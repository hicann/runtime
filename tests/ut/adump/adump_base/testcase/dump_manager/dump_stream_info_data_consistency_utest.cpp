/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

/**
 * @file dump_stream_info_data_consistency_utest.cpp
 * @brief 测试用例：验证 DumpDataRecordInCaptureStream 流程中保存的文件数据与输入一致
 *
 * 测试目标：
 * 1. 验证 protobuf header 正确序列化（op_name, input/output metadata）
 * 2. 验证 tensor raw data 正确写入文件
 * 3. 验证 shape, datatype, format 等 metadata 一致
 * 4. 验证多 chunk 场景下的数据完整性
 */

#include <gtest/gtest.h>
#include <vector>
#include <cstring>
#include <memory>
#include <fstream>
#include <sstream>
#include "mockcpp/mockcpp.hpp"

#define protected public
#define private public

#include "dump_stream_info.h"
#include "dump_tensor.h"
#include "dump_memory.h"
#include "adx_dump_record.h"
#include "proto/dump_task.pb.h"
#include "adump_pub.h"

using namespace Adx;

// 测试数据常量
constexpr int32_t TEST_INT32_VALUE = 12345;
constexpr float TEST_FLOAT_VALUE = 3.14159f;
constexpr size_t TEST_TENSOR_SIZE_INT32 = 256; // 256 bytes = 64 int32 values
constexpr size_t TEST_TENSOR_SIZE_FLOAT = 512; // 512 bytes = 128 float values

// 全局变量用于捕获 dump 队列数据
static std::vector<std::vector<uint8_t>> g_capturedChunks;
static std::string g_capturedFileName;

/**
 * @brief 测试辅助类：用于构建测试 tensor 和验证数据
 */
class TestDataHelper {
public:
    /**
     * @brief 创建测试用的 TensorInfoV2 结构
     * @param dataType 数据类型 (DT_INT32, DT_FLOAT 等)
     * @param tensorSize tensor 数据大小（字节）
     * @param shape tensor 形状
     * @param testData 测试数据指针
     * @return TensorInfoV2 结构
     */
    static TensorInfoV2 CreateTestTensor(
        int32_t dataType, size_t tensorSize, const std::vector<int64_t>& shape, int64_t* testData)
    {
        TensorInfoV2 tensor;
        tensor.type = TensorType::INPUT;
        tensor.tensorSize = tensorSize;
        tensor.format = static_cast<int32_t>(toolkit::dump::FORMAT_ND);
        tensor.dataType = dataType;
        tensor.tensorAddr = testData;
        tensor.addrType = AddressType::TRADITIONAL;
        tensor.placement = TensorPlacement::kOnHost; // 使用 Host 内存便于测试
        tensor.argsOffSet = 0;
        tensor.shape = shape;
        tensor.originShape = shape;
        return tensor;
    }

    /**
     * @brief 创建测试用的 int32 数据
     * @param count 数据个数
     * @param baseValue 基础值（用于生成递增序列）
     * @return 包含测试数据的 vector
     */
    static std::vector<int32_t> CreateInt32TestData(size_t count, int32_t baseValue)
    {
        std::vector<int32_t> data(count);
        for (size_t i = 0; i < count; ++i) {
            data[i] = baseValue + static_cast<int32_t>(i);
        }
        return data;
    }

    /**
     * @brief 创建测试用的 float 数据
     * @param count 数据个数
     * @param baseValue 基础值
     * @return 包含测试数据的 vector
     */
    static std::vector<float> CreateFloatTestData(size_t count, float baseValue)
    {
        std::vector<float> data(count);
        for (size_t i = 0; i < count; ++i) {
            data[i] = baseValue + static_cast<float>(i) * 0.1f;
        }
        return data;
    }

