/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime.hpp"
#include "stars_david.hpp"
#include "memory_task.h"
#include "stream_david.hpp"
#include "stars_cond_isa_helper.hpp"
#include "event.hpp"
#include "notify.hpp"
#include "count_notify.hpp"
#include "thread_local_container.hpp"
#include "task_execute_time.h"
#include "task_res_da.hpp"
#include "fusion_task.h"
#include "fusion_c.hpp"
#include "aic_aiv_sqe_common.hpp"
#include "ccu_sqe.hpp"
#include "device/device_error_proc.hpp"
#include "davinci_multiple_task.h"

namespace cce {
namespace runtime {
static PfnTaskToDavidSqe g_toDavidSqeFunc[TS_TASK_TYPE_RESERVED] = {};

constexpr uint8_t TASK_SQE_NUM_ONE = 1U;
constexpr uint8_t TASK_SQE_NUM_TWO = 2U;
constexpr uint8_t TASK_NUM_FOR_HEAD_UPDATE = 64U;

PfnTaskToDavidSqe *GetDavidSqeFuncAddr()
{
    return g_toDavidSqeFunc;
}

rtError_t RegDavidSqeFunc(tsTaskType_t taskType, PfnTaskToDavidSqe func)
{
    if (taskType >= TS_TASK_TYPE_RESERVED) {
        RT_LOG(RT_LOG_ERROR, "task type is invalid: %d", taskType);
        return RT_ERROR_TASK_BASE;
    }
    g_toDavidSqeFunc[taskType] = func;
    return RT_ERROR_NONE;
}

static uint32_t GetSendSqeNumForFusionKernelTask(const TaskInfo *const taskInfo)
{
    return taskInfo->u.fusionKernelTask.sqeLen;
}

uint32_t GetSendDavidSqeNum(const TaskInfo* const taskInfo)
{
    const tsTaskType_t type = taskInfo->type;
    if (type == TS_TASK_TYPE_MULTIPLE_TASK) {
        return GetSendSqeNumForDavinciMultipleTask(taskInfo);
    } else if (type == TS_TASK_TYPE_DIRECT_SEND) {
        return GetSendSqeNumForDirectWqeTask(taskInfo);
    } else if (type == TS_TASK_TYPE_MEMCPY) {
        return GetSendSqeNumForAsyncDmaTask(taskInfo);
    } else if (type == TS_TASK_TYPE_CCU_LAUNCH) {
        return TASK_SQE_NUM_TWO;
    } else if (type == TS_TASK_TYPE_FUSION_KERNEL) {
        return GetSendSqeNumForFusionKernelTask(taskInfo);
    } else if ((type == TS_TASK_TYPE_IPC_WAIT) || (type == TS_TASK_TYPE_MEM_WAIT_VALUE) ||
        (type == TS_TASK_TYPE_CAPTURE_WAIT)) {
        return MEM_WAIT_V2_SQE_NUM;
    } else {
        return TASK_SQE_NUM_ONE;
    }
}

uint8_t GetHeadUpdateFlag(uint64_t allocTimes)
{
    return (allocTimes % TASK_NUM_FOR_HEAD_UPDATE) == 0U ? 1U : 0U;
}

rtDavidSqe_t *GetSqPosAddr(uint64_t sqBaseAddr, uint32_t pos)
{
    uint32_t temp = pos;
    const uint32_t rtsqDepth = Runtime::Instance()->GetCurChipProperties().rtsqDepth;
    if (temp >= rtsqDepth) {
        temp -= rtsqDepth;
    }
    return RtValueToPtr<rtDavidSqe_t *>(sqBaseAddr + (temp << SHIFT_SIX_SIZE));
}

void ToConstructDavidSqe(TaskInfo *taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    taskInfo->bindFlag = taskInfo->stream->GetBindFlag();
    if (g_toDavidSqeFunc[taskInfo->type] != nullptr) {
        g_toDavidSqeFunc[taskInfo->type](taskInfo, davidSqe, sqBaseAddr);
    }

    if (Runtime::Instance()->GetConnectUbFlag()) {
        uint64_t allocTimes =
            (RtPtrToPtr<TaskResManageDavid *>(taskInfo->stream->taskResMang_))->GetAllocNum();
        davidSqe->phSqe.header.headUpdate = GetHeadUpdateFlag(allocTimes);
    }

    // set expect cqeNum after sqe construction which will be checked before task recycle
    if (taskInfo->type == TS_TASK_TYPE_MULTIPLE_TASK) {
        const uint32_t sendSqeNum = GetSendDavidSqeNum(taskInfo);
        taskInfo->pkgStat[RT_PACKAGE_TYPE_TASK_REPORT].expectPackage = static_cast<uint16_t>(sendSqeNum);
    }
}

// fusion ccu not use these following func
void ConstructDavidSqeForWordOne(const TaskInfo *const taskInfo, rtDavidSqe_t * const sqe)
{
    sqe->commonSqe.sqeHeader.rtStreamId = static_cast<uint16_t>(taskInfo->taskSn & 0xFFFFULL);
    sqe->commonSqe.sqeHeader.taskId = static_cast<uint16_t>((taskInfo->taskSn & 0xFFFF0000ULL) >> UINT16_BIT_NUM);
}

void ConstructDavidSqeForHeadCommon(const TaskInfo *taskInfo, rtDavidSqe_t * const sqe)
{
    Stream * const stream = taskInfo->stream;
    // Performance-sensitive paths, internally controllable addresses
    // and security functions are not required for evaluation.
    (void)memset_s(sqe, sizeof(rtDavidSqe_t), 0, sizeof(rtDavidSqe_t));
    sqe->commonSqe.sqeHeader.wrCqe = stream->GetStarsWrCqeFlag();
    sqe->commonSqe.sqeHeader.rtStreamId = static_cast<uint16_t>(taskInfo->taskSn & 0xFFFFULL);
    sqe->commonSqe.sqeHeader.taskId = static_cast<uint16_t>((taskInfo->taskSn & 0xFFFF0000ULL) >> UINT16_BIT_NUM);
}


void SetStarsResultCommonForDavid(TaskInfo *taskInfo, const rtLogicCqReport_t &logicCq)
{
    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) != 0U) {
        if (logicCq.errorCode != TS_SUCCESS) {
            taskInfo->errorCode = logicCq.errorCode;
        } else {
            static uint32_t errMap[TS_STARS_ERROR_MAX_INDEX] = {
                TS_ERROR_TASK_EXCEPTION,
                TS_ERROR_TASK_BUS_ERROR,
                TS_ERROR_TASK_TIMEOUT,
                TS_ERROR_TASK_SQE_ERROR,
                TS_ERROR_TASK_RES_CONFLICT_ERROR,
                TS_ERROR_TASK_SW_STATUS_ERROR};
            const uint32_t errorIndex =
                static_cast<uint32_t>(BitScan(static_cast<uint64_t>(logicCq.errorType) & RT_STARS_EXIST_ERROR));
            taskInfo->errorCode = errMap[errorIndex];
        }
    }
}

