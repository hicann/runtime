/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_NPU_DRIVER_BASE_SOMA_HPP
#define CCE_RUNTIME_NPU_DRIVER_BASE_SOMA_HPP

#include "driver/ascend_hal_base.h"
#include "driver/ascend_hal_error.h"

extern "C" {
drvError_t __attribute__((weak)) halMemPoolCreate(soma_mem_pool_t pool, soma_mem_pool_prop* prop);
drvError_t __attribute__((weak)) halMemPoolDestroy(soma_mem_pool_t pool);
drvError_t __attribute__((weak)) halMemPoolSetAttr(soma_mem_pool_t pool, soma_mem_pool_attr attr, void* value);
drvError_t __attribute__((weak)) halMemPoolGetAttr(soma_mem_pool_t pool, soma_mem_pool_attr attr, void* value);
drvError_t __attribute__((weak)) halMemPoolMalloc(soma_mem_pool_t pool, uint64_t va, uint64_t size, int32_t policy);
drvError_t __attribute__((weak)) halMemPoolFree(soma_mem_pool_t pool, uint64_t va, uint64_t size, int32_t policy);
drvError_t __attribute__((weak))
halMemPoolTrim(soma_mem_pool_t pool, uint64_t* size, uint64_t poolUsedSize, uint64_t poolFreeSize);
drvError_t __attribute__((weak))
halMemPoolAsyncConfig(soma_mem_pool_t pool, uint64_t va, uint64_t size, halMemPoolConfig_t config);
};

#endif // CCE_RUNTIME_NPU_DRIVER_BASE_SOMA_HPP