/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "trace_rb_log.h"
#include "trace_system_api.h"
#include "adiag_print.h"
#include "adiag_utils.h"
#include "trace_attr.h"
#include "securec.h"
#include "trace_types.h"
#include "adiag_list.h"

#define AVERAGE(a, b) (((a) + (b)) >> 1)
#define MIN(a, b) ((a) > (b) ? (b) : (a))
#define AO_F_ADD(ptr, value)        ((__typeof__(*(ptr)))__sync_fetch_and_add((ptr), (value)))
#define AO_SUB_F(ptr, value)        ((__typeof__(*(ptr)))__sync_sub_and_fetch((ptr), (value)))
#define AO_SET(ptr, value)          ((void)__sync_lock_test_and_set((ptr), (value)))
#define AO_CASB(ptr, comp, value)   (__sync_bool_compare_and_swap((ptr), (comp), (value)))
#define MAX_RING_BUFFER_SIZE 1024U
#define MIN_RING_BUFFER_SIZE 1U
#define MAX_MSG_SIZE 1024U
#define MIN_MSG_SIZE 64U
#define MAX_RING_BUFFER_SPACE 131072U // 128M

STATIC INLINE void TraceRbLogInitTime(struct RbLogCtrl *head)
{
    uint64_t realTime1 = GetRealTime();
    uint64_t monotonicTime1 = GetCpuCycleCounter();
    uint64_t monotonicTime2 = GetCpuCycleCounter();
    uint64_t realTime2 = GetRealTime();
    head->realTime = AVERAGE(realTime1, realTime2);
    head->monotonicTime = AVERAGE(monotonicTime1, monotonicTime2);
    if (TraceGetTimeOffset(&head->minutesWest) != TRACE_SUCCESS) {
        ADIAG_WAR("can not get time offset.");
    }
    head->cpuFreq = GetCpuFrequency();
    ADIAG_INF("init ring buffer time finished, realTime %llu, monotonicTime %llu, freq %llu kHz, minutesWest %d minutes",
        head->realTime, head->monotonicTime, head->cpuFreq, head->minutesWest);
}

STATIC bool TraceRbLogCheckParam(const char *name, const TraceAttr *attr)
{
    ADIAG_CHK_NULL_PTR(name, return false);
    ADIAG_CHK_NULL_PTR(attr, return false);
    if ((attr->msgNum != 0) && (attr->msgNum > MAX_RING_BUFFER_SIZE || attr->msgNum < MIN_RING_BUFFER_SIZE)) {
        ADIAG_ERR("[%s] msg num %u out of range [%u, %u]",
            name, attr->msgNum, MIN_RING_BUFFER_SIZE, MAX_RING_BUFFER_SIZE);
        return false;
    }
    if ((attr->msgSize != 0) && (attr->msgSize > MAX_MSG_SIZE || attr->msgSize < MIN_MSG_SIZE)) {
        ADIAG_ERR("[%s] msg size %u out of range [%u, %u] bytes", name, attr->msgSize, MIN_MSG_SIZE, MAX_MSG_SIZE);
        return false;
    }
    return true;
}

STATIC INLINE TraStatus TraceRbLogInitDataStruct(struct RbLog *rb, const TraceAttr *attr)
{
    for (uint32_t i = 0; i < TRACE_STRUCT_ENTRY_MAX_NUM; i++) {
        if (attr->handle[i] == NULL) {
            continue;
        }
        if (attr->handle[i]->list == NULL) {
            ADIAG_ERR("[%s] struct list is invalid.", attr->handle[i]->name);
            return TRACE_FAILURE;
        }
        errno_t ret = strcpy_s(rb->entry[i].name, TRACE_NAME_LENGTH, attr->handle[i]->name);
        if (ret != EOK) {
            ADIAG_ERR("[%s] strncpy_s data struct name failed.", attr->handle[i]->name);
            return TRACE_FAILURE;
        }
        rb->entry[i].list = attr->handle[i]->list;
        attr->handle[i]->list = NULL;
    }
    return TRACE_SUCCESS;
}

