/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "keystream_manager.h"

#include "common/cc_defs.h"

#include <algorithm>
#include <chrono>
#include <climits>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <functional>
#include <new>
#include <string>
#include <vector>

#include "aicpu_c.hpp"
#include "base.hpp"
#include "context.hpp"
#include "device.hpp"
#include "driver.hpp"
#include "securec.h"
#include "../cc_crypto_plugin.h"
#include "../openssl_loader.h"

namespace cce {
namespace runtime {
namespace {

void PublishFillError(KeystreamContext& context, rtError_t result)
{
    if (result == RT_ERROR_NONE) {
        return;
    }
    int32_t expected = 0;
    (void)context.fillError.compare_exchange_strong(
        expected, static_cast<int32_t>(result), std::memory_order_release, std::memory_order_relaxed);
}

// 发布结果与等待谓词共用 stateMutex_，最后清除 inFlight 并唤醒等待者。
struct FillTaskCleanup {
    KeystreamContext* context;
    std::atomic<int>& streamRef;
    std::atomic<bool>& inFlight;
    std::atomic<int32_t>& fillResult;
    rtError_t result = RT_ERROR_NONE;

    ~FillTaskCleanup()
    {
        streamRef.fetch_sub(1, std::memory_order_relaxed);
        if (context == nullptr) {
            inFlight.store(false, std::memory_order_release);
            return;
        }
        {
            std::lock_guard<std::mutex> lock(context->stateMutex_);
            fillResult.store(static_cast<int32_t>(result), std::memory_order_relaxed);
            PublishFillError(*context, result);
            inFlight.store(false, std::memory_order_release);
        }
        context->stateCv_.notify_all();
    }
};

Api* GetApiInstance()
{
    Runtime* const runtime = Runtime::Instance();
    return (runtime == nullptr) ? nullptr : runtime->Api_();
}

rtError_t SetDeviceByLogicDevId(int devId)
{
    if (devId < 0) {
        return RT_ERROR_INVALID_VALUE;
    }
    uint32_t userDevId = 0U;
    const rtError_t error = Runtime::Instance()->GetUserDevIdByDeviceId(static_cast<uint32_t>(devId), &userDevId);
    if (error != RT_ERROR_NONE) {
        return error;
    }
    Api* const api = GetApiInstance();
    if (api == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    return api->SetDevice(static_cast<int32_t>(userDevId));
}

const KeystreamOps* GetOps(const KeystreamContext* context)
{
    return ((context == nullptr) || (context->manager == nullptr)) ? nullptr : context->manager->Ops();
}

rtError_t CheckFillFailed(const KeystreamContext& context, int length)
{
    const int32_t fillErr = context.fillError.load(std::memory_order_acquire);
    if (fillErr == 0) {
        return RT_ERROR_NONE;
    }
    RT_LOG(RT_LOG_ERROR, "Keystream fill failed, fail-fast, length=%d ret=%#x", length, static_cast<uint32_t>(fillErr));
    return static_cast<rtError_t>(fillErr);
}

void RetrySegmentFill(KeystreamSegment& segment)
{
    if (segment.fillInFlight.load(std::memory_order_acquire) == true) {
        return;
    }
    constexpr int64_t retryIntervalMs = 100; // 限频补填，避免瞬态失败后永久不可用。
    const int64_t nowMs =
        std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now().time_since_epoch())
            .count();
    int64_t nextMs = segment.nextFillTimeMs.load(std::memory_order_relaxed);
    if ((nowMs < nextMs) ||
        (!segment.nextFillTimeMs.compare_exchange_strong(
            nextMs, nowMs + retryIntervalMs, std::memory_order_acq_rel, std::memory_order_relaxed))) {
        return;
    }
    if (segment.ksContext == nullptr) {
        return;
    }
    (void)segment.ksContext->FillKeystreamAsync(&segment);
}

void RetryNeedFillSegments(std::deque<std::unique_ptr<KeystreamSegment>>& segments)
{
    for (auto& segmentPtr : segments) {
        if ((segmentPtr != nullptr) && (segmentPtr->needFill.load(std::memory_order_acquire) == true)) {
            RetrySegmentFill(*segmentPtr);
        }
    }
}

rtError_t TryPickSegment(std::deque<std::unique_ptr<KeystreamSegment>>& segments, KeystreamPair& pair, int length)
{
    for (auto& segmentPtr : segments) {
        KeystreamSegment* segment = segmentPtr.get();
        if ((segment == nullptr) || segment->needFill.load(std::memory_order_acquire) ||
            !segment->ready.load(std::memory_order_acquire) || (length > segment->segmentSize) ||
            (segment->availablePos.load(std::memory_order_acquire) > (segment->segmentSize - length))) {
            continue;
        }
        if (segment->GetKeystreamPair(pair, length) == RT_ERROR_NONE) {
            return RT_ERROR_NONE;
        }
    }
    return RT_ERROR_INVALID_VALUE;
}

bool AllocSegment(KeystreamSegment& segment)
{
    const KeystreamOps* const ops = GetOps(segment.ksContext);
    if ((ops != nullptr) && (ops->allocSegment)) {
        return ops->allocSegment(segment);
    }

    segment.hostAddr = static_cast<uint8_t*>(malloc(static_cast<size_t>(segment.segmentSize)));
    if ((segment.hostAddr == nullptr) || (segment.ksContext == nullptr) || (segment.ksContext->rtContext == nullptr)) {
        return false;
    }

    // 只要求 VA 连续
    const rtError_t error = segment.ksContext->rtContext->Device_()->Driver_()->DevMemAllocWithBackupFlag(
        reinterpret_cast<void**>(&segment.deviceAddr), segment.segmentSize, RT_MEMORY_HBM, segment.devId,
        DevMemBackupType::SNAPSHOT_NO_BACKUP);
    return error == RT_ERROR_NONE;
}

void FreeSegment(KeystreamSegment& segment)
{
    const KeystreamOps* const ops = GetOps(segment.ksContext);
    if ((ops != nullptr) && (ops->freeSegment)) {
        ops->freeSegment(segment);
        return;
    }
    free(segment.hostAddr);
    segment.hostAddr = nullptr;
    if ((segment.deviceAddr != nullptr) && (segment.ksContext != nullptr) &&
        (segment.ksContext->rtContext != nullptr)) {
        (void)segment.ksContext->rtContext->Device_()->Driver_()->DevMemFree(segment.deviceAddr, segment.devId);
        segment.deviceAddr = nullptr;
    }
}

uint32_t QueryAicpuCoreNum()
{
    const Runtime* const runtime = Runtime::Instance();
    if (runtime == nullptr) {
        return KS_FILL_BLOCK_DIM_DEFAULT;
    }
    const int64_t coreNum = runtime->GetAicpuCnt();
    return (coreNum > 0) ? static_cast<uint32_t>(coreNum) : KS_FILL_BLOCK_DIM_DEFAULT;
}

bool InitContext(KeystreamContext& context)
{
    const KeystreamOps* const ops = GetOps(&context);
    if ((ops != nullptr) && (ops->initContext)) {
        return ops->initContext(context);
    }

    const rtError_t error = SetDeviceByLogicDevId(context.devId);
    if (error != RT_ERROR_NONE) {
        return false;
    }
    Runtime* const runtime = Runtime::Instance();
    context.rtContext = (runtime == nullptr) ? nullptr : runtime->CurrentContext(true, DEFAULT_DEVICE_ID);
    if (context.rtContext == nullptr) {
        return false;
    }

    context.fillBlockDim = std::min(KS_FILL_BLOCK_DIM_MAX, std::max(1U, QueryAicpuCoreNum()));
    RT_LOG(RT_LOG_INFO, "CC keystream fill blockDim=%u (AICPU cores), devId=%d", context.fillBlockDim, context.devId);

    if (context.key.keyAddr == 0U) {
        return false;
    }

    for (size_t i = 0U; i < context.fillStreams.size(); ++i) {
        const rtError_t streamError =
            context.rtContext->StreamCreate(RT_STREAM_PRIORITY_DEFAULT, 0U, &context.fillStreams[i]);
        if (streamError != RT_ERROR_NONE) {
            return false;
        }
        context.fillStreamRefs[i] = 0;
    }
    return true;
}

void ReleaseContext(KeystreamContext& context)
{
    const KeystreamOps* const ops = GetOps(&context);
    if ((ops != nullptr) && (ops->releaseContext)) {
        ops->releaseContext(context);
        return;
    }
    for (auto& stream : context.fillStreams) {
        if ((stream != nullptr) && (context.rtContext != nullptr)) {
            // 必须先同步，才能销毁设备侧仍可能使用的 stream。
            (void)SetDeviceByLogicDevId(context.devId);
            Api* const api = GetApiInstance();
            if (api != nullptr) {
                (void)api->StreamSynchronize(stream, -1);
            }
            (void)context.rtContext->StreamDestroy(stream, false);
            stream = nullptr;
        }
    }
}

rtError_t FillSegment(KeystreamSegment& segment, Stream* stream, const uint8_t* iv)
{
    const KeystreamOps* const ops = GetOps(segment.ksContext);
    if ((ops != nullptr) && (ops->fillSegment)) {
        return ops->fillSegment(segment, stream, iv);
    }

    const rtError_t error = SetDeviceByLogicDevId(segment.devId);
    if (error != RT_ERROR_NONE) {
        return error;
    }
    if ((segment.ksContext == nullptr) || (segment.ksContext->key.keyAddr == 0U)) {
        return RT_ERROR_CC_CRYPTO_FAILED;
    }
    const KeystreamKey& key = segment.ksContext->key;

    std::vector<AiccKeystreamFillTask> tasks;
    const uint32_t taskLen =
        BuildKsFillTasks(PtrToValue(segment.deviceAddr), static_cast<uint32_t>(segment.segmentSize), iv, tasks);
    if (taskLen == 0U) {
        return RT_ERROR_CC_CRYPTO_FAILED;
    }

    // Host 与 Device 并行填充；返回前须等待 Host 任务结束，才能复用段缓冲。
    const uint32_t pagesPerHostTask = std::min(taskLen, KS_HOST_GEN_PAGES_PER_TASK);
    const uint32_t hostTaskCount = (taskLen + pagesPerHostTask - 1U) / pagesPerHostTask;
    auto hostTasks = std::make_shared<const std::vector<AiccKeystreamFillTask>>(tasks);
    auto hostFailed = std::make_shared<std::atomic<bool>>(false);
    ThreadPool* const genPool = KeystreamManager::SharedHostGenPool();
    uint8_t* const hostBase = segment.hostAddr;
    std::vector<std::future<void>> hostFutures;
    hostFutures.reserve(hostTaskCount);
    for (uint32_t start = 0U; start < taskLen; start += pagesPerHostTask) {
        const uint32_t count = std::min(taskLen - start, pagesPerHostTask);
        std::function<void()> genFn = [hostTasks, hostFailed, key, hostBase, start, count]() {
            for (uint32_t p = 0U; p < count; ++p) {
                const AiccKeystreamFillTask& pageTask = (*hostTasks)[start + p];
                const uint32_t offset = (start + p) * KS_FILL_PAGE_SIZE;
                const int32_t pageLen = static_cast<int32_t>(pageTask.keystreamLen);
                if (GenerateKeystream(key.key, pageTask.iv, hostBase + offset, pageLen) < 0) {
                    hostFailed->store(true, std::memory_order_release);
                    return;
                }
            }
        };
        if (genPool != nullptr) {
            std::function<void()> submitted = genFn;
            std::future<void> future = genPool->Submit(std::move(submitted));
            if (future.valid()) {
                hostFutures.push_back(std::move(future));
                continue;
            }
        }
        genFn();
    }

    const uint32_t pagesPerLaunch = std::min(taskLen, KS_FILL_PAGES_PER_LAUNCH_MAX);
    const uint32_t blockDim = segment.ksContext->fillBlockDim;
    const size_t headerSize = offsetof(AiccKeystreamFillParam, tasks);
    const auto fillStart = std::chrono::steady_clock::now();
    for (uint32_t launched = 0U; launched < taskLen;) {
        const uint32_t batch = std::min(taskLen - launched, pagesPerLaunch);
        const size_t tasksBytes = static_cast<size_t>(batch) * sizeof(AiccKeystreamFillTask);
        std::vector<uint8_t> argsBlob(headerSize + tasksBytes, 0U);
        auto* const param = reinterpret_cast<AiccKeystreamFillParam*>(argsBlob.data());
        param->keyAddr = key.keyAddr;
        param->keyLen = key.keyLen;
        param->algType = static_cast<uint32_t>(AICC_ALG_AES128_KEYSTREAM);
        param->taskNum = batch;
        param->reserved = 0U;
        (void)memcpy_s(param->tasks, tasksBytes, tasks.data() + launched, tasksBytes);

        RT_LOG(
            RT_LOG_DEBUG,
            "KeystreamFillParallel submit, seg=%d stream=%p size=%d taskLen=%u batch=%u blockDim=%u blob=%zu",
            segment.segmentId, static_cast<void*>(stream), segment.segmentSize, taskLen, batch, blockDim,
            argsBlob.size());
        const rtError_t launchRet = CCCryptoPlugin::LaunchDeviceKernel(
            stream, CC_KERNEL_KEYSTREAM_FILL, argsBlob.data(), static_cast<uint32_t>(argsBlob.size()));
        if (launchRet != RT_ERROR_NONE) {
            RT_LOG(
                RT_LOG_ERROR,
                "KeystreamFillParallel launch failed, seg=%d taskLen=%u batch=%u blockDim=%u blob=%zu ret=%#x",
                segment.segmentId, taskLen, batch, blockDim, argsBlob.size(), static_cast<uint32_t>(launchRet));
            return launchRet;
        }
        launched += batch;
    }

    const auto waitHostGen = [&hostFutures]() {
        for (auto& hostFuture : hostFutures) {
            hostFuture.get();
        }
    };
    Api* const api = GetApiInstance();
    if (api == nullptr) {
        waitHostGen();
        return RT_ERROR_INVALID_VALUE;
    }
    const rtError_t syncRet = api->StreamSynchronize(stream, -1);
    if (syncRet != RT_ERROR_NONE) {
        waitHostGen();
        RT_LOG(
            RT_LOG_ERROR, "KeystreamFillParallel stream sync failed, seg=%d ret=%#x", segment.segmentId,
            static_cast<uint32_t>(syncRet));
        return syncRet;
    }
    waitHostGen();
    if (hostFailed->load(std::memory_order_acquire)) {
        RT_LOG(RT_LOG_ERROR, "Host keystream generate failed, seg=%d size=%d", segment.segmentId, segment.segmentSize);
        return RT_ERROR_CC_CRYPTO_FAILED;
    }
    const auto elapsedUs =
        std::chrono::duration_cast<std::chrono::microseconds>(std::chrono::steady_clock::now() - fillStart);
    RT_LOG(
        RT_LOG_DEBUG, "KsFill done, seg=%d elapsedUs=%lld taskLen=%u batches=%u", segment.segmentId,
        static_cast<long long>(elapsedUs.count()), taskLen, (taskLen + pagesPerLaunch - 1U) / pagesPerLaunch);
    return RT_ERROR_NONE;
}

} // namespace

int32_t GenerateKeystream(const uint8_t* key, const uint8_t* iv, uint8_t* keystream, int32_t length)
{
    if ((key == nullptr) || (iv == nullptr) || (keystream == nullptr) || (length <= 0)) {
        return RT_ERROR_INVALID_VALUE;
    }

    static constexpr int32_t maxBlockSize = 8192; // 8KB
    uint8_t zeroBlock[maxBlockSize] = {0};

    if (!OpenSSLLoader::Instance().Ready()) {
        return -1;
    }
    OpenSSLApi& ossl = OpenSSLLoader::Instance().Api;
    EVP_CIPHER_CTX* ctx = ossl.CipherCtxNew();
    if (ctx == nullptr) {
        return -1;
    }
    if (ossl.EncInit(ctx, ossl.Aes128Ctr(), nullptr, key, iv) != 1) {
        ossl.CipherCtxFree(ctx);
        return -1;
    }

    int32_t totalBytes = 0;
    while (totalBytes < length) {
        const int32_t remaining = length - totalBytes;
        const int32_t toGenerate = std::min(remaining, maxBlockSize);
        int bytesGenerated = 0;
        if ((ossl.EncUpdate(ctx, keystream + totalBytes, &bytesGenerated, zeroBlock, toGenerate) != 1) ||
            (bytesGenerated <= 0)) {
            ossl.CipherCtxFree(ctx);
            return -1;
        }
        totalBytes += static_cast<int32_t>(bytesGenerated);
    }

    ossl.CipherCtxFree(ctx);
    return totalBytes;
}

void AddIvCounter(uint8_t iv[AICC_CTR_IV_SIZE], uint64_t blocks)
{
    uint64_t carry = blocks;
    for (int32_t i = 15; (i >= 0) && (carry != 0U); --i) {
        const uint64_t sum = static_cast<uint64_t>(iv[i]) + (carry & 0xFFU);
        iv[i] = static_cast<uint8_t>(sum & 0xFFU);
        carry = (carry >> 8U) + (sum >> 8U);
    }
}

uint32_t BuildKsFillTasks(
    uint64_t keystreamAddr, uint32_t segmentSize, const uint8_t baseIv[AICC_CTR_IV_SIZE],
    std::vector<AiccKeystreamFillTask>& tasks)
{
    tasks.clear();
    if ((segmentSize == 0U) || ((segmentSize % AICC_BLOCK_SIZE) != 0U) || (baseIv == nullptr)) {
        return 0U;
    }

    uint32_t offset = 0U;
    while (offset < segmentSize) {
        const uint32_t remaining = segmentSize - offset;
        const uint32_t pageLen = std::min(remaining, KS_FILL_PAGE_SIZE);
        AiccKeystreamFillTask task{};
        task.keystreamAddr = keystreamAddr + offset;
        task.keystreamLen = pageLen;
        (void)memcpy_s(task.iv, sizeof(task.iv), baseIv, sizeof(task.iv));
        AddIvCounter(task.iv, static_cast<uint64_t>(offset) / static_cast<uint64_t>(AICC_BLOCK_SIZE));
        tasks.push_back(task);
        offset += pageLen;
    }
    return static_cast<uint32_t>(tasks.size());
}

static rtError_t FillKeystreamTask(KeystreamSegment* segment, Stream* stream, std::atomic<int>& fillStreamRef)
{
    fillStreamRef.fetch_add(1, std::memory_order_relaxed);
    if ((segment == nullptr) || (stream == nullptr)) {
        fillStreamRef.fetch_sub(1, std::memory_order_relaxed);
        return RT_ERROR_INVALID_VALUE;
    }

    FillTaskCleanup cleanup{segment->ksContext, fillStreamRef, segment->fillInFlight, segment->fillResult};

    static thread_local std::random_device rd;
    std::uniform_int_distribution<uint32_t> distU32(0, UINT32_MAX);
    std::uniform_int_distribution<uint64_t> distU64(0, UINT64_MAX);

    uint8_t iv[AICC_CTR_IV_SIZE];
    *reinterpret_cast<uint64_t*>(iv) = distU64(rd);
    *reinterpret_cast<uint32_t*>(iv + 8) = distU32(rd);
    *reinterpret_cast<uint32_t*>(iv + 12) = 0;

    const rtError_t error = FillSegment(*segment, stream, iv);
    cleanup.result = error;
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "Keystream fill task failed, seg=%d size=%d ret=%#x", segment->segmentId,
            segment->segmentSize, static_cast<uint32_t>(error));
        RT_LOG(
            RT_LOG_DEBUG, "fill failed snapshot, seg=%d ret=%#x needFill=%d ready=%d avail=%d", segment->segmentId,
            static_cast<uint32_t>(error), static_cast<int>(segment->needFill.load(std::memory_order_relaxed)),
            static_cast<int>(segment->ready.load(std::memory_order_relaxed)),
            segment->availablePos.load(std::memory_order_relaxed));
        return error;
    }

