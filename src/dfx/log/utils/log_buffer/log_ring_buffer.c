/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_ring_buffer.h"
#include "log_common.h"
#include "log_print.h"
#include "securec.h"
#include "log_system_api.h"

#define PAGE_SIZES 4096U
#define MAX(a, b) (((a) > (b)) ? (a) : (b))

#define ALIGN __alignof__(sizeof(char *))
#define LOG_ALIGN_MASK(x, mask) (((x) + (mask)) & ~(mask))
#define LOG_ALIGN(x, a)         LOG_ALIGN_MASK(x, (typeof(x))(a) - 1U)
#define LOG_ALIGN_DOWN(x, a)    LOG_ALIGN((x) - ((a) - 1U), (a))


/**
 * @brief       : next address with log head
 * @param [in]  : msg       current log msg
 * @return      : next address
 */
STATIC char *LogText(LogHead *msg)
{
    return (char *)msg + LOGHEAD_LEN;
}

/**
 * @brief       : next msg
 * @param [in]  : ringBufferCtrl       g_ringBufferCtrl
 * @param [in]  : idx                  calc offset
 * @return      : NA
 */
STATIC uint32_t LogNext(const RingBufferCtrl *ringBufferCtrl, uint32_t idx)
{
    const LogHead *msg = (const LogHead *)((const char *)ringBufferCtrl + ringBufferCtrl->dataOffset + idx);
    if (msg->allLength == 0U) {
        msg = (const LogHead *)((const char *)ringBufferCtrl + ringBufferCtrl->dataOffset);
        return msg->allLength;
    }
    return idx + msg->allLength;
}

/**
 * @brief       : check if log buffer has left space
 * @param [in]  : logNextIdx        log buffer write idx
 * @param [in]  : logFirstIdx       log buffer read idx
 * @param [in]  : dateLen           length of g_ringBufferCtrl
 * @param [in]  : msgSize           msg length
 * @param [in]  : empty
 * @return      : NA
 */
STATIC bool LogbufHasSpace(uint32_t logNextIdx, uint32_t logFirstIdx, uint32_t dateLen, uint32_t msgSize,
                           uint32_t empty)
{
    uint32_t freeSpace;
    if ((logNextIdx > logFirstIdx) || (empty != 0U)) {
        freeSpace = (MAX((dateLen - logNextIdx), logFirstIdx));
    } else {
        freeSpace = logFirstIdx - logNextIdx;
    }
    return freeSpace >= (msgSize + LOGHEAD_LEN);
}

/**
 * @brief           : make space by first pointer
 * @param [in]      : ringBufferCtrl        log ring buffer
 * @param [in]      : msgSize               log length
 * @param [in/out]  : coverCount            log loss count
 * @return          : true: make free space success; false: make free space failed
 */
STATIC bool LogMakeFreeSpace(RingBufferCtrl *ringBufferCtrl, uint32_t msgSize, uint64_t *coverCount)
{
    uint64_t firstSeq = ringBufferCtrl->logFirstSeq;
    while ((ringBufferCtrl->logFirstSeq < ringBufferCtrl->logNextSeq) &&
           (!LogbufHasSpace(ringBufferCtrl->logNextIdx, ringBufferCtrl->logFirstIdx, ringBufferCtrl->dataLen,
                            msgSize, 0))) {
        ringBufferCtrl->logFirstIdx = LogNext(ringBufferCtrl, ringBufferCtrl->logFirstIdx);
        ringBufferCtrl->logFirstSeq++;
    }
    // calculate covered logs nums
    if ((coverCount != NULL) && (ringBufferCtrl->logFirstSeq > ringBufferCtrl->lastSeq)) {
        *coverCount += ringBufferCtrl->logFirstSeq - MAX(ringBufferCtrl->lastSeq, firstSeq);
    }
    if (LogbufHasSpace(ringBufferCtrl->logNextIdx, ringBufferCtrl->logFirstIdx, ringBufferCtrl->dataLen, msgSize,
                       (uint32_t)(ringBufferCtrl->logFirstSeq == ringBufferCtrl->logNextSeq))) {
        return true;
    }
    return false;
}

