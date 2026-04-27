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
#include "async_hwts_engine.hpp"
#include "task_res.hpp"
#include "stars.hpp"
#include "npu_driver.hpp"
#include "api_error.hpp"
#include "event.hpp"
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "notify.hpp"
#include "profiler.hpp"
#include "api_profile_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "device_state_callback_manager.hpp"
#include "task_fail_callback_manager.hpp"
#include "model.hpp"
#include "subscribe.hpp"
#include "rdma_task.h"
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include "thread_local_container.hpp"
#include "rt_unwrap.h"
#undef protected
#undef private

using namespace testing;
using namespace cce::runtime;

class CloudV2ApiAbnormalTest : public testing::Test
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
        GlobalContainer::SetHardwareSocVersion("Ascend910B1");
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        oldChipType = rtInstance->GetChipType();
        (void)rtSetDevice(0);
    }

    virtual void TearDown()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(oldChipType);
        GlobalMockObject::verify();
        rtDeviceReset(0);
    }
private:
    rtChipType_t oldChipType;
};

TEST_F(CloudV2ApiAbnormalTest, rtsGetMemcpyDescSizeTest)
{
    rtError_t error;
    char oriSocVersion[128] = {0};
    rtGetSocVersion(oriSocVersion, 128);
    (void)rtSetSocVersion("Ascend910B1");
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    error = rtsGetMemcpyDescSize(RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
    rtSetSocVersion(oriSocVersion);
    ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
}

TEST_F(CloudV2ApiAbnormalTest, rtsMemcpyAsyncWithDescTest)
{
    rtError_t error;
    char desc[32];
    error = rtsMemcpyAsyncWithDesc(desc, RT_MEMCPY_KIND_HOST_TO_HOST, nullptr, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, rtsGetMemcpyDescSize_NonDavidChip_Success)
{
    rtError_t error;
    size_t size;
    char oriSocVersion[128] = {0};
    rtGetSocVersion(oriSocVersion, 128);
    (void)rtSetSocVersion("Ascend910B1");
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    
    error = rtsGetMemcpyDescSize(RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE, &size);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(size, MEMCPY_DESC_SIZE);
    rtSetSocVersion(oriSocVersion);
    ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
}

TEST_F(CloudV2ApiAbnormalTest, rtMemcpyAsyncPtrAbnormal)
{
    rtError_t error;
    char srcPtr[64];
    error = rtMemcpyAsyncPtr(srcPtr, 64, 64, RT_MEMCPY_HOST_TO_HOST, nullptr, 0);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, rtReduceAsyncV2Abnormal)
{
    rtError_t error;
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    EXPECT_NE(rtInstance, nullptr);
    error = rtReduceAsyncV2(nullptr, 0, nullptr, 0, RT_MEMCPY_SDMA_AUTOMATIC_ADD, RT_DATA_TYPE_FP32, nullptr, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, rtFftsPlusTaskLaunchAbnormal)
{
    rtError_t error;
    error = rtFftsPlusTaskLaunch(nullptr, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, rtNpuGetFloatStatusAbnormal)
{
    rtError_t error;
    error = rtNpuGetFloatStatus(nullptr, 0, 0, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST(RdmaPiValueModifyTaskTest, ConstructSqeRdmaPiValueModifyTaskSuccess)
{
    Stream *stream = static_cast<Stream *>(malloc(sizeof(Stream)));
    ASSERT_NE(stream, nullptr);
    (void)memset_s(stream, sizeof(Stream), 0, sizeof(Stream));
    stream->streamId_ = 7;

    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.id = 123U;
    taskInfo.u.rdmaPiValueModifyInfo.funCallMemAddrAlign = reinterpret_cast<void *>(0x12345000UL);

    MOCKER(PrintSqe).stubs();

    rtStarsSqe_t command = {};
    ConstructSqeRdmaPiValueModifyTask(&taskInfo, &command);

    const RtStarsFunctionCallSqe &sqe = command.fuctionCallSqe;
    EXPECT_EQ(sqe.kernel_credit, RT_STARS_DEFAULT_KERNEL_CREDIT);
    EXPECT_EQ(sqe.csc, 1U);
    EXPECT_EQ(sqe.sqeHeader.type, RT_STARS_SQE_TYPE_COND);
    EXPECT_EQ(sqe.sqeHeader.l1_lock, 0U);
    EXPECT_EQ(sqe.sqeHeader.l1_unlock, 0U);
    EXPECT_EQ(sqe.sqeHeader.block_dim, 0U);
    EXPECT_EQ(sqe.sqeHeader.rt_stream_id, static_cast<uint16_t>(taskInfo.stream->Id_()));
    EXPECT_EQ(sqe.sqeHeader.task_id, taskInfo.id);
    EXPECT_EQ(sqe.conds_sub_type, CONDS_SUB_TYPE_PI_VALUE_MODIFY);

    free(stream);
    GlobalMockObject::verify();
}

TEST(RdmaPiValueModifyTaskTest, RdmaPiValueModifyTaskUnInitSuccess)
{
    (void)rtSetSocVersion("Ascend910B1");
    ASSERT_EQ(rtSetDevice(0), RT_ERROR_NONE);
    Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
    ASSERT_NE(rtInstance, nullptr);
    Device *device = rtInstance->DeviceRetain(0, 0);
    ASSERT_NE(device, nullptr);
    Stream *stream = static_cast<Stream *>(malloc(sizeof(Stream)));
    ASSERT_NE(stream, nullptr);
    (void)memset_s(stream, sizeof(Stream), 0, sizeof(Stream));
    stream->device_ = device;
    stream->streamId_ = 8;

    TaskInfo taskInfo = {};
    taskInfo.stream = stream;
    taskInfo.u.rdmaPiValueModifyInfo.funCallMemAddr = reinterpret_cast<void *>(0x12345000UL);
    taskInfo.u.rdmaPiValueModifyInfo.funCallMemAddrAlign = reinterpret_cast<void *>(0x12346000UL);
    taskInfo.u.rdmaPiValueModifyInfo.dfxAddr = reinterpret_cast<void *>(0x12347000UL);
    taskInfo.u.rdmaPiValueModifyInfo.rdmaSubContextCount = 2U;

    MOCKER_CPP_VIRTUAL(taskInfo.stream->Device_()->Driver_(), &Driver::DevMemFree)
        .stubs()
        .with(mockcpp::any(), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));

    RdmaPiValueModifyTaskUnInit(&taskInfo);

    EXPECT_EQ(taskInfo.u.rdmaPiValueModifyInfo.funCallMemAddr, nullptr);
    EXPECT_EQ(taskInfo.u.rdmaPiValueModifyInfo.funCallMemAddrAlign, nullptr);
    EXPECT_EQ(taskInfo.u.rdmaPiValueModifyInfo.dfxAddr, nullptr);
    EXPECT_EQ(taskInfo.u.rdmaPiValueModifyInfo.rdmaSubContextCount, 0U);

    free(stream);
    rtInstance->DeviceRelease(device);
    (void)rtDeviceReset(0);
    ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
    GlobalMockObject::verify();
}

TEST(RdmaPiValueModifyTaskTest, PrintDfxInfoForRdmaPiValueModifyTaskCountNotifyReturn)
{
    TaskInfo taskInfo = {};
    taskInfo.u.notifywaitTask.isCountNotify = true;
    taskInfo.u.notifywaitTask.u.notify = nullptr;

    MOCKER(CheckLogLevel).stubs().will(returnValue(1));

    PrintDfxInfoForRdmaPiValueModifyTask(&taskInfo, 0);

    GlobalMockObject::verify();
}

TEST(RdmaPiValueModifyTaskTest, PrintDfxInfoForRdmaPiValueModifyTaskSuccess)
{
    std::string socVersion = GlobalContainer::GetHardwareSocVersion();
    GlobalContainer::SetSocVersion("Ascend910B2");
    GlobalContainer::SetHardwareSocVersion("Ascend910B2");

    rtContext_t ctx = nullptr;
    ASSERT_EQ(rtCtxCreate(&ctx, 0, 0), RT_ERROR_NONE);
    Context *curCtx = static_cast<Context *>(ctx);

    rtStream_t stream = nullptr;
    rtError_t ret = rtStreamCreate(&stream, 0);
    ASSERT_EQ(ret, RT_ERROR_NONE);
    Stream *stm = rt_ut::UnwrapOrNull<Stream>(stream);

    CaptureModel *captureModel = new CaptureModel();
    ASSERT_NE(captureModel, nullptr);
    curCtx->models_.push_back(captureModel);
    captureModel->context_ = curCtx;
    captureModel->InsertRdmaPiValueModifyInfo(1, 1);

    TaskInfo piValueModifyTask = {};
    piValueModifyTask.type = TS_TASK_TYPE_RDMA_PI_VALUE_MODIFY;
    piValueModifyTask.stream = stm;
    void *funCallMemAddr = malloc(sizeof(uint64_t));
    void *funCallMemAddrAlign = malloc(sizeof(uint64_t));
    void *dfxAddr = malloc(sizeof(uint64_t));
    piValueModifyTask.u.rdmaPiValueModifyInfo.funCallMemAddr = funCallMemAddr;
    piValueModifyTask.u.rdmaPiValueModifyInfo.funCallMemAddrAlign = funCallMemAddrAlign;
    piValueModifyTask.u.rdmaPiValueModifyInfo.dfxAddr = dfxAddr;
    piValueModifyTask.u.rdmaPiValueModifyInfo.rdmaSubContextCount = 1;

    std::vector<uint64_t> rdmaPiValueInfo{1};
    MOCKER(CheckLogLevel).stubs().will(returnValue(1));
    MOCKER_CPP(&TaskFactory::GetTask).stubs().with(mockcpp::any(), mockcpp::any()).will(returnValue(&piValueModifyTask));
    MOCKER_CPP_VIRTUAL(stm->Device_()->Driver_(), &Driver::MemCopySync).stubs().with(outBoundP(static_cast<void *>(rdmaPiValueInfo.data()), sizeof(uint64_t)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any()).will(returnValue(RT_ERROR_NONE));

    Notify notify(0, 0);
    notify.endGraphModel_ = captureModel;

    TaskInfo taskInfo = {};
    taskInfo.stream = stm;
    taskInfo.u.notifywaitTask.isCountNotify = false;
    taskInfo.u.notifywaitTask.u.notify = &notify;

    PrintDfxInfoForRdmaPiValueModifyTask(&taskInfo, 0);

    ret = rtStreamDestroy(stream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    captureModel->streams_.clear();
    delete captureModel;
    curCtx->models_.clear();
    ret = rtCtxDestroy(ctx);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    GlobalContainer::SetHardwareSocVersion(socVersion);
    GlobalMockObject::verify();
}

// rts prefix api
TEST_F(CloudV2ApiAbnormalTest, rtsNpuClearFloatOverFlowStatus)
{
    rtError_t error;
    error = rtsNpuClearFloatOverFlowStatus(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, rtsNpuGetFloatOverFlowStatus)
{
    rtError_t error;
    error = rtsNpuGetFloatOverFlowStatus(nullptr, 0, 0, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, rtsNpuGetFloatOverFlowDebugStatus)
{
    rtError_t error;
    error = rtsNpuGetFloatOverFlowDebugStatus(nullptr, 0, 0, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, rtsNpuClearFloatOverFlowDebugStatus)
{
    rtError_t error;
    error = rtsNpuClearFloatOverFlowDebugStatus(0, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, rtGetBinaryDeviceBaseAddrAbnormal)
{
    rtError_t error;
    error = rtGetBinaryDeviceBaseAddr(nullptr, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, rtIpcSetMemoryNameAbnormal)
{
    rtError_t error;
    error = rtIpcSetMemoryName(nullptr, 0, nullptr, 0);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, rtIpcCloseMemoryAbnormal)
{
    rtError_t error;
    error = rtIpcCloseMemory(nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, rtsLaunchReduceAsyncTaskAbnormal)
{
    rtError_t error;
    error = rtsLaunchReduceAsyncTask(nullptr, nullptr, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, rtReduceAsyncTaskAbnormal)
{
    rtError_t ret;
    void *dst = nullptr;
    uint64_t destMax;
    void *src = nullptr;
    uint64_t cnt;
    rtRecudeKind_t kind;
    rtDataType_t dataType;
    rtStream_t stream;
    ret = rtReduceAsync(dst, destMax, src, cnt, kind, dataType, stream);
    EXPECT_NE(ret, RT_ERROR_NONE);

    uint32_t qosCfg;
    ret = rtReduceAsyncWithCfg(dst, destMax, src, cnt, kind, dataType, stream, qosCfg);
    EXPECT_NE(ret, RT_ERROR_NONE);

    rtTaskCfgInfo_t *cfgInfo = nullptr;
    ret = rtReduceAsyncWithCfgV2(dst, destMax, src, cnt, kind, dataType, stream, cfgInfo);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, event_work_abnormal)
{
    rtError_t error;

    error = rtEventWorkModeGet(nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, cm0_task_abnormal)
{
    rtError_t error;
    rtCmoTaskCfg_t cmoTaskCfg = {};

    cmoTaskCfg.cmoType = RT_CMO_RESERVED;
    error = rtsLaunchCmoTask(&cmoTaskCfg, nullptr, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, cntNotify_abnormal)
{
    rtError_t ret = RT_ERROR_NONE;
    rtCntNotify_t inNotify;
    rtCntNotifyWaitInfo_t waitInfo = {RT_CNT_NOTIFY_WAIT_EQUAL_MODE, 0, 10, false};
    rtCntNotifyRecordInfo_t recordInfo = {RT_CNT_NOTIFY_RECORD_ADD_MODE, 0U};
    uint32_t notifyId = 0;
    ret = rtCntNotifyCreate(0, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtCntNotifyCreateWithFlag(0, nullptr, 0);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtCntNotifyRecord(nullptr, nullptr, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtCntNotifyWaitWithTimeout(nullptr, nullptr, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtCntNotifyReset(nullptr, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtCntNotifyDestroy(nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtGetCntNotifyAddress(nullptr, nullptr, NOTIFY_TYPE_MAX);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtGetCntNotifyId(nullptr, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtCntNotifyCreateServer(&inNotify, 0);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret =  rtsCntNotifyRecord(inNotify, nullptr, &recordInfo);
 	EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtsCntNotifyWaitWithTimeout(inNotify, nullptr, &waitInfo);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtsCntNotifyReset(inNotify, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtCntNotifyReset(inNotify, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtCntNotifyDestroy(inNotify);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtsCntNotifyGetId(inNotify, &notifyId);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, ubDb_abnormal)
{
    rtError_t ret = RT_ERROR_NONE;
    ret = rtUbDbSend(nullptr, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtUbDirectSend(nullptr, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtFusionLaunch(nullptr, nullptr, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtCCULaunch(nullptr, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtUbDevQueryInfo(QUERY_TYPE_BUFF, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, devRes_abnormal)
{
    rtError_t ret = RT_ERROR_NONE;
    ret = rtGetDevResAddress(nullptr, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
    ret = rtReleaseDevResAddress(nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, taskbuffer_abnormal)
{ 
    rtError_t ret = RT_ERROR_NONE;
    rtTaskBuffType_t type;
    uint32_t bufferLen;
    ret = rtGetTaskBufferLen(type, &bufferLen);
    EXPECT_NE(ret, RT_ERROR_NONE);

    rtTaskInput_t taskInput;
    uint32_t taskLen;
    ret = rtTaskBuild(&taskInput, &taskLen);
    EXPECT_NE(ret, RT_ERROR_NONE);

    void *elfData = nullptr;
    uint32_t elfLen;
    uint32_t offset;
    ret = rtGetElfOffset(elfData, elfLen, &offset);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, rtGetStreamBufferLen_abnormal)
{ 
    const bool isHuge = true;
    uint32_t * const bufferLen = nullptr;
    rtError_t ret = rtGetStreamBufferLen(isHuge, bufferLen);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, rtIpcDestroyMemoryName_abnormal)
{ 
    rtError_t ret = RT_ERROR_NONE;
    ret = rtIpcDestroyMemoryName(nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, debug_abnormal)
{
    rtError_t error;
    std::vector<uint8_t> data(8192U);
    rtDebugMemoryParam param = {};
    param.debugMemType = RT_DEBUG_MEM_TYPE_L0A;
    param.coreType = RT_CORE_TYPE_AIC;
    param.coreId = 0U;
    param.elementSize = 0U;
    param.srcAddr = 0U;
    param.dstAddr = reinterpret_cast<uint64_t>(data.data());
    param.memLen = 8192U;

    error = rtDebugSetDumpMode(RT_DEBUG_DUMP_ON_EXCEPTION);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtDebugGetStalledCore(nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtDebugReadAICore(nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtsDebugReadAICore(&param);
 	EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, rtsGetErrorVerbosefault_abnormal)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    MOCKER(halGetFaultEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_INVALID_VALUE));
    rtErrorInfo errorInfo = {};
    error = rtsGetErrorVerbose(0, &errorInfo);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, rtsRepairError_abnormal)
{
    rtError_t error;

    error = rtsRepairError(0, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, ModelDebugJsonPrint_Error)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtModel_t captureMdl;
    rtCallback_t stub_func = (rtCallback_t)0x12345;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();

    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));

    error = rtModelDebugJsonPrint(nullptr, "graph_dump.json", 0);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, rtMemcpyAsyncWithOffset_Error)
{
    rtError_t error;

    error = rtMemcpyAsyncWithOffset(nullptr, 0, 0, nullptr, 0, 0, RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, rtSnapShotProcessGetStateTest)
{
    rtError_t error;
    rtProcessState state;

    error = rtSnapShotProcessGetState(&state);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtSnapShotProcessGetState(nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiAbnormalTest, rtFreeKernelBinAbnormal)
{
    rtError_t error;
    error = rtFreeKernelBin(nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, rtEschedQueryInfoAbnormal)
{
    rtError_t error;
    error = rtEschedQueryInfo(0, RT_QUERY_TYPE_LOCAL_GRP_ID, nullptr, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, rtNpuClearFloatStatusAbnormal)
{
    rtError_t error;
    error = rtNpuClearFloatStatus(0, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, rtsMemcpyAsyncTest)
{
    rtError_t error;
    char srcPtr[64];
    char dstPtr[64];
    Api *api = Api::Instance();
    MOCKER_CPP_VIRTUAL(api, &Api::RtsMemcpyAsync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = rtsMemcpyAsync(srcPtr, 64, dstPtr, 64, RT_MEMCPY_KIND_HOST_TO_HOST, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, rtsMemcpyTest)
{
    rtError_t error;
    char srcPtr[64];
    char dstPtr[64];
    Api *api = Api::Instance();
    MOCKER_CPP_VIRTUAL(api, &Api::RtsMemcpy)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    error = rtsMemcpy(srcPtr, 64, dstPtr, 64, RT_MEMCPY_KIND_HOST_TO_HOST, nullptr);
    
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, RtsMemcpyAsyncTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    ApiDecorator apiDecorator(&impl);
    uint32_t srcPtr[64];
    uint32_t dstPtr[64];
    uint64_t count = 64;
    rtMemcpyAttribute_t attr;
    memset_s(&attr, sizeof(attr), 0, sizeof(attr));
    rtMemcpyConfig_t config;
    config.attrs = &attr;
    config.numAttrs = 1;
    MOCKER_CPP_VIRTUAL(api, &ApiErrorDecorator::MemcpyAsync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::PointerGetAttributes)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    rtError_t error = api.RtsMemcpyAsync(dstPtr, count, srcPtr, count, RT_MEMCPY_KIND_DEVICE_TO_DEVICE, &config, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
    attr.value.checkBitmap = 1;
    attr.id = RT_MEMCPY_ATTRIBUTE_CHECK;
    error = api.RtsMemcpyAsync(dstPtr, count, srcPtr, count, RT_MEMCPY_KIND_DEVICE_TO_DEVICE, &config, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = api.RtsMemcpyAsync(dstPtr, count, srcPtr, count, RT_MEMCPY_KIND_DEVICE_TO_DEVICE, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = api.RtsMemcpyAsync(dstPtr, count, srcPtr, count, RT_MEMCPY_KIND_INTER_DEVICE_TO_DEVICE, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    error = impl.RtsMemcpyAsync(dstPtr, count, srcPtr, count, RT_MEMCPY_KIND_INTER_DEVICE_TO_DEVICE, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = apiDecorator.RtsMemcpyAsync(dstPtr, count, srcPtr, count, RT_MEMCPY_KIND_INTER_DEVICE_TO_DEVICE, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, SetMemcpyDescTest)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    ApiDecorator apiDecorator(&impl);
    char desc[1024];
    void * descPtr = (void *)((((uint64_t)desc + 64)/64)*64);
    uint32_t srcPtr[64];
    uint32_t dstPtr[64];
    uint64_t count = 64;
    rtPointerAttributes_t attr;
    memset_s(&attr, sizeof(attr), 0, sizeof(attr));
    attr.locationType = RT_MEMORY_LOC_DEVICE;
    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::PointerGetAttributes)
        .stubs()
        .with(outBoundP(&attr))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&ApiImpl::CurrentContext)
            .stubs()
            .will(returnValue((Context*)nullptr));
    rtError_t error = api.SetMemcpyDesc(descPtr, dstPtr, srcPtr, count, RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = api.SetMemcpyDesc(descPtr, dstPtr, srcPtr, count, RT_MEMCPY_KIND_DEVICE_TO_DEVICE, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = apiDecorator.SetMemcpyDesc(descPtr, dstPtr, srcPtr, count, RT_MEMCPY_KIND_DEVICE_TO_DEVICE, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = impl.SetMemcpyDesc(descPtr, dstPtr, srcPtr, count, RT_MEMCPY_KIND_DEVICE_TO_DEVICE, nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, rtMemcpyAsyncExAbnormal)
{
    rtError_t error = rtMemcpyAsyncEx(NULL, 0U, NULL, 0U, RT_MEMCPY_DEVICE_TO_DEVICE, NULL, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(CloudV2ApiAbnormalTest, rtDevBinaryRegister_Null)
{
    rtError_t error;
    void *handle;
    error = rtDevBinaryRegister(NULL, &handle);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, GetHostAtomicCapabilities_ApiErrorDecorator)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    uint32_t caps[1];
    rtAtomicOperation ops[1] = {RT_ATOMIC_OPERATION_INTEGER_ADD};

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetHostAtomicCapabilities)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    EXPECT_EQ(api.GetHostAtomicCapabilities(caps, ops, 1, 0), RT_ERROR_NONE);

    EXPECT_EQ(api.GetHostAtomicCapabilities(nullptr, ops, 1, 0), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(api.GetHostAtomicCapabilities(caps, nullptr, 1, 0), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(api.GetHostAtomicCapabilities(caps, ops, 0, 0), RT_ERROR_INVALID_VALUE);
    
    rtAtomicOperation invalidOps[1] = {static_cast<rtAtomicOperation>(999)};
    EXPECT_EQ(api.GetHostAtomicCapabilities(caps, invalidOps, 1, 0), RT_ERROR_INVALID_VALUE);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    MOCKER_CPP_VIRTUAL(rtInstance, &Runtime::ChgUserDevIdToDeviceId)
        .stubs()
        .will(returnValue(RT_ERROR_DEVICE_ID));
    EXPECT_EQ(api.GetHostAtomicCapabilities(caps, ops, 1, 255), RT_ERROR_DEVICE_ID); // Invalid device id
}

TEST_F(CloudV2ApiAbnormalTest, GetP2PAtomicCapabilities_ApiErrorDecorator)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    uint32_t caps[1];
    rtAtomicOperation ops[1] = {RT_ATOMIC_OPERATION_INTEGER_ADD};

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetP2PAtomicCapabilities)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
    EXPECT_EQ(api.GetP2PAtomicCapabilities(caps, ops, 1, 0, 1), RT_ERROR_NONE);

    EXPECT_EQ(api.GetP2PAtomicCapabilities(nullptr, ops, 1, 0, 1), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(api.GetP2PAtomicCapabilities(caps, nullptr, 1, 0, 1), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(api.GetP2PAtomicCapabilities(caps, ops, 0, 0, 1), RT_ERROR_INVALID_VALUE);
    
    rtAtomicOperation invalidOps[1] = {static_cast<rtAtomicOperation>(999)};
    EXPECT_EQ(api.GetP2PAtomicCapabilities(caps, invalidOps, 1, 0, 1), RT_ERROR_INVALID_VALUE);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    MOCKER_CPP_VIRTUAL(rtInstance, &Runtime::ChgUserDevIdToDeviceId)
        .stubs()
        .will(returnValue(RT_ERROR_DEVICE_ID));

    EXPECT_EQ(api.GetP2PAtomicCapabilities(caps, ops, 1, 0, 0), RT_ERROR_DEVICE_ID); // src == dst
    EXPECT_EQ(api.GetP2PAtomicCapabilities(caps, ops, 1, 255, 1), RT_ERROR_DEVICE_ID); // invalid src
    EXPECT_EQ(api.GetP2PAtomicCapabilities(caps, ops, 1, 0, 255), RT_ERROR_DEVICE_ID); // invalid dst
}

TEST_F(CloudV2ApiAbnormalTest, GetAtomicCapabilities_ApiDecorator_Forwarding)
{
    ApiImpl impl;
    ApiDecorator api(&impl);
    uint32_t caps[1];
    rtAtomicOperation ops[1] = {RT_ATOMIC_OPERATION_INTEGER_ADD};

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetHostAtomicCapabilities)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));
        
    EXPECT_EQ(api.GetHostAtomicCapabilities(caps, ops, 1, 0), RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetP2PAtomicCapabilities)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(api.GetP2PAtomicCapabilities(caps, ops, 1, 0, 1), RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, GetAtomicCapabilities_ApiProfileDecorator)
{
    ApiImpl impl;
    Profiler profiler(nullptr);
    ApiProfileDecorator api(&impl, &profiler);
    uint32_t caps[1];
    rtAtomicOperation ops[1] = {RT_ATOMIC_OPERATION_INTEGER_ADD};

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetHostAtomicCapabilities)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(api.GetHostAtomicCapabilities(caps, ops, 1, 0), RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetP2PAtomicCapabilities)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(api.GetP2PAtomicCapabilities(caps, ops, 1, 0, 1), RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, GetAtomicCapabilities_ApiProfileLogDecorator)
{
    ApiImpl impl;
    Profiler profiler(nullptr);
    ApiProfileLogDecorator api(&impl, &profiler);
    uint32_t caps[1];
    rtAtomicOperation ops[1] = {RT_ATOMIC_OPERATION_INTEGER_ADD};

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetHostAtomicCapabilities)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(api.GetHostAtomicCapabilities(caps, ops, 1, 0), RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::GetP2PAtomicCapabilities)
        .stubs()
        .will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(api.GetP2PAtomicCapabilities(caps, ops, 1, 0, 1), RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, CacheLastTaskExtendInfo_ApiDecorator_Forwarding)
{
    ApiImpl impl;
    ApiDecorator api(&impl);
    char extendInfo[] = "extend_info";
    const size_t infoSize = sizeof(extendInfo) - 1U;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::CacheLastTaskExtendInfo).stubs().will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(api.CacheLastTaskExtendInfo(extendInfo, infoSize), RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, CacheLastTaskExtendInfo_ApiErrorDecorator)
{
    ApiImpl impl;
    ApiErrorDecorator api(&impl);
    char extendInfo[] = "extend_info";
    const size_t infoSize = sizeof(extendInfo) - 1U;

    EXPECT_EQ(api.CacheLastTaskExtendInfo(nullptr, infoSize), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(api.CacheLastTaskExtendInfo(extendInfo, 0U), RT_ERROR_INVALID_VALUE);

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::CacheLastTaskExtendInfo)
        .stubs()
        .with(mockcpp::any(), eq(static_cast<size_t>(4096U)))
        .will(returnValue(RT_ERROR_NONE));
    EXPECT_EQ(api.CacheLastTaskExtendInfo(extendInfo, 5000U), RT_ERROR_NONE);

    GlobalMockObject::verify();

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::CacheLastTaskExtendInfo).stubs().will(returnValue(RT_ERROR_NONE));
    EXPECT_EQ(api.CacheLastTaskExtendInfo(extendInfo, infoSize), RT_ERROR_NONE);
}

TEST_F(CloudV2ApiAbnormalTest, CacheLastTaskExtendInfo_ApiProfileDecorator)
{
    ApiImpl impl;
    Profiler profiler(nullptr);
    ApiProfileDecorator api(&impl, &profiler);
    char extendInfo[] = "extend_info";
    const size_t infoSize = sizeof(extendInfo) - 1U;

    MOCKER_CPP_VIRTUAL(impl, &ApiImpl::CacheLastTaskExtendInfo).stubs().will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(api.CacheLastTaskExtendInfo(extendInfo, infoSize), RT_ERROR_NONE);
}
