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

class StreamTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout<<"stream test start"<<std::endl;

    }

    static void TearDownTestCase()
    {
        std::cout<<"stream test end"<<std::endl;
    }

    virtual void SetUp()
    {
        (void)rtSetDevice(0);
        std::cout<<"ut test start."<<std::endl;
    }

    virtual void TearDown()
    {
        ind = 0;
        GlobalMockObject::verify();
        rtDeviceReset(0);
        std::cout<<"ut test end."<<std::endl;
    }

public:
    static Api        *oldApi_;
    static rtStream_t stream_;
    static rtEvent_t  event_;
    static void      *binHandle_;
    static char       function_;
    static uint32_t   binary_[32];
};

Api * StreamTest::oldApi_ = NULL;
rtStream_t StreamTest::stream_ = NULL;
rtEvent_t StreamTest::event_ = NULL;
void* StreamTest::binHandle_ = NULL;
char  StreamTest::function_ = 'a';
uint32_t StreamTest::binary_[32] = {};

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

#if 0
TEST_F(StreamTest, stream_create_and_destroy)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamTest, stream_with_flag_create_and_destroy)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreateWithFlags(&stream, 0, 8); /* flag = AICPU */
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamTest, stream_wait_event_null)
{
    rtError_t error;
    int32_t streamId;

    Device *dev = ((Runtime *)Runtime::Instance())->DeviceRetain(0);
    EXPECT_NE(dev, (Device*)NULL);

    error = rtStreamWaitEvent(NULL, NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtGetStreamId(NULL, &streamId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ((Runtime *)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(StreamTest, get_max_stream_and_test)
{
    rtError_t error;
    uint32_t MaxStrCount;
    uint32_t MaxTaskCount;

    error = rtGetMaxStreamAndTask(RT_NORMAL_STREAM, NULL, &MaxTaskCount);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetMaxStreamAndTask(RT_NORMAL_STREAM, &MaxStrCount, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetMaxStreamAndTask(RT_NORMAL_STREAM, &MaxStrCount, &MaxTaskCount);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetMaxStreamAndTask(RT_HUGE_STREAM, NULL, &MaxTaskCount);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetMaxStreamAndTask(RT_HUGE_STREAM, &MaxStrCount, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetMaxStreamAndTask(RT_HUGE_STREAM, &MaxStrCount, &MaxTaskCount);
    EXPECT_EQ(error,  ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

}

TEST_F(StreamTest, stream_wait_event_no_record)
{
    rtError_t error;
    rtEvent_t event;

    Device *dev = ((Runtime *)Runtime::Instance())->DeviceRetain(0);
    EXPECT_NE(dev, (Device*)NULL);

    Stream stream(dev, 0);

    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = stream.WaitEvent((Event*)event);
    EXPECT_EQ(error, RT_ERROR_EVENT_RECORDER_NULL);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ((Runtime *)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(StreamTest, stream_create_alloc_no_id)
{
    rtError_t error;
    rtStream_t stream;

    MOCKER(halResourceIdAlloc).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtStreamCreate(&stream, 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    //MOCKER(rtDeviceReset).stubs().will(returnValue(RT_ERROR_NONE));
}

TEST_F(StreamTest, stream_fusion_destroy)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtKernelFusionEnd(stream);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtKernelFusionStart(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamTest, stream_get_id)
{
    rtError_t error;
    rtStream_t stream;
    int32_t streamId;

    error = rtGetStreamId(stream, NULL);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetStreamId(stream, &streamId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamTest, stream_get_id_other_device)
{
    rtError_t error;
    rtStream_t streamHandle;
    int32_t streamId;

    Device *dev = ((Runtime *)Runtime::Instance())->DeviceRetain(0);
    EXPECT_NE(dev, (Device*)NULL);

    error = rtStreamCreate(&streamHandle, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream *stream = (Stream *)streamHandle;

    Context *tmp_ctx = stream->context_;
    stream->context_ = NULL;
    error = rtGetStreamId(stream, &streamId);
    EXPECT_NE(error, RT_ERROR_NONE);

    stream->context_ = tmp_ctx;
    error = rtStreamDestroy(streamHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ((Runtime *)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(StreamTest, stream_set_l2_addr_mem_alloc_failed)
{
    rtError_t error;
    rtStream_t stream;

    MOCKER(drvMemAlloc).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamTest, stream_set_l2_addr_mem_copy_failed)
{
    rtError_t error;
    rtStream_t stream;

    MOCKER(drvModelMemcpy).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamTest, stream_set_l2_addr_addr_trans_failed)
{
    rtError_t error;
    rtStream_t stream;

    MOCKER(drvMemAddressTranslate).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamTest, stream_set_l2_addr_task_submit_failed)
{
    rtError_t error;
    RawDevice* device= (RawDevice*)((Runtime *)Runtime::Instance())->DeviceRetain(0);
    // device->WaitCompletion();

    Scheduler *oldScheduler = device->engine_->scheduler_;
    SubmitFailSchedulerT scheduler1;
    scheduler1.set(oldScheduler);

    device->engine_->scheduler_ = &scheduler1;
    //stream create
    rtStream_t streamTest;
    error = rtStreamCreate(&streamTest, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    //recover
    device->engine_->scheduler_ = oldScheduler;
    error = rtStreamDestroy(streamTest);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // device->WaitCompletion();
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(StreamTest, stream_set_l2_addr_mem_alloc_release_l2_buffer_failed)
{
    rtError_t error;
    rtStream_t stream;

    MOCKER(drvMemAllocL2buffAddr).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(drvMemReleaseL2buffAddr).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    GlobalMockObject::verify();
}

//for llt exception
TEST_F(StreamTest, stream_set_l2_addr_kernel_launch_translate_addr_failed)
{
    rtError_t error;
    void *args[] = {&error, NULL};

    oldApi_ = Runtime::runtime_->api_;
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    Runtime::runtime_->api_ = apiDecorator_;

    rtError_t error1 = rtStreamCreate(&stream_, 0);
    rtError_t error2 = rtEventCreate(&event_);

    for (uint32_t i = 0; i < sizeof(binary_)/sizeof(uint32_t); i++)
    {
        binary_[i] = i;
    }

    rtDevBinary_t devBin;
    devBin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    devBin.version = 1;
    devBin.length = sizeof(binary_);
    devBin.data = binary_;
    rtError_t error3 = rtDevBinaryRegister(&devBin, &binHandle_);

    rtError_t error4 = rtFunctionRegister(binHandle_, &function_, "foo", NULL, 0);

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    MOCKER(drvMemAddressTranslate).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error1 = rtStreamDestroy(stream_);
    error2 = rtEventDestroy(event_);
    error3 = rtDevBinaryUnRegister(binHandle_);
    std::cout<<"api test start end : "<<error1<<", "<<error2<<", "<<error3<<std::endl;

    Api *apiDecorator = Runtime::runtime_->api_;
    Runtime::runtime_->api_ = oldApi_;
    delete apiDecorator;
}
#endif

//for llt exception
#if 0
TEST_F(StreamTest, stream_fusion_end)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtKernelFusionStart(stream);
    Engine *engine = new Engine(NULL);
    MOCKER_CPP_VIRTUAL(engine, &Engine::SubmitTask)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));

    error = rtKernelFusionEnd(stream);
    EXPECT_NE(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
    delete engine;

    error = rtKernelFusionEnd(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
#endif

TEST_F(StreamTest, stream_create_with_flag_alloc_no_id)
{
    rtError_t error;
    rtStream_t stream;

    MOCKER(halResourceIdAlloc).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtStreamCreateWithFlags(&stream, 0, 0);/*flag = 3*/
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(StreamTest, stream_create_with_flag_fast)
{
    rtError_t error;
    rtStream_t stream;

    MOCKER(halResourceIdAlloc).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    error = rtStreamCreateWithFlags(&stream, 0, (0x200 | 0x400));
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(StreamTest, stream_set_proc_stream_task_fail)
{
    rtError_t error;
    RawDevice* device= (RawDevice*)((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    // device->WaitCompletion();

    MOCKER(CreateStreamTaskInit).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    // ((RawDevice *)device)->platformConfig_ = 0x300;

    //stream create
    rtStream_t streamTest;
    error = rtStreamCreateWithFlags(&streamTest, 5, 1);
    EXPECT_NE(error, RT_ERROR_NONE);

    // device->WaitCompletion();
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(StreamTest, stream_set_proc_l2_task_fail)
{
    rtError_t error;
    RawDevice* device= (RawDevice*)((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    // device->WaitCompletion();

    MOCKER(CreateL2AddrTaskInit).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    //((RawDevice *)device)->platformConfig_ = 0x300;

    //stream create
    rtStream_t streamTest;
    error = rtStreamCreateWithFlags(&streamTest, 5, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // device->WaitCompletion();
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(StreamTest, stream_sync_fail)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtContext_t ctx;
    rtEvent_t event;
    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&Stream::IsPersistentTaskFull).stubs().will(returnValue(true));
    ((Stream *)stream)->GetTaskRevFlag(true);

    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelBindStream(model, stream, 0);
    Stream *stream_var = static_cast<Stream *>(stream);

    stream_var->SetErrCode(1);
    stream_var->SetNeedSyncFlag(false);
    EXPECT_EQ(stream_var->GetNeedSyncFlag(), false);

    stream_var->SetModel((Model*)model);

    stream_var->Synchronize();

    //Model model;
    ((Model *)model)->UnbindStream(NULL , false);

    error = rtModelDestroy(model);
    error = rtEventDestroy(event);
    error = rtStreamDestroy(stream);
    error = rtCtxDestroy(ctx);

}
#if 0
TEST_F(StreamTest, stream_insert_free_persist_task_id_01)
{
    rtError_t error;

    MOCKER_CPP(&PersistTaskPool::FreeId).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&TaskAllocator::FreeById).stubs();

    Device *dev = ((Runtime *)Runtime::Instance())->DeviceRetain(0);
    EXPECT_NE(dev, (Device*)NULL);
    Stream stream(dev, 0);

    stream.PushPersistentTaskID(7500);
    TaskAllocator *allocator = (TaskAllocator *)(&error);
    error = stream.FreePersistentTaskID(allocator);

    ((Runtime *)Runtime::Instance())->DeviceRelease(dev);

}

TEST_F(StreamTest, end_of_sequence)
{
    rtError_t error;
    rtStream_t stream;
    rtContext_t ctx;

    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream *stream_var = static_cast<Stream *>(stream);

    stream_var->SetErrCode(0x95);

    error = rtStreamSynchronize(stream);
    EXPECT_EQ(error, ACL_ERROR_RT_END_OF_SEQUENCE);

    error = rtStreamDestroy(stream);
    error = rtCtxDestroy(ctx);
}

void STREAM_cb2(void *arg)
{
}

TEST_F(StreamTest, SubscribeReport_CB)
{
    rtError_t error;
    rtStream_t stream;
    uint32_t cqId = 0;
    uint32_t sqId = 0;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ((Stream *)stream)->GetCbRptCqid();
    ((Stream *)stream)->IsHostFuncCbReg();

    error = rtSubscribeReport((uint64_t)pthread_self(), stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ((Runtime *)Runtime::Instance())->GetCqIdByStreamId(((Stream *)stream)->Device_()->Id_(),
        ((Stream *)stream)->Id_(), &cqId);

    ((Runtime *)Runtime::Instance())->GetSqIdByStreamId(((Stream *)stream)->Device_()->Id_(),
        ((Stream *)stream)->Id_(), &sqId);

    error = rtProcessReport(0);

    error = rtStreamSynchronize(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtUnSubscribeReport((uint64_t)pthread_self(), stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
#endif

TEST_F(StreamTest, stream_tearDown_fail)
{
    rtError_t error;
    rtStream_t stream;
    Context *ctxPtr;
    int32_t devId;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t preChipType = rtInstance->GetChipType();
    RefObject<Context*> *refObject = NULL;
    error = rtGetDevice(&devId);
    refObject = (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(devId);
    EXPECT_NE(refObject, nullptr);
    ctxPtr = refObject->GetVal();
    EXPECT_NE(ctxPtr, nullptr);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *stream_var = static_cast<Stream *>(stream);
    stream_var->pendingNum_.Set(0);
    stream_var->delayRecycleTaskid_.push_back(0);
    std::cout<<"stream create success."<<std::endl;

    MOCKER_CPP_VIRTUAL(ctxPtr->device_, &Device::GetDevRunningState).stubs().then(returnValue(1));
    error = rtStreamDestroy(stream);
    std::cout<<"stream destory success."<<std::endl;    
    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(devId);
}

TEST_F(StreamTest, stream_tearDownforce_test)
{
    rtError_t error;
    rtStream_t stream;
    rtContext_t ctx;
    Context *ctxPtr;
    int32_t devId;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t preChipType = rtInstance->GetChipType();
    RefObject<Context*> *refObject = NULL;
    error = rtGetDevice(&devId);
    refObject = (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(devId);
    EXPECT_NE(refObject, nullptr);
    ctxPtr = refObject->GetVal();
    EXPECT_NE(ctxPtr, nullptr);
    
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream *stream_var = static_cast<Stream *>(stream);
    stream_var->pendingNum_.Set(1);
    stream_var->delayRecycleTaskid_.push_back(0);
    MOCKER_CPP_VIRTUAL(ctxPtr->device_, &Device::GetDevRunningState).stubs().then(returnValue(1));
    error = rtStreamDestroyForce(stream);
    error = rtCtxDestroy(ctx);
    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(devId);
}

TEST_F(StreamTest, stream_freePersistentTaskId_test)
{
    RawDevice *device = new RawDevice(0);
    EXPECT_NE(device, nullptr);
    device->Init();
    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    CtrlStream *cstream = new CtrlStream(device);
    EXPECT_NE(cstream, nullptr);
    stream->FreePersistentTaskID(cstream);
    

    DELETE_O(stream);
    DELETE_O(cstream);
    DELETE_O(device);
}

TEST_F(StreamTest, stream_StreamSqCqManage)
{
    rtError_t error;
    uint32_t sqId;
    uint32_t cqId;
    uint32_t info = 1;
    uint32_t msg[1] = {0};
    StreamSqCqManage manage(nullptr);
    MOCKER_CPP(&StreamSqCqManage::Add).stubs().will(returnValue(RT_ERROR_SQID_FULL));
    error = manage.Add(1, 0, sqId, cqId, &info, sizeof(info), msg, sizeof(msg));
    EXPECT_EQ(error, RT_ERROR_SQID_FULL);
    manage.GetDefaultCqId(&cqId);
    bool isNeedFast = false;
    bool isFastCq = false;
    RawDevice *dev = new RawDevice(0);
    dev->Init();
    manage.device_ = dev;
    manage.AllocLogicCq(1, isNeedFast, cqId, isFastCq, false);
    manage.AllocLogicCq(1, isNeedFast, cqId, isFastCq, false);
    MOCKER(PidTidFetcher::GetCurrentUserTid).stubs().will(returnValue(1));
    manage.GetLogicCqId(1, &cqId, &isFastCq);
    delete dev;
}

TEST_F(StreamTest, stream_StreamSqCqManage_add_full)
{
    rtError_t error;
    StreamSqCqManage manage(nullptr);
    uint32_t sqId = 0;
    uint32_t cqId = 0;
    manage.streamIdToSqIdMap_[0] = sqId;
    uint32_t info[10] = {0};
    uint32_t msg[1] = {0};
    uint32_t stream_Id = 100;
    info[0] = stream_Id;

    manage.sqIdRefMap_[0] = 5;
    RawDevice *dev = new RawDevice(0);
    dev->Init();
    manage.device_ = dev;
    MOCKER_CPP_VIRTUAL((NpuDriver*)(dev->Driver_()),&NpuDriver::NormalSqCqAllocate).stubs().will(returnValue((int32_t)RT_ERROR_SQID_FULL));
    error = manage.Add(stream_Id, 0, sqId, cqId, info, sizeof(info), msg, sizeof(msg));
    EXPECT_EQ(error, RT_ERROR_SQID_FULL);
    uint32_t getCqId = 0;
    error = manage.GetSqId(stream_Id, getCqId);
    EXPECT_EQ(error, RT_ERROR_STREAM_NOT_EXIST);
    delete dev;
}

TEST_F(StreamTest, stream_StreamSqCqManage_add_full_retry_success)
{
    rtError_t error;
    StreamSqCqManage manage(nullptr);
    uint32_t sqId = 0;
    uint32_t cqId = 0;
    manage.streamIdToSqIdMap_[0] = sqId;
    uint32_t info[10] = {0};
    uint32_t msg[1] = {0};
    uint32_t stream_Id = 100;
    info[0] = stream_Id;

    manage.sqIdRefMap_[0] = 5;
    RawDevice *dev = new RawDevice(0);
    dev->Init();
    manage.device_ = dev;
    MOCKER_CPP_VIRTUAL((NpuDriver*)(dev->Driver_()),&NpuDriver::NormalSqCqAllocate).stubs().will(returnObjectList((int32_t)RT_ERROR_SQID_FULL,(int32_t)RT_ERROR_NONE));
    error = manage.Add(stream_Id, 0, sqId, cqId, info, sizeof(info), msg, sizeof(msg));
    EXPECT_EQ(error, RT_ERROR_NONE);
    uint32_t getCqId = 0;
    error = manage.GetSqId(stream_Id, getCqId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete dev;
}

TEST_F(StreamTest, stream_StreamSqCqManage_add)
{
    rtError_t error;
    StreamSqCqManage manage(nullptr);
    uint32_t sqId;
    uint32_t cqId;
    uint32_t info[10] = {0};
    uint32_t msg[1] = {0};
    uint32_t stream_Id = 100;
    info[0] = stream_Id;

    RawDevice *dev = new RawDevice(0);
    dev->Init();
    manage.device_ = dev;
    MOCKER_CPP_VIRTUAL((NpuDriver*)(dev->Driver_()),&NpuDriver::NormalSqCqAllocate).stubs().will(returnValue((int32_t)RT_ERROR_NONE));
    error = manage.Add(stream_Id, 0, sqId, cqId, info, sizeof(info), msg, sizeof(msg));
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete dev;
}

TEST_F(StreamTest, stream_StreamSqCqManage_AllocLogicCq)
{
    rtError_t error;
    uint32_t sqId;
    uint32_t cqId;
    uint32_t info = 1;
    MOCKER_CPP(&StreamSqCqManage::Add).stubs().will(returnValue(RT_ERROR_SQID_FULL));
    MOCKER_CPP(&StreamSqCqManage::GetLogicCqIdWithoutLock).stubs().will(returnValue(RT_ERROR_STREAM_NOT_EXIST));
    StreamSqCqManage manage(nullptr);
    std::shared_ptr<RawDevice> dev = std::make_shared<RawDevice>(0);
    dev->Init();
    manage.device_ = dev.get();
    bool isNeedFast = false;
    bool isFastCq = true;
    // fast cq first success
    error = manage.AllocLogicCq(1, isNeedFast, cqId, isFastCq, false);
    EXPECT_EQ(error, RT_ERROR_NONE);
    const uint64_t threadId = PidTidFetcher::GetCurrentUserTid();
    MOCKER(PidTidFetcher::GetCurrentUserTid).stubs().will(returnValue(threadId + 1)).then(returnValue(threadId + 2))
        .then(returnValue(threadId + 3));
    // normal cq first success
    isFastCq = false;
    error = manage.AllocLogicCq(1, isNeedFast, cqId, isFastCq, false);
    EXPECT_EQ(error, RT_ERROR_NONE);
    // fast cq alloc twice success
    isFastCq = true;
    error = manage.AllocLogicCq(1, isNeedFast, cqId, isFastCq, false);
    EXPECT_EQ(error, RT_ERROR_NONE);
    // normal cq alloc twice fail, just alloc once
    isFastCq = false;
    error = manage.AllocLogicCq(1, isNeedFast, cqId, isFastCq, false);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamTest, stream_StreamSqCqManage_UnbindandFreeLogicCq)
{
    MOCKER_CPP(&StreamSqCqManage::Add).stubs().will(returnValue(RT_ERROR_SQID_FULL));
    MOCKER_CPP(&StreamSqCqManage::GetLogicCqIdWithoutLock).stubs().will(returnValue(RT_ERROR_STREAM_NOT_EXIST));
    rtError_t error;
    uint32_t sqId;
    uint32_t cqId;
    uint32_t info = 1;
    StreamSqCqManage manage(nullptr);
    std::shared_ptr<RawDevice> dev = std::make_shared<RawDevice>(0);
    dev->Init();
    manage.device_ = dev.get();
    bool isNeedFast = false;
    bool isFastCq = true;

    // stream is not exist
    error = manage.UnbindandFreeLogicCq(1);
    EXPECT_EQ(error, RT_ERROR_STREAM_NOT_EXIST);

    // stream exist but thread id not exist
    error = manage.AllocLogicCq(1, isNeedFast, cqId, isFastCq, false);
    EXPECT_EQ(error, RT_ERROR_NONE);
    const uint64_t threadId = PidTidFetcher::GetCurrentUserTid();
    MOCKER(PidTidFetcher::GetCurrentUserTid).stubs().will(returnValue(threadId + 1)).then(returnValue(threadId + 2));
    error = manage.UnbindandFreeLogicCq(1);
    EXPECT_EQ(error, RT_ERROR_ENGINE_THREAD);

    // normal free
    error = manage.AllocLogicCq(1, isNeedFast, cqId, isFastCq, false);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = manage.UnbindandFreeLogicCq(1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

#if 0
TEST_F(StreamTest, SubscribeReport_CB_2)
{
    rtError_t error;
    rtStream_t stream;
    rtContext_t ctx;

    error = rtCtxCreate(&ctx, RT_CTX_NORMAL_MODE, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSubscribeReport((uint64_t)pthread_self(), stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtCallbackLaunch(ApiTest_Stream_Cb, NULL, stream, true);

    error = rtProcessReport(1);

    error = rtStreamSynchronize(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtUnSubscribeReport((uint64_t)pthread_self(), stream);

    error = rtStreamDestroy(stream);
    error = rtCtxDestroy(ctx);
}
#endif

TEST_F(StreamTest, WaitForTask)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    Stream *stream = new Stream((Device *)device, 0);
    stream->streamId_ = 1;
    uint32_t currentId = UINT32_MAX;
    MOCKER_CPP_VIRTUAL(device, &RawDevice::TaskReclaim)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), outBound(currentId))
        .will(returnValue(RT_ERROR_NONE));


    rtError_t error = stream->WaitForTask(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete stream;
    delete device;
}


TEST_F(StreamTest, WaitForTask_Timeout2)
{
    RawDevice *stubDevice = new RawDevice(0);
    stubDevice->Init();
    Stream *stream = new Stream((Device *)stubDevice, 0);
    stream->streamId_ = 1;
    uint32_t currentId = UINT32_MAX;
    MOCKER_CPP_VIRTUAL(stubDevice, &RawDevice::TaskReclaim)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), outBound(currentId))
        .will(returnValue(RT_ERROR_NONE));
    rtError_t error = stream->WaitForTask(0, false, 1);
    const bool curResult = (error == RT_ERROR_NONE) || (error == RT_ERROR_STREAM_SYNC_TIMEOUT);
    EXPECT_EQ(curResult, true);
    delete stream;
    delete stubDevice;
}

TEST_F(StreamTest, WaitForTask_Timeout3)
{
    RawDevice *stubDevice = new RawDevice(0);
    stubDevice->Init();
    Stream *stream = new Stream((Device *)stubDevice, 0);
    stream->streamId_ = 1;
    uint32_t currentId = UINT32_MAX;
    MOCKER_CPP_VIRTUAL(stubDevice, &RawDevice::TaskReclaim)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), outBound(currentId))
        .will(returnValue(RT_ERROR_NONE));

    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(drv,&NpuDriver::GetRunMode).stubs()
        .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

    rtError_t error = stream->WaitForTask(0, false, 1);
    const bool curResult = (error == RT_ERROR_NONE) || (error == RT_ERROR_STREAM_SYNC_TIMEOUT);
    EXPECT_EQ(curResult, true);
    delete stream;
    delete stubDevice;
}

TEST_F(StreamTest, ReportDestroyFlipTask)
{
    RawDevice *stubDevice = new RawDevice(0);
    rtError_t error = stubDevice->Init();
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *stream = new Stream((Device *)stubDevice, 0);
    stream->streamId_ = 1;

    MOCKER_CPP_VIRTUAL(stream, &Stream::IsNeedSendFlipTask)
        .stubs()
        .will(returnValue(true));
    stream->ReportDestroyFlipTask();
    DELETE_O(stream);
    DELETE_O(stubDevice);
}

TEST_F(StreamTest, AllocAndSendFlipTask)
{
    RawDevice *stubDevice = new RawDevice(0);
    stubDevice->Init();
    Stream *stm = new Stream((Device *)stubDevice, 0);
    stm->streamId_ = 1;
    MOCKER_CPP_VIRTUAL(stm, &Stream::IsNeedSendFlipTask)
        .stubs()
        .will(returnValue(true));
    MOCKER(AllocTaskAndSendDc)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Engine::AddPendingNum)
        .stubs();
    uint16_t taskId = 0;
    rtError_t ret = AllocAndSendFlipTask(stm->GetMaxTaskId(), stm);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    DELETE_O(stm);
    DELETE_O(stubDevice);
}

TEST_F(StreamTest, AllocAndSendFlipTaskAbort)
{
    RawDevice *stubDevice = new RawDevice(0);
    stubDevice->Init();
    Stream *stm = new Stream((Device *)stubDevice, 0);
    stm->streamId_ = 1;
    MOCKER_CPP_VIRTUAL(stm, &Stream::IsNeedSendFlipTask)
        .stubs()
        .will(returnValue(true));
    MOCKER(AllocTaskAndSendDc)
        .stubs()
        .will(returnValue(RT_ERROR_STREAM_ABORT_SEND_TASK_FAIL));
    MOCKER_CPP(&Engine::AddPendingNum)
        .stubs();
    MOCKER_CPP(&Engine::TaskFinished)
        .stubs();
    uint16_t taskId = 0;
    rtError_t ret = AllocAndSendFlipTask(stm->GetMaxTaskId(), stm);
    EXPECT_EQ(ret, RT_ERROR_STREAM_ABORT_SEND_TASK_FAIL);
    DELETE_O(stm);
    DELETE_O(stubDevice);
}

TEST_F(StreamTest, stream_ProcFlipTask)
{
    RawDevice *stubDevice = new RawDevice(0);
    stubDevice->Init();
    Stream *stream = new Stream((Device *)stubDevice, 0);
    TaskInfo tsk = {};
    stream->streamId_ = 1;
    tsk.stream = stream;
    TaskInfo *task1 = &tsk;
    uint16_t flipNum = 1;
    rtError_t error = stream->ProcFlipTask(task1, flipNum);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(stream, task1->stream);
    EXPECT_EQ(TS_TASK_TYPE_FLIP, task1->type);
    EXPECT_EQ(flipNum, task1->u.flipTask.flipNumReport);
    DELETE_O(stream);
    DELETE_O(stubDevice);
}

TEST_F(StreamTest, SendFlipTask)
{
    RawDevice *stubDevice = new RawDevice(0);
    stubDevice->Init();
    Stream *stm = new Stream((Device *)stubDevice, 0);
    stm->streamId_ = 1;
    MOCKER_CPP_VIRTUAL(stm, &Stream::IsNeedSendFlipTask)
        .stubs()
        .will(returnValue(true));
    uint16_t taskId = 0;
    std::unique_ptr<Engine> engine_var = std::make_unique<AsyncHwtsEngine>(stubDevice);
    stm->SetTaskIdFlipNum(1U);
    rtError_t ret = engine_var->SendFlipTask(stm->GetMaxTaskId(), stm);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    DELETE_O(stm);
    DELETE_O(stubDevice);
}

TEST_F(StreamTest, SendFlipTaskAbort)
{
    RawDevice *stubDevice = new RawDevice(0);
    stubDevice->Init();
    Stream *stm = new Stream((Device *)stubDevice, 0);
    stm->streamId_ = 1;
    MOCKER_CPP_VIRTUAL(stm, &Stream::IsNeedSendFlipTask)
        .stubs()
        .will(returnValue(true));
    uint16_t taskId = 0;
    std::unique_ptr<Engine> engine_var = std::make_unique<AsyncHwtsEngine>(stubDevice);
    MOCKER_CPP_VIRTUAL(engine_var.get(), &Engine::SendTask)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_STREAM_ABORT_SEND_TASK_FAIL))
        .then(returnValue(RT_ERROR_COMMON_BASE));
    stm->SetTaskIdFlipNum(1U);
    rtError_t ret = engine_var->SendFlipTask(stm->GetMaxTaskId(), stm);
    EXPECT_EQ(ret, RT_ERROR_STREAM_ABORT_SEND_TASK_FAIL);
    DELETE_O(stm);
    DELETE_O(stubDevice);
}

TEST_F(StreamTest, PushFlipTask)
{
    RawDevice *stubDevice = new RawDevice(0);
    stubDevice->Init();
    Stream *stm = new Stream((Device *)stubDevice, 0);
    stm->streamId_ = 1;
    MOCKER_CPP_VIRTUAL(stm, &Stream::IsNeedSendFlipTask)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&AsyncHwtsEngine::SubmitPush)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    std::unique_ptr<AsyncHwtsEngine> engine_var = std::make_unique<AsyncHwtsEngine>(stubDevice);
    stm->SetTaskIdFlipNum(1U);
    rtError_t ret = engine_var->PushFlipTask(stm->GetMaxTaskId(), stm);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    DELETE_O(stm);
    DELETE_O(stubDevice);
}

TEST_F(StreamTest, stream_GetRecycleTaskHeadId)
{
    RawDevice *stubDevice = new RawDevice(0);
    stubDevice->Init();
    Stream *stream = new Stream((Device *)stubDevice, 0);
    stream->streamId_ = 1;
    uint32_t currentId = UINT32_MAX;
    MOCKER_CPP_VIRTUAL(stubDevice, &RawDevice::TaskReclaim)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), outBound(currentId))
        .will(returnValue(RT_ERROR_NONE));

    uint16_t tailTaskId = 10;
    uint16_t recycleTaskId = 0;
    rtError_t error = stream->GetRecycleTaskHeadId(tailTaskId, recycleTaskId);
    EXPECT_EQ(error, RT_ERROR_STREAM_EMPTY);
    delete stream;
    delete stubDevice;
}

TEST_F(StreamTest, GetLastTaskIdFromCqShm_notNull)
{
    rtError_t error;
    rtEvent_t event;

    Device *dev = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    EXPECT_NE(dev, (Device*)NULL);

    Stream stream(dev, 0);
    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint32_t taskId = 0;
    error = stream.GetLastTaskIdFromCqShm(taskId);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ((Runtime *)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(StreamTest, stream_ProcL2AddrTask)
{
    RawDevice *stubDevice = new RawDevice(0);
    stubDevice->Init();
    Stream *stream = new Stream((Device *)stubDevice, 0);
    TaskInfo tsk = {};
    stream->streamId_ = 1;
    tsk.stream = stream;
    TaskInfo *task1 = &tsk;
    rtError_t error = stream->ProcL2AddrTask(task1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete stream;
    delete stubDevice;
}

TEST_F(StreamTest, stream_ProcL2AddrTask2)
{
    RawDevice *device = new RawDevice(0);
    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::GetRunMode).stubs()
                       .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);

    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    TaskResManage taskResMng;
    stream->taskResMang_ = &taskResMng;
    TaskInfo tsk = {};
    TaskInfo *task1 = &tsk;
    rtError_t error = stream->ProcL2AddrTask(task1);
    stream->taskResMang_ = nullptr;

    delete stream;
    delete device;
}

TEST_F(StreamTest, TaskFactoryFreeById)
{
    RawDevice *stubDevice = new RawDevice(0);
    stubDevice->Init();

    Stream *stm = new Stream((Device *)stubDevice, 0);
    EXPECT_NE(stm, nullptr);
    stm->streamId_ = 1;
    TaskAllocator *allocator = new (std::nothrow) TaskAllocator(128);
    allocator->FreeById(stm, 0, 0);

    delete allocator;
    stm->streamId_ = 65536;
    delete stm;
    delete stubDevice;
}

TEST_F(StreamTest, davinci_task_add_test)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    Stream *stream = new Stream(device, 0);

    stream->davinciTaskListSize_ = STREAM_PUBLIC_TASK_BUFF_SIZE;
    stream->davinciTaskList_ = new (std::nothrow) uint32_t[STREAM_PUBLIC_TASK_BUFF_SIZE];
    stream->taskPublicBuffSize_ = STREAM_PUBLIC_TASK_BUFF_SIZE;
    stream->taskPublicBuff_ = new (std::nothrow) uint32_t[STREAM_PUBLIC_TASK_BUFF_SIZE];
    EXPECT_NE(stream->davinciTaskList_, nullptr);


    stream->SetIsSupportASyncRecycle(true);

    EXPECT_EQ(stream->GetIsSupportASyncRecycle(), true);

    // DavinciKernelTask
    TaskInfo task = {};
    InitByStream(&task, stream);
    AicpuTaskInit(&task, 1, 0);
    task.u.aicpuTaskInfo.aicpuKernelType = (static_cast<uint32_t>(TS_AICPU_KERNEL_AICPU));
    stream->AddTaskToStream(&task);
    EXPECT_EQ(stream->davinciTaskTail_, 1);

    delete stream;
    delete device;
}

TEST_F(StreamTest, davinci_task_add_full_test)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    Stream *stream = new Stream(device, 0);
    stream->davinciTaskListSize_ = STREAM_PUBLIC_TASK_BUFF_SIZE;
    stream->davinciTaskList_ = new (std::nothrow) uint32_t[STREAM_PUBLIC_TASK_BUFF_SIZE];
    stream->taskPublicBuffSize_ = STREAM_PUBLIC_TASK_BUFF_SIZE;
    stream->taskPublicBuff_ = new (std::nothrow) uint32_t[STREAM_PUBLIC_TASK_BUFF_SIZE];
    EXPECT_NE(stream->davinciTaskList_, nullptr);

    stream->SetIsSupportASyncRecycle(true);

    EXPECT_EQ(stream->GetIsSupportASyncRecycle(), true);

    // DavinciKernelTask
    TaskInfo task = {};
    InitByStream(&task, stream);
    AicpuTaskInit(&task, 1, 0);
    task.u.aicpuTaskInfo.aicpuKernelType = static_cast<uint32_t>(TS_AICPU_KERNEL_AICPU);

    for (int i = 0; i < STREAM_PUBLIC_TASK_BUFF_SIZE; i++) {
        stream->AddTaskToStream(&task);
    }

    EXPECT_EQ((stream->davinciTaskTail_ + 1) % STREAM_PUBLIC_TASK_BUFF_SIZE, stream->taskHead_);

    delete stream;
    delete device;
}

TEST_F(StreamTest, davinci_task_recycle_test)
{
    RawDevice *device = new RawDevice(0);
    MOCKER_CPP(&Stream::CheckASyncRecycle).stubs().will(returnValue(true));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);

    Stream *stream = new Stream(device, 0);
    stream->Setup();
    // stream->isLite = false;
    stream->SetStreamAsyncRecycleFlag(true);
    EXPECT_NE(stream->davinciTaskList_, nullptr);
    EXPECT_NE(stream->taskPublicBuff_, nullptr);
    EXPECT_EQ(stream->GetIsSupportASyncRecycle(), true);

    rtError_t errCode = RT_ERROR_NONE;
    TaskInfo *task = device->GetTaskFactory()->Alloc(stream, TS_TASK_TYPE_KERNEL_AICORE, errCode);
    EXPECT_NE(task, nullptr);

    AicTaskInit(task, 0, 1, 0, nullptr);
    stream->AddTaskToStream(task);
    EXPECT_EQ(stream->davinciTaskTail_, 1);
    stream->SetIsSupportASyncRecycle(false);

    MOCKER_CPP(&TaskFactory::GetTask).stubs().will(returnValue(task));

    uint32_t taskId = task->id;
    bool result = device->engine_->ProcessTask(task, 0);
    EXPECT_EQ(result, false);

    uint32_t pendNumOld = device->engine_->GetPendingNum();
    device->engine_->pendingNum_.Add(1);
    EXPECT_EQ(device->engine_->GetPendingNum(), 1 + pendNumOld);
    ((Runtime *)Runtime::Instance())->SetDisableThread(true);
    result = device->engine_->ProcessTaskDavinciList(stream, taskId, 0);
    EXPECT_EQ(device->engine_->GetPendingNum(), pendNumOld);
    ((Runtime *)Runtime::Instance())->SetDisableThread(false);

    delete stream;
    delete device;
}

TEST_F(StreamTest, davinci_task_list_excption_test)
{
    RawDevice *device = new RawDevice(0);
    bool disableThreadFlag = ((Runtime *)Runtime::Instance())->GetDisableThread();

    device->Init();
    uint16_t taskId;
    uint16_t delTaskId;
    rtError_t result;
    Stream *stream = new Stream(device, 0);
    result = stream->TryDelDavinciRecordedTask(taskId, &delTaskId);
    EXPECT_EQ(result, RT_ERROR_STREAM_EMPTY);

    ((Runtime *)Runtime::Instance())->SetDisableThread(true);
    result = stream->TryDelDavinciRecordedTask(taskId, &delTaskId);
    EXPECT_EQ(result, RT_ERROR_STREAM_EMPTY);

    ((Runtime *)Runtime::Instance())->SetDisableThread(disableThreadFlag);

    delete stream;
    delete device;
}

TEST_F(StreamTest, davinci_task_del_test)
{
    RawDevice *device = new RawDevice(0);
    bool disableThreadFlag = ((Runtime *)Runtime::Instance())->GetDisableThread();

    NpuDriver drv;
    Engine *engine = new AsyncHwtsEngine(device);
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::GetRunMode).stubs()
                       .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));
    MOCKER_CPP_VIRTUAL(engine, &Engine::Start).stubs()
                       .will(returnValue((uint32_t)RT_ERROR_NONE));
    MOCKER_CPP(&Stream::CheckASyncRecycle).stubs().will(returnValue(true));

    device->Init();

    Stream *stream = new Stream(device, 0);
    stream->Setup();
    EXPECT_EQ(stream->GetIsSupportASyncRecycle(), true);

    // DavinciKernelTask
    TaskInfo task = {};
    InitByStream(&task, stream);
    AicTaskInit(&task, 0, 1, 0, nullptr);
    task.id = 1;
    stream->AddTaskToStream(&task);
    EXPECT_EQ(stream->davinciTaskTail_, 1);

    ((Runtime *)Runtime::Instance())->SetDisableThread(true);

    uint16_t taskId = stream->davinciTaskTail_;
    uint16_t delTaskId;
    rtError_t result;

    result = stream->TryDelDavinciRecordedTask(0, &delTaskId);
    EXPECT_EQ(result, RT_ERROR_STREAM_INVALID);

    result = stream->TryDelDavinciRecordedTask(taskId, &delTaskId);
    EXPECT_EQ(result, RT_ERROR_NONE);

    result = stream->TryDelDavinciRecordedTask(taskId, &delTaskId);
    EXPECT_EQ(result, RT_ERROR_STREAM_EMPTY);

    ((Runtime *)Runtime::Instance())->SetDisableThread(disableThreadFlag);

    delete stream;
    delete engine;
    delete device;
}

TEST_F(StreamTest, stream_sync_failure)
{
    RawDevice *device = new RawDevice(0);
    bool disableThreadFlag = ((Runtime *)Runtime::Instance())->GetDisableThread();

    MOCKER_CPP(&Stream::WaitForTask).stubs().will(returnValue(RT_ERROR_END_OF_SEQUENCE));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);
    Stream *stream = new Stream(device, 0);
    Context *ctx = new Context(device, 0);
    ctx->Init();

    stream->SetFailureMode(ABORT_ON_FAILURE);
    stream->context_ = ctx;
    stream->SetErrCode(0x95);
    stream->context_ = nullptr;
    ((Runtime *)Runtime::Instance())->SetDisableThread(true);
    rtError_t error = stream->Synchronize();
    EXPECT_EQ(error, RT_ERROR_END_OF_SEQUENCE);

    ((Runtime *)Runtime::Instance())->SetDisableThread(disableThreadFlag);

    delete ctx;
    delete stream;
    delete device;
}

TEST_F(StreamTest, stream_EnterFailureAbort)
{
    RawDevice *device = new RawDevice(0);
    bool disableThreadFlag = ((Runtime *)Runtime::Instance())->GetDisableThread();

    MOCKER_CPP(&Stream::WaitForTask).stubs().will(returnValue(RT_ERROR_END_OF_SEQUENCE));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);
    Stream *stream = new Stream(device, 0);
    stream->failureMode_ = STOP_ON_FAILURE;
    stream->EnterFailureAbort();
    EXPECT_EQ(stream->GetFailureMode(), 2);

    delete stream;
    delete device;
}

TEST_F(StreamTest, public_task_recycle_test)
{
    RawDevice *device = new RawDevice(0);
    MOCKER_CPP(&Stream::CheckASyncRecycle).stubs().will(returnValue(true));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);
    MOCKER_CPP_VIRTUAL(device->engine_, &Engine::WakeUpRecycleThread).stubs();

    Stream *stream = new Stream(device, 0);
    stream->Setup();
    // stream->isLite = false;
    stream->SetStreamAsyncRecycleFlag(true);
    EXPECT_NE(stream->davinciTaskList_, nullptr);
    EXPECT_NE(stream->taskPublicBuff_, nullptr);
    EXPECT_EQ(stream->GetIsSupportASyncRecycle(), true);

    rtError_t errCode = RT_ERROR_NONE;
    TaskInfo *task = device->GetTaskFactory()->Alloc(stream, TS_TASK_TYPE_KERNEL_AICORE, errCode);
    EXPECT_NE(task, nullptr);
    AicTaskInit(task, 0, 1, 0, nullptr);
    stream->AddTaskToStream(task);
    EXPECT_EQ(stream->davinciTaskTail_, 1);

    uint32_t taskId = task->id;
    uint16_t recycleTaskNum = 0;
    bool result = device->engine_->ProcessPublicTask(task, 0, &recycleTaskNum);
    EXPECT_EQ(result, false);

    device->GetTaskFactory()->Recycle(task);

    delete stream;
    delete device;
}

TEST_F(StreamTest, process_task_test)
{
    RawDevice *device = new RawDevice(0);
    MOCKER_CPP(&Engine::ProcessPublicTask).stubs().will(returnValue(true));
    MOCKER_CPP(&Engine::ProcessTaskDavinciList).stubs().will(returnValue(false));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);

    Stream *stream = new Stream(device, 0);
    stream->SetStreamAsyncRecycleFlag(false);
    stream->SetIsSupportASyncRecycle(true);
    EXPECT_EQ(stream->GetIsSupportASyncRecycle(), true);

    TaskInfo task = {};
    InitByStream(&task, stream);
    AicTaskInit(&task, 0, 1, 0, nullptr);
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AICORE);
    task.stream = stream;

    bool result = device->engine_->ProcessTask(&task, 0);
    EXPECT_EQ(result, true);

    task.stream = nullptr;

    delete stream;
    delete device;
}


TEST_F(StreamTest, tsch_stream_test)
{
    RawDevice *device = new RawDevice(0);
    device->Init();

    TschStream *tsStream = new TschStream(device, 0, SQ_ALLOC_TYPE_TS_FFTS_DSA);
    rtError_t error = tsStream->Setup();
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = tsStream->AllocDsaSqAddr();
    // EXPECT_EQ(error, RT_ERROR_NONE);

    delete tsStream;
    delete device;
}

TEST_F(StreamTest, StreamSetupTest)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream = new Stream(device, 0);

    MOCKER_CPP(&StreamSqCqManage::AllocStreamSqCq).stubs().will(returnValue(RT_ERROR_SQ_NO_EXIST_SQ_TO_REUSE));
    rtError_t ret = stream->Setup();
    ASSERT_EQ(ret, RT_ERROR_SQ_NO_EXIST_SQ_TO_REUSE);

    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(StreamTest, tsch_stream_error_test)
{
    RawDevice *device = new RawDevice(0);
    device->Init();

    MOCKER_CPP(&StreamSqCqManage::AllocStreamSqCq).stubs().will(returnValue(RT_ERROR_SQ_NO_EXIST_SQ_TO_REUSE));
    TschStream *tsStream = new TschStream(device, 0, SQ_ALLOC_TYPE_TS_FFTS_DSA);
    rtError_t error = tsStream->Setup();
    EXPECT_EQ(error, RT_ERROR_SQ_NO_EXIST_SQ_TO_REUSE);

    delete tsStream;
    delete device;
}

TEST_F(StreamTest, stream_setup_fail)
{
    RawDevice *device = new RawDevice(0);
    MOCKER_CPP(&Stream::CheckASyncRecycle).stubs().will(returnValue(true));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);

    Stream *stream = new Stream(device, 0);

    MOCKER(memset_s).stubs().will(returnValue(~EOK));
    stream->Setup();

    delete stream;
    delete device;
}

TEST_F(StreamTest, stream_delete_postotaskidmap)
{
    RawDevice *device = new RawDevice(0);
    MOCKER_CPP(&Stream::CheckASyncRecycle).stubs().will(returnValue(true));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);

    Stream *stream = new Stream(device, 0);
    stream->Setup();
    stream->DelPosToTaskIdMap(4097);
    stream->DelPosToTaskIdMap(0);

    delete stream;
    delete device;
}

TEST_F(StreamTest, get_max_trycount_test)
{
    RawDevice *device = new RawDevice(0);
    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::GetRunMode).stubs()
                       .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);

    Stream *stream = new Stream(device, 0);
    stream->SetStreamFastSync(true);
    stream->isModelExcel = true;
    stream->isModelComplete = true;

    EXPECT_EQ(stream->GetMaxTryCount(), 20);

    delete stream;
    delete device;
}



TEST_F(StreamTest, stars_get_max_trycount_test_1)
{
    RawDevice *device = new RawDevice(0);
    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::GetRunMode).stubs()
                       .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);

    Stream *stream = new Stream(device, 0);
    stream->pendingNum_.Add(1U);
    stream->SetStreamFastSync(true);
    stream->isModelExcel = true;
    stream->isModelComplete = true;

    EXPECT_EQ(stream->StarsGetMaxTryCount(), 10);

    stream->pendingNum_.Sub(1U);

    delete stream;
    delete device;
}

TEST_F(StreamTest, stars_get_max_trycount_test_2)
{
    RawDevice *device = new RawDevice(0);
    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::GetRunMode).stubs()
                       .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);

    Stream *stream = new Stream(device, 0);
    stream->pendingNum_.Add(1U);
    stream->SetStreamFastSync(true);
    stream->isModelExcel = false;
    stream->isModelComplete = false;

    EXPECT_EQ(stream->StarsGetMaxTryCount(), 200000);

    stream->pendingNum_.Sub(1U);

    delete stream;
    delete device;
}

TEST_F(StreamTest, IsDavinciTask)
{
    RawDevice *device = new RawDevice(0);
    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::GetRunMode).stubs()
                       .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);

    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);

    TaskInfo task = {};
    InitByStream(&task, stream);
    rtFftsPlusTaskInfo_t fftsPlusTaskInfo = {};
    rtFftsPlusSqe_t sqe = {};
    fftsPlusTaskInfo.fftsPlusSqe = &sqe;
    FftsPlusTaskInit(&task, &fftsPlusTaskInfo, 0);
    EXPECT_EQ(stream->IsDavinciTask(&task), false);
    stream->CreateArgRecycleList(STREAM_PUBLIC_TASK_BUFF_SIZE);
    stream->DestroyArgRecycleList(STREAM_PUBLIC_TASK_BUFF_SIZE);

    delete stream;
    delete device;
}

TEST_F(StreamTest, AddArgToRecycleList)
{
    RawDevice *device = new RawDevice(0);
    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::GetRunMode).stubs()
                       .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);

    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);

    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    task.u.aicTaskInfo.mixOpt = true;
    stream->CreateArgRecycleList(STREAM_PUBLIC_TASK_BUFF_SIZE);
    stream->AddArgToRecycleList(&task);

    TaskInfo task1 = {};
    task1.type = TS_TASK_TYPE_KERNEL_AICORE;
    task1.u.aicTaskInfo.mixOpt = false;
    stream->AddArgToRecycleList(&task1);

    TaskInfo task2 = {};
    task2.type = TS_TASK_TYPE_FUSION_KERNEL;
    stream->AddArgToRecycleList(&task2);
    stream->DestroyArgRecycleList(STREAM_PUBLIC_TASK_BUFF_SIZE);

    delete stream;
    delete device;
}

