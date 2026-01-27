/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpusd_message_queue.h"

#include "ascend_hal.h"
#include "aicpusd_hal_interface_ref.h"
#include "type_def.h"
#include "aicpusd_status.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_feature_ctrl.h"


namespace AicpuSchedule {
namespace {
enum class MsqDataSize : uint32_t {
    MSQ_DATA_SIZE_0 = 0b000,   // No message
    MSQ_DATA_SIZE_128 = 0b100, // Message is 128bit, MSQ_DATA[0:1]_EL0 are valid for read
    MSQ_DATA_SIZE_256 = 0b101, // Message is 256bit, MSQ_DATA[0:3]_EL0 are valid for read
    MSQ_DATA_SIZE_512 = 0b110, // Message is 512bit, MSQ_DATA[0:7]_EL0 are valid for read
};

enum class CqeStatus : uint16_t {
    CQE_STATUS_OK = 0b00000,
    CQE_STATUS_DEBUG = 0b00010,
    CQE_STATUS_EXCEPTION = 0b00100,
    CQE_STATUS_WARNING = 0b10000
};

constexpr uint32_t HARD_THREAD_NUM_PER_CPU = 2U;
constexpr uint32_t CQE_SIZE = 4U;
}

thread_local MessageQueue::MsqStatusFunc MessageQueue::readMsqStatusFunc_ = nullptr;
thread_local MessageQueue::MsqDataFunc MessageQueue::readMsqDataFunc_ = nullptr;
thread_local MessageQueue::MsqRspFunc MessageQueue::sendMsqRspFunc_ = nullptr;
thread_local uint32_t *MessageQueue::cqeAddr_ = nullptr;
std::shared_ptr<MsqImpl> MessageQueue::impl_ = nullptr;

MessageQueue &MessageQueue::GetInstance()
{
    static MessageQueue instance;
    return instance;
}

int32_t MessageQueue::InitMessageQueue(const uint32_t deviceId, const std::vector<uint32_t> &aicpuPhyIds)
{
    deviceId_ = deviceId;
    aicpuPhyIds_ = aicpuPhyIds;

    int32_t ret = InitMsqImpl();
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Init message queue impl instance failed");
        return ret;
    }

    ret = InitCqeBaseAddr();
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Init cqe addr failed, ret=%d, deviceId=%u", ret, deviceId);
        return ret;
    }

    aicpusd_run_info("Init message queue success, deviceId=%u, mode=%d",
                     deviceId, static_cast<int32_t>(FeatureCtrl::IsUseMsqV2()));

    return AICPU_SCHEDULE_OK;
}

int32_t MessageQueue::InitMsqImpl() const
{
    impl_ = FeatureCtrl::IsUseMsqV2() ? std::make_shared<MsqImplV2>() : std::make_shared<MsqImplV1>();
    if (impl_ == nullptr) {
        aicpusd_err("Create msq impl failed by nullptr");
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    return AICPU_SCHEDULE_OK;
}

int32_t MessageQueue::InitCqeBaseAddr()
{
    cqeBaseAddr_ = MapResAddr(RES_ADDR_TYPE_STARS_TOPIC_CQE);
    if (cqeBaseAddr_ == nullptr) {
        aicpusd_err("Get cqe base addr failed by nullptr");
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }
    aicpusd_info("Init cqe base addr success, va=0x%x", cqeBaseAddr_);
    return AICPU_SCHEDULE_OK;
}

uint32_t *MessageQueue::MapResAddr(const res_addr_type resType) const
{
    if (&halResAddrMap == nullptr) {
        aicpusd_err("Get resource address failed by nullptr");
        return nullptr;
    }

    res_addr_info resInfo = {};
    resInfo.id = 0U;
    resInfo.target_proc_type = PROCESS_CP1;
    resInfo.res_type = resType;
    resInfo.res_id = 0U;
    uint64_t va = 0UL;
    uint32_t len = 0U;
    const int32_t ret = halResAddrMap(deviceId_, &resInfo, &va, &len);
    if (ret != DRV_ERROR_NONE) {
        aicpusd_err("Get resource address failed, ret=%d, drvType=%u, deviceId=%u", ret, resType, deviceId_);
        return nullptr;
    }

    aicpusd_info("Get resource address success, type=%u, deviceId=%u, va=0x%x, len=%u",
                 resType, deviceId_, va, len);

    return PtrToPtr<void, uint32_t>(ValueToPtr(va));
}

int32_t MessageQueue::InitMessageQueueForThread(const size_t threadIndex) const
{
    aicpusd_info("Start init message queue for thread");

    int32_t ret = ResetMessageQueueStatus(threadIndex);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Reset message queue status failed, threadIndex=%u", threadIndex);
        return ret;
    }

    ret = InitMessageQueueStatusReadFunc(threadIndex);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Init message queue status read func failed, threadIndex=%u", threadIndex);
        return ret;
    }

    ret = InitMessageQueueDataReadFunc(threadIndex);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Init message queue data read func failed, threadIndex=%u", threadIndex);
        return ret;
    }

    ret = InitMessageQueueRspFunc(threadIndex);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Init message queue rsp func failed, threadIndex=%u", threadIndex);
        return ret;
    }

    ret = InitCqeAddr(threadIndex);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Init cqe addr failed, threadIndex=%u", threadIndex);
        return ret;
    }

    aicpusd_info("Init message queue for thread success, threadIndex=%u", threadIndex);

    return AICPU_SCHEDULE_OK;
}

