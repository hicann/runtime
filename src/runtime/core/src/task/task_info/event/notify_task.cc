/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "notify.hpp"
#include "notify_task.h"
#include "task_info.hpp"
#include "task_fail_callback_manager.hpp"
#include "device/device_error_proc.hpp"
#include "task_manager.h"
#include "error_code.h"
#include "rdma_task.h"
#include "model_execute_task.h"
#include "stub_task.hpp"

namespace cce {
namespace runtime {

namespace {
bool IsSdmaMteErrorCode(const int32_t errCode)
{
    return (errCode == TS_ERROR_SDMA_LINK_ERROR) || (errCode == TS_ERROR_SDMA_POISON_ERROR) ||
           (errCode == TS_ERROR_SDMA_DDRC_ERROR) || (errCode == AICPU_HCCL_OP_SDMA_LINK_FAILED);
}
} // namespace

constexpr uint64_t RT_MC62CM12A_STARS_P_BASE_ADDR = 0x5A0000000ULL;       // P die
constexpr uint64_t RT_MC62CM12A_STARS_F_BASE_ADDR = 0x208A0000000ULL;     // F die
constexpr uint64_t STARS_MC62CM12A_NOTIFY_BASE_ADDR = 0x10000000ULL;
constexpr uint32_t STARS_MC62CM12A_NOTIFY_NUM_OF_SINGLE_TABLE_P = 512U;  // P die
constexpr uint32_t STARS_MC62CM12A_NOTIFY_NUM_OF_SINGLE_TABLE_F = 256U;   // F die
constexpr uint32_t STARS_MC62CM12A_NOTIFY_TABLE_SEPARATE_NUM = 16U;       // P/F DIE
constexpr uint32_t STARS_MC62CM12A_NOTIFY_TABLE_OFFSET   = 0x200000U;     // P/F DIE
constexpr uint32_t STARS_MC62CM12A_NOTIFY_ID_4K_SEPARATE = 0x1000U;       // P/F DIE
constexpr uint32_t STARS_MC62CM12A_NOTIFY_OFFSET   =  0x20U;
constexpr uint64_t RT_MC62CM12A_CHIP_ADDR_OFFSET   =  0x40000000000ULL;  // 4T
constexpr uint64_t RT_MC62CM12A_DIE_ADDR_OFFSET    =  0x10000000000ULL;  // 1T

#if F_DESC("NotifyRecordTask")
rtError_t NotifyRecordTaskInit(TaskInfo *taskInfo, const uint32_t notifyIndex, const int32_t deviceIndex,
                               const uint32_t phyIndex,
                               const SingleBitNotifyRecordInfo * const singleInfo,
                               const rtCntNtyRecordInfo_t * const countInfo,
                               void* const notify, bool isCountNotify)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_NOTIFY_RECORD;
    taskInfo->typeName = const_cast<char_t*>("NOTIFY_RECORD");

    NotifyRecordTaskInfo *notifyRecord = &(taskInfo->u.notifyrecordTask);

