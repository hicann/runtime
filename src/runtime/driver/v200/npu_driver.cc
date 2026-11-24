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
rtError_t GetConnectUbFlagFromDrv(const uint32_t deviceId, bool& connectUbFlag)
{
    drvError_t drvRet = DRV_ERROR_NONE;
    int64_t hdConnectType = 0;
    drvRet = halGetDeviceInfo(deviceId, MODULE_TYPE_SYSTEM, INFO_TYPE_HD_CONNECT_TYPE, &hdConnectType);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet,
            "Call driver api halGetDeviceInfo failed, drvRetCode=%d, moduleType=SYSTEM(%d), "
            "infoType=HD_CONNECT_TYPE(%d).",
            static_cast<int32_t>(drvRet), static_cast<int32_t>(MODULE_TYPE_SYSTEM),
            static_cast<int32_t>(INFO_TYPE_HD_CONNECT_TYPE));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    connectUbFlag = (hdConnectType == HOST_DEVICE_CONNECT_TYPE_UB ? true : false); // 2: ub, 0: pcie, 1: hccs
    RT_LOG(
        RT_LOG_DEBUG, "hdConnectType = %" PRId64 ", connectUbFlag = %d.", hdConnectType,
        static_cast<int32_t>(connectUbFlag));
    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t InitDrvEventThread(const uint32_t deviceId)
{
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}

rtError_t GetDrvSentinelMode(void) { return RT_ERROR_NONE; }

bool IsOfflineNotSupportMemType(const rtMemType_t& type)
{
    UNUSED(type);
    return false;
}

