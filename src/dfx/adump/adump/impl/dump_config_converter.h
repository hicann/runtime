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
const std::string ADUMP_DUMP_DATA_OVERFLOW = "overflow";
const std::string ADUMP_DUMP_DATA_STATS = "stats";
const std::string ADUMP_DUMP_LITE_EXCEPTION = "lite_exception";
const std::string ADUMP_DUMP_EXCEPTION_AIC_ERR_BRIEF = "aic_err_brief_dump";
const std::string ADUMP_DUMP_EXCEPTION_AIC_ERR_NORM = "aic_err_norm_dump";
const std::string ADUMP_DUMP_EXCEPTION_AIC_ERR_DETAIL = "aic_err_detail_dump";
const std::string ADUMP_DUMP_OPTYPE_BLACKLIST = "optype_blacklist";
const std::string ADUMP_DUMP_OPNAME_BLACKLIST = "opname_blacklist";
const std::string ADUMP_DUMP_OPNAME_RANGE = "opname_range";
const std::string ADUMP_DUMP_BLACKLIST_NAME = "name";
const std::string ADUMP_DUMP_BLACKLIST_POS = "pos";
const std::string ADUMP_DUMP_OPNAME_RANGE_BEGIN = "begin";
const std::string ADUMP_DUMP_OPNAME_RANGE_END = "end";
const std::string ADUMP_DUMP_KERNEL_DATA = "dump_kernel_data";
const std::string ADUMP_DUMP_KERNEL_DATA_ALL = "all";
const std::string ADUMP_DUMP_KERNEL_DATA_PRINTF = "printf";
const std::string ADUMP_DUMP_KERNEL_DATA_TENSOR = "tensor";
const std::string ADUMP_DUMP_KERNEL_DATA_ASSERT = "assert";
const std::string ADUMP_DUMP_KERNEL_DATA_TIMESTAMP = "timestamp";
const std::string ADUMP_DUMP_STATS_MAX = "Max";
const std::string ADUMP_DUMP_STATS_MIN = "Min";
const std::string ADUMP_DUMP_STATS_AVG = "Avg";
const std::string ADUMP_DUMP_STATS_NAN = "Nan";
const std::string ADUMP_DUMP_STATS_NEG_INF = "Negative Inf";
const std::string ADUMP_DUMP_STATS_POS_INF = "Positive Inf";
const std::string ADUMP_DUMP_STATS_L2NORM = "L2norm";

constexpr int32_t MAX_DUMP_PATH_LENGTH = 512;
constexpr int32_t MAX_IPV4_ADDRESS_VALUE = 255;
constexpr int32_t MAX_IPV4_ADDRESS_LENGTH = 4;
constexpr size_t MAX_DUMP_STEP_INTERVAL_COUNT = 100U;
constexpr size_t MAX_BLACKLIST_SIZE = 100U;
// 使能exception dump
const std::string ADUMP_ENV_ASCEND_DUMP_SCENE = "ASCEND_DUMP_SCENE";
// 设置dump路径(使能Kernel内DFX DUMP功能)
const std::string ADUMP_ENV_ASCEND_DUMP_PATH = "ASCEND_DUMP_PATH";
// 使能L1 exception dump(优先级低于ASCEND_DUMP_SCENE)
const std::string ADUMP_ENV_NPU_COLLECT_PATH = "NPU_COLLECT_PATH";
// 设置dump路径(使能Kernel内DFX DUMP功能，优先级低于ASCEND_DUMP_PATH)
const std::string ADUMP_ENV_ASCEND_WORK_PATH = "ASCEND_WORK_PATH";

struct RawDumpConfig
{
    std::string dumpPath;
    std::string dumpMode;
    std::string dumpData;
    std::string dumpKernelData;
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
    bool isLayer = false;
    bool isModelName = false;
    bool isWatcherNodes = false;
    std::vector<AclDumpBlacklist> optypeBlacklist;
    std::vector<AclDumpBlacklist> opnameBlacklist;
    std::vector<OpNameRange> dumpOpNameRanges;
};

struct DumpEnvVariable {
    std::string ascendDumpScene;
    std::string ascendDumpPath;
    std::string npuCollectPath;
    std::string ascendWorkPath;
};

struct DumpDfxConfig {
    std::string dumpPath;
    std::vector<std::string> dfxTypes;
};

class DumpConfigConverter
{
public:
    DumpConfigConverter(const char *dumpConfigData, size_t dumpConfigSize, const char *dumpConfigPath = "null")
        : dumpConfigData_(dumpConfigData), dumpConfigSize_(dumpConfigSize), configPath_(dumpConfigPath) {}
    ~DumpConfigConverter() = default;

