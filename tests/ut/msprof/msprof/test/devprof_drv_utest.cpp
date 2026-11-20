/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <chrono>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "ascend_inpackage_hal.h"
#include "prof_dev_api.h"
#include "error_code.h"
#include "devprof_drv_adprof.h"
// #include "aicpu_report_hdc.h"
#include "devprof_common.h"
#include "config.h"
#include "utils.h"
#include "devprof_drv_aicpu.h"
#include "transport/hash_data.h"
#include "hdc-log-stub.h"

#include <atomic>
#include <thread>
#include <vector>

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace Devprof;

extern int32_t ProfStartAicpu(struct prof_sample_start_para* para);
extern int32_t ProfStopAicpu(struct prof_sample_stop_para* para);

extern int32_t ProfStartAdprof(struct prof_sample_start_para* para);
extern int32_t ProfSampleAdprof(struct prof_sample_para* para);
extern int32_t ProfStopAdprof(struct prof_sample_stop_para* para);

class DEVPROF_DRV_UTEST : public testing::Test {
protected:
    virtual void SetUp() { GlobalMockObject::verify(); }
    virtual void TearDown() {}
};

static void SetupHostMoveBufferInfo(
    Devprof::AicpuUserProfileBufferInfo& info, uint8_t* buffer, uint32_t bufferSize, uint32_t* wptr, uint32_t* rptr)
{
    info.buffer_size = bufferSize;
    info.buffer_base_user_va = reinterpret_cast<uint64_t>(buffer);
    info.buffer_read_ptr_user_va = reinterpret_cast<uint64_t>(rptr);
    info.buffer_write_ptr_user_va = reinterpret_cast<uint64_t>(wptr);
}

static void SetupHostMoveChannel(uint32_t channelId)
{
    AicpuStartPara para = {0, 111, channelId, 2};
    MOCKER(halProfSampleRegister).stubs().will(returnValue((int)DRV_ERROR_NONE));
    MOCKER(halProfSampleRegisterEx).stubs().will(returnValue((int)DRV_ERROR_NONE));
    MOCKER(ProfSendEvent).stubs().will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_CONTINUE, DevprofDrvAicpu::instance()->AdprofInit(&para));
    GlobalMockObject::verify();
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

TEST_F(DEVPROF_DRV_UTEST, ProfStartHostMove_BufferSmallerThanOneRecord)
{
    DevprofDrvAicpu::instance()->Reset();
    uint8_t buffer[sizeof(MsprofAdditionalInfo) - 1U] = {0};
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, sizeof(buffer), &wptrVal, &rptrVal);
    ProfSampleStartPara startPara = {0};
    startPara.is_support_host_move = 1;
    startPara.out_data = &info;
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

    uint8_t* buffer = new uint8_t[4 * 1024 * 1024];
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

TEST_F(DEVPROF_DRV_UTEST, ProfStartHostMove_DoesNotAllocateAdditionalBuffer)
{
    DevprofDrvAicpu::instance()->Reset();
    DevprofDrvAicpu::instance()->aicpuAdditionalBuffer_.UnInit();
    AicpuStartPara aicpuStartPara = {0, 111, 143, 2};
    MOCKER(halProfSampleRegister).stubs().will(returnValue((int)DRV_ERROR_NONE));
    MOCKER(halProfSampleRegisterEx).stubs().will(returnValue((int)DRV_ERROR_NONE));
    MOCKER(ProfSendEvent).stubs().will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_CONTINUE, DevprofDrvAicpu::instance()->AdprofInit(&aicpuStartPara));
    EXPECT_FALSE(DevprofDrvAicpu::instance()->aicpuAdditionalBuffer_.isInited_);

    uint8_t* buffer = new uint8_t[4 * sizeof(MsprofAdditionalInfo)];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, 4 * sizeof(MsprofAdditionalInfo), &wptrVal, &rptrVal);
    ProfSampleStartPara startPara = {0};
    startPara.is_support_host_move = 1;
    startPara.out_data = &info;
    startPara.out_data_max_len = sizeof(Devprof::AicpuUserProfileBufferInfo);
    EXPECT_EQ(PROFILING_SUCCESS, ProfStartAicpu(&startPara));
    EXPECT_FALSE(DevprofDrvAicpu::instance()->aicpuAdditionalBuffer_.isInited_);

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ProfStartAicpu_InitializesAdditionalBufferForNormalMode)
{
    DevprofDrvAicpu::instance()->Reset();
    DevprofDrvAicpu::instance()->aicpuAdditionalBuffer_.UnInit();
    MOCKER(OsalCreateTaskWithThreadAttr).stubs().will(returnValue(0));
    MOCKER(OsalJoinTask).stubs().will(returnValue(0));

    ProfSampleStartPara startPara = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfStartAicpu(&startPara));
    EXPECT_TRUE(DevprofDrvAicpu::instance()->aicpuAdditionalBuffer_.isInited_);

    prof_sample_stop_para stopPara = {0};
    stopPara.release_flag = PROF_STOP_STAGE_PAUSE;
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAicpu(&stopPara));
    GlobalMockObject::verify();
}

static int32_t g_callbackReportResult = PROFILING_FAILED;
static int32_t AicpuCommandHandleReportOnStart(uint32_t type, VOID_PTR data, uint32_t len)
{
    (void)type;
    (void)data;
    (void)len;
    MsprofAdditionalInfo additionalInfo = {0};
    g_callbackReportResult = AdprofReportAdditionalInfo(0, &additionalInfo, sizeof(additionalInfo));
    return g_callbackReportResult;
}

