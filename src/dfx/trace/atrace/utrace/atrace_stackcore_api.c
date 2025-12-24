/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "atrace_stackcore_api.h"
#ifdef ENABLE_SCD
#include "scd_process.h"
TraStatus AtraceStackcoreParse(const char *filePath, uint32_t len)
{
    return ScdProcessParseCore(filePath, len);
}

#else
#include "stacktrace_parse.h"
TraStatus AtraceStackcoreParse(const char *filePath, uint32_t len)
{
    return TraceStackParse(filePath, len);
}
#endif