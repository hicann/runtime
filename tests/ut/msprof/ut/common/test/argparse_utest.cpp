/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <string>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "errno/error_code.h"
#include "platform/platform.h"
#include "config/config_manager.h"
#define private public
#include "argparser.h"

using namespace analysis::dvvp::common::argparse;
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Platform;
using namespace Analysis::Dvvp::Common::Config;

class COMMON_ARGPARSE_UTEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

TEST_F(COMMON_ARGPARSE_UTEST, add_option_test) {
    MOCKER_CPP(&Platform::GetPlatformType).stubs().will(returnValue(CHIP_CLOUD_V2));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    Argparser cmd = Argparser("test cmd")
    .AddOption("help", "Shwo this help message", "");
    EXPECT_EQ(1, cmd.options_.size());

    cmd.AddOption("option1", "option has value range", "A", {"A", "B", "C"});
    EXPECT_EQ(2, cmd.options_.size());

    cmd.AddOption("option2", "option has check valid function", "",
                [](const std::string& value) {return ARGPARSE_OK;});
    EXPECT_EQ(3, cmd.options_.size());
}

TEST_F(COMMON_ARGPARSE_UTEST, add_subcommond_test) {
    Argparser cmd = Argparser("test cmd");
    Argparser subcmd1 = Argparser("subcmd1");
    cmd.AddSubCommand("subcmd1", subcmd1);
    EXPECT_EQ(1, cmd.subcommands_.size());
    Argparser subcmd2 = Argparser("subcmd2");
    cmd.AddSubCommand("subcmd2", subcmd2);
    EXPECT_EQ(2, cmd.subcommands_.size());
    Argparser subcmd3 = Argparser("subcmd3");
    cmd.AddSubCommand("subcmd2", subcmd3);
    EXPECT_EQ(2, cmd.subcommands_.size());
}

Argparser EXPECT_TestCmd(std::function<Argparser(void)> createCmd, 
            std::vector<std::string> args, 
            const bool expectedRet, 
            std::vector<std::string> expectedList)
{
    std::stringstream output;
    std::streambuf* oldCoutBuffer = std::cout.rdbuf();
    std::cout.rdbuf(output.rdbuf());
    int argc = args.size();
    std::vector<const char*> argv;
    for (const auto& str : args) {
        argv.push_back(str.c_str());
    }

    auto cmd = createCmd();
    EXPECT_EQ(expectedRet, cmd.Parse(argc, (const char**)argv.data()).ParsedSuccess());

    std::cout.rdbuf(oldCoutBuffer);
    for (auto expectedPrint: expectedList) {
        EXPECT_NE(output.str().find(expectedPrint), std::string::npos) 
            <<"Screen print:" << std::endl << output.str() << std::endl << "Missing expected: " + expectedPrint;
    }
    return cmd;
}

TEST_F(COMMON_ARGPARSE_UTEST, check_option_parse) {
    auto createCmd = []() {
        Argparser cmd = Argparser("test cmd")
            .AddOption("option1", "option help msg", "A");
        return cmd;
    };
    EXPECT_TestCmd(createCmd, {"cmd"}, false, {"--option1", "<Optional> option help msg"});
    EXPECT_TestCmd(createCmd, {"cmd", "--option1=A"}, true, {});
    EXPECT_TestCmd(createCmd, {"cmd", "--option1"}, false, {"Argument --option1: expected one argument"});
    EXPECT_TestCmd(createCmd, {"cmd", "--option1="}, true, {});
    auto cmd1 = EXPECT_TestCmd(createCmd, {"cmd", "--option1=B"}, true, {});
    EXPECT_EQ("B", cmd1.GetOption("option1"));
}

TEST_F(COMMON_ARGPARSE_UTEST, check_option_range_test) {
    auto createCmd = []() {
        Argparser cmd = Argparser("test cmd")
            .AddOption("option", "option has value range", "A", { "A", "B", "C" });
        return cmd;
    };
    EXPECT_TestCmd(createCmd, {"cmd"}, false, {"--option", "<Optional> option has value range"});
    EXPECT_TestCmd(createCmd, {"cmd", "--option=A"}, true, {});
    EXPECT_TestCmd(createCmd, {"cmd", "--option=D"}, false, {"Argument --option: invalid option value D. Please input in the range of [A|B|C]"});
}

