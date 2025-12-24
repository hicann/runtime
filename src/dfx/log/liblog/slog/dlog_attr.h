/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DLOG_ATTR_H
#define DLOG_ATTR_H

#include <stdint.h>
#include <stdbool.h>
#include "slog.h"
#include "log_error_code.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus
#ifndef DEFAULT_LOG_WORKSPACE
#define DEFAULT_LOG_WORKSPACE "/usr/slog"
#endif

typedef enum {
    AOS_GEA = 0,
    AOS_SEA,
} AosType;

void DlogGetUserAttr(LogAttr *attr);
void DlogSetUserAttr(const LogAttr *logAttr);
bool DlogCheckAttrSystem(void);
ProcessType DlogGetProcessType(void);
uint32_t DlogGetAttrDeviceId(void);

bool DlogIsAosCore(void);
AosType DlogGetAosType(void);
bool DlogIsPoolingDevice(void);

int32_t DlogGetCurrPid(void);
void DlogSetCurrPid(void);
bool DlogCheckCurrPid(void);
uint32_t DlogGetHostPid(void);
uint32_t DlogGetUid(void);
uint32_t DlogGetGid(void);

void DlogInitGlobalAttr(void);

#ifdef __cplusplus
}
#endif // __cplusplus

#ifdef __cplusplus
#ifndef LOG_CPP
extern "C" {
#endif
#endif // __cplusplus
/**
 * @ingroup     : slog
 * @brief       : get log attr
 * @param [out] : logAttrInfo struct LogAttr pointer
 * @return      : 0: SUCCEED, others: FAILED
 */
LOG_FUNC_VISIBILITY int32_t DlogGetAttr(LogAttr *logAttrInfo);
#ifdef __cplusplus
#ifndef LOG_CPP
}
#endif // LOG_CPP
#endif // __cplusplus

#endif // DLOG_ATTR_H