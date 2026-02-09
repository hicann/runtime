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

static constexpr rtSocInfo_t SOC_INFO_KIRIN9030[] = {
    {SOC_KIRIN9030, CHIP_9030, ARCH_L311, "Kirin9030"}
};

BATCH_REGISTER_SOC_INFO(SOC_INFO_KIRIN9030, sizeof(SOC_INFO_KIRIN9030) / sizeof(rtSocInfo_t));

constexpr RtDevInfo DEV_INFO_KIRIN9030[] = {
    {CHIP_9030, ARCH_L311, PG_VER_BIN1, "Kirin9030"},
};

BATCH_REGISTER_DEV_INFO(DEV_INFO_KIRIN9030, sizeof(DEV_INFO_KIRIN9030) / sizeof(RtDevInfo));

REGISTER_PLATFORM_LIB_INFO(CHIP_9030, "libruntime_v100.so");

static const std::unordered_set<RtOptionalFeatureType> KIRIN9030_FEATURE{};
REGISTER_CHIP_FEATURE_SET(CHIP_9030, KIRIN9030_FEATURE);

constexpr uint32_t RT_KIRIN9030_AICORE_NUM = 1U;
constexpr uint32_t RT_KIRIN9030_AIVECTOR_NUM = 1U;
static constexpr uint32_t ASYNC_TASK_D2D_QOS = 6U;
constexpr uint32_t TS_FEATURE_MC2_RTS_SUPPORT_HCCL_PROP = 23;
static constexpr uint32_t RT_STARS_MAX_KERNEL_CREDIT_UINT32 = 254U; // STARS MAX KERNEL_CREDIT = 255.
static constexpr uint32_t RT_STARS_DEFAULT_KERNEL_CREDIT_UINT32 = 254U; // The STARS reference time is 1090921693.184 us.
static constexpr float64_t RT_STARS_TASK_KERNEL_CREDIT_SCALE_MIN = 0.001F;  // 0.001(us) = 1ns

