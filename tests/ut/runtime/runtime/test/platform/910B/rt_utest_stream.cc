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
#include <algorithm>
#include <atomic>
#include <chrono>
#include <thread>
#include <vector>

#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#define protected public
#include "engine.hpp"
#include "stars_engine.hpp"
#include "event.hpp"
#include "task_res.hpp"
#include "task.hpp"
#include "ctrl_stream.hpp"
#include "coprocessor_stream.hpp"
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
#include "osal.hpp"
#include "api_impl.hpp"
#include <cerrno>
#include "npu_driver.hpp"
#include "task_submit.hpp"
#include "task_recycle.hpp"
#include "capture_model_utils.hpp"
#include "rt_unwrap.h"
#include "thread_local_container.hpp"
#include "capture_adapt.hpp"
#include "memory_task.h"
#include "task.hpp"
using namespace testing;
using namespace cce::runtime;

static uint16_t ind = 0;

class CloudV2StreamTest : public testing::Test {
protected:
    static void SetUpTestCase() { std::cout << "CloudV2StreamTest start" << std::endl; }

    static void TearDownTestCase() { std::cout << "CloudV2StreamTest end" << std::endl; }

    virtual void SetUp()
    {
        (void)rtSetDevice(0);
        rtError_t error;
        Runtime* rtInstance = const_cast<Runtime*>(Runtime::Instance());
        EXPECT_NE(rtInstance, nullptr);

        GlobalContainer::SetHardwareSocVersion("");
        std::cout << "ut test start." << std::endl;
    }

    virtual void TearDown()
    {
        std::cout << "ut test end." << std::endl;
        ind = 0;
        GlobalMockObject::verify();
        rtDeviceReset(0);
        Runtime* rtInstance = const_cast<Runtime*>(Runtime::Instance());
        EXPECT_NE(rtInstance, nullptr);
    }

public:
    static Api* oldApi_;
    static rtEvent_t event_;
    static void* binHandle_;
    static char function_;
    static uint32_t binary_[32];

private:
    rtChipType_t originType;
};

Api* CloudV2StreamTest::oldApi_ = nullptr;
rtEvent_t CloudV2StreamTest::event_ = nullptr;
void* CloudV2StreamTest::binHandle_ = nullptr;
char CloudV2StreamTest::function_ = 'a';
uint32_t CloudV2StreamTest::binary_[32] = {};

class SubmitFailSchedulerT : public FifoScheduler {
public:
    Scheduler* test;

    void set(Scheduler* fifoScheduler) { test = fifoScheduler; }

    virtual rtError_t PushTask(TaskInfo* task)
    {
        std::cout << "PushTask begin taskType = " << task->type << "ind = " << ind << std::endl;
        if (0 == ind) {
            ind = 1;
            std::cout << "PushTask begin taskType = " << task->type << "ind = " << ind << std::endl;
            return test->PushTask(task);
            // return  FifoScheduler::PushTask(task);
        }
        return RT_ERROR_INVALID_VALUE;
    }

    virtual TaskInfo* PopTask() { return test->PopTask(); }
};

static void ApiTest_Stream_Cb(void* arg) {}

