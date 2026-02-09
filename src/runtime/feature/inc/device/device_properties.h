/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_DEVICE_PROPERTIES_H
#define CCE_RUNTIME_DEVICE_PROPERTIES_H
#include <string>
#include "dev_info.h"
namespace cce {
namespace runtime {

constexpr uint32_t PTHREAD_STACK_SIZE = 128U * 1024U;
constexpr uint32_t TS_4G_CONTIGUOUS_PHY = 0x1U;
constexpr uint32_t TS_PAGE_HUGE_ALIGNED = 0x2U;
constexpr uint32_t TS_WITH_HBM = 0x4U;
constexpr uint32_t SVM_HOST_AGENT = 0x8U;
constexpr uint32_t P2P_ALIGNED = 0x10U;
constexpr uint32_t DEFAULT = 0U;
constexpr uint32_t DEVICE_RINGBUFFER_SIZE = 2U * 1024U * 1024U; // 2M
constexpr uint32_t DEVICE_RINGBUFFER_SIZE_ON_95_96 = 4U * 1024U * 1024U; // 4M
constexpr uint32_t PREFETCH_CNT_8 = 8U;
constexpr uint32_t PREFETCH_CNT_10 = 10U;
constexpr int32_t MAX_GROUP_ID = 3;
constexpr uint32_t NUM_RESET_WITH_FIXED_VALUE = 0x1U;
constexpr uint32_t NUM_RESET_WITH_DRIVER = 0x2U;
constexpr uint32_t MAP_WHEN_GET_INFO = 0x1U;
constexpr uint32_t MAP_WHEN_SET_INFO = 0x2U;

constexpr uint32_t MULTI_GRAPH_ARG_ENTRY_SIZE_OTH = 6208U; // 5120 + 1024(tiling) + 64(host mem)
constexpr uint32_t DEFAULT_INIT_CNT_OTH = 1024U;
constexpr uint32_t SUPER_ARG_AllOC_SIZE_8 = 8U;
constexpr uint32_t SUPER_ARG_AllOC_SIZE_128 = 128U;
constexpr uint32_t ARG_MAX_ENTRY_INIT_NUM = 64U;
constexpr uint32_t HANDLE_ALLOCATOR_SIZE_16 = 16U;
constexpr uint32_t HANDLE_ALLOCATOR_SIZE_1024 = 1024U;
constexpr uint32_t TINY_INIT_CNT = 64U;
constexpr uint32_t TINY_INIT_CNT_DEFAULT = 0U;
constexpr uint32_t KERNEL_INFO_ALLOC_SIZE = 256U;
constexpr uint32_t NORMAL_TASK_RATION = 2U;
constexpr uint32_t DEFAULT_CUSTOM_STACK_SIZE_MAX = 196608U; // 192KB
constexpr uint8_t ENABLED_TS_NUM_1 = 1U;
constexpr uint8_t ENABLED_TS_NUM_2 = 2U;
constexpr size_t MEMCPY_DESC_SIZE_V1 = 32U;
constexpr int32_t TIMELINE_EVENT_ID_DEFAULT = 1023;

enum class EventWaitTimeoutType : uint8_t {
    SET_OP_WAIT_TIMEOUT_NOT_SUPPORT,
    SET_OP_WAIT_TIMEOUT_NEED_TS_VERSION,
    SET_OP_WAIT_TIMEOUT_CONFIG
};

enum class ReduceOverflowType : uint8_t {
    REDUCE_OVERFLOW_TS_VERSION_REDUCE_V2_ID,
    REDUCE_OVERFLOW_TS_VERSION_REDUCV2_SUPPORT_DC,
    REDUCE_NO_OVERFLOW
};

enum class StarsResourceAddrCalculateMethod {
    STARS_RESOURCE_ADDR_CALCULATE_BY_DEVICE_INFO,
    STARS_RESOURCE_ADDR_CALCULATE_STATIC
};

enum class StarsBaseMethod {
    STARS_BASE_CALCULATE_BY_DRIVER,
    STARS_BASE_CALCULATE_STATIC
};

enum class TimeoutUpdateMethod {
    TIMEOUT_SET_WITH_AICPU = 0,
    TIMEOUT_WITHOUT_UPDATE,
    TIMEOUT_NEED_RESET,
    DEFAULT_METHOD,
};

enum class SupportSnapshot {
    SUPPORT = 0,
    SUPPORT_ON_HIGH_TS_VERSION,
    NOT_SUPPORT,
};

enum class EngineCreateType {
    STARS_ENGINE,
    ASYNC_HWTS_ENGINE,
    DIRECT_HWTS_ENGINE
};

enum class SqeVersion {
    CMO_SQE_VERSION_V1,
    CMO_SQE_VERSION_V2,
    CMO_SQE_VERSION_V3
};

struct RtsqVirtualAddr {
    uint64_t rtSqFsmStateAddr;
    uint64_t rtSqEnableAddr;
    uint64_t rtSqTailAddr;
    uint64_t rtSqHeadAddr;
};

enum class RtsqFsmStateAddrCalMethod {
    FSM_ADDR_CALCULATE_BY_DEVICE_INFO,
    FSM_ADDR_CALCULATE_STATIC,
    NOT_SUPPORT
};

enum class StarsBaseAddrMethod {
    STARS_BASE_CALCULATE_BY_DRIVER,
    STARS_BASE_CALCULATE_STATIC,
    NOT_SUPPORT
};

enum class RtSqEnableAddrCalMethod {
    RT_SQ_ENABLE_ADDR_CAL_BY_TRUE_SQID,
    RT_SQ_ENABLE_ADDR_CAL_STATIC,
    NOT_SUPPORT
};

enum class OMArchVersion : uint8_t {
    omArchVersion_4,
    omArchVersion_3,
    omArchVersion_DEFAULT
};

enum class CheckArchVersionCompatibility : uint8_t {
    Arch_Version_Compat_V220,
    Arch_Version_Compat_V100,
    Arch_Version_Compat_DEFAULT,
};

enum class DcacheLockMixType : uint8_t {
    DCACHE_LOCK_MIX_TYPE_FROM_DEFAULT,
    DCACHE_LOCK_MIX_TYPE_FROM_910_B_93,
    DCACHE_LOCK_MIX_TYPE_FROM_STARS_V2,
};

enum class KernelFuncType : uint8_t {
    Kernel_FUC_TYPE_SUPP_AICORE,
    Kernel_FUC_TYPE_NON_SUPP_AICORE,
    Kernel_FUC_TYPE_OTHER_AICORE,
};

enum class CmoAddrInfoType : uint8_t {
    CMO_ADDR_INFO_TYPE_DAFAULT = 0,
    CMO_ADDR_INFO_TYPE_DAVID
};

enum class CqeDepth : uint32_t {
    CQE_DEPTH_NON_DVPP_GRP = 4096U,
    CQE_DEPTH_DVPP_GRP = 16384U
};

enum class GetTsMemTypeMethod : uint8_t {
    GET_TS_MEM_TYPE_STATIC,
    GET_TS_MEM_TYPE_JUDGE_FROM_DRIVER
};

enum class TsOverflowHandling : uint8_t {
    TS_OVER_FLOW_HANDING_INVALID,
    TS_OVER_FLOW_HANDING_FROM_MEM,
    TS_OVER_FLOW_HANDING_DEFAULT
};

enum class DeviceSatStatus : uint8_t {
    DEVICE_SAT_STATUS_SUPPORT,
    DEVICE_SAT_STATUS_OTHER,
    DEVICE_SAT_STATUS_V2,
};

enum class GetCapabilityMethod : uint8_t {
    GET_CAPABILITY_NOT_SUPPORT,
    GET_CAPABILITY_BY_FEATURE_CHECK,
    GET_CAPABILITY_BY_DRIVER_CHECK,
    GET_CAPABILITY_BY_BOTH_FEATURE_AND_DRIVER_CHECK
};

enum class StreamWaitEventTimeout : uint8_t {
    ZERO,
    CUSTOM,
    NOT_SUPPORT,
};

enum class AllocManagedFlag : uint8_t {
    ALLOC_MANAGED_MEM_ADVISE_4G,
    ALLOC_MANAGED_MEM_SET_ALIGN_SIZE,
    ALLOC_MANAGED_MEM_HOST_AGENT,
    ALLOC_MANAGED_MEM_NORMAL
};

enum class SdmaCopyMethod : uint8_t {
    SDMA_COPY_BY_MEM_SYNC_ADAPTER,
    SDMA_COPY_BY_HAL,
    SDMA_COPY_BY_HAL_WITH_OFFLINE
};

enum class SupportCreateTaskRes : uint8_t {
    CREATE_TASK_RES_NOT_SUPPORT,
    CREATE_TASK_RES_SUPPORT_WITH_OFFLINE,
    CREATE_TASK_RES_SUPPORT
};

struct DevProperties final {
    std::string engineType;
    bool isStars;
    uint32_t pthreadStackSize; // 0: Use the default stack size. others: Custom Stack Size
    EventWaitTimeoutType eventWaitTimeout;
    uint32_t tsCount;
    uint32_t defaultTaskRatio;
    uint64_t sqTailOffset;
    int32_t maxGroupId;
    ReduceOverflowType reduceOverflow;
    bool isSupportSetDeviceSatMode;
    uint32_t sdmaReduceKind; // bit supoort
    StarsResourceAddrCalculateMethod starsResourceAddrCalculateMethod;
    uint64_t eventBase;
    StarsBaseMethod starsBaseMethod;
    uint64_t fsmSelBase;
    uint64_t notifyBase;
    uint32_t starsNotifyTableSize;
    uint64_t ipcNotifyNumMask;
    uint32_t mc2FeatureFlag;
    uint64_t stackPhyBase;
    uint32_t maxCustomerStackSize;
    uint32_t aicNum; // 目前是宏定义，后续需要去 ini 里面去读
    uint32_t aivNum; // 目前是宏定义，后续需要去 ini 里面去读
    uint32_t ringbufSize; // 0: do not need new DeviceErrorProc. others: Custom DeviceErrorProc ringBufferSize
    uint32_t hugeManagedFlag;
    uint32_t memAllocPctraceFlag;
    uint32_t memInfoType;
    uint32_t taskPrefetchCount;
    uint32_t maxAllocHugeStreamNum;
    uint32_t resetMaxModelNum;
    bool reduceAicNum;
    TimeoutUpdateMethod timeoutUpdateMethod;
    uint32_t hugePolicyFlag;
    uint32_t memInfoMapType;
    uint32_t resAllocRange;
    SupportSnapshot supportSnapshot;
    uint32_t MaxKernelCredit;
    float eventTimestampFreq;
    EngineCreateType taskEngineType;
    SqeVersion CmoSqeVersion;
    uint32_t DefaultKernelCredit;
    uint8_t starsDefaultKernelCredit;
    double KernelCreditScale;
    bool isSupportInitFuncCallPara;
    RtsqVirtualAddr rtsqVirtualAddr;
    RtsqFsmStateAddrCalMethod rtsqFsmStateAddrCalMethod;
    StarsBaseAddrMethod starsBaseAddrMethod;
    RtSqEnableAddrCalMethod rtSqEnableAddrCalMethod;
    bool isSupportDvppAccelerator;
    bool isSupportDevVA2PA;
    CmoAddrInfoType cmoAddrInfoType;
    uint32_t memcpyAsyncTaskD2DQos;
    bool isMemcpyAsyncTaskSqeType;
    uint32_t sqeDepth;
    uint32_t cqeSize;
    uint32_t cqeDepth;
    int32_t cqeWaitTimeout;
    uint16_t getRtsqPosition;
    uint16_t creditStartValue;
    uint32_t argsItemSize;
    uint32_t argInitCountSize;
    uint32_t argsAllocatorSize;
    uint32_t superArgAllocatorSize;
    uint32_t maxArgAllocatorSize;
    uint32_t handleAllocatorSize;
    uint32_t kernelInfoAllocatorSize;
    bool isNeedlogErrorLevel;
    bool overflowMode;
    bool opExecuteTimeout; // true for ms, false for s.
    OMArchVersion omArchVersion;
    CheckArchVersionCompatibility checkArchVersionCompatibility;
    DcacheLockMixType dcacheLockMixType;
    KernelFuncType kernelFuncType;
    bool taskPoolSizeFromMacroValue;
    uint16_t taskPoolSize;
    GetTsMemTypeMethod getTsMemTypeMethod;
    uint8_t enabledTSNum;
    DeviceSatStatus deviceSatStatus;
    uint32_t ringBufferMemCopyCycleTimes;
    TsOverflowHandling tsOverflowHandling;
    GetCapabilityMethod getCapabilityMethod;
    size_t memcpyDescriptorSize;
    uint64_t cmoDDRStructInfoSize;
    StreamWaitEventTimeout streamWaitEventTimeout;
    int32_t timelineEventId;
    uint16_t deviceSatStatusImpl;
    AllocManagedFlag allocManagedFlag;
    SdmaCopyMethod sdmaCopyMethod;
    uint8_t eventPoolSize;
    uint32_t rtsqShamt;
    SupportCreateTaskRes supportCreateTaskRes;
    uint32_t aicNumForCoreStack;
    uint64_t engineWaitCompletionTImeout;
    int32_t reportWaitTimeout;
};
}
}
#endif