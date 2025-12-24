/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "plog_buffer_mgr.h"
#include "log_print.h"
#include "log_time.h"

#define DEBUG_BUFFER_SIZE (1024U * 1024U)
#define RUN_BUFFER_SIZE (1024U * 1024U)
#define SECURITY_BUFFER_SIZE (20U * 1024U)
#define RATIO_BUFFER_THRESHOLD(size) ((size) * 3U / 4U)
#define PLOG_MAX_LOSS_NUM 10000
#define PLOG_LOSS_PRINT_INTERVAL 900000 // 15min

typedef struct {
    char *buf;        // buffer pointer
    uint32_t dataLen; // buffer offset
    uint32_t readIdx;
    uint32_t writeIdx;
    uint32_t thresholdSize; // threshold size（ fullSize * 3 / 4)
    uint32_t fullSize;      // buffer full size
    uint32_t roundFlag;     // flag whether to wrap and cover
} PlogBuffer;

typedef struct {
    uint32_t lossCount;
    struct timespec lastTv;
} LogLossMgr;

typedef struct {
    PlogBuffer *writeBuf;
    PlogBuffer *sendBuf;
    LogLossMgr lossMgr;
} PlogBufferMgr;

typedef struct {
    PlogBufferMgr debug;
    PlogBufferMgr run;
    PlogBufferMgr security;
} PlogBufferSet;

STATIC PlogBufferSet *g_plogBuffer = NULL;

STATIC PlogBufferMgr *PlogBufferMgrGet(LogType logType)
{
    PlogBufferMgr *bufMgr = NULL;
    switch (logType) {
        case DEBUG_LOG:
            bufMgr = &g_plogBuffer->debug;
            break;
        case RUN_LOG:
            bufMgr = &g_plogBuffer->run;
            break;
        case SECURITY_LOG:
            bufMgr = &g_plogBuffer->security;
            break;
        default:
            break;
    }
    return bufMgr;
}

/* *
 * @brief       get buffer pointer of a specified type
 * @param [in]  buffType:   buffer type (send/write)
 * @param [in]  logType:    log type (debug/run/security)
 * @return      buffer pointer
 */
STATIC PlogBuffer *PlogBuffGet(int32_t buffType, LogType logType)
{
    PlogBufferMgr *bufMgr = PlogBufferMgrGet(logType);
    ONE_ACT_NO_LOG(bufMgr == NULL, return NULL);
    if (buffType == BUFFER_TYPE_WRITE) {
        return bufMgr->writeBuf;
    } else if (buffType == BUFFER_TYPE_SEND) {
        return bufMgr->sendBuf;
    } else {
        return NULL;
    }
}

/* *
 * @brief       check buffer is empty or not
 * @param [in]  buffType:   buffer type (send/write)
 * @return      true  empty; false  not empty
 */
bool PlogBuffCheckEmpty(int32_t buffType)
{
    if (buffType == BUFFER_TYPE_WRITE) {
        return ((g_plogBuffer->debug.writeBuf->dataLen + g_plogBuffer->run.writeBuf->dataLen +
            g_plogBuffer->security.writeBuf->dataLen) == 0U);
    } else {
        return ((g_plogBuffer->debug.sendBuf->dataLen + g_plogBuffer->run.sendBuf->dataLen +
            g_plogBuffer->security.sendBuf->dataLen) == 0U);
    }
}

/* *
 * @brief       check buffer is full or not after write data
 * @param [in]  logType:    log type (debug/run/security)
 * @param [in]  len:        length of the data to be written
 * @return      true  full; false  not full
 */
bool PlogBuffCheckFull(LogType logType, uint32_t len)
{
    PlogBuffer *buffer = PlogBuffGet(BUFFER_TYPE_WRITE, logType);
    if ((buffer == NULL) || (buffer->buf == NULL)) {
        return true;
    }

    if ((buffer->roundFlag == 1U) || ((buffer->dataLen + len) >= buffer->fullSize)) {
        return true;
    }
    return false;
}