/**
 * @brief       create log ringbuffer
 * @param [in]  name:       ringbuffer name
 * @param [in]  bufSize:    ringbuffer size
 * @return      ring buffer ptr
 */
struct RbLog *TraceRbLogCreate(const char *name, const TraceAttr *attr)
{
    if (!TraceRbLogCheckParam(name, attr)) {
        return NULL;
    }
    uint32_t bufferSize = (attr->msgNum == 0) ? DEFAULT_ATRACE_MSG_NUM : attr->msgNum;
    uint32_t msgTxtSize = (attr->msgSize == 0) ? DEFAULT_ATRACE_MSG_SIZE : attr->msgSize;

    if ((bufferSize & (bufferSize - 1U)) != 0) { // bufSize if not power of 2
        bufferSize = GetNearestPowerOfTwo(bufferSize);
        ADIAG_WAR("[%s] buffer size if not power of 2, resize to %u bytes", name, bufferSize);
    }
    uint32_t msgSize = msgTxtSize + (uint32_t)sizeof(RbMsgHead);
    size_t totalSize = (size_t)msgSize * bufferSize;
    if (msgSize * bufferSize > MAX_RING_BUFFER_SPACE) {
        ADIAG_ERR("[%s] buffer space %zu bytes exceed max buffer space %u bytes", name, totalSize, MAX_RING_BUFFER_SPACE);
        return NULL;
    }
    totalSize += sizeof(RbLog);
    struct RbLog *rb = AdiagMalloc(totalSize);
    if (rb == NULL) {
        ADIAG_ERR("[%s] malloc ring buffer failed.", name);
        return NULL;
    }
    struct RbLogCtrl *head = &rb->head;
    errno_t ret = strcpy_s(head->name, sizeof(head->name), name);
    if (ret != EOK) {
        ADIAG_ERR("[%s] strcpy_s ring buffer name failed, ret : %d.", name, ret);
        ADIAG_SAFE_FREE(rb);
        return NULL;
    }
    if (TraceRbLogInitDataStruct(rb, attr) != TRACE_SUCCESS) {
        ADIAG_ERR("[%s] init data struct failed.", name);
        ADIAG_SAFE_FREE(rb);
        return NULL;
    }
    head->readIdx = 0;
    head->writeIdx = 0;
    head->bufSize = bufferSize;
    head->msgSize = msgSize;
    head->msgTxtSize = msgTxtSize;
    head->mask = bufferSize - 1U;
    head->errCount = 0;
    TraceRbLogInitTime(head);
    ADIAG_INF("[%s] create ring buffer successfully, "
        "msgSize %u bytes, msgTxtSize %u bytes, bufferSize %u bytes, msg space %u bytes, total space %zu bytes",
        name, msgSize, msgTxtSize, bufferSize, msgSize, totalSize);
    return rb;
}

/**
 * @brief       destroy log ringbuffer
 * @param [in]  rb:         ringbuffer ptr
 * @return      NA
 */
void TraceRbLogDestroy(struct RbLog *rb)
{
    if (rb != NULL) {
        for (uint32_t i = 0; i < TRACE_STRUCT_ENTRY_MAX_NUM; i++) {
            if (rb->entry[i].list != NULL) {
                (void)AdiagListDestroy((struct AdiagList *)rb->entry[i].list);
                ADIAG_SAFE_FREE(rb->entry[i].list);
            }
        }
        ADIAG_SAFE_FREE(rb);
    }
}

STATIC INLINE RbLogMsg *TraceRbLogGetMsgByIndex(struct RbLog *rb, uint32_t msgIndex)
{
    return (RbLogMsg *)(rb->msg + rb->head.msgSize * msgIndex);
}

