/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime.hpp"
#include "thread_local_container.hpp"
#include "error_message_manage.hpp"
#include "arg_loader.hpp"
#include "task_res.hpp"

namespace cce {
namespace runtime {

TaskResManage::~TaskResManage()
{
}

void TaskResManage::UpdateAddrField(const void * const kerArgs,
                                    void * const argsHostAddr,
                                    const uint16_t hostInputInfoNum,
                                    const rtHostInputInfo * const hostInputInfoPtr) const
{
    uint32_t addrOffset = 0U;
    uint32_t dataOffset = 0U;
    for (uint16_t i = 0U; i < hostInputInfoNum; i++) {
        // set host mem data offset to host mem addr
        addrOffset = hostInputInfoPtr[i].addrOffset;
        dataOffset = hostInputInfoPtr[i].dataOffset;
        *(RtPtrToPtr<uint64_t *>(RtPtrToPtr<char_t *>(argsHostAddr) + addrOffset)) =
            static_cast<uint64_t>(RtPtrToPtr<uintptr_t>(kerArgs) + dataOffset);
    }
}
TIMESTAMP_EXTERN(TaskResManage_LoadInputOutputArgs);
rtError_t TaskResManage::LoadInputOutputArgs(const Stream * const stm, void *&kerArgs, uint32_t taskResId,
    const uint32_t size, const void * const args, const rtArgsEx_t * const argsInfo) const
{
    if ((stm->NonSupportModelCompile()) || (stm->Model_() == nullptr) || (argsInfo->isNoNeedH2DCopy == 0U)) {
        kerArgs = taskRes_[taskResId].copyDev;

        if (argsInfo->hasTiling != 0U) { // set tiling data offset to tiling addr
            *(reinterpret_cast<uint64_t *>(reinterpret_cast<char_t *>(argsInfo->args) + argsInfo->tilingAddrOffset)) =
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(kerArgs) + argsInfo->tilingDataOffset);
        }
        UpdateAddrField(kerArgs, argsInfo->args, argsInfo->hostInputInfoNum, argsInfo->hostInputInfoPtr);

        TIMESTAMP_BEGIN(TaskResManage_LoadInputOutputArgs);
        const errno_t ret = memcpy_s(kerArgs, size, args, size);
        TIMESTAMP_END(TaskResManage_LoadInputOutputArgs);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret != EOK, RT_ERROR_DRV_MEMORY,
            "Pcie bar memcpy failed, kind=%d, ret=%#x.", RT_MEMCPY_HOST_TO_DEVICE, static_cast<uint32_t>(ret));
    }
    return RT_ERROR_NONE;
}

rtError_t TaskResManage::LoadInputOutputArgs(const Stream * const stm, void *&kerArgs, uint32_t taskResId,
    const uint32_t size, const void * const args, const rtAicpuArgsEx_t * const argsInfo) const
{
    if ((stm->NonSupportModelCompile()) || (stm->Model_() == nullptr) || (argsInfo->isNoNeedH2DCopy == 0U)) {
        kerArgs = taskRes_[taskResId].copyDev;

        UpdateAddrField(kerArgs, argsInfo->args, argsInfo->hostInputInfoNum, argsInfo->hostInputInfoPtr);
        UpdateAddrField(kerArgs, argsInfo->args, argsInfo->kernelOffsetInfoNum, argsInfo->kernelOffsetInfoPtr);

        TIMESTAMP_BEGIN(TaskResManage_LoadInputOutputArgs);
        const errno_t ret = memcpy_s(kerArgs, size, args, size);
        TIMESTAMP_END(TaskResManage_LoadInputOutputArgs);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret != EOK, RT_ERROR_DRV_MEMORY,
            "Pcie bar memcpy failed, kind=%d, ret=%#x.", RT_MEMCPY_HOST_TO_DEVICE, static_cast<uint32_t>(ret));
    }

    return RT_ERROR_NONE;
}

void TaskResManage::SetResult(void * const kerArgs, struct ArgLoaderResult * const result) const
{
    result->handle = nullptr;
    result->kerArgs = kerArgs;
    result->smArgs = nullptr;
}

TaskResManage::TaskResManage()
{
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    taskPoolNum_ = GetTaskPoolSizeByChipType(chipType);
}

