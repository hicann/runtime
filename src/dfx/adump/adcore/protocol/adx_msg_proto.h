/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADX_MSG_PROTO_H
#define ADX_MSG_PROTO_H
#include <cstdint>
#include <string>
#include "ide_tlv.h"
#include "adump_device_pub.h"
#include "adx_msg.h"
#include "extra_config.h"
#include "adx_service_config.h"
namespace Adx {
using MsgCode = IdeErrorT;
class AdxMsgProto {
public:
    static MsgProto *CreateMsgPacket(CmdClassT type, uint16_t devId, IdeSendBuffT data, uint32_t length);
    static MsgProto *CreateDataMsg(IdeSendBuffT data, uint32_t length);
    static int32_t CreateCtrlMsg(MsgProto &proto, MsgStatus status);
    static MsgCode SendMsgData(const CommHandle &handle, CmdClassT type, MsgStatus status,
        IdeSendBuffT data, uint32_t length);
    static MsgCode GetStringMsgData(const CommHandle &handle, std::string &value);
    static MsgCode SendEventFile(const CommHandle &handle, CmdClassT type, uint16_t devId, int32_t fd);
    static MsgCode SendFile(const CommHandle &handle, CmdClassT type, uint16_t devId, int32_t fd);
    static MsgCode RecvFile(const CommHandle &handle, int32_t fd);
    static MsgCode HandShake(const CommHandle &handle, CmdClassT type, uint16_t devId);
    static MsgCode SendResponse(const CommHandle &handle, uint16_t type, uint16_t devId, MsgStatus status);
    static MsgCode RecvResponse(const CommHandle &handle);
private:
    static MsgProto *CreateMsgByType(MsgType type, IdeSendBuffT data, uint32_t length);
};
}
#endif // ADX_PROTOCOL_H
