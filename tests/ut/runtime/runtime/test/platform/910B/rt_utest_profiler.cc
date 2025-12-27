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
#include "securec.h"
#include "toolchain/prof_acl_api.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "config.hpp"
#include "profiler.hpp"
#include "api_profile_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "profiler_struct.hpp"
#include "context.hpp"
#include "raw_device.hpp"
#include "event.hpp"
#include "stream.hpp"
#include "stars.hpp"
#include "hwts.hpp"
#include "api_impl.hpp"
#include "kernel.hpp"
#include "program.hpp"
#include "api_impl.hpp"
#include "logger.hpp"
#include "toolchain/prof_api.h"
#include "thread_local_container.hpp"
#include "onlineprof.hpp"
#undef protected
#undef private

using namespace testing;
using namespace cce::runtime;

Api *g_apiPtrOld = NULL;

#define ENV_VAR_NAME "CCE_PROF_SWITCH"
#define PROF_SWITCH_ON "on"
#define PROF_SWITCH_OFF "off"

int32_t MsprofReporterCallbackStub(uint32_t moduleId, uint32_t type, void *data, uint32_t len)
{
    std::cout << "MsprofCtrlCallbackStub moduleId=" << moduleId << ", type=" << type << ", len=" << len << std::endl;
    return MSPROF_ERROR_NONE;
}

void SetEnvVarOn()
{
    setenv(ENV_VAR_NAME, PROF_SWITCH_ON, 1);
}

void SetEnvVarOff()
{
    setenv(ENV_VAR_NAME, PROF_SWITCH_OFF, 1);
}

void SetProfilerOn()
{
    Runtime *runtime = ((Runtime *)Runtime::Instance());
    if (NULL != runtime)
    {
        SetEnvVarOn();
    }
    rtSetDevice(0);
}

void SetProfilerOff()
{
    rtDeviceReset(0);
    SetEnvVarOff();
}

typedef enum
{
    RT_PROF_TIMELINE_STATE_WAIT,
    RT_PROF_TIMELINE_STATE_RUN,
    RT_PROF_TIMELINE_STATE_COMPLETE,
    RT_PROF_TIMELINE_STATE_PENDING,
    RT_PROF_TIMELINE_STATE_BUTT
}rtProfTimelineState;

class ProfilerTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        SetProfilerOn();
        std::cout << "ProfilerTest SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "ProfilerTest TearDownTestCase" << std::endl;
        SetProfilerOff();
    }

    virtual void SetUp()
    {
        rtError_t error = ((Runtime *)Runtime::Instance())->SetMsprofReporterCallback(MsprofReporterCallbackStub);
        EXPECT_EQ(error, ACL_RT_SUCCESS);
    }

    virtual void TearDown()
    {
         //TBD delete all tmp files
         GlobalMockObject::verify();
        //rtDeviceReset(0);
    }


    Runtime *runtime;
    Profiler *profiler;
    rtContext_t ctx_;
};

void SpiltReportPcs(void* buf, uint8_t len, rtTaskReport_t* rptPcs, uint8_t* pcsNum, uint16_t streamID, uint16_t taskID, uint16_t SQ_id, uint8_t packageType)
{
    uint8_t loopPcs = 0;
    uint8_t *loopBuf = (uint8_t*)buf;
    rtTaskReport_t *loopPcsptr = NULL;

    *pcsNum = len / sizeof(uint32_t);
    for (loopPcs = 0; loopPcs < *pcsNum; loopPcs++)
    {
        loopPcsptr = &rptPcs[loopPcs];
        memset_s(loopPcsptr, sizeof(rtTaskReport_t), 0, sizeof(rtTaskReport_t));
        loopPcsptr->streamID = streamID;
        loopPcsptr->taskID = taskID;
        loopPcsptr->SQ_id = SQ_id;
        loopPcsptr->packageType = packageType;
        if (0 == loopPcs)
        {
            loopPcsptr->SOP = 1;
        }
        else if (*pcsNum -1 == loopPcs)
        {
            loopPcsptr->EOP = 1;
        }
        else
        {
            loopPcsptr->MOP = 1;
        }
        memcpy_s(&loopPcsptr->payLoad, sizeof(uint32_t), loopBuf + loopPcs * sizeof(uint32_t), sizeof(uint32_t));
    }
}

uint64_t g_streamTimestamp = 0;

TEST_F(ProfilerTest, SketchOneProcess)
{
    // MemcpyAsyncTask memTask;
    // DavinciKernelTask kernelTask;
    TaskInfo memTask = {};
    TaskInfo kernelTask = {};
    RawDevice * device = new RawDevice(0);
    EXPECT_NE(device, nullptr);
    Runtime *rt = ((Runtime *)Runtime::Instance());
    profiler = rt->profiler_;

    // api prof not enable
    profiler->apiProfileDecorator_->CallApiBegin(RT_PROF_API_MEMCPY_ASYNC);
    profiler->apiProfileDecorator_->CallApiEnd(RT_ERROR_NONE, 0);

    // api prof enable
    profiler->SetApiProfEnable(true);

    profiler->apiProfileDecorator_->CallApiBegin(RT_PROF_API_MEMCPY_ASYNC, 64, RT_MEMCPY_HOST_TO_DEVICE);
    profiler->apiProfileDecorator_->CallApiEnd(RT_ERROR_NONE, 0);

    profiler->apiProfileDecorator_->CallApiBegin(RT_PROF_API_SET_DEVICE);
    profiler->apiProfileDecorator_->CallApiEnd(RT_ERROR_NONE, 0);

    profiler->apiProfileDecorator_->CallApiBegin(RT_PROF_API_rtProcessReport);
    profiler->apiProfileDecorator_->CallApiEnd(RT_ERROR_NONE, 0);

    // task track
    profiler->ReportTaskTrack(&kernelTask, 0);

    profiler->SetTrackProfEnable(true);
    profiler->ReportTaskTrack(&kernelTask, 0);

    TaskTrackInfo &trackMngInfo = profiler->GetProfTaskTrackData();
    trackMngInfo.taskNum = 5;

    trackMngInfo = profiler->GetProfTaskTrackData();
    profiler->ReportTaskTrack(&kernelTask, 0);
    delete device;
}

TEST_F(ProfilerTest, MemCpyAsync)
{
    Runtime *rt = ((Runtime *)Runtime::Instance());
    bool tmp = rt->isHaveDevice_;
    rt->isHaveDevice_ = true;
    profiler = rt->profiler_;
    // api and track prof enable
    profiler->SetApiProfEnable(true);
    profiler->SetTrackProfEnable(true);
    TaskInfo memTask = {};
    memTask.type = TS_TASK_TYPE_MEMCPY;
    RuntimeProfApiData &profApiData = profiler->GetProfApiData();
    profApiData.entryTime = 1;
    // task track
    profiler->ReportTaskTrack(&memTask, 1);
    RuntimeProfTrackData trackData = profiler->GetProfTaskTrackData().trackBuff[0];
    EXPECT_EQ(trackData.compactInfo.timeStamp, 2);
    rt->isHaveDevice_ = tmp;
}

TEST_F(ProfilerTest, OnlyTaskTrack)
{
    // MemcpyAsyncTask memTask;
    // DavinciKernelTask kernelTask;
    TaskInfo memTask = {};
    TaskInfo kernelTask = {};
    RawDevice * device = new RawDevice(0);
    EXPECT_NE(device, nullptr);

    Runtime *rt = ((Runtime *)Runtime::Instance());
    profiler = rt->profiler_;

    // api prof not enable
    profiler->SetApiProfEnable(false);
    // tasktrace prof enable
    profiler->SetTrackProfEnable(true);

    profiler->apiProfileDecorator_->CallApiBegin(RT_PROF_API_SET_DEVICE);
    profiler->apiProfileDecorator_->CallApiEnd(RT_ERROR_NONE, 0);

    // task track
    profiler->ReportTaskTrack(&kernelTask, 0);
    delete device;
}