    // 先重置水位，再发布可用状态；成功填充允许后续请求恢复。
    segment->availablePos.store(0, std::memory_order_release);
    segment->currentConsumers.store(0, std::memory_order_release);
    segment->needFill.store(false, std::memory_order_release);
    segment->ready.store(true, std::memory_order_release);

    if (segment->ksContext != nullptr) {
        segment->ksContext->fillError.store(0, std::memory_order_release);
    }
    return RT_ERROR_NONE;
}

const std::vector<KeystreamConfig>& GetDefaultKeystreamConfigs()
{
    // 末档必须保留 4 MiB 段，以容纳最大加解密分片。
    static std::vector<KeystreamConfig> configs = {{32768, 4194304, 2},  {65536, 4194304, 2},  {131072, 4194304, 2},
                                                   {262144, 4194304, 2}, {524288, 4194304, 2}, {1048576, 4194304, 2},
                                                   {2097152, 4194304, 4}};
    return configs;
}

KeystreamSegment::KeystreamSegment(KeystreamContext* context, int devId, int segmentId, int segmentSize, int threshold)
    : devId(devId), segmentId(segmentId), segmentSize(segmentSize), threshold(threshold), ksContext(context)
{
    if (!AllocSegment(*this)) {
        this->Release();
    }
}

