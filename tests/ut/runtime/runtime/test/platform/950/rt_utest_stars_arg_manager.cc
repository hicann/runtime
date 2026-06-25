/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#define private public
#define protected public
#include "kernel.hpp"
#include "program.hpp"
#include "stream_david.hpp"
#include "raw_device.hpp"
#include "uma_arg_loader.hpp"
#include "stream_c.hpp"
#undef protected
#undef private
#include "runtime.hpp"
#include "event.hpp"
#include "npu_driver.hpp"
#include "api.hpp"
#include "cmodel_driver.h"
#include "thread_local_container.hpp"
#include "task_res.hpp"
#include "../../rt_utest_config_define.hpp"
#include "args/args_inner.h"
#include "kernel_utils.hpp"

using namespace testing;
using namespace cce::runtime;
static Driver *SetupPcieBarCopySupportMock()
{
    Driver *drv = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    uint32_t val = 1;
    MOCKER_CPP_VIRTUAL(drv, &Driver::CheckSupportPcieBarCopy)
        .stubs()
        .with(mockcpp::any(), outBound(val), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    return drv;
}

static void SetupDriverMockForPcie()
{
    Driver *drv = SetupPcieBarCopySupportMock();
    // 使用真实可用的静态内存，避免 H2DArgCopy 向假地址写入导致 coredump
    static char realMemBuffer[4096 * 1024];  // 4MB 真实内存
    void *memBase = realMemBuffer;
    MOCKER_CPP_VIRTUAL(drv, &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
}

static void SetupDriverMockForPcieWithAllocFailure()
{
    Driver *drv = SetupPcieBarCopySupportMock();
    // 第一次失败，第二次成功返回真实地址
    static char realMemBuffer[4096 * 1024];
    void *memBase = realMemBuffer;
    MOCKER_CPP_VIRTUAL(drv, &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(1))
        .then(returnValue(RT_ERROR_NONE));
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
}

static void TestLoadArgsFromArrayZeroSizeCommon(DavidStream *stm)
{
    rtError_t ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program *program = &stubProg;
    Kernel kernelMock("test", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);
    kernelMock.SetParamTotalSize(0);

    void *argsArray[2] = {nullptr, nullptr};
    StarsArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX};

    ret = stm->ArgManagePtr()->LoadArgsFromArray(false, &kernelMock, argsArray, &result);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(result.kerArgs, nullptr);
    EXPECT_EQ(result.hostAddr, nullptr);

    stm->ReleaseStreamArgRes();
}

static Kernel* CreateMockKernelWithParams(Program *program)
{
    Kernel *kernelMock = new Kernel("test", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);
    kernelMock->SetParamTotalSize(128);
    
    std::shared_ptr<ElfParamInfo[]> paramInfos(new ElfParamInfo[2]);
    paramInfos[0].info.offset = 0;
    paramInfos[0].info.size = 16;
    paramInfos[1].info.offset = 16;
    paramInfos[1].info.size = 32;
    kernelMock->SetHasParamSummary(true);
    kernelMock->SetParamCount(2);
    kernelMock->SetParamInfos(paramInfos);
    
    return kernelMock;
}

static void TestLoadArgsFromArrayAllocCopyPtrFailCommon(DavidStream *stm, bool needPcieMock)
{
    GlobalMockObject::reset();
    if (needPcieMock) {
        SetupDriverMockForPcie();
    }
    
    rtError_t ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Kernel *kernelMock = CreateMockKernelWithParams(&stubProg);
    
    void *argsArray[2] = {(void *)0x100, (void *)0x200};
    StarsArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX};
    
    if (needPcieMock) {
        PcieArgManage *argManage = static_cast<PcieArgManage*>(stm->ArgManagePtr());
        MOCKER_CPP_VIRTUAL(argManage, &PcieArgManage::AllocCopyPtr)
            .stubs()
            .will(returnValue(RT_ERROR_MEMORY_ALLOCATION));
    } else {
        UbArgManage *argManage = static_cast<UbArgManage*>(stm->ArgManagePtr());
        MOCKER_CPP_VIRTUAL(argManage, &UbArgManage::AllocCopyPtr)
            .stubs()
            .will(returnValue(RT_ERROR_MEMORY_ALLOCATION));
    }
    
    ret = stm->ArgManagePtr()->LoadArgsFromArray(false, kernelMock, argsArray, &result);
    EXPECT_EQ(ret, RT_ERROR_MEMORY_ALLOCATION);
    
    stm->ReleaseStreamArgRes();
    delete kernelMock;
}

namespace {
void MockDriverSetup(Device** deviceOut, Engine** engineOut)
{
    int64_t hardwareVersion = ((ARCH_V100 << 16) | (CHIP_DAVID << 8) | (VER_NA));
    Driver* driver = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(driver, &Driver::GetDevInfo)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
        .will(returnValue(RT_ERROR_NONE));
    char* socVer = "Ascend950PR_9599";
    MOCKER(halGetSocVersion)
        .stubs()
        .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend950PR_9599")), mockcpp::any())
        .will(returnValue(DRV_ERROR_NONE));

    MOCKER_CPP_VIRTUAL(driver, &Driver::StreamBindLogicCq).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::StreamUnBindLogicCq).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::GetRunMode).stubs().will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

    MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqEnable)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(false))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::EnableSq).stubs().will(returnValue(RT_ERROR_NONE));

    rtSetDevice(0);
    (void)rtSetSocVersion("Ascend950PR_9599");
    ((Runtime*)Runtime::Instance())->SetIsUserSetSocVersion(false);
    *deviceOut = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    (*deviceOut)->SetChipType(CHIP_DAVID);
    *engineOut = ((RawDevice*)*deviceOut)->engine_;
}

void MockDriverTeardown(Device** deviceIn, Engine** engineIn)
{
    *engineIn = nullptr;
    ((Runtime*)Runtime::Instance())->DeviceRelease(*deviceIn);
    ((Runtime*)Runtime::Instance())->SetIsUserSetSocVersion(false);

    Driver* driver = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(driver, &Driver::GetRunMode).stubs().will(returnValue((uint32_t)RT_RUN_MODE_OFFLINE));

    rtDeviceReset(0);
    GlobalMockObject::reset();
}
} // namespace

class ArgManageTestBase : public testing::Test {
protected:
    virtual void SetUp()
    {
        GlobalMockObject::reset();
        MockDriverSetup(&device_, &engine_);
    }

    virtual void TearDown()
    {
        MockDriverTeardown(&device_, &engine_);
    }

public:
    Device* device_ = nullptr;
    Engine* engine_ = nullptr;
    static rtChipType_t originType_;
};

class ArgManageUbTest : public ArgManageTestBase {
protected:
    static void SetUpTestCase()
    {
        GlobalMockObject::reset();
        std::cout << "ArgManageUbTest SetUP" << std::endl;
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetDisableThread(true);
        originType_ = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        rtInstance->SetConnectUbFlag(true);
        std::cout << "ArgManageUbTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        GlobalMockObject::reset();  // 清理 mock 状态，避免影响下一个测试套件
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        rtInstance->SetChipType(originType_);
        GlobalContainer::SetRtChipType(originType_);
        rtInstance->SetDisableThread(false);
        rtInstance->SetConnectUbFlag(false);
        std::cout << "ArgManageUbTest end" << std::endl;
    }
};
rtChipType_t ArgManageTestBase::originType_ = CHIP_DAVID;

