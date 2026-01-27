/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "channel_reader.h"
#include "errno/error_code.h"
#include "cstl/cstl_list.h"
#include "osal/osal_mem.h"
#include "osal/osal_thread.h"
#include "hal/hal_prof.h"
#include "utils/utils.h"
#include "logger/logger.h"
#include "platform/platform.h"
#include "platform/platform_define.h"

typedef struct {
    uint32_t devNum;
    CstlList *readList;
    ChannelList *chanList;
} ChannelReaderAttribue;

ChannelReaderAttribue g_readerAttr = {MAX_DEVICE_NUM, NULL, NULL};

/**
 * @brief Init reader list and channel list
 * @return Success return PROFILING_SUCCESS, failed return PROFILING_FAILED
 */
int32_t ChannelReaderInitialize(uint32_t deviceId, uint32_t deviceNum)
{
    if (g_readerAttr.readList == NULL) {
        g_readerAttr.devNum = deviceNum;
        g_readerAttr.readList = (CstlList *)OsalCalloc(sizeof(CstlList) * g_readerAttr.devNum);
        if (g_readerAttr.readList == NULL) {
            MSPROF_LOGE("Failed to calloc for read list.");
            return PROFILING_FAILED;
        }

        g_readerAttr.chanList = (ChannelList *)OsalCalloc(sizeof(ChannelList) * g_readerAttr.devNum);
        if (g_readerAttr.chanList == NULL) {
            OSAL_MEM_FREE(g_readerAttr.readList);
            MSPROF_LOGE("Failed to calloc for channel list.");
            return PROFILING_FAILED;
        }
    }

    int32_t ret = CSTL_ERR;
    ret = CstlListInit(&g_readerAttr.readList[deviceId], OsalFree);
    if (ret != CSTL_OK) {
        MSPROF_LOGE("Failed to init cstl list for reader of device: %u.", deviceId);
        return PROFILING_FAILED;
    }

    ret = HalProfGetChannelList(deviceId, &g_readerAttr.chanList[deviceId]);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to get channel list for device: %u.", deviceId);
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("Success to init channel read and channel list for device: %u.", deviceId);
    return PROFILING_SUCCESS;
}

/**
 * @brief Compare arguments of two reader
 * @param [in] key1: channel reader ptr
 * @param [in] key2: channel reader ptr
 * @return Success return PROFILING_SUCCESS, failed return PROFILING_FAILED
 */
STATIC int32_t ChannelReaderChannelCmp(uintptr_t key1, uintptr_t key2)
{
    if (((ChannelReader *)key1)->deviceId == ((ChannelReader *)key2)->deviceId &&
        ((ChannelReader *)key1)->channelId == ((ChannelReader *)key2)->channelId) {
        return PROFILING_SUCCESS;
    }
    return PROFILING_FAILED;
}

/**
 * @brief Get channel reader by device id and channel id
 * @param [in] deviceId: device id
 * @param [in] channelId: channel id
 * @return Success return channel reader ptr, failed return NULL
 */
ChannelReader* GetChannelReader(uint32_t deviceId, uint32_t channelId)
{
    if (g_readerAttr.readList == NULL || g_readerAttr.devNum - 1U < deviceId) {
        return NULL;
    }
    ChannelReader reader = {0, deviceId, channelId, 0, NULL, 0, 0, 0, 0, 0,
        PTHREAD_MUTEX_INITIALIZER, PTHREAD_MUTEX_INITIALIZER, PTHREAD_COND_INITIALIZER};
    return (ChannelReader*)CstlListIterData(CstlListIterFind(
        &g_readerAttr.readList[deviceId], ChannelReaderChannelCmp, (uintptr_t)&reader));
}

/**
 * @brief Add channel reader to reader list
 * @param [in] deviceId: device id
 * @param [in] channelId: channel id
 * @return Success return PROFILING_SUCCESS, failed return PROFILING_FAILED
 */
int32_t AddChannelReader(uint32_t deviceId, uint32_t channelId)
{
    if (g_readerAttr.readList == NULL || g_readerAttr.devNum - 1U < deviceId) {
        return PROFILING_FAILED;
    }

    ChannelReader* reader = (ChannelReader*)OsalCalloc(sizeof(ChannelReader));
    if (reader == NULL) {
        MSPROF_LOGE("Failed to calloc for reader.");
        return PROFILING_FAILED;
    }
    reader->deviceId = deviceId;
    reader->channelId = channelId;
    reader->spaceSize = MAX_READER_BUFFER_SIZE;
    reader->bufferSize = MAX_READER_BUFFER_SIZE;
    reader->buffer = (uint8_t*)OsalMalloc(MAX_READER_BUFFER_SIZE + 1U); // '/0'
    if (reader->buffer == NULL) {
        MSPROF_LOGE("Failed to malloc reader buffer of channel reader.");
        OSAL_MEM_FREE(reader);
        return PROFILING_FAILED;
    }
    if (OsalMutexInit(&reader->readMtx) != 0 || OsalMutexInit(&reader->flushMtx) != 0) {
        MSPROF_LOGE("Failed to init mutex of channel reader.");
        OSAL_MEM_FREE(reader->buffer);
        OSAL_MEM_FREE(reader);
        return PROFILING_FAILED;
    }
    int32_t ret = CstlListPushBack(&g_readerAttr.readList[deviceId], (uintptr_t)reader);
    if (ret != CSTL_OK) {
        MSPROF_LOGE("Failed to push channel reader to list.");
        OSAL_MEM_FREE(reader->buffer);
        OSAL_MEM_FREE(reader);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

/**
 * @brief Get channel num of channel list
 * @param [in] deviceId: device id
 * @return Success return channel num, failed return 0
 */
uint32_t GetChannelNum(uint32_t deviceId)
{
    if (g_readerAttr.chanList == NULL || g_readerAttr.devNum - 1U < deviceId) {
        return 0;
    }
 
    return g_readerAttr.chanList[deviceId].channel_num;
}

/**
 * @brief Get channel num of channel list
 * @param [in] deviceId: device id
 * @param [in] index: channel index
 * @return channel id
 */
uint32_t GetChannelIdByIndex(uint32_t deviceId, uint32_t channelIndex)
{
    if (g_readerAttr.chanList == NULL || g_readerAttr.devNum - 1U < deviceId) {
        return 0;
    }

    return g_readerAttr.chanList[deviceId].channel[channelIndex].channel_id;
}

/**
 * @brief UnInit reader list and channel list
 * @return Success return PROFILING_SUCCESS, failed return PROFILING_FAILED
 */
int32_t ChannelReaderFinalize(void)
{
    if (g_readerAttr.readList == NULL) {
        MSPROF_LOGI("Channel read and channel list is already finalize.");
        return PROFILING_SUCCESS;
    }

    for (uint32_t i = 0; i < g_readerAttr.devNum; ++i) {
        (void)CstlListDeinit(&g_readerAttr.readList[i]);
    }
    OSAL_MEM_FREE(g_readerAttr.readList);
    OSAL_MEM_FREE(g_readerAttr.chanList);
    MSPROF_LOGI("Success to finalize channel read and channel list.");
    return PROFILING_SUCCESS;
}