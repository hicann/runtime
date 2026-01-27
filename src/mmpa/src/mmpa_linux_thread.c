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
#if    __cplusplus
extern "C" {
#endif /* __cpluscplus */
#endif

#define MMPA_PTHEAD_SECOND_TO_MSEC                     1000
#define MMPA_PTHEAD_MSEC_TO_USEC                       1000
#define MMPA_PTHEAD_MSEC_TO_NSEC                       1000000
#define MMPA_PTHEAD_SECOND_TO_NSEC                     1000000000

/*
 * 描述:用默认的属性创建线程
 * 参数: threadHandle -- pthread_t类型的实例
 *       funcBlock --包含函数名和参数的结构体指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCreateTask(mmThread *threadHandle, mmUserBlock_t *funcBlock)
{
    if ((threadHandle == NULL) || (funcBlock == NULL) || (funcBlock->procFunc == NULL)) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = pthread_create(threadHandle, NULL, funcBlock->procFunc, funcBlock->pulArg);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }
    return ret;
}

/*
 * 描述:该函数等待线程结束并返回线程退出值"value_ptr"
 *       如果线程成功结束会detach线程
 *       注意:detached的线程不能用该函数或取消
 * 参数: threadHandle-- pthread_t类型的实例
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmJoinTask(mmThread *threadHandle)
{
    if (threadHandle == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = pthread_join(*threadHandle, NULL);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }
    return ret;
}

/*
 * 描述:用默认属性初始化锁
 * 参数: mutex --指向mmMutex_t 指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmMutexInit(mmMutex_t *mutex)
{
    if (mutex == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = pthread_mutex_init(mutex, NULL);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }

    return ret;
}

/*
 * 描述:把mutex锁住
 * 参数: mutex --指向mmMutex_t 指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
/*lint -e454*/
INT32 mmMutexLock(mmMutex_t *mutex)
{
    if (mutex == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = pthread_mutex_lock(mutex);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }
    return ret;
}

/*
 * 描述:把mutex锁住
 * 参数: mutex --指向mmMutex_t 指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmMutexTryLock(mmMutex_t *mutex)
{
    if (mutex == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = pthread_mutex_trylock(mutex);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }
    return ret;
}

/*lint +e454*/
/*
 * 描述:把mutex锁解锁
 * 参数: mutex--指向mmMutex_t 指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
/*lint -e455*/
INT32 mmMutexUnLock(mmMutex_t *mutex)
{
    if (mutex == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = pthread_mutex_unlock(mutex);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }
    return ret;
}

/*lint +e455*/
/*
 * 描述:把mutex锁删除
 * 参数: mutex--指向mmMutex_t 指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmMutexDestroy(mmMutex_t *mutex)
{
    if (mutex == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = pthread_mutex_destroy(mutex);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }
    return ret;
}

/*
 * 描述:初始化条件变量，条件变量属性为NULL
 * 参数: cond -- 指向mmCond的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCondInit(mmCond *cond)
{
    if (cond == NULL) {
        return EN_INVALID_PARAM;
    }
    pthread_condattr_t condAttr;
    // 初始化cond 属性
    INT32 ret = pthread_condattr_init(&condAttr);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    // 为了使 mmCondTimedWait 使用开机时间而不是系统当前时间
    ret = pthread_condattr_setclock(&condAttr, CLOCK_MONOTONIC);
    if (ret != EN_OK) {
        (VOID)pthread_condattr_destroy(&condAttr);
        return EN_ERROR;
    }

    // 使用带属性的初始化
    ret = pthread_cond_init(cond, &condAttr);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }
    (VOID)pthread_condattr_destroy(&condAttr);

    return ret;
}

/*
 * 描述:用默认属性初始化锁
 * 参数: mutex -- 指向mmMutexFC指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCondLockInit(mmMutexFC *mutex)
{
    return mmMutexInit(mutex);
}

/*
 * 描述:把mutex锁住
 * 参数: mutex--指向mmMutexFC 指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCondLock(mmMutexFC *mutex)
{
    return mmMutexLock(mutex);
}

/*
 * 描述:把mutex解锁
 * 参数: mutex --指向mmMutexFC 指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCondUnLock(mmMutexFC *mutex)
{
    return mmMutexUnLock(mutex);
}

/*
 * 描述:销毁mmMutexFC
 * 参数: mutex--指向mmMutexFC 指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCondLockDestroy(mmMutexFC *mutex)
{
    return mmMutexDestroy(mutex);
}

/*
 * 描述:用默认属性初始化读写锁
 * 参数: rwLock --指向mmRWLock_t的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmRWLockInit(mmRWLock_t *rwLock)
{
    if (rwLock == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = pthread_rwlock_init(rwLock, NULL);
    if (ret != MMPA_ZERO) {
        return EN_ERROR;
    }

    return EN_OK;
}

/*
 * 描述:把rwlock锁住,应用于读锁（阻塞）
 * 参数: rwLock --指向mmRWLock_t的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmRWLockRDLock(mmRWLock_t *rwLock)
{
    if (rwLock == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = pthread_rwlock_rdlock(rwLock);
    if (ret != MMPA_ZERO) {
        return EN_ERROR;
    }

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

    INT32 ret = pthread_rwlock_tryrdlock(rwLock);
    if (ret != MMPA_ZERO) {
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

    INT32 ret = pthread_rwlock_wrlock(rwLock);
    if (ret != MMPA_ZERO) {
        return EN_ERROR;
    }

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

    INT32 ret = pthread_rwlock_trywrlock(rwLock);
    if (ret != MMPA_ZERO) {
        return EN_ERROR;
    }

    return EN_OK;
}

/*
 * 描述:把rwlock解锁,应用于读锁
 * 参数: rwLock --指向mmRWLock_t的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmRDLockUnLock(mmRWLock_t *rwLock)
{
    if (rwLock == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = pthread_rwlock_unlock(rwLock);
    if (ret != MMPA_ZERO) {
        return EN_ERROR;
    }

    return EN_OK;
}

/*
 * 描述:把rwlock解锁,应用于写锁
 * 参数: rwLock --指向mmRWLock_t的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmWRLockUnLock(mmRWLock_t *rwLock)
{
    if (rwLock == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = pthread_rwlock_unlock(rwLock);
    if (ret != MMPA_ZERO) {
        return EN_ERROR;
    }

    return EN_OK;
}

/*
 * 描述:把rwlock删除，该接口windows为空实现，系统回自动清理
 * 参数: rwLock --指向mmRWLock_t的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmRWLockDestroy(mmRWLock_t *rwLock)
{
    if (rwLock == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = pthread_rwlock_destroy(rwLock);
    if (ret != MMPA_ZERO) {
        return EN_ERROR;
    }

    return EN_OK;
}

/*
 * 描述:用于阻塞当前线程
 * 参数: cond --  mmCond指针
 *       mutex -- mmMutexFC指针, 条件变量
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCondWait(mmCond *cond, mmMutexFC *mutex)
{
    if ((cond == NULL) || (mutex == NULL)) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = pthread_cond_wait(cond, mutex);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }
    return ret;
}

/*
 * 描述:用于阻塞当前线程一定时间，由外部指定时间
 * 参数: cond --  mmCond指针
 *       mutex -- mmMutexFC指针, 条件变量
 *       mmMilliSeconds -- 阻塞时间
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR、超时返回EN_TIMEOUT, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCondTimedWait(mmCond *cond, mmMutexFC *mutex, UINT32 milliSecond)
{
    if ((cond == NULL) || (mutex == NULL)) {
        return EN_INVALID_PARAM;
    }

    struct timespec absoluteTime;
    (VOID)memset_s(&absoluteTime, sizeof(absoluteTime), 0, sizeof(absoluteTime)); /* unsafe_function_ignore: memset */

    // 系统开机至今的时间, 软件无法修改
    INT32 ret = clock_gettime(CLOCK_MONOTONIC, &absoluteTime);
    if (ret != EN_OK) {
        return EN_ERROR;
    }

    absoluteTime.tv_sec = absoluteTime.tv_sec + ((LONG)milliSecond / MMPA_PTHEAD_SECOND_TO_MSEC);
    absoluteTime.tv_nsec = absoluteTime.tv_nsec +
                           (((LONG)milliSecond % MMPA_PTHEAD_SECOND_TO_MSEC) * MMPA_PTHEAD_MSEC_TO_NSEC);

    // 判断是否进位
    if (absoluteTime.tv_nsec > MMPA_PTHEAD_SECOND_TO_NSEC) {
        ++absoluteTime.tv_sec;
        absoluteTime.tv_nsec = absoluteTime.tv_nsec % MMPA_PTHEAD_SECOND_TO_NSEC;
    }

    ret = pthread_cond_timedwait(cond, mutex, &absoluteTime); // 睡眠相对时间
    if (ret != EN_OK) {
        if (ret == ETIMEDOUT) {
            return EN_TIMEOUT;
        }
        ret = EN_ERROR;
    }
    return ret;
}

