/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef C_BASE_REF_OBJ_H
#define C_BASE_REF_OBJ_H
#include "c_base.h"
#include "mmpa_api.h"
#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    mmAtomicType64 refCount;
    void *obj;
} RefObj;

typedef void* (*FnCreateRefObjValue)(RefObj *);
typedef void* (*FnCreateRefObjValueWithUserData)(RefObj *, const void *);
typedef void (*FnDestroyRefObjValue)(RefObj *);

#define REF_OBJ_INIT {0, NULL}
void InitRefObj(RefObj *obj);
static inline void* GetRefObjVal(RefObj *obj)
{
    return obj->obj;
};
void* GetObjRef(RefObj *obj, FnCreateRefObjValue fnCreateObj);
void* GetObjRefWithUserData(RefObj *obj, const void *userData, FnCreateRefObjValueWithUserData fnCreateObj);
// 为了避免fnDestroyObj里面释放RefObj场景的，obj->obj的指针赋空的动作由fnDestroyObj函数执行保证
void ReleaseObjRef(RefObj *obj, FnDestroyRefObjValue fnDestroyObj);

#ifdef __cplusplus
}
#endif
#endif // C_BASE_REF_OBJ_H