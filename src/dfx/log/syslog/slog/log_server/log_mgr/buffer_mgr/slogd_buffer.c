/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "slogd_buffer.h"
#include "ascend_hal.h"

#define LOG_DYNAMIC_BUFFER 0
#define LOG_STATIC_BUFFER 1
#define LOG_BUFFER_TYPE_NUM 2

#define LOG_HEAD_MAGIC 0xC87A3
#define LOG_BLOCK_SIZE 1048576U

#define LOG_BUFFER_HEAD_RESERVE     20

#ifdef STATIC_BUFFER
static int32_t g_bufferMap[LOG_TYPE_MAX_NUM] = {
    [DEBUG_SYS_LOG_TYPE] = LOG_STATIC_BUFFER,
    [SEC_SYS_LOG_TYPE] = LOG_STATIC_BUFFER,
    [RUN_SYS_LOG_TYPE] = LOG_STATIC_BUFFER,
    [EVENT_LOG_TYPE] = LOG_STATIC_BUFFER,
    [FIRM_LOG_TYPE] = LOG_STATIC_BUFFER,
    [GROUP_LOG_TYPE] = LOG_DYNAMIC_BUFFER,
    [DEBUG_APP_LOG_TYPE] = LOG_DYNAMIC_BUFFER,
    [SEC_APP_LOG_TYPE] = LOG_DYNAMIC_BUFFER,
    [RUN_APP_LOG_TYPE] = LOG_DYNAMIC_BUFFER
};
#else
static int32_t g_bufferMap[LOG_TYPE_MAX_NUM] = {
    [DEBUG_SYS_LOG_TYPE] = LOG_DYNAMIC_BUFFER,
    [SEC_SYS_LOG_TYPE] = LOG_DYNAMIC_BUFFER,
    [RUN_SYS_LOG_TYPE] = LOG_DYNAMIC_BUFFER,
    [EVENT_LOG_TYPE] = LOG_DYNAMIC_BUFFER,
    [FIRM_LOG_TYPE] = LOG_DYNAMIC_BUFFER,
    [GROUP_LOG_TYPE] = LOG_DYNAMIC_BUFFER,
    [DEBUG_APP_LOG_TYPE] = LOG_DYNAMIC_BUFFER,
    [SEC_APP_LOG_TYPE] = LOG_DYNAMIC_BUFFER,
    [RUN_APP_LOG_TYPE] = LOG_DYNAMIC_BUFFER
};
#endif

typedef struct {
    uint32_t magic;      // this parameter is valid only for data0.
    uint32_t blockSize;  // this parameter is valid only for data0.
    uint32_t writePtr;   // this parameter is valid only for data0, offset relative to the bufMgr start address.
    uint32_t readPtr;    // this parameter is valid only for data0, offset relative to the bufMgr start address.
    uint32_t dataLen;    // valid data length of each block.
    char timeStr[TIME_STR_SIZE];  // only timestamps are recorded.
    uint8_t reserve[LOG_BUFFER_HEAD_RESERVE];
    char *data;
} BlockStruct;  // control header of each buffer block

typedef struct LogBufferMgr {
    int32_t logType;
    uint32_t bufferSize;
    uint32_t blockNum;
    int32_t roundFlag;
    uint32_t deviceId;
    uint32_t operaMode;
    ToolMutex lock;
    SlogdBufAttr bufAttr;
    BlockStruct *buffer;
    struct LogBufferMgr *next;
} LogBufferMgr;  // control header of the whole buffer

#define BLOCK_HEADER_LEN (uint32_t)sizeof(BlockStruct)
#define BUF_DATA_OFFSET BLOCK_HEADER_LEN
#define BUF_START_ATTR(blockHead) (((blockHead)->data) - BLOCK_HEADER_LEN)
static LogBufferMgr *g_slogdBufMgr[LOG_TYPE_MAX_NUM] = {0};

typedef struct {
    LogStatus (*slogdBufferInitFunc)(LogBufferMgr *, uint32_t, int32_t, uint32_t);
    void (*slogdBufferExitFunc)(LogBufferMgr **);
    LogStatus (*slogdBufferWriteFunc)(LogBufferMgr *, const char *, uint32_t);
    int32_t (*slogdBufferReadFunc)(LogBufferMgr *, char *, uint32_t);
    bool (*slogdBufferFullCheckFunc)(LogBufferMgr *, uint32_t);
    void (*slogdBufferResetFunc)(LogBufferMgr *);
} SlogdBufOperate;

