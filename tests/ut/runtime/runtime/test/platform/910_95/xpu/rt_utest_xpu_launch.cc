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
#include "arg_loader_xpu.hpp"
#include "stream_xpu.hpp"
#include "xpu_context.hpp"
#include "tprt_worker.hpp"
#include "stream.hpp"
#include "runtime.hpp"
#include "api.hpp"
#include "tprt.hpp"
#include "inner_thread_local.hpp"
#include "task_res_da.hpp"
#include "task_xpu.hpp"
#include "base.h"
#include "task_info.hpp"
#include "task_info_base.hpp"
#include "tprt_error_code.h"
#include "xpu_aicpu_c.hpp"
#include "arg_manage_david.hpp"
#include "utils.h"
#include "npu_driver.hpp"
#include "para_convertor.hpp"
#include "xpu_kernel_task.h"
#include "arg_manage_xpu.hpp"
#include "api_impl_david.hpp"
#undef protected
#undef private
#include "xpu_stub.h"

using namespace cce::runtime;
class XpuLaunchTest : public testing::Test {
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

    static XpuContext* GetContext() 
    {
        Context* ctx = InnerThreadLocalContainer::GetCurCtx();
        return dynamic_cast<XpuContext*>(ctx);
    }

};

uint32_t WorkMock(cce::tprt::TprtSqHandle *sqHandle, const TprtSqe_t *sqe)
{
    return TPRT_SUCCESS;
}

TEST_F(XpuLaunchTest, XpuCheckTaskCanSend_Success_01)
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
    error = XpuLaunchKernelV2(kernel, 1, &argsWithType, context->StreamList_().front(), taskCfg);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    delete result;
    delete kernel;
}

