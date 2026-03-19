/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_SOMA_HPP
#define CCE_RUNTIME_SOMA_HPP
#include "stream_mem_pool.hpp"

namespace cce {
namespace runtime {

class SomaApi {
public:
    static rtError_t CreateMemPool(rtMemPoolProps &poolProps, size_t totalSize, SegmentManager *&retMemPool);
    static rtError_t CheckMemPool(SegmentManager *memPool);
    static rtError_t DestroyMemPool(SegmentManager *memPool);
    static rtError_t AllocFromMemPool(void **ptr, uint64_t size, rtMemPool_t memPool, int32_t streamId);
 	static rtError_t FreeToMemPool(void *ptr);
    static rtError_t StreamMemPoolCreate(rtMemPool_t *memPool, const rtMemPoolProps *poolProps);
    static rtError_t StreamMemPoolDestroy(const rtMemPool_t memPool);
    static rtError_t StreamMemPoolSetAttr(rtMemPool_t memPool, rtMemPoolAttr attr, void *value);
    static rtError_t StreamMemPoolGetAttr(rtMemPool_t memPool, rtMemPoolAttr attr, void *value);
    static SegmentManager* FindMemPoolByPtr(void *ptr);
};


}  // namespace runtime
}  // namespace cce
#endif  // CCE_RUNTIME_SOMA_HPP