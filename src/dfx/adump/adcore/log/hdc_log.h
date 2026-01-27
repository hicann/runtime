/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef IDE_HDC_LOG_H
#define IDE_HDC_LOG_H
#include <cstdint>
#include <sys/syslog.h>
#include "mmpa_api.h"
#include "dlog_pub.h"
namespace Adx {
const int32_t ADX_MODULE_NAME = IDEDD;
const int32_t MAX_ERRSTR_LEN  = 128;
#if defined (IDE_DAEMON_DEVICE) || defined (ADX_LIB) || defined (ADX_LIB_HOST)

#define IDE_LOGD(format, ...) do {                                                              \
    dlog_debug(Adx::ADX_MODULE_NAME, "[tid:%d] " format "\n", mmGetTid(), ##__VA_ARGS__);       \
} while (0)
#define IDE_LOGI(format, ...) do {                                                              \
    dlog_info(Adx::ADX_MODULE_NAME, "[tid:%d] " format "\n", mmGetTid(), ##__VA_ARGS__);        \
} while (0)

#define IDE_LOGW(format, ...) do {                                                              \
    dlog_warn(Adx::ADX_MODULE_NAME, "[tid:%d] " format "\n", mmGetTid(), ##__VA_ARGS__);        \
} while (0)

#define IDE_LOGE(format, ...) do {                                                              \
    dlog_error(Adx::ADX_MODULE_NAME, "[tid:%d] " format "\n", mmGetTid(), ##__VA_ARGS__);       \
} while (0)

inline void AdxLogFlush()
{
    DlogFlush();
}
#define IDE_RUN_LOGI(format, ...) do {                                                                        \
    dlog_info(Adx::ADX_MODULE_NAME | RUN_LOG_MASK, "[tid:%d] " format "\n", mmGetTid(), ##__VA_ARGS__);       \
} while (0)
#else
#define IDE_LOGD(format, ...) do {             \
} while (0)

#define IDE_LOGI(format, ...) do {             \
} while (0)

#define IDE_LOGW(format, ...) do {                                                                                  \
    syslog(LOG_WARNING, "[tid:%ld] %s:%d: " format "\n", syscall(SYS_gettid), __FILE__, __LINE__, ##__VA_ARGS__);   \
} while (0)

#define IDE_LOGE(format, ...) do {                                                                              \
    syslog(LOG_ERR, "[tid:%ld] %s:%d: " format "\n", syscall(SYS_gettid), __FILE__, __LINE__, ##__VA_ARGS__);   \
} while (0)

#define IDE_RUN_LOGI(format, ...) do {         \
} while (0)

inline void AdxLogFlush()
{
}

#endif
}
#endif // IDE_HDC_LOG_H