    notifyRecord->notifyId = notifyIndex;
    notifyRecord->deviceId = static_cast<uint32_t>(deviceIndex);
    notifyRecord->phyId = phyIndex;
    notifyRecord->timestamp = 0UL;
    notifyRecord->isCountNotify = isCountNotify;
    if (notify == nullptr) {
        return RT_ERROR_NOTIFY_NULL;
    }
    if (isCountNotify) {
        if (countInfo == nullptr) {
            RT_LOG(RT_LOG_ERROR, "device_id=%u, countInfo is null.", deviceIndex);
            return RT_ERROR_NOTIFY_NULL;
        }
        notifyRecord->uPtr.countNotify = static_cast<CountNotify *>(notify);
        notifyRecord->uInfo.countNtfyInfo = *countInfo;
    } else {
        if (singleInfo == nullptr) {
            RT_LOG(RT_LOG_ERROR, "device_id=%u, singleInfo is null.", deviceIndex);
            return RT_ERROR_NOTIFY_NULL;
        }
        notifyRecord->uPtr.notify = static_cast<Notify *>(notify);
        notifyRecord->uInfo.singleBitNtfyInfo = *singleInfo;
    }
    return RT_ERROR_NONE;
}

void DoCompleteSuccessForNotifyRecordTask(TaskInfo *taskInfo, const uint32_t devId)
{
    UNUSED(devId);
    if (Runtime::Instance()->ChipIsHaveStars() && (taskInfo->bindFlag == 0U)) {
        NotifyRecordTaskInfo *notifyRecord = &(taskInfo->u.notifyrecordTask);
        Stream* const stream = taskInfo->stream;
        RT_LOG(RT_LOG_INFO, "[DFX_SYNC] notify record finish. notify_id=%u, stream_id=%d, task_id=%hu, sq_id=%u,"
            " device_id=%u, is_ipc=%u, remote_device=%u",
            notifyRecord->notifyId, stream->Id_(), taskInfo->id,
            stream->GetSqId(), stream->Device_()->Id_(), notifyRecord->uInfo.singleBitNtfyInfo.isIpc,
            notifyRecord->deviceId);
    }
}

rtError_t NotifyResetTaskInit(TaskInfo *taskInfo, const uint32_t notifyIndex,
    const SingleBitNotifyRecordInfo * const singleInfo, void * const notify)
{
    COND_RETURN_ERROR((notify == nullptr), RT_ERROR_NOTIFY_NULL, "notify is nullptr.");
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_NOTIFY_RECORD;
    taskInfo->typeName = "NOTIFY_RESET";
    NotifyRecordTaskInfo *notifyReset = &(taskInfo->u.notifyrecordTask);
    notifyReset->notifyId = notifyIndex;
    notifyReset->isCountNotify = false;
    notifyReset->uPtr.notify = static_cast<Notify *>(notify);
    notifyReset->uInfo.singleBitNtfyInfo = *singleInfo;
    return RT_ERROR_NONE;
}

void ToCommandBodyForNotifyRecordTask(TaskInfo *taskInfo, rtCommand_t *const command)
{
    command->u.notifyrecordTask.notifyId = static_cast<uint16_t>(taskInfo->u.notifyrecordTask.notifyId);
    command->u.notifyrecordTask.deviceId = static_cast<uint16_t>(taskInfo->u.notifyrecordTask.phyId);
    command->taskInfoFlag = taskInfo->stream->GetTaskRevFlag(taskInfo->bindFlag);

    NotifyRecordTaskInfo* notifyRecord = &taskInfo->u.notifyrecordTask;
    Stream* const stream = taskInfo->stream;
    AtraceParams param = { stream->Device_()->Id_(), static_cast<uint32_t>(stream->Id_()), taskInfo->id,
        GetCurrentTid(), stream->Device_()->GetAtraceHandle(), {}};
    uintptr_t notifyLowEightAddr = 0;
    if (notifyRecord->uPtr.notify != nullptr) {
        notifyLowEightAddr = RtPtrToPtr<uintptr_t, Notify *>(notifyRecord->uPtr.notify) & 0xFFU;
    }
    param.u.notifyRecordParams = {notifyRecord->notifyId, notifyRecord->deviceId,
        static_cast<uint16_t>(notifyRecord->uInfo.singleBitNtfyInfo.isIpc), false, notifyLowEightAddr};
    AtraceSubmitLog(TYPE_NOTIFY_RECORD, param);
}

static rtError_t GetIpcNotifyBaseAddrForNotifyRecordTask(TaskInfo *taskInfo, uint64_t &baseAddr)
{
    Driver *const curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);

