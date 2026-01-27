/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CORE_AICPUSD_ARGS_PARSER_H
#define CORE_AICPUSD_ARGS_PARSER_H

#include <string>
#include <vector>
#include <unordered_map>
#include "aicpusd_info.h"
#include "aicpusd_common.h"

namespace AicpuSchedule {
namespace {
    const std::string PARAM_DEVICEID = "--deviceId=";
    const std::string PARAM_HOST_PID = "--pid=";
    const std::string PARAM_SIGN = "--pidSign=";
    const std::string PARAM_PROFILING_MODE = "--profilingMode=";
    const std::string PARAM_LOGLEVEL = "--logLevelInPid=";
    const std::string PARAM_CCECPULOGLEVEL = "--ccecpuLogLevel=";
    const std::string PARAM_AICPULOGLEVEL = "--aicpuLogLevel=";
    const std::string PARAM_VFID = "--vfId=";
    const std::string PARAM_DEVICE_MODE = "--deviceMode=";
    const std::string PARAM_AICPU_SCHED_MODE = "--aicpuSchedMode=";
    const std::string PARAM_GRP_NAME_NUM = "--groupNameNum=";
    const std::string PARAM_GRP_NAME_LIST = "--groupNameList=";
    const std::string PARAM_HOST_PROC_NAME = "--hostProcName=";
    const std::string PARAM_QSGRP_NAME_LIST = "--qsInitGroupName=";
    constexpr int32_t ERROR_LOG = 3;
    constexpr int32_t EVENT_LOG = 1;
    constexpr int32_t DEBUG_LOG = 0;
    constexpr int32_t VF_ID_MAX = 16;
    constexpr int32_t DEVICE_MODE_MAX = 1;
    constexpr int32_t AICPUFW_CHIP_NUM_MAX = 64;
    constexpr int32_t VALUE_FOR_CALCULATE_LOG_LEVEL = 100;
}

    class ArgsParser {
    public:
        ArgsParser() : deviceId_(0U), hostPid_(0U), pidSign_(""), profilingMode_(0U), vfId_(0U),
                       logLevel_(ERROR_LOG), eventLevel_(EVENT_LOG), ccecpulogLevel_(-1), aicpulogLevel_(-1),
                       deviceMode_(0U), aicpuSchedMode_(SCHED_MODE_INTERRUPT), grpNameNum_(0U), grpNameList_({}),
                       hostProcName_({}), qsGrpNameList_({}), withDeviceId_(false), withHostPid_(false),
                       withPidSign_(false), withGrpNameNum_(false), withGrpNameList_(false),
                       argsParseFuncMap_({{PARAM_DEVICEID, &ArgsParser::ParseDeviceId},
                                          {PARAM_HOST_PID, &ArgsParser::ParseHostPid},
                                          {PARAM_SIGN, &ArgsParser::ParseSign},
                                          {PARAM_PROFILING_MODE, &ArgsParser::ParseProfilingMode},
                                          {PARAM_LOGLEVEL, &ArgsParser::ParseLogAndEventLevel},
                                          {PARAM_CCECPULOGLEVEL, &ArgsParser::ParseCcecpuLogLevel},
                                          {PARAM_AICPULOGLEVEL, &ArgsParser::ParseAicpuLogLevel},
                                          {PARAM_VFID, &ArgsParser::ParseVfId},
                                          {PARAM_DEVICE_MODE, &ArgsParser::ParseDeviceMode},
                                          {PARAM_AICPU_SCHED_MODE, &ArgsParser::ParseAicpuSchedMode},
                                          {PARAM_GRP_NAME_NUM, &ArgsParser::ParseGrpNameNum},
                                          {PARAM_GRP_NAME_LIST, &ArgsParser::ParseGrpNameList},
                                          {PARAM_HOST_PROC_NAME, &ArgsParser::ParseHostProcName},
                                          {PARAM_QSGRP_NAME_LIST, &ArgsParser::ParseQsGrpNameList}}) {};

