/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef OP_API_WORKSPACE_OP_CACHE_H
#define OP_API_WORKSPACE_OP_CACHE_H
#include <vector>
#include <thread>
#include <chrono>
#include <mutex>
#include <atomic>
#include <queue>
#include <unordered_map>
#include "opdev/common_types.h"
#include <string.h>
#include <cstdint>
#include <iomanip>
#include "opdev/shape_utils.h"
#include "opdev/op_dfx.h"
#include "opdev/op_cache_container.h"
#include "opdev/fast_vector.h"

namespace op {
namespace internal {
constexpr uint64_t K_HASH_BUF_SIZE = 8192;
constexpr uint64_t K_CACHE_BUF_SIZE = 65536;
constexpr size_t K_CACHE_LIMIT = 10000;
constexpr size_t K_MAX_CACHE_LIMIT = 10000000;
constexpr uint64_t K_INVALID_HASH_OFFSET = K_HASH_BUF_SIZE + 1024;
constexpr uint64_t K_CACHE_WRAP_MAGIC_NUMBER = 0xAFBECDDCEBFA;
constexpr size_t K_CACHE_SIZE_ALIGN = 32;
constexpr size_t K_CACHE_SHRINK_NUM = 30;
static constexpr size_t OP_BYTE_FOR_HEX = 2U;
extern thread_local char g_hashBuf[K_HASH_BUF_SIZE];
extern thread_local uint64_t g_hashOffset;
extern thread_local char g_cacheBuf[K_CACHE_BUF_SIZE];

class OpExecCacheDfx;
class OpExecCacheWrap;

void *GetCacheBuf();
bool CheckCacheable();

void AddSeperator();

template <typename T>
void AddParamToBuf(const T *addr, uint64_t size)
{
    uint64_t &hashOffset = g_hashOffset;
    if (hashOffset + size * sizeof(T) > K_HASH_BUF_SIZE) {
        hashOffset = K_INVALID_HASH_OFFSET;
        return;
    }
    OP_CHECK(memcpy_s(g_hashBuf + hashOffset, K_HASH_BUF_SIZE - hashOffset, addr, size * sizeof(T)) == EOK,
             OP_LOGW("Failed to memcpy in op cahce."),
             ;);
    hashOffset += size * sizeof(T);
};

void AddParamToBuf(const aclTensor *tensor);
void AddParamToBuf(aclTensor *tensor);
void AddParamToBuf(const aclScalar *scalar);
void AddParamToBuf(const aclIntArray *value);
void AddParamToBuf(const aclBoolArray *value);
void AddParamToBuf(const aclFloatArray *value);
void AddParamToBuf(const aclFp16Array *value);
void AddParamToBuf(const aclTensorList *tensors);
void AddParamToBuf(const aclScalarList *scalars);
void AddParamToBuf(aclTensorList *tensors);
void AddParamToBuf(aclScalarList *scalars);
void AddParamToBuf(const std::string &s);
void AddParamToBuf(const aclDataType dtype);
void AddParamToBuf(const char *c);
void AddParamToBuf(char *c);
void AddParamToBuf();

template <typename T>
void AddParamToBuf(const T &value)
{
    uint64_t &hashOffset = g_hashOffset;
    if (hashOffset + sizeof(T) > K_HASH_BUF_SIZE) {
        hashOffset = K_INVALID_HASH_OFFSET;
        return;
    }
    OP_CHECK(memcpy_s(g_hashBuf + hashOffset, K_HASH_BUF_SIZE - hashOffset, &value, sizeof(T)) == EOK,
             OP_LOGW("Failed to memcpy in op cahce."),
             ;);
    hashOffset += sizeof(T);
};

void InitExecutorCacheThreadLocal();
void AddOpConfigInfoToBuf();
bool GetFromCache(aclOpExecutor **executor, uint64_t *workspaceSize);

template <typename... Args>
void CaculateHashKey(const std::tuple<Args...> &t)
{
    auto lambda = [](auto &&...args) {
        [[maybe_unused]] int dummy[] = {(AddParamToBuf(std::forward<decltype(args)>(args)), 0)...};
    };
    std::apply(lambda, t);
};

template <typename INPUT_TUPLE = void *, typename OUTPUT_TUPLE = void *>
bool GetFromCache(aclOpExecutor **executor, uint64_t *workspaceSize,
                  const char *api, const INPUT_TUPLE &in, const OUTPUT_TUPLE &out)
{
    // Collecting Cache Data
    InitExecutorCacheThreadLocal();
    AddParamToBuf(api);
    AddOpConfigInfoToBuf();
    CaculateHashKey(in);
    CaculateHashKey(out);
    if (!CheckCacheable()) {
        return false;
    }
    // Get executor ande workspaceSize from Cache
    return GetFromCache(executor, workspaceSize);
}

struct OpCacheKey {
    uint8_t *buf;
    size_t len;

