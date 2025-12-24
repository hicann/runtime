/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "driver/ascend_hal.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "model.hpp"
#include "device.hpp"
#include "raw_device.hpp"
#include "module.hpp"
#include "notify.hpp"
#include "event.hpp"
#include "task_info.hpp"
#include "task_info.h"
#include "device/device_error_proc.hpp"
#include "program.hpp"
#include "uma_arg_loader.hpp"
#include "npu_driver.hpp"
#include "ctrl_res_pool.hpp"
#include "stream_sqcq_manage.hpp"
#include "davinci_kernel_task.h"
#include <fstream>
#include "tsch_defines.h"
#include "utils.h"
#include <functional>
#include "npu_driver_dcache_lock.hpp"
#include "thread_local_container.hpp"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

class CloudV2DcacheDeviceTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {}

    static void TearDownTestCase()
    {}

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
private:
    rtChipType_t oldChipType;
};

TEST_F(CloudV2DcacheDeviceTest, GetDriverPath_01)
{
    std::string driverPath;
    auto ret = GetDriverPath(driverPath);
    EXPECT_EQ(ret, false);
}

TEST_F(CloudV2DcacheDeviceTest, GetDriverPath_02)
{
    std::string driverPath;
    MOCKER_CPP(&ifstream::is_open, bool(ifstream::*)()).stubs().will(returnValue(true));
    auto ret = GetDriverPath(driverPath);
    EXPECT_EQ(ret, false);
}

TEST_F(CloudV2DcacheDeviceTest, AllocStackPhyBaseForCloudV2_01)
{
    MOCKER_CPP(&RawDevice::AllocStackPhyAddrForDcache).stubs().will(returnValue(RT_ERROR_NONE));
    RawDevice *dev = new RawDevice(1);
    auto ret = dev->AllocStackPhyBaseForCloudV2();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete dev;
}

TEST_F(CloudV2DcacheDeviceTest, AllocStackPhyBaseForCloudV2_02)
{
    MOCKER_CPP(&RawDevice::AllocStackPhyAddrForDcache).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    RawDevice *dev = new RawDevice(1);
    int32_t temp = 0;
    Driver *driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    dev->driver_ = driver_;
    // dev->stackPhyBase16k_ = &temp;
    auto ret = dev->AllocStackPhyBaseForCloudV2();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    dev->FreeStackPhyBase();
    dev->driver_ = nullptr;
    delete dev;
}

TEST_F(CloudV2DcacheDeviceTest, AllocStackPhyAddrForDcache_01)
{
    MOCKER(AllocAddrForDcache).stubs().will(returnValue(RT_ERROR_NONE));
    RawDevice *dev = new RawDevice(1);
    int32_t temp = 0;
    dev->stackPhyBase32k_ = &temp;
    Driver *driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    dev->driver_ = driver_;
    rtError_t ret = dev->AllocStackPhyAddrForDcache();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    dev->FreeStackPhyBase();
    dev->driver_ = nullptr;
    delete dev;
}

TEST_F(CloudV2DcacheDeviceTest, AllocStackPhyAddrForDcache_02)
{
    RawDevice *dev = new RawDevice(1);
    dev->stackAddrIsDcache_ = true;
    rtError_t ret = dev->AllocStackPhyAddrForDcache();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    dev->FreeStackPhyBase();
    delete dev;
}

TEST_F(CloudV2DcacheDeviceTest, AllocStackPhyAddrForDcache_03)
{
    RawDevice *dev = new RawDevice(1);
    MOCKER(AllocAddrForDcache).stubs().will(returnValue(RT_ERROR_DCACHE_MEM_ALLOC_FAIL));
    rtError_t ret = dev->AllocStackPhyAddrForDcache();
    EXPECT_EQ(ret, RT_ERROR_DCACHE_MEM_ALLOC_FAIL);
    delete dev;
}

TEST_F(CloudV2DcacheDeviceTest, AllocStackPhyAddrForDcache_04)
{
    RawDevice *dev = new RawDevice(1);
    MOCKER(AllocAddrForDcache).stubs().will(returnValue(RT_ERROR_NONE));
    int32_t temp = 0;
    dev->stackPhyBase16k_ = &temp;
    rtError_t ret = dev->AllocStackPhyAddrForDcache();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete dev;
}

