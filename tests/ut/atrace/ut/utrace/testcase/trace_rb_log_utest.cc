/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <thread>
#include <future>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "trace_rb_log.h"
#include "adiag_print.h"
#include "trace_types.h"
#include "securec.h"
#include "trace_system_api.h"
#include "atrace_api.h"
#include "adiag_list.h"
#include "adiag_utils.h"

using RunFunc = uint64_t (*)(int, int, struct RbLog *, int, int);
static constexpr uint64_t SEC_TO_US = 1000000;

uint64_t GetSysCycleTime()
{
    struct timespec now = {0, 0};
    (void)clock_gettime(CLOCK_MONOTONIC_RAW, &now);
    return (static_cast<uint64_t>(now.tv_sec) * SEC_TO_NS) + static_cast<uint64_t>(now.tv_nsec);
}

class RraceRbLogUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
        bufferSize_ = 1024;
        writeThreadNum_ = 1;
        readThreadNum_ = 1;
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
    
    int bufferSize_;
    int writeThreadNum_;
    int readThreadNum_;
    uint64_t EXPECT_TestLogRingBuffer(int msgNum, int expectResult, RunFunc runFunc);
};

uint64_t WriteMsgPerfFunc(int threadId, struct RbLog *rb, const int msgNum)
{
    std::string buffer = std::to_string(threadId) + "_msg";
    buffer = std::string(rb->head.msgSize - sizeof(RbMsgHead) - buffer.length() - 1, '*') + buffer;
    uint32_t bufSize = buffer.size() + 1;
    uint64_t startTime = GetSysCycleTime();
    for (int i = 0; i < msgNum; i++) {
        TraceRbLogWriteRbMsg(rb, 0, buffer.c_str(), bufSize);
    }
    uint64_t stopTime = GetSysCycleTime();
    return stopTime - startTime;
}

uint64_t WriteMsgFunc(int threadId, struct RbLog *rb, const int msgNum)
{
    uint64_t time = 0;
    for (int i = 0; i < msgNum; i++) {
        std::string buffer = std::to_string(threadId) + "_" + std::to_string(i) + "_msg";
        buffer = std::string(rb->head.msgSize - sizeof(RbMsgHead) - buffer.length() - 1, '*') + buffer;
        uint32_t bufSize = buffer.size() + 1;
        ADIAG_DBG("threadId %d write msg %d %s,size : %zu", threadId, i, buffer.c_str(), buffer.length() + 1);
        uint64_t startTime = GetSysCycleTime();
        auto ret = TraceRbLogWriteRbMsg(rb, 0, buffer.c_str(), bufSize);
        uint64_t stopTime = GetSysCycleTime();
        time += stopTime - startTime;
        EXPECT_EQ(ret, TRACE_SUCCESS);
    }
    return time;
}

#define TIMESTAMP_MAX_LENGTH 29U
int ReadMsgFunc(int threadId, struct RbLog *rb)
{
    int num = 0;
    RbLogMsg *msg = NULL;
    struct RbLog *newRb;
    struct RbLogMsgTime tm;
    TraStatus ret = TraceRbLogGetCopyOfRingBuffer(&newRb, rb);
    EXPECT_EQ(ret, TRACE_SUCCESS);
    char timestamp[TIMESTAMP_MAX_LENGTH] = {0};
    char *txt;
    do {
        ret = TraceRbLogReadRbMsg(newRb, (char *)&timestamp, sizeof(timestamp), &txt);
        if (ret == TRACE_SUCCESS) {
            ADIAG_DBG("threadId %d read msg %d [%s]", threadId, timestamp, txt);
            std::string str = txt;
            std::string tmp = str.erase(0, str.length() - 3);
            if (tmp.compare("msg") != 0) {
                uint32_t readIdx = 0;
                for (; readIdx != rb->head.bufSize; readIdx++) {
                    RbLogMsg *msg = (RbLogMsg *)(rb->msg + rb->head.msgSize * readIdx);
                    ADIAG_RUN_INF("[rb] readIdx : %d busy :%d, txtSize : %d, txt:%s",
                        readIdx, (int)msg->head.busy, msg->head.txtSize, msg->txt);
                }
                readIdx = 0;
                for (;readIdx != newRb->head.bufSize; readIdx++) {
                    RbLogMsg *msg = (RbLogMsg *)(newRb->msg + newRb->head.msgSize * readIdx);
                    ADIAG_RUN_INF("[new rb] readIdx : %d busy :%d, txtSize : %d, txt:%s",
                        readIdx, (int)msg->head.busy, msg->head.txtSize, msg->txt);
                }
            }
            EXPECT_STREQ(tmp.c_str(), "msg");
            num++;
        } 

    } while(ret == TRACE_SUCCESS);
    free(newRb);
    newRb = NULL;
    ADIAG_INF("threadId %d write msg %d", threadId, num);
    
    return num;
}