STATIC const LogHead *LogFromIdx(const RingBufferCtrl *ringBufferCtrl, uint32_t idx)
{
    if (idx > ringBufferCtrl->dataLen) {
        return NULL;
    }
    const LogHead *msg = (const LogHead *)((const char *)ringBufferCtrl + ringBufferCtrl->dataOffset + idx);
    if (msg->allLength == 0U) {
        return (const LogHead *)((const char *)ringBufferCtrl + ringBufferCtrl->dataOffset);
    }
    return msg;
}

/**
 * @brief       : length include text and pad
 * @param [in]  : textLen       text length
 * @param [in]  : padLen        pad length
 * @return      : msg length
 */
STATIC uint32_t MsgUsedSize(uint32_t textLen, uint32_t *padLen)
{
    uint32_t size = (uint32_t)LOGHEAD_LEN + textLen;
    *padLen = (uint32_t)((~size + 1UL) & (ALIGN - 1UL));
    size += *padLen;
    return size;
}

/**
 * @brief       : if msg longer than MSG_LENGTH, truncate to MSG_LENGTH
 * @param [in]  : textLen       text length
 * @param [in]  : padLen        pad length
 * @return      : msg length
 */
STATIC uint32_t TruncateMsgIfLong(uint32_t *textLen, uint32_t *padLen)
{
    if (*textLen >= MSG_LENGTH) {
        *textLen = MSG_LENGTH - 1U;
    }
    return MsgUsedSize(*textLen, padLen);
}

STATIC bool CheckBufHead(const RingBufferCtrl *ringBufferCtrl)
{
    if ((ringBufferCtrl->logFirstIdx > ringBufferCtrl->dataLen) ||
        (ringBufferCtrl->logNextIdx > ringBufferCtrl->dataLen) ||
        (ringBufferCtrl->lastIdx > ringBufferCtrl->dataLen)) {
        return false;
    }
    return true;
}

/**
 * @brief       : calculate the length of data in buffer which has not been read
 * @param [in]  : ringBufferCtrl       ring buffer
 * @return      : data length
 */
uint32_t LogBufCurrDataLen(RingBufferCtrl *ringBufferCtrl)
{
    if ((ringBufferCtrl == NULL) || (ringBufferCtrl->dataLen < ringBufferCtrl->lastIdx)) {
        return 0;
    }
    if (ringBufferCtrl->logFirstSeq > ringBufferCtrl->lastSeq) { // overwritten
        return ringBufferCtrl->dataLen;
    } else if (ringBufferCtrl->logNextIdx >= ringBufferCtrl->lastIdx) { // not overwritten
        return ringBufferCtrl->logNextIdx - ringBufferCtrl->lastIdx;
    } else {
        return ringBufferCtrl->dataLen - ringBufferCtrl->lastIdx + ringBufferCtrl->logNextIdx;
    }
}

/**
 * @brief        : calculate the number of log buf is covered
 * @return       : the number of log buf is covered
 */
uint64_t LogBufLost(RingBufferCtrl *ringBufferCtrl)
{
    if (ringBufferCtrl == NULL) {
        return 0;
    }
    if (ringBufferCtrl->logFirstSeq > ringBufferCtrl->lastSeq) {
        return ringBufferCtrl->logFirstSeq - ringBufferCtrl->lastSeq;
    }
    return 0;
}

STATIC void CompareFirstSeq(const RingBufferCtrl *ringBufferCtrl, ReadContext *readContext)
{
    if (readContext->readSeq < ringBufferCtrl->logFirstSeq) {
        uint64_t lostNum = ringBufferCtrl->logFirstSeq - readContext->readSeq;
        readContext->readSeq = ringBufferCtrl->logFirstSeq;
        readContext->readIdx = ringBufferCtrl->logFirstIdx;
        readContext->lostCount = lostNum;
    }
}

/**
 * @brief        : reinit log buffer to 0
 */
