/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "uploader.h"
#include "inttypes.h"
#include "securec.h"
#include "errno/error_code.h"
#include "logger/logger.h"
#include "thread/thread_pool.h"
#include "hal/hal_dsmi.h"
#include "osal/osal_thread.h"

UploaderMgrAttr g_uploader = {MAX_DEVICE_NUM, NULL, PTHREAD_MUTEX_INITIALIZER, NULL};

/**
 * @brief Flush uploader to make sure that all data have been uploaded
 * @param [in] deviceId : device id
 */
void UploaderFlush(uint32_t deviceId)
{
    (void)OsalMutexLock(&g_uploader.uploaderMtx);
    UploaderAttr* uploader = GetDataUploader(deviceId);
    if (uploader == NULL) {
        (void)OsalMutexUnlock(&g_uploader.uploaderMtx);
        return;
    }
    if (uploader->destruct) {
        MSPROF_LOGI("Uploader %u is already destroy.", deviceId);
        (void)OsalMutexUnlock(&g_uploader.uploaderMtx);
        return;
    }
    (void)OsalMutexLock(&uploader->dataMtx);
    if (uploader->size > 0) {
        MSPROF_LOGD("Wait for uploader queue clear.");
        OsalCondWait(&uploader->clearCond, &uploader->dataMtx);
    }
    (void)OsalMutexUnlock(&uploader->dataMtx);
    MSPROF_LOGI("Uploader %u flush successfully.", deviceId);
    (void)OsalMutexUnlock(&g_uploader.uploaderMtx);
}

/**
 * @brief Init device uploader list
 */
int32_t UploaderInitialize(void)
{
    if (g_uploader.uploaderList != NULL) {
        MSPROF_LOGI("Repeat init uploader.");
        return PROFILING_SUCCESS;
    }
    (void)OsalMutexLock(&g_uploader.uploaderMtx);
    g_uploader.devNum = HalGetDeviceNumber();
    if (g_uploader.devNum == 0) {
        (void)OsalMutexUnlock(&g_uploader.uploaderMtx);
        MSPROF_LOGE("Failed to get device number.");
        return PROFILING_FAILED;
    }
    g_uploader.uploaderList = (CstlList *)OsalCalloc(sizeof(CstlList) * g_uploader.devNum);
    if (g_uploader.uploaderList == NULL) {
        (void)OsalMutexUnlock(&g_uploader.uploaderMtx);
        MSPROF_LOGE("Failed to calloc uploaderList.");
        return PROFILING_FAILED;
    }

    int32_t ret = CSTL_ERR;
    for (uint32_t i = 0; i < g_uploader.devNum; ++i) {
        ret = CstlListInit(&g_uploader.uploaderList[i], OsalFree);
        if (ret != CSTL_OK) {
            MSPROF_LOGE("Failed to CstlListInit uploaderList.");
            OSAL_MEM_FREE(g_uploader.uploaderList);
            (void)OsalMutexUnlock(&g_uploader.uploaderMtx);
            return PROFILING_FAILED;
        }
    }
    (void)OsalMutexUnlock(&g_uploader.uploaderMtx);
    MSPROF_LOGI("Success to init uploader list.");
    return PROFILING_SUCCESS;
}

/**
 * @brief Finalize device uploader list and host uploader
 */
int32_t UploaderFinalize(void)
{
    (void)OsalMutexLock(&g_uploader.uploaderMtx);
    if (g_uploader.uploaderList == NULL) {
        (void)OsalMutexUnlock(&g_uploader.uploaderMtx);
        MSPROF_LOGI("Uploader list is already finalize.");
        return PROFILING_SUCCESS;
    }

    for (uint32_t i = 0; i < g_uploader.devNum; ++i) {
        (void)CstlListDeinit(&g_uploader.uploaderList[i]);
    }
    OSAL_MEM_FREE(g_uploader.uploaderList);
    OSAL_MEM_FREE(g_uploader.uploaderHost);
    (void)OsalMutexUnlock(&g_uploader.uploaderMtx);
    MSPROF_LOGI("Success to finalize uploader.");
    return PROFILING_SUCCESS;
}