TEST_F(DEVPROF_DRV_UTEST, ProfStartAicpu_CallbackCanReportBeforeStartReturns)
{
    DevprofDrvAicpu::instance()->Reset();
    DevprofDrvAicpu::instance()->aicpuAdditionalBuffer_.UnInit();
    g_callbackReportResult = PROFILING_FAILED;
    EXPECT_EQ(PROFILING_SUCCESS, AdprofRegisterCallback(0, &AicpuCommandHandleReportOnStart));
    MOCKER(OsalCreateTaskWithThreadAttr).stubs().will(returnValue(0));
    MOCKER(OsalJoinTask).stubs().will(returnValue(0));

    ProfSampleStartPara startPara = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfStartAicpu(&startPara));
    EXPECT_EQ(PROFILING_SUCCESS, g_callbackReportResult);
    EXPECT_GT(DevprofDrvAicpu::instance()->aicpuAdditionalBuffer_.GetUsedSize(), 0U);

    prof_sample_stop_para stopPara = {0};
    stopPara.release_flag = PROF_STOP_STAGE_PAUSE;
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAicpu(&stopPara));
    DevprofDrvAicpu::instance()->moduleCallbacks_.clear();
    DevprofDrvAicpu::instance()->Release();
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ProfStartHostMove_DirectReportWithoutBackgroundThread)
{
    DevprofDrvAicpu::instance()->Reset();
    DevprofDrvAicpu::instance()->aicpuAdditionalBuffer_.UnInit();
    EXPECT_FALSE(DevprofDrvAicpu::instance()->aicpuAdditionalBuffer_.isInited_);
    uint8_t* buffer = new uint8_t[4 * sizeof(MsprofAdditionalInfo)];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, 4 * sizeof(MsprofAdditionalInfo), &wptrVal, &rptrVal);

    ProfSampleStartPara startPara = {0};
    startPara.is_support_host_move = 1;
    startPara.out_data = &info;
    startPara.out_data_max_len = sizeof(Devprof::AicpuUserProfileBufferInfo);
    EXPECT_EQ(PROFILING_SUCCESS, ProfStartAicpu(&startPara));
    EXPECT_FALSE(DevprofDrvAicpu::instance()->aicpuAdditionalBuffer_.isInited_);

    MsprofAdditionalInfo data = {0};
    data.magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
    data.dataLen = 4;
    (void)memcpy_s(data.data, sizeof(data.data), "abcd", data.dataLen);
    EXPECT_EQ(PROFILING_SUCCESS, DevprofDrvAicpu::instance()->ReportAdditionalInfo(0, &data, sizeof(data)));

    EXPECT_EQ(1U, wptrVal);
    EXPECT_EQ(MSPROF_REPORT_DATA_MAGIC_NUM, reinterpret_cast<const MsprofAdditionalInfo*>(buffer)->magicNumber);
    EXPECT_EQ(0, memcmp(reinterpret_cast<const MsprofAdditionalInfo*>(buffer)->data, "abcd", 4));

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ReportAdditionalInfo_HostMoveRejectsBatchWhenUnconsumedData)
{
    DevprofDrvAicpu::instance()->Reset();
    constexpr uint32_t recordCount = 4;
    const size_t recordSize = sizeof(MsprofAdditionalInfo);
    uint8_t* buffer = new uint8_t[recordSize * recordCount];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, recordSize * recordCount, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->SetSupportHostMove(true);

    DevprofDrvAicpu::instance()->hostMoveWriteIndex_.store(2);
    DevprofDrvAicpu::instance()->hostMoveIdleWriteIndex_.store(2);
    DevprofDrvAicpu::instance()->hostMoveReadIndex_.store(0);
    rptrVal = 0;
    wptrVal = 2;
    MsprofAdditionalInfo records[recordCount - 1] = {};
    DevprofDrvAicpu::instance()->hostMoveMaxCycles_ = 1;
    EXPECT_EQ(PROFILING_SUCCESS, DevprofDrvAicpu::instance()->ReportAdditionalInfo(0, records, sizeof(records)));
    EXPECT_EQ(2U, wptrVal);
    EXPECT_EQ(recordCount - 1, DevprofDrvAicpu::instance()->hostMoveOverflowDiscardSize_.load());

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ReportAdditionalInfo_HostMoveReadCursorAccountsForUnconsumedData)
{
    DevprofDrvAicpu::instance()->Reset();
    constexpr uint32_t ringRecords = 7;
    const size_t recordSize = sizeof(MsprofAdditionalInfo);
    uint8_t* buffer = new uint8_t[recordSize * ringRecords];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, recordSize * ringRecords, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->SetSupportHostMove(true);

    MsprofAdditionalInfo record = {};
    record.magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
    for (uint32_t i = 0; i < 6U; ++i) {
        ASSERT_EQ(PROFILING_SUCCESS, DevprofDrvAicpu::instance()->ReportAdditionalInfo(0, &record, sizeof(record)));
    }
    ASSERT_EQ(6U, wptrVal);

    MsprofAdditionalInfo nextRecord = {};
    DevprofDrvAicpu::instance()->hostMoveMaxCycles_ = 1;
    EXPECT_EQ(PROFILING_SUCCESS, DevprofDrvAicpu::instance()->ReportAdditionalInfo(0, &nextRecord, sizeof(nextRecord)));
    EXPECT_EQ(6U, wptrVal);
    EXPECT_EQ(1U, DevprofDrvAicpu::instance()->hostMoveOverflowDiscardSize_.load());

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, UninitHostMoveBufferLogsOverflowDiscardSize)
{
    DevprofDrvAicpu::instance()->Reset();
    constexpr uint32_t ringRecords = 4;
    const size_t recordSize = sizeof(MsprofAdditionalInfo);
    uint8_t* buffer = new uint8_t[recordSize * ringRecords];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, recordSize * ringRecords, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->SetSupportHostMove(true);
    // host move is shared by channels 143 and 144; the uninit log must identify the active one.
    SetupHostMoveChannel(144U);
    DevprofDrvAicpu::instance()->hostMoveOverflowDiscardSize_.store(3);

    // The production log uses dlog_error. This stub captures only the last non-OSAL
    // error message, so disable UT_DLOG_SILENT for this single call.
    char oldSilent[16] = {0};
    const char* silentValue = getenv("UT_DLOG_SILENT");
    if (silentValue != nullptr) {
        (void)snprintf_s(oldSilent, sizeof(oldSilent), sizeof(oldSilent) - 1U, "%s", silentValue);
        ASSERT_EQ(0, unsetenv("UT_DLOG_SILENT"));
    }
    ResetLastDlogRecordMsg();
    DevprofDrvAicpu::instance()->UninitHostMoveBuffer();
    if (oldSilent[0] != '\0') {
        ASSERT_EQ(0, setenv("UT_DLOG_SILENT", oldSilent, 1));
    }

    EXPECT_NE(nullptr, strstr(GetLastDlogRecordMsg(), "Host move buffer overflow"));
    EXPECT_NE(nullptr, strstr(GetLastDlogRecordMsg(), "channel id: 144"));
    EXPECT_NE(nullptr, strstr(GetLastDlogRecordMsg(), "discard length: 768 bytes"));
    EXPECT_EQ(0U, DevprofDrvAicpu::instance()->hostMoveOverflowDiscardSize_.load());

    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ReportAdditionalInfo_HostMoveFullLogsEventOnce)
{
    DevprofDrvAicpu::instance()->Reset();
    constexpr uint32_t ringRecords = 8;
    constexpr uint32_t producerCount = 16;
    const size_t recordSize = sizeof(MsprofAdditionalInfo);
    uint8_t* buffer = new uint8_t[recordSize * ringRecords];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, recordSize * ringRecords, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->SetSupportHostMove(true);
    // host move is shared by channels 143 and 144; the full-buffer event must identify the active one.
    SetupHostMoveChannel(144U);

    DevprofDrvAicpu::instance()->hostMoveWriteIndex_.store(ringRecords - 1);
    DevprofDrvAicpu::instance()->hostMoveIdleWriteIndex_.store(ringRecords - 1);
    DevprofDrvAicpu::instance()->hostMoveReadIndex_.store(0);
    wptrVal = ringRecords - 1;
    rptrVal = 0;
    // The first full-buffer cycle emits the event and retries; the second one discards the record.
    DevprofDrvAicpu::instance()->hostMoveMaxCycles_ = 2;

    std::vector<std::thread> producers;
    char oldSilent[16] = {0};
    const char* silentValue = getenv("UT_DLOG_SILENT");
    if (silentValue != nullptr) {
        (void)snprintf_s(oldSilent, sizeof(oldSilent), sizeof(oldSilent) - 1U, "%s", silentValue);
        ASSERT_EQ(0, unsetenv("UT_DLOG_SILENT"));
    }
    ResetDlogEventCount();
    ResetLastDlogEventMsg();
    for (uint32_t i = 0; i < producerCount; ++i) {
        producers.emplace_back([]() {
            MsprofAdditionalInfo record = {};
            (void)DevprofDrvAicpu::instance()->ReportAdditionalInfo(0, &record, sizeof(record));
        });
    }
    for (auto& producer : producers) {
        producer.join();
    }
    if (oldSilent[0] != '\0') {
        ASSERT_EQ(0, setenv("UT_DLOG_SILENT", oldSilent, 1));
    }

    EXPECT_EQ(producerCount, DevprofDrvAicpu::instance()->hostMoveOverflowDiscardSize_.load());
    EXPECT_EQ(1, GetDlogEventCount());
    EXPECT_NE(nullptr, strstr(GetLastDlogEventMsg(), "Host move ring buffer full"));
    EXPECT_NE(nullptr, strstr(GetLastDlogEventMsg(), "channel id: 144"));

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, StopWaitsForActiveHostMoveWriter)
{
    DevprofDrvAicpu::instance()->Reset();
    const size_t recordSize = sizeof(MsprofAdditionalInfo);
    constexpr uint32_t ringRecords = 4;
    uint8_t* buffer = new uint8_t[recordSize * ringRecords];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, recordSize * ringRecords, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->SetSupportHostMove(true);
    DevprofDrvAicpu::instance()->hostMoveActiveWriters_.store(1);

    std::atomic<bool> stopReturned{false};
    std::thread stopThread([&stopReturned]() {
        (void)DevprofDrvAicpu::instance()->Stop();
        stopReturned.store(true);
    });
    std::this_thread::sleep_for(std::chrono::milliseconds(20));
    EXPECT_FALSE(stopReturned.load());
    DevprofDrvAicpu::instance()->hostMoveActiveWriters_.fetch_sub(1);
    stopThread.join();
    EXPECT_TRUE(stopReturned.load());
    EXPECT_FALSE(DevprofDrvAicpu::instance()->hostMoveAcceptingWrites_.load());

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ReleaseWaitsForActiveHostMoveWriter)
{
    DevprofDrvAicpu::instance()->Reset();
    const size_t recordSize = sizeof(MsprofAdditionalInfo);
    constexpr uint32_t ringRecords = 4;
    uint8_t* buffer = new uint8_t[recordSize * ringRecords];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, recordSize * ringRecords, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->SetSupportHostMove(true);
    DevprofDrvAicpu::instance()->hostMoveActiveWriters_.store(1);

    std::atomic<bool> releaseReturned{false};
    std::thread releaseThread([&releaseReturned]() {
        DevprofDrvAicpu::instance()->Release();
        releaseReturned.store(true);
    });
    std::this_thread::sleep_for(std::chrono::milliseconds(20));
    EXPECT_FALSE(releaseReturned.load());
    EXPECT_TRUE(DevprofDrvAicpu::instance()->IsSupportHostMove());
    DevprofDrvAicpu::instance()->hostMoveActiveWriters_.fetch_sub(1);
    releaseThread.join();
    EXPECT_TRUE(releaseReturned.load());
    EXPECT_FALSE(DevprofDrvAicpu::instance()->hostMoveAcceptingWrites_.load());
    EXPECT_EQ(0U, DevprofDrvAicpu::instance()->hostMoveActiveWriters_.load());

    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, TryUpdateHostMoveReadIndex_BatchesWrappedConsumerProgress)
{
    DevprofDrvAicpu::instance()->Reset();
    constexpr uint32_t ringRecords = 8;
    const size_t recordSize = sizeof(MsprofAdditionalInfo);
    uint8_t* buffer = new uint8_t[recordSize * ringRecords];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, recordSize * ringRecords, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->SetSupportHostMove(true);

    DevprofDrvAicpu::instance()->hostMoveWriteIndex_.store(10);
    DevprofDrvAicpu::instance()->hostMoveIdleWriteIndex_.store(10);
    DevprofDrvAicpu::instance()->hostMoveReadIndex_.store(2);
    wptrVal = 2;
    rptrVal = 7;

    EXPECT_TRUE(DevprofDrvAicpu::instance()->TryUpdateHostMoveReadIndex(ringRecords));
    EXPECT_EQ(7U, DevprofDrvAicpu::instance()->hostMoveReadIndex_.load());

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, TryUpdateHostMoveReadIndex_RereadsConsumerProgressAfterCas)
{
    DevprofDrvAicpu::instance()->Reset();
    constexpr uint32_t ringRecords = 8;
    const size_t recordSize = sizeof(MsprofAdditionalInfo);
    uint8_t* buffer = new uint8_t[recordSize * ringRecords];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, recordSize * ringRecords, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->SetSupportHostMove(true);

    DevprofDrvAicpu::instance()->hostMoveWriteIndex_.store(7);
    DevprofDrvAicpu::instance()->hostMoveIdleWriteIndex_.store(7);
    DevprofDrvAicpu::instance()->hostMoveReadIndex_.store(0);
    rptrVal = 1;
    EXPECT_TRUE(DevprofDrvAicpu::instance()->TryUpdateHostMoveReadIndex(ringRecords));
    EXPECT_EQ(1U, DevprofDrvAicpu::instance()->hostMoveReadIndex_.load());

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ReportAdditionalInfo_HostMovePublishesAcrossUint32Boundary)
{
    DevprofDrvAicpu::instance()->Reset();
    constexpr uint32_t ringRecords = 4;
    const size_t recordSize = sizeof(MsprofAdditionalInfo);
    uint8_t* buffer = new uint8_t[recordSize * ringRecords];
    uint32_t wptrVal = 3;
    uint32_t rptrVal = 3;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, recordSize * ringRecords, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->SetSupportHostMove(true);

    constexpr uint64_t boundaryCursor = UINT64_C(0xffffffff);
    constexpr uint64_t startCursor = boundaryCursor - 3U;
    DevprofDrvAicpu::instance()->hostMoveReadIndex_.store(startCursor);
    DevprofDrvAicpu::instance()->hostMoveWriteIndex_.store(boundaryCursor);
    DevprofDrvAicpu::instance()->hostMoveIdleWriteIndex_.store(boundaryCursor);
    wptrVal = 0;
    rptrVal = 0;
    MsprofAdditionalInfo record = {};
    record.magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
    EXPECT_EQ(PROFILING_SUCCESS, DevprofDrvAicpu::instance()->ReportAdditionalInfo(0, &record, sizeof(record)));
    rptrVal = 1;
    EXPECT_EQ(PROFILING_SUCCESS, DevprofDrvAicpu::instance()->ReportAdditionalInfo(0, &record, sizeof(record)));
    EXPECT_EQ(UINT64_C(0x100000000), DevprofDrvAicpu::instance()->hostMoveWriteIndex_.load());
    EXPECT_EQ(0U, wptrVal);

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ReportAdditionalInfo_HostMoveReadCursorTranslatesWrap)
{
    DevprofDrvAicpu::instance()->Reset();
    constexpr uint32_t ringRecords = 4;
    const size_t recordSize = sizeof(MsprofAdditionalInfo);
    uint8_t* buffer = new uint8_t[recordSize * ringRecords];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, recordSize * ringRecords, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->SetSupportHostMove(true);

    DevprofDrvAicpu::instance()->hostMoveReadIndex_.store(2);
    DevprofDrvAicpu::instance()->hostMoveWriteIndex_.store(2);
    DevprofDrvAicpu::instance()->hostMoveIdleWriteIndex_.store(2);
    wptrVal = 2;
    rptrVal = 1;

    MsprofAdditionalInfo record = {};
    record.magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
    DevprofDrvAicpu::instance()->hostMoveAcceptingWrites_.store(false);
    EXPECT_EQ(PROFILING_FAILED, DevprofDrvAicpu::instance()->ReportAdditionalInfo(0, &record, sizeof(record)));
    EXPECT_EQ(2U, wptrVal);

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ReportAdditionalInfo_HostMoveCopyFailureReleasesReservation)
{
    DevprofDrvAicpu::instance()->Reset();
    constexpr uint32_t ringRecords = 8;
    const size_t recordSize = sizeof(MsprofAdditionalInfo);
    uint8_t* buffer = new uint8_t[recordSize * ringRecords];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, recordSize * ringRecords, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->SetSupportHostMove(true);

    MsprofAdditionalInfo record = {};
    record.magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
    MOCKER(memcpy_s).stubs().will(returnValue(EOF));
    EXPECT_EQ(PROFILING_FAILED, DevprofDrvAicpu::instance()->ReportAdditionalInfo(0, &record, sizeof(record)));
    EXPECT_EQ(0U, wptrVal);
    EXPECT_EQ(1U, DevprofDrvAicpu::instance()->hostMoveFailedWriteIndex_.load());
    EXPECT_EQ(1U, DevprofDrvAicpu::instance()->hostMoveIdleWriteIndex_.load());

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ReportAdditionalInfo_HostMoveFullOnStop)
{
    DevprofDrvAicpu::instance()->Reset();
    constexpr uint32_t recordCount = 4;
    const size_t recordSize = sizeof(MsprofAdditionalInfo);
    uint8_t* buffer = new uint8_t[recordSize * recordCount];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, recordSize * recordCount, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->SetSupportHostMove(true);
    DevprofDrvAicpu::instance()->hostMoveAcceptingWrites_.store(false);
    DevprofDrvAicpu::instance()->hostMoveWriteIndex_.store(3);
    DevprofDrvAicpu::instance()->hostMoveIdleWriteIndex_.store(4);
    wptrVal = 3;

    MsprofAdditionalInfo records[1] = {};
    EXPECT_EQ(PROFILING_FAILED, DevprofDrvAicpu::instance()->ReportAdditionalInfo(0, records, sizeof(records)));
    EXPECT_EQ(3U, wptrVal);

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ReportAdditionalInfo_HostMoveInvalidReadPointer)
{
    DevprofDrvAicpu::instance()->Reset();
    constexpr uint32_t recordCount = 4;
    const size_t recordSize = sizeof(MsprofAdditionalInfo);
    uint8_t* buffer = new uint8_t[recordSize * recordCount];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, recordSize * recordCount, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->SetSupportHostMove(true);
    rptrVal = recordCount;

    MsprofAdditionalInfo record = {};
    EXPECT_EQ(PROFILING_FAILED, DevprofDrvAicpu::instance()->ReportAdditionalInfo(0, &record, sizeof(record)));
    EXPECT_EQ(0U, wptrVal);

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ReportAdditionalInfo_HostMoveConcurrentWrites)
{
    DevprofDrvAicpu::instance()->Reset();
    constexpr uint32_t ringRecords = 64;
    const size_t recordSize = sizeof(MsprofAdditionalInfo);
    uint8_t* buffer = new uint8_t[recordSize * ringRecords];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, recordSize * ringRecords, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->SetSupportHostMove(true);

    constexpr uint32_t threadCount = 4;
    constexpr uint32_t writesPerThread = 5;
    std::vector<std::thread> workers;
    std::atomic<uint32_t> successCount{0};
    for (uint32_t t = 0; t < threadCount; ++t) {
        workers.emplace_back([&successCount]() {
            for (uint32_t i = 0; i < writesPerThread; ++i) {
                MsprofAdditionalInfo record = {};
                record.magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
                if (DevprofDrvAicpu::instance()->ReportAdditionalInfo(0, &record, sizeof(record)) ==
                    PROFILING_SUCCESS) {
                    ++successCount;
                }
            }
        });
    }
    for (auto& worker : workers) {
        worker.join();
    }

    EXPECT_EQ(threadCount * writesPerThread, successCount.load());
    EXPECT_EQ(threadCount * writesPerThread, wptrVal);
    const auto* written = reinterpret_cast<const MsprofAdditionalInfo*>(buffer);
    for (uint32_t i = 0; i < threadCount * writesPerThread; ++i) {
        EXPECT_EQ(MSPROF_REPORT_DATA_MAGIC_NUM, written[i].magicNumber);
    }

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ReportAdditionalInfo_HostMoveFullRetryDoesNotBlockInMilliseconds)
{
    DevprofDrvAicpu::instance()->Reset();
    constexpr uint32_t ringRecords = 4;
    const size_t recordSize = sizeof(MsprofAdditionalInfo);
    uint8_t* buffer = new uint8_t[recordSize * ringRecords];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, recordSize * ringRecords, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->SetSupportHostMove(true);

    DevprofDrvAicpu::instance()->hostMoveWriteIndex_.store(3);
    DevprofDrvAicpu::instance()->hostMoveIdleWriteIndex_.store(3);
    DevprofDrvAicpu::instance()->hostMoveReadIndex_.store(0);
    wptrVal = 3;
    rptrVal = 0;
    DevprofDrvAicpu::instance()->hostMoveMaxCycles_ = 100;
    MsprofAdditionalInfo record = {};
    const auto start = std::chrono::steady_clock::now();
    EXPECT_EQ(PROFILING_SUCCESS, DevprofDrvAicpu::instance()->ReportAdditionalInfo(0, &record, sizeof(record)));
    const auto elapsedMs =
        std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now() - start).count();
    EXPECT_LT(elapsedMs, 200) << "full-ring retry took " << elapsedMs << "ms";

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ReportAdditionalInfo_HostMoveDoesNotWaitForPreviousReservedRange)
{
    DevprofDrvAicpu::instance()->Reset();
    constexpr uint32_t ringRecords = 16;
    const size_t recordSize = sizeof(MsprofAdditionalInfo);
    uint8_t* buffer = new uint8_t[recordSize * ringRecords];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, recordSize * ringRecords, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->SetSupportHostMove(true);

    // Slot 0 is reserved by another producer, but its copy is not complete yet.
    DevprofDrvAicpu::instance()->hostMoveIdleWriteIndex_.store(2);
    MsprofAdditionalInfo record = {};
    record.magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
    const auto start = std::chrono::steady_clock::now();
    EXPECT_EQ(PROFILING_SUCCESS, DevprofDrvAicpu::instance()->ReportAdditionalInfo(0, &record, sizeof(record)));
    const auto elapsedMs =
        std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now() - start).count();
    EXPECT_LT(elapsedMs, 20) << "later writer waited for previous reserved range";
    EXPECT_EQ(0U, wptrVal);
    EXPECT_EQ(3U, DevprofDrvAicpu::instance()->hostMoveIdleWriteIndex_.load());
    EXPECT_EQ(0U, DevprofDrvAicpu::instance()->hostMoveWriteIndex_.load());

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ReportAdditionalInfo_HostMovePublishesCompletedPrefix)
{
    DevprofDrvAicpu::instance()->Reset();
    constexpr uint32_t ringRecords = 16;
    const size_t recordSize = sizeof(MsprofAdditionalInfo);
    uint8_t* buffer = new uint8_t[recordSize * ringRecords];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, recordSize * ringRecords, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->SetSupportHostMove(true);

    DevprofDrvAicpu::instance()->hostMoveIdleWriteIndex_.store(1);
    MsprofAdditionalInfo record = {};
    record.magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
    ASSERT_EQ(PROFILING_SUCCESS, DevprofDrvAicpu::instance()->ReportAdditionalInfo(0, &record, sizeof(record)));
    ASSERT_EQ(0U, wptrVal);

    // Complete the previous reserved range, then the current writer must publish the whole prefix.
    DevprofDrvAicpu::instance()->hostMoveCommitCounts_[0].store(1);
    ASSERT_EQ(PROFILING_SUCCESS, DevprofDrvAicpu::instance()->ReportAdditionalInfo(0, &record, sizeof(record)));
    EXPECT_EQ(3U, wptrVal);
    EXPECT_EQ(3U, DevprofDrvAicpu::instance()->hostMoveWriteIndex_.load());

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ReportAdditionalInfo_HostMoveFullWaitsForFiveMsConsumer)
{
    DevprofDrvAicpu::instance()->Reset();
    constexpr uint32_t ringRecords = 4;
    const size_t recordSize = sizeof(MsprofAdditionalInfo);
    uint8_t* buffer = new uint8_t[recordSize * ringRecords];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, recordSize * ringRecords, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->SetSupportHostMove(true);

    DevprofDrvAicpu::instance()->hostMoveWriteIndex_.store(3);
    DevprofDrvAicpu::instance()->hostMoveIdleWriteIndex_.store(3);
    DevprofDrvAicpu::instance()->hostMoveReadIndex_.store(0);
    wptrVal = 3;
    rptrVal = 0;
    MsprofAdditionalInfo record = {};
    record.magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
    std::thread consumer([&rptrVal]() {
        std::this_thread::sleep_for(std::chrono::milliseconds(5));
        rptrVal = 1;
    });
    EXPECT_EQ(PROFILING_SUCCESS, DevprofDrvAicpu::instance()->ReportAdditionalInfo(0, &record, sizeof(record)));
    consumer.join();
    EXPECT_EQ(0U, DevprofDrvAicpu::instance()->hostMoveOverflowDiscardSize_.load());

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, ReportAdditionalInfo_HostMoveHighLoadWithConsumer)
{
    DevprofDrvAicpu::instance()->Reset();
    constexpr uint32_t ringRecords = 1024;
    constexpr uint32_t threadCount = 4;
    constexpr uint32_t writesPerThread = 2500;
    const size_t recordSize = sizeof(MsprofAdditionalInfo);
    uint8_t* buffer = new uint8_t[recordSize * ringRecords];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, recordSize * ringRecords, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->SetSupportHostMove(true);

    std::atomic<uint32_t> producedCount{0};
    std::atomic<uint32_t> consumedCount{0};
    std::atomic<bool> produceDone{false};
    std::atomic<uint32_t> failedWrites{0};
    std::vector<uint8_t> seenRecords(threadCount * writesPerThread, 0);
    std::vector<std::thread> workers;
    constexpr uint32_t maxBatchRecords = 7;
    for (uint32_t t = 0; t < threadCount; ++t) {
        workers.emplace_back([&producedCount, &failedWrites, t]() {
            uint32_t reported = 0;
            uint32_t callCount = 0;
            while (reported < writesPerThread) {
                const uint32_t batchCount = std::min(1U + (callCount % maxBatchRecords), writesPerThread - reported);
                MsprofAdditionalInfo records[maxBatchRecords] = {};
                uint32_t sequence = (t * writesPerThread) + reported;
                for (uint32_t i = 0; i < batchCount; ++i) {
                    records[i].magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
                    records[i].timeStamp = sequence++;
                }

                const uint32_t reportSize = static_cast<uint32_t>(sizeof(MsprofAdditionalInfo) * batchCount);
                if (DevprofDrvAicpu::instance()->ReportAdditionalInfo(0, records, reportSize) == PROFILING_SUCCESS) {
                    producedCount.fetch_add(batchCount);
                } else {
                    failedWrites.fetch_add(batchCount);
                }
                reported += batchCount;
                ++callCount;
            }
        });
    }

    auto consumer = [&]() {
        while (!produceDone.load() || (consumedCount.load() < producedCount.load())) {
            const uint32_t readIndex = rptrVal;
            const uint32_t writeIndex = wptrVal;
            if (readIndex == writeIndex) {
                std::this_thread::sleep_for(std::chrono::milliseconds(5));
                continue;
            }
            uint32_t count = writeIndex > readIndex ? writeIndex - readIndex : ringRecords - readIndex + writeIndex;
            count = std::min(count, ringRecords - 1U);
            for (uint32_t i = 0; i < count; ++i) {
                const auto* record = reinterpret_cast<const MsprofAdditionalInfo*>(
                    buffer + ((readIndex + i) % ringRecords) * recordSize);
                EXPECT_EQ(MSPROF_REPORT_DATA_MAGIC_NUM, record->magicNumber);
                ASSERT_LT(record->timeStamp, seenRecords.size());
                EXPECT_EQ(0, seenRecords[record->timeStamp]++);
            }
            consumedCount.fetch_add(count);
            rptrVal = (readIndex + count) % ringRecords;
            std::this_thread::sleep_for(std::chrono::milliseconds(5));
        }
    };
    std::thread consumerThread(consumer);
    for (auto& worker : workers) {
        worker.join();
    }
    produceDone.store(true);
    consumerThread.join();

    EXPECT_EQ(threadCount * writesPerThread, producedCount.load());
    EXPECT_EQ(0U, failedWrites.load());
    EXPECT_EQ(producedCount.load(), consumedCount.load());
    for (const auto seen : seenRecords) {
        EXPECT_EQ(1, seen);
    }
    EXPECT_EQ(wptrVal, rptrVal);
    EXPECT_EQ(0U, DevprofDrvAicpu::instance()->hostMoveOverflowDiscardSize_.load());

    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}

