/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <iostream>
#include <fstream>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "osal/osal.h"
#include "osal/osal_mem.h"
#include "toolchain/prof_api.h"
#include "errno/error_code.h"
#include "report/hash_dic.h"
#include "logger/logger.h"
#include "osal/osal_thread.h"
#include "transport/transport.h"
#include "transport/uploader.h"
#include "utils/utils.h"

class HashDicUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(HashDicUtest, MsprofGetHashId)
{
    size_t dataSize = 0;
    char hashData[] = "Node_hash_test";
    // dataSize invalid
    uint64_t hashId = MsprofGetHashId(hashData, dataSize);
    EXPECT_EQ(hashId, std::numeric_limits<uint64_t>::max());
    dataSize = 14;
    // hashData invalid, NULL
    hashId = MsprofGetHashId(nullptr, dataSize);
    EXPECT_EQ(hashId, std::numeric_limits<uint64_t>::max());

    // hashData not init
    hashId = MsprofGetHashId(hashData, dataSize);
    EXPECT_EQ(hashId, std::numeric_limits<uint64_t>::max());
    
}

TEST_F(HashDicUtest, HashDataInit)
{
    // init hashData
    MOCKER(OsalCalloc)
        .stubs()
        .will(returnValue((void*)nullptr));
    int32_t ret = HashDataInit();
    EXPECT_EQ(ret, PROFILING_FAILED);

    GlobalMockObject::verify();
    ret = HashDataInit();
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = HashDataInit(); // Repeated initialization
    EXPECT_EQ(ret, PROFILING_SUCCESS);

    HashDataStop();
    HashDataUninit();
}

int32_t UploaderUploadDataStub(ProfFileChunk *chunk)
{
    OsalFree(chunk->chunk);
    OsalFree(chunk);
    return PROFILING_SUCCESS;
}

TEST_F(HashDicUtest, HashDataInitAddData)
{
    MOCKER(UploaderUploadData).stubs().will(invoke(UploaderUploadDataStub));
    // init hashData
    int32_t ret = HashDataInit();
    EXPECT_EQ(ret, PROFILING_SUCCESS);

    size_t dataSize = 15;
    char hashData[] = "Variable/Assign";
    uint64_t hashId = MsprofGetHashId(hashData, dataSize);
    EXPECT_EQ(hashId, 12780089546537679858);
    dataSize = 54;
    char hashData2[] = "ge_default_20240308172953_sub_1_know_PartitionedCall_1";
    hashId = MsprofGetHashId(hashData2, dataSize);
    EXPECT_EQ(hashId, 15991947681450900104);
    dataSize = 4;
    char hashData3[] = "Data";
    hashId = MsprofGetHashId(hashData3, dataSize);
    EXPECT_EQ(hashId, 7488232685453138);

    HashDataStop();
    HashDataUninit();
}