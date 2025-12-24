/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_COMMON_PIPE_TRANSPORT_H
#define ANALYSIS_DVVP_COMMON_PIPE_TRANSPORT_H

#include "utils/utils.h"
#include "transport.h"

namespace analysis {
namespace dvvp {
namespace transport {
class MsptiPipeTransport : public ITransport {
public:
    // using the existing session
    explicit MsptiPipeTransport();
    ~MsptiPipeTransport() override;

public:
    int32_t SendBuffer(CONST_VOID_PTR buffer, int32_t length) override;
    int32_t SendBuffer(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq) override;
    int32_t CloseSession() override;
    void WriteDone() override;
    void RegisterRawDataCallback(MsprofRawDataCallback callback) override;
    void UnRegisterRawDataCallback() override;
    bool IsRegisterRawDataCallback() override;
    int32_t ConvertFileChunkToRawData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq,
        MsprofRawData& rawData) const;

private:
    MsprofRawDataCallback profRawDataCallback_;
};

class MsptiPipeTransportFactory {
public:
    explicit MsptiPipeTransportFactory();
    ~MsptiPipeTransportFactory();

public:
    SHARED_PTR_ALIA<ITransport> CreateMsptiPipeTransport() const;
};

}  // namespace transport
}  // namespace dvvp
}  // namespace analysis

#endif
