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
 * 描述:创建一个内存屏障
 */
VOID mmMb(VOID)
{
    __asm__ __volatile__ ("" : : : "memory");
}

/*
 * 描述： 申请和内存页对齐的内存
 * 参数： mallocSize--申请内存大小
 *        alignSize--内存对齐的大小
 * 返回值：成功执行时，返回内存地址；失败返回NULL
 */
VOID *mmAlignMalloc(mmSize mallocSize, mmSize alignSize)
{
    return memalign(alignSize, mallocSize);
}

/*
 * 描述： 释放内存页对齐的内存
 * 参数： addr--内存地址
 */
VOID mmAlignFree(VOID *addr)
{
    if (addr != NULL) {
        free(addr);
    }
}

#ifdef __cplusplus
#if __cplusplus
}
#endif /* __cpluscplus */
#endif /* __cpluscplus */