TEST_F(StreamTest, AddArgToRecycleListNoMix)
{
    RawDevice *device = new RawDevice(0);
    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::GetRunMode).stubs()
                       .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);

    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);

    TaskInfo task = {};
    task.u.aicTaskInfo.mixOpt = false;
    stream->CreateArgRecycleList(STREAM_PUBLIC_TASK_BUFF_SIZE);
    stream->AddArgToRecycleList(&task);
    stream->DestroyArgRecycleList(STREAM_PUBLIC_TASK_BUFF_SIZE);

    delete stream;
    delete device;
}

TEST_F(StreamTest, ProcArgRecycleList)
{
    RawDevice *device = new RawDevice(0);
    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::GetRunMode).stubs()
                       .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);

    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);

    TaskInfo task = {};
    task.u.aicTaskInfo.mixOpt = false;
    stream->CreateArgRecycleList(STREAM_PUBLIC_TASK_BUFF_SIZE);
    stream->AddArgToRecycleList(&task);
    stream->ProcArgRecycleList();;
    stream->DestroyArgRecycleList(STREAM_PUBLIC_TASK_BUFF_SIZE);

    delete stream;
    delete device;
}

TEST_F(StreamTest, GetStarsVersion)
{
    RawDevice *device = new RawDevice(0);
    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::GetRunMode).stubs()
                       .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);

    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);

    MOCKER_CPP(&TaskFactory::Alloc).stubs().will(returnValue((TaskInfo *)nullptr));

    stream->taskResMang_ = nullptr;
    rtError_t error = stream->GetStarsVersion();
    EXPECT_EQ(error, RT_ERROR_TASK_NEW);

    TaskResManage taskResMng;
    stream->taskResMang_ = &taskResMng;

    MOCKER_CPP_VIRTUAL(device, &RawDevice::SubmitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(AllocTaskAndSend).stubs().will(returnValue(RT_ERROR_NONE));

    stream->taskResMang_ = nullptr;

    delete stream;
    delete device;
}

