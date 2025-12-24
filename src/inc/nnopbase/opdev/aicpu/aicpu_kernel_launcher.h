/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OP_API_COMMON_INC_OPDEV_AICPU_KERNEL_LAUNCHER_H_
#define OP_API_COMMON_INC_OPDEV_AICPU_KERNEL_LAUNCHER_H_

#include "opdev/op_arg_def.h"
#include "opdev/aicpu/aicpu_task.h"
#include "opdev/internal/kernel_launcher.h"
#include "opdev/internal/bridge/bridge_graph.h"

namespace op {
namespace internal {
class AiCpuKernelLauncher : public KernelLauncher {
public:
    AiCpuKernelLauncher(uint32_t optype,
                        op::CoreType coreType,
                        const aclOpExecutor *opExe,
                        op::internal::ProfilingInfoId &profilingInfoId,
                        AicpuTask *task,
                        OpArgContext *opArgCtx)
        : KernelLauncher(optype, coreType, opExe, profilingInfoId),
          task_(task),
          args_(opArgCtx) {}

    ~AiCpuKernelLauncher() override
    {
        if (executor_->IsRepeatable()) {
            task_->SetVisit(false);
        }
        if (args_) {
            op::DestroyOpArgContext(args_);
            args_ = nullptr;
        }
    }

    aclnnStatus Launch() override
    {
        AICPU_ASSERT_NOTNULL_RETVAL(task_);
        AICPU_ASSERT_OK_RETVAL(task_->SetIoTensors(const_cast<aclOpExecutor *>(executor_), args_));
        const auto ret = task_->Run(const_cast<aclOpExecutor *>(executor_), executor_->GetStream());
        if (!executor_->IsRepeatable()) {
            task_->SetVisit(false);
        }
        return ret;
    }

    internal::OpKernelBin *GetBin() override { return nullptr; }

    bool CheckRepeatable([[maybe_unused]] const std::unordered_map<const aclStorage *, const aclStorage *> &relation,
        [[maybe_unused]] const std::vector<const aclStorage *> &oriStorage) override
    {
        LauncherRepeatableChecker checker(relation, oriStorage);
        return checker.CheckLauncherRepeatable(args_);
    }

private:
    AicpuTask *task_;
    // tuple of op args of different types.
    OpArgContext *args_{nullptr};
};
}
}
#endif