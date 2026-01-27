/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_MESSAGE_PROFILE_PARAMS_H
#define ANALYSIS_DVVP_MESSAGE_PROFILE_PARAMS_H
#include <set>
#include <vector>
#include <sstream>
#include "msprof_dlog.h"
#include "config/config.h"
#include "utils/utils.h"
#include "message.h"

namespace analysis {
namespace dvvp {
namespace message {
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::utils;
const char * const PROFILING_MODE_SAMPLE_BASED = "sample-based";
const char * const PROFILING_MODE_TASK_BASED = "task-based";
const char * const PROFILING_ANALYSIS_TARGET = "launch application";
const char * const PROFILING_MODE_DEF = "def_mode";
const char * const PROFILING_MODE_SYSTEM_WIDE = "system-wide";
const std::string PROFILING_STATE_FILE = "job_state.ini";

// Attention:
// intervals of ProfileParams maybe large,
// remember to cast to long long before calculation (for example, convert ms to ns)
struct ProfileParams : public BaseInfo {
    std::string job_id;
    std::string result_dir;
    std::string storageLimit;
    std::string profiling_mode;
    std::string devices;
    int msprofBinPid;
    bool isCancel;
    int profiling_period;
    std::string profiling_options;
    std::string jobInfo;
    std::string profMode;
    // app
    std::string app;
    std::string app_dir;
    std::string app_parameters;
    std::string app_location;
    std::string app_env;
    std::string cmdPath;
    std::vector<std::string> application;
    // ai core
    std::string ai_core_profiling;
    int aicore_sampling_interval;
    std::string ai_core_profiling_mode;
    std::string ai_core_profiling_events;
    std::string ai_core_metrics;
    std::string ai_core_lpm;

    std::string aiv_profiling;
    int aiv_sampling_interval;
    std::string aiv_profiling_events;
    std::string aiv_metrics;
    std::string aiv_profiling_mode;
    std::string npuEvents;

    // rts
    std::string ai_core_status;
    std::string ts_task_track;
    std::string ts_task_time;
    std::string ts_cpu_usage;
    std::string ts_timeline;
    std::string ts_keypoint;
    std::string ts_memcpy;
    std::string taskTsfw;
    std::string ai_vector_status;
    std::string ts_fw_training;  // unused
    std::string hwts_log;
    std::string hwts_log1;
    std::string stars_acsq_task;
    std::string taskBlock;
    std::string taskBlockShink;
    std::string sysLp;
    int32_t sysLpFreq;
    std::string aicScale; // acp using
    std::string ccuInstr;

    // system trace
    std::string cpu_profiling;
    int cpu_sampling_interval;
    // cpu
    std::string hscb;
    std::string aiCtrlCpuProfiling;
    std::string ai_ctrl_cpu_profiling_events;
    std::string tsCpuProfiling;
    std::string ts_cpu_profiling_events;

    // sys mem, sys cpuusage, app mem, app cpuusage, qos
    std::string sys_profiling;
    int sys_sampling_interval;
    std::string pid_profiling;
    int pid_sampling_interval;

    std::string hardware_mem;
    int hardware_mem_sampling_interval;
    std::string llc_profiling;
    std::string msprof_llc_profiling;
    std::string memProfiling;
    int memInterval;
    std::string llc_profiling_events;
    int llc_interval;
    std::string ddr_profiling;
    std::string ddr_profiling_events;
    int ddr_interval;
    int ddr_master_id;
    std::string hbmProfiling;
    std::string hbm_profiling_events;
    int hbmInterval;
    std::string qosProfiling;
    std::string qosEvents;
    std::vector<uint8_t> qosEventId;
    std::string memServiceflow;

    std::string l2CacheTaskProfiling;
    std::string l2CacheTaskProfilingEvents;

    std::string io_profiling;
    int io_sampling_interval;
    std::string nicProfiling;
    int nicInterval;
    std::string roceProfiling;
    int roceInterval;

    std::string interconnection_profiling;
    int interconnection_sampling_interval;
    std::string hccsProfiling;
    int32_t hccsInterval;
    std::string pcieProfiling;
    int32_t pcieInterval;
    std::string ubProfiling;
    int32_t ubInterval;

    std::string dvpp_profiling;
    int dvpp_sampling_interval;

