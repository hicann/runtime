/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "device_error_proc_c.hpp"
#include "task_david.hpp"
#include "profiler_c.hpp"
#include "task_fail_callback_manager.hpp"
#include "task_recycle.hpp"
#include "stream.hpp"
#include "error_code.h"

namespace cce {
namespace runtime {
namespace {
constexpr uint32_t DIE_ID_SHIFT_BITS = 5U;
}

static void SetCcuExceptionSqeInfo(rtCcuMissionDetailInfo_t * const sqeInfo, const RtDavidStarsCcuSqe * const ccuSqe,
    uint32_t inputIdx, uint32_t outputIdx)
{
    uint64_t* args = sqeInfo[outputIdx].args;
    sqeInfo[outputIdx].dieId = ccuSqe[inputIdx].resv.ccuResvDesc1.dieId;
    sqeInfo[outputIdx].instrId = ccuSqe[inputIdx].instStartId;
    sqeInfo[outputIdx].missionId = ccuSqe[inputIdx].resv.ccuResvDesc1.missionId;
    /* word6-15 memcpy, 5*8=40B */
    constexpr size_t firstCpySize = sizeof(uint64_t) * 5U;
    (void)memcpy_s(args, firstCpySize,
        RtPtrToPtr<const uint8_t *, const RtDavidStarsCcuSqe *>(&ccuSqe[inputIdx]) + sizeof(rtDavidSqe_t) - firstCpySize, firstCpySize);

    /* second ccu sqe part: 64 Byte(1 sqe size) */
    (void)memcpy_s(RtPtrToPtr<uint8_t *, uint64_t *>(args) + firstCpySize, sizeof(rtDavidSqe_t), &ccuSqe[inputIdx + 1U],
        sizeof(rtDavidSqe_t));
    RT_LOG(RT_LOG_ERROR, "128B:index=%u, udie_id=%hhu, missionId=%hhu, instrId=%hu.", outputIdx, sqeInfo[outputIdx].dieId,
        sqeInfo[outputIdx].missionId, sqeInfo[outputIdx].instrId);
    return;
}

static void ParseCcuDfxInfo(rtMultiCCUExDetailInfo_t * const multiCcuInfo, const StarsDeviceErrorInfo * const info)
{
	std::unordered_map<uint32_t, const StarsCcuDfxInfo*> dfxInfoMap;
	for (uint8_t idx = 0U; idx < info->u.ccuErrorInfo.comm.coreNum; idx++) {
	    const StarsCcuDfxInfo *dfxInfo = &(info->u.ccuErrorInfo.dfxInfo[idx]);
	    uint32_t key = (dfxInfo->dieId) << DIE_ID_SHIFT_BITS | (dfxInfo->missionId);
	    dfxInfoMap.emplace(key, dfxInfo);
	}
	for (uint8_t idx = 0U; idx < multiCcuInfo->ccuMissionNum; idx++) {
	    uint8_t dieId = multiCcuInfo->missionInfo[idx].dieId;
	    uint8_t missionId = multiCcuInfo->missionInfo[idx].missionId;
	    uint32_t key = ((dieId << DIE_ID_SHIFT_BITS) | missionId);
	    auto it = dfxInfoMap.find(key);
	    if (it != dfxInfoMap.end()) {
	        const StarsCcuDfxInfo *dfxInfo = it->second;
	        multiCcuInfo->missionInfo[idx].status = dfxInfo->status;
	        multiCcuInfo->missionInfo[idx].subStatus = dfxInfo->subStatus;
	        int ret = memcpy_s(multiCcuInfo->missionInfo[idx].panicLog, MAX_CCU_EXCEPTION_INFO_SIZE,
	            dfxInfo->panicLog, MAX_CCU_EXCEPTION_INFO_SIZE);
	        if (ret != 0) {
	            RT_LOG(RT_LOG_ERROR, "memcpy failed, die_id=%u, mission_id=%u", dieId, missionId);
	        }
	    }
	}
	RT_LOG(RT_LOG_ERROR, "parse ccu dfx info, core_num=%u, mission_num=%u.", info->u.ccuErrorInfo.comm.coreNum,
	    multiCcuInfo->ccuMissionNum);
}

static void HandleFusionKernelCcuException(rtExceptionExpandInfo_t * const expandInfo, const TaskInfo * const taskInfo,
	const StarsDeviceErrorInfo * const info, const rtDavidSqe_t *sqe)
{
	rtFusionExDetailInfo_t* fusionDetail = &(expandInfo->u.fusionInfo);
	fusionDetail->u.aicoreCcuInfo.ccuDetailMsg.ccuMissionNum = taskInfo->u.fusionKernelTask.ccuSqeNum;
	if (taskInfo->u.fusionKernelTask.ccuArgSize == RT_CCU_SQE32B_ARGS_SIZE) {
	    COND_RETURN_VOID(info->u.ccuErrorInfo.comm.coreNum > FUSION_SUB_TASK_MAX_CCU_NUM,
	        "32B ccu sub task num is invalid, coreNum=%hu.", info->u.ccuErrorInfo.comm.coreNum);
	    const RtDavidStarsCcuSqe32B *ccuSqe = RtPtrToPtr<const RtDavidStarsCcuSqe32B *, const rtDavidSqe_t *>(sqe);
	    for (uint8_t idx = 0U; idx < taskInfo->u.fusionKernelTask.ccuSqeNum; idx++) {
	        fusionDetail->u.aicoreCcuInfo.ccuDetailMsg.missionInfo[idx].dieId = ccuSqe[idx].resv.ccuResvDesc1.dieId;
	        fusionDetail->u.aicoreCcuInfo.ccuDetailMsg.missionInfo[idx].instrId = ccuSqe[idx].instStartId;
	        fusionDetail->u.aicoreCcuInfo.ccuDetailMsg.missionInfo[idx].missionId = ccuSqe[idx].resv.ccuResvDesc1.missionId;
	        (void)memcpy_s(fusionDetail->u.aicoreCcuInfo.ccuDetailMsg.missionInfo[idx].args, sizeof(uint64_t),
	            ccuSqe[idx].usrData, sizeof(uint64_t));
	        RT_LOG(RT_LOG_ERROR, "32B:coreNum=%u, dieId=%hhu, missionId=%hhu, instrId=%hu, args=%#x.",
	            info->u.ccuErrorInfo.comm.coreNum,
	            fusionDetail->u.aicoreCcuInfo.ccuDetailMsg.missionInfo[idx].dieId,
	            fusionDetail->u.aicoreCcuInfo.ccuDetailMsg.missionInfo[idx].missionId,
	            fusionDetail->u.aicoreCcuInfo.ccuDetailMsg.missionInfo[idx].instrId,
	            fusionDetail->u.aicoreCcuInfo.ccuDetailMsg.missionInfo[idx].args[0U]);
	    }
	} else {
	    COND_RETURN_VOID(info->u.ccuErrorInfo.comm.coreNum > 2U,
	        "128B ccu sub task num is invalid, coreNum=%hu.", info->u.ccuErrorInfo.comm.coreNum);
	    const RtDavidStarsCcuSqe *ccuSqe = RtPtrToPtr<const RtDavidStarsCcuSqe *, const rtDavidSqe_t *>(sqe);
	    uint8_t idx = 0U;
	    for (uint8_t num = 0U; num < taskInfo->u.fusionKernelTask.ccuSqeNum; num++) {
	        SetCcuExceptionSqeInfo(fusionDetail->u.aicoreCcuInfo.ccuDetailMsg.missionInfo, ccuSqe, static_cast<uint32_t>(idx),
	            static_cast<uint32_t>(num));
	        idx += 2U;
	    }
	}
	ParseCcuDfxInfo(&(fusionDetail->u.aicoreCcuInfo.ccuDetailMsg), info);
}

static void MapCcuErrorCodeForFastRecovery(const uint8_t status, const uint8_t subStatus, TaskInfo* taskInfo)
{
    const auto device = taskInfo->stream->Device_();
    COND_RETURN_VOID(device == nullptr, "Invalid device");
    const uint32_t devId = device->Id_();
    RT_LOG(RT_LOG_DEBUG,
                "CCU Launch task error status [%#x], subStatus [%#x], device_id=%u, stream_id=%d, task_id=%hu",
                status, subStatus, devId, taskInfo->stream->Id_(), taskInfo->id);
    bool hasMteErr = HasMteErr(device);
    if (status == CCU_TASK_LOCAL_MEM_ERROR && subStatus == CCU_TASK_LOCAL_MEM_ERROR_SUBSTATUS) {
        if (hasMteErr && IsEventIdAndRasCodeMatch(devId, g_ubNonMemPoisonRasList) && !HasMemUceErr(devId, g_aicOrSdmaOrHcclLocalMulBitEccEventIdBlkList)) {
            taskInfo->mte_error = TS_ERROR_LOCAL_MEM_ERROR;
            (RtPtrToUnConstPtr<Device *>(device))->SetDeviceFaultType(DeviceFaultType::HBM_UCE_ERROR);
            RT_LOG(RT_LOG_ERROR,
                "CCU Launch local HBM UCE fault occurred: device_id=%u, stream_id=%d, task_id=%hu, retCode=%u",
                devId, taskInfo->stream->Id_(), taskInfo->id, taskInfo->mte_error);
        }
    }
    else if (status == CCU_TASK_REMOTE_MEM_ERROR) {
        if (!hasMteErr && !HasMemUceErr(devId, g_hcclRemoteMulBitEccEventIdBlkList)) {
            taskInfo->mte_error = TS_ERROR_REMOTE_MEM_ERROR;
            RT_LOG(RT_LOG_ERROR,
                "CCU Launch remote HBM UCE fault occurred: device_id=%u, stream_id=%d, task_id=%hu, retCode=%u",
                devId, taskInfo->stream->Id_(), taskInfo->id, taskInfo->mte_error);
        }
    } else if (status == CCU_TASK_LINK_ERROR) {
        if (!HasBlacklistEventOnDevice(devId, g_ccuTimeoutEventIdBlkList)) {
            taskInfo->mte_error = TS_ERROR_LINK_ERROR;
            (RtPtrToUnConstPtr<Device *>(device))->SetDeviceFaultType(DeviceFaultType::LINK_ERROR);
            RT_LOG(RT_LOG_ERROR,
                "CCU Launch link fault occurred: device_id=%u, stream_id=%d, task_id=%hu, retCode=%u",
                devId, taskInfo->stream->Id_(), taskInfo->id, taskInfo->mte_error);
        }
    } else {
    }
}

static void MapFusionCcuErrorCodeForFastRecovery(const uint8_t ccuStatus, TaskInfo* taskInfo)
{
    const auto device = taskInfo->stream->Device_();
    COND_RETURN_VOID(device == nullptr, "Invalid device");
    const uint32_t devId = device->Id_();
    RT_LOG(RT_LOG_DEBUG,
                "fusion CCU Launch task mte_error=%u, device_id=%u, stream_id=%d, task_id=%hu",
                taskInfo->mte_error, devId, taskInfo->stream->Id_(), taskInfo->id);
    bool hasMteErr = HasMteErr(device);
    if (ccuStatus == CCU_TASK_LOCAL_MEM_ERROR) {
        if (hasMteErr && IsEventIdAndRasCodeMatch(devId, g_ubNonMemPoisonRasList) && !HasMemUceErr(devId, g_aicOrSdmaOrHcclLocalMulBitEccEventIdBlkList)) {
            taskInfo->mte_error = TS_ERROR_LOCAL_MEM_ERROR;
            (RtPtrToUnConstPtr<Device *>(device))->SetDeviceFaultType(DeviceFaultType::HBM_UCE_ERROR);
            RT_LOG(RT_LOG_ERROR,
                "fusion CCU Launch local HBM UCE fault occurred: device_id=%u, stream_id=%d, task_id=%hu, retCode=%u",
                devId, taskInfo->stream->Id_(), taskInfo->id, taskInfo->mte_error);
        }
    }
    else if (ccuStatus == CCU_TASK_REMOTE_MEM_ERROR) {
        if (!hasMteErr && !HasMemUceErr(devId, g_hcclRemoteMulBitEccEventIdBlkList)) {
            taskInfo->mte_error = TS_ERROR_REMOTE_MEM_ERROR;
            RT_LOG(RT_LOG_ERROR,
                "fusion CCU Launch remote HBM UCE fault occurred: device_id=%u, stream_id=%d, task_id=%hu, retCode=%u",
                devId, taskInfo->stream->Id_(), taskInfo->id, taskInfo->mte_error);
        }
    } else if (ccuStatus == CCU_TASK_LINK_ERROR) {
        if (!HasBlacklistEventOnDevice(devId, g_ccuTimeoutEventIdBlkList)) {
            taskInfo->mte_error = TS_ERROR_LINK_ERROR;
            (RtPtrToUnConstPtr<Device *>(device))->SetDeviceFaultType(DeviceFaultType::LINK_ERROR);
            RT_LOG(RT_LOG_ERROR,
                "fusion CCU Launch link fault occurred: device_id=%u, stream_id=%d, task_id=%hu, retCode=%u",
                devId, taskInfo->stream->Id_(), taskInfo->id, taskInfo->mte_error);
        }
    } else {
    }
}

static void ParseAndGetCcuExceptionInfo(rtExceptionExpandInfo_t * const expandInfo, const TaskInfo * const taskInfo,
    const StarsDeviceErrorInfo * const info)
{
    rtDavidSqe_t *sqe = const_cast<rtDavidSqe_t *>(info->u.ccuErrorInfo.davidSqe);
    if (taskInfo->type == TS_TASK_TYPE_CCU_LAUNCH) {
        COND_RETURN_VOID(info->u.ccuErrorInfo.comm.coreNum > 1U,
            "ccu sub task num is invalid, coreNum=%hu.", info->u.ccuErrorInfo.comm.coreNum);
        expandInfo->u.ccuInfo.ccuMissionNum = 1U;
        RtDavidStarsCcuSqe *ccuSqe = RtPtrToPtr<RtDavidStarsCcuSqe *, rtDavidSqe_t *>(sqe);
        SetCcuExceptionSqeInfo(expandInfo->u.ccuInfo.missionInfo, ccuSqe, 0U, 0U);
        ParseCcuDfxInfo(&(expandInfo->u.ccuInfo), info);
        const rtMultiCCUExDetailInfo_t * const multiCcuInfo = &(expandInfo->u.ccuInfo);
        for (uint8_t idx = 0U; idx < multiCcuInfo->ccuMissionNum; idx++) {
            const uint8_t status = multiCcuInfo->missionInfo[idx].status;
            const uint8_t subStatus = multiCcuInfo->missionInfo[idx].subStatus;
            MapCcuErrorCodeForFastRecovery(status, subStatus, RtPtrToUnConstPtr<TaskInfo *>(taskInfo));
        }
    } else if (taskInfo->type == TS_TASK_TYPE_FUSION_KERNEL) {
        HandleFusionKernelCcuException(expandInfo, taskInfo, info, sqe);
        const rtMultiCCUExDetailInfo_t * const multiCcuInfo = &(expandInfo->u.fusionInfo.u.aicoreCcuInfo.ccuDetailMsg);
        for (uint8_t idx = 0U; idx < multiCcuInfo->ccuMissionNum; idx++) {
            const uint8_t ccuStatus = multiCcuInfo->missionInfo[idx].status;
            MapFusionCcuErrorCodeForFastRecovery(ccuStatus, RtPtrToUnConstPtr<TaskInfo *>(taskInfo));
        }
    } else {
    }
}

static void TaskFailCallBackForFusionKernelTask(const TaskInfo * const taskInfo, const uint32_t deviceId,
    const StarsDeviceErrorInfo * const info)
{
    COND_RETURN_VOID(taskInfo == nullptr, "taskInfo is nullptr.");
    const int32_t streamId = taskInfo->stream->GetExposedStreamId();
    const uint32_t threadId = taskInfo->tid;
    rtExceptionInfo_t exceptionInfo;
    (void)memset_s(&exceptionInfo, sizeof(rtExceptionInfo_t), 0U, sizeof(rtExceptionInfo_t));
    rtExceptionExpandInfo_t *expandInfo = &(exceptionInfo.expandInfo);
    rtFusionExDetailInfo_t *fusionDetail = &(expandInfo->u.fusionInfo);
    fusionDetail->type = RT_FUSION_AICORE_CCU;

    ParseAndGetCcuExceptionInfo(expandInfo, taskInfo, info);
    rtError_t rtErrCode = RT_ERROR_TSFW_BASE;
    if (taskInfo->mte_error != 0) {
        (void)GetTsErrCodeMap(taskInfo->mte_error, &rtErrCode);
    }
    exceptionInfo.retcode = static_cast<uint32_t>(RT_TRANS_EXT_ERRCODE(rtErrCode));
    exceptionInfo.taskid = taskInfo->taskSn;
    exceptionInfo.streamid = static_cast<uint32_t>(streamId);
    exceptionInfo.tid = threadId;
    exceptionInfo.deviceid = deviceId;
    expandInfo->type = RT_EXCEPTION_FUSION;
    GetExceptionArgsForFusionKernelTask(taskInfo, &(expandInfo->u.fusionInfo.u.aicoreCcuInfo.exceptionArgs));
    RT_LOG(RT_LOG_WARNING, "fusion kernel task: stream_id=%d, exception_task_id=%u, expandType=%u, retCode=%#x.",
        streamId, exceptionInfo.taskid, expandInfo->type, exceptionInfo.retcode);

    TaskFailCallBackNotify(&exceptionInfo);
}

static void TaskFailCallBackForCcuTask(const TaskInfo * const taskInfo, const uint32_t deviceId,
    const StarsDeviceErrorInfo * const info)
{
    COND_RETURN_VOID(taskInfo == nullptr, "taskInfo is nullptr.");
    const int32_t streamId = taskInfo->stream->GetExposedStreamId();
    const uint32_t threadId = taskInfo->tid;
    rtExceptionInfo_t exceptionInfo;
    (void)memset_s(&exceptionInfo, sizeof(rtExceptionInfo_t), 0U, sizeof(rtExceptionInfo_t));
    rtExceptionExpandInfo_t *expandInfo = &(exceptionInfo.expandInfo);

    ParseAndGetCcuExceptionInfo(expandInfo, taskInfo, info);
    rtError_t errCode = RT_ERROR_TSFW_BASE;
    if (taskInfo->mte_error != 0) {
        (void)GetTsErrCodeMap(taskInfo->mte_error, &errCode);
    }
    exceptionInfo.retcode = static_cast<uint32_t>(RT_TRANS_EXT_ERRCODE(errCode));
    exceptionInfo.taskid = taskInfo->taskSn;
    exceptionInfo.streamid = static_cast<uint32_t>(streamId);
    exceptionInfo.tid = threadId;
    exceptionInfo.deviceid = deviceId;
    expandInfo->type = RT_EXCEPTION_CCU;
    RT_LOG(RT_LOG_WARNING, "ccu kernel task: stream_id=%d, exception_task_id=%u, expandType=%u, retCode=%#x.",
        streamId, exceptionInfo.taskid, expandInfo->type, exceptionInfo.retcode);

    TaskFailCallBackNotify(&exceptionInfo);
}

rtError_t ProcessDavidStarsCcuErrorInfo(const StarsDeviceErrorInfo * const info,
    const uint64_t errorNumber, const Device * const dev, const DeviceErrorProc * const insPtr)
{
    UNUSED(insPtr);
    if (info == nullptr) {
        return RT_ERROR_NONE;
    }

    TaskInfo *errTaskPtr = GetTaskInfo(dev, static_cast<uint32_t>(info->u.ccuErrorInfo.comm.streamId),
        static_cast<uint32_t>(info->u.ccuErrorInfo.comm.taskId), true);

    RT_LOG_CALL_MSG(ERR_MODULE_TBE, "The error from device(D-die, chipId=%u, dieId=%u), serial number is %" PRIu64 ", "
        "ccu task print, coreNum=%hu, streamId=%hu, taskId=%hu.", info->u.ccuErrorInfo.comm.chipId,
        info->u.ccuErrorInfo.comm.dieId, errorNumber, info->u.ccuErrorInfo.comm.coreNum,
        info->u.ccuErrorInfo.comm.streamId, info->u.ccuErrorInfo.comm.taskId);

    COND_RETURN_WARN(errTaskPtr == nullptr, RT_ERROR_NONE, "taskInfo is nullptr.");
    errTaskPtr->isRingbufferGet = true;

    if (errTaskPtr->type == TS_TASK_TYPE_CCU_LAUNCH) {
        TaskFailCallBackForCcuTask(errTaskPtr, dev->Id_(), info);
    } else if (errTaskPtr->type == TS_TASK_TYPE_FUSION_KERNEL) {
        TaskFailCallBackForFusionKernelTask(errTaskPtr, dev->Id_(), info);
    } else {
    }

    return RT_ERROR_NONE;
}
}  // namespace runtime
}  // namespace cce