        ~ArgsParser() = default;

        bool ParseArgs(const int32_t argc, const char_t * const argv[]);

        bool ParseArgs(const std::vector<std::string> &args);

        std::string GetParaParsedStr();

        inline uint32_t GetDeviceId() const
        {
            return deviceId_;
        }

        inline uint32_t GetHostPid() const
        {
            return hostPid_;
        }

        inline std::string GetPidSign() const
        {
            return pidSign_;
        }

        inline uint32_t GetProfilingMode() const
        {
            return profilingMode_;
        }

        inline uint32_t GetVfId() const
        {
            return vfId_;
        }

        inline int32_t GetLogLevel() const
        {
            return logLevel_;
        }

        inline int32_t GetEventLevel() const
        {
            return eventLevel_;
        }

        inline int32_t GetCcecpuLogLevel() const
        {
            return ccecpulogLevel_;
        }

        inline int32_t GetAicpuLogLevel() const
        {
            return aicpulogLevel_;
        }

        inline uint32_t GetDeviceMode() const
        {
            return deviceMode_;
        }

        inline AicpuSchedMode GetAicpuSchedMode() const
        {
            return aicpuSchedMode_;
        }

        inline uint32_t GetGrpNameNum() const
        {
            return grpNameNum_;
        }

        inline std::vector<std::string> GetGrpNameList() const
        {
            return grpNameList_;
        }

        inline std::string GetHostProcName() const
        {
            return hostProcName_;
        }

        inline std::vector<std::string> GetQsGrpNameList() const
        {
            return qsGrpNameList_;
        }

    private:
        bool CheckRequiredParas() const;
        bool ParseSinglePara(const std::string &singlePara);
        bool ParseDeviceId(const std::string &para);
        bool ParseHostPid(const std::string &para);
        bool ParseSign(const std::string &para);
        bool ParseProfilingMode(const std::string &para);
        bool ParseLogAndEventLevel(const std::string &para);
        bool ParseCcecpuLogLevel(const std::string &para);
        bool ParseAicpuLogLevel(const std::string &para);
        bool ParseVfId(const std::string &para);
        bool ParseDeviceMode(const std::string &para);
        bool ParseAicpuSchedMode(const std::string &para);
        bool ParseGrpNameNum(const std::string &para);
        bool ParseGrpNameList(const std::string &para);
        bool ParseHostProcName(const std::string &para);
        bool ParseQsGrpNameList(const std::string &para);
        static void SplitGrpNameList(const std::string &grpNamePara, std::vector<std::string> &grpNameList);

        ArgsParser(ArgsParser const &) = delete;
        ArgsParser &operator=(ArgsParser const &) = delete;
        ArgsParser(ArgsParser &&) = delete;
        ArgsParser &operator=(ArgsParser &&) = delete;

        uint32_t deviceId_;
        uint32_t hostPid_;
        std::string pidSign_;
        uint32_t profilingMode_;
        uint32_t vfId_;
        int32_t logLevel_;
        int32_t eventLevel_;
        int32_t ccecpulogLevel_;
        int32_t aicpulogLevel_;
        uint32_t deviceMode_;
        AicpuSchedMode aicpuSchedMode_;
        uint32_t grpNameNum_;
        std::vector<std::string> grpNameList_;
        std::string hostProcName_;
        std::vector<std::string> qsGrpNameList_;
        bool withDeviceId_;
        bool withHostPid_;
        bool withPidSign_;
        bool withGrpNameNum_;
        bool withGrpNameList_;
        using SingleParaParseFunc = bool (ArgsParser::*)(const std::string &);
        const std::unordered_map<std::string, SingleParaParseFunc> argsParseFuncMap_;
    };
} // namespace AicpuSchedule

#endif // CORE_AICPUSD_ARGS_PARSER_H
