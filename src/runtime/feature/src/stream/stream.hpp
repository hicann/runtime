/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_STREAM_HPP__
#define __CCE_RUNTIME_STREAM_HPP__

#include <list>
#include <vector>
#include <mutex>
#include <set>
#include <fstream>
#include <sstream>
#include "base.hpp"
#include "osal.hpp"
#include "driver/ascend_hal.h"
#include "group_device.hpp"
#include "npu_driver.hpp"
#include "host_task.hpp"
#include "task_info.hpp"
#include "device_sq_cq_pool.hpp"
#include "sq_addr_memory_pool.hpp"
#include "task_info.hpp"

constexpr size_t PTE_LENGTH = 16U;

constexpr uint16_t STREAM_TASK_BUFF_SIZE = 1025U;
constexpr uint16_t STREAM_PUBLIC_TASK_BUFF_SIZE = 10241U;
constexpr uint32_t TASK_NO_SEND_CQ_MAX = 32U;
constexpr uint32_t ACTIVE_TASK_CNT_MAX = 1U;
constexpr uint32_t DVPP_RR_WRITE_VALUE_LEN = 32U;
// Dvpp send 2 write value, Consistent runtime
constexpr uint32_t DVPP_RR_TASK_NUM = 2U;
constexpr uint32_t CTRLSQ_SYNC_CNT = 1000U;
constexpr uint32_t RECYCLE_CNT = 32U;
constexpr uint32_t RECYCLE_INTERVAL = 10U;
constexpr uint64_t STREAM_FAILURE_MODE_MASK = 0x00000001U;
constexpr uint32_t STREAM_TO_FULL_CNT = 64U;
constexpr uint32_t CAPTURE_TASK_RESERVED_NUM = 32U;
constexpr uint32_t STREAM_SQE_BUFFER_MAX_SIZE = 2 * 1024 * 1024;  // 2M, max sq depth 32768
constexpr uint32_t STREAM_SQ_MAX_DEPTH = 32768U;

namespace cce {
namespace runtime {
constexpr uint64_t ABORT_STREAM_TIMEOUT = (60UL * 1000 * 1000);  // us
class Event;
class Context;
class Device;
class Task;
class EventRecordTask;
class Model;
class Label;
class DvppGrp;
class TaskResManage;
class StreamSqCqManage;
class EngineStreamObserver;
class TaskAllocator;

typedef enum TagtsSqAllocType {
    SQ_ALLOC_TYPE_RT_DEFAULT = 0,
    SQ_ALLOC_TYPE_TS_FFTS_DSA = 1,
} RtSqAllocType;

typedef enum TagStreamFailureMode {
    CONTINUE_ON_FAILURE = 0,
    STOP_ON_FAILURE = 1,
    ABORT_ON_FAILURE = 2,
} TsStreamFailureMode;

enum class StreamStateCallback : uint8_t {
    RT_STREAM_STATE_CALLBACK = 0,
    RTS_STREAM_STATE_CALLBACK,
    STREAM_CALLBACK_TYPE_MAX
};

struct RtTaskCqeStatus {
    TaskInfo *taskPtr;
    bool isCqeArrived;
};

struct RtStarsRecordQueue {
    uint32_t *queue = nullptr;
    uint32_t size = 0U;
    uint32_t front = 0U;
    uint32_t rear = 0U;
    uint32_t count = 0U;
};

struct TraceArgs {
    int modelId;
    int streamId;
    int taskId;
};

struct TraceEvent {
    std::string name;
    std::string pid;
    std::string tid;
    int ts;
    float dur;
    std::string ph;
    TraceArgs args;
};

enum class StreamTaskGroupStatus : uint8_t { NONE, SAMPLE, UPDATE, BUTT };

struct TaskGroup {
    std::vector<std::pair<uint16_t, uint16_t>> taskIds; // streamId + taskId
    bool isUpdate{false};
    uint32_t updateTaskIndex{0};
};

enum class StreamInfoExHeaderType : uint8_t {
    TS_SQCQ_NORMAL_TYPE = 0,
    TS_SQCQ_TOPIC_TYPE,
    TS_SUB_TYPE_INVALID,
};

enum class StreamSubscribeFlag : uint8_t {
    SUBSCRIBE_NONE = 0,
    SUBSCRIBE_USER,
    SUBSCRIBE_RUNTIME,
};

enum class UpdateTaskFlag : int32_t {
    SUPPORT = 0,
    NOT_SUPPORT,
    NOT_SUPPORT_AND_SKIP,
};

// A stream is a sequence of task that execute in order.
class Stream : public NoCopy {
public:
    Stream(Device * const dev, const uint32_t prio);
    Stream(Device * const dev, const uint32_t prio, const uint32_t stmFlags, DvppGrp * const dvppGrp = nullptr);
    Stream(const Context * const stmCtx, const uint32_t prio);
    Stream(const Context * const stmCtx, const uint32_t prio, const uint32_t stmFlags);
    ~Stream() override;

    // init stream
    virtual rtError_t Setup();

    virtual rtError_t SetupWithoutBindSq();

    // init L2 addr
    rtError_t SetL2Addr();

    virtual void SetAbortStatus(rtError_t status);

    virtual rtError_t GetAbortStatus() const;

    virtual void SetBeingAbortedFlag(bool abortFlag);

    virtual bool GetBeingAbortedFlag();

    virtual rtError_t CleanSq();

    virtual rtError_t TaskKill(const uint32_t operationType);

    // only pid abort use default
    virtual rtError_t TaskAbortByType(uint32_t &result, const uint32_t opType, const uint32_t targetId = 0U);

    virtual rtError_t SqCqUpdate();

    virtual rtError_t ReAllocStreamId();

    virtual rtError_t Restore();

    // only pid abort use default
    virtual rtError_t QueryAbortStatusByType(uint32_t &status, const uint32_t opType, const uint32_t targetId = 0U);

    virtual rtError_t RecoverAbortByType(const uint32_t opType, const uint32_t targetId, uint32_t &result);

    virtual rtError_t QueryRecoverStatusByType(uint32_t &status, const uint32_t opType, const uint32_t targetId);

