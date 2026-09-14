/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DLOG_DRV_H
#define DLOG_DRV_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

/*
 * Register the driver log callback (UNIFIEDBUS log sink). Runs at most once per
 * process, from DlogInit. dlopen of the driver library is deferred out of the
 * load-time constructor on purpose: libascend_hal.so links against libslog.so,
 * so resolving it during library initialisation re-enters the dynamic loader.
 */
void DlogInitDriverLog(void);

/* Undo the registration state so a later DlogInit registers again. */
void DlogResetDriverLog(void);

/* Fork-child variant: re-initializes mutexes and latch state without taking
 * locks (single-threaded child) and drops the handle without dlclose. */
void DlogForkResetDriverLog(void);

/* Tell the driver to stop calling our log callback. Runs from DlogFree, before
 * the driver library handle is dropped. */
void DlogUnregisterDriverLog(void);

/*
 * Push a log level change down to the driver, which converts it and forwards it
 * to UNIFIEDBUS. moduleId must be DRV or UNIFIEDBUS; ALL_MODULE fans out to both.
 */
void DlogSetDriverLogLevel(int32_t moduleId, int32_t level);

#ifdef __cplusplus
}
#endif // __cplusplus

#endif // DLOG_DRV_H
