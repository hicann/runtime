/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_impl.hpp"

namespace cce {
namespace runtime {

rtError_t ApiImpl::MemCopySyncEx(
    void* const dst, const uint64_t destMax, const void* const src, const uint64_t cnt, const rtMemcpyKind_t kind)
{
    UNUSED(dst);
    UNUSED(destMax);
    UNUSED(src);
    UNUSED(cnt);
    UNUSED(kind);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::RtsMemcpyAsync(
    void* const dst, const uint64_t destMax, const void* const src, const uint64_t cnt, const rtMemcpyKind kind,
    rtMemcpyConfig_t* const config, Stream* const stm)
{
    UNUSED(dst);
    UNUSED(destMax);
    UNUSED(src);
    UNUSED(cnt);
    UNUSED(kind);
    UNUSED(config);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::RtsMemcpy(
    void* const dst, const uint64_t destMax, const void* const src, const uint64_t cnt, const rtMemcpyKind kind,
    rtMemcpyConfig_t* const config)
{
    UNUSED(dst);
    UNUSED(destMax);
    UNUSED(src);
    UNUSED(cnt);
    UNUSED(kind);
    UNUSED(config);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::SetMemcpyDesc(
    rtMemcpyDesc_t desc, const void* const srcAddr, const void* const dstAddr, const size_t count,
    const rtMemcpyKind kind, rtMemcpyConfig_t* const config)
{
    UNUSED(desc);
    UNUSED(srcAddr);
    UNUSED(dstAddr);
    UNUSED(count);
    UNUSED(kind);
    UNUSED(config);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::MemcpyAsyncWithDesc(
    rtMemcpyDesc_t desc, Stream* stm, const rtMemcpyKind kind, rtMemcpyConfig_t* const config)
{
    UNUSED(desc);
    UNUSED(stm);
    UNUSED(kind);
    UNUSED(config);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::MemcpyAsyncPtr(
    void* const memcpyAddrInfo, const uint64_t destMax, const uint64_t count, Stream* const stm,
    const rtTaskCfgInfo_t* const cfgInfo, const bool isMemcpyDesc)
{
    UNUSED(memcpyAddrInfo);
    UNUSED(destMax);
    UNUSED(count);
    UNUSED(stm);
    UNUSED(cfgInfo);
    UNUSED(isMemcpyDesc);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::CheckMemType(void** addrs, uint32_t size, uint32_t memType, uint32_t* checkResult, uint32_t reserve)
{
    UNUSED(addrs);
    UNUSED(size);
    UNUSED(memType);
    UNUSED(checkResult);
    UNUSED(reserve);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::GetMemUsageInfo(
    const uint32_t deviceId, rtMemUsageInfo_t* const memUsageInfo, const size_t inputNum, size_t* const outputNum)
{
    UNUSED(deviceId);
    UNUSED(memUsageInfo);
    UNUSED(inputNum);
    UNUSED(outputNum);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::MemGetInfoEx(const rtMemInfoType_t memInfoType, size_t* const freeSize, size_t* const totalSize)
{
    UNUSED(memInfoType);
    UNUSED(freeSize);
    UNUSED(totalSize);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::MemPrefetchToDevice(const void* const devPtr, const uint64_t len, const int32_t devId)
{
    UNUSED(devPtr);
    UNUSED(len);
    UNUSED(devId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::MemCopy2DSync(
    void* const dst, const uint64_t dstPitch, const void* const src, const uint64_t srcPitch, const uint64_t width,
    const uint64_t height, const rtMemcpyKind_t kind, const rtMemcpyKind newKind)
{
    UNUSED(dst);
    UNUSED(dstPitch);
    UNUSED(src);
    UNUSED(srcPitch);
    UNUSED(width);
    UNUSED(height);
    UNUSED(kind);
    UNUSED(newKind);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::MemCopy2DAsync(
    void* const dst, const uint64_t dstPitch, const void* const src, const uint64_t srcPitch, const uint64_t width,
    const uint64_t height, Stream* const stm, const rtMemcpyKind_t kind, const rtMemcpyKind newKind)
{
    UNUSED(dst);
    UNUSED(dstPitch);
    UNUSED(src);
    UNUSED(srcPitch);
    UNUSED(width);
    UNUSED(height);
    UNUSED(stm);
    UNUSED(kind);
    UNUSED(newKind);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::MemcpyHostTask(
    void* const dst, const uint64_t destMax, const void* const src, const uint64_t cnt, const rtMemcpyKind_t kind,
    Stream* const stm)
{
    UNUSED(dst);
    UNUSED(destMax);
    UNUSED(src);
    UNUSED(cnt);
    UNUSED(kind);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::DevMalloc(
    void** const devPtr, const uint64_t size, rtMallocPolicy policy, rtMallocAdvise advise,
    const rtMallocConfig_t* const cfg)
{
    UNUSED(devPtr);
    UNUSED(size);
    UNUSED(policy);
    UNUSED(advise);
    UNUSED(cfg);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::MemcpyBatch(
    void** dsts, void** srcs, size_t* sizes, size_t count, rtMemcpyBatchAttr* attrs, size_t* attrsIdxs, size_t numAttrs,
    size_t* failIdx)
{
    UNUSED(dsts);
    UNUSED(srcs);
    UNUSED(sizes);
    UNUSED(count);
    UNUSED(attrs);
    UNUSED(attrsIdxs);
    UNUSED(numAttrs);
    UNUSED(failIdx);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::MemcpyBatchAsync(
    void** const dsts, const size_t* const destMaxs, void** const srcs, const size_t* const sizes, const size_t count,
    const rtMemcpyBatchAttr* const attrs, const size_t* const attrsIdxs, const size_t numAttrs, size_t* const failIdx,
    Stream* const stm)
{
    UNUSED(dsts);
    UNUSED(destMaxs);
    UNUSED(srcs);
    UNUSED(sizes);
    UNUSED(count);
    UNUSED(attrs);
    UNUSED(attrsIdxs);
    UNUSED(numAttrs);
    UNUSED(failIdx);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::MemWaitValue(const void* const devAddr, const uint64_t value, const uint32_t flag, Stream* const stm)
{
    UNUSED(devAddr);
    UNUSED(value);
    UNUSED(flag);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

} // namespace runtime
} // namespace cce
