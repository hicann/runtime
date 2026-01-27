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
static constexpr rtSocInfo_t CHIP_MINI_V3_SOC_INFO[] = {
    {SOC_ASCEND310B1, CHIP_MINI_V3, ARCH_V300, "Ascend310B1"},
    {SOC_ASCEND310B2, CHIP_MINI_V3, ARCH_V300, "Ascend310B2"},
    {SOC_ASCEND310B3, CHIP_MINI_V3, ARCH_V300, "Ascend310B3"},
    {SOC_ASCEND310B4, CHIP_MINI_V3, ARCH_V300, "Ascend310B4"},
};

BATCH_REGISTER_SOC_INFO(CHIP_MINI_V3_SOC_INFO, sizeof(CHIP_MINI_V3_SOC_INFO) / sizeof(rtSocInfo_t));

REGISTER_PLATFORM_LIB_INFO(CHIP_MINI_V3, "libruntime_v100.so");

static const std::unordered_set<RtOptionalFeatureType> CHIP_MINI_V3_FEATURE{
    RtOptionalFeatureType::RT_FEATURE_DRIVER_NUMA_TS_MEM_CTRL,
    RtOptionalFeatureType::RT_FEATURE_TASK_ASYNC_CMO,
    RtOptionalFeatureType::RT_FEATURE_STREAM_GET_AVILIABLE_NUM,
    RtOptionalFeatureType::RT_FEATURE_PROFILING_ONLINE,
    RtOptionalFeatureType::RT_FEATURE_TASK_FLIP,
    RtOptionalFeatureType::RT_FEATURE_DFX_ARGS_DOT_ALLOC_ERROR_LOG,
    RtOptionalFeatureType::RT_FEATURE_TASK_DVPP,
    RtOptionalFeatureType::RT_FEATURE_TASK_RDMA,
    RtOptionalFeatureType::RT_FEATURE_STREAM_DVPP_GROUP,
    RtOptionalFeatureType::RT_FEATURE_TASK_TRY_RECYCLE_DISABLE_HWTS,
    RtOptionalFeatureType::RT_FEATURE_NOTIFY_WAIT_TIMEOUT,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_VISIBLE,
    RtOptionalFeatureType::RT_FEATURE_TASK_MODEL_EXECUTE_COPY_ONCE,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_HAS_TS_DEAMON,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_GET_STARS_VERSION,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_NO_MIX_DOT_REGISTER,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_P2P,
    RtOptionalFeatureType::RT_FEATURE_PROFILING_AICPU,
    RtOptionalFeatureType::RT_FEATURE_HOST_CPU_MODEL_INFO_FROM_FILE,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_FAILURE_MODE_SET,
    RtOptionalFeatureType::RT_FEATURE_MODEL_CMO_BARRIER,
    RtOptionalFeatureType::RT_FEATURE_DFX_TS_GET_DEVICE_MSG,
    RtOptionalFeatureType::RT_FEATURE_STREAM_HUGE_DEPTH,
    RtOptionalFeatureType::RT_FEATURE_STREAM_ABORT,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_ELF_NO_FUNC_TYPE,
    RtOptionalFeatureType::RT_FEATURE_STREAM_DELETE_FORCE,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_TYPE_UPDATE_NO_MIX,
    RtOptionalFeatureType::RT_FEATURE_DFX_FLOAT_OVERFLOW_DEBUG,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_GET_RESOURCE_NUM_DYNAMIC,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_SET_RUNTIME_CAPABLITY,
    RtOptionalFeatureType::RT_FEATURE_STREAM_DOT_SET_MODE,
    RtOptionalFeatureType::RT_FEATURE_TASK_MEMORY_COPY_DOT_HOST,
    RtOptionalFeatureType::RT_FEATURE_MODEL_ABORT,
    RtOptionalFeatureType::RT_FEATURE_MODEL_ABORT_USE_DEFAULT_STREAM,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_SPM_POOL,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_BINARY_MACHINE_CVMIX,
    RtOptionalFeatureType::RT_FEATURE_STREAM_ATTR_FAILURE_MODE,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_ADDR_PREFETCH_CNT,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_C2C_SYNC,
    RtOptionalFeatureType::RT_FEATURE_MODEL_ID_FOR_AICPU,
    RtOptionalFeatureType::RT_FEATURE_NOTIFY_WAIT,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_UMA_SUPER_ARGS_ALLOC,
    RtOptionalFeatureType::RT_FEATURE_STREAM_EXECUTED_POS_INIT_DOT_STATIC,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_MEM_COPY_DOT_D2D_ONLY
};