/* *
 * @brief       check the remaining buffer is enough or not (bigger than 1/4)
 * @param [in]  logType:    log type (debug/run/security)
 * @return      true  enough; false  not enough
 */
bool PlogBuffCheckEnough(LogType logType)
{
    PlogBuffer *buffer = PlogBuffGet(BUFFER_TYPE_WRITE, logType);
    if ((buffer != NULL) && (buffer->roundFlag == 0U) && (buffer->dataLen <= buffer->thresholdSize)) {
        return true;
    }

    return false;
}

static void PlogBuffMgrExchange(PlogBufferMgr *bufMgr)
{
    PlogBuffer *tmp = bufMgr->writeBuf;
    bufMgr->writeBuf = bufMgr->sendBuf;
    bufMgr->sendBuf = tmp;
}

/* *
 * @brief       exchange write buffer and send buffer
 */
void PlogBuffExchange(void)
{
    PlogBuffMgrExchange(&g_plogBuffer->debug);
    PlogBuffMgrExchange(&g_plogBuffer->run);
    PlogBuffMgrExchange(&g_plogBuffer->security);
}

STATIC void PlogPrintLogLoss(LogLossMgr *lossMgr, LogType type, bool waitFlag)
{
    if (lossMgr->lossCount > PLOG_MAX_LOSS_NUM) {
        lossMgr->lossCount = PLOG_MAX_LOSS_NUM;
    }
    struct timespec currentTv = { 0, 0 };
    LogStatus result = LogGetMonotonicTime(&currentTv);
    ONE_ACT_WARN_LOG(result != LOG_SUCCESS, return, "can not get time, strerr=%s.", strerror(ToolGetErrorCode()));

    int64_t timeValue = 0;
    if ((lossMgr->lastTv.tv_nsec == 0) && (lossMgr->lastTv.tv_sec == 0)) {
        timeValue = PLOG_LOSS_PRINT_INTERVAL;
    } else {
        timeValue = (int64_t)((currentTv.tv_nsec - lossMgr->lastTv.tv_nsec) / NS_TO_MS) +
            (int64_t)((currentTv.tv_sec - lossMgr->lastTv.tv_sec) * S_TO_MS);
    }
    if (waitFlag || (timeValue >= PLOG_LOSS_PRINT_INTERVAL)) {
        const char *fileDir[LOG_TYPE_NUM] = {"debug", "security", "run"};
        SELF_LOG_INFO("%s log loss num is %u, print every %d seconds.", fileDir[(int32_t)type], lossMgr->lossCount,
            (int32_t)(PLOG_LOSS_PRINT_INTERVAL / S_TO_MS));
        lossMgr->lastTv.tv_nsec = currentTv.tv_nsec;
        lossMgr->lastTv.tv_sec = currentTv.tv_sec;
        lossMgr->lossCount = 0;
    }
}

/* *
 * @brief       calculate log loss num and print
 * @param [in]  type:    log type (debug/run/security)
 */
void PlogBuffLogLoss(LogType type)
{
    PlogBufferMgr *bufMgr = PlogBufferMgrGet(type);
    ONE_ACT_NO_LOG(bufMgr == NULL, return);
    LogLossMgr *lossMgr = &bufMgr->lossMgr;
    if (lossMgr->lossCount != 0) {
        PlogPrintLogLoss(lossMgr, type, true);
    }
}

/* *
 * @brief           find the position of the first log after len offset from the buffer, and count loss number
 * @param[in]       buf:           log buffer data
 * @param[in]       len:           buffer length
 * @param[in/out]   location:      first index of next complete log from current location
 * @return          log loss number
 */
STATIC uint32_t PlogCountLossNum(const char *buf, uint32_t len, uint32_t *location)
{
    uint32_t count = 0;
    char cEnd = '\0';
    char cFirst = '\0';
    uint32_t i = 1;
    while (i < len) {
        cEnd = *(buf + i - 1);
        cFirst = *(buf + i);
        if (((cEnd == '\n') && (cFirst == '[')) || ((cEnd == '\n') && (cFirst == '\0'))) {
            count++;
            if (i > *location) {
                break;
            }
        }
        i++;
    }
    *location = i;
    return count;
}

