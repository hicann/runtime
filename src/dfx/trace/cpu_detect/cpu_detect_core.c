/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "cpu_detect_core.h"
#include <stdlib.h>
#define __USE_GNU
#define _GNU_SOURCE
#include <sched.h>
#include <stdio.h>
#include <errno.h>
#include <pthread.h>
#include <limits.h>
#include <sys/time.h>
#include <sys/prctl.h>
#include "cpu_detect_print.h"
#include "cpu_detect_test.h"
#include "ascend_hal.h"

#define DEVICE_MAX_CPU_NUM  64U
#define THREAD_NAME_LENGTH  16U

typedef struct {
    int32_t cpuId;
    int32_t moduleType;
} CpuInfo;

typedef struct {
    CpuInfo cpu;
    int32_t tid;
    pthread_t task;
    int32_t result;
} CpuDetectThreadMgr;

typedef struct {
    bool stop;
    uint32_t devNum;
    uint32_t cpuNum;
    uint32_t timeout;
    struct timeval startTime;
    CpuDetectThreadMgr thread[DEVICE_MAX_CPU_NUM];
} CpuDetectMgr;

STATIC CpuDetectMgr g_cpuDetectMgr = {0}; 

STATIC INLINE bool CpuDetectIsStop(void) 
{
    return g_cpuDetectMgr.stop;
}

STATIC INLINE void CpuDetectSetStop(void) 
{
    if (!g_cpuDetectMgr.stop) {
        g_cpuDetectMgr.stop = true;
    }
}

STATIC INLINE struct timeval *CpuDetectGetStartTime(void) 
{
    return &g_cpuDetectMgr.startTime;
}

STATIC INLINE uint32_t CpuDetectGetTimeout(void) 
{
    return g_cpuDetectMgr.timeout;
}

STATIC INLINE CpudStatus CpuDetectGetResult(void)
{
    CpudStatus ret = CPUD_SUCCESS;
    for (uint32_t i = 0; i < g_cpuDetectMgr.cpuNum && i < DEVICE_MAX_CPU_NUM; i++) {
        if (g_cpuDetectMgr.thread[i].result != CPUD_SUCCESS) {
            ret = (g_cpuDetectMgr.thread[i].result > ret) ? g_cpuDetectMgr.thread[i].result : ret;
        }
    }
    return ret;
}

STATIC INLINE int32_t CpuDetectGetTid(void)
{
    return (int32_t)syscall(SYS_gettid);
}

STATIC CpudStatus CpuDetectBindCgroup(int32_t moduleType)
{   
    if (moduleType == MODULE_TYPE_AICPU) {
        drvError_t drvRet = halBindCgroup(BIND_AICPU_CGROUP);
        if (drvRet != DRV_ERROR_NONE) {
            ADETECT_ERR("bind aicpu cgroup failed, ret[%d].", drvRet);
            return CPUD_FAILURE;
        }
        ADETECT_INF("bind aicpu cgroup success.");
        return CPUD_SUCCESS;
    } else if (moduleType == MODULE_TYPE_DCPU) {
        drvError_t drvRet = halBindCgroup(BIND_DATACPU_CGROUP);
        if (drvRet != DRV_ERROR_NONE) {
            ADETECT_ERR("bind datacpu cgroup failed, ret[%d]", drvRet);
            return CPUD_FAILURE;
        }
        ADETECT_INF("bind datacpu cgroup success.");
        return CPUD_SUCCESS;
    } else {
        ADETECT_INF("use default cgroup: ccpu_cgroup.");
        return CPUD_SUCCESS;
    }
}

STATIC CpudStatus CpuDetectSetAffinity(const CpuInfo *info)
{
    CpudStatus ret = CpuDetectBindCgroup(info->moduleType);
    if (ret != CPUD_SUCCESS) {
        return CPUD_ERROR_CGROUP_BIND;
    }
    
    cpu_set_t mask;
    CPU_ZERO(&mask);
    CPU_SET(info->cpuId, &mask);
    int32_t err = pthread_setaffinity_np(pthread_self(), sizeof(mask), &mask);
    if (err != 0) {
        ADETECT_ERR("thread(%d) can not set cpu(%d) setaffinity, errno:%d, err:%s", CpuDetectGetTid(), info->cpuId, errno, strerror(errno));
        return CPUD_ERROR_CPU_AFFINITY;
    }
    ADETECT_INF("thread(%d) set cpu(%d) setaffinity success", CpuDetectGetTid(), info->cpuId);
    return CPUD_SUCCESS;
}

