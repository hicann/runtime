/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "runtime/rt.h"
#include "event.hpp"
#include "scheduler.hpp"
#include "gtest/gtest.h"
#include "stars.hpp"
#include "hwts.hpp"
#include "npu_driver.hpp"
#include "event.hpp"
#include "notify.hpp"
#include "subscribe.hpp"
#include "task_res.hpp"
#include "stars_engine.hpp"
#include "raw_device.hpp"
#include "barrier_task.h"
#include "count_notify.hpp"
#include "ffts_task.h"
#include "kernel.hpp"
#include "binary_loader_c.hpp"
#include "binary_loader.hpp"
#include "program_common.hpp"
#undef protected
#undef private
#include <thread>
#include <chrono>
#include "ctrl_stream.hpp"
#include "ctrl_stream.hpp"
#include "runtime.hpp"
#include "runtime_keeper.h"
#include "config.hpp"
#include "mockcpp/mockcpp.hpp"
#include "uma_arg_loader.hpp"
#include "driver/ascend_hal.h"
#include "osal.hpp"
#include "api.hpp"
#include "stars.hpp"
#include "stars_david.hpp"
#include "stars.hpp"
#include "hwts.hpp"
#include "profiler.hpp"
#include "profiler_struct.hpp"
#include "toolchain/prof_api.h"
#include "task_submit.hpp"
#include "thread_local_container.hpp"
#include "device/device_error_proc.hpp"
#include "memory_task.h"
#include "davinci_kernel_task.h"
#include "stub_task.hpp"
#include "task_info.hpp"
#include "printf.hpp"

using namespace testing;
using namespace cce::runtime;

class TaskTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        (void)rtSetDevice(0);
        rtError_t error1 = rtStreamCreate((rtStream_t *)&stream_, 0);
        rtError_t error2 = rtEventCreate((rtEvent_t *)&event_);
        std::cout << "task test start: " << error1 << ", " << error2 << std::endl;
    }

    static void TearDownTestCase()
    {
        rtError_t error1 = rtStreamDestroy(stream_);
        rtError_t error2 = rtEventDestroy(event_);
        std::cout << "task test end" << error1 << ", " << error2 << std::endl;
        rtDeviceReset(0);
    }

    virtual void SetUp() {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }

    static Stream *stream_;
    static Event *event_;
};

Stream *TaskTest::stream_ = NULL;
Event *TaskTest::event_ = NULL;

drvError_t drvDeviceGetTransWay_stub_1(void *src, void *dst, uint8_t *trans_type)
{
    drvError_t error = DRV_ERROR_NONE;
    *trans_type = RT_MEMCPY_CHANNEL_TYPE_PCIe;

    return error;
}

drvError_t drvDeviceGetTransWay_stub_2(void *src, void *dst, uint8_t *trans_type)
{
    drvError_t error = DRV_ERROR_NONE;
    *trans_type = RT_MEMCPY_CHANNEL_TYPE_HCCs;

    return error;
}

rtError_t MemCopySync_stub(NpuDriver *drv, void *dst, uint64_t destMax, const void *src, uint64_t size,
                           rtMemcpyKind_t kind)
{
    memcpy(dst, src, destMax);
    return RT_ERROR_NONE;
}

TEST_F(TaskTest, OnlineProfEnable_to_cmd)
{
    TaskInfo onlineProfTask = {};
    rtCommand_t command;
    NpuDriver drv;

    InitByStream(&onlineProfTask, stream_);
    EXPECT_NE(onlineProfTask.stream, nullptr);
    rtError_t error = OnlineProfEnableTaskInit(&onlineProfTask, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemAddressTranslate).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    onlineProfTask.stream = stream_;
    ToCommand(&onlineProfTask, &command);
}

TEST_F(TaskTest, fusion_dump_addr_set_ToCommandBody)
{
    TaskInfo fusionDumpAddrSetTask = {};
    rtCommand_t command;
    NpuDriver drv;

    InitByStream(&fusionDumpAddrSetTask, stream_);
    EXPECT_NE(fusionDumpAddrSetTask.stream, nullptr);
    rtError_t error = FusionDumpAddrSetTaskInit(&fusionDumpAddrSetTask, 0, NULL, 1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemAddressTranslate).stubs().will(returnValue(RT_ERROR_NONE));

    fusionDumpAddrSetTask.stream = stream_;

    ToCommand(&fusionDumpAddrSetTask, &command);
}

TEST_F(TaskTest, ActiveAicpuStreamTask_to_cmd)
{
    TaskInfo task = {};

    rtCommand_t command;
    InitByStream(&task, stream_);
    auto error = ActiveAicpuStreamTaskInit(&task, 1, 64, 1, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ToCommand(&task, &command);
}

TEST_F(TaskTest, DynamicProfilingEnableTask_to_cmd)
{
    TaskInfo task = {};
    uint64_t val[12];
    rtCommand_t command;
    InitByStream(&task, stream_);
    auto error = DynamicProfilingEnableTaskInit(&task, 1, (rtProfCfg_t *)&val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ToCommand(&task, &command);
}

TEST_F(TaskTest, DynamicProfilingDisableTask_to_cmd)
{
    TaskInfo task = {};
    uint64_t val[12];
    rtCommand_t command;
    InitByStream(&task, stream_);
    auto error = DynamicProfilingDisableTaskInit(&task, 1, (rtProfCfg_t *)&val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ToCommand(&task, &command);
}

TEST_F(TaskTest, notify_wait_task_fail_print)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, (Stream *)stream);
    NotifyWaitTaskInit(&task, 0, 0, nullptr, nullptr, false);

    uint32_t errorcode = 10;
    SetResult(&task, (const uint32_t *)&errorcode, 1);
    Complete(&task, 0);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(TaskTest, notify_wait_task_set_task_tag)
{
    TaskInfo task = {};
    task.id = 1;

    const char *taskTag1 = "123456123456";
    rtError_t error = rtSetTaskTag(taskTag1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t stream = NULL;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    const char *taskTag = "123456";
    error = rtSetTaskTag(taskTag);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, (Stream *)stream);
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    rtInstance->SetNpuCollectFlag(true);
    SetTaskTag(&task);
    EXPECT_STREQ(task.stream->GetTaskTag(task.id).c_str(), taskTag);

    rtInstance->SetNpuCollectFlag(false);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(TaskTest, model_maintance_DoCompleteSuccess_01)
{
    TaskInfo model_maintance_task = {};

    Runtime *rt = ((Runtime *)Runtime::Instance());
    Device *device = new RawDevice(0);
    device->Init();
    Stream *stream = new Stream(device, 0);
    Stream *opStream = new Stream(device, 0);
    stream->streamId_ = 100;      // id不能跟SetUpTestCase中创建的stream id相同（优化bitmap类后，id按序从最近一次分配id的free_bitmap分配，0和1为有效id）
    opStream->streamId_ = 101;
    uint32_t res = RT_ERROR_MODEL_EXE_FAILED;
    rtError_t error;

    InitByStream(&model_maintance_task, stream);
    error = ModelMaintainceTaskInit(&model_maintance_task, MMT_STREAM_ADD, NULL, opStream, RT_MODEL_HEAD_STREAM, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    SetResult(&model_maintance_task, (void *)&res, 1);
    Complete(&model_maintance_task, 0);

    delete stream;
    delete opStream;
    delete device;
}

TEST_F(TaskTest, model_execute_task_print)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&Stream::IsPendingListEmpty).stubs().will(returnValue(false));

    InitByStream(&task, (Stream *)stream);
    ModelExecuteTaskInit(&task, NULL, 0, 1);

    uint32_t errorcode[3] = {10, 1, 0};
    WaitExecFinishForModelExecuteTask(&task);
    SetResult(&task, (const uint32_t *)errorcode, 1);
    Complete(&task, 0);
    rtStreamDestroy(stream);
}

TEST_F(TaskTest, davinci_kernel_task_print)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    InitByStream(&task, (Stream *)stream);
    AicpuTaskInit(&task, 1, 1);
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AICPU);
    uint32_t errorcode[3] = {10, 1, 0};
    SetResult(&task, (const uint32_t *)errorcode, 1);
    PreCheckTaskErr(&task, 0);
    PrintErrorInfo(&task, 0);

    uint32_t timeoutErr[3] = {0x28, 1, 0};
    SetResult(&task, (const uint32_t *)timeoutErr, 1);
    PreCheckTaskErr(&task, 0);
    PrintErrorInfo(&task, 0);

    task.u.aicTaskInfo.comm.args = (void *)0x1;
    task.u.aicTaskInfo.comm.argsSize = 256U;

    error = GetArgsInfo(&task);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStreamDestroy(stream);
}

TEST_F(TaskTest, GetTaskKernelName)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;

    std::string name = GetTaskKernelName(nullptr); // task = nullptr
    EXPECT_EQ(name, "none");

    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    name = GetTaskKernelName(&task); // task.type
    EXPECT_EQ(name, "none");

    const void *stubFunc = (void *)0x02;
    const char *stubName = "abc";
    Kernel *kernel = NULL;
    PlainProgram stubProg(Program::MACH_AI_CORE);
    Program *program = &stubProg;
    program->kernelNames_ = {'a', 'b', 'c', 'd', '\0'};
    kernel = new (std::nothrow) Kernel(stubFunc, stubName, "", program, 0);
    AicTaskInfo *aicTaskInfo = &task.u.aicTaskInfo;
    aicTaskInfo->kernel = kernel;

    kernel->name_ = ""; // kernel name is empty
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    name = GetTaskKernelName(&task);
    EXPECT_EQ(name, "none");
    task.type = TS_TASK_TYPE_KERNEL_AIVEC;
    name = GetTaskKernelName(&task);
    EXPECT_EQ(name, "none");

    kernel->name_ = "op_name_test";
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    name = GetTaskKernelName(&task);
    EXPECT_EQ(name, "op_name_test");
    task.type = TS_TASK_TYPE_KERNEL_AIVEC;
    name = GetTaskKernelName(&task);
    EXPECT_EQ(name, "op_name_test");
    delete kernel;
}

TEST_F(TaskTest, davinci_kernel_task_print_mixCtx)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // new kernel
    const void *stubFunc = (void *)0x02;
    const char *stubName = "abc";
    Kernel *kernel = NULL;
    PlainProgram stubProg(Program::MACH_AI_CORE);
    Program *program = &stubProg;
    program->kernelNames_ = {'a', 'b', 'c', 'd', '\0'};
    MOCKER_CPP(&Runtime::GetProgram).stubs().will(returnValue(true));
    MOCKER_CPP(&Runtime::PutProgram).stubs().will(ignoreReturnValue());

    kernel = new (std::nothrow) Kernel(stubFunc, stubName, "", program, 0);
    ((Runtime *)Runtime::Instance())->kernelTable_.Add(kernel);
    task.u.aicTaskInfo.kernel = kernel;
    kernel->SetMixType(MIX_AIC);

    InitByStream(&task, (Stream *)stream);
    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr);

    task.u.aicTaskInfo.comm.args = (void *)0x1;
    task.u.aicTaskInfo.comm.argsSize = 256U;

    error = GetArgsInfo(&task);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // stub for descAlignBuf = nullptr
    error = GetMixCtxInfo(&task);
    EXPECT_EQ(error, RTS_INNER_ERROR);

    // stub for descAlignBuf != nullptr
    task.u.aicTaskInfo.descAlignBuf = malloc(256);
    error = GetMixCtxInfo(&task);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // stub for MemCopySync fail
    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync).stubs().will(returnValue(RT_ERROR_DEVICE_NULL));
    error = GetMixCtxInfo(&task);
    EXPECT_EQ(error, RT_ERROR_DEVICE_NULL);

    // set mixType != NO_MIX.aicTaskInfo
    EXPECT_EQ(task.u.aicTaskInfo.kernel->mixType_, 1U);

    // printErrorInfo for mixCtx
    PrintErrorInfo(&task, 0);

    free(task.u.aicTaskInfo.descAlignBuf);
    rtStreamDestroy(stream);
}

TEST_F(TaskTest, davinci_mix_kernel_task_print)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    InitByStream(&task, (Stream *)stream);
    AicTaskInit(&task, Program::MACH_AI_CVMIX, 1, 1, nullptr);
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AICORE);
    rtStreamDestroy(stream);
}

TEST_F(TaskTest, stream_IsNeedPostProc_true)
{
    rtError_t error;
    rtStream_t stream;
    rtContext_t ctx;
    TaskInfo tsk = {};

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *stream_var = static_cast<Stream *>(stream);
    stream_var->isHasPcieBar_ = true;
    tsk.stream = stream_var;
    stream_var->IsNeedPostProc(&tsk);
    tsk.type = TS_TASK_TYPE_NOTIFY_WAIT;
    stream_var->IsNeedPostProc(&tsk);
    tsk.type = TS_TASK_TYPE_NOTIFY_RECORD;
    stream_var->IsNeedPostProc(&tsk);
    error = rtStreamDestroy(stream);
}

TEST_F(TaskTest, stream_IsNeedPostProc_false)
{
    rtError_t error;
    rtStream_t stream;
    rtContext_t ctx;
    TaskInfo tsk = {};

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *stream_var = static_cast<Stream *>(stream);
    tsk.stream = stream_var;
    tsk.type = TS_TASK_TYPE_FFTS_PLUS;
    stream_var->IsNeedPostProc(&tsk);
    error = rtStreamDestroy(stream);
}

TEST_F(TaskTest, davinci_kernel_aic_task_print)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    InitByStream(&task, (Stream *)stream);
    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr);
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AICORE);

    uint32_t errorcode[3] = {10, 1, 0};
    SetResult(&task, (const uint32_t *)errorcode, 1);
    PreCheckTaskErr(&task, 0);
    PrintErrorInfo(&task, 0);

    rtStreamDestroy(stream);
}

