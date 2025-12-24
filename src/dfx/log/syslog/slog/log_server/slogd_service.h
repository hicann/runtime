/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SLOGD_SERVICE_H
#define SLOGD_SERVICE_H

#include <stdbool.h>
#include "log_error_code.h"

#ifdef __cplusplus
extern "C" {
#endif

LogStatus LogServiceInit(int32_t devId, int32_t level, bool isDocker);
void LogServiceProcess(int32_t devId);
void LogServiceExit(void);

#ifdef __cplusplus
}
#endif
#endif

