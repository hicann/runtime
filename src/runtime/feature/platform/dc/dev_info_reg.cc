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

static constexpr rtSocInfo_t CHIP_DC_SOC_INFO[] = {
    {SOC_ASCEND310P3, CHIP_DC, ARCH_V200, "Ascend310P3"},
    {SOC_ASCEND310P1, CHIP_DC, ARCH_V200, "Ascend310P1"},
    {SOC_ASCEND310P5, CHIP_DC, ARCH_V200, "Ascend310P5"},
    {SOC_ASCEND310P7, CHIP_DC, ARCH_V200, "Ascend310P7"},
};

BATCH_REGISTER_SOC_INFO(CHIP_DC_SOC_INFO, sizeof(CHIP_DC_SOC_INFO) / sizeof(rtSocInfo_t));

REGISTER_PLATFORM_LIB_INFO(CHIP_DC, "libruntime_v100.so");

static const std::unordered_set<RtOptionalFeatureType> CHIP_DC_FEATURE{
    RtOptionalFeatureType::RT_FEATURE_DRIVER_NUMA_TS_MEM_CTRL,
    RtOptionalFeatureType::RT_FEATURE_IPC_MEMORY,
    RtOptionalFeatureType::RT_FEATURE_IPC_NOTIFY,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_TILING_KEY_SINK,
    RtOptionalFeatureType::RT_FEATURE_STREAM_GET_AVILIABLE_NUM,
    RtOptionalFeatureType::RT_FEATURE_PROFILING_ONLINE,
    RtOptionalFeatureType::RT_FEATURE_TASK_FLIP,
    RtOptionalFeatureType::RT_FEATURE_TASK_RDMA,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_REGISTER_CALLBACK,
    RtOptionalFeatureType::RT_FEATURE_TS_MEM_4G_SPACE_FOR_OVERFLOW,
    RtOptionalFeatureType::RT_FEATURE_STREAM_RECLAIM_ASYNC,
    RtOptionalFeatureType::RT_FEATURE_MODEL_EXECUTOR_WITH_QUEUE,
    RtOptionalFeatureType::RT_FEATURE_NOTIFY_WAIT_TIMEOUT,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_LAUNCH_CANNOT_MIX,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_VISIBLE,
    RtOptionalFeatureType::RT_FEATURE_TASK_RECYCLE_EVENT_THREAD,
    RtOptionalFeatureType::RT_FEATURE_TASK_MODEL_EXECUTE_COPY_ONCE,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_EXTRA_VECTOR_CORE,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_ARGS_ALLOC_DEFAULT,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_HAS_TS_DEAMON,
    RtOptionalFeatureType::RT_FEATURE_DFX_HWTS_LOG,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_P2P,
    RtOptionalFeatureType::RT_FEATURE_PROFILING_AICPU,
    RtOptionalFeatureType::RT_FEATURE_TASK_RECYCLE_THREAD,
    RtOptionalFeatureType::RT_FEATURE_STREAM_ONLINE,
    RtOptionalFeatureType::RT_FEATURE_DRIVER_EVENT_MC2,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_FAILURE_MODE_SET,
    RtOptionalFeatureType::RT_FEATURE_DFX_TS_GET_DEVICE_MSG,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_GROUP_DOT_ON_DEMAND,
    RtOptionalFeatureType::RT_FEATURE_STREAM_ABORT,
    RtOptionalFeatureType::RT_FEATURE_STREAM_POLLING_TASK_POSITION_PREFER,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_GROUP_INFO_SETUP_DOT_ON_DEMIND,
    RtOptionalFeatureType::RT_FEATURE_DFX_AICPU_ERROR_MESSAGE,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_MESSAGE_QUEUE,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_STREAM_CTRL,
    RtOptionalFeatureType::RT_FEATURE_STREAM_PENGING_HALF_DEEPTH,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_ELF_NO_FUNC_TYPE,
    RtOptionalFeatureType::RT_FEATURE_MODEL_UPDATE_SQE_TILING_KEY,
    RtOptionalFeatureType::RT_FEATURE_MODEL_ABORT,
    RtOptionalFeatureType::RT_FEATURE_MODEL_ABORT_USE_DEFAULT_STREAM,
    RtOptionalFeatureType::RT_FEATURE_DFX_FLOAT_OVERFLOW_DEBUG,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_GET_RESOURCE_NUM_DYNAMIC,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_SET_RUNTIME_CAPABLITY,
    RtOptionalFeatureType::RT_FEATURE_STREAM_DOT_SET_MODE,
    RtOptionalFeatureType::RT_FEATURE_TASK_MEMORY_COPY_DOT_HOST,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_MIX,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_INIT_BY_CTRL_CODE,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_SPM_POOL,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_MIX_DEGENERATE,
    RtOptionalFeatureType::RT_FEATURE_MODEL_STREAM_DOT_REUSE,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_GROUP,
    RtOptionalFeatureType::RT_FEATURE_STREAM_CREATE_PRIORITY_GREATEST,
    RtOptionalFeatureType::RT_FEATURE_STREAM_ATTR_FAILURE_MODE,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_C2C_SYNC,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_BINARY_LOAD_DOT_WITHOUT_TILING,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_BINARY_GET_FUNCTION_DOT_BY_NAME,
    RtOptionalFeatureType::RT_FEATURE_MODEL_ID_FOR_AICPU,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_UMA_SUPER_ARGS_ALLOC,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_EVENT_POOL,
    RtOptionalFeatureType::RT_FEATURE_PROFILING_ONLINE_DEVICE_MEM_CLEAR,
    RtOptionalFeatureType::RT_FEATURE_PROFILING_TS_DYNAMIC,
    RtOptionalFeatureType::RT_FEATURE_TASK_DAVINCI_WITH_ARGS_SIZE,
    RtOptionalFeatureType::RT_FEATURE_TASK_NUM_DOT_EXPAND,
    RtOptionalFeatureType::RT_FEATURE_MEM_DESTROY_ADDR_BATCH,
    RtOptionalFeatureType::RT_FEATURE_MODEL_ACL_GRAPH,
    RtOptionalFeatureType::RT_FEATURE_MODEL_JSON_PRINT
};

