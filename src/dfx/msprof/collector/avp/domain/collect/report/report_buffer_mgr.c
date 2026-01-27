/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "report_buffer_mgr.h"
#include "inttypes.h"
#include "osal/osal_mem.h"
#include "logger/logger.h"
#include "errno/error_code.h"
#include "transport/uploader.h"
#include "report_manager.h"
#include "atomic/atomic.h"
#include "thread/thread_pool.h"

#define DATA_STATUS_IS_READY 1
#define DATA_STATUS_NOT_READY 0

static bool g_isQuit = true;
static bool g_isInited = false;
ReportBuffer g_report[REPORT_TYPE_MAX] = {};
ApiVector g_apiAgingVec[AGING_MAX_INDEX] = {};
SizeCount g_sizeCount[REPORT_TYPE_MAX] = {
    {0, 0, true, PTHREAD_COND_INITIALIZER, PTHREAD_MUTEX_INITIALIZER},
    {0, 0, true, PTHREAD_COND_INITIALIZER, PTHREAD_MUTEX_INITIALIZER},
    {0, 0, true, PTHREAD_COND_INITIALIZER, PTHREAD_MUTEX_INITIALIZER}
};
UnionList *g_additionalList = NULL;
UnionList *g_compactList = NULL;
uint32_t g_reportBufferLength[] = {
    sizeof(struct MsprofApi),
    sizeof(struct MsprofCompactInfo),
    sizeof(struct MsprofAdditionalInfo)
};
char g_reportName[REPORT_TYPE_MAX][REPORT_NAME_LEN] = {
    "api_event",
    "compact",
    "additional"
};

/**
 * @brief      Create union list, and save additional or compact data
 * @return     success: pointer of UnionList
 *             failed : NULL
 */
static UnionList *CreateUnionList(void)
{
    UnionList *unionList = (UnionList*)OsalCalloc(sizeof(UnionList));
    if (unionList == NULL) {
        return NULL;
    }
    unionList->head = NULL;
    unionList->quantity = 0;
    return unionList;
}

/**
 * @brief      Destroy addtional unionList or compact unionList
 * @param [in] unionList: unionList which should be destroy
 * @return     void
 */
static void UnionListDestroy(UnionList *unionList)
{
    if (unionList != NULL) {
        UnionVector *node = unionList->head;
        while (node != NULL) {
            UnionVector *next = node->next;
            OSAL_MEM_FREE(node);
            node = next;
        }
        unionList->head = NULL;
        unionList->quantity = 0;
        OSAL_MEM_FREE(unionList);
    }
}

/**
 * @brief      Find addtional data wheter exisit in additional list, the new data will be saved in.
 * @param [in] data: data of the MsprofAdditionalInfo type
 * @param [in] ageFlag: aging flag
 * @return     true: data has saved in
 *             false : target level/type/flag not found
 */
static bool FindAdditionalNode(struct MsprofAdditionalInfo *data, uint8_t ageFlag)
{
    UnionVector *cur = g_additionalList->head;
    while (cur != NULL) {
        if (cur->level == data->level && cur->typeId == data->type && cur->ageFlag == ageFlag) {
            errno_t ret = memcpy_s(&(cur->typeInfo.additionalData[cur->quantity]), sizeof(struct MsprofAdditionalInfo),
                data, sizeof(struct MsprofAdditionalInfo));
            PROF_CHK_EXPR_ACTION(ret != EOK, return true, "additional node memcpy failed.");
            cur->quantity++;
            return true;
        }
        cur = cur->next;
    }
    return false;
}

static bool FindCompactNode(struct MsprofCompactInfo *data, uint8_t ageFlag)
{
    UnionVector *cur = g_compactList->head;
    while (cur != NULL) {
        if (cur->level == data->level && cur->typeId == data->type && cur->ageFlag == ageFlag) {
            errno_t ret = memcpy_s(&(cur->typeInfo.compactData[cur->quantity]), sizeof(struct MsprofCompactInfo),
                data, sizeof(struct MsprofCompactInfo));
            PROF_CHK_EXPR_ACTION(ret != EOK, return true, "compact node memcpy failed.");
            cur->quantity++;
            return true;
        }
        cur = cur->next;
    }
    return false;
}

/**
 * @brief      add addtional node into additional list, the new data and node will be saved in.
 * @param [in] data: data of the MsprofAdditionalInfo type
 * @param [in] ageFlag: aging flag
 * @return     void
 */
void AddAdditionalNode(struct MsprofAdditionalInfo *data, uint8_t ageFlag)
{
    UnionVector *newNode = (UnionVector*)OsalCalloc(sizeof(UnionVector));
    PROF_CHK_EXPR_ACTION(newNode == NULL, return, "OsalCalloc UnionVector failed");
    errno_t ret = memcpy_s(&(newNode->typeInfo.additionalData[0]), sizeof(struct MsprofAdditionalInfo),
        data, sizeof(struct MsprofAdditionalInfo));
    PROF_CHK_EXPR_ACTION_TWICE(ret != EOK, OSAL_MEM_FREE(newNode), return, "additional node memcpy failed.");
    
    if ((uint32_t)ageFlag == AGING_INDEX) {
        ret = strcpy_s(newNode->TypeName, MAX_FILE_CHUNK_NAME_LENGTH, "aging.additional.");
        PROF_CHK_EXPR_ACTION_TWICE(ret != EOK, OSAL_MEM_FREE(newNode), return, "aging title strcpy failed.");
    } else {
        ret = strcpy_s(newNode->TypeName, MAX_FILE_CHUNK_NAME_LENGTH, "unaging.additional.");
        PROF_CHK_EXPR_ACTION_TWICE(ret != EOK, OSAL_MEM_FREE(newNode), return, "aging title strcpy failed.");
    }
    ret = strcat_s(newNode->TypeName, MAX_FILE_CHUNK_NAME_LENGTH, GetTypeName(data->level, data->type));
    PROF_CHK_EXPR_ACTION_TWICE(ret != EOK, OSAL_MEM_FREE(newNode), return, "additional node strcat failed.");

    newNode->quantity = 1;
    newNode->typeId = data->type;
    newNode->level = data->level;
    newNode->ageFlag = ageFlag;
    newNode->next = g_additionalList->head;
    g_additionalList->head = newNode;
    g_additionalList->quantity++;
}