    virtual rtError_t QuerySq(const uint32_t queryType, uint32_t &status);

    virtual bool IsNeedSendFlipTask(uint16_t preTaskId);
    // create CreateL2AddrTask
    rtError_t ProcL2AddrTask(TaskInfo *&tsk);

    // destroy this stream
    virtual rtError_t TearDown(const bool terminal = false, bool flag = true);

    virtual void EnterFailureAbort();
    virtual bool IsSeparateSendAndRecycle();
    // use ctrlsq to recycle task in stream
    rtError_t RecycleTaskWithCtrlsq(Device * const dev, const uint32_t logicCqId, const uint32_t recycleCnt);

    // Block following task to issue after this until the event complete.
    rtError_t WaitEvent(Event * const evt, const uint32_t timeout);

    void StreamLock();
    void StreamUnLock();

    void StreamSyncLock();
    bool StreamSyncTryLock(uint64_t time);

    void StreamSyncUnLock();

    void StreamRecycleLock();
    void StreamRecycleUnlock();

    rtError_t AcquireTimeline(uint64_t &base, uint32_t &offset);
    rtError_t ReleaseTimeline(const uint64_t base, const uint32_t offset);
    uint64_t GetTimelineValue(const uint64_t base, const uint32_t offset);

    void StreamSyncFinishReport() const;
    // Block current host thread until all task ahead finish.
    virtual rtError_t Synchronize(const bool isNeedWaitSyncCq = false, int32_t timeout = -1);

    // Query state of event
    rtError_t Query(void) const;

    // start fusion kernels
    rtError_t KernelFusionStart();

    // end fuison kernels
    rtError_t KernelFusionEnd();

    rtError_t FreePersistentTaskID(TaskAllocator * const tskAllocator);

    rtError_t GetError(void);
    rtError_t ProcessDrvErr(void);
    void SetContextFailureCode();
    rtError_t SetFailMode(const uint64_t mode);

    void EraseEventTask(TaskInfo* const tsk);
    void InsertEventTask(TaskInfo* const tsk);

    int32_t Id_() const
    {
        return streamId_;
    }

    // profiling needs to record the actual stream that executes the task.
    int32_t AllocTaskStreamId() const
    {
        if (captureStream_ != nullptr) {
            return captureStream_->Id_();
        } else {
            return streamId_;
        }
    }

    uint32_t GetSqId() const
    {
        return sqId_;
    }

    uint64_t GetSqIdMemAddr() const
    {
        return sqIdMemAddr_;
    }

    void SetSqIdMemAddr(const uint64_t sqIdMemAddr)
    {
        sqIdMemAddr_ = sqIdMemAddr;
        return;
    }

    uint32_t GetCqId() const
    {
        return cqId_;
    }

    uint32_t GetPoolId() const
    {
        return poolId_;
    }

    Device *Device_() const
    {
        return device_;
    }

    uint32_t Priority() const
    {
        return priority_;
    }

    void SetContext(Context *ctx)
    {
        context_ = ctx;
    }

    void SetPoolId(uint32_t poolId)
    {
        poolId_ = poolId;
    }

    Context *Context_() const
    {
        return context_;
    }

    void SetName(const char_t *name)
    {
        if (name != nullptr) {
            (void)name_.assign(name);
        }
    }

    void SetModel(Model *mdl)
    {
        if (mdl == nullptr) {
            RT_LOG(RT_LOG_ERROR, "mdl == nullptr");
            return;
        }
        models_.insert(mdl);
    }

    void DelModel(Model *mdl)
    {
        models_.erase(mdl);
    }

    Model *Model_() const;

    uint16_t GetModelNum() const
    {
        return models_.size();
    }

    void SetLatestModlId(int32_t id)
    {
        latestModelId_ = id;
    }

    uint32_t Flags() const
    {
        return flags_;
    }

    void SetErrCode(const uint32_t errCode)
    {
        errCode_ = errCode;
        if (GetFailureMode() == ABORT_ON_FAILURE) {
            SetContextFailureCode();
        }
    }

    uint32_t GetErrCode() const
    {
        return errCode_;
    }

    void SetDrvErr(const uint32_t drvErr)
    {
        drvErr_ = drvErr;
    }

    uint32_t GetDrvErr() const
    {
        return drvErr_;
    }

    bool NeedSaveTask(const TaskInfo * const tsk) const;

    bool NeedDelSelfStream(void) const;

    uint32_t GetCbRptCqid() const;

    uint32_t GetCbGrpId() const;

    bool IsHostFuncCbReg();

    uint32_t GetPriority() const
    {
        return priority_;
    }
    void PushPersistentTaskID(uint32_t taskID)
    {
        const std::lock_guard<std::mutex> stmLock(persistentTaskMutex_);
        persistentTaskid_.push_back(taskID);
    }

    bool IsPersistentTaskFull();
    void FreePersistentTaskID(const Stream * const exeStream);

    // some works are not supported in model compile step,
    //      e.q. HCCL task need device memory but not supported now;
    //             so HCCL kernel task can't support arg memory 0 cpy in model loading step,
    //             which need runtime alloc and mamage arg memory.
    bool NonSupportModelCompile() const
    {
        return ((Flags() & (RT_STREAM_FORCE_COPY | RT_STREAM_PERSISTENT)) ==
                (RT_STREAM_FORCE_COPY | RT_STREAM_PERSISTENT));
    }

    void *L2BaseVaddr() const
    {
        return l2BaseVaddr_;
    }

    void InsertLabelList(Label *label)
    {
        labelLock_.Lock();
        labels_.push_back(label);
        labelLock_.Unlock();
    }

    bool IsTaskSink() const
    {
        return GetBindFlag() && ((Flags() & RT_STREAM_AICPU) == 0);
    }

    bool IsSteamNeedFastCq() const
    {
        return needFastcqFlag_;
    }

    void SetLastTaskId(uint32_t lastTaskId)
    {
        lastTaskId_ = lastTaskId;
    }

    uint32_t GetLastTaskId() const
    {
        return lastTaskId_;
    }

    bool NeedSubmitTask(void) const
    {
        return needSubmitTask_;
    }

