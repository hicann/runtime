/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
 
#ifndef CORE_AICPUSD_MC2_MAINTENANCE_THREAD_API_H
#define CORE_AICPUSD_MC2_MAINTENANCE_THREAD_API_H
#include <cstdint>
#include <cstddef>
#include "tsd.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus
    __attribute__((visibility("default"))) __attribute__((weak)) int32_t CreateMc2MantenanceThread(const struct TsdSubEventInfo * const msg);
#ifdef __cplusplus
}
#endif  // __cplusplus
#endif