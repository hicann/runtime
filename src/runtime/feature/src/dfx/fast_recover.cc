/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "fast_recover.hpp"
#include "stream_c.hpp"
#include "task_starsv2.hpp"
#include "stream_factory.hpp"
#include "error_message_manage.hpp"
#include "thread_local_container.hpp"
#include "context_data_manage.h"

namespace cce {
namespace runtime {

rtError_t CtxStreamTaskClean(Context *const ctx)
{
    rtError_t error = RT_ERROR_NONE;
    std::unique_lock<std::mutex> taskLock(ctx->streamLock_);
    Device *dev = ctx->Device_();
    error = ctx->DefaultStream_()->ResClear();
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "ResClear default stream fail, retCode=%#x.", error);
    error = ctx->DefaultStream_()->SqCqUpdate();
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "Update default stream fail, retCode=%#x.", error);
    for (Stream *stream : ctx->StreamList_()) {
        if ((stream->Flags() & RT_STREAM_PERSISTENT) != 0) {
            continue;
        }
        if ((stream->Flags() & RT_STREAM_CP_PROCESS_USE) == 0U) {
            error = stream->ResClear();
            COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "ResClear fail, retCode=%#x.", error);
            error = stream->SqCqUpdate();
            COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "Update stream fail, retCode=%#x.", error);
        } else {
            error = dev->Driver_()->ResetSqCq(dev->Id_(), dev->DevGetTsId(), stream->GetSqId(), stream->Flags());
            ERROR_RETURN(error, "ResetSqCq fail, sq_id=%u, retCode=%#x.", stream->GetSqId(), error);
            error = dev->Driver_()->ResetLogicCq(dev->Id_(), dev->DevGetTsId(), stream->GetLogicalCqId(), stream->Flags());
            ERROR_RETURN(error, "ResetLogicCq fail, logicCq_id=%u, retCode=%#x.", stream->GetLogicalCqId(), error);
        }
    }
    return error;
}

rtError_t DeviceTaskSendStop(const int32_t devId, const uint64_t timeRemain)
{
    RT_LOG(RT_LOG_INFO, "DeviceStop[%u] start", devId);
    rtError_t error = RT_ERROR_CONTEXT_NULL;
    const uint64_t startTime = ClockGetTimeUs();
    const WriteProtect wp(&ContextDataManage::Instance().GetSetRwLock());
    for (Context *const ctx : ContextDataManage::Instance().GetSetObj()) {
        COND_PROC((ctx->Device_()->Id_() != static_cast<uint32_t>(devId)), continue);
        ctx->Device_()->SetDeviceStatus(RT_ERROR_DEVICE_TASK_ABORT);
        ctx->SetFailureError(RT_ERROR_DEVICE_TASK_ABORT);
        ctx->SetStreamsStatus(RT_ERROR_DEVICE_TASK_ABORT);
        error = ctx->Device_()->Driver_()->StopSqSend(static_cast<uint32_t>(devId), ctx->Device_()->DevGetTsId());
        ERROR_RETURN(error, "ctx clean fail, retCode=%#x.", error);
        const uint64_t count = ClockGetTimeIntervalUs(startTime);
        COND_RETURN_ERROR(((timeRemain != 0U) && (count >= timeRemain)), RT_ERROR_WAIT_TIMEOUT,
            "Abort kill timeout, device_id=%u, time=%luus", devId, count);
    }
    RT_LOG(RT_LOG_INFO, "DeviceStop[%u] end", devId);
    return error;
}

