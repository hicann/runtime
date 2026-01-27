/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_WEAK_ASCEND_HAL_H
#define TSD_WEAK_ASCEND_HAL_H

#include "driver/ascend_inpackage_hal.h"

extern "C" {
/**
 * @ingroup driver
 * @brief record wait event or notify
 * @attention only called by cp process
 * @param [in] devId  device id
 * @param [out] vf_max_num  maximum number of segmentation
 * @return 0  success, return others fail
 */
int __attribute__((weak)) halGetDeviceVfMax(unsigned int devId, unsigned int *vf_max_num);
drvError_t __attribute__((weak)) halGetChipFromDevice(int device_id, int *chip_id);
int __attribute__((weak)) halRegisterVmngClient();
int __attribute__((weak)) halGetDeviceVfList(unsigned int devId, unsigned int *vf_list,
                                             unsigned int list_len, unsigned int *vf_num);
drvError_t __attribute__((weak)) halGetVdevNum(uint32_t *num_dev);
DLLEXPORT __attribute__((weak)) drvError_t halSensorNodeRegister(uint32_t devId, struct halSensorNodeCfg *cfg,
                                                                 uint64_t *handle);
DLLEXPORT __attribute__((weak)) drvError_t halSensorNodeUnregister(uint32_t devId, uint64_t handle);
DLLEXPORT __attribute__((weak)) drvError_t halSensorNodeUpdateState(uint32_t devId, uint64_t handle, int val,
                                                                    halGeneralEventType_t assertion);
DLLEXPORT drvError_t __attribute__((weak)) drvUnbindHostPid(struct drvBindHostpidInfo info);
DLLEXPORT drvError_t __attribute__((weak)) drvBindHostPid(struct drvBindHostpidInfo info);
DLLEXPORT drvError_t __attribute__((weak)) halTsCmdlistMemMap(unsigned int devId, unsigned int tsId);
DLLEXPORT __attribute__((weak)) drvError_t drvHdcSendFileV2(int peer_node, int peer_devid, const char *file,
    const char *dst_path, void (*progress_notifier)(struct drvHdcProgInfo *));
DLLEXPORT __attribute__((weak)) drvError_t drvHdcGetTrustedBasePathV2(int peer_node, int peer_devid, char *base_path,
    unsigned int path_len);
int __attribute__((weak)) halTsPkgLoad(unsigned int dev_id, TSFW_LOAD_TYPE load_type, unsigned int ex_type);
}
#endif  // TSD_WEAK_ASCEND_HAL_H