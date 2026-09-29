/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <algorithm>
#include <array>
#include <atomic>
#include <cstdlib>
#include <cstdint>
#include <cstring>
#include <dirent.h>
#include <fstream>
#include <iterator>
#include <limits>
#include <memory>
#include <mutex>
#include <sstream>
#include <string>
#include <sys/stat.h>
#include <thread>
#include <unordered_map>
#include <unistd.h>
#include <vector>

#include <gtest/gtest.h>

#include "datadump/data_dump_manager.hpp"
#include "datadump/data_dump_parser.hpp"
#include "datadump/data_dump_tlv.hpp"
#include "datadump/data_dump_writer.hpp"

#define private public
#include "runtime_thread_aicpu_service.hpp"
#undef private

namespace {

using cce::runtime_thread_aicpu::RuntimeThreadAicpuService;
using cce::runtime_thread_aicpu::datadump::AddressType;
using cce::runtime_thread_aicpu::datadump::BufferType;
using cce::runtime_thread_aicpu::datadump::ConstOpDumpInfoPtr;
using cce::runtime_thread_aicpu::datadump::DataDumpManager;
using cce::runtime_thread_aicpu::datadump::DataDumpParser;
using cce::runtime_thread_aicpu::datadump::DataDumpTaskType;
using cce::runtime_thread_aicpu::datadump::DataDumpWriter;
using cce::runtime_thread_aicpu::datadump::DumpInfoAction;
using cce::runtime_thread_aicpu::datadump::DumpMode;
using cce::runtime_thread_aicpu::datadump::DumpOutputType;
using cce::runtime_thread_aicpu::datadump::InputDumpInfo;
using cce::runtime_thread_aicpu::datadump::MemoryRegion;
using cce::runtime_thread_aicpu::datadump::ModelDumpConfig;
using cce::runtime_thread_aicpu::datadump::ModelDumpInfo;
using cce::runtime_thread_aicpu::datadump::ModelDumpInfoPtr;
using cce::runtime_thread_aicpu::datadump::OpDumpInfo;
using cce::runtime_thread_aicpu::datadump::OpDumpInfoPtr;
using cce::runtime_thread_aicpu::datadump::OutputDumpInfo;
using cce::runtime_thread_aicpu::datadump::ParsedDumpCommand;
using cce::runtime_thread_aicpu::datadump::TaskKey;
using cce::runtime_thread_aicpu::datadump::WorkspaceType;
namespace tlv = cce::runtime_thread_aicpu::datadump::tlv;

struct DataDumpCallbackReport {
    volatile uint16_t phase : 1;
    volatile uint16_t sop : 1;
    volatile uint16_t mop : 1;
    volatile uint16_t eop : 1;
    volatile uint16_t cqId : 12;
    volatile uint16_t streamId;
    volatile uint16_t taskId;
    volatile uint16_t sqId;
    volatile uint16_t sqHead;
    volatile uint16_t sequenceId;
    volatile uint8_t isBlock;
    volatile uint8_t reserved;
    volatile uint16_t eventId;
    volatile uint64_t funcPtr;
    volatile uint64_t fnData;
};

static_assert(sizeof(DataDumpCallbackReport) == 32U, "test callback report layout must match driver ABI");

template <typename T>
void AppendStruct(std::vector<uint8_t>& buffer, const T& value)
{
    const auto* const begin = reinterpret_cast<const uint8_t*>(&value);
    buffer.insert(buffer.end(), begin, begin + sizeof(T));
}

void AppendBytes(std::vector<uint8_t>& buffer, const void* const data, const size_t size)
{
    const auto* const begin = static_cast<const uint8_t*>(data);
    buffer.insert(buffer.end(), begin, begin + size);
}

void AppendTlv(std::vector<uint8_t>& buffer, const uint32_t type, const std::vector<uint8_t>& value)
{
    const tlv::TlvHeader header = {type, static_cast<uint32_t>(value.size())};
    AppendStruct(buffer, header);
    buffer.insert(buffer.end(), value.begin(), value.end());
}

void AppendStringTlv(std::vector<uint8_t>& buffer, const uint32_t type, const std::string& value)
{
    std::vector<uint8_t> bytes(value.begin(), value.end());
    AppendTlv(buffer, type, bytes);
}

void RemoveTree(const std::string& path)
{
    struct stat status = {};
    if (lstat(path.c_str(), &status) != 0) {
        return;
    }
    if (!S_ISDIR(status.st_mode)) {
        (void)unlink(path.c_str());
        return;
    }
    DIR* const directory = opendir(path.c_str());
    if (directory != nullptr) {
        struct dirent* entry = nullptr;
        while ((entry = readdir(directory)) != nullptr) {
            const std::string name(entry->d_name);
            if ((name == ".") || (name == "..")) {
                continue;
            }
            RemoveTree(path + "/" + name);
        }
        (void)closedir(directory);
    }
    (void)rmdir(path.c_str());
}

void CollectRegularFiles(const std::string& path, std::vector<std::string>& files)
{
    DIR* const directory = opendir(path.c_str());
    if (directory == nullptr) {
        return;
    }
    struct dirent* entry = nullptr;
    while ((entry = readdir(directory)) != nullptr) {
        const std::string name(entry->d_name);
        if ((name == ".") || (name == "..")) {
            continue;
        }
        const std::string child = path + "/" + name;
        struct stat status = {};
        if ((lstat(child.c_str(), &status) == 0) && S_ISDIR(status.st_mode)) {
            CollectRegularFiles(child, files);
        } else if (S_ISREG(status.st_mode)) {
            files.emplace_back(child);
        }
    }
    (void)closedir(directory);
}

std::vector<std::string> GetRegularFiles(const std::string& path)
{
    std::vector<std::string> files;
    CollectRegularFiles(path, files);
    std::sort(files.begin(), files.end());
    return files;
}

std::vector<uint8_t> ReadBinaryFile(const std::string& path)
{
    std::ifstream file(path.c_str(), std::ios::in | std::ios::binary);
    return std::vector<uint8_t>(std::istreambuf_iterator<char>(file), std::istreambuf_iterator<char>());
}

std::string ReadTextFile(const std::string& path)
{
    std::ifstream file(path.c_str());
    std::ostringstream contents;
    contents << file.rdbuf();
    return contents.str();
}

std::vector<std::string> Split(const std::string& value, const char separator)
{
    std::vector<std::string> parts;
    std::istringstream input(value);
    std::string part;
    while (std::getline(input, part, separator)) {
        parts.emplace_back(part);
    }
    return parts;
}

class TempDirectory final {
public:
    TempDirectory()
    {
        char pathTemplate[] = "/tmp/runtime_thread_aicpu_datadump_XXXXXX";
        char* const path = mkdtemp(pathTemplate);
        if (path != nullptr) {
            path_ = path;
        }
    }

