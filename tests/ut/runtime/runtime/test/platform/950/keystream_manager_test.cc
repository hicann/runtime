/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <atomic>
#include <chrono>
#include <cinttypes>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <memory>
#include <mutex>
#include <string>
#include <thread>
#include <vector>

#include "gtest/gtest.h"
#include "securec.h"

#define private public
#define protected public
#include "crypto/cc_crypto.h"
#include "crypto/keystream/keystream_manager.h"
#undef private
#undef protected
#include "crypto/openssl_loader.h"

using namespace cce::runtime;

namespace {

constexpr int KS_TEST_DEV_ID = 0;
constexpr int KS_TEST_SEGMENT_SIZE = 4096;
constexpr int KS_TEST_THRESHOLD = 512;
constexpr int KS_TEST_SEGMENT_NUM = 2;
constexpr uint8_t KS_FAKE_FILL_BASE = 0x5AU;

// 伪造的设备/运行时操作：不依赖真实设备，段缓冲用 malloc 模拟，填充用确定性字节模式。
struct FakeKeystreamOps {
    std::atomic<int> allocCount{0};
    std::atomic<int> freeCount{0};
    std::atomic<int> fillCount{0};
    std::atomic<int> initCount{0};
    std::atomic<int> releaseCount{0};
    std::atomic<bool> fillFail{false};

    std::mutex bufMutex;
    std::vector<std::pair<uint8_t*, uint8_t*>> buffers;

    static FakeKeystreamOps& Get(KeystreamSegment& segment);
};

FakeKeystreamOps* g_fakeOps = nullptr;

FakeKeystreamOps& FakeKeystreamOps::Get(KeystreamSegment& /* segment */) { return *g_fakeOps; }

bool FakeAllocSegment(KeystreamSegment& segment)
{
    FakeKeystreamOps& ops = *g_fakeOps;
    auto* const host = static_cast<uint8_t*>(malloc(static_cast<size_t>(segment.segmentSize)));
    auto* const device = static_cast<uint8_t*>(malloc(static_cast<size_t>(segment.segmentSize)));
    if ((host == nullptr) || (device == nullptr)) {
        free(host);
        free(device);
        return false;
    }
    segment.hostAddr = host;
    segment.deviceAddr = device;
    {
        std::lock_guard<std::mutex> lock(ops.bufMutex);
        ops.buffers.emplace_back(host, device);
    }
    ops.allocCount.fetch_add(1);
    return true;
}

void FakeFreeSegment(KeystreamSegment& segment)
{
    FakeKeystreamOps& ops = *g_fakeOps;
    free(segment.hostAddr);
    free(segment.deviceAddr);
    segment.hostAddr = nullptr;
    segment.deviceAddr = nullptr;
    ops.freeCount.fetch_add(1);
}

bool FakeInitContext(KeystreamContext& context)
{
    FakeKeystreamOps& ops = *g_fakeOps;
    // 填充任务要求 stream 非空；伪造指针，不实际解引用（fill 由 fake 实现接管）
    context.fillStream = reinterpret_cast<Stream*>(static_cast<uintptr_t>(0x1000U));
    ops.initCount.fetch_add(1);
    return true;
}

void FakeReleaseContext(KeystreamContext& /* context */) { g_fakeOps->releaseCount.fetch_add(1); }

rtError_t FakeFillSegment(KeystreamSegment& segment, Stream* /* stream */, const uint8_t* /* iv */, size_t /* ivLen */)
{
    FakeKeystreamOps& ops = *g_fakeOps;
    if (ops.fillFail.load()) {
        return RT_ERROR_CC_CRYPTO_FAILED;
    }
    // 用段 ID 区分不同段的密钥流，便于校验分配/归还对应关系
    const uint8_t pattern = static_cast<uint8_t>(KS_FAKE_FILL_BASE + segment.segmentId);
    if (segment.hostAddr != nullptr) {
        (void)memset_s(
            segment.hostAddr, static_cast<size_t>(segment.segmentSize), pattern,
            static_cast<size_t>(segment.segmentSize));
    }
    if (segment.deviceAddr != nullptr) {
        (void)memset_s(
            segment.deviceAddr, static_cast<size_t>(segment.segmentSize), pattern,
            static_cast<size_t>(segment.segmentSize));
    }
    ops.fillCount.fetch_add(1);
    return RT_ERROR_NONE;
}

class KeystreamManagerTest : public testing::Test {
protected:
    void SetUp() override
    {
        g_fakeOps = &fake_;
        ops_.allocSegment = FakeAllocSegment;
        ops_.freeSegment = FakeFreeSegment;
        ops_.initContext = FakeInitContext;
        ops_.releaseContext = FakeReleaseContext;
        ops_.fillSegment = FakeFillSegment;
    }