void AddCompactNode(struct MsprofCompactInfo *data, uint8_t ageFlag)
{
    UnionVector *newNode = (UnionVector*)OsalCalloc(sizeof(UnionVector));
    PROF_CHK_EXPR_ACTION(newNode == NULL, return, "OsalCalloc UnionVector failed");
    errno_t ret = memcpy_s(&(newNode->typeInfo.compactData[0]), sizeof(struct MsprofCompactInfo),
        data, sizeof(struct MsprofCompactInfo));
    PROF_CHK_EXPR_ACTION_TWICE(ret != EOK, OSAL_MEM_FREE(newNode), return, "compact node memcpy failed.");

    if ((uint32_t)ageFlag == AGING_INDEX) {
        ret = strcpy_s(newNode->TypeName, MAX_FILE_CHUNK_NAME_LENGTH, "aging.compact.");
        PROF_CHK_EXPR_ACTION_TWICE(ret != EOK, OSAL_MEM_FREE(newNode), return, "aging title strcpy failed.");
    } else {
        ret = strcpy_s(newNode->TypeName, MAX_FILE_CHUNK_NAME_LENGTH, "unaging.compact.");
        PROF_CHK_EXPR_ACTION_TWICE(ret != EOK, OSAL_MEM_FREE(newNode), return, "aging title strcpy failed.");
    }
    ret = strcat_s(newNode->TypeName, MAX_FILE_CHUNK_NAME_LENGTH, GetTypeName(data->level, data->type));
    PROF_CHK_EXPR_ACTION_TWICE(ret != EOK, OSAL_MEM_FREE(newNode), return, "compact node strcat failed.");

    newNode->quantity = 1;
    newNode->typeId = data->type;
    newNode->level = data->level;
    newNode->ageFlag = ageFlag;
    newNode->next = g_compactList->head;
    g_compactList->head = newNode;
    g_compactList->quantity++;
}

/**
 * @brief      Destroy api_event additional compact report list
 * @return     void
 */
static void ReportDestroy(void)
{
    for (uint32_t i = 0; i < sizeof(g_report)/sizeof(g_report[0]); i++) {
        OSAL_MEM_FREE(g_report[i].avails);
        OSAL_MEM_FREE(g_report[i].aging);
        OSAL_MEM_FREE(g_report[i].buffer);
    }
}

/**
 * @brief      Init api_event additional compact report linked list, init api additional compact buffer list,
 *              inti report status
 * @param [in] length: report buffer length
 * @return     success: PROFILING_SUCCESS
 *             failed : PROFILING_FAILED
 */
int32_t ReportInitialize(uint32_t length)
{
    if (g_isInited) {
        MSPROF_LOGI("The report has been initialized.");
        return PROFILING_SUCCESS;
    }
    for (uint32_t i = 0; i < sizeof(g_report)/sizeof(g_report[0]); i++) {
        AtomicInit(&g_report[i].rIndex, 0);
        AtomicInit(&g_report[i].wIndex, 0);
        AtomicInit(&g_report[i].idleWriteIndex, 0);
        g_report[i].capacity = length;
        g_report[i].mask = length - 1;
        g_report[i].avails = (uint8_t*)OsalCalloc(sizeof(uint8_t) * length);
        g_report[i].aging = (uint8_t*)OsalCalloc(sizeof(uint8_t) * length);
        g_report[i].buffer = (OsalVoidPtr)OsalCalloc(g_reportBufferLength[i] * length);
        if (g_report[i].avails == NULL || g_report[i].aging == NULL || g_report[i].buffer == NULL) {
            ReportDestroy();
            return PROFILING_FAILED;
        }
        for (uint32_t idx = 0; idx < length; idx++) {
            g_report[i].avails[idx] = DATA_STATUS_NOT_READY;
        }
    }
    g_additionalList = CreateUnionList();
    if (g_additionalList == NULL) {
        MSPROF_LOGE("Init additional data list failed.");
        ReportDestroy();
        return PROFILING_FAILED;
    }
    g_compactList = CreateUnionList();
    if (g_compactList == NULL) {
        MSPROF_LOGE("Init compact data list failed.");
        UnionListDestroy(g_additionalList);
        ReportDestroy();
        return PROFILING_FAILED;
    }
    g_apiAgingVec[UNAGING_INDEX].ageFlag = 0;
    g_apiAgingVec[AGING_INDEX].ageFlag = 1;
    g_isInited = true;
    g_isQuit = false;
    MSPROF_LOGI("Init host report success.");
    return PROFILING_SUCCESS;
}

/**
 * @brief      Notify report should be stopped
 * @return     void
 */
