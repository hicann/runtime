/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "hash_dic.h"
#include "inttypes.h"
#include "logger/logger.h"
#include "errno/error_code.h"
#include "osal/osal_mem.h"
#include "osal/osal_thread.h"
#include "transport/transport.h"
#include "transport/uploader.h"
#include "utils/utils.h"
#include "task/task_slot.h"

#define UINT32_BITES 32U
bool g_hashInit = false;
bool g_hashStop = true;
uint64_t g_hashCursors = 0;
OsalMutex g_initMutex = PTHREAD_MUTEX_INITIALIZER;
OsalMutex g_regHashMtx = PTHREAD_MUTEX_INITIALIZER;
HashDataList *g_hashList = NULL;

/**
 * @brief      Create a pointer to the HashDataList to store hash data.
 * @return     success: pointer of HashDataList
 *             failed : NULL
 */
static HashDataList *CreateHashList(void)
{
    HashDataList *hashList = (HashDataList*)OsalCalloc(sizeof(HashDataList));
    if (hashList == NULL) {
        return NULL;
    }
    hashList->head = NULL;
    hashList->size = 0;
    return hashList;
}

/**
 * @brief      Create a node for the HashDataList linked list and save the data and id to the node.
 * @param [in] hashInfo: hash data
 * @param [in] hashId: hash id
 * @return     success: pointer of HashDataList
 *             failed : NULL
 */
static bool AddHashNode(const char *hashInfo, uint64_t hashId)
{
    HashDataNode *node = (HashDataNode*)OsalCalloc(sizeof(HashDataNode));
    if (node == NULL) {
        MSPROF_LOGE("An error occurred while creating the node");
        return false;
    }
    size_t hashLen = strlen(hashInfo);
    node->hashInfo = (char*)OsalCalloc(hashLen + 1);
    if (node->hashInfo == NULL) {
        OSAL_MEM_FREE(node);
        MSPROF_LOGE("An error occurred while creating the hashInfo memory.");
        return false;
    }
    errno_t ret = memcpy_s(node->hashInfo, hashLen + 1, hashInfo, hashLen);
    if (ret != EOK) {
        OSAL_MEM_FREE(node);
        MSPROF_LOGE("An error occurred while doing hashInfo memcpy.");
        return false;
    }
    node->hashId = hashId;
    node->next = g_hashList->head;
    g_hashList->head = node;
    g_hashList->size++;
    return true;
}

/**
 * @brief      Search each node in the HashDataList linked list. If the target hash data exists,
 *               the corresponding hash ID is returned.
 * @param [in] hashInfo: hash data
 * @return     success: corresponding hash ID
 *             failed : 0
 */
static uint64_t SearchHashIdNode(const char *hashInfo)
{
    HashDataNode *node = g_hashList->head;
    while (node != NULL) {
        if (strcmp(node->hashInfo, hashInfo) == 0) {
            return node->hashId;
        }
        node = node->next;
    }
    return 0;
}

/**
 * @brief      Search each node in the HashDataList linked list. If the target id data exists, "true" is returned.
 * @param [in] hashId: hash id
 * @return     success: true
 *             failed : false
 */
static bool SearchHashInfoNode(uint64_t hashId)
{
    HashDataNode *node = g_hashList->head;
    while (node != NULL) {
        if (node->hashId == hashId) {
            return true;
        }
        node = node->next;
    }
    return false;
}

/**
 * @brief      Free the pointer to the H that stores the hash data.
 * @return     void
 */
static void FreeHashList(void)
{
    if (g_hashList == NULL) {
        return;
    }
    HashDataNode *currNode = g_hashList->head;
    while (currNode != NULL) {
        HashDataNode *tempNode = currNode;
        currNode = currNode->next;
        OSAL_MEM_FREE(tempNode->hashInfo);
        OSAL_MEM_FREE(tempNode);
    }
    OSAL_MEM_FREE(g_hashList);
}

/**
 * @brief      Init hash list and switch the status to ready to receive data.
 * @return     success: PROFILING_SUCCESS
 *             failed : PROFILING_FAILED
 */
int32_t HashDataInit(void)
{
    (void)OsalMutexLock(&g_initMutex);
    if (g_hashInit) {
        MSPROF_LOGW("HashData repeated initialize");
        (void)OsalMutexUnlock(&g_initMutex);
        return PROFILING_SUCCESS;
    }
    g_hashList = CreateHashList();
    if (g_hashList == NULL) {
        MSPROF_LOGE("An error occurs during HashData initialization, and the hashList fails to be created.");
        (void)OsalMutexUnlock(&g_initMutex);
        return PROFILING_FAILED;
    }

    g_hashInit = true;
    g_hashStop = false;
    MSPROF_LOGI("HashData initialize success");
    (void)OsalMutexUnlock(&g_initMutex);
    return PROFILING_SUCCESS;
}

