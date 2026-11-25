/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef KEYSTREAM_MANAGER_H
#define KEYSTREAM_MANAGER_H

#include <cstdint>
#include <cstddef>
#include <cstdlib>
#include <cstring>

#include <atomic>
#include <chrono>
#include <condition_variable>
#include <deque>
#include <functional>
#include <memory>
#include <mutex>
#include <random>
#include <vector>

#include "base.hpp"
#include "runtime.hpp"
#include "api.hpp"
#include "api_impl.hpp"
#include "npu_driver.hpp"
#include "memcpy_c.hpp"
#include "utils/thread_pool.h"
#include "../cc_crypto.h"

namespace cce {
namespace runtime {

#define KS_FILL_THREAD_POOL_NAME "KS_FILL"           // 拼接设备 ID，线程名总长不超过 15。
#define KS_HOST_GEN_THREAD_POOL_NAME "KS_GEN"
constexpr uint32_t KS_HOST_GEN_POOL_MIN = 2U;        // 初始线程数
constexpr uint32_t KS_HOST_GEN_POOL_MAX = 8U;        // 弹性上限
constexpr uint32_t KS_HOST_GEN_PAGES_PER_TASK = 4U;
constexpr int KS_GET_KEYSTREAM_TIMEOUT_MS = 5000;    // 请求密钥流资源超时（毫秒）
constexpr int KS_FILL_THREAD_POOL_SIZE = 1;
constexpr uint32_t KS_FILL_PAGE_SIZE = 128U * 1024U; // 并行填充的单页大小（16B 对齐）
constexpr uint32_t KS_FILL_BLOCK_DIM_DEFAULT = 6U;   // 查不到 AICPU 核数时的缺省并行度
constexpr uint32_t KS_FILL_BLOCK_DIM_MAX = 8U;       // AICPU 并行度上限
constexpr uint32_t KS_FILL_PAGES_PER_LAUNCH_MAX = 128U;
constexpr int KS_INIT_FILL_TIMEOUT_SEC = 120;        // Init 等待全部段首次填充的超时（秒）

struct KeystreamKey {
    uint8_t key[AICC_KEY_SIZE] = {0}; // 派生密钥流的对称密钥
    uint64_t keyAddr = 0U;            // 该密钥在设备密钥区中的地址（设备填充算子读取）
    uint32_t keyLen = AICC_KEY_SIZE;  // 密钥长度（字节）
};

// 以下填充参数须与设备算子的 ABI 一致。
struct AiccKeystreamFillTask {
    uint64_t keystreamAddr;       // 设备侧密钥流输出地址
    uint32_t keystreamLen;        // 密钥流长度
    uint32_t reserved;            // 对齐填充
    uint8_t iv[AICC_CTR_IV_SIZE]; // 初始化向量
};
static_assert(sizeof(AiccKeystreamFillTask) == 32U, "AiccKeystreamFillTask must be 32 bytes");
static_assert(offsetof(AiccKeystreamFillTask, iv) == 16U, "AiccKeystreamFillTask iv offset ABI");

struct AiccKeystreamFillParam {
    uint64_t keyAddr;              // 设备侧密钥基址
    uint32_t keyLen;               // 密钥长度
    uint32_t algType;              // 加密算法：AICC_ALG_AES128_KEYSTREAM(2)
    uint32_t taskNum;              // 任务数量
    uint32_t reserved;             // 对齐填充
    AiccKeystreamFillTask tasks[]; // 任务列表
};
static_assert(sizeof(AiccKeystreamFillParam) == 24U, "AiccKeystreamFillParam header must be 24 bytes");
static_assert(offsetof(AiccKeystreamFillParam, tasks) == 24U, "AiccKeystreamFillParam tasks offset ABI");

// 按 AES-CTR 的 128 位大端计数规则递增。
void AddIvCounter(uint8_t iv[AICC_CTR_IV_SIZE], uint64_t blocks);

uint32_t BuildKsFillTasks(
    uint64_t keystreamAddr, uint32_t segmentSize, const uint8_t baseIv[AICC_CTR_IV_SIZE], size_t ivLen,
    std::vector<AiccKeystreamFillTask>& tasks);

class KeystreamManager;
class KeystreamContext;
struct KeystreamSegment;

struct KeystreamConfig {
    int threshold;   // 剩余字节数低于阈值后停止分配，消费者归零后补填。
    int segmentSize; // 每段密钥流大小（字节）
    int segmentNum;  // 遵从该配置的密钥流段数
};

struct KeystreamOps {
    std::function<bool(KeystreamSegment& segment)> allocSegment;   // 申请 Host/Device 段缓冲
    std::function<void(KeystreamSegment& segment)> freeSegment;    // 释放段缓冲
    std::function<bool(KeystreamContext& context)> initContext;    // 初始化上下文（设备、密钥、stream）
    std::function<void(KeystreamContext& context)> releaseContext; // 释放上下文资源
    std::function<rtError_t(KeystreamSegment& segment, Stream* stream, const uint8_t* iv, size_t ivLen)>
        fillSegment;                                               // 填充一段
};

int32_t GenerateKeystream(const uint8_t* key, const uint8_t* iv, uint8_t* keystream, int32_t length);

const std::vector<KeystreamConfig>& GetDefaultKeystreamConfigs();

struct KeystreamSegment {
    KeystreamSegment() = delete;
    KeystreamSegment(const KeystreamSegment&) = delete;
    KeystreamSegment& operator=(const KeystreamSegment&) = delete;