/*
 * 描述:唤醒mmCondWait阻塞的线程, 只给一个线程发信号
 * 参数: cond -- mmCond指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCondNotify(mmCond *cond)
{
    if (cond == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = pthread_cond_signal(cond);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }
    return ret;
}

/*
 * 描述:唤醒mmCondWait阻塞的线程, 可以给多个线程发信号
 * 参数: cond -- mmCond指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCondNotifyAll(mmCond *cond)
{
    if (cond == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = pthread_cond_broadcast(cond);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }
    return ret;
}

/*
 * 描述:销毁cond指向的条件变量
 * 参数: cond -- mmCond指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCondDestroy(mmCond *cond)
{
    if (cond == NULL) {
        return EN_INVALID_PARAM;
    }

    INT32 ret = pthread_cond_destroy(cond);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }
    return ret;
}

/*
 * 描述:创建带默认调度策略属性和优先级属性的线程, 属性只在Linux下有效, 默认调度策略SCHED_FIFO 优先级1
 * 参数: threadHandle -- pthread_t类型的实例
 *       funcBlock --包含函数名和参数的结构体指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCreateTaskWithAttr(mmThread *threadHandle, mmUserBlock_t *funcBlock)
{
    if ((threadHandle == NULL) || (funcBlock == NULL) ||
        (funcBlock->procFunc == NULL)) {
        return EN_INVALID_PARAM;
    }
    UINT uid = getuid();
    // 非root用户的uid不为0，非root用户不支持使用该接口
    if (uid != 0) {
        return EN_ERROR;
    }
    INT32 policy = SCHED_RR;
#ifndef __ANDROID__
    INT32 inherit = PTHREAD_EXPLICIT_SCHED;
#endif
    pthread_attr_t attr;
    struct sched_param param;
    (VOID)memset_s(&attr, sizeof(attr), 0, sizeof(attr)); /* unsafe_function_ignore: memset */
    (VOID)memset_s(&param, sizeof(param), 0, sizeof(param)); /* unsafe_function_ignore: memset */
    param.sched_priority = MMPA_MIN_THREAD_PIO;

    // 初始化线程属性
    INT32 retVal = pthread_attr_init(&attr);
    if (retVal != EN_OK) {
        return EN_ERROR;
    }