    void TearDown() override
    {
        manager_.reset();
        g_fakeOps = nullptr;
    }

    void Start(const std::vector<KeystreamConfig>& configs = DefaultConfigs(), const bool waitFilled = true)
    {
        manager_ = std::make_unique<KeystreamManager>(KS_TEST_DEV_ID, &ops_);
        ASSERT_EQ(manager_->Init(configs, DefaultKey()), RT_ERROR_NONE);
        // 注入实现下 Init 异步填充（生产路径会同步等全部段就绪），UT 需要确定性的数据可用性：
        // 轮询等待后台填充全部完成；fillFail 场景不会就绪，调用方传 waitFilled=false 跳过
        if (waitFilled) {
            int totalSegments = 0;
            for (const auto& cfg : configs) {
                totalSegments += cfg.segmentNum;
            }
            const auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds(5);
            while (fake_.fillCount.load() < totalSegments) {
                ASSERT_LT(std::chrono::steady_clock::now(), deadline) << "background fill not finished";
                std::this_thread::sleep_for(std::chrono::milliseconds(1));
            }
        }
    }

    static KeystreamKey DefaultKey()
    {
        KeystreamKey key{};
        for (uint32_t i = 0U; i < AICC_KEY_SIZE; ++i) {
            key.key[i] = static_cast<uint8_t>(i);
        }
        key.keyAddr = 0x3FF0000ULL;
        key.keyLen = AICC_KEY_SIZE;
        return key;
    }

    static std::vector<KeystreamConfig> DefaultConfigs()
    {
        return {{KS_TEST_THRESHOLD, KS_TEST_SEGMENT_SIZE, KS_TEST_SEGMENT_NUM}};
    }

