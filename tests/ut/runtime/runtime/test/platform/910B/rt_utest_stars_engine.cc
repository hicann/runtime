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
#include "stars_engine.hpp"
#include "runtime.hpp"
#include "event.hpp"
#include "logger.hpp"
#include "raw_device.hpp"
#undef private
#undef protected
#include "scheduler.hpp"
#include "stars.hpp"
#include "hwts.hpp"
#include "npu_driver.hpp"
#include "context.hpp"
#include "device/device_error_proc.hpp"
#include "stream_sqcq_manage.hpp"
#include <map>
#include <utility>  // For std::pair and std::make_pair.
#include "rt_stars_define.h"
#include "thread_local_container.hpp"
#include "task_res.hpp"
#include "task_execute_time.h"
#include "model.hpp"
#include "stub_task.hpp"

using namespace testing;
using namespace cce::runtime;

namespace cce {
namespace runtime {
namespace {
constexpr uint32_t TS_SDMA_STATUS_DDRC_ERROR = 0x8U;
constexpr uint32_t TS_SDMA_STATUS_LINK_ERROR = 0x9U;
constexpr uint32_t TS_SDMA_STATUS_POISON_ERROR = 0xAU;
} // namespace

void ReportErrorInfoForModelExecuteTask(TaskInfo * const taskInfo, const uint32_t devId);
uint16_t GetAicpuKernelCredit(uint16_t timeout);
}
}

using std::pair;
using std::make_pair;

class CloudV2StarsEngineTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "StarsTaskTest SetUP" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "StarsTaskTest Tear Down" << std::endl;
    }

    virtual void SetUp()
    {
        Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver, &Driver::StreamBindLogicCq)
                .stubs()
                .will(returnValue(RT_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::StreamUnBindLogicCq)
                .stubs()
                .will(returnValue(RT_ERROR_NONE));

        bool enable = false;
        MOCKER_CPP_VIRTUAL(driver,
            &Driver::GetSqEnable).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(enable))
            .will(returnValue(RT_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::SetSqHead)
                .stubs()
                .will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP_VIRTUAL(driver, &Driver::EnableSq)
                .stubs()
                .will(returnValue(RT_ERROR_NONE));
        rtSetDevice(0);

        device_ = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
        engine_ = ((RawDevice *)device_)->engine_;
        rtError_t res = rtStreamCreate(&streamHandle_, 0);
        EXPECT_EQ(res, RT_ERROR_NONE);
        stream_ = (Stream *)streamHandle_;

        grp_ = new DvppGrp(device_, 0);
        rtDvppGrp_t grp_t = (rtDvppGrp_t *)grp_;
        rtError_t ret = rtStreamCreateByGrp(&streamHandleDvpp_, 0, 0, grp_t);
        streamDvpp_ = (Stream *)streamHandleDvpp_;
        streamDvpp_->SetLimitFlag(true);
        EXPECT_EQ(res, RT_ERROR_NONE);
    }

    virtual void TearDown()
    {
        if (stream_->GetPendingNum() > 0) {
            stream_->pendingNum_.Set(0U);
        }
        if (engine_->GetPendingNum() > 0) {
            engine_->pendingNum_.Set(0U);
        }
        rtStreamDestroy(streamHandle_);
        rtStreamDestroy(streamHandleDvpp_);
        delete grp_;
        stream_ = nullptr;
        streamDvpp_ = nullptr;
        engine_ = nullptr;
        ((Runtime *)Runtime::Instance())->DeviceRelease(device_);
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }

protected:
    Device *device_ = nullptr;
    Stream *stream_ = nullptr;
    Stream *streamDvpp_ = nullptr;
    Engine *engine_ = nullptr;
    DvppGrp *grp_ = nullptr;
    rtStream_t streamHandle_ = 0;
    rtStream_t streamHandleDvpp_ = 0;
};

TEST_F(CloudV2StarsEngineTest, StateDown)
{
    rtError_t error = RT_ERROR_NONE;
    TaskInfo task0 = {};
    task0.stream = stream_;
    AicTaskInit(&task0, 0, 1, 0, nullptr);
    EXPECT_EQ(task0.type, TS_TASK_TYPE_KERNEL_AICORE);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    const bool flag = rtInstance->GetDisableThread();
    rtInstance->SetDisableThread(true);
    device_->SetDevStatus(RT_ERROR_LOST_HEARTBEAT);
    error = engine_->SubmitTask(&task0);
    EXPECT_EQ(error, RT_ERROR_LOST_HEARTBEAT);
    device_->SetDevStatus(RT_ERROR_NONE);

    rtInstance->SetDisableThread(flag);
}

TEST_F(CloudV2StarsEngineTest, SubmitNormalTask_01)
{
    rtError_t error = RT_ERROR_NONE;
    TaskInfo task0 = {};
    task0.stream = stream_;
    AicTaskInit(&task0, 0, 1, 0, nullptr);
    EXPECT_EQ(task0.type, TS_TASK_TYPE_KERNEL_AICORE);

    MOCKER(WaitAsyncCopyComplete).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    error = engine_->SubmitTask(&task0);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(CloudV2StarsEngineTest, timeout1)
{
    Runtime::Instance()->timeoutConfig_.isInit = false;
    Runtime::Instance()->timeoutConfig_.interval = cce::runtime::RT_STARS_TASK_KERNEL_CREDIT_SCALE_US;
    uint16_t ret = GetAicpuKernelCredit(10 * 1000000UL);
    EXPECT_EQ(ret, 7);
}

TEST_F(CloudV2StarsEngineTest, SendingWaitProc)
{
    ((StarsEngine *)engine_)->SendingWaitProc(stream_);
    auto flag = stream_->GetRecycleFlag();
    EXPECT_EQ(flag, false);
}

TEST_F(CloudV2StarsEngineTest, SendingWaitStreamAbort)
{
    stream_->abortStatus_ = RT_ERROR_STREAM_ABORT;
    ((StarsEngine *)engine_)->SendingWaitProc(stream_);
    auto flag = stream_->GetRecycleFlag();
    EXPECT_EQ(flag, false);
    stream_->abortStatus_ = RT_ERROR_NONE;
}

TEST_F(CloudV2StarsEngineTest, SendingWait_dvpp)
{
    ((StarsEngine *)engine_)->SendingWaitProc(streamDvpp_);
    auto flag = streamDvpp_->GetLimitFlag();
    EXPECT_EQ(flag, false);
}

TEST_F(CloudV2StarsEngineTest, ProfilingEnableTask)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t taskId = 0;

    TaskInfo task = {};
    task.stream = stream_;
    task.type = TS_TASK_TYPE_PROFILING_ENABLE;

    rtStarsSqe_t sqe = {};
    RtStarsPhSqe &placeHolderSqe = sqe.phSqe;
    ToConstructSqe(&task, &sqe);
    // head task_type
    EXPECT_EQ(placeHolderSqe.task_type, 27);
}

TEST_F(CloudV2StarsEngineTest, ProfilingDisableTask)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t taskId = 0;

    TaskInfo task = {};
    task.stream = stream_;
    task.type = TS_TASK_TYPE_PROFILING_DISABLE;

    rtStarsSqe_t sqe = {};
    RtStarsPhSqe &placeHolderSqe = sqe.phSqe;

    ToConstructSqe(&task, &sqe);
    // head task_type
    EXPECT_EQ(placeHolderSqe.task_type, 28);
}

TEST_F(CloudV2StarsEngineTest, AddTaskToStream)
{
    rtError_t error;
    uint32_t sendSqeNum = 1;

    StarsEngine engine(device_);
    TaskInfo workTask = {};
    rtProfCfg_t profCfg = {};
    workTask.stream = stream_;
    ProfilingEnableTaskInit(&workTask, 1, &profCfg);

    MOCKER_CPP_VIRTUAL(stream_,
            &Stream::StarsAddTaskToStream).stubs().will(returnValue(1)).then(returnValue(0));
    error = engine.AddTaskToStream(&workTask, sendSqeNum);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2StarsEngineTest, AddTaskToStream2)
{
    rtError_t error;
    uint32_t sendSqeNum = 4096;

    StarsEngine engine(device_);
    TaskInfo workTask = {};
    stream_->SetBindFlag(true);
    workTask.stream = stream_;
    rtProfCfg_t profCfg = {};
    ProfilingEnableTaskInit(&workTask, 1, &profCfg);

    error = engine.AddTaskToStream(&workTask, sendSqeNum);
    EXPECT_EQ(error, RT_ERROR_STREAM_FULL);
    stream_->SetBindFlag(false);
}

TEST_F(CloudV2StarsEngineTest, SendTask)
{
    rtError_t err = RT_ERROR_NONE;
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    uint16_t taskId = 0;
    task.stream = stream_;
    stream_->SetAbortStatus(RT_ERROR_STREAM_ABORT);
    MOCKER_CPP(&Stream::IsTaskLimited).stubs().will(returnValue(false)).then(returnValue(false));
    err = engine_->SendTask(&task, taskId);
    EXPECT_EQ(err, RT_ERROR_STREAM_ABORT_SEND_TASK_FAIL);
    stream_->SetAbortStatus(RT_ERROR_NONE);
}

