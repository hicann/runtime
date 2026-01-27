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
#include "profiling_adp.h"

namespace AicpuSchedule {
namespace {
    const std::string PARAM_DEVICEID = "--deviceId=";
    const std::string PARAM_HOST_PID = "--pid=";
    const std::string PARAM_SIGN = "--pidSign=";
    const std::string PARAM_PROFILING_MODE = "--profilingMode=";
    const std::string PARAM_CUSTSOPATH = "--custSoPath=";
    const std::string PARAM_AICPUPID = "--aicpuPid=";
    const std::string PARAM_LOGLEVEL = "--logLevelInPid=";
    const std::string PARAM_CCECPULOGLEVEL = "--ccecpuLogLevel=";
    const std::string PARAM_AICPULOGLEVEL = "--aicpuLogLevel=";
    const std::string PARAM_VFID = "--vfId=";
    const std::string PARAM_GRP_NAME_NUM = "--groupNameNum=";
    const std::string PARAM_GRP_NAME_LIST = "--groupNameList=";
    const std::string PARAM_CRL_CPU_LIST = "--ctrolCpuList=";
    const std::string PARAM_TSD_PID = "--tsdPid=";
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
        ArgsParser() : deviceId_(0U), hostPid_(0U), pidSign_(""), profilingMode_(PROFILING_CLOSE), vfId_(0U),
                       logLevel_(ERROR_LOG), eventLevel_(EVENT_LOG), ccecpulogLevel_(-1), aicpulogLevel_(-1),
                       custSoPath_(""), aicpuPid_(0U), grpNameNum_(0U), grpNameList_({}), controlCpuList_({}),
                       tsdPid_(0U), withDeviceId_(false),withHostPid_(false), withPidSign_(false), 
                       withCustSoPath_(false), withAicpuPid_(false), withGrpNameNum_(false), withGrpNameList_(false), 
                       withControlCpuList_(false), withTsdPid_(false),
                       argsParseFuncMap_({{PARAM_DEVICEID, &ArgsParser::ParseDeviceId},
                                          {PARAM_HOST_PID, &ArgsParser::ParseHostPid},
                                          {PARAM_SIGN, &ArgsParser::ParseSign},
                                          {PARAM_PROFILING_MODE, &ArgsParser::ParseProfilingMode},
                                          {PARAM_LOGLEVEL, &ArgsParser::ParseLogAndEventLevel},
                                          {PARAM_CCECPULOGLEVEL, &ArgsParser::ParseCcecpuLogLevel},
                                          {PARAM_AICPULOGLEVEL, &ArgsParser::ParseAicpuLogLevel},
                                          {PARAM_VFID, &ArgsParser::ParseVfId},
                                          {PARAM_CUSTSOPATH, &ArgsParser::ParseCustSoPath},
                                          {PARAM_AICPUPID, &ArgsParser::ParseAicpuPid},
                                          {PARAM_GRP_NAME_NUM, &ArgsParser::ParseGrpNameNum},
                                          {PARAM_GRP_NAME_LIST, &ArgsParser::ParseGrpNameList},
                                          {PARAM_CRL_CPU_LIST, &ArgsParser::ParseCtrolCpuList},
                                          {PARAM_TSD_PID, &ArgsParser::ParseTsdPid}}) {};

        ~ArgsParser() = default;

        bool ParseArgs(const int32_t argc, const char_t * const argv[]);

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

        inline std::string GetCustSoPath() const
        {
            return custSoPath_;
        }

        inline uint32_t GetAicpuPid() const
        {
            return aicpuPid_;
        }

        inline uint32_t GetGrpNameNum() const
        {
            return grpNameNum_;
        }

        inline std::vector<std::string> GetGrpNameList() const
        {
            return grpNameList_;
        }

        inline std::vector<uint32_t> GetControlCpuList() const
        {
            return controlCpuList_;
        }
        inline bool HasControlCpuList() const
        {
            return withControlCpuList_;
        }
        inline bool HasTsdPid() const
        {
            return withTsdPid_;
        }
        inline uint32_t GetTsdPid() const
        {
            return tsdPid_;
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
        bool ParseCustSoPath(const std::string &para);
        bool ParseAicpuPid(const std::string &para);
        bool ParseGrpNameNum(const std::string &para);
        bool ParseGrpNameList(const std::string &para);
        bool ParseCtrolCpuList(const std::string &para);
        static void SplitControlCpuList(const std::string &cupListPara, std::vector<uint32_t> &controlCpuList);
        static void SplitGrpNameList(const std::string &grpNamePara, std::vector<std::string> &grpNameList);
        bool ParseTsdPid(const std::string &para);
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
        std::string custSoPath_;
        uint32_t aicpuPid_;
        uint32_t grpNameNum_;
        std::vector<std::string> grpNameList_;
        std::vector<uint32_t> controlCpuList_;
        uint32_t tsdPid_;
        bool withDeviceId_;
        bool withHostPid_;
        bool withPidSign_;
        bool withCustSoPath_;
        bool withAicpuPid_;
        bool withGrpNameNum_;
        bool withGrpNameList_;
        bool withControlCpuList_;
        bool withTsdPid_;
        using SingleParaParseFunc = bool (ArgsParser::*)(const std::string &);
        const std::unordered_map<std::string, SingleParaParseFunc> argsParseFuncMap_;
    };
} // namespace AicpuSchedule

#endif // CORE_AICPUSD_ARGS_PARSER_H
