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
#include "adiag_utils.h"
#include "trace_recorder.h"
#include "trace_system_api.h"
/**
 * @brief      save msg to file with txt file
 * @param [in] newRb:           ringbuffer
 * @param [in] timeStr:         time stamp of file name
 * @param [in] objName:         object name
 * @return     NA
 */
void TracerScheduleSaveObjData(struct RbLog *newRb, const char *timeStr, const char *eventName, const char *objName)
{
    TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, objName, TRACE_FILE_TXT_SUFFIX };
    TraceDirInfo dirInfo = { eventName, TraceGetPid(), timeStr };
    int32_t fd = -1;
    char *txt = NULL;
    char timestamp[TIMESTAMP_MAX_LENGTH] = {0};
    TraStatus ret = TRACE_SUCCESS;
    do {
        ret = TraceRbLogReadRbMsg(newRb, (char *)&timestamp, TIMESTAMP_MAX_LENGTH, &txt);
        if (ret == TRACE_RING_BUFFER_EMPTY) {
            break;
        }
        if (ret != TRACE_SUCCESS) {
            ADIAG_ERR("read log msg failed, ret : %d", ret);
            break;
        }

        if ((fd == -1) && (TraceRecorderGetFd(&dirInfo, &fileInfo, &fd) != TRACE_SUCCESS)) {
            ADIAG_ERR("get file fd failed, object name=%s.", objName);
            break;
        }
        uint32_t txtLen = (uint32_t)strlen(txt);
        (void)TraceRecorderWrite(fd, timestamp, (uint32_t)strlen(timestamp));
        (void)TraceRecorderWrite(fd, txt, txtLen);
        if ((txtLen > 0) && (txt[txtLen - 1U] != '\n')) {
            (void)TraceRecorderWrite(fd, "\n", 1);
        }
    } while (ret == TRACE_SUCCESS);
    TraceClose(&fd);
}