    void SetNeedSubmitTask(bool needSubmitTask)
    {
        needSubmitTask_ = needSubmitTask;
    }

    void PushbackSwitchNArgs(void *args)
    {
        switchNArg_.push_back(args);
    }

    void *GetOnProfDeviceAddr(void) const
    {
        return onProfDeviceAddr_;
    }

    void SetOnProfDeviceAddr(void *streamOnProfAddr)
    {
        onProfDeviceAddr_ = streamOnProfAddr;
    }

    void *GetOnProfHostRtAddr(void) const
    {
        return onProfHostRtAddr_;
    }

    void SetOnProfHostRtAddr(void *streamOnProfAddr)
    {
        onProfHostRtAddr_ = streamOnProfAddr;
    }

    void *GetOnProfHostTsAddr(void) const
    {
        return onProfHostTsAddr_;
    }

    void SetOnProfHostTsAddr(void *streamOnProfAddr)
    {
        onProfHostTsAddr_ = streamOnProfAddr;
    }

    void SetBindFlag(bool flag)
    {
        bindFlag_.Set(flag);
    }

    bool GetBindFlag() const
    {
        return bindFlag_.Value();
    }

    bool GetStarsWrCqeFlag() const
    {
        return (dvppGrp_ != nullptr);   // all dvpp task need cqe in stars
    }

    void SetRecycleFlag(bool flag)
    {
        recycleFlag_.Set(flag);
    }

    bool GetRecycleFlag() const
    {
        return recycleFlag_.Value();
    }

    void SetSubscribeFlag(StreamSubscribeFlag flag)
    {
        subscribeFlag_.Set(flag);
    }

    StreamSubscribeFlag GetSubscribeFlag() const
    {
        return subscribeFlag_.Value();
    }

    void SetStreamStopSyncFlag(bool flag)
    {
        streamStopSyncFlag_ = flag;
    }

    void SetStreamFastSync(bool flag)
    {
        streamFastSync_ = flag;
    }

    bool IsDavinciTask(const TaskInfo * const tsk) const;

    bool IsFusionKernelTask(const TaskInfo * const tsk) const;

    bool CheckASyncRecycle();

    rtError_t AddTaskToStream(const TaskInfo * const tsk);

    void CacheBindTrackTaskId(const uint16_t taskId){
        cacheTrackTaskid_.push_back(taskId);
    }

    const std::list<uint16_t> &GetCacheTrackTaskList() const;

    void ClearCacheTrackTaskList()
    {
        cacheTrackTaskid_.clear();
    }

    void InsertCacheStream();
    void EraseCacheStream();

    bool IsStreamFull(const uint32_t head, const uint32_t tail, const uint32_t depth, const uint32_t addCnt);

    #define FLAG_OFFSET (31U)
    bool StarsCheckSqeFull(const uint32_t sendSqeNum);
    void StarsSqTailAdd();
    void StarsSqHeadSet(const uint32_t data);
    void StarsWrRecordEnQueue(const bool needSend);
    void StarsWrRecordDeQueue();

    RtStarsRecordQueue StarsGetWrRecordQueue()
    {
        return wrRecordQueue_;
    }

    virtual rtError_t StarsAddTaskToStream(TaskInfo * const tsk, const uint32_t sendSqeNum);

    rtError_t TryDelRecordedTask(const bool isTaskBind, const uint16_t tailTaskId);

    rtError_t StarsTryDelRecordedTask(const TaskInfo * const workTask, const bool isTaskBind, const uint16_t tailTaskId);

    rtError_t TryDelDavinciRecordedTask(const uint16_t tailTaskId, uint16_t * const delTaskId);

    virtual rtError_t StarsGetPublicTaskHead(TaskInfo *workTask, const bool isTaskBind, const uint16_t tailTaskId,
        uint16_t * const delTaskId);
    rtError_t GetPublicTaskHead(const bool isTaskBind, const uint16_t tailTaskId, uint16_t * const delTaskId);
    void BatchDelDavinciRecordedTask(const uint16_t tailTaskId, const uint32_t davinciTaskNum);

    void ClearTaskCount(const bool isTaskBind);

    int32_t GetRecycleTaskHeadId(const uint16_t tailTaskId, uint16_t &recycleTaskId);

    uint8_t GetTaskRevFlag(const bool isTaskBind);

    void SetStreamMark(const TaskInfo * const tsk);
    bool IsTaskLimited(const TaskInfo * const tsk);

    virtual uint32_t GetPendingNum() const
    {
        return pendingNum_.Value();
    }
    void UpdateCascadeCaptureStreamInfo(Stream *newCaptureStream, Stream *curCaptureStream);
    rtError_t AllocCascadeCaptureStream(Stream *&newCaptureStream, const Stream * const curCaptureStream);
    rtError_t ProcRecordTask(TaskInfo *&tsk);
    virtual rtError_t SubmitRecordTask(int32_t timeout);

    rtError_t WaitForTask(const uint32_t taskId, const bool isNeedWaitSyncCq = false, int32_t timeout = -1);
    rtError_t WaitTask(const bool isReclaim, const uint32_t taskId, const int32_t timeout = -1);
    virtual rtError_t QueryWaitTask(bool &isWaitFlag, const uint32_t taskId);
    rtError_t GetLastTaskIdFromCqShm(uint32_t &lastTaskId);
    virtual rtError_t GetLastTaskIdFromRtsq(uint32_t &lastTaskId);
    virtual rtError_t JudgeTaskFinish(uint16_t taskPos, bool &isFinished);
    virtual rtError_t JudgeHeadTailPos(rtEventStatus_t * const status, uint16_t eventPos);
    rtError_t GetLastFinishTaskId(const uint32_t taskId, uint32_t &currId, int32_t timeout);
    virtual bool IsWaitFinish(const uint32_t finishedTaskId, const uint32_t submittedTaskId);
    void ReportErrorMessage(const uint32_t errCode, const std::string &errMsg);

    bool IsDebugRegister(void) const
    {
        return isDebugRegister_;
    }

    void SetDebugRegister(bool isDebugRegister)
    {
        isDebugRegister_ = isDebugRegister;
    }

