/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef LOG_COMMUNICATION_H
#define LOG_COMMUNICATION_H

#include "log_error_code.h"

#define LOGHEAD_LEN     sizeof(LogHead)
#define HEAD_MAGIC      0xA1C0U
#define HEAD_VERSION    0x0001U
#define LOG_REPORT_MAGIC    0xB87AU
#define SINGLE_EXPORT_LOG               "slog_single"
#define CONTAINER_NO_SUPPORT_MESSAGE    "not support container environment"
#define CONNECT_OCCUPIED_MESSAGE        "The connection is occupied"

typedef struct {
    uint16_t magic;
    uint16_t version;
    uint8_t aosType;
    uint8_t processType;
    uint8_t logType;
    uint8_t logLevel;
    uint32_t hostPid;
    uint32_t devicePid;
    uint16_t deviceId;
    uint16_t moduleId;
    uint16_t allLength;
    uint16_t msgLength;
    uint8_t tagSwitch;
    uint8_t saveMode;
    uint8_t resv[6];
} LogHead;

typedef struct {
    uint16_t magic;
    uint16_t logType;
    uint32_t bufLen;
    uint8_t devId;
    char reserve[31];
    char buf[0];
} LogReportMsg;

#endif