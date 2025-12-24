/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stream_sqcq_manage.hpp"
#include "runtime.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
StreamSqCqManage::StreamSqCqManage(Device * const dev) : NoCopy(), device_(dev), normalCq_(UINT32_MAX) {}
void StreamSqCqManage::FillStreamInfoEx(const Stream * const stm, rtStreamInfoExMsg_t &infoEX) const
{
    if (!stm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_SIMT)) {
        return;
    }

    infoEX.head.type = static_cast<uint32_t>(StreamInfoExHeaderType::TS_SQCQ_NORMAL_TYPE);
    const uint32_t vfId = stm->Device_()->GetVfId();
    if (vfId != MAX_UINT32_NUM) {
        infoEX.head.vfid = vfId;
    }
    if ((stm->Flags() & RT_STREAM_ACSQ_LOCK) != 0U) {
        infoEX.body.validFlag |= static_cast<uint64_t>(InfoExValidFlag::INFO_EX_BODY_FLAG_STREAM);
        infoEX.body.streamFlag.u32 = 0x3U;
    }
    if (((stm->Flags() & RT_STREAM_DQS_INTER_CHIP) != 0U) && 
        stm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_STREAM_DQS_INTER_CHIP)) {
        infoEX.body.validFlag |= static_cast<uint64_t>(InfoExValidFlag::INFO_EX_BODY_FLAG_STREAM);
        infoEX.body.streamFlag.bits.dqsInterChip = 1U;
    }

    const uint64_t stackPhyAddr = RtPtrToValue(stm->Device_()->GetSimtStackPhyBase());
    infoEX.body.kisSimtStkBaseAddrLow = static_cast<uint32_t>(stackPhyAddr);
    infoEX.body.kisSimtStkBaseAddrHigh = static_cast<uint16_t>(stackPhyAddr >> UINT32_BIT_NUM);
    infoEX.body.kisSimtWarpStkSize = device_->GetSimtWarpStkSize();
    infoEX.body.kisSimtDvgWarpStkSize = device_->GetSimtDvgWarpStkSize();
    infoEX.body.poolId = stm->Device_()->GetPoolId();
    infoEX.body.poolIdMax = stm->Device_()->GetPoolIdMax();
    RT_LOG(RT_LOG_DEBUG, "Alloc sq cq info: validFlag=%llu, poolId=%u, poolIdMax=%u, stackPhyAddr=%#llx,"
           " WarpStkSize=%u, DvgWarpStkSize=%u.",
           infoEX.body.validFlag, infoEX.body.poolId, infoEX.body.poolIdMax, stackPhyAddr, 
           infoEX.body.kisSimtWarpStkSize, infoEX.body.kisSimtDvgWarpStkSize);
}

rtError_t StreamSqCqManage::AllocStreamSqCq(const Stream * const newStm, const uint32_t priority, uint32_t drvFlag,
                                            uint32_t &sqId, uint32_t &cqId)
{
    uint32_t info[SQCQ_RTS_INFO_LENGTH] = {};
    const uint32_t streamId = static_cast<uint32_t>(newStm->Id_());
    rtStreamAllocInfo_t * const infoPtr = RtPtrToPtr<rtStreamAllocInfo_t *>(info);
    rtStreamInfoExMsg_t infoEx;
    (void)memset_s(&infoEx, sizeof(rtStreamInfoExMsg_t), 0, sizeof(rtStreamInfoExMsg_t));
    infoPtr->streamId = streamId;
    infoPtr->priority = priority;
    infoPtr->satMode = (device_->GetSatMode() == RT_OVERFLOW_MODE_INFNAN) ? 1U : 0U;
    infoPtr->overflowEn = newStm->IsOverflowEnable();
    infoPtr->threadDisableFlag = static_cast<uint32_t>(Runtime::Instance()->GetDisableThread());
    infoPtr->shareSqId = device_->GetShareSqId();
    infoPtr->tsSqType = newStm->GetTsSqAllocType();
    infoPtr->swsqFlag = true;

    const std::lock_guard<std::mutex> stmLock(streamMapLock_);
    sqId = 0U;
    cqId = 0U;
    // One-to-one mapping between SQ and CQ for stars, CQ not reuse
    if ((!(device_->IsStarsPlatform())) &&
        ((drvFlag & (static_cast<uint32_t>(TSDRV_FLAG_REMOTE_ID))) == 0U)) {
        if (!streamIdToSqIdMap_.empty()) {
            drvFlag |= (static_cast<uint32_t>(TSDRV_FLAG_REUSE_CQ));
            // cqId reuse exist cq id.
            cqId = normalCq_;
        }
    }
    if ((newStm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DRIVER_RESOURCE_SQCQ_ALLOC_EX)) &&
        (newStm->Device_()->GetVfId() != MAX_UINT32_NUM)) {
        drvFlag |= (static_cast<uint32_t>(TSDRV_FLAG_RANGE_ID));
    }
    const rtError_t error = Add(streamId, drvFlag, sqId, cqId, info, sizeof(info),
                                RtPtrToPtr<uint32_t *>(&infoEx), sizeof(rtStreamInfoExMsg_t));
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "[SqCqManage]Alloc sq cq fail, stream_id=%u, retCode=%#x.",
            streamId, static_cast<uint32_t>(error));
        return error;
    }
    if (((drvFlag & (static_cast<uint32_t>(TSDRV_FLAG_REUSE_CQ))) == 0U) &&
        ((drvFlag & (static_cast<uint32_t>(TSDRV_FLAG_REMOTE_ID))) == 0U)) {
        normalCq_ = cqId;
    }
    RT_LOG(RT_LOG_DEBUG, "Alloc sq cq info: stream_id=%u, sq_id=%u, cq_id=%u, normal_cq_id=%u, drv_flag=%#x.",
           streamId, sqId, cqId, normalCq_, drvFlag);
    return RT_ERROR_NONE;
}