void LogBufReInit(RingBufferStat *logBuf)
{
    RingBufferCtrl *ringBufferCtrl = logBuf->ringBufferCtrl;
    ringBufferCtrl->lastSeq = ringBufferCtrl->logNextSeq;
    ringBufferCtrl->lastIdx = ringBufferCtrl->logNextIdx;
}

void LogBufReStart(const RingBufferCtrl *ringBufferCtrl, ReadContext *readContext)
{
    readContext->readIdx = ringBufferCtrl->lastIdx;
    readContext->readSeq = ringBufferCtrl->lastSeq;
    readContext->lostCount = 0;
}

/**
 * @brief       : init log buffer head
 * @param [in]  : ringBufferCtrl        ring buffer
 * @param [in]  : size                  buffer size
 * @param [in]  : moduleId              module id
 * @param [in]  : dataOffset            offset
 * @return      : >= 0 success; < 0 failure
 */
int32_t LogBufInitHead(RingBufferCtrl *ringBufferCtrl, uint32_t size, uint32_t dataOffset)
{
    if (ringBufferCtrl == NULL) {
        return -1;
    }
    uint32_t offset = (dataOffset == 0) ? LOG_SIZEOF(RingBufferCtrl) : dataOffset;
    uint32_t tmpLen = (MAX(LOG_SIZEOF(RingBufferCtrl), offset));
    tmpLen = LOG_ALIGN(tmpLen, (uint32_t)ALIGN);
    if (size < (tmpLen + PAGE_SIZES)) {
        return -1;
    }

    int32_t res = memset_s(ringBufferCtrl, offset, 0, offset);
    if (res != EOK) {
        return -1;
    }
    ringBufferCtrl->dataLen = LOG_ALIGN_DOWN(size, (uint32_t)PAGE_SIZES) - tmpLen;
    ringBufferCtrl->dataOffset = tmpLen;
    ringBufferCtrl->levelFilter = LEVEL_FILTER_CLOSE;
    return 0;
}

/**
 * @brief           : write log to log buffer
 * @param [in]      : ringBufferCtrl        ring buffer
 * @param [in]      : text                  log msg
 * @param [in]      : head                  log head
 * @param [in/out]  : coverCount            log loss count
 * @return      : >= 0 success; < 0 failure
 */
int32_t LogBufWrite(RingBufferCtrl *ringBufferCtrl, const char *text, LogHead *head, uint64_t *coverCount)
{
    LogHead *msg;
    uint32_t size = 0, padLen = 0;
    if (ringBufferCtrl == NULL) {
        return (-(int32_t)BUFFER_NULL);
    }
    if (!CheckBufHead(ringBufferCtrl)) {
        return (-(int32_t)BUFFER_CHECK);
    }
    uint32_t textLen = (uint32_t)head->msgLength;
    uint32_t logNextIdxTmp = ringBufferCtrl->logNextIdx;
    char *logBuf = (char *)ringBufferCtrl + ringBufferCtrl->dataOffset;
    size = TruncateMsgIfLong(&textLen, &padLen);
    head->allLength = (uint16_t)size;
    if (!LogMakeFreeSpace(ringBufferCtrl, size, coverCount)) {
        return (-(int32_t)BUFFER_WRITE_LONG);
    }
    int32_t resTmp;
    if ((logNextIdxTmp + size + (uint32_t)LOGHEAD_LEN) > ringBufferCtrl->dataLen) {
        resTmp = memset_s(logBuf + logNextIdxTmp, LOGHEAD_LEN, 0, LOGHEAD_LEN);
        ringBufferCtrl->logNextIdx = 0;
        logNextIdxTmp = 0;
        if (resTmp != EOK) {
            return (-(int32_t)BUFFER_WRITE_MEMCPY);
        }
    }
    msg = (LogHead *)(logBuf + logNextIdxTmp);
    resTmp = memcpy_s((char *)msg, sizeof(LogHead), (char *)head, sizeof(LogHead));
    if (resTmp != EOK) {
        return (-(int32_t)BUFFER_WRITE_MEMCPY);
    }
    resTmp = memcpy_s(LogText(msg), textLen, text, textLen);
    if (resTmp != EOK) {
        return (-(int32_t)BUFFER_WRITE_MEMCPY);
    }
    resTmp = memset_s(LogText(msg) + textLen, MSG_LENGTH, 0, padLen);
    if (resTmp != EOK) {
        return (-(int32_t)BUFFER_WRITE_MEMCPY);
    }
    ringBufferCtrl->logNextIdx += head->allLength;
    ringBufferCtrl->logNextSeq++;
    return (int32_t)head->msgLength;
}

