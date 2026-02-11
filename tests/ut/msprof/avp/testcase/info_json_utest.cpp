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
#include "mmpa_api.h"
#include "osal/osal.h"
#include "osal/osal_mem.h"
#include "errno/error_code.h"
#include "json/info_json.h"
#include "domain/transport/uploader.h"
#include "platform.h"

class InfoJsonNanoUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

static int32_t UploaderUploadDataStub2(ProfFileChunk *chunk)
{
    OSAL_MEM_FREE(chunk->chunk);
    OSAL_MEM_FREE(chunk);
    return PROFILING_SUCCESS;
}

static void* MallocStub3(int size)
{
    return malloc(size);
}
int g_infoMallocSuccessCnt = 0;
static void* MallocTest3(int size)
{
    void* ret = nullptr;
    if (g_infoMallocSuccessCnt != 0) {
        ret = MallocStub3(size);
    } 
    g_infoMallocSuccessCnt--;
    return ret;
}

TEST_F(InfoJsonNanoUtest, CreateInfoJsonBase)
{
    EXPECT_EQ(CreateInfoJson(0), PROFILING_FAILED);
    MOCKER(UploaderUploadData)
        .stubs()
        .will(invoke(UploaderUploadDataStub2));
    EXPECT_EQ(CreateInfoJson(0), PROFILING_SUCCESS);
    MOCKER(OsalMalloc)
        .stubs()
        .will(invoke(MallocTest3));
    MOCKER(PlatformGetHostFreq)
        .stubs()
        .will(returnValue(10));
    int successCnt = 0;
    printf("2 test==========================================\n");
    // Failed to calloc info attribute
    g_infoMallocSuccessCnt = successCnt++;
    EXPECT_EQ(CreateInfoJson(0), PROFILING_FAILED);
    printf("3 test==========================================\n");
    // Faild to strcat_s for aicFreq
    g_infoMallocSuccessCnt = successCnt++;
    EXPECT_EQ(CreateInfoJson(0), PROFILING_SUCCESS);
    printf("4 test==========================================\n");
    // Faild to strcat_s for aivFreq
    g_infoMallocSuccessCnt = successCnt++;
    EXPECT_EQ(CreateInfoJson(0), PROFILING_SUCCESS);
    printf("5 test==========================================\n");
    // Faild to strcat_s for hwtsFreq
    g_infoMallocSuccessCnt = successCnt++;
    EXPECT_EQ(CreateInfoJson(0), PROFILING_SUCCESS);
    printf("6 test==========================================\n");
    // Failed to strcat_s for pid info
    g_infoMallocSuccessCnt = successCnt++;
    EXPECT_EQ(CreateInfoJson(0), PROFILING_SUCCESS);
    printf("7 test==========================================\n");
    // Failed to strcat_s for chip id
    g_infoMallocSuccessCnt = successCnt++;
    EXPECT_EQ(CreateInfoJson(0), PROFILING_SUCCESS);
    printf("8 test==========================================\n");
    // Failed to strcat_s for devices
    g_infoMallocSuccessCnt = successCnt++;
    EXPECT_EQ(CreateInfoJson(0), PROFILING_SUCCESS);
    printf("9 test==========================================\n");
    // Failed to get cpu info
    g_infoMallocSuccessCnt = successCnt++;
    EXPECT_EQ(CreateInfoJson(0), PROFILING_FAILED);
    printf("10 test==========================================\n");
    // Failed to malloc for infoCpus
    g_infoMallocSuccessCnt = successCnt++;
    EXPECT_EQ(CreateInfoJson(0), PROFILING_FAILED);
    printf("11 test==========================================\n");
    // Failed to strcat_s for infoCpus frequency
    g_infoMallocSuccessCnt = successCnt++;
    EXPECT_EQ(CreateInfoJson(0), PROFILING_SUCCESS);
    printf("12 test==========================================\n");
    // Failed to strcat_s for infoCpus logicalCpuCount
    g_infoMallocSuccessCnt = successCnt++;
    EXPECT_EQ(CreateInfoJson(0), PROFILING_SUCCESS);
    printf("13 test==========================================\n");
    // success
    g_infoMallocSuccessCnt = successCnt + 64;
    EXPECT_EQ(CreateInfoJson(0), PROFILING_SUCCESS);
}

TEST_F(InfoJsonNanoUtest, CreateCollectionTimeInfoTest)
{
    EXPECT_EQ(CreateCollectionTimeInfo(0, true), PROFILING_FAILED);
    MOCKER(UploaderUploadData)
        .stubs()
        .will(invoke(UploaderUploadDataStub2));
    EXPECT_EQ(CreateCollectionTimeInfo(0, true), PROFILING_SUCCESS);
    MOCKER(OsalMalloc)
        .stubs()
        .will(invoke(MallocTest3));
    int successCnt = 0;
    printf("2 test==========================================\n");
    // Failed to malloc hostTimeStr
    g_infoMallocSuccessCnt = successCnt++;
    EXPECT_EQ(CreateCollectionTimeInfo(0, true), PROFILING_FAILED);
    printf("3 test==========================================\n");
    // Failed to malloc timeStr
    g_infoMallocSuccessCnt = successCnt++;
    EXPECT_EQ(CreateCollectionTimeInfo(0, true), PROFILING_FAILED);
    printf("4 test==========================================\n");
    // Failed to malloc dateStr
    g_infoMallocSuccessCnt = successCnt++;
    EXPECT_EQ(CreateCollectionTimeInfo(0, true), PROFILING_FAILED);
    printf("5 test==========================================\n");
    // Failed to malloc microTimeStr.
    g_infoMallocSuccessCnt = successCnt++;
    EXPECT_EQ(CreateCollectionTimeInfo(0, true), PROFILING_FAILED);
    printf("6 test==========================================\n");
    // Failed to malloc JsonObj.
    g_infoMallocSuccessCnt = successCnt++;
    EXPECT_EQ(CreateCollectionTimeInfo(0, true), PROFILING_FAILED);
    printf("7 test==========================================\n");
    // Failed to generate json string
    g_infoMallocSuccessCnt = successCnt += 11;
    EXPECT_EQ(CreateCollectionTimeInfo(0, true), PROFILING_FAILED);
    printf("8 test==========================================\n");
    // Failed to malloc chunk
    g_infoMallocSuccessCnt = successCnt += 2;
    EXPECT_EQ(CreateCollectionTimeInfo(0, true), PROFILING_FAILED);
    printf("9 test==========================================\n");
    // success.
    g_infoMallocSuccessCnt = ++successCnt;
    EXPECT_EQ(CreateCollectionTimeInfo(0, true), PROFILING_SUCCESS);
}