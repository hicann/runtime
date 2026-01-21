/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "group_device.hpp"
#include "event.hpp"
#include "api.hpp"
#include "npu_driver.hpp"
#include "task.hpp"
#include "error_message_manage.hpp"
#include "mmpa/mmpa_api.h"
#ifndef CFG_DEV_PLATFORM_PC
#include "error_manager.h"
#endif
#include "dvpp_grp.hpp"
#include "profiler.hpp"
#include "task_res.hpp"
#include "task_submit.hpp"
#include "stream_state_callback_manager.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "error_code.h"
#include "capture_model.hpp"
#include "task_starsv2.hpp"
#include "stub_task.hpp"
#include "device_error_info.hpp"
#include "capture_adapt.hpp"
#include "memory_task.h"
#include "sq_addr_memory_pool.hpp"
#include <thread>

namespace cce {
namespace runtime {
TIMESTAMP_EXTERN(rtStreamCreate_drvMemAllocL2buffAddr);
TIMESTAMP_EXTERN(rtStreamCreate_taskPublicBuff);
TIMESTAMP_EXTERN(rtStreamCreate_drvStreamIdAlloc);
TIMESTAMP_EXTERN(rtStreamCreate_AllocLogicCq);
TIMESTAMP_EXTERN(rtStreamCreate_AllocStreamSqCq);
TIMESTAMP_EXTERN(rtStreamCreate_CreateTaskResource);
TIMESTAMP_EXTERN(rtStreamCreate_SubmitCreateStreamTask);
TIMESTAMP_EXTERN(rtStreamCreate_drvMemAllocHugePageManaged_drvMemAllocManaged_drvMemAdvise);
TIMESTAMP_EXTERN(rtStreamCreate_drvMemcpy);
TIMESTAMP_EXTERN(rtStreamDestroy_drvMemReleaseL2buffAddr);
TIMESTAMP_EXTERN(rtStreamDestroy_drvMemFreeManaged);
TIMESTAMP_EXTERN(rtStreamDestroy_drvStreamIdFree);
TIMESTAMP_EXTERN(rtStreamDestroy_drvMemFreeManaged_arg);
constexpr uint32_t ERROR_MESSAGE_MAX_SIZE = 10U;
__THREAD_LOCAL__ bool Stream::isNeedStreamAsyncRecycle_ = false;

constexpr uint64_t TASK_SENDING_WAIT_CHECK_TIME = 840000U;
constexpr uint16_t TASK_SENDING_WAIT_CHECK_COUNT = 2U;
Stream::Stream(Device * const dev, const uint32_t prio) : Stream(dev, prio, 0U)
{
}

Stream::Stream(Device * const dev, const uint32_t prio, const uint32_t stmFlags, DvppGrp * const dvppGrp)
    : NoCopy(),
      device_(dev),
      streamId_(-1),
      sqId_(UINT32_MAX),
      cqId_(UINT32_MAX),
      priority_(prio),
      flags_(stmFlags),
      errCode_(0U),
      drvErr_(0U),
      dvppGrp_(dvppGrp),
      sqRegVirtualAddr_(0ULL),
      l2BaseVaddr_(nullptr),
      pteVA_(nullptr),
      needSubmitTask_(true),
      fusioning_(false),
      lastTaskId_(MAX_UINT16_NUM),
      onProfDeviceAddr_(nullptr),
      onProfHostRtAddr_(nullptr),
      onProfHostTsAddr_(nullptr),
      taskHead_(0U),
      taskTail_(0U),
      countingNum_(0U),
      davinciTaskHead_(0U),
      davinciTaskTail_(0U),
      taskPersistentHead_(0U),
      taskPersistentTail_(0U),
      countingPersistentNum_(0U),
      bindFlag_(false),
      subscribeFlag_(StreamSubscribeFlag::SUBSCRIBE_NONE),
      countingActiveNum_(0U),
      isDebugRegister_(false),
      isOverflowSwitchOn_(false),
      earlyRecycleTaskHead_(0U),
      executedTimesSvm_(nullptr),
      taskIdFlipNum_(0U),
      needFastcqFlag_(false),
      recycleFlag_(false),
      tid_(PidTidFetcher::GetCurrentTid()),
      limitFlag_(false),
      streamGeOpTag_(UINT32_MAX),
      taskPosHead_(0U),
      taskPosTail_(0U),
      context_(nullptr),
      satMode_(RT_OVERFLOW_MODE_SATURATION),
      sqDepth_(Runtime::macroValue_.rtsqDepth),
      pendingNum_(0U),
      argRecycleList_(nullptr),
      argRecycleListHead_(0U),
      argRecycleListTail_(0U),
      isCtrlStream_(false),
      sqTailPos_(0U),
      sqHeadPos_(0U),
      failureMode_(CONTINUE_ON_FAILURE),
      fftsMemAllocCnt(0U),
      fftsMemFreeCnt(0U),
      hcclIndex_(UINT16_MAX),
      syncTimeout_(-1),
      abortStatus_(RT_ERROR_NONE)
{
}

Stream::Stream(const Context * const stmCtx, const uint32_t prio) : Stream(stmCtx->Device_(), prio)
{
}

Stream::Stream(const Context * const stmCtx, const uint32_t prio,
               const uint32_t stmFlags) : Stream(stmCtx->Device_(), prio, stmFlags)
{
}

Stream::~Stream()
{
    if (device_ != nullptr) {
        if ((device_->GetDevStatus() != RT_ERROR_NONE) && (this->GetBindFlag())) {
            RT_LOG(RT_LOG_WARNING, "Device fault and the model binds this stream, device_id=%u, stream_id=%d, "
                "can not delete.", device_->Id_(), streamId_);
            return;
        }

        (void)FreeExecutedTimesSvm();

        if ((!NeedDelSelfStream()) && (device_->GetTaskFactory() != nullptr)) {
            device_->GetTaskFactory()->FreeStreamRes(streamId_);
        }

        if (Runtime::Instance()->GetDisableThread()) {
            if (dvppGrp_ != nullptr) {
                (void)device_->Driver_()->StreamUnBindLogicCq(device_->Id_(), device_->DevGetTsId(),
                    streamId_, dvppGrp_->getLogicCqId());
            } else {
                (void)device_->GetStreamSqCqManage()->FreeLogicCq(static_cast<uint32_t>(streamId_));
            }
        }

        if (dvppRRTaskAddr_ != nullptr) {
            (void)device_->Driver_()->DevMemFree(dvppRRTaskAddr_, device_->Id_());
            dvppRRTaskAddr_ = nullptr;
        }

        ReleaseStreamTaskRes();
        if (hcclIndex_ != static_cast<uint16_t>(UINT16_MAX)) {
            const std::lock_guard<std::mutex> lk(device_->GetHcclStreamIndexMutex());
            device_->FreeHcclIndex(static_cast<uint16_t>(streamId_));
        }

        if (device_->GetDevRunningState() != static_cast<uint32_t>(DEV_RUNNING_DOWN)) {
            FreeStreamId();
        }

        for (void * const switchArg : switchNArg_) {
            TIMESTAMP_BEGIN(rtStreamDestroy_drvMemFreeManaged_arg);
            (void)device_->Driver_()->DevMemFree(switchArg, device_->Id_());
            TIMESTAMP_END(rtStreamDestroy_drvMemFreeManaged_arg);
        }
        switchNArg_.clear();
        if (timelineAddr_ != nullptr) {
            (void)device_->Driver_()->DevMemFree(timelineAddr_, device_->Id_());
            timelineAddr_ = nullptr;
        }
        if (memContainOverflowAddr_ != nullptr) {
            (void)device_->Driver_()->DevMemFree(memContainOverflowAddr_, device_->Id_());
            memContainOverflowAddr_ = nullptr;
        }
        for (void * const addr : devTilingTblAddr) {
            RT_LOG(RT_LOG_INFO, "Id=%u, devCopyMem=%p", device_->Id_(), addr);
            (void)device_->Driver_()->DevMemFree(addr, device_->Id_());
        }

        for (const auto devAddr : recordDevMemAddr_) {
            (void)device_->Driver_()->DevMemFree(devAddr, device_->Id_());
        }

        if (IsSoftwareSqEnable() && (GetSqBaseAddr() != 0U)) {
            SqAddrMemoryOrder *sqAddrMemoryManage = device_->GetSqAddrMemoryManage();
            if (sqAddrMemoryManage != nullptr) {
                (void)sqAddrMemoryManage->FreeSqAddr(RtValueToPtr<uint64_t *>(GetSqBaseAddr()), GetSqMemOrderType());
            }
        }

        if (GetSqIdMemAddr() != 0UL) {
            device_->FreeSqIdMemAddr(GetSqIdMemAddr());
        }
        recordDevMemAddr_.clear();
        devTilingTblAddr.clear();
        captureStream_ = nullptr;
        streamResId = RTS_INVALID_RES_ID;
        context_ = nullptr;
        device_ = nullptr;
        l2BaseVaddr_ = nullptr;
        models_.clear();
        onProfDeviceAddr_ = nullptr;
        onProfHostRtAddr_ = nullptr;
        onProfHostTsAddr_ = nullptr;
        dvppGrp_ = nullptr;
        taskGroup_ = nullptr;
        isSoftwareSqEnable_ = false;
        sqAddr_ = 0ULL;
        sqMemOrderType_ = SQ_ADDR_MEM_ORDER_TYPE_MAX;
        UpdateTaskGroupStatus(StreamTaskGroupStatus::NONE);
    }

    DestroyArgRecycleList(static_cast<uint32_t>(argRecycleListSize_));
    taskIdToTaskTagMap_.clear();

    DELETE_O(lastHalfRecord_);
    try {
        DELETE_A(taskPublicBuff_);
        DELETE_A(davinciTaskList_);
        DELETE_A(posToTaskIdMap_);
        DELETE_A(wrRecordQueue_.queue);
        DELETE_A(sqeBuffer_);
    } catch(...) {
    }
    latestModelId_ = MAX_INT32_NUM;
}

void Stream::FreeStreamId() const
{
    if (streamId_ == -1) {
        RT_LOG(RT_LOG_INFO, "Free Stream_id is -1,no need free.");
        return;
    }

    if ((flags_ & RT_STREAM_FORBIDDEN_DEFAULT) != 0U) {
        RT_LOG(RT_LOG_INFO, "Free forbidden default stream_id=%d.", streamId_);
    } else if ((flags_ & RT_STREAM_AICPU) != 0U) {
        Runtime::Instance()->FreeAiCpuStreamId(streamId_);
    } else {
        RT_LOG(RT_LOG_INFO, "Free stream_id=%d.", streamId_);
        if (!IsSoftwareSqEnable()) {
            TIMESTAMP_BEGIN(rtStreamDestroy_drvStreamIdFree);
            uint32_t drvFlag = ((flags_ & RT_STREAM_CP_PROCESS_USE) != 0) ?
                static_cast<uint32_t>(TSDRV_FLAG_REMOTE_ID) : 0U;
            (void)device_->GetStreamSqCqManage()->DeAllocStreamSqCq(static_cast<uint32_t>(streamId_), cqId_, drvFlag);
        }

        Driver * const dev = device_->Driver_();
        const rtError_t ret = dev->StreamIdFree(streamId_, device_->Id_(), device_->DevGetTsId(), flags_);
        Runtime * const rtInstance = Runtime::Instance();
        if ((ret != RT_ERROR_NONE) && (rtInstance->excptCallBack_ != nullptr)) {
            Runtime::Instance()->excptCallBack_(RT_EXCEPTION_STREAM_ID_FREE_FAILED);
        }
        TIMESTAMP_END(rtStreamDestroy_drvStreamIdFree);
    }
}

rtError_t Stream::CheckGroup()
{
    uint32_t groupCount = 0U;
    (void)device_->GetGroupCount(&groupCount);
    if ((groupCount > 1U) && (device_->DefaultGroup() == -1) && (device_->GetGroupId() == UNINIT_GROUP_ID)) {
        if ((flags_ & RT_STREAM_PRIMARY_DEFAULT) != 0U) {
            RT_LOG(RT_LOG_WARNING, "Multiple groups have been created, but no default group exists."
                                   " Please use rtSetGroup to set a group first!");
        } else {
            RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,
                "Multiple groups have been created, but no default group exists."
                " Please use rtSetGroup to set a group first!");
            return RT_ERROR_GROUP_NOT_SET;
        }
    }
    return RT_ERROR_NONE;
}

rtError_t Stream::CreateStreamTaskRes(void)
{
    // The fast launch flag is used to determine whether to apply for reserved resources.
    // In addition, streams with reserved resources cannot be bound to models.
    if ((flags_ & RT_STREAM_FAST_LAUNCH) == 0U && !device_->IsStarsPlatform()) {
        RT_LOG(RT_LOG_INFO, "Normal STREAM Setup stream_id=%d flags_=0x%x", streamId_, flags_);
        return RT_ERROR_NONE;
    }
    taskResMang_ = new (std::nothrow) TaskResManage;
    if (taskResMang_ == nullptr) {
        RT_LOG(RT_LOG_WARNING, "new TaskResManage fail.");
        return RT_ERROR_NONE;
    }

    bool flag = taskResMang_->CreateTaskRes(this);
    if (!flag) {
        RT_LOG(RT_LOG_WARNING, "CreateTaskRes fail.");
        delete taskResMang_;
        taskResMang_ = nullptr;
        return RT_ERROR_NONE;
    }

    RT_LOG(RT_LOG_INFO, "STREAM TaskRes Setup stream_id=%d, flags_=0x%x.", streamId_, flags_);
    return RT_ERROR_NONE;
}

void Stream::ReleaseStreamTaskRes(void)
{
    if (taskResMang_ != nullptr) {
        taskResMang_->ReleaseTaskResource(this);
    }

    delete taskResMang_;
    taskResMang_ = nullptr;
}

bool Stream::CheckASyncRecycle()
{
    // todo need to limit ctrlStream
    NULL_PTR_RETURN_MSG(device_->PrimaryStream_(), false);
    if (device_->PrimaryStream_()->Id_() == Id_()) {
        return false;
    }

    if (Runtime::Instance()->GetNpuCollectFlag()) {
        return false;
    }

    const bool isDisableThread = Runtime::Instance()->GetDisableThread();
    if ((!GetBindFlag()) && (!IsBindDvppGrp()) && isDisableThread &&
        (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_STREAM_RECLAIM_ASYNC)) &&
        (device_->Driver_()->GetRunMode() == RT_RUN_MODE_ONLINE)
        && streamFastSync_) {
        return true;
    }
    return false;
}

rtError_t Stream::CreateArgRecycleList(uint32_t size)
{
    argRecycleList_ = new (std::nothrow) RecycleArgs *[size]{};
    if (argRecycleList_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "new arg handle list failed");
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    argRecycleListSize_ = size;
    for (uint32_t i = 0U; i < size; i++) {
        argRecycleList_[i] = new (std::nothrow) RecycleArgs();
        if (argRecycleList_[i] == nullptr) {
            argRecycleListSize_ = i;
            RT_LOG(RT_LOG_ERROR, "new recycle args failed");
            return RT_ERROR_MEMORY_ALLOCATION;
        }
        argRecycleList_[i]->argHandle = nullptr;
        argRecycleList_[i]->mixDescBuf = nullptr;
    }

    return RT_ERROR_NONE;
}

void Stream::DestroyArgRecycleList(uint32_t size)
{
    if (argRecycleList_ == nullptr) {
        return;
    }

    for (uint32_t i = 0U; i < size; i++) {
        DELETE_O(argRecycleList_[i]);
    }

    DELETE_A(argRecycleList_);
    return;
}

bool Stream::AddArgToRecycleList(TaskInfo * const tsk)
{
    const bool isAicTask = (tsk->type == TS_TASK_TYPE_KERNEL_AICORE) ||
        (tsk->type == TS_TASK_TYPE_KERNEL_AIVEC);
    if (isAicTask && static_cast<uint32_t>(tsk->u.aicTaskInfo.mixOpt) != 0U) {
        RT_LOG(RT_LOG_DEBUG, "mix Optimized");
        return false;
    }
    if (argRecycleList_ == nullptr) {
        return false;
    }

    const std::unique_lock<std::mutex> lk(argRecycleListMutex_);
    if (((argRecycleListTail_ + 1U) % argRecycleListSize_) == argRecycleListHead_) {
        RT_LOG(RT_LOG_DEBUG, "arg handle list is full, head=%hu, tail=%hu", argRecycleListHead_, argRecycleListTail_);
        return false;
    }

    RecycleArgs *recycleArgs = *(argRecycleList_ + argRecycleListTail_);

    if (isAicTask) {
        recycleArgs->argHandle = tsk->u.aicTaskInfo.comm.argHandle;
        recycleArgs->mixDescBuf = tsk->u.aicTaskInfo.descBuf;
        tsk->u.aicTaskInfo.comm.argHandle = nullptr;
        tsk->u.aicTaskInfo.descBuf = nullptr;
    } else if (tsk->type == TS_TASK_TYPE_KERNEL_AICPU) {
        recycleArgs->argHandle = tsk->u.aicpuTaskInfo.comm.argHandle;
        tsk->u.aicpuTaskInfo.comm.argHandle = nullptr;
    } else {
        // no operation
    }
    argRecycleListTail_ = (argRecycleListTail_ + 1U) % argRecycleListSize_;

    return true;
}

RecycleArgs* Stream::GetNextRecycleArg(void)
{
    if (argRecycleList_ == nullptr) {
        return nullptr;
    }

    const std::unique_lock<std::mutex> lk(argRecycleListMutex_);
    if (argRecycleListHead_ == argRecycleListTail_) {
        return nullptr;
    }

    /* update the queue head */
    RecycleArgs *recycleArgs = *(argRecycleList_ + argRecycleListHead_);
    argRecycleListHead_ = (argRecycleListHead_ + 1U) % argRecycleListSize_;

    return recycleArgs;
}

void Stream::ProcArgRecycleList(void)
{
    RecycleArgs *recycleArgs = GetNextRecycleArg();
    while (recycleArgs != nullptr) {
        if (recycleArgs->argHandle != nullptr) {
            (void)Device_()->ArgLoader_()->Release(recycleArgs->argHandle);
            recycleArgs->argHandle = nullptr;
        }

        if (recycleArgs->mixDescBuf != nullptr) {
            (void)(Device_()->Driver_())->DevMemFree(recycleArgs->mixDescBuf, Device_()->Id_());
            recycleArgs->mixDescBuf = nullptr;
        }

        recycleArgs = GetNextRecycleArg();
    }
}

bool Stream::IsReclaimAsync(const TaskInfo * const tsk) const
{
    if ((tsk->type == TS_TASK_TYPE_FFTS_PLUS) ||(tsk->type == TS_TASK_TYPE_NOTIFY_WAIT) ||
        (tsk->type == TS_TASK_TYPE_NOTIFY_RECORD)) {
            return true;
    }
    if (tsk->type == TS_TASK_TYPE_MEMCPY) {
        const uint32_t copyTypeFlag = tsk->u.memcpyAsyncTaskInfo.copyType;
        if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_MEMCOPY_RECLAIM_ASYNC_WITHOUR_PCIE_BAR)) {
            if ((copyTypeFlag == RT_MEMCPY_DIR_H2D) || (copyTypeFlag == RT_MEMCPY_DIR_D2H) ||
                 (copyTypeFlag == RT_MEMCPY_DIR_D2D_PCIe)) {
                return false;
            }
            return true;
        } else {
            if ((copyTypeFlag != RT_MEMCPY_DIR_D2D_SDMA) && (copyTypeFlag != RT_MEMCPY_DIR_SDMA_AUTOMATIC_ADD)
                && (copyTypeFlag != RT_MEMCPY_ADDR_D2D_SDMA)) {
                return false;
            }
            return true;
        }
    }
    return false;
}

bool Stream::IsNeedPostProc(const TaskInfo * const tsk) const
{
    if (tsk->stream->isHasPcieBar_) {
        const bool isAicTask = (tsk->type == TS_TASK_TYPE_KERNEL_AICORE) ||
            (tsk->type == TS_TASK_TYPE_KERNEL_AIVEC);
        if (isAicTask) {
            // some aicpu launch size < 1K, but no use pcie
            const uint8_t mixType =
                (tsk->u.aicTaskInfo.kernel != nullptr) ? tsk->u.aicTaskInfo.kernel->GetMixType() : 0U;
            if ((tsk->u.aicTaskInfo.comm.argHandle == nullptr) &&
                (tsk->u.aicTaskInfo.comm.argsSize <= RTS_LITE_PCIE_BAR_COPY_SIZE) && (mixType == NO_MIX)) {
                return false;
            }
        } else if (tsk->type == TS_TASK_TYPE_KERNEL_AICPU) {
            if ((tsk->u.aicpuTaskInfo.comm.argHandle == nullptr) &&
                (tsk->u.aicTaskInfo.comm.argsSize <= RTS_LITE_PCIE_BAR_COPY_SIZE)) {
                return false;
            }
        } else if ((tsk->type == TS_TASK_TYPE_NOTIFY_WAIT) || (tsk->type == TS_TASK_TYPE_NOTIFY_RECORD)) {
            return false;
        } else {
            // do nothing
        }
        return true;
    } else {
        if (IsDavinciTask(tsk) || IsReclaimAsync(tsk)) {
            return false;
        }
        return true;
    }
}

rtError_t Stream::EschedManage(const bool enFlag) const
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t eschedTid = 0U;
    uint32_t grpId = UINT32_MAX;
    const int32_t curTid = mmGetTid();
    const uint32_t devId = device_->Id_();
    const uint32_t tsId = device_->DevGetTsId();
    constexpr uint64_t eventBitmap = (0x1ULL << static_cast<uint64_t>(EVENT_TS_CALLBACK_MSG));  // EVENT TYPE

    Runtime * const rtInstance = Runtime::Instance();
    if (!rtInstance->IsStreamSyncEsched()) {
        return error;
    }

    grpId = rtInstance->GetStreamSyncEschedGrpID();
    if (enFlag) {
        error = NpuDriver::StreamEnableStmSyncEsched(devId, tsId, static_cast<uint32_t>(streamId_),
                                                     grpId, EVENT_TS_CALLBACK_MSG);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    }

    rtInstance->StreamSyncEschedLock();
    std::map<int32_t, uint32_t>::iterator it =
            rtInstance->eschedMap_.find(curTid);
    if (it != rtInstance->eschedMap_.end()) {
        rtInstance->StreamSyncEschedUnLock();
        return RT_ERROR_NONE;
    }

    if (rtInstance->lastEschedTid_ >= STMSYNC_ESCHED_MAX_THREAD_NUM) {
        RT_LOG(RT_LOG_ERROR, "subscribed thread num out of range (max %u).", STMSYNC_ESCHED_MAX_THREAD_NUM);
        rtInstance->StreamSyncEschedUnLock();
        return RT_ERROR_INVALID_VALUE;
    }

    eschedTid = rtInstance->lastEschedTid_;
    rtInstance->eschedMap_[curTid] = eschedTid;
    rtInstance->lastEschedTid_ += 1;
    rtInstance->StreamSyncEschedUnLock();

    RT_LOG(RT_LOG_DEBUG, "Add mapping relation ostid=%u, eschedTid=%u.", curTid, eschedTid);

    error = NpuDriver::EschedSubscribeEvent(static_cast<int32_t>(devId), grpId, eschedTid, eventBitmap);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    RT_LOG(RT_LOG_DEBUG, "EschedSubscribeEvent devId=%u, eschedTid=%u, eventBitmap=%llu.",
        devId, eschedTid, eventBitmap);

    rtEschedEventSummary_t evt = {};
    (void)NpuDriver::EschedWaitEvent(static_cast<int32_t>(devId), grpId, eschedTid, 0, &evt);

    return error;
}

