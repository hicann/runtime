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
#include "hdc-log-stub.h"
#include "hdc-api-stub.h"
#include "proto/profiler.pb.h"
#include "errno/error_code.h"
#include "message/codec.h"
#include "prof_host_core.h"
#include "prof_manager.h"
#include "collect_io_server.h"
#include "securec.h"
#include "config/config_manager.h"
#include "config/config.h"
#include "message/prof_params.h"
#include "hdc/device_transport.h"
#include "prof_file_record.h"
#include "task_relationship_mgr.h"
#include "transport/file_transport.h"

using namespace analysis::dvvp::host;
using namespace analysis::dvvp::driver;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::transport;

class HOST_PROF_MANAGER_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

TEST_F(HOST_PROF_MANAGER_TEST, Init) {
    GlobalMockObject::verify();

    MOCKER(ProfilerServerInit)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER(RegisterSendData)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::ProfInotifyStart)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    auto entry = analysis::dvvp::host::ProfManager::instance();
    EXPECT_EQ(PROFILING_FAILED, entry->Init());
    EXPECT_EQ(PROFILING_FAILED, entry->Init());
    EXPECT_EQ(PROFILING_FAILED, entry->Init());
    EXPECT_EQ(PROFILING_SUCCESS, entry->Init());
    EXPECT_EQ(PROFILING_SUCCESS, entry->Init());

}

TEST_F(HOST_PROF_MANAGER_TEST, Uinit) {
    GlobalMockObject::verify();
    
    MOCKER_CPP(&analysis::dvvp::host::ProfInotify::Uinit)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    auto entry = analysis::dvvp::host::ProfManager::instance();
    EXPECT_EQ(PROFILING_SUCCESS, entry->Uinit());
}

TEST_F(HOST_PROF_MANAGER_TEST, ProfInotifyStart) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::host::ProfInotify::InotifyEnable)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    MOCKER_CPP(&analysis::dvvp::host::ProfInotify::InotifyGetDataStoreAbility)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    MOCKER_CPP(&analysis::dvvp::host::ProfInotify::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    
    MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(EN_ERROR))
        .then(returnValue(EN_OK));
    
    std::string hostLocalDir = "";
    auto entry = analysis::dvvp::host::ProfManager::instance();

    MOCKER_CPP(&Analysis::Dvvp::Aging::ProfFileRecord::Init)
            .stubs()
            .will(returnValue(PROFILING_FAILED))
            .then(returnValue(PROFILING_SUCCESS));
    
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
            .stubs()
            .will(returnValue(1));

    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::Init)
            .stubs()
            .will(returnValue(PROFILING_SUCCESS));
    
    //InotifyEnable failed
    EXPECT_EQ(PROFILING_SUCCESS, entry->ProfInotifyStart());

    //_inotify Init failed
    EXPECT_EQ(PROFILING_FAILED, entry->ProfInotifyStart());

    //inotify Start failed
    EXPECT_EQ(PROFILING_FAILED, entry->ProfInotifyStart());

    //ProfFileRecord Init failed
    EXPECT_EQ(PROFILING_FAILED, entry->ProfInotifyStart());

    EXPECT_EQ(PROFILING_FAILED, entry->ProfInotifyStart());

    //start succ
    EXPECT_EQ(PROFILING_SUCCESS, entry->ProfInotifyStart());
}

TEST_F(HOST_PROF_MANAGER_TEST, ReadDevJobIDMap) {
    GlobalMockObject::verify();
    
    auto entry = analysis::dvvp::host::ProfManager::instance();
    std::string jobId = "0x12345678";
    int devId = 0;
    entry->WriteDevJobIDMap(devId, jobId);

    EXPECT_STREQ("0x12345678", entry->ReadDevJobIDMap(devId).c_str());
    EXPECT_STREQ("", entry->ReadDevJobIDMap(-1).c_str());
}

TEST_F(HOST_PROF_MANAGER_TEST, ProcessHandleFailed) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::host::ProfManager::CreateStateFile)
        .stubs()
        .will(returnValue(false));

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    params->FromString("{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"cloud\", \"profiling_mode\":\"system-wide\"}");

    auto entry = analysis::dvvp::host::ProfManager::instance();
    analysis::dvvp::message::StatusInfo status;

    EXPECT_EQ(PROFILING_FAILED, entry->ProcessHandleFailed(params, status));

    params->FromString("{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"cloud\", \"profiling_mode\":\"def_mode\"}");
    EXPECT_EQ(PROFILING_SUCCESS, entry->ProcessHandleFailed(params, status));
}

