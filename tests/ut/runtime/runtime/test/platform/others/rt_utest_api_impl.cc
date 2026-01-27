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
#define private public
#include "runtime/rt.h"
#include "securec.h"
#include "context.hpp"
#include "raw_device.hpp"
#include "event.hpp"
#include "runtime.hpp"
#include "runtime_keeper.h"
#include "module.hpp"
#include "program.hpp"
#include "api_impl.hpp"
#include "api_error.hpp"
#include "profiler.hpp"
#include "api_profile_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "stream.hpp"
#include "task_res.hpp"
#include "task_submit.hpp"
#include "api.hpp"
#include "driver.hpp"
#include "npu_driver.hpp"
#include "logger.hpp"
#include "dqs/task_dqs.hpp"
#undef private
#include <string>
#include "driver/ascend_hal.h"
#include "device_msg_handler.hpp"
#include "ttlv.hpp"
#include "model.hpp"
#include "task_info.hpp"
#include "platform/platform_info.h"
#include "soc_info.h"
#include "config_define.hpp"
#include "api_impl_david.hpp"
#include "thread_local_container.hpp"
#include "stream_c.hpp"
#include "fast_recover.hpp"
#include "rts.h"

using namespace testing;
using namespace cce::runtime;

extern bool g_init_platform_info_flag;
extern bool g_get_platform_info_flag;
class ApiImplTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
        std::cout<<"ApiImplTest test start start. "<<std::endl;

    }

    static void TearDownTestCase()
    {
        std::cout<<"ApiImplTest test start end. "<<std::endl;

    }

    virtual void SetUp()
    {
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        (void)rtSetDevice(0);
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        rtDeviceReset(0);
    }
private:
    bool isErrorNone_ = true;
};

static void ApiImplTest_Stream_Cb(void *arg)
{
}