rtError_t Stream::Setup()
{
    rtError_t error;
    const uint32_t rtsqDepth = (((flags_ & RT_STREAM_HUGE) != 0U) && (Runtime::macroValue_.maxTaskNumPerHugeStream != 0)) ?
        Runtime::macroValue_.maxTaskNumPerHugeStream : Runtime::macroValue_.rtsqDepth;
    SetSqDepth(rtsqDepth); 

    const bool isDisableThread = Runtime::Instance()->GetDisableThread();

    if (!IsSeparateSendAndRecycle()) {
        TIMESTAMP_BEGIN(rtStreamCreate_taskPublicBuff);
        taskPublicBuffSize_ = isDisableThread ? STREAM_PUBLIC_TASK_BUFF_SIZE : STREAM_TASK_BUFF_SIZE;
        taskPublicBuff_ = new (std::nothrow) uint32_t[taskPublicBuffSize_];
        TIMESTAMP_END(rtStreamCreate_taskPublicBuff);
        COND_RETURN_ERROR(taskPublicBuff_ == nullptr, RT_ERROR_STREAM_NEW,
                          "new task public buffer failed, size=%hu", taskPublicBuffSize_);
    }

    if (CheckASyncRecycle() && !IsSeparateSendAndRecycle()) {
        SetIsSupportASyncRecycle(true);
        davinciTaskListSize_ = STREAM_PUBLIC_TASK_BUFF_SIZE;
        davinciTaskList_ = new (std::nothrow) uint32_t[davinciTaskListSize_];
        COND_RETURN_ERROR(davinciTaskList_ == nullptr, RT_ERROR_STREAM_NEW,
            "new davinci task list failed, size=%hu", davinciTaskListSize_);
    }

    posToTaskIdMapSize_ = rtsqDepth;
    posToTaskIdMap_ = new (std::nothrow) uint16_t[posToTaskIdMapSize_];
    COND_RETURN_ERROR(posToTaskIdMap_ == nullptr, RT_ERROR_STREAM_NEW,
        "new posToTaskIdMap_ failed, size=%u", rtsqDepth);

    const errno_t ret = memset_s(posToTaskIdMap_, posToTaskIdMapSize_ * sizeof(uint16_t), 0XFF,
        posToTaskIdMapSize_ * sizeof(uint16_t));
    if (ret != EOK) {
        RT_LOG(RT_LOG_ERROR, "Memset posToTaskIdMap failed, retCode=%d.", ret);
        return RT_ERROR_SEC_HANDLE;
    }

    wrRecordQueue_.queue = new (std::nothrow) uint32_t[rtsqDepth];
    if (wrRecordQueue_.queue == nullptr) {
        RT_LOG(RT_LOG_ERROR, "new wrRecordQueue_.queue failed, size=%u", rtsqDepth);
        return RT_ERROR_STREAM_NEW;
    }
    (void)memset_s(wrRecordQueue_.queue, rtsqDepth * sizeof(uint32_t), 0, rtsqDepth * sizeof(uint32_t));
    wrRecordQueue_.size = rtsqDepth;

    error = CheckGroup();
    if (error != RT_ERROR_NONE) {
        return error;
    }

    if ((flags_ & RT_STREAM_FORBIDDEN_DEFAULT) != 0U) {
        streamId_ = static_cast<int32_t>(MAX_INT32_NUM);
        RT_LOG(RT_LOG_DEBUG, "create a forbidden stream, stream_id=%u", streamId_);
        StreamStateCallbackManager::Instance().Notify(this, true);
        return RT_ERROR_NONE;
    }
    if ((flags_ & RT_STREAM_AICPU) != 0U) {
        error = Runtime::Instance()->AllocAiCpuStreamId(streamId_);
        ERROR_RETURN_MSG_INNER(error, "Failed to alloc aicpu stream id, retCode=%#x, stream_id=%d.",
            static_cast<uint32_t>(error), streamId_);
        StreamStateCallbackManager::Instance().Notify(this, true);
        return RT_ERROR_NONE; // AiCpuStream not participate in scheduling
    }

    if ((flags_ & RT_STREAM_OVERFLOW) != 0U) {
        SetOverflowSwitch(true);
    }
    TIMESTAMP_BEGIN(rtStreamCreate_drvStreamIdAlloc);
    error = device_->Driver_()->StreamIdAlloc(&streamId_, device_->Id_(), device_->DevGetTsId(), priority_);
    device_->GetStreamSqCqManage()->SetStreamIdToStream(static_cast<uint32_t>(streamId_), this);
    TIMESTAMP_END(rtStreamCreate_drvStreamIdAlloc);
    ERROR_RETURN(error, "Failed to alloc stream id, retCode=%#x.", error);
    RT_LOG(RT_LOG_DEBUG, "Alloc stream, stream_id=%d", streamId_);

    error = AllocExecutedTimesSvm();
    ERROR_RETURN_MSG_INNER(error, "Failed to alloc svm for executed times, retCode=%#x.",
        static_cast<uint32_t>(error));

    TIMESTAMP_BEGIN(rtStreamCreate_AllocStreamSqCq);
    /**** alloc sq cq id *****/
    const auto stmSqCqManage = const_cast<StreamSqCqManage *>(device_->GetStreamSqCqManage());

    uint32_t tmpSqId = 0U;
    uint32_t tmpCqId = 0U;
    error = stmSqCqManage->AllocStreamSqCq(this, priority_, 0U, tmpSqId, tmpCqId);
    if (error == RT_ERROR_DRV_NO_RESOURCES) {
        DeviceSqCqPool *sqcqPool = device_->GetDeviceSqCqManage();
        if ((sqcqPool != nullptr) && (sqcqPool->GetSqCqPoolFreeResNum() != 0U)) {
            if (sqcqPool->TryFreeSqCqToDrv() == RT_ERROR_NONE) {
                error = stmSqCqManage->AllocStreamSqCq(this, priority_, 0U, tmpSqId, tmpCqId);
            }
        }
    }

    TIMESTAMP_END(rtStreamCreate_AllocStreamSqCq);
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "[SqCqManage]Alloc sq cq fail, stream_id=%d, retCode=%#x.", streamId_,
            static_cast<uint32_t>(error));
        device_->GetStreamSqCqManage()->DelStreamIdToStream(static_cast<uint32_t>(streamId_));
        (void)device_->Driver_()->StreamIdFree(streamId_, device_->Id_(), device_->DevGetTsId());
        streamId_ = -1;
        return error;
    }

    SetSatMode(device_->GetSatMode());
    sqId_ = tmpSqId;
    cqId_ = tmpCqId;
    RT_LOG(RT_LOG_DEBUG, "[StreamSetup]alloc sq cq success: stream_id=%d, sqId=%u, cqId=%u", streamId_, tmpSqId,
        tmpCqId);

    const bool starsFlag = device_->IsStarsPlatform();
    if (isDisableThread && (!starsFlag)) {
        error = device_->InitStreamRes(static_cast<uint32_t>(streamId_));
        ERROR_RETURN_MSG_INNER(error, "Failed to Init cq share memory, stream_id=%d.", streamId_);
    }

    TIMESTAMP_BEGIN(rtStreamCreate_AllocLogicCq);
    error = AllocLogicCq(isDisableThread, starsFlag, stmSqCqManage);
    TIMESTAMP_END(rtStreamCreate_AllocLogicCq);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    if (starsFlag) {
        // get virtual addr from Driver by sqId.
        uint32_t addrLen = 0U;
        error = device_->Driver_()->GetSqRegVirtualAddrBySqid(static_cast<int32_t>(device_->Id_()),
                                                              device_->DevGetTsId(),
                                                              sqId_, &sqRegVirtualAddr_, &addrLen);
        ERROR_RETURN_MSG_INNER(error, "Fail to get sq reg virtual addr, deviceId=%u, sqId=%u.", device_->Id_(), sqId_);
        RT_LOG(RT_LOG_INFO, "Success to get sq=%u sq reg virtual addr length=%u.", sqId_, addrLen);
        error = SetSqRegVirtualAddrToDevice(sqRegVirtualAddr_);
        ERROR_RETURN_MSG_INNER(error, "Fail to copy sqid=%u virtual addr to device, error=%#x.", sqId_,
            static_cast<uint32_t>(error));
    }

    TIMESTAMP_BEGIN(rtStreamCreate_CreateTaskResource);
    CreateStreamTaskRes();
    TIMESTAMP_END(rtStreamCreate_CreateTaskResource);
    SetMaxTaskId(isDisableThread);
    if (GetIsSupportASyncRecycle() && isHasPcieBar_) {
        static_cast<void>(CreateArgRecycleList(STREAM_PUBLIC_TASK_BUFF_SIZE));
    }

    isFlowCtrl = false;

    /* no need to seed task.
     * A message will be sent in NormalSqCqAllocate via mailbox to ts.
     * Then, ts will config sq swap buffer info on STARS.
     */
    TIMESTAMP_BEGIN(rtStreamCreate_SubmitCreateStreamTask);
    if (!starsFlag) {
        error = SubmitCreateStreamTask();
        ERROR_RETURN_MSG_INNER(error, "Failed to submit create stream task, stream_id=%d.", streamId_);
    }
    TIMESTAMP_END(rtStreamCreate_SubmitCreateStreamTask);

    error = EschedManage(true);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    RT_LOG(RT_LOG_INFO, "stream setup end, stream_id=%d, IsTaskSink=%d, sqId=%u, cqId=%u, deviceId=%u, streamResId=%u",
           streamId_, static_cast<int32_t>(IsTaskSink()), sqId_, cqId_, device_->Id_(), streamResId);
    StreamStateCallbackManager::Instance().Notify(this, true);
    return RT_ERROR_NONE;
}

void Stream::UpdateSqCq(const rtDeviceSqCqInfo_t * const sqCqInfo)
{
    sqId_ = sqCqInfo->sqId;
    cqId_ = sqCqInfo->cqId;
    sqRegVirtualAddr_ = sqCqInfo->sqRegVirtualAddr;

    return;
}

void Stream::ResetSqCq(void)
{
    sqId_ = UINT32_MAX;
    cqId_ = UINT32_MAX;
    sqRegVirtualAddr_ = 0ULL;

    return;
}

rtError_t Stream::SetupWithoutBindSq()
{
    rtError_t error;
    const bool isDisableThread = Runtime::Instance()->GetDisableThread();
    SetSqDepth(STREAM_SQ_MAX_DEPTH);

    SetIsSupportASyncRecycle(false);
    posToTaskIdMapSize_ = GetSqDepth();
    posToTaskIdMap_ = new (std::nothrow) uint16_t[posToTaskIdMapSize_];
    COND_RETURN_ERROR(posToTaskIdMap_ == nullptr, RT_ERROR_STREAM_NEW,
        "new posToTaskIdMap_ failed, size=%u", posToTaskIdMapSize_);

    errno_t ret = memset_s(posToTaskIdMap_, posToTaskIdMapSize_ * sizeof(uint16_t), 0XFF,
        posToTaskIdMapSize_ * sizeof(uint16_t));
    COND_RETURN_ERROR(ret != EOK, RT_ERROR_STREAM_NEW, "Memset posToTaskIdMap failed, retCode=%d.", ret);

    TIMESTAMP_BEGIN(rtStreamCreate_drvStreamIdAlloc);
    error = device_->Driver_()->StreamIdAlloc(&streamId_, device_->Id_(), device_->DevGetTsId(), priority_);
    device_->GetStreamSqCqManage()->SetStreamIdToStream(static_cast<uint32_t>(streamId_), this);
    TIMESTAMP_END(rtStreamCreate_drvStreamIdAlloc);
    ERROR_RETURN(error, "Failed to alloc stream id, retCode=%#x.", error);
    RT_LOG(RT_LOG_DEBUG, "Alloc stream, stream_id=%d", streamId_);

    error = AllocExecutedTimesSvm();
    ERROR_RETURN_MSG_INNER(error, "Failed to alloc svm for executed times, retCode=%#x.",
        static_cast<uint32_t>(error));

    SetSatMode(device_->GetSatMode());
    const bool starsFlag = device_->IsStarsPlatform();

    /**** alloc sq cq id *****/
    const auto stmSqCqManage = RtPtrToUnConstPtr<StreamSqCqManage *>(device_->GetStreamSqCqManage());
    TIMESTAMP_BEGIN(rtStreamCreate_AllocLogicCq);
    error = AllocLogicCq(isDisableThread, starsFlag, stmSqCqManage);
    TIMESTAMP_END(rtStreamCreate_AllocLogicCq);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "Alloc Sq fail ret=0x%llx", error);

    SetMaxTaskId(isDisableThread);
    isFlowCtrl = false;

    sqeBufferSize_ = STREAM_SQE_BUFFER_MAX_SIZE;
    sqeBuffer_ = new (std::nothrow) uint8_t[sqeBufferSize_];
    COND_RETURN_ERROR(sqeBuffer_ == nullptr, RT_ERROR_STREAM_NEW,
        "new sqeBuffer_ failed, size=%u", sqeBufferSize_);

    ret = memset_s(sqeBuffer_, sqeBufferSize_, 0U, sqeBufferSize_);
    COND_RETURN_ERROR(ret != EOK, RT_ERROR_STREAM_NEW, "Memset sqeBuffer failed, retCode=%d.", ret);

    /* pre alloc sq and cq */
    device_->GetDeviceSqCqManage()->PreAllocSqCq();
    const uint64_t sqIdMemAddr = device_->AllocSqIdMemAddr();
    COND_RETURN_ERROR((sqIdMemAddr == 0UL), RT_ERROR_MEMORY_ALLOCATION,
        "sq id mem alloc failed, device_id=%u, stream_id=%d.", device_->Id_(), Id_());

    SetSqIdMemAddr(sqIdMemAddr);

    RT_LOG(RT_LOG_INFO, "stream setup end, stream_id=%d, IsTaskSink=%d, sqId=%u, cqId=%u, deviceId=%u, streamResId=%u, sqAddr=0x%llx",
           streamId_, static_cast<int32_t>(IsTaskSink()), sqId_, cqId_, device_->Id_(), streamResId, sqAddr_);

    StreamStateCallbackManager::Instance().Notify(this, true);
    return RT_ERROR_NONE;
}

void Stream::SetAbortStatus(rtError_t status)
{
    StreamLock();
    abortStatus_ = status;
    StreamUnLock();
}

rtError_t Stream::GetAbortStatus() const
{
    return abortStatus_;
}

void Stream::SetBeingAbortedFlag(bool abortFlag)
{
    isBeingAborted_ = abortFlag;
}

bool Stream::GetBeingAbortedFlag()
{
    return isBeingAborted_;
}

rtError_t Stream::CleanSq()
{
    const rtError_t error = device_->Driver_()->CleanSq(device_->Id_(), device_->DevGetTsId(), sqId_);
    return error;
}

rtError_t Stream::QuerySq(const uint32_t queryType, uint32_t &status)
{
    const rtError_t error = device_->Driver_()->QuerySq(device_->Id_(), device_->DevGetTsId(), sqId_,
        queryType, status);
    return error;
}

rtError_t Stream::TaskAbortByType(uint32_t &result, const uint32_t opType, const uint32_t targetId)
{
    const rtError_t error = device_->Driver_()->TaskAbortByType(device_->Id_(), device_->DevGetTsId(), opType,
        targetId, result);
    return error;
}

rtError_t Stream::QueryAbortStatusByType(uint32_t &status, const uint32_t opType, const uint32_t targetId)
{
    const rtError_t error = device_->Driver_()->QueryAbortStatusByType(device_->Id_(), device_->DevGetTsId(),
        opType, targetId, status);
    return error;
}

rtError_t Stream::RecoverAbortByType(const uint32_t opType, const uint32_t targetId, uint32_t &result)
{
    const rtError_t error = device_->Driver_()->RecoverAbortByType(device_->Id_(), device_->DevGetTsId(),
        opType, targetId, result);
    return error;
}

rtError_t Stream::QueryRecoverStatusByType(uint32_t &status, const uint32_t opType, const uint32_t targetId)
{
    const rtError_t error = device_->Driver_()->QueryRecoverStatusByType(device_->Id_(), device_->DevGetTsId(),
        opType, targetId, status);
    return error;
}

rtError_t Stream::TaskKill(const uint32_t operationType)
{
    const rtError_t error = device_->Driver_()->TaskKill(device_->Id_(), device_->DevGetTsId(), sqId_, operationType);
    return error;
}

rtError_t Stream::SqCqUpdate()
{
    /**** update sq cq id *****/
    const auto stmSqCqManage = const_cast<StreamSqCqManage *>(device_->GetStreamSqCqManage());
    rtError_t error = stmSqCqManage->UpdateStreamSqCq(this);
    ERROR_RETURN_MSG_INNER(error, "deviceId=%u, streamId=%d, sqId=%u.", device_->Id_(), streamId_, sqId_);

    uint32_t addrLen = 0U;
    error = device_->Driver_()->GetSqRegVirtualAddrBySqid(static_cast<int32_t>(device_->Id_()),
        device_->DevGetTsId(), sqId_, &sqRegVirtualAddr_, &addrLen);
    ERROR_RETURN_MSG_INNER(error, "Fail to get sq reg virtual addr, deviceId=%u, sqId=%u.", device_->Id_(), sqId_);

    error = SetSqRegVirtualAddrToDevice(sqRegVirtualAddr_);
    ERROR_RETURN_MSG_INNER(error, "Fail to copy sqid=%u virtual addr to device, error=%#x.", sqId_,
        static_cast<uint32_t>(error));
    return error;
}

rtError_t Stream::ReAllocStreamId()
{
    rtError_t error = device_->Driver_()->ReAllocResourceId(device_->Id_(), device_->DevGetTsId(), priority_,
        static_cast<uint32_t>(streamId_), DRV_STREAM_ID);
    ERROR_RETURN_MSG_INNER(error, "Realloc stream id failed, streamId=%d, deviceId=%u, ret=%d.",
        streamId_, device_->Id_(), error);

    StreamSqCqManage *stmSqCqManage = device_->GetStreamSqCqManage();
    error = stmSqCqManage->ReAllocSqCqId(this);
    ERROR_RETURN_MSG_INNER(error, "Realloc sqcq id failed, streamId=%d, deviceId=%u, sqId=%u, ret=%d.",
        streamId_, device_->Id_(), sqId_, error);

    uint32_t addrLen = 0U;
    error = device_->Driver_()->GetSqRegVirtualAddrBySqid(static_cast<int32_t>(device_->Id_()),
        device_->DevGetTsId(), sqId_, &sqRegVirtualAddr_, &addrLen);
    ERROR_RETURN_MSG_INNER(error, "Fail to get sq reg virtual addr, deviceId=%u, sqId=%u.", device_->Id_(), sqId_);

    error = SetSqRegVirtualAddrToDevice(sqRegVirtualAddr_);
    ERROR_RETURN_MSG_INNER(error, "Fail to copy sqid=%u virtual addr to device, error=%d.", sqId_, error);
    return error;
}

rtError_t Stream::Restore()
{
    rtError_t error = ReAllocStreamId();
    ERROR_RETURN_MSG_INNER(error, "Realloc stream id failed, streamId=%d, deviceId=%u, ret=%d.",
        streamId_, device_->Id_(), error);

    if (taskResMang_ != nullptr) {
        error = taskResMang_->RePcieHostRegister(this);
        ERROR_RETURN_MSG_INNER(error, "RePcieHostRegister failed, streamId=%d, deviceId=%u, ret=%d.",
            streamId_, device_->Id_(), error);
    }

    error = device_->Driver_()->MemSetSync(executedTimesSvm_, sizeof(uint16_t), 0xFFU, sizeof(uint16_t));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "MemSetSync stream executed times SVM failed, retCode=%#x.", static_cast<uint32_t>(error));
    return error;
}

rtError_t Stream::SetL2Addr()
{
    constexpr size_t memSize = PTE_LENGTH * sizeof(uint64_t);
    // alloc device mem, max L2 size is 32M ,need 16 page table
    TIMESTAMP_BEGIN(rtStreamCreate_drvMemAllocHugePageManaged_drvMemAllocManaged_drvMemAdvise);
    rtError_t error = device_->Driver_()->DevMemAlloc(&pteVA_, memSize, RT_MEMORY_HBM, device_->Id_());
    ERROR_RETURN(error, "Failed to malloc device memory for L2 address.");
    TIMESTAMP_END(rtStreamCreate_drvMemAllocHugePageManaged_drvMemAllocManaged_drvMemAdvise);

    // cpy pte to device mem
    TIMESTAMP_BEGIN(rtStreamCreate_drvMemcpy);
    error = device_->Driver_()->MemCopySync(pteVA_, memSize, static_cast<void *>(pte_.data()),
        memSize, RT_MEMCPY_HOST_TO_DEVICE);
    ERROR_GOTO_MSG_INNER(error, DEV_FREE, "Failed to memcpy for L2 address, retCode=%#x,"
        "srcSize=%zu(bytes), dstSize=%zu(bytes).", static_cast<uint32_t>(error), memSize, memSize);
    TIMESTAMP_END(rtStreamCreate_drvMemcpy);

    return RT_ERROR_NONE;
DEV_FREE:
    const rtError_t errorDevFree = device_->Driver_()->DevMemFree(pteVA_, device_->Id_());
    COND_LOG(errorDevFree != RT_ERROR_NONE, "dump dev mem free failed, retCode=%#x, deviceId=%u.",
        errorDevFree, device_->Id_());
    pteVA_ = nullptr;
    return error;
}

rtError_t Stream::ProcL2AddrTask(TaskInfo *&tsk)
{
    // trans device va to pte_pa;
    uint64_t ptePA;
    int32_t devId = static_cast<int32_t>(device_->Id_());
    rtError_t error = device_->Driver_()->MemAddressTranslate(devId,
        RtPtrToValue(pteVA_), &ptePA);
    ERROR_RETURN_MSG_INNER(error, "Failed to translate address to physic for L2 address, retCode=%#x.",
                           static_cast<uint32_t>(error));

    rtError_t errorReason;
    TaskInfo *l2Task = AllocTask(tsk, TS_TASK_TYPE_CREATE_L2_ADDR, errorReason);
    NULL_PTR_RETURN_MSG(l2Task, errorReason);

    error = CreateL2AddrTaskInit(l2Task, ptePA);
    tsk = l2Task;
    return error;
}

rtError_t Stream::SubmitCreateStreamTask()
{
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *createStmTsk = AllocTask(&submitTask, TS_TASK_TYPE_CREATE_STREAM, errorReason);
    NULL_PTR_RETURN_MSG(createStmTsk, errorReason);

    rtError_t error = CreateStreamTaskInit(createStmTsk, flags_);
    ERROR_GOTO_MSG_INNER(error, ERROR_TASK, "Failed to init create stream task.");

    error = device_->SubmitTask(createStmTsk);
    ERROR_GOTO_MSG_INNER(error, ERROR_TASK, "Failed to submit create stream task.");
    return RT_ERROR_NONE;

ERROR_TASK:
    (void)device_->GetTaskFactory()->Recycle(createStmTsk);
    return error;
}

rtError_t Stream::TearDown(const bool terminal, bool flag)
{
    Runtime * const rt = Runtime::Instance();
    TaskInfo submitRecycleTask = {};
    TaskInfo submitDestroyTask = {};
    TaskInfo *tsk = nullptr;
    TaskInfo *recycleTask = nullptr;
    Stream* exeStream = this;
    Device * const dev = device_;
    const int32_t stmId = streamId_;
    uint32_t logicCqId = 0U;
    uint32_t tskForceRecycleCnt = 0;
    rtError_t error = RT_ERROR_NONE;
    const uint32_t devId = dev->Id_();
    const uint32_t tsId = dev->DevGetTsId();
    uint32_t tryWaitCnt = 0U;
    uint32_t waitCnt = 0U;
    uint16_t sqHead = 0;
    uint16_t sqTail = 0;
    bool sqEnable = true;
    rtError_t errorReason;

    if (fusioning_) {
        RT_LOG(RT_LOG_WARNING, "fusion is not match, stream_id=%d", stmId);
    }

    const bool starsFlag = dev->IsStarsPlatform();
    if (rt->GetDisableThread() && (!starsFlag)) {
        bool isFastCq = false;
        error = dev->GetStreamSqCqManage()->AllocLogicCq(static_cast<uint32_t>(stmId),
            IsSteamNeedFastCq(), logicCqId, isFastCq);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "alloc logic cq failed.");
        RT_LOG(RT_LOG_DEBUG, "stream teardown. stream_id=%d, logic_cq_id=%u, is_Fast_Cq=%u",
            stmId, logicCqId, static_cast<uint32_t>(isFastCq));
    }
    bool isForceRecycle = GetForceRecycleFlag(flag);
    RT_LOG(RT_LOG_INFO, "stream_id=%d, sqId=%u, pendingNum=%u, isForceRecycle_=%d, flag=%d, failMode=%u.", stmId, sqId_,
        pendingNum_.Value(), isForceRecycle, flag, GetFailureMode());
    if (isForceRecycle) {
        // force recycle may use ctrlsq
        exeStream = dev->GetCtrlStream(this);
        if (starsFlag) {
            exeStream = dev->PrimaryStream_();
            if (this == exeStream) {
                isForceRecycle = false;
            }
            isForceRecycle_ = isForceRecycle;
        }
    }
    if (unlikely(pendingNum_.Value() > 0U)) {
        NULL_PTR_RETURN_MSG(exeStream, RT_ERROR_STREAM_NULL);
        tsk = exeStream->AllocTask(&submitRecycleTask, TS_TASK_TYPE_MAINTENANCE, errorReason);
        NULL_PTR_RETURN_MSG(tsk, errorReason);

        error = MaintenanceTaskInit(tsk, MT_STREAM_RECYCLE_TASK, static_cast<uint32_t>(stmId), isForceRecycle);
        ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Failed to init maintenance task, retCode=%#x, stream_id=%d.",
                             static_cast<uint32_t>(error), stmId);
        tsk->u.maintenanceTaskInfo.waitCqId = static_cast<uint16_t>(logicCqId);

        error = dev->SubmitTask(tsk);
        if (error != RT_ERROR_NONE) {
            (void)dev->GetTaskFactory()->Recycle(tsk);
            RT_LOG(RT_LOG_ERROR, "Failed to submit task, retCode=%#x, stream_id=%d, task_id=%u.",
                error, stmId, static_cast<uint32_t>(tsk->id));
        }
    }
    // Stream may be destroyed without sync, so MT task can get abort_failure status
    isForceRecycle = GetForceRecycleFlag(flag);

    while ((pendingNum_.Value() > 0U) && (device_->GetDevRunningState() == static_cast<uint32_t>(DEV_RUNNING_NORMAL))) {
        if (isForceRecycle && (dev->CtrlStream_() != nullptr)) {
            // ctrl sq is fast, normal task may be handled after ctrl task
            // so try to send more force recycle task.
            tskForceRecycleCnt = (tskForceRecycleCnt >= RECYCLE_CNT) ? RECYCLE_CNT : tskForceRecycleCnt;
            error = RecycleTaskWithCtrlsq(dev, logicCqId, tskForceRecycleCnt++);
            COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "force recycle with ctrlsq failed.");
            if ((GetFailureMode() == ABORT_ON_FAILURE) && tskForceRecycleCnt >= RECYCLE_CNT) {
                RT_LOG(RT_LOG_ERROR, "stream_id=%d is ABORT, pendingNum=%u.", stmId, pendingNum_.Value());
                break;
            }
        }
        if (starsFlag) {
            error = dev->Driver_()->GetSqHead(devId, tsId, sqId_, sqHead);
            ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Get sq head failed, stream_id=%d, sqId=%u, pendingNum=%u, "
                "isForceRecycle_=%d.", stmId, sqId_, pendingNum_.Value(), isForceRecycle_);

            error = dev->Driver_()->GetSqTail(devId, tsId, sqId_, sqTail);
            ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Get sq tail failed, stream_id=%d, sqId=%u, pendingNum=%u, "
                "isForceRecycle_=%d.", stmId, sqId_, pendingNum_.Value(), isForceRecycle_);

            RT_LOG(RT_LOG_INFO, "submitTaskFail=%d, stream_id=%d, sqHead=%u, sqTail=%u, tryWaitCnt=%u, pendingNum=%u",
                isSubmitTaskFail_, stmId, sqHead, sqTail, tryWaitCnt, pendingNum_.Value());
            constexpr uint32_t maxWaitCnt = 6U;
            if ((isSubmitTaskFail_) && (waitCnt > maxWaitCnt)) {
                break;
            }
            error = dev->Driver_()->GetSqEnable(devId, tsId, sqId_, sqEnable);
            ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Get sq enable failed, stream_id=%d, sqId=%u, pendingNum=%u, "
                "isForceRecycle_=%d.", stmId, sqId_, pendingNum_.Value(), isForceRecycle_);

            // Wait sqHead == sqTail in 30s
            constexpr uint32_t waitTimeout = 3000U;
            // dvpp需要等待response状态返回才拉低Sq，同时head=tail， 其他的场景当sq是disable的时候需要直接回收。
            if ((sqHead == sqTail) || (tryWaitCnt > waitTimeout) || !sqEnable) {
                uint32_t reclaimTaskId = UINT32_MAX;
                RT_LOG(RT_LOG_INFO, "stream_id=%d, sqId_=%u, pendingNum=%u, isForceRecycle_=%d, isSubmitTaskFail_=%d.",
                    stmId, sqId_, pendingNum_.Value(), isForceRecycle_, isSubmitTaskFail_);
               
                if (IsSeparateSendAndRecycle()) {
                    StreamRecycleLock();
                    dev->RecycleSeparatedStmByFinishedId(this, static_cast<uint16_t>(lastTaskId_));
                    StreamRecycleUnlock();
                } else {
                    StreamSyncLock();
                    (void)dev->TaskReclaim(static_cast<uint32_t>(streamId_), false, reclaimTaskId);
                    StreamSyncUnLock();
                }
                waitCnt++;
            } else {
                (void)mmSleep(1U);
            }
            tryWaitCnt++;
        }
    }

    if (isSupportASyncRecycle_) {
        tryWaitCnt = 0U;
        dev->DelStreamFromMessageQueue(this);
        while (isRecycleThreadProc_ && starsFlag) {
            (void)mmSleep(1U);
            // Wait RecycleThread done in 10s
            if ((tryWaitCnt++) > 1000U) {
                RT_LOG(RT_LOG_WARNING, "stream_id=%d, RecycleThread process over 1s.", stmId);
                break;
            }
        }
    }

    RT_LOG(RT_LOG_INFO, "stream_id=%d, delay recycle task num=%zu.", stmId, delayRecycleTaskid_.size());
    if (!delayRecycleTaskid_.empty()) {
        Profiler * const profilerPtr = Runtime::Instance()->Profiler_();
        if (profilerPtr != nullptr) {
            profilerPtr->EraseStream(this);
        }
    }

    while (!delayRecycleTaskid_.empty()) {
        const uint16_t taskId = delayRecycleTaskid_.back();
        recycleTask = dev->GetTaskFactory()->GetTask(stmId, taskId);
        if (recycleTask == nullptr) {
            RT_LOG(RT_LOG_WARNING, "can't find task from factory, stream_id=%d task_id=%u",
                   stmId, static_cast<uint32_t>(taskId));
            delayRecycleTaskid_.pop_back();
            continue;
        }
        (void)dev->GetTaskFactory()->Recycle(recycleTask);
        delayRecycleTaskid_.pop_back();
    }

    if (GetSubscribeFlag() != StreamSubscribeFlag::SUBSCRIBE_NONE) {
        error = rt->UnSubscribeReport(this);
        ERROR_RETURN_MSG_INNER(error, "Failed to unsubscribe streamId(%d), retCode=%#x.", stmId,
            static_cast<uint32_t>(error));
    }

    // on stars, there is no need to send destroy task
    if (starsFlag || ((flags_ & RT_STREAM_CP_PROCESS_USE) != 0)) {
        const std::lock_guard<std::mutex> stmLock(persistentTaskMutex_);
        persistentTaskid_.clear();
        ReportDestroyFlipTask();
        return error;
    }
    exeStream = this;
    if ((GetFailureMode() == ABORT_ON_FAILURE) || ((exeStream->Context_() != nullptr) &&
        (exeStream->Context_()->GetFailureError() != RT_ERROR_NONE) && (dev->PrimaryStream_()->Id_() != stmId))) {
        // stream is abort, only ctrl sq can destroy stream.
        exeStream = dev->GetCtrlStream(this);
    }

    tsk = exeStream->AllocTask(&submitDestroyTask, TS_TASK_TYPE_MAINTENANCE, errorReason);
    NULL_PTR_RETURN_MSG(tsk, errorReason);

    error = MaintenanceTaskInit(tsk, MT_STREAM_DESTROY, static_cast<uint32_t>(stmId), false);
    tsk->u.maintenanceTaskInfo.waitCqId = static_cast<uint16_t>(logicCqId);
    ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Failed to init maintenance task, retCode=%#x.", static_cast<uint32_t>(error));

    if (terminal) {
        tsk->terminal = true;
    }

    error = dev->SubmitTask(tsk);
    ERROR_GOTO_MSG_INNER(error, ERROR_FREE,
        "Failed to submit maintenance task, retCode=%#x, stream_id=%d, task_id=%u.", static_cast<uint32_t>(error), stmId,
        static_cast<uint32_t>(tsk->id));
    // MT task sent by ctrlsq, taskid in stream will be recycled here, otherwise recycled in Recycle(tsk)
    if (Runtime::Instance()->GetDisableThread()) {
        FreePersistentTaskID(exeStream);
        ReportDestroyFlipTask();
    }
    return RT_ERROR_NONE;

