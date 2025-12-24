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
#include "input_parser.h"
#include "config/open/config_manager.h"
#include "dyn_prof_client.h"
#include "platform/platform.h"

using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Msprof;
using namespace Analysis::Dvvp::Common::Config;
using namespace Collector::Dvvp::DynProf;
using namespace Analysis::Dvvp::Common::Platform;

constexpr int MSPROF_DAEMON_ERROR       = -1;
constexpr int MSPROF_DAEMON_OK          = 0;

class INPUT_PARSER_OPEN_UTEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(INPUT_PARSER_OPEN_UTEST, ProcessOptions) {
    GlobalMockObject::verify();
    InputParser parser = InputParser();
    struct MsprofCmdInfo cmdInfo = { {nullptr} };
    // invalid options
    EXPECT_EQ(PROFILING_FAILED, parser.ProcessOptions(-1, cmdInfo));

    char* resArgs = "on";
    MOCKER(mmGetOptArg)
        .stubs()
        .will(returnValue(resArgs));
    MOCKER_CPP(&InputParser::MsprofHostCheckValid)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&InputParser::MsprofCmdCheckValid)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&InputParser::MsprofSwitchCheckValid)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&InputParser::MsprofFreqCheckValid)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(PROFILING_SUCCESS, parser.ProcessOptions(ARGS_OUTPUT, cmdInfo));
    EXPECT_EQ(PROFILING_SUCCESS, parser.ProcessOptions(ARGS_ASCENDCL, cmdInfo));
    EXPECT_EQ(PROFILING_SUCCESS, parser.ProcessOptions(ARGS_AIC_FREQ, cmdInfo));
    EXPECT_EQ(PROFILING_SUCCESS, parser.ProcessOptions(ARGS_HOST_SYS, cmdInfo));
    EXPECT_EQ(PROFILING_FAILED, parser.ProcessOptions(100, cmdInfo));
}

TEST_F(INPUT_PARSER_OPEN_UTEST, SplitApplicationArgv) {
    GlobalMockObject::verify();
    InputParser parser = InputParser();
    int32_t argc = 4;
    const char *argv[] = {"msprof", "--output=./", "app", "arg1"};
    int32_t argCount = 1;
    parser.SplitApplicationArgv(argc, argv, argCount);
    EXPECT_EQ(2, argCount);
}

TEST_F(INPUT_PARSER_OPEN_UTEST, HandleApp) {
    GlobalMockObject::verify();
    InputParser parser = InputParser();
    parser.params_->application.emplace_back("app");
    parser.params_->application.emplace_back("arg1");
    parser.HandleApp();
    EXPECT_TRUE(parser.params_->app.compare("app") == 0);
    parser.params_->app = "test";
    parser.HandleApp();
    EXPECT_TRUE(parser.params_->app.compare("test") == 0);
}

TEST_F(INPUT_PARSER_OPEN_UTEST, CheckSysCpu) {
    GlobalMockObject::verify();
    InputParser parser = InputParser();
    struct MsprofCmdInfo cmdInfo = { {nullptr} };
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    MOCKER_CPP(&Analysis::Dvvp::Msprof::InputParser::CheckHostSysToolsIsExist)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    parser.params_->cpu_profiling = "on";
    EXPECT_EQ(MSPROF_DAEMON_OK, parser.CheckSysCpu());
    EXPECT_EQ(MSPROF_DAEMON_ERROR, parser.CheckSysCpu());
    EXPECT_EQ(MSPROF_DAEMON_OK, parser.CheckSysCpu());
}


TEST_F(INPUT_PARSER_OPEN_UTEST, MsprofHostCheckValid) {
    GlobalMockObject::verify();
    MOCKER(analysis::dvvp::common::utils::Utils::ExecCmd)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    InputParser parser = InputParser();
    struct MsprofCmdInfo cmdInfo = { {nullptr} };
    // invalid options
    EXPECT_EQ(PROFILING_FAILED, parser.MsprofHostCheckValid(cmdInfo, 999));

    EXPECT_EQ(PROFILING_FAILED, parser.MsprofHostCheckValid(cmdInfo, NR_ARGS));

    EXPECT_EQ(PROFILING_FAILED, parser.MsprofHostCheckValid(cmdInfo, ARGS_HOST_SYS));

    cmdInfo.args[ARGS_HOST_SYS] = "";
    EXPECT_EQ(PROFILING_FAILED, parser.MsprofHostCheckValid(cmdInfo, ARGS_HOST_SYS));

    cmdInfo.args[ARGS_HOST_SYS] = "cpu,mem";
    EXPECT_EQ(PROFILING_SUCCESS, parser.MsprofHostCheckValid(cmdInfo, ARGS_HOST_SYS));

    cmdInfo.args[ARGS_HOST_SYS] = "cpu,mem,network,osrt";
    EXPECT_EQ(PROFILING_FAILED, parser.MsprofHostCheckValid(cmdInfo, ARGS_HOST_SYS));

    cmdInfo.args[ARGS_HOST_SYS] = "cpu,mem,disk,network,osrt";
    parser.params_->result_dir = "./input_parser_utest";
    EXPECT_EQ(PROFILING_FAILED, parser.MsprofHostCheckValid(cmdInfo, ARGS_HOST_SYS));

    EXPECT_EQ(PROFILING_FAILED, parser.MsprofHostCheckValid(cmdInfo, ARGS_HOST_SYS_PID));
    cmdInfo.args[ARGS_HOST_SYS_PID] = "121312312123";
    EXPECT_EQ(PROFILING_FAILED, parser.MsprofHostCheckValid(cmdInfo, ARGS_HOST_SYS_PID));
    cmdInfo.args[ARGS_HOST_SYS_PID] = "";

    EXPECT_EQ(PROFILING_FAILED, parser.MsprofHostCheckValid(cmdInfo, ARGS_HOST_SYS_USAGE));
    cmdInfo.args[ARGS_HOST_SYS_USAGE] = "cpu,mem";
    EXPECT_EQ(PROFILING_SUCCESS, parser.MsprofHostCheckValid(cmdInfo, ARGS_HOST_SYS_USAGE));
    cmdInfo.args[ARGS_HOST_SYS_USAGE] = "disk,network,osrt";
    EXPECT_EQ(PROFILING_FAILED, parser.MsprofHostCheckValid(cmdInfo, ARGS_HOST_SYS_USAGE));
}


TEST_F(INPUT_PARSER_OPEN_UTEST, CheckHostSysCmdOutIsExist) {
    GlobalMockObject::verify();
    MOCKER(analysis::dvvp::common::utils::Utils::ExecCmd)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    InputParser parser = InputParser();
    std::string tempFile = "./CheckHostSysCmdOutIsExist";
    std::ofstream file(tempFile);
    file << "command not found" << std::endl;
    file.close();
    std::string toolName = "iotop";
    mmProcess tmpProcess = 1;
    // invalid options
    EXPECT_EQ(PROFILING_FAILED, parser.CheckHostSysCmdOutIsExist(tempFile, toolName, tmpProcess));
}

