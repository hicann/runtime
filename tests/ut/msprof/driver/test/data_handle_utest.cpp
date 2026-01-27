/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
TEST_F(HOST_PROF_MANAGER_TEST, ProcessStreamFileChunk)
{
    GlobalMockObject::verify();
    
    auto entry = analysis::dvvp::host::ProfManager::instance();
    std::string job_id = "123456789";
    std::string dev_id = "0";
    MOCKER_CPP(&analysis::dvvp::host::ProfTask::GetTaskProfilingMode)
        .stubs()
        .will(returnValue(std::string("test")))
        .then(returnValue(std::string("def_mode")));
    
    std::shared_ptr<analysis::dvvp::proto::FileChunkReq> message(
        new analysis::dvvp::proto::FileChunkReq());
    //fileChunkReq empty
    EXPECT_EQ(PROFILING_FAILED, ProfManager::ProcessStreamFileChunk(NULL, std::shared_ptr<google::protobuf::Message>()));

    //jobCtx.FromString empty
    EXPECT_EQ(PROFILING_FAILED, ProfManager::ProcessStreamFileChunk(NULL, message));

    analysis::dvvp::message::JobContext job_ctx;
    job_ctx.dev_id = dev_id;
    job_ctx.job_id = job_id;
    message->mutable_hdr()->set_job_ctx(job_ctx.ToString());
    //GetTask empty
    EXPECT_EQ(PROFILING_FAILED, ProfManager::ProcessStreamFileChunk(NULL, message));

    IDE_SESSION session = (IDE_SESSION)0x12345678;
    auto transport = std::shared_ptr<analysis::dvvp::transport::IDETransport>(
            new analysis::dvvp::transport::IDETransport(session));

    std::shared_ptr<analysis::dvvp::message::ProfileParams> 
        params(new analysis::dvvp::message::ProfileParams());
    params->FromString("{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\"}");
    std::vector<std::string> devices = 
            analysis::dvvp::common::utils::Utils::Split(params->devices, false, "", ",");
    std::shared_ptr<analysis::dvvp::host::ProfTask> task(new analysis::dvvp::host::ProfTask(transport, devices, params));
    entry->_tasks.insert(std::make_pair(job_id, task));
   
    MOCKER_CPP(&analysis::dvvp::host::ProfTask::WriteStreamData)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    //WriteStreamData success
    EXPECT_EQ(PROFILING_SUCCESS, ProfManager::ProcessStreamFileChunk(NULL, message));

    job_ctx.dev_id = "";
    job_ctx.job_id = job_id;
    message->mutable_hdr()->set_job_ctx(job_ctx.ToString());
    //GetTask empty
    EXPECT_EQ(PROFILING_FAILED, ProfManager::ProcessStreamFileChunk(NULL, message));

    job_ctx.dev_id = "11111111111";
    job_ctx.job_id = job_id;
    message->mutable_hdr()->set_job_ctx(job_ctx.ToString());
    //GetTask empty
    EXPECT_EQ(PROFILING_FAILED, ProfManager::ProcessStreamFileChunk(NULL, message));

    job_ctx.dev_id = "-1";
    job_ctx.job_id = job_id;
    message->mutable_hdr()->set_job_ctx(job_ctx.ToString());
    //GetTask empty
    EXPECT_EQ(PROFILING_FAILED, ProfManager::ProcessStreamFileChunk(NULL, message));

    job_ctx.dev_id = "3147483647";
    job_ctx.job_id = job_id;
    message->mutable_hdr()->set_job_ctx(job_ctx.ToString());
    //GetTask empty
    EXPECT_EQ(PROFILING_FAILED, ProfManager::ProcessStreamFileChunk(NULL, message));

    job_ctx.dev_id = "2";
    job_ctx.job_id = job_id;
    message->mutable_hdr()->set_job_ctx(job_ctx.ToString());
    //GetTask empty
    EXPECT_EQ(PROFILING_SUCCESS, ProfManager::ProcessStreamFileChunk(NULL, message));

    job_ctx.dev_id = "64";
    job_ctx.job_id = job_id;
    message->mutable_hdr()->set_job_ctx(job_ctx.ToString());
    //GetTask empty
    EXPECT_EQ(PROFILING_SUCCESS, ProfManager::ProcessStreamFileChunk(NULL, message));

    std::string invalidJobId = "";
    std::string JobId = "123456789";
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::ReadDevJobIDMap)
        .stubs()
        .with(any(), any(), any())
        .will(returnValue(invalidJobId))
        .then(returnValue(invalidJobId))
        .then(returnValue(JobId));
    message->mutable_hdr()->set_job_ctx(job_ctx.ToString());
    EXPECT_EQ(PROFILING_SUCCESS, ProfManager::ProcessStreamFileChunk(NULL, message));

    message->set_datamodule(analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_FROM_MSPROF);
    message->mutable_hdr()->set_job_ctx(job_ctx.ToString());
    
    //ReadDevJobIDMap empty
    EXPECT_EQ(PROFILING_FAILED, ProfManager::ProcessStreamFileChunk(NULL, message));

    MOCKER_CPP(&analysis::dvvp::transport::FileSlice::SaveDataToLocalFiles)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    //SaveDataToLocalFiles failed
    EXPECT_EQ(PROFILING_FAILED, ProfManager::ProcessStreamFileChunk(NULL, message));
    //SaveDataToLocalFiles success
    EXPECT_EQ(PROFILING_SUCCESS, ProfManager::ProcessStreamFileChunk(NULL, message));

    //SaveDataToLocalFiles success
    EXPECT_EQ(PROFILING_SUCCESS, ProfManager::ProcessStreamFileChunk(NULL, message));

    message->set_datamodule(analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_CTRL_DATA);
    message->mutable_hdr()->set_job_ctx(job_ctx.ToString());
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::WriteCtrlDataToFile)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    //WriteCtrlDataToFile failed
    EXPECT_EQ(PROFILING_SUCCESS, ProfManager::ProcessStreamFileChunk(NULL, message));
    //WriteCtrlDataToFile success
    EXPECT_EQ(PROFILING_SUCCESS, ProfManager::ProcessStreamFileChunk(NULL, message));
}