    /**
     * @brief 解析 dump 文件格式
     * @param chunkData 单个 chunk 的数据（包含 protobuf header 和 raw data）
     * @param[out] dumpData 解析后的 DumpData protobuf message
     * @param[out] rawTensorData 解析后的原始 tensor 数据
     * @return 是否解析成功
     */
    static bool ParseDumpFileFormat(
        const std::vector<uint8_t>& chunkData, toolkit::dump::DumpData& dumpData, std::vector<uint8_t>& rawTensorData)
    {
        if (chunkData.size() < sizeof(uint64_t)) {
            return false;
        }

        // 读取 protobuf header 大小（前 8 字节）
        uint64_t protoSize = 0;
        (void)memcpy_s(&protoSize, sizeof(uint64_t), chunkData.data(), sizeof(uint64_t));

        if (protoSize == 0 || protoSize > chunkData.size() - sizeof(uint64_t)) {
            return false;
        }

        // 解析 protobuf header
        std::string protoStr(reinterpret_cast<const char*>(chunkData.data() + sizeof(uint64_t)), protoSize);
        if (!dumpData.ParseFromString(protoStr)) {
            return false;
        }

        // 提取原始 tensor 数据
        size_t rawDataOffset = sizeof(uint64_t) + protoSize;
        if (rawDataOffset < chunkData.size()) {
            rawTensorData.assign(chunkData.begin() + rawDataOffset, chunkData.end());
        }

        return true;
    }

    /**
     * @brief 比较两个数据缓冲区是否一致
     * @param data1 数据缓冲区 1
     * @param data2 数据缓冲区 2
     * @param size 数据大小
     * @return 是否一致
     */
    static bool CompareDataBuffers(const void* data1, const void* data2, size_t size)
    {
        return std::memcmp(data1, data2, size) == 0;
    }
};

/**
 * @brief 测试 fixture 类
 */
class DumpStreamInfoDataConsistencyUtest : public testing::Test {
protected:
    virtual void SetUp()
    {
        DumpResourceSafeMap::Instance().clear();
        g_capturedChunks.clear();
        g_capturedFileName.clear();
    }

    virtual void TearDown()
    {
        DumpResourceSafeMap::Instance().clear();
        GlobalMockObject::verify();
        g_capturedChunks.clear();
        g_capturedFileName.clear();
    }

    /**
     * @brief 创建测试用的 DumpStreamInfo 结构
     * @param inputTensors 输入 tensor 列表
     * @param outputTensors 输出 tensor 列表
     * @param opType 算子类型
     * @param opName 算子名称
     * @return DumpStreamInfo 指针
     */
    DumpStreamInfo* CreateTestDumpStreamInfo(
        const std::vector<DumpTensor>& inputTensors, const std::vector<DumpTensor>& outputTensors,
        const std::string& opType, const std::string& opName)
    {
        DumpStreamInfo* dumpInfo = new DumpStreamInfo();
        dumpInfo->stm = reinterpret_cast<rtStream_t>(0x1); // 模拟 stream handle
        dumpInfo->mainStmEvt = reinterpret_cast<rtEvent_t>(0x2);
        dumpInfo->dumpStmEvt = reinterpret_cast<rtEvent_t>(0x3);
        dumpInfo->inputTensors = inputTensors;
        dumpInfo->outputTensors = outputTensors;
        dumpInfo->mainStreamKey = "test_stream_key";
        dumpInfo->opType = opType;
        dumpInfo->opName = opName;
        dumpInfo->dumpStmId = 1;
        dumpInfo->dumpEvtId = 2;
        dumpInfo->mainEvtId = 3;
        dumpInfo->taskId = 100;
        dumpInfo->streamId = 10;
        dumpInfo->deviceId = 0;
        dumpInfo->contextId = 0;
        dumpInfo->threadId = 0;
        dumpInfo->timestamp = 1704067200000; // 固定时间戳便于测试
        dumpInfo->dumpNumber = GetNextDumpNumber();
        dumpInfo->dumpPath = "/tmp/dump_test";
        return dumpInfo;
    }
};

/**
 * @brief 测试：单输入 tensor 数据一致性验证
 *
 * 测试场景：
 * - 输入：单个 int32 类型 tensor
 * - 验证：protobuf header 正确，raw data 与输入一致
 */
