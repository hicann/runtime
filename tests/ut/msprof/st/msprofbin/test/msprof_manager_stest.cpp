/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mockcpp/mockcpp.hpp"
#include "gtest/gtest.h"
#include <iostream>
#include "errno/error_code.h"
#include "msprof_manager.h"
#include "message/codec.h"
#include "config/config.h"
#include "config/config_manager.h"
#include "fstream"
#include "running_mode.h"
#include "utils/utils.h"
#include "input_parser.h"
#include "msprof_task.h"
#include "platform/platform.h"
#include <sys/types.h>

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::Msprof;
using namespace analysis::dvvp::common::utils;

class MSPROF_MANAGER_STEST : public testing::Test {
protected:
  virtual void SetUp() {}
  virtual void TearDown() {}
};


TEST_F(MSPROF_MANAGER_STEST, Init) { 
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);   
    EXPECT_EQ(PROFILING_FAILED, MsprofManager::instance()->Init(nullptr));

    EXPECT_EQ(PROFILING_FAILED, MsprofManager::instance()->Init(params));

    params->app = "./main";
    params->usedParams = {ARGS_APPLICATION, ARGS_PYTHON_PATH};
    EXPECT_EQ(PROFILING_SUCCESS, MsprofManager::instance()->Init(params));
    EXPECT_EQ("app", MsprofManager::instance()->rMode_->modeName_);

    params->app = "";
    params->devices = "all";
    params->result_dir = "./test";
    params->host_sys = "on";
    params->host_sys_pid = 1111;
    params->usedParams = {ARGS_SYS_DEVICES, ARGS_OUTPUT, ARGS_HOST_SYS, ARGS_HOST_SYS_PID};
    EXPECT_EQ(PROFILING_FAILED, MsprofManager::instance()->Init(params));
    params->profiling_period = 100;
    params->usedParams = {ARGS_PYTHON_PATH, ARGS_SYS_DEVICES, ARGS_OUTPUT, ARGS_HOST_SYS, ARGS_HOST_SYS_PID, ARGS_SYS_PERIOD};
    EXPECT_EQ(PROFILING_SUCCESS, MsprofManager::instance()->Init(params));
    EXPECT_EQ("system", MsprofManager::instance()->rMode_->modeName_);

    params->devices = "";
    params->result_dir = "";
    params->host_sys = "";
    params->parseSwitch = "on";
    params->usedParams = {ARGS_PARSE};
    EXPECT_EQ(PROFILING_FAILED, MsprofManager::instance()->Init(params));
    params->result_dir = "./test";
    params->usedParams = {ARGS_PARSE, ARGS_OUTPUT, ARGS_PYTHON_PATH};
    EXPECT_EQ(PROFILING_SUCCESS, MsprofManager::instance()->Init(params));
    EXPECT_EQ("parse", MsprofManager::instance()->rMode_->modeName_);

    params->devices = "";
    params->result_dir = "";
    params->parseSwitch = "";
    params->querySwitch = "on";
    params->usedParams = {ARGS_QUERY};
    EXPECT_EQ(PROFILING_FAILED, MsprofManager::instance()->Init(params));
    params->result_dir = "./test";
    params->usedParams = {ARGS_QUERY, ARGS_OUTPUT, ARGS_PYTHON_PATH};
    EXPECT_EQ(PROFILING_SUCCESS, MsprofManager::instance()->Init(params));
    EXPECT_EQ("query", MsprofManager::instance()->rMode_->modeName_);

    params->devices = "";
    params->result_dir = "";
    params->querySwitch = "";
    params->exportSwitch = "on";
    params->usedParams = {ARGS_EXPORT};
    EXPECT_EQ(PROFILING_FAILED, MsprofManager::instance()->Init(params));
    params->result_dir = "./test";
    params->usedParams = {ARGS_EXPORT, ARGS_OUTPUT, ARGS_PYTHON_PATH};
    EXPECT_EQ(PROFILING_SUCCESS, MsprofManager::instance()->Init(params));
    EXPECT_EQ("export", MsprofManager::instance()->rMode_->modeName_);
    params->exportIterationId = 1;
    params->exportModelId = 1;
    params->exportSummaryFormat = "json";
    params->usedParams = {ARGS_EXPORT, ARGS_OUTPUT, ARGS_SUMMARY_FORMAT, ARGS_EXPORT_ITERATION_ID, ARGS_EXPORT_MODEL_ID};
    EXPECT_EQ(PROFILING_SUCCESS, MsprofManager::instance()->Init(params));

    params->devices = "";
    params->result_dir = "";
    params->parseSwitch = "";
    params->querySwitch = "";
    params->exportSwitch = "on";
    params->clearSwitch = "on";
    params->usedParams = {ARGS_CLEAR};
    EXPECT_EQ(PROFILING_FAILED, MsprofManager::instance()->Init(params));
    params->result_dir = "./test";
    params->usedParams = {ARGS_CLEAR, ARGS_EXPORT, ARGS_OUTPUT, ARGS_PYTHON_PATH};
    EXPECT_EQ(PROFILING_SUCCESS, MsprofManager::instance()->Init(params));
}

