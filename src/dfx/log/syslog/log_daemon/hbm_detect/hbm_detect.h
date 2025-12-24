/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef HBM_DETECT_H
#define HBM_DETECT_H
#include "adcore_api.h"

#ifdef __cplusplus
extern "C" {
#endif

#define HBM_AML_MAGIC_NUM                  0xA1A1A1A1U
#define HBM_AML_VERSION                    0x1000U
#define MAX_NUM_OF_ADDR                    128U
typedef enum AmlHbmOperate {
    OPERATE_SET_ADDR = 0,
    OPERATE_RUN,
    OPERATE_RUN_FREE
} AmlHbmOperate;

typedef struct AmlHbmAddrInfo {
    uint64_t startAddr;
    uint64_t endAddr;
} AmlHbmAddrInfo;

typedef struct AmlHbmDetectInfo {
    uint32_t magic;
    uint32_t version;
    AmlHbmOperate operate;
    uint32_t num;
    AmlHbmAddrInfo info[MAX_NUM_OF_ADDR];
    uint8_t reserve[16]; // reserve 16 bytes
} AmlHbmDetectInfo;

int32_t HbmDetectInit(void);
int32_t HbmDetectDestroy(void);
int32_t HbmDetectProcess(const CommHandle *handle, const void *value, uint32_t len);
#ifdef __cplusplus
}
#endif
#endif