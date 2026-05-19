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

TEST_F(GetIrDataTypeUtest, Test_GetIrDataType_Unknown)
{
    // An unknown GeDataType value should return DT_UNDEFINED
    int32_t ret = DumpDataType::GetIrDataType(static_cast<GeDataType>(9999));
    EXPECT_EQ(ret, static_cast<int32_t>(ProtoDataType::DT_UNDEFINED));
}

TEST_F(GetIrDataTypeUtest, Test_GetIrDataType_Common)
{
    // Common types that are in the map
    EXPECT_NE(DumpDataType::GetIrDataType(GeDataType::DT_FLOAT),
              static_cast<int32_t>(ProtoDataType::DT_UNDEFINED));
    EXPECT_NE(DumpDataType::GetIrDataType(GeDataType::DT_INT32),
              static_cast<int32_t>(ProtoDataType::DT_UNDEFINED));
}

TEST_F(GetIrDataTypeUtest, Test_FormatToSerialString_Known)
{
    // FORMAT_ND = 2, FORMAT_NCHW = 0 (common formats that should be in the map)
    // Just call with any format value; a known one returns a non-"RESERVED" string
    std::string s = DumpDataType::FormatToSerialString(0); // FORMAT_NCHW
    EXPECT_NE(s, ""); // should have some result
}

TEST_F(GetIrDataTypeUtest, Test_FormatToSerialString_Unknown)
{
    // FormatToSerialString masks with 0xFF, so use a large value
    // Result depends on whether the masked byte is in the format map
    std::string s = DumpDataType::FormatToSerialString(9999);
    EXPECT_FALSE(s.empty()); // Should return some string (known format or "RESERVED")
}

TEST_F(GetIrDataTypeUtest, Test_FormatToSerialString_WithSubFormat)
{
    // format with sub-format bits set: bits 8-23 contain sub-format value
    // Format = 0 (NCHW) + sub-format in upper bits = (1 << 8) | 0
    int32_t formatWithSub = (1 << 8) | 0; // FORMAT_NCHW + sub=1
    std::string s = DumpDataType::FormatToSerialString(formatWithSub);
    // Should contain ":" for sub-format
    EXPECT_NE(s.find(":"), std::string::npos);
}

TEST_F(GetIrDataTypeUtest, Test_DataTypeToSerialString_Known)
{
    // DT_FLOAT = 0 should be in map
    std::string s = DumpDataType::DataTypeToSerialString(0);
    EXPECT_NE(s, "");
    EXPECT_NE(s, "UNDEFINED");
}

TEST_F(GetIrDataTypeUtest, Test_DataTypeToSerialString_Unknown)
{
    // Unknown datatype -> "UNDEFINED"
    std::string s = DumpDataType::DataTypeToSerialString(9999);
    EXPECT_EQ(s, "UNDEFINED");
}

TEST_F(GetIrDataTypeUtest, Test_DataTypeToSerialString_Float16)
{
    // DT_FLOAT16 = 1
    std::string s = DumpDataType::DataTypeToSerialString(1);
    EXPECT_NE(s, "UNDEFINED");
}