rtError_t StarsV2DeviceKill(const int32_t devId, const uint32_t op, const uint64_t timeRemain)
{
    RT_LOG(RT_LOG_INFO, "DeviceKill[%u] op=%u start", devId, op);
    rtError_t error = RT_ERROR_CONTEXT_NULL;
    const uint64_t startTime = ClockGetTimeUs();
    uint64_t count = 0U;
    const WriteProtect wp(&ContextDataManage::Instance().GetSetRwLock());
    for (Context *const ctx : ContextDataManage::Instance().GetSetObj()) {
        COND_PROC((ctx->Device_()->Id_() != static_cast<uint32_t>(devId)), continue);

        uint32_t result = static_cast<uint32_t>(TS_ERROR_APP_QUEUE_FULL);
        while (result == static_cast<uint32_t>(TS_ERROR_APP_QUEUE_FULL)) {
            if (op == OP_ABORT_APP) {
                error = ctx->Device_()->Driver_()->TaskAbortByType(static_cast<uint32_t>(devId), ctx->Device_()->DevGetTsId(),
                    OP_ABORT_APP, UINT32_MAX, result);
            } else if (op == OP_RECOVER_APP) {
                error = ctx->Device_()->Driver_()->RecoverAbortByType(static_cast<uint32_t>(devId), ctx->Device_()->DevGetTsId(),
                    OP_RECOVER_APP, UINT32_MAX, result);
            } else {
                // no operation
            }
            ERROR_RETURN(error, "Failed to notice device, op=%u, device_id=%d,"
                " retCode=%#x.", op, devId, error);
            if (result == TS_SUCCESS) {
                break;
            }
            COND_RETURN_ERROR((result == TS_ERROR_ILLEGAL_PARAM) || (result == TS_APP_EXIT_UNFINISHED) ||
                (result == TS_ERROR_ABORT_UNFINISHED), RT_ERROR_TSFW_ILLEGAL_PARAM,
                "TS param invalid or proc unfinished, device_id=%u, op=%u, result=%u.", devId, op, result);

            count = ClockGetTimeIntervalUs(startTime);
            COND_RETURN_ERROR(((timeRemain != 0U) && (count >= timeRemain)), RT_ERROR_WAIT_TIMEOUT,
                "Abort kill timeout, device_id=%u, op=%u, time=%luus", devId, op, count);
            (void)mmSleep(1U);
        }

        RT_LOG(RT_LOG_INFO, "DeviceKill[%u] op=%u, time=%luus, end", devId, op, count);
        return error; // one pid kill once
    }
    return error;
}

rtError_t StarsV2DeviceQuery(const int32_t devId, const uint32_t op, const uint64_t timeRemain)
{
    RT_LOG(RT_LOG_INFO, "DeviceQuery[%u] op=%u start.", devId, op);
    rtError_t error = RT_ERROR_CONTEXT_NULL;
    const uint64_t startTime = ClockGetTimeUs();
    const WriteProtect wp(&ContextDataManage::Instance().GetSetRwLock());
    for (Context *const ctx : ContextDataManage::Instance().GetSetObj()) {
        COND_PROC((ctx->Device_()->Id_() != static_cast<uint32_t>(devId)), continue);
        uint64_t count = 0U;
        uint32_t status = 0U;
        while (true) {
            if (op == OP_QUERY_ABORT_STATUS) {
                error = ctx->Device_()->Driver_()->QueryAbortStatusByType(static_cast<uint32_t>(devId), ctx->Device_()->DevGetTsId(),
                    RECOVER_STS_QUERY_BY_PID, UINT32_MAX, status);
                ERROR_RETURN(error, "Failed to query abort, device_id=%d, op=%u, retCode=%#x.",
                    devId, op, error);
                if ((status == STARSV2_ABORT_TERMINATE_SUCC) || (status == STARSV2_ABORT_STOP_FINISH)) {
                    break;
                }
            } else if (op == OP_QUERY_RECOVER_STATUS) {
                error = ctx->Device_()->Driver_()->QueryRecoverStatusByType(static_cast<uint32_t>(devId), ctx->Device_()->DevGetTsId(),
                    RECOVER_STS_QUERY_BY_PID, UINT32_MAX, status);
                ERROR_RETURN(error,
                    "Failed to query recover, device_id=%d, op=%u, retCode=%#x.", devId, op, error);
                if (status == STARSV2_ABORT_TERMINATE_SUCC) {
                    break;
                }
            } else {
                // no operation
            }
            COND_RETURN_ERROR((status == STARSV2_ABORT_TERMINATE_FAIL), RT_ERROR_TSFW_ILLEGAL_PARAM,
                "TS param invalid, device_id=%u, op=%u, result=%u.", devId, op, status);

            count = ClockGetTimeIntervalUs(startTime);
            COND_RETURN_ERROR(((timeRemain != 0U) && (count >= timeRemain)),
                RT_ERROR_WAIT_TIMEOUT, "Abort query timeout, device_id=%u, op=%u, time=%luus.", devId, op, count);
            (void)mmSleep(5U);
        }

        RT_LOG(RT_LOG_INFO, "DeviceQuery[%u] op=%u end, time=%luus.", devId, op, count);
        return error; // one pid kill once
    }
    return error;
}

