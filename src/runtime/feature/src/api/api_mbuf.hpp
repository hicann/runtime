/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_API_MBUF_HPP
#define CCE_RUNTIME_API_MBUF_HPP

#include "runtime/rt.h"
#include "base.hpp"
#include "runtime.hpp"
#include "event.hpp"
#include "model.hpp"
#include "label.hpp"
#include "api.hpp"

namespace cce {
namespace runtime {

// Runtime interface
class ApiMbuf {
public:
    ApiMbuf() = default;
    virtual ~ApiMbuf() = default;

    ApiMbuf(const ApiMbuf &) = delete;
    ApiMbuf &operator=(const ApiMbuf &) = delete;
    ApiMbuf(ApiMbuf &&) = delete;
    ApiMbuf &operator=(ApiMbuf &&) = delete;

    // Get ApiMbuf instance.
    static ApiMbuf *Instance();

    // mbuf API
    virtual rtError_t MbufInit(rtMemBuffCfg_t * const cfg) = 0;
    virtual rtError_t MbufBuild(void * const buff, const uint64_t size, rtMbufPtr_t *mbufPtr) = 0;
    virtual rtError_t MbufAlloc(rtMbufPtr_t * const mbufPtr, const uint64_t size) = 0;
    virtual rtError_t MbufAllocEx(rtMbufPtr_t * const mbufPtr, const uint64_t size, const uint64_t flag,
        const int32_t grpId) = 0;
    virtual rtError_t MbufUnBuild(const rtMbufPtr_t mbufPtr, void ** const buff, uint64_t * const size) = 0;
    virtual rtError_t MbufGet(const rtMbufPtr_t mbufPtr, void * const buff, const uint64_t size) = 0;
    virtual rtError_t MbufPut(const rtMbufPtr_t mbufPtr, void * const buff) = 0;
    virtual rtError_t MbufFree(const rtMbufPtr_t mbufPtr) = 0;
    virtual rtError_t MbufSetDataLen(const rtMbufPtr_t mbufPtr, const uint64_t len) = 0;
    virtual rtError_t MbufGetDataLen(const rtMbufPtr_t mbufPtr, uint64_t *len) = 0;
    virtual rtError_t MbufGetBuffAddr(const rtMbufPtr_t mbufPtr, void ** const buf) = 0;
    virtual rtError_t MbufGetBuffSize(const rtMbufPtr_t mbufPtr, uint64_t * const totalSize) = 0;
    virtual rtError_t MbufGetPrivInfo(const rtMbufPtr_t mbufPtr, void ** const priv, uint64_t * const size) = 0;
    virtual rtError_t MbufCopyBufRef(const rtMbufPtr_t mbufPtr, rtMbufPtr_t * const newMbufPtr) = 0;
    virtual rtError_t MbufChainAppend(const rtMbufPtr_t memBufChainHead, rtMbufPtr_t memBuf) = 0;
    virtual rtError_t MbufChainGetMbufNum(const rtMbufPtr_t memBufChainHead, uint32_t *num) = 0;
    virtual rtError_t MbufChainGetMbuf(const rtMbufPtr_t memBufChainHead, const uint32_t index,
        rtMbufPtr_t * const memBuf) = 0;
};
}  // namespace runtime
}  // namespace cce


#endif  // CCE_RUNTIME_API_MBUF_HPP
