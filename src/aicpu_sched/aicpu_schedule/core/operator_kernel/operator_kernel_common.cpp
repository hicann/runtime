/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_common.h"

#include <cstring>
#include "aicpusd_msg_send.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_model_execute.h"


namespace AicpuSchedule {
int32_t OperatorKernelCommon::SendAICPUSubEvent(char_t * const msg, const uint32_t msgLen, const uint32_t subEventId)
{
    if (msg == nullptr) {
        aicpusd_err("The message is nullptr");
        return AICPU_SCHEDULE_ERROR_INVAILD_EVENT_SUBMIT;
    }

    if (msgLen == 0U) {
        aicpusd_err("The size of message is zero");
        return AICPU_SCHEDULE_ERROR_INVAILD_EVENT_SUBMIT;
    }
    event_summary eventInfoSummary = {};
    eventInfoSummary.pid = getpid();
    eventInfoSummary.event_id = EVENT_AICPU_MSG;
    eventInfoSummary.subevent_id = subEventId;
    eventInfoSummary.msg = msg;
    eventInfoSummary.msg_len = msgLen;

    const uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
    AicpuMsgSend::SetSchedSubmitEvent(deviceId, eventInfoSummary);
    return AICPU_SCHEDULE_OK;
}

void OperatorKernelCommon::TraceQueueData(const RunContext &taskContext, void * const headBuf, const uint32_t headSize,
                                          const char_t* const marker)
{
    MbufHeadMsg * const msg = GetHeadMsgForTrace(headBuf, static_cast<size_t>(headSize), marker);
    DoTraceQueueData(taskContext, msg, marker);
}

MbufHeadMsg *OperatorKernelCommon::GetHeadMsgForTrace(void * const headBuf, const size_t headSize,
    const char_t *const marker)
{
    if (&CheckLogLevel != nullptr) {
        if (CheckLogLevel(static_cast<int32_t>(CCECPU), DLOG_INFO) != 1) {
            return nullptr;
        }
    }

    if ((headBuf == nullptr) || (headSize < sizeof(MbufHeadMsg)) || (marker == nullptr)) {
        return nullptr;
    }

    MbufHeadMsg * const msg = PtrToPtr<uint8_t, MbufHeadMsg>(PtrAdd<uint8_t>(PtrToPtr<void, uint8_t>(headBuf),
        MBUF_HEAD_MAX_SIZE, headSize - sizeof(MbufHeadMsg)));
    return msg;
}

void OperatorKernelCommon::DoTraceQueueData(const RunContext &taskContext, const MbufHeadMsg *const msg,
    const char_t *const marker)
{
    if (msg == nullptr) {
        return;
    }
    if (std::strncmp("Dequeued", marker, DEQUEUED_SIZE) == 0) {
        const auto model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
        if (model == nullptr) {
            aicpusd_err("Cannot get model by modelId:[%u], streamId[%u], transId[%lu].", taskContext.modelId,
                        taskContext.streamId, msg->transId);
            return;
        }
        (void)model->SetModelTransId(msg->transId);
    }
    aicpusd_info("%s: transId[%lu], routeLabel[%u], retCode[%d], modelId[%u], streamId[%u]", marker, msg->transId,
        msg->routeLabel, msg->retCode, taskContext.modelId, taskContext.streamId);
}

std::shared_ptr<MbufHeadMsg> OperatorKernelCommon::BackupHeadMsg(void * const headBuf, const uint32_t headSize,
    const char_t* const marker)
{
    MbufHeadMsg * const msg = GetHeadMsgForTrace(headBuf, static_cast<size_t>(headSize), marker);
    if (msg == nullptr) {
        return nullptr;
    }
    std::shared_ptr<MbufHeadMsg> backupMsg(new (std::nothrow) MbufHeadMsg());
    AICPUSD_CHECK((backupMsg != nullptr), nullptr, "alloc backup headmsg failed.");

    const auto cpyRet = memcpy_s(backupMsg.get(), sizeof(MbufHeadMsg), msg, sizeof(MbufHeadMsg));
    if (cpyRet != EOK) {
        aicpusd_warn("Memcpy headmsg failed, cpyLen[%zu], ret=[%d].", sizeof(MbufHeadMsg), cpyRet);
        return nullptr;
    }
    return backupMsg;
}

int32_t OperatorKernelCommon::CopyMbufHeadInfo(const void * const srcHeaderBuf, const uint32_t srcHeadSize,
                                               Mbuf *destMbuf)
{
    if (srcHeaderBuf == nullptr) {
        aicpusd_err("malloc srcHeaderBuf is nullptr.");
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    if (destMbuf == nullptr) {
        aicpusd_err("malloc destMbuf is nullptr.");
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    void *destHeaderBuf = nullptr;
    uint32_t destHeadSize = 0U;
    const auto ret = halMbufGetPrivInfo(destMbuf, &destHeaderBuf, &destHeadSize);
    if (ret != DRV_ERROR_NONE) {
        aicpusd_err("Failed to get head info in dest information, ret[%d].", ret);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }
    if (destHeaderBuf == nullptr) {
        aicpusd_err("Failed to get head info from dest buffer.");
        return AICPU_SCHEDULE_ERROR_MALLOC_MEM_FAIL_THROUGH_DRV;
    }
    if (srcHeadSize != destHeadSize) {
        aicpusd_err("the src head size[%u] is not equal to the dest size[%u].", srcHeadSize, destHeadSize);
        return AICPU_SCHEDULE_ERROR_MALLOC_MEM_FAIL_THROUGH_DRV;
    }
    if (srcHeadSize == 0U) {
        aicpusd_err("Failed to get size.");
        return AICPU_SCHEDULE_ERROR_MALLOC_MEM_FAIL_THROUGH_DRV;
    }

    const errno_t eRet =
        memcpy_s(destHeaderBuf, static_cast<uint64_t>(destHeadSize), srcHeaderBuf, static_cast<uint64_t>(srcHeadSize));
    if (eRet != EOK) {
        aicpusd_err("Failed to memcpy, ret[%d].", eRet);
        return AICPU_SCHEDULE_ERROR_SAFE_FUNCTION_ERR;
    }
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelCommon::GetMbufDataPtr(const uint64_t srcAddr, void **dataAddrPtr)
{
    if (dataAddrPtr == nullptr) {
        aicpusd_err("Mbuf data ptr is null.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    const auto mbufPptr = reinterpret_cast<Mbuf **>(static_cast<uintptr_t>(srcAddr));
    if (mbufPptr == nullptr) {
        aicpusd_err("mbufPptr is null.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (*mbufPptr == nullptr) {
        aicpusd_err("*mbufPptr is null.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const auto ret = halMbufGetBuffAddr(*mbufPptr, dataAddrPtr);
    if (ret != DRV_ERROR_NONE) {
        aicpusd_err("Failed to get data ptr, ret[%d].", ret);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelCommon::UpdateDataPtr(const uint64_t mbufAddr, const int32_t fusionOffset,
                                            void *&dataPtr, uint64_t &totalOffset)
{
    uint64_t dataSize = 0UL;
    int32_t ret = OperatorKernelCommon::GetMbufDataSize(mbufAddr, dataSize);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Failed to get mbuf data size, ret = %d.", ret);
        return ret;
    }
    if (dataSize < sizeof(RuntimeTensorDesc)) {
        aicpusd_err("Mbuf data size[%lu] is invalid, must >= %zu.", dataSize, sizeof(RuntimeTensorDesc));
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    FusionInfo info = {};
    info.dataSize = dataSize;
    ret = OperatorKernelCommon::DoUpdateDataPtr(info, fusionOffset, dataPtr);
    if (ret == AICPU_SCHEDULE_OK) {
        totalOffset = info.lastDataOffset;
    }
    return ret;
}

int32_t OperatorKernelCommon::DoUpdateDataPtr(FusionInfo &info, const int32_t fusionOffset, void *&dataPtr)
{
    if (fusionOffset < info.lastFusionOffset) {
        aicpusd_err("Invalid fusionOffset[%d] vs lastFusionOffset[%d].", fusionOffset, info.lastFusionOffset);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    auto baseAddr = PtrToPtr<void, uint8_t>(dataPtr);
    uint64_t totalOffset = info.lastDataOffset;
    for (int32_t i = info.lastFusionOffset; i < fusionOffset; ++i) {
        if (totalOffset > info.dataSize - sizeof(RuntimeTensorDesc)) {
            aicpusd_err("Fusion size is invalid, must <= data size[%lu].", info.dataSize);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        auto tensorDesc = PtrToPtr<uint8_t, RuntimeTensorDesc>(baseAddr + totalOffset);
        totalOffset += sizeof(RuntimeTensorDesc);

        if (tensorDesc->dataSize > info.dataSize - totalOffset) {
            aicpusd_err("Tensor dataSize[%lu] is invalid, must <= mbuf dataSize[%lu] - offset[%lu].",
                tensorDesc->dataSize, info.dataSize, totalOffset);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        totalOffset += tensorDesc->dataSize;
    }
    aicpusd_info("Fusion offset index = %d, total offset byte size = %lu.", fusionOffset, totalOffset);
    if (totalOffset > info.dataSize - sizeof(RuntimeTensorDesc)) {
        aicpusd_err("Fusion offset[%lu] is invalid, must <= data size[%u] - %zu.",
            totalOffset, info.dataSize, sizeof(RuntimeTensorDesc));
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    dataPtr = PtrToPtr<uint8_t, void>(baseAddr + totalOffset);
    info.lastFusionOffset = fusionOffset;
    info.lastDataOffset = totalOffset;
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelCommon::GetMbufDataSize(const uint64_t srcAddr, uint64_t &dataSize)
{
    const auto mbufPptr = reinterpret_cast<Mbuf **>(static_cast<uintptr_t>(srcAddr));
    if (mbufPptr == nullptr) {
        aicpusd_err("mbufPptr is null.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    if (*mbufPptr == nullptr) {
        aicpusd_err("*mbufPptr is null.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const auto ret = halMbufGetBuffSize(*mbufPptr, &dataSize);
    if (ret != DRV_ERROR_NONE) {
        aicpusd_err("Failed to get data size, ret[%d].", ret);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelCommon::ParseTensorDescAndCalcDataSize(const RuntimeTensorDesc * const srcTensorDesc,
                                                             uint32_t &dataSize)
{
    if (srcTensorDesc->shape[0] > MAX_DIM_SIZE) {
        aicpusd_err("Max shape size[%lld], but got shape size[%lld]", MAX_DIM_SIZE, srcTensorDesc->shape[0]);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    int64_t size = 0;
    const int32_t ret = AicpuUtil::CalcDataSizeByShape(&(srcTensorDesc->shape[1]), srcTensorDesc->shape[0],
        srcTensorDesc->dtype, size);
    if ((ret != AICPU_SCHEDULE_OK) || (size < 0) || (size > static_cast<int64_t>(UINT32_MAX))) {
        aicpusd_err("Get data size by shape failed, ret[%d], size[%lld]", ret, size);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    dataSize = static_cast<uint32_t>(size);
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelCommon::GetMbufAddrAndSize(Mbuf *mbuf, void **dataPptr, uint64_t *dataLenPtr, uint32_t modelId,
                                                 bool allowOnlyDesc)
{
    if (mbuf == nullptr) {
        aicpusd_err("null mbuf for model[%u]", modelId);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    const uint64_t dataLenThreshold = allowOnlyDesc ? sizeof(RuntimeTensorDesc) : sizeof(RuntimeTensorDesc) + 1U;
    auto ret = halMbufGetBuffSize(mbuf, dataLenPtr);
    if ((ret != static_cast<int32_t>(DRV_ERROR_NONE)) || (*dataLenPtr < dataLenThreshold)) {
        aicpusd_err("Fail to get buff size for mbuf, model:[%u], ret=[%d], dataLen[%u] vs dataLenThreshold[%u]",
                    modelId, ret, *dataLenPtr, dataLenThreshold);
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }

    ret = halMbufGetBuffAddr(mbuf, dataPptr);
    if ((ret != static_cast<int32_t>(DRV_ERROR_NONE)) || (*dataPptr == nullptr)) {
        aicpusd_err("Failed to get data or data is nullptr, ret[%d].", ret);
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }

    return AICPU_SCHEDULE_OK;
}

}  // namespace AicpuSchedule