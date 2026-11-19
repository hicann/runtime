/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "common/api_enum_log.hpp"
#include "runtime/event.h"
#include <cstdio>
#include <cinttypes>
#include <type_traits>
#include "gtest/gtest.h"
#include "runtime/rt_external_device.h"
#include "runtime/rt_external_mem.h"
#include "runtime/rt_external_model.h"
#include "runtime/rt_external_preload.h"
#include "runtime/base.h"
#include "runtime/config.h"
#include "runtime/dev.h"
#include "runtime/mem.h"
#include "runtime/mem_base.h"
#include "args/args_inner.h"
#include "common/internal_error_define.hpp"
#include "device.hpp"
#include "kernel/kernel.hpp"
#include "runtime.hpp"
#include "stream.hpp"
#include "cond_handle/cond_enum_desc.hpp"
#include "device/device_enum_desc.hpp"
#include "jetty_pool.h"
#include "notify/notify_enum_desc.hpp"
#include "printf.hpp"
#include "stream_mem_pool.hpp"

using namespace cce::runtime;

#if RUNTIME_ENABLE_ENUM_LOG_NAMES
TEST(EnumLogNamesTest, UtilizationNamesIncludeUnknownSentinel)
{
    EXPECT_EQ(std::string(RtTypeUtilToString(RT_UTIL_TYPE_AICORE)), "UTIL_TYPE_AICORE");
    EXPECT_EQ(std::string(RtTypeUtilToString(RT_UTIL_TYPE_AIVECTOR)), "UTIL_TYPE_AIVECTOR");
    EXPECT_EQ(std::string(RtTypeUtilToString(RT_UTIL_TYPE_AICPU)), "UTIL_TYPE_AICPU");
    // This unfixed enum represents 0..3; do not cast wider integers into it.
    EXPECT_EQ(std::string(RtTypeUtilToString(RT_UTIL_TYPE_MAX)), "UNKNOWN");
}

TEST(EnumLogNamesTest, HdcNamesPreserveExactEntriesUserIntervalAndHoles)
{
    struct ServiceCase {
        rtHdcServiceType_t value;
        const char* name;
    };
    const ServiceCase cases[] = {
        {RT_HDC_SERVICE_TYPE_DMP, "HDC_SERVICE_TYPE_DMP"},
        {RT_HDC_SERVICE_TYPE_PROFILING, "HDC_SERVICE_TYPE_PROFILING"},
        {RT_HDC_SERVICE_TYPE_IDE1, "HDC_SERVICE_TYPE_IDE1"},
        {RT_HDC_SERVICE_TYPE_FILE_TRANS, "HDC_SERVICE_TYPE_FILE_TRANS"},
        {RT_HDC_SERVICE_TYPE_IDE2, "HDC_SERVICE_TYPE_IDE2"},
        {RT_HDC_SERVICE_TYPE_LOG, "HDC_SERVICE_TYPE_LOG"},
        {RT_HDC_SERVICE_TYPE_RDMA, "HDC_SERVICE_TYPE_RDMA"},
        {RT_HDC_SERVICE_TYPE_BBOX, "HDC_SERVICE_TYPE_BBOX"},
        {RT_HDC_SERVICE_TYPE_FRAMEWORK, "HDC_SERVICE_TYPE_FRAMEWORK"},
        {RT_HDC_SERVICE_TYPE_TSD, "HDC_SERVICE_TYPE_TSD"},
        {RT_HDC_SERVICE_TYPE_TDT, "HDC_SERVICE_TYPE_TDT"},
        {RT_HDC_SERVICE_TYPE_PROF, "HDC_SERVICE_TYPE_PROF"},
        {RT_HDC_SERVICE_TYPE_IDE_FILE_TRANS, "HDC_SERVICE_TYPE_IDE_FILE_TRANS"},
        {RT_HDC_SERVICE_TYPE_DUMP, "HDC_SERVICE_TYPE_DUMP"},
        {RT_HDC_SERVICE_TYPE_USER3, "HDC_SERVICE_TYPE_USER3"},
        {RT_HDC_SERVICE_TYPE_DVPP, "HDC_SERVICE_TYPE_DVPP"},
        {RT_HDC_SERVICE_TYPE_QUEUE, "HDC_SERVICE_TYPE_QUEUE"},
        {RT_HDC_SERVICE_TYPE_UPGRADE, "HDC_SERVICE_TYPE_UPGRADE"},
        {RT_HDC_SERVICE_TYPE_RDMA_V2, "HDC_SERVICE_TYPE_RDMA_V2"},
        {RT_HDC_SERVICE_TYPE_TEST, "HDC_SERVICE_TYPE_TEST"},
        {RT_HDC_SERVICE_TYPE_USER_START, "HDC_SERVICE_TYPE_USER_START"},
        {static_cast<rtHdcServiceType_t>(65), "HDC_SERVICE_TYPE_USER"},
        {static_cast<rtHdcServiceType_t>(96), "HDC_SERVICE_TYPE_USER"},
        {static_cast<rtHdcServiceType_t>(126), "HDC_SERVICE_TYPE_USER"},
        {RT_HDC_SERVICE_TYPE_USER_END, "HDC_SERVICE_TYPE_USER_END"},
        {static_cast<rtHdcServiceType_t>(20), "UNKNOWN"},
        {static_cast<rtHdcServiceType_t>(63), "UNKNOWN"},
        {RT_HDC_SERVICE_TYPE_MAX, "UNKNOWN"},
        {static_cast<rtHdcServiceType_t>(255), "UNKNOWN"},
    };
    // All inputs fit the unfixed enum's representable 0..255 range.
    for (const auto& item : cases) {
        SCOPED_TRACE(static_cast<int32_t>(item.value));
        EXPECT_EQ(std::string(RtHdcServiceTypeToString(item.value)), std::string(item.name));
    }
}
TEST(EnumLogNamesTest, ModelQueueFlagsKeepInputOutputDomain)
{
    EXPECT_EQ(std::string(RtModelQueueFlagToString(RT_MODEL_INPUT_QUEUE)), "MODEL_INPUT_QUEUE");
    EXPECT_EQ(std::string(RtModelQueueFlagToString(RT_MODEL_OUTPUT_QUEUE)), "MODEL_OUTPUT_QUEUE");
    // This unfixed enum only represents 0..1; do not cast an out-of-range integer into it.
}

TEST(EnumLogNamesTest, PreloadTaskTypesKeepTheirOwnSentinel)
{
    EXPECT_EQ(std::string(RtTaskTypeToString(RT_TASK_TYPE_KERNEL_AICORE)), "TASK_TYPE_KERNEL_AICORE");
    EXPECT_EQ(std::string(RtTaskTypeToString(RT_TASK_TYPE_KERNEL_AICPU)), "TASK_TYPE_KERNEL_AICPU");
    EXPECT_EQ(std::string(RtTaskTypeToString(RT_TASK_TYPE_KERNEL_NANO_AICORE)), "TASK_TYPE_KERNEL_NANO_AICORE");
    EXPECT_EQ(
        std::string(RtTaskTypeToString(RT_TASK_TYPE_KERNEL_NANO_AICPU_HOSTFUNC)),
        "TASK_TYPE_KERNEL_NANO_AICPU_HOSTFUNC");
    EXPECT_EQ(std::string(RtTaskTypeToString(RT_TASK_TYPE_MAX)), "UNKNOWN");
}

TEST(EnumLogNamesTest, PointerLocationSentinelIsNotALocation)
{
    EXPECT_EQ(std::string(RtMemLocationTypeToString(RT_MEMORY_LOC_HOST)), "MEMORY_LOC_HOST");
    EXPECT_EQ(std::string(RtMemLocationTypeToString(RT_MEMORY_LOC_DEVICE)), "MEMORY_LOC_DEVICE");
    EXPECT_EQ(std::string(RtMemLocationTypeToString(RT_MEMORY_LOC_UNREGISTERED)), "MEMORY_LOC_UNREGISTERED");
    EXPECT_EQ(std::string(RtMemLocationTypeToString(RT_MEMORY_LOC_MANAGED)), "MEMORY_LOC_MANAGED");
    EXPECT_EQ(std::string(RtMemLocationTypeToString(RT_MEMORY_LOC_HOST_NUMA)), "MEMORY_LOC_HOST_NUMA");
    EXPECT_EQ(std::string(RtMemLocationTypeToString(RT_MEMORY_LOC_MAX)), "UNKNOWN");
}

TEST(EnumLogNamesTest, PointerMemoryUserTypeIsDefined)
{
    EXPECT_EQ(std::string(RtMemoryTypeToString(RT_MEMORY_TYPE_HOST)), "MEMORY_TYPE_HOST");
    EXPECT_EQ(std::string(RtMemoryTypeToString(RT_MEMORY_TYPE_DEVICE)), "MEMORY_TYPE_DEVICE");
    EXPECT_EQ(std::string(RtMemoryTypeToString(RT_MEMORY_TYPE_SVM)), "MEMORY_TYPE_SVM");
    EXPECT_EQ(std::string(RtMemoryTypeToString(RT_MEMORY_TYPE_DVPP)), "MEMORY_TYPE_DVPP");
    EXPECT_EQ(std::string(RtMemoryTypeToString(RT_MEMORY_TYPE_USER)), "MEMORY_TYPE_USER");
    EXPECT_EQ(std::string(RtMemoryTypeToString(static_cast<rtMemoryType_t>(6))), "UNKNOWN");
}

