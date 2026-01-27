/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef AICPUSD_HAL_INTERFACE_REF_H
#define AICPUSD_HAL_INTERFACE_REF_H
#include <unistd.h>
#include "ascend_hal_define.h"
#include "ascend_hal.h"
#ifdef __cplusplus
extern "C" {
#endif
DV_ONLINE DVresult __attribute__((weak)) halMemInitSvmDevice(int hostpid, unsigned int vfid,
    unsigned int dev_id);
DV_ONLINE drvError_t __attribute__((weak)) halGetDeviceCountFromChip(int chipId, int *deviceCount);
drvError_t __attribute__((weak)) halGetVdevNum(uint32_t *numDev);
drvError_t __attribute__((weak)) halBindCgroup(BIND_CGROUP_TYPE bindType);
DV_ONLINE int __attribute__((weak)) halGetDeviceVfMax(unsigned int devId, unsigned int *vfMaxNum);
drvError_t __attribute__((weak)) drvQueryProcessHostPid(int pid, unsigned int *chipId, unsigned int *vfid,
    unsigned int *hostPid, unsigned int *cpType);
drvError_t __attribute__((weak)) halGrpCacheAlloc(const char *name, unsigned int devId, GrpCacheAllocPara *para);
drvError_t __attribute__((weak)) halDrvEventThreadInit(unsigned int devId);
drvError_t __attribute__((weak)) halDrvEventThreadUninit(unsigned int devId);
drvError_t __attribute__((weak)) halResAddrMap(unsigned int devId, struct res_addr_info *resInfo, unsigned long *va,
                                               unsigned int *len);
drvError_t __attribute__((weak))halGetSocVersion(uint32_t devId, char *socVersion, uint32_t len);
#ifdef __cplusplus
}
#endif
#endif