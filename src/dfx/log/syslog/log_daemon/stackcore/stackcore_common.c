/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stackcore_common.h"
#ifdef STACKCORE_DEBUG
void StackSysLog(int32_t priority, const char *format, ...)
{
    va_list args;
    va_start(args, format);
    vsyslog(priority, format, args);
    va_end(args);
}
#endif
/*
 * @brief: get system error code
 * @return error code;
 */
int32_t ToolGetErrorCode(void)
{
    return (int32_t)errno;
}

uint32_t LogStrlen(const char *str)
{
    size_t len = strlen(str);
    if (len > UINT32_MAX) {
        return UINT32_MAX;
    }
    return (uint32_t)len;
}