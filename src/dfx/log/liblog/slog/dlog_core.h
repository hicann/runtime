/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DLOG_CORE_H
#define DLOG_CORE_H

#include "dlog_message.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

void DlogInit(void);
int32_t DlogWriteInner(LogMsgArg* msgArg, const char* fmt, va_list v);
void DlogRefreshCache(void);
int32_t DlogCheckLogLevel(int32_t logLevel);

/*
 * Deferred driver resolution: switch alog to slog at most once, from a
 * normal API entry point (first log write, DlogSetAttr, DlogInit) - never from a
 * load-time constructor, which would dlopen libascend_hal.so (a libslog.so
 * consumer) while the library is still initialising. Safe to call repeatedly.
 * Returns LOG_SUCCESS when writes are being forwarded to slog.
 */
int32_t DlogTryTransferToSlog(void);

/* Whether DlogInit has completed. Guards re-entrant writes from the driver. */
bool DlogIsInited(void);

#ifdef __cplusplus
}
#endif // __cplusplus

#endif // DLOG_CORE_H
