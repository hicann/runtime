/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_model_prepare_non_zero_copy_input.h"

#include <vector>
#include "securec.h"
#include "aicpusd_status.h"
#include "operator_kernel_common.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_MODEL_PREPARE_NON_ZERO_COPY_INPUT = "modelPrepareNonZeroCopyInput";
}  // namespace

int32_t OperatorKernelModelPrepareNonZeroCopyInput::Compute(const AicpuTaskInfo &kernelTaskInfo,
                                                             const RunContext &taskContext)
{
    InputCopyAddrMapInfo *mapInfo = PtrToPtr<void, InputCopyAddrMapInfo>(ValueToPtr(kernelTaskInfo.paraBase));
    if (mapInfo == nullptr) {
        aicpusd_err("Model prepare non-zero copy input para is nullptr, modelId[%u], streamId[%u], taskId[%u]",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    return DoCompute(*mapInfo, taskContext);
}

uint32_t OperatorKernelModelPrepareNonZeroCopyInput::DoCompute(const InputCopyAddrMapInfo &mapInfo,
                                                               const RunContext &taskContext) const
{
    const uint64_t *srcAddrList = PtrToPtr<void, uint64_t>(ValueToPtr(mapInfo.srcAddrList));
    const uint64_t *dstAddrList = PtrToPtr<void, uint64_t>(ValueToPtr(mapInfo.dstAddrList));
    const uint64_t *dstAddrLenList = PtrToPtr<void, uint64_t>(ValueToPtr(mapInfo.dstAddrLenList));
    const int32_t *srcFusionOffsetList = PtrToPtr<void, int32_t>(ValueToPtr(mapInfo.srcFusionOffsetList));
    if ((srcAddrList == nullptr) || (dstAddrList == nullptr) || (dstAddrLenList == nullptr)) {
        aicpusd_err("Failed to non-zero copy by nullptr, modelId[%u], streamId[%u]",
                    taskContext.modelId, taskContext.streamId);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    std::vector<int32_t> srcFusionOffsets(mapInfo.addrNum);
    if (srcFusionOffsetList != nullptr) {
        for (uint32_t i = 0U; i < mapInfo.addrNum; i++) {
            srcFusionOffsets[i] = srcFusionOffsetList[i];
        }
    }

    for (uint32_t i = 0U; i < mapInfo.addrNum; i++) {
        void *srcDataPtr = nullptr;
        uint64_t totalOffset = 0UL;
        int32_t ret = OperatorKernelCommon::GetMbufDataPtr(srcAddrList[i], &srcDataPtr);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Failed to get mbuf data addr. modelId[%u], addrNum[%u].", taskContext.modelId, i);
            return ret;
        }

        if (srcFusionOffsets[i] > 0) {
            ret = OperatorKernelCommon::UpdateDataPtr(srcAddrList[i], srcFusionOffsets[i], srcDataPtr, totalOffset);
            if (ret != AICPU_SCHEDULE_OK) {
                aicpusd_err("Failed to update data addr. fusion offset = %d.", srcFusionOffsets[i]);
                return ret;
            }
        }

        const auto mbufPptr = reinterpret_cast<Mbuf **>(static_cast<uintptr_t>(srcAddrList[i]));
        uint64_t srcDataLen = 0UL;
        ret = halMbufGetDataLen(*mbufPptr, &srcDataLen);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("Get mbuf datalen failed. modelId[%u], addrNum[%u], ret[%d]", taskContext.modelId, i, ret);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        if (srcDataLen < sizeof(RuntimeTensorDesc)) {
            aicpusd_err("The mbuf datalen is less than tensor desc. modelId[%u], srcDataLen[%lu], addrNum[%u]",
                        taskContext.modelId, srcDataLen, i);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        uint32_t dataSize = 0U;
        const RuntimeTensorDesc * const srcTensorDesc = PtrToPtr<void, RuntimeTensorDesc>(srcDataPtr);
        ret = OperatorKernelCommon::ParseTensorDescAndCalcDataSize(srcTensorDesc, dataSize);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Parse runtime tensor desc failed, ret[%d]", ret);
            return ret;
        }

        if (srcDataLen < (sizeof(RuntimeTensorDesc) + totalOffset + dataSize)) {
            aicpusd_err("The mbuf datalen is invalid. modelId[%u], srcDataLen[%lu], addrNum[%u], "
                        "dataSize[%u], totalOffset[%lu].",
                        taskContext.modelId, srcDataLen, i, dataSize, totalOffset);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        srcDataPtr = ValueToPtr(PtrToValue(srcDataPtr) + sizeof(RuntimeTensorDesc));
        const int32_t eRet = memcpy_s(ValueToPtr(dstAddrList[i]), dstAddrLenList[i], srcDataPtr, dataSize);
        if (eRet != EOK) {
            aicpusd_err("Data copy failed. modelId[%u], addrNum[%u], dstAddrLen[%lu], dataSize[%lu], ret[%d]",
                        taskContext.modelId, i, dstAddrLenList[i], dataSize, eRet);
            return AICPU_SCHEDULE_ERROR_SAFE_FUNCTION_ERR;
        }
    }

    return AICPU_SCHEDULE_OK;
}

REGISTER_OPERATOR_KERNEL(KERNEL_MODEL_PREPARE_NON_ZERO_COPY_INPUT, OperatorKernelModelPrepareNonZeroCopyInput);
}  // namespace AicpuSchedule