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
#include "runtime.hpp"
#include "raw_device.hpp"
#include "notify.hpp"
#undef protected
#undef private
#include "runtime/rt.h"
#include "event_task.h"
#include "memory_task.h"
#include "model_execute_task.h"
#include "task_info_v100.h"
#include "task_info.hpp"
#include "npu_driver.hpp"
#include "model.hpp"
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
#include "davinci_kernel_task.h"
#include "event.hpp"
#include "reduce_task.h"
#include "kernel_fusion_task.h"
#include "model_to_aicpu_task.h"
#include "model_update_task.h"

using namespace cce::runtime;

namespace {
constexpr uint32_t DUMP_ARGS_SIZE = 256U;
constexpr uint64_t DUMP_ARGS_BASE = 0x1000ULL;
uint8_t g_dumpArgsBuf[DUMP_ARGS_SIZE] = {};
bool g_memCopySyncFail = false;

rtError_t DumpAicpuArgsMemCopyStub(
    Driver* drv, void* dst, uint64_t destMax, const void* src, uint64_t size, rtMemcpyKind_t kind)
{
    if (g_memCopySyncFail) {
        return RT_ERROR_INVALID_VALUE;
    }
    (void)memcpy_s(dst, static_cast<size_t>(destMax), g_dumpArgsBuf, static_cast<size_t>(size));
    return RT_ERROR_NONE;
}

void InitAicpuTaskInfoForDump(
    TaskInfo& taskInfo, Stream* stream, uint32_t argsSize, void* args, void* soName, void* funcName)
{
    taskInfo.stream = stream;
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICPU;
    taskInfo.errorCode = 0x2A;
    taskInfo.id = 42;
    taskInfo.u.aicpuTaskInfo.kernel = nullptr;
    taskInfo.u.aicpuTaskInfo.aicpuKernelType = TS_AICPU_KERNEL_AICPU;
    taskInfo.u.aicpuTaskInfo.kernelInnerHandle = nullptr;
    taskInfo.u.aicpuTaskInfo.comm.argsSize = argsSize;
    taskInfo.u.aicpuTaskInfo.comm.args = args;
    taskInfo.u.aicpuTaskInfo.soName = soName;
    taskInfo.u.aicpuTaskInfo.funcName = funcName;
    taskInfo.u.aicpuTaskInfo.headParamOffset = 0;
    taskInfo.u.aicpuTaskInfo.aicpuFlags = 0;
    taskInfo.u.aicpuTaskInfo.timeout = 0;
}
} // namespace

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

    rtStarsSqe_t sqe = {};
    uint16_t eventId = GetSqeEventId(&sqe);
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
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo task = {};
    task.stream = stream;
    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    task.errorCode = 0;
    task.u.aicTaskInfo.mixOpt = 1;
    task.u.aicTaskInfo.descBuf = &descBuf;
    DoCompleteSuccessForDavinciTask(&task, 10);
    EXPECT_EQ(task.u.aicTaskInfo.descBuf, nullptr);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, DoCompleteSuccessForDavinciTaskWithModel)
{
    MOCKER_CPP(&Stream::IsSeparateSendAndRecycle).stubs().will(returnValue(true));
    uint32_t descBuf = 1;
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    ASSERT_NE(stream, nullptr);
    Model model;
    stream->SetModel(&model);
    TaskInfo task = {};
    task.stream = stream;
    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    task.errorCode = 0;
    task.id = 1U;
    task.u.aicTaskInfo.mixOpt = 1U;
    task.u.aicTaskInfo.descBuf = &descBuf;
    Handle argHdl = {};
    argHdl.freeArgs = true;
    task.u.aicTaskInfo.comm.argHandle = static_cast<void*>(&argHdl);
    DoCompleteSuccessForDavinciTask(&task, 10);
    EXPECT_EQ(task.u.aicTaskInfo.descBuf, nullptr);
    void* retrieved = model.GetArgHandle(static_cast<uint16_t>(stream->Id_()), task.id);
    EXPECT_NE(retrieved, nullptr);
    EXPECT_EQ(task.u.aicTaskInfo.comm.argHandle, nullptr);
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

TEST_F(Arch5162TaskTest, ConstructSqeForNotifyRecordTask)
{
    MOCKER(PrintSqe).stubs();
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.id = 1;
    taskInfo.u.notifyrecordTask.notifyId = 100;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    ConstructSqeForNotifyRecordTask(&taskInfo, &sqe);
    EXPECT_EQ(sqe.writeValueSqe.header.type, RT_STARS_SQE_TYPE_WRITE_VALUE);
    EXPECT_EQ(sqe.writeValueSqe.notifyId, 100);
    EXPECT_EQ(sqe.writeValueSqe.subType, RT_SQE_SUBTYPE_NOTIFY_ID);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ConstructSqeForNotifyWaitTask)
{
    MOCKER(PrintSqe).stubs();
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.id = 1;
    taskInfo.u.notifywaitTask.notifyId = 100;
    taskInfo.u.notifywaitTask.timeout = 0;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    PfnTaskToSqe toSqeFunc = g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_NOTIFY_WAIT];
    ASSERT_NE(toSqeFunc, nullptr);
    toSqeFunc(&taskInfo, &sqe);
    EXPECT_EQ(sqe.notifySqe.header.type, RT_STARS_SQE_TYPE_NOTIFY_WAIT);
    EXPECT_EQ(sqe.notifySqe.notify_id, 100);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ConstructSqeForEventRecordTask)
{
    MOCKER(PrintSqe).stubs();
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    Event event(device, RT_EVENT_DEFAULT, nullptr, false, true);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.id = 1;
    taskInfo.u.eventRecordTaskInfo.event = &event;
    taskInfo.u.eventRecordTaskInfo.eventid = 5;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    PfnTaskToSqe toSqeFunc = g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_EVENT_RECORD];
    ASSERT_NE(toSqeFunc, nullptr);
    toSqeFunc(&taskInfo, &sqe);
    EXPECT_EQ(sqe.writeValueSqe.header.type, RT_STARS_SQE_TYPE_WRITE_VALUE);
    EXPECT_EQ(sqe.writeValueSqe.notifyId, 5);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ConstructSqeForEventResetTask)
{
    MOCKER(PrintSqe).stubs();
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.id = 1;
    taskInfo.u.eventResetTaskInfo.eventid = 10;
    taskInfo.u.eventResetTaskInfo.event = nullptr;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    PfnTaskToSqe toSqeFunc = g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_EVENT_RESET];
    ASSERT_NE(toSqeFunc, nullptr);
    toSqeFunc(&taskInfo, &sqe);
    EXPECT_EQ(sqe.writeValueSqe.header.type, RT_STARS_SQE_TYPE_WRITE_VALUE);
    EXPECT_EQ(sqe.writeValueSqe.notifyId, 10);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ConstructSqeForEventWaitTask)
{
    MOCKER(PrintSqe).stubs();
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.id = 1;
    taskInfo.u.eventWaitTaskInfo.eventId = 7;
    taskInfo.u.eventWaitTaskInfo.timeout = 0;
    taskInfo.u.eventWaitTaskInfo.event = nullptr;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    PfnTaskToSqe toSqeFunc = g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_STREAM_WAIT_EVENT];
    ASSERT_NE(toSqeFunc, nullptr);
    toSqeFunc(&taskInfo, &sqe);
    EXPECT_EQ(sqe.notifySqe.header.type, RT_STARS_SQE_TYPE_NOTIFY_WAIT);
    EXPECT_EQ(sqe.notifySqe.notify_id, 7);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, CaptureStubs)
{
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    Event event(device, RT_EVENT_DEFAULT, nullptr, false, true);

    rtError_t ret = event.CaptureWaitProcess(stream);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    bool result = event.IsCapturing();
    EXPECT_EQ(result, false);

    CaptureModel* mdl = event.GetCaptureModel();
    EXPECT_EQ(mdl, nullptr);

    result = event.ToBeCaptured(stream);
    EXPECT_EQ(result, false);

    result = event.IsRecordOrigCaptureStream(stream);
    EXPECT_EQ(result, false);

    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, EventTaskRegister)
{
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_EVENT_RECORD], nullptr);
    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].toCommandFunc[TS_TASK_TYPE_EVENT_RECORD], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].doCompleteSuccFunc[TS_TASK_TYPE_EVENT_RECORD], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].taskUnInitFunc[TS_TASK_TYPE_EVENT_RECORD], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].setStarsResultFunc[TS_TASK_TYPE_EVENT_RECORD], nullptr);

    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_EVENT_RESET], nullptr);
    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].toCommandFunc[TS_TASK_TYPE_EVENT_RESET], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].doCompleteSuccFunc[TS_TASK_TYPE_EVENT_RESET], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].taskUnInitFunc[TS_TASK_TYPE_EVENT_RESET], nullptr);

    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_REMOTE_EVENT_WAIT], nullptr);
    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].toCommandFunc[TS_TASK_TYPE_REMOTE_EVENT_WAIT], nullptr);
    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].doCompleteSuccFunc[TS_TASK_TYPE_REMOTE_EVENT_WAIT], nullptr);

    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_NOTIFY_WAIT], nullptr);
    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].toCommandFunc[TS_TASK_TYPE_NOTIFY_WAIT], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].doCompleteSuccFunc[TS_TASK_TYPE_NOTIFY_WAIT], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].printErrorInfoFunc[TS_TASK_TYPE_NOTIFY_WAIT], nullptr);

    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_STREAM_WAIT_EVENT], nullptr);
    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].toCommandFunc[TS_TASK_TYPE_STREAM_WAIT_EVENT], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].doCompleteSuccFunc[TS_TASK_TYPE_STREAM_WAIT_EVENT], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].printErrorInfoFunc[TS_TASK_TYPE_STREAM_WAIT_EVENT], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].setStarsResultFunc[TS_TASK_TYPE_STREAM_WAIT_EVENT], nullptr);

    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_NOTIFY_RECORD], nullptr);
    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].toCommandFunc[TS_TASK_TYPE_NOTIFY_RECORD], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].doCompleteSuccFunc[TS_TASK_TYPE_NOTIFY_RECORD], nullptr);
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

