/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef C_BASE_BINARY_SEARCH_H
#define C_BASE_BINARY_SEARCH_H
#include "c_base.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef void *(*FnBinaryGet)(void *appInfo, size_t id);
typedef int (*FnBinaryCompare)(void *a, void *b, void *appInfo);

static inline int BinarySearchClosest(
    void *appInfo, size_t size, void *key, FnBinaryGet fnBinaryGet, FnBinaryCompare fnComp, size_t *closestIndex)
{
    if (size == 0) {
        *closestIndex = 0;
        return -1;
    }

    size_t left = 0;
    size_t right = size - 1;
    size_t mid;
    int compRet = 0;
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
            right = mid - 1;
        } else {
            *closestIndex = mid;
            return 0;
        }
    }
    *closestIndex = mid;
    return compRet;
};

#ifdef __cplusplus
}
#endif
#endif // C_BASE_BINARY_SEARCH_H