void KeystreamSegment::Release()
{
    FreeSegment(*this);

    this->devId = -1;
    this->segmentId = -1;
    this->segmentSize = 0;
    this->threshold = 0;
}

rtError_t KeystreamSegment::GetKeystreamPair(KeystreamPair& ksPair, int length)
{
    if ((length <= 0) || (length > this->segmentSize) || !this->ready.load(std::memory_order_acquire)) {
        return RT_ERROR_INVALID_VALUE;
    }

    // 先登记消费者，再检查填充状态和推进水位，防止使用期间段被重填。
    this->currentConsumers.fetch_add(1, std::memory_order_acq_rel);

    if (this->fillInFlight.load(std::memory_order_acquire) == true) {
        this->currentConsumers.fetch_sub(1, std::memory_order_acq_rel);
        return RT_ERROR_INVALID_VALUE;
    }

    int curPos = 0;
    int newPos = 0;
    int cnt = (length + AICC_BLOCK_SIZE - 1) / AICC_BLOCK_SIZE; // 按 AICC_BLOCK_SIZE 对齐的块数
    do {
        curPos = this->availablePos.load(std::memory_order_acquire);
        newPos = curPos + cnt * AICC_BLOCK_SIZE;
        if (newPos > this->segmentSize) {
            this->currentConsumers.fetch_sub(1, std::memory_order_acq_rel);
            return RT_ERROR_INVALID_VALUE;
        }
    } while (!this->availablePos.compare_exchange_weak(
        curPos, newPos, std::memory_order_release, std::memory_order_relaxed));

    if (this->needFill == false && newPos + this->threshold > this->segmentSize) {
        this->needFill = true;
    }

    ksPair.keystreamId = this->segmentId;
    ksPair.length = static_cast<size_t>(length);
    ksPair.keystreamHost = this->hostAddr + curPos;
    ksPair.keystreamDevice = this->deviceAddr + curPos;
    return RT_ERROR_NONE;
}

