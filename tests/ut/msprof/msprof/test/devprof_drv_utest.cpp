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

    MOCKER_CPP(&AicpuReportHdc::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED));
    EXPECT_EQ(PROFILING_SUCCESS, AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara));
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
    MOCKER_CPP(&AicpuReportHdc::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED));

    MOCKER(halProfSampleRegister)
        .stubs()
        .will(returnValue((int)DRV_ERROR_NONE))
        .then(returnValue(-1));

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
    MOCKER_CPP(&AicpuReportHdc::Init).stubs().will(returnValue(PROFILING_FAILED));
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

    MOCKER_CPP(&AicpuReportHdc::Init).stubs().will(returnValue(PROFILING_FAILED));
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
    MOCKER_CPP(&AicpuReportHdc::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
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

TEST_F(DEVPROF_DRV_UTEST, AdprofInit) // AdprofAicpuStartRegister
{
    DevprofDrvAicpu::instance()->Reset();
    AdprofRegisterCallback(100, &AicpuCommandHandle);
    AicpuStartPara aicpuStartPara = {0, 111, 1, 0};
    // aicpu not start, return ok
    EXPECT_EQ(PROFILING_SUCCESS, AdprofInit(&aicpuStartPara));
    aicpuStartPara.profConfig = 2;  // aicpu = on

    MOCKER_CPP(&AicpuReportHdc::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED));
    // AicpuReportHdc::Init and return SUCCESS
    EXPECT_EQ(PROFILING_SUCCESS, AdprofInit(&aicpuStartPara));
    // channelId not supported
    EXPECT_EQ(PROFILING_FAILED, AdprofInit(&aicpuStartPara));
    aicpuStartPara.channelId = 143;

    MOCKER(halProfSampleRegister)
        .stubs()
        .will(returnValue(1))
        .then(returnValue((int)DRV_ERROR_NONE));
    // halProfSampleRegister failed
    EXPECT_EQ(PROFILING_FAILED, AdprofInit(&aicpuStartPara));

    MOCKER(ProfSendEvent)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    // Init success
    EXPECT_EQ(PROFILING_SUCCESS, AdprofInit(&aicpuStartPara));
    EXPECT_TRUE(g_commandHandleCount == 1);

    aicpuStartPara.profConfig = ADPROF_TASK_TIME_L0 | ADPROF_TASK_TIME_L1 | ADPROF_TASK_TIME_L2;
    // update config
    EXPECT_EQ(PROFILING_SUCCESS, AdprofInit(&aicpuStartPara));
    EXPECT_EQ(0, AdprofCheckFeatureIsOn(ADPROF_TASK_TIME_L0));
    EXPECT_EQ(0, AdprofCheckFeatureIsOn(ADPROF_TASK_TIME_L1));
    EXPECT_EQ(0, AdprofCheckFeatureIsOn(ADPROF_TASK_TIME_L2));
    constexpr uint32_t START_SWITCH = 1U;
    aicpuStartPara.profConfig |= START_SWITCH;
    EXPECT_EQ(PROFILING_SUCCESS, AdprofInit(&aicpuStartPara));
    EXPECT_EQ(1, AdprofCheckFeatureIsOn(ADPROF_TASK_TIME_L0));
    EXPECT_EQ(1, AdprofCheckFeatureIsOn(ADPROF_TASK_TIME_L1));
    EXPECT_EQ(1, AdprofCheckFeatureIsOn(ADPROF_TASK_TIME_L2));
}

TEST_F(DEVPROF_DRV_UTEST, AdprofRegisterCallback)
{
    AdprofRegisterCallback(0, &AicpuCommandHandle);
    AdprofRegisterCallback(0, &AicpuCommandHandle);
    AdprofRegisterCallback(1, &AicpuCommandHandle);
    AdprofRegisterCallback(1, &AicpuCommandHandle);
    AdprofRegisterCallback(2, &AicpuCommandHandle);
    AdprofRegisterCallback(2, &AicpuCommandHandle);
    sleep(2);
    EXPECT_EQ(g_commandHandleCount, 4);
}

TEST_F(DEVPROF_DRV_UTEST, AdprofFinalize)
{
    AdprofFinalize();
    EXPECT_EQ(g_commandHandleCount, 8);
}