static int32_t ProfStartFailed() { return PROFILING_FAILED; }

static int32_t ProfStartSuccess() { return PROFILING_SUCCESS; }

static void AdprofExit() { return; }

TEST_F(DEVPROF_DRV_UTEST, AdprofAicpuStartRegister)
{
    AicpuStartPara aicpuStartPara = {0, 111, 1, 0};
    EXPECT_EQ(PROFILING_SUCCESS, AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara));
    aicpuStartPara.profConfig = 2; // aicpu = on

    EXPECT_EQ(PROFILING_FAILED, AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara));
    aicpuStartPara.channelId = 143;

    MOCKER(halProfSampleRegister).stubs().will(returnValue(1)).then(returnValue((int)DRV_ERROR_NONE));
    EXPECT_EQ(PROFILING_FAILED, AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara));

    MOCKER(ProfSendEvent).stubs().will(returnValue(PROFILING_FAILED)).then(returnValue(PROFILING_SUCCESS));
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

TEST_F(DEVPROF_DRV_UTEST, AdprofAicpuStartRegister_Multi)
{
    MOCKER(halProfSampleRegister).stubs().will(returnValue((int)DRV_ERROR_NONE)).then(returnValue(-1));
    MOCKER(halProfSampleRegisterEx).stubs().will(returnValue((int)DRV_ERROR_NONE));

    MOCKER(ProfSendEvent).stubs().will(returnValue(PROFILING_SUCCESS)).then(returnValue(PROFILING_FAILED));

    AicpuStartPara aicpuStartPara = {0, 111, 143, 2};
    std::vector<std::thread> th;
    for (int i = 0; i < 10; i++) {
        th.push_back(std::thread([this, &aicpuStartPara]() -> void {
            EXPECT_EQ(PROFILING_SUCCESS, AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara));
        }));
    }
    for_each(th.begin(), th.end(), std::mem_fn(&std::thread::join));
}

