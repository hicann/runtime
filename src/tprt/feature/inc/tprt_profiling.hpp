/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_TPRT_PROFILING_HPP
#define CCE_TPRT_PROFILING_HPP

#include <stdbool.h>
#include <stdint.h>
#include "tprt_sqe_cqe.h"
namespace cce {
namespace tprt {

class TprtProfiling {
public:
    explicit TprtProfiling();
    ~TprtProfiling();
    uint32_t TprtReportTask(uint64_t startTime, uint64_t endTime, uint32_t devId, TprtSqe_t headTask) const;

private:
    uint32_t RT_PROFILE_TYPE_DPU_INFO = 806U;
    uint32_t TS_TASK_TYPE_KERNEL_AICPU = 1U;
};
}
}
#endif