TEST_F(HOST_PROF_MANAGER_TEST, Handle) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    params->FromString("{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"cloud\", \"profiling_mode\":\"system-wide\"}");

    auto entry = analysis::dvvp::host::ProfManager::instance();
    MOCKER(analysis::dvvp::common::utils::Utils::IsFileExist)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(PROFILING_FAILED, entry->Handle(params));

    MOCKER(ProfilerServerInit)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER(RegisterSendData)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_SUCCESS, entry->Init());
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::IsDeviceProfiling)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    EXPECT_EQ(PROFILING_FAILED, entry->Handle(params));
    params->FromString("{\"result_dir\":\"/tmp/\", \"devices\":\"1\",\"profiling_mode\":\"system-wide\"}");

    MOCKER_CPP(&analysis::dvvp::host::ProfManager::InitDeviceTransport)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::LaunchTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED));

    EXPECT_EQ(PROFILING_FAILED, entry->Handle(params));
    EXPECT_EQ(PROFILING_FAILED, entry->Handle(params));
    EXPECT_EQ(PROFILING_FAILED, entry->Handle(params));
    EXPECT_EQ(PROFILING_FAILED, entry->Handle(params));

    //system wide
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::CreateStateFile)
        .stubs()
        .will(returnValue(false));
    params->FromString("{\"profiling_mode\":\"system-wide\", \"result_dir\":\"/tmp/\", \"devices\":\"1\"}");
    EXPECT_EQ(PROFILING_FAILED, entry->Handle(params));

    MOCKER_CPP(&analysis::dvvp::message::ProfileParams::FromString)
        .stubs()
        .will(returnValue(false));
    EXPECT_EQ(PROFILING_FAILED, entry->Handle(params));

     MOCKER_CPP(&analysis::dvvp::host::ProfManager::ProcessHandleFailed)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, entry->Handle(params));
    EXPECT_EQ(PROFILING_FAILED, entry->Handle(params));

    params->is_cancel = true;
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::StopTask)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, entry->Handle(params));

}

TEST_F(HOST_PROF_MANAGER_TEST, handle_cloud) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::host::ProfManager::IsDeviceProfiling)
        .stubs()
        .will(returnValue(true));

    auto entry = analysis::dvvp::host::ProfManager::instance();
    entry->Init();

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    params->FromString("{\"profiling_mode\":\"def_mode\", \"result_dir\":\"/tmp/\", \"devices\":\"1\"}");
    EXPECT_EQ(PROFILING_FAILED, entry->Handle(params));
}

TEST_F(HOST_PROF_MANAGER_TEST, handle_stop_task) {
    GlobalMockObject::verify();

    auto entry = analysis::dvvp::host::ProfManager::instance();
    entry->isInited_ = true;

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    params->FromString("{\"result_dir\":\"/tmp/\", \"devices\":\"1\",\"is_cancel\":true,\"profiling_mode\":\"def_mode\"}");

    MOCKER(ProfilerServerInit)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER(RegisterSendData)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));


    MOCKER_CPP(&analysis::dvvp::host::ProfManager::StopTask)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(PROFILING_FAILED, entry->Handle(params));
}

TEST_F(HOST_PROF_MANAGER_TEST, CreateSampleJsonFile) {
    GlobalMockObject::verify();

    auto entry = analysis::dvvp::host::ProfManager::instance();
    std::shared_ptr<analysis::dvvp::message::ProfileParams>
        params(new analysis::dvvp::message::ProfileParams());
    params->FromString("{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\", \"profiling_mode\":\"test\"}");

    MOCKER_CPP(&analysis::dvvp::host::ProfManager::WriteCtrlDataToFile)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER(analysis::dvvp::common::utils::Utils::CreateDir)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(false, entry->CreateSampleJsonFile(params, "/tmp/1/"));
    params->FromString("{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\", \"profiling_mode\":\"def_mode\"}");
    EXPECT_EQ(false, entry->CreateSampleJsonFile(params, "/tmp/1/"));
    params->FromString("{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\", \"profiling_mode\":\"system-wide\"}");
    EXPECT_EQ(true, entry->CreateSampleJsonFile(params, "/tmp/1/"));
    EXPECT_EQ(true, entry->CreateSampleJsonFile(params, "/tmp/1/"));
}