    std::string ai_core_profiling_metrics;
    std::string aiv_profiling_metrics;
    std::string ts_cpu_hot_function;

    std::string pcSampling;
    std::string instrProfiling;
    int32_t instrProfilingFreq;

    // for msprof
    std::string acl;
    std::string runtimeApi;
    std::string aicpuTrace;
    std::string runtimeTrace;
    std::string hcclTrace;
    std::string msprof;
    std::string msproftx;
    std::string mstxDomainInclude;
    std::string mstxDomainExclude;
    std::string taskTrace;
    std::string taskTime;
    std::string taskMemory;
    std::string prof_level;
    std::string geApi;
    std::string scaleType;
    std::string scaleName;

    // host sys
    std::string host_sys;
    int host_sys_pid;
    std::string hostSysUsage;
    uint32_t hostProfilingSamplingInterval;
    std::string host_disk_profiling;
    std::string host_osrt_profiling;
    std::string pureCpu;

    // app cpu/memory/network usage on host
    bool hostProfiling;
    std::string host_cpu_profiling;
    std::string host_mem_profiling;
    std::string hostAllPidCpuProfiling;
    std::string hostAllPidMemProfiling;
    std::string host_network_profiling;
    int host_disk_freq;

    // for parse, query and export
    std::string pythonPath;
    std::string parseSwitch;
    std::string querySwitch;
    std::string exportSwitch;
    std::string clearSwitch;
    std::string exportSummaryFormat;
    std::string exportType;
    std::string reportsPath;
    std::string analyzeSwitch;
    std::string analyzeRuleSwitch;
    std::string exportIterationId;
    std::string exportModelId;

    // subset of MsprofArgsType
    std::set<int32_t> usedParams;

    // for dynamic profiling
    std::string dynamic;
    std::string pid;
    std::string delayTime;
    std::string durationTime;

    ProfileParams()
        : msprofBinPid(MSVP_PROCESS), isCancel(false), profiling_period(-1),
          profiling_options(""), profMode(""),
          aicore_sampling_interval(DEFAULT_PROFILING_INTERVAL_10MS), ai_core_lpm("off"),
          aiv_sampling_interval(DEFAULT_PROFILING_INTERVAL_10MS), npuEvents(""), taskTsfw("off"), sysLp("off"),
          sysLpFreq(DEFAULT_PROFILING_INTERVAL_10000US), aicScale("all"), ccuInstr("off"), cpu_profiling("off"),
          cpu_sampling_interval(DEFAULT_PROFILING_INTERVAL_20MS),
          hscb("off"), aiCtrlCpuProfiling("off"), tsCpuProfiling("off"),
          sys_profiling("off"), sys_sampling_interval(DEFAULT_PROFILING_INTERVAL_100MS),
          pid_profiling("off"), pid_sampling_interval(DEFAULT_PROFILING_INTERVAL_100MS),
          hardware_mem("off"), hardware_mem_sampling_interval(DEFAULT_PROFILING_INTERVAL_20000US),
          memProfiling("off"), memInterval(DEFAULT_PROFILING_INTERVAL_20MS),
          llc_interval(DEFAULT_PROFILING_INTERVAL_20MS),
          ddr_interval(DEFAULT_PROFILING_INTERVAL_20MS), ddr_master_id(0),
          hbmInterval(DEFAULT_PROFILING_INTERVAL_20MS),
          io_profiling("off"), io_sampling_interval(DEFAULT_PROFILING_INTERVAL_10MS),
          nicProfiling("off"), nicInterval(DEFAULT_PROFILING_INTERVAL_10MS),
          roceProfiling("off"), roceInterval(DEFAULT_PROFILING_INTERVAL_10MS),
          interconnection_profiling("off"), interconnection_sampling_interval(DEFAULT_PROFILING_INTERVAL_20MS),
          hccsProfiling("off"), hccsInterval(DEFAULT_PROFILING_INTERVAL_20MS),
          pcieInterval(DEFAULT_PROFILING_INTERVAL_20MS), ubProfiling("off"), ubInterval(DEFAULT_PROFILING_INTERVAL_20MS),
          dvpp_profiling("off"), dvpp_sampling_interval(DEFAULT_PROFILING_INTERVAL_20MS),
          pcSampling("off"), instrProfilingFreq(DEFAULT_PROFILING_INTERVAL_1000MS),
          runtimeApi("off"), msprof("off"), msproftx("off"), mstxDomainInclude(""), mstxDomainExclude(""),
          taskTrace("on"), taskTime("on"), taskMemory("off"),
          prof_level("off"), geApi("off"), scaleType(""), scaleName(""), host_sys(""),
          host_sys_pid(HOST_PID_DEFAULT), hostSysUsage(""),
          hostProfilingSamplingInterval(DEFAULT_PROFILING_INTERVAL_20MS), host_disk_profiling("off"),
          host_osrt_profiling("off"), pureCpu("off"), hostProfiling(false), host_cpu_profiling("off"),
          host_mem_profiling("off"), hostAllPidCpuProfiling("off"), hostAllPidMemProfiling("off"),
          host_network_profiling("off"), host_disk_freq(DEFAULT_PROFILING_INTERVAL_50MS),
          pythonPath(""), parseSwitch("off"), querySwitch("off"), exportSwitch("off"), clearSwitch("off"),
          exportSummaryFormat(PROFILING_SUMMARY_FORMAT), exportType(PROFILING_EXPORT_TYPE_TEXT), reportsPath(""),
          analyzeSwitch("off"), analyzeRuleSwitch("communication,communication_matrix"),
          exportIterationId(DEFAULT_INTERATION_ID), exportModelId(DEFAULT_MODEL_ID), usedParams(),
          delayTime(""), durationTime("")
    {
    }

