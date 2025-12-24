/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "device_msg_handler.hpp"
#include "runtime.hpp"
#include "error_message_manage.hpp"
#include "ttlv.hpp"
#include "task.hpp"
#include "stub_task.hpp"

namespace cce {
namespace runtime {
namespace {
// alloc a huge page size
constexpr uint32_t GET_DEVICE_MSG_BUF_SIZE = 2U * 1024U * 1024U;
constexpr uint32_t RT_MAX_LOG_LEN = 900U;
}

DeviceMsgHandler::DeviceMsgHandler(Device * const devInfo, const rtGetMsgCallback msgCallback) : dev_(devInfo),
    callback_(msgCallback), devMemSize_(GET_DEVICE_MSG_BUF_SIZE)
{
}

DeviceMsgHandler::~DeviceMsgHandler() noexcept
{
    FreeDevMem();
}


rtError_t DeviceMsgHandler::Init()
{
    const rtError_t ret = AllocDevMem();
    ERROR_RETURN(ret, "Failed to alloc device memory, deviceId=%u.", dev_->Id_());
    return RT_ERROR_NONE;
}

void DeviceMsgHandler::MsgNotify(const char_t * const msg, const uint32_t len) const
{
    callback_(msg, len);
}

rtError_t DeviceMsgHandler::AllocDevMem()
{
    if (devMemAddr_ != nullptr) {
        RT_LOG(RT_LOG_INFO, "no need repeat alloc dev mem device_id=%u.", dev_->Id_());
        return RT_ERROR_NONE;
    }
    Driver * const devDrv = dev_->Driver_();
    Runtime * const rtInstance = Runtime::Instance();
    const rtMemType_t memType = rtInstance->GetTsMemType(MEM_REQUEST_FEATURE_DEFAULT, devMemSize_);

    // create task to transfer the addr to device for error message.
    void *devMem = nullptr;
    const rtError_t error = devDrv->DevMemAlloc(&devMem, static_cast<uint64_t>(devMemSize_), memType, dev_->Id_());
    ERROR_RETURN(error, "Failed to alloc device memory for get device message, size=%u (bytes), "
                 "memType=%u, deviceId=%u.",
                 devMemSize_, memType, dev_->Id_());

    COND_RETURN_ERROR(devMem == nullptr, RT_ERROR_DRV_MEMORY, "DevMemAlloc failed, size=%u (bytes), "
                      "memType=%u, deviceId=%u",
                      devMemSize_, memType, dev_->Id_());
    devMemAddr_ = devMem;
    return RT_ERROR_NONE;
}

void DeviceMsgHandler::FreeDevMem()
{
    // if nullptr, it don`t need to release, directly to return.
    if (devMemAddr_ == nullptr) {
        return;
    }

    Driver * const devDrv = const_cast<Driver *>(dev_->Driver_());
    const rtError_t error = devDrv->DevMemFree(devMemAddr_, dev_->Id_());
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Failed to release device error message memory, device_id=%u.", dev_->Id_());
    }
    devMemAddr_ = nullptr;
}

rtError_t DeviceMsgHandler::CheckGetDevMsgCtrlValid(const rtGetDevMsgCtrlInfo_t * const ctrlInfo) const
{
    if (ctrlInfo->magic != DEVICE_GET_MSG_MAGIC) {
        RT_LOG(RT_LOG_ERROR, "The magic=%#x of device message is invalid, valid value=%#x.",
               ctrlInfo->magic, DEVICE_GET_MSG_MAGIC);
        return RT_ERROR_INVALID_VALUE;
    }
    uint32_t pid = 0U;
    const auto error = dev_->Driver_()->DeviceGetBareTgid(&pid);
    ERROR_RETURN_MSG_INNER(error, "Device get bare tgid failed, device id=%u.", dev_->Id_());
    COND_RETURN_ERROR_MSG_INNER(ctrlInfo->pid != pid, RT_ERROR_INVALID_VALUE,
                                "The pid of error message is not matched, device pid=%u, host pid=%u.", ctrlInfo->pid,
                                pid);

    COND_RETURN_ERROR_MSG_INNER(
        ((ctrlInfo->bufferLen < sizeof(rtGetDevMsgCtrlInfo_t)) || (ctrlInfo->bufferLen > devMemSize_)),
        RT_ERROR_INVALID_VALUE, "bufferLen=%u is invalid, range[%zu, %u], pid=%u.",
        ctrlInfo->bufferLen, sizeof(rtGetDevMsgCtrlInfo_t), devMemSize_, pid);
    return RT_ERROR_NONE;
}

rtError_t DeviceMsgHandler::HandleMsg()
{
    if (devMemAddr_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "dev mem is null, can't handle msg.");
        return RT_ERROR_INVALID_VALUE;
    }

    RT_LOG(RT_LOG_INFO, "Begin to process device errMessage.");
    const std::unique_ptr<char_t[]> hostBuf(new(std::nothrow) char_t[devMemSize_]);
    NULL_PTR_RETURN_MSG(hostBuf, RT_ERROR_MEMORY_ALLOCATION);
    auto * const devDrv = dev_->Driver_();
    // 1. memcpy error message buffer to host
    const uint64_t destMax = devMemSize_;
    rtError_t error = devDrv->MemCopySync(hostBuf.get(), destMax, devMemAddr_, destMax, RT_MEMCPY_DEVICE_TO_HOST);
    ERROR_RETURN_MSG_INNER(error, "Failed to Memcpy from device to host, devMemSize_=%u (bytes).", devMemSize_);

    auto * const ctrlInfo = RtPtrToPtr<rtGetDevMsgCtrlInfo_t *, char_t *>(hostBuf.get());
    error = CheckGetDevMsgCtrlValid(ctrlInfo);
    ERROR_RETURN_MSG_INNER(error, "GetDevMsgCtrlInfo check failed.");

