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
#include <sys/time.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include "adx_prof_api.h"
#include "utils/utils.h"
#include "transport/transport.h"
#include "prof_manager.h"
#include "proto/profiler.pb.h"
#include "message/codec.h"
#include "ai_drv_dev_api.h"
#include "errno/error_code.h"
#include "collect_io_server.h"
#include "prof_task.h"
#include "app/application.h"
#include "info_json.h"
#include "config/config_manager.h"

using namespace analysis::dvvp::host;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::message;
using namespace Analysis::Dvvp::Common::Statistics;
using namespace analysis::dvvp::transport;
class HOST_PROF_TASK_TEST: public testing::Test {
protected:
    virtual void SetUp() {
        IDE_SESSION session = (IDE_SESSION)0x12345678;
        _ide_transport = TransportFactory().CreateIdeTransport(session);
        std::shared_ptr<PerfCount> perfCount(new PerfCount("test"));
        _ide_transport->perfCount_ = perfCount;
        _devices.push_back("0");
        param_ = std::shared_ptr<analysis::dvvp::message::ProfileParams>(
            new analysis::dvvp::message::ProfileParams());
        param_->result_dir=".";
        param_->devices="0";
        param_->jobInfo = "jobInfo";
        param_->job_id = "job_id";
        param_->result_dir = "/tmp/profiler_ut";
        analysis::dvvp::common::utils::Utils::CreateDir(param_->result_dir);
    }
    virtual void TearDown() {
        _ide_transport.reset();
        analysis::dvvp::common::utils::Utils::RemoveDir(param_->result_dir);
    }
public:
    std::shared_ptr<analysis::dvvp::transport::ITransport> _ide_transport;
    std::vector<std::string> _devices;
    std::shared_ptr<analysis::dvvp::message::ProfileParams> param_;
};

TEST_F(HOST_PROF_TASK_TEST, destrcutor) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::host::ProfTask> task(new analysis::dvvp::host::ProfTask(_devices, param_));
    EXPECT_NE(nullptr, task);
    task.reset();
}

TEST_F(HOST_PROF_TASK_TEST, Init) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::host::ProfTask> task(new analysis::dvvp::host::ProfTask(_devices, param_));

    MOCKER_CPP(&analysis::dvvp::transport::Uploader::Flush)
        .stubs();

    MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(EN_OK));

    MOCKER(pthread_create)
        .stubs()
        .then(returnValue(-1));

    EXPECT_EQ(PROFILING_SUCCESS, task->Init());
    EXPECT_TRUE(task->isInited_);

    EXPECT_EQ(PROFILING_SUCCESS, task->Uinit());
    EXPECT_FALSE(task->isInited_);
    
    EXPECT_EQ(PROFILING_SUCCESS, task->Init());
}

TEST_F(HOST_PROF_TASK_TEST, isDeviceRunProfiling) {
    GlobalMockObject::verify();
    std::string dumpMode = param_->profiling_mode;

    std::shared_ptr<analysis::dvvp::host::ProfTask> task(new analysis::dvvp::host::ProfTask(_devices, param_));
    param_->profiling_mode = PROFILING_MODE_DEF;
    EXPECT_FALSE(task->isDeviceRunProfiling("1", PROFILING_MODE_DEF));
    EXPECT_FALSE(task->isDeviceRunProfiling("0", PROFILING_MODE_SYSTEM_WIDE));
    EXPECT_TRUE(task->isDeviceRunProfiling("0", PROFILING_MODE_DEF));
    param_->profiling_mode = PROFILING_MODE_SYSTEM_WIDE;
    EXPECT_FALSE(task->isDeviceRunProfiling("0", PROFILING_MODE_DEF));
    param_->profiling_mode = dumpMode;
}

TEST_F(HOST_PROF_TASK_TEST, IsDeviceProfiling) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::host::ProfTask> task(new analysis::dvvp::host::ProfTask(_devices, param_));

    EXPECT_FALSE(task->IsDeviceProfiling("0"));

    task->devicesMap_["0"] = std::shared_ptr<analysis::dvvp::host::Device>();
    EXPECT_TRUE(task->IsDeviceProfiling("0"));
}

