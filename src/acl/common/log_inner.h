/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ACL_COMMON_LOG_INNER_H_
#define ACL_COMMON_LOG_INNER_H_

#include <string>
#include <vector>
#include "dlog_pub.h"
#include "mmpa/mmpa_api.h"
#include "acl/acl_base.h"

#ifndef char_t
using char_t = char;
#endif

#ifndef float32_t
using float32_t = float;
#endif

namespace acl {
constexpr int32_t ACL_MODE_ID = static_cast<int32_t>(ASCENDCL);
constexpr int32_t APP_MODE_ID = static_cast<int32_t>(APP);
constexpr uint16_t ACL_MODE_ID_U16 = static_cast<uint16_t>(ASCENDCL);
constexpr uint16_t APP_MODE_ID_U16 = static_cast<uint16_t>(APP);
constexpr const char_t *const ACL_MODULE_NAME = "ASCENDCL";
constexpr const char_t *const INVALID_PARAM_MSG = "EH0001";
constexpr const char_t *const INVALID_NULL_POINTER_MSG = "EH0002";
constexpr const char_t *const INVALID_PATH_MSG = "EH0003";
constexpr const char_t *const INVALID_FILE_MSG = "EH0004";
constexpr const char_t *const INVALID_AIPP_MSG = "EH0005";
constexpr const char_t *const UNSUPPORTED_FEATURE_MSG = "EH0006";

// first stage
constexpr const char_t *const ACL_STAGE_SET = "SET";
constexpr const char_t *const ACL_STAGE_GET = "GET";
constexpr const char_t *const ACL_STAGE_CREATE = "CREATE";
constexpr const char_t *const ACL_STAGE_DESTROY = "DESTROY";
constexpr const char_t *const ACL_STAGE_BLAS = "BLAS";
constexpr const char_t *const ACL_STAGE_INFER = "INFER";
constexpr const char_t *const ACL_STAGE_COMP = "COMP";
constexpr const char_t *const ACL_STAGE_LOAD = "LOAD";
constexpr const char_t *const ACL_STAGE_UNLOAD = "UNLOAD";
constexpr const char_t *const ACL_STAGE_EXEC = "EXEC";
constexpr const char_t *const ACL_STAGE_COMP_AND_EXEC = "COMP_AND_EXEC";
constexpr const char_t *const ACL_STAGE_DUMP = "DUMP";
constexpr const char_t *const ACL_STAGE_DVPP = "DVPP";
constexpr const char_t *const ACL_STAGE_TDT = "TDT";
constexpr const char_t *const ACL_STAGE_INIT = "INIT";
constexpr const char_t *const ACL_STAGE_FINAL = "FINAL";
constexpr const char_t *const ACL_STAGE_QUEUE = "QUEUE";
constexpr const char_t *const ACL_STAGE_MBUF = "MBUF";
// second stage
constexpr const char_t *const ACL_STAGE_DEFAULT = "DEFAULT";

constexpr size_t MAX_LOG_STRING = 1024U;

constexpr size_t MAX_ERROR_STRING = 128U;

inline const char_t* format_cast(const char_t *const src)
{
    return static_cast<const char_t *>(src);
}

ACL_FUNC_VISIBILITY std::string AclGetErrorFormatMessage(const mmErrorMsg errnum);

class ACL_FUNC_VISIBILITY AclLog {
public:
    static bool IsLogOutputEnable(const aclLogLevel logLevel);
    static mmPid_t GetTid();
    static void ACLSaveLog(const aclLogLevel logLevel, const char_t *const strLog);
    static bool IsEventLogOutputEnable();
private:
    static aclLogLevel GetCurLogLevel();
    static bool isEnableEvent_;
};

class ACL_FUNC_VISIBILITY AclErrorLogManager {
public:
    static std::string FormatStr(const char_t *const fmt, ...);
#if !defined(ENABLE_DVPP_INTERFACE) || defined(RUN_TEST)
    static void ReportInputError(const char *errorCode, const std::vector<const char *> &key = {},
        const std::vector<const char *> &val = {});
#else
#endif
    static void ReportInputErrorWithChar(const char_t *const errorCode, const char_t *const argNames[],
        const char_t *const argVals[], const size_t size);
    static void ReportInnerError(const char_t *const fmt, ...);
    static void ReportCallError(const char_t *const fmt, ...);
};
} // namespace acl