static LogStatus SlogdDynamicBufInit(LogBufferMgr *bufMgr, uint32_t bufSize, int32_t logType, uint32_t devId);
static LogStatus SlogdStaticBufInit(LogBufferMgr *bufMgr, uint32_t bufSize, int32_t logType, uint32_t devId);
static void SlogdDynamicBufExit(LogBufferMgr **bufMgr);
static void SlogdStaticBufExit(LogBufferMgr **bufMgr);
static LogStatus SlogdDynamicBufWrite(LogBufferMgr *bufMgr, const char *msg, uint32_t msgLen);
static LogStatus SlogdStaticBufWrite(LogBufferMgr *bufMgr, const char *msg, uint32_t msgLen);
static int32_t SlogdDynamicBufRead(LogBufferMgr *bufMgr, char *msg, uint32_t msgLen);
static int32_t SlogdStaticBufRead(LogBufferMgr *bufMgr, char *msg, uint32_t msgLen);
static bool SlogdDynamicBufCheckFull(LogBufferMgr *bufMgr, uint32_t msgLen);
static bool SlogdStaticBufCheckFull(LogBufferMgr *bufMgr, uint32_t msgLen);
static void SlogdDynamicBufferReset(LogBufferMgr *bufMgr);
static void SlogdStaticBufferReset(LogBufferMgr *bufMgr);

static SlogdBufOperate g_slogdBufOperate[LOG_BUFFER_TYPE_NUM] = {
    {SlogdDynamicBufInit, SlogdDynamicBufExit, SlogdDynamicBufWrite,
     SlogdDynamicBufRead, SlogdDynamicBufCheckFull, SlogdDynamicBufferReset},
    {SlogdStaticBufInit, SlogdStaticBufExit, SlogdStaticBufWrite,
     SlogdStaticBufRead, SlogdStaticBufCheckFull, SlogdStaticBufferReset}};

static inline void SlogdBufMgrInit(LogBufferMgr *bufMgr, uint32_t bufSize, int32_t logType, uint32_t devId)
{
    bufMgr->logType = logType;
    bufMgr->bufferSize = bufSize;
    bufMgr->deviceId = devId;
    bufMgr->blockNum = bufSize / bufMgr->buffer->blockSize;
    bufMgr->buffer->data = (char *)bufMgr->buffer + BLOCK_HEADER_LEN;
    bufMgr->buffer->writePtr = BUF_DATA_OFFSET;
    bufMgr->buffer->readPtr = BUF_DATA_OFFSET;
    bufMgr->next = NULL;
    (void)ToolMutexInit(&bufMgr->lock);
}

static LogStatus SlogdDynamicBufInit(LogBufferMgr *bufMgr, uint32_t bufSize, int32_t logType, uint32_t devId)
{
    bufMgr->buffer = (BlockStruct *)LogMalloc(bufSize);
    if (bufMgr->buffer == NULL) {
        SELF_LOG_ERROR("malloc for log buffer[%d] failed.", logType);
        return LOG_FAILURE;
    }
    bufMgr->buffer->blockSize = bufSize;
    SlogdBufMgrInit(bufMgr, bufSize, logType, devId);
    return LOG_SUCCESS;
}

static LogStatus SlogdStaticBufInit(LogBufferMgr *bufMgr, uint32_t bufSize, int32_t logType, uint32_t devId)
{
    uint32_t size = bufSize;
    bufMgr->buffer = (BlockStruct *)log_type_alloc_mem(devId, (uint32_t)logType, &size);
    if (bufMgr->buffer == NULL) {
        SELF_LOG_ERROR("get log buffer[%d] from drv failed.", logType);
        return LOG_FAILURE;
    }
    if (size <= BLOCK_HEADER_LEN) {
        SELF_LOG_ERROR("get log buffer[%d] from drv is invalid, size[%u bytes]<minSize[%u bytes].", logType, size,
                       BLOCK_HEADER_LEN);
        return LOG_FAILURE;
    }
    // when the buffer has been initialized, read and record the data header content.
    if (bufMgr->buffer->magic != LOG_HEAD_MAGIC) {
        bufMgr->buffer->blockSize = NUM_MIN(size, LOG_BLOCK_SIZE);
        SlogdBufMgrInit(bufMgr, size, logType, devId);
        bufMgr->buffer->magic = LOG_HEAD_MAGIC;
        SELF_LOG_INFO("log[%d] buffer init finish, buffer size = %u bytes", logType, size);
    } else {
        bufMgr->logType = logType;
        bufMgr->bufferSize = size;
        bufMgr->deviceId = devId;
        bufMgr->blockNum = size / bufMgr->buffer->blockSize;
        bufMgr->buffer->data = (char *)bufMgr->buffer + BLOCK_HEADER_LEN;
        bufMgr->next = NULL;
        (void)ToolMutexInit(&bufMgr->lock);
        SELF_LOG_INFO("log[%d] buffer has been init, buffer size = %u bytes", logType, size);
    }
    return LOG_SUCCESS;
}

/**
 * @brief           : init slogd buffer
 * @param[in]       : logType        log buffer type
 * @param[in]       : bufSize        log buffer size
 * @param[in]       : devId          device id
 * @param[in]       : bufAttr        buffer attr
 * @return          : == LOG_SUCCESS success; others failure
 */
