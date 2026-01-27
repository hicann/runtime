/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __PLATFORM_ERROR_DEFINE_H__
#define __PLATFORM_ERROR_DEFINE_H__

constexpr uint32_t PLATFORM_FAILED = 0xFFFFFFFF;
constexpr uint32_t PLATFORM_SUCCESS = 0;

// ensure the numerical value remains consistent with rts
constexpr int32_t PLATFORM_ERROR_NOT_FOUND                          = 0x071A0001;
constexpr int32_t PLATFORM_ERROR_PARSE_FILE_FAILED                  = 0x071F0001;

#endif  // __PLATFORM_ERROR_DEFINE_H__