void WriteMsgPerf(std::vector<std::future<uint64_t>> &thread, int threadNum, int msgNum, struct RbLog *rb)
{
    for (int i = 0; i < threadNum; i++) {        
        thread.push_back(std::move(std::async(&WriteMsgPerfFunc, i, rb, msgNum)));
    }
}

void WriteMsg(std::vector<std::future<uint64_t>> &thread, int threadNum, int msgNum, struct RbLog *rb)
{
    for (int i = 0; i < threadNum; i++) {        
        thread.push_back(std::move(std::async(&WriteMsgFunc, i, rb, msgNum)));
    }
}

void ReadMsg(std::vector<std::future<int>> &thread, int threadNum, struct RbLog *rb)
{
    for (int i = 0; i < threadNum; i++) {
        thread.push_back(std::move(std::async(&ReadMsgFunc, i, rb)));
    }
}

uint64_t TestWritePerf(int writeThreadNum_, int readThreadNum_, struct RbLog *rb, int msgNum, int expectResult)
{
    std::vector<std::future<uint64_t>> writeThread;
    std::vector<std::future<int>> readThread;

    WriteMsgPerf(writeThread, writeThreadNum_, msgNum, rb);
    uint64_t time = 0;
    for (auto &fret : writeThread) {
        time += fret.get();
    }
    return time;
}

uint64_t TestReadAfterWrite(int writeThreadNum_, int readThreadNum_, struct RbLog *rb, int msgNum, int expectResult)
{
    std::vector<std::future<uint64_t>> writeThread;
    std::vector<std::future<int>> readThread;

    WriteMsg(writeThread, writeThreadNum_, msgNum, rb);
    uint64_t time = 0;
    for (auto &fret : writeThread) {
        time += fret.get();
    }

    ReadMsg(readThread, readThreadNum_, rb);    
    int count = 0;
    for (auto &fret : readThread) {
        count += fret.get();
    }
    ADIAG_RUN_INF("read count %d", count);
    return time;
}

uint64_t TestReadWhileWrite(int writeThreadNum_, int readThreadNum_, struct RbLog *rb, int msgNum, int expectResult)
{
    std::vector<std::future<uint64_t>> writeThread;
    std::vector<std::future<int>> readThread;

    WriteMsg(writeThread, writeThreadNum_, msgNum, rb);
    ReadMsg(readThread, readThreadNum_, rb);
    
    uint64_t time = 0;
    for (auto &fret : writeThread) {
        time += fret.get();
    }
    int count = 0;
    for (auto &fret : readThread) {
        count += fret.get();
    }
    ADIAG_RUN_INF("read count %d", count);
    return time;
}

uint64_t RraceRbLogUtest::EXPECT_TestLogRingBuffer(int msgNum, int expectResult, RunFunc runFunc)
{
    const char objName[] = "HCCL";
    
    ADIAG_RUN_INF("start writeThreadNum_ %d, readThreadNum_ %d, bufferSize_ %d, msgNum %d",
        writeThreadNum_, readThreadNum_, bufferSize_, msgNum);
    TraceAttr attr = { 0 };
    attr.msgNum = bufferSize_;
    attr.msgSize = 112;
    auto rb = TraceRbLogCreate(objName, &attr);
    
    // test
    uint64_t time = runFunc(writeThreadNum_, readThreadNum_, rb, msgNum, expectResult);

    // restoration
    TraceRbLogDestroy(rb);
    ADIAG_RUN_INF("finish writeThreadNum_ %d, readThreadNum_ %d, bufferSize_ %d, msgNum %d, duration %lluns",
        writeThreadNum_, readThreadNum_, bufferSize_, msgNum, time);
    return time;
}

