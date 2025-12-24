/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DVVP_COLLECT_PLATFORM_PLATFORM_INTERFACE_H
#define DVVP_COLLECT_PLATFORM_PLATFORM_INTERFACE_H
#include <string>
#include <cstdint>
#include <memory>
#include <map>
#include <set>
#include <vector>
#include <functional>
#include "errno/error_code.h"
#include "logger/msprof_dlog.h"
#include "prof_acl_api.h"
#include "base_analyzer.h"

namespace Dvvp {
namespace Collect {
namespace Platform {
constexpr uint16_t MAX_COLLECT_MONITOR_NUM = 8;
constexpr uint16_t MAX_DAVID_MONITOR_NUM = 10;
constexpr char INTERFACE_AIRTHMETICUTILIZATION[] = "0x49,0x4a,0x4b,0x4c,0x4d,0x4e,0x4f";
constexpr char INTERFACE_PIPEUTILIZATION[] = "0x8,0xa,0x9,0xb,0xc,0xd,0x54,0x55";
constexpr char INTERFACE_PIPEUTILIZATIONEXCT[] = "0x416,0x417,0x9,0x302,0xc,0x303,0x54,0x55";
constexpr char INTERFACE_PIPELINEEXECUTEUTILIZATION[] = "0x12c,0x49,0x4a,0x9,0x302,0xc,0xd,0x303";
constexpr char INTERFACE_RESOURCECONFLICTRATIO[] = "0x64,0x65,0x66";
constexpr char INTERFACE_MEMORY[] = "0x15,0x16,0x31,0x32,0xf,0x10,0x12,0x13";
constexpr char INTERFACE_MEMORYL0[] = "0x1b,0x1c,0x21,0x22,0x27,0x28,0x29,0x2a";
constexpr char INTERFACE_MEMORYUB[] = "0x10,0x13,0x37,0x38,0x3d,0x3e,0x43,0x44";
constexpr char INTERFACE_SMMU_EVENT[] = "0x2,0x8a,0x8b,0x8c,0x8d";
constexpr char INTERFACE_L2CACHE[] = "0x500,0x502,0x504,0x506,0x508,0x50a";
constexpr char INTERFACE_L2CACHEEVENT[] = "0xF6,0xFB,0xFC,0xBF,0x90,0x91,0x9C,0x9D";
constexpr char INTERFACE_MEMORYACCESS[] = "0x32,0x3d,0x3e,0x206,0x20c,0x50c,0x50d,0x50e";
constexpr char EMPTY_FREQUENCY[] = "";

enum PlatformTypeEnum {
    CHIP_CLOUD       = 1,
    CHIP_DC          = 4,
    CHIP_CLOUD_V2    = 5,
    CHIP_MINI_V3     = 7,
    CHIP_END         = 17
};

enum PlatformFeature {
    PLATFORM_FEATURE_INVALID,
    // Task
    PLATFORM_TASK_SWITCH,
    PLATFORM_TASK_ASCENDCL,
    PLATFORM_TASK_FWK,
    PLATFORM_TASK_RUNTIME,
    PLATFORM_TASK_AICPU,
    PLATFORM_TASK_HCCL,
    PLATFORM_TASK_L2_CACHE_REG,
    PLATFORM_TASK_L2_CACHE_PMU,
    PLATFORM_TASK_AU_PMU,
    PLATFORM_TASK_PU_PMU,
    PLATFORM_TASK_PEU_PMU,
    PLATFORM_TASK_PUEXCT_PMU,
    PLATFORM_TASK_RCR_PMU,
    PLATFORM_TASK_PSC_PMU,
    PLATFORM_TASK_SCALAR_RATIO_PMU,
    PLATFORM_TASK_MEMORY_PMU,
    PLATFORM_TASK_MEMORYL0_PMU,
    PLATFORM_TASK_MEMORYUB_PMU,
    PLATFORM_TASK_MEMORY_ACCESS_PMU,
    PLATFORM_TASK_TS_TIMELINE,
    PLATFORM_TASK_TS_KEYPOINT,
    PLATFORM_TASK_TS_KEYPOINT_TRAINING,
    PLATFORM_TASK_TS_MEMCPY,
    PLATFORM_TASK_AIC_HWTS,
    PLATFORM_TASK_AIV_HWTS,
    PLATFORM_TASK_AIC_METRICS,
    PLATFORM_TASK_AIV_METRICS,
    PLATFORM_TASK_AICORE_LPM,
    PLATFORM_TASK_AICORE_LPM_INFO,
    PLATFORM_TASK_STARS_ACSQ,
    PLATFORM_TASK_GE_API,
    PLATFORM_TASK_TRACE,
    PLATFORM_TASK_TRACE_L3,
    PLATFORM_TASK_MSPROFTX,
    PLATFORM_TASK_TSFW,
    PLATFORM_TASK_RUNTIME_API,
    PLATFORM_TASK_BLOCK,
    PLATFORM_TASK_METRICS,
    PLATFORM_TASK_TRAINING_TRACE,
    PLATFORM_TASK_MEMORY,
    PLATFORM_TASK_CCU_INSTRUTION,
    PLATFORM_TASK_CCU_STATISTIC,
    PLATFORM_TASK_INSTR_PROFILING,
    PLATFORM_TASK_PC_SAMPLING,
    PLATFORM_TASK_DYNAMIC,
    PLATFORM_TASK_DELAY_DURATION,
    PLATFORM_TASK_SOC_PMU,
    PLATFORM_TASK_SOC_PMU_NOC,
    PLATFORM_TASK_SCALE,
    // System-device
    PLATFORM_SYS_DEVICE_SYS_CPU_MEM_USAGE,
    PLATFORM_SYS_DEVICE_ALL_PID_CPU_MEM_USAGE,
    PLATFORM_SYS_DEVICE_TS_CPU_HOT_FUNC_PMU,
    PLATFORM_SYS_DEVICE_AI_CTRL_CPU_HOT_FUNC_PMU,
    PLATFORM_SYS_DEVICE_NPU_MODULE_MEM,
    PLATFORM_SYS_DEVICE_LLC,
    PLATFORM_SYS_DEVICE_DDR,
    PLATFORM_SYS_DEVICE_HBM,
    PLATFORM_SYS_DEVICE_NIC,
    PLATFORM_SYS_DEVICE_ROCE,
    PLATFORM_SYS_DEVICE_HCCS,
    PLATFORM_SYS_DEVICE_PCIE,
    PLATFORM_SYS_DEVICE_UB,
    PLATFORM_SYS_DEVICE_DVPP,
    PLATFORM_SYS_DEVICE_DVPP_EX,
    PLATFORM_SYS_DEVICE_INSTR_PROFILING,
    PLATFORM_SYS_DEVICE_LOW_POWER,
    PLATFORM_SYS_DEVICE_QOS,
    PLATFORM_SYS_DEVICE_US,
    PLATFORM_SYS_DEVICE_AICPU_HSCB,
    // System-host
    PLATFORM_SYS_HOST_ONE_PID_CPU,
    PLATFORM_SYS_HOST_ALL_PID_CPU,
    PLATFORM_SYS_HOST_ONE_PID_MEM,
    PLATFORM_SYS_HOST_ALL_PID_MEM,
    PLATFORM_SYS_HOST_ONE_PID_DISK,
    PLATFORM_SYS_HOST_ONE_PID_OSRT,
    PLATFORM_SYS_HOST_NETWORK,
    PLATFORM_SYS_HOST_SYS_CPU,
    PLATFORM_SYS_HOST_SYS_MEM,
    // Feature collection
    PLATFORM_COLLECTOR_ACP,
    PLATFORM_DIAGNOSTIC_COLLECTION,
    PLATFORM_AOE_SUPPORT_FUNC,
    PLATFORM_AICSCALE_ACP,
    PLATFORM_STARS_QOS,
    PLATFORM_SYS_MEM_SERVICEFLOW,
    PLATFORM_MC2,
    PLATFORM_AICPU_HCCL,
    PLATFORM_ACLAPI_SETDEVICE_ENABLE,
    // MAX
    PLATFORM_COLLECTOR_TYPES_MAX
};

const std::map<std::string, PlatformFeature> METRIC_FEATURE_MAP = {
    {"ArithmeticUtilization",      PLATFORM_TASK_AU_PMU},
    {"PipeUtilization",            PLATFORM_TASK_PU_PMU},
    {"PipeUtilizationExct",        PLATFORM_TASK_PUEXCT_PMU},
    {"PipelineExecuteUtilization", PLATFORM_TASK_PEU_PMU},
    {"ResourceConflictRatio",      PLATFORM_TASK_RCR_PMU},
    {"PipeStallCycle",             PLATFORM_TASK_PSC_PMU},
    {"Memory",                     PLATFORM_TASK_MEMORY_PMU},
    {"MemoryL0",                   PLATFORM_TASK_MEMORYL0_PMU},
    {"MemoryUB",                   PLATFORM_TASK_MEMORYUB_PMU},
    {"L2Cache",                    PLATFORM_TASK_L2_CACHE_PMU},
    {"ScalarRatio",                PLATFORM_TASK_SCALAR_RATIO_PMU},
    {"MemoryAccess",               PLATFORM_TASK_MEMORY_ACCESS_PMU}
};

const std::map<std::string, std::vector<PlatformFeature>> PLATFORM_FEATURE_MAP = {
    {"switch",                      {PLATFORM_TASK_SWITCH}},
    {"ge_api",                      {PLATFORM_TASK_GE_API}},
    {"task_memory",                 {PLATFORM_TASK_MEMORY}},
    {"task_trace",                  {PLATFORM_TASK_TRACE}},
    {"aicpu",                       {PLATFORM_TASK_AICPU}},
    {"l2",                          {PLATFORM_TASK_L2_CACHE_REG}},
    {"hccl",                        {PLATFORM_TASK_HCCL}},
    {"msproftx",                    {PLATFORM_TASK_MSPROFTX}},
    {"instr_profiling",             {PLATFORM_SYS_DEVICE_INSTR_PROFILING, PLATFORM_TASK_INSTR_PROFILING}},
    {"task_tsfw",                   {PLATFORM_TASK_TSFW}},
    {"runtime_api",                 {PLATFORM_TASK_RUNTIME_API}},
    {"ascendcl",                    {PLATFORM_TASK_ASCENDCL}},
    {"task_block",                  {PLATFORM_TASK_BLOCK}},
    {"sys_lp",                      {PLATFORM_SYS_DEVICE_LOW_POWER}},
    {"sys_lp_freq",                 {PLATFORM_SYS_DEVICE_LOW_POWER}},
    {"training_trace",              {PLATFORM_TASK_TRAINING_TRACE}},
    {"sys_hardware_mem_freq",       {PLATFORM_SYS_DEVICE_NPU_MODULE_MEM, PLATFORM_SYS_DEVICE_LLC,
                                     PLATFORM_SYS_DEVICE_DDR, PLATFORM_SYS_DEVICE_HBM}},
    {"sys_mem_serviceflow",         {PLATFORM_SYS_MEM_SERVICEFLOW}},
    {"llc_profiling",               {PLATFORM_SYS_DEVICE_LLC}},
    {"sys_io_sampling_freq",        {PLATFORM_SYS_DEVICE_NIC, PLATFORM_SYS_DEVICE_ROCE}},
    {"sys_interconnection_freq",    {PLATFORM_SYS_DEVICE_PCIE, PLATFORM_SYS_DEVICE_HCCS}},
    {"sys_cpu_freq",                {PLATFORM_SYS_DEVICE_AICPU_HSCB}},
    {"dvpp_freq",                   {PLATFORM_SYS_DEVICE_DVPP, PLATFORM_SYS_DEVICE_DVPP_EX}},
    {"host_sys",                    {PLATFORM_SYS_HOST_SYS_CPU, PLATFORM_SYS_HOST_SYS_MEM}},
    {"host_sys_usage",              {PLATFORM_SYS_HOST_ALL_PID_CPU, PLATFORM_SYS_HOST_ALL_PID_MEM}},
    {"host_sys_usage_freq",         {PLATFORM_SYS_HOST_ALL_PID_CPU, PLATFORM_SYS_HOST_ALL_PID_MEM}}
};

const std::map<uint64_t, PlatformFeature> PLATFORM_BITE_MAP = {
    {PROF_ACL_API,         PLATFORM_TASK_ASCENDCL},
    {PROF_TASK_TIME_L1,    PLATFORM_TASK_TRACE},
    {PROF_TASK_TIME_L2,    PLATFORM_TASK_TRACE},
    {PROF_TASK_TIME_L3,    PLATFORM_TASK_TRACE_L3},
    {PROF_OP_ATTR,         PLATFORM_TASK_TRACE},
    {PROF_AICORE_METRICS,  PLATFORM_TASK_METRICS},
    {PROF_AICPU_TRACE,     PLATFORM_TASK_AICPU},
    {PROF_L2CACHE,         PLATFORM_TASK_L2_CACHE_REG},
    {PROF_HCCL_TRACE,      PLATFORM_TASK_HCCL},
    {PROF_TRAINING_TRACE,  PLATFORM_TASK_TRAINING_TRACE},
    {PROF_MSPROFTX,        PLATFORM_TASK_MSPROFTX},
    {PROF_RUNTIME_API,     PLATFORM_TASK_RUNTIME_API},
    {PROF_GE_API_L0,       PLATFORM_TASK_GE_API},
    {PROF_TASK_TIME,       PLATFORM_TASK_TRACE},
    {PROF_TASK_MEMORY,     PLATFORM_TASK_MEMORY},
    {PROF_GE_API_L1,       PLATFORM_TASK_GE_API}
};

class PlatformInterface {
public:
    using MetricsFunc = std::string(PlatformInterface::*)();
    PlatformInterface() {}
    virtual ~PlatformInterface() {}
    virtual std::string GetDeviceOscDefaultFreq();
    virtual std::string GetAicDefaultFreq();
    virtual std::string GetAivDefaultFreq();
    virtual int32_t GetAiPmuMetrics(const std::string &key, std::string &vaule);
    virtual bool FeatureIsSupport(const PlatformFeature feature) const;
    virtual std::string GetSmmuEventStr();
    virtual std::string GetL2CacheEvents();
    virtual PlatformFeature PmuMetricsToFeature(const std::string &key) const;
    virtual uint16_t GetMaxMonitorNumber() const;
    virtual uint16_t GetQosMonitorNumber() const;
    virtual int32_t InitOnlineAnalyzer();
    virtual uint32_t GetMetricsPmuNum(const std::string &name) const;
    virtual std::string GetMetricsTopName(const std::string &name) const;
    virtual PmuCalculationAttr* GetMetricsFunc(const std::string &name, uint32_t index) const;
    virtual float GetTotalTime(uint64_t cycle, double freq, uint16_t blockDim, int64_t coreNum) const;
    virtual void SetSubscribeFeature();

protected:
    virtual std::string GetMetricsValue(const PlatformFeature feature);
    virtual std::string GetArithmeticUtilizationMetrics();
    virtual std::string GetPipeUtilizationMetrics();
    virtual std::string GetPipeUtilizationExctMetrics();
    virtual std::string GetPipelineExecuteUtilizationMetrics();
    virtual std::string GetPipeStallCycleMetrics();
    virtual std::string GetResourceConflictRatioMetrics();
    virtual std::string GetMemoryMetrics();
    virtual std::string GetMemoryL0Metrics();
    virtual std::string GetMemoryUBMetrics();
    virtual std::string GetL2CacheMetrics();
    virtual std::string GetScalarMetrics();
    virtual std::string GetMemoryAccessMetrics();
    std::set<PlatformFeature> supportedFeature_;
    SHARED_PTR_ALIA<BaseAnalyzer> analyzer_;
};

class PlatformReflection {
public:
    template<typename T>
    static void RegisterPlatformClass(PlatformTypeEnum platformType)
    {
        platformMap_[platformType] = []() -> std::shared_ptr<PlatformInterface> {
            return std::shared_ptr<T>(new (std::nothrow)T);
        };
    }

    static std::shared_ptr<PlatformInterface> CreatePlatformClass(PlatformTypeEnum platformType)
    {
        auto it = platformMap_.find(platformType);
        if (it != platformMap_.end()) {
            return it->second();
        }
        return nullptr;
    }

private:
    static std::map<PlatformTypeEnum, std::function<std::shared_ptr<PlatformInterface>()>> platformMap_;
};

template<typename T>
class PlatformRegister {
public:
    explicit PlatformRegister(PlatformTypeEnum platformType)
    {
        PlatformReflection::RegisterPlatformClass<T>(platformType);
    }
};

#define PLATFORM_REGISTER(platformType, platformClass) \
    PlatformRegister<platformClass> g_spec##platformClass(platformType)

}
}
}
#endif