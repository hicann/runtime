/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "report/report_manager.h"
#include "securec.h"
#include "inttypes.h"
#include "errno/error_code.h"
#include "logger/logger.h"
#include "utils/utils.h"
#include "thread/thread_pool.h"
#include "toolchain/prof_api.h"
#include "osal/osal_mem.h"
#include "osal/osal_thread.h"
#include "transport/uploader.h"
#include "report/hash_dic.h"
#include "report/report_buffer_mgr.h"

#define DEFAULT_TYPE_INFO_SIZE 13
enum MsprofReporterId {
    API_EVENT           = 0,
    COMPACT             = 1,
    ADDITIONAL          = 2
};

static const TypeInfoNode DEFAULT_TYPE_INFO[DEFAULT_TYPE_INFO_SIZE] = {
    {MSPROF_REPORT_NODE_LEVEL, MSPROF_REPORT_NODE_BASIC_INFO_TYPE, "node_basic_info", NULL},
    {MSPROF_REPORT_NODE_LEVEL, MSPROF_REPORT_NODE_TENSOR_INFO_TYPE, "tensor_info", NULL},
    {MSPROF_REPORT_NODE_LEVEL, MSPROF_REPORT_NODE_ATTR_INFO_TYPE, "node_attr_info", NULL},
    {MSPROF_REPORT_NODE_LEVEL, MSPROF_REPORT_NODE_FUSION_OP_INFO_TYPE, "fusion_op_info", NULL},
    {MSPROF_REPORT_NODE_LEVEL, MSPROF_REPORT_NODE_CONTEXT_ID_INFO_TYPE, "context_id_info", NULL},
    {MSPROF_REPORT_NODE_LEVEL, MSPROF_REPORT_NODE_LAUNCH_TYPE, "launch", NULL},
    {MSPROF_REPORT_NODE_LEVEL, MSPROF_REPORT_NODE_TASK_MEMORY_TYPE, "task_memory_info", NULL},
    {MSPROF_REPORT_NODE_LEVEL, MSPROF_REPORT_NODE_STATIC_OP_MEM_TYPE, "static_op_mem", NULL},
    {MSPROF_REPORT_MODEL_LEVEL, MSPROF_REPORT_MODEL_GRAPH_ID_MAP_TYPE, "graph_id_map", NULL},
    {MSPROF_REPORT_MODEL_LEVEL, MSPROF_REPORT_MODEL_EXEOM_TYPE, "model_exeom", NULL},
    {MSPROF_REPORT_MODEL_LEVEL, MSPROF_REPORT_MODEL_LOGIC_STREAM_TYPE, "logic_stream_info", NULL},
    {MSPROF_REPORT_HCCL_NODE_LEVEL, MSPROF_REPORT_HCCL_MASTER_TYPE, "master", NULL},
    {MSPROF_REPORT_HCCL_NODE_LEVEL, MSPROF_REPORT_HCCL_SLAVE_TYPE, "slave", NULL},
};
TypeInfoFlag g_infoType = {false, true, 0, PTHREAD_MUTEX_INITIALIZER, PTHREAD_MUTEX_INITIALIZER};
TypeInfoList *g_typeInfoList = NULL;

const enum MsprofReporterModuleId DEVICE_REPORT_LIST[] = {MSPROF_MODULE_DATA_PREPROCESS, MSPROF_MODULE_MSPROF};
const enum MsprofReporterId HOST_REPORT_LIST[] = {API_EVENT, COMPACT, ADDITIONAL};

static void CommandhandleProcessDeviceList(ProfCommand *command, const uint32_t devIdList[], uint64_t devNums)
{
    for (uint64_t i = 0; i < devNums && i < MAX_DEVICE_NUM; i++) {
        if (devIdList[i] == MAX_DEVICE_NUM) {
            command->devNums -= 1;
            continue;
        }
        command->devIdList[i] = devIdList[i];
    }
}

