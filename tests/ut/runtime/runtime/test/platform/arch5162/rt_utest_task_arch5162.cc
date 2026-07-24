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
#include "cond_op_label_task.h"
#include "model.hpp"
#include "stars_cond_isa_helper.hpp"
#include "cond_op_stream_task.h"
#include "stream_task.h"
#include "task_res.hpp"

using namespace cce::runtime;

class Arch5162TaskTest : public testing::Test {
protected:
    static void SetUpTestCase() { std::cout << "Arch5162TaskTest test start" << std::endl; }

    static void TearDownTestCase() { std::cout << "Arch5162TaskTest test start end" << std::endl; }

    virtual void SetUp() {}

    virtual void TearDown() { GlobalMockObject::verify(); }
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

    ret = ConvertAsyncDma(nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = ConvertAsyncDma2D(nullptr, nullptr, 0, nullptr, 0, 0, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = SqeUpdateH2DTaskInit(nullptr, nullptr, nullptr, 0, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = UpdateD2HTaskInit(nullptr, nullptr, 0, 0, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = MemWriteValueTaskInit(nullptr, nullptr, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    MemWaitTaskUnInit(nullptr);

    ret = MemWaitValueTaskInit(nullptr, nullptr, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = UpdateTaskD2HSubmit(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = UpdateTaskH2DSubmit(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    IpcEventDestroy(nullptr, 0, 0);

    ret = GetCaptureRecordTaskParams(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = GetCaptureWaitTaskParams(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = GetCaptureResetTaskParams(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = GetWriteValueTaskParams(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = GetWaitValueTaskParams(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = UpdateWriteValueTaskParams(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = UpdateWaitValueTaskParams(nullptr, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = CreateL2AddrTaskInit(nullptr, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ret = UpdateAddressTaskInit(nullptr, 0, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(Arch5162TaskTest, ConstructAICoreSqeForDavinciTask)
{
    MOCKER(GetAicoreKernelCredit).stubs().will(returnValue((uint16_t)0));
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
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
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
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
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
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
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
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
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo task = {};
    task.stream = stream;
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    uint32_t data[3] = {0x10000001, 0x00000002, 0x00000003};
    uint32_t errorcode = 10;
    PfnTaskSetResult setResultFunc = g_taskFuncArrays[CHIP_5162A].setResultFunc[task.type];
    setResultFunc(&task, (const uint32_t*)&errorcode, 1);
    EXPECT_EQ(task.errorCode, 10);

    Handle argHdl = {};
    argHdl.freeArgs = true;
    task.u.aicTaskInfo.comm.argHandle = static_cast<void*>(&argHdl);
    PfnWaitAsyncCpCompleteFunc waitFunc = g_taskFuncArrays[CHIP_5162A].waitAsyncCpCompleteFunc[task.type];
    waitFunc(&task);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, DavinciTaskUnInit_aicore)
{
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    taskInfo.u.aicTaskInfo.comm.argHandle = nullptr;
    taskInfo.u.aicTaskInfo.descBuf = nullptr;
    taskInfo.u.aicTaskInfo.sqeDevBuf = nullptr;
    taskInfo.u.aicTaskInfo.launchParam.placeHoderPtr = new (std::nothrow) rtHostInputInfo_t[2];
    ;
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
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
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

TEST_F(Arch5162TaskTest, ConstructSqeForMemcpyAsyncTask)
{
    MOCKER(PrintSqe).stubs();
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    ConstructSqeForMemcpyAsyncTask(&taskInfo, &sqe);
    EXPECT_EQ(sqe.phSqe.header.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, MemcpyAsyncTaskUnInitAndDoComplete)
{
    MOCKER(TaskFailCallBack).stubs();
    MOCKER(RecycleTaskResourceForMemcpyAsyncTask).stubs();
    MOCKER(PrintErrorInfoForMemcpyAsyncTask).stubs();
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo task = {};
    task.stream = stream;
    task.type = TS_TASK_TYPE_MEMCPY;
    task.u.memcpyAsyncTaskInfo.src = nullptr;
    task.u.memcpyAsyncTaskInfo.releaseArgHandle = nullptr;
    task.u.memcpyAsyncTaskInfo.guardMemVec = nullptr;
    task.u.memcpyAsyncTaskInfo.srcPtr = nullptr;
    task.u.memcpyAsyncTaskInfo.desPtr = nullptr;
    PfnTaskUnInit taskUnInitFunc = g_taskFuncArrays[CHIP_5162A].taskUnInitFunc[task.type];
    taskUnInitFunc(&task);

    task.errorCode = TS_ERROR_TASK_TIMEOUT;
    PfnDoCompleteSucc doCompleteSuccFunc = g_taskFuncArrays[CHIP_5162A].doCompleteSuccFunc[task.type];
    doCompleteSuccFunc(&task, 0);
    delete stream;
    delete device;
}
TEST_F(Arch5162TaskTest, ConstructLabelSetSqe)
{
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.u.labelSetTask.labelId = 0;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    ConstructSqeForLabelSetTask(&taskInfo, &sqe);
    EXPECT_EQ(sqe.phSqe.header.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ConstructLabelSwitchSqe)
{
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.u.stmLabelSwitchIdxTask.indexPtr = 0;
    taskInfo.u.stmLabelSwitchIdxTask.labelInfoPtr = 0;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    ConstructSqeForStreamLabelSwitchByIndexTask(&taskInfo, &sqe);
    EXPECT_EQ(sqe.phSqe.header.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ConstructStreamSwitchSqe)
{
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.u.streamswitchTask.trueStreamId = 0;
    taskInfo.u.streamswitchTask.condition = RT_EQUAL;
    taskInfo.u.streamswitchTask.dataType = RT_SWITCH_INT32;
    taskInfo.u.streamswitchTask.ptr = 0;
    taskInfo.u.streamswitchTask.valuePtr = 0;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    ConstructSqeForStreamSwitchTask(&taskInfo, &sqe);
    EXPECT_EQ(sqe.phSqe.header.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ConstructStreamActiveSqe)
{
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.u.streamactiveTask.activeStreamId = 0;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    ConstructSqeForStreamActiveTask(&taskInfo, &sqe);
    EXPECT_EQ(sqe.phSqe.header.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, LabelSetTaskInit)
{
    rtError_t error;
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    TaskResManage taskResMng;
    stream->taskResMang_ = &taskResMng;
    TaskInfo task = {};
    uint32_t devDestSize = 4;
    void* const devDestAddr = &devDestSize;
    task.stream = stream;
    error = LabelSetTaskInit(&task, 1, devDestAddr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    stream->taskResMang_ = nullptr;
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ToCommandBodyForStreamSwitchNTask)
{
    TaskInfo task = {};
    task.u.streamSwitchNTask.dataType = RT_SWITCH_INT32;
    task.u.streamSwitchNTask.elementSize = 4U;
    task.u.streamSwitchNTask.phyPtr = 0x1000ULL;
    task.u.streamSwitchNTask.phyTrueStreamPtr = 0x2000ULL;
    task.u.streamSwitchNTask.phyValuePtr = 0x3000ULL;
    task.u.streamSwitchNTask.size = 16U;
    task.u.streamSwitchNTask.isTransAddr = true;
    rtCommand_t command = {};
    ToCommandBodyForStreamSwitchNTask(&task, &command);
    EXPECT_EQ(command.u.streamSwitchNTask.dataType, static_cast<uint8_t>(RT_SWITCH_INT32));
}

TEST_F(Arch5162TaskTest, StreamLabelSwitchByIndexTaskInit)
{
    rtError_t error;
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    TaskResManage taskResMng;
    stream->taskResMang_ = &taskResMng;
    TaskInfo task = {};
    uint64_t ptr = 0;
    uint32_t max = 1;
    uint32_t labelInfoPtr[16] = {};
    rtStarsSqe_t sqe[2];
    task.stream = stream;
    error = StreamLabelSwitchByIndexTaskInit(&task, (void*)&ptr, max, (void*)labelInfoPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    stream->taskResMang_ = nullptr;
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, StreamActiveTaskInit)
{
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    TaskResManage taskResMng;
    stream->taskResMang_ = &taskResMng;
    TaskInfo task = {};
    task.stream = stream;
    rtError_t error = StreamActiveTaskInit(&task, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    stream->taskResMang_ = nullptr;
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ConstructSqeForMaintenanceTask)
{
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.id = 10;
    taskInfo.u.maintenanceTaskInfo.mtType = MT_STREAM_DESTROY;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    PfnTaskToSqe toSqeFunc = g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_MAINTENANCE];
    ASSERT_NE(toSqeFunc, nullptr);
    toSqeFunc(&taskInfo, &sqe);
    EXPECT_EQ(sqe.phSqe.header.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    EXPECT_EQ(sqe.phSqe.header.wrCqe, 1U);
    EXPECT_EQ(sqe.phSqe.header.preP, RT_STARS_SQE_INT_DIR_TO_TSCPU);
    EXPECT_EQ(sqe.phSqe.header.postP, RT_STARS_SQE_INT_DIR_NO);
    EXPECT_EQ(sqe.phSqe.header.u.sqeSubType, RT_SQE_SUBTYPE_RESERVED);
    EXPECT_EQ(sqe.phSqe.header.rtStreamId, static_cast<uint16_t>(stream->Id_()));
    EXPECT_EQ(sqe.phSqe.header.taskId, taskInfo.id);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ConstructSqeForMaintenanceTask_RecycleTask)
{
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.id = 20;
    taskInfo.u.maintenanceTaskInfo.mtType = MT_STREAM_RECYCLE_TASK;
    taskInfo.u.maintenanceTaskInfo.flag = true;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    PfnTaskToSqe toSqeFunc = g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_MAINTENANCE];
    ASSERT_NE(toSqeFunc, nullptr);
    toSqeFunc(&taskInfo, &sqe);
    EXPECT_EQ(sqe.phSqe.header.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    EXPECT_EQ(sqe.phSqe.header.wrCqe, 1U);
    EXPECT_EQ(sqe.phSqe.header.rtStreamId, static_cast<uint16_t>(stream->Id_()));
    EXPECT_EQ(sqe.phSqe.header.taskId, taskInfo.id);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, MaintenanceTaskRegister)
{
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_MAINTENANCE], nullptr);
    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].toCommandFunc[TS_TASK_TYPE_MAINTENANCE], nullptr);
    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].doCompleteSuccFunc[TS_TASK_TYPE_MAINTENANCE], nullptr);
    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].taskUnInitFunc[TS_TASK_TYPE_MAINTENANCE], nullptr);
    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].waitAsyncCpCompleteFunc[TS_TASK_TYPE_MAINTENANCE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].printErrorInfoFunc[TS_TASK_TYPE_MAINTENANCE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].setResultFunc[TS_TASK_TYPE_MAINTENANCE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].setStarsResultFunc[TS_TASK_TYPE_MAINTENANCE], nullptr);
}
