/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_OSAL_HPP__
#define __CCE_RUNTIME_OSAL_HPP__

#include <iostream>
#include <atomic>
#include <cstdlib>
#include <vector>
#include <map>
#include <string>
#include <mutex>
#include "runtime/base.h"
#include "mmpa/mmpa_api.h"
#include <functional>

// thread_local
#define LIBRARY_NAME ".so"
#define unlikely(x) (x)
#define likely(x) (x)
#define VISIBILITY_DEFAULT __attribute__((visibility("default")))
#define __THREAD_LOCAL__ __thread
#define CTZ(x) static_cast<uint32_t>(__builtin_ctz(x))

#define MEMORY_FENCE() std::atomic_thread_fence(std::memory_order_seq_cst)

namespace cce {
namespace runtime {
extern bool g_isAddrFlatDevice;
void * AlignedMalloc(const size_t aligned, const size_t size);

void AlignedFree(void * const addr);

bool CompareAndExchange(volatile uint64_t * const addr, const uint64_t currentValue, const uint64_t val);

bool CompareAndExchange(volatile uint32_t * const addr, const uint32_t currentValue, const uint32_t val);

void FetchAndOr(volatile uint64_t * const addr, const uint64_t val);

void FetchAndAnd(volatile uint64_t * const addr, const uint64_t val);

uint64_t BitScan(const uint64_t val);

uint32_t GetCurrentTid(void);

uint64_t GetTickCount(void);

template <class T>
class Atomic {
public:
    explicit Atomic(T v) noexcept : val_(v)
    {
    }

    ~Atomic() = default;


    bool CompareExchange(T exp, T val)
    {
        return val_.compare_exchange_strong(exp, val);
    }

    T Exchange(T val)
    {
        return val_.exchange(val);
    }

    T FetchAndAdd(T val)
    {
        return (T)val_.fetch_add(val);
    }

    T FetchAndSub(T val)
    {
        return (T)val_.fetch_sub(val);
    }

    T AddAndFetch(T val)
    {
        T old = val_.fetch_add(val);
        return old + val;
    }

    T SubAndFetch(T val)
    {
        T old = (T)val_.fetch_sub(val);
        return old - val;
    }

    void Add(T val)
    {
        (void)FetchAndAdd(val);
    }

    void Sub(T val)
    {
        (void)FetchAndSub(val);
    }

    T Value() const
    {
        const T val = (T)val_.load();
        return val;
    }

    void Set(T val)
    {
        val_.store(val);
    }

private:
    std::atomic<T> val_;
};

class SpinLock {
public:
    SpinLock() :atomicLock_(1)
    {
        (void)pthread_spin_init(&lock_, PTHREAD_PROCESS_PRIVATE);
    }

    ~SpinLock()
    {
        (void)pthread_spin_destroy(&lock_);
    }

    void Lock()
    {
        if (g_isAddrFlatDevice == false) {
            (void)pthread_spin_lock(&lock_);
        } else {
            while (!atomicLock_.CompareExchange(1, 0)) {
                continue;
            }
        }
        return;
    }

    void Unlock()
    {
        if (g_isAddrFlatDevice == false) {
            (void)pthread_spin_unlock(&lock_);
        } else {
            atomicLock_.Set(1);
        }
    }

private:
    pthread_spinlock_t lock_;
    Atomic<uint32_t> atomicLock_;
};

// The running body of a thread.
class ThreadRunnable {
public:
    virtual ~ThreadRunnable() = default;

    // Running entry of thread.
    virtual void Run(const void *param) = 0;
};

// An os thread running concurrency with others.
class Thread {
public:
    virtual ~Thread() = default;
    virtual int32_t Start() = 0;

    // join this thread to complete.
    virtual void Join() = 0;

    virtual bool IsAlive() = 0;
    virtual uint64_t GetThreadId() = 0;
};

// Notifier is used for synchronization between threads.
class Notifier {
public:
    virtual ~Notifier() = default;

    // Wait notify. will block if not trgierd.
    virtual rtError_t Wait(int32_t timeout = -1) = 0;

    // Triger notify. all waiting thread will be wakeup.
    virtual rtError_t Triger() = 0;

    // Reset notifier to un-trigerd state.
    virtual rtError_t Reset() = 0;
};

// Factory class for creating OS dependend object.
class OsalFactory {
public:
    // Create Thread object.
    // The thread will start after created.
    static Thread *CreateThread(const char_t * const name, ThreadRunnable * const runnable, void * const param);

    // Create Notifier object.
    static Notifier *CreateNotifier();
};

class PidTidFetcher {
public:
    static uint32_t GetCurrentPid(void);
    static uint32_t GetCurrentTid(void);
    static uint64_t GetCurrentUserTid(void);
};

class ScopeGuard {
public:
    explicit ScopeGuard(std::function<void()> callback)
        : exitCallback_(callback)
    {}

    ~ScopeGuard() noexcept
    {
        if (exitCallback_ != nullptr) {
            exitCallback_();
        }
    }
    void ReleaseGuard()
    {
        exitCallback_ = nullptr;
    }

private:
    ScopeGuard(ScopeGuard const&) = delete;
    ScopeGuard& operator=(ScopeGuard const&) = delete;
    ScopeGuard(ScopeGuard&&) = delete;
    ScopeGuard& operator=(ScopeGuard&&) = delete;

private:
    std::function<void()> exitCallback_;
};

class ThreadGuard {
public:
    ThreadGuard(): threadAtexitFlag_(false), monitorStatus_(true)
    {
    }
    ~ThreadGuard() = default;
    static void ThreadExit();
    void SetThreadTid(const mmThread inTid, const std::string &threadName);
    bool DelThreadTid(const mmThread inTid);
    bool FindThreadTid(const mmThread inTid);
    std::vector<std::pair<mmThread, std::string>> GetAllThreadTid();
    void SetThreadAtexitFlag(const bool inFlag);
    bool GetThreadAtexitFlag() const;
    void SetMonitorStatus(const bool monitorStatus);
    bool GetMonitorStatus() const;

private:
    Atomic<bool> threadAtexitFlag_;
    Atomic<bool> monitorStatus_;
    std::map<mmThread, std::string> threadTid_;
    std::mutex mutex_;
};
}
}

#endif  // __CCE_RUNTIME_OSAL_HPP__