TEST_F(HOST_PROF_MANAGER_TEST, IsDeviceProfiling) {
    GlobalMockObject::verify();

    auto entry = analysis::dvvp::host::ProfManager::instance();
    std::shared_ptr<analysis::dvvp::message::ProfileParams>
        params(new analysis::dvvp::message::ProfileParams());
    params->FromString("{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\"}");
    std::vector<std::string> devices =
            analysis::dvvp::common::utils::Utils::Split(params->devices, false, "", ",");
    std::shared_ptr<analysis::dvvp::host::ProfTask> task(new analysis::dvvp::host::ProfTask(devices, params));
    entry->_tasks.insert(std::make_pair(params->job_id, task));

    MOCKER_CPP(&analysis::dvvp::host::ProfTask::isDeviceRunProfiling)
        .stubs()
        .will(returnValue(true));

    EXPECT_EQ(true, entry->IsDeviceProfiling(devices, analysis::dvvp::message::PROFILING_MODE_DEF));
}

TEST_F(HOST_PROF_MANAGER_TEST, GetTask) {
    GlobalMockObject::verify();

    auto entry = analysis::dvvp::host::ProfManager::instance();
    EXPECT_NE(nullptr, entry->GetTask("1"));

}

TEST_F(HOST_PROF_MANAGER_TEST, OnTaskFinished) {
    GlobalMockObject::verify();

    auto entry = analysis::dvvp::host::ProfManager::instance();
    EXPECT_EQ(PROFILING_SUCCESS, entry->OnTaskFinished("1"));

}

TEST_F(HOST_PROF_MANAGER_TEST, CreateStateFile) {
    GlobalMockObject::verify();
    MOCKER(analysis::dvvp::common::utils::Utils::CreateDir)
            .stubs()
            .will(returnValue(PROFILING_FAILED))
            .then(returnValue(PROFILING_SUCCESS));
    MOCKER(analysis::dvvp::common::utils::Utils::JoinPath)
            .stubs()
            .will(returnValue(std::string("/tmp/profiling_utest/prof")))
            .then(returnValue(std::string("/tmp/profiling_utest/prof")))
            .then(returnValue(std::string("/tmp/profiling_utest/prof")))
            .then(returnValue(std::string("/tmp/profiling_utest/prof")))
            .then(returnValue(std::string("/tmp/profiling_state_utest")))
            .then(returnValue(std::string("/tmp/profiling_utest/prof")))
            .then(returnValue(std::string("/tmp/profiling_state_utest")));

    MOCKER(analysis::dvvp::common::utils::Utils::GetFileSize)
                .stubs()
                .will(returnValue(-1))
                .then(returnValue(10));
    const std::string path = "/tmp/PROFILER_UT/";
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetDataDir)
        .stubs()
        .will(returnValue(path));

    auto entry = analysis::dvvp::host::ProfManager::instance();
    EXPECT_EQ(false, entry->CreateStateFile("profiling", "profutestjobid12345","SUCCESS", ""));
    EXPECT_EQ(false, entry->CreateStateFile("profiling", "profutestjobid12345","SUCCESS", ""));
    EXPECT_EQ(false, entry->CreateStateFile("profiling", "profutestjobid12345","SUCCESS", ""));
    EXPECT_EQ(false, entry->CreateStateFile("profiling", "profutestjobid12345","SUCCESS", "test"));
    remove("/tmp/profiling_state_utest");
}