TEST_F(CloudV2StarsEngineTest, SendTaskFail)
{
    rtError_t err = RT_ERROR_NONE;
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    uint16_t taskId = 0;
    task.stream = stream_;
    stream_->Device_()->SetDevStatus(RT_ERROR_LOST_HEARTBEAT);
    stream_->SetLimitFlag(true);
    MOCKER_CPP_VIRTUAL(engine_, &Engine::TryRecycleTask).stubs().with(mockcpp::any()).will(returnValue(RT_ERROR_NONE));
    err = engine_->SendTask(&task, taskId);
    EXPECT_EQ(err, RT_ERROR_LOST_HEARTBEAT);
    stream_->SetLimitFlag(false);
    stream_->Device_()->SetDevStatus(RT_ERROR_NONE);
}

TEST_F(CloudV2StarsEngineTest, SendTaskDeviceAbort)
{
    rtError_t err = RT_ERROR_NONE;
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    uint16_t taskId = 0;
    task.stream = stream_;
    stream_->SetAbortStatus(RT_ERROR_DEVICE_TASK_ABORT);
    MOCKER_CPP(&Stream::IsTaskLimited).stubs().will(returnValue(false)).then(returnValue(false));
    err = engine_->SendTask(&task, taskId);
    EXPECT_EQ(err, RT_ERROR_DEVICE_ABORT_SEND_TASK_FAIL);
    stream_->SetAbortStatus(RT_ERROR_NONE);
}

TEST_F(CloudV2StarsEngineTest, SendTaskStreamAbort)
{
    rtError_t err = RT_ERROR_NONE;
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    uint16_t taskId = 0;
    task.stream = stream_;
    stream_->SetAbortStatus(RT_ERROR_STREAM_ABORT);
    MOCKER_CPP_VIRTUAL(engine_, &Engine::TryRecycleTask).stubs().with(mockcpp::any()).will(returnValue(RT_ERROR_STREAM_ABORT));
    err = engine_->SendTask(&task, taskId);
    EXPECT_EQ(err, RT_ERROR_STREAM_ABORT_SEND_TASK_FAIL);
    stream_->SetAbortStatus(RT_ERROR_NONE);
}

TEST_F(CloudV2StarsEngineTest, AddTaskToStream3)
{
    rtError_t error;
    uint32_t sendSqeNum = 4096;
    stream_->SetBeingAbortedFlag(true);
    StarsEngine engine(device_);
    TaskInfo workTask = {};
    workTask.stream = stream_;
    rtProfCfg_t profCfg = {};
    ProfilingEnableTaskInit(&workTask, 1, &profCfg);

    MOCKER_CPP_VIRTUAL(stream_,
            &Stream::StarsAddTaskToStream).stubs().will(returnValue(1)).then(returnValue(0));
    error = engine.AddTaskToStream(&workTask, sendSqeNum);
    EXPECT_EQ(error, RT_ERROR_STREAM_ABORT_SEND_TASK_FAIL);
    stream_->SetBeingAbortedFlag(false);
}

TEST_F(CloudV2StarsEngineTest, FinishedTaskReclaim)
{
    uint16_t taskHead = 100U;
    uint16_t sqHead = 200U;
    uint16_t recycleHead = 0U;
    uint32_t taskId = 1U;

    rtError_t error = ((StarsEngine *)engine_)->FinishedTaskReclaim(stream_, true, taskHead, sqHead, taskId);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    sqHead = 100U;
    error = ((StarsEngine *)engine_)->FinishedTaskReclaim(stream_, true, taskHead, sqHead, taskId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    taskHead = 0xffffU;
    sqHead = 0U;
    error = ((StarsEngine *)engine_)->FinishedTaskReclaim(stream_, true, taskHead, sqHead, taskId);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(CloudV2StarsEngineTest, FinishedTaskReclaim1)
{
    uint16_t taskHead = 100U;
    uint16_t sqHead = 200U;
    uint16_t recycleHead = 0U;
    uint32_t taskId = 1U;
    rtError_t error;
    for (uint32_t i = 0; i < 500; i++) {
        error = ((StarsEngine *)engine_)->FinishedTaskReclaim(stream_, true, taskHead, sqHead, taskId);
        EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    }

    sqHead = 100U;
    error = ((StarsEngine *)engine_)->FinishedTaskReclaim(stream_, true, taskHead, sqHead, taskId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    for (uint32_t i = 0; i < 500; i++) {
        taskHead = 0xffffU;
        sqHead = 0U;
        error = ((StarsEngine *)engine_)->FinishedTaskReclaim(stream_, true, taskHead, sqHead, taskId);
        EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    }
}

TEST_F(CloudV2StarsEngineTest, StartAndStopEngine)
{
    rtError_t error;

    StarsEngine engine(device_);

    error = engine.Init();
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = engine.Start();
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = engine.Stop();
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2StarsEngineTest, TaskReclaimByStreamId)
{
    rtError_t error;
    const uint32_t streamId = UINT32_MAX;
    const bool limited = true;
    uint32_t taskId = 0;

    StarsEngine engine(device_);

    error = engine.TaskReclaimByStreamId(streamId, limited, taskId);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2StarsEngineTest, TaskReclaim)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t taskId = 0;

    uint32_t recycleTaskId = 0;
    MOCKER_CPP(&StarsEngine::SendingProcReport).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(recycleTaskId))
        .will(returnValue(RT_ERROR_NONE));

    error = ((StarsEngine *)engine_)->TaskReclaim(0xffffffffU, true, taskId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = ((StarsEngine *)engine_)->TaskReclaim(stream_->Id_(), true, taskId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    stream_->SetFailureMode(ABORT_ON_FAILURE);
    error = ((StarsEngine *)engine_)->TaskReclaim(stream_->Id_(), true, taskId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2StarsEngineTest, MonitorTaskReclaim_01)
{
    rtError_t error;
    StarsEngine engine(device_);

    error = engine.MonitorTaskReclaim(0xFFFFU);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2StarsEngineTest, MonitorTaskReclaim_02)
{
    rtError_t error;
    StarsEngine engine(device_);
    device_->SetMonitorExitFlag(true);
    error = engine.MonitorTaskReclaim(0xFFFFU);
    EXPECT_EQ(error, RT_ERROR_TASK_MONITOR);
}

TEST_F(CloudV2StarsEngineTest, MonitorForWatchDog_01)
{
    rtError_t error;
    StarsEngine engine(device_);

    DeviceErrorProc *errorProc = new DeviceErrorProc(device_);
    EXPECT_NE(errorProc, nullptr);
    MOCKER_CPP_VIRTUAL((RawDevice *)device_, &RawDevice::ReportRingBuffer).stubs()
        .will(returnValue(RT_ERROR_NONE));
    engine.MonitorForWatchDog(device_);
    delete errorProc;
}

TEST_F(CloudV2StarsEngineTest, MonitorForWatchDog_03)
{
    rtError_t error;
    uint16_t streamId;
    StarsEngine engine(device_);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device_);
    EXPECT_NE(errorProc, nullptr);
    MOCKER_CPP_VIRTUAL((RawDevice *)device_, &RawDevice::ReportRingBuffer).stubs().will(returnValue(RT_ERROR_TASK_MONITOR));
    error = device_->ReportRingBuffer(&streamId);
    EXPECT_EQ(error, RT_ERROR_TASK_MONITOR);
    engine.MonitorForWatchDog(device_);
    delete errorProc;
}

TEST_F(CloudV2StarsEngineTest, SyncTask)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t taskId = 0;

    TaskInfo workTask = {};
    workTask.stream = stream_;
    rtProfCfg_t profCfg = {};
    ProfilingEnableTaskInit(&workTask, 1, &profCfg);

    stream_->SetAbortStatus(RT_ERROR_STREAM_ABORT);
    error = ((StarsEngine *)engine_)->SyncTask(stream_, 0, false, 1);
    EXPECT_EQ(error, RT_ERROR_STREAM_ABORT_SYNC_TASK_FAIL);

    stream_->SetAbortStatus(RT_ERROR_DEVICE_TASK_ABORT);
    stream_->Device_()->SetDeviceStatus(RT_ERROR_DEVICE_TASK_ABORT);
    error = ((StarsEngine *)engine_)->SyncTask(stream_, 0, false, 1);

    EXPECT_EQ(error, RT_ERROR_DEVICE_ABORT_SYNC_TASK_FAIL);
    stream_->Device_()->SetDeviceStatus(0);
    stream_->SetAbortStatus(0);
}

TEST_F(CloudV2StarsEngineTest, SyncTask_with_async_recycle_thread)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t taskId = 0;

    TaskInfo workTask = {};
    workTask.stream = stream_;
    stream_->Device_()->SetIsChipSupportRecycleThread(true);
    rtProfCfg_t profCfg = {};
    ProfilingEnableTaskInit(&workTask, 1, &profCfg);


    stream_->SetAbortStatus(RT_ERROR_STREAM_ABORT);
    error = ((StarsEngine *)engine_)->SyncTask(stream_, 0, false, 10);
    EXPECT_EQ(error, RT_ERROR_STREAM_ABORT_SYNC_TASK_FAIL);

    stream_->SetAbortStatus(RT_ERROR_DEVICE_TASK_ABORT);
    stream_->Device_()->SetDeviceStatus(RT_ERROR_DEVICE_TASK_ABORT);
    error = ((StarsEngine *)engine_)->SyncTask(stream_, 0, false, 10);

    EXPECT_EQ(error, RT_ERROR_DEVICE_ABORT_SYNC_TASK_FAIL);
    stream_->Device_()->SetDeviceStatus(0);
    stream_->SetAbortStatus(0);
    stream_->Device_()->SetIsChipSupportRecycleThread(false);
}
TEST_F(CloudV2StarsEngineTest, ProcessHeadTaskByStreamId_01)
{
    rtError_t error;
    uint32_t sendSqeNum = 1;

    TaskInfo * const tsk = device_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_PROFILING_ENABLE, error);
    rtProfCfg_t profCfg = {};
    ProfilingEnableTaskInit(tsk, 1, &profCfg);
    ((StarsEngine *)engine_)->AddTaskToStream(tsk, sendSqeNum);

    device_->GetTaskFactory()->SetSerialId(stream_, tsk);
    tsk->pkgStat[static_cast<uint16_t>(RT_PACKAGE_TYPE_TASK_REPORT)].receivePackage++;

    uint16_t stream_id = stream_->Id_();
    stream_->SetSyncRemainTime(5);
    error = ((StarsEngine *)engine_)->ProcessHeadTaskByStreamId(stream_id);
    EXPECT_EQ(error, RT_ERROR_TASK_NULL);

}

