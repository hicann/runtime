/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "base.hpp"
#include "dev_info_manage.h"
#include "stars_base.hpp"
#include "stars_base_cond_isa_define.hpp"
#include "task_base.hpp"
namespace cce {
namespace runtime {
static constexpr rtSocInfo_t CHIP_ADC_SOC_INFO[] = {
    {SOC_ASCEND610, CHIP_ADC, ARCH_M200, "Ascend610"},
    {SOC_BS9SX1AA, CHIP_ADC, ARCH_M201, "BS9SX1AA"},
    {SOC_BS9SX1AB, CHIP_ADC, ARCH_M201, "BS9SX1AB"},
    {SOC_BS9SX1AC, CHIP_ADC, ARCH_M201, "BS9SX1AC"},
};

BATCH_REGISTER_SOC_INFO(CHIP_ADC_SOC_INFO, sizeof(CHIP_ADC_SOC_INFO) / sizeof(rtSocInfo_t));

REGISTER_PLATFORM_LIB_INFO(CHIP_ADC, "libruntime_v100.so");

static const std::unordered_set<RtOptionalFeatureType> CHIP_ADC_FEATURE{
    RtOptionalFeatureType::RT_FEATURE_DRIVER_NUMA_TS_MEM_CTRL,
    RtOptionalFeatureType::RT_FEATURE_PROFILING_ONLINE,
    RtOptionalFeatureType::RT_FEATURE_TASK_FLIP,
    RtOptionalFeatureType::RT_FEATURE_DFX_ARGS_DOT_ALLOC_ERROR_LOG,
    RtOptionalFeatureType::RT_FEATURE_TASK_RDMA,
    RtOptionalFeatureType::RT_FEATURE_TASK_TRY_RECYCLE_DISABLE_HWTS,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_GROUP_THREAD_LOCAL,
    RtOptionalFeatureType::RT_FEATURE_TASK_MODEL_EXECUTE_COPY_ONCE,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_HAS_TS_DEAMON,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_NO_MIX_DOT_REGISTER,
    RtOptionalFeatureType::RT_FEATURE_MODEL_SCHED_GROUP,
    RtOptionalFeatureType::RT_FEATURE_PROFILING_AICPU,
    RtOptionalFeatureType::RT_FEATURE_PROFILING_ADC,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_AICPUSD_LAZY_START,
    RtOptionalFeatureType::RT_FEATURE_STREAM_ABORT,
    RtOptionalFeatureType::RT_FEATURE_STREAM_DOT_SYNC_TIMEOUT_ABORT,
    RtOptionalFeatureType::RT_FEATURE_STREAM_DOT_RECORD_SYNC_TIMEOUT,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_ELF_NO_FUNC_TYPE,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_TSCH_PACAGE_COMPATABLE,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_DOT_PROGRAM_ALLOCATOR,
    RtOptionalFeatureType::RT_FEATURE_DFX_ATRACE,
    RtOptionalFeatureType::RT_FEATURE_TASK_AICPU_DOT_SUPPORT_CHECK,
    RtOptionalFeatureType::RT_FEATURE_MODEL_EXECUTE_TIMEOUT_MONITOR,
    RtOptionalFeatureType::RT_FEATURE_MODEL_RECORD_TIMEOUT,
    RtOptionalFeatureType::RT_FEATURE_MODEL_ABORT,
    RtOptionalFeatureType::RT_FEATURE_MODEL_ABORT_USE_DEFAULT_STREAM,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_SPM_POOL,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_GROUP,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_C2C_SYNC,
    RtOptionalFeatureType::RT_FEATURE_MODEL_ID_FOR_AICPU,
    RtOptionalFeatureType::RT_FEATURE_NOTIFY_WAIT,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_UMA_SUPER_ARGS_ALLOC,
    RtOptionalFeatureType::RT_FEATURE_PROFILING_ONLINE_DEVICE_MEM_CLEAR,
    RtOptionalFeatureType::RT_FEATURE_DFX_TS_GET_DEVICE_MSG
};

REGISTER_CHIP_FEATURE_SET(CHIP_ADC, CHIP_ADC_FEATURE);

static constexpr uint32_t CQE_DEPTH = 4096U;
static constexpr uint32_t DEFAULT_CQE_SIZE = 12U;
static constexpr uint32_t RT_HWTS_MAX_KERNEL_CREDIT_UINT32 = 255U; // HWTS MAX KERNEL_CREDIT = 255.
static constexpr uint32_t RT_HWTS_610_DEFAULT_KERNEL_CREDIT_UINT32 = 72U; // The TS 610 reference time is 2415919.104 us.
static constexpr double RT_HWTS_610_TASK_KERNEL_CREDIT_SCALE_US = 33554.432F; // 2^25 / 1000M *1000*1000(us)
static constexpr uint64_t ENGINE_WAIT_COMPLETION_TIMEOUT = 2000UL; //2000ms

static const DevProperties CHIP_ADC_PROPERTIES = {
    .engineType = "HWTS",
    .isStars = false,
    .pthreadStackSize = PTHREAD_STACK_SIZE,
    .eventWaitTimeout = EventWaitTimeoutType::SET_OP_WAIT_TIMEOUT_NOT_SUPPORT,
    .tsCount = 2U,
    .defaultTaskRatio = NORMAL_TASK_RATION,
    .sqTailOffset = STARS_SIMPLE_SQ_TAIL_OFFSET,
    .maxGroupId = MAX_GROUP_ID,
    .reduceOverflow = ReduceOverflowType::REDUCE_NO_OVERFLOW,
    .isSupportSetDeviceSatMode = false,
    .sdmaReduceKind = 0x7C00U,
    .starsResourceAddrCalculateMethod = StarsResourceAddrCalculateMethod::STARS_RESOURCE_ADDR_CALCULATE_STATIC,
    .eventBase = RT_STARS_BASE_ADDR_520000000 + STARS_EVENT_BASE_ADDR,
    .starsBaseMethod = StarsBaseMethod::STARS_BASE_CALCULATE_STATIC,
    .fsmSelBase = RT_STARS_BASE_ADDR_520000000 + STARS_SIMPLE_RTSQ_FSM_SEL_REG,
    .notifyBase = RT_STARS_BASE_ADDR_520000000 + STARS_NOTIFY_BASE_ADDR,
    .starsNotifyTableSize = STARS_NOTIFY_NUM_OF_SINGLE_TABLE_128,
    .ipcNotifyNumMask = 0x7FUL,
    .mc2FeatureFlag = 0U,
    .stackPhyBase = RT_SCALAR_BUFFER_SIZE_32K_2,
    .maxCustomerStackSize = DEFAULT_CUSTOM_STACK_SIZE_MAX,
    .aicNum = RT_AICORE_NUM_25,
    .aivNum = RT_AIVECTOR_NUM_50,
    .ringbufSize = 0U,
    .hugeManagedFlag = TS_4G_CONTIGUOUS_PHY,
    .memAllocPctraceFlag = MEM_DEV | MEM_TYPE_HBM | MEM_PAGE_NORMAL | MEM_ADVISE_4G,
    .memInfoType = RT_MEM_INFO_TYPE_DDR_SIZE,
    .taskPrefetchCount = PREFETCH_CNT_8,
    .maxAllocHugeStreamNum = DEFAULT,
    .resetMaxModelNum = DEFAULT,
    .reduceAicNum = false,
    .timeoutUpdateMethod = TimeoutUpdateMethod::TIMEOUT_NEED_RESET,
    .hugePolicyFlag = TS_4G_CONTIGUOUS_PHY,
    .memInfoMapType = MAP_WHEN_GET_INFO,
    .resAllocRange = DEFAULT,
    .supportSnapshot = SupportSnapshot::NOT_SUPPORT,
    .MaxKernelCredit = RT_HWTS_MAX_KERNEL_CREDIT_UINT32,
    .eventTimestampFreq = RT_DEFAULT_TIMESTAMP_FREQ,
    .taskEngineType = EngineCreateType::DIRECT_HWTS_ENGINE,
    .CmoSqeVersion = SqeVersion::CMO_SQE_VERSION_V1,
    .DefaultKernelCredit = RT_HWTS_610_DEFAULT_KERNEL_CREDIT_UINT32,
    .starsDefaultKernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT,
    .KernelCreditScale = RT_HWTS_610_TASK_KERNEL_CREDIT_SCALE_US,
    .isSupportInitFuncCallPara = false,
    .rtsqVirtualAddr = {0ULL, 0ULL, 0ULL, 0ULL},
    .rtsqFsmStateAddrCalMethod = RtsqFsmStateAddrCalMethod::NOT_SUPPORT,
    .starsBaseAddrMethod = StarsBaseAddrMethod::NOT_SUPPORT,
    .rtSqEnableAddrCalMethod = RtSqEnableAddrCalMethod::NOT_SUPPORT,
    .isSupportDvppAccelerator = false,
    .isSupportDevVA2PA = false,
    .cmoAddrInfoType = CmoAddrInfoType::CMO_ADDR_INFO_TYPE_DAFAULT,
    .memcpyAsyncTaskD2DQos = UINT32_MAX,
    .isMemcpyAsyncTaskSqeType = true,
    .sqeDepth = UINT32_MAX,
    .cqeSize = DEFAULT_CQE_SIZE,
    .cqeDepth = CQE_DEPTH,
    .cqeWaitTimeout = RT_REPORT_MDC_TIMEOUT_TIME,
    .getRtsqPosition = UINT16_MAX,
    .creditStartValue = UINT16_MAX,
    .argsItemSize = MULTI_GRAPH_ARG_ENTRY_SIZE_OTH,
    .argInitCountSize = DEFAULT_INIT_CNT_OTH,
    .argsAllocatorSize = TINY_INIT_CNT_DEFAULT,
    .superArgAllocatorSize = SUPER_ARG_AllOC_SIZE_128,
    .maxArgAllocatorSize = ARG_MAX_ENTRY_INIT_NUM,
    .handleAllocatorSize = HANDLE_ALLOCATOR_SIZE_1024,
    .kernelInfoAllocatorSize = KERNEL_INFO_ALLOC_SIZE,
    .isNeedlogErrorLevel = true,
    .overflowMode = false,
    .opExecuteTimeout = true,
    .omArchVersion = OMArchVersion::omArchVersion_DEFAULT,
    .checkArchVersionCompatibility = CheckArchVersionCompatibility::Arch_Version_Compat_DEFAULT,
    .dcacheLockMixPathSourceType = DcacheLockMixPathSourceType::DCACHE_LOCK_MIX_PATH_FROM_DEFAULT,
    .kernelFuncType = KernelFuncType::Kernel_FUC_TYPE_OTHER_AICORE,
    .taskPoolSizeFromMacroValue = false,
    .taskPoolSize = 0U,
    .getTsMemTypeMethod = GetTsMemTypeMethod::GET_TS_MEM_TYPE_JUDGE_FROM_DRIVER,
    .enabledTSNum = ENABLED_TS_NUM_2,
    .deviceSatStatus = DeviceSatStatus::DEVICE_SAT_STATUS_OTHER,
    .ringBufferMemCopyCycleTimes = 1U,
    .tsOverflowHandling = TsOverflowHandling::TS_OVER_FLOW_HANDING_DEFAULT,
    .getCapabilityMethod = GetCapabilityMethod::GET_CAPABILITY_BY_FEATURE_CHECK,
    .memcpyDescriptorSize = MEMCPY_DESC_SIZE_V1,
    .cmoDDRStructInfoSize = 0U,
    .streamWaitEventTimeout = StreamWaitEventTimeout::NOT_SUPPORT,
    .timelineEventId = TIMELINE_EVENT_ID_DEFAULT,
    .deviceSatStatusImpl = 1U,
    .allocManagedFlag = AllocManagedFlag::ALLOC_MANAGED_MEM_ADVISE_4G,
    .sdmaCopyMethod = SdmaCopyMethod::SDMA_COPY_BY_HAL,
    .eventPoolSize = 0U,
    .rtsqShamt = 0x1FFU,
    .supportCreateTaskRes = SupportCreateTaskRes::CREATE_TASK_RES_NOT_SUPPORT,
    .aicNumForCoreStack = 10U,
    .engineWaitCompletionTImeout = ENGINE_WAIT_COMPLETION_TIMEOUT,
    .reportWaitTimeout = RT_REPORT_MDC_TIMEOUT_TIME,
};
REGISTER_DEV_PROPERTIES(CHIP_ADC, CHIP_ADC_PROPERTIES);
}
}
