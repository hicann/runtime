/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef C_BASE_MEM_POOL_H
#define C_BASE_MEM_POOL_H
#include <stdio.h>
#include "single_list.h"
#include "mmpa_api.h"
#ifdef __cplusplus
extern "C" {
#endif

#define MEM_POOL_NODE_SEQ_BITNUM 32
#define MEM_POOL_NODE_IDLE_FLAG 0xCADAEA00UL
#define MEM_POOL_NODE_USED_FLAG 0xCADAEA01UL

typedef struct {
    CSingleList idleList;
    size_t memSize;
    mmAtomicType64 updating;
    uint32_t seq;
    bool reuseMemFlag;
} MemPool;

typedef struct {
    mmAtomicType64 flag;
    CSingleListNode node;
    uint8_t data[0];
} MemNode;

#define MEM_POOL_INIT(memSize) {CSINGLE_LIST_INIT, (memSize), 0, 0, false}
void InitMemPoolWithCSingleList(MemPool *pool, size_t memSize);
void DeInitMemPoolWithCSingleList(MemPool *pool);
void* MemPoolAllocWithCSingleList(MemPool *pool);
void MemPoolFreeWithCSingleList(MemPool *pool, void *mem, FnDestroy pfnDestroy);
bool GetMemPoolReuseFlag(MemPool *pool);

static inline bool MemPoolMemUsed(void *mem)
{
    MemNode *memNode = GET_MAIN_BY_MEMBER(mem, MemNode, data);
    return ((memNode->flag & MEM_POOL_NODE_USED_FLAG) == MEM_POOL_NODE_USED_FLAG);
}

static inline uint32_t GetMemPoolMemSeq(void *mem)
{
    MemNode *memNode = GET_MAIN_BY_MEMBER(mem, MemNode, data);
    return (uint32_t)(memNode->flag >> MEM_POOL_NODE_SEQ_BITNUM);
}

static inline bool MemPoolMemMatchSeq(void *mem, uint32_t seq)
{
    MemNode *memNode = GET_MAIN_BY_MEMBER(mem, MemNode, data);
    return (memNode->flag == (MEM_POOL_NODE_USED_FLAG | (((uint64_t)seq) << MEM_POOL_NODE_SEQ_BITNUM)));
}
#ifdef __cplusplus
}
#endif
#endif // C_BASE_MEM_POOL_H