void TaskResManage::FreePcieBarBuffer(void *addr, Device* para) const
{
    if (addr != nullptr) {
        Device * const dev = para;
        (void)dev->Driver_()->PcieHostUnRegister(addr, dev->Id_());
        (void)dev->Driver_()->DevMemFree(addr, dev->Id_());
        dev->ArgStreamMutexLock();
        const uint8_t argStreamNum = dev->GetArgStreamNum();
        if (argStreamNum > 0U) {
            dev->SetArgStreamNum(argStreamNum - 1U);
        }
        dev->ArgStreamMutexUnLock();
    }
}

rtError_t TaskResManage::RePcieHostRegister(const Stream *const stm) const 
{
    if (pcieBaseAddr_ == nullptr) {
        RT_LOG(RT_LOG_WARNING, "dev not support pcie bar copy.");
        return RT_ERROR_NONE;
    }
    Device *dev = stm->Device_();
    const uint64_t size = taskPoolNum_ * RTS_LITE_PCIE_BAR_COPY_SIZE;
    void *outAddr = nullptr;
    const rtError_t ret = dev->Driver_()->PcieHostRegister(pcieBaseAddr_, size, dev->Id_(), outAddr);
    ERROR_RETURN_MSG_INNER(ret, "Pcie Host Register failed, size=%lu, dev_id=%u, ret=%d.", size, dev->Id_(), ret);
    return RT_ERROR_NONE;
}

void* TaskResManage::MallocPcieBarBuffer(const uint32_t size, Device* const dev, bool isLogError) const
{
    void *addr = nullptr;
    void *outAddr = nullptr;
    uint32_t val = RT_CAPABILITY_NOT_SUPPORT;
    bool is4KAsync = (size > HUGE_PAGE_MEM_CRITICAL_VALUE) ? false : true;
    (void)dev->Driver_()->CheckSupportPcieBarCopy(dev->Id_(), val, is4KAsync);
    if (val != RT_CAPABILITY_SUPPORT) {
        RT_LOG(RT_LOG_WARNING, "dev not support pcie bar copy, device_id=%d, val=%u.", dev->Id_(), val);
        return nullptr;
    }
    rtError_t ret = dev->Driver_()->DevMemAlloc(&addr, static_cast<uint64_t>(size),
                                                RT_MEMORY_P2P_HBM, dev->Id_(), MODULEID_RUNTIME, isLogError);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "alloc dev mem failed, retCode=%#x, size=%u, dev_id=%u.", ret, size, dev->Id_());
        return nullptr;
    }
    ret = dev->Driver_()->PcieHostRegister(addr, static_cast<uint64_t>(size), dev->Id_(), outAddr);
    if (ret != RT_ERROR_NONE) {
        (void)dev->Driver_()->DevMemFree(addr, dev->Id_());
        RT_LOG(RT_LOG_ERROR, "Pcie Host Register failed, retCode=%#x, size=%u, dev_id=%u.", ret, size, dev->Id_());
        return nullptr;
    }
    return addr;
}

