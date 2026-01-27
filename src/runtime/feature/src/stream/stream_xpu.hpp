/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_STREAM_XPU_HPP__
#define __CCE_RUNTIME_STREAM_XPU_HPP__
#include "stream.hpp"
#include "arg_manage_xpu.hpp"

namespace cce {
namespace runtime {
class XpuStream : public Stream {
public:
    explicit XpuStream(Device *const dev, const uint32_t stmFlags);
    ~XpuStream() override;
    rtError_t Setup(void) override;
    rtError_t TearDown(const bool terminal = false, bool flag = true) override;
    rtError_t AddTaskToList(const TaskInfo * const tsk) override;
    rtError_t StarsAddTaskToStream(TaskInfo * const tsk, const uint32_t sendSqeNum) override;
    rtError_t StarsGetPublicTaskHead(TaskInfo *workTask, const bool isTaskBind, const uint16_t tailTaskId,
        uint16_t * const delTaskId) override;
    rtError_t DavidUpdatePublicQueue() override;
    bool IsExistCqe(void) const override;
    rtError_t CreateStreamTaskRes(void) override;
    uint32_t GetCurSqPos() const override;
    uint32_t GetPendingNum() const  override;
    void ArgRelease(TaskInfo * const taskInfo, bool freeStmPool) const;
    void XpuFreeStreamId() const;
    void XpuReleaseStreamArgRes();
    void SetRecycleFinishTaskId(uint32_t taskSn)
    {
        recycleFinishTaskId_ = taskSn;
    }
    uint32_t GetRecycleFinishTaskId() const
    {
        return recycleFinishTaskId_;
    }
    void EnterFailureAbort() override;
    uint32_t GetTaskPosHead() const override;
    uint32_t GetTaskPosTail() const override;
    rtError_t CheckContextStatus(const bool isBlockDefaultStream = true) const override;
    rtError_t GetFinishedTaskIdBySqHead(const uint16_t sqHead, uint32_t &finishedId) override;
    rtError_t GetSynchronizeError(rtError_t error) override;
    rtError_t SynchronizeExecutedTask(const uint32_t taskId, const mmTimespec &beginTime, int32_t timeout) override;
    rtError_t Synchronize(const bool isNeedWaitSyncCq, int32_t timeout) override;
    void ArgReleaseStmPool(TaskInfo * const taskInfo) const;
    void ArgReleaseSingleTask(TaskInfo * const taskInfo, bool freeStmPool) const;
    template<typename T>
    rtError_t LoadArgsInfo(const T *argsInfo, const bool useArgPool, DavidArgLoaderResult * const result)
    {
        if (argManage_ != nullptr) {
            return argManage_->LoadArgs(argsInfo, useArgPool, result);
        }
        result->kerArgs = argsInfo->args;
        return RT_ERROR_NONE;
    }

    uint32_t GetArgPos() const;

    bool GetIsHasArgPool() const
    {
        return isHasArgPool_;
    }

    XpuArgManage *ArgManagePtr() const
    {
        return argManage_;
    }

protected:
    bool isHasArgPool_{false};
    uint32_t publicQueueHead_{0U};
    uint32_t publicQueueTail_{0U};
    uint32_t recycleFinishTaskId_{MAX_UINT32_NUM};
private:
    XpuArgManage *argManage_{nullptr};
    rtError_t CreateStreamArgRes();
};

}  // namespace runtime
}  // namespace cce

#endif // __CCE_RUNTIME_STREAM_DAVID_HPP__
