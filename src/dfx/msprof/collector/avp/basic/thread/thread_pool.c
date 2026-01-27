/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "thread_pool.h"
#include "logger/logger.h"
#include "errno/error_code.h"
#include "utils/utils.h"
#include "osal/osal_mem.h"
#include "osal/osal_thread.h"

STATIC ThreadPool *g_threadPool = NULL;

static int32_t ThreadPoolFilling(uint32_t queueSize, uint32_t consumerNum, uint32_t maxConsumerNum)
{
    PROF_CHK_EXPR_ACTION(g_threadPool == NULL, return PROFILING_FAILED, "ThreadPool is NULL.");
    g_threadPool->threadId = NULL;
    g_threadPool->taskQueue = NULL;
    // malloc consumer threadId of thread pool
    g_threadPool->threadId = (OsalThread*)OsalCalloc(sizeof(OsalThread) * maxConsumerNum);
    PROF_CHK_EXPR_ACTION(g_threadPool->threadId == NULL, return PROFILING_FAILED,
        "Failed to malloc threadId of threadPool.");
    // malloc task queue of thread pool
    g_threadPool->taskQueue = (ThreadTask*)OsalMalloc(sizeof(ThreadTask) * queueSize);
    PROF_CHK_EXPR_ACTION(g_threadPool->taskQueue == NULL, return PROFILING_FAILED,
        "Failed to malloc taskQueue of threadPool.");
    g_threadPool->capacity = queueSize;
    g_threadPool->size = 0;
    g_threadPool->front = 0;
    g_threadPool->rear = 0;
    g_threadPool->threadNum = consumerNum;
    g_threadPool->maxThreadNum = maxConsumerNum;
    g_threadPool->destruct = 0;
    g_threadPool->liveNum = 0;
    for (uint32_t i = 0; i < consumerNum; ++i) {
        // run consumer thread
        int32_t ret = OsalCreateThread(&g_threadPool->threadId[i], ProfThreadPoolConsumer);
        PROF_CHK_EXPR_ACTION(ret != OSAL_EN_OK, return PROFILING_FAILED,
            "Failed to create thread of threadPool, ret: %d.", ret);
        MSPROF_LOGI("Success to create pool thread, id: %u", i);
        g_threadPool->liveNum++;
    }
    MSPROF_LOGI("Success to init threadPool, capacity: %u, size: %u.", g_threadPool->capacity, g_threadPool->size);
    return PROFILING_SUCCESS;
}

/**
 * @brief Init the thread pool and start consumer thread
 * @param [in] queueSize: task queue size
 * @param [in] consumerNum: the consumer number of thread pool
 * @param [in] maxConsumerNum: max consumer number of thread pool
 */
int32_t ProfThreadPoolInit(uint32_t queueSize, uint32_t consumerNum, uint32_t maxConsumerNum)
{
    if (g_threadPool != NULL) {
        MSPROF_LOGI("Repeat init thread pool.");
        return PROFILING_SUCCESS;
    }
    // malloc thread pool
    g_threadPool = (ThreadPool*)OsalMalloc(sizeof(ThreadPool));
    if (g_threadPool == NULL) {
        MSPROF_LOGE("Failed to malloc threadPool.");
        return PROFILING_FAILED;
    }
    // init mutex and condition
    if (OsalMutexInit(&g_threadPool->poolMtx) != 0 ||
        OsalMutexInit(&g_threadPool->liveMtx) != 0 ||
        OsalCondInit(&g_threadPool->notEmpty) != 0 ||
        OsalCondInit(&g_threadPool->notFull) != 0 ||
        OsalCondInit(&g_threadPool->liveCond) != 0) {
        MSPROF_LOGE("Failed to init mutex or condition of threadPool.");
        OSAL_MEM_FREE(g_threadPool);
        return PROFILING_FAILED;
    }
    if (ThreadPoolFilling(queueSize, consumerNum, maxConsumerNum) == PROFILING_SUCCESS) {
        return PROFILING_SUCCESS;
    }
    // free mutex and condition
    (void)OsalMutexDestroy(&g_threadPool->poolMtx);
    (void)OsalMutexDestroy(&g_threadPool->liveMtx);
    (void)OsalCondDestroy(&g_threadPool->notFull);
    (void)OsalCondDestroy(&g_threadPool->notEmpty);
    (void)OsalCondDestroy(&g_threadPool->liveCond);
    // free malloc
    if (g_threadPool != NULL && g_threadPool->threadId != NULL) {
        OSAL_MEM_FREE(g_threadPool->threadId);
    }
    if (g_threadPool != NULL && g_threadPool->taskQueue != NULL) {
        OSAL_MEM_FREE(g_threadPool->taskQueue);
    }
    OSAL_MEM_FREE(g_threadPool);
    return PROFILING_FAILED;
}

