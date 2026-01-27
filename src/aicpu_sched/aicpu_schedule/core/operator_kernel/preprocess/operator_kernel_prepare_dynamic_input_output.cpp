/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_prepare_dynamic_input_output.h"

#include "aicpusd_status.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_resource_manager.h"
#include "operator_kernel_common.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_PREPARE_DYNAMIC_INPUT_OUTPUT = "prepareDynamicInputOutput";
const std::string KERNEL_PREPARE_DYNAMIC_INPUT_OUTPUT_V2 = "prepareDynamicInputOutputV2";
}  // namespace

int32_t PrepareDynamicInputOutputBase::PrepareDynamicInputOutput(const AicpuTaskInfo &kernelTaskInfo,
                                                                 const RunContext &taskContext,
                                                                 const bool hostAllocDynamicOutput) const
{
    aicpusd_info("Start ModelPrepareDynamicInputOutput. modelId=%u, streamId=%u, taskId=%u.",
                 taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID);
    if (kernelTaskInfo.paraBase == 0UL) {
        aicpusd_err("kernelTaskInfo.paraBase is null");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const PrepareDynamicInputOutputKernelArgs * const param =
        PtrToPtr<void, PrepareDynamicInputOutputKernelArgs>(ValueToPtr(kernelTaskInfo.paraBase));
    if (((param->inputsNum != 0U) && ((param->inputDynamicFlagsAddr == 0U) || (param->inputMbufAddrsAddr == 0U))) ||
        ((param->outputsNum != 0U) && ((param->outputTensorSizesAddr == 0U) || (param->outputMbufAddrsAddr == 0U))) ||
        (param->reqMsgMbufAddr == 0U)) {
        aicpusd_err("input or output invalid, input: {inputNums[%u], inputDynamicFlagsAddr[%u], inputMbufAddr[%u]}, "
            "output: {outputNums[%u], outputTensorSizeAddr[%u], outputMbufAddr[%u]}, reqMsgMbufAddr[%u].",
            param->inputsNum, param->inputDynamicFlagsAddr, param->inputMbufAddrsAddr,
            param->outputsNum, param->outputTensorSizesAddr, param->outputMbufAddrsAddr,
            param->reqMsgMbufAddr);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    std::vector<Mbuf *> mbufsToFree;
    const ScopeGuard mbufGuard([&mbufsToFree, &taskContext]() {
        AicpuModel *modelPtr = nullptr;
        if (!mbufsToFree.empty()) {
            modelPtr = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
            if (modelPtr == nullptr) {
                aicpusd_err("cannot get aicpuModel by modelId:[%u]!", taskContext.modelId);
            }
        }
        for (const auto mbuf : mbufsToFree) {
            if (modelPtr != nullptr) {
                (void) modelPtr->UnGardModelBuf(mbuf);
            }
            (void) halMbufFree(mbuf);
        }
    });

    int32_t ret = AllocateAndInitOutput(param, taskContext, mbufsToFree, hostAllocDynamicOutput);
    if (ret != AICPU_SCHEDULE_OK) {
        return ret;
    }

    ret = PrepareReqMsg(param, taskContext, mbufsToFree, hostAllocDynamicOutput);
    if (ret != AICPU_SCHEDULE_OK) {
        return ret;
    }

    mbufsToFree.clear();
    return AICPU_SCHEDULE_OK;
}

int32_t PrepareDynamicInputOutputBase::AllocateAndInitOutput(const PrepareDynamicInputOutputKernelArgs * const param,
                                                             const RunContext &taskContext,
                                                             std::vector<Mbuf *> &mbufsToFree,
                                                             const bool hostAllocDynamicOutput) const
{
    if (param->outputsNum == 0U) {
        aicpusd_info("Zero outputs");
        return AICPU_SCHEDULE_OK;
    }
    if (param->inputsNum == 0U) {
        aicpusd_err("Zero inputs");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const uint64_t * const inputPptrs = PtrToPtr<void, uint64_t>(ValueToPtr(param->inputMbufAddrsAddr));
    Mbuf *const inputMbuf = *(reinterpret_cast<Mbuf **>(inputPptrs[0U]));
    void *customBuf = nullptr;
    uint32_t customBufSize = 0U;
    const auto ret = halMbufGetPrivInfo(inputMbuf, &customBuf, &customBufSize);
    if ((ret != static_cast<int32_t>(DRV_ERROR_NONE)) || (customBuf == nullptr)) {
        aicpusd_err("Failed to get customBuf, ret[%d].", ret);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }

    const int64_t * const outputTensorSizes = PtrToPtr<void, int64_t>(ValueToPtr(param->outputTensorSizesAddr));
    uint64_t *const outputPptrs = PtrToPtr<void, uint64_t>(ValueToPtr(param->outputMbufAddrsAddr));
    for (size_t outputIndex = 0U; outputIndex < static_cast<size_t>(param->outputsNum); ++outputIndex) {
        if ((outputTensorSizes[outputIndex] < 0) || (outputPptrs[outputIndex] == 0U)) {
            aicpusd_err("Invalid outputTensorSizes[%zu]:%ld, or invalid pptr.",
                outputIndex, outputTensorSizes[outputIndex]);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        if (hostAllocDynamicOutput && (outputTensorSizes[outputIndex] == 0)) {
            aicpusd_info("Skip allocate mbuf for [%zu]th output for its size is 0.", outputIndex);
            *(reinterpret_cast<Mbuf **>(outputPptrs[outputIndex])) = nullptr;
            continue;
        }
        const size_t allocSize = static_cast<size_t>(outputTensorSizes[outputIndex]) + sizeof(RuntimeTensorDesc);
        Mbuf *mbuf = BufManager::GetInstance().MallocAndGuardBufU64(static_cast<uint64_t>(allocSize),
            taskContext.modelId);
        if (mbuf == nullptr) {
            aicpusd_err("model[%u] alloc mbuf fail, size: %zu.", taskContext.modelId, allocSize);
            return AICPU_SCHEDULE_ERROR_FROM_DRV;
        }
        mbufsToFree.emplace_back(mbuf);

        const auto copyRet = OperatorKernelCommon::CopyMbufHeadInfo(customBuf, customBufSize, mbuf);
        if (copyRet != AICPU_SCHEDULE_OK) {
            aicpusd_err("model[%u] copy head fail for [%zu]th output.", taskContext.modelId, outputIndex);
            return copyRet;
        }
        *(reinterpret_cast<Mbuf **>(outputPptrs[outputIndex])) = mbuf;
    }
    return AICPU_SCHEDULE_OK;
}

int32_t PrepareDynamicInputOutputBase::PrepareReqMsg(const PrepareDynamicInputOutputKernelArgs * const param,
                                                     const RunContext &taskContext, std::vector<Mbuf *> &mbufsToFree,
                                                     const bool hostAllocDynamicOutput) const
{
    // CalculateReqMsgSize
    size_t reqMsgSize = 0U;
    const uint32_t * const inputDynamicFlags = PtrToPtr<void, uint32_t>(ValueToPtr(param->inputDynamicFlagsAddr));
    for (size_t i = 0U; i < static_cast<size_t>(param->inputsNum); ++i) {
        aicpusd_info("inputDynamicFlags[%zu] is %u.", i, inputDynamicFlags[i]);
        if (inputDynamicFlags[i] > 0U) {
            reqMsgSize += sizeof(RuntimeTensorDesc);
        } else {
            reqMsgSize += sizeof(uint64_t);
        }
    }
    reqMsgSize += sizeof(uint64_t) * static_cast<size_t>(param->outputsNum);
    // AllocReqMbuf
    Mbuf *reqMbuf = BufManager::GetInstance().MallocAndGuardBufU64(static_cast<uint64_t>(reqMsgSize),
        taskContext.modelId);
    if (reqMbuf == nullptr) {
        aicpusd_err("model[%u] alloc mbuf fail, size: %zu.", taskContext.modelId, reqMsgSize);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }
    mbufsToFree.emplace_back(reqMbuf);

    void *reqDataPtr = nullptr;
    const auto reqRet = halMbufGetBuffAddr(reqMbuf, &reqDataPtr);
    if (reqRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
        aicpusd_err("model[%u] failed to get reqData ptr, ret[%d].", taskContext.modelId, reqRet);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }
    char_t *reqCursor = PtrToPtr<void, char_t>(reqDataPtr);

    const uint64_t * const inputPptrs = PtrToPtr<void, uint64_t>(ValueToPtr(param->inputMbufAddrsAddr));
    if (param->inputsNum > 0U) {
        Mbuf *const firstInputMbuf = *(reinterpret_cast<Mbuf **>(inputPptrs[0U]));
        void *customBuf = nullptr;
        uint32_t customBufSize = 0U;
        const auto ret = halMbufGetPrivInfo(firstInputMbuf, &customBuf, &customBufSize);
        if ((ret != static_cast<int32_t>(DRV_ERROR_NONE)) || (customBuf == nullptr)) {
            aicpusd_err("Failed to get customBuf, ret[%d].", ret);
            return AICPU_SCHEDULE_ERROR_FROM_DRV;
        }

        const auto copyRet = OperatorKernelCommon::CopyMbufHeadInfo(customBuf, customBufSize, reqMbuf);
        if (copyRet != AICPU_SCHEDULE_OK) {
            aicpusd_err("Copy head fail for reqMbuf, ret is %d.", copyRet);
            return copyRet;
        }
        (void)UpdateReqMsgHead(reqMbuf, inputPptrs, param->inputsNum, taskContext);
    }

    const uint32_t * const srcFusionOffsets = PtrToPtr<void, uint32_t>(ValueToPtr(param->inputFusionOffsetsAddr));
    for (size_t i = 0U; i < static_cast<size_t>(param->inputsNum); ++i) {
        Mbuf * const inputMbuf = *(reinterpret_cast<Mbuf **>(inputPptrs[i]));
        void *dataPtr = nullptr;
        const auto dataRet = halMbufGetBuffAddr(inputMbuf, &dataPtr);
        if (dataRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
            aicpusd_err("model[%u] failed to get data ptr, ret[%d].", taskContext.modelId, dataRet);
            return AICPU_SCHEDULE_ERROR_FROM_DRV;
        }

        if ((srcFusionOffsets != nullptr) && (srcFusionOffsets[i] > 0)) {
            uint64_t totalOffset = 0UL;
            const auto ret = OperatorKernelCommon::UpdateDataPtr(PtrToValue(&inputMbuf),
                                                                 static_cast<int32_t>(srcFusionOffsets[i]),
                                                                 dataPtr, totalOffset);
            if (ret != AICPU_SCHEDULE_OK) {
                aicpusd_err("Failed to update the[%zu]th data addr. fusion offset = %d.", i, srcFusionOffsets[i]);
                return ret;
            }
            aicpusd_info("Success to update the[%zu]th data addr. fusion offset = %d.", i, srcFusionOffsets[i]);
        }

        if (inputDynamicFlags[i] > 0U) {
            RuntimeTensorDesc *const tensorDesc = PtrToPtr<char_t, RuntimeTensorDesc>(reqCursor);
            const errno_t eRet = memcpy_s(tensorDesc, sizeof(RuntimeTensorDesc), dataPtr, sizeof(RuntimeTensorDesc));
            if (eRet != EOK) {
                aicpusd_err("model[%u] Data copy failed, ret[%d].", taskContext.modelId, eRet);
                return AICPU_SCHEDULE_ERROR_SAFE_FUNCTION_ERR;
            }
            tensorDesc->dataAddr = PtrToValue(dataPtr) + static_cast<uint64_t>(sizeof(RuntimeTensorDesc));
            reqCursor += sizeof(RuntimeTensorDesc);
        } else {
            uint64_t *const dataAddr = PtrToPtr<char_t, uint64_t>(reqCursor);
            *dataAddr = static_cast<uint64_t>(PtrToValue(dataPtr) + sizeof(RuntimeTensorDesc));
            reqCursor += sizeof(uint64_t);
        }
    }

    const int64_t * const outputTensorSizes = PtrToPtr<void, int64_t>(ValueToPtr(param->outputTensorSizesAddr));
    uint64_t *const outputPptrs = PtrToPtr<void, uint64_t>(ValueToPtr(param->outputMbufAddrsAddr));
    for (size_t i = 0U; i < static_cast<size_t>(param->outputsNum); ++i) {
        uint64_t *const dataAddr = PtrToPtr<char_t, uint64_t>(reqCursor);
        if (hostAllocDynamicOutput && (outputTensorSizes[i] == 0)) {
            *dataAddr = 0U;
        } else {
            Mbuf *const outputMbuf = *(reinterpret_cast<Mbuf **>(outputPptrs[i]));
            void *dataPtr = nullptr;
            const auto dataRet = halMbufGetBuffAddr(outputMbuf, &dataPtr);
            if (dataRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
                aicpusd_err("model[%u] failed to get data ptr, ret[%d].",  taskContext.modelId, dataRet);
                return AICPU_SCHEDULE_ERROR_FROM_DRV;
            }
            *dataAddr = static_cast<uint64_t>(PtrToValue(dataPtr) + sizeof(RuntimeTensorDesc));
        }
        reqCursor += sizeof(uint64_t);
    }

    Mbuf **const reqMbufPptr = PtrToPtr<void, Mbuf*>(ValueToPtr(param->reqMsgMbufAddr));
    *reqMbufPptr = reqMbuf;
    const auto model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if (model != nullptr) {
        aicpusd_info("Reset model. modelId=%u", taskContext.modelId);
        model->SetModelRetCode(0);
        model->SetNullDataFlag(false);
        model->ReSetModelEndOfSequence();
    }
    return AICPU_SCHEDULE_OK;
}

int32_t PrepareDynamicInputOutputBase::UpdateReqMsgHead(Mbuf *const reqMbuf, const uint64_t * const inputPptrs,
    const uint32_t inputNum, const RunContext &taskContext) const
{
    void *headBuf = nullptr;
    uint32_t headSize = 0U;
    const auto ret = halMbufGetPrivInfo(reqMbuf, &headBuf, &headSize);
    if ((ret != DRV_ERROR_NONE) || (headBuf == nullptr) || (static_cast<size_t>(headSize) < sizeof(MbufHeadMsg))) {
        aicpusd_err("Skip %s. modelId=%u, headSize=%u, baseSize=%lu",
                    __func__, taskContext.modelId, headSize, sizeof(MbufHeadMsg));
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    MbufHeadMsg * const msg = PtrToPtr<uint8_t, MbufHeadMsg>(PtrAdd<uint8_t>(PtrToPtr<void, uint8_t>(headBuf),
        MBUF_HEAD_MAX_SIZE, static_cast<size_t>(headSize) - sizeof(MbufHeadMsg)));
    int32_t retCode = 0;
    bool nullDataFlag = false;
    bool isEndofSequence = false;
    uint32_t i = 1U;
    while ((i < inputNum) && ((retCode == 0) || !nullDataFlag || !isEndofSequence)) {
        Mbuf *const inputMbuf = *(reinterpret_cast<Mbuf **>(inputPptrs[i++]));
        ExtractHeadInfo(inputMbuf, retCode, nullDataFlag, isEndofSequence);
    }

    if (retCode != 0 && (msg->retCode == 0)) {
        aicpusd_info("update reqMsgHead's ret code for model[%u].", taskContext.modelId);
        msg->retCode = retCode;
    }
    if (nullDataFlag) {
        aicpusd_info("update reqMsgHead's nullDataFlag for model[%u].", taskContext.modelId);
        msg->dataFlag |= MBUF_HEAD_DATA_FLAG_MASK;
    }

    if (isEndofSequence) {
        aicpusd_info("update reqMsgHead's endofSequence for model[%u].", taskContext.modelId);
        uint8_t * const res = PtrAdd<uint8_t>(PtrToPtr<void, uint8_t>(headBuf), MBUF_HEAD_MAX_SIZE,
            static_cast<size_t>(MBUF_HEAD_END_OF_SEQUENCE_POS));
        *res = END_OF_SEQUENCE_FLAG;
    }
    aicpusd_info("reqmsg's retcode is %d, nullflag is %d", msg->retCode, static_cast<int32_t>(msg->dataFlag));
    return AICPU_SCHEDULE_OK;
}

void PrepareDynamicInputOutputBase::ExtractHeadInfo(Mbuf *const mbuf, int32_t &retCode, bool &nullDataFlag,
                                                    bool &isEndofSequence) const
{
    void *customBuf = nullptr;
    uint32_t customBufSize = 0U;
    const auto ret = halMbufGetPrivInfo(mbuf, &customBuf, &customBufSize);
    if ((ret != static_cast<int32_t>(DRV_ERROR_NONE)) || (customBuf == nullptr) ||
        (customBufSize < MBUF_HEAD_MAX_SIZE)) {
        aicpusd_err("Failed to get customBuf, ret[%d].", ret);
        return;
    }
    MbufHeadMsg * const inputMsg = PtrToPtr<uint8_t, MbufHeadMsg>(
        PtrAdd<uint8_t>(PtrToPtr<void, uint8_t>(customBuf),
        MBUF_HEAD_MAX_SIZE, static_cast<size_t>(customBufSize) - sizeof(MbufHeadMsg)));
    if ((retCode == 0) && (inputMsg->retCode != 0)) {
        retCode = inputMsg->retCode;
    }

    if (!nullDataFlag &&
        (inputMsg->dataFlag & MBUF_HEAD_DATA_FLAG_MASK) == static_cast<uint8_t>(DataFlag::DFLOW_NULL_DATA_FLAG)) {
        nullDataFlag = true;
    }
    if (!isEndofSequence) {
        const uint8_t * const endOfSequence = PtrAdd<uint8_t>(
            PtrToPtr<void, uint8_t>(customBuf), MBUF_HEAD_MAX_SIZE,
            static_cast<size_t>(MBUF_HEAD_END_OF_SEQUENCE_POS));
        if (*endOfSequence == END_OF_SEQUENCE_FLAG) {
            isEndofSequence = true;
        }
    }
}

int32_t OperatorKernelPrepareDynamicInputOutput::Compute(const AicpuTaskInfo &kernelTaskInfo,
                                                          const RunContext &taskContext)
{
    return PrepareDynamicInputOutput(kernelTaskInfo, taskContext, false);
}

int32_t OperatorKernelPrepareDynamicInputOutputV2::Compute(const AicpuTaskInfo &kernelTaskInfo,
                                                            const RunContext &taskContext)
{
    return PrepareDynamicInputOutput(kernelTaskInfo, taskContext, true);
}


REGISTER_OPERATOR_KERNEL(KERNEL_PREPARE_DYNAMIC_INPUT_OUTPUT, OperatorKernelPrepareDynamicInputOutput);
REGISTER_OPERATOR_KERNEL(KERNEL_PREPARE_DYNAMIC_INPUT_OUTPUT_V2, OperatorKernelPrepareDynamicInputOutputV2);
}  // namespace AicpuSchedule