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
#include <fstream>
#include "errno/error_code.h"
#include "running_mode.h"
#include "config/config_manager.h"
#include "platform/platform.h"
#include "utils/utils.h"

using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::common::utils;

class MSPROF_BIN_UTEST : public testing::Test {
protected:
  virtual void SetUp() {}
  virtual void TearDown() {}
};

extern int LltMain(int argc, const char **argv, const char **envp);
extern int WlltMain(int argc, const char **argv, const char **envp);
extern void SetEnvList(const char* &envp, std::vector<std::string> &envpList);
extern std::atomic<uint32_t> g_exitType;

void createMsprofpy()
{
    std::ofstream test_file2("/tmp/profiler_tool/analysis/msprof/msprof.py");
    test_file2 << "import sys" << std::endl;
    test_file2 << "print(sys.argv[1:])" << std::endl;
    test_file2 << "if 'summary' in sys.argv or 'analyze' in sys.argv:" << std::endl;
    test_file2 << "    assert '--clear' in sys.argv" << std::endl;
    test_file2.close();
}

TEST_F(MSPROF_BIN_UTEST, LltMain) {
    GlobalMockObject::verify();
    optind = 1;
    char* argv[15];
    argv[0] = "--help";
    argv[1] = "--test";
    argv[2] = "--sys-interconnection-profiling";
    char* envp[2];
    envp[0] = "test=a";
    envp[1] = "a=b";

    MOCKER(&SetEnvList)
        .stubs();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(15))
        .then(returnValue(5));
    Platform::instance()->Uninit();
    EXPECT_EQ(PROFILING_FAILED, LltMain(2, (const char**)argv, (const char**)envp));
    Platform::instance()->Uninit();
    EXPECT_EQ(PROFILING_FAILED, LltMain(1, (const char**)argv, (const char**)envp));
    EXPECT_EQ(PROFILING_FAILED, LltMain(2, (const char**)argv, (const char**)envp));

    std::ofstream test_file("st-prof_bin_test");
    test_file << "echo test" << std::endl;
    test_file.close();
    argv[2] = "--app=./st-prof_bin_test";
    argv[3] = "--task-time=on";
    EXPECT_EQ(PROFILING_FAILED, LltMain(4, (const char**)argv, (const char**)envp));
    std::remove("st-prof_bin_test");
    argv[4] = "--sys-devices=0";
    argv[5] = "--output=./msprof_bin_stest";
    argv[6] = "--sys-period=1";
    argv[7] = "--sys-pid-profiling=on";
    EXPECT_EQ(PROFILING_SUCCESS, LltMain(8, (const char**)argv, (const char**)envp));
    rmdir("msprof_bin_stest");

    // clear mode
    std::string dirName2 = "/tmp";
    Utils::CreateDir(dirName2 + "/profiler_tool");
    Utils::CreateDir(dirName2 + "/profiler_tool/analysis");
    Utils::CreateDir(dirName2 + "/profiler_tool/analysis/msprof");
    createMsprofpy();
    std::string tmp = "/tmp/profiler_tool/analysis";
    MOCKER(&Utils::GetSelfPath).stubs().will(returnValue(tmp));
    MOCKER(&Utils::GetPid).stubs().will(returnValue(1));
    std::cout << "Create fake python script" << std::endl;

    argv[8] = "--export=on";
    argv[9] = "--clear=on";
    argv[10] = "--output=./msprof_clear_mode_stest";
    EXPECT_EQ(PROFILING_SUCCESS, LltMain(11, (const char**)argv, (const char**)envp));
    rmdir("msprof_clear_mode_stest");
    argv[11] = "--analyze=on";
    argv[12] = "--clear=on";
    argv[13] = "--rule=communication";
    argv[14] = "--output=./msprof_clear_mode_stest";
    EXPECT_EQ(PROFILING_SUCCESS, LltMain(15, (const char**)argv, (const char**)envp));
    rmdir("msprof_clear_mode_stest");
    Utils::RemoveDir(dirName2 + "/profiler_tool");
}

TEST_F(MSPROF_BIN_UTEST, SetEnvList) {
    GlobalMockObject::verify();
    char* envp[4097];
    char str[] = "a=a";
    for (int i = 0; i < 4097; i++) {
        envp[i] = str;
    }
    envp[4096] = nullptr;
    std::vector<std::string> envpList;
    SetEnvList(*((const char**)envp), envpList);
    EXPECT_EQ(envpList.size(), 4096);
    if (envpList.size() == 4096) {
        EXPECT_EQ(envpList[0], "a=a");
    }
}

TEST_F(MSPROF_BIN_UTEST, WlltMain) {
    GlobalMockObject::verify();
    char* argv[10];
    argv[0] = "--help";
    argv[1] = "--test";
    char* envp[2];
    envp[0] = "test=a";
    envp[1] = "a=b";

    MOCKER(&SetEnvList)
        .stubs();
    EXPECT_EQ(0, WlltMain(1, (const char**)argv, (const char**)envp));
}
