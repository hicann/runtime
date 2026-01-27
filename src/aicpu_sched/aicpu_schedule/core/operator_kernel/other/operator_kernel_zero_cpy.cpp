/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_zero_cpy.h"

#include "aicpusd_status.h"
#include "operator_kernel_common.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_ZERO_CPY = "zeroCpy";
const std::string KERNEL_ZERO_CPY_V2 = "zeroCpyV2";
const std::string KERNEL_CPU_ZERO_CPY = "cpuZeroCpy";
}  // namespace

int32_t OperatorKernelZeroCpy::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    AddrMapInfo *mapInfo = PtrToPtr<void, AddrMapInfo>(ValueToPtr(kernelTaskInfo.paraBase));
    if (mapInfo == nullptr) {
        aicpusd_err("ModelZeroCpy kernelTaskInfo paramBase is null, modelId[%u], streamId[%u], taskId[%u]",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const uint64_t *const srcAddrList = PtrToPtr<void, uint64_t>(ValueToPtr(mapInfo->srcAddrList));
    const uint64_t *const dstAddrList = PtrToPtr<void, uint64_t>(ValueToPtr(mapInfo->dstAddrList));
    if ((srcAddrList == nullptr) || (dstAddrList == nullptr)) {
        aicpusd_err("Failed to zero copy, srcAddrList or dstAddrList is null, modelId[%u], streamId[%u]",
            taskContext.modelId, taskContext.streamId);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    for (uint32_t i = 0U; i < mapInfo->addrNum; i++) {
        void *dataPtr = nullptr;
        const int32_t ret = OperatorKernelCommon::GetMbufDataPtr(srcAddrList[i], &dataPtr);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Failed to get mbuf data addr. srcAddrList[%u] is [%lu].", i, srcAddrList[i]);
            return ret;
        }
        const auto dstPtr = reinterpret_cast<void **>(static_cast<uintptr_t>(dstAddrList[i]));
        *dstPtr = dataPtr;
    }
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelZeroCpyV2::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    AddrMapInfoV2 * const mapInfo = reinterpret_cast<AddrMapInfoV2 *>(static_cast<uintptr_t>(kernelTaskInfo.paraBase));
    if (mapInfo == nullptr) {
        aicpusd_err("ModelDynZeroCpy kernelTaskInfo paramBase is null, modelId[%u], streamId[%u], taskId[%u]",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    return DoCompute(*mapInfo, taskContext);
}

int32_t OperatorKernelZeroCpyV2::DoCompute(AddrMapInfoV2 &mapInfo, const RunContext &taskContext) const
{
    const uint64_t * const srcAddrList = PtrToPtr<void, uint64_t>(ValueToPtr(static_cast<uintptr_t>(mapInfo.srcAddrList)));
    const uint64_t * const dstAddrList = PtrToPtr<void, uint64_t>(ValueToPtr(static_cast<uintptr_t>(mapInfo.dstAddrList)));
    const int32_t * const isNoTilingList = PtrToPtr<void, int32_t>(ValueToPtr(static_cast<uintptr_t>(mapInfo.isNoTilingList)));
    if ((srcAddrList == nullptr) || (dstAddrList == nullptr) || (isNoTilingList == nullptr)) {
        aicpusd_err("Failed to zero copy, srcAddrList, dstAddrList or isNoTilingList is null, "
                    "modelId[%u], streamId[%u]", taskContext.modelId, taskContext.streamId);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    std::vector<int32_t> fusionOffsets(mapInfo.addrNum);
    if (mapInfo.len >= sizeof(uint32_t) + sizeof(uint64_t) + sizeof(uint64_t)) {
        const uint64_t *const fusionOffsetListAddr =
            PtrToPtr<char, uint64_t>(mapInfo.extendInfo + sizeof(uint32_t) + sizeof(uint64_t));
        const int32_t ret = ResolveFusionOffsets(fusionOffsetListAddr, mapInfo.addrNum, fusionOffsets);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Failed to resolve fusion offsets, addr num = %u, ret = %d.", mapInfo.addrNum, ret);
            return ret;
        }
    }

    std::unordered_map<uint64_t, FusionInfo> fusionMap;
    for (uint32_t i = 0U; i < mapInfo.addrNum; i++) {
        void *srcDataPtr = nullptr;
        auto result = OperatorKernelCommon::GetMbufDataPtr(srcAddrList[i], &srcDataPtr);
        if (result != AICPU_SCHEDULE_OK) {
            aicpusd_err("Failed to get mbuf data addr. srcAddrList[%u] is [%lu].", i, srcAddrList[i]);
            return result;
        }

        if (fusionOffsets[i] > 0) {
            result = UpdateDataPtrExtend(srcAddrList[i], fusionOffsets[i], srcDataPtr, fusionMap);
            if (result != AICPU_SCHEDULE_OK) {
                aicpusd_err("Failed to update data addr. fusion offset[%d]", fusionOffsets[i]);
                return result;
            }
        }
        const auto dstPtr = reinterpret_cast<void **>(static_cast<uintptr_t>(dstAddrList[i]));
        *dstPtr = srcDataPtr;
        // if notiling will not skip
        if (isNoTilingList[i] != 0) {
            RuntimeTensorDesc * const tensorDesc = PtrToPtr<void, RuntimeTensorDesc>(srcDataPtr);
            tensorDesc->dataAddr =
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(srcDataPtr) + sizeof(RuntimeTensorDesc));
            const int32_t *destIsTilingList = nullptr;
            if (mapInfo.len >= sizeof(uint32_t) + sizeof(uint64_t)) {
                const uint64_t *const destIsTilingListPtr =
                    PtrToPtr<char, uint64_t>(mapInfo.extendInfo + sizeof(uint32_t));
                destIsTilingList = PtrToPtr<void, int32_t>(ValueToPtr(*destIsTilingListPtr));
            }
            if ((destIsTilingList != nullptr) && (destIsTilingList[i] == static_cast<int32_t>(true))) {
                *dstPtr = ValueToPtr(PtrToValue(srcDataPtr) + sizeof(RuntimeTensorDesc));
            }
        } else if (mapInfo.len >= sizeof(uint32_t)) {
            const uint32_t skipSize = *(PtrToPtr<char, uint32_t>(mapInfo.extendInfo));
            const uint64_t baseAddr = PtrToValue(srcDataPtr);
            if ((UINT64_MAX - baseAddr) < static_cast<uint64_t>(skipSize)) {
                aicpusd_err("AddrMapInfoV2 extendInfo skip size[%u] + baseAddr will overflow, modelId[%u], \
                    streamId[%u].", skipSize, taskContext.modelId, taskContext.streamId);
                return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
            }
            *dstPtr = ValueToPtr(baseAddr + static_cast<uint64_t>(skipSize));
        } else {}

        aicpusd_info("Zero cpy task success, addr index[%u], is notiling[%d].", i, isNoTilingList[i]);
    }
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelZeroCpyV2::ResolveFusionOffsets(const uint64_t *const fusionOffsetListAddr,
                                                      const uint32_t addrNum,
                                                      std::vector<int32_t> &fusionOffsets) const
{
    if (fusionOffsetListAddr == nullptr) {
        aicpusd_err("The fusion offset list addr is null.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    auto fusionOffsetList = PtrToPtr<void, int32_t>(ValueToPtr(*fusionOffsetListAddr));
    if (fusionOffsetList == nullptr) {
        aicpusd_err("The fusion offset list is null");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    for (uint32_t i = 0; i < addrNum; ++i) {
        fusionOffsets[i] = fusionOffsetList[i];
        aicpusd_info("Get fusion offset success, index = %u, fusion offset = %d.", i, fusionOffsetList[i]);
    }
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelZeroCpyV2::UpdateDataPtrExtend(const uint64_t mbufAddr, const int32_t fusionOffset, void *&dataPtr,
                                                     std::unordered_map<uint64_t, FusionInfo> &fusionMap) const
{
    const auto iter = fusionMap.find(mbufAddr);
    if (iter == fusionMap.end()) {
        uint64_t dataSize = 0UL;
        const int32_t ret = OperatorKernelCommon::GetMbufDataSize(mbufAddr, dataSize);
        if ((ret != AICPU_SCHEDULE_OK) || (dataSize < sizeof(RuntimeTensorDesc))) {
            aicpusd_err("Failed to get mbuf data size, ret = %d, dataSize[%lu] vs threshold[%zu]",
                ret, dataSize, sizeof(RuntimeTensorDesc));
            return (ret != AICPU_SCHEDULE_OK) ? ret : AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        FusionInfo info = {};
        info.dataSize = dataSize;
        fusionMap[mbufAddr] = info;
    }

    auto &fusionInfo = fusionMap[mbufAddr];
    if (fusionInfo.lastFusionOffset > fusionOffset) {
        fusionInfo.lastFusionOffset = 0;
        fusionInfo.lastDataOffset = 0U;
    }

    return OperatorKernelCommon::DoUpdateDataPtr(fusionInfo, fusionOffset, dataPtr);
}

int32_t OperatorKernelCpuZeroCpy::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    AddrMapInfo *mapInfo = reinterpret_cast<AddrMapInfo *>(static_cast<uintptr_t>(kernelTaskInfo.paraBase));
    if (mapInfo == nullptr) {
        aicpusd_err("ModelZeroCpy kernelTaskInfo paramBase is null, modelId[%u], streamId[%u], taskId[%u]",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    const uint64_t *const srcAddrList = PtrToPtr<void, uint64_t>(ValueToPtr(static_cast<uintptr_t>(mapInfo->srcAddrList)));
    const uint64_t *const dstAddrList = PtrToPtr<void, uint64_t>(ValueToPtr(static_cast<uintptr_t>(mapInfo->dstAddrList)));
    if ((srcAddrList == nullptr) || (dstAddrList == nullptr)) {
        aicpusd_err("Failed to zero copy, srcAddrList or dstAddrList is null, modelId[%u], streamId[%u]",
            taskContext.modelId, taskContext.streamId);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    aicpusd_info("copy from %p to %p", srcAddrList, dstAddrList);
    for (uint32_t i = 0U; i < mapInfo->addrNum; i++) {
        const auto dstPtr = reinterpret_cast<void **>(ValueToPtr(dstAddrList[static_cast<size_t>(i)]));
        const auto srcPtr = reinterpret_cast<void **>(ValueToPtr(srcAddrList[static_cast<size_t>(i)]));
        *dstPtr = *srcPtr;
        aicpusd_info("copy element %p, srcPptr %p, dstPptr %p", *dstPtr, srcPtr, dstPtr);
    }
    return AICPU_SCHEDULE_OK;
}


REGISTER_OPERATOR_KERNEL(KERNEL_ZERO_CPY, OperatorKernelZeroCpy);
REGISTER_OPERATOR_KERNEL(KERNEL_ZERO_CPY_V2, OperatorKernelZeroCpyV2);
REGISTER_OPERATOR_KERNEL(KERNEL_CPU_ZERO_CPY, OperatorKernelCpuZeroCpy);
}  // namespace AicpuSchedule