TEST_F(HOST_PROF_MANAGER_TEST, LaunchTask) {
    GlobalMockObject::verify();

    auto entry = analysis::dvvp::host::ProfManager::instance();
    std::shared_ptr<analysis::dvvp::message::ProfileParams>
        params(new analysis::dvvp::message::ProfileParams());
    params->FromString("{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\"}");
    std::vector<std::string> devices =
            analysis::dvvp::common::utils::Utils::Split(params->devices, false, "", ",");
    std::shared_ptr<analysis::dvvp::host::ProfTask> task(new analysis::dvvp::host::ProfTask(devices, params));
    analysis::dvvp::message::StatusInfo status_info;

    status_info.status = analysis::dvvp::message::ERR;


    MOCKER_CPP(&analysis::dvvp::host::ProfTask::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

	MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(EN_OK));
    // MOCKER_CPP(&analysis::dvvp::common::thread::Thread::Start)


    std::shared_ptr<analysis::dvvp::host::ProfTask> mockTask;
    mockTask.reset();
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::GetTask)
        .stubs()
        .will(returnValue(mockTask))
        .then(returnValue(task));

    EXPECT_EQ(PROFILING_FAILED, entry->LaunchTask(task, "1", status_info.info));
    EXPECT_EQ(PROFILING_FAILED, entry->LaunchTask(task, "1", status_info.info));
    EXPECT_EQ(PROFILING_FAILED, entry->LaunchTask(task, "1", status_info.info));

    EXPECT_EQ(PROFILING_SUCCESS, entry->OnTaskFinished("1"));
}

TEST_F(HOST_PROF_MANAGER_TEST, launch_task_same_jobid) {
    GlobalMockObject::verify();

    auto entry = analysis::dvvp::host::ProfManager::instance();
    std::shared_ptr<analysis::dvvp::message::ProfileParams>
        params(new analysis::dvvp::message::ProfileParams());
    params->FromString("{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\"}");
    std::vector<std::string> devices =
            analysis::dvvp::common::utils::Utils::Split(params->devices, false, "", ",");
    std::shared_ptr<analysis::dvvp::host::ProfTask> task(new analysis::dvvp::host::ProfTask(devices, params));
    analysis::dvvp::message::StatusInfo status_info;
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::GetTask)
        .stubs()
        .will(returnValue(task));

    EXPECT_EQ(PROFILING_FAILED, entry->LaunchTask(task, "1", status_info.info));
}

TEST_F(HOST_PROF_MANAGER_TEST, destrcutor) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::host::ProfManager> entry(
        new analysis::dvvp::host::ProfManager());
    EXPECT_NE(nullptr, entry);
    entry.reset();
}

TEST_F(HOST_PROF_MANAGER_TEST, StopTask) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::host::ProfManager> entry(
        new analysis::dvvp::host::ProfManager());

    std::shared_ptr<analysis::dvvp::message::ProfileParams>
        params(new analysis::dvvp::message::ProfileParams());
    params->FromString("{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\"}");
    std::vector<std::string> devices =
            analysis::dvvp::common::utils::Utils::Split(params->devices, false, "", ",");
    std::shared_ptr<analysis::dvvp::host::ProfTask> task(new analysis::dvvp::host::ProfTask(devices, params));

    entry->_tasks.insert(std::make_pair(params->job_id, task));

    MOCKER(mmJoinTask)
        .stubs()
        .will(returnValue(EN_OK));
    // MOCKER_CPP(&analysis::dvvp::common::thread::Thread::Stop)
    //    .stubs()
    //    .will(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(PROFILING_SUCCESS, entry->StopTask(params->job_id));
    EXPECT_EQ(PROFILING_SUCCESS, entry->StopTask("0"));
}

TEST_F(HOST_PROF_MANAGER_TEST, CreateDoneFile)
{
    GlobalMockObject::verify();

    std::string dirName = "/tmp/CreateDoneFile";
    std::string fileName = "/tmp/CreateDoneFile/test";
    std::string fileSize = "123";
    
    std::string invalidPath = "/home/no_exist_dir/profiling";
    
    auto entry = analysis::dvvp::host::ProfManager::instance();
    bool ret = entry->CreateDoneFile(invalidPath, fileSize);
    EXPECT_EQ(false, ret);

    analysis::dvvp::common::utils::Utils::CreateDir(dirName);
    // CreateDoneFile success
    ret = entry->CreateDoneFile(fileName, fileSize);
    EXPECT_EQ(true, ret);
    analysis::dvvp::common::utils::Utils::RemoveDir(dirName);
}

