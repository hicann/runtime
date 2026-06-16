/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_manager.h"
#include "task_info_v100.h"
#include "model_execute_task.h"
#include "model_graph_task.h"
#include "profiling_task.h"
#include "stream.hpp"
#include "runtime.hpp"
#include "thread_local_container.hpp"
#include "driver.hpp"
#include "stars.hpp"
#include "task_fail_callback_manager.hpp"
#include "memory_task.h"
#include "ffts_task.h"
#include "cond_op_label_task.h"
#include "debug_task.h"
#include "davinci_multiple_task.h"
#include "model_maintaince_task.h"
#include "notify_task.h"
#include "timeout_set_task.h"
#include "ringbuffer_maintain_task.h"
#include "model_update_task.h"
#include "model_to_aicpu_task.h"
#include "kernel_fusion_task.h"
#include "error_code.h"
#include "stub_task.hpp"
#include "aclgraph_cond_task.h"
#include "capture_model.hpp"
#include <mutex>
#include <vector>

namespace cce {
namespace runtime {

TaskFuncArrays g_taskFuncArrays[CHIP_END] = {};

static PfnTaskToCmd *g_toCommandFunc = g_taskFuncArrays[CHIP_BEGIN].toCommandFunc;
static PfnTaskToSqe *g_toSqeFunc = g_taskFuncArrays[CHIP_BEGIN].toSqeFunc;
static PfnDoCompleteSucc *g_doCompleteSuccFunc = g_taskFuncArrays[CHIP_BEGIN].doCompleteSuccFunc;
static PfnWaitAsyncCpCompleteFunc *g_waitAsyncCpCompleteFunc = g_taskFuncArrays[CHIP_BEGIN].waitAsyncCpCompleteFunc;
static PfnPrintErrorInfo *g_printErrorInfoFunc = g_taskFuncArrays[CHIP_BEGIN].printErrorInfoFunc;
static PfnTaskSetResult *g_setResultFunc = g_taskFuncArrays[CHIP_BEGIN].setResultFunc;
static PfnTaskSetStarsResult *g_setStarsResultFunc = g_taskFuncArrays[CHIP_BEGIN].setStarsResultFunc;
PfnTaskUnInit *g_taskUnInitFunc = g_taskFuncArrays[CHIP_BEGIN].taskUnInitFunc;

static rtChipType_t g_lastInitializedChipType = CHIP_BEGIN;
static std::mutex g_taskFuncMutex;

static const char_t *g_davidSqeTypeStr[] = {
    "aic",
    "aiv",
    "fusion",
    "place holder",
    "aicpu_h",
    "aicpu_d",
    "notify record",
    "notify wait",
    "write value",
    "ubdma",
    "asyncdma",
    "sdma",
    "vpc",
    "jpege",
    "jpegd",
    "cmo",
    "ccu",
    "rsv"
    "rsv"
    "rsv"
    "condition",
};

static TaskTypeRegisterInfo g_taskDesc[] = {
    // task type and task name
    {TS_TASK_TYPE_KERNEL_AICORE, "KERNEL_AICORE"},
    {TS_TASK_TYPE_KERNEL_AICPU, "KERNEL_AICPU"},
    {TS_TASK_TYPE_EVENT_RECORD, "EVENT_RECORD"},
    {TS_TASK_TYPE_STREAM_WAIT_EVENT, "EVENT_WAIT"},
    {TS_TASK_TYPE_FUSION_ISSUE, "KERNEL_FUSION"},
    {TS_TASK_TYPE_MEMCPY, "MEMCPY_ASYNC"},
    {TS_TASK_TYPE_MAINTENANCE, "MAINTENANCE"},
    {TS_TASK_TYPE_CREATE_STREAM, "CREATE_STREAM"},
    {TS_TASK_TYPE_DATA_DUMP, "DATA_DUMP"},
    {TS_TASK_TYPE_REMOTE_EVENT_WAIT, "REMOTE_EVENT_WAIT"},
    {TS_TASK_TYPE_PCTRACE_ENABLE, "PC_TRACE"},
    {TS_TASK_TYPE_CREATE_L2_ADDR, "CREATE_L2_ADDR"},
    {TS_TASK_TYPE_MODEL_MAINTAINCE, "MODEL_MAINTAINCE"},
    {TS_TASK_TYPE_MODEL_EXECUTE, "MODEL_EXECUTE"},
    {TS_TASK_TYPE_NOTIFY_WAIT, "NOTIFY_WAIT"},
    {TS_TASK_TYPE_NOTIFY_RECORD, "NOTIFY_RECORD"},
    {TS_TASK_TYPE_RDMA_SEND, "RDMA_SEND"},
    {TS_TASK_TYPE_STREAM_SWITCH, "STREAM_SWITCH"},
    {TS_TASK_TYPE_STREAM_ACTIVE, "STREAM_ACTIVE"},
    {TS_TASK_TYPE_LABEL_SET, "LABEL_SET"},
    {TS_TASK_TYPE_LABEL_SWITCH, "LABEL_SWITCH"},
    {TS_TASK_TYPE_LABEL_GOTO, "LABEL_GOTO"},
    {TS_TASK_TYPE_PROFILER_TRACE, "PROFILER_TRACE"},
    {TS_TASK_TYPE_EVENT_RESET, "EVENT_RESET"},
    {TS_TASK_TYPE_RDMA_DB_SEND, "RDMA_DB_SEND"},
    {TS_TASK_TYPE_PROFILER_TRACE_EX, "PROFILER_TRACE_EX"},
    {TS_TASK_TYPE_PROFILER_DYNAMIC_ENABLE, "PROFILER_DYNAMIC_ENABLE"},
    {TS_TASK_TYPE_PROFILER_DYNAMIC_DISABLE, "PROFILER_DYNAMIC_DISABLE"},
    {TS_TASK_TYPE_CCU_LAUNCH, "CCU_LAUNCH"},
    {TS_TASK_TYPE_STARS_COMMON, "STARS_COMMON"},
    {TS_TASK_TYPE_CMO, "CMO_TASK"},
    {TS_TASK_TYPE_WRITE_VALUE, "WRITE_VALUE"},
    {TS_TASK_TYPE_MULTIPLE_TASK, "MULTIPLE_TASK"},
    {TS_TASK_TYPE_PROFILING_ENABLE, "PROFILING_ENABLE"},
    {TS_TASK_TYPE_PROFILING_DISABLE, "PROFILING_DISABLE"},
    {TS_TASK_TYPE_KERNEL_AIVEC, "KERNEL_AIVEC"},
    {TS_TASK_TYPE_MODEL_END_GRAPH, "MODEL_END_GRAPH"},
    {TS_TASK_TYPE_MODEL_TO_AICPU, "MODEL_TO_AICPU"},
    {TS_TASK_TYPE_ACTIVE_AICPU_STREAM, "ACTIVE_AICPU_STREAM"},
    {TS_TASK_TYPE_DATADUMP_LOADINFO, "DATADUMP_LOADINFO"},
    {TS_TASK_TYPE_STREAM_SWITCH_N, "STREAM_SWITCH_N"},
    {TS_TASK_TYPE_HOSTFUNC_CALLBACK, "HOSTFUNC_CALLBACK"},
    {TS_TASK_TYPE_ONLINEPROF_START, "ONLINE_PROF_ENABLE"},
    {TS_TASK_TYPE_ONLINEPROF_STOP, "ONLINE_PROF_DISABLE"},
    {TS_TASK_TYPE_STREAM_LABEL_SWITCH_BY_INDEX, "STREAM_LABEL_SWITCH_BY_INDEX"},
    {TS_TASK_TYPE_STREAM_LABEL_GOTO, "STREAM_LABEL_GOTO"},
    {TS_TASK_TYPE_DEBUG_REGISTER, "DEBUG_REGISTER"},
    {TS_TASK_TYPE_DEBUG_UNREGISTER, "DEBUG_UNREGISTER"},
    {TS_TASK_TYPE_MODEL_EXIT_GRAPH, "MODEL_EXIT_GRAPH"},
    {TS_TASK_TYPE_ADCPROF, "ADC_PROF"},
    {TS_TASK_TYPE_DEVICE_RINGBUFFER_CONTROL, "DEVICE_RINGBUFFER_CONTROL"},
    {TS_TASK_TYPE_DEBUG_REGISTER_FOR_STREAM, "DEBUG_REGISTER_FOR_STREAM"},
    {TS_TASK_TYPE_DEBUG_UNREGISTER_FOR_STREAM, "DEBUG_UNREGISTER_FOR_STREAM"},
    {TS_TASK_TYPE_TASK_TIMEOUT_SET, "TASK_TIMEOUT_SET"},
    {TS_TASK_TYPE_GET_DEVICE_MSG, "GET_DEVICE_MSG"},
    {TS_TASK_TYPE_NPU_GET_FLOAT_STATUS, "NPU_GET_FLOAT_STATUS"},
    {TS_TASK_TYPE_NPU_CLEAR_FLOAT_STATUS, "NPU_CLEAR_FLOAT_STATUS"},
    {TS_TASK_TYPE_MEMCPY_ASYNC_WITHOUT_SDMA, "reserve"},
    {TS_TASK_TYPE_SET_OVERFLOW_SWITCH, "OVERFLOW_SWTICH_SET"},
    {TS_TASK_TYPE_REDUCE_ASYNC_V2, "REDUCE_ASYNC_V2"},
    {TS_TASK_TYPE_SET_STREAM_GE_OP_TAG, "STREAM_TAG_SET"},
    {TS_TASK_TYPE_SET_STREAM_MODE, "SET_STREAM_MODE"},
    {TS_TASK_TYPE_IPCINT_NOTICE, "IPC_INT_NOTICE"},
    {TS_TASK_TYPE_MODEL_LOAD, "MODEL_LOAD"},
    {TS_TASK_TYPE_GET_STARS_VERSION, "GET_STARS_VERSION"},
    {TS_TASK_TYPE_FLIP, "TASK_FLIP"},
    {TS_TASK_TYPE_SET_SQ_LOCK_UNLOCK, "SQ_LOCK_UNLOCK"},
    {TS_TASK_TYPE_UPDATE_ADDRESS, "UPDATE_ADDRESS"},
    {TS_TASK_TYPE_MODEL_TASK_UPDATE, "MODEL_TASK_UPDATE"},
    {TS_TASK_TYPE_AICPU_INFO_LOAD, "AICPU_INFO_LOAD"},
    {TS_TASK_TYPE_NOP, "NOP"},
    {TS_TASK_TYPE_COMMON_CMD, "COMMON_CMD"},
    {TS_TASK_TYPE_UB_DB_SEND, "UB_DB_SEND"},
    {TS_TASK_TYPE_DIRECT_SEND, "DIRECT_SEND"},
    {TS_TASK_TYPE_FUSION_KERNEL, "FUSION_KERNEL"},
    {TS_TASK_TYPE_KERNEL_MIX_AIC, "KERNEL_MIX_AIC"},
    {TS_TASK_TYPE_KERNEL_MIX_AIV, "KERNEL_MIX_AIV"},
    {TS_TASK_TYPE_DAVID_EVENT_RECORD, "EVENT_RECORD"},
    {TS_TASK_TYPE_DAVID_EVENT_WAIT, "EVENT_WAIT"},
    {TS_TASK_TYPE_DAVID_EVENT_RESET, "EVENT_RESET"},
    {TS_TASK_TYPE_MEM_WRITE_VALUE, "MEM_WRITE_VALUE"},
    {TS_TASK_TYPE_MEM_WAIT_VALUE, "MEM_WAIT_VALUE"},
    {TS_TASK_TYPE_RDMA_PI_VALUE_MODIFY, "RDMA_PI_VALUE_MODIFY"},
    {TS_TASK_TYPE_DQS_ENQUEUE, "DQS_ENQUEUE"},
    {TS_TASK_TYPE_DQS_DEQUEUE, "DQS_DEQUEUE"},
    {TS_TASK_TYPE_DQS_PREPARE, "DQS_PREPARE"},
    {TS_TASK_TYPE_DQS_ZERO_COPY, "DQS_ZEROCOPY"},
    {TS_TASK_TYPE_DQS_SCHED_END, "DQS_SCHED_END"},
    {TS_TASK_TYPE_DQS_MBUF_FREE, "DQS_MBUF_FREE"},
    {TS_TASK_TYPE_DQS_INTER_CHIP_PREPROC, "DQS_INTER_CHIP_PREPROC"},
    {TS_TASK_TYPE_DQS_INTER_CHIP_POSTPROC, "DQS_INTER_CHIP_POSTPROC"},
    {TS_TASK_TYPE_DQS_ADSPC, "DQS_ADSPC"},
    {TS_TASK_TYPE_TSFW_AICPU_MSG_VERSION, "TSFW_AICPU_MSG_VERSION"},
    {TS_TASK_TYPE_TASK_SQE_UPDATE, "SQE_UPDATE_TASK"},
    {TS_TASK_TYPE_CAPTURE_RECORD, "CAPTURE_RECORD"},
    {TS_TASK_TYPE_CAPTURE_WAIT, "CAPTURE_WAIT"},
    {TS_TASK_TYPE_IPC_RECORD, "IPC_EVENT_RECORD"},
 	{TS_TASK_TYPE_IPC_WAIT, "IPC_EVENT_WAIT"},
	{TS_TASK_TYPE_CAPTURE_CONDITION, "CAPTURE_CONDITION"},
};

#if F_DESC("pkgStat")
uint32_t GetReportCount(const rtPkgDesc pkgStat[], const uint8_t profEnabled)
{
    if (profEnabled == 0U) {
        return static_cast<uint32_t>(static_cast<uint32_t>(pkgStat[0].packageReportNum) * pkgStat[0].expectPackage);
    }

    uint32_t pkgNum = 0U;
    constexpr size_t pkgTypeNum = static_cast<size_t>(RT_PACKAGE_TYPE_BUTT);
    for (size_t loop = 0LU; loop < pkgTypeNum; loop++) {
        pkgNum += static_cast<uint32_t>(static_cast<uint32_t>(pkgStat[loop].packageReportNum) *
            pkgStat[loop].expectPackage);
    }
    return pkgNum;
}

bool CheckPackageState(const TaskInfo *taskInfo)
{
    return taskInfo->pkgStat[RT_PACKAGE_TYPE_TASK_REPORT].expectPackage ==
        taskInfo->pkgStat[RT_PACKAGE_TYPE_TASK_REPORT].receivePackage;
}
#endif

static const char_t *g_sqeTypeStr[] = {
    "ffts",
    "aicpu",
    "resv",
    "place holder",
    "event record",
    "event wait",
    "notify record",
    "notify wait",
    "write value",
    "resv",
    "resv",
    "sdma",
    "vpc",
    "jpege",
    "jpegd",
    "dsa",
    "rocce",
    "pcie dma",
    "resv",
    "cdqm",
    "condition",
};

#if F_DESC("common func")
const char_t* GetDavidSqeDescByType(const uint8_t sqeType)
{
    const uint8_t arraySize = static_cast<uint8_t>(sizeof(g_davidSqeTypeStr) / sizeof(g_davidSqeTypeStr[0]));

    if (sqeType >= arraySize) {
        return "unknown";
    }

    return g_davidSqeTypeStr[sqeType];
}

const char_t* GetTaskDescByType(const uint8_t taskType)
{
    for (uint32_t i = 0U; i< sizeof(g_taskDesc) / sizeof(TaskTypeRegisterInfo); i++) {
        if (g_taskDesc[i].type == taskType) {
            return g_taskDesc[i].name;
        }
    }
    return "unknown";
}

void PrintSqe(const rtStarsSqe_t * const sqe, const char *desc)
{
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 0) {
        return;
    }

