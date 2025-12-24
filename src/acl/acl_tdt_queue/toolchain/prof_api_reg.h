/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ACL_PROF_API_REG_H_
#define ACL_PROF_API_REG_H_

#include "acl/acl_base.h"
#include "aprof_pub.h"

#define TDT_QUEUE_PROF_TYPE_START_OFFSET 0x008000U

namespace acl {
    aclError AclTdtQueueProfCtrlHandle(uint32_t dataType, void *data, uint32_t dataLen);

    enum AclTdtQueueProfType {
        // start with 0x038000U
        TdtQueueProfTypeStart = MSPROF_REPORT_ACL_RUNTIME_BASE_TYPE + TDT_QUEUE_PROF_TYPE_START_OFFSET,
        AcltdtEnqueue,
        AcltdtDequeue,
        AcltdtEnqueueData,
        AcltdtDequeueData,
        // this is the end, can not add after TdtQueueProfTypeEnd
        TdtQueueProfTypeEnd
    };

    class AclTdtQueueProfilingReporter {
    public:
        explicit AclTdtQueueProfilingReporter(const AclTdtQueueProfType apiId);
        virtual ~AclTdtQueueProfilingReporter() noexcept;
    private:
        uint64_t startTime_ = 0UL;
        const AclTdtQueueProfType aclApi_;
    };
}  // namespace acl

#define ACL_PROFILING_REG(apiId) \
    const acl::AclTdtQueueProfilingReporter profilingReporter(apiId)
#endif 