    ~TempDirectory() { RemoveTree(path_); }

    const std::string& Path() const { return path_; }

private:
    std::string path_;
};

// Keep every mutable end-to-end input here so follow-up coverage can extend the TLV without searching through the test.
struct DataDumpEndToEndInput {
    DataDumpEndToEndInput(const std::string& path, const DumpOutputType outputType)
        : dumpPath(path), dumpOutputType(outputType)
    {}

    uint32_t deviceId = 3U;
    uint32_t tsId = 2U;
    uint32_t modelId = 42U;
    uint32_t streamId = 17U;
    uint32_t taskId = 31U;
    uint32_t logicStreamId = 19U;
    uint32_t blockDim = 8U;
    uint64_t stepId = 7U;
    std::string dumpPath;
    std::string modelName = "end_to_end_model";
    std::string opName = "MatMul_0";
    std::string opType = "MatMul";
    DumpMode dumpMode = DumpMode::ALL;
    DumpOutputType dumpOutputType;

    std::array<float, 3U> inputData = {{1.0F, -2.0F, 3.0F}};
    int32_t inputDataType = 0;
    int32_t inputFormat = 0;
    std::vector<int64_t> inputShape = {3};

    std::array<int32_t, 2U> outputData = {{4, -6}};
    int32_t outputDataType = 3;
    int32_t outputFormat = 2;
    std::vector<int64_t> outputShape = {2};
    int32_t outputOriginalIndex = 0;
    std::string outputOriginalName = "origin_output";
};

OpDumpInfo MakeWriterOp(const std::string& dumpPath, const DumpMode dumpMode, const DumpOutputType dumpOutputType)
{
    std::shared_ptr<ModelDumpConfig> config = std::make_shared<ModelDumpConfig>();
    config->modelId = 42U;
    config->modelName = "model_name";
    config->dumpPath = dumpPath;
    config->dumpMode = dumpMode;
    config->dumpOutputType = dumpOutputType;

    OpDumpInfo op;
    op.taskKey = {3U, 9U};
    op.config = config;
    op.opName = "MatMul_0";
    op.opType = "MatMul";
    return op;
}

template <typename Tensor, typename Value>
Tensor MakeTensor(
    Value* const data, const size_t count, const int32_t dataType, const int32_t format,
    const std::vector<int64_t>& shape)
{
    Tensor tensor;
    tensor.dataType = dataType;
    tensor.format = format;
    tensor.memory.addressType = AddressType::RAW_ADDR;
    tensor.memory.address = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(data));
    tensor.memory.size = sizeof(Value) * count;
    tensor.shape = shape;
    return tensor;
}

std::vector<uint8_t> MakeShapeValue(const std::vector<int64_t>& dimensions)
{
    std::vector<uint8_t> value;
    for (const int64_t dimension : dimensions) {
        AppendStruct(value, dimension);
    }
    return value;
}

std::vector<uint8_t> MakeEndToEndInputList(const DataDumpEndToEndInput& input)
{
    std::vector<uint8_t> nested;
    AppendTlv(nested, static_cast<uint32_t>(tlv::TensorLevel3Type::SHAPE), MakeShapeValue(input.inputShape));
    AppendTlv(nested, static_cast<uint32_t>(tlv::TensorLevel3Type::ORIGINAL_SHAPE), MakeShapeValue(input.inputShape));

    std::vector<uint8_t> value;
    AppendStruct(value, tlv::ListPrefix{1U});
    const tlv::InputDescPrefix descriptor = {
        input.inputDataType,
        input.inputFormat,
        static_cast<int32_t>(AddressType::RAW_ADDR),
        static_cast<uint64_t>(reinterpret_cast<uintptr_t>(input.inputData.data())),
        0U,
        sizeof(input.inputData),
        static_cast<uint32_t>(nested.size()),
    };
    AppendStruct(value, descriptor);
    value.insert(value.end(), nested.begin(), nested.end());
    return value;
}

std::vector<uint8_t> MakeEndToEndOutputList(const DataDumpEndToEndInput& input)
{
    std::vector<uint8_t> nested;
    AppendTlv(nested, static_cast<uint32_t>(tlv::TensorLevel3Type::SHAPE), MakeShapeValue(input.outputShape));
    AppendTlv(nested, static_cast<uint32_t>(tlv::TensorLevel3Type::ORIGINAL_SHAPE), MakeShapeValue(input.outputShape));
    AppendStringTlv(nested, static_cast<uint32_t>(tlv::TensorLevel3Type::ORIGINAL_NAME), input.outputOriginalName);

    std::vector<uint8_t> value;
    AppendStruct(value, tlv::ListPrefix{1U});
    const tlv::OutputDescPrefix descriptor = {
        input.outputDataType,
        input.outputFormat,
        static_cast<int32_t>(AddressType::RAW_ADDR),
        input.outputOriginalIndex,
        input.outputDataType,
        input.outputFormat,
        static_cast<uint64_t>(reinterpret_cast<uintptr_t>(input.outputData.data())),
        0U,
        sizeof(input.outputData),
        static_cast<uint32_t>(nested.size()),
    };
    AppendStruct(value, descriptor);
    value.insert(value.end(), nested.begin(), nested.end());
    return value;
}

