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
#include "async_hwts_engine.hpp"
#include "stars_engine.hpp"
#include "runtime.hpp"
#include "task_res.hpp"
#include "event.hpp"
#include "logger.hpp"
#include "raw_device.hpp"
#undef private
#undef protected
#include "scheduler.hpp"
#include "hwts.hpp"
#include "ctrl_stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "npu_driver.hpp"
#include "context.hpp"
#include "task_fail_callback_manager.hpp"
#include "device/device_error_proc.hpp"
#include <map>
#include <utility>  // For std::pair and std::make_pair.
#include "mmpa_api.h"
#include "task_submit.hpp"
#include "thread_local_container.hpp"

using namespace testing;
using namespace cce::runtime;

using std::pair;
using std::make_pair;

static void excptCallback(rtExceptionType type)
{
    return;
}

class EngineTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
        std::cout<<"engine test start"<<std::endl;

    }

    static void TearDownTestCase()
    {
        std::cout<<"engine test start end"<<std::endl;

    }

    virtual void SetUp()
    {
        rtSetDevice(0);

        device_ = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
        engine_ = ((RawDevice *)device_)->engine_;
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        rtError_t res = rtStreamCreate(&streamHandle_, 0);
        EXPECT_EQ(res, RT_ERROR_NONE);
        stream_ = (Stream *)streamHandle_;
        /* sleep 10ms，advoid stream_create task not processed in no-disable-thread scene, */
        /* in some case which may change the disable-thread flag. */
        usleep(10 * 1000);
        delete rawDevice;
    }

    virtual void TearDown()
    {
        rtStreamDestroy(streamHandle_);
        stream_ = nullptr;
        engine_ = nullptr;
        ((Runtime *)Runtime::Instance())->DeviceRelease(device_);
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }

protected:
    Device *device_ = nullptr;
    Stream *stream_ = nullptr;
    Engine *engine_ = nullptr;
    rtStream_t streamHandle_ = 0;
};


class SubmitFailScheduler : public FifoScheduler
{
public:
    virtual rtError_t PushTask(TaskInfo *task)
    {
        return RT_ERROR_INVALID_VALUE;
    }
};

static volatile uint16_t indp = 0;

class SendingRunScheduler : public FifoScheduler
{
public:
    Scheduler *test;

    void set(Scheduler *fifoScheduler)
    {
        test = fifoScheduler;
    }

    virtual rtError_t PushTask(TaskInfo *task)
    {
        return  test->PushTask(task);
    }

    virtual TaskInfo * PopTask()
    {
        std::cout << "PopTask begin indp = " << indp << std::endl;
        if (0 == indp)
        {
            indp = 1;
            std::cout << "PopTask in indp = " << indp << std::endl;
            return  NULL;
        }
        std::cout << "PopTask end indp = " << indp << std::endl;
        return test->PopTask();
    }
};

extern rtCommand_t g_command[2];

drvError_t halSqMemGet_stub1(uint32_t devId, struct halSqMemGetInput *sqMemGetInput, struct halSqMemGetOutput *sqMemGetOutput )
{
    memset_s(&g_command[devId], sizeof(rtTaskReport_t), 0, sizeof(rtTaskReport_t));
    sqMemGetOutput->cmdPtr = (void *)&g_command[devId];
    sqMemGetOutput->cmdCount = 1;
    return DRV_ERROR_NONE;
}

rtError_t utest_engine_stream_setup_sub(Stream *stream)
{
    stream->streamId_ = 0;
    return RT_ERROR_NONE;
}

void ExeciptionCallback(rtExceptionType type)
{
    printf("this is app exception callback, ExceptionType=%d\n", type);
}

TEST_F(EngineTest, EngineSendingWait)
{
    rtError_t err = RT_ERROR_NONE;
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    uint16_t taskId = 0;
    task.stream = stream_;
    MOCKER_CPP(&Stream::IsTaskLimited).stubs().will(returnValue(true)).then(returnValue(false));
    err = engine_->SendTask(&task, taskId);
    EXPECT_NE(err, RT_ERROR_NONE);
}

TEST_F(EngineTest, AddTaskToStream)
{
    rtError_t err = RT_ERROR_NONE;
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    uint16_t taskId = 0;
    task.stream = stream_;
    MOCKER_CPP(&Stream::AddTaskToStream).stubs().will(returnValue(RT_ERROR_NONE));
    err = engine_->TryAddTaskToStream(&task);
    EXPECT_EQ(err, RT_ERROR_NONE);
    GlobalMockObject::verify();
}

TEST_F(EngineTest, AddTaskToStreamFail)
{
    rtError_t err = RT_ERROR_NONE;
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    uint16_t taskId = 0;
    task.stream = stream_;
    MOCKER_CPP(&Stream::AddTaskToStream).stubs().will(returnValue(RT_ERROR_STREAM_FULL));
    rtError_t old = stream_->Device_()->GetDevStatus();
    stream_->Device_()->SetDevStatus(RT_ERROR_LOST_HEARTBEAT);
    err = engine_->TryAddTaskToStream(&task);
    EXPECT_EQ(err, RT_ERROR_LOST_HEARTBEAT);
    stream_->Device_()->SetDevStatus(RT_ERROR_NONE);
    GlobalMockObject::verify();
}

TEST_F(EngineTest, TaskSubmitSendingWait)
{
    rtError_t err = RT_ERROR_NONE;
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    uint16_t taskId = 0;
    task.stream = stream_;
    MOCKER_CPP(&Stream::IsTaskLimited).stubs().will(returnValue(true)).then(returnValue(false));
    err = AllocTaskAndSendDc(&task, stream_, nullptr);
    EXPECT_EQ(err, RT_ERROR_INVALID_VALUE);
}

TEST_F(EngineTest, ReportExceptProcNotSupport)
{
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    rtStream_t streamHandle;
    rtError_t res = rtStreamCreate(&streamHandle, 0);
    EXPECT_EQ(res, RT_ERROR_NONE);
    Stream *stream = (Stream *)streamHandle;
    task.stream = stream;
    uint32_t payload = TS_ERROR_TASK_TYPE_NOT_SUPPORT;
    std::unique_ptr<HwtsEngine> engine = std::make_unique<AsyncHwtsEngine>(device_);
    ((Runtime *)Runtime::Instance())->excptCallBack_ = ExeciptionCallback;
    engine->ReportExceptProc(&task, payload);
    rtStreamDestroy(streamHandle);
}

TEST_F(EngineTest, ReportExceptProcNotSupport_01)
{
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    rtStream_t streamHandle;
    rtError_t res = rtStreamCreate(&streamHandle, 0);
    EXPECT_EQ(res, RT_ERROR_NONE);
    Stream *stream = (Stream *)streamHandle;
    task.stream = stream;
    uint32_t payload = TS_ERROR_DEBUG_AI_CORE_EXCEPTION;
    std::unique_ptr<HwtsEngine> engine = std::make_unique<AsyncHwtsEngine>(device_);
    ((Runtime *)Runtime::Instance())->excptCallBack_ = ExeciptionCallback;
    device_->SetHasTaskError(true);
    engine->ReportExceptProc(&task, payload);
    rtStreamDestroy(streamHandle);
}

TEST_F(EngineTest, observer_test)
{
    EngineLogObserver observer;

    observer.KernelTaskEventLogProc(0, NULL, NULL);
    observer.TaskLaunchedEx(0, NULL, NULL);
    EXPECT_EQ(CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG), 0);
}

extern "C" void *__real_malloc (size_t c);
extern "C" void *__wrap_malloc (size_t c);
void *malloc_stub(unsigned int num_bytes)
{
    if (num_bytes == 3*sizeof(uint32_t))
        return NULL;
    return __real_malloc(num_bytes);
}

void ut_callback(rtExceptionType type)
{
    printf("this is app exception callback, ExceptionType=%d\n", type);
}

