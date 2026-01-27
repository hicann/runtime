/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "hwts_engine.hpp"
#include <ctime>
#include "base.hpp"
#include "api.hpp"
#include "context.hpp"
#include "task_fail_callback_manager.hpp"
#include "engine.hpp"
#include "runtime.hpp"
#include "profiler.hpp"
#include "securec.h"
#include "stream.hpp"
#include "task.hpp"
#include "task_info.hpp"
#include "task_res.hpp"
#include "error_message_manage.hpp"
#include "errcode_manage.hpp"
#include "npu_driver.hpp"
#include "notify.hpp"
#include "error_code.h"

namespace cce {
namespace runtime {
void HwtsEngine::ProcessOverFlowReport(const rtTaskReport_t * const errorReport, const uint32_t tsRetCode) const
{
    if (errorReport == nullptr) {
        RT_LOG(RT_LOG_WARNING, "errorReport is null, tsRetCode=%u.", tsRetCode);
        return;
    }
    const uint16_t streamId = static_cast<uint16_t>((static_cast<uint32_t>(errorReport->streamID) |
        (static_cast<uint32_t>(errorReport->streamIDEx) << static_cast<uint32_t>(RT_STREAM_ID_OFFSET))));
    RT_LOG(RT_LOG_INFO, "sq_id=%hu, stream_id=%hu, task_id=%hu, sq_head=%hu.",
           errorReport->SQ_id, streamId, errorReport->taskID, errorReport->SQ_head);

    TaskFactory * const taskGenerator = device_->GetTaskFactory();
    COND_RETURN_VOID(taskGenerator == nullptr, "task factory is nullptr.");

    TaskInfo * const reportTask = taskGenerator->GetTask(static_cast<int32_t>(streamId), errorReport->taskID);
    if (reportTask == nullptr) {
        RT_LOG(RT_LOG_WARNING, "can't find task from factory.");
        ProcessNullTaskOverFlowReport(static_cast<uint32_t>(streamId),
                                      static_cast<uint32_t>(errorReport->taskID), tsRetCode);
        return;
    }

    const tsTaskType_t type = reportTask->type;
    if ((type == TS_TASK_TYPE_KERNEL_AICORE) || (type == TS_TASK_TYPE_KERNEL_AICPU) ||
        (type == TS_TASK_TYPE_KERNEL_AIVEC) || (type == TS_TASK_TYPE_MEMCPY)) {
        reportTask->errorCode = tsRetCode;
        TaskFailCallBack(static_cast<uint32_t>(reportTask->stream->Id_()),
                         static_cast<uint32_t>(reportTask->id), reportTask->tid,
                         tsRetCode, reportTask->stream->Device_());
    }
}

void HwtsEngine::ProcessNullTaskOverFlowReport(const uint32_t streamId,
    const uint32_t taskId, const uint32_t retCode) const
{
    rtError_t rtErrCode = RT_ERROR_NONE;
    rtExceptionInfo_t exceptionInfo;
    const char_t *const retDes = GetTsErrCodeMap(retCode, &rtErrCode);

    TaskInfo *workTask = device_->GetTaskFactory()->GetTask(static_cast<int32_t>(streamId),
                                                            static_cast<uint16_t>(taskId));
    GetExceptionArgs(workTask, &(exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs));
    exceptionInfo.retcode = static_cast<uint32_t>(RT_TRANS_EXT_ERRCODE(rtErrCode));
    exceptionInfo.taskid = CovertToFlipTaskId(workTask, taskId);
    exceptionInfo.tid = 0U;
    exceptionInfo.streamid = streamId;
    exceptionInfo.deviceid = device_->Id_();

    RT_LOG(RT_LOG_WARNING, "retCode=0x%x,[%s], errorTaskId=%u, errorStreamId=%u.",
        rtErrCode, retDes, exceptionInfo.taskid, exceptionInfo.streamid);

    TaskFailCallBackNotify(&exceptionInfo);
    if (exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName != nullptr) {
        delete[] exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName;
    }
}

void HwtsEngine::ReportReceive(const rtTaskReport_t * const report, TaskInfo * const reportTask)
{
    TIMESTAMP_NAME(__func__);
    uint8_t package[M_PROF_PACKAGE_LEN] = {0U};
    constexpr size_t pktLen  = static_cast<size_t>(M_PROF_PACKAGE_LEN);
    if (likely(rebuilder_.PackageReportReceive(report, package, pktLen, reportTask))) {
        reportTask->pkgStat[report->packageType].receivePackage++;
        if (likely(report->packageType == static_cast<uint16_t>(RT_PACKAGE_TYPE_TASK_REPORT))) {
            SetResult(reportTask, RtPtrToPtr<const uint8_t *>(package),
                      reportTask->pkgStat[report->packageType].packageReportNum);
            ShowTaskResult(reportTask, device_->Id_());
            const uint32_t errInfo = (*(RtPtrToPtr<uint32_t *>(package))) & RT_GET_ERR_CODE;
            ReportExceptProc(reportTask, errInfo, *(RtPtrToPtr<uint32_t *>(package)));
        }
    }
}

Kernel* HwtsEngine::SearchErrorKernel(const uint16_t devId, const Program* const prog) const
{
    uint64_t *pc_arr = nullptr;
    uint32_t cnt = 0U;
    device_->GetErrorPcArr(devId, &pc_arr, &cnt);
    for (uint32_t i = 0U; i < cnt; i++) {
        if (pc_arr[i] == 0ULL) {
            continue;
        }
        RT_LOG(RT_LOG_INFO, "DevId=%u, the error pc is 0x%llx.", devId, pc_arr[i]);
        Kernel* krnl = prog->SearchKernelByPcAddr(pc_arr[i]);
        if (krnl != nullptr) return krnl;
    }
    return nullptr;
}

void HwtsEngine::ReportExceptProc(const TaskInfo * const reportTask, const uint32_t errCode, const uint32_t errorDesc)
{
    if (static_cast<int32_t>(errCode) == RT_ERROR_NONE) {
        return;
    }

    const tsTaskType_t taskType = reportTask->type;
    if (taskType != TS_TASK_TYPE_EVENT_RECORD) {
        const int32_t streamId = reportTask->stream->Id_();
        const uint64_t failureMode = reportTask->stream->GetFailureMode();
        if ((errCode != static_cast<uint32_t>(TS_ERROR_END_OF_SEQUENCE)) &&
            (errCode != static_cast<uint32_t>(TS_MODEL_ABORT_NORMAL)) &&
            (errCode != static_cast<uint32_t>(TS_ERROR_AICORE_OVERFLOW)) &&
            (errCode != static_cast<uint32_t>(TS_ERROR_AIVEC_OVERFLOW))) {
            const uint32_t faultStreamId = (errorDesc & 0x0000FFFFU);     // stream Id for model execute failed
            const uint32_t faultTaskId = (errorDesc & 0xFFFF0000U) >> 16U; // task id for model execute failed
            TaskInfo *exceptionTask = nullptr;
            if (Runtime::Instance()->GetDisableThread()) {
                exceptionTask = device_->GetTaskFactory()->GetTask(static_cast<int32_t>(faultStreamId),
                static_cast<uint16_t>(faultTaskId));
            }
            if ((taskType == TS_TASK_TYPE_MODEL_EXECUTE) && unlikely(exceptionTask != nullptr)) {
                RT_LOG(RT_LOG_ERROR, "Real task exception! device_id=%u, stream_id=%u, task_id=%u, task_type=%u (%s)",
                    static_cast<uint32_t>(device_->Id_()), faultStreamId, faultTaskId, exceptionTask->type,
                    exceptionTask->typeName);
            }
            if ((taskType == TS_TASK_TYPE_KERNEL_AICORE) || (taskType == TS_TASK_TYPE_KERNEL_AIVEC)) {
                std::string kernelNameStr = "";
                AicTaskInfo *aicTaskInfo = &(const_cast<TaskInfo *>(reportTask)->u.aicTaskInfo);
                if ((aicTaskInfo != nullptr) && (aicTaskInfo->kernel != nullptr)) {
                    kernelNameStr = aicTaskInfo->kernel->Name_();
                }
                kernelNameStr = kernelNameStr.empty() ? ("none") : kernelNameStr;
                RT_LOG(RT_LOG_ERROR, "Task exception! device_id=%u, stream_id=%d, task_id=%hu, type=%d(%s), "
                    "kernel_name=%s , failure_mode=%llu, retCode=%#x, [%s]",
                    device_->Id_(), streamId, reportTask->id, taskType, reportTask->typeName,
                    kernelNameStr.c_str(), failureMode, (errCode & 0xFFFU), GetTsErrCodeDesc(errCode));
            } else {
                RT_LOG(RT_LOG_ERROR, "Task exception! device_id=%u, stream_id=%d, task_id=%hu, type=%d(%s), "
                    "failure_mode =%llu, retCode=%#x, [%s]",
                    device_->Id_(), streamId, reportTask->id, taskType, reportTask->typeName,
                    failureMode, (errCode & 0xFFFU), GetTsErrCodeDesc(errCode));
            }
            (void)device_->PrintStreamTimeoutSnapshotInfo();
            if (Runtime::Instance()->isSetVisibleDev) {
                RT_LOG(RT_LOG_EVENT, "ASCEND_RT_VISIBLE_DEVICES:%s", Runtime::Instance()->inputDeviceStr);
            }

            (void)device_->ProcDeviceErrorInfo();

            reportTask->stream->SetErrCode(errCode);
            reportTask->stream->EnterFailureAbort();

            // Set error device status
            if (device_->GetHasTaskError()) {
                Runtime::Instance()->SetWatchDogDevStatus(device_, RT_DEVICE_STATUS_ABNORMAL);
            } else {
                // for notify wait time out, ts doesn't write data to ringbuf, so watchDog does not take effect
                TrySaveAtraceLogs(device_->GetAtraceEventHandle());
            }
            if (exceptionTask != nullptr &&
                (exceptionTask->type == TS_TASK_TYPE_KERNEL_AICORE ||
                    exceptionTask->type == TS_TASK_TYPE_KERNEL_AIVEC) &&
                exceptionTask->u.aicTaskInfo.kernel == nullptr) {
                AicTaskInfo *aicTask = &exceptionTask->u.aicTaskInfo;
                aicTask->kernel = aicTask->progHandle == nullptr ? nullptr :
                    SearchErrorKernel(device_->Id_(), aicTask->progHandle);
            }
        }
        if (Runtime::Instance()->excptCallBack_ != nullptr) {
            Runtime::Instance()->excptCallBack_(RT_EXCEPTION_TASK_FAILURE);
        } else {
            RT_LOG(RT_LOG_INFO, "excptCallBack_ is null.");
        }
    }
}
}  // namespace runtime
}  // namespace cce