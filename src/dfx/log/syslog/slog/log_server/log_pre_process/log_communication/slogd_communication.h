/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SLOGD_COMMUNICATION_H
#define SLOGD_COMMUNICATION_H

#include "log_error_code.h"
#ifdef __cplusplus
extern "C" {
#endif

#define SLOG_FILE_NUM 2
#define MAX_USERNAME_LEN 16
LogStatus SlogdCommunicationInit(void);
void SlogdCommunicationExit(void);

LogStatus SlogdRmtServerInit(void);
int32_t SlogdRmtServerCreate(int32_t devId, uint32_t *fileNum);
int32_t SlogdRmtServerRecv(uint32_t fileNum, char *buf, uint32_t bufLen, int32_t *logType);
void SlogdRmtServerClose(int32_t devId, uint32_t fileNum);
void SlogdRmtServerExit(void);

#ifdef __cplusplus
}
#endif
#endif