rtError_t StreamSqCqManage::AllocStarsV2StreamSqCq(const Stream * const newStm, const uint32_t priority, 
    uint32_t drvFlag, uint32_t &sqId, uint32_t &cqId, uint64_t &sqAddr)
{
    uint32_t info[SQCQ_RTS_INFO_LENGTH] = {};
    const uint32_t streamId = static_cast<uint32_t>(newStm->Id_());
    rtStreamAllocInfo_t * const infoPtr = RtPtrToPtr<rtStreamAllocInfo_t *>(info);
    rtStreamInfoExMsg_t infoEx;
    (void)memset_s(&infoEx, sizeof(rtStreamInfoExMsg_t), 0, sizeof(rtStreamInfoExMsg_t));
    infoPtr->streamId = streamId;
    infoPtr->priority = priority;
    infoPtr->satMode = (device_->GetSatMode() == RT_OVERFLOW_MODE_INFNAN) ? 1U : 0U;
    infoPtr->overflowEn = newStm->IsOverflowEnable();
    infoPtr->threadDisableFlag = static_cast<uint32_t>(Runtime::Instance()->GetDisableThread());
    infoPtr->shareSqId = device_->GetShareSqId();
    infoPtr->tsSqType = newStm->GetTsSqAllocType();
    infoPtr->swsqFlag = false;

    const std::lock_guard<std::mutex> stmLock(streamMapLock_);
    sqId = 0U;
    cqId = 0U;
    FillStreamInfoEx(newStm, infoEx);
    if(newStm->Device_()->GetVfId() != MAX_UINT32_NUM) {
        drvFlag |= (static_cast<uint32_t>(TSDRV_FLAG_RANGE_ID));
    }
    rtError_t error = Alloc(streamId, drvFlag, sqId, cqId, info, sizeof(info),
                                  RtPtrToPtr<uint32_t *>(&infoEx), sizeof(rtStreamInfoExMsg_t));
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "NormalSqCqAllocate fail, retCode=%#x.", error);
    error = device_->Driver_()->GetSqAddrInfo(device_->Id_(), device_->DevGetTsId(), sqId, sqAddr);
    COND_LOG(error != RT_ERROR_NONE, "hal may not support get sq addr info, device_id=%u, retCode=%#x.", device_->Id_(), error);
    RT_LOG(RT_LOG_DEBUG, "Alloc sq cq: device_id=%u, stream_id=%u, sq_id=%u, cq_id=%u, drv_flag=%#x,"
           "sq_addr=0x%llx.", device_->Id_(), streamId, sqId, cqId, drvFlag, sqAddr);
    return error;
}

