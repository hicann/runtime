/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ADUMP_EXCEPTION_DUMP_FILE_H
#define ADUMP_EXCEPTION_DUMP_FILE_H

#include <string>
#include <vector>

#include "proto/dump_task.pb.h"
#include "file.h"
#include "dump_operator.h"
#include "dump_tensor.h"
#include "dump_args.h"

namespace Adx {
class DumpFile {
public:
    DumpFile(const uint32_t deviceId, const std::string &filePath) : deviceId_(deviceId),
        file_(filePath, M_RDWR | M_CREAT | M_APPEND, M_IRUSR | M_IWUSR) {}
    void SetHeader(const std::string &opName);
    void SetInputTensors(const std::vector<DumpTensor> &inputTensors);
    void SetOutputTensors(const std::vector<DumpTensor> &outputTensors);
    void SetWorkspaces(const std::vector<DumpWorkspace> &workspaces);
    void SetInputBuffer(const std::vector<InputBuffer> input);
    void SetTensorBuffer(const std::vector<TensorBuffer> &tensorBuffer);
    int32_t Dump(std::vector<std::string> &record);
#if !defined(ADUMP_SOC_HOST) || ADUMP_SOC_HOST == 1
    void SetMc2spaces(const std::vector<DumpWorkspace> &mc2Spaces);
#endif

private:
    void SetAicInfo(std::vector<std::string> &record);
    int32_t WriteHeader() const;
    int32_t WriteInputTensors();
    int32_t WriteOutputTensors();
    int32_t WriteWorkspace();
    int32_t WriteMc2Space() const;
    int32_t WriteInputBuffer();

    struct DeviceData {
        DeviceData(const void *data, uint64_t size) : addr(data), bytes(size) {}
        const void *addr;
        uint64_t bytes;
    };
    int32_t WriteDeviceDataToFile(const DeviceData &devData) const;
    void LogIsOtherDeviceAddress(const DeviceData &devData, rtMemInfo_t &memInfo) const;
    int32_t AllocDefaultMemory(void **hostPtr, uint64_t size) const;
#if !defined(ADUMP_SOC_HOST) || ADUMP_SOC_HOST == 1
    uint64_t ComputeStructSize() const;
    uint64_t HandleMc2Ctx(const void *hostData, uint64_t opParamSize, size_t index);
    void HandleMc2CtxV1(const void *hostData, uint64_t &totalSize, std::vector<DeviceData> &dataList) const;
    uint64_t GetMc2DataSize(const void *addr, size_t index, uint64_t &opParamSize);
#endif

    uint32_t deviceId_;
    File file_;
    // file format
    toolkit::dump::DumpData header_;
    std::vector<DeviceData> inputs_;
    std::vector<DeviceData> outputs_;
    std::vector<DeviceData> workspaces_;
    std::vector<DeviceData> inputBuffer_;
    // log record
    std::vector<std::string> logRecord_;
#if !defined(ADUMP_SOC_HOST) || ADUMP_SOC_HOST == 1
    std::vector<DeviceData> mc2Spaces_;
    std::map<size_t, std::vector<DeviceData>> mc2Ctx_;
#endif
};
}  // namespace Adx
#endif  // ADUMP_EXCEPTION_DUMP_FILE_H