STATIC INLINE bool CpuDetectCheckTime(struct timeval *start, uint32_t timeout)
{
    struct timeval end = {0};
    gettimeofday(&end, NULL);
    if ((end.tv_sec - start->tv_sec) >= timeout) {
        return true;
    }
    return false;
}

STATIC INLINE int64_t CpuDetectGetRuntime(struct timeval *start)
{
    struct timeval end = {0};
    gettimeofday(&end, NULL);
    int64_t time = end.tv_sec - start->tv_sec;
    return (time == 0 ? 1 : time);
}

STATIC CpudStatus CpuDetectThreadEntry(CpuInfo *info)
{
    uint32_t *regValues = (uint32_t *)malloc(TEMP_BUF_SIZE);
    if (regValues == NULL) {
        ADETECT_ERR("malloc regValues failed.");
        return CPUD_ERROR_MALLOC;
    }

    uint32_t *loadStoreBuf = (uint32_t *)malloc(TEMP_BUF_SIZE);
    if (loadStoreBuf == NULL) {
        ADETECT_ERR("malloc loadStoreBuf failed.");
        free(regValues);
        return CPUD_ERROR_MALLOC;
    }

    int64_t cycle = 0;
    CpudStatus ret = CPUD_SUCCESS;
    while (!CpuDetectIsStop()) {
        cycle++;
        ret = CpuDetectGroup(regValues, loadStoreBuf, info->cpuId);
        if (ret != CPUD_SUCCESS) {
            int64_t run = CpuDetectGetRuntime(CpuDetectGetStartTime());
            ADETECT_ERR("cpu(%d) detect failed and exit after running %lld cycles for %lld seconds.", info->cpuId, cycle, run);
            break;
        }

        bool result = CpuDetectCheckTime(CpuDetectGetStartTime(), CpuDetectGetTimeout());
        if (result || (cycle >= INT_MAX)) {
            int64_t run = CpuDetectGetRuntime(CpuDetectGetStartTime());
            ADETECT_RUN_INF("cpu(%d) detect success and exit after running %lld cycles for %lld seconds.", info->cpuId, cycle, run);
            break;
        }
    }
    free(regValues);
    free(loadStoreBuf);
    return ret;
}

STATIC INLINE void CpuDetectSetName(const char *name)
{
    int32_t ret = prctl(PR_SET_NAME, (unsigned long)(uintptr_t)name);
    ADETECT_CHK_EXPR(ret != EOK, "cpu detect set name(%s) failed with %d.", name, ret);
}

STATIC INLINE void CpuDetectSetThreadName(int32_t cpuId)
{
    char threadName[THREAD_NAME_LENGTH] = {0};
    int32_t ret = snprintf_s(threadName, THREAD_NAME_LENGTH, THREAD_NAME_LENGTH - 1U, "cpu_detect_%d", cpuId);
    ADETECT_CHK_EXPR(ret == -1, "cpu detect set thread name(%s) failed, snprintf_s err=%d.", threadName, ret);

    CpuDetectSetName((const char *)threadName);
}

STATIC void *CpuDetectThread(void *arg)
{
    ADETECT_CHK_NULL_PTR(arg, return NULL);

    CpuDetectThreadMgr *thread = (CpuDetectThreadMgr *)arg;
    ADETECT_CHK_EXPR_ACTION(thread->cpu.cpuId < 0, return NULL, "cpu detect thread(%d), cpuId(%d) is invalid.", thread->tid, thread->cpu.cpuId);
    thread->tid = CpuDetectGetTid();
    ADETECT_INF("cpu(%d) detect thread(%d) create success.", thread->cpu.cpuId, thread->tid);
    CpuDetectSetThreadName(thread->cpu.cpuId);
    
    CpudStatus ret = CpuDetectSetAffinity(&thread->cpu);
    if (ret != CPUD_SUCCESS) {
        thread->result = ret;
        CpuDetectSetStop();
        return NULL;
    }

    ret = CpuDetectThreadEntry(&thread->cpu);
    if (ret != CPUD_SUCCESS) {
        thread->result = ret;
        CpuDetectSetStop();
        return NULL;
    }
    return NULL;
}

STATIC CpudStatus CpuDetectCreateThread(CpuDetectThreadMgr *thread)
{
    int32_t ret = pthread_create(&thread->task, NULL, CpuDetectThread, (void *)thread);
    if (ret != 0) {
        CpuDetectSetStop();
        thread->result = CPUD_ERROR_CREATE_THREAD;
        return CPUD_ERROR_CREATE_THREAD;
    }
    
    return CPUD_SUCCESS;
}