void ut_taskFailCallback(rtExceptionInfo_t *exceptionInfo) {
    printf("taskid=%d\n, streamid=%d\n, tid=%d\n,", exceptionInfo->taskid, exceptionInfo->streamid, exceptionInfo->tid);
    bool res = ((exceptionInfo->taskid == 1024) && (exceptionInfo->streamid == 512) && (exceptionInfo->tid == 256));
    EXPECT_EQ(res, true);
}

TEST_F(EngineTest, de_state_down)
{
    rtError_t error = RT_ERROR_NONE;
    TaskInfo task0 = {};
    task0.stream = stream_;
    std::unique_ptr<Engine> egine = std::make_unique<AsyncHwtsEngine>(device_);
    const bool flag = Runtime::Instance()->GetDisableThread();

    Runtime::Instance()->SetDisableThread(true);
    device_->SetDevStatus(RT_ERROR_SOCKET_CLOSE);
    error = egine->SubmitTask(&task0);
    EXPECT_EQ(error, RT_ERROR_SOCKET_CLOSE);
    device_->SetDevStatus(RT_ERROR_NONE);
    Runtime::Instance()->SetDisableThread(flag);
}

TEST_F(EngineTest, engine_start)
{
    rtError_t error = RT_ERROR_NONE;
    RawDevice *device = new RawDevice(0);
    device->Init();

    MOCKER_CPP_VIRTUAL(device->engine_, &Engine::Start)
            .stubs()
            .will(returnValue(RT_ERROR_INVALID_VALUE));
    device->Start();
    EXPECT_EQ(device->engine_->CheckMonitorThreadAlive(), false);
    delete device;
}

TEST_F(EngineTest, engine_report_last_error1)
{
    const void *stubFunc = NULL;
    rtStream_t streamHandle;
    rtError_t res = rtStreamCreate(&streamHandle, 0);
    EXPECT_EQ(res, RT_ERROR_NONE);
    Stream *stream = (Stream *)streamHandle;
    EngineLogObserver observer;

    TaskFactory *taskFactory = const_cast<TaskFactory *>(device_->GetTaskFactory());
    TaskInfo *task = taskFactory->Alloc(stream, TS_TASK_TYPE_KERNEL_AICORE, res);
    AicTaskInit(task, (uint32_t)0, (uint64_t)0x02, (uint16_t)1, nullptr);
    EXPECT_EQ(task->type, TS_TASK_TYPE_KERNEL_AICORE);
    task->tid = 256;
    task->stream = stream;

    MOCKER_CPP(&HwtsEngine::ReportExceptProc).stubs().will(ignoreReturnValue());
    MOCKER_CPP(&Engine::ProcessTask).stubs().will(returnValue(false));
    uint32_t errorCode = 0x2f;
    uint32_t errorDesc = 0x0;
    std::unique_ptr<DirectHwtsEngine> engine = std::make_unique<DirectHwtsEngine>(device_);
    engine->ReportLastError(stream->Id_(), task->id, errorCode, errorDesc);

    MOCKER(CheckLogLevel).stubs().will(returnValue(1));
    observer.TaskSubmited(device_, task);

    taskFactory->Recycle(task);
    GlobalMockObject::reset();

    res = rtStreamDestroy(streamHandle);
    EXPECT_EQ(res, RT_ERROR_NONE);
}

TEST_F(EngineTest, engine_PreProcessTask)
{
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    task.stream = stream_;
    uint32_t payload = 1;
    std::unique_ptr<DirectHwtsEngine> engine = std::make_unique<DirectHwtsEngine>(device_);
    ((Runtime *)Runtime::Instance())->excptCallBack_ = ut_callback;
    task.bindFlag = false;
    Runtime::Instance()->SetDisableThread(false);
    EXPECT_EQ(task.preRecycleFlag, false);
    engine->PreProcessTask(&task, payload);
}

TEST_F(EngineTest, engine_PreProcessTask_001)
{
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    task.stream = stream_;

    uint32_t payload = 1;
    std::unique_ptr<DirectHwtsEngine> engine = std::make_unique<DirectHwtsEngine>(device_);
    ((Runtime *)Runtime::Instance())->excptCallBack_ = ut_callback;
    task.bindFlag = false;
    bool orginThreadDisableFlag = Runtime::Instance()->GetDisableThread();
    MOCKER_CPP(&Stream::GetRecycleTaskHeadId)
        .stubs()
        .will(returnValue(RT_ERROR_STREAM_EMPTY));
    Runtime::Instance()->SetDisableThread(true);
    engine->PreProcessTask(&task, payload);
    EXPECT_EQ(task.preRecycleFlag, false);
    Runtime::Instance()->SetDisableThread(orginThreadDisableFlag);
    GlobalMockObject::reset();
}

TEST_F(EngineTest, engine_PreProcessTask_002)
{
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    task.stream = stream_;
    uint32_t payload = 1;
    std::unique_ptr<DirectHwtsEngine> engine = std::make_unique<DirectHwtsEngine>(device_);
    ((Runtime *)Runtime::Instance())->excptCallBack_ = ut_callback;
    task.bindFlag = false;

    bool orginThreadDisableFlag = Runtime::Instance()->GetDisableThread();
    MOCKER_CPP(&Stream::GetRecycleTaskHeadId)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    TaskInfo *nullTask = nullptr;
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .will(returnValue(nullTask));
    Runtime::Instance()->SetDisableThread(true);
    engine->PreProcessTask(&task, payload);
    EXPECT_EQ(task.preRecycleFlag, false);
    Runtime::Instance()->SetDisableThread(orginThreadDisableFlag);
    GlobalMockObject::reset();
}

TEST_F(EngineTest, engine_ProcessReport)
{
    rtTaskReport_t report;
    report.taskID = 1;
    report.SOP = 1;
    report.EOP = 1;
    report.streamID = 1;
    std::unique_ptr<DirectHwtsEngine> engine = std::make_unique<DirectHwtsEngine>(device_);
    engine->ProcessReport(&report, 16, false);
    EXPECT_EQ(engine->reportCount_, 1);
}

TEST_F(EngineTest, engine_ReportTimeoutProc)
{
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device_);
    engine->pendingNum_.Add(1U);
    const rtError_t error = RT_ERROR_REPORT_TIMEOUT;
    int32_t cnt = 37;
    const uint32_t streamId = 192;
    const uint32_t taskId = 5;
    const uint32_t execId = 4;
    const uint64_t msec = 5555;
    engine->ReportTimeoutProc(error, cnt, streamId, taskId, execId, msec);
    EXPECT_EQ(cnt, 0);
    engine->pendingNum_.Sub(1U);
}

TEST_F(EngineTest, engine_GetKernelNameForAiCoreorAiv)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    const void *stubFunc = (void *)0x03;
    const char *stubName = "efg";
    Kernel *kernel = NULL;
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    program->kernelNames_ = {'e', 'f', 'g', 'h', '\0'};

    MOCKER_CPP(&Runtime::GetProgram)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&Runtime::PutProgram)
        .stubs()
        .will(ignoreReturnValue());
    kernel = new (std::nothrow) Kernel(stubFunc, stubName, "", program, 0);
    ((Runtime *)Runtime::Instance())->kernelTable_.Add(kernel);

    std::unique_ptr<DirectHwtsEngine> aicpuErrObj = std::make_unique<DirectHwtsEngine>(device_);
    Stream *stm = new Stream(device, 1);
    stm->streamId_ = 1;
    rtError_t errCode = RT_ERROR_NONE;
    TaskInfo * const kernTask = device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_KERNEL_AICORE, errCode);

    AicTaskInit(kernTask, (uint32_t)3, (uint16_t)1, (uint64_t)0, nullptr);
    EXPECT_EQ(kernTask->type, TS_TASK_TYPE_KERNEL_AICORE);
    kernTask->u.aicTaskInfo.kernel = kernel;
    std::string kernelNameStr = aicpuErrObj->GetKernelNameForAiCoreorAiv(stm->Id_(), kernTask->id);
    EXPECT_STREQ("efg", kernelNameStr.c_str());
    device->GetTaskFactory()->Recycle(kernTask);
    DELETE_O(stm);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