TEST_F(INPUT_PARSER_OPEN_UTEST, CheckHostOutString) {
    GlobalMockObject::verify();
    InputParser parser = InputParser();
    std::string tmpStr = "";
    std::string toolName = "iotop";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckHostOutString(tmpStr, toolName));
    tmpStr = "sudo";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckHostOutString(tmpStr, toolName));
    tmpStr = "iotop";
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckHostOutString(tmpStr, toolName));
}

TEST_F(INPUT_PARSER_OPEN_UTEST, UninitCheckHostSysCmd) {
    GlobalMockObject::verify();

    MOCKER(analysis::dvvp::common::utils::Utils::ExecCmd)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER(analysis::dvvp::common::utils::Utils::ProcessIsRuning)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    MOCKER(analysis::dvvp::common::utils::Utils::WaitProcess)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    InputParser parser = InputParser();
    mmProcess checkProcess = 1;

    EXPECT_EQ(PROFILING_SUCCESS, parser.UninitCheckHostSysCmd(checkProcess));
    EXPECT_EQ(PROFILING_FAILED, parser.UninitCheckHostSysCmd(checkProcess));
    EXPECT_EQ(PROFILING_SUCCESS, parser.UninitCheckHostSysCmd(checkProcess));
}

TEST_F(INPUT_PARSER_OPEN_UTEST, CheckOutputValid) {
    GlobalMockObject::verify();
    InputParser parser = InputParser();
    struct MsprofCmdInfo cmdInfo = { {nullptr} };

    EXPECT_EQ(PROFILING_FAILED, parser.CheckOutputValid(cmdInfo));
    cmdInfo.args[ARGS_OUTPUT] = "";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckOutputValid(cmdInfo));
    cmdInfo.args[ARGS_OUTPUT] = "./";
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckOutputValid(cmdInfo));
}

TEST_F(INPUT_PARSER_OPEN_UTEST, CheckStorageLimitValid) {
    GlobalMockObject::verify();
    InputParser parser = InputParser();
    struct MsprofCmdInfo cmdInfo = { {nullptr} };

    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckStorageLimitValid(cmdInfo));
    cmdInfo.args[ARGS_STORAGE_LIMIT] = "";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckStorageLimitValid(cmdInfo));
    cmdInfo.args[ARGS_STORAGE_LIMIT] = "1000MB";
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckStorageLimitValid(cmdInfo));
    cmdInfo.args[ARGS_STORAGE_LIMIT] = "10MB";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckStorageLimitValid(cmdInfo));
}

TEST_F(INPUT_PARSER_OPEN_UTEST, GetAppParam) {
    GlobalMockObject::verify();
    InputParser parser = InputParser();
    std::remove("./GetAppParam");
    EXPECT_EQ(PROFILING_FAILED, parser.GetAppParam(""));
    EXPECT_EQ(PROFILING_FAILED, parser.GetAppParam(" "));
    EXPECT_EQ(PROFILING_FAILED, parser.GetAppParam("./GetAppParam"));
    EXPECT_EQ(PROFILING_FAILED, parser.GetAppParam("./GetAppParam a"));
    std::ofstream file("GetAppParam");
    file << "command not found" << std::endl;
    file.close();
    EXPECT_EQ(PROFILING_SUCCESS, parser.GetAppParam("./GetAppParam a"));
    MOCKER_CPP(&analysis::dvvp::common::utils::Utils::SplitPath)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(PROFILING_FAILED, parser.GetAppParam("./GetAppParam a"));
}

TEST_F(INPUT_PARSER_OPEN_UTEST, CheckAppValid) {
    GlobalMockObject::verify();
    InputParser parser = InputParser();
    struct MsprofCmdInfo cmdInfo = { {nullptr} };
    std::remove("./CheckAppValid");
    EXPECT_EQ(PROFILING_FAILED, parser.CheckAppValid(cmdInfo));
    MOCKER_CPP(&Analysis::Dvvp::Msprof::InputParser::GetAppParam)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    cmdInfo.args[ARGS_APPLICATION] = "bash";
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckAppValid(cmdInfo));
    cmdInfo.args[ARGS_APPLICATION] = "";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckAppValid(cmdInfo));
    cmdInfo.args[ARGS_APPLICATION] = "./bash";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckAppValid(cmdInfo));
    cmdInfo.args[ARGS_APPLICATION] = "./CheckAppValid a";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckAppValid(cmdInfo));
    std::ofstream file("CheckAppValid");
    file << "command not found" << std::endl;
    file.close();
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckAppValid(cmdInfo));
    MOCKER_CPP(&analysis::dvvp::common::utils::Utils::SplitPath)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(PROFILING_FAILED, parser.CheckAppValid(cmdInfo));
    std::remove("./CheckAppValid");
    cmdInfo.args[ARGS_APPLICATION] = "./libs/xaclfk/xaclfk -m /home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_L1_fp16_32768_1_32768_1_32768_1_TF_32768_b41d37.om -o /home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/out_ID2940_WideDeep_L1_fp16_32768_1_32768_1_32768_1_TF_32768_b41d37 -i /home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_00_ad_advertiser_input_0,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_01_ad_id_input_1,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_02_ad_views_log_01scaled_input_2,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_03_doc_ad_category_id_input_3,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_04_doc_ad_days_since_published_log_01scaled_input_4,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_05_doc_ad_entity_id_input_5,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_06_doc_ad_publisher_id_input_6,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_07_doc_ad_source_id_input_7,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_08_doc_ad_topic_id_input_8,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_09_doc_event_category_id_input_9,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_10_doc_event_days_since_published_log_01scaled_input_10,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_11_doc_event_doc_ad_sim_categories_log_01scaled_input_11,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_12_doc_event_doc_ad_sim_entities_log_01scaled_input_12,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_13_doc_event_doc_ad_sim_topics_log_01scaled_input_13,xrunfk//home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_14_doc_event_entity_id_input_14,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_15_doc_event_hour_log_01scaled_input_15,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_16_doc_event_id_input_16,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_17_doc_event_publisher_id_input_17,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_18_doc_event_source_id_input_18,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_19_doc_event_topic_id_input_19,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_20_doc_id_input_20,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_21_doc_views_log_01scaled_input_21,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_22_event_country_input_22,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_23_event_country_state_input_23,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_24_event_geo_location_input_24,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_25_event_hour_input_25,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_26_event_platform_input_26,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_27_event_weekend_input_27,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_28_pop_ad_id_conf_input_28,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_29_pop_ad_id_log_01scaled_input_29,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_30_pop_advertiser_id_conf_input_30,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_31_pop_advertiser_id_log_01scaled_input_31,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_32_pop_campain_id_conf_multipl_log_01scaled_input_32,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_33_pop_campain_id_log_01scaled_input_33,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_34_pop_category_id_conf_input_34,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_35_pop_category_id_log_01scaled_input_35,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_36_pop_document_id_conf_input_36,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_37_pop_document_id_log_01scaled_input_37,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_38_pop_entity_id_conf_input_38,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_39_pop_entity_id_log_01scaled_input_39,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_40_pop_publisher_id_conf_input_40,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_41_pop_publisher_id_log_01scaled_input_41,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_42_pop_source_id_conf_input_42,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_43_pop_source_id_log_01scaled_input_43,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_44_pop_topic_id_conf_input_44,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_45_pop_topic_id_log_01scaled_input_45,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_46_traffic_source_input_46,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_47_user_doc_ad_sim_categories_conf_input_47,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_48_user_doc_ad_sim_categories_log_01scaled_input_48,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_49_user_doc_ad_sim_entities_log_01scaled_input_49,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_50_user_doc_ad_sim_topics_conf_input_50,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_51_user_doc_ad_sim_topics_log_01scaled_input_51,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_52_user_has_already_viewed_doc_input_52,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_53_user_views_log_01scaled_input_53 -n 0 -l 800";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckAppValid(cmdInfo));
}

