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
#include "thread/thread_pool.h"
#include "errno/error_code.h"
#include "channel/channel_manager.h"
#include "channel/channel_reader.h"
#include "hal/hal_prof.h"
#include "hal/hal_dsmi.h"
#include "platform.h"
#include "platform_define.h"
#include "cstl/cstl_public.h"
#include "cstl/cstl_list.h"

class ThreadPoolUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

OsalVoidPtr taskFunction(OsalVoidPtr arg)
{
    int32_t num = *(int32_t*)arg;
    sleep(1);
    return NULL;
}

TEST_F(ThreadPoolUtest, ThreadPoolBase)
{
    int reti = ProfThreadPoolInit(1000, 0, 20);
    EXPECT_EQ(reti, PROFILING_SUCCESS);
    int32_t* num = (int32_t*)malloc(sizeof(int32_t) * 20);
    for (int32_t i = 0; i < 20; ++i) {

        if (i < 10) {
            int32_t rete = ProfThreadPoolExpand(1);
            EXPECT_EQ(rete, PROFILING_SUCCESS);
        }

        if (i%2 == 0) {
            ThreadTask task = {taskFunction, (OsalVoidPtr)&num[i]};
            int32_t ret = ProfThreadPoolDispatch(&task, 1);
            EXPECT_EQ(ret, PROFILING_SUCCESS);
        } else {
            ThreadTask task = {taskFunction, (OsalVoidPtr)&num[i]};
            int32_t ret = ProfThreadPoolDispatch(&task, 0);
            EXPECT_EQ(ret, PROFILING_SUCCESS);
        }
    }

    sleep(1);
    ProfThreadPoolFinalize();
    free(num);
}

TEST_F(ThreadPoolUtest, ThreadPoolForChannelManager)
{
    MOCKER(PlatformGetDevNum)
        .stubs()
        .will(returnValue(uint32_t(1)));
    int reti = ProfThreadPoolInit(1000, 10, 20);
    EXPECT_EQ(reti, PROFILING_SUCCESS);

    int ret = ChannelMgrInitialize(0);
    EXPECT_EQ(ret, PROFILING_SUCCESS);

    ret = ChannelMgrCreateReader(0, 0);
    EXPECT_EQ(ret, PROFILING_SUCCESS);

    sleep(2);

    ret = ChannelMgrDestroyReader(0, 0);
    EXPECT_EQ(ret, PROFILING_SUCCESS);

    ret = ChannelMgrFinalize();
    ProfThreadPoolFinalize();
}

TEST_F(ThreadPoolUtest, ThreadPoolInitFailed)
{
    GlobalMockObject::verify();
    MOCKER(memset_s)
        .stubs()
        .will(returnValue(-1));

    int ret = ProfThreadPoolInit(1000, 10, 20);
    EXPECT_EQ(ret, PROFILING_FAILED);

    ret = ProfThreadPoolInit(1000, 10, 20);
    EXPECT_EQ(ret, PROFILING_FAILED);
}

TEST_F(ThreadPoolUtest, ThreadPoolDispatchBlock)
{
    GlobalMockObject::verify();
    int ret = ProfThreadPoolDispatch(NULL, 0);
    EXPECT_EQ(ret, PROFILING_FAILED);

    ret = ProfThreadPoolInit(4, 4, 20);
    EXPECT_EQ(ret, PROFILING_SUCCESS);

    int32_t* num = (int32_t*)malloc(sizeof(int32_t) * 20);
    for (int32_t i = 0; i < 20; ++i) {
        if (i%2 == 0) {
            ThreadTask task = {taskFunction, (OsalVoidPtr)&num[i]};
            int32_t retf = ProfThreadPoolDispatch(&task, 1);
            EXPECT_EQ(retf, PROFILING_SUCCESS);
        } else {
            ThreadTask task = {taskFunction, (OsalVoidPtr)&num[i]};
            int32_t retf = ProfThreadPoolDispatch(&task, 0);
            EXPECT_EQ(retf, PROFILING_SUCCESS);
        }
    }

    ProfThreadPoolFinalize();
    free(num);
}

