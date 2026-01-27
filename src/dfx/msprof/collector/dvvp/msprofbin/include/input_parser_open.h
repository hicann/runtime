/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef INPUT_PARSER_OPEN_H
#define INPUT_PARSER_OPEN_H
#include <string>
#include <utils/utils.h>
#include "proto/profiler.pb.h"
#include "message/prof_params.h"
#include "param_validation.h"
#include "osal.h"
#include "running_mode.h"
#include "config_manager.h"

namespace Analysis {
namespace Dvvp {
namespace Msprof {
using namespace analysis::dvvp::common::validation;
using namespace analysis::dvvp::common::utils;

using MsprofStringBuffer = const char *;
using MsprofString = const char *;
using MsprofStrBufAddrT = const char **;

enum MsprofArgsType {
    ARGS_HELP = 0,
    // cmd
    ARGS_OUTPUT,
    ARGS_STORAGE_LIMIT,
    ARGS_APPLICATION,
    ARGS_ENVIRONMENT,
    ARGS_DYNAMIC_PROF,
    ARGS_DYNAMIC_PROF_PID,  // 1-2147483647
    ARGS_DELAY_PROF,
    ARGS_DURATION_PROF,
    ARGS_AIC_MODE,
    ARGS_AIC_METRICS,
    ARGS_AIV_MODE,
    ARGS_AIV_METRICS,
    ARGS_SYS_DEVICES,
    ARGS_LLC_PROFILING,
    ARGS_PYTHON_PATH,
    ARGS_SUMMARY_FORMAT,
    ARGS_EXPORT_TYPE,
    ARGS_REPORTS,
    ARGS_SCALE,
    ARGS_RULE,
    // switch
    ARGS_ASCENDCL,
    ARGS_AI_CORE,
    ARGS_AIV,
    ARGS_MODEL_EXECUTION,
    ARGS_RUNTIME_API,
    ARGS_TASK_TIME,
    ARGS_GE_API,
    ARGS_TASK_MEMORY,
    ARGS_AICPU,
    ARGS_MSPROFTX,
    ARGS_MSTX_DOMAIN_INCLUDE,
    ARGS_MSTX_DOMAIN_EXCLUDE,
    ARGS_CPU_PROFILING,
    ARGS_SYS_PROFILING,
    ARGS_PID_PROFILING,
    ARGS_HARDWARE_MEM,
    ARGS_IO_PROFILING,
    ARGS_INTERCONNECTION_PROFILING,
    ARGS_DVPP_PROFILING,
    ARGS_HCCL,
    ARGS_INSTR_PROFILING,
    ARGS_L2_PROFILING,
    ARGS_PARSE,
    ARGS_QUERY,
    ARGS_EXPORT,
    ARGS_CLEAR,
    ARGS_ANALYZE,
    // number
    ARGS_AIC_FREQ,                   // 100 1-100 hz
    ARGS_AIV_FREQ,                   // 100 1-100 hz
    ARGS_INSTR_PROFILING_FREQ,       // 1000 300-30000 cycle
    ARGS_SYS_PERIOD,                 // >0
    ARGS_SYS_SAMPLING_FREQ,          // 10 1-10 hz
    ARGS_PID_SAMPLING_FREQ,          // 10 1-10 hz
    ARGS_HARDWARE_MEM_SAMPLING_FREQ, // 50 1-10000 hz
    ARGS_IO_SAMPLING_FREQ,           // 100 1-100 hz
    ARGS_DVPP_FREQ,                  // 50 1-100 hz
    ARGS_CPU_SAMPLING_FREQ,          // 50 1-50 hz
    ARGS_INTERCONNECTION_FREQ,       // 50 1-50 hz
    ARGS_HOST_SYS_USAGE_FREQ,        // 50 1-50 hz
    ARGS_INVALID = 63,              // OsalGetOptLong will return opt = 63 for invalid argument
    ARGS_EXPORT_ITERATION_ID,
    ARGS_EXPORT_MODEL_ID,
    // host
    ARGS_HOST_SYS,
    ARGS_HOST_SYS_PID,
    ARGS_HOST_SYS_USAGE,
    // end
    NR_ARGS
};

struct MsprofCmdInfo {
    const char *args[NR_ARGS];
};

const OsalStructOption LONG_OPTIONS[] = {
    // cmd
    {"help", OSAL_NO_ARG, nullptr, ARGS_HELP},
    {"output", OSAL_OPTIONAL_ARG, nullptr, ARGS_OUTPUT},
    {"storage-limit", OSAL_OPTIONAL_ARG, nullptr, ARGS_STORAGE_LIMIT},
    {"application", OSAL_OPTIONAL_ARG, nullptr, ARGS_APPLICATION},
    {"environment", OSAL_OPTIONAL_ARG, nullptr, ARGS_ENVIRONMENT},
    {"dynamic", OSAL_OPTIONAL_ARG, nullptr, ARGS_DYNAMIC_PROF},
    {"pid", OSAL_OPTIONAL_ARG, nullptr, ARGS_DYNAMIC_PROF_PID},
    {"delay", OSAL_OPTIONAL_ARG, nullptr, ARGS_DELAY_PROF},
    {"duration", OSAL_OPTIONAL_ARG, nullptr, ARGS_DURATION_PROF},
    {"aic-mode", OSAL_OPTIONAL_ARG, nullptr, ARGS_AIC_MODE},
    {"aic-metrics", OSAL_OPTIONAL_ARG, nullptr, ARGS_AIC_METRICS},
    {"aiv-mode", OSAL_OPTIONAL_ARG, nullptr, ARGS_AIV_MODE},
    {"aiv-metrics", OSAL_OPTIONAL_ARG, nullptr, ARGS_AIV_METRICS},
    {"sys-devices", OSAL_OPTIONAL_ARG, nullptr, ARGS_SYS_DEVICES},
    {"llc-profiling", OSAL_OPTIONAL_ARG, nullptr, ARGS_LLC_PROFILING},
    {"python-path", OSAL_OPTIONAL_ARG, nullptr, ARGS_PYTHON_PATH},
    {"summary-format", OSAL_OPTIONAL_ARG, nullptr, ARGS_SUMMARY_FORMAT},
    {"type", OSAL_OPTIONAL_ARG, nullptr, ARGS_EXPORT_TYPE},
    {"reports", OSAL_OPTIONAL_ARG, nullptr, ARGS_REPORTS},
    {"scale", OSAL_OPTIONAL_ARG, nullptr, ARGS_SCALE},
    {"rule", OSAL_OPTIONAL_ARG, nullptr, ARGS_RULE},
    // switch
    {"ascendcl", OSAL_OPTIONAL_ARG, nullptr, ARGS_ASCENDCL},               // the default value is on
    {"ai-core", OSAL_OPTIONAL_ARG, nullptr, ARGS_AI_CORE},
    {"ai-vector-core", OSAL_OPTIONAL_ARG, nullptr, ARGS_AIV},
    {"model-execution", OSAL_OPTIONAL_ARG, nullptr, ARGS_MODEL_EXECUTION}, // the default value is off
    {"runtime-api", OSAL_OPTIONAL_ARG, nullptr, ARGS_RUNTIME_API},         // the default value is off
    {"task-time", OSAL_OPTIONAL_ARG, nullptr, ARGS_TASK_TIME},             // the default value is on
    {"ge-api", OSAL_OPTIONAL_ARG, nullptr, ARGS_GE_API},
    {"task-memory", OSAL_OPTIONAL_ARG, nullptr, ARGS_TASK_MEMORY},         // the default value is off
    {"aicpu", OSAL_OPTIONAL_ARG, nullptr, ARGS_AICPU},
    {"msproftx", OSAL_OPTIONAL_ARG, nullptr, ARGS_MSPROFTX},
    {"mstx-domain-include", OSAL_OPTIONAL_ARG, nullptr, ARGS_MSTX_DOMAIN_INCLUDE},
    {"mstx-domain-exclude", OSAL_OPTIONAL_ARG, nullptr, ARGS_MSTX_DOMAIN_EXCLUDE},
    {"sys-cpu-profiling", OSAL_OPTIONAL_ARG, nullptr, ARGS_CPU_PROFILING},
    {"sys-profiling", OSAL_OPTIONAL_ARG, nullptr, ARGS_SYS_PROFILING},
    {"sys-pid-profiling", OSAL_OPTIONAL_ARG, nullptr, ARGS_PID_PROFILING},
    {"sys-hardware-mem", OSAL_OPTIONAL_ARG, nullptr, ARGS_HARDWARE_MEM},
    {"sys-io-profiling", OSAL_OPTIONAL_ARG, nullptr, ARGS_IO_PROFILING},
    {"sys-interconnection-profiling", OSAL_OPTIONAL_ARG, nullptr, ARGS_INTERCONNECTION_PROFILING},
    {"dvpp-profiling", OSAL_OPTIONAL_ARG, nullptr, ARGS_DVPP_PROFILING},
    {"hccl", OSAL_OPTIONAL_ARG, nullptr, ARGS_HCCL},  // the default value is off
    {"instr-profiling", OSAL_OPTIONAL_ARG, nullptr, ARGS_INSTR_PROFILING},
    {"l2", OSAL_OPTIONAL_ARG, nullptr, ARGS_L2_PROFILING},
    {"parse", OSAL_OPTIONAL_ARG, nullptr, ARGS_PARSE},
    {"query", OSAL_OPTIONAL_ARG, nullptr, ARGS_QUERY},
    {"export ", OSAL_OPTIONAL_ARG, nullptr, ARGS_EXPORT},
    {"clear", OSAL_OPTIONAL_ARG, nullptr, ARGS_CLEAR},
    {"analyze", OSAL_OPTIONAL_ARG, nullptr, ARGS_ANALYZE},
    // number
    {"aic-freq", OSAL_OPTIONAL_ARG, nullptr, ARGS_AIC_FREQ},
    {"aiv-freq", OSAL_OPTIONAL_ARG, nullptr, ARGS_AIV_FREQ},
    {"instr-profiling-freq", OSAL_OPTIONAL_ARG, nullptr, ARGS_INSTR_PROFILING_FREQ},
    {"sys-period", OSAL_OPTIONAL_ARG, nullptr, ARGS_SYS_PERIOD},
    {"sys-sampling-freq", OSAL_OPTIONAL_ARG, nullptr, ARGS_SYS_SAMPLING_FREQ},
    {"sys-pid-sampling-freq", OSAL_OPTIONAL_ARG, nullptr, ARGS_PID_SAMPLING_FREQ},
    {"sys-hardware-mem-freq", OSAL_OPTIONAL_ARG, nullptr, ARGS_HARDWARE_MEM_SAMPLING_FREQ},
    {"sys-io-sampling-freq", OSAL_OPTIONAL_ARG, nullptr, ARGS_IO_SAMPLING_FREQ},
    {"dvpp-freq", OSAL_OPTIONAL_ARG, nullptr, ARGS_DVPP_FREQ},
    {"sys-cpu-freq", OSAL_OPTIONAL_ARG, nullptr, ARGS_CPU_SAMPLING_FREQ},
    {"sys-interconnection-freq", OSAL_OPTIONAL_ARG, nullptr, ARGS_INTERCONNECTION_FREQ},
    {"host-sys-usage-freq", OSAL_OPTIONAL_ARG, nullptr, ARGS_HOST_SYS_USAGE_FREQ},
    {"invalid", OSAL_OPTIONAL_ARG, nullptr, ARGS_INVALID},
    {"iteration-id", OSAL_OPTIONAL_ARG, nullptr, ARGS_EXPORT_ITERATION_ID},
    {"model-id", OSAL_OPTIONAL_ARG, nullptr, ARGS_EXPORT_MODEL_ID},
    // host
    {"host-sys", OSAL_OPTIONAL_ARG, nullptr, ARGS_HOST_SYS},
    {"host-sys-pid", OSAL_OPTIONAL_ARG, nullptr, ARGS_HOST_SYS_PID},
    {"host-sys-usage", OSAL_OPTIONAL_ARG, nullptr, ARGS_HOST_SYS_USAGE},
    // end
    {nullptr, OSAL_NO_ARG, nullptr, ARGS_HELP}
};


class InputParser {
public:
    InputParser();
    virtual ~InputParser();