#if defined(__GNUC__) || defined(__clang__)
#define LIKELY(expr) (static_cast<bool>(__builtin_expect(static_cast<bool>(expr), 1)))
#define UNLIKELY(expr) (static_cast<bool>(__builtin_expect(static_cast<bool>(expr), 0)))
#else
#define LIKELY(expr) (expr)
#define UNLIKELY(expr) (expr)
#endif

#ifdef RUN_TEST
#define ACL_LOG_INFO(fmt, ...)                                                                      \
    do {                                                                                            \
            if (acl::AclLog::IsLogOutputEnable(ACL_INFO)) {                                         \
                constexpr const char_t *const funcName = __FUNCTION__;                                        \
                printf("INFO %d %s:%s:%d: "#fmt "\n", acl::AclLog::GetTid(), acl::format_cast(funcName), \
                    __FILE__, __LINE__, ##__VA_ARGS__);                                             \
            }                                                                                       \
    } while (false)
#define ACL_LOG_DEBUG(fmt, ...)                                                                     \
    do {                                                                                            \
            if (acl::AclLog::IsLogOutputEnable(ACL_DEBUG)) {                                        \
                constexpr const char_t *const funcName = __FUNCTION__;                                        \
                printf("DEBUG %d %s:%s:%d: "#fmt "\n", acl::AclLog::GetTid(), acl::format_cast(funcName), \
                    __FILE__, __LINE__, ##__VA_ARGS__);                                             \
            }                                                                                       \
    } while (false)
#define ACL_LOG_WARN(fmt, ...)                                                                      \
    do {                                                                                            \
            if (acl::AclLog::IsLogOutputEnable(ACL_WARNING)) {                                      \
                constexpr const char_t *const funcName = __FUNCTION__;                                        \
                printf("WARN %d %s:%s:%d: "#fmt "\n", acl::AclLog::GetTid(), acl::format_cast(funcName), \
                    __FILE__, __LINE__, ##__VA_ARGS__);                                             \
            }                                                                                       \
    } while (false)
#define ACL_LOG_ERROR(fmt, ...)                                                                     \
    do {                                                                                            \
            constexpr const char_t *const funcName = __FUNCTION__;                                            \
            printf("ERROR %d %s:%s:%d:" fmt "\n", acl::AclLog::GetTid(), acl::format_cast(funcName), \
                __FILE__, __LINE__, ##__VA_ARGS__);  \
    } while (false)
#define ACL_LOG_INNER_ERROR(fmt, ...)                                                               \
    do {                                                                                            \
            constexpr const char_t *const funcName = __FUNCTION__;                                            \
            printf("ERROR %d %s:%s:%d:" fmt "\n", acl::AclLog::GetTid(), acl::format_cast(funcName), \
                __FILE__, __LINE__, ##__VA_ARGS__); \
    } while (false)
#define ACL_LOG_CALL_ERROR(fmt, ...)                                                                \
    do {                                                                                            \
            constexpr const char_t *const funcName = __FUNCTION__;                                            \
            printf("ERROR %d %s:%s:%d:" fmt "\n", acl::AclLog::GetTid(), acl::format_cast(funcName), \
                __FILE__, __LINE__, ##__VA_ARGS__); \
    } while (false)
#define ACL_LOG_EVENT(fmt, ...)                                                                     \
    do {                                                                                            \
            if (acl::AclLog::IsEventLogOutputEnable()) {                                            \
                constexpr const char_t *const funcName = __FUNCTION__;                                        \
                printf("EVENT %d %s:%s:%d: "#fmt "\n", acl::AclLog::GetTid(), acl::format_cast(funcName), \
                    __FILE__, __LINE__, ##__VA_ARGS__);                                             \
            }                                                                                       \
    } while (false)
#else
#define ACL_LOG_INFO(fmt, ...)                                                                                        \
    do {                                                                                                              \
        constexpr const char_t *const funcName = __FUNCTION__;                                                        \
        dlog_info(acl::ACL_MODE_ID, "%d %s: " fmt, acl::AclLog::GetTid(), acl::format_cast(funcName), ##__VA_ARGS__); \
    } while (false)
#define ACL_LOG_DEBUG(fmt, ...)                                                                                        \
    do {                                                                                                               \
        constexpr const char_t *const funcName = __FUNCTION__;                                                         \
        dlog_debug(acl::ACL_MODE_ID, "%d %s: " fmt, acl::AclLog::GetTid(), acl::format_cast(funcName), ##__VA_ARGS__); \
    } while (false)
#define ACL_LOG_WARN(fmt, ...)                                                                                        \
    do {                                                                                                              \
        constexpr const char_t *const funcName = __FUNCTION__;                                                        \
        dlog_warn(acl::ACL_MODE_ID, "%d %s: " fmt, acl::AclLog::GetTid(), acl::format_cast(funcName), ##__VA_ARGS__); \
    } while (false)
#define ACL_LOG_ERROR(fmt, ...)                                                                          \
    do {                                                                                                 \
        constexpr const char_t *const funcName = __FUNCTION__;                                           \
        dlog_error(acl::ACL_MODE_ID, "%d %s:" fmt, acl::AclLog::GetTid(), acl::format_cast(funcName), \
            ##__VA_ARGS__);                          \
    } while (false)
#define ACL_LOG_INNER_ERROR(fmt, ...)                                                                    \
    do {                                                                                                 \
        constexpr const char_t *const funcName = __FUNCTION__;                                           \
        dlog_error(acl::ACL_MODE_ID, "%d %s:" fmt, acl::AclLog::GetTid(), acl::format_cast(funcName), \
            ##__VA_ARGS__);                          \
        acl::AclErrorLogManager::ReportInnerError((fmt), ##__VA_ARGS__);                                 \
    } while (false)
#define ACL_LOG_CALL_ERROR(fmt, ...)                                                                     \
    do {                                                                                                 \
        constexpr const char_t *const funcName = __FUNCTION__;                                           \
        dlog_error(acl::ACL_MODE_ID, "%d %s:" fmt, acl::AclLog::GetTid(), acl::format_cast(funcName), \
            ##__VA_ARGS__);                          \
        acl::AclErrorLogManager::ReportCallError((fmt), ##__VA_ARGS__);                                  \
    } while (false)
#define ACL_LOG_EVENT(fmt, ...)                                                                  \
    do {                                                                                         \
        if (acl::AclLog::IsEventLogOutputEnable()) {                                             \
            constexpr const char_t *const funcName = __FUNCTION__;                               \
            dlog_info((acl::ACL_MODE_ID | (RUN_LOG_MASK)), "%d %s: " fmt, acl::AclLog::GetTid(), \
                acl::format_cast(funcName), ##__VA_ARGS__);                                      \
        }                                                                                        \
    } while (false)
#endif

#define OFFSET_OF_MEMBER(type, member) reinterpret_cast<size_t>(&((reinterpret_cast<type *>(0))->member))

#define ACL_REQUIRES_OK(expr) \
    do { \
        const aclError __ret = (expr); \
        if (__ret != ACL_SUCCESS) { \
            return __ret; \
        } \
    } \
    while (false)

#define ACL_REQUIRES_OK_RETURN_NULL(expr) \
    do { \
        const aclError __ret = (expr); \
        if (__ret != ACL_SUCCESS) { \
            return nullptr; \
        } \
    } \
    while (false)

#define ACL_REQUIRES_EOK(expr, interface) \
    do { \
        const auto __ret = (expr); \
        if (__ret != EOK) { \
            ACL_LOG_INNER_ERROR("call api [%s] failed, retCode is %d", #interface, __ret); \
            return ACL_ERROR_FAILURE; \
        } \
    } \
    while (false)

#define ACL_REQUIRES_OK_WITH_INNER_MESSAGE(expr, ...) \
    do { \
        const aclError __ret = (expr); \
        if (__ret != ACL_SUCCESS) { \
            ACL_LOG_INNER_ERROR(__VA_ARGS__); \
            return __ret; \
        } \
    } \
    while (false)

#define ACL_REQUIRES_CALL_GE_OK(expr, ...) \
    do { \
        const auto __ret = (expr); \
        if (__ret != ge::SUCCESS) { \
            ACL_LOG_CALL_ERROR(__VA_ARGS__); \
            return __ret; \
        } \
    } \
    while (false)

#define ACL_REQUIRES_CALL_RTS_OK(expr, interface) \
    do { \
        const rtError_t __ret = (expr); \
        if (__ret != RT_ERROR_NONE) { \
            if (__ret == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) { \
                ACL_LOG_WARN("rts api [%s] is not supported currently,", #interface); \
                return __ret; \
            } \
            ACL_LOG_CALL_ERROR("[Call][Rts]call rts api [%s] failed, retCode is %d", #interface, __ret); \
            return __ret; \
        } \
    } \
    while (false)

#define ACL_REQUIRES_CALL_HIMPI_OK(expr, interface) \
    do { \
        const int32_t __ret = (expr); \
        if (__ret != 0) { \
            ACL_LOG_CALL_ERROR("[Call][Himpi]call himpi api [%s] failed, retCode is %d", #interface, __ret); \
            return __ret; \
        } \
    } \
    while (false)

// Validate whether the expr value is true
#define ACL_REQUIRES_TRUE(expr, errCode, errDesc) \
    do { \
        const bool __ret = (expr); \
        if (!__ret) { \
            ACL_LOG_ERROR(errDesc); \
            return (errCode); \
        } \
    } \
    while (false)

#ifndef ENABLE_DVPP_INTERFACE
#define ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(val) \
    do { \
    if (UNLIKELY((val) == nullptr)) { \
        ACL_LOG_ERROR("[Check][%s]param must not be null.", #val); \
        acl::AclErrorLogManager::ReportInputError("EH0002", {"param"}, {#val}); \
        return ACL_ERROR_INVALID_PARAM; } \
    } \
    while (false)
#else
#define ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(val) \
    do { \
    if (UNLIKELY((val) == nullptr)) { \
        ACL_LOG_ERROR("[Check][%s]param must not be null.", #val); \
        const char_t *argList[] = {"param"}; \
        const char_t *argVal[] = {#val}; \
        acl::AclErrorLogManager::ReportInputErrorWithChar("EH0002", argList, argVal, 1U); \
        return ACL_ERROR_INVALID_PARAM; } \
    } \
    while (false)
#endif

#define ACL_REQUIRES_NOT_NULL(val) \
    do { \
        if (UNLIKELY((val) == nullptr)) { \
            ACL_LOG_ERROR("[Check][%s]param must not be null.", #val); \
            return ACL_ERROR_INVALID_PARAM; } \
        } \
    while (false)

#define ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(val) \
    do { \
        if (UNLIKELY((val) == nullptr)) { \
            ACL_LOG_INNER_ERROR("[Check][%s]param must not be null.", #val); \
            return ACL_ERROR_INVALID_PARAM; } \
        } \
    while (false)

#define ACL_REQUIRES_NOT_NULL_RET_NULL(val) \
    do { \
        if (UNLIKELY((val) == nullptr)) { \
            ACL_LOG_ERROR("[Check][%s]param must not be null.", #val); \
            return nullptr; } \
        } \
    while (false)

#define ACL_REQUIRES_NOT_NULL_RET_NULL_INPUT_REPORT(val) \
    do { \
        if (UNLIKELY((val) == nullptr)) { \
            ACL_LOG_ERROR("[Check][%s]param must not be null.", #val); \
            acl::AclErrorLogManager::ReportInputError("EH0002", {"param"}, {#val}); \
            return nullptr; } \
        } \
    while (false)

#define ACL_REQUIRES_NOT_NULL_RET_VOID(val) \
    do { \
        if (UNLIKELY((val) == nullptr)) { \
            ACL_LOG_ERROR("[Check][%s]param must not be null.", #val); \
            return; } \
        } \
    while (false)

#define ACL_CHECK_RANGE_INT(val, min, max) \
    do { \
        if (((val) < (min)) || ((val) > (max))) { \
            ACL_LOG_ERROR("[Check][%s]param:[%d] must be in range of [%d] and [%d]", \
                #val, (static_cast<int32_t>(val)), (static_cast<int32_t>(min)), (static_cast<int32_t>(max))); \
            return ACL_ERROR_INVALID_PARAM; } \
        } \
    while (false)

#define ACL_CHECK_LESS_UINT(val, max) \
    do { \
        if ((val) > (max)) { \
            ACL_LOG_ERROR("[Check][%s]param:[%u] must be in range of [0] and [%u]", \
                #val, (static_cast<uint32_t>(val)), (static_cast<uint32_t>(max))); \
            return ACL_ERROR_INVALID_PARAM; } \
        } \
    while (false)

#define ACL_CHECK_RANGE_FLOAT(val, min, max) \
    do { \
        if (((val) < (min)) || ((val) > (max))) { \
            ACL_LOG_ERROR("[Check][%s]param:[%.2f] must be in range of [%.2f] and [%.2f]", \
                #val, (static_cast<float64_t>(val)), (static_cast<float64_t>(min)), (static_cast<float64_t>(max))); \
            return ACL_ERROR_INVALID_PARAM; } \
        } \
    while (false)

#define ACL_CHECK_MALLOC_RESULT(val) \
    do { \
        if ((val) == nullptr) { \
            ACL_LOG_INNER_ERROR("[Check][Malloc]Allocate memory for [%s] failed.", #val); \
            return ACL_ERROR_BAD_ALLOC; } \
        } \
    while (false)

#define ACL_REQUIRES_NON_NEGATIVE(val) \
    do { \
        if ((val) < 0) { \
            ACL_LOG_ERROR("[Check][%s]param must be non-negative.", #val); \
            return ACL_ERROR_INVALID_PARAM; } \
        } \
    while (false)

#define ACL_REQUIRES_NON_NEGATIVE_WITH_INPUT_REPORT(val) \
    do { \
        if ((val) < 0) { \
            ACL_LOG_ERROR("[Check][%s]param must be non-negative.", #val); \
            acl::AclErrorLogManager::ReportInputError("EH0001", \
                std::vector<const char *>({"param", "value", "reason"}), \
                std::vector<const char *>({#val, std::to_string(val).c_str(), "must be non-negative"})); \
            return ACL_ERROR_INVALID_PARAM; } \
        } \
    while (false)

#define ACL_REQUIRES_POSITIVE(val) \
    do { \
        if ((val) <= 0) { \
            ACL_LOG_ERROR("[Check][%s]param must be positive.", #val); \
            return ACL_ERROR_INVALID_PARAM; } \
        } \
    while (false)

#define ACL_REQUIRES_POSITIVE_WITH_INPUT_REPORT(val) \
    do { \
        if ((val) <= 0) { \
            ACL_LOG_ERROR("[Check][%s]param must be positive.", #val); \
            acl::AclErrorLogManager::ReportInputError("EH0001", \
                std::vector<const char *>({"param", "value", "reason"}), \
                std::vector<const char *>({#val, std::to_string(val).c_str(), "must be positive"})); \
            return ACL_ERROR_INVALID_PARAM; } \
        } \
    while (false)

#define ACL_REQUIRES_POSITIVE_RET_NULL(val) \
    do { \
        if ((val) <= 0) { \
            ACL_LOG_ERROR("[Check][%s]param must be positive.", #val); \
            return nullptr; } \
        } \
    while (false)

#define ACL_DELETE(memory) \
    do { \
        delete (memory); \
        (memory) = nullptr; \
    } \
    while (false)

#define ACL_DELETE_ARRAY(memory) \
    do { \
        if ((memory) != nullptr) { \
            delete[] static_cast<char_t *>(memory); \
            (memory) = nullptr; \
        } \
    } \
    while (false)

#define ACL_CHECK_WITH_MESSAGE_AND_RETURN(exp, ret, ...) \
    do { \
        if (!(exp)) { \
            ACL_LOG_ERROR(__VA_ARGS__); \
            return (ret); \
        } \
    } \
    while (false)

#define ACL_CHECK_WITH_INNER_MESSAGE_AND_RETURN(exp, ret, ...) \
    do { \
        if (!(exp)) { \
            ACL_LOG_INNER_ERROR(__VA_ARGS__); \
            return (ret); \
        } \
    } \
    while (false)

#define ACL_DELETE_AND_SET_NULL(var) \
    do { \
        if ((var) != nullptr) { \
            delete (var); \
            (var) = nullptr; \
        } \
    } \
    while (false)

#define ACL_DELETE_ARRAY_AND_SET_NULL(var) \
    do { \
        if ((var) != nullptr) { \
            delete[] (var); \
            (var) = nullptr; \
        } \
    } \
    while (false)

#define ACL_FREE(var) \
    do { \
        if ((var) != nullptr) { \
            free(var); \
            (var) = nullptr; \
        } \
    } \
    while (false)

#define ACL_ALIGN_FREE(var) \
    do { \
        if ((var) != nullptr) { \
            mmAlignFree(var); \
            (var) = nullptr; \
        } \
    } \
    while (false)

// If make_shared is abnormal, print the log and execute the statement
#define ACL_MAKE_SHARED(expr0, expr1) \
    try { \
        (expr0); \
    } catch (const std::bad_alloc &) { \
        ACL_LOG_INNER_ERROR("[Make][Shared]Make shared failed"); \
        expr1; \
    }

#define RETURN_NULL_WITH_ALIGN_FREE(newAddr, mallocAddr) \
    do { \
        if ((newAddr) == nullptr) { \
            ACL_LOG_INNER_ERROR("[Malloc][Mem]new memory failed"); \
            mmAlignFree(mallocAddr); \
            return nullptr; \
        } \
    } \
    while (false)

#define ACL_CHECK_INT32_EQUAL(leftValue, rightValue) \
    do { \
        if ((leftValue) != (rightValue)) { \
            ACL_LOG_INFO("[%d] is not equal to [%d].", (leftValue), (rightValue)); \
            return false; \
        } \
    } \
    while (false)

#define ACL_REQUIRES_EQ(x, y)                                                                                          \
    do {                                                                                                               \
        const auto &xv = (x);                                                                                          \
        const auto &yv = (y);                                                                                          \
        if (xv != yv) {                                                                                                \
            std::stringstream ss;                                                                                      \
            ss << "Assert (" << #x << " == " << #y << ") failed, expect " << yv << " actual " << xv;                   \
            ACL_LOG_INNER_ERROR("%s", ss.str().c_str());                                                               \
            return ACL_ERROR_INVALID_PARAM;                                                                            \
        }                                                                                                              \
    } while (false)

#define ACL_REQUIRES_LE(x, y)                                                                                          \
    do {                                                                                                               \
        const auto &xv = (x);                                                                                          \
        const auto &yv = (y);                                                                                          \
        if (!(xv <= yv)) {                                                                                             \
            std::stringstream ss;                                                                                      \
            ss << "Assert (" << #x << " <= " << #y << ") failed, left value is " << xv << " right value is " << yv;    \
            ACL_LOG_INNER_ERROR("%s", ss.str().c_str());                                                               \
            return ACL_ERROR_INVALID_PARAM;                                                                            \
        }                                                                                                              \
    } while (false)

#define ACL_CHECK_UINT32_GREATER(leftValue, rightValue) \
    do { \
        if ((leftValue) < (rightValue)) { \
            ACL_LOG_ERROR("left value [%u] can not be smaller than right value [%u].", \
                static_cast<uint32_t>(leftValue), static_cast<uint32_t>(rightValue)); \
            return ACL_ERROR_INVALID_PARAM; \
        } \
    } \
    while (false)

#endif // ACL_COMMON_LOG_H_
