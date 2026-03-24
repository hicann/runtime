/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_TPRT_BASE_HPP__
#define __CCE_TPRT_BASE_HPP__

#include <atomic>
#include <memory>
#include <cinttypes>
#include <mutex>
#include <unordered_map>
#include <functional>
#include "toolchain/slog.h"
#include "toolchain/plog.h"
#include "tprt_log.hpp"
#include "tprt_error_code.h"
#include "mmpa/mmpa_api.h"

namespace cce {
namespace tprt {

enum TprtLogLevel : uint8_t {
    TPRT_LOG_ERROR = 0U,
    TPRT_LOG_WARNING = 1U,
    TPRT_LOG_EVENT = 2U,
    TPRT_LOG_INFO = 3U,
    TPRT_LOG_DEBUG = 4U,
    TPRT_LOG_LEVEL_MAX = 5U
};

#define TPRT_EVENT_LOG_MASK (static_cast<uint32_t>(RUNTIME) | static_cast<uint32_t>(RUN_LOG_MASK))
#if (defined WIN32) || (defined CFG_DEV_PLATFORM_PC) || (defined CFG_VECTOR_CAST)
#define TPRT_LOG(level, format, ...)
#else
#define TPRT_LOG(level, format, ...) TPRT_LOG_##level(format, ##__VA_ARGS__)
#define TPRT_LOG_TPRT_LOG_EVENT(format, ...)                                                 \
    do {                                                                                 \
        DlogSub(static_cast<int32_t>(TPRT_EVENT_LOG_MASK), "TPRT", DLOG_INFO, "TID[%d] %s: " format "\n", mmGetTid(), &__func__[0], ##__VA_ARGS__); \
    } while (false)

#define TPRT_LOG_TPRT_LOG_ERROR(format, ...)                                                            \
    do {                                                                                            \
        cce::tprt::RecordErrorLog(__FILE__, __LINE__, &__func__[0], format "\n", ##__VA_ARGS__); \
    } while (false)

#define TPRT_LOG_TPRT_LOG_WARNING(format, ...)                                               \
    do {                                                                                 \
        DlogSub(static_cast<int32_t>(RUNTIME), "TPRT", DLOG_WARN, "TID[%d] %s: " format "\n", mmGetTid(), &__func__[0], ##__VA_ARGS__);  \
    } while (false)

#define TPRT_LOG_TPRT_LOG_INFO(format, ...)                                                  \
    do {                                                                                 \
        DlogSub(static_cast<int32_t>(RUNTIME), "TPRT", DLOG_INFO, "TID[%d] %s: " format "\n", mmGetTid(), &__func__[0], ##__VA_ARGS__); \
    } while (false)

#define TPRT_LOG_TPRT_LOG_DEBUG(format, ...)                                                                       \
    do {                                                                                                       \
        if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 1) {                                   \
            cce::tprt::RecordLog(DLOG_DEBUG, __FILE__, __LINE__, &__func__[0], format "\n", ##__VA_ARGS__); \
        }                                                                                                      \
    } while (false)

#endif

#define DELETE_O(p)  \
    if ((p) != nullptr) { \
        delete (p);    \
        (p) = nullptr;    \
    }

template<typename TI>
inline uint64_t RtPtrToValue(const TI ptr)
{
    return static_cast<uint64_t>(reinterpret_cast<uintptr_t>(ptr));
}

template<typename TO>
inline TO TprtValueToPtr(const uint64_t value)
{
    return reinterpret_cast<TO>(static_cast<uintptr_t>(value));
}

template<typename TO, typename TI>
inline TO TprtPtrToPtr(const TI ptr)
{
    return reinterpret_cast<TO>(ptr);
}

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
}
}
#endif // __CCE_TPRT_BASE_HPP__
