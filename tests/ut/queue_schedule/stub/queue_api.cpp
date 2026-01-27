/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <time.h>
#include "driver/ascend_hal.h"
#include "tsd.h"

drvError_t halQueueCreate(unsigned int devid, const QueueAttr *queAttr, unsigned int *qid)
{ return DRV_ERROR_NONE; }

drvError_t halQueueDestroy(unsigned int devId, unsigned int qid)
{ return DRV_ERROR_NONE; }

drvError_t halQueueEnQueue(unsigned int devId, unsigned int qid, void *mbuf)
{ return DRV_ERROR_NONE; }

drvError_t halQueueDeQueue(unsigned int devId, unsigned int qid, void **mbug)
{ return DRV_ERROR_NONE; }

drvError_t halQueueSubscribe(unsigned int devid, unsigned int qid, unsigned int groupId, int type)
{ return DRV_ERROR_NONE; }

drvError_t halQueueUnsubscribe(unsigned int devid, unsigned int qid)
{ return DRV_ERROR_NONE; }

drvError_t halQueueSubEvent(struct QueueSubPara *subPara)
{ return DRV_ERROR_NONE; }

drvError_t halQueueUnsubEvent(struct QueueUnsubPara *unsubPara)
{ return DRV_ERROR_NONE; }

drvError_t halQueueSet(unsigned int devId, QueueSetCmdType cmd, QueueSetInputPara *inPut)
{ return DRV_ERROR_NONE; }

drvError_t halEschedThreadSwapout(unsigned int devId, unsigned int grpId, unsigned int threadId)
{ return DRV_ERROR_NONE; }

int SetQueueWorkMode(unsigned int devid, unsigned int qid, int mode)
{ return DRV_ERROR_NONE; }

drvError_t halQueueGetStatus(unsigned int devid, unsigned int qid, QUEUE_QUERY_ITEM queryItem, unsigned int len,  void *data)
{ return DRV_ERROR_NONE; }

int halGetQueueDepth(unsigned int devid, unsigned int qid, unsigned int *depth)
{ return DRV_ERROR_NONE; }

drvError_t halQueueInit(unsigned int devid)
{ return DRV_ERROR_NONE; }

drvError_t halQueueSubF2NFEvent(unsigned int devid, unsigned int qid, unsigned int groupid)
{ return DRV_ERROR_NONE; }

drvError_t halQueueUnsubF2NFEvent(unsigned int devid, unsigned int qid)
{ return DRV_ERROR_NONE; }

drvError_t halQueueGetQidbyName(unsigned int devid, const char *name, unsigned int *qid)
{ return 200; }

drvError_t halQueueCtrlEvent (struct QueueSubscriber *subscriber, QUE_EVENT_CMD cmdType)
{ return DRV_ERROR_NONE; }

int32_t TsdWaitForShutdown(const uint32_t deviceId, const TsdWaitType waitType,
                           const uint32_t hostPid, const uint32_t vfId)
{
    return 0;
}

void DlogFlush() {}

int32_t TsdReportStartOrStopErrCode(const uint32_t deviceId, const TsdWaitType waitType,
                                    const uint32_t hostPid, const uint32_t vfId,
                                    const char *errCode, const uint32_t errLen)
{
    return 0;
}

int32_t RegEventMsgCallBackFunc(const struct SubProcEventCallBackInfo *regInfo)
{
    return 0;   
}

void UnRegEventMsgCallBackFunc(const uint32_t eventType)
{
    return;
}

int32_t TsdDestroy(const uint32_t deviceId, const TsdWaitType waitType,
                   const uint32_t hostPid, const uint32_t vfId)
{
    return 0;
}

drvError_t halQueueEnQueueBuff(unsigned int devId, unsigned int qid, struct buff_iovec *vector, int timeout)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueDeQueueBuff(unsigned int devId, unsigned int qid, struct buff_iovec *vector, int timeout)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueuePeek(unsigned int devId, unsigned int qid, uint64_t *buf_len, int timeout)
{
    return DRV_ERROR_NONE;
}

DLLEXPORT drvError_t drvGetLocalDevIDByHostDevID(uint32_t host_dev_id, uint32_t *localDeviceId)
{
    return DRV_ERROR_NONE;
}