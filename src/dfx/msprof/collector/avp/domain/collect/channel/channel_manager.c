/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "channel_manager.h"
#include "inttypes.h"
#include "osal/osal.h"
#include "osal/osal_mem.h"
#include "osal/osal_thread.h"
#include "errno/error_code.h"
#include "logger/logger.h"
#include "hal/hal_prof.h"
#include "hal/hal_dsmi.h"
#include "utils/utils.h"
#include "task/task_pool.h"
#include "transport/uploader.h"
#include "transport/transport.h"
#include "platform/platform_define.h"
#include "platform/platform.h"

#define MAX_SCHEDULING_TIME 3U
#define MIN_CHANNEL_POOL_NUM 5U // 1 for channel poll and 4 for channel read

STATIC ChannelMgrAttribute g_chanMgrAttr = {false, false, PTHREAD_MUTEX_INITIALIZER, PTHREAD_COND_INITIALIZER};

/**
 * @brief Init channel poll, channel reader and channel list
 * @return Success return PROFILING_SUCCESS, failed return PROFILING_FAILED
 */
int32_t ChannelMgrInitialize(uint32_t deviceId)
{
    (void)OsalMutexLock(&g_chanMgrAttr.pollMtx);
    uint32_t channelPollNum = PlatformGetDevNum(); // get device number
    if (channelPollNum == 0) {
        (void)OsalMutexUnlock(&g_chanMgrAttr.pollMtx);
        MSPROF_LOGE("Failed to get device number.");
        return PROFILING_FAILED;
    }
    if (channelPollNum < MIN_CHANNEL_POOL_NUM) {
        channelPollNum = MIN_CHANNEL_POOL_NUM;
    }

    int32_t ret = ChannelReaderInitialize(deviceId, channelPollNum);
    if (ret != PROFILING_SUCCESS) {
        (void)OsalMutexUnlock(&g_chanMgrAttr.pollMtx);
        MSPROF_LOGE("Failed to init channel reader list for device: %u.", deviceId);
        return ret;
    }

    if (g_chanMgrAttr.enable) {
        (void)OsalMutexUnlock(&g_chanMgrAttr.pollMtx);
        MSPROF_LOGI("Repeat initialize channel poll thread.");
        return PROFILING_SUCCESS;
    }

    g_chanMgrAttr.quit = false;
    ThreadTask task = {ChannelMgrThreadHandle, &g_chanMgrAttr};
    ret = ProfThreadPoolExpand(channelPollNum);
    if (ret != PROFILING_SUCCESS) {
        (void)OsalMutexUnlock(&g_chanMgrAttr.pollMtx);
        MSPROF_LOGE("Failed to expand thread pool.");
        return ret;
    }

    ret = ProfThreadPoolDispatch(&task, 0);
    if (ret != PROFILING_SUCCESS) {
        (void)OsalMutexUnlock(&g_chanMgrAttr.pollMtx);
        MSPROF_LOGE("Failed to dispatch thread pool.");
        return ret;
    }
    // make sure channel poll thead start
    MSPROF_LOGD("Wait for channel poll thread start.");
    OsalCondWait(&g_chanMgrAttr.pollCond, &g_chanMgrAttr.pollMtx);
    MSPROF_LOGI("Success to init channel poll.");
    (void)OsalMutexUnlock(&g_chanMgrAttr.pollMtx);
    return ret;
}

/**
 * @brief Channel poll function, get channel poll ptr and dispatch
 * @param [in] args: channel poll arguments
 * @return NULL
 */
OsalVoidPtr ChannelMgrThreadHandle(OsalVoidPtr args)
{
    ChannelMgrAttribute *attr = (ChannelMgrAttribute*)args;
    // wake up ChannelMgrInitialize
    (void)OsalMutexLock(&attr->pollMtx);
    attr->enable = true;
    (void)OsalCondSignal(&attr->pollCond);
    (void)OsalMutexUnlock(&attr->pollMtx);
    ChannelPollInfo channels[MAX_CHANNEL_NUM] = {{0}};
    MSPROF_LOGI("Start run channl poll, enable: %d, quit: %d.", attr->enable, attr->quit);
    while (!attr->quit) {
        // blocking interface prof_channel_poll
        int32_t ret = HalProfChannelPoll(channels, MAX_CHANNEL_NUM, DEFAULT_CHANNEL_POLL_TIMEOUT);
        if (ret == PROF_ERROR) {
            MSPROF_LOGE("Failed to poll channel.");
            attr->quit = true;
        } else if (ret == PROF_STOPPED_ALREADY) {
            MSPROF_LOGI("Channel poll has been stopped.");
            break;
        } else if (ret == PROF_CHANNEL_POLL_UNINITIALIZE){
            MSPROF_LOGD("Channel poll is not ready.");
            (void)OsalSleep(0); // release thread cpu usage
        } else {
            ; // Channel poll get point
        }

        for (int32_t i = 0; i < ret; ++i) {
            MSPROF_LOGD("Channel poll start to dispatch, deviceId: %u, channelId: %u.",
                channels[i].device_id, channels[i].channel_id);
            ChannelMgrDispatch(channels[i].device_id, channels[i].channel_id);
        }
    }
    // wake up ChannelMgrFinalize
    (void)OsalMutexLock(&attr->pollMtx);
    attr->enable = false;
    (void)OsalCondSignal(&attr->pollCond);
    (void)OsalMutexUnlock(&attr->pollMtx);
    return NULL;
}