TEST_F(ApiImplTest, apiImpl_ts_model_abort_as31xm1)
{
    rtError_t error;
    Model *model = NULL;
    ApiImpl apiImpl;
    uint32_t flag = 1;
    uint64_t addr = 0x1000;
    uint32_t streamId;
    uint32_t taskId;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_TS_MODEL_ABORT);
    error = apiImpl.ModelCreate(&model, 0);
    model->SetModelExecutorType(EXECUTOR_TS);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_AS31XM1);
    GlobalContainer::SetRtChipType(CHIP_AS31XM1);

    error = apiImpl.ModelAbort(model);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    device->SetTschVersion(version);

    error = apiImpl.ModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ApiImplTest, apiImpl_ts_model_abort_610lite)
{
    rtError_t error;
    Model *model = NULL;
    ApiImpl apiImpl;
    uint32_t flag = 1;
    uint64_t addr = 0x1000;
    uint32_t streamId;
    uint32_t taskId;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_TS_MODEL_ABORT);
    error = apiImpl.ModelCreate(&model, 0);
    model->SetModelExecutorType(EXECUTOR_TS);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_610LITE);
    GlobalContainer::SetRtChipType(CHIP_610LITE);

    error = apiImpl.ModelAbort(model);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    device->SetTschVersion(version);

    error = apiImpl.ModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ApiImplTest, apiImpl_ts_model_abort_old_ver)
{
    rtError_t error;
    Model *model = NULL;
    ApiImpl apiImpl;
    uint32_t flag = 1;
    uint64_t addr = 0x1000;
    uint32_t streamId;
    uint32_t taskId;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    error = apiImpl.ModelCreate(&model, 0);
    model->SetModelExecutorType(EXECUTOR_TS);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);

    error = apiImpl.ModelAbort(model);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);

    error = apiImpl.ModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ApiImplTest, PROCESS_REPORT)
{
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance()); // 这里又想用回默认的g_runtimeKeeper
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
    ApiImpl apiImpl;
    rtError_t error;
    error = apiImpl.ProcessReport(0);

    rtStream_t stream;
    rtStreamCreate(&stream, 0);
    rtSubscribeReport(123, stream);
    MOCKER_CPP(&Stream::IsHostFuncCbReg).stubs().will(returnValue(true));
    Stream * stm = (Stream *)stream;
    stm->IsHostFuncCbReg();
    rtCallback_t stub_func = (rtCallback_t)0x12345;
    rtCallbackLaunch(stub_func, nullptr, stream, true);
    error = apiImpl.ProcessReport(0);

    int32_t value = 0;
    // 打桩g_runtimeKeeper中的runtime_
    Event evt;
    MOCKER_CPP_VIRTUAL(evt, &Event::TryFreeEventIdAndCheckCanBeDelete).stubs().will(returnValue(true));
    MOCKER_CPP(&Runtime::GetGroupIdByThreadId).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(rtInstance, &Runtime::GetPriCtxByDeviceId).stubs().will(returnValue((Context *)NULL));
    rtUnSubscribeReport(123, stream);
    rtStreamDestroy(stream);
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    error = apiImpl.GetDeviceCapability(0, RT_MODULE_TYPE_TSCPU, FEATURE_TYPE_FFTS_MODE, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    error = apiImpl.GetDeviceCapability(0, RT_MODULE_TYPE_HOST_AICPU, INFO_TYPE_OCCUPY, &value);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
    error = apiImpl.GetDeviceCapability(0, RT_MODULE_TYPE_HOST_AICPU, INFO_TYPE_CORE_NUM, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = apiImpl.GetDeviceCapability(0, RT_MODULE_TYPE_SYSTEM, INFO_TYPE_CORE_NUM, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = apiImpl.GetDeviceCapability(0, RT_MODULE_TYPE_TSCPU, FEATURE_TYPE_MODEL_TASK_UPDATE, &value);
    EXPECT_EQ(error, RT_ERROR_NONE);
    MOCKER(halGetAPIVersion)
    .stubs()
    .will(returnValue(DRV_ERROR_RESERVED));
    error = apiImpl.GetDeviceCapability(0, RT_MODULE_TYPE_SYSTEM, INFO_TYPE_CORE_NUM, &value);
}

rtError_t GetRunModeStubExt(cce::runtime::ApiImpl *api, rtRunMode *mode)
{
    *mode = RT_RUN_MODE_ONLINE;
    return RT_ERROR_NONE;
}

rtError_t GetRunModeOfflineStub(cce::runtime::ApiImpl *api, rtRunMode *mode)
{
    *mode = RT_RUN_MODE_OFFLINE;
    return RT_ERROR_NONE;
}

void GetErrorMessage(const char *msg, uint32_t len) {
    if (msg != nullptr && len != 0) {
        RT_LOG(RT_LOG_ERROR, "rtGetDeviceErrorMessage get msg:%s, length=%u.", msg, len);
    } else {
        RT_LOG(RT_LOG_ERROR, "rtGetDeviceErrorMessage get msg failed, length=%u.", msg, len);
    }
}

TEST_F(ApiImplTest, rtGetDevMsg)
{
    ApiImpl apiImpl;
    rtError_t error;
    MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue((Context *)NULL));
    MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetRunMode).stubs().will(invoke(GetRunModeStubExt));

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);

    error = apiImpl.GetDevMsg(RT_GET_DEV_ERROR_MSG, GetErrorMessage);
    // EXPECT_EQ(error, RT_ERROR_CONTEXT_NULL); 临时注释，后续整改
    error = apiImpl.GetDevMsg(RT_GET_DEV_MSG_RESERVE, GetErrorMessage);
    // EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT); 临时注释，后续整改
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    GlobalMockObject::verify();
}

rtError_t MemCopySyncStubDavid(Driver *drv, void *dst, uint64_t destMax, const void *src, uint64_t size, rtMemcpyKind_t kind)
{
    memcpy_s(dst, destMax, src, size);
    return DRV_ERROR_NONE;
}

