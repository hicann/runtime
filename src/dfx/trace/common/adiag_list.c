/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "adiag_list.h"
#include "adiag_print.h"
#include "adiag_utils.h"

/**
 * @brief       init circular double linked lists
 * @param [in]  traList: list holder ptr
 * @return      AdiagStatus
 */
AdiagStatus AdiagListInit(struct AdiagList *traList)
{
    AdiagStatus ret = ADIAG_FAILURE;
    if (traList != NULL) {
        INIT_LIST_HEAD(&traList->list);
        traList->cnt = 0;
        ret = AdiagLockInit(&traList->lock);
        traList->valid = ((ret == ADIAG_SUCCESS) ? true : false);
    }

    return ret;
}

/**
 * @brief       destroy circular doubly linked lists
 * @param [in]  traList:    list ptr to be destroyed
 * @return      AdiagStatus
 */
AdiagStatus AdiagListDestroy(struct AdiagList *traList)
{
    AdiagStatus ret = ADIAG_SUCCESS;

    if ((traList != NULL) && (traList->valid == true)) {
        void *data = AdiagListTakeOut(traList);
        while (data != NULL) {
            ADIAG_SAFE_FREE(data);
            data = AdiagListTakeOut(traList);
        }

        ret = AdiagLockDestroy(&traList->lock);
    }

    return ret;
}

/**
 * @brief       insert new node into list
 * @param [in]  traList:    list ptr
 * @param [in]  data:       data to be inserted into list
 * @return      AdiagStatus
 */
AdiagStatus AdiagListInsert(struct AdiagList *traList, void *data)
{
    ADIAG_CHK_NULL_PTR(traList, return ADIAG_FAILURE);
    ADIAG_CHK_NULL_PTR(data, return ADIAG_FAILURE);

    struct AdiagListNode *node = AdiagMalloc(sizeof(struct AdiagListNode));
    if (node == NULL) {
        ADIAG_ERR("malloc list node failed.");
        return ADIAG_FAILURE;
    }

    INIT_LIST_HEAD(&node->list);
    node->data = data;

    (void)AdiagLockGet(&traList->lock);
    if (traList->cnt < (UINT32_MAX - 1U)) {
        ListAddBeforeEntry(&node->list, &traList->list);
        traList->cnt++;
        (void)AdiagLockRelease(&traList->lock);
        return ADIAG_SUCCESS;
    } else {
        AdiagFree(node);
        node = NULL;
        (void)AdiagLockRelease(&traList->lock);
        return ADIAG_FAILURE;
    }
}

/**
 * @brief       take out oldest node in list and return node data
 * @param [in]  traList:    list ptr
 * @return      data ptr which has been taken out
 */
void *AdiagListTakeOut(struct AdiagList *traList)
{
    ADIAG_CHK_NULL_PTR(traList, return NULL);

    void *data = NULL;
    struct AdiagListNode *node = NULL;
    (void)AdiagLockGet(&traList->lock);
    if (!ListEmpty(&traList->list)) {
        node = LIST_FIRST_ENTRY(&traList->list, struct AdiagListNode, list);
        if (node != NULL) {
            ListDelEntry(&node->list);
            traList->cnt--;
            data = node->data;
        }
    }
    (void)AdiagLockRelease(&traList->lock);

    ADIAG_SAFE_FREE(node);
    return (void *)data;
}
/**
 * @brief       apply specified function on every node.
 * @param [in]  traList:    list ptr
 * @param [in]  func:       function to be applied
 * @param [in]  arg:        extra argument for function
 * @return      NA
 */
void AdiagListForEachTraverse(struct AdiagList *traList, const AdiagListTraverseFunc func, void *arg)
{
    if ((traList == NULL) || (func == NULL)) {
        return;
    }

    struct AdiagListNode *pos = NULL;
    (void)AdiagLockGet(&traList->lock);
    LIST_FOR_EACH_ENTRY(pos, &traList->list, struct AdiagListNode, list) {
        (void)func(pos->data, arg);
    }
    (void)AdiagLockRelease(&traList->lock);
}

/**
 * @brief       apply specified function on every node in list without lock.
 * @param [in]  traList:    list ptr
 * @param [in]  func:       function to be applied
 * @param [in]  arg:        extra argument for function
 * @return      NA
 */
void AdiagListForEachNolock(struct AdiagList *traList, const AdiagListCmpFunc func, const void *arg)
{
    if ((traList == NULL) || (func == NULL)) {
        return;
    }

    const struct AdiagListNode *pos = NULL;

    LIST_FOR_EACH_ENTRY(pos, &traList->list, struct AdiagListNode, list) {
        (void)func(pos->data, arg);
    }
}

STATIC INLINE AdiagStatus AdiagListCmpData(const void *nodeData, const void *data)
{
    if (nodeData == data) {
        return ADIAG_SUCCESS;
    }
    return ADIAG_FAILURE;
}

void *AdiagListGetNode(struct AdiagList *traList, const void *data)
{
    return AdiagListForEach(traList, AdiagListCmpData, data);
}

/**
 * @brief apply specified function on every node in list.
 *        return first data that let function return true
 * @param [in]  traList: list ptr
 * @param [in]  func: function to be applied
 * @param [in]  arg: extra argument for function
 * @return  data which let function return true
 */