TEST_F(COMMON_ARGPARSE_UTEST, check_option_valid_func_test) {
    auto createCmd = []() {
        Argparser cmd = Argparser("test cmd")
            .AddOption("option", "option has check valid function", "", [](const std::string &value) {
                std::cout << "check option2 valid: " << value << std::endl;
                return ARGPARSE_OK;
            });
        return cmd;
    };
    EXPECT_TestCmd(createCmd, {"cmd", "--option=A"}, true, {"check option2 valid: A"});
}

TEST_F(COMMON_ARGPARSE_UTEST, check_subcommand_parse) {
    auto createCmd = []() {
        Argparser subcmd1 = Argparser("subcmd1 description")
            .AddOption("subcmd1-option1", "subcmd1 option1 help msg", "")
            .AddOption("subcmd1-option2", "subcmd1 option2 help msg", "")
            .BindExecute([](Argparser &cmd) {
                return 111;
            });
        Argparser subcmd2 = Argparser("subcmd2 description")
            .AddOption("subcmd2-option1", "subcmd2 option2 help msg", "");
        Argparser cmd = Argparser("test cmd")
            .AddOption("option1", "option help msg", "")
            .AddSubCommand("subcmd1", subcmd1)
            .AddSubCommand("subcmd2", subcmd2);
        return cmd;
    };
    EXPECT_TestCmd(createCmd, {"cmd"}, false, {
        "Subcommands:",
        "subcmd1                           subcmd1 description",
        "subcmd2                           subcmd2 description",
        "Options:",
        "--option1                         <Optional> option help msg"
    });
    EXPECT_TestCmd(createCmd, {"cmd", "subcmd1"}, false, {
        "Options:",
        "--subcmd1-option1                 <Optional> subcmd1 option1 help msg",
        "--subcmd1-option2                 <Optional> subcmd1 option2 help msg"
    });
    EXPECT_TestCmd(createCmd, {"cmd", "subcmd2"}, false, {
        "Options:",
        "--subcmd2-option1                 <Optional> subcmd2 option2 help msg",
    });
    EXPECT_TestCmd(createCmd, {"cmd", "subcmd3"}, false, {"unrecognized subcommand subcmd3", "Usage:"});
    auto cmd1 = EXPECT_TestCmd(createCmd, {"cmd", "subcmd1", "--subcmd1-option1=aaa"}, true, {});
    EXPECT_EQ(111, cmd1.Execute());
    auto cmd2 = EXPECT_TestCmd(createCmd, {"cmd", "subcmd2", "--subcmd2-option1=aaa"}, true, {});
    EXPECT_EQ(PROFILING_SUCCESS, cmd2.Execute());
}

TEST_F(COMMON_ARGPARSE_UTEST, check_rear_app_parse) {
    auto createCmd = []() {
        Argparser subcmd1 = Argparser("subcmd1 description")
            .AddOption("subcmd1-option1", "subcmd1 option1 help msg", "")
            .AddRearAppSupport();

        Argparser cmd = Argparser("test cmd")
            .AddOption("option1", "option help msg", "")
            .AddSubCommand("subcmd1", subcmd1);
        return cmd;
    };
    EXPECT_TestCmd(createCmd, {"cmd", "subcmd3"}, false, {"unrecognized subcommand subcmd3", "Usage:"});
    EXPECT_TestCmd(createCmd, {"cmd", "subcmd1", "--subcmd1-option1"}, false, {"[ERROR] Argument --subcmd1-option1: expected one argument"});
    EXPECT_TestCmd(createCmd, {"cmd", "subcmd1", "--subcmd1-option1=2"}, false, {"[ERROR] Missing rear app args.", "Usage:"});
    auto cmd = EXPECT_TestCmd(createCmd, {"cmd", "subcmd1", "--subcmd1-option1=2", "./user_app.sh", "--app-opt=1"}, true, {});
    EXPECT_EQ(true, cmd.appArgs.empty());
    auto subcmd = cmd.GetSubCommand(cmd.enabledSubCmd);
    EXPECT_EQ("./user_app.sh", subcmd.appArgs[0]);
    EXPECT_EQ("--app-opt=1", subcmd.appArgs[1]);
}
#undef private