void ReportStop(void)
{
    g_isQuit = true;
    (void)OsalMutexLock(&g_sizeCount[REPORT_API_INDEX].sizeMtx);
    if (!g_sizeCount[REPORT_API_INDEX].finishTag) {
        // wake up api pop wait
        (void)OsalMutexLock(&g_report[REPORT_API_INDEX].bufMtx);
        (void)OsalCondSignal(&g_report[REPORT_API_INDEX].bufCond);
        (void)OsalMutexUnlock(&g_report[REPORT_API_INDEX].bufMtx);
        // make sure api thread stop
        MSPROF_LOGD("Wait for api thread stop.");
        OsalCondWait(&g_sizeCount[REPORT_API_INDEX].sizeCond, &g_sizeCount[REPORT_API_INDEX].sizeMtx);
        MSPROF_LOGD("Wait for api thread stop done.");
    }
    (void)OsalMutexUnlock(&g_sizeCount[REPORT_API_INDEX].sizeMtx);

    (void)OsalMutexLock(&g_sizeCount[REPORT_COMPACT_INDEX].sizeMtx);
    if (!g_sizeCount[REPORT_COMPACT_INDEX].finishTag) {
        // wake up compact pop wait
        (void)OsalMutexLock(&g_report[REPORT_COMPACT_INDEX].bufMtx);
        (void)OsalCondSignal(&g_report[REPORT_COMPACT_INDEX].bufCond);
        (void)OsalMutexUnlock(&g_report[REPORT_COMPACT_INDEX].bufMtx);
        // make sure compact thread stop
        MSPROF_LOGD("Wait for compact thread stop.");
        OsalCondWait(&g_sizeCount[REPORT_COMPACT_INDEX].sizeCond, &g_sizeCount[REPORT_COMPACT_INDEX].sizeMtx);
        MSPROF_LOGD("Wait for compact thread stop done.");
    }
    (void)OsalMutexUnlock(&g_sizeCount[REPORT_COMPACT_INDEX].sizeMtx);

    (void)OsalMutexLock(&g_sizeCount[REPORT_ADDITIONAL_INDEX].sizeMtx);
    if (!g_sizeCount[REPORT_ADDITIONAL_INDEX].finishTag) {
        // wake up additional pop wait
        (void)OsalMutexLock(&g_report[REPORT_ADDITIONAL_INDEX].bufMtx);
        (void)OsalCondSignal(&g_report[REPORT_ADDITIONAL_INDEX].bufCond);
        (void)OsalMutexUnlock(&g_report[REPORT_ADDITIONAL_INDEX].bufMtx);
        // make sure additional thread stop
        MSPROF_LOGD("Wait for additional thread stop.");
        OsalCondWait(&g_sizeCount[REPORT_ADDITIONAL_INDEX].sizeCond, &g_sizeCount[REPORT_ADDITIONAL_INDEX].sizeMtx);
        MSPROF_LOGD("Wait for additional thread stop done.");
    }
    (void)OsalMutexUnlock(&g_sizeCount[REPORT_ADDITIONAL_INDEX].sizeMtx);
}

/**
 * @brief      Push api event data into api_event linked list
 * @param [in] aging: aging flag
 * @param [in] data: data of MsprofApi type
 * @return     success: MSPROF_ERROR_NONE
 *             failed : MSPROF_ERROR_UNINITIALIZE
 */
int32_t ReportApiPush(uint8_t aging, const struct MsprofApi *data)
{
    if (!g_isInited || g_isQuit) {
        MSPROF_LOGW("Ring buffer api_event is not initialized.");
        return MSPROF_ERROR_UNINITIALIZE;
    }
    int32_t currWriteCusor = 0;
    int32_t nextWriteCusor = 0;
    size_t cycles = 0;
    do {
        cycles++;
        if (cycles >= REPORT_BUFFER_MAX_CYCLES) {
            MSPROF_LOGW("Cycle overflow, QueueName: api_event, QueueCapacity: %u", g_report[REPORT_API_INDEX].capacity);
            return MSPROF_ERROR_NONE;
        }
        currWriteCusor = AtomicLoad(&g_report[REPORT_API_INDEX].idleWriteIndex);
        nextWriteCusor = currWriteCusor + 1;
    } while (AtomicCompareExchangeWeak(&g_report[REPORT_API_INDEX].idleWriteIndex,
        nextWriteCusor, currWriteCusor));

    PROF_CHK_EXPR_ACTION(currWriteCusor < 0, return MSPROF_ERROR,
        "Read a negative cursors when push api data.");
    uint32_t index = (uint32_t)currWriteCusor & g_report[REPORT_API_INDEX].mask;
    g_report[REPORT_API_INDEX].aging[index] = aging;
    (void)memcpy_s(&((struct MsprofApi*)g_report[REPORT_API_INDEX].buffer)[index], sizeof(struct MsprofApi),
        data, sizeof(struct MsprofApi));
    g_report[REPORT_API_INDEX].avails[index] = DATA_STATUS_IS_READY;
    (void)AtomicAdd(&g_report[REPORT_API_INDEX].wIndex, 1);
    // wake up api pop wait
    (void)OsalMutexLock(&g_report[REPORT_API_INDEX].bufMtx);
    (void)OsalCondSignal(&g_report[REPORT_API_INDEX].bufCond);
    (void)OsalMutexUnlock(&g_report[REPORT_API_INDEX].bufMtx);
    return MSPROF_ERROR_NONE;
}

/**
 * @brief      Push compact data into compact linked list
 * @param [in] aging: aging flag
 * @param [in] data: data of MsprofCompactInfo type
 * @return     success: MSPROF_ERROR_NONE
 *             failed : MSPROF_ERROR_UNINITIALIZE
 */
int32_t ReportCompactPush(uint8_t aging, const struct MsprofCompactInfo *data)
{
    if (!g_isInited || g_isQuit) {
        MSPROF_LOGW("Ring buffer api_event is not initialized.");
        return MSPROF_ERROR_UNINITIALIZE;
    }
    int32_t currWriteCusor = 0;
    int32_t nextWriteCusor = 0;
    size_t cycles = 0;
    do {
        cycles++;
        if (cycles >= REPORT_BUFFER_MAX_CYCLES) {
            MSPROF_LOGW("Cycle overflow, QueueName: compact, QueueCapacity: %u",
                g_report[REPORT_COMPACT_INDEX].capacity);
            return MSPROF_ERROR_NONE;
        }
        currWriteCusor = AtomicLoad(&g_report[REPORT_COMPACT_INDEX].idleWriteIndex);
        nextWriteCusor = currWriteCusor + 1;
    } while (AtomicCompareExchangeWeak(&g_report[REPORT_COMPACT_INDEX].idleWriteIndex,
        nextWriteCusor, currWriteCusor));

    PROF_CHK_EXPR_ACTION(currWriteCusor < 0, return MSPROF_ERROR,
        "Read a negative cursors when push compact data.");
    uint32_t index = (uint32_t)currWriteCusor & g_report[REPORT_COMPACT_INDEX].mask;
    g_report[REPORT_COMPACT_INDEX].aging[index] = aging;
    (void)memcpy_s(&((struct MsprofCompactInfo*)g_report[REPORT_COMPACT_INDEX].buffer)[index],
        sizeof(struct MsprofCompactInfo), data, sizeof(struct MsprofCompactInfo));
    g_report[REPORT_COMPACT_INDEX].avails[index] = DATA_STATUS_IS_READY;
    (void)AtomicAdd(&g_report[REPORT_COMPACT_INDEX].wIndex, 1);
    // wake up compact pop wait
    (void)OsalMutexLock(&g_report[REPORT_COMPACT_INDEX].bufMtx);
    (void)OsalCondSignal(&g_report[REPORT_COMPACT_INDEX].bufCond);
    (void)OsalMutexUnlock(&g_report[REPORT_COMPACT_INDEX].bufMtx);
    return MSPROF_ERROR_NONE;
}

