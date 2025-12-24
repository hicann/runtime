/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "log_drv.h"
#include "securec.h"
#include "driver_api.h"
#include "log_common.h"
#include "log_system_api.h"
#include "log_print.h"

#define HDC_RECV_MAX_LEN 524288 // 512KB buffer space
#define DATA_LAST_PACKET 1

enum LogPackageType {
    LOG_LITTLE_PACKAGE = 0xB0,
    LOG_BIG_PACKAGE
};

typedef struct {
    unsigned int dataLen;
    enum LogPackageType type;
    char isLast;
    char data[0];
} DataPacket;

typedef struct {
    const char *buf;
    size_t bufLen;
    size_t maxSendLen;
} DataSendMsg;

#define FREE_HDC_MSG_BUF(ptr) do {                    \
    if ((ptr) != NULL) {                                \
        (void)LogdrvHdcFreeMsg((struct drvHdcMsg *)(ptr)); \
        (ptr) = NULL;                                   \
    }                                                 \
} while (0)


int DrvSessionRelease(HDC_SESSION session)
{
    ONE_ACT_WARN_LOG(session == NULL, return -1, "[input] session is null.");

    hdcError_t drvErr = LogdrvHdcSessionClose(session);
    ONE_ACT_ERR_LOG(drvErr != DRV_ERROR_NONE, return -1, "close session failed, drvErr=%d, strerr=%s.",
                    (int32_t)drvErr, strerror(ToolGetErrorCode()));

    return 0;
}

int DrvDevIdGetBySession(HDC_SESSION session, int attr, int *value)
{
    ONE_ACT_NO_LOG((session == NULL) || (value == NULL), return -1);

    int temp = 0;

    hdcError_t drvErr = LogdrvHdcGetSessionAttr(session, attr, &temp);
    ONE_ACT_WARN_LOG(drvErr != DRV_ERROR_NONE, return -1, "can not get session attr, drvErr=%d, strerr=%s.",
                    (int32_t)drvErr, strerror(ToolGetErrorCode()));

    *value = temp;
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
        drvErr = LogdrvHdcSend(session, msg, 0, 0);
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

    DataPacket *packet = (DataPacket *)calloc(1, packetSize * sizeof(char));
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
