/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef PLOG_TO_DLOG_H
#define PLOG_TO_DLOG_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

// log function index for g_slogFuncInfo
#define DLOG_REPORT_INITIALIZE 0U
#define DLOG_REPORT_FINALIZE 1U
#define DLOG_REPORT_START 2U
#define DLOG_REPORT_STOP 3U
#define PLOG_FUNC_MAX 4U

int32_t PlogTransferToUnifiedlog(void);
int32_t PlogCloseUnifiedlog(void);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif // PLOG_TO_DLOG_H