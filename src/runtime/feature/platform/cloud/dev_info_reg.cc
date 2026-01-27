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

static constexpr rtSocInfo_t CHIP_CLOUD_SOC_INFO[] = {
    {SOC_ASCEND910A, CHIP_CLOUD, ARCH_C100, "Ascend910A"},
    {SOC_ASCEND910A, CHIP_CLOUD, ARCH_C100, "Ascend910"},
    {SOC_ASCEND910B, CHIP_CLOUD, ARCH_C100, "Ascend910B"},
    {SOC_ASCEND910ProA, CHIP_CLOUD, ARCH_C100, "Ascend910ProA"},
    {SOC_ASCEND910ProB, CHIP_CLOUD, ARCH_C100, "Ascend910ProB"},
    {SOC_ASCEND910PremiumA, CHIP_CLOUD, ARCH_C100, "Ascend910PremiumA"}
};

BATCH_REGISTER_SOC_INFO(CHIP_CLOUD_SOC_INFO, sizeof(CHIP_CLOUD_SOC_INFO) / sizeof(rtSocInfo_t));

REGISTER_PLATFORM_LIB_INFO(CHIP_CLOUD, "libruntime_v100.so");

static const std::unordered_set<RtOptionalFeatureType> CHIP_CLOUD_FEATURE{
    RtOptionalFeatureType::RT_FEATURE_DEVICE_SPM_POOL,
    RtOptionalFeatureType::RT_FEATURE_IPC_MEMORY,
    RtOptionalFeatureType::RT_FEATURE_IPC_NOTIFY,
    RtOptionalFeatureType::RT_FEATURE_STREAM_GET_AVILIABLE_NUM,
    RtOptionalFeatureType::RT_FEATURE_DRIVER_NUMA_TS_MEM_CTRL,
    RtOptionalFeatureType::RT_FEATURE_PROFILING_ONLINE,
    RtOptionalFeatureType::RT_FEATURE_TASK_FLIP,
    RtOptionalFeatureType::RT_FEATURE_DFX_ARGS_DOT_ALLOC_ERROR_LOG,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_AICORE_NUM_BY_LEVEL,
    RtOptionalFeatureType::RT_FEATURE_TASK_RDMA,
    RtOptionalFeatureType::RT_FEATURE_TS_SCHED_AICPU_MODE,
    RtOptionalFeatureType::RT_FEATURE_STREAM_RECLAIM_ASYNC,
    RtOptionalFeatureType::RT_FEATURE_MEM_MIX_HBM_AND_DDR,
    RtOptionalFeatureType::RT_FEATURE_TASK_TRY_RECYCLE_DISABLE_HWTS,
    RtOptionalFeatureType::RT_FEATURE_NOTIFY_WAIT_TIMEOUT,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_VIRTUAL_MODE_CHECK,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_VISIBLE,
    RtOptionalFeatureType::RT_FEATURE_TASK_MODEL_EXECUTE_COPY_ONCE,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_HAS_TS_DEAMON,
    RtOptionalFeatureType::RT_FEATURE_DFX_HWTS_LOG,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_NO_MIX_DOT_REGISTER,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_P2P,
    RtOptionalFeatureType::RT_FEATURE_PROFILING_AICPU,
    RtOptionalFeatureType::RT_FEATURE_TASK_RECYCLE_THREAD,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_MESSAGE_QUEUE,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_STREAM_CTRL,
    RtOptionalFeatureType::RT_FEATURE_DRIVER_DFX_RECORD_MODULE_ID,
    RtOptionalFeatureType::RT_FEATURE_TASK_LABEL_GOTO,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_FAILURE_MODE_SET,
    RtOptionalFeatureType::RT_FEATURE_DFX_TS_GET_DEVICE_MSG,
    RtOptionalFeatureType::RT_FEATURE_STREAM_HUGE_DEPTH,
    RtOptionalFeatureType::RT_FEATURE_STREAM_ABORT,
    RtOptionalFeatureType::RT_FEATURE_MODEL_ABORT,
    RtOptionalFeatureType::RT_FEATURE_MODEL_ABORT_USE_DEFAULT_STREAM,
    RtOptionalFeatureType::RT_FEATURE_DFX_FLOAT_OVERFLOW_DEBUG,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_GET_RESOURCE_NUM_DYNAMIC,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_SET_RUNTIME_CAPABLITY,
    RtOptionalFeatureType::RT_FEATURE_STREAM_DOT_SET_MODE,
    RtOptionalFeatureType::RT_FEATURE_TASK_MEMORY_COPY_DOT_HOST,
    RtOptionalFeatureType::RT_FEATURE_MEM_HOST_REGISTER,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_ELF_NO_FUNC_TYPE,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_ELF_AICPU_MACHINE,
    RtOptionalFeatureType::RT_FEATURE_TASK_MEMCPY_D2D_BY_OFFSET,
    RtOptionalFeatureType::RT_FEATURE_STREAM_ATTR_FAILURE_MODE,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_C2C_SYNC,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_BINARY_LOAD_DOT_WITHOUT_TILING,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_BINARY_GET_FUNCTION_DOT_BY_NAME,
    RtOptionalFeatureType::RT_FEATURE_MODEL_ID_FOR_AICPU,
    RtOptionalFeatureType::RT_FEATURE_NOTIFY_WAIT,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_UMA_SUPER_ARGS_ALLOC,
    RtOptionalFeatureType::RT_FEATURE_TASK_DAVINCI_WITH_ARGS_SIZE,
    RtOptionalFeatureType::RT_FEATURE_MEM_DESTROY_ADDR_BATCH
};

REGISTER_CHIP_FEATURE_SET(CHIP_CLOUD, CHIP_CLOUD_FEATURE);

