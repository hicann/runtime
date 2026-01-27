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
#include <fstream>
#include <iostream>
#include "utils/utils.h"
#include "platform/platform.h"
#include "errno/error_code.h"
#include "app/application.h"
#include "app/env_manager.h"
#include "message/prof_params.h"
#include "config_manager.h"
#include "message/codec.h"
#include "uploader_mgr.h"
#include "transport.h"
#include "dyn_prof_client.h"
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::message;
using namespace Collector::Dvvp::DynProf;

class PROF_APPLICATION_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

/////////////////////////////////////////////////////////////
TEST_F(PROF_APPLICATION_TEST, PrepareLaunchAppCmd) {
	GlobalMockObject::verify();
	std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
		new analysis::dvvp::message::ProfileParams());

	std::stringstream ss_perf_cmd_app;
	params->app_dir = "";
	EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::app::Application::PrepareLaunchAppCmd(ss_perf_cmd_app, params));
	params->app = "$$$";
	EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::app::Application::PrepareLaunchAppCmd(ss_perf_cmd_app, params));

	params->app_dir = "/appdir";
	EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::app::Application::PrepareLaunchAppCmd(ss_perf_cmd_app, params));
	params->app_parameters = "rm -rf";
	EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::app::Application::PrepareLaunchAppCmd(ss_perf_cmd_app, params));
	params->cmdPath = "/appdir/bash";
	params->app = "test";
	params->app_parameters = "";

	EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::app::Application::PrepareLaunchAppCmd(ss_perf_cmd_app, params));

	EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::app::Application::PrepareLaunchAppCmd(ss_perf_cmd_app, params));

	EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::app::Application::PrepareLaunchAppCmd(ss_perf_cmd_app, params));

	params->app_parameters = "app_parameters";
	EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::app::Application::PrepareLaunchAppCmd(ss_perf_cmd_app, params));
}

/////////////////////////////////////////////////////////////
TEST_F(PROF_APPLICATION_TEST, PrepareAppArgs) {
	GlobalMockObject::verify();

	std::vector<std::string> params;
	params.push_back("params1");
	params.push_back("params2");
	std::vector<std::string> args_v;
	analysis::dvvp::app::Application::PrepareAppArgs(params, args_v);
	std::string newStr = args_v[0];
	EXPECT_STREQ("params2", newStr.c_str());
}

/////////////////////////////////////////////////////////////
TEST_F(PROF_APPLICATION_TEST, PrepareAppEnvs) {
	GlobalMockObject::verify();
	
	std::string result_dir("./");
	std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
		new analysis::dvvp::message::ProfileParams());
	EXPECT_NE(nullptr, params);
	std::string cmd("/path/to/exe");
	std::string ai_core_events_str("ai_core_events_str");
	std::string dev_id("0");

	std::vector<std::string> envs_v;

	params->result_dir = "/tmp/PrepareAppEnvs";

    int ret = analysis::dvvp::app::Application::PrepareAppEnvs(nullptr, envs_v);
    EXPECT_EQ(PROFILING_FAILED, ret);
	ret = analysis::dvvp::app::Application::PrepareAppEnvs(params, envs_v);
	EXPECT_EQ(PROFILING_SUCCESS, ret);
	params->profiling_options = "task_trace";
	ret = analysis::dvvp::app::Application::PrepareAppEnvs(params, envs_v);
	EXPECT_EQ(PROFILING_SUCCESS, ret);
	ret = analysis::dvvp::app::Application::PrepareAppEnvs(params, envs_v);
	EXPECT_EQ(PROFILING_SUCCESS, ret);
}

int launchAppCmdCnt = 0;

