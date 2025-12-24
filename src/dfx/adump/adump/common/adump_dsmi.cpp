/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "adump_dsmi.h"
#include "runtime/dev.h"
#include "error_codes/rt_error_codes.h"
#include "ascend_hal.h"
#include "adx_log.h"
#include "sys_utils.h"

#if !defined(ADUMP_SOC_HOST) || ADUMP_SOC_HOST == 1
__attribute__((weak)) drvError_t halGetVdevNum(uint32_t *num_dev);
__attribute__((weak)) drvError_t halGetVdevIDs(uint32_t *devices, uint32_t len);
__attribute__((weak)) drvError_t halGetChipInfo(uint32_t devId, halChipInfo *chipInfo);
__attribute__((weak)) drvError_t halGetAPIVersion(int *halAPIVersion);
#endif

namespace Adx {
uint32_t AdumpDsmi::DrvGetDevNum()
{
    int32_t numDev = 0;
    rtError_t ret = rtGetDeviceCount(&numDev);
    IDE_CTRL_VALUE_WARN(ret != ACL_ERROR_RT_FEATURE_NOT_SUPPORT, return 0,
        "Driver doesn't support rtGetDeviceCount interface, ret=%d", static_cast<int32_t>(ret));
    IDE_CTRL_VALUE_FAILED((ret == RT_ERROR_NONE) && (numDev >= 0) && (numDev <= DEV_NUM), return 0,
        "Failed to get device count, ret=%d, num=%d", static_cast<int32_t>(ret), numDev);

    IDE_LOGD("Succeeded to get device count, numDev=%d", numDev);
    return static_cast<uint32_t>(numDev);
}

bool AdumpDsmi::DrvGetDevIds(uint32_t numDevices, std::vector<uint32_t> &devIds)
{
    devIds.clear();
    if (numDevices > DEV_NUM) {
        return false;
    }
    uint32_t devices[DEV_NUM] = { 0 };
    rtError_t ret = rtGetDeviceIDs(devices, numDevices);
    IDE_CTRL_VALUE_FAILED(ret == RT_ERROR_NONE, return false, "Failed to rtGetDeviceIDs, ret=%d",
        static_cast<int32_t>(ret));
    for (uint32_t i = 0; i < numDevices; ++i) {
        if (DrvGetDeviceStatus(devices[i])) {
            devIds.push_back(devices[i]);
        }
    }

    IDE_LOGD("Succeeded to rtGetDeviceIDs, numDevices=%u, device list num=%zu", numDevices, devIds.size());
    return true;
}

bool AdumpDsmi::DrvGetDeviceStatus(const uint32_t deviceId)
{
    rtDevStatus_t deviceStatus = RT_DEV_STATUS_INITING;
    rtError_t ret = rtGetDeviceStatus(deviceId, &deviceStatus);
    IDE_CTRL_VALUE_WARN(ret != ACL_ERROR_RT_FEATURE_NOT_SUPPORT, return true,
        "Driver doesn't support rtGetDeviceStatus interface, ret=%d", static_cast<int32_t>(ret));

    IDE_CTRL_VALUE_FAILED(ret == RT_ERROR_NONE, return false, "Failed to get device %u status, ret=%d.",
        deviceId, static_cast<int32_t>(ret));

    IDE_CTRL_VALUE_WARN(deviceStatus != RT_DEV_STATUS_COMMUNICATION_LOST, return false,
        "Device %u status is communication lost.", deviceId);
    return true;
}

std::vector<uint32_t> AdumpDsmi::DrvGetDeviceList()
{
    std::vector<uint32_t> devList;
    uint32_t devNum = DrvGetDevNum();
    if ((devNum > 0) && !DrvGetDevIds(devNum, devList)) {
        IDE_LOGW("Get device id list abnormally, device num: %u.", devNum);
    }
    if (devList.empty()) {
        devList.push_back(0);
    }
    return devList;
}

bool AdumpDsmi::DrvGetPlatformType(uint32_t &platformType)
{
    IDE_LOGD("Start to get chip type.");
    std::vector<uint32_t> devList = DrvGetDeviceList();

    int64_t versionInfo = 0;
    uint64_t chipId = 0;
    rtError_t ret = ACL_ERROR_RT_NO_DEVICE;
    for (auto &devId : devList) {
        ret = rtGetDeviceInfo(devId, static_cast<int32_t>(MODULE_TYPE_SYSTEM),
            static_cast<int32_t>(INFO_TYPE_VERSION), &versionInfo);
        if (ret == RT_ERROR_NONE) {
            chipId = ((static_cast<uint64_t>(versionInfo) >> 8) & 0xff); // 8:shift 8 bits, get the low 8 bits(0xff)
            break;
        } else if (ret == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
            IDE_LOGW("Driver doesn't support device type version by rtGetDeviceInfo interface, ret=%d"
                ", set PlatformType::HELPER_DEVICE_TYPE", static_cast<int32_t>(ret));
            chipId = DEFAULT_CHIP_TYPE; // tmp set mdc type for helper device
            break;
        }
    }
    IDE_CTRL_VALUE_FAILED((ret == RT_ERROR_NONE) || (ret == ACL_ERROR_RT_FEATURE_NOT_SUPPORT), return false,
        "Failed to get chip id, ret is %d.", static_cast<int32_t>(ret));

    platformType = static_cast<uint32_t>(chipId);
    IDE_LOGD("Success to get chip id: %u.", chipId);
    return true;
}

/**
* @ingroup driver
* @brief Get current platform information
* @attention null
* @param [out] *platformInfo  0 Means currently on the Device side, 1/Means currently on the host side
* @return   true for success, false for fail
*/
bool AdumpDsmi::DrvGetPlatformInfo(uint32_t &platformInfo)
{
    rtRunMode info = RT_RUN_MODE_RESERVED;
    rtError_t ret = rtGetRunMode(&info);
    if (ret != RT_ERROR_NONE) {
        if (ret != ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
            IDE_LOGE("Failed to rtGetRunMode, ret=%d", static_cast<int32_t>(ret));
            return false;
        }
    }
    platformInfo = static_cast<uint32_t>(info);
    return true;
}

#if !defined(ADUMP_SOC_HOST) || ADUMP_SOC_HOST == 1
int32_t AdumpDsmi::DrvGetAPIVersion()
{
    int32_t halAPIVersion = 0;
    if (halGetAPIVersion) {
        int32_t ret = halGetAPIVersion(&halAPIVersion);
        if (ret != DRV_ERROR_NONE) {
            IDE_LOGW("Unable to get driver version from halGetAPIVersion, return code is %d.", ret);
            return -1;
        }
        IDE_LOGD("Received current driver version %d.", halAPIVersion);
        return halAPIVersion;
    }
    // If halGetAPIVersion is nullptr, it means that the function is not supported.
    return halAPIVersion;
}
#endif
}