LogStatus SlogdBufferInit(int32_t logType, uint32_t bufSize, uint32_t devId, SlogdBufAttr *bufAttr)
{
    LogBufferMgr *bufMgr = (LogBufferMgr *)LogMalloc(sizeof(LogBufferMgr));
    if (bufMgr == NULL) {
        SELF_LOG_ERROR("malloc for log buffer[%d] mgr failed.", logType);
        return LOG_FAILURE;
    }
    if (g_slogdBufOperate[g_bufferMap[logType]].slogdBufferInitFunc(bufMgr, bufSize, logType, devId) != LOG_SUCCESS) {
        XFREE(bufMgr);
        return LOG_FAILURE;
    }
    if (bufAttr != NULL) {
        bufMgr->bufAttr.attr = bufAttr->attr;
        bufMgr->bufAttr.slogdBufAttrCompare = bufAttr->slogdBufAttrCompare;
    }
    // add to list head to keep consistent with the applog and grouplog nodes.
    if (g_slogdBufMgr[logType] == NULL) {
        g_slogdBufMgr[logType] = bufMgr;
    } else {
        bufMgr->next = g_slogdBufMgr[logType];
        g_slogdBufMgr[logType] = bufMgr;
    }
    return LOG_SUCCESS;
}

static void SlogdDynamicBufExit(LogBufferMgr **bufMgr)
{
    XFREE((*bufMgr)->buffer);
    XFREE(*bufMgr);
}

static void SlogdStaticBufExit(LogBufferMgr **bufMgr)
{
    XFREE(*bufMgr);
}

static void SlogdBufferAllExit(int32_t logType)
{
    LogBufferMgr *next = NULL;
    while (g_slogdBufMgr[logType] != NULL) {
        next = g_slogdBufMgr[logType]->next;
        g_slogdBufOperate[g_bufferMap[logType]].slogdBufferExitFunc(&g_slogdBufMgr[logType]);
        g_slogdBufMgr[logType] = next;
    }
}

/**
 * @brief           : exit slogd buffer, support specify index
 * @param[in]       : logType        log buffer type
 * @param[in]       : bufIdx            log buffer list index,
                                        -1: all buffer in this type, other: specified index buffer
 * @return          : NA
 */
void SlogdBufferExit(int32_t logType, void *attr)
{
    if (attr == NULL) {
        SlogdBufferAllExit(logType);
        return;
    }
    LogBufferMgr *pre = NULL;
    LogBufferMgr *next = NULL;
    LogBufferMgr *head = g_slogdBufMgr[logType];
    while (g_slogdBufMgr[logType] != NULL) {
        next = g_slogdBufMgr[logType]->next;
        if (g_slogdBufMgr[logType]->bufAttr.slogdBufAttrCompare != NULL) {
            if (g_slogdBufMgr[logType]->bufAttr.slogdBufAttrCompare(g_slogdBufMgr[logType]->bufAttr.attr, attr)) {
                g_slogdBufOperate[g_bufferMap[logType]].slogdBufferExitFunc(&g_slogdBufMgr[logType]);
                if (pre == NULL) {
                    head = next;
                } else {
                    pre->next = next;
                }
                break;
            }
        }
        pre = g_slogdBufMgr[logType];
        g_slogdBufMgr[logType] = next;
    }
    g_slogdBufMgr[logType] = head;
}

static LogStatus SlogdBufferReadHandleOpen(LogBufferMgr **handle, LogBufferMgr *oriBufMgr)
{
    *handle = (LogBufferMgr *)LogMalloc(sizeof(LogBufferMgr));
    if (*handle == NULL) {
        SELF_LOG_ERROR("malloc for read handle failed, buffer type = %d.", oriBufMgr->logType);
        return LOG_FAILURE;
    }
    errno_t err = memcpy_s(*handle, sizeof(LogBufferMgr), oriBufMgr, sizeof(LogBufferMgr));
    if (err != EOK) {
        SELF_LOG_ERROR("memcpy for read handle failed, buffer type = %d.", oriBufMgr->logType);
        XFREE(*handle);
        return LOG_FAILURE;
    }
    (*handle)->operaMode = LOG_BUFFER_READ_MODE;
    (*handle)->buffer = (BlockStruct *)LogMalloc(BLOCK_HEADER_LEN);
    if ((*handle)->buffer == NULL) {
        SELF_LOG_ERROR("malloc for read handle block failed, buffer type = %d.", oriBufMgr->logType);
        XFREE(*handle);
        return LOG_FAILURE;
    }
    err = memcpy_s((*handle)->buffer, BLOCK_HEADER_LEN, oriBufMgr->buffer, BLOCK_HEADER_LEN);
    if (err != EOK) {
        SELF_LOG_ERROR("memcpy for read handle buffer failed, buffer type = %d.", oriBufMgr->logType);
        XFREE((*handle)->buffer);
        XFREE(*handle);
        return LOG_FAILURE;
    }
    (*handle)->buffer->data = oriBufMgr->buffer->data;
    if (g_bufferMap[(*handle)->logType] == LOG_STATIC_BUFFER) {
        // the read pointer is placed at the beginning, and the write pointer is placed at the end of the buffer
        // to ensure that the entire buffer can be read.
        (*handle)->buffer->readPtr = BUF_DATA_OFFSET;
        (*handle)->buffer->writePtr = (*handle)->bufferSize - 1U;
    }
    return LOG_SUCCESS;
}