TEST_F(DumpStreamInfoDataConsistencyUtest, Test_SingleInputTensor_DataConsistency)
{
    // 1. 构造测试输入数据
    auto testInt32Data = TestDataHelper::CreateInt32TestData(64, TEST_INT32_VALUE);
    std::vector<int64_t> shape = {8, 8}; // 8x8 = 64 elements

    TensorInfoV2 tensorInfo = TestDataHelper::CreateTestTensor(
        static_cast<int32_t>(toolkit::dump::DT_INT32), TEST_TENSOR_SIZE_INT32, shape,
        reinterpret_cast<int64_t*>(testInt32Data.data()));

    DumpTensor dumpTensor(tensorInfo);
    std::vector<DumpTensor> inputTensors = {dumpTensor};
    std::vector<DumpTensor> outputTensors; // 无输出

    // 2. 创建 DumpStreamInfo
    DumpStreamInfo* dumpInfo = CreateTestDumpStreamInfo(inputTensors, outputTensors, "Add", "add_op_0");
    std::shared_ptr<DumpStreamInfo> dumpInfoPtr(dumpInfo, DumpStreamFree);

    // 3. Mock DumpMemory::CopyDeviceToHost - 返回输入数据地址（因为是 Host 内存）
    MOCKER_CPP(&DumpMemory::CopyDeviceToHost).stubs().will(invoke([](const void* devMem, uint64_t memSize) -> void* {
        // 对于 Host 内存测试，直接返回原地址
        void* hostMem = malloc(memSize);
        if (hostMem != nullptr) {
            (void)memcpy_s(hostMem, memSize, devMem, memSize);
        }
        return hostMem;
    }));

    // 4. Mock DumpTensorPushToDumpQueue - 捕获输出数据而非写入队列
    MOCKER(DumpTensorPushToDumpQueue)
        .stubs()
        .will(invoke(
            [](void* dataBuf, uint32_t bufLen, const char* fileName, uint64_t offset, uint32_t isLastChunk) -> int32_t {
                // 捕获数据
                std::vector<uint8_t> chunk(bufLen);
                (void)memcpy_s(chunk.data(), bufLen, dataBuf, bufLen);
                g_capturedChunks.push_back(chunk);
                g_capturedFileName = fileName;
                return ADUMP_SUCCESS;
            }));

    // 5. Mock AdxDumpRecord::RecordDumpDataToQueue - 不实际写入队列
    MOCKER_CPP(&AdxDumpRecord::RecordDumpDataToQueue).stubs().will(returnValue(true));

    // 6. 执行 DumpTensorToQueue
    DumpTensorToQueue(dumpInfo);

    // 7. 验证捕获的数据
    ASSERT_EQ(g_capturedChunks.size(), 1) << "应该捕获一个 chunk";

    // 8. 解析 dump 文件格式
    toolkit::dump::DumpData dumpData;
    std::vector<uint8_t> rawTensorData;
    bool parseSuccess = TestDataHelper::ParseDumpFileFormat(g_capturedChunks[0], dumpData, rawTensorData);
    ASSERT_TRUE(parseSuccess) << "解析 dump 格式失败";

    // 9. 验证 protobuf header
    EXPECT_EQ(dumpData.version(), "2.0");
    EXPECT_EQ(dumpData.op_name(), "add_op_0");
    EXPECT_EQ(dumpData.input_size(), 1);
    EXPECT_EQ(dumpData.output_size(), 0);

    // 10. 验证 input tensor metadata
    const toolkit::dump::OpInput& input = dumpData.input(0);
    EXPECT_EQ(input.data_type(), toolkit::dump::DT_INT32);
    EXPECT_EQ(input.format(), toolkit::dump::FORMAT_ND);
    EXPECT_EQ(input.size(), TEST_TENSOR_SIZE_INT32);

    // 验证 shape
    EXPECT_EQ(input.shape().dim_size(), 2);
    EXPECT_EQ(input.shape().dim(0), 8);
    EXPECT_EQ(input.shape().dim(1), 8);

    // 11. 验证 raw tensor data 与输入一致
    ASSERT_EQ(rawTensorData.size(), TEST_TENSOR_SIZE_INT32);
    bool dataMatch =
        TestDataHelper::CompareDataBuffers(rawTensorData.data(), testInt32Data.data(), TEST_TENSOR_SIZE_INT32);
    EXPECT_TRUE(dataMatch) << "Tensor raw data 与输入不一致";

    // 12. 验证文件名格式
    EXPECT_TRUE(g_capturedFileName.find("Add.add_op_0") != std::string::npos);
    EXPECT_TRUE(g_capturedFileName.find("100") != std::string::npos); // taskId
    EXPECT_TRUE(g_capturedFileName.find("10") != std::string::npos);  // streamId
}

/**
 * @brief 测试：输入+输出 tensor 数据一致性验证
 *
 * 测试场景：
 * - 输入：int32 类型 input tensor
 * - 输出：float 类型 output tensor
 * - 验证：两种 tensor 的数据都正确保存
 */
