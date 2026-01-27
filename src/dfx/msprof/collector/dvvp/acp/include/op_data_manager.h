/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef COLLECTOR_DVVP_ACP_OP_DATA_MANAGER_H
#define COLLECTOR_DVVP_ACP_OP_DATA_MANAGER_H

#include <vector>
#include "singleton/singleton.h"
#include "data_struct.h"

namespace Dvvp {
namespace Acp {
namespace Analyze {
using namespace Analysis::Dvvp::Analyze;

constexpr uint32_t KERNEL_EXECUTE_TIME = 5;

class OpDataManager : public analysis::dvvp::common::singleton::Singleton<OpDataManager> {
public:
    OpDataManager();
    ~OpDataManager() override;
    void UnInit();
    void AddAnalyzeCount();
    void AddMetrics(std::string &metrics);
    void AddSummaryInfo(KernelDetail &data);
    bool CheckSummaryInfoData(uint32_t replayTime) const;
    uint32_t GetAnalyzeCount() const;
    std::vector<std::string> GetMetricsInfo() const;
    std::vector<std::vector<KernelDetail>> GetSummaryInfo() const;

private:
    uint32_t analyzeCount_;
    std::vector<KernelDetail> replayInfo_;
    std::vector<std::vector<KernelDetail>> summaryInfo_;
    std::vector<std::string> metrics_;
};
}
}
}
#endif