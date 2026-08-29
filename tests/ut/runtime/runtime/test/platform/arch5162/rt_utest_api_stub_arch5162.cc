/*
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstddef>
#include <cstdint>
#include <type_traits>
#include <unistd.h>

#include "acl/acl.h"
#include "acl/acl_rt_allocator.h"
#include "acl/acl_rt_memory_soma.h"
#include "gtest/gtest.h"

namespace {
alignas(std::max_align_t) uint8_t g_defaultArgumentStorage[4096] = {1U};

void DefaultCallback() {}

aclrtPhysicalMemProp* ValidPhysicalMemProp()
{
    static aclrtPhysicalMemProp prop{};
    prop = {};
    prop.handleType = ACL_MEM_HANDLE_TYPE_NONE;
    prop.allocationType = ACL_MEM_ALLOCATION_TYPE_PINNED;
    prop.memAttr = ACL_DDR_MEM_NORMAL;
    prop.location.type = ACL_MEM_LOCATION_TYPE_HOST;
    return &prop;
}

const aclrtMemPoolProps* ValidMemPoolProps()
{
    static aclrtMemPoolProps props{};
    props = {};
    props.allocType = ACL_MEM_ALLOCATION_TYPE_PINNED;
    props.handleType = ACL_MEM_HANDLE_TYPE_NONE;
    props.location.type = ACL_MEM_LOCATION_TYPE_DEVICE;
    return &props;
}

const void** ValidManagedPointers()
{
    static const void* pointers[] = {g_defaultArgumentStorage};
    return pointers;
}

size_t* ValidManagedSizes()
{
    static size_t sizes[] = {1U};
    return sizes;
}

aclrtMemManagedLocation* ValidManagedLocations()
{
    static aclrtMemManagedLocation locations[] = {{ACL_MEM_LOCATIONTYPE_DEVICE, 0}};
    return locations;
}

size_t* ValidManagedLocationIndexes()
{
    static size_t indexes[] = {0U};
    return indexes;
}

template <typename T>
typename std::enable_if<std::is_arithmetic<T>::value || std::is_enum<T>::value, T>::type DefaultAclArgument()
{
    return static_cast<T>(1);
}

template <typename T>
typename std::enable_if<
    !std::is_arithmetic<T>::value && !std::is_enum<T>::value && !std::is_pointer<T>::value &&
        !std::is_reference<T>::value,
    T>::type
DefaultAclArgument()
{
    return T{};
}

template <typename T>
typename std::enable_if<
    std::is_pointer<T>::value && !std::is_function<typename std::remove_pointer<T>::type>::value, T>::type
DefaultAclArgument()
{
    return reinterpret_cast<T>(g_defaultArgumentStorage);
}

template <typename T>
typename std::enable_if<
    std::is_pointer<T>::value && std::is_function<typename std::remove_pointer<T>::type>::value, T>::type
DefaultAclArgument()
{
    return reinterpret_cast<T>(&DefaultCallback);
}

template <typename T>
typename std::enable_if<std::is_lvalue_reference<T>::value, T>::type DefaultAclArgument()
{
    static typename std::remove_reference<T>::type value{};
    return value;
}

template <typename ReturnType, typename... Args>
ReturnType InvokeAclWithDefaultArguments(ReturnType (*api)(Args...))
{
    return api(DefaultAclArgument<Args>()...);
}
} // namespace

#define ARCH5162_UNSUPPORTED_ACL_API(aclApi, runtimeApi)                                     \
    TEST(Arch5162AclApiStubTest, aclApi)                                                     \
    {                                                                                        \
        SCOPED_TRACE("Runtime blocker: " #runtimeApi);                                       \
        EXPECT_EQ(InvokeAclWithDefaultArguments(&aclApi), ACL_ERROR_RT_FEATURE_NOT_SUPPORT); \
    }

#define ARCH5162_UNSUPPORTED_ACL_API_WITH_ARGS(aclApi, runtimeApi, args) \
    TEST(Arch5162AclApiStubTest, aclApi)                                 \
    {                                                                    \
        SCOPED_TRACE("Runtime blocker: " #runtimeApi);                   \
        EXPECT_EQ(aclApi args, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);        \
    }

#define ARCH5162_UNSUPPORTED_ACL_API_WITH_EXPECTED(aclApi, runtimeApi, expected) \
    TEST(Arch5162AclApiStubTest, aclApi)                                         \
    {                                                                            \
        SCOPED_TRACE("Runtime blocker: " #runtimeApi);                           \
        EXPECT_EQ(InvokeAclWithDefaultArguments(&aclApi), expected);             \
    }

#define ARCH5162_UNSUPPORTED_ACL_API_WITH_ARGS_AND_EXPECTED(aclApi, runtimeApi, args, expected) \
    TEST(Arch5162AclApiStubTest, aclApi)                                                        \
    {                                                                                           \
        SCOPED_TRACE("Runtime blocker: " #runtimeApi);                                          \
        EXPECT_EQ(aclApi args, expected);                                                       \
    }

#define ARCH5162_UNSUPPORTED_ACL_POINTER_API_WITH_ARGS(aclApi, runtimeApi, args) \
    TEST(Arch5162AclApiStubTest, aclApi)                                         \
    {                                                                            \
        SCOPED_TRACE("Runtime blocker: " #runtimeApi);                           \
        EXPECT_EQ(aclApi args, nullptr);                                         \
    }

#include "arch5162_unsupported_acl_api.def"

#undef ARCH5162_UNSUPPORTED_ACL_API
#undef ARCH5162_UNSUPPORTED_ACL_API_WITH_ARGS
#undef ARCH5162_UNSUPPORTED_ACL_API_WITH_EXPECTED
#undef ARCH5162_UNSUPPORTED_ACL_API_WITH_ARGS_AND_EXPECTED
#undef ARCH5162_UNSUPPORTED_ACL_POINTER_API_WITH_ARGS
