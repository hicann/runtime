/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef AWATCHDOG_H
#define AWATCHDOG_H
#include "awatchdog_types.h"

#define AWD_ATOMIC_FETCH_AND_ADD(ptr, value)        ((__typeof__(*(ptr)))__sync_fetch_and_add((ptr), (value)))
#define AWD_ATOMIC_SUB_AND_FETCH(ptr, value)        ((__typeof__(*(ptr)))__sync_sub_and_fetch((ptr), (value)))
#define AWD_ATOMIC_TEST_AND_SET(ptr, value)          ((void)__sync_lock_test_and_set((ptr), (value)))
#define AWD_ATOMIC_CMP_AND_SWAP(ptr, comp, value)   (__sync_bool_compare_and_swap((ptr), (comp), (value)))

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

typedef enum AwdWatchdogType {
    AWD_WATCHDOG_TYPE_THREAD = 0,
    AWD_WATCHDOG_TYPE_MAX,
} AwdWatchdogType;

#define DEFINE_THREAD_WATCHDOG(name)        static __thread AwdHandle name = -1
#define WATCHDOG_TYPE_BIT 16U
#define DEFINE_THREAD_WATCHDOG_ID(moduleId)  \
    ((uint32_t)moduleId) | ((uint32_t)1U << WATCHDOG_TYPE_BIT) | ((uint32_t)AWD_WATCHDOG_TYPE_THREAD)

/*
 * @brief       Create thread watchdog
 * @param [in]  dogId:    dog id get from DEFINE_THREAD_WATCHDOG_ID(moduleId)
 * @param [in]  timeout:  watchdog timeout, s
 * @param [in]  callback: watchdog callback function, will be called when timeout
 * @return      watchdog handle, AWD_INVALID_HANDLE for failure
 */
AWD_EXPORT AwdHandle AwdCreateThreadWatchdog(uint32_t dogId, uint32_t timeout, AwatchdogCallbackFunc callback);

/*
 * @brief       Destroy thread watchdog. if not called, watch dog will be destroyed when thread is detected no exist.
 * @param [in]  handle:   watchdog handle
 * @return      NA
 */
AWD_EXPORT void AwdDestroyThreadWatchdog(AwdHandle handle);

/*
 * @brief       start watchdog
 * @param [in]  handle:   watchdog handle
 * @return      AwdStatus
 */
static inline AwdStatus AwdStartThreadWatchdog(const AwdHandle handle)
{
    if (handle == AWD_INVALID_HANDLE) {
        return AWD_FAILURE;
    }
    AwdThreadWatchdog *dog = (AwdThreadWatchdog *)handle;
    AWD_ATOMIC_TEST_AND_SET(&dog->runCount, 0);
    AWD_ATOMIC_TEST_AND_SET(&dog->startCount, AWD_STATUS_STARTED);
    return AWD_SUCCESS;
}

/*
 * @brief       feed watchdog
 * @param [in]  handle:   watchdog handle
 * @return      AwdStatus
 */
static inline AwdStatus AwdFeedThreadWatchdog(const AwdHandle handle)
{
    if (handle == AWD_INVALID_HANDLE) {
        return AWD_FAILURE;
    }
    AwdThreadWatchdog *dog = (AwdThreadWatchdog *)handle;
    AWD_ATOMIC_TEST_AND_SET(&dog->startCount, AWD_ATOMIC_FETCH_AND_ADD(&dog->runCount, 0));
    return AWD_SUCCESS;
}

/*
 * @brief       stop watchdog
 * @param [in]  handle:   watchdog handle
 * @return      AwdStatus
 */
static inline AwdStatus AwdStopThreadWatchdog(const AwdHandle handle)
{
    if (handle == AWD_INVALID_HANDLE) {
        return AWD_FAILURE;
    }
    AwdThreadWatchdog *dog = (AwdThreadWatchdog *)handle;
    AWD_ATOMIC_TEST_AND_SET(&dog->startCount, AWD_STATUS_INIT);
    return AWD_SUCCESS;
}

#ifdef __cplusplus
}
#endif // __cplusplus

#endif