TEST_F(INPUT_PARSER_OPEN_UTEST, CheckEnvironmentValid) {
    GlobalMockObject::verify();
    InputParser parser = InputParser();
    struct MsprofCmdInfo cmdInfo = { {nullptr} };

    EXPECT_EQ(PROFILING_FAILED, parser.CheckEnvironmentValid(cmdInfo));
    cmdInfo.args[ARGS_ENVIRONMENT] = "";

    EXPECT_EQ(PROFILING_FAILED, parser.CheckEnvironmentValid(cmdInfo));
    cmdInfo.args[ARGS_ENVIRONMENT] = "aa";
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckEnvironmentValid(cmdInfo));
}

TEST_F(INPUT_PARSER_OPEN_UTEST, CheckPythonPathValid) {
    GlobalMockObject::verify();
    InputParser parser = InputParser();
    struct MsprofCmdInfo cmdInfo = { {nullptr} };

    EXPECT_EQ(PROFILING_FAILED, parser.CheckPythonPathValid(cmdInfo));
    cmdInfo.args[ARGS_PYTHON_PATH] = "";

    EXPECT_EQ(PROFILING_FAILED, parser.CheckPythonPathValid(cmdInfo));
    
    parser.params_->pythonPath.clear();
    std::string tests = std::string(1025, 'c');
    char* test = const_cast<char*>(tests.c_str()); 
    cmdInfo.args[ARGS_PYTHON_PATH] = test;
    EXPECT_EQ(PROFILING_FAILED, parser.CheckPythonPathValid(cmdInfo));

    cmdInfo.args[ARGS_PYTHON_PATH] = "@";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckPythonPathValid(cmdInfo));

    cmdInfo.args[ARGS_PYTHON_PATH] = "testpython";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckPythonPathValid(cmdInfo));
    
    Utils::CreateDir("TestPython");
    MOCKER(mmAccess2).stubs().will(returnValue(-1)).then(returnValue(0));
    cmdInfo.args[ARGS_PYTHON_PATH] = "TestPython";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckPythonPathValid(cmdInfo));
    EXPECT_EQ(PROFILING_FAILED, parser.CheckPythonPathValid(cmdInfo));
    Utils::RemoveDir("TestPython");
    cmdInfo.args[ARGS_PYTHON_PATH] = "testpython";
    std::ofstream ftest("testpython");
    ftest << "test";
    ftest.close();
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckPythonPathValid(cmdInfo));
    remove("testpython");
}

TEST_F(INPUT_PARSER_OPEN_UTEST, ParamsCheck) {
    GlobalMockObject::verify();
    InputParser parser = InputParser();
    auto pp = parser.params_;
    parser.params_.reset();
    EXPECT_EQ(PROFILING_FAILED, parser.ParamsCheck());
    parser.params_ = pp;
    parser.params_->app_dir="./test";
    parser.params_->result_dir="./profiling_data";
    EXPECT_EQ(PROFILING_SUCCESS, parser.ParamsCheck());
    parser.params_->result_dir="";
    EXPECT_EQ(PROFILING_SUCCESS, parser.ParamsCheck());
    EXPECT_EQ(parser.params_->app_dir, parser.params_->result_dir);

    parser.params_->result_dir="";
    std::string work_path = "/tmp/ascend_work_path/";
    std::string profiling_path = "profiling_data";
    std::string result_path = work_path + profiling_path;
    MOCKER(analysis::dvvp::common::utils::Utils::HandleEnvString).stubs().will(returnValue(work_path));
    MOCKER(analysis::dvvp::common::utils::Utils::CreateDir)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, parser.ParamsCheck());

    MOCKER(analysis::dvvp::common::utils::Utils::IsDirAccessible)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    EXPECT_EQ(PROFILING_FAILED, parser.ParamsCheck());
    MOCKER(analysis::dvvp::common::utils::Utils::CanonicalizePath)
        .stubs()
        .will(returnValue(std::string("")))
        .then(returnValue(result_path));
    EXPECT_EQ(PROFILING_FAILED, parser.ParamsCheck());
    EXPECT_EQ(PROFILING_SUCCESS, parser.ParamsCheck());
    EXPECT_EQ(result_path, parser.params_->result_dir);
}

TEST_F(INPUT_PARSER_OPEN_UTEST, ASCEND_WORK_PATH)
{
    std::string resultDir("/tmp/test/profiling");
    setenv("ASCEND_WORK_PATH", resultDir.c_str(), 1);
    char *argv[] = {"msprof", "--aicpu=on", "python3", "test.py", nullptr};
    optind = 1;
    InputParser parser = InputParser();
    auto params = parser.MsprofGetOpts(4, (const char**)argv);
    EXPECT_EQ(true, params->result_dir == (resultDir + "/profiling_data"));
    unsetenv("ASCEND_WORK_PATH");
}

TEST_F(INPUT_PARSER_OPEN_UTEST, DefaultOutput)
{
    char *argv[] = {"msprof", "--aicpu=on", "python3", "test.py", nullptr};
    optind = 1;
    InputParser parser = InputParser();
    auto params = parser.MsprofGetOpts(4, (const char**)argv);
    std::string result = analysis::dvvp::common::utils::Utils::CanonicalizePath("./");
    EXPECT_EQ(true, params->result_dir == result);
}