    NotifyRecordTaskInfo *notifyRecord = &(taskInfo->u.notifyrecordTask);
    const Notify* const notify = notifyRecord->uPtr.notify;
    rtError_t error;
    const uint32_t remoteDevId = notifyRecord->deviceId;
    const uint32_t remotePhyId = notifyRecord->phyId;
    const uint32_t localDevId = taskInfo->stream->Device_()->Id_();
    int64_t topologyType = 0;
    int64_t localServerId = RT_NOTIFY_INVALID_SRV_ID;
    int64_t remoteServerId = RT_NOTIFY_INVALID_SRV_ID;
    int64_t chipId = 0;
    int64_t dieId = 0;
    error = curDrv->GetDevInfo(localDevId, MODULE_TYPE_SYSTEM, INFO_TYPE_SERVER_ID, &localServerId);
    localServerId = (((error != 0) || (localServerId > RT_NOTIFY_MAX_SRV_ID)) ?
        RT_NOTIFY_INVALID_SRV_ID : localServerId);

    remoteServerId = localServerId;
    if (notify != nullptr) {
        remoteServerId = static_cast<int64_t>(notify->GetServiceId());
    }
    RT_LOG(RT_LOG_INFO, "Get localServerId, retCode=%#x, local_ServerId=%lld, remote=%lld",
        static_cast<uint32_t>(error), localServerId, remoteServerId);
    const bool isPod = (localServerId != remoteServerId && localServerId != RT_NOTIFY_INVALID_SRV_ID &&
        remoteServerId != RT_NOTIFY_INVALID_SRV_ID);
    if (isPod) {
        notifyRecord->uInfo.singleBitNtfyInfo.isPcie = false;
        if (notify != nullptr) {
            chipId = notify->GetChipId();
            dieId = notify->GetDieId();
        }
        baseAddr = RT_CROSS_NODE_BASE_ADDR_48T + static_cast<uint64_t>(remoteServerId) *
            RT_SERVER_ADDR_OFFSET_1T + static_cast<uint64_t>(chipId) * RT_CHIP_ADDR_OFFSET_128G +
            static_cast<uint64_t>(dieId) * RT_DIE_ADDR_OFFSET_64G +
            RT_NOTIFY_ADDR_OFFSET_PER_DIE_1100000;
        RT_LOG(RT_LOG_INFO, "DevId=%u, remoteSrvId=%lld, rDevId=%u, chipId=%lld, dieId=%lld, baseAddr=%llx",
            localDevId, remoteServerId, remoteDevId, chipId, dieId, baseAddr);
        return RT_ERROR_NONE;
    }
    error = curDrv->GetTopologyType(localDevId, remoteDevId, remotePhyId, &topologyType);
    ERROR_RETURN_MSG_INNER(error, "Get topology type fail, retCode=%#x, remoteDevId=%u, remotePhyId=%u", error, remoteDevId, remotePhyId);
    if ((topologyType == TOPOLOGY_HCCS) || (topologyType == TOPOLOGY_HCCS_SW) ||
        (topologyType == TOPOLOGY_SIO)) {
        notifyRecord->uInfo.singleBitNtfyInfo.isPcie = false;
        const rtError_t err = curDrv->GetChipIdDieId(localDevId, remoteDevId, remotePhyId, chipId, dieId);
        ERROR_RETURN_MSG_INNER(err, "Get chipId and dieId fail, retCode=%#x, deviceId=%u, phyId=%u", err, remoteDevId, remotePhyId);

        const uint64_t chipAddr = taskInfo->stream->Device_()->GetChipAddr();
        const uint64_t chipOffset = taskInfo->stream->Device_()->GetChipOffset();
        const uint64_t dieOffset  = taskInfo->stream->Device_()->GetDieOffset();

        baseAddr = RT_STARS_BASE_ADDR + (chipOffset * static_cast<uint64_t>(chipId)) +
            (dieOffset * static_cast<uint64_t>(dieId)) + STARS_NOTIFY_BASE_ADDR + chipAddr;
        RT_LOG(RT_LOG_INFO, "localDevId=%u, remoteDevId=%u, remotePhyId=%u, chipId=%lld, dieId=%lld, hccs addr=%llx, topologyType=%lld",
            localDevId, remoteDevId, remotePhyId, chipId, dieId, baseAddr, topologyType);
        return RT_ERROR_NONE;
    } else if ((topologyType == TOPOLOGY_PIX) || (topologyType == TOPOLOGY_PIB) ||
        (topologyType == TOPOLOGY_PHB) || (topologyType == TOPOLOGY_SYS)) {
        /* A+X 16P phyid correspond with chipid one by one */
        notifyRecord->uInfo.singleBitNtfyInfo.isPcie = true;
        uint32_t localPhyId = 0U;
        error = curDrv->GetDevicePhyIdByIndex(localDevId, &localPhyId);
        ERROR_RETURN_MSG_INNER(error, "Get localDevId phyId fail, retCode=%#x, deviceId=%u", error, localDevId);
        baseAddr = static_cast<uint64_t>(RT_STARS_PCIE_BASE_ADDR) +
            (static_cast<uint64_t>(remotePhyId) << static_cast<uint64_t>(RT_PCIE_REMOTE_DEV_OFFSET)) +
            (static_cast<uint64_t>(localPhyId) << static_cast<uint64_t>(RT_PCIE_LOCAL_DEV_OFFSET)) + STARS_NOTIFY_BASE_ADDR;
        RT_LOG(RT_LOG_DEBUG, "localDevId=%u, localPhyId=%u, remoteDevId=%u, remotePhyId=%u, pcie addr=%#" PRIx64,
            localDevId, localPhyId, remoteDevId, remotePhyId, baseAddr);
        return RT_ERROR_NONE;
    } else {
        // no operation
    }
    RT_LOG(RT_LOG_ERROR, "unsupported topologyType=%" PRId64, topologyType);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

static rtError_t GetIpcSqeWriteAddrByTsId(const TaskInfo * const taskInfo, uint64_t &addr)
{
    const NotifyRecordTaskInfo *const notifyRecord = &(taskInfo->u.notifyrecordTask);
    const Notify *const notify = notifyRecord->uPtr.notify;
    const uint32_t notifyId = taskInfo->u.notifyrecordTask.notifyId;
    const uint32_t serverId = notify->GetServiceId();
    uint32_t dieId = notify->GetAdcDieId();
    const uint32_t tsId = notify->GetTsId();
    const uint32_t notifyCntPerTable =
        (tsId == 0U) ? STARS_MC62CM12A_NOTIFY_NUM_OF_SINGLE_TABLE_P : STARS_MC62CM12A_NOTIFY_NUM_OF_SINGLE_TABLE_F;
    uint64_t baseAddr = (tsId == 0U) ? RT_MC62CM12A_STARS_P_BASE_ADDR : RT_MC62CM12A_STARS_F_BASE_ADDR;
    if (dieId == 2U) {  // dieId=2时固定是Fdie, Fdie仅有一个, 因此计算notify地址时无需对die偏移
        baseAddr += STARS_MC62CM12A_NOTIFY_BASE_ADDR + static_cast<uint64_t>(serverId) * RT_MC62CM12A_CHIP_ADDR_OFFSET;
    } else {
        baseAddr += STARS_MC62CM12A_NOTIFY_BASE_ADDR + static_cast<uint64_t>(serverId) * RT_MC62CM12A_CHIP_ADDR_OFFSET +
            static_cast<uint64_t>(dieId) * RT_MC62CM12A_DIE_ADDR_OFFSET;
    }

    const uint64_t notifyTableId = static_cast<uint64_t>(notifyId) / notifyCntPerTable;
    const uint32_t notifySeparateId = (notifyId % notifyCntPerTable) / STARS_MC62CM12A_NOTIFY_TABLE_SEPARATE_NUM;
    const uint64_t notifyPos =
        (static_cast<uint64_t>(notifyId) % notifyCntPerTable) % STARS_MC62CM12A_NOTIFY_TABLE_SEPARATE_NUM;
    addr = baseAddr + (notifyTableId * STARS_MC62CM12A_NOTIFY_TABLE_OFFSET) + (notifyPos * STARS_MC62CM12A_NOTIFY_OFFSET) +
        (notifySeparateId * STARS_MC62CM12A_NOTIFY_ID_4K_SEPARATE);
    RT_LOG(RT_LOG_INFO, "ipcNotifyId=%u, serverId=%u, dieId=%u, tsId=%u, baseAddr=%#llx", notifyId, serverId, dieId, tsId, addr);

    return RT_ERROR_NONE;
}

rtError_t GetIpcSqeWriteAddrForNotifyRecordTask(TaskInfo *taskInfo, uint64_t &addr)
{
    if (IS_SUPPORT_CHIP_FEATURE(Runtime::Instance()->GetChipType(),
        RtOptionalFeatureType::RT_FEATURE_TASK_IPC_NOTIFY_ADDR_DOT_BY_TSID)) {
        return GetIpcSqeWriteAddrByTsId(taskInfo, addr);
    }
    const uint64_t notifyId = static_cast<uint64_t>(taskInfo->u.notifyrecordTask.notifyId);
    uint64_t notifyTableId = static_cast<uint64_t>(notifyId / taskInfo->stream->Device_()->GetDevProperties().starsNotifyTableSize);
    uint64_t notifyNum = static_cast<uint64_t>(notifyId & taskInfo->stream->Device_()->GetDevProperties().ipcNotifyNumMask);
    uint64_t baseAddr = static_cast<uint64_t>(taskInfo->stream->Device_()->GetDevProperties().notifyBase);

    if (taskInfo->stream->Device_()->GetDevProperties().starsResourceAddrCalculateMethod == 
        StarsResourceAddrCalculateMethod::STARS_RESOURCE_ADDR_CALCULATE_BY_DEVICE_INFO) {
        const rtError_t error = GetIpcNotifyBaseAddrForNotifyRecordTask(taskInfo, baseAddr);
        ERROR_RETURN_MSG_INNER(error, "Get base addr fail, retCode=%#x", static_cast<uint32_t>(error));
    }

    addr = baseAddr + (notifyTableId * STARS_NOTIFY_TABLE_OFFSET) + (notifyNum * STARS_NOTIFY_OFFSET);
    return RT_ERROR_NONE;
}
#endif

#if F_DESC("NotifyWaitTask")
rtError_t NotifyWaitTaskInit(TaskInfo *taskInfo, const uint32_t notifyIndex, const uint32_t timeOutNum,
    const CountNotifyWaitInfo * const cntNtfyInfo, void * const inNotify, const bool isCountNotify)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_NOTIFY_WAIT;
    taskInfo->typeName = "NOTIFY_WAIT";

