/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <set>
#include "mockcpp/mockcpp.hpp"
#include "gtest/gtest.h"
#include <iostream>
#include "errno/error_code.h"
#include "running_mode.h"
#include "utils/utils.h"
#include "config/config.h"
#include "config_manager.h"
#include "transport/file_transport.h"
#include "transport/uploader_mgr.h"
#include "input_parser.h"
#include "application.h"
#include "platform/platform.h"
#include <fstream>
#include <memory>
#include "dyn_prof_client.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::transport;
using namespace Analysis::Dvvp::Common::Config;
using namespace Analysis::Dvvp::Common::Platform;
using namespace Analysis::Dvvp::Msprof;
using namespace Collector::Dvvp::Msprofbin;
using namespace Collector::Dvvp::DynProf;

class RUNNING_MODE_UTEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(RUNNING_MODE_UTEST, ConvertParamsSetToString)
{
    std::set<int> srcSet;
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::AppMode rMode("app", params);
    EXPECT_EQ("", rMode.ConvertParamsSetToString(srcSet));
    srcSet = {0, 1};
    EXPECT_EQ("--help --output", rMode.ConvertParamsSetToString(srcSet));
}

TEST_F(RUNNING_MODE_UTEST, CheckForbiddenParams)
{
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::AppMode rMode("app", params);
    EXPECT_EQ(PROFILING_FAILED, rMode.CheckForbiddenParams());
    params->app = "123";
    EXPECT_EQ(PROFILING_FAILED, rMode.CheckForbiddenParams());
    params->usedParams = {1, 2, 3};
    rMode.blackSet_ = {1, 5 ,6};
    EXPECT_EQ(PROFILING_FAILED, rMode.CheckForbiddenParams());
    rMode.blackSet_.clear();
    rMode.blackSet_ = {5 ,6};
    EXPECT_EQ(PROFILING_SUCCESS, rMode.CheckForbiddenParams());
}

TEST_F(RUNNING_MODE_UTEST, CheckNeccessaryParams)
{
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::AppMode rMode("app", params);
    EXPECT_EQ(PROFILING_FAILED, rMode.CheckNeccessaryParams());
    params->app = "123";
    EXPECT_EQ(PROFILING_FAILED, rMode.CheckNeccessaryParams());
    params->usedParams = {1, 2, 3};
    rMode.neccessarySet_ = {1, 5 ,6};
    EXPECT_EQ(PROFILING_FAILED, rMode.CheckNeccessaryParams());
    params->usedParams.clear();
    params->usedParams = {1, 5, 6, 0};
    EXPECT_EQ(PROFILING_SUCCESS, rMode.CheckNeccessaryParams());
}

TEST_F(RUNNING_MODE_UTEST, OutputUselessParams)
{
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::AppMode rMode("app", params);
    rMode.OutputUselessParams();
    params->usedParams = {1, 2, 3};
    rMode.whiteSet_ = {1, 5 ,6};

    std::stringstream output;
    std::streambuf* oldCoutBuffer = std::cout.rdbuf();
    std::cout.rdbuf(output.rdbuf());

    rMode.OutputUselessParams();
    std::vector<std::string> expectedList = {"The argument --storage-limit --application is useless when --app is not empty"};

    std::cout.rdbuf(oldCoutBuffer);
    for (auto expectedPrint : expectedList) {
        EXPECT_NE(output.str().find(expectedPrint), std::string::npos) 
            <<"Screen print:" << std::endl << output.str() << std::endl << "Missing expected: " + expectedPrint;
    }
    rMode.UpdateOutputDirInfo();
}

TEST_F(RUNNING_MODE_UTEST, GetOutputDirInfoFromParams)
{
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::AppMode rMode("app", params);
    params->result_dir = "123";
    EXPECT_EQ(PROFILING_SUCCESS, rMode.GetOutputDirInfoFromParams()); 
    EXPECT_EQ("123", rMode.jobResultDir_);
    EXPECT_EQ(PROFILING_FAILED, rMode.GetOutputDirInfoFromParams()); 
}

TEST_F(RUNNING_MODE_UTEST, GetOutputDirInfoFromRecord)
{
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::AppMode rMode("app", params);
    std::string result = "/tmp/running_mode_ut";
    rMode.jobResultDir_ = "123";
    EXPECT_EQ(PROFILING_FAILED, rMode.GetOutputDirInfoFromRecord());
    rMode.jobResultDir_.clear();
    MOCKER(Utils::GetPid)
        .stubs()
        .will(returnValue(1));
    MOCKER(Utils::GetFileSize)
        .stubs()
        .will(returnValue((2 * 1024 * 1024 + 1)));
    EXPECT_EQ(PROFILING_FAILED, rMode.GetOutputDirInfoFromRecord());
    GlobalMockObject::verify();

    MOCKER(Utils::GetPid)
        .stubs()
        .will(returnValue(1));
    params->result_dir = result;
    Utils::CreateDir(result);
    std::ofstream out;
    out.open(result + '/' + "1_" + OUTPUT_RECORD);
    out << "PROF_000001_20211211194055303_DANEQIJKACHMDGNB" << std::endl << "JOB44444444444" <<  std::endl;
    out.close();
    EXPECT_EQ(PROFILING_SUCCESS, rMode.GetOutputDirInfoFromRecord());

    rMode.jobResultDir_.clear();
    params->result_dir = "/tmp/profiling_output_r";
    EXPECT_EQ(PROFILING_FAILED, rMode.GetOutputDirInfoFromRecord());
    Utils::RemoveDir(result);
}

int32_t g_remove = 0;
int32_t removeStub(const char *data)
{
    g_remove++;
    return EOK;
}

TEST_F(RUNNING_MODE_UTEST, RemoveRecordFile)
{
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::AppMode rMode("app", params);
    std::string filename = "123";
    rMode.RemoveRecordFile(filename);
    MOCKER(Utils::IsFileExist)
        .stubs()
        .will(returnValue(true));
    rMode.RemoveRecordFile(filename);
    MOCKER(remove)
        .stubs()
        .will(invoke(removeStub));
    rMode.RemoveRecordFile(filename);
    EXPECT_EQ(g_remove, 1);
}

