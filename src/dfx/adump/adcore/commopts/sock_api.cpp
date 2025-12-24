/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "sock_api.h"
#include <arpa/inet.h>
#include <netinet/tcp.h>
#include "log/adx_log.h"
#include "adx_msg.h"
#include "mmpa_api.h"
using namespace Adx;

/**
 * @brief      create sock server
 * @param [in] adxLocalChan: local channel string
 *
 * @return
 *      sock fd
 */
int32_t SockServerCreate(const std::string &adxLocalChan)
{
    IDE_CTRL_VALUE_FAILED(!adxLocalChan.empty(), return -1, "local socket failed");
    int32_t sockFd = mmSocket(PF_LOCAL, SOCK_STREAM, 0);
    IDE_CTRL_VALUE_FAILED(sockFd >= 0, return sockFd, "local socket failed");

    struct sockaddr_un sockAddr;
    (void)memset_s(&sockAddr, sizeof(sockAddr), 0, sizeof(sockAddr));
    int32_t ret = strcpy_s(sockAddr.sun_path + 1, sizeof(sockAddr.sun_path) - 1, adxLocalChan.c_str());
    if (ret != EOK) {
        IDE_LOGE("local socket path copy failed");
        ADX_LOCAL_CLOSE_AND_SET_INVALID(sockFd);
        return sockFd;
    }

    sockAddr.sun_family = AF_LOCAL;
    ret = mmBind(sockFd, reinterpret_cast<mmSockAddr *>(&sockAddr),
        offsetof(struct sockaddr_un, sun_path) + 1 + adxLocalChan.size());
    if (ret < 0) {
        char errBuf[MAX_ERRSTR_LEN + 1] = {0};
        IDE_LOGE("local server bind exception info : %s",
                 mmGetErrorFormatMessage(mmGetErrorCode(), errBuf, MAX_ERRSTR_LEN));
        ADX_LOCAL_CLOSE_AND_SET_INVALID(sockFd);
        return sockFd;
    }

    ret = mmListen(sockFd, TCP_MAX_LISTEN_NUM);
    if (ret < 0) {
        char errBuf[MAX_ERRSTR_LEN + 1] = {0};
        IDE_LOGE("local server listen exception info : %s",
                 mmGetErrorFormatMessage(mmGetErrorCode(), errBuf, MAX_ERRSTR_LEN));
        ADX_LOCAL_CLOSE_AND_SET_INVALID(sockFd);
        return sockFd;
    }

    IDE_LOGD("local server init %d", sockFd);
    return sockFd;
}

/**
 * @brief      destroy sock server
 * @param [in] sockFd: sock Fd
 *
 * @return
 *      IDE_DAEMON_OK: destroy sock server success
 *      IDE_DAEMON_ERROR: destroy sock server failed
 */
int32_t SockServerDestroy(int32_t &sockFd)
{
    if (sockFd < 0) {
        return IDE_DAEMON_ERROR;
    }

    mmClose(sockFd);
    sockFd = -1;
    return IDE_DAEMON_OK;
}

/**
 * @brief      create sock client
 *
 * @return
 *      sock fd
 */
int32_t SockClientCreate()
{
    int sockFd = mmSocket(PF_LOCAL, SOCK_STREAM, 0);
    IDE_CTRL_VALUE_FAILED(sockFd >= 0, return sockFd, "local socket failed");
    IDE_LOGI("SockClientCreate sockFd: %d", sockFd);
    return sockFd;
}

/**
 * @brief      destroy sock client
 * @param [in] sockFd: sock Fd
 *
 * @return
 *      IDE_DAEMON_OK: destroy sock client success
 *      IDE_DAEMON_ERROR: destroy sock client failed
 */
int32_t SockClientDestory(int32_t &sockFd)
{
    IDE_CTRL_VALUE_FAILED(sockFd >= 0, return IDE_DAEMON_ERROR, "sockFd invalid");

    mmClose(sockFd);
    sockFd = -1;
    return IDE_DAEMON_OK;
}

/**
 * @brief      call sock accept
 * @param [in] sockFd: sock Fd
 *
 * @return
 *      clientFd
 */
