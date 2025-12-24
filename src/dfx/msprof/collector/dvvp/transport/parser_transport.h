/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_ANALYZE_PARSER_TRANSPORT_H
#define ANALYSIS_DVVP_ANALYZE_PARSER_TRANSPORT_H

#include "transport.h"
#include "utils/utils.h"

namespace Analysis {
namespace Dvvp {
namespace Analyze {
class Analyzer;
}}}

namespace analysis {
namespace dvvp {
namespace transport {
class Uploader;
// ParserTransport
class ParserTransport : public ITransport {
public:
    explicit ParserTransport(SHARED_PTR_ALIA<Uploader> uploader);
    ~ParserTransport() override;

public:
    int32_t SendBuffer(CONST_VOID_PTR buffer, int32_t length) override;
    int32_t SendBuffer(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq) override;
    int32_t CloseSession() override;
    void WriteDone() override;
    void SetDevId(const std::string &devIdStr) override;
    void SetType(const uint32_t type) override;

private:
    SHARED_PTR_ALIA<Analysis::Dvvp::Analyze::Analyzer> analyzer_;
};

// PipeTransport
class PipeTransport : public ITransport {
public:
    int32_t SendBuffer(CONST_VOID_PTR buffer, int32_t length) override;
    int32_t SendBuffer(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq) override;
    int32_t CloseSession() override;
    void WriteDone() override {}
};
}  // namespace transport
}  // namespace dvvp
}  // namespace analysis

#endif