rtError_t StreamSqCqManage::UpdateStreamSqCq(Stream *newStm)
{
    uint32_t info[SQCQ_RTS_INFO_LENGTH] = {};
    const uint32_t streamId = static_cast<uint32_t>(newStm->Id_());
    uint32_t sqId = newStm->GetSqId();
    uint32_t cqId = newStm->GetCqId();
    uint32_t logicCqId = newStm->GetLogicalCqId();
    rtStreamAllocInfo_t * const infoPtr = RtPtrToPtr<rtStreamAllocInfo_t *>(info);
    infoPtr->streamId = streamId;
    infoPtr->priority = newStm->GetPriority();
    infoPtr->satMode = (device_->GetSatMode() == RT_OVERFLOW_MODE_INFNAN) ? 1U : 0U;
    infoPtr->overflowEn = newStm->IsOverflowEnable();
    infoPtr->threadDisableFlag = static_cast<uint32_t>(Runtime::Instance()->GetDisableThread());
    infoPtr->shareSqId = device_->GetShareSqId();
    infoPtr->tsSqType = newStm->GetTsSqAllocType();
    infoPtr->swsqFlag = true;

    const std::lock_guard<std::mutex> stmLock(streamMapLock_);
    uint32_t drvFlag = TSDRV_FLAG_RSV_CQ_ID;
    rtError_t error = device_->Driver_()->LogicCqFree(device_->Id_(), device_->DevGetTsId(), logicCqId, drvFlag);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "LogicCqFree fail, retCode=%#x.", error);

    drvFlag = (TSDRV_FLAG_RSV_SQ_ID | TSDRV_FLAG_RSV_CQ_ID);
    error = device_->Driver_()->NormalSqCqFree(
        device_->Id_(), device_->DevGetTsId(), drvFlag, sqId, cqId);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "NormalSqCqFree fail, retCode=%#x.", error);

    rtStreamInfoExMsg_t infoEx;
    (void)memset_s(&infoEx, sizeof(rtStreamInfoExMsg_t), 0, sizeof(rtStreamInfoExMsg_t));
    drvFlag = (TSDRV_FLAG_SPECIFIED_SQ_ID | TSDRV_FLAG_SPECIFIED_CQ_ID);
    FillStreamInfoEx(newStm, infoEx);
    error = device_->Driver_()->NormalSqCqAllocate(device_->Id_(),
        device_->DevGetTsId(), drvFlag, &sqId, &cqId, info, sizeof(info),
        RtPtrToPtr<uint32_t *>(&infoEx), sizeof(rtStreamInfoExMsg_t));

    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "NormalSqCqAllocate fail, retCode=%#x.", error);

    drvFlag = TSDRV_FLAG_SPECIFIED_CQ_ID;
    error = device_->Driver_()->LogicCqAllocateV2(
        device_->Id_(), device_->DevGetTsId(), streamId, logicCqId, newStm->IsBindDvppGrp(), drvFlag);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "LogicCqAllocateV2 fail, retCode=%#x.", error);

    if (newStm->GetSqBaseAddr() != 0ULL) {
        uint64_t sqAddr = 0ULL;
        error = device_->Driver_()->GetSqAddrInfo(device_->Id_(), device_->DevGetTsId(), sqId, sqAddr);
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "GetSqAddrInfo fail, retCode=%#x.", error);
        newStm->SetSqBaseAddr(sqAddr);
    }

    COND_RETURN_ERROR(
        ((newStm->GetSqId() != sqId) || (newStm->GetCqId() != cqId) || (newStm->GetLogicalCqId() != logicCqId)),
        RT_ERROR_DRV_ERR,
        "stream_id=%u, sqId=%u, cqId=%u, logicCqId=%u, tmp_sq_id=%u, tmp_cq_id=%u, tmpLogicCqId=%u.",
        streamId, newStm->GetSqId(), newStm->GetCqId(), newStm->GetLogicalCqId(), sqId, cqId, logicCqId);
    return RT_ERROR_NONE;
}

