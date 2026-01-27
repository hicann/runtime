/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstdio>
#include <stdlib.h>

#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#define protected public
#include "engine.hpp"
#include "event.hpp"
#include "ctrl_stream.hpp"
#include "scheduler.hpp"
#include "runtime.hpp"
#include "task_info.hpp"
#include "ctrl_res_pool.hpp"
#undef private
#undef protected
#include "context.hpp"
#include "securec.h"
#include "api.hpp"
#include "npu_driver.hpp"
#include "thread_local_container.hpp"
#include "raw_device.hpp"


using namespace testing;
using namespace cce::runtime;

class CloudV2CtrlTaskPoolEntryTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"CtrlTaskPoolEntry test start"<<std::endl;
        (void)rtSetSocVersion("Ascend910");
        ((Runtime *)Runtime::Instance())->SetDisableThread(true);
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        (void)rtSetTSDevice(0);

    }
    static void TearDownTestCase()
    {
        ((Runtime *)Runtime::Instance())->SetDisableThread(false);
    }

    virtual void SetUp()
    {
         (void)rtSetDevice(0);
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        rtDeviceReset(0);
    }
public:
    static Api *oldApi_;
};

TEST_F(CloudV2CtrlTaskPoolEntryTest, ErrorMessageUtilsTest)
{
    // test ErrorMessageUtils
    const std::vector<std::string> errMsgKey;
    const std::vector<std::string> errMsgValue;
    RtInnerErrcodeType rtErrCode = RT_ERROR_STREAM_SYNC_TIMEOUT;
    char_t * funcName = nullptr;

    EXPECT_NE(&errMsgKey, nullptr);
    EXPECT_NE(&errMsgValue, nullptr);
    ErrorMessageUtils::RuntimeErrorMessage(0, errMsgKey, errMsgValue);
    ErrorMessageUtils::FuncErrorReason(rtErrCode, funcName);
}