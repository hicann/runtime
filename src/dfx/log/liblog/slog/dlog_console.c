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
// stdout 打屏阈值取值缓冲区长度：合法值为 "0"/"1"/"2"/"3"，预留冗余以识别非法长值。
// 取值长度 < 本值时告警可回显具体取值；>= 本值时告警不回显取值。
#define STDOUT_ENV_VALUE_LEN 16U

// 打屏档位语义（issue #1307，仅新变量生效）：STDOUT_LEVEL_OFF 关闭；DLOG_DEBUG 无阈值
// （新变量 "1"，通过级别门的日志全部打屏）；DLOG_WARN（"2"，warning 及以上）；DLOG_ERROR（"3"）。
// 旧变量不适配新特性："1" 走 STDOUT_LEVEL_LEGACY 兼容档（定义见 dlog_console.h）。
#define STDOUT_LEVEL_OFF (-1)
#define STDOUT_LEVEL_UNINIT (-2)

// stdout 打屏环境变量名。集中定义，使读取与废弃告警共用同一来源，避免拼写不一致。
#define STDOUT_ENV_NAME "ASCEND_LOG_PRINT_TO_STDOUT"
#define STDOUT_ENV_NAME_DEPRECATED "ASCEND_SLOG_PRINT_TO_STDOUT"

// 全局日志级别环境变量名（与 dlog_level_env.c 的级别初始化同源）。
#define GLOBAL_LEVEL_ENV_NAME "ASCEND_GLOBAL_LOG_LEVEL"

// 读取单个环境变量并判定 stdout 打屏档位，输出维测日志。
// replacementName 非 NULL 时，表示 envName 已废弃、应改用 replacementName，
// 在确认变量存在后先打印一次废弃告警；为 NULL 表示 envName 未废弃，不打印该告警。
// 注意：本参数用于旧变量兼容期，计划随旧变量在 13.0.0 版本一并移除，详见 DlogGetEnvStdoutLevel 中的说明。
// 旧变量不承载 #1307 特性：合法值仅 "0"/"1"，"1" 走兼容档（只打屏不落盘）；
// 新变量合法值 "0"/"1"/"2"/"3"，输出阈值级别，非法值告警的合法值域文案随变量区分。
// 返回 true 表示该变量已配置，*stdoutLevel 为档位判定结果；返回 false 表示未配置。
STATIC bool DlogGetStdoutEnv(const char* envName, const char* replacementName, int32_t* stdoutLevel)
{
    const char* envValue = getenv(envName);
    if (envValue == NULL) {
        return false; // 未配置
    }
    // 变量名由参数传入，函数内不硬编码具体变量名。
    // 告警不写死移除版本：移除版本由资料承载，避免版本调整需同步改代码。
    const bool isLegacyVar = (replacementName != NULL);
    const char* expectedValues = isLegacyVar ? "'0' or '1'" : "'0', '1', '2' or '3'";
    if (isLegacyVar) {
        SELF_LOG_WARN("Environment variable '%s' is deprecated; use '%s' instead.", envName, replacementName);
    }
    if (strlen(envValue) >= STDOUT_ENV_VALUE_LEN) {
        // 已配置但取值过长 → 非法值（不回显）
        SELF_LOG_WARN(
            "Invalid value for environment variable '%s'; expected %s. "
            "Log-to-stdout disabled.",
            envName, expectedValues);
        *stdoutLevel = STDOUT_LEVEL_OFF;
        return true;
    }
    if (strcmp(envValue, "1") == 0) {
        SELF_LOG_INFO("Log-to-stdout enabled by environment variable '%s' (value: %s).", envName, envValue);
        // 旧变量 "1" 走兼容档（#1307 前旧行为：只打屏不落盘）；新变量 "1" 无阈值
        *stdoutLevel = isLegacyVar ? STDOUT_LEVEL_LEGACY : DLOG_DEBUG;
    } else if (!isLegacyVar && (strcmp(envValue, "2") == 0)) {
        SELF_LOG_INFO("Log-to-stdout enabled by environment variable '%s' (value: %s).", envName, envValue);
        *stdoutLevel = DLOG_WARN;
    } else if (!isLegacyVar && (strcmp(envValue, "3") == 0)) {
        SELF_LOG_INFO("Log-to-stdout enabled by environment variable '%s' (value: %s).", envName, envValue);
        *stdoutLevel = DLOG_ERROR;
    } else if (strcmp(envValue, "0") == 0) {
        *stdoutLevel = STDOUT_LEVEL_OFF; // 显式关闭即默认行为，保持静默
    } else {
        SELF_LOG_WARN(
            "Invalid value '%s' for environment variable '%s'; expected %s. "
            "Log-to-stdout disabled.",
            envValue, envName, expectedValues);
        *stdoutLevel = STDOUT_LEVEL_OFF;
    }
    return true;
}

