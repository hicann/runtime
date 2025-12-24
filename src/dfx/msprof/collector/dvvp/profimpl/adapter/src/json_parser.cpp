/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "json_parser.h"
#include <vector>
#include "ai_drv_prof_api.h"
#include "msprof_dlog.h"
#include "prof_api.h"

using namespace analysis::dvvp::driver;
using namespace analysis::dvvp::common::config;

namespace Msprofiler {
namespace Parser {
std::map<uint32_t, uint32_t> g_moduleIdMap = {
    {ASCENDCL, MSPROF_MODULE_ACL},
    {GE, MSPROF_MODULE_FRAMEWORK},
    {RUNTIME, MSPROF_MODULE_RUNTIME},
    {HCCL, MSPROF_MODULE_HCCL},
    {AICPU, MSPROF_MODULE_DATA_PREPROCESS},
};

std::map<std::string, uint32_t> g_parseJsonModulesMap = {
    {PROF_JSON_ACL, MSPROF_MODULE_ACL},
    {PROF_JSON_FRAMEWORK, MSPROF_MODULE_FRAMEWORK},
    {PROF_JSON_RUNTIME, MSPROF_MODULE_RUNTIME},
    {PROF_JSON_HCCL, MSPROF_MODULE_HCCL},
    {PROF_JSON_DATA_PREPROCESS, MSPROF_MODULE_DATA_PREPROCESS},
    {PROF_JSON_MSPROF, MSPROF_MODULE_MSPROF}
};

std::map<std::string, uint32_t> g_parseJsonReportersMap = {
    {PROF_JSON_API_EVENT, API_EVENT},
    {PROF_JSON_COMPACT, COMPACT},
    {PROF_JSON_ADDITIONAL, ADDITIONAL}
};

JsonParser::JsonParser() : isInited_(false)
{
}

JsonParser::~JsonParser()
{
    UnInit();
}

void JsonParser::Init(const std::string &jsonPath)
{
    if (!isInited_) {
        isInited_ = true;
        ParseJsonFile(jsonPath);
    }
}

void JsonParser::UnInit()
{
    if (!isInited_) {
        return;
    }
    channelParams_.clear();
    moduleParams_.clear();
    reporterParams_.clear();
    isInited_ = false;
}

void JsonParser::ParseJsonFile(const std::string &path)
{
    std::string tempString;
    ProfJsonRoot profJsonRootFile;
    bool isOpen = true;
    Json profJson;
    LoadConfigFlie(path, profJson, isOpen);
    if (!isOpen) {
        return;
    }
    if (profJson.Contains(MSPORF_CANN_STRING)) {
        profJsonRootFile.cann = (profJson)[MSPORF_CANN_STRING];
        if ((profJsonRootFile.cann).Contains(MSPORF_MODULES_STRING)) {
            profJsonRootFile.modules = (profJsonRootFile.cann)[MSPORF_MODULES_STRING];
            profJsonRootFile.reporters = (profJsonRootFile.cann)[MSPORF_REPORTERS_STRING];
            ParseJsonModules(profJsonRootFile);
            ParseJsonReporters(profJsonRootFile);
        }
    }
    if (profJson.Contains(MSPORF_DEVICE_STRING)) {
        profJsonRootFile.devices = (profJson)[MSPORF_DEVICE_STRING];
        if ((profJsonRootFile.devices).Contains(MSPORF_CHANNELS_STRING)) {
            profJsonRootFile.channels = (profJsonRootFile.devices)[MSPORF_CHANNELS_STRING];
            ParseJsonChannels(profJsonRootFile);
        }
    }
}

void JsonParser::ParseJsonReporters(const ProfJsonRoot &profJsonRootFile)
{
    NanoJson::JsonArray reportersArray = profJsonRootFile.reporters.GetValue<NanoJson::JsonArray>();
    size_t len = reportersArray.size();
    for (size_t i = 0; i < len; i++) {
        std::string tempString;
        ProfJsonReporters tempReporter;
        tempString = reportersArray[i][MSPORF_REPORTER_STRING].GetValue<std::string>();
        if (!CheckJsonReporterId(tempString)) {
            continue;
        }
        tempReporter.reporterId = static_cast<int32_t>(g_parseJsonReportersMap[tempString]);
        if (!reportersArray[i].Contains(MSPORF_REPORTER_SWITCH_STRING)) {
            tempReporter.reporterSwitch = true;
        } else {
            tempString = reportersArray[i][MSPORF_REPORTER_SWITCH_STRING].GetValue<std::string>();
            if (tempString == "on") {
                tempReporter.reporterSwitch = true;
            } else if (tempString == "off") {
                MSPROF_EVENT("Set reporter switch of reporter %d off", tempReporter.reporterId);
                tempReporter.reporterSwitch = false;
            }
        }

        CheckModuleReportBufferLen(reportersArray[i], tempReporter);
        (void)reporterParams_.insert(std::make_pair(tempReporter.reporterId, tempReporter));
    }
}

void JsonParser::ParseJsonModules(const ProfJsonRoot &profJsonRootFile)
{
    NanoJson::JsonArray modulesArray = profJsonRootFile.modules.GetValue<NanoJson::JsonArray>();
    size_t len = modulesArray.size();
    for (size_t i = 0; i < len; i++) {
        std::string tempString;
        ProfJsonModules tempModule = {0, false};
        tempString = modulesArray[i][MSPORF_MODULE_STRING].GetValue<std::string>();
        if (!CheckJsonModuleId(tempString)) {
            continue;
        }
        tempModule.moduleId = static_cast<int32_t>(g_parseJsonModulesMap[tempString]);

        if (!modulesArray[i].Contains(MSPORF_PROF_SWITCH_STRING)) {
            tempModule.profSwitch = true;
        } else {
            tempString = modulesArray[i][MSPORF_PROF_SWITCH_STRING].GetValue<std::string>();
            if (tempString == "on") {
                tempModule.profSwitch = true;
            } else if (tempString == "off") {
                MSPROF_EVENT("Set module switch of module %d off", tempModule.moduleId);
                tempModule.profSwitch = false;
            }
        }
        (void)moduleParams_.insert(std::make_pair(tempModule.moduleId, tempModule));
    }
}

void JsonParser::ParseJsonChannels(const ProfJsonRoot &profJsonRootFile)
{
    NanoJson::JsonArray channelsArray = profJsonRootFile.channels.GetValue<NanoJson::JsonArray>();
    size_t len = channelsArray.size();
    for (size_t i = 0; i < len; i++) {
        int32_t tmpInt;
        ProfJsonChannels tempChannel;
        tmpInt = channelsArray[i][MSPORF_CHANNEL_STRING].GetValue<int32_t>();
        if (!CheckJsonChannelId(tmpInt)) {
            continue;
        }
        tempChannel.channelId = tmpInt;
        if (!channelsArray[i].Contains(MSPORF_PERIOD_STRING)) {
            tempChannel.peroid = 0;
        } else if (channelsArray[i][MSPORF_PERIOD_STRING].GetValue<int32_t>() < MIN_CHANNEL_PEROID ||
                    channelsArray[i][MSPORF_PERIOD_STRING].GetValue<int32_t>() > MAX_CHANNEL_PEROID) {
            MSPROF_LOGW("The peroid of Channel %d is out of range", tempChannel.channelId);
            tempChannel.peroid = 0;
        } else {
            tempChannel.peroid = (channelsArray[i])[MSPORF_PERIOD_STRING].GetValue<int32_t>();
        }

        CheckChannelReportBufferLen(channelsArray[i], tempChannel);

        if (!channelsArray[i].Contains(MSPORF_DRIVER_BUFFER_SIZE_STRING)) {
            tempChannel.driverBufferLen = 0;
        } else {
            tempChannel.driverBufferLen = (channelsArray[i])[MSPORF_DRIVER_BUFFER_SIZE_STRING].GetValue<int32_t>();
        }

        CheckChannelThreshold(channelsArray[i], tempChannel);
        CheckChannelProfSwitch(channelsArray[i], tempChannel);
        CheckChannelReporterSwitch(channelsArray[i], tempChannel);

        (void)channelParams_.insert(std::make_pair(tempChannel.channelId, tempChannel));
    }
}

void JsonParser::CheckModuleReportBufferLen(JsonValue temp, ProfJsonReporters &tempReporter) const
{
    if (!temp.Contains(MSPORF_REPORT_BUFFER_LEN_STRING)) {
            tempReporter.reportBufferLen = 0;
        } else if ((temp[MSPORF_REPORT_BUFFER_LEN_STRING].GetValue<int32_t>() < MIN_REPORT_BUFFER_LEN ||
                    temp[MSPORF_REPORT_BUFFER_LEN_STRING].GetValue<int32_t>() > MAX_REPORT_BUFFER_LEN)) {
            MSPROF_LOGW("The reporter buffer len of Repoter %d is out of range", tempReporter.reporterId);
            tempReporter.reportBufferLen = 0;
        } else {
            tempReporter.reportBufferLen = (temp)[MSPORF_REPORT_BUFFER_LEN_STRING].GetValue<int32_t>();
        }
}

void JsonParser::CheckChannelProfSwitch(JsonValue temp, ProfJsonChannels &tempChannel) const
{
    std::string tempString;
    if (!temp.Contains(MSPORF_PROF_SWITCH_STRING)) {
            tempChannel.profSwitch = true;
        } else {
            tempString = temp[MSPORF_PROF_SWITCH_STRING].GetValue<std::string>();
            if (tempString == "on") {
                tempChannel.profSwitch = true;
            } else if (tempString == "off") {
                MSPROF_EVENT("Set channel switch of channel %d off", tempChannel.channelId);
                tempChannel.profSwitch = false;
            }
        }
}

void JsonParser::CheckChannelReporterSwitch(JsonValue temp, ProfJsonChannels &tempChannel) const
{
    std::string tempString;
    if (!temp.Contains(MSPORF_REPORTER_SWITCH_STRING)) {
            tempChannel.reporterSwitch = true;
        } else {
            tempString = temp[MSPORF_REPORTER_SWITCH_STRING].GetValue<std::string>();
            if (tempString == "on") {
                tempChannel.reporterSwitch = true;
            } else if (tempString == "off") {
                MSPROF_EVENT("Set reporter switch of channel %d off", tempChannel.channelId);
                tempChannel.reporterSwitch = false;
            }
        }
}

void JsonParser::CheckChannelReportBufferLen(JsonValue temp, ProfJsonChannels &tempChannel) const
{
    if (!temp.Contains(MSPORF_CHANNEL_BUFFER_SIZE_STRING)) {
            tempChannel.reportBufferLen = 0;
        } else if (temp[MSPORF_CHANNEL_BUFFER_SIZE_STRING].GetValue<int32_t>() < MIN_CHANNEL_BUFFER_SIZE ||
                    temp[MSPORF_CHANNEL_BUFFER_SIZE_STRING].GetValue<int32_t>() > MAX_CHANNEL_BUFFER_SIZE) {
            MSPROF_LOGW("The channel buffer size of Channel %d is out of range", tempChannel.channelId);
            tempChannel.reportBufferLen = 0;
        } else {
            tempChannel.reportBufferLen = (temp)[MSPORF_CHANNEL_BUFFER_SIZE_STRING].GetValue<int32_t>();
        }
}

void JsonParser::CheckChannelThreshold(JsonValue temp, ProfJsonChannels &tempChannel) const
{
    if (!temp.Contains(MSPORF_THRESHOLD_STRING)) {
            tempChannel.threshold = 0;
        } else if ((temp[MSPORF_THRESHOLD_STRING].GetValue<int32_t>() < MIN_HWTS_THRESHOLD ||
                    temp[MSPORF_THRESHOLD_STRING].GetValue<int32_t>() > MAX_HWTS_THRESHOLD) &&
                    (tempChannel.channelId == static_cast<int32_t>(AI_DRV_CHANNEL::PROF_CHANNEL_HWTS_LOG) ||
                    tempChannel.channelId == static_cast<int32_t>(AI_DRV_CHANNEL::PROF_CHANNEL_AIV_HWTS_LOG))) {
            MSPROF_LOGW("The threshold of Channel %d is out of range", tempChannel.channelId);
            tempChannel.threshold = 0;
        } else {
            tempChannel.threshold = (temp)[MSPORF_THRESHOLD_STRING].GetValue<int32_t>();
        }
}

bool JsonParser::CheckJsonModuleId(const std::string &tempString) const
{
    auto iter = g_parseJsonModulesMap.find(tempString);
    if (iter == g_parseJsonModulesMap.end()) {
        MSPROF_LOGE("Module Id is invalid.");
        return false;
    }
    return true;
}

bool JsonParser::CheckJsonReporterId(const std::string &tempString) const
{
    auto iter = g_parseJsonReportersMap.find(tempString);
    if (iter == g_parseJsonReportersMap.end()) {
        MSPROF_LOGE("Reporter Id %s is invalid.", tempString.c_str());
        return false;
    }
    return true;
}

bool JsonParser::CheckJsonChannelId(const int32_t &channelId) const
{
    if (channelId >= AI_DRV_CHANNEL::PROF_CHANNEL_MAX || channelId <= AI_DRV_CHANNEL::PROF_CHANNEL_UNKNOWN) {
        MSPROF_LOGE("Channel Id %d is invalid.", channelId);
        return false;
    }
    return true;
}

bool JsonParser::GetJsonModuleProfSwitch(const uint32_t &moduleId) const
{
    auto iter = moduleParams_.find(g_moduleIdMap[moduleId]);
    if (iter != moduleParams_.end()) {
        return iter->second.profSwitch;
    }
    return true;
}

bool JsonParser::GetJsonModuleReporterSwitch(const uint32_t &moduleId) const
{
    auto iter = reporterParams_.find(moduleId);
    if (iter != reporterParams_.end()) {
        return iter->second.reporterSwitch;
    }
    return true;
}

uint32_t JsonParser::GetJsonModuleReporterBufferLen(const uint32_t &reporterId) const
{
    auto iter = reporterParams_.find(reporterId);
    if (iter != reporterParams_.end()) {
        if (iter->second.reportBufferLen > 0) {
            return static_cast<uint32_t>(iter->second.reportBufferLen);
        }
    }
    return 0;
}

bool JsonParser::GetJsonChannelReporterSwitch(const uint32_t &channelId) const
{
    auto iter = channelParams_.find(channelId);
    if (iter != channelParams_.end()) {
        return iter->second.reporterSwitch;
    }
    return true;
}

bool JsonParser::GetJsonChannelProfSwitch(const uint32_t &channelId) const
{
    auto iter = channelParams_.find(channelId);
    if (iter != channelParams_.end()) {
        return iter->second.profSwitch;
    }
    return true;
}

uint32_t JsonParser::GetJsonChannelReportBufferLen(const uint32_t &channelId) const
{
    auto iter = channelParams_.find(channelId);
    if (iter != channelParams_.end()) {
        if (iter->second.reportBufferLen > 0) {
            return static_cast<uint32_t>(iter->second.reportBufferLen);
        }
    }
    return 0;
}

uint32_t JsonParser::GetJsonChannelDriverBufferLen(const uint32_t &channelId) const
{
    auto iter = channelParams_.find(channelId);
    if (iter != channelParams_.end()) {
        if (iter->second.driverBufferLen > 0) {
            return static_cast<uint32_t>(iter->second.driverBufferLen);
        }
    }
    return 0;
}

uint32_t JsonParser::GetJsonChannelPeroid(const uint32_t &channelId) const
{
    auto iter = channelParams_.find(channelId);
    if (iter != channelParams_.end()) {
        if (iter->second.peroid > 0) {
            return static_cast<uint32_t>(iter->second.peroid);
        }
    }
    return 0;
}

uint32_t JsonParser::GetJsonChannelThreshold(const uint32_t &channelId) const
{
    auto iter = channelParams_.find(channelId);
    if (iter != channelParams_.end()) {
        if (iter->second.threshold > 0) {
            return static_cast<uint32_t>(iter->second.threshold);
        }
    }
    return 0;
}
}
}
