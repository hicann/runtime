/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "securec.h"
#include "binary_search.h"
#include "vector.h"
#include "mmpa_api.h"
#include "sort_vector.h"
#ifdef __cplusplus
extern "C" {
#endif

static int DefaultCmpFunc(void *a, void *b, void *appInfo)
{
    SortVector *sortVector = (SortVector *)appInfo;
    return memcmp(a, b, sortVector->vector.itemSize);
}

void InitSortVector(SortVector *sortVector, size_t itemSize, FnBinaryCompare pfnCmp, void *appInfo)
{
    InitVector(&sortVector->vector, itemSize);
    if (pfnCmp != NULL) {
        sortVector->fnCmp = pfnCmp;
        sortVector->appInfo = appInfo;
    } else {
        sortVector->fnCmp = DefaultCmpFunc;
        sortVector->appInfo = sortVector;
    }
}

void DeInitSortVector(SortVector *vector)
{
    DeInitVector(&vector->vector);
}

SortVector *CreateSortVector(size_t itemSize, FnBinaryCompare pfnCmp, void *appInfo)
{
    SortVector *sortVector = (SortVector *)mmMalloc(sizeof(SortVector));
    if (sortVector == NULL) {
        return NULL;
    }
    InitSortVector(sortVector, itemSize, pfnCmp, appInfo);
    return sortVector;
}

void DestroySortVector(SortVector *sortVector)
{
    DeInitSortVector(sortVector);
    mmFree(sortVector);
}

size_t CapacitySortVector(SortVector *sortVector, size_t capacity)
{
    return CapacityVector(&sortVector->vector, capacity);
}

void *SortVectorAt(SortVector *sortVector, size_t index)
{
    return VectorAt(&sortVector->vector, index);
}

static int SortVectorBinaryCmp(void *a, void *b, void *appInfo)
{
    SortVector *sortVector = (SortVector *)appInfo;
    return sortVector->fnCmp(a, b, sortVector->appInfo);
}

static void *SortVectorGet(void *appInfo, size_t index)
{
    return SortVectorAt((SortVector *)appInfo, index);
}

static int FindSortVectorClosest(SortVector *sortVector, void *key, size_t *closestIndex)
{
    return BinarySearchClosest(
        sortVector, VectorSize(&sortVector->vector), key, SortVectorGet, SortVectorBinaryCmp, closestIndex);
}

size_t FindSortVector(SortVector *sortVector, void *key)
{
    size_t index;
    int cmpRst = FindSortVectorClosest(sortVector, key, &index);
    return (cmpRst == 0) ? index : SortVectorSize(sortVector);
}

void *SortVectorAtKey(SortVector *sortVector, void *key)
{
    return VectorAt(&sortVector->vector, FindSortVector(sortVector, key));
}

void *EmplaceSortVector(SortVector *sortVector, void *data)
{
    size_t index;
    int cmpRst = FindSortVectorClosest(sortVector, data, &index);
    if (cmpRst == 0) {
        size_t size = sortVector->vector.itemSize;
        void *keyData = VectorAt(&sortVector->vector, index);
        errno_t ret = memcpy_s(keyData, size, data, size);
        if (ret != EOK) {
            return NULL;
        }
        return keyData;
    }

    if (cmpRst > 0) {
        index++;
    }
    return EmplaceVector(&sortVector->vector, index, data);
}

void RemoveSortVector(SortVector *sortVector, size_t index)
{
    RemoveVector(&sortVector->vector, index);
    return;
}
#ifdef __cplusplus
}
#endif