TEST_F(ProfilerTest, GetKenerlName)
{
    Runtime *rt = ((Runtime *)Runtime::Instance());
    const Kernel *kernel = NULL;

    rtError_t error;

    uint32_t binary[32];
    rtDevBinary_t devBin;

    void *bin_handle = (void*)NULL;
    static uint32_t stub_func;

    memset_s(&devBin, sizeof(rtDevBinary_t), 0, sizeof(rtDevBinary_t));

    devBin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    devBin.version = 0;
    devBin.data = binary;
    devBin.length = sizeof(binary);

    error = rtDevBinaryRegister(&devBin, &bin_handle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFunctionRegister(bin_handle, &stub_func, "__foo__", NULL, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    kernel = rt->KernelLookup(&stub_func);
    EXPECT_EQ("__foo__", kernel->Name_());

    error = rtDevBinaryUnRegister(bin_handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfilerTest, GetFunctionByName)
{
    rtError_t error;
    void *stubFunc;

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::GetFunctionByName).stubs().will(returnValue(RT_ERROR_NONE));

    error = profiler->apiProfileDecorator_->GetFunctionByName("foo", &stubFunc);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiImpl_;
}

TEST_F(ProfilerTest, QueryFunctionRegistered)
{
    rtError_t error;

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl* api = new ApiImpl();
    MOCKER_CPP_VIRTUAL(api, &ApiImpl::QueryFunctionRegistered).stubs().will(returnValue(RT_ERROR_NONE));

    error = profiler->apiProfileDecorator_->QueryFunctionRegistered("foo");
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete api;
}

TEST_F(ProfilerTest, DatadumpInfoLoad)
{
    rtError_t error;
    uint32_t datdumpinfo[32];

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::DatadumpInfoLoad).stubs().will(returnValue(RT_ERROR_NONE));

    error = profiler->apiProfileDecorator_->DatadumpInfoLoad(datdumpinfo, sizeof(datdumpinfo), RT_KERNEL_DEFAULT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiImpl_;
}

TEST_F(ProfilerTest, MemcpyAsyncPtr)
{
    rtError_t error;

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::MemcpyAsyncPtr).stubs().will(returnValue(RT_ERROR_NONE));

    rtMemcpyAddrInfo memcpyAddrInfo {};
    error = profiler->apiProfileDecorator_->MemcpyAsyncPtr(&memcpyAddrInfo, 0, 0, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiImpl_;
}

TEST_F(ProfilerTest, LaunchKernel)
{
    rtError_t error;
    Kernel * kernel = nullptr;
    uint32_t blockDim = 0;
    rtArgsEx_t argsInfo;
    argsInfo.argsSize = 40960;
    Stream * const stm = nullptr;

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::LaunchKernel).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileDecorator_->LaunchKernel(kernel, blockDim, &argsInfo, stm);
    EXPECT_EQ(error, RT_ERROR_NONE);
    argsInfo.argsSize = 2048;
    error = profiler->apiProfileDecorator_->LaunchKernel(kernel, blockDim, &argsInfo, stm);
    EXPECT_EQ(error, RT_ERROR_NONE);
    argsInfo.argsSize = 100;
    error = profiler->apiProfileDecorator_->LaunchKernel(kernel, blockDim, &argsInfo, stm);
    EXPECT_EQ(error, RT_ERROR_NONE);
    argsInfo.argsSize = 40000;
    error = profiler->apiProfileDecorator_->LaunchKernel(kernel, blockDim, &argsInfo, stm);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
}

TEST_F(ProfilerTest, LabelDestroy)
{
    rtError_t error;
    rtLabel_t label;

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::LabelDestroy).stubs().will(returnValue(RT_ERROR_NONE));

    error = profiler->apiProfileDecorator_->LabelDestroy((Label*)label);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiImpl_;
}