TEST(EnumLogNamesTest, CapabilityCarrierUsesCompleteDefinedDomain)
{
    EXPECT_EQ(std::string(RtDeviceCapabilityTypeToString(RT_SCHEDULE_SOFTWARE)), "SCHEDULE_SOFTWARE");
    EXPECT_EQ(std::string(RtDeviceCapabilityTypeToString(RT_SCHEDULE_SOFTWARE_OPT)), "SCHEDULE_SOFTWARE_OPT");
    EXPECT_EQ(std::string(RtDeviceCapabilityTypeToString(RT_SCHEDULE_HARDWARE)), "SCHEDULE_HARDWARE");
    EXPECT_EQ(
        std::string(RtDeviceCapabilityTypeToString(RT_AICPU_BLOCKING_OP_NOT_SUPPORT)), "AICPU_BLOCKING_OP_NOT_SUPPORT");
    EXPECT_EQ(std::string(RtDeviceCapabilityTypeToString(RT_AICPU_BLOCKING_OP_SUPPORT)), "AICPU_BLOCKING_OP_SUPPORT");
    EXPECT_EQ(std::string(RtDeviceCapabilityTypeToString(RT_MODE_NO_FFTS)), "MODE_NO_FFTS");
    EXPECT_EQ(std::string(RtDeviceCapabilityTypeToString(RT_MODE_FFTS)), "MODE_FFTS");
    EXPECT_EQ(std::string(RtDeviceCapabilityTypeToString(RT_MODE_FFTS_PLUS)), "MODE_FFTS_PLUS");
    EXPECT_EQ(std::string(RtDeviceCapabilityTypeToString(RT_DEV_CAP_SUPPORT)), "DEV_CAP_SUPPORT");
    EXPECT_EQ(std::string(RtDeviceCapabilityTypeToString(RT_DEV_CAP_NOT_SUPPORT)), "DEV_CAP_NOT_SUPPORT");
    EXPECT_EQ(std::string(RtDeviceCapabilityTypeToString(static_cast<rtDeviceCapabilityType>(10))), "UNKNOWN");
}

TEST(EnumLogNamesTest, QueueQuerySentinelIsNotACommand)
{
    EXPECT_EQ(
        std::string(RtMemQueueQueryCmdToString(RT_MQ_QUERY_QUE_ATTR_OF_CUR_PROC)), "MQ_QUERY_QUE_ATTR_OF_CUR_PROC");
    EXPECT_EQ(std::string(RtMemQueueQueryCmdToString(RT_MQ_QUERY_QUES_OF_CUR_PROC)), "MQ_QUERY_QUES_OF_CUR_PROC");
    EXPECT_EQ(
        std::string(RtMemQueueQueryCmdToString(RT_MQ_QUERY_QUES_ATTR_ENTITY_TYPE)), "MQ_QUERY_QUES_ATTR_ENTITY_TYPE");
    EXPECT_EQ(std::string(RtMemQueueQueryCmdToString(RT_MQ_QUERY_CMD_MAX)), "UNKNOWN");
}

TEST(EnumLogNamesTest, BufferGetSentinelIsNotACommand)
{
    EXPECT_EQ(std::string(RtBuffGetCmdTypeToString(RT_BUFF_GET_MBUF_TIMEOUT_INFO)), "BUFF_GET_MBUF_TIMEOUT_INFO");
    EXPECT_EQ(std::string(RtBuffGetCmdTypeToString(RT_BUFF_GET_MBUF_USE_INFO)), "BUFF_GET_MBUF_USE_INFO");
    EXPECT_EQ(std::string(RtBuffGetCmdTypeToString(RT_BUFF_GET_MBUF_TYPE_INFO)), "BUFF_GET_MBUF_TYPE_INFO");
    EXPECT_EQ(std::string(RtBuffGetCmdTypeToString(RT_BUFF_GET_MBUF_BUILD_INFO)), "BUFF_GET_MBUF_BUILD_INFO");
    EXPECT_EQ(std::string(RtBuffGetCmdTypeToString(RT_BUFF_GET_MAX)), "UNKNOWN");
}

TEST(EnumLogNamesTest, TaskBufferDomainKeepsItsOwnSentinel)
{
    EXPECT_EQ(std::string(RtTaskBuffTypeToString(HWTS_STATIC_TASK_DESC)), "HWTS_STATIC_TASK_DESC");
    EXPECT_EQ(std::string(RtTaskBuffTypeToString(HWTS_DYNAMIC_TASK_DESC)), "HWTS_DYNAMIC_TASK_DESC");
    EXPECT_EQ(std::string(RtTaskBuffTypeToString(PARAM_TASK_INFO_DESC)), "PARAM_TASK_INFO_DESC");
    EXPECT_EQ(std::string(RtTaskBuffTypeToString(MAX_TASK)), "UNKNOWN");
}

TEST(EnumLogNamesTest, DeviceFaultNoErrorIsDefined)
{
    EXPECT_EQ(std::string(DeviceFaultTypeToString(DeviceFaultType::L2_BUFFER_ERROR)), "L2_BUFFER_ERROR");
    EXPECT_EQ(std::string(DeviceFaultTypeToString(DeviceFaultType::HBM_UCE_ERROR)), "HBM_UCE_ERROR");
    EXPECT_EQ(std::string(DeviceFaultTypeToString(DeviceFaultType::AICORE_SW_ERROR)), "AICORE_SW_ERROR");
    EXPECT_EQ(std::string(DeviceFaultTypeToString(DeviceFaultType::AICORE_HW_L_ERROR)), "AICORE_HW_L_ERROR");
    EXPECT_EQ(std::string(DeviceFaultTypeToString(DeviceFaultType::AICORE_UNKNOWN_ERROR)), "AICORE_UNKNOWN_ERROR");
    EXPECT_EQ(std::string(DeviceFaultTypeToString(DeviceFaultType::LINK_ERROR)), "LINK_ERROR");
    EXPECT_EQ(std::string(DeviceFaultTypeToString(DeviceFaultType::L3_PORT_ERROR)), "L3_PORT_ERROR");
    EXPECT_EQ(std::string(DeviceFaultTypeToString(DeviceFaultType::NO_ERROR)), "NO_ERROR");
    EXPECT_EQ(std::string(DeviceFaultTypeToString(static_cast<DeviceFaultType>(UINT8_MAX))), "UNKNOWN");
}

TEST(EnumLogNamesTest, MallocAdviceDomainIsSeparateFromAllocationMasks)
{
    EXPECT_EQ(std::string(RtMallocAdviseToString(RT_MEM_ADVISE_NONE)), "MEM_ADVISE_NONE");
    EXPECT_EQ(std::string(RtMallocAdviseToString(RT_MEM_ADVISE_DVPP)), "MEM_ADVISE_DVPP");
    EXPECT_EQ(std::string(RtMallocAdviseToString(RT_MEM_ADVISE_TS)), "MEM_ADVISE_TS");
    EXPECT_EQ(std::string(RtMallocAdviseToString(RT_MEM_ADVISE_CACHED)), "MEM_ADVISE_CACHED");
    // This unfixed enum only represents 0..3; no wider integer is cast into it.
}

TEST(EnumLogNamesTest, DeviceMessageReserveIsNotExecutable)
{
    EXPECT_EQ(std::string(RtGetDevMsgTypeToString(RT_GET_DEV_ERROR_MSG)), "GET_DEV_ERROR_MSG");
    EXPECT_EQ(
        std::string(RtGetDevMsgTypeToString(RT_GET_DEV_RUNNING_STREAM_SNAPSHOT_MSG)),
        "GET_DEV_RUNNING_STREAM_SNAPSHOT_MSG");
    EXPECT_EQ(std::string(RtGetDevMsgTypeToString(RT_GET_DEV_PID_SNAPSHOT_MSG)), "GET_DEV_PID_SNAPSHOT_MSG");
    EXPECT_EQ(std::string(RtGetDevMsgTypeToString(RT_GET_DEV_MSG_RESERVE)), "UNKNOWN");
}

TEST(EnumLogNamesTest, KernelRegistrationUnknownKeepsSignedDomain)
{
    EXPECT_EQ(std::string(KernelRegisterTypeToString(static_cast<KernelRegisterType>(-1))), "UNKNOWN");
    EXPECT_EQ(std::string(KernelRegisterTypeToString(static_cast<KernelRegisterType>(INT32_MAX))), "UNKNOWN");
}

TEST(EnumLogNamesTest, ArgumentSentinelAndUnsignedUnknownHaveNoName)
{
    const ArgsType sentinel = static_cast<ArgsType>(7);
    EXPECT_STREQ(ArgsTypeToString(sentinel), "UNKNOWN");
    const ArgsType unknown = static_cast<ArgsType>(-1);
    char buffer[96] = {};
    std::snprintf(
        buffer, sizeof(buffer), "args=%s(%u), next=%d", ArgsTypeToString(unknown), static_cast<uint32_t>(unknown), -7);
    EXPECT_STREQ(buffer, "args=UNKNOWN(4294967295), next=-7");
}

TEST(EnumLogNamesTest, SubscribeUnknownDoesNotAliasDefinedFlags)
{
    EXPECT_EQ(std::string(StreamSubscribeFlagToString(static_cast<StreamSubscribeFlag>(3))), "UNKNOWN");
    EXPECT_EQ(std::string(StreamSubscribeFlagToString(static_cast<StreamSubscribeFlag>(UINT8_MAX))), "UNKNOWN");
}

