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
#include "api_impl_david.hpp"
#undef private
#undef protected
#include "raw_device.hpp"
#include "xpu_stub.h"
#include "tprt.hpp"


using namespace cce::runtime;
class XpuProfilingTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "XpuProfilingTest SetUP" << std::endl;

        std::cout << "XpuProfilingTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "XpuProfilingTest end" << std::endl;
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(XpuProfilingTest, xpu_profiling_command_handle_should_fail_when_data_is_null)
{
    uint32_t len = 8;
    ApiImplDavid impl;
    rtError_t error = impl.XpuProfilingCommandHandle(PROF_CTRL_SWITCH, nullptr, len);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(XpuProfilingTest, xpu_profiling_command_handle_should_fail_when_type_is_wrong)
{
    void *data = malloc(8);
    uint32_t len = 8;
    ApiImplDavid impl;
    rtError_t error = impl.XpuProfilingCommandHandle(PROF_CTRL_INVALID, data, len);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
    free(data);
}

TEST_F(XpuProfilingTest, rtXpuProfilingCommandHandle_01)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    MOCKER(MsprofReportCompactInfo).stubs().will(returnValue(0));
    rtProfCommandHandle_t profilerConfig;
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    memset_s(&profilerConfig, sizeof(rtProfCommandHandle_t), 0, sizeof(rtProfCommandHandle_t));
    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_START;
    profilerConfig.profSwitch = 1;
    profilerConfig.devNums = 1;
    ApiImplDavid impl;
    error = impl.XpuProfilingCommandHandle(PROF_CTRL_SWITCH, (void *)(&profilerConfig), sizeof(rtProfCommandHandle_t));
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(XpuProfilingTest, rtXpuProfilingCommandHandle_02)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    MOCKER(MsprofReportCompactInfo).stubs().will(returnValue(0));
    rtProfCommandHandle_t profilerConfig;
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    memset_s(&profilerConfig, sizeof(rtProfCommandHandle_t), 0, sizeof(rtProfCommandHandle_t));
    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_STOP;
    profilerConfig.profSwitch = 1;
    profilerConfig.devNums = 1;
    ApiImplDavid impl;
    error = impl.XpuProfilingCommandHandle(PROF_CTRL_SWITCH, (void *)(&profilerConfig), sizeof(rtProfCommandHandle_t));
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(XpuProfilingTest, rtXpuProfilingCommandHandle_03)
{
    rtProfCommandHandle_t profilerConfig;
    memset_s(&profilerConfig, sizeof(rtProfCommandHandle_t), 0, sizeof(rtProfCommandHandle_t));
    profilerConfig.type = 0;
    profilerConfig.profSwitch = 1;
    profilerConfig.devNums = 1;
    ApiImplDavid impl;
    rtError_t error = impl.XpuProfilingCommandHandle(PROF_CTRL_SWITCH, (void *)(&profilerConfig), sizeof(rtProfCommandHandle_t));
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(XpuProfilingTest, rtXpuProfilingCommandHandle_04)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    MOCKER(MsprofReportCompactInfo).stubs().will(returnValue(0));
    rtProfCommandHandle_t profilerConfig;
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    memset_s(&profilerConfig, sizeof(rtProfCommandHandle_t), 0, sizeof(rtProfCommandHandle_t));
    profilerConfig.type = 0;
    profilerConfig.profSwitch = 1;
    profilerConfig.devNums = 1;
    ApiImplDavid impl;
    (void)impl.XpuProfilingCommandHandle(0, (void *)(&profilerConfig), sizeof(rtProfCommandHandle_t));
    error = rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(XpuProfilingTest, rtXpuProfilingCommandHandle_05)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    MOCKER(MsprofReportCompactInfo).stubs().will(returnValue(0));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    rtProfCommandHandle_t profilerConfig;
    memset_s(&profilerConfig, sizeof(rtProfCommandHandle_t), 0, sizeof(rtProfCommandHandle_t));
    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_START;
    profilerConfig.profSwitch = 1;
    profilerConfig.devNums = 1;
    ApiImplDavid impl;
    error = impl.XpuProfilingCommandHandle(PROF_CTRL_SWITCH, (void *)(&profilerConfig), sizeof(rtProfCommandHandle_t));
    EXPECT_EQ(error, RT_ERROR_NONE);
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
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program *program = &stubProg;
    const char* stub = "";
    void* stubFunc = nullptr;
    Kernel *kernel = new (std::nothrow) Kernel("", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 0);
    kernel->SetStub_(stubFunc);
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
    error = XpuLaunchKernelV2(kernel, 1, &argsWithType, context->StreamList_().front(), taskCfg);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    delete result;
    delete kernel;
}