TEST_F(RraceRbLogUtest, TestOneProducerEmpty)
{
    int msgNum = 0;
    int expectResult = 0;

    EXPECT_TestLogRingBuffer(msgNum, expectResult, &TestReadAfterWrite);
    EXPECT_TestLogRingBuffer(msgNum, expectResult, &TestReadWhileWrite);
}

TEST_F(RraceRbLogUtest, TestMsgNumLTBufferSize)
{
    std::vector<int> writeThreadNumList = {1, 2, 4, 8};
    for (auto threadNum : writeThreadNumList) {
        writeThreadNum_ = threadNum;
        int msgNum = bufferSize_ - 1;
        int expectResult = msgNum * (writeThreadNum_);
        EXPECT_TestLogRingBuffer(msgNum, expectResult, &TestReadAfterWrite);
        EXPECT_TestLogRingBuffer(msgNum, expectResult, &TestReadWhileWrite);
    }
}

TEST_F(RraceRbLogUtest, TestMsgNumEQBufferSize)
{
    std::vector<int> writeThreadNumList = {1, 2, 4, 8};
    for (auto threadNum : writeThreadNumList) {
        writeThreadNum_ = threadNum;
        int msgNum = bufferSize_;
        int expectResult = bufferSize_;
        EXPECT_TestLogRingBuffer(msgNum, expectResult, &TestReadAfterWrite);
        EXPECT_TestLogRingBuffer(msgNum, expectResult, &TestReadWhileWrite);
    }
}

TEST_F(RraceRbLogUtest, TestMsgNumGTBufferSize)
{
    std::vector<int> writeThreadNumList = {1, 2, 4, 8};
    std::vector<int> bufferSizeList = {512, 1024};
    for (auto bufferSize : bufferSizeList) {
        bufferSize_ = bufferSize;
        for (auto threadNum : writeThreadNumList) {
            writeThreadNum_ = threadNum;
            int msgNum = bufferSize_ * 2 - 1;
            int expectResult = bufferSize_;
            EXPECT_TestLogRingBuffer(msgNum, expectResult, &TestReadAfterWrite);
            EXPECT_TestLogRingBuffer(msgNum, expectResult, &TestReadWhileWrite);
        }
    }
}

TEST_F(RraceRbLogUtest, TestTraceRbLogCreateSuccess)
{
    TraceAttr attr = { 0 };
    attr.msgNum = 512;
    attr.msgSize = 112;
    std::string name = "HCCL";
    auto rb = TraceRbLogCreate(name.c_str(), &attr);
    EXPECT_TRUE(rb != NULL);
    EXPECT_EQ(rb->head.msgSize, attr.msgSize + sizeof(struct RbMsgHead));
    EXPECT_EQ(rb->head.bufSize, attr.msgNum);
    TraceRbLogDestroy(rb);
}

TEST_F(RraceRbLogUtest, TestTraceRbLogCreateGetTimeFailed)
{
    MOCKER(TraceGetTimeOffset).stubs().will(returnValue(-1));
    TraceAttr attr = { 0 };
    std::string name = "HCCL";
    auto rb = TraceRbLogCreate(name.c_str(), &attr);
    EXPECT_TRUE(rb != NULL);
    EXPECT_EQ(0, rb->head.minutesWest);
    TraceRbLogDestroy(rb);
}

TEST_F(RraceRbLogUtest, TestTraceRbLogCreateNonPowerOf2)
{
    TraceAttr attr = { 0 };
    attr.msgNum = 1000;
    attr.msgSize = 112;
    std::string name = "HCCL";
    auto rb = TraceRbLogCreate(name.c_str(), &attr);
    EXPECT_TRUE(rb != NULL);
    EXPECT_EQ(rb->head.bufSize, 1024);
    EXPECT_EQ(rb->head.msgSize, attr.msgSize + sizeof(struct RbMsgHead));
    TraceRbLogDestroy(rb);

    attr.msgNum = 513;
    rb = TraceRbLogCreate(name.c_str(), &attr);
    EXPECT_TRUE(rb != NULL);
    EXPECT_EQ(rb->head.bufSize, 1024);
    EXPECT_EQ(rb->head.msgSize, attr.msgSize + sizeof(struct RbMsgHead));
    TraceRbLogDestroy(rb);
}