TEST_F(TaskTest, davinci_kernel_aic_task_print1)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    InitByStream(&task, (Stream *)stream);
    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr);

    uint32_t errorcode[3] = {10, 1, 0};
    SetResult(&task, (const uint32_t *)errorcode, 1);
    task.mte_error = 0x58;
    PreCheckTaskErr(&task, 0);
    rtStreamDestroy(stream);
}

TEST_F(TaskTest, davinci_kernel_task_print2)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, (Stream *)stream);
    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr);
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AICORE);

    const uint32_t argsSize = sizeof(uint32_t) + sizeof(uint64_t) * 2;
    char args[argsSize] = {};
    uintptr_t argsAddr = reinterpret_cast<uintptr_t>(args);
    uint32_t *fwkKernelType = reinterpret_cast<uint32_t *>(argsAddr);
    *fwkKernelType = 0;

    std::string opName = "test";
    const uint64_t extendInfoLen = sizeof(int32_t) + sizeof(uint32_t) + sizeof(opName.length());
    char extendInfo[extendInfoLen] = {};
    uint64_t *extInfoLen = reinterpret_cast<uint64_t *>(argsAddr + argsSize - sizeof(uint64_t) * 2);
    *extInfoLen = extendInfoLen;
    uint64_t *extInfoAddr = reinterpret_cast<uint64_t *>(argsAddr + argsSize - sizeof(uint64_t));
    *extInfoAddr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(extendInfo));

    uintptr_t extendInfoAddr = reinterpret_cast<uintptr_t>(extendInfo);
    int32_t *infoType = reinterpret_cast<int32_t *>(extendInfoAddr);
    *infoType = 4;
    uint32_t *infoLen = reinterpret_cast<uint32_t *>(extendInfoAddr + sizeof(int32_t));
    *infoLen = opName.length();
    uintptr_t msgInfoAddr = extendInfoAddr + sizeof(int32_t) + sizeof(uint32_t);
    memcpy(reinterpret_cast<void *>(msgInfoAddr), opName.c_str(), opName.length());
    SetArgs(&task, args, argsSize, NULL, NULL, NULL);

    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync).stubs().will(invoke(MemCopySync_stub));

    uint32_t errorcode[3] = {10, 1, 0};
    SetResult(&task, (const uint32_t *)errorcode, 1);
    PreCheckTaskErr(&task, 0);
    PrintErrorInfo(&task, 0);

    rtStreamDestroy(stream);
}

TEST_F(TaskTest, davinci_kernel_task_print3)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, (Stream *)stream);
    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr);
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AICORE);
    uint32_t errorcode[3] = {10, 1, 0};
    SetResult(&task, (const uint32_t *)errorcode, 1);
    PreCheckTaskErr(&task, 0);
    PrintErrorInfo(&task, 0);

    rtStreamDestroy(stream);
}

TEST_F(TaskTest, davinci_kernel_task_print4)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, (Stream *)stream);
    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr);
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AICORE);

    const uint32_t argsSize = sizeof(uint32_t) + sizeof(uint64_t) * 2;
    char args[argsSize] = {};
    uintptr_t argsAddr = reinterpret_cast<uintptr_t>(args);
    uint32_t *fwkKernelType = reinterpret_cast<uint32_t *>(argsAddr);
    *fwkKernelType = 0;
    SetArgs(&task, args, argsSize, NULL, NULL, NULL);

    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::GetRunMode).stubs().will(returnValue((uint32_t)1));

    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync).stubs().will(returnValue(RT_ERROR_DRV_NULL));

    uint32_t errorcode[3] = {10, 1, 0};
    SetResult(&task, (const uint32_t *)errorcode, 1);
    PreCheckTaskErr(&task, 0);
    PrintErrorInfo(&task, 0);

    rtStreamDestroy(stream);
}

TEST_F(TaskTest, davinci_kernel_task_print5)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, (Stream *)stream);
    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr);

    const uint32_t argsSize = sizeof(uint32_t) + sizeof(uint64_t);
    char args[argsSize] = {};
    SetArgs(&task, args, argsSize, NULL, NULL, NULL);

    uint32_t errorcode[3] = {10, 1, 0};
    SetResult(&task, (const uint32_t *)errorcode, 1);
    PrintErrorInfo(&task, 0);

    rtStreamDestroy(stream);
}

TEST_F(TaskTest, davinci_kernel_task_print6)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, (Stream *)stream);
    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr);

    const uint32_t argsSize = sizeof(uint32_t) * 3 + sizeof(uint64_t);
    char args[argsSize] = {};
    uintptr_t argsAddr = reinterpret_cast<uintptr_t>(args);

    int32_t shapeType = 1;
    const uint64_t extendInfoLen = sizeof(int32_t) + sizeof(uint32_t) + sizeof(int32_t);
    char extendInfo[extendInfoLen] = {};
    uint64_t *extInfoLen = reinterpret_cast<uint64_t *>(argsAddr + sizeof(uint32_t) * 2);
    *extInfoLen = extendInfoLen;
    uint64_t *extInfoAddr = reinterpret_cast<uint64_t *>(argsAddr + sizeof(uint32_t) * 3);
    *extInfoAddr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(extendInfo));

    uintptr_t extendInfoAddr = reinterpret_cast<uintptr_t>(extendInfo);
    int32_t *infoType = reinterpret_cast<int32_t *>(extendInfoAddr);
    *infoType = 0;
    uint32_t *infoLen = reinterpret_cast<uint32_t *>(extendInfoAddr + sizeof(int32_t));
    *infoLen = sizeof(int32_t);
    uintptr_t msgInfoAddr = extendInfoAddr + sizeof(int32_t) + sizeof(uint32_t);
    memcpy(reinterpret_cast<void *>(msgInfoAddr), &shapeType, sizeof(int32_t));
    SetArgs(&task, args, argsSize, NULL, NULL, NULL);

    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync).stubs().will(invoke(MemCopySync_stub));

    uint32_t errorcode[3] = {10, 1, 0};
    SetResult(&task, (const uint32_t *)errorcode, 1);
    PrintErrorInfo(&task, 0);

    rtStreamDestroy(stream);
}

TEST_F(TaskTest, davinci_kernel_task_print7)
{
    GlobalMockObject::verify();
    TaskInfo task = {};
    rtError_t error;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    EXPECT_NE(rtInstance, nullptr);
    rtInstance->SetSimtPrintFifoSize(1048576U);
    EXPECT_EQ(rtInstance->GetSimtPrintFifoSize(), 1048576U);

    RawDevice *device = new RawDevice(0);
    EXPECT_NE(device, nullptr);
    device->Init();
    device->simtEnable_ = true;
    Stream *stream = new Stream(device, 0);

    InitByStream(&task, stream);
    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr);
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AICORE);

    PlainProgram stubProg(Program::MACH_AI_CORE);
    Program *program = &stubProg;
    int32_t fun1;
    Kernel * kernel = new Kernel(&fun1, "f1", 1, program, 10);
    kernel->SetMixType(0);
    AicTaskInfo *aicTaskInfo = &(task.u.aicTaskInfo);
    aicTaskInfo->kernel = kernel;

    Module module(device);
    MOCKER_CPP(&Context::GetModule)
        .stubs()
        .will(returnValue(&module));
    PrintErrorInfo(&task, 0);

    device->simtPrintLen_ = 1048576U;
    std::vector<uint8_t> hostData(1048576U, 0);
    error = InitSimtPrintf(hostData.data(), 1048576U, device->driver_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->simtPrintfAddr_ = hostData.data();
    PrintErrorInfo(&task, 0);

    delete kernel;
    delete stream;
    delete device;
    GlobalMockObject::verify();
}

TEST_F(TaskTest, base_task_print0)
{
    TaskInfo task = {};
    rtStream_t stream = NULL;
    rtError_t error;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, (Stream *)stream);
    AddEndGraphTaskInit(&task, 0, 0, 0, 0, 0);
    PrintErrorInfo(&task, 0);

    rtStarsSqe_t sqe;
    ToConstructSqe(&task, &sqe);
    Complete(&task, 0);
    rtStreamDestroy(stream);
}

TEST_F(TaskTest, base_task_lock_unlock)
{
    TaskInfo task = {};
    TaskInfo task1 = {};
    rtStream_t stream = NULL;
    rtError_t error;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, (Stream *)stream);
    SqLockUnlockTaskInit(&task, true);
    InitByStream(&task1, (Stream *)stream);
    SqLockUnlockTaskInit(&task1, false);

    rtStarsSqe_t sqe;
    ToConstructSqe(&task, &sqe);
    Complete(&task, 0);
    rtStarsSqe_t sqe1;
    ToConstructSqe(&task1, &sqe1);
    Complete(&task1, 0);
    rtStreamDestroy(stream);
}

TEST_F(TaskTest, model_update_task_to_command_test)
{
    rtCommand_t command;
    rtError_t error;
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_MODEL_TASK_UPDATE;

    rtStream_t stream = NULL;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, (Stream *)stream);

    ToCommand(&task, &command);
    Complete(&task, 0);

    rtStreamDestroy(stream);
}

TEST_F(TaskTest, commamdBodyForLabel)
{
    rtCommand_t command;
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_LABEL_GOTO;
    task.u.labelGotoTask.labelId = 1U;

    rtStream_t stream = NULL;
    rtError_t error;

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, (Stream *)stream);

    ToCommand(&task, &command);
    EXPECT_EQ(command.u.labelGotoTask.labelId, 1U);
    Complete(&task, 0);

    rtStreamDestroy(stream);
    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
TEST_F(TaskTest, base_aicpu_info_load_task)
{
    TaskInfo task = {};
    rtStream_t stream = NULL;
    rtError_t error;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, (Stream *)stream);
    char aicpu_info[16] = "aicpu info";
    AicpuInfoLoadTaskInit(&task, aicpu_info, 16);

    rtStarsSqe_t sqe;
    ToConstructSqe(&task, &sqe);
    rtLogicCqReport_t cqe;
    cqe.errorType = 1;
    cqe.errorCode = 1;
    SetStarsResult(&task, cqe);
    Complete(&task, 0);

    rtStreamDestroy(stream);
}

TEST_F(TaskTest, base_task_nop)
{
    TaskInfo task = {};
    rtStream_t stream = NULL;
    rtError_t error;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, (Stream *)stream);
    NopTaskInit(&task);

    rtStarsSqe_t sqe;
    ToConstructSqe(&task, &sqe);
    Complete(&task, 0);
    rtStreamDestroy(stream);
}

TEST_F(TaskTest, aicpu_info_load_task_to_command_01)
{
    TaskInfo aicpu_info_load_task = {};
    rtCommand_t command;
    rtError_t error;
    Runtime *rt = ((Runtime *)Runtime::Instance());
    Device *device = new RawDevice(0);
    device->Init();
    Stream *stream = new Stream(device, 0);
    NpuDriver drv;
    stream->streamId_ = 100;

    InitByStream(&aicpu_info_load_task, stream);
    EXPECT_NE(aicpu_info_load_task.stream, nullptr);
    char aicpu_info[16] = "aicpu info";
    error = AicpuInfoLoadTaskInit(&aicpu_info_load_task, aicpu_info, 16);
    EXPECT_EQ(error, RT_ERROR_NONE);
    TaskUnInitProc(&aicpu_info_load_task);
    delete stream;
    delete device;
}

TEST_F(TaskTest, davinci_kernel_task_ref_module)
{
    rtError_t error;
    rtStream_t stream = NULL;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Device *dev = ((Stream *)stream)->Device_();
    {
        TaskInfo task = {};
        InitByStream(&task, (Stream *)stream);
        AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr);
        TaskUnInitProc(&task);
    }
    rtStreamDestroy(stream);
}

TEST_F(TaskTest, stars_aicpu_sqe)
{
    TaskInfo task = {};
    rtError_t error;

    rtStarsSqe_t command;
    InitByStream(&task, (Stream *)stream_);
    AicpuTaskInit(&task, 1, 1);
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AICPU);
    RtStarsAicpuKernelSqe *const sqe = &(command.aicpuSqe);
    task.u.aicpuTaskInfo.comm.kernelFlag = RT_KERNEL_HOST_FIRST;
    ToConstructSqe(&task, &command);
    task.u.aicpuTaskInfo.aicpuKernelType = 1;
    EXPECT_EQ(sqe->topic_type, TOPIC_TYPE_HOST_AICPU_FIRST);

    task.u.aicpuTaskInfo.comm.kernelFlag = RT_KERNEL_HOST_ONLY;
    ToConstructSqe(&task, &command);
    EXPECT_EQ(sqe->topic_type, TOPIC_TYPE_HOST_AICPU_ONLY);
    task.u.aicpuTaskInfo.comm.kernelFlag = RT_KERNEL_DEVICE_FIRST;
    ToConstructSqe(&task, &command);
    EXPECT_EQ(sqe->topic_type, TOPIC_TYPE_DEVICE_AICPU_FIRST);
    rtLogicCqReport_t cqe;
    cqe.errorType = 1;
    cqe.errorCode = 1;
    SetStarsResult(&task, cqe);
    EXPECT_EQ(task.errorCode, TS_ERROR_AICPU_EXCEPTION);
}

TEST_F(TaskTest, stars_eventrecord_sqe)
{
    TaskInfo task = {};
    rtError_t error;
    Event evt;
    evt.device_ = stream_->Device_();

    rtStarsSqe_t sqe;
    InitByStream(&task, (Stream *)stream_);
    EventRecordTaskInit(&task, &evt, false, evt.EventId_());
    ToConstructSqe(&task, &sqe);
    Complete(&task, 0);

    rtLogicCqReport_t cqe;
    cqe.errorType = 1;
    cqe.errorCode = 2;
    SetStarsResult(&task, cqe);
    EXPECT_EQ(task.errorCode, 2);
    cqe.errorType = 0;
    SetStarsResult(&task, cqe);
    TaskUnInitProc(&task);
}

