/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ALOG_TO_SLOG_H
#define ALOG_TO_SLOG_H

#include <stdint.h>
#include "library_load.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

// log function index for g_slogFuncInfo
#define DLOG_INIT 0U
#define DLOG_GET_LEVEL 1U
#define DLOG_SET_LEVEL 2U
#define CHECK_LOG_LEVEL 3U
#define DLOG_GET_ATTR 4U
#define DLOG_SET_ATTR 5U
#define DLOG_VA_LIST 6U
#define DLOG_FLUSH 7U
#define DLOG_FUNC_MAX 8U

#ifdef PROCESS_LOG
int32_t AlogTransferToUnifiedlog(void);
#else
int32_t AlogTransferToSlog(void);
#endif
void AlogCloseSlogLib(void);

int32_t AlogTryUseSlog(void);
void AlogCloseDrvLib(void);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif // ALOG_TO_SLOG_H