/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_COMMON_HELPER_TRANSPORT_H
#define ANALYSIS_DVVP_COMMON_HELPER_TRANSPORT_H

#include "file_slice.h"
#include "utils/utils.h"
#include "transport/transport.h"
#include "adx_transport.h"
#include "prof_hal_api.h"

namespace analysis {
namespace dvvp {
namespace transport {

class HelperTransport : public ITransport {
public:
    explicit HelperTransport(HDC_SESSION session, bool isClient = false, HDC_CLIENT client = nullptr);
    ~HelperTransport() override;

public:
    int32_t SendBuffer(CONST_VOID_PTR buffer, int32_t length) override;
    int32_t SendBuffer(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq) override;
    void WriteDone() override;
    int32_t CloseSession() override;
    int32_t PackingData(ProfHalStruct &package, SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);
    int32_t SendPackingData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq,
        ProfHalStruct &package, SHARED_PTR_ALIA<ProfHalTlv> tlvbuff);
    void FillLastChunk(uint32_t stackLength, ProfHalStruct &package) const;
    int32_t SendAdxBuffer(VOID_PTR out, int32_t outLen) const;
    int32_t ReceivePacket(ProfHalTlv **packet) const;
    void FreePacket(ProfHalTlv *packet) const;

private:
    void Destroy();

private:
    HDC_SESSION session_;
    bool isClient_;
    HDC_CLIENT client_;
    std::mutex sessionMtx_;
    bool isLastChunk_;
};

class HelperTransportFactory {
public:
    HelperTransportFactory() {}
    virtual ~HelperTransportFactory() {}

public:
    SHARED_PTR_ALIA<ITransport> CreateHdcClientTransport(int32_t hostPid, int32_t devId, HDC_CLIENT client) const;
    SHARED_PTR_ALIA<HelperTransport> CreateHdcServerTransport(int32_t logicDevId, HDC_SERVER server) const;
};

int32_t SendBufferPacket(HelperTransport &transport, VOID_PTR buffer, int32_t length);
}  // namespace transport
}  // namespace dvvp
}  // namespace analysis

#endif