    bool GetOverflowSwtich(void) const
    {
        return isOverflowSwitchOn_;
    }

    void SetOverflowSwitch(bool flag)
    {
        isOverflowSwitchOn_ = flag;
    }

    uint32_t GetStreamTag(void) const
    {
        return streamGeOpTag_;
    }

    void SetStreamTag(const uint32_t geOpTag)
    {
        streamGeOpTag_ = geOpTag;
    }

    bool IsOverflowEnable(void) const
    {
        return (isDebugRegister_ || isOverflowSwitchOn_);
    }

    rtError_t AllocExecutedTimesSvm();
    rtError_t FreeExecutedTimesSvm();
    uint16_t *GetExecutedTimesSvm(void) const
    {
        return executedTimesSvm_;
    }
    uint64_t GetSqRegVirtualAddr(void) const
    {
        return sqRegVirtualAddr_;
    }
    rtError_t SetSqRegVirtualAddrToDevice(uint64_t sqRegVirtualAddr) const;

    void InsertPendingList(uint32_t hostTaskType, HostTaskBase *base);
    bool IsPendingListEmpty(uint32_t hostTaskType);
    rtError_t ExecPendingList(uint32_t hostTaskType);

    uint16_t GetTaskIdFlipNum() const
    {
        return taskIdFlipNum_.Value();
    }

    void SetTaskIdFlipNum(uint16_t flipNum)
    {
        taskIdFlipNum_.Set(flipNum);
    }

    void SetNeedFastcqFlag()
    {
        needFastcqFlag_ = true;
    }

    void SetSatMode(const rtFloatOverflowMode_t mode)
    {
        satMode_ = mode;
    }

    rtFloatOverflowMode_t GetSatMode() const
    {
        return satMode_;
    }

    bool IsBindDvppGrp(void) const
    {
        return (dvppGrp_ != nullptr);
    }

    uint32_t GetCurrentTid() const
    {
        return tid_;
    }

    void SetLimitFlag(bool flag)
    {
        limitFlag_.Set(flag);
    }

    bool GetLimitFlag() const
    {
        return limitFlag_.Value();
    }

    virtual uint32_t GetTaskPosHead() const
    {
        return taskPosHead_.Value();
    }

    virtual uint32_t GetTaskPosTail() const
    {
        return taskPosTail_.Value();
    }

    void SetLogicalCqId(uint32_t logicCqId)
    {
        logicalCqId_ = logicCqId;
    }

    uint32_t GetLogicalCqId() const
    {
        return logicalCqId_;
    }

    void DelPosToTaskIdMap(uint16_t pos) const;

    void SetIsSupportASyncRecycle(bool flag)
    {
        isSupportASyncRecycle_ = flag;
    }

    bool GetIsSupportASyncRecycle() const
    {
        return isSupportASyncRecycle_;
    }

    void SetRecycleEndTaskId(uint16_t taskId)
    {
        recycleEndTaskId_.Set(taskId);
    }

    uint16_t GetRecycleEndTaskId() const
    {
        return recycleEndTaskId_.Value();
    }

    void SetExecuteEndTaskId(uint16_t taskId)
    {
        executeEndTaskid_.Set(taskId);
    }

    uint16_t GetExecuteEndTaskId() const
    {
        return executeEndTaskid_.Value();
    }

    void SetStreamAsyncRecycleFlag(bool flag) const
    {
        isNeedStreamAsyncRecycle_ = flag;
    }

    bool GetStreamAsyncRecycleFlag() const
    {
        return isNeedStreamAsyncRecycle_;
    }
    bool IsCtrlStream() const
    {
        return isCtrlStream_;
    }

    void  SetSqTailPos(uint32_t pos)
    {
        sqTailPos_ = pos;
    }

    uint32_t  GetSqTailPos() const
    {
        return sqTailPos_;
    }

    void SetFlowCtrlFlag(void)
    {
        isFlowCtrl = true;
        return;
    }

    void ClearFlowCtrlFlag(void)
    {
        isFlowCtrl = false;
        return;
    }

    bool GetFlowCtrlFlag(void) const
    {
        return isFlowCtrl;
    }

    void SetFailureMode(uint64_t mode)
    {
        modeMutex.lock();
        if (failureMode_ != ABORT_ON_FAILURE) {
            failureMode_ = mode;
        }
        modeMutex.unlock();
    }

    uint64_t GetFailureMode() const
    {
        return failureMode_;
    }

    bool AbortedStreamToFull() const;

    void SetMode(uint64_t mode)
    {
        modeConfig_.Set(mode);
    }

    uint64_t GetMode() const
    {
        return modeConfig_.Value();
    }

    void SetIsHasPcieBarFlag(bool pcieBarFlag)
    {
        isHasPcieBar_ = pcieBarFlag;
    }

    void SetIsSubmitTaskFailFlag(bool submitTaskFailFlag)
    {
        isSubmitTaskFail_ = submitTaskFailFlag;
    }

    void SetNeedRecvCqeFlag(bool flag)
    {
        isNeedRecvCqe_ = flag;
    }

    bool GetNeedRecvCqeFlag() const
    {
        return isNeedRecvCqe_;
    }

    void SetIsForceRecycle(bool flag)
    {
        isForceRecycle_ = flag;
    }

    bool GetIsForceRecycle()
    {
        return isForceRecycle_;
    }

    uint16_t GetLastRecyclePos() const
    {
        return lastRecyclePos_;
    }

    void SetLastRecyclePos(uint16_t curPos)
    {
        lastRecyclePos_ = curPos;
    }

    void SetNeedSyncFlag(bool flag)
    {
        needSync_ = flag;
    }

    bool GetNeedSyncFlag() const
    {
        return needSync_;
    }
    void SetThreadProcFlag(bool flag)
    {
        isRecycleThreadProc_ = flag;
    }

    uint16_t GetTaskPublicBuffSize() const
    {
        return taskPublicBuffSize_;
    }
    Event *GetLastHalfRecord() const
    {
        return lastHalfRecord_;
    }

    void SetLastHalfRecord(Event *evt)
    {
        lastHalfRecord_ = evt;
    }
    void Destructor();

