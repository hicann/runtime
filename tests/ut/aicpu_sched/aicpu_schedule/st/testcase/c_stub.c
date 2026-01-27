/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <string.h>
#include <unistd.h>
#include <stdint.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <pthread.h>
#include <limits.h>
#include <dlfcn.h>
#include <sys/prctl.h>
#include <fcntl.h>
#include <unistd.h>
#include <pwd.h>
#include <stdio.h>
#include "ascend_hal.h"
#include <sys/types.h>
#include "base.h"

#include "adump/ide_daemon_api.h"
#include "ascend_inpackage_hal.h"
#include "tsd.h"
#include "toolchain/slog.h"


#define DEVDRV_DRV_INFO printf

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

drvError_t halMemInitSvmDevice(int hostpid , unsigned int vfid, unsigned int dev_id)
{
    return DRV_ERROR_NONE;
}

drvError_t drvGetDevIDs(uint32_t *devices, uint32_t len)
{ return DRV_ERROR_NONE; }


IDE_SESSION IdeDumpStart(const char *privInfo)
{
    int a = 1;
    IDE_SESSION sess = (IDE_SESSION)(&a);
    return sess;
}

IdeErrorT IdeDumpData(IDE_SESSION session, const struct IdeDumpChunk *dumpChunk)
{
    return IDE_DAEMON_NONE_ERROR;
}

IdeErrorT IdeDumpEnd(IDE_SESSION session)
{
    return IDE_DAEMON_NONE_ERROR;
}

drvError_t halEschedConfigHostPid(unsigned int devId, int hostPid)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedWaitEvent(unsigned int devId, unsigned int grpId,
                    unsigned int threadId, int timeout, struct event_info *event)
{
    event->comm.event_id = 0;
    return DRV_ERROR_NONE;
}

drvError_t halEschedGetEvent(unsigned int devId, unsigned int grpId, unsigned int threadId,
                   EVENT_ID eventId, struct event_info *event)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedAckEvent(unsigned int devId, EVENT_ID eventId, unsigned int subeventId, char *msg, unsigned int msgLen)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedSubmitEvent(unsigned int devId, struct event_summary *event)
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

drvError_t halEschedDettachDevice(unsigned int devId)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedCreateGrp(unsigned int devId, unsigned int grpId, GROUP_TYPE type)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedSubscribeEvent(unsigned int devId, unsigned int grpId, unsigned int threadId, unsigned long long eventBitmap)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedSetPidPriority(unsigned int devId, SCHEDULE_PRIORITY priority)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedSetEventPriority(unsigned int devId, EVENT_ID eventId, SCHEDULE_PRIORITY priority)
{
    return DRV_ERROR_NONE;
}

int eSchedSetWeight(unsigned int devId, unsigned int weight)
{
    return DRV_ERROR_NONE;
}

int tsDevSendMsgAsync (unsigned int devId, unsigned int tsId, char *msg, unsigned int msgLen, unsigned int handleId)
{
    return 0;
}

int halTsDevRecord(unsigned int devId, unsigned int tsId, unsigned int record_type, unsigned int record_Id)
{
    return 0;
}


drvError_t halEschedBindHostPid(pid_t hostPid, const char *sign, unsigned int len)
{
    return DRV_ERROR_NONE;
}

drvError_t halResAddrMap(unsigned int devId, struct res_addr_info *res_info, unsigned long *va, unsigned int *len)
{
    return DRV_ERROR_NONE;
}

drvError_t drvGetPlatformInfo(uint32_t *info)
{
    *info = 1;
    return DRV_ERROR_NONE;
}
hdcError_t drvHdcGetCapacity(struct drvHdcCapacity *capacity)
{
    capacity->chanType = HDC_CHAN_TYPE_SOCKET;
    return DRV_ERROR_NONE;
}

drvError_t halQueueGetMaxNum(unsigned int *maxQueNum)
{
    return DRV_ERROR_NONE;
}

int halMbufAllocByPool(poolHandle pHandle, Mbuf **mbuf)
{
    return 0;
}
int halMbufFree(Mbuf *mbuf)
{
    return 0;
}

int halMbufGetBuffAddr(Mbuf *mbuf, void **buf)
{
    return 0;
}

