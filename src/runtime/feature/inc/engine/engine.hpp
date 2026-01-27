/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_ENGINE_HPP__
#define __CCE_RUNTIME_ENGINE_HPP__

#include "base.hpp"
#include "osal.hpp"
#include "driver.hpp"
#include "dvpp_grp.hpp"
#ifndef CFG_DEV_PLATFORM_PC
#include "error_manager.h"
#endif

#ifndef REPORT_HASH_KEY
#define REPORT_HASH_KEY(taskId, streamId, taskType)               \
    (((static_cast<uint64_t>(taskId) << 32U) & 0xFFFF00000000U) | \
     ((static_cast<uint64_t>(streamId) << 16U) & 0xFFFF0000U) | \
     (static_cast<uint64_t>(taskType) & 0x0000FFFFU))
#endif

#ifndef LOST_HEARTBEAT_RETURN
#define LOST_HEARTBEAT_RETURN(ERR, DEVICE_ID)                  \
    if (unlikely((ERR) == RT_ERROR_LOST_HEARTBEAT)) { \
        RT_LOG(RT_LOG_ERROR, "Device[%d] lost heartbeat.", std::stoi(DEVICE_ID)); \
        RT_LOG_INNER_DETAIL_MSG(RT_DEVICE_RUNNING_DOWN, {"device_id"}, {(DEVICE_ID)}); \
        return;                                     \
    }
#endif

#ifndef LOST_HEARTBEAT_PROC_RETURN
#define LOST_HEARTBEAT_PROC_RETURN(ERR, DEVICE_ID, PROC1, PROC2)                  \
    if (unlikely((ERR) == RT_ERROR_LOST_HEARTBEAT)) { \
        RT_LOG(RT_LOG_ERROR, "Device[%d] lost heartbeat.", std::stoi(DEVICE_ID)); \
        RT_LOG_INNER_DETAIL_MSG(RT_DEVICE_RUNNING_DOWN, {"device_id"}, {(DEVICE_ID)}); \
        (PROC1);                                    \
        (PROC2);                                    \
        return;                                     \
    }
#endif
#ifndef RT_DEVICE_RUNNING_DOWN_LOG
#define RT_DEVICE_RUNNING_DOWN_LOG(status) \
if (runningState_  != DEV_RUNNING_DOWN) { \
    RT_LOG(RT_LOG_ERROR, "Device %d, status %u, DEV_RUNNING_DOWN.", device_->Id_(), (status)); \
}
#endif
namespace EngineConstExpr{
    constexpr uint32_t MAX_OBSERVER_NUM = 5;
}

namespace cce {
namespace runtime {
class Profiler;
class Scheduler;
class Task;
class Context;
class Stream;
class CtrlStream;
class Device;

class EngineObserver {
public:
    virtual ~EngineObserver();
    virtual void TaskSubmited(Device * const dev, TaskInfo * const tsk);
    virtual void TaskLaunched(const uint32_t devId, TaskInfo * const tsk, rtTsCommand_t * const command);
    virtual void TaskFinished(const uint32_t devId, const TaskInfo * const tsk);
    virtual void DeviceIdle(Device * const dev);
};

enum rtExceptionCodeT {
    EXC_TYPE_NO_ERROR = 0x0,

    /* OS exception code 0xC0000000-0xC00000FF */
    EXC_TYPE_OS_DATA_ABORT = 0xC0000000,
    EXC_TYPE_OS_INSTRUCTION_ABORT = 0xC0000001,
    EXC_TYPE_OS_PC_ALIGN_FAULT = 0xC0000002,
    EXC_TYPE_OS_SP_ALIGN_FAULT = 0xC0000003,
    EXC_TYPE_OS_INFINITE_LOOP = 0xC0000004,
    EXC_TYPE_OS_UNKNOWN_EXCEPTION = 0xC0000005,
    RDR_EXC_TYPE_OS_EXCEPTION = 0xC0000006,