TEST_F(RraceRbLogUtest, TestTraceRbLogCreateInvalidBufferSize)
{
    std::string name = "HCCL";
    TraceAttr attr = { 0 };
    attr.msgNum = 1025;
    attr.msgSize = 112;
    auto rb = TraceRbLogCreate(name.c_str(), &attr);
    EXPECT_TRUE(rb == NULL);
}

TEST_F(RraceRbLogUtest, TestTraceRbLogCreateValidName)
{
    TraceAttr attr = { 0 };
    attr.msgNum = 1024;
    attr.msgSize = 112;
    std::string name = "1234567890123456789012345678901";
    auto rb = TraceRbLogCreate(name.c_str(), &attr);
    EXPECT_TRUE(rb != NULL);
    rb->head.writeIdx = 0xFFFFFFFF;
    EXPECT_EQ(rb->head.msgSize, 128);
    EXPECT_EQ(rb->head.msgTxtSize, 112);
    EXPECT_EQ(rb->head.bufSize, attr.msgNum);
    EXPECT_STREQ(rb->head.name, name.c_str());
    TraceRbLogDestroy(rb);
}

TEST_F(RraceRbLogUtest, TestTraceRbLogCreateInvalidName)
{
    TraceAttr attr = { 0 };
    attr.msgNum = 1024;
    attr.msgSize = 112;
    std::string name = "12345678901234567890123456789012";
    auto rb = TraceRbLogCreate(name.c_str(), &attr);
    EXPECT_TRUE(rb == NULL);

    std::string name2 = "123456789012345678901234567890123";
    rb = TraceRbLogCreate(name2.c_str(), &attr);
    EXPECT_TRUE(rb == NULL);
}

TEST_F(RraceRbLogUtest, TestTraceRbLogCreateMallocFailed)
{
    MOCKER(AdiagMalloc).stubs().will(returnValue((void*)NULL));
    std::string name = "HCCL";
    TraceAttr attr = { 0 };
    attr.msgNum = 1024;
    attr.msgSize = 112;
    auto rb = TraceRbLogCreate(name.c_str(), &attr);
    EXPECT_TRUE(rb == NULL);
}

struct RbLog *GetDefaultRb()
{
    std::string name = "HCCL";
    TraceAttr attr = { 0 };
    attr.msgNum = 1024;
    attr.msgSize = 112;
    auto rb = TraceRbLogCreate(name.c_str(), &attr);
    EXPECT_TRUE(rb != NULL);
    return rb;
}

void FillBuffer(struct RbLog *rb)
{
    std::string buffer(rb->head.msgTxtSize, '*');
    auto ret = TraceRbLogWriteRbMsg(rb, 0, buffer.c_str(), buffer.length());
    EXPECT_EQ(ret, TRACE_SUCCESS);
    rb->head.writeIdx--;
}

TEST_F(RraceRbLogUtest, TestTraceRbLogWriteInvalidBufSize)
{
    auto rb = GetDefaultRb();

    std::string buffer(90, '*');
    auto ret = TraceRbLogWriteRbMsg(rb, 0, buffer.c_str(), 0);
    EXPECT_NE(ret, TRACE_SUCCESS);

    TraceRbLogDestroy(rb);
}

TEST_F(RraceRbLogUtest, TestTraceRbLogWriteInvalidBuffer)
{
    auto rb = GetDefaultRb();

    auto ret = TraceRbLogWriteRbMsg(rb, 0, NULL, 1);
    EXPECT_NE(ret, TRACE_SUCCESS);

    TraceRbLogDestroy(rb);
}

TEST_F(RraceRbLogUtest, TestTraceRbLogWriteMemcpyFailed)
{
    std::string buffer(90, '*');
    auto rb = GetDefaultRb();

    MOCKER(memcpy_s).stubs().will(returnValue(-1));
    auto ret = TraceRbLogWriteRbMsg(rb, 0, buffer.c_str(), buffer.length() + 1);
    EXPECT_NE(ret, TRACE_SUCCESS);

    TraceRbLogDestroy(rb);
}

TEST_F(RraceRbLogUtest, TestTraceRbLogCopyMemcpyFailed)
{
    auto rb = GetDefaultRb();

    MOCKER(memcpy_s).stubs().will(returnValue(-1));
    struct RbLog *newRb = NULL;
    auto ret = TraceRbLogGetCopyOfRingBuffer(&newRb, rb);
    EXPECT_NE(ret, TRACE_SUCCESS);

    TraceRbLogDestroy(rb);
}

