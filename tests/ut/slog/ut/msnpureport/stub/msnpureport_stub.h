/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __MSNPUREPORT_STUB_H__
#define __MSNPUREPORT_STUB_H__

#include "adx_api.h"
#include "ascend_hal.h"
#include "mmpa_api.h"
#include "log_level.h"

#ifdef __cplusplus
extern "C" {
#endif

#define REPORT_OPTION_INDEX     8
#define SLOG_PATH       "slog"
#define STACKCORE_PATH  "stackcore"
#define MESSAGE_PATH    "message"
#define EVENT_PATH      "event_sched"
#define DIR_MODE 0700
#define TIME_SIZE 128
#define MAX_DEV_NUM 64

#define MIN_USER_ARG_LEN 2
#define DEVICE_LEN 3
#define LOG_TYPE_LEN 1
#define MAX_LOG_LEVEL_CMD_LEN 128 // the max length of : SetLogLevel(1)[MDCPERCEPTION:debug]
/*
the max length of LOG_LEVEL_RESULT:
[global]
WARNING
[event]
DISABLE
[module]
SLOG:WARNING IDEDD:WARNING IDEDH:WARNING HCCL:WARNING
FMK:WARNING HIAIENGINE:WARNING DVPP:WARNING RUNTIME:WARNING
...
*/
#define MAX_LOG_LEVEL_RESULT_LEN 1024
#define MAX_LEVEL_STR_LEN 64  // the max length of module name + level: error, info, warning, debug, null,
#define BLOCK_RETURN_CODE 4 // device check hdc-client is in docker

#define SET_LOG_LEVEL_STR "SetLogLevel"
#define GET_LOG_LEVEL_STR "GetLogLevel"
#define EVENT_ENABLE "ENABLE"
#define EVENT_DISABLE "DISABLE"
#define CONNECT_OCCUPIED_MESSAGE            "The connection is occupied"
#define CONTAINER_NO_SUPPORT_MESSAGE        "not support container environment"

typedef enum {
    RPT_ARGS_GLOABLE_LEVEL = 'g',
    RPT_ARGS_MODULE_LEVEL = 'm',
    RPT_ARGS_EVENT_LEVEL = 'e',
    RPT_ARGS_LOG_TYPE = 't',
    RPT_ARGS_DEVICE_ID = 'd',
    RPT_ARGS_REQUEST_LOG_LEVEL = 'r',
    RPT_ARGS_EXPORT_BBOX_LOGS_DEVICE_EVENT = 'a',
    RPT_ARGS_EXPORT_BBOX_LOGS_DEVICE_EVENT_MAINTENANCE_INFORMATION = 'f',
    RPT_ARGS_HELP = 'h',
    RPT_ARGS_DOCKER = 'D'
} UserArgsType;

typedef struct {
    int32_t logType;
    uint32_t logicId;
    int64_t devOsId;
    uint32_t phyId;
    bool isThreadExit;
} ThreadArgInfo;

typedef struct {
    mmUserBlock_t block;
    mmThread tid;
} ThreadInfo;

typedef struct {
    uint32_t magic;
    uint32_t version;
    int32_t retCode;
    uint8_t reserve[116];  // reserve 124 bytes
    char retMsg[128]; // msg length 128 bytes
} MsnServerResultInfo;

void *DlopenStub(const char *filename, int flags);
void *DlsymStub(void *handle, const char *symbol);
drvError_t halGetDeviceInfo_stub(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value);
#ifdef __cplusplus
}
#endif
#endif
