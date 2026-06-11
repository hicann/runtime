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
#include "ascend_inpackage_hal.h"
#include "prof_dev_api.h"
#include "error_code.h"
#include "devprof_drv_adprof.h"
//#include "aicpu_report_hdc.h"
#include "devprof_common.h"
#include "config.h"
#include "utils.h"
#include "devprof_drv_aicpu.h"
#include "transport/hash_data.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace Devprof;

extern int32_t ProfStartAicpu(struct prof_sample_start_para *para);
extern int32_t ProfStopAicpu(struct prof_sample_stop_para *para);

extern int32_t ProfStartAdprof(struct prof_sample_start_para *para);
extern int32_t ProfSampleAdprof(struct prof_sample_para *para);
extern int32_t ProfStopAdprof(struct prof_sample_stop_para *para);

class DEVPROF_DRV_UTEST : public testing::Test {
protected:
    virtual void SetUp()
    {
        GlobalMockObject::verify();
    }
    virtual void TearDown()
    {}
};

static void SetupHostMoveBufferInfo(Devprof::AicpuUserProfileBufferInfo &info,
    uint8_t *buffer, uint32_t bufferSize, uint32_t *wptr, uint32_t *rptr)
{
    info.buffer_size = bufferSize;
    info.buffer_base_user_va = reinterpret_cast<uint64_t>(buffer);
    info.buffer_read_ptr_user_va = reinterpret_cast<uint64_t>(rptr);
    info.buffer_write_ptr_user_va = reinterpret_cast<uint64_t>(wptr);
}

TEST_F(DEVPROF_DRV_UTEST, ProfStartHostMove_OutDataNull)
{
    DevprofDrvAicpu::instance()->Reset();
    ProfSampleStartPara startPara = {0};
    startPara.is_support_host_move = 1;
    startPara.out_data = nullptr;
    startPara.out_data_max_len = sizeof(Devprof::AicpuUserProfileBufferInfo);
    EXPECT_EQ(PROFILING_FAILED, ProfStartAicpu(&startPara));
    EXPECT_FALSE(DevprofDrvAicpu::instance()->IsSupportHostMove());

    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ProfStartHostMove_OutDataMaxLenTooSmall)
{
    DevprofDrvAicpu::instance()->Reset();
    uint8_t dummyBuffer[16];
    ProfSampleStartPara startPara = {0};
    startPara.is_support_host_move = 1;
    startPara.out_data = dummyBuffer;
    startPara.out_data_max_len = 16;
    EXPECT_EQ(PROFILING_FAILED, ProfStartAicpu(&startPara));
    EXPECT_FALSE(DevprofDrvAicpu::instance()->IsSupportHostMove());

    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ProfStartHostMove_InvalidBufferSize)
{
    DevprofDrvAicpu::instance()->Reset();
    Devprof::AicpuUserProfileBufferInfo invalidInfo = {0};
    invalidInfo.buffer_size = 0;
    ProfSampleStartPara startPara = {0};
    startPara.is_support_host_move = 1;
    startPara.out_data = &invalidInfo;
    startPara.out_data_max_len = sizeof(Devprof::AicpuUserProfileBufferInfo);
    EXPECT_EQ(PROFILING_FAILED, ProfStartAicpu(&startPara));
    EXPECT_FALSE(DevprofDrvAicpu::instance()->IsSupportHostMove());

    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ProfStartHostMove_InvalidBaseAddr)
{
    DevprofDrvAicpu::instance()->Reset();
    Devprof::AicpuUserProfileBufferInfo invalidInfo = {0};
    invalidInfo.buffer_size = 4 * 1024 * 1024;
    invalidInfo.buffer_base_user_va = 0;
    ProfSampleStartPara startPara = {0};
    startPara.is_support_host_move = 1;
    startPara.out_data = &invalidInfo;
    startPara.out_data_max_len = sizeof(Devprof::AicpuUserProfileBufferInfo);
    EXPECT_EQ(PROFILING_FAILED, ProfStartAicpu(&startPara));
    EXPECT_FALSE(DevprofDrvAicpu::instance()->IsSupportHostMove());

    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ProfStartHostMove_Success)
{
    DevprofDrvAicpu::instance()->Reset();
    MOCKER(OsalCreateTaskWithThreadAttr).stubs().will(returnValue(0));
    MOCKER(OsalJoinTask).stubs().will(returnValue(0));

    uint8_t *buffer = new uint8_t[4 * 1024 * 1024];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, 4 * 1024 * 1024, &wptrVal, &rptrVal);
    ProfSampleStartPara startPara = {0};
    startPara.is_support_host_move = 1;
    startPara.out_data = &info;
    startPara.out_data_max_len = sizeof(Devprof::AicpuUserProfileBufferInfo);
    EXPECT_EQ(PROFILING_SUCCESS, ProfStartAicpu(&startPara));
    EXPECT_TRUE(DevprofDrvAicpu::instance()->IsSupportHostMove());

    prof_sample_stop_para stopPara = {0};
    stopPara.release_flag = 2;
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAicpu(&stopPara));
    delete[] buffer;
    GlobalMockObject::verify();
}

