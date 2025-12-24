/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __PLATFORM_LOG_H__
#define __PLATFORM_LOG_H__

#include <sys/syscall.h>
#include <unistd.h>
#include <string>
#include "err_msg.h"
#ifndef COMPILE_PLATFORM_STATIC
#include "dlog_pub.h"
#endif
/** Assigned FE name in log */
const std::string PF_MODULE_NAME = "FE";

inline pid_t PltGetTid() {
  thread_local static pid_t tid = syscall(__NR_gettid);
  return tid;
}

#ifdef COMPILE_PLATFORM_STATIC
#define D_PF_LOGD(MOD_NAME, fmt, ...)                                             \
    do {                                                                          \
        (void)MOD_NAME;                                                           \
        (void)fmt;                                                                \
    } while (0)

#define D_PF_LOGI(MOD_NAME, fmt, ...)                                             \
    do {                                                                          \
        (void)MOD_NAME;                                                           \
        (void)fmt;                                                                \
    } while (0)

#define D_PF_LOGW(MOD_NAME, fmt, ...)                                             \
    do {                                                                          \
        (void)MOD_NAME;                                                           \
        (void)fmt;                                                                \
    } while (0)

#define D_PF_LOGE(MOD_NAME, fmt, ...)                                             \
    do {                                                                          \
        (void)MOD_NAME;                                                           \
        (void)fmt;                                                                \
    } while (0)
#endif

#ifndef COMPILE_PLATFORM_STATIC
#define D_PF_LOGD(MOD_NAME, fmt, ...) dlog_debug(FE, "%lu %s:" fmt "\n", PltGetTid(), __FUNCTION__, ##__VA_ARGS__)
#define D_PF_LOGI(MOD_NAME, fmt, ...) dlog_info(FE, "%lu %s:" fmt "\n", PltGetTid(), __FUNCTION__, ##__VA_ARGS__)
#define D_PF_LOGW(MOD_NAME, fmt, ...) dlog_warn(FE, "%lu %s:" fmt "\n", PltGetTid(), __FUNCTION__, ##__VA_ARGS__)
#define D_PF_LOGE(MOD_NAME, fmt, ...) dlog_error(FE, "%lu %s:" fmt "\n", PltGetTid(), __FUNCTION__, ##__VA_ARGS__)
#endif

#define PF_LOGD(...) D_PF_LOGD(PF_MODULE_NAME, __VA_ARGS__)
#define PF_LOGI(...) D_PF_LOGI(PF_MODULE_NAME, __VA_ARGS__)
#define PF_LOGW(...) D_PF_LOGW(PF_MODULE_NAME, __VA_ARGS__)
#define PF_LOGE(...) D_PF_LOGE(PF_MODULE_NAME, __VA_ARGS__)

#define PF_MAKE_SHARED(exec_expr0, exec_expr1) \
  do {                                         \
    try {                                      \
      exec_expr0;                              \
    } catch (...) {                            \
      PF_LOGE("Make shared failed");           \
      exec_expr1;                              \
    }                                          \
  } while (0)

#endif  // __PLATFORM_LOG_H__