TEST_F(ArgManageUbTest, ub_arg_loader_alloc_basic)
{
    uint32_t argsSize = 1024;
    StarsArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX};
    rtError_t ret = device_->UbArgLoaderPtr()->AllocCopyPtr(argsSize, &result);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    UbHandle* argHandle = static_cast<UbHandle*>(result.handle);
    EXPECT_NE(argHandle, nullptr);
    EXPECT_NE(argHandle->argsAlloc, nullptr);

    ret = device_->UbArgLoaderPtr()->Release(result.handle);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(ArgManageUbTest, ub_arg_loader_alloc_dynamic)
{
    uint32_t argsSize = 0xFFFFFFFF;
    StarsArgLoaderResult result = {};
    rtError_t ret = device_->UbArgLoaderPtr()->AllocCopyPtr(argsSize, &result);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    UbHandle* argHandle = static_cast<UbHandle*>(result.handle);
    EXPECT_NE(argHandle, nullptr);
    EXPECT_EQ(argHandle->argsAlloc, nullptr);

    StarsArgLoaderResult result1 = {};
    ret = device_->UbArgLoaderPtr()->AllocCopyPtr(argsSize, &result1);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    UbHandle* argHandle1 = static_cast<UbHandle*>(result1.handle);
    EXPECT_NE(argHandle1, nullptr);
    EXPECT_EQ(argHandle1->argsAlloc, nullptr);

    DavidStream *stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_NE(stm->ArgManagePtr(), nullptr);
    EXPECT_EQ(stm->isHasArgPool_, false);
    EXPECT_EQ(device_->argStreamNum_, 1);

    ret = stm->ArgManagePtr()->H2DArgCopy(&result, result1.hostAddr, argsSize);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    stm->ReleaseStreamArgRes();
    delete stm;

    ret = device_->UbArgLoaderPtr()->Release(result.handle);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = device_->UbArgLoaderPtr()->Release(result1.handle);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(ArgManageUbTest, ub_arg_loader_alloc_exception)
{
    Driver* drv = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);

    GlobalMockObject::verify();
    char memBase[2000];
    char memBase1[2000];
    void *mem = memBase;
    void *mem1 = memBase1;
    MOCKER_CPP(&BufferAllocator::AllocItem)
        .stubs()
        .will(returnValue((void *)0))
        .then(returnValue(mem))
        .then(returnValue((void *)0))
        .then(returnValue(mem))
        .then(returnValue(mem1));

    uint32_t argsSize = 1024;
    StarsArgLoaderResult result = {};
    // ub_arg_loader_alloc_exception1: handle alloc fail
    rtError_t ret = device_->UbArgLoaderPtr()->AllocCopyPtr(argsSize, &result);
    EXPECT_EQ(ret, RT_ERROR_MEMORY_ALLOCATION);
    // ub_arg_loader_alloc_exception2: devAddr alloc fail
    ret = device_->UbArgLoaderPtr()->AllocCopyPtr(argsSize, &result);
    EXPECT_EQ(ret, RT_ERROR_MEMORY_ALLOCATION);
    EXPECT_EQ(result.handle, nullptr);
    // ub_arg_loader_alloc_exception3: hostAddr get fail
    ret = device_->UbArgLoaderPtr()->AllocCopyPtr(argsSize, &result);
    EXPECT_EQ(ret, RT_ERROR_MEMORY_ALLOCATION);
    EXPECT_EQ(result.handle, nullptr);

    MOCKER_CPP_VIRTUAL(drv, &Driver::DevMemAlloc)
        .stubs()
        .will(returnValue(RT_ERROR_DRV_OUT_MEMORY))
        .then(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(drv, &Driver::HostMemAlloc)
        .stubs()
        .will(returnValue(RT_ERROR_DRV_MALLOC_FAIL))
        .then(returnValue(RT_ERROR_NONE));

    argsSize = 17000;
    result = {};
    // ub_arg_loader_alloc_exception4: dynamic devAddr malloc fail
    ret = device_->UbArgLoaderPtr()->AllocCopyPtr(argsSize, &result);
    EXPECT_EQ(ret, RT_ERROR_DRV_OUT_MEMORY);
    // ub_arg_loader_alloc_exception5: dynamic hostAddr malloc fail
    ret = device_->UbArgLoaderPtr()->AllocCopyPtr(argsSize, &result);
    EXPECT_EQ(ret, RT_ERROR_DRV_MALLOC_FAIL);
}

TEST_F(ArgManageUbTest, ub_arg_loader_init_exception)
{
    char memBase[2000];
    char memBase1[2000];
    void *mem = memBase;
    void *mem1 = memBase1;

    Driver *drv = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(drv, &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&mem, sizeof(mem)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(1))
        .then(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(drv, &Driver::HostMemAlloc)
        .stubs()
        .with(outBoundP(&mem1, sizeof(mem1)), mockcpp::any())
        .will(returnValue(2))
        .then(returnValue(RT_ERROR_NONE));

    // malloc_ub_buffer_exception
    H2DCopyMgr* argAllocator =
        new (std::nothrow) H2DCopyMgr(device_, 4096, 1024, 2000000U, BufferAllocator::LINEAR, COPY_POLICY_UB);
    EXPECT_EQ(argAllocator->devAllocator_->allocFuncState_, false);
    delete argAllocator;
    argAllocator =
        new (std::nothrow) H2DCopyMgr(device_, 4096, 1024, 2000000U, BufferAllocator::LINEAR, COPY_POLICY_UB);
    EXPECT_EQ(argAllocator->devAllocator_->allocFuncState_, false);
    delete argAllocator;
    // free_ub_buffer_exception
    argAllocator =
        new (std::nothrow) H2DCopyMgr(device_, 4096, 1024, 2000000U, BufferAllocator::LINEAR, COPY_POLICY_UB);
    CpyUbInfo para = {};
    argAllocator->FreeUbBuffer(mem1, &para);
    delete argAllocator;
}

TEST_F(ArgManageUbTest, stream_arg_res_create)
{
    rtError_t ret = RT_ERROR_NONE;
    DavidStream *stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);

    // default stream, alloc StarsArgManager but not alloc argPoolRes
    ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_NE(stm->ArgManagePtr(), nullptr);
    EXPECT_EQ(stm->isHasArgPool_, false);
    EXPECT_EQ(device_->argStreamNum_, 1);
    stm->ReleaseStreamArgRes();

    // Gen Mode, not alloc StarsArgManager, 校验在上层

    // FAST_LAUNCH stream, alloc StarsArgManager and argPoolRes
    stm->flags_ = RT_STREAM_FAST_LAUNCH;
    ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_NE(stm->ArgManagePtr(), nullptr);
    EXPECT_EQ(stm->isHasArgPool_, true);
    EXPECT_EQ(device_->argStreamNum_, 2);
    stm->ReleaseStreamArgRes();

    delete stm;
}

TEST_F(ArgManageUbTest, stream_arg_res_create_exception)
{
    rtError_t ret = RT_ERROR_NONE;
    DavidStream *stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_FAST_LAUNCH, nullptr);

    // exception1: dev->argStreamNum_ >= STARS_ARG_STREAM_NUM_MAX
    device_->argStreamNum_ = STARS_ARG_STREAM_NUM_MAX;
    ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(stm->isHasArgPool_, false);
    stm->ReleaseStreamArgRes();
    device_->argStreamNum_ = 0;

    Driver *drv = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(drv, &Driver::DevMemAlloc).stubs().will(returnValue(1)).then(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(drv, &Driver::HostMemAlloc).stubs().will(returnValue(2)).then(returnValue(RT_ERROR_NONE));

    // exception2: DevMemAlloc fail
    ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(stm->isHasArgPool_, false);
    stm->ReleaseStreamArgRes();
    // exception3: HostMemAlloc fail
    ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(stm->isHasArgPool_, false);
    stm->ReleaseStreamArgRes();

    delete stm;
}

TEST_F(ArgManageUbTest, async_recycle)
{
    rtError_t ret = RT_ERROR_NONE;

    TaskInfo task = {};
    TaskInfo *taskInfo = &task;
    taskInfo->type = TS_TASK_TYPE_KERNEL_AICORE;
    AicTaskInfo *aicTask = &(taskInfo->u.aicTaskInfo);
    UbHandle argHandle = {nullptr, nullptr, nullptr};
    aicTask->comm.argHandle = &argHandle;

    DavidStream *stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    stm->AddArgToRecycleList(taskInfo);
    ret = stm->CreateArgRecycleList(2);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    stm->AddArgToRecycleList(taskInfo);
    stm->AddArgToRecycleList(taskInfo);
    stm->ProcArgRecycleList();
    stm->DestroyArgRecycleList(2);
    stm->ReleaseStreamArgRes();
    delete stm;
}

TEST_F(ArgManageUbTest, persistent_force_copy)
{
    rtError_t ret = RT_ERROR_NONE;
    DavidStream *stm = new (std::nothrow)
        DavidStream(device_, RT_STREAM_PRIORITY_DEFAULT,
                    RT_STREAM_FAST_LAUNCH | RT_STREAM_FORCE_COPY | RT_STREAM_PERSISTENT, nullptr);
    ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(stm->isHasArgPool_, true);
    stm->context_ = ((RawDevice *)device_)->primaryStream_->Context_();

    TaskInfo task = {};
    TaskInfo *taskInfo = &task;
    taskInfo->type = TS_TASK_TYPE_KERNEL_AICORE;
    taskInfo->stream = stm;
    AicTaskInfo *aicTask = &(taskInfo->u.aicTaskInfo);

    char memBase[2000];
    void *mem = memBase;
    aicTask->argsInfo = (rtArgsEx_t *)mem;
    aicTask->argsInfo->argsSize = 24;
    aicTask->argsInfo->hostInputInfoNum = 0;
    aicTask->argsInfo->hasTiling = 0;
    aicTask->argsInfo->isNoNeedH2DCopy = 0;

    Model *mdl = new (std::nothrow) Model();
    stm->SetModel(mdl);
    stm->SetLatestModlId(mdl->Id_());
    mdl->context_ = stm->Context_();

    MOCKER(memcpy_s).stubs().will(returnValue(NULL)).then(returnValue(1)).then(returnValue(NULL));
    StarsArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX};
    ret = stm->LoadArgsInfo(aicTask->argsInfo, true, &result);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(result.handle, nullptr);
    EXPECT_EQ(result.stmArgPos, 24);

    taskInfo->stmArgPos = result.stmArgPos;
    result.stmArgPos = UINT32_MAX;
    result.handle = nullptr;

    TaskUnInitProc(taskInfo);
    EXPECT_EQ(aicTask->comm.argHandle, nullptr);

    ret = stm->LoadArgsInfo(aicTask->argsInfo, true, &result);
    EXPECT_EQ(ret, RT_ERROR_DRV_ERR);
    EXPECT_EQ(result.handle, nullptr);
    EXPECT_EQ(result.stmArgPos, UINT32_MAX);

    stm->DelModel(mdl);
    stm->models_.clear();
    mdl->context_ = nullptr;
    delete mdl;
    stm->ReleaseStreamArgRes();
    delete stm;
}

