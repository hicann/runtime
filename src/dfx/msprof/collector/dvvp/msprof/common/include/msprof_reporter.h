/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_PROFILER_MSPROF_REPORTER_H
#define ANALYSIS_DVVP_PROFILER_MSPROF_REPORTER_H

#include "acl/acl_base.h"
#include "data_dumper.h"
#include "utils/utils.h"
#include "prof_api.h"

namespace Msprof {
namespace Engine {
using namespace analysis::dvvp::common::utils;

class MsprofReporter {
public:
    MsprofReporter();
    explicit MsprofReporter(const std::string module);
    ~MsprofReporter();

public:
    int32_t HandleReportRequest(uint32_t type, VOID_PTR data, uint32_t len);
    void ForceFlush();
    int32_t SendData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk);
    int32_t StartReporter();
    int32_t StopReporter();

public:
    static void InitReporters();

public:
    static std::map<uint32_t, MsprofReporter> reporters_;

private:
    int32_t ReportData(CONST_VOID_PTR data, uint32_t len) const;
    int32_t FlushData() const;
    int32_t GetDataMaxLen(VOID_PTR data, uint32_t len) const;
    int32_t GetHashId(VOID_PTR data, uint32_t len) const;

private:
    std::string module_;
    SHARED_PTR_ALIA<Msprof::Engine::DataDumper> reporter_{nullptr};
};

void FlushAllModule();
void FlushModule();
int32_t SendAiCpuData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk);
}  // namespace Engine
}  // namespace Msprof

#endif
