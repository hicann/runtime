/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "nano_stars_job.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "errno/error_code.h"
#include "collection_job.h"
#include "logger/logger.h"
#include "securec.h"
#include "channel/channel_manager.h"
#include "ascend_hal.h"
#include "hal/hal_prof.h"


int32_t NanoJobInit(ICollectionJob* attr)
{
    MSPROF_LOGI("Nano job init");
    if (attr->params == NULL) {
        MSPROF_LOGE("Invalid parameter of collection job.");
        return PROFILING_FAILED;
    }
    if (attr->params->hostProfiling ||
        strcmp(attr->params->config.taskTrace, "off") == 0) {
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

static int32_t PackPmuParam(ICollectionJob* attr, TagNanoStarsProfileConfig* config)
{
    char str[NANO_PMU_EVENT_MAX_LEN];
    const ParmasList *paramConfig = &attr->params->config;
    errno_t err = strncpy_s(str, sizeof(str) / sizeof(str[0]), paramConfig->aicEvents, strlen(paramConfig->aicEvents));
    if (err != EOK) {
        MSPROF_LOGE("string copy failed, err: %d", err);
        return PROFILING_FAILED;
    }
    char *context = NULL;
    char *token = Strtok(str, ",", &context);
    PROF_CHK_EXPR_ACTION(errno == ERANGE, return PROFILING_FAILED,
        "The errno is out of the range that can be represented after strtok.");
    if (token == NULL) {
        MSPROF_LOGE("PackPmuParam strtok error, aicEvents:%s", str);
        return PROFILING_FAILED;
    }
    int32_t eventNum = 0;
    while (token != NULL && eventNum < NANO_PMU_EVENT_MAX_NUM) {
        char *endptr = NULL;
        errno = 0;
        int64_t num = strtol(token, &endptr, 16);
        PROF_CHK_EXPR_ACTION(errno == ERANGE || *endptr != '\0', return PROFILING_FAILED,
            "Invalid hexadecimal character string, errno: %d.", errno);

        PROF_CHK_EXPR_ACTION(num < 0 || num > UINT16_MAX, return PROFILING_FAILED,
            "Conversion result is out of the range of the uint16_t type");
        uint16_t hexNum = (uint16_t)num;
        config->event[eventNum] = hexNum;
        token = Strtok(NULL, ",", &context);
        PROF_CHK_EXPR_ACTION(errno == ERANGE, return PROFILING_FAILED,
            "The value of errno %d is abnormal after method Strtok is executed in cycling.", errno);
        eventNum++;
    }
    config->eventNum = (uint32_t)eventNum;
    MSPROF_LOGI("PackPmuParam, event_num=%u, events=%s",
        config->eventNum, paramConfig->aicEvents);
    return PROFILING_SUCCESS;
}

static int32_t ChannelStart(ICollectionJob* attr, uint32_t devId, uint32_t channelId)
{
    MSPROF_LOGI("Begin to start channel profiling, profDeviceId=%u, profChannel=%u", devId, channelId);
    TagNanoStarsProfileConfig config = {
        .tag = 0,
        .eventNum = 0,
        .event = {0}
    };
    int32_t ret = PackPmuParam(attr, &config);
    if (ret == PROFILING_SUCCESS) {
        struct prof_start_para profStartPara;
        profStartPara.channel_type = PROF_TS_TYPE;
        profStartPara.sample_period = 0;
        profStartPara.real_time = PROF_REAL;
        profStartPara.user_data = &config;
        profStartPara.user_data_size = (uint32_t)sizeof(TagNanoStarsProfileConfig);
        ret = HalProfChannelStart(devId, channelId, &profStartPara);
    }
    return ret;
}

int32_t NanoJobProcess(ICollectionJob* attr)
{
    MSPROF_LOGI("Nano job process");
    if (attr->params == NULL) {
        MSPROF_LOGE("Invalid parameter of collection job.");
        return PROFILING_FAILED;
    }

    (void)ChannelMgrCreateReader(attr->devId, attr->channelId);
    return ChannelStart(attr, attr->devId, attr->channelId);
}

int32_t NanoJobUninit(ICollectionJob* attr)
{
    MSPROF_LOGI("Nano job uninit");
    if (attr->params == NULL) {
        MSPROF_LOGE("Invalid parameter of collection job.");
        return PROFILING_FAILED;
    }
    int32_t ret = HalProfChannelStop(attr->devId, attr->channelId);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Nano stars job uninit, prof_stop failed.");
    }
    (void)ChannelMgrDestroyReader(attr->devId, attr->channelId);
    MSPROF_LOGI("stop profiling success, device id: %u, channel id: %u",
        attr->devId, attr->channelId);
    return ret;
}
