/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TRACE_LIST_H
#define TRACE_LIST_H

#include "adiag_list_def.h"
#include "adiag_lock.h"
#include "adiag_types.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

struct AdiagListNode {
    struct ListHead list;
    void *data;
};

struct AdiagList {
    struct ListHead list;
    uint32_t cnt;
    AdiagLock lock;
    bool valid;
};

typedef AdiagStatus (*AdiagListCmpFunc)(const void *, const void *);
typedef AdiagStatus (*AdiagListTraverseFunc)(void *, void *);
typedef AdiagStatus (*AdiagListElemFunc)(void *);

AdiagStatus AdiagListInit(struct AdiagList *traList);
AdiagStatus AdiagListDestroy(struct AdiagList *traList);
AdiagStatus AdiagListInsert(struct AdiagList *traList, void *data);
void *AdiagListTakeOut(struct AdiagList *traList);
void AdiagListForEachNolock(struct AdiagList *traList, const AdiagListCmpFunc func, const void *arg);
void AdiagListForEachTraverse(struct AdiagList *traList, const AdiagListTraverseFunc func, void *arg);
void *AdiagListForEach(struct AdiagList *traList, const AdiagListCmpFunc func, const void *arg);
void *AdiagListGetNode(struct AdiagList *traList, const void *data);
AdiagStatus AdiagListRemove(struct AdiagList *traceList, void *data);
AdiagStatus AdiagListRemoveAll(struct AdiagList *traceList, void *data, const AdiagListElemFunc func);
void AdiagListMove(struct AdiagList *oldList, struct AdiagList *newList);
AdiagStatus AdiagListClearAndProcessNoLock(struct AdiagList *traceList, const AdiagListCmpFunc cmpFunc, const void *arg,
    const AdiagListElemFunc otherFunc);

#ifdef __cplusplus
}
#endif // __cplusplus

#endif // TRACE_LIST_H

