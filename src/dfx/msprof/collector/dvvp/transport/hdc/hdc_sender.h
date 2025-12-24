/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_COMMON_HDC_SENDER_H
#define ANALYSIS_DVVP_COMMON_HDC_SENDER_H

#include "sender.h"
#include "transport/transport.h"

namespace analysis {
namespace dvvp {
namespace transport {
using namespace analysis::dvvp::streamio::client;
class HdcSender {
public:
    HdcSender();
    virtual ~HdcSender();

public:
    int32_t Init(SHARED_PTR_ALIA<ITransport> transport, const std::string &engineName);
    void Uninit() const;
    int32_t SendData(const std::string &jobCtx, const struct DataChunk &data);
    void Flush() const;

private:
    std::string engineName_;
    SHARED_PTR_ALIA<analysis::dvvp::common::memory::ChunkPool> chunkPool_;
    SHARED_PTR_ALIA<Sender> sender_;
    SHARED_PTR_ALIA<ITransport> transport_;
};
}  // namespace transport
}  // namespace dvvp
}  // namespace analysis

#endif  // ANALYSIS_DVVP_COMMON_HDC_SENDER_H
