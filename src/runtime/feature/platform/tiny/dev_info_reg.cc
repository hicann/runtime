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

static constexpr rtSocInfo_t CHIP_5612_SOC_INFO[] = {
    {SOC_ASCEND320T, CHIP_ASCEND_031, ARCH_T300, "Ascend031"},
};

BATCH_REGISTER_SOC_INFO(CHIP_5612_SOC_INFO, sizeof(CHIP_5612_SOC_INFO) / sizeof(rtSocInfo_t));

REGISTER_PLATFORM_LIB_INFO(CHIP_ASCEND_031, "libruntime_v100.so");

static const std::unordered_set<RtOptionalFeatureType> CHIP_5612_FEATURE{
    RtOptionalFeatureType::RT_FEATURE_DFX_HWTS_LOG,
    RtOptionalFeatureType::RT_FEATURE_STREAM_GET_AVILIABLE_NUM,
    RtOptionalFeatureType::RT_FEATURE_PROFILING_ONLINE,
    RtOptionalFeatureType::RT_FEATURE_DFX_ARGS_DOT_ALLOC_ERROR_LOG,
    RtOptionalFeatureType::RT_FEATURE_TASK_RDMA,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_FAILURE_MODE_SET,
    RtOptionalFeatureType::RT_FEATURE_TASK_TRY_RECYCLE_DISABLE_HWTS,
    RtOptionalFeatureType::RT_FEATURE_NOTIFY_WAIT_TIMEOUT,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_NO_MIX_DOT_REGISTER,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_P2P,
    RtOptionalFeatureType::RT_FEATURE_STREAM_HUGE_DEPTH,
    RtOptionalFeatureType::RT_FEATURE_STREAM_ABORT,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_ELF_NO_FUNC_TYPE,
    RtOptionalFeatureType::RT_FEATURE_DFX_FLOAT_OVERFLOW_DEBUG,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_GET_RESOURCE_NUM_DYNAMIC,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_SET_RUNTIME_CAPABLITY,
    RtOptionalFeatureType::RT_FEATURE_STREAM_DOT_SET_MODE,
    RtOptionalFeatureType::RT_FEATURE_TASK_MEMORY_COPY_DOT_HOST,
    RtOptionalFeatureType::RT_FEATURE_STREAM_DELETE_FORCE,
    RtOptionalFeatureType::RT_FEATURE_MODEL_ABORT,
    RtOptionalFeatureType::RT_FEATURE_MODEL_ABORT_USE_DEFAULT_STREAM,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_SPM_POOL,
    RtOptionalFeatureType::RT_FEATURE_STREAM_ATTR_FAILURE_MODE,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_ADDR_PREFETCH_CNT,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_C2C_SYNC,
    RtOptionalFeatureType::RT_FEATURE_MODEL_ID_FOR_AICPU,
    RtOptionalFeatureType::RT_FEATURE_NOTIFY_WAIT,
    RtOptionalFeatureType::RT_FEATURE_KERNEL_UMA_SUPER_ARGS_ALLOC,
    RtOptionalFeatureType::RT_FEATURE_MEM_SPMPOOL_SIZE_DIV,
    RtOptionalFeatureType::RT_FEATURE_TASK_DAVINCI_WITH_SCHEM_MODE,
    RtOptionalFeatureType::RT_FEATURE_DEVICE_MEM_COPY_DOT_D2D_ONLY
};

REGISTER_CHIP_FEATURE_SET(CHIP_ASCEND_031, CHIP_5612_FEATURE);

static constexpr uint32_t CQE_DEPTH = 2048U;
static constexpr uint32_t SQE_DEPTH = 2048U;
static constexpr uint32_t TINY_ARG_MAX_ENTRY_INIT_NUM = 4U;

