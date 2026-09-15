/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <type_traits>

#include "aclrt/set_device_vxx.h"
#include "acl_rt_impl.h"
#include "gtest/gtest.h"

namespace {
template <aclError expectedValue>
struct AclErrorPolicy {
    template <typename ReturnType>
    static ReturnType Expected()
    {
        return static_cast<ReturnType>(expectedValue);
    }
};

using RtFeatureNotSupportPolicy = AclErrorPolicy<ACL_ERROR_RT_FEATURE_NOT_SUPPORT>;
using AclFeatureUnsupportedPolicy = AclErrorPolicy<ACL_ERROR_FEATURE_UNSUPPORTED>;

struct NullptrPolicy {
    template <typename ReturnType>
    static ReturnType Expected()
    {
        return nullptr;
    }
};

struct ZeroPolicy {
    template <typename ReturnType>
    static ReturnType Expected()
    {
        return ReturnType{};
    }
};

struct VoidNoopPolicy {};

template <typename T>
typename std::enable_if<!std::is_reference<T>::value, T>::type DefaultArgument()
{
    return T{};
}

template <typename T>
typename std::enable_if<std::is_lvalue_reference<T>::value, T>::type DefaultArgument()
{
    static typename std::remove_reference<T>::type value{};
    return value;
}

template <typename ReturnType, typename... Args>
ReturnType InvokeWithDefaultArguments(ReturnType (*api)(Args...))
{
    return api(DefaultArgument<Args>()...);
}

template <typename Policy, typename ReturnType, typename... Args>
void VerifyStub(Policy, ReturnType (*impl)(Args...), ReturnType (*api)(Args...))
{
    const ReturnType expected = Policy::template Expected<ReturnType>();
    EXPECT_EQ(InvokeWithDefaultArguments(impl), expected);
    EXPECT_EQ(InvokeWithDefaultArguments(api), expected);
}

template <typename... Args>
void VerifyStub(VoidNoopPolicy, void (*impl)(Args...), void (*api)(Args...))
{
    InvokeWithDefaultArguments(impl);
    InvokeWithDefaultArguments(api);
}
} // namespace

#define ACL_STUB_POLICY_RT_FEATURE_NOT_SUPPORT RtFeatureNotSupportPolicy
#define ACL_STUB_POLICY_ACL_FEATURE_UNSUPPORTED AclFeatureUnsupportedPolicy
#define ACL_STUB_POLICY_NULLPTR NullptrPolicy
#define ACL_STUB_POLICY_ZERO ZeroPolicy
#define ACL_STUB_POLICY_VOID_NOOP VoidNoopPolicy
#define ACL_STUB_POLICY_INNER(policy) ACL_STUB_POLICY_##policy
#define ACL_STUB_POLICY(policy) ACL_STUB_POLICY_INNER(policy)
#define ACL_API_CATALOG_VERSION(version)
#define ACL_API_REAL_PROVIDER_COUNT(count)
#define ACL_API_STUB(name, policy) \
    TEST(Arch5162AclEntryStubTest, name) { VerifyStub(ACL_STUB_POLICY(policy){}, &name##Impl, &name); }

#include <arch5162_unsupported_acl_api.def>

#undef ACL_API_STUB
#undef ACL_API_REAL_PROVIDER_COUNT
#undef ACL_API_CATALOG_VERSION
#undef ACL_STUB_POLICY
#undef ACL_STUB_POLICY_INNER
#undef ACL_STUB_POLICY_VOID_NOOP
#undef ACL_STUB_POLICY_ZERO
#undef ACL_STUB_POLICY_NULLPTR
#undef ACL_STUB_POLICY_ACL_FEATURE_UNSUPPORTED
#undef ACL_STUB_POLICY_RT_FEATURE_NOT_SUPPORT
