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
#include <memory>
#include "mockcpp/mockcpp.hpp"
#include "ascend_hal.h"
#include "gert_tensor_builder.h"
#include "dump_param_builder.h"
#include "runtime/rt.h"
#include "runtime/rt_error_codes.h"
#include "rts/rts_device.h"
#include "rts/rts_stream.h"
#include "rts/rts_kernel.h"
#include "file_utils.h"
#include "file.h"
#include "adump_pub.h"
#include "dump_manager.h"

using namespace Adx;

class OperatorDumpStest: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(OperatorDumpStest, Test_EnableOperatorDump)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::OPERATOR), true);
    uint64_t dumpSwitch = 0;
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::OPERATOR, dumpSwitch), true);
    EXPECT_EQ(dumpSwitch, dumpConf.dumpSwitch);
}

TEST_F(OperatorDumpStest, Test_EnableOperatorDump_Op)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = OPERATOR_OP_DUMP;
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::OPERATOR), false);
    uint64_t dumpSwitch = 0;
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::OPERATOR, dumpSwitch), false);
    EXPECT_EQ(dumpSwitch, dumpConf.dumpSwitch);
}

TEST_F(OperatorDumpStest, Test_DisableOperatorDump)
{
    DumpConfig dumpConf;
    dumpConf.dumpStatus = "off";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::OPERATOR), false);
}

TEST_F(OperatorDumpStest, Test_DumpConfWithInvalidDumpStatus)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "invalid_status";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_FAILED);
}

TEST_F(OperatorDumpStest, Test_DumpConfWithInvalidDumpMode)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "invalid_mode";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_FAILED);
}

TEST_F(OperatorDumpStest, Test_DumpConfWithEmptyDumpPath)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_FAILED);
}

TEST_F(OperatorDumpStest, Test_DumpConfWithInvalidDumpStats)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    dumpConf.dumpStatsItem.push_back("what is this");
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_FAILED);
}

TEST_F(OperatorDumpStest, Test_DumpTensor)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);

    auto inputTensor = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 16}).Build();
    auto outputTensor = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 16}).Build();

    TensorInfo inputTensorInfo = BuildTensorInfo(inputTensor.GetTensor(), TensorType::INPUT);
    TensorInfo outputTensorInfo = BuildTensorInfo(outputTensor.GetTensor(), TensorType::OUTPUT);
    std::vector<TensorInfo> tensorInfos = {inputTensorInfo, outputTensorInfo};
    aclrtStream stream = (aclrtStream)0x1234;
    EXPECT_EQ(AdumpDumpTensor("Conv2D", "op_name", tensorInfos, stream), ADUMP_SUCCESS);
}


TEST_F(OperatorDumpStest, Test_DumpTensor_Multi_DataType)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);

    std::vector<ge::DataType> dataTypes = {
        ge::DT_COMPLEX32, ge::DT_HIFLOAT8, ge::DT_FLOAT8_E5M2, ge::DT_FLOAT8_E4M3FN, ge::DT_FLOAT8_E8M0,
        ge::DT_FLOAT6_E3M2, ge::DT_FLOAT6_E2M3, ge::DT_FLOAT4_E2M1, ge::DT_FLOAT4_E1M2};
    std::vector<TensorInfo> tensorInfos;
    std::vector<std::shared_ptr<gert::TensorHolder>> holders;
    for (int i=0; i < dataTypes.size(); i++) {
        std::shared_ptr<gert::TensorHolder> holder = std::make_shared<gert::TensorHolder>(
            gert::TensorBuilder()
            .Placement(gert::kOnDeviceHbm)
            .DataType(dataTypes[i])
            .Shape({4, 16})
            .Build());
        holders.push_back(holder);
        TensorInfo inputTensorInfo = BuildTensorInfo(holder->GetTensor(), TensorType::INPUT);
        tensorInfos.emplace_back(inputTensorInfo);
    }
    aclrtStream stream = (aclrtStream)0x1234;
    EXPECT_EQ(AdumpDumpTensor("Conv2D", "op_name", tensorInfos, stream), ADUMP_SUCCESS);
}


