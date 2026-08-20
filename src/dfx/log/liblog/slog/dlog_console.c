/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dlog_console.h"
#include <stdlib.h>
#include <string.h>
#include "dlog_core.h"
#include "dlog_attr.h"
#include "log_print.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

/**
 * @brief       : check env_stdout is enable or not, execute getenv only once
 * @return      : true   enable; false   disable
 */
// stdout 开关取值缓冲区长度：合法值为 "0"/"1"，预留冗余以识别非法长值。
// 取值长度 < 本值时告警可回显具体取值；>= 本值时告警不回显取值。
#define STDOUT_ENV_VALUE_LEN 16U

// stdout 开关环境变量名。集中定义，使读取与废弃告警共用同一来源，避免拼写不一致。
#define STDOUT_ENV_NAME "ASCEND_LOG_PRINT_TO_STDOUT"
#define STDOUT_ENV_NAME_DEPRECATED "ASCEND_SLOG_PRINT_TO_STDOUT"

// 读取单个环境变量并判定 stdout 开关，输出维测日志。
// replacementName 非 NULL 时，表示 envName 已废弃、应改用 replacementName，
// 在确认变量存在后先打印一次废弃告警；为 NULL 表示 envName 未废弃，不打印该告警。
// 注意：本参数用于旧变量兼容期，计划随旧变量在 13.0.0 版本一并移除，详见 DlogCheckEnvStdout 中的说明。
// 返回 true 表示该变量已配置，*enabled 为判定结果(1 开启/0 关闭)；返回 false 表示未配置。
STATIC bool DlogGetStdoutEnv(const char* envName, const char* replacementName, int32_t* enabled)
{
    const char* envValue = getenv(envName);
    if (envValue == NULL) {
        return false; // 未配置
    }
    if (replacementName != NULL) {
        // 变量名由参数传入，函数内不硬编码具体变量名。
        // 告警不写死移除版本：移除版本由资料承载，避免版本调整需同步改代码。
        SELF_LOG_WARN("Environment variable '%s' is deprecated; use '%s' instead.", envName, replacementName);
    }
    if (strlen(envValue) >= STDOUT_ENV_VALUE_LEN) {
        // 已配置但取值过长 → 非法值（不回显）
        SELF_LOG_WARN(
            "Invalid value for environment variable '%s'; expected '0' or '1'. "
            "Log-to-stdout disabled.",
            envName);
        *enabled = 0;
        return true;
    }
    if (strcmp(envValue, "1") == 0) {
        SELF_LOG_INFO("Log-to-stdout enabled by environment variable '%s'.", envName);
        *enabled = 1;
    } else if (strcmp(envValue, "0") == 0) {
        *enabled = 0; // 显式关闭即默认行为，保持静默
    } else {
        SELF_LOG_WARN(
            "Invalid value '%s' for environment variable '%s'; expected '0' or '1'. "
            "Log-to-stdout disabled.",
            envValue, envName);
        *enabled = 0;
    }
    return true;
}

bool DlogCheckEnvStdout(void)
{
    static int32_t stdoutFlag = -1;
    if (stdoutFlag == -1) {
        int32_t enabled = 0;
        // 新变量优先：ASCEND_LOG_PRINT_TO_STDOUT（未废弃，故 replacementName 传 NULL）
        if (DlogGetStdoutEnv(STDOUT_ENV_NAME, NULL, &enabled)) {
            stdoutFlag = enabled;
        } else if (DlogGetStdoutEnv(STDOUT_ENV_NAME_DEPRECATED, STDOUT_ENV_NAME, &enabled)) {
            // 新变量未配置时回退旧变量（兼容期保留），并提示废弃。
            //
            // 旧变量 ASCEND_SLOG_PRINT_TO_STDOUT 在 CANN 9.2.0 标记废弃，计划在 13.0.0 版本
            // 随资料一并删除。届时应移除本回退分支、STDOUT_ENV_NAME_DEPRECATED 宏及其废弃
            // 告警，并同步清理相关 UT（TC-768-003/007/009 等依赖旧变量的用例）。
            // 注意：删除后旧变量将不再生效，属预期的不兼容变更，需在版本说明中明确告知。
            stdoutFlag = enabled;
        } else {
            // 两者均未配置：默认关闭，保持静默
            stdoutFlag = 0;
        }
    }
    return (stdoutFlag == 1) ? true : false;
}

/**
 * @brief       : write to console
 * @param [in]  : logMsg        struct of log message
 */
void DlogWriteToConsole(LogMsg* logMsg)
{
#ifndef _LOG_UT
    DlogSetMessageNl(logMsg);
    int32_t fd = ToolFileno(stdout);
    ONE_ACT_ERR_LOG(fd <= 0, return, "file_handle is invalid, file_handle=%d.", fd);
    (void)ToolWrite(fd, (void*)logMsg->logContent, logMsg->contentLength);
#else
    return;
#endif
}

#ifdef __cplusplus
}
#endif // __cplusplus
