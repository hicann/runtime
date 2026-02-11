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
#define protected public
#define private public
#include "task.hpp"
#include "uma_arg_loader.hpp"
#include "task_res.hpp"
#include "task_submit.hpp"
#include "rdma_task.h"
#include "base.hpp"
#include "stars_david.hpp"
#include "task_res_da.hpp"
#include "notify.hpp"
#include "count_notify.hpp"
#include "event_david.hpp"
#include "context.hpp"
#include "profiler.hpp"
#include "runtime.hpp"
#include "uma_arg_loader.hpp"
#include "stars_cond_isa_define.hpp"
#include "thread_local_container.hpp"
#include "api_impl.hpp"
#include "raw_device.hpp"
#include "device/device_error_proc.hpp"
#include "stars_engine.hpp"
#include "config_define.hpp"
#include "api_impl_david.hpp"
#include "task_recycle.hpp"
#include "stream_david.hpp"
#include "subscribe.hpp"
#include "task_david.hpp"
#include "model_c.hpp"
#include "device_error_proc_c.hpp"
#include "arg_manage_david.hpp"
#include "stream_c.hpp"
#undef protected
#undef private

using namespace testing;
using namespace cce::runtime;

class DavidContextTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout << "DavidContextTest SetUpTestCase start" << std::endl;
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetDisableThread(true);
        originType_ = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        std::cout << "DavidContextTest SetUpTestCase end" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "DavidContextTest TearDownTestCase start" << std::endl;
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(originType_);
        GlobalContainer::SetRtChipType(originType_);
        rtInstance->SetDisableThread(false);
        std::cout << "DavidContextTest TearDownTestCase end" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "DavidContextTest SetUp start" << std::endl;
        rtSetDevice(0);
        std::cout << "DavidContextTest SetUp end" << std::endl;
    }

    virtual void TearDown()
    {
        std::cout << "DavidContextTest TearDown start" << std::endl;
        GlobalMockObject::verify();
        rtDeviceReset(0);
        std::cout << "DavidContextTest TearDown end" << std::endl;
    }
private:
    static rtChipType_t originType_;
};

rtChipType_t DavidContextTest::originType_ = CHIP_DAVID;

TEST_F(DavidContextTest, CopyTilingTabToDevForDavid_ForNewBinaryLoadFlow_Test)
{
    GlobalMockObject::verify();
    int32_t devId;
    rtError_t error;
    Context *ctx;

    error = rtGetDevice(&devId);
    RawDevice *device = new RawDevice(0);
    EXPECT_NE(device, nullptr);
    device->Init();
    Stream *stream = new Stream(device, 0);
    RefObject<Context*> *refObject = NULL;
    refObject = (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(devId);
    EXPECT_NE(refObject, nullptr);
    ctx = refObject->GetVal();
    EXPECT_NE(ctx, nullptr);
    PlainProgram prog;
    prog.SetIsNewBinaryLoadFlow(true);
    TilingTabl *memoryPtr = new TilingTabl[10];
    uint32_t tilingTabLen = 0U;
    void *devMem = nullptr;
    auto preType = Runtime::Instance()->chipType_;
    Runtime::Instance()->chipType_ = CHIP_DAVID;
    GlobalContainer::SetRtChipType(CHIP_DAVID);
    MOCKER_CPP(&Program::DavidBuildTilingTblForNewFlow)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(RT_ERROR_NONE));
    error = ctx->CopyTilingTabToDev((Program *)&prog, device, &devMem, &tilingTabLen);
    EXPECT_EQ(error, 1);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP((void **)&memoryPtr))
        .will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    error = ctx->CopyTilingTabToDev((Program *)&prog, device, &devMem, &tilingTabLen);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP((void **)&memoryPtr))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync)
        .stubs()
        .then(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    error = ctx->CopyTilingTabToDev((Program *)&prog, device, &devMem, &tilingTabLen);
    EXPECT_NE(error, RT_ERROR_NONE);

        MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP((void **)&memoryPtr))
        .will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    error = ctx->CopyTilingTabToDev((Program *)&prog, device, &devMem, &tilingTabLen);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP((void **)memoryPtr))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync)
        .stubs()
        .then(returnValue(RT_ERROR_NONE));
    error = ctx->CopyTilingTabToDev((Program *)&prog, device, &devMem, &tilingTabLen);
    EXPECT_NE(error, RT_ERROR_NONE);
    Runtime::Instance()->chipType_ = preType;
    GlobalContainer::SetRtChipType(preType);
    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(devId);
    delete stream;
    delete device;
    delete [] memoryPtr;
    GlobalMockObject::verify();
}

TEST_F(DavidContextTest, CopyTilingTabToDevForDavid_test)
{
    GlobalMockObject::verify();
    int32_t devId;
    rtError_t error;
    Context *ctx;

    error = rtGetDevice(&devId);
    RawDevice *device = new RawDevice(0);
    EXPECT_NE(device, nullptr);
    device->Init();
    Stream *stream = new Stream(device, 0);
    RefObject<Context*> *refObject = NULL;
    refObject = (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(devId);
    EXPECT_NE(refObject, nullptr);
    ctx = refObject->GetVal();
    EXPECT_NE(ctx, nullptr);

    PlainProgram prog;
    TilingTabl *memoryPtr = new TilingTabl[10];
    Module module(device);
    MOCKER_CPP(&Context::GetModule)
        .stubs()
        .will(returnValue((Module *)nullptr))
        .then(returnValue(&module));
    auto preType = Runtime::Instance()->chipType_;
    Runtime::Instance()->chipType_ = CHIP_DAVID;
    GlobalContainer::SetRtChipType(CHIP_DAVID);
    error = ctx->CopyTilingTabToDev((Program *)&prog, device, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_MODULE_NULL);

    MOCKER_CPP(&Program::BuildTilingTblForDavid)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(RT_ERROR_NONE));
    error = ctx->CopyTilingTabToDev((Program *)&prog, device, nullptr, nullptr);
    EXPECT_EQ(error, 1);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP((void **)&memoryPtr))
        .will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    error = ctx->CopyTilingTabToDev((Program *)&prog, device, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP((void **)&memoryPtr))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync)
        .stubs()
        .then(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    error = ctx->CopyTilingTabToDev((Program *)&prog, device, nullptr, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

        MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP((void **)&memoryPtr))
        .will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    error = ctx->CopyTilingTabToDev((Program *)&prog, device, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP((void **)memoryPtr))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync)
        .stubs()
        .then(returnValue(RT_ERROR_NONE));
    error = ctx->CopyTilingTabToDev((Program *)&prog, device, nullptr, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
    Runtime::Instance()->chipType_ = preType;
    GlobalContainer::SetRtChipType(preType);
    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(devId);
    delete stream;
    delete device;
    delete [] memoryPtr;
    GlobalMockObject::verify();
}