void *AdiagListForEach(struct AdiagList *traList, const AdiagListCmpFunc func, const void *arg)
{
    const struct AdiagListNode *pos = NULL;
    void *data = NULL;
    ADIAG_CHK_NULL_PTR(traList, return NULL);
    ADIAG_CHK_NULL_PTR(func, return NULL);
    
    (void)AdiagLockGet(&traList->lock);
    LIST_FOR_EACH_ENTRY(pos, &traList->list, struct AdiagListNode, list) {
        if (func(pos->data, arg) == ADIAG_SUCCESS) {
            data = pos->data;
            break;
        }
    }
    (void)AdiagLockRelease(&traList->lock);
    return (void *)data;
}

/**
 * @brief remove the node that has specified data in list, break if found one
 * @param [in]  traceList: list ptr
 * @param [in]  data: data to be removed
 * @return  0 on success, otherwise -1.
 */
AdiagStatus AdiagListRemove(struct AdiagList *traceList, void *data)
{
    AdiagStatus ret = ADIAG_FAILURE;
    struct AdiagListNode *node = NULL;
    struct ListHead *pos = NULL;

    ADIAG_CHK_NULL_PTR(traceList, return ADIAG_FAILURE);
    ADIAG_CHK_NULL_PTR(data, return ADIAG_FAILURE);

    (void)AdiagLockGet(&traceList->lock);
    if (!ListEmpty(&traceList->list)) {
        LIST_FOR_EACH(pos, &traceList->list) {
            node = LIST_ENTRY(pos, struct AdiagListNode, list);
            if ((node != NULL) && (node->data == data)) {
                ListDelEntry(pos);
                traceList->cnt--;
                AdiagFree(node);
                node = NULL;
                ret = ADIAG_SUCCESS;
                break;
            }
        }
    }
    (void)AdiagLockRelease(&traceList->lock);

    return ret;
}

/**
 * @brief remove all the node that has specified data in list
 * @param [in]  traceList: list ptr
 * @param [in]  data: data to be removed
 * @return  0 on success, otherwise -1.
 */
AdiagStatus AdiagListRemoveAll(struct AdiagList *traceList, void *data, const AdiagListElemFunc func)
{
    AdiagStatus ret = ADIAG_FAILURE;
    struct AdiagListNode *node = NULL;
    struct ListHead *pos = NULL;
    struct ListHead *tmp = NULL;

    ADIAG_CHK_NULL_PTR(traceList, return ADIAG_FAILURE);
    ADIAG_CHK_NULL_PTR(data, return ADIAG_FAILURE);

    (void)AdiagLockGet(&traceList->lock);
    if (!ListEmpty(&traceList->list)) {
        LIST_FOR_EACH(pos, &traceList->list) {
            node = LIST_ENTRY(pos, struct AdiagListNode, list);
            if ((node != NULL) && (node->data == data)) {
                tmp = pos->next;
                ListDelEntry(pos);
                traceList->cnt--;
                if (func != NULL) {
                    func(node->data);
                }
                AdiagFree(node);
                node = NULL;
                ret = ADIAG_SUCCESS;
                pos = tmp->prev;
            }
        }
    }
    (void)AdiagLockRelease(&traceList->lock);

    return ret;
}

/**
 * @brief move from oldList to new List
 * @param [in]  oldList: old list to be move from
 * @param [in]  newList: new list to be move to
 * @return  NA
 */
void AdiagListMove(struct AdiagList *oldList, struct AdiagList *newList)
{
    void *data = NULL;
    do {
        data = AdiagListTakeOut(oldList);
        if (data == NULL) {
            break;
        }
        (void)AdiagListInsert(newList, data);
    } while (true);
}

/**
 * @brief clear all the node that match cmpFunc and do otherFunc if not match
 * @param [in]  traceList: list ptr
 * @param [in]  cmpFunc: compare function to check if remove or not
 * @param [in]  arg: argument of compare function
 * @param [in]  otherFunc: function do if no need to remove

 * @return  0 on success, otherwise -1.
 */
AdiagStatus AdiagListClearAndProcessNoLock(struct AdiagList *traceList, const AdiagListCmpFunc cmpFunc, const void *arg,
    const AdiagListElemFunc otherFunc)
{
    AdiagStatus ret = ADIAG_FAILURE;
    struct AdiagListNode *node = NULL;
    struct ListHead *pos = NULL;
    struct ListHead *tmp = NULL;
    void *data = NULL;

    ADIAG_CHK_NULL_PTR(traceList, return ADIAG_FAILURE);

    if (!ListEmpty(&traceList->list)) {
        LIST_FOR_EACH(pos, &traceList->list) {
            node = LIST_ENTRY(pos, struct AdiagListNode, list);
            if (node == NULL) {
                continue;
            }
            if (cmpFunc(node->data, arg) == ADIAG_SUCCESS) {
                tmp = pos->next;
                ListDelEntry(pos);
                traceList->cnt--;
                data = (void *)node->data;
                pos = tmp->prev;
                ADIAG_SAFE_FREE(node);
                ADIAG_SAFE_FREE(data);
                ret = ADIAG_SUCCESS;
            } else if (otherFunc != NULL) {
                otherFunc(node->data);
            } else {
                ;
            }
        }
    }

    return ret;
}