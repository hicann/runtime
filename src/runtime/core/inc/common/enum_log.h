/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_ENUM_LOG_H
#define CCE_RUNTIME_ENUM_LOG_H

#if defined(TINY_COMPILE)
#undef RUNTIME_ENABLE_ENUM_LOG_NAMES
#define RUNTIME_ENABLE_ENUM_LOG_NAMES 0
#endif

#ifndef RUNTIME_ENABLE_ENUM_LOG_NAMES
#define RUNTIME_ENABLE_ENUM_LOG_NAMES 1
#endif

#if (RUNTIME_ENABLE_ENUM_LOG_NAMES != 0) && (RUNTIME_ENABLE_ENUM_LOG_NAMES != 1)
#error "RUNTIME_ENABLE_ENUM_LOG_NAMES must be 0 or 1"
#endif

#include "runtime/base.h"

#endif // CCE_RUNTIME_ENUM_LOG_H
