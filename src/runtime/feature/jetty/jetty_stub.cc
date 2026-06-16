/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "jetty_manager.h"
#include "jetty_pool.h"
#include "stream_jetty_handler.h"

namespace cce {
namespace runtime {

JettyPool::~JettyPool()
{
}

JettyPool::JettyPool(uint32_t deviceId)
{
    UNUSED(deviceId);
}

JettyManager::JettyManager(uint32_t deviceId)
{
    UNUSED(deviceId);
}

void JettyManager::Clear()
{
}

rtError_t StreamJettyHandler::FillNopWqeOnCaptureEnd(const Stream *stream, JettyType jettyType)
{
    UNUSED(stream);
    UNUSED(jettyType);
    return RT_ERROR_NONE;
}

JettyType StreamJettyHandler::GetJettyTypeFromTask(const TaskInfo *task)
{
    UNUSED(task);
    return JettyType::JETTY_TYPE_MAX;
}

rtError_t StreamJettyHandler::HandleUbDmaTask(
    const Stream *stream, const TaskInfo *task, JettyType jettyType,
    AsyncWqeInputPara *input, AsyncWqeOutputPara *output)
{
    UNUSED(stream);
    UNUSED(task);
    UNUSED(jettyType);
    UNUSED(input);
    UNUSED(output);
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
