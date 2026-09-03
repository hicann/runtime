/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "acl/acl_rt.h"
#include "acl/acl_rt_allocator.h"

#if __GNUC__ >= 8
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wcast-function-type"
#endif // __GNUC__ >= 8
#include <gtest/gtest.h>

using namespace std;

namespace {
// Sentinel return values to detect which function was actually invoked.
const aclError HOOK_RET_VALUE = static_cast<aclError>(999991);
const aclError CHAIN_INNER_RET = static_cast<aclError>(999992);
const aclError CHAIN_OUTER_RET = static_cast<aclError>(999993);

// Signature of aclrtGetDevice for hook testing: a simple query api.
// aclError aclrtGetDevice(int32_t *deviceId);
typedef aclError (*AclrtGetDeviceFunc)(int32_t* deviceId);

// A dummy hook that writes a sentinel value and returns HOOK_RET_VALUE.
aclError DummyGetDeviceHook(int32_t* deviceId)
{
    if (deviceId != nullptr) {
        *deviceId = -1;
    }
    return HOOK_RET_VALUE;
}

// Inner (first-registered) hook for chain test: returns CHAIN_INNER_RET.
aclError ChainInnerHook(int32_t* deviceId)
{
    if (deviceId != nullptr) {
        *deviceId = -2;
    }
    return CHAIN_INNER_RET;
}

// Outer (second-registered) hook for chain test: calls prevFunc then returns its own sentinel.
// This mimics the multi-tool chain pattern from the design doc.
aclrtApiFunc g_chainOuterPrev = nullptr;
aclError ChainOuterHook(int32_t* deviceId)
{
    // Call the previous function in the chain (inner hook or original).
    if (g_chainOuterPrev != nullptr) {
        (void)((AclrtGetDeviceFunc)(void*)g_chainOuterPrev)(deviceId);
    }
    return CHAIN_OUTER_RET;
}
} // namespace

class UTEST_AclRtApiHook : public testing::Test {
protected:
    void SetUp() override
    {
        // Ensure clean state: restore aclrtGetDevice to its original implementation
        // before each test, in case a previous test left a hook installed.
        aclrtApiFunc originFunc = nullptr;
        aclrtApiFunc currentFunc = nullptr;
        aclError ret = aclrtApiInjectionGetFunc("aclrtGetDevice", &originFunc, &currentFunc);
        ASSERT_EQ(ret, ACL_SUCCESS) << "GetFunc should succeed for a valid hookable api";
        if (currentFunc != originFunc) {
            // Restore original to ensure test isolation.
            aclError setRet = aclrtApiInjectionSetFunc("aclrtGetDevice", originFunc);
            ASSERT_EQ(setRet, ACL_SUCCESS);
        }
    }
    void TearDown() override {}
};

// Initial state: originFunc == currentFunc for every hookable api.
TEST_F(UTEST_AclRtApiHook, GetFuncInitialStateOriginEqualsCurrent)
{
    aclrtApiFunc originFunc = nullptr;
    aclrtApiFunc currentFunc = nullptr;
    aclError ret = aclrtApiInjectionGetFunc("aclrtGetDevice", &originFunc, &currentFunc);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(originFunc, nullptr);
    EXPECT_EQ(originFunc, currentFunc);
}

// Hook takes effect: after SetFunc, calling the api routes to the hook function.
TEST_F(UTEST_AclRtApiHook, SetFuncRedirectsApiCallToHook)
{
    aclrtApiFunc originFunc = nullptr;
    aclrtApiFunc currentFunc = nullptr;
    ASSERT_EQ(aclrtApiInjectionGetFunc("aclrtGetDevice", &originFunc, &currentFunc), ACL_SUCCESS);

    // Install hook.
    aclError ret = aclrtApiInjectionSetFunc("aclrtGetDevice", (aclrtApiFunc)DummyGetDeviceHook);
    EXPECT_EQ(ret, ACL_SUCCESS);

    // Verify GetFunc reflects the change.
    aclrtApiFunc newCurrent = nullptr;
    ASSERT_EQ(aclrtApiInjectionGetFunc("aclrtGetDevice", nullptr, &newCurrent), ACL_SUCCESS);
    EXPECT_EQ(newCurrent, (aclrtApiFunc)DummyGetDeviceHook);
    // originFunc must remain unchanged.
    aclrtApiFunc newOrigin = nullptr;
    ASSERT_EQ(aclrtApiInjectionGetFunc("aclrtGetDevice", &newOrigin, nullptr), ACL_SUCCESS);
    EXPECT_EQ(newOrigin, originFunc);

    // Calling aclrtGetDevice should now invoke the hook, returning our sentinel.
    int32_t deviceId = 42;
    aclError callRet = aclrtGetDevice(&deviceId);
    EXPECT_EQ(callRet, HOOK_RET_VALUE);
    EXPECT_EQ(deviceId, -1);

    // Restore.
    ASSERT_EQ(aclrtApiInjectionSetFunc("aclrtGetDevice", originFunc), ACL_SUCCESS);
}