rtError_t KeystreamSegment::FreeKeystreamPair(KeystreamPair& ksPair)
{
    if (ksPair.keystreamId != this->segmentId) {
        return RT_ERROR_INVALID_VALUE;
    }

    const int prevConsumers = this->currentConsumers.fetch_sub(1, std::memory_order_acq_rel);
    if (prevConsumers <= 0) {
        this->currentConsumers.fetch_add(1, std::memory_order_relaxed);
        return RT_ERROR_INVALID_VALUE;
    }

    ksPair = {-1, 0U, nullptr, nullptr};

    if ((this->needFill.load(std::memory_order_acquire) == true) &&
        (this->currentConsumers.load(std::memory_order_acquire) == 0)) {
        (void)this->ksContext->FillKeystreamAsync(this);
    }
    return RT_ERROR_NONE;
}

bool KeystreamContext::InitFillFailed(
    const std::deque<std::unique_ptr<KeystreamSegment>>& segments, const std::atomic<int32_t>& fillError)
{
    if (fillError.load(std::memory_order_acquire) != 0) {
        return true;
    }
    return std::any_of(segments.begin(), segments.end(), [](const auto& segment) {
        if (segment == nullptr) {
            return false;
        }
        const bool notReady = !segment->ready.load(std::memory_order_acquire);
        const bool notInFlight = !segment->fillInFlight.load(std::memory_order_acquire);
        return notReady && notInFlight;
    });
}

