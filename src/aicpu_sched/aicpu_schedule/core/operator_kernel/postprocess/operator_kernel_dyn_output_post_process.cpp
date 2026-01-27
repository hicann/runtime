/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_dyn_output_post_process.h"

#include "aicpusd_status.h"
#include "aicpusd_monitor.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_resource_manager.h"
#include "operator_kernel_common.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_DYN_OUTPUT_POST_PROCESS = "dynOutputPostProcess";
}  // namespace

int32_t OperatorKernelDynOutputPostProcess::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    ProcessOutputInfo * const info = reinterpret_cast<ProcessOutputInfo *>(
        static_cast<uintptr_t>(kernelTaskInfo.paraBase));
    if (info == nullptr) {
        aicpusd_err("ModelDynPrepareOut kernelTaskInfo paramBase is null, modelId[%u], streamId[%u], taskId[%u]",
                    taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    return DoCompute(*info, taskContext);
}

int32_t OperatorKernelDynOutputPostProcess::DoCompute(const ProcessOutputInfo &outputInfo,
                                                      const RunContext &taskContext) const
{
    // point to Mbuf * address
    Mbuf * const * const inMBuf = reinterpret_cast<Mbuf **>(static_cast<uintptr_t>(outputInfo.inMBuf));
    Mbuf ** const outMBuf = reinterpret_cast<Mbuf **>(static_cast<uintptr_t>(outputInfo.outMBuf));
    const RuntimeTensorDesc * const srcTensorDesc =
        reinterpret_cast<RuntimeTensorDesc *>(static_cast<uintptr_t>(outputInfo.srcPtr));
    const bool inOrOutMbufIsNull = ((inMBuf == nullptr) || (outMBuf == nullptr) || (srcTensorDesc == nullptr));
    if (inOrOutMbufIsNull) {
        aicpusd_err("ProcessOutput param inMBuf, outMBuf or srcPtr is null, inMBuf[%llx], outMbuf[%llx], srcPtr[%llx].",
                    outputInfo.inMBuf, outputInfo.outMBuf, outputInfo.srcPtr);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    // parse tensor desc and calculate shape size
    uint32_t dataSize = 0U;
    AicpuModel * const model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if (model == nullptr) {
        aicpusd_err("Model[%u] prepare dynamic output task failed, no model found.", taskContext.modelId);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    if (!model->IsEndOfSequence()) {
        const int32_t ret = OperatorKernelCommon::ParseTensorDescAndCalcDataSize(srcTensorDesc, dataSize);
        if ((ret != AICPU_SCHEDULE_OK) && !model->AbnormalNeedEnqueue()) {
            aicpusd_err("Model[%u] prepare dynamic output task failed, ret[%d]", taskContext.modelId, ret);
            return ret;
        }
    }

    // alloc data buffer
    *outMBuf = BufManager::GetInstance().MallocAndGuardBuf(dataSize + static_cast<uint32_t>(sizeof(RuntimeTensorDesc)),
        taskContext.modelId);
    if (*outMBuf == nullptr) {
        aicpusd_err("Failed to alloc mbuf, dataSize[%u], modelId[%u].", dataSize, taskContext.modelId);
        AicpuMonitor::GetInstance().SendKillMsgToTsd();
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }

    // copy mbuf head info
    void *inputHeaderBuf = nullptr;
    uint32_t inputHeadSize = 0U;
    const auto drvRet = halMbufGetPrivInfo(*inMBuf, &inputHeaderBuf, &inputHeadSize);
    if (drvRet != DRV_ERROR_NONE) {
        aicpusd_err("Failed to get head info in input information, ret[%d].", drvRet);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }
    const int32_t ret = OperatorKernelCommon::CopyMbufHeadInfo(inputHeaderBuf, inputHeadSize, *outMBuf);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Failed copy mbuf head info, ret[%d].", ret);
        return ret;
    }
    // copy tensor desc and data buffer
    return CopyTensorDescAndDataBuf(srcTensorDesc, dataSize, *outMBuf,
        dataSize + static_cast<uint32_t>(sizeof(RuntimeTensorDesc)));
}

int32_t OperatorKernelDynOutputPostProcess::CopyTensorDescAndDataBuf(const RuntimeTensorDesc * const srcTensorDesc,
                                                                     const uint32_t srcDataSize, Mbuf * const outMBuf,
                                                                     const uint32_t dstdataSize) const
{
    void *basePtr = nullptr;
    const auto ret = halMbufGetBuffAddr(outMBuf, &basePtr);
    if ((ret != DRV_ERROR_NONE) || (basePtr == nullptr)) {
        aicpusd_err("Failed to call halMbufGetBuffAddr, ret[%d].", ret);
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }

    errno_t eRet = memcpy_s(basePtr, static_cast<size_t>(dstdataSize), srcTensorDesc, sizeof(RuntimeTensorDesc));
    if (eRet != EOK) {
        aicpusd_err("Failed to memcpy_s for tensor description, ret[%d].", eRet);
        return AICPU_SCHEDULE_ERROR_SAFE_FUNCTION_ERR;
    }
    if (srcDataSize != 0U) {
        uint8_t * const dataPtr = static_cast<uint8_t *>(basePtr) + sizeof(RuntimeTensorDesc);
        eRet = memcpy_s(dataPtr, static_cast<size_t>(dstdataSize) - sizeof(RuntimeTensorDesc),
                        reinterpret_cast<void *>(static_cast<uintptr_t>(srcTensorDesc->dataAddr)),
                        static_cast<size_t>(srcDataSize));
        if (eRet != EOK) {
            aicpusd_err("Failed to memcpy_s for data buffer, ret[%d].", eRet);
            return AICPU_SCHEDULE_ERROR_SAFE_FUNCTION_ERR;
        }
    }
    return AICPU_SCHEDULE_OK;
}

REGISTER_OPERATOR_KERNEL(KERNEL_DYN_OUTPUT_POST_PROCESS, OperatorKernelDynOutputPostProcess);
}  // namespace AicpuSchedule