TEST_F(ArgManageUbTest, stm_arg_pool_alloc)
{
    rtError_t ret = RT_ERROR_NONE;
    DavidStream *stm = new (std::nothrow)
        DavidStream(device_, RT_STREAM_PRIORITY_DEFAULT, RT_STREAM_FAST_LAUNCH, nullptr);
    ret = stm->CreateStreamArgRes();  // size: 2049*1024=2098176
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(stm->isHasArgPool_, true);

    StarsArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX};
    // alloc case1
    bool res = stm->ArgManagePtr()->AllocStmPool(995, &result);  // align 1000
    EXPECT_EQ(res, true);
    EXPECT_EQ(result.stmArgPos, 1000);
    EXPECT_EQ(stm->ArgManagePtr()->GetStmArgPos(), 1000);
    EXPECT_EQ(stm->ArgManagePtr()->stmArgHead_.Value(), 0);

    // recycle exception
    res = stm->ArgManagePtr()->RecycleStmArgPos(0, 1024);
    EXPECT_EQ(res, false);
    EXPECT_EQ(stm->ArgManagePtr()->stmArgHead_.Value(), 0);

    // alloc fail
    res = stm->ArgManagePtr()->AllocStmPool(2097176, &result);  // 边界字节不使用
    EXPECT_EQ(res, false);
    EXPECT_EQ(stm->ArgManagePtr()->GetStmArgPos(), 1000);

    // alloc case1
    res = stm->ArgManagePtr()->AllocStmPool(2097165, &result);  // align 2097168
    EXPECT_EQ(res, true);
    res = stm->ArgManagePtr()->RecycleStmArgPos(0, 1000);
    EXPECT_EQ(res, true);
    EXPECT_EQ(result.stmArgPos, 2098168);
    EXPECT_EQ(stm->ArgManagePtr()->GetStmArgPos(), 2098168);
    EXPECT_EQ(stm->ArgManagePtr()->stmArgHead_.Value(), 1000);

    // alloc_case2
    res = stm->ArgManagePtr()->AllocStmPool(606, &result);  // align 608
    EXPECT_EQ(res, true);
    EXPECT_EQ(result.stmArgPos, 608);
    EXPECT_EQ(stm->ArgManagePtr()->GetStmArgPos(), 608);
    EXPECT_EQ(stm->ArgManagePtr()->stmArgHead_.Value(), 1000);

    // recycle exception
    res = stm->ArgManagePtr()->RecycleStmArgPos(0, 800);
    EXPECT_EQ(res, false);
    EXPECT_EQ(stm->ArgManagePtr()->stmArgHead_.Value(), 1000);

    // alloc_case3
    res = stm->ArgManagePtr()->AllocStmPool(90, &result);  // align 96
    EXPECT_EQ(res, true);
    EXPECT_EQ(result.stmArgPos, 704);
    EXPECT_EQ(stm->ArgManagePtr()->GetStmArgPos(), 704);
    EXPECT_EQ(stm->ArgManagePtr()->stmArgHead_.Value(), 1000);

    stm->ReleaseStreamArgRes();
    delete stm;
}

class ArgManagePcieTest : public ArgManageTestBase {
private:
    static Device* setupDevice_;  // 保存 SetUpTestCase 中创建的 Device

protected:
    static void SetUpTestCase()
    {
        GlobalMockObject::reset();  // 清理之前所有测试套件遗留的 mock 状态
        std::cout << "ArgManagePcieTest SetUP" << std::endl;
        (void)rtDeviceReset(0);
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetDisableThread(true);
        originType_ = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        rtInstance->SetConnectUbFlag(false);  // 必须在 Device 创建前设置
        
        // 重新初始化 Device 的 ArgLoader，确保 argAllocator_ 被创建
        setupDevice_ = rtInstance->DeviceRetain(0, 0);
        if (setupDevice_ != nullptr) {
            ArgLoader* argLoader = setupDevice_->ArgLoader_();
            if (argLoader != nullptr) {
                // 重新初始化 ArgLoader
                (void)argLoader->Init();
            }
        }
        
        std::cout << "ArgManagePcieTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        
        // 释放 SetUpTestCase 中创建的 Device
        if (setupDevice_ != nullptr) {
            rtInstance->DeviceRelease(setupDevice_);
            setupDevice_ = nullptr;
        }
        
        GlobalMockObject::reset();  // 清理 mock 状态，避免影响后续测试套件
        rtInstance->SetChipType(originType_);
        GlobalContainer::SetRtChipType(originType_);
        rtInstance->SetDisableThread(false);
        rtInstance->SetConnectUbFlag(false);
        std::cout << "ArgManagePcieTest end" << std::endl;
    }
};

// 静态成员初始化
Device* ArgManagePcieTest::setupDevice_ = nullptr;

static void ExpectNeedCopyPair(DavidStream* stm, LoadPolicy policy)
{
    EXPECT_EQ(ShouldCopyByPolicy(*stm, 0U, policy), true);
    EXPECT_EQ(ShouldCopyByPolicy(*stm, 1U, policy), false);
}

static void CheckNoMixRuleIgnoresStreamState(DavidStream* stm)
{
    uint32_t savedFlags = stm->flags_;
    stm->flags_ &= ~(RT_STREAM_FORCE_COPY | RT_STREAM_PERSISTENT);
    stm->models_.clear();
    ExpectNeedCopyPair(stm, LoadPolicy::LP_NO_MIX);
    stm->models_.insert(reinterpret_cast<Model*>(0x1));
    ExpectNeedCopyPair(stm, LoadPolicy::LP_NO_MIX);
    stm->flags_ |= (RT_STREAM_FORCE_COPY | RT_STREAM_PERSISTENT);
    ExpectNeedCopyPair(stm, LoadPolicy::LP_NO_MIX);
    stm->models_.clear();
    stm->flags_ = savedFlags;
}

