/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QS_ARGS_PARSER_H
#define QS_ARGS_PARSER_H

#include <string>
#include <vector>
#include <unordered_map>
#include "bqs_msg.h"

namespace bqs {
namespace {
    const std::string PARAM_DEVICEID = "--deviceId=";
    const std::string PARAM_HOST_PID = "--pid=";
    const std::string PARAM_PIDSIGN = "--pidSign=";
    const std::string PARAM_VFID = "--vfId=";
    const std::string PARAM_LOGLEVEL = "--logLevelInPid=";
    const std::string PARAM_AICPULOGLEVEL = "--aicpuLogLevel=";
    const std::string PARAM_DEPLOY_MODE = "--deployMode=";
    const std::string PARAM_RESCHED_INTERVAL = "--reschedInterval=";
    const std::string PARAM_GRP_NAME = "--qsInitGroupName=";
    const std::string PARAM_SCHED_POLICY = "--schedPolicy=";
    const std::string PARAM_STARTER = "--starter=";
    const std::string PARAM_PROF_CFG_DATA = "--profCfgData=";
    const std::string PARAM_PROF_FLAG = "--profFlag=";
    const std::string PARAM_ABNORMAL_INTERVAL = "--abnormalInterval=";
    const std::string PARAM_RESOURCE_LIST = "--resIds=";
    const std::string PARAM_DEVICEIDS_LIST = "--devIds=";
    constexpr int32_t ERROR_LOG = 3;
    constexpr int32_t EVENT_LOG = 1;
    constexpr int32_t DEBUG_LOG = 0;
    constexpr int32_t QS_FW_CHIP_NUM_MAX = 64;
    constexpr int32_t VF_ID_MAX = 16;
    constexpr int32_t VALUE_FOR_CALCULATE_LOG_LEVEL = 100;
    constexpr int32_t SUCCESS_VALUE = 0;
    constexpr int32_t RESCHED_INTERVAL_CLOSE = -1;
    constexpr int32_t RESCHED_INTERVAL_DEFAULT = 30;
    constexpr int32_t RESCHED_INTERVAL_MAX = 1000;
    constexpr int32_t ABNORMAL_INTERVAL_MIN = 0;
    constexpr int32_t ABNORMAL_INTERVAL_DEFAULT = 10;
    constexpr int32_t ABNORMAL_INTERVAL_MAX = 1000;

}

    class ArgsParser {
    public:
        ArgsParser() : deviceId_(0U), hostPid_(0U), pidSign_(""), vfId_(0U), logLevel_(ERROR_LOG),
                       eventLevel_(EVENT_LOG), aicpulogLevel_(-1), deployMode_(QueueSchedulerRunMode::SINGLE_PROCESS),
                       reschedInterval_(RESCHED_INTERVAL_DEFAULT), groupName_(""), schedPolicy_(0U),
                       starter_(QsStartType::START_BY_TSD), profCfgData_(""), abnormalInterval_(ABNORMAL_INTERVAL_DEFAULT),
                       profFlag_(false), withDeviceId_(false), withHostPid_(false),
                       withPidSign_(false), withVfId_(false), withLogLevel_(false), withGroupName_(false), withStarter_(false),
                       argsParseFuncMap_({{PARAM_DEVICEID, &ArgsParser::ParseDeviceId},
                                          {PARAM_HOST_PID, &ArgsParser::ParseHostPid},
                                          {PARAM_PIDSIGN, &ArgsParser::ParsePidSign},
                                          {PARAM_VFID, &ArgsParser::ParseVfId},
                                          {PARAM_LOGLEVEL, &ArgsParser::ParseLogAndEventLevel},
                                          {PARAM_AICPULOGLEVEL, &ArgsParser::ParseAicpuLogLevel},
                                          {PARAM_DEPLOY_MODE, &ArgsParser::ParseDeployMode},
                                          {PARAM_RESCHED_INTERVAL, &ArgsParser::ParseReschedInterval},
                                          {PARAM_GRP_NAME, &ArgsParser::ParseGroupName},
                                          {PARAM_SCHED_POLICY, &ArgsParser::ParseSchedPolicy},
                                          {PARAM_STARTER, &ArgsParser::ParseStarter},
                                          {PARAM_PROF_CFG_DATA, &ArgsParser::ParseProfCfgData},
                                          {PARAM_PROF_FLAG, &ArgsParser::ParseProfFlag},
                                          {PARAM_ABNORMAL_INTERVAL, &ArgsParser::ParseAbnormalInterval},
                                          {PARAM_RESOURCE_LIST, &ArgsParser::ParseResourceList},
                                          {PARAM_DEVICEIDS_LIST, &ArgsParser::ParseDeviceIdsList}}) {};

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

