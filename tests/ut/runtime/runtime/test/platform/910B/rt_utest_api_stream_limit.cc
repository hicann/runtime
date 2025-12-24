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
#include "api_decorator.hpp"
#include "runtime.hpp"
#include "model.hpp"
#include "raw_device.hpp"
#include "module.hpp"
#include "notify.hpp"
#include "event.hpp"
#include "task_info.hpp"
#include "task_info.h"
#include "ffts_task.h"
#include "device/device_error_proc.hpp"
#include "program.hpp"
#include "uma_arg_loader.hpp"
#include "npu_driver.hpp"
#include "ctrl_res_pool.hpp"
#include "stream_sqcq_manage.hpp"
#include "davinci_kernel_task.h"
#include "profiler.hpp"
#include "rdma_task.h"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

class CloudV2StreamResLimitTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {}

    static void TearDownTestCase()
    {}

    virtual void SetUp()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        isCfgOpWaitTaskTimeout = rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout;
        isCfgOpExcTaskTimeout = rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout;
        rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout = false;
        rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout = false;
        rtSetDevice(0);
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout = isCfgOpWaitTaskTimeout;
        rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout = isCfgOpExcTaskTimeout;
        GlobalMockObject::verify();
    }

private:
    rtChipType_t oldChipType;
    bool isCfgOpWaitTaskTimeout{false};
    bool isCfgOpExcTaskTimeout{false};
};

TEST_F(CloudV2StreamResLimitTest, TestSetStreamResLimit)
{
    rtStream_t stream;
    rtError_t error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Api * oldApi = Runtime::Instance()->api_;
    ApiDecorator *apiDeco = new ApiDecorator(oldApi);
    Runtime::Instance()->api_ = apiDeco;

    uint32_t value = 2U; 
    error = rtsSetStreamResLimit(stream, RT_DEV_RES_CUBE_CORE, value);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    uint32_t resultValue = 0U;
    error = rtsGetStreamResLimit(stream, RT_DEV_RES_CUBE_CORE, &resultValue);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(resultValue, value);

    error = rtsSetStreamResLimit(stream, RT_DEV_RES_VECTOR_CORE, 2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsGetStreamResLimit(stream, RT_DEV_RES_VECTOR_CORE, &resultValue);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(resultValue, value);

    error = rtsUseStreamResInCurrentThread(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsGetResInCurrentThread(RT_DEV_RES_CUBE_CORE, &resultValue);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(resultValue, value);

    error = rtsGetResInCurrentThread(RT_DEV_RES_VECTOR_CORE, &resultValue);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(resultValue, value);

    error = rtsNotUseStreamResInCurrentThread(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsSetDeviceResLimit(0, RT_DEV_RES_CUBE_CORE, 24);
    error = rtsGetResInCurrentThread(RT_DEV_RES_CUBE_CORE, &resultValue);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(resultValue, 24);

    error = rtsSetDeviceResLimit(0, RT_DEV_RES_VECTOR_CORE, 48);
    error = rtsGetResInCurrentThread(RT_DEV_RES_VECTOR_CORE, &resultValue);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(resultValue, 48);

    MOCKER(&InnerThreadLocalContainer::GetDevice)
    .stubs()
    .will(returnValue((cce::runtime::Device*)nullptr));
    error = rtsGetResInCurrentThread(RT_DEV_RES_CUBE_CORE, &resultValue);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(resultValue, 24); 

    error = rtsSetStreamResLimit(0, RT_DEV_RES_VECTOR_CORE, 2048);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsResetStreamResLimit(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime::Instance()->api_ = oldApi;
    delete apiDeco;
    apiDeco = nullptr;
}

TEST_F(CloudV2StreamResLimitTest, TestSetStreamResLimitNull)
{
    uint32_t value = 2U; 
    auto error = rtsSetStreamResLimit(NULL, RT_DEV_RES_CUBE_CORE, value);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    uint32_t resultValue = 0U;
    error = rtsGetStreamResLimit(NULL, RT_DEV_RES_CUBE_CORE, &resultValue);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(resultValue, value);

    error = rtsUseStreamResInCurrentThread(NULL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsGetResInCurrentThread(RT_DEV_RES_CUBE_CORE, &resultValue);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(resultValue, value);

    error = rtsNotUseStreamResInCurrentThread(NULL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsResetStreamResLimit(NULL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CloudV2StreamResLimitTest, TestGetStreamResLimit)
{
    uint32_t resultValue = 0U;
    auto error = rtsGetStreamResLimit(NULL, RT_DEV_RES_CUBE_CORE, &resultValue);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsGetResInCurrentThread(RT_DEV_RES_CUBE_CORE, &resultValue);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}