static int _drv_get_dev_ids(int num_devices, std::vector<int> & dev_ids)
{
    static int phase = 0;
    if (phase == 0) {
        phase++;
        return PROFILING_FAILED;
    }

    if (phase >= 1) {
        dev_ids.push_back(0);
        dev_ids.push_back(1);
        return PROFILING_SUCCESS;
    }
}

TEST_F(RUNNING_MODE_UTEST, HandleProfilingParams)
{
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::AppMode rMode("app", nullptr);
    EXPECT_EQ(PROFILING_FAILED, rMode.HandleProfilingParams());
    rMode.params_ = params;
    params->devices = "all";
    std::string resStr = "0,1";
    MOCKER(&analysis::dvvp::driver::DrvGetDevIdsStr)
        .stubs()
        .will(returnValue(resStr));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::GetAicoreEvents)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.HandleProfilingParams());
    EXPECT_EQ(PROFILING_SUCCESS, rMode.HandleProfilingParams());
    MOCKER_CPP(&ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(2))
        .then(returnValue(5))
        .then(returnValue(7));
    EXPECT_EQ(PROFILING_SUCCESS, rMode.HandleProfilingParams());
    EXPECT_EQ(PROFILING_SUCCESS, rMode.HandleProfilingParams());
    EXPECT_EQ(PROFILING_SUCCESS, rMode.HandleProfilingParams());
}

std::vector<std::string> g_argv;
int32_t ExecCmdStub(const ExecCmdParams &execCmdParams, const std::vector<std::string> &argv,
    const std::vector<std::string> &envp, int &exitCodeP, OsalProcess &childProcess)
{
    g_argv = argv;
    return PROFILING_SUCCESS;
}
TEST_F(RUNNING_MODE_UTEST, StopRunningTasks)
{
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::AppMode rMode("app", params);
    rMode.StopRunningTasks();

    MOCKER(Utils::ExecCmd)
        .stubs()
        .will(invoke(ExecCmdStub));
    rMode.taskPid_ = 11111;
    rMode.StopRunningTasks();
    EXPECT_EQ(g_argv.size(), 1);
    if (g_argv.size() == 1) {
        EXPECT_EQ(g_argv[0], "11111");
    }
}

TEST_F(RUNNING_MODE_UTEST, StartParseTask)
{
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::AppMode rMode("app", params);
    rMode.isQuit_ = true;
    EXPECT_EQ(PROFILING_FAILED, rMode.StartParseTask());
    rMode.isQuit_ = false;
    rMode.taskPid_ = 1111;
    EXPECT_EQ(PROFILING_FAILED, rMode.StartParseTask());
    rMode.taskPid_ = MSVP_PROCESS;
    EXPECT_EQ(PROFILING_FAILED, rMode.StartParseTask());
    rMode.jobResultDir_ = "123";
    rMode.analysisPath_ = "path_test";
    MOCKER(Utils::ExecCmd)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartParseTask());
    MOCKER_CPP(&RunningMode::WaitRunningProcess)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartParseTask());
    EXPECT_EQ(PROFILING_SUCCESS, rMode.StartParseTask());
}

TEST_F(RUNNING_MODE_UTEST, StartQueryTask)
{
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::AppMode rMode("app", params);
    rMode.isQuit_ = true;
    EXPECT_EQ(PROFILING_FAILED, rMode.StartQueryTask());
    rMode.isQuit_ = false; 
    rMode.taskPid_ = 1111;
    EXPECT_EQ(PROFILING_FAILED, rMode.StartQueryTask());
    rMode.taskPid_ = MSVP_PROCESS;
    EXPECT_EQ(PROFILING_FAILED, rMode.StartQueryTask());
    rMode.jobResultDir_ = "123";
    rMode.analysisPath_ = "path_test";
    MOCKER(Utils::ExecCmd)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartQueryTask());
    MOCKER_CPP(&RunningMode::WaitRunningProcess)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartQueryTask());
    EXPECT_EQ(PROFILING_SUCCESS, rMode.StartQueryTask());
}

TEST_F(RUNNING_MODE_UTEST, StartExportTask){
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::AppMode rMode("app", params);
    rMode.isQuit_ = true;
    EXPECT_EQ(PROFILING_FAILED, rMode.StartExportTask());
    rMode.isQuit_ = false;
    rMode.taskPid_ = 1111;
    EXPECT_EQ(PROFILING_FAILED, rMode.StartExportTask());
    rMode.taskPid_ = MSVP_PROCESS;
    EXPECT_EQ(PROFILING_FAILED, rMode.StartExportTask());
    rMode.jobResultDir_ = "123";
    rMode.analysisPath_ = "path_test";
    params->exportModelId = 1;
    params->exportIterationId = 1;
    MOCKER_CPP(&RunningMode::RunExportSummaryTask).stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartExportTask());
    MOCKER_CPP(&RunningMode::RunExportTimelineTask).stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartExportTask());
    GlobalMockObject::verify();

    // export summary
    MOCKER(Utils::ExecCmd)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    
    EXPECT_EQ(PROFILING_FAILED, rMode.StartExportTask());
    MOCKER_CPP(&RunningMode::WaitRunningProcess)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartExportTask());

    GlobalMockObject::verify();
    // export timeline
    MOCKER(Utils::ExecCmd)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&RunningMode::WaitRunningProcess)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartExportTask());
    EXPECT_EQ(PROFILING_FAILED, rMode.StartExportTask());
    EXPECT_EQ(PROFILING_SUCCESS, rMode.StartExportTask());
}

