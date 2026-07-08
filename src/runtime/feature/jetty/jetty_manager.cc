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
#include "npu_driver.hpp"
#include "common/internal_error_define.hpp"
#include "error_message_manage.hpp"
#include "runtime.hpp"
#include "context.hpp"
namespace cce {
namespace runtime {

JettyManager::JettyManager(uint32_t deviceId) : jettyPool_(std::make_unique<JettyPool>(deviceId))
{
    RT_LOG(RT_LOG_INFO, "JettyManager created for device_id=%u.", deviceId);
}

rtError_t JettyManager::PreAllocJetty(JettyType type)
{
    rtError_t error = jettyPool_->PreAllocJetty(type);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error,
        "Reserve jetty for stream failed, type=%d, retCode=%#x.", static_cast<int32_t>(type), error);
    return RT_ERROR_NONE;
}

rtError_t JettyManager::AllocJettyWithRetry(JettyType type, int32_t streamId,
    const CaptureModel * const excludeMdl, JettyInfo& jettyInfo)
{
    rtError_t error = jettyPool_->AllocJetty(type, jettyInfo);
    if (error != RT_ERROR_JETTY_POOL_NO_RESOURCES) {
        return error;
    }

    Runtime* rt = Runtime::Instance();
    COND_RETURN_ERROR(rt == nullptr, RT_ERROR_INVALID_VALUE, "Runtime instance is null.");
    Context* curCtx = rt->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    rtError_t errorTmp = RT_ERROR_NONE;
    do {
        error = curCtx->CheckStatus();
        ERROR_RETURN(error, "context is abort, status=%#x.", static_cast<uint32_t>(error));
        (void)PreAllocJetty(type);
        error = jettyPool_->AllocJetty(type, jettyInfo);
        COND_PROC(error != RT_ERROR_NONE, errorTmp = curCtx->TryRecycleCaptureModelJettyResource(excludeMdl, type));
        COND_RETURN_ERROR((errorTmp != RT_ERROR_NONE), errorTmp,
            "release resource failed, stream_id=%u, retCode=%#x.", streamId, static_cast<uint32_t>(errorTmp));
        COND_PROC(error != RT_ERROR_NONE, (void)mmSleep(1U)); // sleep 1ms
    } while (((error != RT_ERROR_NONE)));

    COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
        "jetty alloc failed, stream_id=%u, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t JettyManager::BindJettyForStream(int32_t streamId, const CaptureModel * const excludeMdl, JettyType type)
{
    std::lock_guard<std::recursive_mutex> lock(managerLock_);
    StreamJettyContext* jettyCtx = GetStreamJettyContext(streamId, type);
    if (jettyCtx == nullptr) {
        RT_LOG(RT_LOG_ERROR, "GetStreamJettyContext failed, stream_id=%d, type=%d.",
        streamId, static_cast<int32_t>(type));
        return RT_ERROR_INVALID_VALUE;
    }
    if (jettyCtx->jettyHandle != 0) {
        return RT_ERROR_NONE;
    }

    JettyInfo jettyInfo = {};
    rtError_t error = RT_ERROR_NONE;

    if (jettyCtx->isLargeDepth) {
        error = jettyPool_->AllocLargeDepthJetty(type, jettyCtx->capacity, jettyInfo);
        COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "Create large depth jetty failed, stream_id=%d, type=%d, retCode=%#x.",
            streamId, static_cast<int32_t>(type), error);
    } else {
        error = AllocJettyWithRetry(type, streamId, excludeMdl, jettyInfo);
        ERROR_RETURN_MSG_INNER(error, "Acquire jetty failed, stream_id=%d, type=%d, retCode=%#x.",
            streamId, static_cast<int32_t>(type), error);
    }

    jettyCtx->jettyHandle = jettyInfo.handle;
    RT_LOG(RT_LOG_INFO, "Bind jetty for stream success, stream_id=%d, type=%d, jetty_id=%u.",
        streamId, static_cast<int32_t>(type), jettyInfo.jettyId);
    return RT_ERROR_NONE;
}

rtError_t JettyManager::UnbindJettyForStream(int32_t streamId, JettyType type)
{
    std::lock_guard<std::recursive_mutex> lock(managerLock_);
    StreamJettyContext* jettyCtx = GetStreamJettyContext(streamId, type);
    if (jettyCtx == nullptr || jettyCtx->jettyHandle == 0) {
        return RT_ERROR_NONE;
    }
    rtError_t error = RT_ERROR_NONE;
    if (jettyCtx->isLargeDepth) {
        error = jettyPool_->FreeLargeDepthJetty(jettyCtx->jettyHandle);
    } else {
        error = jettyPool_->FreeJettyLazy(jettyCtx->jettyHandle);
    }
    ERROR_RETURN_MSG_INNER(error, "Unbind jetty for stream failed, stream_id=%d, type=%d, retCode=%#x.",
        streamId, static_cast<int32_t>(type), error);

    jettyCtx->jettyHandle = 0U;

    RT_LOG(RT_LOG_INFO, "Unbind jetty for stream success, stream_id=%d, type=%d.", streamId, static_cast<int32_t>(type));
    return RT_ERROR_NONE;
}

rtError_t JettyManager::FreeJettyByHandle(uint64_t handle, JettyType type)
{
    std::lock_guard<std::recursive_mutex> lock(managerLock_);
    if (handle == 0) {
        return RT_ERROR_NONE;
    }
    rtError_t error = jettyPool_->FreeJetty(handle, type);
    ERROR_RETURN_MSG_INNER(error, "Release jetty by handle failed, handle=%lu, type=%d, retCode=%#x.",
        handle, static_cast<int32_t>(type), error);
    RT_LOG(RT_LOG_INFO, "Release jetty by handle success, handle=%lu, type=%d.",
        handle, static_cast<int32_t>(type));
    return RT_ERROR_NONE;
}

rtError_t JettyManager::GetJettyInfoForStream(int32_t streamId, JettyType type, JettyInfo& jettyInfo)
{
    std::lock_guard<std::recursive_mutex> lock(managerLock_);

    auto key = std::make_pair(static_cast<uint32_t>(streamId), type);
    auto it = streamJettyContexts_.find(key);
    if (it == streamJettyContexts_.end() || it->second->jettyHandle == 0) {
        RT_LOG(RT_LOG_ERROR, "Jetty not found, stream_id=%d, type=%d.", streamId, static_cast<int32_t>(type));
        return RT_ERROR_INVALID_VALUE;
    }

    // Query full jetty info from JettyPool (single source of truth, thread-safe)
    rtError_t error = jettyPool_->GetJettyInfoByHandle(it->second->jettyHandle, jettyInfo);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Jetty info not found in pool, stream_id=%d, type=%d.",
            streamId, static_cast<int32_t>(type));
        return RT_ERROR_INVALID_VALUE;
    }
    return RT_ERROR_NONE;
}

