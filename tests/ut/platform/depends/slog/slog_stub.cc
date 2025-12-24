/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "toolchain/slog.h"
#include <stdio.h>
#include <fstream>
#include <string.h>
#include <stdarg.h>
#include <map>

#define MSG_LENGTH_STUB   (1024)
#define SET_MOUDLE_ID_MAP_NAME(x) { #x, x}

#ifdef __cplusplus
extern "C" {
#endif

#ifndef LINUX
#define LINUX 0
#endif

#ifndef OS_TYPE
#define OS_TYPE 0
#endif

#if (OS_TYPE == LINUX)
#define PATH_SLOG "/usr/slog/slog"
#else
#define PATH_SLOG "C:\\Program Files\\Huawei\\HiAI Foundation\\log"
#endif

typedef struct _dcode_stub {
  const char *c_name;
  int c_val;
} DCODE_STUB;

static DCODE_STUB module_id_name_stub[] =
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
#if (OS_TYPE == LINUX)
        SET_MOUDLE_ID_MAP_NAME(HDC),
#else
        SET_MOUDLE_ID_MAP_NAME(HDCL),
#endif
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
        SET_MOUDLE_ID_MAP_NAME(LIBMEDIA),
        SET_MOUDLE_ID_MAP_NAME(CCECPU),
        SET_MOUDLE_ID_MAP_NAME(26),
        SET_MOUDLE_ID_MAP_NAME(ROS),
        SET_MOUDLE_ID_MAP_NAME(HCCP),
        SET_MOUDLE_ID_MAP_NAME(ROCE),
        SET_MOUDLE_ID_MAP_NAME(TEFUSION),
        SET_MOUDLE_ID_MAP_NAME(PROFILING),
        SET_MOUDLE_ID_MAP_NAME(DP),
        SET_MOUDLE_ID_MAP_NAME(APP),
        SET_MOUDLE_ID_MAP_NAME(TS),
        SET_MOUDLE_ID_MAP_NAME(TSDUMP),
        SET_MOUDLE_ID_MAP_NAME(AICPU),
        SET_MOUDLE_ID_MAP_NAME(LP),
        SET_MOUDLE_ID_MAP_NAME(TDT),
        SET_MOUDLE_ID_MAP_NAME(FE),
        SET_MOUDLE_ID_MAP_NAME(MD),
        SET_MOUDLE_ID_MAP_NAME(MB),
        SET_MOUDLE_ID_MAP_NAME(ME),
        SET_MOUDLE_ID_MAP_NAME(IMU),
        SET_MOUDLE_ID_MAP_NAME(IMP),
        SET_MOUDLE_ID_MAP_NAME(GE),
        SET_MOUDLE_ID_MAP_NAME(46),
        SET_MOUDLE_ID_MAP_NAME(CAMERA),
        SET_MOUDLE_ID_MAP_NAME(ASCENDCL),
        SET_MOUDLE_ID_MAP_NAME(TEEOS),
        SET_MOUDLE_ID_MAP_NAME(ISP),
        SET_MOUDLE_ID_MAP_NAME(SIS),
        SET_MOUDLE_ID_MAP_NAME(HSM),
        SET_MOUDLE_ID_MAP_NAME(DSS),
        SET_MOUDLE_ID_MAP_NAME(PROCMGR),
        SET_MOUDLE_ID_MAP_NAME(BBOX),
        SET_MOUDLE_ID_MAP_NAME(AIVECTOR),
        SET_MOUDLE_ID_MAP_NAME(TBE),
        SET_MOUDLE_ID_MAP_NAME(FV),
        SET_MOUDLE_ID_MAP_NAME(59),
        SET_MOUDLE_ID_MAP_NAME(TUNE),
        SET_MOUDLE_ID_MAP_NAME(OP),
        {NULL, -1}
    };
