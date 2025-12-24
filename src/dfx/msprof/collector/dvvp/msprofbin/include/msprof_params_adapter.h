/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_MSPROFBIN_PARAMS_ADAPTER_H
#define ANALYSIS_DVVP_MSPROFBIN_PARAMS_ADAPTER_H
#include "singleton/singleton.h"
#include "message/prof_params.h"
#include "proto/profiler.pb.h"
#include "utils/utils.h"
namespace Analysis {
namespace Dvvp {
namespace Msprof {
class MsprofParamsAdapter : public analysis::dvvp::common::singleton::Singleton<MsprofParamsAdapter> {
public:
    MsprofParamsAdapter();
    ~MsprofParamsAdapter() override;
    int32_t Init() const;
    void GenerateLlcEvents(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const;
    int32_t UpdateParams(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const;

private:
    std::string GenerateCapacityEvents() const;
    std::string GenerateBandwidthEvents() const;
    void GenerateLlcDefEvents(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const;

private:
    std::map<std::string, std::string> aicoreEvents_;
};
}
}
}

#endif