/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "base.hpp"
#include "david_sqe_adapter.hpp"
#include "stars_david.hpp"
#include "task_scheduler_error.h"
#include "task_info.hpp"
#include "davinci_multiple_task.h"
#include "fusion_task.h"
#include "memory_task.h"

namespace cce {
namespace runtime {

namespace {
constexpr uint8_t TASK_SQE_NUM_ONE = 1U;
constexpr uint8_t TASK_SQE_NUM_TWO = 2U;

uint32_t GetSendSqeNumForFusionKernelTask(const TaskInfo* const taskInfo)
{
    return taskInfo->u.fusionKernelTask.sqeLen;
}
} // namespace

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
    } else if (
        (type == TS_TASK_TYPE_IPC_WAIT) || (type == TS_TASK_TYPE_MEM_WAIT_VALUE) ||
        (type == TS_TASK_TYPE_CAPTURE_WAIT) || (type == TS_TASK_TYPE_CAPTURE_WAIT_EXTERNAL)) {
        return MEM_WAIT_V2_SQE_NUM;
    } else if (type == TS_TASK_TYPE_CAPTURE_CONDITION) {
        return taskInfo->sqeNum;
    } else {
        return TASK_SQE_NUM_ONE;
    }
}

uint32_t GetSendSqeNum(TaskInfo* const taskInfo) { return GetSendDavidSqeNum(taskInfo); }

void SetExpectedTaskReportNum(TaskInfo* const taskInfo, const uint32_t sendSqeNum)
{
    if (taskInfo->type == TS_TASK_TYPE_MULTIPLE_TASK) {
        taskInfo->pkgStat[RT_PACKAGE_TYPE_TASK_REPORT].expectPackage = static_cast<uint16_t>(sendSqeNum);
    }
}

uint8_t GetHeadUpdateFlag(const uint64_t allocTimes) { return GetDavidHeadUpdateFlag(allocTimes); }

rtDavidSqe_t* GetSqPosAddr(const uint64_t sqBaseAddr, const uint32_t pos)
{
    uint32_t sqPos = pos;
    const uint32_t rtsqDepth = Runtime::Instance()->GetCurChipProperties().rtsqDepth;
    if (sqPos >= rtsqDepth) {
        sqPos -= rtsqDepth;
    }
    return RtValueToPtr<rtDavidSqe_t*>(GetSqeAddr(sqBaseAddr, sqPos));
}

uint32_t GetStarsV2VectorErrorCode(const rtCqReport_t& logicCq)
{
    const uint32_t errorIndex = static_cast<uint32_t>(BitScan(static_cast<uint64_t>(logicCq.errorType)));
    const uint32_t vectorErrMap[TS_STARS_ERROR_MAX_INDEX] = {TS_ERROR_VECTOR_CORE_EXCEPTION, TS_ERROR_TASK_BUS_ERROR,
                                                             TS_ERROR_VECTOR_CORE_TIMEOUT,   TS_ERROR_TASK_SQE_ERROR,
                                                             TS_ERROR_VECTOR_CORE_EXCEPTION, logicCq.errorCode};
    return vectorErrMap[errorIndex];
}

uint32_t GetStarsV2AicpuErrorCode(const rtCqReport_t& logicCq)
{
    const uint32_t errorIndex = static_cast<uint32_t>(BitScan(static_cast<uint64_t>(logicCq.errorType)));
    const uint32_t aicpuErrMap[TS_STARS_ERROR_MAX_INDEX] = {TS_ERROR_AICPU_EXCEPTION, TS_ERROR_TASK_BUS_ERROR,
                                                            TS_ERROR_AICPU_TIMEOUT,   TS_ERROR_TASK_SQE_ERROR,
                                                            TS_ERROR_AICPU_EXCEPTION, logicCq.errorCode};
    return aicpuErrMap[errorIndex];
}

uint32_t GetStarsV2AicoreErrorCode(const rtCqReport_t& logicCq)
{
    const uint32_t errorIndex = static_cast<uint32_t>(BitScan(static_cast<uint64_t>(logicCq.errorType)));
    const uint32_t aicoreErrMap[TS_STARS_ERROR_MAX_INDEX] = {TS_ERROR_AICORE_EXCEPTION, TS_ERROR_TASK_BUS_ERROR,
                                                             TS_ERROR_AICORE_TIMEOUT,   TS_ERROR_TASK_SQE_ERROR,
                                                             TS_ERROR_AICORE_EXCEPTION, logicCq.errorCode};
    return aicoreErrMap[errorIndex];
}

void SetStarsResultCommonForDavid(TaskInfo* const taskInfo, const rtCqReport_t& logicCq)
{
    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) != 0U) {
        if (logicCq.errorCode != TS_SUCCESS) {
            taskInfo->errorCode = logicCq.errorCode;
        } else {
            static uint32_t errMap[TS_STARS_ERROR_MAX_INDEX] = {
                TS_ERROR_TASK_EXCEPTION, TS_ERROR_TASK_BUS_ERROR,          TS_ERROR_TASK_TIMEOUT,
                TS_ERROR_TASK_SQE_ERROR, TS_ERROR_TASK_RES_CONFLICT_ERROR, TS_ERROR_TASK_SW_STATUS_ERROR};
            const uint32_t errorIndex =
                static_cast<uint32_t>(BitScan(static_cast<uint64_t>(logicCq.errorType) & RT_STARS_EXIST_ERROR));
            taskInfo->errorCode = errMap[errorIndex];
        }
    }
}

void ConstructDavidPlaceHolderSqe(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t* const davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    UNUSED(sqeInfo);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe* const phSqe = &(davidSqe->phSqe);
    phSqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    phSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    RT_LOG(
        RT_LOG_WARNING,
        "No need to construct sqe. task_type=%u, device_id=%u, stream_id=%d, task_id=%hu,"
        " task_sn=%u.",
        taskInfo->type, taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id, taskInfo->taskSn);
}

void ConstructDavidSqeBase(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    ConstructDavidPlaceHolderSqe(taskInfo, sqe, sqeInfo);
    UpdateDavidSqeHeadUpdate(taskInfo, sqe);
}

} // namespace runtime
} // namespace cce