TEST_F(INPUT_PARSER_OPEN_UTEST, SetHostSysParam) {
    GlobalMockObject::verify();
    InputParser parser = InputParser();
    parser.SetHostSysParam("123");
    parser.SetHostSysParam("osrt");
    EXPECT_EQ(parser.params_->host_osrt_profiling, "on");
}

TEST_F(INPUT_PARSER_OPEN_UTEST, CheckHostSysValid) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckHostSysOptionsIsValid)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    MOCKER_CPP(&Analysis::Dvvp::Msprof::InputParser::CheckHostSysToolsIsExist)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    InputParser parser = InputParser();
    struct MsprofCmdInfo cmdInfo = { {nullptr} };
    cmdInfo.args[ARGS_HOST_SYS] = "osrt,disk";
    parser.params_->result_dir = "./input_parser_utest";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckHostSysValid(cmdInfo));
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckHostSysValid(cmdInfo));
}

TEST_F(INPUT_PARSER_OPEN_UTEST, CheckHostSysUsageValid) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckHostSysUsageOptionsIsValid)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    InputParser parser = InputParser();
    struct MsprofCmdInfo cmdInfo = { {nullptr} };
    cmdInfo.args[ARGS_HOST_SYS_USAGE] = "cpu,mem";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckHostSysUsageValid(cmdInfo));
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckHostSysUsageValid(cmdInfo));
}

TEST_F(INPUT_PARSER_OPEN_UTEST, CheckBaseOrder) {
    EXPECT_EQ(ARGS_INSTR_PROFILING, LONG_OPTIONS[ARGS_INSTR_PROFILING].val);
    EXPECT_EQ(ARGS_INSTR_PROFILING_FREQ, LONG_OPTIONS[ARGS_INSTR_PROFILING_FREQ].val);
}

