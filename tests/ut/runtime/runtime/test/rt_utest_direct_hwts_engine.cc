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
#include "base.hpp"
#include "securec.h"
#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include "npu_driver.hpp"
#define private public
#define protected public
#include "engine.hpp"
#include "direct_hwts_engine.hpp"
#include "stars_engine.hpp"
#include "runtime.hpp"
#include "event.hpp"
#include "logger.hpp"
#include "raw_device.hpp"
#undef protected
#undef private
#include "scheduler.hpp"
#include "hwts.hpp"
#include "stream.hpp"
#include "npu_driver.hpp"
#include "context.hpp"
#include "device/device_error_proc.hpp"
#include <map>
#include <utility>  // For std::pair and std::make_pair.
#include "mmpa_api.h"
#include "thread_local_container.hpp"

using namespace testing;
using namespace cce::runtime;

using std::pair;
using std::make_pair;

class DirectHwtsEngineTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"DirectHwtsEngine test start"<<std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout<<"DirectHwtsEngine test end"<<std::endl;
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
    }
};

rtError_t QueryShmInfoStub(DirectHwtsEngine *engine, const uint32_t streamId,
                           const bool limited, uint32_t &taskId)
{
    (void)streamId;
    (void)limited;
    taskId = 1U;
    return RT_ERROR_NONE;
}

TEST_F(DirectHwtsEngineTest, ProcLogicReport_test)
{
    RawDevice *device = new RawDevice(0);
    device->driver_ = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    DirectHwtsEngine engine(device);

    rtLogicReport_t logic;
    logic.logicCqType = LOGIC_RPT_TSCH_VERSION;
    bool ret = engine.ProcLogicReport(logic, 0, false);
    EXPECT_EQ(ret, false);

    TaskInfo *nullTask = nullptr;
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .will(returnValue(nullTask));

    MOCKER_CPP_VIRTUAL(device->driver_, &Driver::EventIdFree)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    logic.logicCqType = LOGIC_RPT_EVENT_DESTROY;
    ret = engine.ProcLogicReport(logic, 0, false);
    EXPECT_EQ(ret, false);

    logic.logicCqType = LOGIC_RPT_AICPU_ERR_MSG_REPORT;
    ret = engine.ProcLogicReport(logic, 0, false);
    EXPECT_EQ(ret, false);

    MOCKER_CPP(&DirectHwtsEngine::ProcessReport)
        .stubs()
        .will(returnValue(true));
    logic.logicCqType = LOGIC_RPT_TASK_ERROR;
    ret = engine.ProcLogicReport(logic, 0, true);
    EXPECT_EQ(ret, true);

    logic.logicCqType = LOGIC_RPT_MODEL_ERROR;
    ret = engine.ProcLogicReport(logic, 0, true);
    EXPECT_EQ(ret, true);

    logic.logicCqType = LOGIC_RPT_OVERFLOW_ERROR;
    ret = engine.ProcLogicReport(logic, 0, true);
    EXPECT_EQ(ret, false);

    delete device;
    GlobalMockObject::reset();
}

TEST_F(DirectHwtsEngineTest, CreateRecycleThread_failed)
{
    RawDevice *device = new RawDevice(0);
    DirectHwtsEngine engine(device);
    MOCKER(mmCreateTaskWithThreadAttr).stubs().will(returnValue(-1));
    rtError_t error = engine.CreateRecycleThread();
    EXPECT_EQ(error, RT_ERROR_MEMORY_ALLOCATION);
    delete device;
    GlobalMockObject::reset();
}

TEST_F(DirectHwtsEngineTest, CheckMonitorThreadAlive_false)
{
    RawDevice *device = new RawDevice(0);
    DirectHwtsEngine engine(device);
    bool ret = engine.CheckMonitorThreadAlive();
    EXPECT_EQ(ret, false);
    delete device;
    GlobalMockObject::reset();
}

