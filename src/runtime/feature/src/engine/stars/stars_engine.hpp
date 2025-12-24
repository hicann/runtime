/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_STARS_ENGINE_HPP__
#define __CCE_RUNTIME_STARS_ENGINE_HPP__

#include <map>
#include <condition_variable>
#include "base.hpp"
#include "osal.hpp"
#include "driver.hpp"
#include "dvpp_grp.hpp"
#include "task_info.hpp"
#include "engine.hpp"
#ifndef CFG_DEV_PLATFORM_PC
#include "error_manager.h"
#endif

namespace cce {
namespace runtime {
// Runtime engine for STARS task processing, including sending command and receiving report for stars remove thread.
class StarsEngine : public Engine {
public:
    explicit StarsEngine(Device * const dev,
                         Thread * const monitor = nullptr,
                         Thread * const recycle = nullptr);
    ~StarsEngine() noexcept override;

    rtError_t Init() override;

    rtError_t Start() override;

    rtError_t Stop() override;

    // create monitor thread and recycle thread
    void Run(const void * const param) override;

    rtError_t SyncTask(Stream * const stm, const uint32_t taskId, const bool isStreamSync,
        int32_t timeout = -1, bool isForce = false) override;

    void ProcReport(const uint32_t taskId, const bool isStreamSync, const uint32_t cnt,
        rtLogicCqReport_t * const logicReport, bool &isFinished, uint32_t cqId);

    void ProcLogicCqReport(const rtLogicCqReport_t &logicCq, const bool isStreamSync, TaskInfo *reportTask);
    void ClearMulTaskCqeNum(const uint8_t mulTaskCqeNum, TaskInfo * const repTask) const;

    rtError_t DvppWaitGroup(DvppGrp *grp, rtDvppGrpCallback callBackFunc,
        int32_t timeout = RT_REPORT_TIMEOUT_TIME) override;

    rtError_t TaskReclaim(const uint32_t streamId, const bool limited, uint32_t &taskId) override;
    rtError_t TaskReclaimByStm(Stream * const stm, const bool limited, uint32_t &taskId) override;
    rtError_t TaskReclaimAllForNoRes(const bool limited, uint32_t &taskId) override;
    rtError_t ProcLogicCqUntilEmpty(const Stream * const stm, uint32_t &taskId);
    rtError_t TaskReclaimForSeparatedStm(Stream * const stm);
    void IsSyncTaskFinish(Stream * const stm, const uint32_t taskId) const;

    rtError_t TryRecycleTask(Stream * const stm) override;

    void SendingWaitProc(Stream * const stm);

    rtError_t AddTaskToStream(TaskInfo * const workTask, const uint32_t sendSqeNum);

    rtError_t CreateMonitorThread(void);

    void SyncTaskCheckResult(const rtError_t error, const Stream * const stm, const uint16_t taskId) const;
    bool CheckMonitorThreadAlive() override;
    void WakeUpRecycleThread(void) override;
    void RecycleThreadDo(void) override;
    rtError_t RecycleSeparatedStmByFinishedId(Stream * const stm, const uint16_t endTaskId, bool isCqeProcess=false) override;
    void RecycleTaskProcessForSeparatedStm(TaskInfo * const recycleTask, const uint32_t devId);
    rtError_t CreatePrintfThread(void) override;
    bool isEnablePrintfThread(void) override;

private:
    void GetRecycleHead(const uint16_t taskHead, const uint16_t sqHead,
        uint32_t const rtsqDepth, uint16_t &recycleHead) const;

    rtError_t FinishedTaskReclaim(Stream * const stm, const bool limited, uint16_t taskHead,
                                  uint16_t sqHead, uint32_t &taskId);

    rtError_t MonitorTaskReclaim(uint16_t errorStreamId);

    void MonitorForWatchDog(Device * const dev);

    void MonitorEndGraphNotify(Device * const dev) const;

    rtError_t AdjustRecycleTaskID(Stream * const stm, uint32_t &endTaskId, uint16_t pos) const;

    rtError_t TaskReclaimByStreamId(const uint32_t streamId, const bool limited, uint32_t &taskId);

    rtError_t ProcessHeadTaskByStreamId(const uint16_t streamId);

    rtError_t SendingProcReport(Stream * const stm, const bool limited, uint16_t sqHead, uint32_t &taskId);

    rtError_t RecycleTaskBySqHead(Stream * const stm, uint32_t &finishTaskId);
    rtError_t TaskReclaimBySqHeadForSeparatedStm(Stream * const stm);
    rtError_t TaskReclaimByCqeForSeparatedStm(Stream * const stm);

    rtError_t SendTask(TaskInfo * const workTask, uint16_t &taskId, uint32_t * const flipTaskId = nullptr) override;

    rtError_t SubmitSend(TaskInfo * const workTask, uint32_t * const flipTaskId) override;

    rtError_t StarsResumeRtsq(const rtLogicCqReport_t &logicCq,
        const uint16_t taskType, const Stream * const failStm) const;

    void StarsCqeReceive(const rtLogicCqReport_t &logicCq, TaskInfo * const runTask) const;

    bool ProcReportIsVpcErrorAndRetry(const rtLogicCqReport_t& report);

    bool ProcReportIsException(const rtLogicCqReport_t &logicCq, TaskInfo *reportTask = nullptr) const;

    rtError_t MultipleTaskReportLogicCq(TaskInfo * const workTask, const rtLogicCqReport_t& report,
                                        rtDvppGrpCallback callBackFunc);

    rtError_t CommonTaskReportLogicCq(const rtLogicCqReport_t &report, rtDvppGrpCallback callBackFunc);

    rtError_t ReportLogicCq(const rtLogicCqReport_t& report, rtDvppGrpCallback callBackFunc);

    void StarsReportLogicCq(const rtLogicCqReport_t &report, rtDvppGrpCallback callBackFunc);

    void StarsReportLogicCq(const rtLogicCqReport_t &report, rtDvppGrpCallback callBackFunc,
                            uint8_t sqeType, uint8_t cqeErrorCode);

    void ProcCommonLogicCqReport(const rtLogicCqReport_t &report, const uint32_t taskId,
                                 const bool isStreamSync, bool &isFinished);

    bool CompleteProcMultipleTaskReport(TaskInfo * const workTask, const rtLogicCqReport_t &report) const;
    bool ProcMultipleTaskLogicCqReport(TaskInfo * const workTask, const rtLogicCqReport_t &report,
                                       const bool isStreamSync);
    static const std::vector<std::string> StarsCqeErrorDesc_;

    void MonitoringRun();
    void PrintfRun();
    rtError_t CreateRecycleThread(void);
    void RecycleThreadRun(void);
    void DestroyRecycleThread(void);
    void DestroyPrintfThread(void);

    Thread *monitorThread_;
    Thread *recycleThread_;
    std::unique_ptr<Thread> printfThread_;
    volatile bool recycleThreadRunFlag_ = false;
    volatile bool monitorThreadRunFlag_ = false;
    std::atomic<bool> printThreadRunFlag_{false};
    std::mutex printMtx_;
    mmSem_t recycleThreadSem_;

#ifndef CFG_DEV_PLATFORM_PC
    error_message::Context errorContext_ = {0UL, "", "", ""};
#endif
};
}  // namespace runtime
}  // namespace cce

#endif  // __CCE_RUNTIME_STARS_ENGINE_HPP__