TEST_F(RUNNING_MODE_UTEST, StopNoWait) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    std::shared_ptr<Collector::Dvvp::Msprofbin::AppMode> rMode(
    new Collector::Dvvp::Msprofbin::AppMode("app", params));

    MOCKER_CPP_VIRTUAL((Collector::Dvvp::Msprofbin::RunningMode*)rMode.get(),
        &Collector::Dvvp::Msprofbin::AppMode::UpdateOutputDirInfo).stubs();

    std::stringstream output;
    std::streambuf* oldCoutBuffer = std::cout.rdbuf();
    std::cout.rdbuf(output.rdbuf());
    rMode->StopNoWait();
    std::vector<std::string> expectedList = {"Receive stop singal."};
    std::cout.rdbuf(oldCoutBuffer);
    for (auto expectedPrint : expectedList) {
        EXPECT_NE(output.str().find(expectedPrint), std::string::npos) 
            <<"Screen print:" << std::endl << output.str() << std::endl << "Missing expected: " + expectedPrint;
    }
}


static int _wait_process(int taskPid_, bool &isExited, int &exitCode, bool s){
    static int phase2 = 0;
    if (phase2 == 0){
        phase2++;
        return PROFILING_FAILED;
    }

    if (phase2 == 4){
        isExited = true;
        return PROFILING_SUCCESS;
    }

    if (phase2 == 3){
        phase2++;
        return PROFILING_SUCCESS;
    }

    if (phase2 == 2){
        isExited = true;
        exitCode = 1;
        phase2++;
        return PROFILING_SUCCESS;
    }

    if (phase2 == 1){
        isExited = true;
        phase2++;
        return PROFILING_SUCCESS;
    }
}

TEST_F(RUNNING_MODE_UTEST, WaitRunningProcess){
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::AppMode rMode("app", params);
    EXPECT_EQ(PROFILING_FAILED, rMode.WaitRunningProcess("a"));
    rMode.taskPid_ = 11111;
    rMode.isQuit_ = false;
    MOCKER(Utils::WaitProcess)
        .stubs()
        .will(invoke(_wait_process));
    MOCKER_CPP(&AppMode::StopNoWait)
        .stubs();
    EXPECT_EQ(PROFILING_FAILED, rMode.WaitRunningProcess("a"));
    EXPECT_EQ(PROFILING_SUCCESS, rMode.WaitRunningProcess("a"));
    EXPECT_EQ(PROFILING_SUCCESS, rMode.WaitRunningProcess("a"));
    rMode.isQuit_ = true;
    EXPECT_EQ(PROFILING_SUCCESS, rMode.WaitRunningProcess("a"));
}

TEST_F(RUNNING_MODE_UTEST, GetRunningTask){
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::AppMode rMode("app", params);
    EXPECT_EQ(nullptr, rMode.GetRunningTask("1"));
    auto info = std::make_shared<Analysis::Dvvp::Msprof::ProfSocTask>(1, params);
    rMode.taskMap_.insert(std::make_pair("1", info));
    EXPECT_EQ(info, rMode.GetRunningTask("1"));
}

static int _get_cmd_print_info(const std::string &cmd, std::string &output,
    const unsigned int dataLength = MAX_CMD_PRINT_MESSAGE_LEN) 
{
    static int phase3 = 0;
    if (phase3 == 0){
        phase3++;
        return PROFILING_FAILED;
    }
    if (phase3 == 1){
        phase3++;
        output = "Python\n";
        return PROFILING_SUCCESS;
    }
    if (phase3 == 2){
        phase3++;
        output = "Python 3.a.3\n";
        return PROFILING_SUCCESS;
    }
    if (phase3 == 3){
        phase3++;
        output = "Python 3.5.3\n";
        return PROFILING_SUCCESS;
    }
    if (phase3 == 4){
        output = "Python 3.7.5\n";
        return PROFILING_SUCCESS;
    }
    
}

TEST_F(RUNNING_MODE_UTEST, CheckAnalysisEnv){
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::AppMode rMode("app", params);
    rMode.isQuit_=true;
    EXPECT_EQ(PROFILING_FAILED, rMode.CheckAnalysisEnv());
    rMode.isQuit_=false;
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    EXPECT_EQ(PROFILING_FAILED, rMode.CheckAnalysisEnv());

    std::string resValue = "/tmp/test/msprof";
    MOCKER(Utils::GetSelfPath)
        .stubs()
        .will(returnValue(resValue));
    
    MOCKER(Utils::SplitPath)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.CheckAnalysisEnv());
    MOCKER(Utils::IsFileExist)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    EXPECT_EQ(PROFILING_FAILED, rMode.CheckAnalysisEnv());
    MOCKER(mmAccess2).stubs()
        .will(returnValue(EN_ERR))
        .then(returnValue(EN_OK));
    EXPECT_EQ(PROFILING_FAILED, rMode.CheckAnalysisEnv());
    EXPECT_EQ(PROFILING_SUCCESS, rMode.CheckAnalysisEnv());    
}

TEST_F(RUNNING_MODE_UTEST, AppModeModeParamsCheck){
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::AppMode rMode("app", nullptr);
    EXPECT_EQ(PROFILING_FAILED, rMode.ModeParamsCheck());
    rMode.params_ = params;
    MOCKER_CPP(&RunningMode::HandleProfilingParams)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.ModeParamsCheck());
    EXPECT_EQ(PROFILING_SUCCESS, rMode.ModeParamsCheck());
}

TEST_F(RUNNING_MODE_UTEST, AppModeRunModeTasks){
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::AppMode rMode("app", nullptr);
    EXPECT_EQ(PROFILING_FAILED, rMode.RunModeTasks());
    rMode.params_ = params;
    rMode.jobResultDirList_.insert("PROF");
    MOCKER_CPP(&AppMode::StartAppTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&AppMode::CheckAnalysisEnv)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&AppMode::StartExportTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&AppMode::StartQueryTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.RunModeTasks());
    EXPECT_EQ(PROFILING_SUCCESS, rMode.RunModeTasks());
    EXPECT_EQ(PROFILING_SUCCESS, rMode.RunModeTasks());
    EXPECT_EQ(PROFILING_SUCCESS, rMode.RunModeTasks());
    EXPECT_EQ(PROFILING_SUCCESS, rMode.RunModeTasks());
    rMode.jobResultDirList_.clear();
    EXPECT_EQ(PROFILING_FAILED, rMode.RunModeTasks());
}

