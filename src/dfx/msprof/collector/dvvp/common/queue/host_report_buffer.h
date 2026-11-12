/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License");
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED.
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef HOST_REPORT_BUFFER_H
#define HOST_REPORT_BUFFER_H

#include <atomic>
#include <mutex>
#include <cstddef>
#include <cstdint>
#include <limits>
#include <string>
#include "securec.h"
#include "logger/msprof_dlog.h"
#include "prof_api.h"

namespace analysis {
namespace dvvp {
namespace common {
namespace queue {

constexpr size_t HOST_MAX_RING_BUFF_CAPACITY = 2097152; // 2097152: 2M
constexpr size_t HOST_MIN_RING_BUFF_CAPACITY = 2048;    // 2048: 2K
constexpr size_t HOST_API_RING_BUFF_CAPACITY = 131072;  // 131072: 128K
constexpr size_t HOST_COM_RING_BUFF_CAPACITY = 262144;  // 262144: 256K
constexpr size_t HOST_ADD_RING_BUFF_CAPACITY = 262144;  // 262144: 256K
constexpr uint32_t HOST_NEG_RING_BUFF_PERCENT = 1000;   // 1000: (1/0.1%)
constexpr uint32_t HOST_CARDINALITY_RING_BUFF = 2;      // 2^n cardinal number

namespace {
constexpr size_t HOST_REPORT_BUFFER_MAX_CYCLES = 2048;
constexpr uint32_t HOST_PUSH_WAIT_TIME = 1;
constexpr size_t HOST_DISCARD_LOG_INTERVAL = 65536; // 65536: log the first and every 64K dropped records
constexpr size_t HOST_CACHE_LINE_SIZE = 64;         // 64: common cache line size on x86_64/aarch64
constexpr uint8_t HOST_RECORD_UNCOMMITTED = 0;
constexpr uint8_t HOST_RECORD_COMMITTED = 1;
constexpr uint8_t HOST_RECORD_DISCARDED = 2;

#if defined(__x86_64__) || defined(__i386__) || defined(_M_X64) || defined(_M_IX86)
#define HOST_CPU_PAUSE() __builtin_ia32_pause()
#elif defined(__aarch64__) || defined(__arm__)
#define HOST_CPU_PAUSE() __asm__ __volatile__("yield")
#else
#define HOST_CPU_PAUSE() ((void)0)
#endif

inline void DeleteHostBuffer(void* buffer)
{
    if (buffer != nullptr) {
        delete[] static_cast<uint8_t*>(buffer);
    }
}

} // namespace

// Each aging partition supports multiple producers and one consumer at a time.
class HostReportBuffer {
public:
    explicit HostReportBuffer(size_t recordSize);
    ~HostReportBuffer();

    void Init(size_t capacity, const std::string& name);
    void UnInit();
    int32_t BatchPush(uint32_t aging, const void* data, size_t dataSize);
    int32_t BatchPushWait(uint32_t aging, const void* data, size_t dataSize);
    void* BatchPop(uint32_t aging, size_t& popSize, bool popForce);
    void BatchPopBufferIndexShift(void* popPtr, size_t popSize);
    size_t GetUsedSize() const;

private:
    struct Cursor {
        std::atomic<size_t>* read;
        std::atomic<size_t>* write;
        std::atomic<size_t>* writeIdle;
        std::atomic<size_t>* discardedSize;
        std::atomic<uint32_t>* commitSize;
        std::atomic<uint8_t>* recordState;
        size_t capacity;
    };