    int32_t Convert(DumpType &dumpType, DumpConfig &dumpConfig, bool &needDump, DumpDfxConfig &dumpDfxConfig);
    static bool EnableExceptionDumpWithEnv(DumpConfig &dumpConfig, DumpType &dumpType);
    static bool EnableKernelDfxDumpWithEnv(DumpDfxConfig &config);
    static std::string DumpTypeToStr(const DumpType dumpType);

private:
    bool CheckDumpFieldTypes() const;
    bool CheckDumpFieldValues() const;
    bool CheckDumpConstraints() const;
    bool CheckDumpListFieldTypes() const;

    bool CheckDumpScene(std::string &dumpScene) const;
    bool CheckWatcherDumpScene(const std::string &dumpScene) const;
    bool CheckExceptionDumpScene(const std::string &dumpScene) const;

    bool CheckDumpPath() const;
    bool CheckDumpDebug(std::string &dumpDebug) const;
    bool CheckDumpStats() const;
    bool CheckDumpStep() const;

    bool CheckDumplist(const std::string &dumpLevel) const;
    
    // dump_list 校验子函数
    bool CheckModelNameAndLayer(const AclModelDumpConfig &item, const std::string &itemPath) const;
    bool CheckWatcherSceneConstraints(const AclModelDumpConfig &item, const std::string &itemPath,
        const std::string &dumpScene) const;
    bool CheckBlacklistSize(const AclModelDumpConfig &item, const std::string &itemPath) const;
    bool CheckBlacklistWithDumpLevel(const AclModelDumpConfig &item, const std::string &itemPath,
        const std::string &dumpLevel) const;
    bool CheckOpNameRange(const AclModelDumpConfig &item, const std::string &itemPath,
        const std::string &dumpLevel) const;
    bool CheckDumpListItems(const std::vector<AclModelDumpConfig> &dumpList, const std::string &dumpLevel,
        const std::string &dumpScene, bool isSwitchOff) const;

    bool CheckFieldValue(const nlohmann::json &js, const std::string &key) const;
    bool CheckKernelDataValues(const std::string &kernelData) const;
    bool CheckDumpStatsValues() const;
    bool CheckStringField(const nlohmann::json &js, const std::string &key, const std::string &basePath) const;
    bool CheckDumpListItemFieldTypes(const nlohmann::json &item, const std::string &basePath) const;
    bool CheckArrayOfString(const nlohmann::json &arr, const std::string &basePath) const;
    bool CheckArrayOfObject(const nlohmann::json &arr, const std::string &basePath) const;
    bool CheckArrayOfType(const nlohmann::json &arr, const std::string &basePath, bool isStringType) const;
    bool CheckBlacklistFieldTypes(const nlohmann::json &blacklistArray, const std::string &basePath) const;
    bool CheckBlacklistItemFieldTypes(const nlohmann::json &blacklistItem, const std::string &basePath) const;
    bool CheckOpnameRangeFieldTypes(const nlohmann::json &rangeArray, const std::string &basePath) const;
    bool CheckOpnameRangeItemFieldTypes(const nlohmann::json &rangeItem, const std::string &basePath) const;

    void ParseDfxTypesFromJson(const RawDumpConfig &rawDumpConfig, DumpDfxConfig &dumpDfxConfig) const;
    void EnsureDefaultDfxType(const DumpType &dumpType, DumpDfxConfig &dumpDfxConfig) const;
    DumpConfig ConvertDumpConfig(const RawDumpConfig &rawDumpConfig) const;
    DumpType ConvertDumpType(const RawDumpConfig &rawDumpConfig) const;

    std::string BuildIndexedPath(const std::string &base, size_t index) const;
    std::string BuildPath(const std::string &base, const std::string &key) const;
    void Split(const std::string &str, const char delim, std::vector<std::string> &elems) const;
    bool IsDigit(const std::string &str) const;
    bool IsValueValid(const std::string key, const std::string value, const std::string &errorPath = "") const;
    bool ConflictWith(const std::string key, const std::string value) const;
    bool CheckIpAddress(const std::string dumpPath) const;
    bool NeedDump(const RawDumpConfig &rawDumpConfig) const;
    static std::string TransOptionsToStr(const std::set<std::string> &options);
    static bool ConvertDumpScene(const std::string dumpScene, DumpType &dumpType);
    static bool GetEnvVariable(const std::string &env, std::string &value);
    static bool CheckDumpPath(const std::string &param, const std::string &dumpPath);
    static bool GetEnvDumpPath(const std::string &env, std::string &envPath);
    static void LoadDumpEnvVariables(DumpEnvVariable &dumpEnvVariable);

    nlohmann::json dumpJs_;
    const char *dumpConfigData_;
    size_t dumpConfigSize_;
    const char *configPath_;
};

} // namespace Adx
#endif // DUMP_CONFIG_CONVERTER_H