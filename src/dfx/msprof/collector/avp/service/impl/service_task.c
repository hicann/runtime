/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "service_task.h"
#include "errno/error_code.h"
#include "task/task_manager.h"
#include "task/task_pool.h"
#include "report/report_manager.h"
#include "platform/platform.h"
#include "transport/uploader.h"
#include "logger/logger.h"

 /**
 * @brief      initialize task manager and set attribute to attr
 * @param [out] attr: profiling attrubute
 * @return     PROFILING_FAILED  : failed
 *             PROFILING_SUCCESS : success
 */
int32_t ServiceTaskInitialize(ProfileAttribute *attr)
{
    int32_t ret;
    for (uint32_t i = 0; i < MAX_TASK_SLOT; i++) {
        ret = TaskManagerInitialize(i, &attr->taskSlotAttr[i]);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Initialize task manager for deivce %u failed, ret : %d", i, ret);
            return ret;
        }
    }

    ret = TaskPoolInitialize();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Initialize task pool failed");
        return ret;
    }

    ret = UploaderInitialize();
    if (ret != PROFILING_SUCCESS) {
        (void)TaskPoolFinalize();
        MSPROF_LOGE("Initialize uploader failed, ret : %d", ret);
        return ret;
    }

    ret = ReportManagerInitialize(&attr->reportAttr);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Initialize report manager failed");
        (void)HostReportFinalize();
        (void)TaskPoolFinalize();
        (void)UploaderFinalize();
        return ret;
    }
    return PROFILING_SUCCESS;
}

 /**
 * @brief      start task for deviceId
 * @param [in]  deviceId: device id to be started, range[0, DEFAULT_HOST_ID)
 * @param [out] attr:     profiling attrubute
 * @return     PROFILING_FAILED  : failed
 *             PROFILING_SUCCESS : success
 */
int32_t ServiceTaskStart(uint32_t deviceId, ProfileAttribute *attr)
{
    int32_t ret;
    ret = ReportManagerStartDeviceReporters(&attr->reportAttr);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Start device reporters failed, ret : %d", ret);
        return ret;
    }
    ret = TaskManagerStart(&attr->params, attr->transType, &attr->taskSlotAttr[DEFAULT_HOST_ID]);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Start task for device %u failed, ret : %d", DEFAULT_HOST_ID, ret);
        return ret;
    }
    ret = TaskManagerStart(&attr->params, attr->transType, &attr->taskSlotAttr[deviceId]);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Start task for device %u failed, ret : %d", deviceId, ret);
        return ret;
    }
    uint32_t deviceList[] = {deviceId};
    ret = ReportManagerCollectStart(deviceList, sizeof(deviceList) / sizeof(deviceList[0]),
        &attr->reportAttr, attr->params.dataTypeConfig);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Start collect for device %u failed, ret : %d", deviceId, ret);
        return ret;
    }
    return ret;
}

 /**
 * @brief      stop task for deviceId
 * @param [in]  deviceId: device id to be stopped
 * @param [out] attr:     profiling attrubute
 * @return     PROFILING_FAILED  : failed
 *             PROFILING_SUCCESS : success
 */
int32_t ServiceTaskStop(uint32_t deviceId, ProfileAttribute *attr)
{
    int32_t ret = PROFILING_SUCCESS;
    if (deviceId != DEFAULT_HOST_ID) {
        uint32_t deviceList[] = {deviceId};
        if (ReportManagerCollectStop(deviceList, sizeof(deviceList) / sizeof(deviceList[0]),
            &attr->reportAttr, attr->params.dataTypeConfig) != PROFILING_SUCCESS) {
            MSPROF_LOGE("Stop report manager collect for deivce %u failed", deviceId);
            ret = PROFILING_FAILED;
        }
    }
    if (TaskManagerStop(&attr->params, &attr->taskSlotAttr[deviceId]) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Stop task manager for device %u failed", deviceId);
        ret = PROFILING_FAILED;
    }
    if (TaskManagerFinalize(&attr->taskSlotAttr[deviceId]) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Finalize task manager failed");
        ret = PROFILING_FAILED;
    }
    return ret;
}
 
int32_t ServiceTaskFinalize(ProfileAttribute *attr)
{
    int32_t ret = PROFILING_SUCCESS;
    for (uint32_t i = 0; i < MAX_TASK_SLOT; i++) {
        if (!attr->taskSlotAttr[i].started && i != DEFAULT_HOST_ID) {
            continue;
        }
        if (ServiceTaskStop(i, attr) != PROFILING_SUCCESS) {
            MSPROF_LOGE("Stop service task for device %u failed", i);
            ret = PROFILING_FAILED;
        }
    }
    if (ReportManagerFinalize(&attr->reportAttr) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Finalize report manager failed");
        ret = PROFILING_FAILED;
    }
    HostReportFinalize();
    for (uint32_t i = 0; i < MAX_TASK_SLOT; i++) {
        UploaderFlush(attr->taskSlotAttr[i].deviceId);
        DestroyDataUploader(attr->taskSlotAttr[i].deviceId);
    }
    if (UploaderFinalize() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Finalize uploader failed");
        ret = PROFILING_FAILED;
    }
    TaskPoolFinalize();
    if (ReportManagerStopDeviceReporters(&attr->reportAttr) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Stop device reporters failed");
        ret = PROFILING_FAILED;
    }
    return ret;
}