/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef COMMON_COMMON_INC_MSG_PARSE_REG_H
#define COMMON_COMMON_INC_MSG_PARSE_REG_H

#include "proto/tsd_message.pb.h"
#include "inc/message_parse_client.h"
#include "inc/message_parse_server.h"

namespace tsd {
    class MsgParseReg {
    public:
        explicit MsgParseReg(const HDCMessage::MsgType type, ParseFuncType const func) noexcept
        {
#ifdef TDT_HOST_LIB
            MessageParseClient::GetInstance()->RegisterMsgProcess(type, func);
#else
            MessageParseServer::GetInstance()->RegisterMsgProcess(type, func);
#endif
        }

        ~MsgParseReg() = default;
    };  // class MsgParseReg


#define TDT_REGISTER_NORMAL_MSG_PARSE_FUNC(name, type, msgParseFunc)                            \
    static MsgParseReg tdtAutoMsgParse##name((type), (msgParseFunc))
}  // namespace tsd

#endif // INC_TDT_MSG_PARSE_REG_H
