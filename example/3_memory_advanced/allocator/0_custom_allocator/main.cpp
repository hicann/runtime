/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <algorithm>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include "acl/acl.h"
#include "acl/acl_rt_allocator.h"
#include "utils.h"

namespace {
struct CustomBlock { void *addr; size_t size; };
struct CustomAllocatorState { uint32_t allocCount; uint32_t freeCount; };

void *CustomAlloc(aclrtAllocator allocator, size_t size)
{
    auto *state = static_cast<CustomAllocatorState *>(allocator);
    auto *block = static_cast<CustomBlock *>(std::malloc(sizeof(CustomBlock)));
    if (block == nullptr) { return nullptr; }
    block->addr = std::malloc(size);
    if (block->addr == nullptr) { std::free(block); return nullptr; }
    block->size = size;
    if (state != nullptr) { ++state->allocCount; }
    INFO_LOG("CustomAlloc size=%zu", size);
    return block;
}

void CustomFree(aclrtAllocator allocator, aclrtAllocatorBlock block)
{
    auto *state = static_cast<CustomAllocatorState *>(allocator);
    auto *typedBlock = static_cast<CustomBlock *>(block);
    if (typedBlock != nullptr) { std::free(typedBlock->addr); std::free(typedBlock); }
    if (state != nullptr) { ++state->freeCount; }
    INFO_LOG("CustomFree invoked");
}

void *CustomAllocAdvise(aclrtAllocator allocator, size_t size, aclrtAllocatorAddr addr)
{
    (void)addr;
    INFO_LOG("CustomAllocAdvise size=%zu", size);
    return CustomAlloc(allocator, size);
}

void *CustomGetAddrFromBlock(aclrtAllocatorBlock block)
{
    auto *typedBlock = static_cast<CustomBlock *>(block);
    return typedBlock == nullptr ? nullptr : typedBlock->addr;
}
}
#define CHECK_NOT_NULL(ptr, name) do { if ((ptr) == nullptr) { ERROR_LOG("%s is nullptr", name); return -1; } } while (0)
int main()
{
    const int32_t deviceId = 0; aclrtContext context = nullptr; aclrtStream stream = nullptr; CustomAllocatorState state = {0, 0};
    CHECK_ERROR(aclInit(nullptr)); CHECK_ERROR(aclrtSetDevice(deviceId)); CHECK_ERROR(aclrtCreateContext(&context, deviceId)); CHECK_ERROR(aclrtCreateStream(&stream));
    aclrtAllocatorDesc desc = aclrtAllocatorCreateDesc(); CHECK_NOT_NULL(desc, "aclrtAllocatorCreateDesc");
    CHECK_ERROR(aclrtAllocatorSetObjToDesc(desc, reinterpret_cast<aclrtAllocator>(&state))); CHECK_ERROR(aclrtAllocatorSetAllocFuncToDesc(desc, CustomAlloc)); CHECK_ERROR(aclrtAllocatorSetFreeFuncToDesc(desc, CustomFree)); CHECK_ERROR(aclrtAllocatorSetAllocAdviseFuncToDesc(desc, CustomAllocAdvise)); CHECK_ERROR(aclrtAllocatorSetGetAddrFromBlockFuncToDesc(desc, CustomGetAddrFromBlock));
    CHECK_ERROR(aclrtAllocatorRegister(stream, desc));
    aclrtAllocatorDesc descOut = nullptr; aclrtAllocator allocatorOut = nullptr; aclrtAllocatorAllocFunc allocFunc = nullptr; aclrtAllocatorFreeFunc freeFunc = nullptr; aclrtAllocatorAllocAdviseFunc allocAdviseFunc = nullptr; aclrtAllocatorGetAddrFromBlockFunc getAddrFunc = nullptr;
    CHECK_ERROR(aclrtAllocatorGetByStream(stream, &descOut, &allocatorOut, &allocFunc, &freeFunc, &allocAdviseFunc, &getAddrFunc)); CHECK_NOT_NULL(allocFunc, "allocFunc"); CHECK_NOT_NULL(freeFunc, "freeFunc"); CHECK_NOT_NULL(getAddrFunc, "getAddrFunc");
    aclrtAllocatorBlock block = allocFunc(allocatorOut, 256); CHECK_NOT_NULL(block, "Custom block"); void *addr = getAddrFunc(block); CHECK_NOT_NULL(addr, "Custom block addr"); std::fill_n(static_cast<unsigned char *>(addr), 256, static_cast<unsigned char>(0xAB));
    aclrtAllocatorBlock advisedBlock = nullptr; if (allocAdviseFunc != nullptr) { advisedBlock = allocAdviseFunc(allocatorOut, 128, nullptr); if (advisedBlock != nullptr) { freeFunc(allocatorOut, advisedBlock); } }
    freeFunc(allocatorOut, block); INFO_LOG("Allocator desc queried: descOut=%p allocCount=%u freeCount=%u", descOut, state.allocCount, state.freeCount);
    CHECK_ERROR(aclrtAllocatorUnregister(stream)); CHECK_ERROR(aclrtAllocatorDestroyDesc(desc)); CHECK_ERROR(aclrtDestroyStream(stream)); CHECK_ERROR(aclrtDestroyContext(context)); CHECK_ERROR(aclrtResetDeviceForce(deviceId)); CHECK_ERROR(aclFinalize()); return 0;
}