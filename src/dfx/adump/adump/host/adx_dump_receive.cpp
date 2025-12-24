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
    return IDE_DAEMON_OK;
}

int32_t AdxDumpReceive::Process(const CommHandle &handle, const SharedPtr<MsgProto> &proto)
{
    if (proto->msgType == MsgType::MSG_CTRL && proto->status == MsgStatus::MSG_STATUS_HAND_SHAKE) {
        IdeErrorT err = AdxMsgProto::SendResponse(handle,
            (CmdClassT)proto->reqType, proto->devId, MsgStatus::MSG_STATUS_NONE_ERROR);
        if (err != IDE_DAEMON_NONE_ERROR) {
            IDE_LOGE("send dump data response failed, err: %d", err);
            return err;
        }
    } else {
        IDE_LOGW("receive invalid msg");
        return IDE_DAEMON_OK;
    }
    int32_t length = 0;
    MsgProto *msg = nullptr;
    while (true) {
        IDE_LOGI("receive new dump data");
        int ret = AdxCommOptManager::Instance().Read(handle, (IdeRecvBuffT)&msg, length, COMM_OPT_BLOCK);
        IDE_CTRL_VALUE_FAILED(ret == IDE_DAEMON_OK, return IDE_DAEMON_ERROR, "read dump data error");
        SharedPtr<MsgProto> msgPtr(msg, IdeXfree);
        msg = nullptr;
        if (msgPtr->msgType == MsgType::MSG_CTRL) {
            if (msgPtr->status == MsgStatus::MSG_STATUS_DATA_END) {
                IDE_LOGI("received ctrl msg: end, transfer dump data end");
                return IDE_DAEMON_OK;
            } else {
                continue;
            }
        }
        DumpChunk* dumpChunk = reinterpret_cast<DumpChunk*>(msgPtr->data);
        IDE_LOGI("fileName: %s, bufLen: %u, isLastChunk: %u, offset: %ld, flag: %d",
            dumpChunk->fileName, dumpChunk->bufLen, dumpChunk->isLastChunk, dumpChunk->offset, dumpChunk->flag);
        IDE_CTRL_VALUE_FAILED(length > 0, return IDE_DAEMON_ERROR, "receive data length(%d bytes) error", length);
        uint32_t mdgLen = length;
        HostDumpDataInfo data = {msgPtr, mdgLen};
        MsgStatus status = MsgStatus::MSG_STATUS_NONE_ERROR;
        if (!AdxDumpRecord::Instance().RecordDumpDataToQueue(data)) {
            status = MsgStatus::MSG_STATUS_CACHE_FULL_ERROR;
        }

        // send respone msg to device
        IdeErrorT err = AdxMsgProto::SendResponse(handle, proto->reqType, proto->devId, status);
        if (err != IDE_DAEMON_NONE_ERROR) {
            IDE_LOGE("send dump data response failed, err: %d", err);
            return IDE_DAEMON_ERROR;
        }
    }
}

int32_t AdxDumpReceive::UnInit()
{
    return IDE_DAEMON_OK;
}
}