/* *
 * @brief       write data to buffer
 * @param [in]  type:       log type (debug/run/security)
 * @param [in]  data:       data
 * @param [in]  dataLen:    data length
 * @return      LogStatus
 */
LogStatus PlogBuffWrite(LogType type, const char *data, uint32_t dataLen)
{
    if ((data == NULL) || (dataLen == 0U)) {
        return LOG_INVALID_PARAM;
    }
    PlogBufferMgr *bufMgr = PlogBufferMgrGet(type);
    ONE_ACT_NO_LOG(bufMgr == NULL, return LOG_INVALID_PARAM);
    LogLossMgr *lossMgr = &bufMgr->lossMgr;
    PlogBuffer *buffer = bufMgr->writeBuf;
    ONE_ACT_NO_LOG(buffer == NULL, return LOG_INVALID_PARAM);
    uint32_t resLen = buffer->fullSize - buffer->writeIdx;

    // if type is security log, loss the current log
    if ((resLen < dataLen) && (type == SECURITY_LOG)) {
        lossMgr->lossCount++;
        PlogPrintLogLoss(lossMgr, type, false);
        return LOG_SUCCESS;
    }
    uint32_t count = 0;
    // check whether to wrap and cover
    if (resLen <= dataLen) {
        // calculate log loss in resLen
        uint32_t newOffset = resLen;
        char *lossStartIdx = buffer->buf + buffer->writeIdx;
        count += PlogCountLossNum(lossStartIdx, resLen, &newOffset);
        buffer->dataLen -= (buffer->readIdx > buffer->writeIdx) ? LogStrlen(buffer->buf + buffer->readIdx) : 0U;
        (void)memset_s(lossStartIdx, resLen, 0, resLen);
        buffer->readIdx = (buffer->readIdx > buffer->writeIdx) ? 0U : buffer->readIdx;
        buffer->writeIdx = 0U;
        buffer->roundFlag = 1U;
    }
    // if a round of data has been written, check whether the free space is sufficient
    if ((buffer->roundFlag == 1U) && (buffer->readIdx - buffer->writeIdx <= dataLen)) {
        // if the space is insufficient, clear the space and collect statistics on the number of overwritten records
        uint32_t newOffset = dataLen - (buffer->readIdx - buffer->writeIdx);
        count += PlogCountLossNum(buffer->buf + buffer->readIdx, buffer->fullSize - buffer->readIdx, &newOffset);
        (void)memset_s(buffer->buf + buffer->readIdx, newOffset, 0, newOffset);
        buffer->dataLen -= newOffset;
        buffer->readIdx = (buffer->readIdx + newOffset) % buffer->fullSize;
    }
    if (count > 0) {
        lossMgr->lossCount += count;
        PlogPrintLogLoss(lossMgr, type, false);
    }

    errno_t err = memcpy_s(buffer->buf + buffer->writeIdx, (size_t)buffer->fullSize - (size_t)buffer->writeIdx,
        data, dataLen);
    if (err != EOK) {
        SELF_LOG_ERROR("memcpy failed, err=%d.", err);
        return LOG_FAILURE;
    }
    buffer->dataLen += dataLen;
    buffer->writeIdx += dataLen;
    return LOG_SUCCESS;
}

/* *
 * @brief       write data to buffer
 * @param [in]  buffType:   buffer type (send/write)
 * @param [in]  logType:    log type (debug/run/security)
 * @param [out] data:       data
 * @param [out] dataLen:    data length
 * @return      LogStatus
 */
LogStatus PlogBuffRead(int32_t buffType, LogType logType, char **data, uint32_t *dataLen)
{
    PlogBuffer *buffer = PlogBuffGet(buffType, logType);
    ONE_ACT_NO_LOG(buffer == NULL, return LOG_FAILURE);
    if (buffer->writeIdx == buffer->readIdx) {
        *dataLen = 0U;
        return LOG_SUCCESS;
    }
    if (buffer->roundFlag == 0U) {
        *data = buffer->buf;
        *dataLen = buffer->writeIdx;
        buffer->writeIdx = 0U;
        return LOG_SUCCESS;
    }
    *data = buffer->buf + buffer->readIdx;
    *dataLen = LogStrlen(*data);
    buffer->roundFlag = 0U;
    buffer->readIdx = 0U;
    return LOG_SUCCESS;
}

