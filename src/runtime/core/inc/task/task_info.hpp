/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_TASK_INFO_HPP
#define CCE_RUNTIME_TASK_INFO_HPP
#include "rt_model.h"
#include "task_info_struct.hpp"
#include "task_info_struct_cond.hpp"

namespace cce {
namespace runtime {

enum class TaskUpdateFlag : uint8_t {
    RT_TASK_KEEP = 0,
    RT_TASK_UPDATE,
    RT_TASK_DISABLE
};

enum class TaskOwner : uint8_t {
    RT_TASK_USER,
    RT_TASK_INNER,
};

/**
 * @ingroup
 * @brief the struct define of task
 */
typedef struct tagTaskInfoStru {
    Stream *stream;
    const char_t *typeName;
    tsTaskType_t type;
    uint64_t taskTrackTimeStamp;
    uint32_t tid;
    uint32_t error;
    uint32_t drvErr;
    uint32_t errorCode;
    uint32_t taskSn;         /* for dump/profiling */
    uint32_t pos;
    uint32_t stmArgPos;
    uint32_t liteStreamResId;
    uint32_t modelSeqId;
    uint16_t liteTaskResId;
    uint16_t mte_error;
    uint16_t id;
    uint16_t flipNum;
    uint8_t profEn;
    uint8_t updateFlag;

    uint8_t serial : 1;   // false
    uint8_t terminal : 1;
    uint8_t bindFlag : 1;
    uint8_t preRecycleFlag : 1;
    uint8_t isCqeNeedConcern : 1;
    uint8_t isNeedStreamSync : 1;
    uint8_t isForceCycle : 1;
    uint8_t isValidInO1 : 1;
    uint8_t isRingbufferGet : 1;
    uint8_t isUpdateSinkSqe : 1;
    uint8_t isNoRingbuffer : 1;
    uint8_t taskOwner : 1; // 默认是user，使用此标记需关注其实际值
    uint8_t resv : 4;
    uint8_t sqeNum : 7; // 使用sqeNum必须在对应taskini中初始化
    uint8_t needPostProc : 1;
    /*-------------------------tmp begine------------------------------------*/
    // DavinciMultiTaskInfo、PCTraceTaskInfo:
    std::shared_ptr<PCTrace> pcTrace;
    /*-------------------------tmp end---------------------------------------*/
    union {
        AicTaskInfo aicTaskInfo;
        AicpuTaskInfo aicpuTaskInfo;
        DavinciMultiTaskInfo davinciMultiTaskInfo;
        MemcpyAsyncTaskInfo memcpyAsyncTaskInfo;
        MemsetAsyncTaskInfo memsetAsyncTaskInfo;
        ReduceAsyncV2TaskInfo reduceAsyncV2TaskInfo;
        EventRecordTaskInfo eventRecordTaskInfo;
        EventResetTaskInfo eventResetTaskInfo;
        RemoteEventWaitTaskInfo remoteEventWaitTaskInfo;
        EventWaitTaskInfo eventWaitTaskInfo;
        DavidEventRecordTaskInfo davidEventRecordTaskInfo;
        DavidEventResetTaskInfo davidEventResetTaskInfo;
        DavidEventWaitTaskInfo davidEventWaitTaskInfo;
        MaintenanceTaskInfo maintenanceTaskInfo;
        CreateStreamTaskInfo createStreamTaskInfo;
        CreateL2AddrTaskInfo createL2AddrTaskInfo;
        KernelFusionTaskInfo kernelFusionTaskInfo;
        ProfilingEnableTaskInfo profilingEnableTaskInfo;
        ProfilingDisableTaskInfo profilingDisableTaskInfo;
        OnlineProfEnableTaskInfo onlineProfEnableTaskInfo;
        OnlineProfDisableTaskInfo onlineProfDisableTaskInfo;
        AdcProfTaskInfo adcProfTaskInfo;
        PCTraceTaskInfo pcTraceTaskInfo;
        ModelMaintainceTaskInfo modelMaintainceTaskInfo;
        ModelExecuteTaskInfo modelExecuteTaskInfo;
        RdmaPiValueModifyInfo rdmaPiValueModifyInfo;
        RdmaSendTaskInfo rdmaSendTask;
        RdmaDbSendTaskInfo rdmaDbSendTask;
        NotifyRecordTaskInfo notifyrecordTask;
        NotifyWaitTaskInfo notifywaitTask;
        StreamSwitchTaskInfo streamswitchTask;
        StreamActiveTaskInfo streamactiveTask;
        LabelSetTaskInfo labelSetTask;
        LabelSwitchTaskInfo labelSwitchTask;
        LabelGotoTaskInfo labelGotoTask;
        ProfilerTraceTaskInfo profilertraceTask;
        ProfilerTraceExTaskInfo profilerTraceExTask;
        ModelEndGraphTaskInfo addEndGraphTask;
        ModelExitTaskInfo addModelExitTask;
        ModelToAicpuTaskInfo modelToAicpuTask;
        ActiveAicpuStreamTaskInfo activeAicpuStreamTask;
        DataDumpLoadInfoTaskInfo dataDumpLoadInfoTask;
        StreamSwitchNTaskInfo streamSwitchNTask;
        CallbackLaunchTaskInfo callbackLaunchTask;
        StmLabelSwitchByIdxTaskInfo stmLabelSwitchIdxTask;
        StreamLabelGotoTaskInfo streamLabelGotoTask;
        StarsCommonTaskInfo starsCommTask;
        FftsPlusTaskInfo fftsPlusTask;
        NpuGetFloatStatusTaskInfo npuGetFloatStatusTask;
        NpuClearFloatStatusTaskInfo npuClrFloatStatusTask;
        OverflowSwitchSetTaskInfo overflowSwitchSetTask;

        StreamTagSetTaskInfo stmTagSetTask;
        RingBufferMaintainTaskInfo ringBufMtTask;
        WriteValueTaskInfo writeValTask;
        CmoTaskInfo cmoTask;
        BarrierTaskInfo barrierTask;
        SetStreamModeTaskInfo setStmModeTask;
        DebugRegisterTaskInfo debugRegisterTask;
        DebugUnRegisterTaskInfo debugUnRegisterTask;
        FusionDumpAddrSetTaskInfo fusionDumpAddrSetTask;
        DebugRegisterForStreamTaskInfo debugRegisterForStreamTask;
        DebugUnRegForStreamTaskInfo debugUnRegisterForStreamTask;
        TimeoutSetTaskInfo timeoutSetTask;
        GetDevMsgTaskInfo getDevMsgTask;
        FlipTaskInfo flipTask;
        SqLockUnlockTaskInfo sqLockUnlockTask;
        CmoAddrTaskInfo cmoAddrTaskInfo;
        UpdateAddressTaskInfo updateAddrTask;
        MdlUpdateTaskInfo mdlUpdateTask;
        AicpuInfoLoadTaskInfo aicpuInfoLoadTask;
        CommonCmdTaskInfo commonCmdTask;
        CcuLaunchTaskInfo ccuLaunchTask;
        FusionTaskInfo fusionKernelTask;
        UbSendTaskInfo ubSendTask;
        DirectSendTaskInfo directSendTask;
        MemWriteValueTaskInfo memWriteValueTask;
        MemWaitValueTaskInfo memWaitValueTask;
        AicpuMsgVersionTaskInfo aicpuMsgVersionTask;

        // 1952 DQS
        DqsCommonTaskInfo dqsEnqueueTask;
        DqsCommonTaskInfo dqsDequeueTask;
        DqsCommonTaskInfo dqsPrepareTask;
        DqsCommonTaskInfo dqsMbufFreeTask;
        DqsCommonTaskInfo dqsBatchDequeueTask;
        DqsCommonTaskInfo dqsCondCopyTask;
        DqsCommonTaskInfo dqsFrameAlignTask;
        DqsZeroCopyTaskInfo dqsZeroCopyTask;
        DqsSchedEndTaskInfo dqsSchedEndTask;
        DqsInterChipProcTaskInfo dqsInterChipPreProcTask;
        DqsInterChipProcTaskInfo dqsInterChipPostProcTask;
        DqsAdspcTaskInfo dqsAdspcTaskInfo;
        SqeUpdateTaskInfo sqeUpdateTask;

        CaptureConditionTaskInfo captureConditionTask;
    } u;

    rtPkgDesc pkgStat[RT_PACKAGE_TYPE_BUTT];
} TaskInfo;

void Complete(TaskInfo *const taskInfo, const uint32_t devId);
struct TaskTypeRegisterInfo {
    uint32_t type;
    const char_t* name;
};

rtError_t WaitExecFinish(const TaskInfo *taskInfo);
uint32_t GetReportCount(const rtPkgDesc pkgStat[], const uint8_t profEnabled);
bool CheckPackageState(const TaskInfo *taskInfo);
uint32_t GetFlipTaskId(uint32_t taskId, uint16_t flipNum);
TaskInfo *GetRealReportFaultTask(TaskInfo *taskInfo, const void *info);
void PushBackErrInfo(TaskInfo* taskInfo, const void *errInfo, uint32_t len);
void TaskFailCallBack(const uint32_t streamId, const uint32_t taskId,
                    const uint32_t threadId, const uint32_t retCode,
                    const Device * const dev, bool isNeedTransTaskId = false);
void TaskUnInitProc(TaskInfo *taskInfo);
void SetResult(TaskInfo* taskInfo, const void *const data, const uint32_t dataSize);
void SetStarsResult(TaskInfo *taskInfo, const rtLogicCqReport_t &logicCq);
rtError_t WaitAsyncCopyComplete(TaskInfo* taskInfo);

void UpdateFlipNum(TaskInfo *taskInfo, const bool isDisableThread);
void InitByStream(TaskInfo *const taskInfo, Stream *stream);
void DoTaskComplete(TaskInfo* taskInfo, const uint32_t devId);

inline void SetAicoreArgs(TaskInfo *taskInfo, const void * const dataArgs, const uint32_t dataArgsSize, void *const dataArgHandle)
{
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);