    ~ProfileParams() override {}

    std::string GetStructName() override
    {
        return "ProfileParams";
    }

    void PrintAllFields()
    {
        if (CheckLogLevel(MSPROF_MODULE_NAME, DLOG_INFO) != 0) {
            NanoJson::Json object;
            ToObject(object);
            std::stringstream ss;
            for (auto iter = object.Begin(); iter != object.End(); ++iter) {
                ss << iter->first << ": ";
                if (iter->first == "result_dir" || iter->first == "app_dir") {
                    ss << "***/" << Utils::BaseName(iter->second());
                } else {
                    ss << (iter->second());
                }
                if ((iter->first.find("interval") != std::string::npos &&
                    iter->first.find("hardware_mem_sampling_interval") == std::string::npos) ||
                    iter->first.find("memInterval") != std::string::npos ||
                    iter->first.find("ubInterval") != std::string::npos ||
                    iter->first.find("hccsInterval") != std::string::npos ||
                    iter->first.find("nicInterval") != std::string::npos ||
                    iter->first.find("pcieInterval") != std::string::npos ||
                    iter->first.find("roceInterval") != std::string::npos ||
                    iter->first.find("hbmInterval") != std::string::npos ||
                    iter->first.find("hostProfilingSamplingInterval")) {
                    ss << "ms";
                }
                if (iter->first.find("hardware_mem_sampling_interval") != std::string::npos) {
                    ss << "us";
                }
                static size_t scalePrintLen = 128;
                if (iter->first.find("scale") != std::string::npos &&
                    ss.str().size() > scalePrintLen) {
                    MSPROF_LOGI("[PrintAllFields] %s...", ss.str().substr(0, scalePrintLen).c_str());
                    ss.str("");
                    continue;
                }
                MSPROF_LOGI("[PrintAllFields] %s", ss.str().c_str());
                ss.str("");
            }
        }
    }

    bool IsHostProfiling() const
    {
        if (host_cpu_profiling.compare("on") == 0 || host_mem_profiling.compare("on") == 0 ||
            hostAllPidCpuProfiling.compare("on") == 0 || hostAllPidMemProfiling.compare("on") == 0 ||
            host_network_profiling.compare("on") == 0 || host_disk_profiling.compare("on") == 0 ||
            host_osrt_profiling.compare("on") == 0 ||
            msproftx.compare("on") == 0) {
            return true;
        }
        return false;
    }

    bool IsMsprofTx() const
    {
        return msproftx == "on";
    }

