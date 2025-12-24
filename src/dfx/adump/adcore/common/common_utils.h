/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ADX_COMMON_UTILS_H
#define ADX_COMMON_UTILS_H
#include <memory>
namespace Adx {
constexpr uint64_t DUMP_STATS_MAX = 1U << 0;
constexpr uint64_t DUMP_STATS_MIN = 1U << 1;
constexpr uint64_t DUMP_STATS_AVG = 1U << 2;
constexpr uint64_t DUMP_STATS_NAN = 1U << 3;
constexpr uint64_t DUMP_STATS_NEG_INF = 1U << 4;
constexpr uint64_t DUMP_STATS_POS_INF = 1U << 5;
constexpr uint64_t DUMP_STATS_L2NORM = 1U << 6;

#define IDE_RETURN_IF_CHECK_ASSIGN_32U_ADD(A, B, result, action) do { \
    if (UINT32_MAX - (A) <= (B)) {                                 \
        action;                                                \
    }                                                              \
    (result) = (A) + (B);                                           \
} while (0)

template <typename T>
using SharedPtr = std::shared_ptr<T>;
}
#endif