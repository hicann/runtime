/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OP_API_OP_API_COMMON_INC_OPDEV_THREAD_LOCAL_CONTEXT_H_
#define OP_API_OP_API_COMMON_INC_OPDEV_THREAD_LOCAL_CONTEXT_H_

#include <vector>
#include "opdev/common_types.h"
#include "opdev/op_config.h"
#include "opdev/op_dfx.h"
#include "opdev/op_executor.h"
#include "opdev/internal/block_pool.h"

namespace op {
namespace internal {

constexpr size_t RESERVE_SIZE_32 = 32;

struct ProfilingInfoId {

    ProfilingInfoId()
    {
        Init();
    }

    ProfilingInfoId(uint32_t tilingProfilingId, uint64_t kernelLauncherId, uint64_t itemId) : tilingProfilingId_(
        tilingProfilingId), kernelLauncherId_(kernelLauncherId), summaryItemId_(itemId) {}

    ProfilingInfoId(const ProfilingInfoId &rhs)
    {
        tilingProfilingId_ = rhs.tilingProfilingId_;
        kernelLauncherId_ = rhs.kernelLauncherId_;
        summaryItemId_ = rhs.summaryItemId_;
    }

    ProfilingInfoId &operator=(const ProfilingInfoId &rhs)
    {
        tilingProfilingId_ = rhs.tilingProfilingId_;
        kernelLauncherId_ = rhs.kernelLauncherId_;
        summaryItemId_ = rhs.summaryItemId_;
        return *this;
    }

    void Init()
    {
        tilingProfilingId_ = 0;
        kernelLauncherId_ = 0;
        summaryItemId_ = 0;
    }

    uint32_t tilingProfilingId_;
    uint64_t kernelLauncherId_;
    uint64_t summaryItemId_;
};

struct L2IOTensors {
    inline void Init()
    {
        inputTensors_.clear();
        outputTensors_.clear();
        workspaceTensors_.clear();
    }
    // std::vector does not expand stack size if no dfx, but FVector do.
    std::vector<const aclTensor *> inputTensors_;
    std::vector<const aclTensor *> outputTensors_;
    std::vector<const aclTensor *> workspaceTensors_;
};

struct ExceptionDumpInfo {
    std::string blockDim_;
    std::string devFunc_;
    std::string magic_;
    std::string tilingKey_;
    std::string tilingData_;
    void *rtsArgs_{nullptr};
    uint32_t rtsArgsSize_{0};
    bool IsEmpty() const
    {
        return (blockDim_ == "" && devFunc_ == "" && magic_ == "" && tilingKey_ == "" && tilingData_ == "");
    };
};

struct OpThreadLocalContext {
    OpThreadLocalContext()
    {
        Init();
    }
    void Init()
    {
        profilingInfoId_.Init();
        logInfo_.Init();
        l2IOTensors_.Init();
        kernelLauncherStartTime_ = 0;
        poolIndex_ = op::kInvalidHugeMemIndexId;
        cachedStorageList_.reserve(RESERVE_SIZE_32);
        cachedTensorList_.reserve(RESERVE_SIZE_32);
    }
    bool cacheOpInfoSwitch_{false};
    ProfilingInfoId profilingInfoId_;
    ProfilingInfoId memSetProfilingInfoId_;
    OpLogInfo logInfo_;
    OpConfigInfo opConfigInfo_;
    L2IOTensors l2IOTensors_;
    ExceptionDumpInfo exceptionDumpInfo_;
    uint64_t kernelLauncherStartTime_;
    int32_t poolIndex_;
    uint32_t blockDim_{0};
    std::vector<const aclStorage *> cachedStorageList_;
    size_t cachedStorageListSize_{0};
    std::vector<void *> cachedTensorList_;
    size_t cachedTensorListSize_{0};
    uint64_t hashKey_ = 0;
    uint8_t *cacheHashKey_ = nullptr;
    size_t cacheHashKeyLen_ = 0;
    bool usePTAHash_{false};
    bool cacheHasFull_{false};
    const char *cacheApi_{nullptr};
    aclOpExecutor *executor_{nullptr};
};

OpThreadLocalContext &GetThreadLocalContext();

} // namespace internal
} // namespace op
#endif