TEST_F(OperatorDumpStest, Test_DumpTensor_Stats)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    dumpConf.dumpData = "stats";
    dumpConf.dumpStatsItem.push_back("Max");
    dumpConf.dumpStatsItem.push_back("Avg");
    dumpConf.dumpStatsItem.push_back("Nan");
    dumpConf.dumpStatsItem.push_back("Min");
    dumpConf.dumpStatsItem.push_back("Negative Inf");
    dumpConf.dumpStatsItem.push_back("Positive Inf");
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);

    auto inputTensor = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 16}).Build();
    auto outputTensor = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 16}).Build();

    TensorInfo inputTensorInfo = BuildTensorInfo(inputTensor.GetTensor(), TensorType::INPUT);
    TensorInfo outputTensorInfo = BuildTensorInfo(outputTensor.GetTensor(), TensorType::OUTPUT);
    std::vector<TensorInfo> tensorInfos = {inputTensorInfo, outputTensorInfo};
    aclrtStream stream = (aclrtStream)0x1234;
    EXPECT_EQ(AdumpDumpTensor("Conv2D", "op_name", tensorInfos, stream), ADUMP_SUCCESS);
    EXPECT_EQ(true, DumpManager::Instance().GetDumpSetting().GetDumpData().compare("stats") == 0);
}

TEST_F(OperatorDumpStest, Test_DumpTensor_NotOnDevice)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);

    auto inputTensor = gert::TensorBuilder().Placement(gert::kFollowing).DataType(ge::DT_INT32).Build();
    auto outputTensor = gert::TensorBuilder().Placement(gert::kOnHost).DataType(ge::DT_INT32).Build();

    TensorInfo inputTensorInfo = BuildTensorInfo(inputTensor.GetTensor(), TensorType::INPUT);
    TensorInfo outputTensorInfo = BuildTensorInfo(outputTensor.GetTensor(), TensorType::OUTPUT);
    std::vector<TensorInfo> tensorInfos = {inputTensorInfo, outputTensorInfo};
    aclrtStream stream = (aclrtStream)0x1234;
    EXPECT_EQ(AdumpDumpTensor("Conv2D", "op_name", tensorInfos, stream), ADUMP_SUCCESS);
}

TEST_F(OperatorDumpStest, Test_DumpTensor_with_nullptr)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);

    TensorInfo outputTensorInfo = BuildTensorInfo(nullptr, TensorType::OUTPUT);
    std::vector<TensorInfo> tensorInfos = {outputTensorInfo};
    aclrtStream stream = (aclrtStream)0x1234;
    EXPECT_EQ(AdumpDumpTensor("Conv2D", "op_name", tensorInfos, stream), ADUMP_FAILED);
}

TEST_F(OperatorDumpStest, Test_DumpTensor_with_DumpStatus_off)
{
    DumpConfig dumpConf;
    dumpConf.dumpStatus = "off";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    aclrtStream stream = (aclrtStream)0x1234;
    EXPECT_EQ(AdumpDumpTensor("Conv2D", "op_name", {}, stream), ADUMP_SUCCESS);
}

TEST_F(OperatorDumpStest, Test_DumpTensor_rtMalloc_fail)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);

    MOCKER(rtMalloc).stubs().will(returnValue(-1));

    auto th = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Build();

    TensorInfo outputTensorInfo = BuildTensorInfo(th.GetTensor(), TensorType::OUTPUT);
    std::vector<TensorInfo> tensorInfos = {outputTensorInfo};
    aclrtStream stream = (aclrtStream)0x1234;
    EXPECT_EQ(AdumpDumpTensor("Conv2D", "op_name", tensorInfos, stream), ADUMP_FAILED);
}

TEST_F(OperatorDumpStest, Test_DumpTensor_rtMemcpy_fail)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);

    MOCKER(rtMemcpy).stubs().will(returnValue(-1));

    auto th = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Build();

    TensorInfo outputTensorInfo = BuildTensorInfo(th.GetTensor(), TensorType::OUTPUT);;
    std::vector<TensorInfo> tensorInfos = {outputTensorInfo};
    aclrtStream stream = (aclrtStream)0x1234;
    EXPECT_EQ(AdumpDumpTensor("Conv2D", "op_name", tensorInfos, stream), ADUMP_FAILED);
}

TEST_F(OperatorDumpStest, Test_DumpTensor_rtGetDevice_fail)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);

    MOCKER(rtGetDevice).stubs().will(returnValue(-1));

    auto th = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Build();

    TensorInfo outputTensorInfo = BuildTensorInfo(th.GetTensor(), TensorType::OUTPUT);;
    std::vector<TensorInfo> tensorInfos = {outputTensorInfo};
    aclrtStream stream = (aclrtStream)0x1234;
    EXPECT_EQ(AdumpDumpTensor("Conv2D", "op_name", tensorInfos, stream), ADUMP_FAILED);
}


