/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpusd_msg_send.h"

#include <unistd.h>
#include <sys/syscall.h>
#include "ts_api.h"
#include "aicpusd_info.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_status.h"
#include "aicpu_async_event.h"
#include "aicpusd_context.h"
#include "type_def.h"

namespace AicpuSchedule {
namespace {
thread_local AICPUSendType g_sendType(AICPUSendType::NO_NEED_SEND);
thread_local AICPUESchedSubmitEvent g_eschedSubmitEvent = {};
thread_local AICPUTsDevSendMsgAsync g_tsDevSendMsgAsync = {};
constexpr uint32_t AICPU_KERNEL_END_OF_SEQUENCE_FLAG = 201U;
constexpr uint32_t TSDEV_SEND_MSG_ASYNC_RETRY_NUM = 10U;
constexpr uint32_t TSDEV_SEND_MSG_ASYNC_RETRY_INTERVAL = 1000U; // sleep 1ms to retry
}

void AicpuMsgSend::SetSchedSubmitEvent(const uint32_t devId, const event_summary &event)
{
    aicpusd_info("Begin to SetSchedSubmitEvent devId[%u].", devId);
    CheckAndSendEvent();
    AICPUESchedSubmitEvent sched = {};
    sched.deviceId = devId;
    const AICPUSubEventInfo *const subEventInfo = PtrToPtr<char_t, AICPUSubEventInfo>(event.msg);
    sched.modelId = subEventInfo->modelId;
    sched.streamId = subEventInfo->para.streamInfo.streamId;
    sched.summary.pid = event.pid;
    sched.summary.event_id = event.event_id;
    sched.summary.subevent_id = event.subevent_id;
    sched.summary.msg_len = event.msg_len;
    g_eschedSubmitEvent = sched;
    g_sendType = AICPUSendType::SCHED_SUBMIT;
}

void AicpuMsgSend::SetTsDevSendMsgAsync(const uint32_t devId, const uint32_t tsId, const TsAicpuSqe &aicpuSqe,
    const uint32_t handleId)
{
    CheckAndSendEvent();
    AICPUTsDevSendMsgAsync tsDev;
    tsDev.deviceId = devId;
    tsDev.modelId = handleId;
    tsDev.tsId = tsId;
    tsDev.sqe = aicpuSqe;
    tsDev.useSqe = true;
    g_tsDevSendMsgAsync = tsDev;
    g_sendType = AICPUSendType::TS_DEV_SEND;
}

void AicpuMsgSend::SetTsDevSendMsgAsync(const uint32_t devId, const uint32_t tsId, const TsAicpuMsgInfo &msgInfo,
        const uint32_t handleId) 
{
    CheckAndSendEvent();
    AICPUTsDevSendMsgAsync tsDev;
    tsDev.deviceId = devId;
    tsDev.modelId = handleId;
    tsDev.tsId = tsId;
    tsDev.msgInfo = msgInfo;
    tsDev.useSqe = false;
    g_tsDevSendMsgAsync = tsDev;
    g_sendType = AICPUSendType::TS_DEV_SEND;
}

void AicpuMsgSend::SendEvent()
{
    if (g_sendType == AICPUSendType::SCHED_SUBMIT) {
        aicpusd_info("Begin to send event, type[%d].", g_sendType);
        event_summary sched = {};
        sched.pid = g_eschedSubmitEvent.summary.pid;
        sched.event_id = g_eschedSubmitEvent.summary.event_id;
        sched.subevent_id = g_eschedSubmitEvent.summary.subevent_id;
        sched.msg_len = g_eschedSubmitEvent.summary.msg_len;
        AICPUSubEventInfo subEventInfo = {};
        subEventInfo.modelId = g_eschedSubmitEvent.modelId;
        subEventInfo.para.streamInfo.streamId = g_eschedSubmitEvent.streamId;
        sched.msg = PtrToPtr<AICPUSubEventInfo, char_t>(&subEventInfo);
        sched.grp_id = 0U; // default : 0
        DeployContext deployCtx = DeployContext::DEVICE;
        (void)GetAicpuDeployContext(deployCtx);
        if ((deployCtx == DeployContext::HOST) || (deployCtx == DeployContext::HOSTCPU)) {
            sched.dst_engine = static_cast<uint32_t>(CCPU_HOST);
            aicpusd_info("SendEvent to dst engine: %u, modelId: %u", sched.dst_engine, subEventInfo.modelId);
        }
        const drvError_t ret = halEschedSubmitEvent(g_eschedSubmitEvent.deviceId, &sched);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("Submit event failed. ret=%d", ret);
        }
        g_sendType = AICPUSendType::NO_NEED_SEND;
        return;
    }
    if (g_sendType == AICPUSendType::TS_DEV_SEND) {
        aicpusd_info("Begin to send event, type[%d].", g_sendType);
        int32_t ret = DRV_ERROR_NONE;
        for (uint32_t index = 0; index < TSDEV_SEND_MSG_ASYNC_RETRY_NUM; index++) {
            if (g_tsDevSendMsgAsync.useSqe) {
                ret = tsDevSendMsgAsync(g_tsDevSendMsgAsync.deviceId, g_tsDevSendMsgAsync.tsId,
                PtrToPtr<TsAicpuSqe, char_t>(&(g_tsDevSendMsgAsync.sqe)), static_cast<uint32_t>(sizeof(TsAicpuSqe)),
                g_tsDevSendMsgAsync.modelId);
            } else {
                ret = tsDevSendMsgAsync(g_tsDevSendMsgAsync.deviceId, g_tsDevSendMsgAsync.tsId,
                PtrToPtr<TsAicpuMsgInfo, char_t>(&(g_tsDevSendMsgAsync.msgInfo)), 
                static_cast<uint32_t>(sizeof(TsAicpuMsgInfo)), g_tsDevSendMsgAsync.modelId);
            }
            if (ret == DRV_ERROR_NONE) {
                aicpusd_info("Send async msg to ts success, deviceId=%u, tsId=%u",
                             g_tsDevSendMsgAsync.deviceId, g_tsDevSendMsgAsync.tsId);
                g_sendType = AICPUSendType::NO_NEED_SEND;
                return;
            } else {
                aicpusd_run_info("Send async msg to ts not success. ret=%d, deviceId=%u, tsId=%u, retry times=%d",
                                 ret, g_tsDevSendMsgAsync.deviceId,  g_tsDevSendMsgAsync.tsId, index);
            }
            (void)usleep(TSDEV_SEND_MSG_ASYNC_RETRY_INTERVAL);
        }
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("After retry, Send async msg to ts failed. ret=%d, deviceId=%u, tsId=%u",
                        ret, g_tsDevSendMsgAsync.deviceId,  g_tsDevSendMsgAsync.tsId);
        }
        return;
    }
}