/**
 * @brief dispatch poll ptr from driver
 * @param [in] deviceId: device id
 * @param [in] channelId: channel id
 */
void ChannelMgrDispatch(uint32_t deviceId, uint32_t channelId)
{
    ChannelReader *channReader = GetChannelReader(deviceId, channelId);
    if (channReader == NULL) {
        return;
    }
    (void)OsalMutexLock(&channReader->readMtx);
    if (channReader->dispatchCount >= MAX_SCHEDULING_TIME || channReader->quit == 1) {
        (void)OsalMutexUnlock(&channReader->readMtx);
        return;
    }
    channReader->dispatchCount++;
    ThreadTask task = {ChannelMgChannelRead, (OsalVoidPtr)channReader};
    (void)ProfThreadPoolDispatch(&task, 1);
    (void)OsalMutexUnlock(&channReader->readMtx);
}

/**
 * @brief Update flush size of reader
 * @param [in] reader: channel reader
 * @param [in] curLen: read length of buffer
 */
STATIC void ChannelMgChanneFlushIfFinish(ChannelReader *reader, const int32_t curLen)
{
    if (reader->channelId != (uint32_t)PROF_CHANNEL_HWTS_LOG &&
        reader->channelId != (uint32_t)PROF_CHANNEL_TS_FW) {
        return;
    }

    if (reader->flushSize > 0) {
        if (curLen <= 0) {
            reader->flushSize = 0;
        } else {
            reader->flushSize = (reader->flushSize > (uint32_t)curLen) ? (reader->flushSize - (uint32_t)curLen) : 0U;
        }
    }
}

/**
 * @brief channel reader funtion, get data from driver by buffer
 * @param [in] args: channel reader arguments
 * @return NULL
 */
OsalVoidPtr ChannelMgChannelRead(OsalVoidPtr args)
{
    if (args == NULL) {
        MSPROF_LOGW("Channel read arguments is nullptr.");
        return NULL;
    }

    int32_t currLen = 0;
    int32_t totalLen = 0;
    ChannelReader *reader = (ChannelReader*)args;
    (void)OsalMutexLock(&reader->readMtx);
    do {
        if (reader->quit == 1) {
            break;
        }

        reader->spaceSize = reader->bufferSize - reader->dataSize;
        (void)OsalMutexLock(&reader->flushMtx);
        currLen = HalProfChannelRead(reader->deviceId, reader->channelId, (reader->buffer + reader->dataSize),
            reader->spaceSize);
        MSPROF_LOGD("Channel read deviceId:%u, channelId:%u, bufSize:%u, currLen:%d, spaceSize:%u.",
            reader->deviceId, reader->channelId, reader->bufferSize, currLen, reader->spaceSize);
        ChannelMgChanneFlushIfFinish(reader, currLen);
        (void)OsalMutexUnlock(&reader->flushMtx);
        if (currLen <= 0) {
            if (currLen < 0) {
                MSPROF_LOGE("Failed to read from channel.");
            }
            if (reader->dataSize >= MIN_UPLOAD_BUFFER_SIZE) {
                ChannelMgrUploadChannelData(reader);
            }
            MSPROF_LOGI("Success to read end of driver buffer.");
            break;
        }

        totalLen += currLen;
        reader->totalSize += (uint32_t)currLen;
        reader->dataSize += (uint32_t)currLen;
        if (reader->dataSize >= MAX_READER_BUFFER_SIZE) {
            ChannelMgrUploadChannelData(reader);
        }
    } while ((currLen > 0) && (totalLen < MAX_CHANNEL_READ_BUFFER_SIZE));

    reader->dispatchCount--;
    if (reader->dispatchCount == 0) {
        // wake up ChannelMgrDestroyReader
        (void)OsalCondSignal(&reader->readCond);
    }
    (void)OsalMutexUnlock(&reader->readMtx);
    return NULL;
}

/**
 * @brief uploader data from channel reader buffer
 * @param [in] reader: channel reader
 */