STATIC void CpuDetectReleaseThread(CpuDetectThreadMgr *thread)
{
    if (thread->task != 0) {
        int32_t ret = pthread_join(thread->task, NULL);
        ADETECT_CHK_EXPR_ACTION(ret != 0, return, "cpu(%d) detect can not join thread(%d), error=%d, strerr=%s.",
                                thread->cpu.cpuId, thread->tid, errno, strerror(errno));
        ADETECT_INF("cpu(%d) detect thread(%d) release success.", thread->cpu.cpuId, thread->tid);
    }
}

STATIC CpudStatus CpuDetectGetDevNum(uint32_t *deviceNum)
{
    drvError_t drvRet = drvGetDevNum(deviceNum);
    if (drvRet != DRV_ERROR_NONE) {
        ADETECT_ERR("call drvGetDevNum failed with %d.", (int32_t)drvRet);
        return CPUD_FAILURE;
    }
    return CPUD_SUCCESS;
}

STATIC CpudStatus CpuDetectGetAicpuInfo(uint32_t deviceId, uint32_t cpuNum, CpuDetectThreadMgr *thread, uint32_t size)
{
    int64_t aicpuNum = 0;
    int64_t cpuBitMap = 0;
    drvError_t ret = halGetDeviceInfo(deviceId, MODULE_TYPE_AICPU, INFO_TYPE_PF_CORE_NUM, &aicpuNum);
    ADETECT_CHK_EXPR_ACTION((ret != DRV_ERROR_NONE) || (aicpuNum <= 0) || (aicpuNum >= cpuNum), return CPUD_FAILURE, 
                            "device[%u] aicpu detect call halGetDeviceInfo failed with %d, cpu num(%lld).", deviceId, (int32_t)ret, aicpuNum);

    ret = halGetDeviceInfo(deviceId, MODULE_TYPE_AICPU, INFO_TYPE_PF_OCCUPY, &cpuBitMap);
    ADETECT_CHK_EXPR_ACTION(ret != DRV_ERROR_NONE, return CPUD_FAILURE, "device[%u] aicpu detect call halGetDeviceInfo failed with %d.", deviceId, (int32_t)ret);

    ADETECT_INF("device[%u] aicpu detect get info: cpuBitMap[%lld], cpuNum[%lld].", deviceId, cpuBitMap, aicpuNum);
    for (uint32_t i = 0; i < size; i++) {
        if ((cpuBitMap & 0x1LL) != 0LL) {
            uint32_t cpuId = (uint32_t)(deviceId * cpuNum) + i;
            ADETECT_CHK_EXPR_ACTION(cpuId >= size, return CPUD_FAILURE, "device[%u] aicpu detect get info failed, cpu num(%lld), cpu id(%u).", deviceId, aicpuNum, cpuId);
            thread[cpuId].cpu.moduleType = MODULE_TYPE_AICPU;
            thread[cpuId].cpu.cpuId = (int32_t)cpuId;
            ADETECT_INF("device[%u] cpu detect get info: aicpu id(%u).", deviceId, cpuId);
        }
        cpuBitMap = cpuBitMap >> 1;
    }
    return CPUD_SUCCESS;
}

STATIC CpudStatus CpuDetectGetCcpuInfo(uint32_t deviceId, uint32_t cpuNum, CpuDetectThreadMgr *thread, uint32_t size)
{
    int64_t ccpuNum = 0;
    drvError_t ret = halGetDeviceInfo(deviceId, MODULE_TYPE_CCPU, INFO_TYPE_CORE_NUM, &ccpuNum);
    ADETECT_CHK_EXPR_ACTION((ret != DRV_ERROR_NONE) || (ccpuNum == 0), return CPUD_FAILURE,
                            "device[%u] ccpu detect call halGetDeviceInfo failed with %d.", deviceId, (int32_t)ret);

    for (int32_t i = 0; i < ccpuNum; i++) {
        uint32_t cpuId = (uint32_t)(deviceId * cpuNum) + i;
        ADETECT_CHK_EXPR_ACTION(cpuId >= size, return CPUD_FAILURE, "device[%u] ccpu detect get info failed, cpu num(%lld), cpu id(%u).", deviceId, ccpuNum, cpuId);
        thread[cpuId].cpu.moduleType = MODULE_TYPE_CCPU;
        thread[cpuId].cpu.cpuId = (int32_t)cpuId;
        ADETECT_INF("device[%u] cpu detect get info: ccpu id(%u).", deviceId, cpuId);
    }
    return CPUD_SUCCESS;
}