TEST_F(DirectHwtsEngineTest, TaskReclaimEx_handleShmTask)
{
    RawDevice *device = new RawDevice(0);
    DirectHwtsEngine engine(device);
    uint32_t taskId = 0U;
    rtShmQuery_t shareMemInfo;
    shareMemInfo.valid = SQ_SHARE_MEMORY_VALID;
    shareMemInfo.taskId = 1U;
    MOCKER_CPP(&DirectHwtsEngine::HandleShmTask)
        .stubs()
        .will(returnValue(false));
    engine.TaskReclaimEx(0U, false, taskId, shareMemInfo);
    EXPECT_EQ(taskId, shareMemInfo.taskId);
    delete device;
    GlobalMockObject::reset();
}

TEST_F(DirectHwtsEngineTest, UpdateTaskIdForTaskStatus_false)
{
    RawDevice *device = new RawDevice(0);
    DirectHwtsEngine engine(device);
 
    bool ret = engine.UpdateTaskIdForTaskStatus(0U, 0U);
    EXPECT_EQ(ret, false);
 
    device->Init();
    TaskInfo task = {};
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .will(returnValue(&task));
    rtShmQuery_t *nullShmInfo = nullptr;
    MOCKER_CPP(&DirectHwtsEngine::TaskStatusAlloc)
        .stubs()
        .will(returnValue(nullShmInfo));
    ret = engine.UpdateTaskIdForTaskStatus(0U, 0U);
    EXPECT_EQ(ret, false);
    delete device;
    GlobalMockObject::reset();
}

TEST_F(DirectHwtsEngineTest, SyncTaskQueryShm_queryshmfailed)
{
    RawDevice *device = new RawDevice(0);
    DirectHwtsEngine engine(device);
    MOCKER_CPP(&DirectHwtsEngine::QueryShmInfo)
        .stubs()
        .will(returnValue(RT_ERROR_COMMON_BASE));

    engine.SyncTaskQueryShm(0U, 0U, 0U);
    ShmCq *shm = new ShmCq();
    shm->dev_ = device;
    rtError_t error = shm->Init(device);
    EXPECT_EQ(error, RT_ERROR_NONE);
    shm->vSqReadonly_ = true;
    error = shm->InitCqShm(0U);
    EXPECT_EQ(error, RT_ERROR_NONE);
    uint32_t ret = shm->GetTaskIdFromStreamShmTaskId(RT_MAX_STREAM_ID);
    EXPECT_EQ(ret, MAX_UINT32_NUM);
    delete shm;
    delete device;
    GlobalMockObject::reset();
}

TEST_F(DirectHwtsEngineTest, QueryShmInfo_queryfailed)
{
    RawDevice *device = new RawDevice(0);
    DirectHwtsEngine engine(device);
    MOCKER_CPP(&ShmCq::QueryCqShm)
        .stubs()
        .will(returnValue(RT_ERROR_COMMON_BASE));

    uint32_t taskId = 0U;
    rtError_t error = engine.QueryShmInfo(0U, 0U, taskId);
    EXPECT_EQ(error, RT_ERROR_COMMON_BASE);
    delete device;
    GlobalMockObject::reset();
}

void TaskFailCallBackStubFunc(const uint32_t streamId, const uint32_t taskId,
                      const uint32_t threadId, const uint32_t retCode,
                      const Device * const dev)
{
    // stub
}

TEST_F(DirectHwtsEngineTest, ProcessOverFlowReport_TS_TASK_TYPE_KERNEL_AIVEC)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    std::unique_ptr<DirectHwtsEngine> engine = std::make_unique<DirectHwtsEngine>(device);
    engine->ProcessOverFlowReport(nullptr, RT_ERROR_INVALID_VALUE);

    rtTaskReport_t report;
    report.streamID = 0;
    report.streamIDEx = 0;
    report.streamID = 0;

    Stream *stream = new Stream(device, 0);
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AIVEC;
    task.stream = stream;

    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .with(mockcpp::any(), mockcpp::any())
        .will(returnValue(&task));
    MOCKER(TaskFailCallBack).stubs().will(invoke(TaskFailCallBackStubFunc));
    uint32_t tsRetCode = RT_ERROR_INVALID_VALUE;
    engine->ProcessOverFlowReport(&report, RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(task.errorCode, tsRetCode);
    delete stream;
    delete device;
    GlobalMockObject::reset();
}

