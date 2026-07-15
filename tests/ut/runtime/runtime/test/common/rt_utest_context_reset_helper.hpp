/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TESTS_UT_RUNTIME_RUNTIME_TEST_COMMON_RT_UTEST_CONTEXT_RESET_HELPER_HPP_
#define TESTS_UT_RUNTIME_RUNTIME_TEST_COMMON_RT_UTEST_CONTEXT_RESET_HELPER_HPP_

#include <cstring>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "runtime/rt.h"
#include "context.hpp"
#include "device.hpp"
#include "runtime.hpp"
#include "stream.hpp"
#include "device/device_error_proc.hpp"
#include "toolchain/slog.h"

namespace cce {
namespace runtime {
namespace ut {

inline void ClearCurrentDefaultStreamPending();
inline void ClearCurrentContextStatusForReset();

inline void ResetPrimaryDevice()
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    ClearCurrentContextStatusForReset();
    ClearCurrentDefaultStreamPending();
    error = rtDeviceResetForce(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

inline bool IsCurrentContextReadyForReset()
{
    Context * const curCtx = Runtime::Instance()->CurrentContext();
    return (curCtx != nullptr) && (curCtx->GetState() == ContextState::CTX_STATE_ACTIVE) &&
        (curCtx->Device_() != nullptr) && (curCtx->DefaultStream_() != nullptr);
}

inline void ClearCurrentDefaultStreamPending()
{
    Context * const curCtx = Runtime::Instance()->CurrentContext();
    if (!IsCurrentContextReadyForReset()) {
        return;
    }

    auto clearStream = [](Stream * const stream) {
        if (stream == nullptr) {
            return;
        }
        stream->SetAbortStatus(RT_ERROR_NONE);
        stream->SetBeingAbortedFlag(false);
        stream->SetIsSubmitTaskFailFlag(false);

        stream->pendingNum_.Set(0U);
    };

    clearStream(curCtx->DefaultStream_());
    clearStream(curCtx->OnlineStream_());
    clearStream(curCtx->GetCtrlSQStream());
    for (Stream * const stream : curCtx->StreamList_()) {
        clearStream(stream);
    }
}

inline void ClearCurrentContextStatusForReset()
{
    Context * const curCtx = Runtime::Instance()->CurrentContext();
    if (!IsCurrentContextReadyForReset()) {
        return;
    }

    curCtx->SetFailureError(RT_ERROR_NONE);
    curCtx->SetStreamsStatus(RT_ERROR_NONE);
    curCtx->Device_()->SetDeviceStatus(RT_ERROR_NONE);
}

inline bool IsPrimaryDeviceActive()
{
    uint32_t flag = 0U;
    int32_t state = 0;
    const rtError_t error = rtsGetPrimaryCtxState(0, &flag, &state);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    return (error == ACL_RT_SUCCESS) && (state != 0);
}

inline void ForceResetPrimaryDeviceIfActive()
{
    if (!IsPrimaryDeviceActive()) {
        return;
    }

    ClearCurrentContextStatusForReset();
    ClearCurrentDefaultStreamPending();
    rtError_t error = rtDeviceResetForce(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

inline void ResetPrimaryDeviceIfActive()
{
    ForceResetPrimaryDeviceIfActive();
}

inline void ResetPrimaryDeviceIfActiveWithDeviceDown()
{
    // Kept for existing call sites. This helper no longer flips the device to
    // DEV_RUNNING_DOWN; doing so skips the normal primary stream terminal task
    // and can leave AsyncHwtsEngine threads stuck during reset.
    //
    // The UT mock environment can hang in DeviceErrorProc::SendTaskToStopUseRingBuffer
    // because it synchronously waits on a mocked stream. Stub that cleanup task
    // only, keep the device in DEV_RUNNING_NORMAL, and let RawDevice::Stop() run
    // the normal stream teardown so engine threads can exit through their real
    // terminal path.
    GlobalMockObject::verify();
    GlobalMockObject::reset();

    if (!IsPrimaryDeviceActive()) {
        return;
    }

    if (Runtime::Instance()->CurrentContext() == nullptr) {
        rtError_t setDeviceError = rtSetDevice(0);
        EXPECT_EQ(setDeviceError, ACL_RT_SUCCESS);
    }

    ClearCurrentContextStatusForReset();
    ClearCurrentDefaultStreamPending();

    MOCKER_CPP(&DeviceErrorProc::SendTaskToStopUseRingBuffer)
        .stubs().will(returnValue(static_cast<rtError_t>(RT_ERROR_NONE)));
    Context * const curCtx = Runtime::Instance()->CurrentContext();
    if ((curCtx != nullptr) && (curCtx->Device_() != nullptr)) {
        MOCKER_CPP_VIRTUAL(curCtx->Device_(), &Device::WaitCompletion).stubs();
    }

    rtError_t error = rtDeviceResetForce(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    GlobalMockObject::verify();
    GlobalMockObject::reset();
}

inline bool IsRuntimeNeededForApiContextCase()
{
    const testing::TestInfo * const testInfo = testing::UnitTest::GetInstance()->current_test_info();
    return (testInfo == nullptr) || (std::strcmp(testInfo->name(), "TestRtsCtxDestroy") != 0);
}

inline void SetUpApiContextTest()
{
    if (!IsRuntimeNeededForApiContextCase()) {
        return;
    }
    (void)rtSetDevice(0);
}

inline void TearDownApiContextTest()
{
    GlobalMockObject::verify();
}

class ApiContextTestBase : public testing::Test {
protected:
    void SetUp() override
    {
        SetUpApiContextTest();
    }

    void TearDown() override
    {
        TearDownApiContextTest();
    }
};

} // namespace ut
} // namespace runtime
} // namespace cce

#endif // TESTS_UT_RUNTIME_RUNTIME_TEST_COMMON_RT_UTEST_CONTEXT_RESET_HELPER_HPP_
