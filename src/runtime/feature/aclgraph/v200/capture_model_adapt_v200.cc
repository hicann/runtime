/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "capture_model.hpp"
#include "context.hpp"
#include "stream_david.hpp"
#include "memory_task.h"
#include "task.hpp"
#include "stream_c.hpp"
#include "stream_jetty_handler.h"
#include "jetty_manager.h"
#include "jetty_pool.h"
#include "drv/driver.hpp"
#include <securec.h>
#include <vector>

namespace cce {
namespace runtime {

rtError_t CaptureModel::BindSqCqAndSendSqe(void)
{
    rtError_t error = BindSqCq();
    ERROR_RETURN(error, "Failed to bind SQ and CQ, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    error = RebuildExternalTaskSqes();
    ERROR_RETURN(error, "Failed to rebuild external task SQE, model_id=%u, retCode=%#x.", Id_(),
        static_cast<uint32_t>(error));

    error = SendSqe();
    ERROR_RETURN(error, "Failed to send SQE, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    error = BindStreamToModel();
    ERROR_RETURN(error, "Failed to bind stream to model, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    error = ConfigSqTail();
    ERROR_RETURN(error, "Failed to configure SQ tail, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    return error;
}

rtError_t CaptureModel::BindJetty(Stream * const stm, JettyType type)
{
    int32_t streamId = stm->Id_();
    JettyManager *jettyMgr = Context_()->Device_()->GetJettyManager();
    COND_RETURN_ERROR(jettyMgr == nullptr, RT_ERROR_INVALID_VALUE,
        "GetJettyManager returned null, stream_id=%d.", streamId);
    StreamJettyContext *context = jettyMgr->GetStreamJettyContext(streamId, type);
    if (context == nullptr || context->filledWqeCount == 0) {
        RT_LOG(RT_LOG_DEBUG, "No ub dma task, stream_id=%d, jetty_type=%d.",
            streamId, static_cast<int32_t>(type));
        return RT_ERROR_NONE;
    }
    // 检查是否已绑定，避免重复执行 WQE 同步和 SQE 刷新, 已绑定场景要刷新pi
    if (context->jettyHandle != 0) {
        SetNeedUpdateUBPi(true);
        RT_LOG(RT_LOG_DEBUG, "Jetty already bound, skip sync, stream_id=%d, jetty_type=%d.",
            streamId, static_cast<int32_t>(type));
        return RT_ERROR_NONE;
    }
    rtError_t error = jettyMgr->BindJettyForStream(streamId, this, type);
    ERROR_RETURN_MSG_INNER(error, "BindJettyForStream failed, stream_id=%d, ret=%d.", streamId, error);

    JettyInfo jettyInfo = {};
    error = jettyMgr->GetJettyInfoForStream(streamId, type, jettyInfo);
    ERROR_RETURN_MSG_INNER(error, "GetJettyInfoForStream failed, stream_id=%d, ret=%d.", streamId, error);

    error = StreamJettyHandler::SyncWqeBufferToDevice(stm, context, jettyInfo);
    ERROR_RETURN_MSG_INNER(error, "SyncWqeBufferToDevice failed, stream_id=%d, ret=%d.", streamId, error);

    error = StreamJettyHandler::UpdateUbdmaSqeWithJettyInfo(stm, context, jettyInfo);
    ERROR_RETURN_MSG_INNER(error, "UpdateUbdmaSqeWithJettyInfo failed, stream_id=%d, ret=%d.", streamId, error);
    SetNeedUpdateUBPi(false);
    return error;
}

rtError_t CaptureModel::RefreshJettyInfoList()
{
    JettyManager *jettyMgr = Context_()->Device_()->GetJettyManager();
    NULL_PTR_RETURN(jettyMgr, RT_ERROR_INVALID_VALUE);
    ClearH2dJettyInfoList();
    ClearD2dJettyInfoList();
    for (Stream *stm : StreamList_()) {
        int32_t streamId = stm->Id_();
        for (JettyType type : {JettyType::JETTY_TYPE_H2D, JettyType::JETTY_TYPE_D2D}) {
            StreamJettyContext *ctx = jettyMgr->GetStreamJettyContext(streamId, type);
            if (ctx == nullptr || ctx->jettyHandle == 0 || ctx->filledWqeCount == 0) {
                continue;
            }
            JettyInfo jettyInfo = {};
            rtError_t ret = jettyMgr->GetJettyInfoForStream(streamId, type, jettyInfo);
            COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret,
                "GetJettyInfoForStream failed, stream_id=%d, type=%d, ret=%d.", streamId, static_cast<int32_t>(type), ret);

            UbAsyncJettyInfo info = {};
            info.dieId = static_cast<uint16_t>(jettyInfo.dieId);
            info.functionId = static_cast<uint16_t>(jettyInfo.functionId);
            info.jettyId = static_cast<uint16_t>(jettyInfo.jettyId);
            info.piValue = static_cast<uint16_t>(ctx->capacity - ctx->filledWqeCount);
            info.sqId = stm->GetSqId();
            if (type == JettyType::JETTY_TYPE_H2D) {
                SetH2dJettyInfo(info);
            } else {
                SetD2dJettyInfo(info);
            }
        }
    }
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::BindJettyForUbdma()
{
    COND_PROC((!IsSoftwareSqEnable()) || (!Runtime::Instance()->GetConnectUbFlag()), return RT_ERROR_NONE);
    RT_LOG(RT_LOG_DEBUG, "BindJettyForUbdma, model_id=%u.", Id_());
    const std::unique_lock<std::mutex> lk(jettyMutex_);
    for (Stream *stm : StreamList_()) {
        rtError_t error = BindJetty(stm, JettyType::JETTY_TYPE_H2D);
        ERROR_RETURN_MSG_INNER(error, "BindJetty H2D failed, stream_id=%d, ret=%d.", stm->Id_(), error);
        error = BindJetty(stm, JettyType::JETTY_TYPE_D2D);
        ERROR_RETURN_MSG_INNER(error, "BindJetty D2D failed, stream_id=%d, ret=%d.", stm->Id_(), error);
    }

    // jetty 可能因回收而更换，清空旧 info 列表,重新添加
    rtError_t error = RefreshJettyInfoList();
    ERROR_RETURN_MSG_INNER(error, "RefreshJettyInfoList failed, model_id=%u, ret=%d.", Id_(), error);
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::RecycleJetty(int32_t streamId, JettyType type, uint32_t &count) const
{
    JettyManager *jettyMgr = Context_()->Device_()->GetJettyManager();
    COND_RETURN_ERROR(jettyMgr == nullptr, RT_ERROR_INVALID_VALUE,
        "GetJettyManager returned null, stream_id=%d.", streamId);
    StreamJettyContext *ctx = jettyMgr->GetStreamJettyContext(streamId, type);
    if (ctx == nullptr || ctx->jettyHandle == 0) {
        return RT_ERROR_NONE;
    }
    rtError_t error = RT_ERROR_NONE;
    /**
        CaptureModel执行成功,这时候要手动下ud db将pi归0,未执行则不需要(未执行时jetty未绑定, ctx->jettyHandle == 0)
        执行失败,则在执行失败时释放所有jetty:ReleaseAllJetty(), 销毁jetty context
     */
    if (!ctx->isLargeDepth) {
        JettyInfo jettyInfo = {};
        error = jettyMgr->GetJettyInfoForStream(streamId, type, jettyInfo);
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
            "GetJettyInfoForStream failed for recycle, stream_id=%d, error=%d.", streamId, error);
        rtUbDbInfo_t dbInfo;
        dbInfo.wrCqe = 0U;
        dbInfo.dbNum = static_cast<uint8_t>(UB_DOORBELL_NUM_MIN);
        dbInfo.info[0].dieId = static_cast<uint16_t>(jettyInfo.dieId);
        dbInfo.info[0].jettyId = jettyInfo.jettyId;
        dbInfo.info[0].functionId = static_cast<uint16_t>(jettyInfo.functionId);
        dbInfo.info[0].piValue = ctx->capacity - ctx->filledWqeCount;
        Stream * const stm = Context_()->GetCtrlSQStream();
        COND_RETURN_ERROR(stm == nullptr, RT_ERROR_STREAM_NULL,
            "GetCtrlSQStream return null, stream_id=%d.", streamId);
        error = StreamUbDbSend(&dbInfo, stm, static_cast<uint16_t>(UbDmaSqeSource::RT_UBDMA_SOURCE_MODEL_EXE));
        RT_LOG(RT_LOG_INFO, "sent ub doorbell to reset pi/ci, dieId=%u, functionId=%u, jettyId=%u, piValue=%u.",
            jettyInfo.dieId, jettyInfo.functionId, jettyInfo.jettyId, dbInfo.info[0].piValue);
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
            "send h2d ub doorbell failed, stream_id=%d, error=%d.", streamId, error);
        error = stm->Synchronize();
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
            "ub doorbell sync failed, stream_id=%d, error=%d.", streamId, error);

        error = jettyMgr->UnbindJettyForStream(streamId, type);
        ERROR_RETURN_MSG_INNER(error, "UnbindJettyForStream failed, stream_id=%d, type=%d, ret=%d.",
            streamId, static_cast<int32_t>(type), error);
        count++;
    }
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::RecycleAllJetty(uint32_t &h2dCount, uint32_t &d2dCount)
{
    const std::unique_lock<std::mutex> lk(jettyMutex_);
    h2dCount = 0U;
    d2dCount = 0U;
    for (Stream *stm : StreamList_()) {
        int32_t streamId = stm->Id_();
        rtError_t error = RecycleJetty(streamId, JettyType::JETTY_TYPE_H2D, h2dCount);
        ERROR_RETURN_MSG_INNER(error, "RecycleJetty H2D failed, stream_id=%d, ret=%d.", streamId, error);
        error = RecycleJetty(streamId, JettyType::JETTY_TYPE_D2D, d2dCount);
        ERROR_RETURN_MSG_INNER(error, "RecycleJetty D2D failed, stream_id=%d, ret=%d.", streamId, error);
    }
    SetNeedUpdateUBPi(false);
    ClearH2dJettyInfoList();
    ClearD2dJettyInfoList();
    RT_LOG(RT_LOG_DEBUG, "RecycleAllJetty completed, model_id=%u, h2d_count=%u, d2d_count=%u.",
        Id_(), h2dCount, d2dCount);
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::ReleaseJetty(int32_t streamId, JettyType type)
{
    JettyManager *jettyMgr = Context_()->Device_()->GetJettyManager();
    COND_RETURN_ERROR(jettyMgr == nullptr, RT_ERROR_INVALID_VALUE,
        "GetJettyManager returned null, stream_id=%d.", streamId);
    StreamJettyContext* context = jettyMgr->GetStreamJettyContext(streamId, type);
    if (context == nullptr) {
        return RT_ERROR_NONE;
    }

    const uint64_t savedHandle = context->jettyHandle;
    rtError_t error = RT_ERROR_NONE;

    if (context->isLargeDepth) {
        error = jettyMgr->UnbindJettyForStream(streamId, type);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "UnbindJettyForStream failed, stream_id=%d, ret=%d.", streamId, error);
        }
    } else if (savedHandle != 0) {
        error = jettyMgr->ReleaseJettyByHandle(savedHandle, type);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "ReleaseJettyByHandle failed, stream_id=%d, handle=%lu, ret=%d.",
                streamId, savedHandle, error);
        }
    }

    if (!context->wqeBuffers.empty()) {
        context->ReleaseBuffers(Context_()->Device_()->Driver_());
    }
    jettyMgr->DestroyStreamJettyContext(streamId, type);
    return error;
}

rtError_t CaptureModel::ReleaseAllJetty()
{
    COND_PROC((!IsSoftwareSqEnable()) || (!Runtime::Instance()->GetConnectUbFlag()), return RT_ERROR_NONE);
    RT_LOG(RT_LOG_DEBUG, "ReleaseAllJetty, model_id=%u.", Id_());
    const std::unique_lock<std::mutex> lk(jettyMutex_);
    rtError_t finalError = RT_ERROR_NONE;
    for (Stream *stm : StreamList_()) {
        int32_t streamId = stm->Id_();
        rtError_t ret = ReleaseJetty(streamId, JettyType::JETTY_TYPE_H2D);
        if (ret != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "ReleaseJetty H2D failed, stream_id=%d, ret=%d.", streamId, static_cast<int32_t>(ret));
            finalError = ret;
        }
        ret = ReleaseJetty(streamId, JettyType::JETTY_TYPE_D2D);
        if (ret != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "ReleaseJetty D2D failed, stream_id=%d, ret=%d.", streamId, static_cast<int32_t>(ret));
            finalError = ret;
        }
    }