    // 2. memset device ms ctrl info
    error = devDrv->MemSetSync(devMemAddr_, destMax, 0U, sizeof(rtGetDevMsgCtrlInfo_t));
    ERROR_RETURN_MSG_INNER(error, "MemSetSync failed, buffer len=%zu (bytes).", sizeof(rtGetDevMsgCtrlInfo_t));

    RT_LOG(RT_LOG_INFO, "Finished to process device errInfo, retCode=%#x.", error);
    const char_t * const msgBuff = hostBuf.get() + sizeof(rtGetDevMsgCtrlInfo_t);
    const uint32_t msgBuffSize = ctrlInfo->bufferLen - static_cast<uint32_t>(sizeof(rtGetDevMsgCtrlInfo_t));
    return HandleMsgInHostBuf(msgBuff, msgBuffSize);
}

rtError_t DeviceErrMsgHandler::HandleMsgInHostBuf(const char_t * const msgBuff, const uint32_t msgBuffSize)
{
    TTLV ttlvData(msgBuff, msgBuffSize);
    const rtError_t decodeRet = ttlvData.Decode();
    // Translate ts error message to std string
    ERROR_RETURN_MSG_INNER(decodeRet, "Do complete failed, decode error message failed, devId=%u.", dev_->Id_());
    // Splicing string should be an atomic operation
    const std::string reportMsg = ("\nDEVICE[" + std::to_string(dev_->Id_()) + "] PID[" + std::to_string(mmGetPid()) +
        "]:" + ttlvData.GetDecodeStr());
    if (!ttlvData.DecodeMsgFlag()) {
        MsgNotify("", 0U);
        return RT_ERROR_NONE;
    }
    size_t offset = 0U;
    const size_t msgSize = reportMsg.size();
    while (offset < msgSize) {
        char_t logBuffer[RT_MAX_LOG_LEN + 1U] = {};
        char_t * const bAddr = logBuffer;
        size_t copySize = RT_MAX_LOG_LEN;
        if ((offset + copySize) > msgSize) {
            copySize = msgSize - offset;
        }
        const errno_t err = strncpy_s(bAddr, sizeof(logBuffer), reportMsg.c_str() + offset, copySize);
        COND_RETURN_ERROR_MSG_INNER(err != EOK, RT_ERROR_SEC_HANDLE, "strncpy_s failed, max size=%u (bytes)",
                                    RT_MAX_LOG_LEN);
        offset += copySize;
        RT_LOG(RT_LOG_ERROR, "%s", bAddr);
    }

    // TTLV
    MsgNotify(reportMsg.c_str(), static_cast<uint32_t>(reportMsg.length()));
    return RT_ERROR_NONE;
}

rtError_t DeviceStreamSnapshotHandler::HandleMsgInHostBuf(const char_t * const msgBuff, const uint32_t msgBuffSize)
{
    if ((msgBuffSize % sizeof(rtStreamSnapshot_t)) != 0U) {
        RT_LOG(RT_LOG_ERROR, "msgBuffSize=%u (bytes) is not an integer multiple of "
               "sizeof(rtStreamSnapshot_t)=%zu (bytes).", msgBuffSize, sizeof(rtStreamSnapshot_t));
        return RT_ERROR_INVALID_VALUE;
    }

    const auto streamSnapshots = RtPtrToPtr<const rtStreamSnapshot_t *, const char_t *>(msgBuff);
    const uint32_t streamSnapshotCount = msgBuffSize / static_cast<uint32_t>(sizeof(rtStreamSnapshot_t));
    const std::string snapshotMsg = GetActiveStreamSnapshot(streamSnapshots, streamSnapshotCount);
    MsgNotify(snapshotMsg.c_str(), static_cast<uint32_t>(snapshotMsg.length()));
    return RT_ERROR_NONE;
}

std::string DeviceStreamSnapshotHandler::GetActiveStreamSnapshot(const rtStreamSnapshot_t * const streamSnapshots,
                                                                 const uint32_t cnt) const
{
    std::ostringstream outStream;
    uint32_t realDeviceId = dev_->Id_();
    (void)Runtime::Instance()->GetUserDevIdByDeviceId(dev_->Id_(), &realDeviceId);
    outStream << "Device[" << realDeviceId << "] total running stream num=" << cnt << std::endl;
    for (uint32_t i = 0U; i < cnt; ++i) {
        auto &streamSnapshot = streamSnapshots[i];
        TaskInfo *tsk = GetTaskInfo(
            dev_, static_cast<uint32_t>(streamSnapshot.streamId), static_cast<uint32_t>(streamSnapshot.taskId));
        outStream << "\t"
                  << "[" << i << "] streamId=" << streamSnapshot.streamId << ", " << TaskIdCamelbackNaming() << "="
                  << streamSnapshot.taskId;
        if (tsk == nullptr) {
            outStream << ", no task info found in runtime." << std::endl;
            continue;
        }
        outStream << ", taskType=" << tsk->type;
        if (Runtime::Instance()->ChipIsHaveStars()) {
            outStream << ", sq_id=" << streamSnapshot.sqId << ", sq_fsm=" << streamSnapshot.sqFsm
                << ", acsq_id=" << streamSnapshot.acsqId << ", acsq_fsm=" << streamSnapshot.acsqFsm
                << ", is_swap_in=" << streamSnapshot.isSwapIn;
        }

        std::string taskTag = tsk->stream->GetTaskTag(tsk->id);
        if (taskTag.empty()) {
            outStream << ", no task tag is set." << std::endl;
            continue;
        }
        outStream << ", taskTag=" << taskTag << "." << std::endl;
    }
    return outStream.str();
}

}
}
