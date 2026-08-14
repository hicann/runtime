/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "base.hpp"
#include "device_msg_handler.hpp"

namespace cce {
namespace runtime {

DeviceMsgHandler::DeviceMsgHandler(Device* const devInfo, const rtGetMsgCallback msgCallback)
    : dev_(devInfo), callback_(msgCallback), devMemSize_(0U)
{}

DeviceMsgHandler::~DeviceMsgHandler() noexcept {}

rtError_t DeviceMsgHandler::Init() { return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t DeviceStreamSnapshotHandler::HandleMsgInHostBuf(const char_t* const msgBuff, const uint32_t msgBuffSize)
{
    UNUSED(msgBuff);
    UNUSED(msgBuffSize);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

} // namespace runtime
} // namespace cce