TEST_F(Arch5162TaskTest, ConstructSqeForCallbackLaunchTask)
{
    MOCKER_CPP(&Stream::GetCbRptCqid).stubs().will(returnValue(1U));
    MOCKER_CPP(&Stream::GetCbGrpId).stubs().will(returnValue(1U));
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.u.callbackLaunchTask.eventId = 0;
    taskInfo.u.callbackLaunchTask.isBlock = false;
    taskInfo.u.callbackLaunchTask.callBackFunc = nullptr;
    taskInfo.u.callbackLaunchTask.fnData = nullptr;
    taskInfo.type = TS_TASK_TYPE_HOSTFUNC_CALLBACK;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    ConstructSqeForCallbackLaunchTask(&taskInfo, &sqe);
    EXPECT_EQ(sqe.phSqe.header.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ProfilingTaskRegister)
{
    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].toCommandFunc[TS_TASK_TYPE_PROFILING_ENABLE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_PROFILING_ENABLE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].doCompleteSuccFunc[TS_TASK_TYPE_PROFILING_ENABLE], nullptr);
    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].taskUnInitFunc[TS_TASK_TYPE_PROFILING_ENABLE], nullptr);
    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].waitAsyncCpCompleteFunc[TS_TASK_TYPE_PROFILING_ENABLE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].printErrorInfoFunc[TS_TASK_TYPE_PROFILING_ENABLE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].setResultFunc[TS_TASK_TYPE_PROFILING_ENABLE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].setStarsResultFunc[TS_TASK_TYPE_PROFILING_ENABLE], nullptr);

    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].toCommandFunc[TS_TASK_TYPE_PROFILING_DISABLE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_PROFILING_DISABLE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].doCompleteSuccFunc[TS_TASK_TYPE_PROFILING_DISABLE], nullptr);
    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].taskUnInitFunc[TS_TASK_TYPE_PROFILING_DISABLE], nullptr);
    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].waitAsyncCpCompleteFunc[TS_TASK_TYPE_PROFILING_DISABLE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].printErrorInfoFunc[TS_TASK_TYPE_PROFILING_DISABLE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].setResultFunc[TS_TASK_TYPE_PROFILING_DISABLE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].setStarsResultFunc[TS_TASK_TYPE_PROFILING_DISABLE], nullptr);
}