TEST_F(MSPROF_MANAGER_STEST, GetTask) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    std::shared_ptr<Collector::Dvvp::Msprofbin::AppMode> rMode(
    new Collector::Dvvp::Msprofbin::AppMode("app", params));
    auto msprofManager = MsprofManager::instance();
    msprofManager->UnInit();
    EXPECT_EQ(nullptr, msprofManager->GetTask("1"));
    msprofManager->rMode_ = rMode;
    std::shared_ptr<Analysis::Dvvp::Msprof::MsprofTask> info(new Analysis::Dvvp::Msprof::ProfSocTask(1, params));
    rMode->taskMap_.insert(std::make_pair("1", info));
    EXPECT_EQ(info, msprofManager->GetTask("1"));
}

TEST_F(MSPROF_MANAGER_STEST, NotifyStop) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    std::shared_ptr<Collector::Dvvp::Msprofbin::AppMode> rMode(
    new Collector::Dvvp::Msprofbin::AppMode("app", params));
    auto msprofManager = MsprofManager::instance();
    msprofManager->UnInit();
    msprofManager->rMode_ = rMode;
    msprofManager->NotifyStop();
    EXPECT_EQ(true, msprofManager->rMode_->isQuit_);
}

TEST_F(MSPROF_MANAGER_STEST, MsProcessCmd) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    std::shared_ptr<Collector::Dvvp::Msprofbin::AppMode> appMode(
    new Collector::Dvvp::Msprofbin::AppMode("app", params));

    std::string dirName2 = "/tmp";
    Utils::CreateDir(dirName2 + "/profiler_tool");
    Utils::CreateDir(dirName2 + "/profiler_tool/analysis");
    Utils::CreateDir(dirName2 + "/profiler_tool/analysis/msprof");
    std::ofstream test_file2((dirName2 + "/profiler_tool/analysis/msprof/msprof.py").c_str());
    test_file2 << "import os" << std::endl;
    test_file2.close();
    std::string tmp = "/tmp/profiler_tool/analysis";
    MOCKER(&Utils::GetSelfPath).stubs().will(returnValue(tmp));
    MOCKER(&Utils::GetPid).stubs().will(returnValue(1));
    std::cout << "Create fake python script" << std::endl;

    std::ofstream out;
    std::string result_dir = "/tmp/msprof_manager_stest";
    Utils::CreateDir(result_dir);
    out.open(result_dir + '/' + "1_" + OUTPUT_RECORD);
    out << "PROF_000001_20211211194055303_DANEQIJKACHMDGNB" << std::endl << "JOB44444444444" <<  std::endl;
    out.close();
    std::cout << "Create fake record log" << std::endl;
    
    std::ofstream test_file("/tmp/msprof_manager_stest_main");
    test_file << "echo test" << std::endl;
    test_file.close();
    chmod("/tmp/msprof_manager_stest_main",
        S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IWGRP|S_IXGRP|S_IROTH|S_IWOTH|S_IXOTH);

    
    auto msprofManager = MsprofManager::instance();
    msprofManager->UnInit();
    EXPECT_EQ(PROFILING_FAILED, msprofManager->MsProcessCmd());

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(false));

    params->app = "msprof_manager_stest_main";
    params->result_dir = result_dir;
    params->app_dir = "/tmp";
    params->cmdPath = "/tmp/msprof_manager_stest_main";
    msprofManager->params_ = params;
    msprofManager->rMode_ = appMode;
    EXPECT_EQ(PROFILING_SUCCESS, msprofManager->MsProcessCmd());
    std::remove("/tmp/msprof_manager_stest_main");
    Utils::RemoveDir(result_dir);

    Utils::CreateDir(result_dir);
    out.open(result_dir + '/' + "1_" + OUTPUT_RECORD);
    out << "PROF_000001_20211211194055303_DANEQIJKACHMDGNB" << std::endl << "JOB44444444444" <<  std::endl;
    out.close();
    std::cout << "Create fake record log" << std::endl;

    std::shared_ptr<Collector::Dvvp::Msprofbin::SystemMode> systemMode(
    new Collector::Dvvp::Msprofbin::SystemMode("system", params));
    msprofManager->UnInit();
    EXPECT_EQ(PROFILING_FAILED, msprofManager->MsProcessCmd());
    params->app = "";
    params->devices = "0,1";
    params->profiling_period = 2;
    params->result_dir = result_dir;
    msprofManager->params_ = params;
    msprofManager->rMode_ = systemMode;
    MOCKER_CPP(&Collector::Dvvp::Msprofbin::SystemMode::RecordOutPut).stubs().will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::message::ProfileParams::PrintAllFields).stubs();
    MOCKER_CPP(&Collector::Dvvp::Msprofbin::SystemMode::CreateJobDir).stubs().will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Collector::Dvvp::Msprofbin::SystemMode::CreateUploader)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, msprofManager->MsProcessCmd());
    SHARED_PTR_ALIA<ProfSocTask> task = std::make_shared<ProfSocTask>(0, params);
    MOCKER_CPP_VIRTUAL(task.get(), &ProfSocTask::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, msprofManager->MsProcessCmd());
    MOCKER_CPP_VIRTUAL((analysis::dvvp::common::thread::Thread*)task.get(), &ProfSocTask::Start)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, msprofManager->MsProcessCmd());
    EXPECT_EQ(PROFILING_SUCCESS, msprofManager->MsProcessCmd());
    Utils::RemoveDir(result_dir);

    Utils::CreateDir(result_dir);
    std::shared_ptr<Collector::Dvvp::Msprofbin::ParseMode> parseMode(
    new Collector::Dvvp::Msprofbin::ParseMode("parse", params));
    msprofManager->UnInit();
    EXPECT_EQ(PROFILING_FAILED, msprofManager->MsProcessCmd());
    params->app = "";
    params->devices = "";
    params->profiling_period = -1;
    params->result_dir = result_dir;
    msprofManager->params_ = params;
    msprofManager->rMode_ = parseMode;
    EXPECT_EQ(PROFILING_SUCCESS, msprofManager->MsProcessCmd());

    std::shared_ptr<Collector::Dvvp::Msprofbin::QueryMode> queryMode(
    new Collector::Dvvp::Msprofbin::QueryMode("query", params));
    msprofManager->UnInit();
    EXPECT_EQ(PROFILING_FAILED, msprofManager->MsProcessCmd());
    msprofManager->params_ = params;
    msprofManager->rMode_ = systemMode;
    EXPECT_EQ(PROFILING_SUCCESS, msprofManager->MsProcessCmd());

    std::shared_ptr<Collector::Dvvp::Msprofbin::ExportMode> exportMode(
    new Collector::Dvvp::Msprofbin::ExportMode("export", params));
    msprofManager->UnInit();
    EXPECT_EQ(PROFILING_FAILED, msprofManager->MsProcessCmd());
    msprofManager->params_ = params;
    msprofManager->rMode_ = systemMode;
    EXPECT_EQ(PROFILING_SUCCESS, msprofManager->MsProcessCmd());

    std::string path_gov = Utils::IdeGetHomedir();

    Utils::RemoveDir(dirName2 + "/profiler_tool");
    Utils::RemoveDir(result_dir);
}