static int32_t ProfStartFailed()
{
    return PROFILING_FAILED;
}

static int32_t ProfStartSuccess()
{
    return PROFILING_SUCCESS;
}

static void AdprofExit()
{
    return;
}

TEST_F(DEVPROF_DRV_UTEST, AdprofAicpuStartRegister)
{
    AicpuStartPara aicpuStartPara = {0, 111, 1, 0};
    EXPECT_EQ(PROFILING_SUCCESS, AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara));
    aicpuStartPara.profConfig = 2;  // aicpu = on

    EXPECT_EQ(PROFILING_FAILED, AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara));
    aicpuStartPara.channelId = 143;

    MOCKER(halProfSampleRegister)
        .stubs()
        .will(returnValue(1))
        .then(returnValue((int)DRV_ERROR_NONE));
    EXPECT_EQ(PROFILING_FAILED, AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara));

    MOCKER(ProfSendEvent)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara));
    EXPECT_EQ(PROFILING_SUCCESS, AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara));

    aicpuStartPara.profConfig = ADPROF_TASK_TIME_L0 | ADPROF_TASK_TIME_L1 | ADPROF_TASK_TIME_L2;
    EXPECT_EQ(PROFILING_SUCCESS, AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara));
    EXPECT_EQ(0, AdprofCheckFeatureIsOn(ADPROF_TASK_TIME_L0));
    EXPECT_EQ(0, AdprofCheckFeatureIsOn(ADPROF_TASK_TIME_L1));
    EXPECT_EQ(0, AdprofCheckFeatureIsOn(ADPROF_TASK_TIME_L2));
    constexpr uint32_t START_SWITCH = 1U;
    aicpuStartPara.profConfig |= START_SWITCH;
    EXPECT_EQ(PROFILING_SUCCESS, AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara));
    EXPECT_EQ(1, AdprofCheckFeatureIsOn(ADPROF_TASK_TIME_L0));
    EXPECT_EQ(1, AdprofCheckFeatureIsOn(ADPROF_TASK_TIME_L1));
    EXPECT_EQ(1, AdprofCheckFeatureIsOn(ADPROF_TASK_TIME_L2));
}

TEST_F(DEVPROF_DRV_UTEST, AdprofAicpuStartRegister_Multi) {
    MOCKER(halProfSampleRegister)
        .stubs()
        .will(returnValue((int)DRV_ERROR_NONE))
        .then(returnValue(-1));
    MOCKER(halProfSampleRegisterEx)
        .stubs()
        .will(returnValue((int)DRV_ERROR_NONE));

    MOCKER(ProfSendEvent)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED));

    AicpuStartPara aicpuStartPara = {0, 111, 143, 2};
    std::vector<std::thread> th;
    for (int i = 0; i < 10; i++) {
        th.push_back(std::thread([this, &aicpuStartPara]() -> void {
            EXPECT_EQ(PROFILING_SUCCESS, AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara));
        }));
    }
    for_each(th.begin(), th.end(), std::mem_fn(&std::thread::join));
}

TEST_F(DEVPROF_DRV_UTEST, ProfSendEvent) {
    uint32_t devId = 0;
    int32_t hostPid = 123;
    char *grpName = "aicpu_grp";

    MOCKER(halEschedQueryInfo)
        .stubs()
        .will(repeat(1, 10))
        .then(returnValue(DRV_ERROR_NONE));
    EXPECT_EQ(PROFILING_FAILED, ProfSendEvent(devId, hostPid, grpName));
    
    MOCKER(halEschedSubmitEvent)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(DRV_ERROR_NONE));
    EXPECT_EQ(PROFILING_FAILED, ProfSendEvent(devId, hostPid, grpName));
    EXPECT_EQ(PROFILING_SUCCESS, ProfSendEvent(devId, hostPid, grpName));
}

TEST_F(DEVPROF_DRV_UTEST, ReportData) {
    AicpuStartPara aicpuStartPara = {0, 111, 143, 0};
    EXPECT_EQ(PROFILING_SUCCESS, AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara));
    aicpuStartPara.profConfig = 2U | 1U | ADPROF_TASK_TIME_L0;  // aicpu = on
    MOCKER(ProfSendEvent)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_SUCCESS, AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara));
    EXPECT_EQ(1, AdprofCheckFeatureIsOn(ADPROF_TASK_TIME_L0));

    ProfSampleStartPara startPara = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfStartAicpu(&startPara));
    OsalSleep(20);

    MsprofAdditionalInfo additionalInfo;
    additionalInfo.level = 0;
    additionalInfo.type = 0;
    additionalInfo.threadId = 0;
    additionalInfo.dataLen = 4;
    additionalInfo.timeStamp = 1000;
    memset(additionalInfo.data, 0, MSPROF_ADDTIONAL_INFO_DATA_LENGTH);
    memcpy(additionalInfo.data, "test", additionalInfo.dataLen);

    int32_t ret = AdprofReportAdditionalInfo(0, static_cast<void *>(&additionalInfo), sizeof(MsprofAdditionalInfo) - 1);
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = AdprofReportAdditionalInfo(0, static_cast<void *>(&additionalInfo), sizeof(MsprofAdditionalInfo));
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    uint32_t maxCount = REPORT_BUFF_SIZE / sizeof(MsprofAdditionalInfo);
    for (uint32_t i = 0; i < maxCount + 2; i++) {
        AdprofReportAdditionalInfo(0, static_cast<void *>(&additionalInfo), sizeof(MsprofAdditionalInfo));
    }

    prof_sample_stop_para stopPara = {0};
    ret = ProfStopAicpu(&stopPara);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
    EXPECT_EQ(0, AdprofCheckFeatureIsOn(ADPROF_TASK_TIME_L0));
}