TEST_F(TaskTest, stars_eventwait_sqe)
{
    TaskInfo task = {};
    rtError_t error;
    Event evt;
    evt.device_ = stream_->Device_();
    rtEvent_t event;
    uint32_t event_id = 0;

    rtStarsSqe_t command;
    InitByStream(&task, (Stream *)stream_);
    EventWaitTaskInit(&task, &evt, event_id, 0, 0);
    EXPECT_EQ(task.type, TS_TASK_TYPE_STREAM_WAIT_EVENT);
    ToConstructSqe(&task, &command);
    RtStarsEventSqe *evSqe = &(command.eventSqe);
    EXPECT_EQ(evSqe->header.type, RT_STARS_SQE_TYPE_EVENT_WAIT);
    evt.EventIdCountAdd((task.u.eventWaitTaskInfo).eventId);
    Complete(&task, 0);
}

//Memcpy Async D2D and H2D
TEST_F(TaskTest, stars_memcpy_async_sqe_d2d)
{
    void *dst = nullptr;
    void *src = nullptr;
    uint64_t count = 1;
    rtMemcpyKind_t kind = RT_MEMCPY_DEVICE_TO_DEVICE;

    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStarsSqe_t sqe;
    InitByStream(&task, (Stream *)stream);
    MemcpyAsyncTaskInitV3(&task, kind, src, dst, count, 0, NULL);
    ToConstructSqe(&task, &sqe);
    MemcpyAsyncTaskInitV3(&task, RT_MEMCPY_HOST_TO_DEVICE_EX, src, dst, count, 0, NULL);

    rtLogicCqReport_t cqe = {};
    Complete(&task, 0);
    PrintErrorInfo(&task, 0);
    SetStarsResult(&task, cqe);
    TaskUnInitProc(&task);
    rtStreamDestroy(stream);
}

// Memcpy Async D2D
TEST_F(TaskTest, stars_memcpy_async_sqe_d2d_error)
{
    void *dst = nullptr;
    void *src = nullptr;
    uint64_t count = 1;
    rtMemcpyKind_t kind = RT_MEMCPY_DEVICE_TO_DEVICE;

    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStarsSqe_t sqe;
    InitByStream(&task, (Stream *)stream);
    MemcpyAsyncTaskInitV3(&task, kind, src, dst, count, 0, NULL);
    ToConstructSqe(&task, &sqe);

    rtLogicCqReport_t cqe = {};
    cqe.errorType = 1U;
    Complete(&task, 0);
    PrintErrorInfo(&task, 0);
    SetStarsResult(&task, cqe);
    TaskUnInitProc(&task);
    rtStreamDestroy(stream);
}

//dsq sqe update
TEST_F(TaskTest, stars_dsa_update_sqe_d2h_error)
{
    void *src = nullptr;
    uint64_t count = 40U;
    TaskInfo task = {};
    rtError_t error;

    Driver *drv;
    drv = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    rtStarsSqe_t sqe;
    InitByStream(&task, (Stream *)stream_);
    MemcpyAsyncD2HTaskInit(&task, src, count, 2U, 3U);
    EXPECT_EQ(task.type, TS_TASK_TYPE_MEMCPY);
    ToConstructSqe(&task, &sqe);
    rtLogicCqReport_t cqe = {};
    cqe.errorType = 1U;
    Complete(&task, 0);

    MOCKER_CPP_VIRTUAL((NpuDriver *)(drv), &NpuDriver::GetRunMode)
        .stubs()
        .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));
    PrintErrorInfo(&task, 0);
    SetStarsResult(&task, cqe);
    EXPECT_EQ(task.errorCode, TS_ERROR_SDMA_ERROR);
    TaskUnInitProc(&task);
}

//dsq sqe update not a dsa
TEST_F(TaskTest, stars_dsa_update_sqe_d2h_error_not_dsa)
{
    void *src = nullptr;
    uint64_t count = 40U;
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = nullptr;

    Driver *drv;
    drv = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStarsSqe_t sqe;
    InitByStream(&task, (Stream *)stream);
    MemcpyAsyncD2HTaskInit(&task, src, count, 2U, 3U);
    EXPECT_EQ(task.type, TS_TASK_TYPE_MEMCPY);
    ToConstructSqe(&task, &sqe);

    rtLogicCqReport_t cqe = {};
    cqe.errorType = 1U;
    Complete(&task, 0);

    MOCKER_CPP_VIRTUAL((NpuDriver *)(drv), &NpuDriver::GetRunMode)
        .stubs()
        .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

    task.u.memcpyAsyncTaskInfo.dsaSqeUpdateFlag = false;
    PrintErrorInfo(&task, 0);
    SetStarsResult(&task, cqe);
    EXPECT_EQ(task.errorCode, TS_ERROR_SDMA_ERROR);
    TaskUnInitProc(&task);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(TaskTest, RecycleTaskResource_ut)
{
    TaskInfo task = {};
    EXPECT_NE(sizeof(task), 0);
    RecycleTaskResourceForMemcpyAsyncTask(&task);
}

//Reduce Async
TEST_F(TaskTest, stars_reduce_async_sqe)
{
    void *dst = nullptr;
    void *src = nullptr;
    uint64_t count = 4;
    TaskInfo tasks[RT_DATA_TYPE_END * (RT_RECUDE_KIND_END - RT_MEMCPY_SDMA_AUTOMATIC_ADD)] = {{}};
    rtError_t error;
    rtStream_t stream = NULL;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStarsSqe_t sqe;
    TaskInfo *pTask;
    for (int iKind = (int)RT_MEMCPY_SDMA_AUTOMATIC_ADD; iKind < (int)RT_RECUDE_KIND_END; iKind++) {
        for (int jType = 0; jType < (int)RT_DATA_TYPE_END; jType++) {
            pTask = &(tasks[(iKind - (int)RT_MEMCPY_SDMA_AUTOMATIC_ADD) * (RT_DATA_TYPE_END) + jType]);
            InitByStream(pTask, (Stream *)stream);
            MemcpyAsyncTaskInitV3(pTask, (rtRecudeKind_t)iKind, src, dst, count, 0, NULL);
            pTask->u.memcpyAsyncTaskInfo.copyDataType = (rtDataType_t)jType;
            ToConstructSqe(pTask, &sqe);
            Complete(pTask, 0);
            TaskUnInitProc(pTask);
        }
    }
    rtStreamDestroy(stream);
}

TEST_F(TaskTest, stars_notify_record_sqe_notify_null)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStarsSqe_t sqe;
    InitByStream(&task, (Stream *)stream);

    SingleBitNotifyRecordInfo single_bit_notify_info = {false, false, false, false, 0, 0, false};
    NotifyRecordTaskInit(&task, 0, 0, 0, &single_bit_notify_info, nullptr, nullptr, false);

    ToConstructSqe(&task, &sqe);
    Complete(&task, 0);

    rtStreamDestroy(stream);
}

TEST_F(TaskTest, stars_notify_wait_sqe)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStarsSqe_t sqe;
    InitByStream(&task, (Stream *)stream);
    NotifyWaitTaskInit(&task, 0, 0, nullptr, nullptr, false);
    ToConstructSqe(&task, &sqe);
    Complete(&task, 0);
    PrintErrorInfo(&task, 0);

    rtStreamDestroy(stream);
}

TEST_F(TaskTest, stars_stream_activate_sqe)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;
    uint32_t event_id = 0;
    (void)rtSetSocVersion("AS31XM1X");
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStarsSqe_t sqe;
    InitByStream(&task, (Stream *)stream);
    StreamActiveTaskInit(&task, (Stream *)stream);
    ToConstructSqe(&task, &sqe);
    Complete(&task, 0);
    rtStarsStreamActiveFcPara_t fcPara = {};
    error = InitFuncCallParaForStreamActiveTask(&task, fcPara, CHIP_MINI_V3);
    rtStreamDestroy(stream);
}

TEST_F(TaskTest, stars_ph_sqe)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;
    uint32_t event_id = 0;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStarsSqe_t sqe;
    InitByStream(&task, (Stream *)stream);
    DataDumpLoadInfoTaskInit(&task, 0, 0, RT_KERNEL_DEFAULT);
    ToConstructSqe(&task, &sqe);
    Complete(&task, 0);
    rtStreamDestroy(stream);
}

TEST_F(TaskTest, stars_callback_launch)
{
    TaskInfo task = {};
    rtError_t error;
    rtCommand_t command;
    rtStarsSqe_t starsSqe;
    InitByStream(&task, (Stream *)stream_);
    CallbackLaunchTaskInit(&task, nullptr, nullptr, true, -1);
    EXPECT_EQ(task.type, TS_TASK_TYPE_HOSTFUNC_CALLBACK);
    ToConstructSqe(&task, &starsSqe);
    MOCKER_CPP(&CbSubscribe::GetGroupIdByStreamId).stubs().will(returnValue(RT_ERROR_NONE));
    ToConstructSqe(&task, &starsSqe);
    RtStarsHostfuncCallbackSqe *sqe = &(starsSqe.callbackSqe);

    MOCKER_CPP_VIRTUAL((NpuDriver *)((Stream *)stream_->Device_()->Driver_()), &NpuDriver::GetRunMode)
        .stubs()
        .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

    ToConstructSqe(&task, &starsSqe);
    EXPECT_EQ(sqe->kernel_type, TS_AICPU_KERNEL_NON);
    Complete(&task, 0);
    ToCommand(&task, &command);
    EXPECT_EQ(command.taskInfoFlag, TASK_UNSINK_FLAG);
}
TEST_F(TaskTest, memcpy_async_task_init_02)
{
    TaskInfo memcpyTask = {};

    Runtime *rt = ((Runtime *)Runtime::Instance());
    Device *device = new RawDevice(0);
    device->Init();
    Stream *stream = new Stream(device, 0);
    stream->streamId_ = 100;
    NpuDriver drv;

    rtError_t error;

    void *src = malloc(100);
    void *dst = malloc(100);
    uint64_t size = sizeof(void *);

    uint32_t backupcopyType_ = memcpyTask.u.memcpyAsyncTaskInfo.copyType;
    memcpyTask.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_HOST_TO_DEVICE_EX;

    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::GetRunMode).stubs().will(returnValue((uint32_t)1));

    InitByStream(&memcpyTask, stream);
    EXPECT_NE(memcpyTask.stream, nullptr);
    error = MemcpyAsyncTaskInitV3(&memcpyTask, RT_MEMCPY_HOST_TO_DEVICE_EX, src, dst, size, 0, NULL);
    EXPECT_EQ(error, RT_ERROR_DRV_ERR);
    memcpyTask.u.memcpyAsyncTaskInfo.copyType = backupcopyType_;

    TaskUnInitProc(&memcpyTask);
    free(src);
    free(dst);
    delete stream;
    delete device;
}

TEST_F(TaskTest, memcpy_async_task_init_03)
{
    TaskInfo memcpyTask = {};
    Runtime *rt = ((Runtime *)Runtime::Instance());
    Device *device = new RawDevice(0);
    device->Init();
    Stream *stream = new Stream(device, 0);
    stream->streamId_ = 100;
    NpuDriver drv;
    rtError_t error;

    void *src = malloc(100);
    void *dst = malloc(100);
    uint64_t size = sizeof(void *);

    uint32_t backupcopyType_ = memcpyTask.u.memcpyAsyncTaskInfo.copyType;
    memcpyTask.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DEVICE_TO_HOST_EX;

    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::GetRunMode).stubs().will(returnValue((uint32_t)1));
    InitByStream(&memcpyTask, stream);
    error = MemcpyAsyncTaskInitV3(&memcpyTask, RT_MEMCPY_DEVICE_TO_HOST_EX, src, dst, size, 0, NULL);
    EXPECT_EQ(error, RT_ERROR_DRV_ERR);

    memcpyTask.u.memcpyAsyncTaskInfo.copyType = backupcopyType_;
    TaskUnInitProc(&memcpyTask);
    free(src);
    free(dst);
    delete stream;
    delete device;
}