ERROR_FREE:
    (void)dev->GetTaskFactory()->Recycle(tsk);
    return error;
}

rtError_t Stream::RecycleTaskWithCtrlsq(Device * const dev, const uint32_t logicCqId, const uint32_t recycleCnt)
{
    // use ctrl sq to force recycle task in stream.
    rtError_t error = RT_ERROR_NONE;
    TaskInfo *tsk = nullptr;
    NULL_PTR_RETURN(dev, RT_ERROR_DEVICE_NULL);
    NULL_PTR_RETURN(dev->CtrlStream_(), RT_ERROR_STREAM_NULL);

    // avoid too fast recycle task to occupy tsch resource
    COND_PROC(recycleCnt >= RECYCLE_CNT, (void)mmSleep(RECYCLE_INTERVAL));

    Stream* exeStream = dev->GetCtrlStream(this);
    error = RT_ERROR_TASK_NEW;
    tsk = dev->GetTaskFactory()->Alloc(exeStream, TS_TASK_TYPE_MAINTENANCE, error);
    NULL_PTR_RETURN_MSG(tsk, error);
    std::function<void()> const mtTaskRecycle = [&dev, &tsk]() {
        (void)dev->GetTaskFactory()->Recycle(tsk);
    };
    ScopeGuard taskGuard(mtTaskRecycle);
    error = MaintenanceTaskInit(tsk, MT_STREAM_RECYCLE_TASK, static_cast<uint32_t>(streamId_), true);
    ERROR_RETURN(error, "Failed to init maintenance task, retCode=%#x, stream_id=%d.",
        error, streamId_);
    tsk->u.maintenanceTaskInfo.waitCqId = static_cast<uint16_t>(logicCqId);

    RT_LOG(RT_LOG_INFO, "ctrlsq=%d alloc MT task_id=%u for stream_id=%d with pendingNum=%d to force recycle task",
        exeStream->streamId_, tsk->id, streamId_, pendingNum_.Value());

    error = dev->SubmitTask(tsk);
    ERROR_RETURN(error, "Failed to submit maintenance task, retCode=%#x, stream_id=%d.",
        error, streamId_);
    taskGuard.ReleaseGuard();

    uint32_t reclaimTaskId = UINT32_MAX;
    StreamSyncLock();
    (void)dev->TaskReclaim(static_cast<uint32_t>(streamId_), false, reclaimTaskId);
    StreamSyncUnLock();
    return error;
}

rtError_t Stream::WaitEvent(Event * const evt, const uint32_t timeout)
{
    return evt->Wait(this, timeout);
}

rtError_t Stream::ProcessDrvErr(void)
{
    const rtError_t error = static_cast<rtError_t>(GetDrvErr());
    if (unlikely(error == RT_ERROR_NONE)) {
        return RT_ERROR_NONE;
    }
    // report driver error
    if (error == RT_ERROR_SOCKET_CLOSE) {
        RT_LOG_INNER_DETAIL_MSG(RT_DRV_INNER_ERROR, {}, {});
    }
    // report error message error
    const std::lock_guard<std::mutex> errLock(errorMsgLock_);
    for (const auto &errMsg : errorMsg_) {
        RT_LOG_CALL_MSG(errMsg.first, "%s", errMsg.second.c_str());
    }
    return error;
}
rtError_t Stream::GetSynchronizeError(rtError_t error)
{
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    error = GetError();
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    if (GetBindFlag() || context_ == nullptr) {
        return RT_ERROR_NONE;
    }
    if (this == context_->DefaultStream_()) {
        return RT_ERROR_NONE;
    }
    if (device_->GetDeviceStatus() == RT_ERROR_DEVICE_TASK_ABORT) {
        return RT_ERROR_DEVICE_TASK_ABORT;
    }
    // if the context enter failure mode,return the failure error
    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DFX_STOP_ON_STREAM_ERROR)) {
        return (GetFailureMode() == CONTINUE_ON_FAILURE) ? RT_ERROR_NONE : context_->GetFailureError();
    } else {
        return (context_->GetCtxMode() == CONTINUE_ON_FAILURE) ? RT_ERROR_NONE : context_->GetFailureError();
    }
}

rtError_t Stream::GetError(void)
{
    rtError_t error = RT_ERROR_NONE;
    if (unlikely(ProcessDrvErr() != RT_ERROR_NONE)) {
        return static_cast<rtError_t>(GetDrvErr());
    }
    const uint32_t tmpErrCode = GetErrCode();
    if (tmpErrCode != static_cast<uint32_t>(RT_ERROR_NONE)) {
        if (tmpErrCode  == static_cast<uint32_t>(TS_ERROR_END_OF_SEQUENCE)) {
            error = RT_ERROR_END_OF_SEQUENCE;
        } else if (tmpErrCode  == static_cast<uint32_t>(TS_MODEL_ABORT_NORMAL)) {
            error = RT_ERROR_MODEL_ABORT_NORMAL;
        } else if (tmpErrCode  == static_cast<uint32_t>(TS_ERROR_AICORE_OVERFLOW)) {
            error = RT_ERROR_TSFW_AICORE_OVER_FLOW_FAIL;
        } else if (tmpErrCode  == static_cast<uint32_t>(TS_ERROR_AIVEC_OVERFLOW)) {
            error = RT_ERROR_TSFW_AIVEC_OVER_FLOW_FAIL;
        } else if (tmpErrCode == static_cast<uint32_t>(TS_ERROR_AICPU_OVERFLOW)) {
            error = RT_ERROR_TSFW_AICPU_OVER_FLOW_FAIL;
        } else if (tmpErrCode == static_cast<uint32_t>(TS_ERROR_SDMA_OVERFLOW)) {
            error = RT_ERROR_TSFW_SDMA_OVER_FLOW_FAIL;
        } else if (tmpErrCode == static_cast<uint32_t>(TS_ERROR_MODEL_ABORTED)) {
            error = RT_ERROR_MODEL_ABORT_NORMAL;
        } else if (tmpErrCode == static_cast<uint32_t>(TS_ERROR_AICPU_TIMEOUT)) {
            error = RT_ERROR_TSFW_AICPU_TIMEOUT;
        } else {
            RT_LOG(RT_LOG_ERROR, "Stream Synchronize failed, stream_id=%d, retCode=%#x, [%s].",
                streamId_, tmpErrCode, GetTsErrCodeMap(tmpErrCode, &error));
            const std::lock_guard<std::mutex> errLock(errorMsgLock_);
            for (const auto &errMsg : errorMsg_) {
                RT_LOG_CALL_MSG(errMsg.first, "%s", errMsg.second.c_str());
            }
            errorMsg_.clear();
        }
        if (GetFailureMode() != ABORT_ON_FAILURE) {
            errCode_ = static_cast<uint32_t>(RT_ERROR_NONE);
        }
    }
    return error;
}

rtError_t Stream::GetErrorForAbortOnFailure(rtError_t defaultError)
{
    const rtError_t error = GetError();
    if (error == RT_ERROR_NONE) {
        return defaultError;
    }

    return error;
}
rtError_t Stream::CheckContextStatus(const bool isBlockDefaultStream) const
{
    if (context_ == nullptr) {
        if (device_ != nullptr) {
            (void)device_->GetDevRunningState();
            rtError_t status = device_->GetDevStatus();
            COND_PROC_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, status != RT_ERROR_NONE, status,
                                            RT_LOG_INNER_DETAIL_MSG(RT_DRV_INNER_ERROR, {"device_id"}, {std::to_string(device_->Id_())});,
                                            "Device[%u] fault, ret=%#x.", device_->Id_(), status);
            status = device_->GetDeviceStatus();
            COND_RETURN_ERROR(status != RT_ERROR_NONE, status, "device_id=%d status=%d is abnormal.",
                              device_->Id_(), status);
        }
        return RT_ERROR_NONE;
    } else {
        return context_->CheckStatus(this, isBlockDefaultStream);
    }
}

rtError_t Stream::CheckContextTaskSend(const TaskInfo * const workTask) const 
{
    if (context_ == nullptr) {
        if (device_ != nullptr) {
            (void)device_->GetDevRunningState();
            rtError_t status = device_->GetDevStatus();
            COND_PROC_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, status != RT_ERROR_NONE, status,
                                            RT_LOG_INNER_DETAIL_MSG(RT_DRV_INNER_ERROR, {"device_id"}, {std::to_string(device_->Id_())});,
                                            "Device[%u] fault, ret=%#x.", device_->Id_(), status);
            status = device_->GetDeviceStatus();
            COND_RETURN_ERROR(status != RT_ERROR_NONE, status, "device_id=%d status=%d is abnormal.",
                              device_->Id_(), status);
        }
        return RT_ERROR_NONE;
    } else {
        return context_->CheckTaskSend(workTask);
    }
}
rtError_t Stream::GetFinishedTaskIdBySqHead(const uint16_t sqHead, uint16_t &finishedId)
{
    // sqHead indicates the current position of execution; it has not yet been completed.
    const uint32_t rtsqDepth = (((flags_ & RT_STREAM_HUGE) != 0U) && (Runtime::macroValue_.maxTaskNumPerHugeStream != 0)) ?
                               Runtime::macroValue_.maxTaskNumPerHugeStream : Runtime::macroValue_.rtsqDepth;
    const uint32_t posTail = GetTaskPosTail();
    const uint32_t posHead = GetTaskPosHead();
    if (((posTail + rtsqDepth - sqHead) % rtsqDepth) >= (posTail + rtsqDepth - posHead) % rtsqDepth) {
        return RT_ERROR_INVALID_VALUE;
    }
    uint32_t endTaskId = MAX_UINT16_NUM;
    uint32_t nextTaskId = MAX_UINT16_NUM;
    (void)GetTaskIdByPos(sqHead, nextTaskId); // sqhead is next pos.

    const uint16_t finishedPos = (sqHead + rtsqDepth - 1) % rtsqDepth;
    (void)GetTaskIdByPos(finishedPos, endTaskId); // sqhead-1 is finished pos.

    if (sqHead == posTail || nextTaskId != endTaskId) {
        finishedId = static_cast<uint16_t>(endTaskId);
    }
    return RT_ERROR_NONE;
}

bool Stream::SynchronizeDelayTime(const uint16_t finishedId, const uint16_t taskId, const uint16_t sqHead)
{
    constexpr uint16_t LARGER_THRESHOLD = 10U;
    constexpr uint16_t SLEEP_UNIT = 5U;
    constexpr uint16_t PER_SCHED_YIELD = 100U;

    uint16_t exeTaskId = (finishedId == MAX_UINT16_NUM) ? executeEndTaskid_.Value() : finishedId;
    if (TASK_ID_LEQ(TASK_ID_ADD(exeTaskId, LARGER_THRESHOLD), taskId)) {
        std::this_thread::sleep_for(std::chrono::microseconds(LARGER_THRESHOLD * SLEEP_UNIT));
    } else if (TASK_ID_LEQ(TASK_ID_ADD(exeTaskId, 1U), taskId)) {
        uint32_t tryCount = 0U;
        const uint64_t beginTime = GetWallUs();
        while (GetWallUs() - beginTime < SLEEP_UNIT) {
            if (TASK_ID_GEQ(executeEndTaskid_.Value(), taskId) || (sqHead == GetTaskPosTail())) {
                return true;
            }
            tryCount++;
            if ((tryCount % PER_SCHED_YIELD) == 0U) {
                std::this_thread::yield();
            }
        }
    } else {
        // No-op
    }
    return false;
}

rtError_t Stream::SynchronizeExecutedTask(const uint16_t taskId, const mmTimespec &beginTime, int32_t timeout)
{
    uint16_t sqHead = static_cast<uint16_t>(MAX_UINT16_NUM);
    rtError_t error = RT_ERROR_NONE;
    const int32_t REPORT_TIME_UINT = 180 * 1000; // report timeout every 3 min.
    int32_t reportTime = REPORT_TIME_UINT;
    while (true) {
        COND_RETURN_ERROR((IsProcessTimeout(beginTime, timeout)), RT_ERROR_STREAM_SYNC_TIMEOUT,
                          "Stream synchronize timeout, device_id=%u, stream_id=%d, timeout=%dms.",
                          device_->Id_(), streamId_, timeout);
        if (IsProcessTimeout(beginTime, reportTime)) {
            reportTime += REPORT_TIME_UINT;
            RT_LOG(RT_LOG_EVENT, "report three minutes timeout! stream_id=%u, task_id=%u, pendingNum=%u.", Id_(), taskId, pendingNum_.Value());
            if (Runtime::Instance()->excptCallBack_ != nullptr) {
                Runtime::Instance()->excptCallBack_(RT_EXCEPTION_TASK_TIMEOUT);
            }
        }
        COND_RETURN_ERROR((abortStatus_ == RT_ERROR_STREAM_ABORT), RT_ERROR_STREAM_ABORT, "stream_id=%d is abort.", streamId_);
        error = CheckContextStatus(false);
        COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "context is abort, status=%#x.", static_cast<uint32_t>(error));
        if (TASK_ID_GEQ(executeEndTaskid_.Value(), taskId) || sqHead == GetTaskPosTail()) {
            return RT_ERROR_NONE;
        }
        if (!device_->GetIsDoingRecycling()) {
            device_->WakeUpRecycleThread();
        }
        error = device_->Driver_()->GetSqHead(Device_()->Id_(), Device_()->DevGetTsId(), sqId_, sqHead);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Query sq head failed, retCode=%#x.",
                                    static_cast<uint32_t>(error));
        uint16_t finishedId = static_cast<uint16_t>(MAX_UINT16_NUM);
        error = GetFinishedTaskIdBySqHead(sqHead, finishedId);
        if (SynchronizeDelayTime(finishedId, taskId, sqHead)) {
            return RT_ERROR_NONE;
        }
        COND_PROC((error != RT_ERROR_NONE || finishedId == static_cast<uint16_t>(MAX_UINT16_NUM)), continue);
        if (TASK_ID_GEQ(finishedId, taskId)) {
            return RT_ERROR_NONE;
        }
    }
}

rtError_t Stream::WaitConcernedTaskRecycled(const uint16_t taskId, const mmTimespec &beginTime, int32_t timeout)
{
    uint32_t tryCount = 0U;
    rtError_t error = RT_ERROR_NONE;
    constexpr uint16_t perSchedYield = 1000U;
     while (true) {
         COND_RETURN_ERROR((IsProcessTimeout(beginTime, timeout)), RT_ERROR_STREAM_SYNC_TIMEOUT,
                           "Stream recycle timeout, device_id=%u, stream_id=%d, timeout=%dms, tryCount=%u",
                           device_->Id_(), streamId_, timeout, tryCount);
         COND_RETURN_ERROR((abortStatus_ == RT_ERROR_STREAM_ABORT), RT_ERROR_STREAM_ABORT, "stream_id=%d is abort.", streamId_);
         error = CheckContextStatus(false);
         COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "context is abort, status=%#x.", static_cast<uint32_t>(error));
         if (TASK_ID_GEQ(recycleEndTaskId_.Value(), taskId)) {
             return RT_ERROR_NONE;
         }
         if (!device_->GetIsDoingRecycling()) {
             device_->WakeUpRecycleThread();
         }
         tryCount++;
         if (tryCount % perSchedYield == 0) {
             std::this_thread::yield();
         }
     }
}

rtError_t Stream::SynchronizeImpl(const uint16_t syncTaskId, const uint16_t concernedTaskId, int32_t timeout)
{
    rtError_t error = RT_ERROR_NONE;
    const mmTimespec beginTime = mmGetTickCount();
    error = SynchronizeExecutedTask(syncTaskId, beginTime, timeout);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "failed, stream_id=%d, error=0x%x", Id_(), error);
    StreamSyncFinishReport();
    if (concernedTaskId == MAX_UINT16_NUM) {
        RT_LOG(RT_LOG_INFO, "device_id=%d, stream_id=%d, task_id=%u has been completed, no concerned cqe.",
               device_->Id_(), streamId_, syncTaskId);
        return error;
    }
    error = WaitConcernedTaskRecycled(concernedTaskId, beginTime, timeout);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "failed, stream_id=%d, error=0x%x", Id_(), error);
    RT_LOG(RT_LOG_INFO, "device_id=%d, stream_id=%d, task_id=%u has been completed, concerned task_id=%u has been recycled.",
           device_->Id_(), streamId_, syncTaskId, concernedTaskId);
    return error;
}

rtError_t Stream::Synchronize(const bool isNeedWaitSyncCq, int32_t timeout)
{
    rtError_t error = RT_ERROR_NONE;
    if (device_->IsStarsPlatform()) {
        if (!IsSeparateSendAndRecycle() || GetBindFlag()) {
            error = StarsWaitForTask(lastTaskId_, isNeedWaitSyncCq, timeout);
        } else {
            error = SynchronizeImpl(static_cast<uint16_t>(lastTaskId_), latestConcernedTaskId.Value(), timeout);
        }
        if (context_ != nullptr) {
            context_->PopContextErrMsg();
        }
        return GetSynchronizeError(error);
    }

    if (Runtime::Instance()->GetDisableThread()) {
        error = WaitForTask(lastTaskId_, isNeedWaitSyncCq, timeout);
        return GetSynchronizeError(error);
    }
    COND_RETURN_ERROR((GetFailureMode() == ABORT_ON_FAILURE), GetError(),
        "stream_id=%u is ABORT, Synchronize return", Id_());

    Event *event = new (std::nothrow) Event(device_, RT_EVENT_DEFAULT, Context_(), true);
    NULL_PTR_RETURN_MSG(event, RT_ERROR_EVENT_NEW);
    uint32_t tryCount = 50U;

    while (tryCount > 0U) {
        error = event->Record(this);
        if (error == RT_ERROR_NONE) {
            break;
        }
        tryCount--;
    }
    ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Failed to record, retCode=%#x.", static_cast<uint32_t>(error));
    error = event->Synchronize(timeout);
    error = (error == RT_ERROR_EVENT_SYNC_TIMEOUT) ? RT_ERROR_STREAM_SYNC_TIMEOUT : error;
#ifndef CFG_DEV_PLATFORM_PC
    ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Synchronize event failed, retCode=%#x.", static_cast<uint32_t>(error));
#else
    if (error != RT_ERROR_NONE) {
        goto ERROR_FREE;
    }
#endif
    TryToFreeEventIdAndDestroyEvent(&event, event->EventId_(), true);
    if (fftsMemAllocCnt != fftsMemFreeCnt) {
        RT_LOG(RT_LOG_ERROR, "fftsMemAllocCnt=%u, fftsMemAllocCnt=%u.", fftsMemAllocCnt, fftsMemFreeCnt);
    }
    error = GetError();

    return error;
ERROR_FREE:
    TryToFreeEventIdAndDestroyEvent(&event, event->EventId_(), true);
    return error;
}

void Stream::StreamSyncFinishReport() const
{
    Profiler * const profilerPtr = Runtime::Instance()->Profiler_();
    if (profilerPtr != nullptr) {
        profilerPtr->ReportStreamSynctaskFinish(RT_PROF_API_STREAM_SYNC_TASK_FINISH);
    }
}

rtError_t Stream::Query(void) const
{
    rtError_t error = RT_ERROR_NONE;
    COND_RETURN_ERROR_MSG_INNER(GetBindFlag(), RT_ERROR_FEATURE_NOT_SUPPORT,
        "Sink stream does not support stream query, stream_id=%d.", this->Id_());

    // Sending and receiving thread will update pendingNum_
    if (!Runtime::Instance()->GetDisableThread()) {
        return (pendingNum_.Value() == 0U) ? RT_ERROR_NONE : RT_ERROR_STREAM_NOT_COMPLETE;
    }

    // Check whether the tasks are complete
    if (device_->IsStarsPlatform()) {
        uint16_t sqHead = 0U;
        uint16_t sqTail = 0U;
        error = device_->Driver_()->GetSqHead(device_->Id_(), device_->DevGetTsId(), this->GetSqId(), sqHead);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE,
            RT_ERROR_STREAM_NOT_COMPLETE, "Query sq head failed, retCode=%#x", static_cast<uint32_t>(error));
        error = device_->Driver_()->GetSqTail(device_->Id_(), device_->DevGetTsId(), this->GetSqId(), sqTail);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE,
            RT_ERROR_STREAM_NOT_COMPLETE, "Query sq tail failed, retCode=%#x", static_cast<uint32_t>(error));
        if (sqHead != sqTail) {
            RT_LOG(RT_LOG_DEBUG, "Task not complete, stream_id=%d, sqHead=%hu, sqTail=%hu",
                this->Id_(), sqHead, sqTail);
            return RT_ERROR_STREAM_NOT_COMPLETE;
        }
    } else {
        uint32_t latestTskId = 0U;
        error = device_->QueryLatestTaskId(static_cast<uint32_t>(streamId_), latestTskId);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE,
            RT_ERROR_STREAM_NOT_COMPLETE, "Query task id failed, retCode=%#x.", static_cast<uint32_t>(error));
        if ((latestTskId == UINT32_MAX) || (latestTskId != lastTaskId_)) {
            RT_LOG(RT_LOG_DEBUG, "Task not complete or query a invalid id,"
                " stream_id=%d, latestTskId=%u, lastTaskId_=%u", this->Id_(), latestTskId, lastTaskId_);
            return RT_ERROR_STREAM_NOT_COMPLETE;
        }
    }
    return RT_ERROR_NONE;
}

rtError_t Stream::KernelFusionStart()
{
    fusioning_ = true;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *tsk = AllocTask(&submitTask, TS_TASK_TYPE_FUSION_ISSUE, errorReason);
    NULL_PTR_RETURN_MSG(tsk, errorReason);

    rtError_t error = KernelFusionTaskInit(tsk, FUSION_START);
    ERROR_GOTO_MSG_INNER(error, RECYCLE, "Init kernel fusion task failed, retCode=%#x.", static_cast<uint32_t>(error));
    error = device_->SubmitTask(tsk, (context_ != nullptr) ? context_->TaskGenCallback_() : nullptr);
    ERROR_GOTO_MSG_INNER(error, RECYCLE, "Submit kernel fusion task failed, retCode=%#x.", static_cast<uint32_t>(error));

    return RT_ERROR_NONE;

RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(tsk);
    fusioning_ = false;
    return error;
}

rtError_t Stream::KernelFusionEnd()
{
    if (!fusioning_) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR,
            "Run kernel fusion end failed, probably rtKernelFusionStart has not been called");
        return RT_ERROR_STREAM_FUSION;
    }

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *tsk = AllocTask(&submitTask, TS_TASK_TYPE_FUSION_ISSUE, errorReason);
    NULL_PTR_RETURN_MSG(tsk, errorReason);

    rtError_t error = KernelFusionTaskInit(tsk, FUSION_END);
    ERROR_GOTO_MSG_INNER(error, RECYCLE, "Init kernel fusion task failed, retCode=%#x.", static_cast<uint32_t>(error));
    error = device_->SubmitTask(tsk, (context_ != nullptr) ? context_->TaskGenCallback_() : nullptr);
    ERROR_GOTO_MSG_INNER(error, RECYCLE, "Submit kernel fusion task failed, retCode=%#x.", static_cast<uint32_t>(error));

    fusioning_ = false;

    return RT_ERROR_NONE;

RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(tsk);
    return error;
}

rtError_t Stream::FreePersistentTaskID(TaskAllocator * const tskAllocator)
{
    const rtError_t error = RT_ERROR_NONE;
    NULL_PTR_RETURN_MSG(tskAllocator, RT_ERROR_TASK_ALLOCATOR);
    const std::lock_guard<std::mutex> stmLock(persistentTaskMutex_);
    while (!persistentTaskid_.empty()) {
        tskAllocator->FreeById(this, static_cast<int32_t>(persistentTaskid_.back()), true);
        persistentTaskid_.pop_back();
    }
    return error;
}

void Stream::FreePersistentTaskID(const Stream * const exeStream)
{
    if (device_ == nullptr) {
        return;
    }
    TaskFactory * const taskGenerator = device_->GetTaskFactory();
    if ((exeStream != this) && (taskGenerator != nullptr) && (taskGenerator->GetAllocator() != nullptr)) {
        const rtError_t error = this->FreePersistentTaskID(taskGenerator->GetAllocator());
        COND_LOG_ERROR(error != RT_ERROR_NONE, "After teardown FreePersistentTaskID failed, retCode=%#x.", error);
    }
}

bool Stream::NeedSaveTask(const TaskInfo * const tsk) const
{
    if (((flags_ & RT_STREAM_AICPU) != 0U) && (tsk != nullptr)) {
        const tsTaskType_t type = tsk->type;
        if ((type == TS_TASK_TYPE_ACTIVE_AICPU_STREAM) || (type == TS_TASK_TYPE_KERNEL_AICPU)
            || (type == TS_TASK_TYPE_MODEL_END_GRAPH)) {
            const uint32_t modelId = static_cast<uint32_t>(Id_());
            const uint16_t taskId = tsk->id;
            RT_LOG(RT_LOG_DEBUG, "need save task data, stream_id=%d, task_id=%u, task_type=%d(%s)",
                modelId, static_cast<uint32_t>(taskId), static_cast<int32_t>(type), tsk->typeName);
            return true;
        }
    }
    return false;
}

bool Stream::NeedDelSelfStream(void) const
{
    return (((flags_ & RT_STREAM_FORBIDDEN_DEFAULT) != 0U) || ((flags_ & RT_STREAM_AICPU) != 0U));
}

uint32_t Stream::GetCbRptCqid() const
{
    uint32_t tmpCqId = 0U;
    Runtime * const rt = Runtime::Instance();
    (void)rt->GetCqIdByStreamId(device_->Id_(), streamId_, &tmpCqId);
    return tmpCqId;
}

uint32_t Stream::GetCbGrpId() const
{
    uint32_t grpId = 0U;
    Runtime * const rt = Runtime::Instance();
    (void)rt->GetGroupIdByStreamId(device_->Id_(), streamId_, &grpId);
    return grpId;
}

bool Stream::IsHostFuncCbReg()
{
    return Runtime::Instance()->IsHostFuncCbReg(this);
}

bool Stream::IsDavinciTask(const TaskInfo * const tsk) const
{
    const tsTaskType_t tskType = tsk->type;
    if ((tskType == TS_TASK_TYPE_KERNEL_AICORE) || (tskType == TS_TASK_TYPE_KERNEL_AICPU) ||
        (tskType == TS_TASK_TYPE_KERNEL_AIVEC)) {
        return true;
    }
    return false;
}

bool Stream::IsFusionKernelTask(const TaskInfo * const tsk) const
{
    return (tsk->type == TS_TASK_TYPE_FUSION_KERNEL) ? true : false;
}

// add task to taskPublicBuff_ or davinciTaskList_
rtError_t Stream::AddTaskToList(const TaskInfo * const tsk)
{
    if (isSupportASyncRecycle_ && (!IsNeedPostProc(tsk))) {
        if (isHasPcieBar_) {
            /* support O(n) -- O(1) */
            return RT_ERROR_NONE;
        }

        const std::lock_guard<std::mutex> stmLock(davinciTaskMutex_);
        COND_RETURN_WARN(davinciTaskHead_ == ((davinciTaskTail_ + 1U) % davinciTaskListSize_),
            RT_ERROR_STREAM_FULL, "davinci task list is full, stream_id=%d, task_id=%u, tail=%u",
            streamId_, tsk->id, davinciTaskTail_);
            davinciTaskList_[davinciTaskTail_ % davinciTaskListSize_] = tsk->id;
            davinciTaskTail_ = ((davinciTaskTail_ + 1U) % davinciTaskListSize_);
    } else {
        const std::lock_guard<std::mutex> stmLock(publicTaskMutex_);
        COND_RETURN_WARN(taskHead_ == ((taskTail_ + 1U) % taskPublicBuffSize_),
            RT_ERROR_STREAM_FULL, "task public buff full, stream_id=%d, task_id=%hu, tail=%u",
            streamId_, tsk->id, taskTail_);
            taskPublicBuff_[taskTail_ % taskPublicBuffSize_] = tsk->id;
            taskTail_ = ((taskTail_ + 1U) % taskPublicBuffSize_);
    }

    return RT_ERROR_NONE;
}

rtError_t Stream::AddTaskToStream(const TaskInfo * const tsk)
{
    NULL_PTR_RETURN_MSG(tsk, RT_ERROR_TASK_NULL);
    ZERO_RETURN_MSG(taskPublicBuffSize_);
    if (static_cast<bool>(tsk->bindFlag)) {
        COND_RETURN_WARN(taskPersistentHead_.Value() == ((taskPersistentTail_.Value() + 1U) % STREAM_TASK_BUFF_SIZE),
            RT_ERROR_STREAM_FULL, "task persistent buff full, stream_id=%d, task_id=%hu, tail=%u",
            streamId_, tsk->id, taskPersistentTail_.Value());
        taskPersistentBuff_[taskPersistentTail_.Value() % STREAM_TASK_BUFF_SIZE] = tsk->id;
        taskPersistentTail_.Set((taskPersistentTail_.Value() + 1U) % STREAM_TASK_BUFF_SIZE);
        delayRecycleTaskid_.push_back(tsk->id);
        RT_LOG(RT_LOG_INFO, "persistent task, stream_id=%d, task_id=%hu, task_type=%d (%s), "
            "head=%u, tail=%u, delay recycle task num=%zu.",
            streamId_, tsk->id, static_cast<int32_t>(tsk->type), tsk->typeName,
            taskPersistentHead_.Value(), taskPersistentTail_.Value(),
            delayRecycleTaskid_.size());
    } else {
        const rtError_t ret = AddTaskToList(tsk);
        COND_RETURN_WITH_NOLOG((ret != RT_ERROR_NONE), ret);
    }

    SetLastTaskId(static_cast<uint32_t>(tsk->id));
    return RT_ERROR_NONE;
}

//  erase the stream which only bind model without loading anything when unbind model
void Stream::EraseCacheStream()
{
    if (delayRecycleTaskid_.empty()) {
        Profiler * const profilerPtr = Runtime::Instance()->Profiler_();
        if (profilerPtr != nullptr) {
            profilerPtr->EraseStream(this);
        }
    }
}

// insert stream when bind model
void Stream::InsertCacheStream()
{
    Profiler * const profilerPtr = Runtime::Instance()->Profiler_();
    if (profilerPtr != nullptr) {
        profilerPtr->InsertStream(this);
    }
}

const std::list<uint16_t> &Stream::GetCacheTrackTaskList() const
{
    return cacheTrackTaskid_;
}

void Stream::SetMaxTaskId(const bool isDisableThread)
{
    UNUSED(isDisableThread);
    maxTaskId_ = static_cast<uint16_t>(MAX_UINT16_NUM - 1U);
    RT_LOG(RT_LOG_DEBUG, "SetMaxTaskId, maxTaskId_=%hu", maxTaskId_);
}

rtError_t Stream::ProcFlipTask(TaskInfo *&tsk, uint16_t flipNum)
{
    rtError_t errorReason;
    TaskInfo *rtFlipTask = AllocTask(tsk, TS_TASK_TYPE_FLIP, errorReason, 1U, UpdateTaskFlag::NOT_SUPPORT_AND_SKIP);
    NULL_PTR_RETURN_MSG(rtFlipTask, errorReason);
    tsk = rtFlipTask;

    FlipTaskInit(rtFlipTask, flipNum);
    return RT_ERROR_NONE;
}

bool Stream::IsNeedSendFlipTask(uint16_t preTaskId)
{
    RT_LOG(RT_LOG_DEBUG, "IsNeedSendFlipTask, preTaskId=%hu, maxTaskId=%hu, trackProfFlag=%d, isCtrlStream_=%d, isTsSupport=%d.",
        preTaskId, GetMaxTaskId(), Runtime::Instance()->GetTrackProfFlag(), isCtrlStream_, device_->IsSupportTsVersionForFlipTask());
    if (preTaskId != GetMaxTaskId()) {
        return false;
    }

    if (Runtime::Instance()->GetTrackProfFlag()) {
        const bool isTsSupport = device_->IsSupportTsVersionForFlipTask();
        RT_LOG(RT_LOG_INFO, "IsNeedSendFlipTask, isCtrlStream_=%d, isTsSupport=%d.", isCtrlStream_, isTsSupport);
        if (!isCtrlStream_ && isTsSupport) {
            return true;
        }
    }

    return false;
}

void Stream::ReportDestroyFlipTask()
{
    if (!IsNeedSendFlipTask(GetMaxTaskId())) {
        return;
    }

    Profiler *profilerPtr = Runtime::Instance()->Profiler_();
    if (profilerPtr != nullptr) {
        profilerPtr->ReportDestroyFlipTask(this, device_->Id_());
    }
    return;
}

rtError_t Stream::TryDelRecordedTask(const bool isTaskBind, const uint16_t tailTaskId)
{
    ZERO_RETURN_MSG(taskPublicBuffSize_);
    const std::lock_guard<std::mutex> stmLock(publicTaskMutex_);
    if (Runtime::Instance()->GetDisableThread() && (taskHead_ != taskTail_)) {
        const uint32_t fixTaskId = taskPublicBuff_[taskHead_ % taskPublicBuffSize_];
        const uint16_t relTaskId = static_cast<uint16_t>(fixTaskId & 0xFFFFU);
        if (TASK_ID_GT(relTaskId, tailTaskId)) {
            RT_LOG(RT_LOG_DEBUG, "delTaskId is greater than tailTaskId, stream_id=%d, tailTaskId=%u, relTaskId=%u,"
                " head=%u, tail=%u", streamId_, static_cast<uint32_t>(tailTaskId), static_cast<uint32_t>(relTaskId),
                taskHead_, taskTail_);
            return RT_ERROR_STREAM_INVALID;
        }

        taskHead_ = ((taskHead_ + 1U) % taskPublicBuffSize_);
        earlyRecycleTaskHead_ = (taskHead_ % STREAM_PUBLIC_TASK_BUFF_SIZE);
        RT_LOG(RT_LOG_DEBUG, "del public task from stream, stream_id=%d, tailTaskId=%u, delTaskId=%u, head=%u, tail=%u",
            streamId_, static_cast<uint32_t>(tailTaskId), static_cast<uint32_t>(relTaskId),
            taskHead_, taskTail_);
        finishTaskId_ = relTaskId;
        return RT_ERROR_NONE;
    }

    uint16_t delTaskId;

    if (isTaskBind) {
        if (taskPersistentHead_.Value() == taskPersistentTail_.Value()) {
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "Task persistent buff null, stream_id=%d, task_id=%u, head=%u, tail=%u",
                streamId_, static_cast<uint32_t>(tailTaskId), taskPersistentHead_.Value(),
                taskPersistentTail_.Value());
            return RT_ERROR_STREAM_EMPTY;
        }
        delTaskId = taskPersistentBuff_[taskPersistentHead_.Value() % STREAM_TASK_BUFF_SIZE];
        taskPersistentHead_.Set((taskPersistentHead_.Value() + 1U) % STREAM_TASK_BUFF_SIZE);
        RT_LOG(RT_LOG_DEBUG, "del persistent task from stream, stream_id=%d, tailTaskId=%u, delTaskId=%hu, "
            "head=%u, tail=%u", streamId_, static_cast<uint32_t>(tailTaskId), delTaskId,
            taskPersistentHead_.Value(), taskPersistentTail_.Value());
    } else {
        if (taskHead_ == taskTail_) {
            RT_LOG(RT_LOG_DEBUG, "task public buff null, stream_id=%d, task_id=%u, head=%u, tail=%u",
                streamId_, static_cast<uint32_t>(tailTaskId), taskHead_, taskTail_);
            return RT_ERROR_STREAM_EMPTY;
        }
        delTaskId = static_cast<uint16_t>(taskPublicBuff_[taskHead_ % taskPublicBuffSize_]);
        taskHead_ = ((taskHead_ + 1U) % taskPublicBuffSize_);
        earlyRecycleTaskHead_ = (taskHead_ % STREAM_PUBLIC_TASK_BUFF_SIZE);
        RT_LOG(RT_LOG_DEBUG, "del public task from stream, stream_id=%d, tailTaskId=%u, delTaskId=%hu, "
            "head=%u, tail=%u", streamId_, static_cast<uint32_t>(tailTaskId), delTaskId,
            taskHead_, taskTail_);
    }

    finishTaskId_ = delTaskId;
    return RT_ERROR_NONE;
}

rtError_t Stream::GetPublicTaskHead(const bool isTaskBind, const uint16_t tailTaskId, uint16_t * const delTaskId)
{
    NULL_PTR_RETURN_MSG(delTaskId, RT_ERROR_TASK_NULL);
    ZERO_RETURN_MSG(taskPublicBuffSize_);
    const std::lock_guard<std::mutex> stmLock(publicTaskMutex_);
    if (Runtime::Instance()->GetDisableThread() && (taskHead_ != taskTail_)) {
        const uint32_t fixTaskId = taskPublicBuff_[taskHead_ % taskPublicBuffSize_];
        const uint16_t relTaskId = static_cast<uint16_t>(fixTaskId & 0xFFFFU);
        if (TASK_ID_GT(relTaskId, tailTaskId)) {
            RT_LOG(RT_LOG_DEBUG, "delTaskId is greater than tailTaskId, stream_id=%d, tailTaskId=%u, relTaskId=%u,"
                " head=%u, tail=%u", streamId_, static_cast<uint32_t>(tailTaskId), static_cast<uint32_t>(relTaskId),
                taskHead_, taskTail_);
            return RT_ERROR_STREAM_INVALID;
        }
        *delTaskId = relTaskId;
        return RT_ERROR_NONE;
    }

    if (isTaskBind) {
        if (taskPersistentHead_.Value() == taskPersistentTail_.Value()) {
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "Task persistent buff null, stream_id=%d, task_id=%u, head=%u, tail=%u",
                streamId_, static_cast<uint32_t>(tailTaskId), taskPersistentHead_.Value(),
                taskPersistentTail_.Value());
            return RT_ERROR_STREAM_EMPTY;
        }
        *delTaskId = taskPersistentBuff_[taskPersistentHead_.Value() % STREAM_TASK_BUFF_SIZE];
    } else {
        if (taskHead_ == taskTail_) {
            RT_LOG(RT_LOG_DEBUG, "task public buff null, stream_id=%d, task_id=%u, head=%u, tail=%u",
                streamId_, static_cast<uint32_t>(tailTaskId), taskHead_, taskTail_);
            return RT_ERROR_STREAM_EMPTY;
        }
        *delTaskId = taskPublicBuff_[taskHead_ % taskPublicBuffSize_];
    }

    return RT_ERROR_NONE;
}

rtError_t Stream::TryDelDavinciRecordedTask(const uint16_t tailTaskId, uint16_t * const delTaskId)
{
    if (!Runtime::Instance()->GetDisableThread()) {
        return RT_ERROR_STREAM_EMPTY;
    }

    NULL_PTR_RETURN_MSG(delTaskId, RT_ERROR_TASK_NULL);
    if (davinciTaskListSize_ == 0U) {
        return RT_ERROR_STREAM_EMPTY;
    }

    const std::lock_guard<std::mutex> stmLock(davinciTaskMutex_);
    if (davinciTaskHead_ != davinciTaskTail_) {
        const uint32_t fixTaskId = davinciTaskList_[davinciTaskHead_ % davinciTaskListSize_];
        const uint16_t relTaskId = static_cast<uint16_t>(fixTaskId & 0xFFFFU);
        if (TASK_ID_GT(relTaskId, tailTaskId)) {
            RT_LOG(RT_LOG_DEBUG, "delTaskId is greater than tailTaskId, stream_id=%d, tailTaskId=%u, relTaskId=%u,"
                " head=%u, tail=%u", streamId_, static_cast<uint32_t>(tailTaskId), static_cast<uint32_t>(relTaskId),
                davinciTaskHead_, davinciTaskTail_);
            return RT_ERROR_STREAM_INVALID;
        }

        *delTaskId = relTaskId;
        davinciTaskHead_ = ((davinciTaskHead_ + 1U) % davinciTaskListSize_);
        RT_LOG(RT_LOG_DEBUG, "del public task from stream, stream_id=%d, tailTaskId=%u, delTaskId=%u, head=%u, tail=%u",
            streamId_, static_cast<uint32_t>(tailTaskId), static_cast<uint32_t>(relTaskId),
            davinciTaskHead_, davinciTaskTail_);
        finishTaskId_ = relTaskId;
        return RT_ERROR_NONE;
    } else {
        RT_LOG(RT_LOG_DEBUG, "davinci task list null, stream_id=%d, task_id=%u, head=%u, tail=%u",
            streamId_, static_cast<uint32_t>(tailTaskId), davinciTaskHead_, davinciTaskTail_);
        return RT_ERROR_STREAM_EMPTY;
    }
}

TIMESTAMP_EXTERN(BatchDelDavinciRecordedTask);
void Stream::BatchDelDavinciRecordedTask(const uint16_t tailTaskId, const uint32_t davinciTaskNum)
{
    if ((!Runtime::Instance()->GetDisableThread())) {
        return;
    }

    TIMESTAMP_BEGIN(BatchDelDavinciRecordedTask);
    pendingNum_.Sub(davinciTaskNum);
    finishTaskId_ = tailTaskId;
    RT_LOG(RT_LOG_DEBUG, "batch del davinci task from stream, stream_id=%d, tailTaskId=%u,"
        " finishTaskId=%u, recycleTaskNum=%u.",
        streamId_, static_cast<uint32_t>(tailTaskId), finishTaskId_, davinciTaskNum);

    TIMESTAMP_END(BatchDelDavinciRecordedTask);
    return;
}

int32_t Stream::GetRecycleTaskHeadId(const uint16_t tailTaskId, uint16_t &recycleTaskId)
{
    const std::lock_guard<std::mutex> stmLock(publicTaskMutex_);
    if (earlyRecycleTaskHead_ != taskTail_) {
        recycleTaskId = taskPublicBuff_[earlyRecycleTaskHead_ % STREAM_PUBLIC_TASK_BUFF_SIZE];
        earlyRecycleTaskHead_ = ((earlyRecycleTaskHead_ + 1U) % STREAM_PUBLIC_TASK_BUFF_SIZE);
        RT_LOG(RT_LOG_INFO, "get task headId from stream, stream_id=%d, tailTaskId=%u, TaskId=%u, head=%u, tail=%u",
            streamId_, static_cast<uint32_t>(tailTaskId), static_cast<uint32_t>(recycleTaskId),
            earlyRecycleTaskHead_, taskTail_);
    } else {
        RT_LOG(RT_LOG_INFO, "earlyRecycleTaskHead_ value is equal taskTail_[%u]", static_cast<uint32_t>(tailTaskId));
        return RT_ERROR_STREAM_EMPTY;
    }
    return RT_ERROR_NONE;
}

void Stream::ClearTaskCount(const bool isTaskBind)
{
    if (isTaskBind) {
        countingPersistentNum_.Set(0U);
    } else {
        countingNum_.Set(0U);
    }
}

uint8_t Stream::GetTaskRevFlag(const bool isTaskBind)
{
    if (isTaskBind) {
        if (((countingPersistentNum_.Value() + 1U) % TASK_NO_SEND_CQ_MAX) == 0U ||
            IsPersistentTaskFull()) {
            countingPersistentNum_.Set(0U);
            RT_LOG(RT_LOG_INFO, "set recv cq flag when persistent task count=%u, isPersistentTaskFull=%u",
                TASK_NO_SEND_CQ_MAX, IsPersistentTaskFull());
            return TASK_NEED_SEND_CQ;
        } else {
            countingPersistentNum_.Add(1U);
            return TASK_NO_SEND_CQ;
        }
    } else {
        if (((countingNum_.Value() + 1U) % TASK_NO_SEND_CQ_MAX) == 0U) {
            countingNum_.Set(0U);
            RT_LOG(RT_LOG_INFO, "set recv cq flag when public task count=%u", TASK_NO_SEND_CQ_MAX);
            return TASK_NEED_SEND_CQ;
        } else {
            countingNum_.Add(1U);
            return TASK_NO_SEND_CQ;
        }
    }
}

void Stream::StreamLock()
{
    streamMutex_.lock();
}

void Stream::StreamUnLock()
{
    streamMutex_.unlock();
}

void Stream::StreamSyncLock()
{
    streamSyncMutex_.lock();
}

bool Stream::StreamSyncTryLock(uint64_t time)
{
    return streamSyncMutex_.try_lock_for(std::chrono::milliseconds(time));
}

void Stream::StreamSyncUnLock()
{
    streamSyncMutex_.unlock();
}

void Stream::StreamRecycleLock()
{
    recycleMutex_.lock();
}

void Stream::StreamRecycleUnlock()
{
    recycleMutex_.unlock();
}

rtError_t Stream::AcquireTimeline(uint64_t &base, uint32_t &offset)
{
    constexpr uint32_t maxTimelineNum = 512U;   // 4K.

    const std::lock_guard<std::mutex> timelineLock(timelineMutex_);
    if (timelineAddr_ == nullptr) {
        Driver * const devDrv = device_->Driver_();
        constexpr uint32_t maxTimelineSize = maxTimelineNum * sizeof(uint64_t);
        Runtime * const rtInstance = Runtime::Instance();
        const rtMemType_t memType = rtInstance->GetTsMemType(MEM_REQUEST_FEATURE_DEFAULT, maxTimelineSize);
        rtError_t error = devDrv->DevMemAlloc(RtPtrToPtr<void **>(&timelineAddr_),
            maxTimelineSize, memType, device_->Id_());
        ERROR_RETURN(error, "Malloc timeline buffer failed, type=%u, error=%#x",
            static_cast<uint32_t>(memType), static_cast<uint32_t>(error));

        error = devDrv->MemSetSync(timelineAddr_, maxTimelineSize, 0xFFU, maxTimelineSize);
        ERROR_RETURN_MSG_INNER(error, "Memset timeline buffer failed, type=%u, error=%#x",
            static_cast<uint32_t>(memType), static_cast<uint32_t>(error));

        error = devDrv->MemAddressTranslate(static_cast<int32_t>(device_->Id_()),
            RtPtrToValue(timelineAddr_), &timelineBase_);
        ERROR_RETURN_MSG_INNER(error, "Convert address to physical failed! error=%#x", static_cast<uint32_t>(error));
        RT_LOG(RT_LOG_DEBUG, "stream_id=%d, base=%#" PRIx64 "", streamId_, timelineBase_);
    }

    for (uint32_t i = 0U; i < maxTimelineNum; ++i) {
        if (timelineOffset_.count(i) == 0U) {
            base = timelineBase_;
            offset = i;
            (void)timelineOffset_.insert(i);
            RT_LOG(RT_LOG_DEBUG, "Acquire Timeline, stream_id=%d, base=%#" PRIx64 ", offset=%u",
                streamId_, base, offset);
            return RT_ERROR_NONE;
        }
    }

    RT_LOG(RT_LOG_INFO, "Too much timeline in use, max count=%u", maxTimelineNum);
    return RT_ERROR_DEVICE_LIMIT;
}

rtError_t Stream::ReleaseTimeline(const uint64_t base, const uint32_t offset)
{
    RT_LOG(RT_LOG_DEBUG, "Release Timeline, stream_id=%d, base=%#" PRIx64 ", offset=%u.", streamId_, base, offset);
    const std::lock_guard<std::mutex> timelineLock(timelineMutex_);
    if (base != timelineBase_) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Release timeline failed, base=%#" PRIx64 " is invalid, valid value=%#" PRIx64,
            base, timelineBase_);
        return RT_ERROR_INVALID_VALUE;
    }

    const auto it = timelineOffset_.find(offset);
    if (it == timelineOffset_.end()) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Timeline offset=%u is invalid", offset);
        return RT_ERROR_INVALID_VALUE;
    }

    (void)timelineOffset_.erase(it);
    return RT_ERROR_NONE;
}

uint64_t Stream::GetTimelineValue(const uint64_t base, const uint32_t offset)
{
    uint64_t val = 0U;
    if (base != timelineBase_) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Get timeline failed, base=%#" PRIx64 " is invalid, valid value=%#" PRIx64,
            base, timelineBase_);
        return val;
    }

    const std::lock_guard<std::mutex> timelineLock(timelineMutex_);
    const auto it = timelineOffset_.find(offset);
    if (it == timelineOffset_.end()) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Timeline offset=%u invalid", offset);
        return val;
    }

    Driver * const dev = device_->Driver_();
    const rtError_t error = dev->MemCopySync(&val, sizeof(uint64_t), timelineAddr_ + offset, sizeof(uint64_t),
                                             RT_MEMCPY_DEVICE_TO_HOST);
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Copy Timeline failed, error=%#x", static_cast<uint32_t>(error));
        return val;
    }

    RT_LOG(RT_LOG_DEBUG, "Timeline stream_id=%u, base=%#" PRIx64 ", offset=%u, value=%#" PRIx64,
        streamId_, base, offset, val);
    return val;
}

void Stream::SetStreamMark(const TaskInfo * const tsk)
{
    if (IsTaskSink()) {
        return;
    }

    // Record half event record.
    const std::lock_guard<std::mutex> stmLock(streamMutex_);
    if (tsk->type == TS_TASK_TYPE_EVENT_RECORD) {
        lastEventId_ = tsk->id;
    }
}

