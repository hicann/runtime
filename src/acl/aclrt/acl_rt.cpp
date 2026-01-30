/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstdarg>
#include "set_device_vxx.h"
#include "acl_rt_impl.h"

ACL_FUNC_MAP(ACL_RT_CPP)

ACL_RT_FUNC_MAP(ACL_RT_CPP)

ACL_MDLRI_FUNC_MAP(ACL_RT_CPP)

ACL_MDL_FUNC_MAP(ACL_RT_CPP)

ACL_RT_ALLOCATOR_FUNC_MAP(ACL_RT_CPP)

void aclAppLog(aclLogLevel logLevel, const char *func, const char *file, uint32_t line, const char *fmt, ...)
{
    va_list args;
    va_start(args, fmt);
    aclAppLogImpl(logLevel, func, file, line, fmt, args);
    va_end(args);
}

extern "C" ACL_FUNC_VISIBILITY void aclAppLogWithArgs(aclLogLevel logLevel, const char *func, const char *file, uint32_t line, const char *fmt, va_list args)
{
    aclAppLogImpl(logLevel, func, file, line, fmt, args);
}
