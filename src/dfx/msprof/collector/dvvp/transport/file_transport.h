/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_COMMON_FILE_TRANSPORT_H
#define ANALYSIS_DVVP_COMMON_FILE_TRANSPORT_H

#include "file_slice.h"
#include "utils/utils.h"
#include "transport.h"
#include "prof_api.h"

namespace analysis {
namespace dvvp {
namespace transport {
class FILETransport : public ITransport {
public:
    // using the existing session
    explicit FILETransport(const std::string &storageDir, const std::string &storageLimit);
    ~FILETransport() override;

public:
    int32_t SendBuffer(CONST_VOID_PTR buffer, int32_t length) override;
    int32_t SendBuffer(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq) override;
    int32_t CloseSession() override;
    void WriteDone() override;
    int32_t Init();
    void SetAbility(bool needSlice);
    void SetHelperDir(const std::string &id, const std::string &helperPath) override;
    void SetStopped() override;
    void RegisterHashDataGenIdFuncPtr(HashDataGenIdFuncPtr* ptr) override;

private:
    int32_t UpdateFileName(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq, const std::string &devId) const;
    int32_t ParseTlvChunk(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);
    int32_t ParseStr2IdChunk(const SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);
    void AddHashData(const std::string& input) const;
    int32_t SaveChunk(const char *data, SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk) const;

private:
    SHARED_PTR_ALIA<FileSlice> fileSlice_;
    std::string storageDir_;
    std::string storageLimit_;
    bool needSlice_;
    bool stopped_;
    bool parseStr2IdStart_;
    HashDataGenIdFuncPtr* hashDataGenIdFuncPtr_;
    std::map<std::string, std::string> helperStorageMap_;
    std::map<std::string, std::string> channelBuffer_;
    std::mutex helperMtx_;
};

class FileTransportFactory {
public:
    FileTransportFactory() {}
    virtual ~FileTransportFactory() {}

public:
    SHARED_PTR_ALIA<ITransport> CreateFileTransport(const std::string &storageDir, const std::string &storageLimit,
                                                    bool needSlice) const;
};
}  // namespace transport
}  // namespace dvvp
}  // namespace analysis

#endif
