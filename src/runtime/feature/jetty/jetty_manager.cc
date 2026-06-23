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

rtError_t JettyManager::ReserveJetty(JettyType type)
{
    rtError_t error = jettyPool_->ReserveJetty(type);
    ERROR_RETURN_MSG_INNER(error,
        "Reserve jetty for stream failed, type=%d, ret=%d.", static_cast<int32_t>(type), error);
    return RT_ERROR_NONE;
}

rtError_t JettyManager::AcquireJettyWithRetry(JettyType type, int32_t streamId,
    const CaptureModel * const excludeMdl, JettyInfo& jettyInfo)
{
    rtError_t error = jettyPool_->AcquireJetty(type, jettyInfo);
    if (error != RT_ERROR_JETTY_POOL_NO_RESOURCES) {
        return error;
    }

    Runtime* rt = Runtime::Instance();
    COND_RETURN_ERROR(rt == nullptr, RT_ERROR_INVALID_VALUE, "Runtime instance is null.");
    Context* curCtx = rt->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    for (uint32_t retry = 0U; retry < JETTY_POOL_ACQUIRE_RETRY_MAX_COUNT; ++retry) {
        RT_LOG(RT_LOG_DEBUG, "Jetty pool exhausted, try recycle (retry=%u/%u), stream_id=%d, type=%d.",
            retry + 1U, JETTY_POOL_ACQUIRE_RETRY_MAX_COUNT, streamId, static_cast<int32_t>(type));
        (void)ReserveJetty(type);
        error = jettyPool_->AcquireJetty(type, jettyInfo);
        if (error == RT_ERROR_NONE) {
            RT_LOG(RT_LOG_DEBUG, "Acquire jetty success after recycle (retry=%u), stream_id=%d, type=%d.",
                retry + 1U, streamId, static_cast<int32_t>(type));
            return RT_ERROR_NONE;
        }
        error = curCtx->TryRecycleCaptureModelJettyResource(excludeMdl, type);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_INFO, "Recycle jetty failed (retry=%u), stream_id=%d, type=%d, ret=%d.",
                retry + 1U, streamId, static_cast<int32_t>(type), error);
            continue;
        }
    }

    RT_LOG(RT_LOG_ERROR, "Acquire jetty failed after %u retries, stream_id=%d, type=%d.",
        JETTY_POOL_ACQUIRE_RETRY_MAX_COUNT, streamId, static_cast<int32_t>(type));
    return RT_ERROR_JETTY_POOL_NO_RESOURCES;
}

rtError_t JettyManager::BindJettyForStream(int32_t streamId, const CaptureModel * const excludeMdl, JettyType type)
{
    std::lock_guard<std::recursive_mutex> lock(managerLock_);
    StreamJettyContext* ctx = GetStreamJettyContext(streamId, type);
    if (ctx == nullptr) {
        RT_LOG(RT_LOG_ERROR, "GetStreamJettyContext failed, stream_id=%d, type=%d.",
        streamId, static_cast<int32_t>(type));
        return RT_ERROR_INVALID_VALUE;
    }
    if (ctx->jettyHandle != 0) {
        return RT_ERROR_NONE;
    }

    JettyInfo jettyInfo = {};
    rtError_t error = RT_ERROR_NONE;

    if (ctx->isLargeDepth) {
        error = jettyPool_->CreateLargeDepthJetty(type, ctx->capacity, jettyInfo);
        ERROR_RETURN_MSG_INNER(error, "Create large depth jetty failed, stream_id=%d, type=%d, ret=%d.",
            streamId, static_cast<int32_t>(type), error);
    } else {
        error = AcquireJettyWithRetry(type, streamId, excludeMdl, jettyInfo);
        ERROR_RETURN_MSG_INNER(error, "Acquire jetty failed, stream_id=%d, type=%d, ret=%d.",
            streamId, static_cast<int32_t>(type), error);
    }

    ctx->jettyHandle = jettyInfo.handle;
    RT_LOG(RT_LOG_INFO, "Bind jetty for stream success, stream_id=%d, type=%d, jetty_id=%u.",
        streamId, static_cast<int32_t>(type), jettyInfo.jettyId);
    return RT_ERROR_NONE;
}