TEST_F(DumpStreamInfoDataConsistencyUtest, Test_InputOutputTensor_DataConsistency)
{
    // 1. 构造输入 tensor（int32）
    auto testInt32Data = TestDataHelper::CreateInt32TestData(64, TEST_INT32_VALUE);
    std::vector<int64_t> inputShape = {8, 8};

    TensorInfoV2 inputInfo = TestDataHelper::CreateTestTensor(
        static_cast<int32_t>(toolkit::dump::DT_INT32), TEST_TENSOR_SIZE_INT32, inputShape,
        reinterpret_cast<int64_t*>(testInt32Data.data()));

    DumpTensor inputTensor(inputInfo);

    // 2. 构造输出 tensor（float）
    auto testFloatData = TestDataHelper::CreateFloatTestData(128, TEST_FLOAT_VALUE);
    std::vector<int64_t> outputShape = {16, 8};

    TensorInfoV2 outputInfo = TestDataHelper::CreateTestTensor(
        static_cast<int32_t>(toolkit::dump::DT_FLOAT), TEST_TENSOR_SIZE_FLOAT, outputShape,
        reinterpret_cast<int64_t*>(testFloatData.data()));
    outputInfo.type = TensorType::OUTPUT;

    DumpTensor outputTensor(outputInfo);

    std::vector<DumpTensor> inputTensors = {inputTensor};
    std::vector<DumpTensor> outputTensors = {outputTensor};

    // 3. 创建 DumpStreamInfo
    DumpStreamInfo* dumpInfo = CreateTestDumpStreamInfo(inputTensors, outputTensors, "MatMul", "matmul_op_1");
    std::shared_ptr<DumpStreamInfo> dumpInfoPtr(dumpInfo, DumpStreamFree);

    // 4. Mock 函数
    MOCKER_CPP(&DumpMemory::CopyDeviceToHost).stubs().will(invoke([](const void* devMem, uint64_t memSize) -> void* {
        void* hostMem = malloc(memSize);
        if (hostMem != nullptr) {
            (void)memcpy_s(hostMem, memSize, devMem, memSize);
        }
        return hostMem;
    }));

    MOCKER(DumpTensorPushToDumpQueue)
        .stubs()
        .will(invoke(
            [](void* dataBuf, uint32_t bufLen, const char* fileName, uint64_t offset, uint32_t isLastChunk) -> int32_t {
                std::vector<uint8_t> chunk(bufLen);
                (void)memcpy_s(chunk.data(), bufLen, dataBuf, bufLen);
                g_capturedChunks.push_back(chunk);
                g_capturedFileName = fileName;
                return ADUMP_SUCCESS;
            }));

    MOCKER_CPP(&AdxDumpRecord::RecordDumpDataToQueue).stubs().will(returnValue(true));

    // 5. 执行 DumpTensorToQueue
    DumpTensorToQueue(dumpInfo);

    // 6. 解析数据
    ASSERT_EQ(g_capturedChunks.size(), 1);

    toolkit::dump::DumpData dumpData;
    std::vector<uint8_t> rawTensorData;
    bool parseSuccess = TestDataHelper::ParseDumpFileFormat(g_capturedChunks[0], dumpData, rawTensorData);
    ASSERT_TRUE(parseSuccess);

    // 7. 验证 protobuf header
    EXPECT_EQ(dumpData.op_name(), "matmul_op_1");
    EXPECT_EQ(dumpData.input_size(), 1);
    EXPECT_EQ(dumpData.output_size(), 1);

    // 8. 验证 input tensor metadata
    const toolkit::dump::OpInput& input = dumpData.input(0);
    EXPECT_EQ(input.data_type(), toolkit::dump::DT_INT32);
    EXPECT_EQ(input.format(), toolkit::dump::FORMAT_ND);
    EXPECT_EQ(input.size(), TEST_TENSOR_SIZE_INT32);
    EXPECT_EQ(input.shape().dim(0), 8);
    EXPECT_EQ(input.shape().dim(1), 8);

    // 9. 验证 output tensor metadata
    const toolkit::dump::OpOutput& output = dumpData.output(0);
    EXPECT_EQ(output.data_type(), toolkit::dump::DT_FLOAT);
    EXPECT_EQ(output.format(), toolkit::dump::FORMAT_ND);
    EXPECT_EQ(output.size(), TEST_TENSOR_SIZE_FLOAT);
    EXPECT_EQ(output.shape().dim(0), 16);
    EXPECT_EQ(output.shape().dim(1), 8);

    // 10. 验证 raw data：先 input 后 output
    size_t expectedTotalSize = TEST_TENSOR_SIZE_INT32 + TEST_TENSOR_SIZE_FLOAT;
    ASSERT_EQ(rawTensorData.size(), expectedTotalSize);

    // 验证 input data（前 TEST_TENSOR_SIZE_INT32 字节）
    bool inputMatch =
        TestDataHelper::CompareDataBuffers(rawTensorData.data(), testInt32Data.data(), TEST_TENSOR_SIZE_INT32);
    EXPECT_TRUE(inputMatch) << "Input tensor raw data 不一致";

    // 验证 output data（后 TEST_TENSOR_SIZE_FLOAT 字节）
    bool outputMatch = TestDataHelper::CompareDataBuffers(
        rawTensorData.data() + TEST_TENSOR_SIZE_INT32, testFloatData.data(), TEST_TENSOR_SIZE_FLOAT);
    EXPECT_TRUE(outputMatch) << "Output tensor raw data 不一致";
}