bool Stream::IsTaskLimited(const TaskInfo * const tsk)
{
    UNUSED(tsk);
    if (IsTaskSink()) {
        return (pendingNum_.Value() > RT_MAX_TASK_NUM);
    }

    uint32_t pendingMaxValue = taskPublicBuffSize_ - 1U;
    if ((device_->GetTschVersion() < TS_VERSION_SUPPORT_STREAM_TASK_FULL) ||
        ((device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_STREAM_PENGING_HALF_DEEPTH)) &&
         (GetFailureMode() != ABORT_ON_FAILURE))) {
        pendingMaxValue = RT_HALF_TASK_NUM;
    }
    if (pendingNum_.Value() < pendingMaxValue) {
        return false;
    }

    RT_LOG(RT_LOG_DEBUG, "Sending task is limited, stream_id=%d, pendingNum=%u", streamId_, pendingNum_.Value());

    return true;      // Event not happen, need wait.
}

rtError_t Stream::ProcRecordTask(TaskInfo *&tsk)
{
    const std::lock_guard<std::mutex> stmLock(streamMutex_);
    rtError_t error = RT_ERROR_NONE;
    rtError_t errorReason;
    if (lastHalfRecord_ == nullptr) {
        lastHalfRecord_ = new (std::nothrow) Event(device_, RT_EVENT_STREAM_MARK, Context_(), true);
        NULL_PTR_RETURN_MSG(lastHalfRecord_, RT_ERROR_EVENT_NEW);
        error = lastHalfRecord_->GenEventId();
        COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, DELETE_O(lastHalfRecord_), "Gen event id failed");
    }

    TaskInfo *eventRecordTsk = AllocTask(tsk, TS_TASK_TYPE_EVENT_RECORD, errorReason);
    COND_PROC_RETURN_ERROR(eventRecordTsk == nullptr, errorReason, DELETE_O(lastHalfRecord_),
                           "Task new failed");
    tsk = eventRecordTsk;

    error = EventRecordTaskInit(eventRecordTsk, lastHalfRecord_, true, lastHalfRecord_->EventId_());
    ERROR_GOTO_MSG_INNER(error, ERROR_TASK, "Failed to init event record task.");

    return RT_ERROR_NONE;

ERROR_TASK:
    if (lastHalfRecord_ != nullptr) {
        lastHalfRecord_->DeleteRecordResetFromMap(tsk);
        lastHalfRecord_->EventIdCountSub(lastHalfRecord_->EventId_());
    }
    (void)device_->GetTaskFactory()->Recycle(eventRecordTsk);
    RT_LOG_INNER_MSG(RT_LOG_ERROR, "Stream setup failed, stream_id=%d", streamId_);
    return error;
}

bool Stream::IsWaitFinish(const uint32_t finishedTaskId, const uint32_t submittedTaskId)
{
    return (finishedTaskId != UINT16_MAX) && TASK_ID_GEQ(finishedTaskId, submittedTaskId);
}

rtError_t Stream::WaitTask(bool const isReclaim, const uint32_t taskId, const int32_t timeout)
{
    if (IsSeparateSendAndRecycle()) {
        return SynchronizeImpl(static_cast<uint16_t>(taskId), static_cast<uint16_t>(taskId), timeout);
    }
    rtError_t error = RT_ERROR_NONE;
    uint32_t currId = UINT16_MAX;
    mmTimespec beginTimeSpec;
    mmTimespec endTimeSpec;
    uint64_t beginCnt;
    uint64_t endCnt;
    uint64_t count;
    const uint32_t deviceId = device_->Id_();

    RT_LOG(RT_LOG_INFO, "Begin wait task, device_id=%u, stream_id=%d, task_id=%u, finish_task_id=%u, last_task_id=%u",
        deviceId, streamId_, taskId, finishTaskId_, lastTaskId_);

    beginTimeSpec = mmGetTickCount();
    beginCnt = static_cast<uint64_t>(beginTimeSpec.tv_sec) * RT_MS_PER_S +
               static_cast<uint64_t>(beginTimeSpec.tv_nsec) / RT_MS_TO_NS;
    int32_t remainTime = timeout;
    while (streamStopSyncFlag_) {
        if (isReclaim) {
            StreamSyncLock();
            this->SetSyncRemainTime(remainTime);
            if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
                error = TaskReclaimByStream(this, false);
                currId = static_cast<uint32_t>(GetRecycleEndTaskId());
            } else {
                error = device_->TaskReclaim(static_cast<uint32_t>(streamId_), false, currId);
            }
            this->SetSyncRemainTime(-1);
            StreamSyncUnLock();
            COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
                "Query Task status failed, retCode=%#x.", static_cast<uint32_t>(error));
        } else {
            error = GetLastFinishTaskId(taskId, currId, timeout);
            COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Get finish TaskId failed, retCode=%#x.", static_cast<uint32_t>(error));
        }

        if (IsWaitFinish(currId, taskId)) { // Event occurred.
            RT_LOG(RT_LOG_DEBUG, "Wait finish, device_id=%u, stream_id=%d, task_id=%u, current_id=%u",
                deviceId, streamId_, taskId, currId);
            return RT_ERROR_NONE;
        }
        if (abortStatus_ ==  RT_ERROR_STREAM_ABORT) {
            RT_LOG(RT_LOG_ERROR, "stream status is stream abort");
            return RT_ERROR_STREAM_ABORT;
        }
        error = CheckContextStatus();
        COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "context is abort, status=%#x.", static_cast<int32_t>(error));

        if ((currId != UINT32_MAX) && TASK_ID_LT(TASK_ID_ADD(currId, RT_SYNC_SLEEP_INTERVAL), taskId)) {
            (void)mmSleep(1U);
        }

        if (timeout > 0) {
            endTimeSpec = mmGetTickCount();
            endCnt = static_cast<uint64_t>(endTimeSpec.tv_sec) * 1000UL +
                     static_cast<uint64_t>(endTimeSpec.tv_nsec) / RT_MS_TO_NS;
            count = endCnt > beginCnt ? (endCnt - beginCnt) : 0;
            if (count >= static_cast<uint64_t>(timeout)) {
                RT_LOG(RT_LOG_ERROR, "stream sync timeout, device_id=%u, stream_id=%d, time=%lums, timeout=%dms",
                    deviceId, streamId_, count, timeout);
                return RT_ERROR_STREAM_SYNC_TIMEOUT;
            }
            remainTime = (timeout - static_cast<int32_t>(count));
        }
    }
    return RT_ERROR_NONE;
}

rtError_t Stream::QueryWaitTask(bool &isWaitFlag, const uint32_t taskId)
{
    isWaitFlag = false;
    uint32_t currId = 0U;
    rtError_t error = RT_ERROR_NONE;

    RT_LOG(RT_LOG_DEBUG, "Begin query wait task, stream_id=%d, task_id=%u, finish_task_id=%u, last_task_id=%u",
           streamId_, taskId, finishTaskId_, lastTaskId_);

    if (device_->IsStarsPlatform()) {
        error = GetLastTaskIdFromRtsq(currId);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_DEBUG, "GetLastTaskIdFromRtsq fail, error=%d", error);
            return RT_ERROR_NONE;
        }
    } else {
        error = device_->QueryLatestTaskId(static_cast<uint32_t>(streamId_), currId);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Query Task status failed, retCode=%#x.", static_cast<uint32_t>(error));
        if (currId == UINT32_MAX) {
            isWaitFlag = false;
            return RT_ERROR_NONE;
        }
    }

    if ((currId != UINT32_MAX) && TASK_ID_GEQ(currId, taskId)) {
        RT_LOG(RT_LOG_DEBUG, "Wait finish, stream_id=%d, task_id=%u, current_id=%u", streamId_, taskId, currId);
        isWaitFlag = true;
    }

    return RT_ERROR_NONE;
}

rtError_t Stream::GetLastTaskIdFromCqShm(uint32_t &lastTaskId)
{
    RT_LOG(RT_LOG_DEBUG, "Begin query task, stream_id=%d, finish_task_id=%u, last_task_id=%u",
           streamId_, finishTaskId_, lastTaskId_);
    if (device_ != nullptr) {
        const rtError_t error = device_->QueryLatestTaskId(static_cast<uint32_t>(streamId_), lastTaskId);
        COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "Query Task status failed.");
    }
    return RT_ERROR_NONE;
}

uint32_t Stream::GetMaxTryCount() const
{
    if (static_cast<rtRunMode>(device_->Driver_()->GetRunMode()) == RT_RUN_MODE_OFFLINE) {
        return RT_QUERY_TIMES_THRESHOLD;
    }

    if (streamFastSync_) {
        if (isModelExcel || isModelComplete || (GetModelNum() != 0)) {
            return RT_QUERY_TIMES_THRESHOLD_20;
        }
        return RT_QUERY_TIMES_THRESHOLD_DC;
    }

    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_STREAM_POLLING_TASK_POSITION_PREFER) &&
        IsSteamNeedFastCq()) {
        return RT_QUERY_TIMES_THRESHOLD_CLOUD_FAST;
    }

    return RT_QUERY_TIMES_THRESHOLD;
}

rtError_t Stream::WaitForTask(const uint32_t taskId, const bool isNeedWaitSyncCq, int32_t timeout)
{
    const uint32_t deviceId = device_->Id_();
    const uint32_t tsId = device_->DevGetTsId();
    uint32_t logicCqId = 0U;
    uint32_t tryCount = 0U;
    constexpr uint16_t perSchedYield = 1000U;
    rtError_t error = RT_ERROR_NONE;
    uint32_t currentId = 0U;

    RT_LOG(RT_LOG_DEBUG, "Begin wait for task, device_id=%u, ts_id=%u, stream_id=%d, task_id=%u, finish_task_id=%u, "
        "last_task_id=%u, timeout=%dms", deviceId, tsId, streamId_, taskId, finishTaskId_, lastTaskId_, timeout);

    const uint32_t maxTryCount = GetMaxTryCount();

    const mmTimespec beginTimeSpec = mmGetTickCount();
    while (!isNeedWaitSyncCq) {
        StreamSyncLock();
#if !(defined(__arm__))
        SetStreamAsyncRecycleFlag(true);
        error = device_->TaskReclaim(static_cast<uint32_t>(streamId_), false, currentId);
        SetStreamAsyncRecycleFlag(false);
#else
        error = device_->TaskReclaim(static_cast<uint32_t>(streamId_), false, currentId);
#endif
        StreamSyncUnLock();
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "Query Task status failed, device_id=%u, ts_id=%u, stream_id=%d, retCode=%#x",
                deviceId, tsId, streamId_, error);
            return error;
        }

        // Event occurred.
        if ((currentId != UINT32_MAX) && TASK_ID_GEQ(currentId, taskId)) {
            StreamSyncFinishReport();
            RT_LOG(RT_LOG_DEBUG, "Wait finish, device_id=%u, ts_id=%u, stream_id=%d, task_id=%u, current_id=%u, "
                "tryCount=%u", deviceId, tsId, streamId_, taskId, currentId, tryCount);
            return RT_ERROR_NONE;
        }

        if (tryCount >= maxTryCount) {
            if (timeout > 0) {
                uint64_t count = GetTimeInterval(beginTimeSpec);
                COND_RETURN_ERROR((count >= static_cast<uint64_t>(timeout)), RT_ERROR_STREAM_SYNC_TIMEOUT,
                    "Stream sync timeout, device_id=%u, stream_id=%d, time=%lums, timeout=%dms, tryCount=%u",
                    deviceId, streamId_, count, timeout, tryCount);
                timeout = (timeout - static_cast<int32_t>(count));
            }
            break;
        }
        error = CheckContextStatus(false);
        COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "context is abort, status=%#x.", static_cast<int32_t>(error));

        if ((currentId != UINT32_MAX) && TASK_ID_LT(TASK_ID_ADD(currentId, RT_SYNC_SLEEP_INTERVAL), taskId)) {
            (void)mmSleep(1U);
        }

        tryCount++;
        if ((tryCount % perSchedYield) == 0) {
            if (timeout > 0) {
                uint64_t count = GetTimeInterval(beginTimeSpec);
                COND_RETURN_ERROR((count >= static_cast<uint64_t>(timeout)), RT_ERROR_STREAM_SYNC_TIMEOUT,
                    "SchedYield stream sync timeout, device_id=%u, stream_id=%d, time=%lums, timeout=%dms, "
                    "tryCount=%u, RunningState=%u",
                    deviceId, streamId_, count, timeout, tryCount, device_->GetDevRunningState());
            }
            (void)sched_yield();
        }
    }

    error = EschedManage(false);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    TaskInfo submitTask = {};
    TaskInfo *tsk = &submitTask;
    error = ProcRecordTask(tsk);
    ERROR_RETURN_MSG_INNER(error, "Failed to submit create record task, stream_id=%d", streamId_);

    // get logic cq
    bool isFastCq = false;

    StreamSqCqManage * const stmSqCqManage = const_cast<StreamSqCqManage *>(device_->GetStreamSqCqManage());
    COND_RETURN_ERROR_MSG_INNER(stmSqCqManage == nullptr, RT_ERROR_INVALID_VALUE, "Get manage fail.");
    error = stmSqCqManage->AllocLogicCq(static_cast<uint32_t>(streamId_),
        IsSteamNeedFastCq(), logicCqId, isFastCq);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "alloc logic cq failed.");

    EventRecordTaskInfo * const eventRecordTsk = &(tsk->u.eventRecordTaskInfo);
    eventRecordTsk->waitCqflag = true;
    eventRecordTsk->waitCqId = static_cast<uint16_t>(logicCqId);
    eventRecordTsk->timeout = timeout;
    tsk->isNeedStreamSync = true;

    error = device_->SubmitTask(tsk, nullptr, nullptr, timeout);
    if (error != RT_ERROR_NONE) {
        eventRecordTsk->event->DeleteRecordResetFromMap(tsk);
        eventRecordTsk->event->EventIdCountSub(eventRecordTsk->eventid);
    }

    if (error == RT_ERROR_STREAM_SYNC_TIMEOUT) {
        return error;
    }
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error,
        (void)device_->GetTaskFactory()->Recycle(tsk), "fail to submit EventRecordTask");

    error =  stmSqCqManage->FreeLogicCqByThread(static_cast<uint32_t>(streamId_));
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "free logic cq failed.");

    return error;
}

void Stream::ReportErrorMessage(const uint32_t errCode, const std::string &errMsg)
{
    if (errorMsg_.size() < ERROR_MESSAGE_MAX_SIZE) {
        errorMsgLock_.lock();
        errorMsg_.emplace_back(std::make_pair(errCode, errMsg));
        errorMsgLock_.unlock();
    }
}

/* Alloc SVM to save stream executed times, which is used in RDMA c-core SQE to calculate PI */
rtError_t Stream::AllocExecutedTimesSvm()
{
    rtError_t error = RT_ERROR_NONE;
    if (Runtime::Instance()->ChipIsHaveStars()) {
        Runtime * const rtInstance = Runtime::Instance();
        const rtMemType_t memType = rtInstance->GetTsMemType(MEM_REQUEST_FEATURE_DEFAULT, sizeof(uint16_t));

        error = device_->Driver_()->DevMemAlloc(RtPtrToPtr<void **>(&executedTimesSvm_), sizeof(uint16_t),
            memType, device_->Id_());
        COND_RETURN_ERROR((error != RT_ERROR_NONE) || (executedTimesSvm_ == nullptr), error,
            "Alloc SVM to save stream executed times failed, retCode=%#x.", error);
        RT_LOG(RT_LOG_INFO, "stream_id=%d.", streamId_);

        error = device_->Driver_()->MemSetSync(executedTimesSvm_, sizeof(uint16_t), 0xFFU, sizeof(uint16_t));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "MemSetSync stream executed times SVM failed, retCode=%#x.", static_cast<uint32_t>(error));
    }
    return error;
}

rtError_t Stream::FreeExecutedTimesSvm()
{
    if (executedTimesSvm_ == nullptr) {
        return RT_ERROR_NONE;
    }
    if (!Runtime::Instance()->ChipIsHaveStars()) {
        return RT_ERROR_NONE;
    }

    const rtError_t error = device_->Driver_()->DevMemFree(executedTimesSvm_, device_->Id_());
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error,
        "Free executedTimes SVM failed, mem free failed, retCode=%#x.", error);
    executedTimesSvm_ = nullptr;
    return RT_ERROR_NONE;
}

rtError_t Stream::SetSqRegVirtualAddrToDevice(uint64_t sqRegVirtualAddr) const
{
    rtError_t error = RT_ERROR_NONE;
    if ((device_->GetSqVirtualArrBaseAddr_() != nullptr) && (sqRegVirtualAddr != 0ULL)) {
        uint64_t *deviceMemForVirAddr = static_cast<uint64_t*>(device_->GetSqVirtualArrBaseAddr_()) + sqId_;
        error = device_->Driver_()->MemCopySync(static_cast<void*>(deviceMemForVirAddr), sizeof(uint64_t),
                                                static_cast<void*>(&sqRegVirtualAddr), sizeof(uint64_t),
                                                RT_MEMCPY_HOST_TO_DEVICE);
    }
    return error;
}

bool Stream::IsPersistentTaskFull()
{
    const std::lock_guard<std::mutex> stmLock(persistentTaskMutex_);
    return (persistentTaskid_.size() >= Runtime::macroValue_.maxPersistTaskNum);
}

void Stream::InsertPendingList(uint32_t hostTaskType, HostTaskBase *base)
{
    const std::lock_guard<std::mutex> hostTaskLock(hostTaskMutex_);
    hostTaskPendingList_[hostTaskType].push_back(base);
}

rtError_t Stream::ExecPendingList(uint32_t hostTaskType)
{
    const std::lock_guard<std::mutex> hostTaskLock(hostTaskMutex_);
    rtError_t retCode = RT_ERROR_NONE;
    rtError_t errorCode = RT_ERROR_NONE;

    for (auto iter = hostTaskPendingList_[hostTaskType].begin();
        iter != hostTaskPendingList_[hostTaskType].end(); iter++) {
        retCode = (*iter)->WaitFinish();
        if (retCode != RT_ERROR_NONE) {
            errorCode = retCode;
            RT_LOG(RT_LOG_ERROR, "ExecPendingList result failed, hostTaskType = %d, retCode = %#x.",
                hostTaskType, errorCode);
        }
        DELETE_O(*iter);
    }
    (void)hostTaskPendingList_.erase(hostTaskType);
    return errorCode;
}

bool Stream::IsPendingListEmpty(uint32_t hostTaskType)
{
    const std::lock_guard<std::mutex> hostTaskLock(hostTaskMutex_);
    const auto iter = hostTaskPendingList_.find(hostTaskType);
    if (iter != hostTaskPendingList_.end()) {
        return (iter->second).empty();
    }
    return true;
}

void Stream::StarsShowStmDfxInfo(void)
{
    uint16_t sqHead = 0U;
    uint16_t sqTail = 0U;
    const uint32_t sqId = GetSqId();
    const uint32_t tsId = device_->DevGetTsId();
    rtError_t error;

    error = device_->Driver_()->GetSqHead(device_->Id_(), tsId, sqId, sqHead);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Query sq head, device_id=%u, stream_id=%d, retCode=%#x",
            device_->Id_(), Id_(), static_cast<uint32_t>(error));
        return;
    }

    error = device_->Driver_()->GetSqTail(device_->Id_(), tsId, sqId, sqTail);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Query sq tail failed, device_id=%u, stream_id=%d, retCode=%#x",
            device_->Id_(), Id_(), static_cast<uint32_t>(error));
        return;
    }

    RT_LOG(RT_LOG_EVENT, "Current sq head and tail info, device_id=%u, stream_id=%d, sqHead=%hu, sqTail=%hu",
        device_->Id_(), Id_(), sqHead, sqTail);

    uint32_t headTaskId = UINT16_MAX;
    error = GetTaskIdByPos(sqHead, headTaskId);
    if (error == RT_ERROR_NONE) {
        TaskInfo * const workTask = device_->GetTaskFactory()->GetTask(Id_(), static_cast<uint16_t>(headTaskId));
        if (workTask != nullptr) {
            RT_LOG(RT_LOG_EVENT, "Current work task info, device_id=%u, stream_id=%d, task_id=%u, task_type=%u, "
                "sqHead=%hu, sqTail=%hu", device_->Id_(), Id_(), workTask->id, workTask->type, sqHead, sqTail);
        }
    } else {
        RT_LOG(RT_LOG_ERROR, "Get task failed, device_id=%u, stream_id=%d, sqHead=%hu, sqTail=%hu, retCode=%#x",
            device_->Id_(), Id_(), sqHead, sqTail, static_cast<uint32_t>(error));
    }

    RT_LOG(RT_LOG_EVENT, "Stream res info, finishTaskId=%u, lastTaskId=%u, pendingNum=%u, "
        "davinciTaskHead=%u, davinciTaskTail=%u, taskHead=%u, taskTail=%u, taskPosHead=%u, taskPosTail=%u,",
        finishTaskId_, lastTaskId_, pendingNum_.Value(), davinciTaskHead_, davinciTaskTail_, taskHead_, taskTail_,
        taskPosHead_.Value(), taskPosTail_.Value());
    const uint32_t rtsqDepth = (((flags_ & RT_STREAM_HUGE) != 0U) && (Runtime::macroValue_.maxTaskNumPerHugeStream != 0)) ?
        Runtime::macroValue_.maxTaskNumPerHugeStream : GetSqDepth();

    const uint32_t headStart = (taskPosHead_.Value() + rtsqDepth - 5U) % rtsqDepth;
    const uint32_t tailStart = (taskPosTail_.Value() + rtsqDepth - 5U) % rtsqDepth;
    uint32_t headIndex[SHOW_DFX_INFO_TASK_NUM] = {0};
    uint32_t tailIndex[SHOW_DFX_INFO_TASK_NUM] = {0};

    for (uint32_t i = 0; i <= 5U; i++) {
        headIndex[i] = (headStart + i) % rtsqDepth;
    }
    RT_LOG(RT_LOG_EVENT, "Task pos info for head, pos:taskId %u:%hu, %u:%hu, %u:%hu, %u:%hu, %u:%hu, %u:%hu",
        headIndex[0U], posToTaskIdMap_[headIndex[0U]], headIndex[1U], posToTaskIdMap_[headIndex[1U]],
        headIndex[2U], posToTaskIdMap_[headIndex[2U]], headIndex[3U], posToTaskIdMap_[headIndex[3U]],
        headIndex[4U], posToTaskIdMap_[headIndex[4U]], headIndex[5U], posToTaskIdMap_[headIndex[5U]]);

    for (uint32_t i = 0; i <= 5U; i++) {
        tailIndex[i] = (tailStart + i) % rtsqDepth;
    }
    RT_LOG(RT_LOG_EVENT, "Task pos info for tail, pos:taskId %u:%hu, %u:%hu, %u:%hu, %u:%hu, %u:%hu, %u:%hu",
        tailIndex[0U], posToTaskIdMap_[tailIndex[0U]], tailIndex[1U], posToTaskIdMap_[tailIndex[1U]],
        tailIndex[2U], posToTaskIdMap_[tailIndex[2U]], tailIndex[3U], posToTaskIdMap_[tailIndex[3U]],
        tailIndex[4U], posToTaskIdMap_[tailIndex[4U]], tailIndex[5U], posToTaskIdMap_[tailIndex[5U]]);

    if (taskResMang_ != nullptr) {
        taskResMang_->ShowDfxInfo();
    }
}

void Stream::DcShowStmDfxInfo(void)
{
    // get current task id
    uint32_t headTaskId = UINT16_MAX;
    const rtError_t error = GetLastTaskIdFromCqShm(headTaskId);
    if (error == RT_ERROR_NONE) {
        TaskInfo *const workTask = device_->GetTaskFactory()->GetTask(Id_(), static_cast<uint16_t>(headTaskId));
        if (workTask != nullptr) {
            RT_LOG(RT_LOG_EVENT,
                "Current work task info, device_id=%u, stream_id=%d, task_id=%u, task_type=%u",
                device_->Id_(), Id_(), workTask->id, workTask->type);
        }
    } else {
        RT_LOG(RT_LOG_ERROR,
            "Get task failed, device_id=%u, stream_id=%d, retCode=%#x",
            device_->Id_(), Id_(), static_cast<uint32_t>(error));
    }
    const uint32_t streamShmTaskId = device_->GetTaskIdFromStreamShmTaskId(static_cast<uint32_t>(streamId_));
    RT_LOG(RT_LOG_EVENT, "Stream res info, finishTaskId=%u, lastTaskId=%u, pendingNum=%u, davinciTaskHead=%u, "
        "davinciTaskTail=%u, taskHead=%u, taskTail=%u, headTaskId=%u, streamShmTaskId=%u", finishTaskId_, lastTaskId_,
        pendingNum_.Value(), davinciTaskHead_, davinciTaskTail_, taskHead_, taskTail_, headTaskId, streamShmTaskId);

    if ((taskPublicBuff_ != nullptr) && taskPublicBuffSize_ > 0) {
        uint32_t taskPublicHeadIndex[SHOW_DFX_INFO_TASK_NUM] = {0};
        uint32_t taskPublicTailIndex[SHOW_DFX_INFO_TASK_NUM] = {0};
        const uint32_t taskPublicHeadStart = (taskHead_ + taskPublicBuffSize_ - 5U) % taskPublicBuffSize_;
        const uint32_t taskPublicTailStart = (taskTail_ + taskPublicBuffSize_ - 5U) % taskPublicBuffSize_;

        for (uint32_t i = 0; i <= 5U; i++) {
            taskPublicHeadIndex[i] = (taskPublicHeadStart + i) % taskPublicBuffSize_;
            taskPublicTailIndex[i] = (taskPublicTailStart + i) % taskPublicBuffSize_;
        }
        // taskPublicBuffer_ : 保存非davinci类型的task，回收时在主线程回收
        RT_LOG(RT_LOG_EVENT,
            "Task pos info for task public head, pos:taskId %u:%u, %u:%u, %u:%u, %u:%u, %u:%u, %u:%u",
            taskPublicHeadIndex[0U], taskPublicBuff_[taskPublicHeadIndex[0U]],
            taskPublicHeadIndex[1U], taskPublicBuff_[taskPublicHeadIndex[1U]],
            taskPublicHeadIndex[2U], taskPublicBuff_[taskPublicHeadIndex[2U]],
            taskPublicHeadIndex[3U], taskPublicBuff_[taskPublicHeadIndex[3U]],
            taskPublicHeadIndex[4U], taskPublicBuff_[taskPublicHeadIndex[4U]],
            taskPublicHeadIndex[5U], taskPublicBuff_[taskPublicHeadIndex[5U]]);

        RT_LOG(RT_LOG_EVENT,
            "Task pos info for task public tail, pos:taskId %u:%u, %u:%u, %u:%u, %u:%u, %u:%u, %u:%u",
            taskPublicTailIndex[0U], taskPublicBuff_[taskPublicTailIndex[0U]],
            taskPublicTailIndex[1U], taskPublicBuff_[taskPublicTailIndex[1U]],
            taskPublicTailIndex[2U], taskPublicBuff_[taskPublicTailIndex[2U]],
            taskPublicTailIndex[3U], taskPublicBuff_[taskPublicTailIndex[3U]],
            taskPublicTailIndex[4U], taskPublicBuff_[taskPublicTailIndex[4U]],
            taskPublicTailIndex[5U], taskPublicBuff_[taskPublicTailIndex[5U]]);
    }
    if ((davinciTaskList_ != nullptr) && (davinciTaskListSize_ > 0)) {
        uint32_t davinciTaskHeadIndex[SHOW_DFX_INFO_TASK_NUM] = {0};
        uint32_t davinciTaskTailIndex[SHOW_DFX_INFO_TASK_NUM] = {0};
        const uint32_t davinciTaskHeadStart = (davinciTaskHead_ + davinciTaskListSize_ - 5U) % davinciTaskListSize_;
        const uint32_t davinciTaskTailStart = (davinciTaskTail_ + davinciTaskListSize_ - 5U) % davinciTaskListSize_;
        for (uint32_t i = 0; i <= 5U; i++) {
            davinciTaskHeadIndex[i] = (davinciTaskHeadStart + i) % davinciTaskListSize_;
            davinciTaskTailIndex[i] = (davinciTaskTailStart + i) % davinciTaskListSize_;
        }
        // davinciTaskList_ : 保存davinci类型的task，回收时在回收线程回收
        RT_LOG(RT_LOG_EVENT,
            "Task pos info for davinci task head, pos:taskId %u:%u, %u:%u, %u:%u, %u:%u, %u:%u, %u:%u",
            davinciTaskHeadIndex[0U], davinciTaskList_[davinciTaskHeadIndex[0U]],
            davinciTaskHeadIndex[1U], davinciTaskList_[davinciTaskHeadIndex[1U]],
            davinciTaskHeadIndex[2U], davinciTaskList_[davinciTaskHeadIndex[2U]],
            davinciTaskHeadIndex[3U], davinciTaskList_[davinciTaskHeadIndex[3U]],
            davinciTaskHeadIndex[4U], davinciTaskList_[davinciTaskHeadIndex[4U]],
            davinciTaskHeadIndex[5U], davinciTaskList_[davinciTaskHeadIndex[5U]]);

        RT_LOG(RT_LOG_EVENT,
            "Task pos info for davinci task tail, pos:taskId %u:%u, %u:%u, %u:%u, %u:%u, %u:%u, %u:%u",
            davinciTaskTailIndex[0U], davinciTaskList_[davinciTaskTailIndex[0U]],
            davinciTaskTailIndex[1U], davinciTaskList_[davinciTaskTailIndex[1U]],
            davinciTaskTailIndex[2U], davinciTaskList_[davinciTaskTailIndex[2U]],
            davinciTaskTailIndex[3U], davinciTaskList_[davinciTaskTailIndex[3U]],
            davinciTaskTailIndex[4U], davinciTaskList_[davinciTaskTailIndex[4U]],
            davinciTaskTailIndex[5U], davinciTaskList_[davinciTaskTailIndex[5U]]);
    }
    if (taskResMang_ != nullptr) {
        taskResMang_->ShowDfxInfo();
    }
}

