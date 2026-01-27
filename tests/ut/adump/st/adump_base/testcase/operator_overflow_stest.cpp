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
#include "mockcpp/mockcpp.hpp"
#include "gert_tensor_builder.h"
#include "dump_param_builder.h"
#include "runtime/rt.h"
#include "rts/rts_device.h"
#include "rts/rts_stream.h"
#include "rts/rts_kernel.h"
#include "adump_pub.h"
#include "adump_api.h"

using namespace Adx;

class OperatorOverflowStest: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(OperatorOverflowStest, Test_EnableOperatorOverflow)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OP_OVERFLOW, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::OP_OVERFLOW), true);
}

TEST_F(OperatorOverflowStest, Test_DisableOperatorOverflow)
{
    DumpConfig dumpConf;
    dumpConf.dumpStatus = "off";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OP_OVERFLOW, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::OP_OVERFLOW), false);
}

TEST_F(OperatorOverflowStest, Test_DumpConfWithInvalidDumpStatus)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "invalid_status";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OP_OVERFLOW, dumpConf), ADUMP_FAILED);
}

TEST_F(OperatorOverflowStest, Test_DumpConfWithDumpMode)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "invalid_mode";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OP_OVERFLOW, dumpConf), ADUMP_SUCCESS);
}

TEST_F(OperatorOverflowStest, Test_DumpConfWithEmptyDumpPath)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OP_OVERFLOW, dumpConf), ADUMP_FAILED);
}

TEST_F(OperatorOverflowStest, Test_DumpTensor)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OP_OVERFLOW, dumpConf), ADUMP_SUCCESS);

    auto inputTensor = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 16}).Build();
    auto outputTensor = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 16}).Build();

    TensorInfo inputTensorInfo = BuildTensorInfo(inputTensor.GetTensor(), TensorType::INPUT);
    TensorInfo outputTensorInfo = BuildTensorInfo(outputTensor.GetTensor(), TensorType::OUTPUT);
    std::vector<TensorInfo> tensorInfos = {inputTensorInfo, outputTensorInfo};
    aclrtStream stream = (aclrtStream)0x1234;
    EXPECT_EQ(AdumpDumpTensor("Conv2D", "op_name", tensorInfos, stream), ADUMP_SUCCESS);
}


TEST_F(OperatorOverflowStest, Test_DumpTensor_NotOnDevice)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OP_OVERFLOW, dumpConf), ADUMP_SUCCESS);

    auto inputTensor = gert::TensorBuilder().Placement(gert::kFollowing).DataType(ge::DT_INT32).Build();
    auto outputTensor = gert::TensorBuilder().Placement(gert::kOnHost).DataType(ge::DT_INT32).Build();

    TensorInfo inputTensorInfo = BuildTensorInfo(inputTensor.GetTensor(), TensorType::INPUT);
    TensorInfo outputTensorInfo = BuildTensorInfo(outputTensor.GetTensor(), TensorType::OUTPUT);
    std::vector<TensorInfo> tensorInfos = {inputTensorInfo, outputTensorInfo};
    aclrtStream stream = (aclrtStream)0x1234;
    EXPECT_EQ(AdumpDumpTensor("Conv2D", "op_name", tensorInfos, stream), ADUMP_SUCCESS);
}

TEST_F(OperatorOverflowStest, Test_DumpTensor_with_nullptr)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OP_OVERFLOW, dumpConf), ADUMP_SUCCESS);

    TensorInfo outputTensorInfo = BuildTensorInfo(nullptr, TensorType::OUTPUT);
    std::vector<TensorInfo> tensorInfos = {outputTensorInfo};
    aclrtStream stream = (aclrtStream)0x1234;
    EXPECT_EQ(AdumpDumpTensor("Conv2D", "op_name", tensorInfos, stream), ADUMP_FAILED);
}

TEST_F(OperatorOverflowStest, Test_DumpTensor_with_DumpStatus_off)
{
    DumpConfig dumpConf;
    dumpConf.dumpStatus = "off";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);
    aclrtStream stream = (aclrtStream)0x1234;
    EXPECT_EQ(AdumpDumpTensor("Conv2D", "op_name", {}, stream), ADUMP_SUCCESS);
}

TEST_F(OperatorOverflowStest, Test_DumpTensor_rtMalloc_fail)
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

TEST_F(OperatorOverflowStest, Test_DumpTensor_rtMemcpy_fail)
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

TEST_F(OperatorOverflowStest, Test_DumpTensor_rtGetDevice_fail)
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


TEST_F(OperatorOverflowStest, Test_DumpTensor_rtGetTaskIdAndStreamID_fail)
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

TEST_F(OperatorOverflowStest, Test_DumpTensor_rtCpuKernelLaunch_fail)
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

