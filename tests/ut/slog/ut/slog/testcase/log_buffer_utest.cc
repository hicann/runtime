/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

extern "C" {
    #include "slogd_utest_stub.h"
    #include "log_ring_buffer.h"
}

using namespace std;
using namespace testing;

class LogBufferUtest : public testing::Test
{
    protected:
        static void SetUpTestCase()
        {
            cout << "LogBufferUtest SetUP" << endl;
        }
        static void TearDownTestCase()
        {
            cout << "LogBufferUtest TearDown" << endl;
        }
        virtual void SetUp()
        {
            cout << "a test SetUP" << endl;
        }
        virtual void TearDown()
        {
            cout << "a test TearDown" << endl;
        }
};

TEST_F(LogBufferUtest, InitRingbufferHead_suc)
{
    RingBufferCtrl *ringBuffer = (RingBufferCtrl *)calloc(1, 1*1024*1024);
    int res = LogBufInitHead(ringBuffer, 1*1024*1024, 0);
    EXPECT_EQ(ringBuffer->dataLen, 1*1024*1024 - 128);
    EXPECT_EQ(ringBuffer->dataOffset, 128);
    free(ringBuffer);
}

TEST_F(LogBufferUtest, InitRingbufferHead_suc2)
{
    RingBufferCtrl *ringBuffer = (RingBufferCtrl *)calloc(1, 4*1024 + 500);
    int res = LogBufInitHead(ringBuffer, 4*1024 + 500, 0);
    EXPECT_EQ(ringBuffer->dataLen, 3968);
    EXPECT_EQ(ringBuffer->dataOffset, 128);
    free(ringBuffer);
}

TEST_F(LogBufferUtest, ReadAndWritesSuc)
{
    LogHead head;
    char *mem = (char *)calloc(1, sizeof(RingBufferCtrl) + 480 + 32);
    RingBufferCtrl *ctrl = (RingBufferCtrl *)mem;
    ctrl->dataLen = 480 + 32;
    ctrl->dataOffset = sizeof(RingBufferCtrl);
    char szBuff[14];
    int count1 = 10;
    int32_t res;
    uint64_t coverCount;
    for (int i = 0; i < 15; i++) {
        sprintf(szBuff,"%s%d","Hello world",count1);
        head.msgLength = strlen(szBuff);
        res = LogBufWrite(ctrl, szBuff, &head, &coverCount);
        count1++;
    }

    LogHead msgRes;
    int resCount = 0;
    ReadContext readContext = {0};
    for (int i = 0; i < 15; i++) {
        char tmp[MSG_LENGTH];
        res = LogBufRead(&readContext, ctrl, tmp, MSG_LENGTH, &msgRes);
        if (res > 0) {
            resCount++;
        }
    }
    EXPECT_EQ(resCount, 9);
    free(mem);
}

TEST_F(LogBufferUtest, ReadAndWritesSuc2)
{
    LogHead head;
    char *mem = (char *)calloc(1, sizeof(RingBufferCtrl) + 480 + 31);
    RingBufferCtrl *ctrl = (RingBufferCtrl *)mem;
    ctrl->dataLen = 480 + 31;
    ctrl->dataOffset = sizeof(RingBufferCtrl);
    char szBuff[14];
    int count1 = 10;
    int32_t res;
    uint64_t coverCount;
    for (int i = 0; i < 10; i++) {
        sprintf(szBuff,"%s%d","Hello world",count1);
        head.msgLength = strlen(szBuff);
        res = LogBufWrite(ctrl, szBuff, &head, &coverCount);
        count1++;
     }

    LogHead msgRes;
    int resCount = 0;
    ReadContext readContext = {0};
    for (int i = 0; i < 10; i++) {
        char tmp[MSG_LENGTH];
        res = LogBufRead(&readContext, ctrl, tmp, MSG_LENGTH, &msgRes);
        if(res > 0) {
            resCount++;
        }
    }
    EXPECT_EQ(resCount, 8);
    free(mem);
}

TEST_F(LogBufferUtest, ReadAndWritesSuc3)
{
    LogHead head;
    char *mem = (char *)calloc(1, sizeof(RingBufferCtrl) + 480 + 32);
    RingBufferCtrl *ctrl = (RingBufferCtrl *)mem;
    ctrl->dataLen = 480 + 32;
    ctrl->dataOffset = sizeof(RingBufferCtrl);
    char szBuff[100];
    int count1 = 0;
    int resCount = 0;
    int32_t res;
    LogHead msgRes;
    char tmp[MSG_LENGTH];
    ReadContext readContext = {0};
    uint64_t coverCount;
    for (int j = 0; j < 2000; j++) {
        for (int i = 0; i < 5; i++) {
        sprintf(szBuff,"%s%d%d%d%d","Hello world",count1,count1,count1,count1);
        head.msgLength = strlen(szBuff);
        res = LogBufWrite(ctrl, szBuff, &head, &coverCount);
        count1++;
        }
        for (int i = 0; i < 5; i++) {
        res = LogBufRead(&readContext, ctrl, tmp, MSG_LENGTH, &msgRes);
        if(res > 0) {
            resCount++;
        }
        }
        if (resCount == 5000) {
            const char *str = "Hello world4999499949994999";
            EXPECT_STREQ(str, tmp);
        }
    }

    for (int i = 0; i < 10; i++) {
        res = LogBufRead(&readContext, ctrl, tmp, MSG_LENGTH, &msgRes);
        if(res > 0) {
            resCount++;
        }
    }
    EXPECT_EQ(resCount, 10000);
    free(mem);
}