rtError_t StreamSqCqManage::ReAllocSqCqId(const Stream * const newStm)
{
    uint32_t info[SQCQ_RTS_INFO_LENGTH] = {};
    const uint32_t streamId = static_cast<uint32_t>(newStm->Id_());
    uint32_t sqId = newStm->GetSqId();
    uint32_t cqId = newStm->GetCqId();
    uint32_t logicCqId = newStm->GetLogicalCqId();
    rtStreamAllocInfo_t * const infoPtr = RtPtrToPtr<rtStreamAllocInfo_t *>(info);
    infoPtr->streamId = streamId;
    infoPtr->priority = newStm->GetPriority();
    infoPtr->satMode = (device_->GetSatMode() == RT_OVERFLOW_MODE_INFNAN) ? 1U : 0U;
    infoPtr->overflowEn = newStm->IsOverflowEnable();
    infoPtr->threadDisableFlag = static_cast<uint32_t>(Runtime::Instance()->GetDisableThread());
    infoPtr->shareSqId = device_->GetShareSqId();
    infoPtr->tsSqType = newStm->GetTsSqAllocType();
    infoPtr->swsqFlag = true;

    const std::lock_guard<std::mutex> stmLock(streamMapLock_);
    rtStreamInfoExMsg_t infoEx{};
    uint32_t drvFlag = (TSDRV_FLAG_SPECIFIED_SQ_ID | TSDRV_FLAG_SPECIFIED_CQ_ID);
    if (newStm->GetTsSqAllocType() == SQ_ALLOC_TYPE_TS_FFTS_DSA) {
        drvFlag |= TSDRV_FLAG_ONLY_SQCQ_ID;
    }
    rtError_t error = device_->Driver_()->NormalSqCqAllocate(device_->Id_(), device_->DevGetTsId(), drvFlag,
        &sqId, &cqId, info, sizeof(info), RtPtrToPtr<uint32_t *>(&infoEx), sizeof(rtStreamInfoExMsg_t));
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "NormalSqCqAllocate fail, retCode=%#x.", error);
    COND_RETURN_ERROR(((newStm->GetSqId() != sqId) || (newStm->GetCqId() != cqId)), RT_ERROR_DRV_ERR,
        "stream_id=%u, sqId=%u, cqId=%u, tmp_sq_id=%u, tmp_cq_id=%u.",
        streamId, newStm->GetSqId(), newStm->GetCqId(), sqId, cqId);

    if (newStm->GetTsSqAllocType() != SQ_ALLOC_TYPE_TS_FFTS_DSA) {
        drvFlag = TSDRV_FLAG_SPECIFIED_CQ_ID;
        error = device_->Driver_()->LogicCqAllocateV2(
            device_->Id_(), device_->DevGetTsId(), streamId, logicCqId, newStm->IsBindDvppGrp(), drvFlag);
        COND_RETURN_ERROR(((error != RT_ERROR_NONE) || (newStm->GetLogicalCqId() != logicCqId)), error,
            "LogicCqAllocateV2 fail, stream_id=%u, logicCqId=%u, tmpLogicCqId=%u, retCode=%d.",
            streamId, newStm->GetLogicalCqId(), logicCqId, error);
 
        error = device_->Driver_()->StreamBindLogicCq(device_->Id_(), device_->DevGetTsId(), streamId, logicCqId);
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
            "StreamBindLogicCq failed, streamId=%d, deviceId=%u, sqId=%u, logicCqId=%u, ret=%d.",
            streamId, device_->Id_(), newStm->GetSqId(), logicCqId, error);
    }

    RT_LOG(RT_LOG_DEBUG, "ReAllocSqCqId sq cq success: device_id=%u, stream_id=%u, sq_id=%u, cq_id=%u, logicCqId=%u.",
           device_->Id_(), streamId, sqId, cqId, logicCqId);
    return RT_ERROR_NONE;
}
 
rtError_t StreamSqCqManage::Add(const uint32_t streamId, uint32_t drvFlag, uint32_t &sqId, uint32_t &cqId,
                                uint32_t * const info, const uint32_t len, uint32_t * const msg,
                                const uint32_t msgLen)
{
    rtError_t error = Alloc(streamId, drvFlag, sqId, cqId, info, len, msg, msgLen);
    if (error == RT_ERROR_SQID_FULL) {
        // One-to-one mapping between SQ and CQ for stars, reuse not allowed
        if ((device_->IsStarsPlatform()) ||
            ((drvFlag & (static_cast<uint32_t>(TSDRV_FLAG_REMOTE_ID))) != 0U)) {
            return error;
        }
        drvFlag |= static_cast<uint32_t>(static_cast<uint32_t>(TSDRV_FLAG_REUSE_CQ) | static_cast<uint32_t>(TSDRV_FLAG_REUSE_SQ));
        if (streamIdToSqIdMap_.empty()) {
            return RT_ERROR_SQ_NO_EXIST_SQ_TO_REUSE;
        }

        for (auto itor = streamIdToSqIdMap_.begin(); itor != streamIdToSqIdMap_.end(); ++itor) {
            // Query the low-frequency(less than 5) sqId in the SQCQ ID map table, to apply for a new SQCQ.
            if (sqIdRefMap_[itor->second] < 5U) { // 5:frequency
                sqId = itor->second;
                error = Alloc(streamId, drvFlag, sqId, cqId, info, len, msg, msgLen);
                return error;
            }
        }

        for (auto itor = streamIdToSqIdMap_.begin(); itor != streamIdToSqIdMap_.end(); ++itor) {
            // Reuse the first host side sqId to apply for a new SQCQ.
            if (sqIdRefMap_[itor->second] != UINT32_MAX) {
                sqId = itor->second;
                error = Alloc(streamId, drvFlag, sqId, cqId, info, len, msg, msgLen);
                return error;
            }
        }
    }
    return error;
}

