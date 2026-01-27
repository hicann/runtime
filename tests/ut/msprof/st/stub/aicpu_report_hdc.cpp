/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpu_report_hdc.h"
#include <string>
#include <cstdint>
#include "error_code.h"
#include "prof_api.h"
#include "utils.h"
#include "rpc_dumper.h"
#include "message/codec.h"
#include "aicpu_report_hdc.h"

using namespace analysis::dvvp::common::error;
using namespace Msprof::Engine;

AicpuReportHdc::AicpuReportHdc()
{
}
AicpuReportHdc::~AicpuReportHdc()
{
    UnInit();
}

int32_t AicpuReportHdc::Init(std::string &moduleName)
{
    std::lock_guard<std::mutex> lk(mtx_);
    if (started_) {
        return PROFILING_SUCCESS;
    }
    SHARED_PTR_ALIA<RpcDumper> reporter;
    MSVP_MAKE_SHARED1(reporter, RpcDumper, moduleName, return PROFILING_FAILED);
    reporter_ = reporter;
    int32_t ret = reporter_->Start();
    if (ret != PROFILING_SUCCESS) {
        reporter_.reset();
        MSPROF_LOGW("Unable start reporter in aicpu.");
        return ret;
    }
    started_ = true;
    return PROFILING_SUCCESS;
}

int32_t AicpuReportHdc::Report(CONST_REPORT_DATA_PTR rData) const
{
    if (reporter_ == nullptr) {
        MSPROF_LOGE("Reporter is null.");
        return PROFILING_FAILED;
    }
    return reporter_->Report(rData);
}

int32_t AicpuReportHdc::UnInit()
{
    std::lock_guard<std::mutex> lk(mtx_);
    if (reporter_ != nullptr) {
        if (reporter_->Stop() != PROFILING_SUCCESS) {
            MSPROF_LOGE("Aicpu hdc reporter stop failed.");
        }
        reporter_.reset();
        started_ = false;
    }
    return PROFILING_SUCCESS;
}