rtError_t StubQueryCqShm1(RawDevice *device, uint32_t streamId, rtShmQuery_t &shmInfo)
{
    shmInfo.valid = 0x5A5A5A5A;
    return RT_ERROR_NONE;
}

TEST_F(EngineTest, HandleShmTask)
{
    std::unique_ptr<DirectHwtsEngine> engine = std::make_unique<DirectHwtsEngine>(device_);
    MOCKER_CPP(&DirectHwtsEngine::ReportLastError).stubs().will(ignoreReturnValue());
    rtShmQuery_t shareMemInfo;
    shareMemInfo.taskId = 2;
    shareMemInfo.firstErrorCode = 0x1;
    shareMemInfo.taskId1 = 1;
    shareMemInfo.lastErrorCode = 0x1;
    shareMemInfo.taskId2 = 2;
    shareMemInfo.valid = 0x5A5A5A5A;

    bool ret = engine->HandleShmTask(0, false, shareMemInfo);
    EXPECT_EQ(ret, true);
    shareMemInfo.taskId = 5;
    shareMemInfo.taskId1 = 3;
    shareMemInfo.taskId2 = 4;
    ret = engine->HandleShmTask(0, false, shareMemInfo);
    EXPECT_EQ(ret, true);
    GlobalMockObject::reset();
}

TEST_F(EngineTest, HandleShmTask_1)
{
    std::unique_ptr<DirectHwtsEngine> engine = std::make_unique<DirectHwtsEngine>(device_);
    MOCKER_CPP(&DirectHwtsEngine::ReportLastError).stubs().will(ignoreReturnValue());
    rtShmQuery_t shareMemInfo;
    shareMemInfo.taskId = 1;
    shareMemInfo.valid = 0x5A5A5A5A;

    bool ret = engine->HandleShmTask(0, false, shareMemInfo);
    EXPECT_EQ(ret, true);
    shareMemInfo.taskId = 1;
    shareMemInfo.firstErrorCode = 0x1;
    shareMemInfo.taskId1 = 3;
    shareMemInfo.lastErrorCode = 0;
    shareMemInfo.taskId2 = 0;
    ret = engine->HandleShmTask(0, false, shareMemInfo);
    EXPECT_EQ(ret, true);
    GlobalMockObject::reset();
}

TEST_F(EngineTest, TaskReclaimEx)
{
    std::unique_ptr<DirectHwtsEngine> engine = std::make_unique<DirectHwtsEngine>(device_);
    MOCKER_CPP(&Engine::RecycleTask).stubs().will(ignoreReturnValue());
    uint32_t taskID = 2;
    rtShmQuery_t shareMemInfo;
    shareMemInfo.taskId = 2;
    shareMemInfo.firstErrorCode = 0x1;
    shareMemInfo.taskId1 = 1;
    shareMemInfo.lastErrorCode = 0x1;
    shareMemInfo.taskId2 = 2;
    shareMemInfo.valid = 0x5A5A5A5A;

    Runtime::Instance()->SetDisableThread(true);
    engine->TaskReclaimEx(0, true, taskID, shareMemInfo);

    shareMemInfo.taskId = 5;
    shareMemInfo.taskId1 = 3;
    shareMemInfo.taskId2 = 4;
    engine->TaskReclaimEx(0, true, taskID, shareMemInfo);

    shareMemInfo.valid = 0;
    engine->TaskReclaimEx(0, true, taskID, shareMemInfo);

    Runtime::Instance()->SetDisableThread(false);
    engine->TaskReclaimEx(0, true, taskID, shareMemInfo);
    EXPECT_EQ(taskID, UINT32_MAX);
    GlobalMockObject::reset();
}

TEST_F(EngineTest, submit_task_failed)
{
    rtError_t error = RT_ERROR_NONE;
    TaskInfo task0 = {};
    Stream *stream = new Stream(device_, 0);
    stream->streamId_ = -1;
    task0.stream = stream;
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device_);

    error = engine->SubmitTask(&task0);
    EXPECT_EQ(error, RT_ERROR_STREAM_INVALID);
    delete stream;
}

TEST_F(EngineTest, ProcessTaskWait_01)
{
    rtError_t error = RT_ERROR_NONE;
    TaskInfo task0 = {};
    Stream *stream = new Stream(device_, 0);
    stream->streamId_ = -1;
    task0.stream = stream;
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device_);

    MOCKER(WaitExecFinishForModelExecuteTask)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));
    error = engine->ProcessTaskWait(&task0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete stream;
}

TEST_F(EngineTest, ProcessTaskWait_02)
{
    rtError_t error = RT_ERROR_NONE;
    TaskInfo task0 = {};
    Stream *stream = new Stream(device_, 0);
    stream->streamId_ = -1;
    task0.stream = stream;
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device_);

    MOCKER(WaitAsyncCopyComplete)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));
    error = engine->ProcessTaskWait(&task0);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    delete stream;
}
TEST_F(EngineTest, StarsCqeReceive_01)
{
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    task.stream = stream_;
    uint32_t payload = 1;
    std::unique_ptr<StarsEngine> engine = std::make_unique<StarsEngine>(device_);
    ((Runtime *)Runtime::Instance())->excptCallBack_ = ut_callback;

    rtLogicCqReport_t cqe = {0};
    cqe.errorCode = 0x41;
    engine->StarsCqeReceive(cqe, &task);
    EXPECT_NE(task.isCqeNeedConcern, true);
}

TEST_F(EngineTest, StarsCqeReceive_05)
{
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    task.stream = stream_;
    uint32_t payload = 1;
    std::unique_ptr<StarsEngine> engine = std::make_unique<StarsEngine>(device_);
    ((Runtime *)Runtime::Instance())->excptCallBack_ = ut_callback;

    rtLogicCqReport_t cqe = {0};
    cqe.errorCode = 0x41;
    engine->StarsCqeReceive(cqe, &task);
    EXPECT_NE(task.isCqeNeedConcern, true);
}

TEST_F(EngineTest, StarsCqeReceive_04)
{
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    task.stream = stream_;
    uint32_t payload = 1;
    std::unique_ptr<StarsEngine> engine = std::make_unique<StarsEngine>(device_);

    rtLogicCqReport_t cqe = {0};
    cqe.errorType = 0x41; // warning bit and error bit
    engine->StarsCqeReceive(cqe, &task);
    EXPECT_EQ(task.stream->GetNeedRecvCqeFlag(), false);
}

TEST_F(EngineTest, StarsCqeReceive_02)
{
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    task.stream = stream_;
    uint32_t payload = 1;
    std::unique_ptr<StarsEngine> engine = std::make_unique<StarsEngine>(device_);
    ((Runtime *)Runtime::Instance())->excptCallBack_ = ut_callback;

    rtLogicCqReport_t cqe = {0};
    task.id = 1;
    engine->StarsCqeReceive(cqe, &task);
    EXPECT_EQ(task.stream->GetNeedRecvCqeFlag(), false);
}

TEST_F(EngineTest, StarsCqeReceive_03)
{
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    task.stream = stream_;
    uint32_t payload = 1;
    std::unique_ptr<StarsEngine> engine = std::make_unique<StarsEngine>(device_);
    ((Runtime *)Runtime::Instance())->excptCallBack_ = ut_callback;

    rtLogicCqReport_t cqe = {0};
    task.id = 1;
    engine->StarsCqeReceive(cqe, &task);
    EXPECT_EQ(task.stream->GetNeedRecvCqeFlag(), false);
}

