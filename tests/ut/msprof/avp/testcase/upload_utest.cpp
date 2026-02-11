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
#include "osal/osal_thread.h"
#include "osal/osal_linux.h"
#include "thread/thread_pool.h"
#include "errno/error_code.h"
#include "hal/hal_prof.h"
#include "hal/hal_dsmi.h"
#include "platform.h"
#include "platform_define.h"
#include "cstl/cstl_public.h"
#include "cstl/cstl_list.h"
#include "transport/uploader.h"
#include "transport/transport.h"
#include "transport/file_transport.h"
#include "transport/flash_transport.h"
#include "file_interface.h"

class UploadUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

ProfFileChunk * CreateChunk(uint8_t deviceId, uint32_t chunkSize, FileChunkType type)
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

TEST_F(UploadUtest, UploaderInitializeBasic)
{
    int32_t ret = UploaderInitialize();
    EXPECT_EQ(ret, PROFILING_SUCCESS);

    ret = UploaderInitialize(); // repeat
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = UploaderFinalize();
    EXPECT_EQ(ret, PROFILING_SUCCESS);

    MOCKER(HalGetDeviceNumber)
        .stubs()
        .will(returnValue(uint32_t(0)));
    ret = UploaderInitialize();
    EXPECT_EQ(ret, PROFILING_FAILED);
}

int32_t FileSendBufferStub(ProfFileChunk* chunk, const char* dir)
{
    (void)dir;
    OSAL_MEM_FREE(chunk->chunk);
    OSAL_MEM_FREE(chunk);
    return PROFILING_SUCCESS;
}

int32_t FileInitTransportStub(uint32_t deviceId, const char *flushDir, const char *storageLimit)
{
    (void)deviceId;
    (void)flushDir;
    (void)storageLimit;
    return PROFILING_SUCCESS;
}

TEST_F(UploadUtest, UploaderBasic)
{
    MOCKER(ProfSendBuffer)
        .stubs()
        .will(invoke(FileSendBufferStub));
    MOCKER(ProfInitTransport)
        .stubs()
        .will(invoke(FileInitTransportStub));
    int32_t ret = ProfThreadPoolInit(10, 0, 5);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ProfileParam param;
    (void)memset_s(param.config.resultDir, sizeof(param.config.resultDir), 0, sizeof(param.config.resultDir));
    (void)strcpy_s(param.config.resultDir, sizeof(param.config.resultDir), "./test");
    MOCKER(CreateDirectory)
        .stubs()
        .will(returnValue(true));
    MOCKER(IsDirAccessible)
        .stubs()
        .will(returnValue(true));

    ret = UploaderInitialize();
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = CreateDataUploader(&param, FILE_TRANSPORT, 0, UPLOADER_CAPACITY);
    EXPECT_EQ(ret, PROFILING_SUCCESS);

    ret = UploaderUploadData(CreateChunk(0, 1, PROF_DEVICE_DATA));
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = UploaderUploadData(CreateChunk(0, 0, PROF_DEVICE_DATA));
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = UploaderUploadData(CreateChunk(1, 1, PROF_DEVICE_DATA));
    EXPECT_EQ(ret, PROFILING_FAILED);

    UploaderFlush(0);
    UploaderFlush(1);
    DestroyDataUploader(0);

    UploaderFlush(0);
    ret = UploaderFinalize();
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ProfThreadPoolFinalize();
}

TEST_F(UploadUtest, UploaderInitializeFail)
{
    MOCKER(CstlListInit)
        .stubs()
        .will(returnValue(CSTL_ERR))
        .then(returnValue(CSTL_OK));
    int32_t ret = UploaderInitialize();
    EXPECT_EQ(ret, PROFILING_FAILED);

    MOCKER(OsalCalloc)
        .stubs()
        .will(returnValue((void *)NULL));
    ret = UploaderInitialize();
    EXPECT_EQ(ret, PROFILING_FAILED);
}

TEST_F(UploadUtest, UploaderFinalizeBasic)
{
    int32_t ret = UploaderFinalize();
    EXPECT_EQ(ret, PROFILING_SUCCESS);

    ret = UploaderInitialize();
    EXPECT_EQ(ret, PROFILING_SUCCESS);

    ret = UploaderFinalize();
    EXPECT_EQ(ret, PROFILING_SUCCESS);
}

void* MallocStub2(int size)
{
    return malloc(size);
}
int g_osalmallocSuccessCnt = 0;
void* MallocTest2(int size)
{
    void* ret = nullptr;
    if (g_osalmallocSuccessCnt != 0) {
        ret = MallocStub2(size);
    } 
    g_osalmallocSuccessCnt--;
    return ret;
}

