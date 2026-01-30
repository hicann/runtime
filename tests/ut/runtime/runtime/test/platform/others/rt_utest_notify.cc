/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mockcpp/mockcpp.hpp"
#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include "gtest/gtest.h"
#define private public
#define protected public
#include "notify.hpp"
#include "raw_device.hpp"
#include "engine.hpp"
#include "scheduler.hpp"
#include "task_info.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "npu_driver.hpp"
#include "thread_local_container.hpp"
#undef protected
#undef private

using namespace testing;
using namespace cce::runtime;

class NotifyTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"notify test start"<<std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout<<"notify test start end"<<std::endl;
    }

    virtual void SetUp()
    {
        (void)rtSetSocVersion("Ascend910");
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
        rtSetDevice(0);
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        rtDeviceReset(0);
        (void)rtSetSocVersion("");
    }
};

drvError_t halShrIdOpen_stub(const char *name, struct drvShrIdInfo *info)
{
    info->devid = 0;
    info->shrid = 1;
    info->id_type = SHR_ID_NOTIFY_TYPE;
    return DRV_ERROR_NONE;
}

drvError_t halShrIdOpen_stub_pod(const char *name, struct drvShrIdInfo *info)
{
    info->devid = 0;
    info->shrid = 1;
    info->id_type = SHR_ID_NOTIFY_TYPE;
    info->flag |= TSDRV_FLAG_SHR_ID_SHADOW;
    return DRV_ERROR_NONE;
}

drvError_t halParseSDID_parse_stub(uint32_t sdid, struct halSDIDParseInfo *sdid_parse)
{
    sdid_parse->server_id = 0;
    sdid_parse->chip_id = 0;
    sdid_parse->die_id = 0;
    sdid_parse->udevid = 0;
    return DRV_ERROR_NONE;
}

drvError_t testResourceIdAlloc(uint32_t devId, struct halResourceIdInputInfo *in, struct halResourceIdOutputInfo *out)
{
    out->resourceId = 0;
    return DRV_ERROR_NONE;
}

drvError_t testRevisedNotifyIdAlloc(uint32_t devId, struct halResourceIdInputInfo *in, struct halResourceIdOutputInfo *out)
{
    out->resourceId = 32769;
    return DRV_ERROR_NONE;
}

drvError_t testResourceIdAlloc_error_stub(uint32_t devId, struct halResourceIdInputInfo *in, struct halResourceIdOutputInfo *out)
{
    out->resourceId = -1;
    return DRV_ERROR_NO_DEVICE;
}


drvError_t drvDeviceGetPhyIdByIndex_err_stub(uint32_t devIndex, uint32_t *phyId)
{
    return DRV_ERROR_NO_DEVICE;
}
drvError_t drvDeviceGetIndexByPhyId_err_stub(uint32_t phyId, uint32_t *devIndex)
{
    return DRV_ERROR_NO_DEVICE;
}

rtError_t NotifyRecordTask_Init(Stream * stream, uint16_t notifyid, uint16_t deviceid)
{
    return RT_ERROR_INVALID_VALUE;
}

