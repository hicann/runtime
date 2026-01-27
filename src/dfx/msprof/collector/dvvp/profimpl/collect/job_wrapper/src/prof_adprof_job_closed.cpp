/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "prof_adprof_job.h"
#include "collection_job.h"
#include "platform/platform.h"
#include "osal.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Platform;
const std::string LIBTSD_LIB_PATH = "libtsdclient.so";

int32_t ProfAdprofJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    CHECK_JOB_COMMON_PARAM_RET(cfg, return PROFILING_FAILED);

    if (!cfg->comParams->params->app.empty() && 
        cfg->comParams->params->hscb != MSVP_PROF_ON) {
        MSPROF_LOGI("App mode not collect system level data");
        return PROFILING_FAILED;
    }

    if (cfg->comParams->params->hostProfiling) {
        MSPROF_LOGI("Host profiling");
        return PROFILING_FAILED;
    }

    if (cfg->comParams->params->cpu_profiling != MSVP_PROF_ON && cfg->comParams->params->sys_profiling != MSVP_PROF_ON &&
        cfg->comParams->params->pid_profiling != MSVP_PROF_ON) {
        MSPROF_LOGI("Switch cpu_profiling & sys_profiling & pid_profiling are off");
        return PROFILING_FAILED;
    }

    if (!Platform::instance()->CheckIfSupportAdprof(static_cast<uint32_t>(cfg->comParams->devId)) ||
        (Platform::instance()->GetPlatformType() == CHIP_MINI_V3) ||
        (Platform::instance()->GetPlatformType() == CHIP_MDC) ||
        (Platform::instance()->GetPlatformType() == CHIP_MDC_LITE) ||
        (Platform::instance()->GetPlatformType() == CHIP_MDC_MINI_V3)) {
        MSPROF_LOGI("Drv version is not supported adprof");
        return PROFILING_FAILED;
    }

    drvError_t err = drvDeviceGetPhyIdByIndex(static_cast<uint32_t>(cfg->comParams->devId), &phyId_);
    if (err != DRV_ERROR_NONE) {
        if (err == DRV_ERROR_NOT_SUPPORT) {
            MSPROF_LOGW("[ProfAdprofJob]Driver not support drvDeviceGetPhyIdByIndex interface.");
            phyId_ = static_cast<uint32_t>(cfg->comParams->devId);
        } else {
            MSPROF_LOGE("[ProfAdprofJob]Failed to get phyId by devId: %u, err: %d.",
                static_cast<uint32_t>(cfg->comParams->devId), err);
            return PROFILING_FAILED;
        }
    }

    MSPROF_LOGI("[ProfAdprofJob]Adprof get phyId: %u by devId: %u.", phyId_,
        static_cast<uint32_t>(cfg->comParams->devId));
    collectionJobCfg_ = cfg;
    int32_t ret = InitAdprof();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to InitAdprof");
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}
}
}
}