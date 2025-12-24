/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "slogd_dev_mgr.h"
#include "log_common.h"
#include "log_print.h"
#include "ascend_hal.h"

STATIC uint32_t g_deviceIdToHostDeviceId[DEVICE_MAX_DEV_NUM];
STATIC int64_t g_devType = -1;

void SlogdInitDeviceId(void)
{
    for (int32_t i = 0; i < DEVICE_MAX_DEV_NUM; i++) {
        g_deviceIdToHostDeviceId[i] = HOST_MAX_DEV_NUM;
    }
#ifndef HAL_PRODUCT_TYPE_POD
#define HAL_PRODUCT_TYPE_POD 100
#endif
#ifdef _LOG_UT_
#ifndef INFO_TYPE_PRODUCT_TYPE
#define INFO_TYPE_PRODUCT_TYPE 100
#endif
    if (halGetDeviceInfo(0, MODULE_TYPE_SYSTEM, INFO_TYPE_PRODUCT_TYPE, &g_devType) != 0) {
        g_devType = -1;
    }
#endif
    g_devType = -1; // stub for esl
    SELF_LOG_INFO("get device type=%ld", g_devType);
}

bool SlogdIsDevicePooling(void)
{
    return (g_devType == HAL_PRODUCT_TYPE_POD);
}

uint32_t GetHostDeviceID(uint32_t deviceId)
{
#if defined(EP_MODE)
    uint32_t devNum = 0;
    drvError_t ret = drvGetDevNum(&devNum);
    if (ret != DRV_ERROR_NONE) {
        SELF_LOG_ERROR("get device num failed, result=%d.", (int32_t)ret);
        return deviceId;
    }

    if ((deviceId >= devNum) || (deviceId >= HOST_MAX_DEV_NUM)) {
        return deviceId;
    }
    uint32_t hostDeviceId = 0;
    ret = drvGetDevIDByLocalDevID(deviceId, &hostDeviceId);
    if (ret != DRV_ERROR_NONE) {
        SELF_LOG_WARN("get host side device-id by device device-id=%u, result=%d", deviceId, (int32_t)ret);
        return deviceId;
    }
    return hostDeviceId;
#else
    return deviceId;
#endif
}

/**
 * @brief           : get host side device id by device side device id
 * @param [in]      : deviceId         device side device id
 * @return          : host side device id
 */
uint32_t GetHostSideDeviceId(uint32_t deviceId)
{
    if (deviceId < DEVICE_MAX_DEV_NUM) {
        if (g_deviceIdToHostDeviceId[deviceId] == HOST_MAX_DEV_NUM) {
            uint32_t hostDevId = GetHostDeviceID(deviceId);
            g_deviceIdToHostDeviceId[deviceId] = hostDevId;
        }
        return g_deviceIdToHostDeviceId[deviceId];
    }
    return deviceId;
}

/**
 * @brief           : get device side device id by host side device id
 * @param [in]      : hostDevId         host side device id
 * @return          : device side device id
 */
uint32_t GetDeviceSideDeviceId(uint32_t hostDevId)
{
    if (hostDevId < HOST_MAX_DEV_NUM) {
        for (uint32_t i = 0; i < DEVICE_MAX_DEV_NUM; i++) {
            if (g_deviceIdToHostDeviceId[i] == hostDevId) {
                return i;
            }
        }
    }
    return hostDevId;
}

