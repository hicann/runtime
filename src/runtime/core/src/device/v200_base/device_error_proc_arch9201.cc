/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <sstream>
#include "device_error_proc.hpp"
#include "device_error_proc_c.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "ccu_task.hpp"
#include "task_recycle.hpp"
#include "task_fail_callback_manager.hpp"

namespace cce {
namespace runtime {
// arch9201 error map is unified into g_davidErrorMapInfo (device_error_proc_c.cc).
// Only the per-chip bit mask is defined here.
// low32 = T0_0 register, high32 = T0_1 register (0 if no T0_1).
static const DavidErrorBitMask g_arch9201ErrorBitMask = {
    0x000003FF0007FFF7ULL, // cube: T0_0 bits 0-2,4-18; T0_1 bits 0-9
    0x00000000FFFFCFBFULL, // mte:  T0_0 bits 0-5,7-11, 14-31, no T0_1
    0x007FFFFF7BFFFFFFULL, // l1:   T0_0 bits 0-25,27-30; T0_1 bits 0-22
    0x000000000000000FULL, // sc:   T0_0 bits 0-3, no T0_1
    0x0000000FCDD6A7A9ULL, // su:   T0_0 bits 0,3,5,7-10,13,15,17-18,20,22-24,26-27,30-31; T0_1 bits 0-3
    0x00001FFE3EF0FFC7ULL, // vec:  T0_0 bits 0-2,6-15,20-23,25-29; T0_1 bits 1-12
};

static bool RegisterArch9201ErrorBitMask()
{
    RegDavidErrorBitMask(CHIP_CLOUD_V5, &g_arch9201ErrorBitMask);
    return true;
}

static bool g_registerArch9201ErrorBitMask = RegisterArch9201ErrorBitMask();

static void PrintArch9201CoreErrInfo(
    const StarsDeviceErrorInfo* const info, const uint64_t errorNumber, const uint32_t coreIdx,
    const std::string& errorCode)
{
    const DavidOneCoreErrorInfo& coreErrInfo = info->u.davidCoreErrorInfo.info[coreIdx];
    std::ostringstream oss;
    oss << std::showbase << std::dec << "The error from device(chipId:" << info->u.davidCoreErrorInfo.comm.chipId
        << ", dieId:" << info->u.davidCoreErrorInfo.comm.dieId << "), serial number is " << errorNumber
        << ". There is an " << GetStarsRingBufferHeadMsg(info->u.davidCoreErrorInfo.comm.type).c_str()
        << " exception , core id is " << coreErrInfo.coreId << ", error code = " << errorCode.c_str()
        << ", dump info: pc start: " << std::hex << coreErrInfo.pcStart << ", current:" << coreErrInfo.currentPC
        << ", sc error info: " << coreErrInfo.scErrInfo << ", su error info: " << coreErrInfo.suErrInfo[0] << ","
        << coreErrInfo.suErrInfo[1] << "," << coreErrInfo.suErrInfo[2] << "," << coreErrInfo.suErrInfo[3]
        << ", mte error info: " << coreErrInfo.mteErrInfo[0] << ", vec error info: " << coreErrInfo.vecErrInfo[0]
        << ", cube error info: " << coreErrInfo.cubeErrInfo << ", l1 error info: " << coreErrInfo.l1ErrInfo
        << ", aic error mask: " << coreErrInfo.aicErrorMask << ", para base: " << coreErrInfo.paraBase
        << ", first pc start: " << coreErrInfo.ostTaskOneCore[0].pcStart << std::dec
        << ", first taskid: " << coreErrInfo.ostTaskOneCore[0].taskId
        << ", first streamid: " << coreErrInfo.ostTaskOneCore[0].streamId;
    if (coreErrInfo.ostTaskOneCore[1].pcStart != 0) {
        oss << std::showbase << std::hex << ", second pc start: " << coreErrInfo.ostTaskOneCore[1].pcStart << std::dec
            << ", second taskid: " << coreErrInfo.ostTaskOneCore[1].taskId
            << ", second streamid: " << coreErrInfo.ostTaskOneCore[1].streamId
            << ", isconcurrentexe: " << coreErrInfo.isConcurrentExe << ".";
    } else {
        oss << ".";
    }
    RT_LOG_CALL_MSG(ERR_MODULE_TBE, "%s", oss.str().c_str());
}

static rtFusionExType_t GetFusionTaskDetailType(uint8_t fusionSubType)
{
    const uint8_t fusionCcuBit = 0x18; // subType中b'11000(0x18)中的3/4bit表示fusion中有ccu任务
    rtFusionExType_t fusionDetailType;

    if ((fusionSubType & fusionCcuBit) != 0) {
        fusionDetailType = RT_FUSION_AICORE_CCU;
    } else {
        fusionDetailType = RT_FUSION_AICORE_AICPU;
    }
    return fusionDetailType;
}

static void DavidUpdateAicTaskKernel(
    TaskInfo* errTaskPtr, const DavidOneCoreErrorInfo* const info, const uint16_t streamId, const uint16_t taskId)
{
    if (errTaskPtr->u.aicTaskInfo.kernel == nullptr) {
        AicTaskInfo* aicTask = &errTaskPtr->u.aicTaskInfo;
        RT_LOG(
            RT_LOG_ERROR, "stream_id=%u, task_id=%u not with kernel info, tilingKey=0x%llx.", streamId, taskId,
            aicTask->tilingKey);
        if (aicTask->progHandle != nullptr) {
            aicTask->kernel = aicTask->progHandle->SearchKernelByPcAddr(info->pcStart);
        }
    }
}

static void DavidOstTaskFailCallBack(
    const Device* const dev, const TaskInfo* errTaskPtr, const uint16_t streamId, const uint16_t taskId)
{
    if (errTaskPtr->type == TS_TASK_TYPE_KERNEL_AIVEC) {
        TaskFailCallBack(
            streamId, taskId, errTaskPtr->tid, TS_ERROR_VECTOR_CORE_EXCEPTION, errTaskPtr->stream->Device_());
    } else if (errTaskPtr->type == TS_TASK_TYPE_KERNEL_AICORE) {
        TaskFailCallBack(streamId, taskId, errTaskPtr->tid, TS_ERROR_AICORE_EXCEPTION, errTaskPtr->stream->Device_());
    } else if (errTaskPtr->type == TS_TASK_TYPE_FUSION_KERNEL) {
        rtFusionExType_t fusionDetailType = GetFusionTaskDetailType(errTaskPtr->u.fusionKernelTask.sqeSubType);
        TaskFailCallBackForFusionKernelTask(errTaskPtr, dev->Id_(), nullptr, fusionDetailType);
    }
}

static void DavidOstTaskErrorProc(
    const Device* const dev, const DavidOneCoreErrorInfo* const info, std::unordered_set<uint32_t>* allSTaskId)
{
    for (uint32_t taskIdx = 0; taskIdx < MAX_TASK_NUM_ONE_CORE; taskIdx++) {
        /* pc start 为0表示该组信息无效 */
        if (info->ostTaskOneCore[taskIdx].pcStart == 0ULL) {
            continue;
        }
        const uint16_t streamId = info->ostTaskOneCore[taskIdx].streamId;
        const uint16_t taskId = info->ostTaskOneCore[taskIdx].taskId;
        const uint32_t formatSTaskId = ((streamId << 16) | taskId); // streamId和taskId组合成一个32位的值用于去重
        if (allSTaskId->find(formatSTaskId) != allSTaskId->end()) {
            continue;
        }
        allSTaskId->insert(formatSTaskId);

        TaskInfo* errTaskPtr = GetTaskInfo(dev, streamId, taskId);
        if (errTaskPtr == nullptr) {
            RT_LOG(
                RT_LOG_WARNING, "GetTask error, device_id=%u, stream_id=%u, task_id=%u.", dev->Id_(), streamId, taskId);
            continue;
        }

        DavidUpdateAicTaskKernel(errTaskPtr, info, streamId, taskId);
        DavidOstTaskFailCallBack(dev, errTaskPtr, streamId, taskId);
    }
}

static rtError_t ProcessArch9201StarsCoreErrorInfo(
    const StarsDeviceErrorInfo* const info, const uint64_t errorNumber, const Device* const dev,
    const DeviceErrorProc* const insPtr)
{
    UNUSED(insPtr);
    ProcessCoreErrorClass(dev, info);
    const uint16_t type = info->u.davidCoreErrorInfo.comm.type;

    TaskInfo* errTaskPtr = GetTaskInfo(
        dev, static_cast<uint32_t>(info->u.davidCoreErrorInfo.comm.streamId),
        static_cast<uint32_t>(info->u.davidCoreErrorInfo.comm.taskId), true);

    std::unordered_set<uint32_t> allSTaskId;
    for (uint32_t coreIdx = 0U; coreIdx < static_cast<uint32_t>(info->u.davidCoreErrorInfo.comm.coreNum); coreIdx++) {
        std::string errorString;
        std::string errorCode;
        ProcessDavidStarsCoreErrorMapInfo(
            &(info->u.davidCoreErrorInfo.info[coreIdx]), errorString, errorCode, dev->GetChipType());
        AddExceptionRegInfo(info, coreIdx, type, errTaskPtr);
        PrintArch9201CoreErrInfo(info, errorNumber, coreIdx, errorCode);
        DavidOstTaskErrorProc(dev, &(info->u.davidCoreErrorInfo.info[coreIdx]), &allSTaskId);
    }
    return RT_ERROR_NONE;
}

static rtError_t ProcessArch9201FusionKernelErrorInfo(
    const StarsDeviceErrorInfo* const info, const uint64_t errorNumber, const Device* const dev,
    const DeviceErrorProc* const insPtr)
{
    return ProcessFusionKernelErrorCommon(info, errorNumber, dev, insPtr, &ProcessArch9201StarsCoreErrorInfo);
}

static bool RegisterDavidErrorProcFunc()
{
    RegErrorProcFunc(CHIP_CLOUD_V5, AICORE_ERROR, &ProcessArch9201StarsCoreErrorInfo);
    RegErrorProcFunc(CHIP_CLOUD_V5, AIVECTOR_ERROR, &ProcessArch9201StarsCoreErrorInfo);
    RegErrorProcFunc(CHIP_CLOUD_V5, WAIT_TIMEOUT_ERROR, &ProcessDavidStarsWaitTimeoutErrorInfo);
    RegErrorProcFunc(CHIP_CLOUD_V5, SDMA_ERROR, &ProcessStarsSdmaErrorInfo);
    RegErrorProcFunc(CHIP_CLOUD_V5, AICPU_ERROR, &ProcessStarsAicpuErrorInfo);
    RegErrorProcFunc(CHIP_CLOUD_V5, DVPP_ERROR, &DeviceErrorProc::ProcessStarsDvppErrorInfo);
    RegErrorProcFunc(CHIP_CLOUD_V5, SQE_ERROR, &DeviceErrorProc::ProcessStarsSqeErrorInfo);
    RegErrorProcFunc(CHIP_CLOUD_V5, FUSION_KERNEL_ERROR, &ProcessArch9201FusionKernelErrorInfo);
    RegErrorProcFunc(CHIP_CLOUD_V5, CCU_ERROR, &ProcessDavidStarsCcuErrorInfo);
    RegErrorProcFunc(CHIP_CLOUD_V5, AICORE_TIMEOUT_DFX, &ProcessStarsV2CoreTimeoutDfxInfo);
    return true;
}

static bool g_registerDavidErrorProc = RegisterDavidErrorProcFunc();
} // namespace runtime
} // namespace cce
