/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TDT_DEVICE_INNER_INC_MESSAGE_PARSE_SERVER_H
#define TDT_DEVICE_INNER_INC_MESSAGE_PARSE_SERVER_H

#include "inc/message_parse_interface.h"

namespace tsd {
    class MessageParseServer : public MessageParseInterface {
    public:
        /**
        * @ingroup hiaiengine
        * @brief 静态函数，获取单例对象
        * @param 无
        * @return MessageParseServer的指针
        */
        static MessageParseServer* GetInstance();

    private:
        MessageParseServer() = default;
        virtual ~MessageParseServer() override = default;
        MessageParseServer(const MessageParseServer&) = delete;
        MessageParseServer(MessageParseServer&&) = delete;
        MessageParseServer& operator=(const MessageParseServer&) = delete;
        MessageParseServer& operator=(MessageParseServer&) = delete;
        MessageParseServer& operator=(MessageParseServer&&) = delete;
    };
}
#endif  // TDT_DEVICE_INNER_INC_MESSAGE_PARSE_SERVER_H
