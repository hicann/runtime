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
#include <atomic>
#include <chrono>
#include <condition_variable>
#include <memory>
#include <mutex>
#include <string>
#include <thread>
#include <vector>
#include "errno/error_code.h"
#include "transport/injection_transport.h"

using analysis::dvvp::ProfileFileChunk;
using analysis::dvvp::common::error::PROFILING_FAILED;
using analysis::dvvp::common::error::PROFILING_SUCCESS;
using analysis::dvvp::transport::InjectionTransport;

namespace {
constexpr uint32_t WAIT_TIMEOUT_IMMEDIATE_SEC = 0U;
constexpr uint32_t WAIT_TIMEOUT_SHORT_SEC = 1U;
constexpr uint32_t WAIT_CALLBACK_START_TIMEOUT_MS = 1000U;
constexpr uint32_t CONCURRENT_LOOP_NUM = 100U;
constexpr size_t SHORT_CHUNK_SIZE = 2U;
constexpr size_t OVERSIZED_CHUNK_SIZE = 10U;

std::vector<MsprofRawData> g_rawDataList;
std::atomic<bool> callbackStarted(false);
std::atomic<bool> callbackReleased(false);
std::condition_variable callbackCv;
std::mutex callbackMutex;

int32_t SaveRawData(MsprofRawData* rawData)
{
    if (rawData == nullptr) {
        return PROFILING_FAILED;
    }
    g_rawDataList.push_back(*rawData);
    return PROFILING_SUCCESS;
}

int32_t FailRawData(MsprofRawData* rawData)
{
    if (rawData != nullptr) {
        g_rawDataList.push_back(*rawData);
    }
    return PROFILING_FAILED;
}

int32_t BlockRawData(MsprofRawData* rawData)
{
    if (rawData != nullptr) {
        g_rawDataList.push_back(*rawData);
    }
    callbackStarted.store(true);
    callbackCv.notify_all();
    while (!callbackReleased.load()) {
        std::this_thread::sleep_for(std::chrono::milliseconds(10));
    }
    return PROFILING_SUCCESS;
}

std::shared_ptr<ProfileFileChunk> MakeFileChunk(const std::string& fileName, size_t size)
{
    auto fileChunk = std::make_shared<ProfileFileChunk>();
    fileChunk->fileName = fileName;
    fileChunk->extraInfo = "compute.3";
    fileChunk->offset = 0;
    fileChunk->chunkModule = 1;
    fileChunk->chunk.assign(size, 'a');
    fileChunk->chunkSize = size;
    fileChunk->isLastChunk = true;
    return fileChunk;
}
} // namespace

class INJECTION_TRANSPORT_UTEST : public testing::Test {
protected:
    void SetUp() override
    {
        g_rawDataList.clear();
        callbackStarted.store(false);
        callbackReleased.store(false);
    }
};

TEST_F(INJECTION_TRANSPORT_UTEST, IsLastChunkMeansLastSliceOfSingleProfileFileChunk)
{
    InjectionTransport transport(SaveRawData);
    auto fileChunk = MakeFileChunk("data/stars_soc.data", 600);
    fileChunk->offset = static_cast<size_t>(-1);
    fileChunk->isLastChunk = false;
    EXPECT_EQ(PROFILING_SUCCESS, transport.SendBuffer(fileChunk));
    ASSERT_EQ(3U, g_rawDataList.size());
    EXPECT_EQ(RAW_DATA_MAXSIZE, g_rawDataList[0].chunkSize);
    EXPECT_EQ(RAW_DATA_MAXSIZE, g_rawDataList[1].chunkSize);
    EXPECT_EQ(88U, g_rawDataList[2].chunkSize);
    EXPECT_EQ(0U, g_rawDataList[0].offset);
    EXPECT_EQ(RAW_DATA_MAXSIZE, g_rawDataList[1].offset);
    EXPECT_EQ(RAW_DATA_MAXSIZE * 2U, g_rawDataList[2].offset);
    EXPECT_FALSE(g_rawDataList[0].isLastChunk);
    EXPECT_FALSE(g_rawDataList[1].isLastChunk);
    EXPECT_TRUE(g_rawDataList[2].isLastChunk);
    EXPECT_EQ(LOG_DATA_TYPE, g_rawDataList[0].type);
    EXPECT_EQ(3, g_rawDataList[0].deviceId);
    std::string rebuilt;
    for (const auto& rawData : g_rawDataList) {
        rebuilt.append(rawData.chunk, rawData.chunkSize);
    }
    EXPECT_EQ(fileChunk->chunk, rebuilt);
}

