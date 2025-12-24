/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dlog_socket.h"
#include "dlog_attr.h"
#include "log_file_info.h"
#include "log_print.h"
#include "securec.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

STATIC toolSockHandle g_logFd = INVALID;
STATIC int32_t g_connectFlag = 0;
STATIC uint32_t g_connPrintNum = 0;

#define RSYSLOG_SOCKET_NAME_LEN 32U
#define RSYSLOG_SOCKET_NUM 3U
 
typedef struct {
    uint32_t typemask;
    char socketName[RSYSLOG_SOCKET_NAME_LEN];
    int32_t fd;
} RsyslogSocket;

STATIC RsyslogSocket g_rsyslogSocket[RSYSLOG_SOCKET_NUM] = {
    {DEBUG_LOG_MASK, "debug_os", -1},
    {SECURITY_LOG_MASK, "sec_os", -1},
    {RUN_LOG_MASK, "run_os", -1},
};

/**
* @brief IsSocketConnected: return socket status
* @return: g_connectFlag
*/
int32_t IsSocketConnected(void)
{
    return g_connectFlag;
}

/**
* @brief SetSocketConnectedStatus: set g_connectFlag
* @param [in] status: TRUE:socket is connected, FALSE:socket is not connected
* @return: void
*/
void SetSocketConnectedStatus(int32_t status)
{
    if ((status == TRUE) || (status == FALSE)) {
        g_connectFlag = status;
    } else {
        SELF_LOG_WARN("status is invalid. status is %d.", status);
    }
}

/**
* @brief IsSocketFdValid: check g_logFd
* @return: g_logFd<0, return false, others return true.
*/
bool IsSocketFdValid(void)
{
    if (DlogIsPoolingDevice()) {
        return true;
    }
    if (g_logFd < 0) {
        return false;
    } else {
        return true;
    }
}

/**
* @brief SetSocketFd: set g_logFd
* @param [in] fd: socket fd
* @return: void
*/
void SetSocketFd(int32_t fd)
{
    g_logFd = fd;
}

toolSockHandle GetSocketFd(void)
{
    return g_logFd;
}

STATIC int32_t DlogSocketConnect(toolSockHandle sockFd, const char* socketName)
{
    struct sockaddr_un sunx;
    int32_t pid = ToolGetPid();
    int32_t nSendBuf = SIZE_TWO_MB;
    int32_t ret = setsockopt(sockFd, SOL_SOCKET, SO_SNDBUF, (const char *)&nSendBuf, (uint32_t)sizeof(int));
    ONE_ACT_ERR_LOG(ret < 0, return SYS_ERROR, "set socket option failed, strerr=%s, pid=%d.",
        strerror(ToolGetErrorCode()), pid);

    ret = memset_s(&sunx, sizeof(sunx), 0, sizeof(sunx));
    ONE_ACT_ERR_LOG(ret != EOK, return SYS_ERROR, "memset_s failed, result=%d, strerr=%s, pid=%d.",
        ret, strerror(ToolGetErrorCode()), pid);

    sunx.sun_family = AF_UNIX;
    char socketPath[WORKSPACE_PATH_MAX_LENGTH + 1U] = { 0 };
    ret = snprintf_s(socketPath, WORKSPACE_PATH_MAX_LENGTH + 1U, WORKSPACE_PATH_MAX_LENGTH,
        "%s/rsyslog_%s", DEFAULT_LOG_WORKSPACE, socketName);
    ONE_ACT_ERR_LOG(ret == -1, return SYS_ERROR, "snprintf_s failed, result=%d, strerr=%s, pid=%d.",
        ret, strerror(ToolGetErrorCode()), pid)

    ret = strcpy_s(sunx.sun_path, sizeof(sunx.sun_path), socketPath);
    ONE_ACT_ERR_LOG(ret != EOK, return SYS_ERROR, "strcpy failed, ret=%d, pid=%d.", ret, pid);

    ret = ToolConnect(sockFd, (ToolSockAddr *)&sunx, (uint32_t)sizeof(sunx));
    if (ret != SYS_OK) {
        SELF_LOG_WARN_N(&g_connPrintNum, CONN_W_PRINT_NUM,
                        "rsyslogd is not ready, will try to connect again later, pid=%d, \
                        print once every %d times.", pid, CONN_W_PRINT_NUM);
        return SYS_ERROR;
    }

    return SYS_OK;
}

