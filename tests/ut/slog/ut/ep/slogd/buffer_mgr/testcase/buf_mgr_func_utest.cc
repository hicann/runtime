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

class EP_SLOGD_BUF_MGR_FUNC_UTEST : public testing::Test
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

TEST_F(EP_SLOGD_BUF_MGR_FUNC_UTEST, SlogdBufferInit)
{
    for (int32_t i = DEBUG_SYS_LOG_TYPE; i < LOG_TYPE_MAX_NUM; i++) {
        EXPECT_EQ(LOG_SUCCESS, SlogdBufferInit(i, 3 * 1024 * 1024, 0, NULL));
    }
    for (int32_t i = DEBUG_SYS_LOG_TYPE; i < LOG_TYPE_MAX_NUM; i++) {
        SlogdBufferExit(i, NULL);
    }
}

TEST_F(EP_SLOGD_BUF_MGR_FUNC_UTEST, SlogdBufferStaticInit)
{
    EXPECT_EQ(LOG_SUCCESS, SlogdBufferInit(DEBUG_SYS_LOG_TYPE, 3 * 1024 * 1024, 0, NULL));
    const char *msg = "test slogd buffer write.\n";
    void *handle = SlogdBufferHandleOpen(DEBUG_SYS_LOG_TYPE, NULL, LOG_BUFFER_WRITE_MODE, 0);
    EXPECT_EQ(LOG_SUCCESS, SlogdBufferWrite(handle, msg, strlen(msg)));
    SlogdBufferHandleClose(&handle);
    SlogdBufferExit(DEBUG_SYS_LOG_TYPE, NULL);

    EXPECT_EQ(LOG_SUCCESS, SlogdBufferInit(DEBUG_SYS_LOG_TYPE, 3 * 1024 * 1024, 0, NULL));
    handle = SlogdBufferHandleOpen(DEBUG_SYS_LOG_TYPE, NULL, LOG_BUFFER_READ_MODE, 0);
    char result[1024] = { 0 };
    EXPECT_EQ(strlen(msg), SlogdBufferRead(handle, result, 1024));
    SlogdMsgData *data = (SlogdMsgData *)result;
    EXPECT_STREQ((char *)msg, data->data);
    SlogdBufferReset(handle);
    SlogdBufferHandleClose(&handle);
    SlogdBufferExit(DEBUG_SYS_LOG_TYPE, NULL);
}

TEST_F(EP_SLOGD_BUF_MGR_FUNC_UTEST, SlogdBufferWrite)
{
    const char *msg = "test slogd buffer write.\n";
    EXPECT_EQ(LOG_SUCCESS, SlogdBufferInit(DEBUG_SYS_LOG_TYPE, 3 * 1024 * 1024, 0, NULL));
    void *handle = SlogdBufferHandleOpen(DEBUG_SYS_LOG_TYPE, NULL, LOG_BUFFER_WRITE_MODE, 0);
    EXPECT_EQ(LOG_SUCCESS, SlogdBufferWrite(handle, msg, strlen(msg)));
    char result[1024] = { 0 };
    EXPECT_EQ(strlen(msg), SlogdBufferRead(handle, result, 1024));
    EXPECT_STREQ((char *)msg, result);
    memset_s(result, 1024, 0, 1024);
    EXPECT_EQ(0, SlogdBufferRead(handle, result, 1024));
    EXPECT_STREQ("", result);
    SlogdBufferHandleClose(&handle);

    handle = SlogdBufferHandleOpen(DEBUG_SYS_LOG_TYPE, NULL, LOG_BUFFER_WRITE_MODE, 0);
    memset_s(result, 1024, 0, 1024);
    EXPECT_EQ(0, SlogdBufferRead(handle, result, 1024));
    EXPECT_STREQ("", result);
    SlogdBufferHandleClose(&handle);
    SlogdBufferExit(DEBUG_SYS_LOG_TYPE, NULL);
}

TEST_F(EP_SLOGD_BUF_MGR_FUNC_UTEST, SlogdBufferRead)
{
    const char *msg = "test slogd buffer write.\n";
    EXPECT_EQ(LOG_SUCCESS, SlogdBufferInit(DEBUG_SYS_LOG_TYPE, 3 * 1024 * 1024, 0, NULL));
    void *handle = SlogdBufferHandleOpen(DEBUG_SYS_LOG_TYPE, NULL, LOG_BUFFER_WRITE_MODE, 0);
    EXPECT_EQ(LOG_SUCCESS, SlogdBufferWrite(handle, msg, strlen(msg)));
    SlogdBufferHandleClose(&handle);

    handle = SlogdBufferHandleOpen(DEBUG_SYS_LOG_TYPE, NULL, LOG_BUFFER_READ_MODE, 0);
    char result[1024] = { 0 };
    EXPECT_EQ(strlen(msg), SlogdBufferRead(handle, result, 1024));
    SlogdMsgData *data = (SlogdMsgData *)result;
    EXPECT_STREQ((char *)msg, data->data);
    memset_s(result, 1024, 0, 1024);
    EXPECT_EQ(0, SlogdBufferRead(handle, result, 1024));
    EXPECT_STREQ("", result);
    SlogdBufferHandleClose(&handle);

    handle = SlogdBufferHandleOpen(DEBUG_SYS_LOG_TYPE, NULL, LOG_BUFFER_READ_MODE, 0);
    memset_s(result, 1024, 0, 1024);
    EXPECT_EQ(strlen(msg), SlogdBufferRead(handle, result, 1024));
    EXPECT_STREQ((char *)msg, data->data);
    SlogdBufferHandleClose(&handle);
    SlogdBufferExit(DEBUG_SYS_LOG_TYPE, NULL);
}

