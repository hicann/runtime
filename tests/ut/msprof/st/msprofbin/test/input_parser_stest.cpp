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
#include "application.h"
#include "config/config_manager.h"
#include "dyn_prof_client.h"
#include "platform/platform.h"

using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Msprof;
using namespace Analysis::Dvvp::Common::Config;
using namespace Collector::Dvvp::DynProf;
using namespace Analysis::Dvvp::Common::Platform;

constexpr int MSPROF_DAEMON_ERROR       = -1;
constexpr int MSPROF_DAEMON_OK          = 0;

class INPUT_PARSER_STEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(INPUT_PARSER_STEST, MsprofHostCheckValid) {
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
    parser.params_->result_dir = "./input_parser_stest";
    EXPECT_EQ(PROFILING_FAILED, parser.MsprofHostCheckValid(cmdInfo, ARGS_HOST_SYS));

    EXPECT_EQ(PROFILING_FAILED, parser.MsprofHostCheckValid(cmdInfo, ARGS_HOST_SYS_PID));
    cmdInfo.args[ARGS_HOST_SYS_PID] = "121312312123";
    EXPECT_EQ(PROFILING_FAILED, parser.MsprofHostCheckValid(cmdInfo, ARGS_HOST_SYS_PID));
}


TEST_F(INPUT_PARSER_STEST, CheckHostSysCmdOutIsExist) {
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

TEST_F(INPUT_PARSER_STEST, CheckOutputValid) {
    GlobalMockObject::verify();
    InputParser parser = InputParser();
    struct MsprofCmdInfo cmdInfo = { {nullptr} };

    EXPECT_EQ(PROFILING_FAILED, parser.CheckOutputValid(cmdInfo));
    cmdInfo.args[ARGS_OUTPUT] = "";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckOutputValid(cmdInfo));
    cmdInfo.args[ARGS_OUTPUT] = "./";
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckOutputValid(cmdInfo));
}

TEST_F(INPUT_PARSER_STEST, CheckStorageLimitValid) {
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

TEST_F(INPUT_PARSER_STEST, CheckStorageLimit) {
    using namespace analysis::dvvp::common::validation;
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);

    params->storageLimit = "MB";
    bool ret = ParamValidation::instance()->CheckStorageLimit(params);
    EXPECT_EQ(false, ret);

    params->storageLimit = "10MB0";
    ret = ParamValidation::instance()->CheckStorageLimit(params);
    EXPECT_EQ(false, ret);

    params->storageLimit = "A12345MB";
    ret = ParamValidation::instance()->CheckStorageLimit(params);
    EXPECT_EQ(false, ret);

    params->storageLimit = "123456789100MB";
    ret = ParamValidation::instance()->CheckStorageLimit(params);
    EXPECT_EQ(false, ret);

    params->storageLimit = "100MB";
    ret = ParamValidation::instance()->CheckStorageLimit(params);
    EXPECT_EQ(false, ret);

    params->storageLimit = "8294967296MB";
    ret = ParamValidation::instance()->CheckStorageLimit(params);
    EXPECT_EQ(false, ret);

    params->storageLimit = "4294967295MB";
    ret = ParamValidation::instance()->CheckStorageLimit(params);
    EXPECT_EQ(true, ret);

    params->storageLimit = "1000MB";
    ret = ParamValidation::instance()->CheckStorageLimit(params);
    EXPECT_EQ(true, ret);

    params->storageLimit = "";
    ret = ParamValidation::instance()->CheckStorageLimit(params);
    EXPECT_EQ(true, ret);
}

