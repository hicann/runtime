/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include <atomic>
#include <functional>
#include <mutex>
#include <string>
#include <thread>
#include <unordered_set>
#include <vector>
#include "mockcpp/mockcpp.hpp"
#include "dump_manager.h"
#include "utils.h"
#include "common/thread.h"
#include "rts/rts_snapshot.h"
#include "adx_dump_record.h"
#include "adx_dump_process.h"
#include "adx_datadump_server.h"

using namespace Adx;

namespace {
static void WaitInterval_stub(uint32_t intervalSec) { (void)intervalSec; }

std::mutex g_probeMtx;
std::vector<std::string> g_probeSamples;

int32_t ConcurrencyProbeCallback(uint64_t dumpSwitch, const char* dumpConfig, int32_t size)
{
    (void)dumpSwitch;
    if (dumpConfig == nullptr || size <= 0) {
        return 0;
    }
    const std::lock_guard<std::mutex> lk(g_probeMtx);
    g_probeSamples.emplace_back(dumpConfig, static_cast<size_t>(size));
    return 0;
}

int32_t ConcurrencyMessageCallback(const DumpChunk*, int32_t) { return 0; }

void RunConcurrentConfigWriter(
    std::atomic<bool>& go, std::atomic<bool>& stop, const std::string& cfgA, const std::string& cfgB)
{
    while (!go.load()) {
        std::this_thread::yield();
    }
    for (int32_t i = 0; i < 100; ++i) {
        const std::string& cfg = (i % 2 == 0) ? cfgA : cfgB;
        (void)DumpManager::Instance().SetDumpConfig(cfg.c_str(), cfg.size());
    }
    stop.store(true);
}

void RunConcurrentArgsCaller(std::atomic<bool>& go, std::atomic<bool>& stop, const std::string& dumpPath)
{
    while (!go.load()) {
        std::this_thread::yield();
    }
    while (!stop.load()) {
        (void)DumpManager::Instance().StartDumpArgs(dumpPath);
        (void)DumpManager::Instance().StopDumpArgs();
    }
}

void RunConcurrentCallbackRegistrar(std::atomic<bool>& go, std::atomic<bool>& stop)
{
    while (!go.load()) {
        std::this_thread::yield();
    }
    for (int32_t i = 0; i < 2000; ++i) {
        (void)DumpManager::Instance().RegisterCallback(
            3000 + i % 8, ConcurrencyProbeCallback, ConcurrencyProbeCallback);
    }
    stop.store(true);
}
} // namespace

#define JSON_BASE ADUMP_BASE_DIR "stub/data/json/"

class AdumpConcurrencyUtest : public testing::Test {
protected:
    virtual void SetUp()
    {
        MOCKER(DumpResourceSafeMap::WaitInterval).stubs().will(invoke(WaitInterval_stub));
        MOCKER(&AdxDumpRecord::RecordDumpDataToQueue).stubs().will(returnValue(true));
    }
    virtual void TearDown()
    {
        DumpManager::Instance().Reset();
        DumpManager::Instance().opInfoRecordPath_.clear();
        GlobalMockObject::verify();
    }
};

TEST_F(AdumpConcurrencyUtest, Test_AdxDumpRecord_UpdateDumpInitNum_ConcurrentRmwBalance)
{
    constexpr int32_t kPrecharge = 100;
    constexpr int32_t kThreads = 8;
    constexpr int32_t kIters = 2000;
    for (int32_t i = 0; i < kPrecharge; ++i) {
        AdxDumpRecord::Instance().UpdateDumpInitNum(true);
    }
    const int32_t startNum = AdxDumpRecord::Instance().GetDumpInitNum();
    std::atomic<bool> go{false};
    std::vector<std::thread> workers;
    for (int32_t t = 0; t < kThreads; ++t) {
        workers.emplace_back([&go]() {
            while (!go.load()) {
                std::this_thread::yield();
            }
            for (int32_t i = 0; i < kIters; ++i) {
                AdxDumpRecord::Instance().UpdateDumpInitNum(true);
            }
        });
    }
    go.store(true);
    for (auto& w : workers) {
        w.join();
    }
    const int32_t totalInc = kThreads * kIters;
    for (int32_t i = 0; i < totalInc; ++i) {
        AdxDumpRecord::Instance().UpdateDumpInitNum(false);
    }
    const int32_t finalNum = AdxDumpRecord::Instance().GetDumpInitNum();
    EXPECT_EQ(finalNum, startNum);
}