static int32_t CommandHandleSetParams(ProfCommand *command)
{
    char msprofParams[] = "params"; // todo get params string from param module;
    if (strlen(msprofParams) > PARAM_LEN_MAX) {
        MSPROF_LOGE("Command param length %zu bytes, exceeds:%d bytes", strlen(msprofParams), PARAM_LEN_MAX);
        return PROFILING_FAILED;
    }
    command->params.profDataLen = (uint32_t)(strlen(msprofParams));
    errno_t err = strncpy_s(command->params.profData, PARAM_LEN_MAX, msprofParams, strlen(msprofParams));
    if (err != EOK) {
        MSPROF_LOGE("string copy failed, err: %d", err);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

static void CommandHandleCallback(ReportAttribute *reportAttr, ProfCommand *command)
{
    for (uint32_t i = 0; i < reportAttr->regModuleCount; i++) {
        reportAttr->handle[i]((uint32_t)PROF_CTRL_SWITCH, (void*)command, sizeof(ProfCommand));
    }
    reportAttr->handleType = command->type;
    return;
}

 /**
 * @brief      start report thread for report host and device data
 * @param [out] reportAttr: report attr
 * @return     PROFILING_FAILED  : failed
 *             PROFILING_SUCCESS : success
 */
int32_t ReportManagerInitialize(ReportAttribute *reportAttr)
{
    reportAttr->hostReporters.reporterNum = 0;
    reportAttr->hostReporters.reporters = NULL;
    reportAttr->deviceReporters.reporterNum = 0;
    reportAttr->deviceReporters.reporters = NULL;
    int32_t ret = HashDataInit();
    PROF_CHK_EXPR_ACTION(ret != PROFILING_SUCCESS, return PROFILING_FAILED, "Init hash data failed.");
    ret = TypeInfoInit();
    PROF_CHK_EXPR_ACTION(ret != PROFILING_SUCCESS, return PROFILING_FAILED, "Init type info failed.");
    ret = ReportInitialize(REPORT_BUFFER_MAX_CYCLES);
    PROF_CHK_EXPR_ACTION(ret != PROFILING_SUCCESS, return PROFILING_FAILED, "Init host report failed.");
    ret = ReportStart();
    PROF_CHK_EXPR_ACTION(ret != PROFILING_SUCCESS, return PROFILING_FAILED, "Start host report failed.");
    return PROFILING_SUCCESS;
}

int32_t ReportManagerRegisterModule(ReportAttribute *reportAttr, uint32_t moduleId, ProfCommandHandle handle)
{
    uint32_t i;
    if (handle == NULL) {
        MSPROF_LOGE("Invalid handle value NULL");
        return PROFILING_FAILED;
    }
    for (i = 0; i < MAX_REPORT_MODULE; i++) {
        if (reportAttr->moduleId[i] == moduleId) {
            MSPROF_LOGW("Module[%u] has already registered.", moduleId);
            return PROFILING_SUCCESS;
        }
    }
    if (reportAttr->regModuleCount == MAX_REPORT_MODULE) {
        MSPROF_LOGE("Module[%u] register callback failed, the number of modules has reached the maximum value %u",
            moduleId, reportAttr->regModuleCount);
        return PROFILING_FAILED;
    }
    reportAttr->moduleId[reportAttr->regModuleCount] = moduleId;
    reportAttr->handle[reportAttr->regModuleCount] = handle;
    reportAttr->regModuleCount++;
    MSPROF_LOGI("Module[%u] register callback success", moduleId);
    return PROFILING_SUCCESS;
}

 /**
 * @brief      start report thread for read data from ringbuffer
 * @param [in] reportAttr:     report attr
 * @return     PROFILING_FAILED  : failed
 *             PROFILING_SUCCESS : success
 */
int32_t ReportManagerStartDeviceReporters(ReportAttribute *reportAttr)
{
    MsprofReporterList *deviceReporters = &reportAttr->deviceReporters;
    if (deviceReporters->reporterNum != 0) {
        MSPROF_LOGD("Device reporters has been started");
        return PROFILING_SUCCESS;
    }
    deviceReporters->reporterNum = sizeof(DEVICE_REPORT_LIST) / sizeof(DEVICE_REPORT_LIST[0]);
    // start reporter
    
    MSPROF_LOGI("Start device reporters successfully");
    return PROFILING_SUCCESS;
}


 /**
 * @brief      stop report thread for read data from ringbuffer
 * @param [in] reportAttr:     report attr
 * @return     PROFILING_FAILED  : failed
 *             PROFILING_SUCCESS : success
 */
int32_t ReportManagerStopDeviceReporters(ReportAttribute *reportAttr)
{
    // stop reporters
    reportAttr->deviceReporters.reporterNum = 0;
    reportAttr->regModuleCount = 0;
    for (uint32_t i = 0; i < MAX_REPORT_MODULE; i++) {
        reportAttr->moduleId[i] = 0;
        reportAttr->handle[i] = NULL;
    }
    MSPROF_LOGI("Stop device reporters successfully");
    return PROFILING_SUCCESS;
}

 /**
 * @brief      callback module to init and start reporting profiling data
 * @param [in] deviceId:       device id to start report
 * @param [in] reportAttr:     report attr
 * @param [in] dataTypeConfig: report data type config
 * @return     PROFILING_FAILED  : failed
 *             PROFILING_SUCCESS : success
 */
int32_t ReportManagerCollectStart(const uint32_t *deviceList, const size_t deviceNum,
    ReportAttribute *reportAttr, uint64_t dataTypeConfig)
{
    PROF_CHK_EXPR_ACTION(deviceNum > UINT32_MAX, return PROFILING_FAILED,
        "Device number %" PRIu64 " is bigger than uint32 type, and reset it to 0.", deviceNum);
    ProfCommand command;
    errno_t ret = memset_s(&command, sizeof(command), 0, sizeof(command));
    if (ret != EOK) {
        MSPROF_LOGE("ProfCommand memset_s failed, ret : %d", ret);
        return PROFILING_FAILED;
    }
    command.type = PROF_COMMANDHANDLE_TYPE_INIT;
    CommandHandleCallback(reportAttr, &command);
    command.profSwitch = dataTypeConfig;
    command.type = PROF_COMMANDHANDLE_TYPE_START;
    command.devNums = (uint32_t)deviceNum;
    command.modelId = PROF_INVALID_MODE_ID;
    CommandhandleProcessDeviceList(&command, deviceList, deviceNum);
    if (CommandHandleSetParams(&command) != PROFILING_SUCCESS) {
        MSPROF_LOGE("ProfStart CommandHandle set failed");
        return PROFILING_FAILED;
    }
    CommandHandleCallback(reportAttr, &command);
    return PROFILING_SUCCESS;
}

 /**
 * @brief      callback module to stop reporting profiling data
 * @param [in] deviceId:       device id to stop report
 * @param [in] reportAttr:     report attr
 * @param [in] dataTypeConfig: report data type config
 * @return     PROFILING_FAILED  : failed
 *             PROFILING_SUCCESS : success
 */
int32_t ReportManagerCollectStop(const uint32_t *deviceList, const size_t deviceNum,
    ReportAttribute *reportAttr, uint64_t dataTypeConfig)
{
    PROF_CHK_EXPR_ACTION(deviceNum > UINT32_MAX, return PROFILING_FAILED,
        "Device number %" PRIu64 " is bigger than uint32 type, and reset it to 0.", deviceNum);
    ProfCommand command;
    errno_t ret = memset_s(&command, sizeof(command), 0, sizeof(command));
    if (ret != EOK) {
        MSPROF_LOGE("ProfCommand memset_s failed, ret : %d", ret);
        return PROFILING_FAILED;
    }
    command.profSwitch = dataTypeConfig;
    command.type = PROF_COMMANDHANDLE_TYPE_STOP;
    command.devNums = (uint32_t)deviceNum;
    command.modelId = PROF_INVALID_MODE_ID;
    CommandhandleProcessDeviceList(&command, deviceList, deviceNum);
    if (CommandHandleSetParams(&command) != PROFILING_SUCCESS) {
        MSPROF_LOGE("ProfStart CommandHandle set failed");
        return PROFILING_FAILED;
    }
    CommandHandleCallback(reportAttr, &command);
    // flush host reporters
    HashDataStop();
    TypeInfoStop();
    ReportStop();
    return PROFILING_SUCCESS;
}

 /**
 * @brief      callback module to finalize reporting profiling data
 * @param [in] reportAttr:     report attr
 * @param [in] dataTypeConfig: report data type config
 * @return     PROFILING_FAILED  : failed
 *             PROFILING_SUCCESS : success
 */
int32_t ReportManagerCollectFinalize(ReportAttribute *reportAttr)
{
    ProfCommand command;
    errno_t ret = memset_s(&command, sizeof(command), 0, sizeof(command));
    if (ret != EOK) {
        MSPROF_LOGE("ProfCommand memset_s failed, ret : %d", ret);
        return PROFILING_FAILED;
    }
    command.type = PROF_COMMANDHANDLE_TYPE_FINALIZE;
    CommandHandleCallback(reportAttr, &command);
    return PROFILING_SUCCESS;
}

 /**
 * @brief      flush data in reporter
 * @param [in] reportAttr:     report attr
 * @return     PROFILING_FAILED  : failed
 *             PROFILING_SUCCESS : success
 */
static void ReportManagerFlushData(ReportAttribute *reportAttr)
{
    UNUSED(reportAttr);
}

int32_t ReportManagerFinalize(ReportAttribute *reportAttr)
{
    int32_t ret = ReportManagerCollectFinalize(reportAttr);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Finalize report manager collect failed, ret : %d", ret);
        return ret;
    }
    ReportManagerFlushData(reportAttr);
    return PROFILING_SUCCESS;
}

void HostReportFinalize(void)
{
    ReportUninitialize();
    TypeInfoUninit();
    HashDataUninit();
}

/**
 * @brief      Create pointer of TypeInfoList to save type info data
 * @return     success: pointer of TypeInfoList
 *             failed : NULL
 */
static TypeInfoList *CreateTypeInfoList(void)
{
    TypeInfoList *hashList = (TypeInfoList*)OsalCalloc(sizeof(TypeInfoList));
    if (hashList == NULL) {
        return NULL;
    }
    hashList->head = NULL;
    hashList->size = 0;
    return hashList;
}

/**
 * @brief      Add a node for TypeInfoList to save type info data
 * @param [in] level: target level
 * @param [in] typeId: target typeId
 * @param [in] typeName: target typeName
 * @return     true: save data success
 *             false : save data failed
 */
static bool AddTypeInfoNode(uint16_t level, uint32_t typeId, const char *typeName)
{
    TypeInfoNode *node = (TypeInfoNode*)OsalCalloc(sizeof(TypeInfoNode));
    if (node == NULL) {
        MSPROF_LOGE("An error occurred while creating the type info node");
        return false;
    }
    node->typeName = typeName;
    node->level = level;
    node->typeId = typeId;
    node->next = g_typeInfoList->head;
    g_typeInfoList->head = node;
    g_typeInfoList->size++;
    return true;
}

/**
 * @brief      Search target level/typeId/typeName has already exisited in linked list node.
 * @param [in] level: target level
 * @param [in] typeId: target typeId
 * @param [in] typeName: target typeName
 * @return     PROFILING_SUCCESS: corresponding node found
 *             PROFILING_FAILED : corresponding node not found
 */
static int32_t SearchTypeInfoNode(uint16_t level, uint32_t typeId)
{
    TypeInfoNode *node = g_typeInfoList->head;
    while (node != NULL) {
        if (node->level == level && node->typeId == typeId) {
            return PROFILING_SUCCESS;
        }
        node = node->next;
    }
    return PROFILING_FAILED;
}

/**
 * @brief      Free type info linked list.
 * @return     void
 */
static void FreeTypeInfoList(void)
{
    TypeInfoNode *currNode = g_typeInfoList->head;
    while (currNode != NULL) {
        TypeInfoNode *tempNode = currNode;
        currNode = currNode->next;
        OSAL_MEM_FREE(tempNode);
    }
    OSAL_MEM_FREE(g_typeInfoList);
}

/**
 * @brief      Save default data into linked list
 * @return     success: PROFILING_SUCCESS
 *             failed: PROFILING_FAILED
 */
static int32_t SaveDefaultInfo(void)
{
    int32_t ret = PROFILING_SUCCESS;
    for (int32_t idx = 0; idx < DEFAULT_TYPE_INFO_SIZE; idx++) {
        ret = RegReportTypeInfo(DEFAULT_TYPE_INFO[idx].level, DEFAULT_TYPE_INFO[idx].typeId,
            DEFAULT_TYPE_INFO[idx].typeName);
        if (ret != PROFILING_SUCCESS) {
            return PROFILING_FAILED;
        }
    }
    return PROFILING_SUCCESS;
}

/**
 * @brief      Init type info list and switch the status to ready to receive data. Thread will be created.
 * @return     success: PROFILING_SUCCESS
 *             failed : PROFILING_FAILED
 */
int32_t TypeInfoInit(void)
{
    (void)OsalMutexLock(&g_infoType.typeInfoMtx);
    if (g_infoType.infoInit) {
        MSPROF_LOGW("HashData repeated initialize");
        (void)OsalMutexUnlock(&g_infoType.typeInfoMtx);
        return PROFILING_SUCCESS;
    }
    g_typeInfoList = CreateTypeInfoList();
    if (g_typeInfoList == NULL) {
        MSPROF_LOGE("An error occurs during type info initialization, and the type list fails to be created.");
        (void)OsalMutexUnlock(&g_infoType.typeInfoMtx);
        return PROFILING_FAILED;
    }
    g_infoType.infoInit = true;
    g_infoType.infoStop = false;
    do {
        int32_t ret = SaveDefaultInfo();
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to SaveDefaultInfo.");
            break;
        }
        MSPROF_LOGI("TypeInfoReport initialize success");
        (void)OsalMutexUnlock(&g_infoType.typeInfoMtx);
        return PROFILING_SUCCESS;
    } while (0);
    g_infoType.infoInit = false;
    g_infoType.infoStop = true;
    FreeTypeInfoList();
    (void)OsalMutexUnlock(&g_infoType.typeInfoMtx);
    return PROFILING_FAILED;
}