bool TaskResManage::CreateTaskRes(Stream* stm)
{
    Device* dev = stm->Device_();
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    const bool isOffline = (dev->Driver_()->GetRunMode() == RT_RUN_MODE_OFFLINE);
    const auto supportCreateTaskRes = dev->GetDevProperties().supportCreateTaskRes;
    if ((supportCreateTaskRes == SupportCreateTaskRes::CREATE_TASK_RES_NOT_SUPPORT) || 
        (isOffline && (supportCreateTaskRes != SupportCreateTaskRes::CREATE_TASK_RES_SUPPORT_WITH_OFFLINE)) || 
        (!Runtime::Instance()->GetDisableThread())) {
        RT_LOG(RT_LOG_WARNING, "does not support, chipType=%u, isOffline=%u.", chipType, isOffline);
        return false;
    }

    uint32_t taskResCellSize = static_cast<uint32_t>(sizeof(TaskRes));
    if ((taskResCellSize & (RTS_BUFF_ASSING_NUM - 1U)) > 0) {
        taskResCellSize += RTS_BUFF_ASSING_NUM;
        taskResCellSize &= (~(RTS_BUFF_ASSING_NUM - 1U));
    }
    const uint32_t taskPoolSize = taskPoolNum_ * taskResCellSize;
    taskResBaseAddr_ = new (std::nothrow) uint8_t[taskPoolSize];
    COND_RETURN_WARN((taskResBaseAddr_ == nullptr), false, "no memory for taskRes,"
        "taskResSize=%u, taskPoolNum_=%u.", taskResCellSize, taskPoolNum_);

    streamId_ = stm->Id_();
    deviceId_ = stm->Device_()->Id_();
    taskRes_ = (TaskRes*)taskResBaseAddr_;
    RT_LOG(RT_LOG_DEBUG, "TaskInfo Buffer alloc success.");

    if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_KERNEL_ARGS_FROM_STREAM_POOL)) {
        return true;
    }

    if ((stm->Flags() & RT_STREAM_FAST_LAUNCH) == 0U) {
        RT_LOG(RT_LOG_INFO, "stream_id=%d, flags_=0x%x create task res success.", streamId_, stm->Flags());
        return true;
    }

    dev->ArgStreamMutexLock();
    const uint8_t argStreamNum = dev->GetArgStreamNum();
    if (argStreamNum >= RTS_PCIE_STREAM_NUM_MAX) {
        dev->ArgStreamMutexUnLock();
        RT_LOG(RT_LOG_WARNING, "pcieStreamNum=%hhu is over %u.", argStreamNum, RTS_PCIE_STREAM_NUM_MAX);
        return true;
    }

    // 4. pcieBar
    const uint32_t taskNum = (!dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_NUM_DOT_EXPAND)) ? 
        taskPoolNum_ : (taskPoolNum_ + 1);
    const uint32_t pciePoolSize = taskNum * RTS_LITE_PCIE_BAR_COPY_SIZE;
    pcieBaseAddr_ = RtPtrToPtr<uint8_t*, void *>(MallocPcieBarBuffer(pciePoolSize, dev, false));
    if (pcieBaseAddr_ == nullptr) {
        dev->ArgStreamMutexUnLock();
        RT_LOG(RT_LOG_WARNING, "no pciebar for taskRes.");
        return true;
    }
    dev->SetArgStreamNum(argStreamNum + 1U);
    dev->ArgStreamMutexUnLock();

    for (uint32_t i = 0U; i < taskPoolNum_; i++) {
        taskRes_[i].copyDev = static_cast<void *>(pcieBaseAddr_ + (i * RTS_LITE_PCIE_BAR_COPY_SIZE));
    }
    stm->SetIsHasPcieBarFlag(true);
    RT_LOG(RT_LOG_DEBUG, "pciebar Buffer alloc success.");

    return true;
}

void TaskResManage::ReleaseTaskResource(Stream* stm)
{
    stm->SetIsHasPcieBarFlag(false);
    Device* dev = stm->Device_();
    FreePcieBarBuffer(pcieBaseAddr_, dev);
    if (taskRes_ != nullptr) {
        delete[] taskResBaseAddr_;
        taskResBaseAddr_ = nullptr;
        taskRes_ =  nullptr;
    }
}

void TaskResManage::ResetTaskRes()
{
    taskResHead_ = 0U;
    taskResTail_ = 0U;
}

uint16_t TaskResManage::GetTaskPoolSizeByChipType(const rtChipType_t chipType) const
{
    DevProperties prop;
    rtError_t ret = GET_DEV_PROPERTIES(chipType, prop);
    if (ret != RT_ERROR_NONE) { 
        RT_LOG(RT_LOG_ERROR, "GetDevProperties failed, error code=%u.", ret);
        return 0U;
    }
    if (prop.taskPoolSizeFromMacroValue) {
        return Runtime::macroValue_.rtsqDepth;
    }
    return prop.taskPoolSize;
}

bool TaskResManage::AllocTaskResId(uint32_t &taskResId)
{
    taskTailMutex_.lock();
    uint32_t head = taskResHead_;
    if ((taskResTail_ + 1U) % taskPoolNum_ == head) {
        taskResId = RTS_INVALID_RES_ID;
        taskTailMutex_.unlock();
        return false;
    }
    taskResId = taskResTail_;
    taskResTail_ = (taskResTail_ + 1U) % taskPoolNum_;
    RT_LOG(RT_LOG_INFO, "Alloc taskResTail_=%u, taskResHead_=%u, taskResId=%u.", taskResTail_, head, taskResId);
    taskTailMutex_.unlock();
    return true;
}