    std::shared_ptr<Stream> GetSharedPtr() {
        if (myself == nullptr) {
            myself.reset(this);
        }
        return myself;
    }

    rtError_t AllocLogicCq(const bool isDisableThread, const bool starsFlag, StreamSqCqManage * const stmSqCqManage,
        const uint32_t drvFlag = 0U);
    virtual rtError_t GetTaskIdByPos(const uint16_t recycleHead, uint32_t &taskId);
    rtError_t ModelWaitForTask(const uint32_t taskId, const bool isNeedWaitSyncCq);
    rtError_t StarsWaitForTask(const uint32_t taskId, const bool isNeedWaitSyncCq,
        int32_t timeout);
    virtual bool IsTaskExcuted(const uint32_t executeEndTaskid, const uint32_t taskId);
    bool SynchronizeDelayTime(const uint16_t finishedId, const uint16_t taskId, const uint16_t sqHead);
    rtError_t SynchronizeImpl(const uint32_t syncTaskId, const uint16_t concernedTaskId, int32_t timeout=-1);
    virtual rtError_t SynchronizeExecutedTask(const uint32_t taskId, const mmTimespec &beginTime, int32_t timeout);
    rtError_t WaitConcernedTaskRecycled(const uint16_t taskId, const mmTimespec &beginTime, int32_t timeout);
    virtual rtError_t GetFinishedTaskIdBySqHead(const uint16_t sqHead, uint32_t &finishedId);
    void *GetDvppRRTaskAddr(void);
    uint32_t GetMaxTryCount() const;

    virtual RtSqAllocType GetTsSqAllocType() const
    {
        return SQ_ALLOC_TYPE_RT_DEFAULT;
    }

    virtual rtError_t AddTaskToList(const TaskInfo * const tsk);
    rtError_t TryDelPublicRecordedTask(const uint16_t tailTaskId);
    void UpdateTaskPosHead(const uint32_t sqPos, const uint32_t sqeNum);
    virtual uint32_t StarsGetMaxTryCount() const;

    rtError_t EschedManage(const bool enFlag) const;

    virtual bool IsExistCqe(void) const;
    rtError_t CreateArgRecycleList(uint32_t size);
    void DestroyArgRecycleList(uint32_t size);
    virtual bool AddArgToRecycleList(TaskInfo * const tsk);
    virtual void ProcArgRecycleList(void);
    RecycleArgs* GetNextRecycleArg(void);
    bool IsNeedPostProc(const TaskInfo * const tsk) const;
    bool IsReclaimAsync(const TaskInfo * const tsk) const;
    void AddTaskTag(const uint16_t taskId, const std::string &taskTag);
    void DelTaskTag(const uint16_t taskId);
    const std::string GetTaskTag(const uint16_t taskId);

    virtual rtError_t CreateStreamTaskRes(void);
    void ReleaseStreamTaskRes(void);
    virtual rtError_t AllocDsaSqAddr() const
    {
        return RT_ERROR_NONE;
    }

    void SetMaxTaskId(const bool isDisableThread);

    uint16_t GetMaxTaskId() const
    {
        return maxTaskId_;
    }

    rtError_t ProcFlipTask(TaskInfo *&tsk, uint16_t flipNum);
    void ReportDestroyFlipTask();
    rtError_t GetStarsVersion();
    void SetCheckTaskId(const uint32_t taskId)
    {
        checkTaskId_ = taskId;
    }

    uint32_t GetCheckTaskId() const
    {
        return checkTaskId_;
    }

    rtError_t GetErrorForAbortOnFailure(rtError_t defaultError);
    virtual rtError_t CheckContextStatus(const bool isBlockDefaultStream=true) const;
    rtError_t CheckContextTaskSend(const TaskInfo * const workTask) const;

    void SetSyncRemainTime(const int32_t timeout)
    {
        syncTimeout_ = timeout;
    }

    int32_t GetSyncRemainTime() const
    {
        return syncTimeout_;
    }

    virtual uint32_t GetCurSqPos() const
    {
        return taskPersistentTail_.Value();
    }

    void *GetMemContainOverflowAddr() const {
        return memContainOverflowAddr_;
    }
    void SetMemContainOverflowAddr(void *addr) {
        memContainOverflowAddr_ = addr;
    }
    std::string SyncMdlName() const
    {
        return syncMdlName_;
    }

    int32_t SyncMdlId() const
    {
        return syncMdlId_;
    }

    void SetSyncMdlId(const int32_t syncModelId)
    {
        syncMdlId_ = syncModelId;
    }

    bool IsCapturing(void) const
    {
        return ((captureStatus_ == RT_STREAM_CAPTURE_STATUS_ACTIVE) ||
                (captureStatus_ == RT_STREAM_CAPTURE_STATUS_INVALIDATED));
    }

    rtStreamCaptureStatus GetCaptureStatus(void) const
    {
        return captureStatus_;
    }

    void SetCaptureStatus(rtStreamCaptureStatus status)
    {
        captureStatus_ = status;
    }

    uint32_t GetStreamCacheOpInfoSwitch() const
    {
        return cacheOpInfoSwitch_;
    }
 
    void SetStreamCacheOpInfoSwitch(const uint32_t status) const
    {
        cacheOpInfoSwitch_ = status;
    }
 
    uint32_t GetStreamCacheOpInfoOriginSwitch() const
    {
        return cacheOpInfoOriginSwitch_;
    }
 
    void SetStreamCacheOpInfoOriginSwitch(const uint32_t status) const
    {
        cacheOpInfoOriginSwitch_ = status;
    }

    void UpdateCaptureStream(const Stream * const captureStream)
    {
        captureStream_ = RtPtrToUnConstPtr<Stream *>(captureStream);
    }

    Stream* GetCaptureStream(void) const
    {
        return captureStream_;
    }

    virtual uint32_t GetDelayRecycleTaskSqeNum(void) const
    {
        return taskPersistentTail_.Value();
    }

    uint32_t GetTaskPersistentHeadValue(void) const
    {
        return taskPersistentHead_.Value();
    }

    uint32_t GetCaptureSqeNum(void) const
    {
        return captureSqeNum_;
    }