TEST_F(EngineTest, StarsCqeReceive_06)
{
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_FFTS_PLUS;
    task.stream = stream_;
    task.errorCode = 0x1;
    FftsPlusTaskInfo *fftsPlusTask = &(task.u.fftsPlusTask);
    fftsPlusTask->kernelFlag = RT_KERNEL_FFTSPLUS_DYNAMIC_SHAPE_DUMPFLAG;

    uint32_t payload = 1;
    std::unique_ptr<StarsEngine> engine = std::make_unique<StarsEngine>(device_);
    ((Runtime *)Runtime::Instance())->excptCallBack_ = ut_callback;

    rtLogicCqReport_t cqe = {0};
    task.id = 1;
    engine->StarsCqeReceive(cqe, &task);
    EXPECT_EQ(task.stream->GetNeedRecvCqeFlag(), false);
}

TEST_F(EngineTest, StarsMonitor_DevRuningDown)
{
    std::unique_ptr<StarsEngine> engine = std::make_unique<StarsEngine>(device_);
    uint32_t threadNumBefore = Runtime::Instance()->monitorThreadNum_.Value();
    engine->MonitoringRun();
    const bool flag = Runtime::Instance()->GetDisableThread();
    Runtime::Instance()->SetDisableThread(true);
    engine->SetDevRunningState(DEV_RUNNING_DOWN);
    rtDeviceStatus deviceStatus = RT_DEVICE_STATUS_NORMAL;
    rtError_t error = ((Runtime *)Runtime::Instance())->GetWatchDogDevStatus(device_->Id_(), &deviceStatus);
    engine->SetDevRunningState(DEV_RUNNING_NORMAL);
    auto *instance = Runtime::Instance();
    uint32_t threadNumAfter = instance->monitorThreadNum_.Value();
    EXPECT_EQ(threadNumBefore, threadNumAfter);
    Runtime::Instance()->SetDisableThread(flag);
}

drvError_t drvGetPlatformInfo_offline_stub(uint32_t *info)
{
    *info = RT_RUN_MODE_OFFLINE;
    return DRV_ERROR_NONE;
}

TEST_F(EngineTest, ReportSocketCloseProc_01)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_offline_stub));
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device_);
    engine->ReportSocketCloseProc();
    EXPECT_EQ(engine->GetDevRunningState(), DEV_RUNNING_NORMAL);
}

TEST_F(EngineTest, ReportSocketCloseProc_02)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_offline_stub));
    MOCKER_CPP(&Runtime::GetHdcConctStatus)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device_);
    engine->ReportSocketCloseProc();
    EXPECT_EQ(engine->GetDevRunningState(), DEV_RUNNING_NORMAL);
}

TEST_F(EngineTest, ReportSocketCloseProc_03)
{
    int32_t hdcStat = static_cast<int32_t>(HDC_SESSION_STATUS_CONNECT);
    MOCKER_CPP(&Runtime::GetHdcConctStatus)
        .stubs()
        .with(mockcpp::any(), outBound(hdcStat))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&TaskFailCallBackManager::Notify)
        .stubs();
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device_);
    engine->ReportSocketCloseProcV2();
    EXPECT_EQ(engine->GetDevRunningState(), DEV_RUNNING_NORMAL);
}

TEST_F(EngineTest, SendCommand_WaitExec)
{
    TaskInfo task = {};
    task.stream = stream_;
    task.type = TS_TASK_TYPE_MODEL_EXECUTE;
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device_);
    rtTsCommand_t cmdLocal;
    (void)memset_s(&cmdLocal.cmdBuf, sizeof(rtTsCommandBuf_t), 0, sizeof(rtTsCommandBuf_t));
    rtTsCmdSqBuf_t command = {};
    const uint32_t sendSqeNum = 1U;
    MOCKER(WaitExecFinish)
        .stubs()
        .will(returnValue(RT_ERRORCODE_BASE));
    rtError_t error = engine->SendCommand(&task, cmdLocal, &command, sendSqeNum);
    EXPECT_EQ(error, RT_ERRORCODE_BASE);
}

drvError_t drvGetPlatformInfo_OOM_stub(uint32_t *info)
{
    *info = RT_ERROR_DEVICE_OOM;
    return DRV_ERROR_NONE;
}

TEST_F(EngineTest, ReportStatusOomProc_01)
{
    rtError_t error = RT_ERROR_DEVICE_OOM;
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_OOM_stub));
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device_);
    engine->ReportStatusOomProc(error, 0);
    EXPECT_EQ(engine->GetDevRunningState(), DEV_RUNNING_NORMAL);
}

TEST_F(EngineTest, DvppWaitGroup)
{
    DvppGrp *grp = new DvppGrp(device_, 0);
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device_);

    rtError_t error = engine->DvppWaitGroup(grp, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
    delete grp;
}


TEST_F(EngineTest, recycle_thread_run_test)
{
    std::unique_ptr<DirectHwtsEngine> engine = std::make_unique<DirectHwtsEngine>(device_);
    engine->RecycleThreadRun();
    EXPECT_EQ(engine->recycleThreadRunFlag_, false);
}

TEST_F(EngineTest, davinci_task_exception_test)
{
    RawDevice *device = new RawDevice(0);
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device);

    bool result = engine->ProcessTaskDavinciList(nullptr, 1, 0);
    EXPECT_EQ(result, false);

    uint16_t recycleTaskNum = 0;
    result = engine->ProcessPublicTask(nullptr, 0, &recycleTaskNum);
    EXPECT_EQ(result, false);

    delete device;
}
rtError_t utest_get_head_pos_from_ctrl_sq_stub(CtrlStream *This, uint32_t &sqHead)
{
    sqHead = 0;
    return RT_ERROR_NONE;
}

TEST_F(EngineTest, CtrlTaskReclaim_test)
{
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device_);
    CtrlStream* stm = new CtrlStream(device_);
    engine->CtrlTaskReclaim(stm);
    MOCKER_CPP(&CtrlStream::GetHeadPosFromCtrlSq, rtError_t (CtrlStream::*)(uint32_t&))
        .stubs()
        .will(returnValue(RT_ERROR_DRV_NOT_SUPPORT))
        .then(invoke(utest_get_head_pos_from_ctrl_sq_stub));

    engine->CtrlTaskReclaim(stm);
    uint32_t sqHead = 0;
    (void)stm->GetHeadPosFromCtrlSq(sqHead);
    EXPECT_EQ(sqHead, 0U);

    DELETE_O(stm);
}

TEST_F(EngineTest, TaskFactory_RecycleCtrlTask)
{
    CtrlStream* stm = new CtrlStream(device_);

    TaskInfo taskInfo = {};
    taskInfo.id = UINT16_MAX;
    taskInfo.stream = stm;
    taskInfo.type = TS_TASK_TYPE_RESERVED;
    (void)device_->GetTaskFactory()->Recycle(&taskInfo);

    DELETE_O(stm);
}

TEST_F(EngineTest, RecycleCtrlTask_test)
{
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device_);
    CtrlStream* stm = new CtrlStream(device_);

    engine->RecycleCtrlTask(stm, 0);
    stm->SetSqTailPos(2);

    MOCKER_CPP_VIRTUAL(stm, &CtrlStream::GetTaskIdByPos)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    engine->RecycleCtrlTask(stm, 0);
    uint32_t taskId = 0;
    (void)stm->GetTaskIdByPos(0, taskId);
    EXPECT_EQ(taskId, 0U);

    DELETE_O(stm);
}

void DvppGrpCallback(rtDvppGrpRptInfo_t *report)
{
    UNUSED(report);
}

TEST_F(EngineTest, StarsReportLogicCq_01)
{
    std::unique_ptr<StarsEngine> engine = std::make_unique<StarsEngine>(device_);
    rtLogicCqReport_t cqe = {0};
    engine->StarsReportLogicCq(cqe, DvppGrpCallback, 0xFFU, 0);
    uint16_t streamId = (cqe.streamId & 0x7FFFU);
    uint16_t taskId = cqe.taskId;
    TaskInfo *reportTask = device_->GetTaskFactory()->GetTask(static_cast<int32_t>(streamId), taskId);
    EXPECT_EQ(reportTask, nullptr);
}

