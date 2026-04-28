/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstdio>
#include <cstdlib>
#include <queue>

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include "runtime.hpp"
#include "context.hpp"
#include "kernel.hpp"
#include "stream.hpp"
#include "npu_driver.hpp"
#include "api.hpp"
#include "aicpu_c.hpp"
#include "raw_device.hpp"

using namespace testing;
using namespace cce::runtime;

namespace {
uint64_t stubArgs = 0x1234567890;
PlainProgram stubProgram(RT_KERNEL_ATTR_TYPE_AICPU);
int32_t stubFun = 0;
std::queue<rtError_t> expectedSubmitTaskResults = {};

Stream* GetDefaultStream()
{
    Context* ctx = nullptr;
    Api* api = Api::Instance();
    auto error = api->ContextGetCurrent(&ctx);
    EXPECT_EQ(error, RT_ERROR_NONE);

    return ctx->DefaultStream_();
}

void InitRtArgs(rtArgsEx_t& rtArgs)
{
    rtArgs.args = static_cast<void*>(&stubArgs);
    rtArgs.argsSize = sizeof(stubArgs);
}

void InitRtArgs(rtAicpuArgsEx_t& rtArgs)
{
    rtArgs.args = static_cast<void*>(&stubArgs);
    rtArgs.argsSize = sizeof(stubArgs);
}

void MockCopyAndDevAlloc(void* memBase, const NpuDriver* rawDrv)
{
    MOCKER(memcpy_s).stubs().will(returnValue(nullptr));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::DevMemAlloc)
        .stubs()
        .with(outBoundP(&memBase, sizeof(memBase)), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
}

rtError_t SubmitTaskStub(
    Device* device, TaskInfo* const taskObj, const rtTaskGenCallback callback, uint32_t* const flipTaskId,
    int32_t timeout)
{
    UNUSED(callback);
    UNUSED(flipTaskId);
    UNUSED(timeout);

    if (!expectedSubmitTaskResults.empty()) {
        rtError_t expectedResult = expectedSubmitTaskResults.front();
        expectedSubmitTaskResults.pop();
        if (expectedResult == RT_ERROR_NONE && taskObj != nullptr) {
            device->GetTaskFactory()->Recycle(taskObj);
        }
        return expectedResult;
    }
    return RT_ERROR_NONE;
}

void MockSubmitTask()
{
    Device* device = Runtime::Instance()->GetDevice(0, 0);
    MOCKER_CPP_VIRTUAL(device, &Device::SubmitTask)
        .stubs()
        .will(invoke(SubmitTaskStub));
}
}

class CloudV2AicpuKernelLaunchTest : public testing::Test {
protected:
    static void SetUpTestCase() {}

    static void TearDownTestCase() {}

    void SetUp() override
    {
        std::cout << "CloudV2AicpuKernelLaunchTest SetUp" << std::endl;
        rtSetDevice(0);
        std::cout << "CloudV2AicpuKernelLaunchTest SetUp end" << std::endl;
    }

    void TearDown() override
    {
        std::cout << "CloudV2AicpuKernelLaunchTest TearDown" << std::endl;
        expectedSubmitTaskResults = {};
        GlobalMockObject::verify();
        rtDeviceReset(0);
        std::cout << "CloudV2AicpuKernelLaunchTest TearDown end" << std::endl;
    }
};

