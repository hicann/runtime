/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef MATH_UTILS_H
#define MATH_UTILS_H

#include <climits>
#include "acl/acl_base.h"
#include "common/log_inner.h"

namespace acl {

inline aclError CheckSizeTMultiOverflow(const size_t a, const size_t b, size_t &res)
{
    if ((a != 0U) && (b != 0U) && ((SIZE_MAX / a) < b)) {
        ACL_LOG_ERROR("[Check][Overflow]%zu multiplies %zu overflow", a, b);
        return ACL_ERROR_FAILURE;
    }
    res = a * b;
    return ACL_SUCCESS;
}

inline aclError CheckUint32MultiOverflow(const uint32_t a, const uint32_t b, uint32_t &res)
{
    if ((a != 0U) && (b != 0U) && ((UINT32_MAX / a) < b)) {
        ACL_LOG_ERROR("[Check][Overflow]%u multiplies %u overflow", a, b);
        return ACL_ERROR_FAILURE;
    }
    res = a * b;
    return ACL_SUCCESS;
}

inline aclError CheckIntAddOverflow(const int32_t a, const int32_t b, int32_t &res)
{
    if (((b > 0) && (a > (INT_MAX - b))) || ((b < 0) && (a < (INT_MIN - b)))) {
        ACL_LOG_ERROR("[Check][Overflow]%d adds %d overflow", a, b);
        return ACL_ERROR_FAILURE;
    }
    res = a + b;
    return ACL_SUCCESS;
}

inline aclError CheckSizeTAddOverflow(const size_t a, const size_t b, size_t &res)
{
    if (a > (SIZE_MAX - b)) {
        ACL_LOG_ERROR("[Check][Overflow]%zu adds %zu overflow", a, b);
        return ACL_ERROR_FAILURE;
    }
    res = a + b;
    return ACL_SUCCESS;
}

inline aclError CheckUint32AddOverflow(const uint32_t a, const uint32_t b, uint32_t &res)
{
    if (a > (UINT32_MAX - b)) {
        ACL_LOG_ERROR("[Check][Overflow]%u adds %u overflow", a, b);
        return ACL_ERROR_FAILURE;
    }
    res = a + b;
    return ACL_SUCCESS;
}
} // namespace acl

#define ACL_CHECK_ASSIGN_SIZET_MULTI(a, b, res)                      \
    do {                                                             \
            const aclError ret = acl::CheckSizeTMultiOverflow((a), (b), (res));  \
            if (ret != ACL_SUCCESS) {                             \
                return ret;                                          \
            }                                                        \
    } while (false)

#define ACL_CHECK_ASSIGN_SIZET_MULTI_RET_NUM(a, b, res)                      \
    do {                                                             \
            const aclError ret = acl::CheckSizeTMultiOverflow((a), (b), (res));  \
            if (ret != ACL_SUCCESS) {                             \
                return 0U;                                          \
            }                                                       \
    } while (false)

#define ACL_CHECK_ASSIGN_UINT32_MULTI(a, b, res)                      \
    do {                                                             \
            const aclError ret = acl::CheckUint32MultiOverflow((a), (b), (res));  \
            if (ret != ACL_SUCCESS) {                             \
                return ret;                                          \
            }                                                        \
    } while (false)

#define ACL_CHECK_ASSIGN_INT32_ADD(a, b, res)                        \
    do {                                                             \
            const aclError ret = acl::CheckIntAddOverflow((a), (b), (res));      \
            if (ret != ACL_SUCCESS) {                             \
                return ret;                                          \
            }                                                        \
    } while (false)

#define ACL_CHECK_ASSIGN_SIZET_ADD(a, b, res)                       \
    do {                                                            \
            const aclError ret = acl::CheckSizeTAddOverflow((a), (b), (res));   \
            if (ret != ACL_SUCCESS) {                            \
                return ret;                                         \
            }                                                       \
    } while (false)

#define ACL_CHECK_ASSIGN_UINT32T_ADD(a, b, res)                       \
    do {                                                            \
            const aclError ret = acl::CheckUint32AddOverflow((a), (b), (res));   \
            if (ret != ACL_SUCCESS) {                            \
                return ret;                                         \
            }                                                       \
    } while (false)

#endif // MATH_UTILS_H
