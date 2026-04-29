/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "adx_dump_receive.h"
#include "mmpa_api.h"
#include "memory_utils.h"
#include "adx_dump_record.h"
#include "log/adx_log.h"
namespace Adx {
int32_t AdxDumpReceive::Init()
{
    init_ = true;
    return IDE_DAEMON_OK;
}

int32_t AdxDumpReceive::Process(const CommHandle &handle, const SharedPtr<MsgProto> &proto)
{
    // hand shake control(sent by IdeDumpStart)
    if (proto->msgType == MsgType::MSG_CTRL && proto->status == MsgStatus::MSG_STATUS_HAND_SHAKE) {
        IdeErrorT err = AdxMsgProto::SendResponse(handle,
            (CmdClassT)proto->reqType, proto->devId, MsgStatus::MSG_STATUS_NONE_ERROR);
        if (err != IDE_DAEMON_NONE_ERROR) {
            IDE_LOGE("send dump handshake response failed! device(id:%u,session:%zu), err: %d",
                proto->devId, handle.session, err);
            return err;
        }
    } else {
        IDE_LOGW("receive invalid ctrl msg! device(id:%u,session:%zu), type: %d, status: %d",
            proto->devId, handle.session, proto->msgType, proto->status);
        return IDE_DAEMON_OK;
    }
    // store client session(persistent session. must be closed before close server)
    AdxCommHandle adxHandle = const_cast<AdxCommHandle>(&handle);
    StoreSession(proto->devId, adxHandle);
    // read dump data(sent by IdeDumpData) and end dump control(sent by IdeDumpEnd)
    int32_t ret = Receive(handle, proto);
    ReleaseSession(proto->devId, adxHandle);
    return ret;
}

int32_t AdxDumpReceive::Receive(const CommHandle &handle, const SharedPtr<MsgProto> &proto)
{
    int32_t length = 0;
    uint32_t protoHeaderLen = static_cast<uint32_t>(sizeof(MsgProto));
    uint32_t chunkHeaderLen = static_cast<uint32_t>(sizeof(DumpChunk));
    MsgProto *msg = nullptr;
    while (init_) {
        IDE_LOGI("receiving new dump data from device(id:%u,session:%zu)", proto->devId, handle.session);
        int ret = AdxCommOptManager::Instance().Read(handle, (IdeRecvBuffT)&msg, length, COMM_OPT_BLOCK);
        IDE_CTRL_VALUE_WARN(ret == IDE_DAEMON_OK, return ret,
            "read dump data error. device(id:%u,session:%zu), err:%d", proto->devId, handle.session, ret);
        IDE_CTRL_VALUE_WARN(msg != nullptr && length >= 0, { IdeXfree(msg); return IDE_DAEMON_ERROR; },
            "dump data is invalid. device(id:%u,session:%zu)", proto->devId, handle.session);

        uint32_t protoEntryLen = static_cast<uint32_t>(length);
        IDE_CTRL_VALUE_WARN(protoEntryLen >= protoHeaderLen, { IdeXfree(msg); return IDE_DAEMON_ERROR; },
            "recvLen(%u) too small for MsgProto header(%u bytes)", protoEntryLen, protoHeaderLen);

        SharedPtr<MsgProto> msgPtr(msg, IdeXfree);
        msg = nullptr;
        if (msgPtr->msgType == MsgType::MSG_CTRL) {
            if (msgPtr->status == MsgStatus::MSG_STATUS_DATA_END) {
                IDE_LOGI("received dump ctrl msg from device(id:%u,session:%zu), end transfer dump data",
                    proto->devId, handle.session);
                return IDE_DAEMON_OK;
            } else {
                continue;
            }
        }
        uint32_t protoDataLen = protoEntryLen - protoHeaderLen;
        IDE_CTRL_VALUE_WARN(msgPtr->sliceLen == protoDataLen, return IDE_DAEMON_ERROR,
            "msg sliceLen(%u) not equal actual msg data buffer size(%u)", msgPtr->sliceLen, protoDataLen);

        IDE_CTRL_VALUE_WARN(protoDataLen >= chunkHeaderLen, return IDE_DAEMON_ERROR,
            "msg dataLen(%u) too small for DumpChunk header(%u)", protoDataLen, chunkHeaderLen);

        DumpChunk* dumpChunk = reinterpret_cast<DumpChunk*>(msgPtr->data);
        uint32_t chunkDataLen = protoDataLen - chunkHeaderLen;
        IDE_CTRL_VALUE_WARN(dumpChunk->bufLen <= chunkDataLen, return IDE_DAEMON_ERROR,
            "chunk bufLen(%u) exceeds actual chunk data buffer size(%u)", dumpChunk->bufLen, chunkDataLen);

        IDE_LOGI("fileName: %s, bufLen: %u, isLastChunk: %u, offset: %ld, flag: %d",
            dumpChunk->fileName, dumpChunk->bufLen, dumpChunk->isLastChunk, dumpChunk->offset, dumpChunk->flag);

        HostDumpDataInfo data = {msgPtr, protoDataLen};
        MsgStatus status = MsgStatus::MSG_STATUS_NONE_ERROR;
        if (!AdxDumpRecord::Instance().RecordDumpDataToQueue(data)) {
            status = MsgStatus::MSG_STATUS_CACHE_FULL_ERROR;
        }

        // send respone msg to device
        IdeErrorT err = AdxMsgProto::SendResponse(handle, proto->reqType, proto->devId, status);
        IDE_CTRL_VALUE_FAILED(err == IDE_DAEMON_NONE_ERROR, return IDE_DAEMON_ERROR, 
            "send dump handshake response failed! device(id:%u,session:%zu), err: %d",
            proto->devId, handle.session, err);
    }
    return IDE_DAEMON_OK;
}

int32_t AdxDumpReceive::UnInit()
{
    init_ = false;
    return IDE_DAEMON_OK;
}

void AdxDumpReceive::StoreSession(uint32_t deviceId, AdxCommHandle handle)
{
    if (handle != nullptr) {
        std::lock_guard<std::mutex> lock {mutex_};
        handles_[deviceId].push_back(handle);
    }
}

void AdxDumpReceive::ReleaseSession(uint32_t deviceId, AdxCommHandle handle)
{
    if (handle != nullptr) {
        std::lock_guard<std::mutex> lock {mutex_};
        auto map_it = handles_.find(deviceId);
        if (map_it != handles_.end()) {
            auto& vec = map_it->second;
            auto vec_it = std::find(vec.begin(), vec.end(), handle);
            if (vec_it != vec.end()) {
                vec.erase(vec_it);
            }
        }
    }
}

int32_t AdxDumpReceive::Terminate()
{
    std::lock_guard<std::mutex> lock {mutex_};
    for (auto& map_it: handles_) {
        for (auto& handle : map_it.second) {
            IDE_LOGW("close alive client session. device: %u, session: %zu", map_it.first, handle->session);
            (void)AdxCommOptManager::Instance().Close(*handle);
        }
    }
    handles_.clear();
    return IDE_DAEMON_OK;
}
}