TEST_F(AdumpConcurrencyUtest, Test_AdxDataDumpServer_ConcurrentInitUnInit)
{
    MOCKER(&AdxDumpRecord::HasStartedServer).stubs().will(returnValue(true));
    MOCKER(&AdxDumpRecord::CanShutdownServer).stubs().will(returnValue(false));
    DumpManager::Instance().StopDataDumpServer();
    ASSERT_EQ(AdxDumpRecord::Instance().GetDumpInitNum(), 0);

    constexpr int32_t kPrecharge = 50;
    constexpr int32_t kThreads = 4;
    constexpr int32_t kIters = 200;
    for (int32_t i = 0; i < kPrecharge; ++i) {
        AdxDumpRecord::Instance().UpdateDumpInitNum(true);
    }
    std::atomic<bool> go{false};
    std::vector<std::thread> workers;
    for (int32_t t = 0; t < kThreads; ++t) {
        workers.emplace_back([&go]() {
            while (!go.load()) {
                std::this_thread::yield();
            }
            for (int32_t i = 0; i < kIters; ++i) {
                (void)AdxDataDumpServerInit();
            }
        });
    }
    go.store(true);
    for (auto& w : workers) {
        w.join();
    }
    const int32_t totalInc = kThreads * kIters;
    for (int32_t i = 0; i < totalInc; ++i) {
        (void)AdxDataDumpServerUnInit();
    }
    const int32_t finalNum = AdxDumpRecord::Instance().GetDumpInitNum();
    EXPECT_EQ(finalNum, kPrecharge);
    DumpManager::Instance().StopDataDumpServer();
    EXPECT_EQ(AdxDumpRecord::Instance().GetDumpInitNum(), 0);
}

TEST_F(AdumpConcurrencyUtest, Test_DumpConfigInfo_ConcurrentUpdate_SnapshotIntegrity)
{
    MOCKER(&AdxDumpRecord::HasStartedServer).stubs().will(returnValue(true));
    MOCKER(&AdxDumpRecord::CanShutdownServer).stubs().will(returnValue(false));
    DumpManager::Instance().StopDataDumpServer();
    const std::string cfgA = ReadFileToString(JSON_BASE "common/only_path.json");
    const std::string cfgB = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    ASSERT_FALSE(cfgA.empty());
    ASSERT_FALSE(cfgB.empty());
    ASSERT_NE(cfgA, cfgB);

    ASSERT_EQ(
        DumpManager::Instance().RegisterCallback(2003, ConcurrencyProbeCallback, ConcurrencyProbeCallback),
        ADUMP_SUCCESS);

    const std::string dumpPath = "./llt_conc_dump_args";
    system("rm -rf ./llt_conc_dump_args");
    {
        const std::lock_guard<std::mutex> lk(g_probeMtx);
        g_probeSamples.clear();
    }

    std::atomic<bool> go{false};
    std::atomic<bool> stop{false};
    std::thread cfgWriter([&]() { RunConcurrentConfigWriter(go, stop, cfgA, cfgB); });
    std::thread argsCaller([&]() { RunConcurrentArgsCaller(go, stop, dumpPath); });
    go.store(true);
    cfgWriter.join();
    argsCaller.join();
    (void)DumpManager::Instance().StopDumpArgs();
    (void)DumpManager::Instance().UnSetDumpConfig();
    DumpManager::Instance().StopDataDumpServer();

    int32_t badSamples = 0;
    int32_t totalSamples = 0;
    {
        const std::lock_guard<std::mutex> lk(g_probeMtx);
        totalSamples = static_cast<int32_t>(g_probeSamples.size());
        for (const auto& sample : g_probeSamples) {
            if (sample != cfgA && sample != cfgB) {
                ++badSamples;
            }
        }
        g_probeSamples.clear();
    }
    EXPECT_GT(totalSamples, 0);
    EXPECT_EQ(badSamples, 0);

    DumpManager::Instance().opInfoRecordPath_.clear();
    system("rm -rf ./llt_conc_dump_args");
}