TEST_F(StreamTest, GetErrorForAbortOnFailure)
{
    RawDevice *device = new RawDevice(0);
    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(&drv, &NpuDriver::GetRunMode).stubs()
                       .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);

    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);

    rtError_t error = stream->GetErrorForAbortOnFailure(RT_ERROR_STREAM_FULL);
    EXPECT_EQ(error, RT_ERROR_STREAM_FULL);

    stream->SetErrCode(RT_ERROR_TASK_NEW);
    error = stream->GetErrorForAbortOnFailure(RT_ERROR_STREAM_FULL);
    EXPECT_NE(error, RT_ERROR_STREAM_FULL);

    delete stream;
    delete device;
}

TEST_F(StreamTest, return_if_devstatus_not_normal_and_bindflag_true)
{
    RawDevice *device = new RawDevice(0);

    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);

    device->SetDevStatus(RT_ERROR_SOCKET_CLOSE);
    stream->SetBindFlag(true);

    delete stream;
    delete device;
}

TEST_F(StreamTest, StarsStmDfxCheck_test)
{
    RawDevice *device = new RawDevice(0);
    MOCKER_CPP(&Stream::CheckASyncRecycle).stubs().will(returnValue(true));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);
    MOCKER_CPP_VIRTUAL(device->engine_, &Engine::WakeUpRecycleThread).stubs();

    Stream *stream = new Stream(device, 0);
    stream->Setup();
    stream->SetStreamAsyncRecycleFlag(true);
    EXPECT_NE(stream->davinciTaskList_, nullptr);
    EXPECT_NE(stream->taskPublicBuff_, nullptr);
    EXPECT_EQ(stream->GetIsSupportASyncRecycle(), true);

    rtError_t errCode = RT_ERROR_NONE;
    TaskInfo *task = device->GetTaskFactory()->Alloc(stream, TS_TASK_TYPE_KERNEL_AICORE, errCode);
    EXPECT_NE(task, nullptr);
    AicTaskInit(task, 0, 1, 0, nullptr);
    stream->AddTaskToStream(task);
    EXPECT_EQ(stream->davinciTaskTail_, 1);

    uint64_t beginCnt = 0ULL;
    uint64_t endCnt = 0ULL;
    uint16_t checkCount = 0U;
    stream->StarsStmDfxCheck(beginCnt, endCnt, checkCount);
    EXPECT_NE(beginCnt, 0ULL);

    stream->StarsStmDfxCheck(beginCnt, endCnt, checkCount);
    EXPECT_NE(endCnt, 0ULL);

    stream->StarsShowStmDfxInfo();
    TaskResManage taskResMng;
    stream->taskResMang_ = &taskResMng;
    stream->ResetStreamConstruct();
    uint32_t taskId = task->id;
    uint16_t recycleTaskNum = 0;
    bool result = device->engine_->ProcessPublicTask(task, 0, &recycleTaskNum);
    EXPECT_EQ(result, false);

    device->GetTaskFactory()->Recycle(task);
    stream->taskResMang_ = nullptr;
    delete stream;
    delete device;
}