TEST_F(HOST_PROF_MANAGER_TEST, WriteCtrlDataToFile)
{
    GlobalMockObject::verify();

    int ret = -1;
    std::string invalidPath = "/home/no_exist_dir/profiling";
    std::string buff = "test";
    int dataLen = 4;
    std::string dirName = "/tmp/WriteCtrlDataToFile";
    std::string fileName = "/tmp/WriteCtrlDataToFile/test";

    MOCKER_CPP(&analysis::dvvp::host::ProfManager::CreateDoneFile)
            .stubs()
            .will(returnValue(false))
            .then(returnValue(true));

    auto entry = analysis::dvvp::host::ProfManager::instance();
    // data = nullptr failed
    ret = entry->WriteCtrlDataToFile(invalidPath, "", dataLen);
    EXPECT_EQ(PROFILING_FAILED, ret);

    // file open failed
    ret = entry->WriteCtrlDataToFile(invalidPath, buff, dataLen);
    EXPECT_EQ(PROFILING_FAILED, ret);

    analysis::dvvp::common::utils::Utils::CreateDir(dirName);
    // CreateDoneFile failed
    ret = entry->WriteCtrlDataToFile(fileName, buff, dataLen);
    EXPECT_EQ(PROFILING_FAILED, ret);

    // is_file_exist
    ret = entry->WriteCtrlDataToFile(fileName, buff, dataLen);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
    analysis::dvvp::common::utils::Utils::RemoveDir(dirName);
    analysis::dvvp::common::utils::Utils::CreateDir(dirName);
    // CreateDoneFile success
    ret = entry->WriteCtrlDataToFile(fileName, buff, dataLen);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
    analysis::dvvp::common::utils::Utils::RemoveDir(dirName);
}

TEST_F(HOST_PROF_MANAGER_TEST, ReadDevUuidMap) {

    GlobalMockObject::verify();
    auto entry = analysis::dvvp::host::ProfManager::instance();
    entry->WriteDevUuidMap(0, "test");
    EXPECT_STREQ("", entry->ReadDevUuidMap(100).c_str());
    EXPECT_STREQ("test", entry->ReadDevUuidMap(0).c_str());
}

TEST_F(HOST_PROF_MANAGER_TEST, PowerdownHandler) {
    GlobalMockObject::verify();

    auto entry = analysis::dvvp::host::ProfManager::instance();

    devdrv_state_info_t devInfo;
    devInfo.devId = 65;
    EXPECT_EQ(IDE_DAEMON_ERROR, entry->StaticPowerdownHandler(&devInfo));

    MOCKER_CPP(&analysis::dvvp::transport::DeviceTransport::CloseConn) 
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&analysis::dvvp::host::ProfTask::IsDeviceProfiling)
        .stubs()
        .will(returnValue(true));

    // MOCKER_CPP(&analysis::dvvp::host::ProfTask::Stop)
    MOCKER(mmJoinTask)
        .stubs()
        .will(returnValue(EN_OK));

    devInfo.devId = 1;
    entry->_tasks.clear();

    std::shared_ptr<analysis::dvvp::message::ProfileParams>
        params(new analysis::dvvp::message::ProfileParams());
    params->FromString("{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\"}");
    std::vector<std::string> devices =
            analysis::dvvp::common::utils::Utils::Split(params->devices, false, "", ",");
    std::shared_ptr<analysis::dvvp::host::ProfTask> task(new analysis::dvvp::host::ProfTask(devices, params));
    std::string job_id = "1";
    entry->_tasks.insert(std::make_pair(job_id, task));

    IDE_SESSION session = (IDE_SESSION)0x12345678;
    std::shared_ptr<analysis::dvvp::transport::DeviceTransport> dev_tran =
        std::make_shared<DeviceTransport>(session, "1", "0", "def_mode");

    EXPECT_EQ(IDE_DAEMON_OK, entry->StaticPowerdownHandler(&devInfo));
}

static int _drv_get_dev_ids(int num_devices, std::vector<int> & dev_ids) {
    static int phase = 0;
    if (phase == 0) {
        phase++;
        return PROFILING_FAILED;
    }

    if (phase >= 1) {
        dev_ids.push_back(0);
        return PROFILING_SUCCESS;
    }
}

