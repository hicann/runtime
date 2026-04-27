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
#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include "runtime/event.h"
#define private public
#define protected public
#include "event.hpp"
#include "raw_device.hpp"
#include "scheduler.hpp"
#include "task_info.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "memory_task.h"
#include "npu_driver.hpp"
#include "ipc_event.hpp"
#undef protected
#undef private
#include "stream_sqcq_manage.hpp"
#include "thread_local_container.hpp"
#include "memory_task.h"
#include "common/internal_error_define.hpp"
#include "stars_david.hpp"
#include "rt_unwrap.h"

using namespace testing;
using namespace cce::runtime;

static TaskInfo g_mockTask;
static bool g_allocTaskSuccess = true;
static rtError_t g_allocTaskError = RT_ERROR_NONE;
static rtError_t g_davidSendTaskRet = RT_ERROR_NONE;
static rtError_t g_submitPostProcRet = RT_ERROR_NONE;
static rtError_t g_checkTaskCanSendRet = RT_ERROR_NONE;
static rtError_t g_getIpcRecordIndexRet = RT_ERROR_NONE;
static rtError_t g_memWriteValueInitRet = RT_ERROR_NONE;
static rtError_t g_memWaitValueInitRet = RT_ERROR_NONE;
static uint16_t g_mockCurIndex = 0;

rtError_t AllocTaskInfoMock(TaskInfo** tsk, Stream* stm, uint32_t& pos) {
    if (g_allocTaskSuccess) {
        *tsk = &g_mockTask;
        return RT_ERROR_NONE;
    }
    return g_allocTaskError;
}

void ResetIpcEventStarsV2Mocks() {
    g_allocTaskSuccess = true;
    g_allocTaskError = RT_ERROR_NONE;
    g_davidSendTaskRet = RT_ERROR_NONE;
    g_submitPostProcRet = RT_ERROR_NONE;
    g_checkTaskCanSendRet = RT_ERROR_NONE;
    g_getIpcRecordIndexRet = RT_ERROR_NONE;
    g_memWriteValueInitRet = RT_ERROR_NONE;
    g_memWaitValueInitRet = RT_ERROR_NONE;
    g_mockCurIndex = 0;
}

rtError_t MockGetIpcRecordIndex(IpcEvent* self, uint16_t* curIndex) {
    *curIndex = g_mockCurIndex;
    return RT_ERROR_NONE;
}

drvError_t halMemExportToShareableHandleStub(drv_mem_handle_t *handle, drv_mem_handle_type handle_type,
    uint64_t flags, uint64_t *shareable_handle) {
    *shareable_handle = 1;
    return DRV_ERROR_NONE;
}

drvError_t halMemAddressReserveStub(void **ptr, size_t size, size_t alignment, void *addr, uint64_t flag) {
    static IpcHandleVa dummyVa = {0, nullptr, {0}, 0};
    *ptr = &dummyVa;
    return DRV_ERROR_NONE;
}

drvError_t halMemCreateStub(drv_mem_handle_t **handle, size_t size, const struct drv_mem_prop *prop, uint64_t flag) {
    static void* dummyHandle = reinterpret_cast<void*>(0x1);
    *handle = reinterpret_cast<drv_mem_handle_t*>(dummyHandle);
    return DRV_ERROR_NONE;
}

static int g_ipcEventDestroyCallCount = 0;
static IpcEvent** g_ipcEventDestroyEventPtr = nullptr;
static int32_t g_ipcEventDestroyTimeout = 0;
static bool g_ipcEventDestroyIsNeedDestroy = false;

void IpcEventDestroyMock(IpcEvent** event, int32_t timeout, bool isNeedDestroy) {
    g_ipcEventDestroyCallCount++;
    g_ipcEventDestroyEventPtr = event;
    g_ipcEventDestroyTimeout = timeout;
    g_ipcEventDestroyIsNeedDestroy = isNeedDestroy;
}

void ResetIpcEventDestroyMock() {
    g_ipcEventDestroyCallCount = 0;
    g_ipcEventDestroyEventPtr = nullptr;
    g_ipcEventDestroyTimeout = 0;
    g_ipcEventDestroyIsNeedDestroy = false;
}

static int g_devMemFreeCallCount = 0;
static void* g_devMemFreePtr = nullptr;
static int32_t g_devMemFreeDeviceId = 0;

rtError_t DevMemFreeMock(void* ptr, int32_t deviceId) {
    g_devMemFreeCallCount++;
    g_devMemFreePtr = ptr;
    g_devMemFreeDeviceId = deviceId;
    return RT_ERROR_NONE;
}

void ResetDevMemFreeMock() {
    g_devMemFreeCallCount = 0;
    g_devMemFreePtr = nullptr;
    g_devMemFreeDeviceId = 0;
}

void IpcVaLockStub() {}
void IpcVaUnLockStub() {}
void IpcVaLockInitStub() {}

