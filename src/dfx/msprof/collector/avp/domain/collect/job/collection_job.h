/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DOMAIN_COLLECT_JOB_COLLECTION_JOB_H
#define DOMAIN_COLLECT_JOB_COLLECTION_JOB_H
#include <stdint.h>
#include "param/profile_param.h"
#include "osal/osal.h"

typedef struct ICollectionJob {
    uint32_t channelId;
    uint32_t devId;
    int32_t jobId;
    const ProfileParam *params;
    int32_t (*Init)(struct ICollectionJob*);
    int32_t (*Process)(struct ICollectionJob*);
    int32_t (*Uninit)(struct ICollectionJob*);
} ICollectionJob;

ICollectionJob* FactoryCreateJob(uint32_t channelId);
const char* GetResultFileByChannelId(uint32_t channelId);
#endif