StreamJettyContext* JettyManager::GetOrCreateStreamJettyContext(const Stream *stream, JettyType type)
{
    std::lock_guard<std::recursive_mutex> lock(managerLock_);
    int32_t streamId = static_cast<int32_t>(stream->Id_());
    auto key = std::make_pair(static_cast<uint32_t>(streamId), type);
    auto it = streamJettyContexts_.find(key);
    if (it != streamJettyContexts_.end()) {
        return it->second.get();
    }

    auto context = std::make_unique<StreamJettyContext>();
    NULL_PTR_RETURN(context, nullptr);
    context->jettyType = type;
    StreamJettyContext* jettyCtx = context.get();
    streamJettyContexts_[key] = std::move(context);

    rtError_t error = PreAllocJetty(type);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "PreAllocJetty failed, stream_id=%d, type=%d, retCode=%#x.",
            streamId, static_cast<int32_t>(type), error);
        streamJettyContexts_.erase(key);
        return nullptr;
    }
    RT_LOG(RT_LOG_INFO, "Create context with reserved jetty (FREE), stream_id=%d.", streamId);
    return jettyCtx;
}

StreamJettyContext* JettyManager::GetStreamJettyContext(int32_t streamId, JettyType type) const
{
    std::lock_guard<std::recursive_mutex> lock(managerLock_);
    auto key = std::make_pair(static_cast<uint32_t>(streamId), type);
    auto it = streamJettyContexts_.find(key);
    if (it != streamJettyContexts_.end()) {
        return it->second.get();
    }
    return nullptr;
}

void JettyManager::DeleteStreamJettyContext(int32_t streamId, JettyType type)
{
    std::lock_guard<std::recursive_mutex> lock(managerLock_);
    auto key = std::make_pair(static_cast<uint32_t>(streamId), type);
    auto it = streamJettyContexts_.find(key);
    if (it != streamJettyContexts_.end()) {
        streamJettyContexts_.erase(it);
    }
}

void JettyManager::Clear()
{
    std::lock_guard<std::recursive_mutex> lock(managerLock_);
    streamJettyContexts_.clear();
}

} // namespace runtime
} // namespace cce
