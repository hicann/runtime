/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/message_parse_interface.h"
#include "inc/log.h"
#include "inc/internal_api.h"

namespace tsd {
    /**
    * @ingroup MessageParseInterface
    * @brief MessageParseInterface基类构造函数
    */
    MessageParseInterface::MessageParseInterface() {}

    /**
    * @ingroup RegisterMsgProcess
    * @brief RegisterMsgProcess注册HDC消息处理函数
    * @return 无
    */
    void MessageParseInterface::RegisterMsgProcess(const HDCMessage::MsgType type, const ParseFuncType func)
    {
        parseFuncMap_[type] = func;
    }


    /**
    * @ingroup ProcessMessage
    * @brief 处理消息
    * @param [in]sessionID: session标识
    * @param [in]msg:消息数据
    * @return 无
    */
    void MessageParseInterface::ProcessMessage(const uint32_t sessionID, const HDCMessage& msg) const
    {
        ParseFuncType func = nullptr;
        {
            const HDCMessage::MsgType type = msg.type();
            const auto pos =  parseFuncMap_.find(type);
            if (pos != parseFuncMap_.end()) {
                func = pos->second;
            } else {
                TSD_RUN_INFO("Version is not matched(message_type:%u), you need update the software, "
                             "FuncMap size = %zu", static_cast<uint32_t>(type), parseFuncMap_.size());
                uint32_t i = 0;
                for (auto iter = parseFuncMap_.begin();
                     iter != parseFuncMap_.end();
                     iter++, i++) {
                    TSD_RUN_INFO("func type = %u\n", static_cast<uint32_t>(iter->first));
                }
            }
        }
        if (func != nullptr) {
            (*func)(sessionID, msg);
        }
    }
}