TEST_F(DEVPROF_DRV_UTEST, ProfSendEvent)
{
    uint32_t devId = 0;
    int32_t hostPid = 123;
    char* grpName = "aicpu_grp";

    MOCKER(halEschedQueryInfo).stubs().will(repeat(1, 10)).then(returnValue(DRV_ERROR_NONE));
    EXPECT_EQ(PROFILING_FAILED, ProfSendEvent(devId, hostPid, grpName));

    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(1)).then(returnValue(DRV_ERROR_NONE));
    EXPECT_EQ(PROFILING_FAILED, ProfSendEvent(devId, hostPid, grpName));
    EXPECT_EQ(PROFILING_SUCCESS, ProfSendEvent(devId, hostPid, grpName));
}

TEST_F(DEVPROF_DRV_UTEST, ReportData)
{
    AicpuStartPara aicpuStartPara = {0, 111, 143, 0};
    EXPECT_EQ(PROFILING_SUCCESS, AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara));
    aicpuStartPara.profConfig = 2U | 1U | ADPROF_TASK_TIME_L0; // aicpu = on
    MOCKER(ProfSendEvent).stubs().will(returnValue(PROFILING_SUCCESS));
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

    int32_t ret = AdprofReportAdditionalInfo(0, static_cast<void*>(&additionalInfo), sizeof(MsprofAdditionalInfo) - 1);
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = AdprofReportAdditionalInfo(0, static_cast<void*>(&additionalInfo), sizeof(MsprofAdditionalInfo));
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    uint32_t maxCount = REPORT_BUFF_SIZE / sizeof(MsprofAdditionalInfo);
    for (uint32_t i = 0; i < maxCount + 2; i++) {
        AdprofReportAdditionalInfo(0, static_cast<void*>(&additionalInfo), sizeof(MsprofAdditionalInfo));
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
    AdprofReportAdditionalInfo(1, static_cast<void*>(&additionalInfo), sizeof(MsprofAdditionalInfo));
    prof_sample_start_para startPara = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfStartAicpu(&startPara)); // halProfSampleDataReport error
    prof_sample_stop_para stopPara = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAicpu(&stopPara));

    AdprofReportAdditionalInfo(1, static_cast<void*>(&additionalInfo), sizeof(MsprofAdditionalInfo));
    EXPECT_EQ(PROFILING_SUCCESS, ProfStartAicpu(&startPara)); // halProfQueryAvailBufLen 2 error
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAicpu(&stopPara));

    EXPECT_EQ(PROFILING_SUCCESS, ProfStartAicpu(&startPara)); // halProfQueryAvailBufLen 1 error
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAicpu(&stopPara));

    MOCKER(OsalCreateTaskWithThreadAttr).stubs().will(returnValue(-1));
    EXPECT_EQ(PROFILING_FAILED, ProfStartAicpu(&startPara)); // create thread error
}

