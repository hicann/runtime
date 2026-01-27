/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_SCHEDULE_BQS_LOG_H
#define QUEUE_SCHEDULE_BQS_LOG_H

#include <unistd.h>
#include <cstdint>
#include <cstdio>
#include <string>
#include <memory>
#include <sys/syscall.h>
#include "bqs_weak_log.h"
#include "common/type_def.h"

namespace bqs {
enum class QsLogFuncId : uint32_t {
    FUNC_CHECKLOGLEVEL = 0,
    FUNC_DLOGRECORD = 1,
    FUNC_DLOGSETLEVEL = 2,
    FUNC_DLOGSETATTR = 3,
    FUNC_MAXID = 4
};

inline const int64_t GetTid()
{
    thread_local static const int64_t BQS_TID = syscall(__NR_gettid);
    return BQS_TID;
}

class HostQsLog {
public:
    static HostQsLog &GetInstance();
    void *OpenLogSo() const;
    void *OpenLogSoOne(std::string ascendAicpuPath, const char *soName) const;
    void LogPrintNormal(const int32_t moduleId, const int32_t level, const char *fmt, ...) const;
    void LogPrintError(const int32_t moduleId, const char *fmt, ...) const;
    void DlogSetLevel(const int32_t logLevel, const int32_t eventLevel) const;
    void DlogSetAttr(const LogAttr logAttrInfo) const;
    bool CheckLogLevelHost(const int32_t moduleId, const int32_t logLevel) const;
    bool CheckLogLevel(const int32_t moduleId, const int32_t logLevel) const;

private:
    HostQsLog() = default;
    ~HostQsLog() = default;
};

#ifdef RUN_ON_AICPU
#ifdef QS_DEPLOY_ON_HOST
#define BQS_LOG_DEBUG(fmt, ...)                                                                                          \
    do {                                                                                                                 \
        bqs::HostQsLog::GetInstance().LogPrintNormal(static_cast<int32_t>(AICPU), DLOG_DEBUG,                            \
                                                     "[%s:%d][%s][tid:%llu] " fmt, __FILE__, __LINE__, &__FUNCTION__[0], \
                                                     bqs::GetTid(), ##__VA_ARGS__);                                      \
    } while (false)

#define BQS_LOG_INFO(fmt, ...)                                                                                           \
    do {                                                                                                                 \
        bqs::HostQsLog::GetInstance().LogPrintNormal(static_cast<int32_t>(AICPU), DLOG_INFO,                             \
                                                     "[%s:%d][%s][tid:%llu] " fmt, __FILE__, __LINE__, &__FUNCTION__[0], \
                                                     bqs::GetTid(), ##__VA_ARGS__);                                      \
    } while (false)

#define BQS_LOG_WARN(fmt, ...)                                                                                           \
    do {                                                                                                                 \
        bqs::HostQsLog::GetInstance().LogPrintNormal(static_cast<int32_t>(AICPU), DLOG_WARN,                             \
                                                     "[%s:%d][%s][tid:%llu] " fmt, __FILE__, __LINE__, &__FUNCTION__[0], \
                                                     bqs::GetTid(), ##__VA_ARGS__);                                      \
    } while (false)

#define BQS_LOG_ERROR(fmt, ...)                                                                                          \
    do {                                                                                                                 \
        bqs::HostQsLog::GetInstance().LogPrintError(static_cast<int32_t>(AICPU),                                         \
                                                    "[%s:%d][%s][tid:%llu] " fmt, __FILE__, __LINE__, &__FUNCTION__[0],  \
                                                    bqs::GetTid(), ##__VA_ARGS__);                                       \
    } while (false)

#define BQS_LOG_RUN_INFO(fmt, ...)                                                                                       \
    do {                                                                                                                 \
        bqs::HostQsLog::GetInstance().LogPrintNormal(static_cast<int32_t>(static_cast<uint32_t>(AICPU) |                 \
                                                    static_cast<uint32_t>(RUN_LOG_MASK)), DLOG_INFO,                     \
                                                    "[%s:%d][%s][tid:%llu] " fmt, __FILE__, __LINE__, &__FUNCTION__[0],  \
                                                    bqs::GetTid(), ##__VA_ARGS__);                                       \
    } while (false)

#define BQS_LOG_RUN_WARN(fmt, ...)                                                                                       \
    do {                                                                                                                 \
        bqs::HostQsLog::GetInstance().LogPrintNormal(static_cast<int32_t>(static_cast<uint32_t>(AICPU) |                 \
                                                    static_cast<uint32_t>(RUN_LOG_MASK)), DLOG_WARN,                     \
                                                    "[%s:%d][%s][tid:%llu] " fmt, __FILE__, __LINE__, &__FUNCTION__[0],  \
                                                    bqs::GetTid(), ##__VA_ARGS__);                                       \
    } while (false)
#else
#define BQS_LOG_DEBUG(fmt, ...)                                                                                          \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                                       \
        dlog_debug(static_cast<int32_t>(AICPU), "[%s][tid:%llu] " fmt, &__FUNCTION__[0], bqs::GetTid(), ##__VA_ARGS__);  \
    }

#define BQS_LOG_INFO(fmt, ...)                                                                                           \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                                       \
        dlog_info(static_cast<int32_t>(AICPU), "[%s][tid:%llu] " fmt, &__FUNCTION__[0], bqs::GetTid(), ##__VA_ARGS__);   \
    }

#define BQS_LOG_WARN(fmt, ...)                                                                                           \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                                       \
        dlog_warn(static_cast<int32_t>(AICPU), "[%s][tid:%llu] " fmt, &__FUNCTION__[0], bqs::GetTid(), ##__VA_ARGS__);   \
    }

#define BQS_LOG_ERROR(fmt, ...)                                                                                          \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                                       \
        dlog_error(static_cast<int32_t>(AICPU), "[%s][tid:%llu] " fmt, &__FUNCTION__[0], bqs::GetTid(), ##__VA_ARGS__);  \
    }

#define BQS_LOG_RUN_INFO(fmt, ...)                                                                                       \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                                       \
        dlog_info(static_cast<int32_t>(static_cast<uint32_t>(AICPU) | static_cast<uint32_t>(RUN_LOG_MASK)),              \
                  "[%s][tid:%llu] " fmt, &__FUNCTION__[0], bqs::GetTid(), ##__VA_ARGS__);                                \
    }

#define BQS_LOG_RUN_WARN(fmt, ...)                                                                                       \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                                       \
        dlog_warn(static_cast<int32_t>(static_cast<uint32_t>(AICPU) | static_cast<uint32_t>(RUN_LOG_MASK)),              \
                  "[%s][tid:%llu] " fmt, &__FUNCTION__[0], bqs::GetTid(), ##__VA_ARGS__);                                \
    }
#endif
#else
#define BQS_LOG_DEBUG(fmt, ...)                          \
    printf("[DEBUG] [%s][%s:%d][tid:%lu]:" fmt "\n",     \
        __FILE__,                                        \
        &__FUNCTION__[0],                                \
        __LINE__,                                        \
        bqs::GetTid(),                                   \
        ##__VA_ARGS__)
#define BQS_LOG_INFO(fmt, ...)                          \
    printf("[INFO] [%s][%s:%d][tid:%lu]:" fmt "\n",     \
        __FILE__,                                       \
        &__FUNCTION__[0],                               \
        __LINE__,                                       \
        bqs::GetTid(),                                  \
        ##__VA_ARGS__)
#define BQS_LOG_WARN(fmt, ...)                          \
    printf("[WARN] [%s][%s:%d][tid:%lu]:" fmt "\n",     \
        __FILE__,                                       \
        &__FUNCTION__[0],                               \
        __LINE__,                                       \
        bqs::GetTid(),                                  \
        ##__VA_ARGS__)
#define BQS_LOG_ERROR(fmt, ...)                          \
    printf("[ERROR] [%s][%s:%d][tid:%lu]:" fmt "\n",     \
        __FILE__,                                        \
        &__FUNCTION__[0],                                \
        __LINE__,                                        \
        bqs::GetTid(),                                   \
        ##__VA_ARGS__)
#define BQS_LOG_RUN_INFO(fmt, ...)                       \
    printf("[INFO] [%s][%s:%d][tid:%lu]:" fmt "\n",      \
        __FILE__,                                        \
        &__FUNCTION__[0],                                \
        __LINE__,                                        \
        bqs::GetTid(),                                   \
        ##__VA_ARGS__)
#define BQS_LOG_RUN_WARN(fmt, ...)                       \
    printf("[INFO] [%s][%s:%d][tid:%lu]:" fmt "\n",      \
        __FILE__,                                        \
        &__FUNCTION__[0],                                \
        __LINE__,                                        \
        bqs::GetTid(),                                   \
        ##__VA_ARGS__)
#endif
#define DGW_LOG_DEBUG BQS_LOG_DEBUG
#define DGW_LOG_INFO BQS_LOG_INFO
#define DGW_LOG_WARN BQS_LOG_WARN
#define DGW_LOG_ERROR BQS_LOG_ERROR
#define DGW_LOG_RUN_INFO BQS_LOG_RUN_INFO
#define DGW_LOG_RUN_WARN BQS_LOG_RUN_WARN
// cond为真时，进行后续的log打印
#define BQS_LOG_ERROR_WHEN(cond, log, ...)  \
    if (cond) {                             \
        BQS_LOG_ERROR(log, ##__VA_ARGS__);  \
    }

// 注意: 该宏第一项Condition是期望为真，否则将进行后续的返回和日志记录
#define DGW_CHECK(condition, retValue, log, ...)                                \
    do {                                                                        \
        const bool cond = (condition);                                          \
        if (!cond) {                                                            \
            DGW_LOG_ERROR(log, ##__VA_ARGS__);                                    \
            return (retValue);                                                  \
        }                                                                       \
    } while (false)

// 注意: 该宏第一项Condition是期望为真，否则将进行后续的返回和日志记录
#define DGW_CHECK_RET_VOID(condition, log, ...)                                 \
    do {                                                                        \
        const bool cond = (condition);                                          \
        if (!cond) {                                                            \
            DGW_LOG_ERROR(log, ##__VA_ARGS__);                                    \
            return;                                                             \
        }                                                                       \
    } while (false)

/**
 * check two uint32 integer adding weather overflow. execute adding when not overflow.
 * @param onceOverFlow weather overflow in history calculation:
 *                     true: overflow in history or current calculation
 *                     false: never overflow in history or current calculation
 */
inline void BqsCheckAssign32UAdd(const uint32_t para1,
    const uint32_t para2, uint32_t &result, bool &onceOverFlow)
{
    if (onceOverFlow) {
        return;
    }
    if ((UINT32_MAX - para1) < para2) {
        BQS_LOG_ERROR("Integer reversed para1: %u + para2: %u", para1, para2);
        onceOverFlow = true;
        return;
    }
    result = para1 + para2;
    return;
}

/**
 * check two uint32 integer multiplication weather overflow. execute multiplication when not overflow.
 * @param onceOverFlow weather overflow in history calculation:
 *                     true: overflow in history or current calculation
 *                     false: never overflow in history or current calculation
 */
inline void BqsCheckAssign32UMuti(const uint32_t para1,
    const uint32_t para2, uint32_t &result, bool &onceOverFlow)
{
    if (onceOverFlow) {
        return;
    }
    if ((para1 != 0U) && (para2 != 0U) && ((UINT32_MAX / para1) < para2)) {
        BQS_LOG_ERROR("Integer reversed para1: %u * para2: %u", para1, para2);
        onceOverFlow = true;
        return;
    }
    result = para1 * para2;
    return;
}

inline uint64_t BqsCheckAssign64UAdd(const uint64_t para1, const uint64_t para2, bool &onceOverFlow)
{
    if (onceOverFlow) {
        return 0U;
    }
    if ((UINT64_MAX - para1) < para2) {
        BQS_LOG_ERROR("Integer reversed para1: %lu + para2: %lu", para1, para2);
        onceOverFlow = true;
        return 0U;
    }
    return para1 + para2;
}

#define BQS_LOG_WARN_HOST(fmt, ...)                                                                                      \
    do {                                                                                                                 \
        bqs::HostQsLog::GetInstance().LogPrintNormal(static_cast<int32_t>(AICPU), DLOG_WARN,                             \
                                                     "[%s:%d][%s][tid:%llu] " fmt, __FILE__, __LINE__, &__FUNCTION__[0], \
                                                     bqs::GetTid(), ##__VA_ARGS__);                                      \
    } while (false)
}

#endif  // QUEUE_SCHEDULE_BQS_LOG_H
