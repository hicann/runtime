/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_model_report_status.h"

#include "dynamic_sched.pb.h"
#include "aicpusd_status.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_model_execute.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_MODEL_REPORT_STATUS = "modelReportStatus";
}  // namespace

int32_t OperatorKernelModelReportStatus::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    const ReportStatusInfo * const bufInfo =
        PtrToPtr<void, ReportStatusInfo>(ValueToPtr(static_cast<uintptr_t>(kernelTaskInfo.paraBase)));
    if (bufInfo == nullptr) {
        aicpusd_err("ModelReportStatus kernelTaskInfo paramBase is null, modelId[%u], streamId[%u], taskId[%u]",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    std::vector<QueueAttrs> inputQueues;
    // 1 means queue info memory is after ReportStatusInfo memory
    const QueueAttrs *queuePtr = reinterpret_cast<const QueueAttrs *>(bufInfo + 1);
    for (uint32_t idx = 0U; idx < bufInfo->inputNum; idx++) {
        inputQueues.emplace_back(*queuePtr);
        queuePtr++;
    }
    const auto ret = ModelReportStatus(bufInfo->modelUuid, bufInfo->statusOutputQueue, inputQueues, taskContext);
    return ret;
}

int32_t OperatorKernelModelReportStatus::ModelReportStatus(const uint32_t modelUuid, const QueueAttrs &schedOutputQueue,
                                                           const std::vector<QueueAttrs> &inputQueues,
                                                           const RunContext &taskContext) const
{
    AicpuModel *const model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if (model == nullptr) {
        aicpusd_err("cannot get model by modelId:[%u]!", taskContext.modelId);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    uint32_t &inputConsumeNum = model->GetInputConsumeNumRef();
    inputConsumeNum++;
    // construct SubmodelStatus protobuf object
    const auto deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
    aicpu::dynamci_sched::SubmodelStatus submodelStatus;
    submodelStatus.set_model_uuid(modelUuid);
    for (const auto &inputQueue : inputQueues) {
        const uint32_t inputQueueId = inputQueue.queueId;
        uint32_t queueDepth = UINT32_MAX;
        QueueInfo queueInfo;
        const auto drvRet = halQueueQueryInfo(deviceId, inputQueueId, &queueInfo);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_info("query queue info not success, queue id[%u], device id[%u], ret[%d].",
                inputQueueId, deviceId, drvRet);
        } else {
            queueDepth = static_cast<size_t>(queueInfo.size);
        }
        auto queueStatus = submodelStatus.add_queue_statuses();
        queueStatus->set_queue_depth(queueDepth);
        queueStatus->set_input_consume_num(inputConsumeNum);
        auto queueAttrs = queueStatus->mutable_queue_attrs();
        queueAttrs->set_queue_id(inputQueueId);
        queueAttrs->set_device_type(inputQueue.deviceType);
        queueAttrs->set_device_id(inputQueue.deviceId);
        queueAttrs->set_logic_id(inputQueue.logicId);
    }
    // enqueue
    const size_t reqSize = submodelStatus.ByteSizeLong();
    const FillFunc fillFunc = [&submodelStatus](void *const buffer, const size_t size) {
        if (submodelStatus.SerializeToArray(buffer, static_cast<int32_t>(size))) {
            return AICPU_SCHEDULE_OK;
        }
        aicpusd_err("Protobuf serializeToArray failed.");
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    };
    const int32_t ret = EnqueueStatus(deviceId, schedOutputQueue.queueId, reqSize, fillFunc);
    if (ret == AICPU_SCHEDULE_OK) {
        inputConsumeNum = 0U;
    } else if (ret != AICPU_SCHEDULE_ERROR_QUEUE_FULL) {
        aicpusd_err("enqueue failed, deviceId[%u], queueId[%u], ret[%d].",
            deviceId, schedOutputQueue.queueId, ret);
        return ret;
    }
    aicpusd_info("Dynamic sched report status, ret[%d], status[%s], deviceId[%u], queueId[%u]",
        ret, submodelStatus.DebugString().c_str(), deviceId, schedOutputQueue.queueId);
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelModelReportStatus::EnqueueStatus(const uint32_t deviceId, const uint32_t queueId,
                                                       const size_t reqSize, const FillFunc &fillFunc) const
{
    // alloc mbuf
    Mbuf *mbuf = nullptr;
    auto drvRet = halMbufAlloc(reqSize, &mbuf);
    if (drvRet != DRV_ERROR_NONE) {
        aicpusd_err("halMbufAlloc failed, drvRet=%d, dataSize=%lu.", drvRet, reqSize);
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }
    auto mbufDeleter = [](Mbuf *buf) { (void)halMbufFree(buf); };
    std::unique_ptr<Mbuf, decltype(mbufDeleter)> mbufGuard(mbuf, mbufDeleter);
    drvRet = halMbufSetDataLen(mbuf, reqSize);
    if (drvRet != DRV_ERROR_NONE) {
        aicpusd_err("halMbufSetDataLen failed, drvRet=%d, dataSize=%lu.", drvRet, reqSize);
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }
    // write mbuf data
    void *buffAddr = nullptr;
    drvRet = halMbufGetBuffAddr(mbuf, &buffAddr);
    if (drvRet != DRV_ERROR_NONE || buffAddr == nullptr) {
        aicpusd_err("Failed to get buff addr, ret[%d].", drvRet);
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }
    const auto ret = fillFunc(buffAddr, reqSize);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Failed to fill mbuf data, ret[%d].", ret);
        return ret;
    }
    // enqueue
    drvRet = halQueueEnQueue(deviceId, queueId, mbuf);
    if (drvRet == DRV_ERROR_QUEUE_FULL) {
        aicpusd_debug("Queue[%u] is full.", queueId);
        return AICPU_SCHEDULE_ERROR_QUEUE_FULL;
    } else if (drvRet != DRV_ERROR_NONE) {
        aicpusd_err("Failed to enqueue, queueId[%u], ret[%d].", queueId, drvRet);
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }
    (void)mbufGuard.release();
    return AICPU_SCHEDULE_OK;
}


REGISTER_OPERATOR_KERNEL(KERNEL_MODEL_REPORT_STATUS, OperatorKernelModelReportStatus);
}  // namespace AicpuSchedule