/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DVVP_ACP_ANALYZE_OP_ANALYZER_BASE_H
#define DVVP_ACP_ANALYZE_OP_ANALYZER_BASE_H

#include <map>
#include "utils/utils.h"
#include "data_struct.h"
#include "platform/platform.h"
namespace Dvvp {
namespace Acp {
namespace Analyze {
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::Analyze;
class OpAnalyzerBase {
public:
    OpAnalyzerBase() : dataPtr_(nullptr), dataLen_(0), pmuNum_(0), frequency_(0)
    {
        pmuNum_ = Analysis::Dvvp::Common::Platform::Platform::instance()->GetMaxMonitorNumber();
    }
    ~OpAnalyzerBase() {}
    int32_t InitFrequency(uint32_t deviceId);

public:
    CONST_CHAR_PTR dataPtr_;
    uint32_t dataLen_;
    uint32_t pmuNum_;
    double frequency_;
    std::multimap<std::string, KernelDetail> logInfo_;
    std::multimap<std::string, KernelDetail> subTaskInfo_;
    std::multimap<std::string, KernelDetail> blockInfo_;
};
}
}
}

#endif
