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
#define private public
#define protected public
#include "runtime.hpp"
#include "model.hpp"
#include "raw_device.hpp"
#include "module.hpp"
#include "notify.hpp"
#include "event.hpp"
#include "task_info.hpp"
#include "ffts_task.h"
#include "device/device_error_proc.hpp"
#include "program.hpp"
#include "uma_arg_loader.hpp"
#include "npu_driver.hpp"
#include "ctrl_res_pool.hpp"
#include "stream_sqcq_manage.hpp"
#include "davinci_kernel_task.h"
#include "kernel.hpp"
#include "kernel_utils.hpp"
#include "profiler.hpp"
#include "rdma_task.h"
#include "capture_model_utils.hpp"
#include "thread_local_container.hpp"
#include "../../data/elf.h"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

class CloudV2CaptureModelUpdateTest : public testing::Test {
protected:
    static void SetUpTestCase() {}

    static void TearDownTestCase() {}

    virtual void SetUp()
    {
        auto ret = rtSetDevice(0);
        EXPECT_EQ(ret, RT_ERROR_NONE);
        MOCKER(CheckCaptureModelSupportSoftwareSq).stubs().will(returnValue(RT_ERROR_NONE));
        Device* device = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
        MOCKER_CPP_VIRTUAL(device, &Device::CheckFeatureSupport).stubs().will(returnValue(true));

        for (uint32_t i = 0; i < sizeof(binary_) / sizeof(uint32_t); i++) {
            binary_[i] = i;
        }

        rtDevBinary_t devBin;
        devBin.magic = RT_DEV_BINARY_MAGIC_ELF;
        devBin.version = 2;
        devBin.data = (void*)elf_o;
        devBin.length = elf_o_len;
        ret = rtDevBinaryRegister(&devBin, &binHandle_);
        EXPECT_EQ(ret, RT_ERROR_NONE);
        ret = rtFunctionRegister(binHandle_, &function_, "foo", NULL, 0);
        EXPECT_EQ(ret, RT_ERROR_NONE);
        for (uint32_t i = 0; i < sizeof(binary_) / sizeof(uint32_t); i++) {
            binary_[i] = i;
        }
    }

    virtual void TearDown()
    {
        auto ret = rtDevBinaryUnRegister(binHandle_);
        EXPECT_EQ(ret, RT_ERROR_NONE);
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }

public:
    void* binHandle_;
    char function_;
    uint32_t binary_[32];
};

TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskGetParamsActualMemcpyParams)
{
    rtContext_t context = nullptr;
    ASSERT_EQ(rtCtxCreate(&context, 0, 0), RT_ERROR_NONE);
    rtStream_t stream = nullptr;
    ASSERT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    void* src = nullptr;
    void* dst = nullptr;
    ASSERT_EQ(rtMalloc(&src, 128U, RT_MEMORY_HBM, DEFAULT_MODULEID), RT_ERROR_NONE);
    ASSERT_EQ(rtMalloc(&dst, 128U, RT_MEMORY_HBM, DEFAULT_MODULEID), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL), RT_ERROR_NONE);
    ASSERT_EQ(rtMemcpyAsync(dst, 128U, src, 64U, RT_MEMCPY_DEFAULT, stream), RT_ERROR_NONE);
    ASSERT_EQ(rtMemcpy2dAsync(dst, 32U, src, 64U, 16U, 2U, RT_MEMCPY_DEVICE_TO_DEVICE, stream), RT_ERROR_NONE);
    rtModel_t model = nullptr;
    ASSERT_EQ(rtStreamEndCapture(stream, &model), RT_ERROR_NONE);
    uint32_t numStreams = 1U;
    rtStream_t streams[1] = {};
    ASSERT_EQ(rtModelGetStreams(model, streams, &numStreams), RT_ERROR_NONE);
    uint32_t numTasks = 0U;
    ASSERT_EQ(rtStreamGetTasks(streams[0], nullptr, &numTasks), RT_ERROR_NONE);
    std::vector<rtTask_t> tasks(numTasks);
    ASSERT_EQ(rtStreamGetTasks(streams[0], tasks.data(), &numTasks), RT_ERROR_NONE);
    bool found = false;
    uint32_t copy2DCount = 0U;
    for (const rtTask_t task : tasks) {
        if (static_cast<TaskInfo*>(task)->type != TS_TASK_TYPE_MEMCPY) {
            continue;
        }
        rtTaskParams queried = {};
        ASSERT_EQ(rtModelTaskGetParams(task, &queried), RT_ERROR_NONE);
        if (queried.type == RT_TASK_MEMCPY_2D) {
            EXPECT_EQ(queried.memcpy2DTaskParams.src, static_cast<char*>(src) + copy2DCount * 64U);
            EXPECT_EQ(queried.memcpy2DTaskParams.dst, static_cast<char*>(dst) + copy2DCount * 32U);
            EXPECT_EQ(queried.memcpy2DTaskParams.spitch, 64U);
            EXPECT_EQ(queried.memcpy2DTaskParams.dpitch, 32U);
            EXPECT_EQ(queried.memcpy2DTaskParams.width, 16U);
            EXPECT_EQ(queried.memcpy2DTaskParams.height, 2U);
            EXPECT_EQ(queried.memcpy2DTaskParams.kind, RT_MEMCPY_KIND_DEVICE_TO_DEVICE);
            ++copy2DCount;
            continue;
        }
        EXPECT_EQ(queried.type, RT_TASK_MEMCPY);
        EXPECT_EQ(queried.memcpyTaskParams.src, src);
        EXPECT_EQ(queried.memcpyTaskParams.dst, dst);
        EXPECT_EQ(queried.memcpyTaskParams.count, 64U);
        EXPECT_EQ(queried.memcpyTaskParams.kind, RT_MEMCPY_KIND_DEVICE_TO_DEVICE);
        EXPECT_NE(static_cast<TaskInfo*>(task)->u.memcpyAsyncTaskInfo.copyKind, RT_MEMCPY_DEFAULT);
        found = true;
    }
    EXPECT_TRUE(found);
    EXPECT_EQ(copy2DCount, 2U);
    EXPECT_EQ(rtModelDestroy(model), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
    EXPECT_EQ(rtFree(src), RT_ERROR_NONE);
    EXPECT_EQ(rtFree(dst), RT_ERROR_NONE);
    EXPECT_EQ(rtCtxDestroy(context), RT_ERROR_NONE);
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskGetParams_Success)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    void* args[] = {&ret, NULL};
    ret = rtKernelLaunch(&function_, 1, (void*)args, sizeof(args), NULL, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t model;
    ret = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numStreams = 1;
    rtStream_t inputStreams[numStreams];
    ret = rtModelGetStreams(model, inputStreams, &numStreams);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(numStreams, 1);

    uint32_t numTask = 2;
    rtTask_t inputTasks[numTask];
    ret = rtStreamGetTasks(inputStreams[0], inputTasks, &numTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtTaskParams params;
    ret = rtModelTaskGetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_KERNEL);

    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskSetParams_Success)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    void* args[] = {&ret, NULL};
    ret = rtKernelLaunch(&function_, 1, (void*)args, sizeof(args), NULL, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t model;
    ret = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numStreams = 1;
    rtStream_t inputStreams[numStreams];
    ret = rtModelGetStreams(model, inputStreams, &numStreams);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numTask = 2;
    rtTask_t inputTasks[numTask];
    ret = rtStreamGetTasks(inputStreams[0], inputTasks, &numTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtTaskParams params;
    memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    ret = rtModelTaskGetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_KERNEL);

    char rawInfo[] = "test_op_info_data";
    params.opInfoPtr = (void*)rawInfo;
    params.opInfoSize = sizeof(rawInfo);
    ret = rtModelTaskSetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

void CreateKernelTaskModel(rtContext_t& ctx, rtStream_t& stream, rtModel_t& model, char& function, rtTask_t& kernelTask)
{
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    void* args[] = {&ret, NULL};
    ret = rtKernelLaunch(&function, 1, (void*)args, sizeof(args), NULL, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t stmNum = 1;
    rtStream_t inputStreams[stmNum];
    ret = rtModelGetStreams(model, inputStreams, &stmNum);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numTask = 2;
    rtTask_t inputTasks[numTask];
    ret = rtStreamGetTasks(inputStreams[0], inputTasks, &numTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    kernelTask = inputTasks[0];
}

void ReleaseModelResource(rtContext_t& ctx, rtStream_t& stream, rtModel_t& model)
{
    rtError_t ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

// §15.8.6：CacheSimtKernelTaskParams 与 GetSimtKernelTaskParams 的成功路径末尾
// （CommitKernelUpdateInfo / AppendKernelTaskCommonParams）都无条件解引用 taskInfo->stream
// 并 dynamic_cast 成 CaptureModel，且前者假定 updateInfo 已由调用方
// （api_impl_standard_soc.cc:1295）分配，故只能在捕获态下用真实任务覆盖。
// 这里复用捕获到的 AICORE 任务（自带真实 Stream + CaptureModel），手工置 simtParamOffset
// 使 IsPureSimtTask 为真，从而无需 SIMT kernel 测试数据。
TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskSimtParamsCacheAndGetRoundTrip)
{
    rtContext_t ctx;
    rtStream_t stream;
    rtModel_t model;
    rtTask_t kernelTask = nullptr;
    CreateKernelTaskModel(ctx, stream, model, function_, kernelTask);

    TaskInfo* taskInfo = RtPtrToPtr<TaskInfo*>(kernelTask);
    ASSERT_NE(taskInfo, nullptr);
    ASSERT_TRUE((taskInfo->type == TS_TASK_TYPE_KERNEL_AICORE) || (taskInfo->type == TS_TASK_TYPE_KERNEL_AIVEC));
    Kernel* kernel = taskInfo->u.aicTaskInfo.kernel;
    ASSERT_NE(kernel, nullptr);

    // 捕获用的 fake elf 不保证携带参数摘要，按 950 既有写法用 setter 直改
    std::shared_ptr<ElfParamInfo[]> paramInfos(new ElfParamInfo[2]);
    paramInfos[0].info.offset = 0;
    paramInfos[0].info.size = 16;
    paramInfos[1].info.offset = 16;
    paramInfos[1].info.size = 32;
    kernel->SetParamInfos(paramInfos);
    kernel->SetParamCount(2);
    kernel->SetParamTotalSize(48ULL);
    kernel->SetHasParamSummary(true);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_NON_CPU);

    // 使 IsPureSimtTask 为真，任务才会被当作纯 SIMT 任务
    taskInfo->u.aicTaskInfo.simtParamOffset = 64U;

    // 直调时自备 updateInfo（生产路径由 api_impl_standard_soc.cc:1295 分配）
    TaskUpdateInfo* updateInfo = new (std::nothrow) TaskUpdateInfo();
    ASSERT_NE(updateInfo, nullptr);
    taskInfo->updateInfo = updateInfo;

    char src1[16] = {0};
    char src2[32] = {0};
    void* argsArray[2] = {src1, src2};

    rtTaskParams params;
    (void)memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    params.type = RT_TASK_SIMT_KERNEL;
    params.simtKernelTaskParams.func = kernel;
    params.simtKernelTaskParams.cfg = nullptr;
    params.simtKernelTaskParams.gridDimX = 2U;
    params.simtKernelTaskParams.gridDimY = 3U;
    params.simtKernelTaskParams.gridDimZ = 1U;
    params.simtKernelTaskParams.blockDimX = 32U;
    params.simtKernelTaskParams.blockDimY = 1U;
    params.simtKernelTaskParams.blockDimZ = 1U;
    params.simtKernelTaskParams.dynUbufSize = 128U;
    params.simtKernelTaskParams.argsType = RT_KERNEL_ARGS_ARRAY;
    params.simtKernelTaskParams.argsArray = argsArray;

    rtError_t ret = CacheSimtKernelTaskParams(taskInfo, &params, kernel);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    // 装配本身不发布：isValid 由调用方 api_impl_standard_soc.cc:1361 置位
    EXPECT_EQ(updateInfo->latestParams.isValid, 0U);
    EXPECT_EQ(updateInfo->latestParams.type, RT_TASK_SIMT_KERNEL);

    const SimtKernelTaskUpdateInfo& cached = updateInfo->latestParams.u.simtKernelUpdateParams;
    EXPECT_EQ(cached.kernel, kernel);
    EXPECT_EQ(cached.numBlocks, 6U);
    EXPECT_EQ(cached.gridDim.x, 2U);
    EXPECT_EQ(cached.gridDim.y, 3U);
    EXPECT_EQ(cached.blockDim.x, 32U);
    EXPECT_EQ(cached.dynUbufSize, 128U);
    EXPECT_EQ(cached.launchFunc, static_cast<const void*>(kernel));
    EXPECT_EQ(cached.argsType, RT_KERNEL_ARGS_ARRAY);
    // fixture 把 memcpy_s mock 成恒成功，故只断言回填指针非空，不断言拷贝内容
    ASSERT_NE(cached.argsArray, nullptr);

    // 模拟调用方发布，Get 侧的 isValid 守卫才会放行
    updateInfo->latestParams.isValid = 1U;

    // Get 往返：应还原成 SIMT 形态且标量字段逐项一致
    rtTaskParams out;
    (void)memset_s(&out, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    ret = GetSimtKernelTaskParams(taskInfo, &out);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(out.type, RT_TASK_SIMT_KERNEL);
    EXPECT_EQ(out.simtKernelTaskParams.func, static_cast<void*>(kernel));
    EXPECT_EQ(out.simtKernelTaskParams.gridDimX, 2U);
    EXPECT_EQ(out.simtKernelTaskParams.gridDimY, 3U);
    EXPECT_EQ(out.simtKernelTaskParams.gridDimZ, 1U);
    EXPECT_EQ(out.simtKernelTaskParams.blockDimX, 32U);
    EXPECT_EQ(out.simtKernelTaskParams.blockDimY, 1U);
    EXPECT_EQ(out.simtKernelTaskParams.blockDimZ, 1U);
    EXPECT_EQ(out.simtKernelTaskParams.dynUbufSize, 128U);
    EXPECT_EQ(out.simtKernelTaskParams.argsType, RT_KERNEL_ARGS_ARRAY);
    EXPECT_NE(out.simtKernelTaskParams.argsArray, nullptr);

    // 释放缓存，避免影响后续 rtModelDestroy 与其余用例
    TaskUpdateInfoFree(taskInfo);
    EXPECT_EQ(taskInfo->updateInfo, nullptr);

    ReleaseModelResource(ctx, stream, model);

    GlobalMockObject::verify();
}

// HOST_BUFFER 形态的缓存装配与 Get 往返：覆盖 DeepCopyHostArgsWithPlaceHolder →
// CopyPlaceHolderArray 的深拷贝链、CheckPlaceHolderOffsets 的成功返回，以及
// FillArgsFormFromCache 的 HOST_BUFFER 分支。与 SIMT 往返同理，成功路径末尾需要
// 真实 Stream + CaptureModel，故只能在捕获态下直调。
// 注意 fixture 把 memcpy_s mock 成恒成功且不实际拷贝，因此只断言指针与尺寸，不断言内容。
TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskHostBufferParamsCacheAndGetRoundTrip)
{
    rtContext_t ctx;
    rtStream_t stream;
    rtModel_t model;
    rtTask_t kernelTask = nullptr;
    CreateKernelTaskModel(ctx, stream, model, function_, kernelTask);

    TaskInfo* taskInfo = RtPtrToPtr<TaskInfo*>(kernelTask);
    ASSERT_NE(taskInfo, nullptr);
    Kernel* kernel = taskInfo->u.aicTaskInfo.kernel;
    ASSERT_NE(kernel, nullptr);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_NON_CPU);

    TaskUpdateInfo* updateInfo = new (std::nothrow) TaskUpdateInfo();
    ASSERT_NE(updateInfo, nullptr);
    taskInfo->updateInfo = updateInfo;

    char hostArgs[32] = {0};
    rtPlaceHolderInfo_t placeHolder{};
    placeHolder.addrOffset = 8U;
    placeHolder.dataOffset = 16U;

    // ---- 非 SIMT 形态 ----
    rtTaskParams params;
    (void)memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    params.type = RT_TASK_KERNEL;
    params.kernelTaskParams.funcHandle = kernel;
    params.kernelTaskParams.cfg = nullptr;
    params.kernelTaskParams.numBlocks = 4U;
    params.kernelTaskParams.argsType = RT_KERNEL_ARGS_HOST_BUFFER;
    params.kernelTaskParams.hostBuffer.hostArgs = hostArgs;
    params.kernelTaskParams.hostBuffer.hostArgsSize = sizeof(hostArgs);
    params.kernelTaskParams.hostBuffer.placeHolderArray = &placeHolder;
    params.kernelTaskParams.hostBuffer.placeHolderNum = 1U;

    rtError_t ret = CacheKernelTaskParams(taskInfo, &params, kernel);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(updateInfo->latestParams.isValid, 0U);
    EXPECT_EQ(updateInfo->latestParams.type, RT_TASK_KERNEL);

    const KernelTaskUpdateInfo& cached = updateInfo->latestParams.u.kernelUpdateParams;
    EXPECT_EQ(cached.argsType, RT_KERNEL_ARGS_HOST_BUFFER);
    EXPECT_EQ(cached.numBlocks, 4U);
    EXPECT_EQ(cached.launchFunc, static_cast<const void*>(kernel));
    EXPECT_EQ(cached.hostBuffer.hostArgsSize, sizeof(hostArgs));
    EXPECT_EQ(cached.hostBuffer.placeHolderNum, 1U);
    ASSERT_NE(cached.hostBuffer.hostArgs, nullptr);
    ASSERT_NE(cached.hostBuffer.placeHolderArray, nullptr);
    // 深拷贝：缓存持有的必须不是调用方传入的指针
    EXPECT_NE(cached.hostBuffer.hostArgs, static_cast<void*>(hostArgs));
    EXPECT_NE(cached.hostBuffer.placeHolderArray, &placeHolder);

    updateInfo->latestParams.isValid = 1U;
    rtTaskParams out;
    (void)memset_s(&out, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    ret = GetKernelTaskParams(taskInfo, &out);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(out.type, RT_TASK_KERNEL);
    EXPECT_EQ(out.kernelTaskParams.funcHandle, static_cast<void*>(kernel));
    EXPECT_EQ(out.kernelTaskParams.numBlocks, 4U);
    EXPECT_EQ(out.kernelTaskParams.argsType, RT_KERNEL_ARGS_HOST_BUFFER);
    EXPECT_EQ(out.kernelTaskParams.hostBuffer.hostArgsSize, sizeof(hostArgs));
    EXPECT_EQ(out.kernelTaskParams.hostBuffer.placeHolderNum, 1U);
    EXPECT_NE(out.kernelTaskParams.hostBuffer.hostArgs, nullptr);
    EXPECT_NE(out.kernelTaskParams.hostBuffer.placeHolderArray, nullptr);

    TaskUpdateInfoFree(taskInfo);
    EXPECT_EQ(taskInfo->updateInfo, nullptr);

    // ---- SIMT 形态：同一任务改判为纯 SIMT 后走 HOST_BUFFER 分支 ----
    taskInfo->u.aicTaskInfo.simtParamOffset = 64U;
    TaskUpdateInfo* simtUpdateInfo = new (std::nothrow) TaskUpdateInfo();
    ASSERT_NE(simtUpdateInfo, nullptr);
    taskInfo->updateInfo = simtUpdateInfo;

    rtTaskParams simtParams;
    (void)memset_s(&simtParams, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    simtParams.type = RT_TASK_SIMT_KERNEL;
    simtParams.simtKernelTaskParams.func = kernel;
    simtParams.simtKernelTaskParams.cfg = nullptr;
    simtParams.simtKernelTaskParams.gridDimX = 2U;
    simtParams.simtKernelTaskParams.gridDimY = 1U;
    simtParams.simtKernelTaskParams.gridDimZ = 1U;
    simtParams.simtKernelTaskParams.blockDimX = 32U;
    simtParams.simtKernelTaskParams.blockDimY = 1U;
    simtParams.simtKernelTaskParams.blockDimZ = 1U;
    simtParams.simtKernelTaskParams.dynUbufSize = 128U;
    simtParams.simtKernelTaskParams.argsType = RT_KERNEL_ARGS_HOST_BUFFER;
    simtParams.simtKernelTaskParams.hostBuffer.hostArgs = hostArgs;
    simtParams.simtKernelTaskParams.hostBuffer.hostArgsSize = sizeof(hostArgs);
    simtParams.simtKernelTaskParams.hostBuffer.placeHolderArray = &placeHolder;
    simtParams.simtKernelTaskParams.hostBuffer.placeHolderNum = 1U;

    ret = CacheSimtKernelTaskParams(taskInfo, &simtParams, kernel);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(simtUpdateInfo->latestParams.isValid, 0U);
    EXPECT_EQ(simtUpdateInfo->latestParams.type, RT_TASK_SIMT_KERNEL);

    const SimtKernelTaskUpdateInfo& simtCached = simtUpdateInfo->latestParams.u.simtKernelUpdateParams;
    EXPECT_EQ(simtCached.argsType, RT_KERNEL_ARGS_HOST_BUFFER);
    EXPECT_EQ(simtCached.numBlocks, 2U);
    EXPECT_EQ(simtCached.dynUbufSize, 128U);
    EXPECT_EQ(simtCached.hostBuffer.hostArgsSize, sizeof(hostArgs));
    EXPECT_EQ(simtCached.hostBuffer.placeHolderNum, 1U);
    ASSERT_NE(simtCached.hostBuffer.hostArgs, nullptr);
    ASSERT_NE(simtCached.hostBuffer.placeHolderArray, nullptr);
    EXPECT_NE(simtCached.hostBuffer.hostArgs, static_cast<void*>(hostArgs));
    EXPECT_NE(simtCached.hostBuffer.placeHolderArray, &placeHolder);

    simtUpdateInfo->latestParams.isValid = 1U;
    rtTaskParams simtOut;
    (void)memset_s(&simtOut, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    ret = GetSimtKernelTaskParams(taskInfo, &simtOut);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(simtOut.type, RT_TASK_SIMT_KERNEL);
    EXPECT_EQ(simtOut.simtKernelTaskParams.func, static_cast<void*>(kernel));
    EXPECT_EQ(simtOut.simtKernelTaskParams.argsType, RT_KERNEL_ARGS_HOST_BUFFER);
    EXPECT_EQ(simtOut.simtKernelTaskParams.dynUbufSize, 128U);
    EXPECT_EQ(simtOut.simtKernelTaskParams.hostBuffer.hostArgsSize, sizeof(hostArgs));
    EXPECT_EQ(simtOut.simtKernelTaskParams.hostBuffer.placeHolderNum, 1U);
    EXPECT_NE(simtOut.simtKernelTaskParams.hostBuffer.hostArgs, nullptr);
    EXPECT_NE(simtOut.simtKernelTaskParams.hostBuffer.placeHolderArray, nullptr);

    TaskUpdateInfoFree(taskInfo);
    EXPECT_EQ(taskInfo->updateInfo, nullptr);
    // 还原，避免污染后续用例对同一捕获任务的类型判定
    taskInfo->u.aicTaskInfo.simtParamOffset = 0U;

    ReleaseModelResource(ctx, stream, model);

    GlobalMockObject::verify();
}

// 非 SIMT 的 ARRAY / DEVICE_BUFFER 形态缓存装配与 Get 往返，外加零参数 kernel 的 ARRAY 短路。
// 覆盖 CacheKernelTaskParams 的 ARRAY 成功尾部与 DEVICE_BUFFER 零拷贝分支、
// CacheArgsArrayForm 的零参数短路，以及 FillArgsFormFromCache 的 DEVICE_BUFFER 分支
// （该分支由 if constexpr 限定，只对 KernelTaskUpdateInfo 实例化，SIMT 侧编译期即被剔除）。
TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskKernelParamsArrayAndDeviceBufferRoundTrip)
{
    rtContext_t ctx;
    rtStream_t stream;
    rtModel_t model;
    rtTask_t kernelTask = nullptr;
    CreateKernelTaskModel(ctx, stream, model, function_, kernelTask);

    TaskInfo* taskInfo = RtPtrToPtr<TaskInfo*>(kernelTask);
    ASSERT_NE(taskInfo, nullptr);
    Kernel* kernel = taskInfo->u.aicTaskInfo.kernel;
    ASSERT_NE(kernel, nullptr);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_NON_CPU);

    std::shared_ptr<ElfParamInfo[]> paramInfos(new ElfParamInfo[2]);
    paramInfos[0].info.offset = 0;
    paramInfos[0].info.size = 16;
    paramInfos[1].info.offset = 16;
    paramInfos[1].info.size = 32;
    kernel->SetParamInfos(paramInfos);
    kernel->SetParamCount(2);
    kernel->SetParamTotalSize(48ULL);
    kernel->SetHasParamSummary(true);

    TaskUpdateInfo* updateInfo = new (std::nothrow) TaskUpdateInfo();
    ASSERT_NE(updateInfo, nullptr);
    taskInfo->updateInfo = updateInfo;

    // ---- ARRAY 形态 ----
    char src1[16] = {0};
    char src2[32] = {0};
    void* argsArray[2] = {src1, src2};

    rtTaskParams params;
    (void)memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    params.type = RT_TASK_KERNEL;
    params.kernelTaskParams.funcHandle = kernel;
    params.kernelTaskParams.cfg = nullptr;
    params.kernelTaskParams.numBlocks = 8U;
    params.kernelTaskParams.argsType = RT_KERNEL_ARGS_ARRAY;
    params.kernelTaskParams.argsArray = argsArray;

    rtError_t ret = CacheKernelTaskParams(taskInfo, &params, kernel);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(updateInfo->latestParams.isValid, 0U);
    EXPECT_EQ(updateInfo->latestParams.type, RT_TASK_KERNEL);

    const KernelTaskUpdateInfo& cached = updateInfo->latestParams.u.kernelUpdateParams;
    EXPECT_EQ(cached.argsType, RT_KERNEL_ARGS_ARRAY);
    EXPECT_EQ(cached.numBlocks, 8U);
    EXPECT_EQ(cached.launchFunc, static_cast<const void*>(kernel));
    ASSERT_NE(cached.argsArray, nullptr);

    updateInfo->latestParams.isValid = 1U;
    rtTaskParams out;
    (void)memset_s(&out, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    ret = GetKernelTaskParams(taskInfo, &out);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(out.type, RT_TASK_KERNEL);
    EXPECT_EQ(out.kernelTaskParams.funcHandle, static_cast<void*>(kernel));
    EXPECT_EQ(out.kernelTaskParams.numBlocks, 8U);
    EXPECT_EQ(out.kernelTaskParams.argsType, RT_KERNEL_ARGS_ARRAY);
    EXPECT_NE(out.kernelTaskParams.argsArray, nullptr);

    // ---- DEVICE_BUFFER 形态：零拷贝，只缓存调用方传入的设备指针 ----
    TaskUpdateInfoFree(taskInfo);
    updateInfo = new (std::nothrow) TaskUpdateInfo();
    ASSERT_NE(updateInfo, nullptr);
    taskInfo->updateInfo = updateInfo;

    int deviceArgs = 0;
    (void)memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    params.type = RT_TASK_KERNEL;
    params.kernelTaskParams.funcHandle = kernel;
    params.kernelTaskParams.cfg = nullptr;
    params.kernelTaskParams.numBlocks = 8U;
    params.kernelTaskParams.argsType = RT_KERNEL_ARGS_DEVICE_BUFFER;
    params.kernelTaskParams.deviceBuffer.deviceArgs = &deviceArgs;
    params.kernelTaskParams.deviceBuffer.deviceArgsSize = sizeof(deviceArgs);

    ret = CacheKernelTaskParams(taskInfo, &params, kernel);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(updateInfo->latestParams.type, RT_TASK_KERNEL);

    const KernelTaskUpdateInfo& devCached = updateInfo->latestParams.u.kernelUpdateParams;
    EXPECT_EQ(devCached.argsType, RT_KERNEL_ARGS_DEVICE_BUFFER);
    EXPECT_EQ(devCached.deviceBuffer.deviceArgs, static_cast<void*>(&deviceArgs));
    EXPECT_EQ(devCached.deviceBuffer.deviceArgsSize, sizeof(deviceArgs));

    updateInfo->latestParams.isValid = 1U;
    (void)memset_s(&out, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    ret = GetKernelTaskParams(taskInfo, &out);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(out.kernelTaskParams.argsType, RT_KERNEL_ARGS_DEVICE_BUFFER);
    EXPECT_EQ(out.kernelTaskParams.deviceBuffer.deviceArgs, static_cast<void*>(&deviceArgs));
    EXPECT_EQ(out.kernelTaskParams.deviceBuffer.deviceArgsSize, sizeof(deviceArgs));

    // DEVICE_BUFFER 的两个入口守卫
    (void)memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    params.type = RT_TASK_KERNEL;
    params.kernelTaskParams.funcHandle = kernel;
    params.kernelTaskParams.argsType = RT_KERNEL_ARGS_DEVICE_BUFFER;
    params.kernelTaskParams.deviceBuffer.deviceArgs = nullptr;
    EXPECT_EQ(CacheKernelTaskParams(taskInfo, &params, kernel), RT_ERROR_INVALID_VALUE);
    params.kernelTaskParams.deviceBuffer.deviceArgs = &deviceArgs;
    params.kernelTaskParams.deviceBuffer.deviceArgsSize = 0U;
    EXPECT_EQ(CacheKernelTaskParams(taskInfo, &params, kernel), RT_ERROR_INVALID_VALUE);

    // ---- 零参数 kernel 的 ARRAY 短路：argsArray 保持为空 ----
    TaskUpdateInfoFree(taskInfo);
    updateInfo = new (std::nothrow) TaskUpdateInfo();
    ASSERT_NE(updateInfo, nullptr);
    taskInfo->updateInfo = updateInfo;

    kernel->SetParamCount(0);
    kernel->SetParamTotalSize(0ULL);
    (void)memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    params.type = RT_TASK_KERNEL;
    params.kernelTaskParams.funcHandle = kernel;
    params.kernelTaskParams.cfg = nullptr;
    params.kernelTaskParams.argsType = RT_KERNEL_ARGS_ARRAY;
    params.kernelTaskParams.argsArray = nullptr;

    ret = CacheKernelTaskParams(taskInfo, &params, kernel);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const KernelTaskUpdateInfo& zeroCached = updateInfo->latestParams.u.kernelUpdateParams;
    EXPECT_EQ(zeroCached.argsType, RT_KERNEL_ARGS_ARRAY);
    EXPECT_EQ(zeroCached.argsArray, nullptr);

    TaskUpdateInfoFree(taskInfo);
    EXPECT_EQ(taskInfo->updateInfo, nullptr);

    ReleaseModelResource(ctx, stream, model);

    GlobalMockObject::verify();
}

// func 为 nullptr 时在 api 层即被拒：ConvertFuncToKernel 先调 GetFunctionBySymbol，而
// ApiErrorDecorator::GetFunctionBySymbol 自身判空 symbol 并报 EE1004，返回 RT_ERROR_INVALID_VALUE
// （不是 INVALID_DEVICE_FUNCTION），于是 ConvertFuncToKernelImpl 走 else 分支上报并转换错误码，
// rtModelTaskSetParams 提前返回，根本到不了 decorator 的 SIMT 分支。
// 因此 GetValidatedObjectImpl 的空句柄契约在此路径不被触及，ApiErrorDecorator::TaskSetParams 里的
// null-kernel 守卫属纯防御（仅内部直调可达，由 rt_utest_api_kernel.cc 的
// TestRtTaskSetParams_SimtNullKernel 钉住）。真机 Ascend910_9362 实测返回 107000。
TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskSetParams_SimtNullFuncRejectedAtApiLayer)
{
    rtContext_t ctx;
    rtStream_t stream;
    rtModel_t model;
    rtTask_t kernelTask = nullptr;
    CreateKernelTaskModel(ctx, stream, model, function_, kernelTask);

    rtTaskParams params;
    (void)memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    params.type = RT_TASK_SIMT_KERNEL;
    params.simtKernelTaskParams.func = nullptr;
    params.simtKernelTaskParams.argsType = RT_KERNEL_ARGS_ARRAY;

    rtError_t ret = rtModelTaskSetParams(kernelTask, &params);
    EXPECT_EQ(ret, 107000); // RT_ERROR_INVALID_VALUE 的对外错误码，与本文件既有用例口径一致

    ReleaseModelResource(ctx, stream, model);

    GlobalMockObject::verify();
}

// func 指向可读但无 handle magic 的内存时，符号表查不到、句柄校验也失败，
// rtModelTaskSetParams 在 api 层的 convError 分支提前返回，不会带着无效 kernel 进入 decorator
TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskSetParams_InvalidFuncRejectedAtApiLayer)
{
    rtContext_t ctx;
    rtStream_t stream;
    rtModel_t model;
    rtTask_t kernelTask = nullptr;
    CreateKernelTaskModel(ctx, stream, model, function_, kernelTask);

    uint64_t notAKernel = 0U;
    rtTaskParams params;
    (void)memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    params.type = RT_TASK_KERNEL;
    params.kernelTaskParams.funcHandle = &notAKernel; // 可读，但 magic 为 0
    params.kernelTaskParams.argsType = RT_KERNEL_ARGS_ARRAY;

    rtError_t ret = rtModelTaskSetParams(kernelTask, &params);
    EXPECT_NE(ret, RT_ERROR_NONE); // 对外为 invalid handle 类错误码

    ReleaseModelResource(ctx, stream, model);

    GlobalMockObject::verify();
}

// Update 对 ARRAY 形态真正应用（此前是跳过）：非零参数 kernel 的 argsArray 经
// ConvertArgsArrayToArgsEx 展平后，走与 launch 完全相同的 LP_NO_MIX 加载路径。
// 判据：捕获时 rtKernelLaunch 传的 argsSize 是 sizeof(void*[2])=16，应用后 comm.argsSize 变为
// paramTotalSize=48，因此 48 能区分"已应用"与"被跳过"（跳过会保持 16）。
// 同时钉住 v100 的 LP_NO_MIX <-> mixOpt=0 配对：mixOpt 必须为 0，否则 SQE 构造会走
// DavinciFftsPlusTaskPoolH2D，把 128B FFTS context 写进 args 的前 128B（LP_NO_MIX 下 args
// 就在池块 offset 0），造成数据踩踏。
TEST_F(CloudV2CaptureModelUpdateTest, rtModelUpdate_AppliesArrayFormKernelTask)
{
    rtContext_t ctx;
    rtStream_t stream;
    rtModel_t model;
    rtTask_t kernelTask = nullptr;
    CreateKernelTaskModel(ctx, stream, model, function_, kernelTask);

    TaskInfo* taskInfo = RtPtrToPtr<TaskInfo*>(kernelTask);
    ASSERT_NE(taskInfo, nullptr);
    Kernel* kernel = taskInfo->u.aicTaskInfo.kernel;
    ASSERT_NE(kernel, nullptr);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_NON_CPU);
    // ARRAY 形态要求 kernel 带参数摘要；两个参数共 48B，偏移由 paramInfos 给出
    std::shared_ptr<ElfParamInfo[]> paramInfos(new ElfParamInfo[2]);
    paramInfos[0].info.offset = 0;
    paramInfos[0].info.size = 16;
    paramInfos[1].info.offset = 16;
    paramInfos[1].info.size = 32;
    kernel->SetParamInfos(paramInfos);
    kernel->SetParamCount(2);
    kernel->SetParamTotalSize(48ULL);
    kernel->SetHasParamSummary(true);

    // 捕获时 launch 的 argsSize，作为"被跳过"时的对照值
    ASSERT_EQ(taskInfo->u.aicTaskInfo.comm.argsSize, sizeof(void*) * 2U);

    // 先 Get 拿到 launch 缓存的原始参数（含可被 ConvertFuncToKernel 解析的 funcHandle），再改成 ARRAY 形态
    rtTaskParams params;
    (void)memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    rtError_t ret = rtModelTaskGetParams(kernelTask, &params);
    ASSERT_EQ(ret, RT_ERROR_NONE);

    char src1[16] = {0};
    char src2[32] = {0};
    void* argsArray[2] = {src1, src2};
    params.kernelTaskParams.argsType = RT_KERNEL_ARGS_ARRAY;
    params.kernelTaskParams.argsArray = argsArray;

    ret = rtModelTaskSetParams(kernelTask, &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelUpdate(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    // ARRAY 已被应用：argsSize 从 launch 的 16 变为 paramTotalSize 48
    EXPECT_EQ(taskInfo->u.aicTaskInfo.comm.argsSize, 48U);
    // LP_NO_MIX <-> mixOpt=0 配对锁定
    EXPECT_EQ(taskInfo->u.aicTaskInfo.mixOpt, 0U);

    // 应用不清缓存：Get 仍返回这次 Set 的 pending 参数
    rtTaskParams out;
    (void)memset_s(&out, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    ret = rtModelTaskGetParams(kernelTask, &out);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(out.kernelTaskParams.argsType, RT_KERNEL_ARGS_ARRAY);

    // 模型未被 FAULT：换成 HOST_BUFFER 形态再走一轮 Set + Update 仍应成功
    char hostArgs[16] = {0};
    (void)memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    params.type = RT_TASK_KERNEL;
    params.kernelTaskParams.funcHandle = out.kernelTaskParams.funcHandle;
    params.kernelTaskParams.numBlocks = 1U;
    params.kernelTaskParams.argsType = RT_KERNEL_ARGS_HOST_BUFFER;
    params.kernelTaskParams.hostBuffer.hostArgs = hostArgs;
    params.kernelTaskParams.hostBuffer.hostArgsSize = sizeof(hostArgs);
    ret = rtModelTaskSetParams(kernelTask, &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelUpdate(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(taskInfo->u.aicTaskInfo.comm.argsSize, sizeof(hostArgs));

    ReleaseModelResource(ctx, stream, model);

    GlobalMockObject::verify();
}

// ARRAY 形态的零参数退化路径：paramTotalSize==0 时 CacheArgsArrayForm 让 argsArray 保持为空，
// ConvertArgsArrayToArgsEx 产出 args=nullptr/argsSize=0/isNoNeedH2DCopy=1，于是 LP_NO_MIX 走
// AllocNoCopyPtr 建一个不拥有 device 内存的 handle（freeArgs=false），PostUpdateKernelParams 的
// WaitAsyncCopyComplete 因 freeArgs 为假而早退。整体必须成功且不使模型 FAULT。
TEST_F(CloudV2CaptureModelUpdateTest, rtModelUpdate_AppliesZeroParamArrayFormKernelTask)
{
    rtContext_t ctx;
    rtStream_t stream;
    rtModel_t model;
    rtTask_t kernelTask = nullptr;
    CreateKernelTaskModel(ctx, stream, model, function_, kernelTask);

    TaskInfo* taskInfo = RtPtrToPtr<TaskInfo*>(kernelTask);
    ASSERT_NE(taskInfo, nullptr);
    Kernel* kernel = taskInfo->u.aicTaskInfo.kernel;
    ASSERT_NE(kernel, nullptr);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_NON_CPU);
    kernel->SetHasParamSummary(true);
    kernel->SetParamCount(0);
    kernel->SetParamTotalSize(0ULL);

    rtTaskParams params;
    (void)memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    rtError_t ret = rtModelTaskGetParams(kernelTask, &params);
    ASSERT_EQ(ret, RT_ERROR_NONE);
    params.kernelTaskParams.argsType = RT_KERNEL_ARGS_ARRAY;
    params.kernelTaskParams.argsArray = nullptr;

    ret = rtModelTaskSetParams(kernelTask, &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelUpdate(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    // 零参数：argsSize 归零，mixOpt 仍为 0
    EXPECT_EQ(taskInfo->u.aicTaskInfo.comm.argsSize, 0U);
    EXPECT_EQ(taskInfo->u.aicTaskInfo.mixOpt, 0U);

    rtTaskParams out;
    (void)memset_s(&out, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    ret = rtModelTaskGetParams(kernelTask, &out);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(out.kernelTaskParams.argsType, RT_KERNEL_ARGS_ARRAY);

    ReleaseModelResource(ctx, stream, model);

    GlobalMockObject::verify();
}

// mix kernel 的 mixOpt 复位守卫。capture 期 launch 走 LP_MIX 时 mixOpt = !stm->IsModelStream()，
// 而 launch 用的是用户流（未 SetModel），故 capture 后 mixOpt=1；更新时 stm 是模型流，且
// UpdateKernelParams 根本不写 mixOpt，AicTaskInit -> AicTaskInitCommon 把它复位为 0。
// 这个 1 -> 0 的翻转必须成立：v100 的 LoadKernelArgs 恒用 LP_NO_MIX（args 在池块 offset 0），
// 若 mixOpt 残留为 1，SQE 构造会走 DavinciFftsPlusTaskPoolH2D，把 128B FFTS context 写进
// args 的前 128B，造成数据踩踏。
// 翻转本身不泄漏：TaskClearForUpdate 在 AicTaskInit 之前执行，读到的是旧 mixOpt=1，
// 与旧 descBuf（别名池块）的所有权配对，故跳过 DevMemFree 是正确的。
TEST_F(CloudV2CaptureModelUpdateTest, rtModelUpdate_ResetsMixOptForMixKernelTask)
{
    rtContext_t ctx;
    rtStream_t stream;
    rtModel_t model;
    rtTask_t kernelTask = nullptr;
    CreateKernelTaskModel(ctx, stream, model, function_, kernelTask);

    TaskInfo* taskInfo = RtPtrToPtr<TaskInfo*>(kernelTask);
    ASSERT_NE(taskInfo, nullptr);
    Kernel* kernel = taskInfo->u.aicTaskInfo.kernel;
    ASSERT_NE(kernel, nullptr);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_NON_CPU);
    kernel->SetMixType(MIX_AIC);

    // 模拟 capture 期 LP_MIX 加载后的状态：mixOpt=1 且 descBuf 别名 args 池块头
    taskInfo->u.aicTaskInfo.mixOpt = 1U;

    char hostArgs[16] = {0};
    rtTaskParams params;
    (void)memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    rtError_t ret = rtModelTaskGetParams(kernelTask, &params);
    ASSERT_EQ(ret, RT_ERROR_NONE);
    params.kernelTaskParams.argsType = RT_KERNEL_ARGS_HOST_BUFFER;
    params.kernelTaskParams.hostBuffer.hostArgs = hostArgs;
    params.kernelTaskParams.hostBuffer.hostArgsSize = sizeof(hostArgs);

    ret = rtModelTaskSetParams(kernelTask, &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelUpdate(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    // mix kernel 也必须复位为 0，与 LP_NO_MIX 配对
    EXPECT_EQ(taskInfo->u.aicTaskInfo.mixOpt, 0U);
    EXPECT_EQ(taskInfo->u.aicTaskInfo.comm.argsSize, sizeof(hostArgs));

    ReleaseModelResource(ctx, stream, model);

    GlobalMockObject::verify();
}

// Update 对 SIMT 任务跳过而非报错：Set 成功、Update 整体成功且模型不进入 FAULT。
// SIMT 任务此前会落到 UpdateCachedParamsToTask 的 default 分支报 EE1003 并使模型 FAULT。
TEST_F(CloudV2CaptureModelUpdateTest, rtModelUpdate_SkipsSimtKernelTask)
{
    rtContext_t ctx;
    rtStream_t stream;
    rtModel_t model;
    rtTask_t kernelTask = nullptr;
    CreateKernelTaskModel(ctx, stream, model, function_, kernelTask);

    TaskInfo* taskInfo = RtPtrToPtr<TaskInfo*>(kernelTask);
    ASSERT_NE(taskInfo, nullptr);
    Kernel* kernel = taskInfo->u.aicTaskInfo.kernel;
    ASSERT_NE(kernel, nullptr);
    // 通过 CheckSimtKernelCapability：VF 类型为纯 SIMT 且带参数摘要（AIV_TYPE_SIMT_VF_ONLY 为 3）
    kernel->SetKernelVfType_(3U);
    kernel->SetHasParamSummary(true);
    kernel->SetParamCount(0);
    kernel->SetParamTotalSize(0ULL);
    // 通过 CacheSimtKernelTaskParams 的 IsPureSimtTask 守卫
    taskInfo->u.aicTaskInfo.simtParamOffset = 64U;

    rtTaskParams params;
    (void)memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    rtError_t ret = rtModelTaskGetParams(kernelTask, &params);
    ASSERT_EQ(ret, RT_ERROR_NONE);
    void* const launchFunc = params.kernelTaskParams.funcHandle;

    (void)memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    params.type = RT_TASK_SIMT_KERNEL;
    params.simtKernelTaskParams.func = launchFunc;
    params.simtKernelTaskParams.gridDimX = 1U;
    params.simtKernelTaskParams.gridDimY = 1U;
    params.simtKernelTaskParams.gridDimZ = 1U;
    params.simtKernelTaskParams.blockDimX = 1U;
    params.simtKernelTaskParams.blockDimY = 1U;
    params.simtKernelTaskParams.blockDimZ = 1U;
    params.simtKernelTaskParams.argsType = RT_KERNEL_ARGS_ARRAY;
    params.simtKernelTaskParams.argsArray = nullptr;

    ret = rtModelTaskSetParams(kernelTask, &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    // SIMT 任务在 Update 中被跳过：整体成功，模型不进入 FAULT
    ret = rtModelUpdate(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    // 模型仍可用，Get 返回 SIMT 形态的 pending 参数
    rtTaskParams out;
    (void)memset_s(&out, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    ret = rtModelTaskGetParams(kernelTask, &out);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(out.type, RT_TASK_SIMT_KERNEL);
    EXPECT_EQ(out.simtKernelTaskParams.argsType, RT_KERNEL_ARGS_ARRAY);

    ReleaseModelResource(ctx, stream, model);

    GlobalMockObject::verify();
}

// 旧形态（args/isHostArgs/argsSize）在捕获态下的完整往返：Set 按历史语义把宿主参数块深拷贝
// 缓存为 HOST_BUFFER 形态，Get 同时给出新口径（argsType/hostBuffer）与兼容回填的旧三字段
// （args 为任务实际加载使用的 Device 地址、isHostArgs 固定 0、argsSize 取 comm.argsSize）。
// 成功路径必须在捕获态下跑：CommitKernelUpdateInfo 会解引用 taskInfo->stream 并
// dynamic_cast 成 CaptureModel。
TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskKernelParamsLegacyArgsFormRoundTrip)
{
    rtContext_t ctx;
    rtStream_t stream;
    rtModel_t model;
    rtTask_t kernelTask = nullptr;
    CreateKernelTaskModel(ctx, stream, model, function_, kernelTask);

    TaskInfo* taskInfo = RtPtrToPtr<TaskInfo*>(kernelTask);
    ASSERT_NE(taskInfo, nullptr);
    Kernel* kernel = taskInfo->u.aicTaskInfo.kernel;
    ASSERT_NE(kernel, nullptr);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_NON_CPU);

    TaskUpdateInfo* updateInfo = new (std::nothrow) TaskUpdateInfo();
    ASSERT_NE(updateInfo, nullptr);
    taskInfo->updateInfo = updateInfo;

    // 兼容回填所依据的 comm 值，用于断言 Get 的旧三字段口径
    void* const commArgs = taskInfo->u.aicTaskInfo.comm.args;
    const size_t commArgsSize = static_cast<size_t>(taskInfo->u.aicTaskInfo.comm.argsSize);

    char legacyArgs[16] = {0};
    rtTaskParams params;
    (void)memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    params.type = RT_TASK_KERNEL;
    params.kernelTaskParams.funcHandle = kernel;
    params.kernelTaskParams.cfg = nullptr;
    params.kernelTaskParams.numBlocks = 1U;
    // 旧形态：argsType 留 0，只填三字段
    params.kernelTaskParams.args = legacyArgs;
    params.kernelTaskParams.isHostArgs = 1U;
    params.kernelTaskParams.argsSize = sizeof(legacyArgs);

    rtError_t ret = CacheKernelTaskParams(taskInfo, &params, kernel);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(updateInfo->latestParams.isValid, 0U);
    EXPECT_EQ(updateInfo->latestParams.type, RT_TASK_KERNEL);

    const KernelTaskUpdateInfo& cached = updateInfo->latestParams.u.kernelUpdateParams;
    // 旧宿主形态被翻译为 HOST_BUFFER，且是深拷贝
    EXPECT_EQ(cached.argsType, RT_KERNEL_ARGS_HOST_BUFFER);
    EXPECT_EQ(cached.hostBuffer.hostArgsSize, sizeof(legacyArgs));
    EXPECT_EQ(cached.hostBuffer.placeHolderNum, 0U);
    EXPECT_EQ(cached.hostBuffer.placeHolderArray, nullptr);
    ASSERT_NE(cached.hostBuffer.hostArgs, nullptr);
    EXPECT_NE(cached.hostBuffer.hostArgs, static_cast<void*>(legacyArgs));

    updateInfo->latestParams.isValid = 1U;
    rtTaskParams out;
    (void)memset_s(&out, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    ret = GetKernelTaskParams(taskInfo, &out);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    // 新口径
    EXPECT_EQ(out.type, RT_TASK_KERNEL);
    EXPECT_EQ(out.kernelTaskParams.argsType, RT_KERNEL_ARGS_HOST_BUFFER);
    EXPECT_EQ(out.kernelTaskParams.hostBuffer.hostArgsSize, sizeof(legacyArgs));
    EXPECT_NE(out.kernelTaskParams.hostBuffer.hostArgs, nullptr);
    // 兼容回填的旧三字段：恒为任务实际加载使用的 Device 地址，isHostArgs 固定 0
    EXPECT_EQ(out.kernelTaskParams.args, commArgs);
    EXPECT_EQ(out.kernelTaskParams.isHostArgs, 0U);
    EXPECT_EQ(out.kernelTaskParams.argsSize, commArgsSize);

    TaskUpdateInfoFree(taskInfo);
    EXPECT_EQ(taskInfo->updateInfo, nullptr);

    ReleaseModelResource(ctx, stream, model);

    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelKernelTaskInvalidParam)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    void* args[] = {&ret, NULL};
    ret = rtKernelLaunch(&function_, 1, (void*)args, sizeof(args), NULL, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    void* devAddr;
    ret = rtMalloc(&devAddr, 64U, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtsValueWrite(devAddr, 1, 0, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t model;
    ret = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t stmNum = 1;
    rtStream_t inputStreams[stmNum];
    ret = rtModelGetStreams(model, inputStreams, &stmNum);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numTask = 3;
    rtTask_t inputTasks[numTask];
    ret = rtStreamGetTasks(inputStreams[0], inputTasks, &numTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtTask_t kernelTask = inputTasks[0];
    rtTask_t valueTask = inputTasks[1];

    rtLaunchKernelAttrVal_t attrValue;
    ret = rtModelKernelTaskGetAttribute(valueTask, RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE, &attrValue);
    EXPECT_EQ(ret, 107000);

    rtTaskParams params;
    ret = rtModelTaskGetParams(kernelTask, &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelTaskSetParams(valueTask, &params);
    EXPECT_EQ(ret, 107000);

    ret = rtFree(devAddr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ReleaseModelResource(ctx, stream, model);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelKernelTaskGetAttribute001)
{
    rtContext_t ctx;
    rtStream_t stream;
    rtModel_t model;
    rtTask_t kernelTask;
    CreateKernelTaskModel(ctx, stream, model, function_, kernelTask);

    rtTaskParams params;
    rtError_t ret = rtModelTaskGetParams(kernelTask, &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_KERNEL);

    rtLaunchKernelAttrVal_t attrValue;
    ret = rtModelKernelTaskGetAttribute(kernelTask, RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE, &attrValue);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const uint8_t originalSchemMode = attrValue.schemMode;

    rtLaunchKernelAttr_t attr = {RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE, 1};
    rtKernelLaunchCfg_t cfg = {&attr, 1};
    params.kernelTaskParams.cfg = &cfg;
    ret = rtModelTaskSetParams(kernelTask, &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelKernelTaskGetAttribute(kernelTask, RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE, &attrValue);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(attrValue.schemMode, originalSchemMode);

    ReleaseModelResource(ctx, stream, model);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelKernelTaskGetAttribute002)
{
    rtContext_t ctx;
    rtStream_t stream;
    rtModel_t model;
    rtTask_t kernelTask;
    CreateKernelTaskModel(ctx, stream, model, function_, kernelTask);

    rtTaskParams params;
    rtError_t ret = rtModelTaskGetParams(kernelTask, &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtLaunchKernelAttrVal_t attrValue;
    ret = rtModelKernelTaskGetAttribute(kernelTask, RT_LAUNCH_KERNEL_ATTR_DYN_UBUF_SIZE, &attrValue);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const uint32_t originalDynUBufSize = attrValue.dynUBufSize;

    rtLaunchKernelAttr_t attr = {RT_LAUNCH_KERNEL_ATTR_DYN_UBUF_SIZE, 2};
    rtKernelLaunchCfg_t cfg = {&attr, 1};
    params.kernelTaskParams.cfg = &cfg;
    ret = rtModelTaskSetParams(kernelTask, &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelKernelTaskGetAttribute(kernelTask, RT_LAUNCH_KERNEL_ATTR_DYN_UBUF_SIZE, &attrValue);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(attrValue.dynUBufSize, originalDynUBufSize);

    ReleaseModelResource(ctx, stream, model);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelKernelTaskGetAttribute003)
{
    rtContext_t ctx;
    rtStream_t stream;
    rtModel_t model;
    rtTask_t kernelTask;
    CreateKernelTaskModel(ctx, stream, model, function_, kernelTask);

    rtTaskParams params;
    rtError_t ret = rtModelTaskGetParams(kernelTask, &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtLaunchKernelAttrVal_t attrValue;
    ret = rtModelKernelTaskGetAttribute(kernelTask, RT_LAUNCH_KERNEL_ATTR_DATA_DUMP, &attrValue);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const uint8_t originalDataDump = attrValue.isDataDump;

    rtLaunchKernelAttr_t attr = {RT_LAUNCH_KERNEL_ATTR_DATA_DUMP, 1};
    rtKernelLaunchCfg_t cfg = {&attr, 1};
    params.kernelTaskParams.cfg = &cfg;
    ret = rtModelTaskSetParams(kernelTask, &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelKernelTaskGetAttribute(kernelTask, RT_LAUNCH_KERNEL_ATTR_DATA_DUMP, &attrValue);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(attrValue.isDataDump, originalDataDump);

    ReleaseModelResource(ctx, stream, model);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelKernelTaskGetAttribute004)
{
    rtContext_t ctx;
    rtStream_t stream;
    rtModel_t model;
    rtTask_t kernelTask;
    CreateKernelTaskModel(ctx, stream, model, function_, kernelTask);

    rtTaskParams params;
    rtError_t ret = rtModelTaskGetParams(kernelTask, &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtLaunchKernelAttrVal_t attrValue;
    ret = rtModelKernelTaskGetAttribute(kernelTask, RT_LAUNCH_KERNEL_ATTR_TIMEOUT, &attrValue);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const uint32_t originalTimeout = attrValue.timeout;

    rtLaunchKernelAttr_t attr = {RT_LAUNCH_KERNEL_ATTR_TIMEOUT, 100};
    rtKernelLaunchCfg_t cfg = {&attr, 1};
    params.kernelTaskParams.cfg = &cfg;
    ret = rtModelTaskSetParams(kernelTask, &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelKernelTaskGetAttribute(kernelTask, RT_LAUNCH_KERNEL_ATTR_TIMEOUT, &attrValue);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(attrValue.timeout, originalTimeout);

    ReleaseModelResource(ctx, stream, model);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelKernelTaskGetAttribute005)
{
    rtContext_t ctx;
    rtStream_t stream;
    rtModel_t model;
    rtTask_t kernelTask;
    CreateKernelTaskModel(ctx, stream, model, function_, kernelTask);

    rtTaskParams params;
    rtError_t ret = rtModelTaskGetParams(kernelTask, &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtLaunchKernelAttrVal_t attrValue;
    ret = rtModelKernelTaskGetAttribute(kernelTask, RT_LAUNCH_KERNEL_ATTR_TIMEOUT_US, &attrValue);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const auto originalTimeoutUs = attrValue.timeoutUs;

    rtLaunchKernelAttr_t attr;
    attr.id = RT_LAUNCH_KERNEL_ATTR_TIMEOUT_US;
    attr.value.timeoutUs = {100, 0};
    rtKernelLaunchCfg_t cfg = {&attr, 1};
    params.kernelTaskParams.cfg = &cfg;
    ret = rtModelTaskSetParams(kernelTask, &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelKernelTaskGetAttribute(kernelTask, RT_LAUNCH_KERNEL_ATTR_TIMEOUT_US, &attrValue);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(attrValue.timeoutUs.timeoutLow, originalTimeoutUs.timeoutLow);
    EXPECT_EQ(attrValue.timeoutUs.timeoutHigh, originalTimeoutUs.timeoutHigh);

    ReleaseModelResource(ctx, stream, model);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelKernelTaskGetAttribute006)
{
    rtContext_t ctx;
    rtStream_t stream;
    rtModel_t model;
    rtTask_t kernelTask;
    CreateKernelTaskModel(ctx, stream, model, function_, kernelTask);

    rtTaskParams params;
    rtError_t ret = rtModelTaskGetParams(kernelTask, &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtLaunchKernelAttrVal_t attrValue;
    ret = rtModelKernelTaskGetAttribute(kernelTask, RT_LAUNCH_KERNEL_ATTR_ENGINE_TYPE, &attrValue);
    EXPECT_EQ(ret, 107000);
    ret = rtModelKernelTaskGetAttribute(kernelTask, RT_LAUNCH_KERNEL_ATTR_MAX, &attrValue);
    EXPECT_EQ(ret, 107000);

    ReleaseModelResource(ctx, stream, model);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelKernelTaskGetAttributeEnableProfiling)
{
    rtContext_t ctx;
    rtStream_t stream;
    rtModel_t model;
    rtTask_t kernelTask;
    CreateKernelTaskModel(ctx, stream, model, function_, kernelTask);

    rtLaunchKernelAttrVal_t attrValue = {};
    rtError_t ret = rtModelKernelTaskGetAttribute(kernelTask, RT_LAUNCH_KERNEL_ATTR_ENABLE_PROFILING, &attrValue);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(attrValue.enableProfiling, 0U);

    rtTaskParams params = {};
    ret = rtModelTaskGetParams(kernelTask, &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtLaunchKernelAttr_t attr = {};
    attr.id = RT_LAUNCH_KERNEL_ATTR_ENABLE_PROFILING;
    attr.value.enableProfiling = 1U;
    rtKernelLaunchCfg_t cfg = {&attr, 1U};
    params.kernelTaskParams.cfg = &cfg;
    ret = rtModelTaskSetParams(kernelTask, &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelUpdate(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    attrValue.enableProfiling = 0U;
    ret = rtModelKernelTaskGetAttribute(kernelTask, RT_LAUNCH_KERNEL_ATTR_ENABLE_PROFILING, &attrValue);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(attrValue.enableProfiling, 1U);

    ReleaseModelResource(ctx, stream, model);
    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelUpdate_Success)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    void* args[] = {&ret, NULL};
    ret = rtKernelLaunch(&function_, 1, (void*)args, sizeof(args), NULL, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t model;
    ret = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numStreams = 1;
    rtStream_t inputStreams[numStreams];
    ret = rtModelGetStreams(model, inputStreams, &numStreams);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numTask = 2;
    rtTask_t inputTasks[numTask];
    ret = rtStreamGetTasks(inputStreams[0], inputTasks, &numTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtTaskParams params;
    memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    ret = rtModelTaskGetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_KERNEL);

    ret = rtModelTaskSetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelUpdate(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskDisable_Success)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    void* args[] = {&ret, NULL};
    ret = rtKernelLaunch(&function_, 1, (void*)args, sizeof(args), NULL, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t model;
    ret = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numStreams = 1;
    rtStream_t inputStreams[numStreams];
    ret = rtModelGetStreams(model, inputStreams, &numStreams);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numTask = 2;
    rtTask_t inputTasks[numTask];
    ret = rtStreamGetTasks(inputStreams[0], inputTasks, &numTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtTaskParams params;
    memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    ret = rtModelTaskGetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_KERNEL);

    ret = rtModelTaskDisable(inputTasks[0]);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelUpdate(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

// 纯 SIMT 任务的禁用：ConvertTaskType 依 simtParamOffset 将任务归类为 RT_TASK_SIMT_KERNEL，
// 禁用白名单须覆盖该类型（回归：归类变更前 SIMT 任务按 RT_TASK_KERNEL 可禁用）。
// Disable 经 updateFlag 生效（UpdateCachedParamsToTask 对 DISABLE 任务先于类型 switch 跳过），
// 与 latestParams.type 无关，故借用 SIMT 往返用例的手法：捕获普通 kernel 任务后置
// simtParamOffset 使 IsPureSimtTask 为真即可。
TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskDisable_SimtTask_Success)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    void* args[] = {&ret, NULL};
    ret = rtKernelLaunch(&function_, 1, (void*)args, sizeof(args), NULL, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t model;
    ret = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numStreams = 1;
    rtStream_t inputStreams[numStreams];
    ret = rtModelGetStreams(model, inputStreams, &numStreams);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numTask = 2;
    rtTask_t inputTasks[numTask];
    ret = rtStreamGetTasks(inputStreams[0], inputTasks, &numTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    TaskInfo* taskInfo = RtPtrToPtr<TaskInfo*>(inputTasks[0]);
    ASSERT_NE(taskInfo, nullptr);
    taskInfo->u.aicTaskInfo.simtParamOffset = 64U;

    ret = rtModelTaskDisable(inputTasks[0]);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelUpdate(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskDisable_failed)
{
    void* srcPtr;
    void* dstPtr;
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    NpuDriver* rawDrv = new NpuDriver();
    rtPointerAttributes_t rtAttributes;
    rtAttributes.deviceID = 0;
    rtAttributes.memoryType = RT_MEMORY_TYPE_DEVICE;
    rtAttributes.locationType = RT_MEMORY_LOC_DEVICE;
    MOCKER_CPP_VIRTUAL(rawDrv, &NpuDriver::PointerGetAttributes)
        .stubs()
        .with(outBoundP(&rtAttributes, sizeof(rtAttributes)), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    ret = rtMalloc(&srcPtr, 64, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtMalloc(&dstPtr, 64, RT_MEMORY_DEFAULT, DEFAULT_MODULEID);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtMemcpyAsync(dstPtr, 64, srcPtr, 64, RT_MEMCPY_DEVICE_TO_DEVICE, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtMemcpyAsync(dstPtr, 64, srcPtr, 64, RT_MEMCPY_DEVICE_TO_DEVICE, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t model;
    ret = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numStreams = 1;
    rtStream_t inputStreams[numStreams];
    ret = rtModelGetStreams(model, inputStreams, &numStreams);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numTask = 3;
    rtTask_t inputTasks[numTask];
    ret = rtStreamGetTasks(inputStreams[0], inputTasks, &numTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelTaskDisable(inputTasks[0]);
    EXPECT_NE(ret, RT_ERROR_NONE);

    ret = rtModelTaskDisable(inputTasks[1]);
    EXPECT_NE(ret, RT_ERROR_NONE);

    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtFree(srcPtr);
    rtFree(dstPtr);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskDefault_Success)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    void* args[] = {&ret, NULL};
    ret = rtKernelLaunch(&function_, 1, (void*)args, sizeof(args), NULL, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtKernelLaunch(&function_, 1, (void*)args, sizeof(args), NULL, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtModel_t model;
    ret = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numStreams = 1;
    rtStream_t inputStreams[numStreams];
    ret = rtModelGetStreams(model, inputStreams, &numStreams);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numTask = 3;
    rtTask_t inputTasks[numTask];
    ret = rtStreamGetTasks(inputStreams[0], inputTasks, &numTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtTaskParams params;
    memset_s(&params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    ret = rtModelTaskGetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_KERNEL);

    ret = rtModelTaskDisable(inputTasks[0]);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelUpdate(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

void CreateEventTaskModel(
    rtStream_t& stream, rtStream_t& stream2, rtEvent_t& event, rtEvent_t& event2, rtModel_t& model)
{
    rtError_t ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamCreate(&stream2, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtEventCreateExWithFlag(&event, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtEventCreateExWithFlag(&event2, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    ret = rtEventRecord(event, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamWaitEvent(stream2, event);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtEventRecord(event2, stream2);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamWaitEvent(stream, event2);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskEventParam001)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    rtStream_t stream2;
    rtEvent_t event;
    rtEvent_t event2;
    rtModel_t model;
    CreateEventTaskModel(stream, stream2, event, event2, model);

    uint32_t numStreams = 2;
    rtStream_t inputStreams[numStreams];
    ret = rtModelGetStreams(model, inputStreams, &numStreams);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(numStreams, 2);

    uint32_t numTask = 5;
    rtTask_t inputTasks[numTask];
    ret = rtStreamGetTasks(inputStreams[1], inputTasks, &numTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtTaskParams params;
    ret = rtModelTaskGetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_EVENT_RECORD);
    ret = rtModelTaskSetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, 107000);

    ret = rtModelTaskGetParams(inputTasks[1], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_EVENT_WAIT);

    ret = rtModelTaskGetParams(inputTasks[2], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_EVENT_RESET);

    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtStreamDestroy(stream2);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtEventDestroy(event);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtEventDestroy(event2);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

void CreateValueTaskModel(rtStream_t& stream, rtModel_t& model, void* addr)
{
    rtError_t ret = rtStreamCreate(&stream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    ret = rtsValueWrite(addr, 1, 0, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtsValueWait(addr, 1, 0, stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskGetValueParam001)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    rtModel_t model;
    void* devAddr;
    ret = rtMalloc(&devAddr, 64U, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    CreateValueTaskModel(stream, model, devAddr);

    uint32_t numStreams = 1;
    rtStream_t inputStreams[numStreams];
    ret = rtModelGetStreams(model, inputStreams, &numStreams);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numTask = 3;
    rtTask_t inputTasks[numTask];
    ret = rtStreamGetTasks(inputStreams[0], inputTasks, &numTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtTaskParams params;
    ret = rtModelTaskGetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_VALUE_WRITE);
    ret = rtModelTaskGetParams(inputTasks[1], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_VALUE_WAIT);

    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtFree(devAddr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskSetValueParam001)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    rtModel_t model;
    void* addr;
    ret = rtMalloc(&addr, 1024U, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    CreateValueTaskModel(stream, model, addr);

    uint32_t numStreams = 1;
    rtStream_t inputStreams[numStreams];
    ret = rtModelGetStreams(model, inputStreams, &numStreams);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numTask = 3;
    rtTask_t inputTasks[numTask];
    ret = rtStreamGetTasks(inputStreams[0], inputTasks, &numTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtTaskParams params;
    ret = rtModelTaskGetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_VALUE_WRITE);
    params.type = RT_TASK_VALUE_WAIT;
    ret = rtModelTaskSetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelTaskGetParams(inputTasks[1], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_VALUE_WAIT);
    params.type = RT_TASK_VALUE_WRITE;
    ret = rtModelTaskSetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtFree(addr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalMockObject::verify();
}

TEST_F(CloudV2CaptureModelUpdateTest, rtModelTaskSetValueParam002)
{
    rtContext_t ctx;
    rtError_t ret = rtCtxCreate(&ctx, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStream_t stream;
    rtStream_t exeStream;
    rtModel_t model;
    void* addr;
    ret = rtMalloc(&addr, 1024U, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    CreateValueTaskModel(stream, model, addr);

    ret = rtStreamCreate(&exeStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numStreams = 1;
    rtStream_t inputStreams[numStreams];
    ret = rtModelGetStreams(model, inputStreams, &numStreams);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelUpdate(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t numTask = 3;
    rtTask_t inputTasks[numTask];
    ret = rtStreamGetTasks(inputStreams[0], inputTasks, &numTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtTaskParams params;
    ret = rtModelTaskGetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_VALUE_WRITE);
    params.type = RT_TASK_VALUE_WAIT;
    ret = rtModelTaskSetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelTaskGetParams(inputTasks[1], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(params.type, RT_TASK_VALUE_WAIT);

    ret = rtModelExecute(model, exeStream, 0);
    EXPECT_NE(ret, RT_ERROR_NONE);

    ret = rtModelUpdate(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    // 测试update时归还sqAddr_的场景
    ret = rtModelExecute(model, exeStream, 0);
    ret = rtModelTaskSetParams(inputTasks[0], &params);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelUpdate(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtStreamDestroy(exeStream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ReleaseModelResource(ctx, stream, model);

    ret = rtFree(addr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    GlobalMockObject::verify();
}