    const uint32_t * const cmd = reinterpret_cast<const uint32_t *>(sqe);
    for (size_t i = 0UL; i < (sizeof(rtStarsSqe_t) / sizeof(uint32_t)); i += 8U) {
        RT_LOG(RT_LOG_DEBUG, "%s: %08x %08x %08x %08x %08x %08x %08x %08x", desc,
            cmd[i], cmd[i + 1U], cmd[i + 2U], cmd[i + 3U], cmd[i + 4U], cmd[i + 5U], cmd[i + 6U],
            cmd[i + 7U]);
    }
}

void SetStarsResult(TaskInfo *taskInfo, const rtLogicCqReport_t &logicCq)
{
    if (taskInfo->type >= TS_TASK_TYPE_RESERVED) {
        return;
    }

    if (g_setStarsResultFunc[taskInfo->type] != nullptr) {
        g_setStarsResultFunc[taskInfo->type](taskInfo, logicCq);
    }
}

void PrintErrorSqe(const rtStarsSqe_t * const sqe, const char_t *desc)
{
    const uint32_t * const cmd = reinterpret_cast<const uint32_t *>(sqe);
    for (size_t i = 0UL; i < (sizeof(rtStarsSqe_t) / sizeof(uint32_t)); i += 8U) {
        RT_LOG(RT_LOG_ERROR, "%s: %08x %08x %08x %08x %08x %08x %08x %08x", desc,
            cmd[i], cmd[i + 1U], cmd[i + 2U], cmd[i + 3U], cmd[i + 4U], cmd[i + 5U], cmd[i + 6U],
            cmd[i + 7U]);
    }
}

Stream* GetReportStream(Stream *stream)
{
    Stream *reportStream = stream;
    const Model *const modelObj = reportStream->Model_();
    if (modelObj != nullptr) {
        const auto *const captureModel = dynamic_cast<const CaptureModel *>(modelObj);
        if (captureModel != nullptr) {
            const uint16_t rootExeStreamId = captureModel->GetRootExeStreamId();
            if (rootExeStreamId != static_cast<uint16_t>(MAX_UINT16_NUM)) {
                Stream *rootExeStream = nullptr;
                const auto ret = reportStream->Device_()->GetStreamSqCqManage()->GetStreamById(
                    static_cast<uint32_t>(rootExeStreamId), &rootExeStream);
                if ((ret == RT_ERROR_NONE) && (rootExeStream != nullptr)) {
                    return rootExeStream;
                }
            }
        }
        auto *const exeStream = modelObj->GetExeStream();
        reportStream = (exeStream != nullptr) ? exeStream : reportStream;
    }
    return reportStream;
}

void PrintErrorInfo(TaskInfo *taskInfo, const uint32_t devId)
{
    if (taskInfo->type >= TS_TASK_TYPE_RESERVED) {
        return;
    }

    if (g_printErrorInfoFunc[taskInfo->type] != nullptr) {
        g_printErrorInfoFunc[taskInfo->type](taskInfo, devId);
    }

    const Device * const dev = taskInfo->stream->Device_();
    if (dev->IsDevicePageFault() && (dev->Id_() == devId)) {
        // all context enter context fail mode
        ContextManage::SetGlobalFailureErr(devId, RT_ERROR_TSFW_AICORE_EXCEPTION);
    }
}

void PrintErrorInfoCommon(TaskInfo *taskInfo, const uint32_t devId)
{
    const int32_t streamId = taskInfo->stream->Id_();
    Stream *const reportStream = GetReportStream(taskInfo->stream);
    STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_RTS, "Task execution failed, device_id=%u,"
                          " stream_id=%d, %s=%hu, flip_num=%hu, task_type=%d.",
                          devId, streamId, TaskIdDesc(), taskInfo->id, taskInfo->flipNum,
                          static_cast<int32_t>(taskInfo->type));
}

