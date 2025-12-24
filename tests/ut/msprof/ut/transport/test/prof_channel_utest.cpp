/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <pthread.h>
#include <errno.h>
#include <strings.h>
#include <string.h>
#include <memory>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "prof_channel.h"
#include "collection_entry.h"
#include "uploader_mgr.h"

using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Statistics;
using namespace Analysis::Dvvp::MsprofErrMgr;
#define MAX_BUFFER_SIZE (1024 * 1024 * 2)
#define MAX_THRESHOLD_SIZE (MAX_BUFFER_SIZE * 0.8)
class TRANSPORT_PROF_CHANNELREADER_UTEST: public testing::Test {
protected:
    virtual void SetUp() {
        std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx(
            new analysis::dvvp::message::JobContext);
        _job_ctx = jobCtx;
    }
    virtual void TearDown() {
    }
public:
    std::shared_ptr<analysis::dvvp::message::JobContext> _job_ctx;
    void EXPECT_HashIdDiff(analysis::dvvp::driver::AI_DRV_CHANNEL channel1,
        analysis::dvvp::driver::AI_DRV_CHANNEL channel2);
};

TEST_F(TRANSPORT_PROF_CHANNELREADER_UTEST, Execute) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::transport::ChannelReader> reader(
        new analysis::dvvp::transport::ChannelReader(
            0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU, "data/ts.12.0.0",
            _job_ctx));

    reader->Init();
    MOCKER(&analysis::dvvp::driver::DrvChannelRead)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(64))
        .then(returnValue(0));

    MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::UploadData,
        int(analysis::dvvp::transport::UploaderMgr::*)(const std::string &, const void *, uint32_t))
        .stubs()
        .will(returnValue(PROFILING_FAILED));

    reader->dataSize_ = MAX_THRESHOLD_SIZE + 1;

    EXPECT_EQ(PROFILING_SUCCESS, reader->Execute());
    EXPECT_EQ(PROFILING_SUCCESS, reader->Execute());
    EXPECT_EQ(PROFILING_SUCCESS, reader->Execute());

    reader->UploadData();

    reader->SetChannelStopped();
    EXPECT_EQ(PROFILING_SUCCESS, reader->Execute());

    reader.reset();
}

TEST_F(TRANSPORT_PROF_CHANNELREADER_UTEST, HashId) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::transport::ChannelReader> reader(
        new analysis::dvvp::transport::ChannelReader(
            0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU, "data/ts.12.0.0",
            _job_ctx));
    reader->Init();

    EXPECT_NE((size_t)0, reader->HashId());

    reader.reset();
}

void TRANSPORT_PROF_CHANNELREADER_UTEST::EXPECT_HashIdDiff(analysis::dvvp::driver::AI_DRV_CHANNEL channel1,
    analysis::dvvp::driver::AI_DRV_CHANNEL channel2)
{
    std::shared_ptr<analysis::dvvp::transport::ChannelReader> reader1(
        new analysis::dvvp::transport::ChannelReader(0, channel1, "tmp", _job_ctx));
    std::shared_ptr<analysis::dvvp::transport::ChannelReader> reader2(
        new analysis::dvvp::transport::ChannelReader(0, channel2, "tmp", _job_ctx));
    reader1->Init();
    reader2->Init();
    uint32_t threadNum = 4;  // default
    EXPECT_NE(reader1->HashId() % threadNum, reader2->HashId() % threadNum);
    threadNum = 8;  // ai server
    EXPECT_NE(reader1->HashId() % threadNum, reader2->HashId() % threadNum);
}

TEST_F(TRANSPORT_PROF_CHANNELREADER_UTEST, HashIdDifferent) {
    // milan
    EXPECT_HashIdDiff(analysis::dvvp::driver::PROF_CHANNEL_STARS_SOC_LOG, analysis::dvvp::driver::PROF_CHANNEL_FFTS_PROFILE_TASK);
    EXPECT_HashIdDiff(analysis::dvvp::driver::PROF_CHANNEL_STARS_SOC_LOG, analysis::dvvp::driver::PROF_CHANNEL_TS_FW);
    EXPECT_HashIdDiff(analysis::dvvp::driver::PROF_CHANNEL_STARS_SOC_LOG, analysis::dvvp::driver::PROF_CHANNEL_LP);
    EXPECT_HashIdDiff(analysis::dvvp::driver::PROF_CHANNEL_FFTS_PROFILE_TASK, analysis::dvvp::driver::PROF_CHANNEL_TS_FW);
    EXPECT_HashIdDiff(analysis::dvvp::driver::PROF_CHANNEL_FFTS_PROFILE_TASK, analysis::dvvp::driver::PROF_CHANNEL_LP);
    GlobalMockObject::verify();
}

