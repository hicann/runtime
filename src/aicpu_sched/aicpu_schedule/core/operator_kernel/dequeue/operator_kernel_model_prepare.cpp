/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_model_prepare.h"

#include "aicpusd_status.h"
#include "aicpusd_profiler.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_resource_manager.h"
#include "operator_kernel_common.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_MODEL_PREPARE = "modelPrepare";
constexpr uint32_t ONLY_ONE_QUEUE = 1U;
}  // namespace

int32_t OperatorKernelModelPrepare::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    const auto prepareInfo = PtrToPtr<void, AicpuPrepareInfo>(ValueToPtr(kernelTaskInfo.paraBase));
    if (prepareInfo == nullptr) {
        aicpusd_err("ModelPrepare kernelTaskInfo paramBase is null, modelId[%u], streamId[%u], taskId[%u].",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (prepareInfo->aicpuPareInfoSize != sizeof(AicpuPrepareInfo)) {
        aicpusd_err("Failed check AicpuPrepareInfo size. msgInfo.aicpuPareInfoSize is [%u], "
            "calc AicpuPrepareInfo is [%zu].",
            prepareInfo->aicpuPareInfoSize, sizeof(AicpuPrepareInfo));
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (ChecPrepareNullptr(*prepareInfo) != AICPU_SCHEDULE_OK) {
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (CheckPrepareMaxSize(*prepareInfo) != AICPU_SCHEDULE_OK) {
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (!CheckPointListNullptr(PtrToPtr<void, uint64_t>(ValueToPtr(static_cast<uintptr_t>(prepareInfo->inputAddrList))),
        prepareInfo->inputAddrNum)) {
        aicpusd_err("inputAddrList has null pointers!");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (!CheckPointListNullptr(PtrToPtr<void, uint64_t>(ValueToPtr(static_cast<uintptr_t>(prepareInfo->outputAddrList))),
        prepareInfo->outputAddrNum)) {
        aicpusd_err("outputAddrList has null pointers!");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (prepareInfo->inQueueNum > prepareInfo->inputAddrNum) {
        aicpusd_err("Failed check AicpuPrepareInfo, inQueueNum[%u] is bigger then inputAddrNum[%u].",
            prepareInfo->inQueueNum, prepareInfo->inputAddrNum);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if ((prepareInfo->outQueueNum != ONLY_ONE_QUEUE) && (prepareInfo->outQueueNum != prepareInfo->outputMbufNum)) {
        aicpusd_err("Failed check AicpuPrepareInfo, outQueueNum[%u] is not 1 or equal with outputMbufNum[%u].",
            prepareInfo->outQueueNum, prepareInfo->outputMbufNum);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    return DoCompute(*prepareInfo, taskContext);
}

int32_t OperatorKernelModelPrepare::ChecPrepareNullptr(const AicpuPrepareInfo &prepareInfo) const
{
    if (prepareInfo.inputAddrNum == 0U) {
        aicpusd_err("inputAddrNum is zero!");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (prepareInfo.outputAddrNum == 0U) {
        aicpusd_err("outputAddrNum is zero!");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (prepareInfo.outputMbufNum == 0U) {
        aicpusd_err("outputMbufNum is zero!");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (prepareInfo.inputAddrList == 0UL) {
        aicpusd_err("inputAddrList pointers is nullptr!");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (prepareInfo.inputIndexList == 0UL) {
        aicpusd_err("inputIndexList pointers is nullptr!");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (prepareInfo.outputAddrList == 0UL) {
        aicpusd_err("outputAddrList pointers is nullptr!");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (prepareInfo.outputIndexList == 0UL) {
        aicpusd_err("outputIndexList pointers is nullptr!");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (prepareInfo.outDataSizeList == 0UL) {
        aicpusd_err("outDataSizeList pointers is nullptr!");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (prepareInfo.inQueueIdList == 0UL) {
        aicpusd_err("inQueueIdList pointers is nullptr!");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (prepareInfo.mbufPtrlist == 0UL) {
        aicpusd_err("mbufPtrlist pointers is nullptr!");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelModelPrepare::CheckPrepareMaxSize(const AicpuPrepareInfo &prepareInfo) const
{
    if (prepareInfo.inputAddrNum > MAX_SIZE_NUM) {
        aicpusd_err("inputAddrNum:[%u] out of max size:[%u]!", prepareInfo.inputAddrNum, MAX_SIZE_NUM);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (prepareInfo.outputAddrNum > MAX_SIZE_NUM) {
        aicpusd_err("outputAddrNum:[%u] out of max size:[%u]!", prepareInfo.outputAddrNum, MAX_SIZE_NUM);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (prepareInfo.outputMbufNum > MAX_SIZE_NUM) {
        aicpusd_err("outputMbufNum:[%u] out of max size:[%u]!", prepareInfo.outputMbufNum, MAX_SIZE_NUM);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (prepareInfo.inQueueNum > MAX_SIZE_NUM) {
        aicpusd_err("inQueueNum:[%u] out of max size:[%u]!", prepareInfo.inQueueNum, MAX_SIZE_NUM);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (prepareInfo.outQueueNum > MAX_SIZE_NUM) {
        aicpusd_err("outQueueNum:[%u] out of max size:[%u]!", prepareInfo.outQueueNum, MAX_SIZE_NUM);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    return AICPU_SCHEDULE_OK;
}

bool OperatorKernelModelPrepare::CheckPointListNullptr(const uint64_t * const pointList, const uint32_t pointSize) const
{
    for (uint32_t i = 0U; i < pointSize; i++) {
        if (*(pointList + i) == 0UL) {
            return false;
        }
    }
    return true;
}

int32_t OperatorKernelModelPrepare::DoCompute(AicpuPrepareInfo &msgInfo, const RunContext &taskContext) const
{
    AicpuModel *model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if (model == nullptr) {
        aicpusd_err("cannot get model by modelId:[%u]!", taskContext.modelId);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    ModelPrepareData &prepareData = model->GetModelPrepareData();
    std::vector<void *> &inputDataPtrs = model->GetInputDataPtrs();

    auto ret = DequeueMbufList(msgInfo, prepareData, inputDataPtrs, taskContext);
    if (ret != AICPU_SCHEDULE_OK) {
        return ret;
    }
    if (taskContext.pending) {
        aicpusd_info("Model stream pending on.");
        return ret;
    }
    g_aicpuProfiler.SetModelStart();
    Mbuf *lastInputMbuflist = reinterpret_cast<Mbuf *>(prepareData.lastInputMbuflistPtr);

    ret = CopyDequeueDataPtrToInputAddr(msgInfo, inputDataPtrs);
    if (ret != AICPU_SCHEDULE_OK) {
        return ret;
    }
    Mbuf *mbufPtrStore[MAX_SIZE_NUM] = {};
    ret = AllocOutputMbufList(msgInfo, &lastInputMbuflist, mbufPtrStore, taskContext);
    if (ret != AICPU_SCHEDULE_OK) {
        return ret;
    }
    void *dataPtrStore[MAX_SIZE_NUM] = {};
    ret = GetDataPtrsFromMbufs(msgInfo, mbufPtrStore, dataPtrStore);
    if (ret != AICPU_SCHEDULE_OK) {
        return ret;
    }
    ret = CopyOutputDataPtrToOutputAddr(msgInfo, dataPtrStore);
    if (ret != AICPU_SCHEDULE_OK) {
        return ret;
    }
    ret = BuildEnqueueMbufPtrList(msgInfo, mbufPtrStore);
    if (ret != AICPU_SCHEDULE_OK) {
        return ret;
    }

    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelModelPrepare::DequeueMbufList(const AicpuPrepareInfo &msgInfo, ModelPrepareData &prepareData,
                                                    std::vector<void *> &inputsData, const RunContext &taskContext) const
{
    int32_t ret = AICPU_SCHEDULE_OK;
    void *mBufListPtr = nullptr;
    uint32_t mbufListNum = 0U;
    BufEnQueueInfo bufInfo;
    const uint32_t *inQueueIdList = PtrToPtr<void, uint32_t>(ValueToPtr(static_cast<uintptr_t>(msgInfo.inQueueIdList)));

    g_aicpuProfiler.SetDqStart();
    for (; prepareData.dequeueIndex < msgInfo.inQueueNum; prepareData.dequeueIndex++) {
        bufInfo.queueID = *(inQueueIdList + prepareData.dequeueIndex);
        bufInfo.mBufPtr = reinterpret_cast<uintptr_t>(&mBufListPtr);
        ret = DequeueTask(bufInfo, taskContext, true);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        if (taskContext.pending) {
            aicpusd_info("Model stream pending on.");
            return ret;
        }

        if (prepareData.dequeueIndex == 0U) {
            prepareData.lastInputMbuflistPtr = mBufListPtr;
        }

        // store dataptr
        const auto drvRet = halMbufChainGetMbufNum(static_cast<Mbuf *>(mBufListPtr), &mbufListNum);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Failed to get mbuf number, ret[%d].", drvRet);
            return AICPU_SCHEDULE_ERROR_FROM_DRV;
        }
        if (mbufListNum == 0U) {
            aicpusd_err("Get error number form mbuf, ret[%d].", ret);
            return AICPU_SCHEDULE_ERROR_FROM_DRV;
        }
        for (uint32_t mbufRangeIndex = 0U; mbufRangeIndex < mbufListNum; mbufRangeIndex++) {
            void *dataPtr = nullptr;
            ret = GetMbufListDataPtr(mBufListPtr, &dataPtr, mbufRangeIndex);
            if (ret != AICPU_SCHEDULE_OK) {
                aicpusd_err("Failed to get mbuf data addr, ret:%d, index:%u.", ret, mbufRangeIndex);
                return ret;
            }
            inputsData.push_back(dataPtr);
        }
    }
    g_aicpuProfiler.SetDqEnd();
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelModelPrepare::CopyDequeueDataPtrToInputAddr(AicpuPrepareInfo &msgInfo,
                                                                  const std::vector<void *> &inputsData) const
{
    int32_t ret = AICPU_SCHEDULE_OK;
    const uint32_t *inputIndexList = PtrToPtr<void, uint32_t>(ValueToPtr(static_cast<uintptr_t>(msgInfo.inputIndexList)));
    uint64_t *inputAddrList = PtrToPtr<void, uint64_t>(ValueToPtr(static_cast<uintptr_t>(msgInfo.inputAddrList)));
    // zero copy
    uint64_t *inputAddrPtr = nullptr;
    for (size_t addrIndex = 0UL; addrIndex < static_cast<size_t>(msgInfo.inputAddrNum); addrIndex++) {
        if (*(PtrAdd<const uint32_t>(inputIndexList, msgInfo.inputAddrNum, addrIndex)) < inputsData.size()) {
            inputAddrPtr = PtrToPtr<void, uint64_t>(ValueToPtr(static_cast<uintptr_t>(*(PtrAdd<uint64_t>(inputAddrList, msgInfo.inputAddrNum, addrIndex)))));
            *(inputAddrPtr) = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(
                inputsData[static_cast<size_t>(*(PtrAdd<const uint32_t>(inputIndexList, msgInfo.inputAddrNum, addrIndex)))]));
        } else {
            aicpusd_err("Prepare dequeue mbuf index out of range, index:[%u], inputIndexList[addrIndex]:[%zu], "
                "number of mbuf is:[%zu].",
                addrIndex, inputIndexList[addrIndex], inputsData.size());
            ret = AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
            break;
        }
    }
    return ret;
}

int32_t OperatorKernelModelPrepare::AllocOutputMbufList(AicpuPrepareInfo &msgInfo,
                                                        Mbuf **lastInputMbuflistPptr,
                                                        Mbuf *(&mbufPtrStore)[MAX_SIZE_NUM],
                                                        const RunContext &taskContext) const
{
    int32_t ret = AICPU_SCHEDULE_OK;
    uint32_t * const outDataSizeList = PtrToPtr<void, uint32_t>(ValueToPtr(static_cast<uintptr_t>(msgInfo.outDataSizeList)));

    g_aicpuProfiler.SetPrepareOutStart();
    if (msgInfo.outQueueNum == ONLY_ONE_QUEUE) {
        ret = BufManager::GetInstance().MallocAndGuardBufList(outDataSizeList, msgInfo.outputMbufNum,
            taskContext.modelId, true, &mbufPtrStore[0]);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
    } else if (msgInfo.outputMbufNum == msgInfo.outQueueNum) {
        ret = BufManager::GetInstance().MallocAndGuardBufList(outDataSizeList, msgInfo.outputMbufNum,
            taskContext.modelId, false, &mbufPtrStore[0]);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
    } else {
        aicpusd_err("error outputMbufNum. outputMbufNum:%u, outQueueNum:%u.", msgInfo.outputMbufNum,
            msgInfo.outQueueNum);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    g_aicpuProfiler.SetPrepareOutEnd();

    void *headerInfoBuf = nullptr;
    uint32_t headerInfoBufSize = 0U;
    const auto drvRet = halMbufGetPrivInfo(*lastInputMbuflistPptr, &headerInfoBuf, &headerInfoBufSize);
    if (drvRet != DRV_ERROR_NONE) {
        aicpusd_err("Failed to get head info in input information, ret[%d].", drvRet);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }

    for (uint32_t i = 0U; i < msgInfo.outputMbufNum; i++) {
        ret = OperatorKernelCommon::CopyMbufHeadInfo(headerInfoBuf, headerInfoBufSize, mbufPtrStore[i]);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
    }
    g_aicpuProfiler.SetMbufHead(headerInfoBuf);
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelModelPrepare::GetDataPtrsFromMbufs(const AicpuPrepareInfo &msgInfo,
                                                         Mbuf *(&mbufPtrStore)[MAX_SIZE_NUM],
                                                         void *(&dataPtrStore)[MAX_SIZE_NUM]) const
{
    int32_t ret = AICPU_SCHEDULE_OK;
    void *dataPtr = nullptr;
    if (msgInfo.outQueueNum == ONLY_ONE_QUEUE) {
        uint32_t mbufListNum = 0U;
        const auto drvRet = halMbufChainGetMbufNum(mbufPtrStore[0U], &mbufListNum);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Failed to get mbuf number, ret[%d].", drvRet);
            return AICPU_SCHEDULE_ERROR_FROM_DRV;
        }
        if (mbufListNum == 0U) {
            aicpusd_err("Get error number form mbuf, ret[%d].", ret);
            return AICPU_SCHEDULE_ERROR_FROM_DRV;
        }
        for (uint32_t i = 0U; i < mbufListNum; i++) {
            ret = GetMbufListDataPtr(mbufPtrStore[0U], &dataPtr, i);
            if (ret != AICPU_SCHEDULE_OK) {
                aicpusd_err("Failed to get mbuf data addr.");
                return ret;
            }
            dataPtrStore[i] = dataPtr;
        }
    } else if (msgInfo.outputMbufNum == msgInfo.outQueueNum) {
        for (uint32_t i = 0U; i < msgInfo.outputMbufNum; i++) {
            ret = OperatorKernelCommon::GetMbufDataPtr(
                reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(&(mbufPtrStore[i]))), &dataPtr);
            if (ret != AICPU_SCHEDULE_OK) {
                aicpusd_err("Failed to get mbuf data addr.");
                return ret;
            }
            dataPtrStore[i] = dataPtr;
        }
    } else {
        aicpusd_err("error GetDataPtrsFromMbufs. outputMbufNum:%u, outQueueNum:%u.", msgInfo.outputMbufNum,
            msgInfo.outQueueNum);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelModelPrepare::CopyOutputDataPtrToOutputAddr(AicpuPrepareInfo &msgInfo, 
                                                                  void * const (&dataPtrStore)[MAX_SIZE_NUM]) const
{
    uint64_t * const outputAddrList = PtrToPtr<void, uint64_t>(ValueToPtr(static_cast<uintptr_t>(msgInfo.outputAddrList)));
    const uint32_t * const outputIndexList =
        PtrToPtr<void, uint32_t>(ValueToPtr(static_cast<uintptr_t>(msgInfo.outputIndexList)));

    // zero copy
    uint64_t *outputAddrPtr = nullptr;
    for (uint32_t addrIndex = 0U; addrIndex < msgInfo.outputAddrNum; addrIndex++) {
        if (outputIndexList[addrIndex] < msgInfo.outputMbufNum) {
            outputAddrPtr = PtrToPtr<void, uint64_t>(ValueToPtr(static_cast<uintptr_t>(outputAddrList[addrIndex])));
            *(outputAddrPtr) =
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(dataPtrStore[outputIndexList[addrIndex]]));
        } else {
            aicpusd_err("Prepare output datas index out of range, index:[%u], outputIndexList[addrIndex]:[%u], "
                "msgInfo.outputMbufNum is:[%u].",
                addrIndex, outputIndexList[addrIndex], msgInfo.outputMbufNum);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
    }
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelModelPrepare::BuildEnqueueMbufPtrList(AicpuPrepareInfo &msgInfo,
                                                            Mbuf *(&mbufPtrStore)[MAX_SIZE_NUM]) const
{
    Mbuf **mbufPtrlist = reinterpret_cast<Mbuf **>(static_cast<uintptr_t>(msgInfo.mbufPtrlist));
    if ((msgInfo.outQueueNum == ONLY_ONE_QUEUE) && (*mbufPtrStore != nullptr)) {
        mbufPtrlist[0U] = mbufPtrStore[0U];
        return AICPU_SCHEDULE_OK;
    }

    if (msgInfo.outputMbufNum == msgInfo.outQueueNum) {
        for (size_t i = 0UL; i < msgInfo.outQueueNum; i++) {
            mbufPtrlist[i] = mbufPtrStore[i];
        }
        return AICPU_SCHEDULE_OK;
    }
    aicpusd_err("BuildEnqueueMbufPtrList:error outputMbufNum. outputMbufNum:%u, outQueueNum:%u.",
        msgInfo.outputMbufNum, msgInfo.outQueueNum);
    return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
}

int32_t OperatorKernelModelPrepare::GetMbufListDataPtr(void *mbufPtr, void **dataAddrPtr, const uint32_t mbufIndex) const
{
    if (dataAddrPtr == nullptr) {
        aicpusd_err("Mbuf data ptr is null.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    if (mbufPtr == nullptr) {
        aicpusd_err("mbufPtr is null.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    Mbuf *dataMbuf = nullptr;
    const auto drvRet = halMbufChainGetMbuf(PtrToPtr<void, Mbuf>(mbufPtr), mbufIndex, &dataMbuf);
    if (drvRet != DRV_ERROR_NONE) {
        aicpusd_err("Failed to get mbuf from mbuflist, ret[%d].", drvRet);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }
    if (dataMbuf == nullptr) {
        aicpusd_err("Mbuf get from mbuflist is nullptr, ret[%d].", drvRet);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }

    const auto ret = OperatorKernelCommon::GetMbufDataPtr(static_cast<uint64_t>(reinterpret_cast<uintptr_t>(&dataMbuf)),
                                                          dataAddrPtr);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Failed to get mbuf data addr. ret is [%d]", ret);
        return ret;
    }
    return AICPU_SCHEDULE_OK;
}


REGISTER_OPERATOR_KERNEL(KERNEL_MODEL_PREPARE, OperatorKernelModelPrepare);
}  // namespace AicpuSchedule