/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_info.hpp"
#include "device.hpp"
#include "stream.hpp"
#include "arg_manage_david.hpp"

namespace cce {
namespace runtime {

bool DavidArgManage::CreateArgRes()
{
    Device * const dev = stream_->Device_();
    void *devAddr = nullptr;
    void *hostAddr = nullptr;
    const uint64_t size = DAVID_ARG_POOL_SQ_SIZE * Runtime::macroValue_.rtsqDepth;
    argPoolSize_ = static_cast<uint32_t>(size & UINT32_MAX);

    dev->ArgStreamMutexLock();
    const uint8_t argStreamNum = dev->GetArgStreamNum();
    if (argStreamNum >= DAVID_ARG_STREAM_NUM_MAX) {
        dev->ArgStreamMutexUnLock();
        RT_LOG(RT_LOG_WARNING, "argStreamNum=%hhu is over %hhu.", argStreamNum, DAVID_ARG_STREAM_NUM_MAX);
        return false;
    }

    const rtError_t ret = MallocArgMem(devAddr, hostAddr);
    if (ret != RT_ERROR_NONE) {
        dev->ArgStreamMutexUnLock();
        return false;
    }

    dev->SetArgStreamNum(argStreamNum + 1U);
    dev->ArgStreamMutexUnLock();

    devArgResBaseAddr_ = devAddr;
    hostArgResBaseAddr_ = hostAddr;

    RT_LOG(RT_LOG_DEBUG, "Malloc args stm pool mem success, size=%u, device_id=%u.", argPoolSize_, dev->Id_());
    return true;
}

void DavidArgManage::ReleaseArgRes()
{
    if (devArgResBaseAddr_ != nullptr) {
        FreeArgMem();
        Device * const dev = stream_->Device_();
        RT_LOG(RT_LOG_DEBUG, "Release args stm pool mem, stream_id=%d, device_id=%u.", stream_->Id_(), dev->Id_());
        devArgResBaseAddr_ = nullptr;
        hostArgResBaseAddr_ = nullptr;
        dev->ArgStreamMutexLock();
        uint8_t argStreamNum = dev->GetArgStreamNum();
        if (argStreamNum > 0U) {
            argStreamNum = argStreamNum - 1U;
        }
        dev->SetArgStreamNum(argStreamNum);
        dev->ArgStreamMutexUnLock();
    }
}

bool DavidArgManage::RecycleStmArgPos(const uint32_t taskId, const uint32_t stmArgPos)
{
    if ((stmArgPos == UINT32_MAX) || (devArgResBaseAddr_ == nullptr)) {
        return true;
    }
    const uint32_t devId = stream_->Device_()->Id_();
    const int32_t stmId = stream_->Id_();

    stmArgHeadMutex_.lock();
    const uint32_t head = stmArgHead_.Value();
    const uint32_t tail = stmArgTail_.Value();
    // valid argsPos(tail after alloc) in following cases
    const bool flag1 = (head < tail) && (stmArgPos > head) && (stmArgPos <= tail);
    const bool flag2 = (head > tail) && ((stmArgPos <= tail) || ((stmArgPos > head) && (stmArgPos < argPoolSize_)));
    if (!flag1 && !flag2) {
        stmArgHeadMutex_.unlock();
        RT_LOG(RT_LOG_DEBUG, "stmArgPos is invalid, device_id=%u, stream_id=%d, task_id=%u, stmArgPos=%u, "
            "stmArgHead_=%u, stmArgTail_=%u", devId, stmId, taskId, stmArgPos, head, tail);
        return false;
    }

    stmArgHead_.Set(stmArgPos);
    RT_LOG(RT_LOG_DEBUG, "Recycle args stm pool mem success, device_id=%u, stream_id=%d, task_id=%u, stmArgPos=%u, "
        "stmArgHead_=%u, stmArgTail_=%u", devId, stmId, taskId, stmArgPos, stmArgHead_.Value(), stmArgTail_.Value());

    stmArgHeadMutex_.unlock();
    return true;
}

bool DavidArgManage::AllocStmArgPos(const uint32_t argsSize, uint32_t &startPos, uint32_t &endPos)
{
    const uint32_t devId = stream_->Device_()->Id_();
    const int32_t stmId = stream_->Id_();
    stmArgTailMutex_.lock();
    const uint32_t head = stmArgHead_.Value();
    uint32_t tail = stmArgTail_.Value();
    const uint32_t alignArgSize = (argsSize + DAVID_ARG_ADDR_ALIGN_LEN - 1U) & (~(DAVID_ARG_ADDR_ALIGN_LEN - 1U));
    // support alloc in following cases, avoid tail==head when full
    const bool flag1 = (head <= tail) && ((tail + alignArgSize) < argPoolSize_);
    const bool flag2 = (head <= tail) && (alignArgSize < head);
    const bool flag3 = (head > tail) && ((tail + alignArgSize) < head);
    if (!flag1 && !flag2 && !flag3) {
        stmArgTailMutex_.unlock();
        RT_LOG(RT_LOG_DEBUG, "Alloc args stm pool mem failed, size=%u, alignSize=%u, "
            "stream_id=%d, device_id=%u, stmArgHead_=%u, stmArgTail_=%u",
            argsSize, alignArgSize, stmId, devId, head, tail);
        return false;
    }

    if (!flag1 && flag2) {
        tail = 0U;
    }
    startPos = tail;
    tail += alignArgSize;

    stmArgTail_.Set(tail);
    stmArgTailMutex_.unlock();
    endPos = tail;

    RT_LOG(RT_LOG_DEBUG, "Alloc args stm pool mem success, size=%u, alignSize=%u, "
        "stream_id=%d, device_id=%u, stmArgHead_=%u, stmArgTail_=%u",
        argsSize, alignArgSize, stmId, devId, stmArgHead_.Value(), stmArgTail_.Value());
    return true;
}

void DavidArgManage::FreeFail(DavidArgLoaderResult * const result)
{
    if (result->handle != nullptr) {
        RecycleDevLoader(result->handle);
    }
    result->kerArgs = nullptr;
    result->hostAddr = nullptr;
    result->handle = nullptr;
    result->stmArgPos = UINT32_MAX;
}

void DavidArgManage::UpdateAddrField(const void * const kerArgs,
                                     void * const argsHostAddr,
                                     const uint16_t hostInputInfoNum,
                                     const rtHostInputInfo * const hostInputInfoPtr)
{
    uint32_t addrOffset = 0U;
    uint32_t dataOffset = 0U;
    for (uint16_t i = 0U; i < hostInputInfoNum; i++) {
        // set host mem data offset to host mem addr
        addrOffset = hostInputInfoPtr[i].addrOffset;
        dataOffset = hostInputInfoPtr[i].dataOffset;
        *(RtPtrToPtr<uint64_t *, char_t *>(RtPtrToPtr<char_t *, void *>(argsHostAddr) + addrOffset)) =
            RtPtrToValue<const void *>(kerArgs) + dataOffset;
    }
}

rtError_t DavidArgManage::LoadInputOutputArgs(const DavidArgLoaderResult * const result, const rtArgsEx_t * const argsInfo)
{
    if (argsInfo->hasTiling != 0U) {
        // set tiling data offset to tiling addr
        *(RtPtrToPtr<uint64_t *, char_t *>(RtPtrToPtr<char_t *, void *>(argsInfo->args) + argsInfo->tilingAddrOffset)) =
            RtPtrToValue<const void *>(result->kerArgs) + argsInfo->tilingDataOffset;
    }
    UpdateAddrField(result->kerArgs, argsInfo->args, argsInfo->hostInputInfoNum, argsInfo->hostInputInfoPtr);
    return H2DArgCopy(result, argsInfo->args, argsInfo->argsSize);
}

rtError_t DavidArgManage::LoadInputOutputArgs(const DavidArgLoaderResult * const result,
                                              const rtAicpuArgsEx_t * const argsInfo)
{
    UpdateAddrField(result->kerArgs, argsInfo->args, argsInfo->hostInputInfoNum, argsInfo->hostInputInfoPtr);
    UpdateAddrField(result->kerArgs, argsInfo->args, argsInfo->kernelOffsetInfoNum, argsInfo->kernelOffsetInfoPtr);
    return H2DArgCopy(result, argsInfo->args, argsInfo->argsSize);
}

rtError_t DavidArgManage::LoadInputOutputArgs(const DavidArgLoaderResult * const result,
                                              const rtFusionArgsEx_t * const argsInfo)
{
    UpdateAddrField(result->kerArgs, argsInfo->args, argsInfo->hostInputInfoNum, argsInfo->hostInputInfoPtr);
    return H2DArgCopy(result, argsInfo->args, argsInfo->argsSize);
}

uint32_t DavidArgManage::GetStmArgPos()
{
    if (devArgResBaseAddr_ == nullptr) {
        return UINT32_MAX;
    }
    stmArgTailMutex_.lock();
    const uint32_t tail = stmArgTail_.Value();
    stmArgTailMutex_.unlock();
    return tail;
}

}
}