STATIC toolSockHandle GetRsyslogSocket(const char* socketName)
{
    int32_t pid = ToolGetPid();
    toolSockHandle sockFd = ToolSocket(AF_UNIX, (uint32_t)SOCK_DGRAM | (uint32_t)SOCK_NONBLOCK, 0);
    ONE_ACT_ERR_LOG(sockFd == SYS_ERROR, return SYS_ERROR, "create socket failed, strerr=%s, pid=%d",
                    strerror(ToolGetErrorCode()), pid);

    int32_t ret = DlogSocketConnect(sockFd, socketName);
    if (ret == SYS_OK) {
        return sockFd;
    }

    ret = ToolClose(sockFd);
    if (ret != SYS_OK) {
        SELF_LOG_ERROR("close socket failed, strerr=%s, pid=%d.", strerror(ToolGetErrorCode()), pid);
    }
    return SYS_ERROR;
}

toolSockHandle GetRsyslogSocketFd(uint32_t typeMask)
{
    for(uint32_t i = 0; i < RSYSLOG_SOCKET_NUM; i++) {
        if(typeMask != g_rsyslogSocket[i].typemask) {
            continue;
        }
        if(g_rsyslogSocket[i].fd == -1) {
            g_rsyslogSocket[i].fd = GetRsyslogSocket(g_rsyslogSocket[i].socketName);
        }
        return g_rsyslogSocket[i].fd;
    }
    return -1;
}

int32_t CloseSocket(void)
{
    return ToolClose(g_logFd);
}

void CloseLogInternal(void)
{
    if (IsSocketConnected() == FALSE) {
        return;
    }

    if (CloseSocket() != SYS_OK) {
        SELF_LOG_ERROR("close socket failed, strerr=%s, pid=%d.", strerror(ToolGetErrorCode()), ToolGetPid());
    }
    SetSocketFd(INVALID);
    SetSocketConnectedStatus(FALSE);
}

void SigPipeHandler(int32_t signo)
{
    (void)signo;
    CloseLogInternal();
}

/**
 * @brief : strcat filename to directory
 * @param [out]path: the full path
 * @param [in]filename: pointer to store file name
 * @param [in]dir:pointer to store dir
 * @param [in]maxlen:the maxlength of out path
 * @return:succeed: SYS_OK, failed:SYS_ERROR
 */
STATIC int DlogStrcatDir(char *path, const char *filename, const char *dir, unsigned int maxlen)
{
    if ((dir == NULL) || (filename == NULL) || (path == NULL)) {
        return SYS_ERROR;
    }
    if ((unsigned int)(strlen(dir) + strlen(filename)) > maxlen) {
        return SYS_ERROR;
    }

    int ret;
    do {
        ret = strcpy_s(path, maxlen, dir);
        if (ret != EOK) {
            SYSLOG_WARN("strcpy_s failed, path=%s, dir=%s, result=%d, strerr=%s.\n",
                        path, dir, ret, strerror(ToolGetErrorCode()));
            break;
        }
        ret = strcat_s(path, maxlen, filename);
        if (ret != EOK) {
            SYSLOG_WARN("strcat_s failed, path=%s, filename=%s, result=%d, strerr=%s.\n",
                        path, filename, ret, strerror(ToolGetErrorCode()));
            break;
        }
        return SYS_OK;
    } while (0);

    SELF_LOG_ERROR("strcat filename to directory failed, dir=%s, filename=%s.", dir, filename);
    // 复制或者拼接失败之后，将路径清空，防止继续对错误的路径进行操作
    ret = memset_s(path, (size_t)maxlen, 0, (size_t)maxlen);
    if (ret != EOK) {
        SYSLOG_WARN("memset_s failed, path=%s, filename=%s, result=%d, strerr=%s.\n",
                    path, filename, ret, strerror(ToolGetErrorCode()));
    }
    return SYS_ERROR;
}

