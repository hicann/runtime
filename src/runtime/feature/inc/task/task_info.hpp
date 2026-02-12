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
#include "dev.h"
#include "rt_model.h"
#include "task_info_struct.hpp"
#include "task_info_struct_cond.hpp"
#include "event.h"

namespace cce {
namespace runtime {

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
    uint16_t liteTaskResId;
    uint16_t mte_error;
    uint16_t id;
    uint16_t flipNum;
    uint8_t profEn;

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
    uint8_t resv : 5;
    uint8_t sqeNum : 7;
    uint8_t needPostProc : 1;
    /*-------------------------tmp begine---------------------------------------*/
    // DavinciMultiTaskInfo、PCTraceTaskInfo:
    std::shared_ptr<PCTrace> pcTrace;
    /*-------------------------tmp end---------------------------------------*/
    union {
        AicTaskInfo aicTaskInfo;
        AicpuTaskInfo aicpuTaskInfo;
        DavinciMultiTaskInfo davinciMultiTaskInfo;
        MemcpyAsyncTaskInfo memcpyAsyncTaskInfo;
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
        AllocDsaAddrInfoTaskInfo allocDsaAddrTask;
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
TaskInfo *GetRealReportFaultTaskForModelExecuteTask(TaskInfo* const taskInfo);
void PushBackErrInfo(TaskInfo* taskInfo, const void *errInfo, uint32_t len);
void TaskFailCallBack(const uint32_t streamId, const uint32_t taskId,
                    const uint32_t threadId, const uint32_t retCode,
                    const Device * const dev);
void RegTaskFunc(void);
void TaskUnInitProc(TaskInfo *taskInfo);
void SetResult(TaskInfo* taskInfo, const void *const data, const uint32_t dataSize);
void SetStarsResult(TaskInfo *taskInfo, const rtLogicCqReport_t &logicCq);
rtError_t WaitAsyncCopyComplete(TaskInfo* taskInfo);

void UpdateFlipNum(TaskInfo *taskInfo, const bool isDisableThread);
void InitByStream(TaskInfo *const taskInfo, Stream *stream);
void ShowTaskResult(TaskInfo* taskInfo, const uint32_t devId);

void SetPcTrace(TaskInfo *taskInfo, std::shared_ptr<PCTrace> pcTracePtr);
inline void SetAicoreArgs(TaskInfo *taskInfo, const void * const dataArgs, const uint32_t dataArgsSize,
    const void * const descData, const uint32_t memorySize, void *const dataArgHandle)
{
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);

