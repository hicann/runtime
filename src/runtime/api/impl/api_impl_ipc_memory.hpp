/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_API_IMPL_IPC_MEMORY_HPP
#define CCE_RUNTIME_API_IMPL_IPC_MEMORY_HPP

#include "api_ipc_memory.hpp"

namespace cce {
namespace runtime {

class ApiImplIpcMemory : public ApiIpcMemory {
public:
    rtError_t IpcSetMemoryName(
        const void* const ptr, const uint64_t byteCount, char_t* const name, const uint32_t len,
        const uint64_t flags) override;
    rtError_t IpcOpenMemory(void** const ptr, const char_t* const name, const uint64_t flags) override;
    rtError_t IpcCloseMemory(const void* const ptr) override;
    rtError_t IpcCloseMemoryByName(const char_t* const name) override;
    rtError_t IpcDestroyMemoryName(const char_t* const name) override;
    rtError_t SetIpcMemPid(const char_t* const name, int32_t pid[], const int32_t num) override;
    rtError_t ShmemSetPodPid(const char* const name, const uint32_t sdid, int32_t pid[], const int32_t num) override;
};

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_API_IMPL_IPC_MEMORY_HPP
