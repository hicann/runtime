/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "cstl_list.h"
#include "osal/osal_mem.h"
#include "logger/logger.h"

static inline bool CstlRawListNodeInList(const CstlListNode *node)
{
    bool ret = false;
    if ((node->next != NULL) && (node->prev != NULL) &&
        ((const CstlListNode *)(node->next->prev) == node) &&
        ((const CstlListNode *)(node->prev->next) == node)) {
        ret = true;
    }

    return ret;
}

int32_t CstlListInit(CstlList *list, CstlFreeFunc freeFunc)
{
    if (list != NULL) {
        list->head.next = &list->head;
        list->head.prev = &list->head;
        list->size = 0;
        list->freeFunc = freeFunc;
        return CSTL_OK;
    }

    return CSTL_ERR;
}

bool CstlListEmpty(CstlList *list)
{
    if (list != NULL) {
        if (list->size == 0) { // list not init, default size is 0
            return true;
        }
        return (&list->head)->next == &list->head;
    }

    return false;
}

static inline void CstlListRemoveNode(CstlList *list, CstlListNode *node)
{
    if ((node == NULL) || !CstlRawListNodeInList(node)) {
        return;
    }

    node->prev->next = node->next;
    node->next->prev = node->prev;
    if (list->freeFunc != NULL) { // Free object like reader and uploader
        list->freeFunc((void *)node->userdata);
    }

    OSAL_MEM_FREE(node);
    list->size--;
}

int32_t CstlListClear(CstlList *list)
{
    if (list == NULL) {
        return CSTL_ERR;
    }

    while (!CstlListEmpty(list)) {
        CstlListRemoveNode(list, list->head.next);
    }

    return CSTL_OK;
}

int32_t CstlListDeinit(CstlList *list)
{
    if (list == NULL) {
        return CSTL_ERR;
    }

    int32_t ret = CstlListClear(list);
    list->freeFunc = NULL;
    return ret;
}

int32_t CstlListPushBack(CstlList *list, uintptr_t userData)
{
    if (list != NULL) {
        CstlListNode *node = (CstlListNode *)OsalCalloc(sizeof(CstlListNode));
        if (node == NULL) {
            return CSTL_ERR;
        }
        node->userdata = userData;
        node->next = &list->head;
        node->prev = list->head.prev;
        list->head.prev->next = node;
        list->head.prev = node;
        list->size++;
        return CSTL_OK;
    }

    return CSTL_ERR;
}

uintptr_t CstlListIterData(const CstlListIterator it)
{
    if (it != NULL) {
        return it->userdata;
    }

    return 0;
}

CstlListIterator CstlListIterFind(CstlList *list, CstlKeyCmpFunc iterCmpFunc, uintptr_t data)
{
    CstlListNode *ans = NULL;
    CstlListNode *node = NULL;
    if ((list != NULL) && (iterCmpFunc != NULL)) {
        node = list->head.next;
        if (node == NULL) {
            return ans;
        }
        while ((const CstlListNode *)node != &list->head) {
            if (iterCmpFunc(node->userdata, data) == CSTL_OK) {
                ans = node;
                break;
            }
            node = node->next;
        }
    }

    return ans;
}