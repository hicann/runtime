/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TDT_COMMON_COMMON_INC_MESSAGE_PARSE_INTERFACE_H
#define TDT_COMMON_COMMON_INC_MESSAGE_PARSE_INTERFACE_H

#include "driver/ascend_hal.h"
#include "proto/tsd_message.pb.h"

namespace tsd {
    using ParseFuncType = void (*)(const uint32_t sessionID, const tsd::HDCMessage& msg);
    class MessageParseInterface {
    public:
        /**
        * @ingroup MessageParseInterface
        * @brief 处理消息
        * @param [in]msg:消息数据
        * @return 无
        */
        void ProcessMessage(const uint32_t sessionID, const HDCMessage& msg) const;
        /**
        * @ingroup hiaiengine
        * @brief RegisterMsgProcess注册HDC消息处理函数
        * @return 无
        */
        void RegisterMsgProcess(const HDCMessage::MsgType type, const ParseFuncType func);
    protected:
        /**
        * @ingroup MessageParseInterface
        * @brief MessageParseInterface基类构造函数
        */
        MessageParseInterface();

        virtual ~MessageParseInterface() = default;

        MessageParseInterface(
            const MessageParseInterface&) = delete;
        MessageParseInterface(
            MessageParseInterface&&) = delete;
        MessageParseInterface& operator=(
            const MessageParseInterface&) = delete;
        MessageParseInterface& operator=(
            MessageParseInterface&) = delete;
        MessageParseInterface& operator=(
            MessageParseInterface&&) = delete;
    private:
        std::map<HDCMessage::MsgType, ParseFuncType> parseFuncMap_;
    };
}
#endif  // TDT_COMMON_COMMON_INC_MESSAGE_PARSE_INTERFACE_H