TEST_F(INPUT_PARSER_STEST, GetAppParam) {
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

TEST_F(INPUT_PARSER_STEST, CheckAppValid) {
    GlobalMockObject::verify();
    InputParser parser = InputParser();
    struct MsprofCmdInfo cmdInfo = { {nullptr} };

    std::remove("./INPUT_PARSER_STEST-CheckAppValid");
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
    cmdInfo.args[ARGS_APPLICATION] = "./INPUT_PARSER_STEST-CheckAppValid a";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckAppValid(cmdInfo));
    std::ofstream file("INPUT_PARSER_STEST-CheckAppValid");
    file << "command not found" << std::endl;
    file.close();
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckAppValid(cmdInfo));
    MOCKER_CPP(&analysis::dvvp::common::utils::Utils::SplitPath)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(PROFILING_FAILED, parser.CheckAppValid(cmdInfo));
    remove(".INPUT_PARSER_STEST-CheckAppValid");
    cmdInfo.args[ARGS_APPLICATION] = "./libs/xaclfk/xaclfk -m /home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_L1_fp16_32768_1_32768_1_32768_1_TF_32768_b41d37.om -o /home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/out_ID2940_WideDeep_L1_fp16_32768_1_32768_1_32768_1_TF_32768_b41d37 -i /home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_00_ad_advertiser_input_0,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_01_ad_id_input_1,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_02_ad_views_log_01scaled_input_2,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_03_doc_ad_category_id_input_3,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_04_doc_ad_days_since_published_log_01scaled_input_4,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_05_doc_ad_entity_id_input_5,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_06_doc_ad_publisher_id_input_6,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_07_doc_ad_source_id_input_7,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_08_doc_ad_topic_id_input_8,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_09_doc_event_category_id_input_9,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_10_doc_event_days_since_published_log_01scaled_input_10,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_11_doc_event_doc_ad_sim_categories_log_01scaled_input_11,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_12_doc_event_doc_ad_sim_entities_log_01scaled_input_12,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_13_doc_event_doc_ad_sim_topics_log_01scaled_input_13,xrunfk//home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_14_doc_event_entity_id_input_14,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_15_doc_event_hour_log_01scaled_input_15,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_16_doc_event_id_input_16,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_17_doc_event_publisher_id_input_17,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_18_doc_event_source_id_input_18,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_19_doc_event_topic_id_input_19,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_20_doc_id_input_20,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_21_doc_views_log_01scaled_input_21,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_22_event_country_input_22,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_23_event_country_state_input_23,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_24_event_geo_location_input_24,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_25_event_hour_input_25,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_26_event_platform_input_26,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_27_event_weekend_input_27,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_28_pop_ad_id_conf_input_28,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_29_pop_ad_id_log_01scaled_input_29,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_30_pop_advertiser_id_conf_input_30,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_31_pop_advertiser_id_log_01scaled_input_31,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_32_pop_campain_id_conf_multipl_log_01scaled_input_32,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_33_pop_campain_id_log_01scaled_input_33,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_34_pop_category_id_conf_input_34,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_35_pop_category_id_log_01scaled_input_35,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_36_pop_document_id_conf_input_36,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_37_pop_document_id_log_01scaled_input_37,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_38_pop_entity_id_conf_input_38,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_39_pop_entity_id_log_01scaled_input_39,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_40_pop_publisher_id_conf_input_40,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_41_pop_publisher_id_log_01scaled_input_41,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_42_pop_source_id_conf_input_42,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_43_pop_source_id_log_01scaled_input_43,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_44_pop_topic_id_conf_input_44,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_45_pop_topic_id_log_01scaled_input_45,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_46_traffic_source_input_46,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_47_user_doc_ad_sim_categories_conf_input_47,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_48_user_doc_ad_sim_categories_log_01scaled_input_48,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_49_user_doc_ad_sim_entities_log_01scaled_input_49,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_50_user_doc_ad_sim_topics_conf_input_50,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_51_user_doc_ad_sim_topics_log_01scaled_input_51,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_52_user_has_already_viewed_doc_input_52,/home/swx1026645/xrunfk/testcase/model_tf/ID2940_WideDeep/ID2940_WideDeep_53_user_views_log_01scaled_input_53 -n 0 -l 800";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckAppValid(cmdInfo));
}

TEST_F(INPUT_PARSER_STEST, CheckEnvironmentValid) {
    GlobalMockObject::verify();
    InputParser parser = InputParser();
    struct MsprofCmdInfo cmdInfo = { {nullptr} };

    EXPECT_EQ(PROFILING_FAILED, parser.CheckEnvironmentValid(cmdInfo));
    cmdInfo.args[ARGS_ENVIRONMENT] = "";

    EXPECT_EQ(PROFILING_FAILED, parser.CheckEnvironmentValid(cmdInfo));
    cmdInfo.args[ARGS_ENVIRONMENT] = "aa";
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckEnvironmentValid(cmdInfo));
}

TEST_F(INPUT_PARSER_STEST, CheckPythonPathValid) {
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
    
    MOCKER(mmAccess2).stubs().will(returnValue(-1)).then(returnValue(0));
    cmdInfo.args[ARGS_PYTHON_PATH] = "TestPython";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckPythonPathValid(cmdInfo));
    Utils::CreateDir("TestPython");
    EXPECT_EQ(PROFILING_FAILED, parser.CheckPythonPathValid(cmdInfo));
    Utils::RemoveDir("TestPython");
    cmdInfo.args[ARGS_PYTHON_PATH] = "testpython";
    std::ofstream ftest("testpython");
    ftest << "test";
    ftest.close();
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckPythonPathValid(cmdInfo));
    remove("testpython");
}

TEST_F(INPUT_PARSER_STEST, CheckDynProfValid)
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