    void AddCaptureSqeNum(uint32_t sqeNum)
    {
        captureSqeNum_ += sqeNum;
    }

    void ResetCaptureInfo();
    void EnterCapture(const Stream * const captureStream);
    void ExitCapture();
    void SingleStreamTerminateCapture();
    virtual void DebugDotPrintForModelStm();
    std::string TraceEventToJson(const TraceEvent &record) const;
    virtual void DebugJsonPrintForModelStm(std::ofstream& outputFile, const uint32_t modelId, const bool isLastStm);

    void MarkOrigCaptureStream(const bool flag)
    {
        isOrigCaptureStream_ = flag;
    }

    bool IsOrigCaptureStream(void) const
    {
        return isOrigCaptureStream_;
    }

    void CancelLastLevelCaptureStream(void)
    {
        isLastLevelCaptureStream_ = false;
    }

    bool IsLastLevelCaptureStream(void) const
    {
        return isLastLevelCaptureStream_;
    }

    uint32_t GetDavinciTaskHead(void) const
    {
        return davinciTaskHead_;
    }

    uint32_t GetDavinciTaskTail(void) const
    {
        return davinciTaskTail_;
    }

    uint32_t GetTaskHead(void) const
    {
        return taskHead_;
    }

    uint32_t GetTaskTail(void) const
    {
        return taskTail_;
    }

    size_t GetDelayRecycleTaskSize(void) const
    {
        return delayRecycleTaskid_.size();
    }

    const std::vector<uint16_t>& GetDelayRecycleTaskId(void) const 
    {
        return delayRecycleTaskid_;
    }

    rtStreamCaptureMode GetStreamCaptureMode(void) const
    {
        return streamCaptureMode_;
    }

    void SetStreamCaptureMode(rtStreamCaptureMode mode)
    {
        streamCaptureMode_ = mode;
    }

    bool IsTaskGroupBreak() const;