TEST(EnumLogNamesTest, TimeoutUnknownKeepsFullWidth)
{
    EXPECT_EQ(std::string(RtTaskTimeUnitTypeToString(static_cast<RtTaskTimeUnitType>(UINT16_MAX))), "UNKNOWN");
}

TEST(EnumLogNamesTest, MixNamesKeepRepresentableUnknownValues)
{
    // Fixed uint8_t inputs include the unnamed values 5..255.
    EXPECT_EQ(std::string(RtMixTypeToString(static_cast<RtMixType>(5))), "UNKNOWN");
    EXPECT_EQ(std::string(RtMixTypeToString(static_cast<RtMixType>(UINT8_MAX))), "UNKNOWN");
}

TEST(EnumLogNamesTest, FeatureNamesKeepDefinedValuesAndUnknownSentinel)
{
    EXPECT_STREQ(RtFeatureToString(RT_FEATURE_STARS_COMPATIBILITY), "FEATURE_STARS_COMPATIBILITY");
    EXPECT_STREQ(RtFeatureToString(RT_FEATURE_IPC_NOTICE_DC), "FEATURE_IPC_NOTICE_DC");
    EXPECT_STREQ(RtFeatureToString(RT_FEATURE_FFTSPLUS_TASKID_SAME_FIX), "FEATURE_FFTSPLUS_TASKID_SAME_FIX");
    EXPECT_STREQ(RtFeatureToString(RT_FEATURE_OVER_FLOW_DEBUG), "FEATURE_OVER_FLOW_DEBUG");
    EXPECT_STREQ(RtFeatureToString(RT_FEATURE_D2D_ADDR_ASYNC), "FEATURE_D2D_ADDR_ASYNC");
    EXPECT_STREQ(RtFeatureToString(RT_FEATURE_FLIPTASK), "FEATURE_FLIPTASK");
    EXPECT_STREQ(RtFeatureToString(RT_FEATURE_FFTSPLUS_TIMEOUT), "FEATURE_FFTSPLUS_TIMEOUT");
    EXPECT_STREQ(RtFeatureToString(RT_FEATURE_MC2_RTS_SUPPORT_HCCL), "FEATURE_MC2_RTS_SUPPORT_HCCL");
    EXPECT_STREQ(RtFeatureToString(RT_FEATURE_IPC_NOTICE_CLOUD_V2), "FEATURE_IPC_NOTICE_CLOUD_V2");
    EXPECT_STREQ(RtFeatureToString(RT_FEATURE_MC2_RTS_SUPPORT_HCCL_DC), "FEATURE_MC2_RTS_SUPPORT_HCCL_DC");
    EXPECT_STREQ(RtFeatureToString(RT_FEATURE_SUPPORT_REDUCEASYNC_V2_DC), "FEATURE_SUPPORT_REDUCEASYNC_V2_DC");
    EXPECT_STREQ(RtFeatureToString(RT_FEATURE_TILING_KEY_SINK), "FEATURE_TILING_KEY_SINK");
    EXPECT_STREQ(RtFeatureToString(RT_FEATURE_MC2_ENHANCE), "FEATURE_MC2_ENHANCE");
    EXPECT_STREQ(RtFeatureToString(RT_FEATURE_FFTSPLUS_TASKID_SAME_FOR_ALL), "FEATURE_FFTSPLUS_TASKID_SAME_FOR_ALL");
    EXPECT_STREQ(RtFeatureToString(RT_FEATURE_TASK_ABORT), "FEATURE_TASK_ABORT");
    EXPECT_STREQ(RtFeatureToString(RT_FEATURE_MAX), "UNKNOWN");
}

TEST(EnumLogNamesTest, H2DCopyPolicyNamesKeepUnknownSentinel)
{
    EXPECT_STREQ(H2DCopyPolicyToString(COPY_POLICY_DEFAULT), "COPY_POLICY_DEFAULT");
    EXPECT_STREQ(H2DCopyPolicyToString(COPY_POLICY_PCIE_BAR), "COPY_POLICY_PCIE_BAR");
    EXPECT_STREQ(H2DCopyPolicyToString(COPY_POLICY_ASYNC_PCIE_DMA), "COPY_POLICY_ASYNC_PCIE_DMA");
    EXPECT_STREQ(H2DCopyPolicyToString(COPY_POLICY_SYNC), "COPY_POLICY_SYNC");
    EXPECT_STREQ(H2DCopyPolicyToString(COPY_POLICY_UB), "COPY_POLICY_UB");
    EXPECT_STREQ(H2DCopyPolicyToString(COPY_POLICY_MAX), "UNKNOWN");
}

TEST(EnumLogNamesTest, KernelFunctionEntryNamesKeepSignedUnknowns)
{
    EXPECT_STREQ(
        KernelFunctionEntryTypeToString(KernelFunctionEntryType::KERNEL_TYPE_TILING_KEY), "KERNEL_TYPE_TILING_KEY");
    EXPECT_STREQ(
        KernelFunctionEntryTypeToString(KernelFunctionEntryType::KERNEL_TYPE_FUNCTION_ENTRY),
        "KERNEL_TYPE_FUNCTION_ENTRY");
    EXPECT_STREQ(
        KernelFunctionEntryTypeToString(KernelFunctionEntryType::KERNEL_TYPE_NOT_SUPPORT_FUNCTION_ENTRY),
        "KERNEL_TYPE_NOT_SUPPORT_FUNCTION_ENTRY");
    EXPECT_STREQ(KernelFunctionEntryTypeToString(static_cast<KernelFunctionEntryType>(INT32_MIN)), "UNKNOWN");
    EXPECT_STREQ(KernelFunctionEntryTypeToString(static_cast<KernelFunctionEntryType>(INT32_MAX)), "UNKNOWN");
}

TEST(EnumLogNamesTest, KernelRatioNamesKeepSentinelAndUnnamedValue)
{
    EXPECT_STREQ(RatioToString(RATION_TYPE_ONE_RATIO_TWO), "RATION_TYPE_ONE_RATIO_TWO");
    EXPECT_STREQ(RatioToString(RATION_TYPE_TWO_RATIO_ONE), "RATION_TYPE_TWO_RATIO_ONE");
    EXPECT_STREQ(RatioToString(RATION_TYPE_ONE_RATIO_ONE), "RATION_TYPE_ONE_RATIO_ONE");
    EXPECT_STREQ(RatioToString(RATION_TYPE_ONE_RATIO_ZERO), "RATION_TYPE_ONE_RATIO_ZERO");
    EXPECT_STREQ(RatioToString(RATION_TYPE_ZERO_RATIO_ONE), "RATION_TYPE_ZERO_RATIO_ONE");
    EXPECT_STREQ(RatioToString(RATION_TYPE_MAX), "UNKNOWN");
    EXPECT_STREQ(RatioToString(static_cast<Ratio>(6)), "UNKNOWN");
}

TEST(EnumLogNamesTest, ModelExecutorNamesKeepReservedValueAndHoles)
{
    EXPECT_STREQ(RtModelExecutorFlagToString(MODEL_EXECUTOR_TS), "MODEL_EXECUTOR_TS");
    EXPECT_STREQ(RtModelExecutorFlagToString(MODEL_EXECUTOR_AICPU), "MODEL_EXECUTOR_AICPU");
    EXPECT_STREQ(RtModelExecutorFlagToString(MODEL_EXECUTOR_RESERVED), "MODEL_EXECUTOR_RESERVED");
    EXPECT_STREQ(RtModelExecutorFlagToString(MODEL_EXECUTOR_CAPTURE), "MODEL_EXECUTOR_CAPTURE");
    EXPECT_STREQ(RtModelExecutorFlagToString(static_cast<RtModelExecutorFlag>(0)), "UNKNOWN");
    EXPECT_STREQ(RtModelExecutorFlagToString(static_cast<RtModelExecutorFlag>(4)), "UNKNOWN");
    EXPECT_STREQ(RtModelExecutorFlagToString(static_cast<RtModelExecutorFlag>(7)), "UNKNOWN");
}

TEST(EnumLogNamesTest, ModelMaintenanceNamesKeepUnknownSentinel)
{
    EXPECT_STREQ(MmtTypeToString(MMT_STREAM_ADD), "MMT_STREAM_ADD");
    EXPECT_STREQ(MmtTypeToString(MMT_STREAM_DEL), "MMT_STREAM_DEL");
    EXPECT_STREQ(MmtTypeToString(MMT_MODEL_LOAD_COMPLETE), "MMT_MODEL_LOAD_COMPLETE");
    EXPECT_STREQ(MmtTypeToString(MMT_MODEL_DESTROY), "MMT_MODEL_DESTROY");
    EXPECT_STREQ(MmtTypeToString(MMT_MODEL_PRE_PROC), "MMT_MODEL_PRE_PROC");
    EXPECT_STREQ(MmtTypeToString(MMT_STREAM_LOAD_COMPLETE), "MMT_STREAM_LOAD_COMPLETE");
    EXPECT_STREQ(MmtTypeToString(MMT_MODEL_ABORT), "MMT_MODEL_ABORT");
    EXPECT_STREQ(MmtTypeToString(MMT_RESERVED), "UNKNOWN");
    // The unfixed enum's complete 0..7 range is covered above.
}