TEST_F(UploadUtest, CreateDataUploaderBasic)
{
    MOCKER(OsalMkdir)
        .stubs()
        .will(returnValue(OSAL_EN_OK))
        .then(returnValue(OSAL_EN_ERR));
    ProfileParam param;
    (void)memset_s(param.config.resultDir, sizeof(param.config.resultDir), 0, sizeof(param.config.resultDir));
    (void)strcpy_s(param.config.resultDir, sizeof(param.config.resultDir), "./test");
    int32_t ret = ProfThreadPoolInit(10, 0, 5);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = UploaderInitialize();
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    // CreateUploaderTransport
    ret = CreateDataUploader(&param, static_cast<TransportType>(3), 64, UPLOADER_CAPACITY);
    EXPECT_EQ(ret, PROFILING_FAILED);
    // Host uploader with flash transport
    ret = CreateDataUploader(&param, FLSH_TRANSPORT, 64, UPLOADER_CAPACITY);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    // repeat
    ret = CreateDataUploader(&param, FLSH_TRANSPORT, 64, UPLOADER_CAPACITY);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    DestroyDataUploader(64);
    // CreateDirectory failed
    ret = CreateDataUploader(&param, FILE_TRANSPORT, 0, UPLOADER_CAPACITY);
    EXPECT_EQ(ret, PROFILING_FAILED);
    // StartDataUploaderThread
    MOCKER(CstlListPushBack)
        .stubs()
        .will(returnValue(CSTL_ERR))
        .then(returnValue(CSTL_OK));
    ret = CreateDataUploader(&param, FILE_TRANSPORT, 0, UPLOADER_CAPACITY);
    EXPECT_EQ(ret, PROFILING_FAILED);

    MOCKER(ProfThreadPoolExpand)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    ret = CreateDataUploader(&param, FILE_TRANSPORT, 0, UPLOADER_CAPACITY);
    EXPECT_EQ(ret, PROFILING_FAILED);

    MOCKER(ProfThreadPoolDispatch)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    ret = CreateDataUploader(&param, FILE_TRANSPORT, 0, UPLOADER_CAPACITY);
    EXPECT_EQ(ret, PROFILING_FAILED);
    // InitDataUploaderBaisc
    int32_t successCnt = 0;
    MOCKER(OsalMalloc)
        .stubs()
        .will(invoke(MallocTest2));
    g_osalmallocSuccessCnt = successCnt++;
    ret = CreateDataUploader(&param, FILE_TRANSPORT, 0, UPLOADER_CAPACITY);
    EXPECT_EQ(ret, PROFILING_FAILED);
    g_osalmallocSuccessCnt = successCnt++;
    ret = CreateDataUploader(&param, FILE_TRANSPORT, 0, UPLOADER_CAPACITY);
    EXPECT_EQ(ret, PROFILING_FAILED);
    g_osalmallocSuccessCnt = successCnt++;
    ret = CreateDataUploader(&param, FILE_TRANSPORT, 0, UPLOADER_CAPACITY);
    EXPECT_EQ(ret, PROFILING_FAILED);

    ret = UploaderFinalize();
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ProfThreadPoolFinalize();
}

TEST_F(UploadUtest, CreateProfMainDirBasic)
{
    uint32_t index = 0;
    char flushDir[DEFAULT_OUTPUT_MAX_LEGTH];
    (void)memset_s(flushDir, sizeof(flushDir), 0, sizeof(flushDir));
    (void)sprintf_s(flushDir, sizeof(flushDir), "./test");
    int32_t ret = CreateProfMainDir(&index, flushDir);
    EXPECT_EQ(ret, PROFILING_SUCCESS);

    (void)memset_s(flushDir, sizeof(flushDir), 0, sizeof(flushDir));
    (void)sprintf_s(flushDir, sizeof(flushDir), "./test");
    ret = CreateProfMainDir(&index, flushDir);
    EXPECT_EQ(ret, PROFILING_SUCCESS);

    MOCKER(OsalGetLocalTime)
        .stubs()
        .will(returnValue(OSAL_EN_ERROR));
    (void)memset_s(flushDir, sizeof(flushDir), 0, sizeof(flushDir));
    (void)sprintf_s(flushDir, sizeof(flushDir), "./test");
    ret = CreateProfMainDir(&index, flushDir);
    EXPECT_EQ(ret, PROFILING_FAILED);
}

TEST_F(UploadUtest, OsalMutexInitFail)
{
    MOCKER(OsalCondInit)
        .stubs()
        .will(returnValue(-1));
    ProfileParam param;
    (void)memset_s(param.config.resultDir, sizeof(param.config.resultDir), 0, sizeof(param.config.resultDir));
    (void)strcpy_s(param.config.resultDir, sizeof(param.config.resultDir), "./test");

    int32_t ret = ProfThreadPoolInit(10, 0, 5);
    EXPECT_EQ(ret, PROFILING_FAILED);

    ret = UploaderInitialize();
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = CreateDataUploader(&param, FILE_TRANSPORT, 0, UPLOADER_CAPACITY);
    EXPECT_EQ(ret, PROFILING_FAILED);
    ret = UploaderFinalize();
    EXPECT_EQ(ret, PROFILING_SUCCESS);
}

TEST_F(UploadUtest, FlashSendBufferTest)
{
    const char* dir = "./";
    ProfFileChunk *chunk = CreateChunk(0, 1, PROF_DEVICE_DATA);
    EXPECT_EQ(FlashSendBuffer(chunk, dir), PROFILING_SUCCESS);

    ProfFileChunk *chunk2 = CreateChunk(64, 1, PROF_HOST_DATA);
    EXPECT_EQ(FlashSendBuffer(chunk2, dir), PROFILING_SUCCESS);

    ProfFileChunk *chunk3 = CreateChunk(64, 1, PROF_CTRL_DATA);
    EXPECT_EQ(FlashSendBuffer(chunk3, dir), PROFILING_SUCCESS);
}