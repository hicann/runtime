/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <sstream>
#include "aicpusd_util.h"
#include "aicpusd_args_parser.h"

namespace AicpuSchedule {
    bool ArgsParser::ParseArgs(const int32_t argc, const char_t * const argv[])
    {
        if ((argv == nullptr) || (argc <= 1)) {
            return false;
        }

        for (uint32_t i = 0; i < static_cast<uint32_t>(argc); ++i) {
            if (!ParseSinglePara(std::string(argv[i]))) {
                return false;
            }
        }

        return CheckRequiredParas();
    }

    bool ArgsParser::CheckRequiredParas() const
    {
        std::vector<bool> requiredParams = {withDeviceId_, withHostPid_, withPidSign_, withCustSoPath_,
                                            withAicpuPid_, withGrpNameNum_, withGrpNameList_};
        for (const auto &iter : requiredParams) {
            if (!iter) {
                return false;
            }
        }

        return true;
    }

    bool ArgsParser::ParseSinglePara(const std::string &singlePara)
    {
        const std::size_t offset = singlePara.find("=");
        if (offset == std::string::npos) {
            return true;
        }

        const std::string key = singlePara.substr(0U, offset+1UL);
        const std::string val = singlePara.substr(offset+1UL);
        const auto iter = argsParseFuncMap_.find(key);
        if (iter == argsParseFuncMap_.end()) {
            // Ignore unknown parameter
            return true;
        }

        const bool ret = (this->*(iter->second))(val);
        if (!ret) {
            return false;
        }

        return true;
    }

    bool ArgsParser::ParseDeviceId(const std::string &para)
    {
        int32_t val = 0;
        if (!AicpuUtil::TransStrToInt(para, val)) {
            return false;
        }

        if ((val < 0) || (val >= AICPUFW_CHIP_NUM_MAX)) {
            return false;
        }

        deviceId_ = static_cast<uint32_t>(val);
        withDeviceId_ = true;
        return true;
    }

    bool ArgsParser::ParseHostPid(const std::string &para)
    {
        int32_t val = 0;
        if (!AicpuUtil::TransStrToInt(para, val)) {
            return false;
        }

        if (val <= 0) {
            return false;
        }

        hostPid_ = static_cast<uint32_t>(val);
        withHostPid_ = true;
        return true;
    }

    bool ArgsParser::ParseSign(const std::string &para)
    {
        pidSign_ = para;
        withPidSign_ = true;
        return true;
    }

    bool ArgsParser::ParseProfilingMode(const std::string &para)
    {
        uint32_t val = 0U;
        if (!AicpuUtil::TransStrToUint(para, val)) {
            return false;
        }

        if (val < 0U) {
            return false;
        }

        profilingMode_ = val;
        return true;
    }

    bool ArgsParser::ParseLogAndEventLevel(const std::string &para)
    {
        int32_t val = 0;
        if (!AicpuUtil::TransStrToInt(para, val)) {
            return false;
        }

        if (val < 0) {
            return false;
        }

        logLevel_ = val % VALUE_FOR_CALCULATE_LOG_LEVEL;
        eventLevel_ = val / VALUE_FOR_CALCULATE_LOG_LEVEL;
        return true;
    }

    bool ArgsParser::ParseCcecpuLogLevel(const std::string &para)
    {
        int32_t val = 0;
        if (!AicpuUtil::TransStrToInt(para, val)) {
            return true;
        }

        ccecpulogLevel_ = val;
        return true;
    }

    bool ArgsParser::ParseAicpuLogLevel(const std::string &para)
    {
        int32_t val = 0;
        if (!AicpuUtil::TransStrToInt(para, val)) {
            return true;
        }

        aicpulogLevel_ = val;
        return true;
    }

    bool ArgsParser::ParseVfId(const std::string &para)
    {
        int32_t val = 0;
        if (!AicpuUtil::TransStrToInt(para, val)) {
            return false;
        }

        if ((val < 0) || (val > VF_ID_MAX)) {
            return false;
        }

        vfId_ = static_cast<uint32_t>(val);
        return true;
    }

    bool ArgsParser::ParseCustSoPath(const std::string &para)
    {
        custSoPath_ = para;
        withCustSoPath_ = true;
        return true;
    }

    bool ArgsParser::ParseAicpuPid(const std::string &para)
    {
        int32_t val = 0;
        if (!AicpuUtil::TransStrToInt(para, val)) {
            return false;
        }

        if (val <= 0) {
            return false;
        }

        aicpuPid_ = static_cast<uint32_t>(val);
        withAicpuPid_ = true;
        return true;
    }

    bool ArgsParser::ParseGrpNameNum(const std::string &para)
    {
        int32_t val = 0;
        if (!AicpuUtil::TransStrToInt(para, val)) {
            return false;
        }

        if (val < 0) {
            return false;
        }

        grpNameNum_ = static_cast<uint32_t>(val);
        withGrpNameNum_ = true;
        return true;
    }

    bool ArgsParser::ParseGrpNameList(const std::string &para)
    {
        grpNameList_.clear();
        ArgsParser::SplitGrpNameList(para, grpNameList_);
        withGrpNameList_ = true;
        return true;
    }

    void ArgsParser::SplitGrpNameList(const std::string &grpNamePara, std::vector<std::string> &grpNameList)
    {
        std::stringstream grpNameSteam(grpNamePara);
        std::string tmpGrpName;
        while (getline(grpNameSteam, tmpGrpName, ',')) {
            grpNameList.push_back(tmpGrpName);
        }
    }

    void ArgsParser::SplitControlCpuList(const std::string &cupListPara, std::vector<uint32_t> &controlCpuList)
    {
        std::stringstream cpuListSteam(cupListPara);
        std::string cpuName;
        while (getline(cpuListSteam, cpuName, ',')) {
            uint32_t val = 0U;
            if (!AicpuUtil::TransStrToUint(cpuName, val)) {
                controlCpuList.clear();
                return;
            }
            controlCpuList.push_back(val);
        }
    }

    bool ArgsParser::ParseCtrolCpuList(const std::string &para)
    {
        controlCpuList_.clear();
        ArgsParser::SplitControlCpuList(para, controlCpuList_);
        withControlCpuList_ = true;
        return true;
    }

    bool ArgsParser::ParseTsdPid(const std::string &para)
    {
        tsdPid_ = 0U;
        uint32_t val = 0U;
        if (!AicpuUtil::TransStrToUint(para, val)) {
            return true;
        }
        tsdPid_ = val;
        withTsdPid_ = true;
        return true;
    }

    std::string ArgsParser::GetParaParsedStr()
    {
        std::ostringstream oss;
        oss << "deviceId=" <<  deviceId_ << ", hostPid=" << hostPid_ << ", pidSign=" << pidSign_
            << ", profilingMode=" << profilingMode_ << ", vfId=" << vfId_ << ", logLevel=" << logLevel_
            << ", ccecpulogLevel=" << ccecpulogLevel_ << ", aicpulogLevel=" << aicpulogLevel_
            << ", aicpuPid=" << aicpuPid_ << ", grpNameNum=" << grpNameNum_ << ", grpNameList=[";

        for (const std::string &iter : grpNameList_) {
            oss << iter << ",";
        }

        oss << "], " << "custSoPath=" << custSoPath_ <<", ctrolCpuList=[";
        for (const uint32_t &iter : controlCpuList_) {
            oss << std::to_string(iter) << ",";
        }
        oss<<"]"<<", tsdPid=" << tsdPid_;

        return oss.str();
    }
}