TEST_F(TaskTest, INIT_TEST)
{
    rtError_t error;
    rtCommand_t command;
    TaskInfo task = {};
    InitByStream(&task, (Stream *)stream_);
    error = RemoteEventWaitTaskInit(&task, nullptr, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ToCommand(&task, &command);
    EXPECT_EQ(command.taskInfoFlag, TASK_UNSINK_FLAG);
}

TEST_F(TaskTest, notify_wait_record_task_fail)
{
    rtError_t error;
    TaskInfo notify_record_task_null = {};
    InitByStream(&notify_record_task_null, stream_);
    error = NotifyRecordTaskInit(&notify_record_task_null, 0, 0, 0, nullptr, nullptr, nullptr, false);
    EXPECT_EQ(error, RT_ERROR_NOTIFY_NULL);
    TaskInfo notify_record_task = {};
    InitByStream(&notify_record_task, stream_);
    rtCntNtyRecordInfo_t countInfo = {RECORD_ADD_MODE, 1U};
    Notify *count_notify = new (std::nothrow) Notify(0, 0);
    error = NotifyRecordTaskInit(&notify_record_task, 0, 0, 0, nullptr, &countInfo, count_notify, true);
    EXPECT_EQ(error, RT_ERROR_NONE);
    TaskInfo notify_wait_task_null = {};
    InitByStream(&notify_wait_task_null, stream_);
    error = NotifyWaitTaskInit(&notify_wait_task_null, 0, 0, nullptr, nullptr, true);
    EXPECT_EQ(error, RT_ERROR_NOTIFY_NULL);
    TaskInfo notify_wait_task = {};
    InitByStream(&notify_wait_task, stream_);
    CountNotifyWaitInfo cntNtfyInfo = {WAIT_EQUAL_MODE, 1U, false};
    error = NotifyWaitTaskInit(&notify_wait_task, 0, 0, &cntNtfyInfo, count_notify, true);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete count_notify;
}

TEST_F(TaskTest, event_wait_task_failed)
{
    TaskInfo task = {};
    rtError_t error;
    Event evt;
    evt.device_ = stream_->Device_();
    InitByStream(&task, stream_);
    error = EventWaitTaskInit(&task, &evt, 0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    uint32_t errorCode = 0x28;
    evt.EventIdCountAdd((task.u.eventWaitTaskInfo).eventId);
    SetResult(&task, &errorCode, 1);
    Complete(&task, 0);
    EXPECT_EQ(stream_->GetErrCode(), errorCode);
}

TEST_F(TaskTest, event_wait_task_failed1)
{
    TaskInfo task = {};
    rtError_t error;
    Event evt;
    evt.device_ = stream_->Device_();
    InitByStream(&task, stream_);
    error = EventWaitTaskInit(&task, &evt, 0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    evt.EventIdCountAdd((task.u.eventWaitTaskInfo).eventId);
    uint32_t errorCode = 0x01;
    task.u.eventWaitTaskInfo.eventWaitFlag = 1;
    SetResult(&task, &errorCode, 1);
    Complete(&task, 0);
    EXPECT_EQ(stream_->GetErrCode(), errorCode);
}

TEST_F(TaskTest, event_wait_task_end_of_seq)
{
    TaskInfo task = {};
    rtError_t error;
    Event evt;
    evt.device_ = stream_->Device_();
    InitByStream(&task, stream_);
    error = EventWaitTaskInit(&task, &evt, 0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    evt.EventIdCountAdd((task.u.eventWaitTaskInfo).eventId);
    uint32_t errorCode = 0x95;
    SetResult(&task, &errorCode, 1);
    Complete(&task, 0);
}

TEST_F(TaskTest, do_complete_success)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    TaskInfo task = {};
    rtError_t error;
    Stream *taskStream = NULL;
    error = rtStreamCreate((rtStream_t *)&taskStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    InitByStream(&task, taskStream);
    EventResetTaskInit(&task, nullptr, false, -1);

    rtSocType_t socType = rtInstance->GetSocType();
    rtInstance->SetSocType(SOC_ASCEND910B1);
    Complete(&task, 0);
    rtInstance->SetSocType(socType);
}

TEST_F(TaskTest, kernel_task_async_copy_wait)
{
    TaskInfo task = {};
    rtError_t error;
    Stream *taskStream = NULL;
    NpuDriver drv;

    error = rtStreamCreate((rtStream_t *)&taskStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, taskStream);
    AicTaskInit(&task, 0, 1, 0, nullptr);
    EXPECT_EQ(task.u.aicTaskInfo.comm.dim, 1U);

    Handle hdl;
    RawDevice *device = new RawDevice(0);
    device->driver_ = &drv;
    memset_s(&hdl, sizeof(Handle), '\0', sizeof(Handle));
    CpyHandle cpyHdl;
    H2DCopyMgr *argAllocator = new (std::nothrow)
        H2DCopyMgr(device, 10, 1024U, 1024U, BufferAllocator::LINEAR, COPY_POLICY_DEFAULT);
    hdl.kerArgs = argAllocator->AllocDevMem();
    hdl.argsAlloc = argAllocator;
    SetArgs(&task, nullptr, 0, nullptr, 0, &hdl);
    WaitAsyncCopyComplete(&task);
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopyAsyncWaitFinish).stubs().will(returnValue(RT_ERROR_NONE));
    WaitAsyncCopyComplete(&task);
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopyAsyncWaitFinish).stubs().will(returnValue(RT_ERROR_NONE));
    WaitAsyncCopyComplete(&task);
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopyAsyncWaitFinishEx).stubs().will(returnValue(RT_ERROR_DRV_MEMORY));
    WaitAsyncCopyComplete(&task);
    SetArgs(&task, nullptr, 0, nullptr, 0, nullptr);

    delete argAllocator;
    delete device;
    GlobalMockObject::verify();
}

TEST_F(TaskTest, FillKernelLaunchPara)
{
    TaskInfo task = {};
    rtKernelLaunchNames_t launchNames;
    launchNames.kernelName = "ADD";
    launchNames.opName = "Frameworkop";
    launchNames.soName = "aicpusd.so";
    Device *device = new RawDevice(0);
    device->Init();
    UmaArgLoader devArgLdr(device);
    MOCKER_CPP_VIRTUAL(devArgLdr, &UmaArgLoader::GetKernelInfoDevAddr)
        .stubs()
        .will(returnValue((int32_t)RT_ERROR_NONE));
    rtError_t error = FillKernelLaunchPara(&launchNames, &task, &devArgLdr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete device;
    GlobalMockObject::verify();
}

TEST_F(TaskTest, kernel_task_no_complete)
{
    TaskInfo task = {};
    rtError_t error;
    Stream *taskStream = NULL;
    NpuDriver drv;

    error = rtStreamCreate((rtStream_t *)&taskStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, taskStream);
    AicTaskInit(&task, 0, 1, 0, nullptr);
    EXPECT_EQ(task.u.aicTaskInfo.comm.dim, 1U);

    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::GetRunMode).stubs().will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));
    GlobalMockObject::verify();
}

TEST_F(TaskTest, PreCheckTaskErr)
{
    uint32_t devId = 0;
    rtStream_t stream = NULL;
    rtError_t error;
    const void *stubFunc = (void *)0x01;
    const char *stubName = "abc";
    Kernel *kernel = NULL;
    char funcName[KERNEL_INFO_ENTRY_SIZE] = {};
    char soName[KERNEL_INFO_ENTRY_SIZE] = {};
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    program->kernelNames_ = {'a', 'b', 'c', 'd', '\0'};
    MOCKER_CPP(&Runtime::GetProgram).stubs().will(returnValue(true));
    MOCKER_CPP(&Runtime::PutProgram).stubs().will(ignoreReturnValue());
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    TaskInfo davinciKernelTask = {};
    davinciKernelTask.errorCode = TS_ERROR_REPEAT_NOTIFY_WAIT;
    InitByStream(&davinciKernelTask, (Stream *)stream);
    AicpuTaskInit(&davinciKernelTask, (uint16_t)1, (uint32_t)0);
    PreCheckTaskErr(&davinciKernelTask, devId);
    AicTaskInit(&davinciKernelTask, Program::MACH_AI_VECTOR, (uint16_t)1, (uint32_t)0, nullptr);
    PreCheckTaskErr(&davinciKernelTask, devId);
}

TEST_F(TaskTest, Init)
{
    rtError_t error;
    rtFftsPlusSqe_t fftsSqe = {{}, 0};
    void *descBuf = nullptr;  // device memory
    uint32_t descBufLen = 0;
    NpuDriver drv;
    // 压测MOCKER(CheckLogLevel).stubs().will(returnValue(1));
    rtFftsPlusTaskInfo_t fftsPlusTaskInfo = {&fftsSqe, descBuf, descBufLen, {NULL, NULL, 0, 0}};
    fftsPlusTaskInfo.descBuf = malloc(256);
    fftsPlusTaskInfo.descBufLen = 256;

    // 压测MOCKER(CheckLogLevel).stubs().will(returnValue(1));
    TaskInfo fftsPlusTask = {};
    InitByStream(&fftsPlusTask, stream_);

    error = FftsPlusTaskInit(&fftsPlusTask, &fftsPlusTaskInfo, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));

    error = FftsPlusTaskInit(&fftsPlusTask, &fftsPlusTaskInfo, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    TaskUnInitProc(&fftsPlusTask);
    free((void *)fftsPlusTaskInfo.descBuf);
}

TEST_F(TaskTest, InitFftsPlusTaskForDynamicShape)
{
    rtFftsPlusSqe_t fftsSqe = {{}, 0};
    void *descBuf = nullptr;  // device memory
    uint32_t descBufLen = 0;
    NpuDriver drv;
    uint32_t flag = 0x10;

    rtFftsPlusTaskInfo_t fftsPlusTaskInfo = {&fftsSqe, descBuf, descBufLen, {NULL, NULL, 0, 0}};
    fftsPlusTaskInfo.descBuf = malloc(256);
    fftsPlusTaskInfo.descBufLen = 256;

    TaskInfo fftsPlusTask = {};
    InitByStream(&fftsPlusTask, stream_);
    EXPECT_NE(fftsPlusTask.stream, nullptr);
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));

    rtError_t error = FftsPlusTaskInit(&fftsPlusTask, &fftsPlusTaskInfo, flag);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(fftsPlusTask.type, TS_TASK_TYPE_FFTS_PLUS);
    rtStarsSqe_t sqe[3] = {};
    ToConstructSqe(&fftsPlusTask, &sqe[0]);

    TaskUnInitProc(&fftsPlusTask);
    free((void *)fftsPlusTaskInfo.descBuf);
}

TEST_F(TaskTest, InitFftsPlusTaskForStaticShape)
{
    rtFftsPlusSqe_t fftsSqe = {{}, 0};
    void *descBuf = nullptr;  // device memory
    uint32_t descBufLen = 0;
    NpuDriver drv;
    uint32_t flag = 0x20;

    rtFftsPlusTaskInfo_t fftsPlusTaskInfo = {&fftsSqe, descBuf, descBufLen, {NULL, NULL, 0, 0}};
    fftsPlusTaskInfo.descBuf = malloc(256);
    fftsPlusTaskInfo.descBufLen = 256;

    TaskInfo fftsPlusTask = {};
    InitByStream(&fftsPlusTask, stream_);
    EXPECT_NE(fftsPlusTask.stream, nullptr);
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));

    FftsPlusTaskInit(&fftsPlusTask, &fftsPlusTaskInfo, flag);
    EXPECT_EQ(fftsPlusTask.type, TS_TASK_TYPE_FFTS_PLUS);
    rtStarsSqe_t sqe = {};
    ToConstructSqe(&fftsPlusTask, &sqe);

    TaskUnInitProc(&fftsPlusTask);
    free((void *)fftsPlusTaskInfo.descBuf);
}

TEST_F(TaskTest, ConstructSqe)
{
    TaskInfo task = {};
    rtError_t error;
    char *stub = "123";
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    EXPECT_NE(rtInstance, nullptr);
    rtInstance->SetBiuperfProfFlag(true);
    EXPECT_EQ(rtInstance->GetBiuperfProfFlag(), true);

    InitByStream(&task, stream_);
    EXPECT_NE(task.stream, nullptr);
    AicTaskInit(&task, Program::MACH_AI_VECTOR, 1, 3, nullptr);

    rtStarsSqe_t sqe = {};
    ToConstructSqe(&task, &sqe);
}

TEST_F(TaskTest, AllocSqeDevBuf)
{
    TaskInfo task = {};
    rtError_t error;
    char *stub = "123";
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    EXPECT_NE(rtInstance, nullptr);
    rtInstance->SetBiuperfProfFlag(true);
    EXPECT_EQ(rtInstance->GetBiuperfProfFlag(), true);

    InitByStream(&task, stream_);
    EXPECT_NE(task.stream, nullptr);

    task.isUpdateSinkSqe = true;
    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr, true);
    EXPECT_NE(task.u.aicTaskInfo.sqeDevBuf, nullptr);

    DavinciTaskUnInit(&task);
    EXPECT_EQ(task.u.aicTaskInfo.sqeDevBuf, nullptr);
}

TEST_F(TaskTest, ConstructSqe_MACH_AI_MIX_KERNEL_01)
{
    const void *stubFunc = (void *)0x02;
    const char *stubName = "abc";
    Kernel *kernel = NULL;
    PlainProgram stubProg(Program::MACH_AI_CORE);
    Program *program = &stubProg;
    program->kernelNames_ = {'a', 'b', 'c', 'd', '\0'};
    kernel = new (std::nothrow) Kernel(stubFunc, stubName, "", program, 0);

    TaskInfo task = {};
    rtError_t error;
    char *stub = "123";
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    rtInstance->SetBiuperfProfFlag(true);
    EXPECT_EQ(rtInstance->GetBiuperfProfFlag(), true);
    InitByStream(&task, stream_);
    EXPECT_NE(task.stream, nullptr);
    AicTaskInit(&task, Program::MACH_AI_MIX_KERNEL, 1, 3, nullptr);
    AicTaskInfo *aicTaskInfo = &(task.u.aicTaskInfo);
    aicTaskInfo->kernel = kernel;
    aicTaskInfo->kernel->funcType_ = KERNEL_FUNCTION_TYPE_AIC;

    rtStarsSqe_t sqe = {};
    ToConstructSqe(&task, &sqe);
    delete kernel;
    rtFftsPlusSqe_t *fftsSqe = &(sqe.fftsPlusSqe);
    EXPECT_EQ(fftsSqe->sqeHeader.type, RT_STARS_SQE_TYPE_FFTS);
}

TEST_F(TaskTest, ConstructSqe_MACH_AI_MIX_KERNEL_02)
{
    const void *stubFunc = (void *)0x02;
    const char *stubName = "abc";
    Kernel *kernel = NULL;
    PlainProgram stubProg(Program::MACH_AI_CORE);
    Program *program = &stubProg;
    program->kernelNames_ = {'a', 'b', 'c', 'd', '\0'};
    kernel = new (std::nothrow) Kernel(stubFunc, stubName, "", program, 0);
    TaskInfo task = {};
    rtError_t error;
    char *stub = "123";
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    EXPECT_NE(rtInstance, nullptr);
    rtInstance->SetBiuperfProfFlag(true);
    EXPECT_EQ(rtInstance->GetBiuperfProfFlag(), true);
    InitByStream(&task, stream_);
    EXPECT_NE(task.stream, nullptr);
    AicTaskInit(&task, Program::MACH_AI_MIX_KERNEL, 1, 3, nullptr);
    AicTaskInfo *aicTaskInfo = &(task.u.aicTaskInfo);
    aicTaskInfo->kernel = kernel;
    aicTaskInfo->kernel->funcType_ = KERNEL_FUNCTION_TYPE_AIV;

    rtStarsSqe_t sqe = {};
    ToConstructSqe(&task, &sqe);
    delete kernel;
    rtFftsPlusSqe_t *fftsSqe = &(sqe.fftsPlusSqe);
    EXPECT_EQ(fftsSqe->sqeHeader.type, RT_STARS_SQE_TYPE_FFTS);
}

