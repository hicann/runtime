/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef JSON_PARSER_H
#define JSON_PARSER_H

#include <map>
#include <vector>
#include "json/json.h"
#include "json_api.h"
#include "singleton/singleton.h"

namespace Msprofiler {
namespace Parser {
const char PROF_JSON_PATH[] = "/etc/prof.json";
const char MSPORF_CANN_STRING[] = "cann";
const char MSPORF_MODULES_STRING[] = "modules";
const char MSPORF_MODULE_STRING[] = "module";
const char MSPORF_REPORTERS_STRING[] = "reporters";
const char MSPORF_REPORTER_STRING[] = "reporter";
const char MSPORF_PROF_SWITCH_STRING[] = "prof_switch";
const char MSPORF_REPORTER_SWITCH_STRING[] = "reporter_switch";
const char MSPORF_REPORT_BUFFER_LEN_STRING[] = "report_buffer_len";
const char MSPORF_DEVICE_STRING[] = "device";
const char MSPORF_CHANNELS_STRING[] = "channels";
const char MSPORF_CHANNEL_STRING[] = "channel";
const char MSPORF_PERIOD_STRING[] = "peroid";
const char MSPORF_CHANNEL_BUFFER_SIZE_STRING[] = "channel_buffer_size";
const char MSPORF_DRIVER_BUFFER_SIZE_STRING[] = "driver_buffer_size";
const char MSPORF_THRESHOLD_STRING[] = "threshold";
constexpr int32_t MIN_REPORT_BUFFER_LEN = static_cast<int32_t>(16384 * 0.5);
constexpr int32_t MAX_REPORT_BUFFER_LEN = 16384 * 2;
constexpr int32_t MIN_CHANNEL_PEROID = 1;
constexpr int32_t MAX_CHANNEL_PEROID = 1000;
constexpr int32_t MIN_CHANNEL_BUFFER_SIZE = static_cast<int32_t>(2097152 * 0.5);
constexpr int32_t MAX_CHANNEL_BUFFER_SIZE = 2097152 * 2;
constexpr int32_t MIN_HWTS_THRESHOLD = 10;
constexpr int32_t MAX_HWTS_THRESHOLD = 95;

// Modules
const char PROF_JSON_ACL[] = "ACL";
const char PROF_JSON_FRAMEWORK[] = "FRAMEWORK";
const char PROF_JSON_RUNTIME[] = "RUNTIME";
const char PROF_JSON_HCCL[] = "HCCL";
const char PROF_JSON_DATA_PREPROCESS[] = "DATA_PREPROCESS";
const char PROF_JSON_MSPROF[] = "MSPROF";
const char PROF_JSON_API_EVENT[] = "API_EVENT";
const char PROF_JSON_COMPACT[] = "COMPACT";
const char PROF_JSON_ADDITIONAL[] = "ADDITIONAL";

struct ProfJsonRoot {
    JsonValue cann;
    JsonValue modules;
    JsonValue reporters;
    JsonValue devices;
    JsonValue channels;
};

struct ProfJsonModules {
    int32_t moduleId;
    bool profSwitch;
};

struct ProfJsonReporters {
    int32_t reporterId;
    bool reporterSwitch;
    int32_t reportBufferLen;
};

struct ProfJsonChannels {
    int32_t channelId;
    int32_t peroid;
    int32_t reportBufferLen;
    int32_t driverBufferLen;
    int32_t threshold;
    bool profSwitch;
    bool reporterSwitch;
};

class JsonParser : public analysis::dvvp::common::singleton::Singleton<JsonParser> {
public:
    JsonParser();
    ~JsonParser() override;
    void Init(const std::string &jsonPath = PROF_JSON_PATH);
    void JsonParserDefaultParametersInit(void);
    bool GetJsonProfSwitch();
    bool GetJsonModuleProfSwitch(const uint32_t &moduleId) const;
    bool GetJsonModuleReporterSwitch(const uint32_t &moduleId) const;
    uint32_t GetJsonModuleReporterBufferLen(const uint32_t &reporterId) const;
    bool GetJsonChannelReporterSwitch(const uint32_t &channelId) const;
    bool GetJsonChannelProfSwitch(const uint32_t &channelId) const;
    uint32_t GetJsonChannelReportBufferLen(const uint32_t &channelId) const;
    uint32_t GetJsonChannelDriverBufferLen(const uint32_t &channelId) const;
    uint32_t GetJsonChannelPeroid(const uint32_t &channelId) const;
    uint32_t GetJsonChannelThreshold(const uint32_t &channelId) const;
    bool CheckJsonModuleId(const std::string &tempString) const;
    bool CheckJsonReporterId(const std::string &tempString) const;
    bool CheckJsonChannelId(const int32_t &channelId) const;
    void UnInit();

private:
    void ParseJsonFile(const std::string &path);
    void ParseJsonModules(const ProfJsonRoot &profJsonRootFile);
    void ParseJsonReporters(const ProfJsonRoot &profJsonRootFile);
    void ParseJsonChannels(const ProfJsonRoot &profJsonRootFile);
    void CheckModuleReportBufferLen(JsonValue temp, ProfJsonReporters &tempReporter) const;
    void CheckChannelProfSwitch(JsonValue temp, ProfJsonChannels &tempChannel) const;
    void CheckChannelReporterSwitch(JsonValue temp, ProfJsonChannels &tempChannel) const;
    void CheckChannelReportBufferLen(JsonValue temp, ProfJsonChannels &tempChannel) const;
    void CheckChannelThreshold(JsonValue temp, ProfJsonChannels &tempChannel) const;

    bool isInited_;
    std::map<int32_t, ProfJsonChannels> channelParams_;
    std::map<int32_t, ProfJsonModules> moduleParams_;
    std::map<int32_t, ProfJsonReporters> reporterParams_;
};

}
}
#endif