static const DevProperties CHIP_5612_PROPERTIES = {
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
    .eventBase = RT_STARS_BASE_ADDR_78000000 + STARS_EVENT_BASE_ADDR,
    .starsBaseMethod = StarsBaseMethod::STARS_BASE_CALCULATE_STATIC,
    .fsmSelBase = RT_STARS_BASE_ADDR_78000000 + STARS_SIMPLE_RTSQ_FSM_SEL_REG,
    .notifyBase = RT_STARS_BASE_ADDR_78000000 + STARS_NOTIFY_BASE_ADDR,
    .starsNotifyTableSize = STARS_NOTIFY_NUM_OF_SINGLE_TABLE,
    .ipcNotifyNumMask = 0x7FUL,
    .mc2FeatureFlag = 0U,
    .stackPhyBase = RT_TINY_SCALAR_BUFFER_SIZE,
    .maxCustomerStackSize = DEFAULT_CUSTOM_STACK_SIZE_MAX,
    .aicNum = RT_AICORE_NUM_25,
    .aivNum = RT_AIVECTOR_NUM_50,
    .ringbufSize = 0U,
    .hugeManagedFlag = 0U,
    .memAllocPctraceFlag = MEM_SVM_HUGE,
    .memInfoType = RT_MEM_INFO_TYPE_DDR_SIZE,
    .taskPrefetchCount = PREFETCH_CNT_8,
    .maxAllocHugeStreamNum = DEFAULT,
    .resetMaxModelNum = NUM_RESET_WITH_DRIVER,
    .reduceAicNum = false,
    .timeoutUpdateMethod = TimeoutUpdateMethod::DEFAULT_METHOD,
    .hugePolicyFlag = DEFAULT,
    .memInfoMapType = DEFAULT,
    .resAllocRange = DEFAULT,
    .supportSnapshot = SupportSnapshot::NOT_SUPPORT,
    .MaxKernelCredit = 0,
    .eventTimestampFreq = RT_DEFAULT_TIMESTAMP_FREQ,
    .taskEngineType = EngineCreateType::STARS_ENGINE,
    .CmoSqeVersion = SqeVersion::CMO_SQE_VERSION_V1,
    .DefaultKernelCredit = 0U,
    .starsDefaultKernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT,
    .KernelCreditScale = 0.0F,
    .isSupportInitFuncCallPara = true,
    .rtsqVirtualAddr = {0ULL, 0ULL, 0ULL, 0ULL},
    .rtsqFsmStateAddrCalMethod = RtsqFsmStateAddrCalMethod::NOT_SUPPORT,
    .starsBaseAddrMethod = StarsBaseAddrMethod::NOT_SUPPORT,
    .rtSqEnableAddrCalMethod = RtSqEnableAddrCalMethod::RT_SQ_ENABLE_ADDR_CAL_BY_TRUE_SQID,
    .isSupportDvppAccelerator = false,
    .isSupportDevVA2PA = true,
    .cmoAddrInfoType = CmoAddrInfoType::CMO_ADDR_INFO_TYPE_DAFAULT,
    .memcpyAsyncTaskD2DQos = UINT32_MAX,
    .isMemcpyAsyncTaskSqeType = false,
    .sqeDepth = SQE_DEPTH,
    .cqeSize = RT_VIRTUAL_CQE_SIZE,
    .cqeDepth = CQE_DEPTH,
    .cqeWaitTimeout = RT_REPORT_STARS_TIMEOUT_TIME,
    .getRtsqPosition = UINT16_MAX,
    .creditStartValue = UINT16_MAX,
    .argsItemSize = MULTI_GRAPH_ARG_ENTRY_SIZE_OTH,
    .argInitCountSize = DEFAULT_INIT_CNT_OTH,
    .argsAllocatorSize = TINY_INIT_CNT,
    .superArgAllocatorSize = SUPER_ARG_AllOC_SIZE_8,
    .maxArgAllocatorSize = TINY_ARG_MAX_ENTRY_INIT_NUM,
    .handleAllocatorSize = HANDLE_ALLOCATOR_SIZE_16,
    .kernelInfoAllocatorSize = HANDLE_ALLOCATOR_SIZE_16,
    .isNeedlogErrorLevel = true,
    .overflowMode = false,
    .opExecuteTimeout = false,
    .omArchVersion = OMArchVersion::omArchVersion_DEFAULT,
    .checkArchVersionCompatibility = CheckArchVersionCompatibility::Arch_Version_Compat_DEFAULT,
    .dcacheLockMixType = DcacheLockMixType::DCACHE_LOCK_MIX_TYPE_FROM_DEFAULT,
    .kernelFuncType = KernelFuncType::Kernel_FUC_TYPE_OTHER_AICORE,
    .taskPoolSizeFromMacroValue = false,
    .taskPoolSize = 0U,
    .getTsMemTypeMethod = GetTsMemTypeMethod::GET_TS_MEM_TYPE_JUDGE_FROM_DRIVER,
    .enabledTSNum = ENABLED_TS_NUM_1,
    .deviceSatStatus = DeviceSatStatus::DEVICE_SAT_STATUS_OTHER,
    .ringBufferMemCopyCycleTimes = 1U,
    .tsOverflowHandling = TsOverflowHandling::TS_OVER_FLOW_HANDING_DEFAULT,
    .getCapabilityMethod = GetCapabilityMethod::GET_CAPABILITY_NOT_SUPPORT,
    .memcpyDescriptorSize = MEMCPY_DESC_SIZE_V1,
    .cmoDDRStructInfoSize = 0U,
    .streamWaitEventTimeout = StreamWaitEventTimeout::CUSTOM,
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

REGISTER_DEV_PROPERTIES(CHIP_ASCEND_031, CHIP_5612_PROPERTIES);
}
}