// If the task does not have the corresponding docomplete function, use this function.
void DoCompleteSuccess(TaskInfo* taskInfo, const uint32_t devId)
{
    if (unlikely(taskInfo->errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        taskInfo->stream->SetErrCode(taskInfo->errorCode);
        RT_LOG(RT_LOG_ERROR, "device_id=%u, retCode=%#x, [%s].",
               devId, taskInfo->errorCode, GetTsErrCodeDesc(taskInfo->errorCode));
        PrintErrorInfo(taskInfo, devId);
    }
}

const char_t* GetSqeDescByType(const uint8_t sqeType)
{
    const uint8_t arraySize = sizeof(g_sqeTypeStr) / sizeof(g_sqeTypeStr[0]);

    if (sqeType >= arraySize) {
        return "unknown";
    }

    return g_sqeTypeStr[sqeType];
}

void SetTaskTag(TaskInfo *taskInfo)
{
    if (!Runtime::Instance()->GetNpuCollectFlag()) {
        return;
    }

    if (ThreadLocalContainer::IsTaskTagValid()) {
        std::string taskTag;
        ThreadLocalContainer::GetTaskTag(taskTag);
        taskInfo->stream->AddTaskTag(taskInfo->id, taskTag);

        // reset after use.
        ThreadLocalContainer::ResetTaskTag();
    }
}

rtError_t WaitExecFinish(const TaskInfo *taskInfo)
{
    if (taskInfo->type == TS_TASK_TYPE_MODEL_EXECUTE) {
        return WaitExecFinishForModelExecuteTask(taskInfo);
    }

    return RT_ERROR_NONE;
}

void TaskCommonInfoInit(TaskInfo *taskInfo)
{
    taskInfo->pkgStat[RT_PACKAGE_TYPE_TASK_REPORT].packageReportNum = 1U;
    taskInfo->pkgStat[RT_PACKAGE_TYPE_TASK_REPORT].expectPackage = 1U;
    taskInfo->pkgStat[RT_PACKAGE_TYPE_TASK_REPORT].receivePackage = 0U;
    taskInfo->isValidInO1 = false;
    taskInfo->needPostProc = false;
    taskInfo->stmArgPos = UINT32_MAX;
    taskInfo->mte_error = 0; // init mte_error
    taskInfo->isNoRingbuffer = 0U;

    /* if old process, set taskTag */
    if (taskInfo->stream->taskResMang_ == nullptr) {
        SetTaskTag(taskInfo);
    }
    return;
}

uint64_t CombineTo64Bit(uint32_t high, uint32_t low)
{
    uint64_t temp = static_cast<uint64_t>(high) << 32U;
    temp |= static_cast<uint64_t>(low);
    return temp;
}

void UpdateFlipNum(TaskInfo *taskInfo, const bool isDisableThread)
{
    if (Runtime::Instance()->GetDisableThread() != isDisableThread) {
        return;
    }

    Stream* const stm = taskInfo->stream;
    taskInfo->flipNum = stm->GetTaskIdFlipNum();

    if (taskInfo->id == stm->GetMaxTaskId()) {
        RT_LOG(RT_LOG_DEBUG, "stream_id=%d, task_id=%hu, flip_num=%hu.", stm->Id_(), taskInfo->id, taskInfo->flipNum);
        stm->SetTaskIdFlipNum(stm->GetTaskIdFlipNum() + static_cast<uint16_t>(1));
    }
}

void SetResultCommon(TaskInfo *taskInfo, const void *const data, const uint32_t dataSize)
{
    UNUSED(dataSize);
    const uint32_t *const tsData = static_cast<const uint32_t *>(data);
    taskInfo->errorCode = static_cast<uint32_t>(*tsData & 0xFFFU);
}

void InitByStream(TaskInfo *const taskInfo, Stream *stream)
{
    taskInfo->stream = stream;
    taskInfo->tid = GetCurrentTid();
    taskInfo->bindFlag = false;
    taskInfo->serial = false;
}

void SetStarsResultCommon(TaskInfo *taskInfo, const rtLogicCqReport_t &logicCq)
{
    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) != 0U) {
        if (logicCq.errorCode != TS_SUCCESS) {
            taskInfo->errorCode = logicCq.errorCode;
        } else {
            static uint32_t errMap[TS_STARS_ERROR_MAX_INDEX] = {
                TS_ERROR_TASK_EXCEPTION,
                TS_ERROR_TASK_TRAP,
                TS_ERROR_TASK_TIMEOUT,
                TS_ERROR_TASK_SQE_ERROR,
                TS_ERROR_DEBUG_REGISTER_CONFLICT,
                TS_ERROR_DEBUG_INVALID_TASK_STATUS};
            const uint32_t errorIndex =
                static_cast<uint32_t>(BitScan(static_cast<uint64_t>(logicCq.errorType) & static_cast<uint64_t>(RT_STARS_EXIST_ERROR)));
            taskInfo->errorCode = errMap[errorIndex];
        }
    }
}

