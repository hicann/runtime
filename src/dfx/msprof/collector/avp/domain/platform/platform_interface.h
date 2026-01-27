/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DOMAIN_PLARFORM_PLARFORM_INTERFACE_H
#define DOMAIN_PLARFORM_PLARFORM_INTERFACE_H
#include <stdbool.h>
#include "osal/osal.h"
#include "platform_feature.h"
#include "prof_data_config.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef enum {
    CHIP_MINI                      = 0,
    CHIP_CLOUD                     = 1,
    CHIP_MDC                       = 2,
    CHIP_DC                        = 4,
    CHIP_CLOUD_V2                  = 5,
    CHIP_MINI_V3                   = 7,
    CHIP_TINY_V1                   = 8,
    CHIP_NANO_V1                   = 9,
    CHIP_MDC_MINI_V3               = 10, // 11 mdc
    CHIP_MDC_V2                    = 11, // 51 lite
    CHIP_END
} PlatformType;

typedef struct PlatformInterface {
    bool (*FeatureIsSupport)(const PlatformFeature feature);
    bool (*GetPmuEvents)(const PlatformFeature feature, CHAR *events, size_t eventsLen);
    CHAR* (*GetDefaultMetrics)(void);
    uint32_t (*GetAicFreq)();
    uint32_t (*GetAivFreq)();
    uint32_t (*GetDevNum)();
    uint64_t (*GetDefaultFreq)();
} PlatformInterface;

typedef struct {
    PlatformFeature pmuType;
    char pmuEvents[PMU_EVENT_LENGTH];
} PlatformMetrics;

typedef struct {
    PlatformFeature feature;
    char sw[SWITCH_LENGTH];
} PlatformSwitch;

typedef struct {
    PlatformFeature feature;
    uint64_t bitSwitch;
} PlatformBitMap;

typedef void (*CreatePlatformFunc)(PlatformInterface *);
PlatformFeature TransformFeature(const CHAR *sw);
bool GetCommonPmuEvents(const PlatformFeature feature, CHAR *events, size_t eventsLen);
bool CheckBitFeature(const uint64_t dataConfig, PlatformInterface *interface);

#ifdef __cplusplus
}
#endif
#endif