TEST_F(INJECTION_TRANSPORT_UTEST, ParseDeviceIdFailedFallbackToZero)
{
    InjectionTransport transport(SaveRawData);
    auto zeroDevChunk = MakeFileChunk("data/stars_soc.data", 1);
    zeroDevChunk->extraInfo = "compute.0";
    EXPECT_EQ(PROFILING_SUCCESS, transport.SendBuffer(zeroDevChunk));
    auto invalidDevChunk = MakeFileChunk("data/stars_soc.data", 1);
    invalidDevChunk->extraInfo = "compute.invalid";
    EXPECT_EQ(PROFILING_SUCCESS, transport.SendBuffer(invalidDevChunk));
    ASSERT_EQ(2U, g_rawDataList.size());
    EXPECT_EQ(0, g_rawDataList[0].deviceId);
    EXPECT_EQ(0, g_rawDataList[1].deviceId);
}

TEST_F(INJECTION_TRANSPORT_UTEST, ConvertRawDataTypeByFileName)
{
    InjectionTransport transport(SaveRawData);
    EXPECT_EQ(PROFILING_SUCCESS, transport.SendBuffer(MakeFileChunk("data/stars_soc.data", 1)));
    EXPECT_EQ(PROFILING_SUCCESS, transport.SendBuffer(MakeFileChunk("data/ffts_profile.data", 1)));
    EXPECT_EQ(PROFILING_SUCCESS, transport.SendBuffer(MakeFileChunk("data/biu_perf_0.data", 1)));
    EXPECT_EQ(PROFILING_SUCCESS, transport.SendBuffer(MakeFileChunk("data/pc_sampling_0.data", 1)));
    ASSERT_EQ(4U, g_rawDataList.size());
    EXPECT_EQ(LOG_DATA_TYPE, g_rawDataList[0].type);
    EXPECT_EQ(PMU_DATA_TYPE, g_rawDataList[1].type);
    EXPECT_EQ(BIU_PERF_DATA_TYPE, g_rawDataList[2].type);
    EXPECT_EQ(PC_SAMPLING_DATA_TYPE, g_rawDataList[3].type);
}

TEST_F(INJECTION_TRANSPORT_UTEST, UnsupportedFileNameSkipsCallback)
{
    InjectionTransport transport(SaveRawData);
    EXPECT_EQ(PROFILING_SUCCESS, transport.SendBuffer(MakeFileChunk("data/unknown.data", 1)));
    EXPECT_EQ(PROFILING_SUCCESS, transport.SendBuffer(MakeFileChunk("data/stars_soc_profile.data", 1)));
    EXPECT_TRUE(g_rawDataList.empty());
}

TEST_F(INJECTION_TRANSPORT_UTEST, EmptyFileChunkSkipsCallback)
{
    InjectionTransport transport(SaveRawData);
    EXPECT_EQ(PROFILING_SUCCESS, transport.SendBuffer(MakeFileChunk("data/stars_soc.data", 0)));

    auto zeroChunkSize = MakeFileChunk("data/stars_soc.data", 1);
    zeroChunkSize->chunkSize = 0;
    EXPECT_EQ(PROFILING_SUCCESS, transport.SendBuffer(zeroChunkSize));
    EXPECT_TRUE(g_rawDataList.empty());
}

TEST_F(INJECTION_TRANSPORT_UTEST, SendBufferUsesActualChunkSizeWhenChunkSizeIsOversized)
{
    InjectionTransport transport(SaveRawData);
    auto fileChunk = MakeFileChunk("data/stars_soc.data", SHORT_CHUNK_SIZE);
    fileChunk->chunkSize = OVERSIZED_CHUNK_SIZE;

    EXPECT_EQ(PROFILING_SUCCESS, transport.SendBuffer(fileChunk));
    ASSERT_EQ(1U, g_rawDataList.size());
    EXPECT_EQ(SHORT_CHUNK_SIZE, g_rawDataList[0].chunkSize);
    EXPECT_TRUE(g_rawDataList[0].isLastChunk);
}

TEST_F(INJECTION_TRANSPORT_UTEST, CallbackFailedDoesNotFailSendBuffer)
{
    InjectionTransport transport(FailRawData);
    EXPECT_EQ(PROFILING_SUCCESS, transport.SendBuffer(MakeFileChunk("data/pc_sampling_0.data", 300)));
    ASSERT_EQ(2U, g_rawDataList.size());
    EXPECT_EQ(2U, transport.GetCallbackFailedCount());
    EXPECT_EQ(300U, transport.GetCallbackFailedBytes());
}

