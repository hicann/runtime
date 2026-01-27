/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ascend_hal.h"
#include "protocol/adx_msg_proto.h"
#include "adx_datadump_callback.h"
#include "log/adx_log.h"
#include "memory_utils.h"
#include "hdc_api.h"
#include "adcore_api.h"
#include "string_utils.h"
#include "create_func.h"
#include "sys_utils.h"
#include "config.h"
#include "adx_dump_hdc_helper.h"

namespace Adx {
AdxDumpHdcHelper::AdxDumpHdcHelper() : init_(false)
{
    client_.type = NR_COMM;
    client_.session = 0U;
    client_.comp = NR_COMPONENTS;
    client_.timeout = 0;
    client_.client = nullptr;
}

AdxDumpHdcHelper::~AdxDumpHdcHelper()
{
    UnInit();
}

bool AdxDumpHdcHelper::Init()
{
    if (!init_) {
        std::unique_ptr<AdxCommOpt> opt (CreateAdxCommOpt(OptType::COMM_HDC));
        IDE_CTRL_VALUE_FAILED(opt != nullptr, return false, "create hdc commopt exception");
        bool ret = AdxCommOptManager::Instance().CommOptsRegister(opt);
        IDE_CTRL_VALUE_FAILED(ret, return false, "register hdc failed");
        std::map<std::string, std::string> info;
        info[OPT_SERVICE_KEY] = std::to_string(HDC_SERVICE_TYPE_DUMP);
        client_ = AdxCommOptManager::Instance().OpenClient(OptType::COMM_HDC, info);
        IDE_CTRL_VALUE_FAILED(client_.session != ADX_OPT_INVALID_HANDLE, return false,
            "open client failed");
        IDE_LOGI("dump data client init end<%lu, %d>", client_.session, static_cast<int32_t>(client_.type));
        init_ = true;
    }
    return true;
}

void AdxDumpHdcHelper::UnInit()
{
    if (init_) {
        IDE_LOGI("dump data client close <%lu, %d>", client_.session, static_cast<int32_t>(client_.type));
        HdcClientDestroy(reinterpret_cast<HDC_CLIENT>(client_.session));
        init_ = false;
    }
}

/**
 * @brief      parse connect info
 * @param [in] connectInfo: string of connect info
 * @param [in] proto: struct of conect info
 *
 * @return
 *      IDE_DAEMON_NONE_ERROR: parse connect info success
 *      IDE_DAEMON_INVALID_PARAM_ERROR: parse connect info failed
 */
IdeErrorT AdxDumpHdcHelper::ParseConnectInfo(const std::string &connectInfo,
    std::map<std::string, std::string> &proto) const
{
    std::string hostId;
    std::string hostPid;
    bool ret = StringUtils::ParseConnectInfo(connectInfo, hostId, hostPid);
    IDE_CTRL_VALUE_FAILED(ret == true, return IDE_DAEMON_INVALID_PARAM_ERROR, "ParseConnectInfo failed");
    std::string helperHostPid;
    ADX_GET_ENV(MM_ENV_ASCEND_HOSTPID, helperHostPid);
    if (!helperHostPid.empty() && StringUtils::IsIntDigital(helperHostPid)) {
        hostPid = helperHostPid;
    }
    proto[OPT_DEVICE_KEY] = hostId;
    proto[OPT_PID_KEY] =  hostPid;
    return IDE_DAEMON_NONE_ERROR;
}

IdeErrorT AdxDumpHdcHelper::HandShake(const std::string &info, IDE_SESSION &session) const
{
    uint16_t devId = 0;
    std::map<std::string, std::string> proto;
    IdeErrorT err = ParseConnectInfo(info, proto);
    IDE_CTRL_VALUE_FAILED(err == IDE_DAEMON_NONE_ERROR, return err, "parse connect info failed");
    IDE_LOGI("proto: hostId: %s, hostPid: %s", proto[OPT_DEVICE_KEY].c_str(), proto[OPT_PID_KEY].c_str());
    CommHandle handle = AdxCommOptManager::Instance().Connect(client_, proto);
    IDE_CTRL_VALUE_FAILED(handle.session != ADX_OPT_INVALID_HANDLE,
        return IDE_DAEMON_INVALID_PARAM_ERROR, "dump data connect failed");
    err = AdxMsgProto::SendResponse(handle, IDE_DUMP_REQ, devId, MsgStatus::MSG_STATUS_HAND_SHAKE);
    IDE_CTRL_VALUE_FAILED(err == IDE_DAEMON_NONE_ERROR, return err, "dump data hand shake failed");

    err = AdxMsgProto::RecvResponse(handle);
    IDE_CTRL_VALUE_FAILED(err == IDE_DAEMON_NONE_ERROR, return err, "dump date shake response failed");

    session = reinterpret_cast<HDC_SESSION>(handle.session);
    IDE_LOGD("handshake success");
    return IDE_DAEMON_NONE_ERROR;
}

IdeErrorT AdxDumpHdcHelper::DataProcess(const IDE_SESSION &session, const IdeDumpChunk &dumpChunk)
{
    uint32_t dataLen = 0;
    // malloc memory for save user data
    IDE_RETURN_IF_CHECK_ASSIGN_32U_ADD(sizeof(DumpChunk),
        dumpChunk.bufLen, dataLen, return IDE_DAEMON_INTERGER_REVERSED_ERROR);
    MsgProto *msg = AdxMsgProto::CreateMsgPacket(IDE_DUMP_REQ, 0, nullptr, dataLen);
    IDE_CTRL_VALUE_FAILED(msg != nullptr, return IDE_DAEMON_MALLOC_ERROR, "create message failed");
    std::unique_ptr<MsgProto, decltype(&IdeXfree)> sendDataMsgPtr(msg, IdeXfree);
    msg = nullptr;
    DumpChunk* data = reinterpret_cast<DumpChunk*>(sendDataMsgPtr->data);
    // check file name length, not longer than IDE_MAX_FILE_PATH
    IDE_CTRL_VALUE_FAILED(strlen(dumpChunk.fileName) < IDE_MAX_FILE_PATH, return IDE_DAEMON_INVALID_PATH_ERROR,
        "fileName is too long, not longer than %d length", IDE_MAX_FILE_PATH);
    int32_t err = strcpy_s(data->fileName, MAX_FILE_PATH_LENGTH, dumpChunk.fileName);
    IDE_CTRL_VALUE_FAILED(err == EOK, return IDE_DAEMON_INVALID_PATH_ERROR,
        "copy file name failed, err=%d, strerr=%s", err, strerror(errno));
    data->bufLen = dumpChunk.bufLen;
    data->flag = dumpChunk.flag;
    data->isLastChunk = dumpChunk.isLastChunk;
    data->offset = dumpChunk.offset;
    IDE_LOGI("dataLen: %u, bufLen: %u, flag: %d, isLastChunk: %u, offset: %ld, fileName: %s",
        dataLen, data->bufLen, data->flag, data->isLastChunk, data->offset, data->fileName);
    err = memcpy_s(data->dataBuf, data->bufLen, dumpChunk.dataBuf, dumpChunk.bufLen);
    IDE_CTRL_VALUE_FAILED(err == EOK, return IDE_DAEMON_MEMCPY_ERROR, "memcpy_s data buffer failed, err=%d", err);
    IDE_LOGI("the data to be sent has been assembled");
    CommHandle handle;
    handle.type = client_.type;
    handle.session = reinterpret_cast<OptHandle>(session);
    IdeErrorT code = SessionIsConnected(handle);
    IDE_CTRL_VALUE_FAILED(code == IDE_DAEMON_NONE_ERROR,
        return code, "check session status failed, err=%d", static_cast<int32_t>(code));
    uint32_t ret = AdxCommOptManager::Instance().Write(handle, sendDataMsgPtr.get(),
        sendDataMsgPtr->sliceLen + sizeof(MsgProto), COMM_OPT_BLOCK);
    IDE_CTRL_VALUE_FAILED(ret == IDE_DAEMON_OK, return IDE_DAEMON_WRITE_ERROR, "write dump file error");
    code = AdxMsgProto::RecvResponse(handle);
    IDE_CTRL_VALUE_FAILED((code == IDE_DAEMON_NONE_ERROR) || (code == IDE_DAEMON_DUMP_QUEUE_FULL),
        return code, "send file shake response failed, ret=%d", static_cast<int32_t>(code));
    IDE_LOGD("dump data process normal");
    return code;
}

IdeErrorT AdxDumpHdcHelper::SessionIsConnected(const CommHandle handle) const
{
    int32_t status = 0;
    int32_t ret = AdxGetAttrByCommHandle(&handle, HDC_SESSION_ATTR_STATUS, &status);
    if (ret != IDE_DAEMON_OK || status != HDC_SESSION_STATUS_CONNECT) {
        IDE_LOGE("session is not connected, ret: %d, status: %d", ret, status);
        return IDE_DAEMON_HDC_CHANNEL_ERROR;
    }
    return IDE_DAEMON_NONE_ERROR;
}

IdeErrorT AdxDumpHdcHelper::Finish(IDE_SESSION &session)
{
    CommHandle handle;
    handle.type = client_.type;
    handle.session = reinterpret_cast<OptHandle>(session);
    IdeErrorT err = AdxMsgProto::SendResponse(handle, IDE_DUMP_REQ, 0, MsgStatus::MSG_STATUS_DATA_END);
    IDE_CTRL_VALUE_FAILED(err == IDE_DAEMON_NONE_ERROR, return err, "dump data hand shake failed");
    AdxCommOptManager::Instance().Close(handle);
    session = nullptr;
    return IDE_DAEMON_NONE_ERROR;
}

/**
 * @brief dump start api,create a HDC session for dump
 * @param [in] connectInfo: remote connect info
 *
 * @return
 *      not NULL: Handle used by hdc
 *      NULL:     dump start failed
 */
IDE_SESSION HdcDumpStart(const char *connectInfo)
{
    IDE_CTRL_VALUE_FAILED(connectInfo != nullptr && strlen(connectInfo) != 0,
        return nullptr, "dump start msg is empty");
    if (!Adx::AdxDumpHdcHelper::Instance().Init()) {
        return nullptr;
    }
    IDE_SESSION session = nullptr;
    std::string connectInfoStr = std::string(connectInfo);
    Adx::AdxDumpHdcHelper::Instance().HandShake(connectInfoStr, session);
    return session;
}

/**
 * @brief dump data to remote server
 * @param [in] session: HDC session to dump data
 * @param [in] dumpChunk: Dump information
 * @return
 *      IDE_DAEMON_INVALID_PARAM_ERROR: invalid parameter
 *      IDE_DAEMON_UNKNOW_ERROR: write data failed
 *      IDE_DAEMON_NONE_ERROR:   write data succ
 */
IdeErrorT HdcDumpData(const IDE_SESSION session, const IdeDumpChunk *dumpChunk)
{
    IdeErrorT ret;
    IDE_CTRL_VALUE_FAILED(session != nullptr, return IDE_DAEMON_INVALID_PARAM_ERROR, "session is nullptr");
    IDE_CTRL_VALUE_FAILED(dumpChunk != nullptr, return IDE_DAEMON_INVALID_PARAM_ERROR, "IdeDumpChunk is nullptr");
    const uint32_t waitInsertDumpQueueTime = 100;
    int32_t retryInsertDumpQueueTimes = 3000; // 5min(3000 * 100ms)
    IDE_LOGD("dump data process entry");
    do {
        ret = Adx::AdxDumpHdcHelper::Instance().DataProcess(session, *dumpChunk);
        if (ret == IDE_DAEMON_DUMP_QUEUE_FULL) {
            (void)mmSleep(waitInsertDumpQueueTime);
            retryInsertDumpQueueTimes--;
        }
    } while (ret == IDE_DAEMON_DUMP_QUEUE_FULL && retryInsertDumpQueueTimes > 0);
    IDE_LOGD("dump data process exit");
    return ret;
}

/**
 * @brief send dump end msg
 * @param [in] session: HDC session to dump data
 * @return
 *      IDE_DAEMON_UNKNOW_ERROR: send dump end msg failed
 *      IDE_DAEMON_NONE_ERROR:   send dump end msg success
 */
IdeErrorT HdcDumpEnd(IDE_SESSION session)
{
    IDE_CTRL_VALUE_FAILED(session != nullptr, return IDE_DAEMON_INVALID_PARAM_ERROR, "session is nullptr");
    IDE_LOGI("dump data finish");
    return Adx::AdxDumpHdcHelper::Instance().Finish(session);
}
}