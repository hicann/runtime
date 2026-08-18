/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "slogd_thread_mgr.h"
#include "log_print.h"
#include "log_drv.h"

/**
 * @brief       : 创建通用线程
 * @param[in]   : comThread     struct ComThread pointer
 * @param[in]   : procFunc      function pointer
 * @return      : LOG_SUCCESS   success; LOG_FAILURE failure
 */
int32_t SlogdThreadMgrCreateCommonThread(ComThread* comThread, ToolProcFunc procFunc)
{
    ONE_ACT_ERR_LOG(
        (comThread == NULL) || (procFunc == NULL), return LOG_FAILURE, "threadManage or procFunc pointer is NULL");
    ToolThreadAttr threadAttr = {0, 0, 0, 0, 0, 1, 128 * 1024}; // Default ThreadSize(128KB), joinable
    comThread->threadInfo.procFunc = procFunc;
    int32_t ret = ToolCreateTaskWithThreadAttr(&comThread->tid, &comThread->threadInfo, &threadAttr);
    ONE_ACT_ERR_LOG(
        ret != LOG_SUCCESS, return LOG_FAILURE, "slogd create common thread failed, strerr=%s.",
        strerror(ToolGetErrorCode()));
    SELF_LOG_INFO("slogd create common thread success.");
    return LOG_SUCCESS;
}

/**
 * @brief       : 对每个 device id 创建线程
 * @param[in]   : deviceThreadArr   struct DevThread array pointer
 * @param[in]   : arrLen            deviceThreadArr array length
 * @param[out]  : devNum            number of device id
 * @param[in]   : procFunc          function pointer
 * @return      : LOG_SUCCESS       success; LOG_FAILURE failure
 */
int32_t SlogdThreadMgrCreateDeviceThread(
    DevThread* deviceThreadArr, uint32_t arrLen, uint32_t* devNum, ToolProcFunc procFunc)
{
    ONE_ACT_ERR_LOG(
        (deviceThreadArr == NULL) || (devNum == NULL) || (procFunc == NULL), return LOG_FAILURE,
        "deviceThreadArray or devNum or procFunc pointer is NULL");
    // get all device id
    uint32_t devId[MAX_DEV_NUM] = {0};
    int32_t ret = DrvGetDeviceId(devNum, devId, MAX_DEV_NUM);
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("get device id failed, result=%d, device_number=%u.", ret, *devNum);
        return LOG_FAILURE;
    }

    // create thread for all device id
    ToolThreadAttr threadAttr = {0, 0, 0, 0, 0, 1, 128 * 1024}; // Default ThreadSize(128KB), joinable
    for (uint32_t i = 0; (i < *devNum) && (i < arrLen); i++) {
        if (devId[i] < MAX_DEV_NUM) {
            deviceThreadArr[i].deviceId = devId[i];
            deviceThreadArr[i].threadInfo.procFunc = procFunc;
            deviceThreadArr[i].threadInfo.pulArg = (void*)&deviceThreadArr[i].deviceId;
            ret = ToolCreateTaskWithThreadAttr(&deviceThreadArr[i].tid, &deviceThreadArr[i].threadInfo, &threadAttr);
            ONE_ACT_ERR_LOG(
                ret != LOG_SUCCESS, return LOG_FAILURE, "slogd create thread for device %u failed, strerr=%s.",
                devId[i], strerror(ToolGetErrorCode()));
            SELF_LOG_INFO("slogd create thread for device %u success.", devId[i]);
        }
    }
    return LOG_SUCCESS;
}

/**
 * @brief       : 回收所有线程
 * @param[in]   : threadManage   struct ThreadManage pointer
 * @return      : LOG_SUCCESS   success; LOG_FAILURE failure
 */
void SlogdThreadMgrExit(ThreadManage* threadManage)
{
    ONE_ACT_ERR_LOG(threadManage == NULL, return, "threadManage pointer is NULL")
    int32_t ret = 0;
    // exit common thread
    for (int32_t i = 0; i < threadManage->comThreadNum; i++) {
        if ((threadManage->comThread != NULL) && (threadManage->comThread[i].tid != 0)) {
            ret = ToolJoinTask(&threadManage->comThread[i].tid);
            NO_ACT_ERR_LOG(ret != 0, "join common thread failed, strerr=%s.", strerror(ToolGetErrorCode()));
        }
    }

    ONE_ACT_ERR_LOG(threadManage->devThread == NULL, return, "devThread pointer is NULL.");
    // exit device thread
    for (uint32_t j = 0; j < threadManage->devNum; j++) {
        if (threadManage->devThread[j].tid != 0) {
            ret = ToolJoinTask(&threadManage->devThread[j].tid);
            NO_ACT_ERR_LOG(
                ret != 0, "join device %d thread failed, strerr=%s.", threadManage->devThread[j].deviceId,
                strerror(ToolGetErrorCode()));
        }
    }
}