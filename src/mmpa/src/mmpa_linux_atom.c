/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "mmpa_api.h"

#ifdef __cplusplus
#if    __cplusplus
extern "C" {
#endif /* __cpluscplus */
#endif /* __cpluscplus */

/*
 * 描述:原子操作的设置某个值
 * 参数: ptr指针指向需要修改的值, value是需要设置的值
 * 返回值:执行成功返回设置为value后的值，入参错误返回EN_INVALID_PARAM
 */
mmAtomicType mmSetData(mmAtomicType *ptr, mmAtomicType value)
{
    if (ptr == NULL) {
        return EN_INVALID_PARAM;
    }
    mmAtomicType ret = __sync_lock_test_and_set(ptr, value);
    return ret;
}

/*
 * 描述:原子操作的加法
 * 参数: ptr指针指向需要修改的值, value是需要加的值
 * 返回值:执行成功返回加上value后的值，入参错误返回EN_INVALID_PARAM
 */
mmAtomicType mmValueInc(mmAtomicType *ptr, mmAtomicType value)
{
    if (ptr == NULL) {
        return EN_INVALID_PARAM;
    }
    mmAtomicType ret = __sync_add_and_fetch(ptr, value);
    return ret;
}

/*
 * 描述:原子操作的减法
 * 参数: ptr指针指向需要修改的值, value是需要减的值
 * 返回值:执行成功返回减去value后的值，入参错误返回EN_INVALID_PARAM
 */
mmAtomicType mmValueSub(mmAtomicType *ptr, mmAtomicType value)
{
    if (ptr == NULL) {
        return EN_INVALID_PARAM;
    }
    mmAtomicType ret = __sync_sub_and_fetch(ptr, value);
    return ret;
}

/*
 * 描述:原子操作的设置某个值
 * 参数: ptr指针指向需要修改的值, value是需要设置的值
 * 返回值:执行成功返回设置为value后的值，入参错误返回EN_INVALID_PARAM
 */
mmAtomicType64 mmSetData64(mmAtomicType64 *ptr, mmAtomicType64 value)
{
    if (ptr == NULL) {
        return EN_INVALID_PARAM;
    }
    mmAtomicType64 ret = __sync_lock_test_and_set(ptr, value);
    return ret;
}

/*
 * 描述:原子操作的加法
 * 参数: ptr指针指向需要修改的值, value是需要加的值
 * 返回值:执行成功返回加上value后的值，入参错误返回EN_INVALID_PARAM
 */
mmAtomicType64 mmValueInc64(mmAtomicType64 *ptr, mmAtomicType64 value)
{
    if (ptr == NULL) {
        return EN_INVALID_PARAM;
    }
    mmAtomicType64 ret = __sync_add_and_fetch(ptr, value);
    return ret;
}

/*
 * 描述:原子操作的减法
 * 参数: ptr指针指向需要修改的值, value是需要减的值
 * 返回值:执行成功返回减去value后的值，入参错误返回EN_INVALID_PARAM
 */
mmAtomicType64 mmValueSub64(mmAtomicType64 *ptr, mmAtomicType64 value)
{
    if (ptr == NULL) {
        return EN_INVALID_PARAM;
    }
    mmAtomicType64 ret = __sync_sub_and_fetch(ptr, value);
    return ret;
}

#ifdef __cplusplus
#if __cplusplus
}
#endif /* __cpluscplus */
#endif /* __cpluscplus */