std::vector<uint8_t> MakeEndToEndLoadInfo(const DataDumpEndToEndInput& input)
{
    std::vector<uint8_t> buffer;
    AppendStruct(buffer, tlv::DataHeader{tlv::DATA_VERSION, tlv::DATA_MAGIC});
    AppendStringTlv(buffer, static_cast<uint32_t>(tlv::Level1Type::MODEL_NAME), input.modelName);

    std::vector<uint8_t> opNested;
    AppendStringTlv(opNested, static_cast<uint32_t>(tlv::Level2Type::OP_NAME), input.opName);
    AppendStringTlv(opNested, static_cast<uint32_t>(tlv::Level2Type::OP_TYPE), input.opType);
    AppendTlv(opNested, static_cast<uint32_t>(tlv::Level2Type::INPUT_DESC), MakeEndToEndInputList(input));
    AppendTlv(opNested, static_cast<uint32_t>(tlv::Level2Type::OUTPUT_DESC), MakeEndToEndOutputList(input));

    std::vector<uint8_t> opList;
    AppendStruct(opList, tlv::ListPrefix{1U});
    AppendStruct(
        opList, tlv::OpDescPrefix{
                    input.taskId, input.streamId, input.logicStreamId, static_cast<int32_t>(DataDumpTaskType::AICORE),
                    input.blockDim, 0U, static_cast<uint32_t>(opNested.size())});
    opList.insert(opList.end(), opNested.begin(), opNested.end());
    AppendTlv(buffer, static_cast<uint32_t>(tlv::Level1Type::OP_DESC), opList);

    std::vector<uint8_t> modelDesc;
    AppendStruct(
        modelDesc, tlv::ModelDescPrefix{
                       static_cast<uint32_t>(DumpInfoAction::LOAD), input.modelId,
                       static_cast<uint64_t>(reinterpret_cast<uintptr_t>(&input.stepId)), 0U, 0U,
                       static_cast<uint32_t>(input.dumpMode), static_cast<uint64_t>(input.dumpOutputType), 0U});
    AppendTlv(buffer, static_cast<uint32_t>(tlv::Level1Type::MODEL_DESC), modelDesc);
    AppendStringTlv(buffer, static_cast<uint32_t>(tlv::Level1Type::DUMP_PATH), input.dumpPath);
    return buffer;
}

std::vector<uint8_t> MakeInputList(const int32_t addressType)
{
    std::vector<uint8_t> nested;
    AppendTlv(nested, static_cast<uint32_t>(tlv::TensorLevel3Type::SHAPE), MakeShapeValue({1, 3, 8, 8}));
    AppendTlv(nested, static_cast<uint32_t>(tlv::TensorLevel3Type::ORIGINAL_SHAPE), MakeShapeValue({1, 3, 8, 8}));

    std::vector<uint8_t> value;
    AppendStruct(value, tlv::ListPrefix{1U});
    const tlv::InputDescPrefix input = {
        1, 2, addressType, 0x1000U, 0x20U, 0x300U, static_cast<uint32_t>(nested.size())};
    AppendStruct(value, input);
    value.insert(value.end(), nested.begin(), nested.end());
    return value;
}

std::vector<uint8_t> MakeOutputList(const int32_t addressType)
{
    std::vector<uint8_t> nested;
    AppendTlv(nested, static_cast<uint32_t>(tlv::TensorLevel3Type::SHAPE), MakeShapeValue({1, 16}));
    AppendTlv(nested, static_cast<uint32_t>(tlv::TensorLevel3Type::ORIGINAL_SHAPE), MakeShapeValue({1, 16}));
    AppendStringTlv(nested, static_cast<uint32_t>(tlv::TensorLevel3Type::ORIGINAL_NAME), "origin_output");

    std::vector<uint8_t> value;
    AppendStruct(value, tlv::ListPrefix{1U});
    const tlv::OutputDescPrefix output = {3, 4,       addressType, 7,      8,
                                          9, 0x2000U, 0x40U,       0x400U, static_cast<uint32_t>(nested.size())};
    AppendStruct(value, output);
    value.insert(value.end(), nested.begin(), nested.end());
    return value;
}

std::vector<uint8_t> MakeWorkspaceList()
{
    std::vector<uint8_t> value;
    AppendStruct(value, tlv::ListPrefix{1U});
    AppendStruct(value, tlv::WorkspaceDescPrefix{static_cast<int32_t>(WorkspaceType::LOG), 0x3000U, 0x500U, 0U});
    return value;
}

std::vector<uint8_t> MakeBufferList()
{
    std::vector<uint8_t> value;
    AppendStruct(value, tlv::ListPrefix{1U});
    AppendStruct(value, tlv::OpBufferPrefix{static_cast<uint8_t>(BufferType::L1), 0x4000U, 0x600U, 0U});
    return value;
}

std::vector<uint8_t> MakeMemoryInfoList()
{
    std::vector<uint8_t> value;
    AppendStruct(value, tlv::ListPrefix{1U});
    AppendStruct(value, tlv::MemoryInfoPrefix{10U, 20U, 30U, 40U, 100U, 0U});
    return value;
}

std::vector<uint8_t> MakeOriginalNames()
{
    std::vector<uint8_t> value;
    const std::string first = "origin_a";
    const std::string second = "origin_b";
    const uint32_t firstLength = static_cast<uint32_t>(first.size());
    const uint32_t secondLength = static_cast<uint32_t>(second.size());
    AppendStruct(value, firstLength);
    AppendBytes(value, first.data(), first.size());
    AppendStruct(value, secondLength);
    AppendBytes(value, second.data(), second.size());
    return value;
}

std::vector<uint8_t> MakeLoadInfo(
    const int32_t addressType = static_cast<int32_t>(AddressType::RAW_ADDR),
    const int32_t taskType = static_cast<int32_t>(DataDumpTaskType::AICORE), const uint8_t isMultiOp = 0U,
    const uint32_t streamId = 17U, const uint32_t taskId = 31U)
{
    std::vector<uint8_t> buffer;
    AppendStruct(buffer, tlv::DataHeader{tlv::DATA_VERSION, tlv::DATA_MAGIC});
    AppendStringTlv(buffer, static_cast<uint32_t>(tlv::Level1Type::MODEL_NAME), "test_model");

    std::vector<uint8_t> opNested;
    AppendStringTlv(opNested, static_cast<uint32_t>(tlv::Level2Type::OP_NAME), "MatMul_0");
    AppendStringTlv(opNested, static_cast<uint32_t>(tlv::Level2Type::OP_TYPE), "MatMul");
    AppendTlv(opNested, static_cast<uint32_t>(tlv::Level2Type::ORIGINAL_OP_NAME), MakeOriginalNames());
    AppendStringTlv(opNested, static_cast<uint32_t>(tlv::Level2Type::L1_SUB_GRAPH_NO), "subgraph_0");
    AppendTlv(opNested, static_cast<uint32_t>(tlv::Level2Type::INPUT_DESC), MakeInputList(addressType));
    AppendTlv(opNested, static_cast<uint32_t>(tlv::Level2Type::OUTPUT_DESC), MakeOutputList(addressType));
    AppendTlv(opNested, static_cast<uint32_t>(tlv::Level2Type::WORKSPACE_DESC), MakeWorkspaceList());
    AppendTlv(opNested, static_cast<uint32_t>(tlv::Level2Type::OP_BUFFER), MakeBufferList());
    AppendTlv(opNested, static_cast<uint32_t>(tlv::Level2Type::MEMORY_INFO), MakeMemoryInfoList());

    std::vector<uint8_t> opList;
    AppendStruct(opList, tlv::ListPrefix{1U});
    AppendStruct(
        opList,
        tlv::OpDescPrefix{taskId, streamId, 19U, taskType, 8U, isMultiOp, static_cast<uint32_t>(opNested.size())});
    opList.insert(opList.end(), opNested.begin(), opNested.end());
    AppendTlv(buffer, static_cast<uint32_t>(tlv::Level1Type::OP_DESC), opList);

    std::vector<uint8_t> modelDesc;
    AppendStruct(
        modelDesc, tlv::ModelDescPrefix{
                       static_cast<uint32_t>(DumpInfoAction::LOAD), 5U, 0x5000U, 0x6000U, 0x7000U,
                       static_cast<uint32_t>(DumpMode::ALL), static_cast<uint64_t>(DumpOutputType::TENSOR), 0U});
    AppendTlv(buffer, static_cast<uint32_t>(tlv::Level1Type::MODEL_DESC), modelDesc);
    AppendStringTlv(buffer, static_cast<uint32_t>(tlv::Level1Type::DUMP_PATH), "/tmp/datadump");
    AppendTlv(buffer, 99U, std::vector<uint8_t>{1U, 2U, 3U});
    return buffer;
}

