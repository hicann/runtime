/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef OPERATOR_DUMPER_H
#define OPERATOR_DUMPER_H
#include <string>
#include <vector>
#include "proto/op_mapping.pb.h"
#include "dump_setting.h"
#include "dump_tensor.h"

namespace Adx {
class OperatorDumper {
public:
    OperatorDumper(const std::string &opType, const std::string &opName);
    OperatorDumper &SetDumpSetting(const DumpSetting &setting);
    OperatorDumper &InputDumpTensor(const std::vector<DumpTensor> &inputTensors);
    OperatorDumper &OutputDumpTensor(const std::vector<DumpTensor> &outputTensors);
    OperatorDumper &RuntimeStream(aclrtStream stream);
    int32_t Launch();

private:
    int32_t FillOpMappinfInfo();
    int32_t FillDumpPath(int32_t deviceId);
    int32_t FillDumpTask(int32_t deviceId);
    void DumpInput(toolkit::aicpu::dump::Task &task);
    void DumpOutput(toolkit::aicpu::dump::Task &task);

    int32_t LaunchDumpKernal() const;
    int32_t LaunchDumpKernal(const void *const protoMsgDevMem, const void *const protoMsgSizeDevMem) const;

    std::string opType_;
    std::string opName_;
    DumpSetting setting_;
    std::vector<DumpTensor> inputTensors_;
    std::vector<DumpTensor> outputTensors_;
    aclrtStream stream_;
    toolkit::aicpu::dump::OpMappingInfo opMappingInfo_;
};
} // namespace Adx
#endif // OPERATOR_DUMPER_H