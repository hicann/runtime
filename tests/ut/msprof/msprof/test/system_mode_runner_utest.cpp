/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <chrono>
#include <csignal>
#include <memory>
#include <string>
#include <vector>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "errno/error_code.h"
#include "platform/platform.h"
#include "prof_acl_mgr.h"
#include "config_manager.h"
#include "transport/file_transport.h"

#define private public
#define protected public
#include "runtime_system_mode_runner.h"
#undef protected
#undef private

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::message;

class SYSTEM_MODE_RUNNER_UTEST : public testing::Test {
protected:
    void SetUp() override
    {
        GlobalMockObject::reset();
        hostJobCount_ = 0;
    }

    void TearDown() override { GlobalMockObject::verify(); }

    static int32_t HostJob()
    {
        ++hostJobCount_;
        return PROFILING_SUCCESS;
    }

    static bool SigintShutdownInProgress() { return true; }

    static int32_t hostJobCount_;
};

int32_t SYSTEM_MODE_RUNNER_UTEST::hostJobCount_ = 0;

TEST_F(SYSTEM_MODE_RUNNER_UTEST, StartSysTaskStartsHostAndDevicesInOrder)
{
    auto params = std::make_shared<ProfileParams>();
    params->devices = "0,1";
    params->profiling_period = 0;
    params->host_cpu_profiling = "on";
    analysis::dvvp::runner::RuntimeSystemModeRunner runner(params, "PROF_test");

    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::RecordOutPut)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::StartHostJobs)
        .stubs()
        .will(invoke(&SYSTEM_MODE_RUNNER_UTEST::HostJob));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::StartDeviceJobs)
        .expects(exactly(2))
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::StopTask).stubs();

    EXPECT_EQ(PROFILING_SUCCESS, runner.StartSysTask());
    EXPECT_EQ(1, hostJobCount_);
}

TEST_F(SYSTEM_MODE_RUNNER_UTEST, WaitSysTaskReturnsImmediatelyWithoutPeriod)
{
    auto params = std::make_shared<ProfileParams>();
    params->profiling_period = 0;
    analysis::dvvp::runner::RuntimeSystemModeRunner runner(params, "PROF_test");

    EXPECT_EQ(PROFILING_SUCCESS, runner.WaitSysTask());
}

TEST_F(SYSTEM_MODE_RUNNER_UTEST, WaitSysTaskReportsEarlySignalExit)
{
    auto params = std::make_shared<ProfileParams>();
    params->profiling_period = 60;
    analysis::dvvp::runner::RuntimeSystemModeRunner runner(params, "PROF_test");

    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::IsSigintShutdownInProgress)
        .stubs()
        .will(invoke(&SYSTEM_MODE_RUNNER_UTEST::SigintShutdownInProgress));
    MOCKER(Utils::UsleepInterupt).stubs();

    EXPECT_EQ(PROFILING_SUCCESS, runner.WaitSysTask());
}

TEST_F(SYSTEM_MODE_RUNNER_UTEST, DeviceFailureStopsStartedTasks)
{
    auto params = std::make_shared<ProfileParams>();
    params->devices = "0,1";
    params->profiling_period = 0;
    analysis::dvvp::runner::RuntimeSystemModeRunner runner(params, "PROF_test");

    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::RecordOutPut)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::StartDeviceJobs)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::StartHostJobs)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::StopTask).expects(once());

    EXPECT_EQ(PROFILING_FAILED, runner.StartSysTask());
}

TEST_F(SYSTEM_MODE_RUNNER_UTEST, SigintInterruptsWaitWithoutLongBlocking)
{
    auto params = std::make_shared<ProfileParams>();
    params->host_cpu_profiling = "on";
    params->profiling_period = 60; // 60s. SIGINT must prevent the full wait.

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformInitByDriver)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::IsSigintShutdownInProgress)
        .stubs()
        .will(invoke(&SYSTEM_MODE_RUNNER_UTEST::SigintShutdownInProgress));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::RecordOutPut)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::StartHostJobs)
        .stubs()
        .will(invoke(&SYSTEM_MODE_RUNNER_UTEST::HostJob));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::StopTask).stubs();

    const auto begin = std::chrono::steady_clock::now();
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::runner::RuntimeSystemModeRunner::Run(params, "PROF_test"));
    const auto elapsed = std::chrono::steady_clock::now() - begin;
    EXPECT_LT(std::chrono::duration_cast<std::chrono::milliseconds>(elapsed).count(), 500);
}

TEST_F(SYSTEM_MODE_RUNNER_UTEST, CreateUploaderAndSampleJsonFailures)
{
    auto params = std::make_shared<ProfileParams>();
    analysis::dvvp::runner::RuntimeSystemModeRunner runner(params, "PROF_test");

    EXPECT_EQ(PROFILING_FAILED, runner.CreateUploader("", ""));

    MOCKER_CPP(&analysis::dvvp::transport::FileTransportFactory::CreateFileTransport)
        .stubs()
        .will(returnValue(std::shared_ptr<analysis::dvvp::transport::ITransport>()));
    EXPECT_EQ(PROFILING_FAILED, runner.CreateUploader("job", "/tmp"));

    MOCKER_CPP(&analysis::dvvp::common::utils::Utils::CreateDir).stubs().will(returnValue(PROFILING_FAILED));
    EXPECT_FALSE(runner.CreateSampleJsonFile(params, "/tmp/not-exist/sample.json"));
}

