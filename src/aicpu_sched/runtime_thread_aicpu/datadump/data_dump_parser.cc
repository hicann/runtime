/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "data_dump_parser.hpp"

#include <array>
#include <limits>
#include <memory>
#include <new>
#include <utility>
#include <vector>

#include "securec.h"
#include "aicpu_sched/aicpu_schedule/common/aicpusd_status.h"
#include "aicpu_sched/common/type_def.h"
#include "data_dump_tlv.hpp"

namespace cce {
namespace runtime_thread_aicpu {
namespace datadump {
namespace {

class Cursor final {
public:
    Cursor(const uint8_t* const data, const size_t size) : data_(data), size_(size) {}

    template <typename T>
    bool Read(T& value)
    {
        if (sizeof(T) > Remaining()) {
            return false;
        }
        if (memcpy_s(&value, sizeof(T), data_ + offset_, sizeof(T)) != EOK) {
            return false;
        }
        offset_ += sizeof(T);
        return true;
    }

    bool Take(const size_t length, Cursor& subCursor)
    {
        if (length > Remaining()) {
            return false;
        }
        subCursor = Cursor(data_ + offset_, length);
        offset_ += length;
        return true;
    }

    void ReadString(std::string& value)
    {
        value.assign(PtrToPtr<uint8_t, const char>(data_ + offset_), Remaining());
        offset_ = size_;
    }

