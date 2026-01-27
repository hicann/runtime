/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_STREAM_DAVID_HPP__
#define __CCE_RUNTIME_STREAM_DAVID_HPP__
#include "stream.hpp"
#include "arg_manage_david.hpp"

namespace cce {
namespace runtime {
constexpr uint32_t COUNT_NOTIFY_STATIC_THRESHOLD = 0xFFFFFFFDU;
class DavidStream : public Stream {
public:
    explicit DavidStream(Device * const dev, const uint32_t prio, const uint32_t stmFlags, DvppGrp * const dvppGrp);
    ~DavidStream() override;
    rtError_t DavidUpdatePublicQueue(void) override;
    void StarsShowStmDfxInfo(void) override;
    rtError_t SubmitRecordTask(int32_t timeout) override;
    uint32_t GetPendingNum() const override;
    rtError_t PrintStmDfxAndCheckDevice(uint64_t& beginCnt, uint64_t& endCnt, uint16_t& checkCount, uint32_t tryCount) override;
    rtError_t StarsAddTaskToStream(TaskInfo * const tsk, const uint32_t sendSqeNum) override;
    rtError_t AddTaskToList(const TaskInfo * const tsk) override;
    rtError_t CreateStreamTaskRes(void) override;
    rtError_t TearDown(const bool terminal = false, bool flag = true) override;
    bool IsSeparateSendAndRecycle() override;
    virtual rtError_t SetupByFlagAndCheck(void);
    rtError_t Setup(void) override;
    void StarsShowPublicQueueDfxInfo(void) override;
    uint32_t GetCurSqPos(void) const override;
    // public queue stores the initial pos of each task. *delTaskPos = the initial pos of the task.
    rtError_t StarsGetPublicTaskHead(TaskInfo *workTask, const bool isTaskBind, const uint16_t tailTaskId,
        uint16_t * const delTaskId) override;
    bool IsCntNotifyReachThreshold(void) override;
    rtError_t ApplyCntNotifyId(int32_t &newEventId) override;
    void GetCntNotifyId(int32_t &newEventId) override;
    rtError_t ApplyCntValue(uint32_t &cntValue) override;
    rtError_t ResClear(uint64_t timeout = 0) override;
    uint32_t StarsGetMaxTryCount() const override;
    void DebugDotPrintForModelStm() override;
    uint32_t GetDelayRecycleTaskSqeNum(void) const override;
    rtError_t QueryWaitTask(bool &isWaitFlag, const uint32_t taskId) override;
    rtError_t JudgeTaskFinish(uint16_t taskPos, bool &isFinished) override;
    rtError_t JudgeHeadTailPos(rtEventStatus_t * const status, uint16_t eventPos) override;
    rtError_t GetLastTaskIdFromRtsq(uint32_t &lastTaskId) override;

    // use for fast recover
    void ResetDavidStreamConstruct();
    void ModelTaskClean() ;
    rtError_t StreamRecoverAbort() override;
    rtError_t StreamTaskClean() override;
    rtError_t ModelAbortById(uint32_t modelId) override;
    bool IsWaitFinish(const uint32_t finishedTaskId, const uint32_t submittedTaskId) override;
    rtError_t GetAbortStatus() const override;
    rtError_t SubmitMaintenanceTask(const MtType type, bool isForceRecycle, int32_t targetStmId,
        const uint32_t logicCqId = 0U, bool terminal = false);
    bool AddArgToRecycleList(TaskInfo * const tsk) override;
    void ProcArgRecycleList(void) override;
    rtError_t GetTaskIdByPos(const uint16_t pos, uint32_t &taskId) override;
    uint32_t GetTaskPosHead() const override;
    uint32_t GetTaskPosTail() const override;
    bool IsTaskExcuted(const uint32_t executeEndTaskid, const uint32_t taskId) override;
    bool SynchronizeDelayTime(const uint16_t finishedId, const uint16_t taskId, const uint16_t sqHead) override;

    bool GetIsHasArgPool() const
    {
        return isHasArgPool_;
    }
    DavidArgManage *ArgManagePtr() const
    {
        return argManage_;
    }

    template<typename T>
    rtError_t LoadArgsInfo(const T *argsInfo, const bool useArgPool, DavidArgLoaderResult * const result)
    {
        if (argManage_ != nullptr) {
            return argManage_->LoadArgs(argsInfo, useArgPool, result);
        }
        result->kerArgs = argsInfo->args;
        return RT_ERROR_NONE;
    }

    uint32_t GetArgPos();

    void ArgReleaseSingleTask(TaskInfo * const taskInfo, bool freeStmPool);
    void ArgReleaseStmPool(TaskInfo * const taskInfo);
    void ArgReleaseMultipleTask(TaskInfo * const taskInfo);
    Atomic<uint16_t> latestConcernedTaskId{MAX_UINT16_NUM};
protected:
    bool isHasArgPool_{false};

private:
    uint64_t sqAddr_{0ULL};
    std::mutex cntNotifyInfoLock_;
    uint32_t cntNotifyId_{MAX_UINT32_NUM};
    Atomic<uint32_t> recordVersion_{0U};
    uint32_t publicQueueHead_{0U};
    uint32_t publicQueueTail_{0U};
    DavidArgManage *argManage_{nullptr};

    rtError_t CreateStreamArgRes();
    void ReleaseStreamArgRes();
};

}  // namespace runtime
}  // namespace cce

#endif // __CCE_RUNTIME_STREAM_DAVID_HPP__
