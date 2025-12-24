/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_MESSAGE_DISPATCHER_H
#define ANALYSIS_DVVP_MESSAGE_DISPATCHER_H

#include <map>
#include <memory>
#include <string>
#include <google/protobuf/descriptor.h>
#include <google/protobuf/message.h>

#include "utils/utils.h"

namespace analysis {
namespace dvvp {
namespace message {
class IMsgHandler {
public:
    virtual ~IMsgHandler() {}

public:
    virtual void OnNewMessage(SHARED_PTR_ALIA<google::protobuf::Message> message) = 0;
};

class MsgDispatcher {
public:
    MsgDispatcher();
    virtual ~MsgDispatcher();

public:
    void OnNewMessage(SHARED_PTR_ALIA<google::protobuf::Message> message);

    template<typename T>
    void RegisterMessageHandler(SHARED_PTR_ALIA<IMsgHandler> handler)
    {
        if (handler == nullptr) {
            return;
        }
        handlerMap_[T::descriptor()] = handler;
    }

private:
    std::map<const google::protobuf::Descriptor *, SHARED_PTR_ALIA<IMsgHandler> > handlerMap_;
};
}  // namespace message
}  // namespace dvvp
}  // namespace analysis

#endif