    const uint8_t* Current() const { return data_ + offset_; }
    size_t Remaining() const { return size_ - offset_; }
    bool Empty() const { return offset_ == size_; }

private:
    const uint8_t* data_ = nullptr;
    size_t size_ = 0U;
    size_t offset_ = 0U;
};

bool Fail(std::string& errorDetail, const char* const detail)
{
    errorDetail = detail;
    return false;
}

bool ReadTlv(Cursor& cursor, tlv::TlvHeader& header, Cursor& value, std::string& errorDetail)
{
    if (!cursor.Read(header)) {
        return Fail(errorDetail, "truncated TLV header");
    }
    if (!cursor.Take(header.length, value)) {
        return Fail(errorDetail, "TLV value exceeds its enclosing buffer");
    }
    return true;
}

bool ParseStringList(Cursor& cursor, std::vector<std::string>& values, std::string& errorDetail)
{
    while (!cursor.Empty()) {
        uint32_t length = 0U;
        if (!cursor.Read(length)) {
            return Fail(errorDetail, "truncated string-list element length");
        }
        Cursor value(nullptr, 0U);
        if (!cursor.Take(length, value)) {
            return Fail(errorDetail, "string-list element exceeds TLV value");
        }
        std::string item;
        value.ReadString(item);
        values.emplace_back(std::move(item));
    }
    return true;
}

bool ParseShape(Cursor& cursor, std::vector<int64_t>& shape, std::string& errorDetail)
{
    if ((cursor.Remaining() % sizeof(int64_t)) != 0U) {
        return Fail(errorDetail, "shape TLV length is not a multiple of int64_t");
    }
    const size_t count = cursor.Remaining() / sizeof(int64_t);
    shape.reserve(count);
    for (size_t index = 0U; index < count; ++index) {
        int64_t dimension = 0;
        if (!cursor.Read(dimension)) {
            return Fail(errorDetail, "truncated shape dimension");
        }
        shape.emplace_back(dimension);
    }
    return true;
}

bool ParseTensorNested(
    Cursor& cursor, TensorDumpInfo& tensor, std::string* const originalName, std::string& errorDetail)
{
    constexpr size_t tensorLevel3TypeCount = static_cast<size_t>(tlv::TensorLevel3Type::ORIGINAL_NAME) + 1U;
    std::array<bool, tensorLevel3TypeCount> seen = {};
    while (!cursor.Empty()) {
        tlv::TlvHeader header = {};
        Cursor value(nullptr, 0U);
        if (!ReadTlv(cursor, header, value, errorDetail)) {
            return false;
        }
        if (header.type > static_cast<uint32_t>(tlv::TensorLevel3Type::ORIGINAL_NAME)) {
            continue;
        }
        if (seen[header.type]) {
            return Fail(errorDetail, "duplicate tensor level-3 TLV");
        }
        seen[header.type] = true;
        switch (static_cast<tlv::TensorLevel3Type>(header.type)) {
            case tlv::TensorLevel3Type::SHAPE:
                if (!ParseShape(value, tensor.shape, errorDetail)) {
                    return false;
                }
                break;
            case tlv::TensorLevel3Type::ORIGINAL_SHAPE:
                if (!ParseShape(value, tensor.originalShape, errorDetail)) {
                    return false;
                }
                break;
            case tlv::TensorLevel3Type::ORIGINAL_NAME:
                if (originalName == nullptr) {
                    return Fail(errorDetail, "input descriptor contains an output-only original-name TLV");
                }
                value.ReadString(*originalName);
                break;
            default:
                break;
        }
    }
    return true;
}

bool IsKnownAddressType(const int32_t value)
{
    return (value >= static_cast<int32_t>(AddressType::TRADITIONAL_ADDR)) &&
           (value <= static_cast<int32_t>(AddressType::NANO_WORK_ADDR));
}

bool SetMemoryRegion(
    const int32_t addressType, const uint64_t address, const uint64_t offset, const uint64_t size, MemoryRegion& memory,
    std::string& errorDetail)
{
    if (!IsKnownAddressType(addressType)) {
        return Fail(errorDetail, "invalid tensor address type");
    }
    if (offset > (std::numeric_limits<uint64_t>::max() - address)) {
        return Fail(errorDetail, "tensor address and offset overflow uint64_t");
    }
    memory.addressType = static_cast<AddressType>(addressType);
    memory.address = address;
    memory.offset = offset;
    memory.size = size;
    return true;
}

bool ParseInputList(Cursor& cursor, std::vector<InputDumpInfo>& inputs, std::string& errorDetail)
{
    tlv::ListPrefix list = {};
    if (!cursor.Read(list)) {
        return Fail(errorDetail, "truncated input list prefix");
    }
    if (list.count > (cursor.Remaining() / sizeof(tlv::InputDescPrefix))) {
        return Fail(errorDetail, "input count exceeds TLV value");
    }
    inputs.reserve(list.count);
    for (uint32_t index = 0U; index < list.count; ++index) {
        tlv::InputDescPrefix prefix = {};
        if (!cursor.Read(prefix)) {
            return Fail(errorDetail, "truncated input descriptor");
        }
        Cursor nested(nullptr, 0U);
        if (!cursor.Take(prefix.nestedLength, nested)) {
            return Fail(errorDetail, "input level-3 TLVs exceed input list");
        }
        InputDumpInfo input;
        input.dataType = prefix.dataType;
        input.format = prefix.format;
        if (!SetMemoryRegion(
                prefix.addressType, prefix.address, prefix.offset, prefix.size, input.memory, errorDetail) ||
            !ParseTensorNested(nested, input, nullptr, errorDetail)) {
            return false;
        }
        inputs.emplace_back(std::move(input));
    }
    return cursor.Empty() || Fail(errorDetail, "input list has trailing bytes");
}

bool ParseOutputList(Cursor& cursor, std::vector<OutputDumpInfo>& outputs, std::string& errorDetail)
{
    tlv::ListPrefix list = {};
    if (!cursor.Read(list)) {
        return Fail(errorDetail, "truncated output list prefix");
    }
    if (list.count > (cursor.Remaining() / sizeof(tlv::OutputDescPrefix))) {
        return Fail(errorDetail, "output count exceeds TLV value");
    }
    outputs.reserve(list.count);
    for (uint32_t index = 0U; index < list.count; ++index) {
        tlv::OutputDescPrefix prefix = {};
        if (!cursor.Read(prefix)) {
            return Fail(errorDetail, "truncated output descriptor");
        }
        Cursor nested(nullptr, 0U);
        if (!cursor.Take(prefix.nestedLength, nested)) {
            return Fail(errorDetail, "output level-3 TLVs exceed output list");
        }
        OutputDumpInfo output;
        output.dataType = prefix.dataType;
        output.format = prefix.format;
        output.originalIndex = prefix.originalIndex;
        output.originalDataType = prefix.originalDataType;
        output.originalFormat = prefix.originalFormat;
        if (!SetMemoryRegion(
                prefix.addressType, prefix.address, prefix.offset, prefix.size, output.memory, errorDetail) ||
            !ParseTensorNested(nested, output, &output.originalName, errorDetail)) {
            return false;
        }
        outputs.emplace_back(std::move(output));
    }
    return cursor.Empty() || Fail(errorDetail, "output list has trailing bytes");
}

bool ParseWorkspaceList(Cursor& cursor, std::vector<WorkspaceDumpInfo>& workspaces, std::string& errorDetail)
{
    tlv::ListPrefix list = {};
    if (!cursor.Read(list)) {
        return Fail(errorDetail, "truncated workspace list prefix");
    }
    if (list.count > (cursor.Remaining() / sizeof(tlv::WorkspaceDescPrefix))) {
        return Fail(errorDetail, "workspace count exceeds TLV value");
    }
    workspaces.reserve(list.count);
    for (uint32_t index = 0U; index < list.count; ++index) {
        tlv::WorkspaceDescPrefix prefix = {};
        if (!cursor.Read(prefix)) {
            return Fail(errorDetail, "truncated workspace descriptor");
        }
        Cursor nested(nullptr, 0U);
        if (!cursor.Take(prefix.nestedLength, nested)) {
            return Fail(errorDetail, "workspace level-3 TLVs exceed workspace list");
        }
        if (prefix.type != static_cast<int32_t>(WorkspaceType::LOG)) {
            return Fail(errorDetail, "invalid workspace type");
        }
        WorkspaceDumpInfo workspace;
        workspace.type = static_cast<WorkspaceType>(prefix.type);
        workspace.dataAddress = prefix.dataAddress;
        workspace.size = prefix.size;
        workspaces.emplace_back(workspace);
    }
    return cursor.Empty() || Fail(errorDetail, "workspace list has trailing bytes");
}

bool ParseBufferList(Cursor& cursor, std::vector<OpBufferInfo>& buffers, std::string& errorDetail)
{
    tlv::ListPrefix list = {};
    if (!cursor.Read(list)) {
        return Fail(errorDetail, "truncated op-buffer list prefix");
    }
    if (list.count > (cursor.Remaining() / sizeof(tlv::OpBufferPrefix))) {
        return Fail(errorDetail, "op-buffer count exceeds TLV value");
    }
    buffers.reserve(list.count);
    for (uint32_t index = 0U; index < list.count; ++index) {
        tlv::OpBufferPrefix prefix = {};
        if (!cursor.Read(prefix)) {
            return Fail(errorDetail, "truncated op-buffer descriptor");
        }
        Cursor nested(nullptr, 0U);
        if (!cursor.Take(prefix.nestedLength, nested)) {
            return Fail(errorDetail, "op-buffer level-3 TLVs exceed op-buffer list");
        }
        if (prefix.type != static_cast<uint8_t>(BufferType::L1)) {
            return Fail(errorDetail, "invalid op-buffer type");
        }
        OpBufferInfo buffer;
        buffer.type = static_cast<BufferType>(prefix.type);
        buffer.address = prefix.address;
        buffer.size = prefix.size;
        buffers.emplace_back(buffer);
    }
    return cursor.Empty() || Fail(errorDetail, "op-buffer list has trailing bytes");
}

bool ParseMemoryInfoList(Cursor& cursor, std::vector<MemoryUsageInfo>& memoryUsage, std::string& errorDetail)
{
    tlv::ListPrefix list = {};
    if (!cursor.Read(list)) {
        return Fail(errorDetail, "truncated memory-info list prefix");
    }
    if (list.count > (cursor.Remaining() / sizeof(tlv::MemoryInfoPrefix))) {
        return Fail(errorDetail, "memory-info count exceeds TLV value");
    }
    memoryUsage.reserve(list.count);
    for (uint32_t index = 0U; index < list.count; ++index) {
        tlv::MemoryInfoPrefix prefix = {};
        if (!cursor.Read(prefix)) {
            return Fail(errorDetail, "truncated memory-info descriptor");
        }
        Cursor nested(nullptr, 0U);
        if (!cursor.Take(prefix.nestedLength, nested)) {
            return Fail(errorDetail, "memory-info level-3 TLVs exceed memory-info list");
        }
        MemoryUsageInfo info;
        info.inputSize = prefix.inputSize;
        info.outputSize = prefix.outputSize;
        info.weightSize = prefix.weightSize;
        info.workspaceSize = prefix.workspaceSize;
        info.totalSize = prefix.totalSize;
        memoryUsage.emplace_back(info);
    }
    return cursor.Empty() || Fail(errorDetail, "memory-info list has trailing bytes");
}

bool ParseOpNested(Cursor& cursor, OpDumpInfo& op, std::string& errorDetail)
{
    constexpr size_t level2TypeCount = static_cast<size_t>(tlv::Level2Type::MEMORY_INFO) + 1U;
    std::array<bool, level2TypeCount> seen = {};
    while (!cursor.Empty()) {
        const uint8_t* const tlvBegin = cursor.Current();
        const size_t remainingBeforeRead = cursor.Remaining();
        tlv::TlvHeader header = {};
        Cursor value(nullptr, 0U);
        if (!ReadTlv(cursor, header, value, errorDetail)) {
            return false;
        }
        const size_t tlvSize = remainingBeforeRead - cursor.Remaining();
        if (header.type > static_cast<uint32_t>(tlv::Level2Type::MEMORY_INFO)) {
            continue;
        }
        if (seen[header.type]) {
            return Fail(errorDetail, "duplicate op level-2 TLV");
        }
        seen[header.type] = true;
        switch (static_cast<tlv::Level2Type>(header.type)) {
            case tlv::Level2Type::OP_NAME:
                value.ReadString(op.opName);
                break;
            case tlv::Level2Type::OP_TYPE:
                value.ReadString(op.opType);
                break;
            case tlv::Level2Type::ORIGINAL_OP_NAME:
                if (!ParseStringList(value, op.originalOpNames, errorDetail)) {
                    return false;
                }
                break;
            case tlv::Level2Type::L1_SUB_GRAPH_NO:
                value.ReadString(op.l1SubGraphNo);
                break;
            case tlv::Level2Type::INPUT_DESC:
                op.inputDescTlv.assign(tlvBegin, tlvBegin + tlvSize);
                if (!ParseInputList(value, op.inputList, errorDetail)) {
                    return false;
                }
                break;
            case tlv::Level2Type::OUTPUT_DESC:
                op.outputDescTlv.assign(tlvBegin, tlvBegin + tlvSize);
                if (!ParseOutputList(value, op.outputList, errorDetail)) {
                    return false;
                }
                break;
            case tlv::Level2Type::WORKSPACE_DESC:
                if (!ParseWorkspaceList(value, op.workspaces, errorDetail)) {
                    return false;
                }
                break;
            case tlv::Level2Type::OP_BUFFER:
                if (!ParseBufferList(value, op.buffers, errorDetail)) {
                    return false;
                }
                break;
            case tlv::Level2Type::MEMORY_INFO:
                if (!ParseMemoryInfoList(value, op.memoryUsage, errorDetail)) {
                    return false;
                }
                break;
            default:
                break;
        }
    }
    if (op.opName.empty() || op.opType.empty()) {
        return Fail(errorDetail, "op descriptor is missing its name or type");
    }
    return true;
}

bool IsKnownTaskType(const int32_t value)
{
    return (value >= static_cast<int32_t>(DataDumpTaskType::AICORE)) &&
           (value <= static_cast<int32_t>(DataDumpTaskType::DSA));
}

bool ParseOpList(Cursor& cursor, std::vector<OpDumpInfoPtr>& ops, std::string& errorDetail)
{
    tlv::ListPrefix list = {};
    if (!cursor.Read(list)) {
        return Fail(errorDetail, "truncated op list prefix");
    }
    if (list.count > (cursor.Remaining() / sizeof(tlv::OpDescPrefix))) {
        return Fail(errorDetail, "op count exceeds TLV value");
    }
    ops.reserve(list.count);
    for (uint32_t index = 0U; index < list.count; ++index) {
        tlv::OpDescPrefix prefix = {};
        if (!cursor.Read(prefix)) {
            return Fail(errorDetail, "truncated op descriptor");
        }
        if ((prefix.streamId > std::numeric_limits<uint16_t>::max()) ||
            (prefix.taskId > std::numeric_limits<uint16_t>::max())) {
            return Fail(errorDetail, "op stream ID or task ID exceeds callback-report width");
        }
        if (!IsKnownTaskType(prefix.taskType)) {
            return Fail(errorDetail, "invalid DataDump task type");
        }
        if (prefix.isMultiOp > 1U) {
            return Fail(errorDetail, "invalid is-multi-op value");
        }
        Cursor nested(nullptr, 0U);
        if (!cursor.Take(prefix.nestedLength, nested)) {
            return Fail(errorDetail, "op level-2 TLVs exceed op list");
        }
        OpDumpInfoPtr op = std::make_shared<OpDumpInfo>();
        op->taskKey.streamId = static_cast<uint16_t>(prefix.streamId);
        op->taskKey.taskId = static_cast<uint16_t>(prefix.taskId);
        op->logicStreamId = prefix.logicStreamId;
        op->taskType = static_cast<DataDumpTaskType>(prefix.taskType);
        op->blockDim = prefix.blockDim;
        op->isMultiOp = prefix.isMultiOp != 0U;
        if (!ParseOpNested(nested, *op, errorDetail)) {
            return false;
        }
        ops.emplace_back(std::move(op));
    }
    return cursor.Empty() || Fail(errorDetail, "op list has trailing bytes");
}

bool ParseModelDesc(Cursor& cursor, tlv::ModelDescPrefix& model, std::string& errorDetail)
{
    if (!cursor.Read(model)) {
        return Fail(errorDetail, "truncated model descriptor");
    }
    Cursor nested(nullptr, 0U);
    if (!cursor.Take(model.nestedLength, nested)) {
        return Fail(errorDetail, "model level-2 TLVs exceed model descriptor");
    }
    if (!cursor.Empty()) {
        return Fail(errorDetail, "model descriptor has trailing bytes");
    }
    if ((model.action != static_cast<uint32_t>(DumpInfoAction::UNLOAD)) &&
        (model.action != static_cast<uint32_t>(DumpInfoAction::LOAD))) {
        return Fail(errorDetail, "invalid DataDump action");
    }
    if (model.dumpMode > static_cast<uint32_t>(DumpMode::ALL)) {
        return Fail(errorDetail, "invalid DataDump mode");
    }
    if (model.dumpData > static_cast<uint64_t>(DumpOutputType::TENSOR)) {
        return Fail(errorDetail, "invalid DataDump data type");
    }
    return true;
}

RuntimeThreadAicpuStatus ValidateSupportedScope(const ModelDumpInfo& model, std::string& errorDetail)
{
    for (const auto& item : model.ops) {
        const OpDumpInfo& op = *item.second;
        if ((op.taskType != DataDumpTaskType::AICORE) || op.isMultiOp) {
            errorDetail = "only ordinary AI Core operators are supported in this phase";
            return RuntimeThreadAicpuStatus::NOT_SUPPORTED;
        }
        for (const InputDumpInfo& input : op.inputList) {
            if (input.memory.addressType != AddressType::RAW_ADDR) {
                errorDetail = "only raw host addresses are supported for DataDump inputs in this phase";
                return RuntimeThreadAicpuStatus::NOT_SUPPORTED;
            }
        }
        for (const OutputDumpInfo& output : op.outputList) {
            if (output.memory.addressType != AddressType::RAW_ADDR) {
                errorDetail = "only raw host addresses are supported for DataDump outputs in this phase";
                return RuntimeThreadAicpuStatus::NOT_SUPPORTED;
            }
        }
    }
    return RuntimeThreadAicpuStatus::OK;
}

RuntimeThreadAicpuStatus ParseDumpInfo(
    const void* const dumpInfo, const uint32_t length, ParsedDumpCommand& command, std::string& errorDetail)
{
    if ((dumpInfo == nullptr) || (length < sizeof(tlv::DataHeader))) {
        errorDetail = "DataDump TLV buffer is null or shorter than its header";
        return RuntimeThreadAicpuStatus::INVALID_PARAM;
    }
    Cursor cursor(static_cast<const uint8_t*>(dumpInfo), length);
    tlv::DataHeader dataHeader = {};
    if (!cursor.Read(dataHeader) || (dataHeader.version != tlv::DATA_VERSION) ||
        (dataHeader.magic != tlv::DATA_MAGIC)) {
        errorDetail = "invalid DataDump TLV version or magic";
        return RuntimeThreadAicpuStatus::DATADUMP_PARSE_FAILED;
    }

    constexpr size_t level1TypeCount = static_cast<size_t>(tlv::Level1Type::DUMP_PATH) + 1U;
    std::array<bool, level1TypeCount> seen = {};
    std::string modelName;
    std::string dumpPath;
    std::vector<OpDumpInfoPtr> ops;
    tlv::ModelDescPrefix modelDesc = {};
    while (!cursor.Empty()) {
        tlv::TlvHeader header = {};
        Cursor value(nullptr, 0U);
        if (!ReadTlv(cursor, header, value, errorDetail)) {
            return RuntimeThreadAicpuStatus::DATADUMP_PARSE_FAILED;
        }
        if (header.type > static_cast<uint32_t>(tlv::Level1Type::DUMP_PATH)) {
            continue;
        }
        if (seen[header.type]) {
            errorDetail = "duplicate DataDump level-1 TLV";
            return RuntimeThreadAicpuStatus::DATADUMP_PARSE_FAILED;
        }
        seen[header.type] = true;
        bool success = true;
        switch (static_cast<tlv::Level1Type>(header.type)) {
            case tlv::Level1Type::MODEL_NAME:
                value.ReadString(modelName);
                break;
            case tlv::Level1Type::OP_DESC:
                success = ParseOpList(value, ops, errorDetail);
                break;
            case tlv::Level1Type::MODEL_DESC:
                success = ParseModelDesc(value, modelDesc, errorDetail);
                break;
            case tlv::Level1Type::DUMP_PATH:
                value.ReadString(dumpPath);
                break;
            default:
                break;
        }
        if (!success) {
            return RuntimeThreadAicpuStatus::DATADUMP_PARSE_FAILED;
        }
    }

    if (!seen[static_cast<uint32_t>(tlv::Level1Type::MODEL_DESC)]) {
        errorDetail = "DataDump TLV is missing the model descriptor";
        return RuntimeThreadAicpuStatus::DATADUMP_PARSE_FAILED;
    }
    command.action = static_cast<DumpInfoAction>(modelDesc.action);
    command.modelId = modelDesc.modelId;
    if (command.action == DumpInfoAction::UNLOAD) {
        command.model.reset();
        return RuntimeThreadAicpuStatus::OK;
    }
    if (!seen[static_cast<uint32_t>(tlv::Level1Type::MODEL_NAME)] ||
        !seen[static_cast<uint32_t>(tlv::Level1Type::OP_DESC)] ||
        !seen[static_cast<uint32_t>(tlv::Level1Type::DUMP_PATH)] || modelName.empty() || dumpPath.empty()) {
        errorDetail = "DataDump load TLV is missing its model name, op list, or dump path";
        return RuntimeThreadAicpuStatus::DATADUMP_PARSE_FAILED;
    }

    std::shared_ptr<ModelDumpConfig> config = std::make_shared<ModelDumpConfig>();
    config->modelId = modelDesc.modelId;
    config->modelName = std::move(modelName);
    config->dumpPath = std::move(dumpPath);
    config->stepIdAddress = modelDesc.stepIdAddress;
    config->iterationsPerLoopAddress = modelDesc.iterationsPerLoopAddress;
    config->loopCondAddress = modelDesc.loopCondAddress;
    config->dumpMode = static_cast<DumpMode>(modelDesc.dumpMode);
    config->dumpOutputType = static_cast<DumpOutputType>(modelDesc.dumpData);

    ModelDumpInfoPtr model = std::make_shared<ModelDumpInfo>();
    model->config = config;
    for (const OpDumpInfoPtr& op : ops) {
        op->config = config;
        const auto previous = model->ops.find(op->taskKey);
        if (previous != model->ops.end()) {
            aicpusd_warn(
                "Duplicate DataDump task key in one model; the later op wins, model_id=%u, stream_id=%u, task_id=%u.",
                config->modelId, static_cast<uint32_t>(op->taskKey.streamId),
                static_cast<uint32_t>(op->taskKey.taskId));
        }
        model->ops[op->taskKey] = op;
    }
    const RuntimeThreadAicpuStatus scopeStatus = ValidateSupportedScope(*model, errorDetail);
    if (scopeStatus != RuntimeThreadAicpuStatus::OK) {
        return scopeStatus;
    }
    command.model = std::move(model);
    return RuntimeThreadAicpuStatus::OK;
}

} // namespace

RuntimeThreadAicpuStatus DataDumpParser::Parse(
    const void* const dumpInfo, const uint32_t length, ParsedDumpCommand& command, std::string& errorDetail) const
{
    command = ParsedDumpCommand();
    errorDetail.clear();
    try {
        return ParseDumpInfo(dumpInfo, length, command, errorDetail);
    } catch (const std::bad_alloc&) {
        command = ParsedDumpCommand();
        errorDetail = "memory allocation failed while parsing DataDump TLV";
        return RuntimeThreadAicpuStatus::NO_MEMORY;
    } catch (...) {
        command = ParsedDumpCommand();
        errorDetail = "unexpected exception while parsing DataDump TLV";
        return RuntimeThreadAicpuStatus::INTERNAL_ERROR;
    }
}

} // namespace datadump
} // namespace runtime_thread_aicpu
} // namespace cce
