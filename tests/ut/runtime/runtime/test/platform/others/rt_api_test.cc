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
#include "stars.hpp"
#include "npu_driver.hpp"
#include "api_error.hpp"
#include "event.hpp"
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "notify.hpp"
#include "profiler.hpp"
#include "api_profile_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "device_state_callback_manager.hpp"
#include "task_fail_callback_manager.hpp"
#include "model.hpp"
#include "subscribe.hpp"
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include "thread_local_container.hpp"
#undef protected
#undef private

using namespace testing;
using namespace cce::runtime;

class ApiAbnormalTest : public testing::Test
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
    }

    virtual void TearDown()
    {
         GlobalMockObject::verify();
    }
};

TEST_F(ApiAbnormalTest, rtReduceAsyncV2Abnormal)
{
    rtError_t error;
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    EXPECT_NE(rtInstance, nullptr);
    rtChipType_t originType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DAVID);
    GlobalContainer::SetRtChipType(CHIP_DAVID);
    error = rtReduceAsyncV2(nullptr, 0, nullptr, 0, RT_MEMCPY_SDMA_AUTOMATIC_ADD, RT_DATA_TYPE_FP32, nullptr, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
    rtInstance->SetChipType(originType);
    GlobalContainer::SetRtChipType(originType);
}

TEST_F(ApiAbnormalTest, rtRDMASendAbnormal)
{
    rtError_t error;
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    EXPECT_NE(rtInstance, nullptr);
    rtChipType_t originType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DAVID);
    GlobalContainer::SetRtChipType(CHIP_DAVID);
    error = rtRDMASend(0, 0, 0);
    EXPECT_NE(error, RT_ERROR_NONE);
    rtInstance->SetChipType(originType);
    GlobalContainer::SetRtChipType(originType);
}

TEST_F(ApiAbnormalTest, rtRDMADBSendAbnormal)
{
    rtError_t error;
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    EXPECT_NE(rtInstance, nullptr);
    rtChipType_t originType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DAVID);
    GlobalContainer::SetRtChipType(CHIP_DAVID);
    error = rtRDMADBSend(0, 0, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
    rtInstance->SetChipType(originType);
    GlobalContainer::SetRtChipType(originType);
}

TEST_F(ApiAbnormalTest, rtsGetMemcpyDescSize_DavidChip_Success)
{
    rtError_t error;
    size_t size;
    char oriSocVersion[128] = {0};
    rtGetSocVersion(oriSocVersion, 128);
    GlobalContainer::SetHardwareChipType(CHIP_END);
    (void)rtSetSocVersion("ASCEND910_958A");
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DAVID);
    GlobalContainer::SetRtChipType(CHIP_DAVID);
    
    error = rtsGetMemcpyDescSize(RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE, &size);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(size, MEMCPY_DESC_SIZE_V2);
    
    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
    GlobalContainer::SetHardwareChipType(CHIP_END);
    rtSetSocVersion(oriSocVersion);
}