#ifndef __ANDROID__
    // 设置默认继承属性 PTHREAD_EXPLICIT_SCHED
    retVal = pthread_attr_setinheritsched(&attr, inherit);
    if (retVal != EN_OK) {
        (VOID)pthread_attr_destroy(&attr);
        return EN_ERROR;
    }
#endif
    // 设置默认调度策略 SCHED_RR
    retVal = pthread_attr_setschedpolicy(&attr, policy);
    if (retVal != EN_OK) {
        (VOID)pthread_attr_destroy(&attr);
        return EN_ERROR;
    }
    // 设置默认优先级 1
    retVal = pthread_attr_setschedparam(&attr, &param);
    if (retVal != EN_OK) {
        (VOID)pthread_attr_destroy(&attr);
        return EN_ERROR;
    }

    retVal = pthread_create(threadHandle, &attr, funcBlock->procFunc, funcBlock->pulArg);
    (VOID)pthread_attr_destroy(&attr);
    if (retVal != EN_OK) {
        retVal = EN_ERROR;
    }
    return retVal;
}

/*
 * 描述:获取指定进程优先级id
 * 参数: pid--进程ID
 * 返回值:执行成功返回优先级id, 执行错误返回MMPA_PROCESS_ERROR, 入参检查错误返回MMPA_PROCESS_ERROR
 */
