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

static constexpr rtSocInfo_t CHIP_MINI_SOC_INFO[] = {
    {SOC_ASCEND310, CHIP_MINI, ARCH_M100, "Ascend310"}
};

BATCH_REGISTER_SOC_INFO(CHIP_MINI_SOC_INFO, sizeof(CHIP_MINI_SOC_INFO) / sizeof(rtSocInfo_t));

REGISTER_PLATFORM_LIB_INFO(CHIP_MINI, "libruntime_v100.so");

static const std::unordered_set<RtOptionalFeatureType> CHIP_MINI_FEATURE{
    RtOptionalFeatureType::RT_FEATURE_DEVICE_VISIBLE,
    RtOptionalFeatureType::RT_FEATURE_PROFILING_ONLINE,
    RtOptionalFeatureType::RT_FEATURE_DFX_ARGS_DOT_ALLOC_ERROR_LOG,
    RtOptionalFeatureType::RT_FEATURE_DRIVER_NUMA_TS_MEM_CTRL,
    RtOptionalFeatureType::RT_FEATURE_TASK_RDMA,
    RtOptionalFeatureType::RT_FEATURE_TASK_TRY_RECYCLE_DISABLE_HWTS,
    RtOptionalFeatureType::RT_FEATURE_PROFILING_AICPU,
    RtOptionalFeatureType::RT_FEATURE_STREAM_HUGE_DEPTH,
    RtOptionalFeatureType::RT_FEATURE_STREAM_ABORT,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_SPM_POOL
};

REGISTER_CHIP_FEATURE_SET(CHIP_MINI, CHIP_MINI_FEATURE);

static constexpr uint32_t CQE_DEPTH = 1024U;
static constexpr uint32_t DEFAULT_CQE_SIZE = 12U;
static constexpr uint32_t KERNEL_CUSTOM_STACK_SIZE_MAX = 7864320U; // 7680KB

static const DevProperties CHIP_MINI_PROPERTIES = {
    .engineType = "HWTS",
    .isStars = false,
    .pthreadStackSize = PTHREAD_STACK_SIZE,
    .eventWaitTimeout = EventWaitTimeoutType::SET_OP_WAIT_TIMEOUT_CONFIG,
    .tsCount = 1U,
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
    .maxCustomerStackSize = KERNEL_CUSTOM_STACK_SIZE_MAX,
    .aicNum = RT_AICORE_NUM_1,
    .aivNum = RT_AIVECTOR_NUM_1,
    .ringbufSize = DEVICE_RINGBUFFER_SIZE,
    .hugeManagedFlag = TS_PAGE_HUGE_ALIGNED,
    .memAllocPctraceFlag = MEM_SVM_HUGE,
    .memInfoType = RT_MEM_INFO_TYPE_DDR_SIZE,
    .taskPrefetchCount = PREFETCH_CNT_8,
    .maxAllocHugeStreamNum = DEFAULT,
    .resetMaxModelNum = NUM_RESET_WITH_DRIVER,
    .reduceAicNum = false,
    .timeoutUpdateMethod = TimeoutUpdateMethod::DEFAULT_METHOD,
    .hugePolicyFlag = TS_4G_CONTIGUOUS_PHY,
    .memInfoMapType = MAP_WHEN_GET_INFO | MAP_WHEN_SET_INFO,
    .resAllocRange = DEFAULT,
    .supportSnapshot = SupportSnapshot::NOT_SUPPORT,
    .MaxKernelCredit = 0U,
    .eventTimestampFreq = RT_DEFAULT_TIMESTAMP_FREQ,
    .taskEngineType = EngineCreateType::ASYNC_HWTS_ENGINE,
    .CmoSqeVersion = SqeVersion::CMO_SQE_VERSION_V1,
    .DefaultKernelCredit = 0U,
    .starsDefaultKernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT,
    .KernelCreditScale = 0.0F,
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
    .opExecuteTimeout = false,
    .omArchVersion = OMArchVersion::omArchVersion_DEFAULT,
    .checkArchVersionCompatibility = CheckArchVersionCompatibility::Arch_Version_Compat_DEFAULT,
    .dcacheLockMixPathSourceType = DcacheLockMixPathSourceType::DCACHE_LOCK_MIX_PATH_FROM_DEFAULT,
    .kernelFuncType = KernelFuncType::Kernel_FUC_TYPE_OTHER_AICORE,
    .taskPoolSizeFromMacroValue = false,
    .taskPoolSize = 0U,
    .getTsMemTypeMethod = GetTsMemTypeMethod::GET_TS_MEM_TYPE_JUDGE_FROM_DRIVER,
    .enabledTSNum = ENABLED_TS_NUM_1,
    .deviceSatStatus = DeviceSatStatus::DEVICE_SAT_STATUS_OTHER,
    .ringBufferMemCopyCycleTimes = 1U,
    .tsOverflowHandling = TsOverflowHandling::TS_OVER_FLOW_HANDING_DEFAULT,
    .getCapabilityMethod = GetCapabilityMethod::GET_CAPABILITY_BY_BOTH_FEATURE_AND_DRIVER_CHECK,
    .memcpyDescriptorSize = MEMCPY_DESC_SIZE_V1,
    .cmoDDRStructInfoSize = 0U,
    .streamWaitEventTimeout = StreamWaitEventTimeout::ZERO,
    .timelineEventId = TIMELINE_EVENT_ID_DEFAULT,
    .deviceSatStatusImpl = 0U,
    .allocManagedFlag = AllocManagedFlag::ALLOC_MANAGED_MEM_NORMAL,
    .sdmaCopyMethod = SdmaCopyMethod::SDMA_COPY_BY_MEM_SYNC_ADAPTER,
    .eventPoolSize = 0U,
    .rtsqShamt = 0x1FFU,
    .supportCreateTaskRes = SupportCreateTaskRes::CREATE_TASK_RES_NOT_SUPPORT,
    .aicNumForCoreStack = RT_AICORE_NUM_25,
    .engineWaitCompletionTImeout = 0UL,
    .reportWaitTimeout = RT_REPORT_TIMEOUT_TIME,
};

REGISTER_DEV_PROPERTIES(CHIP_MINI, CHIP_MINI_PROPERTIES);
}
}