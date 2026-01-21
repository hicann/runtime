/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef C_BASE_C_BASE_H
#define C_BASE_C_BASE_H
#include <stdint.h>
#include <stdlib.h>
#include <stdbool.h>
#if defined(__cplusplus)
extern "C" {
#endif

#define SUCCESS 0

typedef void (*FnDestroy)(void *);

#define MEMBER_OFFSET(mainType, memberName) ((uintptr_t)(void *)(&(((mainType *)0)->memberName)))
#define GET_MAIN_BY_MEMBER(memberAddr, mainType, memberName) \
    ((mainType *)(void *)((uintptr_t)(void *)(memberAddr)-MEMBER_OFFSET(mainType, memberName)))

#if defined(__cplusplus)
}
#endif

#endif // C_BASE_C_BASE_H