TEST_F(HOST_PROF_MANAGER_TEST, ProcessStreamFileChunkSystemWide)
{
    GlobalMockObject::verify();
    
    std::string job_id = "123456789";
    std::string dev_id = "0";
    MOCKER_CPP(&analysis::dvvp::host::ProfTask::GetTaskProfilingMode)
        .stubs()
        .will(returnValue(std::string(analysis::dvvp::message::PROFILING_MODE_SYSTEM_WIDE)));
    std::shared_ptr<analysis::dvvp::proto::FileChunkReq> message(
        new analysis::dvvp::proto::FileChunkReq());
    analysis::dvvp::message::JobContext job_ctx;
    job_ctx.dev_id = dev_id;
    job_ctx.job_id = job_id;
    message->mutable_hdr()->set_job_ctx(job_ctx.ToString());
    MOCKER_CPP(&analysis::dvvp::transport::FileSlice::SaveDataToLocalFiles)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&analysis::dvvp::host::ProfTask::WriteStreamData)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    //system-wide success
    EXPECT_EQ(PROFILING_SUCCESS, ProfManager::ProcessStreamFileChunk(NULL, message));
}

TEST_F(HOST_PROF_MANAGER_TEST, ProcessFileChunkFlush)
{
    GlobalMockObject::verify();
    
    std::string job_id = "123456789";
    auto entry = analysis::dvvp::host::ProfManager::instance();

    std::shared_ptr<analysis::dvvp::proto::FileChunkFlushReq> message(
        new analysis::dvvp::proto::FileChunkFlushReq());
    std::shared_ptr<google::protobuf::Message> fileChunkFlushReq = message;

    std::string invalidJobId = "";
    std::string JobId = "123456789";
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::ReadDevJobIDMap)
        .stubs()
        .with(any(), any(), any())
        .will(returnValue(invalidJobId))
        .then(returnValue(JobId));
    
    MOCKER_CPP(&analysis::dvvp::transport::FileSlice::FileSliceFlushByJobID)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    
    analysis::dvvp::message::JobContext job_ctx;
    job_ctx.job_id = job_id;
    message->mutable_hdr()->set_job_ctx("fake_job_ctx_json");

    //fileChunkFlush failed
    int ret = entry->ProcessFileChunkFlush(nullptr, nullptr);
    EXPECT_EQ(PROFILING_FAILED, ret);

    //job_ctx failed
    ret = entry->ProcessFileChunkFlush(nullptr, message);
    EXPECT_EQ(PROFILING_FAILED, ret);

    //ReadDevJobIDMap failed
    job_ctx.dev_id = "10000";
    message->mutable_hdr()->set_job_ctx(job_ctx.ToString());
    message->set_filename("__PROFILER_HOST_ST__");
    ret = entry->ProcessFileChunkFlush(nullptr, message);
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = entry->ProcessFileChunkFlush(nullptr, message);
    EXPECT_EQ(PROFILING_FAILED, ret);

    job_ctx.dev_id = "";
    message->mutable_hdr()->set_job_ctx(job_ctx.ToString());
    ret = entry->ProcessFileChunkFlush(nullptr, message);
    EXPECT_EQ(PROFILING_FAILED, ret);

    job_ctx.dev_id = "-123";
    message->mutable_hdr()->set_job_ctx(job_ctx.ToString());
    ret = entry->ProcessFileChunkFlush(nullptr, message);
    EXPECT_EQ(PROFILING_FAILED, ret);

    job_ctx.dev_id = "11111111111";
    message->mutable_hdr()->set_job_ctx(job_ctx.ToString());
    ret = entry->ProcessFileChunkFlush(nullptr, message);
    EXPECT_EQ(PROFILING_FAILED, ret);

    job_ctx.dev_id = "3147483648";
    message->mutable_hdr()->set_job_ctx(job_ctx.ToString());
    ret = entry->ProcessFileChunkFlush(nullptr, message);
    EXPECT_EQ(PROFILING_FAILED, ret);

    job_ctx.dev_id = "2147483646";
    message->mutable_hdr()->set_job_ctx(job_ctx.ToString());
    ret = entry->ProcessFileChunkFlush(nullptr, message);
    EXPECT_EQ(PROFILING_FAILED, ret);

    MOCKER_CPP(&analysis::dvvp::host::ProfTask::WriteStreamData)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    ret = entry->ProcessFileChunkFlush(nullptr, message);
    EXPECT_EQ(PROFILING_FAILED, ret);

    job_ctx.dev_id = "1";
    message->mutable_hdr()->set_job_ctx(job_ctx.ToString());
    ret = entry->ProcessFileChunkFlush(nullptr, message);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}



