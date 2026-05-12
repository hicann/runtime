/**
* Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef UTIL_MSTX_H_
#define UTIL_MSTX_H_

#include <cstdio>

#define CHECK_RET(cond, return_expr) \
    do {                             \
        if (!(cond)) {               \
            return_expr;             \
        }                            \
    } while (0)

#define LOG_PRINT(message, ...)         \
    do {                                \
        printf(message, ##__VA_ARGS__); \
    } while (0)

#define ACL_CALL(acl_func_call)                                                 \
    do {                                                                        \
        auto ret = acl_func_call;                                               \
        if (ret != ACL_SUCCESS) {                                               \
            LOG_PRINT("%s call failed, error code: %d\n", #acl_func_call, ret); \
            return ret;                                                         \
        }                                                                       \
    } while (0)

#endif // UTIL_MSTX_H_