TEST_F(DEVPROF_DRV_UTEST, DevprofDrvAdprof)
{
    AdprofCallBack adprofCallBack = {ProfStartFailed, ProfStartFailed, AdprofExit};
    MOCKER(halProfSampleRegister).stubs().will(returnValue((int)DRV_ERROR_NONE));
    MOCKER(ProfSendEvent).stubs().will(returnValue(PROFILING_FAILED)).then(returnValue(PROFILING_SUCCESS));
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
    EXPECT_EQ(PROFILING_SUCCESS, ReportAdprofFileChunk(static_cast<void*>(&fileChunk)));

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
        ReportAdprofFileChunk(static_cast<void*>(&fileChunk));
    }

    prof_sample_stop_para stopPara = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAdprof(&stopPara));
    EXPECT_EQ(PROFILING_FAILED, ReportAdprofFileChunk(static_cast<void*>(&fileChunk)));
}

TEST_F(DEVPROF_DRV_UTEST, AdprofGetHashId)
{
    MOCKER(Devprof::ProfSendEvent).stubs().will(returnValue(PROFILING_SUCCESS));

    AicpuStartPara aicpuStartPara = {0, 111, 143, 2}; // aicpu = on
    EXPECT_EQ(PROFILING_SUCCESS, AdprofAicpuStartRegister(ProfStartSuccess, &aicpuStartPara));
    EXPECT_EQ(PROFILING_FAILED, AdprofGetHashId(nullptr, 0));
    std::string test("test");
    EXPECT_NE(PROFILING_FAILED, AdprofGetHashId(test.c_str(), test.length()));
}

