/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "driver/ascend_hal.h"
#include <vector>

int buff_get_phy_addr(void *buf, unsigned long long *phyAddr)
{ return DRV_ERROR_NONE; }

int buff_alloc(unsigned int size, void **buff, const char *file, unsigned int line)
{ return DRV_ERROR_NONE; }

int buff_alloc_by_pool(poolHandle pHandle, void **buff, const char *file, unsigned int line)
{ return DRV_ERROR_NONE; }

int buff_free(void *buff)
{ return DRV_ERROR_NONE; }

int mp_create(struct mp_attr *attr, struct mempool_t **mp, unsigned int pool_id, unsigned int private_id,
              const char *file, unsigned int line)
{ return DRV_ERROR_NONE; }

int mp_delete(struct mempool_t *mp)
{ return DRV_ERROR_NONE; }

int halMbufAlloc(uint64_t size, Mbuf **mbuf)
{ return DRV_ERROR_NONE; }

int MbufAllocByPool(poolHandle pHandle, Mbuf **mbuf)
{ return DRV_ERROR_NONE; }

int halMbufFree(Mbuf *mbuf)
{ return DRV_ERROR_NONE; }

int halMbufGetBuffAddr(Mbuf *mbuf, void **buf)
{ return DRV_ERROR_NONE; }

int halMbufGetBuffSize(Mbuf *mbuf, uint64_t *totalSize)
{ return DRV_ERROR_NONE; }

int halMbufSetDataLen(Mbuf *mbuf, uint64_t len)
{ return DRV_ERROR_NONE; }

int MbufGetDataLen(Mbuf *mbuf, unsigned int *len)
{ return DRV_ERROR_NONE; }

int halMbufCopyRef(Mbuf *mbuf, Mbuf **newMbuf)
{ return DRV_ERROR_NONE; }

int MbufBuild(void *buff, unsigned int len, Mbuf **mbuf)
{ return DRV_ERROR_NONE; }

int MbufGetPrivInfo(Mbuf *mbuf, void **priv, unsigned int *size)
{ return DRV_ERROR_NONE; }

int MemzoneGetNum(unsigned int *num)
{ return DRV_ERROR_NONE; }

drvError_t halQueueGetMaxNum(unsigned int *queue_max_num)
{
    if (queue_max_num != nullptr) {
        *queue_max_num = 1024;
    }

    return DRV_ERROR_NONE;
}

drvError_t drvGetDevIDs(uint32_t *devices, uint32_t len)
{ return DRV_ERROR_NONE; }

drvError_t halQueueQueryInfo(unsigned int devId, unsigned int qid, QueueInfo *queInfo)
{ return DRV_ERROR_NONE; }

int halMbufGetPrivInfo(Mbuf *mbuf,  void **priv, unsigned int *size)
{ return DRV_ERROR_NONE; }

int halMbufGetDataLen(Mbuf *mbuf, uint64_t *len)
{ return DRV_ERROR_NONE; }

int halMbufAllocEx(uint64_t size, unsigned int align, unsigned long flag, int grp_id, Mbuf **mbuf)
{
    return 0;
}

drvError_t halSdmaCopy(DVdeviceptr dst, size_t dst_size, DVdeviceptr src, size_t len)
{
    return DRV_ERROR_NONE;
}