int PrepareLaunchAppCmdStub(std::stringstream &ssCmdApp, SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params)
{
    ssCmdApp << "test";
    launchAppCmdCnt++;
    if (launchAppCmdCnt == 1) {
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int CanonicalizePathStubCnt = 0;

std::string CanonicalizePathStub(const std::string &path)
{
	std::string tmp;
    CanonicalizePathStubCnt++;
    if (CanonicalizePathStubCnt == 1) {
        return tmp;
    }
	tmp = "test";
    return tmp;
}

/////////////////////////////////////////////////////////////
TEST_F(PROF_APPLICATION_TEST, LaunchApp) {
	GlobalMockObject::verify();
	
	std::string ai_core_events_str("ai_core_events_str");
	std::string result_dir("./");
	std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
		new analysis::dvvp::message::ProfileParams());
	std::string resultDir = "/tmp";
	params->app = "ls";
	pid_t app_process;

	MOCKER(analysis::dvvp::app::Application::PrepareLaunchAppCmd)
		.stubs()
		.will(invoke(PrepareLaunchAppCmdStub));

	MOCKER(analysis::dvvp::app::Application::PrepareAppArgs)
		.stubs()
		.will(ignoreReturnValue());

	MOCKER(analysis::dvvp::app::Application::PrepareAppEnvs)
		.stubs()
		.will(returnValue(PROFILING_FAILED))
		.then(returnValue(PROFILING_SUCCESS));
	FILE *fp = (FILE *)0x12345;

	MOCKER(analysis::dvvp::common::utils::Utils::CanonicalizePath)
        .stubs()
        .will(invoke(CanonicalizePathStub));

    MOCKER(analysis::dvvp::common::utils::Utils::IsFileExist)
        .stubs()
        .will(returnValue(true));

    MOCKER(analysis::dvvp::common::utils::Utils::IsSoftLink)
        .stubs()
        .will(returnValue(false));

	EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::app::Application::LaunchApp(nullptr, app_process));
	EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::app::Application::LaunchApp(params, app_process));

	params->app_dir = resultDir;
	EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::app::Application::LaunchApp(params, app_process));

	EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::app::Application::LaunchApp(params, app_process));
	//check file path failed
	EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::app::Application::LaunchApp(params, app_process));
	EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::app::Application::LaunchApp(params, app_process));

	EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::app::Application::LaunchApp(params, app_process));

	std::vector<std::string> paramsCmd;
	MOCKER(analysis::dvvp::common::utils::Utils::Split)
		.stubs()
		.will(returnValue(paramsCmd));
	EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::app::Application::LaunchApp(params, app_process));
}


TEST_F(PROF_APPLICATION_TEST, SetAppEnv) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams());
    std::vector<std::string> envs;
    params->app_env = "LD_LIBRARY_PATH=123;asd=1;PATH=123;PROFILING_MODE=true";
	params->delayTime = "1";
    analysis::dvvp::app::Application::SetAppEnv(params, envs);
	EXPECT_EQ(envs.size(), 6);
	if (envs.size() == 6) {
		EXPECT_EQ(envs[0], "LD_LIBRARY_PATH=123");
		EXPECT_EQ(envs[5], "PROFILING_MODE=delay_or_duration");
	}
    MOCKER(&DynProfCliMgr::IsDynProfCliEnable)
        .stubs()
        .will(returnValue(true));
    analysis::dvvp::app::Application::SetAppEnv(params, envs);
	EXPECT_EQ(envs.size(), 12);
	if (envs.size() == 11) {
		EXPECT_EQ(envs[6], "LD_LIBRARY_PATH=123");
		EXPECT_EQ(envs[11], "PROFILING_MODE=delay_or_duration");
	}
}

TEST_F(PROF_APPLICATION_TEST, SetGlobalEnv) {
	GlobalMockObject::verify();
	std::vector<std::string> envList;
	envList.push_back("LD_LIBRARY_PATH=runtime.so");
	Analysis::Dvvp::App::EnvManager::instance()->SetGlobalEnv(envList);
	std::vector<std::string> envs = Analysis::Dvvp::App::EnvManager::instance()->GetGlobalEnv();
	EXPECT_EQ(envs.size(), 1);
	if (envs.size() == 1) {
		EXPECT_EQ(envList[0], envs[0]);
	}
}

TEST_F(PROF_APPLICATION_TEST, GetAppPath) {
	GlobalMockObject::verify();
	std::vector<std::string> paramsCmd;
	EXPECT_EQ("", analysis::dvvp::app::Application::GetAppPath(paramsCmd));

	paramsCmd.push_back("first");
	paramsCmd.push_back("second");
	paramsCmd.push_back("third");
	EXPECT_EQ("first", analysis::dvvp::app::Application::GetAppPath(paramsCmd));

    paramsCmd[0] = "bash";
    EXPECT_EQ("second", analysis::dvvp::app::Application::GetAppPath(paramsCmd));
}

TEST_F(PROF_APPLICATION_TEST, GetCmdString) {
    GlobalMockObject::verify();
	std::string paramsCmd;
    EXPECT_EQ("", analysis::dvvp::app::Application::GetCmdString(paramsCmd));

    paramsCmd = "bash";
	EXPECT_EQ(paramsCmd, analysis::dvvp::app::Application::GetCmdString(paramsCmd));
}
