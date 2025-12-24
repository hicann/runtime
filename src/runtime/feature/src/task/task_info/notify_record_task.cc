/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
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
#include "notify_record_task.h"

namespace cce {
namespace runtime {

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

void ConstructNotifySqeForNotifyRecordTask(TaskInfo *taskInfo, rtStarsSqe_t *const command)
{
    Stream* const stream = taskInfo->stream;
    RtStarsNotifySqe *const sqe = &(command->notifySqe);
    sqe->header.type = RT_STARS_SQE_TYPE_NOTIFY_RECORD;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.wr_cqe = stream->GetStarsWrCqeFlag();
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    sqe->header.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    sqe->notify_id = taskInfo->u.notifyrecordTask.notifyId;
    sqe->header.task_id = taskInfo->id;

    sqe->res2 = 0U;
    sqe->res3 = 0U;

    PrintSqe(command, "NotifyRecordTask");
}

rtError_t GetIpcNotifyBaseAddrForNotifyRecordTask(TaskInfo *taskInfo, uint64_t &baseAddr)
{
    Driver *const curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);

    NotifyRecordTaskInfo *notifyRecord = &(taskInfo->u.notifyrecordTask);
    const Notify* const notify = notifyRecord->uPtr.notify;
    rtError_t error;
    const uint32_t remoteDevId = notifyRecord->deviceId;
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
    error = curDrv->GetPairDevicesInfo(localDevId, remoteDevId, DEVS_INFO_TYPE_TOPOLOGY, &topologyType);
    ERROR_RETURN_MSG_INNER(error, "Get topology type fail, retCode=%#x, remoteDevId=%u", error, remoteDevId);
    if ((topologyType == TOPOLOGY_HCCS) || (topologyType == TOPOLOGY_HCCS_SW) ||
        (topologyType == TOPOLOGY_SIO)) {
        notifyRecord->uInfo.singleBitNtfyInfo.isPcie = false;
        error = curDrv->GetDevInfo(remoteDevId, MODULE_TYPE_SYSTEM, INFO_TYPE_PHY_CHIP_ID, &chipId);
        ERROR_RETURN_MSG_INNER(error, "Get chipId fail, retCode=%#x, deviceId=%u", error, remoteDevId);
        error = curDrv->GetDevInfo(remoteDevId, MODULE_TYPE_SYSTEM, INFO_TYPE_PHY_DIE_ID, &dieId);
        ERROR_RETURN_MSG_INNER(error, "Get dieId fail, retCode=%#x, deviceId=%u", error, remoteDevId);

        const uint64_t chipAddr = taskInfo->stream->Device_()->GetChipAddr();
        const uint64_t chipOffset = taskInfo->stream->Device_()->GetChipOffset();
        const uint64_t dieOffset  = taskInfo->stream->Device_()->GetDieOffset();

        baseAddr = RT_STARS_BASE_ADDR + (chipOffset * static_cast<uint64_t>(chipId)) +
            (dieOffset * static_cast<uint64_t>(dieId)) + STARS_NOTIFY_BASE_ADDR + chipAddr;
        RT_LOG(RT_LOG_INFO, "localDevId=%u, remoteDevId=%u, chipId=%lld, dieId=%lld, hccs addr=%llx, topologyType=%lld",
            localDevId, remoteDevId, chipId, dieId, baseAddr, topologyType);
        return RT_ERROR_NONE;
    } else if (topologyType == TOPOLOGY_PIX) {
        /* A+X 16P phyid correspond with chipid one by one */
        notifyRecord->uInfo.singleBitNtfyInfo.isPcie = true;
        uint32_t localPhyId = 0U;
        const uint32_t remotePhyId = notifyRecord->phyId;
        error = NpuDriver::DeviceGetPhyIdByIndex(localDevId, &localPhyId);
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
    const uint32_t chipId = notify->GetPhyDevId();  // 投片阶段，和tsdrv对齐，phyId即chipId
    uint32_t dieId = notify->GetDieId();
    const uint32_t tsId = notify->GetTsId();
    const uint32_t notifyCntPerTable =
        (tsId == 0U) ? STARS_MC62CM12A_NOTIFY_NUM_OF_SINGLE_TABLE_P : STARS_MC62CM12A_NOTIFY_NUM_OF_SINGLE_TABLE_F;
    uint64_t baseAddr = (tsId == 0U) ? RT_MC62CM12A_STARS_P_BASE_ADDR : RT_MC62CM12A_STARS_F_BASE_ADDR;
    if (dieId == 2U) {  // dieId = 2固定是F DIE，仅有一个die，因此计算notify地址无需对die偏移
        dieId = 0U;
    }
    baseAddr += STARS_MC62CM12A_NOTIFY_BASE_ADDR + static_cast<uint64_t>(chipId) * RT_MC62CM12A_CHIP_ADDR_OFFSET +
        static_cast<uint64_t>(dieId) * RT_MC62CM12A_DIE_ADDR_OFFSET;
    const uint64_t notifyTableId = static_cast<uint64_t>(notifyId) / notifyCntPerTable;
    const uint32_t notifySeparateId = (notifyId % notifyCntPerTable) / STARS_MC62CM12A_NOTIFY_TABLE_SEPARATE_NUM;
    const uint64_t notifyPos =
        (static_cast<uint64_t>(notifyId) % notifyCntPerTable) % STARS_MC62CM12A_NOTIFY_TABLE_SEPARATE_NUM;
    addr = baseAddr + (notifyTableId * STARS_MC62CM12A_NOTIFY_TABLE_OFFSET) + (notifyPos * STARS_MC62CM12A_NOTIFY_OFFSET) +
        (notifySeparateId * STARS_MC62CM12A_NOTIFY_ID_4K_SEPARATE);
    RT_LOG(RT_LOG_INFO, "notifyId:%u, chipId=%u, dieId=%u, tsId=%u, baseAddr=0x%llx", notifyId, chipId, dieId, tsId, addr);

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

void ConstructIpcSqeForNotifyRecordTask(TaskInfo *taskInfo, rtStarsSqe_t *const command)
{
    NotifyRecordTaskInfo* notifyRecord = &taskInfo->u.notifyrecordTask;
    Stream* const stream = taskInfo->stream;
    RtStarsWriteValueSqe *const sqe = &(command->writeValueSqe);
    sqe->header.type = RT_STARS_SQE_TYPE_WRITE_VALUE;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.wr_cqe = stream->GetStarsWrCqeFlag();

    sqe->header.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    sqe->header.task_id = taskInfo->id;
    sqe->va = 0U;

    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->awsize = RT_STARS_WRITE_VALUE_SIZE_TYPE_32BIT;
    sqe->snoop = 0U;
    sqe->awcache = stream->Device_()->IsAddrFlatDev() ? 0xFU : 0U;
    sqe->awprot = 0U;

    sqe->res3 = notifyRecord->phyId;
    sqe->res4 = static_cast<uint32_t>(notifyRecord->uInfo.singleBitNtfyInfo.isPod);
    sqe->res5 = 0U;
    sqe->res6 = 0U;
    sqe->res7 = 0U;
    sqe->write_value_part0 = 1U;
    sqe->write_value_part1 = 0U;
    sqe->write_value_part2 = 0U;
    sqe->write_value_part3 = 0U;
    sqe->write_value_part4 = 0U;
    sqe->write_value_part5 = 0U;
    sqe->write_value_part6 = 0U;
    sqe->write_value_part7 = 0U;

    uint64_t addr = 0UL;
    const uint32_t devId = stream->Device_()->Id_();
    if (notifyRecord->uInfo.singleBitNtfyInfo.lastLocalId == devId) {
        addr = notifyRecord->uInfo.singleBitNtfyInfo.lastBaseAddr;
        notifyRecord->uInfo.singleBitNtfyInfo.isPcie = notifyRecord->uInfo.singleBitNtfyInfo.lastIsPcie;
    } else {
        const rtError_t error = GetIpcSqeWriteAddrForNotifyRecordTask(taskInfo, addr);
        if (error != RT_ERROR_NONE) {
            sqe->header.type = RT_STARS_SQE_TYPE_INVALID;
            RT_LOG(RT_LOG_ERROR, "Failed to get address, retCode=%#x!", error);
            return;
        }
        notifyRecord->uInfo.singleBitNtfyInfo.lastBaseAddr = addr;
        notifyRecord->uInfo.singleBitNtfyInfo.lastLocalId = devId;
        notifyRecord->uInfo.singleBitNtfyInfo.lastIsPcie = notifyRecord->uInfo.singleBitNtfyInfo.isPcie;
		if (notifyRecord->uPtr.notify != nullptr) {
            notifyRecord->uPtr.notify->SetNotifylastBaseAddr(addr);
            notifyRecord->uPtr.notify->SetNotifylastLocalId(devId);
            notifyRecord->uPtr.notify->SetNotifylastIsPcie(notifyRecord->uInfo.singleBitNtfyInfo.isPcie);
        }
        RT_LOG(RT_LOG_INFO, "lastLocalId=%u lastBaseAddr=0x%llx", devId, addr);
    }

    if (notifyRecord->uInfo.singleBitNtfyInfo.isPcie) {
        sqe->sub_type = RT_STARS_WRITE_VALUE_SUB_TYPE_NOTIFY_RECORD_IPC_PCIE;
    } else {
        sqe->sub_type = RT_STARS_WRITE_VALUE_SUB_TYPE_NOTIFY_RECORD_IPC_NO_PCIE;
    }

    sqe->write_addr_low = static_cast<uint32_t>(addr & MASK_32_BIT);
    sqe->write_addr_high = static_cast<uint32_t>((addr >> UINT32_BIT_NUM) & MASK_17_BIT);

    PrintSqe(command, "NotifyRecordTask_Ipc");
}

void ConstructSqeForNotifyRecordTask(TaskInfo *taskInfo, rtStarsSqe_t *const command)
{
    NotifyRecordTaskInfo* notifyRecord = &taskInfo->u.notifyrecordTask;
    if (notifyRecord->uInfo.singleBitNtfyInfo.isIpc == true) {
        ConstructIpcSqeForNotifyRecordTask(taskInfo, command);
    } else {
        ConstructNotifySqeForNotifyRecordTask(taskInfo, command);
    }

    Stream* const stream = taskInfo->stream;
    AtraceParams param = { stream->Device_()->Id_(), static_cast<uint32_t>(stream->Id_()), taskInfo->id,
        GetCurrentTid(), stream->Device_()->GetAtraceHandle(), {}};
    uintptr_t notifyLowEightAddr = 0;
    if (notifyRecord->uPtr.notify != nullptr) {
        notifyLowEightAddr = (RtPtrToPtr<uintptr_t, Notify *>(notifyRecord->uPtr.notify)) & 0xFFU;
    }
    param.u.notifyRecordParams = {notifyRecord->notifyId, notifyRecord->deviceId,
        static_cast<uint16_t>(notifyRecord->uInfo.singleBitNtfyInfo.isIpc), false, notifyLowEightAddr};
    AtraceSubmitLog(TYPE_NOTIFY_RECORD, param);
    RT_LOG(RT_LOG_INFO,
           "notify_record:notify_id=%u,stream_id=%d,task_id=%hu,sq_id=%u,"
           " device_id=%u,is_ipc=%u,logical remote_device=%u,phy remote_device=%u.",
           notifyRecord->notifyId, stream->Id_(), taskInfo->id, stream->GetSqId(),
           stream->Device_()->Id_(), static_cast<uint32_t>(notifyRecord->uInfo.singleBitNtfyInfo.isIpc),
           notifyRecord->deviceId, notifyRecord->phyId);
}

void SetResultForNotifyRecordTask(TaskInfo *const taskInfo, const void *const data, const uint32_t dataSize)
{
    UNUSED(taskInfo);
    UNUSED(dataSize);
    UNUSED(data);
}

#endif

}  // namespace runtime
}  // namespace cce
