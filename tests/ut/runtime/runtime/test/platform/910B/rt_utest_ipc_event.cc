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
#include "runtime/rt.h"
#include "runtime/event.h"
#define private public
#define protected public
#include "event.hpp"
#include "stars_engine.hpp"
#include "raw_device.hpp"
#include "engine.hpp"
#include "task_info.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "npu_driver.hpp"
#include "ipc_event.hpp"
#undef protected
#undef private
#include "stream_sqcq_manage.hpp"
#include "thread_local_container.hpp"
#include "api_impl.hpp"
#include "memory_task.h"
using namespace testing;
using namespace cce::runtime;

class IpcEventTest910B : public testing::Test {
public:
    Device *device_ = nullptr;
    rtChipType_t oldChipType;
protected:
    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }

    virtual void SetUp()
    {
        (void)rtSetSocVersion("Ascend910B1");
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        ((Runtime *)Runtime::Instance())->SetDisableThread(true);
        (void)rtSetDevice(0);
        device_ = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    }

    virtual void TearDown()
    {
        RawDevice *rd = (RawDevice *)device_;
        while (rd->IsNeedFreeEventId()) {rd->PopNextPoolFreeEventId();}
        rtDeviceReset(0);
        ((Runtime *)Runtime::Instance())->SetDisableThread(false);
        (void)rtSetSocVersion("");
        GlobalMockObject::verify();
    }
};

drvError_t halMemExportToShareableHandleStub(drv_mem_handle_t *handle, drv_mem_handle_type handle_type,
    uint64_t flags, uint64_t *shareable_handle)
{
    *shareable_handle = 1;
    return DRV_ERROR_NONE;
}

IpcHandleVa eventAddr = {1, RtValueToPtr<void*>(1), 0, 0};
drvError_t halMemAddressReserveStub(void **ptr, size_t size, size_t alignment, void *addr, uint64_t flag)
{
    *ptr = &eventAddr;
    return DRV_ERROR_NONE;
}

drvError_t halMemAddressReserveStub1(void **ptr, size_t size, size_t alignment, void *addr, uint64_t flag)
{
    return DRV_ERROR_NOT_SUPPORT;
}

int tmp[6] = {1, 2, 3, 4, 5, 6};
drvError_t halMemCreateStub(drv_mem_handle_t **handle, size_t size, const struct drv_mem_prop *prop, uint64_t flag)
{
    *handle = reinterpret_cast<drv_mem_handle_t*>(&tmp);
    return DRV_ERROR_NONE;
}

drvError_t halMemCreateStub1(drv_mem_handle_t **handle, size_t size, const struct drv_mem_prop *prop, uint64_t flag)
{
    return DRV_ERROR_NOT_SUPPORT;
}

void IpcVaLockStub()
{
}

void IpcVaUnLockStub()
{
}

void IpcVaLockInitStub()
{
}

uint16_t* GetCurrentHostMemStub()
{
    uint16_t value = 0U;
    uint16_t* ptr = &value;
    return ptr;
}