TEST_F(CloudV2DcacheDeviceTest, AllocStackPhyAddrForDcache_05)
{
    RawDevice *dev = new RawDevice(1);
    dev->InitRawDriver();
    MOCKER(AllocAddrForDcache).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    rtError_t ret = dev->AllocStackPhyAddrForDcache();
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    delete dev;
}

TEST_F(CloudV2DcacheDeviceTest, AllocStackPhyAddrForDcache_06)
{
    RawDevice *dev = new RawDevice(1);
    dev->InitRawDriver();
    MOCKER(AllocAddrForDcache).stubs().will(returnValue(RT_ERROR_NONE));
    uint32_t tmp = 0;
    void *addr = &tmp;
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&addr, sizeof(void *)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    rtError_t ret = dev->AllocStackPhyAddrForDcache();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete dev;
}

TEST_F(CloudV2DcacheDeviceTest, FreeStackPhyBase_01)
{
    RawDevice *dev = new RawDevice(1);
    dev->InitRawDriver();
    int32_t temp = 0;
    dev->stackPhyBase32k_ = &temp;
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));
    dev->FreeStackPhyBase();
    EXPECT_EQ(dev->stackPhyBase32k_, nullptr);
    delete dev;
}

TEST_F(CloudV2DcacheDeviceTest, FreeStackPhyBase_02)
{
    RawDevice *dev = new RawDevice(1);
    dev->InitRawDriver();
    int32_t temp = 0;
    dev->stackPhyBase32k_ = &temp;
    dev->stackAddrIsDcache_ = true;
    MOCKER(FreeDcacheAddr).stubs();
    dev->FreeStackPhyBase();
    EXPECT_EQ(dev->stackPhyBase32k_, nullptr);
    EXPECT_EQ(dev->stackAddrIsDcache_, false);
    delete dev;
}

TEST_F(CloudV2DcacheDeviceTest, FreeStackPhyBase_03)
{
    RawDevice *dev = new RawDevice(1);
    dev->InitRawDriver();
    int32_t temp = 0;
    dev->stackPhyBase32k_ = &temp;
    dev->stackPhyBase16k_ = &temp;
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));
    dev->FreeStackPhyBase();
    EXPECT_EQ(dev->stackPhyBase32k_, nullptr);
    EXPECT_EQ(dev->stackPhyBase16k_, nullptr);
    delete dev;
}

TEST_F(CloudV2DcacheDeviceTest, LaunchDcacheLockOp_01)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = new RawDevice(1);
    dev->Init();
    MOCKER_CPP_VIRTUAL(dev, &RawDevice::CheckFeatureSupport).stubs().will(returnValue(true));
    Context *ctx = nullptr;
    dev->dCacheLockFlag_ = true;
    rtError_t ret = dev->RegisterAndLaunchDcacheLockOp(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete dev;
}

TEST_F(CloudV2DcacheDeviceTest, LaunchDcacheLockOp_02)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = new RawDevice(1);
    dev->Init();
    MOCKER_CPP_VIRTUAL(dev, &RawDevice::CheckFeatureSupport).stubs().will(returnValue(true));
    MOCKER(QueryDcacheLockStatus).stubs().will(returnValue(RT_ERROR_DRV_NO_DEVICE));
    Context *ctx = nullptr;
    dev->stackAddrIsDcache_ = true;
    rtError_t ret = dev->RegisterAndLaunchDcacheLockOp(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete dev;
}

TEST_F(CloudV2DcacheDeviceTest, LaunchDcacheLockOp_03)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = new RawDevice(1);
    dev->Init();
    MOCKER_CPP_VIRTUAL(dev, &RawDevice::CheckFeatureSupport).stubs().will(returnValue(true));
    MOCKER(QueryDcacheLockStatus).stubs().will(returnValue(RT_ERROR_NONE));
    Context *ctx = nullptr;
    dev->stackAddrIsDcache_ = true;
    rtError_t ret = dev->RegisterAndLaunchDcacheLockOp(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete dev;
}

