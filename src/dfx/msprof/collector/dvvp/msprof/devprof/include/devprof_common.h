/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DEVPROF_COMMON_H
#define DEVPROF_COMMON_H

#include <cstdint>
#include "ascend_inpackage_hal.h"

#ifdef __PROF_LLT
#define STATIC
#else
#define STATIC static
#endif

#ifdef __cplusplus
extern "C" {
#endif
typedef struct prof_sample_start_para ProfSampleStartPara;
typedef struct prof_sample_para ProfSamplePara;
typedef struct prof_sample_stop_para ProfSampleStopPara;
typedef struct prof_sample_ops ProfSampleOps;
typedef struct prof_sample_register_para ProfSampleRegisterPara;


#ifdef __cplusplus
}
#endif

namespace Devprof {
constexpr int32_t REPORT_BUFF_CAPACITY = 16 * 1024;
constexpr size_t REPORT_BUFF_SIZE = 1024 * 1024;
constexpr uint32_t WAIT_DATA_TIME = 5U;
constexpr uint32_t WAIT_DRV_TIME = 1U;
int32_t ProfSendEvent(uint32_t devId, int32_t hostPid, const char *grpName);
}

#endif