TEST_F(Arch5162TaskTest, ConstructSqeForProfilingEnableTask)
{
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    ASSERT_NE(stream, nullptr);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.id = 100U;
    taskInfo.type = TS_TASK_TYPE_PROFILING_ENABLE;
    taskInfo.u.profilingEnableTaskInfo.pid = 1234U;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    ConstructSqeForProfilingEnableTask(&taskInfo, &sqe);
    EXPECT_EQ(sqe.phSqe.header.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    EXPECT_EQ(sqe.phSqe.header.u.sqeSubType, RT_SQE_SUBTYPE_PROFILER_DYNAMIC_ENABLE);
    EXPECT_EQ(sqe.phSqe.header.ie, RT_STARS_SQE_INT_DIR_NO);
    EXPECT_EQ(sqe.phSqe.header.preP, RT_STARS_SQE_INT_DIR_TO_TSCPU);
    EXPECT_EQ(sqe.phSqe.header.postP, RT_STARS_SQE_INT_DIR_NO);
    EXPECT_EQ(sqe.phSqe.header.l1Lock, 0U);
    EXPECT_EQ(sqe.phSqe.header.l1UnLock, 0U);
    EXPECT_EQ(sqe.phSqe.header.taskId, 100U);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ConstructSqeForProfilingDisableTask)
{
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    ASSERT_NE(stream, nullptr);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.id = 100U;
    taskInfo.type = TS_TASK_TYPE_PROFILING_DISABLE;
    taskInfo.u.profilingDisableTaskInfo.pid = 4321U;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    ConstructSqeForProfilingDisableTask(&taskInfo, &sqe);
    EXPECT_EQ(sqe.phSqe.header.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    EXPECT_EQ(sqe.phSqe.header.u.sqeSubType, RT_SQE_SUBTYPE_PROFILER_DYNAMIC_DISABLE);
    EXPECT_EQ(sqe.phSqe.header.ie, RT_STARS_SQE_INT_DIR_NO);
    EXPECT_EQ(sqe.phSqe.header.preP, RT_STARS_SQE_INT_DIR_TO_TSCPU);
    EXPECT_EQ(sqe.phSqe.header.postP, RT_STARS_SQE_INT_DIR_NO);
    EXPECT_EQ(sqe.phSqe.header.l1Lock, 0U);
    EXPECT_EQ(sqe.phSqe.header.l1UnLock, 0U);
    EXPECT_EQ(sqe.phSqe.header.taskId, 100U);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, DumpAicpuArgsForDfx_ArgsNull)
{
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    ASSERT_NE(stream, nullptr);

    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICPU;
    taskInfo.errorCode = 0x2A;
    taskInfo.id = 42;
    taskInfo.u.aicpuTaskInfo.kernel = nullptr;
    taskInfo.u.aicpuTaskInfo.aicpuKernelType = TS_AICPU_KERNEL_AICPU;
    taskInfo.u.aicpuTaskInfo.kernelInnerHandle = nullptr;
    taskInfo.u.aicpuTaskInfo.comm.argsSize = 0;
    taskInfo.u.aicpuTaskInfo.comm.args = nullptr;
    taskInfo.u.aicpuTaskInfo.soName = nullptr;
    taskInfo.u.aicpuTaskInfo.funcName = nullptr;
    taskInfo.u.aicpuTaskInfo.headParamOffset = 0;
    taskInfo.u.aicpuTaskInfo.aicpuFlags = 0;
    taskInfo.u.aicpuTaskInfo.timeout = 0;

    PrintErrorInfoForDavinciTask(&taskInfo, 0);

    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ModelExecuteTaskInit_nullptr)
{
    rtError_t ret = ModelExecuteTaskInit(nullptr, nullptr, 0U, 0U);
    EXPECT_EQ(ret, RT_ERROR_MODEL_NULL);
}

TEST_F(Arch5162TaskTest, ModelExecuteTaskInit_normal)
{
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    Model* model = nullptr;
    rtError_t ret = ModelExecuteTaskInit(&taskInfo, model, 1U, 2U);
    EXPECT_EQ(ret, RT_ERROR_MODEL_NULL);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, DumpAicpuArgsForDfx_ArgsSizeZero)
{
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    ASSERT_NE(stream, nullptr);

    char dummyBuf[8] = {};
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICPU;
    taskInfo.errorCode = 0x2A;
    taskInfo.id = 42;
    taskInfo.u.aicpuTaskInfo.kernel = nullptr;
    taskInfo.u.aicpuTaskInfo.aicpuKernelType = TS_AICPU_KERNEL_AICPU;
    taskInfo.u.aicpuTaskInfo.kernelInnerHandle = nullptr;
    taskInfo.u.aicpuTaskInfo.comm.argsSize = 0;
    taskInfo.u.aicpuTaskInfo.comm.args = static_cast<void*>(dummyBuf);
    taskInfo.u.aicpuTaskInfo.soName = nullptr;
    taskInfo.u.aicpuTaskInfo.funcName = nullptr;
    taskInfo.u.aicpuTaskInfo.headParamOffset = 0;
    taskInfo.u.aicpuTaskInfo.aicpuFlags = 0;
    taskInfo.u.aicpuTaskInfo.timeout = 0;

    // argsSize==0 triggers early return in DumpAicpuArgsForDfx before MemCopySync
    PrintErrorInfoForDavinciTask(&taskInfo, 0);

    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ModelExecuteTaskUnInit)
{
    TaskInfo taskInfo = {};
    ModelExecuteTaskUnInit(&taskInfo);
}

TEST_F(Arch5162TaskTest, ConstructSqeForModelExecuteTask)
{
    MOCKER(PrintSqe).stubs();
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.id = 1U;
    taskInfo.u.modelExecuteTaskInfo.modelId = 10U;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    PfnTaskToSqe toSqeFunc = g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_MODEL_EXECUTE];
    toSqeFunc(&taskInfo, &sqe);
    EXPECT_EQ(sqe.phSqe.header.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    EXPECT_EQ(sqe.phSqe.header.u.sqeSubType, RT_SQE_SUBTYPE_CONDS_MODEL_EXEC);
    EXPECT_EQ(sqe.phSqe.u.modelExecuteInfo.modelId, 10U);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, DumpAicpuArgsForDfx_MemCopyFail)
{
    NpuDriver drv;
    RawDevice* device = new RawDevice(0);
    device->driver_ = &drv;
    Stream* stream = new Stream(device, 0);
    ASSERT_NE(stream, nullptr);

    g_memCopySyncFail = true;
    TaskInfo taskInfo = {};
    InitAicpuTaskInfoForDump(taskInfo, stream, 64U, reinterpret_cast<void*>(DUMP_ARGS_BASE), nullptr, nullptr);

    MOCKER_CPP_VIRTUAL(device->driver_, &Driver::MemCopySync).stubs().will(invoke(DumpAicpuArgsMemCopyStub));
    PrintErrorInfoForDavinciTask(&taskInfo, 0);

    g_memCopySyncFail = false;
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, SetResultForModelExecuteTask)
{
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    uint32_t data[3] = {0x00400001, 0x00000002, 0x00000003};
    PfnTaskSetResult setResultFunc = g_taskFuncArrays[CHIP_5162A].setResultFunc[TS_TASK_TYPE_MODEL_EXECUTE];
    setResultFunc(&taskInfo, data, sizeof(data));
    EXPECT_EQ(taskInfo.errorCode, 1U);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, DumpAicpuArgsForDfx_SoNameInRange)
{
    NpuDriver drv;
    RawDevice* device = new RawDevice(0);
    device->driver_ = &drv;
    Stream* stream = new Stream(device, 0);
    ASSERT_NE(stream, nullptr);

    const char* soNameStr = "test_so.so";
    memset(g_dumpArgsBuf, 0, sizeof(g_dumpArgsBuf));
    memcpy_s(g_dumpArgsBuf + 64U, sizeof(g_dumpArgsBuf) - 64U, soNameStr, strlen(soNameStr) + 1U);
    g_memCopySyncFail = false;

    TaskInfo taskInfo = {};
    InitAicpuTaskInfoForDump(
        taskInfo, stream, DUMP_ARGS_SIZE, reinterpret_cast<void*>(DUMP_ARGS_BASE),
        reinterpret_cast<void*>(DUMP_ARGS_BASE + 64U), nullptr);

    MOCKER_CPP_VIRTUAL(device->driver_, &Driver::MemCopySync).stubs().will(invoke(DumpAicpuArgsMemCopyStub));
    PrintErrorInfoForDavinciTask(&taskInfo, 0);

    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, DumpAicpuArgsForDfx_KernelNameInRange)
{
    NpuDriver drv;
    RawDevice* device = new RawDevice(0);
    device->driver_ = &drv;
    Stream* stream = new Stream(device, 0);
    ASSERT_NE(stream, nullptr);

    const char* kernelNameStr = "TestKernel";
    memset(g_dumpArgsBuf, 0, sizeof(g_dumpArgsBuf));
    memcpy_s(g_dumpArgsBuf + 128U, sizeof(g_dumpArgsBuf) - 128U, kernelNameStr, strlen(kernelNameStr) + 1U);
    g_memCopySyncFail = false;

    TaskInfo taskInfo = {};
    InitAicpuTaskInfoForDump(
        taskInfo, stream, DUMP_ARGS_SIZE, reinterpret_cast<void*>(DUMP_ARGS_BASE), nullptr,
        reinterpret_cast<void*>(DUMP_ARGS_BASE + 128U));

    MOCKER_CPP_VIRTUAL(device->driver_, &Driver::MemCopySync).stubs().will(invoke(DumpAicpuArgsMemCopyStub));
    PrintErrorInfoForDavinciTask(&taskInfo, 0);

    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ModelExecuteTaskRegister)
{
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_MODEL_EXECUTE], nullptr);
    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].toCommandFunc[TS_TASK_TYPE_MODEL_EXECUTE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].doCompleteSuccFunc[TS_TASK_TYPE_MODEL_EXECUTE], nullptr);
    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].taskUnInitFunc[TS_TASK_TYPE_MODEL_EXECUTE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].printErrorInfoFunc[TS_TASK_TYPE_MODEL_EXECUTE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].setResultFunc[TS_TASK_TYPE_MODEL_EXECUTE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].setStarsResultFunc[TS_TASK_TYPE_MODEL_EXECUTE], nullptr);
}