/**
 * @brief Init uploader basic attributes
 * @param [in] param    : prof params pointer
 * @param [in] deviceId : device id
 * @param [in] capacity : size of data queue which need to malloc
 * @return uploader pointer
 */
static UploaderAttr* InitDataUploaderBasic(const ProfileParam *param, uint32_t deviceId, uint32_t capacity)
{
    // calloc uploader
    UploaderAttr* uploader = (UploaderAttr*)OsalCalloc(sizeof(UploaderAttr));
    if (uploader == NULL) {
        MSPROF_LOGE("Failed to calloc for uploader, device: %u.", deviceId);
        return NULL;
    }
    uploader->deviceId = deviceId;
    uploader->capacity = capacity;
    uploader->destruct = false;
    uploader->enable = false;
    uploader->front = 0;
    uploader->rear = 0;
    // init basic flush data dir
    errno_t ret = strcat_s(uploader->baseDir, sizeof(uploader->baseDir), param->config.resultDir);
    PROF_CHK_EXPR_ACTION_TWICE(ret != EOK, OSAL_MEM_FREE(uploader), return NULL,
        "Failed to strcpy_s resultDir for uploader, device: %u, ret: %d.", deviceId, ret);

    // malloc transport
    uploader->transport = (Transport*)OsalCalloc(sizeof(Transport));
    if (uploader->transport == NULL) {
        MSPROF_LOGE("Failed to malloc transport for uploader, device: %u.", deviceId);
        OSAL_MEM_FREE(uploader);
        return NULL;
    }
    // malloc data queue
    uploader->dataQueue = (ProfFileChunk**)OsalCalloc(sizeof(ProfFileChunk*) * capacity);
    if (uploader->dataQueue == NULL) {
        MSPROF_LOGE("Failed to malloc data queue for uploader, device: %u.", deviceId);
        OSAL_MEM_FREE(uploader->transport);
        OSAL_MEM_FREE(uploader);
        return NULL;
    }
    // init mutex and condition
    if (OsalMutexInit(&uploader->dataMtx) != 0 || OsalMutexInit(&uploader->uploadMtx) != 0 ||
        OsalCondInit(&uploader->notEmpty) != 0 || OsalCondInit(&uploader->notFull) != 0) {
        MSPROF_LOGE("Failed to init mutex and condition for uploader, device: %u.", deviceId);
        OSAL_MEM_FREE(uploader->dataQueue);
        OSAL_MEM_FREE(uploader->transport);
        OSAL_MEM_FREE(uploader);
        return NULL;
    }
    return uploader;
}

/**
 * @brief Try to pop from uploader data queue
 * @param [in] uploader : uploader pointer
 * @return chunk data pop from uploader data queue
 */
static ProfFileChunk *TryPopUploader(UploaderAttr* uploader)
{
    (void)OsalMutexLock(&uploader->dataMtx);
    if (uploader->size == 0 && !uploader->destruct) {
        OsalCondWait(&uploader->notEmpty, &uploader->dataMtx);
    }

    if (uploader->destruct) {
        (void)OsalCondSignal(&uploader->clearCond);
        (void)OsalMutexUnlock(&uploader->dataMtx);
        return NULL;
    }

    ProfFileChunk *chunk = uploader->dataQueue[uploader->front];
    uploader->front = (uploader->front + 1U) % uploader->capacity;
    uploader->size--;
    (void)OsalCondSignal(&uploader->notFull);
    if (uploader->size == 0) {
        (void)OsalCondSignal(&uploader->clearCond);
    }
    (void)OsalMutexUnlock(&uploader->dataMtx);
    return chunk;
}

/**
 * @brief Try to push chunk data to uploader data queue
 * @param [in] uploader : uploader pointer
 * @param [in] chunk    : chunk data
 * @return true
           false
 */
