/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPU_KERNEL_UTILS_STATUS_H
#define AICPU_KERNEL_UTILS_STATUS_H

#include <cstdint>

namespace aicpu {
using KernelStatus = uint32_t;
/*
 * status code
 */
// 0-3 is fixed error code, runtime need interprete 0-3 error codes
constexpr uint32_t KERNEL_STATUS_OK = 0U;
constexpr uint32_t KERNEL_STATUS_PARAM_INVALID = 1U;
constexpr uint32_t KERNEL_STATUS_INNER_ERROR = 2U;
constexpr uint32_t KERNEL_STATUS_TIMEOUT = 3U;
constexpr uint32_t KERNEL_STATUS_PROTOBUF_ERROR = 4U;
constexpr uint32_t KERNEL_STATUS_SHARDER_ERROR = 5U;
constexpr uint32_t KERNEL_STATUS_END_OF_SEQUENCE = 201U;
constexpr uint32_t KERNEL_STATUS_SILENT_FAULT = 501U;
constexpr uint32_t KERNEL_STATUS_DETECT_FAULT = 502U;
constexpr uint32_t KERNEL_STATUS_DETECT_FAULT_NORAS = 503U;
constexpr uint32_t KERNEL_STATUS_DETECT_LOW_BIT_FAULT = 504U;
constexpr uint32_t KERNEL_STATUS_DETECT_LOW_BIT_FAULT_NORAS = 505U;
}  // namespace aicpu
#endif  // AICPU_KERNEL_UTILS_STATUS_H
