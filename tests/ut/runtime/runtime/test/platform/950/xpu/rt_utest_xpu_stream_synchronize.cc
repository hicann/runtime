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
#define private public
#define protected public
#include "kernel.hpp"
#include "program.hpp"
#include "arg_loader_xpu.hpp"
#include "stream_xpu.hpp"
#undef private
#undef protected
#include "raw_device.hpp"
#include "xpu_stub.h"
#include "runtime.hpp"
#include "api.hpp"
#include "tprt.hpp"
#include "xpu_kernel_task.h"
#include "xpu_aicpu_c.hpp"
#include "api_impl.hpp"
#include "rt_inner_xpu.h"
#include "../../../common/rt_utest_xpu_helper.hpp"
using namespace testing;
using namespace cce::runtime;

using namespace cce::runtime;
class XpuStreamSynchronizeTest : public ut::XpuRuntimeMockTest {
protected:
    static void SetUpTestCase()
    {
        std::cout << "XpuStreamSynchronizeTest SetUP" << std::endl;

        std::cout << "XpuStreamSynchronizeTest start" << std::endl;
    }

    static void TearDownTestCase() { std::cout << "XpuStreamSynchronizeTest end" << std::endl; }
};

TEST_F(XpuStreamSynchronizeTest, Stream_synchronize_null)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    Runtime* rt = (Runtime*)Runtime::Instance();
    XpuContext* context = static_cast<XpuContext*>(rt->GetXpuCtxt());
    const uint32_t prio = RT_STREAM_PRIORITY_DEFAULT;
    const uint32_t flag = 0;
    Stream** result = new Stream*(nullptr);
    error = context->StreamCreate(prio, flag, result);
    EXPECT_EQ(error, RT_ERROR_NONE);
    XpuStream* stream = static_cast<XpuStream*>(context->StreamList_().front());
    stream->Synchronize(true, 1000);
    rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    delete result;
}

TEST_F(XpuStreamSynchronizeTest, Stream_synchronize_fail)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    Runtime* rt = (Runtime*)Runtime::Instance();
    XpuContext* context = static_cast<XpuContext*>(rt->GetXpuCtxt());
    const uint32_t prio = RT_STREAM_PRIORITY_DEFAULT;
    const uint32_t flag = 0;
    Stream** result = new Stream*(nullptr);
    error = context->StreamCreate(prio, flag, result);
    EXPECT_EQ(error, RT_ERROR_NONE);

    TaskInfo taskInfo = TaskInfo{};
    TaskInfo* taskInfoPtr = &taskInfo;
    taskInfoPtr->u.aicpuTaskInfo = AicpuTaskInfo{};
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    const char* stub = "";
    void* stubFunc = nullptr;
    Kernel* kernel = new (std::nothrow) Kernel("", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 0);
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
    error =
        XpuLaunchKernel(kernel, 1, &argsWithType.args.cpuArgsInfo->baseArgs, context->StreamList_().front(), &taskCfg);

    XpuStream* stream = static_cast<XpuStream*>(context->StreamList_().front());
    MOCKER_CPP_VIRTUAL(stream->Device_(), &Device::WakeUpRecycleThread).stubs();
    stream->Synchronize(true, 10000000);
    rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    delete result;
    delete kernel;
}

TEST_F(XpuStreamSynchronizeTest, Stream_synchronize_with_stream_null)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    ApiImpl impl;
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = impl.StreamSynchronize(nullptr, 1000);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    error = rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(XpuStreamSynchronizeTest, Stream_synchronize_keeps_auto_wait_for_all_modes)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    ASSERT_EQ(rtSetXpuDevice(RT_DEV_TYPE_DPU, 0), ACL_RT_SUCCESS);

    Runtime* const runtime = Runtime::Instance();
    XpuContext* const context = static_cast<XpuContext*>(runtime->GetXpuCtxt());
    Stream* stream = nullptr;
    ASSERT_EQ(context->StreamCreate(RT_STREAM_PRIORITY_DEFAULT, 0U, &stream), RT_ERROR_NONE);
    auto* const xpuStream = static_cast<XpuStream*>(stream);
    MOCKER_CPP_VIRTUAL(xpuStream, &XpuStream::GetPendingNum).expects(exactly(4)).will(returnValue(1U));
    MOCKER_CPP_VIRTUAL(xpuStream, &XpuStream::SynchronizeExecutedTask)
        .expects(exactly(4))
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), eq(RT_DEVICE_SCHEDULE_AUTO))
        .will(returnValue(RT_ERROR_DRV_ERR));

    EXPECT_EQ(xpuStream->Synchronize(true, 1, RT_DEVICE_SCHEDULE_AUTO), RT_ERROR_DRV_ERR);
    EXPECT_EQ(xpuStream->Synchronize(true, 1, RT_DEVICE_SCHEDULE_SPIN), RT_ERROR_DRV_ERR);
    EXPECT_EQ(xpuStream->Synchronize(true, 1, RT_DEVICE_SCHEDULE_YIELD), RT_ERROR_DRV_ERR);
    EXPECT_EQ(xpuStream->Synchronize(true, 1, RT_DEVICE_SCHEDULE_BLOCKING_SYNC), RT_ERROR_DRV_ERR);

    GlobalMockObject::verify();
    GlobalMockObject::reset();
    EXPECT_EQ(rtResetXpuDevice(RT_DEV_TYPE_DPU, 0), ACL_RT_SUCCESS);
}
