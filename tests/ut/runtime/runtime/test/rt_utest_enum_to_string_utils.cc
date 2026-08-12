/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "common/enum_desc.hpp"
#include "model/capture_model_enum_desc.hpp"
#include "notify/notify_enum_desc.hpp"
#include "cond_handle/cond_enum_desc.hpp"
#include "device/device_enum_desc.hpp"
#include "task/task_enum_desc.hpp"
#include "stream/stream_enum_desc.hpp"

#include "gtest/gtest.h"

using namespace cce::runtime;

TEST(EnumToStringUtilsTest, ReduceKindToStringKnownValue)
{
    EXPECT_EQ(ReduceKindToString(RT_MEMCPY_SDMA_AUTOMATIC_ADD), "MEMCPY_SDMA_AUTOMATIC_ADD(10)");
    EXPECT_EQ(ReduceKindToString(RT_MEMCPY_SDMA_AUTOMATIC_MAX), "MEMCPY_SDMA_AUTOMATIC_MAX(11)");
    EXPECT_EQ(ReduceKindToString(RT_MEMCPY_SDMA_AUTOMATIC_MIN), "MEMCPY_SDMA_AUTOMATIC_MIN(12)");
    EXPECT_EQ(ReduceKindToString(RT_MEMCPY_SDMA_AUTOMATIC_EQUAL), "MEMCPY_SDMA_AUTOMATIC_EQUAL(13)");
    EXPECT_EQ(ReduceKindToString(RT_RECUDE_KIND_END), "RECUDE_KIND_END(14)");
}

TEST(EnumToStringUtilsTest, ReduceKindToStringUnknownValue)
{
    EXPECT_EQ(ReduceKindToString(static_cast<rtRecudeKind_t>(100)), "UNKNOWN(100)");
}

TEST(EnumToStringUtilsTest, DataTypeToStringKnownValue)
{
    EXPECT_EQ(DataTypeToString(RT_DATA_TYPE_FP32), "DATA_TYPE_FP32(0)");
    EXPECT_EQ(DataTypeToString(RT_DATA_TYPE_INT8), "DATA_TYPE_INT8(4)");
    EXPECT_EQ(DataTypeToString(RT_DATA_TYPE_END), "DATA_TYPE_END(11)");
}

TEST(EnumToStringUtilsTest, DataTypeToStringUnknownValue)
{
    EXPECT_EQ(DataTypeToString(static_cast<rtDataType_t>(100)), "UNKNOWN(100)");
}

TEST(EnumToStringUtilsTest, StreamCaptureModeToStringKnownValue)
{
    EXPECT_EQ(StreamCaptureModeToString(RT_STREAM_CAPTURE_MODE_GLOBAL), "GLOBAL(0)");
    EXPECT_EQ(StreamCaptureModeToString(RT_STREAM_CAPTURE_MODE_RELAXED), "RELAXED(2)");
}

TEST(EnumToStringUtilsTest, StreamCaptureModeToStringUnknownValue)
{
    EXPECT_EQ(StreamCaptureModeToString(static_cast<rtStreamCaptureMode>(100)), "UNKNOWN(100)");
}

TEST(EnumToStringUtilsTest, InfoTypeToStringKnownValue)
{
    EXPECT_EQ(InfoTypeToString(23U), "UTILIZATION(23)");
    EXPECT_EQ(InfoTypeToString(3U), "CORE_NUM(3)");
}

TEST(EnumToStringUtilsTest, InfoTypeToStringUnknownValue) { EXPECT_EQ(InfoTypeToString(100U), "UNKNOWN(100)"); }

TEST(EnumToStringUtilsTest, ModuleTypeToStringKnownValue)
{
    EXPECT_EQ(ModuleTypeToString(RT_MODULE_TYPE_MEMORY), "MEMORY(10)");
}

TEST(EnumToStringUtilsTest, ModuleTypeToStringUnknownValue) { EXPECT_EQ(ModuleTypeToString(-1), "UNKNOWN(-1)"); }

TEST(EnumToStringUtilsTest, MemcpyKindToStrKnownValue)
{
    EXPECT_STREQ(MemcpyKindToStr(RT_MEMCPY_HOST_TO_HOST), "MEMCPY_HOST_TO_HOST(0)");
    EXPECT_STREQ(MemcpyKindToStr(RT_MEMCPY_DEFAULT), "MEMCPY_DEFAULT(8)");
}

TEST(EnumToStringUtilsTest, MemcpyKindToStrUnknownValue)
{
    EXPECT_STREQ(MemcpyKindToStr(static_cast<rtMemcpyKind_t>(100)), "UNKNOWN(100)");
}

TEST(EnumToStringUtilsTest, MemcpyNewKindToStringKnownValue)
{
    EXPECT_EQ(MemcpyNewKindToString(RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE), "MEMCPY_KIND_INNER_DEVICE_TO_DEVICE(6)");
}

TEST(EnumToStringUtilsTest, MemcpyNewKindToStringUnknownValue)
{
    EXPECT_EQ(MemcpyNewKindToString(static_cast<rtMemcpyKind>(100)), "UNKNOWN(100)");
}

TEST(EnumToStringUtilsTest, WriteValueSizeTypeToStringKnownValue)
{
    EXPECT_EQ(WriteValueSizeTypeToString(WRITE_VALUE_SIZE_TYPE_BUFF), "WRITE_VALUE_SIZE_TYPE_BUFF(7)");
    EXPECT_EQ(WriteValueSizeTypeToString(WRITE_VALUE_SIZE_TYPE_32BIT), "WRITE_VALUE_SIZE_TYPE_32BIT(3)");
}

TEST(EnumToStringUtilsTest, WriteValueSizeTypeToStringUnknownValue)
{
    EXPECT_EQ(WriteValueSizeTypeToString(static_cast<rtWriteValueSizeType_t>(100)), "UNKNOWN(100)");
}

TEST(EnumToStringUtilsTest, CondHandleFlagToStringKnownValue)
{
    EXPECT_EQ(CondHandleFlagToString(RT_COND_HANDLE_ASSIGN_DEFAULT), "COND_HANDLE_ASSIGN_DEFAULT(1)");
}