TEST_F(RUNNING_MODE_UTEST, AppModeSetDefaultParams){
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_V4_1_0));
    Platform::instance()->Init();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    params->taskTsfw = "on";
    Collector::Dvvp::Msprofbin::AppMode rMode("app", params);
    rMode.SetDefaultParams();
    EXPECT_EQ(params->acl, "on");
    EXPECT_EQ(params->ts_keypoint, "on");
    EXPECT_EQ(params->ai_core_profiling, "on");
    EXPECT_EQ(params->ai_core_profiling_mode, "task-based");

    params->ai_core_profiling = "on";
    EXPECT_EQ(params->aiv_profiling, "on");
    EXPECT_EQ(params->aiv_profiling_mode, "task-based");
    EXPECT_EQ(params->hwts_log, "");
    Platform::instance()->Uninit();
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::DC_TYPE));
    Platform::instance()->Init();
    rMode.SetDefaultParams();
    EXPECT_EQ(params->hwts_log, "on");
    Platform::instance()->Uninit();
}

TEST_F(RUNNING_MODE_UTEST, AppModeStartAppTask){
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::AppMode rMode("app", params);
    rMode.isQuit_ = true;
    EXPECT_EQ(PROFILING_FAILED, rMode.StartAppTask(true));
    rMode.isQuit_ = false;
    MOCKER(&analysis::dvvp::app::Application::LaunchApp)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&RunningMode::WaitRunningProcess)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartAppTask(true));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartAppTask(true));
    EXPECT_EQ(PROFILING_SUCCESS, rMode.StartAppTask(true));
}

TEST_F(RUNNING_MODE_UTEST, AppModeStartAppTaskForDynProf){
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::AppMode rMode("app", params);

    MOCKER_CPP(&DynProfCliMgr::IsAppMode)
        .stubs()
        .will(returnValue(true));
    MOCKER(&analysis::dvvp::app::Application::LaunchApp)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&DynProfCliMgr::StartDynProfCli)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&DynProfCliMgr::WaitQuit)
        .stubs()
        .will(ignoreReturnValue());
    MOCKER_CPP(&RunningMode::WaitRunningProcess)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartAppTaskForDynProf());
    EXPECT_EQ(PROFILING_FAILED, rMode.StartAppTaskForDynProf());
    EXPECT_EQ(PROFILING_FAILED, rMode.StartAppTaskForDynProf());
    EXPECT_EQ(PROFILING_SUCCESS, rMode.StartAppTaskForDynProf());
}

static int _drv_get_dev_ids_rmu(int numDevices, std::vector<int> &devIds){
    devIds ={0, 1};
    return PROFILING_SUCCESS;
}

TEST_F(RUNNING_MODE_UTEST, SystemModeCheckIfDeviceOnline){
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::SystemMode rMode("system", params);
    params->devices = "all";
    EXPECT_EQ(PROFILING_SUCCESS, rMode.CheckIfDeviceOnline());
    params->devices = "a,1";
    MOCKER(analysis::dvvp::driver::DrvGetDevNum)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(2));
    EXPECT_EQ(PROFILING_FAILED, rMode.CheckIfDeviceOnline());
    MOCKER(analysis::dvvp::driver::DrvGetDevIds)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(invoke(_drv_get_dev_ids_rmu));
    EXPECT_EQ(PROFILING_FAILED, rMode.CheckIfDeviceOnline());
    EXPECT_EQ(PROFILING_FAILED, rMode.CheckIfDeviceOnline());
    params->devices = "3,4";
    EXPECT_EQ(PROFILING_FAILED, rMode.CheckIfDeviceOnline());
    params->devices = "0";
    EXPECT_EQ(PROFILING_SUCCESS, rMode.CheckIfDeviceOnline());
    params->devices = "0,2";
    EXPECT_EQ(PROFILING_SUCCESS, rMode.CheckIfDeviceOnline());
}

TEST_F(RUNNING_MODE_UTEST, SystemModeStopRunningTasks){
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::SystemMode rMode("system", params);
    MOCKER(Utils::ExecCmd)
        .stubs()
        .will(invoke(ExecCmdStub));
    rMode.StopRunningTasks();
    EXPECT_EQ(g_argv.size(), 1);
    if (g_argv.size() == 1) {
        EXPECT_EQ(g_argv[0], "11111");
    }
}

TEST_F(RUNNING_MODE_UTEST, SystemModeCheckHostSysParams){
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::SystemMode rMode("system", params);
    EXPECT_EQ(PROFILING_FAILED, rMode.CheckHostSysParams());
    params->host_sys = "on";
    EXPECT_EQ(PROFILING_FAILED, rMode.CheckHostSysParams());
    params->host_sys_pid = 100;
    EXPECT_EQ(PROFILING_SUCCESS, rMode.CheckHostSysParams());
}

TEST_F(RUNNING_MODE_UTEST, DataWillBeCollected){
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::SystemMode rMode("system", params);
    EXPECT_EQ(false, rMode.DataWillBeCollected());
    params->usedParams = {ARGS_OUTPUT, ARGS_SYS_PERIOD, ARGS_SYS_DEVICES, ARGS_SYS_PROFILING};
    EXPECT_EQ(true, rMode.DataWillBeCollected());
    params->usedParams = {ARGS_OUTPUT, ARGS_SYS_PERIOD, ARGS_SYS_DEVICES};
    EXPECT_EQ(false, rMode.DataWillBeCollected());
}