static void CheckMixRuleIgnoresStreamState(DavidStream* stm)
{
    uint32_t savedFlags = stm->flags_;
    stm->flags_ &= ~(RT_STREAM_FORCE_COPY | RT_STREAM_PERSISTENT);
    stm->models_.clear();
    ExpectNeedCopyPair(stm, LoadPolicy::LP_MIX);
    stm->models_.insert(reinterpret_cast<Model*>(0x2));
    ExpectNeedCopyPair(stm, LoadPolicy::LP_MIX);
    stm->models_.clear();
    stm->flags_ = savedFlags;
}

static void CheckNoCopyDefaultPath(Stream* stm, const rtArgsEx_t* argsInfo)
{
    StarsArgLoaderResult resultDefault = {};
    rtError_t ret = stm->LoadArgsInfo(argsInfo, false, &resultDefault, LoadPolicy::LP_GENERIC);
    ASSERT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(resultDefault.kerArgs, argsInfo->args);
    EXPECT_EQ(resultDefault.handle, nullptr);
}

static void CheckNoCopyNoMixPath(Stream* stm, const rtArgsEx_t* argsInfo, StarsArgLoaderResult& outResult)
{
    rtError_t ret = stm->LoadArgsInfo(argsInfo, false, &outResult, LoadPolicy::LP_NO_MIX);
    ASSERT_EQ(ret, RT_ERROR_NONE);
    ASSERT_NE(outResult.handle, nullptr);
    EXPECT_EQ(outResult.kerArgs, argsInfo->args);
    Handle* noMixHandle = static_cast<Handle*>(outResult.handle);
    ASSERT_NE(noMixHandle, nullptr);
    EXPECT_EQ(noMixHandle->freeArgs, false);
}

static void CheckNoCopyMixPath(Stream* stm, const rtArgsEx_t* argsInfo, StarsArgLoaderResult& outResult)
{
    rtError_t ret = stm->LoadArgsInfo(argsInfo, false, &outResult, LoadPolicy::LP_MIX);
    if (ret == RT_ERROR_NONE) {
        ASSERT_NE(outResult.handle, nullptr);
        EXPECT_EQ(outResult.kerArgs, argsInfo->args);
        Handle* mixHandle = static_cast<Handle*>(outResult.handle);
        ASSERT_NE(mixHandle, nullptr);
        EXPECT_EQ(mixHandle->freeArgs, true);
        return;
    }
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(outResult.handle, nullptr);
}

static void CheckNoCopyCpuPath(
    DavidStream* stm, Stream* baseStm, const rtArgsEx_t* argsInfo, StarsArgLoaderResult& outResult)
{
    uint32_t savedFlags = stm->flags_;
    stm->flags_ &= ~(RT_STREAM_FORCE_COPY | RT_STREAM_PERSISTENT);
    rtError_t ret = baseStm->LoadArgsInfo(argsInfo, false, &outResult, LoadPolicy::LP_CPU_KRN);
    ASSERT_EQ(ret, RT_ERROR_NONE);
    ASSERT_NE(outResult.handle, nullptr);
    EXPECT_EQ(outResult.kerArgs, argsInfo->args);
    Handle* cpuHandle = static_cast<Handle*>(outResult.handle);
    ASSERT_NE(cpuHandle, nullptr);
    EXPECT_EQ(cpuHandle->freeArgs, false);
    stm->flags_ = savedFlags;
}

static void ReleaseHandleIfValid(Device* device, void* handle)
{
    if (handle != nullptr) {
        EXPECT_EQ(device->ArgLoader_()->Release(handle), RT_ERROR_NONE);
    }
}

TEST_F(ArgManagePcieTest, stream_arg_res_create)
{
    GlobalMockObject::reset();
    rtError_t ret = RT_ERROR_NONE;
    DavidStream *stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_FAST_LAUNCH, nullptr);

    SetupDriverMockForPcieWithAllocFailure();

    // exception: DevMemAlloc fail
    ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(stm->isHasArgPool_, false);
    stm->ReleaseStreamArgRes();

    ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_NE(stm->ArgManagePtr(), nullptr);
    EXPECT_EQ(stm->isHasArgPool_, true);
    EXPECT_EQ(device_->argStreamNum_, 1);
    stm->ReleaseStreamArgRes();
    EXPECT_EQ(device_->argStreamNum_, 0);

    delete stm;
}

// Tier1-1: ShouldCopyByPolicy 各策略分支覆盖
TEST_F(ArgManageUbTest, should_skip_copy_policy)
{
    DavidStream* stm =
        new(std::nothrow) DavidStream(device_, RT_STREAM_PRIORITY_DEFAULT, RT_STREAM_FAST_LAUNCH, nullptr);
    rtError_t ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ExpectNeedCopyPair(stm, LoadPolicy::LP_GENERIC);
    CheckNoMixRuleIgnoresStreamState(stm);
    CheckMixRuleIgnoresStreamState(stm);

    // LP_CPU_KRN: shouldCopy = NonSupportModelCompile || isNoNeedH2DCopy == 0
    uint32_t origFlags = stm->flags_;
    stm->flags_ &= ~(RT_STREAM_FORCE_COPY | RT_STREAM_PERSISTENT);
    EXPECT_EQ(ShouldCopyByPolicy(*stm, 0U, LoadPolicy::LP_CPU_KRN), true);
    EXPECT_EQ(ShouldCopyByPolicy(*stm, 1U, LoadPolicy::LP_CPU_KRN), false);
    stm->flags_ |= (RT_STREAM_FORCE_COPY | RT_STREAM_PERSISTENT);
    EXPECT_EQ(ShouldCopyByPolicy(*stm, 1U, LoadPolicy::LP_CPU_KRN), true);
    stm->flags_ = origFlags;

    // LP_FFTS: always shouldCopy
    EXPECT_EQ(ShouldCopyByPolicy(*stm, 0U, LoadPolicy::LP_FFTS), true);
    EXPECT_EQ(ShouldCopyByPolicy(*stm, 1U, LoadPolicy::LP_FFTS), true);

    stm->ReleaseStreamArgRes();
    delete stm;
}

// Tier1-2: RecycleStmArgPos early-exit 守卫
TEST_F(ArgManageUbTest, recycle_stm_arg_pos_guard)
{
    DavidStream* stm =
        new(std::nothrow) DavidStream(device_, RT_STREAM_PRIORITY_DEFAULT, RT_STREAM_FAST_LAUNCH, nullptr);
    rtError_t ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    StarsArgManager* mgr = stm->ArgManagePtr();
    ASSERT_NE(mgr, nullptr);

    // stmArgPos == UINT32_MAX → skip, return true
    bool res = mgr->RecycleStmArgPos(0, UINT32_MAX);
    EXPECT_EQ(res, true);
    EXPECT_EQ(mgr->stmArgHead_.Value(), 0);

    stm->ReleaseStreamArgRes();
    delete stm;

    // devArgResBaseAddr_ == nullptr (no CreateArgRes) → skip, return true
    DavidStream* stm2 = new(std::nothrow) DavidStream(device_, RT_STREAM_PRIORITY_DEFAULT, 0, nullptr);
    ret = stm2->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(stm2->isHasArgPool_, false);
    res = stm2->ArgManagePtr()->RecycleStmArgPos(0, 100);
    EXPECT_EQ(res, true);

    stm2->ReleaseStreamArgRes();
    delete stm2;
}

// Tier1-3: ReleaseArgRes argStreamNum 下溢守卫
TEST_F(ArgManageUbTest, release_arg_res_underflow_guard)
{
    DavidStream* stm =
        new(std::nothrow) DavidStream(device_, RT_STREAM_PRIORITY_DEFAULT, RT_STREAM_FAST_LAUNCH, nullptr);
    rtError_t ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint8_t numAfterCreate = device_->argStreamNum_;

    // 正常释放
    stm->ReleaseStreamArgRes();
    uint8_t numAfterRelease = device_->argStreamNum_;
    EXPECT_LE(numAfterRelease, numAfterCreate);

    // 再次创建后模拟 argStreamNum 已被其他路径清零
    ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    device_->argStreamNum_ = 0;
    stm->ReleaseStreamArgRes();
    // 下溢守卫：不应变成 255（uint8 wraparound）
    EXPECT_EQ(device_->argStreamNum_, 0);

    delete stm;
}

