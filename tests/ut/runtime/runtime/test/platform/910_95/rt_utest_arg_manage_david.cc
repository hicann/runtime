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
#undef protected
#undef private
#include "runtime.hpp"
#include "event.hpp"
#include "npu_driver.hpp"
#include "api.hpp"
#include "cmodel_driver.h"
#include "thread_local_container.hpp"
#include "task_res.hpp"
#include "task_manager_david.h"

using namespace testing;
using namespace cce::runtime;

class ArgManageUbTest : public testing::Test {
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
        RegDavidTaskFunc();
        std::cout << "ArgManageUbTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(originType_);
        GlobalContainer::SetRtChipType(originType_);
        rtInstance->SetDisableThread(false);
        rtInstance->SetConnectUbFlag(false);
        std::cout << "ArgManageUbTest end" << std::endl;
    }

    virtual void SetUp()
    {
        GlobalMockObject::reset();
        int64_t hardwareVersion = ((ARCH_V100 << 16) | (CHIP_DAVID << 8) | (VER_NA));
        Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetDevInfo)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
            .will(returnValue(RT_ERROR_NONE));
        char *socVer = "Ascend910_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend910_9599")), mockcpp::any())
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
        (void)rtSetSocVersion("Ascend910_9599");
        device_ = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
        device_->SetPlatformType(PLATFORM_DAVID_910_9599);
        engine_ = ((RawDevice *)device_)->engine_;
    }

    virtual void TearDown()
    {
        engine_ = nullptr;
        ((Runtime *)Runtime::Instance())->DeviceRelease(device_);

        Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetRunMode).stubs().will(returnValue((uint32_t)RT_RUN_MODE_OFFLINE));

        rtDeviceReset(0);
        GlobalMockObject::reset();
    }

public:
    Device *device_ = nullptr;
    Engine *engine_ = nullptr;
    static rtChipType_t originType_;
};
rtChipType_t ArgManageUbTest::originType_ = CHIP_DAVID;

TEST_F(ArgManageUbTest, ub_arg_loader_alloc)
{
    Driver *drv = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    rtError_t ret = RT_ERROR_NONE;

    // alloc dev arg loader mem
    uint32_t argsSize = 1024;
    DavidArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX};
    ret = device_->UbArgLoaderPtr()->AllocCopyPtr(argsSize, &result);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    UbHandle *argHandle = static_cast<UbHandle *>(result.handle);
    EXPECT_NE(argHandle, nullptr);
    EXPECT_NE(argHandle->argsAlloc, nullptr);
    ret = device_->UbArgLoaderPtr()->Release(result.handle);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    // alloc dynamic loader mem
    argsSize = 0xFFFFFFFF;
    result = {};
    ret = device_->UbArgLoaderPtr()->AllocCopyPtr(argsSize, &result);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    argHandle = static_cast<UbHandle *>(result.handle);
    EXPECT_NE(argHandle, nullptr);
    EXPECT_EQ(argHandle->argsAlloc, nullptr);

    DavidArgLoaderResult result1 = {nullptr, nullptr, nullptr, UINT32_MAX};
    result1 = {};
    ret = device_->UbArgLoaderPtr()->AllocCopyPtr(argsSize, &result1);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    UbHandle *argHandle1 = static_cast<UbHandle *>(result1.handle);
    EXPECT_NE(argHandle1, nullptr);
    EXPECT_EQ(argHandle1->argsAlloc, nullptr);
    DavidStream *stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);
    ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_NE(stm->ArgManagePtr(), nullptr);
    EXPECT_EQ(stm->isHasArgPool_, false);
    EXPECT_EQ(device_->argStreamNum_, 0);
    ret = stm->ArgManagePtr()->H2DArgCopy(&result, result1.hostAddr, argsSize);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    stm->ReleaseStreamArgRes();
    delete stm;

    ret = device_->UbArgLoaderPtr()->Release(result.handle);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = device_->UbArgLoaderPtr()->Release(result1.handle);
    EXPECT_EQ(ret, RT_ERROR_NONE);

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

    argsSize = 1024;
    result = {};
    // ub_arg_loader_alloc_exception1: handle alloc fail
    ret = device_->UbArgLoaderPtr()->AllocCopyPtr(argsSize, &result);
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
    H2DCopyMgr *argAllocator = new (std::nothrow) H2DCopyMgr(
        device_, 4096, 1024, Runtime::macroValue_.maxSupportTaskNum, BufferAllocator::LINEAR, COPY_POLICY_UB);
    EXPECT_EQ(argAllocator->devAllocator_->allocFuncState_, false);
    delete argAllocator;
    argAllocator = new (std::nothrow) H2DCopyMgr(device_, 4096, 1024, Runtime::macroValue_.maxSupportTaskNum,
                                                 BufferAllocator::LINEAR, COPY_POLICY_UB);
    EXPECT_EQ(argAllocator->devAllocator_->allocFuncState_, false);
    delete argAllocator;
    // free_ub_buffer_exception
    argAllocator = new (std::nothrow) H2DCopyMgr(device_, 4096, 1024, Runtime::macroValue_.maxSupportTaskNum,
                                                 BufferAllocator::LINEAR, COPY_POLICY_UB);
    CpyUbInfo para = {};
    argAllocator->FreeUbBuffer(mem1, &para);
    delete argAllocator;
}

