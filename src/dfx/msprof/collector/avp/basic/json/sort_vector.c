/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "sort_vector.h"
#include <securec.h>
#include "vector.h"
#include "osal/osal_mem.h"
#ifdef __cplusplus
extern "C" {
#endif

static int32_t DefaultCmpFunc(void *a, void *b, void *appInfo)
{
    SortVector *sortVector = (SortVector *)appInfo;
    return memcmp(a, b, sortVector->vector.itemSize);
}

void InitCSortVector(SortVector *sortVector, size_t itemSize, FnBinaryCompare pfnCmp, void *appInfo)
{
    InitCVector(&sortVector->vector, itemSize);
    if (pfnCmp != NULL) {
        sortVector->fnCmp = pfnCmp;
        sortVector->appInfo = appInfo;
    } else {
        sortVector->fnCmp = DefaultCmpFunc;
        sortVector->appInfo = sortVector;
    }
}

void DeInitCSortVector(SortVector *vector)
{
    DeInitCVector(&vector->vector);
}

SortVector *CreateCSortVector(size_t itemSize, FnBinaryCompare pfnCmp, void *appInfo)
{
    SortVector *sortVector = (SortVector *)OsalMalloc(sizeof(SortVector));
    if (sortVector == NULL) {
        return NULL;
    }
    InitCSortVector(sortVector, itemSize, pfnCmp, appInfo);
    return sortVector;
}

void DestroyCSortVector(SortVector *sortVector)
{
    DeInitCSortVector(sortVector);
    OsalFree(sortVector);
}

size_t CapacityCSortVector(SortVector *sortVector, size_t capacity)
{
    return CapacityCVector(&sortVector->vector, capacity);
}

void *CSortVectorAt(SortVector *sortVector, size_t index)
{
    return CVectorAt(&sortVector->vector, index);
}

static int32_t SortVectorBinaryCmp(void *a, void *b, void *appInfo)
{
    SortVector *sortVector = (SortVector *)appInfo;
    return sortVector->fnCmp(a, b, sortVector->appInfo);
}

static void *SortVectorGet(void *appInfo, size_t index)
{
    return CSortVectorAt((SortVector *)appInfo, index);
}

static int32_t BinarySearchClosest(
    void *appInfo, size_t size, void *key, FnBinaryGet fnBinaryGet, FnBinaryCompare fnComp, size_t *closestIndex)
{
    if (size == 0) {
        *closestIndex = 0;
        return -1;
    }

    size_t left = 0;
    size_t right = size - 1U;
    size_t mid;
    int32_t compRet = 0;
    while (left <= right) {
        mid = (left + right) >> 1;
        void *midData = fnBinaryGet(appInfo, mid);
        compRet = fnComp(key, midData, appInfo);
        if (compRet > 0) {
            left = mid + 1;
        } else if (compRet < 0) {
            if (mid == 0) {
                break;
            }
            right = mid - 1U;
        } else {
            *closestIndex = mid;
            return 0;
        }
    }
    *closestIndex = mid;
    return compRet;
}

static int32_t FindSortVectorClosest(SortVector *sortVector, void *key, size_t *closestIndex)
{
    return BinarySearchClosest(
        sortVector, CVectorSize(&sortVector->vector), key, SortVectorGet, SortVectorBinaryCmp, closestIndex);
}

size_t FindCSortVector(SortVector *sortVector, void *key)
{
    size_t index;
    int32_t cmpRst = FindSortVectorClosest(sortVector, key, &index);
    return (cmpRst == 0) ? index : CSortVectorSize(sortVector);
}

void *CSortVectorAtKey(SortVector *sortVector, void *key)
{
    return CVectorAt(&sortVector->vector, FindCSortVector(sortVector, key));
}

void *EmplaceCSortVector(SortVector *sortVector, void *data)
{
    size_t index;
    int32_t cmpRst = FindSortVectorClosest(sortVector, data, &index);
    if (cmpRst == 0) {
        size_t size = sortVector->vector.itemSize;
        void *keyData = CVectorAt(&sortVector->vector, index);
        errno_t ret = memcpy_s(keyData, size, data, size);
        if (ret != EOK) {
            return NULL;
        }
        return keyData;
    }

    if (cmpRst > 0) {
        index++;
    }
    return EmplaceCVector(&sortVector->vector, index, data);
}

void RemoveCSortVector(SortVector *sortVector, size_t index)
{
    RemoveCVector(&sortVector->vector, index);
    return;
}
#ifdef __cplusplus
}
#endif