TEST_F(HOST_PROF_MANAGER_TEST, HandleProfilingParams) {

    GlobalMockObject::verify();
    auto entry = analysis::dvvp::host::ProfManager::instance();
    EXPECT_EQ(nullptr, entry->HandleProfilingParams(""));
    EXPECT_EQ(nullptr, entry->HandleProfilingParams("abc"));
    MOCKER(analysis::dvvp::driver::DrvGetDevNum)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(1));
    EXPECT_EQ(nullptr, entry->HandleProfilingParams(0, "{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\"}"));
    MOCKER(analysis::dvvp::driver::DrvGetDevIds)
        .stubs()
        .will(invoke(_drv_get_dev_ids));
    EXPECT_EQ(nullptr, entry->HandleProfilingParams(0, "{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\"}"));
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::MINI_V3_TYPE));
    EXPECT_EQ(nullptr, entry->HandleProfilingParams(0, "{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\"}"));
}

TEST_F(HOST_PROF_MANAGER_TEST, ProfilingParamsAdapter) {

    GlobalMockObject::verify();
    auto entry = analysis::dvvp::host::ProfManager::instance();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
		new analysis::dvvp::message::ProfileParams());
    const std::string path = "/tmp/PROFILER_UT/";
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetDataDir)
        .stubs()
        .will(returnValue(path));
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetInotifyDir)
        .stubs()
        .will(returnValue(path));
    params->profiling_mode = analysis::dvvp::message::PROFILING_MODE_SYSTEM_WIDE;
    MOCKER_CPP(&ProfManager::CreateSampleJsonFile)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(true, entry->ProfilingParamsAdapter(params));
    params->profiling_mode = analysis::dvvp::message::PROFILING_MODE_DEF;
    params->devices = "0,1";
    EXPECT_EQ(true, entry->ProfilingParamsAdapter(params));
    params->profiling_mode = "online";
    EXPECT_EQ(true, entry->ProfilingParamsAdapter(params));

}

TEST_F(HOST_PROF_MANAGER_TEST, IdeCloudProfileProcess) {
    GlobalMockObject::verify();
    auto entry = analysis::dvvp::host::ProfManager::instance();
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::Handle)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    EXPECT_NE(PROFILING_SUCCESS, entry->IdeCloudProfileProcess(nullptr));
}

TEST_F(HOST_PROF_MANAGER_TEST, IdeCloudProfileProcessFailed) {
    GlobalMockObject::verify();
    auto entry = analysis::dvvp::host::ProfManager::instance();
    std::shared_ptr<analysis::dvvp::transport::ITransport> fileTran = std::make_shared<analysis::dvvp::transport::FILETransport>("/tmp");
    std::shared_ptr<analysis::dvvp::transport::ITransport> trans;
    trans.reset();
    MOCKER_CPP(&analysis::dvvp::transport::FileTransportFactory::CreateFileTransport)
        .stubs()
        .will(returnValue(trans))
        .then(returnValue(fileTran));

    EXPECT_NE(PROFILING_SUCCESS, entry->IdeCloudProfileProcess(nullptr));

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams);
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::HandleProfilingParams)
        .stubs()
        .then(returnValue(params));

    EXPECT_NE(PROFILING_SUCCESS, entry->IdeCloudProfileProcess(params));
}

TEST_F(HOST_PROF_MANAGER_TEST, IdeCloudUuidProcess) {
    GlobalMockObject::verify();
    auto entry = analysis::dvvp::host::ProfManager::instance();
    MOCKER_CPP(&analysis::dvvp::host::ProfManager::Handle)
        .stubs()

        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

   EXPECT_EQ(PROFILING_SUCCESS, entry->IdeCloudUuidProcess(1, "a"));
   EXPECT_EQ(PROFILING_SUCCESS, entry->IdeCloudUuidProcess(1, "abcdefghijklmnopqrstuvwxyz123456"));
   analysis::dvvp::common::utils::Utils::RemoveDir("a");
   analysis::dvvp::common::utils::Utils::RemoveDir("abcdefghijklmnopqrstuvwxyz123456");
}