/**
 * @brief       : read from log buffer
 * @param [in]  : readContext       user attr
 * @param [in]  : ringBufferCtrl    ring buffer
 * @param [out] : buf               buffer
 * @param [in]  : bufSize           buffer size
 * @param [out] : msgRes            msg head
 * @return      : >= 0 success; < 0 failure
 */
int32_t LogBufRead(ReadContext *readContext, const RingBufferCtrl *ringBufferCtrl, char *buf,
                   uint16_t bufSize, LogHead *msgRes)
{
    int32_t ret;
    if (ringBufferCtrl == NULL) {
        return (-(int32_t)BUFFER_NULL);
    }
    if (!CheckBufHead(ringBufferCtrl)) {
        return (-(int32_t)BUFFER_CHECK);
    }
    if (readContext->readIdx > ringBufferCtrl->dataLen) {
        return (-(int32_t)BUFFER_CHECK);
    }
    if (readContext->readSeq == ringBufferCtrl->logNextSeq) {
        return (-(int32_t)BUFFER_READ_FINISH);
    }
    CompareFirstSeq(ringBufferCtrl, readContext);
    const LogHead *msg = LogFromIdx(ringBufferCtrl, readContext->readIdx);
    if (msg == NULL) {
        return (-(int32_t)BUFFER_READ_MEMCPY);
    }
    ret = memcpy_s(msgRes, sizeof(LogHead), msg, sizeof(LogHead));
    if (ret != EOK) {
        return (-(int32_t)BUFFER_READ_MEMCPY);
    }
    if (msgRes->msgLength > (bufSize - 1U)) {
        msgRes->msgLength = bufSize - 1U;
    }
    uintptr_t maxAddr = (uintptr_t)((const char *)ringBufferCtrl + ringBufferCtrl->dataOffset +
        ringBufferCtrl->dataLen);
    if (((uintptr_t)((const char *)msg + LOGHEAD_LEN + msgRes->msgLength) <= maxAddr)) {
        ret = memcpy_s(buf, (size_t)(bufSize - 1UL), (const char *)msg + LOGHEAD_LEN, msgRes->msgLength);
        buf[msgRes->msgLength] = '\0';
        if (ret != EOK) {
            return (-(int32_t)BUFFER_READ_MEMCPY);
        }
        readContext->readIdx = LogNext(ringBufferCtrl, readContext->readIdx);
        readContext->readSeq++;
    } else {
        return (-(int32_t)BUFFER_READ_LONG);
    }
    return (int32_t)msgRes->msgLength;
}

void LogBufSetLevelFilter(RingBufferCtrl *ringBufferCtrl, uint8_t levelFilter)
{
    ringBufferCtrl->levelFilter = levelFilter;
}

bool LogBufCheckEmpty(RingBufferStat *logBuf)
{
    if ((logBuf == NULL) || (logBuf->ringBufferCtrl == NULL) ||
        (logBuf->ringBufferCtrl->lastSeq == logBuf->ringBufferCtrl->logNextSeq)) {
        return true;
    }
    return false;
}

bool LogBufCheckEnough(RingBufferStat *logBuf, uint32_t msgLen)
{
    if (logBuf == NULL) {
        return false;
    }
    RingBufferCtrl *ringBufferCtrl = logBuf->ringBufferCtrl;
    uint32_t textLen = msgLen;
    uint32_t padLen = 0;
    uint32_t size = TruncateMsgIfLong(&textLen, &padLen) + (uint32_t)LOGHEAD_LEN;
    if (LogBufCurrDataLen(ringBufferCtrl) + size < ringBufferCtrl->dataLen) {
        return true;
    }
    return false;
}