    Cursor GetCursor(uint32_t aging);
    static size_t GetBufferUsedSize(
        const std::atomic<size_t>& readIndex, const std::atomic<size_t>& writeIndex, size_t capacity);
    bool IsAvail(const void* begin, size_t recordCount) const;
    static bool TryReserveSpace(const Cursor& cursor, std::atomic<size_t>& reservedSize, size_t inSize);
    static void ReleaseReservedSize(std::atomic<size_t>& reservedSize, size_t size);
    int32_t BatchPushImpl(uint32_t aging, const void* data, size_t dataSize, bool waitConsumer);
    void DropCurrentBatch(std::atomic<size_t>& overflowDiscardSize, size_t inSize) const;
    bool PushFullPath(
        const Cursor& cursor, uint32_t aging, const void* data, size_t dataSize, size_t inSize,
        std::atomic<size_t>& overflowDiscardSize, std::atomic<size_t>& reservedSize);
    bool CopyToRingBuffer(const Cursor& cursor, uint32_t aging, const void* data, size_t dataSize, size_t writeCursor);
    static void AdvanceCommitIndex(const Cursor& cursor);
    static void MarkReservedBatch(const Cursor& cursor, size_t writeCursor, size_t inSize, uint8_t state);
    void SkipInvalidRecord(const Cursor& cursor, size_t readCursor);
    static void CheckBufferOverflow(
        const std::atomic<size_t>& readIndex, const std::atomic<size_t>& writeIndex, size_t capacity);
    static size_t GetPendingDiscardedSize(size_t usedSize, const std::atomic<size_t>& discardedSize);

    size_t recordSize_;
    size_t capacity_;
    size_t maxCycles_;
    bool isInited_;
    std::string name_;
    uint8_t* dataQueue_;
    std::atomic<uint32_t>* commitSize_;
    std::atomic<uint8_t>* recordState_;
    size_t agingCapacity_;
    size_t unagingCapacity_;
    static_assert(
        HOST_CACHE_LINE_SIZE >= alignof(std::max_align_t),
        "Host report buffer cache line alignment must not be weaker than max alignment");

