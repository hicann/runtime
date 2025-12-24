/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_TRANSPORT_FILE_MANAGER_H
#define ANALYSIS_DVVP_TRANSPORT_FILE_MANAGER_H
#include <map>
#include "singleton.h"
#include "transport.h"
#include "file_interface.h"
namespace analysis {
namespace dvvp {
namespace transport {
class FileManager : public analysis::dvvp::common::singleton::Singleton<FileManager> {
public:
    FileManager();
    ~FileManager() override;
    int32_t InitFileTransport(uint32_t deviceId, const char *flushDir, const char *storageLimit);
    int32_t SendBuffer(ProfFileChunk* chunk);

private:
    std::map<uint32_t, SHARED_PTR_ALIA<ITransport>> transportMap_;
    std::mutex fileMtx_;
};
}  // namespace transport
}  // namespace dvvp
}  // namespace analysis

#endif