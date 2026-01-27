/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include<iostream>
#include<stdint.h>
#include<unistd.h>
#include<sys/socket.h>
#include <errno.h>
#include"gtest/gtest.h"
#include"mockcpp/mockcpp.hpp"
#include "platform/platform.h"
#include"errno/error_code.h"
#include"select_operation.h"
#include "message/prof_params.h"
#include "securec.h"
#include "sender.h"

using namespace std;
using namespace analysis::dvvp::streamio::client;
using namespace analysis::dvvp::streamio::common;
using namespace analysis::dvvp::common::error;

class PROFILER_SENDER_TEST: public testing::Test {

public:
    std::string engine_name = "profiling";
    std::string address = "profiling";
    string job_ctx_json = "{\"dev_id\":\"0\",\"job_id\":\"c835ed1c-7575-11e8-a10d-0242ac110002\",\"result_dir\":\"/tmp/profiler/c835ed1c-7575-11e8-a10d-0242ac110002\",\"tag\":\"\"}";
    string job_ctx_json_file_mode = "{\"dev_id\":\"0\",\"job_id\":\"c835ed1c-7575-11e8-a10d-0242ac110002\",\"result_dir\":\"/tmp/profiler/c835ed1c-7575-11e8-a10d-0242ac110002\",\"tag\":\"\",\"stream_enabled\":\"off\"}";
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

void mock_return_void()
{
    return;
}

TEST_F(PROFILER_SENDER_TEST, Init)
{
    GlobalMockObject::verify();
    auto chunkPool = std::make_shared<analysis::dvvp::common::memory::ChunkPool>(1, 16);
    Sender sender(nullptr, "profiling", chunkPool);

    EXPECT_EQ(PROFILING_SUCCESS, sender.Init());
    sender.Uninit();

    char buf[2] = {0};

    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, sender.Init());
    sender.Uninit();
}

TEST_F(PROFILER_SENDER_TEST, Flush)
{
    GlobalMockObject::verify();
    auto chunkPool = std::make_shared<analysis::dvvp::common::memory::ChunkPool>(1, 16);
    EXPECT_NE(nullptr, chunkPool);
    Sender sender(nullptr, "profiling", chunkPool);
    EXPECT_EQ(PROFILING_SUCCESS, sender.Init());

    MOCKER_CPP(&Sender::FlushFileCache)
        .stubs()
        .will(ignoreReturnValue());

    MOCKER_CPP(&Sender::WaitEmpty)
        .stubs()
        .will(ignoreReturnValue());

    MOCKER_CPP(&Sender::CloseFileFds)
        .stubs()
        .will(ignoreReturnValue());

    sender.Flush();
    sender.Uninit();
}

TEST_F(PROFILER_SENDER_TEST, FlushFileCache)
{
    GlobalMockObject::verify();
    auto chunkPool = std::make_shared<analysis::dvvp::common::memory::ChunkPool>(1, 16);
    EXPECT_EQ(true, chunkPool->Init());
    auto chunk = chunkPool->Alloc();
    auto file = std::make_shared<File>(chunkPool, chunk, job_ctx_json, "file_name");
    EXPECT_EQ(PROFILING_SUCCESS, file->Init());
    Sender sender(nullptr, "profiling", chunkPool);
    EXPECT_EQ(PROFILING_SUCCESS, sender.Init());

    MOCKER_CPP(&Sender::DispatchFile)
        .stubs()
        .will(invoke(mock_return_void));

    sender.FlushFileCache();
    file->Uinit();
    sender.Uninit();
    chunkPool->Uninit();
}

TEST_F(PROFILER_SENDER_TEST, GetMutexByFileName)
{
    GlobalMockObject::verify();
    auto chunkPool = std::make_shared<analysis::dvvp::common::memory::ChunkPool>(1, 16);
    chunkPool->Init();
    Sender sender(nullptr, "profiling", chunkPool);
    sender.Init();

    auto file_name_lock = std::make_shared<std::mutex>();
    sender.fileMutexMap_["file_name"] = file_name_lock;
    EXPECT_EQ(file_name_lock, sender.GetMutexByFileName("file_name"));

    sender.fileMutexMap_.clear();
    EXPECT_NE(file_name_lock, sender.GetMutexByFileName("file_name"));

    sender.Uninit();
    chunkPool->Uninit();
}

