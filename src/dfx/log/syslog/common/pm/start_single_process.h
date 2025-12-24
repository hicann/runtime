/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef START_SINGLE_PROCESS_H
#define START_SINGLE_PROCESS_H 1
#include "log_error_code.h"
#include "log_system_api.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    int fd;
    int cmd;
    int type;
    off_t offset;
    int whence;
    off_t len;
} LockRegParams;

// File lock, Just start a process
LogStatus JustStartAProcess(const char *file);
// File lock, end
void SingleResourceCleanup(const char *file);

#ifdef __cplusplus
}
#endif
#endif