// Tier1-4: PCIe AllocStmPool + FreeArgMem 覆盖
static void MockPcieDriverForArgPool(void* memAddr)
{
    uint32_t val = RT_CAPABILITY_SUPPORT;
    Driver* drv = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(drv, &Driver::CheckSupportPcieBarCopy)
        .stubs()
        .with(mockcpp::any(), outBound(val), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(drv, &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memAddr, sizeof(memAddr)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(drv, &Driver::PcieHostRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(drv, &Driver::PcieHostUnRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(drv, &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));
}

TEST_F(ArgManagePcieTest, pcie_stm_arg_pool_alloc)
{
    char memPool[4096];
    void* memAddr = memPool;
    MockPcieDriverForArgPool(memAddr);

    DavidStream* stm =
        new(std::nothrow) DavidStream(device_, RT_STREAM_PRIORITY_DEFAULT, RT_STREAM_FAST_LAUNCH, nullptr);
    Runtime::Instance()->SetConnectUbFlag(false);
    rtError_t ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(stm->isHasArgPool_, true);

    StarsArgManager* mgr = stm->ArgManagePtr();
    ASSERT_NE(mgr, nullptr);

    // alloc success
    StarsArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX};
    bool res = mgr->AllocStmPool(512, &result);
    EXPECT_EQ(res, true);
    EXPECT_NE(result.kerArgs, nullptr);
    EXPECT_NE(result.stmArgPos, UINT32_MAX);

    // recycle
    res = mgr->RecycleStmArgPos(0, result.stmArgPos);
    EXPECT_EQ(res, true);

    // release（覆盖 FreeArgMem：PcieHostUnRegister + DevMemFree）
    stm->ReleaseStreamArgRes();
    delete stm;
}

// ── 公共 helper：创建 PCIe DavidStream 并 mock driver ──
static DavidStream* CreatePcieDavidStream(Device* device)
{
    char* memPool = new(std::nothrow) char[4096];
    void* memAddr = static_cast<void*>(memPool);
    MockPcieDriverForArgPool(memAddr);
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    DavidStream* stm =
        new(std::nothrow) DavidStream(device, RT_STREAM_PRIORITY_DEFAULT, RT_STREAM_FAST_LAUNCH, nullptr);
    Runtime::Instance()->SetConnectUbFlag(false);
    return stm;
}

// Group1: Stream base class virtual methods (OBP Stream)
TEST_F(ArgManagePcieTest, stream_base_virtual_methods)
{
    // Create a plain Stream (not DavidStream) — argManage_ stays nullptr
    Stream* stm = new(std::nothrow) Stream(device_, 0);
    ASSERT_NE(stm, nullptr);

    // GetArgPos default returns UINT32_MAX
    EXPECT_EQ(stm->GetArgPos(), UINT32_MAX);

    // Empty virtual methods — just call to cover
    TaskInfo task = {};
    stm->ArgReleaseSingleTask(&task, false);
    stm->ArgReleaseStmPool(&task);
    stm->ArgReleaseMultipleTask(&task);

    // LoadArgsInfo (rtArgsEx_t) without argManage_ -> result->kerArgs = argsInfo->args
    rtArgsEx_t argsInfo = {};
    uint32_t args[4] = {1, 2, 3, 4};
    argsInfo.args = args;
    argsInfo.argsSize = sizeof(args);
    StarsArgLoaderResult result = {};
    rtError_t ret = stm->LoadArgsInfo(&argsInfo, false, &result, LoadPolicy::LP_GENERIC);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(result.kerArgs, argsInfo.args);

    // LoadArgsInfo (rtAicpuArgsEx_t) without argManage_
    rtAicpuArgsEx_t aicpuArgsInfo = {};
    aicpuArgsInfo.args = args;
    aicpuArgsInfo.argsSize = sizeof(args);
    StarsArgLoaderResult result2 = {};
    ret = stm->LoadArgsInfo(&aicpuArgsInfo, false, &result2, LoadPolicy::LP_GENERIC);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(result2.kerArgs, aicpuArgsInfo.args);

    delete stm;
}

// UmaArgLoader SelectAllocator 各分支覆盖
TEST_F(ArgManagePcieTest, uma_select_allocator)
{
    UmaArgLoader* loader = static_cast<UmaArgLoader*>(device_->ArgLoader_());
    ASSERT_NE(loader, nullptr);
    H2DCopyMgr* alloc = nullptr;

    alloc = loader->SelectAllocator(512, LoadPolicy::LP_MIX);
    EXPECT_EQ(alloc, loader->argPcieBarAllocator_);
    alloc = loader->SelectAllocator(50000, LoadPolicy::LP_NO_MIX);
    EXPECT_EQ(alloc, loader->randomAllocator_);
    alloc = loader->SelectAllocator(512, LoadPolicy::LP_NO_MIX);
    alloc = loader->SelectAllocator(512, LoadPolicy::LP_CPU_KRN);
    EXPECT_EQ(alloc, loader->argAllocator_);
    alloc = loader->SelectAllocator(MULTI_GRAPH_ARG_ENTRY_SIZE + 1, LoadPolicy::LP_CPU_KRN);
    EXPECT_EQ(alloc, loader->superArgAllocator_);
    alloc = loader->SelectAllocator(100000, LoadPolicy::LP_CPU_KRN_EX);
    EXPECT_EQ(alloc, loader->randomAllocator_);
    if (loader->maxArgAllocator_ != nullptr) {
        alloc = loader->SelectAllocator(loader->itemSize_ + 1, LoadPolicy::LP_CPU_KRN_EX);
        EXPECT_EQ(alloc, loader->maxArgAllocator_);
    }
    alloc = loader->SelectAllocator(512, LoadPolicy::LP_CPU_KRN_EX);
    H2DCopyMgr* savedPcie = loader->argPcieBarAllocator_;
    loader->argPcieBarAllocator_ = nullptr;
    alloc = loader->SelectAllocator(512, LoadPolicy::LP_CPU_KRN_EX);
    EXPECT_EQ(alloc, loader->argAllocator_);
    loader->argPcieBarAllocator_ = savedPcie;
    alloc = loader->SelectAllocator(512, LoadPolicy::LP_FFTS);
    alloc = loader->SelectAllocator(512, static_cast<LoadPolicy>(0xFF));
    EXPECT_EQ(alloc, nullptr);
}

// UmaArgLoader NeedPcieRollback + GetEntrySize + CheckPolicyPreCondition
TEST_F(ArgManagePcieTest, uma_helper_methods)
{
    UmaArgLoader* loader = static_cast<UmaArgLoader*>(device_->ArgLoader_());
    ASSERT_NE(loader, nullptr);

    // NeedPcieRollback
    EXPECT_EQ(loader->NeedPcieRollback(LoadPolicy::LP_CPU_KRN, loader->argAllocator_), false);
    if (loader->argPcieBarAllocator_ != nullptr) {
        (void)loader->NeedPcieRollback(LoadPolicy::LP_NO_MIX, loader->argPcieBarAllocator_);
        (void)loader->NeedPcieRollback(LoadPolicy::LP_CPU_KRN_EX, loader->argPcieBarAllocator_);
    }

    // GetEntrySize
    if (loader->argPcieBarAllocator_ != nullptr) {
        EXPECT_EQ(loader->GetEntrySize(loader->argPcieBarAllocator_, 100, false), PCIE_BAR_COPY_SIZE);
    }
    if (loader->superArgAllocator_ != nullptr) {
        EXPECT_EQ(loader->GetEntrySize(loader->superArgAllocator_, 100, false), MULTI_GRAPH_SUPER_ARG_ENTRY_SIZE);
    }
    if (loader->maxArgAllocator_ != nullptr) {
        EXPECT_EQ(loader->GetEntrySize(loader->maxArgAllocator_, 100, false), loader->maxItemSize_);
    }
    EXPECT_EQ(loader->GetEntrySize(reinterpret_cast<H2DCopyMgr*>(0xDEAD), 999, false), 999U);
    EXPECT_EQ(loader->GetEntrySize(loader->argAllocator_, 777, true), 777U);

    // CheckPolicyPreCondition
    EXPECT_EQ(loader->CheckPolicyPreCondition(PCIE_BAR_COPY_SIZE + 1, LoadPolicy::LP_MIX), RT_ERROR_INVALID_VALUE);
    H2DCopyMgr* savedPcie = loader->argPcieBarAllocator_;
    loader->argPcieBarAllocator_ = nullptr;
    EXPECT_EQ(loader->CheckPolicyPreCondition(512, LoadPolicy::LP_MIX), RT_ERROR_INVALID_VALUE);
    loader->argPcieBarAllocator_ = savedPcie;
    EXPECT_EQ(
        loader->CheckPolicyPreCondition(ARG_ENTRY_INCRETMENT_SIZE + ARG_ENTRY_SIZE + 1, LoadPolicy::LP_FFTS),
        RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(loader->CheckPolicyPreCondition(512, LoadPolicy::LP_GENERIC), RT_ERROR_NONE);
}

// PcieArgManage AllocCopyPtr 各路径
TEST_F(ArgManagePcieTest, pcie_alloc_copy_ptr_paths)
{
    DavidStream* stm = CreatePcieDavidStream(device_);
    rtError_t ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    PcieArgManage* pcieMgr = static_cast<PcieArgManage*>(stm->argManage_);
    ASSERT_NE(pcieMgr, nullptr);

    // LP_NO_MIX no-copy → AllocNoCopyPtr
    StarsArgLoaderResult r2 = {};
    r2.kerArgs = &r2;
    EXPECT_EQ(pcieMgr->AllocNoCopyPtr(&r2), RT_ERROR_NONE);

    // LP_NO_MIX need-copy → AllocCopyPtrWithPolicy
    StarsArgLoaderResult r3 = {};
    ret = pcieMgr->AllocCopyPtr(512, false, LoadPolicy::LP_NO_MIX, &r3);
    EXPECT_TRUE(ret == RT_ERROR_NONE || ret == RT_ERROR_MEMORY_ALLOCATION);

    stm->ReleaseStreamArgRes();
    delete stm;
}

// UbArgManage AllocCopyPtr 基线路径
TEST_F(ArgManageUbTest, ub_alloc_copy_ptr_no_copy)
{
    DavidStream* stm =
        new(std::nothrow) DavidStream(device_, RT_STREAM_PRIORITY_DEFAULT, RT_STREAM_FAST_LAUNCH, nullptr);
    rtError_t ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    UbArgManage* ubMgr = static_cast<UbArgManage*>(stm->argManage_);
    ASSERT_NE(ubMgr, nullptr);
    StarsArgLoaderResult result = {};
    EXPECT_EQ(ubMgr->AllocCopyPtr(100, false, LoadPolicy::LP_GENERIC, &result), RT_ERROR_NONE);
    stm->ReleaseStreamArgRes();
    delete stm;
}

TEST_F(ArgManagePcieTest, load_args_no_copy_handle_semantics)
{
    DavidStream* stm = CreatePcieDavidStream(device_);
    rtError_t ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    Stream* baseStm = static_cast<Stream*>(stm);
    rtArgsEx_t argsInfo = {};
    uint32_t args[4] = {0};
    argsInfo.args = args;
    argsInfo.argsSize = 64;
    argsInfo.isNoNeedH2DCopy = 1U;

    CheckNoCopyDefaultPath(baseStm, &argsInfo);
    StarsArgLoaderResult resultNoMix = {};
    CheckNoCopyNoMixPath(baseStm, &argsInfo, resultNoMix);

    StarsArgLoaderResult resultMix = {};
    CheckNoCopyMixPath(baseStm, &argsInfo, resultMix);

    StarsArgLoaderResult resultCpu = {};
    CheckNoCopyCpuPath(stm, baseStm, &argsInfo, resultCpu);

    ReleaseHandleIfValid(device_, resultNoMix.handle);
    ReleaseHandleIfValid(device_, resultMix.handle);
    ReleaseHandleIfValid(device_, resultCpu.handle);

    stm->ReleaseStreamArgRes();
    delete stm;
}

// LoadArgsInfo with LP_MIX
TEST_F(ArgManagePcieTest, load_args_mix_krn_path)
{
    DavidStream* stm = CreatePcieDavidStream(device_);
    rtError_t ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtArgsEx_t argsInfo = {};
    uint32_t args[4] = {0};
    argsInfo.args = args;
    argsInfo.argsSize = 64;
    argsInfo.isNoNeedH2DCopy = 1U;
    StarsArgLoaderResult result = {};
    Stream* baseStm = static_cast<Stream*>(stm);
    ret = baseStm->LoadArgsInfo(&argsInfo, false, &result, LoadPolicy::LP_MIX);
    EXPECT_TRUE(ret == RT_ERROR_NONE || ret == RT_ERROR_INVALID_VALUE);

    argsInfo.isNoNeedH2DCopy = 0U;
    StarsArgLoaderResult result2 = {};
    ret = baseStm->LoadArgsInfo(&argsInfo, false, &result2, LoadPolicy::LP_MIX);
    EXPECT_TRUE(ret == RT_ERROR_NONE || ret == RT_ERROR_INVALID_VALUE || ret == RT_ERROR_MEMORY_ALLOCATION);

    stm->ReleaseStreamArgRes();
    delete stm;
}

// StreamLaunchKernelRecycleAicpu 覆盖
TEST_F(ArgManagePcieTest, stream_launch_kernel_recycle_aicpu)
{
    DavidStream* stm = CreatePcieDavidStream(device_);
    rtError_t ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    // case1: nullptr task
    StarsArgLoaderResult r1 = {};
    TaskInfo* t1 = nullptr;
    StreamLaunchKernelRecycleAicpu(r1, t1, nullptr, stm);
    EXPECT_EQ(t1, nullptr);

    // case2: AICPU task
    TaskInfo aicpuTask = {};
    aicpuTask.type = TS_TASK_TYPE_KERNEL_AICPU;
    aicpuTask.isUpdateSinkSqe = 0U;
    aicpuTask.u.aicpuTaskInfo.kernel = nullptr;
    aicpuTask.u.aicpuTaskInfo.comm.argHandle = nullptr;
    TaskInfo* t2 = &aicpuTask;
    StarsArgLoaderResult r2 = {};
    StreamLaunchKernelRecycleAicpu(r2, t2, nullptr, stm);
    EXPECT_EQ(t2, nullptr);

    // case3: non-AICPU task
    TaskInfo aicTask = {};
    aicTask.type = TS_TASK_TYPE_KERNEL_AICORE;
    aicTask.isUpdateSinkSqe = 0U;
    aicTask.u.aicTaskInfo.comm.argHandle = nullptr;
    TaskInfo* t3 = &aicTask;
    StarsArgLoaderResult r3 = {};
    StreamLaunchKernelRecycleAicpu(r3, t3, nullptr, stm);
    EXPECT_EQ(t3, nullptr);

    stm->ReleaseStreamArgRes();
    delete stm;
}

// LoadArgsInfo with LP_FFTS
TEST_F(ArgManagePcieTest, load_args_ffts_path)
{
    DavidStream* stm = CreatePcieDavidStream(device_);
    rtError_t ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtArgsEx_t argsInfo = {};
    uint32_t args[4] = {0};
    argsInfo.args = args;
    argsInfo.argsSize = 64;
    StarsArgLoaderResult result = {};
    Stream* baseStm = static_cast<Stream*>(stm);
    ret = baseStm->LoadArgsInfo(&argsInfo, false, &result, LoadPolicy::LP_FFTS);
    EXPECT_TRUE(ret == RT_ERROR_NONE || ret == RT_ERROR_MEMORY_ALLOCATION || ret == RT_ERROR_INVALID_VALUE);

    stm->ReleaseStreamArgRes();
    delete stm;
}

TEST_F(ArgManageUbTest, UbArgManage_LoadArgsFromArray_ZeroSize)
{
    DavidStream *stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    TestLoadArgsFromArrayZeroSizeCommon(stm);
    delete stm;
}

TEST_F(ArgManagePcieTest, PcieArgManage_LoadArgsFromArray_ZeroSize)
{
    GlobalMockObject::reset();
    DavidStream *stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    SetupDriverMockForPcie();
    TestLoadArgsFromArrayZeroSizeCommon(stm);
    delete stm;
}

TEST_F(ArgManagePcieTest, PcieArgManage_LoadArgsFromArray_AllocCopyPtrFail)
{
    DavidStream *stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    TestLoadArgsFromArrayAllocCopyPtrFailCommon(stm, true);
    delete stm;
}

TEST_F(ArgManageUbTest, UbArgManage_LoadArgsFromArray_AllocCopyPtrFail)
{
    DavidStream *stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    TestLoadArgsFromArrayAllocCopyPtrFailCommon(stm, false);
    delete stm;
}
static void TestLoadSimtArgsFromArraySuccessCommon(DavidStream* stm, bool needPcieMock)
{
    // 清理之前测试遗留的 mock 状态
    GlobalMockObject::reset();

    if (needPcieMock) {
        SetupDriverMockForPcie();
    }

    rtError_t ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Kernel* kernelMock = CreateMockKernelWithParams(&stubProg);

    SimtArgsArray simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {1, 1, 1};
    // 使用真实内存地址，避免 coredump
    char realArgs1[64] = {0};
    char realArgs2[64] = {0};
    void* argsArray[2] = {realArgs1, realArgs2};
    simtArgs.argsArrayInfo = argsArray;

    StarsArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX};

    // 不需要 mock CopyKernelParamsToBuffer，使用真实内存

    ret = stm->ArgManagePtr()->LoadSimtArgsFromArray(false, kernelMock, &simtArgs, &result);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    stm->ReleaseStreamArgRes();
    delete kernelMock;
}

TEST_F(ArgManagePcieTest, PcieArgManage_LoadSimtArgsFromArray_Success)
{
    DavidStream* stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    TestLoadSimtArgsFromArraySuccessCommon(stm, true);
    delete stm;
}

TEST_F(ArgManageUbTest, UbArgManage_LoadSimtArgsFromArray_Success)
{
    DavidStream* stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    TestLoadSimtArgsFromArraySuccessCommon(stm, false);
    delete stm;
}

static void TestLoadSimtArgsFromArrayAllocCopyPtrFailCommon(DavidStream* stm, bool needPcieMock)
{
    GlobalMockObject::reset();
    if (needPcieMock) {
        SetupDriverMockForPcie();
    }

    rtError_t ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Kernel* kernelMock = CreateMockKernelWithParams(&stubProg);

    SimtArgsArray simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {1, 1, 1};
    void* argsArray[2] = {(void*)0x100, (void*)0x200};
    simtArgs.argsArrayInfo = argsArray;

    StarsArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX};

    if (needPcieMock) {
        PcieArgManage* argManage = static_cast<PcieArgManage*>(stm->ArgManagePtr());
        MOCKER_CPP_VIRTUAL(argManage, &PcieArgManage::AllocCopyPtr)
            .stubs()
            .will(returnValue(RT_ERROR_MEMORY_ALLOCATION));
    } else {
        UbArgManage* argManage = static_cast<UbArgManage*>(stm->ArgManagePtr());
        MOCKER_CPP_VIRTUAL(argManage, &UbArgManage::AllocCopyPtr).stubs().will(returnValue(RT_ERROR_MEMORY_ALLOCATION));
    }

    ret = stm->ArgManagePtr()->LoadSimtArgsFromArray(false, kernelMock, &simtArgs, &result);
    EXPECT_EQ(ret, RT_ERROR_MEMORY_ALLOCATION);

    stm->ReleaseStreamArgRes();
    delete kernelMock;
}

TEST_F(ArgManagePcieTest, PcieArgManage_LoadSimtArgsFromArray_AllocCopyPtrFail)
{
    DavidStream* stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    TestLoadSimtArgsFromArrayAllocCopyPtrFailCommon(stm, true);
    delete stm;
}

TEST_F(ArgManageUbTest, UbArgManage_LoadSimtArgsFromArray_AllocCopyPtrFail)
{
    DavidStream* stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    TestLoadSimtArgsFromArrayAllocCopyPtrFailCommon(stm, false);
    delete stm;
}

static void TestLoadSimtArgsFromArrayMemcpyFailCommon(DavidStream* stm, bool needPcieMock)
{
    if (needPcieMock) {
        // PCIe 需要 mock Driver::DevMemAlloc，但不 mock memcpy_s（让后面单独设置）
        Driver *drv = SetupPcieBarCopySupportMock();
        void *memBase = (void *)100;
        MOCKER_CPP_VIRTUAL(drv, &Driver::DevMemAlloc)
            .stubs()
            .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
            .will(returnValue(RT_ERROR_NONE));
    }

    rtError_t ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Kernel* kernelMock = CreateMockKernelWithParams(&stubProg);

    SimtArgsArray simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {1, 1, 1};
    void* argsArray[2] = {(void*)0x100, (void*)0x200};
    simtArgs.argsArrayInfo = argsArray;

    StarsArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX};

    // PCIe 第一次 memcpy_s 在 PrepareSimtArgsBuffer 中，期望失败
    MOCKER(memcpy_s).stubs().will(returnValue(1));

    ret = stm->ArgManagePtr()->LoadSimtArgsFromArray(false, kernelMock, &simtArgs, &result);
    EXPECT_EQ(ret, RT_ERROR_SEC_HANDLE);

    stm->ReleaseStreamArgRes();
    delete kernelMock;
}

