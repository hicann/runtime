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
#include <stdalign.h>
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
#include "stars_david.hpp"
#undef private
#undef protected
using namespace testing;
using namespace cce::runtime;

class CustomerStackSize : public testing::Test {
protected:
    static void SetUpTestCase() {}

    static void TearDownTestCase() {}

    virtual void SetUp()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        oldChipType = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        int64_t hardwareVersion = CHIP_DAVID << 8;
        Driver *driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver_, &Driver::GetDevInfo)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
            .will(returnValue(RT_ERROR_NONE));
        char *socVer = "Ascend910_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend910_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));
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
        rtInstance->SetChipType(oldChipType);
        GlobalContainer::SetRtChipType(oldChipType);
        GlobalMockObject::verify();
        rtInstance->deviceCustomerStackSize_ = 0;
    }

private:
    rtChipType_t oldChipType;
    bool isCfgOpWaitTaskTimeout{false};
    bool isCfgOpExcTaskTimeout{false};
};

TEST_F(CustomerStackSize, DeviceSetLimit)
{
    rtError_t error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 102400);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtSetDevice(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtDeviceReset(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CustomerStackSize, ConstructDavidMixSqeForDavinciTask1)
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
    taskInfo.stream = static_cast<Stream *>(stream);
    taskInfo.u.aicTaskInfo.kernel = &kernel;

    rtDavidSqe_t command = {};
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&taskInfo, &command, sqBaseAddr);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CustomerStackSize, ConstructDavidMixSqeForDavinciTask2)
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
    taskInfo.stream = static_cast<Stream *>(stream);
    taskInfo.u.aicTaskInfo.kernel = &kernel;

    rtDavidSqe_t command = {};
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&taskInfo, &command, sqBaseAddr);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CustomerStackSize, ConstructDavidMixSqeForDavinciTask3)
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
    kernel.SetMinStackSize2(KERNEL_STACK_SIZE_32K);
    kernel.SetMixType(MIX_AIC);
    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    taskInfo.bindFlag = false;
    taskInfo.stream = static_cast<Stream *>(stream);
    taskInfo.u.aicTaskInfo.kernel = &kernel;

    rtDavidSqe_t command = {};
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&taskInfo, &command, sqBaseAddr);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CustomerStackSize, ConstructDavidMixSqeForDavinciTask4)
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
    kernel.SetMixType(MIX_AIV);
    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    taskInfo.bindFlag = false;
    taskInfo.stream = static_cast<Stream *>(stream);
    taskInfo.u.aicTaskInfo.kernel = &kernel;

    rtDavidSqe_t command = {};
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&taskInfo, &command, sqBaseAddr);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CustomerStackSize, ConstructDavidMixSqeForDavinciTask5)
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

    ElfProgram prog(0);
    Kernel kernelPtr(NULL, "", 355, &prog, 10);
    kernelPtr.SetMinStackSize1(KERNEL_STACK_SIZE_32K + 1024);
    kernelPtr.SetMinStackSize2(KERNEL_STACK_SIZE_32K + 1024);
    kernelPtr.SetMixType(MIX_AIV);

    std::string kernelInfoExt = "abc";
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    kernelPtr.SetMixType(MIX_AIV);
    kernelPtr.SetOffset2(0);
    RtKernel rtKernel = {0};
    prog.kernels_ = &rtKernel;
    prog.elfData_->kernel_num = 1;
    rtKernel.funcType = KERNEL_FUNCTION_TYPE_AIC;
    rtKernel.name = "abc";
    prog.kernelNameMap_["abc"] = &kernelPtr;
    rtInstance->MixKernelRegister(&prog);
    prog.kernels_ = nullptr;
    prog.kernelNameMap_["abc"] = nullptr;
    prog.elfData_->kernel_num = 0;

    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    taskInfo.bindFlag = false;
    taskInfo.stream = static_cast<Stream *>(stream);
    taskInfo.u.aicTaskInfo.kernel = &kernelPtr;

    rtDavidSqe_t command = {};
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&taskInfo, &command, sqBaseAddr);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CustomerStackSize, ConstructDavidAICoreSqeForDavinciTask1)
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
    kernel.SetMixType(NO_MIX);
    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    taskInfo.bindFlag = false;
    taskInfo.stream = static_cast<Stream *>(stream);
    taskInfo.u.aicTaskInfo.kernel = &kernel;

    rtDavidSqe_t command = {};
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&taskInfo, &command, sqBaseAddr);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CustomerStackSize, ConstructDavidAICoreSqeForDavinciTask2)
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
    kernel.SetMixType(NO_MIX);
    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    taskInfo.bindFlag = false;
    taskInfo.stream = static_cast<Stream *>(stream);
    taskInfo.u.aicTaskInfo.kernel = &kernel;

    rtDavidSqe_t command = {};
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&taskInfo, &command, sqBaseAddr);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CustomerStackSize, ConstructDavidAivSqeForDavinciTask1)
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
    kernel.SetMixType(NO_MIX);
    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_KERNEL_AIVEC;
    taskInfo.bindFlag = false;
    taskInfo.stream = static_cast<Stream *>(stream);
    taskInfo.u.aicTaskInfo.kernel = &kernel;

    rtDavidSqe_t command = {};
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&taskInfo, &command, sqBaseAddr);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CustomerStackSize, ConstructDavidAivSqeForDavinciTask2)
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
    kernel.SetMixType(NO_MIX);
    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_KERNEL_AIVEC;
    taskInfo.bindFlag = false;
    taskInfo.stream = static_cast<Stream *>(stream);
    taskInfo.u.aicTaskInfo.kernel = &kernel;

    rtDavidSqe_t command = {};
    uint64_t sqBaseAddr = 0U;
    ToConstructDavidSqe(&taskInfo, &command, sqBaseAddr);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(CustomerStackSize, AllocCustomerStackPhyBaseFailed)
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