/**
 * @brief      Push additional data into additional linked list
 * @param [in] aging: aging flag
 * @param [in] data: data of MsprofAdditionalInfo type
 * @return     success: MSPROF_ERROR_NONE
 *             failed : MSPROF_ERROR_UNINITIALIZE
 */
int32_t ReportAdditionalPush(uint8_t aging, const struct MsprofAdditionalInfo *data)
{
    if (!g_isInited || g_isQuit) {
        MSPROF_LOGW("Ring buffer api_event is not initialized.");
        return MSPROF_ERROR_UNINITIALIZE;
    }
    int32_t currWriteCusor = 0;
    int32_t nextWriteCusor = 0;
    size_t cycles = 0;
    do {
        cycles++;
        if (cycles >= REPORT_BUFFER_MAX_CYCLES) {
            MSPROF_LOGW("Cycle overflow, QueueName: additional, QueueCapacity: %u",
                g_report[REPORT_ADDITIONAL_INDEX].capacity);
            return MSPROF_ERROR_NONE;
        }
        currWriteCusor = AtomicLoad(&g_report[REPORT_ADDITIONAL_INDEX].idleWriteIndex);
        nextWriteCusor = currWriteCusor + 1;
    } while (AtomicCompareExchangeWeak(&g_report[REPORT_ADDITIONAL_INDEX].idleWriteIndex,
        nextWriteCusor, currWriteCusor));

    PROF_CHK_EXPR_ACTION(currWriteCusor < 0, return MSPROF_ERROR,
        "Read a negative cursors when push additional data.");
    uint32_t index = (uint32_t)currWriteCusor & g_report[REPORT_ADDITIONAL_INDEX].mask;
    g_report[REPORT_ADDITIONAL_INDEX].aging[index] = aging;
    (void)memcpy_s(&((struct MsprofAdditionalInfo*)g_report[REPORT_ADDITIONAL_INDEX].buffer)[index],
        sizeof(struct MsprofAdditionalInfo), data, sizeof(struct MsprofAdditionalInfo));
    g_report[REPORT_ADDITIONAL_INDEX].avails[index] = DATA_STATUS_IS_READY;
    (void)AtomicAdd(&g_report[REPORT_ADDITIONAL_INDEX].wIndex, 1);
    // wake up additional pop wait
    (void)OsalMutexLock(&g_report[REPORT_ADDITIONAL_INDEX].bufMtx);
    (void)OsalCondSignal(&g_report[REPORT_ADDITIONAL_INDEX].bufCond);
    (void)OsalMutexUnlock(&g_report[REPORT_ADDITIONAL_INDEX].bufMtx);
    return MSPROF_ERROR_NONE;
}

/**
 * @brief      Pop data from target linked list
 * @param [in] aging: aging flag
 * @param [in] data: data of MsprofAdditionalInfo type
 * @return     true: pop data success
 *             false : pop data failed or nothing need to pop
 */
static bool ReportApiPop(uint8_t *aging, struct MsprofApi **data)
{
    if (!g_isInited) {
        return false;
    }

    int32_t currReadCusor = AtomicLoad(&g_report[REPORT_API_INDEX].rIndex);
    int32_t currWriteCusor = AtomicLoad(&g_report[REPORT_API_INDEX].wIndex);
    PROF_CHK_EXPR_ACTION(currWriteCusor < 0 || currReadCusor < 0, return false,
        "Read an negative numbers cursors when pop api data.");
    if (((uint32_t)currReadCusor & g_report[REPORT_API_INDEX].mask) ==
        ((uint32_t)currWriteCusor & g_report[REPORT_API_INDEX].mask)) {
        return false;
    }

    size_t idx = (uint32_t)currReadCusor & g_report[REPORT_API_INDEX].mask;
    if (g_report[REPORT_API_INDEX].avails[idx] == DATA_STATUS_IS_READY) {
        *data = &((struct MsprofApi*)g_report[REPORT_API_INDEX].buffer)[idx];
        *aging = g_report[REPORT_API_INDEX].aging[idx];
        g_report[REPORT_API_INDEX].avails[idx] = DATA_STATUS_NOT_READY;
        (void)AtomicAdd(&g_report[REPORT_API_INDEX].rIndex, 1);
        return true;
    }

    return false;
}

static bool ReportCompactPop(uint8_t *aging, struct MsprofCompactInfo **data)
{
    if (!g_isInited) {
        return false;
    }

    int32_t currReadCusor = AtomicLoad(&g_report[REPORT_COMPACT_INDEX].rIndex);
    int32_t currWriteCusor = AtomicLoad(&g_report[REPORT_COMPACT_INDEX].wIndex);
    PROF_CHK_EXPR_ACTION(currWriteCusor < 0 || currReadCusor < 0, return false,
        "Read an negative numbers cursors when pop compact data.");
    if (((uint32_t)currReadCusor & g_report[REPORT_COMPACT_INDEX].mask) ==
        ((uint32_t)currWriteCusor & g_report[REPORT_COMPACT_INDEX].mask)) {
        return false;
    }

    size_t idx = (uint32_t)currReadCusor & g_report[REPORT_COMPACT_INDEX].mask;
    if (g_report[REPORT_COMPACT_INDEX].avails[idx] == DATA_STATUS_IS_READY) {
        *data = &((struct MsprofCompactInfo*)g_report[REPORT_COMPACT_INDEX].buffer)[idx];
        *aging = g_report[REPORT_COMPACT_INDEX].aging[idx];
        g_report[REPORT_COMPACT_INDEX].avails[idx] = DATA_STATUS_NOT_READY;
        (void)AtomicAdd(&g_report[REPORT_COMPACT_INDEX].rIndex, 1);
        return true;
    }

    return false;
}