/**
 * @brief 测试：多输入 tensor 数据一致性验证
 *
 * 测试场景：
 * - 输入：2 个 int32 类型 tensor
 * - 验证：两个 tensor 的数据顺序和内容正确
 */
TEST_F(DumpStreamInfoDataConsistencyUtest, Test_MultipleInputTensors_DataConsistency)
{
    // 1. 构造两个 input tensor
    auto testData1 = TestDataHelper::CreateInt32TestData(32, 1000); // 32 elements = 128 bytes
    auto testData2 = TestDataHelper::CreateInt32TestData(32, 2000); // 32 elements = 128 bytes

    std::vector<int64_t> shape1 = {4, 8};
    std::vector<int64_t> shape2 = {8, 4};

    TensorInfoV2 tensorInfo1 = TestDataHelper::CreateTestTensor(
        static_cast<int32_t>(toolkit::dump::DT_INT32), 128, shape1, reinterpret_cast<int64_t*>(testData1.data()));

    TensorInfoV2 tensorInfo2 = TestDataHelper::CreateTestTensor(
        static_cast<int32_t>(toolkit::dump::DT_INT32), 128, shape2, reinterpret_cast<int64_t*>(testData2.data()));

    DumpTensor tensor1(tensorInfo1);
    DumpTensor tensor2(tensorInfo2);

    std::vector<DumpTensor> inputTensors = {tensor1, tensor2};
    std::vector<DumpTensor> outputTensors;

    // 2. 创建 DumpStreamInfo
    DumpStreamInfo* dumpInfo = CreateTestDumpStreamInfo(inputTensors, outputTensors, "Concat", "concat_op_2");
    std::shared_ptr<DumpStreamInfo> dumpInfoPtr(dumpInfo, DumpStreamFree);

    // 3. Mock 函数
    MOCKER_CPP(&DumpMemory::CopyDeviceToHost).stubs().will(invoke([](const void* devMem, uint64_t memSize) -> void* {
        void* hostMem = malloc(memSize);
        if (hostMem != nullptr) {
            (void)memcpy_s(hostMem, memSize, devMem, memSize);
        }
        return hostMem;
    }));

    MOCKER(DumpTensorPushToDumpQueue)
        .stubs()
        .will(invoke(
            [](void* dataBuf, uint32_t bufLen, const char* fileName, uint64_t offset, uint32_t isLastChunk) -> int32_t {
                std::vector<uint8_t> chunk(bufLen);
                (void)memcpy_s(chunk.data(), bufLen, dataBuf, bufLen);
                g_capturedChunks.push_back(chunk);
                return ADUMP_SUCCESS;
            }));

    MOCKER_CPP(&AdxDumpRecord::RecordDumpDataToQueue).stubs().will(returnValue(true));

    // 4. 执行
    DumpTensorToQueue(dumpInfo);

    // 5. 解析验证
    toolkit::dump::DumpData dumpData;
    std::vector<uint8_t> rawTensorData;
    TestDataHelper::ParseDumpFileFormat(g_capturedChunks[0], dumpData, rawTensorData);

    // 6. 验证有两个 input
    EXPECT_EQ(dumpData.input_size(), 2);

    // 7. 验证两个 input 的 metadata
    EXPECT_EQ(dumpData.input(0).size(), 128);
    EXPECT_EQ(dumpData.input(0).shape().dim(0), 4);
    EXPECT_EQ(dumpData.input(0).shape().dim(1), 8);

    EXPECT_EQ(dumpData.input(1).size(), 128);
    EXPECT_EQ(dumpData.input(1).shape().dim(0), 8);
    EXPECT_EQ(dumpData.input(1).shape().dim(1), 4);

    // 8. 验证 raw data：两个 tensor 顺序拼接
    ASSERT_EQ(rawTensorData.size(), 256); // 128 + 128

    bool match1 = TestDataHelper::CompareDataBuffers(rawTensorData.data(), testData1.data(), 128);
    bool match2 = TestDataHelper::CompareDataBuffers(rawTensorData.data() + 128, testData2.data(), 128);
    EXPECT_TRUE(match1) << "第一个 input tensor data 不一致";
    EXPECT_TRUE(match2) << "第二个 input tensor data 不一致";
}