    void ToObjectPartOne(NanoJson::Json &object)
    {
        SET_VALUE(object, result_dir);
        SET_VALUE(object, storageLimit);
        SET_VALUE(object, profiling_mode);
        SET_VALUE(object, devices);
        SET_VALUE(object, ai_ctrl_cpu_profiling_events);
        SET_VALUE(object, ts_cpu_profiling_events);
        SET_VALUE(object, app_dir);
        SET_VALUE(object, app_parameters);
        SET_VALUE(object, app_location);
        SET_VALUE(object, app_env);
        // ai core
        SET_VALUE(object, ai_core_profiling);
        SET_VALUE(object, ai_core_profiling_mode);
        SET_VALUE(object, ai_core_profiling_events);
        SET_VALUE(object, ai_core_metrics);
        SET_VALUE(object, ai_core_status);
        SET_VALUE(object, ai_core_lpm);
        // aiv
        SET_VALUE(object, aiv_profiling);
        SET_VALUE(object, aiv_sampling_interval);
        SET_VALUE(object, aiv_profiling_events);
        SET_VALUE(object, aiv_metrics);
        SET_VALUE(object, aiv_profiling_mode);
        SET_VALUE(object, isCancel);
        SET_VALUE(object, profiling_options);
        SET_VALUE(object, jobInfo);
        SET_VALUE(object, npuEvents);
        // system trace
        SET_VALUE(object, cpu_profiling);
        SET_VALUE(object, hscb);
        SET_VALUE(object, aiCtrlCpuProfiling);
        SET_VALUE(object, tsCpuProfiling);
        SET_VALUE(object, cpu_sampling_interval);
        SET_VALUE(object, sys_profiling);
        SET_VALUE(object, sys_sampling_interval);
        SET_VALUE(object, pid_profiling);
        SET_VALUE(object, pid_sampling_interval);
        SET_VALUE(object, hardware_mem);
        SET_VALUE(object, hardware_mem_sampling_interval);
        SET_VALUE(object, memServiceflow);
        SET_VALUE(object, io_profiling);
        SET_VALUE(object, io_sampling_interval);
        SET_VALUE(object, interconnection_profiling);
        SET_VALUE(object, interconnection_sampling_interval);
        SET_VALUE(object, dvpp_profiling);
        SET_VALUE(object, ai_core_profiling_metrics);
        SET_VALUE(object, aiv_profiling_metrics);
        SET_VALUE(object, ts_cpu_hot_function);
        SET_VALUE(object, nicProfiling);
        SET_VALUE(object, roceProfiling);
        // host system
        SET_VALUE(object, hostProfiling);
        SET_VALUE(object, host_cpu_profiling);
        SET_VALUE(object, host_mem_profiling);
        SET_VALUE(object, host_network_profiling);
        SET_VALUE(object, pureCpu);
    }

    void ToObjectPartTwo(NanoJson::Json &object)
    {
        SET_VALUE(object, dvpp_sampling_interval);
        SET_VALUE(object, aicore_sampling_interval);
        SET_VALUE(object, acl);
        SET_VALUE(object, runtimeApi);
        SET_VALUE(object, aicpuTrace);
        SET_VALUE(object, runtimeTrace);
        SET_VALUE(object, hcclTrace);
        SET_VALUE(object, msprof);
        SET_VALUE(object, msproftx);
        SET_VALUE(object, mstxDomainInclude);
        SET_VALUE(object, mstxDomainExclude);
        SET_VALUE(object, taskTrace);
        SET_VALUE(object, taskTime);
        SET_VALUE(object, taskMemory);
        SET_VALUE(object, prof_level);
        SET_VALUE(object, geApi);
        SET_VALUE(object, scaleType);
        SET_VALUE(object, scaleName);
        SET_VALUE(object, job_id);
        SET_VALUE(object, app);
        SET_VALUE(object, ts_task_track);
        SET_VALUE(object, ts_task_time);
        SET_VALUE(object, ts_cpu_usage);
        SET_VALUE(object, ts_timeline);
        SET_VALUE(object, ts_memcpy);
        SET_VALUE(object, ts_keypoint);
        SET_VALUE(object, ai_vector_status);
        SET_VALUE(object, taskTsfw);
        SET_VALUE(object, ts_fw_training);
        SET_VALUE(object, hwts_log);
        SET_VALUE(object, hwts_log1);
        SET_VALUE(object, l2CacheTaskProfiling);
        SET_VALUE(object, l2CacheTaskProfilingEvents);
        SET_VALUE(object, hccsProfiling);
        SET_VALUE(object, hccsInterval);
        SET_VALUE(object, pcieProfiling);
        SET_VALUE(object, pcieInterval);
        SET_VALUE(object, ubProfiling);
        SET_VALUE(object, ubInterval);
        SET_VALUE(object, roceInterval);
        SET_VALUE(object, nicInterval);
        // llc
        SET_VALUE(object, llc_profiling);         // for analysis use, read, write, capacity
        SET_VALUE(object, msprof_llc_profiling); // for msprof self use, on or off
        SET_VALUE(object, llc_profiling_events);
        SET_VALUE(object, llc_interval);
        // pcSampling
        SET_VALUE(object, pcSampling);
        // instr profiling
        SET_VALUE(object, instrProfiling);
        SET_VALUE(object, instrProfilingFreq);
        // memory
        SET_VALUE(object, memProfiling);
        SET_VALUE(object, memInterval);
        // ddr
        SET_VALUE(object, ddr_profiling);
        SET_VALUE(object, ddr_profiling_events);
        SET_VALUE(object, ddr_interval);
        SET_VALUE(object, ddr_master_id);
        // hbm
        SET_VALUE(object, hbmProfiling);
        SET_VALUE(object, hbm_profiling_events);
        SET_VALUE(object, hbmInterval);
        // for debug purpose
        SET_VALUE(object, profiling_period);
        // host
        SET_VALUE(object, host_sys);
        SET_VALUE(object, host_sys_pid);
        SET_VALUE(object, host_disk_profiling);
        SET_VALUE(object, host_osrt_profiling);
        SET_VALUE(object, host_disk_freq);
    }

