/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_reporter.h"
#include "mmpa/mmpa_api.h"


namespace {
bool IsDumpToStdEnabled() {
   const char *profilingToStdOut = nullptr;
   MM_SYS_GET_ENV(MM_ENV_GE_PROFILING_TO_STD_OUT, profilingToStdOut);
   return profilingToStdOut != nullptr;
}
}

namespace acl {
bool AclProfilingReporter::profRun = false;
AclProfilingReporter::AclProfilingReporter(const AclProfType apiId) : aclApi_(apiId)
{
    if (profRun && (!IsDumpToStdEnabled())) {
        startTime_ = MsprofSysCycleTime();
    }
}


AclProfilingReporter::~AclProfilingReporter() noexcept
{
    if (profRun && (!IsDumpToStdEnabled()) && (startTime_ != 0UL)) {
        // 1000 ^ 3 converts second to nanosecond
        const uint64_t endTime = MsprofSysCycleTime();
        MsprofApi api{};
        api.beginTime = startTime_;
        api.endTime = endTime;
        thread_local static auto tid = mmGetTid();
        api.threadId = static_cast<uint32_t>(tid);
        api.level = MSPROF_REPORT_ACL_LEVEL;
        api.type = static_cast<uint32_t>(aclApi_);
        (void)MsprofReportApi(true, &api);
    }
}
}  // namespace acl
