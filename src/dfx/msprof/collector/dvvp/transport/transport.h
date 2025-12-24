/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_COMMON_TRANSPORT_H
#define ANALYSIS_DVVP_COMMON_TRANSPORT_H

#include <condition_variable>
#include <memory>
#include "statistics/perf_count.h"
#include "utils/utils.h"
#include "prof_common.h"

using HashDataGenIdFuncPtr = uint64_t(const std::string &hashInfo);

namespace analysis {
namespace dvvp {
namespace transport {
using namespace Analysis::Dvvp::Common::Statistics;
using namespace analysis::dvvp::common::utils;
class ITransport {
public:
    explicit ITransport() : perfCount_(nullptr) {}
    virtual ~ITransport() {}

public:
    virtual int32_t SendBuffer(CONST_VOID_PTR buffer, int32_t length) = 0;
    virtual int32_t SendBuffer(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq) = 0;
    virtual int32_t CloseSession() = 0;
    virtual void WriteDone() = 0;
    virtual void SetDevId(const std::string & /* devIdStr */){};
    virtual void SetType(const uint32_t /* type */){};
    virtual void SetHelperDir(const std::string & /* id */, const std::string & /* helperPath */){};
    virtual void SetStopped() {};
    virtual void RegisterHashDataGenIdFuncPtr(HashDataGenIdFuncPtr*) {};
    virtual void RegisterRawDataCallback(MsprofRawDataCallback) {};
    virtual bool IsRegisterRawDataCallback() {return false;};
    virtual void UnRegisterRawDataCallback() {};

public:
    SHARED_PTR_ALIA<PerfCount> perfCount_; // calculate statistics
};

class TransportFactory {
public:
    TransportFactory() {}
    virtual ~TransportFactory() {}

public:
    SHARED_PTR_ALIA<ITransport> CreateIdeTransport(IDE_SESSION session);
};
}  // namespace transport
}  // namespace dvvp
}  // namespace analysis

#endif