TEST_F(CloudV2StarsEngineTest, ProcessHeadTaskByStreamId_02)
{
    rtError_t error;
    uint32_t sendSqeNum = 1;

    TaskInfo * const tsk = device_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_MODEL_EXECUTE, error);
    ModelExecuteTaskInit(tsk, nullptr, 0, 0);

    ((StarsEngine *)engine_)->AddTaskToStream(tsk, sendSqeNum);

    uint16_t stream_id = stream_->Id_();
    error = ((StarsEngine *)engine_)->ProcessHeadTaskByStreamId(stream_id);
    EXPECT_EQ(error, RT_ERROR_TASK_NULL);
}

TEST_F(CloudV2StarsEngineTest, ProcessHeadTaskByStreamId_03)
{
    rtError_t error;
    uint32_t sendSqeNum = 1;

    TaskInfo * tsk = device_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_MODEL_EXECUTE, error);
    tsk->errorCode = 0x221;
    tsk->mte_error = 0x221;
    ModelExecuteTaskInit(tsk, nullptr, 0, 0);

    ((StarsEngine *)engine_)->AddTaskToStream(tsk, sendSqeNum);

    uint16_t stream_id = stream_->Id_();
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .with(mockcpp::any(), mockcpp::any())
        .will(returnValue(tsk));
    MOCKER(&ReportErrorInfoForModelExecuteTask)
        .stubs();
    error = ((StarsEngine *)engine_)->ProcessHeadTaskByStreamId(stream_id);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2StarsEngineTest, ProcessHeadTaskByStreamId_04)
{
    rtError_t error;
    uint32_t sendSqeNum = 1;

    TaskInfo * tsk = device_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_MODEL_EXECUTE, error);
    tsk->errorCode = 0x220;
    tsk->mte_error = 0x220;
    ModelExecuteTaskInit(tsk, nullptr, 0, 0);

    ((StarsEngine *)engine_)->AddTaskToStream(tsk, sendSqeNum);

    uint16_t stream_id = stream_->Id_();
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .with(mockcpp::any(), mockcpp::any())
        .will(returnValue(tsk));
    MOCKER(&ReportErrorInfoForModelExecuteTask)
        .stubs();
    error = ((StarsEngine *)engine_)->ProcessHeadTaskByStreamId(stream_id);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2StarsEngineTest, ProcessHeadTaskByStreamId_05)
{
    rtError_t error;
    uint32_t sendSqeNum = 1;

    TaskInfo * tsk = device_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_MODEL_EXECUTE, error);
    tsk->errorCode = 0x58;
    tsk->mte_error = 0x58;
    ModelExecuteTaskInit(tsk, nullptr, 0, 0);

    ((StarsEngine *)engine_)->AddTaskToStream(tsk, sendSqeNum);

    uint16_t stream_id = stream_->Id_();
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .with(mockcpp::any(), mockcpp::any())
        .will(returnValue(tsk));
    MOCKER(&ReportErrorInfoForModelExecuteTask)
        .stubs();
    error = ((StarsEngine *)engine_)->ProcessHeadTaskByStreamId(stream_id);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2StarsEngineTest, ProcessHeadTaskByStreamId_06)
{
    rtError_t error;
    uint32_t sendSqeNum = 1;

    TaskInfo * tsk = device_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_MODEL_EXECUTE, error);
    tsk->errorCode = 0x57;
    tsk->mte_error = 0x57;
    ModelExecuteTaskInit(tsk, nullptr, 0, 0);

    ((StarsEngine *)engine_)->AddTaskToStream(tsk, sendSqeNum);

    uint16_t stream_id = stream_->Id_();
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .with(mockcpp::any(), mockcpp::any())
        .will(returnValue(tsk));
    MOCKER(&ReportErrorInfoForModelExecuteTask)
        .stubs();
    error = ((StarsEngine *)engine_)->ProcessHeadTaskByStreamId(stream_id);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2StarsEngineTest, buffAllocer_t)
{
    BufferAllocator alloc(4, 1024, 5*1024*1024, BufferAllocator::EXPONENTIAL);
    BufferAllocator::OpenHugeBuff();

    for (uint32_t i = 0; i < 5*1024*1024 + 1; i++) {
        int32_t id = alloc.AllocId();
        void *ptr = alloc.GetItemById(id);
        if (id == 4*1024*1024 - 1) {
            printf("This is a keypoint\r\n");
        }

        if (id < 0) {
            break;
        }
    }
}

TEST_F(CloudV2StarsEngineTest, ProcLogicCqReport)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t taskId = 0;

    rtLogicCqReport_t logicCq = {0};
    logicCq.errorType = (RT_STARS_EXIST_ERROR | RT_STARS_EXIST_WARNING);
    TaskInfo * const workTask = device_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_MODEL_EXECUTE, error);
    ModelExecuteTaskInit(workTask, nullptr, 0, 0);
    device_->GetTaskFactory()->SetSerialId(stream_, workTask);
    logicCq.taskId = workTask->id;
    logicCq.streamId = workTask->stream->Id_();
    workTask->mte_error = 0x221;

    ((StarsEngine *)engine_)->ProcLogicCqReport(logicCq, false, nullptr);
    logicCq.errorCode = 0x221;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    ((StarsEngine *)engine_)->ProcLogicCqReport(logicCq, false, nullptr);
    logicCq.errorCode = 0x2F;
    bool reterr = device_->GetHasTaskError();
    device_->SetHasTaskError(true);
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    ((StarsEngine *)engine_)->ProcLogicCqReport(logicCq, false, nullptr);
    device_->SetHasTaskError(reterr);
    logicCq.errorCode = 0x33;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    logicCq.errorCode = 0x34;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    logicCq.errorCode = 0x35;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    logicCq.errorCode = 0x97;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    logicCq.errorCode = 0x205a0000;
    logicCq.sqeType = 7;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    logicCq.errorCode = 0x105a0000;
    logicCq.sqeType = 7;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    logicCq.errorCode = 0x95;
    logicCq.sqeType = 5;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);

    TaskInfo * const workTask1 = device_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_GET_STARS_VERSION, error);
    StarsVersionTaskInit(workTask1);
    device_->GetTaskFactory()->SetSerialId(stream_, workTask1);

    logicCq.errorCode = 16;
    logicCq.sqeType = 3;
    auto ret = ((StarsEngine *)engine_)->ProcReportIsException(logicCq, workTask1);
    EXPECT_EQ(ret, false);
}