TEST_F(CloudV2DcacheDeviceTest, LaunchDcacheLockOp_04)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = new RawDevice(1);
    dev->Init();
    MOCKER_CPP_VIRTUAL(dev, &RawDevice::CheckFeatureSupport).stubs().will(returnValue(true));
    MOCKER(QueryDcacheLockStatus).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(true)).will(returnValue(RT_ERROR_NONE));
    Context *ctx = nullptr;
    dev->stackAddrIsDcache_ = true;
    rtError_t ret = dev->RegisterAndLaunchDcacheLockOp(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete dev;
}

TEST_F(CloudV2DcacheDeviceTest, LaunchDcacheLockOp_05)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = new RawDevice(1);
    dev->Init();
    MOCKER_CPP_VIRTUAL(dev, &RawDevice::CheckFeatureSupport).stubs().will(returnValue(true));
    MOCKER(QueryDcacheLockStatus).stubs().will(returnValue(RT_ERROR_NONE));
    dev->stackAddrIsDcache_ = true;

    ElfProgram program(0);
    MOCKER_CPP(&RawDevice::RegisterDcacheLockOp)
        .stubs()
        .with(outBound((Program *)&program))
        .will(returnValue(RT_ERROR_NONE));
    Context ctx(dev, 0);
    ctx.Init();
    MOCKER_CPP(&Context::LaunchKernel,
        int(Context::*)(const void *const,
            const uint32_t,
            const rtArgsEx_t *,
            rtL2Ctrl_t *,
            Stream *,
            const uint32_t,
            const TaskCfg *const,
            const bool))
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));
    rtError_t ret = dev->RegisterAndLaunchDcacheLockOp(&ctx);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    delete dev;
    dev = nullptr;
    ctx.device_ = nullptr;
}

TEST_F(CloudV2DcacheDeviceTest, LaunchDcacheLockOp_06)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = new RawDevice(1);
    dev->Init();
    MOCKER_CPP_VIRTUAL(dev, &RawDevice::CheckFeatureSupport).stubs().will(returnValue(true));
    MOCKER(QueryDcacheLockStatus).stubs().will(returnValue(RT_ERROR_NONE));
    dev->stackAddrIsDcache_ = true;

    ElfProgram program(0);
    MOCKER_CPP(&RawDevice::RegisterDcacheLockOp)
        .stubs()
        .with(outBound((Program *)&program))
        .will(returnValue(RT_ERROR_NONE));
    Context ctx(dev, 0);
    ctx.Init();
    MOCKER_CPP(&Context::LaunchKernel,
        int(Context::*)(const void *const,
            const uint32_t,
            const rtArgsEx_t *,
            rtL2Ctrl_t *,
            Stream *,
            const uint32_t,
            const TaskCfg *const,
            const bool))
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    rtError_t ret = dev->RegisterAndLaunchDcacheLockOp(&ctx);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    delete dev;
    dev = nullptr;
    ctx.device_ = nullptr;
}

TEST_F(CloudV2DcacheDeviceTest, LaunchDcacheLockOp_07)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = new RawDevice(1);
    dev->Init();
    MOCKER_CPP_VIRTUAL(dev, &RawDevice::CheckFeatureSupport).stubs().will(returnValue(true));
    MOCKER(QueryDcacheLockStatus).stubs().will(returnValue(RT_ERROR_NONE));
    dev->stackAddrIsDcache_ = true;

    ElfProgram program(0);
    MOCKER_CPP(&RawDevice::RegisterDcacheLockOp)
        .stubs()
        .with(outBound((Program *)&program))
        .will(returnValue(RT_ERROR_NONE));
    Context ctx(dev, 0);
    ctx.Init();
    MOCKER_CPP(&Context::LaunchKernel,
        int(Context::*)(const void *const,
            const uint32_t,
            const rtArgsEx_t *,
            rtL2Ctrl_t *,
            Stream *,
            const uint32_t,
            const TaskCfg *const,
            const bool))
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t ret = dev->RegisterAndLaunchDcacheLockOp(&ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete dev;
    dev = nullptr;
    ctx.device_ = nullptr;
}

TEST_F(CloudV2DcacheDeviceTest, FreeDcacheAddr_01)
{
    MOCKER(halMemCtl)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));
    int32_t temp = 0;
    void *tempAddr = static_cast<void *>(&temp);
    void *drvHandle = nullptr;
    FreeDcacheAddr(0, tempAddr, drvHandle);
    EXPECT_EQ(tempAddr, nullptr);
}