/**
 * @brief      DoubleHash, create hash id for corresponding hash data.
 * @param [in] data: hash data
 * @return     Hash id
 */
static uint64_t DoubleHash(const char *data)
{
    uint64_t prime[2] = {29, 131};
    uint64_t hash[2] = {0};
    int32_t idx = 0;

    while (data[idx] != '\0') {
        hash[0] = hash[0] * prime[0] + (uint64_t)data[idx];
        hash[1] = hash[1] * prime[1] + (uint64_t)data[idx];
        idx++;
    }
    return ((hash[0] << UINT32_BITES) | hash[1]);
}

/**
 * @brief      Creates a hash ID for the input hash data. During this process, this function will checks whether
 *              the hash data and hash ID exist.
 * @param [in] hashInfo: hash data
 * @return     success: corresponding hash ID
 *             failed : UINT64_MAX
 */
uint64_t GeneratedHashId(const char *hashInfo)
{
    (void)OsalMutexLock(&g_regHashMtx);
    if (!g_hashInit || g_hashStop) {
        MSPROF_LOGW("HashData not inited");
        (void)OsalMutexUnlock(&g_regHashMtx);
        return UINT64_MAX;
    }
    uint64_t hashId = SearchHashIdNode(hashInfo);
    if (hashId != 0) {
        (void)OsalMutexUnlock(&g_regHashMtx);
        MSPROF_LOGD("find hash id:%" PRIu64 ".", hashId);
        return hashId;
    }

    hashId = DoubleHash(hashInfo);
    if (SearchHashInfoNode(hashId)) {
        MSPROF_LOGW("HashData GenHashId conflict, hashId:%" PRIu64 " newStr:%s",
                hashId, hashInfo);
    } else {
        if (!AddHashNode(hashInfo, hashId)) {
            MSPROF_LOGE("Add node to hashList failed.");
            (void)OsalMutexUnlock(&g_regHashMtx);
            return UINT64_MAX;
        }
    }
    MSPROF_LOGD("HashData GenHashId id:%" PRIu64 " data:%s", hashId, hashInfo);
    (void)OsalMutexUnlock(&g_regHashMtx);
    return hashId;
}

/**
 * @brief      Check the length of data stored on the current node.
 * @param [in] node: node saved in HashDataList
 * @return     current node data and id length
 */
static size_t GetHashInfoSize(HashDataNode *node)
{
    size_t infoSize = strlen(node->hashInfo);
    uint64_t hashId = node->hashId;
    size_t hashIdSize = 0;
    while (hashId > 0) {
        hashId /= INTEGER_NUMBER_TEN;
        hashIdSize++;
    }
    return infoSize + hashIdSize + INTEGER_NUMBER_TWO;
}

/**
 * @brief      Hash data combination based on the format
 * @param [in] node: node saved in HashDataList
 * @param [in] buffer: Pointer to the buffer to be saved
 * @param [in] bufferSize: buffer size
 * @return     void
 */
static void ConcatenateHash(HashDataNode *node, char *buffer, size_t bufferSize)
{
    if (node->hashInfo == NULL) {
        MSPROF_LOGW("HashData invalid id:%" PRIu64 ".", node->hashId);
        return;
    }
    char *hashId = TransferUint64ToString(node->hashId);
    PROF_CHK_EXPR_ACTION(hashId == NULL, return, "Failed to transfer id into string, id is %" PRIu64 ".", node->hashId);
    errno_t ret = strcat_s(buffer, bufferSize, hashId);
    PROF_CHK_EXPR_ACTION(ret != EOK, break, "Failed to strcat_s %s to hash node, ret is %d.", hashId, ret);
    ret = strcat_s(buffer, bufferSize, ":");
    PROF_CHK_EXPR_ACTION(ret != EOK, break, "Failed to strcat_s : to hash node, ret is %d.", ret);
    ret = strcat_s(buffer, bufferSize, node->hashInfo);
    PROF_CHK_EXPR_ACTION(ret != EOK, break, "Failed to strcat_s %s to hash node, ret is %d.", node->hashInfo, ret);
    ret = strcat_s(buffer, bufferSize, "\n");
    PROF_CHK_EXPR_ACTION(ret != EOK, break, "Failed to strcat_s enter key to hash node, ret is %d.", ret);
    OSAL_MEM_FREE(hashId);
}

/**
 * @brief      combine hash info into chunk, prepare for upload.
 * @param [in] data: hash data after combination
 * @param [in] chunk: Pointer to the chunk to be saved
 * @param [in] isLastChunk: target of isLastChunk
 * @return     void
 */