/**
 * @brief       write log msg to ringbuffer
 * @param [in]  rb:         ringbuffer ptr, caller guarantees not be NULL
 * @param [in]  buffer:     data buffer
 * @param [in]  bufSize:    data buffer size
 * @return      TraStatus
 */
TraStatus TraceRbLogWriteRbMsg(struct RbLog *rb, uint8_t bufferType, const char *buffer, uint32_t bufSize)
{
    ADIAG_CHK_NULL_PTR(buffer, return TRACE_INVALID_PARAM);
    ADIAG_CHK_EXPR_ACTION(bufSize == 0, return TRACE_INVALID_PARAM, "invalid bufSize 0");
    uint32_t txtSize = bufSize;
    if (txtSize > rb->head.msgTxtSize) {
        ADIAG_WAR("[%s] msg size %u bytes exceeded ringbuffer msg size %u bytes, truncated.",
            rb->head.name, txtSize, rb->head.msgTxtSize);
        txtSize = rb->head.msgTxtSize;
    }
    uint64_t monotonicTime = GetCpuCycleCounter();
    uint64_t originalWriteIdx = AO_F_ADD(&rb->head.writeIdx, 1);
    uint32_t writeIdx = (uint32_t)(originalWriteIdx & rb->head.mask);
    RbLogMsg *msg = TraceRbLogGetMsgByIndex(rb, writeIdx);
    if (!AO_CASB(&msg->head.busy, false, true)) {
        uint32_t errCount = AO_F_ADD(&rb->head.errCount, 1);
        if ((errCount & rb->head.mask) == 0) {
            ADIAG_WAR("[%s] can not write msg [%s] to index %u, buffer is busy", rb->head.name, buffer, writeIdx);
        }
        return TRACE_FAILURE;
    }
    int32_t ret = memcpy_s(msg->txt, rb->head.msgTxtSize, buffer, txtSize);
    if (ret != EOK) {
        ADIAG_ERR("[%s] memcpy_s ringbuffer msg failed.", rb->head.name);
        return TRACE_FAILURE;
    }
    msg->head.cycle = monotonicTime - rb->head.monotonicTime;
    msg->head.txtSize = txtSize;
    msg->head.bufferType = bufferType;
    AO_SET(&msg->head.busy, false);
    return TRACE_SUCCESS;
}

TraStatus TraceRbLogWriteRbMsgNoLock(struct RbLog *rb, uint8_t bufferType, const char *buffer, uint32_t bufSize)
{
    if ((buffer == NULL) || (bufSize == 0)) {
        return TRACE_INVALID_PARAM;
    }
    struct RbLogCtrl *head = &rb->head;
    RbLogMsg *msg = (RbLogMsg *)(rb->msg + head->msgSize * (uint32_t)((++head->writeIdx) & head->mask));
    uint32_t txtSize = MIN(bufSize, head->msgTxtSize);

    int32_t ret = memcpy_s(msg->txt, head->msgTxtSize, buffer, txtSize);
    if (ret != EOK) {
        return TRACE_FAILURE;
    }
    msg->head.cycle = GetCpuCycleCounter() - head->monotonicTime;
    msg->head.txtSize = txtSize;
    msg->head.bufferType = bufferType;
    return TRACE_SUCCESS;
}

STATIC INLINE int RbLogMsgCmp(const void *a, const void *b)
{
    const RbLogMsg *msgA = (const RbLogMsg *)a;
    const RbLogMsg *msgB = (const RbLogMsg *)b;
    if (msgA->head.busy != msgB->head.busy) {
        return msgA->head.busy ? 1 : 0;     // msgA->head.busy > msgB->head.busy
    }
    return msgA->head.cycle > msgB->head.cycle;
}