/**
 * @brief           : get slogd buffer handle, support specify index
 * @param[in]       : logType           log buffer type
 * @param[in]       : attr              log buffer attr
 * @param[in]       : operaMode         determine whether to modify bufMgr,
                                        support LOG_BUFFER_WRITE_MODE/LOG_BUFFER_READ_MODE
 * @param[in]       : devId             device id
 * @return          : NA
 */
void *SlogdBufferHandleOpen(int32_t logType, void *attr, uint32_t operaMode, uint32_t devId)
{
    LogBufferMgr *bufMgr = g_slogdBufMgr[logType];
    while (bufMgr != NULL) {
        // if attr compare func is not specified, devId is used for verification.
        if (bufMgr->bufAttr.slogdBufAttrCompare != NULL) {
            if (bufMgr->bufAttr.slogdBufAttrCompare(attr, bufMgr->bufAttr.attr)) {
                break;
            }
        } else if (bufMgr->deviceId == devId) {
            break;
        } else {
            ;
        }
        bufMgr = bufMgr->next;
    }
    if ((bufMgr == NULL) || (bufMgr->buffer == NULL)) {
        return NULL;
    }

    if (operaMode == LOG_BUFFER_WRITE_MODE) {
        return (void *)bufMgr;
    } else if (operaMode == LOG_BUFFER_READ_MODE) {
        LogBufferMgr *handle = NULL;
        LogStatus ret = SlogdBufferReadHandleOpen(&handle, bufMgr);
        if (ret != LOG_SUCCESS) {
            return NULL;
        }
        return (void *)handle;
    } else {
        return NULL;
    }
}

void SlogdBufferHandleClose(void **handle)
{
    if ((handle == NULL) || (*handle == NULL)) {
        return;
    }
    if (((LogBufferMgr *)*handle)->operaMode == LOG_BUFFER_READ_MODE) {
        XFREE(((LogBufferMgr *)*handle)->buffer);
        XFREE(*handle);
    }
    return;
}

static LogStatus SlogdDynamicBufWrite(LogBufferMgr *bufMgr, const char *msg, uint32_t msgLen)
{
    BlockStruct *blockHead = bufMgr->buffer;
    uint32_t curBlkSpace = bufMgr->bufferSize - blockHead->writePtr;
    // if the remaining space of the current round is insufficient for writing, data is written from the next round.
    if (curBlkSpace <= msgLen) {
        // if writePtr will catch up with readPtr, no valid space remains to write, return failure
        if ((blockHead->readPtr > blockHead->writePtr) || (blockHead->readPtr - BUF_DATA_OFFSET < msgLen)) {
            return LOG_FAILURE;
        }
        errno_t err = memset_s(BUF_START_ATTR(blockHead) + blockHead->writePtr, curBlkSpace, 0, curBlkSpace);
        ONE_ACT_ERR_LOG(err != EOK, return LOG_FAILURE, "memset failed, write log to ring buffer failed, err = %d.",
                        (int32_t)err);
        blockHead->writePtr = BUF_DATA_OFFSET;
        bufMgr->roundFlag = 1;
    }
    if (blockHead->writePtr < blockHead->readPtr) {
        curBlkSpace = blockHead->readPtr - blockHead->writePtr;
    } else {
        curBlkSpace = bufMgr->bufferSize - blockHead->writePtr;
    }
    if (curBlkSpace <= msgLen) {
        SELF_LOG_WARN("remaining space is insufficient, can not write log to ring buffer, msgLen = %u.", msgLen);
        return LOG_FAILURE;  // current block has no space left
    }
    errno_t ret = memcpy_s(BUF_START_ATTR(blockHead) + blockHead->writePtr, curBlkSpace, msg, msgLen);
    ONE_ACT_ERR_LOG(ret != EOK, return LOG_FAILURE, "memcpy failed, write log to ring buffer failed, ret = %d.",
                    (int32_t)ret);
    blockHead->writePtr += msgLen;
    blockHead->dataLen += msgLen;
    return LOG_SUCCESS;
}