TEST_F(IpcEventTest910B, ipcEventCreate)
{
    rtError_t error;
    rtEvent_t event;
    rtIpcEventHandle_t handle;
    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    MOCKER(halMemExportToShareableHandle).stubs().will(invoke(halMemExportToShareableHandleStub));
    MOCKER(halMemAddressReserve).stubs().will(invoke(halMemAddressReserveStub1));
    error = rtEventCreateExWithFlag(&event, RT_EVENT_IPC);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtIpcGetEventHandle(event, &handle);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(IpcEventTest910B, ipcEventCreate1)
{
    rtError_t error;
    rtEvent_t event;
    rtIpcEventHandle_t handle;
    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    MOCKER(halMemExportToShareableHandle).stubs().will(invoke(halMemExportToShareableHandleStub));
    MOCKER(halMemAddressReserve).stubs().will(invoke(halMemAddressReserveStub));
    MOCKER(halMemCreate).stubs().will(invoke(halMemCreateStub));
    MOCKER_CPP(&IpcEvent::IpcVaLockInit).stubs().will(invoke(IpcVaLockInitStub));
    error = rtEventCreateExWithFlag(&event, RT_EVENT_IPC);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtIpcGetEventHandle(event, &handle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(IpcEventTest910B, ipcEventCreate2)
{
    rtError_t error;
    rtEvent_t event;
    rtIpcEventHandle_t handle;
    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    MOCKER(halMemExportToShareableHandle).stubs().will(invoke(halMemExportToShareableHandleStub));
    MOCKER(halMemCreate).stubs().will(invoke(halMemCreateStub1));
    error = rtEventCreateExWithFlag(&event, RT_EVENT_IPC);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtIpcGetEventHandle(event, &handle);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(IpcEventTest910B, query)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    rtEventStatus_t status;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventCreateWithFlag(&event, RT_EVENT_WITH_FLAG);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventQueryStatus(event, &status);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(status, RT_EVENT_INIT);


    error = rtEventRecord(event, stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventQuery(event);
    if (error == RT_ERROR_EVENT_NOT_COMPLETE) {
        EXPECT_EQ(error, RT_ERROR_NONE);
    }

    error = rtStreamSynchronize(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventQueryStatus(event, &status);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(status, RT_EVENT_RECORDED);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(IpcEventTest910B, ipcEventBase)
{
    rtError_t error;
    rtEvent_t event;
    rtIpcEventHandle_t handle;
    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    MOCKER(halMemExportToShareableHandle).stubs().will(invoke(halMemExportToShareableHandleStub));
    MOCKER(halMemAddressReserve).stubs().will(invoke(halMemAddressReserveStub));
    MOCKER_CPP(&IpcEvent::IpcVaLockInit).stubs().will(invoke(IpcVaLockInitStub));
    error = rtEventCreateExWithFlag(&event, RT_EVENT_IPC);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtIpcGetEventHandle(event, &handle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventDestroySync(event);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(IpcEventTest910B, ipcEventBase1)
{
    rtError_t error;
    rtEvent_t event;
    rtEvent_t event1;
    rtIpcEventHandle_t handle;
    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    MOCKER(halMemExportToShareableHandle).stubs().will(invoke(halMemExportToShareableHandleStub));
    MOCKER(halMemAddressReserve).stubs().will(invoke(halMemAddressReserveStub));
    MOCKER_CPP(&IpcEvent::IpcVaLockInit).stubs().will(invoke(IpcVaLockInitStub));
    error = rtEventCreateExWithFlag(&event, RT_EVENT_IPC);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtIpcGetEventHandle(event, &handle);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtIpcOpenEventHandle(handle, &event1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventDestroy(event1);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(IpcEventTest910B, ipcEventBase2)
{
    rtError_t error;
    rtEvent_t event;
    MOCKER_CPP(&DevInfoManage::IsSupportChipFeature).stubs().will(returnValue(false));
    error = rtEventCreateExWithFlag(&event, RT_EVENT_IPC);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}


TEST_F(IpcEventTest910B, ipcEventBase3)
{
    rtError_t error;
    rtEvent_t event;
    rtEvent_t event1;
    rtIpcEventHandle_t handle;
    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    MOCKER(halMemExportToShareableHandle).stubs().will(invoke(halMemExportToShareableHandleStub));
    MOCKER(halMemAddressReserve).stubs().will(invoke(halMemAddressReserveStub));
    MOCKER_CPP(&IpcEvent::IpcVaLockInit).stubs().will(invoke(IpcVaLockInitStub));
    error = rtEventCreateExWithFlag(&event, RT_EVENT_IPC);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    MOCKER_CPP(&DevInfoManage::IsSupportChipFeature).stubs().will(returnValue(false));
    error = rtIpcGetEventHandle(event, &handle);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtIpcOpenEventHandle(handle, &event1);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(IpcEventTest910B, ipcEventBase4)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    rtEventStatus_t status;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    MOCKER(halMemExportToShareableHandle).stubs().will(invoke(halMemExportToShareableHandleStub));
    MOCKER(halMemAddressReserve).stubs().will(invoke(halMemAddressReserveStub));
    MOCKER_CPP(&IpcEvent::IpcVaLock).stubs().will(invoke(IpcVaLockStub));
    MOCKER_CPP(&IpcEvent::IpcVaUnLock).stubs().will(invoke(IpcVaUnLockStub));
    MOCKER_CPP(&IpcEvent::IpcVaLockInit).stubs().will(invoke(IpcVaLockInitStub));
    error = rtEventCreateExWithFlag(&event, RT_EVENT_IPC);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventQueryStatus(event, &status);
    if (status == RT_EVENT_RECORDED) {
        EXPECT_EQ(status, RT_EVENT_RECORDED);
    } else {
        EXPECT_EQ(status, RT_EVENT_INIT);
    }
    error = rtEventSynchronize(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(IpcEventTest910B, ipcEventRecordTest)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    rtEventStatus_t status;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    MOCKER(halMemExportToShareableHandle).stubs().will(invoke(halMemExportToShareableHandleStub));
    MOCKER(halMemAddressReserve).stubs().will(invoke(halMemAddressReserveStub));
    MOCKER_CPP(&IpcEvent::IpcVaLock).stubs().will(invoke(IpcVaLockStub));
    MOCKER_CPP(&IpcEvent::IpcVaUnLock).stubs().will(invoke(IpcVaUnLockStub));
    MOCKER_CPP(&IpcEvent::IpcVaLockInit).stubs().will(invoke(IpcVaLockInitStub));
    error = rtEventCreateExWithFlag(&event, RT_EVENT_IPC);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventRecord(event, stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventQueryStatus(event, &status);
    if (status == RT_EVENT_RECORDED) {
        EXPECT_EQ(status, RT_EVENT_RECORDED);
    } else {
        EXPECT_EQ(status, RT_EVENT_INIT);
    }
    error = rtEventSynchronize(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(IpcEventTest910B, ipcEventRecordTest2)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    MOCKER(halMemExportToShareableHandle).stubs().will(invoke(halMemExportToShareableHandleStub));
    MOCKER(halMemAddressReserve).stubs().will(invoke(halMemAddressReserveStub));
    MOCKER(MemWriteValueTaskInit).stubs().will(returnValue(RT_ERROR_STREAM_CONTEXT));
    MOCKER_CPP(&IpcEvent::IpcVaLock).stubs().will(invoke(IpcVaLockStub));
    MOCKER_CPP(&IpcEvent::IpcVaUnLock).stubs().will(invoke(IpcVaUnLockStub));
    MOCKER_CPP(&IpcEvent::IpcVaLockInit).stubs().will(invoke(IpcVaLockInitStub));
    error = rtEventCreateExWithFlag(&event, RT_EVENT_IPC);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventRecord(event, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_CONTEXT);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(IpcEventTest910B, ipcEventRecordTest3)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    rtEventStatus_t status;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    MOCKER(halMemExportToShareableHandle).stubs().will(invoke(halMemExportToShareableHandleStub));
    MOCKER(halMemAddressReserve).stubs().will(invoke(halMemAddressReserveStub));
    MOCKER_CPP(&IpcEvent::GetCurrentHostMem).stubs().will(invoke(GetCurrentHostMemStub));
    MOCKER_CPP(&IpcEvent::IpcVaLock).stubs().will(invoke(IpcVaLockStub));
    MOCKER_CPP(&IpcEvent::IpcVaUnLock).stubs().will(invoke(IpcVaUnLockStub));
    MOCKER_CPP(&IpcEvent::IpcVaLockInit).stubs().will(invoke(IpcVaLockInitStub));
    error = rtEventCreateExWithFlag(&event, RT_EVENT_IPC);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventRecord(event, stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventQueryStatus(event, &status);
    if (status == RT_EVENT_RECORDED) {
        EXPECT_EQ(status, RT_EVENT_RECORDED);
    } else {
        EXPECT_EQ(status, RT_EVENT_INIT);
    }
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(IpcEventTest910B, ipcEventWaitTest)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    MOCKER(halMemExportToShareableHandle).stubs().will(invoke(halMemExportToShareableHandleStub));
    MOCKER(halMemAddressReserve).stubs().will(invoke(halMemAddressReserveStub));
    MOCKER_CPP(&IpcEvent::IpcVaLock).stubs().will(invoke(IpcVaLockStub));
    MOCKER_CPP(&IpcEvent::IpcVaUnLock).stubs().will(invoke(IpcVaUnLockStub));
    MOCKER_CPP(&IpcEvent::IpcVaLockInit).stubs().will(invoke(IpcVaLockInitStub));
    error = rtEventCreateExWithFlag(&event, RT_EVENT_IPC);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventRecord(event, stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtStreamWaitEvent(stream, event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(IpcEventTest910B, ipcEventWaitTest1)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    rtEventStatus_t status;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    MOCKER(halMemExportToShareableHandle).stubs().will(invoke(halMemExportToShareableHandleStub));
    MOCKER(halMemAddressReserve).stubs().will(invoke(halMemAddressReserveStub));
    MOCKER_CPP(&IpcEvent::IpcVaLock).stubs().will(invoke(IpcVaLockStub));
    MOCKER_CPP(&IpcEvent::IpcVaUnLock).stubs().will(invoke(IpcVaUnLockStub));
    MOCKER_CPP(&IpcEvent::IpcVaLockInit).stubs().will(invoke(IpcVaLockInitStub));
    error = rtEventCreateExWithFlag(&event, RT_EVENT_IPC);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtStreamWaitEvent(stream, event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventQueryStatus(event, &status);
    if (status == RT_EVENT_RECORDED) {
        EXPECT_EQ(status, RT_EVENT_RECORDED);
    } else {
        EXPECT_EQ(status, RT_EVENT_INIT);
    }
    error = rtEventSynchronize(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(IpcEventTest910B, ipcEventWaitTest2)
{
    rtError_t error;
    rtEvent_t event;
    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    MOCKER(halMemExportToShareableHandle).stubs().will(invoke(halMemExportToShareableHandleStub));
    MOCKER(halMemAddressReserve).stubs().will(invoke(halMemAddressReserveStub));
    MOCKER(MemWaitValueTaskInit).stubs().will(returnValue(RT_ERROR_STREAM_CONTEXT));
    MOCKER_CPP(&IpcEvent::IpcVaLock).stubs().will(invoke(IpcVaLockStub));
    MOCKER_CPP(&IpcEvent::IpcVaUnLock).stubs().will(invoke(IpcVaUnLockStub));
    MOCKER_CPP(&IpcEvent::IpcVaLockInit).stubs().will(invoke(IpcVaLockInitStub));
    error = rtEventCreateExWithFlag(&event, RT_EVENT_IPC);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventRecord(event, stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtStreamWaitEvent(stream, event);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_CONTEXT);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}