STATIC CpudStatus CpuDetectGetDcpuInfo(uint32_t deviceId, uint32_t cpuNum, CpuDetectThreadMgr *thread, uint32_t size)
{
    int64_t ccpuNum = 0;
    int64_t dcpuNum = 0;

    drvError_t ret = halGetDeviceInfo(deviceId, MODULE_TYPE_CCPU, INFO_TYPE_CORE_NUM, &ccpuNum);
    ADETECT_CHK_EXPR_ACTION(ret != DRV_ERROR_NONE, return CPUD_FAILURE, "device[%u] ccpu detect call halGetDeviceInfo failed with %d.", deviceId, (int32_t)ret);

    ret = halGetDeviceInfo(deviceId, MODULE_TYPE_DCPU, INFO_TYPE_CORE_NUM, &dcpuNum);
    ADETECT_CHK_EXPR_ACTION(ret != DRV_ERROR_NONE, return CPUD_FAILURE, "device[%u] dcpu detect call halGetDeviceInfo failed with %d.", deviceId, (int32_t)ret);
    
    for (int32_t i = 0; i < dcpuNum; i++) {
        uint32_t cpuId = (uint32_t)(deviceId * cpuNum) + ccpuNum + i;
        ADETECT_CHK_EXPR_ACTION(cpuId >= size, return CPUD_FAILURE, "device[%u] dcpu detect get info failed, cpu num(%lld), cpu id(%u).", deviceId, dcpuNum, cpuId);

        thread[cpuId].cpu.moduleType = MODULE_TYPE_DCPU;
        thread[cpuId].cpu.cpuId = (int32_t)cpuId;
        ADETECT_INF("device[%u] cpu detect get info: dcpu id(%u).", deviceId, cpuId);
    }
    return CPUD_SUCCESS;
}

STATIC int32_t CpuDetectGetCpuNum(uint32_t deviceId)
{
    int64_t cpuNum = 0;
    int32_t totalCpuNum = 0;

    drvError_t ret = halGetDeviceInfo(deviceId, MODULE_TYPE_AICPU, INFO_TYPE_PF_CORE_NUM, &cpuNum);
    ADETECT_CHK_EXPR_ACTION((ret != DRV_ERROR_NONE) || (cpuNum == 0), return CPUD_FAILURE, "device[%u] get aicpu num failed with %d.", deviceId, (int32_t)ret);
    totalCpuNum += (int32_t)cpuNum;
    ADETECT_INF("device[%u] cpu detect get info: aicpu cpu num(%lld).", deviceId, cpuNum);

    ret = halGetDeviceInfo(deviceId, MODULE_TYPE_CCPU, INFO_TYPE_CORE_NUM, &cpuNum);
    ADETECT_CHK_EXPR_ACTION((ret != DRV_ERROR_NONE) || (cpuNum == 0), return CPUD_FAILURE, "device[%u] get ccpu num failed with %d.", deviceId, (int32_t)ret);
    totalCpuNum += (int32_t)cpuNum;
    ADETECT_INF("device[%u] cpu detect get info: ccpu cpu num(%lld).", deviceId, cpuNum);

    ret = halGetDeviceInfo(deviceId, MODULE_TYPE_DCPU, INFO_TYPE_CORE_NUM, &cpuNum);
    ADETECT_CHK_EXPR_ACTION(ret != DRV_ERROR_NONE, return CPUD_FAILURE, "device[%u] get dcpu num failed with %d.", deviceId, (int32_t)ret);
    totalCpuNum += (int32_t)cpuNum;
    ADETECT_INF("device[%u] cpu detect get info: dcpu cpu num(%lld).", deviceId, cpuNum);
    return totalCpuNum;
}

STATIC int32_t CpuDetectGetDeviceCpuInfo(uint32_t deviceId, CpuDetectThreadMgr *thread, uint32_t size)
{
    int32_t num = CpuDetectGetCpuNum(deviceId);
    if (num <= 0) {
        ADETECT_ERR("device[%u] cpu detect get info failed with %d.", deviceId, num);
        return CPUD_FAILURE;
    }
    ADETECT_INF("device[%u] cpu detect get info: total cpu num(%d).", deviceId, num);
    uint32_t cpuNum = (uint32_t)num;
    // cpu分段为：ccpu - dcpu - aicpu
    int32_t ret = CpuDetectGetCcpuInfo(deviceId, cpuNum, thread, size);
    if (ret == CPUD_FAILURE) {
        return CPUD_FAILURE;
    }

    ret = CpuDetectGetDcpuInfo(deviceId, cpuNum, thread, size);
    if (ret == CPUD_FAILURE) {
        return CPUD_FAILURE;
    }

    ret = CpuDetectGetAicpuInfo(deviceId, cpuNum, thread, size);
    if (ret == CPUD_FAILURE) {
        return CPUD_FAILURE;
    }
    return num;
}