TEST_F(CloudV2StreamTest, stream_set_attribute2)
{
    rtStream_t stream;
    rtError_t error;
    rtStreamAttrValue_t value;
    Device* device = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
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
    ((Runtime*)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2StreamTest, stream_get_attribute2)
{
    rtError_t error;
    rtStreamAttrValue_t setvalue;
    rtStreamAttrValue_t stmModeRet;
    Device* device = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_SET_STREAM_MODE);

    Stream* stream = nullptr;
    error = rtsStreamGetAttribute(stream, RT_STREAM_ATTR_MAX, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtsStreamGetAttribute(nullptr, RT_STREAM_ATTR_MAX, &stmModeRet);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    rtStream_t stm;
    error = rtStreamCreate(&stm, 0);
    stream = rt_ut::UnwrapOrNull<Stream>(stm);

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
    EXPECT_EQ(stmModeRet.overflowSwitch, 1);

    setvalue = {0};
    setvalue.userCustomTag = 0; // 关闭溢出检测
    error = rtsStreamSetAttribute(stm, RT_STREAM_ATTR_USER_CUSTOM_TAG, &setvalue);
    EXPECT_EQ(error, RT_ERROR_NONE);
    stmModeRet = {0};
    error = rtsStreamGetAttribute(stm, RT_STREAM_ATTR_USER_CUSTOM_TAG, &stmModeRet);
    EXPECT_EQ(stmModeRet.userCustomTag, 0);

    error = rtStreamDestroy(stm);
    device->SetTschVersion(version);
    ((Runtime*)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2StreamTest, rtsLaunchHostFunc01)
{
    rtError_t error;
    rtStream_t stream;
    uint32_t cqId = 0;
    uint32_t sqId = 0;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsLaunchHostFunc(stream, ApiTest_Stream_Cb, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsLaunchHostFunc(stream, ApiTest_Stream_Cb, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamSynchronize(stream);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, Query_test)
{
    std::unique_ptr<RawDevice> device = std::make_unique<RawDevice>(0);
    device->Init();
    std::unique_ptr<Stream> stream = std::make_unique<Stream>(device.get(), 0);

    rtChipType_t oldChipType = device->chipType_;
    uint16_t sqHead = 0U;
    uint16_t sqTail = 1U;
    device->chipType_ = CHIP_910_B_93;
    rtError_t ret = stream->Query();
    EXPECT_NE(ret, RT_ERROR_NONE);

    device->chipType_ = oldChipType;
    GlobalMockObject::verify();
}

TEST_F(CloudV2StreamTest, TestIsTaskLimitedWithTaskFinished)
{
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    Device* device = rtInstance->DeviceRetain(0, 0);
    ASSERT_NE(device, nullptr);
    const ScopeGuard releaseDevice([rtInstance, device]() { rtInstance->DeviceRelease(device); });
    Stream stream(device, 0);
    stream.waitTaskList_.push_back(512);
    TaskInfo task = {};
    stream.SynchronizeDelayTime(0, 2);
    bool ret = stream.IsTaskLimited(&task);
    ASSERT_EQ(ret, false);
}

TEST_F(CloudV2StreamTest, TestIsTaskLimitedWithTaskTypeUnexpected)
{
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    Device* device = rtInstance->DeviceRetain(0, 0);
    ASSERT_NE(device, nullptr);
    const ScopeGuard releaseDevice([rtInstance, device]() { rtInstance->DeviceRelease(device); });
    Stream stream(device, 0);
    stream.waitTaskList_.push_back(512);
    TaskInfo aicoreTask = {};
    aicoreTask.type = TS_TASK_TYPE_KERNEL_AICORE;
    MOCKER_CPP(&TaskFactory::GetTask).stubs().will(returnValue(&aicoreTask));
    TaskInfo task = {};
    bool ret = stream.IsTaskLimited(&task);
    ASSERT_EQ(ret, false);
}

TEST_F(CloudV2StreamTest, EngineStreamObserver_TaskSubmited)
{
    std::shared_ptr<RawDevice> device = std::make_shared<RawDevice>(0);
    MOCKER_CPP_VIRTUAL(device.get(), &RawDevice::SubmitTask).stubs().will(returnValue(RT_ERROR_NONE));
    device->Init();
    std::shared_ptr<Stream> stream = std::make_shared<Stream>(device.get(), 0);
    stream->SetNeedSubmitTask(true);
    std::shared_ptr<Model> model = std::make_shared<Model>();
    stream->SetModel(model.get());
    TaskInfo task = {0};
    task.stream = stream.get();

    std::shared_ptr<EngineStreamObserver> streamObserver = std::make_shared<EngineStreamObserver>();
    EXPECT_EQ(stream->GetPendingNum(), 0);
    streamObserver->TaskSubmited(device.get(), &task);
    EXPECT_EQ(stream->GetPendingNum(), 1);
}

TEST_F(CloudV2StreamTest, rtGetAvailStreamNum)
{
    rtError_t error;
    uint32_t avaliStrCount;

    error = rtGetAvailStreamNum(RT_NORMAL_STREAM, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetAvailStreamNum(RT_NORMAL_STREAM, &avaliStrCount);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    error = rtGetAvailStreamNum(RT_NORMAL_STREAM, &avaliStrCount);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtGetAvailStreamNum(RT_HUGE_STREAM, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetAvailStreamNum(RT_HUGE_STREAM, &avaliStrCount);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halResourceInfoQuery).stubs().will(returnValue(code));
    error = rtGetAvailStreamNum(RT_NORMAL_STREAM, &avaliStrCount);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetAvailStreamNum(RT_NORMAL_STREAM, &avaliStrCount);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2StreamTest, GetCurrentRunningTaskInfo_01)
{
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    Device* device = rtInstance->DeviceRetain(0, 0);
    rtStream_t stm;
    rtError_t error = rtStreamCreate(&stm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream* stream = rt_ut::UnwrapOrNull<Stream>(stm);

    ASSERT_NE(stream, nullptr);
    ASSERT_NE(stream->posToTaskIdMap_, nullptr);
    (void)memset_s(
        stream->posToTaskIdMap_, stream->posToTaskIdMapSize_ * sizeof(uint16_t), 0xFF,
        stream->posToTaskIdMapSize_ * sizeof(uint16_t));
    MOCKER_CPP(&Stream::IsSoftwareSqEnable).stubs().will(returnValue(true));
    uint16_t taskId = 0U;
    tsTaskType_t taskType = TS_TASK_TYPE_RESERVED;
    const char_t* taskTypeName = nullptr;
    stream->GetCurrentRunningTaskInfo(taskId, taskType, taskTypeName);

    EXPECT_EQ(taskId, MAX_UINT16_NUM);
    EXPECT_EQ(taskType, TS_TASK_TYPE_RESERVED);

    GlobalMockObject::verify();
    EXPECT_EQ(rtStreamDestroy(stm), RT_ERROR_NONE);
    rtInstance->DeviceRelease(device);
}

TEST_F(CloudV2StreamTest, GetCurrentRunningTaskInfo_02)
{
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    Device* device = rtInstance->DeviceRetain(0, 0);
    rtStream_t stm;
    rtError_t error = rtStreamCreate(&stm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream* stream = rt_ut::UnwrapOrNull<Stream>(stm);

    ASSERT_NE(stream, nullptr);
    ASSERT_NE(stream->posToTaskIdMap_, nullptr);
    stream->taskHead_ = 0U;
    (void)memset_s(
        stream->posToTaskIdMap_, stream->posToTaskIdMapSize_ * sizeof(uint16_t), 0xFF,
        stream->posToTaskIdMapSize_ * sizeof(uint16_t));
    MOCKER_CPP(&Stream::IsSoftwareSqEnable).stubs().will(returnValue(true));
    uint16_t taskId = 0U;
    tsTaskType_t taskType = TS_TASK_TYPE_RESERVED;
    const char_t* taskTypeName = nullptr;
    stream->GetCurrentRunningTaskInfo(taskId, taskType, taskTypeName);

    EXPECT_EQ(taskId, MAX_UINT16_NUM);
    EXPECT_EQ(taskType, TS_TASK_TYPE_RESERVED);

    GlobalMockObject::verify();
    EXPECT_EQ(rtStreamDestroy(stm), RT_ERROR_NONE);
    rtInstance->DeviceRelease(device);
}

TEST_F(CloudV2StreamTest, GetCurrentRunningTaskInfo_03)
{
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    Device* device = rtInstance->DeviceRetain(0, 0);
    rtStream_t stm;
    rtError_t error = rtStreamCreate(&stm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream* stream = rt_ut::UnwrapOrNull<Stream>(stm);

    ASSERT_NE(stream, nullptr);
    ASSERT_NE(stream->posToTaskIdMap_, nullptr);
    stream->taskHead_ = 0U;
    (void)memset_s(
        stream->posToTaskIdMap_, stream->posToTaskIdMapSize_ * sizeof(uint16_t), 0U,
        stream->posToTaskIdMapSize_ * sizeof(uint16_t));
    MOCKER_CPP(&Device::IsDavidPlatform).stubs().will(returnValue(true));
    MOCKER_CPP(&Stream::IsSoftwareSqEnable).stubs().will(returnValue(false));
    MOCKER_CPP(&Stream::IsAutoSplitSq).stubs().will(returnValue(false));
    uint16_t taskId = 0U;
    tsTaskType_t taskType = TS_TASK_TYPE_RESERVED;
    const char_t* taskTypeName = nullptr;
    tagTaskInfoStru mockTaskInfo = {};
    mockTaskInfo.typeName = "KERNEL_AICORE";
    mockTaskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    MOCKER_CPP_VIRTUAL(stream->taskResMang_, &TaskResManage::GetTaskInfo).stubs().will(returnValue(&mockTaskInfo));

    stream->GetCurrentRunningTaskInfo(taskId, taskType, taskTypeName);
    EXPECT_EQ(taskId, 0U);
    EXPECT_EQ(taskType, TS_TASK_TYPE_KERNEL_AICORE);

    GlobalMockObject::verify();
    EXPECT_EQ(rtStreamDestroy(stm), RT_ERROR_NONE);
    rtInstance->DeviceRelease(device);
}

TEST_F(CloudV2StreamTest, NeedUpdateMemcpyTaskInfoForSnapshot_1D_NotOnlineMode_Skip)
{
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    Device* device = rtInstance->DeviceRetain(0, 0);
    ASSERT_NE(device, nullptr);
    Stream* stream = new Stream(device, 0);
    ASSERT_NE(stream, nullptr);

    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_MEMCPY;
    taskInfo.stream = stream;
    taskInfo.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_H2D;
    taskInfo.u.memcpyAsyncTaskInfo.copyMethod = static_cast<uint8_t>(rtAsyncCpyMethod::RT_ASYNC_CPY);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::GetRunMode).stubs().will(returnValue((uint32_t)RT_RUN_MODE_OFFLINE));

    EXPECT_FALSE(NeedUpdateMemcpyTaskInfoForSnapshot(&taskInfo));

    GlobalMockObject::verify();
    delete stream;
    rtInstance->DeviceRelease(device);
}

TEST_F(CloudV2StreamTest, UpdateMemcpyTaskInfoForSnapshot_1D_MemConvertAddrSuccess)
{
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    Device* device = rtInstance->DeviceRetain(0, 0);
    ASSERT_NE(device, nullptr);
    Stream* stream = new Stream(device, 0);
    ASSERT_NE(stream, nullptr);

    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_MEMCPY;
    taskInfo.stream = stream;
    taskInfo.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_H2D;
    taskInfo.u.memcpyAsyncTaskInfo.src = reinterpret_cast<void*>(0x1000);
    taskInfo.u.memcpyAsyncTaskInfo.desPtr = reinterpret_cast<void*>(0x2000);
    taskInfo.u.memcpyAsyncTaskInfo.copySize = 512;
    taskInfo.u.memcpyAsyncTaskInfo.size = 512;
    taskInfo.u.memcpyAsyncTaskInfo.copyMethod = static_cast<uint8_t>(rtAsyncCpyMethod::RT_ASYNC_CPY);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::GetRunMode).stubs().will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemConvertAddr).stubs().will(returnValue(RT_ERROR_NONE));

    rtError_t error = UpdateMemcpyTaskInfoForSnapshot(&taskInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
    delete stream;
    rtInstance->DeviceRelease(device);
}

TEST_F(CloudV2StreamTest, UpdateMemcpyTaskInfoForSnapshot_2D_MemCopy2DFailed)
{
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    Device* device = rtInstance->DeviceRetain(0, 0);
    ASSERT_NE(device, nullptr);
    Stream* stream = new Stream(device, 0);
    ASSERT_NE(stream, nullptr);

    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_MEMCPY;
    taskInfo.stream = stream;
    taskInfo.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_H2D;
    taskInfo.u.memcpyAsyncTaskInfo.copyMethod = static_cast<uint8_t>(rtAsyncCpyMethod::RT_ASYNC_CPY_2D);
    taskInfo.u.memcpyAsyncTaskInfo.dstPitch = 256;
    taskInfo.u.memcpyAsyncTaskInfo.srcPitch = 256;
    taskInfo.u.memcpyAsyncTaskInfo.width = 128;
    taskInfo.u.memcpyAsyncTaskInfo.height = 2;
    taskInfo.u.memcpyAsyncTaskInfo.fixedSize = 256;
    taskInfo.u.memcpyAsyncTaskInfo.copyKind = RT_MEMCPY_HOST_TO_DEVICE;

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopy2D).stubs().will(returnValue(RT_ERROR_DRV_NOT_SUPPORT));

    rtError_t error = UpdateMemcpyTaskInfoForSnapshot(&taskInfo);
    EXPECT_NE(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
    delete stream;
    rtInstance->DeviceRelease(device);
}

TEST_F(CloudV2StreamTest, StreamUpdateSnapShotSqe_RoutingToSoftwareSq)
{
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    Device* device = rtInstance->DeviceRetain(0, 0);
    ASSERT_NE(device, nullptr);
    Stream* stream = new Stream(device, 0);
    ASSERT_NE(stream, nullptr);

    stream->SetSoftWareSqEnable();
    MOCKER_CPP(&Stream::UpdateHostSqeForSnapshot).stubs().will(returnValue(RT_ERROR_NONE));

    rtError_t error = stream->UpdateSnapShotSqe();
    EXPECT_EQ(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
    delete stream;
    rtInstance->DeviceRelease(device);
}

TEST_F(CloudV2StreamTest, StreamUpdateSnapShotSqe_RoutingToDeviceSq)
{
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    Device* device = rtInstance->DeviceRetain(0, 0);
    ASSERT_NE(device, nullptr);
    Stream* stream = new Stream(device, 0);
    ASSERT_NE(stream, nullptr);

    MOCKER_CPP(&Stream::UpdateDeviceSqeForSnapshot).stubs().will(returnValue(RT_ERROR_NONE));

    rtError_t error = stream->UpdateSnapShotSqe();
    EXPECT_EQ(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
    delete stream;
    rtInstance->DeviceRelease(device);
}

TEST_F(CloudV2StreamTest, StreamUpdateHostSqeForSnapshot_EmptyTaskList)
{
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    Device* device = rtInstance->DeviceRetain(0, 0);
    ASSERT_NE(device, nullptr);
    Stream* stream = new Stream(device, 0);
    ASSERT_NE(stream, nullptr);

    rtError_t error = stream->UpdateHostSqeForSnapshot();
    EXPECT_EQ(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
    delete stream;
    rtInstance->DeviceRelease(device);
}

TEST_F(CloudV2StreamTest, StreamUpdateSnapShotSqe_RoutingToSoftwareSq_EmptyList)
{
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    Device* device = rtInstance->DeviceRetain(0, 0);
    ASSERT_NE(device, nullptr);
    Stream* stream = new Stream(device, 0);
    ASSERT_NE(stream, nullptr);

    stream->SetSoftWareSqEnable();

    rtError_t error = stream->UpdateSnapShotSqe();
    EXPECT_EQ(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
    delete stream;
    rtInstance->DeviceRelease(device);
}

TEST_F(CloudV2StreamTest, StreamUpdateSnapShotSqe_RoutingToDeviceSq_EmptyList)
{
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    Device* device = rtInstance->DeviceRetain(0, 0);
    ASSERT_NE(device, nullptr);
    Stream* stream = new Stream(device, 0);
    ASSERT_NE(stream, nullptr);

    MOCKER_CPP(&Stream::UpdateDeviceSqeForSnapshot).stubs().will(returnValue(RT_ERROR_NONE));

    rtError_t error = stream->UpdateSnapShotSqe();
    EXPECT_EQ(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
    delete stream;
    rtInstance->DeviceRelease(device);
}

TEST_F(CloudV2StreamTest, SyncFuncArgsStartsWithNoNotification)
{
    rtError_t error = RT_ERROR_NONE;
    SyncFuncArgs* args = nullptr;
    error = CreateSyncFuncArgs(args);
    ASSERT_NE(args, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(args->currentCnt, 0U);
    ASSERT_EQ(pthread_mutex_trylock(&args->mutex), 0);
    EXPECT_EQ(pthread_mutex_unlock(&args->mutex), 0);
    DestroySyncFuncArgs(args);
}

TEST_F(CloudV2StreamTest, SyncFuncArgsCondAttributeFailureReturnsSystemError)
{
    MOCKER(pthread_condattr_init).stubs().will(returnValue(EINVAL));
    SyncFuncArgs* args = nullptr;
    EXPECT_EQ(CreateSyncFuncArgs(args), RT_ERROR_OS_HANDLE);
    EXPECT_EQ(args, nullptr);
}

TEST_F(CloudV2StreamTest, SyncScheduleEmptyStreamDoesNotSubmitCallback)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    const ScopeGuard destroyStream([&]() { EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE); });
    Stream* stream = rt_ut::UnwrapOrNull<Stream>(handle);
    Device* device = stream->Device_();
    const bool previousRecycleThread = device->GetIsChipSupportRecycleThread();
    device->SetIsChipSupportRecycleThread(true);
    const ScopeGuard restoreRecycleMode(
        [device, previousRecycleThread]() { device->SetIsChipSupportRecycleThread(previousRecycleThread); });
    ASSERT_TRUE(stream->IsSeparateSendAndRecycle());
    MOCKER_CPP_VIRTUAL(Runtime::Instance()->ApiImpl_(), &Api::LaunchHostFunc).expects(never());
    for (uint32_t mode : {RT_DEVICE_SCHEDULE_SPIN, RT_DEVICE_SCHEDULE_YIELD, RT_DEVICE_SCHEDULE_BLOCKING_SYNC}) {
        EXPECT_EQ(stream->Synchronize(false, 100, mode), RT_ERROR_NONE);
    }
    EXPECT_EQ(stream->GetSubscribeFlag(), StreamSubscribeFlag::SUBSCRIBE_NONE);
    GlobalMockObject::verify();
}

TEST_F(CloudV2StreamTest, SyncCompletionWithoutConcernedTaskWakesRecycleThread)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    Device* const device = stream->Device_();
    const uint32_t previousLastTaskId = stream->GetLastTaskId();
    stream->SetLastTaskId(4U);

    MOCKER_CPP_VIRTUAL(device, &Device::WakeUpRecycleThread).expects(exactly(2));
    MOCKER_CPP_VIRTUAL(stream, &Stream::SynchronizeExecutedTask)
        .expects(exactly(2))
        .with(eq(3U), mockcpp::any(), eq(100), eq(static_cast<uint32_t>(RT_DEVICE_SCHEDULE_AUTO)))
        .will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(stream->SynchronizeImpl(3U, MAX_UINT16_NUM, 100), RT_ERROR_NONE);
    EXPECT_EQ(stream->SynchronizeImpl(3U, MAX_UINT16_NUM, 100, RT_DEVICE_SCHEDULE_AUTO), RT_ERROR_NONE);

    stream->SetLastTaskId(previousLastTaskId);
    GlobalMockObject::verify();
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

namespace {
constexpr uint32_t SYNC_TEST_MODES[] = {
    RT_DEVICE_SCHEDULE_AUTO, RT_DEVICE_SCHEDULE_SPIN, RT_DEVICE_SCHEDULE_YIELD, RT_DEVICE_SCHEDULE_BLOCKING_SYNC};
rtCallback_t syncTestCallback = nullptr;
void* syncTestData = nullptr;
bool syncTestIsBlock = true;
uint32_t syncTestHeadQueries = 0U;
uint32_t syncTestYieldCalls = 0U;
uint32_t syncTestLegacyCalls = 0U;
bool syncTestLegacyWaitSyncCq = false;
int32_t syncTestLegacyTimeout = 0;

rtError_t RecordLegacySync(Stream*, uint32_t, bool waitSyncCq, int32_t timeout)
{
    ++syncTestLegacyCalls;
    syncTestLegacyWaitSyncCq = waitSyncCq;
    syncTestLegacyTimeout = timeout;
    return RT_ERROR_DRV_ERR;
}

void WaitPastSyncDeadline()
{
    const timespec delay{0, 20000000};
    (void)nanosleep(&delay, nullptr);
}

rtError_t ReclaimSyncAfterDeadline(const Stream*, bool, bool)
{
    WaitPastSyncDeadline();
    ++syncTestHeadQueries;
    return RT_ERROR_NONE;
}

rtError_t ReclaimDeviceSyncAfterDeadline(Device*, Stream*, bool, uint32_t& taskId)
{
    WaitPastSyncDeadline();
    ++syncTestHeadQueries;
    taskId = 3U;
    return RT_ERROR_NONE;
}

rtError_t CountSyncPreScanReclaim(const Stream*, bool, bool)
{
    ++syncTestHeadQueries;
    return RT_ERROR_NONE;
}

rtError_t CountDeviceSyncPreScanReclaim(Device*, uint32_t, bool, uint32_t&)
{
    ++syncTestHeadQueries;
    return RT_ERROR_NONE;
}

int32_t FinishSyncPreScanOnYield()
{
    EXPECT_EQ(syncTestHeadQueries, 1000U);
    for (Stream* const stream : Runtime::Instance()->CurrentContext()->StreamList_()) {
        stream->pendingNum_.Set(0U);
    }
    return 0;
}

rtError_t FailSyncRecordAfterLegacyPolling(Stream*, int32_t timeout)
{
    EXPECT_GT(timeout, 0);
    EXPECT_LE(timeout, 1000);
    return RT_ERROR_DRV_ERR;
}

rtError_t CaptureSyncNotification(Api*, Stream*, rtCallback_t callback, void* data, bool isBlock)
{
    syncTestCallback = callback;
    syncTestData = data;
    syncTestIsBlock = isBlock;
    return RT_ERROR_NONE;
}

constexpr int64_t syncTestInitialNs = 100999000000LL;
thread_local int64_t syncTestClockNs = syncTestInitialNs;
thread_local int64_t syncTestLaunchDelayNs = 0;
thread_local int64_t syncTestRawDelayNs = 0;
thread_local int64_t syncTestPendingRawDelayNs = 0;
thread_local bool syncTestNotifyDuringWait = false;
thread_local bool syncTestFailClock = false;
thread_local int syncTestWaitError = 0;
thread_local std::vector<int64_t> syncTestDeadlines;

int ReadSyncTestClock(clockid_t clock, timespec* value)
{
    if ((clock == CLOCK_MONOTONIC) && syncTestFailClock) {
        return -1;
    }
    value->tv_sec = syncTestClockNs / 1000000000LL;
    value->tv_nsec = syncTestClockNs % 1000000000LL;
    if (clock == CLOCK_MONOTONIC_RAW) {
        syncTestClockNs += syncTestPendingRawDelayNs;
        syncTestPendingRawDelayNs = 0;
    }
    return 0;
}

rtError_t CaptureTimedSyncNotification(Api* api, Stream* stream, rtCallback_t callback, void* data, bool isBlock)
{
    syncTestClockNs += syncTestLaunchDelayNs;
    syncTestPendingRawDelayNs = syncTestRawDelayNs;
    return CaptureSyncNotification(api, stream, callback, data, isBlock);
}

int RecordSyncTimedWait(pthread_cond_t*, pthread_mutex_t* mutex, const timespec* deadline)
{
    const int64_t deadlineNs = static_cast<int64_t>(deadline->tv_sec) * 1000000000LL + deadline->tv_nsec;
    syncTestDeadlines.push_back(deadlineNs);
    if (syncTestWaitError != 0) {
        return syncTestWaitError;
    }
    if (syncTestNotifyDuringWait) {
        EXPECT_EQ(pthread_mutex_unlock(mutex), 0);
        syncTestCallback(syncTestData);
        EXPECT_EQ(pthread_mutex_lock(mutex), 0);
        return 0;
    }
    syncTestClockNs = std::max(syncTestClockNs, deadlineNs);
    return (syncTestDeadlines.size() % 2U == 1U) ? 0 : ETIMEDOUT;
}

void PrepareSyncClockTest()
{
    syncTestClockNs = syncTestInitialNs;
    syncTestLaunchDelayNs = 0;
    syncTestRawDelayNs = 0;
    syncTestPendingRawDelayNs = 0;
    syncTestNotifyDuringWait = false;
    syncTestFailClock = false;
    syncTestWaitError = 0;
    syncTestDeadlines.clear();
    syncTestCallback = nullptr;
    syncTestData = nullptr;
    MOCKER(clock_gettime).stubs().will(invoke(ReadSyncTestClock));
    MOCKER(pthread_cond_timedwait).stubs().will(invoke(RecordSyncTimedWait));
}

rtError_t syncTestBlockingError = RT_ERROR_NONE;
rtError_t syncTestRecycleError = RT_ERROR_NONE;

rtError_t ConsumeSyncBlockingBudget(Stream*, int32_t)
{
    syncTestClockNs += 20000000LL;
    return syncTestBlockingError;
}

rtError_t CheckSyncBudgetDuringCommonRecycle(Stream*, uint16_t, const mmTimespec& beginTime, int32_t timeout)
{
    int32_t remainTime = timeout;
    EXPECT_FALSE(IsProcessTimeout(beginTime, timeout, &remainTime));
    EXPECT_EQ(remainTime, 80);
    return syncTestRecycleError;
}

rtError_t CompleteSyncNotification(Api* api, Stream* stream, rtCallback_t callback, void* data, bool isBlock)
{
    const rtError_t error = CaptureSyncNotification(api, stream, callback, data, isBlock);
    callback(data);
    return error;
}

rtError_t syncTestLaunchError = RT_ERROR_DRV_ERR;

rtError_t FailSyncNotification(Api*, Stream*, rtCallback_t callback, void* data, bool isBlock)
{
    EXPECT_NE(callback, nullptr);
    syncTestData = data;
    syncTestIsBlock = isBlock;
    return syncTestLaunchError;
}

void ReleaseFailedSyncNotificationArgs(SyncFuncArgs* args)
{
    ASSERT_NE(args, nullptr);
    EXPECT_EQ(args, syncTestData);
    EXPECT_EQ(pthread_cond_destroy(&args->cond), 0);
    EXPECT_EQ(pthread_mutex_destroy(&args->mutex), 0);
    free(args);
    syncTestData = nullptr;
}

rtError_t InspectNonblockingCallbackTask(RawDevice*, TaskInfo* task)
{
    EXPECT_NE(task, nullptr);
    if (task != nullptr) {
        EXPECT_EQ(task->type, TS_TASK_TYPE_HOSTFUNC_CALLBACK);
        EXPECT_FALSE(task->u.callbackLaunchTask.isBlock);
        EXPECT_EQ(task->u.callbackLaunchTask.eventId, INVALID_EVENT_ID);
    }
    return RT_ERROR_DRV_ERR;
}

rtError_t InspectBlockingCallbackTask(RawDevice*, TaskInfo* task)
{
    EXPECT_NE(task, nullptr);
    if (task != nullptr) {
        EXPECT_EQ(task->type, TS_TASK_TYPE_HOSTFUNC_CALLBACK);
        EXPECT_TRUE(task->u.callbackLaunchTask.isBlock);
        EXPECT_NE(task->u.callbackLaunchTask.eventId, INVALID_EVENT_ID);
    }
    return RT_ERROR_DRV_ERR;
}

rtError_t AdvanceSyncHead(Stream*, uint16_t& sqHead, uint32_t& taskId)
{
    ++syncTestHeadQueries;
    sqHead = 1U;
    taskId = (syncTestHeadQueries >= 173U) ? 3U : MAX_UINT16_NUM;
    return RT_ERROR_NONE;
}

int32_t CountSyncYield()
{
    ++syncTestYieldCalls;
    return 0;
}

rtError_t AdvanceYieldSyncHead(Stream* stream, uint16_t& sqHead, uint32_t& taskId)
{
    EXPECT_EQ(syncTestYieldCalls, syncTestHeadQueries + 1U);
    return AdvanceSyncHead(stream, sqHead, taskId);
}

uint32_t syncTestTimeoutReports = 0U;

void CountSyncTimeoutReport(rtExceptionType type)
{
    EXPECT_EQ(type, RT_EXCEPTION_TASK_TIMEOUT);
    ++syncTestTimeoutReports;
}

Stream* syncTestReportingStream = nullptr;
rtError_t syncTestReportError = RT_ERROR_NONE;

void FailSyncFromTimeoutReport(rtExceptionType type)
{
    CountSyncTimeoutReport(type);
    if (syncTestReportError == RT_ERROR_STREAM_ABORT) {
        syncTestReportingStream->SetAbortStatus(RT_ERROR_STREAM_ABORT);
    } else {
        syncTestReportingStream->SetStreamStatus(StreamStatus::ABNORMAL);
    }
}

rtError_t CompleteSyncAfterTimeoutReport(Stream*, uint16_t& sqHead, uint32_t& taskId)
{
    ++syncTestHeadQueries;
    sqHead = 1U;
    taskId = (syncTestHeadQueries == 1U) ? MAX_UINT16_NUM : 3U;
    syncTestClockNs += 180001000000LL;
    return RT_ERROR_NONE;
}

constexpr int64_t syncTestReportIntervalNs = 180000000000LL;
constexpr uint32_t syncTestReportsPastInt32Max = INT32_MAX / 180000U + 2U;
thread_local bool syncTestLongReportActive = false;

rtError_t AdvanceSyncHeadPastReportTimeLimit(Stream*, uint16_t& sqHead, uint32_t& taskId)
{
    if (!syncTestLongReportActive) {
        return RT_ERROR_DRV_ERR;
    }
    ++syncTestHeadQueries;
    EXPECT_EQ(syncTestTimeoutReports, (syncTestClockNs - syncTestInitialNs) / syncTestReportIntervalNs);
    sqHead = 1U;
    taskId = MAX_UINT16_NUM;
    if (syncTestHeadQueries <= syncTestReportsPastInt32Max) {
        syncTestClockNs += syncTestReportIntervalNs;
    } else if (syncTestHeadQueries == syncTestReportsPastInt32Max + 1U) {
        syncTestClockNs += syncTestReportIntervalNs - 1000000LL;
    } else if (syncTestHeadQueries == syncTestReportsPastInt32Max + 2U) {
        syncTestClockNs += 1000000LL;
    } else {
        taskId = 3U;
    }
    return RT_ERROR_NONE;
}

bool StartMonitorThread(StarsEngine* const engine)
{
    engine->monitorThreadRunFlag_ = true;
    const int32_t error = engine->monitorThread_->Start();
    if (error != EN_OK) {
        engine->monitorThreadRunFlag_ = false;
    }
    return error == EN_OK;
}
} // namespace

TEST_F(CloudV2StreamTest, SyncNonSeparatedModesPreserveLegacyWaitArguments)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* stream = rt_ut::UnwrapOrNull<Stream>(handle);
    Device* device = stream->Device_();
    ASSERT_TRUE(device->IsStarsPlatform());
    const bool previousRecycleThread = device->GetIsChipSupportRecycleThread();
    device->SetIsChipSupportRecycleThread(false);
    const ScopeGuard restoreRecycleMode(
        [device, previousRecycleThread]() { device->SetIsChipSupportRecycleThread(previousRecycleThread); });
    ASSERT_FALSE(stream->IsSeparateSendAndRecycle());
    syncTestLegacyCalls = 0U;
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(invoke(RecordLegacySync));
    MOCKER_CPP_VIRTUAL(Runtime::Instance()->ApiImpl_(), &Api::LaunchHostFunc).expects(never());
    for (uint32_t mode : {RT_DEVICE_SCHEDULE_SPIN, RT_DEVICE_SCHEDULE_YIELD, RT_DEVICE_SCHEDULE_BLOCKING_SYNC}) {
        for (bool waitSyncCq : {false, true}) {
            for (int32_t timeout : {-1, 0, 37}) {
                SCOPED_TRACE(
                    testing::Message() << "mode=" << mode << ", waitSyncCq=" << waitSyncCq << ", timeout=" << timeout);
                const uint32_t callsBefore = syncTestLegacyCalls;
                EXPECT_EQ(stream->Synchronize(waitSyncCq, timeout, mode), RT_ERROR_DRV_ERR);
                EXPECT_EQ(syncTestLegacyCalls, callsBefore + 1U);
                EXPECT_EQ(syncTestLegacyWaitSyncCq, waitSyncCq);
                EXPECT_EQ(syncTestLegacyTimeout, timeout);
            }
        }
    }
    EXPECT_EQ(syncTestLegacyCalls, 18U);
    GlobalMockObject::verify();
    device->SetIsChipSupportRecycleThread(previousRecycleThread);
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncFuncArgsConditionClockFailureReturnsSystemError)
{
    MOCKER(pthread_condattr_setclock).stubs().will(returnValue(EINVAL));
    SyncFuncArgs* args = nullptr;
    EXPECT_EQ(CreateSyncFuncArgs(args), RT_ERROR_OS_HANDLE);
    EXPECT_EQ(args, nullptr);
}

TEST_F(CloudV2StreamTest, SyncFuncArgsConditionInitFailureReturnsSystemError)
{
    MOCKER(pthread_cond_init).stubs().will(returnValue(EINVAL));
    SyncFuncArgs* args = nullptr;
    EXPECT_EQ(CreateSyncFuncArgs(args), RT_ERROR_OS_HANDLE);
    EXPECT_EQ(args, nullptr);
}

TEST_F(CloudV2StreamTest, SyncFuncArgsMutexInitFailureReturnsSystemError)
{
    MOCKER(pthread_mutex_init).stubs().will(returnValue(EINVAL));
    SyncFuncArgs* args = nullptr;
    EXPECT_EQ(CreateSyncFuncArgs(args), RT_ERROR_OS_HANDLE);
    EXPECT_EQ(args, nullptr);
}

TEST_F(CloudV2StreamTest, LaunchHostFuncNonblockingBuildsTaskWithoutEvent)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    RawDevice* const device = static_cast<RawDevice*>(stream->Device_());
    MOCKER_CPP_VIRTUAL(device, &RawDevice::SubmitTask).expects(once()).will(invoke(InspectNonblockingCallbackTask));

    int32_t callbackData = 0;
    EXPECT_EQ(
        Runtime::Instance()->ApiImpl_()->LaunchHostFunc(stream, ApiTest_Stream_Cb, &callbackData, false),
        RT_ERROR_DRV_ERR);

    GlobalMockObject::verify();
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, LaunchHostFuncBuildsBlockingTaskWithEvent)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    RawDevice* const device = static_cast<RawDevice*>(stream->Device_());
    MOCKER_CPP_VIRTUAL(device, &RawDevice::SubmitTask).expects(once()).will(invoke(InspectBlockingCallbackTask));

    EXPECT_EQ(rtsLaunchHostFunc(handle, ApiTest_Stream_Cb, nullptr), ACL_ERROR_RT_DRV_INTERNAL_ERROR);

    GlobalMockObject::verify();
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncBlockingEarlyNonblockingNotificationIsNotLost)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* stream = rt_ut::UnwrapOrNull<Stream>(handle);
    Device* device = stream->Device_();
    const bool previousRecycleThread = device->GetIsChipSupportRecycleThread();
    device->SetIsChipSupportRecycleThread(true);
    const ScopeGuard restoreRecycleMode(
        [device, previousRecycleThread]() { device->SetIsChipSupportRecycleThread(previousRecycleThread); });
    ASSERT_TRUE(stream->IsSeparateSendAndRecycle());
    syncTestIsBlock = true;
    SyncFuncArgs* destroyedArgs = nullptr;
    MOCKER(DestroySyncFuncArgs).expects(once()).with(spy(destroyedArgs));
    MOCKER_CPP_VIRTUAL(static_cast<ApiImpl*>(Runtime::Instance()->ApiImpl_()), &ApiImpl::CallbackLaunch)
        .expects(never());
    MOCKER_CPP_VIRTUAL(Runtime::Instance()->ApiImpl_(), &Api::LaunchHostFunc)
        .expects(once())
        .will(invoke(CompleteSyncNotification));
    const uint32_t previousLastTaskId = stream->GetLastTaskId();
    stream->SetLastTaskId(3U);
    const uint32_t previousPendingNum = stream->GetPendingNum();
    stream->pendingNum_.Set(1U);
    const size_t failedBefore = stream->Device_()->syncArgs_.size();
    EXPECT_EQ(stream->Synchronize(true, 100, RT_DEVICE_SCHEDULE_BLOCKING_SYNC), RT_ERROR_NONE);
    EXPECT_FALSE(syncTestIsBlock);
    ASSERT_NE(syncTestData, nullptr);
    EXPECT_EQ(destroyedArgs, syncTestData);
    EXPECT_EQ(stream->Device_()->syncArgs_.size(), failedBefore);
    stream->pendingNum_.Set(previousPendingNum);
    stream->SetLastTaskId(previousLastTaskId);
    GlobalMockObject::verify();
    // The destruction mock retained the allocation; release it after checking the success path.
    DestroySyncFuncArgs(static_cast<SyncFuncArgs*>(syncTestData));
    device->SetIsChipSupportRecycleThread(previousRecycleThread);
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncBlockingTimeoutKeepsArgsValidForLateCallback)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* stream = rt_ut::UnwrapOrNull<Stream>(handle);
    stream->SetLastTaskId(3U);
    Device* device = stream->Device_();
    const bool previousRecycleThread = device->GetIsChipSupportRecycleThread();
    device->SetIsChipSupportRecycleThread(true);
    const ScopeGuard restoreRecycleMode(
        [device, previousRecycleThread]() { device->SetIsChipSupportRecycleThread(previousRecycleThread); });
    ASSERT_TRUE(stream->IsSeparateSendAndRecycle());
    MOCKER_CPP_VIRTUAL(Runtime::Instance()->ApiImpl_(), &Api::LaunchHostFunc)
        .stubs()
        .will(invoke(CaptureSyncNotification));
    const size_t failedBefore = stream->Device_()->syncArgs_.size();
    EXPECT_EQ(
        stream->SynchronizeImpl(3U, MAX_UINT16_NUM, 12, RT_DEVICE_SCHEDULE_BLOCKING_SYNC),
        RT_ERROR_STREAM_SYNC_TIMEOUT);
    ASSERT_EQ(stream->Device_()->syncArgs_.size(), failedBefore + 1U);
    EXPECT_FALSE(syncTestIsBlock);
    auto* args = static_cast<SyncFuncArgs*>(syncTestData);
    EXPECT_EQ(args->currentCnt, 0U);
    device->DestroySyncArgs(false);
    ASSERT_EQ(device->syncArgs_.size(), failedBefore + 1U);
    EXPECT_EQ(args->currentCnt, 0U);
    syncTestCallback(syncTestData);
    EXPECT_EQ(args->currentCnt, 1U);
    // This test owns the only captured report; it has completed before Device cleanup.
    stream->Device_()->DestroySyncArgs(false);
    EXPECT_TRUE(stream->Device_()->syncArgs_.empty());
    GlobalMockObject::verify();
    device->SetIsChipSupportRecycleThread(previousRecycleThread);
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncBlockingDeadlineDoesNotExtendAfterBudgetCheck)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    PrepareSyncClockTest();
    syncTestLaunchDelayNs = 9000000;
    // Simulate descheduling after the remaining budget is sampled.
    syncTestRawDelayNs = 10000000;
    MOCKER_CPP_VIRTUAL(Runtime::Instance()->ApiImpl_(), &Api::LaunchHostFunc)
        .expects(once())
        .will(invoke(CaptureTimedSyncNotification));
    EXPECT_EQ(stream->SynchronizeBlocking(10), RT_ERROR_STREAM_SYNC_TIMEOUT);
    ASSERT_EQ(syncTestDeadlines.size(), 1U);
    EXPECT_LE(syncTestDeadlines.front(), syncTestInitialNs + 10000000);
    ASSERT_NE(syncTestData, nullptr);
    EXPECT_EQ(stream->Device_()->syncArgs_.size(), 1U);
    syncTestCallback(syncTestData);
    stream->Device_()->DestroySyncArgs();
    GlobalMockObject::verify();
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncBlockingWaitSlicesUseRemainingBudget)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    for (int32_t timeout : {-1, 2, 12}) {
        stream->SetNeedSyncFlag(false);
        PrepareSyncClockTest();
        syncTestNotifyDuringWait = (timeout < 0);
        MOCKER_CPP_VIRTUAL(Runtime::Instance()->ApiImpl_(), &Api::LaunchHostFunc)
            .expects(once())
            .will(invoke(CaptureTimedSyncNotification));
        EXPECT_EQ(stream->SynchronizeBlocking(timeout), timeout < 0 ? RT_ERROR_NONE : RT_ERROR_STREAM_SYNC_TIMEOUT);
        EXPECT_EQ(stream->GetNeedSyncFlag(), timeout >= 0);
        const std::vector<int64_t> offsets = timeout == 12 ? std::vector<int64_t>{5000000, 10000000, 12000000} :
                                                             std::vector<int64_t>{timeout < 0 ? 5000000 : 2000000};
        ASSERT_EQ(syncTestDeadlines.size(), offsets.size());
        for (size_t i = 0; i < offsets.size(); ++i) {
            EXPECT_EQ(syncTestDeadlines[i], syncTestInitialNs + offsets[i]);
        }
        EXPECT_FALSE(syncTestIsBlock);
        EXPECT_EQ(stream->Device_()->syncArgs_.size(), timeout < 0 ? 0U : 1U);
        if (timeout >= 0) {
            syncTestCallback(syncTestData);
            stream->Device_()->DestroySyncArgs();
        }
        GlobalMockObject::verify();
    }
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncBlockingExpiredStatusCheckDoesNotPublishNotification)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    for (int32_t timeout : {0, 10}) {
        stream->SetNeedSyncFlag(false);
        PrepareSyncClockTest();
        MOCKER_CPP_VIRTUAL(stream, &Stream::CheckContextStatus)
            .expects(once())
            .with(eq(false))
            .will(invoke(+[](Stream*, bool) -> rtError_t {
                syncTestClockNs += 20000000;
                return RT_ERROR_NONE;
            }));
        MOCKER_CPP_VIRTUAL(Runtime::Instance()->ApiImpl_(), &Api::LaunchHostFunc).expects(never());
        EXPECT_EQ(stream->SynchronizeBlocking(timeout), RT_ERROR_STREAM_SYNC_TIMEOUT);
        EXPECT_TRUE(stream->GetNeedSyncFlag());
        EXPECT_TRUE(stream->Device_()->syncArgs_.empty());
        EXPECT_TRUE(syncTestDeadlines.empty());
        GlobalMockObject::verify();
    }
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncBlockingCompletedNotificationSkipsWaitChecks)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    stream->SetNeedSyncFlag(false);
    PrepareSyncClockTest();
    syncTestLaunchDelayNs = 20000000;
    MOCKER_CPP_VIRTUAL(Runtime::Instance()->ApiImpl_(), &Api::LaunchHostFunc)
        .expects(once())
        .will(invoke(+[](Api* api, Stream* stm, rtCallback_t callback, void* data, bool block) -> rtError_t {
            const rtError_t error = CaptureTimedSyncNotification(api, stm, callback, data, block);
            callback(data);
            return error;
        }));
    EXPECT_EQ(stream->SynchronizeBlocking(10), RT_ERROR_NONE);
    EXPECT_FALSE(stream->GetNeedSyncFlag());
    EXPECT_TRUE(stream->Device_()->syncArgs_.empty());
    EXPECT_TRUE(syncTestDeadlines.empty());
    GlobalMockObject::verify();
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncBlockingStatusChecksHoldNotificationUntilWait)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    static std::thread callbackThread;
    static std::atomic<bool> callbackStarted{false};
    static std::atomic<bool> callbackFinished{false};
    static rtError_t waitStatus = RT_ERROR_NONE;

    for (rtError_t reportedError : {RT_ERROR_NONE, RT_ERROR_DRV_ERR}) {
        stream->SetNeedSyncFlag(false);
        waitStatus = reportedError;
        callbackStarted.store(false);
        callbackFinished.store(false);
        const ScopeGuard joinCallback([]() {
            if (callbackThread.joinable()) {
                callbackThread.join();
            }
        });
        MOCKER_CPP_VIRTUAL(Runtime::Instance()->ApiImpl_(), &Api::LaunchHostFunc)
            .expects(once())
            .will(invoke(CaptureSyncNotification));
        MOCKER_CPP_VIRTUAL(stream, &Stream::CheckContextStatus)
            .expects(exactly(2))
            .will(returnValue(RT_ERROR_NONE))
            .then(invoke(+[](Stream*, bool) -> rtError_t {
                callbackThread = std::thread([]() {
                    auto* args = static_cast<SyncFuncArgs*>(syncTestData);
                    int32_t lockRet = pthread_mutex_trylock(&args->mutex);
                    EXPECT_EQ(lockRet, EBUSY);
                    callbackStarted.store(true);
                    const auto lockDeadline = std::chrono::steady_clock::now() + std::chrono::seconds(1);
                    while ((lockRet == EBUSY) && (std::chrono::steady_clock::now() < lockDeadline)) {
                        std::this_thread::yield();
                        lockRet = pthread_mutex_trylock(&args->mutex);
                    }
                    EXPECT_EQ(lockRet, 0);
                    if (lockRet == 0) {
                        ++args->currentCnt;
                        EXPECT_EQ(pthread_cond_signal(&args->cond), 0);
                        EXPECT_EQ(pthread_mutex_unlock(&args->mutex), 0);
                    }
                    callbackFinished.store(true);
                });
                const auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds(1);
                while (!callbackStarted.load() && (std::chrono::steady_clock::now() < deadline)) {
                    std::this_thread::yield();
                }
                EXPECT_TRUE(callbackStarted.load());
                EXPECT_FALSE(callbackFinished.load());
                return waitStatus;
            }));

        EXPECT_EQ(stream->SynchronizeBlocking(5000), reportedError);
        const auto callbackDeadline = std::chrono::steady_clock::now() + std::chrono::seconds(2);
        while (!callbackFinished.load() && (std::chrono::steady_clock::now() < callbackDeadline)) {
            std::this_thread::yield();
        }
        ASSERT_TRUE(callbackFinished.load());
        if (callbackThread.joinable()) {
            callbackThread.join();
        }
        EXPECT_TRUE(callbackFinished.load());
        EXPECT_FALSE(syncTestIsBlock);
        EXPECT_FALSE(stream->GetNeedSyncFlag());
        EXPECT_EQ(stream->Device_()->syncArgs_.size(), reportedError == RT_ERROR_NONE ? 0U : 1U);
        if (!stream->Device_()->syncArgs_.empty()) {
            EXPECT_EQ(stream->Device_()->syncArgs_.front()->currentCnt, 1U);
            stream->Device_()->DestroySyncArgs();
        }
        GlobalMockObject::verify();
    }
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncBlockingCompletedNotificationReturnsSuccess)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    stream->SetLastTaskId(3U);
    Device* const device = stream->Device_();
    const bool previousRecycleThread = device->GetIsChipSupportRecycleThread();
    device->SetIsChipSupportRecycleThread(true);
    const ScopeGuard restoreRecycleMode(
        [device, previousRecycleThread]() { device->SetIsChipSupportRecycleThread(previousRecycleThread); });
    stream->SetNeedSyncFlag(false);
    PrepareSyncClockTest();
    syncTestLaunchDelayNs = 20000000;
    MOCKER_CPP_VIRTUAL(Runtime::Instance()->ApiImpl_(), &Api::LaunchHostFunc)
        .expects(once())
        .will(invoke(+[](Api* api, Stream* stm, rtCallback_t callback, void* data, bool block) -> rtError_t {
            const rtError_t error = CaptureTimedSyncNotification(api, stm, callback, data, block);
            callback(data);
            return error;
        }));
    EXPECT_EQ(stream->SynchronizeImpl(3U, MAX_UINT16_NUM, 10, RT_DEVICE_SCHEDULE_BLOCKING_SYNC), RT_ERROR_NONE);
    EXPECT_FALSE(stream->GetNeedSyncFlag());
    EXPECT_TRUE(stream->Device_()->syncArgs_.empty());
    EXPECT_TRUE(syncTestDeadlines.empty());
    GlobalMockObject::verify();
    device->SetIsChipSupportRecycleThread(previousRecycleThread);
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncBlockingReceivesTimeoutAfterModeResolution)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    const uint32_t previousLastTaskId = stream->GetLastTaskId();
    const bool previousNeedSync = stream->GetNeedSyncFlag();
    ScopeGuard restoreState([=]() {
        stream->SetLastTaskId(previousLastTaskId);
        stream->SetNeedSyncFlag(previousNeedSync);
    });
    stream->SetLastTaskId(3U);
    stream->SetNeedSyncFlag(false);
    syncTestClockNs = syncTestInitialNs;
    syncTestPendingRawDelayNs = 0;
    syncTestFailClock = false;
    MOCKER(clock_gettime).stubs().will(invoke(ReadSyncTestClock));
    MOCKER_CPP(&Stream::ResolveSyncScheduleMode).expects(once()).will(invoke(+[](Stream*, uint32_t mode) -> uint32_t {
        syncTestClockNs += 20000000LL;
        return mode;
    }));
    MOCKER_CPP(&Stream::SynchronizeBlocking).expects(once()).with(eq(10)).will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(stream->SynchronizeImpl(3U, MAX_UINT16_NUM, 10, RT_DEVICE_SCHEDULE_BLOCKING_SYNC), RT_ERROR_NONE);
    EXPECT_FALSE(stream->GetNeedSyncFlag());
    GlobalMockObject::verify();

    stream->SetLastTaskId(previousLastTaskId);
    stream->SetNeedSyncFlag(previousNeedSync);
    restoreState.ReleaseGuard();
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncBlockingWaitSystemErrorKeepsPublishedArgs)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    for (bool failClock : {false, true}) {
        stream->SetNeedSyncFlag(false);
        PrepareSyncClockTest();
        syncTestFailClock = failClock;
        syncTestWaitError = EINVAL;
        MOCKER_CPP_VIRTUAL(Runtime::Instance()->ApiImpl_(), &Api::LaunchHostFunc)
            .expects(once())
            .will(invoke(CaptureTimedSyncNotification));
        EXPECT_EQ(stream->SynchronizeBlocking(10), RT_ERROR_OS_HANDLE);
        EXPECT_FALSE(stream->GetNeedSyncFlag());
        ASSERT_NE(syncTestData, nullptr);
        EXPECT_EQ(stream->Device_()->syncArgs_.size(), 1U);
        EXPECT_EQ(syncTestDeadlines.size(), failClock ? 0U : 1U);
        syncTestCallback(syncTestData);
        stream->Device_()->DestroySyncArgs();
        GlobalMockObject::verify();
    }
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncBlockingSubmissionFailureReleasesArgsImmediately)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    Device* const device = stream->Device_();
    for (rtError_t error : {RT_ERROR_DRV_ERR, RT_ERROR_SUBSCRIBE_STREAM, RT_ERROR_MEMORY_ALLOCATION}) {
        SCOPED_TRACE(error);
        syncTestLaunchError = error;
        MOCKER_CPP_VIRTUAL(Runtime::Instance()->ApiImpl_(), &Api::LaunchHostFunc)
            .expects(once())
            .will(invoke(FailSyncNotification));
        MOCKER_CPP_VIRTUAL(stream, &Stream::SynchronizeExecutedTask).expects(never());
        MOCKER(DestroySyncFuncArgs).expects(once()).will(invoke(ReleaseFailedSyncNotificationArgs));
        EXPECT_EQ(stream->SynchronizeBlocking(100), error);
        EXPECT_FALSE(syncTestIsBlock);
        EXPECT_EQ(syncTestData, nullptr);
        EXPECT_TRUE(device->syncArgs_.empty());
        device->DestroySyncArgs(false);
        EXPECT_TRUE(device->syncArgs_.empty());
        GlobalMockObject::verify();
    }
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncSpinDoesNotEnterAdaptiveDelay)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* stream = rt_ut::UnwrapOrNull<Stream>(handle);
    Device* device = stream->Device_();
    const bool previousRecycleThread = device->GetIsChipSupportRecycleThread();
    device->SetIsChipSupportRecycleThread(true);
    const ScopeGuard restoreRecycleMode(
        [device, previousRecycleThread]() { device->SetIsChipSupportRecycleThread(previousRecycleThread); });
    ASSERT_TRUE(stream->IsSeparateSendAndRecycle());
    StarsEngine* const engine = static_cast<StarsEngine*>(static_cast<RawDevice*>(device)->Engine_());
    ASSERT_NE(engine->monitorThread_, nullptr);
    ASSERT_TRUE(engine->monitorThreadRunFlag_.load());
    engine->monitorThreadRunFlag_ = false;
    engine->monitorThread_->Join();
    ScopeGuard restoreMonitorThread([engine]() { EXPECT_TRUE(StartMonitorThread(engine)); });
    const uint32_t previousLastTaskId = stream->GetLastTaskId();
    stream->SetLastTaskId(3U);
    MOCKER_CPP_VIRTUAL(stream, &Stream::GetFinishedTaskIdBySqHead).stubs().will(invoke(AdvanceSyncHead));
    MOCKER_CPP_VIRTUAL(stream, &Stream::SynchronizeDelayTime).expects(never());
    MOCKER(sched_yield).expects(never());
    MOCKER(mmSleep).expects(never());
    for (bool waitSyncCq : {false, true}) {
        syncTestHeadQueries = 0U;
        EXPECT_EQ(stream->Synchronize(waitSyncCq, 100, RT_DEVICE_SCHEDULE_SPIN), RT_ERROR_NONE);
        EXPECT_EQ(syncTestHeadQueries, 173U);
    }
    stream->SetLastTaskId(previousLastTaskId);
    GlobalMockObject::verify();
    const bool monitorStarted = StartMonitorThread(engine);
    EXPECT_TRUE(monitorStarted);
    if (monitorStarted) {
        restoreMonitorThread.ReleaseGuard();
    }
    device->SetIsChipSupportRecycleThread(previousRecycleThread);
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncYieldYieldsOnEveryExecutionQuery)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* stream = rt_ut::UnwrapOrNull<Stream>(handle);
    Device* device = stream->Device_();
    const bool previousRecycleThread = device->GetIsChipSupportRecycleThread();
    device->SetIsChipSupportRecycleThread(true);
    const ScopeGuard restoreRecycleMode(
        [device, previousRecycleThread]() { device->SetIsChipSupportRecycleThread(previousRecycleThread); });
    ASSERT_TRUE(stream->IsSeparateSendAndRecycle());
    StarsEngine* const engine = static_cast<StarsEngine*>(static_cast<RawDevice*>(device)->Engine_());
    ASSERT_NE(engine->monitorThread_, nullptr);
    ASSERT_TRUE(engine->monitorThreadRunFlag_.load());
    engine->monitorThreadRunFlag_ = false;
    engine->monitorThread_->Join();
    ScopeGuard restoreMonitorThread([engine]() { EXPECT_TRUE(StartMonitorThread(engine)); });
    const uint32_t previousLastTaskId = stream->GetLastTaskId();
    stream->SetLastTaskId(3U);
    MOCKER_CPP_VIRTUAL(stream, &Stream::GetFinishedTaskIdBySqHead).stubs().will(invoke(AdvanceYieldSyncHead));
    MOCKER_CPP_VIRTUAL(stream, &Stream::SynchronizeDelayTime).expects(never());
    MOCKER(sched_yield).expects(exactly(346)).will(invoke(CountSyncYield));
    MOCKER(mmSleep).expects(never());
    const ScopeGuard resetYieldCount([]() { syncTestYieldCalls = 0U; });
    for (bool waitSyncCq : {false, true}) {
        syncTestHeadQueries = 0U;
        syncTestYieldCalls = 0U;
        EXPECT_EQ(stream->Synchronize(waitSyncCq, 100, RT_DEVICE_SCHEDULE_YIELD), RT_ERROR_NONE);
        EXPECT_EQ(syncTestHeadQueries, 173U);
        EXPECT_EQ(syncTestYieldCalls, 173U);
    }
    stream->SetLastTaskId(previousLastTaskId);
    GlobalMockObject::verify();
    const bool monitorStarted = StartMonitorThread(engine);
    EXPECT_TRUE(monitorStarted);
    if (monitorStarted) {
        restoreMonitorThread.ReleaseGuard();
    }
    device->SetIsChipSupportRecycleThread(previousRecycleThread);
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncAutoEntersAdaptiveDelayOnlyAfterFastSyncTimes)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* stream = rt_ut::UnwrapOrNull<Stream>(handle);
    StarsEngine* const engine = static_cast<StarsEngine*>(static_cast<RawDevice*>(stream->Device_())->Engine_());
    ASSERT_NE(engine->monitorThread_, nullptr);
    ASSERT_TRUE(engine->monitorThreadRunFlag_.load());
    engine->monitorThreadRunFlag_ = false;
    engine->monitorThread_->Join();
    ScopeGuard restoreMonitorThread([engine]() { EXPECT_TRUE(StartMonitorThread(engine)); });
    syncTestHeadQueries = 0U;
    MOCKER_CPP_VIRTUAL(stream, &Stream::GetFinishedTaskIdBySqHead).stubs().will(invoke(AdvanceSyncHead));
    MOCKER_CPP_VIRTUAL(stream, &Stream::SynchronizeDelayTime).expects(once()).will(returnValue(true));
    EXPECT_EQ(stream->SynchronizeExecutedTask(3U, mmGetTickCount(), 100, RT_DEVICE_SCHEDULE_AUTO), RT_ERROR_NONE);
    EXPECT_EQ(syncTestHeadQueries, 172U);
    GlobalMockObject::verify();
    const bool monitorStarted = StartMonitorThread(engine);
    EXPECT_TRUE(monitorStarted);
    if (monitorStarted) {
        restoreMonitorThread.ReleaseGuard();
    }
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncWaitModesReportLongWaitAndContinueToCompletion)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* stream = rt_ut::UnwrapOrNull<Stream>(handle);
    StarsEngine* const engine = static_cast<StarsEngine*>(static_cast<RawDevice*>(stream->Device_())->Engine_());
    ASSERT_NE(engine->monitorThread_, nullptr);
    ASSERT_TRUE(engine->monitorThreadRunFlag_.load());
    engine->monitorThreadRunFlag_ = false;
    engine->monitorThread_->Join();
    ScopeGuard restoreMonitorThread([engine]() { EXPECT_TRUE(StartMonitorThread(engine)); });
    const rtErrorCallback previousCallback = Runtime::Instance()->excptCallBack_;
    const ScopeGuard restoreCallback([previousCallback]() { Runtime::Instance()->excptCallBack_ = previousCallback; });
    Runtime::Instance()->excptCallBack_ = CountSyncTimeoutReport;
    MOCKER(clock_gettime).stubs().will(invoke(ReadSyncTestClock));
    MOCKER_CPP_VIRTUAL(stream, &Stream::GetFinishedTaskIdBySqHead).stubs().will(invoke(CompleteSyncAfterTimeoutReport));
    for (uint32_t mode : {RT_DEVICE_SCHEDULE_AUTO, RT_DEVICE_SCHEDULE_SPIN, RT_DEVICE_SCHEDULE_YIELD}) {
        syncTestClockNs = syncTestInitialNs;
        syncTestHeadQueries = 0U;
        syncTestTimeoutReports = 0U;
        EXPECT_EQ(stream->SynchronizeExecutedTask(3U, mmGetTickCount(), -1, mode), RT_ERROR_NONE);
        EXPECT_EQ(syncTestHeadQueries, 2U);
        EXPECT_EQ(syncTestTimeoutReports, 1U);
    }
    GlobalMockObject::verify();
    Runtime::Instance()->excptCallBack_ = previousCallback;
    const bool monitorStarted = StartMonitorThread(engine);
    EXPECT_TRUE(monitorStarted);
    if (monitorStarted) {
        restoreMonitorThread.ReleaseGuard();
    }
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncWaitModesKeepReportingPastInt32TimeLimit)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    StarsEngine* const engine = static_cast<StarsEngine*>(static_cast<RawDevice*>(stream->Device_())->Engine_());
    ASSERT_NE(engine->monitorThread_, nullptr);
    ASSERT_TRUE(engine->monitorThreadRunFlag_.load());
    engine->monitorThreadRunFlag_ = false;
    engine->monitorThread_->Join();
    ScopeGuard restoreMonitorThread([engine]() { EXPECT_TRUE(StartMonitorThread(engine)); });
    const rtErrorCallback previousCallback = Runtime::Instance()->excptCallBack_;
    const ScopeGuard restoreCallback([previousCallback]() {
        Runtime::Instance()->excptCallBack_ = previousCallback;
        syncTestLongReportActive = false;
        syncTestClockNs = syncTestInitialNs;
        syncTestHeadQueries = 0U;
        syncTestTimeoutReports = 0U;
    });
    Runtime::Instance()->excptCallBack_ = CountSyncTimeoutReport;
    MOCKER(clock_gettime).stubs().will(invoke(ReadSyncTestClock));
    MOCKER_CPP_VIRTUAL(stream, &Stream::GetFinishedTaskIdBySqHead)
        .stubs()
        .will(invoke(AdvanceSyncHeadPastReportTimeLimit));
    MOCKER_CPP_VIRTUAL(stream, &Stream::SynchronizeDelayTime).stubs().will(returnValue(false));
    for (uint32_t mode : {RT_DEVICE_SCHEDULE_AUTO, RT_DEVICE_SCHEDULE_SPIN, RT_DEVICE_SCHEDULE_YIELD}) {
        SCOPED_TRACE(mode);
        syncTestClockNs = syncTestInitialNs;
        syncTestHeadQueries = 0U;
        syncTestTimeoutReports = 0U;
        syncTestLongReportActive = true;
        EXPECT_EQ(stream->SynchronizeExecutedTask(3U, mmGetTickCount(), -1, mode), RT_ERROR_NONE);
        syncTestLongReportActive = false;
        EXPECT_EQ(syncTestHeadQueries, syncTestReportsPastInt32Max + 3U);
        EXPECT_EQ(syncTestTimeoutReports, syncTestReportsPastInt32Max + 1U);
    }
    GlobalMockObject::verify();
    Runtime::Instance()->excptCallBack_ = previousCallback;
    const bool monitorStarted = StartMonitorThread(engine);
    EXPECT_TRUE(monitorStarted);
    if (monitorStarted) {
        restoreMonitorThread.ReleaseGuard();
    }
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncWaitModesObserveStateChangeFromTimeoutReport)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* stream = rt_ut::UnwrapOrNull<Stream>(handle);
    StarsEngine* const engine = static_cast<StarsEngine*>(static_cast<RawDevice*>(stream->Device_())->Engine_());
    ASSERT_NE(engine->monitorThread_, nullptr);
    ASSERT_TRUE(engine->monitorThreadRunFlag_.load());
    engine->monitorThreadRunFlag_ = false;
    engine->monitorThread_->Join();
    ScopeGuard restoreMonitorThread([engine]() { EXPECT_TRUE(StartMonitorThread(engine)); });
    const rtErrorCallback previousCallback = Runtime::Instance()->excptCallBack_;
    const ScopeGuard restoreCallback([previousCallback]() {
        Runtime::Instance()->excptCallBack_ = previousCallback;
        syncTestReportingStream = nullptr;
    });
    Runtime::Instance()->excptCallBack_ = FailSyncFromTimeoutReport;
    syncTestReportingStream = stream;
    MOCKER(clock_gettime).stubs().will(invoke(ReadSyncTestClock));
    MOCKER_CPP_VIRTUAL(stream, &Stream::GetFinishedTaskIdBySqHead).expects(never());
    for (uint32_t mode : {RT_DEVICE_SCHEDULE_AUTO, RT_DEVICE_SCHEDULE_SPIN, RT_DEVICE_SCHEDULE_YIELD}) {
        for (rtError_t error : {RT_ERROR_STREAM_ABORT, RT_ERROR_STREAM_SYNC}) {
            stream->SetAbortStatus(RT_ERROR_NONE);
            stream->SetStreamStatus(StreamStatus::NORMAL);
            syncTestClockNs = syncTestInitialNs;
            const mmTimespec beginTime = mmGetTickCount();
            syncTestClockNs += 180001000000LL;
            syncTestTimeoutReports = 0U;
            syncTestReportError = error;
            EXPECT_EQ(stream->SynchronizeExecutedTask(3U, beginTime, -1, mode), error);
            EXPECT_EQ(syncTestTimeoutReports, 1U);
        }
    }
    GlobalMockObject::verify();
    Runtime::Instance()->excptCallBack_ = previousCallback;
    stream->SetAbortStatus(RT_ERROR_NONE);
    stream->SetStreamStatus(StreamStatus::NORMAL);
    const bool monitorStarted = StartMonitorThread(engine);
    EXPECT_TRUE(monitorStarted);
    if (monitorStarted) {
        restoreMonitorThread.ReleaseGuard();
    }
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncPollingAlreadyCompletedTaskSkipsExecutionQuery)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    {
        const uint16_t previousTaskId = stream->GetExecuteEndTaskId();
        const ScopeGuard restoreTaskId([stream, previousTaskId]() { stream->SetExecuteEndTaskId(previousTaskId); });
        stream->SetExecuteEndTaskId(3U);
        MOCKER_CPP_VIRTUAL(stream, &Stream::GetFinishedTaskIdBySqHead).expects(never());
        for (uint32_t mode : {RT_DEVICE_SCHEDULE_SPIN, RT_DEVICE_SCHEDULE_YIELD}) {
            EXPECT_EQ(stream->SynchronizeExecutedTask(3U, mmGetTickCount(), 100, mode), RT_ERROR_NONE);
        }
        GlobalMockObject::verify();
    }
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncWaitModesReturnExecutionQueryError)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* stream = rt_ut::UnwrapOrNull<Stream>(handle);
    // The recycler can also call this globally hooked method.
    static thread_local uint32_t queryCount = 0U;
    MOCKER_CPP_VIRTUAL(stream, &Stream::GetFinishedTaskIdBySqHead)
        .stubs()
        .will(invoke(+[](Stream*, uint16_t&, uint32_t&) -> rtError_t {
            ++queryCount;
            return RT_ERROR_DRV_ERR;
        }));
    for (uint32_t mode : {RT_DEVICE_SCHEDULE_AUTO, RT_DEVICE_SCHEDULE_SPIN, RT_DEVICE_SCHEDULE_YIELD}) {
        SCOPED_TRACE(testing::Message() << "mode=" << mode);
        queryCount = 0U;
        EXPECT_EQ(stream->SynchronizeExecutedTask(3U, mmGetTickCount(), 100, mode), RT_ERROR_DRV_ERR);
        EXPECT_EQ(queryCount, 1U);
    }
    queryCount = 0U;
    GlobalMockObject::verify();
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncBlockingDeviceAbortRejectsBeforeCallbackSubmission)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    Device* const device = stream->Device_();
    {
        const rtError_t previousStatus = device->GetDeviceStatus();
        device->SetDeviceStatus(RT_ERROR_DEVICE_TASK_ABORT);
        const ScopeGuard resumeDevice([device, previousStatus]() { device->SetDeviceStatus(previousStatus); });
        MOCKER_CPP_VIRTUAL(Runtime::Instance()->ApiImpl_(), &Api::LaunchHostFunc).expects(never());
        EXPECT_EQ(stream->SynchronizeBlocking(100), RT_ERROR_DEVICE_TASK_ABORT);
        EXPECT_TRUE(device->syncArgs_.empty());
        GlobalMockObject::verify();
    }
    EXPECT_EQ(stream->CheckSyncStatus(), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncBlockingAbortAfterContextCheckDoesNotSubmitCallback)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    Device* const device = stream->Device_();
    for (rtError_t error : {RT_ERROR_STREAM_ABORT, RT_ERROR_DEVICE_TASK_ABORT}) {
        const rtError_t previousStreamStatus = stream->GetAbortStatus();
        const rtError_t previousDeviceStatus = device->GetDeviceStatus();
        const ScopeGuard restoreStatus([=]() {
            stream->SetAbortStatus(previousStreamStatus);
            device->SetDeviceStatus(previousDeviceStatus);
        });
        if (error == RT_ERROR_STREAM_ABORT) {
            MOCKER_CPP_VIRTUAL(stream, &Stream::CheckContextStatus)
                .expects(once())
                .with(eq(false))
                .will(invoke(+[](Stream* current, bool) -> rtError_t {
                    current->SetAbortStatus(RT_ERROR_STREAM_ABORT);
                    return RT_ERROR_NONE;
                }));
        } else {
            MOCKER_CPP_VIRTUAL(stream, &Stream::CheckContextStatus)
                .expects(once())
                .with(eq(false))
                .will(invoke(+[](Stream* current, bool) -> rtError_t {
                    current->Device_()->SetDeviceStatus(RT_ERROR_DEVICE_TASK_ABORT);
                    return RT_ERROR_NONE;
                }));
        }
        MOCKER_CPP_VIRTUAL(Runtime::Instance()->ApiImpl_(), &Api::LaunchHostFunc).expects(never());
        EXPECT_EQ(stream->SynchronizeBlocking(100), error);
        EXPECT_TRUE(device->syncArgs_.empty());
        GlobalMockObject::verify();
    }
    EXPECT_EQ(stream->CheckSyncStatus(), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, DeviceSynchronizationReturnsDeviceAbort)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    Context* const context = stream->Context_();
    Device* const device = stream->Device_();
    const uint32_t previousMode = context->GetDeviceFlags();
    const ScopeGuard restoreMode([context, previousMode]() { context->SetDeviceFlags(previousMode); });
    context->SetDeviceFlags(RT_DEVICE_SCHEDULE_BLOCKING_SYNC);
    {
        device->SetDeviceStatus(RT_ERROR_DEVICE_TASK_ABORT);
        const ScopeGuard resumeDevice([device]() { device->SetDeviceStatus(RT_ERROR_NONE); });
        MOCKER_CPP(&Stream::IsSyncFinished).stubs().will(returnValue(false));
        MOCKER_CPP(&Context::TaskReclaimforSyncDevice).expects(once()).will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP(&Context::SyncStreamsWithTimeout).expects(never());

        EXPECT_EQ(context->Synchronize(100), RT_ERROR_DEVICE_TASK_ABORT);
        GlobalMockObject::verify();
    }
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, DeviceSynchronizationBlockingStatusErrorPopsContextError)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    Context* const context = stream->Context_();
    const uint32_t previousMode = context->GetDeviceFlags();
    const ScopeGuard restoreMode([context, previousMode]() { context->SetDeviceFlags(previousMode); });
    context->SetDeviceFlags(RT_DEVICE_SCHEDULE_BLOCKING_SYNC);

    MOCKER_CPP(&Stream::IsSyncFinished).stubs().will(returnValue(false));
    MOCKER_CPP(&Context::TaskReclaimforSyncDevice).expects(once()).will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(context, &Context::CheckStatus).expects(once()).will(returnValue(RT_ERROR_DRV_ERR));
    MOCKER_CPP(&Context::PopContextErrMsg).expects(once());
    MOCKER_CPP(&Context::SyncStreamsWithTimeout).expects(never());

    EXPECT_EQ(context->Synchronize(100), RT_ERROR_DRV_ERR);
    GlobalMockObject::verify();
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