STATIC TraStatus TraceRbLogCopyMsg(struct RbLog *newRb, struct RbLog *rb, uint32_t msgIndex)
{
    uint32_t msgTxtSize = rb->head.msgTxtSize;
    RbLogMsg *msg = TraceRbLogGetMsgByIndex(rb, msgIndex);
    RbLogMsg *newMsg = TraceRbLogGetMsgByIndex(newRb, msgIndex);

    uint64_t cycle = msg->head.cycle;
    int32_t ret = memcpy_s(&newMsg->txt, msgTxtSize, &msg->txt, msgTxtSize);
    if (ret != EOK) {
        ADIAG_ERR("[%s] memcpy_s msg txt failed.", rb->head.name);
        return TRACE_FAILURE;
    }
    ret = memcpy_s(&newMsg->head, sizeof(RbMsgHead), &msg->head, sizeof(RbMsgHead));
    if (ret != EOK) {
        ADIAG_ERR("[%s] memcpy_s msg head failed.", rb->head.name);
        return TRACE_FAILURE;
    }
    // cycle has changed before memcpy finished, set busy to true to drop data.
    if (newMsg->head.cycle != cycle) {
        newMsg->head.busy = true;
    }
    return TRACE_SUCCESS;
}

STATIC void TraceRbLogSort(struct RbLog *rb)
{
    qsort(rb->msg, rb->head.bufSize, rb->head.msgSize, RbLogMsgCmp);
}

/**
 * @brief           get struct entry list
 * @param [in/out]  newRb:      new ringbuffer
 * @param [in]      traList:    trace list of ring buffer
 * @return          TRACE_SUCCESS  success; TRACE_FAILURE  failure
 */
STATIC TraStatus TraceRbLogGetStructEntryList(struct AdiagList **newRbList, const struct AdiagList *traList)
{
    struct AdiagList *newList = (struct AdiagList *)AdiagMalloc(sizeof(struct AdiagList));
    if (newList == NULL) {
        ADIAG_ERR("malloc new ringbuffer list failed.");
        return TRACE_FAILURE;
    }
    if (AdiagListInit(newList) != TRACE_SUCCESS) {
        ADIAG_ERR("init new ringbuffer list failed.");
        ADIAG_SAFE_FREE(newList);
        return TRACE_FAILURE;
    }
    struct ListHead *pos = NULL;
    struct AdiagListNode *node = NULL;
    LIST_FOR_EACH(pos, &traList->list) {
        node = LIST_ENTRY(pos, struct AdiagListNode, list);
        if (node == NULL) {
            (void)AdiagListDestroy(newList);
            ADIAG_SAFE_FREE(newList);
            return TRACE_FAILURE;
        }
        TraceStructField *data = (TraceStructField *)AdiagMalloc(sizeof(TraceStructField));
        if (data == NULL) {
            ADIAG_ERR("malloc struct field failed.");
            (void)AdiagListDestroy(newList);
            ADIAG_SAFE_FREE(newList);
            return TRACE_FAILURE;
        }
        errno_t ret = memcpy_s(data, sizeof(TraceStructField), node->data, sizeof(TraceStructField));
        if (ret != EOK) {
            ADIAG_ERR("memcpy_s struct field failed.");
            ADIAG_SAFE_FREE(data);
            (void)AdiagListDestroy(newList);
            ADIAG_SAFE_FREE(newList);
            return TRACE_FAILURE;
        }
        if (AdiagListInsert(newList, data) != ADIAG_SUCCESS) {
            ADIAG_ERR("insert struct list failed.");
            ADIAG_SAFE_FREE(data);
            (void)AdiagListDestroy(newList);
            ADIAG_SAFE_FREE(newList);
            return TRACE_FAILURE;
        }
    }
    *newRbList = newList;
    return TRACE_SUCCESS;
}

/**
 * @brief       copy ringbuffer to new buffer and sort valid msg by cycle
 * @param [out] newRb:      new ringbuffer
 * @param [in]  rb:         original ringbuffer
 * @return      TraStatus
 */
