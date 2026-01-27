/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "hal_prof.h"
#include "logger/logger.h"
#include "errno/error_code.h"

int32_t HalProfChannelStop(uint32_t deviceId, uint32_t channelId)
{
    int32_t ret = prof_stop(deviceId, channelId);
    if (ret != PROF_OK) {
        MSPROF_LOGE("Failed to stop profiling channel[%u] of device[%u], ret=%d.",
            deviceId, channelId, ret);
        return PROFILING_FAILED;
    }
 
    MSPROF_EVENT("Succeeded to to stop profiling channel[%u] of device[%u].", channelId, deviceId);
    return PROFILING_SUCCESS;
}

int32_t HalProfChannelStart(uint32_t deviceId, uint32_t channelId, ChannelStartPara *para)
{
    int32_t ret = prof_drv_start(deviceId, channelId, para);
    if (ret != PROF_OK) {
        MSPROF_LOGE("Failed to start profiling channel[%u] of device[%u], ret=%d.",
            deviceId, channelId, ret);
        return PROFILING_FAILED;
    }

    MSPROF_EVENT("Succeeded to to start profiling channel[%u] of device[%u].", channelId, deviceId);
    return PROFILING_SUCCESS;
}

int32_t HalProfChannelPoll(ChannelPollInfo *info, uint32_t num, uint32_t timeout)
{
    int32_t ret = prof_channel_poll(info, (int32_t)num, (int32_t)timeout);
    if (ret == PROF_ERROR || ret > (int32_t)num) {
        MSPROF_LOGE("Failed to poll device channel, num=%u, timeout=%ds, ret=%d", num, timeout, ret);
        return PROF_ERROR;
    }
    return ret;
}

int32_t HalProfChannelRead(uint32_t deviceId, uint32_t channelId, uint8_t *buffer, uint32_t bufferSize)
{
    int32_t ret = prof_channel_read(deviceId, channelId, (char *)buffer, bufferSize);
    if (ret < 0) {
        if (ret == PROF_STOPPED_ALREADY) {
            MSPROF_LOGW("Prof driver channel has been stopped already, device id=%u, channel id=%u, "
                "buffer size=%dbytes", deviceId, channelId, bufferSize);
            return 0;
        }
        MSPROF_LOGE("Failed to prof_channel_read, device id=%u, channel id=%u, buffer size=%dbytes, ret=%d",
            deviceId, channelId, bufferSize, ret);
        return PROFILING_FAILED;
    }

    return ret;
}

int32_t HalProfGetChannelList(uint32_t deviceId, ChannelList *chanList)
{
    int32_t ret = prof_drv_get_channels(deviceId, chanList);
    if (ret != PROF_OK) {
        MSPROF_LOGE("DrvGetChannels get channels failed, device id=%u.", deviceId);
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}
