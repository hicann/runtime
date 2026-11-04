/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_DEV_INFO_H
#define CCE_RUNTIME_DEV_INFO_H
#include <cstddef>
#include <cstdint>

#include "runtime/base.h"
#include "runtime/mem.h"
#include "soc/soc_define.hpp"

namespace cce {
namespace runtime {
struct RtIniAttributes {
    uint32_t normalStreamNum = 0U;       // ini SoCInfo.normal_stream_num
    uint32_t normalStreamDepth = 0U;     // ini SoCInfo.normal_stream_depth
    uint32_t hugeStreamNum = 0U;         // ini SoCInfo.huge_stream_num
    uint32_t hugeStreamDepth = 0U;       // ini SoCInfo.huge_stream_depth
    int64_t npuArch = 0;                 // ini version.NpuArch, 0 means invalid or uninitialized
    uint32_t ioDieNum = 0U;              // ini SoCInfo.io_die_num
    uint32_t modelScheduleSoftware = 0U; // ini SoCInfo.model_schedule_software, only 1 means enabled
};

class Stream;
class Device;
struct DevProperties;
struct rtD2DAddrCfgInfo_t;

rtError_t RegCCManagerProcFunc(const rtChipType_t chipType);

using DEV_PROPS_UPDATE_FUNC = void (*)(DevProperties&);
using DEV_RAS_PRE_CHECK_FUNC = bool (*)(uint32_t devId);
using REG_CC_FEATURE_PROC_FUNC = rtError_t (*)(rtChipType_t);
using MEMCPY_ASYNC_FUNC = rtError_t (*)(
    void*, uint64_t, const void*, uint64_t, rtMemcpyKind_t, Stream*, const rtTaskCfgInfo_t*, const rtD2DAddrCfgInfo_t*,
    bool, const rtMemcpyConfig_t*);
using MEM_COPY_SYNC_FUNC = rtError_t (*)(void*, uint64_t, const void*, uint64_t, rtMemcpyKind_t);
using MEM_COPY_2D_ASYNC_FUNC =
    rtError_t (*)(void*, uint64_t, const void*, uint64_t, uint64_t, uint64_t, Stream*, rtMemcpyKind_t, rtMemcpyKind);
using MEM_COPY_2D_SYNC_FUNC =
    rtError_t (*)(void*, uint64_t, const void*, uint64_t, uint64_t, uint64_t, rtMemcpyKind_t, rtMemcpyKind);
using MEMCPY_BATCH_ASYNC_FUNC = rtError_t (*)(
    void**, const size_t*, void**, const size_t*, size_t, const rtMemcpyBatchAttr*, const size_t*, size_t, size_t*,
    Stream*);
using MEMCPY_BATCH_FUNC = rtError_t (*)(void**, void**, size_t*, size_t, rtMemcpyBatchAttr*, size_t*, size_t, size_t*);
using DEV_MALLOC_FUNC = rtError_t (*)(void**, const uint64_t, const rtMemType_t, const uint16_t);
using DEV_MALLOC_WITH_CFG_FUNC =
    rtError_t (*)(void**, const uint64_t, const rtMemType_t, const uint32_t, const uint16_t);
using DEVICE_RESOURCE_INIT_FUNC = rtError_t (*)(Device*);
using DEVICE_RESOURCE_RELEASE_FUNC = void (*)(uint32_t);
using STREAM_RES_DESTROY_FUNC = void (*)(Stream*);
using DEV_MEMSET_ASYNCFUNC = rtError_t (*)(Stream*, void*, const uint64_t, const uint32_t, const uint64_t);
using DEV_MEMSET32_FUNC = rtError_t (*)(void*, const uint64_t, const uint32_t, const uint64_t, Stream*, const bool);

struct CCProcFunc {
    DEVICE_RESOURCE_INIT_FUNC devResourceInit = nullptr;
    DEVICE_RESOURCE_RELEASE_FUNC devResourceRelease = nullptr;
    STREAM_RES_DESTROY_FUNC streamResDestroy = nullptr;
};

struct MemProcFunc {
    MEMCPY_ASYNC_FUNC memcpyAsync = nullptr;
    MEM_COPY_SYNC_FUNC memCopySync = nullptr;
    MEM_COPY_2D_ASYNC_FUNC memCopy2DAsync = nullptr;
    MEM_COPY_2D_SYNC_FUNC memCopy2DSync = nullptr;
    MEMCPY_BATCH_ASYNC_FUNC memcpyBatchAsync = nullptr;
    MEMCPY_BATCH_FUNC memcpyBatch = nullptr;
    DEV_MALLOC_FUNC devMalloc = nullptr;
    DEV_MALLOC_WITH_CFG_FUNC devMallocWithCfg = nullptr;
    DEV_MEMSET_ASYNCFUNC devMemsetAsync = nullptr;
    DEV_MEMSET32_FUNC devMemset32 = nullptr;
};

struct DevDynInfoProcFunc {
    DEV_PROPS_UPDATE_FUNC devPropsUpdateFunc = nullptr;
    DEV_RAS_PRE_CHECK_FUNC devHitBlackListErrors = nullptr;
    REG_CC_FEATURE_PROC_FUNC regCCFeatureProcFunc = nullptr;
    MemProcFunc memProcFunc;
    CCProcFunc ccProcFunc;
};
} // namespace runtime
} // namespace cce
#endif