//#if (OS_TYPE == LINUX)
//extern void dlog_init(void);
//void DlogErrorInner(int module_id, const char *fmt, ...);
//void DlogWarnInner(int module_id, const char *fmt, ...);
//void DlogInfoInner(int module_id, const char *fmt, ...);
//void DlogDebugInner(int module_id, const char *fmt, ...);
//void DlogEventInner(int module_id, const char *fmt, ...);
//#endif
}

const std::map<int, std::string> LOG_LEVEL_STR_MAP {
    {DLOG_DEBUG, "DEBUG"},
    {DLOG_INFO, "INFO"},
    {DLOG_WARN, "WARNING"},
    {DLOG_ERROR, "ERROR"},
    {DLOG_EVENT, "EVENT"}
};

std::string GetLogLevelStr(int level)
{
    auto iter = LOG_LEVEL_STR_MAP.find(level);
    if (iter == LOG_LEVEL_STR_MAP.end()) {
        return "";
    }
    return iter->second;
}

int CheckLogLevel(int moduleId, int level)
{
    return level < 2;
}

void DlogRecord(int module_id, int level, const char *fmt, ...)
{
    if (module_id < 0 || module_id >= INVLID_MOUDLE_ID){
        return;
    }

    if (!CheckLogLevel(module_id, level)) {
        return;
    }
    int len;
    char msg[MSG_LENGTH_STUB] = {0};
    std::string level_str = GetLogLevelStr(level);
    snprintf(msg,MSG_LENGTH_STUB,"[%s] [%s] ", level_str.c_str(), module_id_name_stub[module_id].c_name);
    va_list ap;

    va_start(ap,fmt);
    len = strlen(msg);
    vsnprintf(msg + len, MSG_LENGTH_STUB- len, fmt, ap);
    va_end(ap);

    len = strlen(msg);
    if (len < MSG_LENGTH_STUB - 1 && msg[len - 1] != '\n') {
        msg[len] = '\n';
        msg[len + 1] = '\0';
    }
    printf("%s", msg);
    return;
}

void DlogErrorInner(int module_id, const char *fmt, ...)
{
    if(module_id < 0 || module_id >= INVLID_MOUDLE_ID){
        return;
    }

    if (!CheckLogLevel(module_id, 0)) {
        return;
    }

    int len;
    char msg[MSG_LENGTH_STUB] = {0};
    snprintf(msg,MSG_LENGTH_STUB,"[%s] [ERROR] ",module_id_name_stub[module_id].c_name);
    va_list ap;

    va_start(ap,fmt);
    len = strlen(msg);
    vsnprintf(msg + len, MSG_LENGTH_STUB- len, fmt, ap);
    va_end(ap);
    len = strlen(msg);
    if (len < MSG_LENGTH_STUB - 1 && msg[len - 1] != '\n') {
      msg[len] = '\n';
      msg[len + 1] = '\0';
    }
    printf("%s",msg);
    return;
}

void DlogWarnInner(int module_id, const char *fmt, ...)
{
    if(module_id < 0 || module_id >= INVLID_MOUDLE_ID){
        return;
    }

    if (!CheckLogLevel(module_id, 1)) {
        return;
    }

    int len;
    char msg[MSG_LENGTH_STUB] = {0};
    snprintf(msg,MSG_LENGTH_STUB,"[%s] [WARNING] ",module_id_name_stub[module_id].c_name);
    va_list ap;

    va_start(ap,fmt);
    len = strlen(msg);
    vsnprintf(msg + len, MSG_LENGTH_STUB- len, fmt, ap);
    va_end(ap);

    len = strlen(msg);
    if (len < MSG_LENGTH_STUB - 1 && msg[len - 1] != '\n') {
      msg[len] = '\n';
      msg[len + 1] = '\0';
    }
    printf("%s",msg);
    return;
}

