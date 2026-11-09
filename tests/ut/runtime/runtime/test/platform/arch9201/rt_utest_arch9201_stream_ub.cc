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
#include "runtime/rt_external_mem.h"
#include "rt_unwrap.h"
#include "runtime/rt.h"
#define private public
#define protected public
#include "engine.hpp"
#include "raw_device.hpp"
#include "runtime.hpp"
#include "stars_david.hpp"
#include "stream.hpp"
#include "task_info.hpp"
#include "task_res_da.hpp"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

namespace {
bool g_taskFailCallbackInvoked = false;
}

class Arch9201StreamUbTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        Runtime* const runtime = static_cast<Runtime*>(Runtime::Instance());
        oldDisableThread_ = runtime->GetDisableThread();
        oldConnectUbFlag_ = runtime->GetConnectUbFlag();
        runtime->SetDisableThread(true);
        runtime->SetConnectUbFlag(true);
    }

    static void TearDownTestCase()
    {
        Runtime* const runtime = static_cast<Runtime*>(Runtime::Instance());
        runtime->SetDisableThread(oldDisableThread_);
        runtime->SetConnectUbFlag(oldConnectUbFlag_);
    }

    void SetUp() override
    {
        g_taskFailCallbackInvoked = false;
        Driver* driver = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);

        bool enable = false;
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqEnable)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(enable))
            .will(returnValue(RT_ERROR_NONE));

        ASSERT_EQ(rtSetDevice(0), RT_ERROR_NONE);

        device_ = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
        engine_ = ((RawDevice*)device_)->engine_;

        ASSERT_EQ(rtStreamCreate(&streamHandle_, 0), RT_ERROR_NONE);
        stream_ = rt_ut::UnwrapOrNull<Stream>(streamHandle_);
    }

    void TearDown() override
    {
        while (engine_->GetPendingNum() > 0) {
            engine_->pendingNum_.Set(0U);
        }
        TaskResManageDavid* taskResMang = ((TaskResManageDavid*)(static_cast<Stream*>(stream_)->taskResMang_));
        taskResMang->ResetTaskRes();
        rtStreamDestroy(streamHandle_);
        ((Runtime*)Runtime::Instance())->DeviceRelease(device_);
        rtDeviceReset(0);
        GlobalMockObject::reset();
    }

    Device* device_ = nullptr;
    Stream* stream_ = nullptr;
    Engine* engine_ = nullptr;
    rtStream_t streamHandle_ = nullptr;

private:
    static bool oldDisableThread_;
    static bool oldConnectUbFlag_;
};

bool Arch9201StreamUbTest::oldDisableThread_ = false;
bool Arch9201StreamUbTest::oldConnectUbFlag_ = false;

void TaskFailCallBackForDoorBell(rtExceptionInfo_t* exceptionInfo)
{
    g_taskFailCallbackInvoked = true;
    // TS_ERROR_TASK_EXCEPTION -> RT_ERROR_TSFW_TASK_EXCEPTION -> ACL_ERROR_RT_TS_ERROR
    EXPECT_EQ(exceptionInfo->retcode, ACL_ERROR_RT_TS_ERROR);
    EXPECT_EQ(exceptionInfo->expandInfo.type, RT_EXCEPTION_UB);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.ubType, RT_UB_TYPE_DOORBELL);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.ubNum, 2);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.info[0].dieId, 0);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.info[0].functionId, 1);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.info[0].jettyId, 10);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.info[0].piValue, 20);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.info[1].dieId, 1);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.info[1].functionId, 2);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.info[1].jettyId, 12);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.info[1].piValue, 30);
}

TEST_F(Arch9201StreamUbTest, ubdma_doorbell_task_doCompleteSuccess)
{
    ASSERT_EQ(rtRegTaskFailCallbackByModule("taskFailCallBackForDoorBell", TaskFailCallBackForDoorBell), RT_ERROR_NONE);

    TaskInfo task = {};
    rtUbDbInfo_t dbInfo = {};
    dbInfo.dbNum = 2;
    dbInfo.info[0].functionId = 1;
    dbInfo.info[0].jettyId = 10;
    dbInfo.info[0].piValue = 20;
    dbInfo.info[1].dieId = 1;
    dbInfo.info[1].functionId = 2;
    dbInfo.info[1].jettyId = 12;
    dbInfo.info[1].piValue = 30;
    InitByStream(&task, stream_);
    UbDbSendTaskInit(&task, &dbInfo, 0);

    rtCqReport_t cqe = {};
    cqe.errorType = 1U;
    SetStarsResult(&task, cqe);
    EXPECT_EQ(task.errorCode, TS_ERROR_TASK_EXCEPTION);
    Complete(&task, 0);
    EXPECT_TRUE(g_taskFailCallbackInvoked);

    EXPECT_EQ(rtRegTaskFailCallbackByModule("taskFailCallBackForDoorBell", nullptr), RT_ERROR_NONE);
}

void TaskFailCallBackForDirectWqe(rtExceptionInfo_t* exceptionInfo)
{
    g_taskFailCallbackInvoked = true;
    // TS_ERROR_TASK_BUS_ERROR -> RT_ERROR_TSFW_TASK_BUS_ERROR -> ACL_ERROR_RT_TS_ERROR
    EXPECT_EQ(exceptionInfo->retcode, ACL_ERROR_RT_TS_ERROR);
    EXPECT_EQ(exceptionInfo->expandInfo.type, RT_EXCEPTION_UB);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.ubNum, 1U);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.ubType, RT_UB_TYPE_DIRECT_WQE);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.info[0].dieId, 0);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.info[0].functionId, 1);
    EXPECT_EQ(exceptionInfo->expandInfo.u.ubInfo.info[0].jettyId, 10);
}

TEST_F(Arch9201StreamUbTest, ubdma_direct_task_doCompleteSuccess)
{
    ASSERT_EQ(
        rtRegTaskFailCallbackByModule("taskFailCallBackForDirectWqe", TaskFailCallBackForDirectWqe), RT_ERROR_NONE);

    TaskInfo task = {};
    rtUbWqeInfo_t wqeInfo = {};
    wqeInfo.wrCqe = 1;
    wqeInfo.functionId = 1;
    wqeInfo.jettyId = 10;
    uint8_t wqe[128] = {};
    wqeInfo.wqe = wqe;
    wqeInfo.wqePtrLen = sizeof(wqe);
    InitByStream(&task, stream_);
    UbDirectSendTaskInit(&task, &wqeInfo);

    rtCqReport_t cqe = {};
    cqe.errorType = 2U;
    SetStarsResult(&task, cqe);
    EXPECT_EQ(task.errorCode, TS_ERROR_TASK_BUS_ERROR);
    Complete(&task, 0);
    EXPECT_TRUE(g_taskFailCallbackInvoked);

    EXPECT_EQ(rtRegTaskFailCallbackByModule("taskFailCallBackForDirectWqe", nullptr), RT_ERROR_NONE);
}