rtError_t WaitAsyncCopyComplete(TaskInfo* taskInfo)
{
    if (taskInfo->type >= TS_TASK_TYPE_RESERVED) {
        return RT_ERROR_NONE;
    }

    if (g_waitAsyncCpCompleteFunc[taskInfo->type] != nullptr) {
        g_waitAsyncCpCompleteFunc[taskInfo->type](taskInfo);
    }

    return RT_ERROR_NONE;
}

void TaskUnInitProc(TaskInfo *taskInfo)
{
    if (taskInfo->type >= TS_TASK_TYPE_RESERVED) {
        return;
    }

    Stream * const stream = taskInfo->stream;
    const uint16_t taskId = taskInfo->id;

    if (Runtime::Instance()->GetNpuCollectFlag()) {
        stream->DelTaskTag(taskId);
    }

    if (g_taskUnInitFunc[taskInfo->type] != nullptr) {
        g_taskUnInitFunc[taskInfo->type](taskInfo);
    }
}

void DoCompleteError(const uint32_t completeError)
{
    // we do nothing for default.
    UNUSED(completeError);
}

void Complete(TaskInfo *const taskInfo, const uint32_t devId = RT_MAX_DEV_NUM)
{
    if (taskInfo->error != 0U) {
        DoCompleteError(taskInfo->error);
    } else if (g_doCompleteSuccFunc[taskInfo->type] != nullptr) {
        g_doCompleteSuccFunc[taskInfo->type](taskInfo, devId);
    } else {
        // no operation
    }
}

void SetResult(TaskInfo* taskInfo, const void *const data, const uint32_t dataSize)
{
    if (taskInfo->type >= TS_TASK_TYPE_RESERVED) {
        return;
    }

    if (g_setResultFunc[taskInfo->type] != nullptr) {
        g_setResultFunc[taskInfo->type](taskInfo, data, dataSize);
    }
}

void DoTaskComplete(TaskInfo* taskInfo, const uint32_t devId)
{
    Stream *stm = taskInfo->stream;

    /* task need support O(N)--O(1) */
    if (stm->GetIsSupportASyncRecycle() && stm->isHasPcieBar_) {
        if (!stm->IsNeedPostProc(taskInfo)) {
            Complete(taskInfo, devId);
        }
    }
}

uint32_t GetFlipTaskId(uint32_t taskId, uint16_t flipNum)
{
    uint32_t flipTaskId = static_cast<uint32_t>(taskId);
    flipTaskId |= (static_cast<uint32_t>(flipNum) << 16U);
    RT_LOG(RT_LOG_DEBUG, "task_id=%hu, flip_num=%u, flip_task_id=%u.", taskId, flipNum, flipTaskId);
    return flipTaskId;
}

uint32_t CovertToFlipTaskId(const int32_t streamId, const uint32_t taskId, const Device * const dev)
{
    TaskInfo *workTask = dev->GetTaskFactory()->GetTask(streamId,
                                                        static_cast<uint16_t>(taskId));
    if (workTask != nullptr) {
        return GetFlipTaskId(workTask->id, workTask->flipNum);
    } else {
        RT_LOG(RT_LOG_WARNING, "get task failed, stream_id=%u, task_id=%u", streamId, taskId);
        return taskId;
    }
}

uint32_t CovertToFlipTaskId(const TaskInfo* const taskInfo, const uint32_t taskId)
{
    if (taskInfo != nullptr) {
        return GetFlipTaskId(taskInfo->id, taskInfo->flipNum);
    } else {
        RT_LOG(RT_LOG_WARNING, "taskInfo==nullptr, task_id=%u", taskId);
        return taskId;
    }
}

void GetBinAndKernelNameExceptionArgs(const Kernel * const kernel, rtExceptionArgsInfo_t *argsInfo)
{
    Program *programPtr = kernel->Program_();
    const uint32_t nameOffset = kernel->NameOffset();
    const std::string &progkernelNames = programPtr->GetKernelNamesBuffer();
    const size_t progkernelNamesSize = progkernelNames.size();
    if (nameOffset >= progkernelNamesSize) {
        RT_LOG(RT_LOG_WARNING, "ameOffset >= progkernelNamesSize");
        return;
    }

    size_t i = nameOffset;
    while ((i < progkernelNamesSize) && (progkernelNames[i] != '\0')) {
        i++;
    }

    const std::string kernelNameStr = progkernelNames.substr(nameOffset, i - nameOffset);
    const uint32_t buffSize = kernelNameStr.length() + 1U;
    argsInfo->exceptionKernelInfo.kernelName = new(std::nothrow) char[buffSize];
    COND_RETURN_VOID(argsInfo->exceptionKernelInfo.kernelName == nullptr, "kernelName malloc failed");

    const errno_t ret = strcpy_s(const_cast<char *>(argsInfo->exceptionKernelInfo.kernelName),
        buffSize, kernelNameStr.c_str());
    COND_PROC_RETURN_ERROR_MSG_INNER((ret != EOK), , DELETE_A(argsInfo->exceptionKernelInfo.kernelName),
        "Failed to call strcpy_s to copy %s, size=%u, retCode=%#x.",
        kernelNameStr.c_str(), buffSize, ret);

    argsInfo->exceptionKernelInfo.kernelNameSize = kernelNameStr.length();
    argsInfo->exceptionKernelInfo.bin = programPtr;
    argsInfo->exceptionKernelInfo.binSize = programPtr->GetBinarySize();
    RT_LOG(RT_LOG_INFO, "kernel_name=%s, kernelNameSize=%u, binSize=%u.",
            argsInfo->exceptionKernelInfo.kernelName,
            argsInfo->exceptionKernelInfo.kernelNameSize,
            argsInfo->exceptionKernelInfo.binSize);
}

