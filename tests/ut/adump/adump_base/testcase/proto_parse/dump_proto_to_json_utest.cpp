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
#include "securec.h"
#include "dump_proto_to_json.h"
#include "proto/adump/dump_data.pb.h"

class DUMP_PROTO_TO_JSON_UTEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(DUMP_PROTO_TO_JSON_UTEST, ParseDumpProtoToJson)
{
    toolkit::dumpdata::DumpData dumpData;
    dumpData.set_version("2.0");
    std::string opName("test_op");
    dumpData.set_op_name(opName);
    std::string protoHeader;
    dumpData.SerializeToString(&protoHeader);
    uint64_t protoSize = dumpData.ByteSizeLong();
    size_t dataLength = protoSize + sizeof(uint64_t);
    std::string data(dataLength, 0);
    char *ptr = data.data();
    uint64_t *sizePtr = (uint64_t *)ptr;
    *sizePtr = protoSize;
    memcpy_s(ptr + sizeof(uint64_t), protoSize, protoHeader.data(), protoSize);

    EXPECT_EQ(0, ParseDumpProtoToJson(data.data(), dataLength, "/tmp/adump_proto_utest.json"));
}

TEST_F(DUMP_PROTO_TO_JSON_UTEST, ParseDumpProtoToJson_error)
{
    toolkit::dumpdata::DumpData dumpData;
    dumpData.set_version("2.0");
    std::string opName("test_op");
    dumpData.set_op_name(opName);
    std::string protoHeader;
    dumpData.SerializeToString(&protoHeader);
    uint64_t protoSize = dumpData.ByteSizeLong();
    size_t dataLength = protoSize + sizeof(uint64_t);
    std::string data(dataLength, 0);
    char *ptr = data.data();
    uint64_t *sizePtr = (uint64_t *)ptr;
    *sizePtr = protoSize;
    memcpy_s(ptr + sizeof(uint64_t), protoSize, protoHeader.data(), protoSize);

    EXPECT_EQ(-1, ParseDumpProtoToJson(data.data(), dataLength, nullptr));
    EXPECT_EQ(-1, ParseDumpProtoToJson(data.data(), 0, "/tmp/adump_proto_utest.json"));
    EXPECT_EQ(-1, ParseDumpProtoToJson(data.data(), dataLength - 1, "/tmp/adump_proto_utest.json"));
    EXPECT_EQ(-1, ParseDumpProtoToJson(data.data(), dataLength, "/tmp/test/adump_proto_utest.json"));
    char *testStr = "/tmp/test";
    size_t strLen = strlen(testStr) + 1;
    char *strPtr = (char *)malloc(strLen);
    strcpy_s(strPtr, strLen, testStr);
    MOCKER(realpath).stubs().will(returnValue(strPtr));
    EXPECT_EQ(-1, ParseDumpProtoToJson(data.data(), dataLength, "/tmp/test/adump_proto_utest.json"));
    MOCKER_CPP(&toolkit::dumpdata::DumpData::ParseFromString).stubs().will(returnValue(false));
    EXPECT_EQ(-1, ParseDumpProtoToJson(data.data(), dataLength, "/tmp/adump_proto_utest.json"));
}