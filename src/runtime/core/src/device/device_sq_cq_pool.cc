/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "runtime.hpp"
#include "device_sq_cq_pool.hpp"
#include "error_message_manage.hpp"
namespace cce {
namespace runtime {

constexpr uint32_t RT_DEVICE_SQCQ_RES_MAX_NUM = 1024U;

DeviceSqCqPool::DeviceSqCqPool(Device * const dev)
    : NoCopy(),
      device_(dev)
{
}
DeviceSqCqPool::~DeviceSqCqPool()
{
    RT_LOG(RT_LOG_DEBUG, "free sq cq pool deviceId=%u, tsId=%u, occupyList_size=%u, freeList_size=%u",
        device_->Id_(), device_->DevGetTsId(), deviceSqCqOccupyList_.size(), deviceSqCqFreeList_.size());
    for (const auto &sqCqOccupyMember : deviceSqCqOccupyList_) {
        RT_LOG(RT_LOG_DEBUG, "deviceSqCqOccupyList_ sqId=%u, cqId=%u", sqCqOccupyMember.sqId, sqCqOccupyMember.cqId);
        FreeSqCqToDrv(sqCqOccupyMember.sqId, sqCqOccupyMember.cqId);
    }
    for (const auto &sqCqFreeMember : deviceSqCqFreeList_) {
        RT_LOG(RT_LOG_DEBUG, "deviceSqCqFreeList_ sqId=%u, cqId=%u", sqCqFreeMember.sqId, sqCqFreeMember.cqId);
        FreeSqCqToDrv(sqCqFreeMember.sqId, sqCqFreeMember.cqId);
    }

    deviceSqCqOccupyList_.clear();
    deviceSqCqFreeList_.clear();
}

rtError_t DeviceSqCqPool::Init(void) const
{
    return RT_ERROR_NONE;
}

void DeviceSqCqPool::FillStreamAttrSimt(rtStreamInfoExMsg_t &infoEX) const
{
    if (!device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_SIMT)) {
        return;
    }

    infoEX.head.type = static_cast<uint32_t>(StreamInfoExHeaderType::TS_SQCQ_NORMAL_TYPE);
    const uint32_t vfId = device_->GetVfId();
    if (vfId != MAX_UINT32_NUM) {
        infoEX.head.vfid = vfId;
    }