TraStatus TraceRbLogGetCopyOfRingBuffer(struct RbLog **newRb, struct RbLog *rb)
{
    size_t totalSize = sizeof(RbLog) + (size_t)rb->head.bufSize * rb->head.msgSize;
    *newRb = AdiagMalloc(totalSize);
    if (*newRb == NULL) {
        ADIAG_ERR("[%s] malloc new ringbuffer failed, size : %zu bytes.", rb->head.name, totalSize);
        return TRACE_FAILURE;
    }
    errno_t ret = memcpy_s(*newRb, sizeof(RbLog), rb, sizeof(RbLog));
    if (ret != EOK) {
        ADIAG_SAFE_FREE(*newRb);
        ADIAG_ERR("[%s] memcpy_s ringbuffer failed.", rb->head.name);
        return TRACE_FAILURE;
    }
    for (uint32_t i = 0; i < rb->head.bufSize; i++) {
        if (TraceRbLogCopyMsg(*newRb, rb, i) != TRACE_SUCCESS) {
            ADIAG_SAFE_FREE(*newRb);
            return TRACE_FAILURE;
        }
    }
    TraceRbLogSort(*newRb);
    // if trace struct not defined, return success
    struct AdiagList *traList = NULL;
    for (uint32_t i = 0; i < TRACE_STRUCT_ENTRY_MAX_NUM; i++) {
        traList = (struct AdiagList *)(rb->entry[i].list);
        if ((rb->entry[i].list == NULL) || (ListEmpty(&traList->list))) {
            continue;
        }
        if (TraceRbLogGetStructEntryList((struct AdiagList **)&(*newRb)->entry[i].list, traList) != TRACE_SUCCESS) {
            ADIAG_SAFE_FREE(*newRb);
            return TRACE_FAILURE;
        }
    }
    return TRACE_SUCCESS;
}

/**
 * @brief       read msg from ringbuffer, must be reentrant, cannot print msg
 * @param [in]  rb:           ringbuffer
 * @param [out] timeStr:      timestamp str
 * @param [out] buffer:       ptr of msg txt in ringbuffer
 * @return      TraStatus
 */
TraStatus TraceRbLogReadRbMsg(struct RbLog *rb, char *timeStr, uint32_t timeStrSize, char **buffer)
{
    RbLogMsg *msg = NULL;
    for (;rb->head.readIdx != rb->head.bufSize; rb->head.readIdx++) {
        msg = TraceRbLogGetMsgByIndex(rb, rb->head.readIdx);
        if (msg->head.busy) { // msg has not been written done
            continue;
        }
        if (msg->head.txtSize == 0) {
            continue;
        }
        rb->head.readIdx++;
        double costTime = (double)msg->head.cycle / (double)rb->head.cpuFreq * (double)FREQ_GHZ_TO_KHZ;
        uint64_t timestamp = (uint64_t)costTime + rb->head.realTime;
        TraStatus ret = TimestampToStr(timestamp, timeStr, timeStrSize);
        if (ret != TRACE_SUCCESS) {
            return ret;
        }
        uint32_t lastIndex = MIN(msg->head.txtSize, rb->head.msgTxtSize - 1U);
        msg->txt[lastIndex] = '\0';  // ensure msg must have a string terminator
        *buffer = msg->txt;
        return TRACE_SUCCESS;
    }
    *buffer = NULL;
    return TRACE_RING_BUFFER_EMPTY;
}

/**
 * @brief       read msg from ringbuffer, must be reentrant, cannot print msg
 * @param [in]  rb:           ringbuffer
 * @param [out] buffer:       ptr of msg in ringbuffer
 * @param [out] bufLen:       length of msg in ringbuffer
 * @return      TraStatus
 */
TraStatus TraceRbLogReadOriRbMsg(struct RbLog *rb, char **buffer, uint32_t *bufLen)
{
    RbLogMsg *msg = NULL;
    for (;rb->head.readIdx != rb->head.bufSize; rb->head.readIdx++) {
        msg = TraceRbLogGetMsgByIndex(rb, rb->head.readIdx);
        if (msg->head.txtSize == 0) {
            continue;
        }
        rb->head.readIdx++;
        *buffer = (char *)msg;
        *bufLen = rb->head.msgSize;
        return TRACE_SUCCESS;
    }
    *buffer = NULL;
    *bufLen = 0;
    return TRACE_RING_BUFFER_EMPTY;
}