TEST_F(TaskTest, ConstructSqe_MACH_AI_MIX_KERNEL_03)
{
    const void *stubFunc = (void *)0x02;
    const char *stubName = "abc";
    Kernel *kernel = NULL;
    PlainProgram stubProg(Program::MACH_AI_CORE);
    Program *program = &stubProg;
    program->kernelNames_ = {'a', 'b', 'c', 'd', '\0'};
    kernel = new (std::nothrow) Kernel(stubFunc, stubName, "", program, 0);
    TaskInfo task = {};
    rtError_t error;
    char *stub = "123";
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    EXPECT_NE(rtInstance, nullptr);
    rtInstance->SetBiuperfProfFlag(true);
    EXPECT_EQ(rtInstance->GetBiuperfProfFlag(), true);
    InitByStream(&task, stream_);
    EXPECT_NE(task.stream, nullptr);
    AicTaskInit(&task, Program::MACH_AI_MIX_KERNEL, 1, 3, nullptr);
    AicTaskInfo *aicTaskInfo = &(task.u.aicTaskInfo);
    aicTaskInfo->kernel = kernel;
    aicTaskInfo->kernel->funcType_ = KERNEL_FUNCTION_TYPE_INVALID;

    rtStarsSqe_t sqe = {};
    ToConstructSqe(&task, &sqe);
    delete kernel;
}

TEST_F(TaskTest, ConstructSqe_MACH_AI_MIX_KERNEL_04)
{
    TaskInfo task = {};
    rtError_t error;
    char *stub = "123";
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    EXPECT_NE(rtInstance, nullptr);
    rtInstance->SetBiuperfProfFlag(true);
    EXPECT_EQ(rtInstance->GetBiuperfProfFlag(), true);
    InitByStream(&task, stream_);
    EXPECT_NE(task.stream, nullptr);
    AicTaskInit(&task, Program::MACH_AI_CVMIX, 1, 3, nullptr);
    rtStarsSqe_t sqe = {};
    ToConstructSqe(&task, &sqe);
}

TEST_F(TaskTest, ProfilerTraceExTask_ConstructSqe)
{
    TaskInfo task = {};
    rtError_t error;
    InitByStream(&task, stream_);
    EXPECT_NE(task.stream, nullptr);
    error = ProfilerTraceExTaskInit(&task, 1, 1, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStarsSqe_t sqe = {};
    ToConstructSqe(&task, &sqe);
}

TEST_F(TaskTest, LabelSetTask_ConstructSqe)
{
    TaskInfo task = {};
    uint32_t devDestSize = 4;
    void *const devDestAddr = &devDestSize;

    InitByStream(&task, stream_);
    LabelSetTaskInit(&task, 1, devDestAddr);
    rtModel_t model;
    rtError_t ret = rtModelCreate(&model, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    stream_->SetModel(static_cast<Model *>(model));
    stream_->SetLatestModlId(static_cast<Model *>(model)->Id_());
    rtStarsSqe_t sqe = {};
    ToConstructSqe(&task, &sqe);
    EXPECT_EQ(sqe.phSqe.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
}

TEST_F(TaskTest, StarsCommonTask_ConstructSqe)
{
    Runtime *rt = ((Runtime *)Runtime::Instance());
    Device *device = new RawDevice(0);
    device->Init();
    Stream *stream = new Stream(device, 0);
    stream->streamId_ = 100;
    TaskInfo dvppTask = {};
    InitByStream(&dvppTask, stream);
    dvppTask.u.starsCommTask.errorTimes++;
    uint16_t errTimes = dvppTask.u.starsCommTask.errorTimes;
    EXPECT_EQ(errTimes, 1U);

    cce::runtime::rtStarsCommonSqe_t vpcSqe = {};
    vpcSqe.sqeHeader.type = RT_STARS_SQE_TYPE_FFTS;
    StarsCommonTaskInit(&dvppTask, vpcSqe, 0);

    vpcSqe.sqeHeader.type = RT_STARS_SQE_TYPE_CDQM;
    StarsCommonTaskInit(&dvppTask, vpcSqe, 0);

    vpcSqe.sqeHeader.type = RT_STARS_SQE_TYPE_VPC;
    StarsCommonTaskInit(&dvppTask, vpcSqe, 0);

    rtStarsSqe_t sqe = {};
    ToConstructSqe(&dvppTask, &sqe);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    ToConstructSqe(&dvppTask, &sqe);

    delete stream;
    delete device;
}

TEST_F(TaskTest, GetDevMsgTask_ConstructSqe)
{
    TaskInfo task = {};
    uint32_t devMemSize = 4;
    const void *devMemAddr = &devMemSize;
    InitByStream(&task, stream_);
    GetDevMsgTaskInit(&task, devMemAddr, devMemSize, RT_GET_DEV_ERROR_MSG);
    rtStarsSqe_t command;
    command.phSqe = {};
    ToConstructSqe(&task, &command);
    EXPECT_EQ(command.phSqe.task_type, TS_TASK_TYPE_GET_DEVICE_MSG);
}

void GetMsgCallbackStub1(const char *msg, uint32_t len) {}

TEST_F(TaskTest, CmoTask_test)
{
    rtError_t error;
    TaskInfo task = {};
    InitByStream(&task, stream_);
    EXPECT_NE(task.stream, nullptr);
    rtCmoTaskInfo_t cmoTask = {};
    error = CmoTaskInit(&task, &cmoTask, stream_, 0);

    Model *tmpModel = stream_->Model_();
    stream_->models_.clear();
    error = CmoTaskInit(&task, &cmoTask, stream_, 0);
    EXPECT_EQ(error, RT_ERROR_MODEL_NULL);
    stream_->SetModel(tmpModel);
    stream_->SetLatestModlId(tmpModel->Id_());
    MOCKER(memcpy_s).stubs().will(returnValue(1));
    error = CmoTaskInit(&task, &cmoTask, stream_, 0);
    EXPECT_EQ(error, RT_ERROR_SEC_HANDLE);
    rtStarsSqe_t sqe = {};
    ToConstructSqe(&task, &sqe);
}

TEST_F(TaskTest, BarrierTask_test)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);

    rtBarrierTaskInfo_t barrierTask = {};
    rtError_t error = BarrierTaskInit(&task, &barrierTask, stream_, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Model *tmpModel = stream_->Model_();
    stream_->models_.clear();
    error = BarrierTaskInit(&task, &barrierTask, stream_, 0);
    EXPECT_EQ(error, RT_ERROR_MODEL_NULL);
    stream_->SetModel(tmpModel);
    stream_->SetLatestModlId(tmpModel->Id_());
    MOCKER(memcpy_s).stubs().will(returnValue(1));
    error = BarrierTaskInit(&task, &barrierTask, stream_, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtStarsSqe_t sqe = {};
    ToConstructSqe(&task, &sqe);
}

TEST_F(TaskTest, npuGetFloatStatus_01)
{
    TaskInfo task = {};
    bool bindFlag = stream_->GetBindFlag();
    stream_->SetBindFlag(true);
    InitByStream(&task, stream_);
    uint32_t checkmode = 0;
    NpuGetFloatStaTaskInit(&task, nullptr, 32, checkmode);

    rtStarsSqe_t sqe = {};
    ToConstructSqe(&task, &sqe);
    stream_->SetBindFlag(bindFlag);
    EXPECT_EQ(sqe.getFloatStatusSqe.sqeHeader.type, RT_STARS_SQE_TYPE_COND);
}

TEST_F(TaskTest, npuGetFloatDebugStatus_01)
{
    TaskInfo task = {};
    bool bindFlag = stream_->GetBindFlag();
    stream_->SetBindFlag(true);
    InitByStream(&task, stream_);
    uint32_t checkmode = 0;
    NpuGetFloatStaTaskInit(&task, nullptr, 32, checkmode, true);

    rtStarsSqe_t sqe = {};
    ToConstructSqe(&task, &sqe);
    stream_->SetBindFlag(bindFlag);
    EXPECT_EQ(sqe.getFloatStatusSqe.sqeHeader.type, RT_STARS_SQE_TYPE_COND);
}

TEST_F(TaskTest, npuGetFloatStatus_02)
{
    TaskInfo task = {};
    bool bindFlag = stream_->GetBindFlag();
    stream_->SetBindFlag(false);
    InitByStream(&task, stream_);
    uint32_t checkmode = 0;
    NpuGetFloatStaTaskInit(&task, nullptr, 32, checkmode);

    rtStarsSqe_t sqe = {};
    ToConstructSqe(&task, &sqe);
    stream_->SetBindFlag(bindFlag);
    EXPECT_EQ(sqe.getFloatStatusSqe.sqeHeader.type, RT_STARS_SQE_TYPE_COND);

    TaskInfo tagTask = {};
    InitByStream(&tagTask, stream_);
    StreamTagSetTaskInit(&tagTask, stream_, 0);
    rtStarsSqe_t command;
    command.phSqe = {};
    ToConstructSqe(&tagTask, &command);
}

TEST_F(TaskTest, npuGetFloatDebugStatus_02)
{
    TaskInfo task = {};
    bool bindFlag = stream_->GetBindFlag();
    stream_->SetBindFlag(false);
    InitByStream(&task, stream_);
    uint32_t checkmode = 0;
    NpuGetFloatStaTaskInit(&task, nullptr, 32, checkmode, true);

    rtStarsSqe_t sqe = {};
    ToConstructSqe(&task, &sqe);
    stream_->SetBindFlag(bindFlag);
    EXPECT_EQ(sqe.getFloatStatusSqe.sqeHeader.type, RT_STARS_SQE_TYPE_COND);

    TaskInfo tagTask = {};
    InitByStream(&tagTask, stream_);
    StreamTagSetTaskInit(&tagTask, stream_, 0);
    rtStarsSqe_t command;
    command.phSqe = {};
    ToConstructSqe(&tagTask, &command);
}

TEST_F(TaskTest, npuClearFloatStatus_01)
{
    TaskInfo task = {};
    bool bindFlag = stream_->GetBindFlag();
    stream_->SetBindFlag(false);
    InitByStream(&task, stream_);
    uint32_t checkmode = 0;
    NpuClrFloatStaTaskInit(&task, checkmode);

    rtStarsSqe_t sqe = {};
    ToConstructSqe(&task, &sqe);
    stream_->SetBindFlag(bindFlag);
    EXPECT_EQ(sqe.phSqe.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
}

TEST_F(TaskTest, npuClearFloatDebugStatus_01)
{
    TaskInfo task = {};
    bool bindFlag = stream_->GetBindFlag();
    stream_->SetBindFlag(false);
    InitByStream(&task, stream_);
    uint32_t checkmode = 0;
    NpuClrFloatStaTaskInit(&task, checkmode, true);

    rtStarsSqe_t sqe = {};
    ToConstructSqe(&task, &sqe);
    stream_->SetBindFlag(bindFlag);
    EXPECT_EQ(sqe.phSqe.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
}

TEST_F(TaskTest, npuClearFloatStatus_02)
{
    TaskInfo task = {};
    bool bindFlag = stream_->GetBindFlag();
    stream_->SetBindFlag(true);
    InitByStream(&task, stream_);
    uint32_t checkmode = 0;
    NpuClrFloatStaTaskInit(&task, checkmode);

    rtStarsSqe_t sqe = {};
    ToConstructSqe(&task, &sqe);
    stream_->SetBindFlag(bindFlag);
    EXPECT_EQ(sqe.phSqe.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
}

TEST_F(TaskTest, npuClearFloatDebugStatus_02)
{
    TaskInfo task = {};
    bool bindFlag = stream_->GetBindFlag();
    stream_->SetBindFlag(true);
    InitByStream(&task, stream_);
    uint32_t checkmode = 0;
    NpuClrFloatStaTaskInit(&task, checkmode, true);

    rtStarsSqe_t sqe = {};
    ToConstructSqe(&task, &sqe);
    stream_->SetBindFlag(bindFlag);
    EXPECT_EQ(sqe.phSqe.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
}

TEST_F(TaskTest, PrintSqe)
{
    // EventResetTask
    TaskInfo eventResetTask = {};
    rtStarsSqe_t sqe = {};
    rtDavidSqe_t sqe1 = {};
    EXPECT_NE(&sqe, nullptr);
    PrintSqe(&sqe, "event reset");
    PrintDavidSqe(&sqe1, "event reset");
}

TEST_F(TaskTest, Task_base)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, (Stream *)stream);
    CreateL2AddrTaskInit(&task, 0x1);
    uint32_t errorcode = 10;
    SetResult(&task, (const uint32_t *)&errorcode, 1);
    Complete(&task, 0);
    rtStreamDestroy(stream);
}

TEST_F(TaskTest, ToCommandForFlipTask)
{
    TaskInfo task = {};
    task.stream = stream_;
    uint16_t flipNum = 1U;
    FlipTaskInit(&task, flipNum);
    rtCommand_t cmd = {};
    ToCommand(&task, &cmd);
    EXPECT_EQ(cmd.u.flipTask.flipNumReport, flipNum);
}

TEST_F(TaskTest, ToConstructSqeForFlipTask)
{
    TaskInfo task = {};
    task.stream = stream_;
    uint16_t flipNum = 1U;
    FlipTaskInit(&task, flipNum);

    rtStarsSqe_t sqe = {};
    ToConstructSqe(&task, &sqe);
    EXPECT_EQ(sqe.phSqe.task_type, TS_TASK_TYPE_FLIP);
}

TEST_F(TaskTest, ToConstructSqeForUpdateAddressTask)
{
    TaskInfo task = {};
    task.stream = stream_;
    UpdateAddressTaskInit(&task, 0, 1);

    rtStarsSqe_t sqe = {};
    ToConstructSqe(&task, &sqe);
    EXPECT_EQ(sqe.phSqe.task_type, TS_TASK_TYPE_UPDATE_ADDRESS);
}

TEST_F(TaskTest, FftsPlusTaskProcessErr)
{
    rtFftsPlusSqe_t fftsSqe = {{}, 0};
    void *descBuf = nullptr;  // device memory
    uint32_t descBufLen = 0;
    NpuDriver drv;
    uint32_t flag = 0x12;

    rtFftsPlusTaskInfo_t fftsPlusTaskInfo = {&fftsSqe, descBuf, descBufLen, {NULL, NULL, 0, 0}};
    fftsPlusTaskInfo.descBuf = malloc(256);
    fftsPlusTaskInfo.descBufLen = 256;

    TaskInfo fftsPlusTask = {};
    InitByStream(&fftsPlusTask, stream_);
    stream_->SetOverflowSwitch(true);

    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));

    rtError_t ret = FftsPlusTaskInit(&fftsPlusTask, &fftsPlusTaskInfo, flag);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStarsSqe_t sqe[3] = {};
    ToConstructSqe(&fftsPlusTask, &sqe[0]);
    rtLogicCqReport_t cqe;
    cqe.errorType = 1;
    cqe.errorCode = 1;
    SetStarsResult(&fftsPlusTask, cqe);
    Complete(&fftsPlusTask, 0);
    rtFftsPlusTaskErrInfo_t fftsPlusErrInfo = {};
    fftsPlusErrInfo.contextId = 1024;
    fftsPlusErrInfo.threadId = 0;
    fftsPlusErrInfo.errType = 1;
    PushBackErrInfo(&fftsPlusTask, static_cast<const void *>(&fftsPlusErrInfo), sizeof(rtFftsPlusTaskErrInfo_t));
    Complete(&fftsPlusTask, 0);
    TaskUnInitProc(&fftsPlusTask);
    free((void *)fftsPlusTaskInfo.descBuf);
}

TEST_F(TaskTest, FftsPlusTaskProcessErr1)
{
    rtFftsPlusSqe_t fftsSqe = {{}, 0};
    void *descBuf = nullptr;  // device memory
    uint32_t descBufLen = 0;
    NpuDriver drv;
    uint32_t flag = 0x12;

    rtFftsPlusTaskInfo_t fftsPlusTaskInfo = {&fftsSqe, descBuf, descBufLen, {NULL, NULL, 0, 0}};
    fftsPlusTaskInfo.descBuf = malloc(256);
    fftsPlusTaskInfo.descBufLen = 256;

    TaskInfo fftsPlusTask = {};
    InitByStream(&fftsPlusTask, stream_);
    stream_->SetOverflowSwitch(true);

    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));

    rtError_t ret = FftsPlusTaskInit(&fftsPlusTask, &fftsPlusTaskInfo, flag);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStarsSqe_t sqe[3] = {};
    ToConstructSqe(&fftsPlusTask, &sqe[0]);
    rtLogicCqReport_t cqe;
    cqe.errorType = 1;
    cqe.errorCode = 1;
    SetStarsResult(&fftsPlusTask, cqe);
    Complete(&fftsPlusTask, 0);
    rtFftsPlusTaskErrInfo_t fftsPlusErrInfo = {};
    fftsPlusErrInfo.contextId = 1024;
    fftsPlusErrInfo.threadId = 0;
    fftsPlusErrInfo.errType = 10;
    PushBackErrInfo(&fftsPlusTask, static_cast<const void *>(&fftsPlusErrInfo), sizeof(rtFftsPlusTaskErrInfo_t));
    Complete(&fftsPlusTask, 0);
    TaskUnInitProc(&fftsPlusTask);
    free((void *)fftsPlusTaskInfo.descBuf);
}

TEST_F(TaskTest, FftsPlusTaskProcessErr2)
{
    rtFftsPlusSqe_t fftsSqe = {{}, 0};
    void *descBuf = nullptr;  // device memory
    uint32_t descBufLen = 0;
    NpuDriver drv;
    uint32_t flag = 0x10;

    rtFftsPlusTaskInfo_t fftsPlusTaskInfo = {&fftsSqe, descBuf, descBufLen, {NULL, NULL, 0, 0}};
    fftsPlusTaskInfo.descBuf = malloc(256);
    fftsPlusTaskInfo.descBufLen = 256;

    TaskInfo fftsPlusTask = {};
    InitByStream(&fftsPlusTask, stream_);

    rtFftsPlusAicAivCtx_t temp = {};
    temp.contextType = RT_CTX_TYPE_AICORE;
    void *addr = reinterpret_cast<void *>(&temp);
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync)
        .stubs()
        .with(outBoundP(addr, sizeof(temp)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    rtError_t ret = FftsPlusTaskInit(&fftsPlusTask, &fftsPlusTaskInfo, flag);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStarsSqe_t sqe[3] = {};
    ToConstructSqe(&fftsPlusTask, &sqe[0]);
    rtLogicCqReport_t cqe;
    cqe.errorType = 1;
    cqe.errorCode = 1;
    SetStarsResult(&fftsPlusTask, cqe);
    Complete(&fftsPlusTask, 0);
    rtFftsPlusTaskErrInfo_t fftsPlusErrInfo = {};
    fftsPlusErrInfo.contextId = 0;
    fftsPlusErrInfo.threadId = 0;
    fftsPlusErrInfo.errType = 10;
    PushBackErrInfo(&fftsPlusTask, static_cast<const void *>(&fftsPlusErrInfo), sizeof(rtFftsPlusTaskErrInfo_t));
    Complete(&fftsPlusTask, 0);
    TaskUnInitProc(&fftsPlusTask);
    free((void *)fftsPlusTaskInfo.descBuf);
}

TEST_F(TaskTest, FftsPlusTaskProcessErr3)
{
    rtFftsPlusSqe_t fftsSqe = {{}, 0};
    void *descBuf = nullptr;  // device memory
    uint32_t descBufLen = 0;
    NpuDriver drv;
    uint32_t flag = 0x10;

    rtFftsPlusTaskInfo_t fftsPlusTaskInfo = {&fftsSqe, descBuf, descBufLen, {NULL, NULL, 0, 0}};
    fftsPlusTaskInfo.descBuf = malloc(256);
    fftsPlusTaskInfo.descBufLen = 256;

    TaskInfo fftsPlusTask = {};
    InitByStream(&fftsPlusTask, stream_);

    rtFftsPlusAicAivCtx_t temp = {};
    temp.contextType = RT_CTX_TYPE_MIX_AIC;
    void *addr = reinterpret_cast<void *>(&temp);
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync)
        .stubs()
        .with(outBoundP(addr, sizeof(temp)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    rtError_t ret = FftsPlusTaskInit(&fftsPlusTask, &fftsPlusTaskInfo, flag);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStarsSqe_t sqe[3] = {};
    ToConstructSqe(&fftsPlusTask, &sqe[0]);
    rtLogicCqReport_t cqe;
    cqe.errorType = 1;
    cqe.errorCode = 1;
    SetStarsResult(&fftsPlusTask, cqe);
    Complete(&fftsPlusTask, 0);
    rtFftsPlusTaskErrInfo_t fftsPlusErrInfo = {};
    fftsPlusErrInfo.contextId = 0;
    fftsPlusErrInfo.threadId = 0;
    fftsPlusErrInfo.errType = 10;
    PushBackErrInfo(&fftsPlusTask, static_cast<const void *>(&fftsPlusErrInfo), sizeof(rtFftsPlusTaskErrInfo_t));
    Complete(&fftsPlusTask, 0);
    TaskUnInitProc(&fftsPlusTask);
    free((void *)fftsPlusTaskInfo.descBuf);
}

TEST_F(TaskTest, FftsPlusTaskProcessErr5)
{
    rtFftsPlusSqe_t fftsSqe = {{}, 0};
    void *descBuf = nullptr;  // device memory
    uint32_t descBufLen = 0;
    NpuDriver drv;
    uint32_t flag = 0x10;

    rtFftsPlusTaskInfo_t fftsPlusTaskInfo = {&fftsSqe, descBuf, descBufLen, {NULL, NULL, 0, 0}, 1};
    fftsPlusTaskInfo.descBuf = malloc(256);
    fftsPlusTaskInfo.descBufLen = 256;

    TaskInfo fftsPlusTask = {};
    InitByStream(&fftsPlusTask, stream_);

    rtFftsPlusSdmaCtx_t temp = {};
    temp.contextType = RT_CTX_TYPE_SDMA;
    void *addr = reinterpret_cast<void *>(&temp);
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync)
        .stubs()
        .with(outBoundP(addr, sizeof(temp)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    rtError_t ret = FftsPlusTaskInit(&fftsPlusTask, &fftsPlusTaskInfo, flag);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtStarsSqe_t sqe[3] = {};
    ToConstructSqe(&fftsPlusTask, &sqe[0]);
    rtLogicCqReport_t cqe;
    cqe.errorType = 1;
    cqe.errorCode = 1;
    SetStarsResult(&fftsPlusTask, cqe);
    Complete(&fftsPlusTask, 0);
    rtFftsPlusTaskErrInfo_t fftsPlusErrInfo = {};
    fftsPlusErrInfo.contextId = 0;
    fftsPlusErrInfo.threadId = 0;
    fftsPlusErrInfo.errType = 4;
    PushBackErrInfo(&fftsPlusTask, static_cast<const void *>(&fftsPlusErrInfo), sizeof(rtFftsPlusTaskErrInfo_t));
    Complete(&fftsPlusTask, 0);
    TaskUnInitProc(&fftsPlusTask);
    free((void *)fftsPlusTaskInfo.descBuf);
}

TEST_F(TaskTest, DoCompleteSuccess_1)
{
    RawDevice *device = new RawDevice(0);
    MOCKER_CPP(&Stream::CheckASyncRecycle).stubs().will(returnValue(false));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);
    MOCKER_CPP_VIRTUAL(device->engine_, &Engine::WakeUpRecycleThread).stubs();

    Stream *stream = new Stream(device, 0);
    stream->Setup();

    rtError_t error = RT_ERROR_NONE;
    TaskInfo *task = device->GetTaskFactory()->Alloc(stream, TS_TASK_TYPE_MEMCPY, error);
    EXPECT_NE(task, nullptr);
    InitByStream(task, stream);
    MemcpyAsyncTaskInitV1(task, nullptr, RT_MEMCPY_HOST_TO_DEVICE);
    MemcpyAsyncTaskInfo *memcpyAsyncTsk = &task->u.memcpyAsyncTaskInfo;

    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::GetRunMode).stubs().will(returnValue((uint32_t)1));  // RT_RUN_MODE_ONLINE

    task->errorCode = 0;
    memcpyAsyncTsk->copyType = RT_MEMCPY_DIR_H2D;
    Complete(task, 0);
    device->GetTaskFactory()->Recycle(task);

    delete stream;
    delete device;
}

TEST_F(TaskTest, TryAgainAlloc)
{
    RawDevice *device = new RawDevice(0);
    MOCKER_CPP(&Stream::CheckASyncRecycle).stubs().will(returnValue(false));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);
    MOCKER_CPP_VIRTUAL(device->engine_, &Engine::WakeUpRecycleThread).stubs();

    Stream *stream = new Stream(device, 0);
    stream->Setup();

    MOCKER_CPP(&TaskAllocator::AllocId).stubs().will(returnValue(-1)).then(returnValue(0));
    rtError_t error = RT_ERROR_NONE;
    TaskInfo *task = device->GetTaskFactory()->Alloc(stream, TS_TASK_TYPE_MEMCPY, error);
    EXPECT_NE(task, nullptr);
    InitByStream(task, stream);
    MemcpyAsyncTaskInitV1(task, nullptr, RT_MEMCPY_HOST_TO_DEVICE);
    MemcpyAsyncTaskInfo *memcpyAsyncTsk = &task->u.memcpyAsyncTaskInfo;

    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::GetRunMode).stubs().will(returnValue((uint32_t)1));  // RT_RUN_MODE_ONLINE

    task->errorCode = 0;
    memcpyAsyncTsk->copyType = RT_MEMCPY_DIR_H2D;
    Complete(task, 0);
    device->GetTaskFactory()->Recycle(task);

    delete stream;
    delete device;
}