// Restore: after SetFunc(originFunc), api call returns to original behavior.
TEST_F(UTEST_AclRtApiHook, RestoreOriginalFuncResetsRouting)
{
    aclrtApiFunc originFunc = nullptr;
    ASSERT_EQ(aclrtApiInjectionGetFunc("aclrtGetDevice", &originFunc, nullptr), ACL_SUCCESS);

    // Hook then restore.
    ASSERT_EQ(aclrtApiInjectionSetFunc("aclrtGetDevice", (aclrtApiFunc)DummyGetDeviceHook), ACL_SUCCESS);
    ASSERT_EQ(aclrtApiInjectionSetFunc("aclrtGetDevice", originFunc), ACL_SUCCESS);

    // Verify currentFunc == originFunc again.
    aclrtApiFunc currentFunc = nullptr;
    ASSERT_EQ(aclrtApiInjectionGetFunc("aclrtGetDevice", nullptr, &currentFunc), ACL_SUCCESS);
    EXPECT_EQ(currentFunc, originFunc);
}

// Multi-tool chain: second tool saves currentFunc as prevFunc, enabling chain calls.
TEST_F(UTEST_AclRtApiHook, MultiToolChainHook)
{
    aclrtApiFunc originFunc = nullptr;
    ASSERT_EQ(aclrtApiInjectionGetFunc("aclrtGetDevice", &originFunc, nullptr), ACL_SUCCESS);

    // Tool1 (inner) registers first.
    ASSERT_EQ(aclrtApiInjectionSetFunc("aclrtGetDevice", (aclrtApiFunc)ChainInnerHook), ACL_SUCCESS);

    // Tool2 (outer) reads current, saves as prev, then installs itself.
    aclrtApiFunc current = nullptr;
    ASSERT_EQ(aclrtApiInjectionGetFunc("aclrtGetDevice", nullptr, &current), ACL_SUCCESS);
    g_chainOuterPrev = current;
    ASSERT_EQ(aclrtApiInjectionSetFunc("aclrtGetDevice", (aclrtApiFunc)ChainOuterHook), ACL_SUCCESS);

    // Call aclrtGetDevice: outer hook runs first, calls prev (inner hook), then returns CHAIN_OUTER_RET.
    int32_t deviceId = 0;
    aclError ret = aclrtGetDevice(&deviceId);
    EXPECT_EQ(ret, CHAIN_OUTER_RET); // outer's return value wins
    EXPECT_EQ(deviceId, -2);         // inner hook set deviceId before outer returned

    // Teardown: unregister outer (restore to inner), then unregister inner (restore to original).
    ASSERT_EQ(aclrtApiInjectionSetFunc("aclrtGetDevice", g_chainOuterPrev), ACL_SUCCESS);
    ASSERT_EQ(aclrtApiInjectionSetFunc("aclrtGetDevice", originFunc), ACL_SUCCESS);
    g_chainOuterPrev = nullptr;
}

