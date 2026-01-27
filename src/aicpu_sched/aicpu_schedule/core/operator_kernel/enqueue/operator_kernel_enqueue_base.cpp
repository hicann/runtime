/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_enqueue_base.h"

#include "aicpusd_profiler.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_resource_manager.h"
#include "operator_kernel_common.h"


namespace AicpuSchedule {
int32_t OperatorKernelEnqueueBase::EnqueueTask(BufEnQueueInfo &bufInfo, const RunContext &taskContext) const
{
    const auto model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if ((model != nullptr) && (model->GetModelRetCode() != 0) && (!model->AbnormalNeedEnqueue())) {
        aicpusd_info("Model execute not success, no need to enqueue. modelId=%u, modelRetCode=%d.",
                     taskContext.modelId, model->GetModelRetCode());
        return AICPU_SCHEDULE_OK;
    }

    auto mBufPptr = reinterpret_cast<Mbuf **>(static_cast<uintptr_t>(bufInfo.mBufPtr));
    if (mBufPptr == nullptr) {
        aicpusd_err("param mBufPptr is null.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (*mBufPptr == nullptr) {
        aicpusd_err("param *mBufPptr is null.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    uint32_t headSize = 0U;
    void *headBuf = nullptr;
    const auto ret = halMbufGetPrivInfo(*mBufPptr, &headBuf, &headSize);
    if (ret != DRV_ERROR_NONE) {
        aicpusd_err("Failed to get head info in input information, ret[%d].", ret);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }
    SetMbufRetCode(taskContext.modelId, headBuf, headSize);
    SetMbufEndOfSequence(taskContext.modelId, headBuf, headSize);
    SetMbufNullData(taskContext.modelId, headBuf, headSize);

    g_aicpuProfiler.SetMbufHead(headBuf);
    const uint32_t queueId = bufInfo.queueID;
    const uint32_t streamId = taskContext.streamId;
    const auto deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
    // clear unused eventState
    EventWaitManager::QueueNotFullWaitManager().ResetEventState(static_cast<size_t>(queueId));
    g_aicpuProfiler.SetQueueId(queueId);
    auto backupMsg = OperatorKernelCommon::BackupHeadMsg(headBuf, headSize, "Enqueued");
    do {
        const auto drvRet = halQueueEnQueue(deviceId, queueId, *mBufPptr);
        if (drvRet == DRV_ERROR_NONE) {
                AicpuModel * const modelPtr = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
                if (modelPtr == nullptr) {
                    aicpusd_err("cannot get aicpuModel by modelId:[%u]!", taskContext.modelId);
                    return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
                }
            const auto guardRet = modelPtr->UnGardModelBuf(*mBufPptr);
            if (guardRet != AICPU_SCHEDULE_OK) {
                aicpusd_warn("BufManager unguard enqueued failed, modelId[%u], drvRet[%d].", taskContext.modelId,
                    guardRet);
            }
            break;
        } else if (drvRet == DRV_ERROR_QUEUE_FULL) {
            aicpusd_run_info("Enqueue full on queueId[%u], drvRet[%d].", queueId, drvRet);
            bool needWait = false;
            // if exist NotFullEvent, needWait return true and not record wait stream
            EventWaitManager::QueueNotFullWaitManager().WaitEvent(static_cast<size_t>(queueId), streamId, needWait);
            if (needWait) {
                aicpusd_run_info("ModelEnqueueTaskKernel pending, queueId:%u, streamId:%u.", queueId, streamId);
                bool *pending = const_cast<bool *>(&taskContext.pending);
                *pending = true;
                return AICPU_SCHEDULE_OK;
            }
        } else {
            aicpusd_err("Failed to enqueue on queueId[%u], drvRet[%d].", queueId, drvRet);
            return AICPU_SCHEDULE_ERROR_FROM_DRV;
        }
    } while (true);
    OperatorKernelCommon::DoTraceQueueData(taskContext, backupMsg.get(), "Enqueued");
    return AICPU_SCHEDULE_OK;
}

void OperatorKernelEnqueueBase::SetMbufRetCode(const uint32_t modelId, void * const headBuf,
                                               const uint32_t headSize) const
{
    if ((headBuf != nullptr) && (static_cast<size_t>(headSize) >= sizeof(MbufHeadMsg))) {
        int32_t retCode = 0;
        const auto model = AicpuModelManager::GetInstance().GetModel(modelId);
        if (model != nullptr) {
            retCode = model->GetModelRetCode();
            if (!model->AbnormalEnabled() || (retCode == 0)) {
                return;
            }
        }
        MbufHeadMsg * const msg = PtrToPtr<uint8_t, MbufHeadMsg>(PtrAdd<uint8_t>(PtrToPtr<void, uint8_t>(headBuf),
            MBUF_HEAD_MAX_SIZE, static_cast<size_t>(headSize) - sizeof(MbufHeadMsg)));
        msg->retCode = retCode;
    }
}

void OperatorKernelEnqueueBase::SetMbufEndOfSequence(const uint32_t modelId, void * const headBuf,
                                                     const uint32_t headSize) const
{
    if ((headBuf != nullptr) && (headSize > MBUF_HEAD_END_OF_SEQUENCE_POS)) {
        const auto model = AicpuModelManager::GetInstance().GetModel(modelId);
        if ((model != nullptr) && (model->IsEndOfSequence())) {
            uint8_t * const ret = PtrAdd<uint8_t>(PtrToPtr<void, uint8_t>(headBuf), MBUF_HEAD_MAX_SIZE,
                static_cast<size_t>(MBUF_HEAD_END_OF_SEQUENCE_POS));
            *ret = END_OF_SEQUENCE_FLAG;
        }
    }
}

void OperatorKernelEnqueueBase::SetMbufNullData(const uint32_t modelId, void * const headBuf,
                                                const uint32_t headSize) const
{
    if ((headBuf != nullptr) && (static_cast<size_t>(headSize) >= sizeof(MbufHeadMsg))) {
        const auto model = AicpuModelManager::GetInstance().GetModel(modelId);
        if ((model != nullptr) && model->GetNullDataFlag()) {
            MbufHeadMsg * const msg = PtrToPtr<uint8_t, MbufHeadMsg>(PtrAdd<uint8_t>(PtrToPtr<void, uint8_t>(headBuf),
                MBUF_HEAD_MAX_SIZE, static_cast<size_t>(headSize) - sizeof(MbufHeadMsg)));
            msg->dataFlag |= MBUF_HEAD_DATA_FLAG_MASK;
        }
    }
}
}  // namespace AicpuSchedule