    NotifyWaitTaskInfo* notifyWaitTask = &(taskInfo->u.notifywaitTask);
    notifyWaitTask->notifyId = notifyIndex;
    notifyWaitTask->timeout = timeOutNum;
    notifyWaitTask->timestamp = 0UL;
    notifyWaitTask->isEndGraphNotify = false;
    notifyWaitTask->captureModel = nullptr;
    notifyWaitTask->isCountNotify = isCountNotify;
    if (isCountNotify) {
        if (inNotify == nullptr) {
            return RT_ERROR_NOTIFY_NULL;
        }
        notifyWaitTask->u.countNotify = static_cast<CountNotify *>(inNotify);
        notifyWaitTask->cntNtfyInfo = *cntNtfyInfo;
    } else {
        notifyWaitTask->u.notify = static_cast<Notify *>(inNotify);
    }
    return RT_ERROR_NONE;
}

void MapNotifyErrorCodeForFastRecovery(TaskInfo *taskInfo, const uint32_t devId)
{
    Stream * const stream = taskInfo->stream;
    if (taskInfo->errorCode == AICPU_HCCL_OP_RETRY_FAILED) {
        taskInfo->errorCode = TS_ERROR_AICPU_HCCL_OP_RETRY_FAILED;
    } else if (taskInfo->errorCode == AICPU_HCCL_OP_UB_DDRC_FAILED) {
        if(HasMteErr(stream->Device_()) && IsEventIdAndRasCodeMatch(stream->Device_()->Id_(), g_ubNonMemPoisonRasList) && !HasMemUceErr(stream->Device_()->Id_(), g_aicOrSdmaOrHcclLocalMulBitEccEventIdBlkList)) {
            taskInfo->errorCode = TS_ERROR_LOCAL_MEM_ERROR;
            (RtPtrToUnConstPtr<Device *>(stream->Device_()))->SetDeviceFaultType(DeviceFaultType::HBM_UCE_ERROR);
            RT_LOG(RT_LOG_ERROR,
                "hccl aicpu task error is local mem error, device_id=%u, stream_id=%d, task_id=%hu, taskInfo->errorCode=%u",
                devId, stream->Id_(), taskInfo->id, taskInfo->errorCode);
        }
    } else if (taskInfo->errorCode == AICPU_HCCL_OP_UB_POISON_FAILED) {
        if (!HasMteErr(stream->Device_()) && !HasMemUceErr(stream->Device_()->Id_(), g_hcclRemoteMulBitEccEventIdBlkList)) {
            taskInfo->errorCode = TS_ERROR_REMOTE_MEM_ERROR;
            RT_LOG(RT_LOG_ERROR,
                "hccl aicpu task error is remote mem error, device_id=%u, stream_id=%d, task_id=%hu, taskInfo->errorCode=%u",
                devId, stream->Id_(), taskInfo->id, taskInfo->errorCode);
        }
    } else if (taskInfo->errorCode == AICPU_HCCL_OP_UB_LINK_FAILED) {
        if (!HasBlacklistEventOnDevice(devId, g_ccuTimeoutEventIdBlkList)) {
            taskInfo->errorCode = TS_ERROR_LINK_ERROR;
            (RtPtrToUnConstPtr<Device *>(stream->Device_()))->SetDeviceFaultType(DeviceFaultType::LINK_ERROR);
            RT_LOG(RT_LOG_ERROR,
                "hccl aicpu task error is link error, device_id=%u, stream_id=%d, task_id=%hu, taskInfo->errorCode=%u",
                devId, stream->Id_(), taskInfo->id, taskInfo->errorCode);
        }
    }
}