namespace {
struct ContextSyncStep {
    Stream* stream;
    int32_t timeout;
    uint32_t mode;
    int64_t durationNs;
    rtError_t result;
};
thread_local std::vector<ContextSyncStep> contextSyncSteps;
thread_local size_t contextSyncStepIndex = 0U;

rtError_t RunContextSyncStep(Stream* stream, bool waitSyncCq, int32_t timeout, uint32_t mode)
{
    EXPECT_LT(contextSyncStepIndex, contextSyncSteps.size());
    if (contextSyncStepIndex >= contextSyncSteps.size()) {
        return RT_ERROR_INVALID_VALUE;
    }
    const ContextSyncStep& step = contextSyncSteps[contextSyncStepIndex++];
    EXPECT_EQ(stream, step.stream);
    EXPECT_FALSE(waitSyncCq);
    EXPECT_EQ(timeout, step.timeout);
    EXPECT_EQ(mode, step.mode);
    syncTestClockNs += step.durationNs;
    return step.result;
}
} // namespace

TEST_F(CloudV2StreamTest, DeviceSynchronizationDefaultStreamPreservesLegacyResult)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    Context* const context = stream->Context_();
    Stream* const defaultStream = context->DefaultStream_();
    for (uint32_t mode : SYNC_TEST_MODES) {
        for (rtError_t result : {RT_ERROR_NONE, RT_ERROR_DRV_ERR}) {
            for (int64_t preparationNs : {0LL, 150000000LL}) {
                SCOPED_TRACE(
                    testing::Message() << "mode=" << mode << ", result=" << result
                                       << ", preparationNs=" << preparationNs);
                syncTestClockNs = syncTestInitialNs;
                syncTestPendingRawDelayNs = 0;
                MOCKER(clock_gettime).stubs().will(invoke(ReadSyncTestClock));
                const mmTimespec beginTime = mmGetTickCount();
                syncTestClockNs += preparationNs;
                contextSyncSteps = {{defaultStream, 100, mode, 150000000LL, result}};
                contextSyncStepIndex = 0U;
                MOCKER_CPP(&Stream::IsSyncFinished).stubs().will(returnValue(false));
                MOCKER_CPP_VIRTUAL(defaultStream, &Stream::Synchronize)
                    .expects(once())
                    .will(invoke(RunContextSyncStep));
                EXPECT_EQ(context->SyncStreamsWithTimeout({}, 100, beginTime, mode), result);
                EXPECT_EQ(contextSyncStepIndex, 1U);
                GlobalMockObject::verify();
            }
        }
    }
    contextSyncSteps.clear();
    syncTestClockNs = syncTestInitialNs;
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, DeviceSynchronizationPreservesRemainingTimeAndFirstError)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    Context* const context = stream->Context_();
    Stream* const defaultStream = context->DefaultStream_();
    const TsStreamFailureMode previousMode = context->GetCtxMode();
    context->SetCtxMode(CONTINUE_ON_FAILURE);
    const ScopeGuard restoreMode([=]() { context->SetCtxMode(previousMode); });
    for (uint32_t mode : SYNC_TEST_MODES) {
        SCOPED_TRACE(testing::Message() << "mode=" << mode);
        syncTestClockNs = syncTestInitialNs;
        syncTestPendingRawDelayNs = 0;
        MOCKER(clock_gettime).stubs().will(invoke(ReadSyncTestClock));
        const mmTimespec beginTime = mmGetTickCount();
        syncTestClockNs += 30000000LL;
        contextSyncSteps = {
            {stream, 100, mode, 20000000LL, RT_ERROR_DRV_ERR},
            {defaultStream, 50, mode, 100000000LL, RT_ERROR_INVALID_VALUE}};
        contextSyncStepIndex = 0U;
        MOCKER_CPP(&Stream::IsSyncFinished).stubs().will(returnValue(false));
        MOCKER_CPP_VIRTUAL(stream, &Stream::Synchronize).expects(exactly(2)).will(invoke(RunContextSyncStep));
        EXPECT_EQ(context->SyncStreamsWithTimeout({stream}, 100, beginTime, mode), RT_ERROR_DRV_ERR);
        EXPECT_EQ(contextSyncStepIndex, 2U);
        GlobalMockObject::verify();
    }
    contextSyncSteps.clear();
    syncTestClockNs = syncTestInitialNs;
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, DeviceSynchronizationKeepsOrdinaryStreamTimeout)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    Context* const context = stream->Context_();
    syncTestClockNs = syncTestInitialNs;
    syncTestPendingRawDelayNs = 0;
    MOCKER(clock_gettime).stubs().will(invoke(ReadSyncTestClock));
    const mmTimespec beginTime = mmGetTickCount();
    contextSyncSteps = {{stream, 100, RT_DEVICE_SCHEDULE_BLOCKING_SYNC, 101000000LL, RT_ERROR_NONE}};
    contextSyncStepIndex = 0U;
    MOCKER_CPP(&Stream::IsSyncFinished).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream, &Stream::Synchronize).expects(once()).will(invoke(RunContextSyncStep));
    EXPECT_EQ(
        context->SyncStreamsWithTimeout({stream}, 100, beginTime, RT_DEVICE_SCHEDULE_BLOCKING_SYNC),
        RT_ERROR_STREAM_SYNC_TIMEOUT);
    EXPECT_EQ(contextSyncStepIndex, 1U);
    GlobalMockObject::verify();
    contextSyncSteps.clear();
    syncTestClockNs = syncTestInitialNs;
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncPollingModesCheckTimeoutBeforeNextQuery)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* stream = rt_ut::UnwrapOrNull<Stream>(handle);
    Device* device = stream->Device_();
    const bool previousRecycleThread = device->GetIsChipSupportRecycleThread();
    device->SetIsChipSupportRecycleThread(true);
    const ScopeGuard restoreRecycleMode(
        [device, previousRecycleThread]() { device->SetIsChipSupportRecycleThread(previousRecycleThread); });
    ASSERT_TRUE(stream->IsSeparateSendAndRecycle());
    // The recycler can also call this globally hooked method.
    static thread_local bool isTestThread = false;
    static thread_local uint32_t queryCount = 0U;
    static thread_local bool queryCompleted = false;
    isTestThread = true;
    const ScopeGuard restoreTestThread([]() { isTestThread = false; });
    MOCKER_CPP_VIRTUAL(stream, &Stream::GetFinishedTaskIdBySqHead)
        .stubs()
        .will(invoke(+[](Stream*, uint16_t& sqHead, uint32_t& taskId) -> rtError_t {
            if (!isTestThread) {
                return RT_ERROR_DRV_ERR;
            }
            WaitPastSyncDeadline();
            ++queryCount;
            sqHead = 1U;
            taskId = queryCompleted ? 3U : MAX_UINT16_NUM;
            return RT_ERROR_NONE;
        }));
    for (uint32_t mode : {RT_DEVICE_SCHEDULE_AUTO, RT_DEVICE_SCHEDULE_SPIN, RT_DEVICE_SCHEDULE_YIELD}) {
        for (bool completed : {true, false}) {
            SCOPED_TRACE(testing::Message() << "mode=" << mode << ", completed=" << completed);
            queryCompleted = completed;
            queryCount = 0U;
            stream->SetNeedSyncFlag(false);
            EXPECT_EQ(
                stream->SynchronizeExecutedTask(3U, mmGetTickCount(), 10, mode),
                completed ? RT_ERROR_NONE : RT_ERROR_STREAM_SYNC_TIMEOUT);
            EXPECT_EQ(queryCount, 1U);
            EXPECT_EQ(stream->GetNeedSyncFlag(), !completed);
        }
    }
    GlobalMockObject::verify();
    device->SetIsChipSupportRecycleThread(previousRecycleThread);
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncNonSeparatedModesKeepLegacyReclaimCompletion)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* stream = rt_ut::UnwrapOrNull<Stream>(handle);
    Device* device = stream->Device_();
    const bool previousRecycleThread = device->GetIsChipSupportRecycleThread();
    device->SetIsChipSupportRecycleThread(false);
    const ScopeGuard restoreRecycleMode(
        [device, previousRecycleThread]() { device->SetIsChipSupportRecycleThread(previousRecycleThread); });
    ASSERT_FALSE(stream->IsSeparateSendAndRecycle());
    MOCKER_CPP_VIRTUAL(stream, &Stream::IsWaitFinish).stubs().will(returnValue(true));
    MOCKER_CPP_VIRTUAL(stream, &Stream::StarsGetMaxTryCount).stubs().will(returnValue(8U));
    MOCKER(TaskReclaimByStream).stubs().will(invoke(ReclaimSyncAfterDeadline));
    MOCKER_CPP_VIRTUAL(device, &Device::TaskReclaimByStm).stubs().will(invoke(ReclaimDeviceSyncAfterDeadline));
    MOCKER_CPP_VIRTUAL(Runtime::Instance()->ApiImpl_(), &Api::LaunchHostFunc).expects(never());
    for (uint32_t mode : {RT_DEVICE_SCHEDULE_SPIN, RT_DEVICE_SCHEDULE_YIELD, RT_DEVICE_SCHEDULE_BLOCKING_SYNC}) {
        SCOPED_TRACE(testing::Message() << "mode=" << mode);
        syncTestHeadQueries = 0U;
        EXPECT_EQ(stream->Synchronize(false, 10, mode), RT_ERROR_NONE);
        EXPECT_EQ(syncTestHeadQueries, 1U);
    }
    GlobalMockObject::verify();
    device->SetIsChipSupportRecycleThread(previousRecycleThread);
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncNonSeparatedModesKeepLegacyRecordThreshold)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    Device* const device = stream->Device_();
    const bool previousRecycleThread = device->GetIsChipSupportRecycleThread();
    device->SetIsChipSupportRecycleThread(false);
    const ScopeGuard restoreRecycleMode(
        [device, previousRecycleThread]() { device->SetIsChipSupportRecycleThread(previousRecycleThread); });
    ASSERT_FALSE(stream->IsSeparateSendAndRecycle());
    MOCKER_CPP_VIRTUAL(stream, &Stream::IsWaitFinish).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream, &Stream::StarsGetMaxTryCount).stubs().will(returnValue(1U));
    MOCKER(TaskReclaimByStream).stubs().will(invoke(ReclaimSyncAfterDeadline));
    MOCKER_CPP_VIRTUAL(device, &Device::TaskReclaimByStm).stubs().will(invoke(ReclaimDeviceSyncAfterDeadline));
    MOCKER_CPP_VIRTUAL(stream, &Stream::SubmitRecordTask)
        .expects(exactly(3))
        .will(invoke(FailSyncRecordAfterLegacyPolling));
    MOCKER_CPP_VIRTUAL(Runtime::Instance()->ApiImpl_(), &Api::LaunchHostFunc).expects(never());
    for (uint32_t mode : {RT_DEVICE_SCHEDULE_SPIN, RT_DEVICE_SCHEDULE_YIELD, RT_DEVICE_SCHEDULE_BLOCKING_SYNC}) {
        SCOPED_TRACE(testing::Message() << "mode=" << mode);
        syncTestHeadQueries = 0U;
        EXPECT_EQ(stream->Synchronize(false, 1000, mode), RT_ERROR_DRV_ERR);
        EXPECT_EQ(syncTestHeadQueries, 2U);
    }
    GlobalMockObject::verify();
    device->SetIsChipSupportRecycleThread(previousRecycleThread);
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncNonSeparatedContextYieldKeepsLegacyPreScanInterval)
{
    rtStream_t firstHandle = nullptr;
    rtStream_t secondHandle = nullptr;
    ASSERT_EQ(rtStreamCreate(&firstHandle, 0), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamCreate(&secondHandle, 0), RT_ERROR_NONE);
    Stream* const first = rt_ut::UnwrapOrNull<Stream>(firstHandle);
    Stream* const second = rt_ut::UnwrapOrNull<Stream>(secondHandle);
    Context* const context = first->Context_();
    Device* const device = first->Device_();
    ASSERT_EQ(context, second->Context_());
    ASSERT_EQ(context->StreamList_().size(), 2U);
    const bool previousRecycleThread = device->GetIsChipSupportRecycleThread();
    const uint32_t previousMode = context->GetDeviceFlags();
    ScopeGuard restoreState([=]() {
        first->pendingNum_.Set(0U);
        second->pendingNum_.Set(0U);
        device->SetIsChipSupportRecycleThread(previousRecycleThread);
        context->SetDeviceFlags(previousMode);
    });
    device->SetIsChipSupportRecycleThread(false);
    ASSERT_FALSE(first->IsSeparateSendAndRecycle());
    ASSERT_FALSE(second->IsSeparateSendAndRecycle());
    first->pendingNum_.Set(20U);
    second->pendingNum_.Set(20U);
    context->SetDeviceFlags(RT_DEVICE_SCHEDULE_YIELD);
    syncTestHeadQueries = 0U;
    MOCKER(TaskReclaimByStream).stubs().will(invoke(CountSyncPreScanReclaim));
    MOCKER_CPP_VIRTUAL(device, &Device::TaskReclaim).stubs().will(invoke(CountDeviceSyncPreScanReclaim));
    MOCKER(sched_yield).expects(once()).will(invoke(FinishSyncPreScanOnYield));
    MOCKER_CPP(&Context::SyncStreamsWithTimeout).expects(once()).will(returnValue(RT_ERROR_DRV_ERR));
    MOCKER_CPP_VIRTUAL(Runtime::Instance()->ApiImpl_(), &Api::LaunchHostFunc).expects(never());
    EXPECT_EQ(context->Synchronize(1000), RT_ERROR_DRV_ERR);
    EXPECT_EQ(syncTestHeadQueries, 1002U);
    EXPECT_EQ(first->GetPendingNum(), 0U);
    EXPECT_EQ(second->GetPendingNum(), 0U);
    EXPECT_EQ(context->GetDeviceFlags(), static_cast<uint32_t>(RT_DEVICE_SCHEDULE_YIELD));
    first->pendingNum_.Set(0U);
    second->pendingNum_.Set(0U);
    device->SetIsChipSupportRecycleThread(previousRecycleThread);
    context->SetDeviceFlags(previousMode);
    restoreState.ReleaseGuard();
    GlobalMockObject::verify();
    EXPECT_EQ(rtStreamDestroy(secondHandle), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(firstHandle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncUserSubscriptionOnlyBlockingFallsBackToAutoWithOneErrorPop)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    Device* const device = stream->Device_();
    const bool previousRecycleThread = device->GetIsChipSupportRecycleThread();
    const auto previousSubscription = stream->GetSubscribeFlag();
    const uint32_t previousLastTaskId = stream->GetLastTaskId();
    device->SetIsChipSupportRecycleThread(true);
    const ScopeGuard restoreRecycleMode(
        [device, previousRecycleThread]() { device->SetIsChipSupportRecycleThread(previousRecycleThread); });
    ASSERT_TRUE(stream->IsSeparateSendAndRecycle());
    stream->SetSubscribeFlag(StreamSubscribeFlag::SUBSCRIBE_USER);
    stream->SetLastTaskId(3U);
    const uint32_t previousMode = stream->Context_()->GetDeviceFlags();
    stream->Context_()->SetDeviceFlags(RT_DEVICE_SCHEDULE_BLOCKING_SYNC);
    ScopeGuard restoreState([=]() {
        stream->Context_()->SetDeviceFlags(previousMode);
        stream->SetLastTaskId(previousLastTaskId);
        stream->SetSubscribeFlag(previousSubscription);
    });
    for (uint32_t mode : SYNC_TEST_MODES) {
        SCOPED_TRACE(mode);
        const uint32_t expectedMode = (mode == RT_DEVICE_SCHEDULE_BLOCKING_SYNC) ? RT_DEVICE_SCHEDULE_AUTO : mode;
        MOCKER_CPP(&Stream::SynchronizeBlocking).expects(never());
        MOCKER_CPP_VIRTUAL(stream, &Stream::SynchronizeExecutedTask)
            .expects(once())
            .with(mockcpp::any(), mockcpp::any(), eq(100), eq(expectedMode))
            .will(returnValue(RT_ERROR_DRV_ERR));
        MOCKER_CPP(&Context::PopContextErrMsg).expects(once());
        EXPECT_EQ(stream->Synchronize(false, 100, mode), RT_ERROR_DRV_ERR);
        EXPECT_EQ(stream->GetSubscribeFlag(), StreamSubscribeFlag::SUBSCRIBE_USER);
        EXPECT_EQ(stream->Context_()->GetDeviceFlags(), RT_DEVICE_SCHEDULE_BLOCKING_SYNC);
        GlobalMockObject::verify();
    }
    stream->Context_()->SetDeviceFlags(previousMode);
    stream->SetLastTaskId(previousLastTaskId);
    stream->SetSubscribeFlag(previousSubscription);
    restoreState.ReleaseGuard();
    GlobalMockObject::verify();
    device->SetIsChipSupportRecycleThread(previousRecycleThread);
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncScheduleCtrlSqUsesConfiguredBlockingMode)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    const ScopeGuard cleanupStream([&]() { EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE); });
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    MOCKER_CPP(&Stream::IsSeparateSendAndRecycle).stubs().will(returnValue(true));
    MOCKER_CPP(&Stream::IsCtrlSQStream).stubs().will(returnValue(true));
    EXPECT_EQ(
        stream->ResolveSyncScheduleMode(RT_DEVICE_SCHEDULE_BLOCKING_SYNC),
        static_cast<uint32_t>(RT_DEVICE_SCHEDULE_BLOCKING_SYNC));
    GlobalMockObject::verify();
}

