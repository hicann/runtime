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
#include "runtime/rt.h"
#include "rts/rts_device.h"
#include "rts/rts_stream.h"
#include "rts/rts_kernel.h"
#include "dump_manager.h"
#include "runtime_stub.h"

using namespace Adx;

class OperatorDumperUtest : public testing::Test {
protected:
    virtual void SetUp()
    {
        // 默认构造普通单算子流场景：非capture、无PERSISTENT标志，保持同步行为
        SetStubStreamState(RT_STREAM_CAPTURE_STATUS_NONE, 0U);
    }

    virtual void TearDown()
    {
        // 恢复桩默认值，兼容其他用例文件（如dump_manager_utest依赖capture默认ACTIVE）
        SetStubStreamState(RT_STREAM_CAPTURE_STATUS_ACTIVE, 0U);
        GlobalMockObject::verify();
    }
};

class OperatorDumperBuilder {
public:
    OperatorDumperBuilder() = default;
    OperatorDumperBuilder& OpType(const std::string& opType)
    {
        opType_ = opType;
        return *this;
    }

    OperatorDumperBuilder& OpName(const std::string& opName)
    {
        opName_ = opName;
        return *this;
    }

    OperatorDumperBuilder& DumpPath(const std::string& dumpPath)
    {
        dumpPath_ = dumpPath;
        return *this;
    }

    OperatorDumperBuilder& DumpMode(const std::string& dumpMode)
    {
        dumpMode_ = dumpMode;
        return *this;
    }

    OperatorDumperBuilder& DumpData(const std::string& dumpData)
    {
        dumpData_ = dumpData;
        return *this;
    }

    OperatorDumperBuilder& SetDumpType(const DumpType& dumpType)
    {
        dumpType_ = dumpType;
        return *this;
    }

    OperatorDumperBuilder& AddInputTensor(AddressType addrType = AddressType::TRADITIONAL)
    {
        TensorInfo tensor = {};
        tensor.tensorAddr = (int64_t*)0x1234;
        tensor.tensorSize = 1;
        tensor.type = TensorType::INPUT;
        tensor.placement = TensorPlacement::kOnDeviceHbm;
        tensor.addrType = addrType;
        tensor.shape.push_back(1);
        tensor.originShape.push_back(1);
        TensorInfoV2 tensorV2;
        DumpManager::Instance().ConvertTensorInfo(tensor, tensorV2);
        inputDumpTensors_.emplace_back(tensorV2);
        return *this;
    }

    OperatorDumperBuilder& AddOutputTensor(AddressType addrType = AddressType::TRADITIONAL)
    {
        TensorInfo tensor = {};
        tensor.tensorAddr = (int64_t*)0x1234;
        tensor.tensorSize = 2;
        tensor.type = TensorType::OUTPUT;
        tensor.placement = TensorPlacement::kOnDeviceHbm;
        tensor.addrType = addrType;
        tensor.shape.push_back(2);
        tensor.originShape.push_back(2);
        TensorInfoV2 tensorV2;
        DumpManager::Instance().ConvertTensorInfo(tensor, tensorV2);
        outputDumpTensors_.emplace_back(tensorV2);
        return *this;
    }

    OperatorDumperBuilder& Stream(rtStream_t stream)
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
        dumpConf.dumpData = dumpData_;
        DumpSetting setting;
        (void)setting.Init(dumpType_, dumpConf);
        return setting;
    }

private:
    std::string opType_{"TestOpType"};
    std::string opName_{"TestOpName"};
    std::string dumpPath_{"/path/to/dump/"};
    std::string dumpMode_{"all"};
    std::string dumpData_{"tensor"};
    DumpType dumpType_ = DumpType::OPERATOR;
    std::vector<DumpTensor> inputDumpTensors_;
    std::vector<DumpTensor> outputDumpTensors_;
    rtStream_t stream_{nullptr};
};

