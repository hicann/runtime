/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "driver.hpp"
#include "driver/ascend_hal.h"
#include "npu_driver_base.hpp"
#include "errcode_manage.hpp"
#include "npu_driver.hpp"

namespace cce {
namespace runtime {
rtError_t GetConnectUbFlagFromDrv(const uint32_t deviceId, bool &connectUbFlag)
{
    drvError_t drvRet = DRV_ERROR_NONE;
    int64_t hdConnectType = 0;
    drvRet = halGetDeviceInfo(deviceId, MODULE_TYPE_SYSTEM, INFO_TYPE_HD_CONNECT_TYPE, &hdConnectType);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "Call halGetDeviceInfo failed: drvRetCode=%u, module type=%d, info type=%d.",
            static_cast<uint32_t>(drvRet), static_cast<int32_t>(MODULE_TYPE_SYSTEM),
            static_cast<int32_t>(INFO_TYPE_HD_CONNECT_TYPE));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    connectUbFlag = (hdConnectType == 2 ? true : false); // 2: ub, 0: pcie, 1: hccs
    RT_LOG(RT_LOG_DEBUG, "hdConnectType = %lld, connectUbFlag = %d.", hdConnectType,
        static_cast<int32_t>(connectUbFlag));
    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t InitDrvEventThread(const uint32_t deviceId)
{
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}

rtError_t GetDrvSentinelMode(void)
{
    return RT_ERROR_NONE;
}

bool IsOfflineNotSupportMemType(const rtMemType_t &type)
{
    UNUSED(type);
    return false;
}

rtError_t GetIpcNotifyVa(const uint32_t notifyId, Driver * const curDrv, const uint32_t deviceId, const uint32_t phyId,
    uint64_t &Va)
{
    COND_RETURN_WARN(&halResAddrMapV2 == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halResAddrMapV2 does not exist");

    uint32_t phyDeviceId = 0U;
    rtError_t error = curDrv->GetDevicePhyIdByIndex(deviceId, &phyDeviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    // 多卡场景需要判断驱动版本是否支持，单卡场景一直支持，不需要再做判断
    if (phyDeviceId != phyId) {
        COND_RETURN_WARN((!(NpuDriver::CheckIsSupportFeature(deviceId,FEATURE_APM_RES_MAP_REMOTE))),
            RT_ERROR_DRV_NOT_SUPPORT, "[drv api] the driver does not support getting the ipc notify va.");
    }

    struct trs_res_map_priv privInfo;
    (void)memset_s(&privInfo, sizeof(privInfo), 0U, sizeof(privInfo));
    privInfo.flag = (phyDeviceId == phyId) ? 0U : TSDRV_RES_REMOTE_ID;
    privInfo.local_devid = deviceId;
    privInfo.remote_devid = phyId;   // 创建notify的device对应的物理id

    struct res_map_info_in devResInfo;
    struct res_map_info_out infoOut;
    (void)memset_s(&devResInfo, sizeof(devResInfo), 0U, sizeof(devResInfo));
    (void)memset_s(&infoOut, sizeof(infoOut), 0U, sizeof(infoOut));
    devResInfo.id = 0U;
    devResInfo.target_proc_type = PROCESS_CP1;
    devResInfo.res_type = RES_ADDR_TYPE_STARS_NOTIFY_RECORD;
    devResInfo.res_id = notifyId; 
    devResInfo.priv_len = sizeof(privInfo);
    devResInfo.priv = (void *)&privInfo;
    const drvError_t drvRet = halResAddrMapV2(deviceId, &devResInfo, &infoOut);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halResAddrMapV2 does not support");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] halResAddrMapV2 notify addr failed: device_id=%u, notify_id=%u, drvRetCode=%d.",
            deviceId, notifyId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    RT_LOG(RT_LOG_INFO, "device_id=%u, notify_id=%u, phyId=%u, peerPhyId=%u, flag=0x%x.",
        deviceId, notifyId, phyDeviceId, phyId, privInfo.flag);
    Va = infoOut.va;
    return RT_ERROR_NONE;
}
}  // namespace runtime
}  // namespace cce