std::vector<uint8_t> MakeUnloadInfo(const uint32_t modelId)
{
    std::vector<uint8_t> buffer;
    AppendStruct(buffer, tlv::DataHeader{tlv::DATA_VERSION, tlv::DATA_MAGIC});
    std::vector<uint8_t> modelDesc;
    AppendStruct(
        modelDesc, tlv::ModelDescPrefix{
                       static_cast<uint32_t>(DumpInfoAction::UNLOAD), modelId, 0U, 0U, 0U,
                       static_cast<uint32_t>(DumpMode::ALL), static_cast<uint64_t>(DumpOutputType::STATS), 0U});
    AppendTlv(buffer, static_cast<uint32_t>(tlv::Level1Type::MODEL_DESC), modelDesc);
    return buffer;
}

void ExpectEndToEndDumpFile(const DataDumpEndToEndInput& input, const OpDumpInfo& op, const std::string& filePath)
{
    if (input.dumpOutputType == DumpOutputType::STATS) {
        std::ostringstream expected;
        expected << "Input/Output,Index,Data Size,Data Type,Format,Shape,Max Value,Min Value,Avg Value,Count,Nan "
                    "Count,Negative Inf Count,Positive Inf Count\n"
                 << "Input,0," << sizeof(input.inputData) << ",DT_FLOAT,NCHW,3,3,-2,0.666667,3,0,0,0\n"
                 << "Output,0," << sizeof(input.outputData) << ",DT_INT32,ND,2,4,-6,-1,2,0,0,0\n";
        EXPECT_EQ(ReadTextFile(filePath), expected.str());
        return;
    }

    const uint64_t dataHeadLength =
        op.inputDescTlv.size() + op.outputDescTlv.size() + sizeof(uint32_t) + sizeof(uint32_t);
    std::vector<uint8_t> expected;
    AppendStruct(expected, dataHeadLength);
    AppendStruct(expected, tlv::DATA_MAGIC);
    AppendStruct(expected, tlv::DATA_VERSION);
    expected.insert(expected.end(), op.inputDescTlv.begin(), op.inputDescTlv.end());
    expected.insert(expected.end(), op.outputDescTlv.begin(), op.outputDescTlv.end());
    AppendBytes(expected, input.inputData.data(), sizeof(input.inputData));
    AppendBytes(expected, input.outputData.data(), sizeof(input.outputData));
    EXPECT_EQ(ReadBinaryFile(filePath), expected);
}

void RunDataDumpEndToEnd(const DumpOutputType outputType)
{
    TempDirectory tempDirectory;
    ASSERT_FALSE(tempDirectory.Path().empty());

    DataDumpEndToEndInput input(tempDirectory.Path(), outputType);
    const std::vector<uint8_t> loadBuffer = MakeEndToEndLoadInfo(input);
    ASSERT_LE(loadBuffer.size(), std::numeric_limits<uint32_t>::max());

    RuntimeThreadAicpuRuntimeHooks hooks = {};
    RuntimeThreadAicpuService service(hooks);
    // Worker and driver lifecycle have dedicated tests; this case starts at the AICPU DataDump load boundary.
    service.started_ = true;
    service.deviceId_ = input.deviceId;
    service.tsId_ = input.tsId;

    RuntimeThreadAicpuDumpInfoRequest request = {};
    request.structSize = sizeof(request);
    request.deviceId = input.deviceId;
    request.tsId = input.tsId;
    request.dumpInfo = loadBuffer.data();
    request.length = static_cast<uint32_t>(loadBuffer.size());
    ASSERT_EQ(service.LoadDumpInfo(request), RuntimeThreadAicpuStatus::OK);

    const TaskKey key(static_cast<uint16_t>(input.streamId), static_cast<uint16_t>(input.taskId));
    const ConstOpDumpInfoPtr op = service.dataDumpManager_.SearchOp(key);
    ASSERT_NE(op, nullptr);
    ASSERT_NE(op->config, nullptr);
    EXPECT_EQ(op->config->modelId, input.modelId);
    EXPECT_EQ(op->config->dumpPath, input.dumpPath);
    EXPECT_EQ(op->config->dumpOutputType, outputType);
    EXPECT_EQ(op->opName, input.opName);
    EXPECT_EQ(op->opType, input.opType);
    ASSERT_EQ(op->inputList.size(), 1U);
    ASSERT_EQ(op->outputList.size(), 1U);
    EXPECT_EQ(
        op->inputList[0].memory.address, static_cast<uint64_t>(reinterpret_cast<uintptr_t>(input.inputData.data())));
    EXPECT_EQ(
        op->outputList[0].memory.address, static_cast<uint64_t>(reinterpret_cast<uintptr_t>(input.outputData.data())));

    std::vector<uint8_t> expectedInputDesc;
    AppendTlv(expectedInputDesc, static_cast<uint32_t>(tlv::Level2Type::INPUT_DESC), MakeEndToEndInputList(input));
    std::vector<uint8_t> expectedOutputDesc;
    AppendTlv(expectedOutputDesc, static_cast<uint32_t>(tlv::Level2Type::OUTPUT_DESC), MakeEndToEndOutputList(input));
    EXPECT_EQ(op->inputDescTlv, expectedInputDesc);
    EXPECT_EQ(op->outputDescTlv, expectedOutputDesc);

    DataDumpCallbackReport report = {};
    report.streamId = static_cast<uint16_t>(input.streamId);
    report.taskId = static_cast<uint16_t>(input.taskId);
    ASSERT_EQ(service.ProcessDumpReport(&report), static_cast<uint32_t>(RuntimeThreadAicpuStatus::OK));

    const std::vector<std::string> files = GetRegularFiles(tempDirectory.Path());
    ASSERT_EQ(files.size(), 1U);
    const std::string expectedDirectory = tempDirectory.Path() + "/" + std::to_string(input.modelId) + "/" +
                                          input.modelName + "/" + std::to_string(input.stepId) + "/";
    const std::string expectedFilePrefix = expectedDirectory + input.opType + "." + input.opName + "." +
                                           std::to_string(input.taskId) + "." + std::to_string(input.streamId) + ".";
    EXPECT_EQ(files[0].compare(0U, expectedFilePrefix.size(), expectedFilePrefix), 0);
    if (outputType == DumpOutputType::STATS) {
        ASSERT_GE(files[0].size(), std::strlen(".csv"));
        EXPECT_EQ(files[0].substr(files[0].size() - std::strlen(".csv")), ".csv");
    }
    ExpectEndToEndDumpFile(input, *op, files[0]);

    const std::vector<uint8_t> unloadBuffer = MakeUnloadInfo(input.modelId);
    request.dumpInfo = unloadBuffer.data();
    request.length = static_cast<uint32_t>(unloadBuffer.size());
    ASSERT_EQ(service.LoadDumpInfo(request), RuntimeThreadAicpuStatus::OK);
    EXPECT_EQ(service.dataDumpManager_.SearchOp(key), nullptr);
}