REGISTER_CHIP_FEATURE_SET(CHIP_DC, CHIP_DC_FEATURE);

static constexpr uint32_t CQE_DEPTH = 1024U;
static constexpr uint32_t DEFAULT_CQE_SIZE = 12U;
constexpr uint32_t TS_FEATURE_MC2_RTS_SUPPORT_HCCL_DC_PROP = 25;
static constexpr uint32_t RT_HWTS_MAX_KERNEL_CREDIT_UINT32 = 255U; // HWTS MAX KERNEL_CREDIT = 255.
static constexpr uint32_t RT_HWTS_310P_DEFAULT_KERNEL_CREDIT_UINT32 = 255U; // The TS 310P reference time is 547608330.240 us.
static constexpr double RT_HWTS_310P_TASK_KERNEL_CREDIT_SCALE_US = 2147483.648F; // 2^31 / 1000M *1000*1000(us)

static const DevProperties CHIP_DC_PROPERTIES = {
    .engineType = "HWTS",
    .isStars = false,
    .pthreadStackSize = 0U,
    .eventWaitTimeout = EventWaitTimeoutType::SET_OP_WAIT_TIMEOUT_NEED_TS_VERSION,
    .tsCount = 1U,
    .defaultTaskRatio = NORMAL_TASK_RATION,
    .sqTailOffset = STARS_SIMPLE_SQ_TAIL_OFFSET,
    .maxGroupId = MAX_GROUP_ID,
    .reduceOverflow = ReduceOverflowType::REDUCE_OVERFLOW_TS_VERSION_REDUCV2_SUPPORT_DC,
    .isSupportSetDeviceSatMode = false,
    .sdmaReduceKind = 0x6400U, // 12 and 13 bit is 0
    .starsResourceAddrCalculateMethod = StarsResourceAddrCalculateMethod::STARS_RESOURCE_ADDR_CALCULATE_STATIC,
    .eventBase = RT_STARS_BASE_ADDR_520000000 + STARS_EVENT_BASE_ADDR,
    .starsBaseMethod = StarsBaseMethod::STARS_BASE_CALCULATE_STATIC,
    .fsmSelBase = RT_STARS_BASE_ADDR_520000000 + STARS_SIMPLE_RTSQ_FSM_SEL_REG,
    .notifyBase = RT_STARS_BASE_ADDR_520000000 + STARS_NOTIFY_BASE_ADDR,
    .starsNotifyTableSize = STARS_NOTIFY_NUM_OF_SINGLE_TABLE_128,
    .ipcNotifyNumMask = 0x7FUL,
    .mc2FeatureFlag = TS_FEATURE_MC2_RTS_SUPPORT_HCCL_DC_PROP,
    .stackPhyBase = RT_SCALAR_BUFFER_SIZE_32K_75,
    .maxCustomerStackSize = DEFAULT_CUSTOM_STACK_SIZE_MAX,
    .aicNum = RT_AICORE_NUM_25,
    .aivNum = RT_AIVECTOR_NUM_50,
    .ringbufSize = DEVICE_RINGBUFFER_SIZE,
    .hugeManagedFlag = TS_4G_CONTIGUOUS_PHY,
    .memAllocPctraceFlag = MEM_DEV | MEM_TYPE_HBM | MEM_PAGE_NORMAL | MEM_ADVISE_4G,
    .memInfoType = RT_MEM_INFO_TYPE_DDR_SIZE,
    .taskPrefetchCount = PREFETCH_CNT_10,
    .maxAllocHugeStreamNum = DEFAULT,
    .resetMaxModelNum = NUM_RESET_WITH_DRIVER,
    .reduceAicNum = false,
    .timeoutUpdateMethod = TimeoutUpdateMethod::DEFAULT_METHOD,
    .hugePolicyFlag = TS_4G_CONTIGUOUS_PHY,
    .memInfoMapType = MAP_WHEN_GET_INFO | MAP_WHEN_SET_INFO,
    .resAllocRange = DEFAULT,
    .supportSnapshot = SupportSnapshot::NOT_SUPPORT,
    .MaxKernelCredit = RT_HWTS_MAX_KERNEL_CREDIT_UINT32,
    .eventTimestampFreq = RT_DEFAULT_TIMESTAMP_FREQ,
    .taskEngineType = EngineCreateType::DIRECT_HWTS_ENGINE,
    .CmoSqeVersion = SqeVersion::CMO_SQE_VERSION_V1,
    .DefaultKernelCredit = RT_HWTS_310P_DEFAULT_KERNEL_CREDIT_UINT32,
    .starsDefaultKernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT,
    .KernelCreditScale = RT_HWTS_310P_TASK_KERNEL_CREDIT_SCALE_US,
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
    .isNeedlogErrorLevel = false,
    .overflowMode = false,
    .opExecuteTimeout = false,
    .omArchVersion = OMArchVersion::omArchVersion_DEFAULT,
    .checkArchVersionCompatibility = CheckArchVersionCompatibility::Arch_Version_Compat_DEFAULT,
    .dcacheLockMixType = DcacheLockMixType::DCACHE_LOCK_MIX_TYPE_FROM_DEFAULT,
    .kernelFuncType = KernelFuncType::Kernel_FUC_TYPE_OTHER_AICORE,
    .taskPoolSizeFromMacroValue = false,
    .taskPoolSize = 1024U,
    .getTsMemTypeMethod = GetTsMemTypeMethod::GET_TS_MEM_TYPE_JUDGE_FROM_DRIVER,
    .enabledTSNum = ENABLED_TS_NUM_1,
    .deviceSatStatus = DeviceSatStatus::DEVICE_SAT_STATUS_OTHER,
    .ringBufferMemCopyCycleTimes = 100U,
    .tsOverflowHandling = TsOverflowHandling::TS_OVER_FLOW_HANDING_FROM_MEM,
    .getCapabilityMethod = GetCapabilityMethod::GET_CAPABILITY_BY_FEATURE_CHECK,
    .memcpyDescriptorSize = MEMCPY_DESC_SIZE_V1,
    .cmoDDRStructInfoSize = 0U,
    .streamWaitEventTimeout = StreamWaitEventTimeout::ZERO,
    .timelineEventId = TIMELINE_EVENT_ID_DEFAULT,
    .deviceSatStatusImpl = 1U,
    .allocManagedFlag = AllocManagedFlag::ALLOC_MANAGED_MEM_ADVISE_4G,
    .sdmaCopyMethod = SdmaCopyMethod::SDMA_COPY_BY_MEM_SYNC_ADAPTER,
    .eventPoolSize = 8U,
    .rtsqShamt = 0x1FFU,
    .supportCreateTaskRes = SupportCreateTaskRes::CREATE_TASK_RES_SUPPORT,
    .aicNumForCoreStack = RT_AICORE_NUM_25,
    .engineWaitCompletionTImeout = 0UL,
    .reportWaitTimeout = RT_REPORT_TIMEOUT_TIME,
};

REGISTER_DEV_PROPERTIES(CHIP_DC, CHIP_DC_PROPERTIES);
}
}
