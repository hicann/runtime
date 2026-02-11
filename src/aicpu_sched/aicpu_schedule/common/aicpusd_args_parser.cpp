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

    bool ArgsParser::ParseArgs(const std::vector<std::string> &args)
    {
        for (const auto &iter : args) {
            if (!ParseSinglePara(iter)) {
                return false;
            }
        }

        return CheckRequiredParas();
    }

    bool ArgsParser::CheckRequiredParas() const
    {
        const bool requiredParams[] = {withDeviceId_, withHostPid_, withPidSign_, withGrpNameNum_, withGrpNameList_};
        for (uint32_t i = 0U; i < (sizeof(requiredParams) / sizeof(bool)); ++i) {
            if (!requiredParams[i]) {
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

        if ((val != static_cast<uint32_t>(PROFILING_CLOSE)) &&
            (val != static_cast<uint32_t>(PROFILING_OPEN))) {
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

    bool ArgsParser::ParseDeviceMode(const std::string &para)
    {
        int32_t val = 0;
        if (!AicpuUtil::TransStrToInt(para, val)) {
            return false;
        }

        if ((val < 0) || (val > DEVICE_MODE_MAX)) {
            return false;
        }

        deviceMode_ = static_cast<uint32_t>(val);
        return true;
    }

    bool ArgsParser::ParseAicpuSchedMode(const std::string &para)
    {
        int32_t val = 0;
        if (!AicpuUtil::TransStrToInt(para, val)) {
            return false;
        }

        if ((val < 0) || (val >= static_cast<int32_t>(SCHED_MODE_INVALID))) {
            return false;
        }

        aicpuSchedMode_ = static_cast<AicpuSchedMode>(val);
        return true;
    }

    bool ArgsParser::ParseAicpuProcNum(const std::string &para) 
    {
        uint32_t val = 0;
        if (!AicpuUtil::TransStrToUint(para, val)) {
            return false;
        }
        aicpuProcNum_ = val;
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

    bool ArgsParser::ParseHostProcName(const std::string &para)
    {
        hostProcName_ = para;
        return true;
    }

    bool ArgsParser::ParseQsGrpNameList(const std::string &para)
    {
        qsGrpNameList_.clear();
        ArgsParser::SplitGrpNameList(para, qsGrpNameList_);
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

    std::string ArgsParser::GetParaParsedStr()
    {
        std::ostringstream oss;
        oss << "deviceId=" <<  deviceId_ << ", hostPid=" << hostPid_ << ", pidSign=" << pidSign_
            << ", profilingMode=" << profilingMode_ << ", vfId=" << vfId_ << ", logLevel=" << logLevel_
            << ", ccecpulogLevel=" << ccecpulogLevel_ << ", aicpulogLevel=" << aicpulogLevel_
            << ", deviceMode=" << deviceMode_ << ", aicpuSchedMode=" << aicpuSchedMode_
            << ", hostProcName=" << hostProcName_ << ", grpNameNum=" << grpNameNum_ << ", aicpuProcNum=" << aicpuProcNum_
            << ", grpNameList=[";

        for (const std::string &iter : grpNameList_) {
            oss << iter << ",";
        }
        oss << "]";

        return oss.str();
    }
}