static bool ReportAdditionalPop(uint8_t *aging, struct MsprofAdditionalInfo **data)
{
    if (!g_isInited) {
        return false;
    }

    int32_t currReadCusor = AtomicLoad(&g_report[REPORT_ADDITIONAL_INDEX].rIndex);
    int32_t currWriteCusor = AtomicLoad(&g_report[REPORT_ADDITIONAL_INDEX].wIndex);
    PROF_CHK_EXPR_ACTION(currWriteCusor < 0 || currReadCusor < 0, return false,
        "Read an negative numbers cursors when pop additional data.");
    if (((uint32_t)currReadCusor & g_report[REPORT_ADDITIONAL_INDEX].mask) ==
        ((uint32_t)currWriteCusor & g_report[REPORT_ADDITIONAL_INDEX].mask)) {
        return false;
    }
    size_t idx = (uint32_t)currReadCusor & g_report[REPORT_ADDITIONAL_INDEX].mask;
    if (g_report[REPORT_ADDITIONAL_INDEX].avails[idx] == DATA_STATUS_IS_READY) {
        *data = &((struct MsprofAdditionalInfo*)g_report[REPORT_ADDITIONAL_INDEX].buffer)[idx];
        *aging = g_report[REPORT_ADDITIONAL_INDEX].aging[idx];
        g_report[REPORT_ADDITIONAL_INDEX].avails[idx] = DATA_STATUS_NOT_READY;
        (void)AtomicAdd(&g_report[REPORT_ADDITIONAL_INDEX].rIndex, 1);
        return true;
    }

    return false;
}

/**
 * @brief      Get api name, aging or unaging
 * @param [in] ageFlag: aging flag
 * @return     agingName
 */
static char *GenApiName(uint32_t ageFlag)
{
    static char unagingName[] = "unaging.api_event.data";
    static char agingName[] = "aging.api_event.data";
    if (ageFlag == 1) {
        return agingName;
    }
    return unagingName;
}

/**
 * @brief      dump api_event data from api list, and save it to chunk, and send chunk
 * @return     void
 */
void DumpApi(void)
{
    for (int32_t idx = UNAGING_INDEX; idx < AGING_MAX_INDEX; idx++) {
        if (g_apiAgingVec[idx].quantity == 0) {
            continue;
        }
        uint64_t chunkSize = g_apiAgingVec[idx].quantity * sizeof(struct MsprofApi);
        ProfFileChunk *chunk = (ProfFileChunk*)OsalCalloc(sizeof(ProfFileChunk));
        if (chunk == NULL) {
            MSPROF_LOGE("OsalCalloc chunk failed.");
            continue;
        }
        chunk->chunkSize = chunkSize;
        chunk->chunkType = PROF_HOST_DATA;
        chunk->deviceId = DEFAULT_HOST_ID;
        errno_t ret = strcpy_s((char *)chunk->fileName, MAX_FILE_CHUNK_NAME_LENGTH,
            GenApiName(g_apiAgingVec[idx].ageFlag));
        if (ret != EOK) {
            MSPROF_LOGE("strcpy_s api name to fileName failed.");
            OSAL_MEM_FREE(chunk);
            continue;
        }
        chunk->isLastChunk = false;
        chunk->offset = -1;
        chunk->chunk = (uint8_t*)OsalCalloc(chunkSize + 1);
        if (chunk->chunk == NULL) {
            OSAL_MEM_FREE(chunk);
            continue;
        }
        ret = memcpy_s(chunk->chunk, chunkSize + 1, g_apiAgingVec[idx].apiData, chunkSize);
        if (ret != EOK) {
            OSAL_MEM_FREE(chunk->chunk);
            OSAL_MEM_FREE(chunk);
            continue;
        }
        (void)UploaderUploadData(chunk);
    }
}

/**
 * @brief      wait for api data
 * @return     void
 */
static void ApiPopWait(void)
{
    (void)OsalMutexLock(&g_report[REPORT_API_INDEX].bufMtx);
    int32_t currReadCusor = AtomicLoad(&g_report[REPORT_API_INDEX].rIndex);
    int32_t currWriteCusor = AtomicLoad(&g_report[REPORT_API_INDEX].wIndex);
    if (((uint32_t)currReadCusor & g_report[REPORT_API_INDEX].mask) ==
        ((uint32_t)currWriteCusor & g_report[REPORT_API_INDEX].mask)) {
        MSPROF_LOGD("Wait for api push signal.");
        OsalCondWait(&g_report[REPORT_API_INDEX].bufCond, &g_report[REPORT_API_INDEX].bufMtx);
    }
    (void)OsalMutexUnlock(&g_report[REPORT_API_INDEX].bufMtx);
}

/**
 * @brief      pop api data from api linked list, and save it to tmp list
 * @return     void
 */
static void ApiPopRun(void)
{
    uint32_t batchSizeMax = 0;
    uint8_t ageFlag = 1;
    struct MsprofApi *data = NULL;
    for (; batchSizeMax < REPORT_BUFFER_MAX_BATCH;) {
        bool isOK = ReportApiPop(&ageFlag, &data);
        if (!isOK) {
            break;
        }
        if (data == NULL || data->level == 0 || (ageFlag != 1 && ageFlag != 0)) {
            MSPROF_LOGW("Receive api data whose level equal to zero, or aging code not equal 1/0.");
            continue;
        }
        g_sizeCount[REPORT_API_INDEX].totalPopCount++;
        g_sizeCount[REPORT_API_INDEX].totalPopSize += sizeof(struct MsprofApi);
        batchSizeMax++;
        errno_t ret = memcpy_s(&g_apiAgingVec[ageFlag].apiData[g_apiAgingVec[ageFlag].quantity],
            sizeof(struct MsprofApi), data, sizeof(struct MsprofApi));
        if (ret != EOK) {
            MSPROF_LOGE("Memcpy api data to buffer failed.");
            continue;
        }
        g_apiAgingVec[ageFlag].quantity++;
    }
    DumpApi();
    g_apiAgingVec[UNAGING_INDEX].quantity = 0;
    g_apiAgingVec[AGING_INDEX].quantity = 0;
}

/**
 * @brief      reset union list quantity number to 0, thus the next data could be saved from 0.
 * @param [in] unionList: unionList for addtional or compact
 * @return     void
 */
