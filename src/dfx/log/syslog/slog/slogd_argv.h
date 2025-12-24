/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SLOGD_ARGV_H
#define SLOGD_ARGV_H

#include <stdbool.h>
#include "log_error_code.h"

#ifdef __cplusplus
extern "C" {
#endif


struct SlogdOptions {
    int32_t n; // 1: run in foreground; 0: run in background
    int32_t l;
    int32_t v; // -1: pf; 32-63: vf
    bool d; // true: run in docker; false: not in docker
};

LogStatus SlogdInitArgs(int32_t argc, char **argv, struct SlogdOptions *opt);

#ifdef __cplusplus
}
#endif
#endif

