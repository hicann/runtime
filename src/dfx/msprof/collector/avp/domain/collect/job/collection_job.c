/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "collection_job.h"
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include "nano_stars_job.h"
#include "errno/error_code.h"
#include "hal/hal_prof.h"
#include "logger/logger.h"
#include "osal/osal_mem.h"

static const char* g_channelResultFile[PROF_CHANNEL_MAX] = {NULL};

ICollectionJob* FactoryCreateJob(uint32_t channelId)
{
    ICollectionJob* collectionJob = NULL;
    switch (channelId) {
        case PROF_CHANNEL_STARS_NANO_PROFILE:
            collectionJob = (ICollectionJob*)OsalMalloc(sizeof(ICollectionJob));
            if (collectionJob == NULL) {
                MSPROF_LOGE("OsalMalloc failed.");
                return collectionJob;
            }
            collectionJob->channelId = (uint32_t)PROF_CHANNEL_STARS_NANO_PROFILE;
            collectionJob->params = NULL;
            collectionJob->Init = NanoJobInit;
            collectionJob->Process = NanoJobProcess;
            collectionJob->Uninit = NanoJobUninit;
            g_channelResultFile[PROF_CHANNEL_STARS_NANO_PROFILE] = "nano_stars_profile.data";
            break;
        case PROF_CHANNEL_AI_CORE:
            g_channelResultFile[PROF_CHANNEL_AI_CORE] = "aicore.data";
            break;
        default:
            MSPROF_LOGW("Channel not support: %u.", channelId);
            break;
    }
    return collectionJob;
}

const char* GetResultFileByChannelId(uint32_t channelId)
{
    return g_channelResultFile[channelId];
}