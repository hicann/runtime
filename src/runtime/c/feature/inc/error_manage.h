/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_C_FEATURE_ERROR_MANAGE_H
#define RUNTIME_C_FEATURE_ERROR_MANAGE_H

#include "hal_ts.h"
#include "mem.h"
#include "error_codes/rt_error_codes.h"
#if defined(__cplusplus)
extern "C" {
#endif
int32_t ErrorConvert(int32_t drvError);
#if defined(__cplusplus)
}
#endif

#endif // RUNTIME_C_FEATURE_BASE_H