TEST_F(StreamTest, ShowDfxInfo_test)
{
    RawDevice *device = new RawDevice(0);
    MOCKER_CPP(&Stream::CheckASyncRecycle).stubs().will(returnValue(true));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);
    MOCKER_CPP_VIRTUAL(device->engine_, &Engine::WakeUpRecycleThread).stubs();

    Stream *stream = new Stream(device, 0);
    TaskResManage *taskRes = new (std::nothrow) TaskResManage();

    uint32_t taskPoolSize = taskRes->taskPoolNum_ * sizeof(TaskRes);
    uint8_t *taskResBaseAddr_ = new (std::nothrow) uint8_t[taskPoolSize];

    memset_s(taskResBaseAddr_, taskPoolSize, 0U, taskPoolSize);
    taskRes->taskRes_ = (TaskRes*)taskResBaseAddr_;
    stream->taskResMang_ = taskRes;
    (stream->taskResMang_)->ShowDfxInfo();
    stream->taskResMang_ = nullptr;
    taskRes->taskRes_ = nullptr;

    delete[] taskResBaseAddr_;
    delete taskRes;
    delete stream;
    delete device;
}

TEST_F(StreamTest, Apply_CntValue)
{
    RawDevice *device = new RawDevice(0);
    MOCKER_CPP(&Stream::CheckASyncRecycle).stubs().will(returnValue(true));
    device->Init();
    EXPECT_NE(device->engine_, nullptr);
    MOCKER_CPP_VIRTUAL(device->engine_, &Engine::WakeUpRecycleThread).stubs();
    Stream *stream = new Stream(device, 0);
    uint32_t cntValue = 0U;
    rtError_t error = stream->ApplyCntValue(cntValue);
    EXPECT_EQ(cntValue, 0);
    delete stream;
    delete device;
}

