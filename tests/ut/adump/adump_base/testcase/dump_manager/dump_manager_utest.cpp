/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include <fstream>
#include <functional>
#include <thread>
#include "mockcpp/mockcpp.hpp"
#include "dump_manager.h"
#include "utils.h"
#include "common/thread.h"

using namespace Adx;
#define JSON_BASE ADUMP_BASE_DIR "stub/data/json/"
class DumpManagerUtest : public testing::Test {
protected:
    virtual void SetUp()
    {}
    virtual void TearDown()
    {
        DumpResourceSafeMap::Instance().waitAndClear();
        DumpManager::Instance().Reset();
        GlobalMockObject::verify();
    }
};

TEST_F(DumpManagerUtest, Test_SetDumpConfig)
{
    MOCKER(Thread::CreateDetachTaskWithDefaultAttr).stubs().will(returnValue(EN_OK));
    int32_t ret = DumpManager::Instance().SetDumpConfig(nullptr, 0);
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = DumpManager::Instance().SetDumpConfig("", 0);
    EXPECT_EQ(ret, ADUMP_FAILED);

    std::string invalidConfigData = ReadFileToString(JSON_BASE "common/bad_path.json");
    ret = DumpManager::Instance().SetDumpConfig(invalidConfigData.c_str(), invalidConfigData.size());
    EXPECT_EQ(ret, ADUMP_INPUT_FAILED);

    std::string validConfigData = ReadFileToString(JSON_BASE "common/only_path.json");
    ret = DumpManager::Instance().SetDumpConfig(validConfigData.c_str(), validConfigData.size());
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    ret = DumpManager::Instance().SetDumpConfig(validConfigData.c_str(), validConfigData.size());
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(DumpManagerUtest, Test_UnSetDumpConfig)
{
    MOCKER(Thread::CreateDetachTaskWithDefaultAttr).stubs().will(returnValue(EN_OK));
    std::string validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    int32_t ret = DumpManager::Instance().SetDumpConfig(validConfigData.c_str(), validConfigData.size());
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = DumpManager::Instance().UnSetDumpConfig();
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    ret = DumpManager::Instance().SetDumpConfig(validConfigData.c_str(), validConfigData.size());
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    MOCKER(&DumpSetting::Init).stubs().will(returnValue(ADUMP_FAILED));
    ret = DumpManager::Instance().UnSetDumpConfig();
    EXPECT_EQ(ret, ADUMP_FAILED);
}

TEST_F(DumpManagerUtest, Test_DumpOperatorV2_WithCapture_Success)
{
    std::string validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    int32_t ret = DumpManager::Instance().SetDumpConfig(validConfigData.c_str(), validConfigData.size());
    ASSERT_EQ(ret, ADUMP_SUCCESS);

    int64_t data[1024];
    for (int i = 0; i < 1024; i++) {
        data[i] = 0;
    }

    std::vector<TensorInfoV2> tensors;
    TensorInfoV2 tensor;
    tensor.tensorAddr = reinterpret_cast<int64_t*>(data);
    tensor.tensorSize = 1024;
    tensor.placement = TensorPlacement::kOnDeviceHbm;
    tensor.type = TensorType::INPUT;
    tensors.push_back(tensor);

    rtStream_t stream = reinterpret_cast<rtStream_t>(0x1);

    std::string mainStreamKey = "1_1";
    auto dumpInfoBefore = DumpResourceSafeMap::Instance().get(mainStreamKey);
    if (dumpInfoBefore != nullptr) {
        DumpResourceSafeMap::Instance().remove(mainStreamKey);
    }

    ret = DumpManager::Instance().DumpOperatorV2("Add", "add_op", tensors, stream);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    auto dumpInfo = DumpResourceSafeMap::Instance().get(mainStreamKey);
    if (dumpInfo != nullptr) {
        EXPECT_EQ(dumpInfo->opType, "Add");
        EXPECT_EQ(dumpInfo->opName, "add_op");
        EXPECT_EQ(dumpInfo->streamId, 1);
        EXPECT_EQ(dumpInfo->taskId, 1);
        EXPECT_EQ(dumpInfo->deviceId, 0);
        EXPECT_GE(dumpInfo->dumpNumber, 0);
        EXPECT_GE(dumpInfo->timestamp, 0);
        DumpResourceSafeMap::Instance().EnqueueCleanup(mainStreamKey);
    }
}

TEST_F(DumpManagerUtest, Test_DumpOperatorV2_WithCapture_NullStream)
{
    std::string validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    int32_t ret = DumpManager::Instance().SetDumpConfig(validConfigData.c_str(), validConfigData.size());
    ASSERT_EQ(ret, ADUMP_SUCCESS);

    std::vector<TensorInfoV2> tensors;
    rtStream_t stream = nullptr;
    ret = DumpManager::Instance().DumpOperatorV2("Add", "add_op", tensors, stream);
    EXPECT_EQ(ret, ADUMP_FAILED);
}

TEST_F(DumpManagerUtest, Test_GetDumpInfoFromMap_CreateNew)
{
    std::vector<DumpTensor> inputTensors;
    std::vector<DumpTensor> outputTensors;

    DumpInfoParams params = {"test_key_123", inputTensors, outputTensors, "Add", "test_op", 0, 0, 0, 0, 0, 0, 0, ""};
    int32_t ret = DumpManager::Instance().GetDumpInfoFromMap(params);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    auto dumpInfo = DumpResourceSafeMap::Instance().get("test_key_123");
    EXPECT_NE(dumpInfo, nullptr);
    EXPECT_EQ(dumpInfo->mainStreamKey, "test_key_123");
    EXPECT_EQ(dumpInfo->opType, "Add");
    EXPECT_EQ(dumpInfo->opName, "test_op");
}

TEST_F(DumpManagerUtest, Test_GetDumpInfoFromMap_ReuseExisting)
{
    std::vector<DumpTensor> inputTensors;
    std::vector<DumpTensor> outputTensors;

    DumpInfoParams params1 = {"test_key_456", inputTensors, outputTensors, "Add", "test_op", 0, 0, 0, 0, 0, 0, 0, ""};
    int32_t ret1 = DumpManager::Instance().GetDumpInfoFromMap(params1);
    ASSERT_EQ(ret1, ADUMP_SUCCESS);

    auto dumpInfo1 = DumpResourceSafeMap::Instance().get("test_key_456");
    ASSERT_NE(dumpInfo1, nullptr);

    DumpInfoParams params2 = {"test_key_456", inputTensors, outputTensors, "Mul", "test_op2", 0, 0, 0, 0, 0, 0, 0, ""};
    int32_t ret2 = DumpManager::Instance().GetDumpInfoFromMap(params2);
    EXPECT_EQ(ret2, ADUMP_SUCCESS);

    auto dumpInfo2 = DumpResourceSafeMap::Instance().get("test_key_456");
    EXPECT_EQ(dumpInfo1.get(), dumpInfo2.get());
    EXPECT_EQ(dumpInfo2->opType, "Add");
    EXPECT_EQ(dumpInfo2->opName, "test_op");
}

TEST_F(DumpManagerUtest, Test_UnSetDumpConfig_ClearsResourceMap)
{
    std::string validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    int32_t ret = DumpManager::Instance().SetDumpConfig(validConfigData.c_str(), validConfigData.size());
    ASSERT_EQ(ret, ADUMP_SUCCESS);

    // Create some dump info
    std::vector<DumpTensor> inputTensors;
    std::vector<DumpTensor> outputTensors;
    DumpInfoParams params = {"test_key_789", inputTensors, outputTensors, "Add", "test_op", 0, 0, 0, 0, 0, 0, 0, ""};
    ret = DumpManager::Instance().GetDumpInfoFromMap(params);
    ASSERT_EQ(ret, ADUMP_SUCCESS);

    EXPECT_EQ(DumpResourceSafeMap::Instance().size(), 1);

    // Enqueue cleanup for the key
    DumpResourceSafeMap::Instance().EnqueueCleanup("test_key_789");
    std::this_thread::sleep_for(std::chrono::milliseconds(100));

    ret = DumpManager::Instance().UnSetDumpConfig();
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_EQ(DumpResourceSafeMap::Instance().size(), 0);
}

TEST_F(DumpManagerUtest, Test_DumpOperatorV2_WithCapture_MultipleTensors)
{
    std::string validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    int32_t ret = DumpManager::Instance().SetDumpConfig(validConfigData.c_str(), validConfigData.size());
    ASSERT_EQ(ret, ADUMP_SUCCESS);

    int64_t data[3][1024];
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 1024; j++) {
            data[i][j] = 0;
        }
    }

    std::vector<TensorInfoV2> tensors;
    for (int i = 0; i < 3; i++) {
        TensorInfoV2 tensor;
        tensor.tensorAddr = reinterpret_cast<int64_t*>(data[i]);
        tensor.tensorSize = 1024;
        tensor.placement = TensorPlacement::kOnDeviceHbm;
        tensor.type = (i % 2 == 0) ? TensorType::INPUT : TensorType::OUTPUT;
        tensors.push_back(tensor);
    }

    rtStream_t stream = reinterpret_cast<rtStream_t>(0x1);
    ret = DumpManager::Instance().DumpOperatorV2("Mul", "mul_op", tensors, stream);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(DumpManagerUtest, Test_DumpOperatorV2_WithCapture_EmptyTensors)
{
    std::string validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    int32_t ret = DumpManager::Instance().SetDumpConfig(validConfigData.c_str(), validConfigData.size());
    ASSERT_EQ(ret, ADUMP_SUCCESS);

    std::vector<TensorInfoV2> tensors;
    rtStream_t stream = reinterpret_cast<rtStream_t>(0x1);
    ret = DumpManager::Instance().DumpOperatorV2("Add", "add_op", tensors, stream);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}