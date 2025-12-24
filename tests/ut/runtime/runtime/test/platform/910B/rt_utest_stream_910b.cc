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
#include "driver/ascend_hal.h"
#include "securec.h"
#include "runtime/rt.h"
#include "runtime/rts/rts.h"
#include "runtime/event.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "api.hpp"
#include "api_impl.hpp"
#include "api_error.hpp"
#include "program.hpp"
#include "context.hpp"
#include "raw_device.hpp"
#include "logger.hpp"
#include "engine.hpp"
#include "task_res.hpp"
#include "rdma_task.h"
#include "stars.hpp"
#include "npu_driver.hpp"
#include "api_error.hpp"
#include "event.hpp"
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "notify.hpp"
#include "count_notify.hpp"
#include "profiler.hpp"
#include "api_profile_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "device_state_callback_manager.hpp"
#include "task_fail_callback_manager.hpp"
#include "model.hpp"
#include "capture_model.hpp"
#include "subscribe.hpp"
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include <cstring>
#include "thread_local_container.hpp"
#include "heterogenous.h"
#include "task_execute_time.h"
#include "runtime/rts/rts_device.h"
#include "runtime/rts/rts_stream.h"
#include "api_c.h"
#undef protected
#undef private

using namespace testing;
using namespace cce::runtime;

class StreamTest910B : public testing::Test
{
protected:
    static void SetUpTestCase()
    {

    }

    static void TearDownTestCase()
    {

    }

    virtual void SetUp()
    {
        std::cout << "StreamTest910B SetUp" << std::endl;
        rtSetDevice(0);
        std::cout << "StreamTest910B SetUp end" << std::endl;
    }

    virtual void TearDown()
    {
        std::cout << "StreamTest910B TearDown" << std::endl;
        GlobalMockObject::verify();
        rtDeviceReset(0);
        std::cout << "StreamTest910B TearDown end" << std::endl;
    }
};

