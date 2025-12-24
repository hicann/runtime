/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <string>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "driver/ascend_hal.h"
#define private public
#define protected public
#include "raw_device.hpp"
#include "driver.hpp"
#include "npu_driver.hpp"
#undef protected
#undef private
#include "runtime/rt.h"
#include "securec.h"
#include "context.hpp"
#include "event.hpp"
#include "runtime.hpp"
#include "module.hpp"
#include "program.hpp"
#include "api_impl.hpp"
#include "api_error.hpp"
#include "profiler.hpp"
#include "api.hpp"
#include "logger.hpp"
#include "task_info.hpp"
#include "thread_local_container.hpp"
#include "device_msg_handler.hpp"

#include "ttlv.hpp"
#include "model.hpp"
#include "rt_utest_encap.h"
#include "dqs/task_dqs.hpp"
#include "ffts_task.h"
#include "memory_task.h"
#include "program.hpp"
#include "stream.hpp"
#include "../../rt_utest_api.hpp"
#include "cond_op_task.h"
#include "stream_task.h"
using namespace testing;
using namespace cce::runtime;

class CloudV2ApiImplSpecTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"ApiImplTestCloudV2 test start start. "<<std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout<<"ApiImplTestCloudV2 test start end. "<<std::endl;
    }

    virtual void SetUp()
    {
        driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL((NpuDriver*)(driver_), &NpuDriver::GetRunMode).stubs().will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

        (void)rtSetDevice(0);
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }
private:
    Driver *driver_;
};

drvError_t halShrIdOpen_notify_stub(const char *name, struct drvShrIdInfo *info)
{
    EXPECT_EQ(info->devid, 0);
    EXPECT_EQ(info->tsid, 0);
    info->devid = 1001;
    info->tsid = 0;
    info->id_type = SHR_ID_NOTIFY_TYPE;
    info->shrid = 1100;
    return DRV_ERROR_NONE;
}

drvError_t drvDeviceGetIndexByPhyId_stub1001(uint32_t phyId, uint32_t *devIndex)
{
    *devIndex = 0;
    return DRV_ERROR_NONE;
}

