/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "slog.h"

#include <stdarg.h>
#include <stdio.h>
#include <string.h>

void dav_log(int module_id, const char *fmt, ...) {}

static int log_level = DLOG_DEBUG;

#define __DO_PRINT(log_level)                                 \
  do {                                               \
    const int FMT_BUFF_SIZE = 1024;                  \
    char fmt_buff[FMT_BUFF_SIZE] = {0};              \
    va_list valist;                                  \
    va_start(valist, fmt);                           \
    vsnprintf(fmt_buff, FMT_BUFF_SIZE, fmt, valist); \
    va_end(valist);                                  \
    printf("[%s]%s \n", #log_level, fmt_buff);                       \
  } while (0)

void DlogErrorInner(int module_id, const char *fmt, ...) {
  if (log_level > DLOG_ERROR) {
    return;
  }
  __DO_PRINT(ERROR);
}

void DlogWarnInner(int module_id, const char *fmt, ...) {
  if (log_level > DLOG_WARN) {
    return;
  }
  __DO_PRINT(WARN);
}

void DlogInfoInner(int module_id, const char *fmt, ...) {
  if (log_level > DLOG_INFO) {
    return;
  }
  __DO_PRINT(INFO);
}

void DlogWrite(int module_id, int level, const char *fmt, ...) {
  if (log_level > level) {
    return;
  }
  __DO_PRINT(level);
}

void DlogRecord(int module_id, int level, const char *fmt, ...) {
  if (log_level > level) {
    return;
  }
  __DO_PRINT(level);
}

void DlogDebugInner(int module_id, const char *fmt, ...) {
  if (log_level > DLOG_DEBUG) {
    return;
  }
  __DO_PRINT(DEBUG);
}

void DlogEventInner(int module_id, const char *fmt, ...) { __DO_PRINT(EVENT); }

void DlogInner(int module_id, int level, const char *fmt, ...) { dav_log(module_id, fmt); }

int dlog_setlevel(int module_id, int level, int enable_event) {
  log_level = level;
  return log_level;
}

int dlog_getlevel(int module_id, int *enable_event) { return log_level; }

int CheckLogLevel(int moduleId, int log_level_check) { return log_level >= log_level_check; }

/**
 * @ingroup plog
 * @brief DlogReportInitialize: init log in service process before all device setting.
 * @return: 0: SUCCEED, others: FAILED
 */
int DlogReportInitialize() { return 0; }

/**
 * @ingroup plog
 * @brief DlogReportFinalize: release log resource in service process after all device reset.
 * @return: 0: SUCCEED, others: FAILED
 */
int DlogReportFinalize() { return 0; }

int DlogSetAttr(LogAttr logAttr) {
    return 0;
}

void DlogFlush() {}