int32_t AicpuMsgSend::SendAICPUSubEvent(const char_t * const msg, const uint32_t msgLen,
                                        const uint32_t subEventId, const uint32_t grpId,
                                        const bool syncSendFlag)
{
    aicpusd_info("Begin to send aicpu subevent, syncflag is %d", static_cast<int32_t>(syncSendFlag));
    if (msg == nullptr) {
        aicpusd_err("The message is null.");
        return AICPU_SCHEDULE_ERROR_INVAILD_EVENT_SUBMIT;
    }

    if (msgLen == 0U) {
        aicpusd_err("The size of message is zero.");
        return AICPU_SCHEDULE_ERROR_INVAILD_EVENT_SUBMIT;
    }
    event_summary eventInfoSummary = {};
    eventInfoSummary.pid = getpid();
    eventInfoSummary.event_id = EVENT_AICPU_MSG;
    eventInfoSummary.subevent_id = subEventId;
    std::string msgStr(msg, static_cast<size_t>(msgLen));
    eventInfoSummary.msg = &msgStr[0];
    eventInfoSummary.msg_len = msgLen;
    eventInfoSummary.grp_id = grpId;
    DeployContext deployCtx = DeployContext::DEVICE;
    (void)GetAicpuDeployContext(deployCtx);
    if ((deployCtx == DeployContext::HOST) || (deployCtx == DeployContext::HOSTCPU) ||
        (subEventId == static_cast<uint32_t>(AICPU_SUB_EVENT_ACTIVE_MODEL))) {
        eventInfoSummary.dst_engine = static_cast<uint32_t>(CCPU_LOCAL);
        aicpusd_info("SendAICPUSubEvent to dst engine: %u", eventInfoSummary.dst_engine);
    }

    if (syncSendFlag) {
        const drvError_t ret = halEschedSubmitEvent(AicpuDrvManager::GetInstance().GetDeviceId(),
                                                    &eventInfoSummary);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("Failed to submit aicpu event. ret is %d.", ret);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        return AICPU_SCHEDULE_OK;
    }

    AicpuMsgSend::SetSchedSubmitEvent(AicpuDrvManager::GetInstance().GetDeviceId(), eventInfoSummary);
    return AICPU_SCHEDULE_OK;
}