    void ToObjectPartThree(NanoJson::Json &object)
    {
        SET_VALUE(object, stars_acsq_task);
        SET_VALUE(object, taskBlock);
        SET_VALUE(object, taskBlockShink);
        SET_VALUE(object, sysLp);
        SET_VALUE(object, sysLpFreq);
        SET_VALUE(object, aicScale);
        SET_VALUE(object, ccuInstr);
        SET_VALUE(object, msprofBinPid);
        SET_VALUE(object, delayTime);
        SET_VALUE(object, durationTime);
        SET_VALUE(object, profMode);
        // qos
        SET_VALUE(object, qosProfiling);
        SET_VALUE(object, qosEvents);
        // host
        SET_VALUE(object, hostSysUsage);
        SET_VALUE(object, hostProfilingSamplingInterval);
        SET_VALUE(object, hostAllPidCpuProfiling);
        SET_VALUE(object, hostAllPidMemProfiling);
    }

    void ToObject(NanoJson::Json &object) override
    {
        ToObjectPartOne(object);
        ToObjectPartTwo(object);
        ToObjectPartThree(object);
    }

    void FromObjectPartOne(NanoJson::Json &object)
    {
        FROM_STRING_VALUE(object, result_dir);
        FROM_STRING_VALUE(object, storageLimit);
        FROM_STRING_VALUE(object, profiling_mode);
        FROM_STRING_VALUE(object, devices);
        FROM_STRING_VALUE(object, ai_ctrl_cpu_profiling_events);
        FROM_STRING_VALUE(object, ts_cpu_profiling_events);
        FROM_STRING_VALUE(object, app_dir);
        FROM_STRING_VALUE(object, app_parameters);
        FROM_STRING_VALUE(object, app_location);
        FROM_STRING_VALUE(object, app_env);
        // ai core
        FROM_STRING_VALUE(object, ai_core_profiling);
        FROM_STRING_VALUE(object, ai_core_profiling_mode);
        FROM_STRING_VALUE(object, ai_core_profiling_events);
        FROM_STRING_VALUE(object, ai_core_metrics);
        FROM_STRING_VALUE(object, ai_core_status);
        FROM_STRING_VALUE(object, ai_core_lpm);
        // AIV
        FROM_STRING_VALUE(object, aiv_profiling);
        FROM_INT_VALUE(object, aiv_sampling_interval, DEFAULT_PROFILING_INTERVAL_10MS);
        FROM_STRING_VALUE(object, aiv_metrics);
        FROM_STRING_VALUE(object, aiv_profiling_mode);
        FROM_STRING_VALUE(object, aiv_profiling_events);
        FROM_BOOL_VALUE(object, isCancel);
        FROM_STRING_VALUE(object, profiling_options);
        FROM_STRING_VALUE(object, jobInfo);
        FROM_STRING_VALUE(object, npuEvents);
        // system trace
        FROM_STRING_VALUE(object, cpu_profiling);
        FROM_STRING_VALUE(object, hscb);
        FROM_STRING_VALUE(object, aiCtrlCpuProfiling);
        FROM_STRING_VALUE(object, tsCpuProfiling);
        FROM_INT_VALUE(object, cpu_sampling_interval, DEFAULT_PROFILING_INTERVAL_10MS);
        FROM_STRING_VALUE(object, sys_profiling);
        FROM_INT_VALUE(object, sys_sampling_interval, DEFAULT_PROFILING_INTERVAL_10MS);
        FROM_STRING_VALUE(object, pid_profiling);
        FROM_INT_VALUE(object, pid_sampling_interval, DEFAULT_PROFILING_INTERVAL_10MS);
        FROM_STRING_VALUE(object, hardware_mem);
        FROM_INT_VALUE(object, hardware_mem_sampling_interval, DEFAULT_PROFILING_INTERVAL_20000US);
        FROM_STRING_VALUE(object, memServiceflow);
        FROM_STRING_VALUE(object, io_profiling);
        FROM_INT_VALUE(object, io_sampling_interval, DEFAULT_PROFILING_INTERVAL_10MS);
        FROM_STRING_VALUE(object, interconnection_profiling);
        FROM_INT_VALUE(object, interconnection_sampling_interval, DEFAULT_PROFILING_INTERVAL_10MS);
        FROM_STRING_VALUE(object, dvpp_profiling);
        FROM_STRING_VALUE(object, nicProfiling);
        FROM_STRING_VALUE(object, roceProfiling);
        FROM_INT_VALUE(object, dvpp_sampling_interval, DEFAULT_PROFILING_INTERVAL_10MS);
        FROM_INT_VALUE(object, aicore_sampling_interval, DEFAULT_PROFILING_INTERVAL_10MS);
        FROM_STRING_VALUE(object, pcSampling);
        FROM_STRING_VALUE(object, instrProfiling);
        FROM_INT_VALUE(object, instrProfilingFreq, DEFAULT_PROFILING_INTERVAL_1000MS);
        FROM_STRING_VALUE(object, ai_core_profiling_metrics);
        FROM_STRING_VALUE(object, aiv_profiling_metrics);
        // host system
        FROM_BOOL_VALUE(object, hostProfiling);
        FROM_STRING_VALUE(object, host_cpu_profiling);
        FROM_STRING_VALUE(object, pureCpu);
    }

