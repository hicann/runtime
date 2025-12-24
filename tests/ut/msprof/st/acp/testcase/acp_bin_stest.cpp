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
#include "error_code.h"
#include "config/config_manager.h"
#include "acp_pipe_transfer.h"
#include "platform/platform.h"
#include "acp_command.h"

using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Platform;
using namespace Collector::Dvvp::Acp;

class ACP_BIN_STEST : public testing::Test {
protected:
    Argparser acpCommand = AcpCommandBuild("acp");
    virtual void SetUp()
    {}
    virtual void TearDown()
    {}
};

extern int LltAcpMain(int argc, const char *argv[], const char **envp);
extern int32_t PreCheckPlatform();

TEST_F(ACP_BIN_STEST, AcpPipeReadWriteTest)
{
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params = 
        std::make_shared<analysis::dvvp::message::ProfileParams>();
    params->ai_core_metrics = "Memory";
    params->result_dir = "./aaa/bbb/ccc/ddd/eee";
    int32_t fd0;
    Collector::Dvvp::Acp::AcpPipeWrite(params, fd0);
    setenv("ACP_PIPE_FD", std::to_string(fd0).c_str(), 1);
    auto  paramsRead = Collector::Dvvp::Acp::AcpPipeRead();
    EXPECT_EQ("Memory", paramsRead->ai_core_metrics);
    EXPECT_EQ("./aaa/bbb/ccc/ddd/eee", paramsRead->result_dir);
}

void EXPECT_TestAcp(std::vector<std::string> args, const int expectedRet, std::vector<std::string> expectedList)
{
    std::stringstream output;
    std::streambuf* oldCoutBuffer = std::cout.rdbuf();
    std::cout.rdbuf(output.rdbuf());
    int argc = args.size();
    std::vector<const char*> argv;
    for (const auto& str : args) {
        argv.push_back(str.c_str());
    }
    const char* envp[1] = {nullptr};
    EXPECT_EQ(expectedRet, LltAcpMain(argc, (const char**)argv.data(), envp));
    std::cout.rdbuf(oldCoutBuffer);
    for (auto expectedPrint: expectedList) {
        EXPECT_NE(output.str().find(expectedPrint), std::string::npos)
            <<"Screen print:" << std::endl << output.str() << std::endl << "Missing expected: " + expectedPrint;
    }
}

TEST_F(ACP_BIN_STEST, AcpBin) 
{
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::CHIP_CLOUD_V3));
    EXPECT_TestAcp({"acp", "--help"}, PROFILING_FAILED, {"Usage:"});
    EXPECT_TestAcp({"acp", "-h"}, PROFILING_FAILED, {"Usage:"});
    EXPECT_TestAcp(
        {"acp", "profile", "-h"}, PROFILING_FAILED, {"Usage:", "./acp profile [--options]", "--aic-metrics", "--output"}
    );
    EXPECT_TestAcp(
        {"acp", "profile", "--help"}, 
        PROFILING_FAILED, 
        {"Usage:", "./acp profile [--options]", "--aic-metrics", "--output"}
    );
    EXPECT_TestAcp(
        {"acp", "profile", "--aic-metrics"},
        PROFILING_FAILED, 
        {"[ERROR] Argument --aic-metrics: expected one argument"}
    );
    EXPECT_TestAcp(
        {"acp", "profile", "--aic-metrics="},
        PROFILING_FAILED, 
        {std::string("[ERROR] Argument --aic-metrics input is empty.")}
    );
    EXPECT_TestAcp(
        {"acp", "profile", "--output"},
        PROFILING_FAILED, 
        {"[ERROR] Argument --output: expected one argument"}
    );
    EXPECT_TestAcp(
        {"acp", "profile", "--output="},
        PROFILING_FAILED, 
        {"[ERROR] Argument --output: expected one argument"}
    );
    EXPECT_TestAcp(
        {"acp", "profile", "--aic-metrics=aaa"}, 
        PROFILING_FAILED, 
        {"Argument --aic-metrics aaa is invalid in this platform, please check input range in help message."}
    );
    EXPECT_TestAcp(
        {"acp", "subcommandx"},
        PROFILING_FAILED, 
        {"[ERROR] acp: unrecognized subcommand subcommandx", "Usage:"}
    );

    MOCKER_CPP(&Platform::CheckIfPlatformExist, bool (Platform::*)(void) const)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    EXPECT_TestAcp(
        {"acp", "profile", "--aic-metrics=PipeUtilization", "--output=./acp_bin_stest", "test.sh"}, 
        PROFILING_FAILED,
        {"Start profiling...."}
    );
    EXPECT_TestAcp(
        {"acp", "profile", "--aic-metrics=PipeUtilization", "--output=./acp_bin_stest", "test.sh"}, 
        PROFILING_FAILED,
        {"[ERROR] Acp is not supported on the current platform type."}
    );
    EXPECT_TestAcp(
        {"acp", "profile", "--help"}, 
        PROFILING_FAILED,
        {"[Warning] Acp is not supported on the current platform type."}
    );
    EXPECT_TestAcp(
        {"acp", "profile", "--aic-metrics=PipeUtilization,Custom:0xab"}, 
        PROFILING_FAILED,
        {"[ERROR] Argument --aic-metrics PipeUtilization,Custom:0xab is invalid because of invalid value before custom events. Please noted that custom function can not be used with metrics groups."}
    );
    EXPECT_TestAcp(
        {"acp", "profile", "--aic-metrics=Custom:0xab,PipeUtilization"}, 
        PROFILING_FAILED,
        {"[ERROR] Argument --aic-metrics pipeutilization (lower) is invalid, hexadecimal or decimal parameters are allowed in custom mode."}
    );
    rmdir("acp_bin_stest");
}