void ExeciptionCallbackStub(rtExceptionType type)
{
    printf("this is app exception callback, ExceptionType=%d\n", type);
}

TEST_F(DirectHwtsEngineTest, ReportExceptProc_TS_TASK_TYPE_MODEL_EXECUTE)
{
    const bool olgFlag = Runtime::Instance()->GetDisableThread();
    bool isSetVisibleDev = Runtime::Instance()->isSetVisibleDev;
    RawDevice *device = new RawDevice(0);
    device->Init();
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_MODEL_EXECUTE;
    Stream *stream = new Stream(device, 0);
    task.stream = stream;
    uint32_t payload = TS_ERROR_TASK_TYPE_NOT_SUPPORT;
    std::unique_ptr<HwtsEngine> engine = std::make_unique<DirectHwtsEngine>(device);
    ((Runtime *)Runtime::Instance())->excptCallBack_ = ExeciptionCallbackStub;
    Runtime::Instance()->SetDisableThread(true);
    TaskInfo taskInfo = {0};
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .will(returnValue(&taskInfo));
    Runtime::Instance()->isSetVisibleDev = true;
    engine->ReportExceptProc(&task, payload);
    EXPECT_EQ(task.stream->GetErrCode(), payload);
    Runtime::Instance()->isSetVisibleDev = isSetVisibleDev;
    Runtime::Instance()->SetDisableThread(olgFlag);
    delete stream;
    delete device;
    GlobalMockObject::reset();
}

drvError_t drvDeviceStatusStub(uint32_t devId, drvStatus_t *status)
{
    (void)devId;
    *status = DRV_STATUS_COMMUNICATION_LOST;
    return DRV_ERROR_NONE;
}

TEST_F(DirectHwtsEngineTest, ReportHeartBreakProcV2_RT_ERROR_LOST_HEARTBEAT)
{
    RawDevice *device = new RawDevice(0);
    DirectHwtsEngine engine(device);
    MOCKER(drvDeviceStatus).stubs().will(invoke(drvDeviceStatusStub));
    rtError_t error = engine.ReportHeartBreakProcV2();
    EXPECT_EQ(error, RT_ERROR_LOST_HEARTBEAT);
    delete device;
    GlobalMockObject::reset();
}

TEST_F(DirectHwtsEngineTest, RecycleThreadDo)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    DirectHwtsEngine engine(device);
    device->SetIsChipSupportRecycleThread(true);

    Stream *recycleStream = new Stream(device, 0);
    Stream *nullptrStream = nullptr;
    MOCKER_CPP_VIRTUAL(device, &RawDevice::GetNextRecycleStream)
        .stubs()
        .will(returnValue(recycleStream))
        .then(returnValue(nullptrStream));
    MOCKER_CPP(&Engine::ProcessTaskDavinciList)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(true));      
    engine.RecycleThreadDo();
    GlobalMockObject::reset();
    MOCKER_CPP_VIRTUAL(device, &RawDevice::GetNextRecycleStream)
        .stubs()
        .will(returnValue(recycleStream))
        .then(returnValue(nullptrStream));
    MOCKER_CPP_VIRTUAL(recycleStream, &Stream::ProcArgRecycleList)
        .stubs();
    recycleStream->isHasPcieBar_ = true;
    engine.RecycleThreadDo();
    EXPECT_EQ(recycleStream->isRecycleThreadProc_, false);
    delete recycleStream;
    delete device;
    GlobalMockObject::reset();
}

