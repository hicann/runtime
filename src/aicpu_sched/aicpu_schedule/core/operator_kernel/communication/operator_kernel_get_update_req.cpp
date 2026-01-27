/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_get_update_req.h"

#include "aicpusd_status.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_common.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_GET_UPDATE_REQ = "getUpdateReq";
constexpr uint32_t UPDATE_INPUT_NUM_FOUR = 4U;
}  // namespace

int32_t OperatorKernelGetUpdateReq::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    AicpuModel *const model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if (model == nullptr) {
        aicpusd_err("cannot get model by modelId:[%u]!", taskContext.modelId);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    aicpusd_info("Start get model update request. modelId=%u, streamId=%u, taskId=%u, tag=%d",
                 taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID, model->GetTag());

    const GetRemoteReqTaskParam * const remoteReqInfo =
        PtrToPtr<void, GetRemoteReqTaskParam>(ValueToPtr(kernelTaskInfo.paraBase));
    if ((remoteReqInfo == nullptr) || (remoteReqInfo->inBuffPtr == 0U)) {
        aicpusd_err("Model remote request info is nullptr. modelId=%u, streamId=%u, taskId=%u",
                    taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    constexpr uint64_t descSize = sizeof(RuntimeTensorDesc);
    uintptr_t *const inputPptrs = PtrToPtr<void, uintptr_t>(ValueToPtr(remoteReqInfo->inBuffPtr));
    Mbuf *keyMbuf = *(reinterpret_cast<Mbuf **>(inputPptrs[1U]));
    Mbuf *valueMbuf = *(reinterpret_cast<Mbuf **>(inputPptrs[0U]));
    aicpusd_info("update handle get inBuffNum=[%u]", remoteReqInfo->inBuffNum);
    if (remoteReqInfo->inBuffNum != UPDATE_INPUT_NUM_FOUR) {
        aicpusd_err("get inBuffNum=[%u] do not supported", remoteReqInfo->inBuffNum);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    Mbuf *tableIdMbuf = *(reinterpret_cast<Mbuf **>(inputPptrs[3U]));
    Mbuf *globalStepMbuf = *(reinterpret_cast<Mbuf **>(inputPptrs[2U]));
    
    uint64_t keyDataLen = 0UL;
    void *keyDataPtr = nullptr;
    auto bufInfoRet = OperatorKernelCommon::GetMbufAddrAndSize(keyMbuf, &keyDataPtr, &keyDataLen,
                                                               taskContext.modelId, false);
    if (bufInfoRet != AICPU_SCHEDULE_OK) {
        return static_cast<int32_t>(bufInfoRet);
    }
    void *keyRecvAddr = ValueToPtr(PtrToValue(keyDataPtr) + descSize);

    uint64_t valueDataLen = 0UL;
    void *valueDataPtr = nullptr;
    bufInfoRet = OperatorKernelCommon::GetMbufAddrAndSize(valueMbuf, &valueDataPtr, &valueDataLen,
                                                          taskContext.modelId, false);
    if (bufInfoRet != AICPU_SCHEDULE_OK) {
        return static_cast<int32_t>(bufInfoRet);
    }
    void *valueRecvAddr = ValueToPtr(PtrToValue(valueDataPtr) + descSize);

    uint64_t tableIdDataLen = 0UL;
    void *tableIdDataPtr = nullptr;
    bufInfoRet = OperatorKernelCommon::GetMbufAddrAndSize(tableIdMbuf, &tableIdDataPtr, &tableIdDataLen,
                                                          taskContext.modelId, false);
    if (bufInfoRet != AICPU_SCHEDULE_OK) {
        return static_cast<int32_t>(bufInfoRet);
    }
    void *tableIdRecvAddr = ValueToPtr(PtrToValue(tableIdDataPtr) + descSize);

    void *globalStepDataPtr = nullptr;
    uint64_t globalStepDataLen = 0UL;
    bufInfoRet = OperatorKernelCommon::GetMbufAddrAndSize(globalStepMbuf, &globalStepDataPtr, &globalStepDataLen,
                                                          taskContext.modelId, false);
    if (bufInfoRet != AICPU_SCHEDULE_OK) {
        return static_cast<int32_t>(bufInfoRet);
    }
    void *globalStepRecvAddr = ValueToPtr(PtrToValue(globalStepDataPtr) + descSize);

    ServiceHandle serviceHandle;
    UpdateReqStatus status = {};
    HcclComm *commHandle = AicpuModelManager::GetInstance().GetHcclComm();
    if (commHandle == nullptr) {
        aicpusd_err("null commHandle!");
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    const auto hcclRet = StubHddsCollRecvUpdateRequest(keyRecvAddr,
        static_cast<int32_t>((keyDataLen - descSize) / sizeof(uint64_t)), HCCL_DATA_TYPE_UINT64,
        valueRecvAddr, static_cast<int32_t>((valueDataLen - descSize) / sizeof(float32_t)), HCCL_DATA_TYPE_FP32,
        model->GetTag(), &serviceHandle, *commHandle, &status);
    if (hcclRet != HCCL_SUCCESS) {
        if (hcclRet == HCCL_E_AGAIN) {
            aicpusd_run_info("HddsCollRecvUpdateRequest was breaked, stream pending. modelId=%u, " \
                             "streamId=%u, taskId=%u, tag=%d, ret=%d", taskContext.modelId,
                             kernelTaskInfo.streamID, kernelTaskInfo.taskID, model->GetTag(),
                             static_cast<int32_t>(hcclRet));
            bool * const pending = const_cast<bool *>(&taskContext.pending);
            *pending = true;
            return AICPU_SCHEDULE_OK;
        }
        aicpusd_err("HddsCollRecvUpdateRequest fail, modelId=%u, streamId=%u, taskId=%u, tag=%d, ret=%d",
                    taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID, model->GetTag(),
                    static_cast<int32_t>(hcclRet));
        return AICPU_SCHEDULE_ERROR_CALL_HCCL;
    }

    const int64_t actualKeyCount = (status.actualKeyCount == 0) ? 1L : static_cast<int64_t>(status.actualKeyCount);
    const int64_t realEmbeddingDim = static_cast<int64_t>(status.actualValueCount / actualKeyCount);
    aicpusd_info("update handle get tableId[%d], embedding_dim[%ld] globalStep[%d], kCount[%d], vCount[%d].",
                 status.tableId, realEmbeddingDim, status.globalStep, status.actualKeyCount, status.actualValueCount);
    *(static_cast<int32_t*>(tableIdRecvAddr)) = status.tableId;
    *(static_cast<int64_t*>(globalStepRecvAddr)) = status.globalStep;

    RuntimeTensorDesc *const keyRTTensorDesc = PtrToPtr<void, RuntimeTensorDesc>(keyDataPtr);
    keyRTTensorDesc->dataAddr = PtrToValue(keyRecvAddr);
    keyRTTensorDesc->dataOffsetSize = 0U;
    keyRTTensorDesc->dtype = DT_INT64;
    keyRTTensorDesc->shape[DIM_NUM_INDEX] = DIM_NUM_ONE;
    keyRTTensorDesc->shape[DIM0_INDEX] = status.actualKeyCount;
    keyRTTensorDesc->originalShape[DIM_NUM_INDEX] = DIM_NUM_ONE;
    keyRTTensorDesc->originalShape[DIM0_INDEX] = status.actualKeyCount;
    keyRTTensorDesc->format = FORMAT_ND;
    keyRTTensorDesc->subFormat = FORMAT_ND;

    RuntimeTensorDesc *const valueRTTensorDesc = PtrToPtr<void, RuntimeTensorDesc>(valueDataPtr);
    valueRTTensorDesc->dataAddr = PtrToValue(valueRecvAddr);
    valueRTTensorDesc->dataOffsetSize = 0U;
    valueRTTensorDesc->dtype = DT_FLOAT;
    valueRTTensorDesc->shape[DIM_NUM_INDEX] = DIM_NUM_TWO;
    valueRTTensorDesc->shape[DIM0_INDEX] = status.actualKeyCount;
    valueRTTensorDesc->shape[DIM1_INDEX] = realEmbeddingDim;
    valueRTTensorDesc->originalShape[DIM_NUM_INDEX] = DIM_NUM_TWO;
    valueRTTensorDesc->originalShape[DIM0_INDEX] = status.actualKeyCount;
    valueRTTensorDesc->originalShape[DIM1_INDEX] = realEmbeddingDim;
    valueRTTensorDesc->format = FORMAT_ND;
    valueRTTensorDesc->subFormat = FORMAT_ND;

    RuntimeTensorDesc *const tableIdRTTensorDesc = PtrToPtr<void, RuntimeTensorDesc>(tableIdDataPtr);
    tableIdRTTensorDesc->dataAddr = PtrToValue(tableIdRecvAddr);
    tableIdRTTensorDesc->dataOffsetSize = 0L;
    tableIdRTTensorDesc->dtype = DT_INT32;
    tableIdRTTensorDesc->shape[DIM_NUM_INDEX] = 1;
    tableIdRTTensorDesc->shape[DIM0_INDEX] = 1;
    tableIdRTTensorDesc->originalShape[DIM_NUM_INDEX] = 1;
    tableIdRTTensorDesc->originalShape[DIM0_INDEX] = 1;
    tableIdRTTensorDesc->format = FORMAT_ND;
    tableIdRTTensorDesc->subFormat = FORMAT_ND;

    RuntimeTensorDesc *const globalStepRTTensorDesc = PtrToPtr<void, RuntimeTensorDesc>(globalStepDataPtr);
    globalStepRTTensorDesc->dataAddr = PtrToValue(globalStepRecvAddr);
    globalStepRTTensorDesc->dataOffsetSize = 0L;
    globalStepRTTensorDesc->dtype = DT_INT64;
    globalStepRTTensorDesc->shape[DIM_NUM_INDEX] = 1;
    globalStepRTTensorDesc->shape[DIM0_INDEX] = 1;
    globalStepRTTensorDesc->originalShape[DIM_NUM_INDEX] = 1;
    globalStepRTTensorDesc->originalShape[DIM0_INDEX] = 1;
    globalStepRTTensorDesc->format = FORMAT_ND;
    globalStepRTTensorDesc->subFormat = FORMAT_ND;

    void *customBuf = nullptr;
    uint32_t customBufSize = 0U;
    const auto ret = halMbufGetPrivInfo(valueMbuf, &customBuf, &customBufSize);
    if ((ret != static_cast<int32_t>(DRV_ERROR_NONE)) ||
        (customBuf == nullptr) || (customBufSize < (sizeof(ServiceHandle) + sizeof(MbufHeadMsg)))) {
        aicpusd_err("Failed to get customBuf in valueMbuf, ret[%d], bufSize[%u], reserveSize[%zu].",
                    ret, customBufSize, (sizeof(ServiceHandle) + sizeof(MbufHeadMsg)));
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }
    // store serviceHandle which obtained before into inputbuf
    *(PtrToPtr<void, ServiceHandle>(customBuf)) = serviceHandle;
    MbufHeadMsg *const curHeadInfo =
        PtrToPtr<char_t, MbufHeadMsg>(PtrToPtr<void, char_t>(customBuf) + customBufSize - sizeof(MbufHeadMsg));
    curHeadInfo->retCode = 0;
    curHeadInfo->flags = 0U;
    curHeadInfo->dataFlag = 0U;

    aicpusd_info("End get model update request. modelId=%u, streamId=%u, taskId=%u, tag=%d",
                 taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID, model->GetTag());

    return AICPU_SCHEDULE_OK;
}


REGISTER_OPERATOR_KERNEL(KERNEL_GET_UPDATE_REQ, OperatorKernelGetUpdateReq);
}  // namespace AicpuSchedule