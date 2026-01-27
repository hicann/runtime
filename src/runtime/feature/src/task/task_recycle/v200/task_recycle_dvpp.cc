/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stream_david.hpp"
#include "stream_sqcq_manage.hpp"
#include "runtime.hpp"
#include "thread_local_container.hpp"
#include "fwk_adpt_struct.h"
#include "rt_stars_define.h"
#include "context.hpp"
#include "event.hpp"
#include "notify.hpp"
#include "count_notify.hpp"
#include "device/device_error_proc.hpp"
#include "aicpu_sched/common/aicpu_task_struct.h"
#include "context.hpp"
#include "tsch_defines.h"
#include "profiler.hpp"
#include "stars.hpp"
#include "stars_david.hpp"
#include "hwts.hpp"
#include "device.hpp"
#include "davinci_kernel_task.h"
#include "event_task.h"
#include "memory_task.h"
#include "task_recycle.hpp"
#include "engine.hpp"
#include "task_res_da.hpp"

namespace cce {
namespace runtime {

// =================================================== static 函数区 ======================================== //

static inline void InvokeCallBack(const Device * const dev, const rtLogicCqReport_t &report,
    rtDvppGrpCallback callBackFunc, uint32_t streamId)
{
    uint32_t userDeviceId = 0U;
    const rtError_t error = Runtime::Instance()->GetUserDevIdByDeviceId(dev->Id_(), &userDeviceId);
    COND_RETURN_VOID((error != RT_ERROR_NONE), "Convert drv devId:%u is err:%#x",
        dev->Id_(), static_cast<uint32_t>(error));
    rtDvppGrpRptInfo_t dvppReport = {};
    dvppReport.deviceId = userDeviceId;
    dvppReport.streamId = streamId;
    dvppReport.taskId = (static_cast<uint32_t>(report.taskId) << UINT16_BIT_NUM) | report.streamId;
    dvppReport.sqeType = report.sqeType;
    dvppReport.cqeErrorCode = GetStarsDefinedErrCode(report.errorType);
    dvppReport.accErrorCode = report.errorCode;
    callBackFunc(&dvppReport);
    RT_LOG(RT_LOG_DEBUG, "dvppReport, report_stream_id=%u, report_task_id=%u, sqe_type=%hhu, cqeCode=%hhu, accErrorCode=%u.",
        dvppReport.streamId, dvppReport.taskId, dvppReport.sqeType, dvppReport.cqeErrorCode,
        dvppReport.accErrorCode);
}

static inline void InvokeCallBack(const Device * const dev, const rtLogicCqReport_t &report,
    rtDvppGrpCallback callBackFunc, uint8_t sqeType, uint8_t cqeErrorCode, uint32_t streamId)
{
    uint32_t userDeviceId = 0U;
    const rtError_t error = Runtime::Instance()->GetUserDevIdByDeviceId(dev->Id_(), &userDeviceId);
    COND_RETURN_VOID((error != RT_ERROR_NONE), "Convert drv devId:%u is err:%#x",
        dev->Id_(), static_cast<uint32_t>(error));
    rtDvppGrpRptInfo_t dvppReport = {};
    dvppReport.deviceId = userDeviceId;
    dvppReport.streamId = streamId;
    dvppReport.taskId = (static_cast<uint32_t>(report.taskId) << UINT16_BIT_NUM) | report.streamId;
    dvppReport.sqeType = sqeType;
    dvppReport.cqeErrorCode = cqeErrorCode;
    dvppReport.accErrorCode = report.errorCode;
    callBackFunc(&dvppReport);
    RT_LOG(RT_LOG_DEBUG, "dvppReport, report_stream_id=%u, report_task_id=%u, sqe_type=%hhu, cqeCode=%hhu, accErrorCode=%u.",
        dvppReport.streamId, dvppReport.taskId, dvppReport.sqeType, dvppReport.cqeErrorCode,
        dvppReport.accErrorCode);
}


static rtError_t ReportLogicCq(Device * const dev, uint32_t streamId, rtLogicCqReport_t &report, rtDvppGrpCallback callBackFunc)
{
    TaskInfo *reportTask = GetTaskInfo(dev, streamId, static_cast<uint32_t>(report.sqHead));
    if (unlikely(reportTask == nullptr)) {
        RT_LOG(RT_LOG_WARNING, "GetTask error, device_id=%u, stream_id=%hu, task_id=%hu.",
            dev->Id_(), streamId, report.sqHead);
        InvokeCallBack(dev, report, callBackFunc, streamId);
        ProcCqReportException(dev, report, nullptr, streamId);
        return RT_ERROR_NONE;
    }

    const tsTaskType_t taskType = reportTask->type;
    RT_LOG(RT_LOG_DEBUG, "ReportLogicCq get taskType=%u.", taskType);
    if ((taskType == TS_TASK_TYPE_MULTIPLE_TASK) && (GetSendDavidSqeNum(reportTask) > 1U)) {
        if (!CompleteProcMultipleTaskReport(reportTask, report)) {
            RT_LOG(RT_LOG_INFO, "MultipleTask not CompleteProc sqeType=%u, streamId=%u, taskId=%u.",
                report.sqeType, streamId, report.sqHead);
            return RT_ERROR_STREAM_SYNC_TIMEOUT;
        }
        InvokeCallBack(dev, report, callBackFunc, static_cast<uint8_t>(RT_STARS_SQE_TYPE_VIR_TYPE),
            GetStarsDefinedErrCode(reportTask->u.davinciMultiTaskInfo.errorType), streamId);
    } else {
        // check error and retry
        if (ProcReportIsDvppErrorAndRetry(report, reportTask)) {
            RT_LOG(RT_LOG_WARNING, "ProcReportIsDvppErrorAndRetry is true.");
            return RT_ERROR_STREAM_SYNC_TIMEOUT;
        }
        InvokeCallBack(dev, report, callBackFunc, streamId);
    }

    ProcLogicCqReport(dev, report, reportTask);
    (void)StarsResumeRtsq(&report, reportTask);
    reportTask->stream->StreamLock();
    (void)RecycleTaskBySqHead(reportTask->stream);
    reportTask->stream->StreamUnLock();

    return RT_ERROR_NONE;
}
// =================================================== static 函数区 ======================================== //

// ================================================== 对外出口区 ======================================== //
bool ProcReportIsDvppErrorAndRetry(const rtLogicCqReport_t& report, TaskInfo *const reportTask)
{
    if (!IsNeedRetryTask(static_cast<uint16_t>(report.sqeType))) {
        return false;
    }

    const uint8_t errorCode = GetStarsDefinedErrCode(report.errorType);
    if (errorCode == 0U) {
        return false;
    }

    // sqe error
    if ((errorCode & static_cast<uint8_t>(RT_STARS_CQE_ERR_TYPE_SQE_ERROR)) != 0U) {
        return false;
    }

    if (unlikely(reportTask == nullptr)) {
        return false;
    }

    if (reportTask->u.starsCommTask.errorTimes != 0U) {
        RT_LOG(RT_LOG_ERROR, "Dvpp task error, stream_id=%hu, task_id=%hu, sqeType=%hhu.",
            reportTask->stream->Id_(), report.sqHead, report.sqeType);
        return false;
    }

    reportTask->u.starsCommTask.errorTimes++;
    RT_LOG(RT_LOG_WARNING, "Dvpp task retry, stream_id=%hu, task_id=%hu, sqeType=%hhu.",
        reportTask->stream->Id_(), report.sqHead, report.sqeType);
    return true;
}

rtError_t DvppWaitGroup(const Device * const dev, const DvppGrp *grp, rtDvppGrpCallback callBackFunc,
    const int32_t timeout)
{
    rtLogicCqReport_t report = {};
    Driver * const devDrv = dev->Driver_();
    uint32_t cnt = 0U;
    const uint32_t logicCqId = grp->getLogicCqId();

    LogicCqWaitInfo waitInfo = {};
    waitInfo.devId = dev->Id_();
    waitInfo.tsId = dev->DevGetTsId();
    waitInfo.cqId = logicCqId;
    waitInfo.isFastCq = false;
    waitInfo.timeout = timeout;
    waitInfo.streamId = UINT32_MAX;
    waitInfo.taskId = UINT32_MAX;

    rtError_t error = devDrv->LogicCqReportV2(waitInfo, RtPtrToPtr<uint8_t *, rtLogicCqReport_t *>(&report), 1U, cnt);
    RT_LOG(RT_LOG_DEBUG, "Logic cq=%u, timeout=%dms, ret=%#x, cnt=%u.", logicCqId, timeout, error, cnt);

    if (error != RT_ERROR_NONE) {
        return error;
    }

    if (cnt == 0U) {
        return RT_ERROR_STREAM_SYNC_TIMEOUT;
    }

    uint32_t streamId = 0U;
    error = dev->GetStreamSqCqManage()->GetStreamIdBySqId(report.sqId, streamId);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "get stream_id by sq_id failed, sq_id=%u, retCode=%#x.",
        report.sqId, error);
    RT_LOG(RT_LOG_DEBUG, "Get report: logic_cq=%u, sq_id=%u, stream_id=%hu, task_id=%u, code=%#x, "
        "type=%hhu, sqe_type=%hhu.", logicCqId, report.sqId, streamId, report.sqHead, report.errorCode,
        report.errorType, report.sqeType);
    return ReportLogicCq(RtPtrToUnConstPtr<Device * const>(dev), streamId, report, callBackFunc);
}
// ================================================== 对外出口区 ======================================== //

}  // namespace runtime
}  // namespace cce