/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_model_prepare_output.h"

#include "aicpusd_status.h"
#include "aicpusd_monitor.h"
#include "aicpusd_profiler.h"
#include "aicpusd_resource_manager.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_model_statistic.h"
#include "operator_kernel_common.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_MODEL_PREPARE_OUTPUT = "modelPrepareOutput";
const std::string KERNEL_MODEL_PREPARE_OUTPUT_WITH_TENSOR_DESC = "modelPrepareOutputWithTensorDesc";
const std::string KERNEL_BUFFER_PREPARE_OUTPUT = "bufferPrepareOutput";
const std::string KERNEL_BUFFER_PREPARE_OUTPUT_WITH_TENSOR_DESC = "bufferPrepareOutputWithTensorDesc";
}  // namespace

int32_t OperatorKernelPrepareOutputBase::PrepareOutput(ProcessOutputInfo &outputInfo, const RunContext &taskContext,
                                                       const bool zeroCpy, RuntimeTensorDesc *const tensorDesc) const
{
    // point to Mbuf
    auto inMBuf = reinterpret_cast<Mbuf **>(static_cast<uintptr_t>(outputInfo.inMBuf));
    auto outMBuf = reinterpret_cast<Mbuf **>(static_cast<uintptr_t>(outputInfo.outMBuf));
    const bool inOrOutMbufIsNull = ((inMBuf == nullptr) || (outMBuf == nullptr));
    if (inOrOutMbufIsNull) {
        aicpusd_err("PrepareOutput param inMBuf or outMBuf is null, inMBuf[%llx], outMbuf[%llx].", outputInfo.inMBuf,
            outputInfo.outMBuf);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    g_aicpuProfiler.SetPrepareOutStart();
    if (tensorDesc != nullptr) {
        if ((UINT32_MAX - static_cast<uint32_t>(sizeof(RuntimeTensorDesc))) < outputInfo.dataSize) {
            aicpusd_err("PrepareOutput param is invalid, output data size[%u] + sizeof(RuntimeTensorDesc)[%zu] \
                will overflow.", outputInfo.dataSize, sizeof(RuntimeTensorDesc));
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        *outMBuf = BufManager::GetInstance().MallocAndGuardBuf(
            outputInfo.dataSize + static_cast<uint32_t>(sizeof(RuntimeTensorDesc)), taskContext.modelId);
        AicpuSdModelStatistic::GetInstance().StatNNModelOutput(taskContext.modelId, tensorDesc,
                                                               GetStaticNNOutPutIndex(taskContext.modelId));
    } else {
        *outMBuf = BufManager::GetInstance().MallocAndGuardBuf(outputInfo.dataSize, taskContext.modelId);
    }

    if (*outMBuf == nullptr) {
        aicpusd_err("Failed to alloc mbuf, dataSize[%u], modelId[%u].", outputInfo.dataSize, taskContext.modelId);
        AicpuMonitor::GetInstance().SendKillMsgToTsd();
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }
    if (tensorDesc != nullptr) {
        void *basePtr = nullptr;
        const auto ret = halMbufGetBuffAddr(*outMBuf, &basePtr);
        if ((ret != DRV_ERROR_NONE) || (basePtr == nullptr)) {
            aicpusd_err("Failed to call halMbufGetBuffAddr, ret[%d].", ret);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }

        tensorDesc->dataAddr = PtrToValue(basePtr) + static_cast<uint64_t>(sizeof(RuntimeTensorDesc));
        const errno_t eRet = memcpy_s(basePtr, sizeof(RuntimeTensorDesc), tensorDesc, sizeof(RuntimeTensorDesc));
        if (eRet != EOK) {
            return AICPU_SCHEDULE_ERROR_SAFE_FUNCTION_ERR;
        }
    }
    g_aicpuProfiler.SetPrepareOutEnd();
    if (!zeroCpy) {
        const auto ret = PrepareOutputNonZeroCpy(outputInfo, *outMBuf, tensorDesc);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
    }

    void *inputHeaderBuf = nullptr;
    uint32_t inputHeadSize = 0U;
    const auto drvRet = halMbufGetPrivInfo(*inMBuf, &inputHeaderBuf, &inputHeadSize);
    if (drvRet != DRV_ERROR_NONE) {
        aicpusd_err("Failed to get head info in input information, ret[%d].", drvRet);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }
    const auto ret = OperatorKernelCommon::CopyMbufHeadInfo(inputHeaderBuf, inputHeadSize, *outMBuf);
    if (ret != AICPU_SCHEDULE_OK) {
        return ret;
    }

    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelPrepareOutputBase::PrepareOutputNonZeroCpy(const ProcessOutputInfo &outputInfo,
                                                                 Mbuf * const outMBuf,
                                                                 RuntimeTensorDesc *const tensorDesc) const
{
    void *dataPtr = nullptr;
    const auto ret = halMbufGetBuffAddr(outMBuf, &dataPtr);
    if ((ret != DRV_ERROR_NONE) || (dataPtr == nullptr)) {
        aicpusd_err("Failed to get data or data is nullptr, ret[%d].", ret);
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }

    if (tensorDesc != nullptr) {
        dataPtr = ValueToPtr(PtrToValue(dataPtr) + sizeof(RuntimeTensorDesc));
    }

    const errno_t eRet = memcpy_s(dataPtr, static_cast<size_t>(outputInfo.dataSize),
        ValueToPtr(outputInfo.srcPtr),
        static_cast<size_t>(outputInfo.dataSize));
    if (eRet != EOK) {
        aicpusd_err("Failed to memcpy, ret[%d].", eRet);
        return AICPU_SCHEDULE_ERROR_SAFE_FUNCTION_ERR;
    }
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelPrepareOutputBase::GetStaticNNOutPutIndex(const uint32_t modelId) const
{
    const auto model = AicpuModelManager::GetInstance().GetModel(modelId);
    if (model == nullptr) {
        aicpusd_err("model:%u is null", modelId);
        return -1;
    }
    return (static_cast<int32_t>(model->GetCurStaticNNModelOutputIndex()));
}

void OperatorKernelPrepareOutputBase::MarkStaticNNOutPutIndex(const uint32_t modelId) const
{
    const auto model = AicpuModelManager::GetInstance().GetModel(modelId);
    if (model == nullptr) {
        aicpusd_err("model:%u is null", modelId);
        return;
    }
    model->IncreaseStaticNNModelOutputIndex();
    return;
}

int32_t OperatorKernelPrepareOutputBase::PrepareOutWithTensorDesc(const AicpuTaskInfo &kernelTaskInfo,
                                                                  const bool zeroCpy,
                                                                  const RunContext &taskContext) const
{
    MarkStaticNNOutPutIndex(taskContext.modelId);
    ProcessOutputInfo * const info = PtrToPtr<void, ProcessOutputInfo>(ValueToPtr(kernelTaskInfo.paraBase));
    if (info == nullptr) {
        aicpusd_err("AicpuTaskInfo.paramBase is null, modelId[%u], streamId[%u], taskId[%u]",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if ((UINT64_MAX - static_cast<uint64_t>(sizeof(ProcessOutputInfo))) < kernelTaskInfo.paraBase) {
        aicpusd_err("AicpuTaskInfo.paramBase[%lu] + sizeof(ProcessOutputInfo)[%zu] will overflow, modelId[%u], \
            streamId[%u], taskId[%u]", kernelTaskInfo.paraBase, sizeof(ProcessOutputInfo), taskContext.modelId,
            taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    RuntimeTensorDesc *const tensorDesc = PtrToPtr<void, RuntimeTensorDesc>(
        ValueToPtr(kernelTaskInfo.paraBase + static_cast<uint64_t>(sizeof(ProcessOutputInfo))));
    return PrepareOutput(*info, taskContext, zeroCpy, tensorDesc);
}

int32_t OperatorKernelModelPrepareOutput::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    ProcessOutputInfo * const info = reinterpret_cast<ProcessOutputInfo *>(
        static_cast<uintptr_t>(kernelTaskInfo.paraBase));
    if (info == nullptr) {
        aicpusd_err("ModelPrepareOut kernelTaskInfo paramBase is null, modelId[%u], streamId[%u], taskId[%u]",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    return PrepareOutput(*info, taskContext, false, nullptr);
}

int32_t OperatorKernelModelPrepareOutputWithTensorDesc::Compute(const AicpuTaskInfo &kernelTaskInfo,
                                                                 const RunContext &taskContext)
{
    return PrepareOutWithTensorDesc(kernelTaskInfo, false, taskContext);
}

int32_t OperatorKernelBufferPrepareOutput::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    ProcessOutputInfo * const info = PtrToPtr<void, ProcessOutputInfo>(
        ValueToPtr(kernelTaskInfo.paraBase));
    if (info == nullptr) {
        aicpusd_err("ModelPrepareOut kernelTaskInfo paramBase is null, modelId[%u], streamId[%u], taskId[%u]",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    return PrepareOutput(*info, taskContext, true, nullptr);
}

int32_t OperatorKernelBufferPrepareOutputWithTensorDesc::Compute(const AicpuTaskInfo &kernelTaskInfo,
                                                                  const RunContext &taskContext)
{
    return PrepareOutWithTensorDesc(kernelTaskInfo, true, taskContext);
}

REGISTER_OPERATOR_KERNEL(KERNEL_MODEL_PREPARE_OUTPUT, OperatorKernelModelPrepareOutput);
REGISTER_OPERATOR_KERNEL(KERNEL_MODEL_PREPARE_OUTPUT_WITH_TENSOR_DESC, OperatorKernelModelPrepareOutputWithTensorDesc);
REGISTER_OPERATOR_KERNEL(KERNEL_BUFFER_PREPARE_OUTPUT, OperatorKernelBufferPrepareOutput);
REGISTER_OPERATOR_KERNEL(KERNEL_BUFFER_PREPARE_OUTPUT_WITH_TENSOR_DESC, OperatorKernelBufferPrepareOutputWithTensorDesc);
}  // namespace AicpuSchedule