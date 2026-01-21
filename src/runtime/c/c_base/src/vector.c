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
#include "mmpa_api.h"
#include "vector.h"
#ifdef __cplusplus
extern "C" {
#endif
#define VECTOR_BASIC_SIZE 0
#define VECTOR_BASIC_STEP 8
#define VECTOR_MAX_AREA 0x80000000U

void InitVector(Vector *vector, size_t itemSize)
{
    vector->itemSize = itemSize;
    vector->size = 0;
    vector->capacity = 0;
    vector->data = NULL;
    vector->pfnDestroyItem = NULL;
}

void ClearVector(Vector *vector)
{
    if (vector->pfnDestroyItem != NULL) {
        for (size_t i = 0; i < vector->size; i++) {
            vector->pfnDestroyItem(VectorAt(vector, i));
        }
    }
    vector->size = 0;
}

void DeInitVector(Vector *vector)
{
    ClearVector(vector);
    if (vector->data != NULL) {
        mmFree(vector->data);
    }
    InitVector(vector, 0);
}

Vector *CreateVector(size_t itemSize)
{
    Vector *vector = (Vector *)mmMalloc(sizeof(Vector));
    if (vector == NULL) {
        return NULL;
    }
    InitVector(vector, itemSize);
    return vector;
}

void DestroyVector(Vector *vector)
{
    DeInitVector(vector);
    mmFree(vector);
}

void MoveVector(Vector *src, Vector *desc)
{
    desc->capacity = src->capacity;
    desc->data = src->data;
    desc->itemSize = src->itemSize;
    desc->pfnDestroyItem = src->pfnDestroyItem;
    desc->size = src->size;
    InitVector(src, 0);
}

size_t CapacityVector(Vector *vector, size_t capacity)
{
    if (vector->capacity >= capacity) {
        return vector->capacity;
    }

    size_t maxCapacity = VECTOR_MAX_AREA / vector->itemSize;
    if (vector->capacity >= maxCapacity) {
        return vector->capacity;
    }

    size_t validCapacity = (capacity >= maxCapacity) ? maxCapacity : capacity;
    size_t areaSize = validCapacity * vector->itemSize;
    uint8_t *data = (uint8_t *)mmMalloc(areaSize);
    if (data == NULL) {
        return vector->capacity;
    }

    if ((vector->data != NULL) && (vector->size != 0) && (vector->itemSize != 0)) {
        errno_t ret = memcpy_s(data, areaSize, vector->data, vector->itemSize * vector->size);
        if (ret != 0) {
            mmFree(data);
            return vector->capacity;
        }
        mmFree(vector->data);
    }

    vector->data = data;
    vector->capacity = validCapacity;
    return validCapacity;
}

size_t ReSizeVector(Vector *vector, size_t size)
{
    if (size > vector->capacity) {
        (void)CapacityVector(vector, size);
        if (size > vector->capacity) {
            return vector->size;
        }
    }

    if (size > vector->size) {
        vector->size = size;
    }
    return vector->size;
}

void *EmplaceVector(Vector *vector, size_t index, void *data)
{
    if (vector->size == vector->capacity) {
        size_t capacity =
            CapacityVector(vector, ((vector->capacity + VECTOR_BASIC_STEP) / VECTOR_BASIC_STEP) * VECTOR_BASIC_STEP);
        if (capacity <= vector->size) {
            return NULL;
        }
    }

    if (index > vector->size) {
        return NULL;
    }

    uint8_t *itemData = vector->data + (index * vector->itemSize);
    errno_t ret;
    if (index < vector->size) {
        size_t mvArea = (vector->size - index) * vector->itemSize;
        ret = memmove_s(itemData + vector->itemSize, mvArea, itemData, mvArea);
        if (ret != 0) {
            return NULL;
        }
    }
    ret = memcpy_s(itemData, vector->itemSize, data, vector->itemSize);
    if (ret != 0) {
        return NULL;
    }
    vector->size++;
    return itemData;
}

void *EmplaceBackVector(Vector *vector, void *data)
{
    return EmplaceVector(vector, vector->size, data);
}

void *EmplaceHeadVector(Vector *vector, void *data)
{
    return EmplaceVector(vector, 0, data);
}

void RemoveVector(Vector *vector, size_t index)
{
    if (index >= vector->size) {
        return;
    }

    uint8_t *itemData = vector->data + (index * vector->itemSize);
    if (vector->pfnDestroyItem != NULL) {
        vector->pfnDestroyItem(itemData);
    }

    if ((index + 1) < vector->size) {
        size_t mvArea = (vector->size - index - 1) * vector->itemSize;
        errno_t ret = memmove_s(itemData, mvArea, itemData + vector->itemSize, mvArea);
        if (ret != 0) {
            return;
        }
    }

    vector->size--;
    // free memory when no data
    if ((vector->size == 0) && (vector->capacity != 0)) {
         mmFree(vector->data);
         vector->data = NULL;
         vector->capacity = 0;
    }
    return;
}

void *VectorAt(Vector *vector, size_t index)
{
    if (index >= vector->size) {
        return NULL;
    }
    return vector->data + (index * vector->itemSize);
}

const void *ConstVectorAt(const Vector *vector, size_t index)
{
    if (index >= vector->size) {
        return NULL;
    }
    return vector->data + (index * vector->itemSize);
}

#ifdef __cplusplus
}
#endif