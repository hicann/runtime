/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef PTA_NPU_OP_API_COMMON_INC_OP_LOG_H_
#define PTA_NPU_OP_API_COMMON_INC_OP_LOG_H_

#include <stdint.h>
#include <string>
#include <type_traits>
#include <unordered_map>
#include "op_errno.h"
#include "toolchain/dlog_pub.h"
#ifdef __GNUC__
#include <sys/syscall.h>
#include <unistd.h>
#else
#include "mmpa/mmpa_api.h"
#endif

#define OPAPI_SUBMOD_NAME "NNOP"
#define OP_ID 63
#define LOG_FMT_IDX 3
#define LOG_AGR_IDX 4

namespace op {
class OpLog {
public:
    static uint64_t GetTid()
    {
#ifdef __GNUC__
        const uint64_t tid = static_cast<uint64_t>(syscall(__NR_gettid));
#else
        const uint64_t tid = static_cast<uint64_t>(GetCurrentThreadId());
#endif
        return tid;
    }
};
}

void ReportErrorMessageInner(const std::string &code, const char *fmt, ...);
const std::unordered_map<char, std::string> ERRNO_PREFIX_TO_ERROR_CODE = {
    {'1', "EZ1001"},
    {'3', "EZ9903"},
    {'5', "EZ9999"}
};

template<typename ...Arguments>
void ReportErrorMessage(const char *code, const char *fmt, Arguments &&... args)
{
    std::string errorCode = "EZ9999";
    const auto iter = ERRNO_PREFIX_TO_ERROR_CODE.find(code[0]);
    if (iter != ERRNO_PREFIX_TO_ERROR_CODE.end()) {
        errorCode = iter->second;
    }
    ReportErrorMessageInner(errorCode, fmt, std::forward<Arguments>(args)...);
}

namespace op::internal {
std::string GetLogApiInfo();
}

#define OP_LOG_DEBUG 0
#define OP_LOG_INFO 1
#define OP_LOG_WARN 2
#define OP_LOG_ERROR 3
#define OP_LOG_EVENT 0x10

constexpr const char *GetFileName(const char *path)
{
    const char *file = path;
    while (*path != '\0') {
        if (*path++ == '/') {
            file = path;
        }
    }
    return file;
}

inline std::string GetOpName()
{
    auto opInfo = op::internal::GetLogApiInfo();
    if (!opInfo.empty()) {
        opInfo = "OpName:[" + opInfo + "] ";
    }
    return opInfo;
}
/**
 * @brief DOplogSub: print log, need caller to specify level and submodule
 * call CheckLogLevel in advance to optimize performance, call interface with fmt input take time
 *
 * @param [in]moduleId: module id, eg: CCE
 * @param [in]submodule: eg: engine
 * @param [in]level(0: debug, 1: info, 2: warning, 3: error, 5: trace, 6: oplog, 16: event)
 * @param [in]fmt: log content
 */
