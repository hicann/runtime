/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_API_SOMA_HPP
#define CCE_RUNTIME_API_SOMA_HPP
 
#include "runtime/rt.h"
#include "base.hpp"
#include "runtime.hpp"
#include "event.hpp"
#include "model.hpp"
#include "label.hpp"
#include "api.hpp"
 
namespace cce {
namespace runtime {
 
// Runtime interface
class ApiSoma {
public:
    ApiSoma() = default;
    virtual ~ApiSoma() = default;
 
    ApiSoma(const ApiSoma &) = delete;
    ApiSoma &operator=(const ApiSoma &) = delete;
    ApiSoma(ApiSoma &&) = delete;
    ApiSoma &operator=(ApiSoma &&) = delete;
 
    // Get ApiSoma instance.
    static ApiSoma *Instance();
 
    // SOMA API
    virtual rtError_t StreamMemPoolCreate(rtMemPool_t *memPool, const rtMemPoolProps *poolProps) = 0;
    virtual rtError_t StreamMemPoolDestroy(const rtMemPool_t memPool) = 0;
    virtual rtError_t StreamMemPoolSetAttr(rtMemPool_t memPool, rtMemPoolAttr attr, void *value) = 0;
    virtual rtError_t StreamMemPoolGetAttr(rtMemPool_t memPool, rtMemPoolAttr attr, void *value) = 0;
    virtual rtError_t MemPoolMallocAsync(void **devPtr, const uint64_t size, const rtMemPool_t memPoolId, Stream * const exeStream) = 0;
 	virtual rtError_t MemPoolFreeAsync(void * const ptr, Stream * const stm) = 0;
 
};
}  // namespace runtime
}  // namespace cce
 
 
#endif  // CCE_RUNTIME_API_SOMA_HPP