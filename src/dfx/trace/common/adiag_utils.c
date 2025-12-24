/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "adiag_utils.h"
#include <stdbool.h>
#include "adiag_print.h"
#include "adiag_types.h"
#include "mmpa_api.h"
#include "adiag_utils.h"

#define TIME_MS_TO_US       1000U
#define MAX_QUICK_SORT_LEN  1024

void *AdiagMalloc(size_t size)
{
    ADIAG_CHK_EXPR_ACTION(size == 0, return NULL, "size is 0.");
    void *ptr = malloc(size);
    if (ptr == NULL) {
        ADIAG_ERR("malloc failed, size=%zu bytes.", size);
        return NULL;
    }
    (void)memset_s(ptr, size, 0, size);
    return ptr;
}

void AdiagFree(void *ptr)
{
    if (ptr != NULL) {
        free(ptr);
    }
}

int32_t AdiagGetErrorCode(void)
{
    return mmGetErrorCode();
}

AdiagStatus AdiagStrToInt(const char *str, int32_t *num)
{
    if ((str == NULL) || (num == NULL)) {
        return ADIAG_FAILURE;
    }

    errno = 0;
    char *endPtr = NULL;
    const int32_t numberBase = 10;
    int64_t ret = strtol(str, &endPtr, numberBase);
    AdiagStatus error = ADIAG_SUCCESS;
    if (((const char *)endPtr == str) || (*endPtr != '\0')) {
        error = ADIAG_FAILURE;
    } else if (((ret == LONG_MIN) || (ret == LONG_MAX)) && (errno == ERANGE)) {
        error = ADIAG_FAILURE;
    } else if (ret <= INT32_MAX) {
        *num = (int32_t)ret;
    } else {
        ;
    }
    return error;
}

/**
 * @brief       get cycle counter
 * @return      cpu cycles
 */
uint64_t GetCpuCycleCounter(void)
{
    uint64_t cycles;
#ifdef CPU_CYCLE_NO_SUPPORT
    cycles = 0; // just for tiny compile(without mrrc), will not be executed when running
#else
#if defined(__aarch64__)
    asm volatile("mrs %0, cntvct_el0" : "=r" (cycles));
#elif defined(__x86_64__)
    const int uint32Bits = 32;  // 32 is uint bit count
    uint32_t hi = 0;
    uint32_t lo = 0;
    __asm__ __volatile__ ("rdtsc" : "=a"(lo), "=d"(hi));
    cycles = ((uint64_t)lo) | (((uint64_t)hi) << uint32Bits);
#elif defined(__arm__)
    const int uint32Bits = 32;  // 32 is uint bit count
    uint32_t hi = 0;
    uint32_t lo = 0;
    asm volatile("mrrc p15, 1, %0, %1, c14" : "=r"(lo), "=r"(hi));
    cycles = ((uint64_t)lo) | (((uint64_t)hi) << uint32Bits);
#else
    cycles = 0;
#endif
#endif // CPU_CYCLE_NO_SUPPORT
    return cycles;
}

/**
 * @brief       get real time
 * @return      real time, ns
 */
uint64_t GetRealTime(void)
{
    struct timespec now = {0, 0};
    (void)clock_gettime(CLOCK_REALTIME, &now);
    return ((uint64_t)now.tv_sec * SEC_TO_NS) + (uint64_t)now.tv_nsec;
}

/**
 * @brief       get monotonic time, absolute time, which cannot be changed
 * @return      monotonic time, ns
 */
uint64_t GetMonotonicTime(void)
{
    struct timespec now = {0, 0};
    (void)clock_gettime(CLOCK_MONOTONIC_RAW, &now);
    return ((uint64_t)now.tv_sec * SEC_TO_NS) + (uint64_t)now.tv_nsec;
}

/**
 * @brief       get cpu frequency
 * @return      cpu frequency, kHz
 */
uint64_t GetCpuFrequency(void)
{
    static uint64_t freq = UINT64_MAX;
    if (freq == UINT64_MAX) {
        uint64_t startTime = GetMonotonicTime();
        uint64_t startCycle = GetCpuCycleCounter();
        (void)usleep(TIME_MS_TO_US); // sleep 1ms
        uint64_t endCycle = GetCpuCycleCounter();
        uint64_t endTime = GetMonotonicTime();
        freq = (endCycle - startCycle) * FREQ_GHZ_TO_KHZ / (endTime - startTime);
    }
    return freq;
}

/**
 * @brief       get nearest power of 2, which is bigger than n
 * @param [in]  n:            original number
 * @return      power of 2, bigger than n, eg, return 1024 for 1023
 */
uint32_t GetNearestPowerOfTwo(uint32_t n)
{
   uint32_t num = n - 1U;
   uint32_t i = num;
   while (i > 0) {
       num |= i;
       i >>= 1U;
   }
   return num + 1U;
}

/**
 * @brief           swap the values of two integers
 * @param [in/out]  a:      pointer to the first integer to swap
 * @param [in/out]  b:      pointer to the second integer to swap
 */
static void AdiagSwap(int32_t *a, int32_t *b)
{
    int32_t temp = *a;
    *a = *b;
    *b = temp;
}

/**
 * @brief           partition an array
 * @param [in/out]  arr:        the array to be partitioned
 * @param [in]      low:        the starting index of the array
 * @param [in]      high:       the ending index of the array
 * @return          the index of the partition point
 */
static int32_t AdiagPartition(int32_t arr[], int32_t low, int32_t high)
{
    int32_t pivot = arr[high];
    int32_t i = (low - 1);

    for (int32_t j = low; j <= high - 1; j++) {
        if (arr[j] <= pivot) {
            i++;
            AdiagSwap(&arr[i], &arr[j]);
        }
    }
    AdiagSwap(&arr[i + 1], &arr[high]);
    return (i + 1);
}

/**
 * @brief           quicksort an array, the size of the array cannot exceed MAX_QUICK_SORT_LEN
 * @param [in/out]  arr:        the array to be sorted
 * @param [in]      low:        the starting index of the array
 * @param [in]      high:       the ending index of the array
 */
void AdiagQuickSort(int32_t arr[], int32_t low, int32_t high)
{
    int32_t len = high - low + 1;
    if (len <= 1 || len > MAX_QUICK_SORT_LEN) {
        return;
    }
    int32_t tmpHigh = high;
    int32_t tmpLow = low;
    int32_t stack[MAX_QUICK_SORT_LEN + 2]; // add 2 to avoid stack overflow
    int32_t top = 0;
    stack[top] = low;
    top++;
    stack[top] = high;

    while ((top >= 0) && (top < MAX_QUICK_SORT_LEN)) {
        tmpHigh = stack[top];
        top--;
        tmpLow = stack[top];
        top--;

        int32_t pi = AdiagPartition(arr, tmpLow, tmpHigh);
        if (pi - 1 > tmpLow) {
            top++;
            stack[top] = tmpLow;
            top++;
            stack[top] = pi - 1;
        }

        if (pi + 1 < tmpHigh) {
            top++;
            stack[top] = pi + 1;
            top++;
            stack[top] = tmpHigh;
        }
    }
}