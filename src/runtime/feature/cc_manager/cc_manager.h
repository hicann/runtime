/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_CC_MANAGER_H
#define CCE_RUNTIME_CC_MANAGER_H

#include <memory>
#include <mutex>

#include "base.hpp"
#include "rt_external_mem.h"
#include "spec/base_info.hpp"
#include "cc_res_manage.h"
#include "dev_info.h"

namespace cce {
namespace runtime {
class CCManager : public NoCopy {
public:
    static CCManager& Instance();

    static rtError_t InitDeviceResource(Device* device);
    static void ReleaseDeviceResource(const uint32_t deviceId);
    static void DestroyStreamResource(Stream* stm);

    static rtError_t CCDevMalloc(
        void** const devPtr, const uint64_t size, const rtMemType_t type, const uint16_t moduleId);
    static rtError_t CCDevMallocWithCfg(
        void** const devPtr, const uint64_t size, const rtMemType_t type, const uint32_t devId,
        const uint16_t moduleId);
    static rtError_t CCMemCopySync(
        void* const dst, const uint64_t destMax, const void* const src, const uint64_t cnt, const rtMemcpyKind_t kind);
    static rtError_t CCMemcpyAsync(
        void* const dst, const uint64_t destMax, const void* const src, const uint64_t cnt, const rtMemcpyKind_t kind,
        Stream* const stm, const rtTaskCfgInfo_t* const cfgInfo = nullptr,
        const struct rtD2DAddrCfgInfo_t* const addrCfg = nullptr, bool checkKind = true,
        const rtMemcpyConfig_t* const memcpyConfig = nullptr);
    static rtError_t CCMemCopy2DAsync(
        void* const dst, const uint64_t dstPitch, const void* const src, const uint64_t srcPitch, const uint64_t width,
        const uint64_t height, Stream* const stm, const rtMemcpyKind_t kind = RT_MEMCPY_RESERVED,
        const rtMemcpyKind newKind = RT_MEMCPY_KIND_MAX);
    static rtError_t CCMemcpyBatchAsync(
        void** const dsts, const size_t* const destMaxs, void** const srcs, const size_t* const sizes,
        const size_t count, const rtMemcpyBatchAttr* const attrs, const size_t* const attrsIdxs, const size_t numAttrs,
        size_t* const failIdx, Stream* const stm);
    static rtError_t CCMemCopy2DSync(
        void* const dst, const uint64_t dstPitch, const void* const src, const uint64_t srcPitch, const uint64_t width,
        const uint64_t height, const rtMemcpyKind_t kind = RT_MEMCPY_RESERVED,
        const rtMemcpyKind newKind = RT_MEMCPY_KIND_MAX);
    static rtError_t CCMemcpyBatch(
        void** const dsts, void** const srcs, size_t* const sizes, const size_t count, rtMemcpyBatchAttr* const attrs,
        size_t* const attrsIdxs, const size_t numAttrs, size_t* const failIdx);
    static rtError_t CCDevMemSetAsync(
        Stream* const stm, void* const ptr, const uint64_t destMax, const uint32_t fillVal, const uint64_t fillCount);
    static rtError_t CCDevMemSetD32(
        void* const dst, const uint64_t destMax, const uint32_t value, const uint64_t count, Stream* const stm,
        const bool isAsync);

private:
    CCManager() = default;
    ~CCManager() override;

    std::unique_ptr<CCResManage> resources_[RT_MAX_DEV_NUM]{};
    // 资源创建会同线程回调 CCManager，期间不得持 resourceMutex_。
    std::mutex resourceMutex_; // 解决同一进程 多线程SetDevice同一Device场景
    std::mutex resourceInitMutex_;
    static rtError_t SubmitCcMemcpyTask(
        void* const dst, const void* const src, const uint64_t count, const rtMemcpyKind_t kind, Stream* const stm,
        std::shared_ptr<void> guardMem = nullptr);
    static void SubmitCcTaskCallback(void* userData);
    static bool CanUseSmallCcMemcpy(uint64_t count, rtMemcpyKind_t kind, const Stream* stm, bool isSync);
    static rtError_t SubmitSmallCcMemcpyTask(
        void* dst, uint64_t destMax, const void* src, uint64_t count, rtMemcpyKind_t kind, Stream* stm, bool isSync);
    static rtError_t SubmitCcMemcpy2DTasks(
        void* const dst, const uint64_t dstPitch, const void* const src, const uint64_t srcPitch, const uint64_t width,
        const uint64_t height, Stream* const stm, const rtMemcpyKind_t kind, bool isSync = false);
    static rtError_t SubmitCcMemcpyBatchTasks(
        void** const dsts, const size_t* const destMaxs, void** const srcs, const size_t* const sizes,
        const size_t count, const rtMemcpyBatchAttr* const attrs, const size_t* const attrsIdxs, const size_t numAttrs,
        size_t* const failIdx, Stream* const stm, bool isSync = false);
    static rtError_t CCDevMemSet(
        Stream* const stm, void* const dst, const uint64_t totalCnt, const uint32_t value, bool isByteFill);
};
} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_CC_MANAGER_H
