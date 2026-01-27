/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "op_transport.h"
#include "errno/error_code.h"
#include "msprof_dlog.h"

namespace analysis {
namespace dvvp {
namespace transport {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;

OpTransport::OpTransport()
{
    MSVP_MAKE_SHARED0(analyzer_, Dvvp::Acp::Analyze::OpAnalyzer, return);
    MSPROF_LOGI("OpTransport create successfully.");
}

OpTransport::~OpTransport()
{
}

int32_t OpTransport::SendBuffer(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (analyzer_ == nullptr) {
        MSPROF_LOGW("Analyzer is not init.");
        return PROFILING_FAILED;
    }

    analyzer_->OnOpData(fileChunkReq);
    return PROFILING_SUCCESS;
}

int32_t OpTransport::SendBuffer(CONST_VOID_PTR buffer, int32_t length)
{
    UNUSED(buffer);
    UNUSED(length);
    return PROFILING_SUCCESS;
}

int32_t OpTransport::CloseSession()
{
    return PROFILING_SUCCESS;
}

void OpTransport::WriteDone()
{
    if (analyzer_ == nullptr) {
        MSPROF_LOGW("Analyzer is not init.");
        return;
    }

    analyzer_->WaitOpDone();
}

void OpTransport::SetDevId(const std::string &deviceId)
{
    if (analyzer_ == nullptr) {
        MSPROF_LOGW("Analyzer is not init.");
        return;
    }

    analyzer_->InitAnalyzerByDeviceId(deviceId);
}

SHARED_PTR_ALIA<ITransport> OpTransportFactory::CreateOpTransport(const std::string &deviceId) const
{
    SHARED_PTR_ALIA<OpTransport> transport = nullptr;
    MSVP_MAKE_SHARED0(transport, OpTransport, return transport);
    transport->SetDevId(deviceId);
    return transport;
}
}  // namespace transport
}  // namespace dvvp
}  // namespace analysis
