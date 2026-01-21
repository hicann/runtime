/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ACL_COMMON_LOG_INNER_H__
#define ACL_COMMON_LOG_INNER_H__

#include "acl/acl_base.h"
#include "error_manager.h"
#include "dlog_pub.h"
#include "mmpa_api.h"

#ifdef __cplusplus
extern "C" {
#endif

#define ACL_GET_ERROR_LOG_HEADER "[ACL][MODULE]"
#define ACL_REPORT_INNER_ERROR "REPORT_INNER_ERROR"
#define ACL_REPORT_CALL_ERROR "REPORT_CALL_ERROR"
#define ACL_MODE_ID ((int32_t)(ASCENDCL))
#define INVALID_PARAM_MSG "EH0001"
#define INVALID_NULL_POINTER_MSG "EH0002"

static inline uint64_t GetTid(void) {
  const uint64_t tid = (uint64_t)(mmGetTaskId());
  return tid;
}

#ifdef RUN_TEST
#define ACL_LOG_DEBUG(fmt, ...)                                \
  do {                                                         \
    printf("[DEBUG][%s:%d]%ld:" #fmt "\n", __FILE__, __LINE__, \
           (long int)GetTid(), ##__VA_ARGS__);                 \
  } while (false)

#define ACL_LOG_INFO(fmt, ...)                                \
  do {                                                        \
    printf("[INFO][%s:%d]%ld:" #fmt "\n", __FILE__, __LINE__, \
           (long int)GetTid(), ##__VA_ARGS__);                \
  } while (false)

#define ACL_LOG_WARN(fmt, ...)                                   \
  do {                                                           \
    printf("[WARNING][%s:%d]%ld:" #fmt "\n", __FILE__, __LINE__, \
           (long int)GetTid(), ##__VA_ARGS__);                   \
  } while (false)

#define ACL_LOG_EVENT(fmt, ...)                                \
  do {                                                         \
    printf("[EVENT][%s:%d]%ld:" #fmt "\n", __FILE__, __LINE__, \
           (long int)GetTid(), ##__VA_ARGS__);                 \
  } while (false)

#define ACL_LOG_ERROR(fmt, ...)                                          \
  do {                                                                   \
    printf("[ERROR][%s:%d]%ld:%s " #fmt "\n", __FILE__, __LINE__,        \
           (long int)GetTid(), ACL_GET_ERROR_LOG_HEADER, ##__VA_ARGS__); \
  } while (false)

#define ACL_LOG_INNER_ERROR(fmt, ...)                                  \
  do {                                                                 \
    printf("[ERROR][%s:%d]%ld:%s " #fmt "\n", __FILE__, __LINE__,      \
           (long int)GetTid(), ACL_REPORT_INNER_ERROR, ##__VA_ARGS__); \
  } while (false)

#define ACL_LOG_CALL_ERROR(fmt, ...)                                  \
  do {                                                                \
    printf("[ERROR][%s:%d]%ld:%s " #fmt "\n", __FILE__, __LINE__,     \
           (long int)GetTid(), ACL_REPORT_CALL_ERROR, ##__VA_ARGS__); \
  } while (false)
#else
#define ACL_LOG_DEBUG(fmt, ...)                                                             \
  do {                                                                                      \
    DlogRecord(ACL_MODE_ID, DLOG_DEBUG, "[DEBUG][%s:%d]%ld " fmt "\n",  __FILE__, __LINE__,  \
              (long int)GetTid(), ##__VA_ARGS__);                                           \
  } while (false)

#define ACL_LOG_INFO(fmt, ...)                                                              \
  do {                                                                                      \
    DlogRecord(ACL_MODE_ID, DLOG_INFO, "[INFO][%s:%d]%ld " fmt "\n",  __FILE__, __LINE__,    \
              (long int)GetTid(), ##__VA_ARGS__);                                           \
  } while (false)

#define ACL_LOG_WARN(fmt, ...)                                                              \
  do {                                                                                      \
    DlogRecord(ACL_MODE_ID, DLOG_WARN, "[WARNING][%s:%d]%ld " fmt "\n",  __FILE__, __LINE__, \
              (long int)GetTid(), ##__VA_ARGS__);                                           \
  } while (false)

#define ACL_LOG_EVENT(fmt, ...)                                                             \
  do {                                                                                      \
    DlogRecord(ACL_MODE_ID, DLOG_EVENT, "[Event][%s:%d]%ld " fmt "\n",  __FILE__, __LINE__,  \
              (long int)GetTid(), ##__VA_ARGS__);                                           \
  } while (false)

#define ACL_LOG_ERROR(fmt, ...)                                                               \
  do {                                                                                        \
    DlogRecord(ACL_MODE_ID, DLOG_ERROR, "[ERROR][%s:%d]%ld:%s " fmt "\n",  __FILE__, __LINE__, \
              (long int)GetTid(), ACL_GET_ERROR_LOG_HEADER, ##__VA_ARGS__);                   \
  } while (false)

#define ACL_LOG_INNER_ERROR(fmt, ...)                                                         \
  do {                                                                                        \
    DlogRecord(ACL_MODE_ID, DLOG_ERROR, "[ERROR][%s:%d]%ld:%s " fmt "\n",  __FILE__, __LINE__, \
              (long int)GetTid(), ACL_REPORT_INNER_ERROR, ##__VA_ARGS__);                     \
  } while (false)

#define ACL_LOG_CALL_ERROR(fmt, ...)                                                          \
  do {                                                                                        \
    DlogRecord(ACL_MODE_ID, DLOG_ERROR, "[ERROR][%s:%d]%ld:%s " fmt "\n",  __FILE__, __LINE__, \
              (long int)GetTid(), ACL_REPORT_CALL_ERROR, ##__VA_ARGS__);                      \
  } while (false)
#endif

#define ACL_REQUIRES_OK(expr)      \
  do {                             \
    const aclError __ret = (expr); \
    if (__ret != ACL_SUCCESS) {    \
      return __ret;                \
    }                              \
  } while (false)

#define ACL_CHECK_RANGE_INT(val, min, max)                                     \
  do {                                                                         \
    if (((val) < (min)) || ((val) > (max))) {                                  \
      ACL_LOG_ERROR("[Check][%s]param:[%d] must be in range of [%d] and [%d]", \
                    #val, (int32_t)(val), (int32_t)(min), (int32_t)(max));     \
      return ACL_ERROR_INVALID_PARAM;                                          \
    }                                                                          \
  } while (false)

#define ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(val)             \
  do {                                                           \
    if ((val) == NULL) {                                         \
      ACL_LOG_ERROR("[Check][%s]param must not be NULL.", #val); \
      return ACL_ERROR_INVALID_PARAM;                            \
    }                                                            \
  } while (false)

#define ACL_REQUIRES_NOT_NULL_RET_NULL_INPUT_REPORT(val)         \
  do {                                                           \
    if ((val) == NULL) {                                         \
      ACL_LOG_ERROR("[Check][%s]param must not be NULL.", #val); \
      return NULL;                                               \
    }                                                            \
  } while (false)

#define ACL_DELETE_AND_SET_NULL(var) \
  do {                               \
    if ((var) != NULL) {             \
      mmFree(var);                     \
      (var) = NULL;                  \
    }                                \
  } while (false)

#ifdef __cplusplus
}
#endif
#endif  // ACL_COMMON_LOG_INNER_H__