// Invalid api name returns ACL_ERROR_INVALID_PARAM.
TEST_F(UTEST_AclRtApiHook, GetFuncInvalidApiNameReturnsInvalidParam)
{
    aclrtApiFunc originFunc = nullptr;
    aclrtApiFunc currentFunc = nullptr;
    aclError ret = aclrtApiInjectionGetFunc("aclrtNonExistentApi", &originFunc, &currentFunc);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

// Invalid api name for SetFunc also returns ACL_ERROR_INVALID_PARAM.
TEST_F(UTEST_AclRtApiHook, SetFuncInvalidApiNameReturnsInvalidParam)
{
    aclError ret = aclrtApiInjectionSetFunc("aclrtNonExistentApi", (aclrtApiFunc)DummyGetDeviceHook);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

// Null name for GetFunc returns ACL_ERROR_INVALID_PARAM.
TEST_F(UTEST_AclRtApiHook, GetFuncNullNameReturnsInvalidParam)
{
    aclrtApiFunc originFunc = nullptr;
    aclrtApiFunc currentFunc = nullptr;
    aclError ret = aclrtApiInjectionGetFunc(nullptr, &originFunc, &currentFunc);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

// Null name for SetFunc returns ACL_ERROR_INVALID_PARAM (FindHookEntryByName rejects nullptr).
TEST_F(UTEST_AclRtApiHook, SetFuncNullNameReturnsInvalidParam)
{
    aclError ret = aclrtApiInjectionSetFunc(nullptr, (aclrtApiFunc)DummyGetDeviceHook);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

// Null func for SetFunc returns ACL_ERROR_INVALID_PARAM.
TEST_F(UTEST_AclRtApiHook, SetFuncNullFuncReturnsInvalidParam)
{
    aclError ret = aclrtApiInjectionSetFunc("aclrtGetDevice", nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

// Non-hookable api (aclInit is in ACL_FUNC_MAP, not in hook scope) returns invalid param.
TEST_F(UTEST_AclRtApiHook, NonHookableApiReturnsInvalidParam)
{
    aclrtApiFunc originFunc = nullptr;
    aclrtApiFunc currentFunc = nullptr;
    // aclInit is in ACL_FUNC_MAP (not ACL_RT_FUNC_MAP / ACL_RT_ALLOCATOR_FUNC_MAP / ACL_MDLRI_FUNC_MAP), so not
    // hookable.
    aclError ret = aclrtApiInjectionGetFunc("aclInit", &originFunc, &currentFunc);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

// originFunc/currentFunc output nullptrs are tolerated (skipped, not written).
TEST_F(UTEST_AclRtApiHook, GetFuncNullOutputsSucceeds)
{
    aclError ret = aclrtApiInjectionGetFunc("aclrtGetDevice", nullptr, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

// Multi-API hook: verify that hooking different APIs from different func maps works independently.
TEST_F(UTEST_AclRtApiHook, MultiApiHookFromDifferentFuncMaps)
{
    // aclrtGetSocName is in ACL_RT_FUNC_MAP, returns const char*.
    aclrtApiFunc socOrigin = nullptr;
    aclrtApiFunc socCurrent = nullptr;
    ASSERT_EQ(aclrtApiInjectionGetFunc("aclrtGetSocName", &socOrigin, &socCurrent), ACL_SUCCESS);
    EXPECT_NE(socOrigin, nullptr);
    EXPECT_EQ(socOrigin, socCurrent);

    // aclrtAllocatorCreateDesc is in ACL_RT_ALLOCATOR_FUNC_MAP, returns aclrtAllocatorDesc (void*).
    aclrtApiFunc allocOrigin = nullptr;
    aclrtApiFunc allocCurrent = nullptr;
    ASSERT_EQ(aclrtApiInjectionGetFunc("aclrtAllocatorCreateDesc", &allocOrigin, &allocCurrent), ACL_SUCCESS);
    EXPECT_NE(allocOrigin, nullptr);
    EXPECT_EQ(allocOrigin, allocCurrent);

    // aclmdlRIDestroy is in ACL_MDLRI_FUNC_MAP, returns aclError.
    aclrtApiFunc mdlOrigin = nullptr;
    aclrtApiFunc mdlCurrent = nullptr;
    ASSERT_EQ(aclrtApiInjectionGetFunc("aclmdlRIDestroy", &mdlOrigin, &mdlCurrent), ACL_SUCCESS);
    EXPECT_NE(mdlOrigin, nullptr);
    EXPECT_EQ(mdlOrigin, mdlCurrent);

    // Verify the three APIs have distinct entries.
    EXPECT_NE(socOrigin, allocOrigin);
    EXPECT_NE(socOrigin, mdlOrigin);
    EXPECT_NE(allocOrigin, mdlOrigin);
}

// Hook an allocator API and verify it redirects.
TEST_F(UTEST_AclRtApiHook, AllocatorApiHookRedirects)
{
    aclrtApiFunc origin = nullptr;
    ASSERT_EQ(aclrtApiInjectionGetFunc("aclrtAllocatorDestroyDesc", &origin, nullptr), ACL_SUCCESS);
    EXPECT_NE(origin, nullptr);

    ASSERT_EQ(aclrtApiInjectionSetFunc("aclrtAllocatorDestroyDesc", (aclrtApiFunc)DummyGetDeviceHook), ACL_SUCCESS);

    aclrtApiFunc current = nullptr;
    ASSERT_EQ(aclrtApiInjectionGetFunc("aclrtAllocatorDestroyDesc", nullptr, &current), ACL_SUCCESS);
    EXPECT_EQ(current, (aclrtApiFunc)DummyGetDeviceHook);

    aclError callRet = aclrtAllocatorDestroyDesc(nullptr);
    EXPECT_EQ(callRet, HOOK_RET_VALUE);

    ASSERT_EQ(aclrtApiInjectionSetFunc("aclrtAllocatorDestroyDesc", origin), ACL_SUCCESS);
}

// Hook an mdlRI API and verify it redirects.
TEST_F(UTEST_AclRtApiHook, MdlRiApiHookRedirects)
{
    aclrtApiFunc origin = nullptr;
    ASSERT_EQ(aclrtApiInjectionGetFunc("aclmdlRIDestroy", &origin, nullptr), ACL_SUCCESS);
    EXPECT_NE(origin, nullptr);

    ASSERT_EQ(aclrtApiInjectionSetFunc("aclmdlRIDestroy", (aclrtApiFunc)DummyGetDeviceHook), ACL_SUCCESS);

    aclrtApiFunc current = nullptr;
    ASSERT_EQ(aclrtApiInjectionGetFunc("aclmdlRIDestroy", nullptr, &current), ACL_SUCCESS);
    EXPECT_EQ(current, (aclrtApiFunc)DummyGetDeviceHook);

    aclError callRet = aclmdlRIDestroy(nullptr);
    EXPECT_EQ(callRet, HOOK_RET_VALUE);

    ASSERT_EQ(aclrtApiInjectionSetFunc("aclmdlRIDestroy", origin), ACL_SUCCESS);
}

#if __GNUC__ >= 8
#pragma GCC diagnostic pop
#endif // __GNUC__ >= 8