TEST_F(RraceRbLogUtest, TestTraceRbLogCopyMemcpyFailed2)
{
    auto rb = GetDefaultRb();

    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(EOK))
        .then(returnValue(-1));
    struct RbLog *newRb = NULL;
    auto ret = TraceRbLogGetCopyOfRingBuffer(&newRb, rb);
    EXPECT_NE(ret, TRACE_SUCCESS);

    TraceRbLogDestroy(rb);
}

TEST_F(RraceRbLogUtest, TestTraceRbLogCopyMemcpyFailed3)
{
    std::string buffer(90, '*');
    auto rb = GetDefaultRb();

    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(EOK))
        .then(returnValue(EOK))
        .then(returnValue(-1));
    struct RbLog *newRb = NULL;
    auto ret = TraceRbLogGetCopyOfRingBuffer(&newRb, rb);
    EXPECT_NE(ret, TRACE_SUCCESS);

    TraceRbLogDestroy(rb);
}

TEST_F(RraceRbLogUtest, TestTraceRbLogWriteBufSizeLTMsgLength)
{
    auto rb = GetDefaultRb();
    FillBuffer(rb);

    std::string buffer("12345");
    uint32_t bufSize = 1;
    auto ret = TraceRbLogWriteRbMsg(rb, 0, buffer.c_str(), bufSize);
    EXPECT_EQ(ret, TRACE_SUCCESS);
    char *txt = NULL;
    char timestamp[TIMESTAMP_MAX_LENGTH] = {0};
    ret = TraceRbLogReadRbMsgSafe(rb, (char *)&timestamp, sizeof(timestamp), &txt);
    EXPECT_EQ(ret, TRACE_SUCCESS);
    EXPECT_STREQ(txt, "1");

    bufSize = 2;
    ret = TraceRbLogWriteRbMsg(rb, 0, buffer.c_str(), bufSize);
    EXPECT_EQ(ret, TRACE_SUCCESS);
    ret = TraceRbLogReadRbMsgSafe(rb, (char *)&timestamp, sizeof(timestamp), &txt);
    EXPECT_EQ(ret, TRACE_SUCCESS);
    EXPECT_STREQ(txt, buffer.substr(0, bufSize).c_str());

    TraceRbLogDestroy(rb);
}

TEST_F(RraceRbLogUtest, TestTraceRbLogWriteBufSizeEQMsgLength)
{
    auto rb = GetDefaultRb();
    FillBuffer(rb);

    std::string buffer("12345");
    auto ret = TraceRbLogWriteRbMsg(rb, 0, buffer.c_str(), buffer.length());
    EXPECT_EQ(ret, TRACE_SUCCESS);

    char *txt = NULL;
    char timestamp[TIMESTAMP_MAX_LENGTH] = {0};
    ret = TraceRbLogReadRbMsgSafe(rb, (char *)&timestamp, sizeof(timestamp), &txt);
    EXPECT_EQ(ret, TRACE_SUCCESS);
    EXPECT_STREQ(txt, buffer.substr(0, buffer.length()).c_str());

    TraceRbLogDestroy(rb);
}

TEST_F(RraceRbLogUtest, TestTraceRbLogWriteBufSizeEQMsgTxtSize)
{
    auto rb = GetDefaultRb();
    FillBuffer(rb);

    std::string buffer(rb->head.msgTxtSize, '#');
    auto ret = TraceRbLogWriteRbMsg(rb, 0, buffer.c_str(), buffer.length());
    EXPECT_EQ(ret, TRACE_SUCCESS);

    char *txt = NULL;
    char timestamp[TIMESTAMP_MAX_LENGTH] = {0};
    TraceRbLogPrepareForRead(rb);
    ret = TraceRbLogReadRbMsgSafe(rb, (char *)&timestamp, sizeof(timestamp), &txt);
    EXPECT_EQ(ret, TRACE_SUCCESS);
    ret = TraceRbLogReadRbMsgSafe(rb, (char *)&timestamp, sizeof(timestamp), &txt);
    EXPECT_EQ(ret, TRACE_RING_BUFFER_EMPTY);
    EXPECT_STREQ(txt, buffer.substr(0, buffer.length() - 1).c_str());

    TraceRbLogDestroy(rb);
}