TEST_F(PROFILER_SENDER_TEST, DispatchFile)
{
    GlobalMockObject::verify();
    auto chunkPool = std::make_shared<analysis::dvvp::common::memory::ChunkPool>(1, 16);
    EXPECT_EQ(true, chunkPool->Init());
    auto chunk = chunkPool->Alloc();
    auto file = std::make_shared<File>(chunkPool, chunk, job_ctx_json, "file_name");
    EXPECT_EQ(PROFILING_SUCCESS, file->Init());
    auto sender = std::make_shared<Sender>(nullptr, "profiling", chunkPool);
    EXPECT_EQ(PROFILING_SUCCESS, sender->Init());

    MOCKER_CPP(&FileQueue::Push)
        .stubs()
        .will(returnValue(true));

    MOCKER_CPP(&SenderPool::Dispatch)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&Sender::WaitEmpty)
        .stubs();

    sender->DispatchFile(file);
    sender->isFinished_ = true;
    //file->Uinit();
    //sender.Uninit();
    //chunkPool->Uninit();
}

TEST_F(PROFILER_SENDER_TEST, WaitEmpty)
{
    GlobalMockObject::verify();
    auto chunkPool = std::make_shared<analysis::dvvp::common::memory::ChunkPool>(1, 16);
    EXPECT_EQ(true, chunkPool->Init());
    Sender sender(nullptr, "profiling", chunkPool);
    EXPECT_EQ(PROFILING_SUCCESS, sender.Init());
    sender.isFinished_ = true;

    sender.WaitEmpty();
    sender.Uninit();
    chunkPool->Uninit();
}

TEST_F(PROFILER_SENDER_TEST, save_file_data_failed)
{
    GlobalMockObject::verify();
    auto chunkPool = std::make_shared<analysis::dvvp::common::memory::ChunkPool>(2, 16);
    chunkPool->Init();
    Sender sender(nullptr, "profiling", chunkPool);
    sender.Init();
    auto chunk = chunkPool->Alloc();
    auto file = std::make_shared<File>(chunkPool, chunk, job_ctx_json, "file_name");
    file->Init();

    struct DataChunk data;
    data.relativeFileName = "file_name";
    unsigned char buf[8] = {0};
    data.dataBuf = buf;
    data.bufLen = 8;

    MOCKER_CPP(&Sender::InitNewCustomFile)
        .stubs()
        //.with(any())
        .will(returnValue((std::shared_ptr<File>)NULL));

    EXPECT_EQ(PROFILING_FAILED, sender.SaveFileData(job_ctx_json, data));
    file->Uinit();
    sender.Uninit();
    chunkPool->Uninit();
}

TEST_F(PROFILER_SENDER_TEST, SaveFileData)
{
    GlobalMockObject::verify();
    auto chunkPool = std::make_shared<analysis::dvvp::common::memory::ChunkPool>(2, 16);
    chunkPool->Init();
    Sender sender(nullptr, "profiling", chunkPool);
    sender.Init();
    auto chunk = chunkPool->Alloc();
    auto file = std::make_shared<File>(chunkPool, chunk, job_ctx_json, "file_name");
    file->Init();

    struct DataChunk data;
    data.relativeFileName = "file_name";
    unsigned char buf[8] = {0};
    data.dataBuf = buf;
    data.bufLen = 8;

    MOCKER_CPP(&Sender::DispatchFile)
        .stubs()
        .will(invoke(mock_return_void));

    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(EOF))
        .then(returnValue(EOK));

    EXPECT_EQ(PROFILING_FAILED, sender.SaveFileData(job_ctx_json, data));
    EXPECT_EQ(PROFILING_SUCCESS, sender.SaveFileData(job_ctx_json, data));
    EXPECT_EQ(PROFILING_SUCCESS, sender.SaveFileData(job_ctx_json, data));
    file->Uinit();
    sender.Uninit();
    chunkPool->Uninit();
}