    const uint64_t stackPhyAddr = RtPtrToValue(device_->GetSimtStackPhyBase());
    infoEX.body.kisSimtStkBaseAddrLow = static_cast<uint32_t>(stackPhyAddr);
    infoEX.body.kisSimtStkBaseAddrHigh = static_cast<uint16_t>(stackPhyAddr >> UINT32_BIT_NUM);
    infoEX.body.kisSimtWarpStkSize = device_->GetSimtWarpStkSize();
    infoEX.body.kisSimtDvgWarpStkSize = device_->GetSimtDvgWarpStkSize();
    infoEX.body.poolId = device_->GetPoolId();
    infoEX.body.poolIdMax = device_->GetPoolIdMax();
    RT_LOG(RT_LOG_DEBUG, "Alloc sq cq info: validFlag=%llu, poolId=%u, poolIdMax=%u, stackPhyAddr=%#llx,"
           " WarpStkSize=%u, DvgWarpStkSize=%u.",
           infoEX.body.validFlag, infoEX.body.poolId, infoEX.body.poolIdMax, stackPhyAddr, 
           infoEX.body.kisSimtWarpStkSize, infoEX.body.kisSimtDvgWarpStkSize);
    return;
}

rtError_t DeviceSqCqPool::AllocSqCqFromDrv(rtDeviceSqCqInfo_t * const sqCqInfo, const uint32_t drvFlag, const int32_t retryCount) const
{
    rtStreamAllocInfo_t info = {};
    constexpr uint32_t streamId = UINT32_MAX;
    rtStreamInfoExMsg_t infoEx = {};
    (void)memset_s(&infoEx, sizeof(rtStreamInfoExMsg_t), 0, sizeof(rtStreamInfoExMsg_t));
    info.streamId = streamId;
    info.priority = 0U;
    info.satMode = static_cast<uint32_t>
        ((device_->GetSatMode() == RT_OVERFLOW_MODE_INFNAN) ? RT_OVERFLOW_MODE_INFNAN : RT_OVERFLOW_MODE_SATURATION);
    info.overflowEn = false; // capture stream use default flag
    info.threadDisableFlag = static_cast<uint32_t>(Runtime::Instance()->GetDisableThread());
    info.shareSqId = device_->GetShareSqId();
    info.tsSqType = SQ_ALLOC_TYPE_RT_DEFAULT;
    info.swsqFlag = true;

    if (device_->IsDavidPlatform()) {
        FillStreamAttrSimt(infoEx);
    }

    const rtError_t error = device_->Driver_()->NormalSqCqAllocate(device_->Id_(),
        device_->DevGetTsId(), drvFlag, &sqCqInfo->sqId, &sqCqInfo->cqId,
        RtPtrToPtr<uint32_t *, rtStreamAllocInfo_t *>(&info), static_cast<uint32_t>(sizeof(info)),
        RtPtrToPtr<uint32_t *, rtStreamInfoExMsg_t *>(&infoEx), static_cast<uint32_t>(sizeof(infoEx)),
        retryCount);
    COND_RETURN_INFO(error == RT_ERROR_DRV_NO_RESOURCES, RT_ERROR_DRV_NO_RESOURCES, "no resource");
    if (unlikely(error != RT_ERROR_NONE)) {
        ERROR_RETURN(error, "[DeviceSqCqPool]Failed to alloc sq cq, retCode=0x%#x.", static_cast<uint32_t>(error));
        return error;
    }

    RT_LOG(RT_LOG_DEBUG, "Alloc sq cq info: sq_id=%u, cq_id=%u", sqCqInfo->sqId, sqCqInfo->cqId);
    return RT_ERROR_NONE;
}

rtError_t DeviceSqCqPool::SetSqRegVirtualAddrToDevice(const uint32_t sqId, const uint64_t sqRegVirtualAddr) const
{
    rtError_t error = RT_ERROR_NONE;
    if ((device_->GetSqVirtualArrBaseAddr_() != nullptr) && (sqRegVirtualAddr != 0ULL)) {
        uint64_t *deviceMemForVirAddr = RtPtrToPtr<uint64_t *, void *>(device_->GetSqVirtualArrBaseAddr_()) + sqId;
        error = device_->Driver_()->MemCopySync(RtPtrToPtr<void *, uint64_t *>(deviceMemForVirAddr), sizeof(uint64_t),
            RtPtrToPtr<const void *, const uint64_t *>(&sqRegVirtualAddr), sizeof(uint64_t), RT_MEMCPY_HOST_TO_DEVICE);
    }
    RT_LOG(RT_LOG_DEBUG, "Alloc sq cq info: sq_id=%u, error=%u", sqId, error);

    return error;
}

rtError_t DeviceSqCqPool::AllocSqRegVirtualAddr(const uint32_t sqId, uint64_t &sqRegVirtualAddr) const
{
    uint32_t addrLen = 0U;
    rtError_t error = device_->Driver_()->GetSqRegVirtualAddrBySqid(static_cast<int32_t>(device_->Id_()),
        device_->DevGetTsId(), sqId, &sqRegVirtualAddr, &addrLen);
    ERROR_RETURN_MSG_INNER(error, "Fail to get sq reg virtual addr, deviceId=%u, sqId=%u.", device_->Id_(), sqId);
    RT_LOG(RT_LOG_DEBUG, "Success to get sq=%u sq reg virtual addr length=%u.", sqId, addrLen);

    error = SetSqRegVirtualAddrToDevice(sqId, sqRegVirtualAddr);
    ERROR_RETURN_MSG_INNER(error, "Fail to copy sqid=%u virtual addr to device, error=0x%#x.", sqId,
        static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}

rtError_t DeviceSqCqPool::BatchAllocSqCq(const uint32_t allcocNum, const int32_t retryCount)
{
    COND_RETURN_INFO((deviceSqCqFreeList_.size() + deviceSqCqOccupyList_.size() + allcocNum) > RT_DEVICE_SQCQ_RES_MAX_NUM,
        RT_ERROR_DEVICE_SQCQ_POOL_RESOURCE_FULL,
        "The number of sq cq resouces has reached the maximum free_size=%u, occupy_size=%u, need allcocNum=%u.",
        deviceSqCqFreeList_.size(), deviceSqCqOccupyList_.size(), allcocNum);

    rtDeviceSqCqInfo_t sqCqInfo = {};
    for (uint32_t loop = 0U; loop < allcocNum; loop++) {
        (void)memset_s(&sqCqInfo, sizeof(sqCqInfo), 0x0, sizeof(sqCqInfo));
        rtError_t error = AllocSqCqFromDrv(&sqCqInfo, TSDRV_FLAG_NO_SQ_MEM, retryCount);
        COND_RETURN_INFO((error != RT_ERROR_NONE), error, "alloc sq cq, loop=%u, retCode=0x%#x.",
            loop, static_cast<uint32_t>(error));

        error = AllocSqRegVirtualAddr(sqCqInfo.sqId, sqCqInfo.sqRegVirtualAddr);
        /* Failure rollback: The SQ and CQ requested in the current loop need to be released;
           instead, those obtained in previous loops are retained in the freeList. */
        COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, (void)FreeSqCqToDrv(sqCqInfo.sqId, sqCqInfo.cqId),
            "Failed to alloc sq reg addr, loop=%u, retCode=0x%#x.", loop, static_cast<uint32_t>(error));

        deviceSqCqFreeList_.push_back(sqCqInfo);
        RT_LOG(RT_LOG_DEBUG, "Alloc SqCq: sq_id=%u, cq_id=%u, virtualAddr=%u, error=%u",
            sqCqInfo.sqId, sqCqInfo.cqId, sqCqInfo.sqRegVirtualAddr, error);
    }

    return RT_ERROR_NONE;
}

void DeviceSqCqPool::PreAllocSqCq(void)
{
    RT_LOG(RT_LOG_DEBUG, "PreAllocSqCq once");

    const std::lock_guard<std::mutex> deviceSqCqLock(deviceSqCqLock_);
    const rtError_t error = BatchAllocSqCq(1U, 0); // alloc sq cq only once
    COND_RETURN_VOID_WARN(error != RT_ERROR_NONE, "alloc sq cq from hal, retCode=0x%#x.",
        static_cast<uint32_t>(error));

    return;
}

rtError_t DeviceSqCqPool::AllocSqCq(const uint32_t allcocNum, rtDeviceSqCqInfo_t * const sqCqList)
{
    RT_LOG(RT_LOG_DEBUG, "deviceId=%u, tsId=%u, allcocNum=%u", device_->Id_(), device_->DevGetTsId(), allcocNum);
    if ((allcocNum == 0U) || (sqCqList == nullptr)) {
        return RT_ERROR_INVALID_VALUE;
    }
    const std::lock_guard<std::mutex> deviceSqCqLock(deviceSqCqLock_);
    if (deviceSqCqFreeList_.size() < allcocNum) {
        const rtError_t error = BatchAllocSqCq(allcocNum - static_cast<uint32_t>(deviceSqCqFreeList_.size()));
        COND_RETURN_INFO((error != RT_ERROR_NONE), error, "Failed to alloc sq cq allcocNum=%u, retCode=0x%#x.",
            allcocNum, static_cast<uint32_t>(error));
    }
    RT_LOG(RT_LOG_DEBUG, "before deviceId=%u, tsId=%u, occupyList_size=%u, freeList_size=%u",
        device_->Id_(), device_->DevGetTsId(), deviceSqCqOccupyList_.size(), deviceSqCqFreeList_.size());
    rtDeviceSqCqInfo_t sqCqInfo = {};
    uint32_t hasAllcocNum = 0;
    while ((hasAllcocNum < allcocNum) && (deviceSqCqFreeList_.size() != 0U)) {
        sqCqInfo = deviceSqCqFreeList_.front();
        sqCqList[hasAllcocNum] = sqCqInfo;
        deviceSqCqFreeList_.pop_front();
        deviceSqCqOccupyList_.push_back(sqCqInfo);
        hasAllcocNum++;
    }

    RT_LOG(RT_LOG_DEBUG, "after deviceId=%u, tsId=%u, occupyList_size=%u, freeList_size=%u",
        device_->Id_(), device_->DevGetTsId(), deviceSqCqOccupyList_.size(), deviceSqCqFreeList_.size());

    return RT_ERROR_NONE;
}

rtError_t DeviceSqCqPool::AllocSqCqForAutoSplit(rtDeviceSqCqInfo_t * const sqCqInfo) const
{
    RT_LOG(RT_LOG_DEBUG, "deviceId=%u, tsId=%u", device_->Id_(), device_->DevGetTsId());
    COND_RETURN_INFO((sqCqInfo == nullptr), RT_ERROR_INVALID_VALUE,
        "sqCqInfo is nullptr, deviceId=%u.", device_->Id_());
    rtError_t error = AllocSqCqFromDrv(sqCqInfo, TSDRV_FLAG_NO_SQ_MEM, PRE_ALLOC_SQ_CQ_RETRY_MAX_COUNT);
    COND_RETURN_INFO((error != RT_ERROR_NONE), error, "alloc sq cq, retCode=0x%#x.",
        static_cast<uint32_t>(error));
    error = AllocSqRegVirtualAddr(sqCqInfo->sqId, sqCqInfo->sqRegVirtualAddr);
    /* Failure rollback: Free the SQ/CQ just allocated from driver */
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, (void)FreeSqCqToDrv(sqCqInfo->sqId, sqCqInfo->cqId),
        "Failed to alloc sq reg addr, retCode=0x%#x.", static_cast<uint32_t>(error));

