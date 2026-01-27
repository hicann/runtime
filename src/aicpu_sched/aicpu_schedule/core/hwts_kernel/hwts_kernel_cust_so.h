/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef HWTS_KERNEL_CUST_SO_H
#define HWTS_KERNEL_CUST_SO_H

#include <mutex>
#include <thread>
#include <set>
#include <vector>

#include "hwts_kernel.h"

namespace AicpuSchedule {
class CustOperationCommon {
public:
    CustOperationCommon() = default;
    virtual ~CustOperationCommon() = default;
    int32_t SendCtrlCpuMsg(int32_t custAicpuPid, const uint32_t eventType, char_t *msg, const uint32_t msgLen) const;
    int32_t StartCustProcess(const uint32_t loadLibNum, const char_t *const loadLibName[]) const;
    int32_t GetGroupNameInfo(std::vector<std::string> &groupNameList, std::string &groupNameStr) const;
    int32_t AicpuNotifyLoadSoEventToCustCtrlCpu(const uint32_t deviceId, const uint32_t hostPid, const uint32_t vfId,
                                                const int32_t custAicpuPid, const uint32_t loadLibNum,
                                                const char_t * const loadLibName[]) const;
};

class LoadOpFromBuffTsKernel : public HwTsKernelHandler, public CustOperationCommon {
public:
    LoadOpFromBuffTsKernel() = default;
    ~LoadOpFromBuffTsKernel() override = default;
    int32_t Compute(const aicpu::HwtsTsKernel &tsKernelInfo) override;
private:
    static std::mutex mutexForStartCustProcess_;
    static std::set<std::string> alreadyLoadSoName_;
};

class BatchLoadSoFromBuffTsKernel : public HwTsKernelHandler, public CustOperationCommon {
public:
    BatchLoadSoFromBuffTsKernel() = default;
    ~BatchLoadSoFromBuffTsKernel() override = default;
    int32_t Compute(const aicpu::HwtsTsKernel &tsKernelInfo) override;

private:
    int32_t TryToStartCustProcess(const std::unique_ptr<const char_t *[]> &soNames, const uint32_t soNum) const;
};

class DeleteCustOpTsKernel : public HwTsKernelHandler {
public:
    DeleteCustOpTsKernel() = default;
    ~DeleteCustOpTsKernel() override = default;
    int32_t Compute(const aicpu::HwtsTsKernel &tsKernelInfo) override;
};
}  // namespace AicpuSchedule
#endif  // HWTS_KERNEL_CUST_SO_H
