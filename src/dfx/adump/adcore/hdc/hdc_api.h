/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef IDE_HDC_API_H
#define IDE_HDC_API_H
#include "ascend_hal.h"
#include "extra_config.h"

namespace Adx {
enum class IdeDaemonPackageType {
    IDE_DAEMON_LITTLE_PACKAGE = 0xB0,
    IDE_DAEMON_BIG_PACKAGE
};

enum class IdeLastPacket:int8_t {
    IDE_NOT_LAST_PACK = 0,
    IDE_LAST_PACK = 1
};

struct IdeHdcPacket {
    uint32_t len;
    IdeDaemonPackageType type;     // package type : big package,little package
    IdeLastPacket isLast;                 // only 0:is not last package; 1:last package
    char value[0];
};

int32_t HdcClientInit(HDC_CLIENT *client);

struct IoVec {
    IdeBuffT base;
    uint32_t len;
};

HDC_CLIENT HdcClientCreate(enum drvHdcServiceType type);
int32_t HdcClientDestroy(HDC_CLIENT client);
HDC_SERVER HdcServerCreate(int32_t logDevId, enum drvHdcServiceType type);
int32_t HdcServerDestroy(HDC_SERVER server);
HDC_SESSION HdcServerAccept(HDC_SERVER server);

/**
 * @brief Interface for receiving data based on HDC sessions.
 * @param [in]  session : specifies session in used
 * @param [out]  recvBuf : buffer for receiving data
 * @param [out]  recvLen : length of read data
 * @return
 *      IDE_DAEMON_OK:    read data success
 *      IDE_DAEMON_ERROR: read data failed
 */
int32_t HdcRead(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen);

/**
 * @brief Receives data based on HDC sessions in non-blocking mode.
 * @param [in]  session : specifies session in used
 * @param [out]  recvBuf : buffer for receiving data
 * @param [out]  recvLen : length of read data
 * @return
 *      IDE_DAEMON_OK:    read data success
 *      IDE_DAEMON_ERROR: read data failed
 */
int32_t HdcReadNb(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen);

/**
 * @brief Receives data based on HDC sessions in timout mode.
 * @param [in]  session : specifies session in used
 * @param [in]  timeout : max wait time
 * @param [out]  recvBuf : buffer for receiving data
 * @param [out]  recvLen : length of read data
 * @return
 *      IDE_DAEMON_OK:    read data success
 *      IDE_DAEMON_ERROR: read data failed
 */
int32_t HdcReadTimeout(HDC_SESSION session, uint32_t timeout, IdeRecvBuffT recvBuf, IdeI32Pt recvLen);

/**
 * @brief Interface for sending data Based on HDC Session.
 * @param [in]  session : specifies session in used
 * @param [in]  buf : buffer for sending data
 * @param [in]  recvLen : length of data to be send
 * @return
 *      IDE_DAEMON_OK:    send data success
 *      IDE_DAEMON_ERROR: send data failed
 */
int32_t HdcWrite(HDC_SESSION session, IdeSendBuffT buf, int32_t len);

/**
 * @brief Interface for sending data Based on HDC Session in non-blocking mode.
 * @param [in]  session : specifies session in used
 * @param [in]  buf : buffer for sending data
 * @param [in]  recvLen : length of data to be sent
 * @return
 *      IDE_DAEMON_OK:    send data success
 *      IDE_DAEMON_ERROR: send data failed
 */
int32_t HdcWriteNb(HDC_SESSION session, IdeSendBuffT buf, int32_t len);

/**
 * @brief connect remote hdc server
 * @param [in]  peerNode: Node number of the node where Device is located
 * @param [in]  peerDevId: Device ID of the unified number in the host
 * @param [in]  client: HDC Client handle corresponding to the newly created Session
 * @param [out]  session: created session
 *
 * @return
 *      IDE_DAEMON_OK:    connect succ
 *      IDE_DAEMON_ERROR: connect failed
 */
int32_t HdcSessionConnect(int32_t peerNode, int32_t peerDevId,
    HDC_CLIENT client, HDC_SESSION *session);

/**
 * @brief connect remote hal hdc server
 * @param [in]  peerNode : Node number of the node where Device is located
 * @param [in]  peerDevId : Device ID of the unified number in the host
 * @param [in]  hostPid : pid of host app process
 * @param [in]  client : HDC Client handle corresponding to the newly created Session
 * @param [out]  session : created session
 * @return
 *      IDE_DAEMON_OK:    connect success
 *      IDE_DAEMON_ERROR: connect failed
 */
int32_t HalHdcSessionConnect(int32_t peerNode, int32_t peerDevId,
    int32_t hostPid, HDC_CLIENT client, HDC_SESSION *session);

/**
 * @brief Destroy an HDC session (Client).
 * @param [in]  session : sessions to be released
 * @return
 *      IDE_DAEMON_OK:    destroy session success
 *      IDE_DAEMON_ERROR: destroy session failed
 */
int32_t HdcSessionDestroy(HDC_SESSION session);

/**
 * @brief releasing an HDC session (Client).
 * @param [in]  session : sessions to be released
 * @return
 *      IDE_DAEMON_OK:    release session success
 *      IDE_DAEMON_ERROR: release session failed
 */
int32_t HdcSessionClose(HDC_SESSION session);

/**
 * @brief get hdc capacity
 * @param segment: hdc max segment size
 * @return
 *      IDE_DAEMON_OK:    read succ
 *      IDE_DAEMON_ERROR: read failed
 */
int32_t HdcCapacity(IdeU32Pt segment);
int32_t IdeGetDevIdBySession(HDC_SESSION session, IdeI32Pt devId);
int32_t IdeGetRunEnvBySession(HDC_SESSION session, IdeI32Pt runEnv);
int32_t IdeGetVfIdBySession(HDC_SESSION session, IdeI32Pt vfId);
int32_t IdeGetPidBySession(HDC_SESSION session, IdeI32Pt pid);
int32_t IdeGetAttrBySession(HDC_SESSION session, int32_t attr, IdeI32Pt value);
int32_t HdcSessionWrite(HDC_SESSION session, IdeSendBuffT buf, int32_t len, int32_t flag);
int32_t HdcStorePackage(const IdeHdcPacket &packet, struct IoVec &ioVec);
}

#endif