/**
 * @brief Finalize the thread pool and free it
 */
VOID ProfThreadPoolFinalize(void)
{
    if (g_threadPool == NULL) {
        MSPROF_LOGW("Thread pool is already finalize.");
        return;
    }
    // identify close threadPool
    g_threadPool->destruct = 1;
    // wake thread
    for (uint32_t i = 0; i < g_threadPool->threadNum; ++i) {
        (void)OsalCondSignal(&g_threadPool->notEmpty);
    }
    // simulate join thread exit
    (void)OsalMutexLock(&g_threadPool->liveMtx);
    if (g_threadPool->liveNum > 0) {
        OsalCondWait(&g_threadPool->liveCond, &g_threadPool->liveMtx);
    }
    (void)OsalMutexUnlock(&g_threadPool->liveMtx);
    for (uint32_t i = 0; i < g_threadPool->threadNum; ++i) {
        g_threadPool->threadId[i] = 0;
    }
    MSPROF_EVENT("total_size_pool, front point: %d, rear point: %d", g_threadPool->front, g_threadPool->rear);
    // free mutex and condition
    (void)OsalMutexDestroy(&g_threadPool->poolMtx);
    (void)OsalCondDestroy(&g_threadPool->notFull);
    (void)OsalCondDestroy(&g_threadPool->notEmpty);
    // free malloc
    if (g_threadPool->threadId != NULL) {
        OSAL_MEM_FREE(g_threadPool->threadId);
    }
    if (g_threadPool->taskQueue != NULL) {
        OSAL_MEM_FREE(g_threadPool->taskQueue);
    }
    OSAL_MEM_FREE(g_threadPool);
    MSPROF_LOGI("Success to finalize threadPool.");
}

/**
 * @brief Push one task to queue of thread pool
 * @param [in] task: thread task with function and arguments
 * @param [in] priority: 0: highest task; 1: secondary task
 * @return Success return PROFILING_SUCCESS, failed return PROFILING_FAILED
 */
int32_t ProfThreadPoolDispatch(ThreadTask* task, uint32_t priority)
{
    if (g_threadPool == NULL) {
        MSPROF_LOGE("Failed to dispatch task because of nullptr thread pool.");
        return PROFILING_FAILED;
    }
    (void)OsalMutexLock(&g_threadPool->poolMtx);
    if (g_threadPool->destruct == 1) {
        (void)OsalMutexUnlock(&g_threadPool->poolMtx);
        MSPROF_LOGE("Failed to dispatch task because thread pool is already destroyed.");
        return PROFILING_FAILED;
    }
    if (g_threadPool->size == g_threadPool->capacity && g_threadPool->destruct == 0) {
        // block producer thread
        MSPROF_LOGW("The task queue is full, wait util notify from front point move.");
        OsalCondWait(&g_threadPool->notFull, &g_threadPool->poolMtx);
    }
    if (priority == 0) {
        // move front point and push task to queue list front
        if (g_threadPool->front == 0) {
            g_threadPool->front = g_threadPool->capacity - 1U;
        } else {
            g_threadPool->front = (g_threadPool->front - 1U) % g_threadPool->capacity;
        }
        g_threadPool->taskQueue[g_threadPool->front].function = task->function;
        g_threadPool->taskQueue[g_threadPool->front].taskArgs = task->taskArgs;
        MSPROF_LOGI("Success to push highest task, front point: %u, rear point: %u.",
            g_threadPool->front, g_threadPool->rear);
    } else {
        // push task to queue list rear and move rear point
        g_threadPool->taskQueue[g_threadPool->rear].function = task->function;
        g_threadPool->taskQueue[g_threadPool->rear].taskArgs = task->taskArgs;
        g_threadPool->rear = (g_threadPool->rear + 1U) % g_threadPool->capacity;
        MSPROF_LOGI("Success to push secondary task, front point: %u, rear point: %u.",
            g_threadPool->front, g_threadPool->rear);
    }
    g_threadPool->size++;
    // release consumer thread
    (void)OsalCondSignal(&g_threadPool->notEmpty);
    (void)OsalMutexUnlock(&g_threadPool->poolMtx);
    return PROFILING_SUCCESS;
}

