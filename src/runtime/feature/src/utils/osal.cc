/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "osal.hpp"
#include <new>
#include "thread_local_container.hpp"
#include "global_state_manager.hpp"

namespace {
constexpr uint32_t PTHREAD_STACK_SIZE_EXT_MAX_TIME = 3U;
static __THREAD_LOCAL__ uint32_t g_currentTid = 0U;
}

namespace cce {
namespace runtime {
uint64_t GetTickCount(void)
{
    const mmTimespec curTimeSpec = mmGetTickCount();
    // 1s : 1000000000ns
    return (static_cast<uint64_t>(curTimeSpec.tv_sec) * 1000000000UL) + static_cast<uint64_t>(curTimeSpec.tv_nsec);
}

uint32_t GetCurrentTid(void)
{
    if (g_currentTid == 0U) {
        g_currentTid = PidTidFetcher::GetCurrentTid();
    }
    return g_currentTid;
}

void *AlignedMalloc(const size_t aligned, const size_t size)
{
    UNUSED(aligned);
#ifdef CFG_DEV_PLATFORM_PC
    return malloc(size);
#elif !defined(WIN32)
    return aligned_alloc(aligned, size);
#else
    return malloc(size);
#endif
}

void AlignedFree(void * const addr)
{
    return free(addr);
}

bool CompareAndExchange(volatile uint64_t * const addr, const uint64_t currentValue, const uint64_t val)
{
#ifndef WIN32
    return __sync_bool_compare_and_swap(addr, currentValue, val);
#else
    return currentValue == InterlockedCompareExchange64((volatile LONG64 *)addr, val, currentValue);
#endif
}

bool CompareAndExchange(volatile uint32_t * const addr, const uint32_t currentValue, const uint32_t val)
{
#ifndef WIN32
    return __sync_bool_compare_and_swap(addr, currentValue, val);
#else
    return currentValue == InterlockedCompareExchange(addr, val, currentValue);
#endif
}

void FetchAndOr(volatile uint64_t * const addr, const uint64_t val)
{
#ifndef WIN32
    (void)__sync_fetch_and_or(addr, val);
#else
    InterlockedOr(addr, val);
#endif  // !WIN32
}

void FetchAndAnd(volatile uint64_t * const addr, const uint64_t val)
{
#ifndef WIN32
    (void)__sync_fetch_and_and(addr, val);
#else
    InterlockedAnd(addr, val);
#endif  // !WIN32
}

uint64_t BitScan(const uint64_t val)
{
#ifndef WIN32
    return static_cast<uint64_t>(__builtin_ffsll(val) - 1);
#else
    DWORD bitIdx = 0;
    // _BitScanForward64, If no set bit is found, 0 is returned; otherwise, 1 is returned.
    uint8_t ret = _BitScanForward64(&bitIdx, val);
    if (ret) {
        return bitIdx;
    } else {
        return UINT64_MAX;
    }
#endif
}

class LocalThread : public Thread {
public:
    LocalThread(const char_t * const thdName, ThreadRunnable * const thdRunnable, void * const thdParam);
    ~LocalThread() override;
    int32_t Start() override;
    void Join() override;
    bool IsAlive() override;

    static void *ThreadProc(void * const parameter);
    uint64_t GetThreadId() override
    {
        return threadHandle_;
    }
private:
    mmThread interThread_{0U};

    const char_t *name_{nullptr};
    ThreadRunnable *runnable_{nullptr};
    void *param_{nullptr};
    mmUserBlock_t userBlock_{nullptr, nullptr};
    uint64_t threadHandle_;
};

class LocalNotifier : public Notifier {
public:
    LocalNotifier();
    ~LocalNotifier() override;