TEST_F(OperatorDumperUtest, Test_DumpTensor_Tensor_Success)
{
    OperatorDumper opDumper = OperatorDumperBuilder().AddInputTensor().AddOutputTensor(AddressType::RAW).Build();
    EXPECT_EQ(opDumper.Launch(), ADUMP_SUCCESS);
}

TEST_F(OperatorDumperUtest, Test_DumpTensor_Stats_Success)
{
    OperatorDumper opDumper = OperatorDumperBuilder().DumpData("stats").AddInputTensor(AddressType::NOTILING).Build();
    EXPECT_EQ(opDumper.Launch(), ADUMP_SUCCESS);
}

TEST_F(OperatorDumperUtest, Test_DumpTensor_With_rtGetDevice_Error)
{
    MOCKER(rtGetDevice).stubs().will(returnValue(-1));
    OperatorDumper opDumper = OperatorDumperBuilder().AddInputTensor().AddOutputTensor().Build();
    EXPECT_EQ(opDumper.Launch(), ADUMP_FAILED);
}

TEST_F(OperatorDumperUtest, Test_DumpTensor_With_rtsGetThreadLastTaskId_Error)
{
    MOCKER(rtsGetThreadLastTaskId).stubs().will(returnValue(-1));
    OperatorDumper opDumper = OperatorDumperBuilder().AddInputTensor().AddOutputTensor().Build();
    EXPECT_EQ(opDumper.Launch(), ADUMP_FAILED);
}

TEST_F(OperatorDumperUtest, Test_DumpTensor_With_rtsStreamGetId_Error)
{
    MOCKER(rtsStreamGetId).stubs().will(returnValue(-1));
    OperatorDumper opDumper = OperatorDumperBuilder().AddInputTensor().AddOutputTensor().Build();
    EXPECT_EQ(opDumper.Launch(), ADUMP_FAILED);
}

TEST_F(OperatorDumperUtest, Test_DumpTensor_With_rtsDeviceGetCapability_Error)
{
    MOCKER(rtsDeviceGetCapability).stubs().will(returnValue(-1));
    OperatorDumper opDumper = OperatorDumperBuilder().AddInputTensor().AddOutputTensor().Build();
    EXPECT_EQ(opDumper.Launch(), ADUMP_FAILED);
}

TEST_F(OperatorDumperUtest, Test_DumpTensor_With_rtMalloc_Error)
{
    MOCKER(rtMalloc).stubs().will(returnValue(-1));
    OperatorDumper opDumper = OperatorDumperBuilder().DumpData("stats").AddInputTensor().Build();
    EXPECT_EQ(opDumper.Launch(), ADUMP_FAILED);
}

TEST_F(OperatorDumperUtest, Test_DumpTensor_With_rtMemcpy_Error)
{
    MOCKER(rtMemcpy).stubs().will(returnValue(-1));
    OperatorDumper opDumper = OperatorDumperBuilder().AddInputTensor().AddOutputTensor().Build();
    EXPECT_EQ(opDumper.Launch(), ADUMP_FAILED);
}

TEST_F(OperatorDumperUtest, Test_DumpTensor_With_rtCpuKernelLaunch_Error)
{
    MOCKER(rtCpuKernelLaunchWithFlag).stubs().will(returnValue(-1));
    OperatorDumper opDumper = OperatorDumperBuilder().AddInputTensor().AddOutputTensor().Build();
    EXPECT_EQ(opDumper.Launch(), ADUMP_FAILED);
}