void ConstructDavidSqeBase(TaskInfo *taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe *const sqe = &(davidSqe->phSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    RT_LOG(RT_LOG_WARNING, "No need to construct sqe. task_type=%u, device_id=%u, stream_id=%d, task_id=%hu,"
        " task_sn=%u.", taskInfo->type, taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(),
        taskInfo->id, taskInfo->taskSn);
}

void RegTaskToDavidSqefunc(void)
{
    g_toDavidSqeFunc[TS_TASK_TYPE_REDUCE_ASYNC_V2] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_REMOTE_EVENT_WAIT] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_MAINTENANCE] = &ConstructDavidSqeForMaintenanceTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_FUSION_ISSUE] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_PROFILING_ENABLE] = &ConstructDavidSqeForProfilingEnableTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_PROFILING_DISABLE] = &ConstructDavidSqeForProfilingDisableTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_ONLINEPROF_START] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_ONLINEPROF_STOP] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_ADCPROF] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_PCTRACE_ENABLE] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_MODEL_MAINTAINCE] = &ConstructDavidSqeForModelMaintainceTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_MODEL_EXECUTE] = &ConstructDavidSqeForModelExecuteTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_DEBUG_UNREGISTER_FOR_STREAM] = &ConstructDavidSqeForDebugUnRegisterForStreamTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_MODEL_END_GRAPH] = &ConstructDavidSqeForAddEndGraphTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_MODEL_EXIT_GRAPH] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_MODEL_TO_AICPU] = &ConstructDavidSqeForModelToAicpuTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_NOTIFY_RECORD] = &ConstructDavidSqeForNotifyRecordTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_NOTIFY_WAIT] = &ConstructDavidSqeForNotifyWaitTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_FFTS_PLUS] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_NPU_GET_FLOAT_STATUS] = &ConstructDavidSqeForNpuGetFloatStaTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_NPU_CLEAR_FLOAT_STATUS] = &ConstructDavidSqeForNpuClrFloatStaTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_DEVICE_RINGBUFFER_CONTROL] = &ConstructDavidSqeForRingBufferMaintainTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_BARRIER] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_RDMA_SEND] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_RDMA_DB_SEND] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_PROFILER_TRACE] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_PROFILER_TRACE_EX] = &ConstructDavidSqeForProfilerTraceExTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_FUSIONDUMP_ADDR_SET] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_DATADUMP_LOADINFO] = &ConstructDavidSqeForDataDumpLoadInfoTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_DEBUG_REGISTER] = &ConstructDavidSqeForDebugRegisterTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_DEBUG_UNREGISTER] = &ConstructDavidSqeForDebugUnRegisterTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_TASK_TIMEOUT_SET] = &ConstructDavidSqeForTimeoutSetTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_GET_DEVICE_MSG] = &ConstructDavidSqeForGetDevMsgTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_DEBUG_REGISTER_FOR_STREAM] = &ConstructDavidSqeForDebugRegisterForStreamTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_ALLOC_DSA_ADDR] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_GET_STARS_VERSION] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_CCU_LAUNCH] = &ConstructDavidSqeForCcuLaunchTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_FUSION_KERNEL] = &ConstructDavidSqeForFusionKernelTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_UB_DB_SEND] = &ConstructDavidSqeForUbDbSendTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_DIRECT_SEND] = &ConstructDavidSqeForUbDirectSendTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_MODEL_TASK_UPDATE] = &ConstructDavidSqeForModelUpdateTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_AICPU_INFO_LOAD] = &ConstructDavidSqeForAicpuInfoLoadTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_NOP] = &ConstructDavidSqeForNopTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_DAVID_EVENT_RECORD] = &ConstructDavidSqeForEventRecordTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_DAVID_EVENT_WAIT] = &ConstructDavidSqeForEventWaitTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_DAVID_EVENT_RESET] = &ConstructDavidSqeForEventResetTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_TSFW_AICPU_MSG_VERSION] = &ConstructDavidSqeForAicpuMsgVersionTask;
}

}  // namespace runtime
}  // namespace cce