TEST_F(RUNNING_MODE_UTEST, SystemModeModeParamsCheck){
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::SystemMode rMode("system", nullptr);
    EXPECT_EQ(PROFILING_FAILED, rMode.ModeParamsCheck());
    rMode.params_ = params;
    MOCKER_CPP(&SystemMode::CheckNeccessaryParams)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&SystemMode::DataWillBeCollected)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    MOCKER_CPP(&SystemMode::CheckHostSysParams)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&SystemMode::HandleProfilingParams)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.ModeParamsCheck());
    EXPECT_EQ(PROFILING_FAILED, rMode.ModeParamsCheck());
    EXPECT_EQ(PROFILING_FAILED, rMode.ModeParamsCheck());
    EXPECT_EQ(PROFILING_FAILED, rMode.ModeParamsCheck());
    EXPECT_EQ(PROFILING_SUCCESS, rMode.ModeParamsCheck());

    GlobalMockObject::verify();
    MOCKER_CPP(&SystemMode::CheckHostSysParams)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&SystemMode::HandleProfilingParams)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    params->usedParams ={ARGS_OUTPUT};
    EXPECT_EQ(PROFILING_FAILED, rMode.ModeParamsCheck());
    params->usedParams ={ARGS_OUTPUT, ARGS_SYS_PERIOD, ARGS_PYTHON_PATH};
    EXPECT_EQ(PROFILING_SUCCESS, rMode.ModeParamsCheck());
    params->usedParams ={ARGS_OUTPUT, ARGS_SYS_PERIOD, ARGS_EXPORT};
    EXPECT_EQ(PROFILING_SUCCESS, rMode.ModeParamsCheck());
}

TEST_F(RUNNING_MODE_UTEST, SystemModeRunModeTasks){
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::SystemMode rMode("system", nullptr);
    EXPECT_EQ(PROFILING_FAILED, rMode.RunModeTasks());
    rMode.params_ = params;
    rMode.params_->ai_core_profiling = "on";
    rMode.jobResultDirList_.insert("PROF");
    MOCKER_CPP(&SystemMode::StartSysTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_NOTSUPPORT))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&SystemMode::CheckAnalysisEnv)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&SystemMode::StartExportTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&SystemMode::StartQueryTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(PROFILING_FAILED, rMode.RunModeTasks());
    EXPECT_EQ(PROFILING_NOTSUPPORT, rMode.RunModeTasks());
    EXPECT_EQ(PROFILING_SUCCESS, rMode.RunModeTasks());
    EXPECT_EQ(PROFILING_SUCCESS, rMode.RunModeTasks());
    EXPECT_EQ(PROFILING_SUCCESS, rMode.RunModeTasks());
    EXPECT_EQ(PROFILING_SUCCESS, rMode.RunModeTasks());
    EXPECT_EQ("on", rMode.params_->aiv_profiling);
    EXPECT_EQ("sample-based", rMode.params_->aiv_profiling_mode);
}

TEST_F(RUNNING_MODE_UTEST, SystemModeCreateJobDir){
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::SystemMode rMode("system", params);
    params->result_dir = "/tmp/running_mode_utest";
    MOCKER(Utils::CreateDir)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    std::string out_dir;
    EXPECT_EQ(PROFILING_FAILED, rMode.CreateJobDir("1", out_dir));
    EXPECT_EQ(PROFILING_SUCCESS, rMode.CreateJobDir("1", out_dir));
}

TEST_F(RUNNING_MODE_UTEST, SystemModeRecordOutPut){
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::SystemMode rMode("system", params);
    std::string out = "/tmp/running_mode_utest";
    Utils::CreateDir(out);
    params->result_dir = "/tmp/running_mo_utest";
    EXPECT_EQ(PROFILING_FAILED, rMode.RecordOutPut());
    params->result_dir = "/tmp/running_mode_utest";
    EXPECT_EQ(PROFILING_SUCCESS, rMode.RecordOutPut());
    Utils::RemoveDir(out);
}

TEST_F(RUNNING_MODE_UTEST, SystemModeCheckHostAndDeviceOrder){
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> paramsDevice(
    new analysis::dvvp::message::ProfileParams);
    std::shared_ptr<analysis::dvvp::message::ProfileParams> paramsHost(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::SystemMode rMode("system", paramsDevice);
    std::string result_dir = "/tmp/running_mode_utest";
    paramsHost->job_id = "64";

    SHARED_PTR_ALIA<ProfRpcTask> deviceTask(new ProfRpcTask(1, paramsDevice));
    SHARED_PTR_ALIA<ProfSocTask> HostTask(new ProfSocTask(64, paramsDevice));

    MOCKER_CPP(&SystemMode::GenerateHostParam)
        .stubs()
        .will(returnValue(paramsHost));
    MOCKER_CPP(&SystemMode::CreateSampleJsonFile)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&SystemMode::CreateUploader)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP_VIRTUAL(deviceTask.get(), &ProfRpcTask::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP_VIRTUAL(HostTask.get(), &ProfSocTask::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP_VIRTUAL((analysis::dvvp::common::thread::Thread*)deviceTask.get(), &ProfRpcTask::Start)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP_VIRTUAL((analysis::dvvp::common::thread::Thread*)HostTask.get(), &ProfSocTask::Start)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    paramsDevice->job_id = "1";
    EXPECT_EQ(PROFILING_SUCCESS, rMode.StartHostTask(result_dir, 64));
    EXPECT_EQ(PROFILING_SUCCESS, rMode.StartDeviceTask(result_dir, "1"));
    EXPECT_EQ(2, rMode.taskMap_.size());
    EXPECT_EQ(2, rMode.taskList_.size());

    rMode.StopTask();
    EXPECT_EQ(0, rMode.taskList_.size());
    EXPECT_EQ(0, rMode.taskMap_.size());
}

TEST_F(RUNNING_MODE_UTEST, SystemModeStartHostTask){
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params2;
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params3(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::SystemMode rMode("system", params);
    std::string result_dir = "/tmp/running_mode_utest";
    MOCKER_CPP(&SystemMode::GenerateHostParam)
        .stubs()
        .will(returnValue(params2))
        .then(returnValue(params3));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartHostTask(result_dir, 64));
    MOCKER_CPP(&SystemMode::CreateSampleJsonFile)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartHostTask(result_dir, 64));
    MOCKER_CPP(&SystemMode::CreateUploader)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartHostTask(result_dir, 64));
    SHARED_PTR_ALIA<ProfSocTask> task(new ProfSocTask(1, params));
    MOCKER_CPP_VIRTUAL(task.get(), &ProfSocTask::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartHostTask(result_dir, 64));
    MOCKER_CPP_VIRTUAL((analysis::dvvp::common::thread::Thread*)task.get(), &ProfSocTask::Start)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartHostTask(result_dir, 64));
    params->job_id = "1";
    
    EXPECT_EQ(PROFILING_SUCCESS, rMode.StartHostTask(result_dir, 1));
}