static constexpr uint32_t CQE_DEPTH = 1024U;
static constexpr uint32_t DEFAULT_CQE_SIZE = 12U;
static constexpr uint32_t RT_HWTS_910A_MAX_BLOCK_DIM_UINT32 = 32U; // 910A BLOCK_DIM = 32.
static constexpr uint32_t RT_HWTS_910A_DEFAULT_BLOCK_DIM_UINT32 = 1U; // The default timeout duration for the 1980's AIC operator is related to the blocdim. This returns the ​​tick​​ of the timeout.
static constexpr double RT_HWTS_910A_TASK_KERNEL_CREDIT_SCALE_US = 68719476.736F; // 2^36 / 1000M *1000*1000(us)

static const DevProperties CHIP_CLOUD_PROPERTIES = {
    .engineType = "HWTS",
    .isStars = false,
    .pthreadStackSize = PTHREAD_STACK_SIZE,
    .eventWaitTimeout = EventWaitTimeoutType::SET_OP_WAIT_TIMEOUT_CONFIG,
    .tsCount = 1U,
    .defaultTaskRatio = NORMAL_TASK_RATION,
    .sqTailOffset = STARS_SIMPLE_SQ_TAIL_OFFSET,
    .maxGroupId = MAX_GROUP_ID,
    .reduceOverflow = ReduceOverflowType::REDUCE_OVERFLOW_TS_VERSION_REDUCE_V2_ID,
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
    .stackPhyBase = RT_SCALAR_BUFFER_SIZE_32K_75,
    .maxCustomerStackSize = DEFAULT_CUSTOM_STACK_SIZE_MAX,
    .aicNum = RT_AICORE_NUM_25,
    .aivNum = RT_AIVECTOR_NUM_50,
    .ringbufSize = DEVICE_RINGBUFFER_SIZE,
    .hugeManagedFlag = TS_PAGE_HUGE_ALIGNED | TS_WITH_HBM ,
    .memAllocPctraceFlag = MEM_SVM_HUGE,
    .memInfoType = RT_MEM_INFO_TYPE_HBM_SIZE,
    .taskPrefetchCount = PREFETCH_CNT_8,
    .maxAllocHugeStreamNum = DEFAULT,
    .resetMaxModelNum = NUM_RESET_WITH_FIXED_VALUE | NUM_RESET_WITH_DRIVER,
    .reduceAicNum = false,
    .timeoutUpdateMethod = TimeoutUpdateMethod::DEFAULT_METHOD,
    .hugePolicyFlag = DEFAULT,
    .memInfoMapType = DEFAULT,
    .resAllocRange = DEFAULT,
    .supportSnapshot = SupportSnapshot::SUPPORT_ON_HIGH_TS_VERSION,
    .MaxKernelCredit = RT_HWTS_910A_MAX_BLOCK_DIM_UINT32,
    .eventTimestampFreq = RT_DEFAULT_TIMESTAMP_FREQ,
    .taskEngineType = EngineCreateType::DIRECT_HWTS_ENGINE,
    .CmoSqeVersion = SqeVersion::CMO_SQE_VERSION_V1,
    .DefaultKernelCredit = RT_HWTS_910A_DEFAULT_BLOCK_DIM_UINT32,
    .starsDefaultKernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT,
    .KernelCreditScale = RT_HWTS_910A_TASK_KERNEL_CREDIT_SCALE_US,
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
    .cqeWaitTimeout = RT_REPORT_STARS_TIMEOUT_TIME,
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
    .omArchVersion = OMArchVersion::omArchVersion_3,
    .checkArchVersionCompatibility = CheckArchVersionCompatibility::Arch_Version_Compat_V100,
    .dcacheLockMixPathSourceType = DcacheLockMixPathSourceType::DCACHE_LOCK_MIX_PATH_FROM_DEFAULT,
    .kernelFuncType = KernelFuncType::Kernel_FUC_TYPE_OTHER_AICORE,
    .taskPoolSizeFromMacroValue = false,
    .taskPoolSize = 2048U,
    .getTsMemTypeMethod = GetTsMemTypeMethod::GET_TS_MEM_TYPE_JUDGE_FROM_DRIVER,
    .enabledTSNum = ENABLED_TS_NUM_1,
    .deviceSatStatus = DeviceSatStatus::DEVICE_SAT_STATUS_OTHER,
    .ringBufferMemCopyCycleTimes = 1U,
    .tsOverflowHandling = TsOverflowHandling::TS_OVER_FLOW_HANDING_FROM_MEM,
    .getCapabilityMethod = GetCapabilityMethod::GET_CAPABILITY_BY_BOTH_FEATURE_AND_DRIVER_CHECK,
    .memcpyDescriptorSize = MEMCPY_DESC_SIZE_V1,
    .cmoDDRStructInfoSize = 0U,
    .streamWaitEventTimeout = StreamWaitEventTimeout::NOT_SUPPORT,
    .timelineEventId = TIMELINE_EVENT_ID_DEFAULT,
    .deviceSatStatusImpl = 1U,
    .allocManagedFlag = AllocManagedFlag::ALLOC_MANAGED_MEM_SET_ALIGN_SIZE,
    .sdmaCopyMethod = SdmaCopyMethod::SDMA_COPY_BY_MEM_SYNC_ADAPTER,
    .eventPoolSize = 0U,
    .rtsqShamt = 0x1FFU,
    .supportCreateTaskRes = SupportCreateTaskRes::CREATE_TASK_RES_SUPPORT,
    .aicNumForCoreStack = RT_AICORE_NUM_25,
    .engineWaitCompletionTImeout = 0UL,
    .reportWaitTimeout = RT_REPORT_TIMEOUT_TIME,
};
REGISTER_DEV_PROPERTIES(CHIP_CLOUD, CHIP_CLOUD_PROPERTIES);
}
}
