/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef UNIFIED_TIMER_ERROR_CODE_H
#define UNIFIED_TIMER_ERROR_CODE_H

#include <stdint.h>

static const uint32_t UNIFILED_TIMER_SUCCESS = 0U;
static const uint32_t UNIFILED_TIMER_FAILED = 0xF10800U;
static const uint32_t UNIFILED_TIMER_NAME_NULL = 0xF10801U;
static const uint32_t UNIFILED_TIMER_INIT_FAILED = 0xF10802U;
static const uint32_t UNIFILED_TIMER_NAME_DUPLICATE = 0xF10803U;
static const uint32_t UNIFILED_TIMER_NAME_NOT_FOUND = 0xF10804U;
static const uint32_t UNIFILED_TIMER_CALLBACK_NULL = 0xF10805U;
static const uint32_t UNIFILED_TIMER_PERIOD_ABNORMAL = 0xF10806U;
static const uint32_t UNIFILED_TIMER_NAME_LENGTH_ERROR = 0xF10807U;
static const uint32_t UNIFILED_TIMER_DESTROYED = 0xF10808U;

#endif