rtError_t StreamSqCqManage::Alloc(const uint32_t streamId, const uint32_t drvFlag, uint32_t &sqId, uint32_t &cqId,
                                  uint32_t * const info, const uint32_t len, uint32_t * const msg,
                                  const uint32_t msgLen)
{
    const auto itor = streamIdToSqIdMap_.find(streamId);
    if (unlikely(itor != streamIdToSqIdMap_.end())) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Stream repeat alloc, streamId=%u, sqId=%u, cqId=%u.", streamId,
            itor->second, normalCq_);
        return RT_ERROR_STREAM_DUPLICATE;
    }

    RT_LOG(RT_LOG_INFO, "deviceId=%u, tsId=%u, drvFlag=%u", device_->Id_(), device_->DevGetTsId(), drvFlag);
    const rtError_t error = device_->Driver_()->NormalSqCqAllocate(device_->Id_(),
        device_->DevGetTsId(), drvFlag, &sqId, &cqId, info, len, msg, msgLen);
    if (unlikely(error != RT_ERROR_NONE)) {
        // no log here, may be retry outside
        return error;
    }
    streamIdToSqIdMap_[streamId] = sqId;
    sqIdToStreamIdMap_[sqId] = streamId;

    if ((drvFlag & (static_cast<uint32_t>(TSDRV_FLAG_REMOTE_ID))) == 0U) {
        ++sqIdRefMap_[sqId];
        return RT_ERROR_NONE;
    }

    if (sqIdRefMap_.count(sqId) != 0U) {
        RT_LOG(RT_LOG_ERROR, "The remote SQ cannot be reused, deviceId=%u, sqId=%u.", device_->Id_(), sqId);
        return RT_ERROR_REMOTE_SQID_DUPLICATE;
    }
    sqIdRefMap_[sqId] = UINT32_MAX; // Ensure that the remote SQ is not reused.
    return RT_ERROR_NONE;
}

rtError_t StreamSqCqManage::DeAllocStreamSqCq(const uint32_t streamId, const uint32_t normalCqId, uint32_t drvFlag)
{
    uint32_t isSqIdNeedRelease = SQID_NEED_RELEASE;
    drvFlag |= (static_cast<uint32_t>(TSDRV_FLAG_REUSE_CQ));

    const std::lock_guard<std::mutex> stmLock(streamMapLock_);

    const auto itor = streamIdToSqIdMap_.find(streamId);
    if (itor == streamIdToSqIdMap_.end()) {
        RT_LOG(RT_LOG_INFO, "There is no sq, stream_id=%u.", streamId);
        return RT_ERROR_NONE;
    }

    const uint32_t sqId = itor->second;
    uint32_t cqId = normalCq_;

    (void)streamIdToSqIdMap_.erase(streamId);
    (void)sqIdToStreamIdMap_.erase(sqId);
    RT_LOG(RT_LOG_DEBUG, "streamIdToSqIdMap remove:stream_id=%u, sq_id=%u, cq_id=%u.",
           streamId, sqId, cqId);

    for (auto it = streamIdToSqIdMap_.begin(); it != streamIdToSqIdMap_.end(); it++) {
        if (it->second == sqId) {
            isSqIdNeedRelease = SQID_NOT_NEED_RELEASE;
            break;
        }
    }

    const auto iter = sqIdRefMap_.find(sqId);
    if (iter == sqIdRefMap_.end()) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Can not find stream map by sqId=%u.", sqId);
        return RT_ERROR_STREAM_NOT_EXIST;
    } else if ((drvFlag & (static_cast<uint32_t>(TSDRV_FLAG_REMOTE_ID))) != 0U) {
        // The remote SQ is not reused, and can be directly released.
        (void)sqIdRefMap_.erase(iter);
    } else {
        --(iter->second);
        if (iter->second == 0U) {
            (void)sqIdRefMap_.erase(iter);
        }
    }

    if (isSqIdNeedRelease == SQID_NEED_RELEASE) {
        // One-to-one mapping between SQ and CQ for stars, CQ not reuse
        if ((device_->IsStarsPlatform()) ||
            ((drvFlag & (static_cast<uint32_t>(TSDRV_FLAG_REMOTE_ID))) != 0U)) {
            drvFlag &= (~(static_cast<uint32_t>(TSDRV_FLAG_REUSE_CQ)));
            RT_LOG(RT_LOG_INFO, "deviceId=%u, tsId=%u, drvFlag=%u",
                device_->Id_(), device_->DevGetTsId(), drvFlag);
            cqId = normalCqId;
        }
        if (streamIdToSqIdMap_.empty()) {
            drvFlag &= (~(static_cast<uint32_t>(TSDRV_FLAG_REUSE_CQ)));
            normalCq_ = UINT32_MAX;
        }
        (void)device_->Driver_()->NormalSqCqFree(device_->Id_(), device_->DevGetTsId(), drvFlag, sqId, cqId);
        if (Runtime::Instance()->GetDisableThread()) {
            (void)sqIdMutex_.erase(sqId);
        }
        RT_LOG(RT_LOG_INFO, "[SqCqManage]success to release sq, sq_id=%u, cq_id=%u, stream_id=%u, "
            "is_sq_need_release=%u, drvFlag=%#x.", sqId, cqId, streamId, isSqIdNeedRelease, drvFlag);
    } else {
        RT_LOG(RT_LOG_INFO, "[SqCqManage]end to release sq, sq is also reuse, sq_id=%u, cq_id=%u, stream_id=%u, "
            "is_sq_need_release=%u, drv_flag=%#x.", sqId, cqId, streamId, isSqIdNeedRelease, drvFlag);
    }

    return RT_ERROR_NONE;
}

