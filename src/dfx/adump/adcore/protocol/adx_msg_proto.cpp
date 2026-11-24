/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "adx_msg_proto.h"
#include <cstring>
#include "securec.h"
#include "mmpa_api.h"
#include "ascend_hal.h"
#include "memory_utils.h"
#include "log/adx_log.h"
#include "adx_comm_opt_manager.h"
// DumpChunk（wire 侧数据块结构，含 fileName[MAX_FILE_PATH_LENGTH]）与 MAX_FILE_PATH_LENGTH：
// BuildDumpChunkMsg 需要按定长数组边界校验并填充，故此处补 include（其余函数不直接依赖）。
#include "adx_datadump_callback.h"
namespace Adx {
static const uint32_t MAX_PROTO_FILE_BUFFER_SIZE = 512000; // 500kb
static const int32_t MAX_DEV_FILE_SIZE = 4096;             // 4k

MsgProto* AdxMsgProto::CreateMsgPacket(CmdClassT type, uint16_t devId, IdeSendBuffT data, uint32_t length)
{
    MsgProto* msg = AdxMsgProto::CreateDataMsg(data, length);
    IDE_CTRL_VALUE_FAILED(msg != nullptr, return nullptr, "create message failed");
    msg->devId = devId;
    msg->reqType = type;
    return msg;
}

MsgProto* AdxMsgProto::CreateMsgByType(MsgType type, IdeSendBuffT data, uint32_t length)
{
    MsgProto* msg = nullptr;
    if (length > UINT32_MAX - sizeof(MsgProto)) {
        return nullptr;
    }

    if (type == MsgType::MSG_CTRL || type == MsgType::MSG_DATA) {
        uint32_t mallocLen = length + sizeof(MsgProto);
        msg = reinterpret_cast<MsgProto*>(IdeXmalloc(mallocLen));
        IDE_CTRL_VALUE_FAILED(msg != nullptr, return nullptr, "malloc memory failed");
        if (data != nullptr) { // send buffer(data) not nullptr copy data to message
            int32_t ret = memcpy_s(msg->data, length, data, length);
            if (ret != EOK) {
                IDE_LOGE("create msg mem copy failed");
                IDE_XFREE_AND_SET_NULL(msg);
                return nullptr;
            }
        }

        msg->msgType = type;
        msg->sliceLen = length;
        msg->totalLen = length;
        IDE_LOGD("adx_msg_proto CreateMsgByType length is %u bytes", length);
        msg->headInfo = ADX_PROTO_MAGIC_VALUE;
        msg->headVer = ADX_PROTO_VERSION;
        msg->order = 0;
        return msg;
    }

    return nullptr;
}

MsgProto* AdxMsgProto::CreateDataMsg(IdeSendBuffT data, uint32_t length)
{
    return CreateMsgByType(MsgType::MSG_DATA, data, length);
}

int32_t AdxMsgProto::CreateCtrlMsg(MsgProto& proto, MsgStatus status)
{
    proto.headInfo = ADX_PROTO_MAGIC_VALUE;
    proto.headVer = ADX_PROTO_VERSION;
    proto.order = 0;
    proto.sliceLen = 0;
    proto.totalLen = 0;
    proto.msgType = MsgType::MSG_CTRL;
    proto.status = status;
    return IDE_DAEMON_OK;
}

MsgCode AdxMsgProto::SendMsgData(
    const CommHandle& handle, CmdClassT type, MsgStatus status, IdeSendBuffT data, uint32_t length)
{
    MsgProto* msg = AdxMsgProto::CreateMsgPacket(type, 0, data, length);
    IDE_CTRL_VALUE_FAILED(msg != nullptr, return IDE_DAEMON_MALLOC_ERROR, "create message failed");
    std::unique_ptr<MsgProto, decltype(&IdeXfree)> sendDataMsgPtr(msg, IdeXfree);
    sendDataMsgPtr->status = status;
    msg = nullptr;
    int32_t ret = AdxCommOptManager::Instance().Write(
        handle, sendDataMsgPtr.get(), sendDataMsgPtr->sliceLen + sizeof(MsgProto), COMM_OPT_BLOCK);
    if (ret != IDE_DAEMON_OK) {
        IDE_LOGE(
            "send message failed, ret: %d, session: %zu, length: %u bytes, please check peer end is alive", ret,
            handle.session, length);
        return IDE_DAEMON_CHANNEL_ERROR;
    }

    return IDE_DAEMON_NONE_ERROR;
}

MsgCode AdxMsgProto::GetStringMsgData(const CommHandle& handle, std::string& value)
{
    MsgProto* req = nullptr;
    int32_t length = 0;
    int32_t blockType = COMM_OPT_NOBLOCK;
    if (handle.timeout == 0) {
        blockType = COMM_OPT_BLOCK;
    } else if (handle.timeout > 0) {
        blockType = handle.timeout;
    }
    int32_t ret = AdxCommOptManager::Instance().Read(handle, reinterpret_cast<IdeRecvBuffT>(&req), length, blockType);
    if ((ret == IDE_DAEMON_ERROR) || (req == nullptr) || (length <= 0)) {
        if (ret == DRV_ERROR_WAIT_TIMEOUT) {
            return IDE_DAEMON_HDC_TIMEOUT;
        }
        if (ret == IDE_DAEMON_SOCK_CLOSE) {
            return static_cast<MsgCode>(IDE_DAEMON_SOCK_CLOSE);
        }
        return IDE_DAEMON_CHANNEL_ERROR;
    }

    SharedPtr<MsgProto> msgPtr(req, IdeXfree);
    if (length <= static_cast<int32_t>(sizeof(MsgProto))) {
        IDE_LOGE("receive request length(%d bytes) exception", length);
        return IDE_DAEMON_INVALID_PARAM_ERROR;
    }
    req = nullptr;
    if (msgPtr->status == MsgStatus::MSG_STATUS_FILE_LOAD) {
        IDE_LOGE("receive request status(%d) exception", static_cast<int32_t>(MsgStatus::MSG_STATUS_FILE_LOAD));
        return IDE_DAEMON_UNKNOW_ERROR;
    }
    if (msgPtr->sliceLen + sizeof(MsgProto) != (uint32_t)length) {
        IDE_LOGE("receive request package(%u bytes) length(%d bytes) exception", msgPtr->sliceLen, length);
        return IDE_DAEMON_UNKNOW_ERROR;
    }

    value = std::string((IdeStringBuffer)msgPtr->data, msgPtr->sliceLen);
    return IDE_DAEMON_NONE_ERROR;
}

MsgCode AdxMsgProto::SendEventFile(const CommHandle& handle, CmdClassT type, uint16_t devId, int32_t fd)
{
    IDE_CTRL_VALUE_FAILED(fd >= 0, return IDE_DAEMON_INVALID_PARAM_ERROR, "create message failed");
    MsgProto* msg = AdxMsgProto::CreateMsgPacket(type, devId, nullptr, MAX_PROTO_FILE_BUFFER_SIZE);
    IDE_CTRL_VALUE_FAILED(msg != nullptr, return IDE_DAEMON_MALLOC_ERROR, "create message failed");
    std::unique_ptr<MsgProto, decltype(&IdeXfree)> sendDataMsgPtr(msg, IdeXfree);
    msg = nullptr;

    mmSsize_t pos = mmLseek(fd, 0L, SEEK_SET);
    IDE_CTRL_VALUE_FAILED(pos >= 0, return IDE_DAEMON_UNKNOW_ERROR, "lseek set failed");

    mmSsize_t readLen = MAX_PROTO_FILE_BUFFER_SIZE;
    mmSsize_t len = mmRead(fd, sendDataMsgPtr->data, readLen);
    char errBuf[MAX_ERRSTR_LEN + 1] = {0};
    int32_t err = mmGetErrorCode();
    if ((len < 0) && (err == EIO)) {
        IDE_LOGW("An EIO exception occurred when reading files from the event_sched directory");
        len = 0;
    } else {
        IDE_CTRL_VALUE_FAILED(
            len >= 0, return IDE_DAEMON_UNKNOW_ERROR, "Failed to read file in the event_sched directory: info [%s]",
            mmGetErrorFormatMessage(err, errBuf, MAX_ERRSTR_LEN));
    }

    if (len > MAX_DEV_FILE_SIZE) {
        IDE_LOGW("read file success, but the size has exceeded the maximum size of the dev file.");
    }
    sendDataMsgPtr->status = MsgStatus::MSG_STATUS_FILE_LOAD;
    sendDataMsgPtr->totalLen = len;
    sendDataMsgPtr->offset = 0;
    sendDataMsgPtr->sliceLen = (uint32_t)len;
    int32_t ret = AdxCommOptManager::Instance().Write(
        handle, sendDataMsgPtr.get(), sendDataMsgPtr->sliceLen + sizeof(MsgProto), COMM_OPT_BLOCK);
    IDE_CTRL_VALUE_FAILED(
        ret == IDE_DAEMON_OK, return IDE_DAEMON_CHANNEL_ERROR, "hand shake failed ret %d, please check server is alive",
        ret);
    RecvResponse(handle);
    return IDE_DAEMON_NONE_ERROR;
}

MsgCode AdxMsgProto::SendFile(const CommHandle& handle, CmdClassT type, uint16_t devId, int32_t fd)
{
    IDE_CTRL_VALUE_FAILED(fd >= 0, return IDE_DAEMON_INVALID_PARAM_ERROR, "create message failed");
    MsgProto* msg = AdxMsgProto::CreateMsgPacket(type, devId, nullptr, MAX_PROTO_FILE_BUFFER_SIZE);
    IDE_CTRL_VALUE_FAILED(msg != nullptr, return IDE_DAEMON_MALLOC_ERROR, "create message failed");
    std::unique_ptr<MsgProto, decltype(&IdeXfree)> sendDataMsgPtr(msg, IdeXfree);
    msg = nullptr;
    mmSsize_t fileLength = mmLseek(fd, 0L, SEEK_END);
    IDE_CTRL_VALUE_FAILED(fileLength >= 0, return IDE_DAEMON_UNKNOW_ERROR, "lseek end failed");

    mmSsize_t pos = mmLseek(fd, 0L, SEEK_SET);
    IDE_CTRL_VALUE_FAILED(pos >= 0, return IDE_DAEMON_UNKNOW_ERROR, "lseek set failed");
    mmSsize_t resLen = fileLength;
    sendDataMsgPtr->status = MsgStatus::MSG_STATUS_FILE_LOAD;
    sendDataMsgPtr->totalLen = fileLength;
    sendDataMsgPtr->offset = 0;

    if (resLen == 0) {
        sendDataMsgPtr->sliceLen = (uint32_t)fileLength;
        int32_t ret = AdxCommOptManager::Instance().Write(
            handle, sendDataMsgPtr.get(), sendDataMsgPtr->sliceLen + sizeof(MsgProto), COMM_OPT_BLOCK);
        IDE_CTRL_VALUE_FAILED(
            ret == IDE_DAEMON_OK, return IDE_DAEMON_CHANNEL_ERROR,
            "send empty file failed ret %d, please check server is alive", ret);
    }

    while (resLen > 0) {
        mmSsize_t readLen =
            static_cast<uint32_t>(resLen) > MAX_PROTO_FILE_BUFFER_SIZE ? MAX_PROTO_FILE_BUFFER_SIZE : resLen;
        mmSsize_t len = mmRead(fd, sendDataMsgPtr->data, readLen);
        char errBuf[MAX_ERRSTR_LEN + 1] = {0};
        IDE_CTRL_VALUE_FAILED(
            len >= 0, return IDE_DAEMON_UNKNOW_ERROR, "read file failed : info [%s]",
            mmGetErrorFormatMessage(mmGetErrorCode(), errBuf, MAX_ERRSTR_LEN));
        if (len > 0 && len <= readLen) {
            sendDataMsgPtr->sliceLen = (uint32_t)len;
            int32_t ret = AdxCommOptManager::Instance().Write(
                handle, sendDataMsgPtr.get(), sendDataMsgPtr->sliceLen + sizeof(MsgProto), COMM_OPT_BLOCK);
            IDE_CTRL_VALUE_FAILED(
                ret == IDE_DAEMON_OK, return IDE_DAEMON_CHANNEL_ERROR,
                "hand shake failed ret %d, please check server is alive", ret);
        }
        sendDataMsgPtr->offset += (uint32_t)len;
        resLen -= len;
    }
    RecvResponse(handle);
    return IDE_DAEMON_NONE_ERROR;
}

MsgCode AdxMsgProto::RecvFile(const CommHandle& handle, int32_t fd)
{
    IDE_CTRL_VALUE_FAILED(fd >= 0, return IDE_DAEMON_INVALID_PARAM_ERROR, "create message failed");
    MsgProto* msg = nullptr;
    int32_t length = 0;
    while (true) {
        int32_t ret = AdxCommOptManager::Instance().Read(handle, (IdeRecvBuffT)&msg, length, handle.timeout);
        IDE_CTRL_VALUE_FAILED(
            ret == IDE_DAEMON_OK && msg != nullptr, return IDE_DAEMON_CHANNEL_ERROR,
            "hand shake failed ret %d, read failed or timeout", ret);
        if (msg->msgType == MsgType::MSG_CTRL) { // check the message is ctrl or not
            IDE_LOGW("receive ctrl msg from device, stop receiving this file");
            IDE_XFREE_AND_SET_NULL(msg);
            return IDE_DAEMON_NONE_ERROR;
        }
        if (msg->sliceLen != 0 && msg->sliceLen <= MAX_PROTO_FILE_BUFFER_SIZE) {
            mmSsize_t len = mmWrite(fd, msg->data, msg->sliceLen);
            if (len < 0) {
                char errBuf[MAX_ERRSTR_LEN + 1] = {0};
                IDE_LOGE(
                    "write file failed : info [%s]", mmGetErrorFormatMessage(mmGetErrorCode(), errBuf, MAX_ERRSTR_LEN));
                IDE_XFREE_AND_SET_NULL(msg);
                return IDE_DAEMON_UNKNOW_ERROR;
            }
        }

        if (msg->totalLen == msg->sliceLen + msg->offset) {
            break;
        }

        IDE_XFREE_AND_SET_NULL(msg);
    }

    if (SendResponse(handle, msg->reqType, msg->devId, MsgStatus::MSG_STATUS_NONE_ERROR) != IDE_DAEMON_NONE_ERROR) {
        IDE_LOGW("send response exception");
        IDE_XFREE_AND_SET_NULL(msg);
        return IDE_DAEMON_CHANNEL_ERROR;
    }

    IDE_XFREE_AND_SET_NULL(msg);
    return IDE_DAEMON_NONE_ERROR;
}

MsgCode AdxMsgProto::SendResponse(const CommHandle& handle, uint16_t type, uint16_t devId, MsgStatus status)
{
    MsgProto msg;
    (void)memset_s(&msg, sizeof(msg), 0, sizeof(msg));
    (void)CreateCtrlMsg(msg, status);
    msg.reqType = type;
    msg.devId = devId;
    int32_t ret = AdxCommOptManager::Instance().Write(handle, (IdeSendBuffT)&msg, sizeof(MsgProto), COMM_OPT_BLOCK);
    if (ret != IDE_DAEMON_OK) {
        IDE_LOGE("send response failed ret %d, please check peer is alive", ret);
        return IDE_DAEMON_CHANNEL_ERROR;
    }

    IDE_LOGI("device(%d) cmd(%d) response success", devId, type);
    return IDE_DAEMON_NONE_ERROR;
}

MsgCode AdxMsgProto::RecvResponse(const CommHandle& handle)
{
    MsgProto* recvBuf = nullptr;
    int32_t length = 0;
    int32_t ret = AdxCommOptManager::Instance().Read(handle, (IdeRecvBuffT)&recvBuf, length, COMM_OPT_BLOCK);
    if (ret != IDE_DAEMON_OK || recvBuf == nullptr) {
        return IDE_DAEMON_CHANNEL_ERROR;
    }

    if (recvBuf->msgType == MsgType::MSG_CTRL && recvBuf->status == MsgStatus::MSG_STATUS_NONE_ERROR) {
        IDE_XFREE_AND_SET_NULL(recvBuf);
        return IDE_DAEMON_NONE_ERROR;
    }

    if (recvBuf->msgType == MsgType::MSG_CTRL && recvBuf->status == MsgStatus::MSG_STATUS_CACHE_FULL_ERROR) {
        IDE_XFREE_AND_SET_NULL(recvBuf);
        return IDE_DAEMON_DUMP_QUEUE_FULL;
    }

    IDE_XFREE_AND_SET_NULL(recvBuf);
    return IDE_DAEMON_UNKNOW_ERROR;
}

// CHECKSUPPORT 应答接收：data 形态应答（status=MSG_STATUS_DUMP_SUPPORT + 8B 位图）。
// 命中读位图返回 NONE；非 SUPPORT 形态或限时内无应答返回错误码——调用方一律按"不支持"回退。
MsgCode AdxMsgProto::RecvSupportResponse(const CommHandle& handle, uint64_t& outBitmap)
{
    outBitmap = 0U;
    MsgProto* recvBuf = nullptr;
    int32_t length = 0;
    // 限时收包用 TryRead（HdcReadNb）退避轮询而非 Read(flag=毫秒) 的 HdcReadTimeout：
    // 后者 A5 真机实测在返回后解引用收包指针即异常（根因未定位），不引入探测链路。
    // 超时语义：handle.timeout 毫秒 → 按 1+2+…+N ms 退避累计到该时长；0 = 无限等（沿用阻塞读）。
    if (handle.timeout > 0) {
        // 步数 = 1+2+…+N ≤ timeout 的最大 N（乘法走 int64 防 N^2 溢出）
        int32_t retryStepMax = 1;
        while (static_cast<int64_t>(retryStepMax + 1) * (retryStepMax + 2) / 2 <= handle.timeout) {
            ++retryStepMax;
        }
        int32_t ret = IDE_DAEMON_RECV_NODATA;
        for (int32_t retryTime = 1; retryTime <= retryStepMax; ++retryTime) {
            ret = AdxCommOptManager::Instance().TryRead(handle, reinterpret_cast<IdeRecvBuffT>(&recvBuf), length);
            if (ret != IDE_DAEMON_RECV_NODATA) {
                break;
            }
            mmSleep(retryTime);
        }
        if (ret == IDE_DAEMON_RECV_NODATA) {
            IDE_LOGE("checksupport response wait timeout after %d retries.", retryStepMax);
            return IDE_DAEMON_HDC_TIMEOUT; // 限时内无应答：判不支持并由调用方即时回退
        }
        if (ret != IDE_DAEMON_OK) {
            IDE_LOGE("checksupport response TryRead failed, ret: %d.", ret);
            return IDE_DAEMON_CHANNEL_ERROR;
        }
    } else {
        const int32_t ret = AdxCommOptManager::Instance().Read(
            handle, reinterpret_cast<IdeRecvBuffT>(&recvBuf), length, COMM_OPT_BLOCK);
        if (ret != IDE_DAEMON_OK) {
            IDE_LOGE("checksupport response blocking read failed, ret: %d.", ret);
            return IDE_DAEMON_CHANNEL_ERROR;
        }
    }
    if (recvBuf == nullptr) {
        IDE_LOGE("checksupport response buffer is null after read.");
        return IDE_DAEMON_CHANNEL_ERROR;
    }

    // 截断防御：读包头字段前确认实际收包长度覆盖包头，位图拷贝前确认 sliceLen 与实际长度一致
    IDE_CTRL_VALUE_FAILED(
        length >= static_cast<int32_t>(sizeof(MsgProto)),
        {
            IDE_XFREE_AND_SET_NULL(recvBuf);
            return IDE_DAEMON_UNKNOW_ERROR;
        },
        "checksupport response truncated: length(%d) < msg header(%u).", length,
        static_cast<uint32_t>(sizeof(MsgProto)));

    // data 形态应答判据：SUPPORT 状态 + data 段装得下 8B 位图 + 长度自洽（sliceLen 与实际收包一致）
    const bool isSupport = (recvBuf->msgType == MsgType::MSG_DATA) &&
                           (recvBuf->status == MsgStatus::MSG_STATUS_DUMP_SUPPORT) &&
                           (recvBuf->sliceLen >= sizeof(uint64_t)) &&
                           (recvBuf->sliceLen + sizeof(MsgProto) == static_cast<uint32_t>(length));
    if (!isSupport) {
        IDE_LOGW(
            "checksupport response is not SUPPORT form (msgType: %d, status: %d, sliceLen: %u, length: %d), "
            "treated as not-supported.",
            static_cast<int32_t>(recvBuf->msgType), static_cast<int32_t>(recvBuf->status), recvBuf->sliceLen, length);
        IDE_XFREE_AND_SET_NULL(recvBuf);
        return IDE_DAEMON_UNKNOW_ERROR;
    }

    const int32_t cpy = memcpy_s(&outBitmap, sizeof(outBitmap), recvBuf->data, sizeof(outBitmap));
    IDE_XFREE_AND_SET_NULL(recvBuf);
    IDE_CTRL_VALUE_FAILED(cpy == EOK, return IDE_DAEMON_UNKNOW_ERROR, "copy support bitmap failed, err=%d", cpy);
    return IDE_DAEMON_NONE_ERROR;
}

// dump 数据块消息组装（单一实现，SOC 直调与 HDC 发送两条路径共用，字节布局单一事实来源）。
MsgCode AdxMsgProto::BuildDumpChunkMsg(const IdeDumpChunk& chunk, SharedPtr<MsgProto>& outMsg)
{
    // 数据段 = DumpChunk 头 + 柔性 dataBuf；bufLen 逼近 UINT32_MAX 时加法回绕，宏提前拒绝
    uint32_t dataLen = 0;
    IDE_RETURN_IF_CHECK_ASSIGN_32U_ADD(
        sizeof(DumpChunk), chunk.bufLen, dataLen, return IDE_DAEMON_INTERGER_REVERSED_ERROR);

    MsgProto* msg = CreateMsgPacket(IDE_DUMP_REQ, 0, nullptr, dataLen);
    IDE_CTRL_VALUE_FAILED(msg != nullptr, return IDE_DAEMON_MALLOC_ERROR, "create message failed");
    outMsg.reset(msg, IdeXfree);

    DumpChunk* data = reinterpret_cast<DumpChunk*>(outMsg->data);
    // fileName 为 nullptr 时 strnlen 会解引用空指针，统一在此拒绝（空串是新 flag 的合法形态）
    IDE_CTRL_VALUE_FAILED(chunk.fileName != nullptr, return IDE_DAEMON_INVALID_PATH_ERROR, "fileName is nullptr");
    // strnlen 而非 strlen：fileName 无 NUL 终止保证，strlen 会越界读；到界即停交给下方判定
    IDE_CTRL_VALUE_FAILED(
        strnlen(chunk.fileName, MAX_FILE_PATH_LENGTH) < MAX_FILE_PATH_LENGTH, return IDE_DAEMON_INVALID_PATH_ERROR,
        "fileName length=%u or not null-terminated, max=%u",
        static_cast<uint32_t>(strnlen(chunk.fileName, MAX_FILE_PATH_LENGTH)), MAX_FILE_PATH_LENGTH);
    const int32_t cpyName = strcpy_s(data->fileName, MAX_FILE_PATH_LENGTH, chunk.fileName);
    IDE_CTRL_VALUE_FAILED(
        cpyName == EOK, return IDE_DAEMON_INVALID_PATH_ERROR, "copy file name failed, err=%d", cpyName);

    data->bufLen = chunk.bufLen;
    data->flag = static_cast<int32_t>(chunk.flag);
    data->isLastChunk = chunk.isLastChunk;
    data->offset = chunk.offset;
    IDE_LOGI(
        "assemble dump chunk, dataLen: %u, bufLen: %u, flag: %d, isLastChunk: %u, offset: %ld, fileName: %s", dataLen,
        data->bufLen, data->flag, data->isLastChunk, data->offset, data->fileName);

    const int32_t cpyData = memcpy_s(data->dataBuf, data->bufLen, chunk.dataBuf, chunk.bufLen);
    IDE_CTRL_VALUE_FAILED(cpyData == EOK, return IDE_DAEMON_MEMCPY_ERROR, "copy data buffer failed, err=%d", cpyData);
    return IDE_DAEMON_NONE_ERROR;
}
} // namespace Adx