static void ReportNotifyErrorForNotifyWaitTask(TaskInfo *taskInfo, const uint32_t devId)
{
    Stream * const stream = taskInfo->stream;
    if (IsSdmaMteErrorCode(static_cast<int32_t>(taskInfo->errorCode))) {
        if (HasMteErr(stream->Device_())) {
            taskInfo->errorCode = TS_ERROR_SDMA_POISON_ERROR;
        } else if (!HasMemUceErr(stream->Device_()->Id_())) {
            taskInfo->errorCode = TS_ERROR_SDMA_LINK_ERROR;
        } else {
            taskInfo->errorCode = TS_ERROR_SDMA_ERROR;
        }
    } else {
        MapNotifyErrorCodeForFastRecovery(taskInfo, devId);
    }
    const uint32_t errorCode = taskInfo->errorCode;
    RT_LOG(RT_LOG_ERROR, "Kernel task happen error, retCode=%#x, [%s].",
        errorCode, GetTsErrCodeDesc(errorCode));
    stream->SetErrCode(errorCode);
    PrintErrorInfoForNotifyWaitTask(taskInfo, devId);
    TaskFailCallBack(static_cast<uint32_t>(stream->Id_()), static_cast<uint32_t>(taskInfo->id),
        taskInfo->tid, errorCode, stream->Device_());
}

