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
#include "capture_model_utils.hpp"
#include "internal_error_define.hpp"
#include "stream_david.hpp"
#include "memory_task.h"
#include "task.hpp"
#include "stream_c.hpp"
#include "stream_jetty_handler.h"
#include "drv/driver.hpp"
#include "logic_sq.hpp"
#include "logic_sq_manage.hpp"
#include <securec.h>
#include <vector>
#include <algorithm>

namespace cce {
namespace runtime {

rtError_t CaptureModel::BindSqCqAndSendSqe(void)
{
    rtError_t error = BindSqCq();
    ERROR_RETURN(error, "Failed to bind SQ and CQ, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    error = RebuildAllExternalTaskSqes();
    ERROR_RETURN(
        error, "Failed to rebuild external task SQE, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    error = SendSqe();
    ERROR_RETURN(error, "Failed to send SQE, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    error = BindStreamToModel();
    ERROR_RETURN(
        error, "Failed to bind stream to model, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    error = ConfigLogicSqTail();
    ERROR_RETURN(error, "Failed to configure SQ tail, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    return error;
}

rtError_t CaptureModel::RefreshJettyInfoList()
{
    JettyManager* jettyMgr = Context_()->Device_()->GetJettyManager();
    NULL_PTR_RETURN(jettyMgr, RT_ERROR_INVALID_VALUE);
    ClearJettyInfoList();
    for (Stream* stm : StreamList_()) {
        const int32_t streamId = stm->Id_();
        for (const JettyType type :
             {JettyType::JETTY_TYPE_H2D, JettyType::JETTY_TYPE_D2D_IN_BOARD, JettyType::JETTY_TYPE_D2D_CROSS_BOARD}) {
            StreamJettyContext* jettyCtx = jettyMgr->GetStreamJettyContext(streamId, type);
            if (jettyCtx == nullptr || jettyCtx->jettyHandle == 0U || jettyCtx->filledWqeCount == 0U) {
                continue;
            }
            JettyInfo jettyInfo = {};
            const rtError_t ret = jettyMgr->GetJettyInfoForStream(streamId, type, jettyInfo);
            COND_RETURN_ERROR(
                (ret != RT_ERROR_NONE), ret, "GetJettyInfoForStream failed, stream_id=%d, type=%s(%d), retCode=%#x.",
                streamId, JettyTypeName(type), static_cast<int32_t>(type), ret);

            UbAsyncJettyInfo info = {};
            info.dieId = static_cast<uint16_t>(std::min(jettyInfo.dieId, static_cast<uint32_t>(UINT16_MAX)));
            info.functionId = static_cast<uint16_t>(std::min(jettyInfo.functionId, static_cast<uint32_t>(UINT16_MAX)));
            info.jettyId = static_cast<uint16_t>(std::min(jettyInfo.jettyId, static_cast<uint32_t>(UINT16_MAX)));
            const uint32_t piVal = jettyCtx->capacity - jettyCtx->filledWqeCount;
            if ((piVal == 0U) || (piVal == jettyCtx->capacity)) {
                continue;
            }
            info.piValue = static_cast<uint16_t>(piVal);
            info.sqId = stm->GetSqId();
            SetJettyInfo(info);
        }
    }
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::BindJettyForUbdma()
{
    COND_PROC((!IsSoftwareSqEnable()) || (!Runtime::Instance()->GetConnectUbFlag()), return RT_ERROR_NONE);
    RT_LOG(RT_LOG_DEBUG, "BindJettyForUbdma, model_id=%u.", Id_());
    const std::unique_lock<std::mutex> lk(jettyMutex_);
    if (GetJettyBindFlag()) {
        SetNeedUpdateUBPi(true);
        RT_LOG(RT_LOG_DEBUG, "Jetty already bound, skip, model_id=%u.", Id_());
        return RT_ERROR_NONE;
    }

    for (Stream* stm : StreamList_()) {
        rtError_t error = StreamJettyHandler::BindJetty(stm, JettyType::JETTY_TYPE_H2D, this);
        COND_RETURN_ERROR(
            error != RT_ERROR_NONE, error, "BindJetty H2D failed, stream_id=%d, retCode=%#x.", stm->Id_(), error);
        error = StreamJettyHandler::BindJetty(stm, JettyType::JETTY_TYPE_D2D_IN_BOARD, this);
        COND_RETURN_ERROR(
            error != RT_ERROR_NONE, error, "BindJetty D2D in board failed, stream_id=%d, retCode=%#x.", stm->Id_(),
            error);
        error = StreamJettyHandler::BindJetty(stm, JettyType::JETTY_TYPE_D2D_CROSS_BOARD, this);
        COND_RETURN_ERROR(
            error != RT_ERROR_NONE, error, "BindJetty D2D cross board failed, stream_id=%d, retCode=%#x.", stm->Id_(),
            error);
    }

    // jetty 可能因回收而更换，清空旧 info 列表,重新添加
    const rtError_t error = RefreshJettyInfoList();
    ERROR_RETURN_MSG_INNER(error, "RefreshJettyInfoList failed, model_id=%u, retCode=%#x.", Id_(), error);
    SetJettyBindFlag(true);
    SetNeedUpdateUBPi(false);
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::RecycleAllJetty(uint32_t& h2dCount, uint32_t& d2dInBoardCount, uint32_t& d2dCrossBoardCount)
{
    const std::unique_lock<std::mutex> lk(jettyMutex_);
    h2dCount = 0U;
    d2dInBoardCount = 0U;
    d2dCrossBoardCount = 0U;
    for (Stream* stm : StreamList_()) {
        const int32_t streamId = stm->Id_();
        rtError_t error = StreamJettyHandler::RecycleJetty(stm, JettyType::JETTY_TYPE_H2D, h2dCount);
        COND_RETURN_ERROR(
            error != RT_ERROR_NONE, error, "RecycleJetty H2D failed, stream_id=%d, retCode=%#x.", streamId, error);
        error = StreamJettyHandler::RecycleJetty(stm, JettyType::JETTY_TYPE_D2D_IN_BOARD, d2dInBoardCount);
        COND_RETURN_ERROR(
            error != RT_ERROR_NONE, error, "RecycleJetty D2D in board failed, stream_id=%d, retCode=%#x.", streamId,
            error);
        error = StreamJettyHandler::RecycleJetty(stm, JettyType::JETTY_TYPE_D2D_CROSS_BOARD, d2dCrossBoardCount);
        COND_RETURN_ERROR(
            error != RT_ERROR_NONE, error, "RecycleJetty D2D cross board failed, stream_id=%d, retCode=%#x.", streamId,
            error);
    }
    SetNeedUpdateUBPi(false);
    ClearJettyInfoList();
    SetJettyBindFlag(false);
    RT_LOG(
        RT_LOG_DEBUG,
        "RecycleAllJetty completed, model_id=%u, h2d_count=%u, d2d_in_board_count=%u, d2d_cross_board_count=%u.", Id_(),
        h2dCount, d2dInBoardCount, d2dCrossBoardCount);
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::ReleaseAllJetty()
{
    COND_PROC((!IsSoftwareSqEnable()) || (!Runtime::Instance()->GetConnectUbFlag()), return RT_ERROR_NONE);
    RT_LOG(RT_LOG_DEBUG, "ReleaseAllJetty, model_id=%u.", Id_());
    const std::unique_lock<std::mutex> lk(jettyMutex_);
    rtError_t finalError = RT_ERROR_NONE;
    for (Stream* stm : StreamList_()) {
        const int32_t streamId = stm->Id_();
        rtError_t ret = StreamJettyHandler::ReleaseJetty(stm, JettyType::JETTY_TYPE_H2D);
        if (ret != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "ReleaseJetty H2D failed, stream_id=%d, retCode=%#x.", streamId, ret);
            finalError = ret;
        }
        ret = StreamJettyHandler::ReleaseJetty(stm, JettyType::JETTY_TYPE_D2D_IN_BOARD);
        if (ret != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "ReleaseJetty D2D in board failed, stream_id=%d, retCode=%#x.", streamId, ret);
            finalError = ret;
        }
        ret = StreamJettyHandler::ReleaseJetty(stm, JettyType::JETTY_TYPE_D2D_CROSS_BOARD);
        if (ret != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "ReleaseJetty D2D cross board failed, stream_id=%d, retCode=%#x.", streamId, ret);
            finalError = ret;
        }
    }

    SetJettyBindFlag(false);
    RT_LOG(RT_LOG_DEBUG, "ReleaseAllJetty completed, model_id=%u.", Id_());
    return finalError;
}

rtError_t UpdateHostSqeBufferByTask(TaskInfo* const task)
{
    if ((task == nullptr) || (task->stream == nullptr)) {
        return RT_ERROR_INVALID_VALUE;
    }

    uint8_t* sqeAddr = task->stream->GetHostSqeAddrByPos(task->pos);
    if (sqeAddr == nullptr) {
        RT_LOG(
            RT_LOG_ERROR, "Get host sqe addr failed, stream_id=%d, task_id=%u, task_pos=%u", task->stream->Id_(),
            task->id, task->pos);
        return RT_ERROR_INVALID_VALUE;
    }

    const uint32_t sendSqeNum = GetSendDavidSqeNum(task);
    const size_t sqeSize = sizeof(rtDavidSqe_t) * static_cast<size_t>(sendSqeNum);
    std::vector<rtDavidSqe_t> sqes(sendSqeNum);
    TaskSqeInfo sqeInfo = {0ULL, 0ULL};
    ToConstructDavidSqe(task, sqes.data(), sqeInfo);
    const errno_t ret = memcpy_s(sqeAddr, sqeSize, sqes.data(), sqeSize);
    if (ret != EOK) {
        return RT_ERROR_INVALID_VALUE;
    }
    return RT_ERROR_NONE;
}

size_t GetExternalRecordRefreshEntrySize(void) { return sizeof(rtDavidSqe_t); }

rtError_t FillExternalRecordRefreshEntry(void* const entry, uint64_t eventAddr)
{
    if (entry == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    auto* const sqe = RtPtrToPtr<rtDavidSqe_t*>(entry);
    *sqe = {};
    sqe->writeValueSqe.header.type = RT_DAVID_SQE_TYPE_WRITE_VALUE;
    sqe->writeValueSqe.header.ptrMode = 0U;
    sqe->writeValueSqe.awsize = RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;
    sqe->writeValueSqe.snoop = 0U;
    sqe->writeValueSqe.awcache = 2U;
    sqe->writeValueSqe.awprot = 0U;
    sqe->writeValueSqe.va = 1U;
    sqe->writeValueSqe.writeAddrLow = static_cast<uint32_t>(eventAddr & MASK_32_BIT);
    sqe->writeValueSqe.writeAddrHigh = static_cast<uint32_t>((eventAddr >> UINT32_BIT_NUM) & MASK_17_BIT);
    sqe->writeValueSqe.writeValuePart[0] = 1U;
    return RT_ERROR_NONE;
}
} // namespace runtime
} // namespace cce
