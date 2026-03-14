/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <iostream>
#include "stub_server_reply.h"
#include "securec.h"

namespace tsd {
    namespace {
        const int32_t MSG_PRE_HEAD_LEN = 12U;
    }
    StubServerReply::StubServerReply() : curMsgType_(HDCMessage::INIT)
    {
    }

    StubServerReply::~StubServerReply()
    {
        ResetServerReply();
    }

    StubServerReply* StubServerReply::GetInstance()
    {
        static StubServerReply instance;
        return &instance;
    }

    void StubServerReply::RegisterCallBack(const HDCMessage::MsgType type, const ServerReplyMsg callBack)
    {
        callbackMap_[static_cast<uint32_t>(type)] = callBack;
    }

    void StubServerReply::ClearAllCallBack()
    {
        callbackMap_.clear();
    }

    void StubServerReply::SetCurMsgType(const struct drvHdcMsg *msg)
    {
        char *buffer = msg->bufList[0].pBuf;
        const int32_t len = *(reinterpret_cast<int32_t *>(buffer));
        const char *hdcMsgBuf = buffer + MSG_PRE_HEAD_LEN;
        sendStoreMsg_.Clear();
        sendStoreMsg_.ParseFromArray(hdcMsgBuf, len - MSG_PRE_HEAD_LEN);
        curMsgType_ = sendStoreMsg_.type();
    }

    void StubServerReply::ResetServerReply()
    {
        ClearAllCallBack();
        curMsgType_ = HDCMessage::INIT;
    }

    bool StubServerReply::ReplyToHost(struct drvHdcMsg *msg)
    {
        (void)memset_s(&priVateMsg_, sizeof(priVateMsg_), 0x00, sizeof(priVateMsg_));
        ServerReplyMsg callbackFunc = nullptr;
        auto iter = callbackMap_.find(static_cast<uint32_t>(curMsgType_));
        if (iter != callbackMap_.end()) {
            callbackFunc = iter->second;
        } else {
            std::cout <<"[FATAL ERROR] cannot find msg:" << static_cast<uint32_t>(curMsgType_) <<
                " callback function" << std::endl;
            return false;
        }
        callbackFunc(msg, &priVateMsg_, sendStoreMsg_);
        return true;
    }
}