TEST_F(StreamTest910B, capture_event_external)
{
    rtError_t error;
    rtEvent_t event = nullptr;
    rtModel_t model;
    rtStream_t stream1;
    rtStream_t stream2;
    void *args[] = {&error, NULL};
    rtStreamCaptureStatus status;

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Stream::WaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::ModelWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::IsStreamFull).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamCreate(&stream2, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventCreateWithFlag(&event, RT_EVENT_EXTERNAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventRecord(event, stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamWaitEvent(stream1, event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamGetCaptureInfo(stream1, &status, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(status, RT_STREAM_CAPTURE_STATUS_ACTIVE);
    EXPECT_NE(model, nullptr);

    error = rtStreamGetCaptureInfo(stream2, &status, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(status, RT_STREAM_CAPTURE_STATUS_NONE);
    EXPECT_EQ(model, nullptr);

    error = rtStreamEndCapture(stream1, &model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    // 确保Event内存被释放
    Event *eventObj = static_cast<Event *>(event);
    uint32_t evtId = 0U;
    (void)eventObj->GetEventID(&evtId);
    TryToFreeEventIdAndDestroyEvent(&eventObj, evtId, false);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(StreamTest910B, capture_event_external2)
{
    rtError_t error;
    rtEvent_t event = nullptr;
    rtModel_t model;
    rtStream_t stream1;
    rtStream_t stream2;
    void *args[] = {&error, NULL};
    rtStreamCaptureStatus status;

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Stream::WaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::ModelWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::IsStreamFull).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamCreate(&stream2, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventCreateWithFlag(&event, RT_EVENT_EXTERNAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventRecord(event, stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamWaitEvent(stream2, event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamGetCaptureInfo(stream1, &status, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(status, RT_STREAM_CAPTURE_STATUS_ACTIVE);
    EXPECT_NE(model, nullptr);

    error = rtStreamGetCaptureInfo(stream2, &status, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(status, RT_STREAM_CAPTURE_STATUS_NONE);
    EXPECT_EQ(model, nullptr);

    error = rtStreamEndCapture(stream1, &model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream2);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    // 确保Event内存被释放
    Event *eventObj = static_cast<Event *>(event);
    uint32_t evtId = 0U;
    (void)eventObj->GetEventID(&evtId);
    TryToFreeEventIdAndDestroyEvent(&eventObj, evtId, false);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(StreamTest910B, task_group_no_captured)
{
    rtError_t error;
    rtStream_t stream1;
    rtTaskGrp_t taskGrpHandle = nullptr;

    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskGrp(stream1);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_NOT_CAPTURED);

    error = rtsStreamEndTaskGrp(stream1, &taskGrpHandle);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_NOT_CAPTURED);

    error = rtStreamSynchronize(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(StreamTest910B, task_group_repeat)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream1;
    rtTaskGrp_t taskGrpHandle = nullptr;

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Stream::WaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::ModelWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::IsStreamFull).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskGrp(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskGrp(stream1);
    EXPECT_EQ(error, ACL_ERROR_STREAM_TASK_GROUP_STATUS);

    error = rtsStreamEndTaskGrp(stream1, &taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamEndTaskGrp(stream1, &taskGrpHandle);
    EXPECT_EQ(error, ACL_ERROR_STREAM_TASK_GROUP_STATUS);

    error = rtStreamEndCapture(stream1, &model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(StreamTest910B, task_group_update)
{
    rtError_t error;
    rtModel_t model;
    rtStream_t stream1;
    rtTaskGrp_t taskGrpHandle = nullptr;

    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    Stream *stream = new Stream((Device *)device, 0);
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(memcpy_s).stubs().will(returnValue(NULL));
    MOCKER_CPP(&Stream::WaitTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::ModelWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::IsStreamFull).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(stream, &Stream::AddTaskToList).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamBeginCapture(stream1, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskGrp(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamEndTaskGrp(stream1, &taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamEndCapture(stream1, &model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamBeginTaskUpdate(stream1, taskGrpHandle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsStreamEndTaskUpdate(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamSynchronize(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(StreamTest910B, task_group_update_3)
{
    rtError_t error;
    rtStream_t stream1;
    rtTaskGrp_t taskGrpHandle = nullptr;
    void *args[] = {&error, NULL};
    rtModel_t model;

    error = rtStreamCreate(&stream1, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    // 直接endtask
    error = rtsStreamEndTaskUpdate(stream1);
    EXPECT_EQ(error, ACL_ERROR_STREAM_TASK_GROUP_STATUS);

    // taskGrpHandle为空
    error = rtsStreamBeginTaskUpdate(stream1, taskGrpHandle);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsStreamBeginTaskUpdate(nullptr, taskGrpHandle);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsStreamEndTaskUpdate(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamDestroy(stream1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(StreamTest910B, memcpy_batch_async_param_err0)
{
    constexpr size_t count = 4U;
    constexpr size_t len = 128U;
    char *dsts[count];
    char *srcs[count];
    size_t sizes[count];
    size_t destMaxs[count];
    for (size_t i = 0; i < count; i++) {
        dsts[i] = new (std::nothrow) char[len];
        srcs[i] = new (std::nothrow) char[len];
        memset(srcs[i], 'a + i', len);
        sizes[i] = i + 1;
        destMaxs[i] = len;
    }
    constexpr size_t numAttrs = 2U;
    rtMemcpyBatchAttr attrs[numAttrs];
    size_t attrsIdxs[numAttrs] = {0, 3};
    for (size_t i = 0; i < numAttrs; i++) {
        attrs[i].srcLoc.id = 0U;
        attrs[i].srcLoc.type = RT_MEMORY_LOC_HOST;
        attrs[i].dstLoc.id = 0U;
        attrs[i].dstLoc.type = RT_MEMORY_LOC_DEVICE;
    }

    size_t failIdx;
    rtError_t error;
    error = rtsMemcpyBatchAsync(nullptr, destMaxs, (void **)srcs, sizes, count, attrs, attrsIdxs, numAttrs, &failIdx, nullptr);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatchAsync((void **)dsts, nullptr, (void **)srcs, sizes, count, attrs, attrsIdxs, numAttrs, &failIdx, nullptr);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, nullptr, sizes, count, attrs, attrsIdxs, numAttrs, &failIdx, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, nullptr, count, attrs, attrsIdxs, numAttrs, &failIdx, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, sizes, 0U, attrs, attrsIdxs, numAttrs, &failIdx, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, sizes, count, nullptr, attrsIdxs, numAttrs, &failIdx, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, sizes, count, attrs, nullptr, numAttrs, &failIdx, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, sizes, count, attrs, attrsIdxs, 0U, &failIdx, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, sizes, count, attrs, attrsIdxs, numAttrs, nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    sizes[0] = 0;
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, sizes, count, attrs, attrsIdxs, numAttrs, nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    for (size_t i = 0; i < count; i++) {
        delete [] dsts[i];
        delete [] srcs[i];
    }

    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, sizes, count, attrs, attrsIdxs, numAttrs, nullptr, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(StreamTest910B, memcpy_batch_async_param_err1)
{
    constexpr size_t count = 4U;
    constexpr size_t len = 128U;
    char *dsts[count];
    char *srcs[count];
    size_t sizes[count];
    size_t destMaxs[count];
    for (size_t i = 0; i < count; i++) {
        dsts[i] = new (std::nothrow) char[len];
        srcs[i] = new (std::nothrow) char[len];
        memset(srcs[i], 'a + i', len);
        sizes[i] = i + 1;
        destMaxs[i] = len;
    }

    constexpr size_t numAttrs = 2U;
    rtMemcpyBatchAttr attrs[numAttrs];
    size_t attrsIdxs[numAttrs] = {0, 3};
    for (size_t i = 0; i < numAttrs; i++) {
        attrs[i].srcLoc.id = 0U;
        attrs[i].srcLoc.type = RT_MEMORY_LOC_HOST;
        attrs[i].dstLoc.id = 0U;
        attrs[i].dstLoc.type = RT_MEMORY_LOC_DEVICE;
    }

    constexpr size_t numAttrs0 = count + 1;
    rtMemcpyBatchAttr attrs0[numAttrs0];
    size_t attrsIdxs0[numAttrs0] = {0, 2, 4, 5};
    for (size_t i = 0; i < numAttrs0; i++) {
        attrs0[i].srcLoc.id = 0U;
        attrs0[i].srcLoc.type = RT_MEMORY_LOC_HOST;
        attrs0[i].dstLoc.id = 0U;
        attrs0[i].dstLoc.type = RT_MEMORY_LOC_DEVICE;
    }

    size_t failIdx;
    rtError_t error;
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, sizes, count, attrs0, attrsIdxs0, numAttrs0, &failIdx, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);

    size_t attrsIdxs1[numAttrs] = {1, 3};
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, sizes, count, attrs, attrsIdxs1, numAttrs, &failIdx, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);

    size_t attrsIdxs2[numAttrs + 1] = {0, 3, 5};
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, sizes, count, attrs, attrsIdxs2, numAttrs + 1, &failIdx, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);

    size_t attrsIdxs3[numAttrs + 1] = {0, 3, 1};
    error = rtsMemcpyBatchAsync((void **)dsts, destMaxs, (void **)srcs, sizes, count, attrs, attrsIdxs3, numAttrs + 1, &failIdx, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    for (size_t i = 0; i < count; i++) {
        delete [] dsts[i];
        delete [] srcs[i];
    }
}

TEST_F(StreamTest910B, memcpy_batch_param_err0)
{
    constexpr size_t count = 4U;
    constexpr size_t len = 128U;
    char *dsts[count];
    char *srcs[count];
    size_t sizes[count];
    for (size_t i = 0; i < count; i++) {
        dsts[i] = new (std::nothrow) char[len];
        srcs[i] = new (std::nothrow) char[len];
        memset(srcs[i], 'a + i', len);
        sizes[i] = i + 1;
    }

    constexpr size_t numAttrs = 2U;
    rtMemcpyBatchAttr attrs[numAttrs];
    size_t attrsIdxs[numAttrs] = {0, 3};
    for (size_t i = 0; i < numAttrs; i++) {
        attrs[i].srcLoc.id = 0U;
        attrs[i].srcLoc.type = RT_MEMORY_LOC_HOST;
        attrs[i].dstLoc.id = 0U;
        attrs[i].dstLoc.type = RT_MEMORY_LOC_DEVICE;
    }

    size_t failIdx;
    rtError_t error;
    error = rtsMemcpyBatch(nullptr, (void **)srcs, sizes, count, attrs, attrsIdxs, numAttrs, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatch((void **)dsts, nullptr, sizes, count, attrs, attrsIdxs, numAttrs, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatch((void **)dsts, (void **)srcs, nullptr, count, attrs, attrsIdxs, numAttrs, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatch((void **)dsts, (void **)srcs, sizes, 0U, attrs, attrsIdxs, numAttrs, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatch((void **)dsts, (void **)srcs, sizes, count, nullptr, attrsIdxs, numAttrs, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatch((void **)dsts, (void **)srcs, sizes, count, attrs, nullptr, numAttrs, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatch((void **)dsts, (void **)srcs, sizes, count, attrs, attrsIdxs, 0U, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);
    error = rtsMemcpyBatch((void **)dsts, (void **)srcs, sizes, count, attrs, attrsIdxs, numAttrs, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    for (size_t i = 0; i < count; i++) {
        delete [] dsts[i];
        delete [] srcs[i];
    }
}

TEST_F(StreamTest910B, memcpy_batch_param_err1)
{
    constexpr size_t count = 4U;
    constexpr size_t len = 128U;
    char *dsts[count];
    char *srcs[count];
    size_t sizes[count];
    for (size_t i = 0; i < count; i++) {
        dsts[i] = new (std::nothrow) char[len];
        srcs[i] = new (std::nothrow) char[len];
        memset(srcs[i], 'a + i', len);
        sizes[i] = i + 1;
    }

    constexpr size_t numAttrs = 2U;
    rtMemcpyBatchAttr attrs[numAttrs];
    size_t attrsIdxs[numAttrs] = {0, 3};
    for (size_t i = 0; i < numAttrs; i++) {
        attrs[i].srcLoc.id = 0U;
        attrs[i].srcLoc.type = RT_MEMORY_LOC_HOST;
        attrs[i].dstLoc.id = 0U;
        attrs[i].dstLoc.type = RT_MEMORY_LOC_DEVICE;
    }

    constexpr size_t numAttrs0 = count + 1;
    rtMemcpyBatchAttr attrs0[numAttrs0];
    size_t attrsIdxs0[numAttrs0] = {0, 2, 4, 5};
    for (size_t i = 0; i < numAttrs0; i++) {
        attrs0[i].srcLoc.id = 0U;
        attrs0[i].srcLoc.type = RT_MEMORY_LOC_HOST;
        attrs0[i].dstLoc.id = 0U;
        attrs0[i].dstLoc.type = RT_MEMORY_LOC_DEVICE;
    }

    size_t failIdx;
    rtError_t error;
    error = rtsMemcpyBatch((void **)dsts, (void **)srcs, sizes, count, attrs0, attrsIdxs0, numAttrs0, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);

    size_t attrsIdxs1[numAttrs] = {1, 3};
    error = rtsMemcpyBatch((void **)dsts, (void **)srcs, sizes, count, attrs, attrsIdxs1, numAttrs, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);

    size_t attrsIdxs2[numAttrs + 1] = {0, 3, 5};
    error = rtsMemcpyBatch((void **)dsts, (void **)srcs, sizes, count, attrs, attrsIdxs2, numAttrs + 1, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);

    size_t attrsIdxs3[numAttrs + 1] = {0, 3, 1};
    error = rtsMemcpyBatch((void **)dsts, (void **)srcs, sizes, count, attrs, attrsIdxs3, numAttrs + 1, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);

    for (size_t i = 0; i < count; i++) {
        delete [] dsts[i];
        delete [] srcs[i];
    }
}

TEST_F(StreamTest910B, memcpy_batch_count_err)
{
    constexpr size_t count = static_cast<size_t>(DEVMM_MEMCPY_BATCH_MAX_COUNT) + 1U;
    constexpr size_t len = 128U;
    char *dsts[count];
    char *srcs[count];
    size_t sizes[count];
    for (size_t i = 0; i < count; i++) {
        dsts[i] = new (std::nothrow) char[len];
        srcs[i] = new (std::nothrow) char[len];
        memset(srcs[i], 'a + i', len);
        sizes[i] = (i + 1U) % len;
    }

    constexpr size_t numAttrs = 2U;
    rtMemcpyBatchAttr attrs[numAttrs];
    size_t attrsIdxs[numAttrs] = {0, 3};
    for (size_t i = 0; i < numAttrs; i++) {
        attrs[i].srcLoc.id = 0U;
        attrs[i].srcLoc.type = RT_MEMORY_LOC_HOST;
        attrs[i].dstLoc.id = 0U;
        attrs[i].dstLoc.type = RT_MEMORY_LOC_DEVICE;
    }

    size_t failIdx;
    rtError_t error;
    error = rtsMemcpyBatch((void **)dsts, (void **)srcs, sizes, count, attrs, attrsIdxs, numAttrs, &failIdx);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(failIdx, SIZE_MAX);

    for (size_t i = 0; i < count; i++) {
        delete [] dsts[i];
        delete [] srcs[i];
    }
}
