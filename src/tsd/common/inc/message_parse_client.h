/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TDT_HOST_INNER_INC_MESSAGE_PARSE_CLIENT_H
#define TDT_HOST_INNER_INC_MESSAGE_PARSE_CLIENT_H

#include "inc/message_parse_interface.h"

namespace tsd {
    class MessageParseClient : public MessageParseInterface {
    public:
        /**
        * @ingroup hiaiengine
        * @brief 静态函数，获取单例对象
        * @param 无
        * @return MessageParseClient的指针
        */
        static MessageParseClient* GetInstance();

    private:
        MessageParseClient() = default;
        virtual ~MessageParseClient() = default;
        MessageParseClient(const MessageParseClient&) = delete;
        MessageParseClient(MessageParseClient&&) = delete;
        MessageParseClient& operator=(const MessageParseClient&) = delete;
        MessageParseClient& operator=(MessageParseClient&) = delete;
        MessageParseClient& operator=(MessageParseClient&&) = delete;
    };
}
#endif  // TDT_HOST_INNER_INC_MESSAGE_PARSE_CLIENT_H