    void MsprofCmdUsage(const std::string msg);
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> MsprofGetOpts(int32_t argc, MsprofString argv[]);
private:
    void SplitApplicationArgv(int32_t argc, CONST_CHAR_PTR argv[], int32_t &argCount);
    void HandleApp();
    int32_t CheckPythonPathValid(const struct MsprofCmdInfo &cmdInfo) const;
    int32_t CheckOutputValid(const struct MsprofCmdInfo &cmdInfo);
    int32_t CheckStorageLimitValid(const struct MsprofCmdInfo &cmdInfo) const;
    int32_t GetAppParam(const std::string &appParams);
    int32_t CheckAppValid(const struct MsprofCmdInfo &cmdInfo);
    int32_t CheckEnvironmentValid(const struct MsprofCmdInfo &cmdInfo);
    int32_t CheckDynProfValid(struct MsprofCmdInfo &cmdInfo) const;
    bool CheckDynConflict(struct MsprofCmdInfo &cmdInfo) const;
    bool ConflictChecking(struct MsprofCmdInfo &cmdInfo, int32_t opt, const std::string &conflictArgs) const;
    int32_t CheckSampleModeValid(const struct MsprofCmdInfo &cmdInfo, int32_t opt) const;
    int32_t CheckArgOnOff(const struct MsprofCmdInfo &cmdInfo, int32_t opt) const;
    int32_t CheckArgRange(const struct MsprofCmdInfo &cmdInfo, int32_t opt, uint32_t min, uint32_t max) const;
    int32_t CheckCmdScaleIsValid(const struct MsprofCmdInfo &cmdInfo) const;
    int32_t CheckAiCoreMetricsValid(const struct MsprofCmdInfo &cmdInfo, int32_t opt) const;
    std::string GeneratePrompts() const;
    int32_t CheckArgsIsNumber(const struct MsprofCmdInfo &cmdInfo, int32_t opt) const;
    int32_t CheckExportSummaryFormat(const struct MsprofCmdInfo &cmdInfo) const;
    int32_t CheckMemServiceflow(const struct MsprofCmdInfo &cmdInfo) const;
    int32_t CheckAnalyzeRuleSwitch(const struct MsprofCmdInfo &cmdInfo) const;
    int32_t CheckLlcProfilingValid(const struct MsprofCmdInfo &cmdInfo);
    int32_t CheckSysPeriodValid(const struct MsprofCmdInfo &cmdInfo) const;
    int32_t CheckSysDevicesValid(const struct MsprofCmdInfo &cmdInfo);
    int32_t CheckHostSysValid(const struct MsprofCmdInfo &cmdInfo);
    int32_t CheckHostSysPidValid(const struct MsprofCmdInfo &cmdInfo);
    int32_t CheckHostSysUsageValid(const struct MsprofCmdInfo &cmdInfo);
    void SetHostSysUsageParam(const std::string &hostSysUsageParam);
    int32_t MsprofCmdCheckValid(const struct MsprofCmdInfo &cmdInfo, int32_t opt);
    int32_t MsprofCmdCheckValid2(const struct MsprofCmdInfo &cmdInfo, int32_t opt);
    int32_t MsprofFreqCheckValid(const struct MsprofCmdInfo &cmdInfo, int32_t opt);
    int32_t MsprofFreqCheckValidTwo(const struct MsprofCmdInfo &cmdInfo, int32_t opt) const;
    int32_t MsprofHostCheckValid(const struct MsprofCmdInfo &cmdInfo, int32_t opt);
    void MsprofFreqUpdateParams(const struct MsprofCmdInfo &cmdInfo, int32_t opt);
    void MsprofFreqTransferParams(const struct MsprofCmdInfo &cmdInfo, int32_t opt);
    int32_t MsprofSwitchCheckValid(const struct MsprofCmdInfo &cmdInfo, int32_t opt);
    int32_t MsprofDynamicCheckValid(const struct MsprofCmdInfo &cmdInfo, int32_t opt);
    void MsprofDynamicUpdateParams(const struct MsprofCmdInfo &cmdInfo, int32_t opt);
    int32_t CheckSysCpu();
    void ParamsSwitchValid(const struct MsprofCmdInfo &cmdInfo, int32_t opt);
    void ParamsSwitchValid2(const struct MsprofCmdInfo &cmdInfo, int32_t opt);
    void ParamsSwitchValid3(const struct MsprofCmdInfo &cmdInfo, int32_t opt);
    void AiCoreFreqCheckValid(const int32_t intervalTransfer);
    int32_t CheckLlcProfilingIsValid(const std::string &llcProfiling) const;
    int32_t PreCheckApp(const std::string &appDir, const std::string &appName) const;
    int32_t ParamsCheck() const;
    int32_t HostAndDevParamsCheck();
    int32_t ProcessOptions(int32_t opt, struct MsprofCmdInfo &cmdInfo);
    void SetTaskTimeSwitch(const std::string timeSwitch);
    int32_t CheckHostSysToolsIsExist(const std::string toolName, const std::string exeCmd);
    void SetHostSysParam(const std::string hostSysParam);
    int32_t CheckHostSysCmdOutIsExist(const std::string tmpDir, const std::string toolName,
        const OsalProcess tmpProcess) const;
    int32_t CheckHostOutString(const std::string tmpStr, const std::string toolName) const;
    int32_t UninitCheckHostSysCmd(const OsalProcess checkProcess) const;
    int32_t PreCheckPlatform(int32_t opt, CONST_CHAR_PTR argv[]);
    std::vector<MsprofArgsType> GeneratePlatSwithList() const;
private:
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params_;
};

class Args {
public:
    Args(const std::string &name, const std::string &detail);
    Args(const std::string &name, const std::string &detail, const std::string &defaultValue);
    Args(const std::string &name, const std::string &detail, const std::string &defaultValue, int32_t optional);
    virtual ~Args();
public:
    void PrintHelp();
    void SetDetail(const std::string &detail);

private:
    std::string name_;
    std::string alias_;
    std::string defaultValue_;
    std::string detail_;
    int32_t optional_;
};

class ArgsManager : public analysis::dvvp::common::singleton::Singleton<ArgsManager> {
public:
    ArgsManager();
    ~ArgsManager() override;
public:
    void AddArgs(const Args &args);
    void PrintHelp();

private:
    void AddArgs();
    void AddStorageLimitArgs();
    void AddModelExecutionArgs();
    void AddAicMetricsArgs();
    void AddHardWareMemArgs();
    void AddCpuArgs();
    void AddSysArgs();
    void AddIoArgs();
    void AddInterArgs();
    void AddDvvpArgs();
    void AddL2Args();
    void AddInstrArgs();
    void AddAivArgs();
    void AddAicpuArgs();
    void AddHostArgs();
    void AddAnalysisArgs();
    void AddDynProfArgs();
    void AddDelayDurationArgs();
    void AddScaleArgs();
private:
    std::vector<Args> argsList_;
};
}
}
}
#endif
