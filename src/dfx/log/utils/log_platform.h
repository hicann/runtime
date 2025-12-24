/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef LOG_PLATFORM_H
#define LOG_PLATFORM_H

#ifndef WIN
#define WIN 1
#endif

#ifndef LINUX
#define LINUX 0
#endif

#ifndef OS_TYPE_DEF
#define OS_TYPE_DEF LINUX
#endif

#if defined _LOG_UT_ || defined __IDE_UT || OS_TYPE_DEF == WIN
#define STATIC
#define INLINE
#define CONSTRUCTOR
#define DESTRUCTOR
#else
#define STATIC static
#define INLINE inline
#define CONSTRUCTOR __attribute__((constructor))
#define DESTRUCTOR __attribute__((destructor))
#endif

#endif
