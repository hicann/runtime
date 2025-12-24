/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DUMP_OPERATOR_H
#define DUMP_OPERATOR_H

#include <string>
#include <vector>
#include <sstream>
#include "adump_pub.h"
#include "dump_tensor.h"
#include "kernel_info_collector.h"

namespace Adx {
struct DumpWorkspace {
    DumpWorkspace() = default;
    DumpWorkspace(const void *wsAddr, uint64_t wsBytes, uint32_t wsArgsOffset)
        : addr(wsAddr),
          bytes(wsBytes),
          argsOffset(wsArgsOffset)
    {
    }
    const void *addr;
    uint64_t bytes;
    uint32_t argsOffset;
};

struct OpIdentity {
    OpIdentity() = default;
    OpIdentity(uint32_t deviceid, uint32_t taskid, uint32_t streamid)
        : deviceId(deviceid),
          taskId(taskid),
          streamId(streamid)
    {
    }
    OpIdentity(uint32_t deviceid, uint32_t taskid, uint32_t streamid, uint32_t contextid)
        : deviceId(deviceid),
          taskId(taskid),
          streamId(streamid),
          contextId(contextid)
    {
    }

    bool operator==(const OpIdentity &rhs) const;
    std::string GetString() const;

    uint32_t deviceId = 0U;
    uint32_t taskId = 0U;
    uint32_t streamId = 0U;
    uint32_t contextId = UINT32_MAX;
};

class DumpOperator {
public:
    DumpOperator() = default;
    void Init(const OperatorInfoV2 &opInfo);
    bool IsBelongTo(const OpIdentity &identity) const;
    int32_t LogExceptionInfo(const rtExceptionArgsInfo &argsInfo);
    int32_t CopyOpKernelFile() const;
    int32_t RefreshAddrs(const rtExceptionArgsInfo &argsInfo);
    int32_t DumpException(const uint32_t deviceId, const std::string &dumpPath);
    explicit DumpOperator(const OperatorInfoV2 &opInfo);

private:
    int32_t DumpExceptionFile(const uint32_t deviceId, const std::string &dumpPath);
    void InitDeviceArgs();
    bool IsTvmOperator() const;
    std::string GetTensorString(const DumpTensor &tensor);
    int32_t LogExceptionArgs(const rtExceptionArgsInfo &argsInfo) const;
    std::string GetDumpFilePath(const std::string &dumpPath) const;
    void PrintAdditionInfo(const char *flag) const;
    void PrintLog(void *const *argsOnHost, size_t argNum, const std::string &tag) const;
    void RecordCurrentLog(std::ostringstream &oss);

    // basic info
    std::string opName_;
    std::string opType_;
    OpIdentity identity_;

    std::vector<DeviceInfo> deviceInfos_;
    // args
    std::vector<void *> hostArgs_;

    // addition info
    std::map<std::string, std::string> additions_;
    std::string isHostArgs_;

    std::vector<DumpTensor> inputTensors_;
    std::vector<DumpTensor> outputTensors_;
    std::vector<DumpWorkspace> workspaces_;
    // log record
    std::vector<std::string> logRecord_;

    KernelInfoCollector kernelCollector_;
};
}  // namespace Adx
#endif  // DUMP_OPERATOR_H