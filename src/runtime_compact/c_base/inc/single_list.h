/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef C_BASE_SINGLE_LIST_H
#define C_BASE_SINGLE_LIST_H
#include "c_base.h"
#ifdef __cplusplus
extern "C" {
#endif
typedef struct CSingleListNode {
    struct CSingleListNode *next;
} CSingleListNode;

typedef struct {
    CSingleListNode *head;
    CSingleListNode *tail;
} CSingleList;

/**
 * You can use this macro to initialize the linked list while defining it,
 *  or use the function InitCSingleList to initialize it before use
 */
#define CSINGLE_LIST_INIT {NULL, NULL}
#define CSingleListNext(curNode) ((curNode) != NULL) ? (curNode)->next : NULL

/**
 * Through this macro, the traversal of the linked list can be realized.
 *  The user needs to define the loop variables curNode, nextNode,
 *  and the loop variable does not need to be initialized.
 */
#define CSingleListForEach(list, curNode, nextNode)                                          \
    for ((curNode) = (list)->head, (nextNode) = CSingleListNext(curNode); (curNode) != NULL; \
         (curNode) = (nextNode), (nextNode) = CSingleListNext(nextNode))

static inline void InitCSingleList(CSingleList *list)
{
    list->head = NULL;
    list->tail = NULL;
}

static inline bool IsSingleListEmpty(CSingleList *list)
{
    return list->head == NULL;
}

static inline CSingleListNode* GetSingleListHead(CSingleList *list)
{
    return list->head;
}

static inline void InsertCSingleListHead(CSingleList *list, CSingleListNode *insertNode)
{
    insertNode->next = list->head;
    list->head = insertNode;
    if (list->tail == NULL) {
        list->tail = insertNode;
    }
}

static inline void InsertCSingleListTail(CSingleList *list, CSingleListNode *insertNode)
{
    insertNode->next = NULL;
    if (list->tail == NULL) {
        list->head = insertNode;
    } else {
        list->tail->next = insertNode;
    }
    list->tail = insertNode;
}

static inline void InsertCSingleList(CSingleList *list, CSingleListNode *listNode, CSingleListNode *insertNode)
{
    insertNode->next = listNode->next;
    listNode->next = insertNode;
    if (list->tail == listNode) {
        list->tail = insertNode;
    }
}

static inline void RemoveCSingleListNode(CSingleList *list, CSingleListNode *listNode)
{
    CSingleListNode *curNode;
    CSingleListNode *nextNode;
    CSingleListNode *preNode = NULL;
    CSingleListForEach(list, curNode, nextNode) {
        if (curNode != listNode) {
            preNode = curNode;
            continue;
        }

        if (preNode == NULL) {
            list->head = nextNode;
            if (list->head == NULL) {
                list->tail = NULL;
            }
        } else {
            preNode->next = curNode->next;
            if (nextNode == NULL) {
                list->tail = preNode;
            }
        }
    }
}

static inline void RemoveCSingleListHead(CSingleList *list)
{
    RemoveCSingleListNode(list, list->head);
}

static inline void RemoveCSingleListTail(CSingleList *list)
{
    RemoveCSingleListNode(list, list->tail);
}
#ifdef __cplusplus
}
#endif
#endif // C_BASE_SINGLE_LIST_H