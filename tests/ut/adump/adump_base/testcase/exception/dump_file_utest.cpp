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
#include "case_workspace.h"
#include "dump_file_checker.h"
#include "adump_pub.h"
#include "dump_tensor.h"
#include "dump_memory.h"
#include "dump_datatype.h"
#include "dump_file.h"
#include "ascend_hal.h"
#include "adump_dsmi.h"
#include "hccl_mc2_define.h"
#include "dump_manager.h"

using namespace Adx;
static std::vector<std::string> logRecord;
constexpr int32_t TENSOR_FORMAT_NC1HWC0 = 3;

class DumpFileUtest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(DumpFileUtest, Test_DumpData)
{
    Tools::CaseWorkspace ws("Test_Dump_Success");
    std::string dumpFilePath = ws.Root() + "/dump_file.bin";

    std::vector<DumpTensor> inputTensors;
    std::vector<DumpTensor> outputTensors;
    std::vector<DumpWorkspace> dumpWorkspaces;

    TensorInfoV2 tensorV2 = {};
    tensorV2.addrType = AddressType::TRADITIONAL;
    tensorV2.type = TensorType::INPUT;
    tensorV2.dataType = static_cast<int32_t>(GeDataType::DT_INT32);
    tensorV2.argsOffSet = 0;
    tensorV2.format = TENSOR_FORMAT_NC1HWC0;
    tensorV2.shape = {2, 4};
    tensorV2.tensorAddr = nullptr;
    tensorV2.tensorSize = TENSOR_SIZE_5;
    tensorV2.originShape = {2, 4};
    tensorV2.placement = TensorPlacement::kOnDeviceHbm;

    inputTensors.emplace_back(tensorV2);
    outputTensors.emplace_back(tensorV2);
    dumpWorkspaces.emplace_back(tensorV2.tensorAddr, tensorV2.tensorSize, 0U);

    std::vector<InputBuffer> inputBuffer;
    inputBuffer.emplace_back(nullptr, 1, 1);
    std::vector<TensorBuffer> tensorBuffer;
    TensorBuffer tensor(nullptr, 0, (DfxTensorType)0, (DfxPointerType)0);
    tensor.size = 1;
    tensorBuffer.emplace_back(tensor);
    DumpFile dumpFile(0, dumpFilePath);
    dumpFile.SetInputBuffer(inputBuffer);
    dumpFile.SetTensorBuffer(tensorBuffer);
    dumpFile.SetHeader("test_op");
    dumpFile.SetInputTensors(inputTensors);
    dumpFile.SetOutputTensors(outputTensors);
    dumpFile.SetWorkspaces(dumpWorkspaces);

    int32_t ret = dumpFile.Dump(logRecord);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    DumpFileChecker checker;
    EXPECT_EQ(checker.Load(dumpFilePath), true);
    EXPECT_EQ(checker.CheckHead("test_op"), true);
    EXPECT_EQ(checker.CheckInputTensorNum(1), true);
    EXPECT_EQ(checker.CheckOutputTensorNum(1), true);
    EXPECT_EQ(checker.CheckWorkspaceNum(1), true);

    EXPECT_EQ(checker.CheckInputTensorShape(0, {2, 4}), true);
    EXPECT_EQ(checker.CheckInputTensorDatatype(0, toolkit::dump::OutputDataType::DT_INT32), true);
    EXPECT_EQ(checker.CheckInputTensorFormat(0, toolkit::dump::OutputFormat::FORMAT_ND), true);

    EXPECT_EQ(checker.CheckOutputTensorShape(0, {2, 4}), true);
    EXPECT_EQ(checker.CheckOutputTensorDatatype(0, toolkit::dump::OutputDataType::DT_INT32), true);
    EXPECT_EQ(checker.CheckOutputTensorFormat(0, toolkit::dump::OutputFormat::FORMAT_ND), true);
}
