/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DATA_CHECK_H
#define DATA_CHECK_H
#include <cstdint>
#include <map>
#include <vector>
#include <memory>
#include <unordered_map>
#include <string>
#include "msprof_stub.h"

namespace Cann {
namespace Dvvp {
namespace Test {
const std::string TASK_TIME = "taskTime";
const std::string TASK_TRACE = "taskTrace";
const std::string TS_TRACK_DATA = "ts_track.data";
const std::string COMMA = ",";
const std::string CROSSBAR = "--";
const std::string EQAL = "=";
const std::string SLASH= "\"";
const std::string COLON= "\":\"";
const std::string COLONBOUND= ":";
const std::string APPLICATION = "application";
const std::string OUTPUT = "output";
const std::string SWITCH = "switch";
const std::string STORAGE_LIMIT_UNIT = "MB";
const std::string PROF_DIR = "PROF";
const std::string DEVICE_DIR = "device";
const std::string HOST_DIR = "host";
const std::string DATA_DIR = "data";
const int32_t PRE_PARAMS_CHECK_SUCCESS = 0;
const int32_t PRE_PARAMS_CHECK_FAILED = -1;
const int32_t FLUSH_DATA_CHECK_SUCCESS = 0;
const int32_t FLUSH_DATA_CHECK_FAILED = -1;

const std::unordered_map<std::string, std::string> INTERNAL_SWITCH_MAP = {
    {"ascendcl", "acl"}, // switch
    {"ai-core", "ai_core_profiling"},
    {"ai-vector-core", "aiv_profiling"},
    {"runtime-api", "runtimeApi"},
    {"task-tsfw", "taskTsfw"},
    {"task-time", "taskTime"},
    {"fwk-schedule", "fwkSchedule"},
    {"task-trace", "taskTrace"},
    {"task-memory", "taskMemory"},
    {"aicpu", "aicpuTrace"},
    {"msproftx", "msproftx"},
    {"sys-cpu-profiling", "cpu_profiling"},
    {"sys-profiling", "sys_profiling"},
    {"sys-pid-profiling", "pid_profiling"},
    {"sys-hardware-mem", "hardware_mem"},
    {"sys-io-profiling", "io_profiling"},
    {"sys-interconnection-profiling", "interconnection_profiling"},
    {"instr-profiling", "instrProfiling"},
    {"dvpp-profiling", "dvpp_profiling"},
    {"task-block", "taskBlock"},
    {"sys-lp", "sysLp"},
    {"sys-lp-freq", "sysLpFreq"},
    {"hccl", "hcclTrace"},
    {"l2", "l2CacheTaskProfiling"},
    {"aic-freq", "aicore_sampling_interval"}, // bound
    {"aiv-freq", "aiv_sampling_interval"},
    {"sys-devices", "devices"},
    {"sys-period", "profiling_period"},
    {"sys-sampling-freq", "sys_sampling_interval"},
    {"sys-pid-sampling-freq", "pid_sampling_interval"},
    {"sys-hardware-mem-freq", "hardware_mem_sampling_interval"},
    {"sys-io-sampling-freq", "io_sampling_interval"},
    {"dvpp-freq", "dvpp_sampling_interval"},
    {"sys-cpu-freq", "cpu_sampling_interval"},
    {"sys-interconnection-freq", "interconnection_sampling_interval"},
    {"iteration-id", "exportIterationId"},
    {"instr-profiling-freq", "instrProfilingFreq"},
    {"model-id", "exportModelId"},
    {"storage-limit","storageLimit"}, // mapping
    {"aic-mode","ai_core_profiling_mode"},
    {"aic-metrics","ai_core_metrics"},
    {"aiv-mode","aiv_profiling_mode"},
    {"aiv-metrics","aiv_metrics"},
    {"llc-profiling","llc_profiling"},
    {"delay","delayTime"},
    {"duration","durationTime"},
};

const std::unordered_map<std::string, std::vector<int64_t>> BOUND_MAP = {
    {"aic-freq", {10, 1000}},
    {"aiv-freq", {10, 1000}},
    {"sys-period", {0, 2592000}},
    {"sys-sampling-freq", {100, 1000}},
    {"sys-pid-sampling-freq", {100, 1000}},
    {"sys-hardware-mem-freq", {10, 1000}},
    {"sys-io-sampling-freq", {10, 1000}},
    {"dvpp-freq", {10, 1000}},
    {"sys-cpu-freq", {20, 1000}},
    {"sys-interconnection-freq", {20, 1000}},
    {"instr-profiling-freq", {300, 30000}},
    {"storage-limit", {200, 4294967296}},
    {"sys-lp-freq", {100, 1000000}},
};

const std::map<std::string, std::vector<std::string>> MAPPING_MAP = {
    {"hardware_mem", {"memProfiling", "ddr_profiling", "hbmProfiling"}},
    {"cpu_profiling", {"tsCpuProfiling", "aiCtrlCpuProfiling"}},
    {"interconnection_profiling", {"pcieProfiling", "hccsProfiling"}},
    {"io_profiling", {"nicProfiling", "roceProfiling"}},
    {"ai-core", {"ai_core_lpm"}},
};

const std::map<std::string, std::string> DEFAULT_MAP = {
    {"acl", "on"},
    {"ai_core_profiling", "on"},
    {"aiv_profiling", "on"},
    {"ai_core_profiling_mode", "task-based"},
    {"aiv_profiling_mode", "task-based"},
    {"ts_keypoint", "on"},
    {"ts_memcpy", "on"},
};

const std::map<StPlatformType, std::string> DEFAULT_PLATFORM_MAP = {
    {StPlatformType::MINI_TYPE, "ts_timeline"},
    {StPlatformType::CLOUD_TYPE, "hwts_log"},
    {StPlatformType::MDC_TYPE, "hwts_log"},
    {StPlatformType::DC_TYPE, "hwts_log"},
    {StPlatformType::CHIP_V4_1_0, "stars_acsq_task"},
    {StPlatformType::MINI_V3_TYPE, "stars_acsq_task"},
    {StPlatformType::CHIP_MDC_LITE, "hwts_log"},
    {StPlatformType::CHIP_CLOUD_V3, "stars_acsq_task"},
};

class DataCheck {
public:
    DataCheck() {}
    virtual ~DataCheck() {}
    int32_t PreParamsChecker(std::string env);
    int32_t PreCheckOnOff(std::string sw, std::string val, std::string env);
    int32_t PreCheckBound(std::string sw, std::string val, std::string env);
    int32_t PreCheckMapping(std::string env);
    int32_t PreCheckDefault(std::string env);
    int32_t PreCheckStorageLimit(std::string sw, std::string val, std::string env);
    int32_t PreCheckIfNumberSwitch(std::string sw, std::string val);

    int32_t ReadNextDir(std::string &path, std::string pattern);
    int32_t ReadDataDir(std::string &dataPath, std::string dirType, std::string inType);
    int32_t CheckIfFileExist(std::string dataPath, std::string pattern, bool mustExist = true);

    int32_t flushDataChecker(std::string path, std::string mode);
    int32_t DeviceDataCheck(std::string deviceDataPath);
    int32_t CheckData(std::vector<std::string> &dataList, std::vector<std::string> &blackDataList,
        std::string dataPath, std::string dataType);
    int32_t HandleDataCheck(std::string &dataPath);
    int32_t HandleDataCheck(std::string &dataPath, std::string dataType);
    int32_t bitSwitchChecker();
    uint32_t GetPlatformType();

private:
    std::map<std::string, std::string> PreCheckSwitch_;
    std::string Ltrim(const std::string &str, const std::string &tripString);
};

}
}
}
#endif