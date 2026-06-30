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
#include <atomic>
#include <fstream>
#include <functional>
#include <thread>
#include "mockcpp/mockcpp.hpp"
#include "dump_manager.h"
#include "utils.h"
#include "common/thread.h"
#include "rts/rts_snapshot.h"
#include "adx_dump_record.h"
#include "dump_stream_info.h"
#include "dump_exception_stub.h"

using namespace Adx;

static uint32_t GetOpExecuteTimeOut()
{
    uint32_t timeout = 0U;
    (void)rtGetOpExecuteTimeoutV2(&timeout);
    return timeout;
}

static void WaitInterval_stub(uint32_t intervalSec)
{
    (void)intervalSec;
}

#define JSON_BASE ADUMP_BASE_DIR "stub/data/json/"
class DumpManagerUtest : public testing::Test {
protected:
    virtual void SetUp()
    {
        MOCKER(DumpResourceSafeMap::WaitInterval).stubs().will(invoke(WaitInterval_stub));
        MOCKER(Thread::CreateDetachTaskWithDefaultAttr).stubs().will(returnValue(EN_OK));
        MOCKER(&AdxDumpRecord::RecordDumpDataToQueue).stubs().will(returnValue(true));
    }
    virtual void TearDown()
    {
        DumpManager::Instance().Reset();
        // 恢复默认算子超时时间，避免污染其他用例
        (void)rtSetOpExecuteTimeOutWithMs(18U * 60U * 1000U);
        // Reset() 不清理超时调整状态，这里手动复位，避免泄漏到其他用例
        DumpManager::Instance().opTimeoutModified_ = false;
        DumpManager::Instance().originOpExecuteTimeOut_ = 0U;
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

// datadump 使能时，当前算子超时时间小于阈值，应延长至阈值并备份原值；关闭时恢复
TEST_F(DumpManagerUtest, Test_AdjustAndRestoreOpExecuteTimeOut)
{
    MOCKER(Thread::CreateDetachTaskWithDefaultAttr).stubs().will(returnValue(EN_OK));
    (void)rtSetOpExecuteTimeOutWithMs(300U); // 小于阈值
    DumpManager::Instance().opTimeoutModified_ = false;
    DumpManager::Instance().originOpExecuteTimeOut_ = 0U;

    std::string validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    int32_t ret = DumpManager::Instance().SetDumpConfig(validConfigData.c_str(), validConfigData.size());
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_EQ(DumpManager::Instance().opTimeoutModified_, true);
    EXPECT_EQ(DumpManager::Instance().originOpExecuteTimeOut_, 300U);
    EXPECT_EQ(GetOpExecuteTimeOut(), OP_EXECUTE_TIMEOUT_FOR_DATADUMP_MS);

    ret = DumpManager::Instance().UnSetDumpConfig();
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_EQ(DumpManager::Instance().opTimeoutModified_, false);
    EXPECT_EQ(GetOpExecuteTimeOut(), 300U);
}

// datadump 使能时，当前算子超时时间不小于阈值，不修改也不备份
TEST_F(DumpManagerUtest, Test_AdjustOpExecuteTimeOut_NoNeed)
{
    MOCKER(Thread::CreateDetachTaskWithDefaultAttr).stubs().will(returnValue(EN_OK));
    (void)rtSetOpExecuteTimeOutWithMs(OP_EXECUTE_TIMEOUT_FOR_DATADUMP_MS + 100U); // 不小于阈值
    DumpManager::Instance().opTimeoutModified_ = false;
    DumpManager::Instance().originOpExecuteTimeOut_ = 0U;

    std::string validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    int32_t ret = DumpManager::Instance().SetDumpConfig(validConfigData.c_str(), validConfigData.size());
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_EQ(DumpManager::Instance().opTimeoutModified_, false);
    EXPECT_EQ(GetOpExecuteTimeOut(), OP_EXECUTE_TIMEOUT_FOR_DATADUMP_MS + 100U);

    ret = DumpManager::Instance().UnSetDumpConfig();
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    // 未修改则关闭时不恢复，超时时间保持不变
    EXPECT_EQ(GetOpExecuteTimeOut(), OP_EXECUTE_TIMEOUT_FOR_DATADUMP_MS + 100U);
}

// 获取算子超时时间失败时，调整失败导致使能失败，不备份
TEST_F(DumpManagerUtest, Test_AdjustOpExecuteTimeOut_GetFailed)
{
    MOCKER(Thread::CreateDetachTaskWithDefaultAttr).stubs().will(returnValue(EN_OK));
    MOCKER(rtGetOpExecuteTimeoutV2).stubs().will(returnValue(static_cast<rtError_t>(1)));
    (void)rtSetOpExecuteTimeOutWithMs(300U);
    DumpManager::Instance().opTimeoutModified_ = false;

    std::string validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    int32_t ret = DumpManager::Instance().SetDumpConfig(validConfigData.c_str(), validConfigData.size());
    EXPECT_EQ(ret, ADUMP_FAILED);
    EXPECT_EQ(DumpManager::Instance().opTimeoutModified_, false);

    ret = DumpManager::Instance().UnSetDumpConfig();
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

// 调整时设置算子超时失败，使能失败，应保持未修改状态，不备份原值
TEST_F(DumpManagerUtest, Test_AdjustOpExecuteTimeOut_SetFailed)
{
    MOCKER(Thread::CreateDetachTaskWithDefaultAttr).stubs().will(returnValue(EN_OK));
    (void)rtSetOpExecuteTimeOutWithMs(300U); // 小于阈值
    DumpManager::Instance().opTimeoutModified_ = false;
    DumpManager::Instance().originOpExecuteTimeOut_ = 0U;
    // 设置超时失败，Adjust 应在设置阶段提前返回
    MOCKER(rtSetOpExecuteTimeOutWithMs).stubs().will(returnValue(static_cast<rtError_t>(1)));

    std::string validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    int32_t ret = DumpManager::Instance().SetDumpConfig(validConfigData.c_str(), validConfigData.size());
    EXPECT_EQ(ret, ADUMP_FAILED);
    // 设置失败时不应标记已修改，也不应备份原值
    EXPECT_EQ(DumpManager::Instance().opTimeoutModified_, false);
    EXPECT_EQ(DumpManager::Instance().originOpExecuteTimeOut_, 0U);

    ret = DumpManager::Instance().UnSetDumpConfig();
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

// 恢复时设置算子超时失败，应保持已修改状态，以便下次关闭时重试
TEST_F(DumpManagerUtest, Test_RestoreOpExecuteTimeOut_SetFailed)
{
    MOCKER(Thread::CreateDetachTaskWithDefaultAttr).stubs().will(returnValue(EN_OK));
    (void)rtSetOpExecuteTimeOutWithMs(300U); // 小于阈值
    DumpManager::Instance().opTimeoutModified_ = false;
    DumpManager::Instance().originOpExecuteTimeOut_ = 0U;

    std::string validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    int32_t ret = DumpManager::Instance().SetDumpConfig(validConfigData.c_str(), validConfigData.size());
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_EQ(DumpManager::Instance().opTimeoutModified_, true);
    EXPECT_EQ(DumpManager::Instance().originOpExecuteTimeOut_, 300U);

    // 关闭时恢复超时失败，UnSetDumpConfig 应返回失败，并保持已修改状态以便下次关闭时重试
    MOCKER(rtSetOpExecuteTimeOutWithMs).stubs().will(returnValue(static_cast<rtError_t>(1)));
    ret = DumpManager::Instance().UnSetDumpConfig();
    EXPECT_EQ(ret, ADUMP_FAILED);
    EXPECT_EQ(DumpManager::Instance().opTimeoutModified_, true);
    EXPECT_EQ(DumpManager::Instance().originOpExecuteTimeOut_, 300U);
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
    std::string validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_tensor.json");
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

    DumpInfoParams params = {"test_key_123", inputTensors, outputTensors, "Add", "test_op", 0, 0, 0, 0, 0, ""};
    int32_t ret = GetDumpInfoFromMap(params);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    auto dumpInfo = DumpResourceSafeMap::Instance().get("test_key_123");
    EXPECT_NE(dumpInfo, nullptr);
    EXPECT_EQ(dumpInfo->mainStreamKey, "test_key_123");
    EXPECT_EQ(dumpInfo->opType, "Add");
    EXPECT_EQ(dumpInfo->opName, "test_op");

    DumpResourceSafeMap::Instance().EnqueueCleanup("test_key_123");
    DumpResourceSafeMap::Instance().waitAndClear();
}

TEST_F(DumpManagerUtest, Test_GetDumpInfoFromMap_ReuseExisting)
{
    std::vector<DumpTensor> inputTensors;
    std::vector<DumpTensor> outputTensors;

    DumpInfoParams params1 = {"test_key_456", inputTensors, outputTensors, "Add", "test_op", 0, 0, 0, 0, 0, ""};
    int32_t ret1 = GetDumpInfoFromMap(params1);
    ASSERT_EQ(ret1, ADUMP_SUCCESS);

    auto dumpInfo1 = DumpResourceSafeMap::Instance().get("test_key_456");
    ASSERT_NE(dumpInfo1, nullptr);

    DumpInfoParams params2 = {"test_key_456", inputTensors, outputTensors, "Mul", "test_op2", 0, 0, 0, 0, 0, ""};
    int32_t ret2 = GetDumpInfoFromMap(params2);
    EXPECT_EQ(ret2, ADUMP_SUCCESS);

    auto dumpInfo2 = DumpResourceSafeMap::Instance().get("test_key_456");
    EXPECT_EQ(dumpInfo1.get(), dumpInfo2.get());
    EXPECT_EQ(dumpInfo2->opType, "Add");
    EXPECT_EQ(dumpInfo2->opName, "test_op");

    DumpResourceSafeMap::Instance().EnqueueCleanup("test_key_456");
    DumpResourceSafeMap::Instance().waitAndClear();
}

TEST_F(DumpManagerUtest, Test_UnSetDumpConfig_ClearsResourceMap)
{
    std::string validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    int32_t ret = DumpManager::Instance().SetDumpConfig(validConfigData.c_str(), validConfigData.size());
    ASSERT_EQ(ret, ADUMP_SUCCESS);

    // Create some dump info
    std::vector<DumpTensor> inputTensors;
    std::vector<DumpTensor> outputTensors;
    DumpInfoParams params = {"test_key_789", inputTensors, outputTensors, "Add", "test_op", 0, 0, 0, 0, 0, ""};
    ret = GetDumpInfoFromMap(params);
    ASSERT_EQ(ret, ADUMP_SUCCESS);

    EXPECT_EQ(DumpResourceSafeMap::Instance().size(), 1);

    // Enqueue cleanup for the key
    DumpResourceSafeMap::Instance().EnqueueCleanup("test_key_789");
    std::this_thread::sleep_for(std::chrono::milliseconds(100));

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

TEST_F(DumpManagerUtest, Test_DumpOperatorV2_CaptureWithStatusMode_SkipDump)
{
    std::string validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_tensor.json");
    int32_t ret = DumpManager::Instance().SetDumpConfig(validConfigData.c_str(), validConfigData.size());
    ASSERT_EQ(ret, ADUMP_SUCCESS);

    MOCKER(rtStreamGetCaptureInfo).stubs().will(returnValue(0));

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
    EXPECT_EQ(dumpInfo, nullptr);
}

TEST_F(DumpManagerUtest, Test_RegisterSnapShotCallback_OK)
{
    DumpManager::Instance().snapCbkRegistered_ = false;
    DumpManager::Instance().RegisterSnapShotCallback();
    EXPECT_EQ(DumpManager::Instance().snapCbkRegistered_, true);
}

TEST_F(DumpManagerUtest, Test_RegisterSnapShotCallback_Failture)
{
    MOCKER(rtSnapShotCallbackRegister).stubs().will(returnValue(1)).then(returnValue(207000));
    DumpManager::Instance().snapCbkRegistered_ = false;
    DumpManager::Instance().RegisterSnapShotCallback();
    EXPECT_EQ(DumpManager::Instance().snapCbkRegistered_, false);

    DumpManager::Instance().RegisterSnapShotCallback();
    EXPECT_EQ(DumpManager::Instance().snapCbkRegistered_, false);
}

static int32_t g_callbackInvoked = 0;

static int32_t CallbackWithLockAccess(uint64_t dumpSwitch, const char* dumpConfig, int32_t size)
{
    g_callbackInvoked++;
    const char* path = DumpManager::Instance().GetDataDumpPath();
    return 0;
}

TEST_F(DumpManagerUtest, Test_StartDumpArgs_CallbackNoDeadlock)
{
    g_callbackInvoked = 0;

    int32_t ret = DumpManager::Instance().RegisterCallback(1001, CallbackWithLockAccess, CallbackWithLockAccess);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    MOCKER(Thread::CreateDetachTaskWithDefaultAttr).stubs().will(returnValue(EN_OK));
    std::string validConfigData = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    ret = DumpManager::Instance().SetDumpConfig(validConfigData.c_str(), validConfigData.size());
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    std::string dumpPath = "./llt_test_dump_args";
    system("rm -rf ./llt_test_dump_args");

    ret = DumpManager::Instance().StartDumpArgs(dumpPath);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    EXPECT_EQ(g_callbackInvoked, 3);

    ret = DumpManager::Instance().StopDumpArgs();
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    DumpManager::Instance().StopDataDumpServer();
    DumpManager::Instance().opInfoRecordPath_.clear();
    system("rm -rf ./llt_test_dump_args");
}

TEST_F(DumpManagerUtest, Test_RegisterExceptionDumpCallback_Null)
{
    int32_t ret = DumpManager::Instance().RegisterExceptionDumpCallback(nullptr);
    EXPECT_EQ(ret, ADUMP_INPUT_FAILED);
}

TEST_F(DumpManagerUtest, Test_RegisterExceptionDumpCallback_Success)
{
    int32_t ret = DumpManager::Instance().RegisterExceptionDumpCallback(MockExceptionCallback);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(DumpManagerUtest, Test_UnregisterExceptionDumpCallback_Null)
{
    int32_t ret = DumpManager::Instance().UnregisterExceptionDumpCallback(nullptr);
    EXPECT_EQ(ret, ADUMP_INPUT_FAILED);
}

TEST_F(DumpManagerUtest, Test_UnregisterExceptionDumpCallback_Success)
{
    int32_t ret = DumpManager::Instance().RegisterExceptionDumpCallback(MockExceptionCallback);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    ret = DumpManager::Instance().UnregisterExceptionDumpCallback(MockExceptionCallback);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(DumpManagerUtest, Test_UnregisterExceptionDumpCallback_NotFound)
{
    int32_t ret = DumpManager::Instance().UnregisterExceptionDumpCallback(MockExceptionCallback);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}