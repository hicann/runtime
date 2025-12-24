/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include<functional>
#include "utils/utils.h"
#include "error_code.h"
#include "adprof_collector_proxy.h"

using namespace analysis::dvvp::common::error;

AdprofCollectorProxy::AdprofCollectorProxy()
{
}

AdprofCollectorProxy::~AdprofCollectorProxy()
{
}

int32_t AdprofCollectorProxy::BindFunction(
    std::function<int32_t(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk>)> reportFunc = nullptr,
    std::function<bool()> adprofStartedFunc = nullptr)
{
    reportFunctionPointer = reportFunc;
    adprofStartedFunctionPointer = adprofStartedFunc;
    return PROFILING_SUCCESS;
}

int32_t AdprofCollectorProxy::Report(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk)
{
    if (reportFunctionPointer == nullptr) {
        return PROFILING_FAILED;
    }
    return reportFunctionPointer(fileChunk);
}

bool AdprofCollectorProxy::AdprofStarted()
{
    if (adprofStartedFunctionPointer == nullptr) {
        return false;
    }
    return adprofStartedFunctionPointer();
}