bool KeystreamContext::InitFillDone(
    const std::deque<std::unique_ptr<KeystreamSegment>>& segments, const std::atomic<int32_t>& fillError)
{
    if (InitFillFailed(segments, fillError)) {
        return true;
    }
    return std::all_of(segments.begin(), segments.end(), [](const auto& segment) {
        return (segment == nullptr) || segment->ready.load(std::memory_order_acquire);
    });
}

KeystreamContext::KeystreamContext(
    KeystreamManager* manager, int devId, const std::vector<KeystreamConfig>& config, const KeystreamKey& key)
    : manager(manager),
      devId(devId),
      key(key),
      fillStreams(static_cast<size_t>(KS_FILL_THREAD_POOL_SIZE)),
      fillStreamRefs(static_cast<size_t>(KS_FILL_THREAD_POOL_SIZE))
{
    // 失败时由 Manager 先 Shutdown 填充任务，再释放 stream 和段缓冲。
    if (!InitContext(*this)) {
        return;
    }

    int segId = 0;
    for (auto& cfg : config) {
        for (int i = 0; i < cfg.segmentNum; i++) {
            this->segments.push_back(
                std::make_unique<KeystreamSegment>(this, devId, segId, cfg.segmentSize, cfg.threshold));
            KeystreamSegment* segment = this->segments.back().get();
            if ((segment->hostAddr == nullptr) || (segment->deviceAddr == nullptr) || (segment->segmentSize == 0) ||
                !this->FillKeystreamAsync(segment)) {
                return;
            }
            segId++;
        }
    }

    // 生产路径等待全部段预热完成；注入实现由调用方控制填充节奏。
    if (GetOps(this) == nullptr) {
        std::unique_lock<std::mutex> lock(this->stateMutex_);
        auto initFillDone = [this]() { return KeystreamContext::InitFillDone(this->segments, this->fillError); };
        const bool done = this->stateCv_.wait_for(lock, std::chrono::seconds(KS_INIT_FILL_TIMEOUT_SEC), initFillDone);
        const bool failed = KeystreamContext::InitFillFailed(this->segments, this->fillError);
        lock.unlock();
        if ((done == false) || failed) {
            RT_LOG(
                RT_LOG_ERROR, "CC keystream pool init fill %s, devId=%d", (done == false) ? "timeout" : "failed",
                this->devId);
            return;
        }
    }
    this->isInit = true;
}