STATIC TraStatus TracerScheduleSaveTraceCtrl(const RbLog *rb, int32_t fd, const char *objName)
{
    TraceCtrlHead traceCtrl = { 0 };
    traceCtrl.magic = TRACE_MAGIC;
    traceCtrl.version = TRACE_VERSION;
    traceCtrl.pos = TRACE_POS_HOST;
    traceCtrl.traceType = TRACE_TYPE_BIN;
    traceCtrl.dataSize = rb->head.msgSize * TracerRbLogGetMsgNum(rb);
    traceCtrl.realTime = rb->head.realTime;
    traceCtrl.minutesWest = rb->head.minutesWest;
    traceCtrl.structSize = (uint32_t)sizeof(TraceStructSegmentHead);
    traceCtrl.cpuFreq = rb->head.cpuFreq;
    for (uint32_t i = 0; i < TRACE_STRUCT_ENTRY_MAX_NUM; i++) {
        if ((rb->entry[i].list == NULL) || (ListEmpty(&((struct AdiagList *)rb->entry[i].list)->list))) {
            continue;
        }
        traceCtrl.structSize += (uint32_t)sizeof(TraceStructHead) +
            ((struct AdiagList *)rb->entry[i].list)->cnt * (uint32_t)sizeof(TraceStructField);
    }
    if (TraceRecorderWrite(fd, (char *)&traceCtrl, (uint32_t)sizeof(TraceCtrlHead)) != TRACE_SUCCESS) {
        ADIAG_ERR("write log ctrl failed, object name=%s.", objName);
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}
 
STATIC TraStatus TracerScheduleSaveStructSegment(const RbLog *rb, int32_t fd, const char *objName)
{
    TraceStructSegmentHead structSegmentHead = { 0 };
    for (uint32_t i = 0; i < TRACE_STRUCT_ENTRY_MAX_NUM; i++) {
        if ((rb->entry[i].list == NULL) || (ListEmpty(&((struct AdiagList *)rb->entry[i].list)->list))) {
            continue;
        }
        structSegmentHead.structCount++;
    }
    if (TraceRecorderWrite(fd, (char *)&structSegmentHead, (uint32_t)sizeof(TraceStructSegmentHead)) != TRACE_SUCCESS) {
        ADIAG_ERR("write struct segment head failed, object name=%s.", objName);
        return TRACE_FAILURE;
    }
 
    for (uint8_t i = 0; i < TRACE_STRUCT_ENTRY_MAX_NUM; i++) {
        struct AdiagList *traList = (struct AdiagList *)(rb->entry[i].list);
        if ((traList == NULL) || (ListEmpty(&traList->list))) {
            continue;
        }
        TraceStructHead structHead = { 0 };
        structHead.structType = i;
        structHead.itemNum = ((struct AdiagList *)rb->entry[i].list)->cnt;
        errno_t err = strcpy_s(structHead.structName, TRACE_NAME_LENGTH, rb->entry[i].name);
        if (err != EOK) {
            ADIAG_ERR("copy struct name failed, object name=%s, struct name=%s.", objName, rb->entry[i].name);
        }
        if (TraceRecorderWrite(fd, (char *)&structHead, (uint32_t)sizeof(TraceStructHead)) != TRACE_SUCCESS) {
            ADIAG_ERR("write struct head failed, entry name=%s, struct name=%s.",
                rb->entry[i].name, structHead.structName);
            continue;
        }
 
        struct AdiagListNode *node = NULL;
        struct ListHead *pos = NULL;
 
        LIST_FOR_EACH(pos, &traList->list) {
            node = LIST_ENTRY(pos, struct AdiagListNode, list);
            if ((node == NULL) ||
                (TraceRecorderWrite(fd, node->data, (uint32_t)sizeof(TraceStructField)) != TRACE_SUCCESS)) {
                ADIAG_ERR("get trace struct field failed, object name=%s, struct name=%s.", objName, rb->entry[i].name);
                return TRACE_FAILURE;
            }
        }
    }
    return TRACE_SUCCESS;
}
 
STATIC TraStatus TracerScheduleSaveDataHead(const RbLog *rb, int32_t fd, const char *objName)
{
    TraceStructDataHead dataHead = { 0 };
    dataHead.msgSize = rb->head.msgSize;
    dataHead.msgTxtSize = rb->head.msgTxtSize;
    dataHead.msgNum = TracerRbLogGetMsgNum(rb);
    if (TraceRecorderWrite(fd, (char *)&dataHead, (uint32_t)sizeof(TraceStructDataHead)) != TRACE_SUCCESS) {
        ADIAG_ERR("write data head failed, object name=%s.", objName);
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}
 
STATIC TraStatus TracerScheduleSaveStruct(const struct RbLog *newRb, int32_t fd, const char *objName)
{
    if (TracerScheduleSaveTraceCtrl(newRb, fd, objName) != TRACE_SUCCESS) {
        ADIAG_ERR("write log ctrl failed, object name=%s.", objName);
        return TRACE_FAILURE;
    }
 
    if (TracerScheduleSaveStructSegment(newRb, fd, objName) != TRACE_SUCCESS) {
        ADIAG_ERR("write struct segment failed, object name=%s.", objName);
        return TRACE_FAILURE;
    }
 
    if (TracerScheduleSaveDataHead(newRb, fd, objName) != TRACE_SUCCESS) {
        ADIAG_ERR("write data head failed, object name=%s.", objName);
        return TRACE_FAILURE;
    }
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
    TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, objName, TRACE_FILE_BIN_SUFFIX };
    TraceDirInfo dirInfo = { eventName, TraceGetPid(), timeStr };
    int32_t fd = -1;

    char *txt = NULL;
    uint32_t txtLen = 0;
    TraStatus ret = TRACE_SUCCESS;
    do {
        ret = TraceRbLogReadOriRbMsg(newRb, &txt, &txtLen);
        if (ret == TRACE_RING_BUFFER_EMPTY) {
            break;
        }
        if (ret != TRACE_SUCCESS) {
            ADIAG_ERR("read log msg failed, ret : %d", ret);
            break;
        }

        if ((fd == -1) && ((TraceRecorderGetFd(&dirInfo, &fileInfo, &fd) != TRACE_SUCCESS) ||
            (TracerScheduleSaveStruct(newRb, fd, objName) != TRACE_SUCCESS))) {
            ADIAG_ERR("get file fd failed, object name=%s.", objName);
            break;
        }
        (void)TraceRecorderWrite(fd, txt, txtLen);
    } while (ret == TRACE_SUCCESS);
    TraceClose(&fd);
    return;
}

/**
 * @brief      save msg to file with txt file, must be reentrant, cannot print msg
 * @param [in] newRb:           ringbuffer
 * @param [in] timeStr:         time stamp of file name
 * @param [in] objName:         object name
 * @return     NA
 */
STATIC void TracerScheduleSaveObjDataSafe(struct RbLog *newRb, const char *timeStr, const char *objName)
{
    TraceDirInfo dirInfo = {  TRACER_STACKCORE_NAME, TraceGetPid(), timeStr};
    TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, objName, TRACE_FILE_TXT_SUFFIX };
    int32_t fd = -1;
    char *txt = NULL;
    char timestamp[TIMESTAMP_MAX_LENGTH] = {0};
    TraStatus ret = TRACE_SUCCESS;
    do {
        ret = TraceRbLogReadRbMsgSafe(newRb, (char *)&timestamp, TIMESTAMP_MAX_LENGTH, &txt);
        if (ret == TRACE_RING_BUFFER_EMPTY) {
            break;
        }
        if (ret != TRACE_SUCCESS) {
            break;
        }
        if ((fd == -1) &&
            (TraceRecorderSafeGetFd(&dirInfo, &fileInfo, &fd) != TRACE_SUCCESS)) {
            break;
        }
        uint32_t txtLen = (uint32_t)strlen(txt);
        (void)TraceRecorderWrite(fd, timestamp, (uint32_t)strlen(timestamp));
        (void)TraceRecorderWrite(fd, txt, txtLen);
        if ((txtLen > 0) && (txt[txtLen - 1U] != '\n')) {
            (void)TraceRecorderWrite(fd, "\n", 1);
        }
    } while (ret == TRACE_SUCCESS);
    TraceClose(&fd);
    return;
}