static bool TryPushUploader(UploaderAttr* uploader, ProfFileChunk *chunk)
{
    if (chunk == NULL) {
        MSPROF_LOGE("Upload data is nullptr.");
        return false;
    }

    (void)OsalMutexLock(&uploader->dataMtx);
    if (uploader->size == uploader->capacity) {
        MSPROF_LOGW("The uploader queue is full, wait util notify from front point move.");
        OsalCondWait(&uploader->notFull, &uploader->dataMtx);
    }

    if (!uploader->enable || uploader->destruct) {
        (void)OsalMutexUnlock(&uploader->dataMtx);
        MSPROF_LOGE("Uploader is not enalble, device: %u, chunk size: %" PRIu64 ".",
            uploader->deviceId, chunk->chunkSize);
        return false;
    }
    MSPROF_LOGD("Push data to uploader list, device: %hu, fileName: %s, dataSize: %" PRIu64 ".",
        chunk->deviceId, chunk->fileName, chunk->chunkSize);
    uploader->dataQueue[uploader->rear] = chunk;
    uploader->rear = (uploader->rear + 1U) % uploader->capacity;
    uploader->size++;
    (void)OsalCondSignal(&uploader->notEmpty);
    (void)OsalMutexUnlock(&uploader->dataMtx);
    return true;
}

/**
 * @brief The uploader thread handle
 * @param [in] args : uploader pointer
 */
static OsalVoidPtr UploaderThreadHandle(OsalVoidPtr args)
{
    UploaderAttr* uploader = (UploaderAttr*)args;
    // wake up StartDataUploaderThread
    (void)OsalMutexLock(&uploader->uploadMtx);
    uploader->enable = true;
    (void)OsalCondSignal(&uploader->uploadCond);
    (void)OsalMutexUnlock(&uploader->uploadMtx);
    do {
        ProfFileChunk *chunk = TryPopUploader(uploader);
        if (chunk == NULL || uploader->destruct) {
            break;
        }
        if (chunk->chunkSize == 0) {
            OSAL_MEM_FREE(chunk->chunk);
            OSAL_MEM_FREE(chunk);
            MSPROF_LOGD("Pop empty data from uploader queue, continue loop.");
            continue;
        }
        // Save data to base dir
        int32_t ret = uploader->transport->SendBuffer(chunk, uploader->baseDir);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to send buffer to file transport.");
        }
    } while (1);
    MSPROF_LOGI("Success to stop uploader thread, device: %u.", uploader->deviceId);
    // wake up DestroyDataUploader
    (void)OsalMutexLock(&uploader->uploadMtx);
    uploader->enable = false;
    (void)OsalCondSignal(&uploader->uploadCond);
    (void)OsalMutexUnlock(&uploader->uploadMtx);
    return NULL;
}