TEST_F(PROFILER_SENDER_TEST, save_file_data_not_enough)
{
    GlobalMockObject::verify();
    auto chunkPool = std::make_shared<analysis::dvvp::common::memory::ChunkPool>(4, 16);
    chunkPool->Init();
    Sender sender(nullptr, "profiling", chunkPool);
    sender.Init();
    auto chunk1 = chunkPool->Alloc();
    auto file1 = std::make_shared<File>(chunkPool, chunk1, job_ctx_json, "file_name");
    file1->Init();
    auto chunk2 = chunkPool->Alloc();
    auto file2 = std::make_shared<File>(chunkPool, chunk2, job_ctx_json, "file_name");
    file2->Init();
    auto chunk3 = chunkPool->Alloc();
    auto file3 = std::make_shared<File>(chunkPool, chunk3, job_ctx_json, "file_name");
    file3->Init();
    auto chunk4 = chunkPool->Alloc();
    auto file4 = std::make_shared<File>(chunkPool, chunk4, job_ctx_json, "file_name");
    file4->Init();

    struct DataChunk data;
    data.relativeFileName = "file_name";
    unsigned char buf[24] = {0};
    data.dataBuf = buf;
    data.bufLen = 24;

    MOCKER_CPP(&Sender::DispatchFile)
        .stubs()
        .will(invoke(mock_return_void));

    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(EOF))
        .then(returnValue(EOK));

    EXPECT_EQ(PROFILING_FAILED, sender.SaveFileData(job_ctx_json, data));
    EXPECT_EQ(PROFILING_SUCCESS, sender.SaveFileData(job_ctx_json, data));
    file1->Uinit();
    file2->Uinit();
    sender.Uninit();
    chunkPool->Uninit();
}

TEST_F(PROFILER_SENDER_TEST, CloseFileFds)
{
    GlobalMockObject::verify();
    auto chunkPool = std::make_shared<analysis::dvvp::common::memory::ChunkPool>(1, 16);
    EXPECT_EQ(true, chunkPool->Init());
    Sender sender(nullptr, "profiling", chunkPool);
    EXPECT_EQ(PROFILING_SUCCESS, sender.Init());
    sender.fileFdMap_["file_name"] = 5;

    MOCKER(mmClose)
        .stubs()
        .will(returnValue(EN_OK));

    sender.CloseFileFds();
    sender.Uninit();
    chunkPool->Uninit();
}

TEST_F(PROFILER_SENDER_TEST, OpenWriteFile)
{
    GlobalMockObject::verify();
    auto chunkPool = std::make_shared<analysis::dvvp::common::memory::ChunkPool>(1, 16);
    chunkPool->Init();
    Sender sender(nullptr, "profiling", chunkPool);
    sender.Init();
    sender.fileFdMap_["file_name"] = 5;

    MOCKER(analysis::dvvp::common::utils::Utils::CreateDir)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER(mmOpen2)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(7));

    EXPECT_EQ(-1, sender.OpenWriteFile("file_name"));
    EXPECT_EQ(-1, sender.OpenWriteFile("file_name"));
    EXPECT_EQ(7, sender.OpenWriteFile("file_name"));
    sender.Uninit();
    chunkPool->Uninit();
}

TEST_F(PROFILER_SENDER_TEST, GetFileFd)
{
    GlobalMockObject::verify();
    auto chunkPool = std::make_shared<analysis::dvvp::common::memory::ChunkPool>(1, 16);
    chunkPool->Init();
    Sender sender(nullptr, "profiling", chunkPool);
    sender.Init();

    EXPECT_EQ(-1, sender.GetFileFd("file_name"));
    sender.SetFileFd("file_name", 7);
    EXPECT_EQ(7, sender.GetFileFd("file_name"));
    sender.Uninit();
    chunkPool->Uninit();
}

TEST_F(PROFILER_SENDER_TEST, Send)
{
    GlobalMockObject::verify();
    auto chunkPool = std::make_shared<analysis::dvvp::common::memory::ChunkPool>(1, 16);
    chunkPool->Init();
    Sender sender(nullptr, "profiling", chunkPool);
    struct DataChunk data;
    EXPECT_EQ(PROFILING_FAILED, sender.Send(job_ctx_json, data));
    sender.Init();

    MOCKER_CPP(&Sender::SaveFileData)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(PROFILING_SUCCESS, sender.Send(job_ctx_json, data));
    sender.Uninit();
    chunkPool->Uninit();
}

