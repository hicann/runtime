/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "msprof_params_adapter.h"
#include <google/protobuf/util/json_util.h>
#include "errno/error_code.h"
#include "message/codec.h"
#include "message/prof_params.h"
#include "config/config.h"
#include "validation/param_validation.h"
#include "config_manager.h"
#include "platform/platform.h"
namespace Analysis {
namespace Dvvp {
namespace Msprof {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::message;
using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::Common::Platform;

MsprofParamsAdapter::MsprofParamsAdapter()
{
}

MsprofParamsAdapter::~MsprofParamsAdapter()
{
}

int32_t MsprofParamsAdapter::Init() const
{
    return PROFILING_SUCCESS;
}

std::string MsprofParamsAdapter::GenerateCapacityEvents() const
{
    std::vector<std::string> llcProfilingEvents;
    const int32_t maxLlcEvents = 8; // llc events list size
    for (int32_t i = 0; i < maxLlcEvents; i++) {
        std::string tempEvents;
        tempEvents.append("hisi_l3c0_1/dsid");
        tempEvents.append(std::to_string(i));
        tempEvents.append("/");
        llcProfilingEvents.push_back(tempEvents);
    }
    analysis::dvvp::common::utils::UtilsStringBuilder<std::string> builder;
    return builder.Join(llcProfilingEvents, ",");
}

std::string MsprofParamsAdapter::GenerateBandwidthEvents() const
{
    std::vector<std::string> llcProfilingEvents;
    llcProfilingEvents.push_back("hisi_l3c0_1/read_allocate/");
    llcProfilingEvents.push_back("hisi_l3c0_1/read_hit/");
    llcProfilingEvents.push_back("hisi_l3c0_1/read_noallocate/");
    llcProfilingEvents.push_back("hisi_l3c0_1/write_allocate/");
    llcProfilingEvents.push_back("hisi_l3c0_1/write_hit/");
    llcProfilingEvents.push_back("hisi_l3c0_1/write_noallocate/");
    analysis::dvvp::common::utils::UtilsStringBuilder<std::string> builder;
    return builder.Join(llcProfilingEvents, ",");
}

int32_t MsprofParamsAdapter::UpdateParams(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const
{
    if (params == nullptr) {
        return PROFILING_FAILED;
    }
    if (params->io_profiling.compare("on") == 0) {
        params->nicProfiling = "on";
        params->nicInterval = params->io_sampling_interval;
        params->roceProfiling = "on";
        params->roceInterval = params->io_sampling_interval;
        params->ubProfiling = "on";
        params->ubInterval = params->io_sampling_interval;
    }
    if (params->interconnection_profiling.compare("on") == 0) {
        params->pcieProfiling = "on";
        params->pcieInterval = params->interconnection_sampling_interval;
        params->hccsProfiling = "on";
        params->hccsInterval = params->interconnection_sampling_interval;
        params->ubProfiling = "on";
        params->ubInterval = params->interconnection_sampling_interval;
    }
    if (params->hardware_mem.compare("on") == 0) {
        const int32_t periodUs = params->hardware_mem_sampling_interval;
        const int32_t periodMs = (periodUs > DEFAULT_PROFILING_INTERVAL_10000US) ?
            (periodUs / US_CONVERT_MS) : DEFAULT_PROFILING_INTERVAL_10MS;
        params->msprof_llc_profiling = "on";
        params->llc_interval = periodMs;
        params->ddr_profiling = "on";
        params->ddr_interval = periodMs;
        params->hbmProfiling = "on";
        params->ddr_profiling_events = "read,write";
        params->hbm_profiling_events = "read,write";
        params->hbmInterval = periodMs;
        params->memProfiling = "on";
        params->memInterval = periodMs;
    }

    if (params->cpu_profiling.compare("on") == 0) {
        params->tsCpuProfiling = "on";
        params->aiCtrlCpuProfiling = "on";
        params->ai_ctrl_cpu_profiling_events = "0x8,0x11";
        params->ts_cpu_profiling_events = "0x8,0x11";
        if (Platform::instance()->CheckIfSupport(PLATFORM_SYS_DEVICE_AICPU_HSCB)) {
            params->hscb = "on";
        }
    }
    params->exportIterationId = DEFAULT_INTERATION_ID;
    params->exportModelId = DEFAULT_MODEL_ID;

    return PROFILING_SUCCESS;
}
}
}
}