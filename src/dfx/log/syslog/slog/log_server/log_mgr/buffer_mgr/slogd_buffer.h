/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SLOGD_BUFFER_H
#define SLOGD_BUFFER_H

#include "log_common.h"
#include "log_print.h"
#include "log_time.h"

#define LOG_BUFFER_WRITE_MODE   0U
#define LOG_BUFFER_READ_MODE    1U

typedef struct {
    void *attr;
    bool (*slogdBufAttrCompare)(void *, void *);
} SlogdBufAttr;

typedef struct {
    char timeStr[TIME_STR_SIZE];
    char *data;
} SlogdMsgData;

#ifdef __cplusplus
extern "C" {
#endif

LogStatus SlogdBufferInit(int32_t logType, uint32_t bufSize, uint32_t devId, SlogdBufAttr *bufAttr);
void SlogdBufferExit(int32_t logType, void *attr);

void *SlogdBufferHandleOpen(int32_t logType, void *attr, uint32_t operaMode, uint32_t devId);
void SlogdBufferHandleClose(void **handle);
LogStatus SlogdBufferWrite(void *handle, const char *msg, uint32_t msgLen);
int32_t SlogdBufferRead(void *handle, char *msg, uint32_t msgLen);

uint32_t SlogdBufferGetBufSize(int32_t logType);

void SlogdBufferReset(void *handle);

bool SlogdBufferCheckFull(void *handle, uint32_t msgLen);
bool SlogdBufferCheckEmpty(void *handle);

LogStatus SlogdBufferCollectNewest(char *buf, uint32_t bufSize, uint32_t *pos, void *handle, uint32_t size);
#ifdef __cplusplus
}
#endif
#endif