/**
 * @brief Start running uploader thread and push uploader point to uploader list
 * @param [in] uploader : uploader pointer
 * @param [in] deviceId : device id
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
static int32_t StartDataUploaderThread(UploaderAttr* uploader, uint32_t deviceId)
{
    int32_t ret = ProfThreadPoolExpand(1);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to expand thread pool.");
        return ret;
    }
    ThreadTask task = {UploaderThreadHandle, (OsalVoidPtr)uploader};
    ret = ProfThreadPoolDispatch(&task, 0);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to dispatch thread pool.");
        return ret;
    }
    // make sure UploaderThreadHandle start
    (void)OsalMutexLock(&uploader->uploadMtx);
    if (!uploader->enable && !uploader->destruct) {
        MSPROF_LOGD("Wait for uploader thread start.");
        OsalCondWait(&uploader->uploadCond, &uploader->uploadMtx);
    }
    (void)OsalMutexUnlock(&uploader->uploadMtx);
    // push to uploader list
    if (deviceId == DEFAULT_HOST_ID) {
        g_uploader.uploaderHost = uploader;
    } else {
        int32_t retCstl = CstlListPushBack(&g_uploader.uploaderList[deviceId], (uintptr_t)uploader);
        if (retCstl != CSTL_OK) {
            uploader->destruct = true; // stop uploader thread
            // wake up TryPopUploader
            (void)OsalMutexLock(&uploader->dataMtx);
            (void)OsalCondSignal(&uploader->notEmpty);
            (void)OsalMutexUnlock(&uploader->dataMtx);
            (void)OsalMutexLock(&uploader->uploadMtx);
            if (uploader->enable) {
                // make sure UploaderThreadHandle stop
                MSPROF_LOGD("Wait for uploader thread stop.");
                OsalCondWait(&uploader->uploadCond, &uploader->uploadMtx);
            }
            (void)OsalMutexUnlock(&uploader->uploadMtx);
            MSPROF_LOGE("Failed to push uploader to list.");
            return PROFILING_FAILED;
        }
    }
    return PROFILING_SUCCESS;
}

/**
 * @brief Generate and concatenate host dir with flush dir
 * @param [out] flushDir   : flush dir
 * @param [in] flushDirLen : len of flush dir space
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
static int32_t CreateProfHostSubDir(char *flushDir, uint32_t flushDirLen)
{
    errno_t ret = strcat_s(flushDir, flushDirLen, "/host");
    PROF_CHK_EXPR_ACTION(ret != EOK, return PROFILING_FAILED, "Failed to strcat_s for host dir, ret: %d.", ret);
    MSPROF_LOGI("Success to generate host dir: %s.", flushDir);
    return PROFILING_SUCCESS;
}

/**
 * @brief Generate and concatenate device dir with flush dir
 * @param [in] deviceId    : device id
 * @param [out] flushDir   : flush dir
 * @param [in] flushDirLen : len of flush dir space
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
static int32_t CreateProfDeviceSubDir(uint32_t deviceId, char *flushDir, uint32_t flushDirLen)
{
    errno_t ret = strcat_s(flushDir, flushDirLen, "/device_");
    PROF_CHK_EXPR_ACTION(ret != EOK, return PROFILING_FAILED, "Failed to strcat_s for device dir, ret: %d.", ret);

    char* devIdStr = TransferUint32ToString(deviceId);
    PROF_CHK_EXPR_ACTION(devIdStr == NULL, return PROFILING_FAILED, "Failed to transfer to char for device id.");
    ret = strcat_s(flushDir, flushDirLen, devIdStr);
    OSAL_MEM_FREE(devIdStr);
    PROF_CHK_EXPR_ACTION(ret != EOK, return PROFILING_FAILED, "Failed to strcat_s for device id, ret: %d.", ret);
    MSPROF_LOGI("Success to generate device dir: %s.", flushDir);
    return PROFILING_SUCCESS;
}

/**
 * @brief Generate and concatenate device or host dir with flush dir
 * @param [in] deviceId    : device id
 * @param [out] flushDir   : flush dir
 * @param [in] flushDirLen : len of flush dir space
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
static int32_t CreateProfSubDir(uint32_t deviceId, char *flushDir, uint32_t flushDirLen)
{
    int32_t ret = PROFILING_FAILED;
    if (deviceId == DEFAULT_HOST_ID) {
        // generate host dir
        ret = CreateProfHostSubDir(flushDir, flushDirLen);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to generate prof host dir, device: %u.", deviceId);
            return PROFILING_FAILED;
        }
    } else {
        // generate device dir
        ret = CreateProfDeviceSubDir(deviceId, flushDir, flushDirLen);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to generate prof device dir, device: %u.", deviceId);
            return PROFILING_FAILED;
        }
    }
    return PROFILING_SUCCESS;
}

/**
 * @brief Create data uploader and run uploader thread handle
 * @param [in] param    : prof params pointer
 * @param [in] type     : transport type of uploader
 * @param [in] deviceId : device id
 * @param [in] capacity : size of data queue which need to malloc
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
int32_t CreateDataUploader(ProfileParam *param, TransportType type, uint32_t deviceId, uint32_t capacity)
{
    (void)OsalMutexLock(&g_uploader.uploaderMtx);
    if (g_uploader.uploaderList == NULL) {
        (void)OsalMutexUnlock(&g_uploader.uploaderMtx);
        MSPROF_LOGE("Failed to create uploader because of nullptr uploader list, device: %u.", deviceId);
        return PROFILING_FAILED;
    }
    if (GetDataUploader(deviceId) != NULL) {
        (void)OsalMutexUnlock(&g_uploader.uploaderMtx);
        MSPROF_LOGI("Repeat create uploader, device: %u.", deviceId);
        return PROFILING_SUCCESS;
    }
    // init uploader attribute
    MSPROF_LOGI("Create uploader deviceId: %u.", deviceId);
    UploaderAttr* uploader = InitDataUploaderBasic(param, deviceId, capacity);
    if (uploader == NULL) {
        (void)OsalMutexUnlock(&g_uploader.uploaderMtx);
        return PROFILING_FAILED;
    }
    // create prof sub folder: device_* or host
    int32_t ret = CreateProfSubDir(deviceId, uploader->baseDir, DEFAULT_OUTPUT_MAX_LEGTH);
    if (ret != PROFILING_SUCCESS) {
        OSAL_MEM_FREE(uploader->dataQueue);
        OSAL_MEM_FREE(uploader->transport);
        OSAL_MEM_FREE(uploader);
        (void)OsalMutexUnlock(&g_uploader.uploaderMtx);
        return PROFILING_FAILED;
    }
    // create transport by type
    ret = CreateUploaderTransport(deviceId, type, uploader->transport, uploader->baseDir);
    if (ret != PROFILING_SUCCESS) {
        OSAL_MEM_FREE(uploader->dataQueue);
        OSAL_MEM_FREE(uploader->transport);
        OSAL_MEM_FREE(uploader);
        (void)OsalMutexUnlock(&g_uploader.uploaderMtx);
        return PROFILING_FAILED;
    }
    // start uploader thread
    ret = StartDataUploaderThread(uploader, deviceId);
    if (ret != PROFILING_SUCCESS) {
        OSAL_MEM_FREE(uploader->dataQueue);
        OSAL_MEM_FREE(uploader->transport);
        OSAL_MEM_FREE(uploader);
        (void)OsalMutexUnlock(&g_uploader.uploaderMtx);
        return PROFILING_FAILED;
    }
    (void)OsalMutexUnlock(&g_uploader.uploaderMtx);
    MSPROF_LOGI("Success to create uploader and start uploader thread, device: %u, capacity: %u.",
        deviceId, capacity);
    return PROFILING_SUCCESS;
}

/**
 * @brief Destroy data uploader and stop uploader thread handle
 * @param [in] deviceId : device id
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
void DestroyDataUploader(uint32_t deviceId)
{
    (void)OsalMutexLock(&g_uploader.uploaderMtx);
    UploaderAttr* uploader = NULL;
    if (deviceId == DEFAULT_HOST_ID) {
        uploader = g_uploader.uploaderHost;
    } else {
        uploader = GetDataUploader(deviceId);
    }
    if (uploader == NULL) {
        (void)OsalMutexUnlock(&g_uploader.uploaderMtx);
        return;
    }
    uploader->destruct = true;
    // wake up TryPopUploader
    (void)OsalMutexLock(&uploader->dataMtx);
    (void)OsalCondSignal(&uploader->notEmpty);
    (void)OsalMutexUnlock(&uploader->dataMtx);
    (void)OsalMutexLock(&uploader->uploadMtx);
    if (uploader->enable) {
        // make sure UploaderThreadHandle stop
        MSPROF_LOGD("Wait for uploader thread stop.");
        OsalCondWait(&uploader->uploadCond, &uploader->uploadMtx);
    }
    (void)OsalMutexUnlock(&uploader->uploadMtx);
    OSAL_MEM_FREE(uploader->dataQueue);
    OSAL_MEM_FREE(uploader->transport);
    MSPROF_LOGI("total_size_uploader, front point: %u, rear point: %u.", uploader->front, uploader->rear);
    (void)OsalMutexUnlock(&g_uploader.uploaderMtx);
    MSPROF_LOGI("Success to destroy uploader and stop uploader thread, deviceId: %d.",
        deviceId);
}

/**
 * @brief Compare uploader device id
 * @param [in] key1 : uploader pointer 1
 * @param [in] key2 : uploader pointer 2
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
static int32_t UploaderCmp(uintptr_t key1, uintptr_t key2)
{
    if (((UploaderAttr*)key1)->deviceId == ((UploaderAttr*)key2)->deviceId) {
        return PROFILING_SUCCESS;
    }
    return PROFILING_FAILED;
}

/**
 * @brief Get uploader pointer by device id
 * @param [in] deviceId : device id
 * @return uploader pointer
 */