TEST(EnumLogNamesTest, PrintDumpNamesKeepWideMarkersAndUnsignedUnknown)
{
    EXPECT_STREQ(DumpTypeToString(DumpType::DUMP_DEFAULT), "DUMP_DEFAULT");
    EXPECT_STREQ(DumpTypeToString(DumpType::DUMP_SCALAR), "DUMP_SCALAR");
    EXPECT_STREQ(DumpTypeToString(DumpType::DUMP_TENSOR), "DUMP_TENSOR");
    EXPECT_STREQ(DumpTypeToString(DumpType::DUMP_SHAPE), "DUMP_SHAPE");
    EXPECT_STREQ(DumpTypeToString(DumpType::DUMP_ASSERT), "DUMP_ASSERT");
    EXPECT_STREQ(DumpTypeToString(DumpType::DUMP_META), "DUMP_META");
    EXPECT_STREQ(DumpTypeToString(DumpType::DUMP_TIMESTAMP), "DUMP_TIMESTAMP");
    EXPECT_STREQ(DumpTypeToString(DumpType::DUMP_SIMT), "DUMP_SIMT");
    EXPECT_STREQ(DumpTypeToString(DumpType::DUMP_BUFI), "DUMP_BUFI");
    EXPECT_STREQ(DumpTypeToString(DumpType::DUMP_BUFO), "DUMP_BUFO");
    EXPECT_STREQ(DumpTypeToString(DumpType::DUMP_SKIP), "DUMP_SKIP");
    EXPECT_STREQ(DumpTypeToString(DumpType::DUMP_AICPU), "DUMP_AICPU");
    EXPECT_STREQ(DumpTypeToString(DumpType::DUMP_SIMT_ASSERT), "DUMP_SIMT_ASSERT");
    EXPECT_STREQ(DumpTypeToString(DumpType::DUMP_SIMT_PRINTF), "DUMP_SIMT_PRINTF");
    EXPECT_STREQ(DumpTypeToString(DumpType::DUMP_WAIT), "DUMP_WAIT");
    EXPECT_STREQ(DumpTypeToString(static_cast<DumpType>(UINT32_MAX)), "UNKNOWN");
}

TEST(EnumLogNamesTest, QosMasterNamesKeepInvalidSentinelAndUnsignedUnknown)
{
    EXPECT_STREQ(QosMasterTypeToString(QosMasterType::MASTER_DVPP_ALL), "MASTER_DVPP_ALL");
    EXPECT_STREQ(QosMasterTypeToString(QosMasterType::MASTER_DVPP_VPC), "MASTER_DVPP_VPC");
    EXPECT_STREQ(QosMasterTypeToString(QosMasterType::MASTER_DVPP_VDEC), "MASTER_DVPP_VDEC");
    EXPECT_STREQ(QosMasterTypeToString(QosMasterType::MASTER_DVPP_JPEGE), "MASTER_DVPP_JPEGE");
    EXPECT_STREQ(QosMasterTypeToString(QosMasterType::MASTER_DVPP_JPEGD), "MASTER_DVPP_JPEGD");
    EXPECT_STREQ(QosMasterTypeToString(QosMasterType::MASTER_ROCE), "MASTER_ROCE");
    EXPECT_STREQ(QosMasterTypeToString(QosMasterType::MASTER_NIC), "MASTER_NIC");
    EXPECT_STREQ(QosMasterTypeToString(QosMasterType::MASTER_PCIE), "MASTER_PCIE");
    EXPECT_STREQ(QosMasterTypeToString(QosMasterType::MASTER_AICPU), "MASTER_AICPU");
    EXPECT_STREQ(QosMasterTypeToString(QosMasterType::MASTER_AIC_DAT), "MASTER_AIC_DAT");
    EXPECT_STREQ(QosMasterTypeToString(QosMasterType::MASTER_AIC_INS), "MASTER_AIC_INS");
    EXPECT_STREQ(QosMasterTypeToString(QosMasterType::MASTER_AIV_DAT), "MASTER_AIV_DAT");
    EXPECT_STREQ(QosMasterTypeToString(QosMasterType::MASTER_AIV_INS), "MASTER_AIV_INS");
    EXPECT_STREQ(QosMasterTypeToString(QosMasterType::MASTER_SDMA), "MASTER_SDMA");
    EXPECT_STREQ(QosMasterTypeToString(QosMasterType::MASTER_STARS), "MASTER_STARS");
    EXPECT_STREQ(QosMasterTypeToString(QosMasterType::MASTER_INVALID), "UNKNOWN");
    EXPECT_STREQ(QosMasterTypeToString(static_cast<QosMasterType>(UINT32_MAX)), "UNKNOWN");
}

TEST(EnumLogNamesTest, ReuseFlagNamesKeepInvalidSentinelAndSignedUnknowns)
{
    EXPECT_STREQ(ReuseFlagToString(ReuseFlag::REUSE_FLAG_STANDARD), "REUSE_FLAG_STANDARD");
    EXPECT_STREQ(ReuseFlagToString(ReuseFlag::REUSE_FLAG_INTERNAL), "REUSE_FLAG_INTERNAL");
    EXPECT_STREQ(ReuseFlagToString(ReuseFlag::REUSE_FLAG_NONE), "REUSE_FLAG_NONE");
    EXPECT_STREQ(ReuseFlagToString(ReuseFlag::REUSE_FLAG_INVALID), "UNKNOWN");
    EXPECT_STREQ(ReuseFlagToString(static_cast<ReuseFlag>(INT32_MIN)), "UNKNOWN");
    EXPECT_STREQ(ReuseFlagToString(static_cast<ReuseFlag>(INT32_MAX)), "UNKNOWN");
}

TEST(EnumLogNamesTest, StreamStateCallbackNamesKeepSentinelAndUnsignedUnknown)
{
    EXPECT_STREQ(StreamStateCallbackToString(StreamStateCallback::RT_STREAM_STATE_CALLBACK), "STREAM_STATE_CALLBACK");
    EXPECT_STREQ(
        StreamStateCallbackToString(StreamStateCallback::RTS_STREAM_STATE_CALLBACK), "RTS_STREAM_STATE_CALLBACK");
    EXPECT_STREQ(StreamStateCallbackToString(StreamStateCallback::STREAM_CALLBACK_TYPE_MAX), "UNKNOWN");
    EXPECT_STREQ(StreamStateCallbackToString(static_cast<StreamStateCallback>(UINT8_MAX)), "UNKNOWN");
}

TEST(EnumLogNamesTest, DeviceStateCallbackNamesKeepSentinelAndUnsignedUnknown)
{
    EXPECT_STREQ(
        DeviceStateCallbackLogToString(DeviceStateCallback::RT_DEVICE_STATE_CALLBACK), "DEVICE_STATE_CALLBACK");
    EXPECT_STREQ(
        DeviceStateCallbackLogToString(DeviceStateCallback::RTS_DEVICE_STATE_CALLBACK), "RTS_DEVICE_STATE_CALLBACK");
    EXPECT_STREQ(DeviceStateCallbackLogToString(DeviceStateCallback::DEVICE_CALLBACK_TYPE_MAX), "UNKNOWN");
    EXPECT_STREQ(DeviceStateCallbackLogToString(static_cast<DeviceStateCallback>(UINT8_MAX)), "UNKNOWN");
}

TEST(EnumLogNamesTest, NotifyWaitModeNamesKeepSentinelAndUnnamedValue)
{
    EXPECT_STREQ(RtCntNotifyWaitModeToString(WAIT_LESS_MODE), "WAIT_LESS_MODE");
    EXPECT_STREQ(RtCntNotifyWaitModeToString(WAIT_EQUAL_MODE), "WAIT_EQUAL_MODE");
    EXPECT_STREQ(RtCntNotifyWaitModeToString(WAIT_BIGGER_MODE), "WAIT_BIGGER_MODE");
    EXPECT_STREQ(RtCntNotifyWaitModeToString(WAIT_BIGGER_OR_EQUAL_MODE), "WAIT_BIGGER_OR_EQUAL_MODE");
    EXPECT_STREQ(RtCntNotifyWaitModeToString(WAIT_BITMAP_MODE), "WAIT_BITMAP_MODE");
    EXPECT_STREQ(RtCntNotifyWaitModeToString(WAIT_MODE_MAX), "UNKNOWN");
    EXPECT_STREQ(RtCntNotifyWaitModeToString(static_cast<rtCntNotifyWaitMode_t>(6)), "UNKNOWN");
}

TEST(EnumLogNamesTest, CondTaskNamesKeepUnknownSentinel)
{
    EXPECT_STREQ(RtCondTaskTypeToString(RT_COND_TASK_TYPE_IF), "COND_TASK_TYPE_IF");
    EXPECT_STREQ(RtCondTaskTypeToString(RT_COND_TASK_TYPE_WHILE), "COND_TASK_TYPE_WHILE");
    EXPECT_STREQ(RtCondTaskTypeToString(RT_COND_TASK_TYPE_SWITCH), "COND_TASK_TYPE_SWITCH");
    EXPECT_STREQ(RtCondTaskTypeToString(RT_COND_TASK_TYPE_MAX), "UNKNOWN");
}

TEST(EnumLogNamesTest, JettyLogNamesTreatMaxAsUnknown)
{
    EXPECT_STREQ(JettyTypeToString(JettyType::JETTY_TYPE_H2D), "JETTY_TYPE_H2D");
    EXPECT_STREQ(JettyTypeToString(JettyType::JETTY_TYPE_D2D_IN_BOARD), "JETTY_TYPE_D2D_IN_BOARD");
    EXPECT_STREQ(JettyTypeToString(JettyType::JETTY_TYPE_D2D_CROSS_BOARD), "JETTY_TYPE_D2D_CROSS_BOARD");
    EXPECT_STREQ(JettyTypeToString(JettyType::JETTY_TYPE_MAX), "UNKNOWN");
    EXPECT_STREQ(JettyTypeToString(static_cast<JettyType>(UINT8_MAX)), "UNKNOWN");
}

