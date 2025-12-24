/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DLOG_TIME_H
#define DLOG_TIME_H

#include "log_error_code.h"
#include "log_system_api.h"

#ifdef __cplusplus
extern "C" {
#endif

void DlogGetTime(char *timeStr, uint32_t length);

int64_t DlogTimeDiff(const struct timespec *lastTv);

#ifdef __cplusplus
}
#endif
#endif

