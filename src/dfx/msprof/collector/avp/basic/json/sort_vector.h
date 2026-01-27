/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef BASE_JSON_SORT_VECTOR_H
#define BASE_JSON_SORT_VECTOR_H
#include "c_base.h"
#include "vector.h"
#ifdef __cplusplus
extern "C" {
#endif

typedef void *(*FnBinaryGet)(void *appInfo, size_t id);
typedef int32_t (*FnBinaryCompare)(void *a, void *b, void *appInfo);

typedef struct {
    void *appInfo;
    FnBinaryCompare fnCmp;
    Vector vector;
} SortVector;

#define NewSortVector(objType, pfnCmp, appInfo) CreateCSortVector(sizeof(objType), pfnCmp, appInfo)

// itemSize 不能为0，请调用者保证
// appInfo 该参数只会透传给pfnCmp使用，为空是否合法由调用者自己判断
void InitCSortVector(SortVector *sortVector, size_t itemSize, FnBinaryCompare pfnCmp, void *appInfo);
static inline void SetCSortVectorDestroyItem(SortVector *sortVector, FnDestroy pfnDestroyItem)
{
    SetCVectorDestroyItem(&sortVector->vector, pfnDestroyItem);
}
void DeInitCSortVector(SortVector *vector);

// itemSize 不能为0，请调用者保证
SortVector *CreateCSortVector(size_t itemSize, FnBinaryCompare pfnCmp, void *appInfo);
void DestroyCSortVector(SortVector *sortVector);
size_t CapacityCSortVector(SortVector *sortVector, size_t capacity);
static inline size_t CSortVectorSize(SortVector *sortVector)
{
    return CVectorSize(&sortVector->vector);
};
void *CSortVectorAt(SortVector *sortVector, size_t index);
size_t FindCSortVector(SortVector *sortVector, void *key);
void *CSortVectorAtKey(SortVector *sortVector, void *key);
void *EmplaceCSortVector(SortVector *sortVector, void *data);
void RemoveCSortVector(SortVector *sortVector, size_t index);
#ifdef __cplusplus
}
#endif
#endif