void GetKernelExceptionDfxInfo(const Kernel * const kernel, const rtArgsSizeInfo_t * const sizeInfo,
    void * const args, const uint32_t argsSize, rtExceptionArgsInfo_t * const argsInfo)
{
    if ((kernel != nullptr) && (kernel->Program_() != nullptr)) {
        GetBinAndKernelNameExceptionArgs(kernel, argsInfo);
    }
 
    if ((kernel != nullptr) && (kernel->DfxAddr() != nullptr) && (kernel->DfxSize() != 0ULL)) {
        argsInfo->exceptionKernelInfo.dfxSize = kernel->DfxSize();
        argsInfo->exceptionKernelInfo.dfxAddr = kernel->DfxAddr();
        argsInfo->exceptionKernelInfo.elfDataFlag = kernel->ElfDataFlag();
        RT_LOG(RT_LOG_INFO, "dfxSize=%u, dfxAddr=%p, elfDataFlag=%u.",
            argsInfo->exceptionKernelInfo.dfxSize,
            argsInfo->exceptionKernelInfo.dfxAddr,
            argsInfo->exceptionKernelInfo.elfDataFlag);
    }

    if (sizeInfo->infoAddr != nullptr) {
        argsInfo->sizeInfo.infoAddr = sizeInfo->infoAddr;
        argsInfo->sizeInfo.atomicIndex = sizeInfo->atomicIndex;
        RT_LOG(RT_LOG_INFO, "GetExceptionArgs infoAddr=%p, atomicIndex=%u.",
            argsInfo->sizeInfo.infoAddr, argsInfo->sizeInfo.atomicIndex);
    }

    if ((args != nullptr) && (argsSize > 0U)) {
        argsInfo->argsize = argsSize;
        argsInfo->argAddr = args;
        RT_LOG(RT_LOG_INFO, "GetExceptionArgs argAddr=%p, argsize=%u.", argsInfo->argAddr, argsInfo->argsize);
    }
    return;
}

void GetExceptionArgs(TaskInfo* taskInfo, rtExceptionArgsInfo_t *argsInfo)
{
    (void)memset_s(argsInfo, sizeof(rtExceptionArgsInfo_t), 0, sizeof(rtExceptionArgsInfo_t));
    if (taskInfo == nullptr) {
        RT_LOG(RT_LOG_WARNING, "taskInfo==nullptr");
        return;
    }

    RT_LOG(RT_LOG_INFO, "GetExceptionArgs taskInfo->type=%u", taskInfo->type);
    if ((taskInfo->type != TS_TASK_TYPE_KERNEL_AICORE) &&
        (taskInfo->type != TS_TASK_TYPE_KERNEL_AIVEC)) {
        return;
    }

    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    Kernel *kernel = aicTaskInfo->kernel;
    GetKernelExceptionDfxInfo(kernel, &(aicTaskInfo->inputArgsSize), aicTaskInfo->comm.args,
        aicTaskInfo->comm.argsSize, argsInfo);
    return;
}

void TaskFailCallBack(const uint32_t streamId, const uint32_t taskId,
                      const uint32_t threadId, const uint32_t retCode,
                      const Device * const dev, bool isNeedTransTaskId)
{
    COND_RETURN_DEBUG(((retCode == static_cast<uint32_t>(RT_ERROR_NONE)) || (retCode == TS_ERROR_END_OF_SEQUENCE) ||
                       (retCode == TS_MODEL_ABORT_NORMAL)), ,
                      "task ok, stream_id=%u, task_id=%u, retCode=%#x.", streamId, taskId, retCode);
    if (dev->GetDeviceStatus() == RT_ERROR_DEVICE_TASK_ABORT) {
        RT_LOG(RT_LOG_WARNING, "Do not call task fail callback in task abort status!");
        return;
    }

    rtExceptionInfo_t exceptionInfo;
    (void)memset_s(&exceptionInfo, sizeof(rtExceptionInfo_t), 0, sizeof(rtExceptionInfo_t));
    rtError_t rtErrCode = RT_ERROR_NONE;
    const char_t *const retDes = GetTsErrCodeMap(retCode, &rtErrCode);

    TaskInfo *workTask = nullptr;
    uint32_t exceptionTaskId = 0xFFFFFFFFU;
    if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
        workTask = GetTaskInfo(dev, streamId, taskId, isNeedTransTaskId);
        if (workTask != nullptr) {
            exceptionTaskId = workTask->taskSn;
        }
    } else {
        workTask = dev->GetTaskFactory()->GetTask(static_cast<int32_t>(streamId), static_cast<uint16_t>(taskId));
        exceptionTaskId = CovertToFlipTaskId(workTask, taskId);
    }

    const rtExceptionExpandType_t type = ((workTask != nullptr) && ((workTask->type == TS_TASK_TYPE_KERNEL_AICORE) ||
        (workTask->type == TS_TASK_TYPE_KERNEL_AIVEC))) ? RT_EXCEPTION_AICORE : RT_EXCEPTION_INVALID;
    GetExceptionArgs(workTask, &(exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs));
    exceptionInfo.retcode = static_cast<uint32_t>(RT_TRANS_EXT_ERRCODE(rtErrCode));
    exceptionInfo.taskid = exceptionTaskId;
    uint32_t exposedStreamId = workTask != nullptr ? workTask->stream->GetExposedStreamId() : streamId;
    exceptionInfo.streamid = exposedStreamId;
    exceptionInfo.tid = threadId;
    exceptionInfo.deviceid = dev->Id_();
    exceptionInfo.expandInfo.type = type;

    RT_LOG(RT_LOG_WARNING, "stream_id=%u, exposed_stream_id=%u, exception_task_id=%u, retCode=%#x,[%s]",
        streamId, exposedStreamId, exceptionTaskId, rtErrCode, retDes);

    TaskFailCallBackNotify(&exceptionInfo);
    if (exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName != nullptr) {
        delete[] exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName;
    }
}

void ToCommand(TaskInfo *taskInfo, rtCommand_t *const command)
{
    Stream * const stream = taskInfo->stream;
    command->taskID = taskInfo->id;
    if (!stream->IsCtrlStream()) {
        command->streamID = static_cast<uint16_t>(stream->Id_());
        command->isctrl = 0;
    } else {
        // avoid tsfw to use out range of task->StreamID
        COND_RETURN_VOID(stream->Device_()->PrimaryStream_() == nullptr, "default stream is NULL.");
        command->streamID = static_cast<uint16_t>(stream->Device_()->PrimaryStream_()->Id_());
        command->isctrl = 1U;
    }
    command->nextTaskIdx = static_cast<uint16_t>(UINT16_MAX);
    command->type = taskInfo->type;
    command->taskState = 0U;
    command->nextStreamIdx = static_cast<uint16_t>(UINT16_MAX);
    command->taskProfEn = taskInfo->profEn & 0x7F;
    command->taskInfoFlag = TASK_NEED_SEND_CQ;
    if (stream->GetBindFlag()) {
        taskInfo->bindFlag = true;
    }

    if (g_toCommandFunc[taskInfo->type] != nullptr) {
        g_toCommandFunc[taskInfo->type](taskInfo, command);
    }

    if (static_cast<int32_t>(command->taskInfoFlag) == static_cast<int32_t>(TASK_NEED_SEND_CQ)) {
        stream->ClearTaskCount(taskInfo->bindFlag);
    }

    if (!(stream->IsTaskSink())) {
        command->taskInfoFlag |= TASK_UNSINK_FLAG;
    }
}