class IpcEventStarsV2Test : public testing::Test {
public:
    Device *device_ = nullptr;
protected:
    static void SetUpTestCase() {}

    static void TearDownTestCase() {}

    virtual void SetUp() {
        (void)rtSetSocVersion("Ascend950PR_9599");
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        ((Runtime *)Runtime::Instance())->SetDisableThread(true);
        (void)rtSetDevice(0);
        device_ = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    }

    virtual void TearDown() {
        RawDevice *rd = (RawDevice *)device_;
        while (rd->IsNeedFreeEventId()) { rd->PopNextPoolFreeEventId(); }
        rtDeviceReset(0);
        ((Runtime *)Runtime::Instance())->SetDisableThread(false);
        (void)rtSetSocVersion("");
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        GlobalMockObject::verify();
    }
};

TEST_F(IpcEventStarsV2Test, RecordStarsV2_Success) {
    ResetIpcEventStarsV2Mocks();

    MOCKER(halMemExportToShareableHandle).stubs().will(invoke(halMemExportToShareableHandleStub));
    MOCKER(halMemAddressReserve).stubs().will(invoke(halMemAddressReserveStub));
    MOCKER(halMemCreate).stubs().will(invoke(halMemCreateStub));
    MOCKER_CPP(&IpcEvent::IpcVaLockInit).stubs().will(invoke(IpcVaLockInitStub));

    rtEvent_t event;
    rtStream_t stream;
    rtError_t error = rtStreamCreate(&stream, 0);
    ASSERT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventCreateExWithFlag(&event, RT_EVENT_IPC);
    ASSERT_EQ(error, ACL_RT_SUCCESS);

    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(AllocTaskInfo).stubs().will(invoke(AllocTaskInfoMock));
    MOCKER(DavidSendTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(SubmitTaskPostProc).stubs().will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP(&IpcEvent::GetIpcRecordIndex).stubs().will(invoke(MockGetIpcRecordIndex));
    MOCKER(MemWriteValueTaskInit).stubs().will(returnValue(RT_ERROR_NONE));

    IpcEvent* ipcEvent = static_cast<IpcEvent *>(rt_ut::UnwrapOrNull<Event>(event));
    error = ipcEvent->IpcEventRecordStarsV2(rt_ut::UnwrapOrNull<Stream>(stream));
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    rtStreamDestroy(stream);
    rtEventDestroy(event);
}

TEST_F(IpcEventStarsV2Test, WaitStarsV2_Success) {
    ResetIpcEventStarsV2Mocks();
    MOCKER(halMemExportToShareableHandle).stubs().will(invoke(halMemExportToShareableHandleStub));
    MOCKER(halMemAddressReserve).stubs().will(invoke(halMemAddressReserveStub));
    MOCKER(halMemCreate).stubs().will(invoke(halMemCreateStub));
    MOCKER_CPP(&IpcEvent::IpcVaLockInit).stubs().will(invoke(IpcVaLockInitStub));

    rtEvent_t event;
    rtStream_t stream;
    rtError_t error = rtStreamCreate(&stream, 0);
    ASSERT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventCreateExWithFlag(&event, RT_EVENT_IPC);
    ASSERT_EQ(error, ACL_RT_SUCCESS);

    IpcEvent* ipcEvent = static_cast<IpcEvent *>(rt_ut::UnwrapOrNull<Event>(event));
    IpcHandleVa* handleVa = ipcEvent->ipcHandleVa_;
    handleVa->currentIndex = 0;
    handleVa->deviceMemRef[0] = 1;

    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(AllocTaskInfo).stubs().will(invoke(AllocTaskInfoMock));
    MOCKER(DavidSendTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(SubmitTaskPostProc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(MemWaitValueTaskInit).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&IpcEvent::IpcVaLock).stubs().will(invoke(IpcVaLockStub));
    MOCKER_CPP(&IpcEvent::IpcVaUnLock).stubs().will(invoke(IpcVaUnLockStub));

    error = ipcEvent->IpcEventWaitStarsV2(rt_ut::UnwrapOrNull<Stream>(stream));
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    rtStreamDestroy(stream);
    rtEventDestroy(event);
}

TEST_F(IpcEventStarsV2Test, WaitStarsV2_AllocFail) {
    ResetIpcEventStarsV2Mocks();
    MOCKER(halMemExportToShareableHandle).stubs().will(invoke(halMemExportToShareableHandleStub));
    MOCKER(halMemAddressReserve).stubs().will(invoke(halMemAddressReserveStub));
    MOCKER(halMemCreate).stubs().will(invoke(halMemCreateStub));
    MOCKER_CPP(&IpcEvent::IpcVaLockInit).stubs().will(invoke(IpcVaLockInitStub));

    rtEvent_t event;
    rtStream_t stream;
    rtError_t error = rtStreamCreate(&stream, 0);
    ASSERT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventCreateExWithFlag(&event, RT_EVENT_IPC);
    ASSERT_EQ(error, ACL_RT_SUCCESS);

    IpcEvent* ipcEvent = static_cast<IpcEvent *>(rt_ut::UnwrapOrNull<Event>(event));
    IpcHandleVa* handleVa = ipcEvent->ipcHandleVa_;
    handleVa->currentIndex = 0;
    handleVa->deviceMemRef[0] = 1;

    MOCKER(CheckTaskCanSend).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(AllocTaskInfo).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    MOCKER(DavidSendTask).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(SubmitTaskPostProc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(MemWaitValueTaskInit).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&IpcEvent::IpcVaLock).stubs().will(invoke(IpcVaLockStub));
    MOCKER_CPP(&IpcEvent::IpcVaUnLock).stubs().will(invoke(IpcVaUnLockStub));

    error = ipcEvent->IpcEventWaitStarsV2(rt_ut::UnwrapOrNull<Stream>(stream));
    EXPECT_NE(error, ACL_RT_SUCCESS);

    rtStreamDestroy(stream);
    rtEventDestroy(event);
}

TEST_F(IpcEventStarsV2Test, WaitStarsV2_RefCountZero_EarlyReturn) {
    ResetIpcEventStarsV2Mocks();
    MOCKER(halMemExportToShareableHandle).stubs().will(invoke(halMemExportToShareableHandleStub));
    MOCKER(halMemAddressReserve).stubs().will(invoke(halMemAddressReserveStub));
    MOCKER(halMemCreate).stubs().will(invoke(halMemCreateStub));
    MOCKER_CPP(&IpcEvent::IpcVaLockInit).stubs().will(invoke(IpcVaLockInitStub));

    rtEvent_t event;
    rtStream_t stream;
    rtError_t error = rtStreamCreate(&stream, 0);
    ASSERT_EQ(error, ACL_RT_SUCCESS);
    error = rtEventCreateExWithFlag(&event, RT_EVENT_IPC);
    ASSERT_EQ(error, ACL_RT_SUCCESS);

    IpcEvent* ipcEvent = static_cast<IpcEvent *>(rt_ut::UnwrapOrNull<Event>(event));
    IpcHandleVa* handleVa = ipcEvent->ipcHandleVa_;
    handleVa->currentIndex = 0;
    handleVa->deviceMemRef[0] = 0;

    MOCKER_CPP(&IpcEvent::IpcVaLock).stubs().will(invoke(IpcVaLockStub));
    MOCKER_CPP(&IpcEvent::IpcVaUnLock).stubs().will(invoke(IpcVaUnLockStub));

    error = ipcEvent->IpcEventWaitStarsV2(rt_ut::UnwrapOrNull<Stream>(stream));
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    rtStreamDestroy(stream);
    rtEventDestroy(event);
}

TEST_F(IpcEventStarsV2Test, RecordTaskUnInit_NormalPath) {
    ResetIpcEventStarsV2Mocks();
    ResetIpcEventDestroyMock();

    MOCKER(halMemExportToShareableHandle).stubs().will(invoke(halMemExportToShareableHandleStub));
    MOCKER(halMemAddressReserve).stubs().will(invoke(halMemAddressReserveStub));
    MOCKER(halMemCreate).stubs().will(invoke(halMemCreateStub));
    MOCKER_CPP(&IpcEvent::IpcVaLockInit).stubs().will(invoke(IpcVaLockInitStub));
    MOCKER(IpcEventDestroy).stubs().will(invoke(IpcEventDestroyMock));

    rtEvent_t event;
    rtError_t error = rtEventCreateExWithFlag(&event, RT_EVENT_IPC);
    ASSERT_EQ(error, ACL_RT_SUCCESS);
    IpcEvent* ipcEvent = static_cast<IpcEvent *>(rt_ut::UnwrapOrNull<Event>(event));

    IpcHandleVa* handleVa = ipcEvent->ipcHandleVa_;
    uint16_t testIndex = 0;
    handleVa->currentIndex = testIndex;
    handleVa->deviceMemRef[testIndex] = 1;
    uint8_t testMem = 0xAA;
    ipcEvent->currentHostMem_ = &testMem;

    TaskInfo taskInfo;
    taskInfo.type = TS_TASK_TYPE_IPC_RECORD;
    taskInfo.u.memWriteValueTask.event = ipcEvent;
    taskInfo.u.memWriteValueTask.curIndex = testIndex;
    taskInfo.stream = reinterpret_cast<Stream*>(0x1234);

    StarsV2IpcEventRecordTaskUnInit(&taskInfo);

    EXPECT_EQ(g_ipcEventDestroyCallCount, 1);
    EXPECT_EQ(handleVa->deviceMemRef[testIndex], 0);
    EXPECT_EQ(testMem, 0);
    EXPECT_TRUE(ipcEvent->IsIpcFinished());

    rtEventDestroy(event);
}