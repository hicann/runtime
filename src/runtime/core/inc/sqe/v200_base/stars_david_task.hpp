/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_STARS_DAVID_TASK_HPP
#define CCE_RUNTIME_STARS_DAVID_TASK_HPP

#include <cstdint>
#include <string>
#include <unordered_map>
#include "task_info.hpp"
#include "runtime_task_manager.h"

namespace cce {
namespace runtime {

struct RtDavidStarsWriteValueSqe;
struct RtDavidStarsAicAivKernelSqe;
struct RtDavidStarsAicpuKernelSqe;
struct RtDavidStarsAicpuControlSqe;
struct RtDavidStarsMemcpySqe;
struct DavidStarsAicpuKernelUserData;
union rtDavidSqe_t;
enum class DavidTaskMapType : std::uint8_t;

uint32_t GetSendDavidSqeNum(const TaskInfo* const taskInfo);
uint8_t GetHeadUpdateFlag(const uint64_t allocTimes);
bool IsNeedRetryTask(const uint16_t sqeType);

const char_t* GetNotifySubType(const uint16_t subType);
void InitWriteValueSqe(RtDavidStarsWriteValueSqe* const writeValueSqe, const rtWriteValueInfo_t* const writeValueInfo);
void AicpuMsgVersionTaskInit(TaskInfo* taskInfo);
void SetStarsResultCommonForDavid(TaskInfo* const taskInfo, const rtCqReport_t& logicCq);

rtError_t GetLaunchConfigAttr(rtLaunchAttribute_t* attr, LaunchTaskCfgInfo_t* launchTaskCfg);
rtError_t GetLaunchConfigInfo(const rtLaunchConfig_t* const launchConfig, LaunchTaskCfgInfo_t* launchTaskCfg);

rtError_t DavidEventRecordTaskInit(TaskInfo* const taskInfo, Event* const eventPtr, const int32_t newEventId);
void DavidEventWaitTaskInit(
    TaskInfo* const taskInfo, Event* const eventPtr, const int32_t eventIndex, const uint32_t timeout);
void DavidEventResetTaskInit(TaskInfo* const taskInfo, Event* const eventPtr, const int32_t eventIndex);
void DavidEventRecordTaskUnInit(TaskInfo* const taskInfo);
void DavidEventWaitTaskUnInit(TaskInfo* const taskInfo);
void DavidEventResetTaskUnInit(TaskInfo* const taskInfo);
void DavidMemWaitTaskUnInit(TaskInfo* taskInfo);
void DavidUpdateAndTryToDestroyEvent(TaskInfo* taskInfo, Event** eventPtr, DavidTaskMapType taskMapType);
void DoCompleteSuccessForDavidEventRecordTask(TaskInfo* const taskInfo, const uint32_t devId);
void DoCompleteSuccessForDavidEventWaitTask(TaskInfo* const taskInfo, const uint32_t devId);
void DoCompleteSuccessForDavidEventResetTask(TaskInfo* const taskInfo, const uint32_t devId);
void SetStarsResultForDavidEventRecordTask(TaskInfo* const taskInfo, const rtCqReport_t& logicCq);
void StarsV2SetStarsResultForDavinciTask(TaskInfo* taskInfo, const rtCqReport_t& logicCq);
uint32_t GetStarsV2VectorErrorCode(const rtCqReport_t& logicCq);
uint32_t GetStarsV2AicpuErrorCode(const rtCqReport_t& logicCq);
uint32_t GetStarsV2AicoreErrorCode(const rtCqReport_t& logicCq);
void ConstructDavidAicAivSqeForDavinciTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void StarsV2DavinciTaskUnInit(TaskInfo* taskInfo);
void StarsV2DoCompleteSuccessForDavinciTask(TaskInfo* taskInfo, const uint32_t devId);
void PrintErrorInfoForDavidEventWaitTask(TaskInfo* const taskInfo, const uint32_t devId);
rtDavidSqe_t* GetSqPosAddr(const uint64_t sqBaseAddr, const uint32_t pos);
void ConstructDavidSqeForHeadCommon(const TaskInfo* const taskInfo, rtDavidSqe_t* const sqe);
void ConstructDavidSqeBase(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructDavidAICpuSqeForDavinciTaskBase(
    TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe, uint64_t sqBaseAddr);
void ConstructDavidAICpuSqeForDavinciTaskResFieldPart(
    DavidStarsAicpuKernelUserData* const usrData, const uint64_t addr, const uint8_t kernelFlag,
    const Stream* const stm);
void FillTopicType(RtDavidStarsAicpuKernelSqe* const sqe, const uint32_t kernelFlag);
void ConstructDavidAICpuSqeForDavinciTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructDavidSqeForCmoTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
using CmoSqeConstructor = void (*)(TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe, uint64_t sqBaseAddr);
void ConstructDavidSqeForCmoTaskCommon(
    TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo, CmoSqeConstructor cmoSqeConstructor);
void ConstructDavidSqeForProfilingEnableTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructDavidSqeForProfilingDisableTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructDavidSqeForProfilerTraceExTask(TaskInfo* taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructDavidSqeForMemcpyAsyncTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructDavidSqeForMemsetAsyncTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructDavidAsyncUbDbSqe(TaskInfo* const taskInfo, rtDavidSqe_t* const command);
void StarsV2MemcpyAsyncTaskUnInit(TaskInfo* const taskInfo);
void StarsV2DoCompleteSuccessForMemcpyAsyncTask(TaskInfo* const taskInfo, const uint32_t devId);
rtError_t UbDbSendTaskInit(TaskInfo* taskInfo, const rtUbDbInfo_t* dbInfo, const uint16_t source);
void PrintErrorInfoForUbDbSendTask(TaskInfo* taskInfo, const uint32_t devId);
void DoCompleteSuccessForUbDmaDbModeTask(TaskInfo* taskInfo, const uint32_t devId);
void UbDirectSendTaskInit(TaskInfo* taskInfo, rtUbWqeInfo_t* wqeInfo);
void PrintErrorInfoForUbDirectSendTask(TaskInfo* taskInfo, const uint32_t devId);
void DoCompleteSuccessForUbDmaDirectWqeModeTask(TaskInfo* taskInfo, const uint32_t devId);
uint32_t GetSendSqeNumForDirectWqeTask(const TaskInfo* const taskInfo);
void ConstructDavidSqeForLabelSetTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructDavidSqeForStreamActiveTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructDavidSqeForOverflowSwitchSetTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructDavidSqeForStreamTagSetTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructDavidSqeForStreamSwitchTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructDavidSqeForStreamLabelSwitchByIndexTask(
    TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
rtError_t DavidModelMaintainceTaskInit(
    TaskInfo* const taskInfo, const MmtType mType, Model* const modelPtr, Stream* const opStreamPtr,
    const rtModelStreamType_t modelStreamType, const uint32_t firstTaskIndex);
void ConstructDavidSqeForNotifyWaitTask(TaskInfo* taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructDavidSqeForNotifyRecordTask(TaskInfo* taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructDavidSqeForStarsCommonTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructDavidSqeForTaskId(const TaskInfo* const taskInfo, rtDavidSqe_t* const sqe);
void ConstructDavidSqeForDavinciMultipleTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void StarsV2DavinciMultipleTaskUnInit(TaskInfo* taskInfo);
void ConstructSqeForIpcNotifyRecordTask(TaskInfo* taskInfo, rtDavidSqe_t* const command);
void ConstructDavidSqeForMemWaitValueTask(TaskInfo* taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructDavidSqeForCaptureConditionTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void Construct1stDavidSqeForCaptureConditionTask(TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe);
void Construct2ndDavidSqeForCaptureConditionTask(TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe);
void Construct3rdDavidSqeForCaptureConditionTask(TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe);
void ConstructDavidSqeForMemWriteValueTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void StarsV2IpcEventWaitTaskUnInit(TaskInfo* taskInfo);
void StarsV2IpcEventRecordTaskUnInit(TaskInfo* taskInfo);
void MemsetAsyncTaskInit(
    TaskInfo* const taskInfo, void* const ptr, const uint64_t destMax, const uint32_t val, const uint64_t cnt,
    const uint32_t elementSize = 1U);
rtError_t ConvertAsyncDmaForTaskUpdate(TaskInfo* const taskInfo, TaskInfo* const updateTaskInfo);
uint32_t GetSendSqeNumForAsyncDmaTask(const TaskInfo* const taskInfo);
void ConstructFirstDavidSqeForMemWaitValueTask(TaskInfo* taskInfo, rtDavidSqe_t* const davidSqe);
void ConstructSecondDavidSqeForMemWaitValueTask(
    TaskInfo* taskInfo, rtDavidSqe_t* const davidSqe, const RtStarsMemWaitValueInstrFcParaWithDynamicProf& fcPara);
void ConstructNopSqeForMemWaitValueTask(const TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe);

void InitStarsSdmaSqeForDavid(RtDavidStarsMemcpySqe* sdmaSqe, const rtTaskCfgInfo_t* const cfgInfo, const Stream* stm);
void ConstructDavidCmoSqe(TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe, uint64_t sqBaseAddr);
void ConstructDavidCmoAddrSqe(TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe, uint64_t sqBaseAddr);
void ConstructDavidCmoSdmaSqe(TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe, uint64_t sqBaseAddr);
void ConstructDavidMemcpySqe(TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe, uint64_t sqBaseAddr);

void PrintErrorInfoForDavidCmoTask(TaskInfo* taskInfo, const uint32_t devId);
void UpdateDavidAICoreSqeForDavinciTask(TaskInfo* taskInfo, RtDavidStarsAicAivKernelSqe* const sqe);
void UpdateDavidAICpuKernelSqeForDavinciTask(RtDavidStarsAicpuKernelSqe* const sqe);
void UpdateDavidAICpuControlSqeForDavinciTask(RtDavidStarsAicpuControlSqe* const sqe);
void ConstructDavidSqeForCallbackLaunchTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);

rtError_t WriteValuePtrTaskInit(TaskInfo* taskInfo, Event* event, const void* const pointedAddr, TaskWrCqeFlag cqeFlag);
void ConstructDavidSqeForWriteValueTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructDavidSqeForUbDirectSendTask(TaskInfo* taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
void ConstructDavidSqeForUbDbSendTask(TaskInfo* taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo);
const std::unordered_map<uint32_t, std::string>& GetUbDmaTaskErrorMap();
void SetUbDmaErrorCode(TaskInfo* taskInfo, const rtCqReport_t& logicCq);
} // namespace runtime
} // namespace cce
#endif // CCE_RUNTIME_STARS_DAVID_TASK_HPP