TEST_F(CloudV2StarsEngineTest, ProcLogicCqReport_with_async_recycle_thread)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t taskId = 0;

    device_->SetIsChipSupportRecycleThread(true);
    rtLogicCqReport_t logicCq = {0};
    logicCq.errorType = (RT_STARS_EXIST_ERROR | RT_STARS_EXIST_WARNING);
    cce::runtime::Model model;
    TaskInfo *reportTask = stream_->taskResMang_->AllocTaskInfoByTaskResId(stream_, 0, 0, TS_TASK_TYPE_MODEL_EXECUTE);
    ModelExecuteTaskInit(reportTask, &model, 0, 0);
    logicCq.taskId = reportTask->id;
    logicCq.streamId = reportTask->stream->Id_();
    reportTask->mte_error = 0x221;

    ((StarsEngine *)engine_)->ProcLogicCqReport(logicCq, false, reportTask);
    logicCq.errorCode = 0x221;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    ((StarsEngine *)engine_)->ProcLogicCqReport(logicCq, false, reportTask);
    logicCq.errorCode = 0x2F;
    bool reterr = device_->GetHasTaskError();
    device_->SetHasTaskError(true);
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    ((StarsEngine *)engine_)->ProcLogicCqReport(logicCq, false, reportTask);
    device_->SetHasTaskError(reterr);
    logicCq.errorCode = 0x33;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    logicCq.errorCode = 0x34;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    logicCq.errorCode = 0x35;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    logicCq.errorCode = 0x97;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    logicCq.errorCode = 0x205a0000;
    logicCq.sqeType = 7;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    logicCq.errorCode = 0x105a0000;
    logicCq.sqeType = 7;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    logicCq.errorCode = 0x95;
    logicCq.sqeType = 5;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);

    TaskInfo * const workTask1 = device_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_GET_STARS_VERSION, error);
    StarsVersionTaskInit(workTask1);
    device_->GetTaskFactory()->SetSerialId(stream_, workTask1);

    logicCq.errorCode = 16;
    logicCq.sqeType = 3;
    auto ret = ((StarsEngine *)engine_)->ProcReportIsException(logicCq, workTask1);
    EXPECT_EQ(ret, false);

    device_->SetIsChipSupportRecycleThread(false);
}

TEST_F(CloudV2StarsEngineTest, ProcLogicCqReport_with_limit_flag)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t taskId = 0;

    device_->SetIsChipSupportRecycleThread(false);
    stream_->SetLimitFlag(true);
    rtLogicCqReport_t logicCq = {0};
    logicCq.errorType = (RT_STARS_EXIST_ERROR | RT_STARS_EXIST_WARNING);
    cce::runtime::Model model;
    TaskInfo *reportTask = stream_->taskResMang_->AllocTaskInfoByTaskResId(stream_, 0, 0, TS_TASK_TYPE_MODEL_EXECUTE);
    ModelExecuteTaskInit(reportTask, &model, 0, 0);
    logicCq.taskId = reportTask->id;
    logicCq.streamId = reportTask->stream->Id_();
    reportTask->mte_error = 0x221;

    ((StarsEngine *)engine_)->ProcLogicCqReport(logicCq, false, reportTask);
    logicCq.errorCode = 0x221;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    ((StarsEngine *)engine_)->ProcLogicCqReport(logicCq, false, reportTask);
    logicCq.errorCode = 0x2F;
    bool reterr = device_->GetHasTaskError();
    device_->SetHasTaskError(true);
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    ((StarsEngine *)engine_)->ProcLogicCqReport(logicCq, false, reportTask);
    device_->SetHasTaskError(reterr);
    logicCq.errorCode = 0x33;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    logicCq.errorCode = 0x34;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    logicCq.errorCode = 0x35;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    logicCq.errorCode = 0x97;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    logicCq.errorCode = 0x205a0000;
    logicCq.sqeType = 7;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    logicCq.errorCode = 0x105a0000;
    logicCq.sqeType = 7;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);
    logicCq.errorCode = 0x95;
    logicCq.sqeType = 5;
    ((StarsEngine *)engine_)->ProcReportIsException(logicCq);

    TaskInfo * const workTask1 = device_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_GET_STARS_VERSION, error);
    StarsVersionTaskInit(workTask1);
    device_->GetTaskFactory()->SetSerialId(stream_, workTask1);

    logicCq.errorCode = 16;
    logicCq.sqeType = 3;
    auto ret = ((StarsEngine *)engine_)->ProcReportIsException(logicCq, workTask1);
    EXPECT_EQ(ret, false);

    device_->SetIsChipSupportRecycleThread(true);
    stream_->SetLimitFlag(false);
}

TEST_F(CloudV2StarsEngineTest, GetLastTaskIdFromRtsq)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t taskId = 0;

    error = stream_->GetLastTaskIdFromRtsq(taskId);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    Device *devicetmp = stream_->device_;
    stream_->device_ = nullptr;
    error = stream_->GetLastTaskIdFromRtsq(taskId);
    stream_->device_ = devicetmp;
    devicetmp = nullptr;
}

TEST_F(CloudV2StarsEngineTest, TryRecycleTask)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t taskId = 0;

    TaskInfo workTask = {};
    workTask.stream = stream_;
    ((StarsEngine *)engine_)->AddTaskToStream(&workTask, 1024);
    error = ((StarsEngine *)engine_)->TryRecycleTask(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2StarsEngineTest, TryRecycleTaskStreamAbort)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t taskId = 0;

    TaskInfo workTask = {};
    workTask.stream = stream_;
    ((StarsEngine *)engine_)->AddTaskToStream(&workTask, 1024);
    stream_->abortStatus_ = RT_ERROR_STREAM_ABORT;
    stream_->pendingNum_.Set(1U);
    MOCKER_CPP_VIRTUAL(stream_, &Stream::IsSeparateSendAndRecycle).stubs().will(returnValue(false));
    error = ((StarsEngine *)engine_)->TryRecycleTask(stream_);
    EXPECT_EQ(error, RT_ERROR_STREAM_ABORT);
    stream_->abortStatus_ = RT_ERROR_NONE;
    stream_->pendingNum_.Set(0U);
}

TEST_F(CloudV2StarsEngineTest, MaintenanceTask)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t taskId = 0;
    MOCKER_CPP_VIRTUAL(stream_, &Stream::IsSeparateSendAndRecycle).stubs().with(mockcpp::any()).will(returnValue(false));
    // MaintenanceTask
    TaskInfo task = {};
    task.stream = stream_;
    MaintenanceTaskInit(&task, MT_STREAM_DESTROY, 0, 0);

    rtStarsSqe_t sqe = {};
    RtStarsPhSqe &placeHolderSqe = sqe.phSqe;
    ToConstructSqe(&task, &sqe);
    // head check
    EXPECT_EQ(placeHolderSqe.rt_streamID, (0x8000 | stream_->Id_()));
}

TEST_F(CloudV2StarsEngineTest, RecycleEventRecordTask)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t sendSqeNum = 1;

    TaskInfo * const workTask = device_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_EVENT_RECORD, error);
    Event *evt = new (std::nothrow) Event(device_, 0x14, nullptr);
    EventRecordTaskInit(workTask, evt, false, evt->EventId_());
    device_->GetTaskFactory()->SetSerialId(stream_, workTask);
    workTask->u.eventRecordTaskInfo.waitCqflag = false;
    workTask->isCqeNeedConcern = true;
    rtStarsSqe_t sqe = {};
    RtStarsEventSqe &eventSqe = sqe.eventSqe;

    std::pair<uint32_t, uint32_t> taskInfo;
    taskInfo.first = 12;
    taskInfo.second = 0;

    ToConstructSqe(workTask, &sqe);
    workTask->stream = stream_;
    stream_->SetSyncRemainTime(5);

    ((StarsEngine *)engine_)->AddTaskToStream(workTask, sendSqeNum);

    rtLogicCqReport_t logicCq = {};
    logicCq.streamId = stream_->Id_();
    logicCq.taskId = workTask->id;
    logicCq.errorType = 0x80U;

    ((StarsEngine *)engine_)->StarsCqeReceive(logicCq, workTask);

    uint16_t recycleTaskNum = 0;
    ((StarsEngine *)engine_)->ProcessPublicTask(workTask, 0, &recycleTaskNum);

    TaskInfo * tsk = device_->GetTaskFactory()->GetTask(logicCq.streamId, logicCq.taskId);
    EXPECT_EQ(true, tsk == nullptr);
    delete evt;
}

TEST_F(CloudV2StarsEngineTest, RecycleEventRecordTask_01)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t sendSqeNum = 1;

    TaskInfo * const workTask = device_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_EVENT_RECORD, error);
    Event *evt = new (std::nothrow) Event(device_, 0x14, nullptr);
    EventRecordTaskInit(workTask, evt, false, evt->EventId_());
    device_->GetTaskFactory()->SetSerialId(stream_, workTask);
    workTask->u.eventRecordTaskInfo.waitCqflag = false;
    workTask->isCqeNeedConcern = true;
    rtStarsSqe_t sqe = {};
    RtStarsEventSqe &eventSqe = sqe.eventSqe;

    std::pair<uint32_t, uint32_t> taskInfo;
    taskInfo.first = 12;
    taskInfo.second = 0;

    ToConstructSqe(workTask, &sqe);
    workTask->stream = stream_;
    stream_->SetSyncRemainTime(5);

    ((StarsEngine *)engine_)->AddTaskToStream(workTask, sendSqeNum);

    rtLogicCqReport_t logicCq = {};
    logicCq.streamId = stream_->Id_();
    logicCq.taskId = workTask->id;
    logicCq.errorType = 0x80U;

    ((StarsEngine *)engine_)->StarsCqeReceive(logicCq, workTask);

    uint16_t recycleTaskNum = 0;
    ((StarsEngine *)engine_)->ProcessPublicTask(workTask, 0, &recycleTaskNum);

    TaskInfo * tsk = device_->GetTaskFactory()->GetTask(logicCq.streamId, logicCq.taskId);
    EXPECT_EQ(true, tsk == nullptr);
    uint64_t time = 0ULL;
    error = evt->GetTimeStamp(&time);
    delete evt;
}