TEST_F(SYSTEM_MODE_RUNNER_UTEST, CreateDoneFileAndExistingCtrlFile)
{
    auto params = std::make_shared<ProfileParams>();
    analysis::dvvp::runner::RuntimeSystemModeRunner runner(params, "PROF_test");
    const std::string ctrlPath = "/tmp/st_ctrl_existing_utest";
    const std::string donePath = ctrlPath + ".done";
    (void)remove(ctrlPath.c_str());
    (void)remove(donePath.c_str());

    EXPECT_FALSE(runner.CreateDoneFile("/tmp/not-exist/st_ctrl_utest.done", "10"));
    EXPECT_EQ(PROFILING_SUCCESS, runner.WriteCtrlDataToFile(ctrlPath, "data", 4));
    EXPECT_EQ(PROFILING_SUCCESS, runner.WriteCtrlDataToFile(ctrlPath, "data2", 5));

    EXPECT_TRUE(runner.CreateDoneFile(donePath, "10"));
    EXPECT_EQ(0, remove(donePath.c_str()));
    EXPECT_EQ(0, remove(ctrlPath.c_str()));
}

TEST_F(SYSTEM_MODE_RUNNER_UTEST, StartTaskFailures)
{
    auto params = std::make_shared<ProfileParams>();
    params->result_dir = "/tmp";
    analysis::dvvp::runner::RuntimeSystemModeRunner runner(params, "PROF_test");

    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::CreateJobDir)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::GenerateHostParam)
        .stubs()
        .will(returnValue(std::shared_ptr<ProfileParams>()));
    EXPECT_EQ(PROFILING_FAILED, runner.StartHostTask("/tmp", 0));

    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::GenerateHostParam).stubs().will(returnValue(params));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::CreateSampleJsonFile).stubs().will(returnValue(false));
    EXPECT_EQ(PROFILING_FAILED, runner.StartHostTask("/tmp", 0));

    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::CreateSampleJsonFile).stubs().will(returnValue(true));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::CreateUploader)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(PROFILING_FAILED, runner.StartHostTask("/tmp", 0));

    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::GenerateDeviceParam)
        .stubs()
        .will(returnValue(std::shared_ptr<ProfileParams>()));
    EXPECT_EQ(PROFILING_FAILED, runner.StartDeviceTask("/tmp", "0"));

    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::GenerateDeviceParam).stubs().will(returnValue(params));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::CreateUploader)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(PROFILING_FAILED, runner.StartDeviceTask("/tmp", "0"));
}

TEST_F(SYSTEM_MODE_RUNNER_UTEST, RunnerBatchGapCoverage)
{
    auto params = std::make_shared<ProfileParams>();
    params->result_dir = "/tmp";
    params->devices = "0,1";
    params->profiling_period = 10;
    params->host_cpu_profiling = "on";
    params->cpu_profiling = "off";
    params->sys_profiling = "off";
    params->pid_profiling = "off";
    params->ai_core_profiling_mode = "task-based";
    analysis::dvvp::runner::RuntimeSystemModeRunner runner(params, "PROF_test");

    auto hostParams = runner.GenerateHostParam(params);
    EXPECT_NE(nullptr, hostParams);
    EXPECT_EQ("task-based", hostParams->ai_core_profiling_mode);
    auto deviceParams = runner.GenerateDeviceParam(params);
    EXPECT_NE(nullptr, deviceParams);
    EXPECT_EQ("/tmp", deviceParams->result_dir);
    EXPECT_FALSE(runner.IsDeviceJob());

    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::RecordOutPut)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::StartHostJobs)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::StopTask).stubs();
    EXPECT_EQ(PROFILING_FAILED, runner.StartSysTask());

    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::runner::RuntimeSystemModeRunner::Run(nullptr, "dir"));
    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::runner::RuntimeSystemModeRunner::Run(params, ""));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformInitByDriver)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::runner::RuntimeSystemModeRunner::Run(params, "dir"));
}