    /* AICPU exception code 0xC0000100-0xC00001FF, only for AICPU use */
    MODID_NPU_AICPU_START = 0xC0000100,
    MODID_NPU_AICPU_END = 0xC00001FF,

    /* AICORE exception code 0xC0000200-0xC00002FF */
    EXC_TYPE_TS_AICORE_EXCEPTION = 0xC0000200,
    EXC_TYPE_TS_AICORE_TIMEOUT = 0xC0000201,

    /* SDMA exception code 0xC0000300-0xC00003FF */
    EXC_TYPE_TS_SDMA_EXCEPTION = 0xC0000300,
    EXC_TYPE_TS_SDMA_TIMEOUT = 0xC0000301,

    /* TS exception code 0xC0000400-0xC00004FF */
    RDR_EXC_TYPE_TS_RUNNING_EXCEPTION = 0xC0000400,
    RDR_EXC_TYPE_TS_RUNNING_TIMEOUT = 0xC0000401,
    RDR_EXC_TYPE_TS_INIT_EXCEPTION = 0xC0000402,

    /* AICPU exception code 0xC0000500-0xC00005FF */
    RDR_EXC_TYPE_AICPU_INIT_EXCEPTION = 0xC0000500,
    RDR_EXC_TYPE_AICPU_HEART_BEAT_EXCEPTION = 0xC0000501,

    /* driver exception code 0xC0000600-0xC00006FF, only for driver */
    RDR_EXC_TYPE_END = 0xC0000FFF,
};

enum ThreadType {
    THREAD_SENDING,
    THREAD_RECVING,
    THREAD_MONITOR,
    THREAD_RECYCLE,
    THREAD_REPORTRAS,
    THREAD_PRINTF,
    THREAD_CALLBACK
};

// Runtime engine for task processing, including sending command
// and receiving report.
class Engine : public ThreadRunnable {
public:
    explicit Engine(Device * const dev);
    ~Engine() override;
    Engine &operator=(const Engine &engine) = delete;
    Engine(const Engine &engine) = delete;

    virtual rtError_t Init() = 0;

    // Start the engine process.
    virtual rtError_t Start() = 0;

    // Stop the engine process.
    virtual rtError_t Stop() = 0;

    // Submit task to process.
    virtual rtError_t SubmitTask(TaskInfo * const workTask, uint32_t * const flipTaskId = nullptr, int32_t timeout = -1);
    virtual rtError_t SubmitTaskNormal(TaskInfo * const workTask, uint32_t * const flipTaskId = nullptr);
    virtual rtError_t TaskReclaim(const uint32_t streamId, const bool limited, uint32_t &taskId);
    virtual rtError_t TaskReclaimByStm(Stream * const stm, const bool limited, uint32_t &taskId);
    virtual rtError_t TaskReclaimAllForNoRes(const bool limited, uint32_t &taskId);
    virtual rtError_t RecycleSeparatedStmByFinishedId(Stream * const stm, const uint16_t endTaskId, bool isCqeProcess=false);
    virtual rtError_t SyncTask(Stream * const stm, const uint32_t taskId, const bool isStreamSync,
        int32_t timeout = -1, bool isForce = false);
    void ReportProfData(TaskInfo * const workTask) const;
    bool ProcessTask(TaskInfo *workTask, const uint32_t deviceId);
    rtError_t ProcessTaskWait(TaskInfo * const task) const;
    virtual rtError_t TryRecycleTask(Stream * const stm);
    virtual void SendingWait(Stream * const stm, uint8_t &failCount);
    virtual void SendingNotify() {};
    rtError_t TryAddTaskToStream(TaskInfo * const workTask);

    virtual rtError_t InitStreamRes(const uint32_t streamId);
    virtual rtError_t QueryLatestTaskId(const uint32_t streamId, uint32_t &taskId);
    virtual uint32_t GetShareLogicCqId() const { return MAX_UINT32_NUM; }

