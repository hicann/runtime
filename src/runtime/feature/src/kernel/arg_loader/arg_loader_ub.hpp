/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_ARG_LOADER_UB_HPP__
#define __CCE_RUNTIME_ARG_LOADER_UB_HPP__

#include "driver.hpp"
#include "runtime.hpp"
#include "h2d_copy_mgr.hpp"

namespace cce {
namespace runtime {
class Device;
class Stream;

struct DavidArgLoaderResult {
    void *kerArgs;      // dev addr
    void *hostAddr;     // used for ub
    void *handle;       // used for dev arg pool & dynamic alloc
    uint32_t stmArgPos; // used for stm arg pool
    void *devTsegInfo;
    void *hostTsegInfo;
};

struct UbHandle {
    void *kerArgs;              // dev addr
    void *hostAddr;             // host addr
    H2DCopyMgr *argsAlloc;      // res allocator, used for dev arg pool
    struct memTsegInfo *memTsegInfo;
};

constexpr uint32_t UB_ARG_MAX_ENTRY_SIZE = 4096U;
constexpr uint32_t UB_ARG_MAX_SUPER_ENTRY_SIZE = 16384U;
constexpr uint32_t UB_ARG_INIT_CNT = 1024U;
constexpr uint32_t UB_ARG_SUPER_INIT_CNT = 128U;

constexpr uint32_t DAVID_ARG_ADDR_ALIGN_LEN = 8U;
constexpr uint32_t DAVID_ARG_ADDR_ALIGN_BIT = 3U;

class UbArgLoader : public NoCopy {
public:
    explicit UbArgLoader(Device * const dev);
    ~UbArgLoader() override;
    rtError_t Init();
    rtError_t Release(void * const argHandle);
    rtError_t AllocCopyPtr(const uint32_t size, DavidArgLoaderResult * const result);
protected:
    Device* device_;

private:
    H2DCopyMgr* argAllocator_;
    H2DCopyMgr* superArgAllocator_;

    BufferAllocator* handleAllocator_;

    void ReleaseDevArgPool(UbHandle * const argHandle);
    rtError_t AllocDevArgPool(const uint32_t size, UbHandle * const argHandle, void **devTsegInfo,
        void **hostTsegInfo);
    void ReleaseDynamic(UbHandle * const argHandle);
    rtError_t AllocDynamic(const uint32_t size, UbHandle * const argHandle, void **devTsegInfo,
        void **hostTsegInfo);
};

}
}
#endif  // __CCE_RUNTIME_ARG_LOADER_UB_HPP__
