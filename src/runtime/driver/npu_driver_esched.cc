/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "npu_driver.hpp"
#include "driver/ascend_hal.h"
#include "driver/ascend_inpackage_hal.h"
#include "errcode_manage.hpp"
#include "error_message_manage.hpp"
#include "rt_log.h"

namespace {
constexpr int32_t EVENT_SYNC_TIMEOUT = -1;
} // namespace

namespace cce {
namespace runtime {

rtError_t NpuDriver::EschedSubmitEvent(const int32_t devId, const rtEschedEventSummary_t* const evt)
{
    RT_LOG(RT_LOG_INFO, "Esched create group, drv devId=%d.", devId);

    COND_RETURN_WARN(
        &halEschedSubmitEvent == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halEschedSubmitEvent does not exist.");

    struct event_summary drv_event_summary;
    drv_event_summary.pid = evt->pid;
    drv_event_summary.grp_id = evt->grpId;
    drv_event_summary.event_id = static_cast<EVENT_ID>(evt->eventId);
    drv_event_summary.subevent_id = evt->subeventId;
    drv_event_summary.msg_len = evt->msgLen;
    drv_event_summary.msg = evt->msg;
    drv_event_summary.dst_engine = evt->dstEngine;
    drv_event_summary.policy = static_cast<SCHEDULE_POLICY>(evt->policy);
    const drvError_t drvRet = halEschedSubmitEvent(static_cast<uint32_t>(devId), &drv_event_summary);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halEschedSubmitEvent failed, drvRetCode=%d, drvDevId=%d.",
            static_cast<int32_t>(drvRet), devId);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedSubmitEventSync(
    const int32_t devId, rtEschedEventSummary_t* const evt, rtEschedEventReply_t* const ack)
{
    RT_LOG(RT_LOG_INFO, "submit event, drv devId=%d.", devId);

    COND_RETURN_WARN(
        &halEschedSubmitEventSync == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halEschedSubmitEventSync does not exist.");
    struct event_summary drvEvent = {};
    drvEvent.pid = evt->pid;
    drvEvent.grp_id = evt->grpId;
    drvEvent.event_id = static_cast<EVENT_ID>(evt->eventId);
    drvEvent.subevent_id = evt->subeventId;
    drvEvent.msg_len = evt->msgLen;
    drvEvent.msg = evt->msg;
    drvEvent.dst_engine = evt->dstEngine;
    drvEvent.policy = static_cast<SCHEDULE_POLICY>(evt->policy);

    struct event_reply drvAck = {};
    drvAck.buf = ack->buf;
    drvAck.buf_len = ack->bufLen;
    const drvError_t drvRet =
        halEschedSubmitEventSync(static_cast<uint32_t>(devId), &drvEvent, EVENT_SYNC_TIMEOUT, &drvAck);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halEschedSubmitEventSync failed, drvRetCode=%d, drvDevId=%d.",
            static_cast<int32_t>(drvRet), devId);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    ack->replyLen = drvAck.reply_len;
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedAttachDevice(const uint32_t devId)
{
    RT_LOG(RT_LOG_INFO, "Esched attach device, drv devId=%u.", devId);

    COND_RETURN_WARN(
        &halEschedAttachDevice == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halEschedAttachDevice does not exist.");

    const drvError_t drvRet = halEschedAttachDevice(devId);
    if ((drvRet != DRV_ERROR_NONE) && (drvRet != DRV_ERROR_PROCESS_REPEAT_ADD)) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halEschedAttachDevice failed, drvRetCode=%d, drvDevId=%u.",
            static_cast<int32_t>(drvRet), devId);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedDettachDevice(const uint32_t devId)
{
    RT_LOG(RT_LOG_INFO, "Esched dettach device, drv devId=%u.", devId);

    COND_RETURN_WARN(
        &halEschedDettachDevice == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halEschedDettachDevice does not exist.");

    const drvError_t drvRet = halEschedDettachDevice(devId);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halEschedDettachDevice failed, drvRetCode=%d, drvDevId=%u.",
            static_cast<int32_t>(drvRet), devId);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedCreateGrp(const int32_t devId, const uint32_t grpId, const rtGroupType_t type)
{
    RT_LOG(
        RT_LOG_INFO, "Esched create group, drv devId=%d, grpId=%u, type=%u.", devId, grpId,
        static_cast<uint32_t>(type));

    COND_RETURN_WARN(
        &halEschedCreateGrp == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halEschedCreateGrp does not exist.");

    const drvError_t drvRet = halEschedCreateGrp(static_cast<uint32_t>(devId), grpId, static_cast<GROUP_TYPE>(type));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halEschedCreateGrp failed, drvRetCode=%d, drvDevId=%d, grpId=%u, type=%u.",
            static_cast<int32_t>(drvRet), devId, grpId, static_cast<uint32_t>(type));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedCreateGrpEx(const uint32_t devId, const uint32_t maxThreadNum, uint32_t* const grpId)
{
    COND_RETURN_WARN(
        &halEschedCreateGrpEx == nullptr, RT_ERROR_DRV_NOT_SUPPORT, "[drv api] halEschedCreateGrpEx does not exist");
    struct esched_grp_para grpPara = {};
    errno_t rc = memset_s(&grpPara, sizeof(esched_grp_para), 0, sizeof(esched_grp_para));
    COND_LOG(rc != EOK, "memset_s failed, size=%zu(bytes), retCode=%d!", sizeof(esched_grp_para), rc);
    grpPara.type = GRP_TYPE_BIND_DP_CPU;
    grpPara.threadNum = maxThreadNum;
    rc = strcpy_s(grpPara.grp_name, sizeof(grpPara.grp_name), "stmSyncEGrp");
    COND_LOG_ERROR(rc != EOK, "strcpy_s failed, max size=%zu(bytes), retCode=%d!", sizeof(grpPara.grp_name), rc);
    const drvError_t drvRet = halEschedCreateGrpEx(devId, &grpPara, grpId);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halEschedCreateGrpEx failed, drvRetCode=%d, drvDevId=%u.",
            static_cast<int32_t>(drvRet), devId);
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "process EschedCreateGrpEx, grpId=%u.", *grpId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedSubscribeEvent(
    const int32_t devId, const uint32_t grpId, const uint32_t threadId, const uint64_t eventBitmap)
{
    RT_LOG(
        RT_LOG_INFO,
        "Esched subscribe event, drv devId=%d, grpId=%u, "
        "threadId=%u, eventBitmap=%" PRIu64,
        devId, grpId, threadId, eventBitmap);

    COND_RETURN_WARN(
        &halEschedSubscribeEvent == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halEschedSubscribeEvent does not exist.");

    const drvError_t drvRet =
        halEschedSubscribeEvent(static_cast<uint32_t>(devId), grpId, threadId, static_cast<UINT64>(eventBitmap));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halEschedSubscribeEvent failed, drvRetCode=%d, drvDevId=%d, grpId=%u.",
            static_cast<int32_t>(drvRet), devId, grpId);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedWaitEvent(
    const int32_t devId, const uint32_t grpId, const uint32_t threadId, const int32_t timeout,
    rtEschedEventSummary_t* const evt)
{
    RT_LOG(
        RT_LOG_INFO, "Esched wait event, drv devId=%d, grpId=%u, threadId=%u, timeout=%dms.", devId, grpId, threadId,
        timeout);

    COND_RETURN_WARN(
        &halEschedWaitEvent == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halEschedWaitEvent does not exist.");

    struct event_info evtInfo = {};
    const drvError_t drvRet = halEschedWaitEvent(static_cast<uint32_t>(devId), grpId, threadId, timeout, &evtInfo);
    COND_RETURN_WARN(
        drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halEschedWaitEvent failed: drv devId=%d, eventId=%d,"
        "subeventId=%u, grpId=%u, pid=%u, drvRetCode=%d.",
        devId, evt->eventId, evt->subeventId, evt->grpId, evt->pid, static_cast<int32_t>(drvRet));
    evt->eventId = static_cast<int32_t>(evtInfo.comm.event_id);
    evt->subeventId = evtInfo.comm.subevent_id;
    evt->pid = evtInfo.comm.pid;
    evt->grpId = evtInfo.comm.grp_id;
    if ((evt->msg != nullptr) && (evt->msgLen > 0)) {
        const errno_t ret =
            memcpy_s(evt->msg, evt->msgLen, evtInfo.priv.msg, static_cast<size_t>(evtInfo.priv.msg_len));
        COND_RETURN_ERROR_MSG_CALL(
            ERR_MODULE_SYSTEM, ret != EOK, RT_ERROR_SEC_HANDLE,
            "Failed to call memcpy_s to copy evt->msg, src=%p, dest=%p, dest_max=%u, count=%u, retCode=%#x.",
            static_cast<const void*>(evtInfo.priv.msg), static_cast<void*>(evt->msg), evt->msgLen,
            static_cast<uint32_t>(evtInfo.priv.msg_len), static_cast<uint32_t>(ret));
        evt->msgLen = evtInfo.priv.msg_len;
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedAckEvent(
    const int32_t devId, const rtEventIdType_t evtId, const uint32_t subeventId, char_t* const msg, const uint32_t len)
{
    RT_LOG(
        RT_LOG_INFO,
        "Esched subscribe event, drv devId=%d, grpevent_idId=%u, "
        "subevent_id=%u, len=%u.",
        devId, static_cast<uint32_t>(evtId), subeventId, len);

    COND_RETURN_WARN(
        &halEschedAckEvent == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halEschedAckEvent does not exist.");

    const drvError_t drvRet =
        halEschedAckEvent(static_cast<uint32_t>(devId), static_cast<EVENT_ID>(evtId), subeventId, msg, len);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet,
            "Call driver api halEschedAckEvent failed, drvRetCode=%d, drvDevId=%d, eventId=%u, subeventId=%u, "
            "len=%u(bytes).",
            static_cast<int32_t>(drvRet), devId, static_cast<uint32_t>(evtId), subeventId, len);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedQueryInfo(
    const uint32_t devId, const rtEschedQueryType type, rtEschedInputInfo* inPut, rtEschedOutputInfo* outPut)
{
    RT_LOG(RT_LOG_INFO, "EschedQueryInfo, drv devId=%u, type=%d,", devId, type);
    COND_RETURN_WARN(
        &halEschedQueryInfo == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halEschedQueryInfo does not exist.");

    const drvError_t drvRet = halEschedQueryInfo(
        devId, static_cast<ESCHED_QUERY_TYPE>(type), RtPtrToPtr<esched_input_info*>(inPut),
        RtPtrToPtr<esched_output_info*>(outPut));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halEschedQueryInfo failed, drvRetCode=%d, drvDevId=%u, type=%d.",
            static_cast<int32_t>(drvRet), devId, type);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

static uint64_t GetTimeInterval(const mmTimespec& beginTime, const mmTimespec& endTime)
{
    const uint64_t beginCnt =
        static_cast<uint64_t>(beginTime.tv_sec) * RT_MS_PER_S + static_cast<uint64_t>(beginTime.tv_nsec) / RT_MS_TO_NS;
    const uint64_t endCnt =
        static_cast<uint64_t>(endTime.tv_sec) * RT_MS_PER_S + static_cast<uint64_t>(endTime.tv_nsec) / RT_MS_TO_NS;
    uint64_t count = (endCnt > beginCnt) ? (endCnt - beginCnt) : 0ULL;
    return count;
}

drvError_t NpuDriver::DrvEschedManage(
    const uint32_t devId, const int32_t timeout, const uint32_t eschedTid, const uint32_t grpId,
    struct halReportRecvInfo* info)
{
    RT_LOG(
        RT_LOG_INFO, "process DrvEschedManage, deviceId=%u, timeout=%ums, eschedTid=%u, grpId=%u.", devId, timeout,
        eschedTid, grpId);
    drvError_t drvRet = DRV_ERROR_NONE;
    uint64_t count = 0LL;
    int32_t timeoutLeft = timeout;
    mmTimespec lastTimeSpec = mmGetTickCount();
    info->report_cqe_num = 0U;
    while (info->report_cqe_num == 0U) {
        drvRet = halEschedThreadSwapout(devId, MAX_UINT32_NUM, MAX_UINT32_NUM);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(
                drvRet, "Call driver api halEschedThreadSwapout failed, drvRetCode=%d, drvDevId=%u, grpId=%u, tid=%u.",
                static_cast<int32_t>(drvRet), devId, grpId, eschedTid);
            return drvRet;
        }

        if (timeoutLeft > 0) {
            mmTimespec curTimeSpec = mmGetTickCount();
            count = GetTimeInterval(lastTimeSpec, curTimeSpec);
            lastTimeSpec = curTimeSpec;
            if (count >= static_cast<uint64_t>(timeoutLeft)) {
                RT_LOG(RT_LOG_ERROR, "Stream sync timeout, time=%lums, total timeout=%dms.", count, timeout);
                return DRV_ERROR_WAIT_TIMEOUT;
            }
            timeoutLeft = (timeoutLeft - static_cast<int32_t>(count));
        }

        RT_LOG(RT_LOG_DEBUG, "timeoutLeft=%u", timeoutLeft);

        struct event_info back_event_info = {};
        drvRet = halEschedWaitEvent(devId, grpId, eschedTid, timeoutLeft, &back_event_info);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(
                drvRet, "Call driver api halEschedWaitEvent failed, drvRetCode=%d, drvDevId=%u, grpId=%u, tid=%u.",
                static_cast<int32_t>(drvRet), devId, grpId, eschedTid);
            return drvRet;
        }

        drvRet = halCqReportRecv(devId, info);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(
                drvRet, "Call driver api halCqReportRecv failed, drvRetCode=%d, drvDevId=%u.",
                static_cast<int32_t>(drvRet), devId);
            return drvRet;
        }

        RT_LOG(RT_LOG_DEBUG, "info->report_cqe_num=%u", info->report_cqe_num);
    }

    return drvRet;
}

} // namespace runtime
} // namespace cce
