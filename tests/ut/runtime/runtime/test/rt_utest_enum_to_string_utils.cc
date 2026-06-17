/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "common/enum_to_string_utils.hpp"

#include "gtest/gtest.h"

using namespace cce::runtime;

TEST(EnumToStringUtilsTest, ReturnExpectedTextForKnownEnumValues)
{
    EXPECT_EQ(ReduceKindToString(RT_MEMCPY_SDMA_AUTOMATIC_ADD), "SDMA_AUTOMATIC_ADD(10)");
    EXPECT_EQ(DataTypeToString(RT_DATA_TYPE_FP32), "FP32(0)");
    EXPECT_EQ(CaptureModelStatusToString(RtCaptureModelStatus::READY), "READY(5)");
    EXPECT_EQ(StreamCaptureModeToString(RT_STREAM_CAPTURE_MODE_RELAXED), "RELAXED(2)");
    EXPECT_EQ(KernelFlagToString(RT_KERNEL_CUSTOM_AICPU), "RT_KERNEL_CUSTOM_AICPU(8)");
    EXPECT_EQ(NotifyFlagToString(static_cast<uint32_t>(RT_NOTIFY_FLAG_SHR_ID_SHADOW)),
        "RT_NOTIFY_FLAG_SHR_ID_SHADOW(64)");
    EXPECT_EQ(RecordModeToString(RECORD_CLEAR_BIT_MODE), "RECORD_CLEAR_BIT_MODE(4)");
    EXPECT_EQ(WaitModeToString(WAIT_BITMAP_MODE), "WAIT_BITMAP_MODE(4)");
    EXPECT_EQ(CaptureEventModeToString(static_cast<uint8_t>(CaptureEventModeType::HARDWARE_MODE)),
        "HARDWARE_MODE(1)");
    EXPECT_EQ(InfoTypeToString(cce::runtime::INFO_TYPE_UTILIZATION), "UTILIZATION(23)");
    EXPECT_EQ(ModuleTypeToString(RT_MODULE_TYPE_MEMORY), "MEMORY(10)");
    EXPECT_EQ(DevResTypeToString(RT_RES_TYPE_STARS_CNT_NOTIFY_ADD), "STARS_CNT_NOTIFY_ADD(6)");
    EXPECT_EQ(DevResProcTypeToString(RT_PROCESS_USER), "USER(5)");
    EXPECT_EQ(UbDevQueryCmdToString(QUERY_TYPE_BUFF), "QUERY_TYPE_BUFF(1)");
    EXPECT_EQ(DeviceStateCallbackToString(DeviceStateCallback::RTS_DEVICE_STATE_CALLBACK),
        "RTS_DEVICE_STATE_CALLBACK(1)");
    EXPECT_EQ(LastErrLevelToString(RT_CONTEXT_LEVEL), "RT_CONTEXT_LEVEL(1)");
    EXPECT_EQ(TaskBuffTypeToString(PARAM_TASK_INFO_DESC), "PARAM_TASK_INFO_DESC(2)");
    EXPECT_EQ(MemcpyKindToString(RT_MEMCPY_DEFAULT), "RT_MEMCPY_DEFAULT(8)");
    EXPECT_EQ(MemcpyNewKindToString(RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE),
        "RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE(6)");
    EXPECT_EQ(WriteValueSizeTypeToString(WRITE_VALUE_SIZE_TYPE_BUFF), "WRITE_VALUE_SIZE_TYPE_BUFF(7)");
    EXPECT_EQ(CondHandleFlagToString(RT_COND_HANDLE_ASSIGN_DEFAULT), "RT_COND_HANDLE_ASSIGN_DEFAULT(1)");
    EXPECT_EQ(CondTaskTypeToString(RT_COND_TASK_TYPE_SWITCH), "RT_COND_TASK_TYPE_SWITCH(2)");
    EXPECT_EQ(DevFeatureTypeToString(RT_FEATURE_SYSTEM_TASKID_BIT_WIDTH),
        "RT_FEATURE_SYSTEM_TASKID_BIT_WIDTH(20001)");
}