TEST_F(HOST_PROF_TASK_TEST, GetHostAndDeviceInfo) {
    GlobalMockObject::verify();
    std::string dumpMode = param_->profiling_mode;

    std::shared_ptr<analysis::dvvp::host::ProfTask> task(new analysis::dvvp::host::ProfTask(_devices, param_));

    MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(EN_OK));

    MOCKER(gettimeofday)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&InfoJson::Generate)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    param_->profiling_mode = PROFILING_MODE_SYSTEM_WIDE;

    EXPECT_EQ(PROFILING_FAILED, task->GetHostAndDeviceInfo());

    EXPECT_EQ(PROFILING_FAILED, task->GetHostAndDeviceInfo());
    MOCKER(analysis::dvvp::common::utils::Utils::JoinPath)
        .stubs()
        .will(returnValue(std::string("/tmp/profing_utest/profiling_utest_info.xml.done")))
        .then(returnValue(std::string("/tmp/profing_utest/profiling_utest_info.xml.done")))
        .then(returnValue(std::string("/tmp/profing_utest/profiling_utest_info.xml.done")))
        .then(returnValue(std::string("/tmp/profiling_utest_info.xml.done")));
    EXPECT_EQ(PROFILING_FAILED, task->GetHostAndDeviceInfo());
    EXPECT_EQ(PROFILING_FAILED, task->GetHostAndDeviceInfo());
    remove("/tmp/profiling_utest_info.xml.done");
    param_->profiling_mode = dumpMode;
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

static std::shared_ptr<analysis::dvvp::host::ProfTask> task_run;

TEST_F(HOST_PROF_TASK_TEST, run) {
    GlobalMockObject::verify();

    MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(EN_OK));

    task_run = std::shared_ptr<analysis::dvvp::host::ProfTask>(new analysis::dvvp::host::ProfTask(_devices, param_));
    EXPECT_NE(nullptr, task_run);

    EXPECT_EQ(PROFILING_SUCCESS, task_run->Init());

    MOCKER(analysis::dvvp::driver::DrvGetDevNum)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(1));

    MOCKER(analysis::dvvp::driver::DrvGetDevIds)
        .stubs()
        .will(invoke(_drv_get_dev_ids));

    MOCKER_CPP(&analysis::dvvp::transport::Uploader::Flush)
        .stubs();

    MOCKER(IdeSockWriteData)
        .stubs()
        .will(returnValue(0));

    MOCKER_CPP(&analysis::dvvp::host::ProfTask::ProcessDefMode)
        .stubs()
        .will(ignoreReturnValue());

    MOCKER_CPP(&analysis::dvvp::host::ProfTask::ProcessSystemWide)
        .stubs()
        .will(ignoreReturnValue());

    MOCKER_CPP(&analysis::dvvp::host::ProfTask::GetHostAndDeviceInfo)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    std::shared_ptr<analysis::dvvp::message::StatusInfo> status(
        new analysis::dvvp::message::StatusInfo());
    status->status = analysis::dvvp::message::SUCCESS;

    MOCKER_CPP(&analysis::dvvp::host::Device::GetStatus)
        .stubs()
        .will(returnValue(status));
    MOCKER_CPP(&analysis::dvvp::host::Device::Wait)
        .stubs()
        .will(returnValue(0));

    MOCKER_CPP(&analysis::dvvp::host::ProfManager::CreateStateFile)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    task_run->Run();
}


TEST_F(HOST_PROF_TASK_TEST, run1) {
    GlobalMockObject::verify();

    task_run = std::shared_ptr<analysis::dvvp::host::ProfTask>(new analysis::dvvp::host::ProfTask(_devices, param_));
    EXPECT_NE(nullptr, task_run);

    MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(EN_OK));

    MOCKER_CPP(&analysis::dvvp::transport::Uploader::Flush)
        .stubs();

    EXPECT_EQ(PROFILING_SUCCESS, task_run->Init());

    MOCKER(analysis::dvvp::driver::DrvGetDevNum)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(1));

    MOCKER(analysis::dvvp::driver::DrvGetDevIds)
        .stubs()
        .will(invoke(_drv_get_dev_ids));

    MOCKER(IdeSockWriteData)
        .stubs()
        .will(returnValue(0));

    MOCKER_CPP(&analysis::dvvp::host::ProfTask::ProcessDefMode)
        .stubs()
        .will(ignoreReturnValue());

    MOCKER_CPP(&analysis::dvvp::host::ProfTask::ProcessSystemWide)
        .stubs()
        .will(ignoreReturnValue());

    MOCKER_CPP(&analysis::dvvp::host::ProfTask::GetHostAndDeviceInfo)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER(pthread_create)
        .stubs()
        .will(returnValue(-1));

    std::shared_ptr<analysis::dvvp::message::StatusInfo> status(
        new analysis::dvvp::message::StatusInfo());
    status->status = analysis::dvvp::message::SUCCESS;

    MOCKER_CPP(&analysis::dvvp::host::Device::GetStatus)
        .stubs()
        .will(returnValue(status));
    MOCKER_CPP(&analysis::dvvp::host::Device::Wait)
        .stubs()
        .will(returnValue(0));

    MOCKER_CPP(&analysis::dvvp::host::ProfManager::CreateStateFile)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    task_run->devicesMap_["0"] = std::shared_ptr<analysis::dvvp::host::Device>(new Device(task_run->params_, "1"));
    task_run->devicesMap_["0"]->Init();
    //def_mode
    task_run->params_->profiling_mode = PROFILING_MODE_DEF;
    task_run->Run();
}