    FakeKeystreamOps fake_;
    KeystreamOps ops_;
    std::unique_ptr<KeystreamManager> manager_;
};

// 密钥流生成契约：长度正确、跨 8KB 分块终止、非法参数拒绝。
// 注意：runtime UT 链接的是 cc_crypto_stub.cc 的 OpenSSL 桩（EncUpdate 为恒等拷贝），
// 真实 AES-128-CTR 向量需在真实 OpenSSL 环境（真机/发布构建）验证，不在本 UT 覆盖。
TEST(KeystreamGeneratorTest, LengthContractAndChunking)
{
    ASSERT_TRUE(OpenSSLLoader::Instance().Init()); // UT 环境为 OpenSSL 桩实现
    const uint8_t key[16] = {0};
    const uint8_t iv[AICC_CTR_IV_SIZE] = {0};
    uint8_t out[8192 + 1] = {0};
    EXPECT_EQ(GenerateKeystream(key, iv, out, 16), 16);
    EXPECT_EQ(GenerateKeystream(key, iv, out, 8192), 8192);
    EXPECT_EQ(GenerateKeystream(key, iv, out, 8193), 8193); // 跨 8KB 分块

    EXPECT_NE(GenerateKeystream(nullptr, iv, out, 16), 16);
    EXPECT_NE(GenerateKeystream(key, nullptr, out, 16), 16);
    EXPECT_NE(GenerateKeystream(key, iv, nullptr, 16), 16);
    EXPECT_NE(GenerateKeystream(key, iv, out, 0), 16);
}

TEST_F(KeystreamManagerTest, InitCreatesSegmentsAndFillsThem)
{
    Start();
    EXPECT_EQ(fake_.initCount.load(), 1);
    EXPECT_EQ(fake_.allocCount.load(), KS_TEST_SEGMENT_NUM);
    EXPECT_EQ(fake_.fillCount.load(), KS_TEST_SEGMENT_NUM);
}

// 生产路径（未注入 ops）的 Init 等待谓词回归：全部段就绪必须判定为「成功结束」。
// 修复前该谓词恒返回 false，stateCv_.wait_for 白等 30s 后误判超时，CTR 初始化必然失败；
// 注入实现的 UT 会跳过整段等待，因此必须单独对谓词做覆盖。
TEST_F(KeystreamManagerTest, InitFillWaitPredicateCoversSuccessInFlightAndFailure)
{
    std::deque<std::unique_ptr<KeystreamSegment>> segments;
    for (int i = 0; i < 2; ++i) {
        segments.push_back(std::make_unique<KeystreamSegment>(nullptr, KS_TEST_DEV_ID, i, 256, 64));
    }
    std::atomic<int32_t> fillError{0};

    for (auto& segment : segments) {
        segment->ready.store(true, std::memory_order_release);
        segment->fillInFlight.store(false, std::memory_order_release);
    }
    EXPECT_FALSE(KeystreamContext::InitFillFailed(segments, fillError));
    EXPECT_TRUE(KeystreamContext::InitFillDone(segments, fillError));

    // 仍有段在填充：既未成功也未失败，继续等
    segments[1]->ready.store(false, std::memory_order_release);
    segments[1]->fillInFlight.store(true, std::memory_order_release);
    EXPECT_FALSE(KeystreamContext::InitFillFailed(segments, fillError));
    EXPECT_FALSE(KeystreamContext::InitFillDone(segments, fillError));

    // 填充任务结束但段未就绪：判定失败，不空等到超时
    segments[1]->fillInFlight.store(false, std::memory_order_release);
    EXPECT_TRUE(KeystreamContext::InitFillFailed(segments, fillError));
    EXPECT_TRUE(KeystreamContext::InitFillDone(segments, fillError));

    // fillError 单独置位同样判失败
    segments[1]->ready.store(true, std::memory_order_release);
    fillError.store(static_cast<int32_t>(RT_ERROR_CC_CRYPTO_FAILED), std::memory_order_release);
    EXPECT_TRUE(KeystreamContext::InitFillFailed(segments, fillError));
    EXPECT_TRUE(KeystreamContext::InitFillDone(segments, fillError));
}

TEST_F(KeystreamManagerTest, GetBeforeInitRejected)
{
    manager_ = std::make_unique<KeystreamManager>(KS_TEST_DEV_ID);
    KeystreamPair pair{};
    EXPECT_EQ(manager_->GetKeystreamPair(pair, 64, 10), RT_ERROR_INVALID_VALUE);
}

TEST_F(KeystreamManagerTest, GetFreeBasic)
{
    Start();
    KeystreamPair pair{};
    ASSERT_EQ(manager_->GetKeystreamPair(pair, 64, 100), RT_ERROR_NONE);
    EXPECT_EQ(pair.length, 64U);
    ASSERT_NE(pair.keystreamHost, nullptr);
    ASSERT_NE(pair.keystreamDevice, nullptr);
    EXPECT_GE(pair.keystreamId, 0);

    // 取到的是 fake 填充的确定性密钥流
    const uint8_t* const ks = static_cast<const uint8_t*>(pair.keystreamHost);
    for (size_t i = 0U; i < pair.length; ++i) {
        EXPECT_EQ(ks[i], static_cast<uint8_t>(KS_FAKE_FILL_BASE + pair.keystreamId));
    }

    EXPECT_EQ(manager_->FreeKeystreamPair(pair), RT_ERROR_NONE);
    EXPECT_EQ(pair.keystreamId, -1);
    EXPECT_EQ(pair.length, 0U);
    EXPECT_EQ(pair.keystreamHost, nullptr);
    EXPECT_EQ(pair.keystreamDevice, nullptr);
}

TEST_F(KeystreamManagerTest, GetAllocationAlignedToBlockSize)
{
    Start();
    KeystreamPair first{};
    KeystreamPair second{};
    ASSERT_EQ(manager_->GetKeystreamPair(first, 1, 100), RT_ERROR_NONE);
    ASSERT_EQ(manager_->GetKeystreamPair(second, 1, 100), RT_ERROR_NONE);
    // 1 字节请求按 16B 块占用：第二次分配的起始偏移为 16
    EXPECT_EQ(
        static_cast<uint8_t*>(second.keystreamHost) - static_cast<uint8_t*>(first.keystreamHost), AICC_BLOCK_SIZE);
    EXPECT_EQ(
        static_cast<uint8_t*>(second.keystreamDevice) - static_cast<uint8_t*>(first.keystreamDevice), AICC_BLOCK_SIZE);
    EXPECT_EQ(manager_->FreeKeystreamPair(first), RT_ERROR_NONE);
    EXPECT_EQ(manager_->FreeKeystreamPair(second), RT_ERROR_NONE);
}

TEST_F(KeystreamManagerTest, GetTooLargeRejected)
{
    Start();
    KeystreamPair pair{};
    EXPECT_EQ(manager_->GetKeystreamPair(pair, KS_TEST_SEGMENT_SIZE + 1, 10), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(manager_->GetKeystreamPair(pair, 0, 10), RT_ERROR_INVALID_VALUE);
}

TEST_F(KeystreamManagerTest, GetExhaustedTimesOut)
{
    // 单段、大阈值：把整段一次取空后，再取必然超时
    Start({{1024, KS_TEST_SEGMENT_SIZE, 1}});
    KeystreamPair pair{};
    ASSERT_EQ(manager_->GetKeystreamPair(pair, KS_TEST_SEGMENT_SIZE, 100), RT_ERROR_NONE);
    KeystreamPair extra{};
    EXPECT_EQ(manager_->GetKeystreamPair(extra, AICC_BLOCK_SIZE, 20), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(manager_->FreeKeystreamPair(pair), RT_ERROR_NONE);
}

TEST_F(KeystreamManagerTest, FreeRejectsInvalidAndDuplicate)
{
    Start();
    KeystreamPair pair{};
    ASSERT_EQ(manager_->GetKeystreamPair(pair, 32, 100), RT_ERROR_NONE);
    ASSERT_EQ(manager_->FreeKeystreamPair(pair), RT_ERROR_NONE);
    // 已清空：直接拒绝
    EXPECT_EQ(manager_->FreeKeystreamPair(pair), RT_ERROR_INVALID_VALUE);

    KeystreamPair bad{};
    bad.keystreamId = 99;
    EXPECT_EQ(manager_->FreeKeystreamPair(bad), RT_ERROR_INVALID_VALUE);
    bad.keystreamId = -1;
    EXPECT_EQ(manager_->FreeKeystreamPair(bad), RT_ERROR_INVALID_VALUE);
}

TEST_F(KeystreamManagerTest, RefillTriggeredAfterThresholdAndConsumersDrained)
{
    Start({{64, 256, 1}});
    KeystreamPair first{};
    KeystreamPair second{};
    ASSERT_EQ(manager_->GetKeystreamPair(first, 128, 100), RT_ERROR_NONE);
    ASSERT_EQ(manager_->GetKeystreamPair(second, 96, 100), RT_ERROR_NONE); // 224 + 64 > 256，置待填充
    const int fillsBefore = fake_.fillCount.load();
    EXPECT_EQ(manager_->FreeKeystreamPair(first), RT_ERROR_NONE);
    EXPECT_EQ(manager_->FreeKeystreamPair(second), RT_ERROR_NONE); // 消费者归零，触发异步填充

    // 等待异步填充完成：段重新可用（availablePos 归零、needFill 清除）
    const auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds(2);
    bool refilled = false;
    while (std::chrono::steady_clock::now() < deadline) {
        KeystreamPair again{};
        if (manager_->GetKeystreamPair(again, 16, 10) == RT_ERROR_NONE) {
            EXPECT_EQ(manager_->FreeKeystreamPair(again), RT_ERROR_NONE);
            refilled = true;
            break;
        }
        std::this_thread::sleep_for(std::chrono::milliseconds(5));
    }
    EXPECT_TRUE(refilled);
    EXPECT_GT(fake_.fillCount.load(), fillsBefore);
}

TEST_F(KeystreamManagerTest, GetFailsFastWhenFillFails)
{
    fake_.fillFail.store(true);
    Start({{64, 256, 1}}, false);
    KeystreamPair pair{};
    // fail-fast：任一填充任务失败即返回该错误码，不再空等到 timeout（超时为 RT_ERROR_INVALID_VALUE）
    EXPECT_EQ(manager_->GetKeystreamPair(pair, 16, 5000), RT_ERROR_CC_CRYPTO_FAILED);
}

TEST_F(KeystreamManagerTest, ReleaseAndReinit)
{
    Start();
    KeystreamPair pair{};
    ASSERT_EQ(manager_->GetKeystreamPair(pair, 16, 100), RT_ERROR_NONE);
    EXPECT_EQ(manager_->FreeKeystreamPair(pair), RT_ERROR_NONE);

    manager_->Release();
    KeystreamPair afterRelease{};
    EXPECT_EQ(manager_->GetKeystreamPair(afterRelease, 16, 10), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(fake_.releaseCount.load(), 1);
    EXPECT_EQ(fake_.freeCount.load(), KS_TEST_SEGMENT_NUM);

    ASSERT_EQ(manager_->Init(DefaultConfigs(), DefaultKey()), RT_ERROR_NONE);
    KeystreamPair again{};
    ASSERT_EQ(manager_->GetKeystreamPair(again, 16, 100), RT_ERROR_NONE);
    EXPECT_EQ(manager_->FreeKeystreamPair(again), RT_ERROR_NONE);
}

TEST_F(KeystreamManagerTest, ConcurrentGetFreeKeepsAllocationConsistent)
{
    Start({{KS_TEST_THRESHOLD, KS_TEST_SEGMENT_SIZE, KS_TEST_SEGMENT_NUM}});
    constexpr int threadCount = 4;
    constexpr int iterations = 200;
    std::atomic<int> success{0};
    std::atomic<bool> overlap{false};
    std::mutex rangeMutex;
    std::vector<std::pair<const uint8_t*, const uint8_t*>> inUse;

    auto worker = [&]() {
        for (int i = 0; i < iterations; ++i) {
            KeystreamPair pair{};
            if (manager_->GetKeystreamPair(pair, 64, 50) != RT_ERROR_NONE) {
                continue;
            }
            const uint8_t* const begin = static_cast<const uint8_t*>(pair.keystreamHost);
            const uint8_t* const end = begin + pair.length;
            {
                std::lock_guard<std::mutex> lock(rangeMutex);
                for (const auto& used : inUse) {
                    if ((begin < used.second) && (used.first < end)) {
                        overlap.store(true);
                    }
                }
                inUse.emplace_back(begin, end);
            }
            (void)memset_s(const_cast<uint8_t*>(begin), pair.length, static_cast<int>(i), pair.length);
            {
                std::lock_guard<std::mutex> lock(rangeMutex);
                for (auto iter = inUse.begin(); iter != inUse.end(); ++iter) {
                    if (iter->first == begin) {
                        inUse.erase(iter);
                        break;
                    }
                }
            }
            if (manager_->FreeKeystreamPair(pair) == RT_ERROR_NONE) {
                success.fetch_add(1);
            }
        }
    };

    std::vector<std::thread> threads;
    for (int i = 0; i < threadCount; ++i) {
        threads.emplace_back(worker);
    }
    for (auto& t : threads) {
        t.join();
    }
    EXPECT_FALSE(overlap.load());
    EXPECT_GT(success.load(), 0);
}

TEST(KeystreamFillTaskTest, AddIvCounterBigEndianCarry)
{
    uint8_t iv[AICC_CTR_IV_SIZE] = {0};
    iv[15] = 0xFFU;
    iv[14] = 0xFFU;
    AddIvCounter(iv, 1U);
    EXPECT_EQ(iv[15], 0x00U);
    EXPECT_EQ(iv[14], 0x00U);
    EXPECT_EQ(iv[13], 0x01U);
    EXPECT_EQ(iv[0], 0x00U);

    uint8_t iv2[16] = {0};
    AddIvCounter(iv2, 0x0102U);
    EXPECT_EQ(iv2[14], 0x01U);
    EXPECT_EQ(iv2[15], 0x02U);
}

TEST(KeystreamFillTaskTest, BuildPagesAndCounters)
{
    constexpr uint32_t segmentSize = (2U * KS_FILL_PAGE_SIZE) + 128U; // 2 整页 + 128B，16B 对齐
    uint8_t baseIv[AICC_CTR_IV_SIZE] = {0};
    std::vector<AiccKeystreamFillTask> tasks;
    const uint32_t taskLen = BuildKsFillTasks(0x1000U, segmentSize, baseIv, AICC_CTR_IV_SIZE, tasks);
    ASSERT_EQ(taskLen, 3U);
    ASSERT_EQ(tasks.size(), 3U);

    EXPECT_EQ(tasks[0].keystreamAddr, 0x1000U);
    EXPECT_EQ(tasks[0].keystreamLen, KS_FILL_PAGE_SIZE);
    EXPECT_EQ(tasks[1].keystreamAddr, 0x1000U + KS_FILL_PAGE_SIZE);
    EXPECT_EQ(tasks[2].keystreamAddr, 0x1000U + (2U * KS_FILL_PAGE_SIZE));
    EXPECT_EQ(tasks[2].keystreamLen, 128U);

    // 第 i 页 counter = 基块 + i * 页块数（每块 16B，128 位大端）
    const uint32_t pageBlocks = KS_FILL_PAGE_SIZE / AICC_BLOCK_SIZE;
    for (uint32_t page = 0U; page < taskLen; ++page) {
        uint8_t expected[16] = {0};
        AddIvCounter(expected, static_cast<uint64_t>(page) * pageBlocks);
        EXPECT_EQ(memcmp(tasks[page].iv, expected, sizeof(expected)), 0);
    }
}

TEST(KeystreamFillTaskTest, BuildRejectsUnalignedSegment)
{
    uint8_t baseIv[AICC_CTR_IV_SIZE] = {0};
    std::vector<AiccKeystreamFillTask> tasks;
    EXPECT_EQ(BuildKsFillTasks(0x1000U, 100U, baseIv, AICC_CTR_IV_SIZE, tasks), 0U); // 非 16B 对齐
    EXPECT_EQ(BuildKsFillTasks(0x1000U, 0U, baseIv, AICC_CTR_IV_SIZE, tasks), 0U);
    EXPECT_EQ(BuildKsFillTasks(0x1000U, AICC_BLOCK_SIZE, nullptr, AICC_CTR_IV_SIZE, tasks), 0U);
    EXPECT_EQ(BuildKsFillTasks(0x1000U, AICC_BLOCK_SIZE, baseIv, AICC_CTR_IV_SIZE - 1U, tasks), 0U); // IV 长度不足
}

TEST_F(KeystreamManagerTest, ReleasedPairIsIdempotentAtCcryptoLayer)
{
    CCrypto crypto(CC_CRYPTO_ALG_TYPE::CTR);
    // 注入小配置的池，避免默认配置（每设备 64MB）在 UT 中分配过大
    crypto.keystreamPool_ = std::make_shared<KeystreamManager>(KS_TEST_DEV_ID, &ops_);
    ASSERT_EQ(crypto.keystreamPool_->Init(DefaultConfigs(), DefaultKey()), RT_ERROR_NONE);
    crypto.deviceId_ = KS_TEST_DEV_ID;
    // Init 异步填充，等待全部段就绪后再取段
    const auto fillDeadline = std::chrono::steady_clock::now() + std::chrono::seconds(5);
    while (fake_.fillCount.load() < KS_TEST_SEGMENT_NUM) {
        ASSERT_LT(std::chrono::steady_clock::now(), fillDeadline) << "background fill not finished";
        std::this_thread::sleep_for(std::chrono::milliseconds(1));
    }

    KeystreamPair pair{};
    ASSERT_EQ(crypto.GetKeyStreamPair(KS_TEST_DEV_ID, 64, 100, pair), RT_ERROR_NONE);
    EXPECT_EQ(pair.length, 64U);

    // 跨设备请求被拒绝（池按设备绑定）
    KeystreamPair other{};
    EXPECT_EQ(crypto.GetKeyStreamPair(KS_TEST_DEV_ID + 1, 64, 10, other), RT_ERROR_INVALID_VALUE);

    // 归还幂等：第二次归还直接成功
    EXPECT_EQ(crypto.FreeKeyStream(KS_TEST_DEV_ID, pair), RT_ERROR_NONE);
    EXPECT_EQ(crypto.FreeKeyStream(KS_TEST_DEV_ID, pair), RT_ERROR_NONE);

    // 非 CTR 模式不启用密钥流池
    CCrypto gcmCrypto(CC_CRYPTO_ALG_TYPE::GCM);
    KeystreamPair noPool{};
    EXPECT_EQ(gcmCrypto.GetKeyStreamPair(KS_TEST_DEV_ID, 64, 10, noPool), RT_ERROR_CC_INIT_FAILED);
}

TEST_F(KeystreamManagerTest, CcryptoKeystreamRoundTrip)
{
    CCrypto crypto(CC_CRYPTO_ALG_TYPE::CTR);
    crypto.keystreamPool_ = std::make_shared<KeystreamManager>(KS_TEST_DEV_ID, &ops_);
    ASSERT_EQ(crypto.keystreamPool_->Init(DefaultConfigs(), DefaultKey()), RT_ERROR_NONE);
    crypto.deviceId_ = KS_TEST_DEV_ID;
    // Init 异步填充，等待全部段就绪后再取段
    const auto fillDeadline = std::chrono::steady_clock::now() + std::chrono::seconds(5);
    while (fake_.fillCount.load() < KS_TEST_SEGMENT_NUM) {
        ASSERT_LT(std::chrono::steady_clock::now(), fillDeadline) << "background fill not finished";
        std::this_thread::sleep_for(std::chrono::milliseconds(1));
    }

    KeystreamPair pair{};
    ASSERT_EQ(crypto.GetKeyStreamPair(KS_TEST_DEV_ID, 128, 100, pair), RT_ERROR_NONE);

    uint8_t plain[128];
    uint8_t cipher[128];
    uint8_t back[128];
    for (size_t i = 0U; i < sizeof(plain); ++i) {
        plain[i] = static_cast<uint8_t>(i * 7U);
    }
    ASSERT_EQ(crypto.KeystreamEncrypt(pair, plain, sizeof(plain), cipher, sizeof(cipher)), RT_ERROR_NONE);
    ASSERT_EQ(crypto.KeystreamDecrypt(pair, cipher, sizeof(cipher), back, sizeof(back)), RT_ERROR_NONE);
    EXPECT_EQ(memcmp(plain, back, sizeof(plain)), 0);
    // 与密钥流做了异或（明文非全零，密文应不同于明文）
    EXPECT_NE(memcmp(plain, cipher, sizeof(plain)), 0);
    EXPECT_EQ(crypto.FreeKeyStream(KS_TEST_DEV_ID, pair), RT_ERROR_NONE);
}

} // namespace