        inline int32_t GetAicpuLogLevel() const
        {
            return aicpulogLevel_;
        }

        inline QueueSchedulerRunMode GetDeployMode() const
        {
            return deployMode_;
        }

        inline int32_t GetReschedInterval() const
        {
            return reschedInterval_;
        }

        inline std::string GetGroupName() const
        {
            return groupName_;
        }

        inline uint64_t GetSchedPolicy() const
        {
            return schedPolicy_;
        }

        inline QsStartType GetStarter() const
        {
            return starter_;
        }

        inline std::string GetProfCfgData() const
        {
            return profCfgData_;
        }

        inline bool GetProfFlag() const
        {
            return profFlag_;
        }

        inline int32_t GetAbnormalInterval() const
        {
            return abnormalInterval_;
        }

        inline bool GetWithDeviceId() const
        {
            return withDeviceId_;
        }

        inline bool GetWithHostPid() const
        {
            return withHostPid_;
        }

        inline bool GetWithPidSign() const
        {
            return withPidSign_;
        }

        inline bool GetWithVfId() const
        {
            return withVfId_;
        }

        inline bool GetWithLogLevel() const
        {
            return withLogLevel_;
        }

        inline bool GetWithGroupName() const
        {
            return withGroupName_;
        }

        inline bool GetWithStarter() const
        {
            return withStarter_;
        }

        inline std::vector<uint32_t> GetResvec() const
        {
            return resVec_;
        }

        inline std::vector<uint32_t> GetDevIdVec() const
        {
            return devIdVec_;
        }

        void SetLogLevel(const int32_t logLevel, const int32_t eventLevel) const;

    private:
        bool CheckRequiredParas() const;
        bool ParseSinglePara(const std::string &singlePara);
        bool ParseDeviceId(const std::string &para);
        bool ParseDeviceId(const std::string &para, int32_t &deviceId) const;
        bool ParseHostPid(const std::string &para);
        bool ParsePidSign(const std::string &para);
        bool ParseLogAndEventLevel(const std::string &para);
        bool ParseAicpuLogLevel(const std::string &para);
        bool ParseVfId(const std::string &para);
        bool ParseDeployMode(const std::string &para);
        bool ParseReschedInterval(const std::string &para);
        bool ParseGroupName(const std::string &para);
        bool ParseSchedPolicy(const std::string &para);
        bool ParseStarter(const std::string &para);
        bool ParseProfCfgData(const std::string &para);
        bool ParseProfFlag(const std::string &para);
        bool ParseAbnormalInterval(const std::string &para);
        bool ParseResourceList(const std::string &para);
        bool ParseDeviceIdsList(const std::string &para);
        void SetAicpuLogLevel() const;
      
        ArgsParser(ArgsParser const &) = delete;
        ArgsParser &operator=(ArgsParser const &) = delete;
        ArgsParser(ArgsParser &&) = delete;
        ArgsParser &operator=(ArgsParser &&) = delete;

        uint32_t deviceId_;
        uint32_t hostPid_;
        std::string pidSign_;
        uint32_t vfId_;
        int32_t logLevel_;
        int32_t eventLevel_;
        int32_t aicpulogLevel_;
        QueueSchedulerRunMode deployMode_;
        int32_t reschedInterval_;
        std::string groupName_;
        uint64_t schedPolicy_;
        QsStartType starter_;
        std::string  profCfgData_;
        int32_t abnormalInterval_;
        std::vector<uint32_t> resVec_;
        std::vector<uint32_t> devIdVec_;
        bool profFlag_;
        bool withDeviceId_;
        bool withHostPid_;
        bool withPidSign_;
        bool withVfId_;
        bool withLogLevel_;
        bool withGroupName_;
        bool withStarter_;
        using SingleParaParseFunc = bool (ArgsParser::*)(const std::string &);
        const std::unordered_map<std::string, SingleParaParseFunc> argsParseFuncMap_;
    };
} // namespace bqs

#endif // QS_ARGS_PARSER_H