rtError_t DeviceTaskSendResume(const int32_t devId, const uint64_t timeRemain)
{
    RT_LOG(RT_LOG_INFO, "DeviceResume[%u] start", devId);
    rtError_t error = RT_ERROR_CONTEXT_NULL;
    uint64_t count = 0U;
    Device *dev = nullptr;
    const uint64_t startTime = ClockGetTimeUs();
    const WriteProtect wp(&ContextDataManage::Instance().GetSetRwLock());
    for (Context *const ctx : ContextDataManage::Instance().GetSetObj()) {
        COND_PROC((ctx->Device_()->Id_() != static_cast<uint32_t>(devId)), continue);
        dev = ctx->Device_();
        error = CtxStreamTaskClean(ctx);
        ERROR_RETURN(error, "ctx task clean fail, retCode=%#x.", error);
    }
    if (dev != nullptr) {
        error = dev->ProcCleanRingbuffer();
        ERROR_RETURN(error, "ctx ringbuffer clean fail, retCode=%#x.", error);
        error = dev->Driver_()->ResourceReset(static_cast<uint32_t>(devId), dev->DevGetTsId(), DRV_NOTIFY_ID);
        ERROR_RETURN(error, "ctx reset notify fail, retCode=%#x.", error);
        error = dev->Driver_()->ResourceReset(static_cast<uint32_t>(devId), dev->DevGetTsId(), DRV_CNT_NOTIFY_ID);
        ERROR_RETURN(error, "ctx reset cntnotify fail, retCode=%#x.", error);
        error = dev->Driver_()->ResumeSqSend(static_cast<uint32_t>(devId), dev->DevGetTsId());
        ERROR_RETURN(error, "ctx resume fail, retCode=%#x.", error);
        dev->SetDeviceStatus(RT_ERROR_NONE);
        dev->SetHasTaskError(false);
        dev->SetMonitorExitFlag(false);
    }
    for (Context *const ctx : ContextDataManage::Instance().GetSetObj()) {
        COND_PROC((ctx->Device_()->Id_() != static_cast<uint32_t>(devId)), continue);
        ctx->SetStreamsStatus(RT_ERROR_NONE);
        ctx->SetFailureError(RT_ERROR_NONE);
    }
    count = ClockGetTimeIntervalUs(startTime);
    COND_RETURN_ERROR(((timeRemain != 0U) && (count >= timeRemain)),
        RT_ERROR_WAIT_TIMEOUT, "DeviceResume timeout, device_id=%u, time=%lu us", devId, count);
    RT_LOG(RT_LOG_INFO, "DeviceResume[%u] end, time=%lu us.", devId, count);
    return error;
}