TEST_F(OperatorDumpStest, Test_DumpTensor_rtGetTaskIdAndStreamID_fail)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);

    MOCKER(rtsDeviceGetCapability).stubs().will(returnValue(-1));

    auto th = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Build();

    TensorInfo outputTensorInfo = BuildTensorInfo(th.GetTensor(), TensorType::OUTPUT);;
    std::vector<TensorInfo> tensorInfos = {outputTensorInfo};
    aclrtStream stream = (aclrtStream)0x1234;
    EXPECT_EQ(ADUMP_FAILED, AdumpDumpTensor("Conv2D", "op_name", tensorInfos, stream));
    MOCKER(rtsStreamGetId).stubs().will(returnValue(-1));
    EXPECT_EQ(ADUMP_FAILED, AdumpDumpTensor("Conv2D", "op_name", tensorInfos, stream));

    MOCKER(rtsGetThreadLastTaskId).stubs().will(returnValue(-1));
    EXPECT_EQ(ADUMP_FAILED, AdumpDumpTensor("Conv2D", "op_name", tensorInfos, stream));
}

TEST_F(OperatorDumpStest, Test_DumpTensor_rtCpuKernelLaunch_fail)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);

    MOCKER(rtCpuKernelLaunchWithFlag).stubs().will(returnValue(-1));

    auto th = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Build();

    TensorInfo outputTensorInfo = BuildTensorInfo(th.GetTensor(), TensorType::OUTPUT);
    std::vector<TensorInfo> tensorInfos = {outputTensorInfo};
    aclrtStream stream = (aclrtStream)0x1234;
    EXPECT_EQ(AdumpDumpTensor("Conv2D", "op_name", tensorInfos, stream), ADUMP_FAILED);
}

template<int64_t V>
rtError_t rtGetDeviceInfoStub(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value) {
    static int32_t g_halSuccessCnt = 0;
    (void)devId;
    (void)moduleType;
    (void)infoType;
    *value = V;
    if (g_halSuccessCnt > 8) {
        return RT_ERROR_NONE; // 9+
    } else if (g_halSuccessCnt > 7) {
        g_halSuccessCnt++;
        return ACL_ERROR_RT_FEATURE_NOT_SUPPORT; // 8
    }
    g_halSuccessCnt++;
    return ACL_ERROR_RT_NO_DEVICE; // 0
}

int32_t g_versionStubCount = -1;
drvError_t halGetAPIVersionStub(int32_t *halAPIVersion)
{
    *halAPIVersion = 467734;
    g_versionStubCount++;
    if (g_versionStubCount < 1) {
        return DRV_ERROR_NOT_SUPPORT;
    }
    return DRV_ERROR_NONE;
}

TEST_F(OperatorDumpStest, Test_AdumpSetDumpConfig_Milan)
{
    MOCKER(rtMalloc).stubs().will(returnValue(0));
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpData = "stats";
    dumpConf.dumpMode = "output";
    DumpManager::Instance().Reset();

    MOCKER(rtGetDeviceInfo)
        .stubs()
        .will(invoke(rtGetDeviceInfoStub<(uint64_t)(5 << 8)>));
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_FAILED);

    // unsupported
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);

    std::string path = "./llt/abl/adump/st/adump_base/stub/data/simulated_data.txt";
    MOCKER_CPP(&Path::Concat).stubs().will(returnValue(Adx::Path(path)));

    // first init
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_TRUE(DumpManager::Instance().GetKFCInitStatus());
    DumpManager::Instance().SetKFCInitStatus(false);
    EXPECT_FALSE(DumpManager::Instance().GetKFCInitStatus());

    // halGetAPIVersion version not support
    MOCKER_CPP(&halGetAPIVersion).stubs().will(invoke(halGetAPIVersionStub));
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_TRUE(DumpManager::Instance().GetKFCInitStatus());
    DumpManager::Instance().SetKFCInitStatus(false);
    EXPECT_FALSE(DumpManager::Instance().GetKFCInitStatus());

    // halGetAPIVersion failed
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_TRUE(DumpManager::Instance().GetKFCInitStatus());

    MOCKER(&Adx::OperatorPreliminary::OperatorInit)
        .stubs()
        .will(returnValue(ADUMP_FAILED))
        .then(returnValue(ADUMP_SUCCESS));
    // kfc has been successed, thus the same device id will be success.
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    // third init
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
}

TEST_F(OperatorDumpStest, Test_AdumpSetDumpConfig_KfcNotExisted)
{
    MOCKER(rtMalloc).stubs().will(returnValue(0));
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpData = "stats";
    dumpConf.dumpMode = "output";
    DumpManager::Instance().Reset();
    MOCKER(rtGetDeviceInfo)
        .stubs()
        .will(invoke(rtGetDeviceInfoStub<(uint64_t)(15 << 8)>));

    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_FAILED);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    MOCKER_CPP(&FileUtils::IsFileExist).stubs().will(returnValue(false));
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(DumpManager::Instance().GetBinName(), "kfc_dump_stat_ascend910_95.o");
}