TEST(EnumToStringUtilsTest, CondHandleFlagToStringUnknownValue)
{
    EXPECT_EQ(CondHandleFlagToString(static_cast<rtCondHandleFlag_t>(100)), "UNKNOWN(100)");
}

TEST(EnumToStringUtilsTest, CondTaskTypeToStringKnownValue)
{
    EXPECT_EQ(CondTaskTypeToString(RT_COND_TASK_TYPE_IF), "COND_TASK_TYPE_IF(0)");
    EXPECT_EQ(CondTaskTypeToString(RT_COND_TASK_TYPE_SWITCH), "COND_TASK_TYPE_SWITCH(2)");
    EXPECT_EQ(CondTaskTypeToString(RT_COND_TASK_TYPE_MAX), "COND_TASK_TYPE_MAX(3)");
}

TEST(EnumToStringUtilsTest, CondTaskTypeToStringUnknownValue)
{
    EXPECT_EQ(CondTaskTypeToString(static_cast<rtCondTaskType_t>(100)), "UNKNOWN(100)");
}

TEST(EnumToStringUtilsTest, CaptureModelStatusToStringKnownValue)
{
    EXPECT_EQ(CaptureModelStatusToString(RtCaptureModelStatus::READY), "READY(5)");
}

TEST(EnumToStringUtilsTest, KernelFlagToStringKnownValue)
{
    EXPECT_EQ(KernelFlagToString(RT_KERNEL_CUSTOM_AICPU), "KERNEL_CUSTOM_AICPU(8)");
}

TEST(EnumToStringUtilsTest, NotifyFlagToStringKnownValue)
{
    EXPECT_EQ(NotifyFlagToString(static_cast<uint32_t>(RT_NOTIFY_FLAG_SHR_ID_SHADOW)), "NOTIFY_FLAG_SHR_ID_SHADOW(64)");
}

TEST(EnumToStringUtilsTest, RecordModeToStringKnownValue)
{
    EXPECT_EQ(RecordModeToString(RECORD_CLEAR_BIT_MODE), "RECORD_CLEAR_BIT_MODE(4)");
}

TEST(EnumToStringUtilsTest, WaitModeToStringKnownValue)
{
    EXPECT_EQ(WaitModeToString(WAIT_BITMAP_MODE), "WAIT_BITMAP_MODE(4)");
}

TEST(EnumToStringUtilsTest, CaptureEventModeToStringKnownValue)
{
    EXPECT_EQ(CaptureEventModeToString(static_cast<uint8_t>(CaptureEventModeType::HARDWARE_MODE)), "HARDWARE_MODE(1)");
}

TEST(EnumToStringUtilsTest, DevFeatureTypeToStringKnownValue)
{
    EXPECT_EQ(DevFeatureTypeToString(RT_FEATURE_SYSTEM_TASKID_BIT_WIDTH), "FEATURE_SYSTEM_TASKID_BIT_WIDTH(20001)");
}

TEST(EnumToStringUtilsTest, MemTypeToStringKnownValue)
{
    EXPECT_EQ(MemTypeToString(RT_MEMORY_HBM), "MEMORY_HBM(2)");
    EXPECT_EQ(MemTypeToString(RT_MEMORY_HOST), "MEMORY_HOST(129)");
    EXPECT_EQ(MemTypeToString(RT_MEMORY_P2P_HBM), "MEMORY_P2P_HBM(16)");
}

TEST(EnumToStringUtilsTest, MemTypeToStringUnknownValue)
{
    EXPECT_EQ(MemTypeToString(static_cast<rtMemType_t>(999)), "UNKNOWN(999)");
}

TEST(EnumToStringUtilsTest, GnlCtrlTypeToStringKnownValue)
{
    EXPECT_EQ(GnlCtrlTypeToString(RT_GNL_CTRL_TYPE_MEMCPY_ASYNC_CFG), "GNL_CTRL_TYPE_MEMCPY_ASYNC_CFG(0)");
    EXPECT_EQ(GnlCtrlTypeToString(RT_GNL_CTRL_TYPE_MULTIPLE_TSK), "GNL_CTRL_TYPE_MULTIPLE_TSK(13)");
}

TEST(EnumToStringUtilsTest, GnlCtrlTypeToStringUnknownValue)
{
    EXPECT_EQ(GnlCtrlTypeToString(static_cast<rtGeneralCtrlType_t>(100)), "UNKNOWN(100)");
}

TEST(EnumToStringUtilsTest, StreamPriorityToStringKnownValue)
{
    EXPECT_EQ(StreamPriorityToString(RT_STREAM_PRIORITY_DEFAULT), "STREAM_PRIORITY_DEFAULT(0)");
}

TEST(EnumToStringUtilsTest, StreamPriorityToStringUnknownValue)
{
    EXPECT_EQ(StreamPriorityToString(999), "UNKNOWN(999)");
}

TEST(EnumToStringUtilsTest, MultipleTaskTypeToStringKnownValue)
{
    EXPECT_EQ(MultipleTaskTypeToString(RT_MULTIPLE_TASK_TYPE_AICPU), "MULTIPLE_TASK_TYPE_AICPU(1)");
}

TEST(EnumToStringUtilsTest, MultipleTaskTypeToStringUnknownValue)
{
    EXPECT_EQ(MultipleTaskTypeToString(static_cast<rtMultipleTaskType_t>(100)), "UNKNOWN(100)");
}

TEST(EnumToStringUtilsTest, StreamTypeToStringKnownValue)
{
    EXPECT_EQ(StreamTypeToString(RT_NORMAL_STREAM), "NORMAL_STREAM(0)");
    EXPECT_EQ(StreamTypeToString(RT_HUGE_STREAM), "HUGE_STREAM(1)");
}

TEST(EnumToStringUtilsTest, StreamTypeToStringUnknownValue) { EXPECT_EQ(StreamTypeToString(999), "UNKNOWN(999)"); }

TEST(EnumToStringUtilsTest, MemInfoTypeToStringKnownValue)
{
    EXPECT_EQ(MemInfoTypeToString(RT_MEMORYINFO_DDR), "MEMORYINFO_DDR(0)");
    EXPECT_EQ(MemInfoTypeToString(RT_MEMORYINFO_HBM), "MEMORYINFO_HBM(1)");
    EXPECT_EQ(MemInfoTypeToString(RT_MEMORYINFO_P2P_HUGE1G), "MEMORYINFO_P2P_HUGE1G(17)");
}