TEST_F(EngineTest, create_recycle_thread_1)
{
    RawDevice *device = new RawDevice(0);
    std::unique_ptr<DirectHwtsEngine> engine = std::make_unique<DirectHwtsEngine>(device);

    rtError_t result = engine->CreateRecycleThread();
    EXPECT_EQ(result, RT_ERROR_NONE);

    engine->DestroyRecycleThread();
    EXPECT_EQ(engine->recycleThreadRunFlag_ , false);

    delete device;
}

TEST_F(EngineTest, create_recycle_thread_2)
{
    RawDevice *device = new RawDevice(0);
    std::unique_ptr<DirectHwtsEngine> engine = std::make_unique<DirectHwtsEngine>(device);

    MOCKER(mmSemInit).stubs().will(returnValue(RT_ERROR_MEMORY_ALLOCATION));

    rtError_t result = engine->CreateRecycleThread();
    EXPECT_EQ(result, RT_ERROR_MEMORY_ALLOCATION);

    delete device;
}

TEST_F(EngineTest, device_status_proc)
{
    RawDevice *device = new RawDevice(0);

    device->SetDevStatus(RT_ERROR_LOST_HEARTBEAT);

    rtError_t ret = device->GetDevStatus();

    EXPECT_EQ(ret, RT_ERROR_LOST_HEARTBEAT);

    delete device;
}

TEST_F(EngineTest, device_monitor_exit_flag)
{
    RawDevice *device = new RawDevice(0);

    device->SetMonitorExitFlag(true);

    bool ret = device->GetMonitorExitFlag();

    EXPECT_EQ(ret, true);

    delete device;
}

TEST_F(EngineTest, Start_engine)
{
    rtError_t error;
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device_);
    error = engine->Init();
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(OsalFactory::CreateNotifier)
            .stubs()
            .will(returnValue((Notifier *)NULL));

    error = engine->Start();
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(EngineTest, WaitCompletion_test_break)
{
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device_);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    engine->pendingNum_.Set(1U);
    bool orginThreadDisableFlag = Runtime::Instance()->GetDisableThread();
    Runtime::Instance()->SetDisableThread(true);
    MOCKER_CPP_VIRTUAL(engine.get(), &Engine::TaskReclaim)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));
    engine->WaitCompletion();
    EXPECT_EQ(engine->pendingNum_.Value(), 1U);
    Runtime::Instance()->SetDisableThread(orginThreadDisableFlag);
}

TEST_F(EngineTest, WaitCompletion_test_submit_task_fail_break)
{
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device_);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    engine->pendingNum_.Set(1U);
    engine->SetIsSubmitTaskFailFlag(true);
    engine->WaitCompletion();
    engine->SetIsSubmitTaskFailFlag(false);
    EXPECT_EQ(engine->pendingNum_.Value(), 1U);
    engine->pendingNum_.Set(0U);
}

TEST_F(EngineTest, PushFlipTask_error_recycle)
{
    std::unique_ptr<AsyncHwtsEngine> engine = std::make_unique<AsyncHwtsEngine>(device_);
    Stream *stream = new Stream(device_, 0);
    MOCKER_CPP_VIRTUAL(stream, &Stream::IsNeedSendFlipTask)
        .stubs()
        .will(returnValue(true));

    TaskInfo task = {};
    MOCKER_CPP(&Stream::ProcFlipTask)
        .stubs()
        .with(outBound(&task), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&AsyncHwtsEngine::SubmitPush)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));
    MOCKER_CPP(&TaskFactory::Recycle)
        .stubs()
        .will(returnValue(0));

    rtError_t error = engine->PushFlipTask(1, stream);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    GlobalMockObject::verify();
    delete stream;
}

TEST_F(EngineTest, SubmitPush_error)
{
    std::unique_ptr<AsyncHwtsEngine> engine = std::make_unique<AsyncHwtsEngine>(device_);
    engine->Init();
    TaskInfo task = {};
    Stream *stream = new Stream(device_, 0);
    task.stream = stream;
    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    uint32_t flipTaskId = 1U;

    MOCKER_CPP_VIRTUAL(engine->GetScheduler(), &Scheduler::PushTask)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    rtError_t error = engine->SubmitPush(&task, &flipTaskId);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    GlobalMockObject::verify();
    delete stream;
}

TEST_F(EngineTest, TaskRecycleProcess_null_task)
{
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device_);
    bool ret = engine->TaskRecycleProcess(nullptr, 0);
    EXPECT_EQ(ret, false);
    GlobalMockObject::reset();
}

TEST_F(EngineTest, PreProcessTask_do_while)
{
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    task.stream = stream_;
    uint32_t payload = 1;
    std::unique_ptr<DirectHwtsEngine> engine = std::make_unique<DirectHwtsEngine>(device_);
    ((Runtime *)Runtime::Instance())->excptCallBack_ = ut_callback;
    task.bindFlag = false;

    bool orginThreadDisableFlag = Runtime::Instance()->GetDisableThread();
    MOCKER_CPP(&Stream::GetRecycleTaskHeadId)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .will(returnValue(&task));
    Runtime::Instance()->SetDisableThread(true);
    engine->PreProcessTask(&task, payload);
    EXPECT_EQ(task.preRecycleFlag, true);
    Runtime::Instance()->SetDisableThread(orginThreadDisableFlag);
    GlobalMockObject::reset();
}

TEST_F(EngineTest, GetRecycleDavinciTaskNum_test)
{
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device_);
    uint16_t lastRecycleEndTaskId = MAX_UINT16_NUM;
    uint16_t recycleEndTaskId = 0U;
    uint16_t recyclePublicTaskCount = 0U;
    uint32_t taskNum = engine->GetRecycleDavinciTaskNum(lastRecycleEndTaskId,
        recycleEndTaskId, recyclePublicTaskCount);
    EXPECT_EQ(taskNum, 1U);

    lastRecycleEndTaskId = 0U;
    recycleEndTaskId = 1U;
    taskNum = engine->GetRecycleDavinciTaskNum(lastRecycleEndTaskId,
        recycleEndTaskId, recyclePublicTaskCount);
    EXPECT_EQ(taskNum, 1U);

    lastRecycleEndTaskId = 1U;
    recycleEndTaskId = 0U;
    recyclePublicTaskCount = 65535U;
    taskNum = engine->GetRecycleDavinciTaskNum(lastRecycleEndTaskId,
        recycleEndTaskId, recyclePublicTaskCount);
    EXPECT_EQ(taskNum, 0U);

    lastRecycleEndTaskId = 1U;
    recycleEndTaskId = 0U;
    recyclePublicTaskCount = 0U;
    taskNum = engine->GetRecycleDavinciTaskNum(lastRecycleEndTaskId,
        recycleEndTaskId, recyclePublicTaskCount);
    EXPECT_EQ(taskNum, 65534U);
}

TEST_F(EngineTest, ProcessTaskDavinciList_invalid_endTaskId)
{
    RawDevice *device = new RawDevice(0);
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device);
    bool result = engine->ProcessTaskDavinciList(nullptr, MAX_UINT16_NUM, 0);
    EXPECT_EQ(result, false);
    delete device;
}

TEST_F(EngineTest, TrigerAsyncRecycle_taskDelay)
{
    std::unique_ptr<Engine> engine = std::make_unique<DirectHwtsEngine>(device_);
    engine->Init();

    Stream *stream = new Stream(device_, 0);

    uint16_t lastRecycleTaskId = 0U;
    uint16_t endTaskId = 0U;
    bool isTaskDelayRecycle = true;

    stream->SetIsSupportASyncRecycle(true);
    stream->SetStreamAsyncRecycleFlag(true);
    MOCKER_CPP_VIRTUAL((RawDevice *)device_, &RawDevice::AddStreamToMessageQueue).stubs()
        .will(returnValue(true));
    MOCKER_CPP_VIRTUAL(engine.get(), &Engine::WakeUpRecycleThread).stubs();

    engine->TrigerAsyncRecycle(stream, lastRecycleTaskId,
        endTaskId, isTaskDelayRecycle);
    EXPECT_EQ(stream->GetRecycleEndTaskId(), lastRecycleTaskId);

    delete stream;
    GlobalMockObject::reset();
}

