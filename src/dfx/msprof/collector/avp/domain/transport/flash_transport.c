/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "flash_transport.h"
#include "inttypes.h"
#include "logger/logger.h"
#include "osal/osal_mem.h"
#include "utils/utils.h"
#ifdef LITE_OS
#include "file_if.h"
#endif

static IndexAttribute g_index = {0, 0};

static void UpdateFileIndex(uint16_t *fileIndex, uint64_t dataSize, char *absolutePath, size_t absolutePathLen)
{
#ifdef LITE_OS
    file_t* file = file_open(absolutePath, "rb");
    PROF_CHK_EXPR_ACTION(file == NULL, return, "Failed to open file %s in flash.", absolutePath);

    int32_t ret = file_seek(file, 0, SEEK_FILE_END);
    PROF_CHK_EXPR_ACTION_TWICE(ret != 0, (void)file_close(file), return,
        "Failed to seek file %s end in flash.", absolutePath);

    int32_t fileSize = file_tell(file);
    PROF_CHK_EXPR_ACTION_TWICE(fileSize < 0, (void)file_close(file), return,
        "Failed to tell file %s in flash.", absolutePath);

    ret = file_seek(file, 0, SEEK_FILE_BEGIN);
    PROF_CHK_EXPR_ACTION_TWICE(ret != 0, (void)file_close(file), return,
        "Failed to seek file %s begin in flash.", absolutePath);

    ret = file_close(file);
    PROF_CHK_EXPR_NO_ACTION(ret != 0, "Failed to close flash file: %s.", absolutePath);
    // change slice key
    if ((uint64_t)fileSize + dataSize >= MAX_DATA_FLASH_SIZE) {
        (*fileIndex)++;
        PROF_CHK_EXPR_ACTION((*fileIndex) > MAX_INDEX_NUMBER, return, "Failed to change slice key: %u.", *fileIndex);
        char indexStr[MAX_INDEX_LENGTH] = { 0 };
        ret = snprintf_s(indexStr, MAX_INDEX_LENGTH, MAX_INDEX_LENGTH - 1, "%u", *fileIndex);
        PROF_CHK_EXPR_ACTION(ret == -1, return, "Failed to change slice key: %u, path: %s.",
            *fileIndex, absolutePath);
        errno_t retv = strcpy_s(absolutePath + (absolutePathLen - strlen(indexStr)), MAX_OUTPUT_FILE_LEGTH, indexStr);
        PROF_CHK_EXPR_ACTION(retv != EOK, return, "Failed to change slice key: %s, path: %s, ret: %d.",
            indexStr, absolutePath, retv);
        MSPROF_LOGI("Success to change slice key: %s, path: %s.", indexStr, absolutePath);
    }
#else
    (void)fileIndex;
    (void)dataSize;
    (void)absolutePath;
    (void)absolutePathLen;
#endif
}