TEST_F(CustomerStackSize, AllocCustomerStackPhyBase)
{
    rtError_t error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, KERNEL_STACK_SIZE_32K);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    RawDevice *dev = new RawDevice(0);
    dev->Init();
    rtError_t ret = dev->AllocCustomerStackPhyBase();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete dev;
}

TEST_F(CustomerStackSize, AllocCustomerStackPhyBaseSuccess)
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

TEST_F(CustomerStackSize, AllocCustomerStackPhyBaseSuccess_align128B)
{
    rtError_t error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 102400);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    RawDevice *dev = new RawDevice(0);
    dev->Init();
    alignas(128) uint32_t tmp = 0;
    void *addr = &tmp;
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&addr, sizeof(void *)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    rtError_t ret = dev->AllocCustomerStackPhyBase();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete dev;
}

TEST_F(CustomerStackSize, AllocCustomerStackPhyBaseMinitV3)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    auto oldChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_MINI_V3);
    GlobalContainer::SetRtChipType(CHIP_MINI_V3);
    rtError_t error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, KERNEL_STACK_SIZE_32K);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    RawDevice *dev = new RawDevice(0);
    dev->Init();
    rtError_t ret = dev->AllocCustomerStackPhyBase();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete dev;
    rtInstance->SetChipType(oldChipType);
    GlobalContainer::SetRtChipType(oldChipType);
}

TEST_F(CustomerStackSize, FreeCustomerStackPhyBase)
{
    rtError_t error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, KERNEL_STACK_SIZE_32K);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    RawDevice *dev = new RawDevice(0);
    dev->Init();
    int32_t temp = 1;
    dev->customerStackPhyBase_ = &temp;
    dev->FreeCustomerStackPhyBase();
    EXPECT_EQ(temp, 1);
    delete dev;
}

TEST_F(CustomerStackSize, UpdateKernelsMinStackSizeInfo)
{
    ElfKernelInfo elfKernelInfo;
    elfKernelInfo.minStackSize = 102400;
    std::map<std::string, ElfKernelInfo *> kernelInfoMap = {{"stackSizeTest", &elfKernelInfo}};
    RtKernel kernel;
    kernel.name = "stackSizeTest";
    auto error = UpdateKernelsMinStackSizeInfo(kernelInfoMap, &kernel, 1);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}
