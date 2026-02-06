/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "plog_drv.h"
#include "securec.h"
#include "plog_driver_api.h"
#include "log_common.h"
#include "log_system_api.h"
#include "log_print.h"

#define FREE_HDC_MSG_BUF(ptr) do {                    \
    if ((ptr) != NULL) {                                \
        (void)LogdrvHdcFreeMsg((struct drvHdcMsg *)(ptr)); \
        (ptr) = NULL;                                   \
    }                                                 \
} while (0)

STATIC uint32_t g_platform = PLATFORM_INVALID_VALUE; // 0 is device side, 1 is host side

int DrvFunctionsInit(void)
{
    return LoadDriverDllFunctions();
}

int DrvFunctionsUninit(void)
{
    return UnloadDriverDllFunctions();
}

int DrvClientCreate(HDC_CLIENT *client, int clientType)
{
    ONE_ACT_NO_LOG(client == NULL, return -1);

    HDC_CLIENT hdcClient = NULL;

    hdcError_t drvErr = LogdrvHdcClientCreate(&hdcClient, MAX_HDC_SESSION_NUM, clientType, 0);
    ONE_ACT_ERR_LOG(drvErr != DRV_ERROR_NONE, return -1, "create HDC client failed, drvErr=%d, strerr=%s.",
                    (int32_t)drvErr, strerror(ToolGetErrorCode()));
    ONE_ACT_WARN_LOG(hdcClient == NULL, return -1, "HDC client is null.");

    *client = hdcClient;
    return 0;
}

int DrvClientRelease(HDC_CLIENT client)
{
    ONE_ACT_NO_LOG(client == NULL, return 0);

    const int hdcMaxTimes = 30;
    const unsigned int hdcWaitBaseSleepTime = 100;
    int times = 0;
    hdcError_t drvErr = DRV_ERROR_NONE;

    do {
        drvErr = LogdrvHdcClientDestroy(client);
        if (drvErr != DRV_ERROR_NONE) {
            SELF_LOG_WARN("hdc client release drvErr=%d, times=%d", (int32_t)drvErr, times);
            (void)ToolSleep(hdcWaitBaseSleepTime);
        }
        times++;
    } while ((times < hdcMaxTimes) && (drvErr == DRV_ERROR_CLIENT_BUSY));

    return 0;
}

int DrvSessionInit(HDC_CLIENT client, HDC_SESSION *session, int devId)
{
    ONE_ACT_WARN_LOG(client == NULL, return -1, "[in] hdc client is null.");
    ONE_ACT_WARN_LOG(session == NULL, return -1, "[out] hdc session is null.");
    ONE_ACT_WARN_LOG((devId < 0) || (devId >= HOST_MAX_DEV_NUM), return -1, "[in] device id[%d] is invalid.", devId);

    int peerNode = 0;
    hdcError_t drvErr;
    HDC_SESSION hdcSession = NULL;

    drvErr = LogdrvHdcSessionConnect(peerNode, devId, client, &hdcSession);
    ONE_ACT_ERR_LOG(drvErr != DRV_ERROR_NONE, return -1, "create session failed, drvErr=%d, strerr=%s.",
                    (int32_t)drvErr, strerror(ToolGetErrorCode()));

    drvErr = LogdrvHdcSetSessionReference(hdcSession);
    if (drvErr != DRV_ERROR_NONE) {
        SELF_LOG_ERROR("set session reference error, drvErr=%d.", (int32_t)drvErr);
        (void)DrvSessionRelease(hdcSession);
        return -1;
    }

    *session = hdcSession;
    return 0;
}

int DrvSessionRelease(HDC_SESSION session)
{
    ONE_ACT_WARN_LOG(session == NULL, return -1, "[input] session is null.");

    hdcError_t drvErr = LogdrvHdcSessionClose(session);
    ONE_ACT_ERR_LOG(drvErr != DRV_ERROR_NONE, return -1, "close session failed, drvErr=%d, strerr=%s.",
                    (int32_t)drvErr, strerror(ToolGetErrorCode()));

    return 0;
}