TEST_F(CloudV2ApiImplSpecTest, get_notify_phy_info)
{
    rtNotify_t notify = nullptr;
    ApiImpl apiImpl;
    rtError_t error;
    int32_t device_id = 0;
    uint32_t phyDevid = 0;
    uint32_t tsId = 0;
    uint32_t notify_id;
    MOCKER(halShrIdOpen).stubs().will(invoke(halShrIdOpen_notify_stub));
    MOCKER(drvDeviceGetIndexByPhyId).stubs().will(invoke(drvDeviceGetIndexByPhyId_stub1001));
    MOCKER(halGetChipFromDevice).stubs().will(returnValue(DRV_ERROR_NONE));

    error = apiImpl.IpcOpenNotify((Notify **)&notify, "notify", 1U);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_MC2_RTS_SUPPORT_HCCL);

    error = apiImpl.IpcOpenNotify((Notify **)&notify, "notify", 1U);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_TRUE(notify != nullptr);

    rtNotifyPhyInfo notifyInfo;
    error = apiImpl.GetNotifyPhyInfo((Notify *)notify, &notifyInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);
    phyDevid = notifyInfo.phyId;
    tsId = notifyInfo.tsId;
    EXPECT_EQ(tsId, 0);

    error = apiImpl.NotifyDestroy((Notify *)notify);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->SetTschVersion(version);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2ApiImplSpecTest, get_notify_phy_info_with_flag_two)
{
    rtNotify_t notify = nullptr;
    ApiImpl apiImpl;
    rtError_t error;
    int32_t device_id = 0;
    uint32_t phyDevid = 0;
    uint32_t tsId = 0;
    uint32_t notify_id;
    MOCKER(halShrIdOpen).stubs().will(invoke(halShrIdOpen_notify_stub));
    MOCKER(drvDeviceGetIndexByPhyId).stubs().will(invoke(drvDeviceGetIndexByPhyId_stub1001));
    MOCKER(halGetChipFromDevice).stubs().will(returnValue(DRV_ERROR_NONE));

    error = apiImpl.IpcOpenNotify((Notify **)&notify, "notify", 1U);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_MC2_RTS_SUPPORT_HCCL);

    error = apiImpl.IpcOpenNotify((Notify **)&notify, "notify", 2U);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_TRUE(notify != nullptr);

    rtNotifyPhyInfo notifyInfo;
    error = apiImpl.GetNotifyPhyInfo((Notify *)notify, &notifyInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);
    phyDevid = notifyInfo.phyId;
    tsId = notifyInfo.tsId;
    EXPECT_EQ(tsId, 0);

    error = apiImpl.NotifyDestroy((Notify *)notify);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->SetTschVersion(version);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2ApiImplSpecTest, stream_set_mode)
{
    rtNotify_t notify = nullptr;
    ApiImpl apiImpl;
    rtError_t error;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_SET_STREAM_MODE);
    Stream * stream = new Stream(device, 0);
    MOCKER_CPP(&Stream::SetFailMode)
        .stubs()
        .with(mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    stream->SetMode(CONTINUE_ON_FAILURE);
    stream->failureMode_ = ABORT_ON_FAILURE;
    error = apiImpl.StreamSetMode(stream, STOP_ON_FAILURE);
    EXPECT_EQ(error, RT_ERROR_STREAM_CONTEXT);

    device->SetTschVersion(version);
    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

drvError_t halShrIdOpen_event_stub(const char *name, struct drvShrIdInfo *info)
{
    EXPECT_EQ(info->devid, 0);
    EXPECT_EQ(info->tsid, 0);
    info->devid = 1001;
    info->tsid = 0;
    info->id_type = SHR_ID_EVENT_TYPE;
    info->shrid = 1100;
    return DRV_ERROR_NONE;
}

TEST_F(CloudV2ApiImplSpecTest, ModelTaskUpdateFail_001)
{
    rtError_t error;

    Device * device = new RawDevice(0);
    device->Init();
    MOCKER_CPP_VIRTUAL(device, &Device::CheckFeatureSupport)
    .stubs()
    .will(returnValue(true));

    Stream * desStm = new Stream(device, 0);
    Stream * sinkStm = new Stream(device, 0);
    uint32_t desTaskId = 1;
    rtMdlTaskUpdateInfo_t para;

    error = rtModelTaskUpdate(desStm, desTaskId, sinkStm, &para);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_MODEL);

    delete desStm;
    delete sinkStm;
    delete device;
}

