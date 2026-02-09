/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <list>
#include "securec.h"
#include "mmpa_api.h"
#include "log/adx_log.h"
#include "common/memory_utils.h"
#include "common/config.h"
#include "ide_os_type.h"
#include "hdc_api.h"

#define IDE_FREE_HDC_MSG_AND_SET_NULL(ptr) do {                        \
    if ((ptr) != nullptr) {                                            \
        (void)drvHdcFreeMsg(ptr);                                            \
        ptr = nullptr;                                                 \
    }                                                                  \
} while (0)

using namespace IdeDaemon::Common::Config;

namespace Adx {
struct DataSendMsg {
    IdeSendBuffT buf;
    int32_t bufLen;
    uint32_t maxSendLen;
};

/**
 * @brief initial HDC client
 * @param client: HDC initialization handle
 *
 * @return
 *      IDE_DAEMON_OK:    init succ
 *      IDE_DAEMON_ERROR: init failed
 */
int32_t HdcClientInit(HDC_CLIENT *client)
{
    UNUSED(client);
    return IDE_DAEMON_ERROR;
}

/**
 * @brief       crete HDC client
 * @param [in]  client : HDC initialization handle
 * @param [in]  type   : create client hdc service type
 * @return
 *      IDE_DAEMON_OK:    init succ
 *      IDE_DAEMON_ERROR: init failed
 */
HDC_CLIENT HdcClientCreate(drvHdcServiceType type)
{
    UNUSED(type);
    return nullptr;
}

/**
 * @brief       destroy HDC client
 * @param [in]  client: HDC handle
 *
 * @return
 *      IDE_DAEMON_OK:    destroy succ
 *      IDE_DAEMON_ERROR: destroy failed
 */
int32_t HdcClientDestroy(HDC_CLIENT client)
{
    UNUSED(client);
    return IDE_DAEMON_ERROR;
}

HDC_SERVER HdcServerCreate(int32_t logDevId, drvHdcServiceType type)
{
    UNUSED(logDevId);
    UNUSED(type);
    return nullptr;
}

/**
 * @brief      destroy HDC server
 * @param [in] server: HDC server handle
 *
 * @return
 *      IDE_DAEMON_OK:    destroy succ
 *      IDE_DAEMON_ERROR: destroy failed
 */
int32_t HdcServerDestroy(HDC_SERVER server)
{
    UNUSED(server);
    return IDE_DAEMON_ERROR;
}

HDC_SESSION HdcServerAccept(HDC_SERVER server)
{
    UNUSED(server);
    return nullptr;
}

/**
 * @brief get packet to recv_buf
 * @param packet: HDC packet
 * @param ioVec: a buffer that stores the result
 *
 * @return
 *      IDE_DAEMON_OK:    store data succ
 *      IDE_DAEMON_ERROR: store data failed
 */
int32_t HdcStorePackage(const IdeHdcPacket &packet, struct IoVec &ioVec)
{
    UNUSED(packet);
    UNUSED(ioVec);
    return IDE_DAEMON_ERROR;
}

/**
 * @brief get data from hdc session
 * @param session: HDC session
 * @param recv_buf: a buffer that stores the result
 * @param recv_len: the length of recv_buf
 * @param nb_flag: IDE_DAEMON_HDC_BLOCK: read by block mode; IDE_DAEMON_HDC_NOBLOCK: read by non-block mode
 *
 * @return
 *      IDE_DAEMON_OK:    read succ
 *      IDE_DAEMON_ERROR: read failed
 */
static int32_t HdcSessionRead(HDC_SESSION session, const IdeRecvBuffT recvBuf, const IdeI32Pt recvLen, int32_t nbFlag,
    uint32_t timeout)
{
    UNUSED(session);
    UNUSED(timeout);
    UNUSED(recvBuf);
    UNUSED(recvLen);
    UNUSED(nbFlag);
    return IDE_DAEMON_ERROR;
}

/**
 * @brief get data from hdc session by block mode
 * @param session: HDC session
 * @param recv_buf: a buffer that stores the result
 * @param recv_len: the length of recv_buf
 *
 * @return
 *      IDE_DAEMON_OK:    read succ
 *      IDE_DAEMON_ERROR: read failed
 */
int32_t HdcRead(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    return HdcSessionRead(session, recvBuf, recvLen, IDE_DAEMON_BLOCK, 0);
}

/**
 * @brief get data from hdc session by non-block mode
 * @param session: HDC session
 * @param recv_buf: a buffer that stores the result
 * @param recv_len: the length of recv_buf
 *
 * @return
 *      IDE_DAEMON_OK:    read succ
 *      IDE_DAEMON_ERROR: read failed
 */
int32_t HdcReadNb(HDC_SESSION session, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    return HdcSessionRead(session, recvBuf, recvLen, IDE_DAEMON_NOBLOCK, 0);
}

/**
 * @brief get data from hdc session by non-block mode
 * @param session: HDC session
 * @param timeout: max wait time
 * @param recv_buf: a buffer that stores the result
 * @param recv_len: the length of recv_buf
 *
 * @return
 *      IDE_DAEMON_OK:    read succ
 *      IDE_DAEMON_ERROR: read failed
 */
int32_t HdcReadTimeout(HDC_SESSION session, uint32_t timeout, IdeRecvBuffT recvBuf, IdeI32Pt recvLen)
{
    return HdcSessionRead(session, recvBuf, recvLen, IDE_DAEMON_TIMEOUT, timeout);
}

/**
 * @brief write data by hdc session
 * @param session: HDC session
 * @param buf: a buffer that store data to send
 * @param len: the length of buffer
 *
 * @return
 *      IDE_DAEMON_OK:    write succ
 *      IDE_DAEMON_ERROR: write failed
 */
int32_t HdcSessionWrite(HDC_SESSION session, IdeSendBuffT buf, int32_t len, int32_t flag)
{
    UNUSED(session);
    UNUSED(buf);
    UNUSED(len);
    UNUSED(flag);
    return IDE_DAEMON_ERROR;
}

/**
 * @brief write data by hdc session
 * @param session: HDC session
 * @param buf: a buffer that store data to send
 * @param len: the length of buffer
 *
 * @return
 *      IDE_DAEMON_OK:    write succ
 *      IDE_DAEMON_ERROR: write failed
 */
int32_t HdcWrite(HDC_SESSION session, IdeSendBuffT buf, int32_t len)
{
    return HdcSessionWrite(session, buf, len, IDE_DAEMON_BLOCK);
}

/**
 * @brief write data by hdc session
 * @param session: HDC session
 * @param buf: a buffer that store data to send
 * @param len: the length of buffer
 *
 * @return
 *      IDE_DAEMON_OK:    write succ
 *      IDE_DAEMON_ERROR: write failed
 */
int32_t HdcWriteNb(HDC_SESSION session, IdeSendBuffT buf, int32_t len)
{
    return HdcSessionWrite(session, buf, len, IDE_DAEMON_NOBLOCK);
}

/**
 * @brief connect remote hdc server
 * @param peer_node: Node number of the node where Device is located
 * @param peer_devid: Device ID of the unified number in the host
 * @param client: HDC Client handle corresponding to the newly created Session
 * @param session: created session
 *
 * @return
 *      IDE_DAEMON_OK:    connect succ
 *      IDE_DAEMON_ERROR: connect failed
 */
int32_t HdcSessionConnect(int32_t peerNode, int32_t peerDevId, HDC_CLIENT client, HDC_SESSION *session)
{
    UNUSED(peerNode);
    UNUSED(peerDevId);
    UNUSED(client);
    UNUSED(session);
    return IDE_DAEMON_ERROR;
}

/**
 * @brief connect remote hal hdc server
 * @param peer_node: Node number of the node where Device is located
 * @param peer_devid: Device ID of the unified number in the host
 * @param host_pid: pid of host app process
 * @param client: HDC Client handle corresponding to the newly created Session
 * @param session: created session
 *
 * @return
 *      IDE_DAEMON_OK:    connect succ
 *      IDE_DAEMON_ERROR: connect failed
 */
int32_t HalHdcSessionConnect(int32_t peerNode, int32_t peerDevId,
    int32_t hostPid, HDC_CLIENT client, HDC_SESSION *session)
{
    UNUSED(peerNode);
    UNUSED(peerDevId);
    UNUSED(hostPid);
    UNUSED(client);
    UNUSED(session);
    return IDE_DAEMON_ERROR;
}


/**
 * @brief destroy hdc_connect session
 * @param session: the session created by hdc connect
 *
 * @return
 *      IDE_DAEMON_OK:    destroy succ
 *      IDE_DAEMON_ERROR: destroy failed
 */
int32_t HdcSessionDestroy(HDC_SESSION session)
{
    return HdcSessionClose(session);
}

/**
 * @brief destroy hdc_accpet session
 * @param session: the session created by hdc_accept
 *
 * @return
 *      IDE_DAEMON_OK:    close succ
 *      IDE_DAEMON_ERROR: close failed
 */
int32_t HdcSessionClose(HDC_SESSION session)
{
    UNUSED(session);
    return IDE_DAEMON_ERROR;
}

/**
 * @brief get hdc capacity
 * @param segment: hdc max segment size
 *
 * @return
 *      IDE_DAEMON_OK:    read succ
 *      IDE_DAEMON_ERROR: read failed
 */
int32_t HdcCapacity(IdeU32Pt segment)
{
    UNUSED(segment);
    return IDE_DAEMON_ERROR;
}

/**
 * @brief get device id by HDC session
 * @param session: hdc session handle
 *
 * @return
 *      IDE_DAEMON_OK:    get hdc session succ
 *      IDE_DAEMON_ERROR: get hdc session failed
 */
int32_t IdeGetDevIdBySession(HDC_SESSION session, IdeI32Pt devId)
{
    UNUSED(session);
    UNUSED(devId);
    return IDE_DAEMON_ERROR;
}

/**
 * @brief get env info by HDC session, is docker or not
 * @param session: hdc session handle
 * @param runEnv: 1 non-docker 2 docker
 *
 * @return
 *      IDE_DAEMON_OK:    get hdc session succ
 *      IDE_DAEMON_ERROR: get hdc session failed
 */
int32_t IdeGetRunEnvBySession(HDC_SESSION session, IdeI32Pt runEnv)
{
    UNUSED(session);
    UNUSED(runEnv);
    return IDE_DAEMON_ERROR;
}

/**
 * @brief get vfid by HDC session
 * @param session: hdc session handle
 *
 * @return
 *      IDE_DAEMON_OK:    get hdc session succ
 *      IDE_DAEMON_ERROR: get hdc session failed
 */
int32_t IdeGetVfIdBySession(HDC_SESSION session, IdeI32Pt vfId)
{
    UNUSED(session);
    UNUSED(vfId);
    return IDE_DAEMON_ERROR;
}

/**
 * @brief get pid info by HDC session
 * @param session: hdc session handle
 * @param pid: app pid
 *
 * @return
 *      IDE_DAEMON_OK:    get hdc session succ
 *      IDE_DAEMON_ERROR: get hdc session failed
 */
int32_t IdeGetPidBySession(HDC_SESSION session, IdeI32Pt pid)
{
    UNUSED(session);
    UNUSED(pid);
    return IDE_DAEMON_ERROR;
}

 /**
 * @brief       : get attribute value by HDC session and attribute type
 * @param [in]  : handle    hdc session
 * @param [in]  : attr      attribute type
 * @param [out] : value     attribute value
 * @return      : IDE_DAEMON_OK succeed; IDE_DAEMON_ERROR failed
 */
int32_t IdeGetAttrBySession(HDC_SESSION session, int32_t attr, IdeI32Pt value)
{
    UNUSED(session);
    UNUSED(attr);
    UNUSED(value);
    return IDE_DAEMON_ERROR;
}
}