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
#include "dlog_core.h"
#include "dlog_attr.h"
#include "mmpa_api.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

/**
 * @brief       : check env_stdout is enable or not, execute getenv only once
 * @return      : true   enable; false   disable
 */
bool DlogCheckEnvStdout(void)
{
    static int32_t stdoutFlag = -1;
    if (stdoutFlag == -1) {   
        const char *envres = NULL;
        MM_SYS_GET_ENV(MM_ENV_ASCEND_SLOG_PRINT_TO_STDOUT, (envres));
        if ((envres != NULL) && (strcmp(envres, "1") == 0)) {
            stdoutFlag = 1;
        } else {
            stdoutFlag = 0;
        }
    }
    return (stdoutFlag == 1) ? true : false;
}

/**
 * @brief       : write to console
 * @param [in]  : logMsg        struct of log message
 */
void DlogWriteToConsole(LogMsg *logMsg)
{
#ifndef _LOG_UT
    DlogSetMessageNl(logMsg);
    int32_t fd = ToolFileno(stdout);
    ONE_ACT_ERR_LOG(fd <= 0, return, "file_handle is invalid, file_handle=%d.", fd);
    (void)ToolWrite(fd, (void *)logMsg->logContent, logMsg->contentLength);
#else
    return;
#endif
}

#ifdef __cplusplus
}
#endif // __cplusplus