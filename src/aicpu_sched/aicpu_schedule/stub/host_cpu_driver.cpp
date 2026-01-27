/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpusd_status.h"
#include "ascend_hal.h"
#include "tsd.h"

#ifdef __cplusplus
extern "C" {
#endif

drvError_t halGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    (void)devId;
    aicpusd_info("Get host aicpu num in stub func[%s].", __func__);
    const int64_t hostAicpuNum = 64;
    const int64_t hostAicpuBitMap = 0;
    if (moduleType == MODULE_TYPE_AICPU && infoType == INFO_TYPE_CORE_NUM) {
        *value = hostAicpuNum;
    } else if (moduleType == MODULE_TYPE_AICPU && infoType == INFO_TYPE_OCCUPY) {
        *value = hostAicpuBitMap;
    }
    return DRV_ERROR_NONE;
}
#ifdef __cplusplus
}
#endif

drvError_t drvBindHostPid(struct drvBindHostpidInfo info)
{
    (void)info;
    aicpusd_info("Bind host pid in stub func[%s].", __func__);
    return DRV_ERROR_NONE;
}

drvError_t drvQueryProcessHostPid(int pid, unsigned int *chip_id, unsigned int *vfid,
                                  unsigned int *host_pid, unsigned int *cp_type)
{
    (void)pid;
    (void)chip_id;
    (void)vfid;
    (void)host_pid;
    (void)cp_type;
    return DRV_ERROR_NONE;
}

DVresult halMemInitSvmDevice(int hostpid, unsigned int vfid, unsigned int dev_id)
{
    (void)hostpid;
    (void)vfid;
    (void)dev_id;
    aicpusd_info("Init svm mem in stub func[%s].", __func__);
    return DRV_ERROR_NONE;
}

int halGetDeviceVfMax(unsigned int devId, unsigned int *vf_max_num)
{
    aicpusd_info("Get device max vf in stub func[%s].", __func__);
    (void)devId;
    (void)vf_max_num;
    return DRV_ERROR_NONE;
}

int halGetDeviceVfList(unsigned int devId, unsigned int *vf_list, unsigned int list_len, unsigned int *vf_num)
{
    aicpusd_info("Get device vf list in stub func[%s].", __func__);
    (void)devId;
    (void)vf_list;
    (void)list_len;
    (void)vf_num;
    return DRV_ERROR_NONE;
}