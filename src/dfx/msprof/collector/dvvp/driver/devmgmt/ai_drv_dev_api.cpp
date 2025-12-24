/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ai_drv_dev_api.h"
#include <set>
#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "ascend_hal.h"
#include "config_manager.h"

namespace analysis {
namespace dvvp {
namespace driver {
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Config;

int32_t DrvGetDevNum(void)
{
    uint32_t numDev = 0;
    drvError_t ret = drvGetDevNum(&numDev);
    if (ret == DRV_ERROR_NOT_SUPPORT) {
        MSPROF_LOGW("Driver doesn't support drvGetDevNum interface, ret=%d", static_cast<int32_t>(ret));
        return PROFILING_SUCCESS;
    }
    if (ret != DRV_ERROR_NONE || numDev > DEV_NUM) {
        MSPROF_LOGE("Failed to drvGetDevNum, ret=%d, num=%u", static_cast<int32_t>(ret), numDev);
        MSPROF_CALL_ERROR("EK9999", "Failed to drvGetDevNum, ret=%d, num=%u",
            static_cast<int32_t>(ret), numDev);
        return PROFILING_FAILED;
    }

    MSPROF_LOGI("Succeeded to drvGetDevNum, numDev=%u", numDev);
    return static_cast<int32_t>(numDev);
}

int32_t DrvGetDevIds(int32_t numDevices, std::vector<int32_t> &devIds)
{
    devIds.clear();

    if (numDevices <= 0 || numDevices > DEV_NUM) {
        return PROFILING_FAILED;
    }

    uint32_t devices[DEV_NUM] = { 0 };
    const drvError_t ret = drvGetDevIDs(devices, static_cast<uint32_t>(numDevices));
    if (ret != DRV_ERROR_NONE) {
        MSPROF_LOGE("Failed to drvGetDevIDs, ret=%d", static_cast<int32_t>(ret));
        MSPROF_CALL_ERROR("EK9999", "Failed to drvGetDevIDs, ret=%d",
            static_cast<int32_t>(ret));
        return PROFILING_FAILED;
    }

    MSPROF_LOGI("Succeeded to drvGetDevIDs, numDevices=%d", numDevices);
    for (int32_t ii = 0; ii < numDevices; ++ii) {
        devIds.push_back(static_cast<int32_t>(devices[ii]));
    }

    return PROFILING_SUCCESS;
}

int32_t DrvGetPlatformInfo(uint32_t &platformInfo)
{
    drvError_t ret = drvGetPlatformInfo(&platformInfo);
    if (ret != DRV_ERROR_NONE) {
        if (ret != MSPROF_HELPER_HOST) {
            MSPROF_LOGE("Failed to drvGetPlatformInfo, ret=%d", static_cast<int32_t>(ret));
            MSPROF_CALL_ERROR("EK9999", "Failed to drvGetPlatformInfo, ret=%d",
                static_cast<int32_t>(ret));
            return PROFILING_FAILED;
        }
    }
    return PROFILING_SUCCESS;
}

int32_t DrvGetEnvType(uint32_t deviceId, int64_t &envType)
{
    const drvError_t ret = halGetDeviceInfo(deviceId, static_cast<int32_t>(MODULE_TYPE_SYSTEM),
        static_cast<int32_t>(INFO_TYPE_ENV), &envType);
    if (ret == DRV_ERROR_NONE) {
        MSPROF_LOGI("Succeeded to DrvGetEnvType, deviceId=%u", deviceId);
        return PROFILING_SUCCESS;
    } else if (ret == DRV_ERROR_NOT_SUPPORT) {
        MSPROF_LOGW("Driver doesn't support DrvGetEnvType by halGetDeviceInfo interface, "
            "deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
        return PROFILING_SUCCESS;
    }

    MSPROF_LOGE("Failed to DrvGetEnvType, deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
    MSPROF_CALL_ERROR("EK9999", "Failed to DrvGetEnvType, deviceId=%u, ret=%d",
        deviceId, static_cast<int32_t>(ret));
    return PROFILING_FAILED;
}

int32_t DrvGetCtrlCpuId(uint32_t deviceId, int64_t &ctrlCpuId)
{
    drvError_t ret = halGetDeviceInfo(deviceId, static_cast<int32_t>(MODULE_TYPE_CCPU),
        static_cast<int32_t>(INFO_TYPE_ID), &ctrlCpuId);
    if (ret == DRV_ERROR_NONE) {
        MSPROF_LOGI("Succeeded to DrvGetCtrlCpuId, deviceId=%u", deviceId);
        return PROFILING_SUCCESS;
    } else if (ret == DRV_ERROR_NOT_SUPPORT) {
        MSPROF_LOGW("Driver doesn't support DrvGetCtrlCpuId by halGetDeviceInfo interface, "
            "deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
        return PROFILING_SUCCESS;
    }

    MSPROF_LOGE("Failed to DrvGetCtrlCpuId, deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
    MSPROF_CALL_ERROR("EK9999", "Failed to DrvGetCtrlCpuId, deviceId=%u, ret=%d",
        deviceId, static_cast<int32_t>(ret));
    return PROFILING_FAILED;
}

int32_t DrvGetCtrlCpuCoreNum(uint32_t deviceId, int64_t &ctrlCpuCoreNum)
{
    drvError_t ret = halGetDeviceInfo(deviceId, static_cast<int32_t>(MODULE_TYPE_CCPU),
        static_cast<int32_t>(INFO_TYPE_CORE_NUM), &ctrlCpuCoreNum);
    if (ret == DRV_ERROR_NONE) {
        MSPROF_LOGI("Succeeded to DrvGetCtrlCpuCoreNum, deviceId=%u", deviceId);
        return PROFILING_SUCCESS;
    } else if (ret == DRV_ERROR_NOT_SUPPORT) {
        MSPROF_LOGW("Driver doesn't support DrvGetCtrlCpuCoreNum by halGetDeviceInfo interface, "
            "deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
        return PROFILING_SUCCESS;
    }

    MSPROF_LOGE("Failed to DrvGetCtrlCpuCoreNum, deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
    MSPROF_CALL_ERROR("EK9999", "Failed to DrvGetCtrlCpuCoreNum, deviceId=%u, ret=%d",
        deviceId, static_cast<int32_t>(ret));
    return PROFILING_FAILED;
}

int32_t DrvGetCtrlCpuEndianLittle(uint32_t deviceId, int64_t &ctrlCpuEndianLittle)
{
    drvError_t ret = halGetDeviceInfo(deviceId, static_cast<int32_t>(MODULE_TYPE_CCPU),
        static_cast<int32_t>(INFO_TYPE_ENDIAN), &ctrlCpuEndianLittle);
    if (ret == DRV_ERROR_NONE) {
        MSPROF_LOGI("Succeeded to DrvGetCtrlCpuEndianLittle, deviceId=%u", deviceId);
        return PROFILING_SUCCESS;
    } else if (ret == DRV_ERROR_NOT_SUPPORT) {
        MSPROF_LOGW("Driver doesn't support DrvGetCtrlCpuEndianLittle by halGetDeviceInfo interface, "
            "deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
        return PROFILING_SUCCESS;
    }

    MSPROF_LOGE("Failed to DrvGetCtrlCpuEndianLittle, deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
    MSPROF_CALL_ERROR("EK9999", "Failed to DrvGetCtrlCpuEndianLittle, deviceId=%u, ret=%d",
        deviceId, static_cast<int32_t>(ret));
    return PROFILING_FAILED;
}

int32_t DrvGetAiCpuCoreNum(uint32_t deviceId, int64_t &aiCpuCoreNum)
{
    const drvError_t ret = halGetDeviceInfo(deviceId, static_cast<int32_t>(MODULE_TYPE_AICPU),
        static_cast<int32_t>(INFO_TYPE_CORE_NUM), &aiCpuCoreNum);
    if (ret == DRV_ERROR_NONE) {
        MSPROF_LOGI("Succeeded to DrvGetAiCpuCoreNum, deviceId=%u", deviceId);
        return PROFILING_SUCCESS;
    } else if (ret == DRV_ERROR_NOT_SUPPORT) {
        MSPROF_LOGW("Driver doesn't support DrvGetAiCpuCoreNum by halGetDeviceInfo interface, "
            "deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
        return PROFILING_SUCCESS;
    }

    MSPROF_LOGE("Failed to DrvGetAiCpuCoreNum, deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
    MSPROF_CALL_ERROR("EK9999", "Failed to DrvGetAiCpuCoreNum, deviceId=%u, ret=%d",
        deviceId, static_cast<int32_t>(ret));
    return PROFILING_FAILED;
}

int32_t DrvGetAiCpuCoreId(uint32_t deviceId, int64_t &aiCpuCoreId)
{
    const drvError_t ret = halGetDeviceInfo(deviceId, static_cast<int32_t>(MODULE_TYPE_AICPU),
        static_cast<int32_t>(INFO_TYPE_ID), &aiCpuCoreId);
    if (ret == DRV_ERROR_NONE) {
        MSPROF_LOGI("Succeeded to DrvGetAiCpuCoreId, deviceId=%u", deviceId);
        return PROFILING_SUCCESS;
    } else if (ret == DRV_ERROR_NOT_SUPPORT) {
        MSPROF_LOGW("Driver doesn't support DrvGetAiCpuCoreId by halGetDeviceInfo interface, "
            "deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
        return PROFILING_SUCCESS;
    }

    MSPROF_LOGE("Failed to DrvGetAiCpuCoreId, deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
    MSPROF_CALL_ERROR("EK9999", "Failed to DrvGetAiCpuCoreId, deviceId=%u, ret=%d",
        deviceId, static_cast<int32_t>(ret));
    return PROFILING_FAILED;
}

int32_t DrvGetAiCpuOccupyBitmap(uint32_t deviceId, int64_t &aiCpuOccupyBitmap)
{
    const drvError_t ret = halGetDeviceInfo(deviceId, static_cast<int32_t>(MODULE_TYPE_AICPU),
        static_cast<int32_t>(INFO_TYPE_OCCUPY), &aiCpuOccupyBitmap);
    if (ret == DRV_ERROR_NONE) {
        MSPROF_LOGI("Succeeded to DrvGetAiCpuOccupyBitmap, deviceId=%u", deviceId);
        return PROFILING_SUCCESS;
    } else if (ret == DRV_ERROR_NOT_SUPPORT) {
        MSPROF_LOGW("Driver doesn't support DrvGetAiCpuOccupyBitmap by halGetDeviceInfo interface, "
            "deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
        return PROFILING_SUCCESS;
    }

    MSPROF_LOGE("Failed to DrvGetAiCpuOccupyBitmap, deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
    MSPROF_CALL_ERROR("EK9999", "Failed to DrvGetAiCpuOccupyBitmap, deviceId=%u, ret=%d",
        deviceId, static_cast<int32_t>(ret));
    return PROFILING_FAILED;
}

int32_t DrvGetTsCpuCoreNum(uint32_t deviceId, int64_t &tsCpuCoreNum)
{
    drvError_t ret = halGetDeviceInfo(deviceId, MODULE_TYPE_TSCPU, INFO_TYPE_CORE_NUM, &tsCpuCoreNum);
    if (ret == DRV_ERROR_NONE) {
        MSPROF_LOGI("Succeeded to DrvGetTsCpuCoreNum, deviceId=%u", deviceId);
        return PROFILING_SUCCESS;
    } else if (ret == DRV_ERROR_NOT_SUPPORT) {
        MSPROF_LOGW("Driver doesn't support DrvGetTsCpuCoreNum by halGetDeviceInfo interface, "
            "deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
        return PROFILING_SUCCESS;
    }

    MSPROF_LOGE("Failed to DrvGetTsCpuCoreNum, deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
    MSPROF_CALL_ERROR("EK9999", "Failed to DrvGetTsCpuCoreNum, deviceId=%u, ret=%d",
        deviceId, static_cast<int32_t>(ret));
    return PROFILING_FAILED;
}

int32_t DrvGetAiCoreId(uint32_t deviceId, int64_t &aiCoreId)
{
    drvError_t ret = halGetDeviceInfo(deviceId, static_cast<int32_t>(MODULE_TYPE_AICORE),
        static_cast<int32_t>(INFO_TYPE_ID), &aiCoreId);
    if (ret == DRV_ERROR_NONE) {
        MSPROF_LOGI("Succeeded to DrvGetAiCoreId, deviceId=%u", deviceId);
        return PROFILING_SUCCESS;
    } else if (ret == DRV_ERROR_NOT_SUPPORT) {
        MSPROF_LOGW("Driver doesn't support DrvGetAiCoreId by halGetDeviceInfo interface, "
            "deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
        return PROFILING_SUCCESS;
    }

    MSPROF_LOGE("Failed to DrvGetAiCoreId, deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
    MSPROF_CALL_ERROR("EK9999", "Failed to DrvGetAiCoreId, deviceId=%u, ret=%d",
        deviceId, static_cast<int32_t>(ret));
    return PROFILING_FAILED;
}

int32_t DrvGetAiCoreNum(uint32_t deviceId, int64_t &aiCoreNum)
{
    drvError_t ret = halGetDeviceInfo(deviceId, static_cast<int32_t>(MODULE_TYPE_AICORE),
        static_cast<int32_t>(INFO_TYPE_CORE_NUM), &aiCoreNum);
    if (ret == DRV_ERROR_NONE) {
        MSPROF_LOGI("Succeeded to DrvGetAiCoreNum, deviceId=%u, aicNum=%lld", deviceId, aiCoreNum);
        return PROFILING_SUCCESS;
    } else if (ret == DRV_ERROR_NOT_SUPPORT) {
        MSPROF_LOGW("Driver doesn't support DrvGetAiCoreNum by halGetDeviceInfo interface, "
            "deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
        return PROFILING_SUCCESS;
    }

    MSPROF_LOGE("Failed to DrvGetAiCoreNum, deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
    MSPROF_CALL_ERROR("EK9999", "Failed to DrvGetAiCoreNum, deviceId=%u, ret=%d",
        deviceId, static_cast<int32_t>(ret));
    return PROFILING_FAILED;
}

int32_t DrvGetDeviceTime(uint32_t deviceId, uint64_t &startMono, uint64_t &cntvct)
{
    int64_t time = 0;
    drvError_t ret = halGetDeviceInfo(deviceId, static_cast<int32_t>(MODULE_TYPE_SYSTEM),
        static_cast<int32_t>(INFO_TYPE_MONOTONIC_RAW), &time);
    if (ret == DRV_ERROR_NONE) {
        MSPROF_LOGI("Succeeded to DrvGetDeviceTime startMono, devId=%u, startMono=%llu ns",
            deviceId, startMono);
        startMono = static_cast<uint64_t>(time);
    } else if (ret == DRV_ERROR_NOT_SUPPORT) {
        MSPROF_LOGW("Driver doesn't support DrvGetDeviceTime startMono by halGetDeviceInfo interface, "
            "deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
    } else {
        MSPROF_LOGE("Failed to DrvGetDeviceTime startMono, deviceId=%u, ret=%d",
            deviceId, static_cast<int32_t>(ret));
        MSPROF_CALL_ERROR("EK9999", "Failed to DrvGetDeviceTime startMono, deviceId=%u, ret=%d",
            deviceId, static_cast<int32_t>(ret));
        return PROFILING_FAILED;
    }

    ret = halGetDeviceInfo(deviceId, static_cast<int32_t>(MODULE_TYPE_SYSTEM),
        static_cast<int32_t>(INFO_TYPE_SYS_COUNT), &time);
    if (ret == DRV_ERROR_NONE) {
        cntvct = static_cast<uint64_t>(time);
        MSPROF_LOGI("Succeeded to DrvGetDeviceTime cntvct, devId=%u, cntvct=%" PRIu64, deviceId, cntvct);
    } else if (ret == DRV_ERROR_NOT_SUPPORT) {
        MSPROF_LOGW("Driver doesn't support DrvGetDeviceTime cntvct by halGetDeviceInfo interface, "
            "deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
    } else {
        MSPROF_LOGE("Failed to DrvGetDeviceTime cntvct, deviceId=%u, ret=%d",
            deviceId, static_cast<int32_t>(ret));
        MSPROF_CALL_ERROR("EK9999", "Failed to DrvGetDeviceTime cntvct, deviceId=%u, ret=%d",
            deviceId, static_cast<int32_t>(ret));
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

std::string DrvGetDevIdsStr()
{
    int32_t devNum = DrvGetDevNum();
    std::vector<int32_t> devIds;
    int32_t ret = DrvGetDevIds(devNum, devIds);
    if (ret != PROFILING_SUCCESS || devIds.size() == 0) {
        return "";
    } else {
        std::stringstream result;
        for (auto devId : devIds) {
            result << devId << ",";
        }
        return result.str().substr(0, result.str().size() - 1);
    }
}

bool DrvCheckIfHelperHost()
{
    uint32_t numDev = 0;
    drvError_t ret = drvGetDevNum(&numDev);
    if (ret == MSPROF_HELPER_HOST) {
        MSPROF_LOGI("Msprof work in Helper.");
        return true;
    }
    return false;
}

bool DrvGetHostFreq(std::string &freq)
{
    int64_t hostFreq = 0;
    const auto ret = halGetDeviceInfo(0, static_cast<int32_t>(MODULE_TYPE_SYSTEM),
        static_cast<int32_t>(INFO_TYPE_HOST_OSC_FREQUE), &hostFreq);
    if (ret == DRV_ERROR_NONE && hostFreq > 0) {
        MSPROF_LOGI("Succeeded to DrvGetHostFreq frequency=%lld", hostFreq);
        freq = std::to_string(static_cast<float>(hostFreq) / FREQUENCY_KHZ_TO_MHZ);
        return true;
    } else {
        MSPROF_LOGW("Driver doesn't support DrvGetHostFreq by halGetDeviceInfo interface, ret=%d",
            static_cast<int32_t>(ret));
        freq = NOT_SUPPORT_FREQUENCY;
    }

    return false;
}

bool DrvGetDeviceFreq(uint32_t deviceId, std::string &freq)
{
    int64_t deviceFreq = 0;
    auto ret = halGetDeviceInfo(deviceId, static_cast<int32_t>(MODULE_TYPE_SYSTEM),
        static_cast<int32_t>(INFO_TYPE_DEV_OSC_FREQUE), &deviceFreq);
    if (ret == DRV_ERROR_NONE && deviceFreq > 0) {
        MSPROF_LOGI("Succeeded to DrvGetDeviceFreq frequency=%lld", deviceFreq);
        freq = std::to_string(static_cast<float>(deviceFreq) / FREQUENCY_KHZ_TO_MHZ);
        return true;
    } else {
        MSPROF_LOGW("Driver doesn't support DrvGetDeviceFreq by halGetDeviceInfo interface, ret=%d",
            static_cast<int32_t>(ret));
    }

    return false;
}

bool DrvGetDeviceStatus(const uint32_t deviceId)
{
#ifndef OSAL
    drvStatus_t deviceStatus = DRV_STATUS_INITING;
    drvError_t ret = drvDeviceStatus(deviceId, &deviceStatus);
    if (ret == DRV_ERROR_NOT_SUPPORT) {
        MSPROF_LOGW("Driver doesn't support drvDeviceStatus interface, ret=%d", static_cast<int32_t>(ret));
        return true;
    }
    if (ret != DRV_ERROR_NONE) {
        MSPROF_LOGE("Failed to get device %u status.", deviceId);
        return false;
    }
    if (deviceStatus == DRV_STATUS_COMMUNICATION_LOST) {
        MSPROF_LOGW("Device %u status is communication lost.", deviceId);
        return false;
    }
#endif
    UNUSED(deviceId);
    return true;
}

}  // namespace driver
}  // namespace dvvp
}  // namespace analysis