void ConstructSqeBase(TaskInfo *const taskInfo, rtStarsSqe_t *const command)
{
    command->phSqe.type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    command->phSqe.l2_lock = 0;
    command->phSqe.ie = 0;
    command->phSqe.pre_p = 0;
    command->phSqe.post_p = 0;
    command->phSqe.wr_cqe = 1;
    command->phSqe.res0 = 0;

    command->phSqe.task_id = taskInfo->id;
    command->phSqe.rt_streamID = static_cast<uint16_t>(taskInfo->stream->Id_());
    command->phSqe.kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    RT_LOG(RT_LOG_WARNING, "No need to construct sqe. type:%u, task_id:%u, stream_id:%u",
        taskInfo->type, static_cast<uint32_t>(taskInfo->id), taskInfo->stream->Id_());
}

void ToConstructSqe(TaskInfo *taskInfo, rtStarsSqe_t *const command)
{
    // same as ToCommand
    taskInfo->bindFlag = taskInfo->stream->GetBindFlag();

    const uint32_t sendSqeNum = GetSendSqeNum(taskInfo);
    if (g_toSqeFunc[taskInfo->type] != nullptr) {
        g_toSqeFunc[taskInfo->type](taskInfo, command);
    }

    // set expect cqe_num after sqe construction which will be checked before task recly
    taskInfo->pkgStat[RT_PACKAGE_TYPE_TASK_REPORT].expectPackage = static_cast<uint16_t>(sendSqeNum);
}

TaskInfo *GetRealReportFaultTask(TaskInfo *taskInfo, const void *info)
{
    const tsTaskType_t type = taskInfo->type;
    if (type == TS_TASK_TYPE_MODEL_EXECUTE) {
        return GetRealReportFaultTaskForModelExecuteTask(taskInfo);
    } else if (type == TS_TASK_TYPE_NOTIFY_WAIT) {
        return GetRealReportFaultTaskForNotifyWaitTask(taskInfo, info);
    } else {
        return taskInfo;
    }
}

void PushBackErrInfo(TaskInfo* taskInfo, const void *errInfo, uint32_t len)
{
    if (taskInfo == nullptr) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "PushBackErrInfo failed because taskInfo cannot be a NULL pointer.");
        return;
    }
    const tsTaskType_t type = taskInfo->type;
    if (type != TS_TASK_TYPE_FFTS_PLUS) {
        return;
    }
    PushBackErrInfoForFftsPlusTask(taskInfo, errInfo, len);
}

void SetEndGraphNotifyWaitSqPos(TaskInfo* taskInfo, const uint32_t pos)
{
    taskInfo->pos = pos;
    if (taskInfo->bindFlag != 0U) {
        return;
    }

    if ((taskInfo->type == TS_TASK_TYPE_NOTIFY_WAIT) && (taskInfo->u.notifywaitTask.isEndGraphNotify)) {
        (void)taskInfo->stream->Device_()->StoreEndGraphNotifyInfo(taskInfo->stream->Id_(), taskInfo->u.notifywaitTask.captureModel, pos);
    }

    return;
}

void SetSqPos(TaskInfo* taskInfo, const uint32_t pos)
{
    taskInfo->pos = pos;
    if (taskInfo->type == TS_TASK_TYPE_LABEL_SET) {
        SetLabelInfoForLabelSetTask(taskInfo, pos);
    }
    
    if (taskInfo->bindFlag == 0U) {
        if (taskInfo->type == TS_TASK_TYPE_EVENT_RECORD) {
            EventRecordTaskInfo *eventRecordInfo = &(taskInfo->u.eventRecordTaskInfo);
            if (eventRecordInfo->event != nullptr) {
                eventRecordInfo->event->SetRecordPos(static_cast<uint16_t>(pos));
            }
        } else if (taskInfo->type == TS_TASK_TYPE_DAVID_EVENT_RECORD) {
            DavidEventRecordTaskInfo *davidEventRecordInfo = &(taskInfo->u.davidEventRecordTaskInfo);
            if (davidEventRecordInfo->event != nullptr) {
                davidEventRecordInfo->event->SetRecordPos(static_cast<uint16_t>(pos));
            }
        } else if ((taskInfo->type == TS_TASK_TYPE_NOTIFY_WAIT) && (taskInfo->u.notifywaitTask.isEndGraphNotify)) {
            (void)taskInfo->stream->Device_()->StoreEndGraphNotifyInfo(taskInfo->stream->Id_(), taskInfo->u.notifywaitTask.captureModel, pos);
        } else {
            // no operation
        }
    } else {
        // no operation
    }
}

void SaveTaskInfo(TaskInfo *const taskInfo, TaskInfo *submitTask)
{
    taskInfo->type = submitTask->type;
    taskInfo->typeName = submitTask->typeName;
    taskInfo->id = submitTask->id;
    taskInfo->flipNum = submitTask->flipNum;
    taskInfo->profEn = submitTask->profEn;
    taskInfo->terminal = submitTask->terminal;
    taskInfo->preRecycleFlag = submitTask->preRecycleFlag;
    taskInfo->isCqeNeedConcern = submitTask->isCqeNeedConcern;
    taskInfo->u = submitTask->u;
    taskInfo->taskOwner = submitTask->taskOwner;

    TaskCommonInfoInit(taskInfo);
    taskInfo->needPostProc = submitTask->needPostProc;
    taskInfo->stmArgPos = submitTask->stmArgPos;

    /* SaveTaskInfo only for new process */
    SetTaskTag(taskInfo);
}

bool IsNeedFreeStreamRes(const TaskInfo *task)
{
    if (task->type == TS_TASK_TYPE_MAINTENANCE) {
        if (task->u.maintenanceTaskInfo.mtType == MT_STREAM_DESTROY) {
            return true;
        }
    }
    return false;
}

#endif

#if F_DESC("钩子注册框架")
const std::vector<rtChipType_t>& GetV100Chips()
{
    static const std::vector<rtChipType_t> chips = {
        CHIP_MINI, CHIP_CLOUD, CHIP_ADC, CHIP_LHISI, CHIP_DC, CHIP_910_B_93,
        CHIP_NO_DEVICE, CHIP_MINI_V3, CHIP_ASCEND_031, CHIP_NANO, CHIP_RESERVED,
        CHIP_AS31XM1, CHIP_610LITE, CHIP_CLOUD_V3, CHIP_BS9SX1A
    };
    return chips;
}

const std::vector<rtChipType_t>& GetDavidChips()
{
    static const std::vector<rtChipType_t> chips = {
        CHIP_DAVID, CHIP_CLOUD_V5, CHIP_MC62CM12A, CHIP_ASCEND_350
    };
    return chips;
}

const std::vector<rtChipType_t>& GetV200Chips()
{
    static const std::vector<rtChipType_t> chips = { CHIP_DAVID, CHIP_CLOUD_V5, CHIP_ASCEND_350 };
    return chips;
}

const std::vector<rtChipType_t>& GetV201Chips()
{
    static const std::vector<rtChipType_t> chips = { CHIP_MC62CM12A };
    return chips;
}

