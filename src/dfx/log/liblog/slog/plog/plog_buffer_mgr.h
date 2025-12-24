/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef PLOG_BUFFER_MGR_H
#define PLOG_BUFFER_MGR_H

#define BUFFER_TYPE_WRITE   0
#define BUFFER_TYPE_SEND    1

#include "log_common.h"
#ifdef __cplusplus
extern "C" {
#endif

bool PlogBuffCheckEmpty(int32_t buffType);
void PlogBuffExchange(void);
// check buffer pointer is not null before call this function
bool PlogBuffCheckFull(LogType logType, uint32_t len);
bool PlogBuffCheckEnough(LogType logType);
LogStatus PlogBuffWrite(LogType type, const char *data, uint32_t dataLen);
LogStatus PlogBuffRead(int32_t buffType, LogType logType, char **data, uint32_t *dataLen);
void PlogBuffReset(int32_t buffType, LogType logType);
void PlogBuffLogLoss(LogType type);

LogStatus PlogBuffInit(void);
void PlogBuffExit(void);

#ifdef __cplusplus
}
#endif
#endif /* PLOG_FILE_MGR_H */