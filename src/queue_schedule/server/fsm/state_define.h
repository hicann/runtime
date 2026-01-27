/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DGW_STATE_DEFINE_H
#define DGW_STATE_DEFINE_H

#include <memory>
#include "common/bqs_log.h"

namespace dgw {
class Entity;
using EntityPtr = std::shared_ptr<Entity>;
class ChannelEntity;
using ChannelEntityPtr = std::shared_ptr<ChannelEntity>;

enum class FsmStatus : int32_t {
    FSM_SUCCESS = 0,
    FSM_DEST_FULL,
    FSM_KEEP_STATE,
    FSM_ERROR_PENDING,
    FSM_FAILED,
    FSM_CACHED,
    FSM_ERROR,
    FSM_SRC_EMPTY
};

enum class InnerMsgType : int32_t {
    INNER_MSG_PUSH = 0,
    INNER_MSG_F2NF,
    INNER_MSG_RECOVER,
    INNER_MSG_INVALID
};

struct InnerMessage {
    InnerMsgType msgType = InnerMsgType::INNER_MSG_INVALID;
};

inline const char_t *GetMsgDesc(const InnerMessage &msg)
{
    if ((msg.msgType >= InnerMsgType::INNER_MSG_PUSH) && (msg.msgType <= InnerMsgType::INNER_MSG_RECOVER)) {
        const char_t * const msgDesc[static_cast<int32_t>(InnerMsgType::INNER_MSG_INVALID)] = {
            "PUSH",
            "F2NF",
            "RECOVER"
        };

        return msgDesc[static_cast<int32_t>(msg.msgType)];
    } else {
        return "INNER_MSG_INVALID";
    }
}

enum class EntityType : int32_t {
    ENTITY_QUEUE = 0,
    ENTITY_TAG,
    ENTITY_GROUP,
    ENTITY_INVALID
};

enum class EntityDirection : int32_t {
    DIRECTION_SEND = 0,
    DIRECTION_RECV,
    DIRECTION_INVALID
};

inline const char_t *GetDirectionDesc(const EntityDirection direction)
{
    if ((direction >= EntityDirection::DIRECTION_SEND) && (direction <= EntityDirection::DIRECTION_RECV)) {
        const char_t * const directionDesc[static_cast<int32_t>(EntityDirection::DIRECTION_INVALID)] = {
            "SEND",
            "RECV"
        };

        return directionDesc[static_cast<int32_t>(direction)];
    } else {
        return "DIRECTION_INVALID";
    }
}

enum class FsmState : int32_t {
    FSM_BASE_STATE = 0,
    FSM_IDLE_STATE,
    FSM_PEEK_STATE,
    FSM_TRY_PUSH_STATE,
    FSM_WAIT_PUSH_STATE,
    FSM_PUSH_STATE,
    FSM_FULL_STATE,
    FSM_ERROR_STATE,
    FSM_INVALID_STATE
};

enum class AsyncDataState : int32_t {
    FSM_ASYNC_DATA_INIT = 0,
    FSM_ASYNC_DATA_WAIT,
    FSM_ASYNC_DATA_SENT,
    FSM_ASYNC_ENTITY_DONE,
    FSM_ASYNC_DATA_INVALID
};

enum class SubscribeStatus : int32_t {
    SUBSCRIBE_PAUSE = 0,
    SUBSCRIBE_RESUME,
    SUBSCRIBE_INVALID
};

enum class BufEventType : int32_t {
    BUF_EVENT_DEL = 0,
    BUF_EVENT_ADD,
};

enum class ChannelLinkStatus : int32_t {
    UNCONNECTED = 0,
    CONNECTED,
    ABNORMAL,
};
}
#endif