TEST_F(DEVPROF_DRV_UTEST, ProfStartAicpuError)
{
    AicpuStartPara aicpuStartPara = {0, 111, 143, 2};
    EXPECT_EQ(PROFILING_SUCCESS, AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara));

    MOCKER(halProfSampleDataReport).stubs().will(returnValue(-1));
    uint32_t bufLen = 1024 * 1024;
    MOCKER(halProfQueryAvailBufLen)
        .stubs()
        .with(any(), any(), outBoundP(&bufLen, sizeof(bufLen)))
        .will(repeat(0, 3))
        .then(returnValue(-1));

    MsprofAdditionalInfo additionalInfo;
    AdprofReportAdditionalInfo(1, static_cast<void *>(&additionalInfo), sizeof(MsprofAdditionalInfo));
    prof_sample_start_para startPara = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfStartAicpu(&startPara));   // halProfSampleDataReport error
    prof_sample_stop_para stopPara = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAicpu(&stopPara));

    AdprofReportAdditionalInfo(1, static_cast<void *>(&additionalInfo), sizeof(MsprofAdditionalInfo));
    EXPECT_EQ(PROFILING_SUCCESS, ProfStartAicpu(&startPara));   // halProfQueryAvailBufLen 2 error
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAicpu(&stopPara));

    EXPECT_EQ(PROFILING_SUCCESS, ProfStartAicpu(&startPara));   // halProfQueryAvailBufLen 1 error
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAicpu(&stopPara));

    MOCKER(OsalCreateTaskWithThreadAttr).stubs().will(returnValue(-1));
    EXPECT_EQ(PROFILING_FAILED, ProfStartAicpu(&startPara));    // create thread error
}

TEST_F(DEVPROF_DRV_UTEST, DevprofDrvAdprof)
{
    AdprofCallBack adprofCallBack = {ProfStartFailed, ProfStartFailed, AdprofExit};
    MOCKER(halProfSampleRegister)
        .stubs()
        .will(returnValue(1))
        .then(returnValue((int)DRV_ERROR_NONE));
    MOCKER(halProfSampleRegisterEx)
        .stubs()
        .will(returnValue((int)DRV_ERROR_NONE));
    EXPECT_EQ(PROFILING_FAILED, AdprofStartRegister(adprofCallBack, 0, 123));
    EXPECT_EQ(PROFILING_SUCCESS, AdprofStartRegister(adprofCallBack, 0, 123));

    prof_sample_start_para startPara = {0};
    EXPECT_EQ(PROFILING_FAILED, ProfStartAdprof(&startPara));

    adprofCallBack = {ProfStartSuccess, ProfStartSuccess, AdprofExit};
    EXPECT_EQ(PROFILING_SUCCESS, AdprofStartRegister(adprofCallBack, 0, 123));
    EXPECT_EQ(PROFILING_SUCCESS, ProfStartAdprof(&startPara));

    analysis::dvvp::ProfileFileChunk fileChunk;
    fileChunk.isLastChunk = false;
    fileChunk.chunkModule = PROFILING_IS_FROM_DEVICE;
    fileChunk.offset = -1;
    fileChunk.chunk = "test file chunk";
    fileChunk.chunkSize = fileChunk.chunk.length();
    fileChunk.fileName = "test_file";
    fileChunk.extraInfo = "test_info";
    fileChunk.id = "test_id";
    EXPECT_EQ(PROFILING_SUCCESS, ReportAdprofFileChunk(static_cast<void *>(&fileChunk)));

    prof_sample_para samplePara = {0};
    samplePara.dev_id = 0;
    samplePara.sample_flag = 0;
    samplePara.buff_len = 102400;
    samplePara.report_len = 0;
    samplePara.buff = malloc(samplePara.buff_len);
    EXPECT_EQ(PROFILING_SUCCESS, ProfSampleAdprof(&samplePara));
    EXPECT_EQ(sizeof(ProfTlv), samplePara.report_len);
    free(samplePara.buff);

    uint32_t maxCount = REPORT_BUFF_SIZE / sizeof(ProfTlv);
    for (uint32_t i = 0; i < maxCount + 2; i++) {
        ReportAdprofFileChunk(static_cast<void *>(&fileChunk));
    }

    prof_sample_stop_para stopPara = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAdprof(&stopPara));
    EXPECT_EQ(PROFILING_FAILED, ReportAdprofFileChunk(static_cast<void *>(&fileChunk)));
}