TEST_F(CloudV2StreamTest, SyncScheduleRestrictionsUseExpectedFallbacks)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    const ScopeGuard cleanupStream([&]() { EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE); });
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    Context* const context = stream->Context_();
    Device* const device = stream->Device_();
    const uint32_t previousLastTaskId = stream->GetLastTaskId();
    const uint32_t previousMode = context->GetDeviceFlags();
    const bool previousCallbackThreadExists = context->GetCallBackThreadExistFlag();
    const uint64_t previousCallbackThreadId = context->GetCallBackThreadId();
    const uint64_t currentThreadId = PidTidFetcher::GetCurrentUserTid();
    const bool previousRecycleThread = device->GetIsChipSupportRecycleThread();
    const bool previousSoftwareSq = stream->IsSoftwareSqEnable();
    const bool previousAutoSplitSq = stream->IsAutoSplitSq();
    RawDevice* const rawDevice = static_cast<RawDevice*>(device);
    const bool previousIsStars = rawDevice->properties_.isStars;
    ScopeGuard restoreState([=]() {
        stream->SetBindFlag(false);
        stream->SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_NONE);
        stream->SetLastTaskId(previousLastTaskId);
        context->SetDeviceFlags(previousMode);
        context->callBackThreadExist_.Set(previousCallbackThreadExists);
        context->callBackThreadId_ = previousCallbackThreadId;
        device->SetIsChipSupportRecycleThread(previousRecycleThread);
        stream->isSoftwareSqEnable_ = previousSoftwareSq;
        stream->SetAutoSplitSq(previousAutoSplitSq);
        rawDevice->properties_.isStars = previousIsStars;
    });
    device->SetIsChipSupportRecycleThread(true);
    context->SetDeviceFlags(RT_DEVICE_SCHEDULE_BLOCKING_SYNC);
    stream->SetLastTaskId(3U);
    ASSERT_TRUE(stream->IsSeparateSendAndRecycle());
    // Test the common scope gate and mode selection for the remaining stream states.
    for (uint32_t restriction = 0U; restriction < 8U; ++restriction) {
        rawDevice->properties_.isStars = (restriction != 3U);
        device->SetIsChipSupportRecycleThread(restriction != 4U);
        stream->SetBindFlag(restriction == 0U);
        stream->SetCaptureStatus((restriction == 1U) ? RT_STREAM_CAPTURE_STATUS_ACTIVE : RT_STREAM_CAPTURE_STATUS_NONE);
        stream->isSoftwareSqEnable_ = (restriction == 6U);
        stream->SetAutoSplitSq(restriction == 7U);
        context->callBackThreadExist_.Set(restriction == 5U);
        context->callBackThreadId_ = currentThreadId;
        for (uint32_t mode : SYNC_TEST_MODES) {
            SCOPED_TRACE(testing::Message() << "restriction=" << restriction << ", mode=" << mode);
            const bool commonFallback =
                (restriction == 0U) || (restriction == 3U) || (restriction == 4U) || (restriction == 6U);
            const uint32_t expectedMode = commonFallback ? RT_DEVICE_SCHEDULE_AUTO : mode;
            MOCKER_CPP(&Stream::IsCtrlSQStream).stubs().will(returnValue(restriction == 2U));
            MOCKER_CPP(&Context::PopContextErrMsg).expects(never());
            MOCKER_CPP_VIRTUAL(stream, &Stream::GetSynchronizeError).expects(never());
            if (expectedMode == RT_DEVICE_SCHEDULE_BLOCKING_SYNC) {
                MOCKER_CPP(&Stream::SynchronizeBlocking).expects(once()).will(returnValue(RT_ERROR_DRV_ERR));
            } else {
                MOCKER_CPP(&Stream::SynchronizeBlocking).expects(never());
                MOCKER_CPP_VIRTUAL(stream, &Stream::SynchronizeExecutedTask)
                    .expects(once())
                    .with(eq(3U), mockcpp::any(), eq(37), eq(expectedMode))
                    .will(returnValue(RT_ERROR_DRV_ERR));
            }
            EXPECT_EQ(stream->SynchronizeImpl(3U, MAX_UINT16_NUM, 37, mode), RT_ERROR_DRV_ERR);
            EXPECT_EQ(context->GetDeviceFlags(), RT_DEVICE_SCHEDULE_BLOCKING_SYNC);
            GlobalMockObject::verify();
        }
    }
}