STATIC TraStatus TracerScheduleSaveTraceCtrlSafe(const RbLog *rb, int32_t fd)
{
    TraceCtrlHead traceCtrl = { 0 };
    traceCtrl.magic = TRACE_MAGIC;
    traceCtrl.version = TRACE_VERSION;
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

    if (TraceRecorderWrite(fd, (char *)&traceCtrl, (uint32_t)sizeof(TraceCtrlHead)) != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}
 
STATIC TraStatus TracerScheduleSaveStructSegmentSafe(const RbLog *rb, int32_t fd)
{
    TraceStructSegmentHead structSegmentHead = { 0 };
    for (uint32_t i = 0; i < TRACE_STRUCT_ENTRY_MAX_NUM; i++) {
        if ((rb->entry[i].list == NULL) || (ListEmpty(&((struct AdiagList *)rb->entry[i].list)->list))) {
            continue;
        }
        structSegmentHead.structCount++;
    }
    if (TraceRecorderWrite(fd, (char *)&structSegmentHead, (uint32_t)sizeof(TraceStructSegmentHead)) != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }
 
    for (uint8_t i = 0; i < TRACE_STRUCT_ENTRY_MAX_NUM; i++) {
        struct AdiagList *traList = (struct AdiagList *)(rb->entry[i].list);
        if ((traList == NULL) || (ListEmpty(&traList->list))) {
            continue;
        }
        TraceStructHead structHead = { 0 };
        structHead.structType = i;
        structHead.itemNum = ((struct AdiagList *)rb->entry[i].list)->cnt;
        errno_t err = strcpy_s(structHead.structName, TRACE_NAME_LENGTH, rb->entry[i].name);
        if (err != EOK) {
        }
        if (TraceRecorderWrite(fd, (char *)&structHead, (uint32_t)sizeof(TraceStructHead)) != TRACE_SUCCESS) {
            continue;
        }
 
        struct AdiagListNode *node = NULL;
        struct ListHead *pos = NULL;
 
        LIST_FOR_EACH(pos, &traList->list) {
            node = LIST_ENTRY(pos, struct AdiagListNode, list);
            if ((node == NULL) ||
                (TraceRecorderWrite(fd, node->data, (uint32_t)sizeof(TraceStructField)) != TRACE_SUCCESS)) {
                return TRACE_FAILURE;
            }
        }
    }
    return TRACE_SUCCESS;
}
 
STATIC TraStatus TracerScheduleSaveDataHeadSafe(const RbLog *rb, int32_t fd)
{
    TraceStructDataHead dataHead = { 0 };
    dataHead.msgSize = rb->head.msgSize;
    dataHead.msgTxtSize = rb->head.msgTxtSize;
    dataHead.msgNum = TracerRbLogGetMsgNum(rb);
    if (TraceRecorderWrite(fd, (char *)&dataHead, (uint32_t)sizeof(TraceStructDataHead)) != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}
 
STATIC TraStatus TracerScheduleSaveStructSafe(const struct RbLog *newRb, int32_t fd)
{
    if (TracerScheduleSaveTraceCtrlSafe(newRb, fd) != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }
 
    if (TracerScheduleSaveStructSegmentSafe(newRb, fd) != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }
 
    if (TracerScheduleSaveDataHeadSafe(newRb, fd) != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

/**
 * @brief      save msg to file with binary file, must be reentrant, cannot print msg
 * @param [in] newRb:           ringbuffer
 * @param [in] timeStr:         time stamp of file name
 * @param [in] objName:         object name
 * @return     NA
 */
STATIC void TracerScheduleSaveObjBinDataSafe(struct RbLog *newRb, const char *timeStr, const char *objName)
{
    TraceDirInfo dirInfo = {  TRACER_STACKCORE_NAME, TraceGetPid(), timeStr};
    TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, objName, TRACE_FILE_BIN_SUFFIX };
    int32_t fd = -1;
    char *txt = NULL;
    uint32_t txtLen = 0;
    TraStatus ret = TRACE_SUCCESS;
    uint64_t cycle = 0;
    do {
        ret = TraceRbLogReadOriRbMsgSafe(newRb, &txt, &txtLen, &cycle);
        if (ret == TRACE_RING_BUFFER_EMPTY) {
            break;
        }
        if (ret != TRACE_SUCCESS) {
            break;
        }
        if ((fd == -1) &&
            ((TraceRecorderSafeGetFd(&dirInfo, &fileInfo, &fd) != TRACE_SUCCESS) || 
             (TracerScheduleSaveStructSafe(newRb, fd) != TRACE_SUCCESS))) {
            break;
        }
        (void)TraceRecorderWrite(fd, txt, txtLen);
    } while (ret == TRACE_SUCCESS);
    TraceClose(&fd);
    return;
}

/**
 * @brief      save msg to file with binary file, must be reentrant, cannot print msg
 * @param [in] tracer:          tracer pointer
 * @param [in] timeStamp:       timestamp
 * @return     NA
 */
TraStatus TracerScheduleSafeSave(Tracer *tracer, uint64_t timeStamp)
{
    if (tracer->mgr == NULL) {
        return TRACE_FAILURE;
    }
    char dirTimeStr[TIMESTAMP_MAX_LENGTH] = {0};
    TraStatus ret = TimestampToFileStr(timeStamp, dirTimeStr, TIMESTAMP_MAX_LENGTH);
    if (ret != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }
    for (int32_t i = 0; i < MAX_OBJECT_NUM; i++) {
        if ((tracer->mgr->obj[i].status != (int32_t)OBJ_STATUS_WORKING) || (tracer->mgr->obj[i].pid != TraceGetPid())) {
            continue;
        }
        // read from ringbuffer, then write to file
        struct RbLog *rb = (RbLog *)tracer->mgr->obj[i].data;
        TraceRbLogPrepareForRead(rb);
        if (TracerScheduleCheckListEmpty(rb)) {
            TracerScheduleSaveObjDataSafe(rb, dirTimeStr, tracer->mgr->obj[i].name);
        } else {
            TracerScheduleSaveObjBinDataSafe(rb, dirTimeStr, tracer->mgr->obj[i].name);
        }
    }

    return TRACE_SUCCESS;
}