TaskInfo* TaskResManage::GetTaskInfo(uint32_t taskId) const
{
    __sync_synchronize();
    const uint16_t head = taskResHead_;
    const uint16_t tail = taskResTail_;
    uint32_t taskResId = taskId % taskPoolNum_;
    if (head == tail) {
        RT_LOG(RT_LOG_WARNING, "head==tail, device_id=%u, stream_id=%d, taskId=%u, taskResId=%u, head=%hu, tail=%hu, "
            "taskResHead_=%hu, taskResTail_=%hu, taskInfo_id=%hu.",
            deviceId_, streamId_, taskId, taskResId, head, tail, taskResHead_, taskResTail_,
            taskRes_[taskResId].taskInfo.id);
        return nullptr;
    }

    const bool flag1 = (head < tail) && (!((taskResId >= head) && (taskResId < tail)));
    const bool flag2 = (head > tail) && ((taskResId >= tail) && (taskResId < head));
    if (flag1 || flag2) {
        RT_LOG(RT_LOG_WARNING, "taskResId is invalid, device_id=%u, stream_id=%d, taskId=%u, taskResId=%u, "
            "head=%hu, tail=%hu, taskResHead_=%hu, taskResTail_=%hu, taskInfo_id=%hu, isValidInO1=%hhu.",
            deviceId_, streamId_, taskId, taskResId, head, tail, taskResHead_, taskResTail_,
            taskRes_[taskResId].taskInfo.id, taskRes_[taskResId].taskInfo.isValidInO1);
        return nullptr;
    }

    if ((taskRes_[taskResId].taskInfo.id == 0xFFFFU) || (taskRes_[taskResId].taskInfo.id != taskId)) {
        RT_LOG(RT_LOG_WARNING, "taskResId is recycled, device_id=%u, stream_id=%d, taskId=%u, taskResId=%u, "
            "head=%hu, tail=%hu, taskResHead_=%hu, taskResTail_=%hu, taskInfo_id=%hu",
            deviceId_, streamId_, taskId, taskResId, head, tail, taskResHead_, taskResTail_,
            taskRes_[taskResId].taskInfo.id);
        return nullptr;
    }

    return &taskRes_[taskResId].taskInfo;
}
TaskInfo* TaskResManage::GetHeadTaskInfo() const
{
    return &taskRes_[taskResHead_].taskInfo;
}

void TaskResManage::RecycleResHead()
{
    taskRes_[taskResHead_].taskInfo.id = static_cast<uint16_t>(MAX_UINT16_NUM);
    taskResHead_ = (taskResHead_ + 1U) % taskPoolNum_;
}

uint16_t TaskResManage::GetResHead() const
{
    return taskResHead_;
}

bool TaskResManage::RecycleTaskInfoOn(uint32_t taskId)
{
    const uint32_t taskDesHeadIdx = taskId % taskPoolNum_;

    taskHeadMutex_.lock();
    uint32_t tail = taskResTail_;
    bool flag1 = (taskResHead_ < tail) && (!((taskDesHeadIdx >= taskResHead_) && (taskDesHeadIdx < tail)));
    bool flag2 = (taskResHead_ > tail) && ((taskDesHeadIdx >= tail) && (taskDesHeadIdx < taskResHead_));
    if (flag1 || flag2) {
        RT_LOG(RT_LOG_WARNING, "taskDesHeadIdx is invalid, device_id=%u, stream_id=%u, taskId=%u, taskDesHeadIdx=%u, "
            "taskResHead_=%u, taskResTail_=%u", deviceId_, streamId_, taskId, taskDesHeadIdx, taskResHead_, tail);
        taskHeadMutex_.unlock();
        return false;
    }

    taskResHead_ = (taskDesHeadIdx + 1) % taskPoolNum_;
    RT_LOG(RT_LOG_INFO, "recycleOn taskinfo success, taskId=%u, taskResHead_=%u, tail=%u.", taskId,
        taskResHead_, tail);
    taskHeadMutex_.unlock();
    return true;
}