TEST_F(OperatorDumperUtest, Test_DumpTensorWithCfg_StaticGraph_Tensor_Success)
{
    DumpCfg dumpCfg;
    std::vector<DumpAttr> attrs;
    std::string modelName{"modelName"};
    std::string dumpStep{"0|1|3"};
    attrs.push_back({DUMP_ATTR_MODEL_NAME, {.modelName = const_cast<char*>(modelName.c_str())}});
    attrs.push_back({DUMP_ATTR_MODEL_NAMESIZE, {.modelNameSize = modelName.size()}});
    attrs.push_back({DUMP_ATTR_MODEL_ID, {.modelId = 10U}});
    attrs.push_back({DUMP_ATTR_STEP_ID_ADDR, {.stepIdAddr = 0x1234}});
    attrs.push_back({DUMP_ATTR_ITER_PER_LOOP_ADDR, {.iterPerLoopAddr = 0x1234}});
    attrs.push_back({DUMP_ATTR_LOOP_COND_ADDR, {.loopCondAddr = 0x1234}});
    attrs.push_back({DUMP_ATTR_DUMP_STEP, {.dumpStep = const_cast<char*>(dumpStep.c_str())}});
    attrs.push_back({DUMP_ATTR_DUMP_STEPSIZE, {.dumpStepSize = dumpStep.size()}});
    attrs.push_back({DUMP_ATTR_STREAM_MODEL, {.streamModel = 0U}});
    dumpCfg.attrs = attrs.data();
    dumpCfg.numAttrs = attrs.size();
    OperatorDumper opDumper = OperatorDumperBuilder().AddInputTensor().AddOutputTensor(AddressType::RAW).Build();
    EXPECT_EQ(opDumper.LaunchWithCfg(dumpCfg), ADUMP_SUCCESS);
    opDumper.FreeDevMemCache();
}

TEST_F(OperatorDumperUtest, Test_DumpTensorWithCfg_DynamicGraph_Tensor_Success)
{
    DumpCfg dumpCfg;
    std::vector<DumpAttr> attrs;
    attrs.push_back({DUMP_ATTR_STREAM_MODEL, {.streamModel = 1U}});
    dumpCfg.attrs = attrs.data();
    dumpCfg.numAttrs = attrs.size();
    OperatorDumper opDumper = OperatorDumperBuilder().AddInputTensor().AddOutputTensor(AddressType::RAW).Build();
    EXPECT_EQ(opDumper.LaunchWithCfg(dumpCfg), ADUMP_SUCCESS);
    opDumper.FreeDevMemCache();
}

TEST_F(OperatorDumperUtest, Test_DumpTensorWithCfg_StaticGraph_Stats_Success)
{
    DumpCfg dumpCfg;
    std::vector<DumpAttr> attrs;
    dumpCfg.attrs = attrs.data();
    dumpCfg.numAttrs = attrs.size();
    OperatorDumper opDumper = OperatorDumperBuilder().DumpData("stats").AddOutputTensor(AddressType::RAW).Build();
    EXPECT_EQ(opDumper.LaunchWithCfg(dumpCfg), ADUMP_SUCCESS);
    opDumper.FreeDevMemCache();
}

TEST_F(OperatorDumperUtest, Test_DumpTensorWithCfg_StaticGraph_OverFlow_Success)
{
    DumpCfg dumpCfg;
    std::vector<DumpAttr> attrs;
    dumpCfg.attrs = attrs.data();
    dumpCfg.numAttrs = attrs.size();
    OperatorDumper opDumper =
        OperatorDumperBuilder().SetDumpType(DumpType::OP_OVERFLOW).AddOutputTensor(AddressType::RAW).Build();
    EXPECT_EQ(opDumper.LaunchWithCfg(dumpCfg), ADUMP_SUCCESS);
    opDumper.FreeDevMemCache();
}

TEST_F(OperatorDumperUtest, Test_DumpTensorWithCfg_InitDumpSwitch_rtMalloc_Error)
{
    MOCKER(rtMalloc).stubs().will(returnValue(-1));
    DumpCfg dumpCfg;
    std::vector<DumpAttr> attrs;
    dumpCfg.attrs = attrs.data();
    dumpCfg.numAttrs = attrs.size();
    OperatorDumper opDumper = OperatorDumperBuilder().AddOutputTensor(AddressType::RAW).Build();
    EXPECT_EQ(opDumper.LaunchWithCfg(dumpCfg), ADUMP_FAILED);
}

