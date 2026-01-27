/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TOOLS_DUMP_FILE_CHECKER_H
#define TOOLS_DUMP_FILE_CHECKER_H

#include <string>
#include <vector>
#include "proto/dump_task.pb.h"

namespace Adx {

class DumpFileChecker {
public:
    DumpFileChecker() = default;
    ~DumpFileChecker() = default;

    bool Load(const std::string &filePath);

    // check head
    bool CheckHead(const std::string &opName) const;
    bool CheckInputTensorNum(int32_t num) const;
    bool CheckOutputTensorNum(int32_t num) const;
    bool CheckWorkspaceNum(int32_t num) const;

    // check input
    bool CheckInputTensorSize(size_t index, uint64_t size) const;
    bool CheckInputTensorData(size_t index, const std::vector<uint8_t> &data) const;
    bool CheckInputTensorShape(size_t index, const std::vector<int64_t> &shape) const;
    bool CheckInputTensorDatatype(size_t index, toolkit::dump::OutputDataType datatype) const;
    bool CheckInputTensorFormat(size_t index, toolkit::dump::OutputFormat format) const;

    // check output
    bool CheckOutputTensorSize(size_t index, uint64_t size) const;
    bool CheckOutputTensorData(size_t index, const std::vector<uint8_t> &data) const;
    bool CheckOutputTensorShape(size_t index, const std::vector<int64_t> &shape) const;
    bool CheckOutputTensorDatatype(size_t index, toolkit::dump::OutputDataType datatype) const;
    bool CheckOutputTensorFormat(size_t index, toolkit::dump::OutputFormat format) const;

    // check workspace
    bool CheckWorkspaceData(size_t index, const std::vector<uint8_t> &data) const;
    bool CheckWorkspaceSize(size_t index, uint64_t size) const;

private:
    toolkit::dump::DumpData header_;
    std::vector<std::vector<uint8_t>> inputs_;
    std::vector<std::vector<uint8_t>> outputs_;
    std::vector<std::vector<uint8_t>> workspaces_;
};

std::string ExpectedDumpFilePath(const std::string &envDumpPath, uint32_t deviceId, const std::string &opType,
    const std::string &opName, uint32_t taskId, const std::string &timestamp);

std::string ExpectedArgsDumpFilePath(const std::string &envDumpPath, uint32_t deviceId, uint32_t streamId,
                                     uint32_t taskId, const std::string &timestamp);

bool IsFileExist(const std::string &filePath);
} // namespace Adx
#endif // TOOLS_DUMP_FILE_CHECKER_H