    // Each atomic cursor occupies its own cache line to avoid producer-consumer false sharing.
    alignas(HOST_CACHE_LINE_SIZE) std::atomic<size_t> agingReadIndex_;
    alignas(HOST_CACHE_LINE_SIZE) std::atomic<size_t> agingWriteIndex_;
    alignas(HOST_CACHE_LINE_SIZE) std::atomic<size_t> agingWriteIdleIndex_;
    alignas(HOST_CACHE_LINE_SIZE) std::atomic<size_t> unagingReadIndex_;
    alignas(HOST_CACHE_LINE_SIZE) std::atomic<size_t> unagingWriteIndex_;
    alignas(HOST_CACHE_LINE_SIZE) std::atomic<size_t> unagingWriteIdleIndex_;
    alignas(HOST_CACHE_LINE_SIZE) std::atomic<size_t> agingDiscardedSize_;
    alignas(HOST_CACHE_LINE_SIZE) std::atomic<size_t> unagingDiscardedSize_;
    alignas(HOST_CACHE_LINE_SIZE) std::atomic<size_t> agingReservedSize_;
    alignas(HOST_CACHE_LINE_SIZE) std::atomic<size_t> unagingReservedSize_;
    alignas(HOST_CACHE_LINE_SIZE) std::atomic<size_t> agingOverflowDiscardSize_;
    alignas(HOST_CACHE_LINE_SIZE) std::atomic<size_t> unagingOverflowDiscardSize_;
};

inline HostReportBuffer::HostReportBuffer(size_t recordSize)
    : recordSize_(recordSize),
      capacity_(0),
      maxCycles_(HOST_REPORT_BUFFER_MAX_CYCLES),
      isInited_(false),
      name_("HostReportBuffer"),
      dataQueue_(nullptr),
      commitSize_(nullptr),
      recordState_(nullptr),
      agingCapacity_(0),
      unagingCapacity_(0)
{
    agingReadIndex_.store(0);
    agingWriteIndex_.store(0);
    agingWriteIdleIndex_.store(0);
    unagingReadIndex_.store(0);
    unagingWriteIndex_.store(0);
    unagingWriteIdleIndex_.store(0);
    agingDiscardedSize_.store(0);
    unagingDiscardedSize_.store(0);
    agingReservedSize_.store(0);
    unagingReservedSize_.store(0);
    agingOverflowDiscardSize_.store(0);
    unagingOverflowDiscardSize_.store(0);
}

inline HostReportBuffer::~HostReportBuffer() { UnInit(); }

inline void HostReportBuffer::Init(size_t capacity, const std::string& name)
{
    if (isInited_) {
        MSPROF_LOGW("Repeat init report buffer capacity: %zu, buffer name: %s", capacity, name.c_str());
        return;
    }
    capacity_ = capacity;
    name_ = name;
    MSPROF_EVENT("Init report buffer capacity: %zu, buffer name: %s", capacity_, name_.c_str());
    dataQueue_ = new (std::nothrow) uint8_t[capacity_ * recordSize_]();
    commitSize_ = new (std::nothrow) std::atomic<uint32_t>[capacity_]();
    recordState_ = new (std::nothrow) std::atomic<uint8_t>[capacity_]();
    if ((dataQueue_ == nullptr) || (commitSize_ == nullptr) || (recordState_ == nullptr)) {
        MSPROF_LOGE("Failed to init report buffer");
        DeleteHostBuffer(dataQueue_);
        delete[] commitSize_;
        delete[] recordState_;
        dataQueue_ = nullptr;
        commitSize_ = nullptr;
        recordState_ = nullptr;
        return;
    }
    agingCapacity_ = (capacity_ < 4U) ? (capacity_ - capacity_ / 4U) : ((capacity_ * 3U + 3U) / 4U);
    unagingCapacity_ = capacity - agingCapacity_;
    agingReadIndex_.store(0);
    agingWriteIndex_.store(0);
    agingWriteIdleIndex_.store(0);
    unagingReadIndex_.store(0);
    unagingWriteIndex_.store(0);
    unagingWriteIdleIndex_.store(0);
    agingDiscardedSize_.store(0);
    unagingDiscardedSize_.store(0);
    agingReservedSize_.store(0);
    unagingReservedSize_.store(0);
    agingOverflowDiscardSize_.store(0);
    unagingOverflowDiscardSize_.store(0);
    isInited_ = true;
}

inline void HostReportBuffer::UnInit()
{
    if (!isInited_) {
        return;
    }
    isInited_ = false;
    CheckBufferOverflow(agingReadIndex_, agingWriteIndex_, agingCapacity_);
    CheckBufferOverflow(unagingReadIndex_, unagingWriteIndex_, unagingCapacity_);
    DeleteHostBuffer(dataQueue_);
    delete[] commitSize_;
    delete[] recordState_;
    dataQueue_ = nullptr;
    commitSize_ = nullptr;
    recordState_ = nullptr;
    const size_t totalReadCount = agingReadIndex_.exchange(0) + unagingReadIndex_.exchange(0);
    const size_t totalWriteCount = agingWriteIndex_.exchange(0) + unagingWriteIndex_.exchange(0);
    MSPROF_EVENT(
        "total_size_report [%s] read count: %zu, write count: %zu", name_.c_str(), totalReadCount, totalWriteCount);
    const size_t overflowDiscardCount = agingOverflowDiscardSize_.exchange(0) + unagingOverflowDiscardSize_.exchange(0);
    MSPROF_EVENT("total_size_report [%s] overflow discard count: %zu", name_.c_str(), overflowDiscardCount);
    agingWriteIdleIndex_.store(0);
    unagingWriteIdleIndex_.store(0);
    agingDiscardedSize_.store(0);
    unagingDiscardedSize_.store(0);
    agingReservedSize_.store(0);
    unagingReservedSize_.store(0);
    agingOverflowDiscardSize_.store(0);
    unagingOverflowDiscardSize_.store(0);
}

inline HostReportBuffer::Cursor HostReportBuffer::GetCursor(uint32_t aging)
{
    if (aging != 0U) {
        return Cursor{&agingReadIndex_, &agingWriteIndex_, &agingWriteIdleIndex_, &agingDiscardedSize_,
                      commitSize_,      recordState_,      agingCapacity_};
    }
    return Cursor{&unagingReadIndex_,     &unagingWriteIndex_,          &unagingWriteIdleIndex_,
                  &unagingDiscardedSize_, commitSize_ + agingCapacity_, recordState_ + agingCapacity_,
                  unagingCapacity_};
}

inline int32_t HostReportBuffer::BatchPush(uint32_t aging, const void* data, size_t dataSize)
{
    return BatchPushImpl(aging, data, dataSize, false);
}

inline int32_t HostReportBuffer::BatchPushWait(uint32_t aging, const void* data, size_t dataSize)
{
    return BatchPushImpl(aging, data, dataSize, true);
}

inline int32_t HostReportBuffer::BatchPushImpl(uint32_t aging, const void* data, size_t dataSize, bool waitConsumer)
{
    if (!isInited_) {
        MSPROF_LOGW("Ring buffer %s is not initialized.", name_.c_str());
        return MSPROF_ERROR_UNINITIALIZE;
    }
    if (data == nullptr || dataSize == 0U || dataSize % recordSize_ != 0U) {
        MSPROF_LOGW(
            "Invalid batch push input, buffer name: %s, record size: %zu, data size: %zu", name_.c_str(), recordSize_,
            dataSize);
        return MSPROF_ERROR_CONFIG_INVALID;
    }

    const Cursor cursor = GetCursor(aging);
    const size_t inSize = dataSize / recordSize_;
    std::atomic<size_t>& reservedSize = (aging != 0U) ? agingReservedSize_ : unagingReservedSize_;
    std::atomic<size_t>& overflowDiscardSize = (aging != 0U) ? agingOverflowDiscardSize_ : unagingOverflowDiscardSize_;
    if (!waitConsumer) {
        // Full-buffer fast check: one relaxed load instead of the add/sub rollback pair. A stale
        // (too small) read falls through to the strict TryReserveSpace below; a stale (too large)
        // read only drops a batch that a racing consumer may have just freed, which stays within the
        // drop-on-full contract.
        const size_t used = reservedSize.load(std::memory_order_relaxed);
        if (used + inSize > cursor.capacity - 1U) {
            DropCurrentBatch(overflowDiscardSize, inSize);
            return MSPROF_ERROR_NONE;
        }
    }
    if (!TryReserveSpace(cursor, reservedSize, inSize)) {
        if (waitConsumer) {
            if (!PushFullPath(cursor, aging, data, dataSize, inSize, overflowDiscardSize, reservedSize)) {
                return MSPROF_ERROR_CONFIG_INVALID;
            }
        } else {
            DropCurrentBatch(overflowDiscardSize, inSize);
        }
        return MSPROF_ERROR_NONE;
    }

    const size_t writeCursor = cursor.writeIdle->fetch_add(inSize, std::memory_order_acq_rel);
    const size_t index = writeCursor % cursor.capacity;
    const size_t offset = index * recordSize_;
    uint8_t* buffer = dataQueue_ + ((aging != 0U) ? 0U : (agingCapacity_ * recordSize_));
    if (offset + dataSize <= cursor.capacity * recordSize_) {
        if (memcpy_s(buffer + offset, dataSize, data, dataSize) == EOK) {
            MarkReservedBatch(cursor, writeCursor, inSize, HOST_RECORD_COMMITTED);
            return MSPROF_ERROR_NONE;
        }
    } else {
        const size_t endSize = (cursor.capacity - index) * recordSize_;
        const size_t frontSize = dataSize - endSize;
        if ((memcpy_s(buffer + offset, endSize, data, endSize) == EOK) &&
            (memcpy_s(buffer, frontSize, static_cast<const uint8_t*>(data) + endSize, frontSize) == EOK)) {
            MarkReservedBatch(cursor, writeCursor, inSize, HOST_RECORD_COMMITTED);
            return MSPROF_ERROR_NONE;
        }
    }

    MSPROF_LOGE("Failed to copy report buffer data, buffer name: %s", name_.c_str());
    MarkReservedBatch(cursor, writeCursor, inSize, HOST_RECORD_DISCARDED);
    return MSPROF_ERROR_CONFIG_INVALID;
}

inline void HostReportBuffer::DropCurrentBatch(std::atomic<size_t>& overflowDiscardSize, size_t inSize) const
{
    // Diagnostic-only counter read at UnInit and in UT: no cross-thread ordering dependency, so the
    // relaxed order avoids needless fences on the hottest (full-buffer) path.
    const size_t beforeDiscard = overflowDiscardSize.fetch_add(inSize, std::memory_order_relaxed);
    const size_t afterDiscard = beforeDiscard + inSize;
    const bool crossesLogInterval =
        (beforeDiscard / HOST_DISCARD_LOG_INTERVAL) != (afterDiscard / HOST_DISCARD_LOG_INTERVAL);
    if ((beforeDiscard == 0U) || crossesLogInterval) {
        // Event level: warning is disabled by the default log level, so drops must stay visible there.
        MSPROF_EVENT(
            "Report buffer full, drop data, buffer name: %s, batch size: %zu, total discarded: %zu", name_.c_str(),
            inSize, afterDiscard);
    }
}

inline bool HostReportBuffer::PushFullPath(
    const Cursor& cursor, uint32_t aging, const void* data, size_t dataSize, size_t inSize,
    std::atomic<size_t>& overflowDiscardSize, std::atomic<size_t>& reservedSize)
{
    size_t cycles = 0;
    while (true) {
        if (TryReserveSpace(cursor, reservedSize, inSize)) {
            const size_t writeCursor = cursor.writeIdle->fetch_add(inSize, std::memory_order_acq_rel);
            if (!CopyToRingBuffer(cursor, aging, data, dataSize, writeCursor)) {
                MSPROF_LOGE("Failed to replay report buffer data, buffer name: %s", name_.c_str());
                MarkReservedBatch(cursor, writeCursor, inSize, HOST_RECORD_DISCARDED);
                return false;
            }
            MarkReservedBatch(cursor, writeCursor, inSize, HOST_RECORD_COMMITTED);
            return true;
        }

        cycles++;
        if (cycles >= maxCycles_) {
            // Reuse DropCurrentBatch so both drop paths share the same counter order and log cadence.
            DropCurrentBatch(overflowDiscardSize, inSize);
            return true;
        }

        (void)usleep(HOST_PUSH_WAIT_TIME);
    }
}

inline bool HostReportBuffer::CopyToRingBuffer(
    const Cursor& cursor, uint32_t aging, const void* data, size_t dataSize, size_t writeCursor)
{
    const size_t index = writeCursor % cursor.capacity;
    const size_t offset = index * recordSize_;
    uint8_t* buffer = dataQueue_ + ((aging != 0U) ? 0U : (agingCapacity_ * recordSize_));
    if (offset + dataSize > cursor.capacity * recordSize_) {
        const size_t endSize = (cursor.capacity - index) * recordSize_;
        const size_t frontSize = dataSize - endSize;
        return (memcpy_s(buffer + offset, endSize, data, endSize) == EOK) &&
               (memcpy_s(buffer, frontSize, static_cast<const uint8_t*>(data) + endSize, frontSize) == EOK);
    }
    return memcpy_s(buffer + offset, dataSize, data, dataSize) == EOK;
}

inline void HostReportBuffer::AdvanceCommitIndex(const Cursor& cursor)
{
    size_t committed = cursor.write->load(std::memory_order_acquire);
    while (true) {
        const size_t idle = cursor.writeIdle->load(std::memory_order_acquire);
        if (committed >= idle) {
            return;
        }

        const size_t index = committed % cursor.capacity;
        const uint32_t size = cursor.commitSize[index].load(std::memory_order_acquire);
        if (size == 0U) {
            return;
        }

        const uint8_t state = cursor.recordState[index].load(std::memory_order_acquire);
        if (state == HOST_RECORD_UNCOMMITTED) {
            return;
        }

        const size_t next = committed + size;
        if (state == HOST_RECORD_COMMITTED) {
            cursor.commitSize[index].store(0U, std::memory_order_release);
            cursor.recordState[index].store(HOST_RECORD_UNCOMMITTED, std::memory_order_release);
        }
        cursor.write->store(next, std::memory_order_release);
        committed = next;
    }
}

inline void HostReportBuffer::MarkReservedBatch(const Cursor& cursor, size_t writeCursor, size_t inSize, uint8_t state)
{
    const size_t index = writeCursor % cursor.capacity;
    cursor.commitSize[index].store(static_cast<uint32_t>(inSize), std::memory_order_release);
    cursor.recordState[index].store(state, std::memory_order_release);
    if (state == HOST_RECORD_DISCARDED) {
        (void)cursor.discardedSize->fetch_add(inSize, std::memory_order_release);
    }
}

inline bool HostReportBuffer::TryReserveSpace(const Cursor& cursor, std::atomic<size_t>& reservedSize, size_t inSize)
{
    const size_t oldReservedSize = reservedSize.fetch_add(inSize, std::memory_order_acq_rel);
    if (oldReservedSize + inSize <= cursor.capacity - 1U) {
        return true;
    }

    (void)reservedSize.fetch_sub(inSize, std::memory_order_acq_rel);
    return false;
}

inline void HostReportBuffer::ReleaseReservedSize(std::atomic<size_t>& reservedSize, size_t size)
{
    (void)reservedSize.fetch_sub(size, std::memory_order_acq_rel);
}

inline void* HostReportBuffer::BatchPop(uint32_t aging, size_t& popSize, bool popForce)
{
    if (!isInited_ || popSize == 0) {
        return nullptr;
    }

    const Cursor cursor = GetCursor(aging);
    size_t currReadCursor = cursor.read->load(std::memory_order_relaxed);
    AdvanceCommitIndex(cursor);
    currReadCursor = cursor.read->load(std::memory_order_relaxed);
    size_t currWriteCursor = cursor.write->load(std::memory_order_acquire);
    while (currReadCursor < currWriteCursor) {
        const size_t index = currReadCursor % cursor.capacity;
        const uint32_t commitSize = cursor.commitSize[index].load(std::memory_order_acquire);
        const uint8_t state = cursor.recordState[index].load(std::memory_order_acquire);
        if ((commitSize == 0U) || (state == HOST_RECORD_UNCOMMITTED)) {
            break;
        }

        if (state == HOST_RECORD_DISCARDED) {
            currReadCursor += commitSize;
            cursor.commitSize[index].store(0U, std::memory_order_release);
            cursor.recordState[index].store(HOST_RECORD_UNCOMMITTED, std::memory_order_release);
            cursor.read->store(currReadCursor, std::memory_order_release);
            (void)cursor.discardedSize->fetch_sub(commitSize, std::memory_order_acq_rel);
            ReleaseReservedSize(
                (cursor.capacity == agingCapacity_) ? agingReservedSize_ : unagingReservedSize_, commitSize);
            continue;
        }
        break;
    }

    if (currReadCursor == currWriteCursor) {
        popSize = 0;
        HOST_CPU_PAUSE();
        return nullptr;
    }

    const size_t availSize = (currWriteCursor - currReadCursor) * recordSize_;
    const size_t offerSize = (availSize >= popSize) ? popSize : availSize;
    if ((offerSize < popSize) && !popForce) {
        popSize = offerSize;
        return nullptr;
    }

    const size_t currIndex = currReadCursor % cursor.capacity;
    const size_t currOffset = currIndex * recordSize_;
    uint8_t* buffer = dataQueue_ + ((aging != 0U) ? 0U : (agingCapacity_ * recordSize_));
    const size_t tailSize = (cursor.capacity - currIndex) * recordSize_;
    if (offerSize <= tailSize) {
        if (!IsAvail(buffer + currOffset, offerSize / recordSize_)) {
            SkipInvalidRecord(cursor, currReadCursor);
            popSize = 0;
            return nullptr;
        }
        popSize = offerSize;
        return buffer + currOffset;
    }

    if (!IsAvail(buffer + currOffset, tailSize / recordSize_)) {
        SkipInvalidRecord(cursor, currReadCursor);
        popSize = 0;
        return nullptr;
    }
    const size_t offerCount = (offerSize < tailSize) ? (offerSize / recordSize_) : (tailSize / recordSize_);
    popSize = offerCount * recordSize_;
    return buffer + currOffset;
}

inline void HostReportBuffer::BatchPopBufferIndexShift(void* popPtr, size_t popSize)
{
    if (popPtr == nullptr || popSize == 0) {
        return;
    }

    const bool isAging = (popPtr < static_cast<void*>(dataQueue_ + (agingCapacity_ * recordSize_)));
    Cursor cursor = GetCursor(isAging ? 1U : 0U);
    (void)memset_s(popPtr, popSize, 0, popSize);
    cursor.read->fetch_add(popSize / recordSize_, std::memory_order_release);
    ReleaseReservedSize(isAging ? agingReservedSize_ : unagingReservedSize_, popSize / recordSize_);
}

inline size_t HostReportBuffer::GetUsedSize() const
{
    const size_t agingUsedSize = GetBufferUsedSize(agingReadIndex_, agingWriteIdleIndex_, agingCapacity_);
    const size_t unagingUsedSize = GetBufferUsedSize(unagingReadIndex_, unagingWriteIdleIndex_, unagingCapacity_);
    const size_t agingDiscardedSize = GetPendingDiscardedSize(agingUsedSize, agingDiscardedSize_);
    const size_t unagingDiscardedSize = GetPendingDiscardedSize(unagingUsedSize, unagingDiscardedSize_);
    return (agingUsedSize - agingDiscardedSize) + (unagingUsedSize - unagingDiscardedSize);
}

inline size_t HostReportBuffer::GetPendingDiscardedSize(size_t usedSize, const std::atomic<size_t>& discardedSize)
{
    const size_t pendingDiscardedSize = discardedSize.load(std::memory_order_acquire);
    return pendingDiscardedSize > usedSize ? usedSize : pendingDiscardedSize;
}

inline size_t HostReportBuffer::GetBufferUsedSize(
    const std::atomic<size_t>& readIndex, const std::atomic<size_t>& writeIndex, size_t capacity)
{
    const size_t read = readIndex.load(std::memory_order_relaxed);
    const size_t write = writeIndex.load(std::memory_order_relaxed);
    if (read > write) {
        return ((std::numeric_limits<size_t>::max() - read + write) % capacity);
    }
    return (write - read);
}

inline bool HostReportBuffer::IsAvail(const void* begin, size_t recordCount) const
{
    const uint8_t* data = static_cast<const uint8_t*>(begin);
    for (size_t i = 0; i < recordCount; i++) {
        const uint16_t* magic = reinterpret_cast<const uint16_t*>(data + (i * recordSize_));
        if (*magic != MSPROF_REPORT_DATA_MAGIC_NUM) {
            return false;
        }
    }
    return true;
}

inline void HostReportBuffer::SkipInvalidRecord(const Cursor& cursor, size_t readCursor)
{
    MSPROF_LOGW(
        "Report buffer invalid record, skip data, buffer name: %s, read cursor: %zu, record size: %zu", name_.c_str(),
        readCursor, recordSize_);
    cursor.read->store(readCursor + 1U, std::memory_order_release);
    ReleaseReservedSize((cursor.capacity == agingCapacity_) ? agingReservedSize_ : unagingReservedSize_, 1U);
}

inline void HostReportBuffer::CheckBufferOverflow(
    const std::atomic<size_t>& readIndex, const std::atomic<size_t>& writeIndex, size_t capacity)
{
    const size_t read = readIndex.load(std::memory_order_relaxed);
    const size_t write = writeIndex.load(std::memory_order_relaxed);
    if (write - read >= capacity) {
        MSPROF_LOGE("Report buffer overflow, capacity: %zu, read count: %zu, write count: %zu", capacity, read, write);
    }
}

} // namespace queue
} // namespace common
} // namespace dvvp
} // namespace analysis

#endif
