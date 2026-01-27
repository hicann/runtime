/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "start_time.h"
#include "inttypes.h"
#include "logger/logger.h"
#include "errno/error_code.h"
#include "osal/osal_mem.h"
#include "transport/transport.h"
#include "transport/uploader.h"
#include "utils/utils.h"
#include "task/task_slot.h"
#include "hal/hal_dsmi.h"

TimeListCollector g_timeCount = {0, 0, 0, 0, 0};
TimeData g_timeData = { 0 };

static void CreateHostTime(void)
{
    uint64_t t1 = 0;
    uint64_t t2 = 0;
    int32_t ret = 0;
    ret = HalGetDeviceTime(0, &t1);
    PROF_CHK_EXPR_NO_ACTION(ret != PROFILING_SUCCESS, "Failed to get time data from device.");
    int64_t monoTime = GetClockMonotonicTime();
    PROF_CHK_EXPR_ACTION(monoTime < 0, monoTime = 0, "Received an invalid monotonic time %" PRId64 ".", monoTime);
    g_timeCount.hostMonotonicStart = (uint64_t)monoTime;
    ret = HalGetDeviceTime(0, &t2);
    PROF_CHK_EXPR_NO_ACTION(ret != PROFILING_SUCCESS, "Failed to get time data from device.");
    g_timeCount.hostCntvctStart = (t2 + t1) >> 1U;
}

static void CreateHostAndDeviceTime(uint32_t devIndexId)
{
    uint64_t deviceCntvct = 0;
    uint64_t t1 = 0;
    uint64_t t2 = 0;
    uint64_t t3 = 0;
    uint64_t t4 = 0;
    int32_t ret = 0;
    // Warn up 5 times to reduce the impact of HDC interaction time
    for (int32_t i = 0; i < ITER_TIME_COUNT; i++) {
        ret = HalGetDeviceTime(devIndexId, &deviceCntvct);
    }

    uint64_t minDelta = 0;
    for (int32_t i = 0; i < ITER_TIME_COUNT; i++) {
        ret = HalGetDeviceTime(devIndexId, &t1);
        PROF_CHK_EXPR_NO_ACTION(ret != PROFILING_SUCCESS, "Failed to get time data from device.");
        int64_t mT1 = GetClockMonotonicTime();
        ret = HalGetDeviceTime(devIndexId, &t2);
        PROF_CHK_EXPR_NO_ACTION(ret != PROFILING_SUCCESS, "Failed to get time data from device.");
        ret = HalGetDeviceTime(devIndexId, &deviceCntvct);
        PROF_CHK_EXPR_NO_ACTION(ret != PROFILING_SUCCESS, "Failed to get time data from device.");
        ret = HalGetDeviceTime(devIndexId, &t3);
        PROF_CHK_EXPR_NO_ACTION(ret != PROFILING_SUCCESS, "Failed to get time data from device.");
        int64_t mT2 = GetClockMonotonicTime();
        ret = HalGetDeviceTime(devIndexId, &t4);
        PROF_CHK_EXPR_NO_ACTION(ret != PROFILING_SUCCESS, "Failed to get time data from device.");

        PROF_CHK_EXPR_ACTION_NODO(t3 < t2, continue, "The obtained time is abnormal.");
        // Filter out the minimum time difference for obtaining device time from 5 times,
        // indicating that the interaction time between host and device has the least impact
        if ((t3 - t2) < minDelta || minDelta == 0) {
            minDelta = t3 - t2;
            PROF_CHK_EXPR_ACTION_NODO(mT1 < 0 || mT2 < 0, continue, "The monotonic time is abnormal, mT1 is %" PRIu64
            " mT2 is %" PRIu64 ".", mT1, mT2);
            g_timeCount.hostMonotonicStart = (uint64_t)(mT2 + mT1) >> 1U;
            g_timeCount.hostCntvctStart = (((t1 + t2) >> 1U) + ((t3 + t4) >> 1U)) >> 1U;
            g_timeCount.devCntvct = deviceCntvct;
        }
    }
}

static void ConcatenateTime(char* buffer, size_t bufferSize, const char* key, uint64_t time)
{
    char* timeStr = TransferUint64ToString(time);
    PROF_CHK_EXPR_ACTION(timeStr == NULL, return, "Failed to transfer time into string, time is %" PRIu64 ".", time);
    errno_t ret = strcat_s(buffer, bufferSize, key);
    PROF_CHK_EXPR_ACTION(ret != EOK, break, "Failed to strcat_s %s to time buffer, ret is %d.", timeStr, ret);
    ret = strcat_s(buffer, bufferSize, ": ");
    PROF_CHK_EXPR_ACTION(ret != EOK, break, "Failed to strcat_s : to time buffer, ret is %d.", ret);
    ret = strcat_s(buffer, bufferSize, timeStr);
    OSAL_MEM_FREE(timeStr);
    PROF_CHK_EXPR_ACTION(ret != EOK, break, "Failed to strcat_s %" PRIu64 " to time buffer, ret is %d.", time, ret);
    ret = strcat_s(buffer, bufferSize, "\n");
    PROF_CHK_EXPR_ACTION(ret != EOK, break, "Failed to strcat_s enter key to time buffer, ret is %d.", ret);
}

static void GenDevStartTime(void)
{
    size_t capacity = sizeof(g_timeData.deviceData);
    ConcatenateTime(g_timeData.deviceData, capacity, "clock_monotonic_raw", g_timeCount.devMonotonic);
    ConcatenateTime(g_timeData.deviceData, capacity, "cntvct", g_timeCount.devCntvct);
}