TEST(EnumToStringUtilsTest, ReturnUnknownTextForUnexpectedEnumValues)
{
    EXPECT_EQ(ReduceKindToString(static_cast<rtRecudeKind_t>(100)), "UNKNOWN(100)");
    EXPECT_EQ(DataTypeToString(static_cast<rtDataType_t>(100)), "UNKNOWN(100)");
    EXPECT_EQ(CaptureModelStatusToString(static_cast<RtCaptureModelStatus>(100)), "UNKNOWN(100)");
    EXPECT_EQ(StreamCaptureModeToString(static_cast<rtStreamCaptureMode>(100)), "UNKNOWN(100)");
    EXPECT_EQ(KernelFlagToString(1024U), "UNKNOWN(1024)");
    EXPECT_EQ(NotifyFlagToString(2U), "UNKNOWN(2)");
    EXPECT_EQ(RecordModeToString(static_cast<rtCntNotifyRecordMode_t>(100)), "UNKNOWN(100)");
    EXPECT_EQ(WaitModeToString(static_cast<rtCntNotifyWaitMode_t>(100)), "UNKNOWN(100)");
    EXPECT_EQ(CaptureEventModeToString(static_cast<uint8_t>(255U)), "UNKNOWN(255)");
    EXPECT_EQ(InfoTypeToString(100U), "UNKNOWN(100)");
    EXPECT_EQ(ModuleTypeToString(-1), "UNKNOWN(-1)");
    EXPECT_EQ(DevResTypeToString(static_cast<rtDevResType_t>(100)), "UNKNOWN(100)");
    EXPECT_EQ(DevResProcTypeToString(static_cast<rtDevResProcType_t>(100)), "UNKNOWN(100)");
    EXPECT_EQ(UbDevQueryCmdToString(static_cast<rtUbDevQueryCmd>(100)), "UNKNOWN(100)");
    EXPECT_EQ(DeviceStateCallbackToString(static_cast<DeviceStateCallback>(100)), "UNKNOWN(100)");
    EXPECT_EQ(LastErrLevelToString(static_cast<rtLastErrLevel_t>(100)), "UNKNOWN(100)");
    EXPECT_EQ(TaskBuffTypeToString(static_cast<rtTaskBuffType_t>(100)), "UNKNOWN(100)");
    EXPECT_EQ(MemcpyKindToString(static_cast<rtMemcpyKind_t>(100)), "UNKNOWN(100)");
    EXPECT_EQ(MemcpyNewKindToString(static_cast<rtMemcpyKind>(100)), "UNKNOWN(100)");
    EXPECT_EQ(WriteValueSizeTypeToString(static_cast<rtWriteValueSizeType_t>(100)), "UNKNOWN(100)");
    EXPECT_EQ(CondHandleFlagToString(static_cast<rtCondHandleFlag_t>(100)), "UNKNOWN(100)");
    EXPECT_EQ(CondTaskTypeToString(static_cast<rtCondTaskType_t>(100)), "UNKNOWN(100)");
    EXPECT_EQ(DevFeatureTypeToString(-1), "UNKNOWN(-1)");
}

TEST(EnumToStringUtilsTest, ReturnExpectedTextForFlagValues)
{
    constexpr uint32_t unknownStreamFlag = 0x100000U;
    constexpr uint64_t unknownEventFlag = 0x100U;

    EXPECT_EQ(StreamFlagsToString(0U), "RT_STREAM_DEFAULT(0x0)");
    EXPECT_EQ(StreamFlagsToString(RT_STREAM_FAST_LAUNCH | RT_STREAM_FAST_SYNC),
        "RT_STREAM_FAST_LAUNCH(0x200)|RT_STREAM_FAST_SYNC(0x400)");
    EXPECT_EQ(StreamFlagsToString(RT_STREAM_AICPU | unknownStreamFlag),
        "RT_STREAM_AICPU(0x8)|UNKNOWN(0x100000)");

    EXPECT_EQ(EventFlagsToString(0U), "UNKNOWN(0x0)");
    EXPECT_EQ(EventFlagsToString(RT_EVENT_DEFAULT),
        "RT_EVENT_STREAM_MARK(0x2)|RT_EVENT_DDSYNC(0x4)|RT_EVENT_TIME_LINE(0x8)");
    EXPECT_EQ(EventFlagsToString(RT_EVENT_IPC | unknownEventFlag), "RT_EVENT_IPC(0x40)|UNKNOWN(0x100)");
}