static LogStatus SlogdStaticBufWrite(LogBufferMgr *bufMgr, const char *msg, uint32_t msgLen)
{
    BlockStruct *blockHead = bufMgr->buffer;
    // determine the current block.
    uint32_t curBlkIdx = blockHead->writePtr / blockHead->blockSize;
    uint32_t curBlkOffset = curBlkIdx * blockHead->blockSize;
    BlockStruct *curBlkHead = (BlockStruct *)(BUF_START_ATTR(blockHead) + curBlkOffset);
    uint32_t curBlkSpace = (curBlkIdx + 1U) * blockHead->blockSize - blockHead->writePtr;
    // remaining space of the current block is insufficient.
    // data needs to be written from the start address of the next block.
    if (curBlkSpace <= msgLen) {
        // clear data of next block.
        curBlkIdx = (curBlkIdx + 1U) % bufMgr->blockNum;
        // if readPtr is in the block specified by blockIdx, move readPtr to the start of the next block.
        if (blockHead->readPtr / blockHead->blockSize == curBlkIdx) {
            blockHead->readPtr = (curBlkIdx + 1U) % bufMgr->blockNum * blockHead->blockSize + BLOCK_HEADER_LEN;
        }
        curBlkOffset = curBlkIdx * blockHead->blockSize;
        curBlkHead = (BlockStruct *)(BUF_START_ATTR(blockHead) + curBlkOffset);
        curBlkSpace = blockHead->blockSize - BLOCK_HEADER_LEN;
        (void)memset_s((char *)curBlkHead + BLOCK_HEADER_LEN, curBlkSpace, 0, curBlkSpace);
        curBlkHead->dataLen = 0;
        blockHead->writePtr = curBlkOffset + BLOCK_HEADER_LEN;
    }
    // if writePtr is at the block start address, update the timestamp.
    if (blockHead->writePtr == curBlkOffset + BLOCK_HEADER_LEN) {
        (void)memset_s(curBlkHead->timeStr, TIME_STR_SIZE, 0, TIME_STR_SIZE);
        if (LogGetTimeStr(curBlkHead->timeStr, TIME_STR_SIZE) != LOG_SUCCESS) {
            SELF_LOG_ERROR("get time string failed, write log to ring buffer failed.");
            return LOG_FAILURE;
        }
    }
    // appending data to the current block
    errno_t err = memcpy_s(BUF_START_ATTR(blockHead) + blockHead->writePtr, curBlkSpace, msg, msgLen);
    ONE_ACT_ERR_LOG(err != EOK, return LOG_FAILURE, "memcpy failed, write log to ring buffer failed, ret = %d.",
                    (int32_t)err);
    curBlkHead->dataLen += msgLen;
    blockHead->writePtr += msgLen;
    return LOG_SUCCESS;
}

/**
 * @brief           : write log to slogd buffer,
                      before invoking this interface,
                      ensure that buffer has sufficient space with interface SlogdBufferCheckFull.
 * @param[in]       : handle        log buffer handle
 * @param[in]       : msg           log message
 * @param[in]       : msgLen        log length
 * @return          : == LOG_SUCCESS success; others failure
 */
LogStatus SlogdBufferWrite(void *handle, const char *msg, uint32_t msgLen)
{
    ONE_ACT_ERR_LOG(handle == NULL, return LOG_INVALID_PTR, "check log buffer failed, input handle is null.");
    LogBufferMgr *bufMgr = (LogBufferMgr *)handle;
    (void)ToolMutexLock(&g_slogdBufMgr[bufMgr->logType]->lock);
    if (bufMgr->buffer == NULL) {
        (void)ToolMutexUnLock(&g_slogdBufMgr[bufMgr->logType]->lock);
        SELF_LOG_ERROR("buffer is invalid, write msg to buffer failed.");
        return LOG_INVALID_PTR;
    }
    if ((msg == NULL) || (msgLen > (size_t)bufMgr->bufferSize)) {
        (void)ToolMutexUnLock(&g_slogdBufMgr[bufMgr->logType]->lock);
        SELF_LOG_ERROR("msg is invalid, write msg to buffer failed, msgLen = %u.", msgLen);
        return LOG_INVALID_PTR;
    }
    LogStatus ret = g_slogdBufOperate[g_bufferMap[bufMgr->logType]].slogdBufferWriteFunc(bufMgr, msg, msgLen);
    (void)ToolMutexUnLock(&g_slogdBufMgr[bufMgr->logType]->lock);
    return ret;
}