TEST_F(INPUT_PARSER_STEST, ParamsCheck) {
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

TEST_F(INPUT_PARSER_STEST, ASCEND_WORK_PATH)
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

TEST_F(INPUT_PARSER_STEST, DefaultOutput)
{
    char *argv[] = {"msprof", "--aicpu=on", "python3", "test.py", nullptr};
    optind = 1;
    InputParser parser = InputParser();
    auto params = parser.MsprofGetOpts(4, (const char**)argv);
    std::string result = analysis::dvvp::common::utils::Utils::CanonicalizePath("./");
    EXPECT_EQ(true, params->result_dir == result);
}

TEST_F(INPUT_PARSER_STEST, SetHostSysParam) {
    GlobalMockObject::verify();
    InputParser parser = InputParser();
    parser.SetHostSysParam("123");
    parser.SetHostSysParam("osrt");
    EXPECT_EQ(parser.params_->host_osrt_profiling, "on");
}

TEST_F(INPUT_PARSER_STEST, CheckBaseOrder) {
    EXPECT_EQ(ARGS_INSTR_PROFILING, LONG_OPTIONS[ARGS_INSTR_PROFILING].val);
    EXPECT_EQ(ARGS_INSTR_PROFILING_FREQ, LONG_OPTIONS[ARGS_INSTR_PROFILING_FREQ].val);
}

TEST_F(INPUT_PARSER_STEST, CheckBaseInfo) {
    GlobalMockObject::verify();
    InputParser parser = InputParser();
    struct MsprofCmdInfo cmdInfo = { {nullptr} };
    auto configManger = Analysis::Dvvp::Common::Config::ConfigManager::instance();

    EXPECT_EQ(PROFILING_FAILED, parser.CheckSampleModeValid(cmdInfo, ARGS_AIV_MODE));
    EXPECT_EQ(PROFILING_FAILED, parser.CheckSampleModeValid(cmdInfo, ARGS_AIC_MODE));
    cmdInfo.args[ARGS_AIV_MODE] = "aa";
    cmdInfo.args[ARGS_AIC_MODE] = "aa";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckSampleModeValid(cmdInfo, ARGS_AIV_MODE));
    EXPECT_EQ(PROFILING_FAILED, parser.CheckSampleModeValid(cmdInfo, ARGS_AIC_MODE));
    cmdInfo.args[ARGS_AIV_MODE] = "sample-based";
    cmdInfo.args[ARGS_AIC_MODE] = "sample-based";
    configManger->configMap_["type"] = "2";
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
    configManger->configMap_["type"] = "2";
    configManger->Init();

    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::MDC_TYPE));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    cmdInfo.args[ARGS_AIV_METRICS] = "L2Cache";
    cmdInfo.args[ARGS_AIC_METRICS] = "L2Cache";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckAiCoreMetricsValid(cmdInfo, ARGS_AIC_METRICS));
    EXPECT_EQ(PROFILING_FAILED, parser.CheckAiCoreMetricsValid(cmdInfo, ARGS_AIV_METRICS));

    GlobalMockObject::verify();
    cmdInfo.args[ARGS_AIC_METRICS] = "PipelineExecuteUtilization";
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::MINI_V3_TYPE));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckAiCoreMetricsValid(cmdInfo, ARGS_AIC_METRICS));

    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::CHIP_MDC_MINI_V3));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    EXPECT_EQ(PROFILING_SUCCESS, parser.CheckAiCoreMetricsValid(cmdInfo, ARGS_AIC_METRICS));
    configManger->Uninit();

    // check summary format
    EXPECT_EQ(PROFILING_FAILED, parser.CheckExportSummaryFormat(cmdInfo));
    cmdInfo.args[ARGS_SUMMARY_FORMAT] = "aaa";
    EXPECT_EQ(PROFILING_FAILED, parser.CheckExportSummaryFormat(cmdInfo));
    cmdInfo.args[ARGS_SUMMARY_FORMAT] = "csv";
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
    cmdInfo.args[ARGS_HCCL] = "1";
    cmdInfo.args[ARGS_INSTR_PROFILING] = "1";
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
    cmdInfo.args[ARGS_PARSE] = "1";
    cmdInfo.args[ARGS_QUERY] = "1";
    cmdInfo.args[ARGS_EXPORT] = "1";
    cmdInfo.args[ARGS_ANALYZE] = "1";
    cmdInfo.args[ARGS_CLEAR] = "1";
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

TEST_F(INPUT_PARSER_STEST, MsprofFreqCheckValid) {
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

}

TEST_F(INPUT_PARSER_STEST, GetAppPath) {
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

TEST_F(INPUT_PARSER_STEST, GetCmdString) {
    GlobalMockObject::verify();
	std::string paramsCmd;
    EXPECT_EQ("", analysis::dvvp::app::Application::GetCmdString(paramsCmd));

    paramsCmd = "bash";
	EXPECT_EQ(paramsCmd, analysis::dvvp::app::Application::GetCmdString(paramsCmd));
}

TEST_F(INPUT_PARSER_STEST, MsprofCmdCheckValid) {
    InputParser parser = InputParser();
    struct MsprofCmdInfo cmdInfo = { {nullptr} };
    cmdInfo.args[ARGS_DYNAMIC_PROF] = "on";
    cmdInfo.args[ARGS_DYNAMIC_PROF_PID] = "123";
    MOCKER(mmGetOptInd)
        .stubs()
        .will(returnValue(1));
    EXPECT_EQ(MSPROF_DAEMON_OK, parser.MsprofCmdCheckValid(cmdInfo, ARGS_DYNAMIC_PROF));
    EXPECT_EQ(MSPROF_DAEMON_OK, parser.MsprofCmdCheckValid(cmdInfo, ARGS_DYNAMIC_PROF_PID));
}