/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "adx_dsmi.h"
#include <algorithm>
#include "ascend_hal.h"
#include "log/adx_log.h"

namespace Adx {
/**
 * @brief Check is vf id or not
 * @param devId: device id
 *
 * @return
 *      true:    is vf id
 *      false: not vf id
 */
bool CheckVfId(uint32_t devId)
{
#if defined(ADX_LIB_DEVICE_DRV)
    // 32~63  device vfid
    const uint32_t minVfid = 32;
    if ((devId >= minVfid) && (devId < MAX_LOCAL_DEVICE_NUM)) {
        return true;
    }
#endif
    (void)devId;
    return false;
}

/**
 * @brief Get Device Info
 * @param devNum: device num from driver api
 * @param devs:   array to save device id
 * @param len:    the length of devs
 *
 * @return
 *      IDE_DAEMON_OK:    get device num succ
 *      IDE_DAEMON_ERROR: get device num failed
 */
int32_t IdeGetDevList(IdeU32Pt devNum, std::vector<uint32_t> &devs, uint32_t len)
{
    IDE_CTRL_VALUE_FAILED(devNum != nullptr, return IDE_DAEMON_ERROR, "devNum is nullptr");
    IDE_CTRL_VALUE_FAILED(len == DEVICE_NUM_MAX, return IDE_DAEMON_ERROR, "len is invalid");
    drvError_t err = drvGetDevNum(devNum);
    if (err != DRV_ERROR_NONE) {
        IDE_LOGE("Get physical device number failed, err: %d", err);
        return IDE_DAEMON_ERROR;
    }

    if (*devNum > 0 && *devNum <= DEVICE_NUM_MAX) {
#if (defined ADX_LIB_HOST) || (defined ADX_LIB_HOST_DRV)
        err = drvGetDevIDs(devs.data(), MAX_LOCAL_DEVICE_NUM);    // host side get devId
#else
        err = drvGetDeviceLocalIDs(devs.data(), MAX_LOCAL_DEVICE_NUM); //  device side get devId
#endif
        if (err != DRV_ERROR_NONE) {
            IDE_LOGE("get device IDs failed, err: %d", err);
            return IDE_DAEMON_ERROR;
        }
    }
    return IDE_DAEMON_OK;
}

/**
 * @brief Get Device Physical Info
 * @param devNum: device num from driver api
 * @param devs:   array to save phy device id
 * @param len:    the length of devs
 *
 * @return
 *      IDE_DAEMON_OK:    get device num succ
 *      IDE_DAEMON_ERROR: get device num failed
 */
int32_t IdeGetPhyDevList(IdeU32Pt devNum, std::vector<uint32_t> &devs, uint32_t len)
{
    IDE_CTRL_VALUE_FAILED(devNum != nullptr, return IDE_DAEMON_ERROR, "devNum is nullptr");
    IDE_CTRL_VALUE_FAILED(len == DEVICE_NUM_MAX, return IDE_DAEMON_ERROR, "len is invalid");

    std::vector<uint32_t> devLogIds(DEVICE_NUM_MAX, 0);
    int32_t ret = IdeGetDevList(devNum, devLogIds, DEVICE_NUM_MAX);
    IDE_CTRL_VALUE_FAILED(ret == IDE_DAEMON_OK, return IDE_DAEMON_ERROR, "IdeGetDevList failed, ret: %d", ret);

    uint32_t i = 0;
    uint32_t phyId = 0;
    for (i = 0; i < *devNum && i < DEVICE_NUM_MAX; i++) {
        drvError_t err = drvDeviceGetPhyIdByIndex(devLogIds[i], &phyId);
        IDE_CTRL_VALUE_FAILED(err == DRV_ERROR_NONE, return IDE_DAEMON_ERROR,
            "drvDeviceGetPhyIdByIndex devIds: %u failed, err: %d", devLogIds[i], err);
        devs[i] = phyId;
    }
    return IDE_DAEMON_OK;
}

/**
 * @brief According to the physical ID of the input, it is judged whether the ID has been scanned.
 * @param [in]  desPhyId: Physical ID of the device
 * @param [out] logId:    logical ID of the device
 * @return
 *      IDE_DAEMON_OK:      Find the logical ID corresponding to the physical ID
 *      IDE_DAEMON_ERROR:   Unable to find the logical ID corresponding to the physical ID
 */
int32_t IdeGetLogIdByPhyId(uint32_t desPhyId, IdeU32Pt logId)
{
    drvError_t err = DRV_ERROR_NONE;
    uint32_t devNum = 0;
    std::vector<uint32_t> devIds(DEVICE_NUM_MAX, 0);

    IDE_CTRL_VALUE_FAILED(logId != nullptr, return IDE_DAEMON_ERROR, "logId is nullptr");

    // get logic device id list
    int32_t ret = IdeGetDevList(&devNum, devIds, DEVICE_NUM_MAX);
    IDE_CTRL_VALUE_FAILED(ret == IDE_DAEMON_OK, return IDE_DAEMON_ERROR, "IdeGetDevList failed");

    // check if phyid exist
    if (devNum > 0 && devNum <= DEVICE_NUM_MAX) {
        uint32_t i = 0;
        uint32_t phyId = 0;
        for (i = 0; i < devNum; i++) {
            err = drvDeviceGetPhyIdByIndex(devIds[i], &phyId);
            IDE_CTRL_VALUE_FAILED(err == DRV_ERROR_NONE, return IDE_DAEMON_ERROR,
                "drvDeviceGetPhyIdByIndex devIds: %u failed, err: %d", devIds[i], err);
            if (phyId == desPhyId) {
                IDE_LOGI("the logical ID(%u) is a corresponding physical ID(%u)", devIds[i], phyId);
                *logId = devIds[i];
                return IDE_DAEMON_OK;
            }
        }
    }

    return IDE_DAEMON_ERROR;
}

/**
 * @brief According to the physical ID of the input, it is judged whether the ID has been scanned.
 * @param [in]  desPhyId: Physical ID of the device
 * @param [out] logId:    logical ID of the device
 * @return
 *      IDE_DAEMON_OK:      Find the logical ID corresponding to the physical ID
 *      IDE_DAEMON_ERROR:   Unable to find the logical ID corresponding to the physical ID
 */
int32_t AdxGetLogIdByPhyId(uint32_t desPhyId, IdeU32Pt logId)
{
    if (desPhyId > DEVICE_NUM_MAX || logId == nullptr) {
        return IDE_DAEMON_ERROR;
    }

    drvError_t err = drvDeviceGetIndexByPhyId(desPhyId, logId);
    IDE_CTRL_VALUE_FAILED(err == DRV_ERROR_NONE, return IDE_DAEMON_ERROR,
        "drvDeviceGetIndexByPhyId devIds: %u failed, err: %d", desPhyId, err);

    return IDE_DAEMON_OK;
}
}