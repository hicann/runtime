/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "driver/ascend_hal.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "model.hpp"
#include "raw_device.hpp"
#include "module.hpp"
#include "notify.hpp"
#include "event.hpp"
#include "task_info.hpp"
#include "task_info.h"
#include "ffts_task.h"
#include "device/device_error_proc.hpp"
#include "program.hpp"
#include "uma_arg_loader.hpp"
#include "npu_driver.hpp"
#include "ctrl_res_pool.hpp"
#include "stream_sqcq_manage.hpp"
#include "davinci_kernel_task.h"
#include "profiler.hpp"
#include "rdma_task.h"
#include "thread_local_container.hpp"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

class CloudV2CustomerStackSize : public testing::Test {
protected:
    static void SetUpTestCase()
    {}

    static void TearDownTestCase()
    {}

    virtual void SetUp()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        isCfgOpWaitTaskTimeout = rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout;
        isCfgOpExcTaskTimeout = rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout;
        rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout = false;
        rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout = false;
    }

    virtual void TearDown()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->timeoutConfig_.isCfgOpWaitTaskTimeout = isCfgOpWaitTaskTimeout;
        rtInstance->timeoutConfig_.isCfgOpExcTaskTimeout = isCfgOpExcTaskTimeout;
        GlobalMockObject::verify();
        rtInstance->deviceCustomerStackSize_ = 0;
    }

private:
    rtChipType_t oldChipType;
    bool isCfgOpWaitTaskTimeout{false};
    bool isCfgOpExcTaskTimeout{false};
};