/**
 * @brief           : get socket path if devId is vfid
 * @param [in]      : vfid              vfid
 * @param [out]     : socketPath        socket path
 * @param [in]      : pathLen           path length
 * @return          : !=0 failure; ==0 success
 */
STATIC int32_t GetSocketPathByVfid(const uint32_t vfid, char *socketPath, const uint32_t pathLen)
{
    ONE_ACT_ERR_LOG(socketPath == NULL, return SYS_ERROR, "[input]socketPath is null.");
    char fileName[WORKSPACE_FILE_MAX_LENGTH + 1U] = { 0 };
    int32_t ret = snprintf_s(fileName, WORKSPACE_FILE_MAX_LENGTH + 1U, WORKSPACE_FILE_MAX_LENGTH,
                             "%s_%u", SOCKET_FILE, vfid);
    if (ret == -1) {
        SELF_LOG_ERROR("snprintf_s failed, strerr=%s, pid=%d, vfid=%u.",
                       strerror(ToolGetErrorCode()), ToolGetPid(), vfid);
        return SYS_ERROR;
    }

    ret = DlogStrcatDir(socketPath, fileName, DEFAULT_LOG_WORKSPACE, pathLen);
    ONE_ACT_ERR_LOG(ret != SYS_OK, return SYS_ERROR, "strcat socket path failed, ret=%d, vfid=%u.", ret, vfid);

    return SYS_OK;
}

/**
 * @brief           : get socket path if devId is pfid
 * @param [out]     : socketPath        socket path
 * @param [in]      : pathLen           path length
 * @return          : !=0 failure; ==0 success
 */
STATIC int32_t GetSocketPathByPfid(char *socketPath, const uint32_t pathLen)
{
    ONE_ACT_ERR_LOG(socketPath == NULL, return SYS_ERROR, "[input]socketPath is null.");
    int32_t ret = DlogStrcatDir(socketPath, SOCKET_FILE, DEFAULT_LOG_WORKSPACE, pathLen);
    ONE_ACT_ERR_LOG(ret != SYS_OK, return SYS_ERROR, "strcat socket path failed, ret=%d.", ret);

    // only alog will consider using the "slog_app" to create the socket
    if (DlogCheckAttrSystem()) {
        return SYS_OK;
    }
    struct passwd *curUsrInfo = getpwuid(DlogGetUid());
    ONE_ACT_ERR_LOG(curUsrInfo == NULL, return SYS_ERROR, "get current user info failed.");
    SELF_LOG_INFO("Current username is %s.", curUsrInfo->pw_name);

    struct stat dirStat;
    ret = ToolStatGet(DEFAULT_LOG_WORKSPACE, &dirStat);
    ONE_ACT_ERR_LOG(ret != SYS_OK, return SYS_ERROR, "get default slog path state failed.");

    if (curUsrInfo->pw_uid == dirStat.st_uid) {
        return SYS_OK;
    }
    char customSlogPath[WORKSPACE_PATH_MAX_LENGTH + 1U] = { 0 };
    ret = DlogStrcatDir(customSlogPath, CUST_SOCKET_FILE, DEFAULT_LOG_WORKSPACE, pathLen);
    ONE_ACT_ERR_LOG(ret != SYS_OK, return SYS_ERROR, "strcat socket path failed, ret=%d.", ret);

    ONE_ACT_WARN_LOG(ToolAccess(customSlogPath) != SYS_OK, return SYS_OK,
        "Path %s cannot access.", customSlogPath);
    (void)memset_s(socketPath, pathLen, 0, pathLen);
    ret = strcpy_s(socketPath, pathLen, customSlogPath);
    ONE_ACT_ERR_LOG(ret != EOK, return SYS_ERROR, "strcpy_s failed.");
    return SYS_OK;
}