void KeystreamContext::Release()
{
    ReleaseContext(*this);

    this->segments.clear();

    this->isInit = false;
}

bool KeystreamContext::FillKeystreamAsync(KeystreamSegment* segment)
{
    if ((segment == nullptr) || (this->manager == nullptr)) {
        return false;
    }
    if (segment->fillInFlight.exchange(true, std::memory_order_acq_rel)) {
        return false;
    }
    // CAS 去重后仍需检查消费者，避免覆盖已分配的密钥流。
    if ((segment->currentConsumers.load(std::memory_order_acquire) != 0) || this->fillStreams.empty()) {
        segment->fillInFlight.store(false, std::memory_order_release);
        return false;
    }

    int minPos = 0;
    int minVal = INT32_MAX;
    const int streamNum = static_cast<int>(this->fillStreams.size());
    for (int i = 0; i < streamNum; i++) {
        const int refCount = this->fillStreamRefs[static_cast<size_t>(i)].load(std::memory_order_relaxed);
        if (refCount < minVal) {
            minVal = refCount;
            minPos = i;
        }
    }
    Stream* stream = this->fillStreams[static_cast<size_t>(minPos)];
    std::atomic<int>* streamRef = &this->fillStreamRefs[static_cast<size_t>(minPos)];

    const std::future<void> fillFuture = this->manager->FillThreads().Submit(
        [segment, stream, streamRef]() { (void)FillKeystreamTask(segment, stream, *streamRef); });
    const bool ret = fillFuture.valid();
    if (ret == false) {
        {
            std::lock_guard<std::mutex> lock(this->stateMutex_);
            segment->fillResult.store(static_cast<int32_t>(RT_ERROR_CC_CRYPTO_FAILED), std::memory_order_relaxed);
            PublishFillError(*this, RT_ERROR_CC_CRYPTO_FAILED);
            segment->fillInFlight.store(false, std::memory_order_release);
        }
        this->stateCv_.notify_all();
    }
    return ret;
}

