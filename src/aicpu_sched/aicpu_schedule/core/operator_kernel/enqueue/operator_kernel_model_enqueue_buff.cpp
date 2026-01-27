/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "operator_kernel_model_enqueue_buff.h"

#include "aicpusd_status.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_resource_manager.h"
#include "operator_kernel_common.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_MODEL_ENQUEUE_BUFF = "modelEnqueueBuff";
constexpr uint32_t ENQUEUED_TIMEOUT = 1000U;
}  // namespace

int32_t OperatorKernelModelEnqueueBuff::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    auto bufInfo = reinterpret_cast<BufEnQueueBuffInfo *>(static_cast<uintptr_t>(kernelTaskInfo.paraBase));
    if (bufInfo == nullptr) {
        aicpusd_err("ModelEnqueue kernelTaskInfo paramBase is null, modelId[%u], streamId[%u], taskId[%u]",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    const auto ret = ModelEnqueueBuff(*bufInfo, taskContext);
    return ret;
}

int32_t OperatorKernelModelEnqueueBuff::ModelEnqueueBuff(BufEnQueueBuffInfo &bufInfo,
                                                         const RunContext &taskContext) const
{
    const auto model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if ((model != nullptr) && (model->GetModelRetCode() != 0)) {
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
    const auto guardRet = BufManager::GetInstance().GuardBuf(*mBufPptr, taskContext.modelId);
    if (guardRet != AICPU_SCHEDULE_OK) {
        aicpusd_err("BufManager guard dequeue failed, modelId[%u], ret[%d].", taskContext.modelId, guardRet);
        return guardRet;
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

    const uint32_t queueId = bufInfo.queueID;
    const uint32_t deviceId = static_cast<uint32_t>(bufInfo.deviceId);
    const auto drvRet = QueueEnQueueBuff(deviceId, queueId, *mBufPptr, headBuf, headSize);
    if (drvRet != DRV_ERROR_NONE) {
        aicpusd_err("Failed to enqueue on queueId[%u], drvRet[%d].", queueId, drvRet);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }

    OperatorKernelCommon::TraceQueueData(taskContext, headBuf, headSize, "EnqueuedBuff");
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelModelEnqueueBuff::QueueEnQueueBuff(const uint32_t deviceId, const uint32_t queueId,
                                                         Mbuf *const mbuf, void *const headBuf,
                                                         const uint32_t headSize) const
{
    uint64_t mbufLen = 0UL;
    int32_t ret = halMbufGetDataLen(mbuf, &mbufLen);
    if (ret != DRV_ERROR_NONE) {
        aicpusd_err("Get mbuf datalen failed. deviceId[%u], queueId[%u]", deviceId, queueId);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }
    constexpr size_t totalLen = sizeof(struct buff_iovec) + sizeof(struct iovec_info);
    std::unique_ptr<char_t[]> vecUniquePtr(new (std::nothrow) char_t[totalLen], std::default_delete<char_t[]>());
    if (vecUniquePtr == nullptr) {
        aicpusd_err("failed to alloc memory for buffIovec, size[%zu].", totalLen);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    void *dataAddrPtr = nullptr;
    ret = OperatorKernelCommon::GetMbufDataPtr(static_cast<uint64_t>(reinterpret_cast<uintptr_t>(&mbuf)), &dataAddrPtr);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Failed to get mbuf data addr. ret is [%d]", ret);
        return ret;
    }

    buff_iovec * const buffIovec = reinterpret_cast<buff_iovec *>(vecUniquePtr.get());
    buffIovec->context_base = headBuf;
    buffIovec->context_len = headSize;
    buffIovec->count = 1U;
    buffIovec->ptr[0U].iovec_base = dataAddrPtr;
    buffIovec->ptr[0U].len = mbufLen;
    const auto drvRet = halQueueEnQueueBuff(deviceId, queueId, buffIovec, ENQUEUED_TIMEOUT);
    if (drvRet != DRV_ERROR_NONE) {
        aicpusd_err("halQueueEnQueueBuff to queue[%u] in device[%u] failed, error[%d]",
            queueId, deviceId, static_cast<int32_t>(drvRet));
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }
    return AICPU_SCHEDULE_OK;
}


REGISTER_OPERATOR_KERNEL(KERNEL_MODEL_ENQUEUE_BUFF, OperatorKernelModelEnqueueBuff);
}  // namespace AicpuSchedule