TEST_F(ArgManagePcieTest, PcieArgManage_LoadSimtArgsFromArray_MemcpyFail)
{
    DavidStream* stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    TestLoadSimtArgsFromArrayMemcpyFailCommon(stm, true);
    delete stm;
}

TEST_F(ArgManageUbTest, UbArgManage_LoadSimtArgsFromArray_MemcpyFail)
{
    DavidStream* stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    TestLoadSimtArgsFromArrayMemcpyFailCommon(stm, false);
    delete stm;
}

static void TestLoadSimtArgsFromArrayCopyKernelParamsFailCommon(DavidStream* stm, bool needPcieMock)
{
    GlobalMockObject::reset();
    if (needPcieMock) {
        SetupDriverMockForPcie();
    }

    rtError_t ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Kernel* kernelMock = CreateMockKernelWithParams(&stubProg);

    SimtArgsArray simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {1, 1, 1};
    void* argsArray[2] = {(void*)0x100, (void*)0x200};
    simtArgs.argsArrayInfo = argsArray;

    StarsArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX};

    // 对于失败路径，使用假地址 + mock
    MOCKER(CopyKernelParamsToBuffer).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    ret = stm->ArgManagePtr()->LoadSimtArgsFromArray(false, kernelMock, &simtArgs, &result);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);

    stm->ReleaseStreamArgRes();
    delete kernelMock;
}

