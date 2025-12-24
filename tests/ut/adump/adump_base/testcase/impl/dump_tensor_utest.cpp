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
#include "dump_tensor.h"
#include "dump_datatype.h"
#include "dump_manager.h"

using namespace Adx;

constexpr size_t TENSOR_SIZE = 5;

class DumpTensorUtest: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }

private:
};

TEST_F(DumpTensorUtest, Test_DumpTensor)
{
    TensorInfoV2 tensor = {};
    tensor.addrType = AddressType::TRADITIONAL;
    tensor.type = TensorType::INPUT;
    tensor.dataType = static_cast<int32_t>(GeDataType::DT_INT32);
    tensor.argsOffSet = 0;
    tensor.format = 0; // FORMAT_NC1HWC0
    tensor.shape = {4, 2, 7, 7, 16};
    tensor.tensorAddr = nullptr;
    tensor.tensorSize = TENSOR_SIZE;
    tensor.originShape = {4, 32, 7, 7};
    tensor.placement = TensorPlacement::kOnDeviceHbm;

    DumpTensor dumpTensor(tensor);
    EXPECT_EQ(dumpTensor.GetDataType(), static_cast<int32_t>(GeDataType::DT_INT32));
    EXPECT_EQ(dumpTensor.GetFormat(), 0);
    EXPECT_EQ(dumpTensor.GetSize(), TENSOR_SIZE);
    EXPECT_EQ(dumpTensor.GetAddress(), nullptr);
    EXPECT_EQ(dumpTensor.GetAddressType(), AddressType::TRADITIONAL);
    EXPECT_EQ(dumpTensor.GetArgsOffSet(), 0);
}