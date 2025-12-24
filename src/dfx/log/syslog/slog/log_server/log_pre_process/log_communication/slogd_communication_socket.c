/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "slogd_communication.h"
#include "log_common.h"
#include "log_system_api.h"
#include "log_file_info.h"
#include "log_path_mgr.h"
#include "log_print.h"
#include "slogd_flush.h"
#include "slogd_dev_mgr.h"

#define LOG_CLOSE_SOCK(sock) do {   \
    (void)ToolCloseSocket((sock));  \
    (sock) = -1;                    \
} while (0)

#define SIZE_SIXTEEN_MB (16 * 1024 * 1024) // 16MB

#ifndef SLOGD_SERVER_USER_NAME
#define SLOGD_SERVER_USER_NAME "HwHiAiUser"
#endif

typedef struct {
    char filename[WORKSPACE_PATH_MAX_LENGTH + 1U];
    char username[MAX_USERNAME_LEN + 1U];
    char groupName[MAX_USERNAME_LEN + 1U];
    int32_t permission;
} SocketFileInfo;

STATIC toolSockHandle g_sockFd[SLOG_FILE_NUM];
STATIC SocketFileInfo g_socketFileInfoTbl[SLOG_FILE_NUM] = {
    // index 0 is the fd for HwHiAiUser socket
    // To ensure compatibility, the slog user group is set to HwHiAiUser temporarily
    // and will be changed to HwBaseUser in future.
    {SOCKET_FILE, SLOGD_SERVER_USER_NAME, SLOGD_SERVER_USER_NAME, (S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP)},  // 660
    {CUST_SOCKET_FILE, SLOGD_SERVER_USER_NAME, SLOGD_SERVER_USER_NAME, (S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP)}  // 660
};

STATIC int32_t SlogdGetSocketPath(int32_t devId, char socketPath[SLOG_FILE_NUM][WORKSPACE_PATH_MAX_LENGTH + 1U],
    uint32_t *fileNum)
{
    int32_t ret;
    *fileNum = 0;
    char *defaultPath = LogGetWorkspacePath();
    if ((devId >= MIN_VFID_NUM) && (devId <= MAX_VFID_NUM)) {
        *fileNum = 1;
        ret = sprintf_s(socketPath[0], WORKSPACE_PATH_MAX_LENGTH, "%s%s_%d", defaultPath, SOCKET_FILE, devId);
        ONE_ACT_ERR_LOG(ret == -1, return SYS_ERROR, "sprintf_s vfid failed, vfid=%d.", devId);
    } else {
        *fileNum = SLOG_FILE_NUM;
        for (uint32_t i = 0; i < *fileNum; i++) {
            ret = sprintf_s(socketPath[i], WORKSPACE_PATH_MAX_LENGTH, "%s%s",
                defaultPath, g_socketFileInfoTbl[i].filename);
            ONE_ACT_ERR_LOG(ret == -1, return SYS_ERROR, "sprintf_s vfid failed, vfid=%d.", devId);
        }
    }
    return SYS_OK;
}