TEST_F(CloudV2CustomerStackSize, DeviceSetLimit)
{
    rtError_t error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 102400);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtSetDevice(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtDeviceReset(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CloudV2CustomerStackSize, getStackBufferMinSize32K)
{
    rtError_t error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 102400);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtSetDevice(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    ElfProgram program(0);
    Kernel kernel(NULL, "", 355, &program, 10);
    kernel.SetMinStackSize1(KERNEL_STACK_SIZE_16K);
    kernel.SetMinStackSize2(KERNEL_STACK_SIZE_16K);
    program.kernelNameMap_.insert({"test1", &kernel});

    const void *stack = nullptr;
    uint32_t stackSize = 0U;
    EXPECT_EQ(rtGetStackBuffer(&program, 0, 0, &stack, &stackSize), RT_ERROR_NONE);
    EXPECT_EQ(stackSize, KERNEL_STACK_SIZE_32K);
    error = rtDeviceReset(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    program.kernelNameMap_.clear();
}

TEST_F(CloudV2CustomerStackSize, getStackBufferMinSize64K)
{
    rtError_t error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 114688);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtSetDevice(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    ElfProgram program(0);
    Kernel kernel(NULL, "", 355, &program, 10);
    kernel.SetMinStackSize1(KERNEL_STACK_SIZE_16K * 4);
    kernel.SetMinStackSize2(KERNEL_STACK_SIZE_16K);
    program.kernelNameMap_.insert({"test1", &kernel});

    const void *stack = nullptr;
    uint32_t stackSize = 0U;
    EXPECT_EQ(rtGetStackBuffer(&program, 0, 0, &stack, &stackSize), RT_ERROR_NONE);
    EXPECT_EQ(stackSize, 114688);
    error = rtDeviceReset(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    program.kernelNameMap_.clear();
}

TEST_F(CloudV2CustomerStackSize, ConstructFftsMixSqeForDavinciTask)
{

    rtError_t error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 102400);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtSetDevice(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    rtContext_t ctx;
    rtError_t ret = RT_ERROR_NONE;
    ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ElfProgram program(0);
    Kernel kernel(NULL, "", 355, &program, 10);
    kernel.SetMinStackSize1(KERNEL_STACK_SIZE_32K + 1024);
    kernel.SetMinStackSize2(KERNEL_STACK_SIZE_32K + 1024);
    kernel.SetMixType(MIX_AIC_AIV_MAIN_AIC);
    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    taskInfo.bindFlag = false;
    taskInfo.stream = static_cast<Stream*>(stream);
    taskInfo.u.aicTaskInfo.kernel = &kernel;

    rtStarsSqe_t command = {};
    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_NONE));
    ConstructFftsMixSqeForDavinciTask(&taskInfo, &command);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CloudV2CustomerStackSize, ConstructFftsMixSqeForDavinciTask2)
{

    rtError_t error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 102400);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtSetDevice(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    rtContext_t ctx;
    rtError_t ret = RT_ERROR_NONE;
    ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ElfProgram program(0);
    Kernel kernel(NULL, "", 355, &program, 10);
    kernel.SetMinStackSize1(KERNEL_STACK_SIZE_32K);
    kernel.SetMinStackSize2(KERNEL_STACK_SIZE_32K);
    kernel.SetMixType(MIX_AIC_AIV_MAIN_AIC);
    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    taskInfo.bindFlag = false;
    taskInfo.stream = static_cast<Stream*>(stream);
    taskInfo.u.aicTaskInfo.kernel = &kernel;

    rtStarsSqe_t command = {};
    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_NONE));
    ConstructFftsMixSqeForDavinciTask(&taskInfo, &command);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CloudV2CustomerStackSize, ConstructFftsMixSqeForDavinciTask3)
{

    rtError_t error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 102400);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtSetDevice(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    rtContext_t ctx;
    rtError_t ret = RT_ERROR_NONE;
    ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Context *ctxPtr = (Context *)ctx;
    Stream *stmPtr = (Stream *)stream;
    std::list<Stream *> streamList;
    streamList.push_back(stmPtr);
    const mmTimespec startTime = mmGetTickCount();
    (void *)ctxPtr->SyncStreamsWithTimeout(streamList, -1 , startTime);

    ElfProgram program(0);
    program.SetStackSize(KERNEL_STACK_SIZE_16K);
    Kernel kernel(NULL, "", 355, &program, 10);
    kernel.SetMixType(MIX_AIC_AIV_MAIN_AIC);
    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    taskInfo.bindFlag = false;
    taskInfo.stream = static_cast<Stream*>(stream);
    taskInfo.u.aicTaskInfo.kernel = &kernel;

    rtStarsSqe_t command = {};
    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_NONE));
    ConstructFftsMixSqeForDavinciTask(&taskInfo, &command);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CloudV2CustomerStackSize, ConstructFftsMixSqeForDavinciTask4)
{
    rtError_t ret = RT_ERROR_NONE;
    ret = rtSetDevice(0);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ElfProgram program(0);
    program.SetStackSize(KERNEL_STACK_SIZE_16K);
    Kernel kernel(NULL, "", 355, &program, 10);
    kernel.SetMixType(MIX_AIC_AIV_MAIN_AIV);
    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    taskInfo.bindFlag = false;
    taskInfo.stream = static_cast<Stream*>(stream);
    taskInfo.u.aicTaskInfo.kernel = &kernel;

    rtStarsSqe_t command = {};
    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_NONE));

    std::array<qos_master_config_type, MAX_ACC_QOS_CFG_NUM> aicoreQosCfg = {};
    aicoreQosCfg[0].mode = 0;
    aicoreQosCfg[1].mode = 0;
    aicoreQosCfg[2].mode = 0;
    aicoreQosCfg[3].mode = 0;

    cce::runtime::RawDevice *dev = (cce::runtime::RawDevice*)(taskInfo.stream->Device_());
    dev->SetQosCfg(aicoreQosCfg[0], 0);
    dev->SetQosCfg(aicoreQosCfg[1], 1);
    dev->SetQosCfg(aicoreQosCfg[2], 2);
    dev->SetQosCfg(aicoreQosCfg[3], 3);
    ConstructFftsMixSqeForDavinciTask(&taskInfo, &command);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtDeviceReset(0);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
}