void RegTaskToCommandFunc(const std::vector<rtChipType_t> &chipTypes)
{
    PfnTaskToCmd *toCommandFunc = nullptr;
    for (auto chipType : chipTypes) {
        toCommandFunc = g_taskFuncArrays[chipType].toCommandFunc;

        toCommandFunc[TS_TASK_TYPE_FUSION_ISSUE] = &ToCommandBodyForKernelFusionTask;
        toCommandFunc[TS_TASK_TYPE_PROFILER_DYNAMIC_ENABLE] = &ToCommandBodyForDynamicProfilingEnableTask;
        toCommandFunc[TS_TASK_TYPE_PROFILER_DYNAMIC_DISABLE] = &ToCommandBodyForDynamicProfilingDisableTask;
        toCommandFunc[TS_TASK_TYPE_PROFILING_ENABLE] = &ToCommandBodyForProfilingEnableTask;
        toCommandFunc[TS_TASK_TYPE_PROFILING_DISABLE] = &ToCommandBodyForProfilingDisableTask;
        toCommandFunc[TS_TASK_TYPE_ONLINEPROF_START] = &ToCommandBodyForOnlineProfEnableTask;
        toCommandFunc[TS_TASK_TYPE_ONLINEPROF_STOP] = &ToCommandBodyForOnlineProfDisableTask;
        toCommandFunc[TS_TASK_TYPE_ADCPROF] = &ToCommandBodyForAdcProfTask;
        toCommandFunc[TS_TASK_TYPE_PCTRACE_ENABLE] = &ToCommandBodyForPCTraceTask;
        toCommandFunc[TS_TASK_TYPE_MODEL_MAINTAINCE] = &ToCommandBodyForModelMaintainceTask;
        toCommandFunc[TS_TASK_TYPE_MODEL_EXECUTE] = &ToCommandBodyForModelExecuteTask;
        toCommandFunc[TS_TASK_TYPE_MODEL_END_GRAPH] = &ToCmdBodyForAddEndGraphTask;
        toCommandFunc[TS_TASK_TYPE_MODEL_EXIT_GRAPH] = &ToCmdBodyForAddModelExitTask;
        toCommandFunc[TS_TASK_TYPE_MODEL_TO_AICPU] = &ToCmdBodyForModelToAicpuTask;
        toCommandFunc[TS_TASK_TYPE_FFTS_PLUS] = nullptr;
        toCommandFunc[TS_TASK_TYPE_DEVICE_RINGBUFFER_CONTROL] = &ToCmdBodyForRingBufferMaintainTask;
        toCommandFunc[TS_TASK_TYPE_PROFILER_TRACE] = &ToCommandBodyForProfilerTraceTask;
        toCommandFunc[TS_TASK_TYPE_PROFILER_TRACE_EX] = &ToCommandBodyForProfilerTraceExTask;
        toCommandFunc[TS_TASK_TYPE_TASK_TIMEOUT_SET] = &ToCommandBodyForTimeoutSetTask;
        toCommandFunc[TS_TASK_TYPE_MODEL_TASK_UPDATE] = &ToCommandBodyForModelUpdateTask;
        toCommandFunc[TS_TASK_TYPE_CAPTURE_CONDITION] = nullptr;
    }

}

static void RegDoCompleteSuccFunc(const std::vector<rtChipType_t> &chipTypes)
{
    PfnDoCompleteSucc *doCompleteSuccFunc = nullptr;
    for (auto chipType : chipTypes) {
        doCompleteSuccFunc = g_taskFuncArrays[chipType].doCompleteSuccFunc;

        doCompleteSuccFunc[TS_TASK_TYPE_FUSION_ISSUE] = &DoCompleteSuccess;
        doCompleteSuccFunc[TS_TASK_TYPE_PROFILER_DYNAMIC_ENABLE] = &DoCompleteSuccess;
        doCompleteSuccFunc[TS_TASK_TYPE_PROFILER_DYNAMIC_DISABLE] = &DoCompleteSuccess;
        doCompleteSuccFunc[TS_TASK_TYPE_PROFILING_ENABLE] = &DoCompleteSuccess;
        doCompleteSuccFunc[TS_TASK_TYPE_PROFILING_DISABLE] = &DoCompleteSuccess;
        doCompleteSuccFunc[TS_TASK_TYPE_ONLINEPROF_START] = &DoCompleteSuccess;
        doCompleteSuccFunc[TS_TASK_TYPE_ONLINEPROF_STOP] = &DoCompleteSuccess;
        doCompleteSuccFunc[TS_TASK_TYPE_ADCPROF] = &DoCompleteSuccess;
        doCompleteSuccFunc[TS_TASK_TYPE_PCTRACE_ENABLE] = &DoCompleteSuccess;
        doCompleteSuccFunc[TS_TASK_TYPE_MODEL_MAINTAINCE] = &DoCompleteSuccessForModelMaintainceTask;
        doCompleteSuccFunc[TS_TASK_TYPE_MODEL_EXECUTE] = &DoCompleteSuccessForModelExecuteTask;
        doCompleteSuccFunc[TS_TASK_TYPE_MODEL_END_GRAPH] = &DoCompleteSuccess;
        doCompleteSuccFunc[TS_TASK_TYPE_MODEL_EXIT_GRAPH] = &DoCompleteSuccess;
        doCompleteSuccFunc[TS_TASK_TYPE_MODEL_TO_AICPU] = &DoCompleteSuccForModelToAicpuTask;
        doCompleteSuccFunc[TS_TASK_TYPE_FFTS_PLUS] = &DoCompleteSuccForFftsPlusTask;
        doCompleteSuccFunc[TS_TASK_TYPE_DEVICE_RINGBUFFER_CONTROL] = &DoCompleteSuccess;
        doCompleteSuccFunc[TS_TASK_TYPE_IPCINT_NOTICE] = &DoCompleteSuccess;
        doCompleteSuccFunc[TS_TASK_TYPE_PROFILER_TRACE] = &DoCompleteSuccess;
        doCompleteSuccFunc[TS_TASK_TYPE_PROFILER_TRACE_EX] = &DoCompleteSuccess;
        doCompleteSuccFunc[TS_TASK_TYPE_TASK_TIMEOUT_SET] = &DoCompleteSuccess;
        doCompleteSuccFunc[TS_TASK_TYPE_MODEL_TASK_UPDATE] = &DoCompleteSuccess;
        doCompleteSuccFunc[TS_TASK_TYPE_CAPTURE_CONDITION] = &DoCompleteSuccess;
    }
}

