/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_BASE_HPP__
#define __CCE_RUNTIME_BASE_HPP__

#include <atomic>
#include <memory>
#include <cinttypes>
#include <sstream>
#include "soc_define.hpp"
#include "mmpa/mmpa_api.h"
#include "osal.hpp"
#include "error_codes/rt_error_codes.h"
#include "runtime/base.h"
#include "runtime/config.h"
#include "rts.h"
#include "rts_dqs.h"
#include "dlog_pub.h"
#include "plog.h"
#include "atrace_api.h"
#include "spec/base_info.hpp"
#include "common/internal_error_define.hpp"
#if (!defined(CFG_DEV_PLATFORM_PC))
#include "error_manager.h"
#endif
#include "args/args_inner.h"
#include "rt_log.h"
#include "config_define.hpp"

extern "C" {
int __attribute((weak)) AtraceReportStart(int32_t devId);
void __attribute((weak)) AtraceReportStop(int32_t devId);
};

namespace cce {
namespace runtime {
#ifdef BUILD_VERSION_ENG
#define RT_LOG_LEVEL        RT_LOG_WARNING
#elif defined(BUILD_VERSION_USER)
#define RT_LOG_LEVEL        RT_LOG_WARNING
#elif defined(BUILD_VERSION_PERF)
#define RT_LOG_LEVEL        RT_LOG_ERROR
#else
#define RT_LOG_LEVEL        RT_LOG_INFO
#endif

#ifndef UNUSED
#define UNUSED(expr) do { \
    (void)(expr); \
} while (false)
#endif

#ifndef F_DESC
#define F_DESC(x)            1
#endif

#if (defined CFG_DEV_PLATFORM_PC)

#define RT_LOG(level, format, ...) RT_LOG_##level(format, ##__VA_ARGS__)
#define RT_EVENT_LOG_MASK (static_cast<uint32_t>(RUNTIME) | static_cast<uint32_t>(RUN_LOG_MASK))
#define RT_LOG_RT_LOG_EVENT(format, ...)                                                 \
    do {                                                                                 \
        dlog_info(static_cast<int32_t>(RT_EVENT_LOG_MASK), " %d %s: " format "\n", mmGetTid(), &__func__[0], ##__VA_ARGS__); \
    } while (false)

#define RT_LOG_RT_LOG_WARNING_EVENT(format, ...)                                                  \
    do {                                                                                  \
        dlog_warn(static_cast<int32_t>(RT_EVENT_LOG_MASK), " %d %s: " format "\n", mmGetTid(), &__func__[0], ##__VA_ARGS__); \
    } while (false)

#define RT_LOG_RT_LOG_ERROR(format, ...)                                                            \
    do {                                                                                            \
        cce::runtime::RecordErrorLog(__FILE__, __LINE__, &__func__[0], format "\n", ##__VA_ARGS__); \
    } while (false)

#define RT_LOG_RT_LOG_WARNING(format, ...)                                               \
    do {                                                                                 \
        dlog_warn(static_cast<int32_t>(RUNTIME), " %d %s: " format "\n", mmGetTid(), &__func__[0], ##__VA_ARGS__);  \
    } while (false)

#define RT_LOG_RT_LOG_INFO(format, ...)                                                  \
    do {                                                                                 \
        dlog_info(static_cast<int32_t>(RUNTIME), " %d %s: " format "\n", mmGetTid(), &__func__[0], ##__VA_ARGS__); \
    } while (false)

#define RT_LOG_RT_LOG_DEBUG(format, ...)                                                                       \
    do {                                                                                                       \
        if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 1) {                                   \
            cce::runtime::RecordLog(DLOG_DEBUG, __FILE__, __LINE__, &__func__[0], format "\n", ##__VA_ARGS__); \
        }                                                                                                      \
    } while (false)

#ifndef REPORT_INNER_ERROR
#define REPORT_INNER_ERROR(level, format, ...)
#endif
#define RT_LOG_INNER_MSG(level, format, ...) \
        RT_LOG(level, format, ##__VA_ARGS__);
#define RT_LOG_CALL_MSG(model_type, format, ...) \
        RT_LOG(RT_LOG_ERROR, format, ##__VA_ARGS__);
#define RT_LOG_OUTER_MSG(error_code, format, ...) \
        RT_LOG(RT_LOG_ERROR, format, ##__VA_ARGS__);
#define RT_LOG_OUTER_MSG_IMPL(error_code, ...)
#define RT_LOG_OUTER_MSG_WITH_FUNC(error_code, ...)
#define RT_LOG_OUTER_MSG_INVALID_PARAM(parm, ...)
#define RT_LOG_FLUSH()
#define REPORT_INPUT_ERROR(error_code, key, value)

#elif (defined CFG_VECTOR_CAST)
#define RT_LOG(level, format, ...)
#define RT_LOG_STDOUT(level, format, ...)
#define RT_LOG_INNER_MSG(level, format, ...)
#define RT_LOG_CALL_MSG(model_type, format, ...)
#define RT_LOG_OUTER_MSG(error_code, format, ...)
#define RT_LOG_OUTER_MSG_IMPL(error_code, ...)
#define RT_LOG_OUTER_MSG_WITH_FUNC(error_code, ...)
#define RT_LOG_OUTER_MSG_INVALID_PARAM(parm, ...)
#define RT_LOG_FLUSH()
#else
#define RT_LOG(level, format, ...) RT_LOG_##level(format, ##__VA_ARGS__)

#define RT_EVENT_LOG_MASK (static_cast<uint32_t>(RUNTIME) | static_cast<uint32_t>(RUN_LOG_MASK))
#define RT_LOG_RT_LOG_EVENT(format, ...)                                                  \
    do {                                                                                  \
        dlog_info(static_cast<int32_t>(RT_EVENT_LOG_MASK), " %d %s: " format "\n", mmGetTid(), &__func__[0], ##__VA_ARGS__); \
    } while (false)

#define RT_LOG_RT_LOG_WARNING_EVENT(format, ...)                                                  \
    do {                                                                                  \
        dlog_warn(static_cast<int32_t>(RT_EVENT_LOG_MASK), " %d %s: " format "\n", mmGetTid(), &__func__[0], ##__VA_ARGS__); \
    } while (false)

#define RT_LOG_RT_LOG_ERROR(format, ...)                                                            \
    do {                                                                                            \
        cce::runtime::RecordErrorLog(__FILE__, __LINE__, &__func__[0], format "\n", ##__VA_ARGS__); \
    } while (false)

#define RT_LOG_RT_LOG_WARNING(format, ...)                                               \
    do {                                                                                 \
        dlog_warn(static_cast<int32_t>(RUNTIME), " %d %s: " format "\n", mmGetTid(), &__func__[0], ##__VA_ARGS__); \
    } while (false)

#define RT_LOG_RT_LOG_INFO(format, ...)                                                    \
    do {                                                                                   \
        dlog_info(static_cast<int32_t>(RUNTIME), " %d %s: " format "\n", mmGetTid(), &__func__[0], ##__VA_ARGS__);   \
    } while (false)

#define RT_LOG_RT_LOG_DEBUG(format, ...)                                                                       \
    do {                                                                                                       \
        if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 1) {                                   \
            cce::runtime::RecordLog(DLOG_DEBUG, __FILE__, __LINE__, &__func__[0], format "\n", ##__VA_ARGS__); \
        }                                                                                                      \
    } while (false)

#define RT_LOG_FLUSH() DlogFlush()

static constexpr const char_t *RT_ERR_MSG_INVALID_HEAD = "INVALID_HEAD";
static constexpr const char_t *RT_LOG_LEVEL_TO_ERR_MSG[RT_LOG_LEVEL_MAX] = {
    RT_INNER_ERROR, RT_INNER_WARNING, RT_ERR_MSG_INVALID_HEAD, RT_ERR_MSG_INVALID_HEAD, RT_ERR_MSG_INVALID_HEAD
};

static constexpr const char_t *RT_MODULE_TYPE_TO_ERR_MSG[ERR_MODULE_MAX] = {
    RT_AICPU_INNER_ERROR, RT_DRV_INNER_ERROR, RT_HCCL_INNER_ERROR, RT_GE_INNER_ERROR,
    RT_PROFILE_INNER_ERROR, RT_TBE_INNER_ERROR, RT_SYSTEM_INNER_ERROR, RT_INNER_ERROR,
    RT_FE_INNER_ERROR, RT_AICPU_TIMEOUT_ERROR, RT_INVALID_ARGUMENT_ERROR
};

// RT_LOG_INNER_MSG description:
// Used for print runtime inner error, need error_manager library.
// WARNING:
// This usually used to record RT_LOG_ERROR faults
// if you want to use RT_LOG_WARNING level, your changes need to be carefully reviewed
// Other level may cause an exception log
#define RT_LOG_INNER_MSG(level, format, ...) \
    do { \
        RT_LOG(level, format, ##__VA_ARGS__);                           \
        REPORT_INNER_ERROR(RT_LOG_LEVEL_TO_ERR_MSG[(level)], format, ##__VA_ARGS__);                 \
    } while (false)

// report other module error message by module type
#define RT_LOG_CALL_MSG(module_type, format, ...) \
    do { \
        RT_LOG(RT_LOG_ERROR, format, ##__VA_ARGS__);               \
        REPORT_CALL_ERROR(RT_MODULE_TYPE_TO_ERR_MSG[(module_type)], format, ##__VA_ARGS__);      \
    } while (false)

// report outer error message, such as invalid parameter
#define RT_LOG_OUTER_MSG(error_code, format, ...)                                                                    \
    do { \
        RT_LOG(RT_LOG_ERROR, format, ##__VA_ARGS__);                                                                 \
        std::vector<char> value_string(LIMIT_PER_MESSAGE, '\0');                                                     \
        if (error_message::FormatErrorMessage(value_string.data(), value_string.size(), format, ##__VA_ARGS__) > 0) {\
            ReportErrMsg((error_code), value_string);                                                                  \
        }                                                                                                            \
    } while (false)

constexpr const char* ErrorCodeToString(ErrorCode code) {
    switch (code) {
        case ErrorCode::EE1001:
            return "EE1001";
        case ErrorCode::EE1002:
            return "EE1002";
        case ErrorCode::EE1003:
            return "EE1003";
        case ErrorCode::EE1004:
            return "EE1004";
        case ErrorCode::EE1005:
            return "EE1005";
        case ErrorCode::EE1006:
            return "EE1006";
        case ErrorCode::EE1007:
            return "EE1007";
        case ErrorCode::EE1008:
            return "EE1008";
        case ErrorCode::EE1009:
            return "EE1009";
        case ErrorCode::EE1010:
            return "EE1010";
        case ErrorCode::EE1011:
            return "EE1011";
        case ErrorCode::EE2002:
            return "EE2002";
        default:
            return "UNKNOWN";
    }
}

template<class... Args>
void ErrorCodeProcess(ErrorCode errorCode, const char *file,
    const int32_t line, const char *func, Args&&... args)
{
#if (!defined(WIN32)) && (!defined(CFG_DEV_PLATFORM_PC))
    std::vector<std::string> values;
    if constexpr (sizeof...(Args) > 0) {
        values.reserve(sizeof...(Args));
        auto processArg = [&values](auto&& arg) {
            using T = std::decay_t<decltype(arg)>;
            if constexpr (std::is_arithmetic_v<T>) {
                values.emplace_back(std::to_string(arg));
            } else if constexpr (std::is_same_v<T, std::string>) {
                values.emplace_back(std::forward<decltype(arg)>(arg));
            } else if constexpr (std::is_convertible_v<T, const char*>) {
                const char* ptr = arg;
                values.emplace_back(ptr ? ptr : "");
            } else {
                std::ostringstream oss;
                oss << arg;
                values.emplace_back(oss.str());
            }
        };

        (processArg(std::forward<Args>(args)), ...);
    }
    ProcessErrorCodeImpl(errorCode, file, line, func, std::move(values));
    ErrorManager::GetInstance().ATCReportErrMessage(
        ErrorCodeToString(errorCode), 
        GetParamNames(errorCode), 
        std::move(values)
    );
#else
    (void)errorCode;
    (void)(sizeof...(args));
#endif
}

// EE1003错误码上报
#define RT_LOG_OUTER_MSG_INVALID_PARAM(parm, ...) \
    RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1003, (parm), #parm, ##__VA_ARGS__)
 
#define RT_LOG_OUTER_MSG_WITH_FUNC(error_code, ...) \
    RT_LOG_OUTER_MSG_IMPL((error_code), __func__, ##__VA_ARGS__)

// 由调用者保证传参个数和errmsg匹配
#define RT_LOG_OUTER_MSG_IMPL(error_code, ...)                                                               \
    do {                                                                                                     \
        ErrorCodeProcess((error_code), __FILE__, __LINE__, &__func__[0], ##__VA_ARGS__);                     \
    } while (false)
#endif

/******************************************/
/* Do not add new Marcos arbitrarily !    */
/* Use existed Marcos as much as possible */
/******************************************/
#define NULL_PTR_PROC_RETURN_ERROR(PTR, ERR, PROC) \
    if (unlikely((PTR) == nullptr)) { \
        PROC; \
        RT_LOG(RT_LOG_ERROR, #PTR " is NULL!");     \
        return (ERR); }
#define NULL_PTR_RETURN_NOLOG(PTR, ERRCODE) \
    if (unlikely((PTR) == nullptr)) { \
        return ERRCODE; }

#define NULL_PTR_RETURN_DIRECTLY(PTR) \
    if (unlikely((PTR) == nullptr)) { \
        RT_LOG(RT_LOG_ERROR, #PTR " is NULL!");     \
        return; }

#define NULL_PTR_RETURN(PTR, ERRCODE) \
    COND_RETURN_ERROR(((PTR) == nullptr), ERRCODE, #PTR " is NULL!")

#define ERROR_RETURN(ERRCODE, format, ...) \
    COND_RETURN_ERROR((ERRCODE) != RT_ERROR_NONE, ERRCODE, format, ##__VA_ARGS__)

#define ERROR_GOTO(ERRCODE, LABEL, format, ...) \
    COND_GOTO_ERROR((ERRCODE) != RT_ERROR_NONE, LABEL, ERRCODE, ERRCODE, format, ##__VA_ARGS__)

#define COND_RETURN_VOID(COND, format, ...) \
    COND_RETURN_((COND), , RT_LOG_ERROR, format, ##__VA_ARGS__)

#define COND_RETURN_VOID_WARN(COND, format, ...) \
    COND_RETURN_((COND), , RT_LOG_WARNING, format, ##__VA_ARGS__)

#define COND_RETURN_NORMAL(COND, format, ...) \
    COND_RETURN_((COND), , RT_LOG_INFO, format, ##__VA_ARGS__)

#define COND_RETURN_WITH_NOLOG(COND, ERRCODE) \
    COND_RETURN_WITH_NOLOG_((COND), ERRCODE)

#define COND_RETURN_ERROR(COND, ERRCODE, format, ...) \
    COND_RETURN_((COND), ERRCODE, RT_LOG_ERROR, format, ##__VA_ARGS__)

#define COND_RETURN_DEBUG(COND, ERRCODE, format, ...) \
    COND_RETURN_((COND), ERRCODE, RT_LOG_DEBUG, format, ##__VA_ARGS__)

#define COND_RETURN_WARN(COND, ERRCODE, format, ...) \
    COND_RETURN_((COND), ERRCODE, RT_LOG_WARNING, format, ##__VA_ARGS__)

#define COND_PROC_RETURN_ERROR(COND, ERRCODE, PROC, format, ...) \
    COND_PROC_RETURN_((COND), ERRCODE, PROC, RT_LOG_ERROR, format, ##__VA_ARGS__)

#define COND_PROC_RETURN_WARN(COND, ERRCODE, PROC, format, ...) \
    COND_PROC_RETURN_((COND), ERRCODE, PROC, RT_LOG_WARNING, format, ##__VA_ARGS__)

#define COND_RETURN_EVENT(COND, ERRCODE, format, ...) \
    COND_RETURN_((COND), ERRCODE, RT_LOG_EVENT, format, ##__VA_ARGS__)

#define COND_RETURN_INFO(COND, ERRCODE, format, ...) \
    COND_RETURN_((COND), ERRCODE, RT_LOG_INFO, format, ##__VA_ARGS__)

#define COND_GOTO_ERROR(COND, LABEL, ERROR, ERRCODE, format, ...) \
    COND_GOTO_WITH_ERRCODE_((COND), LABEL, ERROR, ERRCODE, RT_LOG_ERROR, format, ##__VA_ARGS__)

#define COND_LOG(COND, format, ...)                    \
    if (unlikely(COND)) {                      \
        RT_LOG(RT_LOG_WARNING, format, ##__VA_ARGS__); \
    }

#define COND_LOG_DEBUG(COND, format, ...)            \
    if (unlikely(COND)) {                    \
        RT_LOG(RT_LOG_DEBUG, format, ##__VA_ARGS__); \
    }

#define COND_LOG_ERROR(COND, format, ...)            \
    if (unlikely(COND)) {                    \
        RT_LOG(RT_LOG_ERROR, format, ##__VA_ARGS__); \
    }
#define COND_PROC(COND, PROC) \
    if (unlikely(COND)) { \
        PROC; \
    }
// Do NOT use this Marco directly
#define COND_RETURN_WITH_NOLOG_(COND, ERRCODE) \
    if ((COND)) {                              \
        return ERRCODE;                        \
    }
// Do NOT use this Marco directly
#define COND_RETURN_(COND, ERRCODE, LOGTYPE, format, ...) \
    if (unlikely(COND)) {                         \
        RT_LOG(LOGTYPE, format, ##__VA_ARGS__);           \
        return ERRCODE;                           \
    }

// Do NOT use this Marco directly
#define COND_PROC_RETURN_(COND, ERRCODE, PROC, LOGTYPE, format, ...) \
    if (unlikely(COND)) {                                    \
        RT_LOG(LOGTYPE, format, ##__VA_ARGS__);                      \
        PROC;                                                \
        return ERRCODE;                                      \
    }

// Do NOT use this Marco directly
#define COND_GOTO_WITH_ERRCODE_(COND, LABEL, ERROR, ERRCODE, LOGTYPE, format, ...) \
    if (unlikely(COND)) {                                                  \
        RT_LOG(LOGTYPE, format, ##__VA_ARGS__);                                    \
        ERROR = (ERRCODE);                                                 \
        goto LABEL;                                                        \
    }

// delete an object
#define DELETE_O(p)  \
    if ((p) != nullptr) { \
        delete (p);    \
        (p) = nullptr;    \
    }

// delete an array
#define DELETE_A(p)  \
    if ((p) != nullptr) { \
        delete[] (p);  \
        (p) = nullptr;    \
    }

using TDT_StatusType = uint32_t;

struct rtSocInfo_t final {
    rtSocType_t socType;
    rtChipType_t chipType;
    rtArchType_t archType;
    const char_t *socName; // Must be a constant string
};

struct RtDevInfo final {
    rtChipType_t chipType;
    rtArchType_t archType;
    RtPGVersion pgType;
    const char_t *socName;// Must be a constant string
};

// delete an ref obj
#define DELETE_R(p)                 \
    if (((p) != nullptr) && ((p)->DecRef())) { \
        delete (p);                   \
        (p) = nullptr;                   \
    }

static inline uint64_t GetWallUs()
{
    mmTimeval timeVal;
    mmGetTimeOfDay(&timeVal, nullptr);
    return timeVal.tv_sec * 1000000LL + timeVal.tv_usec;
}

#ifdef TEMP_PERFORMANCE
static inline long long GetThreadNs()
{
    mmTimespec timeSpec = mmGetTickCount();
    return timeSpec.tv_sec * 1000000000LL + timeSpec.tv_nsec;
}

#define TIMESTAMP_BEGIN(VAR)              \
    do {                                  \
        VAR##Time.fetch_sub(GetWallUs()); \
    } while (false)

#define TIMESTAMP_END(VAR)                \
    do {                                  \
        VAR##Time.fetch_add(GetWallUs()); \
        VAR##Count.fetch_add(1);          \
    } while (false)

#define TIMESTAMP_DEFINE(VAR) \
    __THREAD_LOCAL__ std::atomic<int32_t> VAR##Count{0};       \
    __THREAD_LOCAL__ std::atomic<long long> VAR##Time{0};

#define TIMESTAMP_EXTERN(VAR) \
    extern __THREAD_LOCAL__ std::atomic<int32_t> VAR##Count;    \
    extern __THREAD_LOCAL__ std::atomic<long long> VAR##Time;

#ifndef TEMP_PERFORMANCE_NOT_OUTPUT
#define TIMESTAMP_DUMP(VAR)                                                                                     \
    do {                                                                                                        \
        int32_t count = VAR##Count;                                                                             \
        long long totalTime = VAR##Time;                                                                        \
        RT_LOG(RT_LOG_ERROR, "[" #VAR "] TIME = %.3f us, COUNT = %d", count ? (float64_t)totalTime / count : 0, \
               count);                                                                                          \
    } while (false)
#else
#define TIMESTAMP_DUMP(VAR) 
#endif

#define TIMESTAMP_NAME(VAR)

#else
#define TIMESTAMP_BEGIN(VAR)
#define TIMESTAMP_END(VAR)
#define TIMESTAMP_DEFINE(VAR)
#define TIMESTAMP_EXTERN(VAR)
#define TIMESTAMP_DUMP(VAR)
#define TIMESTAMP_NAME(VAR)
#endif

void RtLogErrorLevelControl(bool isLogError, const char *format, ...);

class NoCopy {
public:
    NoCopy()  = default;
    virtual ~NoCopy() = default;

private:
    NoCopy &operator=(const NoCopy &other) = delete;

    NoCopy(const NoCopy &other) = delete;
};

template<typename TI>
inline uint64_t RtPtrToValue(const TI ptr)
{
    return static_cast<uint64_t>(reinterpret_cast<uintptr_t>(ptr));
}

template<typename TO>
inline TO RtValueToPtr(const uint64_t value)
{
    return reinterpret_cast<TO>(static_cast<uintptr_t>(value));
}

template<typename TO, typename TI>
inline TO RtPtrToPtr(const TI ptr)
{
    return reinterpret_cast<TO>(ptr);
}

template<typename TO, typename TI>
inline TO RtPtrToUnConstPtr(TI ptr)
{
    return const_cast<TO>(ptr);
}

}
}
#endif // __CCE_RUNTIME_BASE_HPP__