/* *
 * @brief       reset buffer
 * @param [in]  buffType:   buffer type (send/write)
 * @param [in]  logType:    log type (debug/run/security)
 */
void PlogBuffReset(int32_t buffType, LogType logType)
{
    PlogBuffer *buffer = PlogBuffGet(buffType, logType);
    ONE_ACT_NO_LOG(buffer == NULL, return );
    (void)memset_s(buffer->buf, buffer->fullSize, 0, buffer->fullSize);
    buffer->dataLen = 0U;
    buffer->writeIdx = 0U;
    buffer->readIdx = 0U;
    buffer->roundFlag = 0U;
}

STATIC LogStatus PlogBufferInit(PlogBuffer **buffer, uint32_t size)
{
    *buffer = (PlogBuffer *)LogMalloc(sizeof(PlogBuffer));
    if (*buffer == NULL) {
        SELF_LOG_ERROR("malloc plog buffer mgr failed.");
        return LOG_FAILURE;
    }
    char *buf = (char *)LogMalloc(size);
    if (buf == NULL) {
        SELF_LOG_ERROR("malloc plog buffer failed, size=%u.", size);
        return LOG_FAILURE;
    }
    (*buffer)->buf = buf;
    (*buffer)->dataLen = 0U;
    (*buffer)->writeIdx = 0U;
    (*buffer)->readIdx = 0U;
    (*buffer)->fullSize = size;
    (*buffer)->thresholdSize = RATIO_BUFFER_THRESHOLD(size);
    (*buffer)->roundFlag = 0U;
    return LOG_SUCCESS;
}

STATIC LogStatus PlogBufferMgrInit(PlogBufferMgr *mgr, uint32_t size)
{
    LogStatus ret = PlogBufferInit(&mgr->writeBuf, size);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return ret, "init plog write buffer failed, ret=%d.", ret);

    ret = PlogBufferInit(&mgr->sendBuf, size);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return ret, "init plog send buffer failed, ret=%d.", ret);

    return LOG_SUCCESS;
}

STATIC void PlogBufferMgrExit(PlogBufferMgr *mgr)
{
    if (mgr->writeBuf != NULL) {
        XFREE(mgr->writeBuf->buf);
        XFREE(mgr->writeBuf);
    }
    if (mgr->sendBuf != NULL) {
        XFREE(mgr->sendBuf->buf);
        XFREE(mgr->sendBuf);
    }
}

STATIC void PlogBufferRelease(void)
{
    PlogBufferMgrExit(&g_plogBuffer->debug);
    PlogBufferMgrExit(&g_plogBuffer->run);
    PlogBufferMgrExit(&g_plogBuffer->security);
}

/* *
 * @brief       init buffer mgr
 * @return      LogStatus
 */
LogStatus PlogBuffInit(void)
{
    g_plogBuffer = (PlogBufferSet *)LogMalloc(sizeof(PlogBufferSet));
    if (g_plogBuffer == NULL) {
        SELF_LOG_ERROR("malloc plog buffer failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }
    LogStatus ret = PlogBufferMgrInit(&g_plogBuffer->debug, DEBUG_BUFFER_SIZE);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return ret, "init plog debug buffer failed, ret=%d.", ret);

    ret = PlogBufferMgrInit(&g_plogBuffer->run, RUN_BUFFER_SIZE);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return ret, "init plog run buffer failed, ret=%d.", ret);

    ret = PlogBufferMgrInit(&g_plogBuffer->security, SECURITY_BUFFER_SIZE);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return ret, "init plog security buffer failed, ret=%d.", ret);

    return LOG_SUCCESS;
}

/* *
 * @brief       release buffer mgr
 */
void PlogBuffExit(void)
{
    if (g_plogBuffer != NULL) {
        PlogBufferRelease();
        XFREE(g_plogBuffer);
    }
}