TEST_F(DEVPROF_DRV_UTEST, AdprofGetHashId)
{
    MOCKER(Devprof::ProfSendEvent).stubs().will(returnValue(PROFILING_SUCCESS));

    AicpuStartPara aicpuStartPara = {0, 111, 143, 2};  // aicpu = on
    EXPECT_EQ(PROFILING_SUCCESS, AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara));
    EXPECT_EQ(PROFILING_FAILED, AdprofGetHashId(nullptr, 0));
    std::string test("test");
    EXPECT_NE(PROFILING_FAILED, AdprofGetHashId(test.c_str(), test.length()));
}

static int halProfQueryAvailBufLenStub(unsigned int dev_id, unsigned int chan_id, unsigned int *buff_avail_len)
{
    static int count = 0;
    if (count == 0) {
        *buff_avail_len = 1024 * 1024;
    } else if (count == 1) {
        *buff_avail_len = 1024 * 1024;
    } else if (count == 2) {    // aicpu
        *buff_avail_len = 0;
    } else if (count == 3) {
        *buff_avail_len = 1024 * 1024;
    } else if (count == 4) {    // adprof
        *buff_avail_len = 0;
    } else {
        *buff_avail_len = 1024 * 1024;
    }
    count++;
    return 0;
}

TEST_F(DEVPROF_DRV_UTEST, BufLenZero)
{
    MOCKER(halProfQueryAvailBufLen).stubs().will(invoke(halProfQueryAvailBufLenStub));

    AicpuStartPara aicpuStartPara = {0, 111, 143, 2};
    EXPECT_EQ(PROFILING_SUCCESS, AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara));
    ProfSampleStartPara startPara = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfStartAicpu(&startPara));
    OsalSleep(15);
    MsprofAdditionalInfo additionalInfo;
    AdprofReportAdditionalInfo(1, static_cast<void *>(&additionalInfo), sizeof(MsprofAdditionalInfo));
    OsalSleep(5);
    prof_sample_stop_para stopPara = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAicpu(&stopPara));

    AdprofCallBack adprofCallBack = {ProfStartSuccess, ProfStartSuccess, AdprofExit};
    MOCKER(halProfSampleRegister)
        .stubs()
        .will(returnValue((int)DRV_ERROR_NONE));
    MOCKER(halProfSampleRegisterEx)
        .stubs()
        .will(returnValue((int)DRV_ERROR_NONE));
    EXPECT_EQ(PROFILING_SUCCESS, AdprofStartRegister(adprofCallBack, 0, 123));
    EXPECT_EQ(PROFILING_SUCCESS, ProfStartAdprof(&startPara));
    analysis::dvvp::ProfileFileChunk fileChunk;
    fileChunk.isLastChunk = false;
    fileChunk.chunkModule = PROFILING_IS_FROM_DEVICE;
    fileChunk.offset = -1;
    fileChunk.chunk = "test file chunk";
    fileChunk.chunkSize = fileChunk.chunk.length();
    fileChunk.fileName = "test_file";
    fileChunk.extraInfo = "test_info";
    fileChunk.id = "test_id";
    EXPECT_EQ(PROFILING_SUCCESS, ReportAdprofFileChunk(static_cast<void *>(&fileChunk)));
    OsalSleep(1);
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAdprof(&stopPara));
}

TEST_F(DEVPROF_DRV_UTEST, AdprofGetBatchReportMaxSizeBase)
{
    EXPECT_EQ(131072, AdprofGetBatchReportMaxSize(0));
    EXPECT_EQ(0, AdprofGetBatchReportMaxSize(1));
    EXPECT_EQ(131072, AdprofGetBatchReportMaxSize(ADPROF_ADDITIONAL_INFO));
}


TEST_F(DEVPROF_DRV_UTEST, AdprofBatchReportAdditionalInfoBase)
{
    MsprofAdditionalInfo data;
    data.magicNumber = 0x5A5AU;
    data.level = 6000; // aicpu
    data.type = 2;
    data.timeStamp = 151515151;
    void *addPtr = malloc(1024); // 1024byte
    (void)memset_s(addPtr, 1024, 0, 1024);
    (void)memcpy_s(addPtr, 256, &data, 256);
    (void)memcpy_s(addPtr + 256, 256, &data, 256);
    (void)memcpy_s(addPtr + 512, 256, &data, 256);
    (void)memcpy_s(addPtr + 768, 256, &data, 256);

    uint32_t bufLen = 524032;
    MOCKER(halProfQueryAvailBufLen)
        .stubs()
        .with(any(), any(), outBoundP(&bufLen, sizeof(bufLen)))
        .then(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    MOCKER(halProfSampleDataReport)
        .stubs()
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    AicpuStartPara aicpuStartPara = {0, 1111, 143, 2};
    EXPECT_EQ(PROFILING_SUCCESS, AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara));
    ProfSampleStartPara startPara = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfStartAicpu(&startPara));
    EXPECT_EQ(PROFILING_FAILED, AdprofReportBatchAdditionalInfo(1, nullptr, 4 * sizeof(MsprofAdditionalInfo)));
    EXPECT_EQ(PROFILING_SUCCESS, AdprofReportBatchAdditionalInfo(1, addPtr, 4 * sizeof(MsprofAdditionalInfo)));
    prof_sample_stop_para stopPara = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAicpu(&stopPara));
    free(addPtr);
}