rtError_t GetIpcNotifyVa(
    const uint32_t notifyId, Driver* const curDrv, const uint32_t deviceId, const uint32_t phyId, uint64_t& Va)
{
    COND_RETURN_WARN(
        &halResAddrMapV2 == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halResAddrMapV2 does not exist");

    uint32_t phyDeviceId = 0U;
    rtError_t error = curDrv->GetDevicePhyIdByIndex(deviceId, &phyDeviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    // 多卡场景需要判断驱动版本是否支持，单卡场景一直支持，不需要再做判断
    if (phyDeviceId != phyId) {
        COND_RETURN_WARN(
            (!(NpuDriver::CheckIsSupportFeature(deviceId, FEATURE_APM_RES_MAP_REMOTE))), RT_ERROR_DRV_NOT_SUPPORT,
            "[drv api] the driver does not support getting the ipc notify va.");
    }

    struct trs_res_map_priv privInfo;
    (void)memset_s(&privInfo, sizeof(privInfo), 0U, sizeof(privInfo));
    privInfo.flag = (phyDeviceId == phyId) ? 0U : TSDRV_RES_REMOTE_ID;
    privInfo.local_devid = deviceId;
    privInfo.remote_devid = phyId; // 创建notify的device对应的物理id

    struct res_map_info_in devResInfo;
    struct res_map_info_out infoOut;
    (void)memset_s(&devResInfo, sizeof(devResInfo), 0U, sizeof(devResInfo));
    (void)memset_s(&infoOut, sizeof(infoOut), 0U, sizeof(infoOut));
    devResInfo.id = 0U;
    devResInfo.target_proc_type = PROCESS_CP1;
    devResInfo.res_type = RES_ADDR_TYPE_STARS_NOTIFY_RECORD;
    devResInfo.res_id = notifyId;
    devResInfo.priv_len = sizeof(privInfo);
    devResInfo.priv = static_cast<void*>(&privInfo);
    const drvError_t drvRet = halResAddrMapV2(deviceId, &devResInfo, &infoOut);
    COND_RETURN_WARN(
        drvRet == DRV_ERROR_NOT_SUPPORT, RT_GET_DRV_ERRCODE(drvRet), "[drv api] halResAddrMapV2 does not support");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halResAddrMapV2 failed, drvRetCode=%d, drvDevId=%u, notifyId=%u.",
            static_cast<int32_t>(drvRet), deviceId, notifyId);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    RT_LOG(
        RT_LOG_INFO, "device_id=%u, notify_id=%u, phyId=%u, peerPhyId=%u, flag=0x%x.", deviceId, notifyId, phyDeviceId,
        phyId, privInfo.flag);
    Va = infoOut.va;
    return RT_ERROR_NONE;
}

static void InitCrossEventMapInfo(
    uint32_t notifyId, uint32_t deviceId, uint32_t phyId, bool isCountNotify, trs_res_map_priv& priv,
    res_map_info_in& info)
{
    priv.flag = TSDRV_RES_REMOTE_ID;
    priv.local_devid = deviceId;
    priv.remote_devid = phyId;
    info.target_proc_type = PROCESS_CP1;
    info.res_type = isCountNotify ? RES_ADDR_TYPE_STARS_CNT_NOTIFY_RECORD : RES_ADDR_TYPE_STARS_NOTIFY_RECORD;
    info.res_id = notifyId;
    info.priv_len = sizeof(priv);
    info.priv = &priv;
}

rtError_t ReleaseCrossEventVa(uint32_t notifyId, uint32_t deviceId, uint32_t phyId, bool isCountNotify)
{
    COND_RETURN_WARN(
        &halResAddrUnmapV2 == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halResAddrUnmapV2 does not exist");
    trs_res_map_priv priv = {};
    res_map_info_in info = {};
    InitCrossEventMapInfo(notifyId, deviceId, phyId, isCountNotify, priv, info);
    const drvError_t ret = halResAddrUnmapV2(deviceId, &info);
    if (ret != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            ret, "Unmap cross-device event failed, device_id=%u, notify_id=%u, drvRetCode=%d.", deviceId, notifyId,
            static_cast<int32_t>(ret));
    }
    return RT_GET_DRV_ERRCODE(ret);
}

rtError_t GetCrossEventVa(uint32_t notifyId, uint32_t deviceId, uint32_t phyId, bool isCountNotify, uint64_t& addr)
{
    COND_RETURN_WARN(
        &halResAddrMapV2 == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halResAddrMapV2 does not exist");
    COND_RETURN_WARN(
        &halResAddrUnmapV2 == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halResAddrUnmapV2 does not exist");
    COND_RETURN_WARN(
        !NpuDriver::CheckIsSupportFeature(deviceId, FEATURE_APM_RES_MAP_REMOTE), RT_ERROR_DRV_NOT_SUPPORT,
        "The driver does not support remote event resource mapping, device_id=%u.", deviceId);
    trs_res_map_priv priv = {};
    res_map_info_in info = {};
    res_map_info_out out = {};
    InitCrossEventMapInfo(notifyId, deviceId, phyId, isCountNotify, priv, info);
    const drvError_t ret = halResAddrMapV2(deviceId, &info, &out);
    if (ret != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            ret, "Map cross-device event failed, device_id=%u, notify_id=%u, drvRetCode=%d.", deviceId, notifyId,
            static_cast<int32_t>(ret));
        return RT_GET_DRV_ERRCODE(ret);
    }
    const uint32_t requiredSize = isCountNotify ? sizeof(uint32_t) : sizeof(uint8_t);
    if ((out.va == 0UL) || (out.len < requiredSize) || ((out.va % requiredSize) != 0UL)) {
        (void)ReleaseCrossEventVa(notifyId, deviceId, phyId, isCountNotify);
        RT_LOG(
            RT_LOG_ERROR, "Invalid mapped event address, device_id=%u, notify_id=%u, va=%#" PRIx64 ", length=%u.",
            deviceId, notifyId, static_cast<uint64_t>(out.va), out.len);
        return RT_ERROR_INVALID_VALUE;
    }
    addr = out.va;
    RT_LOG(
        RT_LOG_INFO,
        "Cross-device event map success: device_id=%u, peer_phy_id=%u, notify_id=%u, "
        "res_type=%u, va=%#" PRIx64 ", length=%u.",
        deviceId, phyId, notifyId, static_cast<uint32_t>(info.res_type), static_cast<uint64_t>(out.va), out.len);
    return RT_ERROR_NONE;
}

bool isNeedOpenDevice(const bool isTscOpen, const bool isTsvOpen, const uint32_t tsId)
{
    UNUSED(isTscOpen);
    UNUSED(isTsvOpen);
    return tsId != static_cast<uint32_t>(RT_TSV_ID);
}

bool isNeedCloseDevice(const bool isTscOpen, const bool isTsvOpen) { return !(isTscOpen && isTsvOpen); }

rtError_t SetModelNameWithCtrlMsg(Model* const mdl)
{
    UNUSED(mdl);
    return RT_ERROR_NONE;
}
} // namespace runtime
} // namespace cce