std::mutex *StreamSqCqManage::GetSqMutex(const uint32_t sqId)
{
    if (Runtime::Instance()->GetDisableThread()) {
        const std::lock_guard<std::mutex> stmLock(streamMapLock_);
        return &sqIdMutex_[sqId];
    }
    return nullptr;
}

rtError_t StreamSqCqManage::GetSqId(const uint32_t streamId, uint32_t &sqId)
{
    const std::lock_guard<std::mutex> stmLock(streamMapLock_);
    const auto itor = streamIdToSqIdMap_.find(streamId);
    if (itor == streamIdToSqIdMap_.end()) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Can not find stream map by stream_id=%u.", streamId);
        return RT_ERROR_STREAM_NOT_EXIST;
    }
    sqId = itor->second;
    return RT_ERROR_NONE;
}

rtError_t StreamSqCqManage::GetStreamIdBySqId(const uint32_t sqId, uint32_t &streamId)
{
    const std::lock_guard<std::mutex> stmLock(streamMapLock_);
    const auto itor = sqIdToStreamIdMap_.find(sqId);
    if (itor == sqIdToStreamIdMap_.end()) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Can not find stream_id by sq_id=%u.", sqId);
        return RT_ERROR_STREAM_NOT_EXIST;
    }
    streamId = itor->second;
    return RT_ERROR_NONE;
}

void StreamSqCqManage::GetDefaultCqId(uint32_t * const cqId)
{
    const std::lock_guard<std::mutex> stmLock(streamMapLock_);
    if (streamIdToSqIdMap_.empty()) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Stream map is empty.");
        *cqId = 0xFFFFU;
        return;
    }
    *cqId = normalCq_;
}


void StreamSqCqManage::GetAllStreamId(std::vector<uint32_t> &streams)
{
    const std::lock_guard<std::mutex> stmLock(streamIdToStreamMapLock_);
    for (auto &item : streams_) {
        streams.emplace_back(item.first);
    }
}

void StreamSqCqManage::GetAllStream(std::vector<Stream *> &streams)
{
    const std::lock_guard<std::mutex> stmLock(streamIdToStreamMapLock_);
    for (auto &item : streams_) {
        streams.emplace_back(item.second);
    }
}

rtError_t StreamSqCqManage::GetLogicCqIdWithoutLock(const uint32_t streamId,
    uint32_t * const logicCqId, bool * const isFastCq)
{
    const auto it = logicCqIdMap_.find(streamId);
    if (it == logicCqIdMap_.end()) {
        return RT_ERROR_STREAM_NOT_EXIST;
    }
    if (Runtime::Instance()->IsDrvBindStreamThread()) {
        if (it->second.empty()) {
            return RT_ERROR_STREAM_NOT_EXIST;
        }
    }
    const uint64_t userId = PidTidFetcher::GetCurrentUserTid();
    const auto threadInfo = it->second.find(userId);
    if (threadInfo == it->second.end()) {
        if (Runtime::Instance()->IsDrvBindStreamThread()) {
            for (const auto &cqInfoIt : it->second) {
                if (!cqInfoIt.second.isFastCq) {
                    *logicCqId = cqInfoIt.second.logicCqId;
                    *isFastCq = cqInfoIt.second.isFastCq;
                    RT_LOG(RT_LOG_DEBUG, "find normal cq, stream_id=%u, isFastCq=%u, logic cq_id=%u.",
                        streamId, *isFastCq, *logicCqId);
                    return RT_ERROR_NONE;
                }
            }
        }
        return RT_ERROR_STREAM_NOT_EXIST;
    }
    const rtLogicCqInfo_t cqInfo = threadInfo->second;
    *isFastCq = cqInfo.isFastCq;
    *logicCqId = cqInfo.logicCqId;
    return RT_ERROR_NONE;
}

