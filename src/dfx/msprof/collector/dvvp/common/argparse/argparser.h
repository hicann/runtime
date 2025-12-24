/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ARGPARSER_H
#define ARGPARSER_H
#include <functional>
#include <set>
#include <iomanip>
#include <string>
#include <map>
#include <unordered_map>
#include <vector>
#include "utils/utils.h"

namespace analysis {
namespace dvvp {
namespace common {
namespace argparse {

const int32_t ARGPARSE_ERROR = -1;
const int32_t ARGPARSE_OK = 0;
const std::string LONG_PRE = "--";

struct Option {
    Option(std::string lname, std::string hp, std::string val,
        std::function<int32_t(std::string&)> checkFunc, std::vector<std::string> valRange)
        : longName(lname), help(hp), value(val), checkValidFunc(checkFunc),
          valueRange(valRange)
    {}
    std::string longName;
    std::string help;
    std::string value;
    std::function<int32_t(std::string&)> checkValidFunc;
    std::vector<std::string> valueRange;
};

class Argparser {
public:
    explicit Argparser(const std::string &description);
    ~Argparser() = default;
public:
    Argparser &SetProgramName(const std::string &name);
    Argparser &SetUsage(const std::string &usage);
    Argparser &AddOption(std::string lname, std::string help, std::string defaultValue);
    Argparser &AddOption(std::string lname, std::string help, std::string defaultValue,
                        std::function<int32_t(std::string&)> checkValidFunc);
    Argparser &AddOption(std::string lname, std::string help, std::string defaultValue,
                        std::vector<std::string> valueRange);
    Argparser &AddOption(std::string lname, std::string help, std::string defaultValue,
                        std::function<int32_t(std::string&)> checkValidFunc, std::vector<std::string> valueRange);
    Argparser &AddRearAppSupport();
    std::string GetOption(const std::string &longName);
    Argparser &AddSubCommand(std::string commandName, Argparser &subcommand);
    Argparser &GetSubCommand(std::string commandName);
    Argparser &BindPreCheck(std::function<int32_t(void)> preCheckFunc);
    Argparser &BindExecute(std::function<int32_t(Argparser&)> executeFunc);
    Argparser &Parse(int32_t argc, const CHAR *argv[]);
    bool ParsedSuccess() const;
    std::string GetDescription();
    void PrintHelp();
    int32_t Execute();
public:
    std::vector<std::string> appArgs;
    std::string enabledSubCmd;
private:
    int32_t ProcessOptLong(int32_t argc, const CHAR *argv[]);
    void ProcessAppArgs(std::vector<std::string> &tokens);
    int32_t CheckOptionValue(Option &option) const;
    bool StartWith(const std::string& str, const std::string& prefix) const;
    std::string StringJoin(std::vector<std::string> &stringList, std::string sep) const;

private:
    std::string description_;
    std::string programName_;
    std::string usage_;
    std::vector<Option> options_;
    bool appSupported_{false};
    std::unordered_map<std::string, std::size_t> longNameIndex_;
    std::unordered_map<std::string, SHARED_PTR_ALIA<Argparser>> subcommands_;
    int32_t status_{ARGPARSE_ERROR};
    std::function<int32_t(void)> preCheckFunc_{nullptr};
    std::function<int32_t(Argparser&)> executeFunc_{nullptr};
};
}
}
}
}
#endif