    KeystreamSegment(KeystreamContext* context, int devId, int segmentId, int segmentSize, int threshold);
    ~KeystreamSegment() { this->Release(); }
    void Release();

    rtError_t GetKeystreamPair(KeystreamPair& pair, int length);
    rtError_t FreeKeystreamPair(KeystreamPair& pair);

    int devId = -1;                        // 所属设备 ID
    int segmentId = -1;                    // 当前密钥流段 ID
    int segmentSize = 0;                   // 密钥流段大小（字节）
    int threshold = 0;                     // 可用段数低于该阈值时，进入待填充状态
    uint8_t* hostAddr = nullptr;           // Host 侧密钥流段地址
    uint8_t* deviceAddr = nullptr;         // Device 侧密钥流段地址

    KeystreamContext* ksContext = nullptr; // 所属 KeystreamContext
    std::atomic<bool> needFill = true;     // 是否需要填充密钥流
    std::atomic<bool> fillInFlight = false; // 是否已有填充任务在途，保证同段同时只有一个填充任务
    std::atomic<bool> ready = false;        // 段内容有效（首次填充完成）；Get 以此为门控
    std::atomic<int> currentConsumers = 0; // 当前正在使用该段的消费者数量
    std::atomic<int> availablePos = -1;    // 指向可用缓冲的字节偏移，对齐到 AICC_BLOCK_SIZE 字节
    std::atomic<int32_t> fillResult = 0;   // 最近一次填充任务返回码（0 成功），供 Get 侧感知失败
    std::atomic<int64_t> nextFillTimeMs = 0; // steady_clock 毫秒，限制补填重试频率。
};

class KeystreamContext {
public:
    KeystreamContext() = delete;
    KeystreamContext(const KeystreamContext&) = delete;
    KeystreamContext& operator=(const KeystreamContext&) = delete;

    KeystreamContext(
        KeystreamManager* manager, int devId, const std::vector<KeystreamConfig>& config, const KeystreamKey& key);
    ~KeystreamContext() { this->Release(); }
    void Release();

    // 同段只允许一次填充在途；任务期间 segment 必须存活。
    bool FillKeystreamAsync(KeystreamSegment* segment);

    KeystreamManager* manager = nullptr;                    // 所属 KeystreamManager（提供填充线程池）
    int devId = -1;                                         // 所属设备 ID
    KeystreamKey key;                                       // 填充使用的密钥材料（CTR 单密钥）
    std::deque<std::unique_ptr<KeystreamSegment>> segments; // 按配置创建的密钥流段
    std::vector<Stream*> fillStreams;                       // 用于执行密钥流填充任务的 stream 数组
    std::vector<std::atomic<int>> fillStreamRefs;           // 每个 stream 的引用计数，避免过载
    uint32_t fillBlockDim = KS_FILL_BLOCK_DIM_DEFAULT;
    Context* rtContext = nullptr;                           // 所属设备的运行时上下文
    bool isInit = false;
    std::mutex stateMutex_;
    std::condition_variable stateCv_;
    std::atomic<int32_t> fillError{0}; // 首次失败使 Get 立即返回错误，填充成功后清零。

private:
    static bool InitFillFailed(
        const std::deque<std::unique_ptr<KeystreamSegment>>& segments, const std::atomic<int32_t>& fillError);

    static bool InitFillDone(
        const std::deque<std::unique_ptr<KeystreamSegment>>& segments, const std::atomic<int32_t>& fillError);
};

// 每设备一个实例；Get 低段优先，无可用段时等待填充完成或失败。
class KeystreamManager {
public:
    explicit KeystreamManager(int devId, const KeystreamOps* ops = nullptr);
    KeystreamManager(const KeystreamManager&) = delete;
    KeystreamManager& operator=(const KeystreamManager&) = delete;

    ~KeystreamManager() { this->Release(); }

    rtError_t Init(const std::vector<KeystreamConfig>& configs, const KeystreamKey& key);
    void Release();

    // length 按 AICC_BLOCK_SIZE 对齐占用；成功 Free 后清空密钥流对。
    rtError_t GetKeystreamPair(KeystreamPair& ksPair, int length, int timeoutMs = KS_GET_KEYSTREAM_TIMEOUT_MS);
    rtError_t FreeKeystreamPair(KeystreamPair& ksPair);

    ThreadPool& FillThreads() { return fillThreads; }
    const KeystreamOps* Ops() const { return ops_; }
    static ThreadPool* SharedHostGenPool();

    ThreadPool fillThreads; // 本设备独占的填充线程池。

private:
    int devId_ = -1;
    const KeystreamOps* ops_{nullptr};
    std::atomic<bool> isInit_{false};
    std::shared_ptr<KeystreamContext> context_; // 本设备的密钥流上下文
    mutable std::mutex contextMutex_;           // 保护 context_ 与 Release 的并发
};

} // namespace runtime
} // namespace cce

#endif // KEYSTREAM_MANAGER_H