TEST_F(ThreadPoolUtest, ThreadPoolFinalizeMiddle)
{
    GlobalMockObject::verify();
    int32_t ret = ProfThreadPoolInit(10, 2, 10);
    EXPECT_EQ(ret, PROFILING_SUCCESS);

    int32_t* num = (int32_t*)malloc(sizeof(int32_t) * 20);
    for (int32_t i = 0; i < 10; ++i) {
        ThreadTask task = {taskFunction, (OsalVoidPtr)&num[i]};
        int32_t retf = ProfThreadPoolDispatch(&task, 1);
        EXPECT_EQ(retf, PROFILING_SUCCESS);
        if (i == 9) {
            ProfThreadPoolFinalize();
        }
    }

    ProfThreadPoolFinalize();
    free(num);
}

TEST_F(ThreadPoolUtest, ThreadPoolExpandFailed)
{
    int32_t ret = ProfThreadPoolExpand(1);
    EXPECT_EQ(ret, PROFILING_FAILED);
    ret = ProfThreadPoolExpand(0);
    EXPECT_EQ(ret, PROFILING_FAILED);

    GlobalMockObject::verify();
    ret = ProfThreadPoolInit(10, 2, 10);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    MOCKER(OsalCreateThread)
        .stubs()
        .will(returnValue(OSAL_EN_INVALID_PARAM))
        .then(returnValue(OSAL_EN_ERROR));
    ret = ProfThreadPoolExpand(1);
    EXPECT_EQ(ret, PROFILING_FAILED);
    ret = ProfThreadPoolExpand(1);
    EXPECT_EQ(ret, PROFILING_FAILED);
    ProfThreadPoolFinalize();
}

TEST_F(ThreadPoolUtest, ChannelManagerBasic)
{
    MOCKER(PlatformGetDevNum)
        .stubs()
        .will(returnValue(uint32_t(1)));
    int32_t ret = ProfThreadPoolInit(10, 0, 20);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = ChannelMgrInitialize(0);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = ChannelMgrInitialize(0);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = ChannelMgrFinalize();
    EXPECT_EQ(ret, PROFILING_SUCCESS);

    MOCKER(ProfThreadPoolExpand)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER(ProfThreadPoolDispatch)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    ret = ChannelMgrInitialize(0);
    EXPECT_EQ(ret, PROFILING_FAILED);
    ret = ChannelMgrFinalize();
    EXPECT_EQ(ret, PROFILING_SUCCESS);

    ret = ChannelMgrInitialize(0);
    EXPECT_EQ(ret, PROFILING_FAILED);
    ret = ChannelMgrFinalize();
    EXPECT_EQ(ret, PROFILING_SUCCESS);

    ProfThreadPoolFinalize();
}

TEST_F(ThreadPoolUtest, ChannelMgrFlushUnInit)
{
    GlobalMockObject::verify();
    EXPECT_EQ(GetChannelIdByIndex(0, 0), 0);
}

TEST_F(ThreadPoolUtest, ChannelReadBasic)
{
    MOCKER(PlatformGetDevNum)
        .stubs()
        .will(returnValue(uint32_t(1)));
    ChannelReader* reader = (ChannelReader*)malloc(sizeof(ChannelReader));
    memset_s(reader, sizeof(ChannelReader), 0, sizeof(ChannelReader));
    ChannelMgChannelRead(NULL);

    reader->quit = 1;
    reader->dispatchCount = 1;
    reader->buffer = (uint8_t*)malloc(MAX_READER_BUFFER_SIZE);
    pthread_mutex_init(&reader->readMtx, NULL);
    pthread_mutex_init(&reader->flushMtx, NULL);
    ChannelMgChannelRead(reader);
    EXPECT_EQ(0, reader->dispatchCount);

    MOCKER(HalProfChannelRead)
        .stubs()
        .will(returnValue(1024 * 1024 * 1))
        .then(returnValue(0));
    reader->quit = 0;
    reader->dispatchCount = 1;
    ChannelMgChannelRead(reader);
    EXPECT_EQ(0, reader->dispatchCount);

    free(reader->buffer);
    free(reader);
    reader = NULL;
}