    RT_LOG(RT_LOG_DEBUG, "Alloc SqCq: sq_id=%u, cq_id=%u, error=%u",
        sqCqInfo->sqId, sqCqInfo->cqId, error);

    return RT_ERROR_NONE;
}

rtError_t DeviceSqCqPool::FreeSqCqToDrv(const uint32_t sqId, const uint32_t cqId) const
{
    if (device_->GetDevRunningState() != static_cast<uint32_t>(DEV_RUNNING_DOWN)) {
        constexpr uint32_t drvFlag = 0U;
        RT_LOG(RT_LOG_DEBUG, "free SqCq: sq_id=%u, cq_id=%u", sqId, cqId);

        const rtError_t error = device_->Driver_()->NormalSqCqFree(device_->Id_(), device_->DevGetTsId(), drvFlag, sqId, cqId);
        ERROR_RETURN(error, "Failed to free sq cq, retCode=0x%#x.", static_cast<uint32_t>(error));
    }

    return RT_ERROR_NONE;
}

rtError_t DeviceSqCqPool::FreeSqCqLazy(const rtDeviceSqCqInfo_t * const sqCqList, const uint32_t freeNum)
{
    RT_LOG(RT_LOG_DEBUG, "deviceId=%u, tsId=%u, freeNum=%u", device_->Id_(), device_->DevGetTsId(), freeNum);
    if ((freeNum == 0U) || (sqCqList == nullptr)) {
        return RT_ERROR_INVALID_VALUE;
    }
    const std::lock_guard<std::mutex> deviceSqCqLock(deviceSqCqLock_);
    for (uint32_t listId = 0; listId < freeNum; listId++) {
        uint32_t sqId = sqCqList[listId].sqId;
        uint32_t cqId = sqCqList[listId].cqId;
        auto it = std::find_if(deviceSqCqOccupyList_.begin(), deviceSqCqOccupyList_.end(),
            [sqId, cqId](const rtDeviceSqCqInfo_t& info) {
                return (info.sqId == sqId) && (info.cqId == cqId);
            });
        if (it != deviceSqCqOccupyList_.end()) {
            (void)deviceSqCqOccupyList_.erase(it);
            deviceSqCqFreeList_.push_back(sqCqList[listId]);
        }
        RT_LOG(RT_LOG_DEBUG, "deviceId=%u, tsId=%u, sqId=%u, cqId=%u, occupyList_size=%u, freeList_size=%u, isMatchSqIdCqId=%u",
            device_->Id_(), device_->DevGetTsId(), sqCqList[listId].sqId, sqCqList[listId].cqId,
            deviceSqCqOccupyList_.size(), deviceSqCqFreeList_.size(), (it != deviceSqCqOccupyList_.end()));
    }

    return RT_ERROR_NONE;
}