rtError_t StarsV2DeviceTaskAbort(const int32_t devId, const uint32_t time)
{
    Runtime * const rtInstance = Runtime::Instance();
    const uint64_t timeout = static_cast<uint64_t>(time) * 1000ULL;
    uint64_t timeCost[10U] = {0U}; // 10 step
    uint8_t index = 0U;
    const uint64_t startTime = ClockGetTimeUs();
    std::function<void()> const abortTimeoutInfo = [&devId, &index, &timeCost]() {
        for (int32_t i = 1U; i <= index; ++i) {
            RT_LOG(RT_LOG_EVENT, "device_id=%d, step %d: time cost=%llu us", devId, i, (timeCost[i] - timeCost[i-1]));
        }
    };
    ScopeGuard abortInfo(abortTimeoutInfo);
    /* 1. Stop host/device sq task send */
    rtError_t error = DeviceTaskSendStop(devId, timeout);
    ERROR_RETURN_MSG_INNER(error, "DeviceStop, retCode=%#x", static_cast<uint32_t>(error));
    timeCost[++index] = ClockGetTimeIntervalUs(startTime);
    COND_RETURN_ERROR(((timeout != 0U) && (timeCost[index] > timeout)), RT_ERROR_WAIT_TIMEOUT,
        "DeviceStop timeout, device_id=%d.", devId);

    /* 2. Callback HCCL to stop MC2 expand */
    error = rtInstance->TaskAbortCallBack(devId, RT_DEVICE_ABORT_PRE,
        ((timeout != 0U) ? (timeout - timeCost[index]) : timeout) / RT_US_TO_MS);
    ERROR_RETURN_MSG_INNER(error, "ABORT_PRE, retCode=%#x", static_cast<uint32_t>(error));
    timeCost[++index] = ClockGetTimeIntervalUs(startTime);
    COND_RETURN_ERROR(((timeout != 0U) && (timeCost[index] > timeout)), RT_ERROR_WAIT_TIMEOUT,
        "ABORT_PRE timeout, device_id=%d.", devId);

    /* 3. Notice TS terminate all sq */
    error = StarsV2DeviceKill(devId, OP_ABORT_APP, (timeout != 0U) ? (timeout - timeCost[index]) : timeout);
    ERROR_RETURN_MSG_INNER(error, "Abort app, retCode=%#x", static_cast<uint32_t>(error));
    timeCost[++index] = ClockGetTimeIntervalUs(startTime);
    COND_RETURN_ERROR(((timeout != 0U) && (timeCost[index] > timeout)), RT_ERROR_WAIT_TIMEOUT,
        "Abort app timeout, device_id=%d.", devId);

    /* 4. Query all single and model stream terminate/stop succ */
    error = StarsV2DeviceQuery(devId, OP_QUERY_ABORT_STATUS, (timeout != 0U) ? (timeout - timeCost[index]) : timeout);
    ERROR_RETURN_MSG_INNER(error, "Query abort, retCode=%#x", static_cast<uint32_t>(error));
    timeCost[++index] = ClockGetTimeIntervalUs(startTime);
    COND_RETURN_ERROR(((timeout != 0U) && (timeCost[index] > timeout)), RT_ERROR_WAIT_TIMEOUT,
        "Query abort timeout, device_id=%d.", devId);

    /* 5. Callback HCCL to clean all communication domain */
    error = rtInstance->TaskAbortCallBack(devId, RT_DEVICE_ABORT_POST,
        ((timeout != 0U) ? (timeout - timeCost[index]) : timeout) / RT_US_TO_MS);
    ERROR_RETURN_MSG_INNER(error, "ABORT_POST, retCode=%#x", static_cast<uint32_t>(error));
    timeCost[++index] = ClockGetTimeIntervalUs(startTime);
    COND_RETURN_ERROR(((timeout != 0U) && (timeCost[index] > timeout)), RT_ERROR_WAIT_TIMEOUT,
        "ABORT_POST timeout, device_id=%d.", devId);

    /* 6. Notice TS recover all stop sq */
    error = StarsV2DeviceKill(devId, OP_RECOVER_APP, (timeout != 0U) ? (timeout - timeCost[index]) : timeout);
    ERROR_RETURN_MSG_INNER(error, "Recover app, retCode=%#x", static_cast<uint32_t>(error));
    timeCost[++index] = ClockGetTimeIntervalUs(startTime);
    COND_RETURN_ERROR(((timeout != 0U) && (timeCost[index] > timeout)), RT_ERROR_WAIT_TIMEOUT,
        "Recover app timeout, device_id=%d.", devId);

    /* 7. Query all sq terminate succ */
    error = StarsV2DeviceQuery(devId, OP_QUERY_RECOVER_STATUS, (timeout != 0U) ? (timeout - timeCost[index]) : timeout);
    ERROR_RETURN_MSG_INNER(error, "Query recover, retCode=%#x", static_cast<uint32_t>(error));
    timeCost[++index] = ClockGetTimeIntervalUs(startTime);
    COND_RETURN_ERROR(((timeout != 0U) && (timeCost[index] > timeout)), RT_ERROR_WAIT_TIMEOUT,
        "Query recover timeout, device_id=%d.", devId);

    /* 8. Resume device send */
    error = DeviceTaskSendResume(devId, (timeout != 0U) ? (timeout - timeCost[index]) : timeout);
    ERROR_RETURN_MSG_INNER(error, "DeviceResume, retCode=%#x", static_cast<uint32_t>(error));
    timeCost[++index] = ClockGetTimeIntervalUs(startTime);
    COND_RETURN_ERROR(((timeout != 0U) && (timeCost[index] > timeout)), RT_ERROR_WAIT_TIMEOUT,
        "DeviceResume timeout, device_id=%d.", devId);
    return error;
}

}  // namespace runtime
}  // namespace cce