TEST_F(PROFILER_SENDER_TEST, SendData)
{
    GlobalMockObject::verify();
    auto chunkPool = std::make_shared<analysis::dvvp::common::memory::ChunkPool>(1, 16);
    chunkPool->Init();
    Sender sender(nullptr, "profiling", chunkPool);
    sender.Init();

    char buf[24] = {0};

    MOCKER(mmSocketSend)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(7));

    EXPECT_EQ(0, sender.SendData(buf, 7));
    EXPECT_EQ(0, sender.SendData(buf, 7));
    sender.Uninit();
    chunkPool->Uninit();
}

TEST_F(PROFILER_SENDER_TEST, EncodeData)
{
    GlobalMockObject::verify();
    auto chunkPool = std::make_shared<analysis::dvvp::common::memory::ChunkPool>(1, 16);
    EXPECT_EQ(true, chunkPool->Init());
    Sender sender(nullptr, "profiling", chunkPool);
    EXPECT_EQ(PROFILING_SUCCESS, sender.Init());
    auto chunk = chunkPool->Alloc();
    auto file = std::make_shared<File>(chunkPool, chunk, job_ctx_json, "file_name");
    EXPECT_EQ(PROFILING_SUCCESS, file->Init());

    EXPECT_NE(nullptr, sender.EncodeData(file));
    file->Uinit();
    sender.Uninit();
    chunkPool->Uninit();
}

TEST_F(PROFILER_SENDER_TEST, ExecuteStreamMode)
{
    GlobalMockObject::verify();
    auto chunkPool = std::make_shared<analysis::dvvp::common::memory::ChunkPool>(1, 16);
    EXPECT_EQ(true, chunkPool->Init());
    Sender sender(nullptr, "profiling", chunkPool);
    EXPECT_EQ(PROFILING_SUCCESS, sender.Init());
    auto chunk = chunkPool->Alloc();
    auto file = std::make_shared<File>(chunkPool, chunk, job_ctx_json, "file_name");
    EXPECT_EQ(PROFILING_SUCCESS, file->Init());

    std::shared_ptr<std::string> encode;
    encode = std::make_shared<std::string>("1234567890");

    MOCKER_CPP(&Sender::EncodeData)
        .stubs()
        .will(returnValue(encode));

    MOCKER_CPP(&Sender::SendData)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(9));

    sender.ExecuteStreamMode(file);
    sender.ExecuteStreamMode(file);
    sender.ExecuteStreamMode(file);
    file->Uinit();
    sender.Uninit();
    chunkPool->Uninit();
}

TEST_F(PROFILER_SENDER_TEST, Execute_stream_mode_not_enough)
{
    GlobalMockObject::verify();
    auto chunkPool = std::make_shared<analysis::dvvp::common::memory::ChunkPool>(1, 16);
    EXPECT_EQ(true, chunkPool->Init());
    Sender sender(nullptr, "profiling", chunkPool);
    EXPECT_EQ(PROFILING_SUCCESS, sender.Init());
    auto chunk = chunkPool->Alloc();
    auto file = std::make_shared<File>(chunkPool, chunk, job_ctx_json, "file_name");
    EXPECT_EQ(PROFILING_SUCCESS, file->Init());

	std::shared_ptr<std::string> encode;
	encode = std::make_shared<std::string>("1234567890");

    MOCKER_CPP(&Sender::EncodeData)
        .stubs()
        .will(returnValue(encode));

    MOCKER_CPP(&Sender::SendData)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(0))
        .then(returnValue(8));

    sender.ExecuteStreamMode(file);
    sender.ExecuteStreamMode(file);
    file->Uinit();
    sender.Uninit();
    chunkPool->Uninit();
}