TEST_F(EngineTest, ProcessPublicTask_recycleStm_null)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device);
    engine->Init();
    Stream *stream = new Stream(device, 0);
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    task.stream = stream;

    stream->SetIsSupportASyncRecycle(true);
    stream->SetStreamAsyncRecycleFlag(true);

    device->GetStreamSqCqManage()->SetStreamIdToStream(stream->Id_(), nullptr);
    uint16_t recycleTaskNum = 0;
    bool ret = engine->ProcessPublicTask(&task, 0, &recycleTaskNum);
    EXPECT_EQ(ret, false);

    delete stream;
    delete device;
    GlobalMockObject::reset();
}

TEST_F(EngineTest, ProcessPublicTask_GetRecycleWorkTask_null)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device);
    engine->Init();
    Stream *stream = new Stream(device, 0);
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    task.stream = stream;

    MOCKER_CPP(&Stream::GetPublicTaskHead)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    uint16_t recycleTaskNum = 0;
    bool ret = engine->ProcessPublicTask(&task, 0, &recycleTaskNum);
    EXPECT_EQ(ret, false);

    delete stream;
    delete device;
    GlobalMockObject::reset();
}

TEST_F(EngineTest, GetTsReportByIdx_GetRecycleWorkTask_null)
{
    RawDevice *device = new RawDevice(0);
    std::unique_ptr<AsyncHwtsEngine> engine = std::make_unique<AsyncHwtsEngine>(device);
    rtStarsCqe_t cqeReport;
    cqeReport.streamID = 1;
    rtTsReport_t tsReport;
    tsReport.msgType = TS_REPORT_MSG_TYPE_STARS_CQE;
    engine->GetTsReportByIdx(reinterpret_cast<void *>(&cqeReport), 0, tsReport);
    EXPECT_EQ(tsReport.msgBuf.starsCqe->streamID, cqeReport.streamID);
    delete device;
    GlobalMockObject::reset();
}

TEST_F(EngineTest, GetReportCommonInfo_TS_REPORT_MSG_TYPE_STARS_CQE)
{
    RawDevice *device = new RawDevice(0);
    std::unique_ptr<AsyncHwtsEngine> engine = std::make_unique<AsyncHwtsEngine>(device);

    rtStarsCqe_t cqeReport;
    cqeReport.streamID = 1;
    cqeReport.taskID = 1;
    cqeReport.SQ_id = 1;
    cqeReport.SQ_head = 1;
    cqeReport.error_bit = 1;
    rtTsReport_t tsReport;
    tsReport.msgType = TS_REPORT_MSG_TYPE_STARS_CQE;
    tsReport.msgBuf.starsCqe = &cqeReport;

    uint16_t streamId = 0U;
    uint16_t taskId = 0U;
    uint16_t sqId = 0U;
    uint16_t sqHead = 0U;
    uint16_t errorBit = 0U;
    engine->GetReportCommonInfo(tsReport, streamId, taskId, sqId, sqHead, errorBit);
    EXPECT_EQ(streamId, cqeReport.streamID);
    EXPECT_EQ(taskId, cqeReport.taskID);
    EXPECT_EQ(sqId, cqeReport.SQ_id);
    EXPECT_EQ(sqHead, cqeReport.SQ_head);
    EXPECT_EQ(errorBit, cqeReport.error_bit);
    delete device;
}

void TaskFailCallBackStub(const uint32_t streamId, const uint32_t taskId,
                      const uint32_t threadId, const uint32_t retCode,
                      const Device * const dev)
{
    // stub
}
TEST_F(EngineTest, ProcessOverFlowReport_TS_TASK_TYPE_KERNEL_AICORE)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    std::unique_ptr<AsyncHwtsEngine> engine = std::make_unique<AsyncHwtsEngine>(device);

    rtTaskReport_t report;
    report.streamID = 0;
    report.streamIDEx = 0;
    report.streamID = 0;

    Stream *stream = new Stream(device, 0);
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    task.stream = stream;

    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .with(mockcpp::any(), mockcpp::any())
        .will(returnValue(&task));
    MOCKER(TaskFailCallBack).stubs().will(invoke(TaskFailCallBackStub));
    uint32_t tsRetCode = RT_ERROR_INVALID_VALUE;
    engine->ProcessOverFlowReport(&report, RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(task.errorCode, tsRetCode);
    GlobalMockObject::reset();
    delete stream;
    delete device;
}

TEST_F(EngineTest, ProcessOverFlowReport_TS_TASK_TYPE_KERNEL_AICORE_1)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    std::unique_ptr<AsyncHwtsEngine> engine = std::make_unique<AsyncHwtsEngine>(device);

    rtTaskReport_t report;
    report.streamID = 0;
    report.streamIDEx = 0;
    report.streamID = 0;

    const void *stubFunc = (void *)0x03;
    const char *stubName = "efg";
    Kernel *kernel = NULL;
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    program->kernelNames_ = {'e', 'f', 'g', 'h', '\0'};

    MOCKER_CPP(&Runtime::GetProgram)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&Runtime::PutProgram)
        .stubs()
        .will(ignoreReturnValue());
    kernel = new (std::nothrow) Kernel(stubFunc, stubName, "", program, 0);
    ((Runtime *)Runtime::Instance())->kernelTable_.Add(kernel);

    Stream *stream = new Stream(device, 0);
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    task.stream = stream;

    AicTaskInfo *aicTaskInfo = &(task.u.aicTaskInfo);
    aicTaskInfo->kernel = kernel;
    kernel->SetDfxSize(100U);
    uint8_t buf[4096] = {0};
    kernel->SetDfxAddr(buf);
    aicTaskInfo->inputArgsSize.infoAddr = buf;
    aicTaskInfo->comm.args = buf;
    aicTaskInfo->comm.argsSize = 10U;

    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .with(mockcpp::any(), mockcpp::any())
        .will(returnValue(&task));
    uint32_t tsRetCode = RT_ERROR_INVALID_VALUE;
    engine->ProcessOverFlowReport(&report, RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(task.errorCode, tsRetCode);
    GlobalMockObject::reset();
    DELETE_O(kernel);
    delete stream;
    delete device;
}

TEST_F(EngineTest, ProcessOverFlowReport_TS_TASK_TYPE_KERNEL_AICORE_2)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    std::unique_ptr<AsyncHwtsEngine> engine = std::make_unique<AsyncHwtsEngine>(device);

    rtTaskReport_t report;
    report.streamID = 0;
    report.streamIDEx = 0;
    report.streamID = 0;

    const void *stubFunc = (void *)0x03;
    const char *stubName = "efgexample";
    Kernel *kernel = NULL;
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    program->kernelNames_ = {'e', 'f', 'g', 'h', '\0'};

    MOCKER_CPP(&Runtime::GetProgram)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&Runtime::PutProgram)
        .stubs()
        .will(ignoreReturnValue());
    kernel = new (std::nothrow) Kernel(stubFunc, stubName, "", program, 0);
    ((Runtime *)Runtime::Instance())->kernelTable_.Add(kernel);

    Stream *stream = new Stream(device, 0);
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    task.stream = stream;

    AicTaskInfo *aicTaskInfo = &(task.u.aicTaskInfo);
    aicTaskInfo->kernel = kernel;
    kernel->SetDfxSize(6584);
    uint8_t buf[4096] = {0};
    kernel->SetDfxAddr(buf);
    program->binary_ = buf + 1024;
    program->binarySize_ = 300;

    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .with(mockcpp::any(), mockcpp::any())
        .will(returnValue(&task));
    uint32_t tsRetCode = RT_ERROR_INVALID_VALUE;
    engine->ProcessOverFlowReport(&report, RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(task.errorCode, tsRetCode);
    GlobalMockObject::reset();
    DELETE_O(kernel);
    delete stream;
    delete device;
}