TEST_F(CloudV2CustomerStackSize, ConstructAICoreSqeForDavinciTask)
{

    rtError_t error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 102400);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtSetDevice(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    rtContext_t ctx;
    rtError_t ret = RT_ERROR_NONE;
    ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ElfProgram program(0);
    Kernel kernel(NULL, "", 355, &program, 10);
    kernel.SetMinStackSize1(KERNEL_STACK_SIZE_32K + 1024);
    kernel.SetMixType(NO_MIX);
    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    taskInfo.bindFlag = false;
    taskInfo.stream = static_cast<Stream*>(stream);
    taskInfo.u.aicTaskInfo.kernel = &kernel;

    rtStarsSqe_t command = {};
    ConstructAICoreSqeForDavinciTask(&taskInfo, &command);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CloudV2CustomerStackSize, ConstructAICoreSqeForDavinciTask2)
{

    rtError_t error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 102400);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtSetDevice(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    rtContext_t ctx;
    rtError_t ret = RT_ERROR_NONE;
    ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ElfProgram program(0);
    Kernel kernel(NULL, "", 355, &program, 10);
    kernel.SetMinStackSize1(KERNEL_STACK_SIZE_32K);
    kernel.SetMixType(NO_MIX);
    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    taskInfo.bindFlag = false;
    taskInfo.stream = static_cast<Stream*>(stream);
    taskInfo.u.aicTaskInfo.kernel = &kernel;

    rtStarsSqe_t command = {};
    ConstructAICoreSqeForDavinciTask(&taskInfo, &command);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CloudV2CustomerStackSize, ConstructAICoreSqeForDavinciTask3)
{

    rtError_t error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 102400);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtSetDevice(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    rtContext_t ctx;
    rtError_t ret = RT_ERROR_NONE;
    ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ElfProgram program(0);
    program.SetStackSize(KERNEL_STACK_SIZE_16K);
    Kernel kernel(NULL, "", 355, &program, 10);
    kernel.SetMixType(NO_MIX);
    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    taskInfo.bindFlag = false;
    taskInfo.stream = static_cast<Stream*>(stream);
    taskInfo.u.aicTaskInfo.kernel = &kernel;

    rtStarsSqe_t command = {};
    ConstructAICoreSqeForDavinciTask(&taskInfo, &command);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CloudV2CustomerStackSize, ConstructAICoreSqeForDavinciTask4)
{
    rtError_t ret = RT_ERROR_NONE;
    ret = rtSetDevice(0);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ElfProgram program(0);
    program.SetStackSize(KERNEL_STACK_SIZE_16K);
    Kernel kernel(NULL, "", 355, &program, 10);
    kernel.SetMixType(NO_MIX);
    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    taskInfo.bindFlag = false;
    taskInfo.stream = static_cast<Stream*>(stream);
    taskInfo.u.aicTaskInfo.kernel = &kernel;

    rtStarsSqe_t command = {};

    std::array<qos_master_config_type, MAX_ACC_QOS_CFG_NUM> aicoreQosCfg = {};
    aicoreQosCfg[0].mode = 0;
    aicoreQosCfg[1].mode = 0;
    aicoreQosCfg[2].mode = 0;
    aicoreQosCfg[3].mode = 0;

    cce::runtime::RawDevice *dev = (cce::runtime::RawDevice*)(taskInfo.stream->Device_());
    dev->SetQosCfg(aicoreQosCfg[0], 0);
    dev->SetQosCfg(aicoreQosCfg[1], 1);
    dev->SetQosCfg(aicoreQosCfg[2], 2);
    dev->SetQosCfg(aicoreQosCfg[3], 3);
    ConstructAICoreSqeForDavinciTask(&taskInfo, &command);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtDeviceReset(0);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
}

TEST_F(CloudV2CustomerStackSize, AllocCustomerStackPhyBaseFailed)
{
    rtError_t error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 102400);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    RawDevice *dev = new RawDevice(0);
    dev->Init();
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    rtError_t ret = dev->AllocCustomerStackPhyBase();
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    delete dev;
}

TEST_F(CloudV2CustomerStackSize, AllocCustomerStackPhyBase)
{
    rtError_t error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, KERNEL_STACK_SIZE_32K);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    RawDevice *dev = new RawDevice(0);
    dev->Init();
    rtError_t ret = dev->AllocCustomerStackPhyBase();
    dev->FreeCustomerStackPhyBase();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete dev;
}

TEST_F(CloudV2CustomerStackSize, AllocCustomerStackPhyBaseSuccess)
{
    rtError_t error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 102400);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    RawDevice *dev = new RawDevice(0);
    dev->Init();
    uint32_t tmp = 0;
    void *addr = &tmp;
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&addr, sizeof(void *)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    rtError_t ret = dev->AllocCustomerStackPhyBase();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete dev;
}

TEST_F(CloudV2CustomerStackSize, FreeCustomerStackPhyBase)
{
    rtError_t error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, KERNEL_STACK_SIZE_32K);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    RawDevice *dev = new RawDevice(0);
    dev->Init();
    int32_t temp = 1;
    // dev->customerStackPhyBase_ = &temp;
    dev->AllocCustomerStackPhyBase();
    dev->FreeCustomerStackPhyBase();
    EXPECT_EQ(temp, 1);
    delete dev;
}

TEST_F(CloudV2CustomerStackSize, UpdateKernelsMinStackSizeInfo)
{
    ElfKernelInfo elfKernelInfo;
    elfKernelInfo.minStackSize = 102400;
    std::map<std::string, ElfKernelInfo *> kernelInfoMap = {{"stackSizeTest", &elfKernelInfo}};
    RtKernel kernel;
    kernel.name = "stackSizeTest";
    auto error = UpdateKernelsMinStackSizeInfo(kernelInfoMap, &kernel, 1);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}