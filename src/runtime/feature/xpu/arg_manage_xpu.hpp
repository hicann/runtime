/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_ARG_MANAGE_XPU_HPP__
#define __CCE_RUNTIME_ARG_MANAGE_XPU_HPP__

#include <mutex>
#include "task_info.hpp"
#include "stars_arg_manager.hpp"

namespace cce {
namespace runtime {

class XpuStream;

constexpr uint32_t XPU_ARG_POOL_COPY_SIZE = 4096U;

class XpuArgManage : public StarsArgManager {
public:
    using StarsArgManager::StarsArgManager;
    explicit XpuArgManage(Stream* const stm) : StarsArgManager(stm) {}

    ~XpuArgManage() override;

    void RecycleDevLoader(void * const handle) override;
    bool CreateArgRes() override;
    void ReleaseArgRes() override;
    void FreeArgMem() override;
    rtError_t H2DArgCopy(const StarsArgLoaderResult* const result, void* const args, const uint32_t size) override;

    rtError_t MallocArgMem(void *&devAddr, void *&hostAddr) override;
    bool AllocStmPool(const uint32_t size, StarsArgLoaderResult* const result) override;
    rtError_t AllocCopyPtr(
        const uint32_t size, const bool useArgPool, LoadPolicy policy, StarsArgLoaderResult* const result) override;
    rtError_t LoadArgsFromArray(
        const bool useArgPool, const Kernel* kernel, void** argsArray, StarsArgLoaderResult* result) override;
    rtError_t LoadSimtArgsFromArray(
        const bool useArgPool, const Kernel* kernel, SimtArgsArray* simtArgsArray,
        StarsArgLoaderResult* result) override;
    rtError_t LoadSimtHostArgs(
        const bool useArgPool, SimtArgsHost* simtArgsHost, StarsArgLoaderResult* result) override;
};

}  // namespace runtime
}  // namespace cce
#endif