static int32_t SlogdDynamicBufRead(LogBufferMgr *bufMgr, char *msg, uint32_t msgLen)
{
    uint32_t ret = 0;
    errno_t err = EOK;
    BlockStruct *blockHead = bufMgr->buffer;
    if (blockHead->writePtr == blockHead->readPtr) {
        ret = 0;
    } else if (blockHead->writePtr > blockHead->readPtr) {
        uint32_t curBlkSpace = blockHead->writePtr - blockHead->readPtr;
        uint32_t readLen = NUM_MIN(curBlkSpace, msgLen);
        err = memcpy_s(msg, msgLen, BUF_START_ATTR(blockHead) + blockHead->readPtr, readLen);
        ONE_ACT_ERR_LOG(err != EOK, return -1, "memcpy failed, read log buffer failed, err = %d.", (int32_t)err);
        blockHead->readPtr += readLen;
        blockHead->dataLen -= readLen;
        ret = readLen;
    } else {
        uint32_t curBlkSpace = blockHead->dataLen - (blockHead->writePtr - BUF_DATA_OFFSET);
        if (curBlkSpace >= msgLen) {
            err = memcpy_s(msg, msgLen, BUF_START_ATTR(blockHead) + blockHead->readPtr, msgLen);
            ONE_ACT_ERR_LOG(err != EOK, return -1, "memcpy failed, read log buffer failed, err = %d.", (int32_t)err);
            blockHead->readPtr += msgLen;
            blockHead->dataLen -= msgLen;
            ret = msgLen;
        } else {
            err = memcpy_s(msg, msgLen, BUF_START_ATTR(blockHead) + blockHead->readPtr, curBlkSpace);
            ONE_ACT_ERR_LOG(err != EOK, return -1, "memcpy failed, read log buffer failed, err = %d.",
                            (int32_t)err);
            uint32_t readLen = NUM_MIN(msgLen - curBlkSpace, blockHead->writePtr - BUF_DATA_OFFSET);
            err = memcpy_s(msg + curBlkSpace, (size_t)msgLen - (size_t)curBlkSpace, blockHead->data, readLen);
            ONE_ACT_ERR_LOG(err != EOK, return -1, "memcpy failed, read log buffer failed, err = %d.",
                            (int32_t)err);
            blockHead->readPtr = BUF_DATA_OFFSET + readLen;
            blockHead->dataLen = blockHead->dataLen - curBlkSpace - readLen;
            ret = curBlkSpace + readLen;
        }
    }
    return (int32_t)ret;
}

static int32_t SlogdStaticBufRead(LogBufferMgr *bufMgr, char *msg, uint32_t msgLen)
{
    BlockStruct *blockHead = bufMgr->buffer;
    if (blockHead->readPtr == blockHead->writePtr) {
        return 0;
    }
    uint32_t curReadBlkIdx = blockHead->readPtr / blockHead->blockSize;
    uint32_t curWriteBlkIdx = blockHead->writePtr / blockHead->blockSize;
    uint32_t readLen = NUM_MIN(msgLen, (uint32_t)strlen(BUF_START_ATTR(blockHead) + blockHead->readPtr));
    if (readLen == 0) {
        if (curReadBlkIdx == curWriteBlkIdx) {
            blockHead->readPtr = blockHead->writePtr;
            return 0;
        }
        curReadBlkIdx++;
        blockHead->readPtr = curReadBlkIdx % bufMgr->blockNum * blockHead->blockSize + BLOCK_HEADER_LEN;
        if (blockHead->readPtr == blockHead->writePtr) {
            return 0;
        }
        readLen = NUM_MIN(msgLen, (uint32_t)strlen(BUF_START_ATTR(blockHead) + blockHead->readPtr));
    }
    errno_t err = 0;
    if (bufMgr->operaMode == LOG_BUFFER_READ_MODE) {
        if (msgLen > (uint32_t)sizeof(SlogdMsgData)) {
            // determine the current block.
            uint32_t curBlkOffset = curReadBlkIdx * blockHead->blockSize;
            BlockStruct *curBlkHead = (BlockStruct *)(BUF_START_ATTR(blockHead) + curBlkOffset);
            SlogdMsgData *data = (SlogdMsgData *)msg;
            data->data = msg + sizeof(SlogdMsgData);
            err = memcpy_s(data->timeStr, TIME_STR_SIZE, curBlkHead->timeStr, TIME_STR_SIZE);
            ONE_ACT_ERR_LOG(err != EOK, return -1, "memcpy failed, read log buffer time string failed, err = %d.",
                (int32_t)err);
            err = memcpy_s(data->data, (size_t)msgLen - sizeof(SlogdMsgData),
                           BUF_START_ATTR(blockHead) + blockHead->readPtr, readLen);
            ONE_ACT_ERR_LOG(err != EOK, return -1, "memcpy failed, read log buffer failed, err = %d.", (int32_t)err);
        } else {
            SELF_LOG_ERROR("read log buffer failed, length[%u bytes] is invalid.", msgLen);
            return -1;
        }
        if (curReadBlkIdx == bufMgr->blockNum - 1U) {
            blockHead->readPtr = blockHead->writePtr;
        } else {
            blockHead->readPtr = (curReadBlkIdx + 1U) * blockHead->blockSize + BLOCK_HEADER_LEN;
        }
    } else {
        err = memcpy_s(msg, msgLen, BUF_START_ATTR(blockHead) + blockHead->readPtr, readLen);
        ONE_ACT_ERR_LOG(err != EOK, return -1, "memcpy failed, read log buffer failed, err = %d.", (int32_t)err);
        blockHead->readPtr += readLen;
    }
    return (int32_t)readLen;
}

/**
 * @brief           : read log from slogd buffer
 * @param[in]       : handle        log buffer handle
 * @param[out]      : msg           log message
 * @param[in]       : msgLen        log message length
 * @return          : >=0 msg length; <0 failed
 */