////////////////////////////////////////////////////////////////////
TEST_F(TRANSPORT_PROF_CHANNELREADER_UTEST, SetChannelStopped) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::transport::ChannelReader::UploadData)
        .stubs();

    std::shared_ptr<analysis::dvvp::transport::ChannelReader> reader(
        new analysis::dvvp::transport::ChannelReader(
            0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU, "data/ts.12.0.0",
            _job_ctx));
    EXPECT_EQ(PROFILING_SUCCESS, reader->Init());
    reader->dataSize_ = 10;
    reader->SetChannelStopped();
    reader.reset();
}

TEST_F(TRANSPORT_PROF_CHANNELREADER_UTEST, UploadData) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::transport::ChannelReader::UploadData)
        .stubs();

    std::shared_ptr<analysis::dvvp::transport::ChannelReader> reader(
        new analysis::dvvp::transport::ChannelReader(
            0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU, "data/ts.12.0.0",
            _job_ctx));
    EXPECT_EQ(PROFILING_SUCCESS, reader->Init());
    reader->dataSize_ = 0;
    reader->UploadData();

    reader->dataSize_ = 10;
    reader->UploadData();
}

TEST_F(TRANSPORT_PROF_CHANNELREADER_UTEST, FlushDrvBuff) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::transport::ChannelReader::UploadData)
        .stubs();

    MOCKER(&analysis::dvvp::driver::DrvProfFlush)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    
    std::shared_ptr<analysis::dvvp::transport::ChannelReader> reader(
        new analysis::dvvp::transport::ChannelReader(
            0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU, "data/ts.12.0.0",
            _job_ctx));
    EXPECT_EQ(PROFILING_SUCCESS, reader->Init());
    reader->FlushDrvBuff();
    reader->channelId_ = analysis::dvvp::driver::PROF_CHANNEL_HWTS_LOG;
    reader->FlushDrvBuff();
    reader->FlushDrvBuff();
    reader->needWait_ = true;
    reader->CheckIfSendFlush(0);
}

void *ThreadRun(void *data)
{
    auto reader = reinterpret_cast<analysis::dvvp::transport::ChannelReader *>(data);
    while(reader->flushBufSize_ == 0) {
        sleep(1);
    }
    reader->SendFlushFinished();
    pthread_exit(NULL);
}

TEST_F(TRANSPORT_PROF_CHANNELREADER_UTEST, FlushDrvBuff2) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::transport::ChannelReader::UploadData)
        .stubs();
    unsigned int flushsize = 100;
    MOCKER(&analysis::dvvp::driver::DrvProfFlush)
        .stubs()
        .with(any(), any(), outBound(flushsize))
        .will(returnValue(PROFILING_SUCCESS));
    analysis::dvvp::transport::ChannelReader *reader(
        new analysis::dvvp::transport::ChannelReader(
            0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU, "data/ts.12.0.0",
            _job_ctx));
    EXPECT_EQ(PROFILING_SUCCESS, reader->Init());
    reader->flushBufSize_ = 0;
    reader->channelId_ = analysis::dvvp::driver::PROF_CHANNEL_HWTS_LOG;
    pthread_t threadId;
    pthread_create(&threadId, NULL, ThreadRun, reinterpret_cast<void *>(reader));
    reader->FlushDrvBuff();
    delete reader;
}

class TRANSPORT_PROF_CHANNELPOLL_UTEST: public testing::Test {
protected:
    virtual void SetUp() {
        _job_ctx = std::make_shared<analysis::dvvp::message::JobContext>();
    }
    virtual void TearDown() {
    }
public:
    std::shared_ptr<analysis::dvvp::message::JobContext> _job_ctx;
};

TEST_F(TRANSPORT_PROF_CHANNELPOLL_UTEST, AddReader) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::transport::ChannelPoll> poll(
        new analysis::dvvp::transport::ChannelPoll());

    std::shared_ptr<analysis::dvvp::transport::ChannelReader> reader(
        new analysis::dvvp::transport::ChannelReader(
            0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU, "data/ts.12.0.0",
            _job_ctx));
    reader->Init();

    EXPECT_EQ(PROFILING_SUCCESS, poll->AddReader(0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU, reader));
    EXPECT_NE(nullptr, poll->GetReader(0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU).get());

    poll.reset();
}

TEST_F(TRANSPORT_PROF_CHANNELPOLL_UTEST, RemoveReader) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::transport::ChannelPoll> poll(
        new analysis::dvvp::transport::ChannelPoll());

    std::shared_ptr<analysis::dvvp::transport::ChannelReader> reader(
        new analysis::dvvp::transport::ChannelReader(
            0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU, "data/ts.12.0.0",
            _job_ctx));
    reader->Init();

    EXPECT_EQ(PROFILING_SUCCESS, poll->AddReader(0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU, reader));
    EXPECT_NE(nullptr, poll->GetReader(0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU).get());

    EXPECT_EQ(PROFILING_SUCCESS, poll->RemoveReader(0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU));
    EXPECT_EQ(nullptr, poll->GetReader(0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU).get());

    poll.reset();
}

