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
#include "driver/ascend_hal.h"
#include "securec.h"
#include "runtime/rt.h"
#include "runtime/rts/rts.h"
#include "runtime/event.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "api.hpp"
#include "api_impl.hpp"
#include "api_error.hpp"
#include "program.hpp"
#include "context.hpp"
#include "raw_device.hpp"
#include "logger.hpp"
#include "engine.hpp"
#include "async_hwts_engine.hpp"
#include "task_res.hpp"
#include "rdma_task.h"
#include "stars.hpp"
#include "npu_driver.hpp"
#include "api_error.hpp"
#include "event.hpp"
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "notify.hpp"
#include "count_notify.hpp"
#include "profiler.hpp"
#include "api_profile_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "device_state_callback_manager.hpp"
#include "task_fail_callback_manager.hpp"
#include "model.hpp"
#include "capture_model.hpp"
#include "subscribe.hpp"
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include <cstring>
#include "thread_local_container.hpp"
#include "heterogenous.h"
#include "task_execute_time.h"
#include "runtime/rts/rts_device.h"
#include "runtime/rts/rts_stream.h"
#include "api_c.h"
#undef protected
#undef private

using namespace testing;
using namespace cce::runtime;

class ApiTest6 : public testing::Test
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
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }
};

TEST_F(ApiTest6, rtGetConditionKernelBin_TEST_1)
{
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    char_t *buffer = nullptr;
    char_t *binFileName = "elf.o";
    uint32_t length = 0;

    rtError_t error = rtGetKernelBin(binFileName, &buffer, &length);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_NANO);
    GlobalContainer::SetRtChipType(CHIP_NANO);
    error = rtGetKernelBin(binFileName, &buffer, &length);
    rtFreeKernelBin(buffer);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}

TEST_F(ApiTest6, Need_Translate_TEST)
{
    bool bNeed = false;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t ori_chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_5612);
    GlobalContainer::SetRtChipType(CHIP_5612);
    rtError_t error = rtNeedDevVA2PA(&bNeed);
    rtInstance->SetChipType(ori_chipType);
    GlobalContainer::SetRtChipType(ori_chipType);
    EXPECT_EQ(bNeed, true);
}

TEST_F(ApiTest6, TINY_ALLOC_STACK_TEST)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t ori_chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_5612);
    GlobalContainer::SetRtChipType(CHIP_5612);

    int32_t devId = 0;
    rtContext_t ctx;
    rtError_t error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxCreate(&ctx, 0, devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceReset(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtInstance->SetChipType(ori_chipType);
    GlobalContainer::SetRtChipType(ori_chipType);

}

TEST_F(ApiTest6, Translate_VA_2_PA_TEST_SYNC)
{
    uint64_t devAddr = 0;
    uint64_t len = 1;
    rtStream_t stream;
    bool isAsync = false;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t ori_chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_5612);
    GlobalContainer::SetRtChipType(CHIP_5612);
    rtError_t error = rtDevVA2PA(devAddr, len, stream, isAsync);
    rtInstance->SetChipType(ori_chipType);
    GlobalContainer::SetRtChipType(ori_chipType);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiTest6, Translate_VA_2_PA_TEST_SYNC_FAIL)
{
    uint64_t devAddr = 0;
    uint64_t len = 0;
    rtStream_t stream;
    bool isAsync = false;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t ori_chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_5612);
    GlobalContainer::SetRtChipType(CHIP_5612);
    rtError_t error = rtDevVA2PA(devAddr, len, stream, isAsync);
    rtInstance->SetChipType(ori_chipType);
    GlobalContainer::SetRtChipType(ori_chipType);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiTest6, Translate_VA_2_PA_TEST_ASYNC)
{
    uint64_t devAddr = 0;
    uint64_t len = 0;
    rtStream_t stream;
    rtError_t error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    bool isAsync = true;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t ori_chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_5612);
    GlobalContainer::SetRtChipType(CHIP_5612);
    error = rtDevVA2PA(devAddr, len, stream, isAsync);
    rtInstance->SetChipType(ori_chipType);
    GlobalContainer::SetRtChipType(ori_chipType);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}