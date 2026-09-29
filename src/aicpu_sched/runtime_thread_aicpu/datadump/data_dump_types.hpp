/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef RUNTIME_THREAD_AICPU_DATA_DUMP_TYPES_HPP
#define RUNTIME_THREAD_AICPU_DATA_DUMP_TYPES_HPP

#include <cstddef>
#include <cstdint>
#include <limits>
#include <memory>
#include <string>
#include <unordered_map>
#include <vector>

namespace cce {
namespace runtime_thread_aicpu {
namespace datadump {

enum class DumpInfoAction : uint32_t {
    UNLOAD = 0U,
    LOAD = 1U,
};

enum class DumpMode : uint32_t {
    INPUT = 0U,
    OUTPUT = 1U,
    ALL = 2U,
};

enum class DumpOutputType : uint64_t {
    STATS = 0U,
    TENSOR = 1U,
};

enum class AddressType : int32_t {
    TRADITIONAL_ADDR = 0,
    NOTILING_ADDR = 1,
    RAW_ADDR = 2,
    NANO_IO_ADDR = 3,
    NANO_WEIGHT_ADDR = 4,
    NANO_WORK_ADDR = 5,
};

enum class DataDumpTaskType : int32_t {
    AICORE = 0,
    AICPU = 1,
    DEBUG = 2,
    SDMA = 3,
    FFTSPLUS = 4,
    DSA = 5,
};

enum class WorkspaceType : int32_t {
    LOG = 0,
};

enum class BufferType : uint8_t {
    L1 = 0U,
};

struct TaskKey {
    TaskKey() = default;
    TaskKey(const uint16_t stream, const uint16_t task) : streamId(stream), taskId(task) {}

    uint16_t streamId = 0U;
    uint16_t taskId = 0U;

    bool operator==(const TaskKey& other) const { return (streamId == other.streamId) && (taskId == other.taskId); }
};

struct TaskKeyHash {
    size_t operator()(const TaskKey& key) const
    {
        return static_cast<size_t>(
            (static_cast<uint32_t>(key.streamId) << std::numeric_limits<uint16_t>::digits) | key.taskId);
    }
};

struct MemoryRegion {
    AddressType addressType = AddressType::RAW_ADDR;
    uint64_t address = 0U;
    uint64_t offset = 0U;
    uint64_t size = 0U;
};

struct TensorDumpInfo {
    int32_t dataType = 0;
    int32_t format = 0;
    MemoryRegion memory;
    std::vector<int64_t> shape;
    std::vector<int64_t> originalShape;
};

struct InputDumpInfo : public TensorDumpInfo {};

struct OutputDumpInfo : public TensorDumpInfo {
    int32_t originalIndex = 0;
    int32_t originalDataType = 0;
    int32_t originalFormat = 0;
    std::string originalName;
};

struct WorkspaceDumpInfo {
    WorkspaceType type = WorkspaceType::LOG;
    uint64_t dataAddress = 0U;
    uint64_t size = 0U;
};

struct OpBufferInfo {
    BufferType type = BufferType::L1;
    uint64_t address = 0U;
    uint64_t size = 0U;
};

struct MemoryUsageInfo {
    uint64_t inputSize = 0U;
    uint64_t outputSize = 0U;
    uint64_t weightSize = 0U;
    uint64_t workspaceSize = 0U;
    uint64_t totalSize = 0U;
};

struct ModelDumpConfig {
    uint32_t modelId = 0U;
    std::string modelName;
    std::string dumpPath;
    uint64_t stepIdAddress = 0U;
    uint64_t iterationsPerLoopAddress = 0U;
    uint64_t loopCondAddress = 0U;
    DumpMode dumpMode = DumpMode::ALL;
    DumpOutputType dumpOutputType = DumpOutputType::STATS;
};

using ModelDumpConfigPtr = std::shared_ptr<const ModelDumpConfig>;

struct OpDumpInfo {
    TaskKey taskKey;
    ModelDumpConfigPtr config;
    uint32_t logicStreamId = 0U;
    DataDumpTaskType taskType = DataDumpTaskType::AICORE;
    uint32_t blockDim = 0U;
    bool isMultiOp = false;
    std::string opName;
    std::string opType;
    std::vector<std::string> originalOpNames;
    std::string l1SubGraphNo;
    std::vector<InputDumpInfo> inputList;
    std::vector<OutputDumpInfo> outputList;
    std::vector<uint8_t> inputDescTlv;
    std::vector<uint8_t> outputDescTlv;
    std::vector<WorkspaceDumpInfo> workspaces;
    std::vector<OpBufferInfo> buffers;
    std::vector<MemoryUsageInfo> memoryUsage;
};

using OpDumpInfoPtr = std::shared_ptr<OpDumpInfo>;
using ConstOpDumpInfoPtr = std::shared_ptr<const OpDumpInfo>;

struct ModelDumpInfo {
    ModelDumpConfigPtr config;
    std::unordered_map<TaskKey, OpDumpInfoPtr, TaskKeyHash> ops;
};

using ModelDumpInfoPtr = std::shared_ptr<ModelDumpInfo>;

struct ParsedDumpCommand {
    DumpInfoAction action = DumpInfoAction::LOAD;
    uint32_t modelId = 0U;
    ModelDumpInfoPtr model;
};

} // namespace datadump
} // namespace runtime_thread_aicpu
} // namespace cce

#endif