UploaderAttr* GetDataUploader(uint32_t deviceId)
{
    if (g_uploader.uploaderList == NULL) {
        return NULL;
    }
    // host uploader
    if (deviceId == DEFAULT_HOST_ID) {
        return g_uploader.uploaderHost;
    }
    // out of range
    if (deviceId > g_uploader.devNum - 1U) {
        return NULL;
    }
    UploaderAttr uploader = {false, false, deviceId, 0, 0, 0, 0, {}, NULL, PTHREAD_COND_INITIALIZER,
        PTHREAD_MUTEX_INITIALIZER, PTHREAD_COND_INITIALIZER, PTHREAD_COND_INITIALIZER, PTHREAD_COND_INITIALIZER,
        PTHREAD_MUTEX_INITIALIZER, NULL};
    return (UploaderAttr*)CstlListIterData(CstlListIterFind(
        &g_uploader.uploaderList[deviceId], UploaderCmp, (uintptr_t)&uploader));
}

/**
 * @brief Get uploader and push chunk data to uploader data queue
 * @param [in] chunk : chunk data
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
int32_t UploaderUploadData(ProfFileChunk *chunk)
{
    UploaderAttr* uploader = GetDataUploader((uint32_t)chunk->deviceId);
    if (uploader == NULL) {
        MSPROF_LOGE("Failed to find data uploader for device: %hu.", chunk->deviceId);
        OSAL_MEM_FREE(chunk->chunk);
        OSAL_MEM_FREE(chunk);
        return PROFILING_FAILED;
    }

    if (!TryPushUploader(uploader, chunk)) {
        MSPROF_LOGE("Failed to push data to uploader list for device: %hu.", chunk->deviceId);
        OSAL_MEM_FREE(chunk->chunk);
        OSAL_MEM_FREE(chunk);
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

/**
 * @brief Generate time field of prof dir
 * @param [out] timeField   : time field string
 * @param [in] timeFieldLen : size of time field space
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
static int32_t CreateProfTimeField(char *timeField, size_t timeFieldLen)
{
    OsalSystemTime sysTime;
    if (OsalGetLocalTime(&sysTime) == OSAL_EN_ERROR) {
        MSPROF_LOGE("Time field get time failed.");
        return PROFILING_FAILED;
    }

    int32_t ret = snprintf_s(timeField, timeFieldLen, timeFieldLen - 1U, "%04d%02d%02d%02d%02d%02d%03d", sysTime.wYear,
        sysTime.wMonth, sysTime.wDay, sysTime.wHour, sysTime.wMinute, sysTime.wSecond, sysTime.wMilliseconds);
    if (ret == -1) {
        MSPROF_LOGE("Format time failed, timeField: %s, year: %d, month: %d, day: %d, hour: %d, minute: %d"
            "second: %d, milli second: %lld.", timeField, sysTime.wYear, sysTime.wMonth, sysTime.wDay, sysTime.wHour,
            sysTime.wMinute, sysTime.wSecond, sysTime.wMilliseconds);
        return PROFILING_FAILED;
    }

    MSPROF_LOGI("Success to get time field: %s.", timeField);
    return PROFILING_SUCCESS;
}

/**
 * @brief Generate rand field of prof dir
 * @param [out] randField   : rand field string
 * @param [in] randFieldLen : size of rand field space
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
static int32_t CreateProfRandField(char *randField, int32_t randFieldLen)
{
    static const uint64_t AZ_NUMBER = 26; // A - Z
    static char randStr[MAX_RAND_STR_LEN] = { 0 };
    (void)memset_s(randStr, MAX_RAND_STR_LEN, 0, MAX_RAND_STR_LEN);
    uint64_t timeStamp = (uint64_t)GetClockMonotonicTime();
    uint64_t timeSinceEpoch = timeStamp / AZ_NUMBER;
    int32_t ret = 0;
    ret = snprintf_s(randStr, MAX_RAND_STR_LEN, MAX_RAND_STR_LEN - 1, "%llu%llu",
        timeSinceEpoch, timeStamp);
    PROF_CHK_EXPR_ACTION(ret == -1, return PROFILING_FAILED,
        "Failed to snprintf_s randField: %s.", randField);
    // get rand hash id
    uint64_t hashId = GetBkdrHashId(randStr);
    for (int32_t i = 0; i < randFieldLen - 1; ++i) {
        randField[i] = (char)('A' + hashId % AZ_NUMBER);
        hashId /= AZ_NUMBER;
    }
    MSPROF_LOGI("Success to get rand field: %s.", randField);
    return PROFILING_SUCCESS;
}

/**
 * @brief Concatenate api index, time field string and rand field string with flush dir
 * @param [in] index      : api index
 * @param [out] flushDir  : flush dir
 * @param [out] timeField : time field string
 * @param [out] randField : rand field string
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
static int32_t CreateProfMainField(uint32_t *apiIndex, char *flushDir, const char *timeField,
    const char *randField)
{
    int32_t ret = 0;
    errno_t retVal = EOK;
    static char mainDir[DEFAULT_OUTPUT_MAX_LEGTH] = { 0 };
    (void)memset_s(mainDir, DEFAULT_OUTPUT_MAX_LEGTH, 0, DEFAULT_OUTPUT_MAX_LEGTH);
    // strcat all str for main dir
    ret = sprintf_s(mainDir, sizeof(mainDir), "%s%06u%s%s%s%08d%s",
#ifdef LITE_OS
        "PROF_", (*apiIndex + 1U), // api index count
#else
        "/PROF_", (*apiIndex + 1U), // api index count
#endif
        "_", timeField,             // time str
        "_", OsalGetPid(),          // main pid str
        randField);                 // rand hash str
    PROF_CHK_EXPR_ACTION(ret == -1, return PROFILING_FAILED, "Failed to sprintf_s main dir: %s.", mainDir);
    // strcat flush dir
    retVal = strcat_s(flushDir, DEFAULT_OUTPUT_MAX_LEGTH, mainDir);
    PROF_CHK_EXPR_ACTION(retVal != EOK, return PROFILING_FAILED, "Failed to strcat_s main dir, err: %d.", retVal);
    MSPROF_LOGI("Success to create prof main dir: %s.", flushDir);
    return PROFILING_SUCCESS;
}

/**
 * @brief Generate and concatenate prof main dir with flush dir
 * @param [in] index      : api index
 * @param [out] flushDir  : flush dir
 * @return PROFILING_SUCCESS
           PROFILING_FAILED
 */
int32_t CreateProfMainDir(uint32_t *apiIndex, CHAR *flushDir)
{
    // create time field
    static char timeField[MAX_TIME_FIELD_LEN] = { 0 };
    (void)memset_s(timeField, MAX_TIME_FIELD_LEN, 0, MAX_TIME_FIELD_LEN);
    int32_t ret = CreateProfTimeField(timeField, MAX_TIME_FIELD_LEN);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to create time field.");
        return PROFILING_FAILED;
    }
    // create rand field
    static char randField[MAX_RAND_FIELD_LEN] = { 0 };
    (void)memset_s(randField, MAX_RAND_FIELD_LEN, 0, MAX_RAND_FIELD_LEN);
    ret = CreateProfRandField(randField, MAX_RAND_FIELD_LEN);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to create rand field.");
        return PROFILING_FAILED;
    }
    // generate main dir
    ret = CreateProfMainField(apiIndex, flushDir, timeField, randField);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to create main field.");
        return PROFILING_FAILED;
    }
    // api index ++ when aclprofStart be calling
    (*apiIndex)++;
    return PROFILING_SUCCESS;
}