rtError_t StreamSqCqManage::AllocLogicCq(const uint32_t streamId, const bool isNeedFast, uint32_t &logicCqId,
                                         bool &isFastCq, const bool isDefaultCq, const uint32_t drvFlag)
{
    const std::lock_guard<std::mutex> logicLock(logicCqLock_);
    rtError_t error = GetLogicCqIdWithoutLock(streamId, &logicCqId, &isFastCq);
    if (error == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    }

    if (device_->IsStarsPlatform()) {
        error = device_->Driver_()->LogicCqAllocateV2(device_->Id_(), device_->DevGetTsId(), streamId,
            logicCqId, false, drvFlag);
    } else {
        error = device_->Driver_()->LogicCqAllocate(device_->Id_(), device_->DevGetTsId(),
            streamId, isNeedFast, logicCqId, isFastCq, false);
    }
    ERROR_RETURN_MSG_INNER(error, "Failed to alloc logic cq, stream_id=%u, logicCqId=%u, isFastCq=%u",
        streamId, logicCqId, static_cast<uint32_t>(isFastCq));
    const uint64_t threadId = PidTidFetcher::GetCurrentUserTid();
    rtLogicCqInfo_t info;
    info.logicCqId = logicCqId;
    info.isDefaultCq = isDefaultCq;
    info.isFastCq = isFastCq;
    info.remoteFlag = drvFlag;
    RT_LOG(RT_LOG_DEBUG, "Succ, stream_id=%u, isNeedFast=%u, cq_id=%u, isFastCq=%u.",
        streamId, isNeedFast, logicCqId, isFastCq);

    if (Runtime::Instance()->IsDrvBindStreamThread()) {
        const auto it = logicCqIdMap_.find(streamId);
        if (it == logicCqIdMap_.end()) {
            std::map<uint64_t, rtLogicCqInfo_t> threadIdMap;
            threadIdMap[threadId] = info;
            logicCqIdMap_[streamId] = threadIdMap;
            return RT_ERROR_NONE;
        }

        if (isFastCq) {
            it->second[threadId] = info;
            return RT_ERROR_NONE;
        }

        for (const auto &cqInfoIt : it->second) {
            if (!cqInfoIt.second.isFastCq) {
                RT_LOG(RT_LOG_WARNING, "normal cq just alloc one, stream_id=%u, isNeedFast=%u, cq_id=%u",
                    streamId, isNeedFast, logicCqId);
                return RT_ERROR_NONE;
            }
        }
        it->second[threadId] = info;
        return RT_ERROR_NONE;
    }

    const auto it = logicCqIdMap_.find(streamId);
    if (it == logicCqIdMap_.end()) {
        std::map<uint64_t, rtLogicCqInfo_t> threadIdMap;
        threadIdMap[threadId] = info;
        logicCqIdMap_[streamId] = threadIdMap;
    } else {
        it->second[threadId] = info;
    }
    return RT_ERROR_NONE;
}

rtError_t StreamSqCqManage::FreeLogicCqByThread(const uint32_t streamId)
{
    if (Runtime::Instance()->IsDrvBindStreamThread()) {
        return RT_ERROR_NONE;
    }
    return UnbindandFreeLogicCq(streamId);
}

rtError_t StreamSqCqManage::UnbindandFreeLogicCq(const uint32_t streamId)
{
    const uint64_t threadId = PidTidFetcher::GetCurrentUserTid();
    rtError_t ret = RT_ERROR_NONE;

    const std::lock_guard<std::mutex> logicLock(logicCqLock_);
    const auto it = logicCqIdMap_.find(streamId);
    if (it == logicCqIdMap_.end()) {
        return RT_ERROR_STREAM_NOT_EXIST;
    }

    const auto it1 = it->second.find(threadId);
    if (it1 == it->second.end()) {
        return RT_ERROR_ENGINE_THREAD;
    }
    const rtLogicCqInfo_t info = it1->second;
    if (info.isDefaultCq) {
        /* default cq should not be free */
        return RT_ERROR_NONE;
    }

    if (device_->IsStarsPlatform()) {
        ret = device_->Driver_()->StreamUnBindLogicCq(device_->Id_(), device_->DevGetTsId(), streamId, info.logicCqId);
        if (ret != RT_ERROR_NONE) {
            RT_LOG_INNER_MSG(RT_LOG_ERROR,
                "Error(%#x), StreamUnBindLogicCq failed, devId(%u), tsId(%u), streamId(%u), cqId(%u)",
                static_cast<uint32_t>(ret), device_->Id_(), device_->DevGetTsId(), streamId, info.logicCqId);
            return ret;
        }
    }

    ret = device_->Driver_()->LogicCqFree(device_->Id_(), device_->DevGetTsId(), info.logicCqId);
    if (ret != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR,
            "Error(%#x), LogicCqFree failed, threadId(%" PRIu64 "),devId(%u),tsId(%u),cqId(%u), isFastCq(%u)",
            static_cast<uint32_t>(ret), threadId, device_->Id_(), device_->DevGetTsId(), info.logicCqId, info.isFastCq);
        return ret;
    }
    (void)it->second.erase(threadId);

    RT_LOG(RT_LOG_INFO, "LogicCqFree succ, stream_id=%u, threadId=%" PRIu64, streamId, threadId);
    return RT_ERROR_NONE;
}