TEST_F(OperatorDumperUtest, Test_DumpTensorWithCfg_InitDumpSwitch_rtMemcpy_Error)
{
    MOCKER(rtMemcpy).stubs().will(returnValue(-1));
    DumpCfg dumpCfg;
    std::vector<DumpAttr> attrs;
    dumpCfg.attrs = attrs.data();
    dumpCfg.numAttrs = attrs.size();
    OperatorDumper opDumper = OperatorDumperBuilder().AddOutputTensor(AddressType::RAW).Build();
    EXPECT_EQ(opDumper.LaunchWithCfg(dumpCfg), ADUMP_FAILED);
}

TEST_F(OperatorDumperUtest, Test_DumpTensor_NormalStream_Sync)
{
    // 普通单算子流：保持原有同步行为（传非空stream句柄，避免deferred判定被跳过）
    OperatorDumper opDumper =
        OperatorDumperBuilder().AddInputTensor().AddOutputTensor().Stream(reinterpret_cast<rtStream_t>(0x1)).Build();
    MOCKER(rtStreamSynchronize).expects(once()).will(returnValue(RT_ERROR_NONE));
    EXPECT_EQ(opDumper.Launch(), ADUMP_SUCCESS);
}

TEST_F(OperatorDumperUtest, Test_DumpTensor_PersistentStream_DeferSync)
{
    // 下沉流（PERSISTENT flag，含GE下沉流与aclGraph capture流，后者创建时也带此flag）：
    // 不执行流同步，proto device内存延迟释放
    SetStubStreamState(RT_STREAM_CAPTURE_STATUS_NONE, RT_STREAM_PERSISTENT);
    OperatorDumper opDumper =
        OperatorDumperBuilder().AddInputTensor().AddOutputTensor().Stream(reinterpret_cast<rtStream_t>(0x1)).Build();
    MOCKER(rtStreamSynchronize).expects(never());
    EXPECT_EQ(opDumper.Launch(), ADUMP_SUCCESS);
    OperatorDumper::FreeDevMemCache();
}

TEST_F(OperatorDumperUtest, Test_DumpTensor_GetFlagsError_KeepSync)
{
    // rtStreamGetFlags查询失败：保守回退，保持原有同步行为
    MOCKER(rtStreamGetFlags).stubs().will(returnValue(-1));
    OperatorDumper opDumper =
        OperatorDumperBuilder().AddInputTensor().AddOutputTensor().Stream(reinterpret_cast<rtStream_t>(0x1)).Build();
    MOCKER(rtStreamSynchronize).expects(once()).will(returnValue(RT_ERROR_NONE));
    EXPECT_EQ(opDumper.Launch(), ADUMP_SUCCESS);
}

TEST_F(OperatorDumperUtest, Test_DumpTensorWithCfg_DynamicGraph_OnPersistentStream_DeferSync)
{
    // 动态图（STREAM_MODEL=1要求同步）叠加下沉流：下沉流守卫优先生效，不执行流同步
    SetStubStreamState(RT_STREAM_CAPTURE_STATUS_NONE, RT_STREAM_PERSISTENT);
    DumpCfg dumpCfg;
    std::vector<DumpAttr> attrs;
    attrs.push_back({DUMP_ATTR_STREAM_MODEL, {.streamModel = 1U}});
    dumpCfg.attrs = attrs.data();
    dumpCfg.numAttrs = attrs.size();
    OperatorDumper opDumper = OperatorDumperBuilder()
                                  .AddInputTensor()
                                  .AddOutputTensor(AddressType::RAW)
                                  .Stream(reinterpret_cast<rtStream_t>(0x1))
                                  .Build();
    MOCKER(rtStreamSynchronize).expects(never());
    EXPECT_EQ(opDumper.LaunchWithCfg(dumpCfg), ADUMP_SUCCESS);
    opDumper.FreeDevMemCache();
}