INT32 mmGetProcessPrio(mmProcess pid)
{
    if (pid < MMPA_ZERO) {
        return MMPA_PROCESS_ERROR;
    }
    errno = MMPA_ZERO;
    INT32 ret = getpriority(PRIO_PROCESS, (id_t)pid);
    if ((ret == EN_ERROR) && ((INT32)errno != MMPA_ZERO)) {
        return MMPA_PROCESS_ERROR;
    }
    return ret;
}

/*
 * 描述:设置进程优先级
 * 参数: pid--进程ID
 *       processPrio: 需要设置的优先级值，参数范围取 -20 to 19
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmSetProcessPrio(mmProcess pid, INT32 processPrio)
{
    if ((pid < MMPA_ZERO) || (processPrio < MMPA_MIN_NI) || (processPrio > MMPA_MAX_NI)) {
        return EN_INVALID_PARAM;
    }
    return setpriority(PRIO_PROCESS, (id_t)pid, processPrio);
}

/*
 * 描述:获取线程优先级
 * 参数: threadHandle--线程ID
 * 返回值:执行成功返回获取到的优先级, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmGetThreadPrio(mmThread *threadHandle)
{
    if (threadHandle == NULL) {
        return EN_INVALID_PARAM;
    }
    struct sched_param param;
    INT32 policy = SCHED_RR;
    (VOID)memset_s(&param, sizeof(param), 0, sizeof(param)); /* unsafe_function_ignore: memset */

    INT32 ret = pthread_getschedparam(*threadHandle, &policy, &param);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return param.sched_priority;
}

/*
 * 描述:设置线程优先级, Linux默认以SCHED_RR策略设置
 * 参数: threadHandle--线程ID
 *       threadPrio:设置的优先级id，参数范围取1 - 99, 1为最高优先级
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmSetThreadPrio(mmThread *threadHandle, INT32 threadPrio)
{
    if (threadHandle == NULL) {
        return EN_INVALID_PARAM;
    }
    if ((threadPrio > MMPA_MAX_THREAD_PIO) || (threadPrio < MMPA_MIN_THREAD_PIO)) {
        return EN_INVALID_PARAM ;
    }

    struct sched_param param;
    (VOID)memset_s(&param, sizeof(param), 0, sizeof(param)); /* unsafe_function_ignore: memset */
    param.sched_priority = threadPrio;

    INT32 ret = pthread_setschedparam(*threadHandle, SCHED_RR, &param);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return ret;
}