TEST_F(INPUT_PARSER_OPEN_UTEST, CheckBaseInfo) {
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_V4_1_0))
        .then(returnValue(15));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::AscendHalAdaptor::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    InputParser parser = InputParser();

    struct MsprofCmdInfo cmdInfo = { {nullptr} };
    auto configManger = Analysis::Dvvp::Common::Config::ConfigManager::instance();
    Platform::instance()->Init();

    EXPECT_EQ(PROFILING_FAILED, parser.CheckSampleModeValid(cmdInfo, ARGS_AIV_MODE));
    EXPECT_EQ(PROFILING_FAILED, parser.CheckSampleModeValid(cmdInfo, ARGS_AIC_MODE));
    cmdInfo.args[ARGS_AIV_MODE] = "aa";
    cmdInfo.args[ARGS_AIC_MODE] = "aa";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckSampleModeValid(cmdInfo, ARGS_AIV_MODE));
    EXPECT_EQ(PROFILING_FAILED, parser.CheckSampleModeValid(cmdInfo, ARGS_AIC_MODE));
    cmdInfo.args[ARGS_AIV_MODE] = "sample-based";
    cmdInfo.args[ARGS_AIC_MODE] = "sample-based";
    configManger->configMap_["type"] = "5";
    configManger->isInit_ = true;
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckSampleModeValid(cmdInfo, ARGS_AIV_MODE));
    configManger->Uninit();
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckSampleModeValid(cmdInfo, ARGS_AIC_MODE));

    // check aic metrics valid
    EXPECT_EQ(PROFILING_FAILED, parser.CheckAiCoreMetricsValid(cmdInfo, ARGS_AIC_METRICS));
    EXPECT_EQ(PROFILING_FAILED, parser.CheckAiCoreMetricsValid(cmdInfo, ARGS_AIV_METRICS));

    cmdInfo.args[ARGS_AIC_METRICS] = "";
    cmdInfo.args[ARGS_AIV_METRICS] = "";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckAiCoreMetricsValid(cmdInfo, ARGS_AIC_METRICS));
    EXPECT_EQ(PROFILING_FAILED, parser.CheckAiCoreMetricsValid(cmdInfo, ARGS_AIV_METRICS));

    cmdInfo.args[ARGS_AIC_METRICS] = "1";
    cmdInfo.args[ARGS_AIV_METRICS] = "1";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckAiCoreMetricsValid(cmdInfo, ARGS_AIC_METRICS));
    EXPECT_EQ(PROFILING_FAILED, parser.CheckAiCoreMetricsValid(cmdInfo, ARGS_AIV_METRICS));

    cmdInfo.args[ARGS_AIC_METRICS] = "Memory";
    cmdInfo.args[ARGS_AIV_METRICS] = "Memory";
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckAiCoreMetricsValid(cmdInfo, ARGS_AIC_METRICS));
    configManger->configMap_["type"] = "5";
    configManger->Init();
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckAiCoreMetricsValid(cmdInfo, ARGS_AIV_METRICS));

    cmdInfo.args[ARGS_NPU_EVENTS] = "0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x9";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckNpuEventsValid(cmdInfo, ARGS_NPU_EVENTS));
    cmdInfo.args[ARGS_NPU_EVENTS] = "0x1,0x2,0x3";
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckNpuEventsValid(cmdInfo, ARGS_NPU_EVENTS));

    // Failed to check scale, please check if input duplicate type
    cmdInfo.args[ARGS_SCALE] = "opType:Index;opType:aclnn_matmul_index";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckCmdScaleIsValid(cmdInfo));
    // Failed to check empty scale
    cmdInfo.args[ARGS_SCALE] = "opType:;opName:aclnn_matmul_index";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckCmdScaleIsValid(cmdInfo));
    // Failed to check unkown scale type
    cmdInfo.args[ARGS_SCALE] = "op type:Index;opName:aclnn_matmul_index";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckCmdScaleIsValid(cmdInfo));
    cmdInfo.args[ARGS_SCALE] = "Index";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckCmdScaleIsValid(cmdInfo));
    // Failed to check overflow scale
    std::string opName(4096, 't');
    std::string scaleOpName = "opName:" + opName;
    cmdInfo.args[ARGS_SCALE] = const_cast<char *>(scaleOpName.c_str());
    EXPECT_EQ(PROFILING_FAILED, parser.CheckCmdScaleIsValid(cmdInfo));

    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::MINI_V3_TYPE));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    cmdInfo.args[ARGS_AIC_METRICS] = "PipelineExecuteUtilization";
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckAiCoreMetricsValid(cmdInfo, ARGS_AIV_METRICS));
    EXPECT_EQ(PROFILING_FAILED, parser.CheckCmdScaleIsValid(cmdInfo));
    configManger->Uninit();

    // check summary format
    EXPECT_EQ(PROFILING_FAILED, parser.CheckExportSummaryFormat(cmdInfo));
    cmdInfo.args[ARGS_SUMMARY_FORMAT] = "aaa";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckExportSummaryFormat(cmdInfo));
    cmdInfo.args[ARGS_SUMMARY_FORMAT] = "csv";
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckExportSummaryFormat(cmdInfo));
    cmdInfo.args[ARGS_SUMMARY_FORMAT] = "json";
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckExportSummaryFormat(cmdInfo));

    // check llc
    EXPECT_EQ(PROFILING_FAILED, parser.CheckLlcProfilingValid(cmdInfo));
    cmdInfo.args[ARGS_LLC_PROFILING] = "";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckLlcProfilingValid(cmdInfo));
    cmdInfo.args[ARGS_LLC_PROFILING] = "read";
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckLlcProfilingValid(cmdInfo));
    cmdInfo.args[ARGS_LLC_PROFILING] = "capacity";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckLlcProfilingValid(cmdInfo));

    // check period
    EXPECT_EQ(PROFILING_FAILED, parser.CheckSysPeriodValid(cmdInfo));
    cmdInfo.args[ARGS_SYS_PERIOD] = "capacity";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckSysPeriodValid(cmdInfo));
    cmdInfo.args[ARGS_SYS_PERIOD] = "-1";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckSysPeriodValid(cmdInfo));
    cmdInfo.args[ARGS_SYS_PERIOD] = "2";
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckSysPeriodValid(cmdInfo));

    // check devices
    EXPECT_EQ(PROFILING_FAILED, parser.CheckSysDevicesValid(cmdInfo));
    cmdInfo.args[ARGS_SYS_DEVICES] = "";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckSysDevicesValid(cmdInfo));
    cmdInfo.args[ARGS_SYS_DEVICES] = "all";
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckSysDevicesValid(cmdInfo));
    cmdInfo.args[ARGS_SYS_DEVICES] = "A";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckSysDevicesValid(cmdInfo));

    // check arg on off
    EXPECT_EQ(PROFILING_FAILED, parser.CheckArgOnOff(cmdInfo, ARGS_ASCENDCL));
    cmdInfo.args[ARGS_TASK_TIME] = "tas";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckArgOnOff(cmdInfo, ARGS_TASK_TIME));
    cmdInfo.args[ARGS_TASK_TIME] = "off";
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckArgOnOff(cmdInfo, ARGS_TASK_TIME));
    cmdInfo.args[ARGS_TASK_TIME] = "L1";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckArgOnOff(cmdInfo, ARGS_TASK_TIME));
    cmdInfo.args[ARGS_TASK_TIME] = "l1";
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckArgOnOff(cmdInfo, ARGS_TASK_TIME));
    cmdInfo.args[ARGS_GE_API] = "fwk";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckArgOnOff(cmdInfo, ARGS_GE_API));
    cmdInfo.args[ARGS_GE_API] = "off";
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckArgOnOff(cmdInfo, ARGS_GE_API));
    cmdInfo.args[ARGS_GE_API] = "L1";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckArgOnOff(cmdInfo, ARGS_GE_API));
    cmdInfo.args[ARGS_GE_API] = "l1";
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckArgOnOff(cmdInfo, ARGS_GE_API));
    cmdInfo.args[ARGS_ASCENDCL] = "A";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckArgOnOff(cmdInfo, ARGS_ASCENDCL));

    // check arg range
    EXPECT_EQ(PROFILING_FAILED, parser.CheckArgRange(cmdInfo,ARGS_INTERCONNECTION_PROFILING, 1, 100));

    cmdInfo.args[ARGS_INTERCONNECTION_PROFILING] = "A";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckArgRange(cmdInfo,ARGS_INTERCONNECTION_PROFILING, 1, 100));
    cmdInfo.args[ARGS_INTERCONNECTION_PROFILING] = "111";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckArgRange(cmdInfo,ARGS_INTERCONNECTION_PROFILING, 1, 100));
    cmdInfo.args[ARGS_INTERCONNECTION_PROFILING] = "1";
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckArgRange(cmdInfo,ARGS_INTERCONNECTION_PROFILING, 1, 100));

    // check args is number
    EXPECT_EQ(PROFILING_FAILED, parser.CheckArgsIsNumber(cmdInfo, ARGS_EXPORT_ITERATION_ID));
    cmdInfo.args[ARGS_EXPORT_ITERATION_ID] = "a";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckArgsIsNumber(cmdInfo, ARGS_EXPORT_ITERATION_ID));
    cmdInfo.args[ARGS_EXPORT_ITERATION_ID] = "1";
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckArgsIsNumber(cmdInfo, ARGS_EXPORT_ITERATION_ID));

    // check analyze rule valid range
    cmdInfo.args[ARGS_RULE] = nullptr;
    EXPECT_EQ(PROFILING_FAILED, parser.CheckAnalyzeRuleSwitch(cmdInfo));
    cmdInfo.args[ARGS_RULE] = "on";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckAnalyzeRuleSwitch(cmdInfo));
    cmdInfo.args[ARGS_RULE] = "communication";
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckAnalyzeRuleSwitch(cmdInfo));
    cmdInfo.args[ARGS_RULE] = "communication,communication_matrix";
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckAnalyzeRuleSwitch(cmdInfo));

    // params switch valid
    cmdInfo.args[ARGS_IO_PROFILING] = "1";
    cmdInfo.args[ARGS_MODEL_EXECUTION] = "1";
    cmdInfo.args[ARGS_RUNTIME_API] = "1";
    cmdInfo.args[ARGS_TASK_TSFW] = "1";
    cmdInfo.args[ARGS_AI_CORE] = "1";
    cmdInfo.args[ARGS_AIV] = "1";
    cmdInfo.args[ARGS_CPU_PROFILING] = "1";
    cmdInfo.args[ARGS_SYS_PROFILING] = "1";
    cmdInfo.args[ARGS_PID_PROFILING] = "1";
    cmdInfo.args[ARGS_HARDWARE_MEM] = "1";
    cmdInfo.args[ARGS_INTERCONNECTION_PROFILING] = "1";
    cmdInfo.args[ARGS_DVPP_PROFILING] = "1";
    cmdInfo.args[ARGS_L2_PROFILING] = "1";
    cmdInfo.args[ARGS_AICPU] = "1";
    cmdInfo.args[ARGS_TASK_BLOCK] = "1";
    cmdInfo.args[ARGS_SYS_LOW_POWER] = "1";
    cmdInfo.args[ARGS_DVPP_FREQ] = "1";
    cmdInfo.args[ARGS_IO_SAMPLING_FREQ] = "1";
    cmdInfo.args[ARGS_PID_SAMPLING_FREQ] = "1";
    cmdInfo.args[ARGS_SYS_SAMPLING_FREQ] = "1";
    cmdInfo.args[ARGS_CPU_SAMPLING_FREQ] = "1";
    cmdInfo.args[ARGS_HCCL] = "1";
    cmdInfo.args[ARGS_INSTR_PROFILING] = "1";
    cmdInfo.args[ARGS_PARSE] = "1";
    cmdInfo.args[ARGS_QUERY] = "1";
    cmdInfo.args[ARGS_EXPORT] = "1";
    cmdInfo.args[ARGS_ANALYZE] = "1";
    cmdInfo.args[ARGS_CLEAR] = "1";
    cmdInfo.args[ARGS_TASK_MEMORY] = "on";
    cmdInfo.args[ARGS_TASK_TRACE] = "on";
    parser.ParamsSwitchValid(cmdInfo, ARGS_TASK_MEMORY);
    parser.ParamsSwitchValid(cmdInfo, ARGS_IO_PROFILING);
    parser.ParamsSwitchValid(cmdInfo, ARGS_MODEL_EXECUTION);
    parser.ParamsSwitchValid(cmdInfo, ARGS_RUNTIME_API);
    parser.ParamsSwitchValid(cmdInfo, ARGS_TASK_TSFW);
    parser.ParamsSwitchValid(cmdInfo, ARGS_AI_CORE);
    parser.ParamsSwitchValid(cmdInfo, ARGS_AIV);
    parser.ParamsSwitchValid(cmdInfo, ARGS_CPU_PROFILING);
    parser.ParamsSwitchValid(cmdInfo, ARGS_SYS_PROFILING);
    parser.ParamsSwitchValid(cmdInfo, ARGS_PID_PROFILING);
    parser.ParamsSwitchValid(cmdInfo, ARGS_HARDWARE_MEM);
    parser.ParamsSwitchValid(cmdInfo, ARGS_HCCL);
    parser.ParamsSwitchValid(cmdInfo, ARGS_INSTR_PROFILING);
    parser.ParamsSwitchValid(cmdInfo, 111);
    parser.ParamsSwitchValid(cmdInfo, ARGS_TASK_TRACE);
    parser.ParamsSwitchValid2(cmdInfo, 111);
    parser.ParamsSwitchValid2(cmdInfo, ARGS_INTERCONNECTION_PROFILING);
    parser.ParamsSwitchValid2(cmdInfo, ARGS_DVPP_PROFILING);
    parser.ParamsSwitchValid2(cmdInfo, ARGS_L2_PROFILING);
    parser.ParamsSwitchValid2(cmdInfo, ARGS_AICPU);
    parser.ParamsSwitchValid2(cmdInfo, ARGS_TASK_BLOCK);
    parser.ParamsSwitchValid2(cmdInfo, ARGS_SYS_LOW_POWER);
    parser.ParamsSwitchValid2(cmdInfo, ARGS_PARSE);
    parser.ParamsSwitchValid2(cmdInfo, ARGS_QUERY);
    parser.ParamsSwitchValid2(cmdInfo, ARGS_EXPORT);
    parser.ParamsSwitchValid2(cmdInfo, ARGS_ANALYZE);
    parser.ParamsSwitchValid2(cmdInfo, ARGS_CLEAR);
}