TEST_F(CloudV2StarsEngineTest, SyncTaskCheckResult)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t sendSqeNum = 1;

    TaskInfo * const workTask = device_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_EVENT_RECORD, error);
    EventRecordTaskInit(workTask, nullptr, false, INVALID_EVENT_ID);
    device_->GetTaskFactory()->SetSerialId(stream_, workTask);
    workTask->u.eventRecordTaskInfo.waitCqflag = false;
    workTask->isCqeNeedConcern = true;
    rtStarsSqe_t sqe = {};
    RtStarsEventSqe &eventSqe = sqe.eventSqe;

    Event recorder(device_, 0x14, nullptr);
    workTask->u.eventRecordTaskInfo.event = &recorder;
    std::pair<uint32_t, uint32_t> taskInfo;
    taskInfo.first = 12;
    taskInfo.second = 0;


    ToConstructSqe(workTask, &sqe);
    workTask->stream = stream_;
    stream_->SetSyncRemainTime(5);
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .will(returnValue(workTask));
    ((StarsEngine *)engine_)->AddTaskToStream(workTask, sendSqeNum);
    ((StarsEngine *)engine_)->SyncTaskCheckResult(RT_ERROR_NONE, stream_, workTask->id);
    EXPECT_EQ(true, workTask->isCqeNeedConcern == true);
    ((StarsEngine *)engine_)->SyncTaskCheckResult(RT_ERROR_STREAM_SYNC_TIMEOUT, stream_, workTask->id);
    EXPECT_EQ(true, workTask->isCqeNeedConcern == false);

    rtLogicCqReport_t logicCq = {};
    logicCq.streamId = stream_->Id_();
    logicCq.taskId = workTask->id;
    logicCq.errorType = 0x80U;

    ((StarsEngine *)engine_)->StarsCqeReceive(logicCq, workTask);

    uint16_t recycleTaskNum = 0;
    ((StarsEngine *)engine_)->ProcessPublicTask(workTask, 0, &recycleTaskNum);
    GlobalMockObject::verify();
    TaskInfo * tsk = device_->GetTaskFactory()->GetTask(logicCq.streamId, logicCq.taskId);
    EXPECT_EQ(true, tsk == nullptr);
}

TEST_F(CloudV2StarsEngineTest, ProcReportIsVpcErrorAndRetry)
{
    bool rt;
    StarsEngine *engine = (StarsEngine *)engine_;
    rtLogicCqReport_t cqReport = {};

    // not vpc task
    cqReport.sqeType = 0;
    rt = engine->ProcReportIsVpcErrorAndRetry(cqReport);
    EXPECT_EQ(rt, false);

    // vpc task, no error
    cqReport.sqeType = RT_STARS_SQE_TYPE_VPC;
    rt = engine->ProcReportIsVpcErrorAndRetry(cqReport);
    EXPECT_EQ(rt, false);

    // vpc task, sqe error
    cqReport.errorType = RT_STARS_CQE_ERR_TYPE_SQE_ERROR;
    rt = engine->ProcReportIsVpcErrorAndRetry(cqReport);
    EXPECT_EQ(rt, false);

    cqReport.errorType = RT_STARS_CQE_ERR_TYPE_EXCEPTION;
    rt = engine->ProcReportIsVpcErrorAndRetry(cqReport);
    EXPECT_EQ(rt, false);

    rtError_t error = RT_ERROR_NONE;
    TaskInfo * const tsk = device_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_STARS_COMMON, error);

    device_->GetTaskFactory()->SetSerialId(stream_, tsk);
    cqReport.errorType = RT_STARS_CQE_ERR_TYPE_EXCEPTION;
    cqReport.streamId = tsk->stream->Id_();
    cqReport.taskId = tsk->id;
    rt = engine->ProcReportIsVpcErrorAndRetry(cqReport);
    EXPECT_EQ(rt, false);
    (void)device_->GetTaskFactory()->Recycle(tsk);
}

void testDvppGrpCallbackFunc(rtDvppGrpRptInfo_t *report)
{
    std::cout << "streamId=" << report->streamId << " taskId=" << report->taskId << " sqeType=" << report->sqeType
              << std::endl;
}

TEST_F(CloudV2StarsEngineTest, DvppWaitGroup)
{
    DvppGrp *grp = new DvppGrp(device_, 0);
    rtError_t error = device_->DvppWaitGroup(grp, testDvppGrpCallbackFunc, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete grp;
}

TEST_F(CloudV2StarsEngineTest, GetLastFinishTaskId)
{
    uint32_t recycleTaskId = 0;
    MOCKER_CPP(&StarsEngine::SendingProcReport).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(recycleTaskId))
        .will(returnValue(RT_ERROR_NONE));

    rtError_t error = stream_->WaitTask(false, stream_->lastTaskId_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(CloudV2StarsEngineTest, WaitTask)
{
    uint32_t recycleTaskId = 0;
    MOCKER_CPP(&StarsEngine::SendingProcReport).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(recycleTaskId))
    .will(returnValue(RT_ERROR_NONE));
    stream_->Context_()->SetFailureError(2);
    stream_->failureMode_ = STOP_ON_FAILURE;
    TsStreamFailureMode flag = stream_->Context_()->GetCtxMode();
    stream_->Context_()->SetCtxMode(STOP_ON_FAILURE);
    rtError_t error = stream_->WaitTask(true, 2);
    EXPECT_EQ(error, 2);
    stream_->Context_()->SetCtxMode(flag);
    stream_->Context_()->SetFailureError(0);
}

TEST_F(CloudV2StarsEngineTest, WaitTask_DEV_RUNNING_DOWN)
{
    uint32_t recycleTaskId = 0;
    MOCKER_CPP(&StarsEngine::SendingProcReport).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(recycleTaskId))
    .will(returnValue(RT_ERROR_NONE));
    stream_->Context_()->SetFailureError(2);

    Device* dev = stream_->Device_();
    dev->SetDevStatus(RT_ERROR_LOST_HEARTBEAT);
    rtError_t error = stream_->WaitTask(true, 2);
    EXPECT_EQ(error, RT_ERROR_LOST_HEARTBEAT);
    dev->SetDevStatus(RT_ERROR_NONE);

    stream_->Context_()->SetFailureError(0);
}

TEST_F(CloudV2StarsEngineTest, WaitTask_StreamAbort)
{
    uint32_t recycleTaskId = 0;
    MOCKER_CPP(&StarsEngine::SendingProcReport).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(recycleTaskId))
    .will(returnValue(RT_ERROR_NONE));
    stream_->SetAbortStatus(RT_ERROR_STREAM_ABORT);
    rtError_t error = stream_->WaitTask(true, 2);
    EXPECT_EQ(error, RT_ERROR_STREAM_ABORT);
    stream_->SetAbortStatus(0);
}

TEST_F(CloudV2StarsEngineTest, WaitTaskabort)
{
    uint32_t recycleTaskId = 0;
    MOCKER_CPP(&StarsEngine::SendingProcReport).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(recycleTaskId))
    .will(returnValue(RT_ERROR_NONE));
    stream_->Device_()->SetDeviceStatus(RT_ERROR_DEVICE_TASK_ABORT);
    rtError_t error = stream_->GetSynchronizeError(0U);
    EXPECT_EQ(error, RT_ERROR_DEVICE_TASK_ABORT);
    stream_->Device_()->SetDeviceStatus(0);
}

