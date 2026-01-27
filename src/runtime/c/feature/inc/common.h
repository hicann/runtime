/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef RUNTIME_C_FEATURE_COMMON_H
#define RUNTIME_C_FEATURE_COMMON_H

#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include "runtime/base.h"
#include "error_codes/rt_error_codes.h"
#include "runtime/rt.h"
#include "vector.h"
#include "log_inner.h"

#if defined(__cplusplus)
extern "C" {
#endif

typedef struct TagContext Context;
typedef struct TagDevice Device;
typedef struct TagStream Stream;

Device *RetainDevice(const uint32_t devId);
rtError_t ReleaseDevice(const uint32_t devId);
#if defined(__cplusplus)
}
#endif

#endif // RUNTIME_C_FEATURE_BASE_H