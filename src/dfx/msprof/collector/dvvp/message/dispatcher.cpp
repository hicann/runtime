/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dispatcher.h"
#include "config/config.h"
#include "message/prof_params.h"
#include "msprof_dlog.h"

namespace analysis {
namespace dvvp {
namespace message {
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::config;
MsgDispatcher::MsgDispatcher()
{
}

MsgDispatcher::~MsgDispatcher()
{
}

void MsgDispatcher::OnNewMessage(SHARED_PTR_ALIA<google::protobuf::Message> message)
{
    if (message == nullptr) {
        MSPROF_LOGE("message is null");
        return;
    }

    auto iter = handlerMap_.find(message->GetDescriptor());
    if (iter != handlerMap_.end()) {
        iter->second->OnNewMessage(message);
    } else {
        MSPROF_LOGE("Failed to find handler for message:%s", message->GetTypeName().c_str());
    }
}
}  // namespace message
}  // namespace dvvp
}  // namespace analysis