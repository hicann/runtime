/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "atrace_log.hpp"

namespace cce {
namespace runtime {
typedef rtError_t (*pfnAtraceSubmit)(const AtraceParams &atraceParams);

pfnAtraceSubmit g_atraceSubmitFunc[TYPE_RESERVED] = {nullptr};
std::string recycleTypeStr[TYPE_FUNC_RESERVED] = {};

void TrySubmitAtraceLog(TraHandle atraceHandle, const void *buffer, uint32_t bufSize)
{
    // some soc don't have atrace, so need check nullptr
    if (AtraceSubmit == nullptr) {
        return;
    }
    TraStatus errNum = AtraceSubmit(atraceHandle, buffer, bufSize);
    if (errNum < 0) {
        RT_LOG(RT_LOG_WARNING, "Can't use AtraceSubmit to submit log, errorCode=%d.", errNum);
    }
}

rtError_t AtraceSubmitForLogicCqRecord(const AtraceParams &atraceParams)
{
    char buff[PER_ATRACE_LOG_LEN] = {};
    const CqReportParams *cqReport = &(atraceParams.u.cqReportParams);
    int32_t ret = snprintf_s(buff, PER_ATRACE_LOG_LEN, PER_ATRACE_LOG_LEN - 1, "CqReport:devId=%d,stmId=%u,"
        "tskId=%hu,cqId=%u,errCode=%u,cqType=%hhu,tid=%d", atraceParams.deviceId, atraceParams.streamId,
        atraceParams.taskId, cqReport->cqId, cqReport->errCode, cqReport->cqType, atraceParams.tid);
    COND_RETURN_WARN(ret < 0, RT_ERROR_SEC_HANDLE, "Snprintf_s for generating runtime atrace msg abnormally.");
    TrySubmitAtraceLog(atraceParams.handle, buff, PER_ATRACE_LOG_LEN);
    return RT_ERROR_NONE;
}

rtError_t AtraceSubmitForRecycleTask(const AtraceParams &atraceParams)
{
    char buff[PER_ATRACE_LOG_LEN] = {};
    const TaskRecycleParams *taskRecycle = &(atraceParams.u.taskRecycleParams);
    int32_t ret = snprintf_s(buff, PER_ATRACE_LOG_LEN, PER_ATRACE_LOG_LEN - 1, "%s:devId=%u,"
        "stmId=%u,lastTaskId=%u,exeTaskId=%u,tid=%u", recycleTypeStr[taskRecycle->funcType].c_str(),
        atraceParams.deviceId, atraceParams.streamId, taskRecycle->lastTaskId, taskRecycle->exeTaskId,
        atraceParams.tid);
    COND_RETURN_WARN(ret < 0, RT_ERROR_SEC_HANDLE, "Snprintf_s for generating runtime atrace msg abnormally.");
    TrySubmitAtraceLog(atraceParams.handle, buff, PER_ATRACE_LOG_LEN);
    return RT_ERROR_NONE;
}

rtError_t AtraceSubmitForEventRecord(const AtraceParams &atraceParams)
{
    char buff[PER_ATRACE_LOG_LEN] = {};
    const EventRecordParams *eventRecord = &(atraceParams.u.eventRecordParams);
    const int32_t ret = snprintf_s(&(buff[0]), PER_ATRACE_LOG_LEN, PER_ATRACE_LOG_LEN - 1, "eventRecord:devId=%u,"
        "stmId=%u,tskId=%hu,eventId=%d,waitCqFlag=%u,waitCqId=%hu,addr=0x%lx,tid=%u", atraceParams.deviceId,
        atraceParams.streamId, atraceParams.taskId, eventRecord->eventId, eventRecord->waitCqFlag,
        eventRecord->waitCqId, eventRecord->eventAddrLowEightBit, atraceParams.tid);
    COND_RETURN_WARN(ret < 0, RT_ERROR_SEC_HANDLE, "Snprintf_s for generating runtime atrace msg abnormally.");
    TrySubmitAtraceLog(atraceParams.handle, &(buff[0]), PER_ATRACE_LOG_LEN);
    return RT_ERROR_NONE;
}

rtError_t AtraceSubmitForEventReset(const AtraceParams &atraceParams)
{
    char buff[PER_ATRACE_LOG_LEN] = {};
    const EventResetParams *eventReset = &(atraceParams.u.eventResetParams);
    const int32_t ret = snprintf_s(&(buff[0]),
        PER_ATRACE_LOG_LEN,
        PER_ATRACE_LOG_LEN - 1,
        "eventReset:devId=%u,"
        "stmId=%u,tskId=%hu,eventId=%d,isNotify=%hu,addr=0x%lx,tid=%d",
        atraceParams.deviceId,
        atraceParams.streamId,
        atraceParams.taskId,
        eventReset->eventId,
        eventReset->isNotify,
        eventReset->eventAddrLowEightBit,
        atraceParams.tid);
    COND_RETURN_WARN(ret < 0, RT_ERROR_SEC_HANDLE, "Snprintf_s for generating runtime atrace msg abnormally.");
    TrySubmitAtraceLog(atraceParams.handle, &(buff[0]), PER_ATRACE_LOG_LEN);
    return RT_ERROR_NONE;
}

rtError_t AtraceSubmitForEventWait(const AtraceParams &atraceParams)
{
    char buff[PER_ATRACE_LOG_LEN] = {};
    const int32_t ret = snprintf_s(&(buff[0]),
        PER_ATRACE_LOG_LEN,
        PER_ATRACE_LOG_LEN - 1,
        "eventWait:devId=%u,"
        "stmId=%u,tskId=%hu,eventId=%d,addr=0x%lx,tid=%u",
        atraceParams.deviceId,
        atraceParams.streamId,
        atraceParams.taskId,
        atraceParams.u.eventWaitParams.eventId,
        atraceParams.u.eventWaitParams.eventAddrLowEightBit,
        atraceParams.tid);
    COND_RETURN_WARN(ret < 0, RT_ERROR_SEC_HANDLE, "Snprintf_s for generating runtime atrace msg abnormally.");
    TrySubmitAtraceLog(atraceParams.handle, &(buff[0]), PER_ATRACE_LOG_LEN);
    return RT_ERROR_NONE;
}

rtError_t AtraceSubmitForNotifyWait(const AtraceParams &atraceParams)
{
    char buff[PER_ATRACE_LOG_LEN] = {};
    const NotifyWaitParams *notifyWait = &(atraceParams.u.notifyWaitParams);
    const int32_t ret = snprintf_s(&(buff[0]),
        PER_ATRACE_LOG_LEN,
        PER_ATRACE_LOG_LEN - 1,
        "notifyWait:devId=%u, stmId=%u, "
        "tskId=%hu, notifyId=%u, timeout=%us, addr=0x%lx, tid=%d",
        atraceParams.deviceId,
        atraceParams.streamId,
        atraceParams.taskId,
        notifyWait->notifyId,
        notifyWait->timeout,
        notifyWait->notifyWaitAddrLowEightBit,
        atraceParams.tid);
    COND_RETURN_WARN(ret < 0, RT_ERROR_SEC_HANDLE, "Snprintf_s for generating runtime atrace msg abnormally.");
    TrySubmitAtraceLog(atraceParams.handle, &(buff[0]), PER_ATRACE_LOG_LEN);
    return RT_ERROR_NONE;
}

rtError_t AtraceSubmitForNotifyRecord(const AtraceParams &atraceParams)
{
    char buff[PER_ATRACE_LOG_LEN] = {};
    const NotifyRecordParams *notifyRecord = &(atraceParams.u.notifyRecordParams);
    const int32_t ret = snprintf_s(&(buff[0]), PER_ATRACE_LOG_LEN, PER_ATRACE_LOG_LEN - 1, "notifyRecord:devId=%u,"
        "stmId=%u,tskId=%hu,notifyId=%u,isIpc=%hu,remoteDev=%u,addr=0x%lx,tid=%d", atraceParams.deviceId,
        atraceParams.streamId, atraceParams.taskId, notifyRecord->notifyId, notifyRecord->isIpc,
        notifyRecord->remoteDevice, notifyRecord->notifyWaitAddrLowEightBit, atraceParams.tid);
    COND_RETURN_WARN(ret < 0, RT_ERROR_SEC_HANDLE, "Snprintf_s for generating runtime atrace msg abnormally.");
    TrySubmitAtraceLog(atraceParams.handle, &(buff[0]), PER_ATRACE_LOG_LEN);
    return RT_ERROR_NONE;
}

void AtraceSubmitLog(AtraceSubmitType type, const AtraceParams &atraceParams)
{
    if (atraceParams.handle < 0) {
        return;
    }
    if (type >= TYPE_RESERVED) {
        return;
    }
    (void)g_atraceSubmitFunc[type](atraceParams);
}

void TrySaveAtraceLogs(TraEventHandle handle)
{
    if (&AtraceEventReportSync == nullptr) {
        return;
    }
    const TraStatus ret = AtraceEventReportSync(handle);
    if (ret < 0) {
        RT_LOG(RT_LOG_WARNING, "Can't save atrace logs to file, errorCode=%d", ret);
    } else {
        RT_LOG(RT_LOG_INFO, "Save atrace logs to file successfully!");
    }
}

void RegAtraceInfoInit(void)
{
    g_atraceSubmitFunc[TYPE_CQ_REPORT] = AtraceSubmitForLogicCqRecord;
    g_atraceSubmitFunc[TYPE_TASK_RECYCLE] = AtraceSubmitForRecycleTask;
    g_atraceSubmitFunc[TYPE_EVENT_WAIT] = AtraceSubmitForEventWait;
    g_atraceSubmitFunc[TYPE_EVENT_RECORD] = AtraceSubmitForEventRecord;
    g_atraceSubmitFunc[TYPE_EVENT_RESET] = AtraceSubmitForEventReset;
    g_atraceSubmitFunc[TYPE_NOTIFY_WAIT] = AtraceSubmitForNotifyWait;
    g_atraceSubmitFunc[TYPE_NOTIFY_RECORD] = AtraceSubmitForNotifyRecord;

    recycleTypeStr[TYPE_SENDINGWAIT] = std::string("SendWait");
    recycleTypeStr[TYPE_TRYRECYCLETASK] = std::string("TryReclyTask");
}

}
}