// 读取 ASCEND_GLOBAL_LOG_LEVEL：仅显式配置且取值合法时返回级别值，未配置/非法返回 -1
// （非法值按未配置处理，级别初始化同样按默认值回退）。解析方式与
// DlogInitGlobalLogLevelByEnv 保持一致（LogStrToInt + 级别范围校验），
// 确保两处读取对同一份环境变量得到相同结论。
STATIC int32_t DlogGetGlobalEnvLevel(void)
{
    const char* envValue = getenv(GLOBAL_LEVEL_ENV_NAME);
    if (envValue == NULL) {
        return -1; // 未配置
    }
    int64_t level = -1;
    if ((LogStrToInt(envValue, &level) != LOG_SUCCESS) || (level < DLOG_DEBUG) || (level > DLOG_NULL)) {
        return -1; // 非法值按未配置处理，不参与打屏阈值组合
    }
    return (int32_t)level;
}

// issue #1519：打屏阈值档（新变量 "2"/"3"）与全局级别环境变量取最大值，
// 得到实际打屏阈值：该阈值约束所有日志类别的上屏（run/security 类的落盘级别门
// 不受全局变量影响，但上屏一律受组合阈值约束）；全局变量未配置/非法时不参与组合。
// =1（无阈值档）与旧变量兼容档不参与组合，行为保持不变。
STATIC int32_t DlogCombineStdoutThreshold(int32_t stdoutLevel)
{
    if (stdoutLevel <= DLOG_DEBUG) {
        return stdoutLevel; // 关闭档/无阈值档（=1）不参与组合：组合只收紧阈值，不开启打屏
    }
    int32_t globalLevel = DlogGetGlobalEnvLevel();
    if (globalLevel <= stdoutLevel) {
        return stdoutLevel;
    }
    SELF_LOG_INFO(
        "Log-to-stdout threshold raised from %d to %d by environment variable '%s'.", stdoutLevel, globalLevel,
        GLOBAL_LEVEL_ENV_NAME);
    return globalLevel;
}

/**
 * @brief       : get stdout print threshold level, execute getenv only once
 * @return      : STDOUT_LEVEL_OFF(-1)   disable;
 *                DLOG_DEBUG              no threshold (new env "1");
 *                DLOG_WARN               warning and above (new env "2", combined with global env by #1519);
 *                DLOG_ERROR              error only (new env "3", combined with global env by #1519);
 *                STDOUT_LEVEL_LEGACY     print-only legacy mode (deprecated env "1")
 */
int32_t DlogGetEnvStdoutLevel(void)
{
    static int32_t stdoutLevel = STDOUT_LEVEL_UNINIT;
    if (stdoutLevel == STDOUT_LEVEL_UNINIT) {
        int32_t level = STDOUT_LEVEL_OFF;
        // 新变量优先：ASCEND_LOG_PRINT_TO_STDOUT（未废弃，故 replacementName 传 NULL）
        if (DlogGetStdoutEnv(STDOUT_ENV_NAME, NULL, &level)) {
            stdoutLevel = DlogCombineStdoutThreshold(level);
        } else if (DlogGetStdoutEnv(STDOUT_ENV_NAME_DEPRECATED, STDOUT_ENV_NAME, &level)) {
            // 新变量未配置时回退旧变量（兼容期保留），并提示废弃。
            //
            // 旧变量 ASCEND_SLOG_PRINT_TO_STDOUT 在 CANN 9.2.0 标记废弃，计划在 13.0.0 版本
            // 随资料一并删除。届时应移除本回退分支、STDOUT_ENV_NAME_DEPRECATED 宏及其废弃
            // 告警，并同步清理相关 UT（TC-768-003/007/009 等依赖旧变量的用例）。
            // 注意：删除后旧变量将不再生效，属预期的不兼容变更，需在版本说明中明确告知。
            stdoutLevel = level;
        } else {
            // 两者均未配置：默认关闭，保持静默
            stdoutLevel = STDOUT_LEVEL_OFF;
        }
    }
    return stdoutLevel;
}

bool DlogCheckEnvStdout(void)
{
    // 兼容档(STDOUT_LEVEL_LEGACY)与阈值档(>=0)均视为打屏开启
    return (DlogGetEnvStdoutLevel() != STDOUT_LEVEL_OFF) ? true : false;
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
