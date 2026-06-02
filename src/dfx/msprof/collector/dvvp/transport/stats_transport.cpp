/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stats_transport.h"
#include "errno/error_code.h"
#include "msprof_dlog.h"

namespace analysis {
namespace dvvp {
namespace transport {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;

StatsTransport::StatsTransport(const std::string &path)
{
    MSVP_MAKE_SHARED1(analyzer_, Analysis::Dvvp::Analyze::StatsAnalyzer, path, return);
    MSPROF_LOGI("StatsTransport create successfully.");
}

StatsTransport::~StatsTransport()
{
}

int32_t StatsTransport::SendBuffer(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (analyzer_ == nullptr) {
        MSPROF_LOGW("Analyzer is not init.");
        return PROFILING_FAILED;
    }

    analyzer_->OnApiData(fileChunkReq);
    return PROFILING_SUCCESS;
}

int32_t StatsTransport::SendBuffer(CONST_VOID_PTR buffer, int32_t length)
{
    UNUSED(buffer);
    UNUSED(length);
    return PROFILING_SUCCESS;
}

int32_t StatsTransport::CloseSession()
{
    MSPROF_LOGI("StatsTransport CloseSession");
    return PROFILING_SUCCESS;
}

void StatsTransport::WriteDone()
{
    MSPROF_LOGI("StatsTransport WriteDone");
}

SHARED_PTR_ALIA<ITransport> StatsTransportFactory::CreateStatsTransport(const std::string &path) const
{
    SHARED_PTR_ALIA<StatsTransport> transport = nullptr;
    MSVP_MAKE_SHARED1(transport, StatsTransport, path, return transport);
    return transport;
}
}  // namespace transport
}  // namespace dvvp
}  // namespace analysis
