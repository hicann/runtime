/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stream_launch_blocking.hpp"

#include <new>
#include "context.hpp"
#include "error_message_manage.hpp"
#include "runtime.hpp"
#include "stream.hpp"

namespace cce {
namespace runtime {
constexpr uint32_t LAUNCH_BLOCKING_UNSUPPORTED_STREAM_FLAGS =
    RT_STREAM_PERSISTENT | RT_STREAM_AICPU | RT_STREAM_CP_PROCESS_USE;

StreamLaunchBlocking::StreamLaunchBlocking() : mode_(RT_STREAM_LAUNCH_BLOCKING_MODE_CTRL_BY_ENV), nonBlockingDepth_(0U)
{}

bool StreamLaunchBlocking::End(bool& isNonBlockingSectionClosed)
{
    uint32_t depth = nonBlockingDepth_.Value();
    while (depth > 0U) {
        if (nonBlockingDepth_.CompareExchange(depth, depth - 1U)) {
            // A depth transition from 1 to 0 closes the outermost non-blocking section.
            isNonBlockingSectionClosed = (depth == 1U);
            return true;
        }
        depth = nonBlockingDepth_.Value();
    }
    return false;
}

rtError_t StreamLaunchBlocking::GetLaunchBlockingState(Stream* const stm, StreamLaunchBlocking*& launchBlockingState)
{
    launchBlockingState = stm->launchBlockingState_.Value();
    if (launchBlockingState != nullptr) {
        return RT_ERROR_NONE;
    }

    // Concurrent first callers may allocate together; only the CAS winner installs its state.
    StreamLaunchBlocking* const candidate = new (std::nothrow) StreamLaunchBlocking();
    COND_RETURN_AND_MSG_OUTER(
        candidate == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, sizeof(StreamLaunchBlocking), "new");
    if (stm->launchBlockingState_.CompareExchange(nullptr, candidate)) {
        launchBlockingState = candidate;
    } else {
        delete candidate;
        launchBlockingState = stm->launchBlockingState_.Value();
    }
    return RT_ERROR_NONE;
}

void StreamLaunchBlocking::ReleaseLaunchBlockingState(Stream* const stm)
{
    StreamLaunchBlocking* launchBlockingState = stm->launchBlockingState_.Exchange(nullptr);
    DELETE_O(launchBlockingState);
}

rtError_t StreamLaunchBlocking::SetLaunchBlockingMode(Stream* const stm, const uint32_t mode)
{
    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream* const targetStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(targetStm);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
        targetStm, curCtx, RT_ERROR_STREAM_CONTEXT, "Setting the stream launch blocking mode");

    StreamLaunchBlocking* launchBlockingState = targetStm->launchBlockingState_.Value();
    if ((launchBlockingState == nullptr) && (mode == RT_STREAM_LAUNCH_BLOCKING_MODE_CTRL_BY_ENV)) {
        // The null state already represents the default mode, so no allocation is needed.
        return RT_ERROR_NONE;
    }
    if (launchBlockingState == nullptr) {
        const rtError_t error = GetLaunchBlockingState(targetStm, launchBlockingState);
        if (error != RT_ERROR_NONE) {
            return error;
        }
    }
    launchBlockingState->SetMode(mode);
    return RT_ERROR_NONE;
}

rtError_t StreamLaunchBlocking::GetLaunchBlockingMode(const Stream* const stm, uint32_t* const mode)
{
    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    const Stream* const targetStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(targetStm);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
        targetStm, curCtx, RT_ERROR_STREAM_CONTEXT, "Obtaining the stream launch blocking mode");
    const StreamLaunchBlocking* const launchBlockingState = targetStm->launchBlockingState_.Value();
    *mode =
        (launchBlockingState == nullptr) ? RT_STREAM_LAUNCH_BLOCKING_MODE_CTRL_BY_ENV : launchBlockingState->GetMode();
    return RT_ERROR_NONE;
}

rtError_t StreamLaunchBlocking::NonBlockingLaunchBegin(Stream* const stream)
{
    StreamLaunchBlocking* launchBlockingState = nullptr;
    const rtError_t error = GetLaunchBlockingState(stream, launchBlockingState);
    if (error != RT_ERROR_NONE) {
        return error;
    }
    launchBlockingState->Begin();
    return RT_ERROR_NONE;
}

rtError_t StreamLaunchBlocking::NonBlockingLaunchEnd(Stream* const stream)
{
    bool isNonBlockingSectionClosed = false;
    StreamLaunchBlocking* const launchBlockingState = stream->launchBlockingState_.Value();
    if ((launchBlockingState == nullptr) || !launchBlockingState->End(isNonBlockingSectionClosed)) {
        RT_LOG_OUTER_MSG_IMPL(
            ErrorCode::EE1018, "Ending a non-blocking launch section",
            RtFmtMsg(
                "The stream (stream_id=%d) is not in a non-blocking launch section. Call the "
                "aclrtNonBlockingLaunchBegin API first",
                stream->Id_()));
        return RT_ERROR_INVALID_VALUE;
    }

    if (isNonBlockingSectionClosed && ShouldLaunchBlock(stream)) {
        return stream->Synchronize(false);
    }
    return RT_ERROR_NONE;
}

bool StreamLaunchBlocking::IsNonBlockingLaunchActive(const Stream* const stm)
{
    const StreamLaunchBlocking* const launchBlockingState = stm->launchBlockingState_.Value();
    return (launchBlockingState != nullptr) && (launchBlockingState->nonBlockingDepth_.Value() > 0U);
}

bool StreamLaunchBlocking::ShouldLaunchBlock(const Stream* const stm)
{
    if ((stm == nullptr) || !stm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_LAUNCH_BLOCKING) ||
        stm->IsModelStream() || stm->GetBindFlag() || stm->IsCapturing() ||
        ((stm->Flags() & LAUNCH_BLOCKING_UNSUPPORTED_STREAM_FLAGS) != 0U)) {
        return false;
    }

    if (IsNonBlockingLaunchActive(stm)) {
        return false;
    }
    const StreamLaunchBlocking* const launchBlockingState = stm->launchBlockingState_.Value();
    const uint32_t mode =
        (launchBlockingState == nullptr) ? RT_STREAM_LAUNCH_BLOCKING_MODE_CTRL_BY_ENV : launchBlockingState->GetMode();
    if (mode == RT_STREAM_LAUNCH_BLOCKING_MODE_NON_BLOCKING) {
        return false;
    }
    if (mode == RT_STREAM_LAUNCH_BLOCKING_MODE_BLOCKING) {
        return true;
    }
    return Runtime::Instance()->IsLaunchBlockingEnvEnabled();
}

} // namespace runtime
} // namespace cce
