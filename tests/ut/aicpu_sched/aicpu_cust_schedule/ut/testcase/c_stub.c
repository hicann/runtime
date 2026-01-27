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
#include <sys/types.h>

#include "seccomp.h"

#include "driver/ascend_hal.h"
#include "ascend_inpackage_hal.h"
#include "adump/ide_daemon_api.h"
#include "tsd.h"
#include "toolchain/slog.h"


#define DEVDRV_DRV_INFO printf

static struct event_info g_event = {
    .comm = {
        .event_id = EVENT_TEST,
        .subevent_id = 2,
        .pid = 3,
        .host_pid = 4,
        .grp_id = 5,
        .submit_timestamp = 6,
        .sched_timestamp = 7
    },
    .priv = {
        .msg_len = EVENT_MAX_MSG_LEN,
        .msg = {0}
    }
};

DVresult halMemInitSvmDevice(int hostpid, unsigned int vfid, unsigned int dev_id)
{
    return DRV_ERROR_NONE;
}

DVresult halMemBindSibling(int hostPid, int aicpuPid, unsigned int vfid, unsigned int dev_id, unsigned int flag)
{
    return DRV_ERROR_NONE;
}

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
    *event = g_event;
    return DRV_ERROR_NONE;
}

drvError_t halEschedGetEvent(unsigned int devId, unsigned int grpId, unsigned int threadId,
                   EVENT_ID eventId, struct event_info *event)
{
    *event = g_event;
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

drvError_t halEschedBindHostPid(pid_t hostPid, const char *sign, unsigned int len)
{
    return DRV_ERROR_NONE;
}

void AicpuPulseNotify()
{
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

int halBuffConfigGet(unsigned int *memzone_mx_num, unsigned int *queue_max_num)
{
    return 0;
}

int halMbufAlloc(uint64_t size, Mbuf **mbuf)
{
    return 0;
}
int halMbufAllocByPool(poolHandle pHandle, Mbuf **mbuf)
{
    return 0;
}
int halMbufFree(Mbuf *mbuf)
{
    return 0;
}

int halMbufSetDataLen (Mbuf *mbuf, uint64_t len)
{
    return 0;
}
int halMbufGetDataLen (Mbuf *mbuf, uint64_t *len)
{
    return 0;
}
int halMbufCopyRef (Mbuf *mbuf, Mbuf **newMbuf)
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

int SetQueueWorkMode(unsigned int devid, unsigned int qid, int mode)
{
    return DRV_ERROR_NONE;
}

// for sec comp stub
scmp_filter_ctx seccomp_init(uint32_t def_action)
{
    scmp_filter_ctx ctx;
    return ctx;
}

int seccomp_rule_add(scmp_filter_ctx ctx, uint32_t action, int syscall, unsigned int arg_cnt, ...)
{
    return 0;
}

int seccomp_load(const scmp_filter_ctx ctx)
{
    return 0;
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
    return DRV_ERROR_NONE;
}

pid_t drvDeviceGetBareTgid(void)
{
    return getpid();
}

int halGetDeviceVfMax(unsigned int devId, unsigned int *vf_max_num)
{
    return DRV_ERROR_NONE;
}

drvError_t halBindCgroup(BIND_CGROUP_TYPE bindType)
{
    return DRV_ERROR_NONE;
}

drvError_t halGetSocVersion(uint32_t devId, char *soc_version, uint32_t len)
{
    return DRV_ERROR_NONE;
}

#ifdef __cplusplus
extern "C" {
#endif

/**
 * @brief       : set stackcore file subdirectory to store files in the subdirectory
 * @param [in]  : subdir      subdirectory name
 * @return      : 0 success; -1 failed
 */
__attribute__((weak)) __attribute__((visibility("default"))) int StackcoreSetSubdirectory(const char *subdir)
{
    return 0;
}

#ifdef __cplusplus
}
#endif