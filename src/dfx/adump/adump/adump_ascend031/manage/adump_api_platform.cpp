/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <atomic>
#include "adump_api.h"
#include "dump_manager.h"

namespace Adx {
uint64_t g_chunk[RING_CHUNK_SIZE + MAX_TENSOR_NUM] = {0};
namespace {
std::atomic<uint64_t> g_writeIdx{0};
uint32_t g_atomicIndex = 0x2000;
}  // namespace

void *AdumpGetSizeInfoAddr(uint32_t space, uint32_t &atomicIndex)
{
    if (space > MAX_TENSOR_NUM) {
        return nullptr;
    }

    atomicIndex = g_atomicIndex++;
    auto nextWriteCursor = g_writeIdx.fetch_add(space);
    return g_chunk + (nextWriteCursor % RING_CHUNK_SIZE);
}

int32_t AdumpRegisterCallback(uint32_t moduleId, AdumpCallback enableFunc, AdumpCallback disableFunc)
{
    return DumpManager::Instance().RegisterCallback(moduleId, enableFunc, disableFunc);
}
}  // namespace Adx