TEST_F(CloudV2StarsEngineTest, QueryWaitTask)
{
    bool isWaitFlag = false;
    rtError_t error = stream_->QueryWaitTask(isWaitFlag, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2StarsEngineTest, MultipleTaskReportLogicCq_01)
{
    uint32_t sendSqeNum = 1;
    rtError_t error;
    // DavinciMultipleTask
    TaskInfo * const tsk = device_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_MULTIPLE_TASK, error);
    ((StarsEngine *)engine_)->AddTaskToStream(tsk, sendSqeNum);
    device_->GetTaskFactory()->SetSerialId(stream_, tsk);
    rtMultipleTaskInfo_t multipleTaskInfo;
    multipleTaskInfo.taskNum = 2;
    multipleTaskInfo.taskDesc = new rtTaskDesc_t[2];
    error = DavinciMultipleTaskInit(tsk, &multipleTaskInfo, 0U);
    EXPECT_EQ(error, RT_ERROR_NONE);

    IncMultipleTaskCqeNum(tsk);
    IncMultipleTaskCqeNum(tsk);
    tsk->u.davinciMultiTaskInfo.hasUnderstudyTask = true;
    uint16_t stream_id = stream_->Id_();
    rtLogicCqReport_t cqe = {0};
    cqe.streamId = stream_id;
    cqe.taskId = tsk->id;
    cqe.sqeType = RT_STARS_SQE_TYPE_JPEGD;
    std::cout<<"MultipleTaskReportLogicCq_01 call MultipleTaskReportLogicCq"<<std::endl;
    ((StarsEngine *)engine_)->MultipleTaskReportLogicCq(tsk, cqe, testDvppGrpCallbackFunc);
    std::cout<<"MultipleTaskReportLogicCq_01 call end"<<std::endl;

    TaskUnInitProc(tsk);
    delete[] multipleTaskInfo.taskDesc;
}

TEST_F(CloudV2StarsEngineTest, ProcMultipleTaskLogicCqReport_02)
{
    bool isStreamSync = false;
    rtError_t error;
    rtMultipleTaskInfo_t multipleTaskInfo;
    multipleTaskInfo.taskNum = 2;
    multipleTaskInfo.taskDesc = new rtTaskDesc_t[multipleTaskInfo.taskNum];

    // DaviDavinciMultipleTask
    TaskInfo mulTipleTask = {};
    mulTipleTask.stream = stream_;
    error = DavinciMultipleTaskInit(&mulTipleTask, &multipleTaskInfo, 0x40U);
    EXPECT_EQ(error, RT_ERROR_NONE);
    IncMultipleTaskCqeNum(&mulTipleTask);
    IncMultipleTaskCqeNum(&mulTipleTask);
    mulTipleTask.u.davinciMultiTaskInfo.hasUnderstudyTask = true;


    rtLogicCqReport_t cqe = {0};
    cqe.streamId = 1;
    cqe.taskId = 1;
    cqe.sqeType = RT_STARS_SQE_TYPE_JPEGD;
    std::cout<<"ProcMultipleTaskLogicCqReport_02 call ProcMultipleTaskLogicCqReport1"<<std::endl;
    ((StarsEngine *)engine_)->ProcMultipleTaskLogicCqReport(&mulTipleTask, cqe, isStreamSync);
    std::cout<<"ProcMultipleTaskLogicCqReport_02 call 1 end"<<std::endl;
    TaskUnInitProc(&mulTipleTask);
    delete[] multipleTaskInfo.taskDesc;
}

TEST_F(CloudV2StarsEngineTest, ProcMultipleTaskLogicCqReport_03)
{
    bool isStreamSync = false;
    rtMultipleTaskInfo_t multipleTaskInfo;
    multipleTaskInfo.taskNum = 2;
    multipleTaskInfo.taskDesc = new rtTaskDesc_t[multipleTaskInfo.taskNum];

    // DaviDavinciMultipleTask
    TaskInfo mulTipleTask = {};
    mulTipleTask.stream = stream_;
    rtError_t error = DavinciMultipleTaskInit(&mulTipleTask, &multipleTaskInfo, 0U);
    EXPECT_EQ(error, RT_ERROR_NONE);
    IncMultipleTaskCqeNum(&mulTipleTask);
    IncMultipleTaskCqeNum(&mulTipleTask);
    mulTipleTask.u.davinciMultiTaskInfo.hasUnderstudyTask = true;

    StarsEngine engine(device_);

    rtLogicCqReport_t cqe = {0};
    cqe.streamId = 1;
    cqe.taskId = 1;
    cqe.sqeType = RT_STARS_SQE_TYPE_AICPU;
    cqe.errorType = 0xFF;
    std::cout<<"ProcMultipleTaskLogicCqReport_03 call ProcMultipleTaskLogicCqReport"<<std::endl;
    MOCKER_CPP(&StarsEngine::ProcLogicCqReport).stubs().will(ignoreReturnValue());
    engine.ProcMultipleTaskLogicCqReport(&mulTipleTask, cqe, isStreamSync);
    std::cout<<"ProcMultipleTaskLogicCqReport_03 call end"<<std::endl;
    TaskUnInitProc(&mulTipleTask);
    delete[] multipleTaskInfo.taskDesc;
}

TEST_F(CloudV2StarsEngineTest, ClearcMulTaskCqeNum_01)
{
    rtMultipleTaskInfo_t multipleTaskInfo;
    multipleTaskInfo.taskNum = 2;
    multipleTaskInfo.taskDesc = new rtTaskDesc_t[multipleTaskInfo.taskNum];

    // DaviDavinciMultipleTask
    TaskInfo mulTipleTask = {};
    mulTipleTask.stream = stream_;
    rtError_t error = DavinciMultipleTaskInit(&mulTipleTask, &multipleTaskInfo, 0U);
    EXPECT_EQ(error, RT_ERROR_NONE);
    IncMultipleTaskCqeNum(&mulTipleTask);
    IncMultipleTaskCqeNum(&mulTipleTask);
    mulTipleTask.u.davinciMultiTaskInfo.hasUnderstudyTask = true;

    StarsEngine engine(device_);
    uint8_t mulTaskCqeNum = 0;
    engine.ClearMulTaskCqeNum(mulTaskCqeNum, &mulTipleTask);
    mulTaskCqeNum = multipleTaskInfo.taskNum;
    engine.ClearMulTaskCqeNum(mulTaskCqeNum, &mulTipleTask);
    TaskUnInitProc(&mulTipleTask);
    delete[] multipleTaskInfo.taskDesc;
}

TEST_F(CloudV2StarsEngineTest, CompleteProcMultipleTaskReport_01)
{
    rtMultipleTaskInfo_t multipleTaskInfo;
    multipleTaskInfo.taskNum = 2U;
    multipleTaskInfo.taskDesc = new rtTaskDesc_t[multipleTaskInfo.taskNum];

    // DaviDavinciMultipleTask
    TaskInfo mulTipleTask = {};
    mulTipleTask.stream = stream_;
    rtError_t error = DavinciMultipleTaskInit(&mulTipleTask, &multipleTaskInfo, 0U);
    EXPECT_EQ(error, RT_ERROR_NONE);
    IncMultipleTaskCqeNum(&mulTipleTask);
    IncMultipleTaskCqeNum(&mulTipleTask);
    mulTipleTask.u.davinciMultiTaskInfo.hasUnderstudyTask = true;
    StarsEngine engine(device_);

    rtLogicCqReport_t cqe = {0};
    cqe.streamId = 1U;
    cqe.taskId = 1U;
    cqe.sqeType = RT_STARS_SQE_TYPE_AICPU;
    cqe.errorType = 0xFFU;
    engine.CompleteProcMultipleTaskReport(&mulTipleTask, cqe);

    TaskUnInitProc(&mulTipleTask);
    delete[] multipleTaskInfo.taskDesc;
}

TEST_F(CloudV2StarsEngineTest, ProcLogicCqUntilEmpty_test)
{
    Stream * const stm = stream_;
    StarsEngine engine(device_);

    MOCKER_CPP_VIRTUAL(device_->Driver_(), &Driver::LogicCqReportV2)
        .stubs()
        .will(returnValue(RT_ERROR_LOST_HEARTBEAT));
    MOCKER_CPP(&Engine::ReportHeartBreakProcV2)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    uint32_t taskId = 0U;
    rtError_t error = engine.ProcLogicCqUntilEmpty(stm, taskId);
    EXPECT_EQ(error, RT_ERROR_STREAM_EMPTY);
    GlobalMockObject::reset();
}

TEST_F(CloudV2StarsEngineTest, ProcLogicCqUntilEmpty_OneLogicReport)
{
    Stream * const stm = stream_;
    StarsEngine engine(device_);
    rtLogicCqReport_t report[RT_MILAN_MAX_QUERY_CQE_NUM] = {};
    uint8_t *reportInfo = reinterpret_cast<uint8_t *>(report);
    uint32_t cnt = 1U;

    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .with(mockcpp::any(), mockcpp::any())
        .will(returnValue(&task));

    MOCKER_CPP_VIRTUAL(device_->Driver_(), &Driver::LogicCqReportV2)
        .stubs()
        .with(mockcpp::any(), outBound(reportInfo), mockcpp::any(), outBound(cnt))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Engine::ReportHeartBreakProcV2)
        .stubs()
        .will(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_LOST_HEARTBEAT));
    MOCKER_CPP(&StarsEngine::ProcLogicCqReport).stubs().will(ignoreReturnValue());

    uint32_t taskId = 0U;
    rtError_t error = engine.ProcLogicCqUntilEmpty(stm, taskId);
    EXPECT_EQ(error, RT_ERROR_LOST_HEARTBEAT);
    GlobalMockObject::reset();
}

