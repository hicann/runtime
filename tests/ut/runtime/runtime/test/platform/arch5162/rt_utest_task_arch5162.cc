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
#define protected public
#define private public
#include "base.hpp"
#include "task.hpp"
#include "stars.hpp"
#include "hwts.hpp"
#include "rt_unwrap.h"
#undef protected
#undef private
#include "runtime/rt.h"
#include "event_task.h"
#include "memory_task.h"
#include "task_info_v100.h"
#include "task_info.hpp"
#include "runtime.hpp"
#include "raw_device.hpp"
#include "thread_local_container.hpp"
#include "log_types.h"
#include "task_execute_time.h"
#include "device_error_proc.hpp"

using namespace cce::runtime;

class Arch5162TaskTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "Arch5162TaskTest test start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "Arch5162TaskTest test start end" << std::endl;
    }

    virtual void SetUp() {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(Arch5162TaskTest, StubTask)
{
    Construct2ndSqeForCaptureConditionTask(nullptr, nullptr);

    ConstructSqeForNotifyRecordTask(nullptr, nullptr);

    uint16_t eventId = GetSqeEventId(nullptr);
    EXPECT_EQ(eventId, 0U);

    int32_t countNum = 5;
    PrintAsyncPtrProc(nullptr, nullptr, nullptr, countNum);
    EXPECT_EQ(countNum, 5);

    uint32_t sqeNum = GetSendSqeNum(nullptr);
    EXPECT_EQ(sqeNum, 1U);

    rtError_t ret = MixKernelUpdatePrepare(nullptr, nullptr, 0U);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = NormalKernelUpdatePrepare(nullptr, nullptr, 0U);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ConstructAICpuSqeForDavinciTask(nullptr, nullptr);
}

TEST_F(Arch5162TaskTest, ConstructAICoreSqeForDavinciTask)
{
    MOCKER(GetAicoreKernelCredit).stubs().will(returnValue((uint16_t)0));
    RawDevice *device = new RawDevice(0);
    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.u.aicTaskInfo.kernel = nullptr;
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    ConstructAICoreSqeForDavinciTask(&taskInfo, &sqe);
    EXPECT_EQ(sqe.aicAivKernelSqe.header.type, TS_TASK_TYPE_KERNEL_AICORE);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, SetStarsResultForDavinciTask_aicpu)
{
    RawDevice *device = new RawDevice(0);
    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo task = {};
    task.stream = stream;
    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    task.errorCode = 0;
    rtLogicCqReport_t logicCq;
    logicCq.errorType = RT_STARS_EXIST_ERROR;
    logicCq.errorCode = AE_STATUS_TASK_ABORT;
    SetStarsResultForDavinciTask(&task, logicCq);
    EXPECT_EQ(task.errorCode, 0);
    logicCq.errorCode = AICPU_HCCL_OP_RETRY_FAILED;
    SetStarsResultForDavinciTask(&task, logicCq);
    EXPECT_EQ(task.errorCode, TS_ERROR_AICPU_HCCL_OP_RETRY_FAILED);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, SetStarsResultForDavinciTask_aicore)
{
    RawDevice *device = new RawDevice(0);
    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo task = {};
    task.stream = stream;
    task.type = TS_TASK_TYPE_KERNEL_AIVEC;
    task.errorCode = 0;
    rtLogicCqReport_t logicCq;
    logicCq.errorType = RT_STARS_EXIST_ERROR;
    logicCq.errorCode = AE_STATUS_TASK_ABORT;
    SetStarsResultForDavinciTask(&task, logicCq);
    EXPECT_EQ(task.errorCode, TS_ERROR_VECTOR_CORE_EXCEPTION);
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    SetStarsResultForDavinciTask(&task, logicCq);
    EXPECT_EQ(task.errorCode, TS_ERROR_AICORE_EXCEPTION);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, DoCompleteSuccessForDavinciTask)
{
    MOCKER_CPP(&Stream::IsSeparateSendAndRecycle).stubs().will(returnValue(true));
    MOCKER_CPP(&Stream::SetArgHandle).stubs();
    uint32_t descBuf = 1;
    std::shared_ptr<PCTrace> pcTrace;
    RawDevice *device = new RawDevice(0);
    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo task = {};
    task.stream = stream;
    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    task.errorCode = 0;
    task.u.aicTaskInfo.mixOpt = 1;
    task.u.aicTaskInfo.descBuf = &descBuf;
    task.pcTrace = pcTrace;
    DoCompleteSuccessForDavinciTask(&task, 10);
    EXPECT_EQ(task.u.aicTaskInfo.descBuf, nullptr);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, SetResultForDavinciTask)
{
    MOCKER_CPP(&H2DCopyMgr::H2DMemCopyWaitFinish).stubs().will(returnValue(RT_ERROR_NONE));
    RawDevice *device = new RawDevice(0);
    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo task = {};
    task.stream = stream;
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    uint32_t data[3] = {0x10000001, 0x00000002, 0x00000003};
    uint32_t errorcode = 10;
    PfnTaskSetResult setResultFunc = g_taskFuncArrays[CHIP_5162A].setResultFunc[task.type];
    setResultFunc(&task, (const uint32_t *)&errorcode, 1);
    EXPECT_EQ(task.errorCode, 10);

    Handle argHdl = {};
    argHdl.freeArgs = true;
    task.u.aicTaskInfo.comm.argHandle = static_cast<void *>(&argHdl);
    PfnWaitAsyncCpCompleteFunc waitFunc = g_taskFuncArrays[CHIP_5162A].waitAsyncCpCompleteFunc[task.type];
    waitFunc(&task);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, DavinciTaskUnInit_aicore)
{
    RawDevice *device = new RawDevice(0);
    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    taskInfo.u.aicTaskInfo.comm.argHandle = nullptr;
    taskInfo.u.aicTaskInfo.descBuf = nullptr;
    taskInfo.u.aicTaskInfo.sqeDevBuf = nullptr;
    taskInfo.u.aicTaskInfo.launchParam.placeHoderPtr = new (std::nothrow) rtHostInputInfo_t[2];;
    DavinciTaskUnInit(&taskInfo);
    EXPECT_EQ(taskInfo.u.aicTaskInfo.comm.argHandle, nullptr);
    EXPECT_EQ(taskInfo.u.aicTaskInfo.descBuf, nullptr);
    EXPECT_EQ(taskInfo.u.aicTaskInfo.sqeDevBuf, nullptr);
    EXPECT_EQ(taskInfo.u.aicTaskInfo.launchParam.placeHoderPtr, nullptr);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, DavinciTaskUnInit_aicpu)
{
    RawDevice *device = new RawDevice(0);
    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICPU;
    taskInfo.u.aicpuTaskInfo.comm.argHandle = nullptr;
    DavinciTaskUnInit(&taskInfo);
    EXPECT_EQ(taskInfo.u.aicpuTaskInfo.comm.argHandle, nullptr);
    EXPECT_EQ(taskInfo.u.aicpuTaskInfo.funcName, nullptr);
    EXPECT_EQ(taskInfo.u.aicpuTaskInfo.soName, nullptr);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, DavinciKernelTaskRegister)
{
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_KERNEL_AICORE], nullptr);
    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].toCommandFunc[TS_TASK_TYPE_KERNEL_AICORE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].doCompleteSuccFunc[TS_TASK_TYPE_KERNEL_AICORE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].taskUnInitFunc[TS_TASK_TYPE_KERNEL_AICORE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].waitAsyncCpCompleteFunc[TS_TASK_TYPE_KERNEL_AICORE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].printErrorInfoFunc[TS_TASK_TYPE_KERNEL_AICORE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].setResultFunc[TS_TASK_TYPE_KERNEL_AICORE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].setStarsResultFunc[TS_TASK_TYPE_KERNEL_AICORE], nullptr);

    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_KERNEL_AIVEC], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_KERNEL_AICPU], nullptr);
}
