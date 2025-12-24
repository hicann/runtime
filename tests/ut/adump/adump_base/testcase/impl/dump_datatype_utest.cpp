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
#include <vector>

using namespace Adx;

class GetIrDataTypeUtest: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(GetIrDataTypeUtest, Test_GetIrDataType)
{
    const std::map<GeDataType, ProtoDataType> dtMapping = {
        { GeDataType::DT_COMPLEX32, ProtoDataType::DT_COMPLEX32 },
        { GeDataType::DT_HIFLOAT8, ProtoDataType::DT_HIFLOAT8 },
        { GeDataType::DT_FLOAT8_E5M2, ProtoDataType::DT_FLOAT8_E5M2 },
        { GeDataType::DT_FLOAT8_E4M3FN, ProtoDataType::DT_FLOAT8_E4M3FN },
        { GeDataType::DT_FLOAT8_E8M0, ProtoDataType::DT_FLOAT8_E8M0 },
        { GeDataType::DT_FLOAT6_E3M2, ProtoDataType::DT_FLOAT6_E3M2 },
        { GeDataType::DT_FLOAT6_E2M3, ProtoDataType::DT_FLOAT6_E2M3 },
        { GeDataType::DT_FLOAT4_E2M1, ProtoDataType::DT_FLOAT4_E2M1 },
        { GeDataType::DT_FLOAT4_E1M2, ProtoDataType::DT_FLOAT4_E1M2 }
    };
    for (const auto& pair: dtMapping) {
        EXPECT_EQ(DumpDataType::GetIrDataType(pair.first),  static_cast<int32_t>(pair.second));
    }
}