TEST_F(Arch5162TaskTest, ConstructSqeForModelMaintainceTask_Bind)
{
    MOCKER(PrintSqe).stubs();
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    Stream* opStream = new Stream(device, 1);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.id = 1U;
    Model model;
    taskInfo.u.modelMaintainceTaskInfo.type = MMT_STREAM_ADD;
    taskInfo.u.modelMaintainceTaskInfo.model = &model;
    taskInfo.u.modelMaintainceTaskInfo.opStream = opStream;
    taskInfo.u.modelMaintainceTaskInfo.streamType = RT_MODEL_HEAD_STREAM;
    taskInfo.u.modelMaintainceTaskInfo.firstTaskId = 0U;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    PfnTaskToSqe toSqeFunc = g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_MODEL_MAINTAINCE];
    toSqeFunc(&taskInfo, &sqe);
    EXPECT_EQ(sqe.phSqe.header.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    EXPECT_EQ(sqe.phSqe.header.u.sqeSubType, RT_SQE_SUBTYPE_MODEL_MAINTAINCE);
    EXPECT_EQ(sqe.phSqe.u.modelMaintainceInfo.operation, MMT_STREAM_ADD);
    delete opStream;
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ModelMaintainceTaskRegister)
{
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_MODEL_MAINTAINCE], nullptr);
    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].toCommandFunc[TS_TASK_TYPE_MODEL_MAINTAINCE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].doCompleteSuccFunc[TS_TASK_TYPE_MODEL_MAINTAINCE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].printErrorInfoFunc[TS_TASK_TYPE_MODEL_MAINTAINCE], nullptr);
}

