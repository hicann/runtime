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
#include "common/path.h"

namespace Adx {
constexpr int32_t DECIMAL = 10;
const std::map<std::string, std::set<std::string>> dumpValidOptions = {
    {ADUMP_DUMP_MODE, {ADUMP_DUMP_MODE_INPUT, ADUMP_DUMP_MODE_OUTPUT, ADUMP_DUMP_MODE_ALL}},
    {ADUMP_DUMP_DATA, {ADUMP_DUMP_DATA_TENSOR, ADUMP_DUMP_DATA_STATS}},
    {ADUMP_DUMP_KERNEL_DATA, {ADUMP_DUMP_KERNEL_DATA_ALL, ADUMP_DUMP_KERNEL_DATA_PRINTF,
                              ADUMP_DUMP_KERNEL_DATA_TENSOR, ADUMP_DUMP_KERNEL_DATA_ASSERT,
                              ADUMP_DUMP_KERNEL_DATA_TIMESTAMP}},
    {ADUMP_DUMP_OP_SWITCH, {ADUMP_DUMP_STATUS_SWITCH_ON, ADUMP_DUMP_STATUS_SWITCH_OFF}},
    {ADUMP_DUMP_LEVEL, {ADUMP_DUMP_LEVEL_OP, ADUMP_DUMP_LEVEL_KERNEL, ADUMP_DUMP_LEVEL_ALL}},
    {ADUMP_DUMP_DEBUG, {ADUMP_DUMP_STATUS_SWITCH_ON, ADUMP_DUMP_STATUS_SWITCH_OFF}},
    {ADUMP_DUMP_SCENE, {ADUMP_DUMP_LITE_EXCEPTION,
                        ADUMP_DUMP_EXCEPTION_AIC_ERR_BRIEF,
                        ADUMP_DUMP_EXCEPTION_AIC_ERR_NORM,
                        ADUMP_DUMP_EXCEPTION_AIC_ERR_DETAIL,
                        ADUMP_DUMP_WATCHER}},
    {ADUMP_DUMP_STATS, {ADUMP_DUMP_STATS_MAX, ADUMP_DUMP_STATS_MIN, ADUMP_DUMP_STATS_AVG,
                        ADUMP_DUMP_STATS_NAN, ADUMP_DUMP_STATS_NEG_INF,
                        ADUMP_DUMP_STATS_POS_INF, ADUMP_DUMP_STATS_L2NORM}},
};

const std::set<std::string> envDumpScenes = {
    ADUMP_DUMP_EXCEPTION_AIC_ERR_BRIEF,
    ADUMP_DUMP_EXCEPTION_AIC_ERR_NORM,
    ADUMP_DUMP_EXCEPTION_AIC_ERR_DETAIL
};

static void from_json(const nlohmann::json &js, RawDumpConfig &config)
{
    JsonParser::GetStringIfExist(js, ADUMP_DUMP_PATH, config.dumpPath);
    config.dumpMode = JsonParser::GetStringOrDefault(js, ADUMP_DUMP_MODE, ADUMP_DUMP_MODE_OUTPUT);
    config.dumpOpSwitch = JsonParser::GetStringOrDefault(js, ADUMP_DUMP_OP_SWITCH, ADUMP_DUMP_STATUS_SWITCH_OFF);
    config.dumpDebug = JsonParser::GetStringOrDefault(js, ADUMP_DUMP_DEBUG, ADUMP_DUMP_STATUS_SWITCH_OFF);
    JsonParser::GetStringIfExist(js, ADUMP_DUMP_SCENE, config.dumpScene);
    JsonParser::GetStringIfExist(js, ADUMP_DUMP_DATA, config.dumpData);
    config.dumpKernelData = JsonParser::GetStringOrDefault(js, ADUMP_DUMP_KERNEL_DATA, ADUMP_DUMP_KERNEL_DATA_ALL);
    config.dumpLevel = JsonParser::GetStringOrDefault(js, ADUMP_DUMP_LEVEL, ADUMP_DUMP_LEVEL_ALL);
    if (JsonParser::ContainKey(js, ADUMP_DUMP_STATS)) {
        config.dumpStats = js.at(ADUMP_DUMP_STATS).get<std::vector<std::string>>();
    }
}

static void from_json(const nlohmann::json &js, OpNameRange &range)
{
    JsonParser::GetStringIfExist(js, ADUMP_DUMP_OPNAME_RANGE_BEGIN, range.begin);
    JsonParser::GetStringIfExist(js, ADUMP_DUMP_OPNAME_RANGE_END, range.end);
}

static void from_json(const nlohmann::json &js, AclDumpBlacklist &blacklist)
{
    JsonParser::GetStringIfExist(js, ADUMP_DUMP_BLACKLIST_NAME, blacklist.name);
    if (JsonParser::ContainKey(js, ADUMP_DUMP_BLACKLIST_POS)) {
        blacklist.pos = js.at(ADUMP_DUMP_BLACKLIST_POS).get<std::vector<std::string>>();
    }
}

static void from_json(const nlohmann::json &js, AclModelDumpConfig &info)
{
    info.isLayer = false;
    if (JsonParser::GetStringIfExist(js, ADUMP_DUMP_MODEL_NAME, info.modelName)) {
        info.isModelName = true;
    }
    if (JsonParser::ContainKey(js, ADUMP_DUMP_LAYER)) {
        info.layer = js.at(ADUMP_DUMP_LAYER).get<std::vector<std::string>>();
        info.isLayer = true;
    }
    if (JsonParser::ContainKey(js, ADUMP_DUMP_WATCHER_NODES)) {
        info.watcherNodes = js.at(ADUMP_DUMP_WATCHER_NODES).get<std::vector<std::string>>();
        info.isWatcherNodes = true;
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

std::string DumpConfigConverter::BuildIndexedPath(const std::string &base, size_t index) const
{
    return base + "[" + std::to_string(index) + "]";
}

std::string DumpConfigConverter::BuildPath(const std::string &base, const std::string &key) const
{
    return base.empty() ? key : base + "." + key;
}

bool DumpConfigConverter::CheckDumpFieldTypes() const
{
    const std::vector<std::string> stringFields = {
        ADUMP_DUMP_PATH, ADUMP_DUMP_MODE, ADUMP_DUMP_OP_SWITCH, ADUMP_DUMP_LEVEL, ADUMP_DUMP_SCENE,
        ADUMP_DUMP_DATA, ADUMP_DUMP_DEBUG, ADUMP_DUMP_KERNEL_DATA, ADUMP_DUMP_STEP
    };
    
    for (const auto &field : stringFields) {
        if (!CheckStringField(dumpJs_, field, "")) {
            return false;
        }
    }
    
    if (JsonParser::ContainKey(dumpJs_, ADUMP_DUMP_STATS)) {
        std::string fieldPath = ADUMP_DUMP_STATS;
        if (!CheckArrayOfString(dumpJs_.at(ADUMP_DUMP_STATS), fieldPath)) {
            return false;
        }
    }
    
    if (JsonParser::ContainKey(dumpJs_, ADUMP_DUMP_LIST)) {
        if (!CheckDumpListFieldTypes()) {
            return false;
        }
    }
    
    return true;
}

bool DumpConfigConverter::CheckStringField(const nlohmann::json &js, const std::string &key,
    const std::string &basePath) const
{
    if (!JsonParser::ContainKey(js, key)) {
        return true;
    }
    
    std::string fieldPath = BuildPath(basePath, key);
    if (!js.at(key).is_string()) {
        REPORT_EP0001_ITEM_ERROR("CheckFieldValue", fieldPath, ADUMP_REASON_ITEM_MUST_BE_STRING, configPath_);
        return false;
    }
    
    return true;
}

bool DumpConfigConverter::CheckDumpFieldValues() const
{
    const std::vector<std::string> singleValueFields = {
        ADUMP_DUMP_MODE, ADUMP_DUMP_DATA, ADUMP_DUMP_OP_SWITCH, ADUMP_DUMP_LEVEL, ADUMP_DUMP_DEBUG, ADUMP_DUMP_SCENE
    };
    
    for (const auto &field : singleValueFields) {
        if (!CheckFieldValue(dumpJs_, field)) {
            return false;
        }
    }
    
    std::string kernelData;
    if (JsonParser::GetStringIfExist(dumpJs_, ADUMP_DUMP_KERNEL_DATA, kernelData)) {
        if (!CheckKernelDataValues(kernelData)) {
            return false;
        }
    }
    
    if (JsonParser::ContainKey(dumpJs_, ADUMP_DUMP_STATS)) {
        if (!CheckDumpStatsValues()) {
            return false;
        }
    }
    
    return true;
}

bool DumpConfigConverter::CheckFieldValue(const nlohmann::json &js, const std::string &key) const
{
    std::string value;
    if (JsonParser::GetStringIfExist(js, key, value)) {
        return IsValueValid(key, value);
    }

    return true;
}

bool DumpConfigConverter::CheckKernelDataValues(const std::string &kernelData) const
{
    std::vector<std::string> dfxTypes;
    Split(kernelData, ',', dfxTypes);
    
    for (const auto &dfxType : dfxTypes) {
        if (!IsValueValid(ADUMP_DUMP_KERNEL_DATA, dfxType)) {
            return false;
        }
    }

    return true;
}

bool DumpConfigConverter::CheckDumpStatsValues() const
{
    const auto &statsArray = dumpJs_.at(ADUMP_DUMP_STATS);
    
    for (size_t i = 0; i < statsArray.size(); ++i) {
        std::string statValue = statsArray[i].get<std::string>();
        std::string indexedPath = BuildIndexedPath(ADUMP_DUMP_STATS, i);
        if (!IsValueValid(ADUMP_DUMP_STATS, statValue, indexedPath)) {
            return false;
        }
    }
    
    return true;
}

bool DumpConfigConverter::CheckDumpListFieldTypes() const
{
    const auto &dumpListArray = dumpJs_.at(ADUMP_DUMP_LIST);
    if (!dumpListArray.is_array()) {
        REPORT_EP0001_ITEM_ERROR("CheckDumpListFieldTypes", ADUMP_DUMP_LIST,
            ADUMP_REASON_ITEM_MUST_BE_ARRAY, configPath_);
        return false;
    }
    
    for (size_t i = 0; i < dumpListArray.size(); ++i) {
        std::string itemPath = BuildIndexedPath(ADUMP_DUMP_LIST, i);
        if (!dumpListArray[i].is_object()) {
            REPORT_EP0001_ITEM_ERROR("CheckDumpListFieldTypes", itemPath,
                ADUMP_REASON_ITEM_MUST_BE_OBJECT, configPath_);
            return false;
        }
        if (!CheckDumpListItemFieldTypes(dumpListArray[i], itemPath)) {
            return false;
        }
    }
    return true;
}

bool DumpConfigConverter::CheckDumpListItemFieldTypes(const nlohmann::json &item, const std::string &basePath) const
{
    if (!CheckStringField(item, ADUMP_DUMP_MODEL_NAME, basePath)) {
        return false;
    }
    
    if (JsonParser::ContainKey(item, ADUMP_DUMP_LAYER)) {
        std::string fieldPath = BuildPath(basePath, ADUMP_DUMP_LAYER);
        if (!CheckArrayOfString(item.at(ADUMP_DUMP_LAYER), fieldPath)) {
            return false;
        }
    }
    
    if (JsonParser::ContainKey(item, ADUMP_DUMP_WATCHER_NODES)) {
        std::string fieldPath = BuildPath(basePath, ADUMP_DUMP_WATCHER_NODES);
        if (!CheckArrayOfString(item.at(ADUMP_DUMP_WATCHER_NODES), fieldPath)) {
            return false;
        }
    }
    
    if (JsonParser::ContainKey(item, ADUMP_DUMP_OPTYPE_BLACKLIST)) {
        std::string fieldPath = BuildPath(basePath, ADUMP_DUMP_OPTYPE_BLACKLIST);
        if (!CheckBlacklistFieldTypes(item.at(ADUMP_DUMP_OPTYPE_BLACKLIST), fieldPath)) {
            return false;
        }
    }
    
    if (JsonParser::ContainKey(item, ADUMP_DUMP_OPNAME_BLACKLIST)) {
        std::string fieldPath = BuildPath(basePath, ADUMP_DUMP_OPNAME_BLACKLIST);
        if (!CheckBlacklistFieldTypes(item.at(ADUMP_DUMP_OPNAME_BLACKLIST), fieldPath)) {
            return false;
        }
    }
    
    if (JsonParser::ContainKey(item, ADUMP_DUMP_OPNAME_RANGE)) {
        std::string fieldPath = BuildPath(basePath, ADUMP_DUMP_OPNAME_RANGE);
        if (!CheckOpnameRangeFieldTypes(item.at(ADUMP_DUMP_OPNAME_RANGE), fieldPath)) {
            return false;
        }
    }
    
    return true;
}

bool DumpConfigConverter::CheckArrayOfType(const nlohmann::json &arr, const std::string &basePath,
    bool isStringType) const
{
    if (!arr.is_array()) {
        REPORT_EP0001_ITEM_ERROR("CheckArrayOfType", basePath, ADUMP_REASON_ITEM_MUST_BE_ARRAY, configPath_);
        return false;
    }
    
    for (size_t i = 0; i < arr.size(); ++i) {
        std::string itemPath = BuildIndexedPath(basePath, i);
        bool typeMatch = isStringType ? arr[i].is_string() : arr[i].is_object();
        if (!typeMatch) {
            const std::string &reason = isStringType ? ADUMP_REASON_MEMBER_MUST_BE_STRING :
                                        ADUMP_REASON_MEMBER_MUST_BE_OBJECT;
            REPORT_EP0001_ITEM_ERROR("CheckArrayOfType", itemPath, reason, configPath_);
            return false;
        }
    }
    return true;
}

bool DumpConfigConverter::CheckArrayOfString(const nlohmann::json &arr, const std::string &basePath) const
{
    return CheckArrayOfType(arr, basePath, true);
}

bool DumpConfigConverter::CheckArrayOfObject(const nlohmann::json &arr, const std::string &basePath) const
{
    return CheckArrayOfType(arr, basePath, false);
}

bool DumpConfigConverter::CheckBlacklistFieldTypes(const nlohmann::json &blacklistArray,
    const std::string &basePath) const
{
    if (!CheckArrayOfObject(blacklistArray, basePath)) {
        return false;
    }
    
    for (size_t i = 0; i < blacklistArray.size(); ++i) {
        std::string itemPath = BuildIndexedPath(basePath, i);
        if (!CheckBlacklistItemFieldTypes(blacklistArray[i], itemPath)) {
            return false;
        }
    }
    return true;
}

bool DumpConfigConverter::CheckBlacklistItemFieldTypes(const nlohmann::json &blacklistItem,
    const std::string &basePath) const
{
    if (!CheckStringField(blacklistItem, ADUMP_DUMP_BLACKLIST_NAME, basePath)) {
        return false;
    }
    
    if (JsonParser::ContainKey(blacklistItem, ADUMP_DUMP_BLACKLIST_POS)) {
        std::string fieldPath = BuildPath(basePath, ADUMP_DUMP_BLACKLIST_POS);
        if (!CheckArrayOfString(blacklistItem.at(ADUMP_DUMP_BLACKLIST_POS), fieldPath)) {
            return false;
        }
    }
    
    return true;
}

bool DumpConfigConverter::CheckOpnameRangeFieldTypes(const nlohmann::json &rangeArray,
    const std::string &basePath) const
{
    if (!CheckArrayOfObject(rangeArray, basePath)) {
        return false;
    }
    
    for (size_t i = 0; i < rangeArray.size(); ++i) {
        std::string itemPath = BuildIndexedPath(basePath, i);
        if (!CheckOpnameRangeItemFieldTypes(rangeArray[i], itemPath)) {
            return false;
        }
    }
    return true;
}

bool DumpConfigConverter::CheckOpnameRangeItemFieldTypes(const nlohmann::json &rangeItem,
    const std::string &basePath) const
{
    if (!CheckStringField(rangeItem, ADUMP_DUMP_OPNAME_RANGE_BEGIN, basePath)) {
        return false;
    }
    
    if (!CheckStringField(rangeItem, ADUMP_DUMP_OPNAME_RANGE_END, basePath)) {
        return false;
    }
    
    return true;
}

bool DumpConfigConverter::CheckDumpConstraints() const
{
    std::string dumpScene;
    if (!CheckDumpScene(dumpScene)) {
        return false;
    }

    if (!dumpScene.empty() && (dumpScene != ADUMP_DUMP_WATCHER)) {
        return true;
    }

    if (!CheckDumpPath()) {
        return false;
    }

    std::string dumpDebug;
    if (!CheckDumpDebug(dumpDebug)) {
        return false;
    }

    if (dumpDebug == ADUMP_DUMP_STATUS_SWITCH_ON) {
        return true;
    }

    if (!CheckDumpStep()) {
        return false;
    }

    std::string dumpLevel = JsonParser::GetStringOrDefault(dumpJs_, ADUMP_DUMP_LEVEL, ADUMP_DUMP_LEVEL_ALL);
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
    if (!JsonParser::GetStringIfExist(dumpJs_, ADUMP_DUMP_SCENE, dumpScene)) {
        return true;
    }

    if (dumpScene == ADUMP_DUMP_WATCHER) {
        return CheckWatcherDumpScene(dumpScene);
    } else {
        return CheckExceptionDumpScene(dumpScene);
    }   
}

bool DumpConfigConverter::CheckWatcherDumpScene(const std::string &dumpScene) const
{
    if (ConflictWith(ADUMP_DUMP_DEBUG, ADUMP_DUMP_STATUS_SWITCH_ON)) {
        REPORT_EP0005_ITEM_VALUE_CANNOT_SET_WHEN_ITEM_VALUE("CheckWatcherDumpScene",
            ADUMP_DUMP_DEBUG, ADUMP_DUMP_STATUS_SWITCH_ON, ADUMP_DUMP_SCENE, dumpScene, configPath_);
        return false;
    }
    if (ConflictWith(ADUMP_DUMP_OP_SWITCH, ADUMP_DUMP_STATUS_SWITCH_ON)) {
        REPORT_EP0005_ITEM_VALUE_CANNOT_SET_WHEN_ITEM_VALUE("CheckWatcherDumpScene",
            ADUMP_DUMP_OP_SWITCH, ADUMP_DUMP_STATUS_SWITCH_ON, ADUMP_DUMP_SCENE, dumpScene, configPath_);
        return false;
    }
    
    std::string dumpMode = JsonParser::GetStringOrDefault(dumpJs_, ADUMP_DUMP_MODE, ADUMP_DUMP_MODE_OUTPUT);
    if (dumpMode != ADUMP_DUMP_MODE_OUTPUT) {
        REPORT_EP0005_ITEM_VALUE_CANNOT_SET_WHEN_ITEM_VALUE("CheckWatcherDumpScene",
            ADUMP_DUMP_MODE, dumpMode, ADUMP_DUMP_SCENE, dumpScene, configPath_);
        return false;
    }
    
    return true;
}

bool DumpConfigConverter::CheckExceptionDumpScene(const std::string &dumpScene) const
{
    if (ConflictWith(ADUMP_DUMP_DEBUG, ADUMP_DUMP_STATUS_SWITCH_ON)) {
        REPORT_EP0005_ITEM_VALUE_CANNOT_SET_WHEN_ITEM_VALUE("CheckExceptionDumpScene",
            ADUMP_DUMP_DEBUG, ADUMP_DUMP_STATUS_SWITCH_ON, ADUMP_DUMP_SCENE, dumpScene, configPath_);
        return false;
    }
    if (ConflictWith(ADUMP_DUMP_OP_SWITCH, ADUMP_DUMP_STATUS_SWITCH_ON)) {
        REPORT_EP0005_ITEM_VALUE_CANNOT_SET_WHEN_ITEM_VALUE("CheckExceptionDumpScene",
            ADUMP_DUMP_OP_SWITCH, ADUMP_DUMP_STATUS_SWITCH_ON, ADUMP_DUMP_SCENE, dumpScene, configPath_);
        return false;
    }
    
    return true;
}

bool DumpConfigConverter::CheckDumpDebug(std::string &dumpDebug) const
{
    dumpDebug = JsonParser::GetStringOrDefault(dumpJs_, ADUMP_DUMP_DEBUG, ADUMP_DUMP_STATUS_SWITCH_OFF);

    if (dumpDebug == ADUMP_DUMP_STATUS_SWITCH_OFF) {
        return true;
    }

    if (ConflictWith(ADUMP_DUMP_OP_SWITCH, ADUMP_DUMP_STATUS_SWITCH_ON)) {
        REPORT_EP0005_ITEM_VALUE_CANNOT_SET_WHEN_ITEM_VALUE("CheckDumpDebug",
            ADUMP_DUMP_OP_SWITCH, ADUMP_DUMP_STATUS_SWITCH_ON,
            ADUMP_DUMP_DEBUG, ADUMP_DUMP_STATUS_SWITCH_ON, configPath_);
        return false;
    }

    return true;
}

void DumpConfigConverter::ParseDfxTypesFromJson(const RawDumpConfig &rawDumpConfig, DumpDfxConfig &dumpDfxConfig) const
{
    dumpDfxConfig.dumpPath = rawDumpConfig.dumpPath;
    if (JsonParser::ContainKey(dumpJs_, ADUMP_DUMP_KERNEL_DATA)) {
        std::string kernelDumpData = JsonParser::GetCfgStrByKey(dumpJs_, ADUMP_DUMP_KERNEL_DATA);
        Split(kernelDumpData, ',', dumpDfxConfig.dfxTypes);
    }
}

void DumpConfigConverter::EnsureDefaultDfxType(const DumpType &dumpType, DumpDfxConfig &dumpDfxConfig) const
{
    if (dumpType == DumpType::OPERATOR && dumpDfxConfig.dfxTypes.empty()) {
        dumpDfxConfig.dfxTypes.push_back(ADUMP_DUMP_KERNEL_DATA_ALL);
    }
}

bool DumpConfigConverter::CheckDumpPath() const
{
    if (!JsonParser::ContainKey(dumpJs_, ADUMP_DUMP_PATH)) {
        REPORT_EP0001_ITEM_ERROR("CheckDumpPath", ADUMP_DUMP_PATH, ADUMP_REASON_ITEM_NOT_FOUND, configPath_);
        return false;
    }
    
    std::string dumpPath = JsonParser::GetCfgStrByKey(dumpJs_, ADUMP_DUMP_PATH);
    if (dumpPath.empty()) {
        REPORT_EP0001_ITEM_ERROR("CheckDumpPath", ADUMP_DUMP_PATH, ADUMP_REASON_ITEM_VALUE_EMPTY, configPath_);
        return false;
    }

    if (dumpPath.length() > static_cast<size_t>(MAX_DUMP_PATH_LENGTH)) {
        REPORT_EP0003_INVALID_VALUE(
            "CheckDumpPath", dumpPath, ADUMP_DUMP_PATH, ADUMP_REASON_PATH_LENGTH_EXCEED_LIMIT, configPath_);
        return false;
    }

    const size_t colonPos = dumpPath.find_first_of(":");
    bool isCutDumpPathFlag = CheckIpAddress(dumpPath);
    if (isCutDumpPathFlag) {
        std::string pathAfterIp = dumpPath.substr(colonPos + 1U);
        if (!FileUtils::IsValidDirChar(pathAfterIp)) {
            REPORT_EP0003_INVALID_VALUE(
                "CheckDumpPath", pathAfterIp, ADUMP_DUMP_PATH, ADUMP_REASON_VALUE_INVALID_CHARS, configPath_);
            return false;
        }
    } else {
        Path path(dumpPath);
        if (!path.RealPath()) {
            REPORT_EP0003_INVALID_VALUE("CheckDumpPath", dumpPath, ADUMP_DUMP_PATH, 
                ADUMP_REASON_PATH_NOT_EXIST, configPath_);
            return false;
        }
        if (!path.IsDirectory()) {
            REPORT_EP0003_INVALID_VALUE("CheckDumpPath", dumpPath, ADUMP_DUMP_PATH, 
                ADUMP_REASON_PATH_NOT_DIRECTORY, configPath_);
            return false;
        }
        constexpr uint32_t accessMode = static_cast<uint32_t>(M_R_OK) | static_cast<uint32_t>(M_W_OK);
        if (!path.Asccess(accessMode)) {
            REPORT_EP0003_INVALID_VALUE("CheckDumpPath", dumpPath, ADUMP_DUMP_PATH, 
                ADUMP_REASON_PATH_NO_PERMISSION, configPath_);
            return false;
        }
    }
    return true;
}

bool DumpConfigConverter::CheckDumpStep() const
{
    std::string dumpStep = JsonParser::GetStringOrDefault(dumpJs_, ADUMP_DUMP_STEP, "");
    if (dumpStep.empty()) {
        return true;
    }

    std::vector<std::string> matchVecs;
    Split(dumpStep, '|', matchVecs);
    if (matchVecs.size() > MAX_DUMP_STEP_INTERVAL_COUNT) {
        REPORT_EP0003_INVALID_VALUE(
            "CheckDumpStep", dumpStep, ADUMP_DUMP_STEP, ADUMP_REASON_DUMP_STEP_EXCEED_LIMIT, configPath_);
        return false;
    }

    for (size_t i = 0U; i < matchVecs.size(); ++i) {
        std::vector<std::string> steps;
        Split(matchVecs[i], '-', steps);
        if (steps.size() > 2U) {
            std::string indexedPath = BuildIndexedPath(ADUMP_DUMP_STEP, i);
            REPORT_EP0003_INVALID_VALUE(
                "CheckDumpStep", matchVecs[i], indexedPath, ADUMP_REASON_DUMP_STEP_INVALID_FORMAT, configPath_);
            return false;
        }

        for (const auto &step : steps) {
            if (!IsDigit(step)) {
                std::string indexedPath = BuildIndexedPath(ADUMP_DUMP_STEP, i);
                REPORT_EP0003_INVALID_VALUE(
                    "CheckDumpStep", matchVecs[i], indexedPath, ADUMP_REASON_DUMP_STEP_NOT_DIGIT, configPath_);
                return false;
            }
        }

        if (std::strtol(steps[0U].c_str(), nullptr, DECIMAL) >
            std::strtol(steps[steps.size() - 1U].c_str(), nullptr, DECIMAL)) {
            std::string indexedPath = BuildIndexedPath(ADUMP_DUMP_STEP, i);
            REPORT_EP0003_INVALID_VALUE(
                "CheckDumpStep", matchVecs[i], indexedPath, ADUMP_REASON_DUMP_STEP_INVALID_RANGE, configPath_);
            return false;
        }
    }
    return true;
}

bool DumpConfigConverter::CheckDumplist(const std::string& dumpLevel) const
{
    std::vector<AclModelDumpConfig> dumpList;
    if (JsonParser::ContainKey(dumpJs_, ADUMP_DUMP_LIST)) {
        dumpList = dumpJs_.at(ADUMP_DUMP_LIST).get<std::vector<AclModelDumpConfig>>();
    }
    if (dumpList.empty()) {
        return true;
    }

    std::string dumpOpSwitch = JsonParser::GetStringOrDefault(
        dumpJs_, ADUMP_DUMP_OP_SWITCH, ADUMP_DUMP_STATUS_SWITCH_OFF);
    std::string dumpScene = JsonParser::GetStringOrDefault(dumpJs_, ADUMP_DUMP_SCENE, "");
    bool isSwitchOff = (dumpOpSwitch == ADUMP_DUMP_STATUS_SWITCH_OFF);

    return CheckDumpListItems(dumpList, dumpLevel, dumpScene, isSwitchOff);
}

bool DumpConfigConverter::CheckModelNameAndLayer(const AclModelDumpConfig &item, const std::string &itemPath) const
{
    if (item.isModelName && item.modelName.empty()) {
        std::string modelPath = BuildPath(itemPath, ADUMP_DUMP_MODEL_NAME);
        REPORT_EP0001_ITEM_ERROR("CheckDumpList", modelPath, ADUMP_REASON_ITEM_VALUE_EMPTY, configPath_);
        return false;
    }

    if (item.isLayer && item.layer.empty()) {
        std::string layerPath = BuildPath(itemPath, ADUMP_DUMP_LAYER);
        REPORT_EP0001_ITEM_ERROR("CheckDumpList", layerPath, ADUMP_REASON_ITEM_VALUE_EMPTY, configPath_);
        return false;
    }
    
    return true;
}
bool DumpConfigConverter::CheckWatcherSceneConstraints(const AclModelDumpConfig &item, const std::string &itemPath,
     const std::string &dumpScene) const
{
    if (dumpScene == ADUMP_DUMP_WATCHER) {
        if (!item.isWatcherNodes) {
            std::string watcherPath = BuildPath(itemPath, ADUMP_DUMP_WATCHER_NODES);
            REPORT_EP0001_ITEM_ERROR("CheckDumpList", watcherPath, ADUMP_REASON_ITEM_NOT_FOUND, configPath_);
            return false;
        }

        if (item.watcherNodes.empty()) {
            std::string watcherPath = BuildPath(itemPath, ADUMP_DUMP_WATCHER_NODES);
            REPORT_EP0001_ITEM_ERROR("CheckDumpList", watcherPath, ADUMP_REASON_ITEM_VALUE_EMPTY, configPath_);
            return false;
        }

        if (item.isModelName) {
            std::string modelPath = BuildPath(itemPath, ADUMP_DUMP_MODEL_NAME);
            REPORT_EP0005_ITEM_CANNOT_SET_WHEN_ITEM_VALUE("CheckDumpList", modelPath,
                ADUMP_DUMP_SCENE, ADUMP_DUMP_WATCHER, configPath_);
            return false;
        }
    } else {
        if (!item.watcherNodes.empty()) {
            std::string watcherPath = BuildPath(itemPath, ADUMP_DUMP_WATCHER_NODES);
            REPORT_EP0005_ITEM_CANNOT_SET_WHEN_ITEM_NOT_VALUE("CheckDumpList", watcherPath,
                ADUMP_DUMP_SCENE, ADUMP_DUMP_WATCHER, configPath_);
            return false;
        }
    }
    
    return true;
}

bool DumpConfigConverter::CheckBlacklistSize(const AclModelDumpConfig &item,
                                               const std::string &itemPath) const
{
    if (item.optypeBlacklist.size() > MAX_BLACKLIST_SIZE) {
        std::string blacklistPath = BuildPath(itemPath, ADUMP_DUMP_OPTYPE_BLACKLIST);
        REPORT_EP0003_INVALID_VALUE("CheckDumpList", std::to_string(item.optypeBlacklist.size()),
            blacklistPath, ADUMP_REASON_BLACKLIST_SIZE_EXCEED_LIMIT, configPath_);
        return false;
    }

    if (item.opnameBlacklist.size() > MAX_BLACKLIST_SIZE) {
        std::string blacklistPath = BuildPath(itemPath, ADUMP_DUMP_OPNAME_BLACKLIST);
        REPORT_EP0003_INVALID_VALUE("CheckDumpList", std::to_string(item.opnameBlacklist.size()),
            blacklistPath, ADUMP_REASON_BLACKLIST_SIZE_EXCEED_LIMIT, configPath_);
        return false;
    }
    
    return true;
}
bool DumpConfigConverter::CheckBlacklistWithDumpLevel(const AclModelDumpConfig &item, const std::string &itemPath,
    const std::string &dumpLevel) const
{
    bool hasOptypeBlacklist = !item.optypeBlacklist.empty();
    bool hasOpnameBlacklist = !item.opnameBlacklist.empty();

    if (hasOptypeBlacklist && dumpLevel != ADUMP_DUMP_LEVEL_OP) {
        std::string blacklistPath = BuildPath(itemPath, ADUMP_DUMP_OPTYPE_BLACKLIST);
        REPORT_EP0005_ITEM_CANNOT_SET_WHEN_ITEM_NOT_VALUE("CheckDumpList", blacklistPath,
            ADUMP_DUMP_LEVEL, ADUMP_DUMP_LEVEL_OP, configPath_);
        return false;
    }

    if (hasOpnameBlacklist && dumpLevel != ADUMP_DUMP_LEVEL_OP) {
        std::string blacklistPath = BuildPath(itemPath, ADUMP_DUMP_OPNAME_BLACKLIST);
        REPORT_EP0005_ITEM_CANNOT_SET_WHEN_ITEM_NOT_VALUE("CheckDumpList", blacklistPath,
            ADUMP_DUMP_LEVEL, ADUMP_DUMP_LEVEL_OP, configPath_);
        return false;
    }
    
    return true;
}
bool DumpConfigConverter::CheckOpNameRange(const AclModelDumpConfig &item, const std::string &itemPath,
    const std::string &dumpLevel) const
{
    if (item.dumpOpNameRanges.empty()) {
        return true;
    }
    
    std::string rangePath = BuildPath(itemPath, ADUMP_DUMP_OPNAME_RANGE);

    if (dumpLevel != ADUMP_DUMP_LEVEL_OP) {
        REPORT_EP0005_ITEM_CANNOT_SET_WHEN_ITEM_NOT_VALUE("CheckDumpList", rangePath,
            ADUMP_DUMP_LEVEL, ADUMP_DUMP_LEVEL_OP, configPath_);
        return false;
    }

    std::string modelPath = BuildPath(itemPath, ADUMP_DUMP_MODEL_NAME);
    if (!item.isModelName) {
        REPORT_EP0001_ITEM_ERROR("CheckDumpList", modelPath, ADUMP_REASON_ITEM_NOT_FOUND, configPath_);
        return false;
    }

    if (item.modelName.empty()) {
        REPORT_EP0001_ITEM_ERROR("CheckDumpList", modelPath, ADUMP_REASON_ITEM_VALUE_EMPTY, configPath_);
        return false;
    }

    for (size_t j = 0U; j < item.dumpOpNameRanges.size(); ++j) {
        const auto &range = item.dumpOpNameRanges[j];
        std::string rangeIndexPath = BuildIndexedPath(rangePath, j);

        if (range.begin.empty() || range.end.empty()) {
            std::string rangeValue = "begin=" + range.begin + ", end=" + range.end;
            REPORT_EP0003_INVALID_VALUE("CheckDumpList", rangeValue, rangeIndexPath,
                ADUMP_REASON_OPNAME_RANGE_INCOMPLETE, configPath_);
            return false;
        }
        IDE_LOGI("op name range begin[%s], op name range end[%s].", range.begin.c_str(), range.end.c_str());
    }
    
    return true;
}

bool DumpConfigConverter::CheckDumpListItems(const std::vector<AclModelDumpConfig> &dumpList,
    const std::string &dumpLevel, const std::string &dumpScene, bool isSwitchOff) const
{
    for (size_t i = 0U; i < dumpList.size(); ++i) {
        const auto &item = dumpList[i];
        std::string itemPath = BuildIndexedPath(ADUMP_DUMP_LIST, i);
        
        if (isSwitchOff && !CheckModelNameAndLayer(item, itemPath)) {
            return false;
        }
        
        if (!CheckWatcherSceneConstraints(item, itemPath, dumpScene)) {
            return false;
        }
        
        if (!CheckBlacklistSize(item, itemPath)) {
            return false;
        }
        
        if (!CheckBlacklistWithDumpLevel(item, itemPath, dumpLevel)) {
            return false;
        }
        
        if (!CheckOpNameRange(item, itemPath, dumpLevel)) {
            return false;
        }
    }
    
    IDE_LOGI("end to check the validity of dump_list and dump_op_switch field.");
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
        REPORT_EP0001_ITEM_ERROR("CheckDumpStats", ADUMP_DUMP_STATS, ADUMP_REASON_ITEM_VALUE_EMPTY, configPath_);
        return false;
    }
    
    std::string dumpData = JsonParser::GetStringOrDefault(dumpJs_, ADUMP_DUMP_DATA, ADUMP_DUMP_DATA_TENSOR);
    if (dumpData == ADUMP_DUMP_DATA_TENSOR) {
        REPORT_EP0005_ITEM_CANNOT_SET_WHEN_ITEM_VALUE("CheckDumpStats", ADUMP_DUMP_STATS,
            ADUMP_DUMP_DATA, ADUMP_DUMP_DATA_TENSOR, configPath_);
        return false;
    }
    return true;
}

bool DumpConfigConverter::IsValueValid(const std::string key, const std::string value,
                                        const std::string &errorPath) const
{
    std::string reportPath = errorPath.empty() ? key : errorPath;
    
    if (value.empty()) {
        REPORT_EP0001_ITEM_ERROR("CheckItemValue", reportPath, ADUMP_REASON_ITEM_VALUE_EMPTY, configPath_);
        return false;
    }

    if (dumpValidOptions.at(key).find(value) != dumpValidOptions.at(key).end()) {
        return true;
    }

    std::string validOptionStr = TransOptionsToStr(dumpValidOptions.at(key));
    REPORT_EP0002_ENUM_VALUE_INVALID("CheckItemValue", value, reportPath, validOptionStr, configPath_);
    return false;
}

std::string DumpConfigConverter::TransOptionsToStr(const std::set<std::string> &options)
{
    std::string optionStr;
    for (auto option : options) {
        optionStr += option + "/";
    }
    optionStr.pop_back();
    return optionStr;
}

bool DumpConfigConverter::ConflictWith(const std::string key, const std::string value) const
{
    std::string itemValue;
    if (!JsonParser::GetStringIfExist(dumpJs_, key, itemValue)) {
        return false;
    }
    return itemValue == value;
}

bool DumpConfigConverter::CheckIpAddress(const std::string dumpPath) const
{
    // check the valid of ipAddress in dump_path
    const size_t colonPos = dumpPath.find_first_of(":");
    if (colonPos != std::string::npos) {
        IDE_LOGI("dump_path field contains ip address.");
        if ((colonPos + 1U) == dumpPath.size()) {
            REPORT_EP0003_INVALID_VALUE("CheckIpAddress", dumpPath, ADUMP_DUMP_PATH,
                ADUMP_REASON_PATH_INVALID, configPath_);
            return false;
        }
        const std::string ipAddress = dumpPath.substr(0U, colonPos);
        const std::vector<std::string> ipRet = StrUtils::Split(ipAddress, ".");
        if (ipRet.size() == static_cast<size_t>(MAX_IPV4_ADDRESS_LENGTH)) {
            try {
                for (const std::string &ret : ipRet) {
                    const int32_t val = std::stoi(ret);
                    if ((val < 0) || (val > MAX_IPV4_ADDRESS_VALUE)) {
                        IDE_LOGW("ip address[%s] is invalid in dump_path field", ipAddress.c_str());
                        return false;
                    }
                }
            } catch (...) {
                IDE_LOGW("ip address[%s] can not convert to digital in dump_path field", ipAddress.c_str());
                return false;
            }
            IDE_LOGI("ip address[%s] is valid in dump_path field.", ipAddress.c_str());
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
    if (!rawDumpConfig.dumpScene.empty() && rawDumpConfig.dumpScene != ADUMP_DUMP_WATCHER) {
        // 优先级：ASCEND_DUMP_PATH > ASCEND_WORK_PATH > 配置文件 > "./"
        std::string envDumpPath;
        if (GetEnvDumpPath(ADUMP_ENV_ASCEND_WORK_PATH, envDumpPath)) {
            dumpConfig.dumpPath = envDumpPath;
        }
        if (GetEnvDumpPath(ADUMP_ENV_ASCEND_DUMP_PATH, envDumpPath)) {
            dumpConfig.dumpPath = envDumpPath;
        }
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
    DumpType dumpType;
    if (ConvertDumpScene(rawDumpConfig.dumpScene, dumpType)) {
        return dumpType;
    } else if (rawDumpConfig.dumpDebug == ADUMP_DUMP_STATUS_SWITCH_ON) {
        return DumpType::OP_OVERFLOW;
    } else{
        return DumpType::OPERATOR;
    }
}

bool DumpConfigConverter::ConvertDumpScene(const std::string dumpScene, DumpType &dumpType)
{
    if (dumpScene == ADUMP_DUMP_EXCEPTION_AIC_ERR_BRIEF || dumpScene == ADUMP_DUMP_LITE_EXCEPTION) {
        dumpType = DumpType::ARGS_EXCEPTION;
    } else if (dumpScene == ADUMP_DUMP_EXCEPTION_AIC_ERR_NORM) {
        dumpType = DumpType::EXCEPTION;
    } else if (dumpScene == ADUMP_DUMP_EXCEPTION_AIC_ERR_DETAIL) {
        dumpType = DumpType::AIC_ERR_DETAIL_DUMP;
    } else {
        return false;
    }
    return true;
}

std::string DumpConfigConverter::DumpTypeToStr(const DumpType dumpType)
{
    if (dumpType == DumpType::ARGS_EXCEPTION) {
        return ADUMP_DUMP_EXCEPTION_AIC_ERR_BRIEF;
    } else if (dumpType == DumpType::EXCEPTION) {
        return ADUMP_DUMP_EXCEPTION_AIC_ERR_NORM;
    } else if (dumpType == DumpType::AIC_ERR_DETAIL_DUMP) {
        return ADUMP_DUMP_EXCEPTION_AIC_ERR_DETAIL;
    } else if (dumpType == DumpType::OP_OVERFLOW) {
        return ADUMP_DUMP_DATA_OVERFLOW;
    } else if (dumpType == DumpType::OPERATOR) {
        return ADUMP_DUMP_DATA_TENSOR;
    } else {
        return "unknown";
    }
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

int32_t DumpConfigConverter::Convert(DumpType &dumpType, DumpConfig &dumpConfig, bool &needDump,
    DumpDfxConfig &dumpDfxConfig)
{
    nlohmann::json js;
    std::string errMsg;
    needDump = false;
    int32_t ret = JsonParser::ParseJsonFromMemory(dumpConfigData_, dumpConfigSize_, js, errMsg);
    if (ret != ADUMP_SUCCESS) {
        REPORT_EP0004_PARSE_ERROR("Convert", errMsg, configPath_);
        return ADUMP_FAILED;
    }
    try {
        if (!JsonParser::ContainKey(js, ADUMP_DUMP)) {
            return ADUMP_SUCCESS;
        }
        dumpJs_ = js.at(ADUMP_DUMP);
        if (!dumpJs_.is_object()) {
            REPORT_EP0001_ITEM_ERROR("Convert", ADUMP_DUMP, ADUMP_REASON_ITEM_MUST_BE_OBJECT, configPath_);
            return ADUMP_FAILED;
        }
        if (dumpJs_.empty()) {
            return ADUMP_SUCCESS;
        }
        if (!CheckDumpFieldTypes()) {
            return ADUMP_FAILED;
        }
        if (!CheckDumpFieldValues()) {
            return ADUMP_FAILED;
        }
        if (!CheckDumpConstraints()) {
            return ADUMP_FAILED;
        }
        RawDumpConfig rawDumpConfig = js.at(ADUMP_DUMP);
        ParseDfxTypesFromJson(rawDumpConfig, dumpDfxConfig);

        if (!NeedDump(rawDumpConfig)) {
            return ADUMP_SUCCESS;
        }
        dumpConfig = ConvertDumpConfig(rawDumpConfig);
        dumpType = ConvertDumpType(rawDumpConfig);
        EnsureDefaultDfxType(dumpType, dumpDfxConfig);
        needDump = true;
        IDE_LOGI("Success to convert dumpType[%d], dumpPath[%s], dumpMode[%s], "
                 "dumpStatus[%s], dumpData[%s], dumpSwitch[%ld]",
                 dumpType, dumpConfig.dumpPath.c_str(), dumpConfig.dumpMode.c_str(),
                 dumpConfig.dumpStatus.c_str(), dumpConfig.dumpData.c_str(), dumpConfig.dumpSwitch);
    } catch (const std::exception &e) {
        REPORT_EP0004_PARSE_ERROR("Convert", std::string(e.what()), configPath_);
        return ADUMP_FAILED;
    }
    return ADUMP_SUCCESS;
}

bool DumpConfigConverter::GetEnvVariable(const std::string &env, std::string &value)
{
    if (env.empty()) {
        return false;
    }
    const char* val = std::getenv(env.c_str());
    if (val != nullptr && val[0] != '\0') {
        value = val;
        IDE_LOGI("Get Env[%s] is [%s]", env.c_str(), val);
        return true;
    }
    return false;
}

bool DumpConfigConverter::CheckDumpPath(const std::string &param, const std::string &dumpPath)
{
    Path path(dumpPath);
    if (!path.CreateDirectory(true)) {
        IDE_LOGW("Failed to create dump path [%s] for Env[%s]", dumpPath.c_str(), param.c_str());
        return false;
    }
    if (!path.RealPath()) {
        IDE_LOGW("The dump path [%s] for Env[%s] is not a real path", path.GetCString(), param.c_str());
        return false;
    }

    if (!path.IsDirectory()) {
        IDE_LOGW("The dump path [%s] for Env[%s] is not a directory path", path.GetCString(), param.c_str());
        return false;
    }

    constexpr uint32_t accessMode = static_cast<uint32_t>(M_R_OK) | static_cast<uint32_t>(M_W_OK);
    if (!path.Asccess(accessMode)) {
        IDE_LOGW("The path [%s] for Env[%s] does not have read and write permission",
            path.GetCString(), param.c_str());
        return false;
    }

    IDE_LOGI("The real dump path [%s]", path.GetCString());
    return true;
}

bool DumpConfigConverter::GetEnvDumpPath(const std::string &env, std::string &envPath)
{
    std::string tmpPath;
    if (GetEnvVariable(env, tmpPath)) {
        if (CheckDumpPath(env, tmpPath)) {
            envPath = tmpPath;
            return true;
        }
    }
    return false;
}

void DumpConfigConverter::LoadDumpEnvVariables(DumpEnvVariable &dumpEnvVariable)
{
    std::string envAscendDumpScene;
    if (GetEnvVariable(ADUMP_ENV_ASCEND_DUMP_SCENE, envAscendDumpScene)) {
        if (envDumpScenes.find(envAscendDumpScene) != envDumpScenes.end()) {
            dumpEnvVariable.ascendDumpScene = envAscendDumpScene;
        } else {
            std::string optionStr = TransOptionsToStr(envDumpScenes);
            IDE_LOGW("Value[%s] of Env[ASCEND_DUMP_SCENE] is invalid, it must be %s",
                envAscendDumpScene.c_str(), optionStr.c_str());
        }
    }

    (void)GetEnvDumpPath(ADUMP_ENV_ASCEND_DUMP_PATH, dumpEnvVariable.ascendDumpPath);
    (void)GetEnvDumpPath(ADUMP_ENV_NPU_COLLECT_PATH, dumpEnvVariable.npuCollectPath);
    (void)GetEnvDumpPath(ADUMP_ENV_ASCEND_WORK_PATH, dumpEnvVariable.ascendWorkPath);
}

bool DumpConfigConverter::EnableExceptionDumpWithEnv(DumpConfig &dumpConfig, DumpType &dumpType)
{
    DumpEnvVariable dumpEnvVariable;
    LoadDumpEnvVariables(dumpEnvVariable);
    if (ConvertDumpScene(dumpEnvVariable.ascendDumpScene, dumpType)) {
        dumpConfig.dumpPath = !dumpEnvVariable.ascendDumpPath.empty()
            ? dumpEnvVariable.ascendDumpPath
            : (dumpEnvVariable.ascendWorkPath.empty() ? "./": dumpEnvVariable.ascendWorkPath);
        dumpConfig.dumpStatus = ADUMP_DUMP_STATUS_SWITCH_ON;
        return true;
    } else if (!dumpEnvVariable.npuCollectPath.empty()) {
        dumpType = DumpType::EXCEPTION;
        dumpConfig.dumpPath = dumpEnvVariable.npuCollectPath;
        dumpConfig.dumpStatus = ADUMP_DUMP_STATUS_SWITCH_ON;
        return true;
    } else {
        IDE_LOGI("No Env enable exception dump");
        return false;
    }
}

bool DumpConfigConverter::EnableKernelDfxDumpWithEnv(DumpDfxConfig &config)
{
    DumpEnvVariable dumpEnvVariable;
    LoadDumpEnvVariables(dumpEnvVariable);
    if (!dumpEnvVariable.ascendDumpPath.empty() || !dumpEnvVariable.ascendWorkPath.empty()) {
        // enable all(default, RT_KERNEL_DFX_INFO_DEFAULT) with env variable
        config.dfxTypes.push_back(ADUMP_DUMP_KERNEL_DATA_ALL);
        std::string dumpPath = dumpEnvVariable.ascendDumpPath.empty()
            ? dumpEnvVariable.ascendWorkPath : dumpEnvVariable.ascendDumpPath;
        Path path = Path(dumpPath).Append("printf");
        config.dumpPath = path.GetString();
        return true;
    }
    return false;
}
}  // namespace Adx