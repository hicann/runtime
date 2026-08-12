/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
// L1 符号接管层：导出与 pkg_inc/driver 同名的 esched 强符号，链接期接管 HAL 弱符号，转调 EschedSimEngine。
// OBJECT library 保证 L1 shim 与 L4 testcase 共享同一个 EschedSimEngine 单例（SHARED 会因 exe/so 各自实例化而割裂）。
#include "ascend_hal_base.h"
#include "ascend_hal_define.h"
#include "ascend_hal_error.h"
#include "ascend_hal_external.h"

#include "sim/esched_sim_engine.h"

extern "C" {

drvError_t halEschedAttachDevice(unsigned int devId) { return sim::EschedSimEngine::Instance().AttachDevice(devId); }

drvError_t halEschedDettachDevice(unsigned int devId) { return sim::EschedSimEngine::Instance().DetachDevice(devId); }

drvError_t halEschedCreateGrp(unsigned int devId, unsigned int grpId, GROUP_TYPE type)
{
    return sim::EschedSimEngine::Instance().CreateGrp(devId, grpId, type);
}

drvError_t halEschedSubscribeEvent(
    unsigned int devId, unsigned int grpId, unsigned int threadId, unsigned long long eventBitmap)
{
    return sim::EschedSimEngine::Instance().SubscribeEvent(devId, grpId, threadId, eventBitmap);
}

drvError_t halEschedWaitEvent(
    unsigned int devId, unsigned int grpId, unsigned int threadId, int timeout, struct event_info* event)
{
    return sim::EschedSimEngine::Instance().WaitEvent(devId, grpId, threadId, timeout, event);
}

drvError_t halEschedGetEvent(
    unsigned int devId, unsigned int grpId, unsigned int threadId, EVENT_ID eventId, struct event_info* event)
{
    return sim::EschedSimEngine::Instance().GetEvent(devId, grpId, threadId, eventId, event);
}

drvError_t halEschedSubmitEvent(unsigned int devId, struct event_summary* event)
{
    return sim::EschedSimEngine::Instance().SubmitEvent(devId, event);
}

drvError_t halEschedSubmitEventBatch(
    unsigned int devId, SUBMIT_FLAG flag, struct event_summary* events, unsigned int event_num,
    unsigned int* succ_event_num)
{
    return sim::EschedSimEngine::Instance().SubmitEventBatch(devId, flag, events, event_num, succ_event_num);
}

drvError_t halEschedSubmitEventSync(
    unsigned int devId, struct event_summary* event, int timeout, struct event_reply* reply)
{
    (void)timeout;
    if (reply != nullptr) {
        reply->reply_len = 0U;
    }
    return sim::EschedSimEngine::Instance().SubmitEvent(devId, event);
}

drvError_t halEschedAckEvent(
    unsigned int devId, EVENT_ID eventId, unsigned int subeventId, char* msg, unsigned int msgLen)
{
    return sim::EschedSimEngine::Instance().AckEvent(devId, eventId, subeventId, msg, msgLen);
}

drvError_t halEschedSetPidPriority(unsigned int devId, SCHEDULE_PRIORITY priority)
{
    (void)devId;
    (void)priority;
    return DRV_ERROR_NONE;
}

drvError_t halEschedSetEventPriority(unsigned int devId, EVENT_ID eventId, SCHEDULE_PRIORITY priority)
{
    (void)devId;
    (void)eventId;
    (void)priority;
    return DRV_ERROR_NONE;
}

drvError_t halEschedSetGrpEventQos(
    unsigned int devId, unsigned int grpId, EVENT_ID eventId, struct event_sched_grp_qos* qos)
{
    (void)devId;
    (void)grpId;
    (void)eventId;
    (void)qos;
    return DRV_ERROR_NONE;
}

drvError_t halEschedThreadSwapout(unsigned int devId, unsigned int grpId, unsigned int threadId)
{
    (void)devId;
    (void)grpId;
    (void)threadId;
    return DRV_ERROR_NONE;
}

drvError_t halEschedThreadGiveup(unsigned int devId, unsigned int grpId, unsigned int threadId)
{
    (void)devId;
    (void)grpId;
    (void)threadId;
    return DRV_ERROR_NONE;
}

} // extern "C"