TEST_F(ArgManageUbTest, stream_arg_res_create)
{
    rtError_t ret = RT_ERROR_NONE;
    DavidStream *stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_DEFAULT, nullptr);

    // default stream, alloc DavidArgManage but not alloc argPoolRes
    ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_NE(stm->ArgManagePtr(), nullptr);
    EXPECT_EQ(stm->isHasArgPool_, false);
    EXPECT_EQ(device_->argStreamNum_, 0);
    stm->ReleaseStreamArgRes();

    // Gen Mode, not alloc DavidArgManage, 校验在上层

    // FAST_LAUNCH stream, alloc DavidArgManage and argPoolRes
    stm->flags_ = RT_STREAM_FAST_LAUNCH;
    ret = stm->CreateStreamArgRes();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_NE(stm->ArgManagePtr(), nullptr);
    EXPECT_EQ(stm->isHasArgPool_, true);
    EXPECT_EQ(device_->argStreamNum_, 1);
    stm->ReleaseStreamArgRes();

    delete stm;
}

TEST_F(ArgManageUbTest, stream_arg_res_create_exception)
{
    rtError_t ret = RT_ERROR_NONE;
    DavidStream *stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_FAST_LAUNCH, nullptr);

    // exception1: dev->argStreamNum_ >= DAVID_ARG_STREAM_NUM_MAX
    device_->argStreamNum_ = DAVID_ARG_STREAM_NUM_MAX;
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
    DavidArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX};
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
    uint32_t oldDepth = ((Runtime *)Runtime::Instance())->macroValue_.rtsqDepth;
    ((Runtime *)Runtime::Instance())->macroValue_.rtsqDepth = 2049;

    rtError_t ret = RT_ERROR_NONE;
    DavidStream *stm = new (std::nothrow)
        DavidStream(device_, RT_STREAM_PRIORITY_DEFAULT, RT_STREAM_FAST_LAUNCH, nullptr);
    ret = stm->CreateStreamArgRes();  // size: 2049*1024=2098176
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(stm->isHasArgPool_, true);

    DavidArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX};
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

    ((Runtime *)Runtime::Instance())->macroValue_.rtsqDepth = oldDepth;
}

class ArgManagePcieTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "ArgManagePcieTest SetUP" << std::endl;
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetDisableThread(true);
        originType_ = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        rtInstance->SetConnectUbFlag(false);
        std::cout << "ArgManagePcieTest start" << std::endl;
        GlobalMockObject::verify();
    }

    static void TearDownTestCase()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(originType_);
        GlobalContainer::SetRtChipType(originType_);
        rtInstance->SetDisableThread(false);
        rtInstance->SetConnectUbFlag(false);
        std::cout << "ArgManagePcieTest end" << std::endl;
    }

    virtual void SetUp()
    {
        GlobalMockObject::reset();
        int64_t hardwareVersion = ((ARCH_V100 << 16) | (CHIP_DAVID << 8) | (VER_NA));
        Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetDevInfo)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
            .will(returnValue(RT_ERROR_NONE));
        char *socVer = "Ascend910_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend910_9599")), mockcpp::any())
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
        (void)rtSetSocVersion("Ascend910_9599");
        device_ = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
        device_->SetPlatformType(PLATFORM_DAVID_910_9599);
        engine_ = ((RawDevice *)device_)->engine_;
    }

    virtual void TearDown()
    {
        engine_ = nullptr;
        ((Runtime *)Runtime::Instance())->DeviceRelease(device_);

        Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetRunMode).stubs().will(returnValue((uint32_t)RT_RUN_MODE_OFFLINE));

        rtDeviceReset(0);
        GlobalMockObject::reset();
    }

public:
    Device *device_ = nullptr;
    Engine *engine_ = nullptr;
    static rtChipType_t originType_;
};
rtChipType_t ArgManagePcieTest::originType_ = CHIP_DAVID;

TEST_F(ArgManagePcieTest, stream_arg_res_create)
{
    rtError_t ret = RT_ERROR_NONE;
    DavidStream *stm = new (std::nothrow) DavidStream(device_, 0, RT_STREAM_FAST_LAUNCH, nullptr);

    Driver *drv = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    void *memBase = (void *)100;
    uint32_t val = 1;
    MOCKER_CPP_VIRTUAL(drv, &Driver::CheckSupportPcieBarCopy)
        .stubs()
        .with(mockcpp::any(), outBound(val), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(drv, &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(1))
        .then(returnValue(RT_ERROR_NONE));
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

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

    delete stm;
}