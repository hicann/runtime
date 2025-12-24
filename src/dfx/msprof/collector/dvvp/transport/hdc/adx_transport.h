/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_TRANSPORT_ADX_TRANSPORT_H
#define ANALYSIS_DVVP_TRANSPORT_ADX_TRANSPORT_H
#include "transport.h"
#include "hdc_api.h"

namespace analysis {
namespace dvvp {
namespace transport {
using namespace analysis::dvvp::common::utils;
using TLV_REQ_PTR = struct tlv_req *;
using CONST_TLV_REQ_PTR = const struct tlv_req *;
using TLV_REQ_2PTR = struct tlv_req **;
class AdxTransport : public ITransport {
public:
    int32_t SendBuffer(CONST_VOID_PTR buffer, int32_t length) override = 0;
    int32_t SendBuffer(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq) override = 0;
    int32_t CloseSession() override = 0;
    void WriteDone() override {}
    virtual int32_t SendAdxBuffer(IdeBuffT out, int32_t outLen) = 0;
    virtual int32_t RecvPacket(TLV_REQ_2PTR packet, uint32_t timeout = 0) = 0;
    virtual void DestroyPacket(TLV_REQ_PTR packet) = 0;
};
}  // namespace transport
}  // namespace dvvp
}  // namespace analysis

#endif