/**
 * @brief Identify stop thread
 */
VOID ProfThreadPoolStop(void)
{
    OsalThread threadTid = pthread_self();
    for (uint32_t i = 0; i < g_threadPool->threadNum; ++i) {
        if (g_threadPool->threadId[i] == threadTid) {
            MSPROF_LOGI("Called thead %d exit.", threadTid);
            (void)OsalMutexLock(&g_threadPool->liveMtx);
            g_threadPool->liveNum--;
            if (g_threadPool->liveNum == 0) {
                (void)OsalCondSignal(&g_threadPool->liveCond);
            }
            (void)OsalMutexUnlock(&g_threadPool->liveMtx);
            break;
        }
    }
}

/**
 * @brief Consumer thread of thread pool
 */
OsalVoidPtr ProfThreadPoolConsumer(OsalVoidPtr arg)
{
    UNUSED(arg);
    do {
        (void)OsalMutexLock(&g_threadPool->poolMtx);
        while (g_threadPool->size == 0 && g_threadPool->destruct == 0) {
            // block consumer thread
            OsalCondWait(&g_threadPool->notEmpty, &g_threadPool->poolMtx);
        }

        if (g_threadPool->destruct == 1) {
            (void)OsalMutexUnlock(&g_threadPool->poolMtx);
            ProfThreadPoolStop(); // stop this thread
            break;
        }
        // dispatch one task
        ThreadTask profTask;
        profTask.function = g_threadPool->taskQueue[g_threadPool->front].function;
        profTask.taskArgs = g_threadPool->taskQueue[g_threadPool->front].taskArgs;
        // move front point
        g_threadPool->front = (g_threadPool->front + 1U) % g_threadPool->capacity;
        g_threadPool->size--;
        MSPROF_LOGI("Success to pop and run task, front point: %u, rear point: %u.",
            g_threadPool->front, g_threadPool->rear);
        // release producer thread
        (void)OsalCondSignal(&g_threadPool->notFull);
        // unlock mutex
        (void)OsalMutexUnlock(&g_threadPool->poolMtx);
        // run task
        profTask.function(profTask.taskArgs);
        MSPROF_LOGI("Success to run task end.");
    } while (1);
    return NULL;
}

/**
 * @brief Expand thread num of thread pool
 * @param [in] expandNum: the number of thread need to add
 * @return Success return PROFILING_SUCCESS, failed return PROFILING_FAILED
 */
int32_t ProfThreadPoolExpand(uint32_t expandNum)
{
    if (g_threadPool == NULL) {
        MSPROF_LOGE("Failed to expand thread pool because of nullptr thread pool.");
        return PROFILING_FAILED;
    }
    if (expandNum <= 0) {
        MSPROF_LOGE("Failed to expand thread pool by negative expand number.");
        return PROFILING_FAILED;
    }
    (void)OsalMutexLock(&g_threadPool->poolMtx);
    uint32_t count = 0;
    for (uint32_t i = g_threadPool->threadNum;
        i < g_threadPool->maxThreadNum && i < (g_threadPool->threadNum + expandNum); ++i) {
        int32_t ret = OsalCreateThread(&g_threadPool->threadId[i], ProfThreadPoolConsumer);
        if (ret != OSAL_EN_OK) {
            MSPROF_LOGE("Failed to create thread of threadPool, ret: %d.", ret);
            (void)OsalMutexUnlock(&g_threadPool->poolMtx);
            return PROFILING_FAILED;
        }
        MSPROF_LOGI("Expand thread, index %u, id: %d.", i, g_threadPool->threadId[i]);
        count++;
        (void)OsalMutexLock(&g_threadPool->liveMtx);
        g_threadPool->liveNum++;
        (void)OsalMutexUnlock(&g_threadPool->liveMtx);
    }
    g_threadPool->threadNum += count;
    (void)OsalMutexUnlock(&g_threadPool->poolMtx);
    MSPROF_LOGI("Success to expand thread num to %u", g_threadPool->threadNum);
    return PROFILING_SUCCESS;
}
