/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef BASIC_HAL_HAL_DSMI_H
#define BASIC_HAL_HAL_DSMI_H
#include "osal/osal.h"

#ifdef __cplusplus
extern "C" {
#endif

#define MAX_CHIP_VERSION (8)
#define MAX_DEVICE_NUMS (64)
#define MAX_INFO_MESSAGE_LEN 32U
typedef enum {
    SYSTEM_SYS_COUNT = 0,
    SYSTEM_HOST_OSC_FREQUE,
    SYSTEM_DEV_OSC_FREQUE,
    SYSTEM_VERSION,
    SYSTEM_ENV,
    CCPU_ID,
    CCPU_CORE_NUM,
    CCPU_ENDIAN,
    AICPU_ID,
    AICPU_CORE_NUM,
    AICPU_OCCUPY,
    TSCPU_CORE_NUM,
    AICORE_ID,
    AICORE_CORE_NUM,
    AICORE_FREQUE,
    VECTOR_CORE_CORE_NUM,
    VECTOR_CORE_FREQUE,
    MAX_DEVICE_INFO_TYPE,
} DeviceInfoType;

uint32_t HalGetApiVersion(void);
int32_t HalGetPlatformInfo(uint32_t* platformInfo);
uint32_t HalGetDeviceNumber(void);
uint32_t HalGetDeviceIds(uint32_t devNum, uint32_t *devIds, uint32_t devIdsLen);
int32_t HalGetDeviceInfo(DeviceInfoType type, uint32_t deviceId, int64_t *value);
uint64_t HalGetHostFreq(void);
uint64_t HalGetDeviceFreq(uint32_t deviceId);
int32_t HalGetDeviceTime(uint32_t deviceId, uint64_t *cntvct);
uint32_t HalGetChipVersion(void);
int64_t HalGetEnvType(uint32_t deviceId);
int64_t HalGetCtrlCpuId(uint32_t deviceId);
int64_t HalGetCtrlCpuCoreNum(uint32_t deviceId);
int64_t HalGetCtrlCpuEndianLittle(uint32_t deviceId);
int64_t HalGetAiCpuCoreNum(uint32_t deviceId);
int64_t HalGetAiCpuCoreId(uint32_t deviceId);
int64_t HalGetAiCpuOccupyBitmap(uint32_t deviceId);
int64_t HalGetTsCpuCoreNum(uint32_t deviceId);
int64_t HalGetAiCoreId(uint32_t deviceId);
int64_t HalGetAiCoreNum(uint32_t deviceId);
int64_t HalGetAiVectorCoreNum(uint32_t deviceId);
int64_t HalGetAicFrq(uint32_t deviceId);
int64_t HalGetAivFeq(uint32_t deviceId);
#ifdef __cplusplus
}
#endif
#endif