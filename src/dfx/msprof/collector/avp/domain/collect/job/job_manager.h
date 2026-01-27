/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DOMAIN_COLLECT_JOB_JOB_MANAGER_H
#define DOMAIN_COLLECT_JOB_JOB_MANAGER_H
#include "collection_job.h"
#include "param/profile_param.h"
#include "hal/hal_prof.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    bool isStart;
    bool quit;
    uint32_t deviceId;
    const ProfileParam *params;
    ICollectionJob* collectionJobs[PROF_CHANNEL_MAX];
} JobManagerAttribute;
int32_t JobManagerStart(JobManagerAttribute *attr);
int32_t JobManagerStop(JobManagerAttribute *attr);

#ifdef __cplusplus
}
#endif
#endif