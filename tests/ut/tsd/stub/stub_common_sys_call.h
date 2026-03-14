/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __INC_STUB_COMMON_SYS_CALL_H
#define __INC_STUB_COMMON_SYS_CALL_H

#include <sys/types.h>

#ifdef __cplusplus
extern "C" {
#endif

void *stub_dlopen_success(const char *filename, int flags);
int stub_dlclose_success(void *handle);
void *stub_dlsym_start_app_success(void *handle, const char *symbol);
#ifdef __cplusplus
}
#endif

#endif