/**
 * @brief 测试：验证 DumpDataRecordInCaptureStream 回调函数数据传递
 *
 * 测试场景：
 * - 通过 DumpDataRecordInCaptureStream 回调调用
 * - 验证数据从 fnArgs 正确传递到 DumpTensorToQueue
 */
TEST_F(DumpStreamInfoDataConsistencyUtest, Test_DumpDataRecordInCaptureStream_CallbackDataPass)
{
    // 1. 构造测试数据
    auto testInt32Data = TestDataHelper::CreateInt32TestData(16, 5000);
    std::vector<int64_t> shape = {4, 4};

    TensorInfoV2 tensorInfo = TestDataHelper::CreateTestTensor(
        static_cast<int32_t>(toolkit::dump::DT_INT32), 64, shape, reinterpret_cast<int64_t*>(testInt32Data.data()));

    DumpTensor dumpTensor(tensorInfo);
    std::vector<DumpTensor> inputTensors = {dumpTensor};
    std::vector<DumpTensor> outputTensors;

    // 2. 创建 DumpStreamInfo（模拟 SetupAsyncDump 中的创建）
    DumpStreamInfo* dumpInfo = CreateTestDumpStreamInfo(inputTensors, outputTensors, "Relu", "relu_op_3");

    // 3. 使用 shared_ptr 包装（模拟实际流程）
    auto* rawContext = new std::shared_ptr<DumpStreamInfo>(dumpInfo, DumpStreamFree);

    // 4. Mock 函数
    MOCKER_CPP(&DumpMemory::CopyDeviceToHost).stubs().will(invoke([](const void* devMem, uint64_t memSize) -> void* {
        void* hostMem = malloc(memSize);
        if (hostMem != nullptr) {
            (void)memcpy_s(hostMem, memSize, devMem, memSize);
        }
        return hostMem;
    }));

    MOCKER(DumpTensorPushToDumpQueue)
        .stubs()
        .will(invoke(
            [](void* dataBuf, uint32_t bufLen, const char* fileName, uint64_t offset, uint32_t isLastChunk) -> int32_t {
                std::vector<uint8_t> chunk(bufLen);
                (void)memcpy_s(chunk.data(), bufLen, dataBuf, bufLen);
                g_capturedChunks.push_back(chunk);
                return ADUMP_SUCCESS;
            }));

    MOCKER_CPP(&AdxDumpRecord::RecordDumpDataToQueue).stubs().will(returnValue(true));

    // Mock DumpResourceSafeMap::EnqueueCleanup - 不执行清理
    MOCKER_CPP(&DumpResourceSafeMap::EnqueueCleanup).stubs().will(returnValue());

    // 5. 执行 DumpDataRecordInCaptureStream
    DumpDataRecordInCaptureStream(static_cast<void*>(rawContext));

    // 6. 验证数据被正确处理
    ASSERT_GE(g_capturedChunks.size(), 1);

    toolkit::dump::DumpData dumpData;
    std::vector<uint8_t> rawTensorData;
    TestDataHelper::ParseDumpFileFormat(g_capturedChunks[0], dumpData, rawTensorData);

    // 7. 验证 op_name
    EXPECT_EQ(dumpData.op_name(), "relu_op_3");

    // 8. 验证数据一致性
    ASSERT_EQ(rawTensorData.size(), 64);
    bool dataMatch = TestDataHelper::CompareDataBuffers(rawTensorData.data(), testInt32Data.data(), 64);
    EXPECT_TRUE(dataMatch) << "Callback 传递的数据不一致";
}

/**
 * @brief 测试：不同数据类型的数据一致性
 *
 * 测试场景：
 * - 验证多种数据类型的正确序列化和反序列化
 */
