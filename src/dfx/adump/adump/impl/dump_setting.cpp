/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <unordered_map>
#include "dump_setting.h"
#include "log/hdc_log.h"
#include "sys_utils.h"
#include "str_utils.h"
#include "common_utils.h"
#include "adump_api.h"

namespace Adx {
namespace {
constexpr char CONF_DUMP_STATUS_ON[] = "on";
constexpr char CONF_DUMP_STATUS_OFF[] = "off";
constexpr char CONF_DUMP_STATUS_ON_CAPITAL[] = "ON";
constexpr char CONF_DUMP_STATUS_OFF_CAPITAL[] = "OFF";

constexpr char CONF_DUMP_MODE_INPUT[] = "input";
constexpr char CONF_DUMP_MODE_OUTPUT[] = "output";
constexpr char CONF_DUMP_MODE_ALL[] = "all";
}  // namespace

int32_t DumpSetting::Init(const DumpType type, const DumpConfig &dumpConfig)
{
    if (type == DumpType::OPERATOR) {
        return DumpOperatorInit(dumpConfig);
    } else if (type == DumpType::OP_OVERFLOW) {
        return DumpOverflowInit(dumpConfig);
    } else {
        IDE_LOGE("Dump type(%d) is not valid.", static_cast<int32_t>(type));
    }

    return ADUMP_FAILED;
}

int32_t DumpSetting::DumpOperatorInit(const DumpConfig &dumpConfig)
{
    if (!InitDumpStatus(dumpConfig.dumpStatus, dumpStatus_)) {
        IDE_LOGE("Dump status(%s) is not valid.", dumpConfig.dumpStatus.c_str());
        return ADUMP_FAILED;
    }

    // if disable dump, just return.
    if (!dumpStatus_) {
        return ADUMP_SUCCESS;
    }

    if (!InitDumpMode(dumpConfig.dumpMode)) {
        IDE_LOGE("Dump mode(%s) is not valid.", dumpConfig.dumpMode.c_str());
        return ADUMP_FAILED;
    }

    if (!InitDumpPath(dumpConfig.dumpPath)) {
        IDE_LOGE("Dump path(%s) is not valid.", dumpConfig.dumpPath.c_str());
        return ADUMP_FAILED;
    }

    InitDumpData(dumpConfig.dumpData);

    InitDumpSwitch(dumpConfig.dumpSwitch & DUMP_SWITCH_MASK);

    if (!InitDumpStatsItem(dumpConfig.dumpStatsItem)) {
        IDE_LOGE("Dump stats config check failed.");
        return ADUMP_FAILED;
    }
    if (!AdumpDsmi::DrvGetPlatformType(platformType_)) {
        IDE_LOGE("Get platform type failed.");
        return ADUMP_FAILED;
    }
    IDE_LOGD("DumpOperatorInit finished.");
    return ADUMP_SUCCESS;
}

int32_t DumpSetting::DumpOverflowInit(const DumpConfig &dumpConfig)
{
    if (!InitDumpStatus(dumpConfig.dumpStatus, dumpDebugStatus_)) {
        IDE_LOGE("Dump status(%s) is not valid.", dumpConfig.dumpStatus.c_str());
        return ADUMP_FAILED;
    }

    // Non-Zero when enable, Zero when disable(dumpDebug is converted to be dumpStatus when convert dump config)
    if (dumpConfig.dumpSwitch != 0) {
        dumpDebugStatus_ = true;
    }

    // if disable dump, just return.
    if (!dumpDebugStatus_) {
        return ADUMP_SUCCESS;
    }

    if (!InitDumpMode(CONF_DUMP_MODE_ALL)) {
        IDE_LOGE("Dump mode(%s) is not valid.", dumpConfig.dumpMode.c_str());
        return ADUMP_FAILED;
    }

    if (!InitDumpPath(dumpConfig.dumpPath)) {
        IDE_LOGE("Dump path(%s) is not valid.", dumpConfig.dumpPath.c_str());
        return ADUMP_FAILED;
    }

    InitDumpSwitch(dumpConfig.dumpSwitch & DUMP_SWITCH_MASK);
    IDE_LOGD("DumpOverflowInit finished.");
    return ADUMP_SUCCESS;
}

std::string DumpSetting::GetDumpPath() const
{
    return dumpPath_.GetString();
}

const char* DumpSetting::GetDumpCPath() const
{
    return dumpPath_.Empty() ? nullptr : dumpPath_.GetCString();
}

uint32_t DumpSetting::GetDumpMode() const
{
    return dumpMode_;
}

bool DumpSetting::GetDumpStatus() const
{
    if (dumpStatus_) {
        return ((dumpSwitch_ & OPERATOR_KERNEL_DUMP) != 0);
    }
    return dumpStatus_;
}

bool DumpSetting::GetDumpDebugStatus() const
{
    return dumpDebugStatus_;
}

const std::string DumpSetting::GetDumpData() const
{
    return dumpData_;
}

uint64_t DumpSetting::GetDumpSwitch() const
{
    return dumpSwitch_;
}

uint64_t DumpSetting::GetDumpStatsItem() const
{
    return dumpStatsItem_;
}

PlatformType DumpSetting::GetPlatformType() const
{
    return static_cast<PlatformType>(platformType_);
}

bool DumpSetting::InitDumpStatus(const std::string &dumpStatus, bool &status) const
{
    static const std::map<std::string, bool> DUMP_STATUS_MAP = { { CONF_DUMP_STATUS_ON, true },
                                                                 { CONF_DUMP_STATUS_ON_CAPITAL, true },
                                                                 { CONF_DUMP_STATUS_OFF_CAPITAL, false },
                                                                 { CONF_DUMP_STATUS_OFF, false } };

    auto it = DUMP_STATUS_MAP.find(dumpStatus);
    if (it == DUMP_STATUS_MAP.cend()) {
        return false;
    }

    status = it->second;
    return true;
}

bool DumpSetting::InitDumpMode(const std::string &dumpMode)
{
    static const std::map<std::string, uint32_t> DUMP_MODE_MAP = {
        { CONF_DUMP_MODE_INPUT, DUMP_MODE_INPUT },
        { CONF_DUMP_MODE_OUTPUT, DUMP_MODE_OUTPUT },
        { CONF_DUMP_MODE_ALL, DUMP_MODE_INPUT | DUMP_MODE_OUTPUT | DUMP_MODE_WORKSPACE }
    };

    auto it = DUMP_MODE_MAP.find(dumpMode);
    if (it == DUMP_MODE_MAP.cend()) {
        return false;
    }
    dumpMode_ = it->second;
    return true;
}

bool DumpSetting::InitDumpPath(const std::string &dumpPath)
{
    if (dumpPath.empty()) {
        IDE_LOGE("Dump path is empty.");
        return false;
    }

    dumpPath_ = Path(dumpPath).Append(SysUtils::GetCurrentTime());
    IDE_LOGI("Init dump path: %s", dumpPath_.GetString().c_str());
    return true;
}

void DumpSetting::InitDumpData(const std::string &dumpData)
{
    if (StrUtils::Trim(dumpData).compare(DUMP_STATS_DATA) == 0) {
        dumpData_ = DUMP_STATS_DATA;
    } else {
        dumpData_ = DUMP_TENSOR_DATA;
    }
}

bool DumpSetting::InitDumpStatsItem(const std::vector<std::string> &dumpStatsItem)
{
    const std::unordered_map<std::string, uint64_t> statsItemMap = {
        {"Max", DUMP_STATS_MAX},
        {"Min", DUMP_STATS_MIN},
        {"Avg", DUMP_STATS_AVG},
        {"Nan", DUMP_STATS_NAN},
        {"Negative Inf", DUMP_STATS_NEG_INF},
        {"Positive Inf", DUMP_STATS_POS_INF},
        {"L2norm", DUMP_STATS_L2NORM}
    };
    if (dumpStatsItem.empty()) {
        dumpStatsItem_ |= DUMP_STATS_MAX | DUMP_STATS_MIN | DUMP_STATS_AVG | DUMP_STATS_NAN | DUMP_STATS_NEG_INF |
            DUMP_STATS_POS_INF;
        IDE_LOGI("Dump stats set to default configuration[0x%llx].", dumpStatsItem_);
        return true;
    }
    for (auto &str : dumpStatsItem) {
        auto it = statsItemMap.find(StrUtils::Trim(str));
        if (it != statsItemMap.cend()) {
            dumpStatsItem_ |= it->second;
        } else {
            std::vector<std::string> keysVector;
            for (auto const& element : statsItemMap) {
                keysVector.push_back(element.first);
            }
            IDE_LOGE("Dump stats config[%s] is invalid, and expected %s.", str.c_str(),
                StrUtils::ToString(keysVector).c_str());
            return false;
        }
    }
    IDE_LOGI("Dump stats set configuration[0x%llx].", dumpStatsItem_);
    return true;
}

void DumpSetting::InitDumpSwitch(uint64_t dumpSwitch)
{
    dumpSwitch_ = dumpSwitch;
}

}  // namespace Adx