TEST_F(TaskTest, SetStreamModeTask)
{
    TaskInfo tsk = {};
    InitByStream(&tsk, stream_);
    rtError_t ret = SetStreamModeTaskInit(&tsk, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtCommand_t cmd = {};
    ToCommand(&tsk, &cmd);
    Complete(&tsk, 0);
}

TEST_F(TaskTest, FftsPlusTaskForDevAddr)
{
    rtFftsPlusSqe_t fftsSqe = {{}, 0};
    void *descBuf = nullptr;  // device memory
    uint32_t descBufLen = 0;
    NpuDriver drv;
    uint32_t flag = 0x10;

    rtFftsPlusTaskInfo_t fftsPlusTaskInfo = {&fftsSqe, descBuf, descBufLen, {NULL, NULL, 0, 0}, 0, 1, NULL};
    fftsPlusTaskInfo.descBuf = malloc(256);
    fftsPlusTaskInfo.descBufLen = 256;
    void *handleInfo[2] = {nullptr, nullptr};
    fftsPlusTaskInfo.argsHandleInfoPtr = handleInfo;
    TaskInfo fftsPlusTask = {};
    InitByStream(&fftsPlusTask, stream_);

    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    fftsPlusTask.errorCode = 0;
    rtError_t ret = FftsPlusTaskInit(&fftsPlusTask, &fftsPlusTaskInfo, flag);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    Model *tmpModel = stream_->Model_();
    stream_->models_.clear();
    DoCompleteSuccForFftsPlusTask(&fftsPlusTask, 0);
    rtStarsSqe_t sqe[3] = {};
    ToConstructSqe(&fftsPlusTask, &sqe[0]);

    struct Handle {
        void *kerArgs;
        void *smArgs;
        bool freeArgs;
        bool freeL2Desc;
        void *argsAlloc;
    };

    struct Handle hand;
    void *phand;
    hand.kerArgs = descBuf;
    hand.smArgs = descBuf;
    hand.freeArgs = true;
    hand.freeL2Desc = false;
    hand.kerArgs = nullptr;
    phand = (void *)&hand;

    fftsPlusTask.u.fftsPlusTask.argsHandleInfoNum = 1;
    fftsPlusTask.u.fftsPlusTask.argsHandleInfoPtr = new std::vector<void *>();
    fftsPlusTask.u.fftsPlusTask.argsHandleInfoPtr->push_back(phand);
    UmaArgLoader *argLoad = (UmaArgLoader *)(stream_->Device_()->ArgLoader_());
    MOCKER_CPP_VIRTUAL(*argLoad, &UmaArgLoader::Release).stubs().will(returnValue(RT_ERROR_NONE));

    DoCompleteSuccForFftsPlusTask(&fftsPlusTask, 0);

    fftsPlusTask.u.fftsPlusTask.argsHandleInfoNum = 1;
    fftsPlusTask.u.fftsPlusTask.argsHandleInfoPtr = new std::vector<void *>();
    fftsPlusTask.u.fftsPlusTask.argsHandleInfoPtr->push_back(phand);
    FftsPlusTaskUnInit(&fftsPlusTask);

    free((void *)fftsPlusTaskInfo.descBuf);
    stream_->SetModel(tmpModel);
    stream_->SetLatestModlId(tmpModel->Id_());
}

TEST_F(TaskTest, FftsPlusTaskForDevMemErr)
{
    rtFftsPlusSqe_t fftsSqe = {{}, 0};
    void *descBuf = nullptr;  // device memory
    uint32_t descBufLen = 0;
    NpuDriver drv;
    uint32_t flag = 0x10;

    rtFftsPlusTaskInfo_t fftsPlusTaskInfo = {&fftsSqe, descBuf, descBufLen, {NULL, NULL, 0, 0}, 0, 1, NULL};
    fftsPlusTaskInfo.descBuf = malloc(256);
    fftsPlusTaskInfo.descBufLen = 256;
    void *handleInfo[2] = {nullptr, nullptr};
    fftsPlusTaskInfo.argsHandleInfoPtr = handleInfo;
    TaskInfo fftsPlusTask = {};
    InitByStream(&fftsPlusTask, stream_);

    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    FftsPlusTaskInit(&fftsPlusTask, &fftsPlusTaskInfo, flag);
    fftsPlusTask.errorCode = 0x58;
    fftsPlusTask.mte_error = 0x58;
    DoCompleteSuccForFftsPlusTask(&fftsPlusTask, 0);
    rtStarsSqe_t sqe[3] = {};
    ToConstructSqe(&fftsPlusTask, &sqe[0]);

    FftsPlusTaskUnInit(&fftsPlusTask);
    EXPECT_EQ(fftsPlusTask.u.fftsPlusTask.errInfo, nullptr);
    free((void *)fftsPlusTaskInfo.descBuf);
}

TEST_F(TaskTest, FftsPlusTaskForDevMemErr_1)
{
    rtFftsPlusSqe_t fftsSqe = {{}, 0};
    void *descBuf = nullptr;  // device memory
    uint32_t descBufLen = 0;
    NpuDriver drv;
    uint32_t flag = 0x10;

    rtFftsPlusTaskInfo_t fftsPlusTaskInfo = {&fftsSqe, descBuf, descBufLen, {NULL, NULL, 0, 0}, 0, 1, NULL};
    fftsPlusTaskInfo.descBuf = malloc(256);
    fftsPlusTaskInfo.descBufLen = 256;
    void *handleInfo[2] = {nullptr, nullptr};
    fftsPlusTaskInfo.argsHandleInfoPtr = handleInfo;
    TaskInfo fftsPlusTask = {};
    InitByStream(&fftsPlusTask, stream_);

    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    FftsPlusTaskInit(&fftsPlusTask, &fftsPlusTaskInfo, flag);
    fftsPlusTask.errorCode = 0x220;
    fftsPlusTask.mte_error = 0x220;
    DoCompleteSuccForFftsPlusTask(&fftsPlusTask, 0);
    rtStarsSqe_t sqe[3] = {};
    ToConstructSqe(&fftsPlusTask, &sqe[0]);

    FftsPlusTaskUnInit(&fftsPlusTask);
    EXPECT_EQ(fftsPlusTask.u.fftsPlusTask.errInfo, nullptr);
    free((void *)fftsPlusTaskInfo.descBuf);
}

TEST_F(TaskTest, FftsPlusTaskForDevMemErr_2)
{
    rtFftsPlusSqe_t fftsSqe = {{}, 0};
    void *descBuf = nullptr;  // device memory
    uint32_t descBufLen = 0;
    NpuDriver drv;
    uint32_t flag = 0x10;

    rtFftsPlusTaskInfo_t fftsPlusTaskInfo = {&fftsSqe, descBuf, descBufLen, {NULL, NULL, 0, 0}, 0, 1, NULL};
    fftsPlusTaskInfo.descBuf = malloc(256);
    fftsPlusTaskInfo.descBufLen = 256;
    void *handleInfo[2] = {nullptr, nullptr};
    fftsPlusTaskInfo.argsHandleInfoPtr = handleInfo;
    TaskInfo fftsPlusTask = {};
    InitByStream(&fftsPlusTask, stream_);

    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    FftsPlusTaskInit(&fftsPlusTask, &fftsPlusTaskInfo, flag);
    fftsPlusTask.errorCode = 0x221;
    fftsPlusTask.mte_error = 0x221;
    DoCompleteSuccForFftsPlusTask(&fftsPlusTask, 0);
    rtStarsSqe_t sqe[3] = {};
    ToConstructSqe(&fftsPlusTask, &sqe[0]);

    FftsPlusTaskUnInit(&fftsPlusTask);
    EXPECT_EQ(fftsPlusTask.u.fftsPlusTask.errInfo, nullptr);
    free((void *)fftsPlusTaskInfo.descBuf);
}

TEST_F(TaskTest, ToConstructSqeForModelUpdateTask)
{
    NpuDriver drv;
    TaskInfo task = {};
    task.stream = stream_;
    uint16_t desStreamId = 0;
    uint16_t destaskId = 0;
    uint16_t exeStreamId = 0;
    void *devCopyMem = nullptr;
    uint32_t tilingTabLen = 1;
    rtFftsPlusTaskInfo_t fftsPlusTaskInfo;
    rtMdlTaskUpdateInfo_t para;
    para.tilingKeyAddr = nullptr;
    para.hdl = nullptr;
    para.fftsPlusTaskInfo = &fftsPlusTaskInfo;
    rtError_t ret = ModelTaskUpdateInit(&task, desStreamId, destaskId, exeStreamId, devCopyMem, tilingTabLen, &para);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemAddressTranslate).stubs().will(returnValue(RT_ERROR_NONE));

    rtStarsSqe_t sqe = {};
    ToConstructSqe(&task, &sqe);
    EXPECT_EQ(sqe.phSqe.task_type, TS_TASK_TYPE_MODEL_TASK_UPDATE);
}