TEST_F(Arch5162TaskTest, PrepareSqeInfoForModelExecuteTask)
{
    rtError_t ret = PrepareSqeInfoForModelExecuteTask(nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(Arch5162TaskTest, PrintErrorModelExecuteTaskFuncCall) { PrintErrorModelExecuteTaskFuncCall(nullptr); }

TEST_F(Arch5162TaskTest, ConstructSqeForModelExecuteTask_AllFields)
{
    MOCKER(PrintSqe).stubs();
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.id = 42U;
    taskInfo.u.modelExecuteTaskInfo.modelId = 10U;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    PfnTaskToSqe toSqeFunc = g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_MODEL_EXECUTE];
    toSqeFunc(&taskInfo, &sqe);
    EXPECT_EQ(sqe.phSqe.header.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    EXPECT_EQ(sqe.phSqe.header.wrCqe, stream->GetStarsWrCqeFlag());
    EXPECT_EQ(sqe.phSqe.header.l1Lock, 0U);
    EXPECT_EQ(sqe.phSqe.header.l1UnLock, 0U);
    EXPECT_EQ(sqe.phSqe.header.ie, RT_STARS_SQE_INT_DIR_NO);
    EXPECT_EQ(sqe.phSqe.header.preP, RT_STARS_SQE_INT_DIR_TO_TSCPU);
    EXPECT_EQ(sqe.phSqe.header.postP, RT_STARS_SQE_INT_DIR_NO);
    EXPECT_EQ(sqe.phSqe.header.u.sqeSubType, RT_SQE_SUBTYPE_CONDS_MODEL_EXEC);
    EXPECT_EQ(sqe.phSqe.header.rtStreamId, static_cast<uint16_t>(stream->Id_()));
    EXPECT_EQ(sqe.phSqe.header.taskId, 42U);
    EXPECT_EQ(sqe.phSqe.u.modelExecuteInfo.modelId, 10U);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, SetResultForModelExecuteTask_AllFields)
{
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    uint32_t data[3] = {0xFFFFFABC, 0x0000001F, 0x00000003};
    PfnTaskSetResult setResultFunc = g_taskFuncArrays[CHIP_5162A].setResultFunc[TS_TASK_TYPE_MODEL_EXECUTE];
    setResultFunc(&taskInfo, data, sizeof(data));
    EXPECT_EQ(taskInfo.errorCode, 0xABCU);
    EXPECT_EQ(taskInfo.u.modelExecuteTaskInfo.errorTaskId, 0x7FFFU);
    EXPECT_EQ(taskInfo.u.modelExecuteTaskInfo.errorStreamId, 0xFFFU);
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ConstructSqeForModelMaintainceTask_Unbind)
{
    MOCKER(PrintSqe).stubs();
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    Stream* opStream = new Stream(device, 1);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.id = 2U;
    Model model;
    taskInfo.u.modelMaintainceTaskInfo.type = MMT_STREAM_DEL;
    taskInfo.u.modelMaintainceTaskInfo.model = &model;
    taskInfo.u.modelMaintainceTaskInfo.opStream = opStream;
    taskInfo.u.modelMaintainceTaskInfo.streamType = RT_MODEL_HEAD_STREAM;
    taskInfo.u.modelMaintainceTaskInfo.firstTaskId = 0U;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    PfnTaskToSqe toSqeFunc = g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_MODEL_MAINTAINCE];
    toSqeFunc(&taskInfo, &sqe);
    EXPECT_EQ(sqe.phSqe.header.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    EXPECT_EQ(sqe.phSqe.header.u.sqeSubType, RT_SQE_SUBTYPE_MODEL_MAINTAINCE);
    EXPECT_EQ(sqe.phSqe.header.preP, RT_STARS_SQE_INT_DIR_TO_TSCPU);
    EXPECT_EQ(sqe.phSqe.u.modelMaintainceInfo.operation, MMT_STREAM_DEL);
    delete opStream;
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ConstructSqeForModelMaintainceTask_LoadComplete)
{
    MOCKER(PrintSqe).stubs();
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    Stream* opStream = new Stream(device, 1);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.id = 3U;
    Model model;
    taskInfo.u.modelMaintainceTaskInfo.type = MMT_MODEL_LOAD_COMPLETE;
    taskInfo.u.modelMaintainceTaskInfo.model = &model;
    taskInfo.u.modelMaintainceTaskInfo.opStream = opStream;
    taskInfo.u.modelMaintainceTaskInfo.streamType = RT_MODEL_HEAD_STREAM;
    taskInfo.u.modelMaintainceTaskInfo.firstTaskId = 0U;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    PfnTaskToSqe toSqeFunc = g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_MODEL_MAINTAINCE];
    toSqeFunc(&taskInfo, &sqe);
    EXPECT_EQ(sqe.phSqe.header.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    EXPECT_EQ(sqe.phSqe.header.u.sqeSubType, RT_SQE_SUBTYPE_MODEL_MAINTAINCE);
    EXPECT_EQ(sqe.phSqe.u.modelMaintainceInfo.operation, MMT_MODEL_LOAD_COMPLETE);
    EXPECT_EQ(sqe.phSqe.header.preP, RT_STARS_SQE_INT_DIR_NO);
    delete opStream;
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ConstructSqeForModelMaintainceTask_PreProc_Aicpu)
{
    MOCKER(PrintSqe).stubs();
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    Stream* opStream = new Stream(device, 1);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.id = 4U;
    Model model;
    model.SetModelExecutorType(EXECUTOR_AICPU);
    taskInfo.u.modelMaintainceTaskInfo.type = MMT_MODEL_PRE_PROC;
    taskInfo.u.modelMaintainceTaskInfo.model = &model;
    taskInfo.u.modelMaintainceTaskInfo.opStream = opStream;
    taskInfo.u.modelMaintainceTaskInfo.streamType = RT_MODEL_HEAD_STREAM;
    taskInfo.u.modelMaintainceTaskInfo.firstTaskId = 0U;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    PfnTaskToSqe toSqeFunc = g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_MODEL_MAINTAINCE];
    toSqeFunc(&taskInfo, &sqe);
    EXPECT_EQ(sqe.phSqe.header.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    EXPECT_EQ(sqe.phSqe.header.u.sqeSubType, RT_SQE_SUBTYPE_MODEL_MAINTAINCE);
    EXPECT_EQ(sqe.phSqe.u.modelMaintainceInfo.operation, MMT_MODEL_PRE_PROC);
    EXPECT_EQ(sqe.phSqe.header.preP, RT_STARS_SQE_INT_DIR_TO_TSCPU);
    EXPECT_EQ(sqe.phSqe.u.modelMaintainceInfo.executorFlag, MODEL_EXECUTOR_AICPU);
    EXPECT_EQ(sqe.phSqe.u.modelMaintainceInfo.endgraphNotifyId, 0U);
    delete opStream;
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ConstructSqeForModelMaintainceTask_PreProc_NonAicpu)
{
    MOCKER(PrintSqe).stubs();
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    Stream* opStream = new Stream(device, 1);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.id = 5U;
    Model model;
    Notify notify(0U, 0U);
    notify.notifyid_ = 100U;
    model.SetEndGraphNotify(&notify);
    taskInfo.u.modelMaintainceTaskInfo.type = MMT_MODEL_PRE_PROC;
    taskInfo.u.modelMaintainceTaskInfo.model = &model;
    taskInfo.u.modelMaintainceTaskInfo.opStream = opStream;
    taskInfo.u.modelMaintainceTaskInfo.streamType = RT_MODEL_HEAD_STREAM;
    taskInfo.u.modelMaintainceTaskInfo.firstTaskId = 0U;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    PfnTaskToSqe toSqeFunc = g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_MODEL_MAINTAINCE];
    toSqeFunc(&taskInfo, &sqe);
    EXPECT_EQ(sqe.phSqe.header.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    EXPECT_EQ(sqe.phSqe.header.u.sqeSubType, RT_SQE_SUBTYPE_MODEL_MAINTAINCE);
    EXPECT_EQ(sqe.phSqe.u.modelMaintainceInfo.operation, MMT_MODEL_PRE_PROC);
    EXPECT_EQ(sqe.phSqe.header.preP, RT_STARS_SQE_INT_DIR_TO_TSCPU);
    EXPECT_EQ(sqe.phSqe.u.modelMaintainceInfo.executorFlag, MODEL_EXECUTOR_RESERVED);
    EXPECT_EQ(sqe.phSqe.u.modelMaintainceInfo.endgraphNotifyId, 100U);
    delete opStream;
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ConstructSqeForModelMaintainceTask_Abort)
{
    MOCKER(PrintSqe).stubs();
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    Stream* opStream = new Stream(device, 1);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.id = 6U;
    Model model;
    taskInfo.u.modelMaintainceTaskInfo.type = MMT_MODEL_ABORT;
    taskInfo.u.modelMaintainceTaskInfo.model = &model;
    taskInfo.u.modelMaintainceTaskInfo.opStream = opStream;
    taskInfo.u.modelMaintainceTaskInfo.streamType = RT_MODEL_HEAD_STREAM;
    taskInfo.u.modelMaintainceTaskInfo.firstTaskId = 0U;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    PfnTaskToSqe toSqeFunc = g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_MODEL_MAINTAINCE];
    toSqeFunc(&taskInfo, &sqe);
    EXPECT_EQ(sqe.phSqe.header.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    EXPECT_EQ(sqe.phSqe.header.u.sqeSubType, RT_SQE_SUBTYPE_MODEL_MAINTAINCE);
    EXPECT_EQ(sqe.phSqe.u.modelMaintainceInfo.operation, MMT_MODEL_ABORT);
    EXPECT_EQ(sqe.phSqe.header.preP, RT_STARS_SQE_INT_DIR_TO_TSCPU);
    delete opStream;
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ConstructSqeForModelMaintainceTask_DefaultCase)
{
    MOCKER(PrintSqe).stubs();
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    Stream* opStream = new Stream(device, 1);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.id = 7U;
    Model model;
    taskInfo.u.modelMaintainceTaskInfo.type = MMT_MODEL_DESTROY;
    taskInfo.u.modelMaintainceTaskInfo.model = &model;
    taskInfo.u.modelMaintainceTaskInfo.opStream = opStream;
    taskInfo.u.modelMaintainceTaskInfo.streamType = RT_MODEL_HEAD_STREAM;
    taskInfo.u.modelMaintainceTaskInfo.firstTaskId = 0U;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    PfnTaskToSqe toSqeFunc = g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_MODEL_MAINTAINCE];
    toSqeFunc(&taskInfo, &sqe);
    EXPECT_EQ(sqe.phSqe.header.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    EXPECT_EQ(sqe.phSqe.header.u.sqeSubType, RT_SQE_SUBTYPE_MODEL_MAINTAINCE);
    EXPECT_EQ(sqe.phSqe.u.modelMaintainceInfo.operation, MMT_MODEL_DESTROY);
    EXPECT_EQ(sqe.phSqe.header.preP, RT_STARS_SQE_INT_DIR_NO);
    delete opStream;
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ConstructSqeForModelMaintainceTask_Bind_AllFields)
{
    MOCKER(PrintSqe).stubs();
    RawDevice* device = new RawDevice(0);
    Stream* stream = new Stream(device, 0);
    Stream* opStream = new Stream(device, 1);
    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.id = 8U;
    Model model;
    taskInfo.u.modelMaintainceTaskInfo.type = MMT_STREAM_ADD;
    taskInfo.u.modelMaintainceTaskInfo.model = &model;
    taskInfo.u.modelMaintainceTaskInfo.opStream = opStream;
    taskInfo.u.modelMaintainceTaskInfo.streamType = RT_MODEL_HEAD_STREAM;
    taskInfo.u.modelMaintainceTaskInfo.firstTaskId = 5U;
    taskInfo.u.modelMaintainceTaskInfo.execTimesSvmOffset = 0x1000ULL;
    rtStarsSqe_t sqe = {};
    memset_s(&sqe, sizeof(sqe), 0, sizeof(sqe));
    PfnTaskToSqe toSqeFunc = g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_MODEL_MAINTAINCE];
    toSqeFunc(&taskInfo, &sqe);
    EXPECT_EQ(sqe.phSqe.header.type, RT_STARS_SQE_TYPE_PLACE_HOLDER);
    EXPECT_EQ(sqe.phSqe.header.wrCqe, stream->GetStarsWrCqeFlag());
    EXPECT_EQ(sqe.phSqe.header.u.sqeSubType, RT_SQE_SUBTYPE_MODEL_MAINTAINCE);
    EXPECT_EQ(sqe.phSqe.header.rtStreamId, static_cast<uint16_t>(stream->Id_()));
    EXPECT_EQ(sqe.phSqe.header.taskId, 8U);
    EXPECT_EQ(sqe.phSqe.header.preP, RT_STARS_SQE_INT_DIR_TO_TSCPU);
    EXPECT_EQ(sqe.phSqe.u.modelMaintainceInfo.modelId, static_cast<uint16_t>(model.Id_()));
    EXPECT_EQ(sqe.phSqe.u.modelMaintainceInfo.streamId, static_cast<uint16_t>(opStream->Id_()));
    EXPECT_EQ(sqe.phSqe.u.modelMaintainceInfo.operation, MMT_STREAM_ADD);
    EXPECT_EQ(sqe.phSqe.u.modelMaintainceInfo.streamType, static_cast<uint16_t>(RT_MODEL_HEAD_STREAM));
    EXPECT_EQ(sqe.phSqe.u.modelMaintainceInfo.firstTaskId, 5U);
    EXPECT_EQ(sqe.phSqe.u.modelMaintainceInfo.streamExecTimesAddr, 0x1000ULL);
    delete opStream;
    delete stream;
    delete device;
}

TEST_F(Arch5162TaskTest, ModelMaintainceTaskRegister_AllFields)
{
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].toSqeFunc[TS_TASK_TYPE_MODEL_MAINTAINCE], nullptr);
    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].toCommandFunc[TS_TASK_TYPE_MODEL_MAINTAINCE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].doCompleteSuccFunc[TS_TASK_TYPE_MODEL_MAINTAINCE], nullptr);
    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].taskUnInitFunc[TS_TASK_TYPE_MODEL_MAINTAINCE], nullptr);
    EXPECT_EQ(g_taskFuncArrays[CHIP_5162A].waitAsyncCpCompleteFunc[TS_TASK_TYPE_MODEL_MAINTAINCE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].printErrorInfoFunc[TS_TASK_TYPE_MODEL_MAINTAINCE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].setResultFunc[TS_TASK_TYPE_MODEL_MAINTAINCE], nullptr);
    EXPECT_NE(g_taskFuncArrays[CHIP_5162A].setStarsResultFunc[TS_TASK_TYPE_MODEL_MAINTAINCE], nullptr);
}

TEST_F(Arch5162TaskTest, ReduceAsyncV2TaskInit_NotSupport)
{
    rtError_t ret = ReduceAsyncV2TaskInit(nullptr, 0U, nullptr, nullptr, 0ULL, nullptr);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(Arch5162TaskTest, KernelFusionTaskInit_NotSupport)
{
    rtError_t ret = KernelFusionTaskInit(nullptr, FUSION_START);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(Arch5162TaskTest, ModelToAicpuTaskInit_NotSupport)
{
    rtError_t ret = ModelToAicpuTaskInit(nullptr, 0U, 0U, 0U, 0ULL);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(Arch5162TaskTest, ModelTaskUpdateInit_NotSupport)
{
    rtMdlTaskUpdateInfo_t para = {};
    rtError_t ret = ModelTaskUpdateInit(nullptr, 0U, 0U, 0U, nullptr, 0U, &para);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);
}
