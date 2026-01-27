/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef LITE_OS
#include "file_transport.h"
#include "logger/logger.h"
#include "osal/osal_mem.h"
#include "file_interface.h"

static int32_t CreateProfAllDir(const char *flushDir)
{
    // copy flush dir
    char path[MAX_OUTPUT_FILE_LEGTH] = { 0 };
    errno_t ret = strcat_s(path, sizeof(path), flushDir);
    PROF_CHK_EXPR_ACTION(ret != EOK, return PROFILING_FAILED,
        "Failed to strcat_s for dir: %s, ret: %d.", flushDir, ret);
    // create data dir
    ret = strcat_s(path, sizeof(path), "/data");
    PROF_CHK_EXPR_ACTION(ret != EOK, return PROFILING_FAILED,
        "Failed to strcat_s for dir: %s, ret: %d.", flushDir, ret);
    if (!CreateDirectory(path)) {
        MSPROF_LOGE("Failed to create dir: %s.", path);
        return PROFILING_FAILED;
    }

    MSPROF_LOGI("Success to create all prof dir: %s.", path);
    return PROFILING_SUCCESS;
}

int32_t FileInitTransport(uint32_t deviceId, Transport* transport, const char *flushDir)
{
    if (transport == NULL) {
        MSPROF_LOGE("Failed to init file transport because transport is nullptr.");
        return PROFILING_FAILED;
    }
    int32_t ret = CreateProfAllDir(flushDir);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to create all prof dir: %s.", flushDir);
        return PROFILING_FAILED;
    }
    ret = ProfInitTransport(deviceId, flushDir, "200MB");
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to init prof transport: %s.", flushDir);
        return PROFILING_FAILED;
    }
    transport->SendBuffer = ProfSendBuffer;
    MSPROF_LOGI("Success to init file transport.");
    return PROFILING_SUCCESS;
}
#endif