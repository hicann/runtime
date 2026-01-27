/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "runtime/rt.h"
#include "utils.h"
#include "xpu_context.hpp"
#include "arg_manage_david.hpp"
#define private public
#define protected public
#include "kernel.hpp"
#include "program.hpp"
#include "arg_loader_xpu.hpp"
#include "stream_xpu.hpp"
#include "xpu_aicpu_c.hpp"
#include "xpu_driver.hpp"
#undef protected
#undef private
#include "xpu_stub.h"
#include "stream.hpp"
#include "runtime.hpp"
#include "api.hpp"
#include "tprt.hpp"
#include "inner_thread_local.hpp"
#include "task_xpu_recycle.hpp"

using namespace testing;
using namespace cce::runtime;

class XpuRecycleTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {

    }

    virtual void SetUp()
    {

    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

rtError_t GetSqState1(const uint32_t deviceId, const uint32_t sqId, uint32_t &status)
{
    status = TPRT_SQ_STATE_IS_QUITTED;
}

TEST_F(XpuRecycleTest, xpu_recycle_test_01)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));

    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    Runtime *rt = (Runtime *)Runtime::Instance();
    XpuContext *context = static_cast<XpuContext*>(rt->GetXpuCtxt());
    
    const uint32_t prio = RT_STREAM_PRIORITY_DEFAULT;
    const uint32_t flag = 0;
    Stream **result = new Stream*(nullptr);
    error = context->StreamCreate(prio, flag, result);
    EXPECT_EQ(error, RT_ERROR_NONE);
    XpuStream *stream = static_cast<XpuStream *>(context->StreamList_().front());
    XpuTaskReclaimAllStream(context->Device_());

    rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    delete result;
 }

TEST_F(XpuRecycleTest, xpu_recycle_test_02)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    Runtime *rt = (Runtime *)Runtime::Instance();
    XpuContext *context = static_cast<XpuContext*>(rt->GetXpuCtxt());
    const uint32_t prio = RT_STREAM_PRIORITY_DEFAULT;
    const uint32_t flag = 0;
    Stream **result = new Stream*(nullptr);
    error = context->StreamCreate(prio, flag, result);
    EXPECT_EQ(error, RT_ERROR_NONE);

    TaskInfo taskInfo = TaskInfo{};
    TaskInfo *taskInfoPtr = &taskInfo;
    taskInfoPtr->u.aicpuTaskInfo = AicpuTaskInfo{};
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    const char* stub = "";
    void* stubFunc = nullptr;
    Kernel *kernel = new (std::nothrow) Kernel(stubFunc, stub, static_cast<uint64_t>(0), program, 0);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_CPU);
    TaskCfg taskCfg{};
    taskCfg.base.dumpflag = 0;
    RtArgsWithType argsWithType{};
    argsWithType.type = RT_ARGS_CPU_EX;
    uint64_t data1 = 1001;
    rtCpuKernelArgs_t argsInfo = {};
    argsInfo.baseArgs.args = &data1;
    argsInfo.baseArgs.argsSize = 4200;
    argsInfo.cpuParamHeadOffset = 0U;
    argsInfo.baseArgs.soNameAddrOffset = 1U;
    argsWithType.args.cpuArgsInfo = &argsInfo;
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP_VIRTUAL((XpuDriver *)context->Device_()->Driver_(), &XpuDriver::LogicCqReportV2).stubs().will(returnValue(RT_ERROR_LOST_HEARTBEAT));
    error = XpuLaunchKernelV2(kernel, 1, &argsWithType, context->StreamList_().front(), taskCfg);
    context->StreamList_().front()->SetFailureMode(ABORT_ON_FAILURE);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    delete result;
    delete kernel;
}

rtError_t mockState(XpuDriver* xpuDrive, const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, uint16_t &head, bool needLog)
{
    head = 1;
    return RT_ERROR_NONE;
}

TEST_F(XpuRecycleTest, xpu_recycle_test_03)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    Runtime *rt = (Runtime *)Runtime::Instance();
    XpuContext *context = static_cast<XpuContext*>(rt->GetXpuCtxt());
    const uint32_t prio = RT_STREAM_PRIORITY_DEFAULT;
    const uint32_t flag = 0;
    Stream **result = new Stream*(nullptr);
    error = context->StreamCreate(prio, flag, result);
    EXPECT_EQ(error, RT_ERROR_NONE);
    MOCKER_CPP_VIRTUAL((XpuDriver *)context->Device_()->Driver_(), &XpuDriver::GetSqHead).stubs().will(invoke(mockState));
    error = XpuRecycleTaskBySqHead(context->StreamList_().front());
    rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    delete result;
}

TEST_F(XpuRecycleTest, XpuDriver_LogicCqReportV2_error)
{
    XpuDriver *driver = new XpuDriver();
    constexpr uint32_t allocCnt = RT_MILAN_MAX_QUERY_CQE_NUM;
    const uint32_t streamId = 0U;

    LogicCqWaitInfo waitInfo = {};
    waitInfo.devId = 0U;
    waitInfo.tsId = 1U;
    waitInfo.cqId = 1U;
    waitInfo.isFastCq = false;
    waitInfo.timeout = RT_REPORT_WITHOUT_TIMEOUT;
    waitInfo.streamId = 0U;
    waitInfo.taskId = MAX_UINT32_NUM;
    uint32_t cnt = 0U;
    TprtLogicCqReport_t reportInfo[RT_MILAN_MAX_QUERY_CQE_NUM] = {};

    MOCKER(TprtCqReportRecv).stubs().will(returnValue((uint32_t)TPRT_CQ_HANDLE_INVALID));
    rtError_t error =
        driver->LogicCqReportV2(waitInfo, RtPtrToPtr<uint8_t *, TprtLogicCqReport_t *>(reportInfo), allocCnt, cnt);
    EXPECT_EQ(error, RT_ERROR_DRV_INVALID_HANDLE);
    DELETE_O(driver)
}