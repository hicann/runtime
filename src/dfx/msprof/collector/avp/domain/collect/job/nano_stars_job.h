/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DOMAIN_COLLECT_JOB_NANO_STARS_JOB_H
#define DOMAIN_COLLECT_JOB_NANO_STARS_JOB_H
#include "job/job_manager.h"
#include "collection_job.h"

#define NANO_PMU_EVENT_MAX_NUM 10
#define NANO_PMU_EVENT_MAX_LEN 65
typedef struct {
    uint32_t tag;                                  // 0-enable immediately, 1-enable delay
    uint32_t eventNum;                             // PMU count
    uint16_t event[NANO_PMU_EVENT_MAX_NUM];        // PMU value
} TagNanoStarsProfileConfig;

int32_t NanoJobInit(ICollectionJob *attr);
int32_t NanoJobProcess(ICollectionJob *attr);
int32_t NanoJobUninit(ICollectionJob *attr);
#endif