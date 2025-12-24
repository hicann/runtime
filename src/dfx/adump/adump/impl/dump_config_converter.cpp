/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <set>
#include <string>
#include <mutex>
#include <vector>
#include <cctype>
#include <cstdint>
#include <sstream>
#include "log/adx_log.h"
#include "common/file_utils.h"
#include "common/str_utils.h"
#include "adump_api.h"
#include "adump_pub.h"
#include "adump_error_manager.h"
#include "dump_config_converter.h"
#include "common/json_parser.h"

namespace Adx {
constexpr int32_t DECIMAL = 10;
const std::map<std::string, std::set<std::string>> dumpValidOptions = {
    {ADUMP_DUMP_MODE, {ADUMP_DUMP_MODE_INPUT, ADUMP_DUMP_MODE_OUTPUT, ADUMP_DUMP_MODE_ALL}},
    {ADUMP_DUMP_DATA, {ADUMP_DUMP_DATA_TENSOR, ADUMP_DUMP_DATA_STATS}},
    {ADUMP_DUMP_OP_SWITCH, {ADUMP_DUMP_STATUS_SWITCH_ON, ADUMP_DUMP_STATUS_SWITCH_OFF}},
    {ADUMP_DUMP_LEVEL, {ADUMP_DUMP_LEVEL_OP, ADUMP_DUMP_LEVEL_KERNEL, ADUMP_DUMP_LEVEL_ALL}},
    {ADUMP_DUMP_DEBUG, {ADUMP_DUMP_STATUS_SWITCH_ON, ADUMP_DUMP_STATUS_SWITCH_OFF}},
    {ADUMP_DUMP_SCENE, {ADUMP_DUMP_LITE_EXCEPTION,
                        ADUMP_DUMP_EXCEPTION_AIC_ERR_BRIEF,
                        ADUMP_DUMP_EXCEPTION_AIC_ERR_NORM,
                        ADUMP_DUMP_EXCEPTION_AIC_ERR_DETAIL,
                        ADUMP_DUMP_WATCHER}},
};

static void from_json(const nlohmann::json &js, RawDumpConfig &config)
{
    if (JsonParser::ContainKey(js, ADUMP_DUMP_PATH)) {
        config.dumpPath = JsonParser::GetCfgStrByKey(js, ADUMP_DUMP_PATH);
    }
    if (JsonParser::ContainKey(js, ADUMP_DUMP_MODE)) {
        config.dumpMode = JsonParser::GetCfgStrByKey(js, ADUMP_DUMP_MODE);
    } else {
        config.dumpMode = ADUMP_DUMP_MODE_OUTPUT;
    }
    if (JsonParser::ContainKey(js, ADUMP_DUMP_OP_SWITCH)) {
        config.dumpOpSwitch = JsonParser::GetCfgStrByKey(js, ADUMP_DUMP_OP_SWITCH);
    } else {
        config.dumpOpSwitch = ADUMP_DUMP_STATUS_SWITCH_OFF;
    }
    config.dumpDebug = ADUMP_DUMP_STATUS_SWITCH_OFF;
    if (JsonParser::ContainKey(js, ADUMP_DUMP_DEBUG)) {
        config.dumpDebug = JsonParser::GetCfgStrByKey(js, ADUMP_DUMP_DEBUG);
    }
    config.dumpScene.clear();
    if (JsonParser::ContainKey(js, ADUMP_DUMP_SCENE)) {
        config.dumpScene = JsonParser::GetCfgStrByKey(js, ADUMP_DUMP_SCENE);
    }
    if (JsonParser::ContainKey(js, ADUMP_DUMP_DATA)) {
        config.dumpData = JsonParser::GetCfgStrByKey(js, ADUMP_DUMP_DATA);
    }
    if (JsonParser::ContainKey(js, ADUMP_DUMP_LEVEL)) {
        config.dumpLevel = JsonParser::GetCfgStrByKey(js, ADUMP_DUMP_LEVEL);
    } else {
        config.dumpLevel = ADUMP_DUMP_LEVEL_ALL;
    }
    if (JsonParser::ContainKey(js, ADUMP_DUMP_STATS)) {
        config.dumpStats = js.at(ADUMP_DUMP_STATS).get<std::vector<std::string>>();
    }
}

static void from_json(const nlohmann::json &js, OpNameRange &range)
{
    if (JsonParser::ContainKey(js, ADUMP_DUMP_OPNAME_RANGE_BEGIN)) {
        range.begin = js.at(ADUMP_DUMP_OPNAME_RANGE_BEGIN).get<std::string>();
    }
    if (JsonParser::ContainKey(js, ADUMP_DUMP_OPNAME_RANGE_END)) {
        range.end = js.at(ADUMP_DUMP_OPNAME_RANGE_END).get<std::string>();
    }
}
 
static void from_json(const nlohmann::json &js, AclDumpBlacklist &blacklist)
{
    if (JsonParser::ContainKey(js, ADUMP_DUMP_BLACKLIST_NAME)) {
        blacklist.name = JsonParser::GetCfgStrByKey(js, ADUMP_DUMP_BLACKLIST_NAME);
    }
    if (JsonParser::ContainKey(js, ADUMP_DUMP_BLACKLIST_POS)) {
        blacklist.pos = js.at(ADUMP_DUMP_BLACKLIST_POS).get<std::vector<std::string>>();
    }
}
 
static void from_json(const nlohmann::json &js, AclModelDumpConfig &info)
{
    info.isLayer = false;
    if (JsonParser::ContainKey(js, ADUMP_DUMP_MODEL_NAME)) {
        info.modelName = JsonParser::GetCfgStrByKey(js, ADUMP_DUMP_MODEL_NAME);
        info.isModelName = true;
    }
    if (JsonParser::ContainKey(js, ADUMP_DUMP_LAYER)) {
        info.layer = js.at(ADUMP_DUMP_LAYER).get<std::vector<std::string>>();
        info.isLayer = true;
    }
    if (JsonParser::ContainKey(js, ADUMP_DUMP_WATCHER_NODES)) {
        info.watcherNodes = js.at(ADUMP_DUMP_WATCHER_NODES).get<std::vector<std::string>>();
    }
    if (JsonParser::ContainKey(js, ADUMP_DUMP_OPTYPE_BLACKLIST)) {
        info.optypeBlacklist = js.at(ADUMP_DUMP_OPTYPE_BLACKLIST).get<std::vector<AclDumpBlacklist>>();
    }
    if (JsonParser::ContainKey(js, ADUMP_DUMP_OPNAME_BLACKLIST)) {
        info.opnameBlacklist = js.at(ADUMP_DUMP_OPNAME_BLACKLIST).get<std::vector<AclDumpBlacklist>>();
    }
    if (JsonParser::ContainKey(js, ADUMP_DUMP_OPNAME_RANGE)) {
        info.dumpOpNameRanges = js.at(ADUMP_DUMP_OPNAME_RANGE).get<std::vector<OpNameRange>>();
    }
}

bool DumpConfigConverter::IsValidDumpConfig() const
{
    // exception dump, check if dump_scene exists
    std::string dumpScene;
    if (!CheckDumpScene(dumpScene)) {
        return false;
    }
    std::string dumpMode;
    if (!CheckDumpMode(dumpMode)) {
        return false;
    }
    
    if ((dumpMode != ADUMP_DUMP_MODE_OUTPUT) && (dumpScene == ADUMP_DUMP_WATCHER)) {
        IDE_LOGE("dump_mode only supports output when dump_scene is %s.", dumpScene.c_str());
        return false;
    }

    if (!dumpScene.empty() && ((dumpScene != ADUMP_DUMP_WATCHER) ||
                               (dumpScene == ADUMP_DUMP_WATCHER && dumpMode == ADUMP_DUMP_MODE_OUTPUT))) {
        return true;
    }

    if (!CheckDumpPath()) {
        return false;
    }

    // overflow dump, check if dump_debug exists
    std::string dumpDebug;
    if (!CheckDumpDebug(dumpDebug)) {
        return false;
    }
    if (dumpDebug == ADUMP_DUMP_STATUS_SWITCH_ON) {
        return true;
    }

    // data dump, check if dump_data is valid
    if (!CheckValueValidIfContain(ADUMP_DUMP_DATA)) {
        return false;
    }
    // options of data dump
    if (!CheckValueValidIfContain(ADUMP_DUMP_MODE) ||
        !CheckValueValidIfContain(ADUMP_DUMP_LEVEL) ||
        !CheckValueValidIfContain(ADUMP_DUMP_OP_SWITCH)) {
        return false;
    }

    std::string dumpLevel;
    if (JsonParser::ContainKey(dumpJs_, ADUMP_DUMP_LEVEL)) {
        dumpLevel = JsonParser::GetCfgStrByKey(dumpJs_, ADUMP_DUMP_LEVEL);
    }
    else {
        dumpLevel = ADUMP_DUMP_LEVEL_ALL;
    }
 
    if ((dumpLevel != ADUMP_DUMP_LEVEL_OP) &&
        (dumpLevel != ADUMP_DUMP_LEVEL_KERNEL) &&
        (dumpLevel != ADUMP_DUMP_LEVEL_ALL)) {
        IDE_LOGE("[Check][dumpLevel]dump_level value[%s] error in config, only supports "
                      "op/kernel/all",
                      dumpLevel.c_str());
        return false;
    }
 
    if (!CheckDumpStep()) {
        return false;
    }
 
    if (!CheckDumplist(dumpLevel)) {
        return false;
    }

    if (!CheckDumpStats()) {
        return false;
    };
    return true;
}

bool DumpConfigConverter::CheckDumpScene(std::string &dumpScene) const
{
    if (!JsonParser::ContainKey(dumpJs_, ADUMP_DUMP_SCENE)){
        IDE_LOGI("dump_scene does not exist, no need to check.");
        return true;
    }
    dumpScene = JsonParser::GetCfgStrByKey(dumpJs_, ADUMP_DUMP_SCENE);
    if (!IsValueValid(ADUMP_DUMP_SCENE, dumpScene)) {
        return false;
    }
    if (ConflictWith(ADUMP_DUMP_DEBUG, ADUMP_DUMP_STATUS_SWITCH_ON)){
        IDE_LOGE("dump_scene is %s when dump_debug is on is unsupported.", dumpScene.c_str());
        return false;
    }
    if (ConflictWith(ADUMP_DUMP_OP_SWITCH, ADUMP_DUMP_STATUS_SWITCH_ON)){
        IDE_LOGE("dump_scene is %s when dump_op_switch is on is unsupported.", dumpScene.c_str());
        return false;
    }
    return true;
}

bool DumpConfigConverter::CheckDumpMode(std::string &dumpMode) const
{
    if (!JsonParser::ContainKey(dumpJs_, ADUMP_DUMP_MODE)){
        IDE_LOGI("dump_mode does not exist, no need to check.");
        return true;
    }
    dumpMode = JsonParser::GetCfgStrByKey(dumpJs_, ADUMP_DUMP_MODE);
    if (!IsValueValid(ADUMP_DUMP_MODE, dumpMode)) {
        return false;
    }
    return true;
}

bool DumpConfigConverter::CheckDumpDebug(std::string &dumpDebug) const
{
    if (!JsonParser::ContainKey(dumpJs_, ADUMP_DUMP_DEBUG)) {
        return true;
    }
    dumpDebug = JsonParser::GetCfgJsonByKey(dumpJs_, ADUMP_DUMP_DEBUG);
    if (dumpDebug == ADUMP_DUMP_STATUS_SWITCH_OFF) {
        return true;
    }
    if (!IsValueValid(ADUMP_DUMP_DEBUG, dumpDebug)) {
        return false;
    }
    if (ConflictWith(ADUMP_DUMP_OP_SWITCH, ADUMP_DUMP_STATUS_SWITCH_ON)) {
        IDE_LOGE("dump_op_switch is %s when dump_debug is on is unsupported.",
                 ADUMP_DUMP_STATUS_SWITCH_ON.c_str());
        return false;
    }
    return true;
}

bool DumpConfigConverter::CheckDumpPath() const
{
    if (!JsonParser::ContainKey(dumpJs_, ADUMP_DUMP_PATH)) {
        ReportInvalidArgumentError(ADUMP_DUMP_PATH, "",
            StrUtils::Format(FIELD_NOT_FOUND, ADUMP_DUMP_PATH.c_str(), configPath_));
        return false;
    }
    std::string dumpPath = JsonParser::GetCfgStrByKey(dumpJs_, ADUMP_DUMP_PATH);
    if (dumpPath.empty()) {
        ReportInvalidArgumentError(ADUMP_DUMP_PATH, "",
            StrUtils::Format(FIELD_EMPTY, ADUMP_DUMP_PATH.c_str(), configPath_));
        return false;
    }
    if (dumpPath.length() > static_cast<size_t>(MAX_DUMP_PATH_LENGTH)) {
        ReportInvalidArgumentError(ADUMP_DUMP_PATH, dumpPath,
            StrUtils::Format(FIELD_TOO_LONG, ADUMP_DUMP_PATH.c_str(), configPath_, MAX_DUMP_PATH_LENGTH));
        return false;
    }
    const size_t colonPos = dumpPath.find_first_of(":");
    bool isCutDumpPathFlag = CheckIpAddress(dumpPath);
    if (isCutDumpPathFlag) {
        dumpPath = dumpPath.substr(colonPos + 1U);
        if (!FileUtils::IsValidDirChar(dumpPath)) {
            ReportInvalidArgumentError(ADUMP_DUMP_PATH, dumpPath,
                StrUtils::Format(FIELD_INVALID_CHARACTERS, dumpPath.c_str(), ADUMP_DUMP_PATH.c_str(), configPath_));
            return false;
        }
    } else {
        if (!FileUtils::IsPathHasPermission(dumpPath)) {
            ReportInvalidArgumentError(ADUMP_DUMP_PATH, dumpPath,
                StrUtils::Format(FIELD_PATH_NO_PERMISSIONS, dumpPath.c_str(), ADUMP_DUMP_PATH.c_str(), configPath_));
            return false;
        }
    }
    return true;
}

bool DumpConfigConverter::CheckDumpStep() const
{
    IDE_LOGI("start to execute CheckDumpStep");
    std::string dumpStep = "";
    if (JsonParser::ContainKey(dumpJs_, ADUMP_DUMP_STEP)) {
        dumpStep = JsonParser::GetCfgStrByKey(dumpJs_, ADUMP_DUMP_STEP);
    }
 
    if (dumpStep.empty()) {
        return true;
    }
 
    std::vector<std::string> matchVecs;
    Split(dumpStep, '|', matchVecs);
    if (matchVecs.size() > 100U) {
        IDE_LOGE("dump_step value:%s, only support dump <= 100 sets of data.", dumpStep.c_str());
        return false;
    }
 
    for (const auto &it : matchVecs) {
        std::vector<std::string> steps;
        Split(it, '-', steps);
        if (steps.size() > 2U)
        {
            IDE_LOGE("dump_step value:%s, step is not a range or a digit, correct example:'3|5-10'.",
                          dumpStep.c_str());
            return false;
        }
 
        for (const auto &step : steps) {
            if (!IsDigit(step))
            {
                IDE_LOGE("dump_step value:%s, step is not a digit, correct example:'3|5-10'.",
                              dumpStep.c_str());
                return false;
            }
        }
 
        if (std::strtol(steps[0U].c_str(), nullptr, DECIMAL) >
            std::strtol(steps[steps.size() - 1U].c_str(), nullptr, DECIMAL)) {
            IDE_LOGE("dump_step value:%s, for set of dump range, the first step > second step.",
                          dumpStep.c_str());
            return false;
        }
    }
    return true;
}
 
bool DumpConfigConverter::CheckDumplist(const std::string& dumpLevel) const
{
    IDE_LOGI("start to execute CheckDumpListValidity.");
    std::vector<AclModelDumpConfig> dumpList;
    if (JsonParser::ContainKey(dumpJs_, ADUMP_DUMP_LIST)) {
        dumpList = dumpJs_.at(ADUMP_DUMP_LIST).get<std::vector<AclModelDumpConfig>>();
    }
 
    std::string dumpOpSwitch = dumpJs_.find(ADUMP_DUMP_OP_SWITCH) != dumpJs_.end()
                                   ? JsonParser::GetCfgStrByKey(dumpJs_, ADUMP_DUMP_OP_SWITCH)
                                   : ADUMP_DUMP_STATUS_SWITCH_OFF;
    if (!CheckDumpOpSwitch(dumpOpSwitch)) {
        return false;
    }
    if (CheckEmptyDumpList(dumpList, dumpOpSwitch)) {
        return true;
    }
    if (dumpOpSwitch == ADUMP_DUMP_STATUS_SWITCH_OFF && !CheckDumpListWhenSwitchOff(dumpList)) {
        return false;
    }
 
    std::string dumpScene = JsonParser::ContainKey(dumpJs_, ADUMP_DUMP_SCENE)
                                ? JsonParser::GetCfgStrByKey(dumpJs_, ADUMP_DUMP_SCENE)
                                : "";
    if (!CheckWatcherScene(dumpList, dumpScene)) {
        return false;
    }
    if (!CheckOpBlacklistSize(dumpList)) {
        return false;
    }
    if (!CheckOpBlacklistWithDumpLevel(dumpList, dumpLevel)) {
        return false;
    }
    if (!CheckDumpOpNameRange(dumpList, dumpLevel)) {
        return false;
    }
    IDE_LOGI("end to check the validity of dump_list and dump_op_switch field.");
    return true;
}
 
bool DumpConfigConverter::CheckDumpOpSwitch(const std::string &dumpOpSwitch) const
{
    if ((dumpOpSwitch != ADUMP_DUMP_STATUS_SWITCH_ON) &&
        (dumpOpSwitch != ADUMP_DUMP_STATUS_SWITCH_OFF))
    {
        IDE_LOGE("[Check][DumpOpSwitch]dump_op_switch value[%s] is invalid in config, "
                      "only supports on/off",
                      dumpOpSwitch.c_str());
        return false;
    }
    return true;
}
 
bool DumpConfigConverter::CheckEmptyDumpList(const std::vector<AclModelDumpConfig> &dumpList,
                                             const std::string &dumpOpSwitch) const
{
    if (dumpList.empty() && dumpOpSwitch == ADUMP_DUMP_STATUS_SWITCH_OFF)
    {
        IDE_LOGI("dump list is empty and dumpOpSwitch is off");
        return true;
    }
    return false;
}
 
bool DumpConfigConverter::CheckDumpListWhenSwitchOff(const std::vector<AclModelDumpConfig> &dumpList) const
{
    if (std::none_of(dumpList.begin(), dumpList.end(), [](const AclModelDumpConfig &info)
                     { return !(info.isModelName && info.modelName.empty()) &&
                              !(info.isLayer && info.layer.empty()); }))
    {
        IDE_LOGE("[Check][ValidDumpList]dump_list is not null, but dump_list "
                      "field invalid, dump config is invalid");
        return false;
    }
    return true;
}
 
bool DumpConfigConverter::CheckWatcherScene(const std::vector<AclModelDumpConfig> &dumpList,
                                            const std::string &dumpScene) const
{
    if (dumpScene == ADUMP_DUMP_WATCHER)
    {
        for (const auto &item : dumpList)
        {
            if (item.watcherNodes.empty()) {
                IDE_LOGE("[Check][ValidDumpList]dump_list is not null, but watcher_nodes is empty "
                              "when dump_scene is %s, dump config is invalid",
                              dumpScene.c_str());
                return false;
            }
 
            if (!item.modelName.empty()) {
                IDE_LOGE("[Check][ValidDumpList]dump_list is not null, but model_name is not empty "
                              "when dump_scene is %s, dump config is invalid",
                              dumpScene.c_str());
                return false;
            }
        }
    }
 
    for (size_t i = 0U; i < dumpList.size(); ++i) {
        if ((!dumpList[i].watcherNodes.empty()) && (dumpScene != ADUMP_DUMP_WATCHER)) {
            IDE_LOGE("[Check][ValidDumpList]dump_scene must be watcher when watcher_nodes is not null");
            return false;
        }
    }
    return true;
}
 
bool DumpConfigConverter::CheckOpBlacklistSize(const std::vector<AclModelDumpConfig> &dumpList) const
{
    return std::all_of(dumpList.begin(), dumpList.end(), [](const AclModelDumpConfig &dumpModelConfig)
                       {
            if (dumpModelConfig.optypeBlacklist.size() > 100U || dumpModelConfig.opnameBlacklist.size() > 100U) {
                IDE_LOGE("[Check][ValidDumpList] size of optype_blacklist or opname_blacklist is over 100.");
                return false;
            }
            return true; });
}
 
bool DumpConfigConverter::CheckOpBlacklistWithDumpLevel(const std::vector<AclModelDumpConfig> &dumpList,
                                                        const std::string &dumpLevel) const
{
    for (const auto &config : dumpList)
    {
        bool hasBlacklist = !config.optypeBlacklist.empty() ||
                            !config.opnameBlacklist.empty();
        if (hasBlacklist && dumpLevel != "op")
        {
            IDE_LOGE("[Check][ValidDumpList] optype_blacklist or opname_blacklist is configured, "
                          "but dump_level is not 'op'");
            return false;
        }
    }
    return true;
}
 
bool DumpConfigConverter::CheckDumpOpNameRange(const std::vector<AclModelDumpConfig> &dumpConfigList,
                                               const std::string &dumpLevel) const
{
    IDE_LOGI("start to execute CheckDumpOpNameRange");
    for (const auto &dumpConfig : dumpConfigList)
    {
        if (!dumpConfig.dumpOpNameRanges.empty()) {
            if (dumpLevel != "op") {
                IDE_LOGE("[Check][ValidDumpList] dump level only support op when op name range is enable.");
                return false;
            }
 
            if (dumpConfig.modelName.empty()) {
                IDE_LOGE("[Check][ValidDumpList] model name cannot be empty when op name range is enable.");
                return false;
            }
 
            for (const auto &range : dumpConfig.dumpOpNameRanges) {
                if (range.begin.empty() || range.end.empty()) {
                    IDE_LOGE("[Check][ValidDumpList] op name range is imcomplete, op name range begin[%s] end[%s].",
                                  range.begin.c_str(), range.end.c_str());
                    return false;
                }
                IDE_LOGI("op name range begin[%s], op name range end[%s].",
                             range.begin.c_str(), range.end.c_str());
            }
        }
    }
    IDE_LOGI("successfully execute CheckDumpOpNameRange.");
    return true;
}
 
void DumpConfigConverter::Split(const std::string &str, const char delim, std::vector<std::string> &elems) const
{
    elems.clear();
    if (str.empty()) {
        elems.emplace_back("");
        return;
    }
 
    std::stringstream ss(str);
    std::string item;
 
    while (getline(ss, item, delim)) {
        elems.push_back(item);
    }
 
    const auto strSize = str.size();
    if ((strSize > 0U) && (str[strSize - 1U] == delim)) {
        elems.emplace_back("");
    }
}
 
bool DumpConfigConverter::IsDigit(const std::string &str) const
{
    if (str.empty()) {
        return false;
    }
 
    for (const char &c : str) {
        if (isdigit(static_cast<int32_t>(c)) == 0) {
            return false;
        }
    }
    return true;
}

bool DumpConfigConverter::CheckDumpStats() const
{
    if (!JsonParser::ContainKey(dumpJs_, ADUMP_DUMP_STATS)) {
        return true;
    }
    std::vector<std::string> dumpStats = dumpJs_.at(ADUMP_DUMP_STATS).get<std::vector<std::string>>();
    if (dumpStats.empty()) {
        IDE_LOGE("dump_stats exists but is empty.");
        return false;
    }
    if ((!JsonParser::ContainKey(dumpJs_, ADUMP_DUMP_DATA)) ||
        (JsonParser::GetCfgStrByKey(dumpJs_, ADUMP_DUMP_DATA) != ADUMP_DUMP_DATA_STATS)) {
        IDE_LOGE("nonsupport to enable dump_stats when dump_data is tensor.");
        return false;
    }
    return true;
}

bool DumpConfigConverter::CheckValueValidIfContain(const std::string key) const
{
    if (JsonParser::ContainKey(dumpJs_, key)) {
        return IsValueValid(key, JsonParser::GetCfgStrByKey(dumpJs_, key));
    }
    return true;
}

bool DumpConfigConverter::IsValueValid(const std::string key, const std::string value) const
{
    if (dumpValidOptions.at(key).find(value) != dumpValidOptions.at(key).end()) {
        return true;
    }
    std::string validOptionStr;
    for (auto validOption : dumpValidOptions.at(key)) {
        validOptionStr += validOption + "/";
    }
    validOptionStr.pop_back();
    ReportInvalidArgumentError(key, value,
        StrUtils::Format(FIELD_INVALID_VALUE, value.c_str(), key.c_str(), configPath_, validOptionStr.c_str()));
    return false;
}

bool DumpConfigConverter::ConflictWith(const std::string key, const std::string value) const
{
    if (!JsonParser::ContainKey(dumpJs_, key)) {
        return false;
    }
    if (JsonParser::GetCfgStrByKey(dumpJs_, key) == value) {
        return true;
    }
    return false;
};

bool DumpConfigConverter::CheckIpAddress(const std::string dumpPath) const
{
    // check the valid of ipAddress in dump_path
    const size_t colonPos = dumpPath.find_first_of(":");
    if (colonPos != std::string::npos) {
        IDE_LOGI("dump_path field contains ip address.");
        if ((colonPos + 1U) == dumpPath.size()) {
            ReportInvalidArgumentError(ADUMP_DUMP_PATH, dumpPath, StrUtils::Format(FIELD_PATH_INVALID,
                dumpPath.c_str(), ADUMP_DUMP_PATH.c_str(), configPath_, "format is illegal"));
            return false;
        }

        const std::string ipAddress = dumpPath.substr(0U, colonPos);
        const std::vector<std::string> ipRet = StrUtils::Split(ipAddress, ".");
        if (ipRet.size() == static_cast<size_t>(MAX_IPV4_ADDRESS_LENGTH)) {
            try {
                for (const std::string &ret : ipRet) {
                    const int32_t val = std::stoi(ret);
                    if ((val < 0) || (val > MAX_IPV4_ADDRESS_VALUE)) {
                        IDE_LOGD("ip address[%s] is invalid in dump_path field", ipAddress.c_str());
                        return false;
                    }
                }
            } catch (...) {
                IDE_LOGD("ip address[%s] can not convert to digital in dump_path field", ipAddress.c_str());
                return false;
            }
            IDE_LOGD("ip address[%s] is valid in dump_path field.", ipAddress.c_str());
            return true;
        }
    }

    IDE_LOGD("the dump_path field does not contain ip address or it does not comply with the ipv4 rule.");
    return false;
}

DumpConfig DumpConfigConverter::ConvertDumpConfig(const RawDumpConfig &rawDumpConfig) const
{
    DumpConfig dumpConfig;
    dumpConfig.dumpStatus = ADUMP_DUMP_STATUS_SWITCH_ON;
    dumpConfig.dumpMode = rawDumpConfig.dumpMode;
    dumpConfig.dumpPath = rawDumpConfig.dumpPath;
    dumpConfig.dumpData = rawDumpConfig.dumpData;
    if (!rawDumpConfig.dumpScene.empty()) {
        const char *ascendWorkPath = nullptr;
        MM_SYS_GET_ENV(MM_ENV_ASCEND_WORK_PATH, ascendWorkPath);
        if (ascendWorkPath != nullptr) {
            dumpConfig.dumpPath = ascendWorkPath;
        }
    }
    if (rawDumpConfig.dumpDebug == ADUMP_DUMP_STATUS_SWITCH_ON) {
        dumpConfig.dumpStatus = ADUMP_DUMP_STATUS_SWITCH_OFF;
    }
    if (rawDumpConfig.dumpLevel == ADUMP_DUMP_LEVEL_OP) {
        dumpConfig.dumpSwitch = OPERATOR_OP_DUMP;
    } else if (rawDumpConfig.dumpLevel == ADUMP_DUMP_LEVEL_KERNEL) {
        dumpConfig.dumpSwitch = OPERATOR_KERNEL_DUMP;
    } else {
        dumpConfig.dumpSwitch = OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP;
    }
    for (auto dumpStat : rawDumpConfig.dumpStats) {
        dumpConfig.dumpStatsItem.emplace_back(dumpStat);
    }
    return dumpConfig;
}

DumpType DumpConfigConverter::ConvertDumpType(const RawDumpConfig &rawDumpConfig) const
{
    if (rawDumpConfig.dumpScene == ADUMP_DUMP_EXCEPTION_AIC_ERR_BRIEF ||
        rawDumpConfig.dumpScene == ADUMP_DUMP_LITE_EXCEPTION) {
        return DumpType::ARGS_EXCEPTION;
    }
    if (rawDumpConfig.dumpScene == ADUMP_DUMP_EXCEPTION_AIC_ERR_NORM) {
        return DumpType::EXCEPTION;
    }
    if (rawDumpConfig.dumpScene == ADUMP_DUMP_EXCEPTION_AIC_ERR_DETAIL) {
        return DumpType::AIC_ERR_DETAIL_DUMP;
    }
    if (rawDumpConfig.dumpDebug == ADUMP_DUMP_STATUS_SWITCH_ON) {
        return DumpType::OP_OVERFLOW;
    }
    return DumpType::OPERATOR;
}

bool DumpConfigConverter::NeedDump(const RawDumpConfig &rawDumpConfig) const
{
    if (dumpJs_.contains("dump_list") && dumpJs_["dump_list"].is_array() && !dumpJs_["dump_list"].empty())
    {
        IDE_LOGI("Dump list size: %zu", dumpJs_["dump_list"].size());
        return true;
    }  
    IDE_LOGI("Dump list is not an array or does not exist.");
    if ((rawDumpConfig.dumpOpSwitch == ADUMP_DUMP_STATUS_SWITCH_ON) ||
        (rawDumpConfig.dumpDebug == ADUMP_DUMP_STATUS_SWITCH_ON) ||
        (!rawDumpConfig.dumpScene.empty())) {
        return true;
    }
    IDE_LOGI("No dump config need to be set.");
    return false;
}

int32_t DumpConfigConverter::Convert(DumpType &dumpType, DumpConfig &dumpConfig, bool &needDump)
{
    nlohmann::json js;
    int32_t ret = JsonParser::ParseJsonFromMemory(dumpConfigData_, dumpConfigSize_, js);
    if (ret != ADUMP_SUCCESS) {
        return ADUMP_FAILED;
    }
    try {
        if (!JsonParser::ContainKey(js, ADUMP_DUMP)) {
            needDump = false;
            IDE_LOGI("No need to dump because no dump key in config file.");
            return ADUMP_SUCCESS;
        }
        dumpJs_ = js.at(ADUMP_DUMP);
        if (!IsValidDumpConfig()) {
            return ADUMP_FAILED;
        }
        RawDumpConfig rawDumpConfig = js.at(ADUMP_DUMP);
        if (!NeedDump(rawDumpConfig)) {
            needDump = false;
            IDE_LOGI("No need to dump anything after check dump config.");
            return ADUMP_SUCCESS;
        }
        dumpConfig = ConvertDumpConfig(rawDumpConfig);
        dumpType = ConvertDumpType(rawDumpConfig);
        needDump = true;
        IDE_LOGI("Success to convert dumpType[%d], dumpPath[%s], dumpMode[%s], dumpStatus[%s], dumpData[%s], dumpSwitch[%ld]",
            dumpType, dumpConfig.dumpPath.c_str(), dumpConfig.dumpMode.c_str(), dumpConfig.dumpStatus.c_str(), dumpConfig.dumpData.c_str(),
            dumpConfig.dumpSwitch
        );
    } catch (const nlohmann::json::exception &e) {
        ReportConfigParseError(StrUtils::Format(MEMORY_JSON_PARSE_FAILED, e.what()));
        return ADUMP_FAILED;
    }
    return ADUMP_SUCCESS;
}

bool DumpConfigConverter::EnabledExceptionWithEnv(DumpConfig &dumpConfig)
{
    // Enable L1 exception dump with Env[NPU_COLLECT_PATH/NPU_COLLECT_PATH_EXE]
    const char *npuCollectPath = nullptr;
    MM_SYS_GET_ENV(MM_ENV_NPU_COLLECT_PATH, npuCollectPath);
    if (npuCollectPath == nullptr) {
        MM_SYS_GET_ENV(MM_ENV_NPU_COLLECT_PATH_EXE, npuCollectPath);
    }
    if (npuCollectPath != nullptr && npuCollectPath[0] != '\0') {
        dumpConfig.dumpPath = npuCollectPath;
        dumpConfig.dumpStatus = "on";
        IDE_LOGI("Get NPU_COLLECT_PATH: %s.", dumpConfig.dumpPath.c_str());
        return true;
    }
    return false;
}

}  // namespace Adx