TEST_F(DEVPROF_DRV_UTEST, AdprofStr2Id)
{
    EXPECT_EQ(PROFILING_FAILED, AdprofStr2Id(nullptr, 0));
    std::string test("test");
    EXPECT_EQ(AdprofGetHashId(test.c_str(), test.length()), AdprofStr2Id(test.c_str(), test.length()));
}

static int halProfQueryAvailBufLenStub(unsigned int dev_id, unsigned int chan_id, unsigned int* buff_avail_len)
{
    static int count = 0;
    if (count == 0) {
        *buff_avail_len = 1024 * 1024;
    } else if (count == 1) {
        *buff_avail_len = 1024 * 1024;
    } else if (count == 2) { // aicpu
        *buff_avail_len = 0;
    } else if (count == 3) {
        *buff_avail_len = 1024 * 1024;
    } else if (count == 4) { // adprof
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
    AdprofReportAdditionalInfo(1, static_cast<void*>(&additionalInfo), sizeof(MsprofAdditionalInfo));
    OsalSleep(5);
    prof_sample_stop_para stopPara = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAicpu(&stopPara));

    AdprofCallBack adprofCallBack = {ProfStartSuccess, ProfStartSuccess, AdprofExit};
    MOCKER(halProfSampleRegister).stubs().will(returnValue((int)DRV_ERROR_NONE));
    MOCKER(halProfSampleRegisterEx).stubs().will(returnValue((int)DRV_ERROR_NONE));
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
    EXPECT_EQ(PROFILING_SUCCESS, ReportAdprofFileChunk(static_cast<void*>(&fileChunk)));
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
    void* addPtr = malloc(1024); // 1024byte
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
    MOCKER(halProfSampleDataReport).stubs().will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

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

    uint8_t* buffer = new uint8_t[4 * 1024 * 1024];
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
    uint8_t* buffer = new uint8_t[4 * 1024 * 1024];
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

    uint8_t* buffer = new uint8_t[4 * 1024 * 1024];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, 4 * 1024 * 1024, &wptrVal, &rptrVal);

    DevprofDrvAicpu::instance()->Reset();
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

    uint8_t* buffer = new uint8_t[4 * 1024 * 1024];
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

