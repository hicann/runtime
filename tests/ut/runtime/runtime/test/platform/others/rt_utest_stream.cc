/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstdio>
#include <stdlib.h>

#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#define protected public
#include "engine.hpp"
#include "event.hpp"
#include "task_res.hpp"
#include "ctrl_stream.hpp"
#include "coprocessor_stream.hpp"
#include "tsch_stream.hpp"
#include "engine_stream_observer.hpp"
#include "stream_sqcq_manage.hpp"
#include "scheduler.hpp"
#include "runtime.hpp"
#include "raw_device.hpp"
#include "task_info.hpp"
#include "async_hwts_engine.hpp"
#undef private
#undef protected
#include "ffts_task.h"
#include "context.hpp"
#include "securec.h"
#include "api.hpp"
#include "npu_driver.hpp"
#include "task_submit.hpp"
#include "capture_model_utils.hpp"
#include "thread_local_container.hpp"
#include "capture_adapt.hpp"
using namespace testing;
using namespace cce::runtime;

static uint16_t ind = 0;

class ChipStreamTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"ChipStreamTest start"<<std::endl;

    }

    static void TearDownTestCase()
    {
        std::cout<<"ChipStreamTest end"<<std::endl;
    }

    virtual void SetUp()
    {
        (void)rtSetDevice(0);
        std::cout<<"ut test start."<<std::endl;
    }

    virtual void TearDown()
    {
        std::cout<<"ut test end."<<std::endl;
        ind = 0;
        GlobalMockObject::verify();
        rtDeviceReset(0);
    }

public:
    static Api        *oldApi_;
    static rtStream_t stream_;
    static rtEvent_t  event_;
    static void      *binHandle_;
    static char       function_;
    static uint32_t   binary_[32];
private:
    rtChipType_t originType;
};

Api * ChipStreamTest::oldApi_ = nullptr;
rtStream_t ChipStreamTest::stream_ = nullptr;
rtEvent_t ChipStreamTest::event_ = nullptr;
void* ChipStreamTest::binHandle_ = nullptr;
char  ChipStreamTest::function_ = 'a';
uint32_t ChipStreamTest::binary_[32] = {};

class SubmitFailSchedulerT : public FifoScheduler
{
public:
    Scheduler *test;

    void set(Scheduler *fifoScheduler)
    {
        test = fifoScheduler;
    }

    virtual rtError_t PushTask(TaskInfo *task)
    {
        std::cout << "PushTask begin taskType = " << task->type << "ind = " << ind << std::endl;
        if (0 == ind)
        {
            ind = 1;
            std::cout << "PushTask begin taskType = " << task->type << "ind = " << ind << std::endl;
            return  test->PushTask(task);
            // return  FifoScheduler::PushTask(task);
        }
        return RT_ERROR_INVALID_VALUE;
    }

    virtual TaskInfo * PopTask()
    {
        return test->PopTask();
    }
};

static void ApiTest_Stream_Cb(void *arg)
{
}

TEST_F(ChipStreamTest, TestIsTaskLimitedWithTaskFinished)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device *device = rtInstance->DeviceRetain(0, 0);
    Stream stream(device, 0);
    rtChipType_t preChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    stream.waitTaskList_.push_back(512);
    TaskInfo task = {};
    bool ret = stream.IsTaskLimited(&task);
    ASSERT_EQ(ret, false);

    rtInstance->SetChipType(preChipType);
    GlobalContainer::SetRtChipType(preChipType);
    rtInstance->DeviceRelease(device);
}

TEST_F(ChipStreamTest, TestIsTaskLimitedWithTaskTypeUnexpected)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Device *device = rtInstance->DeviceRetain(0, 0);
    Stream stream(device, 0);
    rtChipType_t preChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    stream.waitTaskList_.push_back(512);
    TaskInfo aicoreTask = {};
    aicoreTask.type = TS_TASK_TYPE_KERNEL_AICORE;
    MOCKER_CPP(&TaskFactory::GetTask).stubs().will(returnValue(&aicoreTask));
    TaskInfo task = {};
    bool ret = stream.IsTaskLimited(&task);
    ASSERT_EQ(ret, false);

    rtInstance->SetChipType(preChipType);
    GlobalContainer::SetRtChipType(preChipType);
    rtInstance->DeviceRelease(device);
}

TEST_F(ChipStreamTest, EngineStreamObserver_TaskSubmited)
{
    MOCKER_CPP(&Stream::ProcL2AddrTask).stubs().will(returnValue(RT_ERROR_NONE));
    std::shared_ptr<RawDevice> device = std::make_shared<RawDevice>(0);
    MOCKER_CPP_VIRTUAL(device.get(), &RawDevice::SubmitTask).stubs().will(returnValue(RT_ERROR_NONE));
    device->Init();
    std::shared_ptr<Stream> stream = std::make_shared<Stream>(device.get(), 0);
    stream->SetNeedSubmitTask(true);
    std::shared_ptr<Model> model = std::make_shared<Model>();
    stream->SetModel(model.get());
    stream->SetLatestModlId(model.get()->Id_());
    TaskInfo task = {0};
    task.stream = stream.get();

    std::shared_ptr<EngineStreamObserver> streamObserver = std::make_shared<EngineStreamObserver>();
    EXPECT_EQ(stream->GetPendingNum(), 0);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    streamObserver->TaskSubmited(device.get(), &task);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    EXPECT_EQ(stream->GetPendingNum(), 1);
}