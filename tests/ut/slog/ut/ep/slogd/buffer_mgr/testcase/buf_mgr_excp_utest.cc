/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "self_log_stub.h"
#include "slogd_buffer.h"
#include "slogd_applog_flush.h"
#include "ascend_hal_stub.h"

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
using namespace std;
using namespace testing;

class EP_SLOGD_BUF_MGR_EXCP_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        system("rm -rf " PATH_ROOT "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        log_release_buffer();
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("mkdir -p " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }
};

static void *MallocStub(size_t size)
{
    if (size == 0) {
        return NULL;
    }

    void *buffer = malloc(size);
    if (buffer == NULL) {
        return NULL;
    }

    int32_t ret = memset_s(buffer, size, 0, size);
    if (ret != EOK) {
        free(buffer);
        return NULL;
    }
    return buffer;
}

TEST_F(EP_SLOGD_BUF_MGR_EXCP_UTEST, SlogdBufferInitMallocFailed)
{
    MOCKER(LogMalloc).stubs().will(returnValue((void*)NULL));
    EXPECT_EQ(LOG_FAILURE, SlogdBufferInit(DEBUG_SYS_LOG_TYPE, 1024U, 0U, NULL));
    SlogdBufferExit(DEBUG_SYS_LOG_TYPE, NULL);
    GlobalMockObject::verify();

    MOCKER(LogMalloc).stubs()
        .will(invoke(MallocStub))
        .then(returnValue((void*)NULL));
    EXPECT_EQ(LOG_FAILURE, SlogdBufferInit(DEBUG_SYS_LOG_TYPE, 1024U, 0U, NULL));
    SlogdBufferExit(DEBUG_SYS_LOG_TYPE, NULL);
    GlobalMockObject::verify();

    MOCKER(LogMalloc).stubs()
        .will(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(returnValue((void*)NULL));
    EXPECT_EQ(LOG_FAILURE, SlogdBufferInit(DEBUG_APP_LOG_TYPE, 1024U, 0U, NULL));
    SlogdBufferExit(DEBUG_APP_LOG_TYPE, NULL);
    GlobalMockObject::verify();
}

TEST_F(EP_SLOGD_BUF_MGR_EXCP_UTEST, SlogdBufferOpenHandleFailed)
{
    EXPECT_EQ(LOG_SUCCESS, SlogdBufferInit(DEBUG_SYS_LOG_TYPE, 1024U, 0U, NULL));
    MOCKER(LogMalloc).stubs().will(returnValue((void*)NULL));
    void *handle = SlogdBufferHandleOpen(DEBUG_SYS_LOG_TYPE, NULL, LOG_BUFFER_READ_MODE, 0);
    EXPECT_EQ((void *)NULL, handle);
    SlogdBufferHandleClose(&handle);
    GlobalMockObject::verify();

    MOCKER(LogMalloc).stubs()
        .will(invoke(MallocStub))
        .then(invoke(MallocStub))
        .then(returnValue((void*)NULL));
    handle = SlogdBufferHandleOpen(DEBUG_SYS_LOG_TYPE, NULL, LOG_BUFFER_READ_MODE, 0);
    EXPECT_EQ((void *)NULL, handle);
    SlogdBufferHandleClose(&handle);
    GlobalMockObject::verify();

    MOCKER(memcpy_s).stubs().will(returnValue(EOK + 1));
    handle = SlogdBufferHandleOpen(DEBUG_SYS_LOG_TYPE, NULL, LOG_BUFFER_READ_MODE, 0);
    EXPECT_EQ((void *)NULL, handle);
    SlogdBufferHandleClose(&handle);
    GlobalMockObject::verify();

    MOCKER(memcpy_s).stubs()
        .will(returnValue(EOK))
        .then(returnValue(EOK + 1));
    handle = SlogdBufferHandleOpen(DEBUG_SYS_LOG_TYPE, NULL, LOG_BUFFER_READ_MODE, 0);
    EXPECT_EQ((void *)NULL, handle);
    SlogdBufferHandleClose(&handle);
    SlogdBufferExit(DEBUG_SYS_LOG_TYPE, NULL);
    GlobalMockObject::verify();
}

TEST_F(EP_SLOGD_BUF_MGR_EXCP_UTEST, SlogdStaticBufferWriteFailed)
{
    const char *msg = "test.";
    EXPECT_EQ(LOG_INVALID_PTR, SlogdBufferWrite(NULL, msg, strlen(msg)));

    EXPECT_EQ(LOG_SUCCESS, SlogdBufferInit(DEBUG_SYS_LOG_TYPE, 1024U, 0U, NULL));
    void *handle = SlogdBufferHandleOpen(DEBUG_SYS_LOG_TYPE, NULL, LOG_BUFFER_WRITE_MODE, 0);
    EXPECT_EQ(LOG_INVALID_PTR, SlogdBufferWrite(handle, NULL, strlen(msg)));
    EXPECT_EQ(LOG_INVALID_PTR, SlogdBufferWrite(handle, msg, 1025U));

    MOCKER(localtime_r).stubs().will(returnValue((struct tm *)NULL));
    EXPECT_EQ(LOG_FAILURE, SlogdBufferWrite(handle, msg, strlen(msg)));
    GlobalMockObject::verify();

    MOCKER(memcpy_s).stubs().will(returnValue(EOK + 1));
    EXPECT_EQ(LOG_FAILURE, SlogdBufferWrite(handle, msg, strlen(msg)));
    SlogdBufferHandleClose(&handle);
    SlogdBufferExit(DEBUG_SYS_LOG_TYPE, NULL);
}

TEST_F(EP_SLOGD_BUF_MGR_EXCP_UTEST, SlogdDynamicBufferWriteFailed)
{
    const char *msg = "test.";
    EXPECT_EQ(LOG_SUCCESS, SlogdBufferInit(DEBUG_APP_LOG_TYPE, 1024U, 0U, NULL));
    void *handle = SlogdBufferHandleOpen(DEBUG_APP_LOG_TYPE, NULL, LOG_BUFFER_WRITE_MODE, 0);
    MOCKER(memcpy_s).stubs().will(returnValue(EOK + 1));
    EXPECT_EQ(LOG_FAILURE, SlogdBufferWrite(handle, msg, strlen(msg)));
    SlogdBufferHandleClose(&handle);
    SlogdBufferExit(DEBUG_APP_LOG_TYPE, NULL);
}

TEST_F(EP_SLOGD_BUF_MGR_EXCP_UTEST, SlogdDynamicBufferReadFailed)
{
    EXPECT_EQ(-1, SlogdBufferRead(NULL, NULL, 0));
    EXPECT_EQ(LOG_SUCCESS, SlogdBufferInit(DEBUG_APP_LOG_TYPE, 1024U, 0U, NULL));
    void *handle = SlogdBufferHandleOpen(DEBUG_APP_LOG_TYPE, NULL, LOG_BUFFER_WRITE_MODE, 0);
    EXPECT_EQ(-1, SlogdBufferRead(handle, NULL, 0));
    SlogdBufferHandleClose(&handle);
    SlogdBufferExit(DEBUG_APP_LOG_TYPE, NULL);
}

TEST_F(EP_SLOGD_BUF_MGR_EXCP_UTEST, SlogdStaticBufferReadFailed)
{
    MOCKER(memcpy_s).stubs().will(returnValue(EOK + 1));
    EXPECT_EQ(LOG_SUCCESS, SlogdBufferInit(DEBUG_SYS_LOG_TYPE, 1024U, 0U, NULL));
    void *handle = SlogdBufferHandleOpen(DEBUG_SYS_LOG_TYPE, NULL, LOG_BUFFER_WRITE_MODE, 0);
    EXPECT_EQ(-1, SlogdBufferRead(handle, NULL, 0));
    SlogdBufferHandleClose(&handle);
    SlogdBufferExit(DEBUG_SYS_LOG_TYPE, NULL);
}