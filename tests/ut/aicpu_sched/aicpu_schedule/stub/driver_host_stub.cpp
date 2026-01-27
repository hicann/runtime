/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <unistd.h>
#include "driver/ascend_hal.h"
#include "driver/ascend_inpackage_hal.h"

/* Host侧驱动专用打桩文件
 * 该文件内的桩为驱动在host上提供的功能
 * 如果驱动接口未在host上提供需要打桩，请在代码仓内打桩（不要在UT中添加）
 */

#ifdef __cplusplus
extern "C" {
#endif

drvError_t drvGetProcessSign(struct process_sign *sign)
{
    int signLen = PROCESS_SIGN_LENGTH;
    int i = 0;
    if (sign != NULL) {
        if (signLen > 0) {
            for (i = 0; i < signLen - 1; ++i) {
                sign->sign[i] = '0';
            }
            sign->sign[signLen-1] = '\0';
        }
    }
    return DRV_ERROR_NONE;
}

int halMbufChainGetMbufNum(Mbuf *mbufChainHead, unsigned int *num)
{
    return DRV_ERROR_NONE;
}

int halMbufGetDataLen(Mbuf *mbuf, uint64_t *len)
{
    return DRV_ERROR_NONE;
}

int halMbufChainGetMbuf(Mbuf *mbufChainHead, unsigned int index, Mbuf **mbuf)
{
    return DRV_ERROR_NONE;
}

int halMbufAllocEx(uint64_t size, unsigned int align, unsigned long flag, int grp_id, Mbuf **mbuf)
{
    return DRV_ERROR_NONE;
}

int halMbufSetDataLen (Mbuf *mbuf, uint64_t len)
{
    return DRV_ERROR_NONE;
}

int halMbufChainAppend(Mbuf *mbufChainHead, Mbuf *mbuf)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedSetEventPriority(unsigned int devId, EVENT_ID eventId, SCHEDULE_PRIORITY priority)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedSetPidPriority(unsigned int devId, SCHEDULE_PRIORITY priority)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedGetEvent(unsigned int devId, unsigned int grpId, unsigned int threadId,
                   EVENT_ID eventId, struct event_info *event)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedSubmitEventBatch(unsigned int devId, SUBMIT_FLAG flag,
    struct event_summary *events, unsigned int event_num, unsigned int *succ_event_num)
{
    *succ_event_num = event_num;
    return DRV_ERROR_NONE;
}

drvError_t halEschedAttachDevice(unsigned int devId)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedCreateGrp(unsigned int devId, unsigned int grpId, GROUP_TYPE type)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueSet(unsigned int devId, QueueSetCmdType cmd, QueueSetInputPara *inPut)
{
  return DRV_ERROR_NONE;
}

pid_t drvDeviceGetBareTgid(void)
{
    return getpid();
}

int halBuffCreatePool(mp_attr *attr, struct mempool_t **mp)
{
    return DRV_ERROR_NONE;
}

int halBuffDeletePool(mempool_t *mp)
{
    return DRV_ERROR_NONE;
}

int halMbufAllocByPool(poolHandle pHandle, Mbuf **mbuf)
{
    return DRV_ERROR_NONE;
}

int halBuffGetInfo(enum BuffGetCmdType cmd, void *inBuff, unsigned int inLen,
    void *outBuff, unsigned int *outLen)
{
    return DRV_ERROR_NONE;
}

#ifdef __cplusplus
}
#endif
