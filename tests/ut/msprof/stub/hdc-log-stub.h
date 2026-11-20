/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef _ANALYSIS_DVVP_UT_HDC_LOG_STUB_H_
#define _ANALYSIS_DVVP_UT_HDC_LOG_STUB_H_

#include "slog.h"

void ResetDlogRecordCount();
int32_t GetDlogRecordCount();
void ResetDlogEventCount();
int32_t GetDlogEventCount();
// capture the last DlogRecord message text so unit tests can assert log content
const char* GetLastDlogRecordMsg();
void ResetLastDlogRecordMsg();
// capture the last run-log event so later warning logs do not hide it in assertions
const char* GetLastDlogEventMsg();
void ResetLastDlogEventMsg();

#endif
