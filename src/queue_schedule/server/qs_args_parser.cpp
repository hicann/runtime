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
#include "qs_args_parser.h"
#include "bqs_util.h"
#include "bqs_log.h"
#include "bqs_feature_ctrl.h"

namespace bqs {
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
        std::unordered_map<std::string, bool> requiredParamsMap;
        requiredParamsMap.insert(std::make_pair(PARAM_DEVICEID, withDeviceId_));
        requiredParamsMap.insert(std::make_pair(PARAM_HOST_PID, withHostPid_));
        if (bqs::GetRunContext() == bqs::RunContext::HOST) {
            requiredParamsMap.insert(std::make_pair(PARAM_GRP_NAME, withGroupName_));
        }
        for (auto requiredParams : requiredParamsMap) {
            if (!requiredParams.second) {
                BQS_LOG_ERROR("Param error. Must specify param with [%s].", requiredParams.first.c_str());                
                return false;
            }
        }

        std::unordered_map<std::string, bool> requiredParamsWarnMap;
        requiredParamsWarnMap.insert(std::make_pair(PARAM_VFID, withVfId_));
        requiredParamsWarnMap.insert(std::make_pair(PARAM_PIDSIGN, withPidSign_));
        for (auto requiredParamsWarn : requiredParamsWarnMap) {
            if (!requiredParamsWarn.second) {
                BQS_LOG_WARN("param error. Param %s does not exist.", requiredParamsWarn.first.c_str());
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

        const std::string key = singlePara.substr(0U, offset + 1UL);
        const std::string val = singlePara.substr(offset + 1UL);
        const auto iter = argsParseFuncMap_.find(key);
        if (iter == argsParseFuncMap_.end()) {
            // Ignore unknown parameter
            BQS_LOG_WARN("unknown input parameter [%s] of function ParseArgs, ignore", key.c_str());
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
        if (!TransStrToInt(para, val)) {
            BQS_LOG_ERROR("Parse deviceId failed, param is %s", para.c_str());
            return false;
        }

        if ((val < 0) || (val >= QS_FW_CHIP_NUM_MAX)) {
            BQS_LOG_ERROR("DeviceId param[%s] invalided, value is not in [%d, %d)",
                          para.c_str(), 0, QS_FW_CHIP_NUM_MAX);
            return false;
        }

        deviceId_ = static_cast<uint32_t>(val);
        withDeviceId_ = true;
        return true;
    }

    bool ArgsParser::ParseDeviceId(const std::string &para, int32_t &deviceId) const
    {
        int32_t val = 0;
        if (!TransStrToInt(para, val)) {
            BQS_LOG_WARN("Parse deviceId failed, param is %s", para.c_str());
            return false;
        }

        if ((val < 0) || (val >= QS_FW_CHIP_NUM_MAX)) {
            BQS_LOG_WARN("DeviceId param[%s] invalided, value is not in [%d, %d)",
                         para.c_str(), 0, QS_FW_CHIP_NUM_MAX);
            return false;
        }

        deviceId = static_cast<uint32_t>(val);
        return true;
    }

    bool ArgsParser::ParseHostPid(const std::string &para)
    {
        int32_t val = 0;
        if (!TransStrToInt(para, val)) {
            BQS_LOG_ERROR("Parse pid failed, param is %s", para.c_str());
            return false;
        }

        if (val <= 0) {
            BQS_LOG_ERROR("Pid param[%s] value invalided", para.c_str());
            return false;
        }

        hostPid_ = static_cast<uint32_t>(val);
        withHostPid_ = true;
        return true;
    }

    bool ArgsParser::ParsePidSign(const std::string &para)
    {
        pidSign_ = para;
        withPidSign_ = true;
        return true;
    }

    bool ArgsParser::ParseVfId(const std::string &para)
    {
        int32_t val = 0;
        if (!TransStrToInt(para, val)) {
            BQS_LOG_ERROR("Parse vfId failed, param is %s", para.c_str());
            return false;
        }

        if ((val < 0) || (val > VF_ID_MAX)) {
            BQS_LOG_ERROR("VfId param[%s] invalided, value is not in [%u, %u]",
                          para.c_str(), 0, VF_ID_MAX);
            return false;
        }

        vfId_ = static_cast<uint32_t>(val);
        withVfId_ = true;
        return true;
    }

    void ArgsParser::SetLogLevel(const int32_t logLevel, const int32_t eventLevel) const
    {
        if (bqs::FeatureCtrl::IsHostQs()) {
            bqs::HostQsLog::GetInstance().DlogSetLevel(logLevel, eventLevel);
            LogAttr dlogAttrInfo = {};
            dlogAttrInfo.type = APPLICATION;
            dlogAttrInfo.pid = hostPid_;
            dlogAttrInfo.deviceId = deviceId_;
            dlogAttrInfo.mode = 0;
            bqs::HostQsLog::GetInstance().DlogSetAttr(dlogAttrInfo);
        } else {
            if (&dlog_setlevel != nullptr) {
                if (dlog_setlevel(-1, logLevel, eventLevel) != SUCCESS_VALUE) {
                    BQS_LOG_WARN("Set log level failed");
                }
            }
            if (&DlogSetAttr != nullptr) {
                LogAttr dlogAttrInfo = {};
                dlogAttrInfo.type = APPLICATION;
                dlogAttrInfo.pid = hostPid_;
                dlogAttrInfo.deviceId = deviceId_;
                dlogAttrInfo.mode = 0;
                if (DlogSetAttr(dlogAttrInfo) != SUCCESS_VALUE) {
                    BQS_LOG_WARN("Set log attr failed");
                }
            }
        }
    }

    void ArgsParser::SetAicpuLogLevel() const
    {
        if ((aicpulogLevel_ >= DEBUG_LOG) && (aicpulogLevel_ <= ERROR_LOG)) {
            if (bqs::FeatureCtrl::IsHostQs()) {
                bqs::HostQsLog::GetInstance().DlogSetLevel(aicpulogLevel_, eventLevel_);
            } else {
                if (&dlog_setlevel != nullptr) {
                    if (dlog_setlevel(AICPU, aicpulogLevel_, eventLevel_) != SUCCESS_VALUE) {
                        BQS_LOG_WARN("Set aicpu log level failed");
                    }
                }
            }
        }
    }

    bool ArgsParser::ParseLogAndEventLevel(const std::string &para)
    {
        int32_t val = 0;
        if (!TransStrToInt(para, val)) {
            return false;
        }

        if (val < 0) {
            return false;
        }

        logLevel_ = val % VALUE_FOR_CALCULATE_LOG_LEVEL;
        eventLevel_ = val / VALUE_FOR_CALCULATE_LOG_LEVEL;
        withLogLevel_ = true;
        SetLogLevel(logLevel_, eventLevel_);
        return true;
    }

    bool ArgsParser::ParseAicpuLogLevel(const std::string &para)
    {
        int32_t val = 0;
        if (!TransStrToInt(para, val)) {
            return true;
        }

        aicpulogLevel_ = val;
        withLogLevel_ = true;
        SetAicpuLogLevel();
        return true;
    }

    bool ArgsParser::ParseDeployMode(const std::string &para)
    {
        int32_t val = 0;
        if (!TransStrToInt(para, val)) {
            BQS_LOG_ERROR("Parse deploy mode failed, param is %s", para.c_str());
            return false;
        }

        if ((val < static_cast<int32_t>(bqs::QueueSchedulerRunMode::SINGLE_PROCESS)) ||
            (val > static_cast<int32_t>(bqs::QueueSchedulerRunMode::MULTI_THREAD))) {
            BQS_LOG_ERROR("deploy mode param[%s] invalided, value is not in [%u, %u]", para.c_str(),
                          QueueSchedulerRunMode::SINGLE_PROCESS, QueueSchedulerRunMode::MULTI_THREAD);
             return false;
        }

        deployMode_ = static_cast<QueueSchedulerRunMode>(val);
        return true;
    }

    // ignore error
    bool ArgsParser::ParseReschedInterval(const std::string &para)
    {
        int32_t val = 0;
        if (!TransStrToInt(para, val)) {
            BQS_LOG_WARN("Parse resched interval not success, using default value %d ms", reschedInterval_);
            return true;
        }

        if ((val < RESCHED_INTERVAL_CLOSE) || (val > RESCHED_INTERVAL_MAX)) {
            BQS_LOG_WARN("resched interval param[%s] invalided, value is not in [%d, %d], using default value[%d] ms",
                         para.c_str(), RESCHED_INTERVAL_CLOSE, RESCHED_INTERVAL_MAX, reschedInterval_);
            return true;
        }

        reschedInterval_ = val;
        return true;
    }


    bool ArgsParser::ParseGroupName(const std::string &para)
    {
        groupName_ = para;
        withGroupName_ = true;
        return true;
    }

    bool ArgsParser::ParseSchedPolicy(const std::string &para)
    {
        uint64_t val = 0;
        if (!TransStrToull(para, val)) {
            BQS_LOG_ERROR("Parse SchedPolicy failed, param is %s", para.c_str());
            return false;
        }

        BQS_LOG_INFO("SchedPolicy is [0x%llx].", val);
        schedPolicy_ = val;
        return true;
    }

    // ignore error
    bool ArgsParser::ParseStarter(const std::string &para)
    {
        int32_t val = 0;
        if (!TransStrToInt(para, val)) {
            BQS_LOG_WARN("Parse starter failed, param is %s", para.c_str());
            return true;
        }

        starter_ = static_cast<bqs::QsStartType>(val);
        withStarter_ = true;
        return true;
    }

    bool ArgsParser::ParseProfCfgData(const std::string &para)
    {
        profCfgData_ = para;
        return true;
    }

    // ignore error
    bool ArgsParser::ParseProfFlag(const std::string &para)
    {
        int32_t val = 0;
        if (!TransStrToInt(para, val)) {
            BQS_LOG_WARN("Parse prof flag failed, param is %s", para.c_str());
            return true;
        }

        profFlag_ = (val != 0);
        return true;
    }

    // ignore error
    bool ArgsParser::ParseAbnormalInterval(const std::string &para)
    {
        int32_t val = 0;
        if (!TransStrToInt(para, val)) {
            BQS_LOG_INFO("Parse abnormal interval not success, using default value %d", abnormalInterval_);
            return true;
        }

        if ((val <= ABNORMAL_INTERVAL_MIN) || (val > ABNORMAL_INTERVAL_MAX)) {
            BQS_LOG_WARN("abnormal interval param[%s] invalided, value is not in [%d, %d], using default value[%d]",
                         para.c_str(), ABNORMAL_INTERVAL_MIN, ABNORMAL_INTERVAL_MAX, abnormalInterval_);
            return true;
        }

        abnormalInterval_ = val;
        return true;
    }

    // ignore error
    bool ArgsParser::ParseResourceList(const std::string &para)
    {
        size_t pos = para.find(",");
        if (pos == std::string::npos) {
            return true;
        }
        std::string deviceStr0 = para.substr(0, pos);
        std::string deviceStr1 = para.substr(pos + 1, para.length());
        int32_t curId = 0;
        if (!ParseDeviceId(deviceStr0, curId)) {
            return true;
        }
        resVec_.push_back(curId);
	    
        if (!ParseDeviceId(deviceStr1, curId)) {
            return true;
        }
        resVec_.push_back(curId);
        return true;
    }

    // ignore error
    bool ArgsParser::ParseDeviceIdsList(const std::string &para)
    {
        std::istringstream issStr(para);
        std::string idStr;
        int32_t curId = 0;
        while (std::getline(issStr, idStr, ',')) {
            if (!ParseDeviceId(idStr, curId)) {
                return true;
            }
            devIdVec_.push_back(curId);
        }
        return true;
    }

    std::string ArgsParser::GetParaParsedStr()
    {
        std::ostringstream oss;
        oss << "deviceId=" <<  deviceId_ << ", hostPid=" << hostPid_ << ", pidSign=" << pidSign_
            << ", vfId=" << vfId_ << ", logLevel=" << logLevel_ << ", eventLevel_=" << eventLevel_
            << ", aicpulogLevel=" << aicpulogLevel_ << ", deployMode_=" << static_cast<uint32_t>(deployMode_)
            << ", reschedInterval_=" << reschedInterval_ << ", groupName_=" << groupName_
            << ", schedPolicy_=" << schedPolicy_ << ", starter_=" << static_cast<uint32_t>(starter_)
            << ", profCfgData_=" << profCfgData_ << ", profFlag_=" << profFlag_
            << ", abnormalInterval_=" << abnormalInterval_ << ", withDeviceId_=" << withDeviceId_
            << ", withHostPid_=" << withHostPid_ << ", withPidSign_=" << withPidSign_
            << ", withVfId_=" << profCfgData_ << ", withLogLevel_=" << withLogLevel_
            << ", withGroupName_=" << withGroupName_ << ", withStarter_=" << withStarter_;

        return oss.str();
    }
}
