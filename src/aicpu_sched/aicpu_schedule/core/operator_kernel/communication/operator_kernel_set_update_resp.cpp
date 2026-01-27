/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "operator_kernel_set_update_resp.h"

#include "aicpusd_status.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_common.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_SET_UPDATE_RESP = "setUpdateResp";
}  // namespace

int32_t OperatorKernelSetUpdateResp::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    aicpusd_info("Start set model update response. modelId=%u, streamId=%u, taskId=%u",
                 taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID);

    AicpuModel *const model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if (model == nullptr) {
        aicpusd_err("cannot get model by modelId:[%u]!", taskContext.modelId);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    const SetRemoteRespTaskParam * const remoteRespInfo =
        PtrToPtr<void, SetRemoteRespTaskParam>(ValueToPtr(kernelTaskInfo.paraBase));
    if ((remoteRespInfo == nullptr) || (remoteRespInfo->inBuffPtr == 0U)) {
        aicpusd_err("Model remote response info is nullptr. modelId=%u, streamId=%u, taskId=%u",
                    taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    uintptr_t *const inputPptrs = PtrToPtr<void, uintptr_t>(ValueToPtr(remoteRespInfo->inBuffPtr));
    Mbuf *valueMbuf = *(reinterpret_cast<Mbuf **>(inputPptrs[0U]));

    uint64_t dataLen = 0UL;
    void *dataPtr = nullptr;
    const auto bufInfoRet = OperatorKernelCommon::GetMbufAddrAndSize(valueMbuf, &dataPtr, &dataLen,
                                                                     taskContext.modelId, false);
    if (bufInfoRet != AICPU_SCHEDULE_OK) {
        return static_cast<int32_t>(bufInfoRet);
    }
    void *customBuf = nullptr;
    uint32_t customBufSize = 0U;
    auto ret = halMbufGetPrivInfo(valueMbuf, &customBuf, &customBufSize);
    if ((ret != static_cast<int32_t>(DRV_ERROR_NONE)) ||
        (customBuf == nullptr) || (customBufSize < (sizeof(ServiceHandle) + sizeof(MbufHeadMsg)))) {
        aicpusd_err("Failed to get customBuf in valueMbuf, ret[%d], bufSize[%u].", ret, customBufSize);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }
    ServiceHandle serviceHandle = *(PtrToPtr<void, ServiceHandle>(customBuf));
    const MbufHeadMsg * const curHeadInfo =
        PtrToPtr<char_t, MbufHeadMsg>(PtrToPtr<void, char_t>(customBuf) + customBufSize - sizeof(MbufHeadMsg));
    if (curHeadInfo->retCode != 0) {
        aicpusd_err("Actived model executed abnormally");
        (void) StubHddsServiceCancel(serviceHandle);
        return AICPU_SCHEDULE_ERROR_MODEL_EXIT_ERR;
    }

    HcclRequest request = nullptr;
    HcclComm *commHandle = AicpuModelManager::GetInstance().GetHcclComm();
    if (commHandle == nullptr) {
        aicpusd_err("null commHandle!");
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    const auto hcclRet = StubHddsIsendUpdateResponse(serviceHandle, *commHandle, &request);
    if (hcclRet != HCCL_SUCCESS) {
        aicpusd_err("HddsIsendUpdateResponse fail, tag[%d], model[%u], ret is %d",
                    model->GetTag(), taskContext.modelId, static_cast<int32_t>(hcclRet));
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }

    ret = SingleHcclWait(request);
    if (ret != RET_SUCCESS) {
        aicpusd_err("HcclWait fail when release mem");
    }

    for (uint32_t inputIndex = 0; inputIndex < remoteRespInfo->inBuffNum; ++inputIndex) {
        (void)model->GetInputBufPool(inputIndex).
            Free(*(reinterpret_cast<Mbuf **>(inputPptrs[static_cast<size_t>(inputIndex)])));
    }

    AICPUSubEventInfo subEventInfo = {};
    subEventInfo.modelId = taskContext.modelId;
    (void)OperatorKernelCommon::SendAICPUSubEvent(PtrToPtr<AICPUSubEventInfo, char_t>(&subEventInfo),
        static_cast<uint32_t>(sizeof(AICPUSubEventInfo)), AICPU_SUB_EVENT_PREPARE_MEM);

    return AICPU_SCHEDULE_OK;
}


REGISTER_OPERATOR_KERNEL(KERNEL_SET_UPDATE_RESP, OperatorKernelSetUpdateResp);
}  // namespace AicpuSchedule