int32_t SockAccept(int32_t sockFd)
{
    IDE_CTRL_VALUE_FAILED(sockFd >= 0, return sockFd, "local socket failed");
    mmSockAddr clientAddr;
    (void)memset_s(&clientAddr, sizeof(clientAddr), 0, sizeof(clientAddr));
    mmSocklen_t len = sizeof(mmSockAddr);
    int32_t clientFd = mmAccept(sockFd, &clientAddr, &len);
    if (clientFd < 0) {
        char errBuf[MAX_ERRSTR_LEN + 1] = {0};
        IDE_LOGE("local socket accept failed, info : %s",
                 mmGetErrorFormatMessage(mmGetErrorCode(), errBuf, MAX_ERRSTR_LEN));
    }

    return clientFd;
}

/**
 * @brief      sock connect
 * @param [in] sockFd: sock Fd
 * @param [in] adxLocalChan: local channel string
 *
 * @return
 *      sockFd: sock fd
 *      IDE_DAEMON_ERROR: sock connect failed
 */
int32_t SockConnect(int32_t sockFd, const std::string &adxLocalChan)
{
    IDE_CTRL_VALUE_FAILED(sockFd >= 0, return IDE_DAEMON_ERROR, "local socket failed");
    IDE_CTRL_VALUE_FAILED(!adxLocalChan.empty(), return IDE_DAEMON_ERROR,
        "local socket failed");
    struct sockaddr_un sockAddr;
    (void)memset_s(&sockAddr, sizeof(sockAddr), 0, sizeof(sockAddr));
    int32_t ret = strcpy_s(sockAddr.sun_path + 1, sizeof(sockAddr.sun_path) - 1, adxLocalChan.c_str());
    if (ret != EOK) {
        IDE_LOGE("local socket strcpy_s failed");
        return IDE_DAEMON_ERROR;
    }

    sockAddr.sun_family = AF_LOCAL;
    ret = mmConnect(sockFd, reinterpret_cast<mmSockAddr *>(&sockAddr),
        offsetof(struct sockaddr_un, sun_path) + 1 + adxLocalChan.size());
    if (ret < 0) {
        IDE_LOGE("local socket connect failed");
        return IDE_DAEMON_ERROR;
    }

    IDE_LOGI("SockConnect ret: %d, sockFd: %d", ret, sockFd);
    return sockFd;
}

/**
 * @brief      sock hal read
 * @param [in] fd: file descriptor
 * @param [in] readBuf: read buffer
 * @param [in] recvLen: receive length
 * @param [in] flag: read flag
 *
 * @return
 *      recvLen: receive length
 *      IDE_DAEMON_ERROR: sock hal read failed
 */
static uint32_t SockHalRead(int32_t fd, IdeBuffT readBuf, int32_t recvLen, int32_t flag)
{
    if (fd < 0 || readBuf == nullptr || recvLen <= 0) {
        return IDE_DAEMON_ERROR;
    }

    int32_t remainLen = recvLen;
    do {
        int32_t len = mmSocketRecv(fd, readBuf, remainLen, flag);
        IDE_LOGI("sock %d recv length %d, %d", fd, len, remainLen);
        if (len < 0 && mmGetErrorCode() == EINTR) {
            continue;
        } else if (len < 0) {
            char errBuf[MAX_ERRSTR_LEN + 1] = {0};
            IDE_LOGE("sock recv error, info : %s", mmGetErrorFormatMessage(mmGetErrorCode(), errBuf, MAX_ERRSTR_LEN));
            return IDE_DAEMON_ERROR;
        }

        remainLen -= len;
    } while (remainLen > 0);

    return static_cast<uint32_t>(recvLen);
}

/**
 * @brief      check msg valid
 * @param [in] proto: msg proto
 *
 * @return
 *      true: msg is valid
 *      false: msg is invalid
 */
static bool CheckMsgValid(const MsgProto &proto)
{
    if (proto.headInfo != ADX_PROTO_MAGIC_VALUE) {
        return false;
    }

    if (proto.totalLen > INT32_MAX - sizeof(MsgProto)) {
        return false;
    }

    return true;
}

/**
 * @brief      sock proto read
 * @param [in] fd: file descriptor
 * @param [in] readBuf: read buffer
 * @param [in] recvLen: receive length
 * @param [in] flag: read flag
 *
 * @return
 *      recvTotalLen: receive total length
 *      IDE_DAEMON_ERROR: sock proto read failed
 */
