/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DOMAIN_COLLECT_PARAM_PROFILE_PARAM_H
#define DOMAIN_COLLECT_PARAM_PROFILE_PARAM_H
#include "cstl/cstl_list.h"
#include "platform_feature.h"
#include "osal/osal.h"
#include "utils/utils.h"

#ifdef __cplusplus
extern "C" {
#endif

#define DEFAULT_PROFILING_INTERVAL_10MS 10
#define DEFAULT_FEATURES_BYTE_MAP 5
#define DEFAULT_MAX_BYTE_LENGTH 32U
#define STORAGE_MINIMUM_LENGTH 5

static const PlatformFeature featureList[] = {
    // 模拟platform当前支持的参数
    PLATFORM_TASK_ASCENDCL,
    PLATFORM_TASK_SWITCH,
    PLATFORM_TASK_AIC_METRICS,
    PLATFORM_TASK_AIV_METRICS,
    PLATFORM_TASK_TS_TIMELINE,
    PLATFORM_TASK_STARS_ACSQ,
    PLATFORM_TASK_TS_KEYPOINT,
    PLATFORM_TASK_AIC_HWTS,
    PLATFORM_TASK_TS_MEMCPY,
    PLATFORM_TASK_RUNTIME_TRACE,
    PLATFORM_TASK_RUNTIME_API
};

typedef struct {
    char aiCoreMetrics[32];
    PlatformFeature feature;
} MetricsMap;

static const PlatformFeature DefaultSwitchList[] = {
    // 设置默认开启的开关
    PLATFORM_TASK_ASCENDCL,
    PLATFORM_TASK_AIC_METRICS,
    PLATFORM_TASK_AIV_METRICS,
    PLATFORM_TASK_TS_TIMELINE,
    PLATFORM_TASK_TS_MEMCPY,
    PLATFORM_TASK_RUNTIME_TRACE,
    PLATFORM_TASK_TS_KEYPOINT,
    PLATFORM_TASK_STARS_ACSQ,
    PLATFORM_TASK_AIC_HWTS,
    PLATFORM_TASK_RUNTIME_API
};

typedef struct {
    uint32_t features[DEFAULT_FEATURES_BYTE_MAP]; // 31 * DEFAULT_FEATURES_BYTE_MAP
    uint32_t aicSamplingInterval;
    uint32_t aivSamplingInterval;
    int32_t hostPid;
    int32_t jobId;
    char storageLimit[16]; // 4294967295MB
    char taskTrace[4];
    char resultDir[DEFAULT_OUTPUT_MAX_LEGTH];
    char aiCoreMetrics[32];
    char aicEvents[PMU_EVENT_LENGTH];
    char aiCoreProfilingMode[16];
    char aiVectMetrics[32];
    char aivEvents[PMU_EVENT_LENGTH];
    char aiVectProfilingMode[16];
    char profLevel[8];
} ParmasList;

typedef struct {
    bool hostProfiling;   // 标识是否启用host侧的采集任务
    bool deviceProfiling; // 标识是否启用host侧的采集任务
    uint64_t dataTypeConfig;
    ParmasList config;
} ProfileParam;

bool IsEnable(ParmasList *param, PlatformFeature enumValue);
int32_t GenProfileParam(uint32_t dataType, OsalVoidPtr data, uint32_t dataLength, ProfileParam *param);
CHAR* Slice(const CHAR* str, uint64_t start, uint64_t end);
#ifdef __cplusplus
}
#endif
#endif