void ChannelMgrUploadChannelData(ChannelReader *reader)
{
    if (reader->dataSize == 0) {
        return;
    }

    ProfFileChunk *chunk = (ProfFileChunk *)OsalMalloc(sizeof(ProfFileChunk));
    if (chunk == NULL) {
        MSPROF_LOGE("Failed to malloc chunk for ChannelMgrUploadChannelData.");
        return;
    }
    chunk->chunk = reader->buffer;
    chunk->deviceId = (uint8_t)reader->deviceId;
    chunk->chunkSize = reader->dataSize;
    chunk->chunkType = PROF_DEVICE_DATA;
    chunk->isLastChunk = false;
    chunk->offset = UINT32_MAX;
    // for speed and function, do not need to check ret value
    (void)strcpy_s(chunk->fileName, sizeof(chunk->fileName), "nano_stars_profile.data");
    (void)UploaderUploadData(chunk);

    reader->dataSize = 0;
    reader->buffer = (uint8_t*)OsalMalloc(MAX_READER_BUFFER_SIZE + 1U);
    if (reader->buffer == NULL) {
        MSPROF_LOGE("Failed to malloc reader buffer, buffer size: %u.", (MAX_READER_BUFFER_SIZE + 1U));
        return;
    }
}

/**
 * @brief upload data from channel reader buffer with mutex lock
 * @param [in] reader: channel reader
 */
VOID ChannelMgrUploadOnce(ChannelReader* reader)
{
    (void)OsalMutexLock(&reader->readMtx);
    ChannelMgrUploadChannelData(reader);
    (void)OsalMutexUnlock(&reader->readMtx);
}

/**
 * @brief Add reader to reader list
 * @param [in] deviceId: device id
 * @param [in] channelId: channel id
 * @return Success return PROFILING_SUCCESS, failed return PROFILING_FAILED
 */
int32_t ChannelMgrCreateReader(uint32_t deviceId, uint32_t channelId)
{
    (void)OsalMutexLock(&g_chanMgrAttr.pollMtx);
    int32_t ret = AddChannelReader(deviceId, channelId);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGI("Failed to create channel reader, deviceId: %d, channelId: %d", deviceId, channelId);
        (void)OsalMutexUnlock(&g_chanMgrAttr.pollMtx);
        return PROFILING_FAILED;
    }
    (void)OsalMutexUnlock(&g_chanMgrAttr.pollMtx);
    MSPROF_LOGI("Success to create channel reader, deviceId: %u, channelId: %u.", deviceId, channelId);
    return PROFILING_SUCCESS;
}

/**
 * @brief Destroy reader from reader list, wait util thread clear
 * @param [in] deviceId: device id
 * @param [in] channelId: channel id
 * @return Success return PROFILING_SUCCESS, failed return PROFILING_FAILED
 */
int32_t ChannelMgrDestroyReader(uint32_t deviceId, uint32_t channelId)
{
    (void)OsalMutexLock(&g_chanMgrAttr.pollMtx);
    ChannelReader *reader = GetChannelReader(deviceId, channelId);
    if (reader == NULL) {
        (void)OsalMutexUnlock(&g_chanMgrAttr.pollMtx);
        MSPROF_LOGE("Failed to find channel reader, deviceId: %u, channelId: %u", deviceId, channelId);
        return PROFILING_FAILED;
    }
    (void)OsalMutexLock(&reader->readMtx);
    reader->quit = 1;
    if (reader->dispatchCount > 0) {
        // make sure channel reader thread clear
        MSPROF_LOGD("Wait for dispatchCount clear.");
        OsalCondWait(&reader->readCond, &reader->readMtx);
    }
    (void)OsalMutexUnlock(&reader->readMtx);
    ChannelMgrUploadOnce(reader);
    OSAL_MEM_FREE(reader->buffer);
    (void)OsalMutexUnlock(&g_chanMgrAttr.pollMtx);
    MSPROF_LOGI("Success to destroy channel reader, deviceId: %u, channelId: %u, total_size_channel: %" PRIu64 ".",
        deviceId, channelId, reader->totalSize);
    return PROFILING_SUCCESS;
}

/**
 * @brief UnInit channel poll and channel reader
 * @return Success return PROFILING_SUCCESS, failed return PROFILING_FAILED
 */
int32_t ChannelMgrFinalize(void)
{
    (void)OsalMutexLock(&g_chanMgrAttr.pollMtx);
    g_chanMgrAttr.quit = true;
    if (g_chanMgrAttr.enable) {
        MSPROF_LOGD("Wait for channel poll thread stop.");
        OsalCondWait(&g_chanMgrAttr.pollCond, &g_chanMgrAttr.pollMtx);
    }
    (void)OsalMutexUnlock(&g_chanMgrAttr.pollMtx);
    MSPROF_LOGI("Success to finalize channel poll.");
    return ChannelReaderFinalize();
}