/*
 * 描述:创建带分离属性的线程, 不需要mmJoinTask等待线程结束
 * 参数: threadHandle -- pthread_t类型的实例
 *       funcBlock --包含函数名和参数的结构体指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCreateTaskWithDetach(mmThread *threadHandle, mmUserBlock_t *funcBlock)
{
    if ((threadHandle == NULL) || (funcBlock == NULL) || (funcBlock->procFunc == NULL)) {
        return EN_INVALID_PARAM;
    }
    pthread_attr_t attr;
    (VOID)memset_s(&attr, sizeof(attr), 0, sizeof(attr)); /* unsafe_function_ignore: memset */

    // 初始化线程属性
    INT32 ret = pthread_attr_init(&attr);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    // 设置默认线程分离属性
    ret = pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
    if (ret != EN_OK) {
        (VOID)pthread_attr_destroy(&attr);
        return EN_ERROR;
    }

    ret = pthread_create(threadHandle, &attr, funcBlock->procFunc, funcBlock->pulArg);
    (VOID)pthread_attr_destroy(&attr);
    if (ret != EN_OK) {
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
INT32 mmTlsCreate(mmThreadKey *key, VOID(*destructor)(VOID*))
{
    if (key == NULL) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = pthread_key_create(key, destructor);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return ret;
}

/*
 * 描述:线程局部变量设置
 * 参数:key--线程变量存储区索引
 *      value--需要设置的局部变量的值
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmTlsSet(mmThreadKey key, const VOID *value)
{
    if (value == NULL) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = pthread_setspecific(key, value);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return ret;
}

/*
 * 描述:线程局部变量获取
 * 参数:key --线程变量存储区索引
 * 返回值:执行成功返回指向局部存储变量的指针, 执行错误返回NULL
 */
VOID *mmTlsGet(mmThreadKey key)
{
    return pthread_getspecific(key);
}

/*
 * 描述:线程局部变量清除
 * 参数:key--线程变量存储区索引
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR
 */
INT32 mmTlsDelete(mmThreadKey key)
{
    INT32 ret = pthread_key_delete(key);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return ret;
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
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wimplicit-function-declaration"
    INT32 ret = pthread_setname_np(*threadHandle, name);
#pragma GCC diagnostic pop
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:获取线程名-线程体外调用, 仅在Linux下生效, Windows下不支持为空实现
 * 参数:threadHandle--线程ID
 *      size--存放线程名的缓存长度
 *      name--线程名由用户分配缓存, 缓存长度必须>=MMPA_THREADNAME_SIZE
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmGetThreadName(mmThread *threadHandle, CHAR* name, INT32 size)
{
#ifndef __GLIBC__
    return EN_ERROR;
#else
    if ((threadHandle == NULL) || (name == NULL) || (size < MMPA_THREADNAME_SIZE)) {
        return EN_INVALID_PARAM;
    }
    UINT32 len = (UINT32)size;
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wimplicit-function-declaration"
    INT32 ret = pthread_getname_np(*threadHandle, name, len);
#pragma GCC diagnostic pop
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
#endif
}

/*
 * 描述:设置当前执行的线程的线程名-线程体内调用, 仅在Linux下生效, Windows下不支持为空实现
 * 参数:name--需要设置的线程名
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmSetCurrentThreadName(const CHAR* name)
{
    if (name == NULL) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = prctl(PR_SET_NAME, name);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:获取当前执行的线程的线程名-线程体内调用, 仅在Linux下生效, Windows下不支持为空实现
 * 参数:name--获取到的线程名, 缓存空间由用户分配
 *      size--缓存长度必须>=MMPA_THREADNAME_SIZE
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmGetCurrentThreadName(CHAR* name, INT32 size)
{
    if ((name == NULL) || (size < MMPA_THREADNAME_SIZE)) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = prctl(PR_GET_NAME, name);
    if (ret != EN_OK) {
        return EN_ERROR;
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
INT32 mmCreateProcess(const CHAR *fileName, const mmArgvEnv *env, const CHAR* stdoutRedirectFile, mmProcess *id)
{
    if ((id == NULL) || (fileName == NULL)) {
        return EN_INVALID_PARAM;
    }
    pid_t child = fork();
    if (child == EN_ERROR) {
        return EN_ERROR;
    }

    if (child == MMPA_ZERO) {
        if (stdoutRedirectFile != NULL) {
            INT32 fd = open(stdoutRedirectFile, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
            if (fd != EN_ERROR) {
                (VOID)mmDup2(fd, 1); // 1: standard output
                (VOID)mmDup2(fd, 2); // 2: error output
                (VOID)mmClose(fd);
            }
        }
        CHAR * const *  argv = NULL;
        CHAR * const *  envp = NULL;
        if (env != NULL) {
            if (env->argv != NULL) {
                argv = env->argv;
            }
            if (env->envp != NULL) {
                envp = env->envp;
            }
        }
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wimplicit-function-declaration"
        if (execvpe(fileName, argv, envp) < MMPA_ZERO) {
#pragma GCC diagnostic pop
            exit(1);
        }
        // 退出,不会运行至此
    }
    *id = child;
    return EN_OK;
}

/*
 * 描述:mmCreateTaskWithThreadAttr内部使用,设置线程调度相关属性
 * 参数: attr -- 线程属性结构体
 *       threadAttr -- 包含需要设置的线程属性类别和值
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
static INT32 LocalSetSchedAttr(pthread_attr_t *attr, const mmThreadAttr *threadAttr)
{
#ifndef __ANDROID__
    // 设置默认继承属性 PTHREAD_EXPLICIT_SCHED 使得调度属性生效
    if ((threadAttr->policyFlag == TRUE) || (threadAttr->priorityFlag == TRUE)) {
        if (pthread_attr_setinheritsched(attr, PTHREAD_EXPLICIT_SCHED) != EN_OK) {
            return EN_ERROR;
        }
    }
#endif

    // 设置调度策略
    if (threadAttr->policyFlag == TRUE) {
        if ((threadAttr->policy != MMPA_THREAD_SCHED_FIFO) && (threadAttr->policy != MMPA_THREAD_SCHED_OTHER) &&
            (threadAttr->policy != MMPA_THREAD_SCHED_RR)) {
            return EN_INVALID_PARAM;
        }
        if (pthread_attr_setschedpolicy(attr, threadAttr->policy) != EN_OK) {
            return EN_ERROR;
        }
    }

    // 设置优先级
    if (threadAttr->priorityFlag == TRUE) {
        if ((threadAttr->priority < MMPA_MIN_THREAD_PIO) || (threadAttr->priority > MMPA_MAX_THREAD_PIO)) {
            return EN_INVALID_PARAM;
        }
        struct sched_param param;
        (VOID)memset_s(&param, sizeof(param), 0, sizeof(param)); /* unsafe_function_ignore: memset */
        param.sched_priority = threadAttr->priority;
        if (pthread_attr_setschedparam(attr, &param) != EN_OK) {
            return EN_ERROR;
        }
    }
    return EN_OK;
}