rtError_t DeviceSqCqPool::FreeSqCqImmediately(const rtDeviceSqCqInfo_t * const sqCqList, const uint32_t freeNum)
{
    RT_LOG(RT_LOG_DEBUG, "deviceId=%u, tsId=%u, freeNum=%u", device_->Id_(), device_->DevGetTsId(), freeNum);
    if ((freeNum == 0U) || (sqCqList == nullptr)) {
        return RT_ERROR_INVALID_VALUE;
    }
    const std::lock_guard<std::mutex> deviceSqCqLock(deviceSqCqLock_);
    for (uint32_t listId = 0; listId < freeNum; listId++) {
        uint32_t sqId = sqCqList[listId].sqId;
        uint32_t cqId = sqCqList[listId].cqId;
        auto it = std::find_if(deviceSqCqOccupyList_.begin(), deviceSqCqOccupyList_.end(),
            [sqId, cqId](const rtDeviceSqCqInfo_t& info) {
                return (info.sqId == sqId) && (info.cqId == cqId);
            });
        if (it != deviceSqCqOccupyList_.end()) {
            const rtError_t error = FreeSqCqToDrv(sqCqList[listId].sqId, sqCqList[listId].cqId);
            if (error != RT_ERROR_NONE) {
                RT_LOG(RT_LOG_EVENT, "FreeSqCqToDrv fail deviceId=%u, tsId=%u, sqId=%u, cqId=%u",
                    device_->Id_(), device_->DevGetTsId(), sqCqList[listId].sqId, sqCqList[listId].cqId);
                continue;
            }
            (void)deviceSqCqOccupyList_.erase(it);
        }
        RT_LOG(RT_LOG_DEBUG, "deviceId=%u, tsId=%u, sqId=%u, cqId=%u, occupyList_size=%u, freeList_size=%u, isMatchSqIdCqId=%u",
            device_->Id_(), device_->DevGetTsId(), sqCqList[listId].sqId, sqCqList[listId].cqId,
            deviceSqCqOccupyList_.size(), deviceSqCqFreeList_.size(), (it != deviceSqCqOccupyList_.end()));
    }

    return RT_ERROR_NONE;
}