int DrvGetPlatformInfo(unsigned int *info)
{
    ONE_ACT_NO_LOG(info == NULL, return -1);

    if ((g_platform == HOST_SIDE) || (g_platform == DEVICE_SIDE)) {
        *info = g_platform;
        return 0;
    }

    unsigned int platform = PLATFORM_INVALID_VALUE;

    hdcError_t drvErr = LogdrvGetPlatformInfo(&platform);
    ONE_ACT_ERR_LOG(drvErr != DRV_ERROR_NONE, return -1, "get platform info failed, drvErr=%d.", (int32_t)drvErr);
    if (platform != PLATFORM_INVALID_VALUE) {
        ONE_ACT_WARN_LOG((platform != DEVICE_SIDE) && (platform != HOST_SIDE), return -1,
                         "platform info %u is invaild.", platform);
    }
    *info = platform;
    g_platform = platform;
    return 0;
}

int DrvGetDevNum(unsigned int *num)
{
    unsigned int devNum = 0;
    drvError_t drvErr = LogdrvGetDevNum(&devNum);
    ONE_ACT_ERR_LOG(drvErr != DRV_ERROR_NONE, return -1, "can not get deivce number, drvErr=%d.", (int32_t)drvErr);

    *num = devNum;
    return 0;
}

/**
* @brief DrvCapacityInit: get capacity by hdc alloc
* @param [out]segment: capacity size
* @return: 0: success, -1: failed
*/
static int DrvCapacityInit(size_t *segment)
{
    ONE_ACT_NO_LOG(segment == NULL, return -1);

    struct drvHdcCapacity capacity = { HDC_CHAN_TYPE_MAX, 0 };

    hdcError_t drvErr = LogdrvHdcGetCapacity(&capacity);
    ONE_ACT_ERR_LOG(drvErr != DRV_ERROR_NONE, return -1, "alloc HDC capacity failed, drvErr=%d", (int32_t)drvErr);
    ONE_ACT_WARN_LOG((capacity.maxSegment == 0) || (capacity.maxSegment > HDC_RECV_MAX_LEN), return -1,
                     "HDC capacity invalid, size=%u.", capacity.maxSegment);

    *segment = capacity.maxSegment;
    return 0;
}

/**
* @brief DrvPackageWrite: subcontract and send msg to peer end
* @param [in]session: connection session
* @param [in]sendMsg: send msg info
* @param [in]packet: packet buffer
* @return: 0: success, -1: failed
*/
static int DrvPackageWrite(HDC_SESSION session, DataSendMsg sendMsg, DataPacket *packet)
{
    hdcError_t drvErr;
    struct drvHdcMsg *msg = NULL;
    uint32_t reservedLen = (uint32_t)sendMsg.bufLen;

    packet->isLast = (~DATA_LAST_PACKET);
    packet->dataLen = (uint32_t)sendMsg.maxSendLen - 1U;
    packet->type = LOG_LITTLE_PACKAGE;

    // alloc one hdc message for receiving
    drvErr = LogdrvHdcAllocMsg(session, &msg, 1);
    ONE_ACT_ERR_LOG(drvErr != DRV_ERROR_NONE, return -1, "alloc msg failed, drvErr=%d.", (int32_t)drvErr);
    ONE_ACT_WARN_LOG(msg == NULL, return -1, "HDC msg is null.");

    do {
        // if msg is bigger than max packet size, need to subcontract and send
        if (reservedLen < sendMsg.maxSendLen) {
            packet->dataLen = reservedLen;
            packet->isLast = DATA_LAST_PACKET;
        }

        // copy data to packet
        unsigned int offset = (unsigned int)(sendMsg.bufLen - reservedLen);
        int ret = memcpy_s(packet->data, sendMsg.maxSendLen, sendMsg.buf + offset, packet->dataLen);
        ONE_ACT_ERR_LOG(ret != EOK, goto WRITE_ERROR, "memory copy failed, strerr=%s.", strerror(ToolGetErrorCode()));

        // add buffer to hdc message descriptor
        drvErr = LogdrvHdcAddMsgBuffer(msg, (char *)packet, (int32_t)(sizeof(DataPacket) + packet->dataLen));
        ONE_ACT_ERR_LOG(drvErr != DRV_ERROR_NONE, goto WRITE_ERROR,
                        "add buffer to HDC msg failed, drvErr=%d.", (int32_t)drvErr);

        // send hdc message
        const uint32_t sendTimeout = 150U * 1000U; // 150s
        const uint64_t sendFlag = 2U; // means HDC_FLAG_WAIT_TIMEOUT
        drvErr = LogdrvHdcSend(session, msg, sendFlag, sendTimeout);
        ONE_ACT_ERR_LOG(drvErr != DRV_ERROR_NONE, goto WRITE_ERROR,
                        "HDC send failed, drvErr=%d.", (int32_t)drvErr);

        // reuse message descriptor
        drvErr = LogdrvHdcReuseMsg(msg);
        ONE_ACT_ERR_LOG(drvErr != DRV_ERROR_NONE, goto WRITE_ERROR,
                        "reuse HDC msg failed, drvErr=%d.", (int32_t)drvErr);

        reservedLen -= packet->dataLen;
    } while ((reservedLen > 0) && (drvErr == DRV_ERROR_NONE));

    FREE_HDC_MSG_BUF(msg);
    return 0;

WRITE_ERROR:
    FREE_HDC_MSG_BUF(msg);
    return -1;
}

