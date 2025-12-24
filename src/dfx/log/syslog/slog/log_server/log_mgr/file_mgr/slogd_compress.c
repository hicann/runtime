/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "slogd_compress.h"

#if defined(SOFTWARE_ZIP) || defined(HARDWARE_ZIP)

#include "log_compress/log_compress.h"
#include "log_file_info.h"
#include "log_file_util.h"
#include "log_pm.h"
#include "log_pm_sig.h"
#include "log_print.h"
#include "log_iam_pub.h"

STATIC enum IAMResourceStatus g_slogdCompressResStatus = IAM_RESOURCE_WAITING;

static INLINE bool SlogdCompressServiceIsValid(void)
{
    return (g_slogdCompressResStatus == IAM_RESOURCE_READY);
}

STATIC INLINE void SlogdSetCompressStatus(enum IAMResourceStatus status)
{
    g_slogdCompressResStatus = status;
}

#if defined(HARDWARE_ZIP)

#define SLOGD_IAM_RES_FILE_NUM     1
#define SLOGD_IAM_RES_TIMEOUT      (-1)

bool SlogdCompressIsValid(void)
{
    // if system in sleep, can not compress until wake up
    if (LogPmGetSystemStatus() == SLEEP) {
        SlogdSubscribeToWakeUpState();
    }
    return ((LogPmGetSystemStatus() != SLEEP) && SlogdCompressServiceIsValid());
}

LogStatus SlogdCompress(const char *source, uint32_t sourceLen, char **dest, uint32_t *destLen)
{
    if (SlogdCompressIsValid()) {
        return LogCompressBuffer(source, sourceLen, dest, destLen);
    }
    return LOG_SERVICE_NOT_READY;
}

/**
 * @brief           : kms resource call back function, when status is ready, set compress status ready
 * @param[in]       : resList       resource list with status
 * @param[in]       : listNum       resource list number
 * @return          : NULL
 */
STATIC void SlogdKmsResStatusCb(struct IAMVirtualResourceStatus *resList, const int32_t listNum)
{
    ONE_ACT_ERR_LOG((resList == NULL) || (listNum == 0), return,
                    "kms resource status cb input null, pid = %d.", ToolGetPid());
    for (int32_t i = 0; i < listNum; i++) {
        if (strcmp(KMS_IAM_SERVICE_PATH, resList[i].IAMResName) == 0) {
            SlogdSetCompressStatus(resList[i].status);
            SELF_LOG_INFO("kms resource status update finished, status = %d, pid = %d.",
                          (int32_t)resList[i].status, ToolGetPid());
        }
    }
}

/**
 * @brief           : init compress resource
 * @return          : == LOG_SUCCESS success; others failure
 */
LogStatus SlogdCompressInit(void)
{
    struct IAMVirtualResourceStatus virtualResStatus = { KMS_IAM_SERVICE_PATH, IAM_RESOURCE_WAITING };
    struct IAMResourceSubscribeConfig iamResSubConfig = {
        &virtualResStatus, SLOGD_IAM_RES_FILE_NUM, SLOGD_IAM_RES_TIMEOUT
    };
    int32_t ret = IAMRegResStatusChangeCb(SlogdKmsResStatusCb, iamResSubConfig);
    if (ret == 0) {
        SELF_LOG_INFO("kms resource register success, pid = %d.", ToolGetPid());
    } else {
        SELF_LOG_ERROR("kms resource register failed, ret = %d, errno = %d, pid = %d.",
                       ret, ToolGetErrorCode(), ToolGetPid());
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

void SlogdCompressExit(void)
{
    int32_t ret = IAMUnregAssignedResStatusChangeCb((char *)KMS_IAM_SERVICE_PATH);
    if (ret == 0) {
        SELF_LOG_INFO("kms resource unregister success, pid = %d.", ToolGetPid());
    } else {
        SELF_LOG_ERROR("kms resource unregister failed, ret = %d, errno = %d, pid = %d.",
                       ret, ToolGetErrorCode(), ToolGetPid());
    }
}

#else

bool SlogdCompressIsValid(void)
{
    return true;
}

LogStatus SlogdCompress(const char *source, uint32_t sourceLen, char **dest, uint32_t *destLen)
{
    return LogCompressBuffer(source, sourceLen, dest, destLen);
}

/**
 * @brief           : init compress resource
 * @return          : == LOG_SUCCESS success; others failure
 */
LogStatus SlogdCompressInit(void)
{
    SlogdSetCompressStatus(IAM_RESOURCE_READY);
    return LOG_SUCCESS;
}

void SlogdCompressExit(void)
{
    return;
}
#endif // HARDWARE_ZIP

#else
LogStatus SlogdCompressInit(void)
{
    return LOG_SUCCESS;
}

void SlogdCompressExit(void)
{
    return;
}

bool SlogdCompressIsValid(void)
{
    return true;
}

LogStatus SlogdCompress(const char *source, uint32_t sourceLen, char **dest, uint32_t *destLen)
{
    (void)source;
    (void)sourceLen;
    (void)dest;
    (void)destLen;
    return LOG_SUCCESS;
}
#endif // SOFTWARE_ZIP || HARDWARE_ZIP