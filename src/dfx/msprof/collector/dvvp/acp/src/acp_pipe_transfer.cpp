/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "acp_pipe_transfer.h"
#include "utils/utils.h"
#include "errno/error_code.h"
#include "osal.h"
#include "mmpa_api.h"

namespace Collector {
namespace Dvvp {
namespace Acp {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;

int32_t AcpPipeWrite(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params, int32_t &fdPipe)
{
    AcpPipeParams acpPipeParams;
    int32_t ret = strcpy_s(acpPipeParams.aicCoreMetrics,
        AIC_CORE_METRICS_MAX_LEN, params->ai_core_metrics.c_str());
    FUNRET_CHECK_EXPR_ACTION(ret != EOK, return PROFILING_FAILED, "ai_core_metrics copy failed");
    ret = strcpy_s(acpPipeParams.resultDir, RESULT_DIR_MAX_LEN, params->result_dir.c_str());
    FUNRET_CHECK_EXPR_ACTION(ret != EOK, return PROFILING_FAILED, "result_dir copy failed");
    ret = strcpy_s(acpPipeParams.aicScale, AIC_SCALE_MAX_LEN, params->aicScale.c_str());
    FUNRET_CHECK_EXPR_ACTION(ret != EOK, return PROFILING_FAILED, "aicScale copy failed");
    ret = strcpy_s(acpPipeParams.instrProfiling, ON_OFF_MAX_LEN, params->instrProfiling.c_str());
    FUNRET_CHECK_EXPR_ACTION(ret != EOK, return PROFILING_FAILED, "instrProfiling copy failed");
    ret = strcpy_s(acpPipeParams.pcSampling, ON_OFF_MAX_LEN, params->pcSampling.c_str());
    FUNRET_CHECK_EXPR_ACTION(ret != EOK, return PROFILING_FAILED, "PcSampling copy failed");
    int32_t fd[2] = {-1, -1};
    ret = pipe(fd);
    if (ret != EOK) {
        MSPROF_LOGE("Pipe open failed.");
        return PROFILING_FAILED;
    }
    ret = write(fd[1], &acpPipeParams, sizeof(AcpPipeParams));
    if (ret != sizeof(AcpPipeParams)) {
        MSPROF_LOGE("Pipe write AcpPipeParams failed.");
        return PROFILING_FAILED;
    }
    ret = close(fd[1]);
    if (ret != EOK) {
        MSPROF_LOGE("Pipe close failed.");
        return PROFILING_FAILED;
    }
    fdPipe = fd[0];
    return PROFILING_SUCCESS;
}

SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> AcpPipeRead()
{
    CHAR* envVal = nullptr;
    MM_SYS_GET_ENV(MM_ENV_ACP_PIPE_FD, envVal);
    std::string fdStr;
    if (envVal != nullptr) {
        fdStr = envVal;
    } else {
        MSPROF_LOGE("Get ACP_PIPE_FD failed.");
        return nullptr;
    }
    int32_t fdPipe = -1;
    if (!Utils::StrToInt32(fdPipe, fdStr)) {
        MSPROF_LOGE("fdPipe '%d' is invalid", fdPipe);
        return nullptr;
    }
    signal(SIGPIPE, SIG_IGN);
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params;
    MSVP_MAKE_SHARED0(params, analysis::dvvp::message::ProfileParams, return nullptr);
    AcpPipeParams acpPipeParams;
    int32_t ret = read(fdPipe, &acpPipeParams, sizeof(acpPipeParams));
    if (ret != sizeof(AcpPipeParams)) {
        MSPROF_LOGE("Pipe read AcpPipeParams failed.");
        return nullptr;
    }
    params->ai_core_metrics = acpPipeParams.aicCoreMetrics;
    params->result_dir = acpPipeParams.resultDir;
    params->aicScale = acpPipeParams.aicScale;
    params->instrProfiling = acpPipeParams.instrProfiling;
    params->pcSampling = acpPipeParams.pcSampling;
    ret = close(fdPipe);
    if (ret != EOK) {
        MSPROF_LOGE("Pipe close failed.");
        return nullptr;
    }
    fdPipe = -1;
    return params;
}
}
}
}