TEST_F(INJECTION_TRANSPORT_UTEST, WaitAllCallbackDoneTimeoutAndSuccess)
{
    InjectionTransport transport(BlockRawData);
    std::thread worker([&transport]() { (void)transport.SendBuffer(MakeFileChunk("data/stars_soc.data", 1)); });
    std::unique_lock<std::mutex> lock(callbackMutex);
    bool callbackStartedInTime = callbackCv.wait_for(
        lock, std::chrono::milliseconds(WAIT_CALLBACK_START_TIMEOUT_MS), []() { return callbackStarted.load(); });
    EXPECT_TRUE(callbackStartedInTime);
    if (callbackStartedInTime) {
        const auto waitBegin = std::chrono::steady_clock::now();
        EXPECT_EQ(PROFILING_FAILED, transport.WaitAllCallbackDone(WAIT_TIMEOUT_IMMEDIATE_SEC));
        const auto waitCost = std::chrono::steady_clock::now() - waitBegin;
        EXPECT_LT(waitCost, std::chrono::seconds(WAIT_TIMEOUT_SHORT_SEC));
    }

    callbackReleased.store(true);
    worker.join();
    EXPECT_EQ(PROFILING_SUCCESS, transport.WaitAllCallbackDone(WAIT_TIMEOUT_SHORT_SEC));
}

TEST_F(INJECTION_TRANSPORT_UTEST, WaitAllCallbackDoneReturnsSuccessWithoutPendingBuffer)
{
    InjectionTransport transport(SaveRawData);
    EXPECT_EQ(PROFILING_SUCCESS, transport.WaitAllCallbackDone(WAIT_TIMEOUT_IMMEDIATE_SEC));
}

TEST_F(INJECTION_TRANSPORT_UTEST, SendRawBufferSuccessAndInvalidLength)
{
    InjectionTransport transport(SaveRawData);
    const char data[] = "abc";

    EXPECT_EQ(PROFILING_SUCCESS, transport.SendBuffer(data, sizeof(data)));
    EXPECT_TRUE(g_rawDataList.empty());

    EXPECT_EQ(PROFILING_FAILED, transport.SendBuffer(data, 0));
    EXPECT_EQ(PROFILING_FAILED, transport.SendBuffer(data, -1));
}

TEST_F(INJECTION_TRANSPORT_UTEST, CloseSessionAndWriteDoneReturnSuccess)
{
    InjectionTransport transport(SaveRawData);
    transport.WriteDone();
    EXPECT_EQ(PROFILING_SUCCESS, transport.CloseSession());
}

TEST_F(INJECTION_TRANSPORT_UTEST, RegisterAndUnRegisterRawDataCallback)
{
    InjectionTransport transport(nullptr);
    EXPECT_FALSE(transport.IsRegisterRawDataCallback());
    EXPECT_EQ(PROFILING_FAILED, transport.SendBuffer(MakeFileChunk("data/stars_soc.data", 1)));

    transport.RegisterRawDataCallback(SaveRawData);
    EXPECT_TRUE(transport.IsRegisterRawDataCallback());
    EXPECT_EQ(PROFILING_SUCCESS, transport.SendBuffer(MakeFileChunk("data/stars_soc.data", 1)));
    ASSERT_EQ(1U, g_rawDataList.size());

    transport.UnRegisterRawDataCallback();
    EXPECT_FALSE(transport.IsRegisterRawDataCallback());
    EXPECT_EQ(PROFILING_FAILED, transport.SendBuffer(MakeFileChunk("data/stars_soc.data", 1)));
    EXPECT_EQ(1U, g_rawDataList.size());
}

TEST_F(INJECTION_TRANSPORT_UTEST, ConcurrentRegisterAndQuerySmoke)
{
    InjectionTransport transport(nullptr);
    std::atomic<bool> start(false);
    std::thread registerThread([&transport, &start]() {
        while (!start.load()) {
            std::this_thread::yield();
        }
        for (uint32_t i = 0; i < CONCURRENT_LOOP_NUM; ++i) {
            transport.RegisterRawDataCallback(SaveRawData);
            (void)transport.IsRegisterRawDataCallback();
            transport.UnRegisterRawDataCallback();
        }
    });

    std::thread queryThread([&transport, &start]() {
        start.store(true);
        for (uint32_t i = 0; i < CONCURRENT_LOOP_NUM; ++i) {
            (void)transport.IsRegisterRawDataCallback();
        }
    });

    registerThread.join();
    queryThread.join();
    SUCCEED();
}

TEST_F(INJECTION_TRANSPORT_UTEST, InvalidInputReturnsFailed)
{
    InjectionTransport transport(SaveRawData);
    EXPECT_EQ(PROFILING_FAILED, transport.SendBuffer(nullptr, 0));
    EXPECT_EQ(PROFILING_FAILED, transport.SendBuffer(nullptr));
}