static void GenHostStartTime(uint32_t deviceId)
{
    size_t capacity = sizeof(g_timeData.hostData);
    errno_t ret = 0;
    if (deviceId == DEFAULT_HOST_ID) {
        ret = strcat_s(g_timeData.hostData, sizeof(g_timeData.hostData), "[host]\n");
        PROF_CHK_EXPR_ACTION(ret != EOK, break, "Failed to strcat_s title to time buffer, ret is %d.", ret);
    } else {
        ret = strcat_s(g_timeData.hostData, capacity, "[Device");
        PROF_CHK_EXPR_ACTION(ret != EOK, break, "Failed to strcat_s title to time buffer, ret is %d.", ret);
        char* deviceIdStr = TransferUint32ToString(deviceId);
        PROF_CHK_EXPR_ACTION(deviceIdStr == NULL, return, "Failed to transfer device id into string, ret is %d.", ret);
        ret = strcat_s(g_timeData.hostData, capacity, deviceIdStr);
        OSAL_MEM_FREE(deviceIdStr);
        PROF_CHK_EXPR_ACTION(ret != EOK, break, "Failed to strcat_s device id %u to time buffer, ret is %d.",
            deviceId, ret);
        ret = strcat_s(g_timeData.hostData, capacity, "]\n");
        PROF_CHK_EXPR_ACTION(ret != EOK, break, "Failed to strcat_s symbols to time buffer, ret is %d.", ret);
    }
    ConcatenateTime(g_timeData.hostData, capacity, "clock_monotonic_raw", g_timeCount.hostMonotonicStart);
    ConcatenateTime(g_timeData.hostData, capacity, "cntvct", g_timeCount.hostCntvctStart);
    ConcatenateTime(g_timeData.hostData, capacity, "cntvct_diff", g_timeCount.hostCntvctDiff);
}

/**
 * @brief      dump time data. send chunk to UploaderUploadData
 * @return     success: PROFILING_SUCCESS
 *             failed : PROFILING_FAILED
 */
static int32_t UploadTimeData(uint32_t deviceId, char* timeData, const char* fileName)
{
    if (timeData == NULL || strlen(timeData) == 0 || deviceId > DEFAULT_HOST_ID) {
        MSPROF_LOGE("Receive an unexpected value of timeData, pleace check the context log.");
        return PROFILING_FAILED;
    }
    ProfFileChunk* chunk = (ProfFileChunk*)OsalMalloc(sizeof(ProfFileChunk));
    if (chunk == NULL) {
        MSPROF_LOGE("Failed to malloc chunk for UploadTimeData.");
        return PROFILING_FAILED;
    }
    chunk->deviceId = (uint8_t)deviceId;
    chunk->chunkSize = strlen(timeData);
    chunk->chunkType = PROF_CTRL_DATA;
    chunk->isLastChunk = false;
    chunk->offset = -1;
    errno_t result = strcpy_s(chunk->fileName, sizeof(chunk->fileName), fileName);
    PROF_CHK_EXPR_ACTION(result != EOK, break, "strcpy_s name %s to chunk failed.", fileName);

    chunk->chunk = (uint8_t*)OsalMalloc(strlen(timeData) + 1);
    PROF_CHK_EXPR_ACTION_TWICE(chunk->chunk == NULL, OSAL_MEM_FREE(chunk), return PROFILING_FAILED,
        "malloc chunk data failed.");
    result = memcpy_s(chunk->chunk, strlen(timeData) + 1, timeData, strlen(timeData));
    if (result != EOK) {
        OSAL_MEM_FREE(chunk->chunk);
        OSAL_MEM_FREE(chunk);
        MSPROF_LOGE("An error occurred while doing chunk memcpy.");
        return PROFILING_FAILED;
    }

    (void)memset_s(timeData, strlen(timeData), 0, strlen(timeData));
    int32_t ret = UploaderUploadData(chunk);
    PROF_CHK_EXPR_ACTION(ret != PROFILING_SUCCESS, return PROFILING_FAILED, "Failed to upload times data.");
    return PROFILING_SUCCESS;
}

/**
 * @brief      Create dev_start.log and host_start.log
 * @return     success: PROFILING_SUCCESS
 *             failed : PROFILING_FAILED
 */
int32_t CreateStartTimeFile(uint32_t deviceId)
{
    int32_t result = 0;
    if (deviceId == DEFAULT_HOST_ID) {
        CreateHostTime();
    } else {
        CreateHostAndDeviceTime(deviceId);
        MSPROF_LOGI("devId: %u, hostMonotonicStart=%" PRIu64 " ns, hostCntvctStart=%" PRIu64 " ns, hostCntvctDiff=%"
            PRIu64 ", devCntvct=%" PRIu64 " cycle", deviceId, g_timeCount.hostMonotonicStart,
            g_timeCount.hostCntvctStart, g_timeCount.hostCntvctDiff, g_timeCount.devCntvct);
        GenDevStartTime();
        result = UploadTimeData(deviceId, g_timeData.deviceData, "dev_start.log");
        if (result != PROFILING_SUCCESS) {
            MSPROF_LOGE("[DeviceJob]Failed to upload data for device");
            return PROFILING_FAILED;
        }
    }
    GenHostStartTime(deviceId);
    result = UploadTimeData(deviceId, g_timeData.hostData, "host_start.log");
    if (result != PROFILING_SUCCESS) {
        MSPROF_LOGE("[DeviceJob]Failed to upload data for host");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}