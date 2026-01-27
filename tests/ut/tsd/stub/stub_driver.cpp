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
#include <stdint.h>
#include <sys/types.h>
#include <stdlib.h>
#include <unistd.h>
#include "stub_log.h"
#include "driver/ascend_hal.h"
#include "driver/ascend_inpackage_hal.h"
#include "inc/weak_ascend_hal.h"

extern "C" int tsDevSendMsgAsync (unsigned int devId, unsigned int tsId, char *msg, unsigned int msgLen, unsigned int handleId);
static struct event_info g_event = {
    .comm = {
        .event_id = 1,
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

drvError_t halEschedSubmitEvent(unsigned int devId, struct event_summary *event)
{
    return DRV_ERROR_NONE;
}

int tsDevSendMsgAsync (unsigned int devId, unsigned int tsId, char *msg, unsigned int msgLen, unsigned int handleId)
{
    return 0;
}
int eSchedSubmitEvent(unsigned int devId, struct event_summary *event)
{
    return 0;
}

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

drvError_t drvHdcGetTrustedBasePath(int peer_node, int peer_devid, char *base_path, unsigned int path_len)
{
    return DRV_ERROR_NONE;
}

int halVerifyImg(HAL_VERIFY_TYPE verify_type, HAL_IMG_ID image_id, const char *img_path, int mode)
{
    return 0;
}

drvError_t drvHdcSendFile(int peer_node, int peer_devid, const char *file, const char *dst_path,
                                    void (*progress_notifier)(struct drvHdcProgInfo *))
{
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
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

drvError_t halEschedDettachDevice(unsigned int devId)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedSubscribeEvent(unsigned int devId, unsigned int grpId,
                    unsigned int threadId, unsigned long long eventBitmap)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedWaitEvent(unsigned int devId, unsigned int grpId,
                    unsigned int threadId, int timeout, struct event_info *event)
{
    sleep(1);
    *event = g_event;
    return DRV_ERROR_NONE;
}

drvError_t drvBindHostPid(struct drvBindHostpidInfo info)
{
    return DRV_ERROR_NONE;
}

drvError_t drvUnbindHostPid(struct drvBindHostpidInfo info)
{
    return DRV_ERROR_NONE;
}

int halRegisterVmngClient()
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedAckEvent(unsigned int devId, EVENT_ID eventId, unsigned int subeventId,
                   char *msg, unsigned int msgLen)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueGrant(unsigned int devId, int qid, int pid, QueueShareAttr attr)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueryDevpid(struct halQueryDevpidInfo info, pid_t *dev_pid)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueQuery(unsigned int devId, QueueQueryCmdType cmd, QueueQueryInputPara *inPut, QueueQueryOutputPara *outPut)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueInit(unsigned int devId)
{
    return DRV_ERROR_NONE;
}

int halGrpQuery(GroupQueryCmdType cmd, void *inBuff, unsigned int inLen, void *outBuff, unsigned int *outLen)
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

int halGrpAddProc(const char *name, int pid, GroupShareAttr attr)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedSubmitEventSync(unsigned int devId,
                                    struct event_summary *event, int timeout, struct event_reply *reply)
{
    return DRV_ERROR_NONE;
}

drvError_t halGetVdevNum(uint32_t *devNum)
{
    return DRV_ERROR_NONE;
}

drvError_t halSensorNodeRegister(uint32_t devId, struct halSensorNodeCfg *Cfg, uint64_t *Handle)
{
    return DRV_ERROR_NONE;
}

drvError_t halSensorNodeUnregister(uint32_t devId, uint64_t Handle)
{
    return DRV_ERROR_NONE;
}

drvError_t halSensorNodeUpdateState(uint32_t devId, uint64_t Handle, int val, halGeneralEventType_t flag)
{
    if (devId == 1) {
        return DRV_ERROR_IOCRL_FAIL;
    }
    if ((devId == 0U) && (flag == GENERAL_EVENT_TYPE_OCCUR)) {
        return DRV_ERROR_NONE;
    }
    if ((devId == 0U) && (flag == GENERAL_EVENT_TYPE_RESUME)) {
        return DRV_ERROR_IOCRL_FAIL;
    }
    return DRV_ERROR_NONE;
}

DLLEXPORT DVresult halMemGetInfo(DVdevice device, unsigned int type, struct MemInfo *info)
{
    if (device == 5) {
        info->numa_info.node_cnt = 1U;
        info->numa_info.node_id[0] = 129;
    }
    return DRV_ERROR_NONE;
}

drvError_t drvQueryProcessHostPid(int pid, unsigned int *chip_id, unsigned int *vfid,
                                  unsigned int *host_pid, unsigned int *cp_type)
{
    (void)chip_id;
    (void)vfid;
    (void)cp_type;
    if (pid == 123) {
        return 0;
    } else if (pid == 456) {
        return 1;
    } else {
        *host_pid = 456;
    }
    return DRV_ERROR_NONE;
}

drvError_t halSetDeviceInfoByBuff(uint32_t deviceId, int32_t moduleType, int32_t infoType, void* buf, int32_t size) {
  (void)moduleType;
  (void)infoType;
  (void)buf;
  (void)size;
  if (deviceId < 2) {
    return DRV_ERROR_NONE;
  } else if (deviceId == 3) {
    return DRV_ERROR_BUSY;
  } else {
    return DRV_ERROR_NO_DEVICE;
  }
}

drvError_t halTsCmdlistMemMap(unsigned int devId, unsigned int tsId)
{
    return DRV_ERROR_NONE;
}

drvError_t drvHdcGetTrustedBasePathV2(int peer_node, int peer_devid, char *base_path, unsigned int path_len)
{
    return DRV_ERROR_NONE;
}

drvError_t drvHdcSendFileV2(int peer_node, int peer_devid, const char *file, const char *dst_path,
                            void (*progress_notifier)(struct drvHdcProgInfo *))
{
    return DRV_ERROR_NONE;
}