TEST_F(XpuLaunchTest, XpuLaunchKernelV2_Success_01)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    MOCKER(XpuCheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    TaskInfo taskInfo = TaskInfo{};
    TaskInfo *taskInfoPtr = nullptr;
    taskInfoPtr = &taskInfo;
    taskInfoPtr->u.aicpuTaskInfo = AicpuTaskInfo{}; 
    MOCKER_CPP(&XpuStream::LoadArgsInfo<rtAicpuArgsEx_t>).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(XpuAllocTaskInfo).stubs().with(outBoundP(&taskInfoPtr, mockcpp::any())).will(returnValue(RT_ERROR_NONE));
    MOCKER(XpuSendTask)
    .stubs()
    .will(returnValue(RT_ERROR_NONE));

    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    const char* stub = "";
    void* stubFunc = nullptr;
    Kernel * kernel = new (std::nothrow) Kernel(stubFunc, stub, static_cast<uint64_t>(0), program, 0);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_CPU);
    kernel->SetKernelType_(KERNEL_TYPE_AICPU);
    rtStream_t stream;
    rtsStreamCreate(&stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RtArgsWithType argsWithType{};
    argsWithType.type = RT_ARGS_CPU_EX;
    rtCpuKernelArgs_t cpuArgsInfo = rtCpuKernelArgs_t{};
    argsWithType.args.cpuArgsInfo = &cpuArgsInfo;
    rtAicpuArgsEx_t baseArgs = rtAicpuArgsEx_t{};
    cpuArgsInfo.baseArgs = baseArgs;

    rtKernelLaunchCfg_t taskCfg;
    taskCfg.numAttrs = 1;
    rtLaunchKernelAttr_t attrs[1];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_DATA_DUMP;
    attrs[0].value.isDataDump = DATA_DUMP_DISABLE; // DATA_DUMP_ENABLE
    taskCfg.attrs = attrs;

    ApiImplDavid impl;
    error = impl.LaunchKernelV2(kernel, 1, &argsWithType, RtPtrToPtr<Stream *>(stream), &taskCfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete kernel;
    TprtDavinciTaskUnInit(taskInfoPtr);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(XpuLaunchTest, XpuLaunchKernelV2_Success_argSize_MoreThan4K)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    MOCKER(XpuCheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    TaskInfo taskInfo = TaskInfo{};
    TaskInfo *taskInfoPtr = nullptr;
    taskInfoPtr = &taskInfo;
    taskInfoPtr->u.aicpuTaskInfo = AicpuTaskInfo{}; 
    MOCKER_CPP(&XpuStream::LoadArgsInfo<rtAicpuArgsEx_t>).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(XpuAllocTaskInfo).stubs().with(outBoundP(&taskInfoPtr, mockcpp::any())).will(returnValue(RT_ERROR_NONE));
    MOCKER(XpuSendTask)
    .stubs()
    .will(returnValue(RT_ERROR_NONE));

    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    const char* stub = "";
    void* stubFunc = nullptr;
    Kernel * kernel = new (std::nothrow) Kernel(stubFunc, stub, static_cast<uint64_t>(0), program, 0);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_CPU);
    kernel->SetKernelType_(KERNEL_TYPE_AICPU);
    rtStream_t stream;
    error = rtsStreamCreate(&stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RtArgsWithType argsWithType{};
    argsWithType.type = RT_ARGS_CPU_EX;
    rtCpuKernelArgs_t cpuArgsInfo = rtCpuKernelArgs_t{};
    argsWithType.args.cpuArgsInfo = &cpuArgsInfo;
    rtAicpuArgsEx_t baseArgs = rtAicpuArgsEx_t{};
    baseArgs.argsSize = XPU_ARG_POOL_COPY_SIZE + 1;
    cpuArgsInfo.baseArgs = baseArgs;

    rtKernelLaunchCfg_t taskCfg;
    taskCfg.numAttrs = 1;
    rtLaunchKernelAttr_t attrs[1];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_DATA_DUMP;
    attrs[0].value.isDataDump = DATA_DUMP_DISABLE; // DATA_DUMP_ENABLE
    taskCfg.attrs = attrs;

    ApiImplDavid impl;
    error = impl.LaunchKernelV2(kernel, 1, &argsWithType, RtPtrToPtr<Stream *>(stream), &taskCfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete kernel;
    TprtDavinciTaskUnInit(taskInfoPtr);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(XpuLaunchTest, XpuLaunchKernelV2_Failed_01)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    MOCKER(XpuCheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    TaskInfo taskInfo = TaskInfo{};
    TaskInfo *taskInfoPtr = nullptr;
    taskInfoPtr = &taskInfo;
    taskInfoPtr->u.aicpuTaskInfo = AicpuTaskInfo{}; 
    MOCKER_CPP(&XpuStream::LoadArgsInfo<rtAicpuArgsEx_t>).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(XpuAllocTaskInfo).stubs().with(outBoundP(&taskInfoPtr, mockcpp::any())).will(returnValue(RT_ERROR_NONE));
    MOCKER(XpuSendTask)
    .stubs()
    .will(returnValue(RT_ERROR_NONE));

    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    const char* stub = "";
    void* stubFunc = nullptr;
    Kernel * kernel = new (std::nothrow) Kernel(stubFunc, stub, static_cast<uint64_t>(0), program, 0);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_NON_CPU);
    kernel->SetKernelType_(KERNEL_TYPE_AICPU);
    rtStream_t stream;
    error = rtsStreamCreate(&stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RtArgsWithType argsWithType{};
    argsWithType.type = RT_ARGS_CPU_EX;
    rtCpuKernelArgs_t cpuArgsInfo = rtCpuKernelArgs_t{};
    argsWithType.args.cpuArgsInfo = &cpuArgsInfo;
    rtAicpuArgsEx_t baseArgs = rtAicpuArgsEx_t{};
    cpuArgsInfo.baseArgs = baseArgs;

    rtKernelLaunchCfg_t taskCfg;
    taskCfg.numAttrs = 1;
    rtLaunchKernelAttr_t attrs[1];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_DATA_DUMP;
    attrs[0].value.isDataDump = DATA_DUMP_DISABLE; // DATA_DUMP_ENABLE
    taskCfg.attrs = attrs;

    ApiImplDavid impl;
    error = impl.LaunchKernelV2(kernel, 1, &argsWithType, RtPtrToPtr<Stream *>(stream), &taskCfg);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
    TprtDavinciTaskUnInit(taskInfoPtr);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(XpuLaunchTest, XpuLaunchKernelV2_NonCpu)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    MOCKER(XpuCheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    TaskInfo taskInfo = TaskInfo{};
    TaskInfo *taskInfoPtr = nullptr;
    taskInfoPtr = &taskInfo;
    taskInfoPtr->u.aicpuTaskInfo = AicpuTaskInfo{}; 
    MOCKER_CPP(&XpuStream::LoadArgsInfo<rtAicpuArgsEx_t>).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(XpuAllocTaskInfo).stubs().with(outBoundP(&taskInfoPtr, mockcpp::any())).will(returnValue(RT_ERROR_NONE));
    MOCKER(XpuSendTask)
    .stubs()
    .will(returnValue(RT_ERROR_NONE));

    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    const char* stub = "";
    void* stubFunc = nullptr;
    Kernel * kernel = new (std::nothrow) Kernel(stubFunc, stub, static_cast<uint64_t>(0), program, 0);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_CPU);
    kernel->SetKernelType_(KERNEL_TYPE_AICPU);
    rtStream_t stream;
    error = rtsStreamCreate(&stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RtArgsWithType argsWithType{};
    argsWithType.type = RT_ARGS_NON_CPU_EX;
    rtCpuKernelArgs_t cpuArgsInfo = rtCpuKernelArgs_t{};
    argsWithType.args.cpuArgsInfo = &cpuArgsInfo;
    rtAicpuArgsEx_t baseArgs = rtAicpuArgsEx_t{};
    cpuArgsInfo.baseArgs = baseArgs;

    rtKernelLaunchCfg_t taskCfg;
    taskCfg.numAttrs = 1;
    rtLaunchKernelAttr_t attrs[1];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_DATA_DUMP;
    attrs[0].value.isDataDump = DATA_DUMP_DISABLE; // DATA_DUMP_ENABLE
    taskCfg.attrs = attrs;

    ApiImplDavid impl;
    error = impl.LaunchKernelV2(kernel, 1, &argsWithType, RtPtrToPtr<Stream *>(stream), &taskCfg);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
    TprtDavinciTaskUnInit(taskInfoPtr);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(XpuLaunchTest, XpuLaunchKernelV2_DumpEnable)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    MOCKER(XpuCheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    TaskInfo taskInfo = TaskInfo{};
    TaskInfo *taskInfoPtr = nullptr;
    taskInfoPtr = &taskInfo;
    taskInfoPtr->u.aicpuTaskInfo = AicpuTaskInfo{}; 
    MOCKER_CPP(&XpuStream::LoadArgsInfo<rtAicpuArgsEx_t>).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(XpuAllocTaskInfo).stubs().with(outBoundP(&taskInfoPtr, mockcpp::any())).will(returnValue(RT_ERROR_NONE));
    MOCKER(XpuSendTask)
    .stubs()
    .will(returnValue(RT_ERROR_NONE));

    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    const char* stub = "";
    void* stubFunc = nullptr;
    Kernel * kernel = new (std::nothrow) Kernel(stubFunc, stub, static_cast<uint64_t>(0), program, 0);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_CPU);
    kernel->SetKernelType_(KERNEL_TYPE_AICPU);
    rtStream_t stream;
    error = rtsStreamCreate(&stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RtArgsWithType argsWithType{};
    argsWithType.type = RT_ARGS_CPU_EX;
    rtCpuKernelArgs_t cpuArgsInfo = rtCpuKernelArgs_t{};
    argsWithType.args.cpuArgsInfo = &cpuArgsInfo;
    rtAicpuArgsEx_t baseArgs = rtAicpuArgsEx_t{};
    cpuArgsInfo.baseArgs = baseArgs;

    rtKernelLaunchCfg_t taskCfg;
    taskCfg.numAttrs = 1;
    rtLaunchKernelAttr_t attrs[1];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_DATA_DUMP;
    attrs[0].value.isDataDump = DATA_DUMP_ENABLE;
    taskCfg.attrs = attrs;

    ApiImplDavid impl;
    error = impl.LaunchKernelV2(kernel, 1, &argsWithType, RtPtrToPtr<Stream *>(stream), &taskCfg);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
    TprtDavinciTaskUnInit(taskInfoPtr);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(XpuLaunchTest, XpuLaunchKernelV2_LoadArgsInfo_Dev_Fail)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    MOCKER(XpuCheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    TaskInfo taskInfo = TaskInfo{};
    TaskInfo *taskInfoPtr = nullptr;
    taskInfoPtr = &taskInfo;
    taskInfoPtr->u.aicpuTaskInfo = AicpuTaskInfo{}; 
    MOCKER_CPP(&XpuStream::LoadArgsInfo<rtAicpuArgsEx_t>).stubs().will(returnValue(RT_ERROR_MEMORY_ALLOCATION));
    MOCKER(XpuAllocTaskInfo).stubs().with(outBoundP(&taskInfoPtr, mockcpp::any())).will(returnValue(RT_ERROR_NONE));
    MOCKER(XpuSendTask)
    .stubs()
    .will(returnValue(RT_ERROR_NONE));

    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    const char* stub = "";
    void* stubFunc = nullptr;
    Kernel * kernel = new (std::nothrow) Kernel(stubFunc, stub, static_cast<uint64_t>(0), program, 0);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_CPU);
    kernel->SetKernelType_(KERNEL_TYPE_AICPU);
    rtStream_t stream;
    error = rtsStreamCreate(&stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RtArgsWithType argsWithType{};
    argsWithType.type = RT_ARGS_CPU_EX;
    rtCpuKernelArgs_t cpuArgsInfo = rtCpuKernelArgs_t{};
    argsWithType.args.cpuArgsInfo = &cpuArgsInfo;
    rtAicpuArgsEx_t baseArgs = rtAicpuArgsEx_t{};
    baseArgs.argsSize = XPU_ARG_POOL_COPY_SIZE + 1;
    cpuArgsInfo.baseArgs = baseArgs;
    
    rtKernelLaunchCfg_t taskCfg;
    taskCfg.numAttrs = 1;
    rtLaunchKernelAttr_t attrs[1];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_DATA_DUMP;
    attrs[0].value.isDataDump = DATA_DUMP_DISABLE;
    taskCfg.attrs = attrs;

    ApiImplDavid impl;
    error = impl.LaunchKernelV2(kernel, 1, &argsWithType, RtPtrToPtr<Stream *>(stream), &taskCfg);
    EXPECT_EQ(error, RT_ERROR_MEMORY_ALLOCATION);

    delete kernel;
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(XpuLaunchTest, XpuLaunchKernelV2_LoadArgsInfo_Fail)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    MOCKER(XpuCheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    TaskInfo taskInfo = TaskInfo{};
    TaskInfo *taskInfoPtr = nullptr;
    taskInfoPtr = &taskInfo;
    taskInfoPtr->u.aicpuTaskInfo = AicpuTaskInfo{}; 
    MOCKER_CPP(&XpuStream::LoadArgsInfo<rtAicpuArgsEx_t>).stubs().will(returnValue(RT_ERROR_MEMORY_ALLOCATION));
    MOCKER(XpuAllocTaskInfo).stubs().with(outBoundP(&taskInfoPtr, mockcpp::any())).will(returnValue(RT_ERROR_NONE));
    MOCKER(XpuSendTask)
    .stubs()
    .will(returnValue(RT_ERROR_NONE));

    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    const char* stub = "";
    void* stubFunc = nullptr;
    Kernel * kernel = new (std::nothrow) Kernel(stubFunc, stub, static_cast<uint64_t>(0), program, 0);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_CPU);
    kernel->SetKernelType_(KERNEL_TYPE_AICPU);
    rtStream_t stream;
    error = rtsStreamCreate(&stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RtArgsWithType argsWithType{};
    argsWithType.type = RT_ARGS_CPU_EX;
    rtCpuKernelArgs_t cpuArgsInfo = rtCpuKernelArgs_t{};
    argsWithType.args.cpuArgsInfo = &cpuArgsInfo;
    rtAicpuArgsEx_t baseArgs = rtAicpuArgsEx_t{};
    cpuArgsInfo.baseArgs = baseArgs;
    
    rtKernelLaunchCfg_t taskCfg;
    taskCfg.numAttrs = 1;
    rtLaunchKernelAttr_t attrs[1];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_DATA_DUMP;
    attrs[0].value.isDataDump = DATA_DUMP_DISABLE;
    taskCfg.attrs = attrs;

    ApiImplDavid impl;
    error = impl.LaunchKernelV2(kernel, 1, &argsWithType, RtPtrToPtr<Stream *>(stream), &taskCfg);
    EXPECT_EQ(error, RT_ERROR_MEMORY_ALLOCATION);

    delete kernel;
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(XpuLaunchTest, XpuLaunchKernelV2_XpuAllocTaskInfo_Fail)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    MOCKER(XpuCheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    TaskInfo taskInfo = TaskInfo{};
    TaskInfo *taskInfoPtr = nullptr;
    taskInfoPtr = &taskInfo;
    taskInfoPtr->u.aicpuTaskInfo = AicpuTaskInfo{}; 
    MOCKER_CPP(&XpuStream::LoadArgsInfo<rtAicpuArgsEx_t>).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(XpuAllocTaskInfo).stubs().with(outBoundP(&taskInfoPtr, mockcpp::any())).will(returnValue(RT_ERROR_INVALID_VALUE));
    MOCKER(XpuSendTask)
    .stubs()
    .will(returnValue(RT_ERROR_NONE));

    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    const char* stub = "";
    void* stubFunc = nullptr;
    Kernel * kernel = new (std::nothrow) Kernel(stubFunc, stub, static_cast<uint64_t>(0), program, 0);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_CPU);
    kernel->SetKernelType_(KERNEL_TYPE_AICPU);
    rtStream_t stream;
    error = rtsStreamCreate(&stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RtArgsWithType argsWithType{};
    argsWithType.type = RT_ARGS_CPU_EX;
    rtCpuKernelArgs_t cpuArgsInfo = rtCpuKernelArgs_t{};
    argsWithType.args.cpuArgsInfo = &cpuArgsInfo;
    rtAicpuArgsEx_t baseArgs = rtAicpuArgsEx_t{};
    cpuArgsInfo.baseArgs = baseArgs;
    
    rtKernelLaunchCfg_t taskCfg;
    taskCfg.numAttrs = 1;
    rtLaunchKernelAttr_t attrs[1];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_DATA_DUMP;
    attrs[0].value.isDataDump = DATA_DUMP_DISABLE;
    taskCfg.attrs = attrs;

    ApiImplDavid impl;
    error = impl.LaunchKernelV2(kernel, 1, &argsWithType, RtPtrToPtr<Stream *>(stream), &taskCfg);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(XpuLaunchTest, XpuLaunchKernelV2_XpuSendTask_Fail)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    MOCKER(XpuCheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    TaskInfo taskInfo = TaskInfo{};
    TaskInfo *taskInfoPtr = nullptr;
    taskInfoPtr = &taskInfo;
    taskInfoPtr->u.aicpuTaskInfo = AicpuTaskInfo{}; 
    MOCKER_CPP(&XpuStream::LoadArgsInfo<rtAicpuArgsEx_t>).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(XpuAllocTaskInfo).stubs().with(outBoundP(&taskInfoPtr, mockcpp::any())).will(returnValue(RT_ERROR_INVALID_VALUE));
    MOCKER(XpuSendTask)
    .stubs()
    .will(returnValue(RT_ERROR_INVALID_VALUE));

    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    const char* stub = "";
    void* stubFunc = nullptr;
    Kernel * kernel = new (std::nothrow) Kernel(stubFunc, stub, static_cast<uint64_t>(0), program, 0);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_CPU);
    kernel->SetKernelType_(KERNEL_TYPE_AICPU);
    rtStream_t stream;
    error = rtsStreamCreate(&stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RtArgsWithType argsWithType{};
    argsWithType.type = RT_ARGS_CPU_EX;
    rtCpuKernelArgs_t cpuArgsInfo = rtCpuKernelArgs_t{};
    argsWithType.args.cpuArgsInfo = &cpuArgsInfo;
    rtAicpuArgsEx_t baseArgs = rtAicpuArgsEx_t{};
    cpuArgsInfo.baseArgs = baseArgs;
    
    rtKernelLaunchCfg_t taskCfg;
    taskCfg.numAttrs = 1;
    rtLaunchKernelAttr_t attrs[1];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_DATA_DUMP;
    attrs[0].value.isDataDump = DATA_DUMP_DISABLE;
    taskCfg.attrs = attrs;

    ApiImplDavid impl;
    error = impl.LaunchKernelV2(kernel, 1, &argsWithType, RtPtrToPtr<Stream *>(stream), &taskCfg);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}


uint32_t AicpuFuncFailMock(uint32_t a)
{
    return a++;
}

uint32_t AicpuFuncSuccessMock(uint32_t a)
{
    a++;
    return 0;
}

TEST_F(XpuLaunchTest, XpuLaunchKernelV2_NoMocker_Success)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    const char* stub = "";
    void* stubFunc = nullptr;
    Kernel * kernel = new (std::nothrow) Kernel(stubFunc, stub, static_cast<uint64_t>(0), program, 0);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_CPU);
    kernel->SetKernelType_(KERNEL_TYPE_AICPU);
    kernel->SetKernelLiteralNameDevAddr(nullptr, (void *)(&AicpuFuncSuccessMock), 0);
    rtStream_t stream;
    rtsStreamCreate(&stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RtArgsWithType argsWithType{};
    argsWithType.type = RT_ARGS_CPU_EX;
    rtCpuKernelArgs_t cpuArgsInfo = rtCpuKernelArgs_t{};
    argsWithType.args.cpuArgsInfo = &cpuArgsInfo;
    rtAicpuArgsEx_t baseArgs = rtAicpuArgsEx_t{};
    uint32_t param = 10;
    baseArgs.args = (void*)(&param);
    baseArgs.argsSize = sizeof(uint32_t);
    cpuArgsInfo.baseArgs = baseArgs;

    rtKernelLaunchCfg_t taskCfg;
    taskCfg.numAttrs = 1;
    rtLaunchKernelAttr_t attrs[1];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_DATA_DUMP;
    attrs[0].value.isDataDump = DATA_DUMP_DISABLE; // DATA_DUMP_ENABLE
    taskCfg.attrs = attrs;

    ApiImplDavid impl;
    error = impl.LaunchKernelV2(kernel, 1, &argsWithType, RtPtrToPtr<Stream *>(stream), &taskCfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete kernel;
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(XpuLaunchTest, XpuLaunchKernelV2_NoMocker_Fail)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
    MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
    rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    const char* stub = "";
    void* stubFunc = nullptr;
    Kernel * kernel = new (std::nothrow) Kernel(stubFunc, stub, static_cast<uint64_t>(0), program, 0);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_CPU);
    kernel->SetKernelType_(KERNEL_TYPE_AICPU);
    kernel->SetKernelLiteralNameDevAddr(nullptr, (void *)(&AicpuFuncFailMock), 0);
    rtStream_t stream;
    rtsStreamCreate(&stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RtArgsWithType argsWithType{};
    argsWithType.type = RT_ARGS_CPU_EX;
    rtCpuKernelArgs_t cpuArgsInfo = rtCpuKernelArgs_t{};
    argsWithType.args.cpuArgsInfo = &cpuArgsInfo;
    rtAicpuArgsEx_t baseArgs = rtAicpuArgsEx_t{};
    uint32_t param = 10;
    baseArgs.args = (void*)(&param);
    baseArgs.argsSize = sizeof(uint32_t);
    cpuArgsInfo.baseArgs = baseArgs;

    rtKernelLaunchCfg_t taskCfg;
    taskCfg.numAttrs = 1;
    rtLaunchKernelAttr_t attrs[1];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_DATA_DUMP;
    attrs[0].value.isDataDump = DATA_DUMP_DISABLE; // DATA_DUMP_ENABLE
    taskCfg.attrs = attrs;

    ApiImplDavid impl;
    error = impl.LaunchKernelV2(kernel, 1, &argsWithType, RtPtrToPtr<Stream *>(stream), &taskCfg);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete kernel;
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}