TEST_F(HOST_PROF_MANAGER_TEST, ProcessDataChannelFinish) {

    GlobalMockObject::verify();
    auto entry = analysis::dvvp::host::ProfManager::instance();
    std::string dev_id = "0";
    std::string job_id = "123456789";
    //data_chann_finish empty
    EXPECT_EQ(PROFILING_FAILED, ProfManager::ProcessDataChannelFinish(NULL, std::shared_ptr<google::protobuf::Message>()));
    
    std::shared_ptr<analysis::dvvp::proto::DataChannelFinish> message(
        new analysis::dvvp::proto::DataChannelFinish());
    //job_ctx empty
    EXPECT_EQ(PROFILING_FAILED, ProfManager::ProcessDataChannelFinish(NULL, message));
    
    std::vector<std::string> devices;
    analysis::dvvp::transport::FILETransport * ide_trans = new analysis::dvvp::transport::FILETransport("/tmp");
    auto transport = std::shared_ptr<analysis::dvvp::transport::FILETransport>(ide_trans);
    std::shared_ptr<analysis::dvvp::message::ProfileParams> 
        params(new analysis::dvvp::message::ProfileParams());
    params->FromString("{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\"}");
    analysis::dvvp::host::ProfTask* _task = new analysis::dvvp::host::ProfTask(transport, devices, params);
    _task->Init();
    
    std::shared_ptr<analysis::dvvp::host::ProfTask> taskFake;
    taskFake.reset();
    std::shared_ptr<analysis::dvvp::host::ProfTask> task(_task);
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::GetTask)
        .stubs()
        .will(returnValue(taskFake))
        .then(returnValue(task));

    analysis::dvvp::message::JobContext job_ctx;
    job_ctx.dev_id = dev_id;
    job_ctx.job_id = "0x123456789";
    message->mutable_hdr()->set_job_ctx(job_ctx.ToString());
    //gettask failed
    EXPECT_EQ(PROFILING_FAILED, ProfManager::ProcessDataChannelFinish(NULL, message));

    std::shared_ptr<analysis::dvvp::host::Device> deviceFake;
    std::shared_ptr<analysis::dvvp::host::Device> device( new analysis::dvvp::host::Device(nullptr, dev_id));

    MOCKER_CPP(&analysis::dvvp::host::ProfTask::GetDevice)
        .stubs()
        .will(returnValue(deviceFake))
        .then(returnValue(device));
        
    //getDevice failed
    EXPECT_EQ(PROFILING_FAILED, ProfManager::ProcessDataChannelFinish(NULL, message));

    job_ctx.job_id = job_id;
    message->mutable_hdr()->set_job_ctx(job_ctx.ToString());
    
    devices = 
            analysis::dvvp::common::utils::Utils::Split(params->devices, false, "", ",");
    std::shared_ptr<analysis::dvvp::host::ProfTask> task2(new analysis::dvvp::host::ProfTask(transport, devices, params));
    entry->_tasks.insert(std::make_pair(job_id, task2));

    MOCKER_CPP(&analysis::dvvp::host::Device::PostSyncDataCtrl)
        .stubs();
    
    MOCKER_CPP(&analysis::dvvp::host::ProfTask::GetTaskProfilingMode)
        .stubs()
        .will(returnValue(std::string("def_mode")))
        .then(returnValue(std::string("def_mode")))
        .then(returnValue(std::string("def_mode")))
        .then(returnValue(std::string("test")));

    std::string invalidJobId = "";
    std::string JobId = "123456789";
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::ReadDevJobIDMap)
        .stubs()
        .with(any(), any(), any())
        .will(returnValue(invalidJobId))
        .then(returnValue(JobId));
    MOCKER_CPP(&analysis::dvvp::transport::FileSlice::FileSliceFlushByJobID)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    
    //ReadDevJobIDMap failed
    EXPECT_EQ(PROFILING_SUCCESS, ProfManager::ProcessDataChannelFinish(NULL, message));

    //FileSliceFlushByJobID false
    EXPECT_EQ(PROFILING_SUCCESS, ProfManager::ProcessDataChannelFinish(NULL, message));

    //return PROFILING_SUCCESS
    EXPECT_EQ(PROFILING_SUCCESS, ProfManager::ProcessDataChannelFinish(NULL, message));
}

TEST_F(HOST_PROF_MANAGER_TEST, ReceiveStreamData) {

    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::proto::DataChannelFinish> message(
        new analysis::dvvp::proto::DataChannelFinish());
    std::string encoded = analysis::dvvp::message::EncodeMessage(message);

    MOCKER(analysis::dvvp::host::ProfManager::ProcessDataChannelFinish)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    //null
    EXPECT_EQ(PROFILING_FAILED, Analysis::Dvvp::Transport::MsprofDataHandle::ReceiveStreamData(NULL, (void*)NULL, encoded.size()));
    //message error
    std::shared_ptr<analysis::dvvp::proto::Response> fake_message(
        new analysis::dvvp::proto::Response());
    std::string fake_encoded = analysis::dvvp::message::EncodeMessage(fake_message);
    EXPECT_EQ(PROFILING_FAILED, Analysis::Dvvp::Transport::MsprofDataHandle::ReceiveStreamData(NULL, (void*)fake_encoded.c_str(), fake_encoded.size()));
    //success
    EXPECT_EQ(PROFILING_SUCCESS, Analysis::Dvvp::Transport::MsprofDataHandle::ReceiveStreamData(NULL, (void*)encoded.c_str(), encoded.size()));
}