static int32_t SockProtoRead(int32_t fd, IdeRecvBuffT readBuf, IdeI32Pt recvLen, int32_t flag)
{
    MsgProto proto;
    (void)memset_s(&proto, sizeof(proto), 0, sizeof(proto));
    if (SockHalRead(fd, static_cast<IdeBuffT>(&proto), sizeof(MsgProto), flag) != sizeof(MsgProto)) {
        IDE_LOGE("sock recv proto head error");
        return IDE_DAEMON_ERROR;
    }

    if (CheckMsgValid(proto) == false) {
        IDE_LOGE("check proto head error");
        return IDE_DAEMON_ERROR;
    }

    IdeU8Pt buffer = (IdeU8Pt)ADX_SAFE_MALLOC(proto.totalLen + sizeof(MsgProto));
    if (buffer == nullptr) {
        IDE_LOGE("check proto malloc error");
        return IDE_DAEMON_ERROR;
    }

    int32_t recvTotalLen = proto.totalLen + sizeof(MsgProto);
    int ret = memcpy_s(buffer, recvTotalLen, &proto, sizeof(MsgProto));
    IDE_LOGI("recvTotalLen: %d, sizeof(MsgProto): %zu", recvTotalLen, sizeof(MsgProto));
    if (ret != EOK) {
        IDE_LOGE("check memcpy_s head error");
        ADX_SAFE_FREE(buffer);
        return IDE_DAEMON_ERROR;
    }

    if (proto.totalLen != 0) {
        if (SockHalRead(fd, buffer + sizeof(MsgProto), proto.totalLen, flag) != proto.totalLen) {
            IDE_LOGE("sock recv proto body error");
            ADX_SAFE_FREE(buffer);
            return IDE_DAEMON_ERROR;
        }
    }
    *readBuf = buffer;
    *recvLen = recvTotalLen;
    return recvTotalLen;
}

/**
 * @brief      sock read
 * @param [in] fd: file descriptor
 * @param [in] readBuf: read buffer
 * @param [in] recvLen: receive length
 * @param [in] flag: read flag
 *
 * @return
 *      IDE_DAEMON_OK: sock read success
 *      IDE_DAEMON_ERROR: sock read failed
 */
int32_t SockRead(int32_t fd, IdeRecvBuffT readBuf, IdeI32Pt recvLen, int32_t flag)
{
    if (fd < 0 || readBuf == nullptr || recvLen == nullptr) {
        return IDE_DAEMON_ERROR;
    }

    if (SockProtoRead(fd, readBuf, recvLen, flag) < 0) {
        return IDE_DAEMON_ERROR;
    }
    return IDE_DAEMON_OK;
}

/**
 * @brief      sock hal write
 * @param [in] fd: file descriptor
 * @param [in] writeBuf: write buffer
 * @param [in] writeLen: receive length
 * @param [in] flag: write flag
 *
 * @return
 *      len: return len of mmSocketSend
 */
static int32_t SockHalWrite(int32_t fd, IdeSendBuffT writeBuf, int32_t writeLen, int32_t flag)
{
    int32_t len = 0;
    do {
        len = mmSocketSend(fd, const_cast<IdeBuffT>(writeBuf), writeLen, flag);
    } while (len < 0 && mmGetErrorCode() == EINTR);
    return len;
}

/**
 * @brief      sock write
 * @param [in] fd: file descriptor
 * @param [in] writeBuf: write buffer
 * @param [in] writeLen: receive length
 * @param [in] flag: write flag
 *
 * @return
 *      IDE_DAEMON_OK: sock write success
 *      IDE_DAEMON_ERROR: sock write failed
 */
int32_t SockWrite(int32_t fd, IdeSendBuffT writeBuf, int32_t len, int32_t flag)
{
    if (fd < 0 || writeBuf == nullptr || len <= 0) {
        return IDE_DAEMON_ERROR;
    }

    if (SockHalWrite(fd, writeBuf, len, flag) < 0) {
        return IDE_DAEMON_ERROR;
    }
    return IDE_DAEMON_OK;
}

/**
 * @brief      sock close for server accept
 * @param [in] sockFd: sock file descriptor
 *
 * @return
 *      ret: return val of mmClose
 *      IDE_DAEMON_ERROR: sockFd invalid
 */
int32_t SockClose(int32_t &sockFd)
{
    if (sockFd < 0) {
        return IDE_DAEMON_ERROR;
    }

    int32_t ret = mmClose(sockFd);
    sockFd = -1;
    return ret;
}