uint32_t DeviceSqCqPool::GetSqCqPoolTotalResNum(void)
{
    const std::lock_guard<std::mutex> deviceSqCqLock(deviceSqCqLock_);
    RT_LOG(RT_LOG_DEBUG, "deviceId=%u, tsId=%u, occupyList_size=%u, freeList_size=%u",
        device_->Id_(), device_->DevGetTsId(), deviceSqCqOccupyList_.size(), deviceSqCqFreeList_.size());

    return static_cast<uint32_t>(deviceSqCqFreeList_.size() + deviceSqCqOccupyList_.size());
}

uint32_t DeviceSqCqPool::GetSqCqPoolFreeResNum(void)
{
    const std::lock_guard<std::mutex> deviceSqCqLock(deviceSqCqLock_);
    return static_cast<uint32_t>(deviceSqCqFreeList_.size());
}

rtError_t DeviceSqCqPool::TryFreeSqCqToDrv(void)
{
    rtError_t error = RT_ERROR_NONE;

    const std::lock_guard<std::mutex> deviceSqCqLock(deviceSqCqLock_);
    if (deviceSqCqFreeList_.size() != 0U) {
        rtDeviceSqCqInfo_t sqCqInfo = {};
        sqCqInfo = deviceSqCqFreeList_.front();
        error = FreeSqCqToDrv(sqCqInfo.sqId, sqCqInfo.cqId);
        if (error == RT_ERROR_NONE) {
            deviceSqCqFreeList_.pop_front();
        }
    }

    return error;
}

void DeviceSqCqPool::FreeOccupyList(void)
{
    deviceSqCqFreeList_.splice(deviceSqCqFreeList_.end(), deviceSqCqOccupyList_);
    return;
}

void DeviceSqCqPool::FreeReallocatedSqCqToDrv(
    const std::list<rtDeviceSqCqInfo_t>::iterator begin,
    const std::list<rtDeviceSqCqInfo_t>::iterator end) const {
    for (auto it = begin; it != end; ++it) {
        (void)FreeSqCqToDrv(it->sqId, it->cqId);
    }
}

rtError_t DeviceSqCqPool::ReAllocSqCqForFreeList(void)
{
    uint32_t drvFlag = (TSDRV_FLAG_SPECIFIED_SQ_ID | TSDRV_FLAG_SPECIFIED_CQ_ID | TSDRV_FLAG_NO_SQ_MEM);

    for (auto it = deviceSqCqFreeList_.begin(); it != deviceSqCqFreeList_.end(); ++it) {
        rtError_t error = AllocSqCqFromDrv(&(*it), drvFlag);
        COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, FreeReallocatedSqCqToDrv(deviceSqCqFreeList_.begin(), it),
            "Fail to realloc sqcq from driver, deviceId=%u, sqId=%u.", device_->Id_(), it->sqId);
        error = AllocSqRegVirtualAddr(it->sqId, it->sqRegVirtualAddr);
        COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, FreeReallocatedSqCqToDrv(deviceSqCqFreeList_.begin(), ++it),
            "Failed to alloc sq reg addr from driver, retCode=0x%#x.", static_cast<uint32_t>(error));
    }
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce
