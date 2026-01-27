/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_lookup_req.h"

#include "aicpusd_status.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_common.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_GET_LOOKUP_REQ = "getLookupReq";
const std::string KERNEL_COLL_RECV_LOOKUP_REQ = "collRecvLookupReq";
}  // namespace

int32_t OperatorKernelLookupReq::ModelLookupRequest(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext,
                                                    bool isInfer) const
{
    AicpuModel *const model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if (model == nullptr) {
        aicpusd_err("cannot get model by modelId:[%u]!", taskContext.modelId);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    aicpusd_info("Start get model remote request. modelId=%u, streamId=%u, taskId=%u, tag=%d",
                 taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID, model->GetTag());

    const GetRemoteReqTaskParam * const remoteReqInfo =
        PtrToPtr<void, GetRemoteReqTaskParam>(ValueToPtr(kernelTaskInfo.paraBase));
    if ((remoteReqInfo == nullptr) || (remoteReqInfo->inBuffPtr == 0U)) {
        aicpusd_err("Model remote request info is nullptr. modelId=%u, streamId=%u, taskId=%u.",
                    taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    uintptr_t *const inputPptrs = PtrToPtr<void, uintptr_t>(ValueToPtr(remoteReqInfo->inBuffPtr));
    Mbuf *tableIdMbuf = *(reinterpret_cast<Mbuf **>(inputPptrs[0U]));
    Mbuf *keyMbuf = *(reinterpret_cast<Mbuf **>(inputPptrs[1U]));

    uint64_t tableIdDataLen = 0UL;
    void *tableIdDataPtr = nullptr;
    auto bufInfoRet = OperatorKernelCommon::GetMbufAddrAndSize(tableIdMbuf, &tableIdDataPtr, &tableIdDataLen,
                                                               taskContext.modelId, false);
    if (bufInfoRet != AICPU_SCHEDULE_OK) {
        aicpusd_err("tableId GetMbufAddrAndSize failed!");
        return static_cast<int32_t>(bufInfoRet);
    }
    const uint64_t descSize = sizeof(RuntimeTensorDesc);
    void *tableIdRecvAddr = ValueToPtr(PtrToValue(tableIdDataPtr) + descSize);

    uint64_t keyDataLen = 0UL;
    void *keyDataPtr = nullptr;
    bufInfoRet = OperatorKernelCommon::GetMbufAddrAndSize(keyMbuf, &keyDataPtr, &keyDataLen,
                                                          taskContext.modelId, false);
    if (bufInfoRet != AICPU_SCHEDULE_OK) {
        return static_cast<int32_t>(bufInfoRet);
    }
    void *keyRecvAddr = ValueToPtr(PtrToValue(keyDataPtr) + descSize);

    ServiceHandle serviceHandle;
    HcclComm *commHandle = AicpuModelManager::GetInstance().GetHcclComm();
    if (commHandle == nullptr) {
        aicpusd_err("null commHandle!");
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    
    int32_t tableId = 0;
    int32_t keyCount = 0;
    int32_t workerId = 0;
    HcclResult hcclRet = HCCL_SUCCESS;
    if (isInfer) {
        ReqStatus status = {};
        hcclRet = StubHcclGetLookupRequest(keyRecvAddr,
            static_cast<int32_t>((keyDataLen - descSize) / sizeof(uint64_t)),
            HCCL_DATA_TYPE_UINT64, model->GetTag(), &serviceHandle, *commHandle, &status);
        tableId = status.tableId;
        keyCount = status.actualSize;
        aicpusd_info("HcclGetLookupRequest, status tableId[%d], kCout[%d]", tableId, keyCount);
    } else {
        LookupReqStatus status = {};
        hcclRet = StubHddsCollRecvLookupRequest(keyRecvAddr,
            static_cast<int32_t>((keyDataLen - descSize) / sizeof(uint64_t)),
            HCCL_DATA_TYPE_UINT64, model->GetTag(), &serviceHandle, *commHandle, &status);
        tableId = status.tableId;
        keyCount = status.actualCount;
        workerId = status.workerId;
        aicpusd_info("HddsCollRecvLookupRequest, status tableId[%d], kCout[%d], workerId[%d]",
                     tableId, keyCount, workerId);
    }

    if (hcclRet != HCCL_SUCCESS) {
        if (hcclRet == HCCL_E_AGAIN) {
            aicpusd_run_info("HcclGetLookupRequest was breaked, stream pending. modelId=%u, " \
                             "streamId=%u, taskId=%u, tag=%d, ret=%d", taskContext.modelId,
                             kernelTaskInfo.streamID, kernelTaskInfo.taskID, model->GetTag(),
                             static_cast<int32_t>(hcclRet));
            bool * const pending = const_cast<bool *>(&taskContext.pending);
            *pending = true;
            return AICPU_SCHEDULE_OK;
        }
        aicpusd_err("HcclGetLookupRequest fail, modelId=%u, streamId=%u, taskId=%u, tag=%d, ret=%d",
                    taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID,
                    model->GetTag(), static_cast<int32_t>(hcclRet));
        return AICPU_SCHEDULE_ERROR_CALL_HCCL;
    }

    aicpusd_info("lookup handle get tableId[%d], kCout[%d], workerId[%d].", tableId, keyCount, workerId);
    const errno_t eRet = memcpy_s(tableIdRecvAddr, sizeof(int32_t), &(tableId), sizeof(int32_t));
    if (eRet != EOK) {
        aicpusd_err("lookup model[%u] tableId[%d] copy failed, ret[%d].", taskContext.modelId, tableId, eRet);
        return AICPU_SCHEDULE_ERROR_SAFE_FUNCTION_ERR;
    }
    RuntimeTensorDesc *const tableIdTensorDesc = PtrToPtr<void, RuntimeTensorDesc>(tableIdDataPtr);
    tableIdTensorDesc->dataAddr = PtrToValue(tableIdRecvAddr);
    tableIdTensorDesc->dataOffsetSize = 0L;
    tableIdTensorDesc->dtype = DT_INT32;
    tableIdTensorDesc->shape[DIM_NUM_INDEX] = 1;
    tableIdTensorDesc->shape[DIM0_INDEX] = 1;
    tableIdTensorDesc->originalShape[DIM_NUM_INDEX] = 1;
    tableIdTensorDesc->originalShape[DIM0_INDEX] = 1;
    tableIdTensorDesc->format = FORMAT_ND;
    tableIdTensorDesc->subFormat = FORMAT_ND;

    RuntimeTensorDesc *const keyTensorDesc = PtrToPtr<void, RuntimeTensorDesc>(keyDataPtr);
    keyTensorDesc->dataAddr = PtrToValue(keyRecvAddr);
    keyTensorDesc->dataOffsetSize = 0L;
    keyTensorDesc->dtype = DT_INT64;
    if ((!isInfer) && (model->IsSupportCounterFilter())) {
        aicpusd_info("handle counter filter shape keyCount=%d.", keyCount);
        const int64_t eachCount = static_cast<int64_t>(keyCount) / DIM_NUM_TWO;
        keyTensorDesc->shape[DIM_NUM_INDEX] = DIM_NUM_TWO;
        keyTensorDesc->shape[DIM0_INDEX] = eachCount;
        keyTensorDesc->shape[DIM1_INDEX] = DIM_NUM_TWO;
        keyTensorDesc->originalShape[DIM_NUM_INDEX] = DIM_NUM_TWO;
        keyTensorDesc->originalShape[DIM0_INDEX] = eachCount;
        keyTensorDesc->originalShape[DIM1_INDEX] = DIM_NUM_TWO;
    } else {
        aicpusd_info("not counter filter handle shape keyCount=%d.", keyCount);
        keyTensorDesc->shape[DIM_NUM_INDEX] = DIM_NUM_ONE;
        keyTensorDesc->shape[DIM0_INDEX] = keyCount;
        keyTensorDesc->originalShape[DIM_NUM_INDEX] = DIM_NUM_ONE;
        keyTensorDesc->originalShape[DIM0_INDEX] = keyCount;
    }
    keyTensorDesc->format = FORMAT_ND;
    keyTensorDesc->subFormat = FORMAT_ND;

    void *customBuf = nullptr;
    uint32_t customBufSize = 0U;
    const auto ret = halMbufGetPrivInfo(tableIdMbuf, &customBuf, &customBufSize);
    if ((ret != static_cast<int32_t>(DRV_ERROR_NONE)) ||
        (customBuf == nullptr) || (customBufSize < (sizeof(ServiceHandle) + sizeof(MbufHeadMsg)))) {
        aicpusd_err("Failed to get customBuf in inputMbuf, ret[%d], bufSize[%u], reserveSize[%zu].",
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
    curHeadInfo->workerId = workerId;

    aicpusd_info("End get model remote request. modelId=%u, streamId=%u, taskId=%u, tag=%d",
                 taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID, model->GetTag());

    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelGetLookupReq::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    return ModelLookupRequest(kernelTaskInfo, taskContext, true);
}

int32_t OperatorKernelCollRecvLookupReq::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    return ModelLookupRequest(kernelTaskInfo, taskContext, false);
}


REGISTER_OPERATOR_KERNEL(KERNEL_GET_LOOKUP_REQ, OperatorKernelGetLookupReq);
REGISTER_OPERATOR_KERNEL(KERNEL_COLL_RECV_LOOKUP_REQ, OperatorKernelCollRecvLookupReq);
}  // namespace AicpuSchedule