/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ACP_PIPE_TRANSFER_H
#define ACP_PIPE_TRANSFER_H

#include "message/prof_params.h"

namespace Collector {
namespace Dvvp {
namespace Acp {
const int32_t ON_OFF_MAX_LEN = 4;
const int32_t AIC_CORE_METRICS_MAX_LEN = 256;
const int32_t RESULT_DIR_MAX_LEN = 512;
const int32_t AIC_SCALE_MAX_LEN = 10;
struct AcpPipeParams {
    char aicCoreMetrics[AIC_CORE_METRICS_MAX_LEN];
    char resultDir[RESULT_DIR_MAX_LEN];
    char aicScale[AIC_SCALE_MAX_LEN];
    char instrProfiling[ON_OFF_MAX_LEN];
    char pcSampling[ON_OFF_MAX_LEN];
};
int32_t AcpPipeWrite(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params, int32_t &fdPipe);
SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> AcpPipeRead();
}
}
}
#endif