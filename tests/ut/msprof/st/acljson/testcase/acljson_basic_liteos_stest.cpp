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
#include "errno/error_code.h"
#include "flash_transport.h"
#include "platform_define.h"
#include "osal_mem.h"
#include "file_if.h"
#include "profile_param.h"
#include "platform.h"
#include "prof_common.h"
#include "hal_dsmi.h"
#include "osal/osal_thread.h"

static const char C_RM_RF[] = "rm -rf ./acljsonLiteOsstest_workspace";
static const char C_MKDIR[] = "mkdir ./acljsonLiteOsstest_workspace";
static const char C_OUTPUT_DIR[] = "./acljsonLiteOsstest_workspace/output";

class BasicCStest: public testing::Test {
protected:
    virtual void SetUp()
    {
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

ProfFileChunk * CreateChunkLiteOs(uint8_t deviceId, uint32_t chunkSize, FileChunkType type)
{
    ProfFileChunk *chunk = (ProfFileChunk *)OsalMalloc(sizeof(ProfFileChunk));
    chunk->deviceId = deviceId;
    chunk->chunkSize = chunkSize;
    chunk->chunkType = type;
    chunk->isLastChunk = false;
    chunk->offset = -1;
    chunk->chunk = (uint8_t*)OsalMalloc(MAX_READER_BUFFER_SIZE);
    (void)memset_s(chunk->fileName, sizeof(chunk->fileName), 0, sizeof(chunk->fileName));
    (void)sprintf_s(chunk->fileName, sizeof(chunk->fileName), "%s", "nano_stars_profile.data");
    return chunk;
}

TEST_F(BasicCStest, FlashSendBufferTest)
{
    const char* dir = "./";
    ProfFileChunk *chunk = CreateChunkLiteOs(0, 1, PROF_DEVICE_DATA);
    EXPECT_EQ(FlashSendBuffer(chunk, dir), PROFILING_SUCCESS);

    ProfFileChunk *chunk2 = CreateChunkLiteOs(64, 1, PROF_HOST_DATA);
    EXPECT_EQ(FlashSendBuffer(chunk2, dir), PROFILING_SUCCESS);

    ProfFileChunk *chunk3 = CreateChunkLiteOs(64, 1, PROF_CTRL_DATA);
    EXPECT_EQ(FlashSendBuffer(chunk3, dir), PROFILING_SUCCESS);

    ProfFileChunk *chunk4 = CreateChunkLiteOs(0, 1024 * 10, PROF_DEVICE_DATA);
    EXPECT_EQ(FlashSendBuffer(chunk4, dir), PROFILING_SUCCESS);
}

TEST_F(BasicCStest, ProfileParamBase)
{
    GlobalMockObject::verify();
    MOCKER(HalGetChipVersion)
        .stubs()
        .will(returnValue(uint32_t(PlatformType::CHIP_NANO_V1)));
    MOCKER(HalGetHostFreq)
        .stubs()
        .will(returnValue((uint64_t)10000));
    MOCKER(HalGetDeviceFreq)
        .stubs()
        .will(returnValue((uint64_t)50000));
    uint32_t count = 0;
    int32_t ret = PlatformInitialize(&count);
    ProfileParam ut_profileParam = { 0 };
    uint32_t errorType = 100;
    const int32_t DEFSIZE = 4096;
    char data[DEFSIZE] = "{\"aic_metrics\":\"PipeUtilization\",\"output\":\"./output_dir\",\"switch\":\"on\",\"task_trace\":\"on\",\"storage_limit\":\"200MB\"}";
    MOCKER(IsSupportSwitch)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(GenProfileParam(MSPROF_CTRL_INIT_ACL_JSON, data, sizeof(data), &ut_profileParam), PROFILING_SUCCESS);
    PlatformFinalize(&count);
}

TEST_F(BasicCStest, ThreadCreateBase)
{
    GlobalMockObject::verify();
    OsalThread th;
    UserProcFunc fc;
    MOCKER(pthread_attr_init)
        .stubs()
        .will(returnValue(OSAL_EN_ERROR))
        .then(returnValue(OSAL_EN_OK));
    EXPECT_EQ(OSAL_EN_ERROR, OsalCreateThread(&th, fc));
 
    MOCKER(pthread_attr_setstacksize)
        .stubs()
        .will(returnValue(OSAL_EN_ERROR))
        .then(returnValue(OSAL_EN_OK));
    EXPECT_EQ(OSAL_EN_ERROR, OsalCreateThread(&th, fc));
 
    MOCKER(pthread_create)
        .stubs()
        .will(returnValue(OSAL_EN_OK));
    MOCKER(pthread_attr_destroy)
        .stubs()
        .will(returnValue(OSAL_EN_OK));
    EXPECT_EQ(OSAL_EN_OK, OsalCreateThread(&th, fc));
}