TEST_F(StreamTest, rtResClear_01)
{
    RawDevice *device = new RawDevice(0);

    device->Init();
    Stream *stream = new Stream(device, 0);
    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(device, &RawDevice::TaskReclaim)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device, &RawDevice::GetDevRunningState)
        .stubs()
        .will(returnValue(0U))
        .then(returnValue(1U));
    MOCKER_CPP_VIRTUAL(device, &RawDevice::DelStreamFromMessageQueue)
        .stubs()
        .will(returnValue(0));
    stream->pendingNum_.Set(1);
    stream->SetIsSupportASyncRecycle(true);
    rtError_t error = stream->ResClear();
    EXPECT_EQ(error, RT_ERROR_DRV_ERR);
    delete stream;
    delete device;
}

TEST_F(StreamTest, Query_test)
{
    const bool olgFlag = Runtime::Instance()->GetDisableThread();

    std::unique_ptr<RawDevice> device = std::make_unique<RawDevice>(0);
    device->Init();
    std::unique_ptr<Stream> stream = std::make_unique<Stream>(device.get(), 0);

    stream->SetBindFlag(true);
    rtError_t ret = stream->Query();
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    stream->SetBindFlag(false);
    Runtime::Instance()->SetDisableThread(false);
    ret = stream->Query();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    Runtime::Instance()->SetDisableThread(true);
    rtPlatformType_t oldPlatForm = device->platformType_;
    uint16_t sqHead = 0U;
    uint16_t sqTail = 1U;

    device->platformType_ = PLATFORM_CLOUD_V1;
    uint32_t lastTaskId = 1U;
    MOCKER_CPP_VIRTUAL(device.get(), &RawDevice::QueryLatestTaskId)
        .stubs()
        .with(mockcpp::any(), outBound(lastTaskId))
        .will(returnValue(RT_ERROR_NONE));
    ret = stream->Query();
    EXPECT_EQ(ret, RT_ERROR_STREAM_NOT_COMPLETE);

    device->platformType_ = oldPlatForm;
    Runtime::Instance()->SetDisableThread(olgFlag);
    GlobalMockObject::verify();
}