TEST_F(HOST_PROF_TASK_TEST, run2) {
    GlobalMockObject::verify();

    task_run = std::shared_ptr<analysis::dvvp::host::ProfTask>(new analysis::dvvp::host::ProfTask(_devices, param_));
    EXPECT_NE(nullptr, task_run);

    MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(EN_OK));

    MOCKER_CPP(&analysis::dvvp::transport::Uploader::Flush)
        .stubs();

    EXPECT_EQ(PROFILING_SUCCESS, task_run->Init());

    MOCKER(analysis::dvvp::driver::DrvGetDevNum)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(1));

    MOCKER(analysis::dvvp::driver::DrvGetDevIds)
        .stubs()
        .will(invoke(_drv_get_dev_ids));

    MOCKER(IdeSockWriteData)
        .stubs()
        .will(returnValue(0));

    MOCKER_CPP(&analysis::dvvp::host::ProfTask::ProcessDefMode)
        .stubs()
        .will(ignoreReturnValue());

    MOCKER_CPP(&analysis::dvvp::host::ProfTask::ProcessSystemWide)
        .stubs()
        .will(ignoreReturnValue());
    MOCKER_CPP(&analysis::dvvp::host::ProfTask::GetHostAndDeviceInfo)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER(pthread_create)
        .stubs()
        .will(returnValue(-1));

    std::shared_ptr<analysis::dvvp::message::StatusInfo> status(
        new analysis::dvvp::message::StatusInfo());
    status->status = analysis::dvvp::message::SUCCESS;

    MOCKER_CPP(&analysis::dvvp::host::Device::GetStatus)
        .stubs()
        .will(returnValue(status));
    MOCKER_CPP(&analysis::dvvp::host::Device::Wait)
        .stubs()
        .will(returnValue(0));

    MOCKER_CPP(&analysis::dvvp::host::ProfManager::CreateStateFile)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    task_run->devicesMap_["0"] = std::shared_ptr<analysis::dvvp::host::Device>(new Device(task_run->params_, "1"));
    task_run->devicesMap_["0"]->Init();

    //system_wide
    task_run->params_->profiling_mode = PROFILING_MODE_SYSTEM_WIDE;
    task_run->Run();
}

/////////////////////////////////////////////////////////////////////////////

TEST_F(HOST_PROF_TASK_TEST, ProcessDefMode) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::host::ProfTask> task(new analysis::dvvp::host::ProfTask(_devices, param_));
    EXPECT_NE(nullptr, task);
    task->devicesMap_["0"] = std::shared_ptr<analysis::dvvp::host::Device>(new Device(task->params_, "0"));
    EXPECT_EQ(PROFILING_SUCCESS, task->devicesMap_["0"]->Init());

    MOCKER_CPP(&analysis::dvvp::host::ProfTask::IsQuit)
        .stubs()
        .then(returnValue(true));

    MOCKER_CPP(&analysis::dvvp::host::ProfTask::StartDevices)
        .stubs();

    task->ProcessDefMode();
}

TEST_F(HOST_PROF_TASK_TEST, ProcessSyetemWide) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::host::ProfTask> task(new analysis::dvvp::host::ProfTask(_devices, param_));
    EXPECT_NE(nullptr, task);
    std::shared_ptr<analysis::dvvp::message::Status> status(new analysis::dvvp::message::Status());
    task->taskStatus_ = status;
    task->devicesMap_["0"] = std::shared_ptr<analysis::dvvp::host::Device>(new Device(task->params_, "0"));
    EXPECT_EQ(PROFILING_SUCCESS, task->devicesMap_["0"]->Init());
    MOCKER_CPP(&analysis::dvvp::host::ProfTask::IsQuit)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));

    MOCKER_CPP(&analysis::dvvp::host::ProfTask::StartDevices)
        .stubs()
        .will(ignoreReturnValue());

    const std::string path = "/tmp/profiler_st/devicetest/";
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetDataDir)
        .stubs()
        // .will(returnValue(""))
        .will(returnValue(path));
    task->ProcessSystemWide();
    task->ProcessSystemWide();
    param_->profiling_period = 1;
    task->ProcessSystemWide();

}

