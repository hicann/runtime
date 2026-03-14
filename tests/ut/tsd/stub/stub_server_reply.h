/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TSD_STUB_SERVER_REPLY_H
#define TSD_STUB_SERVER_REPLY_H
#include <map>
#include <list>
#include "tsd/status.h"
#include "proto/tsd_message.pb.h"
#include "stub_server_msg_impl.h"
#include "driver/ascend_hal.h"

namespace tsd {
using ServerReplyMsg = void (*)(struct drvHdcMsg *msg, HdcBufferInfo *buf, const HDCMessage &sendMsg);

class StubServerReply {
public:
    static StubServerReply* GetInstance();

    void RegisterCallBack(const HDCMessage::MsgType type, const ServerReplyMsg callBack);

    void ClearAllCallBack();

    void SetCurMsgType(const struct drvHdcMsg *msg);

    void ResetServerReply();

    bool ReplyToHost(struct drvHdcMsg *msg);

private:
    StubServerReply();

    virtual ~StubServerReply();

    StubServerReply(const StubServerReply&) = delete;

    StubServerReply(StubServerReply&&) = delete;

    StubServerReply& operator=(const StubServerReply&) = delete;
    
    StubServerReply& operator=(StubServerReply&) = delete;

    StubServerReply& operator=(StubServerReply&&) = delete;

    std::map<uint32_t, ServerReplyMsg> callbackMap_;

    HDCMessage::MsgType curMsgType_;

    HdcBufferInfo priVateMsg_;

    HDCMessage sendStoreMsg_;
};
}

#endif