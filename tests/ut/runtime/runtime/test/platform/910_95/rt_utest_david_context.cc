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
#include "raw_device.hpp"
#include "module.hpp"
#include "event.hpp"
#include "task_info.hpp"
#include "device/device_error_proc.hpp"
#include "program.hpp"
#include "uma_arg_loader.hpp"
#include "npu_driver.hpp"
#include "ctrl_res_pool.hpp"
#include "stream_sqcq_manage.hpp"
#include "api_impl.hpp"
#include "aicpu_err_msg.hpp"
#include "thread_local_container.hpp"
#undef private
#undef protected
#include "rdma_task.h"
#include "device_sq_cq_pool.hpp"
#include "sq_addr_memory_pool.hpp"

using namespace testing;
using namespace cce::runtime;


class ContextTestDavid : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }

    virtual void SetUp()
    {
        rtSetDevice(0);
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }
public:
    Device *device_ = nullptr;
    Stream *stream_ = nullptr;
    Engine *engine_ = nullptr;
    rtStream_t streamHandle_ = 0;
    static void *binHandle_;
    static char function_;
    static uint32_t binary_[32];
};

TEST_F(ContextTestDavid, CopyTilingTabToDevForDavid_ForNewBinaryLoadFlow_Test)
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
    Module module(device);
    void *devMem = nullptr;

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
    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(devId);
    delete stream;
    delete device;
    delete [] memoryPtr;
    GlobalMockObject::verify();
}

TEST_F(ContextTestDavid, CopyTilingTabToDevForDavid_test)
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
    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(devId);
    delete stream;
    delete device;
    delete [] memoryPtr;
    GlobalMockObject::verify();
}