TEST_F(CloudV2StarsEngineTest, ProcLogicCqUntilEmpty_MutiTaskReport)
{
    Stream * const stm = stream_;
    StarsEngine engine(device_);
    rtLogicCqReport_t report[RT_MILAN_MAX_QUERY_CQE_NUM] = {};
    uint8_t *reportInfo = reinterpret_cast<uint8_t *>(report);
    uint32_t cnt = 1U;

    TaskInfo task = {};
    task.type = TS_TASK_TYPE_MULTIPLE_TASK;
    task.u.davinciMultiTaskInfo.sqeNum = 2U;
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .with(mockcpp::any(), mockcpp::any())
        .will(returnValue(&task));

    MOCKER_CPP_VIRTUAL(device_->Driver_(), &Driver::LogicCqReportV2)
        .stubs()
        .with(mockcpp::any(), outBound(reportInfo), mockcpp::any(), outBound(cnt))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Engine::ReportHeartBreakProcV2)
        .stubs()
        .will(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_LOST_HEARTBEAT));
    MOCKER_CPP(&StarsEngine::ProcMultipleTaskLogicCqReport)
        .stubs()
        .will(returnValue(false));
    MOCKER_CPP(&StarsEngine::ProcLogicCqReport).stubs().will(ignoreReturnValue());

    uint32_t taskId = 0U;
    rtError_t error = engine.ProcLogicCqUntilEmpty(stm, taskId);
    EXPECT_EQ(error, RT_ERROR_LOST_HEARTBEAT);
    GlobalMockObject::reset();
}

TEST_F(CloudV2StarsEngineTest, SendingProcReport_test)
{
    Stream * const stm = stream_;
    StarsEngine engine(device_);

    MOCKER_CPP(&StarsEngine::ProcLogicCqUntilEmpty)
        .stubs()
        .will(returnValue(RT_ERROR_LOST_HEARTBEAT));
    MOCKER_CPP(&StarsEngine::FinishedTaskReclaim)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    bool orgIsNeedRecvCqe = stm->isNeedRecvCqe_;
    stm->SetNeedRecvCqeFlag(true);
    uint32_t taskId = 0U;
    rtError_t error = engine.SendingProcReport(stm, false, 0U, taskId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::reset();

    MOCKER_CPP(&StarsEngine::ProcLogicCqUntilEmpty)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = engine.SendingProcReport(stm, false, 0U, taskId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::reset();
    stm->SetNeedRecvCqeFlag(orgIsNeedRecvCqe);
}

TEST_F(CloudV2StarsEngineTest, ProcReport_test)
{
    Stream * const stm = stream_;
    StarsEngine engine(device_);

    rtLogicCqReport_t logicReport[RT_MILAN_MAX_QUERY_CQE_NUM] = {};
    rtLogicCqReport_t &report = logicReport[0];
    report.taskId = 1U;

    TaskInfo task = {};
    task.type = TS_TASK_TYPE_MULTIPLE_TASK;
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .with(mockcpp::any(), mockcpp::any())
        .will(returnValue(&task));
    MOCKER(GetSendSqeNum)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(2U)));
    MOCKER_CPP(&StarsEngine::ProcMultipleTaskLogicCqReport)
        .stubs()
        .will(returnValue(true));

    bool isFinished = false;
    engine.ProcReport(0U, false, 1U, logicReport, isFinished, 0U);
    EXPECT_EQ(isFinished, true);
    GlobalMockObject::reset();
}

void UserDefineDvppGrpCb(rtDvppGrpRptInfo_t *rptInfo)
{
    (void)rptInfo;
    std::cout << "User define callback." << std::endl;
}

TEST_F(CloudV2StarsEngineTest, CommonTaskReportLogicCq_test)
{
    Stream * const stm = stream_;
    StarsEngine engine(device_);
    rtLogicCqReport_t report;

    MOCKER_CPP(&StarsEngine::ProcReportIsVpcErrorAndRetry)
        .stubs()
        .will(returnValue(true));

    rtError_t error = engine.CommonTaskReportLogicCq(report, nullptr);
    EXPECT_EQ(error, RT_ERROR_STREAM_SYNC_TIMEOUT);
    GlobalMockObject::reset();

    MOCKER_CPP(&StarsEngine::ProcLogicCqReport)
        .stubs();
    error = engine.CommonTaskReportLogicCq(report, UserDefineDvppGrpCb);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::reset();
}

TEST_F(CloudV2StarsEngineTest, ReportLogicCq_test)
{
    Stream * const stm = stream_;
    StarsEngine engine(device_);
    rtLogicCqReport_t report;

    TaskInfo task = {};
    task.type = TS_TASK_TYPE_MULTIPLE_TASK;
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .with(mockcpp::any(), mockcpp::any())
        .will(returnValue(&task));
    MOCKER_CPP(&StarsEngine::CommonTaskReportLogicCq)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    rtError_t error = engine.ReportLogicCq(report, UserDefineDvppGrpCb);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::reset();
}

TEST_F(CloudV2StarsEngineTest, Run_WithWrongThreadType)
{
    std::unique_ptr<Engine> engine = std::make_unique<StarsEngine>(device_);
    uint32_t threadType = 5U;
    void * const typeParm = reinterpret_cast<void *>(static_cast<uintptr_t>(threadType));
    std::unique_ptr<Thread> testThread(OsalFactory::CreateThread("test_thread", engine.get(), typeParm));
    EXPECT_NE(testThread, nullptr);
    rtError_t error = testThread->Start();
    EXPECT_EQ(error, EN_OK);
    EXPECT_EQ(engine->CheckMonitorThreadAlive(), false);
    testThread->Join();
}

TEST_F(CloudV2StarsEngineTest, DvppWaitGroup_test)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    Stream *stream = new Stream(device, 0);
    StarsEngine engine(device);

    rtLogicCqReport_t report[RT_MILAN_MAX_QUERY_CQE_NUM] = {};
    uint8_t *reportInfo = reinterpret_cast<uint8_t *>(report);
    uint32_t cnt = 0U;
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::LogicCqReportV2)
        .stubs()
        .with(mockcpp::any(), outBound(reportInfo), mockcpp::any(), outBound(cnt))
        .will(returnValue(RT_ERROR_NONE));

    DvppGrp *grp = new DvppGrp(device, 0);
    rtDvppGrpCallback callBackFunc;
    rtError_t error = engine.DvppWaitGroup(grp, callBackFunc, 0);
    EXPECT_EQ(error, RT_ERROR_STREAM_SYNC_TIMEOUT);
    delete stream;
    delete device;
    delete grp;
    GlobalMockObject::reset();
}

TEST_F(CloudV2StarsEngineTest, CreateRecycleThread_failed)
{
    RawDevice *device = new RawDevice(0);
    StarsEngine engine(device);
    MOCKER(mmCreateTaskWithThreadAttr).stubs().will(returnValue(-1));
    rtError_t error = engine.CreateRecycleThread();
    EXPECT_EQ(error, RT_ERROR_MEMORY_ALLOCATION);

    MOCKER(mmSemInit).stubs().will(returnValue(-1));
    error = engine.CreateRecycleThread();
    EXPECT_EQ(error, RT_ERROR_MEMORY_ALLOCATION);
    delete device;
    GlobalMockObject::reset();
}