static void SetCountZero(UnionList *unionList)
{
    UnionVector *node = unionList->head;
    for (uint64_t idx = 0; idx < unionList->quantity; idx++) {
        if (node == NULL) {
            return;
        }
        node->quantity = 0;
        node = node->next;
    }
}

/**
 * @brief      dump compact data from compact list, and save it to chunk, and send chunk
 * @return     void
 */
void DumpCompact(void)
{
    uint32_t listSize = g_compactList->quantity;
    UnionVector *node = g_compactList->head;
    for (uint32_t idx = 0; idx < listSize; idx++) {
        if (node == NULL) {
            return;
        }
        if (node->quantity == 0) {
            node = node->next;
            continue;
        }
        uint64_t chunkSize = node->quantity * sizeof(struct MsprofCompactInfo);
        ProfFileChunk *chunk = (ProfFileChunk*)OsalCalloc(sizeof(ProfFileChunk));
        if (chunk == NULL) {
            MSPROF_LOGE("OsalCalloc chunk failed.");
            node = node->next;
            continue;
        }
        errno_t ret = strcpy_s(chunk->fileName, sizeof(chunk->fileName), node->TypeName);
        if (ret != EOK) {
            OSAL_MEM_FREE(chunk);
            node = node->next;
            MSPROF_LOGE("strcpy_s compact file name %s to chunk failed.", node->TypeName);
            continue;
        }
        chunk->chunk = (uint8_t*)OsalCalloc(chunkSize + 1);
        if (chunk->chunk == NULL) {
            MSPROF_LOGE("OsalCalloc chunk failed.");
            node = node->next;
            OSAL_MEM_FREE(chunk);
            continue;
        }
        ret = memcpy_s(chunk->chunk, chunkSize + 1, node->typeInfo.compactData, chunkSize);
        if (ret != EOK) {
            MSPROF_LOGE("memcpy_s compact chunk failed.");
            node = node->next;
            OSAL_MEM_FREE(chunk->chunk);
            OSAL_MEM_FREE(chunk);
            continue;
        }
        chunk->chunkSize = chunkSize;
        chunk->chunkType = PROF_HOST_DATA;
        chunk->deviceId = DEFAULT_HOST_ID;
        chunk->isLastChunk = false;
        chunk->offset = -1;
        (void)UploaderUploadData(chunk);
        node = node->next;
    }
}

/**
 * @brief      wait for compact data
 * @return     void
 */
static void CompactPopWait(void)
{
    (void)OsalMutexLock(&g_report[REPORT_COMPACT_INDEX].bufMtx);
    int32_t currReadCusor = AtomicLoad(&g_report[REPORT_COMPACT_INDEX].rIndex);
    int32_t currWriteCusor = AtomicLoad(&g_report[REPORT_COMPACT_INDEX].wIndex);
    if (((uint32_t)currReadCusor & g_report[REPORT_COMPACT_INDEX].mask) ==
        ((uint32_t)currWriteCusor & g_report[REPORT_COMPACT_INDEX].mask)) {
        MSPROF_LOGD("Wait for compact push signal.");
        OsalCondWait(&g_report[REPORT_COMPACT_INDEX].bufCond, &g_report[REPORT_COMPACT_INDEX].bufMtx);
    }
    (void)OsalMutexUnlock(&g_report[REPORT_COMPACT_INDEX].bufMtx);
}

/**
 * @brief      pop compact data from compact linked list, and save it to tmp list
 * @return     void
 */
static void CompactPopRun(void)
{
    uint64_t batchSizeMax = 0;
    uint8_t ageFlag = 1;
    struct MsprofCompactInfo *data = NULL;
    for (; batchSizeMax < REPORT_BUFFER_MAX_BATCH;) {
        bool isOK = ReportCompactPop(&ageFlag, &data);
        if (!isOK) {
            break;
        }
        g_sizeCount[REPORT_COMPACT_INDEX].totalPopCount++;
        g_sizeCount[REPORT_COMPACT_INDEX].totalPopSize += sizeof(struct MsprofCompactInfo);
        batchSizeMax++;
        isOK = FindCompactNode(data, ageFlag);
        if (!isOK) {
            AddCompactNode(data, ageFlag);
        }
    }
    DumpCompact();
    SetCountZero(g_compactList);
}

/**
 * @brief      dump additional data from additional list, and save it to chunk, and send chunk
 * @return     void
 */
void DumpAdditional(void)
{
    uint32_t listSize = g_additionalList->quantity;
    UnionVector *additionalNode = g_additionalList->head;
    for (uint32_t idx = 0; idx < listSize; idx++) {
        if (additionalNode == NULL) {
            return;
        }
        if (additionalNode->quantity == 0) {
            additionalNode = additionalNode->next;
            continue;
        }
        uint64_t chunkSize = additionalNode->quantity * sizeof(struct MsprofAdditionalInfo);
        ProfFileChunk *chunk = (ProfFileChunk*)OsalCalloc(sizeof(ProfFileChunk));
        if (chunk == NULL) {
            MSPROF_LOGE("OsalCalloc chunk failed.");
            continue;
        }
        errno_t ret = strcpy_s((char *)chunk->fileName, sizeof(chunk->fileName), additionalNode->TypeName);
        if (ret != EOK) {
            OSAL_MEM_FREE(chunk);
            additionalNode = additionalNode->next;
            MSPROF_LOGE("strcpy_s addtional file name failed.");
            continue;
        }
        chunk->chunk = (uint8_t*)OsalCalloc(chunkSize + 1);
        if (chunk->chunk == NULL) {
            MSPROF_LOGE("OsalCalloc chunk failed.");
            additionalNode = additionalNode->next;
            OSAL_MEM_FREE(chunk);
            continue;
        }
        ret = memcpy_s(chunk->chunk, chunkSize + 1, additionalNode->typeInfo.additionalData, chunkSize);
        if (ret != EOK) {
            MSPROF_LOGE("memcpy_s additional chunk failed.");
            additionalNode = additionalNode->next;
            OSAL_MEM_FREE(chunk->chunk);
            OSAL_MEM_FREE(chunk);
            continue;
        }
        chunk->chunkSize = chunkSize;
        chunk->chunkType = PROF_HOST_DATA;
        chunk->deviceId = DEFAULT_HOST_ID;
        chunk->isLastChunk = false;
        chunk->offset = -1;
        (void)UploaderUploadData(chunk);
        additionalNode = additionalNode->next;
    }
}