TEST_F(HOST_PROF_TASK_TEST, ProcessRemote) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::host::ProfTask> task(new analysis::dvvp::host::ProfTask(_devices, param_));
    EXPECT_NE(nullptr, task);
    std::vector<std::string> currDevicesV;
    currDevicesV.push_back("");
    task->currDevicesV_ = currDevicesV;
    std::shared_ptr<analysis::dvvp::message::Status> status(new analysis::dvvp::message::Status());
    task->taskStatus_ = status;
    task->devicesMap_["0"] = std::shared_ptr<analysis::dvvp::host::Device>(new Device(task->params_, "0"));
    EXPECT_EQ(PROFILING_SUCCESS, task->devicesMap_["0"]->Init());
    MOCKER_CPP(&analysis::dvvp::host::ProfTask::IsQuit)
        .stubs()
        .will(returnValue(true));

    MOCKER_CPP(&analysis::dvvp::host::ProfTask::SendMsgAndHandleResponse)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    task->ProcessRemote();
    currDevicesV.push_back("1");
    task->currDevicesV_ = currDevicesV;
    MOCKER_CPP(&analysis::dvvp::host::Device::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    task->ProcessRemote();
    task->ProcessRemote();
}


TEST_F(HOST_PROF_TASK_TEST, ProcessSyetemWideForGetHostAndDeviceTime) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::host::ProfTask> task(new analysis::dvvp::host::ProfTask(_devices, param_));
    EXPECT_NE(nullptr, task);
    std::shared_ptr<analysis::dvvp::message::Status> status(new analysis::dvvp::message::Status());
    task->taskStatus_ = status;
    task->devicesMap_["0"] = std::shared_ptr<analysis::dvvp::host::Device>(new Device(task->params_, "0"));
    EXPECT_EQ(PROFILING_SUCCESS, task->devicesMap_["0"]->Init());

    MOCKER_CPP(&analysis::dvvp::host::ProfTask::StartDevices)
        .stubs()
        .will(ignoreReturnValue());

    MOCKER_CPP(&analysis::dvvp::host::ProfTask::IsQuit)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));

    MOCKER_CPP(&analysis::dvvp::host::ProfManager::CreateStateFile)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    task->ProcessSystemWide();
    param_->profiling_period = 1;
    task->ProcessSystemWide();
}

TEST_F(HOST_PROF_TASK_TEST, StartDevices) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::host::ProfTask> task(new analysis::dvvp::host::ProfTask(_devices, param_));
    EXPECT_NE(nullptr, task);

    task->devicesMap_["0"] = std::shared_ptr<analysis::dvvp::host::Device>(new Device(task->params_, "1"));
    EXPECT_EQ(PROFILING_SUCCESS, task->devicesMap_["0"]->Init());
    param_->profiling_mode = PROFILING_MODE_DEF;

    std::vector<std::string> devices({"", "0", "1"});
    MOCKER_CPP(&analysis::dvvp::host::Device::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(EN_ERROR))
        .then(returnValue(EN_OK))
        .then(returnValue(EN_OK));
    //MOCKER_CPP(&analysis::dvvp::common::thread::Thread::Start)
    //    .stubs()
    //    .will(returnValue(PROFILING_FAILED))
    //    .then(returnValue(PROFILING_SUCCESS))
    //    .then(returnValue(PROFILING_SUCCESS));

    task->StartDevices(devices);
    task->StartDevices(devices);
    task->StartDevices(devices);
}

TEST_F(HOST_PROF_TASK_TEST, IsAllDevicesQuit) {

    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::host::ProfTask> task(new analysis::dvvp::host::ProfTask(_devices, param_));

    task->devicesMap_["0"] = std::shared_ptr<analysis::dvvp::host::Device>(new Device(task->params_, "0"));
    task->devicesMap_["0"]->Init();

    MOCKER_CPP(&analysis::dvvp::host::Device::GetIsQuited)
        .stubs()
        .will(returnValue(false));

    EXPECT_FALSE(task->IsAllDevicesQuit());
}
////////////////////////////////////////////////////
TEST_F(HOST_PROF_TASK_TEST, SetAllDevicesQuit) {

    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::host::ProfTask> task(new analysis::dvvp::host::ProfTask(_devices, param_));
    EXPECT_NE(nullptr, task);

    task->devicesMap_["0"] = std::shared_ptr<analysis::dvvp::host::Device>(new Device(task->params_, "0"));
    task->devicesMap_["0"]->Init();
    EXPECT_EQ(PROFILING_SUCCESS, task->devicesMap_["0"]->Init());

    task->SetAllDevicesQuit();
}
//////////////////////////////////////////////////

TEST_F(HOST_PROF_TASK_TEST, GetTaskProfilingMode) {

    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::host::ProfTask> task(new analysis::dvvp::host::ProfTask(_devices, nullptr));

    std::string profilingMode = task->GetTaskProfilingMode();
    EXPECT_TRUE(profilingMode.empty());

    std::shared_ptr<analysis::dvvp::host::ProfTask> task1(new analysis::dvvp::host::ProfTask(_devices, param_));

    profilingMode = task1->GetTaskProfilingMode();
    EXPECT_TRUE(profilingMode.empty());
}