    aicTaskInfo->comm.args = const_cast<void*>(dataArgs);
    aicTaskInfo->comm.argsSize = dataArgsSize;
    aicTaskInfo->comm.argHandle = dataArgHandle;
}

inline bool IsPureSimtTask(const AicTaskInfo &aicTaskInfo)
{
    return (aicTaskInfo.simtParamOffset != 0U);
}

inline void SetAicpuArgs(TaskInfo *taskInfo, const void * const dataArgs, const uint32_t dataArgsSize,
    void *const dataArgHandle)
{
    AicpuTaskInfo *aicpuTaskInfo = &(taskInfo->u.aicpuTaskInfo);

    aicpuTaskInfo->comm.args = const_cast<void *>(dataArgs);
    aicpuTaskInfo->comm.argsSize = dataArgsSize;
    aicpuTaskInfo->comm.argHandle = dataArgHandle;
}

inline void SetArgs(TaskInfo *taskInfo, const void * const dataArgs, const uint32_t dataArgsSize, void *const dataArgHandle)
{
    const tsTaskType_t tskType = taskInfo->type;
    if ((tskType == TS_TASK_TYPE_KERNEL_AICORE) || (tskType == TS_TASK_TYPE_KERNEL_AIVEC)) {
        SetAicoreArgs(taskInfo, dataArgs, dataArgsSize, dataArgHandle);
    } else if (tskType == TS_TASK_TYPE_KERNEL_AICPU) {
        SetAicpuArgs(taskInfo, dataArgs, dataArgsSize, dataArgHandle);
    } else {
        // 仅处理TS_TASK_TYPE_KERNEL_AICORE/TS_TASK_TYPE_KERNEL_AIVEC/TS_TASK_TYPE_KERNEL_AICPU 3类type
    }
}

inline void SetNameArgs(TaskInfo *taskInfo, const void *const kernelSoName, const void *const kernelFuncName)
{
    AicpuTaskInfo *aicpuTaskInfo = &(taskInfo->u.aicpuTaskInfo);

    aicpuTaskInfo->funcName = const_cast<void*>(kernelFuncName);
    aicpuTaskInfo->soName = const_cast<void*>(kernelSoName);
}

const char_t* GetSqeDescByType(const uint8_t sqeType);
const char_t* GetDavidSqeDescByType(const uint8_t sqeType);
const char_t* GetTaskDescByType(const uint8_t taskType);
bool IsNeedFreeStreamRes(const TaskInfo *task);

uint32_t CovertToFlipTaskId(const int32_t streamId, const uint32_t taskId, const Device * const dev);
uint32_t CovertToFlipTaskId(const TaskInfo* const taskInfo, const uint32_t taskId);
void GetExceptionArgs(TaskInfo* taskInfo, rtExceptionArgsInfo_t *argsInfo);
void GetAicpuExceptionDetailInfo(TaskInfo *taskInfo, rtAicpuExDetailInfo_t *detailInfo);

void SetSqPos(TaskInfo* taskInfo, const uint32_t pos);
void SetEndGraphNotifyWaitSqPos(TaskInfo* taskInfo, const uint32_t pos);
uint32_t GetSendSqeNum(TaskInfo * const taskInfo);
void DoCompleteSuccess(TaskInfo* taskInfo, const uint32_t devId);
void PrintErrorInfo(TaskInfo *taskInfo, const uint32_t devId);

void SaveTaskInfo(TaskInfo *const taskInfo, TaskInfo *submitTask);
void SetTaskTag(TaskInfo *taskInfo);
void TaskCommonInfoInit(TaskInfo *taskInfo);
bool IsSupportType(const uint16_t sqeType);
bool IsDvppTask(const uint16_t sqeType);
bool IsLogicCqInvalid(const uint8_t errorType);
uint32_t GetProfTaskId(const TaskInfo * const taskInfo);
uint32_t GetTaskId(const TaskInfo* const taskInfo);
int32_t GetTaskIdBitWidth();
const char_t* TaskIdDesc();
const char_t* TaskIdCamelbackNaming();
void PrintStarsCqeInfo(const rtLogicCqReport_t &cqe, const uint32_t devId, const uint32_t cqId);
void GetBinAndKernelNameExceptionArgs(const Kernel * const kernel, rtExceptionArgsInfo_t *argsInfo);
void GetKernelExceptionDfxInfo(const Kernel * const kernel, const rtArgsSizeInfo_t * const sizeInfo,
    void * const args, const uint32_t argsSize, rtExceptionArgsInfo_t * const argsInfo);
}
}
#endif  // CCE_RUNTIME_TASK_INFO_HPP