    virtual void WakeUpRecycleThread(void) {};

    virtual uint32_t GetTaskIdFromStreamShmTaskId(const uint32_t streamId) {
         (void) streamId;
         return MAX_UINT32_NUM;
    }

    // stars feature
    virtual rtError_t DvppWaitGroup(DvppGrp *grp, rtDvppGrpCallback callBackFunc,
        int32_t timeout = RT_REPORT_TIMEOUT_TIME)
    {
        (void)grp;
        (void)callBackFunc;
        (void)timeout;
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    uint32_t GetDevRunningState()
    {
        if (monitorIsRunning_ == false && runningState_ == DEV_RUNNING_NORMAL) {
            (void)ReportHeartBreakProcV2();
        }
        return static_cast<uint32_t>(runningState_);
    }

    uint32_t GetPendingNum() const
    {
        return pendingNum_.Value();
    }

    void AddPendingNum()
    {
        pendingNum_.Add(1U);
    }

    void SetIsSubmitTaskFailFlag(bool submitTaskFailFlag)
    {
        isSubmitTaskFail_ = submitTaskFailFlag;
    }

    void AddObserver(EngineObserver *observer)
    {
        COND_RETURN_VOID(observerNum_ >= EngineConstExpr::MAX_OBSERVER_NUM, "too many observers");
        observers_[observerNum_] = observer;
        observerNum_++;
    }

    void TaskFinished(const uint32_t devId, const TaskInfo * const workTask)
    {
        for (uint32_t i = 0U; i < observerNum_; i++) {
            observers_[i]->TaskFinished(devId, workTask);
        }
    }

    virtual uint32_t GetShareSqId() const
    {
        return MAX_UINT32_NUM;
    }

    // wait all task to be finish
    void WaitCompletion();
    virtual bool CheckSendThreadAlive() { return false; };
    virtual bool CheckReceiveThreadAlive() { return false; };
    virtual bool CheckMonitorThreadAlive() { return false; };
    void CtrlTaskReclaim(CtrlStream*const stm);
    void RecycleCtrlTask(CtrlStream* const stm, const uint32_t sqPos);
    rtError_t ReportHeartBreakProcV2(void);
    virtual void RecycleThreadDo(void);

    rtError_t CreatePrintfThread(void);
    bool isEnablePrintfThread(void);
protected:
    Device *GetDevice() const
    {
        return device_;
    }

    bool IsExeTaskSame(Stream *const stm, uint32_t taskId) const;
    void SetDevRunningState(const DevRunningState state, const bool direct=false);
    bool ProcessPublicTask(TaskInfo *workTask, const uint32_t deviceId, uint16_t *recycleTaskCount);
    void StreamSyncTaskFinishReport() const;
    void RecycleTask(const uint32_t streamId, const uint32_t taskId);
    void ReportTimeoutProc(const rtError_t error, int32_t &timeoutCnt, const uint32_t streamId = MAX_UINT16_NUM,
        const uint32_t taskId = MAX_UINT16_NUM, const uint32_t execId = MAX_UINT16_NUM,
        const uint64_t msec = MAX_UINT16_NUM);
    void GetProfileEnableFlag(uint8_t * const profileEnabled) const;
    void ReportStatusFailProc(const rtError_t error, const uint32_t deviceId) const;
    void ProcessObserver(const uint32_t deviceId, TaskInfo * const task, rtTsCommand_t * const command) const;
    rtError_t SendCommand(TaskInfo * const workTask, rtTsCommand_t &cmdLocal, rtTsCmdSqBuf_t * const command,
        const uint32_t sendSqeNum);
    void ProcessProfAndObserver(TaskInfo *workTask, const uint32_t deviceId);
    rtError_t GetPublicRecycleTask(TaskInfo * const workTask, Stream * const stm, const bool isTaskBind, const uint16_t endTaskId,
        uint16_t * const delTaskId) const;
    rtError_t DelPublicRecycleTask(const TaskInfo * const workTask, Stream * const stm, const bool isTaskBind,
        const uint16_t endTaskId) const;
    rtError_t GetDavinciDelRecordedTask(Stream * const stm, const uint16_t endTaskId, uint16_t * const delTaskId) const;
    TaskInfo* GetRecycleWorkTask(Stream * const stm, const uint16_t delTaskId) const;
    bool ProcessTaskDavinciList(Stream * const stm,  const uint16_t endTaskId, const uint32_t deviceId);
    bool TaskRecycleProcess(TaskInfo * const recycleTsk, const uint32_t devId);
    uint32_t GetRecycleDavinciTaskNum(const uint16_t lastRecycleEndTaskId,
        const uint16_t recycleEndTaskId, const uint16_t recyclePublicTaskCount) const;
    void TrigerAsyncRecycle(Stream * const stm, const uint16_t lastRecycleTaskId,
                            const uint16_t endTaskId, bool isTaskDelayRecycle);
    void ReportSocketCloseProc();
    void ReportSocketCloseProcV2();
    void ReportOomQueryProc() const;

    rtError_t SendFlipTask(uint16_t preTaskId, Stream *stm);

    void SetWaitTimeout(const int32_t timeout)
    {
        waitTimeout_ = timeout;
    }
    int32_t GetWaitTimeout(void) const
    {
        return waitTimeout_;
    }

    bool TaskIdIsGEQ(const uint32_t lsh, const uint32_t rsh) const
    {
        return TASK_ID_GEQ(lsh, rsh);
    }
    bool TaskIdIsLEQ(const uint32_t lsh, const uint32_t rsh) const
    {
        return TASK_ID_LEQ(lsh, rsh);
    }
    bool TaskIdIsGT(const uint32_t lsh, const uint32_t rsh) const
    {
        return TASK_ID_GT(lsh, rsh);
    }
    bool TaskIdIsLT(const uint32_t lsh, const uint32_t rsh) const
    {
        return TASK_ID_LT(lsh, rsh);
    }
    uint32_t TaskIdAdd(const uint32_t lsh, const uint32_t rsh) const
    {
        return static_cast<uint32_t>(TASK_ID_ADD(lsh, rsh));
    }

    void SetReportSimuFlag(const rtTsReport_t &taskReport) const;
    bool CheckReportSimuFlag(const rtTsReport_t &taskReport) const;
    virtual rtError_t SendTask(TaskInfo * const workTask, uint16_t &taskId, uint32_t * const flipTaskId = nullptr);
    virtual rtError_t SubmitSend(TaskInfo * const workTask, uint32_t * const flipTaskId = nullptr) {
        UNUSED(workTask);
        UNUSED(flipTaskId);
        return RT_ERROR_NONE;
    }
    void ReportStatusOomProc(const rtError_t error, const uint32_t deviceId) const;
    void PrintfRun();
    void DestroyPrintfThread(void);

    EngineObserver *observers_[EngineConstExpr::MAX_OBSERVER_NUM];
    uint32_t observerNum_;

    Atomic<uint32_t> pendingNum_;
    bool monitorIsRunning_;
    int32_t waitTimeout_;

    Device *device_;
    uint64_t reportCount_;
    uint64_t parseTaskCount_;
    std::mutex davinciTaskListMutex_;

    bool stmEmptyFlag_;
    bool isSubmitTaskFail_;

    std::unique_ptr<Thread> printfThread_;
    std::atomic<bool> printThreadRunFlag_{false};
    std::mutex printMtx_;
#ifndef CFG_DEV_PLATFORM_PC
    error_message::Context errorContext_ = {0UL, "", "", ""};
#endif

private:
    DevRunningState runningState_;
}; // class Engine
}  // namespace runtime
}  // namespace cce

#endif  // __CCE_RUNTIME_ENGINE_HPP__
