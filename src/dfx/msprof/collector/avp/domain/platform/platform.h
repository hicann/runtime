/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DOMAIN_PLARFORM_PLARFORM_H
#define DOMAIN_PLARFORM_PLARFORM_H

#include <stdint.h>
#include "platform_interface.h"
#ifdef __cplusplus
extern "C" {
#endif

#define FREQUENCY_KHZ_TO_MHZ 1000U
#define NANO_CHIP_TYPE 9U
typedef struct {
    bool ifSocSide;
    bool ifHelpHostSide;
    uint32_t platformInfo;
    uint64_t hostOscFreq;
    PlatformInterface *interface;
} PlatformAttribute;

PlatformType PlatformTypeConversion(void);
int32_t PlatformInitialize(uint32_t *repeatCount);
void PlatformFinalize(uint32_t *repeatCount);
uint32_t PlatformGetAicFreq(void);
uint32_t PlatformGetAivFreq(void);
uint32_t PlatformGetDevNum(void);
bool IsSupportSwitch(const CHAR *sw);
bool IsSupportFeature(const PlatformFeature feature);
bool IsSupportBit(const uint64_t dataConfig);
bool PlatformGetMetricsEvents(const CHAR *sw, CHAR *events, size_t eventsLen);
CHAR* PlatformGetDefaultMetrics(void);
uint64_t PlatformGetDefaultDevFreq(void);
float PlatformGetDevFreq(uint32_t deviceId);
uint64_t PlatformGetHostFreq(void);
const CHAR* PlatformGetVersionInfo(void);
bool PlatformHostFreqIsEnable(void);
#ifdef __cplusplus
}
#endif
#endif