bool TaskResManage::RecycleTaskInfoO1(uint32_t taskId)
{
    const uint32_t taskDesHeadIdx = taskId % taskPoolNum_;

    taskHeadMutex_.lock();
    __sync_synchronize();
    const uint32_t tail = taskResTail_;
    const bool flag1 = (taskResHead_ < tail) && (!((taskDesHeadIdx >= taskResHead_) && (taskDesHeadIdx < tail)));
    const bool flag2 = (taskResHead_ > tail) && ((taskDesHeadIdx >= tail) && (taskDesHeadIdx < taskResHead_));
    if (flag1 || flag2) {
        RT_LOG(RT_LOG_WARNING, "taskDesHeadIdx is invalid, device_id=%u, stream_id=%d, taskId=%u, taskDesHeadIdx=%u, "
            "taskResHead_=%u, tail=%u, taskResTail_=%u",
            deviceId_, streamId_, taskId, taskDesHeadIdx, taskResHead_, tail, taskResTail_);
        taskHeadMutex_.unlock();
        return false;
    }

    if (taskId == taskRes_[taskDesHeadIdx].taskInfo.id) {
        taskRes_[taskDesHeadIdx].taskInfo.id = 0xFFFFU;
        taskRes_[taskDesHeadIdx].taskInfo.isValidInO1 = true;
    } else {
        RT_LOG(RT_LOG_WARNING, "taskDesHeadIdx is already recycle, device_id=%u, stream_id=%d, taskId=%u, "
            "taskDesHeadIdx=%u, taskResHead_=%u, tail=%u, taskResTail_=%u, resTaskId=%hu",
            deviceId_, streamId_, taskId, taskDesHeadIdx, taskResHead_, tail, taskResTail_,
            taskRes_[taskDesHeadIdx].taskInfo.id);
    }

    __sync_synchronize();
    while (taskResHead_ != tail) {
        if (taskRes_[taskResHead_].taskInfo.isValidInO1 != true) {
            break;
        }
        taskResHead_ = (taskResHead_ + 1U) % taskPoolNum_;
    }

    RT_LOG(RT_LOG_INFO, "recycleO1 taskinfo success, device_id=%u, stream_id=%d, taskId=%u, taskDesHeadIdx=%u, "
        "taskResHead_=%u, tail=%u, taskResTail_=%u",
        deviceId_, streamId_, taskId, taskDesHeadIdx, taskResHead_, tail, taskResTail_);

    taskHeadMutex_.unlock();
    return true;
}

TaskInfo* TaskResManage::AllocTaskInfoByTaskResId(Stream *stm, uint32_t taskResId,
                                                  uint16_t taskId, tsTaskType_t taskType)
{
    // 1. check tail Invalid：head <= tail amd head > tail
    taskTailMutex_.lock();
    uint32_t head = taskResHead_;
    uint32_t tail = taskResTail_;
    if ((taskResTail_ + 1U) % taskPoolNum_ == head) {
        taskTailMutex_.unlock();
        RT_LOG(RT_LOG_DEBUG, "taskRes Queue full, taskResId=%u, head=%u, taskResTail_=%u.",
               taskResId, head, taskResTail_);
        return nullptr;
    }

    bool flag1 = (head < taskResTail_) && ((taskResId >= head) && (taskResId < taskResTail_));
    bool flag2 = (head > taskResTail_) && (!((taskResId >= taskResTail_) && (taskResId < head)));
    if (flag1 || flag2) {
        RT_LOG(RT_LOG_WARNING, "taskResId is invalid, device_id=%u, stream_id=%u, taskResId=%u, head=%u, "
            "taskResHead_=%hu, taskResTail_=%hu", deviceId_, streamId_, taskResId, head, taskResHead_, taskResTail_);
        taskTailMutex_.unlock();
        return nullptr;
    }

    TaskInfo *task = nullptr;
    while (taskResId != tail) {
        if ((taskResId + 1U) % taskPoolNum_ == head) {
            taskTailMutex_.unlock();
            RT_LOG(RT_LOG_DEBUG, "taskRes Queue full 2, taskResId=%u, head=%u, tail=%u.",
                taskResId, head, tail);
            return nullptr;
        }

        task = &taskRes_[tail].taskInfo;
        task->id = 0xFFFFU;
        task->isValidInO1 = true;
        tail = (tail + 1U) % taskPoolNum_;
        RT_LOG(RT_LOG_DEBUG, "taskResId is not equal taskResTail_, taskResId=%u, taskResTail_=%u",
            taskResId, taskResTail_);
    }

    task = &taskRes_[taskResId].taskInfo;
    (void)memset_s(task, sizeof(TaskInfo), 0, sizeof(TaskInfo));
    task->type = taskType;
    InitByStream(task, stm);
    task->id = taskId;
    UpdateFlipNum(task, false);

    __sync_synchronize();
    taskResTail_ = (taskResId + 1U) % taskPoolNum_;
    __sync_synchronize();
    taskTailMutex_.unlock();
    RT_LOG(RT_LOG_DEBUG, "alloc taskinfo success, device_id=%u, stream_id=%u, taskResId=%u, taskResHead_=%u, "
        "taskResTail_=%u, taskPoolNum_=%u.",
        deviceId_, streamId_, taskResId, taskResHead_, taskResTail_, taskPoolNum_);

    return task;
}