static int32_t g_commandHandleCount = 0;
static int32_t AicpuCommandHandle(uint32_t type, VOID_PTR data, uint32_t len)
{
    g_commandHandleCount++;
    return PROFILING_SUCCESS;
}

TEST_F(DEVPROF_DRV_UTEST, AdprofRegisterCallback)
{
    AdprofRegisterCallback(0, &AicpuCommandHandle);
    AdprofRegisterCallback(0, &AicpuCommandHandle);
    AdprofRegisterCallback(1, &AicpuCommandHandle);
    AdprofRegisterCallback(1, &AicpuCommandHandle);
    AdprofRegisterCallback(2, &AicpuCommandHandle);
    AdprofRegisterCallback(2, &AicpuCommandHandle);
}

TEST_F(DEVPROF_DRV_UTEST, RecordHostMoveBufferAddresses)
{
    DevprofDrvAicpu::instance()->Reset();
    EXPECT_EQ(PROFILING_FAILED, DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(nullptr));

    Devprof::AicpuUserProfileBufferInfo invalidInfo = {0};
    invalidInfo.buffer_size = 0;
    EXPECT_EQ(PROFILING_FAILED, DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&invalidInfo));

    invalidInfo.buffer_size = 4 * 1024 * 1024;
    invalidInfo.buffer_base_user_va = 0;
    EXPECT_EQ(PROFILING_FAILED, DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&invalidInfo));

    uint8_t *buffer = new uint8_t[4 * 1024 * 1024];
    // wptr/rptr user va must be valid (non-zero), otherwise the shared pointers cannot be initialized.
    invalidInfo.buffer_base_user_va = reinterpret_cast<uint64_t>(buffer);
    invalidInfo.buffer_write_ptr_user_va = 0;
    invalidInfo.buffer_read_ptr_user_va = 0;
    EXPECT_EQ(PROFILING_FAILED, DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&invalidInfo));

    DevprofDrvAicpu::instance()->SetSupportHostMove(true);
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    // Pre-dirty the shared pointers to mimic halMemAlloc returning non-zeroed memory; the fix must
    // reset them to 0 so the host consumer does not read stale records before any data is produced.
    wptrVal = 12345;
    rptrVal = 678;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, 4 * 1024 * 1024, &wptrVal, &rptrVal);
    EXPECT_EQ(PROFILING_SUCCESS, DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info));
    EXPECT_EQ(0U, wptrVal);
    EXPECT_EQ(0U, rptrVal);

    MsprofAdditionalInfo data;
    data.magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
    EXPECT_EQ(PROFILING_SUCCESS, DevprofDrvAicpu::instance()->WriteToHostMoveBuffer(&data, sizeof(MsprofAdditionalInfo)));
    EXPECT_EQ(1U, wptrVal);

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ProfStopDevicePause_ThreadStopFailed)
{
    DevprofDrvAicpu::instance()->Reset();
    MOCKER(OsalCreateTaskWithThreadAttr).stubs().will(returnValue(0));
    MOCKER(OsalJoinTask).stubs().will(returnValue(-1));

    ProfSampleStartPara startPara = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfStartAicpu(&startPara));

    prof_sample_stop_para stopPara = {0};
    stopPara.release_flag = PROF_STOP_STAGE_PAUSE;
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAicpu(&stopPara));

    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, RunHostMoveMode_WriteFailed)
{
    DevprofDrvAicpu::instance()->Reset();
    DevprofDrvAicpu::instance()->aicpuAdditionalBuffer_.UnInit();
    DevprofDrvAicpu::instance()->aicpuAdditionalBuffer_.Init("AicpuBuffer");
    uint8_t *buffer = new uint8_t[4 * 1024 * 1024];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, 4 * 1024 * 1024, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->isSupportHostMove_ = true;

    MsprofAdditionalInfo data;
    AdprofReportAdditionalInfo(0, static_cast<void *>(&data), sizeof(MsprofAdditionalInfo));

    MOCKER(OsalSleep).stubs().will(returnValue(0));
    DevprofDrvAicpu::instance()->stopped_ = true;
    DevprofDrvAicpu::instance()->hostMoveBufferSize_ = 2 * sizeof(MsprofAdditionalInfo);
    DevprofDrvAicpu::instance()->RunHostMoveMode();

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ReleaseAndSupportHostMove)
{
    DevprofDrvAicpu::instance()->Reset();
    EXPECT_FALSE(DevprofDrvAicpu::instance()->IsSupportHostMove());

    DevprofDrvAicpu::instance()->SetSupportHostMove(true);
    EXPECT_TRUE(DevprofDrvAicpu::instance()->IsSupportHostMove());

    DevprofDrvAicpu::instance()->SetSupportHostMove(false);
    EXPECT_FALSE(DevprofDrvAicpu::instance()->IsSupportHostMove());

    DevprofDrvAicpu::instance()->Reset();
    DevprofDrvAicpu::instance()->SetSupportHostMove(true);
    uint8_t *buffer = new uint8_t[4 * 1024 * 1024];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, 4 * 1024 * 1024, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    EXPECT_TRUE(DevprofDrvAicpu::instance()->IsSupportHostMove());
    DevprofDrvAicpu::instance()->Release();
    EXPECT_FALSE(DevprofDrvAicpu::instance()->IsSupportHostMove());
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ProfStartAicpu_HostMove)
{
    EXPECT_EQ(PROFILING_FAILED, ProfStartAicpu(nullptr));

    DevprofDrvAicpu::instance()->Reset();
    ProfSampleStartPara startPara = {0};
    startPara.is_support_host_move = 1;
    startPara.out_data = nullptr;
    EXPECT_EQ(PROFILING_FAILED, ProfStartAicpu(&startPara));

    startPara.out_data = malloc(16);
    startPara.out_data_max_len = 16;
    EXPECT_EQ(PROFILING_FAILED, ProfStartAicpu(&startPara));
    free(startPara.out_data);

    uint8_t *buffer = new uint8_t[4 * 1024 * 1024];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, 4 * 1024 * 1024, &wptrVal, &rptrVal);

    DevprofDrvAicpu::instance()->Reset();
    MOCKER(OsalCreateTaskWithThreadAttr).stubs().will(returnValue(0));
    MOCKER(OsalJoinTask).stubs().will(returnValue(0));
    startPara = {0};
    startPara.is_support_host_move = 1;
    startPara.out_data = &info;
    startPara.out_data_max_len = sizeof(Devprof::AicpuUserProfileBufferInfo);
    EXPECT_EQ(PROFILING_SUCCESS, ProfStartAicpu(&startPara));

    prof_sample_stop_para stopPara = {0};
    stopPara.release_flag = 2;
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAicpu(&stopPara));
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ProfStopAicpu_ReleaseFlag)
{
    EXPECT_EQ(PROFILING_FAILED, ProfStopAicpu(nullptr));

    DevprofDrvAicpu::instance()->Reset();
    MOCKER(OsalCreateTaskWithThreadAttr).stubs().will(returnValue(0));
    MOCKER(OsalJoinTask).stubs().will(returnValue(0));

    uint8_t *buffer = new uint8_t[4 * 1024 * 1024];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, 4 * 1024 * 1024, &wptrVal, &rptrVal);

    ProfSampleStartPara startPara = {0};
    startPara.is_support_host_move = 1;
    startPara.out_data = &info;
    startPara.out_data_max_len = sizeof(Devprof::AicpuUserProfileBufferInfo);
    EXPECT_EQ(PROFILING_SUCCESS, ProfStartAicpu(&startPara));

    prof_sample_stop_para stopPara = {0};
    stopPara.release_flag = 1;
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAicpu(&stopPara));
    EXPECT_TRUE(DevprofDrvAicpu::instance()->IsSupportHostMove());

    stopPara.release_flag = 2;
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAicpu(&stopPara));
    EXPECT_FALSE(DevprofDrvAicpu::instance()->IsSupportHostMove());

    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, WriteToHostMoveBuffer)
{
    DevprofDrvAicpu::instance()->Reset();
    MsprofAdditionalInfo data;
    EXPECT_EQ(PROFILING_FAILED, DevprofDrvAicpu::instance()->WriteToHostMoveBuffer(&data, sizeof(MsprofAdditionalInfo)));

    DevprofDrvAicpu::instance()->SetSupportHostMove(true);
    uint8_t *buffer = new uint8_t[4 * 1024 * 1024];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, 4 * 1024 * 1024, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);

    EXPECT_EQ(PROFILING_FAILED, DevprofDrvAicpu::instance()->WriteToHostMoveBuffer(nullptr, sizeof(MsprofAdditionalInfo)));
    EXPECT_EQ(PROFILING_FAILED, DevprofDrvAicpu::instance()->WriteToHostMoveBuffer(&data, 0));
    EXPECT_EQ(PROFILING_FAILED, DevprofDrvAicpu::instance()->WriteToHostMoveBuffer(&data, 300));

    data.magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
    EXPECT_EQ(PROFILING_SUCCESS, DevprofDrvAicpu::instance()->WriteToHostMoveBuffer(&data, sizeof(MsprofAdditionalInfo)));
    for (int i = 0; i < 10; i++) {
        EXPECT_EQ(PROFILING_SUCCESS, DevprofDrvAicpu::instance()->WriteToHostMoveBuffer(&data, sizeof(MsprofAdditionalInfo)));
    }

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, WriteToHostMoveBuffer_WriteOffsetOverflow)
{
    DevprofDrvAicpu::instance()->Reset();
    uint8_t *buffer = new uint8_t[4 * 1024 * 1024];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, 4 * 1024 * 1024, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);

    MsprofAdditionalInfo data;
    data.magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
    DevprofDrvAicpu::instance()->hostMoveWriteIndex_.store(16384);
    EXPECT_EQ(PROFILING_FAILED, DevprofDrvAicpu::instance()->WriteToHostMoveBuffer(&data, sizeof(MsprofAdditionalInfo)));
    EXPECT_EQ(0u, wptrVal);

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, WriteToHostMoveBuffer_NullWptr)
{
    DevprofDrvAicpu::instance()->Reset();
    uint8_t *buffer = new uint8_t[4 * 1024 * 1024];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, 4 * 1024 * 1024, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->hostMoveWptr_ = nullptr;
    DevprofDrvAicpu::instance()->hostMoveWriteIndex_.store(16384);

    MsprofAdditionalInfo data;
    data.magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
    EXPECT_EQ(PROFILING_FAILED, DevprofDrvAicpu::instance()->WriteToHostMoveBuffer(&data, sizeof(MsprofAdditionalInfo)));
    EXPECT_EQ(0u, wptrVal);

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, UninitHostMoveBuffer)
{
    DevprofDrvAicpu::instance()->Reset();
    DevprofDrvAicpu::instance()->UninitHostMoveBuffer();

    DevprofDrvAicpu::instance()->SetSupportHostMove(true);
    uint8_t *buffer = new uint8_t[4 * 1024 * 1024];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, 4 * 1024 * 1024, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->UninitHostMoveBuffer();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, RegisterDrvChannel_NotSupport)
{
    DevprofDrvAicpu::instance()->Reset();
    AicpuStartPara aicpuStartPara = {0, 111, 143, 2};

    MOCKER(halProfSampleRegister).stubs().will(returnValue((int)DRV_ERROR_NONE));
    MOCKER(halProfSampleRegisterEx).stubs().will(returnValue((int)DRV_ERROR_NOT_SUPPORT));
    MOCKER(ProfSendEvent).stubs().will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_CONTINUE, DevprofDrvAicpu::instance()->AdprofInit(&aicpuStartPara));
    EXPECT_TRUE(DevprofDrvAicpu::instance()->IsRegister());

    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ProfStopDeviceRelease_NotSupportHostMove)
{
    DevprofDrvAicpu::instance()->Reset();
    EXPECT_FALSE(DevprofDrvAicpu::instance()->IsSupportHostMove());

    MOCKER(OsalCreateTaskWithThreadAttr).stubs().will(returnValue(0));
    MOCKER(OsalJoinTask).stubs().will(returnValue(0));

    ProfSampleStartPara startPara = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfStartAicpu(&startPara));

    prof_sample_stop_para stopPara = {0};
    stopPara.release_flag = PROF_STOP_STAGE_PAUSE_AND_RELEASE;
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAicpu(&stopPara));
    EXPECT_FALSE(DevprofDrvAicpu::instance()->IsSupportHostMove());

    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ProfStopAicpu_InvalidReleaseFlag)
{
    prof_sample_stop_para stopPara = {0};
    stopPara.release_flag = 99;
    EXPECT_EQ(PROFILING_FAILED, ProfStopAicpu(&stopPara));
}