TEST_F(CloudV2AicpuKernelLaunchTest, CPU_KERNEL_LAUNCH_TEST)
{
    rtError_t error = RT_ERROR_NONE;
    expectedSubmitTaskResults.push(RT_ERROR_NONE);
    expectedSubmitTaskResults.push(RT_ERROR_NONE);
    expectedSubmitTaskResults.push(RT_ERROR_DEVICE_INVALID);
    MockSubmitTask();

    auto stream = GetDefaultStream();
    char soName[] = "libDvpp.so";
    char kernelName[] = "DvppResize";
    rtKernelLaunchNames_t name = {soName, kernelName, ""};
    rtArgsEx_t argsInfo = {};
    InitRtArgs(argsInfo);
    error = StreamLaunchCpuKernel(&name, 1, &argsInfo, stream, RT_KERNEL_DEFAULT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = StreamLaunchCpuKernel(&name, 1, &argsInfo, stream, RT_KERNEL_HOST_ONLY);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = StreamLaunchCpuKernel(&name, 1, &argsInfo, stream, RT_KERNEL_HOST_ONLY);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2AicpuKernelLaunchTest, CPU_KERNEL_LAUNCH_EX_TEST)
{
    rtError_t error = RT_ERROR_NONE;
    expectedSubmitTaskResults.push(RT_ERROR_NONE);
    expectedSubmitTaskResults.push(RT_ERROR_DEVICE_INVALID);
    MockSubmitTask();

    auto stream = GetDefaultStream();
    auto args = static_cast<void*>(&stubArgs);
    auto argsSize = sizeof(stubArgs);
    error = StreamLaunchKernelEx(args, argsSize, RT_KERNEL_DEFAULT, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = StreamLaunchKernelEx(args, argsSize, RT_KERNEL_DEFAULT, stream);
    EXPECT_NE(error, RT_ERROR_NONE);
}

/*
 * test entry: Context::LaunchCpuKernelExWithArgs
 * test conditions:
 *     1.cpu args load with args size: 8 bytes;
 *     2.use UmaArgLoder::argAllocator_;
 *     3.mock H2D args copy and dev mem alloc;
 *     4.return success;
 */
TEST_F(CloudV2AicpuKernelLaunchTest, CPU_KERNEL_LAUNCH_EX_WITH_ARGS_TEST_00)
{
    rtError_t error = RT_ERROR_NONE;
    expectedSubmitTaskResults.push(RT_ERROR_NONE);
    expectedSubmitTaskResults.push(RT_ERROR_DEVICE_INVALID);
    expectedSubmitTaskResults.push(RT_ERROR_NONE);
    expectedSubmitTaskResults.push(RT_ERROR_DEVICE_INVALID);
    MockSubmitTask();

    void* memBase = reinterpret_cast<void*>(100);
    NpuDriver* rawDrv = new(std::nothrow) NpuDriver();
    MockCopyAndDevAlloc(memBase, rawDrv);

    auto stream = GetDefaultStream();
    rtAicpuArgsEx_t argsInfo = {};
    InitRtArgs(argsInfo);

    error = StreamLaunchCpuKernelExWithArgs(
        1, &argsInfo, nullptr, stream, RT_KERNEL_DEFAULT, KERNEL_TYPE_AICPU, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    auto origPcieBarFlag = stream->isHasPcieBar_;
    stream->isHasPcieBar_ = true;
    error = StreamLaunchCpuKernelExWithArgs(
        1, &argsInfo, nullptr, stream, RT_KERNEL_DEFAULT, KERNEL_TYPE_AICPU, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    Kernel* k1 = new(std::nothrow) Kernel("", 0UL, &stubProgram, RT_KERNEL_ATTR_TYPE_AICPU, 1);
    error = StreamLaunchCpuKernelExWithArgs(1, &argsInfo, nullptr, stream, RT_KERNEL_DEFAULT, KERNEL_TYPE_AICPU, k1, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = StreamLaunchCpuKernelExWithArgs(1, &argsInfo, nullptr, stream, RT_KERNEL_DEFAULT, KERNEL_TYPE_AICPU, k1, 1);
    EXPECT_NE(error, RT_ERROR_NONE);

    stream->isHasPcieBar_ = origPcieBarFlag;
    delete k1;
    delete rawDrv;
}

/*
 * test entry: Context::LaunchCpuKernelExWithArgs
 * test conditions:
 *     1.cpu args load with args size: 8bytes;
 *     2.use UmaArgLoder::argPcieBarAllocator_;
 *     3.mock H2D args copy and dev mem alloc;
 *     4.return success;
 */
TEST_F(CloudV2AicpuKernelLaunchTest, CPU_KERNEL_LAUNCH_EX_WITH_ARGS_TEST_01)
{
    rtError_t error = RT_ERROR_NONE;
    expectedSubmitTaskResults.push(RT_ERROR_NONE);
    expectedSubmitTaskResults.push(RT_ERROR_NONE);
    expectedSubmitTaskResults.push(RT_ERROR_DEVICE_INVALID);
    MockSubmitTask();

    void* memBase = reinterpret_cast<void*>(100);
    NpuDriver* rawDrv = new(std::nothrow) NpuDriver();
    uint32_t supportPcieBar = 1;
    MockCopyAndDevAlloc(memBase, rawDrv);

    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::CheckSupportPcieBarCopy)
        .stubs()
        .with(mockcpp::any(), outBound(supportPcieBar))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::GetRunMode).stubs().will(returnValue(RT_RUN_MODE_ONLINE));

    auto stream = GetDefaultStream();
    rtAicpuArgsEx_t argsInfo = {};
    InitRtArgs(argsInfo);

    error = StreamLaunchCpuKernelExWithArgs(
        1, &argsInfo, nullptr, stream, RT_KERNEL_DEFAULT, KERNEL_TYPE_AICPU, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Kernel* k2 = new(std::nothrow) Kernel("", 0UL, &stubProgram, RT_KERNEL_ATTR_TYPE_AICPU, 1);
    error = StreamLaunchCpuKernelExWithArgs(1, &argsInfo, nullptr, stream, RT_KERNEL_DEFAULT, KERNEL_TYPE_AICPU, k2, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = StreamLaunchCpuKernelExWithArgs(1, &argsInfo, nullptr, stream, RT_KERNEL_DEFAULT, KERNEL_TYPE_AICPU, k2, 1);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete k2;
    delete rawDrv;
}

/*
 * test entry: Context::LaunchCpuKernelExWithArgs
 * test conditions:
 *     1.cpu args load with args size: PCIE_BAR_COPY_SIZE + 1;
 *     2.use UmaArgLoder::maxArgAllocator_;
 *     3.mock H2D args copy and dev mem alloc;
 *     4.return success;
 */
TEST_F(CloudV2AicpuKernelLaunchTest, CPU_KERNEL_LAUNCH_EX_WITH_ARGS_TEST_02)
{
    rtError_t error = RT_ERROR_NONE;
    void* memBase = reinterpret_cast<void*>(100);
    NpuDriver* rawDrv = new(std::nothrow) NpuDriver();
    MockCopyAndDevAlloc(memBase, rawDrv);

    expectedSubmitTaskResults.push(RT_ERROR_NONE);
    expectedSubmitTaskResults.push(RT_ERROR_NONE);
    expectedSubmitTaskResults.push(RT_ERROR_DEVICE_INVALID);
    MockSubmitTask();

    auto stream = GetDefaultStream();
    rtAicpuArgsEx_t argsInfo = {};
    InitRtArgs(argsInfo);
    argsInfo.argsSize = stream->Context_()->Device_()->GetDevProperties().argsItemSize + 1;

    error = StreamLaunchCpuKernelExWithArgs(
        1, &argsInfo, nullptr, stream, RT_KERNEL_DEFAULT, KERNEL_TYPE_AICPU, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    argsInfo.kernelNameAddrOffset = 1;
    Kernel* k3 = new(std::nothrow) Kernel("", 0UL, &stubProgram, RT_KERNEL_ATTR_TYPE_AICPU, 1);
    error = StreamLaunchCpuKernelExWithArgs(1, &argsInfo, nullptr, stream, RT_KERNEL_DEFAULT, KERNEL_TYPE_AICPU, k3, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = StreamLaunchCpuKernelExWithArgs(1, &argsInfo, nullptr, stream, RT_KERNEL_DEFAULT, KERNEL_TYPE_AICPU, k3, 1);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete k3;
    delete rawDrv;
}