/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_dequeue_base.h"

#include "aicpusd_profiler.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_resource_manager.h"
#include "operator_kernel_common.h"


namespace AicpuSchedule {
int32_t OperatorKernelDequeueBase::DequeueTask(BufEnQueueInfo &bufInfo, const RunContext &taskContext,
                                                const bool needPending) const
{
    void *taskMBuf = nullptr;
    Mbuf ** const mBufPptr = reinterpret_cast<Mbuf **>(static_cast<uintptr_t>(bufInfo.mBufPtr));
    if (mBufPptr == nullptr) {
        aicpusd_err("param mBufPptr is null.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    const auto queueId = bufInfo.queueID;
    const auto streamId = taskContext.streamId;
    const auto deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
    // clear unused eventState
    EventWaitManager::QueueNotEmptyWaitManager().ResetEventState(static_cast<size_t>(queueId));
    int32_t ret = AICPU_SCHEDULE_OK;
    g_aicpuProfiler.SetQueueId(queueId);
    do {
        ret = halQueueDeQueue(deviceId, queueId, &taskMBuf);
        if (ret == DRV_ERROR_NONE) {
            // guard taskMBuf
            const auto guardRet = BufManager::GetInstance().GuardBuf(reinterpret_cast<Mbuf *>(taskMBuf),
                                                                     taskContext.modelId);
            if (guardRet != AICPU_SCHEDULE_OK) {
                aicpusd_err("BufManager guard dequeue failed, modelId[%u], ret[%d].", taskContext.modelId, guardRet);
                return guardRet;
            }
            break;
        }
        if (ret == DRV_ERROR_QUEUE_EMPTY) {
            aicpusd_run_info("Dequeue empty on queueId[%u], ret[%d].", queueId, ret);
            if (needPending) {
                bool needWait = false;
                // if exist NotEmptyEvent, needWait return true and not record wait stream
                EventWaitManager::QueueNotEmptyWaitManager().
                    WaitEvent(static_cast<size_t>(queueId), streamId, needWait);
                if (needWait) {
                    aicpusd_run_info("%s pending, queueId:%u, streamId:%u.", __func__, queueId, streamId);
                    bool *pending = const_cast<bool *>(&taskContext.pending);
                    *pending = true;
                    return AICPU_SCHEDULE_OK;
                }
            } else {
                aicpusd_info("no need pending");
                return AICPU_SCHEDULE_OK;
            }
        } else {
            aicpusd_err("Failed to dequeue on queueId[%u], ret[%d].", queueId, ret);
            return AICPU_SCHEDULE_ERROR_FROM_DRV;
        }
    } while (true);
    *mBufPptr = PtrToPtr<void, Mbuf>(taskMBuf);

    uint32_t headSize = 0U;
    void *headBuf = nullptr;
    const auto drvRet = halMbufGetPrivInfo(*mBufPptr, &headBuf, &headSize);
    if (drvRet != DRV_ERROR_NONE) {
        aicpusd_err("Failed to get head info in input information, ret[%d].", drvRet);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }

    (void)ProcessMbufHeadInDequeueTask(taskContext.modelId, headBuf, headSize);
    (void)SetModelEndOfSequence(taskContext.modelId, headBuf, headSize);

    g_aicpuProfiler.SetMbufHead(headBuf);
    OperatorKernelCommon::TraceQueueData(taskContext, headBuf, headSize, "Dequeued");
    return AICPU_SCHEDULE_OK;
}

void OperatorKernelDequeueBase::ProcessMbufHeadInDequeueTask(const uint32_t modelId, void * const headBuf,
                                                             const uint32_t headSize) const
{
    if ((headBuf == nullptr) || (static_cast<size_t>(headSize) < sizeof(MbufHeadMsg))) {
        aicpusd_debug("Skip process mbuf head msg. modelId=%u, headSize=%u, baseSize=%lu",
                      modelId, headSize, sizeof(MbufHeadMsg));
        return;
    }

    MbufHeadMsg * const msg = PtrToPtr<uint8_t, MbufHeadMsg>(PtrAdd<uint8_t>(PtrToPtr<void, uint8_t>(headBuf),
                              MBUF_HEAD_MAX_SIZE, static_cast<size_t>(headSize) - sizeof(MbufHeadMsg)));

    SetModelNullData(modelId, msg);
    SetModelRetCode(modelId, msg);
    SetMbufStepId(modelId, msg);

    return;
}

void OperatorKernelDequeueBase::SetModelEndOfSequence(const uint32_t modelId, void * const headBuf,
                                                      const uint32_t headSize) const
{
    const auto model = AicpuModelManager::GetInstance().GetModel(modelId);
    if (model == nullptr) {
        return;
    }

    if ((headBuf != nullptr) && (headSize > MBUF_HEAD_END_OF_SEQUENCE_POS)) {
        const uint8_t * const endOfSequence = PtrAdd<uint8_t>(PtrToPtr<void, uint8_t>(headBuf), MBUF_HEAD_MAX_SIZE,
            static_cast<size_t>(MBUF_HEAD_END_OF_SEQUENCE_POS));
        if (*endOfSequence == END_OF_SEQUENCE_FLAG) {
            model->SetModelEndOfSequence();
            aicpusd_info("Set model end of sequence success.");
        }
    }
}

void OperatorKernelDequeueBase::SetModelNullData(const uint32_t modelId, const MbufHeadMsg * const headMsg) const
{
    if (!FeatureCtrl::ShouldSetModuleNullData()) {
        aicpusd_info("skip SetModelNullData");
        return;
    }

    aicpusd_info("Mbuf head msg, flags=%u, dataFlag=%u.", headMsg->flags, headMsg->dataFlag);
    if ((headMsg->dataFlag & MBUF_HEAD_DATA_FLAG_MASK) == static_cast<uint8_t>(DataFlag::DFLOW_NULL_DATA_FLAG)) {
        const auto model = AicpuModelManager::GetInstance().GetModel(modelId);
        if (model == nullptr) {
            aicpusd_debug("Skip process mbuf head msg, model is null. modelId=%u", modelId);
            return;
        }

        model->SetNullDataFlag(true);
    }

    return;
}

void OperatorKernelDequeueBase::SetModelRetCode(const uint32_t modelId, const MbufHeadMsg * const headMsg) const
{
    const auto model = AicpuModelManager::GetInstance().GetModel(modelId);
    if (model == nullptr) {
        aicpusd_debug("Skip process mbuf head msg, model is null. modelId=%u", modelId);
        return;
    }

    if (!model->AbnormalEnabled()) {
        // The input mbuf may not be initialized. Set retcode when abnormal enabled
        return;
    }

    if ((headMsg->retCode != 0) && (model->GetModelRetCode() == 0)) {
        model->SetModelRetCode(headMsg->retCode);
        aicpusd_info("Set model ret code success, modelId=%u, retCode=%d", model->GetId(), headMsg->retCode);
    }

    return;
}

void OperatorKernelDequeueBase::SetMbufStepId(const uint32_t modelId, MbufHeadMsg * const headMsg) const
{
    const auto model = AicpuModelManager::GetInstance().GetModel(modelId);
    if (model == nullptr) {
        aicpusd_debug("Skip process mbuf head msg, model is null. modelId=%u", modelId);
        return;
    }

    const StepIdInfo info = model->GetStepIdInfo();
    if (model->GetHeadNodeFlag()) {
        // head node set step id to mbuf head
        aicpusd_debug("set mbuf head. modelId=%u, before=%u, after=%u", modelId, headMsg->stepId, info.stepId);
        headMsg->stepId = info.stepId;
    } else {
        // get step id from mbuf head and refresh global step id
        if (info.stepIdAddr != nullptr) {
            aicpusd_debug("get mbuf head. modelId=%u, before=%lu, after=%u",
                          modelId, *info.stepIdAddr, headMsg->stepId);
            if (*info.stepIdAddr <= headMsg->stepId) {
                *info.stepIdAddr = headMsg->stepId;
            }
        }
    }

    return;
}

int32_t OperatorKernelDequeueBase::AlignTimestamp(BatchDequeueInfo &batchDeqInfo, const RunContext &taskContext,
                                                  uint32_t &maxAlignTimestamp, uint32_t &minAlignTimestamp,
                                                  uint32_t &minTimestampIndex)
{
    uint32_t minTimestamp = UINT32_MAX;
    for (uint32_t i = 0U; i < batchDeqInfo.inputNums; ++i) {
        // mbuf and mbufHead has been checked in dequeue, not nullptr
        Mbuf ** const mbufpPtr = PtrToPtr<void, Mbuf*>(ValueToPtr(batchDeqInfo.mbufAddrs[i]));
        uint32_t headSize = 0U;
        void *headBuf = nullptr;
        (void) halMbufGetPrivInfo(*mbufpPtr, &headBuf, &headSize);
        if (headBuf == nullptr || static_cast<size_t>(headSize) < sizeof(MbufHeadMsg)) {
            aicpusd_err("Mbuf head is error headSize[%u]", headSize);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        const MbufHeadMsg * const curHeadInfo = PtrToPtr<uint8_t, MbufHeadMsg>(PtrAdd<uint8_t>(
            PtrToPtr<void, uint8_t>(headBuf), MBUF_HEAD_MAX_SIZE, static_cast<size_t>(headSize) - sizeof(MbufHeadMsg)));
        if (curHeadInfo->startTime != curHeadInfo->endTime) {
            aicpusd_err("Mbuf head starttime[%llu] and endtime[%llu] not equal",
                        curHeadInfo->startTime, curHeadInfo->endTime);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        const uint32_t curTimeStamp = static_cast<uint32_t>(curHeadInfo->startTime);
        if (curTimeStamp < batchDeqInfo.alignOffsets[i]) {
            aicpusd_err("Mbuf head timestamp[%u] < alignOffset[%u], modelId[%u], streamId[%u]",
                curTimeStamp, batchDeqInfo.alignOffsets[i], taskContext.modelId, taskContext.streamId);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        const uint32_t timeAlign = curTimeStamp - batchDeqInfo.alignOffsets[i];
        if (curTimeStamp < minTimestamp) {
            minTimestamp = curTimeStamp;
            minTimestampIndex = i;
        }
        if (timeAlign > maxAlignTimestamp) {
            maxAlignTimestamp = timeAlign;
        }
        if (timeAlign < minAlignTimestamp) {
            minAlignTimestamp = timeAlign;
        }
    }
    return AICPU_SCHEDULE_OK;
}

}  // namespace AicpuSchedule