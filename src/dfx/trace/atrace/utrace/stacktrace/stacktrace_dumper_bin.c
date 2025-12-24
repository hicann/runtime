/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <stdint.h>
#include <string.h>
#include "adiag_print.h"
#include "stacktrace_parse.h"

#define ASC_DUMPER_ARGC 2

#if defined (_ADIAG_LLT_) || defined (ENABLE_SCD)
int32_t StacktraceDumperMain(int32_t argc, const char *argv[]);
int32_t StacktraceDumperMain(int32_t argc, const char *argv[])
#else
int32_t main(int32_t argc, const char *argv[])
#endif
{
    if (argc != ASC_DUMPER_ARGC) {
        ADIAG_WAR("input args is invalid, argc=%d", argc);
        return 1;
    }

    const char *binPath = argv[1];
    return TraceStackParse(binPath, (uint32_t)strlen(binPath));
}