TEST_F(NotifyTest, notify_record)
{
    rtError_t error;
    int32_t device_id = 0;
    uint32_t tsId = 0;

    MOCKER(halResourceIdAlloc)
             .stubs()
             .will(invoke(testResourceIdAlloc));
    RefObject<Context*> *refObject = NULL;
    refObject = (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(0);
    Context *ctx = refObject->GetVal();
    EXPECT_NE(ctx, (Context*)NULL);



    Notify *notify = new Notify(device_id, tsId);
    notify->Setup();
    EXPECT_EQ(notify->GetNotifyId(), 0);

    error = notify ->SetName("test");
    EXPECT_EQ(error, RT_ERROR_NONE);


    error = notify->Record((Stream *)ctx->DefaultStream_());
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = notify->Wait((Stream *)ctx->DefaultStream_(), 600);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete notify;

    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(0);
}

TEST_F(NotifyTest, revised_notify_record)
{
    rtError_t error;
    int32_t device_id = 0;
    uint32_t tsId = 0;

    MOCKER(halResourceIdAlloc)
             .stubs()
	     .will(invoke(testRevisedNotifyIdAlloc));

    RefObject<Context*> *refObject = NULL;
    refObject = (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(0);
    Context *ctx = refObject->GetVal();
    EXPECT_NE(ctx, (Context*)NULL);

    NpuDriver *driver = (NpuDriver *)((Device *)ctx->Device_())->Driver_();
    driver->chipType_ = CHIP_CLOUD;
    Notify *notify = new Notify(device_id, tsId);
    notify->Setup();
    EXPECT_EQ(notify->GetNotifyId(), 32769);

    error = notify->SetName("test");
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = notify->Record((Stream *)ctx->DefaultStream_());
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = notify->Wait((Stream *)ctx->DefaultStream_(), 600);

    delete notify;

    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(0);
    driver->chipType_ = CHIP_CLOUD;
}

TEST_F(NotifyTest, notify_create_error)
{
    rtError_t error;
    int32_t device_id = 0;
    uint32_t tsId = 0;

    MOCKER(halResourceIdAlloc)
             .stubs()
             .will(invoke(testResourceIdAlloc_error_stub));

    Notify *notify = new Notify(device_id, tsId);
    error = notify->Setup();
    EXPECT_EQ(error, RT_ERROR_DRV_NO_DEVICE);

    delete notify;
}
TEST_F(NotifyTest, notify_create_error02)
{
    rtError_t error;
    int32_t device_id = 0;
    uint32_t tsId = 0;
    uint32_t len = 32;

    MOCKER(drvDeviceGetPhyIdByIndex)
             .stubs()
             .will(invoke(drvDeviceGetPhyIdByIndex_err_stub));
    MOCKER(drvDeviceGetIndexByPhyId)
             .stubs()
             .will(invoke(drvDeviceGetIndexByPhyId_err_stub));
    Notify *notify = new Notify(device_id, tsId);
    error = notify->Setup();
    EXPECT_NE(error, RT_ERROR_NONE);
    error = notify->CreateIpcNotify("test_notify", len);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete notify;
}

TEST_F(NotifyTest, notify_getaddroffset)
{
    rtError_t error;
    int32_t device_id = 0;
    uint32_t tsId = 0;
    uint64_t devAddrOffset = 0;

    Notify *notify = new Notify(device_id, tsId);
    error = notify->Setup();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = notify ->GetAddrOffset(&devAddrOffset);

    delete notify;
}

TEST_F(NotifyTest, notify_getaddroffset_error)
{
    rtError_t error;
    int32_t device_id = 0;
    uint32_t tsId = 0;
    uint64_t devAddrOffset = 0;

    Notify *notify = new Notify(device_id, tsId);
    error = notify->Setup();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = notify ->GetAddrOffset(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete notify;
}

TEST_F(NotifyTest, notify_getaddroffset_error2)
{

    rtError_t error;
    int32_t device_id = 0;
    uint32_t tsId = 0;
    uint64_t devAddrOffset = 0;

    Notify *notify = new Notify(device_id, tsId);
    error = notify->Setup();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = notify ->GetAddrOffset(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete notify;
}
TEST_F(NotifyTest, notify_getaddroffset_error3)
{
    rtError_t error;
    int32_t device_id = 0;
    uint32_t tsId = 0;
    uint64_t devAddrOffset = 0;
    MOCKER(drvDeviceGetIndexByPhyId)
             .stubs()
             .will(invoke(drvDeviceGetIndexByPhyId_err_stub));
    Notify *notify = new Notify(device_id, tsId);
    error = notify->Setup();
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = notify ->GetAddrOffset(&devAddrOffset);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete notify;
}

TEST_F(NotifyTest, notify_record_taskinit_error)
{
    MOCKER(NotifyRecordTaskInit).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    MOCKER(NotifyWaitTaskInit).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    rtError_t error;
    int32_t device_id = 0;
    uint32_t tsId = 0;

    Notify *notify = new Notify(device_id, tsId);
    notify->Setup();
    RefObject<Context*> *refObject = NULL;
    refObject = (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(0);
    Context *ctx = refObject->GetVal();
    EXPECT_NE(ctx, (Context*)NULL);

    error = notify->Record((Stream *)ctx->DefaultStream_());
    EXPECT_NE(error, RT_ERROR_NONE);

    error = notify->Wait((Stream *)ctx->DefaultStream_(), 600);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete notify;
    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(0);
}

TEST_F(NotifyTest, notify_record_tasksubmit_error)
{
    RawDevice* device= (RawDevice*)((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);

    MOCKER_CPP_VIRTUAL(device->engine_, &Engine::SubmitTaskNormal).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    rtError_t error;
    int32_t device_id = 0;
    uint32_t tsId = 0;

    Notify *notify = new Notify(device_id, tsId);
    notify->Setup();
    RefObject<Context*> *refObject = NULL;
    refObject = (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(0);
    Context *ctx = refObject->GetVal();
    EXPECT_NE(ctx, (Context*)NULL);

    error = notify->Record((Stream *)ctx->DefaultStream_());
    EXPECT_NE(error, RT_ERROR_NONE);

    error = notify->Wait((Stream *)ctx->DefaultStream_(), 600);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete notify;
    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(0);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(NotifyTest, notify_ipc_create)
{
    rtError_t error;
    int32_t device_id = 0;
    int32_t tsId = 0;
    uint32_t len = 32;

    Notify *notify = new Notify(device_id, tsId);
    notify->Setup();

    error = notify->CreateIpcNotify("test_ipc", len);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete notify;
}

TEST_F(NotifyTest, notify_ipc_multi_create)
{
    rtError_t error;
    int32_t device_id = 0;
    uint32_t tsId = 0;
    uint32_t len = 32;

    Notify *notify = new Notify(device_id, tsId);
    notify->Setup();

    error = notify->CreateIpcNotify("test_ipc", len);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = notify->CreateIpcNotify("test_ipc", len);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete notify;
}

TEST_F(NotifyTest, notify_ipc_open)
{

    MOCKER(halShrIdOpen)
             .stubs()
             .will(invoke(halShrIdOpen_stub));
    rtError_t error;
    Notify *notify = new Notify(0, 0);
    error = notify->OpenIpcNotify("test_ipc", RT_NOTIFY_FLAG_DEFAULT);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(notify->GetNotifyId(), 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete notify;
}

TEST_F(NotifyTest, notify_ipc_pod_open)
{

    MOCKER(halShrIdOpen)
             .stubs()
             .will(invoke(halShrIdOpen_stub));
    rtError_t error;
    Notify *notify = new Notify(0, 0);

    MOCKER(halShrIdOpen)
             .stubs()
             .will(invoke(halShrIdOpen_stub_pod));
    error = notify->OpenIpcNotify("test_ipc", RT_NOTIFY_FLAG_SHR_ID_SHADOW);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete notify;
}

TEST_F(NotifyTest, notify_ipc_shadow_open)
{
    MOCKER(halShrIdOpen)
        .stubs()
        .will(invoke(halShrIdOpen_stub_pod));
    MOCKER(halParseSDID)
        .stubs()
        .will(invoke(halParseSDID_parse_stub));

    rtError_t error;
    Notify *notify = new Notify(0, 0);
    error = notify->OpenIpcNotify("test_ipc", RT_NOTIFY_FLAG_SHR_ID_SHADOW);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete notify;
}

TEST_F(NotifyTest, notify_ipc_multi_open)
{
    MOCKER(halShrIdOpen)
             .stubs()
             .will(invoke(halShrIdOpen_stub));
    rtError_t error;
    Notify *notify = new Notify(0, 0);

    error = notify->OpenIpcNotify("test_ipc", RT_NOTIFY_FLAG_DEFAULT);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(notify->GetNotifyId(), 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = notify->OpenIpcNotify("test_ipc", RT_NOTIFY_FLAG_DEFAULT);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete notify;
}

TEST_F(NotifyTest, notify_dtor_null)
{
    Notify *notify = new Notify(0, 0);
    EXPECT_NE(notify, nullptr);

    delete notify;
}

TEST_F(NotifyTest, notify_setname_fail)
{
    MOCKER(drvCreateIpcNotify)
             .stubs()
             .will(returnValue(DRV_ERROR_NO_DEVICE));

    rtError_t error;
    int32_t device_id = 0;
    uint32_t tsId = 0;
    uint32_t len = 32;

    Notify *notify = new Notify(device_id, tsId);
    notify->Setup();

    error = notify->CreateIpcNotify("test_ipc", len);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete notify;
}

TEST_F(NotifyTest, CheckIpcNotifyDevId)
{
    rtError_t error;
    uint32_t device_id = UINT32_MAX;
    uint32_t tsId = 0;
    Notify notify(device_id, tsId);
    notify.isIpcNotify_ = true;
    EXPECT_NE(notify.CheckIpcNotifyDevId(), RT_ERROR_NONE);
}