/**
 * @brief           : get socket path when slog create socket
 * @param [in]      : devId             device id
 * @param [out]     : socketPath        socket path
 * @param [in]      : pathLen           path length
 * @return          : !=0 failure; ==0 success
 */
STATIC int32_t GetSlogSocketPath(const uint32_t devId, char *socketPath, const uint32_t pathLen)
{
    ONE_ACT_ERR_LOG(socketPath == NULL, return SYS_ERROR, "[input]socketPath is null.");

    const uint32_t minVfid = 32; // vfid minimum value
    if ((devId >= minVfid) && (devId < (uint32_t)DEVICE_MAX_DEV_NUM)) {
        // devId(32~63) is vfid, strcat socketpath with "slog_vfid"
        return GetSocketPathByVfid(devId, socketPath, pathLen);
    } else {
        // devId(0~31) is pfid, strcat socketpath with "slog"
        return GetSocketPathByPfid(socketPath, pathLen);
    }
}

toolSockHandle CreatSocket(uint32_t devId)
{
    struct sockaddr_un sunx;
    int32_t pid = ToolGetPid();
    toolSockHandle sockFd = ToolSocket(AF_UNIX, (uint32_t)SOCK_DGRAM | (uint32_t)SOCK_NONBLOCK, 0);
    ONE_ACT_ERR_LOG(sockFd == SYS_ERROR, return SYS_ERROR, "create socket failed, strerr=%s, pid=%d",
                    strerror(ToolGetErrorCode()), pid);

    int32_t nSendBuf = SIZE_TWO_MB;
    int32_t ret;
    do {
        ret = setsockopt(sockFd, SOL_SOCKET, SO_SNDBUF, (const char *)&nSendBuf, sizeof(int));
        ONE_ACT_ERR_LOG(ret < 0, break, "set socket option failed, strerr=%s, pid=%d.",
                         strerror(ToolGetErrorCode()), pid);

        ret = memset_s(&sunx, sizeof(sunx), 0, sizeof(sunx));
        ONE_ACT_ERR_LOG(ret != EOK, break, "memset_s failed, result=%d, strerr=%s, pid=%d.",
                         ret, strerror(ToolGetErrorCode()), pid);

        sunx.sun_family = AF_UNIX;
        char socketPath[WORKSPACE_PATH_MAX_LENGTH + 1U] = { 0 };
        ret = GetSlogSocketPath(devId, socketPath, WORKSPACE_PATH_MAX_LENGTH);
        ONE_ACT_ERR_LOG(ret != SYS_OK, break, "get socket path failed, ret=%d, pid=%d, devId=%u.", ret, pid, devId);

        ret = strcpy_s(sunx.sun_path, sizeof(sunx.sun_path), socketPath);
        ONE_ACT_ERR_LOG(ret != EOK, break, "strcpy failed, ret=%d, pid=%d, devId=%u.", ret, pid, devId);

        ret = ToolConnect(sockFd, (ToolSockAddr *)&sunx, sizeof(sunx));
        if (ret != SYS_OK) {
            SELF_LOG_WARN_N(&g_connPrintNum, CONN_W_PRINT_NUM,
                            "slogd is not ready, will try to connect again later, pid=%d, \
                            print once every %d times.", pid, CONN_W_PRINT_NUM);
            break;
        }

        return sockFd;
    } while (0);

    ret = ToolClose(sockFd);
    if (ret != SYS_OK) {
        SELF_LOG_ERROR("close socket failed, strerr=%s, pid=%d.", strerror(ToolGetErrorCode()), pid);
    }
    return SYS_ERROR;
}

#ifdef __cplusplus
}
#endif // __cplusplus