TEST_F(TaskTest, SetSerialId)
{
    bool disableThread = Runtime::Instance()->GetDisableThread();
    if (!disableThread) {
        /* 在将SetDisableThread变更为true前做延时处理 */
        std::this_thread::sleep_for(std::chrono::milliseconds(10));
        ((Runtime *)Runtime::Instance())->SetDisableThread(true);
    }
    RawDevice *device = new RawDevice(0);
    device->Init();

    Stream *stream = new Stream(device, 0);
    stream->streamId_ = 100;
    TaskInfo davinciKernelTask_ = {};
    InitByStream(&davinciKernelTask_, (Stream *)stream);
    davinciKernelTask_.id = 65533;
    AicTaskInit(&davinciKernelTask_, 0, 1, 0, nullptr);

    device->GetTaskFactory()->SetSerialId(stream, &davinciKernelTask_);
    ((Runtime *)Runtime::Instance())->SetDisableThread(disableThread);
    EXPECT_EQ(davinciKernelTask_.type, TS_TASK_TYPE_KERNEL_AICORE);
    delete stream;
    delete device;
}

TEST_F(TaskTest, TransDavinciTaskToVectorCore)
{
    uint64_t addr2 = 0x100;
    uint64_t addr1 = 0x200;
    uint8_t mixType = 1;
    uint32_t kernelType = 0;

    TransDavinciTaskToVectorCore(0x1000, addr2, addr1, mixType, kernelType, true);
    EXPECT_EQ(addr1, 0x100);
    EXPECT_EQ(mixType, 0);
    EXPECT_EQ(kernelType, 2);
}