TEST(EnumToStringUtilsTest, MemInfoTypeToStringUnknownValue)
{
    EXPECT_EQ(MemInfoTypeToString(static_cast<rtMemInfoType_t>(100)), "UNKNOWN(100)");
}

TEST(EnumToStringUtilsTest, RemediatedEnumToStringKnownValue)
{
    EXPECT_EQ(
        ManagedMemLocationTypeToString(rtMemLocationTypeHostNumaCurrent), "MEM_LOCATION_TYPE_HOST_NUMA_CURRENT(4)");
    EXPECT_STREQ(MallocAttrToString(RT_MEM_MALLOC_ATTR_VA_FLAG), "MEM_MALLOC_ATTR_VA_FLAG(3)");
    EXPECT_STREQ(FloatOverflowModeToString(RT_OVERFLOW_MODE_INFNAN), "OVERFLOW_MODE_INFNAN(1)");
    EXPECT_STREQ(FloatOverflowModeToString(RT_OVERFLOW_MODE_UNDEF), "OVERFLOW_MODE_UNDEF(2)");
    EXPECT_EQ(CmoOpCodeToString(RT_CMO_FLUSH), "CMO_FLUSH(9)");
    EXPECT_EQ(CmoOpCodeToString(RT_CMO_RESERVED), "CMO_RESERVED(10)");
    EXPECT_EQ(LimitTypeToString(RT_LIMIT_TYPE_SIMT_PRINTF_FIFO_SIZE), "LIMIT_TYPE_SIMT_PRINTF_FIFO_SIZE(5)");
    EXPECT_EQ(SysParamOptToString(SYS_OPT_STRONG_CONSISTENCY), "SYS_OPT_STRONG_CONSISTENCY(2)");
    EXPECT_EQ(SysParamOptToString(SYS_OPT_RESERVED), "SYS_OPT_RESERVED(3)");
    EXPECT_STREQ(DevResLimitTypeToString(RT_DEV_RES_VECTOR_CORE), "DEV_RES_VECTOR_CORE(1)");
    EXPECT_STREQ(DevResLimitTypeToString(RT_DEV_RES_TYPE_MAX), "DEV_RES_TYPE_MAX(2)");
    EXPECT_EQ(ConditionToString(RT_GREATER_OR_EQUAL), "GREATER_OR_EQUAL(3)");
    EXPECT_EQ(KernelAttrTypeToString(RT_KERNEL_ATTR_TYPE_AICPU), "KERNEL_ATTR_TYPE_AICPU(100)");
    EXPECT_EQ(LaunchKernelAttrIdToString(RT_LAUNCH_KERNEL_ATTR_TIMEOUT_US), "LAUNCH_KERNEL_ATTR_TIMEOUT_US(8)");
    EXPECT_EQ(LaunchKernelAttrIdToString(RT_LAUNCH_KERNEL_ATTR_MAX), "LAUNCH_KERNEL_ATTR_MAX(9)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_NPU_ARCH), "DEV_ATTR_NPU_ARCH(601)");
    EXPECT_STREQ(
        DevAttrToString(RT_DEV_ATTR_MAX), RtFmtMsg("DEV_ATTR_MAX(%d)", static_cast<int32_t>(RT_DEV_ATTR_MAX)).c_str());
    EXPECT_EQ(HacTypeToString(RT_HAC_TYPE_CCU), "HAC_TYPE_CCU(9)");
    EXPECT_EQ(MemPoolAttrToString(rtMemPoolAttrUsedMemHigh), "rtMemPoolAttrUsedMemHigh(8)");
    EXPECT_EQ(DeviceStatusToString(RT_DEVICE_STATUS_END), "DEVICE_STATUS_END(65535)");
    EXPECT_STREQ(DrvMemHandleTypeToString(RT_MEM_HANDLE_TYPE_POSIX), "MEM_HANDLE_TYPE_POSIX(2)");
    EXPECT_STREQ(MemSharedHandleTypeToString(RT_MEM_SHARE_HANDLE_TYPE_FABRIC), "MEM_SHARE_HANDLE_TYPE_FABRIC(2)");
    EXPECT_EQ(TaskTypeToString(RT_TASK_VALUE_WAIT), "TASK_VALUE_WAIT(6)");
    EXPECT_EQ(
        StreamCaptureStatusToString(RT_STREAM_CAPTURE_STATUS_INVALIDATED), "STREAM_CAPTURE_STATUS_INVALIDATED(2)");
}

TEST(EnumToStringUtilsTest, RemediatedEnumToStringUnknownValue)
{
    EXPECT_EQ(ManagedMemLocationTypeToString(static_cast<rtMemManagedLocationType>(100)), "UNKNOWN(100)");
    EXPECT_STREQ(MallocAttrToString(static_cast<rtMallocAttr>(101)), "UNKNOWN(101)");
    EXPECT_STREQ(FloatOverflowModeToString(static_cast<rtFloatOverflowMode_t>(102)), "UNKNOWN(102)");
    EXPECT_EQ(CmoOpCodeToString(static_cast<rtCmoOpCode_t>(104)), "UNKNOWN(104)");
    EXPECT_EQ(LimitTypeToString(static_cast<rtLimitType_t>(106)), "UNKNOWN(106)");
    EXPECT_EQ(SysParamOptToString(static_cast<rtSysParamOpt>(107)), "UNKNOWN(107)");
    EXPECT_STREQ(DevResLimitTypeToString(static_cast<rtDevResLimitType_t>(108)), "UNKNOWN(108)");
    EXPECT_EQ(ConditionToString(static_cast<rtCondition_t>(109)), "UNKNOWN(109)");
    EXPECT_EQ(KernelAttrTypeToString(static_cast<rtKernelAttrType>(110)), "UNKNOWN(110)");
    EXPECT_EQ(LaunchKernelAttrIdToString(static_cast<rtLaunchKernelAttrId>(111)), "UNKNOWN(111)");
    EXPECT_STREQ(DevAttrToString(static_cast<rtDevAttr>(113)), "UNKNOWN(113)");
    EXPECT_EQ(HacTypeToString(static_cast<rtHacType>(115)), "UNKNOWN(115)");
    EXPECT_EQ(MemPoolAttrToString(static_cast<rtMemPoolAttr>(116)), "UNKNOWN(116)");
    EXPECT_EQ(DeviceStatusToString(static_cast<rtDeviceStatus>(117)), "UNKNOWN(117)");
    EXPECT_STREQ(DrvMemHandleTypeToString(static_cast<rtDrvMemHandleType>(118)), "UNKNOWN(118)");
    EXPECT_STREQ(MemSharedHandleTypeToString(static_cast<rtMemSharedHandleType>(119)), "UNKNOWN(119)");
    EXPECT_EQ(
        RtFmtMsg(
            "%s,%s", MallocAttrToString(static_cast<rtMallocAttr>(101)),
            FloatOverflowModeToString(static_cast<rtFloatOverflowMode_t>(102))),
        "UNKNOWN(101),UNKNOWN(102)");
    EXPECT_EQ(TaskTypeToString(static_cast<rtTaskType>(120)), "UNKNOWN(120)");
    EXPECT_EQ(StreamCaptureStatusToString(static_cast<rtStreamCaptureStatus>(121)), "UNKNOWN(121)");
}

TEST(EnumToStringUtilsTest, SwitchDataTypeToStringKnownValue)
{
    EXPECT_EQ(SwitchDataTypeToString(RT_SWITCH_INT32), "SWITCH_INT32(0)");
    EXPECT_EQ(SwitchDataTypeToString(RT_SWITCH_INT64), "SWITCH_INT64(1)");
}

TEST(EnumToStringUtilsTest, SwitchDataTypeToStringUnknownValue)
{
    EXPECT_EQ(SwitchDataTypeToString(static_cast<rtSwitchDataType_t>(100)), "UNKNOWN(100)");
}

TEST(EnumToStringUtilsTest, RandomNumDataTypeToStringKnownValue)
{
    EXPECT_EQ(RandomNumDataTypeToString(RT_RANDOM_NUM_DATATYPE_INT32), "RANDOM_NUM_DATATYPE_INT32(0)");
    EXPECT_EQ(RandomNumDataTypeToString(RT_RANDOM_NUM_DATATYPE_FP32), "RANDOM_NUM_DATATYPE_FP32(6)");
    EXPECT_EQ(RandomNumDataTypeToString(RT_RANDOM_NUM_DATATYPE_MAX), "RANDOM_NUM_DATATYPE_MAX(7)");
}

TEST(EnumToStringUtilsTest, RandomNumDataTypeToStringUnknownValue)
{
    EXPECT_EQ(RandomNumDataTypeToString(static_cast<rtRandomNumDataType>(100)), "UNKNOWN(100)");
}

TEST(EnumToStringUtilsTest, RandomNumFuncTypeToStringKnownValue)
{
    EXPECT_EQ(
        RandomNumFuncTypeToString(RT_RANDOM_NUM_FUNC_TYPE_DROPOUT_BITMASK), "RANDOM_NUM_FUNC_TYPE_DROPOUT_BITMASK(0)");
    EXPECT_EQ(
        RandomNumFuncTypeToString(RT_RANDOM_NUM_FUNC_TYPE_TRUNCATED_NORMAL_DIS),
        "RANDOM_NUM_FUNC_TYPE_TRUNCATED_NORMAL_DIS(3)");
    EXPECT_EQ(RandomNumFuncTypeToString(RT_RANDOM_NUM_FUNC_TYPE_MAX), "RANDOM_NUM_FUNC_TYPE_MAX(4)");
}

TEST(EnumToStringUtilsTest, RandomNumFuncTypeToStringUnknownValue)
{
    EXPECT_EQ(RandomNumFuncTypeToString(static_cast<rtRandomNumFuncType>(100)), "UNKNOWN(100)");
}

TEST(EnumToStringUtilsTest, CommonDataAndMemoryEnumsAllKnownValues)
{
    EXPECT_EQ(DataTypeToString(RT_DATA_TYPE_FP32), "DATA_TYPE_FP32(0)");
    EXPECT_EQ(DataTypeToString(RT_DATA_TYPE_FP16), "DATA_TYPE_FP16(1)");
    EXPECT_EQ(DataTypeToString(RT_DATA_TYPE_INT16), "DATA_TYPE_INT16(2)");
    EXPECT_EQ(DataTypeToString(RT_DATA_TYPE_INT4), "DATA_TYPE_INT4(3)");
    EXPECT_EQ(DataTypeToString(RT_DATA_TYPE_INT8), "DATA_TYPE_INT8(4)");
    EXPECT_EQ(DataTypeToString(RT_DATA_TYPE_INT32), "DATA_TYPE_INT32(5)");
    EXPECT_EQ(DataTypeToString(RT_DATA_TYPE_BFP16), "DATA_TYPE_BFP16(6)");
    EXPECT_EQ(DataTypeToString(RT_DATA_TYPE_BFP32), "DATA_TYPE_BFP32(7)");
    EXPECT_EQ(DataTypeToString(RT_DATA_TYPE_UINT8), "DATA_TYPE_UINT8(8)");
    EXPECT_EQ(DataTypeToString(RT_DATA_TYPE_UINT16), "DATA_TYPE_UINT16(9)");
    EXPECT_EQ(DataTypeToString(RT_DATA_TYPE_UINT32), "DATA_TYPE_UINT32(10)");
    EXPECT_EQ(DataTypeToString(RT_DATA_TYPE_END), "DATA_TYPE_END(11)");

    EXPECT_EQ(MemInfoTypeToString(RT_MEMORYINFO_DDR), "MEMORYINFO_DDR(0)");
    EXPECT_EQ(MemInfoTypeToString(RT_MEMORYINFO_HBM), "MEMORYINFO_HBM(1)");
    EXPECT_EQ(MemInfoTypeToString(RT_MEMORYINFO_DDR_HUGE), "MEMORYINFO_DDR_HUGE(2)");
    EXPECT_EQ(MemInfoTypeToString(RT_MEMORYINFO_DDR_NORMAL), "MEMORYINFO_DDR_NORMAL(3)");
    EXPECT_EQ(MemInfoTypeToString(RT_MEMORYINFO_HBM_HUGE), "MEMORYINFO_HBM_HUGE(4)");
    EXPECT_EQ(MemInfoTypeToString(RT_MEMORYINFO_HBM_NORMAL), "MEMORYINFO_HBM_NORMAL(5)");
    EXPECT_EQ(MemInfoTypeToString(RT_MEMORYINFO_DDR_P2P_HUGE), "MEMORYINFO_DDR_P2P_HUGE(6)");
    EXPECT_EQ(MemInfoTypeToString(RT_MEMORYINFO_DDR_P2P_NORMAL), "MEMORYINFO_DDR_P2P_NORMAL(7)");
    EXPECT_EQ(MemInfoTypeToString(RT_MEMORYINFO_HBM_P2P_HUGE), "MEMORYINFO_HBM_P2P_HUGE(8)");
    EXPECT_EQ(MemInfoTypeToString(RT_MEMORYINFO_HBM_P2P_NORMAL), "MEMORYINFO_HBM_P2P_NORMAL(9)");
    EXPECT_EQ(MemInfoTypeToString(RT_MEMORYINFO_HBM_HUGE1G), "MEMORYINFO_HBM_HUGE1G(10)");
    EXPECT_EQ(MemInfoTypeToString(RT_MEMORYINFO_HBM_P2P_HUGE1G), "MEMORYINFO_HBM_P2P_HUGE1G(11)");
    EXPECT_EQ(MemInfoTypeToString(RT_MEMORYINFO_NORMAL), "MEMORYINFO_NORMAL(12)");
    EXPECT_EQ(MemInfoTypeToString(RT_MEMORYINFO_HUGE), "MEMORYINFO_HUGE(13)");
    EXPECT_EQ(MemInfoTypeToString(RT_MEMORYINFO_HUGE1G), "MEMORYINFO_HUGE1G(14)");
    EXPECT_EQ(MemInfoTypeToString(RT_MEMORYINFO_P2P_NORMAL), "MEMORYINFO_P2P_NORMAL(15)");
    EXPECT_EQ(MemInfoTypeToString(RT_MEMORYINFO_P2P_HUGE), "MEMORYINFO_P2P_HUGE(16)");
    EXPECT_EQ(MemInfoTypeToString(RT_MEMORYINFO_P2P_HUGE1G), "MEMORYINFO_P2P_HUGE1G(17)");

    EXPECT_STREQ(DrvMemHandleTypeToString(RT_MEM_HANDLE_TYPE_NONE), "MEM_HANDLE_TYPE_NONE(0)");
    EXPECT_STREQ(DrvMemHandleTypeToString(RT_MEM_HANDLE_TYPE_POSIX), "MEM_HANDLE_TYPE_POSIX(2)");
    EXPECT_STREQ(MemSharedHandleTypeToString(RT_MEM_SHARE_HANDLE_TYPE_DEFAULT), "MEM_SHARE_HANDLE_TYPE_DEFAULT(1)");
    EXPECT_STREQ(MemSharedHandleTypeToString(RT_MEM_SHARE_HANDLE_TYPE_FABRIC), "MEM_SHARE_HANDLE_TYPE_FABRIC(2)");
    EXPECT_STREQ(MallocAttrToString(RT_MEM_MALLOC_ATTR_RSV), "MEM_MALLOC_ATTR_RSV(0)");
    EXPECT_STREQ(MallocAttrToString(RT_MEM_MALLOC_ATTR_MODULE_ID), "MEM_MALLOC_ATTR_MODULE_ID(1)");
    EXPECT_STREQ(MallocAttrToString(RT_MEM_MALLOC_ATTR_DEVICE_ID), "MEM_MALLOC_ATTR_DEVICE_ID(2)");
    EXPECT_STREQ(MallocAttrToString(RT_MEM_MALLOC_ATTR_VA_FLAG), "MEM_MALLOC_ATTR_VA_FLAG(3)");
    EXPECT_STREQ(MallocAttrToString(RT_MEM_MALLOC_ATTR_MAX), "MEM_MALLOC_ATTR_MAX(4)");
    EXPECT_STREQ(FloatOverflowModeToString(RT_OVERFLOW_MODE_SATURATION), "OVERFLOW_MODE_SATURATION(0)");
    EXPECT_STREQ(FloatOverflowModeToString(RT_OVERFLOW_MODE_INFNAN), "OVERFLOW_MODE_INFNAN(1)");
    EXPECT_STREQ(FloatOverflowModeToString(RT_OVERFLOW_MODE_UNDEF), "OVERFLOW_MODE_UNDEF(2)");

    EXPECT_EQ(MemLocationTypeToString(RT_MEMORY_LOC_HOST), "MEMORY_LOC_HOST(0)");
    EXPECT_EQ(MemLocationTypeToString(RT_MEMORY_LOC_DEVICE), "MEMORY_LOC_DEVICE(1)");
    EXPECT_EQ(MemLocationTypeToString(RT_MEMORY_LOC_UNREGISTERED), "MEMORY_LOC_UNREGISTERED(2)");
    EXPECT_EQ(MemLocationTypeToString(RT_MEMORY_LOC_MANAGED), "MEMORY_LOC_MANAGED(3)");
    EXPECT_EQ(MemLocationTypeToString(RT_MEMORY_LOC_HOST_NUMA), "MEMORY_LOC_HOST_NUMA(4)");
    EXPECT_EQ(MemLocationTypeToString(RT_MEMORY_LOC_MAX), "MEMORY_LOC_MAX(5)");
    EXPECT_EQ(MemLocationTypeToString(static_cast<rtMemLocationType>(100)), "UNKNOWN(100)");
}

TEST(EnumToStringUtilsTest, CommonExecutionEnumsAllKnownValues)
{
    EXPECT_EQ(LimitTypeToString(RT_LIMIT_TYPE_LOW_POWER_TIMEOUT), "LIMIT_TYPE_LOW_POWER_TIMEOUT(0)");
    EXPECT_EQ(LimitTypeToString(RT_LIMIT_TYPE_SIMT_STACK_SIZE), "LIMIT_TYPE_SIMT_STACK_SIZE(1)");
    EXPECT_EQ(LimitTypeToString(RT_LIMIT_TYPE_SIMT_DVG_WARP_STACK_SIZE), "LIMIT_TYPE_SIMT_DVG_WARP_STACK_SIZE(2)");
    EXPECT_EQ(LimitTypeToString(RT_LIMIT_TYPE_STACK_SIZE), "LIMIT_TYPE_STACK_SIZE(3)");
    EXPECT_EQ(
        LimitTypeToString(RT_LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE),
        "LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE(4)");
    EXPECT_EQ(LimitTypeToString(RT_LIMIT_TYPE_SIMT_PRINTF_FIFO_SIZE), "LIMIT_TYPE_SIMT_PRINTF_FIFO_SIZE(5)");
    EXPECT_EQ(LimitTypeToString(RT_LIMIT_TYPE_RESERVED), "LIMIT_TYPE_RESERVED(6)");

    EXPECT_STREQ(DevResLimitTypeToString(RT_DEV_RES_CUBE_CORE), "DEV_RES_CUBE_CORE(0)");
    EXPECT_STREQ(DevResLimitTypeToString(RT_DEV_RES_VECTOR_CORE), "DEV_RES_VECTOR_CORE(1)");
    EXPECT_STREQ(DevResLimitTypeToString(RT_DEV_RES_TYPE_MAX), "DEV_RES_TYPE_MAX(2)");
    EXPECT_EQ(ConditionToString(RT_EQUAL), "EQUAL(0)");
    EXPECT_EQ(ConditionToString(RT_NOT_EQUAL), "NOT_EQUAL(1)");
    EXPECT_EQ(ConditionToString(RT_GREATER), "GREATER(2)");
    EXPECT_EQ(ConditionToString(RT_GREATER_OR_EQUAL), "GREATER_OR_EQUAL(3)");
    EXPECT_EQ(ConditionToString(RT_LESS), "LESS(4)");
    EXPECT_EQ(ConditionToString(RT_LESS_OR_EQUAL), "LESS_OR_EQUAL(5)");

    EXPECT_EQ(KernelAttrTypeToString(RT_KERNEL_ATTR_TYPE_AICORE), "KERNEL_ATTR_TYPE_AICORE(0)");
    EXPECT_EQ(KernelAttrTypeToString(RT_KERNEL_ATTR_TYPE_CUBE), "KERNEL_ATTR_TYPE_CUBE(1)");
    EXPECT_EQ(KernelAttrTypeToString(RT_KERNEL_ATTR_TYPE_VECTOR), "KERNEL_ATTR_TYPE_VECTOR(2)");
    EXPECT_EQ(KernelAttrTypeToString(RT_KERNEL_ATTR_TYPE_MIX), "KERNEL_ATTR_TYPE_MIX(3)");
    EXPECT_EQ(KernelAttrTypeToString(RT_KERNEL_ATTR_TYPE_AICPU), "KERNEL_ATTR_TYPE_AICPU(100)");

    EXPECT_EQ(LaunchKernelAttrIdToString(RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE), "LAUNCH_KERNEL_ATTR_SCHEM_MODE(1)");
    EXPECT_EQ(LaunchKernelAttrIdToString(RT_LAUNCH_KERNEL_ATTR_DYN_UBUF_SIZE), "LAUNCH_KERNEL_ATTR_DYN_UBUF_SIZE(2)");
    EXPECT_EQ(LaunchKernelAttrIdToString(RT_LAUNCH_KERNEL_ATTR_ENGINE_TYPE), "LAUNCH_KERNEL_ATTR_ENGINE_TYPE(3)");
    EXPECT_EQ(
        LaunchKernelAttrIdToString(RT_LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET), "LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET(4)");
    EXPECT_EQ(
        LaunchKernelAttrIdToString(RT_LAUNCH_KERNEL_ATTR_BLOCK_TASK_PREFETCH),
        "LAUNCH_KERNEL_ATTR_BLOCK_TASK_PREFETCH(5)");
    EXPECT_EQ(LaunchKernelAttrIdToString(RT_LAUNCH_KERNEL_ATTR_DATA_DUMP), "LAUNCH_KERNEL_ATTR_DATA_DUMP(6)");
    EXPECT_EQ(LaunchKernelAttrIdToString(RT_LAUNCH_KERNEL_ATTR_TIMEOUT), "LAUNCH_KERNEL_ATTR_TIMEOUT(7)");
    EXPECT_EQ(LaunchKernelAttrIdToString(RT_LAUNCH_KERNEL_ATTR_TIMEOUT_US), "LAUNCH_KERNEL_ATTR_TIMEOUT_US(8)");
    EXPECT_EQ(LaunchKernelAttrIdToString(RT_LAUNCH_KERNEL_ATTR_MAX), "LAUNCH_KERNEL_ATTR_MAX(9)");

    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_AICPU_CORE_NUM), "DEV_ATTR_AICPU_CORE_NUM(1)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_AICORE_CORE_NUM), "DEV_ATTR_AICORE_CORE_NUM(101)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_CUBE_CORE_NUM), "DEV_ATTR_CUBE_CORE_NUM(102)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_VECTOR_CORE_NUM), "DEV_ATTR_VECTOR_CORE_NUM(201)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_WARP_SIZE), "DEV_ATTR_WARP_SIZE(202)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_MAX_THREAD_PER_VECTOR_CORE), "DEV_ATTR_MAX_THREAD_PER_VECTOR_CORE(203)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_UBUF_PER_VECTOR_CORE), "DEV_ATTR_UBUF_PER_VECTOR_CORE(204)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_MAX_GRID_DIM_X), "DEV_ATTR_MAX_GRID_DIM_X(205)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_MAX_GRID_DIM_Y), "DEV_ATTR_MAX_GRID_DIM_Y(206)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_MAX_GRID_DIM_Z), "DEV_ATTR_MAX_GRID_DIM_Z(207)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_MAX_BLOCK_PER_GRID), "DEV_ATTR_MAX_BLOCK_PER_GRID(208)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_MAX_THREADS_PER_BLOCK), "DEV_ATTR_MAX_THREADS_PER_BLOCK(209)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_MAX_BLOCK_DIM_X), "DEV_ATTR_MAX_BLOCK_DIM_X(210)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_MAX_BLOCK_DIM_Y), "DEV_ATTR_MAX_BLOCK_DIM_Y(211)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_MAX_BLOCK_DIM_Z), "DEV_ATTR_MAX_BLOCK_DIM_Z(212)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_TOTAL_GLOBAL_MEM_SIZE), "DEV_ATTR_TOTAL_GLOBAL_MEM_SIZE(301)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_L2_CACHE_SIZE), "DEV_ATTR_L2_CACHE_SIZE(302)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_SMP_ID), "DEV_ATTR_SMP_ID(401)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_PHY_CHIP_ID), "DEV_ATTR_PHY_CHIP_ID(402)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_SUPER_POD_DEVICE_ID), "DEV_ATTR_SUPER_POD_DEVICE_ID(403)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_SUPER_POD_SERVER_ID), "DEV_ATTR_SUPER_POD_SERVER_ID(404)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_SUPER_POD_ID), "DEV_ATTR_SUPER_POD_ID(405)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_CUST_OP_PRIVILEGE), "DEV_ATTR_CUST_OP_PRIVILEGE(406)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_MAINBOARD_ID), "DEV_ATTR_MAINBOARD_ID(407)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_HD_CONNECT_TYPE), "DEV_ATTR_HD_CONNECT_TYPE(408)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_DEVICE_FORM_FACTOR), "DEV_ATTR_DEVICE_FORM_FACTOR(409)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_IS_VIRTUAL), "DEV_ATTR_IS_VIRTUAL(501)");
    EXPECT_STREQ(DevAttrToString(RT_DEV_ATTR_NPU_ARCH), "DEV_ATTR_NPU_ARCH(601)");

    EXPECT_EQ(HacTypeToString(RT_HAC_TYPE_STARS), "HAC_TYPE_STARS(0)");
    EXPECT_EQ(HacTypeToString(RT_HAC_TYPE_AICPU), "HAC_TYPE_AICPU(1)");
    EXPECT_EQ(HacTypeToString(RT_HAC_TYPE_AIC), "HAC_TYPE_AIC(2)");
    EXPECT_EQ(HacTypeToString(RT_HAC_TYPE_AIV), "HAC_TYPE_AIV(3)");
    EXPECT_EQ(HacTypeToString(RT_HAC_TYPE_PCIEDMA), "HAC_TYPE_PCIEDMA(4)");
    EXPECT_EQ(HacTypeToString(RT_HAC_TYPE_RDMA), "HAC_TYPE_RDMA(5)");
    EXPECT_EQ(HacTypeToString(RT_HAC_TYPE_SDMA), "HAC_TYPE_SDMA(6)");
    EXPECT_EQ(HacTypeToString(RT_HAC_TYPE_DVPP), "HAC_TYPE_DVPP(7)");
    EXPECT_EQ(HacTypeToString(RT_HAC_TYPE_UDMA), "HAC_TYPE_UDMA(8)");
    EXPECT_EQ(HacTypeToString(RT_HAC_TYPE_CCU), "HAC_TYPE_CCU(9)");
    EXPECT_EQ(HacTypeToString(RT_HAC_TYPE_MAX), "HAC_TYPE_MAX(10)");
    EXPECT_EQ(DeviceStatusToString(RT_DEVICE_STATUS_NORMAL), "DEVICE_STATUS_NORMAL(0)");
    EXPECT_EQ(DeviceStatusToString(RT_DEVICE_STATUS_ABNORMAL), "DEVICE_STATUS_ABNORMAL(1)");
    EXPECT_EQ(DeviceStatusToString(RT_DEVICE_STATUS_END), "DEVICE_STATUS_END(65535)");
    EXPECT_EQ(TaskTypeToString(RT_TASK_DEFAULT), "TASK_DEFAULT(0)");
    EXPECT_EQ(TaskTypeToString(RT_TASK_KERNEL), "TASK_KERNEL(1)");
    EXPECT_EQ(TaskTypeToString(RT_TASK_EVENT_RECORD), "TASK_EVENT_RECORD(2)");
    EXPECT_EQ(TaskTypeToString(RT_TASK_EVENT_WAIT), "TASK_EVENT_WAIT(3)");
    EXPECT_EQ(TaskTypeToString(RT_TASK_EVENT_RESET), "TASK_EVENT_RESET(4)");
    EXPECT_EQ(TaskTypeToString(RT_TASK_VALUE_WRITE), "TASK_VALUE_WRITE(5)");
    EXPECT_EQ(TaskTypeToString(RT_TASK_VALUE_WAIT), "TASK_VALUE_WAIT(6)");
}