static bool SlogdBufAttrCompare(void *srcAttr, void *dstAttr)
{
    return srcAttr == dstAttr;
}

TEST_F(EP_SLOGD_BUF_MGR_FUNC_UTEST, SlogdBufferList)
{
    AppLogList *appLog = NULL;
    for (int i = 0; i < 1024; i++) {
        AppLogList *node = (AppLogList *)LogMalloc(sizeof(AppLogList));
        SlogdBufAttr bufAttr = { node, SlogdBufAttrCompare };
        EXPECT_EQ(LOG_SUCCESS, SlogdBufferInit(DEBUG_APP_LOG_TYPE, 256 * 1024, 0, &bufAttr));
        if (i == 0) {
            appLog = node;
        } else {
            AppLogList *next = appLog->next;
            appLog->next = node;
            node->next = next;
        }
    }
    AppLogList *pre = appLog;
    AppLogList *logNode = appLog->next;
    int num = 0;
    for (; num < 100; num++) {
        pre = logNode;
        logNode = logNode->next;
    }
    EXPECT_EQ(100, num);
    void *handle = SlogdBufferHandleOpen(DEBUG_APP_LOG_TYPE, logNode, LOG_BUFFER_WRITE_MODE, 0);
    const char *msg = "test app log list.";
    EXPECT_EQ(LOG_SUCCESS, SlogdBufferWrite(handle, msg, strlen(msg)));
    SlogdBufferHandleClose(&handle);

    handle = SlogdBufferHandleOpen(DEBUG_APP_LOG_TYPE, logNode, LOG_BUFFER_READ_MODE, 0);
    char result[1024] = { 0 };
    EXPECT_EQ(strlen(msg), SlogdBufferRead(handle, result, 1024));
    EXPECT_STREQ((char *)msg, result);
    SlogdBufferHandleClose(&handle);

    handle = SlogdBufferHandleOpen(DEBUG_APP_LOG_TYPE, logNode, LOG_BUFFER_WRITE_MODE, 0);
    memset_s(result, 1024, 0, 1024);
    EXPECT_EQ(strlen(msg), SlogdBufferRead(handle, result, 1024));
    EXPECT_STREQ((char *)msg, result);
    EXPECT_EQ(true, SlogdBufferCheckEmpty(handle));
    SlogdBufferHandleClose(&handle);
    SlogdBufferExit(DEBUG_APP_LOG_TYPE, logNode);
    pre->next = logNode->next;
    XFREE(logNode);

    num = 0;
    while (appLog != NULL) {
        AppLogList *next = appLog->next;
        SlogdBufferExit(DEBUG_APP_LOG_TYPE, appLog);
        XFREE(appLog);
        appLog = next;
        num++;
    }
    EXPECT_EQ(1023, num);
}

TEST_F(EP_SLOGD_BUF_MGR_FUNC_UTEST, SlogdBufferFull)
{
    EXPECT_EQ(LOG_SUCCESS, SlogdBufferInit(DEBUG_APP_LOG_TYPE, 1024, 0, NULL));
    void *handle = SlogdBufferHandleOpen(DEBUG_APP_LOG_TYPE, NULL, LOG_BUFFER_WRITE_MODE, 0);
    EXPECT_EQ(true, SlogdBufferCheckEmpty(handle));
    const char *msg = "test slogd buffer write.\n";
    for (int i = 0; i < 1024; i++) {
        if (SlogdBufferCheckFull(handle, strlen(msg))) {
            break;
        }
        EXPECT_EQ(LOG_SUCCESS, SlogdBufferWrite(handle, msg, strlen(msg)));
    }
    EXPECT_EQ(true, SlogdBufferCheckFull(handle, 1024));
    char result[1024] = { 0 };
    while (!SlogdBufferCheckEmpty(handle)) {
        EXPECT_LT(0, SlogdBufferRead(handle, result, 1024));
    };
    EXPECT_EQ(true, SlogdBufferCheckEmpty(handle));
    SlogdBufferHandleClose(&handle);
    SlogdBufferExit(DEBUG_APP_LOG_TYPE, NULL);
}