rtError_t JettyManager::UnbindJettyForStream(int32_t streamId, JettyType type)
{
    std::lock_guard<std::recursive_mutex> lock(managerLock_);
    StreamJettyContext* ctx = GetStreamJettyContext(streamId, type);
    if (ctx == nullptr || ctx->jettyHandle == 0) {
        return RT_ERROR_NONE;
    }
    rtError_t error = RT_ERROR_NONE;
    if (ctx->isLargeDepth) {
        error = jettyPool_->DestroyLargeDepthJetty(ctx->jettyHandle);
    } else {
        error = jettyPool_->MarkFree(ctx->jettyHandle);
    }
    ERROR_RETURN_MSG_INNER(error, "Unbind jetty for stream failed, stream_id=%d, type=%d, ret=%d.",
        streamId, static_cast<int32_t>(type), error);

    ctx->jettyHandle = 0;

    RT_LOG(RT_LOG_INFO, "Unbind jetty for stream success, stream_id=%d, type=%d.", streamId, static_cast<int32_t>(type));
    return RT_ERROR_NONE;
}

rtError_t JettyManager::ReleaseJettyByHandle(uint64_t handle, JettyType type)
{
    std::lock_guard<std::recursive_mutex> lock(managerLock_);
    if (handle == 0) {
        return RT_ERROR_NONE;
    }
    rtError_t error = jettyPool_->ReleaseJetty(handle, type);
    ERROR_RETURN_MSG_INNER(error, "Release jetty by handle failed, handle=%lu, type=%d, ret=%d.",
        handle, static_cast<int32_t>(type), error);
    RT_LOG(RT_LOG_INFO, "Release jetty by handle success, handle=%lu, type=%d.",
        handle, static_cast<int32_t>(type));
    return RT_ERROR_NONE;
}

rtError_t JettyManager::GetJettyInfoForStream(int32_t streamId, JettyType type, JettyInfo& jettyInfo)
{
    std::lock_guard<std::recursive_mutex> lock(managerLock_);

    auto key = std::make_pair(static_cast<uint32_t>(streamId), type);
    auto it = streamCaptureContexts_.find(key);
    if (it == streamCaptureContexts_.end() || it->second->jettyHandle == 0) {
        RT_LOG(RT_LOG_WARNING, "Jetty not found, stream_id=%d, type=%d.", streamId, static_cast<int32_t>(type));
        return RT_ERROR_INVALID_VALUE;
    }

    // Query full jetty info from JettyPool (single source of truth, thread-safe)
    rtError_t error = jettyPool_->GetJettyInfoByHandle(it->second->jettyHandle, jettyInfo);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "Jetty info not found in pool, stream_id=%d, type=%d.",
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
    auto it = streamCaptureContexts_.find(key);
    if (it != streamCaptureContexts_.end()) {
        return it->second.get();
    }

    auto context = std::make_unique<StreamJettyContext>();
    context->jettyType = type;
    StreamJettyContext* ctxPtr = context.get();
    streamCaptureContexts_[key] = std::move(context);

    rtError_t error = ReserveJetty(type);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "ReserveJetty failed, stream_id=%d, type=%d, ret=%d.",
            streamId, static_cast<int32_t>(type), error);
        streamCaptureContexts_.erase(key);
        return nullptr;
    }
    RT_LOG(RT_LOG_INFO, "Create context with reserved jetty (FREE), stream_id=%d.", streamId);
    return ctxPtr;
}

StreamJettyContext* JettyManager::GetStreamJettyContext(int32_t streamId, JettyType type) const
{
    std::lock_guard<std::recursive_mutex> lock(managerLock_);
    auto key = std::make_pair(static_cast<uint32_t>(streamId), type);
    auto it = streamCaptureContexts_.find(key);
    if (it != streamCaptureContexts_.end()) {
        return it->second.get();
    }
    return nullptr;
}

void JettyManager::DestroyStreamJettyContext(int32_t streamId, JettyType type)
{
    std::lock_guard<std::recursive_mutex> lock(managerLock_);
    auto key = std::make_pair(static_cast<uint32_t>(streamId), type);
    auto it = streamCaptureContexts_.find(key);
    if (it != streamCaptureContexts_.end()) {
        streamCaptureContexts_.erase(it);
    }
}

void JettyManager::Clear()
{
    std::lock_guard<std::recursive_mutex> lock(managerLock_);
    streamCaptureContexts_.clear();
}

} // namespace runtime
} // namespace cce