KeystreamManager::KeystreamManager(int devId, const KeystreamOps* ops) : devId_(devId), ops_(ops) {}

namespace {
// 进程级宿主生成池故意不析构，避免退出期与设备资源释放发生跨组件时序依赖。
ThreadPool* CreateSharedHostGenPool()
{
    auto* const created = new (std::nothrow) ThreadPool();
    if (created == nullptr) {
        RT_LOG(RT_LOG_ERROR, "CC host keystream pool allocation failed, fall back to inline generate");
        return nullptr;
    }
    const rtError_t ret = created->Init(KS_HOST_GEN_THREAD_POOL_NAME, KS_HOST_GEN_POOL_MIN, KS_HOST_GEN_POOL_MAX);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "CC host keystream pool init failed, ret=%#x, fall back to inline generate",
            static_cast<uint32_t>(ret));
        delete created;
        return nullptr;
    }
    return created;
}
} // namespace

ThreadPool* KeystreamManager::SharedHostGenPool()
{
    static ThreadPool* const pool = CreateSharedHostGenPool();
    return pool;
}

rtError_t KeystreamManager::Init(const std::vector<KeystreamConfig>& configs, const KeystreamKey& key)
{
    bool expected = false;
    if (!this->isInit_.compare_exchange_strong(expected, true, std::memory_order_acq_rel)) {
        return RT_ERROR_NONE; // 幂等
    }

    const std::string poolName = std::string(KS_FILL_THREAD_POOL_NAME) + "_" + std::to_string(this->devId_);
    rtError_t ret = this->fillThreads.Init(poolName.c_str(), KS_FILL_THREAD_POOL_SIZE);
    if (ret != RT_ERROR_NONE) {
        this->isInit_.store(false, std::memory_order_release);
        return ret;
    }

    std::shared_ptr<KeystreamContext> context = std::make_shared<KeystreamContext>(this, this->devId_, configs, key);
    if (context->isInit == false) {
        this->fillThreads.Shutdown();
        context->Release();
        this->isInit_.store(false, std::memory_order_release);
        return RT_ERROR_CC_INIT_FAILED;
    }

    {
        std::lock_guard<std::mutex> lock(this->contextMutex_);
        this->context_ = std::move(context);
    }
    return RT_ERROR_NONE;
}