#else
TEST(EnumLogNamesTest, DisabledConvertersReturnOwnedNumericStrings)
{
    // Historical case name retained: disabled logging consumes the original numbers only.
    char buffer[32] = {};
    std::snprintf(
        buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d"),
        RT_ENUM_LOG_VALUE(static_cast<int32_t>(RT_MODEL_INPUT_QUEUE), RtModelQueueFlagToString(RT_MODEL_INPUT_QUEUE)));
    EXPECT_STREQ(buffer, "0");
    std::snprintf(
        buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d"),
        RT_ENUM_LOG_VALUE(
            static_cast<int32_t>(RT_TASK_TYPE_KERNEL_AICORE), RtTaskTypeToString(RT_TASK_TYPE_KERNEL_AICORE)));
    EXPECT_STREQ(buffer, "0");
    std::snprintf(
        buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d"),
        RT_ENUM_LOG_VALUE(static_cast<int32_t>(RT_MEMORY_LOC_HOST), RtMemLocationTypeToString(RT_MEMORY_LOC_HOST)));
    EXPECT_STREQ(buffer, "0");
    std::snprintf(
        buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d"),
        RT_ENUM_LOG_VALUE(static_cast<int32_t>(RT_MEMORY_TYPE_HOST), RtMemoryTypeToString(RT_MEMORY_TYPE_HOST)));
    EXPECT_STREQ(buffer, "1");
    std::snprintf(
        buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d"),
        RT_ENUM_LOG_VALUE(
            static_cast<int32_t>(RT_SCHEDULE_SOFTWARE), RtDeviceCapabilityTypeToString(RT_SCHEDULE_SOFTWARE)));
    EXPECT_STREQ(buffer, "0");
    std::snprintf(
        buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d"),
        RT_ENUM_LOG_VALUE(
            static_cast<int32_t>(RT_MQ_QUERY_QUE_ATTR_OF_CUR_PROC),
            RtMemQueueQueryCmdToString(RT_MQ_QUERY_QUE_ATTR_OF_CUR_PROC)));
    EXPECT_STREQ(buffer, "0");
    std::snprintf(
        buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d"),
        RT_ENUM_LOG_VALUE(
            static_cast<int32_t>(RT_BUFF_GET_MBUF_TIMEOUT_INFO),
            RtBuffGetCmdTypeToString(RT_BUFF_GET_MBUF_TIMEOUT_INFO)));
    EXPECT_STREQ(buffer, "0");
    std::snprintf(
        buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d"),
        RT_ENUM_LOG_VALUE(static_cast<int32_t>(HWTS_STATIC_TASK_DESC), RtTaskBuffTypeToString(HWTS_STATIC_TASK_DESC)));
    EXPECT_STREQ(buffer, "0");
    std::snprintf(
        buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d"),
        RT_ENUM_LOG_VALUE(
            static_cast<int32_t>(DeviceFaultType::L2_BUFFER_ERROR),
            DeviceFaultTypeToString(DeviceFaultType::L2_BUFFER_ERROR)));
    EXPECT_STREQ(buffer, "0");
    std::snprintf(
        buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d"),
        RT_ENUM_LOG_VALUE(static_cast<int32_t>(RT_MEM_ADVISE_NONE), RtMallocAdviseToString(RT_MEM_ADVISE_NONE)));
    EXPECT_STREQ(buffer, "0");
    std::snprintf(
        buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d"),
        RT_ENUM_LOG_VALUE(static_cast<int32_t>(RT_GET_DEV_ERROR_MSG), RtGetDevMsgTypeToString(RT_GET_DEV_ERROR_MSG)));
    EXPECT_STREQ(buffer, "0");
    std::snprintf(
        buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d"),
        RT_ENUM_LOG_VALUE(
            static_cast<int32_t>(RT_KERNEL_REG_TYPE_CPU), KernelRegisterTypeToString(RT_KERNEL_REG_TYPE_CPU)));
    EXPECT_STREQ(buffer, "0");
    std::snprintf(
        buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d"),
        RT_ENUM_LOG_VALUE(static_cast<int32_t>(RT_ARGS_NON_CPU_EX), ArgsTypeToString(RT_ARGS_NON_CPU_EX)));
    EXPECT_STREQ(buffer, "1");
    std::snprintf(
        buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d"),
        RT_ENUM_LOG_VALUE(
            static_cast<int32_t>(StreamSubscribeFlag::SUBSCRIBE_NONE),
            StreamSubscribeFlagToString(StreamSubscribeFlag::SUBSCRIBE_NONE)));
    EXPECT_STREQ(buffer, "0");
    std::snprintf(
        buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d"),
        RT_ENUM_LOG_VALUE(static_cast<int32_t>(RT_TIME_UNIT_TYPE_S), RtTaskTimeUnitTypeToString(RT_TIME_UNIT_TYPE_S)));
    EXPECT_STREQ(buffer, "0");
    std::snprintf(
        buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d"),
        RT_ENUM_LOG_VALUE(static_cast<int32_t>(NO_MIX), RtMixTypeToString(NO_MIX)));
    EXPECT_STREQ(buffer, "0");
    std::snprintf(
        buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d"),
        RT_ENUM_LOG_VALUE(static_cast<int32_t>(RT_UTIL_TYPE_AICORE), RtTypeUtilToString(RT_UTIL_TYPE_AICORE)));
    EXPECT_STREQ(buffer, "0");
    std::snprintf(
        buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d"),
        RT_ENUM_LOG_VALUE(
            static_cast<int32_t>(RT_HDC_SERVICE_TYPE_DMP), RtHdcServiceTypeToString(RT_HDC_SERVICE_TYPE_DMP)));
    EXPECT_STREQ(buffer, "0");
}
#endif

TEST(EnumLogFormatTest, BorrowedNameAndValueAreReadOnce)
{
    int32_t nameReads = 0;
    int32_t valueReads = 0;
    const int32_t value = (++valueReads, -7);
    char buffer[64] = {};
    std::snprintf(
        buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d"),
        RT_ENUM_LOG_VALUE(value, RT_ENUM_LOG_NAME((++nameReads, "BORROWED"))));
    EXPECT_EQ(valueReads, 1);
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    EXPECT_STREQ(buffer, "BORROWED(-7)");
    EXPECT_EQ(nameReads, 1);
#else
    EXPECT_STREQ(buffer, "-7");
    EXPECT_EQ(nameReads, 0);
#endif
}

TEST(EnumLogFormatTest, TwoEnumsPreserveFollowingArgumentOrder)
{
    char buffer[128] = {};
    const auto util = RT_UTIL_TYPE_AICPU;
    const auto service = RT_HDC_SERVICE_TYPE_USER_END;
    std::snprintf(
        buffer, sizeof(buffer), "util=" RT_ENUM_LOG_FORMAT("%d") ", service=" RT_ENUM_LOG_FORMAT("%d") ", ret=%d",
        RT_ENUM_LOG_VALUE(static_cast<int32_t>(util), RtTypeUtilToString(util)),
        RT_ENUM_LOG_VALUE(static_cast<int32_t>(service), RtHdcServiceTypeToString(service)), -7);
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    EXPECT_STREQ(buffer, "util=UTIL_TYPE_AICPU(2), service=HDC_SERVICE_TYPE_USER_END(127), ret=-7");
#else
    EXPECT_STREQ(buffer, "util=2, service=127, ret=-7");
#endif
}

TEST(EnumLogFormatTest, ConvertedStringsRemainIndependent)
{
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    const char* const first = RtMixTypeToString(static_cast<RtMixType>(5));
    const char* const copy = first;
    const char* const second = RtMixTypeToString(static_cast<RtMixType>(UINT8_MAX));
    const char* const args = ArgsTypeToString(static_cast<ArgsType>(-1));
    // Names are stable text; subsequent calls do not reuse a mutable numeric buffer.
    EXPECT_STREQ(first, "UNKNOWN");
    EXPECT_STREQ(second, "UNKNOWN");
    EXPECT_STREQ(args, "UNKNOWN");
    EXPECT_EQ(first, copy);
#else
    uint32_t value = 256U;
    const auto copy = value;
    value = 0U;
    char buffer[96] = {};
    std::snprintf(
        buffer, sizeof(buffer),
        "first=" RT_ENUM_LOG_FORMAT("%u") ", second=" RT_ENUM_LOG_FORMAT("%u") ", args=" RT_ENUM_LOG_FORMAT("%u"),
        RT_ENUM_LOG_VALUE(copy, RtMixTypeToString(copy)), RT_ENUM_LOG_VALUE(UINT32_MAX, RtMixTypeToString(UINT32_MAX)),
        RT_ENUM_LOG_VALUE(UINT32_MAX, ArgsTypeToString(static_cast<ArgsType>(-1))));
    EXPECT_STREQ(buffer, "first=256, second=4294967295, args=4294967295");
    EXPECT_EQ(copy, 256U);
    EXPECT_EQ(value, 0U);
#endif
}