void TaskResManage::ShowDfxInfo(void) const
{
    RT_LOG(RT_LOG_EVENT, "task res info, taskResHead=%hu, taskResTail=%hu", taskResHead_, taskResTail_);
    
    if (taskPoolNum_ == 0U) {
        return;
    }

    const uint32_t headStart = (taskResHead_ + taskPoolNum_ - 5U) % taskPoolNum_;
    const uint32_t tailStart = (taskResTail_ + taskPoolNum_ - 5U) % taskPoolNum_;
    uint32_t headIndex[SHOW_DFX_INFO_TASK_NUM] = {0};
    uint32_t tailIndex[SHOW_DFX_INFO_TASK_NUM] = {0};

    for (uint32_t index = 0; index <= 5U; index++) {
        headIndex[index] = (headStart + index) % taskPoolNum_;
    }
    RT_LOG(RT_LOG_EVENT, "task head info, headStart=%u, taskId:isValid %hu:%d, %hu:%d, %hu:%d, %hu:%d, %hu:%d, %hu:%d",
        headStart, taskRes_[headIndex[0U]].taskInfo.id, taskRes_[headIndex[0U]].taskInfo.isValidInO1,
        taskRes_[headIndex[1U]].taskInfo.id, taskRes_[headIndex[1U]].taskInfo.isValidInO1,
        taskRes_[headIndex[2U]].taskInfo.id, taskRes_[headIndex[2U]].taskInfo.isValidInO1,
        taskRes_[headIndex[3U]].taskInfo.id, taskRes_[headIndex[3U]].taskInfo.isValidInO1,
        taskRes_[headIndex[4U]].taskInfo.id, taskRes_[headIndex[4U]].taskInfo.isValidInO1,
        taskRes_[headIndex[5U]].taskInfo.id, taskRes_[headIndex[5U]].taskInfo.isValidInO1);

    for (uint32_t index = 0; index <= 5U; index++) {
        tailIndex[index] = (tailStart + index) % taskPoolNum_;
    }
    RT_LOG(RT_LOG_EVENT, "task tail info, tailStart=%u, taskId:isValid %hu:%d, %hu:%d, %hu:%d, %hu:%d, %hu:%d, %hu:%d",
        tailStart, taskRes_[tailIndex[0U]].taskInfo.id, taskRes_[tailIndex[0U]].taskInfo.isValidInO1,
        taskRes_[tailIndex[1U]].taskInfo.id, taskRes_[tailIndex[1U]].taskInfo.isValidInO1,
        taskRes_[tailIndex[2U]].taskInfo.id, taskRes_[tailIndex[2U]].taskInfo.isValidInO1,
        taskRes_[tailIndex[3U]].taskInfo.id, taskRes_[tailIndex[3U]].taskInfo.isValidInO1,
        taskRes_[tailIndex[4U]].taskInfo.id, taskRes_[tailIndex[4U]].taskInfo.isValidInO1,
        taskRes_[tailIndex[5U]].taskInfo.id, taskRes_[tailIndex[5U]].taskInfo.isValidInO1);
}
}  // namespace runtime
}  // namespace cce
