/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __ACL_OP_CACHE_INTERNAL_H__
#define __ACL_OP_CACHE_INTERNAL_H__

#include <stdint.h>
#include <type_traits>
#include <mutex>

#include "toolchain/aprof_pub.h"
#include "aclnn/acl_meta.h"
#include "opdev/op_cache.h"
#include "opdev/internal/thread_local_context.h"

namespace op {
namespace internal {

struct TaskInfo {
    MsprofGeTaskType type;
    uint32_t ration;
    OpExecMode execMode{OpExecMode::OP_EXEC_MODE_DEFAULT};
};

class OpExecCacheDfx {
public:
    void SetExceptionDumpInfo(const ExceptionDumpInfo &info)
    {
        exceptionDumpInfo_.push_back(info);
    }
    ExceptionDumpInfo GetExceptionDumpInfo(int32_t index) const
    {
        return exceptionDumpInfo_[index];
    }
    void SetProfilingInfoId(const op::internal::ProfilingInfoId &id)
    {
        profilingInfoId_.push_back(id);
    }
    op::internal::ProfilingInfoId GetProfilingInfoId(int32_t index) const
    {
        return profilingInfoId_[index];
    }
    void SetTaskInfo(const TaskInfo &taskInfo);
    MsprofGeTaskType GetTaskType(int32_t index) const
    {
        return taskInfo_[index].type;
    }
    TaskInfo GetTaskInfo(int32_t index) const
    {
        return taskInfo_[index];
    }

private:
    std::vector<TaskInfo> taskInfo_;
    std::vector<op::internal::ProfilingInfoId> profilingInfoId_;
    std::vector<ExceptionDumpInfo> exceptionDumpInfo_;
};

class OpExecCacheWrap {
public:
    OpExecCacheWrap()
    {}
    explicit OpExecCacheWrap(OpExecCache *cache);
    ~OpExecCacheWrap();

    aclnnStatus Run(void *workspaceAddr, const aclrtStream stream);
    std::string ReportAddr();

    uint64_t magicNumber_{K_CACHE_WRAP_MAGIC_NUMBER};
    OpExecCache *opExecCache_;
    std::vector<void *> cachedTensorList_;
    op::internal::OpLogInfo opLogInfo_;
    int32_t hugeMemPoolIndex_{op::kInvalidHugeMemIndexId};
    void *opExecCacheManager_{nullptr};
};

aclnnStatus DoReportAdditionInfo(
    void *infoLists, const TaskInfo &taskInfo, const op::internal::ProfilingInfoId &profilingInfoId);
void DoExceptionDump(
    void *infoLists, void *workspaceAddr, const std::vector<void *> &tensors, const ExceptionDumpInfo &dumpInfo);

class OpCacheContext {
public:
    void SetOpCache(OpExecCache *cache);

    OpExecCache *GetOpCache();

private:
    OpExecCache *cache_{nullptr};
};

class OpCacheGuard {
public:
    OpCacheGuard() = default;
    ~OpCacheGuard();
};

OpCacheContext &GetOpCacheContext();
OpExecCacheWrap *CreateCacheWrap(OpExecCache *opExecCache);
void *GetOpExecCacheManager();
void ReleaseOpExecCacheManager(void *ptr);
void DisableOpCacheCount();
void ReinitOpCacheManager();
} // namespace internal
} // namespace op

#endif