TEST(EnumToStringUtilsTest, CommonApiEnumsAllKnownValues)
{
    EXPECT_STREQ(MemcpyKindToStr(RT_MEMCPY_HOST_TO_HOST), "MEMCPY_HOST_TO_HOST(0)");
    EXPECT_STREQ(MemcpyKindToStr(RT_MEMCPY_HOST_TO_DEVICE), "MEMCPY_HOST_TO_DEVICE(1)");
    EXPECT_STREQ(MemcpyKindToStr(RT_MEMCPY_DEVICE_TO_HOST), "MEMCPY_DEVICE_TO_HOST(2)");
    EXPECT_STREQ(MemcpyKindToStr(RT_MEMCPY_DEVICE_TO_DEVICE), "MEMCPY_DEVICE_TO_DEVICE(3)");
    EXPECT_STREQ(MemcpyKindToStr(RT_MEMCPY_MANAGED), "MEMCPY_MANAGED(4)");
    EXPECT_STREQ(MemcpyKindToStr(RT_MEMCPY_ADDR_DEVICE_TO_DEVICE), "MEMCPY_ADDR_DEVICE_TO_DEVICE(5)");
    EXPECT_STREQ(MemcpyKindToStr(RT_MEMCPY_HOST_TO_DEVICE_EX), "MEMCPY_HOST_TO_DEVICE_EX(6)");
    EXPECT_STREQ(MemcpyKindToStr(RT_MEMCPY_DEVICE_TO_HOST_EX), "MEMCPY_DEVICE_TO_HOST_EX(7)");
    EXPECT_STREQ(MemcpyKindToStr(RT_MEMCPY_DEFAULT), "MEMCPY_DEFAULT(8)");
    EXPECT_STREQ(MemcpyKindToStr(RT_MEMCPY_RESERVED), "MEMCPY_RESERVED(9)");

    EXPECT_EQ(MemcpyNewKindToString(RT_MEMCPY_KIND_HOST_TO_HOST), "MEMCPY_KIND_HOST_TO_HOST(0)");
    EXPECT_EQ(MemcpyNewKindToString(RT_MEMCPY_KIND_HOST_TO_DEVICE), "MEMCPY_KIND_HOST_TO_DEVICE(1)");
    EXPECT_EQ(MemcpyNewKindToString(RT_MEMCPY_KIND_DEVICE_TO_HOST), "MEMCPY_KIND_DEVICE_TO_HOST(2)");
    EXPECT_EQ(MemcpyNewKindToString(RT_MEMCPY_KIND_DEVICE_TO_DEVICE), "MEMCPY_KIND_DEVICE_TO_DEVICE(3)");
    EXPECT_EQ(MemcpyNewKindToString(RT_MEMCPY_KIND_DEFAULT), "MEMCPY_KIND_DEFAULT(4)");
    EXPECT_EQ(MemcpyNewKindToString(RT_MEMCPY_KIND_HOST_TO_BUF_TO_DEVICE), "MEMCPY_KIND_HOST_TO_BUF_TO_DEVICE(5)");
    EXPECT_EQ(MemcpyNewKindToString(RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE), "MEMCPY_KIND_INNER_DEVICE_TO_DEVICE(6)");
    EXPECT_EQ(MemcpyNewKindToString(RT_MEMCPY_KIND_INTER_DEVICE_TO_DEVICE), "MEMCPY_KIND_INTER_DEVICE_TO_DEVICE(7)");
    EXPECT_EQ(MemcpyNewKindToString(RT_MEMCPY_KIND_MAX), "MEMCPY_KIND_MAX(8)");

    EXPECT_EQ(CmoOpCodeToString(RT_CMO_PREFETCH), "CMO_PREFETCH(6)");
    EXPECT_EQ(CmoOpCodeToString(RT_CMO_WRITEBACK), "CMO_WRITEBACK(7)");
    EXPECT_EQ(CmoOpCodeToString(RT_CMO_INVALID), "CMO_INVALID(8)");
    EXPECT_EQ(CmoOpCodeToString(RT_CMO_FLUSH), "CMO_FLUSH(9)");
    EXPECT_EQ(CmoOpCodeToString(RT_CMO_RESERVED), "CMO_RESERVED(10)");
    EXPECT_EQ(SysParamOptToString(SYS_OPT_DETERMINISTIC), "SYS_OPT_DETERMINISTIC(0)");
    EXPECT_EQ(SysParamOptToString(SYS_OPT_ENABLE_DEBUG_KERNEL), "SYS_OPT_ENABLE_DEBUG_KERNEL(1)");
    EXPECT_EQ(SysParamOptToString(SYS_OPT_STRONG_CONSISTENCY), "SYS_OPT_STRONG_CONSISTENCY(2)");
    EXPECT_EQ(SysParamOptToString(SYS_OPT_RESERVED), "SYS_OPT_RESERVED(3)");
}