    uint8_t GetGroupId() const;
    bool IsModelsDebugRegister() const;
    void ResetStreamConstruct();
    void FreeOnlineProf() const;
    virtual rtError_t ResClear(uint64_t timeout = 0);
    virtual void StarsShowStmDfxInfo(void);
    void DcShowStmDfxInfo(void);
    void ShowStmDfxInfo(void);
    void StarsStmDfxCheck(uint64_t &beginCnt, uint64_t &endCnt, uint16_t &checkCount);
    void StmDfxCheck(uint64_t &beginCnt, uint64_t &endCnt, uint16_t &checkCount);
    virtual rtError_t DavidUpdatePublicQueue(void) { return RT_ERROR_NONE; }
    virtual bool IsCntNotifyReachThreshold(void)   { return false; }
    virtual rtError_t ApplyCntNotifyId(int32_t &newEventId)
    {
        (void)newEventId;
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    virtual void GetCntNotifyId(int32_t &newEventId)
    {
        (void)newEventId;
    }
    virtual rtError_t ApplyCntValue(uint32_t &cntValue)
    {
        (void)cntValue;
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    virtual bool GetSqLocType(void) const
    {
        return false;
    }

    virtual void SetSqMemAttr(bool hostFlag)
    {
        (void)hostFlag;
    }
    virtual rtError_t PrintStmDfxAndCheckDevice(uint64_t& beginCnt, uint64_t& endCnt, uint16_t& checkCount, uint32_t tryCount);
    virtual rtError_t StreamTaskClean(void);
    void PushbackTilingTblAddr(void *addr)
    {
        devTilingTblAddr.push_back(addr);
    }
    rtError_t ModelTaskUpdate(const Stream *desStm, uint32_t desTaskId, void *devCopyMem, uint32_t tilingTabLen,
                              rtMdlTaskUpdateInfo_t *para);
    void FreeStreamId() const;
    bool GetForceRecycleFlag(bool flag) const;
    rtError_t CheckGroup();
    virtual void StarsShowPublicQueueDfxInfo(void) {}
    // use for david
    rtError_t TaskAbortAndQueryStatus(const uint32_t opType);
    rtError_t StreamAbort();
    rtError_t StreamStop();
    virtual rtError_t StreamRecoverAbort(void) { return RT_ERROR_NONE; }
    virtual rtError_t ModelAbortById(uint32_t modelId);
    rtError_t UpdateTask(TaskInfo** updateTask);
    TaskInfo* AllocTask(TaskInfo* pTask, tsTaskType_t taskType, rtError_t& errorReason,
        uint32_t sqeNum = 1U, UpdateTaskFlag flag = UpdateTaskFlag::NOT_SUPPORT);
    rtError_t TaskReclaim(void);
    rtError_t AllocCaptureTask(tsTaskType_t taskType, uint32_t sqeNum, TaskInfo **task);
    void GetTaskEventIdOrNotifyId(TaskInfo *taskInfo, int32_t &eventId, uint32_t &notifyId, uint64_t &devAddr) const;
    rtError_t AllocSoftwareSqAddr(uint32_t additionalSqeNum);

    uint64_t GetSqBaseAddr(void) const
    {
        return sqAddr_;
    }

    void SetSqBaseAddr(uint64_t sqAddr)
    {
        sqAddr_ = sqAddr;
    }

    uint32_t GetSqMemOrderType(void) const
    {
        return sqMemOrderType_;
    }

    void SetSqMemOrderType(const uint32_t type)
    {
        sqMemOrderType_ = type;
    }

    void ResetTaskGroup(void)
    {
        taskGroup_ = nullptr;
    }

    void SetSoftWareSqEnable()
    {
        isSoftwareSqEnable_ = true;
    }

    bool IsSoftwareSqEnable(void) const
    {
        return isSoftwareSqEnable_;
    }

    uint32_t GetSqDepth(void) const
    {
        return sqDepth_;
    }

    void SetSqDepth(const uint32_t sqDepth)
    {
        sqDepth_ = sqDepth;
    }

    uint8_t* GetSqeBuffer(void)
    {
        return sqeBuffer_;
    }

    void UpdateSqCq(const rtDeviceSqCqInfo_t * const sqCqInfo);
    void ResetSqCq(void);

    void UpdateCurrentTaskGroup(std::unique_ptr<TaskGroup> &taskGroup)
    {
        taskGroup_ = std::move(taskGroup);
    }

    std::unique_ptr<TaskGroup> &GetCurrentTaskGroup(void)
    {
        return taskGroup_;
    }

    rtError_t UpdateTaskGroupStatus(const StreamTaskGroupStatus status);

    StreamTaskGroupStatus GetTaskGroupStatus(void) const
    {
        return taskGroupStatus_;
    }

    bool IsTaskGroupUpdate() const {
        return (taskGroupStatus_ == StreamTaskGroupStatus::UPDATE);
    }
    
    TaskGroup * GetUpdateTaskGroup()
    {
        return updateTaskGroup_;
    }

    void SetUpdateTaskGroup(TaskGroup * taskGroupHandle)
    {
        updateTaskGroup_ = taskGroupHandle;
        updateTaskGroup_->isUpdate = true;
        updateTaskGroup_->updateTaskIndex = 0;
    }

    void UpdateTaskIndex(uint32_t index) const
    {
        updateTaskGroup_->updateTaskIndex = index;
    }

    void ResetUpdateTaskGroup()
    {
        updateTaskGroup_->isUpdate = false;
        updateTaskGroup_->updateTaskIndex = 0;
        updateTaskGroup_ = nullptr;
    }

    bool IsTaskGrouping(void) const;

    std::mutex & GetTaskGrpMutex(void)
    {
        return taskGroupMutex_;
    }
    std::mutex &GetCaptureLock()
    {
        return captureLock_;
    }

    void SetTaskGroupErrCode(const rtError_t errorCode) const;

    void InsertResLimit(const rtDevResLimitType_t type, const uint32_t value);
    void ResetResLimit(void);
    uint32_t GetResValue(const rtDevResLimitType_t type) const;
    bool GetResLimitFlag(const rtDevResLimitType_t type) const;
    rtError_t PackingTaskGroup(const TaskInfo * const task, const uint16_t streamId);
    rtError_t UpdateSnapShotSqe();
    bool IsNeedUpdateTask(const TaskInfo * const updateTask) const;
    rtError_t SubmitMemCpyAsyncTask(TaskInfo * const updateTask);

    void RecordDevMemAddr(void *devAddr)
    {
        recordDevMemAddr_.push_back(devAddr);
    }

    void SetBeginCaptureThreadId(uint32_t beginCaptureThreadId)
    {
        beginCaptureThreadId_ = beginCaptureThreadId;
    }

    uint32_t GetBeginCaptureThreadId(void) const
    {
        return beginCaptureThreadId_;
    }

    void SetArgHandle(void *argHandle)
    {
        argsHandle_ = argHandle;
    }

    void *GetArgHandle() const
    {
        return argsHandle_;
    }
private:
    // submit create stream task
    rtError_t SubmitCreateStreamTask();
    virtual rtError_t GetSynchronizeError(rtError_t error);
    rtError_t SubmitStreamRecycle(Stream* exeStream, bool isForceRecycle, uint16_t logicCqId, TaskInfo *&task) const;
    void ResetHostResourceForPersistentStream();
    void RecycleModelDelayRecycleTask();
public:
    bool isDeviceSyncFlag = false;
    uint32_t streamResId;
    bool isModelExcel = false;
    bool isModelComplete = false;
    bool isForceRecycle_ = false;
    std::mutex streamMutex_;    // Guard for stream exclusive.
    std::mutex recycleMutex_;
protected:
    Device *device_;
    int32_t streamId_;
    uint32_t sqId_;
    uint32_t cqId_;
    uint32_t priority_;
    uint32_t flags_;
    uint32_t errCode_;
    uint32_t drvErr_;
    DvppGrp *dvppGrp_;
    void *dvppRRTaskAddr_{nullptr};
    uint32_t *taskPublicBuff_{nullptr};
    uint16_t taskPublicBuffSize_{0};
    uint64_t sqRegVirtualAddr_{0ULL}; // virtual address of stars_simple_sq0_4k head, get from DRV by sq_id
    uint32_t finishTaskId_{MAX_UINT32_NUM};
    bool isNeedRecvCqe_{false};
    Event *lastHalfRecord_{nullptr};
    std::mutex publicTaskMutex_;
    std::set<Model *> models_;
    int32_t latestModelId_{MAX_INT32_NUM};
    std::vector<std::pair<uint32_t, std::string>> errorMsg_;
private:
    uint32_t poolId_;
    void *l2BaseVaddr_;
    std::array<uint64_t, PTE_LENGTH> pte_ = {};

    void *pteVA_;
    bool needSubmitTask_;

    bool fusioning_;
    std::string name_;
    SpinLock labelLock_;
    uint32_t lastTaskId_;
    uint32_t checkTaskId_{MAX_UINT32_NUM};
    std::mutex persistentTaskMutex_;
    std::vector<uint16_t> persistentTaskid_;
    class EngineStreamObserver;
    std::vector<void *> switchNArg_;
    void *onProfDeviceAddr_;
    void *onProfHostRtAddr_;
    void *onProfHostTsAddr_;
    uint32_t taskHead_;
    uint32_t taskTail_;
    Atomic<uint32_t> countingNum_;
    uint32_t davinciTaskHead_;
    uint32_t davinciTaskTail_;
    uint32_t *davinciTaskList_{nullptr};
    uint16_t davinciTaskListSize_{0};
    std::mutex davinciTaskMutex_;

    Atomic<uint32_t> taskPersistentHead_;
    Atomic<uint32_t> taskPersistentTail_;
    Atomic<uint32_t> countingPersistentNum_;
    uint16_t taskPersistentBuff_[STREAM_TASK_BUFF_SIZE] = {0};
    std::vector<uint16_t> delayRecycleTaskid_;  // save delay recycle task id, thread unsafe
    Atomic<bool> bindFlag_;
    Atomic<StreamSubscribeFlag> subscribeFlag_{StreamSubscribeFlag::SUBSCRIBE_NONE};
    Atomic<uint32_t> countingActiveNum_;
    // save not report track task for bind stream, clean when stream destroy or reported
    std::list<uint16_t> cacheTrackTaskid_;
    uint32_t lastEventId_{MAX_UINT32_NUM};
    std::vector<uint32_t> waitTaskList_;

    std::mutex timelineMutex_;
    std::timed_mutex streamSyncMutex_;
    std::mutex hostTaskMutex_;
    std::set<uint32_t> timelineOffset_;
    uint64_t *timelineAddr_{nullptr};
    uint64_t timelineBase_{0};
    bool isDebugRegister_;
    bool isOverflowSwitchOn_;
    std::mutex errorMsgLock_;
    uint32_t earlyRecycleTaskHead_;
    uint16_t *executedTimesSvm_; // Initialized to 0xFFFF, increased before every ActiveStream and ModelExecute
    std::map<uint32_t, std::list<HostTaskBase *>> hostTaskPendingList_;
    Atomic<uint16_t> taskIdFlipNum_;
    bool needFastcqFlag_;
    Atomic<bool> recycleFlag_;
    uint32_t tid_;
    Atomic<bool> limitFlag_;
    uint32_t logicalCqId_{MAX_UINT32_NUM};
    std::mutex posToTaskIdMapLock_;
    uint16_t *posToTaskIdMap_{nullptr};
    uint32_t posToTaskIdMapSize_{0U};
    RtStarsRecordQueue wrRecordQueue_{};
    std::mutex eventTaskListLock_;
    std::set<TaskInfo*> eventTaskList;
    std::mutex dvppRRTaskAddrLock_;
    bool streamStopSyncFlag_{true};
    bool streamFastSync_{false};
    uint32_t streamGeOpTag_;
    bool isSupportASyncRecycle_{false};
    static __THREAD_LOCAL__ bool isNeedStreamAsyncRecycle_;
    bool isFlowCtrl;  // Indicating has flow ctrl in this stream
    Atomic<uint32_t> taskPosHead_;  // only for stars
    Atomic<uint32_t> taskPosTail_;  // only for stars
    Atomic<uint64_t> modeConfig_{0ULL}; //遇错即停开关
    std::mutex taskIdToTaskTagMapMutex_;
    std::unordered_map<uint16_t, std::string> taskIdToTaskTagMap_;
    bool needSync_{false};
    uint16_t lastRecyclePos_{0xFFFFU};
    uint16_t maxTaskId_{MAX_UINT16_NUM};
    std::string syncMdlName_;
    int32_t syncMdlId_{-1};
    bool isBeingAborted_{false};
    Stream *captureStream_{nullptr};
    uint32_t captureSqeNum_{0U};
    rtStreamCaptureStatus captureStatus_{RT_STREAM_CAPTURE_STATUS_NONE}; // only for single-operator stream, not capture stream
    mutable uint32_t cacheOpInfoOriginSwitch_{0U};  // only record this stream switch status for rec: 0: false, 1:true
    mutable uint32_t cacheOpInfoSwitch_{0U}; // aclgraph stream status: 0: false, 1:true,
    std::mutex captureLock_;       // used to mutually exclusive alloc task between begin/end capture
    bool isOrigCaptureStream_{false};
    bool isLastLevelCaptureStream_{true};
    rtStreamCaptureMode streamCaptureMode_{RT_STREAM_CAPTURE_MODE_MAX};
    StreamTaskGroupStatus taskGroupStatus_{StreamTaskGroupStatus::NONE}; // only for single-operator stream
    std::unique_ptr<TaskGroup> taskGroup_ = nullptr; // only for capture stream
    std::mutex taskGroupMutex_;
    TaskGroup *updateTaskGroup_{nullptr};
    Atomic<uint16_t> recycleEndTaskId_{MAX_UINT16_NUM};
    Atomic<uint16_t> executeEndTaskid_{MAX_UINT16_NUM};
    Context *context_{nullptr};
    rtFloatOverflowMode_t satMode_{RT_OVERFLOW_MODE_SATURATION};
    std::array<uint32_t, RT_DEV_RES_TYPE_MAX> resLimitArray_{};  // resource limit for stream
    std::array<bool, RT_DEV_RES_TYPE_MAX> resLimitFlag_{};
    uint64_t sqAddr_{0ULL};   /* max size is 2M */
    uint32_t sqMemOrderType_{SQ_ADDR_MEM_ORDER_TYPE_MAX};
    bool isSoftwareSqEnable_{false};
    uint32_t sqDepth_;
    uint8_t *sqeBuffer_{nullptr};
    uint32_t sqeBufferSize_{0U};
    uint32_t beginCaptureThreadId_{UINT32_MAX};
    uint64_t sqIdMemAddr_{0UL};
    void *argsHandle_{nullptr};
public:
    TaskResManage *taskResMang_{nullptr};
    bool isHasPcieBar_{false};
    Atomic<uint32_t> pendingNum_;
    bool isSubmitTaskFail_{false};
    RecycleArgs **argRecycleList_;
    uint16_t argRecycleListSize_{0U};
    uint16_t argRecycleListHead_;
    uint16_t argRecycleListTail_;
    std::mutex argRecycleListMutex_;
    std::vector<void *> devTilingTblAddr;
    void *memContainOverflowAddr_{nullptr};
    bool isRecycleThreadProc_{false};
protected:
    bool isCtrlStream_;
    uint32_t sqTailPos_;
    uint32_t sqHeadPos_;
    std::mutex modeMutex;
    uint64_t failureMode_; //遇错即停状态
    std::shared_ptr<Stream> myself = nullptr;
public:
    uint32_t fftsMemAllocCnt;
    uint32_t fftsMemFreeCnt;
    uint16_t hcclIndex_;
    int32_t syncTimeout_ = -1; // -1 no timeout default
    rtError_t abortStatus_;
    std::list<Label *> labels_;
    std::vector<void *> recordDevMemAddr_;
    Atomic<uint16_t> latestConcernedTaskId{MAX_UINT16_NUM};
};

inline void DeleteStream(Stream * &stm) {
    if (stm != nullptr) {
        stm->Destructor();
        stm = nullptr;
    }
}

}  // namespace runtime
}  // namespace cce

#endif  // __CCE_RUNTIME_STREAM_HPP__
