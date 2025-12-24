/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_COMMON_HDC_TRANSPORT_H
#define ANALYSIS_DVVP_COMMON_HDC_TRANSPORT_H

#include "adx_transport.h"
#include "utils/utils.h"

namespace analysis {
namespace dvvp {
namespace transport {
class HDCTransport : public AdxTransport {
public:
    explicit HDCTransport(HDC_SESSION session, bool isClient = false, HDC_CLIENT client = nullptr);
    ~HDCTransport() override;

public:
    int32_t SendBuffer(CONST_VOID_PTR buffer, int32_t length) override;
    int32_t SendBuffer(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq) override;
    int32_t RecvPacket(TLV_REQ_2PTR packet, uint32_t timeout = 0) override;
    void DestroyPacket(TLV_REQ_PTR packet) override;
    int32_t CloseSession() override;
    int32_t SendAdxBuffer(IdeBuffT out, int32_t outLen) override;

private:
    void Destroy();

private:
    HDC_SESSION session_;
    bool isClient_;
    HDC_CLIENT client_;
    std::mutex hdcMtx_;
};

class HDCTransportFactory {
public:
    HDCTransportFactory() {}
    virtual ~HDCTransportFactory() {}

public:
    SHARED_PTR_ALIA<AdxTransport> CreateHdcTransport(HDC_SESSION session) const;
    SHARED_PTR_ALIA<AdxTransport> CreateHdcTransport(HDC_CLIENT client, int32_t devId) const;
    SHARED_PTR_ALIA<AdxTransport> CreateHdcServerTransport(int32_t logicDevId, HDC_SERVER server) const;
    SHARED_PTR_ALIA<AdxTransport> CreateHdcClientTransport(int32_t hostPid, int32_t devId, HDC_CLIENT client) const;
};

int32_t SendBufferWithFixedLength(AdxTransport &transport, CONST_VOID_PTR buffer, int32_t length);
}}}
#endif
