/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_TASK_RES_DAVID_HPP
#define CCE_RUNTIME_TASK_RES_DAVID_HPP

#include "task_res.hpp"
namespace cce {
namespace runtime {

class TaskResManageDavid : public TaskResManage {
public: 
    TaskResManageDavid();
    ~TaskResManageDavid() override;

    TaskInfo* GetTaskInfo(uint32_t taskId) const override;
    void ResetTaskRes() override;
    bool RecycleTaskInfo(uint32_t pos, uint32_t sqeNum);
    rtError_t AllocTaskInfoAndPos(uint32_t sqeNum, uint32_t &pos, TaskInfo **task, bool needLog = true);
    void GetHeadTail(uint16_t &head, uint16_t &tail) const;
    void RollbackTail(uint16_t pos);

    uint16_t GetTaskPosHead() const
    {
        return taskResAHead_.Value();
    }

    uint16_t GetTaskPosTail() const
    {
        return taskResATail_.Value();
    }

    bool IsEmpty() const
    {
        return taskResAHead_.Value() == taskResATail_.Value();
    }

    uint64_t GetAllocNum() const
    {
        return allocNum_;
    }

    uint16_t GetPendingNum();
    bool IsRecyclePosValid(uint16_t recyclePos) const;
    bool CreateTaskRes(Stream* stm) override;

private:
    Atomic<uint16_t> taskResAHead_{0U};
    Atomic<uint16_t> taskResATail_{0U};
    uint64_t allocNum_{0U};
};

}  // namespace runtime
}  // namespace cce

#endif  // CCE_RUNTIME_TASK_RES_DAVID_HPP
