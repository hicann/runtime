/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#define protected public
#define private public
#include "base.hpp"
#include "raw_device.hpp"
#include "device_error_proc.hpp"
#include "device_msg_handler.hpp"
#include "ctrl_sq.hpp"
#include "ctrl_res_pool.hpp"
#include "memory_pool_manager.hpp"
#undef protected
#undef private
#include "runtime/rt.h"

using namespace cce::runtime;

class Arch5162DeviceTest : public testing::Test {
protected:
    static void SetUpTestCase() { std::cout << "Arch5162DeviceTest test start" << std::endl; }

    static void TearDownTestCase() { std::cout << "Arch5162DeviceTest test end" << std::endl; }

    void SetUp() override {}

    void TearDown() override { GlobalMockObject::verify(); }
};

TEST_F(Arch5162DeviceTest, CtrlSQStub_NotSupport)
{
    Device* dev = nullptr;
    CtrlSQ ctrlSq(dev);
    EXPECT_EQ(ctrlSq.Setup(), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(ctrlSq.SendStreamClearMsg(nullptr, RT_STREAM_CLEAR), RT_ERROR_FEATURE_NOT_SUPPORT);
    RtMaintainceParam maintenanceParam = {};
    TaskInfo* task = nullptr;
    EXPECT_EQ(ctrlSq.SendStreamRecycleMsg(maintenanceParam, task), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(ctrlSq.SendNotifyResetMsg(0U), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(ctrlSq.SendModelUnbindMsg(nullptr, nullptr, false), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(ctrlSq.SendModelUnbindMsgOnly(nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(ctrlSq.SendModelBindMsg(nullptr, nullptr, 0U), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(ctrlSq.SendModelBindMsgOnly(nullptr, nullptr, 0U), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(ctrlSq.SendModelAbortMsg(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(ctrlSq.SendModelLoadCompleteMsg(nullptr, 0U), RT_ERROR_FEATURE_NOT_SUPPORT);
    RtAicpuModelParam aicpuModelParam = {};
    EXPECT_EQ(
        ctrlSq.SendAicpuModelMsg(RtCtrlMsgType::RT_CTRL_MSG_AICPU_MODEL_DESTROY, aicpuModelParam),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    RtDataDumpLoadInfoParam datadumpLoadInfoParam = {};
    EXPECT_EQ(
        ctrlSq.SendDataDumpLoadInfoMsg(RtCtrlMsgType::RT_CTRL_MSG_DATADUMP_INFOLOAD, datadumpLoadInfoParam),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    RtAicpuInfoLoadParam aicpuInfoLoadParam = {};
    EXPECT_EQ(
        ctrlSq.SendAicpuInfoLoadMsg(RtCtrlMsgType::RT_CTRL_MSG_AICPU_INFOLOAD, aicpuInfoLoadParam),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    RtDebugRegisterParam debugRegisterParam = {};
    uint32_t flipTaskId = 0U;
    EXPECT_EQ(
        ctrlSq.SendDebugRegisterMsg(RtCtrlMsgType::RT_CTRL_MSG_DEBUG_REGISTER, debugRegisterParam, &flipTaskId),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    RtDebugUnRegisterParam debugUnRegisterParam = {};
    EXPECT_EQ(
        ctrlSq.SendDebugUnRegisterMsg(RtCtrlMsgType::RT_CTRL_MSG_DEBUG_UNREGISTER, debugUnRegisterParam),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    RtOverflowSwitchSetParam overflowSwitchSetParam = {};
    EXPECT_EQ(
        ctrlSq.SendOverflowSwitchSetMsg(
            RtCtrlMsgType::RT_CTRL_MSG_SET_OVERFLOW_SWITCH, overflowSwitchSetParam, &flipTaskId),
        RT_ERROR_FEATURE_NOT_SUPPORT);
    RtSetStreamTagParam setStreamTagParam = {};
    EXPECT_EQ(
        ctrlSq.SendSetStreamTagMsg(RtCtrlMsgType::RT_CTRL_MSG_SET_STREAM_TAG, setStreamTagParam, &flipTaskId),
        RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(Arch5162DeviceTest, DeviceErrorProcStub_NotSupport)
{
    Device* dev = nullptr;
    DeviceErrorProc errProc(dev, 0U);
    EXPECT_EQ(errProc.CreateDeviceRingBufferAndSendTask(), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(errProc.CreateFastRingbuffer(), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(errProc.RingBufferRestore(), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(errProc.SendTaskToStopUseRingBuffer(), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(errProc.DestroyDeviceRingBuffer(), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(errProc.ProcErrorInfo(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    uint16_t errorStreamId = 0U;
    EXPECT_EQ(errProc.ReportRingBuffer(&errorStreamId), RT_ERROR_FEATURE_NOT_SUPPORT);
    errProc.ProcessReportFastRingBuffer();
    EXPECT_EQ(errProc.ProcCleanRingbuffer(), RT_ERROR_FEATURE_NOT_SUPPORT);
    errProc.ProcClearFastRingBuffer();
    errProc.ProduceProcNum();
    EXPECT_EQ(errProc.GetQosInfoFromRingbuffer(), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(errProc.IsPrintStreamTimeoutSnapshot(), false);
    EXPECT_EQ(errProc.PrintStreamTimeoutSnapshotInfo(), RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(Arch5162DeviceTest, DeviceErrorCoreProcStub_NotSupport)
{
    EXPECT_EQ(HasMteErr(nullptr), false);
    EXPECT_EQ(HasBlacklistEventOnDevice(0U, {}), false);
    EXPECT_EQ(HasMemUceErr(nullptr, {}), false);
    uint32_t eventCount = 10U;
    rtDmsFaultEvent faultEvent = {};
    EXPECT_EQ(GetDeviceFaultEvents(0U, &faultEvent, eventCount, false), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(eventCount, 0U);
    ProcessSdmaError(nullptr);
}

TEST_F(Arch5162DeviceTest, DeviceMsgHandlerStub_NotSupport)
{
    DeviceStreamSnapshotHandler handler(nullptr, nullptr);
    EXPECT_EQ(handler.Init(), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(handler.HandleMsgInHostBuf(nullptr, 0U), RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(Arch5162DeviceTest, GroupDeviceStub_NotSupport)
{
    RawDevice* device = new RawDevice(0);
    EXPECT_EQ(device->GroupInfoSetup(), RT_ERROR_FEATURE_NOT_SUPPORT);
    rtGroupInfo_t groupInfo = {};
    EXPECT_EQ(device->GetGroupInfo(0, &groupInfo, 1U), RT_ERROR_FEATURE_NOT_SUPPORT);
    uint32_t cnt = 10U;
    EXPECT_EQ(device->GetGroupCount(&cnt), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(cnt, 0U);
    EXPECT_EQ(device->GetGroupCount(nullptr), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(device->SetGroup(0), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(device->ResetGroup(), RT_ERROR_FEATURE_NOT_SUPPORT);
    delete device;
}

TEST_F(Arch5162DeviceTest, CtrlResEntryStub_NotSupport)
{
    CtrlResEntry ctrlRes;
    EXPECT_EQ(ctrlRes.Init(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    uint32_t taskId = 0U;
    ctrlRes.AllocTaskId(taskId);
    EXPECT_EQ(taskId, CTRL_INVALID_TASK_ID);
    ctrlRes.RecycleTask(0U);
    EXPECT_EQ(ctrlRes.GetTask(0U), nullptr);
    ctrlRes.TryTaskReclaim(nullptr);
    ctrlRes.TearDown();
}

TEST_F(Arch5162DeviceTest, CtrlTaskPoolEntryStub_NotSupport)
{
    CtrlTaskPoolEntry entry;
    EXPECT_EQ(entry.Alloc(nullptr, 0U, TS_TASK_TYPE_KERNEL_AICORE), nullptr);
}

TEST_F(Arch5162DeviceTest, MemoryPoolManagerStub_NotSupport)
{
    MemoryPoolManager poolMng(nullptr, 0);
    EXPECT_EQ(poolMng.Init(), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(poolMng.Allocate(0U, false), nullptr);
    EXPECT_EQ(poolMng.TryRelease(nullptr, 0U), false);
    PoolMemInfo info = poolMng.GetPoolMemInfo(nullptr);
    EXPECT_EQ(info.found, false);
}
