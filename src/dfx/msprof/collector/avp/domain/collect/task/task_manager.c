/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_manager.h"
#include "errno/error_code.h"
#include "logger/logger.h"
#include "transport/uploader.h"
#include "json/info_json.h"
#include "json/sample_json.h"
#include "report/start_time.h"

int32_t TaskManagerInitialize(uint32_t deviceId, TaskSlotAttribute *attr)
{
    attr->deviceId = deviceId;
    return TaskSlotInitialize(attr);
}

 /**
 * @brief      start task slot for device and save device info to attr
 * @param [in]     params   : profiling params
 * @param [in]     transType: transport types
 * @param [in/out] attr     : task slot attr
 * @return     PROFILING_FAILED  : failed
 *             PROFILING_SUCCESS : success
 */
int32_t TaskManagerStart(ProfileParam *params, const TransportType transType, TaskSlotAttribute *attr)
{
    if (attr->started && attr->deviceId != DEFAULT_HOST_ID) {
        MSPROF_LOGE("Repeat start device %u task manager.", attr->deviceId);
        return PROFILING_FAILED;
    }
    int32_t ret = CreateDataUploader(params, transType, attr->deviceId, UPLOADER_CAPACITY);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Create uploader for device %u failed, ret : %d", attr->deviceId, ret);
        return ret;
    }
    ret = CreateCollectionTimeInfo(attr->deviceId, true);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to create start_info.");
        return PROFILING_FAILED;
    }
    ret = CreateStartTimeFile(attr->deviceId);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Create time file for device %u failed, ret : %d", attr->deviceId, ret);
        return ret;
    }
    if (attr->deviceId == DEFAULT_HOST_ID) {
        attr->launchRepeatTimes++;
        return PROFILING_SUCCESS;
    }
    ret = TaskSlotStart(params, attr);
    if (ret != PROFILING_SUCCESS) {
        UploaderFlush(attr->deviceId);
        DestroyDataUploader(attr->deviceId);
        MSPROF_LOGE("Start task slot for device %u failed, ret : %d", attr->deviceId, ret);
        return ret;
    }
    attr->launchRepeatTimes++;
    return PROFILING_SUCCESS;
}

 /**
 * @brief      stop task slot for device and save device info to attr
 * @param [in/out] attr: task slot attr
 * @return     PROFILING_FAILED  : failed
 *             PROFILING_SUCCESS : success
 */
int32_t TaskManagerStop(ProfileParam *params, TaskSlotAttribute *attr)
{
    if (attr->launchRepeatTimes == 0) {
        return PROFILING_SUCCESS;
    }
    attr->launchRepeatTimes--;
    if (attr->launchRepeatTimes != 0) {
        return PROFILING_SUCCESS;
    }
    int32_t ret = TaskSlotStop(attr);
    if (ret != PROFILING_SUCCESS) {
        UploaderFlush(attr->deviceId);
        DestroyDataUploader(attr->deviceId);
        MSPROF_LOGE("Stop task slot for device %u failed, ret : %d", attr->deviceId, ret);
        return ret;
    }
    ret = CreateInfoJson(attr->deviceId);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to create info.json.");
        return PROFILING_FAILED;
    }
    ret = CreateSampleJson(params, attr->deviceId);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to create sample.json.");
        return PROFILING_FAILED;
    }
    ret = CreateCollectionTimeInfo(attr->deviceId, false);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to create end_info.");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t TaskManagerFinalize(TaskSlotAttribute *attr)
{
    UploaderFlush(attr->deviceId);
    return TaskSlotFinalize(attr);
}