TEST_F(ProfilerTest, StreamMode)
{
    RawDevice * device = new RawDevice(0);
    device->Init();

    Stream * stream = new Stream(device, 0);

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    ApiImpl *apiImpl_ = new ApiImpl();
    uint64_t mode = 0;

    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::StreamSetMode).stubs().will(returnValue(RT_ERROR_NONE));
    profiler->apiProfileDecorator_->StreamSetMode(stream, 0);

    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::StreamGetMode).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = profiler->apiProfileDecorator_->StreamGetMode(stream, &mode);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, NameResource)
{
    rtError_t error;
    rtStream_t stream;
    rtEvent_t event;
    uint16_t name_length;
    char stream_name[16];
    char event_name[16];

    Api *api_ = ((Runtime *)Runtime::Instance())->api_;
    ((Runtime *)Runtime::Instance())->api_ = ((Runtime *)Runtime::Instance())->profiler_->apiProfileDecorator_;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNameStream(stream, "ssstttrrreeeaaam");
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtNameStream(NULL, "stream1");
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtNameStream(stream, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtNameStream(stream, "stream1");
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNameEvent(event, "eeevvveeennnttt1");
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtNameEvent(event, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtNameEvent(event, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtNameEvent(event, "event1");
    EXPECT_EQ(error, RT_ERROR_NONE);

    Event *eventPtr = (Event*)event;
    if (eventPtr->Name_())
    {
        name_length = strlen(eventPtr->Name_());
        strncpy_s(event_name, 16, eventPtr->Name_(), name_length);
        EXPECT_EQ(strcmp(event_name, "event1"), 0);
    }

    ((Runtime *)Runtime::Instance())->api_ = api_;

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfilerTest, FftsPlusTaskLaunch)
{
    rtError_t error;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::FftsPlusTaskLaunch).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileDecorator_->FftsPlusTaskLaunch(nullptr, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
}

TEST_F(ProfilerTest, UnSubscribeReport)
{
    rtError_t error;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    ApiImpl *apiImpl_ = new ApiImpl();
    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);

    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::UnSubscribeReport).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileDecorator_->UnSubscribeReport((uint64_t)pthread_self(), stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, FunctionRegister)
{
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl* apiImpl = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::FunctionRegister).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = profiler->apiProfileDecorator_->FunctionRegister(nullptr, "stubFunc", "stubName", nullptr, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl;
}

TEST_F(ProfilerTest, KernelLaunchWithHandle)
{
    rtError_t error;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    ApiImpl* apiImpl_ = new ApiImpl();
    rtArgsEx_t argsInfo = {};
    argsInfo.args = nullptr;
    argsInfo.argsSize = 4;
    argsInfo.hostInputInfoNum = 4;
    profiler->SetProfLogEnable(true);
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::KernelLaunchWithHandle).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileDecorator_->KernelLaunchWithHandle(nullptr, 0, 1, &argsInfo, nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->KernelLaunchWithHandle(nullptr, 0, 1, &argsInfo, nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
}

TEST_F(ProfilerTest, KernelLaunchWithHandle_40k)
{
    rtError_t error;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    ApiImpl* apiImpl_ = new ApiImpl();
    rtArgsEx_t argsInfo = {};
    argsInfo.args = nullptr;
    argsInfo.argsSize = 40000U;
    argsInfo.hostInputInfoNum = 4;
    profiler->SetProfLogEnable(true);
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::KernelLaunchWithHandle).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileDecorator_->KernelLaunchWithHandle(nullptr, 0, 1, &argsInfo, nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
}

TEST_F(ProfilerTest, KernelLaunch)
{
    rtError_t error;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    ApiImpl* api = new ApiImpl();
    rtArgsEx_t argsInfo = {};
    argsInfo.args = nullptr;
    argsInfo.argsSize = 4;
    argsInfo.hostInputInfoNum = 4;
    profiler->SetProfLogEnable(true);
    MOCKER_CPP_VIRTUAL(api, &ApiImpl::KernelLaunch).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileDecorator_->KernelLaunch(nullptr, 1, &argsInfo, nullptr, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->KernelLaunch(nullptr, 1, &argsInfo, nullptr, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete api;
}

TEST_F(ProfilerTest, KernelLaunch_40k)
{
    rtError_t error;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    ApiImpl* api = new ApiImpl();
    rtArgsEx_t argsInfo = {};
    argsInfo.args = nullptr;
    argsInfo.argsSize = 40000U;
    argsInfo.hostInputInfoNum = 4;
    profiler->SetProfLogEnable(true);
    MOCKER_CPP_VIRTUAL(api, &ApiImpl::KernelLaunch).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileDecorator_->KernelLaunch(nullptr, 1, &argsInfo, nullptr, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete api;
}

TEST_F(ProfilerTest, KernelLaunch_log_false)
{
    rtError_t error;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    ApiImpl* api = new ApiImpl();
    rtArgsEx_t argsInfo = {};
    argsInfo.args = nullptr;
    argsInfo.argsSize = 4;
    argsInfo.hostInputInfoNum = 4;
    profiler->SetProfLogEnable(false);
    MOCKER_CPP_VIRTUAL(api, &ApiImpl::KernelLaunch).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileDecorator_->KernelLaunch(nullptr, 1, &argsInfo, nullptr, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->KernelLaunch(nullptr, 1, &argsInfo, nullptr, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete api;
}

TEST_F(ProfilerTest, KernelLaunchWithHandle_1)
{
    rtError_t error;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    ApiImpl* apiImpl_ = new ApiImpl();
    rtArgsEx_t argsInfo = {};
    argsInfo.args = nullptr;
    argsInfo.argsSize = 1025;
    argsInfo.hostInputInfoNum = 4;
    profiler->SetProfLogEnable(true);
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::KernelLaunchWithHandle).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileDecorator_->KernelLaunchWithHandle(nullptr, 0, 1, &argsInfo, nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->KernelLaunchWithHandle(nullptr, 0, 1, &argsInfo, nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
}

TEST_F(ProfilerTest, KernelLaunchWithHandle_log_false)
{
    rtError_t error;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    ApiImpl* apiImpl_ = new ApiImpl();
    rtArgsEx_t argsInfo = {};
    argsInfo.args = nullptr;
    argsInfo.argsSize = 1025;
    argsInfo.hostInputInfoNum = 4;
    profiler->SetProfLogEnable(false);
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::KernelLaunchWithHandle).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileDecorator_->KernelLaunchWithHandle(nullptr, 0, 1, &argsInfo, nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->KernelLaunchWithHandle(nullptr, 0, 1, &argsInfo, nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
}

TEST_F(ProfilerTest, KernelLaunch_1)
{
    rtError_t error;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    ApiImpl* api = new ApiImpl();
    rtArgsEx_t argsInfo = {};
    argsInfo.args = nullptr;
    argsInfo.argsSize = 1025;
    argsInfo.hostInputInfoNum = 4;
    profiler->SetProfLogEnable(true);
    MOCKER_CPP_VIRTUAL(api, &ApiImpl::KernelLaunch).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileDecorator_->KernelLaunch(nullptr, 1, &argsInfo, nullptr, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->KernelLaunch(nullptr, 1, &argsInfo, nullptr, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete api;
}

TEST_F(ProfilerTest, KernelLaunchWithHandle_2)
{
    rtError_t error;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    ApiImpl* apiImpl_ = new ApiImpl();
    rtArgsEx_t argsInfo = {};
    argsInfo.args = nullptr;
    argsInfo.argsSize = 4097;
    argsInfo.hostInputInfoNum = 4;
    profiler->SetProfLogEnable(true);
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::KernelLaunchWithHandle).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileDecorator_->KernelLaunchWithHandle(nullptr, 0, 1, &argsInfo, nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->KernelLaunchWithHandle(nullptr, 0, 1, &argsInfo, nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
}

TEST_F(ProfilerTest, KernelLaunch_2)
{
    rtError_t error;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    ApiImpl* api = new ApiImpl();
    rtArgsEx_t argsInfo = {};
    argsInfo.args = nullptr;
    argsInfo.argsSize = 4097;
    argsInfo.hostInputInfoNum = 4;
    profiler->SetProfLogEnable(true);
    MOCKER_CPP_VIRTUAL(api, &ApiImpl::KernelLaunch).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileDecorator_->KernelLaunch(nullptr, 1, &argsInfo, nullptr, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->KernelLaunch(nullptr, 1, &argsInfo, nullptr, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete api;
}

TEST_F(ProfilerTest, KernelLaunchWithHandle_FlowCtrl)
{
    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream *stream = new Stream(device, 0);
    stream->SetFlowCtrlFlag();

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    ApiImpl* apiImpl_ = new ApiImpl();
    rtArgsEx_t argsInfo = {};
    argsInfo.args = nullptr;
    argsInfo.argsSize = 4097;
    argsInfo.hostInputInfoNum = 4;
    profiler->SetProfLogEnable(true);
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::KernelLaunchWithHandle).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = profiler->apiProfileDecorator_->KernelLaunchWithHandle(nullptr, 0, 1, &argsInfo, nullptr, stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = profiler->apiProfileLogDecorator_->KernelLaunchWithHandle(nullptr, 0, 1, &argsInfo, nullptr, stream, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, KernelLaunch_FlowCtrl)
{
    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream *stream = new Stream(device, 0);
    stream->SetFlowCtrlFlag();
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    ApiImpl* api = new ApiImpl();
    rtArgsEx_t argsInfo = {};
    argsInfo.args = nullptr;
    argsInfo.argsSize = 4097;
    argsInfo.hostInputInfoNum = 4;
    profiler->SetProfLogEnable(true);
    MOCKER_CPP_VIRTUAL(api, &ApiImpl::KernelLaunch).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = profiler->apiProfileDecorator_->KernelLaunch(nullptr, 1, &argsInfo, nullptr, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->KernelLaunch(nullptr, 1, &argsInfo, nullptr, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete api;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, Stars_Launch)
{
    rtError_t error;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::StarsTaskLaunch).stubs().will(returnValue(RT_ERROR_NONE));

    cce::runtime::rtStarsCommonSqe_t commonSqe = {{0}, {0}};
    commonSqe.sqeHeader.type = RT_STARS_SQE_TYPE_VPC;
    error = profiler->apiProfileDecorator_->StarsTaskLaunch(&commonSqe,
        sizeof(cce::runtime::rtStarsCommonSqe_t), nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiImpl_;
}

TEST_F(ProfilerTest, LaunchKernelV3)
{
    rtError_t error;
    rtArgsEx_t argsInfo = {};
    argsInfo.args = nullptr;
    argsInfo.argsSize = 1025;
    argsInfo.hostInputInfoNum = 4;

    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);
    Api *oldApi_ = const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    error = apiDecorator_->LaunchKernelV3(nullptr, &argsInfo, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    Profiler *profiler = new Profiler(oldApi_);
    profiler->Init();

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::LaunchKernelV3).stubs().will(returnValue(RT_ERROR_NONE));

    error = profiler->apiProfileDecorator_->LaunchKernelV3(nullptr, &argsInfo, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    rtArgsEx_t argsInfo1 = {};
    argsInfo1.args = nullptr;
    argsInfo1.argsSize = 16;
    argsInfo1.hostInputInfoNum = 4;
    error = profiler->apiProfileDecorator_->LaunchKernelV3(nullptr, &argsInfo1, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    rtArgsEx_t argsInfo2 = {};
    argsInfo2.args = nullptr;
    argsInfo2.argsSize = 4097;
    argsInfo2.hostInputInfoNum = 4;
    error = profiler->apiProfileDecorator_->LaunchKernelV3(nullptr, &argsInfo2, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    profiler->SetProfLogEnable(true);
    error = profiler->apiProfileLogDecorator_->LaunchKernelV3(nullptr, &argsInfo, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    profiler->SetProfLogEnable(false);
    error = profiler->apiProfileLogDecorator_->LaunchKernelV3(nullptr, &argsInfo, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    
    delete profiler;
    delete apiDecorator_;
    delete apiImpl_;
    delete stream;
    delete device;
}

class ProfilerLogTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        rtSetDevice(0);
    }

    static void TearDownTestCase()
    {
        rtDeviceReset(0);
    }

    virtual void SetUp()
    {
        rtError_t error = ((Runtime *)Runtime::Instance())->SetMsprofReporterCallback(MsprofReporterCallbackStub);
        EXPECT_EQ(error, ACL_RT_SUCCESS);
    }

    virtual void TearDown()
    {
        //TBD delete all tmp files
        GlobalMockObject::verify();
    }
};

#define PROF_RUNTIME_PROFILE_LOG_MASK        0x00002000

class ProfilerLogFunctionTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtSetDevice(0);
        uint16_t type_log = PROF_RUNTIME_PROFILE_LOG_MASK;
        rtError_t error1 = rtEventCreate(&event_);

        for (uint32_t i = 0; i < sizeof(binary_)/sizeof(uint32_t); i++)
        {
            binary_[i] = i;
        }

        rtDevBinary_t devBin;
        devBin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
        devBin.version = 1;
        devBin.length = sizeof(binary_);
        devBin.data = binary_;
        rtError_t error2 = rtDevBinaryRegister(&devBin, &binHandle_);
        rtError_t error3 = rtFunctionRegister(binHandle_, &function_, "foo", NULL, 0);
    }

    static void TearDownTestCase()
    {
        Context *context = NULL;

        rtError_t error1 = rtEventDestroy(event_);
        rtError_t error2 = rtDevBinaryUnRegister(binHandle_);
        GlobalMockObject::verify();
        rtDeviceReset(0);
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        std::cout << "tear down" << std::endl;
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }

    void AddObserver()
    {
    }

    void DecObserver()
    {
    }

public:
    static rtStream_t stream_;
    static rtEvent_t  event_;
    static void      *binHandle_;
    static char       function_;
    static uint32_t   binary_[32];
};

rtStream_t ProfilerLogFunctionTest::stream_ = NULL;
rtEvent_t ProfilerLogFunctionTest::event_ = NULL;
void* ProfilerLogFunctionTest::binHandle_ = NULL;
char  ProfilerLogFunctionTest::function_ = 'a';
uint32_t ProfilerLogFunctionTest::binary_[32] = {};

TEST_F(ProfilerLogFunctionTest, stream_wait_event_default_stream)
{
    rtError_t error;
    rtStream_t stream;
    rtEvent_t event;

    error = rtEventCreate(&event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventRecord(event, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamWaitEvent(NULL, event);

    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfilerLogFunctionTest, kernel_launch)
{
    rtError_t error;
    void *args[] = {&error, NULL};

    error = rtKernelLaunch(&error, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtKernelLaunch(&function_, 1, NULL, 0, NULL, stream_);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(ProfilerLogFunctionTest, kernel_launch_l2_preload)
{
    rtError_t error;
    rtL2Ctrl_t ctrl;
    void *args[] = {&error, NULL};

    memset_s(&ctrl, sizeof(rtL2Ctrl_t), 0, sizeof(rtL2Ctrl_t));

    ctrl.size = 0;

    /* preload is right */
    ctrl.size = 128;
    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), &ctrl, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfilerLogFunctionTest, kernel_launch_config)
{
    rtSmDesc_t desc;
    rtError_t error;
    void *args[] = {(void*)100, (void*)200};

    //MOCKER(rtKernelLaunch).stubs().will(invoke(kernel_launch_stub));

    desc.size = 128;

    error = rtConfigureCall(1, NULL, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtConfigureCall(1, &desc, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetupArgument(&args[0], sizeof(void*), 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetupArgument(&args[1], sizeof(void*), sizeof(void*));
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetupArgument(NULL, sizeof(void*), 0);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtLaunch(&function_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(ProfilerLogFunctionTest, kernel_launch_ex)
{
    rtError_t error;
    error = rtKernelLaunchEx((void *)1, 1, 0, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfilerLogFunctionTest, kernel_launch_with_default_stream)
{
    rtError_t error;
    void *args[] = {&error, NULL};

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfilerLogFunctionTest, get_device_count)
{
    rtError_t error;
    int32_t count;

    error = rtGetDeviceCount(&count);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfilerLogFunctionTest, get_device_handle)
{
    rtError_t error;
    int32_t handle;

    error = rtGetDevice(&handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfilerLogFunctionTest, set_device_repeat)
{
    rtError_t error;

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfilerLogFunctionTest, get_priority_range)
{
    rtError_t error;
    int32_t leastPriority;
    int32_t greatestPriority;

    error = rtDeviceGetStreamPriorityRange(&leastPriority, &greatestPriority);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfilerLogFunctionTest, device_mem_alloc_free)
{
    rtError_t error;
    void * devPtr;

    error = rtMalloc(&devPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemset(&devPtr, 64, 0, 64);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfilerLogFunctionTest, device_dvpp_mem_alloc_free)
{
    rtError_t error;
    void * devPtr;

    error = rtDvppMalloc(&devPtr, 64, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDvppFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfilerLogFunctionTest, memcpy_host_to_device)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;

    error = rtMalloc(&hostPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpy(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);

    //error = rtMemcpy(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE);
    //EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfilerLogFunctionTest, memcpy_async_host_to_device)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;

    error = rtMalloc(&hostPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpyAsync(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE, stream_);
    //EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemsetAsync(hostPtr, 64, 1, 64, stream_);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfilerLogFunctionTest, memcpy_async_host_to_device_default_stream)
{
    rtError_t error;
    void *hostPtr;
    void *devPtr;

    error = rtMalloc(&hostPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMalloc(&devPtr, 64, RT_MEMORY_HBM, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemcpyAsync(devPtr, 64, hostPtr, 64, RT_MEMCPY_HOST_TO_DEVICE, NULL);
    //EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(devPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtFree(hostPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}



TEST_F(ProfilerLogFunctionTest, dev_sync_null)
{
    int32_t devId;
    rtError_t error;

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(devId);

    error = rtDeviceSynchronize();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceSynchronizeWithTimeout(1);
    // EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsDeviceSynchronize(2);
    // EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSetDevice(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceReset(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(devId);
}

TEST_F(ProfilerLogFunctionTest, dev_sync_ok)
{
    rtError_t error;

    error = rtDeviceSynchronize();
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfilerLogFunctionTest, dev_get_all)
{
    int32_t devId;
    rtError_t error;

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    (RefObject<Context*> *)((Runtime *)Runtime::Instance())->PrimaryContextRetain(devId);

    error = rtGetDevice(&devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(devId, 0);

    error = rtSetDevice(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceReset(devId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    (void)((Runtime *)Runtime::Instance())->PrimaryContextRelease(devId);
}

TEST_F(ProfilerLogFunctionTest, managed_mem)
{
    rtError_t error;
    void *ptr = NULL;

    error = rtMemAllocManaged(&ptr, 128, 0, DEFAULT_MODULEID);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtMemFreeManaged(ptr);
}

TEST_F(ProfilerLogFunctionTest, SET_DEVICE_TEST_1)
{
    rtError_t error;

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfilerLogFunctionTest, SET_DEVICE_TEST_2)
{
    rtError_t error;

    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfilerLogFunctionTest, notify_record_cloud)
{
    rtNotify_t notify;
    rtError_t error;
    int32_t device_id = 0;

    error = rtNotifyCreate(device_id, &notify);
    EXPECT_EQ(error, RT_ERROR_NONE);


    error = rtNotifyRecord(notify, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyWait(notify, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyDestroy(notify);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfilerLogFunctionTest, notify_record_mini)
{
    rtNotify_t notify;
    rtError_t error;
    int32_t device_id = 0;

    error = rtNotifyCreate(device_id, &notify);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyRecord(notify, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyWait(notify, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtNotifyDestroy(notify);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfilerTest, memcpy2dsync_profiler)
{
    void *dst = NULL;
    const void *src = NULL;
    uint64_t count = 10;
    rtMemcpyKind_t kind;

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    rtError_t error = profiler->apiProfileDecorator_->MemCopy2DSync(dst, count, src, count, count, 1, kind);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfilerTest, memcpy2dasync_profiler)
{
    void *dst = NULL;
    const void *src = NULL;
    uint64_t count = 10;
    rtMemcpyKind_t kind;

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    rtError_t error = profiler->apiProfileDecorator_->MemCopy2DAsync(dst, count, src, count, 0, 0, NULL, kind);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfilerTest, tsprofilerstart_profiler)
{
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->TsProfilerStart(0, 0, NULL);
    EXPECT_EQ(profiler->profCfg_.isRtsProfEn, 0);

}

TEST_F(ProfilerTest, tsprofilerstart2_profiler)
{
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->TsProfilerStart(0, 0, NULL, false);
    EXPECT_EQ(profiler->profCfg_.isRtsProfEn, 0);
}

TEST_F(ProfilerTest, tsprofilerstart3_profiler)
{
    GlobalMockObject::verify();
    int32_t devId;
    rtError_t error;
    Context *ctx;

    error = rtGetDevice(&devId);
    RawDevice *device = new RawDevice(0);
    EXPECT_NE(device, nullptr);

    uint64_t tempMem[8];
    device->Init();
    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);

    device->primaryStream_ = stream;
    stream->taskResMang_ = (TaskResManage *)&tempMem;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->TsProfilerStart(0xFF, 0, device);
    EXPECT_EQ(profiler->profCfg_.isRtsProfEn, 0);
    MOCKER_CPP_VIRTUAL(device, &RawDevice::CheckFeatureSupport).stubs().will(returnValue(true));
    profiler->TsProfilerStart(0xFF, 0, device);
    profiler->TsProfilerStart(0xFF, 0, device, false);
    profiler->TsProfilerStop(0xFF, 0, device, false);
    stream->taskResMang_  = nullptr;
    device->primaryStream_ = nullptr;
    delete stream;
    delete device;
    GlobalMockObject::verify();
}

TEST_F(ProfilerTest, tsprofilerstop_profiler)
{
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->TsProfilerStop(0, 0, NULL);
    EXPECT_EQ(profiler->profCfg_.isRtsProfEn, 0);
}

TEST_F(ProfilerTest, tsprofilerstop2_profiler)
{
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->TsProfilerStop(0, 0, NULL, false);
    EXPECT_EQ(profiler->profCfg_.isRtsProfEn, 0);
}

TEST_F(ProfilerTest, tsprofilerstop3_profiler)
{
    GlobalMockObject::verify();
    int32_t devId;
    rtError_t error;
    Context *ctx;

    error = rtGetDevice(&devId);
    RawDevice *device = new RawDevice(0);
    EXPECT_NE(device, nullptr);

    uint64_t tempMem[8];
    device->Init();
    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);

    device->primaryStream_ = stream;
    stream->taskResMang_ = (TaskResManage *)&tempMem;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->TsProfilerStop(0xFF, 0, device);
    EXPECT_EQ(profiler->profCfg_.isRtsProfEn, 0);

    MOCKER_CPP_VIRTUAL(device, &RawDevice::CheckFeatureSupport).stubs().will(returnValue(true));
    profiler->TsProfilerStop(0xFF, 0, device);
    stream->taskResMang_  = nullptr;
    device->primaryStream_ = nullptr;
    delete stream;
    delete device;
    GlobalMockObject::verify();
}

TEST_F(ProfilerTest, DevBinaryRegister_ProfileLog)
{
    uint32_t binary[32];
    rtDevBinary_t devBin;
    devBin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    devBin.version = 1;
    devBin.length = sizeof(binary);
    devBin.data = binary;

    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    rtError_t error = profiler->apiProfileLogDecorator_->DevBinaryRegister(&devBin, &program);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ProfilerTest, AllKernelLaunch_ProfileLog)
{
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::RegisterAllKernel).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = profiler->apiProfileLogDecorator_->RegisterAllKernel(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiImpl_;
}
TEST_F(ProfilerTest, notifyreset_ProfileLog)
{
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::NotifyReset).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = profiler->apiProfileLogDecorator_->NotifyReset(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
}

TEST_F(ProfilerTest, StreamClear_ProfileLog)
{
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::StreamClear).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = profiler->apiProfileLogDecorator_->StreamClear(nullptr, RT_STREAM_STOP);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
}

TEST_F(ProfilerTest, FunctionRegister_ProfileLog)
{
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl* apiImpl = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl, &ApiImpl::FunctionRegister).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = profiler->apiProfileLogDecorator_->FunctionRegister(nullptr, "stubFunc", "stubName", nullptr, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl;
}

TEST_F(ProfilerTest, DatadumpInfoLoad_ProfileLog)
{
    rtError_t error;
    uint32_t datdumpinfo[32];

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::DatadumpInfoLoad).stubs().will(returnValue(RT_ERROR_NONE));

    error = profiler->apiProfileLogDecorator_->DatadumpInfoLoad(datdumpinfo, sizeof(datdumpinfo), RT_KERNEL_DEFAULT);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiImpl_;
}

TEST_F(ProfilerTest, ModelSetSchGroupId_Profile)
{
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::ModelSetSchGroupId).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = profiler->apiProfileDecorator_->ModelSetSchGroupId(nullptr, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
}

TEST_F(ProfilerTest, notifyreset_Profile)
{
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::NotifyReset).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = profiler->apiProfileDecorator_->NotifyReset(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
}

TEST_F(ProfilerTest, StreamClear_Profile)
{
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::StreamClear).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = profiler->apiProfileDecorator_->StreamClear(nullptr, RT_STREAM_STOP);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
}

TEST_F(ProfilerTest, RDMASend_ProfileLog)
{
    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::RDMASend).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = profiler->apiProfileLogDecorator_->RDMASend(0, 0, (Stream *)stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, RdmaDbSend_ProfileLog)
{
    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::RdmaDbSend).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = profiler->apiProfileLogDecorator_->RdmaDbSend(0, 0, (Stream *)stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, StreamDestroy_ProfileLog)
{
    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::StreamSynchronize).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = profiler->apiProfileLogDecorator_->StreamSynchronize((Stream *)stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::StreamDestroy).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileLogDecorator_->StreamDestroy((Stream *)stream, false);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, EventCreate_ProfileLog)
{
    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);

    Event * evt = new Event();
    Event * evt2 = new Event();
    uint32_t evtId = 0;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::EventCreate).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = profiler->apiProfileLogDecorator_->EventCreate(&evt, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::EventCreateForNotify).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileLogDecorator_->EventCreateForNotify(&evt2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::GetEventID).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileLogDecorator_->GetEventID(evt, &evtId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::EventRecord).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileLogDecorator_->EventRecord(evt, (Stream *)stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::EventRecordForNotify).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileLogDecorator_->EventRecordForNotify(evt2, (Stream *)stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::EventDestroy).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileLogDecorator_->EventDestroy(evt);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->EventDestroy(evt2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiImpl_;
    delete evt;
    delete evt2;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, RDMASend_Profiler)
{
    rtError_t error;
    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::RDMASend).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileDecorator_->RDMASend(0, 0, (Stream *)stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, RdmaDbSend_Profiler)
{
    rtError_t error;
    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::RdmaDbSend).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileDecorator_->RdmaDbSend(0, 0, (Stream *)stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, GetNotifyAddress_Profiler)
{
    rtError_t error;
    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::GetNotifyAddress).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileDecorator_->GetNotifyAddress(0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, ContextSetCurrent_ProfilerLog)
{
    rtError_t error;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::ContextSetCurrent).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileLogDecorator_->ContextSetCurrent(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
}

TEST_F(ProfilerTest, ModelBindStream_ProfilerLog)
{
    rtError_t error;
    rtModel_t model;
    rtModelCreate(&model, 0);

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::ModelBindStream).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileLogDecorator_->ModelBindStream((Model *)model, (Stream *)stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, ModelUnbindStream_ProfilerLog)
{
    rtError_t error;
    rtModel_t model;
    rtModelCreate(&model, 0);

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);


    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::ModelUnbindStream).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileLogDecorator_->ModelUnbindStream((Model *)model, (Stream *)stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, ModelExecute_ProfilerLog)
{
    rtError_t error;
    rtModel_t model;
    rtModelCreate(&model, 0);

    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::ModelExecute).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileLogDecorator_->ModelExecute((Model *)model, (Stream *)stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, StreamWaitEvent_ProfilerLog)
{
    rtError_t error;
    rtEvent_t event;

    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);

    error = rtEventCreate(&event);

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::StreamWaitEvent).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileLogDecorator_->StreamWaitEvent((Stream *)stream, (Event *)event, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, NotifyCreate_ProfilerLog)
{
    rtError_t error;
    rtNotify_t *notify;

    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::NotifyCreate).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileLogDecorator_->NotifyCreate(0, ( Notify **)&notify);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, NotifyDestroy_ProfilerLog)
{
    rtError_t error;

    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::NotifyDestroy).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileLogDecorator_->NotifyDestroy(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, NotifyRecord_ProfilerLog)
{
    rtError_t error;

    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::NotifyRecord).stubs().will(returnValue(RT_ERROR_NONE));
    profiler->apiProfileLogDecorator_->NotifyRecord(nullptr, stream);

    rtCmoTaskInfo_t cmoTask = {0};
    rtBarrierTaskInfo_t barrierTask = {0};
    //MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CmoTaskLaunch).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileLogDecorator_->CmoTaskLaunch(&cmoTask,  stream, 0);
    EXPECT_EQ(error, RT_ERROR_STREAM_CONTEXT);

    //MOCKER_CPP_VIRTUAL(apiImpl_,  &ApiImpl::BarrierTaskLaunch).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileLogDecorator_->BarrierTaskLaunch(&barrierTask,  stream, 0);
    EXPECT_EQ(error, RT_ERROR_STREAM_CONTEXT);

    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, CmoAddrTaskLaunch_ProfilerLog)
{
    rtError_t error;
    RawDevice * device = new RawDevice(0);
    device->Init();
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    Stream * stream = new Stream(device, 0);

    ApiImpl *apiImpl_ = new ApiImpl();
    rtCmoAddrInfo cmoAddrTask;
    error = memset_s(&cmoAddrTask, sizeof(rtCmoAddrInfo), 0U, sizeof(rtCmoAddrInfo));
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    uint64_t destMax = sizeof(rtCmoAddrInfo);
    rtCmoOpCode_t cmoOpCode = RT_CMO_PREFETCH;
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CmoAddrTaskLaunch).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileLogDecorator_->CmoAddrTaskLaunch(&cmoAddrTask, destMax, cmoOpCode, stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, MemcpyHostTask_ProfilerLog)
{
    rtError_t error;
    void *hostPtr = (void*)0x41;
    void *devPtr = (void*)0x42;
    uint64_t count = 64*1024*1024+1;
    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::MemcpyHostTask).stubs().will(returnValue(RT_ERROR_NONE));

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    error = profiler->apiProfileLogDecorator_->MemcpyHostTask(devPtr, count, hostPtr, count,
        RT_MEMCPY_DEVICE_TO_DEVICE, (cce::runtime::Stream *)stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    delete apiImpl_;
}

TEST_F(ProfilerTest, ReduceAsync_ProfilerLog)
{
    rtError_t error;
    void *devMemSrc = (void*)0x41;
    void *devMem = (void*)0x42;
    uint64_t count = 100;

    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::ReduceAsync).stubs().will(returnValue(RT_ERROR_NONE));

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    error  = profiler->apiProfileLogDecorator_->ReduceAsync(devMem, devMemSrc, count,
        RT_MEMCPY_SDMA_AUTOMATIC_ADD, RT_DATA_TYPE_FP32, (cce::runtime::Stream *)stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    delete apiImpl_;
}

TEST_F(ProfilerTest, StreamGetMode_ProfilerLog)
{
    rtError_t error;

    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);
    uint64_t mode = 0LLU;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::StreamGetMode).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileLogDecorator_->StreamGetMode(stream, &mode);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, NameStream_ProfilerLog)
{
    rtError_t error;

    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);
    uint64_t mode = 0LLU;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    error = profiler->apiProfileLogDecorator_->NameStream(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete stream;
    delete device;
}

TEST_F(ProfilerTest, NameEvent_ProfilerLog)
{
    rtError_t error;

    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);
    uint64_t mode = 0LLU;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    error = profiler->apiProfileLogDecorator_->NameEvent(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete stream;
    delete device;
}

TEST_F(ProfilerTest, GetDevArgsAddr_ProfilerLog)
{
    rtError_t error;
    rtArgsEx_t *argsInfo = nullptr;
    void *devArgsAddr = nullptr;
    void *argsHandle = nullptr;
    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::GetDevArgsAddr).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileLogDecorator_->GetDevArgsAddr(stream, argsInfo, &devArgsAddr, &argsHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = profiler->apiProfileDecorator_->GetDevArgsAddr(stream, argsInfo, &devArgsAddr, &argsHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, ModelTaskUpdate001)
{
    rtError_t error;
    uint32_t streamId = 1;
    uint32_t taskId = 0;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    RawDevice * device = new RawDevice(0);
    device->Init();

    Stream * desStm = new Stream(device, 0);
    Stream * sinkStm = new Stream(device, 0);
    uint32_t desTaskId = 1;
    rtMdlTaskUpdateInfo_t para;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::ModelTaskUpdate).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileDecorator_->ModelTaskUpdate(desStm, desTaskId, sinkStm, &para);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete desStm;
    delete sinkStm;
    delete apiImpl_;
    delete device;
}

TEST_F(ProfilerTest, EventCreateEx)
{
    rtError_t error;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    Event *event = nullptr;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::EventCreateEx).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileLogDecorator_->EventCreateEx(&event, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
}

TEST_F(ProfilerTest, AicpuInfoLoad001)
{
    rtError_t error;
    uint32_t streamId = 1;
    uint32_t taskId = 0;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    RawDevice * device = new RawDevice(0);
    device->Init();

    Stream * desStm = new Stream(device, 0);
    Stream * sinkStm = new Stream(device, 0);
    uint32_t desTaskId = 1;
    char aicpu_info[16] = "aicpu info";

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::AicpuInfoLoad).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileDecorator_->AicpuInfoLoad(aicpu_info, 16);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete desStm;
    delete sinkStm;
    delete apiImpl_;
    delete device;
}

TEST_F(ProfilerTest, get_srvid_by_sdid_test)
{
    rtError_t error;
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    Api* apiImpl_ = new ApiImpl();
    uint32_t sdid = 0x66660000U;
    uint32_t srvid = 0;
    profiler->apiProfileDecorator_->GetServerIDBySDID(sdid, &srvid);
    error = profiler->apiProfileLogDecorator_->GetServerIDBySDID(sdid, &srvid);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetApiProfEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, GetCntNotifyAddress)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::GetCntNotifyAddress).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileLogDecorator_->GetCntNotifyAddress(NULL, NULL, NOTIFY_CNT_ST_SLICE);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, WriteValue)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::WriteValue).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileLogDecorator_->WriteValue(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, CntNotifyWaitWithTimeout)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CntNotifyWaitWithTimeout).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileLogDecorator_->CntNotifyWaitWithTimeout(NULL, NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, CntNotifyCreate)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CntNotifyCreate).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileLogDecorator_->CntNotifyCreate(0, NULL, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, CntNotifyDestroy)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CntNotifyDestroy).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileLogDecorator_->CntNotifyDestroy(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, CntNotifyRecord)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CntNotifyRecord).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileLogDecorator_->CntNotifyRecord(NULL, NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, CntNotifyReset)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CntNotifyReset).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileLogDecorator_->CntNotifyReset(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, UbDbSend)
{
    rtError_t error;
    rtUbDbInfo_t dbInfo;
    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::UbDbSend).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileDecorator_->UbDbSend(&dbInfo, (Stream *)stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, UbDbSend_ProfileLog)
{
    rtError_t error;
    rtUbDbInfo_t dbInfo;
    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::UbDbSend).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileLogDecorator_->UbDbSend(&dbInfo, (Stream *)stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, UbDirectSend)
{
    rtError_t error;
    rtUbWqeInfo_t wqeInfo;
    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::UbDirectSend).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileDecorator_->UbDirectSend(&wqeInfo, (Stream *)stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, UbDirectSend_ProfileLog)
{
    rtError_t error;
    rtUbWqeInfo_t wqeInfo;
    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::UbDirectSend).stubs().will(returnValue(RT_ERROR_NONE));
    error = profiler->apiProfileLogDecorator_->UbDirectSend(&wqeInfo, (Stream *)stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, CCULaunchProfi)
{
    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream *stream = new Stream(device, 0);
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    rtCcuTaskInfo_t info = {0};
    info.argSize = RT_CCU_SQE_ARGS_LEN;

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CCULaunch).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = profiler->apiProfileDecorator_->CCULaunch(&info, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->CCULaunch(&info, stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, fusion_kernel_launch_profile)
{
    rtError_t error;
    rtFusionArgsEx_t argsInfo = {};
    rtFunsionTaskInfo_t fusionInfo = {};

    RawDevice * device = new RawDevice(0);
    device->Init();
    Stream * stream = new Stream(device, 0);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    Api *oldApi_ = const_cast<Api *>(Runtime::runtime_->api_);
    ApiDecorator *apiDecorator_ = new ApiDecorator(oldApi_);
    error = apiDecorator_->FusionLaunch(&fusionInfo, (Stream *)stream, &argsInfo);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
    Profiler *profiler = new Profiler(oldApi_);
    profiler->Init();

    ApiImpl *apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::FusionLaunch).stubs().will(returnValue(RT_ERROR_NONE));

    error = profiler->apiProfileDecorator_->FusionLaunch(&fusionInfo, (Stream *)stream, &argsInfo);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
    profiler->SetProfLogEnable(true);
    error = profiler->apiProfileLogDecorator_->FusionLaunch(&fusionInfo, (Stream *)stream, &argsInfo);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);
    profiler->SetProfLogEnable(false);
    error = profiler->apiProfileLogDecorator_->FusionLaunch(&fusionInfo, (Stream *)stream, &argsInfo);
    EXPECT_EQ(error, RT_ERROR_FEATURE_NOT_SUPPORT);

    delete profiler;
    delete apiDecorator_;
    delete apiImpl_;
    delete stream;
    delete device;
}

TEST_F(ProfilerTest, RegisterAllKernel)
{
    uint32_t binary[32];
    rtDevBinary_t devBin;
    devBin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    devBin.version = 1;
    devBin.length = sizeof(binary);
    devBin.data = binary;
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::RegisterAllKernel).stubs().will(returnValue(RT_ERROR_NONE));

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    auto error = profiler->apiProfileDecorator_->RegisterAllKernel(&devBin, &program);
    profiler->SetApiProfEnable(false);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiImpl_;
}

TEST_F(ProfilerTest, BuffGetInfo)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::BuffGetInfo).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    auto error = profiler->apiProfileDecorator_->BuffGetInfo(RT_BUFF_GET_MBUF_BUILD_INFO, NULL, 0, NULL, NULL);
    profiler->SetApiProfEnable(false);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
}

TEST_F(ProfilerTest, BinaryLoad)
{
    uint32_t binary[32];
    rtDevBinary_t devBin;
    devBin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    devBin.version = 1;
    devBin.length = sizeof(binary);
    devBin.data = binary;
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::BinaryLoad).stubs().will(returnValue(RT_ERROR_NONE));

    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    auto error = profiler->apiProfileDecorator_->BinaryLoad(&devBin, &program);
    profiler->SetApiProfEnable(false);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete apiImpl_;
}

TEST_F(ProfilerTest, BinaryLoad_02)
{
    uint32_t binary[32];
    rtDevBinary_t devBin;
    devBin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    devBin.version = 1;
    devBin.length = sizeof(binary);
    devBin.data = binary;
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    ApiImpl* apiImpl_ = new ApiImpl();
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    NpuDriver drv;

    MOCKER_CPP_VIRTUAL(drv,&NpuDriver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    auto error = profiler->apiProfileDecorator_->BinaryLoad(&devBin, &program);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    profiler->SetApiProfEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, BinaryLoad_03)
{
    uint32_t binary[32];
    rtDevBinary_t devBin;
    devBin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    devBin.version = 1;
    devBin.length = sizeof(binary);
    devBin.data = binary;
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    ApiImpl* apiImpl_ = new ApiImpl();
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    NpuDriver drv;
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemCopySync)
        .stubs()
        .will(returnValue(RT_ERROR_DEVICE_NULL));
    auto error = profiler->apiProfileDecorator_->BinaryLoad(&devBin, &program);
    EXPECT_EQ(error, RT_ERROR_DEVICE_NULL);
    profiler->SetApiProfEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, BinaryGetFunction)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::BinaryGetFunction).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    auto error = profiler->apiProfileDecorator_->BinaryGetFunction(NULL, 1, NULL);
    profiler->SetApiProfEnable(false);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
}

TEST_F(ProfilerTest, BinaryUnLoad)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::BinaryUnLoad).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    auto error = profiler->apiProfileDecorator_->BinaryUnLoad(NULL);
    profiler->SetApiProfEnable(false);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
}

TEST_F(ProfilerTest, DevMallocCached)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::DevMallocCached).stubs().will(returnValue(RT_ERROR_NONE));
    void *m_ptr = NULL;
    uint64_t m_size = 100 * sizeof(uint32_t);
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    auto error = profiler->apiProfileDecorator_->DevMallocCached(&m_ptr, m_size, 2);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetApiProfEnable(false);
    profiler->SetProfLogEnable(true);
    error = profiler->apiProfileLogDecorator_->DevMallocCached(&m_ptr, m_size, 2);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, ReduceAsyncV2)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::ReduceAsyncV2).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    auto error = profiler->apiProfileDecorator_->ReduceAsyncV2(NULL, NULL, 1, RT_MEMCPY_SDMA_AUTOMATIC_ADD, RT_DATA_TYPE_FP32, NULL, NULL);
    profiler->SetApiProfEnable(false);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
}

TEST_F(ProfilerTest, ReduceAsyncV2_CLOUD)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::ReduceAsyncV2).stubs().will(returnValue(RT_ERROR_NONE));
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    Profiler *profiler = rtInstance->profiler_;
    profiler->SetApiProfEnable(true);


    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_REDUCE_V2_ID);

    auto error = profiler->apiProfileDecorator_->ReduceAsyncV2(NULL, NULL, 1, RT_MEMCPY_SDMA_AUTOMATIC_ADD, RT_DATA_TYPE_FP32, NULL, NULL);
    profiler->SetApiProfEnable(false);
    EXPECT_EQ(error, RT_ERROR_NONE);
    device->SetTschVersion(version);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
    delete apiImpl_;
}

TEST_F(ProfilerTest, IpcOpenNotify)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::IpcOpenNotify).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    auto error = profiler->apiProfileDecorator_->IpcOpenNotify(NULL, "test_ipc");
    profiler->SetApiProfEnable(false);
    profiler->SetProfLogEnable(true);
    error = profiler->apiProfileLogDecorator_->IpcOpenNotify(NULL, "test_ipc");
    profiler->SetProfLogEnable(false);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    delete apiImpl_;
}

TEST_F(ProfilerTest, SubscribeReport)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::SubscribeReport).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    auto error = profiler->apiProfileDecorator_->SubscribeReport(0, NULL);
    profiler->SetApiProfEnable(false);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
}