TEST(EnumToStringUtilsTest, CommonOptionalEnumsAllKnownValues)
{
    EXPECT_EQ(ManagedMemLocationTypeToString(rtMemLocationTypeInvalid), "MEM_LOCATION_TYPE_INVALID(0)");
    EXPECT_EQ(ManagedMemLocationTypeToString(rtMemLocationTypeDevice), "MEM_LOCATION_TYPE_DEVICE(1)");
    EXPECT_EQ(ManagedMemLocationTypeToString(rtMemLocationTypeHost), "MEM_LOCATION_TYPE_HOST(2)");
    EXPECT_EQ(ManagedMemLocationTypeToString(rtMemLocationTypeHostNuma), "MEM_LOCATION_TYPE_HOST_NUMA(3)");
    EXPECT_EQ(
        ManagedMemLocationTypeToString(rtMemLocationTypeHostNumaCurrent), "MEM_LOCATION_TYPE_HOST_NUMA_CURRENT(4)");

    EXPECT_EQ(MemPoolAttrToString(rtMemPoolReuseFollowEventDependencies), "rtMemPoolReuseFollowEventDependencies(1)");
    EXPECT_EQ(MemPoolAttrToString(rtMemPoolReuseAllowOpportunistic), "rtMemPoolReuseAllowOpportunistic(2)");
    EXPECT_EQ(
        MemPoolAttrToString(rtMemPoolReuseAllowInternalDependencies), "rtMemPoolReuseAllowInternalDependencies(3)");
    EXPECT_EQ(MemPoolAttrToString(rtMemPoolAttrReleaseThreshold), "rtMemPoolAttrReleaseThreshold(4)");
    EXPECT_EQ(MemPoolAttrToString(rtMemPoolAttrReservedMemCurrent), "rtMemPoolAttrReservedMemCurrent(5)");
    EXPECT_EQ(MemPoolAttrToString(rtMemPoolAttrReservedMemHigh), "rtMemPoolAttrReservedMemHigh(6)");
    EXPECT_EQ(MemPoolAttrToString(rtMemPoolAttrUsedMemCurrent), "rtMemPoolAttrUsedMemCurrent(7)");
    EXPECT_EQ(MemPoolAttrToString(rtMemPoolAttrUsedMemHigh), "rtMemPoolAttrUsedMemHigh(8)");

    EXPECT_EQ(StreamCaptureStatusToString(RT_STREAM_CAPTURE_STATUS_NONE), "STREAM_CAPTURE_STATUS_NONE(0)");
    EXPECT_EQ(StreamCaptureStatusToString(RT_STREAM_CAPTURE_STATUS_ACTIVE), "STREAM_CAPTURE_STATUS_ACTIVE(1)");
    EXPECT_EQ(
        StreamCaptureStatusToString(RT_STREAM_CAPTURE_STATUS_INVALIDATED), "STREAM_CAPTURE_STATUS_INVALIDATED(2)");
    EXPECT_EQ(StreamCaptureStatusToString(RT_STREAM_CAPTURE_STATUS_MAX), "STREAM_CAPTURE_STATUS_MAX(3)");
}