int32_t MessageQueue::ResetMessageQueueStatus(const size_t threadIndex) const
{
    // MSQ{0-7}_STATUS_EL0
    aicpusd_info("Start reset message queue status");
    int32_t ret = AICPU_SCHEDULE_OK;
    MsqStatus msqStatus = {};
    if (isEnableHardThread_) {
        ret = IsUseMsqT0(threadIndex) ? ResetMsqT0Status() : ResetMsqT1Status();
        msqStatus = IsUseMsqT0(threadIndex) ? ReadMsqT0Status() : ReadMsqT1Status();
    } else {
        (void)ResetMsqT0Status();
        ret = ResetMsqT1Status();
        msqStatus = ReadMsqT0Status();
    }

    aicpusd_info("End reset message queue status, ret=%d, valid=%u, comp=%u", ret, msqStatus.valid, msqStatus.comp);

    return ret;
}

int32_t MessageQueue::ResetMsqT0Status() const
{
    return impl_->ResetMsqT0Status();
}

int32_t MessageQueue::ResetMsqT1Status() const
{
    return impl_->ResetMsqT1Status();
}

int32_t MessageQueue::InitMessageQueueStatusReadFunc(const size_t threadIndex) const
{
    if (isEnableHardThread_) {
        readMsqStatusFunc_ = IsUseMsqT0(threadIndex) ? &MessageQueue::ReadMsqT0Status : &MessageQueue::ReadMsqT1Status;
    } else {
        readMsqStatusFunc_ = &MessageQueue::ReadMsqT0Status;
    }

    return AICPU_SCHEDULE_OK;
}

MsqStatus MessageQueue::ReadMsqT0Status()
{
    return impl_->ReadMsqT0Status();
}
 
MsqStatus MessageQueue::ReadMsqT1Status()
{
    return impl_->ReadMsqT1Status();
}

int32_t MessageQueue::InitMessageQueueDataReadFunc(const size_t threadIndex) const
{
    if (isEnableHardThread_) {
        readMsqDataFunc_ = IsUseMsqT0(threadIndex) ? &MessageQueue::ReadMsqT0Data : &MessageQueue::ReadMsqT1Data;
    } else {
        readMsqDataFunc_ = &MessageQueue::ReadMsqT0Data;
    }

    return AICPU_SCHEDULE_OK;
}

void MessageQueue::ReadMsqT0Data(const uint32_t msgSize, MsqDatas &datas)
{
    impl_->ReadMsqT0Data(msgSize, datas);
}
 
void MessageQueue::ReadMsqT1Data(const uint32_t msgSize, MsqDatas &datas)
{
    impl_->ReadMsqT1Data(msgSize, datas);
}

int32_t MessageQueue::InitMessageQueueRspFunc(const size_t threadIndex) const
{
    if (isEnableHardThread_) {
        sendMsqRspFunc_ = IsUseMsqT0(threadIndex) ? &MessageQueue::SendMsqT0Response : &MessageQueue::SendMsqT1Response;
    } else {
        sendMsqRspFunc_ = &MessageQueue::SendMsqT0Response;
    }

    return AICPU_SCHEDULE_OK;
}

void MessageQueue::SendMsqT0Response()
{
    impl_->SendMsqT0Response();
}

void MessageQueue::SendMsqT1Response()
{
    impl_->SendMsqT1Response();
}