    rtError_t Wait(int32_t timeout) override;
    rtError_t Triger() override;
    rtError_t Reset() override;

private:
    bool trigerd_{false};
    mmCond cond_;
    mmMutexFC mutex_;
};

void *LocalThread::ThreadProc(void * const parameter)
{
    LocalThread * const self = static_cast<LocalThread *>(parameter);

    if (self->name_ != nullptr) {
        uint64_t threadHandle;
#ifndef WIN32
        threadHandle = pthread_self();
#else
        threadHandle = mmGetTid();
#endif
        if (mmSetThreadName(RtPtrToPtr<mmThread *>(&threadHandle), self->name_) != EN_OK) {
            RT_LOG_CALL_MSG(ERR_MODULE_SYSTEM, "mmSetThreadName failed, setname=%s!", self->name_);
        }
    }

    self->runnable_->Run(self->param_);
    return nullptr;
}

LocalThread::LocalThread(const char_t * const thdName, ThreadRunnable * const thdRunnable, void * const thdParam)
    : Thread(), name_(thdName), runnable_(thdRunnable), param_(thdParam)
{
}

LocalThread::~LocalThread()
{
    name_ = nullptr;
    runnable_ = nullptr;
    param_ = nullptr;
    userBlock_.procFunc = nullptr;
    userBlock_.pulArg = nullptr;
}

static void GetThreadStackSize(mmThreadAttr& threadAttr)
{
    DevProperties  prop;
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    const rtError_t error = GET_DEV_PROPERTIES(chipType, prop);
    if (error == RT_ERROR_NONE) {
        if (prop.pthreadStackSize == 0U) {
            threadAttr.stackFlag = 0; // Use library or system default stack size
            return;
        }

        threadAttr.stackFlag = 1;
        threadAttr.stackSize = prop.pthreadStackSize;
    }
    return;
}

int32_t LocalThread::Start()
{
    userBlock_.procFunc = &ThreadProc;
    userBlock_.pulArg = this;
    mmThreadAttr threadAttr = {};
    threadAttr.stackFlag = 1;
    threadAttr.stackSize = PTHREAD_STACK_SIZE;
    GetThreadStackSize(threadAttr);
    int32_t error = EN_OK;

    for (uint32_t i = 0U; i < PTHREAD_STACK_SIZE_EXT_MAX_TIME; i++) {
        error = mmCreateTaskWithThreadAttr(&interThread_, &userBlock_, &threadAttr);
        RT_LOG(RT_LOG_INFO, "mmCreateTaskWithThreadAttr, retCode=%d, name_=%s, i=%u",
            error, name_, i);
        if (error == EN_OK) {
            const Runtime * const runtime = Runtime::Instance();
            const bool atexitFlag = runtime->GetThreadGuard()->GetThreadAtexitFlag();
            const std::string threadName = std::string(name_);
            threadHandle_ = static_cast<uint64_t>(interThread_);
            runtime->GetThreadGuard()->SetThreadTid(interThread_, threadName);
            if (atexitFlag == false) {
                (void)atexit(&ThreadGuard::ThreadExit);
                runtime->GetThreadGuard()->SetThreadAtexitFlag(true);
            }
            return EN_OK;
        }
        threadAttr.stackSize += PTHREAD_STACK_SIZE;
    }

    RT_LOG_CALL_MSG(ERR_MODULE_SYSTEM, "mmCreateTaskWithThreadAttr failed, stackSize=%u, retCode=%d!",
        threadAttr.stackSize, error);
    return error;
}

bool LocalThread::IsAlive()
{
#ifdef WIN32
    int32_t status = 0;
    bool ret = GetExitCodeThread(interThread_, (LPDWORD)&status);
    if (!ret) {
        RT_LOG(RT_LOG_INFO, "GetExitCodeThread ret=%d, lastError=%d, status=%d", ret, GetLastError(), status);
        return false;
    }
    if (status == STILL_ACTIVE) {
        RT_LOG(RT_LOG_INFO, "GetExitCodeThread ret=%d, status=%d", ret, status);
        return true;
    }
    return false;
#endif
    return true;
}

void LocalThread::Join()
{
    const Runtime * const runtime = Runtime::Instance();
    const bool interThreadExist = runtime->GetThreadGuard()->FindThreadTid(interThread_);
    if (interThreadExist == false) {
        RT_LOG(RT_LOG_WARNING, "mmJoinTask failed, thread=%lu does not exist!", interThread_);
        return ;
    }

    const int32_t error = mmJoinTask(&interThread_);
    if (error != EN_OK) {
        RT_LOG_CALL_MSG(ERR_MODULE_SYSTEM, "mmJoinTask failed, retCode=%d!", error);
    }

    (void)runtime->GetThreadGuard()->DelThreadTid(interThread_);
}

LocalNotifier::LocalNotifier() : Notifier()
{
    (void)mmCondLockInit(&mutex_);
    (void)mmCondInit(&cond_);
}

LocalNotifier::~LocalNotifier()
{
    (void)mmCondDestroy(&cond_);
    (void)mmCondLockDestroy(&mutex_);
}

rtError_t LocalNotifier::Wait(int32_t timeout)
{
    rtError_t error = RT_ERROR_NONE;
    (void)mmCondLock(&mutex_);
    if (trigerd_) {
        goto FINISH;
    }
    if (timeout < 0) {
        (void)mmCondWait(&cond_, &mutex_);
    } else {
        const int32_t ret = mmCondTimedWait(&cond_, &mutex_, static_cast<uint32_t>(timeout));
        if (ret == EN_TIMEOUT) {
            error = RT_ERROR_REPORT_TIMEOUT;
        }
    }
FINISH:
    (void)mmCondUnLock(&mutex_);
    return error;
}

rtError_t LocalNotifier::Triger()
{
    (void)mmCondLock(&mutex_);
    trigerd_ = true;
    (void)mmCondNotifyAll(&cond_);
    (void)mmCondUnLock(&mutex_);
    return RT_ERROR_NONE;
}

rtError_t LocalNotifier::Reset()
{
    (void)mmCondLock(&mutex_);
    trigerd_ = false;
    (void)mmCondUnLock(&mutex_);
    return RT_ERROR_NONE;
}

uint32_t PidTidFetcher::GetCurrentPid(void)
{
    return static_cast<uint32_t>(mmGetPid());
}

uint32_t PidTidFetcher::GetCurrentTid(void)
{
    return static_cast<uint32_t>(mmGetTid());
}

uint64_t PidTidFetcher::GetCurrentUserTid(void)
{
    uint64_t threadId;
#ifndef WIN32
    threadId = pthread_self();
#else
    threadId = mmGetTid();
#endif
    return threadId;
}

Thread *OsalFactory::CreateThread(const char_t * const name, ThreadRunnable * const runnable, void * const param)
{
    RT_LOG(RT_LOG_INFO, "Runtime_alloc_size %zu", sizeof(LocalThread));
    return new (std::nothrow) LocalThread(name, runnable, param);
}

Notifier *OsalFactory::CreateNotifier()
{
    RT_LOG(RT_LOG_INFO, "Runtime_alloc_size %zu", sizeof(LocalNotifier));
    return new (std::nothrow) LocalNotifier();
}

void ThreadGuard::ThreadExit()
{
    RT_LOG(RT_LOG_INFO, "ThreadExit start.");
    const Runtime * const interRuntime = Runtime::Instance();
    if (interRuntime == nullptr) {
        RT_LOG(RT_LOG_WARNING, "Runtime::Instance does not exist.");
        return ;
    }

    GlobalStateManager::GetInstance().ForceUnlocked();

    interRuntime->GetThreadGuard()->SetMonitorStatus(false);
    auto allThreadTid = interRuntime->GetThreadGuard()->GetAllThreadTid();
    for (auto itr : allThreadTid) {
        if ((itr.second == "MONITOR_0") || (itr.second == "MONITOR_1") || (itr.second == "THREAD_CALLBACK")) {
            const int32_t error = mmJoinTask(&itr.first);
            if (error != EN_OK) {
                RT_LOG(RT_LOG_WARNING, "Thread_tid=%lu mmJoinTask failed, retCode=%d!", itr.first, error);
            }
            interRuntime->GetThreadGuard()->DelThreadTid(itr.first);
        }
    }

    RT_LOG_FLUSH();
    return;
}

void ThreadGuard::SetThreadTid(const mmThread inTid, const std::string &threadName)
{
    std::unique_lock<std::mutex> lock(mutex_);
    threadTid_[inTid] = threadName;
}

bool ThreadGuard::DelThreadTid(const mmThread inTid)
{
    std::unique_lock<std::mutex> lock(mutex_);
    if (threadTid_.find(inTid) != threadTid_.end()) {
        threadTid_.erase(inTid);
        return true;
    }
    return false;
}

bool ThreadGuard::FindThreadTid(const mmThread inTid)
{
    std::unique_lock<std::mutex> lock(mutex_);
    if (threadTid_.find(inTid) != threadTid_.end()) {
        return true;
    }
    return false;
}

std::vector<std::pair<mmThread, std::string>> ThreadGuard::GetAllThreadTid()
{
    std::unique_lock<std::mutex> lock(mutex_);
    std::vector<std::pair<mmThread, std::string>> res;
    for (auto itr : threadTid_) {
        res.push_back(std::make_pair(itr.first, itr.second));
    }
    return res;
}

void ThreadGuard::SetThreadAtexitFlag(const bool inFlag)
{
    threadAtexitFlag_.Set(inFlag);
}

bool ThreadGuard::GetThreadAtexitFlag() const
{
    return threadAtexitFlag_.Value();
}

void ThreadGuard::SetMonitorStatus(const bool monitorStatus)
{
    monitorStatus_.Set(monitorStatus);
}

bool ThreadGuard::GetMonitorStatus() const
{
    return monitorStatus_.Value();
}
}
}