void DlogInfoInner(int module_id, const char *fmt, ...)
{
    if(module_id < 0 || module_id >= INVLID_MOUDLE_ID){
        return;
    }

    if (!CheckLogLevel(module_id, 2)) {
        return;
    }

    int len;
    char msg[MSG_LENGTH_STUB] = {0};
    snprintf(msg,MSG_LENGTH_STUB,"[%s] [INFO] ",module_id_name_stub[module_id].c_name);
    va_list ap;

    va_start(ap,fmt);
    len = strlen(msg);
    vsnprintf(msg + len, MSG_LENGTH_STUB- len, fmt, ap);
    va_end(ap);

    len = strlen(msg);
    if (len < MSG_LENGTH_STUB - 1 && msg[len - 1] != '\n') {
      msg[len] = '\n';
      msg[len + 1] = '\0';
    }
    printf("%s",msg);
    return;
}


void DlogInner(int module_id, int level, const char *fmt, ...)
{
  if(module_id < 0 ){
    return;
  }

  if (!CheckLogLevel(module_id, 4 - level)) {
    return;
  }
  std::string level_str;
  if (level == 0) {
    level_str = "DEBUG";
  } else if (level == 1) {
    level_str = "INFO";
  } else if (level == 2) {
    level_str = "WARNING";
  } else {
    level_str = "ERROR";
  }
  int len;
  char msg[MSG_LENGTH_STUB] = {0};
  if (module_id >= INVLID_MOUDLE_ID) {
    snprintf(msg,MSG_LENGTH_STUB,"[%s] [%s] ", "UNKNOWN", level_str.c_str());
  } else {
    snprintf(msg,MSG_LENGTH_STUB,"[%s] [%s] ", module_id_name_stub[module_id].c_name, level_str.c_str());
  }

  va_list ap;

  va_start(ap,fmt);
  len = strlen(msg);
  vsnprintf(msg + len, MSG_LENGTH_STUB - len, fmt, ap);
  va_end(ap);

  len = strlen(msg);
  if (len < MSG_LENGTH_STUB - 1 && msg[len - 1] != '\n') {
    msg[len] = '\n';
    msg[len + 1] = '\0';
  }
  printf("%s",msg);
  return;
}

void DlogDebugInner(int module_id, const char *fmt, ...)
{
    if(module_id < 0 || module_id >= INVLID_MOUDLE_ID){
        return;
    }

    if (!CheckLogLevel(module_id, 3)) {
        return;
    }

    int len;
    char msg[MSG_LENGTH_STUB] = {0};
    snprintf(msg,MSG_LENGTH_STUB,"[%s] [DEBUG] ",module_id_name_stub[module_id].c_name);
    va_list ap;

    va_start(ap,fmt);
    len = strlen(msg);
    vsnprintf(msg + len, MSG_LENGTH_STUB - len, fmt, ap);
    va_end(ap);

    len = strlen(msg);
    if (len < MSG_LENGTH_STUB - 1 && msg[len - 1] != '\n') {
      msg[len] = '\n';
      msg[len + 1] = '\0';
    }
    printf("%s",msg);
    return;
}

void DlogEventInner(int module_id, const char *fmt, ...)
{
    if(module_id < 0 || module_id >= INVLID_MOUDLE_ID){
        return;
    }

    if (!CheckLogLevel(module_id, 4)) {
        return;
    }

    int len;
    char msg[MSG_LENGTH_STUB + 1] = {0};
    snprintf(msg,MSG_LENGTH_STUB,"[%s] [EVENT] ",module_id_name_stub[module_id].c_name);
    va_list ap;

    va_start(ap,fmt);
    len = strlen(msg);
    vsnprintf(msg + len, MSG_LENGTH_STUB- len, fmt, ap);
    va_end(ap);
    len = strlen(msg);
    if (len <= MSG_LENGTH_STUB && msg[len - 2] != '\n') {
      msg[len - 1] = '\n';
      msg[len] = '\0';
    }
    printf("%s",msg);
    return;
}

