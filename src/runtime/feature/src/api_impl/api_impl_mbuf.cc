/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_impl_mbuf.hpp"
#include "npu_driver.hpp"
#include "runtime/rt_mem_queue.h"

namespace cce {
namespace runtime {

rtError_t ApiImplMbuf::MbufInit(rtMemBuffCfg_t *const cfg) {
    RT_LOG(RT_LOG_INFO, "Start to init mbuf.");
    return NpuDriver::MbufInit(cfg);
}

rtError_t ApiImplMbuf::MbufBuild(void * const buff, const uint64_t size, rtMbufPtr_t * const mbufPtr)
{
    RT_LOG(RT_LOG_INFO, "Start to build mbuf, size is %" PRIu64, size);
    return NpuDriver::MbufBuild(buff, size, mbufPtr);
}

rtError_t ApiImplMbuf::MbufAlloc(rtMbufPtr_t * const mbufPtr, const uint64_t size)
{
    RT_LOG(RT_LOG_INFO, "Start to alloc mbuf, size is %" PRIu64, size);
    TIMESTAMP_NAME(__func__);
    return NpuDriver::MbufAlloc(mbufPtr, size);
}

rtError_t ApiImplMbuf::MbufAllocEx(rtMbufPtr_t * const mbufPtr, const uint64_t size,
    const uint64_t flag, const int32_t grpId)
{
    RT_LOG(RT_LOG_INFO, "Start to alloc mbuf, size is %" PRIu64, size);
    return NpuDriver::MbufAllocEx(mbufPtr, size, flag, grpId);
}

rtError_t ApiImplMbuf::MbufUnBuild(const rtMbufPtr_t mbufPtr, void ** const buff, uint64_t * const size)
{
    RT_LOG(RT_LOG_INFO, "Start to unBuild mbuf, size is %p", size);
    return NpuDriver::MbufUnBuild(mbufPtr, buff, size);
}

rtError_t ApiImplMbuf::MbufGet(const rtMbufPtr_t mbufPtr, void * const buff, const uint64_t size)
{
    RT_LOG(RT_LOG_INFO, "Start to get mbuf, size is %" PRIu64, size);
    return NpuDriver::MbufGet(mbufPtr, buff, size);
}

rtError_t ApiImplMbuf::MbufPut(const rtMbufPtr_t mbufPtr, void * const buff)
{
    RT_LOG(RT_LOG_INFO, "Start to put buff.");
    return NpuDriver::MbufPut(mbufPtr, buff);
}


rtError_t ApiImplMbuf::MbufFree(const rtMbufPtr_t mbufPtr)
{
    RT_LOG(RT_LOG_INFO, "Start to free mbuf.");

    return NpuDriver::MbufFree(mbufPtr);
}

rtError_t ApiImplMbuf::MbufSetDataLen(const rtMbufPtr_t mbufPtr, const uint64_t len)
{
    RT_LOG(RT_LOG_INFO, "Start to set mbuf data len %lu.", len);
    return NpuDriver::MbufSetDataLen(mbufPtr, len);
}

rtError_t ApiImplMbuf::MbufGetDataLen(const rtMbufPtr_t mbufPtr, uint64_t *len)
{
    return NpuDriver::MbufGetDataLen(mbufPtr, len);
}

rtError_t ApiImplMbuf::MbufGetBuffAddr(const rtMbufPtr_t mbufPtr, void ** const buf)
{
    RT_LOG(RT_LOG_INFO, "Start to get mbuf data addr.");

    return NpuDriver::MbufGetBuffAddr(mbufPtr, buf);
}

rtError_t ApiImplMbuf::MbufGetBuffSize(const rtMbufPtr_t mbufPtr, uint64_t * const totalSize)
{
    RT_LOG(RT_LOG_INFO, "Start to get databuf size.");

    return NpuDriver::MbufGetBuffSize(mbufPtr, totalSize);
}

rtError_t ApiImplMbuf::MbufGetPrivInfo(const rtMbufPtr_t mbufPtr, void ** const priv, uint64_t * const size)
{
    RT_LOG(RT_LOG_INFO, "Start to get mbuf priv addr.");

    return NpuDriver::MbufGetPrivInfo(mbufPtr, priv, size);
}

rtError_t ApiImplMbuf::MbufCopyBufRef(const rtMbufPtr_t mbufPtr, rtMbufPtr_t * const newMbufPtr)
{
    RT_LOG(RT_LOG_INFO, "Start to copy buf ref.");

    return NpuDriver::MbufCopyBufRef(mbufPtr, newMbufPtr);
}

rtError_t ApiImplMbuf::MbufChainAppend(const rtMbufPtr_t memBufChainHead, rtMbufPtr_t memBuf)
{
    RT_LOG(RT_LOG_INFO, "Start to append mbuf chain.");

    return NpuDriver::MbufChainAppend(memBufChainHead, memBuf);
}

rtError_t ApiImplMbuf::MbufChainGetMbufNum(const rtMbufPtr_t memBufChainHead, uint32_t *num)
{
    RT_LOG(RT_LOG_INFO, "Start to get mbuf chain num.");

    return NpuDriver::MbufChainGetMbufNum(memBufChainHead, num);
}

rtError_t ApiImplMbuf::MbufChainGetMbuf(const rtMbufPtr_t memBufChainHead, const uint32_t index,
    rtMbufPtr_t * const memBuf)
{
    RT_LOG(RT_LOG_INFO, "Start to get mbuf from chain %u.", index);

    return NpuDriver::MbufChainGetMbuf(memBufChainHead, index, memBuf);
}
}  // namespace runtime
}  // namespace cce