    RT_LOG(RT_LOG_DEBUG, "ReleaseAllJetty completed, model_id=%u.", Id_());
    return finalError;
}

rtError_t CaptureModel::BuildActualExternalTaskSqe(TaskInfo* const task)
{
    if ((task == nullptr) || (task->stream == nullptr)) {
        return RT_ERROR_INVALID_VALUE;
    }
    if (task->stream->GetSqeBuffer() == nullptr) {
        return RT_ERROR_NONE;
    }
    const uint32_t sendSqeNum = GetSendDavidSqeNum(task);
    const size_t sqeOffset = sizeof(rtDavidSqe_t) * static_cast<size_t>(task->pos);
    const size_t sqeSize = sizeof(rtDavidSqe_t) * static_cast<size_t>(sendSqeNum);
    if ((sqeOffset + sqeSize) > task->stream->GetSqeBufferSize()) {
        return RT_ERROR_INVALID_VALUE;
    }
    std::vector<rtDavidSqe_t> sqes(sendSqeNum);
    TaskSqeInfo sqeInfo = {0ULL, 0ULL};
    ToConstructDavidSqe(task, sqes.data(), sqeInfo);
    const errno_t ret = memcpy_s(task->stream->GetSqeBuffer() + sqeOffset, sqeSize, sqes.data(), sqeSize);
    if (ret != EOK) {
        return RT_ERROR_INVALID_VALUE;
    }
    return RT_ERROR_NONE;
}

size_t CaptureModel::GetExternalRecordRefreshSlotSize(void) const { return sizeof(rtDavidSqe_t); }

rtError_t CaptureModel::FillExternalRecordRefreshSlot(void* const slot, uint64_t eventAddr) const
{
    if (slot == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    auto* const sqe = reinterpret_cast<rtDavidSqe_t*>(slot);
    *sqe = {};
    sqe->writeValueSqe.header.type = RT_DAVID_SQE_TYPE_WRITE_VALUE;
    sqe->writeValueSqe.header.ptrMode = 0U;
    sqe->writeValueSqe.awsize = RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;
    sqe->writeValueSqe.snoop = 0U;
    sqe->writeValueSqe.awcache = 2U;
    sqe->writeValueSqe.awprot = 0U;
    sqe->writeValueSqe.va = 1U;
    sqe->writeValueSqe.writeAddrLow = static_cast<uint32_t>(eventAddr & 0xFFFFFFFFU);
    sqe->writeValueSqe.writeAddrHigh = static_cast<uint32_t>((eventAddr >> 32U) & 0x1FFFFU);
    sqe->writeValueSqe.writeValuePart[0] = 1U;
    return RT_ERROR_NONE;
}
} // namespace runtime
} // namespace cce
