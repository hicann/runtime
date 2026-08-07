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
#include "tsd.h"
#define private public
#include "aicpusd_model.h"
#include "hwts_kernel_close_monitor.h"
#include "hwts_kernel_register.h"
#include "hwts_kernel_cust_so.h"
#include "aicpusd_monitor.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_drv_manager.h"
#include "hwts_kernel_stub.h"

using namespace AicpuSchedule;

class CloseAicpuMonitorKernelTest : public EventProcessKernelTest {
protected:
    CloseAicpuMonitorTsKernel kernel_;
};

namespace {
drvError_t SubmitCustCloseMonitorSuccess(unsigned int devId, event_summary* event)
{
    EXPECT_EQ(devId, 1U);
    EXPECT_EQ(event->dst_engine, CCPU_DEVICE);
    EXPECT_EQ(event->policy, ONLY);
    EXPECT_EQ(event->pid, 12345);
    EXPECT_EQ(event->grp_id, 30U);
    EXPECT_EQ(event->event_id, EVENT_CCPU_CTRL_MSG);
    EXPECT_EQ(event->subevent_id, AICPU_SUB_EVENT_CUST_CLOSE_MONITOR);
    EXPECT_EQ(event->msg_len, sizeof(TsdSubEventInfo));
    auto info = reinterpret_cast<TsdSubEventInfo*>(event->msg);
    EXPECT_EQ(info->deviceId, 1U);
    EXPECT_EQ(info->srcPid, static_cast<uint32_t>(getpid()));
    EXPECT_EQ(info->dstPid, 12345U);
    EXPECT_EQ(info->hostPid, 54321U);
    EXPECT_EQ(info->vfId, 3U);
    EXPECT_EQ(info->procType, 1U);
    EXPECT_EQ(info->eventType, AICPU_SUB_EVENT_CUST_CLOSE_MONITOR);
    auto closeMonitorMsg = reinterpret_cast<AICPUCloseMonitorEventMsg*>(info->priMsg);
    EXPECT_EQ(closeMonitorMsg->closeFlag, 1U);
    return DRV_ERROR_NONE;
}
} // namespace

TEST_F(CloseAicpuMonitorKernelTest, CloseMonitorSuccess)
{
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernelName[] = "CloseAicpuMonitor";
    cceKernel.kernelName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(kernelName));
    struct {
        uint8_t monitorEn;
        uint8_t retcode;
        uint8_t rsv[2];
    } args = {1U, 0xFF, {0U, 0U}};
    cceKernel.paramBase = reinterpret_cast<uint64_t>(&args);
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(args.retcode, 0U);
    EXPECT_TRUE(AicpuMonitor::GetInstance().IsMonitorClosed());
    AicpuMonitor::GetInstance().SetCloseMonitorFlag(false);
}

TEST_F(CloseAicpuMonitorKernelTest, OpenMonitorSuccess)
{
    AicpuMonitor::GetInstance().SetCloseMonitorFlag(true);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernelName[] = "CloseAicpuMonitor";
    cceKernel.kernelName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(kernelName));
    struct {
        uint8_t monitorEn;
        uint8_t retcode;
        uint8_t rsv[2];
    } args = {0U, 0xFF, {0U, 0U}};
    cceKernel.paramBase = reinterpret_cast<uint64_t>(&args);
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(args.retcode, 0U);
    EXPECT_FALSE(AicpuMonitor::GetInstance().IsMonitorClosed());
    AicpuMonitor::GetInstance().SetCloseMonitorFlag(false);
}

TEST_F(CloseAicpuMonitorKernelTest, CheckKernelSupported)
{
    int32_t ret = HwTsKernelRegister::Instance().CheckTsKernelSupported("CloseAicpuMonitor");
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(CloseAicpuMonitorKernelTest, CheckKernelSupportedNotFound)
{
    int32_t ret = HwTsKernelRegister::Instance().CheckTsKernelSupported("CloseAicpuMonitorNotExist");
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(CloseAicpuMonitorKernelTest, NullParamBase)
{
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernelName[] = "CloseAicpuMonitor";
    cceKernel.kernelName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(kernelName));
    cceKernel.paramBase = 0U;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    AicpuMonitor::GetInstance().SetCloseMonitorFlag(false);
}

TEST_F(CloseAicpuMonitorKernelTest, NotifyCustCloseMonitorSuccess)
{
    MOCKER_CPP(&AicpuDrvManager::GetDeviceId).stubs().will(returnValue(1U));
    MOCKER_CPP(&AicpuDrvManager::GetHostPid).stubs().will(returnValue(54321));
    MOCKER_CPP(&AicpuDrvManager::GetVfId).stubs().will(returnValue(3U));
    int32_t custPid = 12345;
    MOCKER(halEschedSubmitEvent).stubs().will(invoke(SubmitCustCloseMonitorSuccess));
    LoadOpFromBuffTsKernel loadKernel;
    int ret = loadKernel.NotifyCustCloseMonitor(custPid);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    GlobalMockObject::verify();
}

TEST_F(CloseAicpuMonitorKernelTest, NotifyCustCloseMonitorFailed)
{
    MOCKER_CPP(&AicpuDrvManager::GetDeviceId).stubs().will(returnValue(1U));
    int32_t custPid = 12345;
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    LoadOpFromBuffTsKernel loadKernel;
    int ret = loadKernel.NotifyCustCloseMonitor(custPid);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
    GlobalMockObject::verify();
}
