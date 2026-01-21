/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mem_pool.h"
#include "mmpa_api.h"
#ifdef __cplusplus
extern "C" {
#endif

void InitMemPoolWithCSingleList(MemPool *pool, size_t memSize)
{
    InitCSingleList(&pool->idleList);
    pool->memSize = memSize;
    pool->updating = 0;
    pool->seq = 0;
    pool->reuseMemFlag = false;
}

void DeInitMemPoolWithCSingleList(MemPool *pool)
{
    CSingleListNode *curNode;
    CSingleListNode *nextNode;
    while (!mmCompareAndSwap64(&pool->updating, 0, 1)) {
    }
    CSingleListForEach(&pool->idleList, curNode, nextNode) {
        RemoveCSingleListNode(&pool->idleList, curNode);
        MemNode *memNode = GET_MAIN_BY_MEMBER(curNode, MemNode, node);
        mmFree(memNode);
    }
    mmSetData64(&pool->updating, 0);
}

void* MemPoolAllocWithCSingleList(MemPool *pool)
{
    MemNode *memNode = NULL;
    while (!mmCompareAndSwap64(&pool->updating, 0, 1)) {
    }
    if (IsSingleListEmpty(&pool->idleList)) {
        memNode = (MemNode*)mmMalloc(sizeof(MemNode) + pool->memSize);
    } else {
        memNode = GET_MAIN_BY_MEMBER(GetSingleListHead(&pool->idleList), MemNode, node);
        RemoveCSingleListHead(&pool->idleList);
    }
    if (memNode != NULL) {
        memNode->flag = MEM_POOL_NODE_USED_FLAG | (((uint64_t)pool->seq) << MEM_POOL_NODE_SEQ_BITNUM);
        pool->seq++;
    }
    mmSetData64(&pool->updating, 0);
    return (void*)((memNode == NULL) ? NULL : memNode->data);
}

void MemPoolFreeWithCSingleList(MemPool *pool, void *mem, FnDestroy pfnDestroy)
{
    if (mem == NULL) {
        return;
    }

    MemNode *memNode = GET_MAIN_BY_MEMBER(mem, MemNode, data);
    if (memNode == NULL) {
        return;
    }

    mmAtomicType64 flag = memNode->flag;
    if ((flag & MEM_POOL_NODE_USED_FLAG) != MEM_POOL_NODE_USED_FLAG) {
        return;
    }
    if (mmCompareAndSwap64(&memNode->flag, flag, MEM_POOL_NODE_IDLE_FLAG)) {
        if (pfnDestroy != NULL) {
            pfnDestroy(mem);
        }
        while (!mmCompareAndSwap64(&pool->updating, 0, 1)) {
        }
        if (GetMemPoolReuseFlag(pool)) {
            InsertCSingleListTail(&pool->idleList, &memNode->node);
        } else {
            // No insert to IDEL list, free memNode immediately
            mmFree(memNode);
            memNode = NULL;
        }
        mmSetData64(&pool->updating, 0);
    }
    return;
}

bool GetMemPoolReuseFlag(MemPool *pool)
{
    return (pool->reuseMemFlag);
}

#ifdef __cplusplus
}
#endif