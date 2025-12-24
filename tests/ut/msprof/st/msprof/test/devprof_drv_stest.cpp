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
#include "prof_dev_api.h"
#include "error_code.h"
#include "devprof_common.h"
#include "devprof_drv_adprof.h"
#include "aicpu_report_hdc.h"
#include "config.h"
#include "utils.h"
#include "rpc_data_handle.h"
#include <future>

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;

class DEVPROF_DRV_STEST : public testing::Test {
protected:
    virtual void SetUp()
    {
        GlobalMockObject::verify();
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

extern int32_t ProfStartAicpu(struct prof_sample_start_para *para);
extern int32_t ProfStopAicpu(struct prof_sample_stop_para *para);

extern int32_t ProfStartAdprof(struct prof_sample_start_para *para);
extern int32_t ProfSampleAdprof(struct prof_sample_para *para);
extern int32_t ProfStopAdprof(struct prof_sample_stop_para *para);

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

static uint32_t totalReportSize = 0;

static int halProfSampleDataReportStub(unsigned int dev_id, unsigned int chan_id, unsigned int sub_chan_id,
    struct prof_data_report_para *para)
{
    totalReportSize += para->data_len;
    usleep(2);
    return 0;
}

TEST_F(DEVPROF_DRV_STEST, AdprofGetBatchReportMaxSizeBase)
{
    EXPECT_EQ(131072, AdprofGetBatchReportMaxSize(0));
    EXPECT_EQ(0, AdprofGetBatchReportMaxSize(1));
    EXPECT_EQ(131072, AdprofGetBatchReportMaxSize(ADPROF_ADDITIONAL_INFO));
}

TEST_F(DEVPROF_DRV_STEST, AdprofBatchReportAdditionalInfoBase)
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
        .will(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED));
    MOCKER(halProfSampleDataReport)
        .stubs()
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    AicpuStartPara aicpuStartPara = {0, 1111, 143, 2};
    EXPECT_EQ(PROFILING_SUCCESS, AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara));
    EXPECT_EQ(PROFILING_SUCCESS, AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara));
    ProfSampleStartPara startPara = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfStartAicpu(&startPara));
    EXPECT_EQ(PROFILING_FAILED, AdprofReportBatchAdditionalInfo(1, nullptr, 4 * sizeof(MsprofAdditionalInfo)));
    EXPECT_EQ(PROFILING_SUCCESS, AdprofReportBatchAdditionalInfo(1, addPtr, 4 * sizeof(MsprofAdditionalInfo)));
    prof_sample_stop_para stopPara = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAicpu(&stopPara));
    free(addPtr);
}

TEST_F(DEVPROF_DRV_STEST, DevprofDrvAicpuStress)
{
    MOCKER_CPP(&AicpuReportHdc::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    MOCKER(halProfSampleDataReport).stubs().will(invoke(halProfSampleDataReportStub));
    AicpuStartPara aicpuStartPara = {0, 111, 143, 2};
    int32_t ret = AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara);

    prof_sample_start_para startPara = {0};
    ret = ProfStartAicpu(&startPara);
    std::vector<std::future<void>> threads;

    MsprofAdditionalInfo additionalInfo;
    for (int i = 0; i < 10; i++) {
        threads.emplace_back(std::async(std::launch::async, [&additionalInfo]()->void {
            for (int j = 0; j < 10000; j++) {
                AdprofReportAdditionalInfo(0, static_cast<void *>(&additionalInfo), sizeof(MsprofAdditionalInfo));
            }
        }));
    }

    for (auto &it : threads) {
        it.wait();
    }

    prof_sample_stop_para stopPara = {0};
    ret = ProfStopAicpu(&stopPara);
    EXPECT_EQ(100000 * sizeof(MsprofAdditionalInfo), totalReportSize);
}

TEST_F(DEVPROF_DRV_STEST, DevprofDrvAicpu)
{
    AicpuStartPara aicpuStartPara = {0, 111, 143, 0};
    int32_t ret = AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
    aicpuStartPara.profConfig = 2;  // aicpu = on

    MOCKER_CPP(&AicpuReportHdc::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED));
    ret = AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara);
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    ret = AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara);
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    prof_sample_start_para startPara = {0};
    ret = ProfStartAicpu(&startPara);
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    MsprofAdditionalInfo additionalInfo;
    additionalInfo.level = 0;
    additionalInfo.type = 0;
    additionalInfo.threadId = 0;
    additionalInfo.dataLen = 4;
    additionalInfo.timeStamp = 1000;
    memset(additionalInfo.data, 0, MSPROF_ADDTIONAL_INFO_DATA_LENGTH);
    memcpy(additionalInfo.data, "test", additionalInfo.dataLen);

    ret = AdprofReportAdditionalInfo(0, static_cast<void *>(&additionalInfo), sizeof(MsprofAdditionalInfo) - 1);
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = AdprofReportAdditionalInfo(0, static_cast<void *>(&additionalInfo), sizeof(MsprofAdditionalInfo));
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    prof_sample_stop_para stopPara = {0};
    ret = ProfStopAicpu(&stopPara);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}

