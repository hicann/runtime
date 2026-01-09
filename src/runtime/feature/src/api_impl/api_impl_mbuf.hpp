/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_API_IMPL_MBUF_HPP
#define CCE_RUNTIME_API_IMPL_MBUF_HPP

#include "api_mbuf.hpp"

namespace cce {
namespace runtime {

// Runtime APIMbuf implement
class ApiImplMbuf : public ApiMbuf {
public:
    // mbuf API
    rtError_t MbufInit(rtMemBuffCfg_t *const cfg) override;
    rtError_t MbufBuild(void * const buff, const uint64_t size, rtMbufPtr_t * const mbufPtr) override;
    rtError_t MbufAlloc(rtMbufPtr_t * const mbufPtr, const uint64_t size) override;
    rtError_t MbufAllocEx(rtMbufPtr_t * const mbufPtr, const uint64_t size, const uint64_t flag,
        const int32_t grpId) override;
    rtError_t MbufUnBuild(const rtMbufPtr_t mbufPtr, void ** const buff, uint64_t * const size) override;
    rtError_t MbufGet(const rtMbufPtr_t mbufPtr, void * const buff, const uint64_t size) override;
    rtError_t MbufPut(const rtMbufPtr_t mbufPtr, void * const buff) override;
    rtError_t MbufFree(const rtMbufPtr_t mbufPtr) override;
    rtError_t MbufSetDataLen(const rtMbufPtr_t mbufPtr, const uint64_t len) override;
    rtError_t MbufGetDataLen(const rtMbufPtr_t mbufPtr, uint64_t *len) override;
    rtError_t MbufGetBuffAddr(const rtMbufPtr_t mbufPtr, void ** const buf) override;
    rtError_t MbufGetBuffSize(const rtMbufPtr_t mbufPtr, uint64_t * const totalSize) override;
    rtError_t MbufGetPrivInfo(const rtMbufPtr_t mbufPtr, void ** const priv, uint64_t * const size) override;
    rtError_t MbufCopyBufRef(const rtMbufPtr_t mbufPtr, rtMbufPtr_t * const newMbufPtr) override;
    rtError_t MbufChainAppend(const rtMbufPtr_t memBufChainHead, rtMbufPtr_t memBuf) override;
    rtError_t MbufChainGetMbufNum(const rtMbufPtr_t memBufChainHead, uint32_t *num) override;
    rtError_t MbufChainGetMbuf(const rtMbufPtr_t memBufChainHead, const uint32_t index,
        rtMbufPtr_t * const memBuf) override;
};
}  // namespace runtime
}  // namespace cce


#endif  // CCE_RUNTIME_API_IMPL_MBUF_HPP
