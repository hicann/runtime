/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_COMMON_ERRNO_ERROR_CODE_H
#define ANALYSIS_DVVP_COMMON_ERRNO_ERROR_CODE_H

#include <stdint.h>

namespace analysis {
namespace dvvp {
namespace common {
namespace error {
constexpr int32_t PROFILING_CONTINUE = 1;
constexpr int32_t PROFILING_SUCCESS = 0;
constexpr int32_t PROFILING_FAILED = -1;
constexpr int32_t PROFILING_NOTSUPPORT = -2;
constexpr int32_t PROFILING_IN_WARMUP = -3;
}  // namespace error
}  // namespace common
}  // namespace dvvp
}  // namespace analysis

#endif
