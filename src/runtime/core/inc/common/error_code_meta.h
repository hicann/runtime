/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef RUNTIME_ERROR_CODE_META_H
#define RUNTIME_ERROR_CODE_META_H

#include "dlog_pub.h"  // DLOG_ERROR, DLOG_WARN

// ============================================================
//  X-Macro 错误码元数据表
//  新增/修改错误码时只需在此表添加/修改一行。
//  格式: X(ErrorCode枚举名, 字符串名称, (参数名列表), 完整消息模板, 日志级别)
//        - 参数名列表用括号包裹，字符串字面量
//        - 消息模板含 ErrorCode 后缀及 \n，和 PrintErrMsgToLog 原输出一致
//        - 日志级别: DLOG_ERROR 或 DLOG_WARN
// ============================================================
#define RUNTIME_ERROR_CODE_TABLE(X)                                           \
    /* EE1001 - Invalid_Argument */                                           \
    X(EE1001, "EE1001",                                                       \
      ("extend_info"),                                                        \
      "The argument is invalid. Reason: %s. ErrorCode=EE1001.\n",              \
      DLOG_ERROR)                                                             \
    /* EE1002 - Execution_Error_Stream_Synchronize_Timeout */                 \
    X(EE1002, "EE1002",                                                       \
      ("extend_info"),                                                        \
      "Stream synchronize timeout. %s. ErrorCode=EE1002.\n",                  \
      DLOG_ERROR)                                                             \
    /* EE1003 - Invalid_Argument */                                           \
    X(EE1003, "EE1003",                                                       \
      ("func", "value", "param", "expect"),                                   \
      "%s failed because value %s for parameter %s is invalid. "              \
      "Expected value: %s. ErrorCode=EE1003.\n",                              \
      DLOG_ERROR)                                                             \
    /* EE1004 - Invalid_Argument_Null_Pointer */                              \
    X(EE1004, "EE1004",                                                       \
      ("func", "param"),                                                      \
      "%s failed because %s cannot be a NULL pointer. ErrorCode=EE1004.\n",   \
      DLOG_ERROR)                                                             \
    /* EE1005 - Not_Supported */                                              \
    X(EE1005, "EE1005",                                                       \
      ("func"),                                                               \
      "The current system or device does not support %s. "                    \
      "ErrorCode=EE1005.\n",                                                  \
      DLOG_ERROR)                                                             \
    /* EE1006 - Not_Supported */                                              \
    X(EE1006, "EE1006",                                                       \
      ("func", "type"),                                                       \
      "%s execution failed because %s is not supported. "                     \
      "ErrorCode=EE1006.\n",                                                  \
      DLOG_ERROR)                                                             \
    /* EE1007 - Resource_Error_Bind_Stream */                                 \
    X(EE1007, "EE1007",                                                       \
      ("id", "reason"),                                                       \
      "Failed to bind stream with ID %s. Reason: %s. ErrorCode=EE1007.\n",    \
      DLOG_ERROR)                                                             \
    /* EE1009 - Execution_Error_Model */                                      \
    X(EE1009, "EE1009",                                                       \
      ("id", "reason"),                                                       \
      "Failed to execute model with ID %s. Reason: %s. "                      \
      "ErrorCode=EE1009.\n",                                                  \
      DLOG_ERROR)                                                             \
    /* EE1010 - Execution_Error_Invalid_Context */                            \
    X(EE1010, "EE1010",                                                       \
      ("func", "object"),                                                     \
      "%s execution failed because %s does not belong to the current "        \
      "context. ErrorCode=EE1010.\n",                                         \
      DLOG_ERROR)                                                             \
    /* EE1011 - Invalid_Argument */                                           \
    X(EE1011, "EE1011",                                                       \
      ("func", "value", "param", "reason"),                                   \
      "%s failed. Value %s for parameter %s is invalid. "                     \
      "Reason: %s. ErrorCode=EE1011.\n",                                      \
      DLOG_ERROR)                                                             \
    /* EE1012 - Invalid_Argument */                                           \
    X(EE1012, "EE1012",                                                       \
      ("func", "value", "param", "reason"),                                   \
      "%s failed. Value %s for %s is invalid. "                               \
      "Reason: %s. ErrorCode=EE1012.\n",                                      \
      DLOG_ERROR)                                                             \
    /* EE1013 - Resource_Error_Insufficient_Host_Memory */                    \
    X(EE1013, "EE1013",                                                       \
      ("buf_size"),                                                           \
      "Failed to allocate %s bytes host memory for Runtime. "                 \
      "ErrorCode=EE1013.\n",                                                  \
      DLOG_ERROR)                                                             \
    /* EE1014 - File_Operation_Error_Parse */                                 \
    X(EE1014, "EE1014",                                                       \
      ("reason"),                                                             \
      "Failed to parse the binary file of the operator. "                     \
      "Reason: %s. ErrorCode=EE1014.\n",                                      \
      DLOG_ERROR)                                                             \
    /* EE1015 - Package_Error_Incorrect_Driver_Version */                     \
    X(EE1015, "EE1015",                                                       \
      ("func", "reason"),                                                     \
      "%s failed. Reason: The driver version capacity is insufficient. %s "   \
      "ErrorCode=EE1015.\n",                                                  \
      DLOG_ERROR)                                                             \
    /* EE1016 - Not_Supported */                                              \
    X(EE1016, "EE1016",                                                       \
      ("func", "reason"),                                                     \
      "%s failed. Reason: %s. ErrorCode=EE1016.\n",                           \
      DLOG_ERROR)                                                             \
    /* EE1017 - Invalid_Argument */                                           \
    X(EE1017, "EE1017",                                                       \
      ("func", "param", "reason"),                                            \
      "%s failed. Parameter %s is invalid. Reason: %s. ErrorCode=EE1017.\n",  \
      DLOG_ERROR)                                                             \
    /* EE1018 - Invalid_Argument_API_Call_Sequence */                         \
    X(EE1018, "EE1018",                                                       \
      ("func", "reason"),                                                     \
      "%s failed. Reason: %s. ErrorCode=EE1018.\n",                           \
      DLOG_ERROR)                                                             \
    /* EE1019 - Execution_Error */                                            \
    X(EE1019, "EE1019",                                                       \
      ("func", "reason"),                                                     \
      "%s failed. "                                                           \
      "Reason: %s. ErrorCode=EE1019.\n",                                      \
      DLOG_ERROR)                                                             \
    /* EE1020 - Invalid_Argument */                                           \
    X(EE1020, "EE1020",                                                       \
      ("func1", "func2", "ret_code", "reason", "extend_info"),                \
      "%s failed. Reason: Standard function %s failed. "                      \
      "[Errno %s] %s. %s ErrorCode=EE1020.\n",                                \
      DLOG_ERROR)                                                             \
    /* EE1021 - Resource_Error */                                               \
    X(EE1021, "EE1021",                                                         \
      ("resource_type", "api"),                                                 \
      "The runtime module failed to create host %s through API %s. ErrorCode=EE1021.\n", \
      DLOG_ERROR)                                                               \
    /* EE2002 - Config_Error_Invalid_Environment_Variable */                  \
    X(EE2002, "EE2002",                                                       \
      ("value", "env", "expect"),                                             \
      "Value %s for environment variable %s is invalid. "                     \
      "Expected value: %s. ErrorCode=EE2002.\n",                              \
      DLOG_ERROR)                                                             \
    /* WE0001 - Not_Supported (Warning 级别) */                                \
    X(WE0001, "WE0001",                                                       \
      ("function", "type"),                                                   \
      "Failed to %s because %s is not supported. ErrorCode=WE0001.\n",        \
      DLOG_WARN)

#endif // RUNTIME_ERROR_CODE_META_H
