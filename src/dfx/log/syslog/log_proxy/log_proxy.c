/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_proxy.h"
#include <errno.h>
#include "high_mem.h"
#include "string.h"
#include "log_print.h"
#include "log_iam_pub.h"

#define DLOG_IAM_RES_FILE_NUM   1
#define DLOG_IAM_RES_TIMEOUT    (-1)
STATIC RingBufferStat *g_logProxBuf;
STATIC int32_t g_iamFd = INVALID;
STATIC enum IAMResourceStatus g_iamResStatus = IAM_RESOURCE_WAITING;

STATIC LogStatus LogProxyIamOpenServiceFd(int32_t *fd)
{
    if (*fd != INVALID) {
        (void)close(*fd);
        *fd = INVALID;
    }
    int32_t retry = 0;
    while ((*fd == INVALID) && (retry < IAM_RETRY_TIMES)) {
        *fd = open(LOGOUT_IAM_SERVICE_PATH, O_RDWR);
        retry++;
    }
    return (*fd == INVALID) ? LOG_FAILURE : LOG_SUCCESS;
}

STATIC bool LogProxyIamResStatusIsChange(struct IAMVirtualResourceStatus *resList, int32_t listNum)
{
    for (int32_t i = 0; i < listNum; i++) {
        if (strcmp(LOGOUT_IAM_SERVICE_PATH, resList[i].IAMResName) == 0) {
            if (g_iamResStatus != resList[i].status) {
                g_iamResStatus = resList[i].status;
                SELF_LOG_INFO("iam resource status update finished, status = %d, pid = %d.",
                              (int32_t)g_iamResStatus, (int32_t)getpid());
                return true;
            } else {
                return false;
            }
        }
    }
    return false;
}

/**
 * @brief           : iam resource call back function, when status is ready, open iam service
 * @param[in]       : resList       resource list with status
 * @param[in]       : listNum       resource list number
 */
STATIC void LogProxyIamResStatusCb(struct IAMVirtualResourceStatus *resList, const int32_t listNum)
{
    ONE_ACT_ERR_LOG((resList == NULL) || (listNum <= 0), return,
                    "iam resource status cb input null, pid = %d.", (int32_t)getpid());
    if (LogProxyIamResStatusIsChange(resList, listNum)) {
        if (g_iamResStatus == IAM_RESOURCE_READY) {
            if (LogProxyIamOpenServiceFd(&g_iamFd) == LOG_SUCCESS) {
                SELF_LOG_INFO("log_proxy open iam service success, pid = %d.", (int32_t)getpid());
            } else {
                SELF_LOG_ERROR("log_proxy open iam service failed, pid = %d, errno = %d.",
                               (int32_t)getpid(), errno);
            }
        } else {
            SELF_LOG_INFO("fd is invalid, g_iamResStatus = %d, pid = %d.", (int32_t)g_iamResStatus, (int32_t)getpid());
            (void)close(g_iamFd);
            g_iamFd = INVALID;
        }
    }
}

