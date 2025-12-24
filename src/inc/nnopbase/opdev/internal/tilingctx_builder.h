/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __TILINGCTX_BUILDER_H__
#define __TILINGCTX_BUILDER_H__

#include <array>
#include <iostream>
#include <string>
#include <vector>

#include "exe_graph/runtime/compute_node_info.h"
#include "exe_graph/runtime/kernel_run_context.h"
#include "exe_graph/runtime/tensor.h"
#include "exe_graph/runtime/tensor_data.h"
#include "exe_graph/runtime/tiling_context.h"
#include "opdev/op_def.h"
#include "opdev/op_dfx.h"
#include "opdev/internal/kernel_context_holder.h"
#include "opdev/internal/tiling_parse_ctx_holder.h"
#include "opdev/internal/op_dfx_internal.h"

namespace op {
namespace internal {

class TilingResCache {
public:
    bool IsValid() const
    {
        return valid_;
    }

    explicit TilingResCache(const TilingCtxOutput *res)
    {
        if (res == nullptr || res->tilingData_ == nullptr) {
            return;
        }

        // copy tiling data
        size_t wsNum = res->workspaceSize_->GetSize();
        size_t sz = wsNum * sizeof(size_t) + res->tilingData_->data_size_;
        void *p = BlockPool::Malloc(sz);
        if (p == nullptr) {
            return;
        }
        workspaceNum_ = wsNum;
        workspaceSize_ = static_cast<size_t*>(p);
        if (wsNum > 0) {
            OP_CHECK(memcpy_s(p, sz, res->workspaceSize_->GetData(), wsNum * sizeof(size_t)) == EOK,
                     OP_LOGW("Failed to memcpy in workspace addr."),
                     ;);
        }
        OP_CHECK(
            memcpy_s(PtrShift(p, wsNum * sizeof(size_t)), sz, res->tilingData_->data_, res->tilingData_->data_size_) ==
                EOK,
            OP_LOGW("Failed to memcpy in tiling data."),
            ;);
        rawTilingData_ = PtrShift(p, res->workspaceSize_->GetSize() * sizeof(size_t));
        rawTilingDataLen_ = res->tilingData_->data_size_;

        tilingKey_ = *(res->tilingKey_);
        blockDim_ = *(res->blockDim_);
        atomicCleanFlag_ = *(res->atomicCleanFlag_);
        tilingCond_ = *(res->tilingCond_);
        scheduleMode_ = *(res->scheduleMode_);
        localMemorySize_ = *(res->localMemorySize_);
        inputNum_ = res->inputNum_;
        outputNum_ = res->outputNum_;
        valid_ = true;
    }

    ~TilingResCache()
    {
        OP_LOGI("#### release tiling result");
        if (workspaceSize_ != nullptr) {
            BlockPool::Free(workspaceSize_);
            workspaceSize_ = nullptr;
        }
    }

    bool valid_{false};

    uint64_t tilingKey_;
    int64_t blockDim_;
    bool atomicCleanFlag_;
    void *rawTilingData_{nullptr};
    size_t rawTilingDataLen_;
    size_t *workspaceSize_{nullptr};
    size_t workspaceNum_;
    int64_t tilingCond_;
    uint8_t scheduleMode_;
    uint32_t localMemorySize_;

    size_t inputNum_;
    size_t outputNum_;
};

class TilingCtxHolder {
public:
    TilingCtxHolder()
    {
        BuildTilingCtx();
    }

    ~TilingCtxHolder();

    /*
   * outputs, tiling的outputs以如下顺序排列：
   * outputs[0]: tiling-key
   * outputs[1]: block-dim
   * outputs[2]: atomic-clean-flag
   * outputs[3]: tiling-data
   * outputs[4]: workspace sizes
   * outputs[5]: tiling condition
   */
    enum TilingOutputIndex {
        kOutputTilingKey,
        kOutputBlockDim,
        kOutputAtomicCleanFlag,
        kOutputTilingData,
        kOutputWorkspace,
        kOutputTilingCond,
        kOutputScheduleMode,
        kOutputLocalMemorySize,
        // add new output definitions here
        kOutputNum
    };

    aclnnStatus UpdateTilingCtx(const KernelContextHolder *kernelCtx, const TilingParseCtxHolder *tilingParseCtx);
    aclnnStatus UpdateTilingCtx(const KernelContextHolder *kernelCtx);
    gert::TilingContext *GetTilingCtx(const TilingParseCtxHolder *tilingParseCtx) const
    {
        gert::TilingContext *ctx = PtrCastTo<gert::TilingContext>(tilingCtx_);
        if (opProfilingSwitch.recordOpArgFlag) {
            OP_LOGI("Call ExeOptInfoStat, option %d %s. kernel info %d %s.",
                    tilingParseCtx->GetCompileOptions().deterministic,
                    tilingParseCtx->GetCompileOptions().impl_mode.c_str(), tilingParseCtx->GetOpKernelInfo()->bin_type,
                    tilingParseCtx->GetOpKernelInfo()->bin_info.c_str());
            aclnnOpInfoRecord::OpInfoSerialize(
                ctx, tilingParseCtx->GetCompileOptions(), tilingParseCtx->GetOpKernelInfo());
        }
        return ctx;
    };

    gert::TilingContext *GetTilingCtx() const
    {
        return PtrCastTo<gert::TilingContext>(tilingCtx_);
    };

    const TilingCtxOutput *GetTilingResult() const
    {
        return &tilingOutput_;
    };

    const TilingCtxOutput *GetTilingResFromCache(const TilingResCache &res)
    {
        if (!res.IsValid()) {
            return nullptr;
        }
        *tilingOutput_.tilingKey_ = res.tilingKey_;
        *tilingOutput_.blockDim_ = res.blockDim_;
        *tilingOutput_.atomicCleanFlag_ = res.atomicCleanFlag_;
        *tilingOutput_.tilingCond_ = res.tilingCond_;
        *tilingOutput_.scheduleMode_ = res.scheduleMode_;
        *tilingOutput_.localMemorySize_ = res.localMemorySize_;
        OP_LOGD("Call GetTilingResFromCache, scheduleMode_ %u.", *tilingOutput_.scheduleMode_);
        OP_CHECK((memcpy_s(tilingOutput_.tilingData_->data_,
                     tilingOutput_.tilingData_->capacity_,
                     res.rawTilingData_,
                     res.rawTilingDataLen_) == EOK),
                 OP_LOGW("Failed to memcpy in tiling data use."),
                 return nullptr);
        tilingOutput_.tilingData_->data_size_ = res.rawTilingDataLen_;
        if (res.workspaceNum_ > 0) {
            tilingOutput_.workspaceSize_->SetSize(res.workspaceNum_);
            for (size_t i = 0; i < res.workspaceNum_; i++) {
                tilingOutput_.workspaceSize_->MutableData()[i] = res.workspaceSize_[i];
            }
        }
        tilingOutput_.inputNum_ = res.inputNum_;
        tilingOutput_.outputNum_ = res.outputNum_;
        return &tilingOutput_;
    }

private:
    TilingCtxOutput tilingOutput_{};
    TilingData *tilingData_{nullptr};

    void BuildTilingCtx();

private:
    constexpr static size_t tilingOutputNum_ = kOutputNum;
    KernelRunContext *tilingCtx_{nullptr};
    AsyncAnyValue *tilingCtxValue_{nullptr};
    AsyncAnyValue platformInfoValue_;
    std::unique_ptr<uint8_t[]> workspaceSizeVec_;
};

} //namespace internal
} //namespace op

#endif
