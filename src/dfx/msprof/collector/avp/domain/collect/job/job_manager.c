/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "job_manager.h"
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <stdio.h>
#include "channel/channel_manager.h"
#include "errno/error_code.h"
#include "nano_stars_job.h"
#include "collection_job.h"
#include "hal/hal_prof.h"
#include "ascend_hal.h"
#include "logger/logger.h"
#include "securec.h"
#include "utils/utils.h"
#include "osal/osal_mem.h"
#include "param/profile_param.h"

static int32_t DrvGetChannels(uint32_t devId, bool *channels)
{
    channel_list_t *channelList = (channel_list_t *)OsalCalloc(sizeof(channel_list_t));
    PROF_CHK_EXPR_ACTION(channelList == NULL, return PROFILING_FAILED, "ChannelList calloc failed.");
    int32_t ret = HalProfGetChannelList(devId, channelList);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("DrvGetChannels get channels failed, deviceId=%u, ret=%d", devId, ret);
        OSAL_MEM_FREE(channelList);
        return PROFILING_FAILED;
    }
    for (uint32_t i = 0; i < channelList->channel_num; i++) {
        if (channelList->channel[i].channel_id == 0 ||
            channelList->channel[i].channel_id >= (uint32_t)PROF_CHANNEL_MAX) {
            MSPROF_LOGE("Channel id is invalid, channelId=%u, i=%u", channelList->channel[i].channel_id, i);
            continue;
        }
        channels[channelList->channel[i].channel_id] = true;
    }
    OSAL_MEM_FREE(channelList);
    return PROFILING_SUCCESS;
}

static int32_t DeviceJobInit(JobManagerAttribute *attr)
{
    MSPROF_LOGI("Device job init");
    for (uint32_t i = 0; i < (uint32_t)PROF_CHANNEL_MAX; i++) {
        attr->collectionJobs[i] = NULL;
    }
    bool *channels = (bool*)OsalCalloc(sizeof(bool) * (size_t)PROF_CHANNEL_MAX);
    PROF_CHK_EXPR_ACTION(channels == NULL, return PROFILING_FAILED, "Channels calloc failed.");
    if (DrvGetChannels(attr->deviceId, channels) != PROFILING_SUCCESS) {
        OSAL_MEM_FREE(channels);
        return PROFILING_FAILED;
    }
    for (uint32_t channelId = 0; channelId < (uint32_t)PROF_CHANNEL_MAX; channelId++) {
        if (channels[channelId] == false) {
            continue;
        }
        ICollectionJob* job = FactoryCreateJob(channelId);
        if (job == NULL) {
            continue;
        }
        job->params = attr->params;
        job->devId = attr->deviceId;
        job->jobId = attr->params->config.jobId;
        int32_t ret = job->Init(job);
        if (ret == PROFILING_SUCCESS) {
            MSPROF_LOGI("Create device[%u] channel[%u] success", attr->deviceId, channelId);
            attr->collectionJobs[channelId] = job;
        } else {
            MSPROF_LOGW("Device[%u] channel[%u] is not enable.", attr->deviceId, channelId);
            OsalFree(job);
        }
    }
    OSAL_MEM_FREE(channels);
    return PROFILING_SUCCESS;
}

static void DeviceJobStart(JobManagerAttribute *attr)
{
    for (uint32_t i = 0; i < (uint32_t)PROF_CHANNEL_MAX; i++) {
        if (attr->collectionJobs[i] == NULL) {
            continue;
        }
        ICollectionJob* job = attr->collectionJobs[i];
        job->Process(job);
    }
}

static void DeviceJobStop(JobManagerAttribute *attr)
{
    for (uint32_t i = 0; i < (uint32_t)PROF_CHANNEL_MAX; i++) {
        if (attr->collectionJobs[i] == NULL) {
            continue;
        }
        ICollectionJob* job = attr->collectionJobs[i];
        job->Uninit(job);
        OsalFree(job);
    }
}

int32_t JobManagerStart(JobManagerAttribute *attr)
{
    if (attr->isStart || attr->params == NULL) {
        MSPROF_LOGE("JobManager start flag is true or params is invalid.");
        return PROFILING_FAILED;
    }
    if (attr->params->hostProfiling) {
        MSPROF_LOGI("Device job is not support.");
        attr->isStart = true;
        return PROFILING_SUCCESS;
    }
    MSPROF_LOGI("Devicd[%u] job start profiling begin.", attr->deviceId);
    int32_t ret = DeviceJobInit(attr);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Devide job init failed.");
        return ret;
    }
    if (!attr->params->hostProfiling) {
        ret = ChannelMgrInitialize(attr->deviceId);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to init channel poll.");
            DeviceJobStop(attr);
            (void)ChannelMgrFinalize();
            return ret;
        }
    }
    attr->isStart = true;
    DeviceJobStart(attr);
    MSPROF_LOGI("Device job start profiling end.");
    return ret;
}

int32_t JobManagerStop(JobManagerAttribute *attr)
{
    if (!attr->isStart) {
        MSPROF_LOGW("Device job is not started.");
        return PROFILING_FAILED;
    }

    MSPROF_LOGI("Device job stop profiling begin.");
    DeviceJobStop(attr);
    MSPROF_LOGI("Device job stop profiling end.");
    if (!attr->params->hostProfiling) {
        (void)ChannelMgrFinalize();
    }
    MSPROF_LOGI("Device job channel finish.");
    attr->isStart = false;
    return PROFILING_SUCCESS;
}