STATIC LogStatus InitIam(void)
{
    ONE_ACT_INFO_LOG(g_iamFd >= 0, return SYS_OK, "iam service is already open.");
    ONE_ACT_ERR_LOG(IAMResMgrReady() != SYS_OK, return LOG_FAILURE, "iam service not ready.");
    struct IAMVirtualResourceStatus virtualResStatus = { LOGOUT_IAM_SERVICE_PATH, IAM_RESOURCE_WAITING };
    struct IAMResourceSubscribeConfig iamResSubConfig = {
        &virtualResStatus, DLOG_IAM_RES_FILE_NUM, DLOG_IAM_RES_TIMEOUT
    };
    int32_t ret = IAMRegResStatusChangeCb(LogProxyIamResStatusCb, iamResSubConfig);
    if (ret == 0) {
        SELF_LOG_INFO("iam resource register success, pid = %d.", (int32_t)getpid());
    } else {
        SELF_LOG_ERROR("iam resource register failed, ret = %d, errno = %d, pid = %d.",
                       ret, errno, (int32_t)getpid());
        NO_ACT_ERR_LOG(IAMRetrieveService() != SYS_OK, "iam retrieve service failed.");
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

STATIC void DeInitIam(void)
{
    if (g_iamFd >= 0) {
        (void)close(g_iamFd);
        g_iamFd = INVALID;
    }
    int32_t ret = IAMUnregAssignedResStatusChangeCb((char *)LOGOUT_IAM_SERVICE_PATH);
    if (ret == 0) {
        SELF_LOG_INFO("iam resource unregister success, pid = %d.", (int32_t)getpid());
    } else {
        SELF_LOG_ERROR("iam resource unregister failed, ret = %d, errno = %d, pid = %d.",
                       ret, errno, (int32_t)getpid());
    }
    NO_ACT_ERR_LOG(IAMRetrieveService() != SYS_OK, "iam retrieve service failed.");
    return;
}

STATIC void FlushIamLog(int32_t himemFd)
{
    uint32_t nodeNum = HiMemReadIamLog(himemFd, g_logProxBuf);
    if (nodeNum == 0) {
        return;
    }
    int32_t n = 0;
    int32_t retryTime = 0;
    const uint32_t sleepTime = 1; // time to sleep when slogd is not ready.
    do {
        if (g_iamFd == INVALID) {
            (void)sleep(sleepTime);
            continue;
        }
        n = (int32_t)write(g_iamFd, g_logProxBuf->ringBufferCtrl, g_logProxBuf->logBufSize);
        retryTime++;
    } while ((n != (int32_t)(g_logProxBuf->logBufSize)) && (retryTime < IAM_RETRY_TIMES));
    int ret = memset_s(g_logProxBuf->ringBufferCtrl, sizeof(RingBufferCtrl), 0, sizeof(RingBufferCtrl));
    if (ret != 0) {
        SELF_LOG_ERROR("memset_s g_logProxBuf err. errno :%d", errno);
    }
}

STATIC int32_t HimemRead(int32_t himemFd)
{
    g_logProxBuf = (RingBufferStat *)LogMalloc(sizeof(RingBufferStat));
    ONE_ACT_ERR_LOG(g_logProxBuf == NULL, return SYS_ERROR, "mallocRingBufferStatf failed. errno :%d", errno);
    g_logProxBuf->logBufSize = DEF_SIZE;
    g_logProxBuf->ringBufferCtrl = (RingBufferCtrl *)LogMalloc(g_logProxBuf->logBufSize);
    if (g_logProxBuf->ringBufferCtrl == NULL) {
        XFREE(g_logProxBuf);
        return SYS_ERROR;
    }
    int32_t ret = LogBufInitHead(g_logProxBuf->ringBufferCtrl, g_logProxBuf->logBufSize, 0);
    if (ret != 0) {
        SELF_LOG_ERROR("memset_s g_logProxBuf err. errno :%d", errno);
        XFREE(g_logProxBuf->ringBufferCtrl);
        XFREE(g_logProxBuf);
        return SYS_ERROR;
    }
    FlushIamLog(himemFd);
    XFREE(g_logProxBuf->ringBufferCtrl);
    XFREE(g_logProxBuf);
    g_logProxBuf = NULL;
    return SYS_OK;
}

int32_t MAIN(int argc, char **argv)
{
    (void)argc;
    (void)argv;
    int32_t fd = -1;
    openlog("sea_log_proxy", LOG_NDELAY, LOG_USER);
    ONE_ACT_NO_LOG(InitIam() != LOG_SUCCESS, return SYS_ERROR);
    TWO_ACT_NO_LOG(HiMemInit(&fd) != LOG_SUCCESS, DeInitIam(), return SYS_ERROR);

    if (HimemRead(fd) != SYS_OK) {
        HiMemFree(&fd);
        DeInitIam();
        SELF_LOG_ERROR("himem read failed.");
        return SYS_ERROR;
    }
    HiMemFree(&fd);
    DeInitIam();
    return SYS_OK;
}