TEST_F(DirectHwtsEngineTest, SubmitSend_observer)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    std::unique_ptr<Engine> engine = std::make_unique<DirectHwtsEngine>(device);
    Stream *stream = new Stream(device, 0);
    stream->isCtrlStream_ = true;

    TaskInfo task = {};
    task.type = TS_TASK_TYPE_RESERVED;
    task.stream = stream;

    uint16_t retTaskId = 255;
    MOCKER_CPP_VIRTUAL(engine.get(), &Engine::SendTask)
        .stubs()
        .with(mockcpp::any(), outBound(retTaskId), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_COMMON_BASE));
    MOCKER_CPP(&Engine::SendFlipTask)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    TaskInfo halfRecordtask = {};
    EventRecordTaskInfo eventRecordTaskInfo = {};
    eventRecordTaskInfo.event = new Event(device, RT_EVENT_DEFAULT, nullptr, true);
    halfRecordtask.u.eventRecordTaskInfo = eventRecordTaskInfo;
    MOCKER_CPP(&Stream::ProcRecordTask)
        .stubs()
        .with(outBound(&halfRecordtask))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&TaskFactory::Recycle)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::SetStreamMark).stubs();
    MOCKER_CPP(&Event::DeleteRecordResetFromMap).stubs();
    MOCKER_CPP(&Event::EventIdCountSub).stubs();

    uint32_t flipTaskId = UINT32_MAX;
    EngineObserver observer;
    engine->AddObserver(&observer);
    rtError_t ret = engine->SubmitSend(&task, &flipTaskId);
    EXPECT_EQ(ret, RT_ERROR_COMMON_BASE);
    delete eventRecordTaskInfo.event;
    delete stream;
    delete device;
    GlobalMockObject::reset();
}

rtError_t StartMock(DirectHwtsEngine * engine) {
    engine->monitorThreadRunFlag_ = true;
    return 0;
}

TEST_F(DirectHwtsEngineTest, ReportExceptProc_TS_TASK_TYPE_KERNEL_AICORE_001)
{
    const bool olgFlag = Runtime::Instance()->GetDisableThread();
    bool isSetVisibleDev = Runtime::Instance()->isSetVisibleDev;
    RawDevice *device = new RawDevice(0);
    device->Init();
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    Stream *stream = new Stream(device, 0);
    task.stream = stream;
    uint32_t payload = TS_ERROR_TASK_TYPE_NOT_SUPPORT;
    std::unique_ptr<HwtsEngine> engine = std::make_unique<DirectHwtsEngine>(device);
    ((Runtime *)Runtime::Instance())->excptCallBack_ = ExeciptionCallbackStub;
    Runtime::Instance()->SetDisableThread(true);
    TaskInfo taskInfo = {0};
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .will(returnValue(&taskInfo));
    Runtime::Instance()->isSetVisibleDev = true;
    engine->ReportExceptProc(&task, payload);
    EXPECT_EQ(task.stream->GetErrCode(), payload);
    Runtime::Instance()->isSetVisibleDev = isSetVisibleDev;
    Runtime::Instance()->SetDisableThread(olgFlag);
    delete stream;
    delete device;
    GlobalMockObject::reset();
}

TEST_F(DirectHwtsEngineTest, ReportExceptProc_TS_TASK_TYPE_KERNEL_AICORE_002)
{
    const bool olgFlag = Runtime::Instance()->GetDisableThread();
    bool isSetVisibleDev = Runtime::Instance()->isSetVisibleDev;
    RawDevice *device = new RawDevice(0);
    device->Init();
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    Stream *stream = new Stream(device, 0);
    task.stream = stream;
    uint32_t payload = TS_ERROR_TASK_TYPE_NOT_SUPPORT;

    const void *stubFunc = (void *)0x03;
    const char *stubName = "efgexample";
    Kernel *kernel = NULL;
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    program->kernelNames_ = {'e', 'f', 'g', 'h', '\0'};
    kernel = new (std::nothrow) Kernel(stubFunc, stubName, "", program, 0);
    task.u.aicTaskInfo.kernel = kernel;

    std::unique_ptr<HwtsEngine> engine = std::make_unique<DirectHwtsEngine>(device);
    ((Runtime *)Runtime::Instance())->excptCallBack_ = ExeciptionCallbackStub;
    Runtime::Instance()->SetDisableThread(true);
    TaskInfo taskInfo = {0};
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .will(returnValue(&taskInfo));
    Runtime::Instance()->isSetVisibleDev = true;
    engine->ReportExceptProc(&task, payload);
    EXPECT_EQ(task.stream->GetErrCode(), payload);
    Runtime::Instance()->isSetVisibleDev = isSetVisibleDev;
    Runtime::Instance()->SetDisableThread(olgFlag);
    delete kernel;
    delete stream;
    delete device;
    GlobalMockObject::reset();
}