/*
 * 描述:mmCreateTaskWithThreadAttr内部使用,创建带属性的线程, 支持调度策略、优先级、线程栈大小属性设置
 * 参数: attr -- 线程属性结构体
 *       threadAttr -- 包含需要设置的线程属性类别和值
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
static INT32 LocalSetThreadAttr(pthread_attr_t *attr, const mmThreadAttr *threadAttr)
{
    // 设置调度相关属性
    INT32 ret = LocalSetSchedAttr(attr, threadAttr);
    if (ret != EN_OK) {
        return ret;
    }

    // 设置堆栈
    if (threadAttr->stackFlag == TRUE) {
        if (threadAttr->stackSize < MMPA_THREAD_MIN_STACK_SIZE) {
            return EN_INVALID_PARAM;
        }
        if (pthread_attr_setstacksize(attr, threadAttr->stackSize) != EN_OK) {
            return EN_ERROR;
        }
    }
    if (threadAttr->detachFlag == TRUE) {
        // 设置默认线程分离属性
        if (pthread_attr_setdetachstate(attr, PTHREAD_CREATE_DETACHED) != EN_OK) {
            return EN_ERROR;
        }
    }
    return EN_OK;
}

/*
 * 描述:创建带属性的线程, 支持调度策略、优先级、线程栈大小、分离属性设置,除了分离属性,其他只在Linux下有效
 * 参数: threadHandle -- pthread_t类型的实例
 *       funcBlock --包含函数名和参数的结构体指针
 *       threadAttr -- 包含需要设置的线程属性类别和值
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmCreateTaskWithThreadAttr(mmThread *threadHandle, const mmUserBlock_t *funcBlock,
                                 const mmThreadAttr *threadAttr)
{
    if ((threadHandle == NULL) || (funcBlock == NULL) ||
        (funcBlock->procFunc == NULL) || (threadAttr == NULL)) {
        return EN_INVALID_PARAM;
    }

    pthread_attr_t attr;
    (VOID)memset_s(&attr, sizeof(attr), 0, sizeof(attr)); /* unsafe_function_ignore: memset */

    // 初始化线程属性
    INT32 ret = pthread_attr_init(&attr);
    if (ret != EN_OK) {
        return EN_ERROR;
    }

    ret = LocalSetThreadAttr(&attr, threadAttr);
    if (ret != EN_OK) {
        (VOID)pthread_attr_destroy(&attr);
        return ret;
    }

    ret = pthread_create(threadHandle, &attr, funcBlock->procFunc, funcBlock->pulArg);
    (VOID)pthread_attr_destroy(&attr);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }
    return ret;
}

#ifdef __cplusplus
#if __cplusplus
}
#endif /* __cpluscplus */
#endif /* __cpluscplus */