TEST_F(CloudV2DcacheDeviceTest, AllocAddrForDcache_01)
{
    MOCKER(halMemCtl).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any()).will(returnValue(DRV_ERROR_INVALID_VALUE));
    void *tempAddr = nullptr;
    void *drvHandle = nullptr;
    auto ret = AllocAddrForDcache(0, tempAddr, 0, drvHandle);
    EXPECT_EQ(ret, RT_ERROR_DCACHE_MEM_ALLOC_FAIL);
}

TEST_F(CloudV2DcacheDeviceTest, AllocAddrForDcache_02)
{
    MOCKER(halMemCtl)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));
    int32_t temp = 0;
    void *tempAddr = static_cast<void *>(&temp);
    void *drvHandle = nullptr;
    auto ret = AllocAddrForDcache(0, tempAddr, 0, drvHandle);
    EXPECT_EQ(ret, RT_ERROR_DCACHE_MEM_ALLOC_FAIL);
}

TEST_F(CloudV2DcacheDeviceTest, QueryDcacheLockStatus_01)
{
    MOCKER(halTsdrvCtl).stubs().will(returnValue(DRV_ERROR_NO_DEVICE));
    int32_t temp = 0;
    void *dcacheAddr = &temp;
    bool dCacheLockFlag = false;
    rtError_t ret = QueryDcacheLockStatus(0, 0, dcacheAddr, dCacheLockFlag);
    EXPECT_EQ(ret, RT_ERROR_DRV_NO_DEVICE);
}

TEST_F(CloudV2DcacheDeviceTest, QueryDcacheLockStatus_02)
{
    MOCKER(halTsdrvCtl).stubs().will(returnValue(DRV_ERROR_NONE));
    int32_t temp = 0;
    void *dcacheAddr = &temp;
    bool dCacheLockFlag = false;
    rtError_t ret = QueryDcacheLockStatus(0, 0, dcacheAddr, dCacheLockFlag);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2DcacheDeviceTest, QueryDcacheLockStatus_03)
{
    ts_ctrl_msg_body_t ack = {};
    ack.u.query_task_ack_info.status = 1;
    MOCKER(halTsdrvCtl)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP((void *)&ack, sizeof(ack)), mockcpp::any())
        .will(returnValue(DRV_ERROR_NONE));
    int32_t temp = 0;
    void *dcacheAddr = &temp;
    bool dCacheLockFlag = false;
    rtError_t ret = QueryDcacheLockStatus(0, 0, dcacheAddr, dCacheLockFlag);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2DcacheDeviceTest, QueryDcacheLockStatus_04)
{
    ts_ctrl_msg_body_t ack = {};
    memset(&ack, 1, sizeof(ts_ctrl_msg_body_t));
    ack.u.query_task_ack_info.status = 1;
    MOCKER(halTsdrvCtl)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP((void *)&ack, sizeof(ack)), mockcpp::any())
        .will(returnValue(DRV_ERROR_NONE));
    int32_t temp = 0;
    void *dcacheAddr = &temp;
    bool dCacheLockFlag = false;
    rtError_t ret = QueryDcacheLockStatus(0, 0, dcacheAddr, dCacheLockFlag);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(dCacheLockFlag, true);
}

TEST_F(CloudV2DcacheDeviceTest, RegisterDcacheLockOp_01)
{
    RawDevice *dev = new RawDevice(1);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::vector<char> dcacheLockMixOpData{'a'};
    rtInstance->dcacheLockMixOpData_ = dcacheLockMixOpData;
    MOCKER_CPP(&Runtime::ProgramRegister).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    Program *dcacheLockOpProgram = nullptr;
    auto ret = dev->RegisterDcacheLockOp(dcacheLockOpProgram);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    rtInstance->dcacheLockMixOpData_.clear();
    delete dev;
}