void ObserverTaskLaunched(EngineObserver *ob, const uint32_t devId, TaskInfo * const tsk, rtTsCommand_t * const command)
{
    (void)devId;
    (void)command;
    tsk->errorCode = RT_ERROR_INVALID_VALUE;
}

TEST_F(EngineTest, ProcessObserver_observerNum)
{
    RawDevice *device = new RawDevice(0);
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device);
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICORE;

    MOCKER(CheckLogLevel).stubs().will(returnValue(1));
    EngineObserver observer;
    engine->AddObserver(&observer);
    MOCKER_CPP_VIRTUAL(&observer, &EngineObserver::TaskLaunched)
        .stubs()
        .will(invoke(ObserverTaskLaunched));
    engine->ProcessObserver(0, &task, nullptr);
    EXPECT_EQ(task.errorCode, RT_ERROR_INVALID_VALUE);
    delete device;
    GlobalMockObject::reset();
}

TEST_F(EngineTest, ProcessTaskWait_WaitExecFinish_error)
{
    RawDevice *device = new RawDevice(0);
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device);
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_RESERVED;

    MOCKER(WaitExecFinish).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    rtError_t ret = engine->ProcessTaskWait(&task);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    delete device;
    GlobalMockObject::reset();
}

TEST_F(EngineTest, GetKernelNameForAiCoreorAiv_workTask_null)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    std::unique_ptr<DirectHwtsEngine> engine = std::make_unique<DirectHwtsEngine>(device);

    TaskInfo *nullTask = nullptr;
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .will(returnValue(nullTask));
    std::string ret = engine->GetKernelNameForAiCoreorAiv(0, 0);
    EXPECT_EQ(ret, "unknown");
    delete device;
    GlobalMockObject::reset();
}

void ToConstructSqeStub(TaskInfo *taskInfo, rtStarsSqe_t *const command)
{
    (void)command;
    taskInfo->errorCode = RT_ERROR_NONE;
}

TEST_F(EngineTest, TaskToCommand_RT_TASK_COMMAND_TYPE_STARS_SQE)
{
    RawDevice *device = new RawDevice(0);
    std::unique_ptr<AsyncHwtsEngine> engine = std::make_unique<AsyncHwtsEngine>(device);

    rtTsCommand_t cmdLocal;
    cmdLocal.cmdType = RT_TASK_COMMAND_TYPE_STARS_SQE;

    MOCKER(ToConstructSqe).stubs().will(invoke(ToConstructSqeStub));
    rtLogicReport_t report;
    TaskInfo task = {};
    engine->TaskToCommand(&task, cmdLocal, nullptr);
    EXPECT_EQ(task.errorCode, RT_ERROR_NONE);
    delete device;
    GlobalMockObject::reset();
}

TEST_F(EngineTest, SetReportSimuFlag_test)
{
    RawDevice *device = new RawDevice(0);
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device);

    rtStarsCqe_t cqeReport;
    cqeReport.evt = 0U;

    rtTsReport_t taskReport;
    taskReport.msgType = TS_REPORT_MSG_TYPE_STARS_CQE;
    taskReport.msgBuf.starsCqe = &cqeReport;

    rtLogicReport_t report;
    engine->SetReportSimuFlag(taskReport);
    EXPECT_EQ(taskReport.msgBuf.starsCqe->evt, 1U);
    delete device;
    GlobalMockObject::reset();
}

TEST_F(EngineTest, CheckReportSimuFlag_TS_REPORT_MSG_TYPE_STARS_CQE)
{
    RawDevice *device = new RawDevice(0);
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device);

    rtStarsCqe_t cqeReport;
    cqeReport.evt = 1U;
    cqeReport.place_hold = 1U;

    rtTsReport_t taskReport;
    taskReport.msgType = TS_REPORT_MSG_TYPE_STARS_CQE;
    taskReport.msgBuf.starsCqe = &cqeReport;

    rtLogicReport_t report;
    bool ret = engine->CheckReportSimuFlag(taskReport);
    EXPECT_EQ(ret, true);

    taskReport.msgBuf.starsCqe->evt = 0U;
    ret = engine->CheckReportSimuFlag(taskReport);
    EXPECT_EQ(ret, false);

    delete device;
    GlobalMockObject::reset();
}

TEST_F(EngineTest, ReportSocketCloseProc_RT_ERROR_SOCKET_CLOSE)
{
    RawDevice *device = new RawDevice(0);
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device);
    int32_t hdcStat = static_cast<int32_t>(HDC_SESSION_STATUS_CLOSE);
    MOCKER_CPP(&Runtime::GetHdcConctStatus)
        .stubs()
        .with(mockcpp::any(), outBound(hdcStat))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&TaskFailCallBackManager::Notify).stubs();
    MOCKER_CPP(&Runtime::SetWatchDogDevStatus)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    engine->ReportSocketCloseProcV2();
    EXPECT_EQ(engine->GetDevice()->GetDevStatus(), RT_ERROR_SOCKET_CLOSE);
    engine->SetDevRunningState(DEV_RUNNING_NORMAL);
    delete device;
    GlobalMockObject::reset();
}

TEST_F(EngineTest, SendingWait_failCount)
{
    RawDevice *device = new RawDevice(0);
    std::unique_ptr<AsyncHwtsEngine> engine = std::make_unique<AsyncHwtsEngine>(device);
    engine->notifier_ = nullptr;
    engine->wflag_ = true;

    uint8_t failCount = 10;
    engine->SendingWait(nullptr, failCount);
    EXPECT_EQ(failCount, 11);
    engine->SendingNotify();
    EXPECT_EQ(engine->wflag_, false);

    delete device;
    GlobalMockObject::reset();
}

TEST_F(EngineTest, CheckSendThreadAlive_test)
{
    RawDevice *device = new RawDevice(0);
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device);

    bool ret = engine->CheckSendThreadAlive();
    EXPECT_EQ(ret, false);

    ret = engine->CheckReceiveThreadAlive();
    EXPECT_EQ(ret, false);

    ret = engine->CheckMonitorThreadAlive();
    EXPECT_EQ(ret, false);

    // test for RecycleTask, workTask is null
    TaskInfo *nullTask = nullptr;
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .will(returnValue(nullTask));

    engine->RecycleTask(0, 0);

    delete device;
    GlobalMockObject::reset();
}


TEST_F(EngineTest, SubmitSend_test)
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
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Engine::SendFlipTask)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::ProcRecordTask)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::SetStreamMark).stubs();

    uint32_t flipTaskId = UINT32_MAX;
    rtError_t ret = engine->SubmitSend(&task, &flipTaskId);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    engine->RecycleSeparatedStmByFinishedId(stream, flipTaskId, false);
    delete stream;
    delete device;
    GlobalMockObject::reset();
}

class EngineTestWithDisableThread : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"engine test start"<<std::endl;

    }

    static void TearDownTestCase()
    {
        std::cout<<"engine test start end"<<std::endl;
    }

    virtual void SetUp()
    {
        rtSetDevice(0);
        device_ = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
        engine_ = ((RawDevice *)device_)->engine_;
        rtError_t res = rtStreamCreate(&streamHandle_, 0);
        EXPECT_EQ(res, RT_ERROR_NONE);
        stream_ = (Stream *)streamHandle_;
    }

    virtual void TearDown()
    {
        rtStreamDestroy(streamHandle_);
        stream_ = nullptr;
        engine_ = nullptr;
        ((Runtime *)Runtime::Instance())->DeviceRelease(device_);
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }

protected:
    Device *device_ = nullptr;
    Stream *stream_ = nullptr;
    Engine *engine_ = nullptr;
    rtStream_t streamHandle_ = 0;
};