TEST_F(DEVPROF_DRV_UTEST, RunHostMoveMode_NullPointers)
{
    DevprofDrvAicpu::instance()->Reset();
    DevprofDrvAicpu::instance()->isSupportHostMove_ = true;
    DevprofDrvAicpu::instance()->hostMoveBuffer_ = nullptr;
    DevprofDrvAicpu::instance()->hostMoveWptr_ = nullptr;
    DevprofDrvAicpu::instance()->hostMoveRptr_ = nullptr;
    DevprofDrvAicpu::instance()->RunHostMoveMode();
    EXPECT_EQ(0u, DevprofDrvAicpu::instance()->hostMoveWriteIndex_.load());
}

TEST_F(DEVPROF_DRV_UTEST, RunHostMoveMode_InvalidBufferSize)
{
    DevprofDrvAicpu::instance()->Reset();
    uint8_t *buffer = new uint8_t[4 * 1024 * 1024];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, 4 * 1024 * 1024, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->hostMoveBufferSize_ = 0;
    DevprofDrvAicpu::instance()->RunHostMoveMode();
    EXPECT_EQ(0u, wptrVal);

    DevprofDrvAicpu::instance()->hostMoveBufferSize_ = 10;
    DevprofDrvAicpu::instance()->RunHostMoveMode();
    EXPECT_EQ(0u, wptrVal);

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
}

