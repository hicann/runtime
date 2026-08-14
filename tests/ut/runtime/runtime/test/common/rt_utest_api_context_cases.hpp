/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TESTS_UT_RUNTIME_RUNTIME_TEST_COMMON_RT_UTEST_API_CONTEXT_CASES_HPP_
#define TESTS_UT_RUNTIME_RUNTIME_TEST_COMMON_RT_UTEST_API_CONTEXT_CASES_HPP_

#include <iostream>

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#define private public
#include "config.h"
#include "runtime/context.h"
#include "rt_error_codes.h"
#include "rt_utest_context_reset_helper.hpp"
#undef private

namespace cce {
namespace runtime {
namespace ut {

inline void RunRtsCtxDestroyCase()
{
    rtError_t error = rtsCtxDestroy(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

inline void ExpectPrimaryCtxStateAccessible(const int32_t devId)
{
    int32_t state = 0;
    uint32_t flag = 0;
    rtError_t error = rtsGetPrimaryCtxState(devId, &flag, &state);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

inline void ExpectCurrentDevice(const int32_t devId)
{
    int32_t currentDevId = -1;
    rtError_t error = rtCtxGetDevice(&currentDevId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(currentDevId, devId);
}

inline void ExpectCurrentContext(const rtContext_t expected)
{
    rtContext_t current = nullptr;
    rtError_t error = rtsCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(current, expected);
}

inline void CreateContextPairAndRejectInvalidFlag(const int32_t devId, rtContext_t& ctxA, rtContext_t& ctxB)
{
    rtContext_t invalidCtx = nullptr;
    rtError_t error = rtsCtxCreate(&ctxA, 0, devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsCtxCreate(&ctxB, 0, devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsCtxCreate(&invalidCtx, 1, devId);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

inline void SwitchAndExpectCurrentContext(const rtContext_t ctx, const int32_t devId)
{
    rtError_t error = rtsCtxSetCurrent(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ExpectCurrentDevice(devId);
    ExpectCurrentContext(ctx);
}

inline void RunRtsCtxGetAndSetCurrentCase()
{
    int32_t devId = 0;
    ExpectPrimaryCtxStateAccessible(devId);

    rtError_t error = rtsCtxGetCurrent(NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ExpectCurrentDevice(devId);
    ExpectPrimaryCtxStateAccessible(devId);

    rtContext_t ctxA = nullptr;
    rtContext_t ctxB = nullptr;
    CreateContextPairAndRejectInvalidFlag(devId, ctxA, ctxB);

    SwitchAndExpectCurrentContext(ctxA, devId);
    SwitchAndExpectCurrentContext(ctxB, devId);

    error = rtSetDevice(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtContext_t current = nullptr;
    error = rtsCtxGetCurrent(&current);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctxA);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCtxDestroy(ctxB);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ExpectPrimaryCtxStateAccessible(devId);
}

inline void RunRtsGetPrimaryCtxStateCase()
{
    rtError_t error;
    int32_t state = 0;
    int32_t devId = 0;
    uint32_t flag;
    rtContext_t ctx = nullptr;
    rtsCtxCreate(&ctx, 0, devId);
    error = rtsGetPrimaryCtxState(1, &flag, &state);
    bool isInUse = false;
    ContextManage::QueryContextInUse(0, isInUse);
    rtCtxDestroy(ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

inline void RunRtsCtxGetAndSetSysParamOptCase()
{
    rtError_t error;
    int64_t val;
    error = rtsCtxGetSysParamOpt(SYS_OPT_DETERMINISTIC, &val);
    EXPECT_EQ(error, ACL_ERROR_RT_SYSPARAMOPT_NOT_SET);

    error = rtsCtxSetSysParamOpt(SYS_OPT_DETERMINISTIC, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsCtxGetSysParamOpt(SYS_OPT_DETERMINISTIC, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(val, 1);

    error = rtsCtxSetSysParamOpt(SYS_OPT_RESERVED, 1);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsCtxGetSysParamOpt(SYS_OPT_RESERVED, &val);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

inline void RunRtsCtxGetCurrentDefaultStreamCase()
{
    rtStream_t stream;
    rtError_t error = rtsCtxGetCurrentDefaultStream(&stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(stream, nullptr);
    error = rtsCtxGetCurrentDefaultStream(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

inline void RunContextThreadRefCountTracksBindingCase()
{
    rtContext_t ctxA = nullptr;
    rtContext_t ctxB = nullptr;
    int32_t devId = 0;
    ASSERT_EQ(rtGetDevice(&devId), RT_ERROR_NONE);

    ASSERT_EQ(rtsCtxCreate(&ctxA, 0, devId), RT_ERROR_NONE);
    Context* const ctxAPtr = static_cast<Context*>(ctxA);
    ASSERT_NE(ctxAPtr, nullptr);
    EXPECT_EQ(ctxAPtr->GetThreadRefCount(), 1U);

    ASSERT_EQ(rtsCtxCreate(&ctxB, 0, devId), RT_ERROR_NONE);
    Context* const ctxBPtr = static_cast<Context*>(ctxB);
    ASSERT_NE(ctxBPtr, nullptr);
    EXPECT_EQ(ctxAPtr->GetThreadRefCount(), 0U);
    EXPECT_EQ(ctxBPtr->GetThreadRefCount(), 1U);

    EXPECT_EQ(rtsCtxSetCurrent(ctxA), RT_ERROR_NONE);
    EXPECT_EQ(ctxAPtr->GetThreadRefCount(), 1U);
    EXPECT_EQ(ctxBPtr->GetThreadRefCount(), 0U);

    EXPECT_EQ(rtSetDevice(devId), RT_ERROR_NONE);
    EXPECT_EQ(ctxAPtr->GetThreadRefCount(), 0U);
    EXPECT_EQ(ctxBPtr->GetThreadRefCount(), 0U);

    EXPECT_EQ(rtCtxDestroy(ctxA), RT_ERROR_NONE);
    EXPECT_EQ(rtCtxDestroy(ctxB), RT_ERROR_NONE);

    // Pair the explicit rtSetDevice() above with rtDeviceReset() so that the
    // primary refObj count is restored to its pre-case value. Plan A keeps
    // rtDeviceReset on the ref-count release path, so leaving an unmatched
    // SetDevice would leak a primary reference into subsequent cases.
    EXPECT_EQ(rtDeviceReset(devId), RT_ERROR_NONE);
}

inline void RunDestroyedContextHandleRejectedCase()
{
    rtContext_t ctx = nullptr;
    int32_t devId = 0;
    ASSERT_EQ(rtGetDevice(&devId), RT_ERROR_NONE);
    ASSERT_EQ(rtsCtxCreate(&ctx, 0, devId), RT_ERROR_NONE);
    ASSERT_EQ(rtCtxDestroy(ctx), RT_ERROR_NONE);

    EXPECT_NE(rtCtxSetCurrent(ctx), RT_ERROR_NONE);
    EXPECT_NE(rtCtxDestroy(ctx), RT_ERROR_NONE);

    rtContext_t current = nullptr;
    EXPECT_EQ(rtCtxGetCurrent(&current), ACL_ERROR_RT_CONTEXT_NULL);
}

inline void RunFinalizingContextBlockedForUserButAllowedForInternalCase()
{
    rtContext_t ctx = nullptr;
    int32_t devId = 0;
    ASSERT_EQ(rtGetDevice(&devId), RT_ERROR_NONE);
    ASSERT_EQ(rtsCtxCreate(&ctx, 0, devId), RT_ERROR_NONE);

    Context* const ctxPtr = static_cast<Context*>(ctx);
    ASSERT_NE(ctxPtr, nullptr);
    EXPECT_EQ(ctxPtr->GetState(), ContextState::CTX_STATE_ACTIVE);
    ASSERT_TRUE(ctxPtr->TearDownIsCanExecute());
    EXPECT_EQ(ctxPtr->GetState(), ContextState::CTX_STATE_FINALIZING);

    rtError_t errorCode = RT_ERROR_NONE;
    EXPECT_FALSE(ContextManage::CheckContextIsValid(ctxPtr, ContextAccessMode::USER, &errorCode));
    EXPECT_EQ(errorCode, RT_ERROR_CONTEXT_DEL);

    errorCode = RT_ERROR_NONE;
    EXPECT_TRUE(ContextManage::CheckContextIsValid(ctxPtr, ContextAccessMode::INTERNAL, &errorCode));
    EXPECT_EQ(errorCode, RT_ERROR_NONE);
    EXPECT_EQ(ctxPtr->GetThreadRefCount(), 0U);

    ctxPtr->SetTearDownExecuteResult(TearDownStatus::TEARDOWN_ERROR);
    EXPECT_EQ(ctxPtr->GetState(), ContextState::CTX_STATE_ACTIVE);
    EXPECT_EQ(rtCtxDestroy(ctx), RT_ERROR_NONE);
}

inline bool IsPrimaryContextNotInitialized(const int32_t devId)
{
    uint32_t flag = 0U;
    int32_t state = 0;
    const rtError_t error = rtsGetPrimaryCtxState(devId, &flag, &state);
    EXPECT_EQ(error, RT_ERROR_NONE);
    return (error == RT_ERROR_NONE) && (state == static_cast<int32_t>(ContextState::CTX_STATE_NOT_INITIALIZED));
}

inline void ReleasePrimaryRefsForApiContextCase(const int32_t devId)
{
    constexpr uint32_t maxReleaseCount = 64U;
    for (uint32_t i = 0U; i < maxReleaseCount; ++i) {
        if (IsPrimaryContextNotInitialized(devId)) {
            return;
        }
        const rtError_t error = rtDeviceReset(devId);
        if (error == ACL_ERROR_RT_CONTEXT_NULL) {
            return;
        }
        ASSERT_EQ(error, RT_ERROR_NONE);
    }
    FAIL() << "primary context ref count was not released after " << maxReleaseCount << " resets";
}

inline void RunPrimaryContextResetKeepsObjectAndCanReinitCase()
{
    int32_t devId = 0;
    ASSERT_EQ(rtGetDevice(&devId), RT_ERROR_NONE);
    ASSERT_NO_FATAL_FAILURE(ReleasePrimaryRefsForApiContextCase(devId));
    ASSERT_EQ(rtSetDevice(devId), RT_ERROR_NONE);

    Runtime* const rt = Runtime::Instance();
    Context* const primaryBefore = rt->CurrentContext();
    ASSERT_NE(primaryBefore, nullptr);
    ASSERT_TRUE(primaryBefore->IsPrimary());
    EXPECT_EQ(primaryBefore->GetState(), ContextState::CTX_STATE_ACTIVE);

    ASSERT_EQ(rtDeviceReset(devId), RT_ERROR_NONE);
    EXPECT_EQ(primaryBefore->GetState(), ContextState::CTX_STATE_NOT_INITIALIZED);
    EXPECT_TRUE(ContextManage::IsContextTracked(primaryBefore));

    rtContext_t current = nullptr;
    EXPECT_EQ(rtCtxGetCurrent(&current), ACL_ERROR_RT_CONTEXT_NULL);
    EXPECT_EQ(current, nullptr);

    ASSERT_EQ(rtSetDevice(devId), RT_ERROR_NONE);
    Context* const primaryAfter = rt->CurrentContext();
    ASSERT_NE(primaryAfter, nullptr);
    EXPECT_EQ(primaryAfter, primaryBefore);
    EXPECT_EQ(primaryAfter->GetState(), ContextState::CTX_STATE_ACTIVE);
}

inline void RunPrimaryRefCountReleaseSemanticsCase()
{
    int32_t devId = 0;
    ASSERT_EQ(rtGetDevice(&devId), RT_ERROR_NONE);
    ASSERT_NO_FATAL_FAILURE(ReleasePrimaryRefsForApiContextCase(devId));
    ASSERT_EQ(rtSetDevice(devId), RT_ERROR_NONE);

    Runtime* const rt = Runtime::Instance();
    Context* const primary = rt->CurrentContext();
    ASSERT_NE(primary, nullptr);
    ASSERT_TRUE(primary->IsPrimary());
    EXPECT_EQ(primary->GetState(), ContextState::CTX_STATE_ACTIVE);

    ASSERT_EQ(rtSetDevice(devId), RT_ERROR_NONE);
    ASSERT_EQ(rtSetDevice(devId), RT_ERROR_NONE);

    ASSERT_EQ(rtDeviceReset(devId), RT_ERROR_NONE);
    EXPECT_EQ(primary->GetState(), ContextState::CTX_STATE_ACTIVE);
    EXPECT_EQ(rt->CurrentContext(), primary);

    ASSERT_EQ(rtDeviceReset(devId), RT_ERROR_NONE);
    EXPECT_EQ(primary->GetState(), ContextState::CTX_STATE_ACTIVE);

    ASSERT_EQ(rtDeviceReset(devId), RT_ERROR_NONE);
    EXPECT_EQ(primary->GetState(), ContextState::CTX_STATE_NOT_INITIALIZED);
    EXPECT_TRUE(ContextManage::IsContextTracked(primary));

    ASSERT_EQ(rtSetDevice(devId), RT_ERROR_NONE);
    EXPECT_EQ(rt->CurrentContext(), primary);
    EXPECT_EQ(primary->GetState(), ContextState::CTX_STATE_ACTIVE);
}

inline void RunResetDeviceForceTearsDownRegardlessOfRefCountCase()
{
    int32_t devId = 0;
    ASSERT_EQ(rtGetDevice(&devId), RT_ERROR_NONE);
    ASSERT_EQ(rtSetDevice(devId), RT_ERROR_NONE);
    ASSERT_EQ(rtSetDevice(devId), RT_ERROR_NONE);

    Context* const primary = Runtime::Instance()->CurrentContext();
    ASSERT_NE(primary, nullptr);
    ASSERT_TRUE(primary->IsPrimary());
    EXPECT_EQ(primary->GetState(), ContextState::CTX_STATE_ACTIVE);

    ASSERT_EQ(rtDeviceResetForce(devId), RT_ERROR_NONE);
    EXPECT_EQ(primary->GetState(), ContextState::CTX_STATE_NOT_INITIALIZED);
    EXPECT_TRUE(ContextManage::IsContextTracked(primary));
}

inline void RunDeviceResetDoesNotDestroyExplicitContextCase()
{
    rtContext_t ctx = nullptr;
    int32_t devId = 0;
    ASSERT_EQ(rtGetDevice(&devId), RT_ERROR_NONE);
    ASSERT_EQ(rtsCtxCreate(&ctx, 0, devId), RT_ERROR_NONE);

    Context* const ctxPtr = static_cast<Context*>(ctx);
    ASSERT_NE(ctxPtr, nullptr);
    ASSERT_FALSE(ctxPtr->IsPrimary());
    EXPECT_EQ(ctxPtr->GetState(), ContextState::CTX_STATE_ACTIVE);

    ASSERT_EQ(rtDeviceReset(devId), RT_ERROR_NONE);
    EXPECT_EQ(ctxPtr->GetState(), ContextState::CTX_STATE_ACTIVE);
    EXPECT_TRUE(ContextManage::IsContextTracked(ctxPtr));

    rtContext_t current = nullptr;
    EXPECT_EQ(rtCtxGetCurrent(&current), RT_ERROR_NONE);
    EXPECT_EQ(current, ctx);
    EXPECT_EQ(rtCtxSetCurrent(ctx), RT_ERROR_NONE);

    EXPECT_EQ(rtCtxDestroy(ctx), RT_ERROR_NONE);
    EXPECT_FALSE(ContextManage::IsContextTracked(ctxPtr));
}

} // namespace ut
} // namespace runtime
} // namespace cce

#define RT_UTEST_API_CONTEXT_FIXTURE(test_fixture, setup_msg, teardown_msg)        \
    class test_fixture : public cce::runtime::ut::ApiContextTestBase {             \
    protected:                                                                     \
        static void SetUpTestCase() { std::cout << setup_msg << std::endl; }       \
                                                                                   \
        static void TearDownTestCase() { std::cout << teardown_msg << std::endl; } \
    };

#define RT_UTEST_API_CONTEXT_CASES(test_fixture)                                                                    \
    TEST_F(test_fixture, TestRtsCtxDestroy) { cce::runtime::ut::RunRtsCtxDestroyCase(); }                           \
                                                                                                                    \
    TEST_F(test_fixture, TestRtsCtxGetAndSetCurrent) { cce::runtime::ut::RunRtsCtxGetAndSetCurrentCase(); }         \
                                                                                                                    \
    TEST_F(test_fixture, TestRtsGetPrimaryCtxState) { cce::runtime::ut::RunRtsGetPrimaryCtxStateCase(); }           \
                                                                                                                    \
    TEST_F(test_fixture, TestRtsCtxGetAndSetSysParamOpt) { cce::runtime::ut::RunRtsCtxGetAndSetSysParamOptCase(); } \
                                                                                                                    \
    TEST_F(test_fixture, TestRtsCtxGetCurrentDefaultStream)                                                         \
    {                                                                                                               \
        cce::runtime::ut::RunRtsCtxGetCurrentDefaultStreamCase();                                                   \
    }                                                                                                               \
                                                                                                                    \
    TEST_F(test_fixture, TestContextThreadRefCountTracksBinding)                                                    \
    {                                                                                                               \
        cce::runtime::ut::RunContextThreadRefCountTracksBindingCase();                                              \
    }                                                                                                               \
                                                                                                                    \
    TEST_F(test_fixture, TestDestroyedContextHandleRejected)                                                        \
    {                                                                                                               \
        cce::runtime::ut::RunDestroyedContextHandleRejectedCase();                                                  \
    }                                                                                                               \
                                                                                                                    \
    TEST_F(test_fixture, TestFinalizingContextBlockedForUserButAllowedForInternal)                                  \
    {                                                                                                               \
        cce::runtime::ut::RunFinalizingContextBlockedForUserButAllowedForInternalCase();                            \
    }                                                                                                               \
                                                                                                                    \
    TEST_F(test_fixture, TestPrimaryContextResetKeepsObjectAndCanReinit)                                            \
    {                                                                                                               \
        cce::runtime::ut::RunPrimaryContextResetKeepsObjectAndCanReinitCase();                                      \
    }                                                                                                               \
                                                                                                                    \
    TEST_F(test_fixture, TestPrimaryRefCountReleaseSemantics)                                                       \
    {                                                                                                               \
        cce::runtime::ut::RunPrimaryRefCountReleaseSemanticsCase();                                                 \
    }                                                                                                               \
                                                                                                                    \
    TEST_F(test_fixture, TestResetDeviceForceTearsDownRegardlessOfRefCount)                                         \
    {                                                                                                               \
        cce::runtime::ut::RunResetDeviceForceTearsDownRegardlessOfRefCountCase();                                   \
    }                                                                                                               \
                                                                                                                    \
    TEST_F(test_fixture, TestDeviceResetDoesNotDestroyExplicitContext)                                              \
    {                                                                                                               \
        cce::runtime::ut::RunDeviceResetDoesNotDestroyExplicitContextCase();                                        \
    }

#endif // TESTS_UT_RUNTIME_RUNTIME_TEST_COMMON_RT_UTEST_API_CONTEXT_CASES_HPP_
