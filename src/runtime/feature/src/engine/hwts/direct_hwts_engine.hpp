/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_DIRECT_HWTS_ENGINE_HPP
#define CCE_RUNTIME_DIRECT_HWTS_ENGINE_HPP

#include "hwts_engine.hpp"
#include "device.hpp"
#include "runtime.hpp"
#include "shm_cq.hpp"

namespace cce {
namespace runtime {
class DirectHwtsEngine : public HwtsEngine {
public:
    explicit DirectHwtsEngine(Device * const dev);
    ~DirectHwtsEngine() override;

    rtError_t Init() override;
    // Start the engine process.
    rtError_t Start() override;
    // Stop the engine process.
    rtError_t Stop() override;
    // create monitor thread and recycle thread
    void Run(const void * const param) override;

    rtError_t InitStreamRes(const uint32_t streamId) override;
    rtError_t QueryLatestTaskId(const uint32_t streamId, uint32_t &taskId) override;
    uint32_t GetShareLogicCqId() const override
    {
        return logicCqId_;
    }

    rtError_t SyncTask(Stream * const stm, const uint32_t taskId, const bool isStreamSync,
        int32_t timeout = -1, bool isForce = false) override;
    rtError_t TryRecycleTask(Stream * const stm) override;
    void SendingWait(Stream * const stm, uint8_t &failCount) override;
    rtError_t TaskReclaimAllForNoRes(const bool limited, uint32_t &taskId) override;
    rtError_t TaskReclaim(const uint32_t streamId, const bool limited, uint32_t &taskId) override;
    uint32_t GetTaskIdFromStreamShmTaskId(const uint32_t streamId) override;

    bool CheckMonitorThreadAlive() override;
    void WakeUpRecycleThread(void) override;

protected:
    uint32_t GetShareSqId() const override;

    rtError_t QueryShmInfo(const uint32_t streamId, const bool limited, uint32_t &taskId);
    void SyncTaskQueryShm(const uint32_t streamId, const uint32_t taskId, const uint32_t cqId);
    void ProcessFastCqTask(const uint32_t streamId, const uint32_t taskId);

    void IsSyncFinish(const uint32_t taskId, uint32_t cnt, const rtLogicReport_t *logicReport) const;
    bool UpdateTaskIdForTaskStatus(const uint32_t streamId, const uint16_t taskId);

    // task submit
    rtError_t SubmitSend(TaskInfo * const workTask, uint32_t * const flipTaskId = nullptr) override;

private:
    void MonitoringRun();
    bool ProcLogicReport(const rtLogicReport_t &logic, const uint32_t drvErr, const bool isStreamSync);
    void ProcAicpuErrMsgReport(const rtLogicReport_t &logic) const;
    bool ProcessReport(const rtTaskReport_t * const report, const uint32_t drvErr, const bool isStreamSync);
    std::string GetKernelNameForAiCoreorAiv(const uint32_t streamId, const uint32_t taskId) const;
    bool PreProcessTask(TaskInfo *preTask, const uint32_t deviceId);

    void RecycleThreadRun(void);
    rtError_t CreateRecycleThread(void);
    void DestroyRecycleThread(void);

    rtShmQuery_t *TaskStatusAlloc(const uint32_t streamId);
    void EraseTaskStatus(const size_t streamId);

    // recycle task
    void TaskReclaimEx(const uint32_t streamId, const bool limited, uint32_t &taskId, rtShmQuery_t &shareMemInfo);
    bool HandleShmTask(const uint32_t streamId, const bool limited, rtShmQuery_t &shareMemInfo);
    void ReportLastError(const uint32_t streamId, const uint32_t taskId,
                         const uint32_t errorCode, const uint32_t errorDesc);

    Thread *monitorThread_;
    Thread *recycleThread_;
    volatile bool recycleThreadRunFlag_ = false;
    volatile bool monitorThreadRunFlag_ = false;
    mmSem_t recycleThreadSem_;
    ShmCq shmCq_;
    std::mutex statusMutex_;    // Guard for task recycle status.
    std::vector<rtShmQuery_t *> vecTaskStatus_{std::vector<rtShmQuery_t *>(RT_MAX_STREAM_ID, nullptr)};

    uint32_t logicCqId_{MAX_UINT32_NUM};
}; // class DirectHwtsEngine
}  // namespace runtime
}  // namespace cce

#endif  // CCE_RUNTIME_DIRECT_HWTS_ENGINE_HPP