TEST_F(DEVPROF_DRV_UTEST, UninitHostMoveBuffer)
{
    DevprofDrvAicpu::instance()->Reset();
    DevprofDrvAicpu::instance()->UninitHostMoveBuffer();

    DevprofDrvAicpu::instance()->SetSupportHostMove(true);
    uint8_t* buffer = new uint8_t[4 * 1024 * 1024];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, 4 * 1024 * 1024, &wptrVal, &rptrVal);
    DevprofDrvAicpu::instance()->RecordHostMoveBufferAddresses(&info);
    DevprofDrvAicpu::instance()->UninitHostMoveBuffer();
    delete[] buffer;
    GlobalMockObject::verify();
}

TEST_F(DEVPROF_DRV_UTEST, RegisterDrvChannel_Success)
{
    DevprofDrvAicpu::instance()->Reset();
    AicpuStartPara aicpuStartPara = {0, 111, 143, 2};

    MOCKER(halProfSampleRegister).stubs().will(returnValue((int)DRV_ERROR_NONE));
    MOCKER(halProfSampleRegisterEx).stubs().will(returnValue((int)DRV_ERROR_NONE));
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

// host-move 模式没有背景线程，真实 PAUSE 停止路径必须同步回传 str2id，
// 防止 release 阶段释放共享 buffer 后 hash key 丢失。
TEST_F(DEVPROF_DRV_UTEST, ProfStopAicpu_HostMovePauseReportsStr2Id)
{
    DevprofDrvAicpu::instance()->Reset();
    auto* hashData = analysis::dvvp::transport::HashData::instance();
    const bool hashDataInited = hashData->IsInit();
    hashData->Uninit();
    hashData->hashVector_.clear();
    hashData->Init();
    uint8_t* buffer = new uint8_t[4 * 1024 * 1024];
    uint32_t wptrVal = 0;
    uint32_t rptrVal = 0;
    Devprof::AicpuUserProfileBufferInfo info;
    SetupHostMoveBufferInfo(info, buffer, 4 * 1024 * 1024, &wptrVal, &rptrVal);

    ProfSampleStartPara startPara = {0};
    startPara.is_support_host_move = 1;
    startPara.out_data = &info;
    startPara.out_data_max_len = sizeof(Devprof::AicpuUserProfileBufferInfo);
    EXPECT_EQ(PROFILING_SUCCESS, ProfStartAicpu(&startPara));

    analysis::dvvp::transport::HashData::instance()->GenHashId("stop_kernel_name");

    prof_sample_stop_para stopPara = {0};
    stopPara.release_flag = PROF_STOP_STAGE_PAUSE;
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAicpu(&stopPara));

    EXPECT_GT(wptrVal, 0U);
    const MsprofAdditionalInfo* record = reinterpret_cast<const MsprofAdditionalInfo*>(buffer);
    EXPECT_EQ(0, strncmp(reinterpret_cast<const char*>(record->data), STR2ID_MARK, strlen(STR2ID_MARK)));

    hashData->Uninit();
    hashData->hashVector_.clear();
    if (hashDataInited) {
        hashData->Init();
    }
    DevprofDrvAicpu::instance()->Release();
    delete[] buffer;
    GlobalMockObject::verify();
}