REGISTER_CHIP_FEATURE_SET(CHIP_MINI_V3, CHIP_MINI_V3_FEATURE);

static constexpr uint32_t CQE_DEPTH = 2048U;
constexpr static uint32_t SQE_DEPTH = 2048U;
static constexpr uint32_t RT_STARS_MAX_KERNEL_CREDIT_UINT32 = 254U; // STARS MAX KERNEL_CREDIT = 255.
static constexpr uint32_t RT_STARS_DEFAULT_KERNEL_CREDIT_UINT32 = 254U; // The STARS reference time is 1090921693.184 us.
static constexpr double RT_STARS_TASK_KERNEL_CREDIT_SCALE_US = 4294967.296F; // 2^32 / 1000M *1000*1000(us)
static constexpr uint32_t KERNEL_CUSTOM_STACK_SIZE_MAX = 7864320U; // 7680KB

static const DevProperties CHIP_MINI_V3_PROPERTIES = {
    .engineType = "STARS",
    .isStars = true,
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
    .MaxKernelCredit = RT_STARS_MAX_KERNEL_CREDIT_UINT32,
    .eventTimestampFreq = RT_CHIP_MINI_V3_TIMESTAMP_FREQ,
    .taskEngineType = EngineCreateType::STARS_ENGINE,
    .CmoSqeVersion = SqeVersion::CMO_SQE_VERSION_V1,
    .DefaultKernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_UINT32,
    .starsDefaultKernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT,
    .KernelCreditScale = RT_STARS_TASK_KERNEL_CREDIT_SCALE_US,
    .isSupportInitFuncCallPara = true,
    .rtsqVirtualAddr = {RT_STARS_BASE_ADDR_520000000 + STARS_SIMPLE_RTSQ_FSM_SEL_REG,
        STARS_SIMPLE_SQ_ENABLE_OFFSET,
        STARS_SIMPLE_SQ_TAIL_OFFSET,
        STARS_SIMPLE_SQ_HEAD_OFFSET},
    .rtsqFsmStateAddrCalMethod = RtsqFsmStateAddrCalMethod::FSM_ADDR_CALCULATE_STATIC,
    .starsBaseAddrMethod = StarsBaseAddrMethod::STARS_BASE_CALCULATE_STATIC,
    .rtSqEnableAddrCalMethod = RtSqEnableAddrCalMethod::RT_SQ_ENABLE_ADDR_CAL_STATIC,
    .isSupportDvppAccelerator = true,
    .isSupportDevVA2PA = false,
    .cmoAddrInfoType = CmoAddrInfoType::CMO_ADDR_INFO_TYPE_DAFAULT,
    .memcpyAsyncTaskD2DQos = UINT32_MAX,
    .isMemcpyAsyncTaskSqeType = true,
    .sqeDepth = SQE_DEPTH,
    .cqeSize = RT_VIRTUAL_CQE_SIZE,
    .cqeDepth = CQE_DEPTH,
    .cqeWaitTimeout = RT_REPORT_STARS_TIMEOUT_TIME,
    .getRtsqPosition = RT_MILAN_POSITION_NUM_MAX_MINIV3,
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
    .tsOverflowHandling = TsOverflowHandling::TS_OVER_FLOW_HANDING_FROM_MEM,
    .getCapabilityMethod = GetCapabilityMethod::GET_CAPABILITY_BY_BOTH_FEATURE_AND_DRIVER_CHECK,
    .memcpyDescriptorSize = MEMCPY_DESC_SIZE_V1,
    .cmoDDRStructInfoSize = 0U,
    .streamWaitEventTimeout = StreamWaitEventTimeout::CUSTOM,
    .timelineEventId = TIMELINE_EVENT_ID_DEFAULT,
    .deviceSatStatusImpl = 1U,
    .allocManagedFlag = AllocManagedFlag::ALLOC_MANAGED_MEM_SET_ALIGN_SIZE,
    .sdmaCopyMethod = SdmaCopyMethod::SDMA_COPY_BY_MEM_SYNC_ADAPTER,
    .eventPoolSize = 0U,
    .rtsqShamt = 0x1FFU,
    .supportCreateTaskRes = SupportCreateTaskRes::CREATE_TASK_RES_NOT_SUPPORT,
    .aicNumForCoreStack = RT_AICORE_NUM_1,
    .engineWaitCompletionTImeout = 0UL,
    .reportWaitTimeout = RT_REPORT_TIMEOUT_TIME,
};
REGISTER_DEV_PROPERTIES(CHIP_MINI_V3, CHIP_MINI_V3_PROPERTIES);
}
}
