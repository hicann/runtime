/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OPERATOR_KERNEL_MODEL_REPORT_STATUS_H
#define OPERATOR_KERNEL_MODEL_REPORT_STATUS_H

#include <vector>
#include "operator_kernel.h"


namespace AicpuSchedule {
class OperatorKernelModelReportStatus : public OperatorKernel {
public:
    OperatorKernelModelReportStatus() = default;
    ~OperatorKernelModelReportStatus() = default;
    int32_t Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext) override;
private:
    using FillFunc = std::function<int32_t(void *const buffer, const size_t size)>;
    int32_t ModelReportStatus(const uint32_t modelUuid, const QueueAttrs &schedOutputQueue,
                              const std::vector<QueueAttrs> &inputQueues, const RunContext &taskContext) const;
    int32_t EnqueueStatus(const uint32_t deviceId, const uint32_t queueId, const size_t reqSize,
                          const FillFunc &fillFunc) const;
};
}  // namespace AicpuSchedule
#endif  // OPERATOR_KERNEL_MODEL_REPORT_STATUS_H
