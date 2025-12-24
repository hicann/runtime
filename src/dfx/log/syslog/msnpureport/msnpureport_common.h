/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef MSNPUREPORT_COMMON_H
#define MSNPUREPORT_COMMON_H

#include <stdint.h>
#include <stdbool.h>

#ifdef _LOG_UT_
#define STATIC
#define INLINE
#else
#define STATIC static
#define INLINE inline
#endif

enum CmdType {
    CONFIG_GET,
    CONFIG_SET,
    REPORT,
    REPORT_PERMANENT,
    INVALID_CMD
};

enum ConfigType {
    LOG_LEVEL = 0,
    ICACHE_RANGE,
    ACCELERATOR_RECOVER,
    AIC_SWITCH,
    AIV_SWITCH,
    SINGLE_COMMIT,
    INVALID_TYPE
};

enum ReportType {
    REPORT_DEFAULT = 0,
    REPORT_ALL,
    REPORT_FORCE,
    REPORT_TYPE,
};

#define MAX_VALUE_STR_LEN 64
#define MIN_USER_ARG_LEN 2

typedef struct {
    enum CmdType cmdType;
    uint32_t subCmd;
    uint16_t deviceId;
    uint16_t valueLen;
    int32_t coreSwitch;
    int32_t reportType;
    int32_t dockerFlag;
    int32_t printMode;
    int32_t selfLogLevel;
    char value[MAX_VALUE_STR_LEN];
} ArgInfo;

struct MsnReq {
    enum CmdType cmdType;
    uint32_t subCmd;
    uint32_t valueLen;
    char value[0];
};

struct ConfigInfo {
    uint32_t len;
    bool isError;
    char value[0];
};

typedef struct {
    uint32_t sysLogFileNum;
    uint32_t sysLogFileSize;
    uint32_t eventLogFileNum;
    uint32_t eventLogFileSize;
    uint32_t securityLogFileNum;
    uint32_t securityLogFileSize;
    uint32_t firmwareLogFileNum;
    uint32_t firmwareLogFileSize;
    uint32_t stackcoreFileNum;
    uint32_t slogdLogFileNum;
    uint32_t deviceAppDirNum;
    uint32_t faultEventDirNum;
    uint32_t bboxDirNum;
} FileAgeingParam;

#define MAX_ICACHE_CHECK_RANGE (128U * 1024U)   // 128M
#define DISABLE_CORE 0
#define ENABLE_CORE 1
#define RESTORE_CORE 2

enum {
    CORE_ID0 = 0,
    CORE_ID1,
    CORE_ID2,
    CORE_ID3,
    CORE_ID_MAX
};

// define by TS
typedef struct {
    uint8_t coreSwitch;  // 0: disable 1:enable 2:restore
    uint8_t configNum;
    uint8_t coreId[CORE_ID_MAX];
    uint8_t resv[14];
} DfxCoreSetMask;
// define by TS
typedef struct {
    uint32_t value;  // 通用log dfx配置值
    uint8_t resv[16];
} DfxCommon;

#endif // MSNPUREPORT_COMMON_H