TEST_F(CloudV2StreamTest, SyncBlockingKeepsTotalBudgetForCommonRecycleAndReturnsSubmissionError)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    stream->SetLastTaskId(3U);
    Device* const device = stream->Device_();
    const bool previousRecycleThread = device->GetIsChipSupportRecycleThread();
    device->SetIsChipSupportRecycleThread(true);
    const ScopeGuard restoreRecycleMode(
        [device, previousRecycleThread]() { device->SetIsChipSupportRecycleThread(previousRecycleThread); });
    ASSERT_TRUE(stream->IsSeparateSendAndRecycle());
    for (rtError_t waitError : {RT_ERROR_NONE, RT_ERROR_SUBSCRIBE_STREAM}) {
        for (rtError_t recycleError : {RT_ERROR_NONE, RT_ERROR_DRV_ERR}) {
            SCOPED_TRACE(testing::Message() << waitError << ", " << recycleError);
            syncTestClockNs = syncTestInitialNs;
            syncTestPendingRawDelayNs = 0;
            syncTestFailClock = false;
            syncTestRecycleError = recycleError;
            syncTestBlockingError = waitError;
            MOCKER(clock_gettime).stubs().will(invoke(ReadSyncTestClock));
            MOCKER_CPP(&Stream::IsSyncFinished).expects(never());
            MOCKER_CPP(&Context::PopContextErrMsg).expects(never());
            MOCKER_CPP_VIRTUAL(stream, &Stream::GetSynchronizeError).expects(never());
            MOCKER_CPP(&Stream::SynchronizeBlocking)
                .expects(once())
                .with(eq(100))
                .will(invoke(ConsumeSyncBlockingBudget));
            if (waitError == RT_ERROR_NONE) {
                MOCKER_CPP(&Stream::WaitConcernedTaskRecycled)
                    .expects(once())
                    .with(eq(static_cast<uint16_t>(7U)), mockcpp::any(), eq(100))
                    .will(invoke(CheckSyncBudgetDuringCommonRecycle));
            } else {
                MOCKER_CPP(&Stream::WaitConcernedTaskRecycled).expects(never());
            }
            EXPECT_EQ(
                stream->SynchronizeImpl(3U, 7U, 100, RT_DEVICE_SCHEDULE_BLOCKING_SYNC),
                waitError == RT_ERROR_NONE ? recycleError : waitError);
            GlobalMockObject::verify();
        }
    }
    device->SetIsChipSupportRecycleThread(previousRecycleThread);
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncAllModesUseCommonConcernedTaskRecycle)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    Device* const device = stream->Device_();
    const uint32_t previousLastTaskId = stream->GetLastTaskId();
    const bool previousRecycleThread = device->GetIsChipSupportRecycleThread();
    ScopeGuard restoreState([=]() {
        device->SetIsChipSupportRecycleThread(previousRecycleThread);
        stream->SetLastTaskId(previousLastTaskId);
    });
    device->SetIsChipSupportRecycleThread(true);
    stream->SetLastTaskId(3U);
    ASSERT_TRUE(stream->IsSeparateSendAndRecycle());

    for (uint32_t mode : SYNC_TEST_MODES) {
        SCOPED_TRACE(testing::Message() << "mode=" << mode);
        if (mode == RT_DEVICE_SCHEDULE_BLOCKING_SYNC) {
            MOCKER_CPP(&Stream::SynchronizeBlocking).expects(once()).will(returnValue(RT_ERROR_NONE));
        } else {
            MOCKER_CPP(&Stream::SynchronizeBlocking).expects(never());
            MOCKER_CPP_VIRTUAL(stream, &Stream::SynchronizeExecutedTask)
                .expects(once())
                .with(eq(3U), mockcpp::any(), eq(100), eq(mode))
                .will(returnValue(RT_ERROR_NONE));
        }
        MOCKER_CPP(&Stream::WaitConcernedTaskRecycled)
            .expects(once())
            .with(eq(static_cast<uint16_t>(7U)), mockcpp::any(), eq(100))
            .will(returnValue(RT_ERROR_NONE));

        EXPECT_EQ(stream->SynchronizeImpl(3U, 7U, 100, mode), RT_ERROR_NONE);
        GlobalMockObject::verify();
    }

    restoreState.ReleaseGuard();
    device->SetIsChipSupportRecycleThread(previousRecycleThread);
    stream->SetLastTaskId(previousLastTaskId);
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncConcernedTaskRecycleUsesCommonStatusCheck)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);

    MOCKER_CPP_VIRTUAL(stream, &Stream::CheckContextStatus)
        .expects(once())
        .with(eq(false))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(stream, &Stream::IsTaskExcuted).expects(once()).will(returnValue(true));

    EXPECT_EQ(stream->WaitConcernedTaskRecycled(7U, mmGetTickCount(), -1), RT_ERROR_NONE);

    GlobalMockObject::verify();
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncBlockingTargetBeforeStreamTailKeepsBlockingMode)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    Device* const device = stream->Device_();
    const uint32_t previousLastTaskId = stream->GetLastTaskId();
    const bool previousRecycleThread = device->GetIsChipSupportRecycleThread();
    stream->SetLastTaskId(4U);
    device->SetIsChipSupportRecycleThread(true);
    ScopeGuard restoreState([=]() {
        stream->SetLastTaskId(previousLastTaskId);
        device->SetIsChipSupportRecycleThread(previousRecycleThread);
    });
    ASSERT_TRUE(stream->IsSeparateSendAndRecycle());

    syncTestClockNs = syncTestInitialNs;
    syncTestPendingRawDelayNs = 0;
    syncTestFailClock = false;
    MOCKER(clock_gettime).stubs().will(invoke(ReadSyncTestClock));
    MOCKER_CPP(&Stream::SynchronizeBlocking).expects(once()).with(eq(100)).will(returnValue(RT_ERROR_DRV_ERR));

    EXPECT_EQ(stream->SynchronizeImpl(3U, MAX_UINT16_NUM, 100, RT_DEVICE_SCHEDULE_BLOCKING_SYNC), RT_ERROR_DRV_ERR);
    GlobalMockObject::verify();
    stream->SetLastTaskId(previousLastTaskId);
    device->SetIsChipSupportRecycleThread(previousRecycleThread);
    restoreState.ReleaseGuard();
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, SyncInternalWaitTaskDefaultsToAutoRegardlessOfContextMode)
{
    rtStream_t handle = nullptr;
    ASSERT_EQ(rtStreamCreate(&handle, 0), RT_ERROR_NONE);
    Stream* const stream = rt_ut::UnwrapOrNull<Stream>(handle);
    Context* const context = stream->Context_();
    Device* const device = stream->Device_();
    const uint32_t previousMode = context->GetDeviceFlags();
    const uint32_t previousLastTaskId = stream->GetLastTaskId();
    const bool previousRecycleThread = device->GetIsChipSupportRecycleThread();
    ScopeGuard restoreState([=]() {
        context->SetDeviceFlags(previousMode);
        stream->SetLastTaskId(previousLastTaskId);
        device->SetIsChipSupportRecycleThread(previousRecycleThread);
    });

    stream->SetLastTaskId(3U);
    device->SetIsChipSupportRecycleThread(true);
    ASSERT_TRUE(stream->IsSeparateSendAndRecycle());
    ASSERT_FALSE(stream->GetBindFlag());

    for (uint32_t mode : SYNC_TEST_MODES) {
        SCOPED_TRACE(mode);
        context->SetDeviceFlags(mode);
        uint32_t waitMode = MAX_UINT32_NUM;
        MOCKER_CPP(&Context::PopContextErrMsg).expects(never());
        MOCKER_CPP_VIRTUAL(stream, &Stream::GetSynchronizeError).expects(never());
        MOCKER_CPP_VIRTUAL(stream, &Stream::SynchronizeExecutedTask)
            .stubs()
            .with(eq(3U), mockcpp::any(), eq(100), spy(waitMode))
            .will(returnValue(RT_ERROR_DRV_ERR));
        MOCKER_CPP(&Stream::SynchronizeBlocking).stubs().will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));

        EXPECT_EQ(stream->WaitTask(false, 3U, 100), RT_ERROR_DRV_ERR);
        EXPECT_EQ(waitMode, static_cast<uint32_t>(RT_DEVICE_SCHEDULE_AUTO));
        EXPECT_EQ(context->GetDeviceFlags(), mode);
        GlobalMockObject::verify();
    }

    context->SetDeviceFlags(previousMode);
    stream->SetLastTaskId(previousLastTaskId);
    device->SetIsChipSupportRecycleThread(previousRecycleThread);
    restoreState.ReleaseGuard();
    EXPECT_EQ(rtStreamDestroy(handle), RT_ERROR_NONE);
}