#define DOplogSub(moduleId, submodule, level, fmt, ...)                                                               \
    do {                                                                                                              \
        if (CheckLogLevel(moduleId, level) == 1) {                                                                    \
            DlogRecord(moduleId, level, "[%s:%d][%s]" fmt, GetFileName(__FILE__), __LINE__, submodule, ##__VA_ARGS__); \
        }                                                                                                             \
    } while (false)

#define DDfxlogSub(moduleId, submodule, level, file, line, fmt, ...)                             \
    do {                                                                                         \
        if (CheckLogLevel(moduleId, level) == 1) {                                               \
            DlogRecord(moduleId, level, "[%s:%d][%s]" fmt, file, line, submodule, ##__VA_ARGS__); \
        }                                                                                        \
    } while (false)

#if defined(NNOPBASE_UT) || defined(NNOPBASE_ST)
#define OP_TEST_LOG(fmt, ...)                                    \
    do {                                                         \
        fprintf(stdout, "[OP_TEST] [tid: %lu][%s:%d] %s:" fmt "\n",        \
            op::OpLog::GetTid(), __FILE__, __LINE__, __FUNCTION__, ##__VA_ARGS__);    \
        fflush(stdout);                                          \
    } while (0)
#define OP_LOGI(...) OP_TEST_LOG(__VA_ARGS__)
#define OP_LOGW(...) OP_TEST_LOG(__VA_ARGS__)
#define OP_LOGE(errno, ...) OP_TEST_LOG(__VA_ARGS__)
#define OP_LOGE_WITHOUT_REPORT(errno, ...) OP_TEST_LOG(__VA_ARGS__)
#define OP_LOGD(...) OP_TEST_LOG(__VA_ARGS__)
#define OP_EVENT(...) OP_TEST_LOG(__VA_ARGS__)
#define OP_DFX_LOGD(file, line, func, ...)
#define OP_DFX_LOGI(file, line, func, ...)
#define OP_DFX_LOGW(file, line, func, ...)
#define OP_DFX_LOGE(file, line, func, ...)
#elif !defined(__ANDROID__) && !defined(ANDROID)
#define OP_LOGI(...) D_OP_LOGI(GetOpName().c_str(), __VA_ARGS__)
#define OP_LOGW(...) D_OP_LOGW(GetOpName().c_str(), __VA_ARGS__)

#define OP_DFX_LOGD(file, line, func, ...) D_OP_DFX_LOGD(GetOpName().c_str(), file, line, func, __VA_ARGS__)
#define OP_DFX_LOGI(file, line, func, ...) D_OP_DFX_LOGI(GetOpName().c_str(), file, line, func, __VA_ARGS__)
#define OP_DFX_LOGW(file, line, func, ...) D_OP_DFX_LOGW(GetOpName().c_str(), file, line, func, __VA_ARGS__)
#define OP_DFX_LOGE(file, line, func, ...) D_OP_DFX_LOGW(GetOpName().c_str(), file, line, func, __VA_ARGS__)
#define REPORT_ERROR_MESSAGE(code, ...)         \
    do {                                        \
        ReportErrorMessage(std::to_string(code).c_str(), __VA_ARGS__); \
    } while (0)
#define OP_LOGE_WITHOUT_REPORT(errno, ...) D_OP_LOGE(GetOpName().c_str(), errno, __VA_ARGS__)
#define OP_LOGE(errno, ...)                         \
    do {                                            \
        OP_LOGE_WITHOUT_REPORT(errno, __VA_ARGS__); \
        REPORT_ERROR_MESSAGE(errno, __VA_ARGS__);  \
    } while (false)

#define OP_LOGD(...) D_OP_LOGD(GetOpName().c_str(), __VA_ARGS__)
#define OP_EVENT(...) D_OP_EVENT(GetOpName().c_str(), __VA_ARGS__)
#else
#define OP_LOGI(...)
#define OP_LOGW(...)
#define OP_LOGE_WITHOUT_REPORT(...)
#define OP_LOGE(...)
#define OP_LOGD(...)
#define OP_EVENT(...)
#endif

#define OpLogSub(moduleId, level, op_info, fmt, ...)                                                  \
    DOplogSub(static_cast<int32_t>(moduleId), OPAPI_SUBMOD_NAME, level, "[%s][%lu] %s" fmt, __FUNCTION__, \
            op::OpLog::GetTid(), op_info, ##__VA_ARGS__)

#define OpLogErrSub(moduleId, level, op_info, errno, fmt, ...)                                                  \
    DOplogSub(static_cast<int32_t>(moduleId), OPAPI_SUBMOD_NAME, level, "[%s][%lu] errno[%d] %s" fmt, __FUNCTION__, \
            op::OpLog::GetTid(), errno, op_info, ##__VA_ARGS__)

#define OpDfxLogSub(moduleId, level, file, line, func, op_info, fmt, ...)                                      \
DDfxlogSub(static_cast<int32_t>(moduleId), OPAPI_SUBMOD_NAME, level, GetFileName(file), line, "[%s][%lu] %s"   \
            fmt, func, op::OpLog::GetTid(), op_info, ##__VA_ARGS__)

#if !defined(__ANDROID__) && !defined(ANDROID)
#define D_OP_LOGI(opname, fmt, ...) OpLogSub(OP_ID, OP_LOG_INFO, opname, fmt, ##__VA_ARGS__)
#define D_OP_LOGW(opname, fmt, ...) OpLogSub(OP_ID, OP_LOG_WARN, opname, fmt, ##__VA_ARGS__)
#define D_OP_LOGE(opname, errno, fmt, ...) OpLogErrSub(OP_ID, OP_LOG_ERROR, opname, errno, fmt, ##__VA_ARGS__)
#define D_OP_LOGD(opname, fmt, ...) OpLogSub(OP_ID, OP_LOG_DEBUG, opname, fmt, ##__VA_ARGS__)
#define D_OP_EVENT(opname, fmt, ...) OpLogSub(OP_ID, OP_LOG_EVENT, opname, fmt, ##__VA_ARGS__)

#define D_OP_DFX_LOGI(opname, file, line, func, fmt, ...) \
OpDfxLogSub(OP_ID, OP_LOG_INFO, file, line, func, opname, fmt, ##__VA_ARGS__)
#define D_OP_DFX_LOGW(opname, file, line, func, fmt, ...) \
OpDfxLogSub(OP_ID, OP_LOG_WARN, file, line, func, opname, fmt, ##__VA_ARGS__)
#define D_OP_DFX_LOGE(opname, file, line, func, fmt, ...) \
OpDfxLogSub(OP_ID, OP_LOG_ERROR, file, line, func, opname, fmt, ##__VA_ARGS__)
#define D_OP_DFX_LOGD(opname, file, line, func, fmt, ...) \
OpDfxLogSub(OP_ID, OP_LOG_DEBUG, file, line, func, opname, fmt, ##__VA_ARGS__)

#else
#define D_OP_LOGI(opname, fmt, ...)
#define D_OP_LOGW(opname, fmt, ...)
#define D_OP_LOGE(opname, fmt, ...)
#define D_OP_LOGD(opname, fmt, ...)
#define D_OP_EVENT(opname, fmt, ...)
#endif

#define unlikely(x) __builtin_expect((x), 0)
#define likely(x) __builtin_expect((x), 1)

#define OP_CHECK_NOTNULL(val)                                                          \
    do {                                                                               \
        if ((val) == nullptr) {                                                        \
            OP_LOGE(ACLNN_ERR_INNER_NULLPTR, "Parameter[%s] must not be null.", #val); \
            return ACLNN_ERR_INNER_NULLPTR;                                            \
        }                                                                              \
    } while (false)

#define RET_IF_NOT_SUCCESS(x)
#define CHECK_RET(condition, ret_value)                                              \
    do {                                                                             \
        if (!(condition)) {                                                          \
            OP_LOGE_WITHOUT_REPORT(ACLNN_ERR_INNER, "check %s failed.", #condition); \
            return ret_value;                                                        \
        }                                                                            \
    } while (false)
#define CHECK_RET_CODE(func, fmt, ...)                    \
    do {                                                  \
        aclnnStatus __rc = func;                          \
        if (__rc != ACLNN_SUCCESS) {                      \
            OP_LOGE(__rc, fmt, ##__VA_ARGS__);            \
            return __rc;                                  \
        }                                                 \
    } while (false)

#define OP_CHECK(cond, log_func, return_expr) \
    do {                                      \
        if (!(cond)) {                        \
            log_func;                         \
            return_expr;                      \
        }                                     \
    } while (false)

#define OP_CHECK_NO_RETURN(cond, log_func)    \
    do {                                      \
        if (!(cond)) {                        \
            log_func;                         \
        }                                     \
    } while (false)

#define CHECK_COND(cond, ret, fmt, ...)       \
    do {                                      \
        if (!(cond)) {                        \
            OP_LOGE(ret, fmt, ##__VA_ARGS__); \
            return ret;                       \
        }                                     \
    } while (false)

#endif //PTA_NPU_OP_API_COMMON_INC_OP_LOG_H_