TEST_F(CloudV2StarsEngineTest, MonitorTaskReclaim_taskRecycle)
{
    rtError_t error;
    StarsEngine engine(device_);
    device_->SetMonitorExitFlag(true);
    bool oldMonitorFlag = device_->GetMonitorExitFlag();
    rtStream_t streamHandle;
    error = rtStreamCreate(&streamHandle, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *stream = (Stream *)streamHandle;
    stream->pendingNum_.Set(1U);
    device_->SetMonitorExitFlag(false);
    MOCKER_CPP(&StarsEngine::TaskReclaimByStreamId)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = engine.MonitorTaskReclaim(stream->Id_());
    EXPECT_EQ(error, RT_ERROR_NONE);
    stream->pendingNum_.Set(0U);
    device_->SetMonitorExitFlag(oldMonitorFlag);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2StarsEngineTest, StarsResumeRtsq_RT_STARS_EXIST_ERROR)
{
    uint32_t taskId = 0U;
    RawDevice *device = new RawDevice(0);
    StarsEngine engine(device);
    rtLogicCqReport_t logicCq = {0};
    logicCq.errorType = 0;
    logicCq.taskId = taskId;
    logicCq.streamId = stream_->Id_();
    logicCq.errorType = 0U;
    rtError_t ret = engine.StarsResumeRtsq(logicCq, 0U, nullptr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete device;
}

TEST_F(CloudV2StarsEngineTest, WaitTask3)
{
    uint32_t recycleTaskId = 0;
    rtError_t ret;
    TaskInfo task0 = {};
    task0.stream = stream_;
    AicTaskInit(&task0, Program::MACH_AI_CORE, 1, 0, nullptr);
    ret = engine_->SubmitTask(&task0);

    MOCKER_CPP_VIRTUAL(engine_, &Engine::SubmitTask).stubs().will(returnValue(RT_ERROR_STREAM_ABORT_SEND_TASK_FAIL));
    stream_->Context_()->SetFailureError(0);
    ret = stream_->StarsWaitForTask(10, true, -1);
    EXPECT_EQ(ret, RT_ERROR_STREAM_ABORT_SEND_TASK_FAIL);
}

TEST_F(CloudV2StarsEngineTest, WaitTask4)
{
    uint32_t recycleTaskId = 0;
    rtError_t ret;
    TaskInfo task0 = {};
    task0.stream = stream_;
    AicTaskInit(&task0, Program::MACH_AI_CORE, 1, 0, nullptr);
    ret = engine_->SubmitTask(&task0);

    MOCKER_CPP_VIRTUAL(engine_, &Engine::SubmitTask).stubs().will(returnValue(RT_ERROR_STREAM_ABORT_SYNC_TASK_FAIL));
    stream_->Context_()->SetFailureError(0);
    ret = stream_->StarsWaitForTask(10, true, -1);
    EXPECT_EQ(ret, RT_ERROR_STREAM_ABORT_SYNC_TASK_FAIL);
}

TEST_F(CloudV2StarsEngineTest, WaitTask5)
{
    uint32_t recycleTaskId = 0;
    rtError_t ret;
    TaskInfo task0 = {};
    task0.stream = stream_;
    AicTaskInit(&task0, Program::MACH_AI_CORE, 1, 0, nullptr);
    ret = engine_->SubmitTask(&task0);

    MOCKER_CPP_VIRTUAL(engine_, &Engine::SubmitTask).stubs().will(returnValue(RT_ERROR_STREAM_SYNC_TIMEOUT));
    stream_->Context_()->SetFailureError(0);
    ret = stream_->StarsWaitForTask(10, true, -1);
    EXPECT_EQ(ret, RT_ERROR_STREAM_SYNC_TIMEOUT);
}

TEST_F(CloudV2StarsEngineTest, ClearSerId)
{
    rtError_t error;
    uint32_t sendSqeNum = 1;

    TaskInfo * const workTask = device_->GetTaskFactory()->Alloc(stream_, TS_TASK_TYPE_EVENT_RECORD, error);
    error = EventRecordTaskInit(workTask, nullptr, false, INVALID_EVENT_ID);
    EXPECT_NE(error, RT_ERROR_NONE);
    device_->GetTaskFactory()->SetSerialId(stream_, workTask);
    device_->GetTaskFactory()->ClearSerialVecId(stream_);
}

extern int32_t reportRasProcFlag;
extern int32_t faultEventFlag;
TEST_F(CloudV2StarsEngineTest, ReportRasProc)
{
    faultEventFlag = 1;
    RawDevice device(0);
    TaskInfo task = {};
    task.stream = stream_;
    GetMteErrFromCqeStatus(&task, &device, TS_SDMA_STATUS_DDRC_ERROR);
    EXPECT_EQ(task.mte_error, TS_ERROR_SDMA_LINK_ERROR);
    task.mte_error = 0U;

    GetMteErrFromCqeStatus(&task, &device, TS_SDMA_STATUS_LINK_ERROR);
    EXPECT_EQ(task.mte_error, TS_ERROR_SDMA_LINK_ERROR);
    task.mte_error = 0U;

    GetMteErrFromCqeStatus(&task, &device, TS_SDMA_STATUS_POISON_ERROR);
    EXPECT_EQ(task.mte_error, TS_ERROR_SDMA_LINK_ERROR);
    task.mte_error = 0U;
    faultEventFlag = 0;

    reportRasProcFlag = 1;
    StarsEngine engine(&device);
    rtError_t ret = ((Runtime *)Runtime::Instance())->CreateReportRasThread();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    mmSleep(400U);
    device.SetDeviceRas(true);
    GetMteErrFromCqeStatus(&task, &device, TS_SDMA_STATUS_POISON_ERROR);
    EXPECT_EQ(task.mte_error, TS_ERROR_SDMA_POISON_ERROR);
    task.mte_error = 0U;
    ((Runtime *)Runtime::Instance())->DestroyReportRasThread();
    reportRasProcFlag = 0;

    reportRasProcFlag = 2;
    ret = ((Runtime *)Runtime::Instance())->CreateReportRasThread();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    mmSleep(1200U);
    GetMteErrFromCqeStatus(&task, &device, TS_SDMA_STATUS_POISON_ERROR);
    EXPECT_EQ(task.mte_error, TS_ERROR_SDMA_POISON_ERROR);
    task.mte_error = 0U;
    ((Runtime *)Runtime::Instance())->DestroyReportRasThread();
    Runtime::Instance()->hbmRasProcFlag_ = HBM_RAS_WORKING;
    reportRasProcFlag = 0;

    reportRasProcFlag = 3;
    ret = ((Runtime *)Runtime::Instance())->CreateReportRasThread();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    mmSleep(1200U);
    ((Runtime *)Runtime::Instance())->DestroyReportRasThread();
    Runtime::Instance()->hbmRasProcFlag_ = HBM_RAS_WORKING;
    reportRasProcFlag = 0;

    reportRasProcFlag = 4;
    ret = ((Runtime *)Runtime::Instance())->CreateReportRasThread();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    mmSleep(1200U);
    ((Runtime *)Runtime::Instance())->DestroyReportRasThread();
    Runtime::Instance()->hbmRasProcFlag_ = HBM_RAS_WORKING;
    reportRasProcFlag = 0;

    Runtime::Instance()->hbmRasProcFlag_ = HBM_RAS_NOT_SUPPORT;
    SetTaskMteErr(&task, &device);
    Runtime::Instance()->hbmRasProcFlag_ = HBM_RAS_WORKING;

    device.SetDeviceRas(true);
    SetTaskMteErr(&task, &device);
}

TEST_F(CloudV2StarsEngineTest, ReportRasProc_no_support)
{
    reportRasProcFlag = 2;
    RawDevice device(0);
    StarsEngine engine(&device);
    rtError_t ret = ((Runtime *)Runtime::Instance())->CreateReportRasThread();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    mmSleep(400U);
    ((Runtime *)Runtime::Instance())->DestroyReportRasThread();
    reportRasProcFlag = 0;
}

extern int32_t checkProcessStatusFlag;
TEST_F(CloudV2StarsEngineTest, TestMemUceError)
{
    EXPECT_EQ(HasMemUceErr(0), true);

    faultEventFlag = 2;
    EXPECT_EQ(HasMemUceErr(0), false);

    checkProcessStatusFlag = 1;
    EXPECT_EQ(HasMemUceErr(0), false);

    checkProcessStatusFlag = 2;
    EXPECT_EQ(HasMemUceErr(0), false);

    faultEventFlag = 3;
    EXPECT_EQ(HasMemUceErr(0), false);

    checkProcessStatusFlag = 0;
    faultEventFlag = 0;

    RawDevice device(0);
    device.SetDeviceStatus(RT_ERROR_DEVICE_TASK_ABORT);
    TaskFailCallBack(0, 0, 0, RT_ERROR_DEVICE_TASK_ABORT, &device);
}

TEST_F(CloudV2StarsEngineTest, ProcessStarsSdmaErrorInfoNotSupport)
{
    StarsEngine engine(device_);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device_);
    StarsDeviceErrorInfo errorInfo = {};
    TaskInfo task = {};
    InitByStream(&task, stream_);
    MOCKER(GetTaskInfo).stubs().will(returnValue(&task));
    Runtime::Instance()->hbmRasProcFlag_ = HBM_RAS_NOT_SUPPORT;
    device_->SetDeviceRas(false);
    errorInfo.u.sdmaErrorInfo.comm.type = SDMA_ERROR;
    errorInfo.u.sdmaErrorInfo.comm.coreNum = 1;
    errorInfo.u.sdmaErrorInfo.sdma.starsInfo[0].cqeStatus = TS_SDMA_STATUS_DDRC_ERROR;
    rtError_t ret = DeviceErrorProc::ProcessStarsSdmaErrorInfo(&errorInfo, 0, device_, nullptr);
    Runtime::Instance()->hbmRasProcFlag_ = HBM_RAS_WORKING;
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalMockObject::verify();
    delete errorProc;
}

TEST_F(CloudV2StarsEngineTest, MonitorForWatchDog_02)
{
    rtError_t error;
    uint16_t streamId;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    StarsEngine engine(device_);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device_);
    EXPECT_NE(errorProc, nullptr);
    MOCKER_CPP_VIRTUAL((RawDevice *)device_, &RawDevice::ReportRingBuffer).stubs().will(returnValue(RT_ERROR_TASK_MONITOR));
    error = device_->ReportRingBuffer(&streamId);
    EXPECT_EQ(error, RT_ERROR_TASK_MONITOR);
    engine.MonitorForWatchDog(device_);
    delete errorProc;
}