TEST_F(CloudV2StreamTest, ReBuildDriverStreamResource_RebindSoftwareSqLogicCqSuccess)
{
    Runtime* rtInstance = Runtime::Instance();
    Device* device = rtInstance->DeviceRetain(0, 0);
    ASSERT_NE(device, nullptr);
    Stream* stream = new Stream(device, 3U);
    ASSERT_NE(stream, nullptr);
    stream->streamId_ = 17;
    stream->SetLogicalCqId(23U);
    stream->SetSoftWareSqEnable();

    Driver* driver = device->Driver_();
    MOCKER_CPP_VIRTUAL(driver, &Driver::StreamIdReservedFree)
        .expects(once())
        .with(eq(17), eq(device->Id_()), eq(device->DevGetTsId()))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::ReAllocResourceId)
        .expects(once())
        .with(eq(device->Id_()), eq(device->DevGetTsId()), eq(3U), eq(17U), eq(DRV_STREAM_ID), eq(0U))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::LogicCqAllocateV2).expects(never());
    MOCKER_CPP_VIRTUAL(driver, &Driver::StreamBindLogicCq)
        .expects(once())
        .with(eq(device->Id_()), eq(device->DevGetTsId()), eq(17U), eq(23U), eq(0U))
        .will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(stream->ReBuildDriverStreamResource(), RT_ERROR_NONE);

    GlobalMockObject::verify();
    stream->device_ = nullptr;
    delete stream;
    rtInstance->DeviceRelease(device);
}