TEST_F(RraceRbLogUtest, TestTraceRbLogWriteBufSizeGTMsgTxtSize)
{
    auto rb = GetDefaultRb();
    FillBuffer(rb);

    std::string buffer(rb->head.msgTxtSize + 1, '#');
    auto ret = TraceRbLogWriteRbMsg(rb, 0, buffer.c_str(), buffer.length());
    EXPECT_EQ(ret, TRACE_SUCCESS);

    char *txt = NULL;
    char timestamp[TIMESTAMP_MAX_LENGTH] = {0};
    ret = TraceRbLogReadRbMsg(rb, (char *)&timestamp, sizeof(timestamp), &txt);
    EXPECT_EQ(ret, TRACE_SUCCESS);
    EXPECT_STREQ(txt, buffer.substr(0, buffer.length() - 2).c_str());

    TraceRbLogDestroy(rb);
}

extern void RecordLog(int level, char *buffer);
TEST_F(RraceRbLogUtest, TestWriteBufferPress)
{
    int msgNum = 1;
    writeThreadNum_ = 2048;
    int expectResult = 0;
    // sleep in memcpy to let ring buffer be busy when submite msg
    MOCKER(RecordLog).stubs();
    // check ERROR msg print not more than once
    MOCKER(RecordLog).expects(atMost(1)).with(eq(DLOG_ERROR), any()); 

    EXPECT_TestLogRingBuffer(msgNum, expectResult, &TestWritePerf);
}

TEST_F(RraceRbLogUtest, TestTraceRbLogReadOriRbMsg)
{
    auto rb = GetDefaultRb();
    FillBuffer(rb);

    std::string buffer("12345");
    auto ret = TraceRbLogWriteRbMsg(rb, 0, buffer.c_str(), buffer.length());
    EXPECT_EQ(ret, TRACE_SUCCESS);

    char *txt = NULL;
    uint32_t len = 0;
    ret = TraceRbLogReadOriRbMsg(rb, &txt, &len);
    EXPECT_EQ(ret, TRACE_SUCCESS);
    txt[sizeof(RbMsgHead) + buffer.size()] = '\0';
    EXPECT_STREQ(txt + sizeof(RbMsgHead), buffer.c_str());

    TraceRbLogDestroy(rb);
}

TEST_F(RraceRbLogUtest, TestTraceRbLogReadOriRbMsgSafe)
{
    auto rb = GetDefaultRb();
    FillBuffer(rb);

    std::string buffer("12345");
    auto ret = TraceRbLogWriteRbMsg(rb, 0, buffer.c_str(), buffer.length());
    EXPECT_EQ(ret, TRACE_SUCCESS);

    char *txt = NULL;
    uint32_t len = 0;
    uint64_t cycle = 0;
    ret = TraceRbLogReadOriRbMsgSafe(rb, &txt, &len, &cycle);
    EXPECT_EQ(ret, TRACE_SUCCESS);
    txt[sizeof(RbMsgHead) + buffer.size()] = '\0';
    EXPECT_STREQ(txt + sizeof(RbMsgHead), buffer.c_str());

    TraceRbLogDestroy(rb);
}

struct RbLog *GetDefaultRbAttr(TraceStructEntry *en)
{
    std::string name = "HCCL";
    TraceAttr attr = { 0 };
    attr.msgNum = 1024;
    attr.msgSize = 112;
    
    TRACE_STRUCT_SET_ATTR(*en, 0, &attr);
    auto rb = TraceRbLogCreate(name.c_str(), &attr);
    EXPECT_TRUE(rb != NULL);
    return rb;
}

TEST_F(RraceRbLogUtest, TestTraceRbLogCopyEntryFailed)
{
    TRACE_STRUCT_DEFINE_ENTRY(en);
    TRACE_STRUCT_DEFINE_ENTRY_NAME(en, "demo");
    TRACE_STRUCT_DEFINE_FIELD_UINT32(en, tid, TRACE_STRUCT_SHOW_MODE_DEC);
    auto rb = GetDefaultRbAttr(&en);
    struct RbLog *newRb = NULL;

    MOCKER(mmMutexInit).stubs().will(returnValue(-1));
    auto ret = TraceRbLogGetCopyOfRingBuffer(&newRb, rb);
    EXPECT_NE(ret, TRACE_SUCCESS);

    size_t totalSize = sizeof(RbLog) + rb->head.bufSize * rb->head.msgSize;
    void *buffer = malloc(totalSize);
    MOCKER(AdiagMalloc).stubs().will(returnValue(buffer)).then(returnValue((void *)NULL));
    ret = TraceRbLogGetCopyOfRingBuffer(&newRb, rb);
    EXPECT_NE(ret, TRACE_SUCCESS);

    TraceRbLogDestroy(rb);
    TRACE_STRUCT_UNDEFINE_ENTRY(en);
}