static const DevProperties CHIP_KIRIN9030_PROPERTIES = {
    .engineType = "STARS",
    .isStars = true,
    .pthreadStackSize = 0U,
    .eventWaitTimeout = EventWaitTimeoutType::SET_OP_WAIT_TIMEOUT_CONFIG,
    .tsCount = 1U,
    .defaultTaskRatio = NORMAL_TASK_RATION,
    .sqTailOffset = STARS_SIMPLE_SQ_TAIL_OFFSET,
    .maxGroupId = MAX_GROUP_ID,
    .reduceOverflow = ReduceOverflowType::REDUCE_NO_OVERFLOW,
    .isSupportSetDeviceSatMode = true,
    .sdmaReduceKind = 0x7C00U,
    .starsResourceAddrCalculateMethod = StarsResourceAddrCalculateMethod::STARS_RESOURCE_ADDR_CALCULATE_BY_DEVICE_INFO,
    .eventBase = RT_STARS_BASE_ADDR + STARS_EVENT_BASE_ADDR,
    .starsBaseMethod = StarsBaseMethod::STARS_BASE_CALCULATE_STATIC,
    .fsmSelBase = RT_STARS_BASE_ADDR + STARS_SIMPLE_RTSQ_FSM_SEL_REG,
    .notifyBase = RT_STARS_BASE_ADDR + STARS_NOTIFY_BASE_ADDR,
    .starsNotifyTableSize = STARS_NOTIFY_NUM_OF_SINGLE_TABLE,
    .ipcNotifyNumMask = 0x1FFUL,
    .mc2FeatureFlag = TS_FEATURE_MC2_RTS_SUPPORT_HCCL_PROP,
    .stackPhyBase = RT_SCALAR_BUFFER_SIZE_32K_75,
    .maxCustomerStackSize = DEFAULT_CUSTOM_STACK_SIZE_MAX,
    .aicNum = RT_KIRIN9030_AICORE_NUM,
    .aivNum = RT_KIRIN9030_AIVECTOR_NUM,
    .ringbufSize = DEVICE_RINGBUFFER_SIZE,
    .hugeManagedFlag = SVM_HOST_AGENT,
    .memAllocPctraceFlag = MEM_SVM_HUGE,
    .memInfoType = RT_MEM_INFO_TYPE_HBM_SIZE,
    .taskPrefetchCount = PREFETCH_CNT_8,
    .maxAllocHugeStreamNum = DEFAULT,
    .resetMaxModelNum = NUM_RESET_WITH_DRIVER,
    .reduceAicNum = false,
    .timeoutUpdateMethod = TimeoutUpdateMethod::DEFAULT_METHOD,
    .hugePolicyFlag = DEFAULT,
    .memInfoMapType = DEFAULT,
    .resAllocRange = DEFAULT,
    .supportSnapshot = SupportSnapshot::SUPPORT,
    .MaxKernelCredit = RT_STARS_MAX_KERNEL_CREDIT_UINT32,
    .eventTimestampFreq = RT_DEFAULT_TIMESTAMP_FREQ,
    .taskEngineType = EngineCreateType::STARS_ENGINE,
    .CmoSqeVersion = SqeVersion::CMO_SQE_VERSION_V2,
    .DefaultKernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_UINT32,
    .starsDefaultKernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT,
    .KernelCreditScale = RT_STARS_TASK_KERNEL_CREDIT_SCALE_MIN,
    .isSupportInitFuncCallPara = true,
    .rtsqVirtualAddr = {RT_STARS_BASE_ADDR + STARS_SIMPLE_RTSQ_FSM_SEL_REG,
        STARS_SIMPLE_SQ_ENABLE_OFFSET,
        STARS_SIMPLE_SQ_TAIL_OFFSET,
        STARS_SIMPLE_SQ_HEAD_OFFSET},
    .rtsqFsmStateAddrCalMethod = RtsqFsmStateAddrCalMethod::FSM_ADDR_CALCULATE_BY_DEVICE_INFO,
    .starsBaseAddrMethod = StarsBaseAddrMethod::STARS_BASE_CALCULATE_STATIC,
    .rtSqEnableAddrCalMethod = RtSqEnableAddrCalMethod::RT_SQ_ENABLE_ADDR_CAL_STATIC,
    .isSupportDvppAccelerator = true,
    .isSupportDevVA2PA = false,
    .cmoAddrInfoType = CmoAddrInfoType::CMO_ADDR_INFO_TYPE_DAFAULT,
    .memcpyAsyncTaskD2DQos = ASYNC_TASK_D2D_QOS,
    .isMemcpyAsyncTaskSqeType = true,
    .sqeDepth = UINT32_MAX,
    .cqeSize = RT_VIRTUAL_CQE_SIZE,
    .cqeDepth = static_cast<uint32_t>(CqeDepth::CQE_DEPTH_DVPP_GRP),
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
    .overflowMode = true,
    .opExecuteTimeout = false,
    .omArchVersion = OMArchVersion::omArchVersion_DEFAULT,
    .checkArchVersionCompatibility = CheckArchVersionCompatibility::Arch_Version_Compat_DEFAULT,
    .dcacheLockMixType = DcacheLockMixType::DCACHE_LOCK_MIX_TYPE_FROM_DEFAULT,
    .kernelFuncType = KernelFuncType::Kernel_FUC_TYPE_SUPP_AICORE,
    .taskPoolSizeFromMacroValue = true,
    .taskPoolSize = 0U,
    .getTsMemTypeMethod = GetTsMemTypeMethod::GET_TS_MEM_TYPE_STATIC,
    .enabledTSNum = ENABLED_TS_NUM_1,
    .deviceSatStatus = DeviceSatStatus::DEVICE_SAT_STATUS_V2,
    .ringBufferMemCopyCycleTimes = 1U,
    .tsOverflowHandling = TsOverflowHandling::TS_OVER_FLOW_HANDING_DEFAULT,
    .getCapabilityMethod = GetCapabilityMethod::GET_CAPABILITY_BY_BOTH_FEATURE_AND_DRIVER_CHECK,
    .memcpyDescriptorSize = MEMCPY_DESC_SIZE_V1,
    .cmoDDRStructInfoSize = sizeof(rtCmoAddrInfo),
    .streamWaitEventTimeout = StreamWaitEventTimeout::CUSTOM,
    .timelineEventId = TIMELINE_EVENT_ID_DEFAULT,
    .deviceSatStatusImpl = 2U,
    .allocManagedFlag = AllocManagedFlag::ALLOC_MANAGED_MEM_NORMAL,
    .sdmaCopyMethod = SdmaCopyMethod::SDMA_COPY_BY_MEM_SYNC_ADAPTER,
    .eventPoolSize = 0U,
    .rtsqShamt = 0x1FFU,
    .supportCreateTaskRes = SupportCreateTaskRes::CREATE_TASK_RES_NOT_SUPPORT,
    .aicNumForCoreStack = RT_AICORE_NUM_25,
    .engineWaitCompletionTImeout = 0UL,
    .reportWaitTimeout = RT_REPORT_TIMEOUT_TIME
};

REGISTER_DEV_PROPERTIES(CHIP_9030, CHIP_KIRIN9030_PROPERTIES);
} // namespace runtime
} // namespace cce