/**
 * @brief      wait for additional data
 * @return     void
 */
static void AdditionalPopWait(void)
{
    (void)OsalMutexLock(&g_report[REPORT_ADDITIONAL_INDEX].bufMtx);
    int32_t currReadCusor = AtomicLoad(&g_report[REPORT_ADDITIONAL_INDEX].rIndex);
    int32_t currWriteCusor = AtomicLoad(&g_report[REPORT_ADDITIONAL_INDEX].wIndex);
    if (((uint32_t)currReadCusor & g_report[REPORT_ADDITIONAL_INDEX].mask) ==
        ((uint32_t)currWriteCusor & g_report[REPORT_ADDITIONAL_INDEX].mask)) {
        MSPROF_LOGD("Wait for additional push signal.");
        OsalCondWait(&g_report[REPORT_ADDITIONAL_INDEX].bufCond, &g_report[REPORT_ADDITIONAL_INDEX].bufMtx);
    }
    (void)OsalMutexUnlock(&g_report[REPORT_ADDITIONAL_INDEX].bufMtx);
}

/**
 * @brief      pop additional data from additional linked list, and save it to tmp list
 * @return     void
 */
static void AdditionalPopRun(void)
{
    uint64_t batchSizeMax = 0;
    uint8_t ageFlag = 1;
    struct MsprofAdditionalInfo *data = NULL;
    for (; batchSizeMax < REPORT_BUFFER_MAX_BATCH;) {
        bool isOK = ReportAdditionalPop(&ageFlag, &data);
        if (!isOK) {
            break;
        }
        g_sizeCount[REPORT_ADDITIONAL_INDEX].totalPopCount++;
        g_sizeCount[REPORT_ADDITIONAL_INDEX].totalPopSize += sizeof(struct MsprofAdditionalInfo);
        batchSizeMax++;
        isOK = FindAdditionalNode(data, ageFlag);
        if (!isOK) {
            AddAdditionalNode(data, ageFlag);
        }
    }
    DumpAdditional();
    SetCountZero(g_additionalList);
}

/**
 * @brief      Check wheter all data has been read out.
 * @param [in] idx: which type index, api_event/compact/additional
 * @return     true: find data that not be read yet
 *             false: no more data need be read.
 */
static bool CheckAllAvails(int32_t idx)
{
    uint32_t totalSize = g_report[idx].capacity;
    for (uint32_t i = 0; i < totalSize; i++) {
        if (g_report[idx].avails == NULL) {
            return false;
        }
        if (g_report[idx].avails[i] == DATA_STATUS_IS_READY) {
            return true;
        }
    }
    return false;
}

/**
 * @brief      Check wheter all report task has been stop
 * @param [in] reportType: which type reportType, api_event/compact/additional
 * @return     true: find data that not be read yet
 *             false: no more data need be read.
 */
static bool CheckReportStatus(int32_t reportType)
{
    if (!g_isInited) {
        MSPROF_LOGI("Report is not initializing. No need to check.");
        return false;
    }
    return CheckAllAvails(reportType) || AtomicLoad(&g_report[reportType].rIndex) !=
        AtomicLoad(&g_report[reportType].wIndex);
}

/**
 * @brief      thread handle for api/compact/additional
 * @param [in] args: is Stopped
 * @return     NULL
 */
static OsalVoidPtr ApiReportHandle(OsalVoidPtr args)
{
    (void)OsalMutexLock(&g_sizeCount[REPORT_API_INDEX].sizeMtx);
    g_sizeCount[REPORT_API_INDEX].finishTag = false;
    (void)OsalCondSignal(&g_sizeCount[REPORT_API_INDEX].sizeCond);
    (void)OsalMutexUnlock(&g_sizeCount[REPORT_API_INDEX].sizeMtx);
    bool *quit = (bool *)args;
    while (!*quit) {
        ApiPopWait();
        ApiPopRun();
    }
    while (CheckReportStatus(REPORT_API_INDEX)) {
        ApiPopRun();
    }
    // wake up ReportUninitialize
    (void)OsalMutexLock(&g_sizeCount[REPORT_API_INDEX].sizeMtx);
    g_sizeCount[REPORT_API_INDEX].finishTag = true;
    (void)OsalCondSignal(&g_sizeCount[REPORT_API_INDEX].sizeCond);
    (void)OsalMutexUnlock(&g_sizeCount[REPORT_API_INDEX].sizeMtx);
    return NULL;
}

static OsalVoidPtr CompactReportHandle(OsalVoidPtr args)
{
    (void)OsalMutexLock(&g_sizeCount[REPORT_COMPACT_INDEX].sizeMtx);
    g_sizeCount[REPORT_COMPACT_INDEX].finishTag = false;
    (void)OsalCondSignal(&g_sizeCount[REPORT_COMPACT_INDEX].sizeCond);
    (void)OsalMutexUnlock(&g_sizeCount[REPORT_COMPACT_INDEX].sizeMtx);
    bool *quit = (bool *)args;
    while (!*quit) {
        CompactPopWait();
        CompactPopRun();
    }
    while (CheckReportStatus(REPORT_COMPACT_INDEX)) {
        CompactPopRun();
    }
    // wake up ReportUninitialize
    (void)OsalMutexLock(&g_sizeCount[REPORT_COMPACT_INDEX].sizeMtx);
    g_sizeCount[REPORT_COMPACT_INDEX].finishTag = true;
    (void)OsalCondSignal(&g_sizeCount[REPORT_COMPACT_INDEX].sizeCond);
    (void)OsalMutexUnlock(&g_sizeCount[REPORT_COMPACT_INDEX].sizeMtx);
    return NULL;
}

