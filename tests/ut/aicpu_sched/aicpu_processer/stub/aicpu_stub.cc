/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <stdio.h>
#include <fstream>
#include <string.h>
#include "toolchain/slog.h"
#include <stdarg.h>
#include <stdio.h>
#include "aicpu_context.h"

namespace aicpu {
status_t GetAicpuRunMode(uint32_t &runMode)
{
    runMode = aicpu::PROCESS_PCIE_MODE;
    return AICPU_ERROR_NONE;
}

status_t SetBlockIdxAndBlockNum(uint32_t blockIdx, uint32_t blockNum)
{
    return AICPU_ERROR_NONE;
}
}

#ifndef RUN_ON_AICPU

#define MSG_LENGTH_STUB   (1024)
#define SET_MOUDLE_ID_MAP_NAME(x) { #x, x}

typedef struct _dcode_stub {
    const char *c_name;
    int c_val;
} DCODE_STUB;

static DCODE_STUB moduleIdName_stub[] =
{
    SET_MOUDLE_ID_MAP_NAME(SLOG),
    SET_MOUDLE_ID_MAP_NAME(IDEDD),
    SET_MOUDLE_ID_MAP_NAME(2),
    SET_MOUDLE_ID_MAP_NAME(HCCL),
    SET_MOUDLE_ID_MAP_NAME(FMK),
    SET_MOUDLE_ID_MAP_NAME(5),
    SET_MOUDLE_ID_MAP_NAME(DVPP),
    SET_MOUDLE_ID_MAP_NAME(RUNTIME),
    SET_MOUDLE_ID_MAP_NAME(CCE),
    SET_MOUDLE_ID_MAP_NAME(HDC),
    SET_MOUDLE_ID_MAP_NAME(DRV),
    SET_MOUDLE_ID_MAP_NAME(11),
    SET_MOUDLE_ID_MAP_NAME(12),
    SET_MOUDLE_ID_MAP_NAME(13),
    SET_MOUDLE_ID_MAP_NAME(14),
    SET_MOUDLE_ID_MAP_NAME(15),
    SET_MOUDLE_ID_MAP_NAME(16),
    SET_MOUDLE_ID_MAP_NAME(17),
    SET_MOUDLE_ID_MAP_NAME(18),
    SET_MOUDLE_ID_MAP_NAME(19),
    SET_MOUDLE_ID_MAP_NAME(20),
    SET_MOUDLE_ID_MAP_NAME(21),
    SET_MOUDLE_ID_MAP_NAME(DEVMM),
    SET_MOUDLE_ID_MAP_NAME(KERNEL),
    {NULL, -1}
};

static const char *logLevel[] =
{
    "DEBUG",
    "INFO",
    "WARNING",
    "ERROR",
    "NULL",
};

void DlogErrorInner(int module_id, const char *fmt, ...)
{
    if(module_id < 0 || module_id >= INVLID_MOUDLE_ID){
        return;
    }

    int len;
    char msg[MSG_LENGTH_STUB] = {0};
    snprintf(msg,MSG_LENGTH_STUB,"[%s] [ERROR] ",moduleIdName_stub[module_id].c_name);
    va_list ap;

    va_start(ap,fmt);
    len = strlen(msg);
    vsnprintf(msg + len, MSG_LENGTH_STUB- len, fmt, ap);
    va_end(ap);

    printf("%s",msg);
    return;
}

void DlogWarnInner(int module_id, const char *fmt, ...)
{
    if(module_id < 0 || module_id >= INVLID_MOUDLE_ID){
        return;
    }

    int len;
    char msg[MSG_LENGTH_STUB] = {0};
    snprintf(msg,MSG_LENGTH_STUB,"[%s] [WARNING] ",moduleIdName_stub[module_id].c_name);
    va_list ap;

    va_start(ap,fmt);
    len = strlen(msg);
    vsnprintf(msg + len, MSG_LENGTH_STUB- len, fmt, ap);
    va_end(ap);

    printf("%s",msg);
    return;
}

void DlogInfoInner(int module_id, const char *fmt, ...)
{
    if(module_id < 0 || module_id >= INVLID_MOUDLE_ID){
        return;
    }

    int len;
    char msg[MSG_LENGTH_STUB] = {0};
    snprintf(msg,MSG_LENGTH_STUB,"[%s] [INFO] ",moduleIdName_stub[module_id].c_name);
    va_list ap;

    va_start(ap,fmt);
    len = strlen(msg);
    vsnprintf(msg + len, MSG_LENGTH_STUB- len, fmt, ap);
    va_end(ap);

    printf("%s",msg);
    return;
}

void DlogWrite(int module_id, int level, const char *fmt, ...) {
    if(module_id < 0 || module_id >= INVLID_MOUDLE_ID || level >= 5) {
        return;
    }

    int len;
    char msg[MSG_LENGTH_STUB] = {0};
    snprintf(msg,MSG_LENGTH_STUB,"[%s] [%s]",moduleIdName_stub[module_id].c_name, logLevel[level]);
    va_list ap;

    va_start(ap,fmt);
    len = strlen(msg);
    vsnprintf(msg + len, MSG_LENGTH_STUB- len, fmt, ap);
    va_end(ap);

    printf("%s",msg);
    return;
}

void DlogRecord(int module_id, int level, const char *fmt, ...) {
    if(module_id < 0 || module_id >= INVLID_MOUDLE_ID || level >= 5) {
        return;
    }

    int len;
    char msg[MSG_LENGTH_STUB] = {0};
    snprintf(msg,MSG_LENGTH_STUB,"[%s] [%s]",moduleIdName_stub[module_id].c_name, logLevel[level]);
    va_list ap;

    va_start(ap,fmt);
    len = strlen(msg);
    vsnprintf(msg + len, MSG_LENGTH_STUB- len, fmt, ap);
    va_end(ap);

    printf("%s",msg);
    return;
}

void DlogDebugInner(int module_id, const char *fmt, ...)
{
    if(module_id < 0 || module_id >= INVLID_MOUDLE_ID){
        return;
    }

    int len;
    char msg[MSG_LENGTH_STUB] = {0};
    snprintf(msg,MSG_LENGTH_STUB,"[%s] [DEBUG] ",moduleIdName_stub[module_id].c_name);
    va_list ap;

    va_start(ap,fmt);
    len = strlen(msg);
    vsnprintf(msg + len, MSG_LENGTH_STUB- len, fmt, ap);
    va_end(ap);

    printf("%s",msg);
    return;
}

void DlogInner(int module_id, int level, const char *fmt, ...)
{
    if(module_id < 0 || module_id >= INVLID_MOUDLE_ID || level >= 5) {
        return;
    }

    int len;
    char msg[MSG_LENGTH_STUB] = {0};
    snprintf(msg,MSG_LENGTH_STUB,"[%s] [%s]",moduleIdName_stub[module_id].c_name, logLevel[level]);
    va_list ap;

    va_start(ap,fmt);
    len = strlen(msg);
    vsnprintf(msg + len, MSG_LENGTH_STUB- len, fmt, ap);
    va_end(ap);

    printf("%s",msg);
    return;
}

#endif