TEST_F(DEVPROF_DRV_STEST, DevprofDrvAicpuError)
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

TEST_F(DEVPROF_DRV_STEST, DevprofDrvAdprof)
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

    EXPECT_EQ(PROFILING_SUCCESS, ReportAdprofFileChunk(static_cast<void *>(&fileChunk)));
    prof_sample_stop_para stopPara = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAdprof(&stopPara));
    EXPECT_EQ(PROFILING_FAILED, ReportAdprofFileChunk(static_cast<void *>(&fileChunk)));
}

TEST_F(DEVPROF_DRV_STEST, CheckFeatureIsOn)
{
    MOCKER_CPP(&AicpuReportHdc::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    prof_sample_start_para startPara = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfStartAicpu(&startPara));
    AicpuStartPara aicpuStartPara = {0, 111, 143, ADPROF_TASK_TIME_L0 | ADPROF_TASK_TIME_L1 | ADPROF_TASK_TIME_L2};
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
    prof_sample_stop_para stopPara = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAicpu(&stopPara));
    EXPECT_EQ(0, AdprofCheckFeatureIsOn(ADPROF_TASK_TIME_L0));
}

TEST_F(DEVPROF_DRV_STEST, AdprofGetHashId)
{
    MOCKER_CPP(&AicpuReportHdc::Init).stubs().will(returnValue(PROFILING_FAILED));
    MOCKER(Devprof::ProfSendEvent).stubs().will(returnValue(PROFILING_SUCCESS));

    AicpuStartPara aicpuStartPara = {0, 111, 143, 2};   // aicpu = on
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
    } else if (count == 1) {    // aicpu
        *buff_avail_len = 0;
    } else if (count == 2) {
        *buff_avail_len = 1024 * 1024;
    } else if (count == 3) {    // adprof
        *buff_avail_len = 0;
    } else {
        *buff_avail_len = 1024 * 1024;
    }
    count++;
    return 0;
}

TEST_F(DEVPROF_DRV_STEST, BufLenZero)
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

int32_t g_callbackHandle = 0;
static int32_t AicpuCallbackFunc(uint32_t type, void *data, uint32_t len)
{
    (void)type;
    (void)data;
    (void)len;
    g_callbackHandle++;
    return 0;
}

TEST_F(DEVPROF_DRV_STEST, DevprofDrvAicpuWithNewApi)
{
    AicpuStartPara aicpuStartPara = {0, 111, 143, 0};
    int32_t ret = AdprofRegisterCallback(10086, &AicpuCallbackFunc);
    ret = AdprofInit(&aicpuStartPara);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
    aicpuStartPara.profConfig = 2;  // aicpu = on

    MOCKER_CPP(&AicpuReportHdc::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED));
    ret = AdprofInit(&aicpuStartPara);
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    ret = AdprofInit(&aicpuStartPara);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
    EXPECT_EQ(g_callbackHandle, 1);
    ret = AdprofRegisterCallback(10087, &AicpuCallbackFunc);
    sleep(1);
    EXPECT_EQ(g_callbackHandle, 2);

    prof_sample_start_para startPara = {0};
    ret = ProfStartAicpu(&startPara);
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    MsprofAdditionalInfo additionalInfo;
    additionalInfo.level = 0;
    additionalInfo.type = 0;
    additionalInfo.threadId = 0;
    additionalInfo.dataLen = 4;
    additionalInfo.timeStamp = 1000;
    memset(additionalInfo.data, 0, MSPROF_ADDTIONAL_INFO_DATA_LENGTH);
    memcpy(additionalInfo.data, "test", additionalInfo.dataLen);

    ret = AdprofReportAdditionalInfo(0, static_cast<void *>(&additionalInfo), sizeof(MsprofAdditionalInfo) - 1);
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = AdprofReportAdditionalInfo(0, static_cast<void *>(&additionalInfo), sizeof(MsprofAdditionalInfo));
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    EXPECT_EQ(PROFILING_SUCCESS, AdprofFinalize());
    sleep(1);
    EXPECT_EQ(g_callbackHandle, 4);
    prof_sample_stop_para stopPara = {0};
    ret = ProfStopAicpu(&stopPara);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}