void Stream::ShowStmDfxInfo(void)
{
    if (Device_()->IsStarsPlatform()) {
        StarsShowStmDfxInfo();
    } else {
        DcShowStmDfxInfo();
    }
}

void Stream::StarsStmDfxCheck(uint64_t &beginCnt, uint64_t &endCnt, uint16_t &checkCount)
{
    if (checkCount >= TASK_SENDING_WAIT_CHECK_COUNT) {
        return;
    }

    if (beginCnt == 0ULL) {
        mmTimespec beginTimeSpec = mmGetTickCount();
        beginCnt = static_cast<uint64_t>(beginTimeSpec.tv_sec) * RT_MS_PER_S +
            static_cast<uint64_t>(beginTimeSpec.tv_nsec) / RT_MS_TO_NS;
        return;
    }

    mmTimespec endTimeSpec = mmGetTickCount();
    endCnt = static_cast<uint64_t>(endTimeSpec.tv_sec) * RT_MS_PER_S +
        static_cast<uint64_t>(endTimeSpec.tv_nsec) / RT_MS_TO_NS;

    const uint64_t spendTime = (endCnt > beginCnt) ? (endCnt - beginCnt) : 0ULL;

    if (spendTime > TASK_SENDING_WAIT_CHECK_TIME) {
        StarsShowStmDfxInfo();
        beginCnt = endCnt;
        checkCount++;
    }
}

void Stream::StmDfxCheck(uint64_t &beginCnt, uint64_t &endCnt, uint16_t &checkCount)
{
    if (checkCount >= TASK_SENDING_WAIT_CHECK_COUNT) {
        return;
    }

    if (beginCnt == 0ULL) {
        mmTimespec beginTimeSpec = mmGetTickCount();
        beginCnt = static_cast<uint64_t>(beginTimeSpec.tv_sec) * RT_MS_PER_S +
            static_cast<uint64_t>(beginTimeSpec.tv_nsec) / RT_MS_TO_NS;
        return;
    }

    mmTimespec endTimeSpec = mmGetTickCount();
    endCnt = static_cast<uint64_t>(endTimeSpec.tv_sec) * 1000UL +
        static_cast<uint64_t>(endTimeSpec.tv_nsec) / RT_MS_TO_NS;

    const uint64_t spendTime = (endCnt > beginCnt) ? (endCnt - beginCnt) : 0ULL;

    if (spendTime > TASK_SENDING_WAIT_CHECK_TIME) {
        ShowStmDfxInfo();
        beginCnt = endCnt;
        checkCount++;
    }
}

rtError_t Stream::PrintStmDfxAndCheckDevice(
    uint64_t &beginCnt, uint64_t &endCnt, uint16_t &checkCount, uint32_t tryCount)
{
    constexpr uint16_t perDetectTimes = 1000U;
    if ((tryCount % perDetectTimes) == 0) {
        if (device_->GetDevRunningState() == static_cast<uint32_t>(DEV_RUNNING_DOWN)) {
            RT_LOG(RT_LOG_ERROR, "device running down, device_id=%u, stream_id=%d", device_->Id_(), Id_());
            ShowStmDfxInfo();
            return RT_ERROR_DRV_ERR;
        } else {
            StmDfxCheck(beginCnt, endCnt, checkCount);
        }
    }
    return RT_ERROR_NONE;
}

// taskPersistentTail_/taskPosTail_ save the postion of rtsq tail
rtError_t Stream::StarsAddTaskToStream(TaskInfo * const tsk, const uint32_t sendSqeNum)
{
    NULL_PTR_RETURN_MSG(tsk, RT_ERROR_TASK_NULL);
    const bool bind = GetBindFlag();
    const uint32_t posTail = bind ? taskPersistentTail_.Value() : taskPosTail_.Value();
    const uint32_t rtsqDepth = (((flags_ & RT_STREAM_HUGE) != 0U) && (Runtime::macroValue_.maxTaskNumPerHugeStream != 0)) ?
        Runtime::macroValue_.maxTaskNumPerHugeStream : GetSqDepth();
    const uint32_t newPosTail = (posTail + sendSqeNum) % rtsqDepth;

    if (bind) {
        // If model stream is already full, return STREAM_FULL. PendingNum add 1 in TaskSubmited. Because the task will
        // not be sent, pendingNum sub 1 is performed.
        COND_PROC_RETURN_ERROR(posTail + sendSqeNum >= rtsqDepth, RT_ERROR_STREAM_FULL, pendingNum_.Sub(1),
                               "model stream full, stream_id=%d, task_id=%u, posTail=%u, sendSqeNum=%u, rtsqDepth=%u",
                               streamId_, tsk->id, posTail, sendSqeNum, rtsqDepth);
        const rtError_t ret = PackingTaskGroup(tsk, static_cast<uint16_t>(streamId_));
        COND_PROC_RETURN_ERROR(ret != RT_ERROR_NONE, ret, SetTaskGroupErrCode(ret),
            "pack task group failed, stream_id=%d, task_id=%hu.", streamId_, tsk->id);
        taskPersistentTail_.Set(newPosTail);
        delayRecycleTaskid_.push_back(tsk->id);
    } else {
        const uint32_t posHead = bind ? taskPersistentHead_.Value() : taskPosHead_.Value();
        const bool stmFullFlag = IsStreamFull(posHead, posTail, rtsqDepth, sendSqeNum);
        if (unlikely(stmFullFlag)) {
            return RT_ERROR_STREAM_FULL;
        }

        if (!IsSeparateSendAndRecycle()) {
            const rtError_t ret = AddTaskToList(tsk);
            COND_RETURN_WITH_NOLOG((ret != RT_ERROR_NONE), ret);
        }

        taskPosTail_.Set(newPosTail);
    }

    posToTaskIdMapLock_.lock();
    for (uint32_t i = 0U; i < sendSqeNum; ++i) {
        posToTaskIdMap_[((posTail + i) % rtsqDepth)] = tsk->id;
    }
    posToTaskIdMapLock_.unlock();

    SetSqPos(tsk, posTail);
    SetLastTaskId(static_cast<uint32_t>(tsk->id));
    if ((tsk->isNeedStreamSync != 0U) || (tsk->isCqeNeedConcern != 0U) ||
        ((tsk->type == TS_TASK_TYPE_MEMCPY) && (tsk->u.memcpyAsyncTaskInfo.isConcernedRecycle))) {
        tsk->stream->latestConcernedTaskId.Set(tsk->id);
    }
    return RT_ERROR_NONE;
}

bool Stream::StarsCheckSqeFull(const uint32_t sendSqeNum)
{
    const uint32_t rtsqDepth = GetSqDepth();
    if (sendSqeNum >= rtsqDepth) {
        return true;
    }
    const uint32_t posTail = sqTailPos_;
    const uint32_t posHead = sqHeadPos_;
    if (!IsStreamFull(posHead, posTail, rtsqDepth, sendSqeNum)) {
        return false;
    }

    uint16_t sqHead = 0U;
    const uint32_t sqId = GetSqId();
    const uint32_t tsId = device_->DevGetTsId();
    const rtError_t error = device_->Driver_()->GetSqHead(device_->Id_(), tsId, sqId, sqHead);
    if (error != RT_ERROR_NONE) {
        return true;
    }
    // There is a delay in updating the sqHead using the cqe response. Here, update the sqHead again.
    sqHeadPos_ = sqHead;

    return IsStreamFull(sqHead, posTail, rtsqDepth, sendSqeNum);
}

void Stream::StarsSqTailAdd()
{
    const uint32_t rtsqDepth = GetSqDepth();
    const uint32_t posTail = sqTailPos_;
    const uint32_t newPosTail = (posTail + 1U) % rtsqDepth;
    sqTailPos_ = newPosTail;
}

void Stream::StarsSqHeadSet(const uint32_t data)
{
    const uint32_t rtsqDepth = GetSqDepth();
    sqHeadPos_ = (data + 1U) % rtsqDepth;
    return;
}

void Stream::StarsWrRecordEnQueue(const bool needSend)
{
    uint32_t sqeIndex = sqTailPos_;
    if (!needSend) {
        sqeIndex = static_cast<uint32_t>(1UL << FLAG_OFFSET) | sqeIndex;
    }
    wrRecordQueue_.queue[wrRecordQueue_.rear] = sqeIndex;
    wrRecordQueue_.rear = (wrRecordQueue_.rear + 1U) % (wrRecordQueue_.size);
    wrRecordQueue_.count++;
    return;
}

void Stream::StarsWrRecordDeQueue()
{
    if (wrRecordQueue_.front != wrRecordQueue_.rear) {
        wrRecordQueue_.front = (wrRecordQueue_.front + 1U) % (wrRecordQueue_.size);
        wrRecordQueue_.count--;
    }
    return;
}

void Stream::UpdateTaskPosHead(const uint32_t sqPos, const uint32_t sqeNum)
{
    if ((!device_->IsStarsPlatform()) || GetBindFlag()) {
        return;
    }

    const uint32_t rtsqDepth = GetSqDepth();
    taskPosHead_.Set((sqPos + sqeNum) % rtsqDepth);
    return;
}


rtError_t Stream::TryDelPublicRecordedTask(const uint16_t tailTaskId)
{
    if (taskPublicBuffSize_ == 0U) {
        return RT_ERROR_STREAM_EMPTY;
    }

    const std::lock_guard<std::mutex> stmLock(publicTaskMutex_);
    if (taskHead_ != taskTail_) {
        const uint32_t fixTaskId = taskPublicBuff_[taskHead_ % taskPublicBuffSize_];
        const uint16_t relTaskId = static_cast<uint16_t>(fixTaskId & 0xFFFFU);
        if (TASK_ID_GT(relTaskId, tailTaskId)) {
            RT_LOG(RT_LOG_DEBUG, "delTaskId is larger than tailTaskId, stream_id=%d, tailTaskId=%u, relTaskId=%u, "
                "head=%u, tail=%u", streamId_, static_cast<uint32_t>(tailTaskId), static_cast<uint32_t>(relTaskId),
                taskHead_, taskTail_);
            return RT_ERROR_STREAM_INVALID;
        }

        taskHead_ = ((taskHead_ + 1U) % taskPublicBuffSize_);
        RT_LOG(RT_LOG_DEBUG, "del public task from stream, stream_id=%d, tailTaskId=%u, delTaskId=%u, head=%u, tail=%u",
            streamId_, static_cast<uint32_t>(tailTaskId), static_cast<uint32_t>(relTaskId),
            taskHead_, taskTail_);
        finishTaskId_ = relTaskId;
        return RT_ERROR_NONE;
    } else {
        RT_LOG(RT_LOG_DEBUG, "public task list null, stream_id=%d, task_id=%u, head=%u, tail=%u",
            streamId_, static_cast<uint32_t>(tailTaskId), taskHead_, taskTail_);
        return RT_ERROR_STREAM_EMPTY;
    }
}

rtError_t Stream::StarsTryDelRecordedTask(const TaskInfo * const workTask, const bool isTaskBind,
                                          const uint16_t tailTaskId)
{
    if (!isTaskBind) {
        return TryDelPublicRecordedTask(tailTaskId);
    }
    NULL_PTR_RETURN_MSG(workTask, RT_ERROR_TASK_NULL);
    // the flow is the proc for taskBind
    // finishTaskId_ is the last released task, tailTaskId is the last task id want to release
    // the maximum task ID of the lite stream is 65533.
    if (finishTaskId_ != tailTaskId) {
        uint16_t delTaskId = workTask->id;
        finishTaskId_ = delTaskId;

        const uint32_t rtsqDepth = GetSqDepth();
        taskPersistentHead_.Set((workTask->pos + 1) % rtsqDepth);
        RT_LOG(RT_LOG_INFO, "del persistent task, stream_id=%d, tailTaskId=%u, delTaskId=%hu, head=%hu, tail=%u",
            streamId_, static_cast<uint32_t>(tailTaskId), delTaskId,
            workTask->pos, taskPersistentTail_.Value());
        return RT_ERROR_NONE;
    } else {
        RT_LOG(RT_LOG_ERROR, "Task persistent buff null, stream_id=%d, task_id=%u, head=%u, tail=%u",
            streamId_, static_cast<uint32_t>(tailTaskId), workTask->pos, taskPersistentTail_.Value());
        return RT_ERROR_STREAM_EMPTY;
    }
}

rtError_t Stream::StarsGetPublicTaskHead(TaskInfo *workTask, const bool isTaskBind, const uint16_t tailTaskId,
    uint16_t * const delTaskId)
{
    NULL_PTR_RETURN_MSG(delTaskId, RT_ERROR_TASK_NULL);

    if (!isTaskBind) {
        const std::lock_guard<std::mutex> stmLock(publicTaskMutex_);
        if (taskHead_ != taskTail_) {
            const uint32_t fixTaskId = taskPublicBuff_[taskHead_ % taskPublicBuffSize_];
            const uint16_t relTaskId = static_cast<uint16_t>(fixTaskId & 0xFFFFU);
            if (TASK_ID_GT(relTaskId, tailTaskId)) {
                RT_LOG(RT_LOG_DEBUG, "delTaskId is larger than tailTaskId, stream_id=%d, tailTaskId=%u, relTaskId=%u, "
                    "head=%u, tail=%u", streamId_, static_cast<uint32_t>(tailTaskId), static_cast<uint32_t>(relTaskId),
                    taskHead_, taskTail_);
                return RT_ERROR_STREAM_INVALID;
            }

            *delTaskId = relTaskId;
            return RT_ERROR_NONE;
        } else {
            RT_LOG(RT_LOG_DEBUG, "public task list null, stream_id=%d, task_id=%u, head=%u, tail=%u",
                streamId_, static_cast<uint32_t>(tailTaskId), taskHead_, taskTail_);
            return RT_ERROR_STREAM_EMPTY;
        }
    }

    // the flow is the proc for taskBind
    // finishTaskId_ is the last released task, tailTaskId is the last task id want to release
    // the maximum task ID of the lite stream is 65533.
    if ((finishTaskId_ < tailTaskId) || (finishTaskId_ == MAX_UINT32_NUM)) {
        *delTaskId = static_cast<uint16_t>((finishTaskId_ + 1U) % MAX_UINT16_NUM);
        return RT_ERROR_NONE;
    } else {
        RT_LOG(RT_LOG_DEBUG, "Task persistent buff null, stream_id=%d, task_id=%u, head=%u, tail=%u, "
            "finishTaskId=%u, endTaskId=%hu",
            streamId_, static_cast<uint32_t>(tailTaskId), workTask->pos, taskPersistentTail_.Value(),
            finishTaskId_, tailTaskId);
        return RT_ERROR_STREAM_EMPTY;
    }
}

rtError_t Stream::ModelWaitForTask(const uint32_t taskId, const bool isNeedWaitSyncCq)
{
    uint32_t idx = 0U;
    uint16_t sqTail = 0U;
    const uint32_t devId = device_->Id_();
    const uint32_t tsId = device_->DevGetTsId();
   TaskInfo * const preTask = device_->GetTaskFactory()->GetTask(streamId_, static_cast<uint16_t>(taskId));

    while (!isNeedWaitSyncCq) {
        COND_RETURN_ERROR((device_->GetDevRunningState() == static_cast<uint32_t>(DEV_RUNNING_DOWN)),
            RT_ERROR_DRV_ERR, "device_id=%u is down, stream_id=%u", device_->Id_(), streamId_);

        const rtError_t error = device_->Driver_()->GetSqTail(devId, tsId, sqId_, sqTail);
        ERROR_RETURN_MSG_INNER(error, "Failed to get sq tail, stream_id=%d, task_id=%u, dev_id=%u, ts_id=%u",
            streamId_, taskId, devId, tsId);

        // Sq have no task, return OK
        if (sqTail == 0U) {
            RT_LOG(RT_LOG_EVENT, "Model wait finish, device_id=%u, ts_id=%u, stream_id=%d, sqTail=%u",
                devId, tsId, streamId_, sqTail);
            return RT_ERROR_NONE;
        }

        // eg: prePos is loadCompleteTask's postion of occupy, sqTail is the postion of rtsq's tail
        NULL_PTR_RETURN_MSG(preTask, RT_ERROR_TASK_NULL);
        uint32_t prePos = preTask->pos;
        if (TASK_ID_GEQ(sqTail, prePos)) {
           RT_LOG(RT_LOG_DEBUG, "Model wait finish, device_id=%u, ts_id=%u, stream_id=%d, prePos=%u, sqTail=%u",
               devId, tsId, streamId_, prePos, sqTail);
           return RT_ERROR_NONE;
        }

        if (TASK_ID_LT(TASK_ID_ADD(sqTail, RT_SYNC_SLEEP_INTERVAL), prePos)) {
            (void)mmSleep(1U);
        }

        if ((idx % 80000U) == 0U) { // 80000:print debug info per 80000 times
            RT_LOG(RT_LOG_DEBUG, "model wait for task, taskId=%u, prePos=%u, sqTail=%hu", taskId, prePos, sqTail);
        }
        idx++;
    }
    return RT_ERROR_NONE;
}

uint32_t Stream::StarsGetMaxTryCount() const
{
    if (static_cast<rtRunMode>(device_->Driver_()->GetRunMode()) == RT_RUN_MODE_OFFLINE) {
        return RT_QUERY_TIMES_THRESHOLD;
    }

    if (pendingNum_.Value() == 0U) {
        return 0U;
    }

    if (streamFastSync_) {
        if (isModelExcel || isModelComplete || (GetModelNum() != 0)) {
            return RT_QUERY_TIMES_THRESHOLD;
        }
        return RT_QUERY_TIMES_THRESHOLD_STARS;
    }

    return device_->IsAddrFlatDev() ? RT_QUERY_TIMES_THRESHOLD_DOUBLE_DIE_STARS : RT_QUERY_TIMES_THRESHOLD;
}

rtError_t Stream::SubmitRecordTask(int32_t timeout)
{
    TaskInfo submitTask = {};
    TaskInfo *tsk = &submitTask;
    rtError_t error = ProcRecordTask(tsk);
    ERROR_RETURN_MSG_INNER(error, "Failed to submit record task, device_id=%u, stream_id=%d", device_->Id_(), streamId_);

    EventRecordTaskInfo * const eventRecordTsk = &(tsk->u.eventRecordTaskInfo);
    eventRecordTsk->waitCqflag = true;
    eventRecordTsk->timeout = timeout;
    tsk->isNeedStreamSync = true;

    error = device_->SubmitTask(tsk, nullptr, nullptr, timeout);
    // ERROR CASE1: task send successfully but sync failed, and pendingNum_ has been incremented, simply return, don't
    // recycle task here; in the case of stream abort, task is recycled in Stream::ResClear instead;
    if ((error == RT_ERROR_STREAM_SYNC_TIMEOUT) || (error == RT_ERROR_STREAM_ABORT_SYNC_TASK_FAIL) ||
        (error == RT_ERROR_DEVICE_ABORT_SYNC_TASK_FAIL)) {
        RT_LOG(RT_LOG_WARNING,
            "fail to submit EventRecordTask, because timeout or stream is abort status, error=%u.",
            error);
        SetNeedSyncFlag(true);
        return error;
    }
    // ERROR CASE2: task sending failed and pendingNum_ has not been incremented;
    if (error != RT_ERROR_NONE) {
        eventRecordTsk->event->DeleteRecordResetFromMap(tsk);
        eventRecordTsk->event->EventIdCountSub(eventRecordTsk->eventid);
        (void)device_->GetTaskFactory()->Recycle(tsk);
        RT_LOG(RT_LOG_ERROR, "fail to submit EventRecordTask.");
    }
    return error;
}

rtError_t Stream::StarsWaitForTask(const uint32_t taskId, const bool isNeedWaitSyncCq,
    int32_t timeout)
{
    rtError_t errorCode = RT_ERROR_NONE;
    const uint32_t deviceId = device_->Id_();
    RT_LOG(RT_LOG_DEBUG, "Begin wait for task, device_id=%u, stream_id=%d, task_id=%u, finish_task_id=%u, "
        "last_task_id=%u, timeout=%dms.", deviceId, streamId_, taskId, finishTaskId_, lastTaskId_, timeout);

    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if ((!device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_STREAM_DOT_SYNC)) && (GetBindFlag())) {
        return ModelWaitForTask(taskId, isNeedWaitSyncCq);
    }

    uint32_t currentId = UINT16_MAX;
    uint32_t tryCount = 0U;
    constexpr uint16_t perSchedYield = 1000U;
    const uint32_t maxTryCount = StarsGetMaxTryCount();
    if (maxTryCount == 0U) {
        return RT_ERROR_NONE;
    }

    int32_t remainTime = timeout;
    const mmTimespec beginTime = mmGetTickCount();
    const bool isNeedRecordSyncTimeout =
        device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_STREAM_DOT_RECORD_SYNC_TIMEOUT);
    while (!isNeedWaitSyncCq) {
        StreamSyncLock();
        // WARNING: abort status must be checked after locking StreamSyncLock
        //  to avoid parallelized execution with Stream::SqcqUpdate
        if (abortStatus_ == RT_ERROR_STREAM_ABORT) {
            StreamSyncUnLock();
            RT_LOG(RT_LOG_ERROR,
                "this stream status is stream abort, stream_id=%u, sq_id=%u, cq_id=%u.",
                streamId_,
                sqId_,
                cqId_);
            return RT_ERROR_STREAM_ABORT;
        }

        this->SetSyncRemainTime(remainTime);
#if !(defined(__arm__))
        SetStreamAsyncRecycleFlag(true);
        if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
            errorCode = TaskReclaimByStream(this, false);
            currentId = static_cast<uint32_t>(GetRecycleEndTaskId());
        } else {
            errorCode = device_->TaskReclaimByStm(this, false, currentId);
        }
        SetStreamAsyncRecycleFlag(false);
#else
        if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
            errorCode = TaskReclaimByStream(this, false);
            currentId = static_cast<uint32_t>(GetRecycleEndTaskId());
        } else {
            errorCode = device_->TaskReclaimByStm(this, false, currentId);
        }