TEST(EnumLogFormatTest, EnumValueIsReadOnce)
{
    int32_t reads = 0;
    const auto value = (++reads, RT_MODEL_INPUT_QUEUE);
    char buffer[64] = {};
    std::snprintf(
        buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d"),
        RT_ENUM_LOG_VALUE(static_cast<int32_t>(value), RtModelQueueFlagToString(value)));
    EXPECT_EQ(reads, 1);
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    EXPECT_STREQ(buffer, "MODEL_INPUT_QUEUE(0)");
#else
    EXPECT_STREQ(buffer, "0");
#endif
}

TEST(EnumLogFormatTest, MixWidthsPreserveUnknownValuesAndFollowingArguments)
{
    const uint8_t byteMix = UINT8_MAX;
    const uint16_t wideMix = 257U;
    int32_t nameReadsU32 = 0;
    int32_t nameReadsU64 = 0;
    char buffer[256] = {};
    // Name probes stay inside the enum domain while numeric fields retain their original widths.
    std::snprintf(
        buffer, sizeof(buffer),
        "byte=" RT_ENUM_LOG_FORMAT("%u") ", wide=" RT_ENUM_LOG_FORMAT("%u") ", u32=" RT_ENUM_LOG_FORMAT(
            "%u") ", u64=" RT_ENUM_LOG_FORMAT("%" PRIu64) ", next=%d",
        RT_ENUM_LOG_VALUE(static_cast<uint32_t>(byteMix), RtMixTypeToString(static_cast<RtMixType>(byteMix))),
        RT_ENUM_LOG_VALUE(static_cast<uint32_t>(wideMix), RtMixTypeToString(static_cast<RtMixType>(UINT8_MAX))),
        RT_ENUM_LOG_VALUE(UINT32_MAX, RT_ENUM_LOG_NAME((++nameReadsU32, "BORROWED"))),
        RT_ENUM_LOG_VALUE(UINT64_MAX, RT_ENUM_LOG_NAME((++nameReadsU64, "BORROWED"))), -9);
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    EXPECT_STREQ(
        buffer, "byte=UNKNOWN(255), wide=UNKNOWN(257), u32=BORROWED(4294967295), "
                "u64=BORROWED(18446744073709551615), next=-9");
    EXPECT_EQ(nameReadsU32, 1);
    EXPECT_EQ(nameReadsU64, 1);
#else
    EXPECT_STREQ(buffer, "byte=255, wide=257, u32=4294967295, u64=18446744073709551615, next=-9");
    EXPECT_EQ(nameReadsU32, 0);
    EXPECT_EQ(nameReadsU64, 0);
#endif
}

#if RUNTIME_ENABLE_ENUM_LOG_NAMES
TEST(EnumLogNamesTest, EventStatusKeepsInitRecordedAndUnknownDomain)
{
    EXPECT_EQ(std::string(RtEventStatusToString(RT_EVENT_INIT)), "EVENT_INIT");
    EXPECT_EQ(std::string(RtEventStatusToString(RT_EVENT_RECORDED)), "EVENT_RECORDED");
}
#endif

TEST(EnumLogFormatTest, EventValueIsReadOnceAndFollowingWidthIsPreserved)
{
    int evaluations = 0;
    const auto readValue = [&evaluations]() -> rtEventStatus_t {
        ++evaluations;
        return RT_EVENT_RECORDED;
    };
    const auto value = readValue();
    char buffer[128] = {};
    const int result = std::snprintf(
        buffer, sizeof(buffer), "state=" RT_ENUM_LOG_FORMAT("%d") ", size=%llu",
        RT_ENUM_LOG_VALUE(static_cast<int32_t>(value), RtEventStatusToString(value)), 4294967301ULL);
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    EXPECT_STREQ(buffer, "state=EVENT_RECORDED(1), size=4294967301");
#else
    EXPECT_STREQ(buffer, "state=1, size=4294967301");
#endif
    EXPECT_EQ(evaluations, 1);
    EXPECT_GT(result, 0);
}

TEST(EnumLogFormatTest, DirectArgumentsPreserveWidthsAndOrder)
{
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    static_assert(
        std::is_same<decltype(RtMixTypeToString(NO_MIX)), const char*>::value,
        "name lookup returns a pointer without a numeric result object");
    static_assert(
        std::is_convertible<decltype(RT_ENUM_LOG_NAME("SIGNED")), const char*>::value,
        "borrowed names use the same pointer contract");
#else
    static_assert(
        std::is_same<decltype(RT_ENUM_LOG_VALUE(uint32_t{UINT32_MAX}, RtMixTypeToString(UINT32_MAX))), uint32_t>::value,
        "disabled logging preserves the original unsigned carrier");
    static_assert(
        std::is_same<decltype(RT_ENUM_LOG_VALUE(int64_t{INT64_MIN}, TsTaskTypeToString(UINT32_MAX))), int64_t>::value,
        "disabled logging preserves the original signed width");
#endif
    char buffer[256] = {};
    std::snprintf(
        buffer, sizeof(buffer),
        "i32=" RT_ENUM_LOG_FORMAT("%d") ", u32=" RT_ENUM_LOG_FORMAT("%u") ", i64=" RT_ENUM_LOG_FORMAT(
            "%" PRId64) ", u64=" RT_ENUM_LOG_FORMAT("%" PRIu64) ", next=%d",
        RT_ENUM_LOG_VALUE(INT32_MIN, RT_ENUM_LOG_NAME("SIGNED")),
        RT_ENUM_LOG_VALUE(UINT32_MAX, RT_ENUM_LOG_NAME("UNSIGNED")),
        RT_ENUM_LOG_VALUE(INT64_MIN, RT_ENUM_LOG_NAME("SIGNED")),
        RT_ENUM_LOG_VALUE(UINT64_MAX, RT_ENUM_LOG_NAME("UNSIGNED")), -9);
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    EXPECT_STREQ(
        buffer, "i32=SIGNED(-2147483648), u32=UNSIGNED(4294967295), i64=SIGNED(-9223372036854775808), "
                "u64=UNSIGNED(18446744073709551615), next=-9");
#else
    EXPECT_STREQ(
        buffer, "i32=-2147483648, u32=4294967295, i64=-9223372036854775808, "
                "u64=18446744073709551615, next=-9");
#endif
    std::snprintf(
        buffer, sizeof(buffer),
        "i32=" RT_ENUM_LOG_FORMAT("%d") ", u32=" RT_ENUM_LOG_FORMAT("%u") ", i64=" RT_ENUM_LOG_FORMAT(
            "%" PRId64) ", u64=" RT_ENUM_LOG_FORMAT("%" PRIu64) ", next=%d",
        RT_ENUM_LOG_VALUE(INT32_MAX, RT_ENUM_LOG_NAME("SIGNED")), RT_ENUM_LOG_VALUE(0U, RT_ENUM_LOG_NAME("UNSIGNED")),
        RT_ENUM_LOG_VALUE(INT64_MAX, RT_ENUM_LOG_NAME("SIGNED")),
        RT_ENUM_LOG_VALUE(UINT64_C(0), RT_ENUM_LOG_NAME("UNSIGNED")), -9);
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    EXPECT_STREQ(
        buffer, "i32=SIGNED(2147483647), u32=UNSIGNED(0), i64=SIGNED(9223372036854775807), u64=UNSIGNED(0), next=-9");
#else
    EXPECT_STREQ(buffer, "i32=2147483647, u32=0, i64=9223372036854775807, u64=0, next=-9");
#endif
}

TEST(EnumLogFormatTest, DirectArgumentsSkipDisabledNamesAndReadInputsOnce)
{
    int32_t valueReads = 0;
    int32_t generatedReads = 0;
    int32_t nameReads = 0;
    const int32_t value = (++valueReads, -7);
    char buffer[64] = {};
    std::snprintf(
        buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d") ", next=%d",
        RT_ENUM_LOG_VALUE(value, RT_ENUM_LOG_NAME((++nameReads, "BORROWED"))), -9);
    EXPECT_EQ(valueReads, 1);
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    EXPECT_STREQ(buffer, "BORROWED(-7), next=-9");
    EXPECT_EQ(nameReads, 1);
#else
    EXPECT_STREQ(buffer, "-7, next=-9");
    EXPECT_EQ(nameReads, 0);
#endif
    const uint32_t generatedValue = (++generatedReads, UINT32_MAX);
    std::snprintf(
        buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%u") ", next=%d",
        RT_ENUM_LOG_VALUE(generatedValue, RtMixTypeToString(static_cast<RtMixType>(UINT8_MAX))), -9);
    EXPECT_EQ(generatedReads, 1);
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    EXPECT_STREQ(buffer, "UNKNOWN(4294967295), next=-9");
#else
    EXPECT_STREQ(buffer, "4294967295, next=-9");
#endif
}