    OpCacheKey() : buf(nullptr), len(0)
    {}

    OpCacheKey(uint8_t *buf_, size_t len_) : buf(buf_), len(len_)
    {}

    OpCacheKey(const OpCacheKey &key);

    friend bool operator==(const OpCacheKey &lhs, const OpCacheKey &rhs);
    ge::AscendString ToString();
};

struct OpCacheKeyHash {
    std::size_t operator()(const OpCacheKey &key) const;
};

struct OpCacheKeyEqual {
    bool operator()(const OpCacheKey &lhs, const OpCacheKey &rhs) const;
};

void SetOpCacheKey(OpCacheKey &key);

struct AddrRule {
    bool isWorkspace{false};
    uint64_t workspaceOffset{0};
    int l2TensorInx{0};
    int64_t l2TensorOffset{0};
    AddrRule(){};
    AddrRule(bool w, uint64_t offset, int inx, int64_t l2Offset)
        : isWorkspace(w), workspaceOffset(offset), l2TensorInx(inx), l2TensorOffset(l2Offset){};
};

class OpExecCache {
public:
    OpExecCache();
    ~OpExecCache();

    using R = aclnnStatus (*)(aclrtStream, void *cache);
    using Task = std::tuple<size_t, R>;

    void InitOpCacheKey();
    void InitCacheData();

    aclnnStatus RecordAddrRule(const aclTensor *t, AddrRule &rule);

    void *AddLaunchTensor(const aclTensor *t, size_t dataLen);
    void *AddLaunchData(size_t dataLen);

    void SetCacheBuf(void *buf);

    void UpdateTensorAddr(void *workspaceAddr, const std::vector<void *> &tensors);

    void SetBlockDim(uint32_t blockDim);

    void SetCacheTensorInfo(void *infoLists);
    void *GetCacheTensorInfo(int index);
    void AddTensorRelation(const aclTensor *tensorOut, const aclTensor *tensorMiddle);

    void NewLaunchCache(size_t *offset, size_t *cap, R runner);

    void OldCacheClear();

    void Finalize();

    void SetWorkspaceSize(uint64_t val);
    uint64_t GetWorkspaceSize() const;

    uint64_t GetHash() const;

    OpCacheKey GetOpCacheKey() const;
    void MarkOpCacheInvalid();
    bool IsOpCacheValid();

    aclnnStatus DoSummaryProfiling(int index);

    void RestoreThreadLocal(int index);

    aclnnStatus Run(void *workspaceAddr, const aclrtStream stream, const std::vector<void *> &tensors);

    bool CanUse();
    void SetUse();

    inline ListHead *GetShrinkList()
    {
        return &shrinkList_;
    }
    std::unordered_map<const aclStorage *, const aclStorage *> GetStorageRelation();
    OpExecCacheDfx *opExecCacheDfx_{nullptr};

private:
    // cache meta data
    void *cacheBuf_{nullptr};
    size_t cacheOffset_{0};
    size_t cacheCap_{K_CACHE_BUF_SIZE};
    std::atomic<bool> canUse_{false};
    // cache to use meta data
    std::unordered_map<size_t, AddrRule> addrUpdateRelation_;
    std::vector<Task> taskQueue_;
    uint64_t hashKey_{0};
    OpCacheKey key_;
    uint64_t workspaceSize_{0};
    bool hasExclusiveMem_{false};
    const char *l2Name_{nullptr};
    // temporary data
    std::vector<const aclStorage *> cachedStorageList_;
    std::unordered_map<const aclStorage *, const aclStorage *> storageRelation_;
    // dfx data
    std::vector<void *> cacheTensorInfoLists_;
    std::vector<uint32_t> blockDim_;
    ListHead shrinkList_;
    uint8_t reserved_field_[8]; // Reserved field
};

struct OpCacheValue : public ListHead, public HlistNode, public OpCacheKey {
    OpCacheValue() = default;

    ~OpCacheValue();

    OpCacheValue(OpExecCache *cache, OpCacheKey &key)
        : OpCacheKey(key.buf, key.len), cache_(cache) {}

    OpCacheValue(const OpCacheValue &value);

    OpCacheValue(OpCacheValue &&value);

    OpCacheValue &operator=(const OpCacheValue &value);

    OpCacheValue &operator=(OpCacheValue &&value);

    OpExecCache *cache_ = nullptr;
};

OpExecCache *GetOpExecCache(uint64_t hash);
OpExecCache *GetOpExecCache(OpCacheKey &key);
bool AddOpExecCache(OpExecCache *exec);
void RemoveExecCache(OpExecCache *exec);

}  // namespace internal

}  // namespace op
#endif  // OP_API_WORKSPACE_OP_CACHE_H
