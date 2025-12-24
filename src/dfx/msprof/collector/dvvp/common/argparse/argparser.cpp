/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "argparser.h"
#include "cmd_log/cmd_log.h"
#include "errno/error_code.h"
#include "getopt.h"
#include "platform/platform.h"

namespace analysis {
namespace dvvp {
namespace common {
namespace argparse {
using namespace analysis::dvvp::common::cmdlog;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::Common::Platform;

Argparser::Argparser(const std::string &description) : description_(description)
{
}

Argparser &Argparser::SetProgramName(const std::string &name)
{
    programName_ = name;
    return *this;
}

Argparser &Argparser::SetUsage(const std::string &usage)
{
    usage_ = usage;
    return *this;
}

void Argparser::PrintHelp()
{
    if (!Platform::instance()->CheckIfPlatformExist()) {
        std::cout << std::endl << "[Warning] Acp is not supported on the current platform type." << std::endl;
        return;
    }
    std::cout << std::endl << "Usage:" << std::endl;
    std::cout << "      " + usage_ << std::endl << std::endl;
    if (!subcommands_.empty()) {
        std::cout << "Subcommands:" << std::endl;
        for (auto const &kv : subcommands_) {
            // 6 space command line indentation
            std::cout << std::right << std::setw(6) << "";
            // 34 space for subcommand indentation
            std::cout << std::left << std::setw(34) << kv.first;
            std::cout << kv.second->GetDescription() << std::endl << std::flush;
        }
    }
    std::cout << "Options:" << std::endl;
    for (auto opt : options_) {
        std::string ifOptional = "<Optional>";
        // 6 space for command line indentation
        std::cout << std::right << std::setw(6) << "";
        // 34 space for option indentation
        std::cout << std::left << std::setw(34) << LONG_PRE + opt.longName << ifOptional;
        std::cout << " " << opt.help << std::endl << std::flush;
    }
}

/**
 * @ingroup argparse
 * @name  AddOption
 * @brief Method. Add an option to argparser to compose a command app.
 * @param [in] lname: long name of option
 * @param [in] help: used to display help information for option
 * @param [in] defaultValue: set defalut value of option
 * @param [in] checkValidFunc: function use to check this option valid, will be called in CheckOptionValue
 * @param [in] valueRange: valid value range of this option, will be checked in CheckOptionValue
 * @return Argparser
 */
Argparser &Argparser::AddOption(std::string lname, std::string help, std::string defaultValue,
    std::function<int32_t(std::string&)> checkValidFunc, std::vector<std::string> valueRange)
{
    if (lname.empty()) {
        return *this;
    }
    size_t optIndex = options_.size();
    longNameIndex_[lname] = optIndex;
    options_.emplace_back(lname, help, defaultValue, checkValidFunc, valueRange);
    return *this;
}

/**
 * @ingroup argparse
 * @name  AddOption
 * @brief Method. Add an option to argparser to compose a command app, with checkValidFunc.
 * @param [in] lname: long name of option
 * @param [in] help: used to display help information for option
 * @param [in] defaultValue: set defalut value of option
 * @param [in] checkValidFunc: function use to check this option valid, will be called in CheckOptionValue
 * @return Argparser
 */
Argparser &Argparser::AddOption(std::string lname, std::string help, std::string defaultValue,
    std::function<int32_t(std::string&)> checkValidFunc)
{
    return AddOption(lname, help, defaultValue, checkValidFunc, {});
}

/**
 * @ingroup argparse
 * @name  AddOption
 * @brief Method. Add an option to argparser to compose a command app, with valueRange.
 * @param [in] lname: long name of option
 * @param [in] help: used to display help information for option
 * @param [in] defaultValue: set defalut value of option
 * @param [in] valueRange: valid value range of this option, will be checked in CheckOptionValue
 * @return Argparser
 */
Argparser &Argparser::AddOption(std::string lname, std::string help, std::string defaultValue,
    std::vector<std::string> valueRange)
{
    return AddOption(lname, help, defaultValue, nullptr, valueRange);
}

/**
 * @ingroup argparse
 * @name  AddOption
 * @brief Method. Add an option to argparser to compose a command app, no need option check.
 * @param [in] lname: long name of option
 * @param [in] help: used to display help information for option
 * @param [in] defaultValue: set defalut value of option
 * @return Argparser
 */
Argparser &Argparser::AddOption(std::string lname, std::string help, std::string defaultValue)
{
    return AddOption(lname, help, defaultValue, nullptr, {});
}

/**
 * @ingroup argparse
 * @name  AddSubCommand
 * @brief Method. Add an subcommand to argparser to compose a command app.
 * @param [in] commandName: command name of this subcommand
 * @param [in] subcommand: another instance of Argparser
 * @return Argparser
 */
Argparser &Argparser::AddSubCommand(std::string commandName, Argparser &subcommand)
{
    SHARED_PTR_ALIA<Argparser> subCmdPtr = nullptr;
    MSVP_MAKE_SHARED1(subCmdPtr, Argparser, subcommand, return *this);
    subcommands_[commandName] = subCmdPtr;
    return *this;
}

Argparser &Argparser::AddRearAppSupport()
{
    appSupported_ = true;
    return *this;
}

Argparser &Argparser::GetSubCommand(std::string commandName)
{
    if (subcommands_.find(commandName) == subcommands_.end()) {
        CmdLog::CmdErrorLog("Can not find subcommand: %s", commandName.c_str());
        return *this;
    }
    return *subcommands_[commandName].get();
}

std::string Argparser::GetOption(const std::string &longName)
{
    if (longNameIndex_.find(longName) == longNameIndex_.end()) {
        return "";
    }
    size_t idx = longNameIndex_[longName];
    return options_[idx].value;
}

Argparser &Argparser::BindPreCheck(std::function<int32_t(void)> preCheckFunc)
{
    preCheckFunc_ = preCheckFunc;
    return *this;
}

Argparser &Argparser::BindExecute(std::function<int32_t(Argparser&)> executeFunc)
{
    executeFunc_ = executeFunc;
    return *this;
}

bool Argparser::ParsedSuccess() const
{
    return status_ == ARGPARSE_OK;
}

bool Argparser::StartWith(const std::string& str, const std::string& prefix) const
{
    if (str.size() < prefix.size() || prefix.size() == 0) {
        return false;
    }
    return str.substr(0, prefix.size()) == prefix;
}

std::string Argparser::StringJoin(std::vector<std::string> &stringList, std::string sep) const
{
    std::string joinedStr;
    for (size_t i = 0; i < stringList.size(); i++) {
        if (i > 0) {
            joinedStr += sep;
        }
        joinedStr += stringList[i];
    }
    return joinedStr;
}

/**
 * @ingroup argparse
 * @name  CheckOptionValue
 * @brief Method. use checkValidFunc or valueRange to check option value
 * @param [in] option: option will be check
 * @return: ARGPARSE_OK
            ARGPARSE_ERROR
 */
int32_t Argparser::CheckOptionValue(Option &option) const
{
    if (option.valueRange.empty() && option.checkValidFunc == nullptr) {
        return ARGPARSE_OK;
    }
    if (!option.valueRange.empty()) {
        std::set<std::string> validSet(option.valueRange.begin(), option.valueRange.end());
        if (validSet.count(option.value) != 1) {
            std::string valueRangeStr = StringJoin(option.valueRange, "|");
            valueRangeStr = "[" + valueRangeStr + "]";
            CmdLog::CmdErrorLog("Argument %s: invalid option value %s. Please input in the range of %s",
                (LONG_PRE + option.longName).c_str(), option.value.c_str(), valueRangeStr.c_str());
            return ARGPARSE_ERROR;
        }
    }
    if (option.checkValidFunc != nullptr) {
        return option.checkValidFunc(option.value);
    }
    return ARGPARSE_OK;
}

std::string Argparser::GetDescription()
{
    return description_;
}

int32_t Argparser::ProcessOptLong(int32_t argc, const CHAR *argv[])
{
    int32_t opt = 0;
    std::string optString = "";
    int32_t optionIndex = 0;
    optind = 1;
    const int32_t offset = 200; // avoid conflicts with 63 and any other ASCII code(0 ~ 127)
    std::vector<OsalStructOption> longopts;
    OsalStructOption longopt;
    for (int32_t i = 0; i < static_cast<int32_t>(options_.size()); i++) {
        int32_t hasArg = options_[i].longName == "help" ? OSAL_NO_ARG : OSAL_OPTIONAL_ARG;
        longopt = {options_[i].longName.c_str(), hasArg, nullptr, i + offset};
        longopts.emplace_back(longopt);
    }
    longopt = {nullptr, 0, nullptr, 0};
    longopts.emplace_back(longopt);
    while ((opt = OsalGetOptLong(argc, const_cast<CHAR **>(argv), optString.c_str(),
        longopts.data(), &optionIndex)) != ARGPARSE_ERROR) {
        if (opt == '?') { // 63
            PrintHelp();
            return ARGPARSE_ERROR;
        }
        int32_t optIdx = opt - offset;
        if (optIdx < 0 || optIdx >= static_cast<int32_t>(options_.size())) {
            CmdLog::CmdErrorLog("Invalid optIdx: %d", optIdx);
            return ARGPARSE_ERROR;
        }
        if (options_[optIdx].longName == "help") {
            PrintHelp();
            return ARGPARSE_ERROR;
        }
        if (OsalGetOptArg() == nullptr) {
            CmdLog::CmdErrorLog("Argument %s: expected one argument",
                (LONG_PRE + options_[optIdx].longName).c_str());
            return ARGPARSE_ERROR;
        }
        options_[optIdx].value = std::string(OsalGetOptArg());
        if (CheckOptionValue(options_[optIdx]) != ARGPARSE_OK) {
            return ARGPARSE_ERROR;
        }
    }
    return ARGPARSE_OK;
}

void Argparser::ProcessAppArgs(std::vector<std::string> &tokens)
{
    if (!appSupported_) {
        return;
    }
    for (size_t i = 0; i < tokens.size(); i++) {
        if (!StartWith(tokens[i], "-")) {
            std::vector<std::string> parsedAppArgs(tokens.begin() + i, tokens.end());
            appArgs = parsedAppArgs;
            tokens.erase(tokens.begin() + i, tokens.end());
            return;
        }
    }
}

Argparser &Argparser::Parse(int32_t argc, const CHAR *argv[])
{
    if (!Utils::CheckInputArgsLength(argc, argv)) {
        return *this;
    }
    if (argc == 1) {
        PrintHelp();
        return *this;
    }
    std::string maybeSubCommand = argv[1];
    if (subcommands_.find(maybeSubCommand) != subcommands_.end()) {
        SHARED_PTR_ALIA<Argparser> subcommand = subcommands_[maybeSubCommand];
        argc--;
        argv++;
        subcommand->Parse(argc, argv);
        if (subcommand->ParsedSuccess()) {
            enabledSubCmd = maybeSubCommand;
            status_ = ARGPARSE_OK;
        }
        return *this;
    }
    if (!StartWith(maybeSubCommand, "-") && !subcommands_.empty()) {
        CmdLog::CmdErrorLog("%s: unrecognized subcommand %s", programName_.c_str(), maybeSubCommand.c_str());
        PrintHelp();
        return *this;
    }
    std::vector<std::string> tokens;
    for (int32_t i = 1; i < argc; ++i) {
        tokens.emplace_back(argv[i]);
    }
    ProcessAppArgs(tokens);
    int32_t argcCount = tokens.size() + 1;
    if (ProcessOptLong(argcCount, argv) != ARGPARSE_OK) {
        return *this;
    }
    if (appSupported_ && appArgs.empty()) {
        CmdLog::CmdErrorLog("Missing rear app args.");
        PrintHelp();
        return *this;
    }
    status_ = ARGPARSE_OK;
    return *this;
}

int32_t Argparser::Execute()
{
    if (!ParsedSuccess()) {
        MSPROF_EVENT("%s command line end.", programName_.c_str());
        return PROFILING_FAILED;
    }
    if (preCheckFunc_ != nullptr && preCheckFunc_() != ARGPARSE_OK) {
        MSPROF_EVENT("%s pre-check failed.", programName_.c_str());
        return PROFILING_FAILED;
    }
    if (!enabledSubCmd.empty()) {
        auto subCommand = GetSubCommand(enabledSubCmd);
        return subCommand.Execute();
    }
    if (executeFunc_ != nullptr) {
        MSPROF_EVENT("%s start execution.", programName_.c_str());
        return executeFunc_(*this);
    }
    return PROFILING_SUCCESS;
}
}
}
}
}