TEST_F(TRANSPORT_PROF_CHANNELPOLL_UTEST, DispatchChannel) {
    GlobalMockObject::verify();

    //not start
    std::shared_ptr<analysis::dvvp::transport::ChannelPoll> poll(
        new analysis::dvvp::transport::ChannelPoll());

    EXPECT_EQ(PROFILING_FAILED, poll->DispatchChannel(0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU));

    MOCKER(&analysis::dvvp::driver::DrvGetDevNum)
        .stubs()
        .will(returnValue(1));
    //post start
    poll->Start();
    EXPECT_EQ(PROFILING_FAILED, poll->DispatchChannel(0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU));

    //find reader
    std::shared_ptr<analysis::dvvp::transport::ChannelReader> reader(
        new analysis::dvvp::transport::ChannelReader(
            0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU, "data/ts.12.0.0",
            _job_ctx));
    reader->Init();
    poll->AddReader(0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU, reader);
    reader->SetSchedulingStatus(true);
    EXPECT_EQ(PROFILING_SUCCESS, poll->DispatchChannel(0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU));
    reader->SetSchedulingStatus(false);
    EXPECT_EQ(PROFILING_SUCCESS, poll->DispatchChannel(0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU));
    poll.reset();
}

TEST_F(TRANSPORT_PROF_CHANNELPOLL_UTEST, FlushAllChannels) {
    GlobalMockObject::verify();

        //not start
    std::shared_ptr<analysis::dvvp::transport::ChannelPoll> poll(
        new analysis::dvvp::transport::ChannelPoll());

    MOCKER(&analysis::dvvp::driver::DrvGetDevNum)
        .stubs()
        .will(returnValue(1));
    //post start
    poll->Start();

    std::shared_ptr<analysis::dvvp::transport::ChannelReader> reader(
        new analysis::dvvp::transport::ChannelReader(
            0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU, "data/ts.12.0.0",
            _job_ctx));
    reader->Init();

    EXPECT_EQ(PROFILING_SUCCESS, poll->AddReader(0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU, reader));
    EXPECT_NE(nullptr, poll->GetReader(0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU).get());

    poll.reset();
}

TEST_F(TRANSPORT_PROF_CHANNELPOLL_UTEST, start) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::transport::ChannelPoll> poll(
        new analysis::dvvp::transport::ChannelPoll());

    EXPECT_EQ(PROFILING_SUCCESS, poll->Start());
    EXPECT_TRUE(poll->isStart_);

    poll.reset();
}

TEST_F(TRANSPORT_PROF_CHANNELPOLL_UTEST, stop) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::transport::ChannelPoll> poll(
        new analysis::dvvp::transport::ChannelPoll());

    poll->Start();
    EXPECT_EQ(PROFILING_SUCCESS, poll->Stop());
    EXPECT_FALSE(poll->isStart_);

    poll.reset();
}

TEST_F(TRANSPORT_PROF_CHANNELPOLL_UTEST, run) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::transport::ChannelPoll> poll(
        new analysis::dvvp::transport::ChannelPoll());
    EXPECT_NE(nullptr, poll);

    poll->isStart_= true;
    MOCKER(&analysis::dvvp::driver::DrvChannelPoll)
        .stubs()
        .will(returnValue(-4))
        .then(returnValue(6))
        .then(returnValue(-1));

    MOCKER_CPP(&analysis::dvvp::transport::ChannelPoll::DispatchChannel)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    auto errorContext = MsprofErrorManager::instance()->GetErrorManagerContext();
    poll->Run(errorContext);
    poll->isStart_=false;
    EXPECT_EQ(3, poll->pollCount_);
    EXPECT_EQ(1, poll->pollSleepCount_);
    EXPECT_EQ(1, poll->dispatchCount_);
    EXPECT_EQ(6, poll->dispatchChannelCount_);
    poll.reset();
}

TEST_F(TRANSPORT_PROF_CHANNELPOLL_UTEST, run_quit) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::transport::ChannelPoll> poll(
        new analysis::dvvp::transport::ChannelPoll());

    MOCKER(&analysis::dvvp::driver::DrvChannelPoll)
        .stubs()
        .will(returnValue(0));

    EXPECT_EQ(PROFILING_SUCCESS, poll->Start());
    EXPECT_EQ(PROFILING_SUCCESS, poll->Stop());

    poll.reset();
}

TEST_F(TRANSPORT_PROF_CHANNELPOLL_UTEST, ChannelBufferBase) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::transport::ChannelBuffer> threadBuffer(
        new analysis::dvvp::transport::ChannelBuffer());
    std::string buffer;
    threadBuffer->SwapChannelBuffer(buffer);
    EXPECT_EQ(PROFILING_SUCCESS, threadBuffer->Start());
    uint32_t sleepCount = 0;
    while (threadBuffer->preBufferQueue_.size() == 0 && sleepCount < 1000) {
        analysis::dvvp::common::utils::Utils::UsleepInterupt(1000);
        sleepCount++;
    }
    threadBuffer->SwapChannelBuffer(buffer);
    EXPECT_EQ(PROFILING_SUCCESS, threadBuffer->Stop());
    threadBuffer.reset();
}
