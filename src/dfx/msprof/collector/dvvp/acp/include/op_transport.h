/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DVVP_ACP_ANALYZE_TRANSPORT_H
#define DVVP_ACP_ANALYZE_TRANSPORT_H

#include "transport.h"
#include "utils/utils.h"
#include "op_analyzer.h"

namespace analysis {
namespace dvvp {
namespace transport {
class OpTransport : public ITransport {
public:
    explicit OpTransport();
    ~OpTransport() override;

public:
    int32_t SendBuffer(CONST_VOID_PTR buffer, int32_t length) override;
    int32_t SendBuffer(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq) override;
    int32_t CloseSession() override;
    void WriteDone() override;
    void SetDevId(const std::string &deviceId) override;

private:
    SHARED_PTR_ALIA<Dvvp::Acp::Analyze::OpAnalyzer> analyzer_;
};

class OpTransportFactory {
public:
    OpTransportFactory() {}
    virtual ~OpTransportFactory() {}

public:
    SHARED_PTR_ALIA<ITransport> CreateOpTransport(const std::string &deviceId) const;
};
}  // namespace transport
}  // namespace dvvp
}  // namespace analysis

#endif