TEST_F(TaskTest, RemoteWaitTask)
{
    rtError_t ret;
    rtEvent_t event;
    uint32_t evtId;
    ret = rtEventCreateWithFlag(&event, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
    ret = rtGetEventID(event, &evtId);
    TaskInfo remoteWaitTask = {};
    InitByStream(&remoteWaitTask, stream_);
    Event *evt = (Event *)(event);
    ret = RemoteEventWaitTaskInit(&remoteWaitTask, evt, 0, evtId);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    rtCommand_t cmd = {};
    MOCKER_CPP(&Event::InsertWaitToMap).stubs();
    ToCommand(&remoteWaitTask, &cmd);
    MOCKER_CPP(&Event::DeleteWaitFromMap).stubs();
    MOCKER_CPP_VIRTUAL(evt, &Event::TryFreeEventIdAndCheckCanBeDelete)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    Complete(&remoteWaitTask, 0);
    rtEventDestroy(event);
}

TEST_F(TaskTest, Subscribe)
{
    GlobalMockObject::verify();

    rtError_t ret = RT_ERROR_NONE;
    NpuDriver drv;
    MOCKER_CPP(&Event::WaitForBusy).stubs().will(returnValue(1)).then(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::SqCqFree).stubs().will(returnValue(2)).then(returnValue(RT_ERROR_NONE));
    RawDevice *dev = new RawDevice(1);
    dev->Init();
    dev->driver_ = &drv;
    Stream *stm = new (std::nothrow) Stream(dev, RT_STREAM_PRIORITY_DEFAULT, RT_STREAM_FAST_SYNC, nullptr);
    CbSubscribe *cbSubscribe = new (std::nothrow) CbSubscribe(static_cast<uint32_t>(RT_THREAD_GROUP_ID_MAX));

    uint32_t devId = stm->Device_()->Id_();
    uint32_t tsId = stm->Device_()->DevGetTsId();
    int32_t streamId = stm->Id_();
    uint64_t threadId = 0;
    uint64_t threadIdGet = 0;
    uint32_t sqId = 0;
    uint32_t cqId = 0;
    uint32_t groupId = 0;

    // CbSubscribe::DeleteAll
    Event *evt = new (std::nothrow) Event();
    evt->device_ = stream_->Device_();
    uint64_t key = RT_CB_SUBSCRIBE_MK_STREAM_DEV_KEY(devId, streamId);
    cbSubscribeInfo subscribeInfo = {threadId, stm, sqId, cqId, groupId, evt};
    cbSubscribe->subscribeMapByStreamId_[key] = subscribeInfo;
    cbSubscribe->DeleteAll();
    cbSubscribe->DeleteAll();

    rtEvent_t event;
    Event *evt1 = (Event *)(event);
    cbSubscribeInfo subscribeInfo1 = {threadId, stm, sqId, cqId, groupId, evt1};
    cbSubscribe->subscribeMapByStreamId_[key] = subscribeInfo1;
    // CbSubscribe::GetSqIdByStreamId
    ret = cbSubscribe->GetSqIdByStreamId(devId, streamId, &sqId);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    // CbSubscribe::GetGroupIdByStreamId
    ret = cbSubscribe->GetGroupIdByStreamId(devId, streamId, &groupId);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    // CbSubscribe::GetThreadIdByStreamId
    ret = cbSubscribe->GetThreadIdByStreamId(devId, streamId, &threadIdGet);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(threadId, threadIdGet);

    ret = cbSubscribe->GetThreadIdByStreamId(devId, 0x1000, &threadIdGet);
    EXPECT_EQ(ret, RT_ERROR_SUBSCRIBE_STREAM);

    // CbSubscribe::IsExistInStreamMap
    bool exist = cbSubscribe->IsExistInStreamMap(stm);
    EXPECT_EQ(exist, true);
    // CbSubscribe::GetEventByStreamId
    cbSubscribe->subscribeMapByStreamId_.clear();
    ret = cbSubscribe->GetEventByStreamId(devId, streamId, &evt1);
    EXPECT_EQ(ret, RT_ERROR_SUBSCRIBE_STREAM);
    // CbSubscribe::IsExistInStreamMap
    exist = cbSubscribe->IsExistInStreamMap(stm);
    EXPECT_EQ(exist, false);

    // CbSubscribe::GetGroupIdByThreadId
    uint32_t key1 = RT_CB_SUBSCRIBE_MK_INFO_KEY(tsId, devId);
    cbSubscribe->subscribeMapByThreadId_[threadId][key1][streamId] = subscribeInfo1;
    ret = cbSubscribe->GetGroupIdByThreadId(threadId, &devId, &tsId, &groupId);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    delete cbSubscribe;
    delete stm;
    delete dev;
}

TEST_F(TaskTest, TestGetExceptionArgsForFftsPlus)
{
    TaskInfo taskInfo = {};
    rtExceptionArgsInfo_t argsInfo;

    rtExceptionExpandInfo_t expandInfo = {};
    taskInfo.u.fftsPlusTask.fftsSqe.subType = RT_STARS_FFTSPLUS_HCCL_WITHOUT_AICAIV_FLAG;
    taskInfo.u.fftsPlusTask.errInfo = new std::vector<rtFftsPlusTaskErrInfo_t>(0);
    rtFftsPlusTaskErrInfo_t fftsPlusErrInfo = {};
    taskInfo.u.fftsPlusTask.errInfo->push_back(fftsPlusErrInfo);
    GetExceptionArgsForFftsPlus(&taskInfo, &expandInfo, FFTS_PLUS_AICORE_ERROR, &argsInfo);
    EXPECT_EQ(argsInfo.argsize, 0U);
    EXPECT_EQ(argsInfo.sizeInfo.atomicIndex, 0U);

    taskInfo.u.fftsPlusTask.fftsSqe.subType = 0x5CU;
    taskInfo.u.fftsPlusTask.inputArgsSize.infoAddr = nullptr;
    GetExceptionArgsForFftsPlus(&taskInfo, &expandInfo, FFTS_PLUS_AICORE_ERROR, &argsInfo);
    EXPECT_EQ(argsInfo.argsize, 0U);
    EXPECT_EQ(argsInfo.sizeInfo.atomicIndex, 0U);

    taskInfo.u.fftsPlusTask.inputArgsSize.infoAddr = malloc(32);
    taskInfo.u.fftsPlusTask.inputArgsSize.atomicIndex = 1;
    taskInfo.u.fftsPlusTask.descAlignBuf = malloc(256);
    taskInfo.u.fftsPlusTask.descBufLen = 256;
    expandInfo.u.fftsPlusInfo.contextId = 0U;
    InitByStream(&taskInfo, stream_);
    NpuDriver drv;
    rtFftsPlusMixAicAivCtx_t temp = {};
    temp.contextType = RT_CTX_TYPE_MIX_AIC;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync)
        .stubs()
        .with(outBoundP(reinterpret_cast<void *>(&temp), sizeof(temp)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    GetExceptionArgsForFftsPlus(&taskInfo, &expandInfo, FFTS_PLUS_AICORE_ERROR, &argsInfo);
    EXPECT_EQ(argsInfo.sizeInfo.infoAddr, taskInfo.u.fftsPlusTask.inputArgsSize.infoAddr);
    EXPECT_EQ(argsInfo.sizeInfo.atomicIndex, taskInfo.u.fftsPlusTask.inputArgsSize.atomicIndex);
    GlobalMockObject::verify();

    temp.contextType = RT_CTX_TYPE_SDMA;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync)
        .stubs()
        .with(outBoundP(reinterpret_cast<void *>(&temp), sizeof(temp)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    GetExceptionArgsForFftsPlus(&taskInfo, &expandInfo, FFTS_PLUS_AICORE_ERROR, &argsInfo);
    EXPECT_EQ(argsInfo.argsize, 0U);
    EXPECT_EQ(argsInfo.sizeInfo.atomicIndex, 0U);

    taskInfo.u.fftsPlusTask.errInfo->clear();
    GetExceptionArgsForFftsPlus(&taskInfo, &expandInfo, ERROR_TYPE_BUTT, &argsInfo);
    EXPECT_EQ(argsInfo.argsize, 0U);
    EXPECT_EQ(argsInfo.sizeInfo.atomicIndex, 0U);

    free(taskInfo.u.fftsPlusTask.inputArgsSize.infoAddr);
    free(taskInfo.u.fftsPlusTask.descAlignBuf);
    delete taskInfo.u.fftsPlusTask.errInfo;
}

TEST_F(TaskTest, TestGetExceptionArgs)
{
    TaskInfo taskInfo = {};
    rtExceptionArgsInfo_t argsInfo;
    char addr[10];
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    AicTaskInfo *aicTaskInfo = &(taskInfo.u.aicTaskInfo);
    aicTaskInfo->inputArgsSize.infoAddr = (void *)(addr);  // here
    aicTaskInfo->comm.args = (void *)(addr);
    aicTaskInfo->comm.argsSize = 10;
    GetExceptionArgs(&taskInfo, &argsInfo);
    EXPECT_EQ(10, argsInfo.argsize);
}

TEST_F(TaskTest, TestReduceAsyncV2TaskInitFailed)
{
    TaskInfo memcpy_asyncv2_task = {};
    uint32_t res = RT_ERROR_MODEL_STREAM;
    InitByStream(&memcpy_asyncv2_task, stream_);
    rtError_t error =
        ReduceAsyncV2TaskInit(&memcpy_asyncv2_task, RT_MEMCPY_DIR_SDMA_AUTOMATIC_ADD, NULL, NULL, 0, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    SetResult(&memcpy_asyncv2_task, (void *)&res, 1);
    Complete(&memcpy_asyncv2_task, 0);
    TaskUnInitProc(&memcpy_asyncv2_task);
}

TEST_F(TaskTest, TestLabelSwitchTaskInit)
{
    TaskInfo switchTask = {};
    InitByStream(&switchTask, stream_);
    rtCommand_t command;
    uint32_t data = 0;
    const rtCondition_t cond = RT_EQUAL;
    const uint32_t val = 0;
    const uint16_t labelId = 1;
    rtError_t error = LabelSwitchTaskInit(&switchTask, &data, cond, val, labelId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ToCommand(&switchTask, &command);
    TaskUnInitProc(&switchTask);
}

TEST_F(TaskTest, TestLabelGotoTaskInit)
{
    TaskInfo gotoTask = {};
    rtCommand_t command;
    InitByStream(&gotoTask, stream_);
    const uint16_t labelId = 1;
    rtError_t error = LabelGotoTaskInit(&gotoTask, labelId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint32_t pos = 0;
    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync).stubs().will(returnValue(RT_ERROR_DEVICE_NULL));
    gotoTask.type = TS_TASK_TYPE_LABEL_SET;
    SetSqPos(&gotoTask, pos);

    ToCommand(&gotoTask, &command);
    TaskUnInitProc(&gotoTask);
}

TEST_F(TaskTest, ConstructSqeForMemcpyAsyncTask)
{
    TaskInfo memcpyAsyncTask = {};
    rtCommand_t command;
    rtStarsSqe_t sqe;

    InitByStream(&memcpyAsyncTask, stream_);
    uint32_t memcpyAddrInfo = 0;
    memcpyAsyncTask.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_ADDR_D2D_SDMA;
    memcpyAsyncTask.u.memcpyAsyncTaskInfo.copyKind = RT_MEMCPY_RESERVED;
    memcpyAsyncTask.u.memcpyAsyncTaskInfo.memcpyAddrInfo = &memcpyAddrInfo;
    ConstructSqeForMemcpyAsyncTask(&memcpyAsyncTask, &sqe);

    rtError_t error = GetModuleIdByMemcpyAddr(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ToCommand(&memcpyAsyncTask, &command);
    TaskUnInitProc(&memcpyAsyncTask);
}

bool CheckPcieBarStub(void)
{
    return true;
}

TEST_F(TaskTest, TestStreamLabelSwitchByIndexTaskInitFailed)
{
    TaskInfo labelSwitchTask = {};
    InitByStream(&labelSwitchTask, stream_);
    uint64_t ptr = 0;
    uint32_t max = 1;
    uint32_t labelInfoPtr[16] = {};
    InitByStream(&labelSwitchTask, stream_);
    rtError_t error = StreamLabelSwitchByIndexTaskInit(&labelSwitchTask, (void *)&ptr, max, (void *)labelInfoPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    uint32_t res = RT_ERROR_MODEL_STREAM;
    SetResult(&labelSwitchTask, (void *)&res, 1);
    Complete(&labelSwitchTask, 0);
    TaskUnInitProc(&labelSwitchTask);
}

TEST_F(TaskTest, davinci_kernel_task_abort)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    InitByStream(&task, (Stream *)stream);
    AicTaskInit(&task, Program::MACH_AI_CORE, 1, 1, nullptr);
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AICORE);
    uint32_t errorcode[3] = {10, 1, 0};
    SetResult(&task, (const uint32_t *)errorcode, 1);
    task.mte_error = TS_ERROR_AICORE_MTE_ERROR;
    PreCheckTaskErr(&task, 0);
    PrintErrorInfo(&task, 0);

    rtStreamDestroy(stream);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(TaskTest, stars_ipc_notify_record_sqe)
{
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t oriChipType = rtInstance->GetChipType();
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStarsSqe_t sqe;
    InitByStream(&task, (Stream *)stream);
    SingleBitNotifyRecordInfo single_bit_notify_info = {false, false, false, false, 0, 0, false};
    NotifyRecordTaskInit(&task, 0, 0, 0, &single_bit_notify_info, nullptr, nullptr, false);
    ToConstructSqe(&task, &sqe);

    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::GetChipFromDevice).stubs().will(returnValue((uint32_t)1));
    ToConstructSqe(&task, &sqe);
    Complete(&task, 0);
    rtStreamDestroy(stream);
}

//Memcpy Async D2D
TEST_F(TaskTest, stars_memcpy_async_miniv3)
{
    uint64_t add = 5;
    uint64_t add1 = 5;
    void *dst = &add1;
    void *src = &add;
    uint64_t count = 1;
    rtMemcpyKind_t kind = RT_MEMCPY_HOST_TO_DEVICE;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtInstance->ParseHostCpuModelInfo();
    uint32_t cpyType = 1;
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStarsSqe_t sqe;
    InitByStream(&task, (Stream *)stream);

    rtInstance->isRk3588Cpu_ = true;
    error = MemcpyAsyncTaskInitV3(&task, kind, src, dst, count, 0, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    kind = RT_MEMCPY_DEVICE_TO_HOST;
    error = MemcpyAsyncTaskInitV3(&task, kind, src, dst, count, 0, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    kind = RT_MEMCPY_HOST_TO_HOST;
    error = MemcpyAsyncTaskInitV3(&task, kind, src, dst, count, 0, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ToConstructSqe(&task, &sqe);

    rtLogicCqReport_t cqe = {};
    cqe.errorType = 1U;
    Complete(&task, 0);
    PrintErrorInfo(&task, 0);
    SetStarsResult(&task, cqe);
    TaskUnInitProc(&task);
    rtStreamDestroy(stream);
}

//Memcpy Async D2D
TEST_F(TaskTest, stars_memcpy_async_miniv3_offline)
{
    uint64_t add = 5;
    uint64_t add1 = 5;
    void *dst = &add1;
    void *src = &add;
    uint64_t count = 1;
    rtMemcpyKind_t kind = RT_MEMCPY_HOST_TO_DEVICE;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtInstance->ParseHostCpuModelInfo();
    uint32_t cpyType = 1;
    TaskInfo task = {};
    rtError_t error;
    rtStream_t stream = NULL;

    Driver *drv;
    drv = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL((NpuDriver *)(drv), &NpuDriver::GetRunMode)
        .stubs()
        .will(returnValue((uint32_t)RT_RUN_MODE_OFFLINE));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStarsSqe_t sqe;
    InitByStream(&task, (Stream *)stream);
    ((RawDevice *)(((Stream *)stream)->device_))->driver_ = drv;

    rtInstance->isRk3588Cpu_ = true;
    error = MemcpyAsyncTaskInitV3(&task, kind, src, dst, count, 0, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    kind = RT_MEMCPY_DEVICE_TO_HOST;
    error = MemcpyAsyncTaskInitV3(&task, kind, src, dst, count, 0, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ToConstructSqe(&task, &sqe);

    rtLogicCqReport_t cqe = {};
    cqe.errorType = 1U;
    Complete(&task, 0);
    PrintErrorInfo(&task, 0);
    SetStarsResult(&task, cqe);
    TaskUnInitProc(&task);
    rtStreamDestroy(stream);
}

TEST_F(TaskTest, memcpy_async_to_constructSqe_01)
{
    TaskInfo memcpyTask = {};
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    Device *device = new RawDevice(0);
    device->Init();
    Stream *stream = new Stream(device, 0);
    NpuDriver drv;

    rtError_t error;
    stream->streamId_ = 100;
    void *src = malloc(100);
    void *dst = malloc(100);
    uint64_t size = 100;

    memcpyTask.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_HOST_TO_DEVICE;

    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::GetRunMode).stubs().will(returnValue((uint32_t)0));
    InitByStream(&memcpyTask, stream);
    error = MemcpyAsyncTaskInitV3(&memcpyTask, RT_MEMCPY_DEVICE_TO_DEVICE, src, dst, size, 0, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    memcpyTask.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_D2D_SDMA;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::GetRunMode).stubs().will(returnValue((uint32_t)0));
    rtStarsSqe_t command;
    ToConstructSqe(&memcpyTask, &command);
    TaskUnInitProc(&memcpyTask);
    free(src);
    free(dst);
    delete stream;
    delete device;
}

TEST_F(TaskTest, DoCompleteSuccessForDavinciTask)
{
    uint32_t descBuf = 1;
    std::shared_ptr<PCTrace> pcTrace;
    TaskInfo task = {};
    InitByStream(&task, stream_);
    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    task.errorCode = 0;
    task.u.aicTaskInfo.mixOpt = 1;
    task.u.aicTaskInfo.descBuf = &descBuf;
    task.pcTrace = pcTrace;
    DoCompleteSuccessForDavinciTask(&task, 10);
    EXPECT_EQ(task.u.aicTaskInfo.descBuf, nullptr);
}

TEST_F(TaskTest, XpuBinaryLoadFromFile)
{
    EXPECT_EQ(XpuBinaryLoadFromFile(nullptr,nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(TaskTest, XpuLoad)
{
    BinaryLoader *bl;
    EXPECT_EQ(bl->XpuLoad(nullptr), RT_ERROR_NONE);
}

TEST_F(TaskTest, XpuRegisterCpuKernel)
{
    Program *pg;
    std::vector<CpuKernelInfo> kernelInfos;
    EXPECT_EQ(pg->XpuRegisterCpuKernel(kernelInfos), RT_ERROR_NONE);
}

TEST_F(TaskTest, SetStarsResultForDavinciTask)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    task.errorCode = 0;
    rtLogicCqReport_t logicCq;
    logicCq.errorType = RT_STARS_EXIST_ERROR;
    logicCq.errorCode = AE_STATUS_TASK_ABORT;
    SetStarsResultForDavinciTask(&task, logicCq);
    EXPECT_EQ(task.errorCode, 0);
    task.type = TS_TASK_TYPE_KERNEL_AIVEC;
    logicCq.errorCode = AE_STATUS_SILENT_FAULT;
    SetStarsResultForDavinciTask(&task, logicCq);
    EXPECT_EQ(task.errorCode, TS_ERROR_VECTOR_CORE_EXCEPTION);
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    SetStarsResultForDavinciTask(&task, logicCq);
    EXPECT_EQ(task.errorCode, TS_ERROR_AICORE_EXCEPTION);
}