    void FromObjectPartTwo(NanoJson::Json &object)
    {
        FROM_STRING_VALUE(object, ts_cpu_hot_function);
        FROM_STRING_VALUE(object, acl);
        FROM_STRING_VALUE(object, runtimeApi);
        FROM_STRING_VALUE(object, aicpuTrace);
        FROM_STRING_VALUE(object, runtimeTrace);
        FROM_STRING_VALUE(object, hcclTrace);
        FROM_STRING_VALUE(object, msprof);
        FROM_STRING_VALUE(object, msproftx);
        FROM_STRING_VALUE(object, mstxDomainInclude);
        FROM_STRING_VALUE(object, mstxDomainExclude);
        FROM_STRING_VALUE(object, taskTrace);
        FROM_STRING_VALUE(object, taskTime);
        FROM_STRING_VALUE(object, taskMemory);
        FROM_STRING_VALUE(object, prof_level);
        FROM_STRING_VALUE(object, geApi);
        FROM_STRING_VALUE(object, scaleType);
        FROM_STRING_VALUE(object, scaleName);
        FROM_STRING_VALUE(object, job_id);
        FROM_STRING_VALUE(object, app);
        FROM_STRING_VALUE(object, ts_task_track);
        FROM_STRING_VALUE(object, ts_task_time);
        FROM_STRING_VALUE(object, ts_cpu_usage);
        FROM_STRING_VALUE(object, ts_timeline);
        FROM_STRING_VALUE(object, ts_memcpy);
        FROM_STRING_VALUE(object, ts_keypoint);
        FROM_STRING_VALUE(object, ai_vector_status);
        FROM_STRING_VALUE(object, taskTsfw);
        FROM_STRING_VALUE(object, ts_fw_training);
        FROM_STRING_VALUE(object, hwts_log);
        FROM_STRING_VALUE(object, hwts_log1);
        FROM_STRING_VALUE(object, stars_acsq_task);
        FROM_STRING_VALUE(object, taskBlock);
        FROM_STRING_VALUE(object, taskBlockShink);
        FROM_STRING_VALUE(object, sysLp);
        FROM_INT_VALUE(object, sysLpFreq, DEFAULT_PROFILING_INTERVAL_10000US);
        FROM_STRING_VALUE(object, aicScale);
        FROM_STRING_VALUE(object, ccuInstr);
        FROM_STRING_VALUE(object, l2CacheTaskProfiling);
        FROM_STRING_VALUE(object, l2CacheTaskProfilingEvents);
        FROM_STRING_VALUE(object, hccsProfiling);
        FROM_INT_VALUE(object, hccsInterval, DEFAULT_PROFILING_INTERVAL_100MS);
        FROM_STRING_VALUE(object, pcieProfiling);
        FROM_INT_VALUE(object, pcieInterval, DEFAULT_PROFILING_INTERVAL_100MS);
        FROM_STRING_VALUE(object, ubProfiling);
        FROM_INT_VALUE(object, ubInterval, DEFAULT_PROFILING_INTERVAL_20MS);
        FROM_INT_VALUE(object, roceInterval, DEFAULT_PROFILING_INTERVAL_10MS);
        FROM_INT_VALUE(object, nicInterval, DEFAULT_PROFILING_INTERVAL_10MS);
        // llc
        FROM_STRING_VALUE(object, llc_profiling);
        FROM_STRING_VALUE(object, msprof_llc_profiling);
        FROM_STRING_VALUE(object, llc_profiling_events);
        FROM_INT_VALUE(object, llc_interval, DEFAULT_PROFILING_INTERVAL_100MS);
    }