TEST_F(AdumpConcurrencyUtest, Test_AdxDumpProcess_ConcurrentRegisterUnregisterGet)
{
    constexpr int32_t kIters = 2000;
    std::atomic<bool> go{false};
    std::thread regThread([&go]() {
        while (!go.load()) {
            std::this_thread::yield();
        }
        for (int32_t i = 0; i < kIters; ++i) {
            AdxDumpProcess::Instance().MessageCallbackRegister(ConcurrencyMessageCallback);
        }
    });
    std::thread unregThread([&go]() {
        while (!go.load()) {
            std::this_thread::yield();
        }
        for (int32_t i = 0; i < kIters; ++i) {
            AdxDumpProcess::Instance().MessageCallbackUnRegister();
        }
    });
    std::thread readerThread([&go]() {
        while (!go.load()) {
            std::this_thread::yield();
        }
        for (int32_t i = 0; i < kIters; ++i) {
            std::function<int32_t(const DumpChunk*, int32_t)> callback = AdxDumpProcess::Instance().GetCallbackFun();
            if (callback) {
                (void)callback(nullptr, 0);
            }
        }
    });
    go.store(true);
    regThread.join();
    unregThread.join();
    readerThread.join();

    AdxDumpProcess::Instance().MessageCallbackRegister(ConcurrencyMessageCallback);
    EXPECT_TRUE(AdxDumpProcess::Instance().IsRegistered());
    std::function<int32_t(const DumpChunk*, int32_t)> callback = AdxDumpProcess::Instance().GetCallbackFun();
    ASSERT_TRUE(callback);
    EXPECT_EQ(callback(nullptr, 0), 0);
    AdxDumpProcess::Instance().MessageCallbackUnRegister();
    EXPECT_FALSE(AdxDumpProcess::Instance().IsRegistered());
}

TEST_F(AdumpConcurrencyUtest, Test_RegisterCallback_ConcurrentWithStartStopDumpArgs)
{
    MOCKER(&AdxDumpRecord::HasStartedServer).stubs().will(returnValue(true));
    MOCKER(&AdxDumpRecord::CanShutdownServer).stubs().will(returnValue(false));
    DumpManager::Instance().StopDataDumpServer();
    const std::string cfgA = ReadFileToString(JSON_BASE "common/only_path.json");
    ASSERT_FALSE(cfgA.empty());
    ASSERT_EQ(DumpManager::Instance().SetDumpConfig(cfgA.c_str(), cfgA.size()), ADUMP_SUCCESS);

    const std::string dumpPath = "./llt_conc_reg_cb";
    system("rm -rf ./llt_conc_reg_cb");
    {
        const std::lock_guard<std::mutex> lk(g_probeMtx);
        g_probeSamples.clear();
    }

    std::atomic<bool> go{false};
    std::atomic<bool> stop{false};
    std::thread regThread([&]() { RunConcurrentCallbackRegistrar(go, stop); });
    std::thread argsThread([&]() { RunConcurrentArgsCaller(go, stop, dumpPath); });
    go.store(true);
    regThread.join();
    argsThread.join();
    (void)DumpManager::Instance().StopDumpArgs();
    (void)DumpManager::Instance().UnSetDumpConfig();
    DumpManager::Instance().StopDataDumpServer();

    int32_t badSamples = 0;
    {
        const std::lock_guard<std::mutex> lk(g_probeMtx);
        for (const auto& sample : g_probeSamples) {
            if (sample != cfgA) {
                ++badSamples;
            }
        }
        g_probeSamples.clear();
    }
    EXPECT_EQ(badSamples, 0);

    DumpManager::Instance().opInfoRecordPath_.clear();
    system("rm -rf ./llt_conc_reg_cb");
}
