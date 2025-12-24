/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OP_API_OP_API_COMMON_INC_OPDEV_KERNEL_LAUNCHER_H
#define OP_API_OP_API_COMMON_INC_OPDEV_KERNEL_LAUNCHER_H

#include <utility>

#include "kernel_mgr.h"
#include "opdev/op_arg_def.h"
#include "opdev/internal/op_dfx_internal.h"
#include "opdev/object.h"
#include "opdev/op_def.h"
#include "opdev/op_executor.h"
#include "opdev/op_log.h"
#include "runtime/context.h"
#include "opdev/internal/launcher_ctx.h"

namespace op {

class KernelLauncher : public op::Object {

public:
    KernelLauncher(uint32_t opType, op::CoreType coreType, const aclOpExecutor *executor,
        const op::internal::ProfilingInfoId &profilingInfoId)
        : opType_(opType), coreType_(coreType), executor_(executor), profilingInfoId_(profilingInfoId)
    {
        opLogInfo_ = op::internal::GetThreadLocalContext().logInfo_;
    }
    ~KernelLauncher() override
    {}
    virtual aclnnStatus Launch() = 0;
    virtual internal::OpKernelBin *GetBin() = 0;
    virtual bool CheckRepeatable([[maybe_unused]] const std::unordered_map<const aclStorage *, const aclStorage *> &,
        [[maybe_unused]] const std::vector<const aclStorage *> &) = 0;
    uint32_t GetOpType() const
    {
        return opType_;
    }
    void SetOpType(uint32_t type)
    {
        opType_ = type;
    }
    void UpdateThreadLocal()
    {
        op::internal::GetThreadLocalContext().logInfo_.l0Name = opLogInfo_.l0Name;
    }

protected:
    uint32_t opType_;
    op::CoreType coreType_;
    const aclOpExecutor *executor_;
    op::internal::ProfilingInfoId profilingInfoId_;
    op::internal::OpLogInfo opLogInfo_;
};

class LauncherRepeatableChecker {
public:
    LauncherRepeatableChecker(const std::unordered_map<const aclStorage *, const aclStorage *> &relation,
        const std::vector<const aclStorage *> &oriStorage)
        : relation_(relation), oriStorage_(oriStorage)
    {}

    void CheckLaunchArg(const aclTensor *arg)
    {
        if (!canRepeatable_ || arg == nullptr || arg->IsFromWorkspace() || arg->GetPlacement() != gert::kOnDeviceHbm) {
            return;
        }
        auto s = arg->GetStorage();
        // l0 use l2 tensor
        if (std::find(oriStorage_.begin(), oriStorage_.end(), s) != oriStorage_.end()) {
            return;
        }

        auto storageRelate = relation_.find(s);
        if (storageRelate == relation_.end()) {
            OP_LOGW("launcher repeat check fail, find tensor relation fail");
            canRepeatable_ = false;
            return;
        }
        // viewCopy or createView product l0 tensor and l2 tensor relation
        auto rel = storageRelate->second;
        if (std::find(oriStorage_.begin(), oriStorage_.end(), rel) == oriStorage_.end()) {
            OP_LOGW("launcher repeat check fail, find tensor fail");
            canRepeatable_ = false;
            return;
        }
    }

    void CheckLaunchArg(const aclTensorList *arg)
    {
        if (!canRepeatable_ || arg == nullptr) {
            return;
        }
        for (uint64_t i = 0; i < arg->Size(); i++) {
            CheckLaunchArg((*arg)[i]);
        }
    }

    void CheckLaunchArg(OpArg &arg)
    {
        if (arg.type == OpArgType::OPARG_ACLTENSOR) {
            CheckLaunchArg(reinterpret_cast<aclTensor *>(arg->pointer));
        } else if (arg.type == OpArgType::OPARG_ACLTENSOR_LIST) {
            CheckLaunchArg(reinterpret_cast<aclTensorList *>(arg->pointer));
        }
    }

