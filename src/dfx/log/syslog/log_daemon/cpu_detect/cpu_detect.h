/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CPU_DETECT_H
#define CPU_DETECT_H

#include "detect_errcode.h"

#ifdef __cplusplus
extern "C" {
#endif
typedef enum {
    CPU_DETECT_CMD_UNKNOWN = 0,
    CPU_DETECT_CMD_START = 1,
    CPU_DETECT_CMD_MAX,
} CpuDetectCmdType;
#define CPU_DETECT_MAGIC_NUM 0xA1A1A1A1U
#define CPU_DETECT_VERSION 0x1000U
#define CPU_DETECT_MSG_SIZE 256
// total 512 byte
typedef struct CpuDetectInfo {
    uint32_t magic;
    uint32_t version;
    uint32_t cmdType;
    int32_t deviceId;
    uint32_t timeout;
    uint8_t reserve[492];  // reserve 492 bytes
} CpuDetectInfo;

// total 512 byte
typedef struct CpuDetectResultInfo {
    uint32_t magic;
    uint32_t version;
    uint8_t reserve[244];  // reserve 244 bytes
    int32_t retCode;
    char retMsg[CPU_DETECT_MSG_SIZE];  // msg length 256 bytes
} CpuDetectResultInfo;

int32_t CpuDetectServerInit(void);
void CpuDetectServerExit(void);

#ifdef __cplusplus
}
#endif
#endif