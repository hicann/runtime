/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DUMP_CONFIG_CONVERTER_H
#define DUMP_CONFIG_CONVERTER_H
#include <cstdint>
#include <string>
#include <vector>
#include "adump_pub.h"
#include "adump_api.h"
#include "nlohmann/json.hpp"

namespace Adx {

const std::string ADUMP_DUMP = "dump";
const std::string ADUMP_DUMP_SCENE = "dump_scene";
const std::string ADUMP_DUMP_PATH = "dump_path";
const std::string ADUMP_DUMP_MODE = "dump_mode";
const std::string ADUMP_DUMP_DATA = "dump_data";
const std::string ADUMP_DUMP_OP_SWITCH = "dump_op_switch";
const std::string ADUMP_DUMP_LEVEL = "dump_level";
const std::string ADUMP_DUMP_STATS = "dump_stats";
const std::string ADUMP_DUMP_DEBUG = "dump_debug";

const std::string ADUMP_DUMP_MODE_INPUT = "input";
const std::string ADUMP_DUMP_MODE_OUTPUT = "output";
const std::string ADUMP_DUMP_MODE_ALL = "all";
const std::string ADUMP_DUMP_STATUS_SWITCH_ON = "on";
const std::string ADUMP_DUMP_STATUS_SWITCH_OFF = "off";
const std::string ADUMP_DUMP_MODEL_NAME = "model_name";
const std::string ADUMP_DUMP_LAYER = "layer";
const std::string ADUMP_DUMP_WATCHER_NODES = "watcher_nodes";
const std::string ADUMP_DUMP_LIST = "dump_list";
const std::string ADUMP_DUMP_STEP = "dump_step";
const std::string ADUMP_DUMP_WATCHER = "watcher";
const std::string ADUMP_DUMP_LEVEL_OP = "op";
const std::string ADUMP_DUMP_LEVEL_KERNEL = "kernel";
const std::string ADUMP_DUMP_LEVEL_ALL = "all";
const std::string ADUMP_DUMP_DATA_TENSOR = "tensor";
const std::string ADUMP_DUMP_DATA_STATS = "stats";
const std::string ADUMP_DUMP_LITE_EXCEPTION = "lite_exception";                 // l0 exception dump
const std::string ADUMP_DUMP_EXCEPTION_AIC_ERR_BRIEF = "aic_err_brief_dump";    // l0 exception dump
const std::string ADUMP_DUMP_EXCEPTION_AIC_ERR_NORM = "aic_err_norm_dump";      // l1 exception dump
const std::string ADUMP_DUMP_EXCEPTION_AIC_ERR_DETAIL = "aic_err_detail_dump";
const std::string ADUMP_DUMP_OPTYPE_BLACKLIST = "optype_blacklist";
const std::string ADUMP_DUMP_OPNAME_BLACKLIST = "opname_blacklist";
const std::string ADUMP_DUMP_OPNAME_RANGE = "opname_range";
const std::string ADUMP_DUMP_BLACKLIST_NAME = "name";
const std::string ADUMP_DUMP_BLACKLIST_POS = "pos";
const std::string ADUMP_DUMP_OPNAME_RANGE_BEGIN = "begin";
const std::string ADUMP_DUMP_OPNAME_RANGE_END = "end";
constexpr int32_t MAX_DUMP_PATH_LENGTH = 512;
constexpr int32_t MAX_IPV4_ADDRESS_VALUE = 255;
constexpr int32_t MAX_IPV4_ADDRESS_LENGTH = 4;

struct RawDumpConfig
{
    std::string dumpPath;
    std::string dumpMode;
    std::string dumpData;
    std::vector<std::string> dumpStats;
    std::string dumpOpSwitch;
    std::string dumpLevel;
    std::string dumpDebug;
    std::string dumpScene;
};

struct AclDumpBlacklist
{
    std::string name;
    std::vector<std::string> pos;
};
 
struct OpNameRange
{
    std::string begin;
    std::string end;
};
struct AclModelDumpConfig
{
    std::string modelName;
    std::vector<std::string> layer;
    std::vector<std::string> watcherNodes;
    bool isLayer = false;     // Whether the label of "layer" exists
    bool isModelName = false; // Whether the label of "model_name" exists
    std::vector<AclDumpBlacklist> optypeBlacklist;
    std::vector<AclDumpBlacklist> opnameBlacklist;
    std::vector<OpNameRange> dumpOpNameRanges;
};

class DumpConfigConverter
{
public:
    DumpConfigConverter(const char *dumpConfigData, size_t dumpConfigSize) 
    : dumpConfigData_(dumpConfigData), dumpConfigSize_(dumpConfigSize) {};
    ~DumpConfigConverter() = default;
    int32_t ParseJsonFile() const;
    int32_t Convert(DumpType &dumpType, DumpConfig &dumpConfig, bool &needDump);
    bool IsValidDumpConfig() const;
    static bool EnabledExceptionWithEnv(DumpConfig &dumpConfig);
private:
    bool CheckDumpScene(std::string &dumpScene) const;
    bool CheckDumpDebug(std::string &dumpDebug) const;
    bool CheckDumpPath() const;
    bool CheckDumpStats() const;
    bool CheckValueValidIfContain(const std::string key) const;
    bool IsValueValid(const std::string key, const std::string value) const;
    bool ConflictWith(const std::string key, const std::string value) const;
    bool CheckIpAddress(const std::string dumpPath) const;
    bool NeedDump(const RawDumpConfig &rawDumpConfig) const;
    DumpConfig ConvertDumpConfig(const RawDumpConfig &rawDumpConfig) const;
    DumpType ConvertDumpType(const RawDumpConfig &rawDumpConfig) const;
    bool CheckDumpMode(std::string &dumpMode) const;
    bool CheckDumplist(const std::string& dumpLevel) const;
    bool CheckDumpOpSwitch(const std::string &dumpOpSwitch) const;
    bool CheckEmptyDumpList(const std::vector<AclModelDumpConfig> &dumpList,
                                           const std::string &dumpOpSwitch) const;
    bool CheckDumpListWhenSwitchOff(const std::vector<AclModelDumpConfig> &dumpList) const;
    bool CheckWatcherScene(const std::vector<AclModelDumpConfig> &dumpList,
                                            const std::string &dumpScene) const;
    bool CheckOpBlacklistSize(const std::vector<AclModelDumpConfig> &dumpList) const;
    bool CheckOpBlacklistWithDumpLevel(const std::vector<AclModelDumpConfig> &dumpList,
                                                        const std::string &dumpLevel) const;
    bool CheckDumpOpNameRange(const std::vector<AclModelDumpConfig> &dumpConfigList,
                                               const std::string &dumpLevel) const;
    void Split(const std::string &str, const char delim, std::vector<std::string> &elems) const;
    bool IsDigit(const std::string &str) const;
    bool CheckDumpStep() const;
    const char *configPath_ = "null";  //后续会下线，默认赋值null，防止日志打印逻辑出现异常
    nlohmann::json dumpJs_;
    const char *dumpConfigData_;
    size_t dumpConfigSize_;
};
} // namespace Adx
#endif // DUMP_CONFIG_CONVERTER_H
