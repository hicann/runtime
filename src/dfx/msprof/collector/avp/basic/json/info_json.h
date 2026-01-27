/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef BASIC_JSON_INFO_JSON_H
#define BASIC_JSON_INFO_JSON_H

#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>
#include "osal/osal.h"
#include "utils/utils.h"

#ifdef __cplusplus
extern "C" {
#endif

#define MAX_INFO_JSON_LEN 4097
#define MAX_PATH_LEN MAX_INFO_JSON_LEN
#define CPU_TYPE_NAME_LEN 20
#define CPU_ID_STRING_LEN 100
#define MAX_FREQ_LEN 10
#define MAX_MEM_TOTAL_BUF 128
#define MAX_UP_TIME_LEN 64
#define MAX_HW_TYPE_LEN OSAL_CPUDESC_DEFAULT_SIZE
#define MAX_CPU_INFO_LEN OSAL_CPUDESC_DEFAULT_SIZE
#define MAX_JOB_INFO_LEN 3
#define MAX_PLAT_VER_LEN 3
#define MAX_VER_INFO_LEN 5
#define MAX_DEV_CAT_LEN 128

typedef struct {
    int32_t id;
    char name[MAX_CPU_INFO_LEN];
    char frequency[MAX_CPU_INFO_LEN];
    char logicalCpuCount[MAX_NUMBER_LEN];
    char type[MAX_CPU_INFO_LEN];
} CpuInfo;

typedef struct {
    uint32_t id;
    int64_t envType;
    int64_t ctrlCpuCoreNum;
    int64_t ctrlCpuEndianLittle;
    int64_t tsCpuCoreNum;
    int64_t aiCpuCoreNum;
    int64_t aiCoreNum;
    int64_t aiCpuCoreId;
    int64_t aiCoreId;
    int64_t aiCpuOccupyBitMap;
    int64_t aivNum;
    char ctrlCpuId[CPU_TYPE_NAME_LEN];
    char ctrlCpu[CPU_ID_STRING_LEN];
    char aiCpu[CPU_ID_STRING_LEN];
    char hwtsFrequency[MAX_FREQ_LEN];
    char aicFrequency[MAX_FREQ_LEN];
    char aivFrequency[MAX_FREQ_LEN];
} DevInfo;

typedef struct {
    char version[MAX_VER_INFO_LEN];
    char jobInfo[MAX_JOB_INFO_LEN];
    char os[MAX_PATH_LEN];
    char hostname[MAX_PATH_LEN];
    char hwtype[MAX_HW_TYPE_LEN];
    char devices[MAX_DEV_CAT_LEN];
    char platformVersion[MAX_PLAT_VER_LEN];
    char pid[MAX_NUMBER_LEN];
    char upTime[MAX_UP_TIME_LEN];
    uint64_t memoryTotal;
    uint32_t cpuNums;
    uint32_t sysClockFreq;
    uint32_t cpuCores;
    int32_t rankId;
    uint32_t drvVersion;
    CpuInfo *infoCpus;
    DevInfo deviceInfos;
} InfoAttr;

typedef struct {
    int64_t envType; /**< 0, FPGA  1, EMU 2, ESL*/
    int64_t ctrlCpuId;
    int64_t ctrlCpuCoreNum;
    int64_t ctrlCpuEndianLittle;
    int64_t tsCpuCoreNum;
    int64_t aiCpuCoreNum;
    int64_t aiCoreNum;
    int64_t aivNum;
    int64_t aiCpuCoreId;
    int64_t aiCoreId;
    int64_t aiCpuOccupyBitMap;
} DeviceInfo;

int32_t CreateInfoJson(uint32_t deviceId);
int32_t CreateCollectionTimeInfo(uint32_t deviceId, bool isStartTime);
int32_t UploadCollectionTimeInfo(uint32_t deviceId, CHAR* content, size_t contentLen, const CHAR* fileName);
#ifdef __cplusplus
}
#endif
#endif