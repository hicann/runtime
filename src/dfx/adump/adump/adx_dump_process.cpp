/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "adx_dump_process.h"
#include <string>
#include "log/adx_log.h"
namespace Adx {
void AdxDumpProcess::MessageCallbackRegister(const MessageCallback callbackFun)
{
    if (init_) {
        IDE_LOGE("MessageCallback function has been registered, The registration does not take effect.");
        return;
    }
    messageCallback_ = callbackFun;
    init_ = true;
}

const std::function<int32_t(const struct DumpChunk *, int32_t)>& AdxDumpProcess::GetCallbackFun() const
{
    return messageCallback_;
}

bool AdxDumpProcess::IsRegistered() const
{
    return init_;
}

void AdxDumpProcess::MessageCallbackUnRegister()
{
    if (!init_) {
        IDE_LOGW("MessageCallback is not registered!");
        return;
    }
    init_ = false;
    messageCallback_ = nullptr;
}
}