#endif
        if (tryCount <= RT_QUERY_TIMES_THRESHOLD) {
            RT_LOG(RT_LOG_INFO, "No.%u stream_id=%d, taskId=%u, currentId=%u", tryCount, streamId_, taskId, currentId);
        }
        this->SetSyncRemainTime(-1);
        StreamSyncUnLock();
        if (errorCode != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "Query Task status failed, device_id=%u, stream_id=%d, retCode=%#x",
                deviceId, streamId_, errorCode);
            return errorCode;
        }

        // Event occurred.
        if (IsWaitFinish(currentId, taskId)) {
            StreamSyncFinishReport();
            RT_LOG(RT_LOG_DEBUG, "Wait finish, device_id=%u, stream_id=%d, task_id=%u, current_id=%u, "
                "tryCount=%u", deviceId, streamId_, taskId, currentId, tryCount);
            const uint64_t timeCnt1 = isNeedRecordSyncTimeout ? GetTimeInterval(beginTime) : 0ULL;
            COND_PROC((isNeedRecordSyncTimeout && (timeCnt1 > ADC_MODEL_EXE_TIMEOUT)),
                RT_LOG(RT_LOG_EVENT, "sync/model exec timeout, timeCnt1=%ums, stream_id=%u", timeCnt1, streamId_));
            return RT_ERROR_NONE;
        }

        if (tryCount >= maxTryCount) {
            if (timeout > 0) {
                uint64_t count = GetTimeInterval(beginTime);
                COND_RETURN_ERROR((count >= static_cast<uint64_t>(timeout)), RT_ERROR_STREAM_SYNC_TIMEOUT,
                    "Stream sync timeout, device_id=%u, stream_id=%d, time=%lums, timeout=%dms, tryCount=%u",
                    deviceId, streamId_, count, timeout, tryCount);
                timeout = (timeout - static_cast<int32_t>(count));
            }
            break;
        }

        errorCode = CheckContextStatus(false);
        COND_RETURN_ERROR(errorCode != RT_ERROR_NONE, errorCode, "context is abort, status=%#x.", static_cast<uint32_t>(errorCode));

        if ((currentId != UINT16_MAX) && TASK_ID_LT(TASK_ID_ADD(currentId, RT_SYNC_SLEEP_INTERVAL), taskId)) {
            (void)mmSleep(1U);
        }

        tryCount++;
        if ((tryCount % perSchedYield) == 0U) {
            if (timeout > 0) {
                const uint64_t count = GetTimeInterval(beginTime);
                COND_RETURN_INFO((count >= static_cast<uint64_t>(timeout)), RT_ERROR_STREAM_SYNC_TIMEOUT,
                    "SchedYield stream sync timeout, device_id=%u, stream_id=%d, time=%lums, timeout=%dms, "
                    "tryCount=%u", deviceId, streamId_, count, timeout, tryCount);
                remainTime = (timeout - static_cast<int32_t>(count));
            }
            (void)sched_yield();
        }
    }
    const uint64_t timeCnt2 = GetTimeInterval(beginTime);
    errorCode = SubmitRecordTask(timeout);
    const uint64_t timeCnt3 = GetTimeInterval(beginTime);
    COND_PROC((isNeedRecordSyncTimeout && (timeCnt3 > ADC_MODEL_EXE_TIMEOUT)),
        RT_LOG(RT_LOG_EVENT, "sync/model exec timeout, timeCnt2=%lums, timeCnt3=%lums, stream_id=%u",
        timeCnt2, timeCnt3, streamId_));
    return errorCode;
}

rtError_t Stream::GetTaskIdByPos(const uint16_t recycleHead, uint32_t &taskId)
{
    const uint32_t rtsqDepth = (((flags_ & RT_STREAM_HUGE) != 0U) && (Runtime::macroValue_.maxTaskNumPerHugeStream != 0)) ?
        Runtime::macroValue_.maxTaskNumPerHugeStream : GetSqDepth();

    posToTaskIdMapLock_.lock();
    if (unlikely(recycleHead >= rtsqDepth) || (posToTaskIdMap_[recycleHead] == MAX_UINT16_NUM)) {
        posToTaskIdMapLock_.unlock();
        RT_LOG(RT_LOG_DEBUG, "fail, recycleHead=%hu.", recycleHead);
        return RT_ERROR_INVALID_VALUE;
    }

    taskId = posToTaskIdMap_[recycleHead];
    posToTaskIdMapLock_.unlock();
    return RT_ERROR_NONE;
}

rtError_t Stream::AllocLogicCq(const bool isDisableThread, const bool starsFlag, StreamSqCqManage * const stmSqCqManage,
    const uint32_t drvFlag)
{
    if (!isDisableThread) {
        return RT_ERROR_NONE;
    }

    uint32_t logicCqId;
    bool isFastCq = false;
    const uint32_t devId = device_->Id_();
    const uint32_t tsId = device_->DevGetTsId();

    rtError_t error;
    if (dvppGrp_ == nullptr) {
        error = stmSqCqManage->AllocLogicCq(static_cast<uint32_t>(streamId_), needFastcqFlag_,
            logicCqId, isFastCq, true, drvFlag);
        ERROR_RETURN_MSG_INNER(error, "Failed to alloc logic cq, stream_id=%d.", streamId_);
        if (needFastcqFlag_ && (!isFastCq)) {
            RT_LOG(RT_LOG_DEBUG, "Failed to alloc fast logic cq, stream_id=%d.", streamId_);
            return RT_ERROR_STREAM_INVALID;
        }
    } else {
        logicCqId = dvppGrp_->getLogicCqId();
        RT_LOG(RT_LOG_DEBUG, "stream bind to dvpp grp, streamId_=%d, logicCq=%u.", streamId_, logicCqId);
    }

    if (starsFlag) {
        SetLogicalCqId(logicCqId);
        // stars need streamId binding logicCqId
        error = device_->Driver_()->StreamBindLogicCq(devId, tsId, static_cast<uint32_t>(streamId_),
            logicCqId, drvFlag);
        ERROR_RETURN_MSG_INNER(error, "Failed to bind streamId and logicCqId, stream_id=%d, logicCq=%u.",
            streamId_, logicCqId);
    }
    RT_LOG(RT_LOG_DEBUG, "alloc logic cq success, stream_id=%d, logicCq=%u.", streamId_, logicCqId);

    return RT_ERROR_NONE;
}

// get taskId by rtsq head that has Finished
rtError_t Stream::GetLastTaskIdFromRtsq(uint32_t &lastTaskId)
{
    if (device_ == nullptr) {
        RT_LOG(RT_LOG_WARNING, "device is null, stream_id=%d", streamId_);
        return RT_ERROR_NONE;
    }
    uint16_t sqHead = 0U;
    const uint32_t sqId = GetSqId();
    const uint32_t tsId = device_->DevGetTsId();

    rtError_t error = device_->Driver_()->GetSqHead(device_->Id_(), tsId, sqId, sqHead);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Query sq head failed, retCode=%#x",
        static_cast<uint32_t>(error));

    // get taskId by postion, sqHead is executing Currently, pos has been executed.
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    uint16_t pos = 0U;
    if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_STREAM_EXECUTED_POS_INIT_DOT_STATIC)) {
        pos = (sqHead == 0U) ? RT_MILAN_POSITION_NUM_MAX_MINIV3 : (sqHead - 1U);
    } else {
        pos = (sqHead == 0U) ? (GetSqDepth() - 1U) : (sqHead - 1U);
    }
    error = GetTaskIdByPos(pos, lastTaskId);
    lastTaskId = lastTaskId & 0xFFFFU;
    if ((error != RT_ERROR_NONE) && (sqHead != 0U)) {
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "GetTaskIdByPos fail, sqHead=%hu", sqHead);
        return error;
    }
    return error;
}

rtError_t Stream::JudgeTaskFinish(uint16_t taskPos, bool &isFinished)
{
    UNUSED(taskPos);
    UNUSED(isFinished);
    return RT_ERROR_NONE;
}

rtError_t Stream::JudgeHeadTailPos(rtEventStatus_t * const status, uint16_t eventPos)
{
    COND_RETURN_WARN(device_ == nullptr, RT_ERROR_NONE, "device is null, stream_id=%d", streamId_);

    uint16_t sqHead = 0U;
    const uint32_t sqId = GetSqId();
    const uint32_t tsId = device_->DevGetTsId();
    const uint16_t sqTail = taskPosTail_.Value();
    const rtError_t error = device_->Driver_()->GetSqHead(device_->Id_(), tsId, sqId, sqHead);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Query sq head failed, retCode=%#x", static_cast<uint32_t>(error));
    if (sqHead < sqTail) {
        if (sqHead > eventPos || eventPos > sqTail) {
            *status = RT_EVENT_RECORDED;
        } else {
            *status = RT_EVENT_INIT;
        }
    } else if (sqHead > sqTail) {
        if (eventPos >= sqHead || eventPos < sqTail) {
            *status = RT_EVENT_INIT;
        } else {
            *status = RT_EVENT_RECORDED;
        }
    } else {
        *status = RT_EVENT_RECORDED;
    }
    RT_LOG(RT_LOG_INFO, "device_id=%u, status=%d, stream_id=%u, head=%u, tail=%u, pos=%u",
        device_->Id_(), *status, streamId_, sqHead, sqTail, eventPos);
    return RT_ERROR_NONE;
}

rtError_t Stream::GetLastFinishTaskId(const uint32_t taskId, uint32_t &currId, int32_t timeout)
{
    rtError_t errorCode = RT_ERROR_NONE;

    if (device_->IsStarsPlatform()) {
        errorCode = StarsWaitForTask(taskId, false, timeout);
        currId = taskId;
    } else {
        TaskInfo *eventRecordTsk = device_->GetTaskFactory()->GetTask(streamId_, static_cast<uint16_t>(taskId));
        if (eventRecordTsk == nullptr) {
            RT_LOG(RT_LOG_WARNING, "Get null task from stream_id=%d, task_id=%u", streamId_, taskId);
            errorCode = device_->QueryLatestTaskId(static_cast<uint32_t>(streamId_), currId);
            COND_RETURN_ERROR_MSG_INNER(errorCode != RT_ERROR_NONE, errorCode,
            "Query null Task status failed, retCode=%#x.", static_cast<uint32_t>(errorCode));
            return errorCode;
        }
        const uint64_t eventFlag = eventRecordTsk->u.eventRecordTaskInfo.event->GetEventFlag();
        if ((eventFlag & RT_EVENT_TIME_LINE) != 0U) {
            errorCode = WaitForTask(taskId, false, timeout);
            currId = taskId;
        } else {
            errorCode = device_->QueryLatestTaskId(static_cast<uint32_t>(streamId_), currId);
        }
        COND_RETURN_ERROR_MSG_INNER(errorCode != RT_ERROR_NONE, errorCode,
            "Query Task status failed, retCode=%#x.", static_cast<uint32_t>(errorCode));
    }
    return errorCode;
}

// dvpp rr task need 32 byte mem, addr align to 32 byte
// default align of DevMemAlloc is 4K(page size)
void* Stream::GetDvppRRTaskAddr(void)
{
    if (dvppRRTaskAddr_ != nullptr) {
        return dvppRRTaskAddr_;
    }

    const std::lock_guard<std::mutex> lock(dvppRRTaskAddrLock_);
    const rtError_t error = device_->Driver_()->DevMemAlloc(&dvppRRTaskAddr_, DVPP_RR_WRITE_VALUE_LEN,
        RT_MEMORY_DEFAULT, device_->Id_());
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Failed to malloc mem for dvpp rr task, stream_id=%d, retCode=%#x", streamId_, error);
        return nullptr;
    }

    RT_LOG(RT_LOG_INFO, "stream_id=%d", streamId_);
    return dvppRRTaskAddr_;
}

rtError_t Stream::SetFailMode(const uint64_t mode)
{
    if (device_->IsStarsPlatform()) {
        SetFailureMode(mode);
        SetMode(GetMode() | (mode & STREAM_FAILURE_MODE_MASK));
        context_->SetCtxMode(STOP_ON_FAILURE);
        RT_LOG(RT_LOG_INFO, "stream_id=%d is updated from CONTINUE to STOP.", Id_());
        // stars no need to send task
        return RT_ERROR_NONE;
    }
    rtError_t errorCode = RT_ERROR_NONE;
    TaskInfo submitTask = {};
    rtError_t errorReason;

    TaskInfo *tsk = AllocTask(&submitTask, TS_TASK_TYPE_SET_STREAM_MODE, errorReason);
    NULL_PTR_RETURN_MSG(tsk, errorReason);

    (void)SetStreamModeTaskInit(tsk, mode);
    errorCode = device_->SubmitTask(tsk);
    ERROR_GOTO_MSG_INNER(errorCode, RECYCLE, "Submit set stream failure mode task failed, retCode=%#x.",
        static_cast<uint32_t>(errorCode));
    SetFailureMode(mode);
    SetMode(GetMode() | (mode & STREAM_FAILURE_MODE_MASK));
    context_->SetCtxMode(STOP_ON_FAILURE);
    RT_LOG(RT_LOG_INFO, "stream_id=%d is updated from CONTINUE to STOP.", Id_());
    return errorCode;
RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(tsk);
    return errorCode;
}

void Stream::EnterFailureAbort()
{
    if (context_ == nullptr) {
        if (GetFailureMode() != STOP_ON_FAILURE) {
            return;
        }
    } else {
        if (IsSeparateSendAndRecycle()) {
            context_->PushContextErrMsg();
        }
        if (context_->GetCtxMode() != STOP_ON_FAILURE) {
            return;
        }
        if (context_->GetFailureError() == RT_ERROR_NONE) {
            context_->SetFailureError(GetError());
        }
    }
    SetFailureMode(ABORT_ON_FAILURE);
    RT_LOG(RT_LOG_ERROR, "stream_id=%d enter failure abort.", Id_());
    if (!Runtime::Instance()->GetDisableThread()) {
        const std::lock_guard<std::mutex> eventTaskLock(eventTaskListLock_);
        for (auto &evtTsk : eventTaskList) {
            if ((evtTsk != nullptr) && (evtTsk->type == TS_TASK_TYPE_EVENT_RECORD) && (evtTsk->stream == this)) {
                RT_LOG(RT_LOG_INFO, "stream_id=%u task_id=%u trigger event_id=%u.",
                    Id_(), evtTsk->id, evtTsk->u.eventRecordTaskInfo.eventid);
                TaskTriggerEvent(evtTsk);
            }
        }
        eventTaskList.clear();
    }
}
bool Stream::IsSeparateSendAndRecycle()
{
    return device_->IsStarsPlatform() && device_->GetIsChipSupportRecycleThread() && !IsBindDvppGrp() && !IsSoftwareSqEnable();
}

void Stream::EraseEventTask(TaskInfo* const tsk)
{
    if (Runtime::Instance()->GetDisableThread()) {
        return;
    }
    const std::lock_guard<std::mutex> eventTaskLock(eventTaskListLock_);
    if (tsk->type == TS_TASK_TYPE_EVENT_RECORD) {
        const auto it = eventTaskList.find(tsk);
        if (it == eventTaskList.end()) {
            return;
        }
        eventTaskList.erase(tsk);
        RT_LOG(RT_LOG_INFO, "stream_id=%d task_id=%u with event_id=%d is erased.",
            Id_(), tsk->id, tsk->u.eventRecordTaskInfo.eventid);
    }
}
void Stream::InsertEventTask(TaskInfo* const tsk)
{
    if (Runtime::Instance()->GetDisableThread()) {
        return;
    }
    if (GetFailureMode() == CONTINUE_ON_FAILURE) {
        return;
    }
    const std::lock_guard<std::mutex> eventTaskLock(eventTaskListLock_);
    if (tsk->type == TS_TASK_TYPE_EVENT_RECORD) {
        (void)eventTaskList.insert(tsk);
        RT_LOG(RT_LOG_INFO, "stream_id=%u task_id=%u with event_id=%d is inserted.",
            Id_(), tsk->id, tsk->u.eventRecordTaskInfo.eventid);
    }
}

bool Stream::AbortedStreamToFull() const
{
    if (taskPublicBuffSize_ < STREAM_TO_FULL_CNT) {
        return false;
    }
    if ((GetFailureMode() == ABORT_ON_FAILURE) && (GetPendingNum() >= (taskPublicBuffSize_ - STREAM_TO_FULL_CNT))) {
        return true;
    }
    return false;
}

void Stream::SetContextFailureCode()
{
    if (context_ != nullptr) {
        context_->SetFailureError(GetError());
    }
}

void Stream::DelPosToTaskIdMap(uint16_t pos) const
{
    const uint32_t rtsqDepth = (((flags_ & RT_STREAM_HUGE) != 0U) && (Runtime::macroValue_.maxTaskNumPerHugeStream != 0)) ?
        Runtime::macroValue_.maxTaskNumPerHugeStream : GetSqDepth();
    if (pos >= rtsqDepth) {
        return;
    }

    posToTaskIdMap_[pos] = MAX_UINT16_NUM;
}

bool Stream::IsExistCqe(void) const
{
    bool status = false;
    const uint32_t sqId = GetSqId();
    const uint32_t tsId = device_->DevGetTsId();

    rtError_t error = device_->Driver_()->GetCqeStatus(device_->Id_(), tsId, sqId, status);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_DEBUG, "Get cqe status failed, retCode=%#x.", error);
    }
    return status;
}

void Stream::AddTaskTag(const uint16_t taskId, const std::string &taskTag)
{
    const std::unique_lock<std::mutex> lk(taskIdToTaskTagMapMutex_);
    taskIdToTaskTagMap_[taskId] = taskTag;
}

void Stream::DelTaskTag(const uint16_t taskId)
{
    const std::unique_lock<std::mutex> lk(taskIdToTaskTagMapMutex_);
    (void)taskIdToTaskTagMap_.erase(taskId);
}

rtError_t Stream::GetStarsVersion()
{
    NULL_PTR_RETURN(device_, RT_ERROR_DEVICE_NULL);
    auto * const factory = device_->GetTaskFactory();

    TaskInfo taskSubmit = {};
    TaskInfo *tsk = &taskSubmit;
    Stream* stm = this;
    tsk->stream = stm;
    rtError_t error = RT_ERROR_TASK_NEW;
    if (taskResMang_ == nullptr) {
        tsk = factory->Alloc(stm, TS_TASK_TYPE_GET_STARS_VERSION, error);
        NULL_PTR_RETURN(tsk, error);
    }

    error = StarsVersionTaskInit(tsk);
    ERROR_GOTO(error, ERROR_TASK, "Failed to init get stars version task.");

    error = device_->SubmitTask(tsk);
    ERROR_GOTO(error, ERROR_TASK, "Failed to SubmitTask task.");
    error = stm->GetError();
    return error;
ERROR_TASK:
    (void)factory->Recycle(tsk);
    return error;
}

const std::string Stream::GetTaskTag(const uint16_t taskId)
{
    const std::unique_lock<std::mutex> lk(taskIdToTaskTagMapMutex_);
    auto iter = taskIdToTaskTagMap_.find(taskId);
    if (iter != taskIdToTaskTagMap_.end()) {
        return iter->second;
    }

    return "";
}

bool Stream::GetForceRecycleFlag(bool flag) const
{
    bool forceRecycleFlag = (flag || (GetFailureMode() == ABORT_ON_FAILURE));
    if ((context_ != nullptr) && (context_->GetFailureError() != RT_ERROR_NONE)) {
        forceRecycleFlag = true;
    }
    return forceRecycleFlag;
}

rtError_t Stream::ModelTaskUpdate(const Stream * desStm, uint32_t desTaskId, void *devCopyMem, uint32_t tilingTabLen,
                                  rtMdlTaskUpdateInfo_t *para)
{
    NULL_PTR_RETURN(device_, RT_ERROR_DEVICE_NULL);

    TaskInfo taskSubmit = {};
    rtError_t errorReason = RT_ERROR_NONE;
    TaskInfo *tsk = AllocTask(&taskSubmit, TS_TASK_TYPE_MODEL_TASK_UPDATE, errorReason);
    NULL_PTR_RETURN(tsk, errorReason);

    auto * const factory = device_->GetTaskFactory();
    rtError_t error = ModelTaskUpdateInit(tsk, static_cast<uint16_t>(desStm->Id_()), desTaskId, 
                                          static_cast<uint16_t>(Id_()), devCopyMem, tilingTabLen, para);
    COND_PROC((error == RT_ERROR_DRV_IOCTRL),
        RT_LOG(RT_LOG_ERROR, "MemTranslate offset may used out, Please reduce IFA update task num."));

    ERROR_GOTO(error, ERROR_TASK, "Failed to init model update task.error=%d.", error);

    RT_LOG(RT_LOG_DEBUG, "SubmitTask streamId_=%u tsk->id=%u.", Id_(), tsk->id);
    error = device_->SubmitTask(tsk);
    ERROR_GOTO(error, ERROR_TASK, "Failed to submit model update task. error=%d.", error);

    return RT_ERROR_NONE;
ERROR_TASK:
    (void)factory->Recycle(tsk);
    return error;
}

Model* Stream::Model_() const
{
    for (auto it = models_.begin(); it != models_.end(); it++) {
        if (*it != nullptr) {
            return *it;
        }
    }
    return nullptr;
}

bool Stream::IsModelsDebugRegister() const
{
    for (auto it = models_.begin(); it != models_.end(); it++) {
        if ((*it)->IsDebugRegister()) {
            return true;
        }
    }
    return false;
}

void Stream::FreeOnlineProf() const
{
    rtError_t error;
    (void)Device_()->DevSetOnlineProfStart(false);
    if (onProfDeviceAddr_ != nullptr) {
        error = device_->Driver_()->DevMemFree(onProfDeviceAddr_, device_->Id_());
        COND_LOG(error != RT_ERROR_NONE, "Free online profiling memory deviceMem failed, retCode=%#x",
            static_cast<uint32_t>(error));
    }
    if (onProfHostRtAddr_ != nullptr) {
        error = device_->Driver_()->HostMemFree(onProfHostRtAddr_);
        COND_LOG(error != RT_ERROR_NONE, "Free online profiling memory hostRtMem failed, retCode=%#x",
            static_cast<uint32_t>(error));
    }
    if (onProfHostTsAddr_ != nullptr) {
        error = device_->Driver_()->HostMemFree(onProfHostTsAddr_);
        COND_LOG(error != RT_ERROR_NONE, "Free online profiling memory hostTsMem failed, retCode=%#x",
            static_cast<uint32_t>(error));
    }
}

void Stream::ResetStreamConstruct()
{
    lastTaskId_ = MAX_UINT16_NUM;
    checkTaskId_ = MAX_UINT32_NUM;
    (void)FreeOnlineProf();
    taskHead_ = 0U;
    taskTail_ = 0U;
    davinciTaskHead_ = 0U;
    davinciTaskTail_ = 0U;
    finishTaskId_ = MAX_UINT32_NUM;
    earlyRecycleTaskHead_ = 0U;
    taskIdFlipNum_.Set(0);
    recycleFlag_.Set(false);
    limitFlag_.Set(false);
    (void)memset_s(posToTaskIdMap_, posToTaskIdMapSize_ * sizeof(uint16_t), 0xFFU,
        posToTaskIdMapSize_ * sizeof(uint16_t));
    SetRecycleEndTaskId(MAX_UINT16_NUM);
    SetExecuteEndTaskId(static_cast<uint16_t>(MAX_UINT16_NUM));
    taskPosHead_.Set(0);
    taskPosTail_.Set(0);
    isNeedRecvCqe_ = false;
    needSync_ = false;
    lastRecyclePos_ = 0xFFFFU;
    pendingNum_.Set(0);
    sqTailPos_ = 0U;
    sqHeadPos_ = 0U;
    fftsMemAllocCnt = 0U;
    fftsMemFreeCnt = 0U;
    syncTimeout_ = -1;
    isForceRecycle_ = false;
    errCode_ = 0U;
    drvErr_ = 0U;
    failureMode_ = GetMode();
    SetStreamAsyncRecycleFlag(false);
    errorMsg_.clear();
    taskIdToTaskTagMap_.clear();
    latestConcernedTaskId.Set(MAX_UINT16_NUM);
    if (taskResMang_ != nullptr) {
        taskResMang_->ResetTaskRes();
    }
}

rtError_t Stream::ResClear(uint64_t timeout)
{
    // old sq stop and head == tail
    Device *const dev = device_;
    RT_LOG(
        RT_LOG_INFO, "stream_id=%d, pendingNum=%u, force recycle, recycle task begin.", streamId_, pendingNum_.Value());
    uint64_t tryCount = 0;
    constexpr uint64_t perDetectTimes = 1000U;
    mmTimespec startCnt = {};
    mmTimespec endCnt = {};
    uint64_t startTime;
    uint64_t endTime; 
    startCnt = mmGetTickCount();
    startTime= static_cast<uint64_t>(startCnt.tv_sec) * RT_MS_PER_S +
               static_cast<uint64_t>(startCnt.tv_nsec) / RT_MS_TO_NS;
    while (pendingNum_.Value() > 0U) {
        COND_RETURN_ERROR((device_->GetDevRunningState() == static_cast<uint32_t>(DEV_RUNNING_DOWN)), RT_ERROR_DRV_ERR,
            "device_id=%u is down, clear stream_id=%u", device_->Id_(), streamId_);
        StreamSyncLock();
        isForceRecycle_ = true;
        SetNeedRecvCqeFlag(false);
        if (IsSeparateSendAndRecycle()) {
            StreamRecycleLock();
            (void)dev->RecycleSeparatedStmByFinishedId(this, static_cast<uint16_t>(lastTaskId_));
            StreamRecycleUnlock();
        } else {
            uint32_t reclaimTaskId = UINT32_MAX;
            (void)dev->TaskReclaim(static_cast<uint32_t>(streamId_), false, reclaimTaskId);
        }
        StreamSyncUnLock();
        tryCount++;
        if(timeout >0 && tryCount % perDetectTimes == 0) {
            endCnt = mmGetTickCount();
            endTime = static_cast<uint64_t>(endCnt.tv_sec) * RT_MS_PER_S +
            static_cast<uint64_t>(endCnt.tv_nsec) / RT_MS_TO_NS;
            COND_RETURN_ERROR(((endTime - startTime) > timeout), RT_ERROR_WAIT_TIMEOUT, "task reclaim timeout, "
                "stream_id=%d, sq_id=%u, cq_id=%u, pendingNum=%u", streamId_, sqId_, cqId_, pendingNum_.Value());
        }
    }
    const rtError_t error = device_->Driver_()->MemSetSync(executedTimesSvm_, sizeof(uint16_t), 0xFFU, sizeof(uint16_t));
    // reconstruct will modify resHead and resTail, lock by recycleMutex_.
    StreamRecycleLock();
    ResetStreamConstruct();
    StreamRecycleUnlock();
    dev->GetTaskFactory()->ClearSerialVecId(this);
    if (isSupportASyncRecycle_) {
        dev->DelStreamFromMessageQueue(this);
    }
    RT_LOG(RT_LOG_INFO, "stream_id=%d, pendingNum=%u, recycle task end.", streamId_, pendingNum_.Value());
    return error;
}

void Stream::Destructor() {
    if ((((flags_ & RT_STREAM_FORBIDDEN_DEFAULT) == 0U) && ((flags_ & RT_STREAM_AICPU) == 0U))) {
        device_->GetStreamSqCqManage()->DelStreamIdToStream(static_cast<uint32_t>(streamId_));
    }
    if (myself == nullptr) {
        delete this;
    } else {
        myself.reset();
    }
}

rtError_t Stream::ModelAbortById(uint32_t modelId)
{
    UNUSED(modelId);
    return RT_ERROR_NONE;
}

uint8_t Stream::GetGroupId() const
{
    uint8_t groupId = UNINIT_GROUP_ID;
    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_GROUP_THREAD_LOCAL)) {
        const uint8_t tmpGroupId = InnerThreadLocalContainer::GetGroupId();
        groupId = (tmpGroupId != UNINIT_GROUP_ID) ? tmpGroupId : device_->GetGroupId();
    } else {
        groupId = device_->GetGroupId();
    }

    return groupId;
}

void Stream::SingleStreamTerminateCapture()
{
    SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_INVALIDATED);
    Stream *curCaptureStream = GetCaptureStream();
    if (curCaptureStream != nullptr) {
        CaptureModel *captureModel = static_cast<CaptureModel *>(curCaptureStream->Model_());
        if (captureModel != nullptr) {
            captureModel->TerminateCapture();
        }
    }
}