TEST_F(PROFILER_SENDER_TEST, ExecuteFileMode)
{
    GlobalMockObject::verify();
    auto chunkPool = std::make_shared<analysis::dvvp::common::memory::ChunkPool>(1, 16);
    EXPECT_EQ(true, chunkPool->Init());
    Sender sender(nullptr, "profiling", chunkPool);
    EXPECT_EQ(PROFILING_SUCCESS, sender.Init());
    auto chunk = chunkPool->Alloc();
    auto file = std::make_shared<File>(chunkPool, chunk, job_ctx_json, "file_name");
    EXPECT_EQ(PROFILING_SUCCESS, file->Init());

    MOCKER_CPP(&Sender::GetFileFd)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(7));

    MOCKER_CPP(&Sender::OpenWriteFile)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(7));

    MOCKER(mmWrite)
        .stubs()
        .will(returnValue(-1));

    sender.ExecuteFileMode(file);
    sender.ExecuteFileMode(file);

    file->Uinit();
    sender.Uninit();
    chunkPool->Uninit();
}

TEST_F(PROFILER_SENDER_TEST, Execute)
{
    GlobalMockObject::verify();
    auto chunkPool = std::make_shared<analysis::dvvp::common::memory::ChunkPool>(1, 16);
    chunkPool->Init();
    Sender sender(nullptr, "profiling", chunkPool);
    sender.Init();
    auto chunk = chunkPool->Alloc();
    auto file = std::make_shared<File>(chunkPool, chunk, job_ctx_json, "file_name");
    file->Init();

    EXPECT_EQ(PROFILING_FAILED, sender.Execute());

    MOCKER_CPP(&File::IsStreamMode)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));

    MOCKER_CPP(&Sender::ExecuteStreamMode)
        .stubs()
        .will(invoke(mock_return_void));

    MOCKER_CPP(&Sender::ExecuteFileMode)
        .stubs()
        .will(invoke(mock_return_void));

    file->mode_ = analysis::dvvp::streamio::common::STREAM_MODE;
    sender.fileQueue_->Push(file);
    EXPECT_EQ(PROFILING_SUCCESS, sender.Execute());
    file->mode_ = analysis::dvvp::streamio::common::FILE_MODE;
    sender.fileQueue_->Push(file);
    EXPECT_EQ(PROFILING_SUCCESS, sender.Execute());

    file->Uinit();
    sender.Uninit();
    chunkPool->Uninit();
}

TEST_F(PROFILER_SENDER_TEST, HashId)
{
    GlobalMockObject::verify();
    auto chunkPool = std::make_shared<analysis::dvvp::common::memory::ChunkPool>(1, 16);
    chunkPool->Init();
    Sender sender(nullptr, "profiling", chunkPool);
    sender.Init();
    sender.hashId_ = 0;

    EXPECT_EQ(0, sender.HashId());

    sender.Uninit();
    chunkPool->Uninit();
}

TEST_F(PROFILER_SENDER_TEST, sender_pool_init)
{
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::common::thread::ThreadPool::Start)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(PROFILING_FAILED, SenderPool::instance()->Init());
    EXPECT_EQ(PROFILING_SUCCESS, SenderPool::instance()->Init());
    EXPECT_EQ(PROFILING_SUCCESS, SenderPool::instance()->Init());

    SenderPool::instance()->Uninit();
}

TEST_F(PROFILER_SENDER_TEST, sender_pool_dispatch)
{
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::common::thread::ThreadPool::Dispatch)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    std::shared_ptr<Sender> sender;
    auto sener_pool = std::make_shared<SenderPool>();
    EXPECT_EQ(PROFILING_FAILED, sener_pool->Dispatch(sender));
    sener_pool->Init();
    EXPECT_EQ(PROFILING_SUCCESS, sener_pool->Dispatch(sender));

    sener_pool->Uninit();

}

TEST_F(PROFILER_SENDER_TEST, file_init)
{
    GlobalMockObject::verify();

    auto chunkPool = std::make_shared<analysis::dvvp::common::memory::ChunkPool>(1, 16);
    EXPECT_EQ(true, chunkPool->Init());
    auto chunk = chunkPool->Alloc();
    auto file = std::make_shared<File>(chunkPool, chunk, "job_ctx_json", "file_name");
    EXPECT_EQ(PROFILING_FAILED, file->Init());
    file = std::make_shared<File>(chunkPool, chunk, job_ctx_json_file_mode, "file_name");
    EXPECT_EQ(PROFILING_SUCCESS, file->Init());
    file->Uinit();
    chunkPool->Uninit();
}