STATIC toolSockHandle SlogdCreateSocketBySlogFile(char *socketPath, char *groupName, int32_t permission)
{
    struct sockaddr_un sunx;
    int32_t nSendBuf = SIZE_SIXTEEN_MB;
    (void)memset_s(&sunx, sizeof(sunx), 0, sizeof(sunx));
    sunx.sun_family = AF_UNIX;

    int32_t ret = strcpy_s(sunx.sun_path, sizeof(sunx.sun_path), socketPath);
    ONE_ACT_ERR_LOG(ret != EOK, return SYS_ERROR,
        "strcpy_s failed, result=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));

    // Unlink the previous socket file first.
    ret = ToolUnlink(sunx.sun_path);
    NO_ACT_WARN_LOG(ret != EOK,
        "can not unlink file=%s, strerr=%s.", sunx.sun_path, strerror(ToolGetErrorCode()));

    // Create socket.
    toolSockHandle sockFd = ToolSocket(AF_UNIX, SOCK_DGRAM, 0);
    ONE_ACT_ERR_LOG(sockFd < 0, return SYS_ERROR,
        "create socket failed, strerr=%s.", strerror(ToolGetErrorCode()));

    // Set socket description.
    ret = setsockopt(sockFd, SOL_SOCKET, SO_RCVBUF, (const char *)&nSendBuf, sizeof(int32_t));
    NO_ACT_ERR_LOG(ret < 0, "set socket option failed, strerr=%s.", strerror(ToolGetErrorCode()));

    // bind socket with a certain address.
    ret = ToolBind(sockFd, (ToolSockAddr *)&sunx, sizeof(sunx));
    TWO_ACT_ERR_LOG(ret != SYS_OK, LOG_CLOSE_SOCK(sockFd), return SYS_ERROR,
        "bind socket failed, bind path is: %s, strerr=%s.", sunx.sun_path, strerror(ToolGetErrorCode()));

    // Get the GID by using group name string
    struct group *grpInfo = getgrnam(groupName);
    TWO_ACT_ERR_LOG(grpInfo == NULL, LOG_CLOSE_SOCK(sockFd), return SYS_ERROR, "%s is not exist", groupName);

    // Change the socket files owner and group.
    ret = lchown(sunx.sun_path, getuid(), grpInfo->gr_gid);
    TWO_ACT_ERR_LOG(ret != SYS_OK, LOG_CLOSE_SOCK(sockFd), return SYS_ERROR,
        "Change the socket file: %s group failed, strerr=%s.", sunx.sun_path, strerror(ToolGetErrorCode()));

    // Set the socket files permission.
    ret = ToolChmod(sunx.sun_path, permission);
    TWO_ACT_ERR_LOG(ret != SYS_OK, LOG_CLOSE_SOCK(sockFd), return SYS_ERROR,
        "chmod %s failed , strerr=%s.", sunx.sun_path, strerror(ToolGetErrorCode()));

    SELF_LOG_INFO("create socket succeed, socket path: %s.", sunx.sun_path);
    return sockFd;
}

STATIC int32_t SlogdCreateSocket(int32_t devId, uint32_t *fileNum)
{
    char socketPath[SLOG_FILE_NUM][WORKSPACE_PATH_MAX_LENGTH + 1U];
    (void)memset_s(socketPath, sizeof(socketPath), 0, sizeof(socketPath));

    int32_t ret = SlogdGetSocketPath(devId, socketPath, fileNum);
    ONE_ACT_ERR_LOG(ret != SYS_OK, return SYS_ERROR, "get slogd socket path failed, result=%d.", ret);
    SELF_LOG_INFO("Total socket num is %u.", *fileNum);

    for (uint32_t i = 0; i < *fileNum; i++) {
        SELF_LOG_INFO("Socket Path is: %s.", socketPath[i]);
        g_sockFd[i] = SlogdCreateSocketBySlogFile(socketPath[i], g_socketFileInfoTbl[i].groupName,
            (int32_t)SyncGroupToOther(g_socketFileInfoTbl[i].permission));
        ONE_ACT_ERR_LOG(g_sockFd[i] == SYS_ERROR, return SYS_ERROR,
            "create socket failed, strerr=%s.", strerror(ToolGetErrorCode()));
    }
    return SYS_OK;
}

/**
 * @brief       : init for communication server
 * @return      : LOG_SUCCESS: success; LOG_FAILURE: failure
 */
LogStatus SlogdRmtServerInit(void)
{
    return LOG_SUCCESS;
}

/**
 * @brief       : exit for communication server
 */
void SlogdRmtServerExit(void)
{
    return;
}

/**
 * @brief       : create socket
 * @param       : devId       device id
                  fileNum   the number of socket
 * @return      : SYS_OK: success; others: create failed
 */
int32_t SlogdRmtServerCreate(int32_t devId, uint32_t *fileNum)
{
    return SlogdCreateSocket(devId, fileNum);
}

/**
 * @brief       : read messages by socket
 */
int32_t SlogdRmtServerRecv(uint32_t fileNum, char *buf, uint32_t bufLen, int32_t *logType)
{
    (void)logType;
    static uint32_t turn = 0;
    fd_set fdSet;
    FD_ZERO(&fdSet);
    for (uint32_t i = 0; i < fileNum; i++) {
        FD_SET(g_sockFd[i], &fdSet);
    }
    int maxfd = g_sockFd[0] > g_sockFd[1] ? g_sockFd[0] : g_sockFd[1];
    // The first parameter should be the max fd + 1 .
    int ret = select(maxfd + 1, &fdSet, NULL, NULL, NULL);
    ONE_ACT_ERR_LOG(ret <= 0, return SYS_ERROR,
        "select error, strerr=%s.", strerror(ToolGetErrorCode()));
    // ret > 0 means fd changes, then check all fds and receive.
    for (uint32_t i = 0; i < fileNum; i++) {
        if (FD_ISSET(g_sockFd[(i + turn) % fileNum], &fdSet)) {
            return ToolRead(g_sockFd[(i + turn) % fileNum], buf, bufLen);
        }
    }
    turn = (turn + 1) % fileNum;
    return SYS_OK;
}

/**
 * @brief      close socket fd and unlink socket file
 * @param[in]  devId:       device id
 * @param[in]  fileNum:     file number
 */
void SlogdRmtServerClose(int32_t devId, uint32_t fileNum)
{
    for (uint32_t i = 0; i < fileNum; i++) {
        (void)ToolCloseSocket(g_sockFd[i]);
    }

    char socketPath[SLOG_FILE_NUM][WORKSPACE_PATH_MAX_LENGTH + 1U];
    (void)memset_s(socketPath, sizeof(socketPath), 0, sizeof(socketPath));

    uint32_t num = fileNum;
    int32_t ret = SlogdGetSocketPath(devId, socketPath, &num);
    ONE_ACT_ERR_LOG(ret != SYS_OK, return, "get slogd socket path failed, result=%d.", ret);
    for (uint32_t i = 0; i < num; i++) {
        (void)ToolUnlink(socketPath[i]);
    }
}