TEST(DataDumpEndToEndTest, LoadsSearchesAndWritesStatsFileFromTlv) { RunDataDumpEndToEnd(DumpOutputType::STATS); }

TEST(DataDumpEndToEndTest, LoadsSearchesAndWritesTensorFileFromTlv) { RunDataDumpEndToEnd(DumpOutputType::TENSOR); }

TEST(DataDumpParserTest, ParsesCompleteGeTlvAndOwnsAllData)
{
    std::vector<uint8_t> buffer = MakeLoadInfo();
    std::vector<uint8_t> expectedInputDesc;
    AppendTlv(
        expectedInputDesc, static_cast<uint32_t>(tlv::Level2Type::INPUT_DESC),
        MakeInputList(static_cast<int32_t>(AddressType::RAW_ADDR)));
    std::vector<uint8_t> expectedOutputDesc;
    AppendTlv(
        expectedOutputDesc, static_cast<uint32_t>(tlv::Level2Type::OUTPUT_DESC),
        MakeOutputList(static_cast<int32_t>(AddressType::RAW_ADDR)));
    DataDumpParser parser;
    ParsedDumpCommand command;
    std::string detail;

    ASSERT_EQ(parser.Parse(buffer.data(), buffer.size(), command, detail), RuntimeThreadAicpuStatus::OK) << detail;
    ASSERT_EQ(command.action, DumpInfoAction::LOAD);
    ASSERT_NE(command.model, nullptr);
    ASSERT_NE(command.model->config, nullptr);
    EXPECT_EQ(command.model->config->modelId, 5U);
    EXPECT_EQ(command.model->config->modelName, "test_model");
    EXPECT_EQ(command.model->config->dumpPath, "/tmp/datadump");
    EXPECT_EQ(command.model->config->stepIdAddress, 0x5000U);
    EXPECT_EQ(command.model->config->iterationsPerLoopAddress, 0x6000U);
    EXPECT_EQ(command.model->config->loopCondAddress, 0x7000U);
    EXPECT_EQ(command.model->config->dumpMode, DumpMode::ALL);
    EXPECT_EQ(command.model->config->dumpOutputType, DumpOutputType::TENSOR);

    const TaskKey key = {17U, 31U};
    ASSERT_EQ(command.model->ops.size(), 1U);
    const OpDumpInfoPtr op = command.model->ops.at(key);
    EXPECT_EQ(op->config, command.model->config);
    EXPECT_EQ(op->logicStreamId, 19U);
    EXPECT_EQ(op->taskType, DataDumpTaskType::AICORE);
    EXPECT_EQ(op->blockDim, 8U);
    EXPECT_EQ(op->opName, "MatMul_0");
    EXPECT_EQ(op->opType, "MatMul");
    ASSERT_EQ(op->originalOpNames.size(), 2U);
    EXPECT_EQ(op->originalOpNames[1], "origin_b");
    EXPECT_EQ(op->l1SubGraphNo, "subgraph_0");
    ASSERT_EQ(op->inputList.size(), 1U);
    EXPECT_EQ(op->inputList[0].memory.address, 0x1000U);
    EXPECT_EQ(op->inputList[0].memory.offset, 0x20U);
    EXPECT_EQ(op->inputList[0].shape, (std::vector<int64_t>{1, 3, 8, 8}));
    ASSERT_EQ(op->outputList.size(), 1U);
    EXPECT_EQ(op->outputList[0].originalName, "origin_output");
    EXPECT_EQ(op->outputList[0].originalIndex, 7);
    EXPECT_EQ(op->outputList[0].originalDataType, 8);
    EXPECT_EQ(op->outputList[0].originalFormat, 9);
    EXPECT_EQ(op->inputDescTlv, expectedInputDesc);
    EXPECT_EQ(op->outputDescTlv, expectedOutputDesc);
    ASSERT_EQ(op->workspaces.size(), 1U);
    EXPECT_EQ(op->workspaces[0].dataAddress, 0x3000U);
    ASSERT_EQ(op->buffers.size(), 1U);
    EXPECT_EQ(op->buffers[0].address, 0x4000U);
    ASSERT_EQ(op->memoryUsage.size(), 1U);
    EXPECT_EQ(op->memoryUsage[0].totalSize, 100U);

    std::fill(buffer.begin(), buffer.end(), 0U);
    EXPECT_EQ(op->opName, "MatMul_0");
    EXPECT_EQ(command.model->config->dumpPath, "/tmp/datadump");
    EXPECT_EQ(op->inputDescTlv, expectedInputDesc);
    EXPECT_EQ(op->outputDescTlv, expectedOutputDesc);
}