rtError_t StreamSqCqManage::GetLogicCqId(const uint32_t streamId, uint32_t * const logicCqId, bool * const isFastCq)
{
    const std::lock_guard<std::mutex> logicLock(logicCqLock_);
    return GetLogicCqIdWithoutLock(streamId, logicCqId, isFastCq);
}

rtError_t StreamSqCqManage::FreeLogicCq(const uint32_t streamId)
{
    rtError_t ret = RT_ERROR_NONE;
    std::map<uint64_t, rtLogicCqInfo_t> tmpLogicCqMap;
    {
        const std::lock_guard<std::mutex> logicLock(logicCqLock_);
        const auto logicCqOuter = logicCqIdMap_.find(streamId);
        if (logicCqOuter != logicCqIdMap_.end()) {
            for (auto &logicCqInner : logicCqOuter->second) {
                (void)tmpLogicCqMap.insert(std::pair<uint64_t, rtLogicCqInfo_t>(logicCqInner.first,
                                                                                logicCqInner.second));
            }
            (void)logicCqIdMap_.erase(logicCqOuter);
        }
    }
    for (const auto &logicCq:tmpLogicCqMap) {
        const rtLogicCqInfo_t logicCqInfo = logicCq.second;
        RT_LOG(RT_LOG_INFO, "Return(%#x), threadIdentifier(%" PRIu64 "), devId(%u), tsId(%u), cqId(%u), isFastCq(%u).",
               ret, logicCq.first, device_->Id_(), device_->DevGetTsId(), logicCqInfo.logicCqId, logicCqInfo.isFastCq);

        if (device_->IsStarsPlatform()) {
            ret = device_->Driver_()->StreamUnBindLogicCq(device_->Id_(), device_->DevGetTsId(), streamId,
                logicCqInfo.logicCqId, logicCqInfo.remoteFlag);
            if (ret != RT_ERROR_NONE) {
                RT_LOG_INNER_MSG(RT_LOG_ERROR,
                    "Error(%#x), StreamUnBindLogicCq failed, devId(%u), tsId(%u), streamId(%u), cqId(%u)",
                    static_cast<uint32_t>(ret), device_->Id_(), device_->DevGetTsId(), streamId, logicCqInfo.logicCqId);
                break;
            }
        }

        ret = device_->Driver_()->LogicCqFree(device_->Id_(), device_->DevGetTsId(), logicCqInfo.logicCqId,
            logicCqInfo.remoteFlag);
        if (ret != RT_ERROR_NONE) {
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "Error(%#x), LogicCqFree failed, threadIdentifier(%" PRIu64 "), devId(%u), "
                "tsId(%u), cqId(%u), isFastCq(%u)", static_cast<uint32_t>(ret), logicCq.first, device_->Id_(),
                device_->DevGetTsId(), logicCqInfo.logicCqId, logicCqInfo.isFastCq);
            break;
        }
    }
    return ret;
}

void StreamSqCqManage::SetStreamIdToStream(const uint32_t streamId, Stream * const stm)
{
    const std::lock_guard<std::mutex> stmLock(streamIdToStreamMapLock_);
    RT_LOG(RT_LOG_DEBUG, "stream_id=%d.", static_cast<int32_t>(streamId));
    const auto it = streams_.find(streamId);
    if (it != streams_.end()) {
        RT_LOG(RT_LOG_WARNING, "streamId=%u exist.", streamId);
    }

    streams_[streamId] = stm;
}

void StreamSqCqManage::DelStreamIdToStream(const uint32_t streamId)
{
    const std::lock_guard<std::mutex> stmLock(streamIdToStreamMapLock_);
    RT_LOG(RT_LOG_DEBUG, "stream_id=%d.", static_cast<int32_t>(streamId));
    (void)streams_.erase(streamId);
}

rtError_t StreamSqCqManage::GetStreamById(const uint32_t streamId, Stream **stm)
{
    const std::lock_guard<std::mutex> stmLock(streamIdToStreamMapLock_);
    const auto it = streams_.find(streamId);
    if (it != streams_.end()) {
        *stm = it->second;
        return RT_ERROR_NONE;
    }
    RT_LOG(RT_LOG_WARNING, "get stream failed, stream_id=%d", static_cast<int32_t>(streamId));
    return RT_ERROR_STREAM_NULL;
}

rtError_t StreamSqCqManage::GetStreamSharedPtrById(const uint32_t streamId, std::shared_ptr<Stream> &sharedStm)
{
    const std::lock_guard<std::mutex> stmLock(streamIdToStreamMapLock_);
    const auto it = streams_.find(streamId);
    if (it != streams_.end()) {
        sharedStm = it->second->GetSharedPtr();
        return RT_ERROR_NONE;
    }
    return RT_ERROR_STREAM_NULL;
}

}  // namespace runtime
}  // namespace cce