TEST_F(EngineTestWithDisableThread, test_not_same_taskid_branch_engine)
{
    Stream *stream = new Stream(device_, 0);
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device_);
    uint32_t taskId = 1111U;
    stream->SetCheckTaskId(taskId);
    bool orginThreadDisableFlag = Runtime::Instance()->GetDisableThread();
    MOCKER_CPP_VIRTUAL(engine.get(), &Engine::TaskReclaim)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    uint8_t failCount = 0U;
    Runtime::Instance()->SetDisableThread(true);
    engine->SendingWait(stream, failCount);
    EXPECT_EQ(failCount, 1U);
    Runtime::Instance()->SetDisableThread(orginThreadDisableFlag);
    delete stream;
}

TEST_F(EngineTestWithDisableThread, test_not_same_taskid_branch_starsengine)
{
    Stream *stream = new Stream(device_, 0);
    std::unique_ptr<StarsEngine> engine = std::make_unique<StarsEngine>(device_);
    uint32_t taskId = 6666U;
    stream->SetCheckTaskId(taskId);
    bool orginThreadDisableFlag = Runtime::Instance()->GetDisableThread();
    MOCKER_CPP(&StarsEngine::SendingProcReport)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    Runtime::Instance()->SetDisableThread(true);
    engine->SendingWaitProc(stream);
    EXPECT_EQ(stream->GetRecycleFlag(), false);
    Runtime::Instance()->SetDisableThread(orginThreadDisableFlag);
    delete stream;
}

TEST_F(EngineTest, PushFlipTask_flip_fail)
{
    std::unique_ptr<AsyncHwtsEngine> engine = std::make_unique<AsyncHwtsEngine>(device_);
    std::unique_ptr<Stream> stream = std::make_unique<Stream>(device_, 0);
    MOCKER_CPP_VIRTUAL(stream.get(), &Stream::IsNeedSendFlipTask)
        .stubs()
        .will(returnValue(true));
    TaskInfo task = {};
    MOCKER_CPP(&Stream::ProcFlipTask)
        .stubs()
        .with(outBound(&task), mockcpp::any())
        .will(returnValue(RT_ERROR_COMMON_BASE));
    EngineObserver engObj;
    engObj.TaskSubmited(device_, &task);
    engObj.TaskFinished(0, &task);
    rtError_t error = engine->PushFlipTask(1, stream.get());
    EXPECT_EQ(error, RT_ERROR_COMMON_BASE);
    GlobalMockObject::verify();
}

TEST_F(EngineTest, SubmitPush_abort)
{
    std::unique_ptr<AsyncHwtsEngine> engine = std::make_unique<AsyncHwtsEngine>(device_);
    engine->Init();
    TaskInfo task = {};
    std::shared_ptr<Stream> stream = std::make_shared<Stream>(device_, 0);
    task.stream = stream.get();
    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    uint32_t flipTaskId = 1U;

    MOCKER_CPP_VIRTUAL(engine->GetScheduler(), &Scheduler::PushTask)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));
    stream->taskPublicBuffSize_ = STREAM_TO_FULL_CNT;
    stream->SetFailureMode(ABORT_ON_FAILURE);
    rtError_t error = engine->SubmitPush(&task, &flipTaskId);
    EXPECT_EQ(error, RT_ERROR_STREAM_FULL);
    GlobalMockObject::verify();
}

bool ProcessPublicTaskStub(Engine *engine, TaskInfo *workTask, const uint32_t deviceId, uint16_t *recycleTaskCount)
{
    workTask->stream->SetRecycleEndTaskId(1);
    return true;
}

TEST_F(EngineTest, ProcessTask_pciebar)
{
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device_);
    engine->Init();
    TaskInfo task = {};
    std::shared_ptr<Stream> stream = std::make_shared<Stream>(device_, 0);
    task.stream = stream.get();
    task.type = TS_TASK_TYPE_KERNEL_AICPU;

    uint16_t recyclePublicTaskCount = 0U;
    MOCKER_CPP(&Engine::ProcessPublicTask)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(invoke(ProcessPublicTaskStub));
    stream->SetIsSupportASyncRecycle(true);
    stream->SetRecycleEndTaskId(0);
    stream->SetIsHasPcieBarFlag(true);
    stream->taskResMang_ = new (std::nothrow) TaskResManage;
    MOCKER_CPP(&TaskResManage::RecycleTaskInfoOn)
        .stubs()
        .with(mockcpp::any())
        .will(returnValue(true));
    stream->isCtrlStream_ = false;

    bool ret = engine->ProcessTask(&task, 0U);
    EXPECT_EQ(ret, true);
    GlobalMockObject::verify();
}

class EngineTest1 : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"engine test1 start"<<std::endl;

    }

    static void TearDownTestCase()
    {
        std::cout<<"engine test1 start end"<<std::endl;

    }

    virtual void SetUp()
    {

    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

drvError_t drvGetPlatformInfo_offline_stub1(uint32_t *info)
{
    *info = RT_RUN_MODE_ONLINE;
    return DRV_ERROR_NONE;
}

TEST_F(EngineTest1, ReportSocketCloseProc_04)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_offline_stub1));
    int32_t hdcStat = static_cast<int32_t>(HDC_SESSION_STATUS_CLOSE);
    MOCKER_CPP(&Runtime::GetHdcConctStatus)
        .stubs()
        .with(mockcpp::any(), outBound(hdcStat))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Runtime::SetWatchDogDevStatus)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&TaskFailCallBackManager::Notify)
        .stubs();
    RawDevice *device = new RawDevice(0);
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device);
    engine->ReportSocketCloseProc();
    EXPECT_NE(engine->GetDevRunningState(), DEV_RUNNING_DOWN);
    device->SetDevStatus(RT_ERROR_NONE);
    const bool flag = Runtime::Instance()->GetDisableThread();
    Runtime::Instance()->SetDisableThread(true);
    engine->SetDevRunningState(DEV_RUNNING_NORMAL);
    Runtime::Instance()->SetDisableThread(flag);
    delete device;
}

static rtExceptionInfo_t stub_exceptionInfo;
void TaskFailCallBackNotify_stub(rtExceptionInfo_t *const exceptionInfo)
{
    stub_exceptionInfo = *exceptionInfo;
    return;
}

// hdc close, offline, call ReportStatusFailProc
TEST_F(EngineTest1, ReportSocketCloseProc_05)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_offline_stub));
    int32_t hdcStat = static_cast<int32_t>(HDC_SESSION_STATUS_CLOSE);
    MOCKER_CPP(&Runtime::GetHdcConctStatus)
        .stubs()
        .with(mockcpp::any(), outBound(hdcStat))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Runtime::SetWatchDogDevStatus)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER(TaskFailCallBackNotify).stubs().will(invoke(TaskFailCallBackNotify_stub));

    stub_exceptionInfo.retcode = 0U;  // init stub status
    RawDevice *device = new RawDevice(0);
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device);
    engine->ReportSocketCloseProc();
    EXPECT_EQ(stub_exceptionInfo.retcode, static_cast<uint32_t>(RT_TRANS_EXT_ERRCODE(RT_ERROR_SOCKET_CLOSE)));
    delete device;
}

// hdc close, online, don't call ReportStatusFailProc
TEST_F(EngineTest1, ReportSocketCloseProc_06)
{
    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_offline_stub1));
    int32_t hdcStat = static_cast<int32_t>(HDC_SESSION_STATUS_CLOSE);
    MOCKER_CPP(&Runtime::GetHdcConctStatus)
        .stubs()
        .with(mockcpp::any(), outBound(hdcStat))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Runtime::SetWatchDogDevStatus)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER(TaskFailCallBackNotify).stubs().will(invoke(TaskFailCallBackNotify_stub));

    stub_exceptionInfo.retcode = 0U;  // init stub status
    RawDevice *device = new RawDevice(0);
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device);
    engine->ReportSocketCloseProc();
    EXPECT_EQ(stub_exceptionInfo.retcode, 0U);
    delete device;
}