rtError_t Stream::AllocCascadeCaptureStream(Stream *&newCaptureStream, const Stream * const curCaptureStream)
{
    Context * const ctx = Context_();
    const rtError_t error = ctx->AllocCascadeCaptureStream(this, curCaptureStream->Model_(),
                                                     &newCaptureStream);
    if ((error != RT_ERROR_NONE) || (newCaptureStream == nullptr)) {
        SingleStreamTerminateCapture();
        RT_LOG(RT_LOG_ERROR, "alloc capture stream failed, device_id=%u, original stream_id=%d.",
            device_->Id_(), Id_());
        return error;
    }
    if (curCaptureStream->Model_() != nullptr) {
        CaptureModel *captureModel = static_cast<CaptureModel *>(curCaptureStream->Model_());
        auto &addStreamMap = captureModel->GetAddStreamMap();
        auto it = addStreamMap.find(this);
        if (it != addStreamMap.end()) {
            captureModel->SetAddStreamMap(this, newCaptureStream);
        }
    }
    return RT_ERROR_NONE;
}

void Stream::UpdateCascadeCaptureStreamInfo(Stream *newCaptureStream, Stream *curCaptureStream)
{        
    curCaptureStream->CancelLastLevelCaptureStream();
    newCaptureStream->MarkOrigCaptureStream(curCaptureStream->IsOrigCaptureStream());
    newCaptureStream->UpdateCurrentTaskGroup(curCaptureStream->GetCurrentTaskGroup());
    curCaptureStream->ResetTaskGroup();
    CaptureModel *captureModel = static_cast<CaptureModel *>(curCaptureStream->Model_());
    if (captureModel != nullptr) {
        captureModel->ReplaceTaskGroupStreamId(
            static_cast<uint16_t>(curCaptureStream->Id_()),
            static_cast<uint16_t>(newCaptureStream->Id_()));
        captureModel->InsertSingleOperStmIdAndCaptureStmId(Id_(), newCaptureStream->Id_());
    }
    UpdateCaptureStream(newCaptureStream);
}

rtError_t Stream::AllocCaptureTask(tsTaskType_t taskType, uint32_t sqeNum, TaskInfo **task)
{
    std::unique_lock<std::mutex> lk(captureLock_);
    Stream *curCaptureStream = GetCaptureStream();
    if (curCaptureStream == nullptr) {
        /* stm exit capture mode */
        return RT_ERROR_STREAM_CAPTURE_EXIT;
    }

    COND_PROC_RETURN_ERROR(IsTaskGroupBreak(), RT_ERROR_STREAM_TASKGRP_INTR,
        SetTaskGroupErrCode(RT_ERROR_STREAM_TASKGRP_INTR), "the task group interrupted.");

    if ((curCaptureStream->GetCaptureSqeNum() + CAPTURE_TASK_RESERVED_NUM) >= curCaptureStream->GetSqDepth()) {
        Stream *newCaptureStream = nullptr;
        Context * const ctx = Context_();
        if (ctx == nullptr) {
            SingleStreamTerminateCapture();
            RT_LOG(RT_LOG_ERROR, "context is null, device_id=%u, original stream_id=%d.",
                device_->Id_(), Id_());
            return RT_ERROR_CONTEXT_NULL;
        }
        rtError_t error = AllocCascadeCaptureStream(newCaptureStream, curCaptureStream);
        COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
        error = ctx->StreamActive(newCaptureStream, curCaptureStream);
        if (error != RT_ERROR_NONE) {
            ctx->FreeCascadeCaptureStream(newCaptureStream);
            SingleStreamTerminateCapture();
            RT_LOG(RT_LOG_ERROR, "stream active failed, device_id=%u, original stream_id=%d.",
                device_->Id_(), Id_());
            return error;
        }
        UpdateCascadeCaptureStreamInfo(newCaptureStream, curCaptureStream);
        curCaptureStream = newCaptureStream;
    }
    rtError_t errCode = RT_ERROR_TASK_NEW;
    if (curCaptureStream->taskResMang_ == nullptr) {
        *task = device_->GetTaskFactory()->Alloc(curCaptureStream, taskType, errCode);
    }
    if (*task != nullptr) {
        curCaptureStream->AddCaptureSqeNum(sqeNum);
        (*task)->stream = curCaptureStream;
    } else {
        SingleStreamTerminateCapture();
        return errCode;
    }
    RT_LOG(RT_LOG_INFO,
        "Alloc task in capture stream successfully, device id = %u, origin stream_id=%d, capture stream_id=%d.",
        device_->Id_(), Id_(), curCaptureStream->Id_());
    return RT_ERROR_NONE;
}

rtError_t Stream::UpdateTask(TaskInfo** updateTask)
{
    *updateTask = nullptr;
    const std::lock_guard<std::mutex> tskGrpLock(GetTaskGrpMutex());
    TaskGroup *updateTaskGroup = GetUpdateTaskGroup();

    if (updateTaskGroup == nullptr) {
        RT_LOG(RT_LOG_ERROR, "updateTaskGroup is nullptr");
        return RT_ERROR_INVALID_VALUE;
    }

    uint32_t taskIndex = updateTaskGroup->updateTaskIndex;
    if (taskIndex >= updateTaskGroup->taskIds.size()) {
        RT_LOG(RT_LOG_ERROR,
            "task num exceed task group size, current task index=%u, task group size=%u.",
            taskIndex,
            updateTaskGroup->taskIds.size());
        return RT_ERROR_STREAM_TASKGRP_UPDATE;
    }

    auto& taskIdPair = updateTaskGroup->taskIds[taskIndex];
    const uint16_t streamId = taskIdPair.first;
    const uint16_t taskId = taskIdPair.second;

    TaskInfo* taskInfo = GetStreamTaskInfo(device_, streamId, taskId);
    if (unlikely(taskInfo == nullptr)) {
        RT_LOG(RT_LOG_ERROR,
            "update task stream_id or task_id is invalid, stream_id=%hu, task_id=%hu.", streamId, taskId);
        return RT_ERROR_STREAM_TASKGRP_UPDATE;
    }

    taskInfo->isUpdateSinkSqe = 1U;
    *updateTask = taskInfo;
    UpdateTaskIndex(taskIndex + 1U);
    RT_LOG(RT_LOG_DEBUG, "stream_id=%hu, task_id=%hu, current task index=%u, task group size=%u",
        streamId, taskId, taskIndex, updateTaskGroup->taskIds.size());
    return RT_ERROR_NONE;
}

TaskInfo* Stream::AllocTask(TaskInfo* pTask, tsTaskType_t taskType, rtError_t& errorReason,
    uint32_t sqeNum, UpdateTaskFlag flag)
{
    errorReason = RT_ERROR_TASK_NEW;
    /* update task group scene */
    if (IsTaskGroupUpdate()) {
        TaskInfo* updateTask = nullptr;
        if (flag == UpdateTaskFlag::SUPPORT) {
            errorReason = UpdateTask(&updateTask);
            return updateTask;
        } else if (flag != UpdateTaskFlag::NOT_SUPPORT_AND_SKIP) {
            RT_LOG(RT_LOG_ERROR, "Unsupported task type for task update.");
            errorReason = RT_ERROR_TASK_NOT_SUPPORT;
            return updateTask;
        } else {
            // do nothing
        }
    }

    /* capture sense */
    if ((GetCaptureStatus() != RT_STREAM_CAPTURE_STATUS_NONE)) {
        TaskInfo* captureTask = pTask;
        const rtError_t error = AllocCaptureTask(taskType, sqeNum, &captureTask);
        if (error != RT_ERROR_STREAM_CAPTURE_EXIT) {
            errorReason = error;
            return error == RT_ERROR_NONE ? captureTask : nullptr;
        }
    }

    if (taskResMang_ == nullptr) {
        return device_->GetTaskFactory()->Alloc(this, taskType, errorReason);
    } else {
        pTask->stream = this;
        return pTask;
    }
}

rtError_t Stream::TaskReclaim(void)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t currId = UINT32_MAX;

    StreamSyncLock();
    error = device_->TaskReclaim(static_cast<uint32_t>(streamId_), false, currId);
    StreamSyncUnLock();
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "stream_id=%d, device_id=%u, retCode=%#x.", Id_(), device_->Id_(), error);
    return error;
}

void Stream::EnterCapture(const Stream * const captureStream)
{
    /* enter capture status */
    CaptureModel *captureMdl = RtPtrToPtr<CaptureModel *>(captureStream->Model_());
    if (captureMdl != nullptr) {
        captureMdl->EnterCaptureNotify(Id_(), captureStream->Id_());
    }

    std::unique_lock<std::mutex> lk(captureLock_);
    UpdateCaptureStream(captureStream);
    SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_ACTIVE);

    if (captureStream->IsOrigCaptureStream()) {
        captureMdl->SetModelCacheOpInfoSwitch(GetStreamCacheOpInfoOriginSwitch());
    } else {
        SetStreamCacheOpInfoSwitch(captureMdl->GetModelCacheOpInfoSwitch());
    }

    return;
}

void Stream::ResetCaptureInfo()
{
    /* exit capture status */
    std::unique_lock<std::mutex> lk(captureLock_);
    UpdateCaptureStream(nullptr);
    SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_NONE);

    return;
}

void Stream::ExitCapture()
{
    /* exit capture status */
    Stream *captureStream = GetCaptureStream();
    if (captureStream != nullptr) {
        CaptureModel *captureMdl = dynamic_cast<CaptureModel *>(captureStream->Model_());
        if (captureMdl != nullptr) {
            captureMdl->ExitCaptureNotify();
            captureMdl->SetModelCacheOpInfoSwitch(0);
        }
    }

    ResetCaptureInfo();
    return;
}

bool Stream::IsStreamFull(const uint32_t head, const uint32_t tail, const uint32_t depth, const uint32_t addCnt)
{
    if ((tail < head) && (tail + addCnt >= head)) {
        return true;
    }
    if ((tail >= head) && (tail + addCnt >= depth) && (((tail + addCnt) % depth) >= head)) {
        return true;
    }
    return false;
}

void Stream::GetTaskEventIdOrNotifyId(TaskInfo *taskInfo, int32_t &eventId, uint32_t &notifyId, uint64_t &devAddr) const
{
    EventRecordTaskInfo *eventRecordTaskInfo = nullptr;
    EventWaitTaskInfo *eventWaitTaskInfo = nullptr;
    EventResetTaskInfo *eventResetTaskInfo = nullptr;
    NotifyWaitTaskInfo* notifyWaitTask = nullptr;
    NotifyRecordTaskInfo *notifyRecord = nullptr;
    MemWriteValueTaskInfo *memWriteValueTask = nullptr;
    MemWaitValueTaskInfo *memWaitValueTask = nullptr;

    switch (taskInfo->type) {
        case TS_TASK_TYPE_EVENT_RECORD:
            eventRecordTaskInfo = &(taskInfo->u.eventRecordTaskInfo);
            eventId = eventRecordTaskInfo->eventid;
            break;
        case TS_TASK_TYPE_STREAM_WAIT_EVENT:
            eventWaitTaskInfo = &(taskInfo->u.eventWaitTaskInfo);
            eventId = eventWaitTaskInfo->eventId;
            break;
        case TS_TASK_TYPE_EVENT_RESET:
            eventResetTaskInfo = &(taskInfo->u.eventResetTaskInfo);
            eventId = eventResetTaskInfo->eventid;
            break;
        case TS_TASK_TYPE_NOTIFY_WAIT:
            notifyWaitTask = &(taskInfo->u.notifywaitTask);
            notifyId = notifyWaitTask->notifyId;
            break;
        case TS_TASK_TYPE_NOTIFY_RECORD:
            notifyRecord = &(taskInfo->u.notifyrecordTask);
            notifyId = notifyRecord->notifyId;
            break;
        case TS_TASK_TYPE_CAPTURE_RECORD:
        case TS_TASK_TYPE_MEM_WRITE_VALUE:
            memWriteValueTask = &taskInfo->u.memWriteValueTask;
            devAddr = memWriteValueTask->devAddr;
            break;
        case TS_TASK_TYPE_CAPTURE_WAIT:
        case TS_TASK_TYPE_MEM_WAIT_VALUE:
            memWaitValueTask = &taskInfo->u.memWaitValueTask;
            devAddr = memWaitValueTask->devAddr;
            break;

        default:
            break;    
    }
}

rtError_t Stream::AllocSoftwareSqAddr(uint32_t additionalSqeNum)
{
    rtError_t ret = RT_ERROR_NONE;
    if (GetSqBaseAddr() == 0ULL) {
        const uint32_t deviceId = Context_()->Device_()->Id_();
        SqAddrMemoryOrder *sqAddrMemoryManage = Context_()->Device_()->GetSqAddrMemoryManage();
        COND_RETURN_ERROR((sqAddrMemoryManage == nullptr), RT_ERROR_INVALID_VALUE,
            "sqAddrMemoryManage is null. device_id=%u", deviceId);

        uint64_t *sqBaseAddr = nullptr;
        const uint32_t allocMemSize = (GetDelayRecycleTaskSqeNum() + additionalSqeNum) * sizeof(rtStarsSqe_t);
        const uint32_t memOrderType = sqAddrMemoryManage->GetMemOrderTypeByMemSize(allocMemSize);
        const uint32_t memOrderSize = sqAddrMemoryManage->GetMemOrderSizeByMemOrderType(memOrderType);
        uint32_t sqDepthAfterUpdate = memOrderSize / sizeof(rtStarsSqe_t);

        ret = Context_()->Device_()->GetSqAddrMemoryManage()->AllocSqAddr(memOrderType, &sqBaseAddr);
        COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret, "AllocSqAddr failed. device_id=%u, stream_id=%d, "
            "retCode=%#x,", deviceId, Id_(), ret);

        SetSqBaseAddr(RtPtrToValue(sqBaseAddr));
        SetSqMemOrderType(memOrderType);
        SetSqDepth(sqDepthAfterUpdate);
    }

    return ret;
}

void Stream::DebugDotPrintForModelStm()
{
    if (!GetBindFlag()) {
        RT_LOG(RT_LOG_DEBUG, "non-model stream, device_id=%u, stream_id=%d.", device_->Id_(), Id_());
        return;
    }

    std::vector<uint16_t>::iterator it;
    for (it = delayRecycleTaskid_.begin(); it != delayRecycleTaskid_.end(); ++it) {
        const uint16_t taskId = *it;
        TaskInfo *task = device_->GetTaskFactory()->GetTask(Id_(), taskId);
        if (task == nullptr) {
            continue;
        }

        int32_t eventId = INVALID_EVENT_ID;
        uint32_t notifyId = MAX_UINT32_NUM;
        uint64_t devAddr = MAX_UINT64_NUM;
        GetTaskEventIdOrNotifyId(task, eventId, notifyId, devAddr);

        if (eventId != INVALID_EVENT_ID) {
            RT_LOG(RT_LOG_EVENT, "device_id=%u, stream_id=%d, task_id=%hu, task_type=%s, event_id=%d.",
                device_->Id_(), Id_(), taskId, task->typeName, eventId);
            continue;
        }

        if (notifyId != MAX_UINT32_NUM) {
            RT_LOG(RT_LOG_EVENT, "device_id=%u, stream_id=%d, task_id=%hu, task_type=%s, notify_id=%u.",
                device_->Id_(), Id_(), taskId, task->typeName, notifyId);
            continue;
        }

        if ((task->type == TS_TASK_TYPE_KERNEL_AICORE) || (task->type == TS_TASK_TYPE_KERNEL_AIVEC)) {
            std::string mixTypeName = "NO_MIX";
            const auto &aicTaskInfo = task->u.aicTaskInfo;
            const uint8_t mixType = (aicTaskInfo.kernel != nullptr) ? aicTaskInfo.kernel->GetMixType() : 0U;
            if (mixType == MIX_AIC || mixType == MIX_AIC_AIV_MAIN_AIC) {
                (void)mixTypeName.assign("MIX_AIC");
            } else if (mixType == MIX_AIV || mixType == MIX_AIC_AIV_MAIN_AIV) {
                (void)mixTypeName.assign("MIX_AIV");
            } else {
                ;
            }

            RT_LOG(RT_LOG_EVENT, "device_id=%u, stream_id=%d, task_id=%hu, task_type=%s, mix_type=%s.",
                device_->Id_(), Id_(), taskId, task->typeName, mixTypeName.c_str());
            continue;    
        }

        RT_LOG(RT_LOG_EVENT, "device_id=%u, stream_id=%d, task_id=%hu, task_type=%s.",
            device_->Id_(), Id_(), taskId, task->typeName);
    }
}

std::string Stream::TraceEventToJson(const TraceEvent &record) const
{
    std::ostringstream oss;
    oss << "{";
    oss << "\"name\":\"" << record.name << "\",";
    oss << "\"pid\":\"" << record.pid << "\",";
    oss << "\"tid\":\"" << record.tid << "\",";
    oss << "\"ts\":" << record.ts << ",";
    oss << "\"dur\":" << record.dur << ",";
    oss << "\"ph\":\"" << record.ph << "\",";
    oss << "\"args\":{";
    oss << "\"Model Id\":" << record.args.modelId << ",";
    oss << "\"Stream Id\":" << record.args.streamId << ",";
    oss << "\"Task Id\":" << record.args.taskId;
    oss << "}";
    oss << "}";
    return oss.str();
}

void Stream::DebugJsonPrintForModelStm(std::ofstream& outputFile, const uint32_t modelId, const bool isLastStm)
{
    if (!GetBindFlag()) {
        RT_LOG(RT_LOG_DEBUG, "non-model stream, device_id=%u, stream_id=%d.", device_->Id_(), Id_());
        return;
    }
    std::vector<uint16_t>::iterator it;
    std::vector<TraceEvent> recordArray;
    pid_t pid = getpid();
    uint32_t taskDur = 0;
    for (it = delayRecycleTaskid_.begin(); it != delayRecycleTaskid_.end(); ++it) {
        TraceEvent record;
        const uint16_t taskId = *it;
        TaskInfo *task = device_->GetTaskFactory()->GetTask(Id_(), taskId);
        if (task == nullptr) {
            continue;
        }

        std::string taskName;
        const Kernel *kernel = nullptr;
        if ((task->type == TS_TASK_TYPE_KERNEL_AICORE) || (task->type == TS_TASK_TYPE_KERNEL_AIVEC)) {
            std::string kernelNameStr = "";
            AicTaskInfo *aicTaskInfo = &(task->u.aicTaskInfo);
            kernel = aicTaskInfo->kernel;
            kernelNameStr = (kernel != nullptr) ? kernel->Name_() : "AICORE_KERNEL";
            taskName = kernelNameStr;
        } else if (task->type == TS_TASK_TYPE_KERNEL_AICPU) {
            AicpuTaskInfo *aicpuTaskInfo = &(task->u.aicpuTaskInfo);
            kernel = aicpuTaskInfo->kernel;
            std::string kernelName = (kernel != nullptr) ? kernel->GetCpuOpType() : "AICPU_KERNEL";
            taskName = (!kernelName.empty()) ? kernelName : "AICPU_KERNEL";
        } else {
            taskName = task->typeName;
        }

        int32_t eventId = INVALID_EVENT_ID;
        uint32_t notifyId = MAX_UINT32_NUM;
        uint64_t devAddr = MAX_UINT64_NUM;
        GetTaskEventIdOrNotifyId(task, eventId, notifyId, devAddr);
        if (eventId != INVALID_EVENT_ID) {
            record.name = taskName + "_" + std::to_string(eventId);
        } else if (notifyId != MAX_UINT32_NUM) {
            record.name = taskName + "_" + std::to_string(notifyId);
        } else if (devAddr != MAX_UINT64_NUM) {
            record.name = taskName + "_" + std::to_string(devAddr);
        } else {
            record.name = taskName;
        }

        record.pid = std::to_string(pid) + " aclGraph";
        record.tid = "stream" + std::to_string(streamId_);
        record.ts = taskDur;
        taskDur += 10;
        record.dur = 9.5;
        record.ph =  "X";	
        record.args.modelId = modelId;
        record.args.streamId = streamId_;
        record.args.taskId = task->id;
        recordArray.emplace_back(record);
    }

    //translate record array to json string;
    std::ostringstream json_array;
    for (size_t i = 0; i < recordArray.size(); ++i) {
        json_array << TraceEventToJson(recordArray[i]);
        if ((i < recordArray.size() - 1) || (isLastStm == false)) {
            json_array << ",";
        }
        json_array << "\n";
    }
    // write to json file;
    outputFile << json_array.str();
}

rtError_t Stream::UpdateTaskGroupStatus(const StreamTaskGroupStatus status)
{
    if (status == taskGroupStatus_) {
        return RT_ERROR_NONE;
    }
    if (status >= StreamTaskGroupStatus::BUTT) {
        return RT_ERROR_STREAM_TASKGRP_STATUS;
    }
    if ((status != StreamTaskGroupStatus::NONE) &&
        (taskGroupStatus_ != StreamTaskGroupStatus::NONE)) {
        return RT_ERROR_STREAM_TASKGRP_STATUS;
    }
    taskGroupStatus_ = status;
    return RT_ERROR_NONE;
}

bool Stream::IsTaskGrouping(void) const
{
    return (taskGroupStatus_ == StreamTaskGroupStatus::SAMPLE);
} 

bool Stream::IsTaskGroupBreak() const
{
    if (captureStream_ == nullptr) {
        return false;
    }
    if (captureStream_->GetCurrentTaskGroup() != nullptr) {
        return false;
    }
    CaptureModel * const mdl = dynamic_cast<CaptureModel *>(captureStream_->Model_());
    if (mdl == nullptr) {
        RT_LOG(RT_LOG_ERROR, "capture model is NULL, stream_id=%d.", Id_());
        return true;
    }
    std::set<uint16_t>& stmIds = mdl->GetTaskGroupStreamIds();
    return (!stmIds.empty());
}

void Stream::SetTaskGroupErrCode(const rtError_t errorCode) const
{
    CaptureModel *mdl = nullptr;
    if (captureStream_ == nullptr) {
        mdl = dynamic_cast<CaptureModel *>(Model_());
    } else {
        mdl = dynamic_cast<CaptureModel *>(captureStream_->Model_());
    }
    if (mdl == nullptr) {
        RT_LOG(RT_LOG_ERROR, "capture model is NULL, stream_id=%d.", Id_());
        return;
    }
    mdl->TerminateCapture();
    mdl->SetTaskGroupErrCode(errorCode);
}

rtError_t Stream::PackingTaskGroup(const TaskInfo * const task, const uint16_t streamId)
{
    NULL_PTR_RETURN_NOLOG(taskGroup_, RT_ERROR_NONE);
    if (task->type == TS_TASK_TYPE_STREAM_ACTIVE) {
        /* 过滤掉capture model级联场景下隐式添加的StreamActive任务 */
        return RT_ERROR_NONE;
    }
    if (!TaskTypeIsSupportTaskGroup(task)) {
        RT_LOG(RT_LOG_ERROR, "Unsupported task type %d(%s) in task group.", task->type, task->typeName);
        return RT_ERROR_TASK_NOT_SUPPORT;
    }
    taskGroup_->taskIds.emplace_back(streamId, task->id);
    return RT_ERROR_NONE;
}

void Stream::InsertResLimit(const rtDevResLimitType_t type, const uint32_t value)
{
    if (type < RT_DEV_RES_TYPE_MAX && type >= 0) {
        resLimitArray_[type] = value;
        resLimitFlag_[type] = true;
    }
}

void Stream::ResetResLimit(void)
{
    for (uint32_t i = 0; i < RT_DEV_RES_TYPE_MAX; i++) {
        resLimitArray_[i] = 0U;
        resLimitFlag_[i] = false;
    }
}

bool Stream::GetResLimitFlag(const rtDevResLimitType_t type) const
{
    if (type < RT_DEV_RES_TYPE_MAX && type >= 0) {
        return resLimitFlag_[type];
    }
    return false;
}

uint32_t Stream::GetResValue(const rtDevResLimitType_t type) const
{
    if (type < RT_DEV_RES_TYPE_MAX && type >= 0) {
        return resLimitArray_[type];
    }
    return 0U;
}

rtError_t Stream::UpdateSnapShotSqe()
{    
    const size_t size = delayRecycleTaskid_.size();
    for (size_t i = 0U; i < size; i++) {
        const uint16_t taskId = delayRecycleTaskid_[i];
        TaskInfo *task = device_->GetTaskFactory()->GetTask(Id_(), taskId);
        NULL_PTR_RETURN_MSG(task, RT_ERROR_INVALID_VALUE);
        if (IsNeedUpdateTask(task)) {
            const rtError_t error = SubmitMemCpyAsyncTask(task);
            ERROR_RETURN(error, "update task failed, ret=%d", error);
        }
    }

    Stream * const defaultStream = context_->DefaultStream_();
    constexpr uint32_t waitTimeout = 1000u * 60u * 10u; // 超时等待十分钟
    const rtError_t error = defaultStream->Synchronize(false, waitTimeout);
    ERROR_RETURN(error, "Synchronize failed, streamId=%u, retCode=%#x.", Id_(), error);
    return RT_ERROR_NONE;
}

bool Stream::IsNeedUpdateTask(const TaskInfo * const updateTask) const
{
    const std::vector<tagTsTaskType> updateTasks =
        {TS_TASK_TYPE_STREAM_SWITCH, TS_TASK_TYPE_MODEL_TASK_UPDATE};
    
    return std::find(updateTasks.begin(), updateTasks.end(), updateTask->type) != updateTasks.end();
}

rtError_t Stream::SubmitMemCpyAsyncTask(TaskInfo * const updateTask)
{
    void *sqeDeviceAddr = nullptr;
    rtError_t error = RT_ERROR_NONE;

    error = device_->Driver_()->DevMemAlloc(
        &sqeDeviceAddr, static_cast<uint64_t>(sizeof(rtStarsSqe_t)), RT_MEMORY_HBM, device_->Id_());
    COND_RETURN_ERROR((error != RT_ERROR_NONE) || (sqeDeviceAddr == nullptr), error,
            "DevMemAlloc failed, retCode=%#x.", error);
    updateTask->stream->RecordDevMemAddr(sqeDeviceAddr);

    error = UpdateTaskH2DSubmit(updateTask, context_->DefaultStream_(), sqeDeviceAddr);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, RT_ERROR_NONE, "h2d task submit failed, ret=%d", error);
 
    error = UpdateTaskD2HSubmit(updateTask, sqeDeviceAddr, context_->DefaultStream_());
    COND_RETURN_ERROR(error != RT_ERROR_NONE, RT_ERROR_NONE, "d2h task submit failed, ret=%d", error);
    return RT_ERROR_NONE;
}
}  // namespace runtime
}  // namespace cce