TEST_F(DumpStreamInfoDataConsistencyUtest, Test_DifferentDataType_DataConsistency)
{
    // 测试 DT_INT64 类型
    std::vector<int64_t> int64Data(16, 9876543210LL);
    std::vector<int64_t> shape = {4, 4};

    TensorInfoV2 tensorInfo =
        TestDataHelper::CreateTestTensor(static_cast<int32_t>(toolkit::dump::DT_INT64), 128, shape, int64Data.data());

    DumpTensor dumpTensor(tensorInfo);
    std::vector<DumpTensor> inputTensors = {dumpTensor};
    std::vector<DumpTensor> outputTensors;

    DumpStreamInfo* dumpInfo = CreateTestDumpStreamInfo(inputTensors, outputTensors, "Cast", "cast_op_4");
    std::shared_ptr<DumpStreamInfo> dumpInfoPtr(dumpInfo, DumpStreamFree);

    MOCKER_CPP(&DumpMemory::CopyDeviceToHost).stubs().will(invoke([](const void* devMem, uint64_t memSize) -> void* {
        void* hostMem = malloc(memSize);
        if (hostMem != nullptr) {
            (void)memcpy_s(hostMem, memSize, devMem, memSize);
        }
        return hostMem;
    }));

    MOCKER(DumpTensorPushToDumpQueue)
        .stubs()
        .will(invoke(
            [](void* dataBuf, uint32_t bufLen, const char* fileName, uint64_t offset, uint32_t isLastChunk) -> int32_t {
                std::vector<uint8_t> chunk(bufLen);
                (void)memcpy_s(chunk.data(), bufLen, dataBuf, bufLen);
                g_capturedChunks.push_back(chunk);
                return ADUMP_SUCCESS;
            }));

    MOCKER_CPP(&AdxDumpRecord::RecordDumpDataToQueue).stubs().will(returnValue(true));

    DumpTensorToQueue(dumpInfo);

    toolkit::dump::DumpData dumpData;
    std::vector<uint8_t> rawTensorData;
    TestDataHelper::ParseDumpFileFormat(g_capturedChunks[0], dumpData, rawTensorData);

    // 验证数据类型
    EXPECT_EQ(dumpData.input(0).data_type(), toolkit::dump::DT_INT64);

    // 验证数据内容
    ASSERT_EQ(rawTensorData.size(), 128);
    bool dataMatch = TestDataHelper::CompareDataBuffers(rawTensorData.data(), int64Data.data(), 128);
    EXPECT_TRUE(dataMatch) << "INT64 数据不一致";
}

/**
 * @brief 测试：空 tensor 场景
 *
 * 测试场景：
 * - 输入输出 tensor 都为空
 * - 验证不会崩溃，生成空文件
 */
TEST_F(DumpStreamInfoDataConsistencyUtest, Test_EmptyTensors_NoCrash)
{
    std::vector<DumpTensor> inputTensors;
    std::vector<DumpTensor> outputTensors;

    DumpStreamInfo* dumpInfo = CreateTestDumpStreamInfo(inputTensors, outputTensors, "Empty", "empty_op");

    MOCKER(DumpTensorPushToDumpQueue)
        .stubs()
        .will(invoke(
            [](void* dataBuf, uint32_t bufLen, const char* fileName, uint64_t offset, uint32_t isLastChunk) -> int32_t {
                std::vector<uint8_t> chunk(bufLen);
                (void)memcpy_s(chunk.data(), bufLen, dataBuf, bufLen);
                g_capturedChunks.push_back(chunk);
                return ADUMP_SUCCESS;
            }));

    MOCKER_CPP(&AdxDumpRecord::RecordDumpDataToQueue).stubs().will(returnValue(true));

    // 执行不应崩溃
    DumpTensorToQueue(dumpInfo);

    // 验证生成一个 chunk（只包含 protobuf header）
    ASSERT_GE(g_capturedChunks.size(), 1);

    toolkit::dump::DumpData dumpData;
    std::vector<uint8_t> rawTensorData;
    TestDataHelper::ParseDumpFileFormat(g_capturedChunks[0], dumpData, rawTensorData);

    // 验证 input/output 数量为 0
    EXPECT_EQ(dumpData.input_size(), 0);
    EXPECT_EQ(dumpData.output_size(), 0);

    // raw data 应为空
    EXPECT_EQ(rawTensorData.size(), 0);

    delete dumpInfo;
}