TEST_F(CloudV2ApiImplSpecTest, ModelTaskUpdateFail_002)
{
    rtError_t error;
    Context * const curCtx = Runtime::Instance()->CurrentContext();
    EXPECT_EQ(curCtx != nullptr, true);
    Device * const dev = curCtx->Device_();
    EXPECT_EQ(dev != nullptr, true);
    MOCKER_CPP_VIRTUAL(dev, &Device::CheckFeatureSupport)
    .stubs()
    .will(returnValue(false));

    rtStream_t desStm;
    error = rtStreamCreate(&desStm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtStream_t sinkStm;
    error = rtStreamCreate(&sinkStm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint64_t tillingkey = 123456;
    uint64_t *devMemSrc;
    error = rtMalloc((void **)&devMemSrc, sizeof(uint64_t), RT_MEMORY_HBM, 255);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpy(devMemSrc, sizeof(uint64_t), &tillingkey, sizeof(uint64_t), RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    void *devMem;
    error = rtMalloc((void **)&devMem, sizeof(rtFftsPlusMixAicAivCtx_t), RT_MEMORY_HBM, 255);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtFftsPlusTaskInfo_t fftsPlusTaskInfo;
    fftsPlusTaskInfo.descBuf = devMem;
    rtMdlTaskUpdateInfo_t  para;
    para.tilingKeyAddr = devMemSrc;
    para.hdl = devMemSrc;
    para.fftsPlusTaskInfo = &fftsPlusTaskInfo;
    uint32_t desTaskId = 0;

    error = rtModelTaskUpdate(desStm, desTaskId, sinkStm, &para);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    rtFree(devMemSrc);
    rtFree(devMem);
    error = rtStreamDestroy(desStm);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(sinkStm);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiImplSpecTest, GetDeviceCapModelUpdate)
{
    rtError_t error;
    int32_t value = 0;

    error = rtGetDeviceCapability(0, RT_MODULE_TYPE_TSCPU, FEATURE_TYPE_MODEL_TASK_UPDATE, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(value, RT_DEV_CAP_NOT_SUPPORT);
}

TEST_F(CloudV2ApiImplSpecTest, GetDeviceCapModelUpdate_Support)
{
    rtError_t error;
    int32_t value = 0;

    MOCKER(CheckFeatureIsSupportOld)
    .stubs()
    .will(returnValue(true));

    error = rtGetDeviceCapability(0, RT_MODULE_TYPE_TSCPU, FEATURE_TYPE_MODEL_TASK_UPDATE, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(value, RT_DEV_CAP_SUPPORT);
}

TEST_F(CloudV2ApiImplSpecTest, GetDeviceCapModelUpdate_StubDev)
{
    rtError_t error;

    int32_t value = 0;

    error = rtGetDeviceCapability(64, RT_MODULE_TYPE_TSCPU, FEATURE_TYPE_MODEL_TASK_UPDATE, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(value, RT_DEV_CAP_NOT_SUPPORT);
}

TEST_F(CloudV2ApiImplSpecTest, MODEL_TASK_UPDATE_TEST_1)
{
    unsigned char *m_data = g_m_data;
    size_t m_len = sizeof(g_m_data) / sizeof(g_m_data[0]);
    rtError_t error;
    rtBinHandle bin_handle = nullptr;
    void *handle;
    rtDevBinary_t master_bin;
    master_bin.magic = RT_DEV_BINARY_MAGIC_ELF_AICUBE;
    master_bin.version = 2;
    master_bin.data = m_data;
    master_bin.length = m_len;

    Context * const curCtx = Runtime::Instance()->CurrentContext();
    EXPECT_EQ(curCtx != nullptr, true);
    Device * dev = curCtx->Device_();
    EXPECT_EQ(dev != nullptr, true);
    MOCKER_CPP_VIRTUAL(dev, &Device::CheckFeatureSupport)
    .stubs()
    .will(returnValue(true));
    std::cout<<"call rtBinaryLoad in:"<<error<<std::endl;
    error = rtRegisterAllKernel(&master_bin, &handle);
    std::cout<<"call rtBinaryLoad out:"<<error<<std::endl;
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t desStm;
    error = rtStreamCreate(&desStm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t sinkStm;
    error = rtStreamCreate(&sinkStm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtModel_t model;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RawDevice *rawDevice = (RawDevice *)curCtx->Device_();
    MOCKER_CPP_VIRTUAL(rawDevice->Engine_(), &Engine::SyncTask).stubs().will(returnValue(RT_ERROR_NONE));
    rtModelBindStream(model, desStm, 0);
    rtModelBindStream(model, sinkStm, 0);

    uint64_t tillingkey = 123456;
    uint64_t *devMemSrc;
    error = rtMalloc((void **)&devMemSrc, sizeof(uint64_t), RT_MEMORY_HBM, 255);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpy(devMemSrc, sizeof(uint64_t), &tillingkey, sizeof(uint64_t), RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    void *devMem;
    error = rtMalloc((void **)&devMem, sizeof(rtFftsPlusMixAicAivCtx_t), RT_MEMORY_HBM, 255);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtFftsPlusTaskInfo_t fftsPlusTaskInfo;
    fftsPlusTaskInfo.descBuf = devMem;
    rtMdlTaskUpdateInfo_t  para;
    para.tilingKeyAddr = devMemSrc;
    para.hdl = handle;
    para.fftsPlusTaskInfo = &fftsPlusTaskInfo;
    uint32_t desTaskId = 0;
    error = rtModelTaskUpdate(desStm, desTaskId, sinkStm, &para);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtFree(devMemSrc);
    rtFree(devMem);
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    error = rtModelUnbindStream(model, desStm);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelUnbindStream(model, sinkStm);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Device* dev2 = curCtx->DefaultStream_()->Device_();
    MOCKER_CPP_VIRTUAL(dev2, &Device::GetDevRunningState)
    .stubs()
    .will(returnValue((uint32_t)DEV_RUNNING_NORMAL))
    .then(returnValue((uint32_t)DEV_RUNNING_DOWN));
}

TEST_F(CloudV2ApiImplSpecTest, DeviceGetStreamlistTest)
{
    ApiImpl apiImpl;
    rtStreamlist_t myStreamList = {0, {nullptr}};
    rtError_t error = apiImpl.DeviceGetStreamlist(0, RT_STREAM_TYPE_MAX, &myStreamList);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiImplSpecTest, MODEL_BACKUP)
{
    rtError_t error;
    Context * const curCtx = Runtime::Instance()->CurrentContext();
    EXPECT_EQ(curCtx != nullptr, true);
    Device * dev = curCtx->Device_();
    EXPECT_EQ(dev != nullptr, true);

    rtStream_t sinkStm;
    error = rtStreamCreate(&sinkStm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtModel_t model;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RawDevice *rawDevice = dynamic_cast<RawDevice *>(dev);
    MOCKER_CPP_VIRTUAL(rawDevice->Engine_(), &Engine::SyncTask).stubs().will(returnValue(RT_ERROR_NONE));
    rtModelBindStream(model, sinkStm, 0);

    error = rtEndGraph(model, sinkStm);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelLoadComplete(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSnapShotProcessLock();
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtSnapShotProcessBackup();
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtSnapShotProcessUnlock();
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    GlobalMockObject::verify();

    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    error = rtModelUnbindStream(model, sinkStm);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Device* dev2 = curCtx->DefaultStream_()->Device_();
    MOCKER_CPP_VIRTUAL(dev2, &Device::GetDevRunningState)
        .stubs()
        .will(returnValue((uint32_t)DEV_RUNNING_NORMAL))
        .then(returnValue((uint32_t)DEV_RUNNING_DOWN));
}

TEST_F(CloudV2ApiImplSpecTest, MODEL_RESTORE)
{
    rtError_t error;
    Context * const curCtx = Runtime::Instance()->CurrentContext();
    EXPECT_EQ(curCtx != nullptr, true);
    Device * dev = curCtx->Device_();
    EXPECT_EQ(dev != nullptr, true);

    rtStream_t desStm;
    error = rtStreamCreate(&desStm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t sinkStm;
    error = rtStreamCreate(&sinkStm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t aicpuStm;
    error = rtStreamCreateWithFlags(&aicpuStm, 0, RT_STREAM_AICPU);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtModel_t model;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RawDevice *rawDevice = dynamic_cast<RawDevice *>(dev);
    MOCKER_CPP_VIRTUAL(rawDevice->Engine_(), &Engine::SyncTask).stubs().will(returnValue(RT_ERROR_NONE));
    rtModelBindStream(model, desStm, 0);
    rtModelBindStream(model, sinkStm, 0);
    rtModelBindStream(model, aicpuStm, 0);

    error = rtEndGraph(model, sinkStm);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelLoadComplete(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = ((Model *)model)->SinkSqTasksBackup();
    EXPECT_EQ(error, RT_ERROR_NONE);

    bool enable = false;
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::GetSqEnable)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(enable))
        .will(returnValue(RT_ERROR_NONE));
    uint16_t head = 0U;
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::GetSqHead)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(head), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    uint16_t sinkTail = 1U;
    uint32_t sinkSqId = ((Stream *)sinkStm)->GetSqId();
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::GetSqTail)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), eq(sinkSqId), outBound(sinkTail))
        .will(returnValue(RT_ERROR_NONE));
    uint16_t tail = 0U;
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::GetSqTail)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(tail))
        .will(returnValue(RT_ERROR_NONE));

    TaskInfo task1 = {};
    task1.type = TS_TASK_TYPE_RDMA_PI_VALUE_MODIFY;
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .with(mockcpp::any(), mockcpp::any())
        .will(returnValue(&task1));

    MOCKER_CPP(&DeviceSnapshot::OpMemoryRestore).stubs().will(returnValue(RT_ERROR_NONE));
    error = ContextManage::ModelRestore(dev->Id_());
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    GlobalMockObject::verify();
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtModelUnbindStream(model, desStm);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelUnbindStream(model, sinkStm);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelUnbindStream(model, aicpuStm);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Device* dev2 = curCtx->DefaultStream_()->Device_();
    MOCKER_CPP_VIRTUAL(dev2, &Device::GetDevRunningState)
        .stubs()
        .will(returnValue((uint32_t)DEV_RUNNING_NORMAL))
        .then(returnValue((uint32_t)DEV_RUNNING_DOWN));
}

TEST_F(CloudV2ApiImplSpecTest, MODEL_RESTORE2)
{
    rtError_t error;
    Context * const curCtx = Runtime::Instance()->CurrentContext();
    EXPECT_EQ(curCtx != nullptr, true);
    Device * dev = curCtx->Device_();
    EXPECT_EQ(dev != nullptr, true);

    rtStream_t desStm;
    error = rtStreamCreate(&desStm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtStream_t sinkStm;
    error = rtStreamCreate(&sinkStm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtModel_t model;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RawDevice *rawDevice = dynamic_cast<RawDevice *>(dev);
    MOCKER_CPP_VIRTUAL(rawDevice->Engine_(), &Engine::SyncTask).stubs().will(returnValue(RT_ERROR_NONE));
    rtModelBindStream(model, sinkStm, 0);

    error = rtEndGraph(model, sinkStm);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelLoadComplete(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    TaskInfo task = {};
    InitByStream(&task, (Stream *)desStm);
    ModelExecuteTaskInit(&task, (Model *)model, 0, 1);

    uint32_t errorcode[3] = {10, 1, 0};
    WaitExecFinishForModelExecuteTask(&task);
    SetResult(&task, (const uint32_t *)errorcode,1);
    Complete(&task, 0);

    error = ((Model *)model)->SinkSqTasksBackup();
    EXPECT_EQ(error, RT_ERROR_NONE);

    bool enable = false;
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::GetSqEnable)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(enable))
        .will(returnValue(RT_ERROR_NONE));
    uint16_t head = 0U;
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::GetSqHead)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(head), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    uint16_t sinkTail = 1U;
    uint32_t sinkSqId = ((Stream *)sinkStm)->GetSqId();
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::GetSqTail)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), eq(sinkSqId), outBound(sinkTail))
        .will(returnValue(RT_ERROR_NONE));
    uint16_t tail = 0U;
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::GetSqTail)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(tail))
        .will(returnValue(RT_ERROR_NONE));

    TaskInfo task1 = {};
    task1.type = TS_TASK_TYPE_RDMA_PI_VALUE_MODIFY;
    MOCKER_CPP(&TaskFactory::GetTask)
        .stubs()
        .with(mockcpp::any(), mockcpp::any())
        .will(returnValue(&task1));
    MOCKER_CPP(&DeviceSnapshot::OpMemoryRestore).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    error = ContextManage::ModelRestore(dev->Id_());
    EXPECT_EQ(error, RT_ERROR_NONE);

    GlobalMockObject::verify();
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtModelUnbindStream(model, sinkStm);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(sinkStm);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(desStm);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Device* dev2 = curCtx->DefaultStream_()->Device_();
    MOCKER_CPP_VIRTUAL(dev2, &Device::GetDevRunningState)
        .stubs()
        .will(returnValue((uint32_t)DEV_RUNNING_NORMAL))
        .then(returnValue((uint32_t)DEV_RUNNING_DOWN));
}

TEST_F(CloudV2ApiImplSpecTest, MODEL_SNAPSHOT_002)
{
    rtStream_t sinkStm;
    rtError_t error = rtStreamCreate(&sinkStm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream *stream = (Stream *)sinkStm;
    TaskInfo task = {};
    InitByStream(&task, stream);
    task.type = TS_TASK_TYPE_MODEL_TASK_UPDATE;
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(UpdateD2HTaskInit).stubs().will(returnValue(RT_ERROR_DRV_ERR));
    error = UpdateTaskD2HSubmit(&task, nullptr, stream);
    EXPECT_EQ(error,RT_ERROR_DRV_ERR);
    error = rtStreamDestroy(sinkStm);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiImplSpecTest, MODEL_SNAPSHOT_003)
{
    rtStream_t sinkStm;
    rtError_t error = rtStreamCreate(&sinkStm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream *stream = (Stream *)sinkStm;
    TaskInfo task = {};
    InitByStream(&task, stream);
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(UpdateD2HTaskInit).stubs().will(returnValue(RT_ERROR_NONE));
    Context * const curCtx = Runtime::Instance()->CurrentContext();
    EXPECT_EQ(curCtx != nullptr, true);
    MOCKER_CPP_VIRTUAL(curCtx->Device_(), &Device::SubmitTask).stubs().will(returnValue(RT_ERROR_DRV_ERR));
    error = UpdateTaskD2HSubmit(&task, nullptr, stream);
    EXPECT_EQ(error, RT_ERROR_DRV_ERR);
    error = rtStreamDestroy(sinkStm);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiImplSpecTest, MODEL_SNAPSHOT_004)
{
    rtStream_t sinkStm;
    rtError_t error = rtStreamCreate(&sinkStm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream *stream = (Stream *)sinkStm;
    TaskInfo task = {};
    InitByStream(&task, stream);
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(MemcpyAsyncTaskPrepare).stubs().will(returnValue(RT_ERROR_DRV_ERR));
    error = UpdateTaskH2DSubmit(&task, stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_DRV_ERR);
    error = rtStreamDestroy(sinkStm);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiImplSpecTest, MODEL_SNAPSHOT_005)
{
    rtStream_t sinkStm;
    rtError_t error = rtStreamCreate(&sinkStm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream *stream = (Stream *)sinkStm;
    TaskInfo task = {};
    InitByStream(&task, stream);
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(MemcpyAsyncTaskPrepare).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(SqeUpdateH2DTaskInit).stubs().will(returnValue(RT_ERROR_DRV_ERR));

    error = UpdateTaskH2DSubmit(&task, stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_DRV_ERR);
    error = rtStreamDestroy(sinkStm);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiImplSpecTest, MODEL_SNAPSHOT_006)
{
    rtStream_t sinkStm;
    rtError_t error = rtStreamCreate(&sinkStm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Stream *stream = (Stream *)sinkStm;
    TaskInfo task = {};
    InitByStream(&task, stream);
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(MemcpyAsyncTaskPrepare).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(SqeUpdateH2DTaskInit).stubs().will(returnValue(RT_ERROR_NONE));

    Context * const curCtx = Runtime::Instance()->CurrentContext();
    EXPECT_EQ(curCtx != nullptr, true);
    MOCKER_CPP_VIRTUAL(curCtx->Device_(), &Device::SubmitTask).stubs().will(returnValue(RT_ERROR_DRV_ERR));
    error = UpdateTaskH2DSubmit(&task, stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_DRV_ERR);
    error = rtStreamDestroy(sinkStm);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiImplSpecTest, MODEL_SNAPSHOT_007)
{
    rtError_t error;
    Context * const curCtx = Runtime::Instance()->CurrentContext();
    EXPECT_EQ(curCtx != nullptr, true);
    Device * dev = curCtx->Device_();
    EXPECT_EQ(dev != nullptr, true);
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    dev->GetDeviceSnapShot()->OpMemoryRestore();
    dev->GetDeviceSnapShot()->OpMemoryBackup();

    H2DCopyMgr *argAllocator = new (std::nothrow) H2DCopyMgr(dev, 2000U, 5U, 5U,
        BufferAllocator::LINEAR, COPY_POLICY_ASYNC_PCIE_DMA);
    void *add = argAllocator->MallocBuffer(1, &(argAllocator->cpyInfoDmaMap_));
    argAllocator->FreeBuffer(add, &(argAllocator->cpyInfoDmaMap_));

    argAllocator->policy_ = COPY_POLICY_ASYNC_PCIE_DMA;
    MOCKER_CPP(&H2DCopyMgr::ArgsPoolConvertAddr)
            .stubs()
            .will(returnValue(RT_ERROR_NONE));

    error = dev->GetDeviceSnapShot()->ArgsPoolConvertAddr(argAllocator);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete argAllocator;
}

TEST_F(CloudV2ApiImplSpecTest, MODEL_SNAPSHOT_001)
{
    rtError_t error;
    Context * const curCtx = Runtime::Instance()->CurrentContext();
    EXPECT_EQ(curCtx != nullptr, true);
    Device * dev = curCtx->Device_();
    EXPECT_EQ(dev != nullptr, true);

    rtModel_t model;
    error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Model *temp_model = (Model*) model;
    temp_model->UpdateSnapShotSqe();
    temp_model->ReBuild();

    rtStream_t sinkStm;
    error = rtStreamCreate(&sinkStm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    RawDevice *rawDevice = dynamic_cast<RawDevice *>(dev);
    MOCKER_CPP_VIRTUAL(rawDevice->Engine_(), &Engine::SyncTask).stubs().will(returnValue(RT_ERROR_NONE));
    rtModelBindStream(model, sinkStm, 0);

    MOCKER_CPP(&Context::MemcpyAsync)
            .stubs()
            .will(returnValue(RT_ERROR_NONE));

    uint64_t* args = new uint64_t[20];
    // aicpu
    Stream *stream = (Stream *)sinkStm;
    TaskInfo task1 = {};
    InitByStream(&task1, stream);
    AicpuTaskInit(&task1, 1, 0);
    task1.u.aicTaskInfo.comm.args = &args[0];
    task1.u.aicTaskInfo.comm.argsSize = 8;
    stream->AddTaskToStream(&task1);
    dev->GetDeviceSnapShot()->RecordArgsAddrAndSize(&task1);

    EXPECT_EQ(stream->IsNeedUpdateTask(&task1), false);

    // aic
    TaskInfo task2 = {};
    InitByStream(&task2, stream);
    AicTaskInit(&task2, 0, 1, 0, nullptr);

    task2.u.aicTaskInfo.comm.args = &args[1];
    task2.u.aicTaskInfo.comm.argsSize = 8;
    stream->AddTaskToStream(&task2);
    dev->GetDeviceSnapShot()->RecordArgsAddrAndSize(&task2);

    // mix
    const void *stubFunc = (void *)0x02;
    const char *stubName = "abc";

    TaskInfo task3 = {};
    InitByStream(&task3, stream);
    AicTaskInit(&task3, Program::MACH_AI_CORE, 1, 1, nullptr);
    PlainProgram stubProg(Program::MACH_AI_CORE);
    Program *program = &stubProg;
    program->kernelNames_ = {'a', 'b', 'c', 'd', '\0'};
    Kernel *kernel = new (std::nothrow) Kernel(stubFunc, stubName, "", program, 0);
    task3.u.aicTaskInfo.kernel = kernel;
    kernel->SetMixType(MIX_AIV);
    task3.u.aicTaskInfo.mixOpt= true;

    task3.u.aicTaskInfo.comm.args = &args[3];
    task3.u.aicTaskInfo.comm.argsSize = 8;

    rtFftsPlusMixAicAivCtx_t * descAlignBuf = new rtFftsPlusMixAicAivCtx_t;
    task3.u.aicTaskInfo.descAlignBuf = descAlignBuf;
    stream->AddTaskToStream(&task3);
    dev->GetDeviceSnapShot()->RecordArgsAddrAndSize(&task3);

    // fftsplus
    TaskInfo task4 = {};
    rtFftsPlusTaskInfo_t  fftsPlusTaskInfo = {};
    MOCKER(FillFftsPlusSqe)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    InitByStream(&task4, stream);
    FftsPlusTaskInit(&task4, &fftsPlusTaskInfo, 0);
    FftsPlusTaskInfo *fftsPlusTask = &(task4.u.fftsPlusTask);
    fftsPlusTask->descAlignBuf = &args[4];
    fftsPlusTask->descBufLen = 8;
    stream->AddTaskToStream(&task4);
    dev->GetDeviceSnapShot()->RecordArgsAddrAndSize(&task4);

    // 条件算子
    TaskInfo task5 = {};
    InitByStream(&task5, stream);
    StreamActiveTaskInit(&task5, stream);
    StreamActiveTaskInfo *streamActiveTask = &(task5.u.streamactiveTask);
    streamActiveTask->funcCallSvmMem = &args[5];
    streamActiveTask->funCallMemSize = 8;
    stream->AddTaskToStream(&task5);
    dev->GetDeviceSnapShot()->RecordFuncCallAddrAndSize(&task5);
    StreamActiveTaskUnInit(&task5);

    TaskInfo task6 = {};
    task6.typeName = "MEM_WAIT_VALUE";
    task6.type = TS_TASK_TYPE_MEM_WAIT_VALUE;
    InitByStream(&task6, stream);
    MemWaitValueTaskInit(&task6, &args[8], 0, 0);
    MemWaitValueTaskInfo *memWaitValueTask = &task6.u.memWaitValueTask;
    memWaitValueTask->funcCallSvmMem2 = &args[7];
    memWaitValueTask->funCallMemSize2 = 8;
    memWaitValueTask->devAddr = (uint64_t)(&args[8]);
    stream->AddTaskToStream(&task6);
    dev->GetDeviceSnapShot()->RecordFuncCallAddrAndSize(&task6);
    MemWaitTaskUnInit(&task6);

    TaskInfo task7 = {};
    InitByStream(&task7, stream);
    StreamLabelSwitchByIndexTaskInit(&task7, &args[9], 10, &args[10]);
    StmLabelSwitchByIdxTaskInfo * stmLabelSwitchByIdxTaskInfo = &(task7.u.stmLabelSwitchIdxTask);
    stmLabelSwitchByIdxTaskInfo->funcCallSvmMem = &args[11];
    stmLabelSwitchByIdxTaskInfo->funCallMemSize = 8;
    dev->GetDeviceSnapShot()->RecordFuncCallAddrAndSize(&task7);
    StreamLabelSwitchByIndexTaskUnInit(&task7);

    TaskInfo task8 = {};
    InitByStream(&task8, stream);
    task8.type = TS_TASK_TYPE_RDMA_PI_VALUE_MODIFY;
    RdmaPiValueModifyInfo *rdmaPiValueModifyInfo = &(task8.u.rdmaPiValueModifyInfo);
    rdmaPiValueModifyInfo->funCallMemAddr = &args[12];
    rdmaPiValueModifyInfo->funCallMemSize = 8;
    dev->GetDeviceSnapShot()->RecordFuncCallAddrAndSize(&task8);

    TaskInfo task9 = {};
    InitByStream(&task9, stream);
    task9.type = TS_TASK_TYPE_STREAM_SWITCH;
    StreamSwitchTaskInfo* streamSwitchTask = &(task9.u.streamswitchTask);
    streamSwitchTask->funcCallSvmMem = &args[13];
    streamSwitchTask->funCallMemSize = 8;
    dev->GetDeviceSnapShot()->RecordFuncCallAddrAndSize(&task9);

    TaskInfo task10 = {};
    InitByStream(&task10, stream);
    task10.type = TS_TASK_TYPE_MODEL_TASK_UPDATE;
    TilingTabl* tilingTbl = new TilingTabl;
    MdlUpdateTaskInfo *mdlUpdateTaskInfo = &(task10.u.mdlUpdateTask);
    mdlUpdateTaskInfo->tilingTabLen = 1;
    mdlUpdateTaskInfo->tilingTabAddr = tilingTbl;
    mdlUpdateTaskInfo->tilingKeyAddr = &args[14];
    mdlUpdateTaskInfo->blockDimAddr = &args[15];
    mdlUpdateTaskInfo->fftsPlusTaskDescBuf = &args[16];
    dev->GetDeviceSnapShot()->RecordFuncCallAddrAndSize(&task10);
    MOCKER_CPP(&Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));

    MOCKER_CPP(&DeviceSnapshot::OpMemoryInfoInit).stubs();
    error = dev->GetDeviceSnapShot()->OpMemoryBackup();
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = dev->GetDeviceSnapShot()->OpMemoryRestore();
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = dev->GetDeviceSnapShot()->ArgsPoolRestore();
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(SqeUpdateH2DTaskInit).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(MemcpyAsyncTaskCommonInit).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(halMemAlloc).stubs().will(returnValue(DRV_ERROR_NONE));
    stream->SubmitMemCpyAsyncTask(&task10);
    stream->SubmitMemCpyAsyncTask(&task9);

    delete[] args;
    delete descAlignBuf;
    delete kernel;
    delete tilingTbl;

    error = rtModelUnbindStream(model, sinkStm);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(sinkStm);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Device* dev2 = curCtx->DefaultStream_()->Device_();
    MOCKER_CPP_VIRTUAL(dev2, &Device::GetDevRunningState)
    .stubs()
    .will(returnValue((uint32_t)DEV_RUNNING_NORMAL))
    .then(returnValue((uint32_t)DEV_RUNNING_DOWN));
}