TEST_F(CloudV2DcacheDeviceTest, RegisterDcacheLockOp_02)
{
    RawDevice *dev = new RawDevice(1);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::vector<char> dcacheLockMixOpData{'a'};
    rtInstance->dcacheLockMixOpData_ = dcacheLockMixOpData;
    ElfProgram program(0);
    Program *programPtr = &program;
    MOCKER_CPP(&Runtime::ProgramRegister)
        .stubs()
        .with(mockcpp::any(), outBoundP(&programPtr, sizeof(programPtr)))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Runtime::KernelRegister).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    Program *dcacheLockOpProgram = nullptr;
    auto ret = dev->RegisterDcacheLockOp(dcacheLockOpProgram);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    rtInstance->dcacheLockMixOpData_.clear();
    delete dev;
}

TEST_F(CloudV2DcacheDeviceTest, RegisterDcacheLockOp_03)
{
    RawDevice *dev = new RawDevice(1);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::vector<char> dcacheLockMixOpData{'a'};
    rtInstance->dcacheLockMixOpData_ = dcacheLockMixOpData;
    ElfProgram program(0);
    Program *programPtr = &program;
    MOCKER_CPP(&Runtime::ProgramRegister)
        .stubs()
        .with(mockcpp::any(), outBoundP(&programPtr, sizeof(programPtr)))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Runtime::KernelRegister).stubs().will(returnValue(RT_ERROR_NONE));
    Program *dcacheLockOpProgram = nullptr;
    auto ret = dev->RegisterDcacheLockOp(dcacheLockOpProgram);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtInstance->dcacheLockMixOpData_.clear();
    delete dev;
}

TEST_F(CloudV2DcacheDeviceTest, FindAndRegisterDcacheLockOp_01)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->FindDcacheLockOp();
    EXPECT_EQ(rtInstance->dcacheLockMixOpData_.size(), 0);
}

TEST_F(CloudV2DcacheDeviceTest, FindAndRegisterDcacheLockOp_02)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    MOCKER(stat).stubs().will(returnValue(0));
    rtInstance->FindDcacheLockOp();
    EXPECT_EQ(rtInstance->dcacheLockMixOpData_.size(), 0);
}

TEST_F(CloudV2DcacheDeviceTest, FindAndRegisterDcacheLockOp_06)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    std::string driverPath = "llt/ace/npuruntime/runtime/ut/runtime/test/data/";
    MOCKER(GetDriverPath).stubs().with(outBound(driverPath)).will(returnValue(true));
    MOCKER_CPP(&ifstream::is_open, bool(ifstream::*)()).stubs().will(returnValue(false));
    rtInstance->FindDcacheLockOp();
    EXPECT_EQ(rtInstance->dcacheLockMixOpData_.size(), 0);
}

int32_t invokeStat(const char *path, struct stat *buf)
{
    if (path != nullptr && !strcmp(path, "/usr/local/Ascend/driver/lib64/common/dcache_lock_mix.o")) {
        buf->st_size = 1;
    }
    return 0;
}

TEST_F(CloudV2DcacheDeviceTest, FindAndRegisterDcacheLockOp_07)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    MOCKER(stat).stubs().with(mockcpp::any(), mockcpp::any()).will(invoke(invokeStat));
    MOCKER_CPP(&ifstream::is_open, bool(ifstream::*)()).stubs().will(returnValue(true));
    rtInstance->FindDcacheLockOp();
    EXPECT_EQ(rtInstance->dcacheLockMixOpData_.size(), 0);
}

class CloudV2DcacheLockFillFftsMixSqeForDavinciTaskTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {}

    static void TearDownTestCase()
    {}

    virtual void SetUp()
    {
        rtSetDevice(0);
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }
private:
    rtChipType_t oldChipType;
};

TEST_F(CloudV2DcacheLockFillFftsMixSqeForDavinciTaskTest, FillFftsMixSqeForDavinciTask_01)
{
    rtContext_t ctx;
    rtError_t ret = RT_ERROR_NONE;
    ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ElfProgram program(0);
    program.isDcacheLockOp_ = true;
    Kernel kernel(NULL, "", 355, &program, 10);

    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_FFTS_PLUS;
    taskInfo.bindFlag = true;
    taskInfo.stream = static_cast<Stream*>(stream);
    taskInfo.u.aicTaskInfo.kernel = &kernel;

    rtStarsSqe_t command = {};
    uint32_t minStackSize = 0U;
    FillFftsMixSqeForDavinciTask(&taskInfo, &command, minStackSize, ret);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}