static void RegTaskToSqefunc(const std::vector<rtChipType_t> &chipTypes)
{
    PfnTaskToSqe *toSqeFunc = nullptr;
    for (auto chipType : chipTypes) {
        toSqeFunc = g_taskFuncArrays[chipType].toSqeFunc;
        toSqeFunc[TS_TASK_TYPE_FUSION_ISSUE] = &ConstructSqeBase;
        toSqeFunc[TS_TASK_TYPE_PROFILING_ENABLE] = &ConstructSqeForProfilingEnableTask;
        toSqeFunc[TS_TASK_TYPE_PROFILING_DISABLE] = &ConstructSqeForProfilingDisableTask;
        toSqeFunc[TS_TASK_TYPE_ONLINEPROF_START] = &ConstructSqeBase;
        toSqeFunc[TS_TASK_TYPE_ONLINEPROF_STOP] = &ConstructSqeBase;
        toSqeFunc[TS_TASK_TYPE_ADCPROF] = &ConstructSqeBase;
        toSqeFunc[TS_TASK_TYPE_PCTRACE_ENABLE] = &ConstructSqeBase;
        toSqeFunc[TS_TASK_TYPE_MODEL_MAINTAINCE] = &ConstructSqeForModelMaintainceTask;
        toSqeFunc[TS_TASK_TYPE_MODEL_EXECUTE] = &ConstructSqeForModelExecuteTask;
        toSqeFunc[TS_TASK_TYPE_MODEL_END_GRAPH] = &ConstructSqeForAddEndGraphTask;
        toSqeFunc[TS_TASK_TYPE_MODEL_EXIT_GRAPH] = &ConstructSqeBase;
        toSqeFunc[TS_TASK_TYPE_MODEL_TO_AICPU] = &ConstructSqeForModelToAicpuTask;
        toSqeFunc[TS_TASK_TYPE_FFTS_PLUS] = &ConstructSqeForFftsPlusTask;
        toSqeFunc[TS_TASK_TYPE_DEVICE_RINGBUFFER_CONTROL] = &ConstructSqeForRingBufferMaintainTask;
        toSqeFunc[TS_TASK_TYPE_PROFILER_TRACE] = &ConstructSqeBase;
        toSqeFunc[TS_TASK_TYPE_PROFILER_TRACE_EX] = &ConstructSqeForProfilerTraceExTask;
        toSqeFunc[TS_TASK_TYPE_TASK_TIMEOUT_SET] = &ConstructSqeForTimeoutSetTask;
        toSqeFunc[TS_TASK_TYPE_MODEL_TASK_UPDATE] = &ConstructSqeForModelUpdateTask;
        toSqeFunc[TS_TASK_TYPE_CAPTURE_CONDITION] = &ConstructSqeForCaptureConditionTask;
    }
}

static void RegTaskUnInitFunc(const std::vector<rtChipType_t> &chipTypes)
{
    for (auto chipType : chipTypes) {
        auto &taskUnInitFunc = g_taskFuncArrays[chipType].taskUnInitFunc;

        taskUnInitFunc[TS_TASK_TYPE_PCTRACE_ENABLE] = &PCTraceTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_FFTS_PLUS] = &FftsPlusTaskUnInit;
        taskUnInitFunc[TS_TASK_TYPE_CAPTURE_CONDITION] = &CaptureConditionTaskUnInit;
    }
}

static void RegSetResultFunc(const std::vector<rtChipType_t> &chipTypes)
{
    for (auto chipType : chipTypes) {
        auto &setResultFunc = g_taskFuncArrays[chipType].setResultFunc;
        for (auto &item : setResultFunc) {
            if (item == nullptr) {
                item = &SetResultCommon;
            }
        }

        setResultFunc[TS_TASK_TYPE_MODEL_EXECUTE] = &SetResultForModelExecuteTask;
    }
}

static void RegPrintErrorInfoFunc(const std::vector<rtChipType_t> &chipTypes)
{
    for (auto chipType : chipTypes) {
        auto &printErrorInfoFunc = g_taskFuncArrays[chipType].printErrorInfoFunc;
        for (auto &item : printErrorInfoFunc) {
            if (item == nullptr) {
                item = &PrintErrorInfoCommon;
            }
        }
        printErrorInfoFunc[TS_TASK_TYPE_MODEL_MAINTAINCE] = &PrintErrorInfoForModelMaintainceTask;
        printErrorInfoFunc[TS_TASK_TYPE_MODEL_EXECUTE] = &PrintErrorInfoForModelExecuteTask;
        printErrorInfoFunc[TS_TASK_TYPE_MODEL_TO_AICPU] = &PrintErrorInfoForModelToAicpuTask;
        printErrorInfoFunc[TS_TASK_TYPE_FFTS_PLUS] = &PrintErrorInfoForFftsPlusTask;
    }
}

static void RegSetStarsResultFunc(const std::vector<rtChipType_t> &chipTypes)
{
    for (auto chipType : chipTypes) {
        auto &setStarsResultFunc = g_taskFuncArrays[chipType].setStarsResultFunc;
        for (auto &item : setStarsResultFunc) {
            if (item == nullptr) {
                item = &SetStarsResultCommon;
            }
        }

        setStarsResultFunc[TS_TASK_TYPE_MODEL_EXECUTE] = &SetStarsResultForModelExecuteTask;
        setStarsResultFunc[TS_TASK_TYPE_MODEL_TO_AICPU] = &SetStarsResultForModelToAicpuTask;
        setStarsResultFunc[TS_TASK_TYPE_FFTS_PLUS] = &SetStarsResultForFftsPlusTask;
    }
}

void TaskFuncReg(void)
{
    const auto& chipTypes = GetV100Chips();

    RegTaskToCommandFunc(chipTypes);
    RegTaskToSqefunc(chipTypes);
    RegDoCompleteSuccFunc(chipTypes);
    RegTaskUnInitFunc(chipTypes);
    RegPrintErrorInfoFunc(chipTypes);
    RegSetResultFunc(chipTypes);
    RegSetStarsResultFunc(chipTypes);

    return;
}

void RefreshTaskFuncPointer(rtChipType_t chipType)
{
    if (chipType < CHIP_BEGIN || chipType >= CHIP_END) {
        RT_LOG(RT_LOG_ERROR, "Invalid chipType: %d", chipType);
        return;
    }
    
    std::lock_guard<std::mutex> lock(g_taskFuncMutex);
    
    if (g_lastInitializedChipType == chipType) {
        return;
    }
    
    g_lastInitializedChipType = chipType;
    
    TaskFuncArrays &arrays = g_taskFuncArrays[chipType];
    g_toCommandFunc = arrays.toCommandFunc;
    g_toSqeFunc = arrays.toSqeFunc;
    g_doCompleteSuccFunc = arrays.doCompleteSuccFunc;
    g_taskUnInitFunc = arrays.taskUnInitFunc;
    g_waitAsyncCpCompleteFunc = arrays.waitAsyncCpCompleteFunc;
    g_printErrorInfoFunc = arrays.printErrorInfoFunc;
    g_setResultFunc = arrays.setResultFunc;
    g_setStarsResultFunc = arrays.setStarsResultFunc;
    RT_LOG(RT_LOG_INFO, "Task func pointer refreshed to chip type: %d", chipType);
}

rtError_t RegTaskFunc(rtChipType_t chipType, tsTaskType_t taskType, const TaskFuncSingle& funcs)
{
    if (chipType < CHIP_BEGIN || chipType >= CHIP_END) {
        RT_LOG(RT_LOG_ERROR, "chip type is invalid: %d", chipType);
        return RT_ERROR_TASK_BASE;
    }
    
    if (taskType >= TS_TASK_TYPE_RESERVED) {
        RT_LOG(RT_LOG_ERROR, "task type is invalid: %d", taskType);
        return RT_ERROR_TASK_BASE;
    }
    
    TaskFuncArrays& arrays = g_taskFuncArrays[chipType];
    arrays.toCommandFunc[taskType] = funcs.toCommandFunc;
    arrays.toSqeFunc[taskType] = funcs.toSqeFunc;
    arrays.doCompleteSuccFunc[taskType] = funcs.doCompleteSuccFunc;
    arrays.taskUnInitFunc[taskType] = funcs.taskUnInitFunc;
    arrays.waitAsyncCpCompleteFunc[taskType] = funcs.waitAsyncCpCompleteFunc;
    arrays.printErrorInfoFunc[taskType] = funcs.printErrorInfoFunc;
    arrays.setResultFunc[taskType] = funcs.setResultFunc;
    arrays.setStarsResultFunc[taskType] = funcs.setStarsResultFunc;
    
    return RT_ERROR_NONE;
}

#endif

}  // namespace runtime
}  // namespace cce
