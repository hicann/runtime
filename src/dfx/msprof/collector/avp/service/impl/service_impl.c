/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "service_impl.h"
#include "service_task.h"
#include "service_param.h"
#include "platform.h"
#include "errno/error_code.h"
#include "logger/logger.h"
#include "transport/uploader.h"

STATIC ProfileAttribute g_profileAttr;

int32_t ServiceImplInitialize(void)
{
    if (g_profileAttr.count > 0) {
        g_profileAttr.count++;
        MSPROF_LOGI("Repeat ServiceImplInitialize, count: %u.", g_profileAttr.count);
        return PROFILING_SUCCESS;
    }
    int32_t ret = PlatformInitialize(&g_profileAttr.count);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Init platform failed, ret : %d", ret);
        return ret;
    }
#ifdef LITE_OS
    g_profileAttr.transType = FLSH_TRANSPORT;
#else
    g_profileAttr.transType = FILE_TRANSPORT;
#endif
    g_profileAttr.apiIndex = 0;
    return PROFILING_SUCCESS;
}

int32_t ServiceImplSetConfig(uint32_t dataType, OsalVoidPtr data, uint32_t dataLength)
{
    if (g_profileAttr.count > 1) {
        MSPROF_LOGI("Repeat ServiceImplSetConfig, count: %u.", g_profileAttr.count);
        return PROFILING_SUCCESS;
    }
    int32_t ret = ServiceParamParseConfig(dataType, data, dataLength, &g_profileAttr.params);
    if (ret != PROFILING_SUCCESS) {
        PlatformFinalize(&g_profileAttr.count);
        MSPROF_LOGE("Set config failed, ret : %d", ret);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ServiceImplRegisterCallback(uint32_t moduleId, ProfCommandHandle handle)
{
    return ReportManagerRegisterModule(&g_profileAttr.reportAttr, moduleId, handle);
}

int32_t ServiceImplStart(uint32_t chipId, uint32_t deviceId)
{
    UNUSED(chipId);
    if (deviceId >= MAX_TASK_SLOT) {
        MSPROF_LOGE("Invalid device id %u", deviceId);
        PlatformFinalize(&g_profileAttr.count);
        return PROFILING_FAILED;
    }
    int32_t ret = ServiceTaskInitialize(&g_profileAttr);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Initialize service task failed, ret : %d", ret);
        PlatformFinalize(&g_profileAttr.count);
        return ret;
    }
    ret = CreateProfMainDir(&g_profileAttr.apiIndex, g_profileAttr.params.config.resultDir);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Create profiling dir failed, ret : %d", ret);
        (void)ServiceImplFinalize();
        return ret;
    }
    ret = ServiceTaskStart(deviceId, &g_profileAttr);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Start service task failed, ret : %d", ret);
        (void)ServiceImplFinalize();
        return ret;
    }
    return PROFILING_SUCCESS;
}

int32_t ServiceImplStop(uint32_t chipId, uint32_t deviceId)
{
    UNUSED(chipId);
    if (deviceId > MAX_TASK_SLOT) {
        MSPROF_LOGE("Invalid device id %u", deviceId);
        return PROFILING_FAILED;
    }
    return ServiceTaskStop(deviceId, &g_profileAttr);
}

int32_t ServiceImplFinalize(void)
{
    if (g_profileAttr.count > 1) {
        g_profileAttr.count--;
        MSPROF_LOGI("Repeat ServiceImplFinalize, count: %u.", g_profileAttr.count);
        return PROFILING_SUCCESS;
    }
    int32_t ret = ServiceTaskFinalize(&g_profileAttr);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Finalize service task failed, ret : %d", ret);
    }
    PlatformFinalize(&g_profileAttr.count);
    // clean g_profileAttr
    (void)memset_s(&g_profileAttr, sizeof(g_profileAttr), 0, sizeof(g_profileAttr));
    return ret;
}
