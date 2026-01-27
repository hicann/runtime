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
#define private public
#define protected public
#include "kernel.hpp"
#include "program.hpp"
#include "stream_xpu.hpp"
#include "arg_loader_xpu.hpp"
#include "task_xpu.hpp"
#include "task_res_da.hpp"
#include "runtime.hpp"
#include "api.hpp"
#include "tprt.hpp"
#include "runtime/rt.h"
#include "utils.h"
#include "xpu_context.hpp"
#include "task_manager_xpu.hpp"
#include "xpu_aicpu_c.hpp"
#include "xpu_kernel_task.h"
#undef private
#undef protected
#include "raw_device.hpp"
#include "xpu_stub.h"

using namespace testing;
using namespace cce::runtime;
class XpuTaskTest : public testing::Test
{
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

drvError_t drvGetPlatformInfo_online7(uint32_t *info)
{
    *info = RT_RUN_MODE_ONLINE;
    return DRV_ERROR_NONE;
}

drvError_t drvGetPlatformInfo_offline7(uint32_t *info)
{
    *info = RT_RUN_MODE_OFFLINE;
    return DRV_ERROR_NONE;
}

rtError_t ParseXpuConfigInfo_mock7(XpuDevice *This)
{
    This->configInfo_.version = 1.0;
    This->configInfo_.maxStreamNum = 64;
    This->configInfo_.maxStreamDepth = 1024;
    This->configInfo_.timeoutMonitorGranularity = 1000;
    This->configInfo_.defaultTaskExeTimeout = 30000;
    return RT_ERROR_NONE;
}

TEST_F(XpuTaskTest, xpu_task_test_01)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online7));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock7));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    Runtime *rt = (Runtime *)Runtime::Instance();
    XpuContext *context = static_cast<XpuContext*>(rt->GetXpuCtxt());
    const uint32_t prio = RT_STREAM_PRIORITY_DEFAULT;
    const uint32_t flag = 0;
    Stream **result = new Stream*(nullptr);
    error = context->StreamCreate(prio, flag, result);
    XpuStream *stream = static_cast<XpuStream *>(context->StreamList_().front());
    XpuTaskRollBack(stream, 1025);
    rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    delete result;
}

TEST_F(XpuTaskTest, xpu_task_test_02)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online7));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock7));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    Runtime *rt = (Runtime *)Runtime::Instance();
    XpuContext *context = static_cast<XpuContext*>(rt->GetXpuCtxt());
    const uint32_t prio = RT_STREAM_PRIORITY_DEFAULT;
    const uint32_t flag = 0;
    Stream **result = new Stream*(nullptr);
    error = context->StreamCreate(prio, flag, result);
    XpuStream *stream = static_cast<XpuStream *>(context->StreamList_().front());
    XpuTaskRollBack(stream, 0);
    rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    delete result;
}

TEST_F(XpuTaskTest, xpu_task_test_03)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online7));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock7));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    Runtime *rt = (Runtime *)Runtime::Instance();
    XpuContext *context = static_cast<XpuContext*>(rt->GetXpuCtxt());
    const uint32_t prio = RT_STREAM_PRIORITY_DEFAULT;
    const uint32_t flag = 0;
    Stream **result = new Stream*(nullptr);
    error = context->StreamCreate(prio, flag, result);
    uint32_t sqeNum = 1;
    TaskInfo** taskInfo = nullptr;
    error = XpuAllocTaskInfo(taskInfo, context->StreamList_().front(), sqeNum, 1);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    delete result;
    delete taskInfo;
}

TEST_F(XpuTaskTest, xpu_task_test_04)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online7));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock7));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    Runtime *rt = (Runtime *)Runtime::Instance();
    XpuContext *context = static_cast<XpuContext*>(rt->GetXpuCtxt());
    const uint32_t prio = RT_STREAM_PRIORITY_DEFAULT;
    const uint32_t flag = 0;
    Stream **result = new Stream*(nullptr);
    error = context->StreamCreate(prio, flag, result);
    uint32_t sqeNum = 1;
    TaskInfo** taskInfo;
    MOCKER_CPP(&TaskResManageDavid::AllocTaskInfoAndPos)
    .stubs()
    .will(returnValue(RT_ERROR_TASKRES_QUEUE_FULL))
    .then(returnValue(RT_ERROR_INVALID_VALUE));
    error = XpuAllocTaskInfo(taskInfo, context->StreamList_().front(), sqeNum, 1);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    delete result;
}

TEST_F(XpuTaskTest, xpu_task_test_05)
{
    const char* ans = GetXpuSqeDescByType(100);
    EXPECT_STREQ(ans, "unknown");
}

TEST_F(XpuTaskTest, xpu_task_test_06)
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
    MOCKER_CPP(&TaskResManageDavid::AllocTaskInfoAndPos).stubs().will(returnValue(RT_ERROR_TASKRES_QUEUE_FULL)).then(returnValue(RT_ERROR_DRV_ERR));
    error = XpuLaunchKernelV2(kernel, 1, &argsWithType, context->StreamList_().front(), taskCfg);
    rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    delete result;
    delete kernel;
}

TEST_F(XpuTaskTest, xpu_task_test_07)
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
    MOCKER_CPP_VIRTUAL((XpuStream *)(context->StreamList_().front()), &XpuStream::StarsAddTaskToStream).stubs().will(returnValue(1));
    error = XpuLaunchKernelV2(kernel, 1, &argsWithType, context->StreamList_().front(), taskCfg);
    rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    delete result;
    delete kernel;
}

TEST_F(XpuTaskTest, xpu_task_test_08)
{
    Runtime *rt = Runtime::Instance();
    rtError_t ret = RT_ERROR_NONE;
    TaskInfo task = {};
    TaskInfo *taskInfo = &task;
    taskInfo->type = TS_TASK_TYPE_KERNEL_AICPU;
    MOCKER(XpuPrintAICpuErrorInfoForDavinciTask).stubs();
    XpuPrintErrorInfo(taskInfo, 1);
}

TEST_F(XpuTaskTest, xpu_task_test_09)
{
    Runtime *rt = Runtime::Instance();
    rtError_t ret = RT_ERROR_NONE;
    TaskInfo task = {};
    TaskInfo *taskInfo = &task;
    taskInfo->type = TS_TASK_TYPE_RESERVED;
    XpuPrintErrorInfo(taskInfo, 1);
}