    void FromObjectPartThree(NanoJson::Json &object)
    {
        FROM_STRING_VALUE(object, profMode);
        FROM_INT_VALUE(object, msprofBinPid, MSVP_PROCESS);
        // memory
        FROM_STRING_VALUE(object, memProfiling);
        FROM_INT_VALUE(object, memInterval, DEFAULT_PROFILING_INTERVAL_10MS);
        // ddr
        FROM_STRING_VALUE(object, ddr_profiling);
        FROM_STRING_VALUE(object, ddr_profiling_events);
        FROM_INT_VALUE(object, ddr_interval, DEFAULT_PROFILING_INTERVAL_20MS);
        FROM_INT_VALUE(object, ddr_master_id, 0);
        // hbm
        FROM_STRING_VALUE(object, hbmProfiling);
        FROM_STRING_VALUE(object, hbm_profiling_events);
        FROM_INT_VALUE(object, hbmInterval, DEFAULT_PROFILING_INTERVAL_20MS);
        // qos
        FROM_STRING_VALUE(object, qosProfiling);
        FROM_STRING_VALUE(object, qosEvents);

        // for debug purpose
        FROM_INT_VALUE(object, profiling_period, DEFAULT_PROFILING_INTERVAL_5MS);
        // host
        FROM_STRING_VALUE(object, host_sys);
        FROM_INT_VALUE(object, host_sys_pid, HOST_PID_DEFAULT);
        FROM_STRING_VALUE(object, hostSysUsage);
        FROM_INT_VALUE(object, hostProfilingSamplingInterval, DEFAULT_PROFILING_INTERVAL_20MS);
        FROM_STRING_VALUE(object, host_disk_profiling);
        FROM_STRING_VALUE(object, host_osrt_profiling);
        FROM_INT_VALUE(object, host_disk_freq, DEFAULT_PROFILING_INTERVAL_10MS);
        FROM_STRING_VALUE(object, host_mem_profiling);
        FROM_STRING_VALUE(object, host_network_profiling);
        FROM_STRING_VALUE(object, hostAllPidCpuProfiling);
        FROM_STRING_VALUE(object, hostAllPidMemProfiling);
        FROM_STRING_VALUE(object, delayTime);
        FROM_STRING_VALUE(object, durationTime);
    }

    void FromObject(NanoJson::Json &object) override
    {
        FromObjectPartOne(object);
        FromObjectPartTwo(object);
        FromObjectPartThree(object);
    }
};
}  // namespace message
}  // namespace dvvp
}  // namespace analysis
#endif // ANALYSIS_DVVP_MESSAGE_PROFILE_PARAMS_H
