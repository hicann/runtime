/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef RUNTIME_ACL_RT_IMPL_H_
#define RUNTIME_ACL_RT_IMPL_H_

#include <stdint.h>
#include <stddef.h>
#include <cstdarg>
#include "acl/acl_rt.h"
#include "acl/acl.h"
#include "acl/acl_base.h"
#include "acl/acl_rt_allocator.h"
#include "acl_rt_wrapper.h"

#ifdef __cplusplus
extern "C" {
#endif

// MACRO expand and declare ACL RT Impl functions
ACL_FUNC_MAP(ACL_RT_IMPL_HEADER)

ACL_RT_FUNC_MAP(ACL_RT_IMPL_HEADER)

ACL_MDLRI_FUNC_MAP(ACL_RT_IMPL_HEADER)

ACL_MDL_FUNC_MAP(ACL_RT_IMPL_HEADER)

ACL_RT_ALLOCATOR_FUNC_MAP(ACL_RT_IMPL_HEADER)

ACL_FUNC_VISIBILITY void aclAppLogImpl(
    aclLogLevel logLevel, const char* func, const char* file, uint32_t line, const char* fmt, va_list args);

#ifdef __cplusplus
}
#endif

#endif // RUNTIME_ACL_RT_IMPL_H_