TEST_F(RraceRbLogUtest, TestTraceRbLogCopyEntryListFailed)
{
    TRACE_STRUCT_DEFINE_ENTRY(en);
    TRACE_STRUCT_DEFINE_ENTRY_NAME(en, "demo");
    TRACE_STRUCT_DEFINE_FIELD_UINT32(en, tid, TRACE_STRUCT_SHOW_MODE_DEC);
    auto rb = GetDefaultRbAttr(&en);
    struct RbLog *newRb = NULL;

    size_t totalSize = sizeof(RbLog) + rb->head.bufSize * rb->head.msgSize;
    void *buffer1 = malloc(totalSize);
    void *buffer2 = malloc(sizeof(struct AdiagList));
    MOCKER(AdiagMalloc).stubs().will(returnValue(buffer1)).then(returnValue(buffer2)).then(returnValue((void *)NULL));
    auto ret = TraceRbLogGetCopyOfRingBuffer(&newRb, rb);
    EXPECT_NE(ret, TRACE_SUCCESS);

    TraceRbLogDestroy(rb);
    TRACE_STRUCT_UNDEFINE_ENTRY(en);
}

TEST_F(RraceRbLogUtest, TestTraceRbLogCopyEntryListMallocFailed)
{
    TRACE_STRUCT_DEFINE_ENTRY(en);
    TRACE_STRUCT_DEFINE_ENTRY_NAME(en, "demo");
    TRACE_STRUCT_DEFINE_FIELD_UINT32(en, tid, TRACE_STRUCT_SHOW_MODE_DEC);
    auto rb = GetDefaultRbAttr(&en);
    struct RbLog *newRb = NULL;

    size_t totalSize = sizeof(RbLog) + rb->head.bufSize * rb->head.msgSize;
    void *buffer1 = malloc(totalSize);
    void *buffer2 = malloc(sizeof(struct AdiagList));
    void *buffer3 = malloc(sizeof(TraceStructField));
    MOCKER(AdiagMalloc).stubs()
        .will(returnValue(buffer1))
        .then(returnValue(buffer2))
        .then(returnValue(buffer3))
        .then(returnValue((void *)NULL));
    auto ret = TraceRbLogGetCopyOfRingBuffer(&newRb, rb);
    EXPECT_NE(ret, TRACE_SUCCESS);

    TraceRbLogDestroy(rb);
    TRACE_STRUCT_UNDEFINE_ENTRY(en);
}

TEST_F(RraceRbLogUtest, TestTraceRbLogCreateInvalid)
{
    TraceAttr attr = { 0 };
    attr.exitSave = true;
    attr.msgSize = 0;
    attr.msgNum = DEFAULT_ATRACE_MSG_NUM;
    TracerType tracerType = TRACER_TYPE_SCHEDULE;
    const char objName[] = "HCCL";
    std::vector<std::pair<uint16_t, uint16_t>> attrList = {
        {63, DEFAULT_ATRACE_MSG_NUM},
        {1025, DEFAULT_ATRACE_MSG_NUM},
        {DEFAULT_ATRACE_MSG_SIZE, 1025},
        {113, 1024},
        {1024, 1024}
        };
    for (auto item : attrList) {
        attr.msgSize = item.first;
        attr.msgNum = item.second;
        EXPECT_EQ((struct RbLog *)NULL, TraceRbLogCreate(objName, &attr));
    }
}

TEST_F(RraceRbLogUtest, TestTraceRbLogCreateStrcpyFailed)
{
    MOCKER(strcpy_s).stubs().will(returnValue(EOK + 1));
    std::string name = "HCCL";
    TraceAttr attr = { 0 };
    attr.msgNum = 1024;
    attr.msgSize = 112;

    auto rb = TraceRbLogCreate(name.c_str(), &attr);
    EXPECT_EQ((struct RbLog *)NULL, rb);
}