/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef LOG_RING_BUFFER_H
#define LOG_RING_BUFFER_H

#include "log_common.h"
#include "log_communication.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#ifdef BUF_SIZE
#define DEF_SIZE (512U * 1024U)
#else
#define DEF_SIZE (1U * 1024U * 1024U)
#endif
#define LEVEL_FILTER_CLOSE  0
#define LEVEL_FILTER_OPEN   1

typedef struct {
    uint32_t readIdx;
    uint64_t readSeq;
    uint64_t lostCount;
} ReadContext;

typedef struct RingBufferCtrl {
    uint32_t dataLen;       // space for log
    uint32_t dataOffset;
    uint32_t logFirstIdx;   // index for first write pointer, make space for next
    uint32_t logNextIdx;    // index for next write pointer, point to the end of the latest log
    uint64_t logFirstSeq;   // seq for first write pointer, make space for next, absolute value
    uint64_t logNextSeq;    // seq for next write pointer, point to the end of the latest log, absolute value
    uint64_t lastSeq;       // seq for read pointer, absolute value
    uint32_t lastIdx;       // index for read pointer
    uint8_t levelFilter;    // indicates whether secondary verification of level is required
    char resv[79];
} RingBufferCtrl;

typedef struct {
    uint32_t logBufSize;
    RingBufferCtrl *ringBufferCtrl;
} RingBufferStat;

void LogBufReInit(RingBufferStat *logBuf);
void LogBufReStart(const RingBufferCtrl *ringBufferCtrl, ReadContext *readContext);
int32_t LogBufInitHead(RingBufferCtrl *ringBufferCtrl, uint32_t size, uint32_t dataOffset);
int32_t LogBufWrite(RingBufferCtrl *ringBufferCtrl, const char *text, LogHead *head, uint64_t *coverCount);
int32_t LogBufRead(ReadContext *readContext, const RingBufferCtrl *ringBufferCtrl, char *buf,
                   uint16_t bufSize, LogHead *msgRes);
uint32_t LogBufCurrDataLen(RingBufferCtrl *ringBufferCtrl);
uint64_t LogBufLost(RingBufferCtrl *ringBufferCtrl);
void LogBufSetLevelFilter(RingBufferCtrl *ringBufferCtrl, uint8_t levelFilter);
bool LogBufCheckEmpty(RingBufferStat *logBuf);
bool LogBufCheckEnough(RingBufferStat *logBuf, uint32_t msgLen);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif // LOG_RING_BUFFER_H
