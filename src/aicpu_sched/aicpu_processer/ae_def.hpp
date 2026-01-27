/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef _AE_DEFINE_H_
#define _AE_DEFINE_H_

#include <unistd.h>
#include <sys/syscall.h>
#include "aicpu_engine.h"
#include "aicpu_engine_struct.h"
#include "aicpu_error_log_api.h"
#ifdef RUN_ON_AICPU
#include "aicpuprocess_weak_log.h"
#else
#define CCECPU 0
#endif

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#if defined(RUN_ON_AICPU) && defined(AE_PERF_LOG)
#include <sys/time.h>
#endif
#ifdef _AOSCORE_
#include <pthread.h>
#endif
namespace cce {
using char_t = char;

enum class AicpuOpErrorCode : uint32_t {
    AICPU_TASK_WATI_FLAG = 101U, // aicpu task wait flag
    AICPU_END_OF_SEQUENCE_FLAG = 201U, // aicpu end of sequence flag
    AICPU_TASK_ABORT = 301U, // ccl kernel task abort flag
    AICPU_SILENT_FAULT = 501U, // aicpu silent fault flag
    AICPU_DETECT_FAULT = 502U, // aicpu detect fault flag
    AICPU_DETECT_FAULT_NORAS = 503U, // aicpu detect fault flag no RAS
    AICPU_DETECT_LOW_BIT_FAULT = 504U, // aicpu detect low-bit fault flag
    AICPU_DETECT_LOW_BIT_FAULT_NORAS = 505U, // aicpu detect low-bit fault flag no RAS
    AICPU_KFC_PASSTHROUGH_START = 1000U, // aicpu will passthrough errcode to rts
    AICPU_KFC_PASSTHROUGH_END = 1099U
};

inline long GetTid()
{
    thread_local static long tid = syscall(__NR_gettid);
    return tid;
}

#ifdef __GNUC__
#define likely(X) __builtin_expect((static_cast<int64_t>(X)), 1L)
#define unlikely(X) __builtin_expect((static_cast<int64_t>(X)), 0L)
#else
#define likely(X) (X)
#define unlikely(X) (X)
#endif

#define AE_MODULE_ID CCECPU

#ifdef RUN_ON_AICPU

#define AE_ERR_LOG(id, fmt, args...)                                                                                \
    do {                                                                                                            \
        aicpu::RestoreErrorLog(&__FUNCTION__[0], __FILE__, __LINE__, cce::GetTid(), (fmt), ##args);                 \
        if (&DlogRecord != nullptr) {                                                                               \
            dlog_error(static_cast<int32_t>(AE_MODULE_ID), "[%s][tid:%ld][AICPU_PROCESSER] " fmt,                   \
                       &__FUNCTION__[0], cce::GetTid(), ##args);                                                    \
        }                                                                                                           \
    } while (0)

#define AE_WARN_LOG(id, fmt, args...)                                                                               \
    do {                                                                                                            \
        if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                              \
            dlog_warn(static_cast<int32_t>(AE_MODULE_ID), "[%s][tid:%ld][AICPU_PROCESSER] " fmt,                    \
                      &__FUNCTION__[0], cce::GetTid(), ##args);                                                     \
        }                                                                                                           \
    } while (0)

#define AE_INFO_LOG(id, fmt, args...)                                                                               \
    do {                                                                                                            \
        if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                              \
            dlog_info(static_cast<int32_t>(AE_MODULE_ID), "[%s][tid:%ld][AICPU_PROCESSER] " fmt,                    \
                      &__FUNCTION__[0], cce::GetTid(), ##args);                                                     \
        }                                                                                                           \
    } while (0)

#define AE_DEBUG_LOG(id, fmt, args...)                                                                              \
    do {                                                                                                            \
        if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                              \
            dlog_debug(static_cast<int32_t>(AE_MODULE_ID), "[%s][tid:%ld][AICPU_PROCESSER] " fmt,                   \
                       &__FUNCTION__[0], cce::GetTid(), ##args);                                                    \
        }                                                                                                           \
    } while (0)

#define AE_RUN_INFO_LOG(id, fmt, args...)                                                                           \
    do {                                                                                                            \
        if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                              \
            dlog_info(static_cast<int32_t>(static_cast<uint32_t>(AE_MODULE_ID) |                                    \
                      static_cast<uint32_t>(RUN_LOG_MASK)), "[%s][tid:%ld][AICPU_PROCESSER] " fmt,                  \
                      &__FUNCTION__[0], cce::GetTid(), ##args);                                                     \
        }                                                                                                           \
    } while (0)

#define AE_RUN_WARN_LOG(id, fmt, args...)                                                                           \
    do {                                                                                                            \
        aicpu::RestoreErrorLog(&__FUNCTION__[0], __FILE__, __LINE__, cce::GetTid(), (fmt), ##args);                 \
        if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                              \
            dlog_warn(static_cast<int32_t>(static_cast<uint32_t>(AE_MODULE_ID) |                                    \
                      static_cast<uint32_t>(RUN_LOG_MASK)), "[%s][tid:%ld][AICPU_PROCESSER] " fmt,                  \
                      &__FUNCTION__[0], cce::GetTid(), ##args);                                                     \
        }                                                                                                           \
    } while (0)

#define AE_MEMORY_LOG(id, fmt, args...)                                                                             \
    do {                                                                                                            \
        if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                              \
            dlog_info(static_cast<int32_t>(AE_MODULE_ID), "[%s][tid:%ld][AICPU_PROCESSER] " fmt,                    \
                      &__FUNCTION__[0], cce::GetTid(), ##args);                                                     \
        }                                                                                                           \
    } while (0)

#else
#define AE_ERR_LOG(id, fmt, args...)  printf("[ERROR] [%s:%d][AICPU_PROCESSER] " fmt "\n", __FILE__, __LINE__, ##args)
#define AE_WARN_LOG(id, fmt, args...)  printf("[ERROR] [%s:%d][AICPU_PROCESSER] " fmt "\n", __FILE__, __LINE__, ##args)
#define AE_INFO_LOG(id, fmt, args...) printf("[INFO] [%s:%d][AICPU_PROCESSER] " fmt "\n", __FILE__, __LINE__, ##args)
#define AE_DEBUG_LOG(id, fmt, args...) printf("[DEBUG] [%s:%d][AICPU_PROCESSER] " fmt "\n", __FILE__, __LINE__, ##args)
#define AE_MEMORY_LOG(id, fmt, args...) printf("[INFO] [%s:%d][AICPU_PROCESSER] " fmt "\n", __FILE__, __LINE__, ##args)
#define AE_RUN_INFO_LOG(id, fmt, args...) \
    printf("[INFO] [%s:%d][AICPU_PROCESSER] " fmt "\n", __FILE__, __LINE__, ##args)
#define AE_RUN_WARN_LOG(id, fmt, args...) \
    printf("[WARN] [%s:%d][AICPU_PROCESSER] " fmt "\n", __FILE__, __LINE__, ##args)
#endif

// perf log feature
#if defined(RUN_ON_AICPU)&&defined(AE_PERF_LOG)
#define FUNC_PROFILE_START \
    struct timeval ts; \
    (void)gettimeofday(&ts, nullptr); \
    const uint64_t startUsec = (static_cast<uint64_t>(ts.tv_sec) * 1000000LU) + static_cast<uint64_t>(ts.tv_usec);

#define FUNC_PROFILE_END \
    (void)gettimeofday(&ts, nullptr); \
    const uint64_t endUsec = (static_cast<uint64_t>(ts.tv_sec) * 1000000LU)  + static_cast<uint64_t>(ts.tv_usec); \
    const uint64_t costUsec = endUsec - startUsec; \
    AE_INFO_LOG(AE_MODULE_ID, "[PERF] start=%lu, end=%lu, use=%lu us\n", \
        startUsec, endUsec, costUsec);
#else
    #define FUNC_PROFILE_START
    #define FUNC_PROFILE_END
#endif

using tAERwLock = pthread_rwlock_t;
#define AE_RW_LOCK_RD_LOCK(lock) (void)pthread_rwlock_rdlock(lock)
#define AE_RW_LOCK_WR_LOCK(lock) (void)pthread_rwlock_wrlock(lock)
#define AE_RW_LOCK_UN_LOCK(lock) (void)pthread_rwlock_unlock(lock)
#define AE_RW_LOCK_DESTROY(lock) (void)pthread_rwlock_destroy(lock)

#define AE_SINGLETON_CREAT(CLASS) do {\
    mtx_.lock();\
    if (instance_ != nullptr)\
    {\
        mtx_.unlock();\
        return instance_;\
    }\
    else\
    {\
        if (instance_ == nullptr)\
        {\
            instance_ = new(std::nothrow) CLASS();\
            if(instance_ == nullptr)\
            {\
                mtx_.unlock();\
                return nullptr;\
            }\
            (void)instance_->Init(); \
        }\
        mtx_.unlock();\
    \
        return instance_;\
    }\
}while(0)

#define AE_SINGLETON_DESTROY() do {\
    mtx_.lock();\
    if (instance_ == nullptr)\
    {\
        mtx_.unlock();\
        return;\
    }\
    delete instance_;\
    instance_ = nullptr;\
    mtx_.unlock();\
    \
}while(0)

}
#endif