static void FillHashData(ProfFileChunk *chunk, char *data, size_t dataSize, bool isLastChunk)
{
    chunk->chunkSize = dataSize;
    chunk->chunkType = PROF_HOST_DATA;
    chunk->isLastChunk = isLastChunk;
    chunk->offset = -1;
    chunk->deviceId = DEFAULT_HOST_ID;
    errno_t ret = strcpy_s((char *)chunk->fileName, MAX_FILE_CHUNK_NAME_LENGTH, "unaging.additional.hash_dic");
    PROF_CHK_EXPR_ACTION_TWICE(ret != EOK, chunk->chunk = NULL, return, "strcpy_s hash_dic name to chunk failed.");
    chunk->chunk = (uint8_t*)OsalCalloc(dataSize + 1U);
    PROF_CHK_EXPR_ACTION(chunk->chunk == NULL, return, "malloc chunk failed.");
    ret = memcpy_s(chunk->chunk, dataSize + 1U, data, dataSize);
    if (ret != EOK) {
        OSAL_MEM_FREE(chunk->chunk);
        MSPROF_LOGE("An error occurred while doing chunk memcpy.");
    }
}

/**
 * @brief      read hash info, combine hash info, send hash chunk
 * @param [in] isLastChunk: whether is last time
 * @return     void
 */
void SaveHashData(bool isLastChunk)
{
    (void)OsalMutexLock(&g_regHashMtx);
    if (!g_hashInit || g_hashStop) {
        MSPROF_LOGW("HashData not inited or stopted");
        (void)OsalMutexUnlock(&g_regHashMtx);
        return;
    }
    char *hashbuffer = (char*)OsalCalloc(QUEUE_BUFFER_SIZE + 1);
    PROF_CHK_EXPR_ACTION_TWICE(hashbuffer == NULL, (void)OsalMutexUnlock(&g_regHashMtx), return,
        "Hashbuffer calloc failed.");
    HashDataNode *currNode = g_hashList->head;
    do {
        if (currNode == NULL || g_hashCursors == g_hashList->size) {
            break;
        }
        ConcatenateHash(currNode, hashbuffer, QUEUE_BUFFER_SIZE + 1);
        g_hashCursors++;
        currNode = currNode->next;
        if (currNode == NULL || GetHashInfoSize(currNode) + strlen(hashbuffer) > QUEUE_BUFFER_SIZE ||
            g_hashCursors == g_hashList->size) {
            ProfFileChunk *chunk = (ProfFileChunk*)OsalCalloc(sizeof(ProfFileChunk));
            if (chunk == NULL) {
                MSPROF_LOGE("malloc file chunk failed.");
                break;
            }
            FillHashData(chunk, hashbuffer, strlen(hashbuffer), isLastChunk);
            if (chunk->chunk == NULL) {
                OSAL_MEM_FREE(chunk);
                break;
            }
            (void)UploaderUploadData(chunk);
            MSPROF_LOGI("total_size_HashData, saveLen:%zu bytes, hashSize:%" PRIu64 ", uploadSize:%" PRIu64 ".",
                strlen(hashbuffer), g_hashList->size, g_hashCursors);
            errno_t ret = memset_s(hashbuffer, QUEUE_BUFFER_SIZE + 1, 0, QUEUE_BUFFER_SIZE + 1);
            if (ret != EOK) {
                MSPROF_LOGE("memset_s hashData failed.");
                break;
            }
        }
    } while (currNode != NULL && g_hashList->size > g_hashCursors);
    OSAL_MEM_FREE(hashbuffer);
    if (isLastChunk) {
        g_hashStop = true;
    }
    (void)OsalMutexUnlock(&g_regHashMtx);
}

/**
 * @brief      Stop hash task, flush hash date for the last time
 * @return     void
 */
void HashDataStop(void)
{
    (void)OsalMutexLock(&g_initMutex);
    if (!g_hashInit && g_hashStop) {
        MSPROF_LOGW("HashData not initialize");
        (void)OsalMutexUnlock(&g_initMutex);
        return;
    }
    MSPROF_LOGI("Start stop hash data.");
    SaveHashData(true);
    g_hashCursors = 0;
    MSPROF_LOGI("HashData stop success.");
    (void)OsalMutexUnlock(&g_initMutex);
}

/**
 * @brief      Uninit hash task, destroy hash list, reset status
 * @return     void
 */
void HashDataUninit(void)
{
    (void)OsalMutexLock(&g_initMutex);
    if (!g_hashInit && g_hashStop) {
        MSPROF_LOGW("HashData not initialize.");
        (void)OsalMutexUnlock(&g_initMutex);
        return;
    }
    g_hashInit = false;
    g_hashStop = true;
    g_hashCursors = 0;
    FreeHashList();
    MSPROF_LOGI("HashData uninitialize success.");
    (void)OsalMutexUnlock(&g_initMutex);
}