void DoCompleteSuccessForNotifyWaitTask(TaskInfo *taskInfo, const uint32_t devId)
{
    if (unlikely(taskInfo->errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        if ((!taskInfo->u.notifywaitTask.isCountNotify) && (taskInfo->u.notifywaitTask.u.notify != nullptr) &&
            (taskInfo->u.notifywaitTask.u.notify->GetEndGraphModel() != nullptr)) {
            ReportModelEndGraphErrorForNotifyWaitTask(taskInfo, devId);
        } else {
            ReportNotifyErrorForNotifyWaitTask(taskInfo, devId);
        }
    }

    if (Runtime::Instance()->ChipIsHaveStars() && (!(taskInfo->bindFlag))) {
        Stream* const stream = taskInfo->stream;
        RT_LOG(RT_LOG_INFO, "[DFX_SYNC] notify wait finish. notify_id=%u, stream_id=%d, task_id=%hu, sq_id=%u,"
            " device_id=%u", taskInfo->u.notifywaitTask.notifyId, stream->Id_(), taskInfo->id,
            stream->GetSqId(), stream->Device_()->Id_());
        PrintDfxInfoForRdmaPiValueModifyTask(taskInfo, devId);
    }

    if ((taskInfo->u.notifywaitTask.isEndGraphNotify) &&
        (taskInfo->u.notifywaitTask.captureModel != nullptr)) {
        taskInfo->stream->Device_()->DeleteEndGraphNotifyInfo(taskInfo->stream->Id_(),
            taskInfo->u.notifywaitTask.captureModel, taskInfo->pos);
    }
}

void PrintErrorInfoForNotifyWaitTask(TaskInfo *const taskInfo, const uint32_t devId)
{
    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = taskInfo->stream->Id_();
    Stream *const reportStream = GetReportStream(taskInfo->stream);
    STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_HCCL,
        "Notify wait execute failed, device_id=%u, stream_id=%d, %s=%u, flip_num=%hu, "
        "notify_id=%u, isCountNotify=%u.", devId, streamId, TaskIdDesc(), taskId, taskInfo->flipNum,
        taskInfo->u.notifywaitTask.notifyId, taskInfo->u.notifywaitTask.isCountNotify);
}