TEST_F(RUNNING_MODE_UTEST, SystemModeStartDeviceTask){
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params2;
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params3(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::SystemMode rMode("system", params);
    std::string result_dir = "/tmp/running_mode_utest";
    MOCKER_CPP(&SystemMode::GenerateDeviceParam)
        .stubs()
        .will(returnValue(params2))
        .then(returnValue(params3));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartDeviceTask(result_dir, "1"));
    MOCKER_CPP(&SystemMode::CreateUploader)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartDeviceTask(result_dir, "1"));
    SHARED_PTR_ALIA<ProfRpcTask> task(new ProfRpcTask(1, params));
    MOCKER_CPP_VIRTUAL(task.get(), &ProfRpcTask::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartDeviceTask(result_dir, "1"));
    MOCKER_CPP_VIRTUAL((analysis::dvvp::common::thread::Thread*)task.get(), &ProfRpcTask::Start)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartDeviceTask(result_dir, "1"));
    params->job_id = "1";
    EXPECT_EQ(PROFILING_SUCCESS, rMode.StartDeviceTask(result_dir, "1"));
}

TEST_F(RUNNING_MODE_UTEST, SystemModeStopTask){
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::SystemMode rMode("system", params);
    auto info = std::make_shared<Analysis::Dvvp::Msprof::ProfSocTask>(1, params);
    rMode.taskMap_.insert(std::make_pair("1", info));
    rMode.taskList_.push_back(info);
    MOCKER_CPP_VIRTUAL((MsprofTask*)info.get(), &ProfSocTask::Stop).stubs().will(returnValue(0));
    MOCKER_CPP_VIRTUAL((MsprofTask*)info.get(), &ProfSocTask::Wait).stubs().will(returnValue(0));
    rMode.StopTask();
    EXPECT_EQ(0, rMode.taskMap_.size());
    EXPECT_EQ(0, rMode.taskList_.size());
}

TEST_F(RUNNING_MODE_UTEST, SystemWaitSysTask){
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::SystemMode rMode("system", params);
    params->profiling_period = 2;
    EXPECT_EQ(PROFILING_SUCCESS, rMode.WaitSysTask());
}

TEST_F(RUNNING_MODE_UTEST, IsDeviceJob){
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::SystemMode rMode("system", nullptr);
    EXPECT_EQ(false, rMode.IsDeviceJob());
    rMode.params_ = params;
    params->hardware_mem = "on";
    MOCKER_CPP(&ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(1));
    EXPECT_EQ(true, rMode.IsDeviceJob());
    EXPECT_EQ(false, rMode.IsDeviceJob());
    params->cpu_profiling = "on";
    EXPECT_EQ(true, rMode.IsDeviceJob());
}

TEST_F(RUNNING_MODE_UTEST, CreateUploader)
{
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::SystemMode rMode("system", params);
    EXPECT_EQ(PROFILING_FAILED, rMode.CreateUploader("", ""));

    std::string tmp = "/tmp/running_mode_utest";
    SHARED_PTR_ALIA<ITransport> fileTransport_null;
    SHARED_PTR_ALIA<ITransport> fileTransport = std::make_shared<FILETransport>(tmp, "1000");
    MOCKER_CPP(&FileTransportFactory::CreateFileTransport)
        .stubs()
        .will(returnValue(fileTransport_null))
        .then(returnValue(fileTransport));
    EXPECT_EQ(PROFILING_FAILED, rMode.CreateUploader("1", "/tmp"));

    MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::CreateUploader)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.CreateUploader("1", "/tmp"));
    EXPECT_EQ(PROFILING_SUCCESS, rMode.CreateUploader("1", "/tmp"));
}

TEST_F(RUNNING_MODE_UTEST, GenerateHostParam)
{
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::SystemMode rMode("system", params);
    EXPECT_EQ(nullptr, rMode.GenerateHostParam(nullptr));

    MOCKER_CPP(&analysis::dvvp::message::ProfileParams::FromString)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    EXPECT_EQ(nullptr, rMode.GenerateHostParam(params));
    auto pp = rMode.GenerateHostParam(params);
    EXPECT_GE(pp->job_id.size(), 0);
    EXPECT_EQ(pp->ai_core_profiling_mode, "sample-based");
    EXPECT_EQ(pp->aiv_profiling_mode, "sample-based");

    MOCKER_CPP(&ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(5));
    params->instrProfiling = "on";
    params->instrProfilingFreq = 1234;
    auto pp1 = rMode.GenerateHostParam(params);
    EXPECT_EQ(pp1->instrProfiling, "on");
    EXPECT_EQ(pp1->instrProfilingFreq, 1234);
}

TEST_F(RUNNING_MODE_UTEST, GenerateDeviceParam) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::SystemMode rMode("system", params);
    EXPECT_EQ(nullptr, rMode.GenerateDeviceParam(nullptr));

    MOCKER_CPP(&ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(0));
    params->llc_profiling_events = "0x55,0x22";
    auto pp = rMode.GenerateDeviceParam(params);
    EXPECT_EQ(pp->llc_profiling_events, "0x55,0x22");
}

TEST_F(RUNNING_MODE_UTEST, GenerateDeviceParam2) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::SystemMode rMode("system", params);

    MOCKER_CPP(&ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(5));
    params->instrProfiling = "on";
    params->instrProfilingFreq = 1234;
    auto pp1 = rMode.GenerateDeviceParam(params);
    EXPECT_EQ(pp1->instrProfiling, "on");
    EXPECT_EQ(pp1->instrProfilingFreq, 1234);
}