TEST_F(ArgManagePcieTest, PcieArgManage_LoadSimtArgsFromArray_CopyKernelParamsFail)
{
    DavidStream* stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    TestLoadSimtArgsFromArrayCopyKernelParamsFailCommon(stm, true);
    delete stm;
}

TEST_F(ArgManageUbTest, UbArgManage_LoadSimtArgsFromArray_CopyKernelParamsFail)
{
    DavidStream* stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    TestLoadSimtArgsFromArrayCopyKernelParamsFailCommon(stm, false);
    delete stm;
}

// PCIe LoadSimtHostArgs tests

static void TestLoadSimtHostArgsSuccessNoPlaceHolderCommon(DavidStream* stm, bool needPcieMock)
{
    GlobalMockObject::reset();
    if (needPcieMock) {
        SetupDriverMockForPcie();
    }

    rtError_t ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    SimtArgsHost simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {1, 1, 1};
    char hostArgs[128] = {0};
    simtArgs.hostArgs = hostArgs;
    simtArgs.argsSize = 128;
    simtArgs.placeHolderArray = nullptr;
    simtArgs.placeHolderNum = 0;

    StarsArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX};

    ret = stm->ArgManagePtr()->LoadSimtHostArgs(false, &simtArgs, &result);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    stm->ReleaseStreamArgRes();
}

