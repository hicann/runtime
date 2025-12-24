/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

/**
 * @defgroup los_atomic Atomic
 * @ingroup kernel
 */

#ifndef _LOS_ATOMIC_H
#define _LOS_ATOMIC_H

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif /* __cplusplus */
#endif /* __cplusplus */
typedef signed long long   INT64;
typedef unsigned char      UINT8;
typedef unsigned short     UINT16;
typedef unsigned int       UINT32;
typedef signed char        INT8;
typedef signed short       INT16;
typedef signed int         INT32;
typedef float              FLOAT;
typedef double             DOUBLE;
typedef char               CHAR;
typedef UINT32             BOOL;
typedef volatile INT32     Atomic;
typedef volatile INT64     Atomic64;
#define STATIC             static
#define INLINE             inline

STATIC INLINE BOOL LOS_AtomicCmpXchg32bits(Atomic *v, INT32 val, INT32 oldVal)
{
    INT32 prevVal;
    prevVal = *v;
    if (*v == oldVal) {
        *v = val;
    }
    return (prevVal != oldVal);
}

STATIC INLINE INT32 LOS_AtomicRead(const Atomic *v)
{
    return *v;
}

STATIC INLINE void LOS_AtomicSet(Atomic *v, INT32 setVal)
{
    *v = setVal;
}

STATIC INLINE INT32 LOS_AtomicAdd(Atomic *v, INT32 addVal)
{
    *v += addVal;
    return *v;
}


#ifdef __cplusplus
#if __cplusplus
}
#endif /* __cplusplus */
#endif /* __cplusplus */

#endif /* _LOS_ATOMIC_H */