int32_t SlogdBufferRead(void *handle, char *msg, uint32_t msgLen)
{
    ONE_ACT_ERR_LOG(handle == NULL, return -1, "check log buffer failed, input handle is null.");
    ONE_ACT_ERR_LOG((msg == NULL) || (msgLen == 0), return -1, "msg is invalid, write msg to buffer failed.");
    (void)memset_s(msg, msgLen, 0, msgLen);
    LogBufferMgr *bufMgr = (LogBufferMgr *)handle;
    (void)ToolMutexLock(&g_slogdBufMgr[bufMgr->logType]->lock);
    int32_t ret = g_slogdBufOperate[g_bufferMap[bufMgr->logType]].slogdBufferReadFunc(bufMgr, msg, msgLen);
    (void)ToolMutexUnLock(&g_slogdBufMgr[bufMgr->logType]->lock);
    return ret;
}

uint32_t SlogdBufferGetBufSize(int32_t logType)
{
    return g_slogdBufMgr[logType]->buffer->blockSize - BLOCK_HEADER_LEN;
}

static void SlogdDynamicBufferReset(LogBufferMgr *bufMgr)
{
    ONE_ACT_ERR_LOG(bufMgr->buffer == NULL, return, "check log buffer failed, input buffer is null.");
    BlockStruct *blockHead = bufMgr->buffer;
    blockHead->readPtr = blockHead->writePtr;
    blockHead->dataLen = 0;
}

static void SlogdStaticBufferReset(LogBufferMgr *bufMgr)
{
    ONE_ACT_ERR_LOG(bufMgr->buffer == NULL, return, "check log buffer failed, input buffer is null.");
    BlockStruct *blockHead = bufMgr->buffer;
    blockHead->readPtr = (blockHead->readPtr / blockHead->blockSize + 1U) % bufMgr->blockNum +
        (uint32_t)sizeof(BlockStruct);
}

void SlogdBufferReset(void *handle)
{
    ONE_ACT_ERR_LOG(handle == NULL, return, "check log buffer failed, input handle is null.");
    LogBufferMgr *bufMgr = (LogBufferMgr *)handle;
    (void)ToolMutexLock(&g_slogdBufMgr[bufMgr->logType]->lock);
    g_slogdBufOperate[g_bufferMap[bufMgr->logType]].slogdBufferResetFunc(bufMgr);
    (void)ToolMutexUnLock(&g_slogdBufMgr[bufMgr->logType]->lock);
    return;
}

static bool SlogdDynamicBufCheckFull(LogBufferMgr *bufMgr, uint32_t msgLen)
{
    BlockStruct *blockHead = bufMgr->buffer;
    uint32_t freeSpace = 0;
    if (blockHead->writePtr >= blockHead->readPtr) {
        freeSpace = NUM_MAX(bufMgr->bufferSize - blockHead->writePtr, blockHead->readPtr - BUF_DATA_OFFSET);
    } else {
        freeSpace = blockHead->readPtr - blockHead->writePtr;
    }
    return freeSpace <= msgLen;  // one bit needs to be reserved \0
}

static bool SlogdStaticBufCheckFull(LogBufferMgr *bufMgr, uint32_t msgLen)
{
    BlockStruct *blockHead = bufMgr->buffer;
    // the remaining space of the block is sufficient
    uint32_t freeSpace = blockHead->blockSize - blockHead->writePtr % blockHead->blockSize;
    if (freeSpace > msgLen) {
        return false;
    }
    // if the read pointer is in the next block, the buffer is full. Otherwise, the buffer is not full.
    uint32_t curWriteBlkIdx = blockHead->writePtr / blockHead->blockSize;
    uint32_t curReadBlkIdx = blockHead->readPtr / blockHead->blockSize;
    if ((curWriteBlkIdx + 1U) % bufMgr->blockNum == curReadBlkIdx) {
        return true;
    } else {
        return false;
    }
}

/**
 * @brief           : check slogd buffer is full
 * @param[in]       : handle        log buffer handle
 * @param[in]       : msgLen        next messages length
 * @return          : == true full; false not full
 */
bool SlogdBufferCheckFull(void *handle, uint32_t msgLen)
{
    ONE_ACT_ERR_LOG(handle == NULL, return false, "check log buffer failed, input handle is null.");
    LogBufferMgr *bufMgr = (LogBufferMgr *)handle;
    (void)ToolMutexLock(&g_slogdBufMgr[bufMgr->logType]->lock);
    TWO_ACT_ERR_LOG(bufMgr->buffer == NULL, (void)ToolMutexUnLock(&g_slogdBufMgr[bufMgr->logType]->lock), return false,
                    "check log buffer failed, input buffer is null.");
    bool isFull = g_slogdBufOperate[g_bufferMap[bufMgr->logType]].slogdBufferFullCheckFunc(bufMgr, msgLen);
    (void)ToolMutexUnLock(&g_slogdBufMgr[bufMgr->logType]->lock);
    return isFull;
}

/**
 * @brief           : check slogd buffer is empty
 * @param[in]       : handle        log buffer handle
 * @return          : == true full; false not full
 */
