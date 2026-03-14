/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stub_common_sys_call.h"

int32_t g_addr = 0;

void *stub_dlopen_success(const char *filename, int flags)
{
    return &g_addr;
}

int stub_dlclose_success(void *handle)
{
    return 0;
}

int32_t stub_start_app_success(const char *appName, const size_t nameLen, const int32_t timeout)
{
    return 0;
}

void *stub_dlsym_start_app_success(void *handle, const char *symbol)
{
    return reinterpret_cast<void*>(stub_start_app_success);
}