TEST_F(CloudV2StreamTest, ReBuildDriverStreamResource_LogicCqBindFailed)
{
    Runtime* rtInstance = Runtime::Instance();
    Device* device = rtInstance->DeviceRetain(0, 0);
    ASSERT_NE(device, nullptr);
    Stream* stream = new Stream(device, 0U);
    ASSERT_NE(stream, nullptr);
    stream->streamId_ = 17;
    stream->SetLogicalCqId(23U);
    stream->SetSoftWareSqEnable();

    Driver* driver = device->Driver_();
    MOCKER_CPP_VIRTUAL(driver, &Driver::StreamIdReservedFree).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::ReAllocResourceId).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::LogicCqAllocateV2).expects(never());
    MOCKER_CPP_VIRTUAL(driver, &Driver::StreamBindLogicCq).expects(once()).will(returnValue(RT_ERROR_DRV_NOT_SUPPORT));

    EXPECT_EQ(stream->ReBuildDriverStreamResource(), RT_ERROR_DRV_NOT_SUPPORT);

    GlobalMockObject::verify();
    stream->device_ = nullptr;
    delete stream;
    rtInstance->DeviceRelease(device);
}

TEST_F(CloudV2StreamTest, ReBuildDriverStreamResource_NonSoftwareSqSkipsLogicCqRestore)
{
    Runtime* rtInstance = Runtime::Instance();
    Device* device = rtInstance->DeviceRetain(0, 0);
    ASSERT_NE(device, nullptr);
    Stream* stream = new Stream(device, 0U);
    ASSERT_NE(stream, nullptr);
    stream->streamId_ = 17;
    stream->SetLogicalCqId(23U);

    Driver* driver = device->Driver_();
    MOCKER_CPP_VIRTUAL(driver, &Driver::StreamIdReservedFree).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::ReAllocResourceId).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::LogicCqAllocateV2).expects(never());
    MOCKER_CPP_VIRTUAL(driver, &Driver::StreamBindLogicCq).expects(never());

    EXPECT_EQ(stream->ReBuildDriverStreamResource(), RT_ERROR_NONE);

    GlobalMockObject::verify();
    stream->device_ = nullptr;
    delete stream;
    rtInstance->DeviceRelease(device);
}

TEST_F(CloudV2StreamTest, ReBuildDriverStreamResource_UnassignedLogicCqSkipsRebind)
{
    Runtime* rtInstance = Runtime::Instance();
    Device* device = rtInstance->DeviceRetain(0, 0);
    ASSERT_NE(device, nullptr);
    Stream* stream = new Stream(device, 0U);
    ASSERT_NE(stream, nullptr);
    stream->streamId_ = 17;
    stream->SetSoftWareSqEnable();

    Driver* driver = device->Driver_();
    MOCKER_CPP_VIRTUAL(driver, &Driver::StreamIdReservedFree).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::ReAllocResourceId).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::LogicCqAllocateV2).expects(never());
    MOCKER_CPP_VIRTUAL(driver, &Driver::StreamBindLogicCq).expects(never());

    EXPECT_EQ(stream->ReBuildDriverStreamResource(), RT_ERROR_NONE);

    GlobalMockObject::verify();
    stream->device_ = nullptr;
    delete stream;
    rtInstance->DeviceRelease(device);
}