int32_t MessageQueue::InitCqeAddr(const size_t threadIndex) const
{
    if (threadIndex >= aicpuPhyIds_.size()) {
        aicpusd_err("Init cqe addr failed, threadIdx larger than aicpuPhyIds size, threadIndex=%u, size=%lu",
                    threadIndex, aicpuPhyIds_.size());
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    cqeAddr_ = &(cqeBaseAddr_[aicpuPhyIds_[threadIndex] * CQE_SIZE]);
    aicpusd_info("Init cqe addr success, threadIndex=%zu, base=0x%x, va=0x%x", threadIndex, cqeBaseAddr_, cqeAddr_);
    return AICPU_SCHEDULE_OK;
}

void MessageQueue::SendResponse(const uint32_t errCode, const uint32_t status)
{
    MessageQueue::sendMsqRspFunc_();
    SetCQE(errCode, status);
}

void MessageQueue::SetCQE(const uint32_t errCode, const uint32_t status)
{
    /**
     * Topic CQE
     * 上报执行错误码
     *
     * total 32bit
     * [31:16](RW): error code
     * [15:0](RW): status
     */

    const uint32_t cqeStatus = (status == 0U) ? static_cast<uint32_t>(CqeStatus::CQE_STATUS_OK) :
                                                static_cast<uint32_t>(CqeStatus::CQE_STATUS_EXCEPTION);

    aicpusd_info("Begin to set cqe, va=0x%x, errCode=%u, status=%u, cqeStatus=%u",
                  cqeAddr_, errCode, status, cqeStatus);
    *cqeAddr_ = ((errCode << 16U) | (cqeStatus));
    aicpusd_info("End to set cqe, va=0x%x, errCode=%u, status=%u, cqeStatus=%u",
                  cqeAddr_, errCode, status, cqeStatus);
}

bool MessageQueue::WaitMsqInfoOnce(MsqDatas &datas)
{
    const MsqStatus status = readMsqStatusFunc_();
    if (status.valid == 0U) {
        WaitForEvent();
        return false;
    }

    aicpusd_info("Begin to read message queue datas, size=%u", status.size);
    readMsqDataFunc_(status.size, datas);
    aicpusd_info("End to read message queue datas, size=%u", status.size);

    return true;
}

void MessageQueue::WaitForEvent()
{
    return;
}

bool MessageQueue::IsUseMsqT0(const size_t threadIndex)
{
    return ((threadIndex % HARD_THREAD_NUM_PER_CPU) == 0U);
}

int32_t MsqImplV1::ResetMsqT0Status() const
{
    return AICPU_SCHEDULE_OK;
}

int32_t MsqImplV1::ResetMsqT1Status() const
{
    return AICPU_SCHEDULE_OK;
}

MsqStatus MsqImplV1::ReadMsqT0Status() const
{
    // MSQ0_STATUS_EL0
    MsqStatus status = {};
    return status;
}

MsqStatus MsqImplV1::ReadMsqT1Status() const
{
    // MSQ4_STATUS_EL0
    MsqStatus status = {};
    return status;
}

void MsqImplV1::ReadMsqT0Data(const uint32_t msgSize, MsqDatas &datas) const
{
    // MSQ0_DATA_EL0
    const MsqDatas tmpDatas = {};
    datas = tmpDatas;
    if (msgSize == static_cast<uint32_t>(MsqDataSize::MSQ_DATA_SIZE_0)) {
        aicpusd_err("Message size is 0");
        return;
    }
    return;
}

void MsqImplV1::ReadMsqT1Data(const uint32_t msgSize, MsqDatas &datas) const
{
    // MSQ4_DATA_EL0
    const MsqDatas tmpDatas = {};
    datas = tmpDatas;
    if (msgSize == static_cast<uint32_t>(MsqDataSize::MSQ_DATA_SIZE_0)) {
        aicpusd_err("Message size is 0");
        return;
    }
    return;
}

void __attribute__((optimize("O0"))) MsqImplV1::SendMsqT0Response() const
{
    // O2 compilation optimization will optimize away the msq write operation, so O0 optimization must be used.
    return;
}

void __attribute__((optimize("O0"))) MsqImplV1::SendMsqT1Response() const
{
    return;
}

int32_t MsqImplV2::ResetMsqT0Status() const
{
    return AICPU_SCHEDULE_OK;
}

int32_t MsqImplV2::ResetMsqT1Status() const
{
    return AICPU_SCHEDULE_OK;
}

MsqStatus MsqImplV2::ReadMsqT1Status() const
{
    MsqStatus status = {};
    return status;
}

void MsqImplV2::ReadMsqT1Data(const uint32_t msgSize, MsqDatas &datas) const
{
    const MsqDatas tmpDatas = {};
    datas = tmpDatas;
    if (msgSize == static_cast<uint32_t>(MsqDataSize::MSQ_DATA_SIZE_0)) {
        aicpusd_err("Message size is 0");
        return;
    }
    return;
}

void __attribute__((optimize("O0"))) MsqImplV2::SendMsqT1Response() const
{
    return;
}
} // namespace AicpuSchedule