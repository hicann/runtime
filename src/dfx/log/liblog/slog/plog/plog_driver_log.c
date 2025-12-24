/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */


#include "plog_driver_log.h"
#include "dlog_core.h"
#include "plog_driver_api.h"
#include "ascend_hal.h"
#include "plog_drv.h"
#include "log_print.h"
#include "log_system_api.h"
#include "log_common.h"
#include "dlog_message.h"
#include "mmpa_api.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef HAL_REGISTER_ALOG
STATIC void PlogDriverLog(int32_t moduleId, int32_t level, const char *fmt, ...)
{
    if ((moduleId < 0) || (fmt == NULL)) {
        return;
    }

    LogMsgArg msgArg = {
        (uint32_t)moduleId & MODULE_ID_MASK,
        (uint32_t)moduleId & LOG_TYPE_MASK,
        level,
        0,
        {APPLICATION, 0, 0, 0, {'\0'}},
        {'\0'},
        {NULL, 0}
    };

    va_list list;
    va_start(list, fmt);
    (void)DlogWriteInner(&msgArg, fmt, list);
    va_end(list);
}

STATIC uint32_t PlogGetLogLevelByEnv(void)
{
    const char *env = NULL;
    MM_SYS_GET_ENV(MM_ENV_ASCEND_GLOBAL_LOG_LEVEL, (env));
    if (env != NULL) {
        int64_t tmpL = -1;
        if ((LogStrToInt(env, &tmpL) == LOG_SUCCESS) && (tmpL <= LOG_MAX_LEVEL) && (tmpL >= LOG_MIN_LEVEL)) {
            SELF_LOG_INFO("get env ASCEND_GLOBAL_LOG_LEVEL(%" PRId64 ").", tmpL);
            return (uint32_t)tmpL;
        }
    }
    SELF_LOG_INFO("can not get global log level from env, maybe is's null. Use default: %d",
                  GLOABLE_DEFAULT_LOG_LEVEL);
    return GLOABLE_DEFAULT_LOG_LEVEL;
}

void PlogRegisterDriverLog(void)
{
    struct log_out_handle handle;
    handle.DlogInner = PlogDriverLog;
    handle.logLevel = PlogGetLogLevelByEnv();
    drvError_t errNum = LogdrvCtl((int32_t)HAL_CTL_REGISTER_RUN_LOG_OUT_HANDLE, &handle, sizeof(handle), NULL, NULL);
    if (errNum != DRV_ERROR_NONE) {
        errNum = LogdrvCtl((int32_t)HAL_CTL_REGISTER_LOG_OUT_HANDLE, &handle, sizeof(handle), NULL, NULL);
        ONE_ACT_ERR_LOG(errNum != DRV_ERROR_NONE, return, "register DlogInner function to Hal failed");
        SELF_LOG_INFO("plog register DlogInner function to Hal by LOG_OUT_HANDLE.");
        return;
    }
    SELF_LOG_INFO("plog register DlogInner function to Hal by RUN_LOG_OUT_HANDLE.");
}

void PlogUnregisterDriverLog(void)
{
    drvError_t ret = LogdrvCtl((int32_t)HAL_CTL_UNREGISTER_LOG_OUT_HANDLE, NULL, 0, NULL, NULL);
    NO_ACT_ERR_LOG(ret != DRV_ERROR_NONE, "unregister DlogInner function to Hal failed");
}

#else

void PlogRegisterDriverLog(void)
{
    return;
}

void PlogUnregisterDriverLog(void)
{
    return;
}
#ifdef __cplusplus
}
#endif
#endif