TEST(DataDumpParserTest, ParsesMinimalUnloadCommand)
{
    const std::vector<uint8_t> buffer = MakeUnloadInfo(23U);
    DataDumpParser parser;
    ParsedDumpCommand command;
    std::string detail;
    ASSERT_EQ(parser.Parse(buffer.data(), buffer.size(), command, detail), RuntimeThreadAicpuStatus::OK) << detail;
    EXPECT_EQ(command.action, DumpInfoAction::UNLOAD);
    EXPECT_EQ(command.modelId, 23U);
    EXPECT_EQ(command.model, nullptr);
}

TEST(DataDumpParserTest, RejectsMalformedFramingAndTaskKeyOverflow)
{
    DataDumpParser parser;
    ParsedDumpCommand command;
    std::string detail;
    std::vector<uint8_t> buffer = MakeLoadInfo();
    buffer.pop_back();
    EXPECT_EQ(
        parser.Parse(buffer.data(), buffer.size(), command, detail), RuntimeThreadAicpuStatus::DATADUMP_PARSE_FAILED);
    EXPECT_FALSE(detail.empty());

    buffer = MakeLoadInfo();
    buffer[0] = 1U;
    EXPECT_EQ(
        parser.Parse(buffer.data(), buffer.size(), command, detail), RuntimeThreadAicpuStatus::DATADUMP_PARSE_FAILED);

    buffer = MakeLoadInfo(
        static_cast<int32_t>(AddressType::RAW_ADDR), static_cast<int32_t>(DataDumpTaskType::AICORE), 0U, 0x10000U, 31U);
    EXPECT_EQ(
        parser.Parse(buffer.data(), buffer.size(), command, detail), RuntimeThreadAicpuStatus::DATADUMP_PARSE_FAILED);
}

TEST(DataDumpParserTest, RejectsDuplicateKnownLevelOneTlv)
{
    DataDumpParser parser;
    ParsedDumpCommand command;
    std::string detail;
    std::vector<uint8_t> buffer = MakeLoadInfo();
    AppendStringTlv(buffer, static_cast<uint32_t>(tlv::Level1Type::MODEL_NAME), "duplicate");
    EXPECT_EQ(
        parser.Parse(buffer.data(), buffer.size(), command, detail), RuntimeThreadAicpuStatus::DATADUMP_PARSE_FAILED);
}

TEST(DataDumpParserTest, ReportsUnsupportedPhaseOneOperatorForms)
{
    DataDumpParser parser;
    ParsedDumpCommand command;
    std::string detail;
    std::vector<uint8_t> buffer = MakeLoadInfo(static_cast<int32_t>(AddressType::NANO_IO_ADDR));
    EXPECT_EQ(parser.Parse(buffer.data(), buffer.size(), command, detail), RuntimeThreadAicpuStatus::NOT_SUPPORTED);

    buffer = MakeLoadInfo(static_cast<int32_t>(AddressType::RAW_ADDR), static_cast<int32_t>(DataDumpTaskType::AICPU));
    EXPECT_EQ(parser.Parse(buffer.data(), buffer.size(), command, detail), RuntimeThreadAicpuStatus::NOT_SUPPORTED);

    buffer =
        MakeLoadInfo(static_cast<int32_t>(AddressType::RAW_ADDR), static_cast<int32_t>(DataDumpTaskType::AICORE), 1U);
    EXPECT_EQ(parser.Parse(buffer.data(), buffer.size(), command, detail), RuntimeThreadAicpuStatus::NOT_SUPPORTED);
}

ModelDumpInfoPtr MakeModel(const uint32_t modelId, const TaskKey key, const std::string& opName)
{
    std::shared_ptr<ModelDumpConfig> config = std::make_shared<ModelDumpConfig>();
    config->modelId = modelId;
    ModelDumpInfoPtr model = std::make_shared<ModelDumpInfo>();
    model->config = config;
    OpDumpInfoPtr op = std::make_shared<OpDumpInfo>();
    op->taskKey = key;
    op->opName = opName;
    op->config = config;
    model->ops[key] = op;
    return model;
}

TEST(DataDumpManagerTest, LaterTaskBindingWinsAndOldUnloadPreservesIt)
{
    DataDumpManager manager;
    const TaskKey key = {2U, 3U};
    const ModelDumpInfoPtr first = MakeModel(1U, key, "first");
    const ModelDumpInfoPtr second = MakeModel(2U, key, "second");
    ASSERT_EQ(manager.Load(first), RuntimeThreadAicpuStatus::OK);
    ASSERT_EQ(manager.Load(second), RuntimeThreadAicpuStatus::OK);
    ASSERT_NE(manager.SearchOp(key), nullptr);
    EXPECT_EQ(manager.SearchOp(key)->opName, "second");

    EXPECT_EQ(manager.Unload(1U), RuntimeThreadAicpuStatus::OK);
    ASSERT_NE(manager.SearchOp(key), nullptr);
    EXPECT_EQ(manager.SearchOp(key)->opName, "second");
    EXPECT_EQ(manager.Unload(2U), RuntimeThreadAicpuStatus::OK);
    EXPECT_EQ(manager.SearchOp(key), nullptr);
    EXPECT_EQ(manager.Unload(99U), RuntimeThreadAicpuStatus::OK);
}

TEST(DataDumpManagerTest, ReloadRemovesOnlyThePreviousModelTasks)
{
    DataDumpManager manager;
    const TaskKey oldKey = {1U, 1U};
    const TaskKey newKey = {1U, 2U};
    ASSERT_EQ(manager.Load(MakeModel(7U, oldKey, "old")), RuntimeThreadAicpuStatus::OK);
    ASSERT_EQ(manager.Load(MakeModel(7U, newKey, "new")), RuntimeThreadAicpuStatus::OK);
    EXPECT_EQ(manager.SearchOp(oldKey), nullptr);
    ASSERT_NE(manager.SearchOp(newKey), nullptr);
    EXPECT_EQ(manager.SearchOp(newKey)->opName, "new");
}

