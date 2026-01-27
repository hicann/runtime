/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_post_process_dynamic_output.h"

#include "aicpusd_status.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_resource_manager.h"
#include "operator_kernel_common.h"

namespace AicpuSchedule {
namespace {
const std::string KERNEL_POST_PROCESS_DYNAMIC_OUTPUT = "postprocessDynamicOutput";
const std::string KERNEL_POST_PROCESS_DYNAMIC_OUTPUT_V2 = "postprocessDynamicOutputV2";

enum class OutputType {
    STATIC_OUTPUT = 0,
    DYNAMIC_OUTPUT_WITH_MAXSIZE = 1,
    DYNAMIC_OUTPUT_WITHOUT_MAXSIZE = 2
};
}  // namespace

int32_t OperatorKernelPostProcessDynamicOutput::Compute(const AicpuTaskInfo &kernelTaskInfo,
                                                         const RunContext &taskContext)
{
    aicpusd_info("Start ModelPostprocessDynamicOutput. modelId=%u, streamId=%u, taskId=%u.",
                 taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID);
    if (kernelTaskInfo.paraBase == 0UL) {
        aicpusd_err("kernelTaskInfo.paraBase is null");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const PostprocessDynamicOutputKernelArgs * const param =
        PtrToPtr<void, PostprocessDynamicOutputKernelArgs>(ValueToPtr(kernelTaskInfo.paraBase));
    if ((param->outputsNum > 0U) && ((param->outputDynamicFlagsAddr == 0U) || (param->outputMbufAddrsAddr == 0U))) {
        aicpusd_err("Parameter invalid: outputsNum[%u], outputDynamicFlagsAddr[%u], outputMbufAddrsAddr[%u]",
            param->outputsNum, param->outputDynamicFlagsAddr, param->outputMbufAddrsAddr);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const auto copyRet = CopyTensorDesc(param, taskContext);
    if (copyRet != AICPU_SCHEDULE_OK) {
        return copyRet;
    }

    return FreeMbuf(param, taskContext);
}

int32_t OperatorKernelPostProcessDynamicOutput::CopyTensorDesc(const PostprocessDynamicOutputKernelArgs * const param,
                                                               const RunContext &taskContext) const
{
    const uint32_t * const dynamicFlags = PtrToPtr<void, uint32_t>(ValueToPtr(param->outputDynamicFlagsAddr));
    uint64_t *const outputPptrs = PtrToPtr<void, uint64_t>(ValueToPtr(param->outputMbufAddrsAddr));
    RuntimeTensorDesc *dynamicSrcDesc = nullptr;
    RuntimeTensorDesc *staticSrcDesc = PtrToPtr<void, RuntimeTensorDesc>(ValueToPtr(param->outputStaticTensorDescAddr));

    void *customBuf = nullptr;
    uint32_t customBufSize = 0U;
    for (size_t index = 0U; index < param->outputsNum; ++index) {
        aicpusd_info("dynamicFlags[%zu] is %u.", index, dynamicFlags[index]);
        if (outputPptrs[index] == 0U) {
            aicpusd_err("the [%zu]th outputMbufPtr is null", index);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        if ((dynamicFlags[index] == static_cast<uint32_t>(OutputType::STATIC_OUTPUT)) ||
            (dynamicFlags[index] == static_cast<uint32_t>(OutputType::DYNAMIC_OUTPUT_WITH_MAXSIZE))) {
            Mbuf *const outputMbuf = *(reinterpret_cast<Mbuf **>(outputPptrs[index]));
            const auto ret = AllocatedOutput(param, outputMbuf, dynamicFlags[index], index,
                &dynamicSrcDesc, &staticSrcDesc);
            if (ret != AICPU_SCHEDULE_OK) {
                return ret;
            }
            continue;
        }

        if (dynamicFlags[index] == static_cast<uint32_t>(OutputType::DYNAMIC_OUTPUT_WITHOUT_MAXSIZE)) {
            const auto getHeadRet =
                GetMbufHeadFromResp(reinterpret_cast<Mbuf **>(param->respMsgMbufAddr), taskContext, &customBuf,
                &customBufSize);
            if (getHeadRet != AICPU_SCHEDULE_OK) {
                return getHeadRet;
            }
            const auto ret = PostProcessForOutputToAllocate(param, reinterpret_cast<Mbuf **>(outputPptrs[index]),
                index, &dynamicSrcDesc, customBuf, customBufSize, taskContext);
            if (ret != AICPU_SCHEDULE_OK) {
                return ret;
            }
        }
    }
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelPostProcessDynamicOutput::AllocatedOutput(const PostprocessDynamicOutputKernelArgs * const param,
                                                                Mbuf *const outputMbuf, const uint32_t dynamicFlag,
                                                                const size_t index,
                                                                RuntimeTensorDesc **dynamicSrcDescPptr,
                                                                RuntimeTensorDesc **staticSrcDescPptr) const
{
    if (outputMbuf == nullptr) {
        aicpusd_err("the [%zu]th outputMbuf is null, dynamicFlag is %u.", index, dynamicFlag);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    void *dataPtr = nullptr;
    const auto dataRet = halMbufGetBuffAddr(outputMbuf, &dataPtr);
    if (dataRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
        aicpusd_err("Failed to get data ptr, ret[%d].", dataRet);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }
    RuntimeTensorDesc *runtimeTensorDesc = nullptr;
    if (dynamicFlag > 0U) {
        if (*dynamicSrcDescPptr == nullptr) {
            const auto tensorRet = GetRuntimeTensor(param, dynamicSrcDescPptr);
            if (tensorRet != AICPU_SCHEDULE_OK) {
                return tensorRet;
            }
        }
        runtimeTensorDesc = (*dynamicSrcDescPptr)++;
        const auto setLenRet = PostprocessSetDataLen(runtimeTensorDesc, outputMbuf, index);
        if (setLenRet != AICPU_SCHEDULE_OK) {
            return setLenRet;
        }
    } else {
        runtimeTensorDesc = (*staticSrcDescPptr)++;
    }

    const errno_t eRet = memcpy_s(dataPtr, sizeof(RuntimeTensorDesc), runtimeTensorDesc, sizeof(RuntimeTensorDesc));
    if (eRet != EOK) {
        aicpusd_err("Data copy failed, ret[%d].", eRet);
        return AICPU_SCHEDULE_ERROR_SAFE_FUNCTION_ERR;
    }
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelPostProcessDynamicOutput::GetRuntimeTensor(const PostprocessDynamicOutputKernelArgs * const param,
                                                                 RuntimeTensorDesc **dynamicSrcDescPtr) const
{
    Mbuf **const respPptrs = reinterpret_cast<Mbuf **>(param->respMsgMbufAddr);
    if (respPptrs == nullptr) {
        aicpusd_err("respMsgMbufAddr is null");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    Mbuf *const respMbuf = *respPptrs;
    if (respMbuf == nullptr) {
        aicpusd_err("respMsgMbuf is null");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    void *dataPtr = nullptr;
    const auto dataRet = halMbufGetBuffAddr(respMbuf, &dataPtr);
    if (dataRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
        aicpusd_err("Failed to get data ptr, ret[%d].", dataRet);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }

    *dynamicSrcDescPtr = PtrToPtr<void, RuntimeTensorDesc>(dataPtr);
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelPostProcessDynamicOutput::PostprocessSetDataLen(const RuntimeTensorDesc * const runtimeTensorDesc,
                                                                      Mbuf *const outputMbuf, const size_t index) const
{
    const uint64_t mbufLen = runtimeTensorDesc->dataSize + static_cast<uint64_t>(sizeof(RuntimeTensorDesc));
    const auto setLenRet = halMbufSetDataLen(outputMbuf, mbufLen);
    if (setLenRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
        uint64_t outputMbufLen = 0UL;
        const auto getSizeRet = halMbufGetBuffSize(outputMbuf, &outputMbufLen);
        if ((getSizeRet != static_cast<int32_t>(DRV_ERROR_NONE)) ||
            (outputMbufLen < sizeof(RuntimeTensorDesc))) {
            aicpusd_err("Fail to get buff size for [%zu]th mbuf, ret=[%d], outputMbufLen[%lu]",
                        index, getSizeRet, outputMbufLen);
        }
        if (outputMbufLen >= sizeof(RuntimeTensorDesc)) {
            outputMbufLen -= sizeof(RuntimeTensorDesc);
        }
        aicpusd_err("set [%zu]th mbuf's datalen to %lu fail, mbuf's len is %lu, dataSize is %lu, ret is %d",
            index, mbufLen, outputMbufLen, runtimeTensorDesc->dataSize, setLenRet);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }
    aicpusd_info("set [%zu]th mbuf's datalen to %lu success.", index, mbufLen);
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelPostProcessDynamicOutput::GetMbufHeadFromResp(Mbuf **const respMbufPtr,
                                                                    const RunContext &taskContext,
                                                                    void **const customBufPtr,
                                                                    uint32_t *const customBufSizePtr) const
{
    if (*customBufPtr == nullptr) {
        if ((respMbufPtr == nullptr) || (*respMbufPtr == nullptr)) {
            aicpusd_err("Invalid response Mbuf for model[%u].", taskContext.modelId);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        Mbuf *const respMbuf = *respMbufPtr;
        const auto ret = halMbufGetPrivInfo(respMbuf, customBufPtr, customBufSizePtr);
        if ((ret != static_cast<int32_t>(DRV_ERROR_NONE)) || (*customBufPtr == nullptr)) {
            aicpusd_err("Failed to get customBuf from reponse Mbuf for model[%u], ret[%d].",
                taskContext.modelId, ret);
            return AICPU_SCHEDULE_ERROR_FROM_DRV;
        }
    }
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelPostProcessDynamicOutput::PostProcessForOutputToAllocate(
    const PostprocessDynamicOutputKernelArgs * const param, Mbuf **const outputMbufPtr, const size_t index,
    RuntimeTensorDesc **dynamicSrcDescPptr, void *const customBuf, const uint32_t customBufSize,
    const RunContext &taskContext) const
{
    if (*dynamicSrcDescPptr == nullptr) {
        const auto tensorRet = GetRuntimeTensor(param, dynamicSrcDescPptr);
        if (tensorRet != AICPU_SCHEDULE_OK) {
            return tensorRet;
        }
    }

    RuntimeTensorDesc *runtimeTensorDesc = (*dynamicSrcDescPptr)++;
    if (runtimeTensorDesc == nullptr) {
        aicpusd_err("the runtimeTensor of [%zu]th output is invalid.", index);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    return MakeupDynamicOutputMbuf(outputMbufPtr, index, runtimeTensorDesc, customBuf, customBufSize, taskContext);
}

int32_t OperatorKernelPostProcessDynamicOutput::MakeupDynamicOutputMbuf(Mbuf **const outputMbufPtr, const size_t index,
                                                                        const RuntimeTensorDesc *const runtimeTensorDesc,
                                                                        void *const customBuf,
                                                                        const uint32_t customBufSize,
                                                                        const RunContext &taskContext) const
{
    const uint64_t allocSize = runtimeTensorDesc->dataSize + static_cast<uint64_t>(sizeof(RuntimeTensorDesc));
    Mbuf *mbuf = BufManager::GetInstance().MallocAndGuardBufU64(static_cast<uint64_t>(allocSize),
        taskContext.modelId);
    if (mbuf == nullptr) {
        aicpusd_err("model[%u] alloc mbuf fail, size: %zu.", taskContext.modelId, allocSize);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }

    const ScopeGuard mbufGuard([&mbuf, &taskContext]() {
        if (mbuf != nullptr) {
            aicpusd_info("Free mbuf in ScopeGuard");
            const auto modelPtr = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
            if (modelPtr == nullptr) {
                aicpusd_err("cannot get aicpuModel by modelId:[%u]!", taskContext.modelId);
            }
            if (modelPtr != nullptr) {
                (void) modelPtr->UnGardModelBuf(mbuf);
            }
            (void) halMbufFree(mbuf);
        }
    });

    const auto copyRet = OperatorKernelCommon::CopyMbufHeadInfo(customBuf, customBufSize, mbuf);
    if (copyRet != AICPU_SCHEDULE_OK) {
        aicpusd_err("model[%u] copy head fail for [%zu]th output.", taskContext.modelId, index);
        return copyRet;
    }

    void *dataPtr = nullptr;
    const auto dataRet = halMbufGetBuffAddr(mbuf, &dataPtr);
    if (dataRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
        aicpusd_err("Failed to get data ptr, ret[%d].", dataRet);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }
    // copy (runtimeTensorDesc, sizeof(RuntimeTensorDesc)) to mbuf's data
    bool cpyRet = OptimizedMemCopy(dataPtr, sizeof(RuntimeTensorDesc), runtimeTensorDesc, sizeof(RuntimeTensorDesc));
    if (!cpyRet) {
        aicpusd_err("model[%u] copy tensordesc for [%zu]th output failed.", taskContext.modelId, index);
        return AICPU_SCHEDULE_ERROR_SAFE_FUNCTION_ERR;
    }
    dataPtr = ValueToPtr(PtrToValue(dataPtr) + sizeof(RuntimeTensorDesc));
    // copy (dataAddr, dataSize) to mbuf's offset of sizeof(RuntimeTensorDesc)
    cpyRet = OptimizedMemCopy(dataPtr, static_cast<size_t>(runtimeTensorDesc->dataSize),
        ValueToPtr(runtimeTensorDesc->dataAddr), static_cast<size_t>(runtimeTensorDesc->dataSize));
    if (!cpyRet) {
        aicpusd_err("model[%u] copy data for [%zu]th output failed.", taskContext.modelId, index);
        return AICPU_SCHEDULE_ERROR_SAFE_FUNCTION_ERR;
    }

    *outputMbufPtr = mbuf;
    mbuf = nullptr;
    return AICPU_SCHEDULE_OK;
}

bool OperatorKernelPostProcessDynamicOutput::IsSupportSdmaCopy() const {
    return (&halSdmaCopy != nullptr);
}

bool OperatorKernelPostProcessDynamicOutput::OptimizedMemCopy(void *const dst_data, const size_t dst_size,
    const void *const src_data, const size_t src_size) const {
    if (IsSupportSdmaCopy()) {
        const auto ret = halSdmaCopy(reinterpret_cast<DVdeviceptr>(dst_data), dst_size,
                                     reinterpret_cast<DVdeviceptr>(src_data), src_size);
        if (ret != DRV_ERROR_NONE) {
          aicpusd_err("Failed to call halSdmaCopy, driver api ret:%d, dst_size:%zu, src_size:%zu.",
                      static_cast<int32_t>(ret), dst_size, src_size);
        }
        return (ret == DRV_ERROR_NONE);
    }
    return AicpuUtil::BiggerMemCpy(dst_data, dst_size, src_data, src_size);
}

int32_t OperatorKernelPostProcessDynamicOutput::FreeMbuf(const PostprocessDynamicOutputKernelArgs * const param,
                                                         const RunContext &taskContext) const
{
    // free (respMsgMbufAddr, inputMbufAddrsAddr(uniq)) and unguard them
    AicpuModel * const modelPtr = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if (modelPtr == nullptr) {
        aicpusd_err("cannot get aicpuModel by modelId:[%u]!", taskContext.modelId);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    Mbuf **const respPptrs = reinterpret_cast<Mbuf **>(param->respMsgMbufAddr);
    if ((respPptrs != nullptr) && (*respPptrs != nullptr)) {
        (void)halMbufFree(*respPptrs);
        (void)modelPtr->UnGardModelBuf(*respPptrs);
    }
    if ((param->inputsNum > 0U) && (param->inputMbufAddrsAddr == 0U)) {
        aicpusd_err("Invalid inputsNum[%u], inputMbufAddrsAddr[%u]", param->inputsNum,
            param->inputMbufAddrsAddr);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    uint64_t *const inputPptrs = PtrToPtr<void, uint64_t>(ValueToPtr(param->inputMbufAddrsAddr));
    std::unordered_set<Mbuf*> freedInput;
    for (size_t index = 0U; index < param->inputsNum; ++index) {
        Mbuf *const inputMbuf = *(reinterpret_cast<Mbuf **>(inputPptrs[index]));
        if (freedInput.count(inputMbuf) != 0U) {
            continue;
        }
        (void)halMbufFree(inputMbuf);
        (void)modelPtr->UnGardModelBuf(inputMbuf);
        freedInput.insert(inputMbuf);
    }
    return AICPU_SCHEDULE_OK;
}


REGISTER_OPERATOR_KERNEL(KERNEL_POST_PROCESS_DYNAMIC_OUTPUT, OperatorKernelPostProcessDynamicOutput);
REGISTER_OPERATOR_KERNEL(KERNEL_POST_PROCESS_DYNAMIC_OUTPUT_V2, OperatorKernelPostProcessDynamicOutput);
}  // namespace AicpuSchedule