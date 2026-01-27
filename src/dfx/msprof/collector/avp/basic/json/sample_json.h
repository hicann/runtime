/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef BASIC_JSON_SAMPLE_JSON_H
#define BASIC_JSON_SAMPLE_JSON_H

#include <stddef.h>
#include "json_parser.h"
#include "profile_param.h"

#ifdef __cplusplus
extern "C" {
#endif

int32_t CreateSampleJson(ProfileParam *params, uint32_t deviceId);

#ifdef __cplusplus
}
#endif
#endif