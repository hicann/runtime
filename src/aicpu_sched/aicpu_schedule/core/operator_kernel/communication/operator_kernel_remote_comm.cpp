/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "operator_kernel_remote_comm.h"

#include "aicpusd_status.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_common.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_REMOTE_COMM = "remoteComm";
}  // namespace

int32_t OperatorKernelRemoteComm::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    aicpusd_info("Start ModelRemoteComm. modelId=%u, streamId=%u, taskId=%u",
                 taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID);
    if (kernelTaskInfo.paraBase == 0UL) {
        aicpusd_err("kernelTaskInfo.paraBase is null");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    const RemoteCommTaskParm *const remoteCommTaskInfo =
        PtrToPtr<void, RemoteCommTaskParm>(ValueToPtr(kernelTaskInfo.paraBase));
    const HcomOpDesc *const hcomOpDescPtr = PtrToPtr<void, HcomOpDesc>(ValueToPtr(remoteCommTaskInfo->hcomOpDescAddr));
    const uint32_t buffLen = remoteCommTaskInfo->buffAddrLen;
    if (buffLen <= 0 || buffLen > MAX_SAVE_TASK_BUFF_LEN) {
        aicpusd_err("Buff length:[%u] overflow max buff len:[%u]!", buffLen, MAX_SAVE_TASK_BUFF_LEN);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    uint64_t psIdBuffAddr = 0;
    uint64_t stepBuffAddr = 0;
    if (buffLen == 1) {
        psIdBuffAddr = remoteCommTaskInfo->buffAddr[0];
    } else if (buffLen == MAX_SAVE_TASK_BUFF_LEN) {
        psIdBuffAddr = remoteCommTaskInfo->buffAddr[0];
        stepBuffAddr = remoteCommTaskInfo->buffAddr[1];
    } else {
        // can not reach here
    }
    aicpusd_info("Hcom broadcast get buffLen[%u] psId Buff[%lu] step Buff[%lu].",
                 buffLen, psIdBuffAddr, stepBuffAddr);

    int32_t ret = AICPU_SCHEDULE_ERROR_INNER_ERROR;
    if (hcomOpDescPtr->opType == HCOM_OP_TYPE_BROADCAST) {
        ret = ModelHcomBroadCast(hcomOpDescPtr, psIdBuffAddr, stepBuffAddr, taskContext);
    } else if (hcomOpDescPtr->opType == HCOM_OP_TYPE_GATHER) {
        ret = ModelHcomGather(hcomOpDescPtr, psIdBuffAddr, stepBuffAddr, taskContext);
    } else {
        aicpusd_err("op time is error:%d", hcomOpDescPtr->opType);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    aicpusd_info("Finish ModelRemoteComm process. modelId=%u, streamId=%u, taskId=%u, ret=%d, optype:%d",
        taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID, ret, hcomOpDescPtr->opType);
    return ret;
}

int32_t OperatorKernelRemoteComm::ModelHcomBroadCast(const HcomOpDesc *const hcomOpDescPtr, const uint64_t psIdBuffAddr,
                                                     const uint64_t stepBuffAddr, const RunContext &taskContext) const
{
    aicpusd_info("handle broadcast begin");
    AicpuModel *const model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if (model == nullptr) {
        aicpusd_err("cannot get model by modelId:[%u]!", taskContext.modelId);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    const HcomCollOpInfo * const coll = &(hcomOpDescPtr->info.coll);
    const auto hcclRet = StubHcomBroadcastByOS(coll->inputAddr, coll->count, coll->dataType, coll->root, coll->group,
                                               hcomOpDescPtr->flag);
    if ((hcclRet != HCCL_SUCCESS) && (hcclRet != HCCL_E_AGAIN)) {
        aicpusd_err("HcomBroadcastByOS failed ret:[%d]", hcclRet);
        return hcclRet;
    }
    if (hcclRet == HCCL_E_AGAIN) {
        aicpusd_run_info("ModelHcomBroadCast was breaked, stream pending. modelId=%u, streamId=%u, tag=%d, ret=%d",
                         taskContext.modelId, taskContext.streamId, model->GetTag(), static_cast<int32_t>(hcclRet));
        bool * const pending = const_cast<bool *>(&taskContext.pending);
        *pending = true;
        return AICPU_SCHEDULE_OK;
    }
    // clear psIdBuffAddr
    *(reinterpret_cast<Mbuf **>(static_cast<uintptr_t>(psIdBuffAddr))) = nullptr;
    // alloc mbuf from buff pool
    Mbuf *psIdBuffPtr = nullptr;
    auto allocateRet = model->GetInputBufPool(0U).Allocate(&psIdBuffPtr);
    if ((allocateRet != 0) || (psIdBuffPtr == nullptr)) {
        aicpusd_err("Fail to allocate mbuf for model[%u], ret is %d", taskContext.modelId, allocateRet);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    uint64_t psIdDataLen = 0UL;
    void *psIdDataPtr = nullptr;
    auto bufInfoRet = OperatorKernelCommon::GetMbufAddrAndSize(psIdBuffPtr, &psIdDataPtr, &psIdDataLen,
                                                               taskContext.modelId, false);
    if (bufInfoRet != AICPU_SCHEDULE_OK) {
        (void)model->GetInputBufPool(0U).Free(psIdBuffPtr);
        return static_cast<int32_t>(bufInfoRet);
    }
    constexpr size_t desiredBuffLen = sizeof(RuntimeTensorDesc) + sizeof(int32_t);
    if (psIdDataLen < desiredBuffLen) {
        (void)model->GetInputBufPool(0U).Free(psIdBuffPtr);
        aicpusd_err("psId dataLen[%lu] is less than desired buff len[%zu], model[%u].",
                    psIdDataLen, desiredBuffLen, taskContext.modelId);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    // record ps id
    void *psIdAddr = ValueToPtr(PtrToValue(psIdDataPtr) + sizeof(RuntimeTensorDesc));
    *(static_cast<int32_t *>(psIdAddr)) = model->GetPsId();
    // create runtime tensor desc
    RuntimeTensorDesc *const tensorDesc = PtrToPtr<void, RuntimeTensorDesc>(psIdDataPtr);
    tensorDesc->dataAddr = PtrToValue(psIdAddr);
    tensorDesc->dataOffsetSize = 0U;
    tensorDesc->dtype = DT_INT32;
    tensorDesc->shape[0] = 1;
    tensorDesc->originalShape[0] = 1;
    tensorDesc->format = FORMAT_ND;
    tensorDesc->subFormat = FORMAT_ND;
    // record mbuf to psIdBuffAddr
    *(reinterpret_cast<Mbuf **>(psIdBuffAddr)) = psIdBuffPtr;
    aicpusd_info("Hcom broadcast process psid sucess, model[%u].", taskContext.modelId);

    if (stepBuffAddr != 0) {
        // clear stepBuffAddr
        *(reinterpret_cast<Mbuf **>(static_cast<uintptr_t>(stepBuffAddr))) = nullptr;
        // alloc mbuf from buff pool
        Mbuf *stepBuffPtr = nullptr;
        allocateRet = model->GetInputBufPool(1U).Allocate(&stepBuffPtr);
        if ((allocateRet != 0) || (stepBuffPtr == nullptr)) {
            aicpusd_err("Fail to allocate mbuf for model[%u], ret is %d", taskContext.modelId, allocateRet);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        constexpr size_t stepBuffLen = sizeof(RuntimeTensorDesc) + sizeof(int64_t);
        void *stepDataPtr = nullptr;
        uint64_t stepDataLen = 0UL;
        bufInfoRet = OperatorKernelCommon::GetMbufAddrAndSize(stepBuffPtr, &stepDataPtr, &stepDataLen,
                                                              taskContext.modelId, false);
        if ((bufInfoRet != AICPU_SCHEDULE_OK) || (stepDataLen < stepBuffLen)) {
            (void)model->GetInputBufPool(1U).Free(stepBuffPtr);
            aicpusd_err("bufInfoRet[%d] step dataLen[%lu] is less than desired buff len[%zu], model[%u].",
                        static_cast<int32_t>(bufInfoRet), stepDataLen, stepBuffLen, taskContext.modelId);
            return (bufInfoRet != AICPU_SCHEDULE_OK) ? static_cast<int32_t>(bufInfoRet) : AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        // record save step
        void *stepAddr = ValueToPtr(PtrToValue(stepDataPtr) + sizeof(RuntimeTensorDesc));
        int64_t *saveStepPtr = static_cast<int64_t *>(coll->inputAddr);
        *(static_cast<int64_t *>(stepAddr)) = *saveStepPtr;
        aicpusd_info("Hcom broadcast get save step[%ld].", *saveStepPtr);
        // create runtime tensor desc
        RuntimeTensorDesc *const stepTensorDesc = PtrToPtr<void, RuntimeTensorDesc>(stepDataPtr);
        stepTensorDesc->dataAddr = PtrToValue(stepAddr);
        stepTensorDesc->dataOffsetSize = 0U;
        stepTensorDesc->dtype = DT_INT64;
        stepTensorDesc->shape[0] = 1;
        stepTensorDesc->originalShape[0] = 1;
        stepTensorDesc->format = FORMAT_ND;
        stepTensorDesc->subFormat = FORMAT_ND;
        // record mbuf to stepBuffAddr
        *(reinterpret_cast<Mbuf **>(stepBuffAddr)) = stepBuffPtr;
        aicpusd_info("Hcom broadcast process step sucess, model[%u].", taskContext.modelId);
    }

    return static_cast<int32_t>(AICPU_SCHEDULE_OK);
}

int32_t OperatorKernelRemoteComm::ModelHcomGather(const HcomOpDesc *const hcomOpDescPtr, const uint64_t psIdBuffAddr,
                                                  const uint64_t stepBuffAddr, const RunContext &taskContext) const
{
    aicpusd_info("handle gather begin");
    AicpuModel *const model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if (model == nullptr) {
        aicpusd_err("cannot get model by modelId:[%u]!", taskContext.modelId);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    // free input mbuf
    Mbuf *psIdBbuf = *(reinterpret_cast<Mbuf **>(static_cast<uintptr_t>(psIdBuffAddr)));
    if (psIdBbuf != nullptr) {
        (void)model->GetInputBufPool(0U).Free(psIdBbuf);
        *(reinterpret_cast<Mbuf **>(static_cast<uintptr_t>(psIdBuffAddr))) = nullptr;
        psIdBbuf = nullptr;
    }
    if (stepBuffAddr != 0) {
        Mbuf *stepMbuf = *(reinterpret_cast<Mbuf **>(static_cast<uintptr_t>(stepBuffAddr)));
        if (stepMbuf != nullptr) {
            (void)model->GetInputBufPool(1U).Free(stepMbuf);
            *(reinterpret_cast<Mbuf **>(static_cast<uintptr_t>(stepBuffAddr))) = nullptr;
            stepMbuf = nullptr;
        }
    }
    // call hcom gather api
    const HcomCollOpInfo * const coll = &(hcomOpDescPtr->info.coll);
    const auto hcclRet = StubHcomGatherByOS(coll->inputAddr, coll->count, coll->dataType, coll->outputAddr, coll->count,
                                            coll->dataType, coll->root, coll->group, hcomOpDescPtr->flag);
    if ((hcclRet != HCCL_SUCCESS) && (hcclRet != HCCL_E_AGAIN)) {
        aicpusd_err("StubHcomGatherByOS failed ret:[%d]", hcclRet);
        return hcclRet;
    }
    if (hcclRet == HCCL_E_AGAIN) {
        aicpusd_run_info("%s was breaked, stream pending. modelId=%u, streamId=%u, tag=%d, ret=%d", __func__,
                         taskContext.modelId, taskContext.streamId, model->GetTag(), static_cast<int32_t>(hcclRet));
        bool * const pending = const_cast<bool *>(&taskContext.pending);
        *pending = true;
        return AICPU_SCHEDULE_OK;
    }
    aicpusd_info("%s process success, modelId=%u, streamId=%u, tag=%d.", __func__,  taskContext.modelId,
                 taskContext.streamId, model->GetTag());
    return static_cast<int32_t>(AICPU_SCHEDULE_OK);
}


REGISTER_OPERATOR_KERNEL(KERNEL_REMOTE_COMM, OperatorKernelRemoteComm);
}  // namespace AicpuSchedule