TEST_F(SYSTEM_MODE_RUNNER_UTEST, RunnerFileAndJobDirBatch)
{
    auto params = std::make_shared<ProfileParams>();
    params->result_dir = "/tmp/st_runner_batch";
    params->msprofBinPid = 123;
    analysis::dvvp::runner::RuntimeSystemModeRunner runner(params, "PROF_batch");

    std::string resultDir;
    MOCKER_CPP(analysis::dvvp::common::utils::Utils::CreateDir).stubs().will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_SUCCESS, runner.CreateJobDir("0", resultDir));
    EXPECT_FALSE(resultDir.empty());

    (void)system("rm -rf /tmp/st_runner_batch && mkdir -p /tmp/st_runner_batch");
    EXPECT_EQ(PROFILING_SUCCESS, runner.RecordOutPut());
    EXPECT_TRUE(runner.CreateDoneFile("/tmp/st_runner_batch.done", "10"));
    EXPECT_EQ(PROFILING_SUCCESS, runner.WriteCtrlDataToFile("/tmp/st_runner_batch.ctrl", "data", 4));

    EXPECT_EQ(PROFILING_FAILED, runner.WriteCtrlDataToFile("/tmp/st_runner_batch.empty", "", 0));
    EXPECT_EQ(PROFILING_FAILED, runner.WriteCtrlDataToFile("/not-exist/st_ctrl", "data", 4));
    EXPECT_TRUE(runner.CreateSampleJsonFile(params, ""));

    const std::string tmpFile = "/tmp/st_runner_batch/ctrl-noexist";
    EXPECT_EQ(PROFILING_FAILED, runner.WriteCtrlDataToFile("/not-exist/st_ctrl", "data", 4));
    EXPECT_EQ(PROFILING_SUCCESS, runner.WriteCtrlDataToFile(tmpFile, "data", 4));
    EXPECT_EQ(PROFILING_SUCCESS, runner.WriteCtrlDataToFile(tmpFile, "data2", 5));
    EXPECT_EQ(PROFILING_FAILED, runner.CreateUploader("", "/tmp"));
    EXPECT_EQ(PROFILING_FAILED, runner.CreateUploader("job", ""));

    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::CreateJobDir)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::StartHostTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(PROFILING_FAILED, runner.StartHostJobs());

    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::StartDeviceTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(PROFILING_FAILED, runner.StartDeviceJobs("not-number"));
}

TEST_F(SYSTEM_MODE_RUNNER_UTEST, RunnerRecordOutPutUsesSecureWriteFile)
{
    auto params = std::make_shared<ProfileParams>();
    params->result_dir = "/tmp/st_runner_record";
    params->msprofBinPid = 123;
    analysis::dvvp::runner::RuntimeSystemModeRunner runner(params, "PROF_record");
    (void)system("rm -rf /tmp/st_runner_record && mkdir -p /tmp/st_runner_record");

    EXPECT_EQ(PROFILING_SUCCESS, runner.RecordOutPut());
    struct stat fileStat = {};
    const std::string record = "/tmp/st_runner_record/123_profiling_output_record";
    ASSERT_EQ(0, stat(record.c_str(), &fileStat));
    EXPECT_TRUE(S_ISREG(fileStat.st_mode));
    EXPECT_EQ(static_cast<mode_t>(0640), fileStat.st_mode & 0777);
    (void)system("rm -rf /tmp/st_runner_record");
}

TEST_F(SYSTEM_MODE_RUNNER_UTEST, RunnerNullParamsAndFileFailurePaths)
{
    auto params = std::make_shared<ProfileParams>();
    analysis::dvvp::runner::RuntimeSystemModeRunner nullRunner(params, "PROF_null");
    EXPECT_EQ(nullptr, nullRunner.GenerateHostParam(nullptr));
    EXPECT_EQ(nullptr, nullRunner.GenerateDeviceParam(nullptr));

    params->result_dir = "/tmp/st_runner_fail";
    params->msprofBinPid = 123;
    analysis::dvvp::runner::RuntimeSystemModeRunner failRunner(params, "PROF_fail");
    EXPECT_EQ(PROFILING_FAILED, failRunner.RecordOutPut());
    EXPECT_FALSE(failRunner.CreateDoneFile("/tmp/not-exist/st_ctrl.done", "1"));
    EXPECT_EQ(PROFILING_FAILED, failRunner.WriteCtrlDataToFile("/tmp/st_runner_fail.empty", "", 0));
    EXPECT_EQ(PROFILING_FAILED, failRunner.WriteCtrlDataToFile("/not-exist/st_ctrl", "data", 4));
    EXPECT_EQ(PROFILING_FAILED, failRunner.CreateUploader("", "/tmp"));
    EXPECT_EQ(PROFILING_FAILED, failRunner.CreateUploader("job", ""));
}

TEST_F(SYSTEM_MODE_RUNNER_UTEST, RunnerStartDeviceJobFailurePaths)
{
    auto params = std::make_shared<ProfileParams>();
    params->result_dir = "/tmp";
    params->devices = "0";
    params->cpu_profiling = "on";
    analysis::dvvp::runner::RuntimeSystemModeRunner runner(params, "PROF_device");

    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::CreateJobDir)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(PROFILING_FAILED, runner.StartDeviceJobs("0"));

    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::CreateJobDir)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::StartHostTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(PROFILING_FAILED, runner.StartDeviceJobs("0"));

    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::StartHostTask)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsSocSide).stubs().will(returnValue(false));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::MINI_V3_TYPE));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::StartDeviceTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(PROFILING_FAILED, runner.StartDeviceJobs("0"));
}