TEST(DataDumpWriterTest, RejectsIncompleteMetadata)
{
    DataDumpWriter writer;
    OpDumpInfo op;
    op.taskKey = {1U, 2U};
    op.opName = "MatMul";
    EXPECT_EQ(writer.DumpOp(op), RuntimeThreadAicpuStatus::INVALID_PARAM);
}

TEST(DataDumpWriterTest, WritesFloatHalfAndInt8Statistics)
{
    TempDirectory tempDirectory;
    ASSERT_FALSE(tempDirectory.Path().empty());
    float floatData[] = {
        1.0F, -2.0F, std::numeric_limits<float>::infinity(), -std::numeric_limits<float>::infinity(),
        std::numeric_limits<float>::quiet_NaN()};
    uint16_t halfData[] = {0x3C00U, 0xC000U, 0x7C00U, 0xFC00U, 0x7E00U};
    int8_t int8Data[] = {-3, 5};
    OpDumpInfo op = MakeWriterOp(tempDirectory.Path(), DumpMode::ALL, DumpOutputType::STATS);
    op.inputList.emplace_back(MakeTensor<InputDumpInfo>(floatData, 5U, 0, 0, {5}));
    op.inputList.emplace_back(MakeTensor<InputDumpInfo>(halfData, 5U, 1, 1, {}));
    op.outputList.emplace_back(MakeTensor<OutputDumpInfo>(int8Data, 2U, 2, 2, {2}));

    DataDumpWriter writer;
    ASSERT_EQ(writer.DumpOp(op), RuntimeThreadAicpuStatus::OK);
    const std::vector<std::string> files = GetRegularFiles(tempDirectory.Path());
    ASSERT_EQ(files.size(), 1U);
    const std::string contents = ReadTextFile(files[0]);
    const std::string expected =
        "Input/Output,Index,Data Size,Data Type,Format,Shape,Max Value,Min Value,Avg Value,Count,Nan Count,"
        "Negative Inf Count,Positive Inf Count\n"
        "Input,0,20,DT_FLOAT,NCHW,5,inf,-inf,nan,5,1,1,1\n"
        "Input,1,10,DT_FLOAT16,NHWC,,inf,-inf,nan,5,1,1,1\n"
        "Output,0,2,DT_INT8,ND,2,5,-3,1,2,0,0,0\n";
    EXPECT_EQ(contents, expected);
}

TEST(DataDumpWriterTest, UsesGeDataTypeAndFormatMappingsAndBuildsStepPath)
{
    const char* const expectedDataTypes[] = {
        "DT_FLOAT",         "DT_FLOAT16",        "DT_INT8",      "DT_INT32",      "DT_UINT8",  "-",         "DT_INT16",
        "DT_UINT16",        "DT_UINT32",         "DT_INT64",     "DT_UINT64",     "DT_DOUBLE", "DT_BOOL",   "DT_STRING",
        "DT_DUAL_SUB_INT8", "DT_DUAL_SUB_UINT8", "DT_COMPLEX64", "DT_COMPLEX128", "DT_QINT8",  "DT_QINT16", "DT_QINT32",
        "DT_QUINT8",        "DT_QUINT16",        "DT_RESOURCE",  "DT_STRING_REF",
    };
    const char* const expectedFormats[] = {
        "NCHW",
        "NHWC",
        "ND",
        "NC1HWC0",
        "FRACTAL_Z",
        "NC1C0HWPAD",
        "NHWC1C0",
        "FSR_NCHW",
        "FRACTAL_DECONV",
        "C1HWNC0",
        "FRACTAL_DECONV_TRANSPOSE",
        "FRACTAL_DECONV_SP_STRIDE_TRANS",
        "NC1HWC0_C04",
        "FRACTAL_Z_C04",
        "CHWN",
        "FRACTAL_DECONV_SP_STRIDE8_TRANS",
        "HWCN",
        "NC1KHKWHWC0",
        "BN_WEIGHT",
        "FILTER_HWCK",
        "HASHTABLE_LOOKUP_LOOKUPS",
        "HASHTABLE_LOOKUP_KEYS",
        "HASHTABLE_LOOKUP_VALUE",
        "HASHTABLE_LOOKUP_OUTPUT",
        "HASHTABLE_LOOKUP_HITS",
        "C1HWNCoC0",
        "MD",
        "NDHWC",
        "FRACTAL_ZZ",
        "FRACTAL_NZ",
        "NCDHW",
        "DHWCN",
        "NDC1HWC0",
        "FRACTAL_Z_3D",
        "CN",
        "NC",
        "DHWNC",
        "FRACTAL_Z_3D_TRANSPOSE",
        "FRACTAL_ZN_LSTM",
        "FRACTAL_Z_G",
        "RESERVED",
    };
    TempDirectory tempDirectory;
    ASSERT_FALSE(tempDirectory.Path().empty());
    uint64_t stepId = 7U;
    uint8_t zeroData[8] = {};
    OpDumpInfo op = MakeWriterOp(tempDirectory.Path(), DumpMode::INPUT, DumpOutputType::STATS);
    std::shared_ptr<ModelDumpConfig> config = std::const_pointer_cast<ModelDumpConfig>(op.config);
    config->stepIdAddress = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(&stepId));
    op.opType = "Type A.B/C\\D";
    op.opName = "scope/" + std::string(250U, 'x');
    for (size_t index = 0U; index < 41U; ++index) {
        const int32_t dataType = (index < 25U) ? static_cast<int32_t>(index) : 25;
        op.inputList.emplace_back(
            MakeTensor<InputDumpInfo>(zeroData, sizeof(zeroData), dataType, static_cast<int32_t>(index), {}));
    }

    DataDumpWriter writer;
    ASSERT_EQ(writer.DumpOp(op), RuntimeThreadAicpuStatus::OK);
    const std::string expectedDirectory = tempDirectory.Path() + "/42/model_name/7";
    const std::vector<std::string> files = GetRegularFiles(tempDirectory.Path());
    ASSERT_EQ(files.size(), 1U);
    EXPECT_EQ(files[0].compare(0U, expectedDirectory.size(), expectedDirectory), 0);
    const size_t separator = files[0].find_last_of('/');
    ASSERT_NE(separator, std::string::npos);
    const std::string fileName = files[0].substr(separator + 1U);
    ASSERT_GE(fileName.size(), std::strlen(".csv"));
    EXPECT_EQ(fileName.substr(fileName.size() - std::strlen(".csv")), ".csv");
    EXPECT_LT(fileName.size() - std::strlen(".csv"), 220U);
    EXPECT_EQ(fileName.compare(0U, std::strlen("Type_A_B_C_D."), "Type_A_B_C_D."), 0);
    EXPECT_EQ(fileName.find(' '), std::string::npos);
    EXPECT_EQ(fileName.find('\\'), std::string::npos);

    const std::vector<std::string> lines = Split(ReadTextFile(files[0]), '\n');
    ASSERT_EQ(lines.size(), 42U);
    for (size_t index = 0U; index < 41U; ++index) {
        const std::vector<std::string> columns = Split(lines[index + 1U], ',');
        ASSERT_GE(columns.size(), 5U);
        const std::string expectedDataType = (index < 25U) ? expectedDataTypes[index] : "-";
        EXPECT_EQ(columns[3], expectedDataType) << "index=" << index;
        EXPECT_EQ(columns[4], expectedFormats[index]) << "index=" << index;
    }
}