TEST_F(StreamTest, SetFailureMode)
{
    uint32_t num = Runtime::maxProgramNum_;
    std::unique_ptr<RawDevice> device = std::make_unique<RawDevice>(0);
    rtPlatformType_t oldPlatForm = device->platformType_;
    device->Init();
    std::unique_ptr<Stream> stream = std::make_unique<Stream>(device.get(), 0);
    device->platformType_ = PLATFORM_DC;
    Context * context = new Context(device.get(), true);
    stream->context_ = context;
    stream->taskResMang_ = nullptr;
    TaskInfo kernTask = {};
    kernTask.stream=stream.get();
    MOCKER_CPP(&Stream::AllocTask).stubs().will(returnValue(&kernTask));
    MOCKER_CPP_VIRTUAL(device.get(), &RawDevice::SubmitTask)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    Runtime::maxProgramNum_ = 0;
    rtError_t error = stream->SetFailMode(STOP_ON_FAILURE);
    EXPECT_EQ(error, RT_ERROR_NONE);
    device->platformType_ = oldPlatForm;
    delete context;
    Runtime::maxProgramNum_ = num;
    GlobalMockObject::verify(); 
}

TEST_F(StreamTest, GetTimeLineValue_err_01)
{
    rtError_t error;
    uint64_t ret;
    RawDevice *device = new RawDevice(0);
    MOCKER_CPP(&Stream::CheckASyncRecycle).stubs().will(returnValue(true));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);
    MOCKER_CPP_VIRTUAL(device->engine_, &Engine::WakeUpRecycleThread).stubs();

    MOCKER_CPP_VIRTUAL((NpuDriver*)(device->Driver_()),&NpuDriver::MemCopySync).stubs().will(returnValue((int32_t)RT_ERROR_DRV_MEMORY));
    Stream *stream = new Stream(device, 0);
    stream->timelineOffset_.insert(0);
    ret = stream->GetTimelineValue(0, 0);

    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete stream;
    delete device;
}