TEST_F(RUNNING_MODE_UTEST, CreateSampleJsonFile) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::SystemMode rMode("system", params);
    EXPECT_EQ(true, rMode.CreateSampleJsonFile(params, ""));
    std::string output = "/tmp/running_mode_utest";
    MOCKER(Utils::CreateDir)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(false, rMode.CreateSampleJsonFile(params, output));
    MOCKER_CPP(&SystemMode::WriteCtrlDataToFile)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(false, rMode.CreateSampleJsonFile(params, output));
    EXPECT_EQ(true, rMode.CreateSampleJsonFile(params, output));
}

TEST_F(RUNNING_MODE_UTEST, CreateDoneFile) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::SystemMode rMode("system", params);
    std::string output = "/tmp/running_mode_utest";
    Utils::CreateDir(output);
    EXPECT_EQ(false, rMode.CreateDoneFile("/tmp/running_mode_mtest/test.done", "10"));
    EXPECT_EQ(true, rMode.CreateDoneFile("/tmp/running_mode_utest/test.done", "10"));
    Utils::RemoveDir(output);
}

TEST_F(RUNNING_MODE_UTEST, WriteCtrlDataToFile) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::SystemMode rMode("system", params);
    std::string output = "/tmp/running_mode_utest";
    std::string output_err = "/tmp/running_mo_utest";
    Utils::CreateDir(output);
    MOCKER(Utils::IsFileExist)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    std::string s = "{\"result_dir\":\"/tmp/\", \"devices\":\"1\", \"job_id\":\"1\"}";
    int len = s.size();
    EXPECT_EQ(PROFILING_SUCCESS, rMode.WriteCtrlDataToFile(output + "/sample.json", s, len));
    EXPECT_EQ(PROFILING_FAILED, rMode.WriteCtrlDataToFile(output + "/sample.json", "", 0));
    EXPECT_EQ(PROFILING_FAILED, rMode.WriteCtrlDataToFile(output_err + "/sample.json", s, len));
    MOCKER_CPP(&SystemMode::CreateDoneFile)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    EXPECT_EQ(PROFILING_FAILED, rMode.WriteCtrlDataToFile(output + "/sample.json", s, len));
    EXPECT_EQ(PROFILING_SUCCESS, rMode.WriteCtrlDataToFile(output + "/sample.json", s, len));
    Utils::RemoveDir(output);
}

TEST_F(RUNNING_MODE_UTEST, StartSysTask) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::SystemMode rMode("system", params);
    params->devices = "0";
    MOCKER_CPP(&SystemMode::StartHostTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartSysTask());
    GlobalMockObject::verify();
    MOCKER_CPP(&SystemMode::CreateJobDir)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartSysTask());
    GlobalMockObject::verify();
    MOCKER_CPP(&SystemMode::StartHostTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartSysTask());
    GlobalMockObject::verify();
    MOCKER_CPP(&SystemMode::IsDeviceJob)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformIsSocSide)
        .stubs()
        .will(returnValue(false));
    MOCKER_CPP(&SystemMode::StartDeviceTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartSysTask());

    GlobalMockObject::verify();
    params->devices = "";
    MOCKER_CPP(&analysis::dvvp::message::ProfileParams::IsHostProfiling)
        .stubs()
        .will(repeat(true, 2))
        .then(returnValue(false));
    MOCKER_CPP(&SystemMode::CreateJobDir)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartSysTask());
    MOCKER_CPP(&SystemMode::StartHostTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartSysTask());
    MOCKER_CPP(&SystemMode::WaitSysTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartSysTask());
    EXPECT_EQ(PROFILING_SUCCESS, rMode.StartSysTask());
}

TEST_F(RUNNING_MODE_UTEST, ParseModeModeParamsCheck) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::ParseMode rMode("parse", nullptr);
    EXPECT_EQ(PROFILING_FAILED, rMode.ModeParamsCheck());
    rMode.params_ = params;

    GlobalMockObject::verify();
    params->usedParams = {ARGS_QUERY};
    EXPECT_EQ(PROFILING_FAILED, rMode.ModeParamsCheck());
    params->usedParams = {};
    EXPECT_EQ(PROFILING_FAILED, rMode.ModeParamsCheck());
    params->usedParams = {ARGS_OUTPUT, ARGS_PARSE, ARGS_PYTHON_PATH};
    EXPECT_EQ(PROFILING_SUCCESS, rMode.ModeParamsCheck());
    params->usedParams = {ARGS_OUTPUT, ARGS_PARSE, ARGS_SYS_PROFILING};
    EXPECT_EQ(PROFILING_SUCCESS, rMode.ModeParamsCheck());
}

TEST_F(RUNNING_MODE_UTEST, ParseModeUpdateOutputDirInfo) 
{
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    params->result_dir = "hello";
    Collector::Dvvp::Msprofbin::ParseMode rMode("parse", params);
    rMode.jobResultDir_="123";
    rMode.UpdateOutputDirInfo();

    rMode.jobResultDir_="";
    rMode.UpdateOutputDirInfo();
    EXPECT_EQ(rMode.jobResultDir_, "hello");
}

TEST_F(RUNNING_MODE_UTEST, ParseModeRunModeTasks) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::ParseMode rMode("parse", nullptr);
    EXPECT_EQ(PROFILING_FAILED, rMode.RunModeTasks());
    rMode.params_ = params;
    MOCKER_CPP(&SystemMode::CheckAnalysisEnv)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.RunModeTasks());
    MOCKER_CPP(&SystemMode::StartParseTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.RunModeTasks());
    MOCKER_CPP(&SystemMode::StartQueryTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.RunModeTasks());
    EXPECT_EQ(PROFILING_SUCCESS, rMode.RunModeTasks());
}

