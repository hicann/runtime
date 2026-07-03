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

TEST(EnumToStringUtilsTest, InfoTypeToStringUnknownValue)
{
    EXPECT_EQ(InfoTypeToString(100U), "UNKNOWN(100)");
}

TEST(EnumToStringUtilsTest, ModuleTypeToStringKnownValue)
{
    EXPECT_EQ(ModuleTypeToString(RT_MODULE_TYPE_MEMORY), "MEMORY(10)");
}

TEST(EnumToStringUtilsTest, ModuleTypeToStringUnknownValue)
{
    EXPECT_EQ(ModuleTypeToString(-1), "UNKNOWN(-1)");
}

TEST(EnumToStringUtilsTest, MemcpyKindToStringKnownValue)
{
    EXPECT_EQ(MemcpyKindToString(RT_MEMCPY_HOST_TO_HOST), "MEMCPY_HOST_TO_HOST(0)");
    EXPECT_EQ(MemcpyKindToString(RT_MEMCPY_DEFAULT), "MEMCPY_DEFAULT(8)");
}

TEST(EnumToStringUtilsTest, MemcpyKindToStringUnknownValue)
{
    EXPECT_EQ(MemcpyKindToString(static_cast<rtMemcpyKind_t>(100)), "UNKNOWN(100)");
}

TEST(EnumToStringUtilsTest, MemcpyNewKindToStringKnownValue)
{
    EXPECT_EQ(MemcpyNewKindToString(RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE),
        "MEMCPY_KIND_INNER_DEVICE_TO_DEVICE(6)");
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
    EXPECT_EQ(NotifyFlagToString(static_cast<uint32_t>(RT_NOTIFY_FLAG_SHR_ID_SHADOW)),
        "NOTIFY_FLAG_SHR_ID_SHADOW(64)");
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
    EXPECT_EQ(CaptureEventModeToString(static_cast<uint8_t>(CaptureEventModeType::HARDWARE_MODE)),
        "HARDWARE_MODE(1)");
}

TEST(EnumToStringUtilsTest, DevFeatureTypeToStringKnownValue)
{
    EXPECT_EQ(DevFeatureTypeToString(RT_FEATURE_SYSTEM_TASKID_BIT_WIDTH),
        "FEATURE_SYSTEM_TASKID_BIT_WIDTH(20001)");
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

TEST(EnumToStringUtilsTest, StreamTypeToStringUnknownValue)
{
    EXPECT_EQ(StreamTypeToString(999), "UNKNOWN(999)");
}

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
}

TEST(EnumToStringUtilsTest, RandomNumDataTypeToStringUnknownValue)
{
    EXPECT_EQ(RandomNumDataTypeToString(static_cast<rtRandomNumDataType>(100)), "UNKNOWN(100)");
}

TEST(EnumToStringUtilsTest, RandomNumFuncTypeToStringKnownValue)
{
    EXPECT_EQ(RandomNumFuncTypeToString(RT_RANDOM_NUM_FUNC_TYPE_DROPOUT_BITMASK), "RANDOM_NUM_FUNC_TYPE_DROPOUT_BITMASK(0)");
    EXPECT_EQ(RandomNumFuncTypeToString(RT_RANDOM_NUM_FUNC_TYPE_TRUNCATED_NORMAL_DIS), "RANDOM_NUM_FUNC_TYPE_TRUNCATED_NORMAL_DIS(3)");
}

TEST(EnumToStringUtilsTest, RandomNumFuncTypeToStringUnknownValue)
{
    EXPECT_EQ(RandomNumFuncTypeToString(static_cast<rtRandomNumFuncType>(100)), "UNKNOWN(100)");
}
