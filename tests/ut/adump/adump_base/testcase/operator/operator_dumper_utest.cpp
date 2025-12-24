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
#include "operator_dumper.h"
#include "gert_tensor_builder.h"
#include "runtime/rt.h"
#include "rts/rts_device.h"
#include "rts/rts_stream.h"
#include "rts/rts_kernel.h"
#include "dump_manager.h"

using namespace Adx;

class OperatorDumperUtest: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

class OperatorDumperBuilder {
public:
    OperatorDumperBuilder() = default;
    OperatorDumperBuilder &OpType(const std::string &opType)
    {
        opType_ = opType;
        return *this;
    }

    OperatorDumperBuilder &OpName(const std::string &opName)
    {
        opName_ = opName;
        return *this;
    }

    OperatorDumperBuilder &DumpPath(const std::string &dumpPath)
    {
        dumpPath_ = dumpPath;
        return *this;
    }

    OperatorDumperBuilder &DumpMode(const std::string &dumpMode)
    {
        dumpMode_ = dumpMode;
        return *this;
    }

    OperatorDumperBuilder &AddInputTensor(gert::Tensor *tensor, AddressType addrType = AddressType::TRADITIONAL)
    {
        if (tensor == nullptr) {
            return *this;
        }

        TensorInfoV2 tensorV2 = {};
        tensorV2.addrType = addrType;
        tensorV2.argsOffSet = 0U;
        TensorInfo tensor1 = {tensor, TensorType::INPUT, AddressType::TRADITIONAL};
        DumpManager::Instance().ConvertTensorInfo(tensor1, tensorV2);
        inputDumpTensors_.emplace_back(tensorV2);
        return *this;
    }

    OperatorDumperBuilder &AddOutputTensor(gert::Tensor *tensor, AddressType addrType = AddressType::TRADITIONAL)
    {
        if (tensor == nullptr) {
            return *this;
        }
        TensorInfoV2 tensorV2 = {};
        tensorV2.addrType = addrType;
        tensorV2.argsOffSet = 0U;
        TensorInfo tensor1 = {tensor, TensorType::INPUT, AddressType::TRADITIONAL};
        DumpManager::Instance().ConvertTensorInfo(tensor1, tensorV2);
        outputDumpTensors_.emplace_back(tensorV2);
        return *this;
    }

    OperatorDumperBuilder &Stream(rtStream_t stream)
    {
        stream_ = stream;
        return *this;
    }

    OperatorDumper Build()
    {
        OperatorDumper opDumper(opType_, opName_);
        opDumper.SetDumpSetting(GetDumpSetting())
            .InputDumpTensor(inputDumpTensors_)
            .OutputDumpTensor(outputDumpTensors_)
            .RuntimeStream(stream_);
        return opDumper;
    }

    DumpSetting GetDumpSetting() const
    {
        struct DumpConfig dumpConf;
        dumpConf.dumpPath = dumpPath_;
        dumpConf.dumpStatus = "on";
        dumpConf.dumpMode = dumpMode_;
        DumpSetting setting;
        (void) setting.Init(DumpType::OPERATOR, dumpConf);
        return setting;
    }

private:
    std::string opType_ {"TestOpType"};
    std::string opName_ {"TestOpName"};
    std::string dumpPath_ {"/path/to/dump/"};
    std::string dumpMode_ {"all"};
    std::vector<DumpTensor> inputDumpTensors_;
    std::vector<DumpTensor> outputDumpTensors_;
    rtStream_t stream_ {nullptr};
};

TEST_F(OperatorDumperUtest, Test_DumpTensor_Success)
{
    auto inputTensor = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 16}).Build();
    auto outputTensor = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Shape({4, 16}).Build();

    OperatorDumper opDumper = OperatorDumperBuilder()
        .AddInputTensor(inputTensor.GetTensor())
        .AddOutputTensor(outputTensor.GetTensor())
        .Build();

    EXPECT_EQ(opDumper.Launch(), ADUMP_SUCCESS);
}

TEST_F(OperatorDumperUtest, Test_DumpTensor_With_rtMalloc_Error)
{
    MOCKER(rtMalloc).stubs().will(returnValue(-1));
    auto th = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Build();
    OperatorDumper opDumper = OperatorDumperBuilder().AddOutputTensor(th.GetTensor()).Build();
    EXPECT_EQ(opDumper.Launch(), ADUMP_FAILED);
}

TEST_F(OperatorDumperUtest, Test_DumpTensor_With_rtMemcpy_Error)
{
    MOCKER(rtMemcpy).stubs().will(returnValue(-1));
    auto th = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Build();
    OperatorDumper opDumper = OperatorDumperBuilder().AddOutputTensor(th.GetTensor()).Build();
    EXPECT_EQ(opDumper.Launch(), ADUMP_FAILED);
}

TEST_F(OperatorDumperUtest, Test_DumpTensor_With_rtGetDevice_Error)
{
    MOCKER(rtGetDevice).stubs().will(returnValue(-1));
    auto th = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Build();
    OperatorDumper opDumper = OperatorDumperBuilder().AddOutputTensor(th.GetTensor()).Build();
    EXPECT_EQ(opDumper.Launch(), ADUMP_FAILED);
}


TEST_F(OperatorDumperUtest, Test_DumpTensor_With_rtGetTaskIdAndStreamID_Error)
{
    MOCKER(rtsDeviceGetCapability).stubs().will(returnValue(-1));
    auto th = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Build();
    OperatorDumper opDumper = OperatorDumperBuilder().AddOutputTensor(th.GetTensor()).Build();
    EXPECT_EQ(ADUMP_FAILED, opDumper.Launch());
    MOCKER(rtsStreamGetId).stubs().will(returnValue(-1));
    EXPECT_EQ(ADUMP_FAILED, opDumper.Launch());
    MOCKER(rtsGetThreadLastTaskId).stubs().will(returnValue(-1));
    EXPECT_EQ(ADUMP_FAILED, opDumper.Launch());
}

TEST_F(OperatorDumperUtest, Test_DumpTensor_With_rtCpuKernelLaunch_Error)
{
    MOCKER(rtCpuKernelLaunchWithFlag).stubs().will(returnValue(-1));
    auto th = gert::TensorBuilder().Placement(gert::kOnDeviceHbm).DataType(ge::DT_INT32).Build();
    OperatorDumper opDumper = OperatorDumperBuilder().AddOutputTensor(th.GetTensor()).Build();
    EXPECT_EQ(opDumper.Launch(), ADUMP_FAILED);
}