TEST_F(StreamTest, GetLastFinishTaskId_err)
{
    rtError_t error;
    uint64_t ret;
    RawDevice *device = new RawDevice(0);
    MOCKER_CPP(&Stream::CheckASyncRecycle).stubs().will(returnValue(true));

    device->Init();
    EXPECT_NE(device->engine_, nullptr);
    MOCKER_CPP_VIRTUAL(device->engine_, &Engine::WakeUpRecycleThread).stubs();

    MOCKER_CPP_VIRTUAL((NpuDriver*)(device->Driver_()),&NpuDriver::MemCopySync).stubs().will(returnValue((uint32_t)RT_ERROR_DRV_MEMORY));
    Stream *stream = new Stream(device, 0);
    uint32_t currId = 0;
    error = stream->GetLastFinishTaskId(0, currId, 100);
    EXPECT_NE(ret, RT_ERROR_NONE);
    delete stream;
    delete device;
}

TEST_F(StreamTest, IsStreamFull_True)
{
    RawDevice *device = new RawDevice(0);
    device->Init();
    Stream *stream = new Stream(device, 0);

    bool ret;
    uint32_t head = 5;
    uint32_t tail = 1;
    uint32_t depth = 8;
    uint32_t addCnt = 5;
    ret = stream->IsStreamFull(head, tail, depth, addCnt);
    EXPECT_EQ(ret, true);

    tail = 5;
    head = 0;
    addCnt = 3;
    ret = stream->IsStreamFull(head, tail, depth, addCnt);
    EXPECT_EQ(ret, true);

    delete stream;
    delete device;
}

TEST_F(StreamTest, GetTaskEventIdOrNotifyId)
{
    RawDevice *device = new RawDevice(0);
    device->Init();

    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);

    TaskInfo task = {};
    int32_t eventId = -1;
    uint32_t notifyId = MAX_UINT32_NUM;
    uint64_t devAddr = MAX_UINT64_NUM;
    InitByStream(&task, stream);

    task.type = TS_TASK_TYPE_EVENT_RECORD;
    task.u.eventRecordTaskInfo.eventid = 1;
    stream->GetTaskEventIdOrNotifyId(&task, eventId, notifyId, devAddr);
    EXPECT_EQ(eventId, 1);

    task.type = TS_TASK_TYPE_STREAM_WAIT_EVENT;
    task.u.eventWaitTaskInfo.eventId = 2;
    stream->GetTaskEventIdOrNotifyId(&task, eventId, notifyId, devAddr);
    EXPECT_EQ(eventId, 2);

    task.type = TS_TASK_TYPE_EVENT_RESET;
    task.u.eventResetTaskInfo.eventid = 3;
    stream->GetTaskEventIdOrNotifyId(&task, eventId, notifyId, devAddr);
    EXPECT_EQ(eventId, 3);

    task.type = TS_TASK_TYPE_NOTIFY_WAIT;
    task.u.notifywaitTask.notifyId = 4;
    stream->GetTaskEventIdOrNotifyId(&task, eventId, notifyId, devAddr);
    EXPECT_EQ(notifyId, 4);

    task.type = TS_TASK_TYPE_NOTIFY_RECORD;
    task.u.notifyrecordTask.notifyId = 5;
    stream->GetTaskEventIdOrNotifyId(&task, eventId, notifyId, devAddr);
    EXPECT_EQ(notifyId, 5);

    task.type = TS_TASK_TYPE_CAPTURE_RECORD;
    task.u.memWriteValueTask.devAddr = 5;
    stream->GetTaskEventIdOrNotifyId(&task, eventId, notifyId, devAddr);
    EXPECT_EQ(devAddr, 5);

    task.type = TS_TASK_TYPE_MEM_WRITE_VALUE;
    task.u.memWriteValueTask.devAddr = 6;
    stream->GetTaskEventIdOrNotifyId(&task, eventId, notifyId, devAddr);
    EXPECT_EQ(devAddr, 6);

    task.type = TS_TASK_TYPE_CAPTURE_WAIT;
    task.u.memWaitValueTask.devAddr = 7;
    stream->GetTaskEventIdOrNotifyId(&task, eventId, notifyId, devAddr);
    EXPECT_EQ(devAddr, 7);

    task.type = TS_TASK_TYPE_MEM_WAIT_VALUE;
    task.u.memWaitValueTask.devAddr = 8;
    stream->GetTaskEventIdOrNotifyId(&task, eventId, notifyId, devAddr);
    EXPECT_EQ(devAddr, 8);

    delete stream;
    delete device;
}

TEST_F(StreamTest, StreamFlagIsSupportCapture)
{
    bool flag = StreamFlagIsSupportCapture(8);
    EXPECT_EQ(flag, false);

    flag = StreamFlagIsSupportCapture(16);
    EXPECT_EQ(flag, false);

    flag = StreamFlagIsSupportCapture(2048);
    EXPECT_EQ(flag, false);

    flag = StreamFlagIsSupportCapture(4096);
    EXPECT_EQ(flag, false);

    flag = StreamFlagIsSupportCapture(0);
    EXPECT_EQ(flag, true);
}