void KeystreamManager::Release()
{
    if (this->isInit_.exchange(false, std::memory_order_acq_rel) == false) {
        return;
    }

    // 先 Join 在途填充任务，再销毁上下文。
    this->fillThreads.Shutdown();

    std::shared_ptr<KeystreamContext> context;
    {
        std::lock_guard<std::mutex> lock(this->contextMutex_);
        context = std::move(this->context_);
    }
    context.reset();
}

rtError_t KeystreamManager::GetKeystreamPair(KeystreamPair& pair, int length, int timeoutMs)
{
    if ((this->isInit_.load(std::memory_order_acquire) == false) || (length <= 0)) {
        return RT_ERROR_INVALID_VALUE;
    }

    std::shared_ptr<KeystreamContext> context;
    {
        std::lock_guard<std::mutex> lock(this->contextMutex_);
        context = this->context_;
    }
    if (context == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }

    std::deque<std::unique_ptr<KeystreamSegment>>& segments = context->segments;

    const auto getStart = std::chrono::steady_clock::now();
    bool waited = false;
    auto finishGet = [&](rtError_t result) {
        const auto spendUs =
            std::chrono::duration_cast<std::chrono::microseconds>(std::chrono::steady_clock::now() - getStart);
        RT_LOG(
            RT_LOG_DEBUG, "get keystream, len=%d waited=%d spendUs=%lld ret=%#x", length, (waited) ? 1 : 0,
            static_cast<long long>(spendUs.count()), static_cast<uint32_t>(result));
        return result;
    };

    RetryNeedFillSegments(segments);

    rtError_t fillErr = CheckFillFailed(*context, length);
    if (fillErr != RT_ERROR_NONE) {
        return finishGet(fillErr);
    }

    if (TryPickSegment(segments, pair, length) == RT_ERROR_NONE) {
        return finishGet(RT_ERROR_NONE);
    }

    const auto timeEnd = std::chrono::steady_clock::now() + std::chrono::milliseconds(timeoutMs);
    for (;;) {
        // 提交补填可能获取 stateMutex_，须在锁外执行。
        RetryNeedFillSegments(segments);

        fillErr = CheckFillFailed(*context, length);
        if (fillErr != RT_ERROR_NONE) {
            return finishGet(fillErr);
        }

        std::unique_lock<std::mutex> lock(context->stateMutex_);
        if (TryPickSegment(segments, pair, length) == RT_ERROR_NONE) {
            return finishGet(RT_ERROR_NONE);
        }
        if (std::chrono::steady_clock::now() >= timeEnd) {
            break;
        }
        waited = true; // 本次确实阻塞在条件变量上（填充未跟上）
        (void)context->stateCv_.wait_until(lock, timeEnd);
    }

    RT_LOG(
        RT_LOG_ERROR, "Keystream pool request timed out, length=%d timeoutMs=%d segments=%zu", length, timeoutMs,
        segments.size());
    for (const auto& segmentPtr : segments) {
        const KeystreamSegment* const segment = segmentPtr.get();
        if (segment == nullptr) {
            continue;
        }
        RT_LOG(
            RT_LOG_DEBUG, "pool snapshot, seg=%d size=%d needFill=%d ready=%d avail=%d consumers=%d inflight=%d",
            segment->segmentId, segment->segmentSize,
            static_cast<int>(segment->needFill.load(std::memory_order_relaxed)),
            static_cast<int>(segment->ready.load(std::memory_order_relaxed)),
            segment->availablePos.load(std::memory_order_relaxed),
            segment->currentConsumers.load(std::memory_order_relaxed),
            static_cast<int>(segment->fillInFlight.load(std::memory_order_relaxed)));
    }
    return RT_ERROR_INVALID_VALUE; // 等待超时
}

rtError_t KeystreamManager::FreeKeystreamPair(KeystreamPair& ksPair)
{
    if ((this->isInit_.load(std::memory_order_acquire) == false) || (ksPair.keystreamId < 0)) {
        return RT_ERROR_INVALID_VALUE;
    }

    std::shared_ptr<KeystreamContext> context;
    {
        std::lock_guard<std::mutex> lock(this->contextMutex_);
        context = this->context_;
    }
    if (context == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }

    auto& segments = context->segments;
    if (static_cast<size_t>(ksPair.keystreamId) >= segments.size()) {
        return RT_ERROR_INVALID_VALUE;
    }
    KeystreamSegment* segment = segments[static_cast<size_t>(ksPair.keystreamId)].get();
    return (segment == nullptr) ? RT_ERROR_INVALID_VALUE : segment->FreeKeystreamPair(ksPair);
}

} // namespace runtime
} // namespace cce