void ToCommandBodyForNotifyWaitTask(TaskInfo *taskInfo, rtCommand_t *const command)
{
    command->u.notifywaitTask.notifyid = static_cast<uint16_t>(taskInfo->u.notifywaitTask.notifyId);
    command->u.notifywaitTask.timeout = static_cast<uint32_t>(taskInfo->u.notifywaitTask.timeout);
    command->taskInfoFlag = taskInfo->stream->GetTaskRevFlag(taskInfo->bindFlag);
}

TaskInfo* GetRealReportFaultTaskForNotifyWaitTask(TaskInfo *taskInfo, const void *info)
{
    Notify* const notify = taskInfo->u.notifywaitTask.u.notify;
    if (unlikely(notify == nullptr)) {
        return nullptr;
    }

    if (notify->GetEndGraphModel() != nullptr) {
        rtStarsCqeSwStatus_t sw_status;
        sw_status.value = *(static_cast<const uint32_t *>(info));
        uint16_t streamId = sw_status.model_exec.stream_id;
        uint16_t taskId = sw_status.model_exec.task_id;
        Device *const dev = taskInfo->stream->Device_();
        if ((dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_ACL_GRAPH_SOFTWARE_ENABLE)) && 
            (dev->CheckFeatureSupport(TS_FEATURE_SOFTWARE_SQ_ENABLE))) {
            streamId = notify->GetEndGraphModel()->GetStreamIdBySqId(sw_status.model_exec_ex.sq_id);
            taskId = sw_status.model_exec_ex.task_id;
        }

        TaskInfo *taskPtr = GetTaskInfo(dev, static_cast<uint32_t>(streamId), static_cast<uint32_t>(taskId), true);
        
        return taskPtr;
    }
    return nullptr;
}
#endif

}  // namespace runtime
}  // namespace cce
