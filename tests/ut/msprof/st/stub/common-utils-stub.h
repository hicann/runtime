/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef _ANALYSIS_DVVP_UT_COMMON_UTILS_STUB_H
#define _ANALYSIS_DVVP_UT_COMMON_UTILS_STUB_H
#include <string.h>
#include <stdio.h>
#include <string>
#include "mmpa_api.h"

extern "C" int snprintf_s(char* strDest, size_t destMax, size_t count, const char* format, ...);
std::string GetAdxWorkPath();
#endif