TEST_F(INPUT_PARSER_OPEN_UTEST, PreCheckPlatform) {
    InputParser parser = InputParser();
    struct MsprofCmdInfo cmdInfo = { {nullptr} };
    const char * argv[] = {"aiv-me"};
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::END_TYPE))
        .then(returnValue(Analysis::Dvvp::Common::Config::PlatformType::DC_TYPE))
        .then(returnValue(Analysis::Dvvp::Common::Config::PlatformType::CHIP_V4_1_0));
    EXPECT_EQ(PROFILING_FAILED, parser.PreCheckPlatform(ARGS_AIV, argv));
    MOCKER(mmGetOptInd)
        .stubs()
        .will(returnValue(1));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    parser.PreCheckPlatform(ARGS_AIV, argv);
    parser.PreCheckPlatform(ARGS_INTERCONNECTION_PROFILING, argv);
    EXPECT_EQ(PROFILING_SUCCESS, parser.PreCheckPlatform(ARGS_DYNAMIC_PROF, argv));
    EXPECT_EQ(PROFILING_FAILED, parser.PreCheckPlatform(ARGS_HOST_SYS_PID, argv));
}

TEST_F(INPUT_PARSER_OPEN_UTEST, MsprofCmdCheckValid) {
    InputParser parser = InputParser();
    struct MsprofCmdInfo cmdInfo = { {nullptr} };
    cmdInfo.args[ARGS_AIV_MODE] = "sample-baseddddd";
    cmdInfo.args[ARGS_AIC_METRICS] = "PipeUtilization";
    cmdInfo.args[ARGS_TASK_BLOCK] = "aa";
    cmdInfo.args[ARGS_SYS_LOW_POWER] = "bb";
    cmdInfo.args[ARGS_SUMMARY_FORMAT] = "csv";
    cmdInfo.args[ARGS_PYTHON_PATH] = "123";
    cmdInfo.args[ARGS_DYNAMIC_PROF] = "on";
    cmdInfo.args[ARGS_DYNAMIC_PROF_PID] = "123";
    cmdInfo.args[ARGS_DELAY_PROF] = "1";
    cmdInfo.args[ARGS_DURATION_PROF] = "1";
    cmdInfo.args[ARGS_NPU_EVENTS] = "";
    MOCKER(mmGetOptInd)
        .stubs()
        .will(returnValue(1));
    parser.MsprofCmdCheckValid(cmdInfo, ARGS_AIV_MODE);
    parser.MsprofCmdCheckValid(cmdInfo, ARGS_AIC_METRICS);
    parser.MsprofCmdCheckValid(cmdInfo, ARGS_TASK_BLOCK);
    parser.MsprofCmdCheckValid(cmdInfo, ARGS_SYS_LOW_POWER);
    parser.MsprofCmdCheckValid(cmdInfo, ARGS_SUMMARY_FORMAT);
    parser.MsprofCmdCheckValid(cmdInfo, ARGS_PYTHON_PATH);
    EXPECT_EQ(MSPROF_DAEMON_OK, parser.MsprofCmdCheckValid(cmdInfo, ARGS_DYNAMIC_PROF));
    EXPECT_EQ(MSPROF_DAEMON_OK, parser.MsprofCmdCheckValid(cmdInfo, ARGS_DYNAMIC_PROF_PID));
    EXPECT_EQ(MSPROF_DAEMON_OK, parser.MsprofCmdCheckValid(cmdInfo, ARGS_DELAY_PROF));
    EXPECT_EQ(MSPROF_DAEMON_OK, parser.MsprofCmdCheckValid(cmdInfo, ARGS_DURATION_PROF));
    EXPECT_EQ(MSPROF_DAEMON_OK, parser.MsprofCmdCheckValid(cmdInfo, ARGS_NPU_EVENTS));
    cmdInfo.args[ARGS_NPU_EVENTS] = "abcdefghijklmn";
    EXPECT_EQ(MSPROF_DAEMON_ERROR, parser.MsprofCmdCheckValid(cmdInfo, ARGS_NPU_EVENTS));
    EXPECT_EQ(MSPROF_DAEMON_ERROR, parser.MsprofCmdCheckValid(cmdInfo, ARGS_MEM_SERVICEFLOW));
    cmdInfo.args[ARGS_MEM_SERVICEFLOW] = "";
    EXPECT_EQ(MSPROF_DAEMON_ERROR, parser.MsprofCmdCheckValid(cmdInfo, ARGS_MEM_SERVICEFLOW));
    cmdInfo.args[ARGS_MEM_SERVICEFLOW] = "aaa,bbb";
    EXPECT_EQ(MSPROF_DAEMON_OK, parser.MsprofCmdCheckValid(cmdInfo, ARGS_MEM_SERVICEFLOW));
}