int DrvBufWrite(HDC_SESSION session, const char *buf, size_t bufLen)
{
    ONE_ACT_NO_LOG((session == NULL) || (buf == NULL) || (bufLen == 0), return -1);

    size_t packetSize = 0;
    DataSendMsg sendMsg = { 0 };

    // calloc capacity
    int ret = DrvCapacityInit(&packetSize);
    ONE_ACT_NO_LOG(ret != 0, return -1);
    if ((bufLen + sizeof(DataPacket)) < packetSize) {
        packetSize = bufLen + sizeof(DataPacket) + 1U;
    }

    DataPacket *packet = (DataPacket *)LogMalloc(packetSize);
    // cppcheck-suppress *
    ONE_ACT_ERR_LOG(packet == NULL, return -1, "calloc %zu size failed, strerr=%s.",
                    packetSize, strerror(ToolGetErrorCode()));

    // write buffer to hdc
    sendMsg.buf = buf;
    sendMsg.bufLen = bufLen;
    sendMsg.maxSendLen = packetSize - sizeof(DataPacket);
    ret = DrvPackageWrite(session, sendMsg, packet);

    XFREE(packet);
    return ret;
}

/**
* @brief CopyBufData: add packet data to buf, buf may be not empty, need to realloc new memory and copy
* @param [in]packet: recv packet data
* @param [out]buf: recv buffer
* @param [out]bufLen: recv buffer length
* @return: 0: success, -1: failed
*/
static int CopyBufData(const DataPacket *packet, char **buf, unsigned int *bufLen)
{
    int ret;
    unsigned int newLen;

    newLen = packet->dataLen + *bufLen;
    char *tempBuf = (char *)LogMalloc(newLen + 1U);
    ONE_ACT_ERR_LOG(tempBuf == NULL, goto COPY_ERROR, "calloc failed, strerr=%s.", strerror(ToolGetErrorCode()));

    if ((*buf != NULL) && (*bufLen != 0)) {
        ret = memcpy_s(tempBuf, newLen, *buf, *bufLen);
        ONE_ACT_ERR_LOG(ret != 0, goto COPY_ERROR, "copy data failed, strerr=%s.", strerror(ToolGetErrorCode()));
    }

    ret = memcpy_s(tempBuf + *bufLen, newLen, packet->data, packet->dataLen);
    ONE_ACT_ERR_LOG(ret != 0, goto COPY_ERROR, "copy data failed, strerr=%s.", strerror(ToolGetErrorCode()));

    XFREE(*buf);
    *buf = tempBuf;
    *bufLen = newLen;
    return 0;

COPY_ERROR:
    XFREE(tempBuf);
    return -1;
}

