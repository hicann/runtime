/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "model.hpp"
#if (!defined(CFG_VECTOR_CAST))
#include <algorithm>
#endif
#include <functional>
#include "context.hpp"

namespace cce {
namespace runtime {
void Model::ResetForRestore(void)
{
    Device * const dev = context_->Device_();
    Driver * const deviceDrv = dev->Driver_();
    const uint32_t deviceId = dev->Id_();
    const uint32_t tsId = dev->DevGetTsId();
 
    if (streamInfoPtr_ != nullptr) {
        (void)deviceDrv->DevMemFree(streamInfoPtr_, deviceId);
        streamInfoPtr_ = nullptr;
    }
    if (aicpuTaskInfoPtr_ != nullptr) {
        (void)deviceDrv->DevMemFree(aicpuTaskInfoPtr_, deviceId);
        aicpuTaskInfoPtr_ = nullptr;
    }
    if (queueInfoPtr_ != nullptr) {
        (void)deviceDrv->DevMemFree(queueInfoPtr_, deviceId);
        queueInfoPtr_ = nullptr;
    }
    if (funcCallHostMem_ != nullptr) {
        free(funcCallHostMem_);
        funcCallHostMem_ = nullptr;
    }
    if (baseFuncCallSvmMem_ != nullptr) {
        (void)deviceDrv->DevMemFree(baseFuncCallSvmMem_, deviceId);
        baseFuncCallSvmMem_ = nullptr;
        dfxPtr_ = nullptr;
        funcCallSvmMem_ = 0ULL;
    }
    if (funcCallDfxBaseSvmMem_ != nullptr) {
        (void)deviceDrv->DevMemFree(funcCallDfxBaseSvmMem_, deviceId);
        funcCallDfxBaseSvmMem_ = nullptr;
        dfxPtr_ = nullptr;
    }
    funCallMemSize_ = 0ULL;
    funcCallSvmMem_ = 0ULL;
    RT_LOG(RT_LOG_INFO, "Success to reInit, devId=%u, tsId=%u, modelId=%u.", deviceId, tsId, id_);
}

rtError_t Model::ReAllocStreamId(void)
{
    for (Stream *s : streams_) {
        const int32_t streamId = s->Id_();
        const uint32_t sqId = s->GetSqId();
        const rtError_t ret = s->ReAllocStreamId();
        ERROR_RETURN(ret, "Realloc stream_id %d->%u failed, retCode=%#x.",
            streamId, sqId, static_cast<uint32_t>(ret));
    }
    return RT_ERROR_NONE;
}

rtError_t Model::CheckRestoredSqStatus(void)
{
    Device * const dev = context_->Device_();
    const uint32_t tsId = dev->DevGetTsId();
    const uint32_t deviceId = dev->Id_();

    for (Stream *s : streams_) {
        bool enable = false;
        uint16_t sqHead = 0U;
        const int32_t streamId = s->Id_();
        const uint32_t sqId = s->GetSqId();
        rtError_t ret = dev->Driver_()->GetSqEnable(deviceId, tsId, sqId, enable);
        ERROR_RETURN(ret, "Get SQ %u status failed, retCode=%#x.", sqId, static_cast<uint32_t>(ret));
        COND_RETURN_ERROR(enable, RT_ERROR_STREAM_INVALID, "The stream[%d->%u] status exception.", streamId, sqId);
        ret = dev->Driver_()->GetSqHead(deviceId, tsId, sqId, sqHead);
        ERROR_RETURN(ret, "Get SQ %u head failed, retCode=%#x.", sqId, static_cast<uint32_t>(ret));
        COND_RETURN_ERROR(sqHead != 0U, RT_ERROR_STREAM_INVALID, "The SQ %d head %hu is invalid.", sqId, sqHead);
        // 当前驱动二级SQ队列的任务可能仍处于异步恢复过程中，此时查询得到的tail值可能仅为中间状态，其最终正确性将在后续的
        // LoadCompleteByStreamPostp流程中进行最终校验。
    }
    return RT_ERROR_NONE;
}

rtError_t Model::ReSetup(void)
{
    Device * const dev = context_->Device_();
    const uint32_t deviceId = dev->Id_();
    const uint32_t tsId = dev->DevGetTsId();

    rtError_t err = dev->Driver_()->ReAllocResourceId(deviceId, tsId, 0U, Id_(), DRV_MODEL_ID);
    ERROR_RETURN(err, "Realloc modelId failed, devId=%u, tsId=%u, retCode=%#x!",
        deviceId, tsId, static_cast<uint32_t>(err));

    err = dev->WriteDevValue(modeID_, sizeof(int32_t), &id_);
    ERROR_RETURN(err, "Write modelId failed, devId=%u, tsId=%u, retCode=%#x!",
        deviceId, tsId, static_cast<uint32_t>(err));

    err = dev->WriteDevString(endGraphName_, MALLOC_DEV_NAME_STRING_MAX, "endGraph");
    ERROR_RETURN(err, "Write EndGraph failed, devId=%u, tsId=%u, retCode=%#x!",
        deviceId, tsId, static_cast<uint32_t>(err));

    err = dev->WriteDevString(activeStreamName_, MALLOC_DEV_NAME_STRING_MAX, "activeEntryStream");
    ERROR_RETURN(err, "Write ActiveEntryStream failed, devId=%u, tsId=%u, retCode=%#x!",
        deviceId, tsId, static_cast<uint32_t>(err));

    err = ReAllocStreamId();
    ERROR_RETURN(err, "Realloc streamId failed, error=%#x.", static_cast<uint32_t>(err));

    return RT_ERROR_NONE;
}

rtError_t Model::ReBindStreams(void)
{
    for (Stream * const streamObj : streams_) {
        if ((streamObj->Flags() & RT_STREAM_AICPU) != 0U) {
            continue;
        }
        const uint32_t flag = (IsModelHeadStream(streamObj)) ?
            static_cast<uint32_t>(RT_HEAD_STREAM) :
            static_cast<uint32_t>(RT_INVALID_FLAG);
        const rtError_t error = EnterBindStream(streamObj, flag);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    }
    return RT_ERROR_NONE;
}

rtError_t Model::SinkSqTasksBackup(void)
{
    const size_t stmCnt = streams_.size();
    auto sqIdGrp = std::make_unique<uint32_t[]>(stmCnt);
    NULL_PTR_RETURN(sqIdGrp, RT_ERROR_MEMORY_ALLOCATION);
    (void)std::transform(streams_.begin(), streams_.end(), sqIdGrp.get(),
        [](const Stream * const stream) -> uint32_t {
            return static_cast<uint32_t>(stream->GetSqId());
        }
    );
    return NpuDriver::SqBackup(context_->Device_()->Id_(), sqIdGrp.get(), stmCnt);
}

rtError_t Model::SinkSqTasksRestore(void)
{
    const size_t stmCnt = streams_.size();
    auto sqIdGrp = std::make_unique<uint32_t[]>(stmCnt);
    NULL_PTR_RETURN(sqIdGrp, RT_ERROR_MEMORY_ALLOCATION);
    (void)std::transform(streams_.begin(), streams_.end(), sqIdGrp.get(),
        [](const Stream * const stream) -> uint32_t {
            return static_cast<uint32_t>(stream->GetSqId());
        }
    );
    return NpuDriver::SqRestore(context_->Device_()->Id_(), sqIdGrp.get(), stmCnt);
}

rtError_t Model::ReBuild(void)
{
    RT_LOG(RT_LOG_EVENT, "Begin to rebuild model, id=%d.", id_);

    rtError_t error = ReSetup();
    ERROR_RETURN_MSG_INNER(error,"ReSetup model failed. retCode=%#x!",
        static_cast<uint32_t>(error));

    ResetForRestore();

    error = ReBindStreams();
    ERROR_RETURN_MSG_INNER(error,"ReBind stream failed. retCode=%#x!",
        static_cast<uint32_t>(error));

    error = SinkSqTasksRestore();
    ERROR_RETURN_MSG_INNER(error,"Restore tasks failed. retCode=%#x!",
        static_cast<uint32_t>(error));
 
    error = CheckRestoredSqStatus();
    ERROR_RETURN_MSG_INNER(error,"Check SQ status failed. retCode=%#x!",
        static_cast<uint32_t>(error));

    error = LoadCompleteByStream();
    ERROR_RETURN_MSG_INNER(error,"ReLoad complete failed. retCode=%#x!",
        static_cast<uint32_t>(error));
    
    error = UpdateSnapShotSqe();
    ERROR_RETURN_MSG_INNER(error,"update sqe failed. retCode=%#x!",
        static_cast<uint32_t>(error));

    RT_LOG(RT_LOG_EVENT, "Success to rebuild model, id=%d.", id_);
    return RT_ERROR_NONE;
}

}
}