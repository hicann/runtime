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
#include "driver/ascend_hal_define.h"
#include "driver/ascend_inpackage_hal.h"
#include "tsd.h"

drvError_t halGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    DEV_MODULE_TYPE mtype = static_cast<DEV_MODULE_TYPE>(moduleType);
	*value = 1;
	if ((mtype == MODULE_TYPE_DCPU) || (mtype == MODULE_TYPE_TSCPU)) {
		*value = 0;
	}

	return DRV_ERROR_NONE;
}

drvError_t drvGetDevNum(uint32_t *num_dev)
{
    *num_dev = 2;
    return DRV_ERROR_NONE;
}

pid_t drvDeviceGetBareTgid(void)
{
    return getpid();
}

int halBuffRecycleByPid(int pid)
{
    return 0;
}
int tsDevSendMsgAsync (unsigned int devId, unsigned int tsId, char *msg, unsigned int msgLen, unsigned int handleId)
{
    return 0;
}
int eSchedSubmitEvent(unsigned int devId, struct event_summary *event)
{
    return 0;
}

drvError_t drvHdcGetTrustedBasePath(int peer_node, int peer_devid, char *base_path, unsigned int path_len)
{
    return DRV_ERROR_NONE;
}


drvError_t drvHdcSendFile(int peer_node, int peer_devid, const char *file, const char *dst_path,
                                    void (*progress_notifier)(struct drvHdcProgInfo *))
{
    return DRV_ERROR_NONE;
}

int halRegisterVmngClient()
{
    return DRV_ERROR_NONE;
}

int halGrpQuery(GroupQueryCmdType cmd,
    void *inBuff, unsigned int inLen, void *outBuff, unsigned int *outLen)
{
    return 0;
}

int halGrpAddProc(const char *name, int pid, GroupShareAttr attr)
{
    return 0;
}

drvError_t halQueueQuery(unsigned int devId, QueueQueryCmdType cmd, QueueQueryInputPara *inPut, QueueQueryOutputPara *outPut)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueGrant(unsigned int devId, int qid, int pid, QueueShareAttr attr)
{
    return DRV_ERROR_NONE;
}

int halGrpAttach(const char *name, int timeout)
{
    return 0;
}

drvError_t halQueueAttach(unsigned int devId, unsigned int qid, int timeOut)
{
    return DRV_ERROR_NONE;
}
int halBuffInit(BuffCfg *cfg)
{
    return 0;
}

hdcError_t drvHdcGetCapacity(struct drvHdcCapacity *capacity)
{
    capacity->chanType = HDC_CHAN_TYPE_SOCKET;
    return DRV_ERROR_NONE;
}

drvError_t halBufEventSubscribe( const char *name, unsigned int threadGrpId, unsigned int event_id, unsigned int devid)
{
    return DRV_ERROR_NONE;
}

drvError_t halGetVdevNum(uint32_t *num_dev)
{
    return DRV_ERROR_NONE;
}

drvError_t halEschedSetGrpEventQos(unsigned int devId, unsigned int grpId,
                                   EVENT_ID eventId, struct event_sched_grp_qos *qos)
{
    return DRV_ERROR_NONE;
}

int halBuffGetInfo(enum BuffGetCmdType cmd, void *inBuff, unsigned int inLen, void *outBuff, unsigned int *outLen)
{
    return 0;
}

int halMbufUnBuild(Mbuf *mbuf, void **buff, uint64_t *len) {
    return 0;
}

void halBuffPut(Mbuf *mbuf, void *buf)
{
    return;
}

drvError_t drvQueryProcessHostPid(int pid, unsigned int *chip_id, unsigned int *vfid,
                                  unsigned int *host_pid, unsigned int *cp_type)
{
    return DRV_ERROR_NONE;
}

int32_t SubModuleProcessResponse(const uint32_t deviceId, const TsdWaitType waitType,
                                 const uint32_t hostPid, const uint32_t vfId,
                                 const uint32_t eventType)
{
    return 0;
}