TEST_F(ApiImplTest, rtGetDevMsgOffline)
{
    ApiImpl apiImpl;
    rtError_t error;
    MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue((Context *)NULL));
    MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(false));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetRunMode).stubs().will(invoke(GetRunModeOfflineStub));

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);

    error = apiImpl.GetDevMsg(RT_GET_DEV_ERROR_MSG, GetErrorMessage);
    // EXPECT_EQ(error, RT_ERROR_CONTEXT_NULL); 临时注释，后续整改
    error = apiImpl.GetDevMsg(RT_GET_DEV_MSG_RESERVE, GetErrorMessage);
    // EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT); 临时注释，后续整改
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    GlobalMockObject::verify();
}

TEST_F(ApiImplTest, GetMaxModelNum)
{
    rtError_t error;
    ApiImpl apiImpl;
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    Device* device = rtInstance->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_EXPEND_MODEL_ID);
    uint32_t maxModelCount;
    Context context(device, false);
    context.Init();
    MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(true));
    MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue(&context));
    error = apiImpl.GetMaxModelNum(&maxModelCount);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiImplTest, IPC_ADAPT)
{
    ApiImpl apiImpl;
    void *ptr = nullptr;
    void **ptrNull = nullptr;
    char* name = nullptr;
    rtNotify_t notify;
    int32_t pid[]={1};
    rtError_t error;
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    Device* device = rtInstance->DeviceRetain(0, 0);
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    error = apiImpl.SetIpcNotifyPid(name, pid, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halShrIdSetPid).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = apiImpl.SetIpcNotifyPid(name, pid, 1);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}

rtError_t GetDevMsgTaskInitStubDavid(TaskInfo *task, const void *devMemAddr, uint32_t devMemSize,
                                rtGetDevMsgType_t msgType)
{
    task->type = TS_TASK_TYPE_GET_DEVICE_MSG;
    if (devMemAddr != nullptr && devMemSize > sizeof(rtGetDevMsgCtrlInfo_t)) {
        rtGetDevMsgCtrlInfo_t *ctrlInfo = (rtGetDevMsgCtrlInfo_t *)devMemAddr;
        ctrlInfo->magic = DeviceMsgHandler::DEVICE_GET_MSG_MAGIC;
        ctrlInfo->pid = 0;
        ctrlInfo->bufferLen = sizeof(rtGetDevMsgCtrlInfo_t) + sizeof(rtStreamSnapshot_t);
    }
    return RT_ERROR_NONE;
}

rtError_t GetDevMsgSubmitTaskStubDavid(Device *dev, TaskInfo *task, rtTaskGenCallback callback)
{
    (void)dev->GetTaskFactory()->Recycle(task);
    return RT_ERROR_NONE;
}

void GetMsgCallbackStubDavid(const char *msg, uint32_t len) {}

TEST_F(ApiImplTest, GetDevRunningStreamSnapshotMsg_david)
{
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DAVID);
    GlobalContainer::SetRtChipType(CHIP_DAVID);

    ApiImpl apiImpl;
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    device->SetTschVersion(TS_VERSION_GET_DEV_MSG);
    Stream *stream = new Stream((Device *)device, 0);
    MOCKER(GetDevMsgTaskInit).stubs().will(invoke(GetDevMsgTaskInitStubDavid));
    MOCKER(SyncGetDeviceMsg).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::GetRunMode).stubs().will(invoke(GetRunModeStubExt));
    MOCKER_CPP_VIRTUAL(device, &Device::SubmitTask).stubs().will(invoke(GetDevMsgSubmitTaskStubDavid));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(invoke(MemCopySyncStubDavid));
    MOCKER_CPP_VIRTUAL(stream, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(stream, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    {
        Context context(device, false);
        context.Init();
        MOCKER(ContextManage::CheckContextIsValid).stubs().will(returnValue(true));
        MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue(&context));

        rtError_t ret = apiImpl.GetDevMsg(RT_GET_DEV_RUNNING_STREAM_SNAPSHOT_MSG, GetMsgCallbackStubDavid);
    }
    delete stream;

    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    GlobalMockObject::verify();
}