TEST_F(INPUT_PARSER_OPEN_UTEST, MsprofFreqCheckValid) {
    InputParser parser = InputParser();
    struct MsprofCmdInfo cmdInfo = { {nullptr} };
    EXPECT_EQ(PROFILING_FAILED, parser.MsprofFreqCheckValid(cmdInfo, 100));
    cmdInfo.args[ARGS_SYS_PERIOD] = "100";
    cmdInfo.args[ARGS_SYS_SAMPLING_FREQ] = "1";
    cmdInfo.args[ARGS_PID_SAMPLING_FREQ] = "1";
    cmdInfo.args[ARGS_CPU_SAMPLING_FREQ] = "10";
    cmdInfo.args[ARGS_INTERCONNECTION_FREQ] = "10";
    cmdInfo.args[ARGS_IO_SAMPLING_FREQ] = "60";
    cmdInfo.args[ARGS_DVPP_FREQ] = "60";
    cmdInfo.args[ARGS_HARDWARE_MEM_SAMPLING_FREQ] = "100";
    cmdInfo.args[ARGS_AIC_FREQ] = "20";
    cmdInfo.args[ARGS_AIV_FREQ] = "20";
    cmdInfo.args[ARGS_EXPORT_ITERATION_ID] = "1";
    cmdInfo.args[ARGS_EXPORT_MODEL_ID] = "1";
    cmdInfo.args[ARGS_INSTR_PROFILING_FREQ] = "1000";
    cmdInfo.args[ARGS_HOST_SYS_USAGE_FREQ] = "20";

    EXPECT_EQ(PROFILING_SUCCESS, parser.MsprofFreqCheckValid(cmdInfo, ARGS_SYS_PERIOD));
    EXPECT_EQ(PROFILING_SUCCESS, parser.MsprofFreqCheckValid(cmdInfo, ARGS_SYS_SAMPLING_FREQ));
    EXPECT_EQ(PROFILING_SUCCESS, parser.MsprofFreqCheckValid(cmdInfo, ARGS_PID_SAMPLING_FREQ));
    EXPECT_EQ(PROFILING_SUCCESS, parser.MsprofFreqCheckValid(cmdInfo, ARGS_CPU_SAMPLING_FREQ));
    EXPECT_EQ(PROFILING_SUCCESS, parser.MsprofFreqCheckValid(cmdInfo, ARGS_INTERCONNECTION_FREQ));
    EXPECT_EQ(PROFILING_SUCCESS, parser.MsprofFreqCheckValid(cmdInfo, ARGS_IO_SAMPLING_FREQ));
    EXPECT_EQ(PROFILING_SUCCESS, parser.MsprofFreqCheckValid(cmdInfo, ARGS_DVPP_FREQ));
    EXPECT_EQ(PROFILING_SUCCESS, parser.MsprofFreqCheckValid(cmdInfo, ARGS_HARDWARE_MEM_SAMPLING_FREQ));
    EXPECT_EQ(PROFILING_SUCCESS, parser.MsprofFreqCheckValid(cmdInfo, ARGS_AIC_FREQ));
    EXPECT_EQ(PROFILING_SUCCESS, parser.MsprofFreqCheckValid(cmdInfo, ARGS_AIV_FREQ));
    EXPECT_EQ(PROFILING_SUCCESS, parser.MsprofFreqCheckValid(cmdInfo, ARGS_EXPORT_ITERATION_ID));
    EXPECT_EQ(PROFILING_SUCCESS, parser.MsprofFreqCheckValid(cmdInfo, ARGS_EXPORT_MODEL_ID));
    EXPECT_EQ(PROFILING_SUCCESS, parser.MsprofFreqCheckValid(cmdInfo, ARGS_INSTR_PROFILING_FREQ));
    EXPECT_EQ(PROFILING_SUCCESS, parser.MsprofFreqCheckValid(cmdInfo, ARGS_HOST_SYS_USAGE_FREQ));
    // useless test
    MOCKER_CPP(&Platform::CheckIfSupport, bool (Platform::*)(const PlatformFeature) const)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(PROFILING_SUCCESS, parser.MsprofFreqCheckValid(cmdInfo, ARGS_INSTR_PROFILING_FREQ));

    // Incorrect input
    cmdInfo.args[ARGS_EXPORT_ITERATION_ID] = "";
    EXPECT_EQ(PROFILING_FAILED, parser.MsprofFreqCheckValid(cmdInfo, ARGS_EXPORT_ITERATION_ID));
    cmdInfo.args[ARGS_EXPORT_ITERATION_ID] = "abc";
    EXPECT_EQ(PROFILING_FAILED, parser.MsprofFreqCheckValid(cmdInfo, ARGS_EXPORT_ITERATION_ID));
    cmdInfo.args[ARGS_EXPORT_ITERATION_ID] = "4294967296";
    EXPECT_EQ(PROFILING_FAILED, parser.MsprofFreqCheckValid(cmdInfo, ARGS_EXPORT_ITERATION_ID));
    cmdInfo.args[ARGS_EXPORT_ITERATION_ID] = "4294967295";
    EXPECT_EQ(PROFILING_SUCCESS, parser.MsprofFreqCheckValid(cmdInfo, ARGS_EXPORT_ITERATION_ID));
    cmdInfo.args[ARGS_EXPORT_ITERATION_ID] = "12345678901234567890123456789012345678901234567890123456789012345678901";
    EXPECT_EQ(PROFILING_FAILED, parser.MsprofFreqCheckValid(cmdInfo, ARGS_EXPORT_ITERATION_ID));

    cmdInfo.args[ARGS_SYS_LOW_POWER_FREQ] = "0";
    EXPECT_EQ(PROFILING_FAILED, parser.MsprofFreqCheckValid(cmdInfo, ARGS_SYS_LOW_POWER_FREQ));
    cmdInfo.args[ARGS_SYS_LOW_POWER_FREQ] = "1";
    EXPECT_EQ(PROFILING_SUCCESS, parser.MsprofFreqCheckValid(cmdInfo, ARGS_SYS_LOW_POWER_FREQ));
    cmdInfo.args[ARGS_SYS_LOW_POWER_FREQ] = "100";
    EXPECT_EQ(PROFILING_SUCCESS, parser.MsprofFreqCheckValid(cmdInfo, ARGS_SYS_LOW_POWER_FREQ));
    cmdInfo.args[ARGS_SYS_LOW_POWER_FREQ] = "101";
    EXPECT_EQ(PROFILING_FAILED, parser.MsprofFreqCheckValid(cmdInfo, ARGS_SYS_LOW_POWER_FREQ));
}

