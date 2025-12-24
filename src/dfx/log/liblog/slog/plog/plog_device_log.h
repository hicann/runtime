/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef PLOG_DEVICE_LOG_H
#define PLOG_DEVICE_LOG_H

#include "log_error_code.h"

#ifdef __cplusplus
extern "C" {
#endif

LogStatus PlogDeviceMgrInit(void);
void PlogDeviceMgrExit(void);

int32_t DlogReportInitializeInner(void);
int32_t DlogReportFinalizeInner(void);
int32_t DlogReportStartInner(int32_t devId, int32_t mode);
void DlogReportStopInner(int32_t devId);

#ifdef __cplusplus
}
#endif
#endif