void ExpectTensorDumpMatchesGolden(const DumpMode dumpMode)
{
    TempDirectory tempDirectory;
    ASSERT_FALSE(tempDirectory.Path().empty());
    uint8_t inputData[] = {1U, 2U};
    uint8_t outputData[] = {3U, 4U, 5U};
    OpDumpInfo op = MakeWriterOp(tempDirectory.Path(), dumpMode, DumpOutputType::TENSOR);
    op.inputList.emplace_back(MakeTensor<InputDumpInfo>(inputData, 2U, 4, 0, {2}));
    op.outputList.emplace_back(MakeTensor<OutputDumpInfo>(outputData, 3U, 4, 2, {3}));
    AppendTlv(op.inputDescTlv, static_cast<uint32_t>(tlv::Level2Type::INPUT_DESC), std::vector<uint8_t>{0x11U, 0x12U});
    AppendTlv(
        op.outputDescTlv, static_cast<uint32_t>(tlv::Level2Type::OUTPUT_DESC),
        std::vector<uint8_t>{0x21U, 0x22U, 0x23U});

    DataDumpWriter writer;
    ASSERT_EQ(writer.DumpOp(op), RuntimeThreadAicpuStatus::OK);
    const std::vector<std::string> files = GetRegularFiles(tempDirectory.Path());
    ASSERT_EQ(files.size(), 1U);

    const bool includeInput = dumpMode != DumpMode::OUTPUT;
    const bool includeOutput = dumpMode != DumpMode::INPUT;
    const uint64_t dataHeadLength = (includeInput ? op.inputDescTlv.size() : 0U) +
                                    (includeOutput ? op.outputDescTlv.size() : 0U) + sizeof(uint32_t) +
                                    sizeof(uint32_t);
    std::vector<uint8_t> expected;
    AppendStruct(expected, dataHeadLength);
    AppendStruct(expected, tlv::DATA_MAGIC);
    AppendStruct(expected, tlv::DATA_VERSION);
    if (includeInput) {
        expected.insert(expected.end(), op.inputDescTlv.begin(), op.inputDescTlv.end());
    }
    if (includeOutput) {
        expected.insert(expected.end(), op.outputDescTlv.begin(), op.outputDescTlv.end());
    }
    if (includeInput) {
        AppendBytes(expected, inputData, sizeof(inputData));
    }
    if (includeOutput) {
        AppendBytes(expected, outputData, sizeof(outputData));
    }
    EXPECT_EQ(ReadBinaryFile(files[0]), expected);
}

TEST(DataDumpWriterTest, WritesTensorGoldenLayoutForAllDumpModes)
{
    ExpectTensorDumpMatchesGolden(DumpMode::INPUT);
    ExpectTensorDumpMatchesGolden(DumpMode::OUTPUT);
    ExpectTensorDumpMatchesGolden(DumpMode::ALL);
}

TEST(DataDumpWriterTest, ReportsAddressTensorDirectoryAndOpenFailures)
{
    TempDirectory tempDirectory;
    ASSERT_FALSE(tempDirectory.Path().empty());
    uint8_t data = 1U;
    DataDumpWriter writer;

    OpDumpInfo invalidAddress = MakeWriterOp(tempDirectory.Path(), DumpMode::INPUT, DumpOutputType::STATS);
    InputDumpInfo addressTensor = MakeTensor<InputDumpInfo>(&data, 1U, 4, 0, {1});
    addressTensor.memory.address = 0U;
    invalidAddress.inputList.emplace_back(addressTensor);
    EXPECT_EQ(writer.DumpOp(invalidAddress), RuntimeThreadAicpuStatus::DATADUMP_ADDRESS_INVALID);

    OpDumpInfo invalidTensor = MakeWriterOp(tempDirectory.Path(), DumpMode::INPUT, DumpOutputType::STATS);
    InputDumpInfo emptyTensor = MakeTensor<InputDumpInfo>(&data, 1U, 4, 0, {1});
    emptyTensor.memory.size = 0U;
    invalidTensor.inputList.emplace_back(emptyTensor);
    EXPECT_EQ(writer.DumpOp(invalidTensor), RuntimeThreadAicpuStatus::DATADUMP_TENSOR_INVALID);

    OpDumpInfo directoryFailure =
        MakeWriterOp("/proc/runtime_thread_aicpu_datadump_invalid", DumpMode::INPUT, DumpOutputType::STATS);
    directoryFailure.inputList.emplace_back(MakeTensor<InputDumpInfo>(&data, 1U, 4, 0, {1}));
    EXPECT_EQ(writer.DumpOp(directoryFailure), RuntimeThreadAicpuStatus::DATADUMP_CREATE_DIR_FAILED);

    OpDumpInfo openFailure = MakeWriterOp("/proc", DumpMode::INPUT, DumpOutputType::STATS);
    openFailure.inputList.emplace_back(MakeTensor<InputDumpInfo>(&data, 1U, 4, 0, {1}));
    EXPECT_EQ(writer.DumpOp(openFailure), RuntimeThreadAicpuStatus::DATADUMP_OPEN_FILE_FAILED);

    OpDumpInfo missingDescriptor = MakeWriterOp(tempDirectory.Path(), DumpMode::INPUT, DumpOutputType::TENSOR);
    missingDescriptor.inputList.emplace_back(MakeTensor<InputDumpInfo>(&data, 1U, 4, 0, {1}));
    EXPECT_EQ(writer.DumpOp(missingDescriptor), RuntimeThreadAicpuStatus::DATADUMP_TENSOR_INVALID);
}

} // namespace