int halMbufCopyRef (Mbuf *mbuf, Mbuf **newMbuf)
{
    return 0;
}
int halMbufCopy(Mbuf *mbuf, Mbuf **newMbuf)
{
    return 0;
}
int halMbufGetPrivInfo (Mbuf *mbuf,  void **priv, unsigned int *size)
{
    return 0;
}

int buff_get_phy_addr (void *buf, unsigned long long *phyAddr)
{
    return 0;
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

drvError_t halQueueInit(unsigned int devid)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueDeQueue(unsigned int devId, unsigned int qid, void **mbug)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueEnQueue(unsigned int devId, unsigned int qid, void *mbuf)
{
    return DRV_ERROR_NONE;
}


drvError_t halQueueCreate(unsigned int devId, const QueueAttr *queAttr, unsigned int *qid)
{ 
    return DRV_ERROR_NONE;
}

drvError_t halQueueDestroy(unsigned int devId, unsigned int qid)
{ 
    return DRV_ERROR_NONE;
}

int halGrpQuery(GroupQueryCmdType cmd, void *inBuff, unsigned int inLen, void *outBuff, unsigned int *outLen)
{
    return DRV_ERROR_NONE;
}

int halGrpCreate(const char *name, GroupCfg *cfg)
{
    return DRV_ERROR_NONE;
}

int halGrpAddProc(const char *name, int pid, GroupShareAttr attr)
{
    return DRV_ERROR_NONE;
}

int halGrpAttach(const char *name, int timeout)
{
    return DRV_ERROR_NONE;
}

int halBuffInit(BuffCfg *cfg)
{
    return DRV_ERROR_NONE;
}

int SetQueueWorkMode(unsigned int devid, unsigned int qid, int mode)
{
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (value != NULL) {
        *value = 1;
    }
    return DRV_ERROR_NONE;
}

int32_t TsdDestroy(const uint32_t deviceId, const TsdWaitType waitType,
                   const uint32_t hostPid, const uint32_t vfId)
{
    return 0;
}

int32_t TsdHeartbeatSend(const uint32_t deviceId, const TsdWaitType waitType)
{
    return 0;
}

drvError_t drvBindHostPid(struct drvBindHostpidInfo info)
{
    return DRV_ERROR_NONE;
}

drvError_t drvQueryProcessHostPid(int pid, unsigned int *chip_id, unsigned int *vfid,
                                  unsigned int *host_pid, unsigned int *cp_type)
{
    if (pid = 123789) {
        *host_pid = 789123;
    }
    return DRV_ERROR_NONE;
}

pid_t drvDeviceGetBareTgid(void)
{
    return getpid();
}

void InitMarker(){}
void FiniMarker(){}

drvError_t halEventProc(unsigned int devId, struct event_info *event)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueAttach(unsigned int devId, unsigned int qid, int timeOut)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueGrant(unsigned int devId, int qid, int pid, QueueShareAttr attr)
{
    return DRV_ERROR_NONE;
}

drvError_t drvQueryDevpid(struct drvBindHostpidInfo info, pid_t *dev_pid)
{
    *dev_pid = 12345678;
    return DRV_ERROR_NONE;
}

int halMbufAlloc(uint64_t size, Mbuf **mbuf)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueQuery(unsigned int devId, QueueQueryCmdType cmd, QueueQueryInputPara *inPut, QueueQueryOutputPara *outPut)
{
    return 0;
}

drvError_t halQueryDevpid(struct halQueryDevpidInfo info, pid_t *dev_pid)
{
    return DRV_ERROR_NONE;
}

uint32_t aicpuGetDeviceId(uint32_t deviceId)
{
	return DRV_ERROR_NONE;
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

int halBuffGetInfo(enum BuffGetCmdType cmd, void *inBuff, unsigned int inLen,
    void *outBuff, unsigned int *outLen)
{
    return DRV_ERROR_NONE;
}

drvError_t halGetSocVersion(uint32_t devId, char *soc_version, uint32_t len)
{
    return DRV_ERROR_NONE;
}

hdcError_t halHdcGetSessionAttr(HDC_SESSION session, int attr, int *value)
{
    return DRV_ERROR_NONE;
}