TEST_F(ProfilerTest, CallbackLaunch)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CallbackLaunch).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    auto error = profiler->apiProfileDecorator_->CallbackLaunch(NULL, NULL, NULL, true);
    profiler->SetApiProfEnable(false);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
}

TEST_F(ProfilerTest, ProcessReport)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::ProcessReport).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    auto error = profiler->apiProfileDecorator_->ProcessReport(0);
    profiler->SetApiProfEnable(false);
    profiler->SetProfLogEnable(true);
    error = profiler->apiProfileLogDecorator_->ProcessReport(0);
    profiler->SetProfLogEnable(false);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete apiImpl_;
}

TEST_F(ProfilerTest, CtxSysParamOptTest)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CtxSetSysParamOpt).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CtxGetSysParamOpt).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetApiProfEnable(true);
    auto error = profiler->apiProfileDecorator_->CtxSetSysParamOpt(SYS_OPT_DETERMINISTIC, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->CtxGetSysParamOpt(SYS_OPT_DETERMINISTIC, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetApiProfEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, KernelFusionTest)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::KernelFusionStart).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::KernelFusionEnd).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileLogDecorator_->KernelFusionStart(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->KernelFusionEnd(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, LaunchTest)
{
    rtError_t error;
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CmoTaskLaunch).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::BarrierTaskLaunch).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::KernelLaunchEx).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::MultipleTaskInfoLaunch).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;

    profiler->SetApiProfEnable(true);
    error = profiler->apiProfileDecorator_->CmoTaskLaunch(NULL, NULL, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->BarrierTaskLaunch(NULL, NULL, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetApiProfEnable(false);
    profiler->SetProfLogEnable(true);
    error = profiler->apiProfileLogDecorator_->KernelLaunchEx("", (void *)1, 1, 0, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->MultipleTaskInfoLaunch(NULL, NULL, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, DevDvppTest)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::DevDvppMalloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::DevDvppFree).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileLogDecorator_->DevDvppMalloc(NULL, 1, 0, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->DevDvppFree(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, HostMemTest)
{
    void *hostPtr;
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::HostMalloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::HostFree).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileLogDecorator_->HostMalloc(&hostPtr, 64);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->HostFree(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, ManagedMemTest)
{
    void *hostPtr;
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::ManagedMemAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::ManagedMemFree).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileLogDecorator_->ManagedMemAlloc(&hostPtr, 1, 0, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->ManagedMemFree(NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, MemCpyTest)
{
    void *hostPtr;
    void *devPtr;
    uint64_t memsize = 64*1024*1024+1;
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::MemcpyAsync).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::MemCopy2DSync).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::MemCopy2DAsync).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileLogDecorator_->MemcpyAsync(devPtr, memsize, hostPtr, memsize, RT_MEMCPY_HOST_TO_DEVICE, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->MemCopy2DSync(devPtr, 100, hostPtr, 100, 10, 1, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->MemCopy2DAsync(devPtr, 100, hostPtr, 100, 10, 1, NULL, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, MemSetTest)
{
    void *devPtr;
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::MemSetSync).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::MemsetAsync).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileLogDecorator_->MemSetSync(devPtr, 60, 0, 60);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->MemsetAsync(devPtr, 60, 0, 60, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, LableTest)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::LabelSwitchByIndex).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::LabelGotoEx).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::LabelListCpy).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileLogDecorator_->LabelSwitchByIndex(NULL, 2, NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->LabelGotoEx(NULL, NULL);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->LabelListCpy(NULL, 0, NULL, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, OnlineProfMallocTest)
{
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    EXPECT_NE(device, nullptr);
    RawDevice *dev = dynamic_cast<RawDevice *>(device);
    EXPECT_NE(dev, nullptr);
    NpuDriver *drv = dynamic_cast<NpuDriver *>(dev->driver_);
    EXPECT_NE(drv, nullptr);
    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::MemSetSync).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::DevMemFlushCache).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::HostMemAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::HostMemFree).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(memset_s).stubs().will(returnValue(EOK)).then(returnValue(EOK - 1));
    auto error = OnlineProf::OnlineProfMalloc(stream);
    EXPECT_NE(error, RT_ERROR_NONE);
    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ProfilerTest, OnlineProfFreeTest)
{
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    EXPECT_NE(device, nullptr);
    RawDevice *dev = dynamic_cast<RawDevice *>(device);
    EXPECT_NE(dev, nullptr);
    NpuDriver *drv = dynamic_cast<NpuDriver *>(dev->driver_);
    EXPECT_NE(drv, nullptr);
    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(drv, &NpuDriver::HostMemFree).stubs().will(returnValue(RT_ERROR_NONE));
    auto error = OnlineProf::OnlineProfFree(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ProfilerTest, GetOnlineProfilingDataTest)
{
    uint8_t deviceMem[512];
    uint8_t hostRtMem[512];
    uint8_t hostTsMem[512];
    Device* device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    EXPECT_NE(device, nullptr);
    RawDevice *dev = dynamic_cast<RawDevice *>(device);
    EXPECT_NE(dev, nullptr);
    NpuDriver *drv = dynamic_cast<NpuDriver *>(dev->driver_);
    EXPECT_NE(drv, nullptr);
    Stream *stream = new Stream(device, 0);
    EXPECT_NE(stream, nullptr);
    stream->SetOnProfDeviceAddr((void *)&deviceMem);
    stream->SetOnProfHostRtAddr((void *)&hostRtMem);
    stream->SetOnProfHostTsAddr((void *)&hostTsMem);
    rtProfDataInfo_t pProfData = {0};
    auto error = OnlineProf::GetOnlineProfilingData(stream, &pProfData, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    delete stream;
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ProfilerTest, ProfileDecoratorKernelApiTest)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::MetadataRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::DependencyRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::KernelFusionStart).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::KernelFusionEnd).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CpuKernelLaunch).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CpuKernelLaunchExWithArgs).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::MultipleTaskInfoLaunch).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileDecorator_->MetadataRegister(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->DependencyRegister(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->KernelFusionStart(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->KernelFusionEnd(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->CpuKernelLaunch(nullptr, 0, nullptr, nullptr, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtAicpuArgsEx_t aicpuArgs = {0};
    error = profiler->apiProfileDecorator_->CpuKernelLaunchExWithArgs(nullptr, 0, &aicpuArgs, nullptr, nullptr, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->MultipleTaskInfoLaunch(nullptr, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, ProfileDecoratorNotifyApiTest)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CntNotifyCreate).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CntNotifyDestroy).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CntNotifyRecord).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CntNotifyReset).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CntNotifyWaitWithTimeout).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::GetCntNotifyAddress).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::EventCreateForNotify).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::EventRecordForNotify).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::GetEventID).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileDecorator_->CntNotifyCreate(0, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->CntNotifyDestroy(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->CntNotifyRecord(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->CntNotifyReset(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->CntNotifyWaitWithTimeout(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->GetCntNotifyAddress(nullptr, nullptr, NOTIFY_TABLE_SLICE);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->EventCreateForNotify(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->EventRecordForNotify(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->GetEventID(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, ProfileDecoratorMemApiTest)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::HostMalloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::HostFree).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::ReduceAsync).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::GetRunMode).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CmoAddrTaskLaunch).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CtxGetOverflowAddr).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileDecorator_->HostMalloc(nullptr, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->HostFree(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->ReduceAsync(nullptr, nullptr, 0, RT_MEMCPY_SDMA_AUTOMATIC_ADD, RT_DATA_TYPE_FP32, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->GetRunMode(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->CmoAddrTaskLaunch(nullptr, 0, RT_CMO_PREFETCH, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->CtxGetOverflowAddr(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, ProfileDecoratorDeviceApiTest)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::GetDeviceSatStatus).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CleanDeviceSatStatus).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::GetLogicDevIdByUserDevId).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::MemWriteValue).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::MemWaitValue).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::LaunchHostFunc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::WriteValue).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::ModelExecuteSync).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileDecorator_->GetDeviceSatStatus(nullptr, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->CleanDeviceSatStatus(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->GetLogicDevIdByUserDevId(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->MemWriteValue(nullptr, 0, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->MemWaitValue(nullptr, 0, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->LaunchHostFunc(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->WriteValue(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileDecorator_->ModelExecuteSync(nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, ProfileLogDecoratorBinaryApiTest)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::DevBinaryUnRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::MetadataRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::DependencyRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::BinaryLoad).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::BinaryGetFunction).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::BinaryGetFunctionByName).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::BinaryUnLoad).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileLogDecorator_->DevBinaryUnRegister(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->MetadataRegister(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->DependencyRegister(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->BinaryLoad(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->BinaryGetFunction(nullptr, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->BinaryGetFunctionByName(nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->BinaryUnLoad(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, ProfileLogDecoratorKernelApiTest)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CpuKernelLaunch).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CpuKernelLaunchExWithArgs).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::LaunchKernel).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::AicpuInfoLoad).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileLogDecorator_->CpuKernelLaunch(nullptr, 0, nullptr, nullptr, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->CpuKernelLaunchExWithArgs(nullptr, 0, nullptr, nullptr, nullptr, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->LaunchKernel(nullptr, 0, nullptr, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->AicpuInfoLoad(nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, ProfileLogDecoratorMemApiTest)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::GetNotifyAddress).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::BuffGetInfo).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, 
    static_cast<rtError_t (ApiImpl::*)(void ** const, const uint64_t, const rtMemType_t, const uint16_t)>(
        &ApiImpl::DevMalloc)).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::DevFree).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::ReduceAsyncV2).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileLogDecorator_->GetNotifyAddress(nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->BuffGetInfo(RT_BUFF_GET_MBUF_TIMEOUT_INFO, nullptr, 0, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->DevMalloc(nullptr, 0, 0, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->DevFree(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->MemCopySync(nullptr, 0, nullptr, 0, RT_MEMCPY_HOST_TO_HOST, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->ReduceAsyncV2(nullptr, nullptr, 0, RT_MEMCPY_SDMA_AUTOMATIC_ADD, RT_DATA_TYPE_FP32, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, ProfileLogDecoratorStreamApiTest)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::StreamCreate).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::StreamSetMode).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileLogDecorator_->StreamCreate(nullptr, 0, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->StreamSetMode(nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, ProfileLogDecoratorDeviceApiTest)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::SetDevice).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::DeviceReset).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::DeviceResetForce).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::ContextCreate).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::ContextDestroy).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CtxSetSysParamOpt).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CtxGetSysParamOpt).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CtxGetOverflowAddr).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::GetDeviceSatStatus).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CleanDeviceSatStatus).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::GetLogicDevIdByUserDevId).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::GetUserDevIdByLogicDevId).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileLogDecorator_->SetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->DeviceReset(0, true);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->DeviceResetForce(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->ContextCreate(nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->ContextDestroy(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->CtxSetSysParamOpt(SYS_OPT_DETERMINISTIC, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->CtxGetSysParamOpt(SYS_OPT_DETERMINISTIC, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->CtxGetOverflowAddr(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->GetDeviceSatStatus(nullptr, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->CleanDeviceSatStatus(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->GetLogicDevIdByUserDevId(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->GetUserDevIdByLogicDevId(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, ProfileLogDecoratorNormalApiTest)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::EventSynchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::NotifyWait).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::CallbackLaunch).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::GetRunMode).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::SubscribeReport).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::UnSubscribeReport).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::MemWriteValue).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::MemWaitValue).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::MemcpyBatchAsync).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileLogDecorator_->EventSynchronize(nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->NotifyWait(nullptr, nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->CallbackLaunch(nullptr, nullptr, nullptr, false);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->GetRunMode(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->SubscribeReport(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->UnSubscribeReport(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->MemWriteValue(nullptr, 0, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->MemWaitValue(nullptr, 0, 0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->MemcpyBatchAsync(nullptr, nullptr, nullptr, nullptr, 0, nullptr, nullptr, 0, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}

TEST_F(ProfilerTest, ProfileLogDecoratorModelApiTest)
{
    ApiImpl* apiImpl_ = new ApiImpl();
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::ModelCreate).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::ModelDestroy).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::ModelExecuteSync).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::ModelSetSchGroupId).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(apiImpl_, &ApiImpl::ModelTaskUpdate).stubs().will(returnValue(RT_ERROR_NONE));
    Profiler *profiler = ((Runtime *)Runtime::Instance())->profiler_;
    profiler->SetProfLogEnable(true);
    auto error = profiler->apiProfileLogDecorator_->ModelCreate(nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->ModelDestroy(nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->ModelExecuteSync(nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->ModelSetSchGroupId(nullptr, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = profiler->apiProfileLogDecorator_->ModelTaskUpdate(nullptr, 0, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    profiler->SetProfLogEnable(false);
    delete apiImpl_;
}