void TraceRbLogPrepareForRead(struct RbLog *rb)
{
    rb->head.readIdx = 0;
}

STATIC RbLogMsg *TraceRbLogGetOldestMsg(struct RbLog *rb, uint64_t *cycle, bool filterBusy)
{
    RbLogMsg *oldestMsg = NULL;
    RbLogMsg *msg = NULL;
    for (uint32_t i = 0; i < rb->head.bufSize; i++) {
        msg = TraceRbLogGetMsgByIndex(rb, i);
        if (msg->head.txtSize == 0) {
            continue;
        }
        if ((filterBusy) && (msg->head.busy)) {
            continue;
        }
        if (msg->head.cycle <= *cycle) {
            continue;
        }
        if ((oldestMsg == NULL) || (msg->head.cycle < oldestMsg->head.cycle)) {
            oldestMsg = msg;
        }
    }
    if (oldestMsg != NULL) {
        *cycle = oldestMsg->head.cycle;
    }
    return oldestMsg;
}

/**
 * @brief       read msg from ringbuffer, must be reentrant, cannot print msg
 * @param [in]  rb:           ringbuffer
 * @param [out] timeStr:      timestamp str
 * @param [out] buffer:       ptr of msg txt in ringbuffer
 * @return      TraStatus
 */
TraStatus TraceRbLogReadRbMsgSafe(struct RbLog *rb, char *timeStr, uint32_t timeStrSize, char **buffer)
{
    if (rb->head.readIdx == rb->head.bufSize) {
        return TRACE_RING_BUFFER_EMPTY;
    }
    uint64_t cycle = 0;
    RbLogMsg *msg = TraceRbLogGetOldestMsg(rb, &cycle, true);
    if (msg == NULL) {
        return TRACE_RING_BUFFER_EMPTY;
    }
    double costTime = (double)msg->head.cycle / (double)rb->head.cpuFreq * (double)FREQ_GHZ_TO_KHZ;
    uint64_t timestamp = (uint64_t)costTime + rb->head.realTime;
    TraStatus ret = TimestampToStr(timestamp, timeStr, timeStrSize);
    if (ret != TRACE_SUCCESS) {
        return ret;
    }
    uint32_t lastIndex = MIN(msg->head.txtSize, rb->head.msgTxtSize - 1U);
    msg->txt[lastIndex] = '\0';  // ensure msg must have a string terminator
    *buffer = msg->txt;
    msg->head.txtSize = 0;
    rb->head.readIdx++;
    return TRACE_SUCCESS;
}

/**
 * @brief       read msg from ringbuffer, must be reentrant, cannot print msg
 * @param [in]  rb:           ringbuffer
 * @param [out] buffer:       ptr of msg in ringbuffer
 * @param [out] bufLen:       length of msg in ringbuffer
 * @return      TraStatus
 */
TraStatus TraceRbLogReadOriRbMsgSafe(struct RbLog *rb, char **buffer, uint32_t *bufLen, uint64_t *cycle)
{
    if (rb->head.readIdx == rb->head.bufSize) {
        return TRACE_RING_BUFFER_EMPTY;
    }
    RbLogMsg *msg = TraceRbLogGetOldestMsg(rb, cycle, false);
    if (msg == NULL) {
        return TRACE_RING_BUFFER_EMPTY;
    }
    *buffer = (char *)msg;
    *bufLen = rb->head.msgSize;
    rb->head.readIdx++;
    return TRACE_SUCCESS;
}

uint32_t TracerRbLogGetMsgNum(const RbLog *rb)
{
    return (rb->head.writeIdx > (uint64_t)rb->head.bufSize) ? rb->head.bufSize : (uint32_t)rb->head.writeIdx;
}