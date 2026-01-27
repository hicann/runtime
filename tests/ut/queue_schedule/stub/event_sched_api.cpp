/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <sys/types.h>
#include "driver/ascend_hal.h"
#include <unistd.h>

drvError_t halEschedAttachDevice(unsigned int devId)
{ return DRV_ERROR_NONE; }

drvError_t halEschedDettachDevice(unsigned int devId)
{ return DRV_ERROR_NONE; }

drvError_t halEschedCreateGrp(unsigned int devId, unsigned int grpId, GROUP_TYPE type)
{ return DRV_ERROR_NONE; }

drvError_t halEschedSubscribeEvent(unsigned int devId, unsigned int grpId, unsigned int threadId, unsigned long long eventBitmap)
{ return DRV_ERROR_NONE; }

drvError_t halEschedSetPidPriority(unsigned int devId, SCHEDULE_PRIORITY priority)
{ return DRV_ERROR_NONE; }

drvError_t halEschedSetEventPriority(unsigned int devId, EVENT_ID eventId, SCHEDULE_PRIORITY priority)
{ return DRV_ERROR_NONE; }

int eSchedSetWeight(unsigned int devId, unsigned int weight)
{ return DRV_ERROR_NONE; }

/* return value:
   not find process: SCHED_NO_PROCESS
   no thread subcribe event: SCHED_NO_SUBSCRIBE_THREAD
   too many event: SCHED_PUBLISH_QUE_FULL
*/
drvError_t halEschedSubmitEvent(unsigned int devId, struct event_summary *event)
{ return DRV_ERROR_NONE; }

/* return value:
   timeout : DRV_ERROR_SCHED_WAIT_TIMEOUT
   dettach : SCHED_PROCESS_EXIT
*/
drvError_t halEschedWaitEvent(unsigned int devId, unsigned int grpId,
                    unsigned int threadId, int timeout, struct event_info *event)
{
    sleep(1);
    return DRV_ERROR_NONE;
}

drvError_t halEschedGetEvent(unsigned int devId, unsigned int grpId, unsigned int threadId,
                   EVENT_ID eventId, struct event_info *event)
{ return DRV_ERROR_NONE; }

drvError_t halEschedAckEvent(unsigned int devId, EVENT_ID eventId, unsigned int subeventId, char *msg, unsigned int msgLen)
{ return DRV_ERROR_NONE; }

drvError_t halEschedConfigHostPid(unsigned int devId, int hostPid)
{ return DRV_ERROR_NONE; }

drvError_t halEschedSubmitEventSync(unsigned int devId,
    struct event_summary *event, int timeout, struct event_reply *reply)
{
    if (reply != nullptr) {
        reply->reply_len = reply->buf_len;
    }
    return DRV_ERROR_NONE;
}
