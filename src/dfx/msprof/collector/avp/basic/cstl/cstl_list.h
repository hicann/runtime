/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef BASIC_CSTL_CSTL_LIST_H
#define BASIC_CSTL_CSTL_LIST_H

#include <stdio.h>
#include "cstl_public.h"

#ifdef __cplusplus
extern "C" {
#endif
typedef struct TagCstlListNode {
    struct TagCstlListNode *prev;
    struct TagCstlListNode *next;
    uintptr_t userdata;
} CstlListNode;

typedef struct {
    size_t size;
    CstlListNode head;
    CstlFreeFunc freeFunc;
} CstlList;

typedef CstlListNode* CstlListIterator;
typedef int32_t (*CstlKeyCmpFunc)(uintptr_t key1, uintptr_t key2);
typedef void (*CstlFreeFunc)(void *ptr);
int32_t CstlListInit(CstlList *list, CstlFreeFunc freeFunc);
int32_t CstlListDeinit(CstlList *list);
bool CstlListEmpty(CstlList *list);
int32_t CstlListClear(CstlList *list);
int32_t CstlListPushBack(CstlList *list, uintptr_t userData);
uintptr_t CstlListIterData(const CstlListIterator it);
CstlListIterator  CstlListIterFind(CstlList *list, CstlKeyCmpFunc iterCmpFunc, uintptr_t data);
#ifdef __cplusplus
}
#endif
#endif /* BASIC_CSTL_CSTL_LIST_H */