    aicTaskInfo->comm.args = const_cast<void*>(dataArgs);
    aicTaskInfo->comm.argsSize = dataArgsSize;
    aicTaskInfo->comm.argHandle = dataArgHandle;
    aicTaskInfo->smDescData = RtPtrToValue(descData);
    aicTaskInfo->smSize = memorySize;
}

inline void SetAicpuArgs(TaskInfo *taskInfo, const void * const dataArgs, const uint32_t dataArgsSize,
    void *const dataArgHandle)
{
    AicpuTaskInfo *aicpuTaskInfo = &(taskInfo->u.aicpuTaskInfo);

    aicpuTaskInfo->comm.args = const_cast<void *>(dataArgs);
    aicpuTaskInfo->comm.argsSize = dataArgsSize;
    aicpuTaskInfo->comm.argHandle = dataArgHandle;
}

inline void SetArgs(TaskInfo *taskInfo, const void * const dataArgs, const uint32_t dataArgsSize,
             const void * const descData, const uint32_t memorySize, void *const dataArgHandle)
{
    const tsTaskType_t tskType = taskInfo->type;
    if ((tskType == TS_TASK_TYPE_KERNEL_AICORE) || (tskType == TS_TASK_TYPE_KERNEL_AIVEC)) {
        SetAicoreArgs(taskInfo, dataArgs, dataArgsSize, descData, memorySize, dataArgHandle);
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
void ResetCmdList(TaskInfo* taskInfo);
void TaskTriggerEvent(TaskInfo * const taskInfo);
rtError_t FillKernelLaunchPara(const rtKernelLaunchNames_t * const launchNames,
                               TaskInfo* taskInfo, ArgLoader * const devArgLdr);
void AicpuTaskInit(TaskInfo *taskInfo, const uint16_t dimNum, const uint32_t flag);
void AicTaskInit(TaskInfo *taskInfo, const uint32_t mach,
                 const uint16_t dimNum, const uint32_t flag,
                 const TaskCfg * const taskcfg, const bool isNeedAllocSqeDevBuf = false);
void AicTaskInitV2(TaskInfo *taskInfo, const uint32_t mach,
    const uint16_t dimNum, const uint32_t flag,
    const LaunchTaskCfgInfo_t * const launchTaskCfg);
rtError_t CheckMixKernelValid(const uint8_t mixType, const uint64_t func2);

rtError_t DavinciMultipleTaskInit(TaskInfo* taskInfo, const void *const multipleTaskInfo, const uint32_t flag);
void TransDavinciTaskToVectorCore(const uint32_t flags, uint64_t addr2, uint64_t &addr1,
    uint8_t &mixType, uint32_t &kernelType, const bool isLaunchVec);
rtError_t MemcpyAsyncTaskInitV1(TaskInfo * const taskInfo, void *memcpyAddrInfo, const uint64_t cpySize);
rtError_t MemcpyAsyncTaskInitV2(TaskInfo * const taskInfo, void *const dst, const uint64_t dstPitch,
                                const void *const srcAddr, const uint64_t srcPitch, const uint64_t width,
                                const uint64_t height, const uint32_t kind, const uint64_t fixedSize);
rtError_t MemcpyAsyncTaskInitV3(TaskInfo * const taskInfo, uint32_t cpyType, const void *srcAddr,
    void *desAddr, const uint64_t cpySize, const rtTaskCfgInfo_t *cfgInfo, const rtD2DAddrCfgInfo_t * const addrCfg);
rtError_t MemcpyAsyncD2HTaskInit(TaskInfo * const taskInfo, const void *srcAddr, const uint64_t cpySize,
                                 uint32_t sqId, uint32_t pos);
rtError_t ReduceAsyncV2TaskInit(TaskInfo * const taskInfo, uint32_t cpyType, const void *srcAddr,
     void *desAddr, const uint64_t cpySize, void * const overflowAddr);
rtError_t UpdateEventTimeLine(TaskInfo * const taskInfo, const Event *const eventPtr);
rtError_t EventRecordTaskInit(TaskInfo * const taskInfo, Event *const eventPtr, const bool isNotifyRecordFlag,
                              const int32_t newEventId);
rtError_t EventResetTaskInit(TaskInfo * const taskInfo, Event *const eventPtr,
                             const bool isNotifyFlag, const int32_t eventIndex);
rtError_t RemoteEventWaitTaskInit(TaskInfo * const taskInfo, Event *const eventRec,
                                  const int32_t srcDeviceId, const int32_t eventIndex);
rtError_t EventWaitTaskInit(TaskInfo * const taskInfo, Event *const eventRec, const int32_t eventIndex,
                            const uint32_t timeout, const uint8_t waitFlag = 0U);
rtError_t MaintenanceTaskInit(TaskInfo * const taskInfo, const MtType type, const uint32_t id,
                              bool flag, const uint32_t idType = UINT32_MAX);
rtError_t CreateStreamTaskInit(TaskInfo * const taskInfo, const uint32_t flag);
rtError_t CreateL2AddrTaskInit(TaskInfo * const taskInfo, const uint64_t ptePtrAddr);
rtError_t KernelFusionTaskInit(TaskInfo * const taskInfo, const FusionFlag fusFlag);
rtError_t DynamicProfilingEnableTaskInit(TaskInfo * const taskInfo, const uint64_t processId,
    const rtProfCfg_t *const profCfg);
rtError_t DynamicProfilingDisableTaskInit(TaskInfo * const taskInfo, const uint64_t processId,
    const rtProfCfg_t *const profCfg);
rtError_t ProfilingEnableTaskInit(TaskInfo * const taskInfo, const uint64_t processId,
    const rtProfCfg_t *const profCfg);
rtError_t ProfilingDisableTaskInit(TaskInfo * const taskInfo, const uint64_t processId,
    const rtProfCfg_t *const profCfg);
rtError_t OnlineProfEnableTaskInit(TaskInfo * const taskInfo, const uint64_t onlineProfilingAddr);
rtError_t OnlineProfDisableTaskInit(TaskInfo * const taskInfo, const uint64_t onlineProfilingAddr);
rtError_t AdcProfTaskInit(TaskInfo * const taskInfo, const uint64_t address, const uint32_t len);
rtError_t PCTraceTaskInit(TaskInfo * const taskInfo, const uint16_t enableTaskIndex,
                          const uint16_t coreDims, std::shared_ptr<PCTrace> pcTracePtr);
rtError_t ModelMaintainceTaskInit(TaskInfo * const taskInfo, const MmtType mType,
                                  Model *const modelPtr, Stream *const opStreamPtr,
                                  const rtModelStreamType_t modelStreamType,
                                  const uint32_t firstTaskIndex);
rtError_t DavidModelMaintainceTaskInit(TaskInfo * const taskInfo, const MmtType mType,
    Model *const modelPtr, Stream *const opStreamPtr, const rtModelStreamType_t modelStreamType,
    const uint32_t firstTaskIndex);
rtError_t ModelExecuteTaskInit(TaskInfo * const taskInfo, Model *const modelPtr, const uint32_t modelIndex,
                               const uint32_t firstTaskIndex);
// task init func
rtError_t DebugUnRegisterForStreamTaskInit(TaskInfo* taskInfo, const uint32_t stmId);
rtError_t AddEndGraphTaskInit(TaskInfo* taskInfo, const uint32_t modelId, const uint32_t exeFlag,
                              const uint64_t argParam, const uint64_t endGraphName,
                              const uint8_t flags);
rtError_t AddModelExitTaskInit(TaskInfo* taskInfo, const uint32_t modelId);
rtError_t ModelToAicpuTaskInit(TaskInfo* taskInfo, const uint32_t modelIndex, const uint32_t controlType,
                               const uint32_t exeFlag, const uint64_t modelPtr);
rtError_t ActiveAicpuStreamTaskInit(TaskInfo* taskInfo, const uint64_t argsParam, const uint32_t argsSizeLen,
                                    const uint64_t func, const uint32_t kernelTypeId);
rtError_t CallbackLaunchTaskInit(TaskInfo* taskInfo, const rtCallback_t callBackFunction, void *const functionData,
                                 const bool isBlockFlag, const int32_t evtId);
rtError_t StreamLabelSwitchByIndexTaskInit(TaskInfo* taskInfo, void * const idPtr, const uint32_t maxIndex,
                                           void * const labelPtr);
rtError_t StreamLabelGotoTaskInit(TaskInfo* taskInfo, const uint16_t lblId);
rtError_t NpuGetFloatStaTaskInit(TaskInfo *taskInfo, void * const outputAddrPtr,
                                 const uint64_t outputSize, const uint32_t checkMode,
                                 bool debugFlag = false);
rtError_t NpuClrFloatStaTaskInit(TaskInfo *taskInfo, const uint32_t checkMode, bool debugFlag = false);
rtError_t OverflowSwitchSetTaskInit(TaskInfo *taskInfo, Stream * const stm, const uint32_t flags);
rtError_t StreamTagSetTaskInit(TaskInfo *taskInfo, Stream * const stm, const uint32_t geOpTag);
rtError_t RingBufferMaintainTaskInit(TaskInfo *taskInfo, const void *const addr, const bool delFlag, const uint32_t len);
rtError_t WriteValueTaskInit(TaskInfo *taskInfo, uint64_t addr, WriteValueSize size,
                             uint8_t *value, TaskWrCqeFlag cqeFlag);
rtError_t WriteValuePtrTaskInit(TaskInfo *taskInfo, const void * const pointedAddr, TaskWrCqeFlag cqeFlag);
rtError_t CmoTaskInit(TaskInfo *taskInfo, const rtCmoTaskInfo_t *const cmoTaskInfo, const Stream * const stm,
                      const uint32_t flag);
void CcuLaunchTaskInit(TaskInfo *taskInfo, rtCcuTaskInfo_t *const ccuInfo);
rtError_t CmoAddrTaskInit(TaskInfo *taskInfo, void *cmoAddrInfo, const rtCmoOpCode_t cmoOpCode);
rtError_t BarrierTaskInit(TaskInfo *taskInfo, const rtBarrierTaskInfo_t *const barrierTaskInfo, const Stream *const stm,
                          const uint32_t flag);
rtError_t SetStreamModeTaskInit(TaskInfo *taskInfo, const uint64_t mode);
void CommonCmdTaskInit(TaskInfo * const taskInfo, const PhCmdType cmdType, const CommonCmdTaskInfo *cmdInfo);

rtError_t NotifyRecordTaskInit(TaskInfo *taskInfo, const uint32_t notifyIndex, const int32_t deviceIndex,
                               const uint32_t phyIndex,
                               const SingleBitNotifyRecordInfo * const singleInfo,
                               const rtCntNtyRecordInfo_t * const countInfo,
                               void * const notify, bool isCountNotify = false);
rtError_t NotifyWaitTaskInit(TaskInfo *taskInfo, const uint32_t notifyIndex, const uint32_t timeOutNum,
    const CountNotifyWaitInfo * const cntNtfyInfo, void * const inNotify, const bool isCountNotify = false);
rtError_t NotifyResetTaskInit(TaskInfo *taskInfo, const uint32_t notifyIndex,
    const SingleBitNotifyRecordInfo * const singleInfo, void * const notify);
rtError_t StreamSwitchTaskInitV1(TaskInfo *taskInfo, const void *const ptrAddr,
    const rtCondition_t condi, const int64_t valueNum, const Stream * const trueStream);
rtError_t StreamSwitchTaskInitV2(TaskInfo *taskInfo, const void *const ptrAddr,
    const rtCondition_t condi, const Stream * const trueStream,
    const void *const valPtr, const rtSwitchDataType_t taskDataType);
rtError_t StreamSwitchNTaskInit(TaskInfo *taskInfo, const void *const ptrAddr, const uint32_t ptrSize,
    const void *const valPtr, const void *const trueStream,
    const uint32_t eleSize, const rtSwitchDataType_t taskDataType);
rtError_t StreamActiveTaskInit(TaskInfo* taskInfo, const Stream * const stm);
rtError_t LabelSetTaskInit(TaskInfo* taskInfo, const uint16_t labelIndex, void * const devDestAddr);
rtError_t LabelSwitchTaskInit(TaskInfo* taskInfo, const void *const ptr, const rtCondition_t cond,
    const uint32_t val, const uint16_t labelId);
rtError_t LabelGotoTaskInit(TaskInfo* taskInfo, const uint16_t lblId);
rtError_t ProfilerTraceTaskInit(TaskInfo* taskInfo, const uint64_t id, const bool notifyFlag, const uint32_t flags);
rtError_t ProfilerTraceExTaskInit(TaskInfo* taskInfo, const uint64_t id, const uint64_t mdlId, const uint16_t tag);
rtError_t FusionDumpAddrSetTaskInit(TaskInfo* taskInfo, const uint16_t modelIndex, const void *const address,
    const uint32_t dumpDataSize, const uint32_t fusionFlag);
rtError_t DataDumpLoadInfoTaskInit(TaskInfo* taskInfo, const void *const dumpInfoPtr,
    const uint32_t len, const uint16_t kernelType);
rtError_t AicpuInfoLoadTaskInit(TaskInfo* taskInfo, const void *const aicpuInfo, const uint32_t len);
rtError_t DebugRegisterTaskInit(TaskInfo* taskInfo, const uint32_t mdlId, const void *const address,
    const uint32_t curFlag);
rtError_t DebugUnRegisterTaskInit(TaskInfo* taskInfo, const uint32_t mdlId);
rtError_t TimeoutSetTaskInit(TaskInfo* taskInfo, const rtTaskTimeoutType_t type, const uint32_t timeout);
rtError_t GetDevMsgTaskInit(TaskInfo* taskInfo, const void *const devMemAddr,
    const uint32_t devMemSize, const rtGetDevMsgType_t messageType);
rtError_t DebugRegisterForStreamTaskInit(TaskInfo* taskInfo, const uint32_t stmId, const void *const address,
    const uint32_t curFlag);
uint32_t CovertToFlipTaskId(const int32_t streamId, const uint32_t taskId, const Device * const dev);
uint32_t CovertToFlipTaskId(const TaskInfo* const taskInfo, const uint32_t taskId);
void FlipTaskInit(TaskInfo* taskInfo, const uint16_t flipNum);
void GetExceptionArgs(TaskInfo* taskInfo, rtExceptionArgsInfo_t *argsInfo);

// others
uint32_t GetSqeNumForMemcopyAsync(const rtMemcpyKind_t kind, bool isModelByUb = false, uint32_t cpyType = UINT32_MAX);
rtError_t ConvertD2DCpyType(const Stream * const stm, uint32_t &cpyType, const void *const srcAddr, void *const desAddr);
void TimeoutSetTaskInitV1(TaskInfo* taskInfo);
void TimeoutSetTaskUpdate(TaskInfo* taskInfo, const rtTaskTimeoutType_t type, const uint32_t timeout);
void RecycleTaskResourceForMemcpyAsyncTask(TaskInfo * const taskInfo);
uint8_t GetMultipleTaskCqeNum(TaskInfo * const taskInfo);
void DecMultipleTaskCqeNum(TaskInfo *taskInfo);
void SetMultipleTaskCqeErrorInfo(TaskInfo *taskInfo, uint8_t sqeType, uint8_t errorType, uint32_t errorCode);
void GetMultipleTaskCqeErrorInfo(TaskInfo * const taskInfo, volatile uint8_t &sqeType,
    volatile uint8_t &errorType, volatile uint32_t &errorCode);
void SetSqPos(TaskInfo* taskInfo, const uint32_t pos);

void DoCompleteSuccess(TaskInfo* taskInfo, const uint32_t devId);
rtError_t WaitExecFinishForModelExecuteTask(const TaskInfo *const taskInfo);
void PreCheckTaskErr(TaskInfo* taskInfo, const uint32_t devId);
void PrintErrorInfo(TaskInfo *taskInfo, const uint32_t devId);
uint8_t ReduceOpcodeHigh(TaskInfo * const taskInfo);
rtError_t InitFuncCallParaForStreamActiveTask(TaskInfo* taskInfo, rtStarsStreamActiveFcPara_t &fcPara,
    const rtChipType_t chipType);
void IncMultipleTaskCqeNum(TaskInfo *taskInfo);
void ParseExtendInfo(TaskInfo* taskInfo, const char_t *const extInfos, const uint64_t extInfoLen,
    const uint64_t extInfoStructLen, std::string &extendInfo);

void SaveTaskInfo(TaskInfo *const taskInfo, TaskInfo *submitTask);
rtError_t GetArgsInfo(TaskInfo* taskInfo);
rtError_t GetMixCtxInfo(TaskInfo* taskInfo);
rtError_t InitFuncCallParaForStreamSwitchTaskV2(TaskInfo* taskInfo, rtStarsStreamSwitchExFcPara_t &fcPara,
    const rtChipType_t chipType);
rtError_t InitFuncCallParaForStreamSwitchTaskV1(TaskInfo* taskInfo, rtStarsStreamSwitchFcPara_t &fcPara,
    const rtChipType_t chipType);
void SetTaskTag(TaskInfo *taskInfo);
rtError_t AllocDsaAddrTaskInit(TaskInfo * const taskInfo, const uint16_t sqId);
rtError_t StarsVersionTaskInit(TaskInfo * const taskInfo);
void SetStarsResultForStarsVersionTask(TaskInfo* taskInfo, const rtLogicCqReport_t &logicCq);
void DoCompleteSuccessForStarsVersionTask(TaskInfo* taskInfo, const uint32_t devId);
void TryToFreeEventIdAndDestroyEvent(Event **eventPtr, int32_t freeId, bool isNeedDestroy, bool isCaptureDestroy = false);
void IpcEventDestroy(IpcEvent **eventPtr, int32_t freeId, bool isNeedDestroy);
rtError_t DestroyEventSync(Event *evt);
rtError_t SqLockUnlockTaskInit(TaskInfo* taskInfo, const bool isLock);
rtError_t NopTaskInit(TaskInfo* taskInfo);
rtError_t UpdateAddressTaskInit(TaskInfo* taskInfo, uint64_t devAddr, uint64_t len);
uint32_t GetSendSqeNumForDavinciMultipleTask(const TaskInfo * const taskInfo);
bool IsPcieDma(const uint32_t copyTypeFlag);
uint8_t GetOpcodeForReduce(TaskInfo * const taskInfo);
uint8_t ReduceOpcodeLow(TaskInfo * const taskInfo);
void TaskCommonInfoInit(TaskInfo *taskInfo);
bool IsSupportType(const uint16_t sqeType);
uint16_t GetAICpuQos(const TaskInfo * const taskInfo);
uint32_t GetSendSqeNumForDirectWqeTask(const TaskInfo * const taskInfo);
uint32_t GetSendSqeNumForAsyncDmaTask(const TaskInfo * const taskInfo);
rtError_t UbDbSendTaskInit(TaskInfo *taskInfo, const rtUbDbInfo_t *dbInfo);
void UbDirectSendTaskInit(TaskInfo *taskInfo, rtUbWqeInfo_t *wqeInfo);
bool IsDavidUbDma(const uint32_t copyTypeFlag);
rtError_t ModelTaskUpdateInit(TaskInfo *taskInfo, uint16_t desStreamId, uint32_t destaskId, uint16_t exeStreamId,
                              void *devCopyMem, uint32_t tilingTabLen, rtMdlTaskUpdateInfo_t *para);
rtError_t PrepareSqeInfoForModelExecuteTask(TaskInfo * const taskInfo);
rtError_t FreeFuncCallHostMemAndSvmMem(TaskInfo * const taskInfo);
void ReportErrorInfoForModelExecuteTask(TaskInfo * const taskInfo, const uint32_t devId);
void ReportModelEndGraphErrorForNotifyWaitTask(TaskInfo *taskInfo, const uint32_t devId);
bool IsDvppTask(const uint16_t sqeType);
uint32_t GetProfTaskId(const TaskInfo * const taskInfo);
int32_t GetTaskIdBitWidth();
const char_t* TaskIdDesc();
const char_t* TaskIdCamelbackNaming();
void PrintStarsCqeInfo(const rtLogicCqReport_t &cqe, const uint32_t devId, const uint32_t cqId);
void GetBinAndKernelNameExceptionArgs(const Kernel * const kernel, rtExceptionArgsInfo_t *argsInfo);
void GetKernelExceptionDfxInfo(const Kernel * const kernel, const rtArgsSizeInfo_t * const sizeInfo,
    void * const args, const uint32_t argsSize, rtExceptionArgsInfo_t * const argsInfo);
template<typename T>
rtError_t StarsCommonTaskInit(TaskInfo* taskInfo, const T &sqe, const uint32_t flag)
{
    TaskCommonInfoInit(taskInfo);

    StarsCommonTaskInfo *starsCommTask = &taskInfo->u.starsCommTask;

    taskInfo->typeName = const_cast<char_t*>("STARS_COMMON");
    taskInfo->type = TS_TASK_TYPE_STARS_COMMON;
    starsCommTask->flag = RT_KERNEL_DEFAULT;
    starsCommTask->cmdList = nullptr;
    starsCommTask->errorTimes = 0U;
    starsCommTask->srcDevAddr = nullptr;

    const uint16_t sqeType = sqe.sqeHeader.type;
    if (!IsSupportType(sqeType)) {
        RT_LOG(RT_LOG_ERROR, "StarsCommonTask not support type[%hu]", sqeType);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    starsCommTask->flag = flag;
    const errno_t error = memcpy_s(&starsCommTask->commonStarsSqe.commonSqe,
        sizeof(starsCommTask->commonStarsSqe.commonSqe), &sqe, sizeof(sqe));
    if (error != EOK) {
        RT_LOG(RT_LOG_ERROR, "copy to starsSqe failed,ret=%d,src size=%zu,dst size=%zu",
               error, sizeof(sqe), sizeof(starsCommTask->commonStarsSqe.commonSqe));
        return RT_ERROR_SEC_HANDLE;
    }

    if (!IsDvppTask(sqeType)) {
        return RT_ERROR_NONE;
    }

    const uint64_t cmdListAddrLow =
        starsCommTask->commonStarsSqe.commonSqe.commandCustom[STARS_DVPP_SQE_CMDLIST_ADDR_LOW_IDX];
    const uint64_t cmdListAddrHigh =
        starsCommTask->commonStarsSqe.commonSqe.commandCustom[STARS_DVPP_SQE_CMDLIST_ADDR_HIGH_IDX];
    // the dvpp has malloced the cmdlist memory.
    starsCommTask->cmdList = RtValueToPtr<void *>(((cmdListAddrHigh << UINT32_BIT_NUM) & 0xFFFFFFFF00000000ULL) |
        (cmdListAddrLow & 0x00000000FFFFFFFFULL));
    if (starsCommTask->cmdList == nullptr) {
        RT_LOG(RT_LOG_ERROR, "cmdList addr is null.");
        return RT_ERROR_INVALID_VALUE ;
    }
    if ((starsCommTask->flag & RT_KERNEL_CMDLIST_NOT_FREE) == 0U) {
        taskInfo->needPostProc = true;
    }

    RT_LOG(RT_LOG_INFO, "dvpp type=%hu,need to write value=%u, needPostProc=%u.", sqeType, sqe.sqeHeader.reserved, taskInfo->needPostProc);
    return RT_ERROR_NONE;
}
}
}
#endif  // CCE_RUNTIME_TASK_INFO_HPP