static OsalVoidPtr AdditionalReportHandle(OsalVoidPtr args)
{
    (void)OsalMutexLock(&g_sizeCount[REPORT_ADDITIONAL_INDEX].sizeMtx);
    g_sizeCount[REPORT_ADDITIONAL_INDEX].finishTag = false;
    (void)OsalCondSignal(&g_sizeCount[REPORT_ADDITIONAL_INDEX].sizeCond);
    (void)OsalMutexUnlock(&g_sizeCount[REPORT_ADDITIONAL_INDEX].sizeMtx);
    bool *quit = (bool *)args;
    while (!*quit) {
        AdditionalPopWait();
        AdditionalPopRun();
    }
    while (CheckReportStatus(REPORT_ADDITIONAL_INDEX)) {
        AdditionalPopRun();
    }
    // wake up ReportUninitialize
    (void)OsalMutexLock(&g_sizeCount[REPORT_ADDITIONAL_INDEX].sizeMtx);
    g_sizeCount[REPORT_ADDITIONAL_INDEX].finishTag = true;
    (void)OsalCondSignal(&g_sizeCount[REPORT_ADDITIONAL_INDEX].sizeCond);
    (void)OsalMutexUnlock(&g_sizeCount[REPORT_ADDITIONAL_INDEX].sizeMtx);
    return NULL;
}

/**
 * @brief      thread report start for api/compact/additional
 * @param [in] args: is Stopped
 * @return     true: dispatch success
 *             false: dispatch failed
 */
static bool ApiReportStart(void)
{
    ThreadTask apiTask = {ApiReportHandle, &g_isQuit};
    int32_t ret = ProfThreadPoolDispatch(&apiTask, 0);
    PROF_CHK_EXPR_ACTION(ret != PROFILING_SUCCESS, return false, "Failed to dispatch api thread pool.");
    // make sure ApiReportHandle start
    (void)OsalMutexLock(&g_sizeCount[REPORT_API_INDEX].sizeMtx);
    if (g_sizeCount[REPORT_API_INDEX].finishTag) {
        MSPROF_LOGD("Wait for api thread start.");
        OsalCondWait(&g_sizeCount[REPORT_API_INDEX].sizeCond, &g_sizeCount[REPORT_API_INDEX].sizeMtx);
        MSPROF_LOGD("Wait for api thread start done.");
    }
    (void)OsalMutexUnlock(&g_sizeCount[REPORT_API_INDEX].sizeMtx);
    return true;
}

static bool CompactReportStart(void)
{
    ThreadTask compactTask = {CompactReportHandle, &g_isQuit};
    int32_t ret = ProfThreadPoolDispatch(&compactTask, 0);
    PROF_CHK_EXPR_ACTION(ret != PROFILING_SUCCESS, return false, "Failed to dispatch compact thread pool.");
    // make sure CompactReportHandle start
    (void)OsalMutexLock(&g_sizeCount[REPORT_COMPACT_INDEX].sizeMtx);
    if (g_sizeCount[REPORT_COMPACT_INDEX].finishTag) {
        MSPROF_LOGD("Wait for compact thread start.");
        OsalCondWait(&g_sizeCount[REPORT_COMPACT_INDEX].sizeCond, &g_sizeCount[REPORT_COMPACT_INDEX].sizeMtx);
        MSPROF_LOGD("Wait for compact thread start done.");
    }
    (void)OsalMutexUnlock(&g_sizeCount[REPORT_COMPACT_INDEX].sizeMtx);
    return true;
}

static bool AdditionalReportStart(void)
{
    ThreadTask additionalTask = {AdditionalReportHandle, &g_isQuit};
    int32_t ret = ProfThreadPoolDispatch(&additionalTask, 0);
    PROF_CHK_EXPR_ACTION(ret != PROFILING_SUCCESS, return false, "Failed to dispatch additional thread pool.");
    // make sure AdditionalReportHandle start
    (void)OsalMutexLock(&g_sizeCount[REPORT_ADDITIONAL_INDEX].sizeMtx);
    if (g_sizeCount[REPORT_ADDITIONAL_INDEX].finishTag) {
        MSPROF_LOGD("Wait for additional thread start.");
        OsalCondWait(&g_sizeCount[REPORT_ADDITIONAL_INDEX].sizeCond, &g_sizeCount[REPORT_ADDITIONAL_INDEX].sizeMtx);
        MSPROF_LOGD("Wait for additional thread start done.");
    }
    (void)OsalMutexUnlock(&g_sizeCount[REPORT_ADDITIONAL_INDEX].sizeMtx);
    return true;
}

/**
 * @brief      thread report start for api/compact/additional
 * @return     success: PROFILING_SUCCESS
 *             falied: PROFILING_FAILED
 */
int32_t ReportStart(void)
{
    int32_t ret = ProfThreadPoolExpand(REPORT_TYPE_MAX);
    if (ret != PROFILING_SUCCESS) {
        ReportStop();
        ReportUninitialize();
        MSPROF_LOGE("Failed to expand report thread pool.");
        return PROFILING_FAILED;
    }

    if (!ApiReportStart() || !CompactReportStart() || !AdditionalReportStart()) {
        ReportStop();
        ReportUninitialize();
        MSPROF_LOGE("Failed to dispatch report thread pool.");
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("report initialize success");
    return PROFILING_SUCCESS;
}

static void TotalCountPrint(void)
{
    for (int32_t idx = 0; idx < REPORT_TYPE_MAX; idx++) {
        int32_t currWrite = AtomicLoad(&g_report[idx].idleWriteIndex);
        MSPROF_LOGI("total_size_report module:%s, push count:%d, pop count:%" PRIu64 ", pop size:%"
        PRIu64 " bytes", g_reportName[idx], currWrite, g_sizeCount[idx].totalPopCount, g_sizeCount[idx].totalPopSize);
        g_sizeCount[idx].totalPopCount = 0;
        g_sizeCount[idx].totalPopSize = 0;
        g_sizeCount[idx].finishTag = true;
    }
}

/**
 * @brief      Uninit all linked list or list
 * @return     void
 */
void ReportUninitialize(void)
{
    if (!g_isInited) {
        MSPROF_LOGI("Report is not initializing. No need to uninitialize.");
        return;
    }
    ReportStop();
    g_isInited = false;
    TotalCountPrint();
    UnionListDestroy(g_additionalList);
    UnionListDestroy(g_compactList);
    ReportDestroy();
    MSPROF_LOGI("report uninitialization successful");
}