TEST_F(ApiImplTest, apiimpl_stream_test)
{
    ApiImpl apiImpl;
    rtError_t error;
    rtStream_t rt_stream;

    rtStreamCreate(&rt_stream, 0);
    Stream *stream = (Stream *)rt_stream;
    Context *context = (Context *)stream->Context_();
    sleep(1);
    error = rtStreamQuery(rt_stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    rtChipType_t chipType = rtInstance->GetChipType();

    uint32_t maxStrCount;
    uint32_t maxTaskCount;
    error = apiImpl.GetMaxStreamAndTask(0, &maxStrCount, &maxTaskCount);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);
    error = apiImpl.GetMaxStreamAndTask(0, &maxStrCount, &maxTaskCount);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetChipType(CHIP_610LITE);
    GlobalContainer::SetRtChipType(CHIP_610LITE);
    error = apiImpl.GetMaxStreamAndTask(1, &maxStrCount, &maxTaskCount);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiImplTest, get_priority_range_coverage)
{
    rtError_t error;
    int32_t leastPriority;
    int32_t greatestPriority;

    ApiImpl impl;
    ApiDecorator api(&impl);

    error = api.DeviceGetStreamPriorityRange(&leastPriority, &greatestPriority);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiImplTest, get_priority_range_coverage_with_nullptr)
{
    rtError_t error;
    int32_t leastPriority;
    int32_t greatestPriority;

    ApiImpl impl;
    ApiDecorator api(&impl);

    error = api.DeviceGetStreamPriorityRange(NULL, &greatestPriority);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = api.DeviceGetStreamPriorityRange(&leastPriority, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = api.DeviceGetStreamPriorityRange(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(ApiImplTest, stream_create_with_priority_out_of_range)
{
    ApiImpl impl;
	ApiErrorDecorator api(&impl);
    rtError_t error;
	rtStream_t stream_ = nullptr;
	int32_t priority = -1;

	error = api.StreamCreate((Stream**)&stream_, priority, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    stream_ = nullptr;

    priority = 8;

    error = api.StreamCreate((Stream**)&stream_, priority, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiImplTest, ModelSetSchGroupId_test)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    int16_t schGrpId = 1;
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);

    rtModel_t  model;
    rtError_t error = rtModelCreate(&model, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelSetSchGroupId(model, schGrpId);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    schGrpId = 5;
    error = rtModelSetSchGroupId(model, schGrpId);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiImplTest, apiImpl_ts_model_abort_adc)
{
    rtError_t error;
    Model *model = NULL;
    ApiImpl apiImpl;
    uint32_t flag = 1;
    uint64_t addr = 0x1000;
    uint32_t streamId;
    uint32_t taskId;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_TS_MODEL_ABORT);
    error = apiImpl.ModelCreate(&model, 0);
    model->SetModelExecutorType(EXECUTOR_TS);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_ADC);
    GlobalContainer::SetRtChipType(CHIP_ADC);

    error = apiImpl.ModelAbort(model);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    device->SetTschVersion(version);

    error = apiImpl.ModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ApiImplTest, decorator_david)
{
    rtError_t error;
    Api *oldApi_= const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    error = apiDecorator_->WriteValuePtr(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->DeviceGetStreamlist(0, RT_STREAM_TYPE_MAX, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    rtModelList_t myModelList = {0, {nullptr}};
    error = apiDecorator_->DeviceGetModelList(0, &myModelList);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = apiDecorator_->DeviceGetModelList(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->CntNotifyCreate(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->CntNotifyDestroy(nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->CntNotifyRecord(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->CntNotifyWaitWithTimeout(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->CntNotifyReset(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->GetCntNotifyAddress(nullptr, nullptr, NOTIFY_TYPE_MAX);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->WriteValue(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->CCULaunch(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->GetDevResAddress(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->UbDevQueryInfo(QUERY_TYPE_BUFF, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->ReleaseDevResAddress(nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = apiDecorator_->UbDbSend(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    
    error = apiDecorator_->UbDirectSend(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t originChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DAVID);
    GlobalContainer::SetRtChipType(CHIP_DAVID);

    error = apiDecorator_->FusionLaunch(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    rtInstance->SetChipType(originChipType);
    GlobalContainer::SetRtChipType(originChipType);


    error = apiDecorator_->DeviceResourceClean(0);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    delete apiDecorator_;
}


TEST_F(ApiImplTest, rts_api_impl_test5)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    ApiImpl impl;
    ApiErrorDecorator apiError(&impl);

    RtArgsWithType argsWithType;
    argsWithType.args.argHandle = nullptr;
    argsWithType.type = RT_ARGS_MAX;
    rtError_t error = apiError.CheckArgsWithType(&argsWithType);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    int32_t fun1;
    Kernel *k1 = new Kernel(&fun1, "f1", "", program, 10);
    k1->userParaNum_ = 0;
    k1->systemParaNum_ = 0;
    k1->isSupportOverFlow_ = false;
    k1->isNeedSetFftsAddrInArg_ = false;
    k1->SetKernelRegisterType(RT_KERNEL_REG_TYPE_NON_CPU);
    k1->mixType_ = MIX_AIV;

    uint64_t data = 1234;
    argsWithType.type = RT_ARGS_NON_CPU_EX;
    rtArgsEx_t nonCpuArgsInfo = {};
    nonCpuArgsInfo.args = &data;
    nonCpuArgsInfo.argsSize = 8;
    nonCpuArgsInfo.isNoNeedH2DCopy = 1;
    argsWithType.args.nonCpuArgsInfo = &nonCpuArgsInfo;

    rtKernelLaunchCfg_t cfg;
    rtLaunchKernelAttr_t attrs[2];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_ENGINE_TYPE;
    attrs[0].value.engineType = RT_ENGINE_TYPE_AIV;
    attrs[1].id = RT_LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET;
    attrs[1].value.blockDimOffset = 1;
    cfg.attrs = attrs;
    cfg.numAttrs = 2;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DC);
    GlobalContainer::SetRtChipType(CHIP_DC);
    Stream *stream = new Stream(device, 0);
    error = apiError.LaunchKernelV2(k1, 1, &argsWithType, stream, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    attrs[1].id = RT_LAUNCH_KERNEL_ATTR_TIMEOUT;
    attrs[1].value.timeout = 123;
    error = apiError.LaunchKernelV2(k1, 1, &argsWithType, stream, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    attrs[1].id = RT_LAUNCH_KERNEL_ATTR_TIMEOUT_US;
    attrs[1].value.timeoutUs.timeoutLow = 123U; // us
    attrs[1].value.timeoutUs.timeoutHigh = 0U; // us
    error = apiError.LaunchKernelV2(k1, 1, &argsWithType, stream, &cfg);
    EXPECT_NE(error, RT_ERROR_NONE);

    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_TIMEOUT;
    attrs[1].id = RT_LAUNCH_KERNEL_ATTR_TIMEOUT_US;
    error = apiError.LaunchKernelV2(k1, 1, &argsWithType, stream, &cfg);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);

    delete k1;
    delete stream;
}

TEST_F(ApiImplTest, api_DvppGroupCreate)
{
    rtError_t error;

    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtSocType_t oriSocType = rtInstance->GetSocType();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);

    error = rtDvppGroupCreate(nullptr, 0U);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
    rtInstance->SetSocType(oriSocType);
}

TEST_F(ApiImplTest, api_rtStarsTaskLaunch)
{
    rtError_t error;

    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    rtChipType_t oriChipType = rtInstance->GetChipType();
    rtSocType_t oriSocType = rtInstance->GetSocType();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);

    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStarsTaskLaunch(nullptr, 0U, stream);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    rtInstance->SetChipType(oriChipType);
    GlobalContainer::SetRtChipType(oriChipType);
    rtInstance->SetSocType(oriSocType);
}

TEST_F(ApiImplTest, stub_david_test_SendTopicMsgVersionToAicpuDavid)
{
    rtStream_t stream;
    rtError_t error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    bool isFinished = false;
    uint32_t taskId = 0U;
    uint32_t streamId = 0U;
    ((Stream *)stream)->JudgeTaskFinish(0, isFinished);

    Runtime *rtInstance = (Runtime *) Runtime::Instance();
    rtChipType_t originChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_DAVID);
    error = rtGetTaskIdAndStreamID(&taskId, &streamId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetChipType(originChipType);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