STATIC CpudStatus CpuDetectGetCpuInfo(uint32_t deviceNum, uint32_t *cpuNum, CpuDetectThreadMgr *thread, uint32_t size)
{
    uint32_t num = 0;
    for (uint32_t i = 0; i < deviceNum; i++) {
        int32_t ret = CpuDetectGetDeviceCpuInfo(i, thread, size);
        if (ret == CPUD_FAILURE) {
            return CPUD_FAILURE;
        }
        num += (uint32_t)ret;
    }
    *cpuNum = num;
    return CPUD_SUCCESS;
}

STATIC CpudStatus CpuDetectInit(uint32_t timeout)
{
    // timeout校验
    g_cpuDetectMgr.stop = false;
    g_cpuDetectMgr.timeout = timeout;
    gettimeofday(&g_cpuDetectMgr.startTime, NULL);

    // 获取dev个数
    CpudStatus ret = CpuDetectGetDevNum(&g_cpuDetectMgr.devNum);
    ADETECT_CHK_EXPR_ACTION((ret != CPUD_SUCCESS) || (g_cpuDetectMgr.devNum == 0), return CPUD_FAILURE, "get dev num(%u) failed with %d.", g_cpuDetectMgr.devNum, ret);
    
    // 获取cpu个数和类型
    g_cpuDetectMgr.cpuNum = 0;
    for (uint32_t i = 0; i < DEVICE_MAX_CPU_NUM; i++) {
        g_cpuDetectMgr.thread[i].cpu.cpuId = -1;
        g_cpuDetectMgr.thread[i].cpu.moduleType = -1;
        g_cpuDetectMgr.thread[i].tid = 0;
        g_cpuDetectMgr.thread[i].task = 0;
        g_cpuDetectMgr.thread[i].result = 0;
    }
    ret = CpuDetectGetCpuInfo(g_cpuDetectMgr.devNum, &g_cpuDetectMgr.cpuNum, g_cpuDetectMgr.thread, DEVICE_MAX_CPU_NUM);
    ADETECT_CHK_EXPR_ACTION((ret != CPUD_SUCCESS) || (g_cpuDetectMgr.cpuNum == 0), return CPUD_FAILURE, "get cpu info failed with %d, num(%u).", ret, g_cpuDetectMgr.cpuNum);

    ADETECT_INF("cpu detect get info: devNum(%u), cpuNum(%u).", g_cpuDetectMgr.devNum, g_cpuDetectMgr.cpuNum);
    return CPUD_SUCCESS;
}

STATIC void CpuDetectExit(void)
{
    size_t size = sizeof(CpuDetectMgr);
    (void)memset_s(&g_cpuDetectMgr, size, 0, size);
    return;
}

CpudStatus CpuDetectProcess(uint32_t timeout)
{
    CpuDetectSetName("cpu_detect_process.");
    CpudStatus ret = CpuDetectInit(timeout);
    if (ret != CPUD_SUCCESS) {
        ADETECT_ERR("cpu detect init failed with %d.", ret);
        return CPUD_ERROR_INIT;
    }

    // 启动线程
    for (uint32_t i = 0; i < g_cpuDetectMgr.cpuNum && i < DEVICE_MAX_CPU_NUM; i++) {
        ret = CpuDetectCreateThread(&g_cpuDetectMgr.thread[i]);
        if (ret != CPUD_SUCCESS) {
            ADETECT_ERR("cpu(%d) create thread failed, err: %d(%s)", g_cpuDetectMgr.thread[i].cpu.cpuId, errno, strerror(errno));
            break;
        }
    }

    // 回收线程
    for (uint32_t j = 0; j < g_cpuDetectMgr.cpuNum && j < DEVICE_MAX_CPU_NUM; j++) {
        CpuDetectReleaseThread(&g_cpuDetectMgr.thread[j]);
    }
    ret = CpuDetectGetResult();
    CpuDetectExit();
    return ret;
}