static int32_t UpdateChunkName(ProfFileChunk *chunk, char *absolutePath, size_t absolutePathLen,
    const char *flushDir)
{
    int32_t ret;
    // combine file name and device id
    if (chunk->deviceId != DEFAULT_HOST_ID && strcmp(chunk->fileName, "sample.json") != 0) {
        ret = snprintf_s(chunk->fileName, MAX_FILE_CHUNK_NAME_LENGTH, MAX_FILE_CHUNK_NAME_LENGTH - 1U, "%s%s%u",
            chunk->fileName, ".", chunk->deviceId);
        PROF_CHK_EXPR_ACTION(ret == -1, return PROFILING_FAILED,
            "Failed to snprintf_s device id, fileName: %s, baseDir: %s.", chunk->fileName, flushDir);
    }
    // combine dir with data or not
    if (chunk->chunkType == (uint16_t)PROF_DEVICE_DATA) {
        ret = snprintf_s(absolutePath, absolutePathLen, absolutePathLen - 1U, "%s%s%s%s%u",
            flushDir, "/data/", chunk->fileName, ".slice_", g_index.devIdx);
        PROF_CHK_EXPR_ACTION(ret == -1, return PROFILING_FAILED,
            "Failed to snprintf_s absolutePath, fileName: %s, baseDir: %s.", chunk->fileName, flushDir);
        // if first time, device file not exist
        if (g_index.devFile == 0U) {
            g_index.devFile = 1U;
        } else {
            // only update file index of device data
            UpdateFileIndex(&g_index.devIdx, chunk->chunkSize, absolutePath, strlen(absolutePath));
        }
    } else if (chunk->chunkType == (uint16_t)PROF_HOST_DATA) {
        ret = snprintf_s(absolutePath, absolutePathLen, absolutePathLen - 1U, "%s%s%s%s",
            flushDir, "/data/", chunk->fileName, ".slice_0");
        PROF_CHK_EXPR_ACTION(ret == -1, return PROFILING_FAILED,
            "Failed to snprintf_s absolutePath, fileName: %s, baseDir: %s.", chunk->fileName, flushDir);
    } else {
        ret = snprintf_s(absolutePath, absolutePathLen, absolutePathLen - 1U, "%s%s%s",
            flushDir, "/", chunk->fileName);
        PROF_CHK_EXPR_ACTION(ret == -1, return PROFILING_FAILED,
            "Failed to snprintf_s absolutePath, fileName: %s, baseDir: %s.", chunk->fileName, flushDir);
    }
    return PROFILING_SUCCESS;
}

static void SaveChunkToFlash(uint16_t chunkType, const char *absolutePath, const uint8_t* data, uint64_t dataSize)
{
#ifdef LITE_OS
    size_t flashSize = (chunkType == PROF_CTRL_DATA) ? MAX_CTRL_FLASH_SIZE : MAX_DATA_FLASH_SIZE;
    PROF_CHK_WARN_NO_ACTION(file_create(absolutePath, flashSize) != 0,
        "Unable to create file %s in flash.", absolutePath);

    file_t* file = file_open(absolutePath, "a");
    if (file == NULL) {
        MSPROF_LOGE("Failed to open file %s in flash.", absolutePath);
        return;
    }

    if (file_write((void*)data, sizeof(uint8_t), (size_t)dataSize, file) != dataSize) {
        MSPROF_LOGE("Failed to write data to flash: %s, size: %" PRIu64 ".", absolutePath, dataSize);
    }

    if (file_close(file) != 0) {
        MSPROF_LOGE("Failed to close flash file: %s.", absolutePath);
    }
#else
    (void)chunkType;
    (void)absolutePath;
    (void)data;
    (void)dataSize;
#endif
}

int32_t FlashInitTransport(Transport* transport)
{
    if (transport == NULL) {
        MSPROF_LOGE("Failed to init flash transport because transport is nullptr.");
        return PROFILING_FAILED;
    }
    g_index.devIdx = 0;
    g_index.devFile = 0;
    transport->SendBuffer = FlashSendBuffer;
    MSPROF_LOGI("Success to init flash transport.");
    return PROFILING_SUCCESS;
}

int32_t FlashSendBuffer(ProfFileChunk *chunk, const char *dir)
{
    char absolutePath[MAX_OUTPUT_FILE_LEGTH] = { 0 };
    int32_t ret = UpdateChunkName(chunk, absolutePath, MAX_OUTPUT_FILE_LEGTH, dir);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to SendDataBuffer, fileName: %s, baseDir: %s", chunk->fileName, dir);
        OSAL_MEM_FREE(chunk->chunk);
        OSAL_MEM_FREE(chunk);
        return PROFILING_FAILED;
    }
    SaveChunkToFlash(chunk->chunkType, absolutePath, chunk->chunk, chunk->chunkSize);
    MSPROF_LOGI("End to SendDataBuffer, fileName: %s, absolutePath: %s", chunk->fileName, absolutePath);
    OSAL_MEM_FREE(chunk->chunk);
    OSAL_MEM_FREE(chunk);
    return PROFILING_SUCCESS;
}