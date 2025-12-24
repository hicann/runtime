/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mmpa_api.h"

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif /* __cpluscplus */
#endif /* __cpluscplus */

const INT32 MMPA_MAX_WAIT_TIME = 100;
const INT32 MMPA_MIN_WAIT_TIME = 0;

#define MMPA_FREE(var) \
    do { \
        if (var != nullptr) { \
            free(var); \
            var = nullptr; \
        } \
    } \
    while (0)

#define MMPA_CLOSE_FILE_HANDLE(var) \
    do { \
        if (var != nullptr) { \
            (void)CloseHandle(var); \
            var = nullptr; \
        } \
    } \
    while (0)

/*
 * 描述:内部使用
 */
static INT32 CheckSizetAddOverflow(size_t a, size_t b)
{
    if ((b > 0) && (a > (SIZE_MAX - b))) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:根据创建线程时候的函数名和参数执行相关功能,内部使用
 * 参数:pstArg --包含函数名和参数的结构体指针
 * 返回值:执行成功或者失败都返回EN_OK
 */
static DWORD WINAPI LocalThreadProc(LPVOID pstArg)
{
    mmUserBlock_t *pstTemp = reinterpret_cast<mmUserBlock_t *>(pstArg);
    pstTemp->procFunc(pstTemp->pulArg);
    return EN_OK;
}

/*
 * 描述:用默认的属性创建线程
 * 参数:threadHandle -- pthread_t类型的实例
 *       funcBlock --包含函数名和参数的结构体指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCreateTask(mmThread *threadHandle, mmUserBlock_t *funcBlock)
{
    if ((threadHandle == nullptr) || (funcBlock  == nullptr) || (funcBlock->procFunc  == nullptr)) {
        return EN_INVALID_PARAM;
    }

    DWORD threadId;
    *threadHandle = CreateThread(nullptr, MMPA_ZERO, LocalThreadProc, (LPVOID)funcBlock, MMPA_ZERO, &threadId);
    if (*threadHandle == nullptr) {
        return EN_ERROR;
    }
    (void)WaitForSingleObject(*threadHandle, MMPA_MAX_WAIT_TIME); // 等待时间为100ms，确保funcBlock->procFunc线程体被执行
    return EN_OK;
}

/*
 * 描述:该函数等待线程结束并返回线程退出值"value_ptr"
 *       如果线程成功结束会detach线程
 *       注意:detached的线程不能用该函数或取消
 * 参数:threadHandle-- pthread_t类型的实例
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmJoinTask(mmThread *threadHandle)
{
    if (threadHandle == nullptr) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = EN_OK;
    DWORD dwWaitResult = WaitForSingleObject(*threadHandle, INFINITE);
    if (dwWaitResult == WAIT_ABANDONED) {
        ret = EN_ERROR;
    } else if (dwWaitResult == WAIT_TIMEOUT) {
        ret = EN_ERROR;
    } else if (dwWaitResult == WAIT_FAILED) {
        ret = EN_ERROR;
    }
    return ret;
}

/*
 * 描述:用默认属性初始化锁
 * 参数:mutex --指向mmMutex_t 指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmMutexInit(mmMutex_t *mutex)
{
    if (mutex == nullptr) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = EN_OK;
    HANDLE handleMutex = CreateMutex(nullptr, FALSE, nullptr);
    if (handleMutex == nullptr) {
        ret = EN_ERROR;
    } else {
        *mutex = handleMutex;
    }
    return ret;
}

/*
 * 描述:把mutex锁住
 * 参数:mutex --指向mmMutex_t 指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmMutexLock(mmMutex_t *mutex)
{
    if (mutex == nullptr) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = EN_OK;
    DWORD dwWaitResult = WaitForSingleObject(*mutex, INFINITE);
    if (dwWaitResult == WAIT_ABANDONED) {
        ret = EN_ERROR;
    } else if (dwWaitResult == WAIT_FAILED) {
        ret = EN_ERROR;
    }
    return ret;
}

/*
 * 描述:把mutex锁住，非阻塞
 * 参数: mutex --指向mmMutex_t 指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmMutexTryLock(mmMutex_t *mutex)
{
    if (mutex == nullptr) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = EN_OK;
    DWORD dwWaitResult = WaitForSingleObject(*mutex, MMPA_MIN_WAIT_TIME);
    if (dwWaitResult == WAIT_ABANDONED || dwWaitResult == WAIT_FAILED) {
        ret = EN_ERROR;
    }
    return ret;
}

/*
 * 描述:把mutex锁解锁
 * 参数:mutex--指向mmMutex_t 指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmMutexUnLock(mmMutex_t *mutex)
{
    if (mutex == nullptr) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = EN_OK;
    BOOL releaseMutex = ReleaseMutex(*mutex);
    if (!releaseMutex) {
        ret = EN_ERROR;
    }
    return ret;
}

/*
 * 描述:把mutex锁删除
 * 参数:mutex--指向mmMutex_t 指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmMutexDestroy(mmMutex_t *mutex)
{
    if (mutex == nullptr) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = EN_OK;
    BOOL cHandle = CloseHandle(*mutex);
    if (!cHandle) {
        ret = EN_ERROR;
    }
    return ret;
}

/*
 * 描述:初始化条件变量，条件变量属性为nullptr
 * 输入 :cond -- 指向mmCond的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCondInit(mmCond *cond)
{
    if (cond == nullptr) {
        return EN_INVALID_PARAM;
    }

    InitializeConditionVariable(cond);
    return EN_OK;
}

/*
 * 描述:用默认属性初始化锁
 * 参数:cond -- 指向mmMutexFC指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCondLockInit(mmMutexFC *mutex)
{
    if (mutex == nullptr) {
        return EN_INVALID_PARAM;
    }

    InitializeCriticalSection(mutex);
    return EN_OK;
}

/*
 * 描述:把mutex锁住
 * 参数:cond--指向mmMutexFC 指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCondLock(mmMutexFC *mutex)
{
    if (mutex == nullptr) {
        return EN_INVALID_PARAM;
    }

    EnterCriticalSection(mutex);
    return EN_OK;
}

/*
 * 描述:把mutex解锁
 * 参数:cond --指向mmMutexFC 指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCondUnLock(mmMutexFC *mutex)
{
    if (mutex == nullptr) {
        return EN_INVALID_PARAM;
    }

    LeaveCriticalSection(mutex);
    return EN_OK;
}

/*
 * 描述:销毁mmMutexFC
 * 参数:cond--指向mmMutexFC 指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCondLockDestroy(mmMutexFC *mutex)
{
    if (mutex == nullptr) {
        return EN_INVALID_PARAM;
    }

    DeleteCriticalSection(mutex);
    return EN_OK;
}

/*
 * 描述:用默认属性初始化读写锁
 * 参数: rwLock --指向mmRWLock_t的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmRWLockInit(mmRWLock_t *rwLock)
{
    if (rwLock == nullptr) {
        return EN_INVALID_PARAM;
    }

    InitializeSRWLock(rwLock);
    return EN_OK;
}

/*
 * 描述:把rwlock锁住,应用于读锁
 * 参数: rwLock --指向mmRWLock_t的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmRWLockRDLock(mmRWLock_t *rwLock)
{
    if (rwLock == NULL) {
        return EN_INVALID_PARAM;
    }

    AcquireSRWLockShared(rwLock);
    return EN_OK;
}

/*
 * 描述:把rwlock锁住,应用于读锁（非阻塞）
 * 参数: rwLock --指向mmRWLock_t的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmRWLockTryRDLock(mmRWLock_t *rwLock)
{
    if (rwLock == NULL) {
        return EN_INVALID_PARAM;
    }

    BOOLEAN ret = TryAcquireSRWLockShared(rwLock);
    if (!ret) {
        return EN_ERROR;
    }

    return EN_OK;
}

/*
 * 描述:把rwlock锁住,应用于写锁（阻塞）
 * 参数: rwLock --指向mmRWLock_t的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmRWLockWRLock(mmRWLock_t *rwLock)
{
    if (rwLock == NULL) {
        return EN_INVALID_PARAM;
    }

    AcquireSRWLockExclusive(rwLock);
    return EN_OK;
}

/*
 * 描述:把rwlock锁住,应用于写锁（非阻塞）
 * 参数: rwLock --指向mmRWLock_t的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmRWLockTryWRLock(mmRWLock_t *rwLock)
{
    if (rwLock == NULL) {
        return EN_INVALID_PARAM;
    }

    BOOLEAN ret = TryAcquireSRWLockExclusive(rwLock);
    if (!ret) {
        return EN_ERROR;
    }

    return EN_OK;
}

/*
 * 描述:把rwlock解锁,应用于读锁
 * 参数: rwLock --指向mmRWLock_t的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARA
 */
INT32 mmRDLockUnLock(mmRWLock_t *rwLock)
{
    if (rwLock == NULL) {
        return EN_INVALID_PARAM;
    }

    ReleaseSRWLockShared(rwLock);
    return EN_OK;
}

/*
 * 描述:把rwlock解锁,应用于写锁
 * 参数: rwLock --指向mmRWLock_t的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARA
 */
INT32 mmWRLockUnLock(mmRWLock_t *rwLock)
{
    if (rwLock == NULL) {
        return EN_INVALID_PARAM;
    }

    ReleaseSRWLockExclusive(rwLock);
    return EN_OK;
}

/*
 * 描述:把rwlock删除，该接口windows为空实现，系统回自动清理
 * 参数: rwLock --指向mmRWLock_t的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmRWLockDestroy(mmRWLock_t *rwLock)
{
    return EN_OK;
}

/*
 * 描述:用于阻塞当前线程
 * 参数:cond --  mmCond指针
 *       mutex -- mmMutexFC指针, 条件变量
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCondWait(mmCond *cond, mmMutexFC *mutex)
{
    if ((cond == nullptr) || (mutex == nullptr)) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = EN_OK;
    BOOL sCondition = SleepConditionVariableCS(cond, mutex, INFINITE);
    if (!sCondition) {
        ret = EN_ERROR;
    }
    return ret;
}

/*
 * 描述:用于阻塞当前线程一定时间，由外部指定时间
 * 参数:cond --  mmCond指针
 *       mutex -- mmMutexFC指针, 条件变量
 *       mmMilliSeconds -- 阻塞时间
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR、超时返回EN_TIMEOUT, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCondTimedWait(mmCond *cond, mmMutexFC *mutex, UINT32 milliSecond)
{
    if ((cond == nullptr) || (mutex == nullptr)) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = EN_OK;
    BOOL sleepCondition = SleepConditionVariableCS(cond, mutex, (DWORD)milliSecond);
    if (!sleepCondition) {
        if (GetLastError() == WAIT_TIMEOUT) {
            return EN_TIMEOUT;
        }
        ret = EN_ERROR;
    }
    return ret;
}

/*
 * 描述:唤醒mmCondWait阻塞的线程, 只给一个线程发信号
 * 参数:cond -- mmCond指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCondNotify(mmCond *cond)
{
    if (cond == nullptr) {
        return EN_INVALID_PARAM;
    }

    WakeConditionVariable(cond);
    return EN_OK;
}

/*
 * 描述:唤醒mmCondWait阻塞的线程, 可以给多个线程发信号
 * 参数:cond -- mmCond指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCondNotifyAll(mmCond *cond)
{
    if (cond == nullptr) {
        return EN_INVALID_PARAM;
    }

    WakeAllConditionVariable(cond);
    return EN_OK;
}

/*
 * 描述:销毁cond指向的条件变量
 * 参数:cond -- mmCond指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32  mmCondDestroy(mmCond *cond)
{
    if (cond == nullptr) {
        return EN_INVALID_PARAM;
    }

    return EN_OK;
}

/*
 * 描述:用默认的属性创建线程，属性linux下有效
 * 参数:threadHandle -- pthread_t类型的实例
 *       funcBlock --包含函数名和参数的结构体指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCreateTaskWithAttr(mmThread *threadHandle, mmUserBlock_t *funcBlock)
{
    return mmCreateTask(threadHandle, funcBlock);
}

/*
 * 描述:获取指定进程优先级id
 * 参数:pid--进程ID
 * 返回值:执行成功返回优先级id, 执行错误返回MMPA_PROCESS_ERROR, 入参检查错误返回MMPA_PROCESS_ERROR
 */
INT32 mmGetProcessPrio(mmProcess pid)
{
    if (pid == nullptr) {
        return MMPA_PROCESS_ERROR ;
    }

    INT32 priority;
    INT32 ret = GetPriorityClass(pid);
    if (ret == MMPA_ZERO) {
        return MMPA_PROCESS_ERROR;
    }
    switch (ret) {
        case REALTIME_PRIORITY_CLASS:   // those three process priority in windows
        case HIGH_PRIORITY_CLASS:       // compare to MMPA_MIN_NI in linux
        case ABOVE_NORMAL_PRIORITY_CLASS:
            priority = MMPA_MIN_NI;
            break;
        case NORMAL_PRIORITY_CLASS:
            priority = MMPA_LOW_NI;
            break;
        case BELOW_NORMAL_PRIORITY_CLASS: // those two process priority in windows
        case IDLE_PRIORITY_CLASS:         // compare to MMPA_MAX_NI in linux
            priority = MMPA_MAX_NI;
            break;
        default:
            priority = MMPA_PROCESS_ERROR;
    }
    return priority;
}

/*
 * 描述:设置进程优先级
 * 参数:pid--进程ID
 *       processPrio:需要设置的优先级值，参数范围取 -20 to 19
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmSetProcessPrio(mmProcess pid, INT32 processPrio)
{
    if (pid == nullptr) {
        return EN_INVALID_PARAM;
    }

    DWORD priority;
    if (processPrio >= MMPA_MIDDLE_NI) {
        priority = BELOW_NORMAL_PRIORITY_CLASS;
    } else if (processPrio < MMPA_MIDDLE_NI && processPrio >= MMPA_LOW_NI) {
        priority = NORMAL_PRIORITY_CLASS;
    } else {
        priority = ABOVE_NORMAL_PRIORITY_CLASS;
    }

    INT32 ret = SetPriorityClass(pid, priority);
    if (ret == MMPA_ZERO) {
        return EN_ERROR;
    } else {
        return EN_OK;
    }
}

/*
 * 描述:获取线程优先级
 * 参数:threadHandle--线程ID
 * 返回值:执行成功返回获取到的优先级, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmGetThreadPrio(mmThread *threadHandle)
{
    if (threadHandle == nullptr) {
        return EN_INVALID_PARAM;
    }

    INT32 priority;
    INT32 ret = GetThreadPriority(*threadHandle);
    if (ret == THREAD_PRIORITY_ERROR_RETURN) {
        return EN_ERROR;
    }
    switch (ret) {
        case THREAD_PRIORITY_TIME_CRITICAL: // those three thread priority in windows
        case THREAD_PRIORITY_HIGHEST:       // compare to  MMPA_MAX_THREAD_PIO in linux
        case THREAD_PRIORITY_ABOVE_NORMAL:
            priority = MMPA_MAX_THREAD_PIO;
            break;
        case THREAD_PRIORITY_NORMAL:
            priority = MMPA_LOW_THREAD_PIO;
            break;
        case THREAD_PRIORITY_BELOW_NORMAL: // those three thread priority in windows
        case THREAD_PRIORITY_LOWEST:       // compare to  MMPA_MIN_THREAD_PIO in linux
        case THREAD_PRIORITY_IDLE:
            priority = MMPA_MIN_THREAD_PIO;
            break;
        default:
            return EN_ERROR;
    }
    return priority;
}

/*
 * 描述:设置线程优先级, Linux默认以SCHED_RR策略设置
 * 参数:threadHandle--线程ID
 *       threadPrio:设置的优先级id，参数范围取1 - 99, 1为最高优先级
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmSetThreadPrio(mmThread *threadHandle, INT32 threadPrio)
{
    if (threadHandle == nullptr) {
        return EN_INVALID_PARAM;
    }

    INT32 priority;
    if (threadPrio <= MMPA_MAX_THREAD_PIO && threadPrio >= MMPA_MIDDLE_THREAD_PIO) {
        priority = THREAD_PRIORITY_ABOVE_NORMAL;
    } else if (threadPrio < MMPA_MIDDLE_THREAD_PIO && threadPrio >= MMPA_LOW_THREAD_PIO) {
        priority = THREAD_PRIORITY_NORMAL;
    } else if (threadPrio < MMPA_LOW_THREAD_PIO && threadPrio >= MMPA_MIN_THREAD_PIO) {
        priority = THREAD_PRIORITY_BELOW_NORMAL;
    } else {
        return EN_INVALID_PARAM;
    }

    INT32 ret = SetThreadPriority(*threadHandle, priority);
    if (ret == MMPA_ZERO) {
        return EN_ERROR;
    } else {
        return EN_OK;
    }
}

/*
 * 描述:创建带分离属性的线程, 不需要mmJoinTask等待线程结束
 * 参数:threadHandle -- pthread_t类型的实例
 *       funcBlock --包含函数名和参数的结构体指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCreateTaskWithDetach(mmThread *threadHandle, mmUserBlock_t *funcBlock)
{
    INT32 ret = EN_OK;
    DWORD threadId;

    if ((threadHandle == nullptr) || (funcBlock == nullptr) || (funcBlock->procFunc == nullptr)) {
        return EN_INVALID_PARAM;
    }

    *threadHandle = CreateThread(nullptr, MMPA_ZERO, LocalThreadProc, (LPVOID)funcBlock, MMPA_ZERO, &threadId);
    (void)CloseHandle(*threadHandle);
    if (*threadHandle == nullptr) {
        ret = EN_ERROR;
    }
    return ret;
}

/*
 * 描述:线程局部变量存储区创建
 * 参数:destructor--清理函数-linux有效
 *      key-线程变量存储区索引
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmTlsCreate(mmThreadKey *key, void(*destructor)(void*))
{
    if (key == nullptr) {
        return EN_INVALID_PARAM;
    }
    DWORD index = TlsAlloc();
    if (index == TLS_OUT_OF_INDEXES) {
        return EN_ERROR;
    }
    *key = index;
    return EN_OK;
}

/*
 * 描述:线程局部变量设置
 * 参数:key--线程变量存储区索引
        value--需要设置的局部变量的值
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmTlsSet(mmThreadKey key, const VOID *value)
{
    if (value == nullptr) {
        return EN_INVALID_PARAM;
    }
    BOOL ret = TlsSetValue(key, (LPVOID)value);
    if (!ret) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:线程局部变量获取
 * 参数:key --线程变量存储区索引
 * 返回值:执行成功返回指向局部存储变量的指针, 执行错误返回nullptr
 */
VOID *mmTlsGet(mmThreadKey key)
{
    return TlsGetValue(key);
}

/*
 * 描述:线程局部变量清除
 * 参数:key--线程变量存储区索引
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR
 */
INT32 mmTlsDelete(mmThreadKey key)
{
    BOOL ret = TlsFree(key);
    if (!ret) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:设置mmCreateTask创建的线程名-线程体外调用
 * 参数:threadHandle--线程ID
 *      name--线程名, name的实际长度必须<MMPA_THREADNAME_SIZE
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmSetThreadName(mmThread *threadHandle, const CHAR *name)
{
    if ((threadHandle == NULL) || (name == NULL)) {
        return EN_INVALID_PARAM;
    }
    PCWSTR threadName = reinterpret_cast<PCWSTR>(const_cast<CHAR *>(name));
    HRESULT ret = SetThreadDescription(*threadHandle, threadName);
    if (FAILED(ret)) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:获取线程名-线程体外调用, 仅在Linux下生效, Windows下不支持为空实现
 * 参数:threadHandle--线程ID
 *      size--存放线程名的缓存长度
 *      name--线程名由用户分配缓存, 缓存长度必须>=MMPA_THREADNAME_SIZE
 * 返回值:windows下默认返回EN_ERROR
 */
INT32 mmGetThreadName(mmThread *threadHandle, CHAR *name, INT32 size)
{
    return EN_ERROR;
}

/*
 * 描述:设置当前执行的线程的线程名-线程体内调用, 仅在Linux下生效, Windows下不支持为空实现
 * 参数:name--需要设置的线程名
 * 返回值:windows下默认返回EN_ERROR
 */
INT32 mmSetCurrentThreadName(const CHAR *name)
{
    return EN_ERROR;
}

/*
 * 描述:获取当前执行的线程的线程名-线程体内调用, 仅在Linux下生效, Windows下不支持为空实现
 * 参数:name--获取到的线程名, 缓存空间由用户分配
 *      size--缓存长度必须>=MMPA_THREADNAME_SIZE
 * 返回值:windows下默认返回EN_ERROR
 */
INT32 mmGetCurrentThreadName(CHAR *name, INT32 size)
{
    return EN_ERROR;
}

/*
 * 描述:内部使用
 */
static INT32 LocalGetArgsAndEnvpLen(const mmArgvEnv *env, size_t *argvLen, size_t *envpLen)
{
    if (env == nullptr) {
        return EN_OK;
    }
    INT32 i = 0;
    for (i = 0; i < env->argvCount; ++i) {
        if (env->argv[i] == nullptr) {
            continue;
        }
        if (CheckSizetAddOverflow(*argvLen, strlen(env->argv[i]) + 1) != EN_OK) {
            return EN_ERROR;
        }
        *argvLen += strlen(env->argv[i]) + 1; // an extra space is required
    }
    if (env->argvCount > 0) {
        *argvLen += 1;
    }
    // envp要求格式 name1=value1\0name2=value2\0...namex=valuex\0\0 双\0结尾
    for (i = 0; i < env->envpCount; ++i) {
        if (env->envp[i] == nullptr) {
            continue;
        }
        if (CheckSizetAddOverflow(*envpLen, strlen(env->envp[i]) + 1) != EN_OK) {
            return EN_ERROR;
        }
        *envpLen += strlen(env->envp[i]) + 1;
    }
    if (env->envpCount > 0) {
        *envpLen += 1;
    }
    return EN_OK;
}

/*
 * 描述:内部使用，将传入的argvs和envps字符串数组组合成一个argv和envp
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_INVALID_PARAM
 */
INT32 LocalGetArgsAndEnvp(CHAR *argv, INT32 argvLen, CHAR *envp, INT32 envpLen, const mmArgvEnv *env)
{
    INT32 i = 0;
    INT32 ret = 0;
    CHAR *destEnvp = envp;
    // 将argv和envp字符串数组列表拼接成一个字符串命令
    if (env == nullptr) {
        return EN_OK;
    }

    // envp要求格式 name1=value1\0name2=value2\0...namex=valuex\0\0 双\0结尾
    if (destEnvp != nullptr) {
        for (i = 0; i < env->envpCount; ++i) {
            if (env->envp[i] == nullptr) {
                continue;
            }
            size_t len = strlen(env->envp[i]);
            ret = strncpy_s(destEnvp, envpLen, env->envp[i], len + 1);
            if (ret != MMPA_ZERO) {
                return EN_INVALID_PARAM;
            }
            destEnvp += len + 1;
            envpLen -= len + 1;
        }
        *destEnvp = '\0';
    }

    if (argv == nullptr) {
        return EN_OK;
    }

    for (i = 0; i < env->argvCount; ++i) {
        if (env->argv[i] == nullptr) {
            continue;
        }
        ret = strcat_s(argv, argvLen, env->argv[i]);
        if (ret != MMPA_ZERO) {
            return EN_INVALID_PARAM;
        }
        if (i < env->argvCount - 1) {
            ret = strcat_s(argv, argvLen, " ");
            if (ret != MMPA_ZERO) {
                return EN_INVALID_PARAM;
            }
        }
    }
    return EN_OK;
}

/*
 * 描述:新创建进程执行可执行程序或者指定命令或者重定向输出文件
 * 参数:fileName--需要执行的可执行程序所在路径名
 *      env--保存子进程的状态信息
 *      stdoutRedirectFile--重定向文件路径, 若不为空, 则启用重定向功能
 *      id--创建的子进程ID号
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCreateProcess(const CHAR *fileName, const mmArgvEnv *env, const CHAR *stdoutRedirectFile, mmProcess *id)
{
    STARTUPINFO si;
    PROCESS_INFORMATION pi;
    SecureZeroMemory(&si, sizeof(si));
    SecureZeroMemory(&pi, sizeof(pi));
    BOOL bInheritHandles = FALSE;
    SECURITY_ATTRIBUTES sa = {sizeof(SECURITY_ATTRIBUTES), nullptr, TRUE};
    HANDLE cmdOutput = nullptr;
    if (stdoutRedirectFile != nullptr) {
        cmdOutput = CreateFile(stdoutRedirectFile,
                               GENERIC_WRITE, FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
                               &sa, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, nullptr);
        if (cmdOutput == INVALID_HANDLE_VALUE) {
            return EN_ERROR;
        }
        si.hStdOutput = cmdOutput;
        si.dwFlags = STARTF_USESTDHANDLES;
        bInheritHandles = true;
    }

    size_t argvLen = 0;
    size_t envpLen = 0;
    if (LocalGetArgsAndEnvpLen(env, &argvLen, &envpLen) != EN_OK) {
        MMPA_CLOSE_FILE_HANDLE(cmdOutput);
        return EN_ERROR;
    }
    CHAR *command = nullptr;
    CHAR *environment = nullptr;
    if (argvLen > 0) {
        command = reinterpret_cast<CHAR *>(malloc(argvLen));
        if (command == nullptr) {
            MMPA_CLOSE_FILE_HANDLE(cmdOutput);
            return EN_ERROR;
        }
        SecureZeroMemory(command, argvLen);
    }

    if (envpLen > 0) {
        environment = reinterpret_cast<CHAR *>(malloc(envpLen));
        if (environment == nullptr) {
            MMPA_CLOSE_FILE_HANDLE(cmdOutput);
            MMPA_FREE(command);
            return EN_ERROR;
        }
        SecureZeroMemory(environment, envpLen);
    }

    INT32 ret = LocalGetArgsAndEnvp(command, argvLen, environment, envpLen, env);
    if (ret != MMPA_ZERO) {
        MMPA_CLOSE_FILE_HANDLE(cmdOutput);
        MMPA_FREE(command);
        MMPA_FREE(environment);
        return ret;
    }
    BOOL bRet = CreateProcess(fileName, (LPTSTR)command, nullptr, nullptr,
    bInheritHandles, 0, (LPVOID)environment, nullptr, &si, &pi);
    MMPA_CLOSE_FILE_HANDLE(cmdOutput);
    MMPA_FREE(command);
    MMPA_FREE(environment);
    if (bRet) { // 创建成功
        *id = pi.hProcess;
        return EN_OK;
    } else {
        return EN_ERROR;
    }
}

/*
 * 描述:创建带属性的线程, 支持调度策略、优先级、分离属性设置,除了分离属性和线程栈大小,其他只在Linux下有效
 * 参数: threadHandle -- pthread_t类型的实例
 *       funcBlock --包含函数名和参数的结构体指针
 *       threadAttr -- 包含需要设置的线程属性类别和值
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCreateTaskWithThreadAttr(mmThread *threadHandle,
                                 const mmUserBlock_t *funcBlock,
                                 const mmThreadAttr *threadAttr)

{
    INT32 ret = EN_OK;
    DWORD threadId;

    if ((threadHandle == nullptr) || (funcBlock == nullptr) || (funcBlock->procFunc == nullptr)
        || (threadAttr == nullptr)) {
        return EN_INVALID_PARAM;
    }
    if (threadAttr->stackFlag) {
        if (threadAttr->stackSize < MMPA_THREAD_MIN_STACK_SIZE) {
            return EN_INVALID_PARAM;
        }
        *threadHandle = CreateThread(nullptr, threadAttr->stackSize,
                                     LocalThreadProc, (LPVOID)funcBlock, MMPA_ZERO, &threadId);
    } else {
        *threadHandle = CreateThread(nullptr, MMPA_ZERO, LocalThreadProc, (LPVOID)funcBlock, MMPA_ZERO, &threadId);
    }
    (void)WaitForSingleObject(*threadHandle, 100); // 等待时间为100ms，确保funcBlock->procFunc线程体被执行
    if (threadAttr->detachFlag == TRUE) {
        (void)CloseHandle(*threadHandle);
    }

    if (*threadHandle == nullptr) {
        ret = EN_ERROR;
    }
    return ret;
}

#ifdef __cplusplus
#if __cplusplus
}
#endif /* __cpluscplus */
#endif /* __cpluscplus */

