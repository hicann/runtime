/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef C_BASE_VECTOR_H
#define C_BASE_VECTOR_H
#include "c_base.h"
#ifdef __cplusplus
extern "C" {
#endif
typedef struct {
    size_t itemSize;
    size_t size;
    size_t capacity;
    uint8_t *data;
    FnDestroy pfnDestroyItem;
} Vector;

#define NewVector(objType) CreateVector(sizeof(objType))

// itemSize 不能为0，请调用者保证
void InitVector(Vector *vector, size_t itemSize);
static inline void SetVectorDestroyItem(Vector *vector, FnDestroy pfnDestroyItem)
{
    vector->pfnDestroyItem = pfnDestroyItem;
};
void DeInitVector(Vector *vector);

// itemSize 不能为0，请调用者保证
Vector *CreateVector(size_t itemSize);
void DestroyVector(Vector *vector);
void ClearVector(Vector *vector);
static inline size_t VectorSize(const Vector *vector)
{
    return vector->size;
};
size_t ReSizeVector(Vector *vector, size_t size);
size_t CapacityVector(Vector *vector, size_t capacity);
void *EmplaceVector(Vector *vector, size_t index, void *data);
void *EmplaceBackVector(Vector *vector, void *data);
void *EmplaceHeadVector(Vector *vector, void *data);
void RemoveVector(Vector *vector, size_t index);
void MoveVector(Vector *src, Vector *desc);
void *VectorAt(Vector *vector, size_t index);
const void *ConstVectorAt(const Vector *vector, size_t index);
#ifdef __cplusplus
}
#endif
#endif // C_BASE_VECTOR_H