TEST_F(DEVPROF_DRV_UTEST, RunHostMoveMode_StoppedNoData)
{
    DevprofDrvAicpu::instance()->Reset();
    // Reset the additional buffer and clear str2id keys leaked by prior tests, so this case truly
    // starts from "no pending data, no hash keys" and the ring buffer stays untouched.
    DevprofDrvAicpu::instance()->aicpuAdditionalBuffer_.UnInit();
    DevprofDrvAicpu::instance()->aicpuAdditionalBuffer_.Init("AicpuBuffer");
    analysis::dvvp::transport::HashData::instance()->hashVector_.clear();
    uint8_t *buffer = new uint8_t[4 * 1024 * 1024];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, 4 * 1024 * 1024, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->isSupportHostMove_ = true;
    DevprofDrvAicpu::instance()->stopped_ = true;
    MOCKER(OsalSleep).stubs().will(returnValue(0));
    DevprofDrvAicpu::instance()->RunHostMoveMode();
    EXPECT_EQ(0u, wptrVal);

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, RunHostMoveMode_InvalidWptrRptr)
{
    DevprofDrvAicpu::instance()->Reset();
    DevprofDrvAicpu::instance()->aicpuAdditionalBuffer_.UnInit();
    DevprofDrvAicpu::instance()->aicpuAdditionalBuffer_.Init("AicpuBuffer");
    uint8_t *buffer = new uint8_t[4 * 1024 * 1024];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, 4 * 1024 * 1024, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    // RecordHostMoveBufferAddresses now zeroes the shared pointers, so inject the invalid rptr
    // afterwards to mimic a corrupt read pointer appearing at runtime.
    rptrVal = 99999;
    DevprofDrvAicpu::instance()->isSupportHostMove_ = true;

    MsprofAdditionalInfo data;
    data.magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
    AdprofReportAdditionalInfo(0, static_cast<void *>(&data), sizeof(MsprofAdditionalInfo));

    MOCKER(OsalSleep).stubs().will(returnValue(0));
    DevprofDrvAicpu::instance()->stopped_ = true;
    DevprofDrvAicpu::instance()->RunHostMoveMode();
    EXPECT_EQ(0u, wptrVal);

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, RunHostMoveMode_RingBufferFull)
{
    DevprofDrvAicpu::instance()->Reset();
    DevprofDrvAicpu::instance()->aicpuAdditionalBuffer_.UnInit();
    DevprofDrvAicpu::instance()->aicpuAdditionalBuffer_.Init("AicpuBuffer");
    uint8_t *buffer = new uint8_t[4 * 1024 * 1024];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, 4 * 1024 * 1024, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->isSupportHostMove_ = true;

    MsprofAdditionalInfo data;
    data.magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
    AdprofReportAdditionalInfo(0, static_cast<void *>(&data), sizeof(MsprofAdditionalInfo));

    DevprofDrvAicpu::instance()->hostMoveWriteIndex_.store(16383);
    MOCKER(OsalSleep).stubs().will(returnValue(0));
    DevprofDrvAicpu::instance()->stopped_ = true;
    DevprofDrvAicpu::instance()->RunHostMoveMode();
    EXPECT_EQ(0u, wptrVal);

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, RunHostMoveMode_WriteSuccess)
{
    DevprofDrvAicpu::instance()->Reset();
    DevprofDrvAicpu::instance()->aicpuAdditionalBuffer_.UnInit();
    DevprofDrvAicpu::instance()->aicpuAdditionalBuffer_.Init("AicpuBuffer");
    // Clear leaked str2id keys so only the single pushed record is written to the ring buffer.
    analysis::dvvp::transport::HashData::instance()->hashVector_.clear();
    uint8_t *buffer = new uint8_t[4 * 1024 * 1024];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, 4 * 1024 * 1024, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->isSupportHostMove_ = true;

    MsprofAdditionalInfo data;
    data.magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
    AdprofReportAdditionalInfo(0, static_cast<void *>(&data), sizeof(MsprofAdditionalInfo));

    MOCKER(OsalSleep).stubs().will(returnValue(0));
    DevprofDrvAicpu::instance()->stopped_ = true;
    DevprofDrvAicpu::instance()->RunHostMoveMode();
    EXPECT_EQ(1U, wptrVal);

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

// host-move 模式下，所有采样数据落盘后，str2id hashkey 也应通过环形缓冲区回传给 host，
// 与 RunNormalMode 行为对齐。验证 str2id 记录确实被写入了环形缓冲区且带 STR2ID_MARK 标记。
TEST_F(DEVPROF_DRV_UTEST, RunHostMoveMode_ReportStr2Id)
{
    DevprofDrvAicpu::instance()->Reset();
    DevprofDrvAicpu::instance()->aicpuAdditionalBuffer_.UnInit();
    DevprofDrvAicpu::instance()->aicpuAdditionalBuffer_.Init("AicpuBuffer");
    analysis::dvvp::transport::HashData::instance()->hashVector_.clear();
    uint8_t *buffer = new uint8_t[4 * 1024 * 1024];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, 4 * 1024 * 1024, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->isSupportHostMove_ = true;

    // 预置若干 hashkey，使 GetHashKeys 返回非空
    analysis::dvvp::transport::HashData::instance()->GenHashId("op_kernel_name_0");
    analysis::dvvp::transport::HashData::instance()->GenHashId("op_kernel_name_1");

    MOCKER(OsalSleep).stubs().will(returnValue(0));
    DevprofDrvAicpu::instance()->stopped_ = true;
    DevprofDrvAicpu::instance()->RunHostMoveMode();

    // 采样 buffer 为空，主排空不写入；str2id flush 后环形缓冲区应至少有一条记录
    EXPECT_GT(wptrVal, 0U);
    // 校验首条记录的 data 以 STR2ID_MARK 开头
    const MsprofAdditionalInfo *record = reinterpret_cast<const MsprofAdditionalInfo *>(buffer);
    EXPECT_EQ(0, strncmp(reinterpret_cast<const char *>(record->data), STR2ID_MARK, strlen(STR2ID_MARK)));

    analysis::dvvp::transport::HashData::instance()->hashVector_.clear();
    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}