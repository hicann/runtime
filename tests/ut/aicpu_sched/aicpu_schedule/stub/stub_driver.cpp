/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <stdint.h>
#include <sys/types.h>
#include <stdlib.h>
#include "driver/ascend_hal.h"
#include "driver/ascend_inpackage_hal.h"
#include "aicpusd_common.h"

drvError_t halGetChipFromDevice(int device_id, int *chip_id)
{
    *chip_id = 0;
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceCountFromChip(int chip_id, int *device_count)
{
    *device_count = 1;
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceFromChip(int chip_id, int device_list[], int count)
{
    for (int i = 0; i < count; i++) {
        device_list[i] = chip_id;
    }
    return DRV_ERROR_NONE;
}

drvError_t halQueueSet(unsigned int devId, QueueSetCmdType cmd, QueueSetInputPara *inPut)
{
  return DRV_ERROR_NONE;
}

int halGrpAttach(const char *name, int timeout)
{
    return 0;
}

int halBuffInit(BuffCfg *cfg)
{
    return 0;
}

drvError_t halQueueDeQueue(unsigned int devId, unsigned int qid, void **mbug)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueEnQueue(unsigned int devId, unsigned int qid, void *mbuf)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueInit(unsigned int devid)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueSubscribe(unsigned int devid, unsigned int qid, unsigned int groupId, int type)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueUnsubscribe(unsigned int devid, unsigned int qid)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueSubF2NFEvent(unsigned int devid, unsigned int qid, unsigned int groupid)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueUnsubF2NFEvent(unsigned int devid, unsigned int qid)
{
    return DRV_ERROR_NONE;
}

drvError_t halGetVdevNum(uint32_t *devNum)
{
    return DRV_ERROR_NONE;
}

drvError_t halBindCgroup(BIND_CGROUP_TYPE bindType)
{
    return DRV_ERROR_NONE;
}

int halMbufGetBuffAddr(Mbuf *mbuf, void **buf)
{
    return DRV_ERROR_NONE;
}

int halMbufGetBuffSize(Mbuf *mbuf, uint64_t *totalSize)
{
    return DRV_ERROR_NONE;
}

int halMbufSetDataLen (Mbuf *mbuf, uint64_t len)
{
    return DRV_ERROR_NONE;
}

int halMbufGetDataLen(Mbuf *mbuf, uint64_t *len)
{
    return DRV_ERROR_NONE;
}

int halMbufAllocEx(uint64_t size, unsigned int align, unsigned long flag, int grp_id, Mbuf **mbuf)
{
    return DRV_ERROR_NONE;
}

int halMbufFree(Mbuf *mbuf)
{
    return DRV_ERROR_NONE;
}

int halMbufGetPrivInfo (Mbuf *mbuf,  void **priv, unsigned int *size)
{
    return DRV_ERROR_NONE;
}

int halMbufChainGetMbuf(Mbuf *mbufChainHead, unsigned int index, Mbuf **mbuf)
{
    return DRV_ERROR_NONE;
}

int halMbufChainGetMbufNum(Mbuf *mbufChainHead, unsigned int *num)
{
    return DRV_ERROR_NONE;
}

int halMbufChainAppend(Mbuf *mbufChainHead, Mbuf *mbuf)
{
    return DRV_ERROR_NONE;
}

int halGetDeviceVfMax(unsigned int devId, unsigned int *vf_max_num)
{
    return DRV_ERROR_NONE;
}

int halBuffCreatePool(mp_attr *attr, struct mempool_t **mp)
{
    return DRV_ERROR_NONE;
}

int halBuffDeletePool(mempool_t *mp)
{
    return DRV_ERROR_NONE;
}

drvError_t halGrpCacheAlloc(const char *name, unsigned int devId, GrpCacheAllocPara *para)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueQueryInfo(unsigned int devId, unsigned int qid, QueueInfo *queInfo)
{
    return DRV_ERROR_NONE;
}

drvError_t halDrvEventThreadUninit(unsigned int devId)
{
    return DRV_ERROR_NONE;
}

drvError_t halSdmaCopy(DVdeviceptr dst, size_t dst_size, DVdeviceptr src, size_t len) {
    return DRV_ERROR_NONE;
}