TEST_F(RUNNING_MODE_UTEST, QueryModeUpdateOutputDirInfo) 
{
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    params->result_dir = "hello";
    Collector::Dvvp::Msprofbin::QueryMode rMode("query", params);
    rMode.jobResultDir_ = "123";
    rMode.UpdateOutputDirInfo();
    
    rMode.jobResultDir_="";
    rMode.UpdateOutputDirInfo();
    EXPECT_EQ(rMode.jobResultDir_, "hello");
}

TEST_F(RUNNING_MODE_UTEST, QueryModeModeParamsCheck) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::QueryMode rMode("query", nullptr);
    EXPECT_EQ(PROFILING_FAILED, rMode.ModeParamsCheck());
    rMode.params_ = params;

    GlobalMockObject::verify();
    params->usedParams = {ARGS_EXPORT};
    EXPECT_EQ(PROFILING_FAILED, rMode.ModeParamsCheck());
    params->usedParams = {};
    EXPECT_EQ(PROFILING_FAILED, rMode.ModeParamsCheck());
    params->usedParams = {ARGS_OUTPUT, ARGS_QUERY, ARGS_PYTHON_PATH};
    EXPECT_EQ(PROFILING_SUCCESS, rMode.ModeParamsCheck());
    params->usedParams = {ARGS_OUTPUT, ARGS_QUERY, ARGS_SYS_PROFILING};
    EXPECT_EQ(PROFILING_SUCCESS, rMode.ModeParamsCheck());
}

TEST_F(RUNNING_MODE_UTEST, QueryModeRunModeTasks) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::QueryMode rMode("query", nullptr);
    EXPECT_EQ(PROFILING_FAILED, rMode.RunModeTasks());
    rMode.params_ = params;
    MOCKER_CPP(&SystemMode::CheckAnalysisEnv)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.RunModeTasks());
    MOCKER_CPP(&SystemMode::StartQueryTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.RunModeTasks());
    EXPECT_EQ(PROFILING_SUCCESS, rMode.RunModeTasks());
}

TEST_F(RUNNING_MODE_UTEST, ExportModeUpdateOutputDirInfo) 
{
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    params->result_dir = "hello";
    Collector::Dvvp::Msprofbin::ExportMode rMode("export", params);
    rMode.jobResultDir_ = "123";
    rMode.UpdateOutputDirInfo();

    rMode.jobResultDir_="";
    rMode.UpdateOutputDirInfo();
    EXPECT_EQ(rMode.jobResultDir_, "hello");
}

TEST_F(RUNNING_MODE_UTEST, ExportModeModeParamsCheck) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::ExportMode rMode("export", nullptr);
    EXPECT_EQ(PROFILING_FAILED, rMode.ModeParamsCheck());
    rMode.params_ = params;

    GlobalMockObject::verify();
    params->usedParams = {ARGS_QUERY};
    EXPECT_EQ(PROFILING_FAILED, rMode.ModeParamsCheck());
    params->usedParams = {};
    EXPECT_EQ(PROFILING_FAILED, rMode.ModeParamsCheck());
    params->usedParams = {ARGS_OUTPUT, ARGS_EXPORT, ARGS_PYTHON_PATH};
    EXPECT_EQ(PROFILING_SUCCESS, rMode.ModeParamsCheck());
    params->usedParams = {ARGS_OUTPUT, ARGS_EXPORT, ARGS_SYS_PROFILING, ARGS_EXPORT_ITERATION_ID, ARGS_EXPORT_MODEL_ID};
    EXPECT_EQ(PROFILING_SUCCESS, rMode.ModeParamsCheck());
}

TEST_F(RUNNING_MODE_UTEST,ExportModeRunModeTasks) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::ExportMode rMode("export", nullptr);
    EXPECT_EQ(PROFILING_FAILED, rMode.RunModeTasks());
    rMode.params_ = params;
    MOCKER_CPP(&SystemMode::CheckAnalysisEnv)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.RunModeTasks());
    MOCKER_CPP(&SystemMode::StartExportTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.RunModeTasks());
    EXPECT_EQ(PROFILING_SUCCESS, rMode.RunModeTasks());
}

TEST_F(RUNNING_MODE_UTEST, StartAnalyzeTask)
{
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::AnalyzeMode rMode("analyze", params);
    rMode.isQuit_ = true;
    EXPECT_EQ(PROFILING_FAILED, rMode.StartAnalyzeTask());
    rMode.isQuit_ = false;
    rMode.taskPid_ = 1111;
    EXPECT_EQ(PROFILING_FAILED, rMode.StartAnalyzeTask());
    rMode.taskPid_ = MSVP_PROCESS;
    EXPECT_EQ(PROFILING_FAILED, rMode.StartAnalyzeTask());
    rMode.jobResultDir_ = "123";
    rMode.analysisPath_ = "path_test";
    MOCKER(Utils::ExecCmd)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartAnalyzeTask());
    MOCKER_CPP(&RunningMode::WaitRunningProcess)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, rMode.StartAnalyzeTask());
    EXPECT_EQ(PROFILING_SUCCESS, rMode.StartAnalyzeTask());
}

TEST_F(RUNNING_MODE_UTEST, AnalyzeModeModeParamsCheck) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    Collector::Dvvp::Msprofbin::AnalyzeMode rMode("analyze", nullptr);
    EXPECT_EQ(PROFILING_FAILED, rMode.ModeParamsCheck());
    rMode.params_ = params;
    params->usedParams = {};
    EXPECT_EQ(PROFILING_FAILED, rMode.ModeParamsCheck());
    params->usedParams = {ARGS_QUERY};
    EXPECT_EQ(PROFILING_FAILED, rMode.ModeParamsCheck());
    params->usedParams = {ARGS_OUTPUT, ARGS_ANALYZE, ARGS_PYTHON_PATH};
    EXPECT_EQ(PROFILING_SUCCESS, rMode.ModeParamsCheck());
    params->usedParams = {ARGS_OUTPUT, ARGS_ANALYZE, ARGS_PYTHON_PATH, ARGS_RULE};
    EXPECT_EQ(PROFILING_SUCCESS, rMode.ModeParamsCheck());
}
