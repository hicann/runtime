/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ref_obj.h"

#ifdef __cplusplus
extern "C" {
#endif

#define REF_OBJ_UPDATING 0x8000000000000000UL
#define TRY_LOOP_MAX 0x80000000UL

typedef struct {
    int step;
    uint64_t oldValTrigger;
} RefObjUpdate;

void InitRefObj(RefObj *obj)
{
    obj->refCount = 0;
    obj->obj = NULL;
}

static bool ObjRefCount(RefObj *obj, const RefObjUpdate *update,
    void(*pfnHook)(RefObj *, const void *, void *), void *appInfo, const void *usrData)
{
    uint64_t oldVal;
    uint64_t newVal;
    uint64_t tryCount = 0UL;
    uint64_t perSchedYield = 0x3FFU;
    do {
        tryCount++;
        if ((tryCount & perSchedYield) == 0U) {
            (void)mmSchedYield();
        }
        oldVal = obj->refCount;
        if ((oldVal & REF_OBJ_UPDATING) != 0) {
            continue;
        }
        // 防溢出
        if (((update->step < 0) && (oldVal < (uint64_t)(0L - update->step))) ||
            ((update->step > 0) && (oldVal >= REF_OBJ_UPDATING - update->step))) {
            return false;
        }
        newVal = (oldVal == update->oldValTrigger) ? REF_OBJ_UPDATING : (oldVal + update->step);
        if (mmCompareAndSwap64(&obj->refCount, oldVal, newVal)) {
            if (oldVal == update->oldValTrigger) {
                pfnHook(obj, usrData, appInfo);
            }
            return true;
        }
    } while (tryCount < TRY_LOOP_MAX);
    return false;
}

static void CreateRefObjVal(RefObj *obj, const void *userData, void *fnCreateObj)
{
    (void)userData;
    obj->obj = ((FnCreateRefObjValue)fnCreateObj)(obj);
    mmSetData64(&obj->refCount, 1);
}

static void CreateRefObjValWithUserData(RefObj *obj, const void *userData, void *fnCreateObj)
{
    obj->obj = ((FnCreateRefObjValueWithUserData)fnCreateObj)(obj, userData);
    mmSetData64(&obj->refCount, 1);
}

static void DestroyRefObjVal(RefObj *obj, const void *userData, void *fnDestroyObj)
{
    (void)userData;
    mmSetData64(&obj->refCount, 0);
    if (fnDestroyObj != NULL) {
        ((FnDestroyRefObjValue)fnDestroyObj)(obj);
    }
}

void* GetObjRef(RefObj *obj, FnCreateRefObjValue fnCreateObj)
{
    RefObjUpdate update = {1, 0};
    if (!ObjRefCount(obj, &update, CreateRefObjVal, fnCreateObj, NULL)) {
        return NULL;
    }
    if (obj->obj == NULL) {
        ReleaseObjRef(obj, NULL);
    }
    return obj->obj;
}

void* GetObjRefWithUserData(RefObj *obj, const void *userData, FnCreateRefObjValueWithUserData fnCreateObj)
{
    RefObjUpdate update = {1, 0};
    if (!ObjRefCount(obj, &update, CreateRefObjValWithUserData, fnCreateObj, userData)) {
        return NULL;
    }
    if (obj->obj == NULL) {
        ReleaseObjRef(obj, NULL);
    }
    return obj->obj;
}

void ReleaseObjRef(RefObj *obj, FnDestroyRefObjValue fnDestroyObj)
{
    RefObjUpdate update = {-1, 1};
    (void)ObjRefCount(obj, &update, DestroyRefObjVal, fnDestroyObj, NULL);
}

#ifdef __cplusplus
}
#endif