TEST_F(HOST_PROF_MANAGER_TEST, CheckIfDevicesOnline) {
    GlobalMockObject::verify();
    auto entry = analysis::dvvp::host::ProfManager::instance();
    MOCKER(analysis::dvvp::driver::DrvGetDevNum)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(1));
    std::string statsInfo;
    EXPECT_EQ(false, entry->CheckIfDevicesOnline("1", statsInfo));
    MOCKER(analysis::dvvp::driver::DrvGetDevIds)
        .stubs()
        .will(invoke(_drv_get_dev_ids));
    EXPECT_EQ(false, entry->CheckIfDevicesOnline("1,2", statsInfo));
    EXPECT_EQ(false, entry->CheckIfDevicesOnline("1,2", statsInfo));
    EXPECT_EQ(true, entry->CheckIfDevicesOnline("0", statsInfo));
}

TEST_F(HOST_PROF_MANAGER_TEST, AclInitUinit) {
    GlobalMockObject::verify();
    auto entry = analysis::dvvp::host::ProfManager::instance();
    // init ok
    EXPECT_EQ(PROFILING_SUCCESS, entry->AclInit());
    // inited
    EXPECT_EQ(PROFILING_SUCCESS, entry->AclInit());
    // uinit ok
    EXPECT_EQ(PROFILING_SUCCESS, entry->AclUinit());
}

TEST_F(HOST_PROF_MANAGER_TEST, CheckHandleSuc)
{
    GlobalMockObject::verify();
    auto entry = analysis::dvvp::host::ProfManager::instance();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    params->FromString("{\"app\":\"/ls/\", \"app_dir\":\"/usr/bin/\", \"job_id\":\"cloud\"}");
    analysis::dvvp::message::StatusInfo status;
    EXPECT_TRUE(entry->CheckHandleSuc(params, status));
    EXPECT_EQ(status.info, "device is already in profiling, skip the task");
}

TEST_F(HOST_PROF_MANAGER_TEST, StartMsprofSysTask)
{
    GlobalMockObject::verify();
    auto entry = analysis::dvvp::host::ProfManager::instance();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    params->FromString("{\"app\":\"/ls/\", \"app_dir\":\"/usr/bin/\", \"job_id\":\"cloud\"}");
    std::vector<std::string> devIds;
    devIds.push_back("0");
    std::string info;
    EXPECT_EQ(PROFILING_FAILED, entry->StartMsprofSysTask(nullptr, info, devIds));

    MOCKER_CPP(&analysis::dvvp::host::ProfManager::InitDeviceTransport)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    MOCKER_CPP(&ProfManager::LaunchTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(PROFILING_FAILED, entry->StartMsprofSysTask(params, info, devIds));
    EXPECT_EQ(PROFILING_FAILED, entry->StartMsprofSysTask(params, info, devIds));
    EXPECT_EQ(PROFILING_FAILED, entry->StartMsprofSysTask(params, info, devIds));

}

TEST_F(HOST_PROF_MANAGER_TEST, OpenCpuDeviceTest)
{
    GlobalMockObject::verify();
    auto entry = analysis::dvvp::host::ProfManager::instance();
    EXPECT_EQ(true, entry->CheckOpenCpuDevice("0"));
    entry->AddOpenCpuDevice("0");
    EXPECT_EQ(false, entry->CheckOpenCpuDevice("0"));
    entry->DelOpenCpuDevice("0");
    EXPECT_EQ(true, entry->CheckOpenCpuDevice("0"));
}

TEST_F(HOST_PROF_MANAGER_TEST, InitDeviceAndLaunchTaskTest)
{
    GlobalMockObject::verify();
    auto entry = analysis::dvvp::host::ProfManager::instance();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    params->devices = "0";
    params->app_location = "device";

    std::string info;

    MOCKER_CPP(&ProfManager::CheckOpenCpuDevice)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    EXPECT_EQ(PROFILING_FAILED, entry->InitDeviceAndLaunchTask(params, info));

    params->app_location = "";
    MOCKER_CPP(&ProfManager::IsDeviceProfiling)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    EXPECT_EQ(PROFILING_FAILED, entry->InitDeviceAndLaunchTask(params, info));

    params->app_location = "device";
    MOCKER_CPP(&ProfManager::InitDeviceTransport)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&ProfManager::CloseDeviceTransport)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, entry->InitDeviceAndLaunchTask(params, info));

    MOCKER_CPP(&ProfManager::LaunchTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, entry->InitDeviceAndLaunchTask(params, info));

    EXPECT_EQ(PROFILING_SUCCESS, entry->InitDeviceAndLaunchTask(params, info));
}