TEST_F(StreamTest, stream_taskGrp_status)
{
    rtError_t error;
    bool flag;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *stm = static_cast<Stream *>(stream);
    error = stm->UpdateTaskGroupStatus(StreamTaskGroupStatus::BUTT);
    EXPECT_EQ(error, RT_ERROR_STREAM_TASKGRP_STATUS);

    error = stm->UpdateTaskGroupStatus(StreamTaskGroupStatus::SAMPLE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = stm->UpdateTaskGroupStatus(StreamTaskGroupStatus::SAMPLE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = stm->UpdateTaskGroupStatus(StreamTaskGroupStatus::UPDATE);
    EXPECT_EQ(error, RT_ERROR_STREAM_TASKGRP_STATUS);

    error = stm->UpdateTaskGroupStatus(StreamTaskGroupStatus::NONE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = stm->UpdateTaskGroupStatus(StreamTaskGroupStatus::UPDATE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = stm->UpdateTaskGroupStatus(StreamTaskGroupStatus::UPDATE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    flag = stm->IsTaskGrouping();
    EXPECT_EQ(flag, false);

    error = stm->UpdateTaskGroupStatus(StreamTaskGroupStatus::SAMPLE);
    EXPECT_EQ(error, RT_ERROR_STREAM_TASKGRP_STATUS);

    error = stm->UpdateTaskGroupStatus(StreamTaskGroupStatus::NONE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    flag = stm->IsTaskGrouping();
    EXPECT_EQ(flag, false);

    error = stm->UpdateTaskGroupStatus(StreamTaskGroupStatus::SAMPLE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    flag = stm->IsTaskGrouping();
    EXPECT_EQ(flag, true);

    flag = stm->IsTaskGroupBreak();
    EXPECT_EQ(flag, false);

    stm->SetTaskGroupErrCode(RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamTest, rtsStreamDestroy_default)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsStreamDestroy(stream, 0x0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamTest, rtsStreamDestroy_force)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsStreamDestroy(stream, 0x1);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamTest, rtsStreamDestroy_invalidFlags)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsStreamDestroy(stream, 0x2);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(StreamTest, rtsStreamAbort_normal) {
    rtStream_t stream;
    rtError_t error = RT_ERROR_NONE;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ts_ctrl_msg_body_t ack;
    ack.u.query_task_ack_info.status = 3;
    size_t count;
    count = sizeof(ts_ctrl_msg_body_t);
    MOCKER(halTsdrvCtl)
        .stubs()
	.with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP((void*)&ack, sizeof(ack)), outBoundP(&count, sizeof(count)))
        .will(returnValue(DRV_ERROR_NONE));

    MOCKER_CPP(&Context::IsStreamAbortSupported)
        .stubs()
        .will(returnValue(true));

    MOCKER(halSqCqFree)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER(halSqCqAllocate)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER_CPP(&StreamSqCqManage::UpdateStreamSqCq)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    error = rtsStreamAbort(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsStreamDestroy(stream, 0x0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamTest, rtsStreamSynchronize_noTimeLimit)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 5);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsStreamSynchronize(stream, -1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsStreamDestroy(stream, 0x0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamTest, rtsStreamSynchronize_withTimeout)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 5);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsStreamSynchronize(stream, 100);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsStreamDestroy(stream, 0x0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamTest, rtsStreamSynchronize_invalidTime1)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 5);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsStreamSynchronize(stream, 0);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsStreamDestroy(stream, 0x0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamTest, rtsStreamSynchronize_invalidTime2)
{
    rtError_t error;
    rtStream_t stream;

    error = rtStreamCreate(&stream, 5);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsStreamSynchronize(stream, -2);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsStreamDestroy(stream, 0x0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamTest, rtsStreamQuery_normal)
{
    rtStream_t stream;
    rtError_t error = RT_ERROR_NONE;

    error = rtStreamCreate(&stream, 0);
    Api *api = Api::Instance();
    MOCKER_CPP_VIRTUAL(api, &Api::StreamQuery).stubs().will(returnValue(RT_ERROR_NONE));
    error = rtsStreamQuery(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamDestroy(stream, 0x0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamTest, rtsStreamGetAvailableNum_normal)
{
    rtError_t error;
    uint32_t avaliStrCount1;
    error = rtsStreamGetAvailableNum(&avaliStrCount1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(StreamTest, stream_create_with_invalid_config) {
    rtError_t error;
    rtStream_t stream;
    rtStreamCreateConfig_t config;
    rtStreamCreateAttr_t attrs[1];
 
    // 配置无效id
    attrs[0].id = RT_STREAM_CREATE_ATTR_MAX;
    attrs[0].value.flags = 0; // 任意值，因为属性ID未知，值不会被使用
 
    config.attrs = attrs;
    config.numAttrs = 1;
 
    error = rtsStreamCreate(&stream, &config);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
}
 
TEST_F(StreamTest, stream_create_with_valid_config) {
    rtError_t error;
    rtStream_t stream;
    rtStreamCreateConfig_t config;
    rtStreamCreateAttr_t attrs[2];
 
    // 配置有效的FLAGS和PRIORITY
    attrs[0].id = RT_STREAM_CREATE_ATTR_FLAGS;
    attrs[0].value.flags = 8; // 假设8是有效的FLAGS值
    attrs[1].id = RT_STREAM_CREATE_ATTR_PRIORITY;
    attrs[1].value.priority = 5; // 有效PRIORITY值
 
 
    config.attrs = attrs;
    config.numAttrs = 2;
 
    error = rtsStreamCreate(&stream, &config);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // 清理资源
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamTest, stream_create_with_priority_out_of_range) 
{
    rtError_t error;
    rtStream_t stream;
    rtStreamCreateConfig_t config;
    rtStreamCreateAttr_t attrs[2];
 
    attrs[0].id = RT_STREAM_CREATE_ATTR_FLAGS;
    attrs[0].value.flags = 8;
    attrs[1].id = RT_STREAM_CREATE_ATTR_PRIORITY;
    attrs[1].value.priority = 8; // Out of range [0, 7]
 
    config.attrs = attrs;
    config.numAttrs = 2;
 
    error = rtsStreamCreate(&stream, &config);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamTest, get_priority_range)
{
    rtError_t error;
    int32_t leastPriority;
    int32_t greatestPriority;

    error = rtDeviceGetStreamPriorityRange(&leastPriority, &greatestPriority);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamTest, get_priority_range_with_nullptr)
{ 
    rtError_t error;
    int32_t leastPriority;
    int32_t greatestPriority;

    error = rtDeviceGetStreamPriorityRange(NULL, &greatestPriority);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceGetStreamPriorityRange(&leastPriority, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceGetStreamPriorityRange(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
 
TEST_F(StreamTest, stream_set_attribute1) {
    rtStream_t stream;
    rtError_t error;
    rtStreamAttrValue_t value;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_SET_STREAM_MODE);
    value.failureMode = RT_STREAM_FAILURE_MODE_CONTINUE_ON_FAILURE; // 假设这是一个有效的失败模式值
 
    // 创建流
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    // 设置属性
    error = rtsStreamSetAttribute(stream, RT_STREAM_ATTR_FAILURE_MODE, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    value.overflowSwitch = false; // 关闭溢出检测
    error = rtsStreamSetAttribute(stream, RT_STREAM_ATTR_FLOAT_OVERFLOW_CHECK, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    value.userCustomTag = 0; // 不使用自定义标签
    error = rtsStreamSetAttribute(stream, RT_STREAM_ATTR_USER_CUSTOM_TAG, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtsStreamSetAttribute(stream, RT_STREAM_ATTR_MAX, &value);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    error = rtsStreamSetAttribute(stream, RT_STREAM_ATTR_MAX, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    // 销毁流
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    device->SetTschVersion(version);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(StreamTest, stream_get_attribute1)
{
    rtError_t error;
    rtStreamAttrValue_t setvalue;
    rtStreamAttrValue_t stmModeRet;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_SET_STREAM_MODE);
 
    Stream *stream = nullptr;
    error = rtsStreamGetAttribute(stream, RT_STREAM_ATTR_MAX, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtsStreamGetAttribute(nullptr, RT_STREAM_ATTR_MAX, &stmModeRet);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    rtStream_t stm;
    error = rtStreamCreate(&stm, 0);
    stream = static_cast<Stream *>(stm);
 
    setvalue.failureMode = RT_STREAM_FAILURE_MODE_CONTINUE_ON_FAILURE; // 假设这是一个有效的失败模式值
    error = rtsStreamSetAttribute(stm, RT_STREAM_ATTR_FAILURE_MODE, &setvalue);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsStreamGetAttribute(stm, RT_STREAM_ATTR_FAILURE_MODE, &stmModeRet);
    EXPECT_EQ(stmModeRet.failureMode, RT_STREAM_FAILURE_MODE_CONTINUE_ON_FAILURE);
 
    setvalue = {0};
    setvalue.overflowSwitch = true; // 关闭溢出检测
    error = rtsStreamSetAttribute(stm, RT_STREAM_ATTR_FLOAT_OVERFLOW_CHECK, &setvalue);
    EXPECT_EQ(error, RT_ERROR_NONE);
    stmModeRet = {0};
    error = rtsStreamGetAttribute(stm, RT_STREAM_ATTR_FLOAT_OVERFLOW_CHECK, &stmModeRet);
    EXPECT_EQ(stmModeRet.overflowSwitch, true);
 
    setvalue = {0};
    setvalue.userCustomTag = 0; // 关闭溢出检测
    error = rtsStreamSetAttribute(stm, RT_STREAM_ATTR_USER_CUSTOM_TAG, &setvalue);
    EXPECT_EQ(error, RT_ERROR_NONE);
    stmModeRet = {0};
    error = rtsStreamGetAttribute(stm, RT_STREAM_ATTR_USER_CUSTOM_TAG, &stmModeRet);
    EXPECT_EQ(stmModeRet.userCustomTag, 0);
 
    error = rtStreamDestroy(stm);
    device->SetTschVersion(version);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(StreamTest, stream_update_stream_sqcq) {
    rtStream_t stream;
    rtError_t error = RT_ERROR_NONE;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    StreamSqCqManage manage(nullptr);
    std::shared_ptr<RawDevice> dev = std::make_shared<RawDevice>(0);
    dev->Init();
    manage.device_ = dev.get();
    Stream *streamPtr = static_cast<Stream *>(stream);
    manage.UpdateStreamSqCq(streamPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    streamPtr->SetSqBaseAddr(1);
    MOCKER_CPP_VIRTUAL((NpuDriver*)(dev->Driver_()),&NpuDriver::GetSqAddrInfo).stubs().will(returnValue((int32_t)RT_ERROR_NONE));
    manage.UpdateStreamSqCq(streamPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsStreamDestroy(stream, 0x0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamTest, StreamSetupCreateRecycleListTest)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream = new Stream(device, 0);

    MOCKER_CPP(&StreamSqCqManage::AllocStreamSqCq).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::AllocLogicCq).stubs().will(returnValue(RT_ERROR_NONE));
    stream->isSupportASyncRecycle_ = true;
    stream->isHasPcieBar_ = true;
    ((Runtime *)Runtime::Instance())->disableThread_ = false;
    MOCKER_CPP(&Stream::SubmitCreateStreamTask).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    rtError_t ret = stream->Setup();
    ASSERT_EQ(ret, RT_ERROR_INVALID_VALUE);

    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(StreamTest, Test_CreateStreamAndGet)
{
    rtError_t error;
    RawDevice* device= (RawDevice*)((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);

    MOCKER_CPP(&StreamSqCqManage::AllocStreamSqCq).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::AllocLogicCq).stubs().will(returnValue(RT_ERROR_NONE));

    //stream create
    rtStream_t streamTest;
    error = rtStreamCreateWithFlags(&streamTest, 0, RT_STREAM_CP_PROCESS_USE);
    EXPECT_NE(error, RT_ERROR_NONE);

    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(StreamTest, public_queue)
{
    RawDevice* device= (RawDevice*)((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    
    Stream stream(device, 0);
    uint16_t delTaskPos;
    uint16_t endRecylePos = 10;
    TaskInfo workTask = {};
    stream.finishTaskId_ = 10;
    EXPECT_EQ(stream.StarsGetPublicTaskHead(&workTask, true, endRecylePos, &delTaskPos), RT_ERROR_STREAM_EMPTY);

    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(StreamTest, rtsLaunchHostFunc00)
{
    rtError_t error;
    rtStream_t stream;
    uint32_t cqId = 0;
    uint32_t sqId = 0;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsLaunchHostFunc(stream, ApiTest_Stream_Cb, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsLaunchHostFunc(NULL, ApiTest_Stream_Cb, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamSynchronize(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}