/**
 * @brief      Save input info data to linked list
 * @param [in] hashInfo: hash data
 * @return     success: PROFILING_SUCCESS
 *             failed : PROFILING_FAILED
 */
int32_t RegReportTypeInfo(uint16_t level, uint32_t typeId, const char *typeName)
{
    (void)OsalMutexLock(&g_infoType.regMtx);
    if (!g_infoType.infoInit || g_infoType.infoStop) {
        MSPROF_LOGW("HashData reporter not inited or has been stopped.");
        (void)OsalMutexUnlock(&g_infoType.regMtx);
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("Register type info of reporter[%u], type id %u, type name %s", level, typeId, typeName);
    int32_t ret = SearchTypeInfoNode(level, typeId);
    if (ret != PROFILING_SUCCESS && !AddTypeInfoNode(level, typeId, typeName)) {
        MSPROF_LOGE("Register type info node failed.");
        (void)OsalMutexUnlock(&g_infoType.regMtx);
        return PROFILING_FAILED;
    }
    (void)OsalMutexUnlock(&g_infoType.regMtx);
    return PROFILING_SUCCESS;
}

/**
 * @brief      combine type info into chunk, prepare for upload.
 * @param [in] data: type info data after combination
 * @param [in] chunk: Pointer to the chunk to be saved
 * @param [in] isLastChunk: target of isLastChunk
 * @return     void
 */
static void FillTypeData(ProfFileChunk *chunk, char *data, size_t dataSize, bool isLastChunk)
{
    chunk->chunkSize = dataSize;
    chunk->chunkType = PROF_HOST_DATA;
    chunk->isLastChunk = isLastChunk;
    chunk->offset = -1;
    chunk->deviceId = DEFAULT_HOST_ID;
    errno_t ret = strcpy_s((char *)chunk->fileName, MAX_FILE_CHUNK_NAME_LENGTH, "unaging.additional.type_info_dic");
    PROF_CHK_EXPR_ACTION_TWICE(ret != EOK, chunk->chunk = NULL, return, "strcpy_s type_info_dic to chunk failed.");
    chunk->chunk = (uint8_t*)OsalCalloc(dataSize + 1U);
    PROF_CHK_EXPR_ACTION(chunk->chunk == NULL, return, "malloc chunk failed.");
    ret = memcpy_s(chunk->chunk, dataSize + 1U, data, dataSize);
    if (ret != EOK) {
        OSAL_MEM_FREE(chunk->chunk);
        MSPROF_LOGE("An error occurred while doing chunk memcpy.");
        return;
    }
}

/**
 * @brief      Type info data combination based on the format
 * @param [in] node: node saved in type info linked list
 * @param [in] buffer: Pointer to the buffer to be saved
 * @param [in] bufferSize: buffer size
 * @return     void
 */
static void ConcatenateTypeInfo(TypeInfoNode *node, char *buffer, size_t bufferSize)
{
    if (node->typeName == NULL) {
        MSPROF_LOGW("typeName invalid level:%u id:%u.", node->level, node->typeId);
        return;
    }
    char *typeLevel = TransferUint32ToString((uint32_t)node->level);
    char *typeId = TransferUint32ToString(node->typeId);
    errno_t ret = strcat_s(buffer, bufferSize, typeLevel);
    PROF_CHK_EXPR_ACTION(ret != EOK, break, "Failed to strcat_s %s to type info node, ret is %d.", typeLevel, ret);
    ret = strcat_s(buffer, bufferSize, "_");
    PROF_CHK_EXPR_ACTION(ret != EOK, break, "Failed to strcat_s _ to type info node, ret is %d.", ret);
    ret = strcat_s(buffer, bufferSize, typeId);
    PROF_CHK_EXPR_ACTION(ret != EOK, break, "Failed to strcat_s %s to type info node, ret is %d.", typeId, ret);
    ret = strcat_s(buffer, bufferSize, ":");
    PROF_CHK_EXPR_ACTION(ret != EOK, break, "Failed to strcat_s : to type info node, ret is %d.", ret);
    ret = strcat_s(buffer, bufferSize, node->typeName);
    PROF_CHK_EXPR_ACTION(ret != EOK, break, "Failed to strcat_s %s to type info node, ret is %d.", node->typeName, ret);
    ret = strcat_s(buffer, bufferSize, "\n");
    PROF_CHK_EXPR_ACTION(ret != EOK, break, "Failed to strcat_s enter key to type info node, ret is %d.", ret);
    OSAL_MEM_FREE(typeLevel);
    OSAL_MEM_FREE(typeId);
}

/**
 * @brief      Check the length of data stored on the current node.
 * @param [in] node: node saved in TypeInfoNode
 * @return     current node data and id length
 */
static size_t GetTypeInfoSize(TypeInfoNode *node)
{
    size_t nameSize = strlen(node->typeName);
    uint16_t level = node->level;
    uint32_t typeId = node->typeId;
    size_t levelSize = 0;
    while (level > 0) {
        level /= INTEGER_NUMBER_TEN;
        levelSize++;
    }
    size_t idSize = 0;
    while (typeId > 0) {
        typeId /= INTEGER_NUMBER_TEN;
        idSize++;
    }
    return nameSize + levelSize + idSize + INTEGER_NUMBER_THREE;
}

/**
 * @brief      Check the length of data stored on the current node.
 * @param [in] level: node saved in TypeInfoNode
 * @param [in] typeId: node saved in TypeInfoNode
 * @return     TypeName
 */
const CHAR *GetTypeName(uint16_t level, uint32_t typeId)
{
    (void)OsalMutexLock(&g_infoType.regMtx);
    TypeInfoNode *node = g_typeInfoList->head;
    while (node != NULL) {
        if (node->level == level && node->typeId == typeId) {
            (void)OsalMutexUnlock(&g_infoType.regMtx);
            return node->typeName;
        }
        node = node->next;
    }
    (void)OsalMutexUnlock(&g_infoType.regMtx);
    return "invalid";
}

/**
 * @brief      Read type info, combine hash info, send hash chunk
 * @param [in] isLastChunk: whether is last time
 * @return     void
 */
void SaveTypeInfoData(TypeInfoFlag *flag, bool isLastChunk)
{
    (void)OsalMutexLock(&g_infoType.regMtx);
    if (!flag->infoInit || flag->infoStop) {
        MSPROF_LOGW("Type info is not initialized or has been stoped.");
        (void)OsalMutexUnlock(&g_infoType.regMtx);
        return;
    }
    if (GetDataUploader(DEFAULT_HOST_ID) == NULL) {
        (void)OsalMutexUnlock(&g_infoType.regMtx);
        return;
    }
    char *infoBuffer = (char*)OsalCalloc(QUEUE_BUFFER_SIZE + 1);
    PROF_CHK_EXPR_ACTION_TWICE(infoBuffer == NULL, (void)OsalMutexUnlock(&g_infoType.regMtx), return,
        "InfoBuffer calloc failed.");
    infoBuffer[0] = '\0';
    TypeInfoNode *currNode = g_typeInfoList->head;

    do {
        if (currNode == NULL || g_infoType.typeCursors == g_typeInfoList->size) {
            break;
        }
        ConcatenateTypeInfo(currNode, infoBuffer, QUEUE_BUFFER_SIZE + 1);
        g_infoType.typeCursors++;
        currNode = currNode->next;
        if (currNode == NULL || GetTypeInfoSize(currNode) + strlen(infoBuffer) > QUEUE_BUFFER_SIZE ||
            g_infoType.typeCursors == g_typeInfoList->size) {
            ProfFileChunk *chunk = (ProfFileChunk *)OsalCalloc(sizeof(ProfFileChunk));
            if (chunk == NULL) {
                MSPROF_LOGE("malloc file chunk failed.");
                break;
            }
            FillTypeData(chunk, infoBuffer, strlen(infoBuffer), isLastChunk);
            if (chunk->chunk == NULL) {
                OSAL_MEM_FREE(chunk);
                break;
            }
            (void)UploaderUploadData(chunk);
            MSPROF_LOGI("total_size_typeInfo, saveLen:%zu bytes, typeSize:%" PRIu64 ", uploadSize:%" PRIu64 ".",
                strlen(infoBuffer), g_typeInfoList->size, g_infoType.typeCursors);
            errno_t err = memset_s(infoBuffer, QUEUE_BUFFER_SIZE + 1, 0, QUEUE_BUFFER_SIZE + 1);
            if (err != EOK) {
                MSPROF_LOGE("memset_s type info failed.");
                break;
            }
        }
    } while (currNode != NULL && g_typeInfoList->size > g_infoType.typeCursors);
    OSAL_MEM_FREE(infoBuffer);
    (void)OsalMutexUnlock(&g_infoType.regMtx);
}

/**
 * @brief      Stop type info task, flush type info date for the last time
 * @return     void
 */
void TypeInfoStop(void)
{
    (void)OsalMutexLock(&g_infoType.typeInfoMtx);
    if (!g_infoType.infoInit && g_infoType.infoStop) {
        MSPROF_LOGI("TypeInfo hash been stoped.");
        (void)OsalMutexUnlock(&g_infoType.typeInfoMtx);
        return;
    }
    MSPROF_LOGI("TypeInfo start to stop.");
    SaveTypeInfoData(&g_infoType, true);
    g_infoType.infoStop = true;
    g_infoType.typeCursors = 0;
    MSPROF_LOGI("TypeInfo stop success.");
    (void)OsalMutexUnlock(&g_infoType.typeInfoMtx);
}

/**
 * @brief      Uninit type info task, destroy type info list, reset status
 * @return     void
 */
void TypeInfoUninit(void)
{
    (void)OsalMutexLock(&g_infoType.typeInfoMtx);
    if (!g_infoType.infoInit && g_infoType.infoStop) {
        MSPROF_LOGI("TypeInfo hash been uninitialized.");
        (void)OsalMutexUnlock(&g_infoType.typeInfoMtx);
        return;
    }
    g_infoType.infoInit = false;
    g_infoType.infoStop = true;
    g_infoType.typeCursors = 0;
    FreeTypeInfoList();
    MSPROF_LOGI("TypeInfo uninitialize success.");
    (void)OsalMutexUnlock(&g_infoType.typeInfoMtx);
}