TEST(EnumLogFormatTest, DirectArgumentsKeepLongAndNullNames)
{
    static constexpr char staticName[] =
        "STATIC_NAME_ABCDEFGHIJKLMNOPQRSTUVWXYZ_ABCDEFGHIJKLMNOPQRSTUVWXYZ_"
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ_ABCDEFGHIJKLMNOPQRSTUVWXYZ_ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    static constexpr char exactName[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXY";
    static constexpr char overflowName[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ";
    // The old numeric-buffer boundary no longer limits a stable name pointer.
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    const char* const staticText = RT_ENUM_LOG_NAME(staticName);
    const char* const exactText = RT_ENUM_LOG_NAME(exactName);
    const char* const overflowText = RT_ENUM_LOG_NAME(overflowName);
    EXPECT_EQ(staticText, staticName);
    EXPECT_EQ(exactText, exactName);
    EXPECT_EQ(overflowText, overflowName);
    const std::string longName(4096, 'X');
#endif
    char buffer[4600] = {};
    std::snprintf(
        buffer, sizeof(buffer),
        "static=" RT_ENUM_LOG_FORMAT("%d") ", long=" RT_ENUM_LOG_FORMAT("%" PRIu64) ", null=" RT_ENUM_LOG_FORMAT(
            "%d") ", next=%d",
        RT_ENUM_LOG_VALUE(INT32_MIN, staticText), RT_ENUM_LOG_VALUE(UINT64_MAX, RT_ENUM_LOG_NAME(longName.c_str())),
        RT_ENUM_LOG_VALUE(-1, RT_ENUM_LOG_NAME(nullptr)), -9);
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    EXPECT_EQ(
        std::string(buffer), std::string("static=") + staticName + "(-2147483648), long=" + longName +
                                 "(18446744073709551615), null=UNKNOWN(-1), next=-9");
#else
    EXPECT_STREQ(buffer, "static=-2147483648, long=18446744073709551615, null=-1, next=-9");
#endif
    (void)staticName;
    (void)exactName;
    (void)overflowName;
}

TEST(EnumLogFormatTest, DirectGeneratedNamesPreserveFollowingArguments)
{
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    const auto returned = []() { return RtMixTypeToString(static_cast<RtMixType>(5)); }();
    auto original = RtMixTypeToString(static_cast<RtMixType>(UINT8_MAX));
    const auto copied = original;
    original = RtMixTypeToString(NO_MIX);
    // Pointer copies remain valid after the source variable is reassigned.
    EXPECT_STREQ(returned, "UNKNOWN");
    EXPECT_STREQ(copied, "UNKNOWN");
    EXPECT_STREQ(original, "NO_MIX");
#endif
    char buffer[512] = {};
    // clang-format 16 cannot stably format adjacent string macros.
    // clang-format off
    constexpr char format[] =
        "dmp=" RT_ENUM_LOG_FORMAT("%d") ", begin=" RT_ENUM_LOG_FORMAT("%d")
        ", user=" RT_ENUM_LOG_FORMAT("%d") ", last=" RT_ENUM_LOG_FORMAT("%d")
        ", end=" RT_ENUM_LOG_FORMAT("%d") ", unknown=" RT_ENUM_LOG_FORMAT("%d")
        ", mix=" RT_ENUM_LOG_FORMAT("%u") ", next=%d";
    // clang-format on
    std::snprintf(
        buffer, sizeof(buffer), format,
        RT_ENUM_LOG_VALUE(
            static_cast<int32_t>(RT_HDC_SERVICE_TYPE_DMP), RtHdcServiceTypeToString(RT_HDC_SERVICE_TYPE_DMP)),
        RT_ENUM_LOG_VALUE(
            static_cast<int32_t>(RT_HDC_SERVICE_TYPE_USER_START),
            RtHdcServiceTypeToString(RT_HDC_SERVICE_TYPE_USER_START)),
        RT_ENUM_LOG_VALUE(65, RtHdcServiceTypeToString(static_cast<rtHdcServiceType_t>(65))),
        RT_ENUM_LOG_VALUE(126, RtHdcServiceTypeToString(static_cast<rtHdcServiceType_t>(126))),
        RT_ENUM_LOG_VALUE(
            static_cast<int32_t>(RT_HDC_SERVICE_TYPE_USER_END), RtHdcServiceTypeToString(RT_HDC_SERVICE_TYPE_USER_END)),
        RT_ENUM_LOG_VALUE(63, RtHdcServiceTypeToString(static_cast<rtHdcServiceType_t>(63))),
        RT_ENUM_LOG_VALUE(UINT32_MAX, RtMixTypeToString(static_cast<RtMixType>(UINT8_MAX))), -9);
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    EXPECT_STREQ(
        buffer, "dmp=HDC_SERVICE_TYPE_DMP(0), begin=HDC_SERVICE_TYPE_USER_START(64), user=HDC_SERVICE_TYPE_USER(65), "
                "last=HDC_SERVICE_TYPE_USER(126), end=HDC_SERVICE_TYPE_USER_END(127), unknown=UNKNOWN(63), "
                "mix=UNKNOWN(4294967295), next=-9");
#else
    EXPECT_STREQ(buffer, "dmp=0, begin=64, user=65, last=126, end=127, unknown=63, mix=4294967295, next=-9");
#endif
}

TEST(EnumLogFormatTest, SelectedLogArgumentPreservesIntegerWidthsAndFollowingArguments)
{
    const int32_t signedValue = INT32_MIN;
    const uint32_t unsignedValue = UINT32_MAX;
    char buffer[256] = {};
    // Typed UNKNOWN probes and raw numeric fields are independent macro arguments.
    std::snprintf(
        buffer, sizeof(buffer),
        "i32=" RT_ENUM_LOG_FORMAT("%d") ", u32=" RT_ENUM_LOG_FORMAT("%u") ", i64=" RT_ENUM_LOG_FORMAT(
            "%" PRId64) ", u64=" RT_ENUM_LOG_FORMAT("%" PRIu64) ", next=%d",
        RT_ENUM_LOG_VALUE(signedValue, RtDeviceCapabilityTypeToString(static_cast<rtDeviceCapabilityType>(10))),
        RT_ENUM_LOG_VALUE(unsignedValue, RtRunModeToString(RT_RUN_MODE_RESERVED)),
        RT_ENUM_LOG_VALUE(INT64_MIN, RT_ENUM_LOG_NAME("SIGNED64")),
        RT_ENUM_LOG_VALUE(UINT64_MAX, RT_ENUM_LOG_NAME("UNSIGNED64")), -9);
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    static_assert(
        std::is_same<
            decltype(RtDeviceCapabilityTypeToString(static_cast<rtDeviceCapabilityType>(10))), const char*>::value,
        "signed lookups return names without converting the original numeric argument");
    static_assert(
        std::is_same<decltype(RtRunModeToString(RT_RUN_MODE_RESERVED)), const char*>::value,
        "unsigned lookups return names without narrowing the original numeric argument");
    EXPECT_STREQ(
        buffer, "i32=UNKNOWN(-2147483648), u32=UNKNOWN(4294967295), "
                "i64=SIGNED64(-9223372036854775808), u64=UNSIGNED64(18446744073709551615), next=-9");
#else
    EXPECT_STREQ(
        buffer, "i32=-2147483648, u32=4294967295, i64=-9223372036854775808, "
                "u64=18446744073709551615, next=-9");
#endif
}

TEST(EnumLogFormatTest, SelectedLogArgumentEvaluatesOnlyActiveExpressionOnce)
{
    int32_t valueReads = 0;
    int32_t nameReads = 0;
    const auto readValue = [&valueReads]() {
        ++valueReads;
        return UINT64_MAX;
    };
    const uint64_t value = readValue();
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    const auto name = [&nameReads](const uint64_t) -> const char* {
        ++nameReads;
        return "SELECTED";
    };
#endif
    char buffer[96] = {};
    std::snprintf(
        buffer, sizeof(buffer), "value=" RT_ENUM_LOG_FORMAT("%" PRIu64) ", next=%d",
        RT_ENUM_LOG_VALUE(value, name(value)), -9);
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    EXPECT_STREQ(buffer, "value=SELECTED(18446744073709551615), next=-9");
    EXPECT_EQ(nameReads, 1);
#else
    EXPECT_STREQ(buffer, "value=18446744073709551615, next=-9");
    EXPECT_EQ(nameReads, 0);
#endif
    EXPECT_EQ(valueReads, 1);
}

TEST(EnumLogNamesTest, BinBufferNamesKeepSentinelAndUnnamedZero)
{
    const auto unknown = static_cast<rtBinBufferType_t>(0);
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    EXPECT_STREQ(RtBinBufferTypeToString(RT_BIN_HOST_ADDR), "BIN_HOST_ADDR");
    EXPECT_STREQ(RtBinBufferTypeToString(RT_BIN_DEVICE_ADDR), "BIN_DEVICE_ADDR");
    EXPECT_STREQ(RtBinBufferTypeToString(RT_BIN_TYPE_MAX), "UNKNOWN");
    EXPECT_STREQ(RtBinBufferTypeToString(unknown), "UNKNOWN");
#else
    const int32_t values[] = {RT_BIN_HOST_ADDR, RT_BIN_DEVICE_ADDR, RT_BIN_TYPE_MAX, unknown};
    const char* const expected[] = {"1", "2", "3", "0"};
    for (size_t i = 0U; i < sizeof(values) / sizeof(values[0]); ++i) {
        SCOPED_TRACE(i);
        char buffer[32] = {};
        std::snprintf(
            buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d"),
            RT_ENUM_LOG_VALUE(values[i], RtBinBufferTypeToString(values[i])));
        EXPECT_STREQ(buffer, expected[i]);
    }
#endif
}

TEST(EnumLogNamesTest, DqsZeroCopyNamesCoverRepresentableDomain)
{
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    EXPECT_STREQ(RtDqsZeroCopyTypeToString(RT_DQS_ZERO_COPY_INPUT), "DQS_ZERO_COPY_INPUT");
    EXPECT_STREQ(RtDqsZeroCopyTypeToString(RT_DQS_ZERO_COPY_OUTPUT), "DQS_ZERO_COPY_OUTPUT");
    // Both representable values are named; this unfixed enum has no legal UNKNOWN input.
#else
    const uint32_t values[] = {RT_DQS_ZERO_COPY_INPUT, RT_DQS_ZERO_COPY_OUTPUT, 2U, UINT32_MAX};
    const char* const expected[] = {"0", "1", "2", "4294967295"};
    for (size_t i = 0U; i < sizeof(values) / sizeof(values[0]); ++i) {
        SCOPED_TRACE(i);
        char buffer[32] = {};
        std::snprintf(
            buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%u"),
            RT_ENUM_LOG_VALUE(values[i], RtDqsZeroCopyTypeToString(values[i])));
        EXPECT_STREQ(buffer, expected[i]);
    }
#endif
}

TEST(EnumLogNamesTest, FusionSubKernelNamesKeepEndAndUnnamedValue)
{
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    EXPECT_STREQ(RtFusionTypeToString(RT_FUSION_HCOM_CPU), "FUSION_HCOM_CPU");
    EXPECT_STREQ(RtFusionTypeToString(RT_FUSION_AICPU), "FUSION_AICPU");
    EXPECT_STREQ(RtFusionTypeToString(RT_FUSION_AICORE), "FUSION_AICORE");
    EXPECT_STREQ(RtFusionTypeToString(RT_FUSION_CCU), "FUSION_CCU");
    EXPECT_STREQ(RtFusionTypeToString(RT_FUSION_END), "UNKNOWN");
    EXPECT_STREQ(RtFusionTypeToString(static_cast<rtFusionType_t>(5)), "UNKNOWN");
#else
    const uint32_t values[] = {RT_FUSION_HCOM_CPU, RT_FUSION_AICPU, RT_FUSION_AICORE,
                               RT_FUSION_CCU,      RT_FUSION_END,   UINT32_MAX};
    const char* const expected[] = {"0", "1", "2", "3", "4", "4294967295"};
    for (size_t i = 0U; i < sizeof(values) / sizeof(values[0]); ++i) {
        SCOPED_TRACE(i);
        char buffer[32] = {};
        std::snprintf(
            buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%u"),
            RT_ENUM_LOG_VALUE(values[i], RtFusionTypeToString(values[i])));
        EXPECT_STREQ(buffer, expected[i]);
    }
#endif
}

TEST(EnumLogNamesTest, ExceptionExpandNamesKeepSignedUnknowns)
{
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    EXPECT_STREQ(RtExceptionExpandTypeToString(RT_EXCEPTION_INVALID), "EXCEPTION_INVALID");
    EXPECT_STREQ(RtExceptionExpandTypeToString(RT_EXCEPTION_FFTS_PLUS), "EXCEPTION_FFTS_PLUS");
    EXPECT_STREQ(RtExceptionExpandTypeToString(RT_EXCEPTION_AICORE), "EXCEPTION_AICORE");
    EXPECT_STREQ(RtExceptionExpandTypeToString(RT_EXCEPTION_UB), "EXCEPTION_UB");
    EXPECT_STREQ(RtExceptionExpandTypeToString(RT_EXCEPTION_CCU), "EXCEPTION_CCU");
    EXPECT_STREQ(RtExceptionExpandTypeToString(RT_EXCEPTION_FUSION), "EXCEPTION_FUSION");
    EXPECT_STREQ(RtExceptionExpandTypeToString(RT_EXCEPTION_AICPU), "EXCEPTION_AICPU");
    EXPECT_STREQ(RtExceptionExpandTypeToString(static_cast<rtExceptionExpandType_t>(7)), "UNKNOWN");
#else
    const int32_t values[] = {
        RT_EXCEPTION_INVALID,
        RT_EXCEPTION_FFTS_PLUS,
        RT_EXCEPTION_AICORE,
        RT_EXCEPTION_UB,
        RT_EXCEPTION_CCU,
        RT_EXCEPTION_FUSION,
        RT_EXCEPTION_AICPU,
        -1,
        INT32_MAX};
    const char* const expected[] = {"0", "1", "2", "3", "4", "5", "6", "-1", "2147483647"};
    for (size_t i = 0U; i < sizeof(values) / sizeof(values[0]); ++i) {
        SCOPED_TRACE(i);
        char buffer[32] = {};
        std::snprintf(
            buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d"),
            RT_ENUM_LOG_VALUE(values[i], RtExceptionExpandTypeToString(values[i])));
        EXPECT_STREQ(buffer, expected[i]);
    }
#endif
}

TEST(EnumLogNamesTest, FusionSchemNamesKeepEndAndUnnamedValue)
{
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    EXPECT_STREQ(RtSchemModeTypeToString(RT_SCHEM_MODE_NORMAL), "SCHEM_MODE_NORMAL");
    EXPECT_STREQ(RtSchemModeTypeToString(RT_SCHEM_MODE_BATCH), "SCHEM_MODE_BATCH");
    EXPECT_STREQ(RtSchemModeTypeToString(RT_SCHEM_MODE_END), "UNKNOWN");
    EXPECT_STREQ(RtSchemModeTypeToString(static_cast<rtschemModeType_t>(3)), "UNKNOWN");
#else
    const uint32_t values[] = {RT_SCHEM_MODE_NORMAL, RT_SCHEM_MODE_BATCH, RT_SCHEM_MODE_END, UINT32_MAX};
    const char* const expected[] = {"0", "1", "2", "4294967295"};
    for (size_t i = 0U; i < sizeof(values) / sizeof(values[0]); ++i) {
        SCOPED_TRACE(i);
        char buffer[32] = {};
        std::snprintf(
            buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%u"),
            RT_ENUM_LOG_VALUE(values[i], RtSchemModeTypeToString(values[i])));
        EXPECT_STREQ(buffer, expected[i]);
    }
#endif
}

TEST(EnumLogNamesTest, TaskTimeoutNamesCoverRepresentableDomain)
{
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    EXPECT_STREQ(RtTaskTimeoutTypeToString(RT_TIMEOUT_TYPE_OP_WAIT), "TIMEOUT_TYPE_OP_WAIT");
    EXPECT_STREQ(RtTaskTimeoutTypeToString(RT_TIMEOUT_TYPE_OP_EXECUTE), "TIMEOUT_TYPE_OP_EXECUTE");
    // Both representable values are named; this unfixed enum has no legal UNKNOWN input.
#else
    const int32_t values[] = {RT_TIMEOUT_TYPE_OP_WAIT, RT_TIMEOUT_TYPE_OP_EXECUTE, -1, INT32_MAX};
    const char* const expected[] = {"0", "1", "-1", "2147483647"};
    for (size_t i = 0U; i < sizeof(values) / sizeof(values[0]); ++i) {
        SCOPED_TRACE(i);
        char buffer[32] = {};
        std::snprintf(
            buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%d"),
            RT_ENUM_LOG_VALUE(values[i], RtTaskTimeoutTypeToString(values[i])));
        EXPECT_STREQ(buffer, expected[i]);
    }
#endif
}

TEST(EnumLogNamesTest, TaskFailCallbackNamesKeepSentinelAndOwnedResults)
{
    const auto unknown = static_cast<TaskFailCallbackType>(UINT8_MAX);
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    // Copies now retain stable name pointers, rather than owning numeric buffers.
    auto text = TaskFailCallbackTypeToString(TaskFailCallbackType::RT_SET_TASK_FAIL_CALLBACK);
    const auto copy = text;
    text = TaskFailCallbackTypeToString(TaskFailCallbackType::RTS_SET_TASK_FAIL_CALLBACK);
    EXPECT_STREQ(copy, "SET_TASK_FAIL_CALLBACK");
    EXPECT_STREQ(text, "RTS_SET_TASK_FAIL_CALLBACK");
    EXPECT_STREQ(
        TaskFailCallbackTypeToString(TaskFailCallbackType::RT_REG_TASK_FAIL_CALLBACK_BY_MODULE),
        "REG_TASK_FAIL_CALLBACK_BY_MODULE");
    EXPECT_STREQ(TaskFailCallbackTypeToString(TaskFailCallbackType::TASK_FAIL_CALLBACK_TYPE_MAX), "UNKNOWN");
    EXPECT_STREQ(TaskFailCallbackTypeToString(unknown), "UNKNOWN");
#else
    const uint32_t values[] = {
        static_cast<uint32_t>(TaskFailCallbackType::RT_SET_TASK_FAIL_CALLBACK),
        static_cast<uint32_t>(TaskFailCallbackType::RTS_SET_TASK_FAIL_CALLBACK),
        static_cast<uint32_t>(TaskFailCallbackType::RT_REG_TASK_FAIL_CALLBACK_BY_MODULE),
        static_cast<uint32_t>(TaskFailCallbackType::TASK_FAIL_CALLBACK_TYPE_MAX), static_cast<uint32_t>(unknown)};
    const char* const expected[] = {"0", "2", "1", "3", "255"};
    for (size_t i = 0U; i < sizeof(values) / sizeof(values[0]); ++i) {
        SCOPED_TRACE(i);
        char buffer[32] = {};
        std::snprintf(
            buffer, sizeof(buffer), RT_ENUM_LOG_FORMAT("%u"),
            RT_ENUM_LOG_VALUE(values[i], TaskFailCallbackTypeToString(values[i])));
        EXPECT_STREQ(buffer, expected[i]);
    }
#endif
}
