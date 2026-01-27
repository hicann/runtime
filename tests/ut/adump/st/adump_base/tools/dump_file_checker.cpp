/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dump_file_checker.h"
#include <unistd.h>
#include <iostream>
#include <fstream>

namespace Adx {

bool DumpFileChecker::Load(const std::string &filePath)
{
    std::ifstream ifs(filePath, std::ios::binary);
    if (!ifs.is_open()) {
        return false;
    }

    uint64_t protoHeaderSize = 0;
    if (!ifs.read(reinterpret_cast<char *>(&protoHeaderSize), sizeof(uint64_t))) {
        std::cout << "Read proto header size failed" << std::endl;
        return false;
    }
    std::cout << "Read proto header size: " << protoHeaderSize << std::endl;

    std::string protoHeader(protoHeaderSize, '\0');
    if (!ifs.read(&protoHeader[0], protoHeaderSize)) {
        std::cout << "Read proto header failed." << std::endl;
        return false;
    }

    if (!header_.ParseFromString(protoHeader)) {
        std::cout << "parse proto header failed." << std::endl;
        return false;
    }
    std::cout << "Read input tensor size: " << header_.input_size() << std::endl;
    std::cout << "Read output tensor size: " << header_.output_size() << std::endl;
    std::cout << "Read workspace size: " << header_.space_size() << std::endl;

    for (int i = 0; i < header_.input_size(); i++) {
        const toolkit::dump::OpInput &input = header_.input(i);
        uint64_t inputSize = input.size();
        std::vector<uint8_t> buff(inputSize);
        if (!ifs.read(reinterpret_cast<char *>(buff.data()), inputSize)) {
            std::cout << "read input " << i << " tensor failed" << std::endl;
            return false;
        }
        inputs_.emplace_back(std::move(buff));
    }

    for (int i = 0; i < header_.output_size(); i++) {
        const toolkit::dump::OpOutput &output = header_.output(i);
        uint64_t outputSize = output.size();
        std::vector<uint8_t> buff(outputSize);
        if (!ifs.read(reinterpret_cast<char *>(buff.data()), outputSize)) {
            std::cout << "read output " << i << " tensor failed" << std::endl;
            return false;
        }
        outputs_.emplace_back(std::move(buff));
    }

    for (int i = 0; i < header_.space_size(); i++) {
        const toolkit::dump::Workspace &workspace = header_.space(i);
        uint64_t workspaceSize = workspace.size();
        std::vector<uint8_t> buff(workspaceSize);
        if (!ifs.read(reinterpret_cast<char *>(buff.data()), workspaceSize)) {
            std::cout << "read workspace " << i << " failed" << std::endl;
            return false;
        }
        workspaces_.emplace_back(std::move(buff));
    }
    return true;
}

bool DumpFileChecker::CheckHead(const std::string &opName) const
{
    return header_.op_name() == opName;
}

bool DumpFileChecker::CheckInputTensorNum(int32_t num) const
{
    std::cout << "Input num: " << num << " dump file input num " << header_.input_size() << std::endl;
    return header_.input_size() == num;
}

bool DumpFileChecker::CheckOutputTensorNum(int32_t num) const
{
    std::cout << "Output num: " << num << " dump file Output num " << header_.output_size() << std::endl;
    return header_.output_size() == num;
}

bool DumpFileChecker::CheckWorkspaceNum(int32_t num) const
{
    return header_.space_size() == num;
}

bool DumpFileChecker::CheckInputTensorSize(size_t index, uint64_t size) const
{
    if (index >= header_.input_size()) {
        return false;
    }
    return header_.input(index).size() == size;
}

bool DumpFileChecker::CheckInputTensorData(size_t index, const std::vector<uint8_t> &data) const
{
    if (index >= header_.input_size() || index >= inputs_.size()) {
        return false;
    }
    return inputs_[index] == data;
}

bool DumpFileChecker::CheckInputTensorShape(size_t index, const std::vector<int64_t> &shape) const
{
    if (index >= header_.input_size()) {
        return false;
    }
    toolkit::dump::Shape dumpShape = header_.input(index).shape();
    if (dumpShape.dim_size() != shape.size()) {
        std::cout << "dump shape dim size: " << dumpShape.dim_size() << " not equal " << shape.size() << std::endl;
        return false;
    }

    for (size_t i = 0; i < shape.size(); i++) {
        if (dumpShape.dim(i) != shape[i]) {
            std::cout << "dump shape dim[" << i << "] " << dumpShape.dim(i) << " not equal " << shape[i] << std::endl;
            return false;
        }
    }
    return true;
}

bool DumpFileChecker::CheckInputTensorDatatype(size_t index, toolkit::dump::OutputDataType datatype) const
{
    if (index >= header_.input_size()) {
        return false;
    }
    return header_.input(index).data_type() == datatype;
}

bool DumpFileChecker::CheckInputTensorFormat(size_t index, toolkit::dump::OutputFormat format) const
{
    if (index >= header_.input_size()) {
        return false;
    }
    return header_.input(index).format() == format;
}

bool DumpFileChecker::CheckOutputTensorSize(size_t index, uint64_t size) const
{
    if (index >= header_.output_size()) {
        return false;
    }
    return header_.output(index).size() == size;
}

bool DumpFileChecker::CheckOutputTensorData(size_t index, const std::vector<uint8_t> &data) const
{
    if (index >= header_.output_size() || index >= outputs_.size()) {
        return false;
    }
    return outputs_[index] == data;
}

bool DumpFileChecker::CheckOutputTensorShape(size_t index, const std::vector<int64_t> &shape) const
{
    if (index >= header_.output_size()) {
        return false;
    }
    toolkit::dump::Shape dumpShape = header_.output(index).shape();
    if (dumpShape.dim_size() != shape.size()) {
        return false;
    }

    for (size_t i = 0; i < shape.size(); i++) {
        if (dumpShape.dim(i) != shape[i]) {
            return false;
        }
    }
    return true;
}

bool DumpFileChecker::CheckOutputTensorDatatype(size_t index, toolkit::dump::OutputDataType datatype) const
{
    if (index >= header_.output_size()) {
        return false;
    }
    return header_.output(index).data_type() == datatype;
}

bool DumpFileChecker::CheckOutputTensorFormat(size_t index, toolkit::dump::OutputFormat format) const
{
    if (index >= header_.output_size()) {
        return false;
    }
    return header_.output(index).format() == format;
}

bool DumpFileChecker::CheckWorkspaceData(size_t index, const std::vector<uint8_t> &data) const
{
    if (index >= header_.space_size() || index >= workspaces_.size()) {
        return false;
    }
    return workspaces_[index] == data;
}

bool DumpFileChecker::CheckWorkspaceSize(size_t index, uint64_t size) const
{
    if (index >= header_.space_size()) {
        return false;
    }
    return header_.space(index).size() == size;
}

std::string ExpectedDumpFilePath(const std::string &envDumpPath, uint32_t deviceId, const std::string &opType,
                                 const std::string &opName, uint32_t taskId, const std::string &timestamp)
{
    std::string expectDumpFile = opType + "." + opName + "." + std::to_string(taskId) + "." + timestamp;
    std::string expectDumpDir = envDumpPath + "/extra-info/data-dump/" + std::to_string(deviceId);
    std::string expectDumpFilePath = expectDumpDir + "/" + expectDumpFile;
    return expectDumpFilePath;
}

std::string ExpectedArgsDumpFilePath(const std::string &envDumpPath, uint32_t deviceId, uint32_t streamId,
                                     uint32_t taskId, const std::string &timestamp)
{
    std::string opType = "exception_info";
    std::string expectDumpFile =
        opType + "." + std::to_string(streamId) + "." + std::to_string(taskId) + "." + timestamp;
    std::string expectDumpDir = envDumpPath + "/extra-info/data-dump/" + std::to_string(deviceId);
    std::string expectDumpFilePath = expectDumpDir + "/" + expectDumpFile;
    return expectDumpFilePath;
}

bool IsFileExist(const std::string &filePath)
{
    return access(filePath.c_str(), F_OK) == 0;
}
}  // namespace Adx