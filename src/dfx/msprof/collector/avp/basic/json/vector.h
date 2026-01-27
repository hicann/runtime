/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef BASE_JSON_VECTOR_H
#define BASE_JSON_VECTOR_H
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

#define NewVector(objType) CreateCVector(sizeof(objType))

// itemSize 不能为0，请调用者保证
void InitCVector(Vector *vector, size_t itemSize);
static inline void SetCVectorDestroyItem(Vector *vector, FnDestroy pfnDestroyItem)
{
    vector->pfnDestroyItem = pfnDestroyItem;
};
void DeInitCVector(Vector *vector);

// itemSize 不能为0，请调用者保证
Vector *CreateCVector(size_t itemSize);
void DestroyCVector(Vector *vector);
void ClearCVector(Vector *vector);
static inline size_t CVectorSize(const Vector *vector)
{
    return vector->size;
};
size_t ReSizeCVector(Vector *vector, size_t size);
size_t CapacityCVector(Vector *vector, size_t capacity);
void *EmplaceCVector(Vector *vector, size_t index, void *data);
void *EmplaceBackCVector(Vector *vector, void *data);
void *EmplaceHeadCVector(Vector *vector, void *data);
void RemoveCVector(Vector *vector, size_t index);
void MoveCVector(Vector *src, Vector *desc);
void *CVectorAt(Vector *vector, size_t index);
const void *ConstCVectorAt(const Vector *vector, size_t index);
#ifdef __cplusplus
}
#endif
#endif