void AicpuMsgSend::CheckAndSendEvent()
{
    if (g_sendType != AICPUSendType::NO_NEED_SEND) {
        SendEvent();
    }
}

void AicpuMsgSend::AicpuReportNotifyInfo(const aicpu::AsyncNotifyInfo &notifyInfo)
{
    aicpusd_err("Send aicpu notify info to ts, streamId=%u, taskId=%lu, retcode=%u.",
                notifyInfo.streamId, notifyInfo.taskId, notifyInfo.retCode);
    
    AicpuSqeAdapter aicpuSqeAdapter(FeatureCtrl::GetTsMsgVersion());
    AicpuSqeAdapter::AicpuRecordInfo recordInfo(notifyInfo.waitId, notifyInfo.waitType, notifyInfo.retCode,
                                                static_cast<uint8_t>(notifyInfo.ctx.tsId), notifyInfo.taskId,
                                                notifyInfo.streamId, notifyInfo.ctx.deviceId);
    const int32_t ret =  aicpuSqeAdapter.AicpuRecordResponseToTs(recordInfo);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("AicpuRecordResponseToTs failed. ret=%d, streamId=%u, taskId=%lu.",
                    ret, notifyInfo.streamId, notifyInfo.taskId);
    }
}

void AicpuMsgSend::SendAicpuRecordMsg(const void *const notifyParam, const uint32_t paramLen)
{
    if ((notifyParam == nullptr) || (paramLen != sizeof(aicpu::AsyncNotifyInfo))) {
        aicpusd_err("NotifyEventWait param is null or paramLen not matched. paramLen = %u, AsyncNotifyInfo size = %zu",
            paramLen, sizeof(aicpu::AsyncNotifyInfo));
        return;
    }
    const aicpu::AsyncNotifyInfo *const notifyInfo = reinterpret_cast<const aicpu::AsyncNotifyInfo *>(notifyParam);
    if ((notifyInfo->retCode != 0U) && (notifyInfo->retCode != AICPU_KERNEL_END_OF_SEQUENCE_FLAG)) {
        aicpusd_err("Aicpu recevied error code, wait_type[%u], wait_id[%u], task_id[%lu], stream_id[%u], ret_code[%u].",
                    notifyInfo->waitType, notifyInfo->waitId, notifyInfo->taskId, notifyInfo->streamId,
                    notifyInfo->retCode);
    } else {
        aicpusd_info("NotifyEventWait, wait_type[%u], wait_id[%u], task_id[%lu], stream_id[%u], ret_code[%u].",
                     notifyInfo->waitType, notifyInfo->waitId, notifyInfo->taskId, notifyInfo->streamId,
                     notifyInfo->retCode);
    }

    // create param.
    int32_t sendRet = 0;
    int32_t retCode = 0;
    bool retSucc = notifyInfo->retCode == 0U;
    bool isRetEndSequence = (notifyInfo->retCode == AICPU_KERNEL_END_OF_SEQUENCE_FLAG);
    retCode = retSucc ? (notifyInfo->retCode) : (isRetEndSequence
                                                ? static_cast<uint16_t>(TS_ERROR_END_OF_SEQUENCE)
                                                : static_cast<uint16_t>(TS_ERROR_AICPU_EXCEPTION));
    AicpuSqeAdapter aicpuSqeAdapter(FeatureCtrl::GetTsMsgVersion());
    AicpuSqeAdapter::AicpuRecordInfo recordInfo(notifyInfo->waitId, notifyInfo->waitType, retCode,
                                                static_cast<uint8_t>(notifyInfo->ctx.tsId), notifyInfo->taskId,
                                                notifyInfo->streamId, notifyInfo->ctx.deviceId);
    sendRet = aicpuSqeAdapter.AicpuRecordResponseToTs(recordInfo);
    if (sendRet != static_cast<uint32_t>(AICPU_SCHEDULE_OK)) {
        aicpusd_err("Send event notify to ts failed, sendRet=%d, notifyId=%u, retVal=%d.", sendRet, notifyInfo->waitId,
            notifyInfo->retCode);
        return;
    }
    aicpusd_info("send event notify to ts success, notifyId=%u, hostpid=%u, retCode=%d.", notifyInfo->waitId,
                 AicpuDrvManager::GetInstance().GetHostPid(), notifyInfo->retCode);
}
}