TEST_F(ThreadPoolUtest, ChannelManagerBasicFailed)
{
    int32_t ret = ProfThreadPoolInit(10, 0, 50);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = ProfThreadPoolInit(10, 0, 50);
    EXPECT_EQ(ret, PROFILING_SUCCESS);

    GlobalMockObject::verify();
    MOCKER(PlatformGetDevNum)
        .stubs()
        .will(returnValue(uint32_t(0)));
    ret = ChannelMgrInitialize(0);
    EXPECT_EQ(ret, PROFILING_FAILED);
    ChannelMgrFinalize();

    GlobalMockObject::verify();
    MOCKER(PlatformGetDevNum)
        .stubs()
        .will(returnValue(uint32_t(1)));
    MOCKER(CstlListInit)
        .stubs()
        .will(returnValue(CSTL_ERR));
    ret = ChannelMgrInitialize(0);
    EXPECT_EQ(ret, PROFILING_FAILED);
    ChannelMgrFinalize();

    GlobalMockObject::verify();
    MOCKER(PlatformGetDevNum)
        .stubs()
        .will(returnValue(uint32_t(1)));
    MOCKER(HalProfGetChannelList)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    ret = ChannelMgrInitialize(0);
    EXPECT_EQ(ret, PROFILING_FAILED);
    ChannelMgrFinalize();

    GlobalMockObject::verify();
    MOCKER(ProfThreadPoolExpand)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    ret = ChannelMgrInitialize(0);
    EXPECT_EQ(ret, PROFILING_FAILED);
    ChannelMgrFinalize();

    GlobalMockObject::verify();
    MOCKER(ProfThreadPoolDispatch)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    ret = ChannelMgrInitialize(0);
    EXPECT_EQ(ret, PROFILING_FAILED);
    ChannelMgrFinalize();

    ProfThreadPoolFinalize();
}

void* MallocStub(int32_t size)
{
    return malloc(size);
}
int32_t g_mallocSuccessCnt = 0;
void* MallocTest(int32_t size)
{
    void* ret = nullptr;
    if (g_mallocSuccessCnt > 0) {
        ret = MallocStub(size);
    } 
    g_mallocSuccessCnt--;
    return ret;
}

TEST_F(ThreadPoolUtest, ChannelReadMallocFailed)
{
    MOCKER(PlatformGetDevNum)
        .stubs()
        .will(returnValue(uint32_t(1)));
    int32_t ret = ProfThreadPoolInit(10, 0, 50);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    ret = ChannelMgrInitialize(0);
    EXPECT_EQ(ret, PROFILING_SUCCESS);

    MOCKER(OsalMalloc)
        .stubs()
        .will(invoke(MallocTest));
    int32_t successCnt = 2;
    g_mallocSuccessCnt = successCnt;
    EXPECT_EQ(PROFILING_FAILED, ChannelMgrCreateReader(0, 150));
    EXPECT_EQ(PROFILING_FAILED, ChannelMgrDestroyReader(0, 150));
    // reader list push failed
    g_mallocSuccessCnt = successCnt--;
    EXPECT_EQ(PROFILING_FAILED, ChannelMgrCreateReader(0, 150));
    EXPECT_EQ(PROFILING_FAILED, ChannelMgrDestroyReader(0, 150));
    // reader buffer failed
    g_mallocSuccessCnt = successCnt--;
    EXPECT_EQ(PROFILING_FAILED, ChannelMgrCreateReader(0, 150));
    EXPECT_EQ(PROFILING_FAILED, ChannelMgrDestroyReader(0, 150));
    // reader failed
    g_mallocSuccessCnt = successCnt--;
    EXPECT_EQ(PROFILING_FAILED, ChannelMgrCreateReader(0, 150));
    EXPECT_EQ(PROFILING_FAILED, ChannelMgrDestroyReader(0, 150));
    ChannelMgrFinalize();
    ProfThreadPoolFinalize();
}

TEST_F(ThreadPoolUtest, UploadChannelDataMallocFailed)
{
    ChannelReader reader = {0, 0, 0, 0, NULL, 0, 1, 0, 0, 0};
    MOCKER(OsalMalloc)
        .stubs()
        .will(invoke(MallocTest));
    int32_t successCnt = 1;
    g_mallocSuccessCnt = successCnt--;
    // reader buffer failed
    ChannelMgrUploadChannelData(&reader);
    EXPECT_EQ(0, reader.dataSize);
    // chunk failed
    reader.dataSize = 1;
    g_mallocSuccessCnt = successCnt--;
    ChannelMgrUploadChannelData(&reader);
    EXPECT_EQ(1, reader.dataSize);
}