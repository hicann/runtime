/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef C_BASE_SORT_VECTOR_H
#define C_BASE_SORT_VECTOR_H
#include "c_base.h"
#include "binary_search.h"
#include "vector.h"
#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    void *appInfo;
    FnBinaryCompare fnCmp;
    Vector vector;
} SortVector;

#define NewSortVector(objType, pfnCmp, appInfo) CreateSortVector(sizeof(objType), pfnCmp, appInfo)

// itemSize 不能为0，请调用者保证
// appInfo 该参数只会透传给pfnCmp使用，为空是否合法由调用者自己判断
void InitSortVector(SortVector *sortVector, size_t itemSize, FnBinaryCompare pfnCmp, void *appInfo);
static inline void SetSortVectorDestroyItem(SortVector *sortVector, FnDestroy pfnDestroyItem)
{
    SetVectorDestroyItem(&sortVector->vector, pfnDestroyItem);
}
void DeInitSortVector(SortVector *vector);

// itemSize 不能为0，请调用者保证
SortVector *CreateSortVector(size_t itemSize, FnBinaryCompare pfnCmp, void *appInfo);
void DestroySortVector(SortVector *sortVector);
size_t CapacitySortVector(SortVector *sortVector, size_t capacity);
static inline size_t SortVectorSize(SortVector *sortVector)
{
    return VectorSize(&sortVector->vector);
};
void *SortVectorAt(SortVector *sortVector, size_t index);
size_t FindSortVector(SortVector *sortVector, void *key);
void *SortVectorAtKey(SortVector *sortVector, void *key);
void *EmplaceSortVector(SortVector *sortVector, void *data);
void RemoveSortVector(SortVector *sortVector, size_t index);
#ifdef __cplusplus
}
#endif
#endif // C_BASE_SORT_VECTOR_H