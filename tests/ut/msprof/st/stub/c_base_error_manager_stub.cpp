/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "msprof_stub.h"
#include "error_manager.h"

void ReportErrMessage(const char *errorCode, char *args[], char *argValues[], int32_t argsNum)
{
    MSPROF_LOGI("ReportErrMessage: error code: %s", errorCode);
}

void FormatReportInner(const char *errorCode, const char *fmt, ...)
{
    MSPROF_LOGI("FormatReportInner: error code: %s", errorCode);
}