TEST_F(EP_SLOGD_BUF_MGR_FUNC_UTEST, SlogdDynamicBufferBlockFull)
{
    EXPECT_EQ(LOG_SUCCESS, SlogdBufferInit(DEBUG_SYS_LOG_TYPE, 2 * 1024 * 1024, 0, NULL));
    void *handle = SlogdBufferHandleOpen(DEBUG_SYS_LOG_TYPE, NULL, LOG_BUFFER_WRITE_MODE, 0);
    EXPECT_NE(handle, (void *)NULL);
    EXPECT_EQ(true, SlogdBufferCheckEmpty(handle));
    const char *msg = "test slogd buffer write.\n";
    int num = 0;
    for (num = 0; num < 1024 * 1024; num++) {
        if (SlogdBufferCheckFull(handle, strlen(msg))) {
            break;
        }
        EXPECT_EQ(LOG_SUCCESS, SlogdBufferWrite(handle, msg, strlen(msg)));
    }
    SELF_LOG_ERROR("NUM=%d", num);
    char result[1024] = { 0 };
    for (int i = 0; i < num - 1; i++) {
        uint32_t ret = SlogdBufferRead(handle, result, strlen(msg));
        EXPECT_EQ(strlen(msg), ret);
        if (ret != strlen(msg)) {
            SELF_LOG_ERROR("msg num = %d, read num = %d.", num, i);
            break;
        }
    }
    EXPECT_EQ(LOG_SUCCESS, SlogdBufferWrite(handle, msg, strlen(msg)));
    EXPECT_EQ(strlen(msg), SlogdBufferRead(handle, result, strlen(msg)));
    EXPECT_EQ(strlen(msg), SlogdBufferRead(handle, result, strlen(msg)));
    EXPECT_EQ(true, SlogdBufferCheckEmpty(handle));
    SlogdBufferHandleClose(&handle);
    SlogdBufferExit(DEBUG_SYS_LOG_TYPE, NULL);
}

void TestBuffer(int32_t type, uint32_t bufSize)
{
    EXPECT_EQ(LOG_SUCCESS, SlogdBufferInit(type, bufSize, 0, NULL));
    void *handle = SlogdBufferHandleOpen(type, NULL, LOG_BUFFER_WRITE_MODE, 0);
    EXPECT_NE(handle, (void *)NULL);
    EXPECT_EQ(true, SlogdBufferCheckEmpty(handle));
    const char *msg = "test slogd buffer write.\n";
    int num = 0;
    for (num = 0; num < 1024 * 1024; num++) {
        if (SlogdBufferCheckFull(handle, strlen(msg))) {
            break;
        }
        EXPECT_EQ(LOG_SUCCESS, SlogdBufferWrite(handle, msg, strlen(msg)));
    }
    char result[1024] = { 0 };
    for (int i = 0; i < num; i++) {
        uint32_t ret = SlogdBufferRead(handle, result, strlen(msg));
        EXPECT_EQ(strlen(msg), ret);
        if (ret != strlen(msg)) {
            SELF_LOG_ERROR("msg num = %d, read num = %d.", num, i);
            break;
        }
    }
    EXPECT_EQ(true, SlogdBufferCheckEmpty(handle));
    SlogdBufferHandleClose(&handle);
    SlogdBufferExit(DEBUG_APP_LOG_TYPE, NULL);
}

TEST_F(EP_SLOGD_BUF_MGR_FUNC_UTEST, SlogdStaticBufferBlockFull)
{
    TestBuffer(DEBUG_SYS_LOG_TYPE, 1024 * 1024 * 2);
    TestBuffer(DEBUG_SYS_LOG_TYPE, 1024 * 1024 * 3);
}

TEST_F(EP_SLOGD_BUF_MGR_FUNC_UTEST, SlogdCollectBufferRound)
{
    EXPECT_EQ(LOG_SUCCESS, SlogdBufferInit(DEBUG_APP_LOG_TYPE, 1024 * 1024, 0, NULL));
    void *handle = SlogdBufferHandleOpen(DEBUG_APP_LOG_TYPE, NULL, LOG_BUFFER_WRITE_MODE, 0);
    EXPECT_NE(handle, (void *)NULL);
    EXPECT_EQ(true, SlogdBufferCheckEmpty(handle));
    const char *msg = "[ERROR]test slogd buffer write.\n";
    int num = 0;
    for (num = 0; num < 1024 * 1024; num++) {
        if (SlogdBufferCheckFull(handle, strlen(msg))) {
            break;
        }
        EXPECT_EQ(LOG_SUCCESS, SlogdBufferWrite(handle, msg, strlen(msg)));
    }
    char result[1024] = { 0 };
    for (int i = 0; i < num; i++) {
        uint32_t ret = SlogdBufferRead(handle, result, strlen(msg));
        EXPECT_EQ(strlen(msg), ret);
        if (ret != strlen(msg)) {
            SELF_LOG_ERROR("msg num = %d, read num = %d.", num, i);
            break;
        }
    }
    EXPECT_EQ(true, SlogdBufferCheckEmpty(handle));
    EXPECT_EQ(LOG_SUCCESS, SlogdBufferWrite(handle, msg, strlen(msg)));
    char buf[100] = { 0 };
    uint32_t pos = 0;
    EXPECT_EQ(LOG_SUCCESS, SlogdBufferCollectNewest(buf, 100, &pos, handle, 100));
    EXPECT_EQ(0, pos % strlen(msg));
    SlogdBufferHandleClose(&handle);
    SlogdBufferExit(DEBUG_APP_LOG_TYPE, NULL);
}