/**
* @brief DrvPackageRead: subcontract and send msg to peer end
* @param [in]session: connection session
* @param [in]buf: send msg info
* @param [in]bufLen: packet buffer
* @return: 0: success, -1: failed
*/
static hdcError_t DrvPackageRead(HDC_SESSION session, char **buf, unsigned int *bufLen,
                                 UINT64 flag, unsigned int timeout)
{
    hdcError_t drvErr;
    int bufCount = 0; // receive buffer count
    short isLast = (~DATA_LAST_PACKET); // last packet flag
    struct drvHdcMsg *msg = NULL;

    // alloc hdc msg
    drvErr = LogdrvHdcAllocMsg(session, &msg, 1);
    ONE_ACT_ERR_LOG(drvErr != DRV_ERROR_NONE, return drvErr, "alloc msg failed, drvErr=%d.", (int32_t)drvErr);
    ONE_ACT_WARN_LOG(msg == NULL, return drvErr, "HDC msg is null.");

    while (isLast != DATA_LAST_PACKET) {
        // receive data from hdc
        drvErr = LogdrvHdcRecv(session, (struct drvHdcMsg *)msg, HDC_RECV_MAX_LEN, flag, &bufCount, timeout);
        ONE_ACT_NO_LOG(drvErr != DRV_ERROR_NONE, goto READ_ERROR);

        // parse hdc recv msg to buffer
        char *pBuf = NULL; // get buffer data from msg
        int pBufLen = 0; // get buffer data length from msg
        drvErr = LogdrvHdcGetMsgBuffer(msg, 0, &pBuf, &pBufLen);
        ONE_ACT_ERR_LOG((drvErr != DRV_ERROR_NONE) || (pBuf == NULL), goto READ_ERROR,
                        "get HDC msg buffer failed, drvErr=%d.", (int32_t)drvErr);

        DataPacket *packet = (DataPacket *)pBuf;
        if (packet->isLast == DATA_LAST_PACKET) {
            isLast = DATA_LAST_PACKET;
        }
        // save recv data to buf
        ONE_ACT_NO_LOG(CopyBufData(packet, buf, bufLen) != 0, goto READ_ERROR);

        // reuse message descriptor
        drvErr = LogdrvHdcReuseMsg(msg);
        ONE_ACT_ERR_LOG(drvErr != DRV_ERROR_NONE, goto READ_ERROR, "reuse HDC msg failed, drvErr=%d.", (int32_t)drvErr);
    }
    FREE_HDC_MSG_BUF(msg);
    return DRV_ERROR_NONE;

READ_ERROR:
    FREE_HDC_MSG_BUF(msg);
    XFREE(*buf);
    return drvErr;
}

LogStatus DrvBufRead(HDC_SESSION session, int devId, char **buf, unsigned int *bufLen, unsigned int timeout)
{
    ONE_ACT_NO_LOG((session == NULL) || (buf == NULL) || (bufLen == NULL), return LOG_INVALID_PARAM);
    ONE_ACT_NO_LOG((devId < 0) || (devId >= HOST_MAX_DEV_NUM), return LOG_INVALID_PARAM);

    // read by HDC
    hdcError_t drvErr = DrvPackageRead(session, buf, bufLen, HDC_FLAG_WAIT_TIMEOUT, timeout);
    if (drvErr == DRV_ERROR_SOCKET_CLOSE) {
        SELF_LOG_WARN("HDC session is closed, devId=%d.", devId);
        return LOG_SESSION_CLOSE;
    } else if (drvErr == DRV_ERROR_NON_BLOCK) {
        SELF_LOG_WARN("HDC no data, devId=%d.", devId);
        return LOG_FAILURE;
    } else if (drvErr == DRV_ERROR_WAIT_TIMEOUT) {
        return LOG_SESSION_RECV_TIMEOUT;
    } else if (drvErr != DRV_ERROR_NONE) {
        SELF_LOG_ERROR("HDC recv failed, ret=%d, devId=%d.", (int32_t)drvErr, devId);
        return LOG_FAILURE;
    } else {
        return LOG_SUCCESS;
    }
}
