/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime.hpp"
#include "stars_david.hpp"
#include "stream_david.hpp"
#include "dump_task.h"
#include "task_manager.h"

namespace cce {
namespace runtime {
static void ConstructDavidSqeForDebugUnRegisterForStreamTask(TaskInfo * const taskInfo, void *const sqe,
    const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    UNUSED(sqeInfo);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe *const phSqe = &(davidSqe->phSqe);
    Stream * const stm = taskInfo->stream;
    phSqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    phSqe->header.preP = 1U;
    phSqe->taskType = TS_TASK_TYPE_DEBUG_UNREGISTER_FOR_STREAM;
    phSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    phSqe->u.streamDebugRegisterInfo.streamId = taskInfo->u.debugUnRegisterForStreamTask.streamId;

    PrintDavidSqe(davidSqe, "DebugUnRegisterForStream");
    RT_LOG(RT_LOG_INFO, "DebugUnRegisterForStreamTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u.",
        taskInfo->stream->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn);
}

static void ConstructDavidSqeForDebugRegisterTask(TaskInfo *taskInfo, void *const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    UNUSED(sqeInfo);
    Stream * const stm = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe *const phSqe = &(davidSqe->phSqe);
    phSqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    phSqe->header.preP = 1U;
    phSqe->taskType = TS_TASK_TYPE_DEBUG_REGISTER;
    phSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    phSqe->u.modelDebugRegisterInfo.addr = taskInfo->u.debugRegisterTask.addr;
    phSqe->u.modelDebugRegisterInfo.modelId = taskInfo->u.debugRegisterTask.modelId;
    phSqe->u.modelDebugRegisterInfo.flag = taskInfo->u.debugRegisterTask.flag;

    PrintDavidSqe(davidSqe, "DebugRegister");
    RT_LOG(RT_LOG_INFO, "DebugRegisterTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u.",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn);
}

static void ConstructDavidSqeForDebugUnRegisterTask(TaskInfo *taskInfo, void *const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    UNUSED(sqeInfo);
    Stream * const stm = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const phSqe = &(davidSqe->phSqe);
    phSqe->header.type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    phSqe->header.preP = 1U;
    phSqe->taskType = TS_TASK_TYPE_DEBUG_UNREGISTER;
    phSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    phSqe->u.modelDebugRegisterInfo.modelId = taskInfo->u.debugUnRegisterTask.modelId;

    PrintDavidSqe(davidSqe, "DebugUnRegister");
    RT_LOG(RT_LOG_INFO, "DebugUnRegisterTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, "
        "model_id=%u.", stm->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn,
        taskInfo->u.debugUnRegisterTask.modelId);
}

static void ConstructDavidSqeForDebugRegisterForStreamTask(TaskInfo *taskInfo, void *const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    UNUSED(sqeInfo);
    Stream * const stm = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const phSqe = &(davidSqe->phSqe);
    phSqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    phSqe->header.preP = 1U;
    phSqe->taskType = TS_TASK_TYPE_DEBUG_REGISTER_FOR_STREAM;
    phSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    phSqe->u.streamDebugRegisterInfo.addr = taskInfo->u.debugRegisterForStreamTask.addr;
    phSqe->u.streamDebugRegisterInfo.streamId = taskInfo->u.debugRegisterForStreamTask.streamId;
    phSqe->u.streamDebugRegisterInfo.flag = taskInfo->u.debugRegisterForStreamTask.flag;

    PrintDavidSqe(davidSqe, "DebugRegisterForStream");
    RT_LOG(RT_LOG_INFO, "DebugRegisterForStreamTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u.",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn);
}

static void ConstructDavidSqeForDataDumpLoadInfoTask(TaskInfo *taskInfo, void *const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    UNUSED(sqeInfo);
    Stream * const stm = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const phSqe = &(davidSqe->phSqe);
    phSqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    phSqe->header.preP = 1U;
    phSqe->taskType = TS_TASK_TYPE_DATADUMP_LOADINFO;
    phSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    phSqe->u.dataDumpLoadInfo.dumpinfoPtr = taskInfo->u.dataDumpLoadInfoTask.dumpInfo;
    phSqe->u.dataDumpLoadInfo.length = taskInfo->u.dataDumpLoadInfoTask.length;
    phSqe->u.dataDumpLoadInfo.streamId = static_cast<uint16_t>(stm->Id_());
    phSqe->u.dataDumpLoadInfo.taskId = taskInfo->id;
    phSqe->u.dataDumpLoadInfo.kernelType = taskInfo->u.dataDumpLoadInfoTask.kernelType;
    phSqe->u.dataDumpLoadInfo.reserved = 0U;

    PrintDavidSqe(davidSqe, "DataDumpLoadInfoTask");
    RT_LOG(RT_LOG_INFO, "DataDumpLoadInfoTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u.",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn);
}

static void ConstructDavidSqeForAicpuInfoLoadTask(
    TaskInfo *taskInfo, void *const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    UNUSED(sqeInfo);
    Stream * const stm = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe *const phSqe = &(davidSqe->phSqe);
    phSqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    phSqe->header.preP = 1U;

    phSqe->taskType = TS_TASK_TYPE_AICPU_INFO_LOAD;
    phSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    phSqe->u.aiCpuLoadInfo.aicpufoPtr = taskInfo->u.aicpuInfoLoadTask.aicpuInfo;
    phSqe->u.aiCpuLoadInfo.length = taskInfo->u.aicpuInfoLoadTask.length;
    phSqe->u.aiCpuLoadInfo.streamId = static_cast<uint16_t>(stm->Id_());
    phSqe->u.aiCpuLoadInfo.taskId = taskInfo->id;
    phSqe->u.aiCpuLoadInfo.reserved[0] = 0U;
    phSqe->u.aiCpuLoadInfo.reserved[1] = 0U;

    PrintDavidSqe(davidSqe, "AicpuInfoLoadTask");
    RT_LOG(RT_LOG_INFO, "AicpuInfoLoadTask stream_id:%d task_id:%hu", stm->Id_(), taskInfo->id);
}

static void ConstructDavidSqeForNopTask(TaskInfo * const taskInfo, void *const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    UNUSED(sqeInfo);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe *const phSqe = &(davidSqe->phSqe);
    phSqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    phSqe->taskType = TS_TASK_TYPE_NOP;
    phSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    PrintDavidSqe(davidSqe, "NoOperationTask");
}

static bool DumpTaskRegister()
{
    TaskFuncSingle fusionDumpAddrSetFuncs = {
        .toCommandFunc = &ToCommandBodyForFusionDumpAddrSetTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle dataDumpLoadInfoFuncs = {
        .toCommandFunc = &ToCommandBodyForDataDumpLoadInfoTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultForDataDumpLoadInfoTask,
    };
    TaskFuncSingle debugRegisterFuncs = {
        .toCommandFunc = &ToCommandBodyForDebugRegisterTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle debugUnRegisterFuncs = {
        .toCommandFunc = &ToCommandBodyForDebugUnRegisterTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle debugRegisterForStreamFuncs = {
        .toCommandFunc = &ToCommandBodyForDebugRegisterForStreamTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle debugUnRegisterForStreamFuncs = {
        .toCommandFunc = &ToCmdBodyForDebugUnRegisterForStreamTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle aicpuInfoLoadFuncs = {
        .toCommandFunc = &ToCommandBodyForAicpuInfoLoadTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultForAicpuInfoLoadTask,
    };
    TaskFuncSingle nopFuncs = {
        .toCommandFunc = &ToCommandForNopTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };

    const auto& chips = GetDavidChips();
    for (auto chip : chips) {
        (void)RegTaskFunc(chip, TS_TASK_TYPE_FUSIONDUMP_ADDR_SET, fusionDumpAddrSetFuncs);
        (void)RegTaskFunc(chip, TS_TASK_TYPE_DATADUMP_LOADINFO, dataDumpLoadInfoFuncs);
        (void)RegTaskFunc(chip, TS_TASK_TYPE_DEBUG_REGISTER, debugRegisterFuncs);
        (void)RegTaskFunc(chip, TS_TASK_TYPE_DEBUG_UNREGISTER, debugUnRegisterFuncs);
        (void)RegTaskFunc(chip, TS_TASK_TYPE_DEBUG_REGISTER_FOR_STREAM, debugRegisterForStreamFuncs);
        (void)RegTaskFunc(chip, TS_TASK_TYPE_DEBUG_UNREGISTER_FOR_STREAM, debugUnRegisterForStreamFuncs);
        (void)RegTaskFunc(chip, TS_TASK_TYPE_AICPU_INFO_LOAD, aicpuInfoLoadFuncs);
        (void)RegTaskFunc(chip, TS_TASK_TYPE_NOP, nopFuncs);
    }

    (void)RegDavidSqeFunc(TS_TASK_TYPE_FUSIONDUMP_ADDR_SET, &ConstructDavidSqeBase);
    (void)RegDavidSqeFunc(TS_TASK_TYPE_DATADUMP_LOADINFO, &ConstructDavidSqeForDataDumpLoadInfoTask);
    (void)RegDavidSqeFunc(TS_TASK_TYPE_DEBUG_REGISTER, &ConstructDavidSqeForDebugRegisterTask);
    (void)RegDavidSqeFunc(TS_TASK_TYPE_DEBUG_UNREGISTER, &ConstructDavidSqeForDebugUnRegisterTask);
    (void)RegDavidSqeFunc(TS_TASK_TYPE_DEBUG_REGISTER_FOR_STREAM, &ConstructDavidSqeForDebugRegisterForStreamTask);
    (void)RegDavidSqeFunc(TS_TASK_TYPE_DEBUG_UNREGISTER_FOR_STREAM, &ConstructDavidSqeForDebugUnRegisterForStreamTask);
    (void)RegDavidSqeFunc(TS_TASK_TYPE_AICPU_INFO_LOAD, &ConstructDavidSqeForAicpuInfoLoadTask);
    (void)RegDavidSqeFunc(TS_TASK_TYPE_NOP, &ConstructDavidSqeForNopTask);

    return true;
}

static bool g_dumpTaskRegister = DumpTaskRegister();

}  // namespace runtime
}  // namespace cce