TEST_F(INPUT_PARSER_OPEN_UTEST, CheckDynProfValid)
{
    struct MsprofCmdInfo cmdInfo = { {nullptr} };
    cmdInfo.args[ARGS_DYNAMIC_PROF] = "on";

    MOCKER_CPP(&DynProfCliMgr::SetKeyPid)
        .stubs()
        .will(ignoreReturnValue());
    MOCKER_CPP(&DynProfCliMgr::EnableDynProfCli)
        .stubs()
        .will(ignoreReturnValue());

    InputParser parser = InputParser();
    parser.params_->app = "";
    parser.params_->dynamic = "";
    parser.params_->pid = "123";
    EXPECT_EQ(MSPROF_DAEMON_ERROR, parser.CheckDynProfValid(cmdInfo));

    parser.params_->app = "";
    parser.params_->dynamic = "";
    parser.params_->pid = "";
    EXPECT_EQ(MSPROF_DAEMON_OK, parser.CheckDynProfValid(cmdInfo));

    parser.params_->app = "";
    parser.params_->dynamic = "on";
    parser.params_->pid = "";
    EXPECT_EQ(MSPROF_DAEMON_ERROR, parser.CheckDynProfValid(cmdInfo));

    parser.params_->app = "app";
    parser.params_->dynamic = "on";
    parser.params_->pid = "123";
    EXPECT_EQ(MSPROF_DAEMON_ERROR, parser.CheckDynProfValid(cmdInfo));

    parser.params_->app = "";
    parser.params_->dynamic = "on";
    parser.params_->pid = "123";
    EXPECT_EQ(MSPROF_DAEMON_OK, parser.CheckDynProfValid(cmdInfo));

    cmdInfo.args[ARGS_CPU_PROFILING] = "on";
    EXPECT_EQ(MSPROF_DAEMON_ERROR, parser.CheckDynProfValid(cmdInfo));
    cmdInfo.args[ARGS_SYS_PERIOD] = "10";
    EXPECT_EQ(MSPROF_DAEMON_ERROR, parser.CheckDynProfValid(cmdInfo));
    cmdInfo.args[ARGS_SYS_DEVICES] = "on";
    EXPECT_EQ(MSPROF_DAEMON_ERROR, parser.CheckDynProfValid(cmdInfo));
}

TEST_F(INPUT_PARSER_OPEN_UTEST, PreCheckPlatform_Miniv3) {
    InputParser parser = InputParser();
    struct MsprofCmdInfo cmdInfo = { {nullptr} };
    const char * argv[] = {"instr-profiling"};
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::MINI_V3_TYPE));
    MOCKER(mmGetOptInd)
        .stubs()
        .will(returnValue(1));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(true));
    EXPECT_EQ(PROFILING_FAILED, parser.PreCheckPlatform(ARGS_INSTR_PROFILING, argv));
    EXPECT_EQ(PROFILING_FAILED, parser.PreCheckPlatform(ARGS_INSTR_PROFILING_FREQ, argv));
}

TEST_F(INPUT_PARSER_OPEN_UTEST, PreCheckSwitch310P) {
    InputParser parser = InputParser();
    int32_t argc = 4;
    const char* argv[argc];
    argv[0] = "msprof";
    argv[1] = "--dynamic=on";
    argv[2] = "--output=./";
    argv[3] = "./main -m ./resnet50.om";

    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::DC_TYPE));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    MOCKER(mmGetOptInd).stubs().will(returnValue(1));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide)
        .stubs()
        .will(returnValue(false));
    MOCKER(mmGetOptLong)
        .stubs()
        .will(returnValue(MSPROF_DAEMON_ERROR));

    EXPECT_EQ(PROFILING_SUCCESS, parser.PreCheckPlatform(ARGS_DYNAMIC_PROF, (const char**)argv));
    EXPECT_EQ(PROFILING_SUCCESS, parser.PreCheckPlatform(ARGS_DYNAMIC_PROF_PID, (const char**)argv));
    EXPECT_EQ(PROFILING_SUCCESS, parser.PreCheckPlatform(ARGS_DELAY_PROF, (const char**)argv));
    EXPECT_EQ(PROFILING_SUCCESS, parser.PreCheckPlatform(ARGS_DURATION_PROF, (const char**)argv));

    EXPECT_NE(nullptr, parser.MsprofGetOpts(3, (const char**)argv));

    MOCKER_CPP(&InputParser::CheckDynProfValid)
        .stubs()
        .will(returnValue(MSPROF_DAEMON_ERROR));
    EXPECT_EQ(nullptr, parser.MsprofGetOpts(3, (const char**)argv));
}

/*
 * 函数原型	MsprofArgsType, LONG_OPTIONS[]
 * 函数功能	检测参数配置是否发生错位
 * 注意事项 谨慎修改，确保63位是invalid，并且63之前参数填充满，保证63的前后参数与input_parser.h顺序一致
 */
TEST_F(INPUT_PARSER_OPEN_UTEST, PreCheckParamOffset) {
    EXPECT_EQ(62, ARGS_SYS_LOW_POWER_FREQ);
    EXPECT_EQ(64, ARGS_EXPORT_ITERATION_ID);
    EXPECT_EQ(65, ARGS_EXPORT_MODEL_ID);
    EXPECT_EQ("sys-lp-freq", LONG_OPTIONS[ARGS_SYS_LOW_POWER_FREQ].name); // 62
    EXPECT_EQ("invalid", LONG_OPTIONS[ARGS_INVALID].name); // 63
    EXPECT_EQ("iteration-id", LONG_OPTIONS[ARGS_EXPORT_ITERATION_ID].name); // 64
    EXPECT_EQ("model-id", LONG_OPTIONS[ARGS_EXPORT_MODEL_ID].name); // 65
}