    bool CheckLauncherRepeatable(OpArgContext *args)
    {
        if (args->ContainsOpArgType(OpArgDef::OP_INPUT_ARG)) {
            args->GetOpArg(OpArgDef::OP_INPUT_ARG)->VisitByNoReturn([this]([[maybe_unused]] size_t idx, OpArg &elem) {
                this->CheckLaunchArg(elem);
            });
        }
        if (args->ContainsOpArgType(OpArgDef::OP_OUTPUT_ARG)) {
            args->GetOpArg(OpArgDef::OP_OUTPUT_ARG)->VisitByNoReturn([this]([[maybe_unused]] size_t idx, OpArg &elem) {
                this->CheckLaunchArg(elem);
            });
        }
        if (args->ContainsOpArgType(OpArgDef::OP_OUTSHAPE_ARG)) {
            return false;
        }
        if (args->ContainsOpArgType(OpArgDef::OP_WORKSPACE_ARG)) {
            args->GetOpArg(OpArgDef::OP_WORKSPACE_ARG)
                ->VisitByNoReturn([this]([[maybe_unused]] size_t idx, OpArg &elem) { this->CheckLaunchArg(elem); });
        }
        return canRepeatable_;
    }

private:
    const std::unordered_map<const aclStorage *, const aclStorage *> &relation_;
    const std::vector<const aclStorage *> &oriStorage_;
    bool canRepeatable_{true};
};

class AiCoreKernelLauncher : public KernelLauncher {
public:
    AiCoreKernelLauncher(uint32_t opType, op::CoreType coreType, const op::internal::ProfilingInfoId &profilingId,
        const aclOpExecutor *executor,
        // use rvalue to force using OpInput/OpOutput... template to generate op args.
        OpArgContext *args)
        : KernelLauncher(opType, coreType, executor, profilingId), args_(args)
    {}

    ~AiCoreKernelLauncher() override
    {
        if (args_) {
            op::DestroyOpArgContext(args_);
            args_ = nullptr;
        }
        if (launchCtx_.GetLauncherRepeatable()) {
            OP_LOGI("delete launch ctx in repeatable launcher destructor");
            launchCtx_.Reset();
        }
    }

    void SaveLaunchCtx(op::internal::LauncherContext &&ctx)
    {
        launchCtx_ = std::move(ctx);
    }

    aclnnStatus Launch() override
    {
        internal::GetLauncherCtx() = std::move(launchCtx_);
        bool isRepeatable = executor_->IsRepeatable();
        internal::GetLauncherCtx().SetLauncherRepeatable(isRepeatable);
        // 1. Restore thread local, put these codes at the begining
        op::internal::GetThreadLocalContext().logInfo_.l0Name = opLogInfo_.l0Name;
        op::internal::GetThreadLocalContext().profilingInfoId_ = profilingInfoId_;

        // 2. Dump Inputs
        if (op::internal::IsDumpEnable()) {
            op::internal::DumpL0(*args_->GetOpArg(op::OP_INPUT_ARG), opLogInfo_, OpInputType, executor_->GetStream());
        }

        // 3. Do Tiling & KernelLaunch
        op::internal::SetOpImplModeCtx(*args_->GetOpArg(op::OP_OPTION_ARG));
        auto res = op::internal::gKernelMgr.Run(opType_, executor_->GetStream(), args_);

        // 4. Dump Outputs
        if (op::internal::IsDumpEnable()) {
            op::internal::DumpL0(*args_->GetOpArg(op::OP_OUTPUT_ARG), opLogInfo_, OpOutputType, executor_->GetStream());
        }

        if (res == ACLNN_SUCCESS && op::internal::IsOverflowDumpEnable()) {
            (void)op::internal::OverflowDumpProcess(
                args_, const_cast<aclOpExecutor *>(executor_), executor_->GetStream(), opLogInfo_);
            internal::GetLauncherCtx().ClearTilingCache();
        }
        if (isRepeatable) {
            launchCtx_ = std::move(internal::GetLauncherCtx());
        } else {
            internal::GetLauncherCtx().Reset();
        }
        return res;
    }

    op::internal::OpKernelBin *GetBin() override
    {
        internal::OpKernel *opKernel = op::internal::gKernelMgr.GetKernel(opType_);
        if (opKernel == nullptr) {
            return nullptr;
        }

        // TODO: if not op input or output arg, compile will fail.
        // Use ContainsOpArgType to check input/output existence if absence of input/output is allowed.
        return opKernel->SelectBin(
            *args_->GetOpArg(op::OP_INPUT_ARG), *args_->GetOpArg(op::OP_OUTPUT_ARG), *args_->GetOpArg(op::OP_ATTR_ARG));
    }

    bool CheckRepeatable(const std::unordered_map<const aclStorage *, const aclStorage *> &relation,
        const std::vector<const aclStorage *> &oriStorage) override
    {
        LauncherRepeatableChecker checker(relation, oriStorage);
        return checker.CheckLauncherRepeatable(args_);
    }

private:
    // tuple of op args of different types.
    // std::tuple<T...> args_;
    OpArgContext *args_{nullptr};
    op::internal::LauncherContext launchCtx_;
    uint8_t reserved_field_[32];  // Reserved field
};

}  // namespace op

#endif
