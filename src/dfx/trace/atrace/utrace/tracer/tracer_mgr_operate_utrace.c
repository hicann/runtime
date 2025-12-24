/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "tracer_mgr_operate.h"
#include "tracer_mgr_operate_inner.h"
#include "adiag_print.h"
#include "trace_recorder.h"
#include "adiag_utils.h"
#include "trace_system_api.h"
#include "trace_msg.h"
#include "utrace_socket.h"
#include "trace_attr.h"

#define SOCKET_MAX_DATA_SIZE    524288

STATIC TraStatus TracerGetMsgHead(UtraceMsg *traceHead, uint8_t saveType, const char *objName, const char *timeStr)
{
    traceHead->magic = UTRACE_HEAD_MAGIC;
    traceHead->version = UTRACE_HEAD_VERSION;
    traceHead->hostPid = TraceAttrGetGlobalPid();
    traceHead->devicePid = TraceAttrGetPid();
    traceHead->deviceId = TraceAttrGetGlobalDevId();
    traceHead->tracerType = TRACER_TYPE_SCHEDULE;
    traceHead->saveType = saveType;

    errno_t err = strcpy_s(traceHead->objName, TRACE_NAME_LENGTH, objName);
    if (err != EOK) {
        ADIAG_ERR("strcpy objName failed, result=%d, strerr=%s.", (int32_t)err, strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }
    err = strcpy_s(traceHead->eventTime, TIMESTAMP_MAX_LENGTH, timeStr);
    if (err != EOK) {
        ADIAG_ERR("strcpy eventTime failed, result=%d, strerr=%s.", (int32_t)err, strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus TracerGetMsgData(struct RbLog *newRb, char *data, uint32_t len, uint32_t *dataPos)
{
    char *txt = NULL;
    TraStatus ret = TRACE_SUCCESS;
    char timestamp[TIMESTAMP_MAX_LENGTH] = {0};
    do {
        ret = TraceRbLogReadRbMsg(newRb, (char *)&timestamp, TIMESTAMP_MAX_LENGTH, &txt);
        if (ret == TRACE_RING_BUFFER_EMPTY) {
            break;
        }
        if (ret != TRACE_SUCCESS) {
            break;
        }
        if (memcpy_s(data + *dataPos, len - *dataPos, timestamp, (uint32_t)strlen(timestamp)) != EOK) {
            continue;
        }
        *dataPos += (uint32_t)strlen(timestamp);
        uint32_t txtLen = (uint32_t)strlen(txt);
        if (memcpy_s(data + *dataPos, len - *dataPos, txt, txtLen) != EOK) {
            continue;
        }
        *dataPos += txtLen;
        if ((txtLen > 0) && (txt[txtLen - 1U] != '\n')) {
            if (memcpy_s(data + *dataPos, len - *dataPos, "\n", 1) != EOK) {
                continue;
            }
            *dataPos += 1U;
        }
    } while (ret == TRACE_SUCCESS);
    return TRACE_SUCCESS;
}

/**
 * @brief      save msg to file with txt file
 * @param [in] newRb:           ringbuffer
 * @param [in] timeStr:         time stamp of file name
 * @param [in] objName:         object name
 * @return     NA
 */
void TracerScheduleSaveObjData(struct RbLog *newRb, const char *timeStr, const char *eventName, const char *objName)
{
    (void)eventName;
    if (TraceAttrGetSaveMode() != 1) {
        return;
    }
    UtraceMsg *buffer = (UtraceMsg *)AdiagMalloc(SOCKET_MAX_DATA_SIZE);
    if (buffer == NULL) {
        ADIAG_ERR("malloc for send msg to utrace server failed, strerr = %s.", strerror(AdiagGetErrorCode()));
        return;
    }

    if (TracerGetMsgHead(buffer, FILE_SAVE_MODE_CHAR, objName, timeStr) != TRACE_SUCCESS) {
        ADIAG_SAFE_FREE(buffer);
        ADIAG_ERR("get timestamp failed, objName = %s.", objName);
        return;
    }

    uint32_t pos = 0;
    if ((TracerGetMsgData(newRb, buffer->data,
        SOCKET_MAX_DATA_SIZE - (uint32_t)sizeof(UtraceMsg), &pos) != TRACE_SUCCESS)) {
        ADIAG_SAFE_FREE(buffer);
        ADIAG_ERR("get msg data failed, objName = %s.", objName);
        return;
    }
    if (pos == 0) {
        ADIAG_SAFE_FREE(buffer);
        ADIAG_INF("no date need to save, objName = %s.", objName);
        return;
    }
    buffer->dataLength = pos;

    if (!UtraceIsSocketFdValid()) {
        int32_t fd = UtraceCreateSocket(TraceAttrGetGlobalDevId());
        if (fd != TRACE_FAILURE) {
            UtraceSetSocketFd(fd);
        } else {
            ADIAG_SAFE_FREE(buffer);
            ADIAG_ERR("create socket failed, objName = %s, device id = %d.", objName, TraceAttrGetGlobalDevId());
            return;
        }
    }
    if (TraceRecorderWrite(UtraceGetSocketFd(), (char *)buffer, (uint32_t)sizeof(UtraceMsg) + pos) != TRACE_SUCCESS) {
        ADIAG_SAFE_FREE(buffer);
        ADIAG_ERR("write trace data to socket failed, objName = %s. strerror %s.",
            objName, strerror(AdiagGetErrorCode()));
        return;
    }
    ADIAG_SAFE_FREE(buffer);
    ADIAG_INF("write trace data to socket successfully, objName = %s.", objName);
    return;
}

STATIC TraStatus TracerGetTraceCtrl(const struct RbLog *rb, char *data, uint32_t len, uint32_t *dataPos)
{
    TraceCtrlHead traceCtrl = { 0 };
    traceCtrl.magic = TRACE_MAGIC;
    traceCtrl.version = TRACE_VERSION;
    traceCtrl.pos = TRACE_POS_DEVICE;
    traceCtrl.traceType = TRACE_TYPE_BIN;
    traceCtrl.dataSize = rb->head.msgSize * TracerRbLogGetMsgNum(rb);
    traceCtrl.realTime = rb->head.realTime;
    traceCtrl.minutesWest = rb->head.minutesWest;
    traceCtrl.cpuFreq = rb->head.cpuFreq;
    traceCtrl.structSize = (uint32_t)sizeof(TraceStructSegmentHead);
    for (uint32_t i = 0; i < TRACE_STRUCT_ENTRY_MAX_NUM; i++) {
        if ((rb->entry[i].list == NULL) || (ListEmpty(&((struct AdiagList *)rb->entry[i].list)->list))) {
            continue;
        }
        traceCtrl.structSize += (uint32_t)sizeof(TraceStructHead) +
            ((struct AdiagList *)rb->entry[i].list)->cnt * (uint32_t)sizeof(TraceStructField);
    }
    if (memcpy_s(data + *dataPos, len - *dataPos, (char *)&traceCtrl, sizeof(TraceCtrlHead)) != EOK) {
        ADIAG_ERR("memcpy log ctrl failed, strerr=%s.", strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }
    *dataPos += (uint32_t)sizeof(TraceCtrlHead);
    return TRACE_SUCCESS;
}

STATIC TraStatus TracerScheduleSaveStructSegment(const struct RbLog *rb, char *data, uint32_t len, uint32_t *dataPos)
{
    TraceStructSegmentHead structSegmentHead = { 0 };
    for (uint32_t i = 0; i < TRACE_STRUCT_ENTRY_MAX_NUM; i++) {
        if ((rb->entry[i].list == NULL) || (ListEmpty(&((struct AdiagList *)rb->entry[i].list)->list))) {
            continue;
        }
        structSegmentHead.structCount++;
    }
    if (memcpy_s(data + *dataPos, len - *dataPos, (char *)&structSegmentHead, sizeof(TraceStructSegmentHead)) != EOK) {
        ADIAG_ERR("memcpy struct segment head failed, strerr=%s.", strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }
    *dataPos += (uint32_t)sizeof(TraceStructSegmentHead);
 
    for (uint32_t i = 0; i < TRACE_STRUCT_ENTRY_MAX_NUM; i++) {
        struct AdiagList *traList = (struct AdiagList *)(rb->entry[i].list);
        if ((traList == NULL) || (ListEmpty(&traList->list))) {
            continue;
        }
        TraceStructHead structHead = { 0 };
        structHead.structType = i;
        structHead.itemNum = ((struct AdiagList *)rb->entry[i].list)->cnt;
        errno_t err = strcpy_s(structHead.structName, TRACE_NAME_LENGTH, rb->entry[i].name);
        if (err != EOK) {
            ADIAG_ERR("copy struct name failed, struct name=%s.", rb->entry[i].name);
        }
        if (memcpy_s(data + *dataPos, len - *dataPos, (char *)&structHead, sizeof(TraceStructHead)) != EOK) {
            ADIAG_ERR("memcpy struct head failed, entry name=%s, struct name=%s, strerr=%s.",
                rb->entry[i].name, structHead.structName, strerror(AdiagGetErrorCode()));
            continue;
        }
        *dataPos += (uint32_t)sizeof(TraceStructHead);
 
        struct AdiagListNode *node = NULL;
        struct ListHead *pos = NULL;
 
        LIST_FOR_EACH(pos, &traList->list) {
            node = LIST_ENTRY(pos, struct AdiagListNode, list);
            if ((node == NULL) ||
                (memcpy_s(data + *dataPos, len - *dataPos, node->data, sizeof(TraceStructField)) != EOK)) {
                ADIAG_ERR("get trace struct field failed, struct name=%s, strerr=%s.",
                    rb->entry[i].name, strerror(AdiagGetErrorCode()));
                return TRACE_FAILURE;
            }
            *dataPos += (uint32_t)sizeof(TraceStructField);
        }
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus TracerScheduleSaveDataHead(const struct RbLog *rb, char *data, uint32_t len, uint32_t *dataPos)
{
    TraceStructDataHead dataHead = { 0 };
    dataHead.msgSize = rb->head.msgSize;
    dataHead.msgTxtSize = rb->head.msgTxtSize;
    dataHead.msgNum = TracerRbLogGetMsgNum(rb);
    if (memcpy_s(data + *dataPos, len - *dataPos, (char *)&dataHead, sizeof(TraceStructDataHead)) != EOK) {
        ADIAG_ERR("memcpy data head failed, strerr=%s.", strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }
    *dataPos += (uint32_t)sizeof(TraceStructDataHead);
    return TRACE_SUCCESS;
}

STATIC TraStatus TracerGetDataStruct(const struct RbLog *newRb, char *data, uint32_t len, uint32_t *dataPos)
{
    if (TracerGetTraceCtrl(newRb, data, len, dataPos) != TRACE_SUCCESS) {
        ADIAG_ERR("get log ctrl failed.");
        return TRACE_FAILURE;
    }
 
    if (TracerScheduleSaveStructSegment(newRb, data, len, dataPos) != TRACE_SUCCESS) {
        ADIAG_ERR("write struct segment failed.");
        return TRACE_FAILURE;
    }
 
    if (TracerScheduleSaveDataHead(newRb, data, len, dataPos) != TRACE_SUCCESS) {
        ADIAG_ERR("write data head failed.");
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus TracerGetOriMsgData(struct RbLog *newRb, char *data, uint32_t len, uint32_t *dataPos)
{
    if (TracerGetDataStruct(newRb, data, len, dataPos) != TRACE_SUCCESS) {
        ADIAG_ERR("get data struct failed.");
        return TRACE_FAILURE;
    }

    char *txt = NULL;
    uint32_t txtLen = 0;
    TraStatus ret = TRACE_SUCCESS;
    uint32_t dataLen = *dataPos;
    do {
        ret = TraceRbLogReadOriRbMsg(newRb, &txt, &txtLen);
        if (ret == TRACE_RING_BUFFER_EMPTY) {
            break;
        }
        if (ret != TRACE_SUCCESS) {
            break;
        }
        if (memcpy_s(data + dataLen, len - dataLen, txt, txtLen) != EOK) {
            continue;
        }
        dataLen += txtLen;
    } while (ret == TRACE_SUCCESS);
    // if data is null, clear dataPos
    *dataPos = (*dataPos == dataLen) ? 0 : dataLen;
    return TRACE_SUCCESS;
}

/**
 * @brief      save msg to file with binary file
 * @param [in] newRb:           ringbuffer
 * @param [in] timeStr:         time stamp of file name
 * @param [in] objName:         object name
 * @return     NA
 */
void TracerScheduleSaveObjBinData(struct RbLog *newRb, const char *timeStr, const char *eventName, const char *objName)
{
    (void)eventName;
    if (TraceAttrGetSaveMode() != 1) {
        return;
    }
    UtraceMsg *buffer = (UtraceMsg *)AdiagMalloc(SOCKET_MAX_DATA_SIZE);
    if (buffer == NULL) {
        ADIAG_ERR("malloc for send msg to utrace server failed, strerr = %s.", strerror(AdiagGetErrorCode()));
        return;
    }

    if (TracerGetMsgHead(buffer, FILE_SAVE_MODE_BIN, objName, timeStr) != TRACE_SUCCESS) {
        ADIAG_SAFE_FREE(buffer);
        ADIAG_ERR("get timestamp failed, objName = %s.", objName);
        return;
    }
    uint32_t pos = 0;
    if ((TracerGetOriMsgData(newRb, buffer->data,
        SOCKET_MAX_DATA_SIZE - (uint32_t)sizeof(UtraceMsg), &pos) != TRACE_SUCCESS)) {
        ADIAG_SAFE_FREE(buffer);
        ADIAG_ERR("get msg data failed, objName = %s.", objName);
        return;
    }
    if (pos == 0) {
        ADIAG_SAFE_FREE(buffer);
        ADIAG_INF("no date need to save, objName = %s.", objName);
        return;
    }
    buffer->dataLength = pos;

    if (!UtraceIsSocketFdValid()) {
        int32_t fd = UtraceCreateSocket(TraceAttrGetGlobalDevId());
        if (fd != TRACE_FAILURE) {
            UtraceSetSocketFd(fd);
        } else {
            ADIAG_SAFE_FREE(buffer);
            ADIAG_ERR("create socket failed, objName = %s, device id = %d.", objName, TraceAttrGetGlobalDevId());
            return;
        }
    }
    if (TraceRecorderWrite(UtraceGetSocketFd(), (char *)buffer, (uint32_t)sizeof(UtraceMsg) + pos) != TRACE_SUCCESS) {
        ADIAG_SAFE_FREE(buffer);
        ADIAG_ERR("write trace data to socket failed, objName = %s.", objName);
        return;
    }
    ADIAG_SAFE_FREE(buffer);
    return;
}

TraStatus TracerScheduleSafeSave(Tracer *tracer, uint64_t timeStamp)
{
    (void)tracer;
    (void)timeStamp;
    return TRACE_SUCCESS;
}