TEST_F(ArgManagePcieTest, PcieArgManage_LoadSimtHostArgs_SuccessNoPlaceHolder)
{
    DavidStream* stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    TestLoadSimtHostArgsSuccessNoPlaceHolderCommon(stm, true);
    delete stm;
}

TEST_F(ArgManageUbTest, UbArgManage_LoadSimtHostArgs_SuccessNoPlaceHolder)
{
    DavidStream* stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    TestLoadSimtHostArgsSuccessNoPlaceHolderCommon(stm, false);
    delete stm;
}

static void TestLoadSimtHostArgsSuccessWithPlaceHolderCommon(DavidStream* stm, bool needPcieMock)
{
    GlobalMockObject::reset();
    if (needPcieMock) {
        SetupDriverMockForPcie();
    }

    rtError_t ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    SimtArgsHost simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {1, 1, 1};
    char hostArgs[128] = {0};
    simtArgs.hostArgs = hostArgs;
    simtArgs.argsSize = 128;

    rtPlaceHolderInfo_t placeHolders[2];
    placeHolders[0].addrOffset = 10;
    placeHolders[0].dataOffset = 20;
    placeHolders[1].addrOffset = 30;
    placeHolders[1].dataOffset = 40;
    simtArgs.placeHolderArray = placeHolders;
    simtArgs.placeHolderNum = 2;

    StarsArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX};

    ret = stm->ArgManagePtr()->LoadSimtHostArgs(false, &simtArgs, &result);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    stm->ReleaseStreamArgRes();
}

TEST_F(ArgManagePcieTest, PcieArgManage_LoadSimtHostArgs_SuccessWithPlaceHolder)
{
    DavidStream* stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    TestLoadSimtHostArgsSuccessWithPlaceHolderCommon(stm, true);
    delete stm;
}

TEST_F(ArgManageUbTest, UbArgManage_LoadSimtHostArgs_SuccessWithPlaceHolder)
{
    DavidStream* stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    TestLoadSimtHostArgsSuccessWithPlaceHolderCommon(stm, false);
    delete stm;
}

static void TestLoadSimtHostArgsAllocCopyPtrFailCommon(DavidStream* stm, bool needPcieMock)
{
    GlobalMockObject::reset();
    if (needPcieMock) {
        SetupDriverMockForPcie();
    }

    rtError_t ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    SimtArgsHost simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {1, 1, 1};
    char hostArgs[128] = {0};
    simtArgs.hostArgs = hostArgs;
    simtArgs.argsSize = 128;
    simtArgs.placeHolderArray = nullptr;
    simtArgs.placeHolderNum = 0;

    StarsArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX};

    if (needPcieMock) {
        PcieArgManage* argManage = static_cast<PcieArgManage*>(stm->ArgManagePtr());
        MOCKER_CPP_VIRTUAL(argManage, &PcieArgManage::AllocCopyPtr)
            .stubs()
            .will(returnValue(RT_ERROR_MEMORY_ALLOCATION));
    } else {
        UbArgManage* argManage = static_cast<UbArgManage*>(stm->ArgManagePtr());
        MOCKER_CPP_VIRTUAL(argManage, &UbArgManage::AllocCopyPtr).stubs().will(returnValue(RT_ERROR_MEMORY_ALLOCATION));
    }

    ret = stm->ArgManagePtr()->LoadSimtHostArgs(false, &simtArgs, &result);
    EXPECT_EQ(ret, RT_ERROR_MEMORY_ALLOCATION);

    stm->ReleaseStreamArgRes();
}

TEST_F(ArgManagePcieTest, PcieArgManage_LoadSimtHostArgs_AllocCopyPtrFail)
{
    DavidStream* stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    TestLoadSimtHostArgsAllocCopyPtrFailCommon(stm, true);
    delete stm;
}

TEST_F(ArgManageUbTest, UbArgManage_LoadSimtHostArgs_AllocCopyPtrFail)
{
    DavidStream* stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    TestLoadSimtHostArgsAllocCopyPtrFailCommon(stm, false);
    delete stm;
}

static void TestLoadSimtHostArgsMemcpyImplicitFailCommon(DavidStream* stm, bool needPcieMock)
{
    GlobalMockObject::reset();
    if (needPcieMock) {
        Driver *drv = SetupPcieBarCopySupportMock();
        void *memBase = (void *)100;
        MOCKER_CPP_VIRTUAL(drv, &Driver::DevMemAlloc)
            .stubs()
            .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
            .will(returnValue(RT_ERROR_NONE));
    }

    rtError_t ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    SimtArgsHost simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {1, 1, 1};
    char hostArgs[128] = {0};
    simtArgs.hostArgs = hostArgs;
    simtArgs.argsSize = 128;
    simtArgs.placeHolderArray = nullptr;
    simtArgs.placeHolderNum = 0;

    StarsArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX};

    MOCKER(memcpy_s).stubs().will(returnValue(1));

    ret = stm->ArgManagePtr()->LoadSimtHostArgs(false, &simtArgs, &result);
    EXPECT_EQ(ret, RT_ERROR_SEC_HANDLE);

    stm->ReleaseStreamArgRes();
}

TEST_F(ArgManagePcieTest, PcieArgManage_LoadSimtHostArgs_MemcpyImplicitFail)
{
    DavidStream* stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    TestLoadSimtHostArgsMemcpyImplicitFailCommon(stm, true);
    delete stm;
}

TEST_F(ArgManageUbTest, UbArgManage_LoadSimtHostArgs_MemcpyImplicitFail)
{
    DavidStream* stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    TestLoadSimtHostArgsMemcpyImplicitFailCommon(stm, false);
    delete stm;
}

static void TestLoadSimtHostArgsMemcpyHostArgsFailCommon(DavidStream* stm, bool needPcieMock)
{
    GlobalMockObject::reset();
    if (needPcieMock) {
        Driver *drv = SetupPcieBarCopySupportMock();
        void *memBase = (void *)100;
        MOCKER_CPP_VIRTUAL(drv, &Driver::DevMemAlloc)
            .stubs()
            .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
            .will(returnValue(RT_ERROR_NONE));
    }

    rtError_t ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    SimtArgsHost simtArgs = {};
    simtArgs.gridDim = {1, 1, 1};
    simtArgs.blockDim = {1, 1, 1};
    char hostArgs[128] = {0};
    simtArgs.hostArgs = hostArgs;
    simtArgs.argsSize = 128;
    simtArgs.placeHolderArray = nullptr;
    simtArgs.placeHolderNum = 0;

    StarsArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX};

    // 第一次 memcpy_s 成功（implicit data），第二次失败（host args）
    MOCKER(memcpy_s).stubs().will(returnValue(EOK)).then(returnValue(1));

    ret = stm->ArgManagePtr()->LoadSimtHostArgs(false, &simtArgs, &result);
    EXPECT_EQ(ret, RT_ERROR_SEC_HANDLE);

    stm->ReleaseStreamArgRes();
}

TEST_F(ArgManagePcieTest, PcieArgManage_LoadSimtHostArgs_MemcpyHostArgsFail)
{
    DavidStream* stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    TestLoadSimtHostArgsMemcpyHostArgsFailCommon(stm, true);
    delete stm;
}

TEST_F(ArgManageUbTest, UbArgManage_LoadSimtHostArgs_MemcpyHostArgsFail)
{
    DavidStream* stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    TestLoadSimtHostArgsMemcpyHostArgsFailCommon(stm, false);
    delete stm;
}