bool SlogdBufferCheckEmpty(void *handle)
{
    if (handle == NULL) {
        return true;
    }
    LogBufferMgr *bufMgr = (LogBufferMgr *)handle;
    if ((bufMgr->buffer == NULL) || (bufMgr->buffer->writePtr == bufMgr->buffer->readPtr)) {
        return true;
    }
    return false;
}

/**
 * @brief           : find next log from loc
 * @param[in]       : buf           log buffer data
 * @param[in]       : size          target buffer max index
 * @param[out]      : loc           first index of next complete log
 */
STATIC void SlogdBufferFindLocation(char *buf, uint32_t size, uint32_t *loc)
{
    if (*loc == 0) {
        return;
    }
    char cEnd = '\0';
    char cFirst = '\0';
    uint32_t i = 0;
    while (i < size) {
        cEnd = *(buf + *loc - 1);
        cFirst = *(buf + *loc);
        if ((cEnd == '\n') && (cFirst == '[')) {
            break;
        }
        (*loc)++;
        i++;
    }
}

/**
 * @brief           : collect newest log from logBuf to buf
 * @param[out]      : buf           buffer to store newest log
 * @param[in]       : bufSize       buffer size
 * @param[out]      : pos           buffer offset
 * @param[in]       : handle        log buffer handle
 * @param[in]       : size          max size to collect from logBuf
 * @return          : == LOG_SUCCESS success; others failure
 */
LogStatus SlogdBufferCollectNewest(char *buf, uint32_t bufSize, uint32_t *pos, void *handle, uint32_t size)
{
    ONE_ACT_ERR_LOG((buf == NULL) || (pos == NULL) || (handle == NULL), return LOG_INVALID_PTR,
                    "input ptr is null, collect newest log failed.");
    LogBufferMgr *bufMgr = (LogBufferMgr *)handle;
    (void)ToolMutexLock(&g_slogdBufMgr[bufMgr->logType]->lock);
    TWO_ACT_ERR_LOG(bufMgr->buffer == NULL, (void)ToolMutexUnLock(&g_slogdBufMgr[bufMgr->logType]->lock), return LOG_INVALID_PTR,
                    "check log buffer failed, input buffer is null.");
    BlockStruct *blockHead = bufMgr->buffer;
    uint32_t logSize = size;
    if (bufMgr->roundFlag == 0) {
        logSize = NUM_MIN(size, blockHead->writePtr - BUF_DATA_OFFSET);
    }
    // if bufMgr not full or log from start to writeIndex is enough
    uint32_t dataLen = 0;
    uint32_t validLen = 0;
    errno_t ret = EOK;
    if ((bufMgr->roundFlag == 0) || (blockHead->writePtr - BUF_DATA_OFFSET >= logSize)) {
        uint32_t startLoc = blockHead->writePtr - BUF_DATA_OFFSET - logSize;
        SlogdBufferFindLocation(blockHead->data, logSize, &startLoc);
        dataLen = logSize - startLoc;
        validLen = bufSize - *pos;
        ret = memcpy_s(buf + *pos, validLen, blockHead->data + startLoc, dataLen);
        TWO_ACT_ERR_LOG(ret != EOK, ((void)ToolMutexUnLock(&g_slogdBufMgr[bufMgr->logType]->lock)), return LOG_FAILURE,
                        "memcpy failed, ret=%d, collect newest log failed.", ret);
        *pos += dataLen;
    } else {
        // calculate size that should be collect from last round
        char *dataHead = blockHead->data - BLOCK_HEADER_LEN;
        uint32_t endSize = logSize - (blockHead->writePtr - BUF_DATA_OFFSET);
        endSize = NUM_MIN(endSize, bufMgr->bufferSize - blockHead->writePtr);
        uint32_t startLoc = bufMgr->bufferSize - endSize;
        SlogdBufferFindLocation(dataHead, endSize, &startLoc);
        // copy from last round
        dataLen = bufMgr->bufferSize - startLoc;
        validLen = bufSize - *pos;
        ret = memcpy_s(buf + *pos, validLen, dataHead + startLoc, dataLen);
        TWO_ACT_ERR_LOG(ret != EOK, ((void)ToolMutexUnLock(&g_slogdBufMgr[bufMgr->logType]->lock)), return LOG_FAILURE,
                        "memcpy failed, collect newest log failed, ret = %d.", (int32_t)ret);
        *pos = LogStrlen(buf);
        dataLen = blockHead->writePtr - BUF_DATA_OFFSET;
        validLen = bufSize - *pos;
        ret = memcpy_s(buf + *pos, validLen, dataHead, dataLen);
        TWO_ACT_ERR_LOG(ret != EOK, (void)ToolMutexUnLock(&g_slogdBufMgr[bufMgr->logType]->lock), return LOG_FAILURE,
                        "memcpy failed, collect newest log failed, ret = %d.", (int32_t)ret);
        *pos += dataLen;
    }
    (void)ToolMutexUnLock(&g_slogdBufMgr[bufMgr->logType]->lock);
    return LOG_SUCCESS;
}