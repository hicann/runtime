/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_gather_dequeue.h"

#include "aicpusd_event_process.h"
#include "aicpusd_status.h"
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_msg_send.h"
#include "aicpusd_resource_manager.h"
#include "operator_kernel_common.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_GATHER_DEQUEUE = "gatherDequeue";
}  // namespace

int32_t OperatorKernelGatherDequeue::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    aicpusd_info("Start ModelGatherDeque. modelId=%u, streamId=%u, taskId=%u",
                 taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID);
    if (kernelTaskInfo.paraBase == 0UL) {
        aicpusd_err("kernelTaskInfo.paraBase is null");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const GatherDequeParam * const batchDeqInfo = PtrToPtr<void, GatherDequeParam>(ValueToPtr(kernelTaskInfo.paraBase));
    if ((batchDeqInfo->inputNums == 0U) || (batchDeqInfo->queueIdsAddr == 0U) || (batchDeqInfo->mbufAddrsAddr == 0U)) {
        aicpusd_err("inputNums or queueIdsAddr or mbufAddrsAddr is invalid");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const auto model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if (model == nullptr) {
        aicpusd_err("Cannot get model by modelId:[%u], streamId[%u], taskId[%u].",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    int32_t gatherRet = AICPU_SCHEDULE_OK;
    if (SelectMbuf(batchDeqInfo, taskContext, model, gatherRet)) {
        return gatherRet;
    }

    EventWaitManager::AnyQueNotEmptyWaitManager().ResetEventState(static_cast<size_t>(taskContext.modelId));
    // if not gathered, then pending; if pending fail, try gather again
    bool blockOnClientQ = false;
    const auto tempContext = taskContext;
    // DequeAndCheckIfReady with tempContext to avoid taskContext being modified
    while (!DequeAndCheckIfReady(batchDeqInfo, gatherRet, model, tempContext, blockOnClientQ)) {
        bool needWait = false;
        aicpusd_info("Batch queue is not gathered, modelId[%u], streamId[%u], taskId[%u].",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        EventWaitManager::AnyQueNotEmptyWaitManager().WaitEvent(static_cast<size_t>(taskContext.modelId),
            taskContext.streamId, needWait);
        if (needWait) {
            bool * const pending = const_cast<bool *>(&taskContext.pending);
            *pending = true;
            aicpusd_info("ModelGatherDeque pending, modelId[%u], streamId[%u], taskId[%u].",
                taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
            if (blockOnClientQ && !model->GetModelDestroyStatus()) {
                aicpusd_info("Submit supply enque event for model[%u] blocked on client queue.", taskContext.modelId);
                AICPUSubEventInfo subEventInfo = {};
                subEventInfo.modelId = taskContext.modelId;
                (void) AicpuMsgSend::SendAICPUSubEvent(
                    PtrToPtr<AICPUSubEventInfo, const char_t>(&subEventInfo),
                    static_cast<uint32_t>(sizeof(AICPUSubEventInfo)), AICPU_SUB_EVENT_SUPPLY_ENQUEUE,
                    CP_DEFAULT_GROUP_ID, true);
            }
            break;
        }
    }
    return (gatherRet == AICPU_SCHEDULE_ERROR_MODEL_UNLOAD) ? AICPU_SCHEDULE_OK : gatherRet;
}

bool OperatorKernelGatherDequeue::SelectMbuf(const GatherDequeParam * const batchDeqInfo, const RunContext &taskContext,
                                             void *const modelPtr, int32_t &gatherRet) const
{
    AicpuModel* const model = PtrToPtr<void, AicpuModel>(modelPtr);
    Mbuf ***mbufPptr = PtrToPtr<void, Mbuf**>(ValueToPtr(batchDeqInfo->mbufAddrsAddr));
    const auto selectRes =
        model->SelectGatheredMbuf(mbufPptr, batchDeqInfo->inputsAlignTimeout, batchDeqInfo->inputsAlignMaxCacheNum);
    if (selectRes == GatherResult::UN_SELECTED) {
        return false;
    }

    if (selectRes == GatherResult::SELECTED) {
        for (size_t i = 0U; i < static_cast<size_t>(batchDeqInfo->inputNums); ++i) {
            (void) BufManager::GetInstance().GuardBuf(*mbufPptr[i], taskContext.modelId);
        }
        gatherRet = AICPU_SCHEDULE_OK;
        return true;
    }

    // fake selected
    // allow drop
    if (batchDeqInfo->inputsAlignDropout != 0U) {
        for (size_t i = 0U; i < static_cast<size_t>(batchDeqInfo->inputNums); ++i) {
            if (*mbufPptr[i] != nullptr) {
                aicpusd_info("free the [%zu]th mbuf", i);
                (void) halMbufFree(*mbufPptr[i]);
            }
        }
        return false;
    }
    // not allow drop
    Mbuf *const stubMbuf = MakeUpPassedMbuf(taskContext.modelId);
    for (size_t i = 0U; i < static_cast<size_t>(batchDeqInfo->inputNums); ++i) {
        if (*mbufPptr[i] != nullptr) {
            (void) BufManager::GetInstance().GuardBuf(*mbufPptr[i], taskContext.modelId);
        } else {
            // when FAKE_SELECTED, there's some null mbuf, then we should alloc
            aicpusd_info("stub mbuf for the [%zu]th input", i);
            *mbufPptr[i] = stubMbuf;
        }
    }
    gatherRet = AICPU_SCHEDULE_ERROR_DISCARD_DATA;
    return true;
}

Mbuf *OperatorKernelGatherDequeue::MakeUpPassedMbuf(const uint32_t modelId) const
{
    Mbuf *stubMbuf = BufManager::GetInstance().MallocAndGuardBufU64(
        static_cast<uint64_t>(sizeof(RuntimeTensorDesc)), modelId);
    if (stubMbuf == nullptr) {
        aicpusd_err("Failed to alloc stubMbuf");
        return nullptr;
    }

    MbufHeadMsg * const headMsg = GetMbufHeadMsg(stubMbuf);
    if (headMsg == nullptr) {
        aicpusd_err("null head");
        return nullptr;
    }

    headMsg->retCode = INNER_ERROR_BASE + AICPU_SCHEDULE_ERROR_DISCARD_DATA;

    uint64_t mbufLen = 0UL;
    void *dataPtr = nullptr;
    const auto bufInfoRet = OperatorKernelCommon::GetMbufAddrAndSize(stubMbuf, &dataPtr, &mbufLen, modelId, true);
    if (bufInfoRet != AICPU_SCHEDULE_OK) {
        return nullptr;
    }
    RuntimeTensorDesc *const tensorDesc = PtrToPtr<void, RuntimeTensorDesc>(dataPtr);
    tensorDesc->shape[0U] = 1;
    tensorDesc->shape[1U] = 0;
    tensorDesc->originalShape[0U] = 1;
    tensorDesc->originalShape[1U] = 0;
    tensorDesc->dataSize = 0U;

    return stubMbuf;
}

MbufHeadMsg *OperatorKernelGatherDequeue::GetMbufHeadMsg(Mbuf *const mbuf) const
{
    void *headBuf = nullptr;
    uint32_t headSize = 0U;
    const auto drvRet = halMbufGetPrivInfo(mbuf, &headBuf, &headSize);
    if ((drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) ||
        (headBuf == nullptr) || (static_cast<size_t>(headSize) < sizeof(MbufHeadMsg))) {
        aicpusd_err("Failed to get head info in input information, ret[%d].", drvRet);
        return nullptr;
    }
    return PtrToPtr<char_t, MbufHeadMsg>(PtrToPtr<void, char_t>(headBuf) + headSize - sizeof(MbufHeadMsg));
}

bool OperatorKernelGatherDequeue::DequeAndCheckIfReady(const GatherDequeParam * const batchDeqInfo, int32_t &gatherRet,
                                                       void *const modelPtr, const RunContext &taskContext,
                                                       bool &blockOnClientQ) const
{
    AicpuModel* const model = PtrToPtr<void, AicpuModel>(modelPtr);
    uint32_t * const queueIds = PtrToPtr<void, uint32_t>(ValueToPtr(batchDeqInfo->queueIdsAddr));
    uint32_t *const deviceTypes = PtrToPtr<void, uint32_t>(ValueToPtr(batchDeqInfo->deviceTypeAddr));
    uint32_t *const deviceIds = PtrToPtr<void, uint32_t>(ValueToPtr(batchDeqInfo->deviceIdAddr));
    DeployContext deployCtx = DeployContext::DEVICE;
    (void) GetAicpuDeployContext(deployCtx);
    uint64_t loopCnt = 0UL;
    while (true) {
        loopCnt++;
        const size_t queueIndex = model->GetCurDequeIndex(static_cast<size_t>(batchDeqInfo->inputNums));
        aicpusd_info("start [%llu]th dequeue queue[%zu]", loopCnt, queueIndex);
        Mbuf *mbuf = nullptr;
        // host cpusd with device queue, so the queue is clientQ
        if ((deployCtx != DeployContext::DEVICE) && (deviceTypes[queueIndex] == 0U)) {
            blockOnClientQ = true;
            BufEnQueueBuffInfo queueInfo = {
                queueIds[queueIndex], static_cast<int32_t>(deviceIds[queueIndex]), PtrToValue(&mbuf)};
            gatherRet = ModelAttachAndDequeueBuff(queueInfo, taskContext, true);
        } else {
            blockOnClientQ = false;
            BufEnQueueInfo queueInfo = { queueIds[queueIndex], PtrToValue(&mbuf) };
            gatherRet = DequeueTask(queueInfo, taskContext, false);
        }
        if ((gatherRet != static_cast<int32_t>(AICPU_SCHEDULE_OK)) || (mbuf == nullptr)) {
            aicpusd_warn("Failed to deque from queue[%u], gatherRet[%d].", queueIds[queueIndex], gatherRet);
            return false;
        }

        if (!StoreMbufIntoModel(mbuf, queueIndex, batchDeqInfo->inputNums, modelPtr)) {
            continue;
        }

        if (SelectMbuf(batchDeqInfo, taskContext, modelPtr, gatherRet)) {
            return true;
        }
    }
    return false;
}

bool OperatorKernelGatherDequeue::StoreMbufIntoModel(Mbuf *const mbuf, const size_t index, const uint32_t capacity,
                                                     void *const modelPtr) const
{
    AicpuModel* const model = PtrToPtr<void, AicpuModel>(modelPtr);
    const MbufHeadMsg * const headMsg = GetMbufHeadMsg(mbuf);
    if (headMsg == nullptr) {
        return false;
    }
    const auto result = model->StoreDequedMbuf(headMsg->transId, headMsg->dataLabel, index, mbuf, capacity);
    if (result == StoreResult::FAIL_STORE) {
        return false;
    }

    const auto guardRet = model->UnGardModelBuf(mbuf);
    if (guardRet != AICPU_SCHEDULE_OK) {
        aicpusd_warn("BufManager unguard mbuf failed, drvRet[%d].", guardRet);
    }
    return (result == StoreResult::SUCCESS_STORE);
}


REGISTER_OPERATOR_KERNEL(KERNEL_GATHER_DEQUEUE, OperatorKernelGatherDequeue);
}  // namespace AicpuSchedule