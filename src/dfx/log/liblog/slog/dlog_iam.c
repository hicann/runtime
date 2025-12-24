/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dlog_iam.h"
#include "log_iam_pub.h"
#include "log_print.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#define DLOG_IAM_RES_FILE_NUM   1
#define DLOG_IAM_RES_TIMEOUT    (-1)

STATIC int32_t g_logOutFd = INVALID;
STATIC enum IAMResourceStatus g_iamResStatus = IAM_RESOURCE_WAITING;
STATIC IamRegisterServer g_iamRegLevelServer = NULL;

bool DlogIamServiceIsValid(void)
{
    return (g_logOutFd != INVALID);
}

/**
 * @brief       : slog ioctl by iam
 * @param [in]  : fd            file fd
 * @param [in]  : cmd           command
 * @param [in]  : arg           iam ioctl args
 * @return      : == 0 success; != 0 failure
 */
STATIC int32_t SlogIamIoctl(int32_t fd, uint32_t cmd, struct IAMIoctlArg *arg)
{
    int32_t retry = 0;
    int32_t ret = 0;
    int32_t err = 0;
    do {
        ret = ioctl(fd, cmd, arg);
        retry++;
        err = ToolGetErrorCode();
    } while ((ret == SYS_ERROR) && (retry <= IAM_RETRY_TIMES) && (IS_BUSY(err)));
    return ret;
}

/**
 * @brief           : open iam service fd
 * @param [in/out]  : fd               iam service fd
 * @return          : == SYS_OK success; == SYS_ERROR failure
 */
STATIC int32_t DlogIamOpenServiceFd(int32_t *fd)
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
    return (*fd == INVALID) ? SYS_ERROR : SYS_OK;
}

/**
 * @brief        : get level by iam ioctl
 * @param [in]   : arg      argument
 * @return       : == 0 success; != 0 failure
 */
int32_t DlogIamIoctlGetLevel(struct IAMIoctlArg *arg)
{
    if (!DlogIamServiceIsValid()) {
        return SYS_ERROR;
    }
    return SlogIamIoctl(g_logOutFd, IAM_CMD_GET_LEVEL, arg);
}

/**
 * @brief        : flush log buffer by iam ioctl
 * @param [in]   : arg      argument
 * @return       : == 0 success; != 0 failure
 */
int32_t DlogIamIoctlFlushLog(struct IAMIoctlArg *arg)
{
    return SlogIamIoctl(g_logOutFd, IAM_CMD_FLUSH_LOG, arg);
}

/**
 * @brief           : write log buffer to iam
 * @param [in]      : buffer      log buffer
 * @param [in]      : length      length of log buffer
 * @return          : >= 0 success; < 0 failure
 */
int32_t DlogIamWrite(void* buffer, uint32_t length)
{
    return (int32_t)write(g_logOutFd, buffer, length);
}

/**
 * @brief           : open iam service fd
 * @return          : == SYS_OK success; == SYS_ERROR failure
 */
int32_t DlogIamOpenService(void)
{
    if (DlogIamOpenServiceFd(&g_logOutFd) == SYS_OK) {
        SELF_LOG_INFO("open iam service succeed, pid = %d.", ToolGetPid());
        return SYS_OK;
    }
    int32_t err = ToolGetErrorCode();
    if (err == EPROTONOSUPPORT) {
        SELF_LOG_WARN("can not open self resmgr, errno = %d, pid = %d.", err, ToolGetPid());
    } else {
        SELF_LOG_ERROR("open iam service failed, errno = %d, pid = %d.", err, ToolGetPid());
    }
    return SYS_ERROR;
}

/**
 * @brief           : when iam is ready, get log level by iam will be call back
 */
void DlogIamRegisterServer(IamRegisterServer regFunc)
{
    if (regFunc != NULL) {
        g_iamRegLevelServer = regFunc;
    }
}

/**
 * @brief           : unregister log level call back
 */
STATIC void DlogIamUnregisterServer(void)
{
    g_iamRegLevelServer = NULL;
}

STATIC bool DlogIamResStatusIsChange(struct IAMVirtualResourceStatus *resList, int32_t listNum)
{
    for (int32_t i = 0; i < listNum; i++) {
        if (strcmp(LOGOUT_IAM_SERVICE_PATH, resList[i].IAMResName) == 0) {
            if (g_iamResStatus != resList[i].status) {
                g_iamResStatus = resList[i].status;
                SELF_LOG_INFO("iam resource status update finished, status = %d, pid = %d.",
                              (int32_t)g_iamResStatus, ToolGetPid());
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
 * @return          : == SYS_OK success; == SYS_ERROR failure
 */
STATIC void DlogIamResStatusCb(struct IAMVirtualResourceStatus *resList, const int32_t listNum)
{
    ONE_ACT_ERR_LOG((resList == NULL) || (listNum == 0), return,
                    "iam resource status cb input null, pid = %d.", ToolGetPid());
    if (DlogIamResStatusIsChange(resList, listNum)) {
        if (g_iamResStatus == IAM_RESOURCE_READY) {
            if ((DlogIamOpenService() == SYS_OK) && (g_iamRegLevelServer != NULL)) {
                g_iamRegLevelServer(); // call back log level init
            }
        } else {
            SELF_LOG_INFO("fd is invalid, g_iamResStatus = %d, pid = %d.", (int32_t)g_iamResStatus, ToolGetPid());
            (void)close(g_logOutFd);
            g_logOutFd = INVALID;
        }
    }
}

/**
 * @brief           : register iam call back
 * @return          : == SYS_OK success; == SYS_ERROR failure
 */
int32_t DlogIamInit(void)
{
    if (!IAMCheckServicePreparation()) {
        SELF_LOG_WARN("iam resource service is not available, pid = %d", ToolGetPid());
        return SYS_ERROR;
    }
    struct IAMVirtualResourceStatus virtualResStatus = { LOGOUT_IAM_SERVICE_PATH, IAM_RESOURCE_WAITING };
    struct IAMResourceSubscribeConfig iamResSubConfig = {
        &virtualResStatus, DLOG_IAM_RES_FILE_NUM, DLOG_IAM_RES_TIMEOUT
    };
    int32_t ret = IAMRegResStatusChangeCb(DlogIamResStatusCb, iamResSubConfig);
    if (ret == 0) {
        SELF_LOG_INFO("iam resource register success, pid = %d.", ToolGetPid());
    } else {
        SELF_LOG_ERROR("iam resource register failed, ret = %d, errno = %d, pid = %d.",
                       ret, ToolGetErrorCode(), ToolGetPid());
        return SYS_ERROR;
    }
    return SYS_OK;
}

/**
 * @brief           : unregister iam call back
 */
void DlogIamExit(void)
{
    int32_t ret = IAMUnregAssignedResStatusChangeCb((char *)LOGOUT_IAM_SERVICE_PATH);
    if (ret == 0) {
        SELF_LOG_INFO("iam resource unregister success, pid = %d.", ToolGetPid());
    } else {
        SELF_LOG_ERROR("iam resource unregister failed, ret = %d, errno = %d, pid = %d.",
                       ret, ToolGetErrorCode(), ToolGetPid());
    }
    DlogIamUnregisterServer();
    return;
}

#ifdef __cplusplus
}
#endif // __cplusplus
