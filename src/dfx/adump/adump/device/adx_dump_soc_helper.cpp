/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "adx_dump_soc_helper.h"
#include "protocol/adx_msg_proto.h"
#include "adx_dump_record.h"
#include "memory_utils.h"
#include "common_utils.h"
#include "log/adx_log.h"
#include "string_utils.h"
#include "adx_datadump_server_soc.h"
namespace Adx {
AdxDumpSocHelper::AdxDumpSocHelper()
{
}

AdxDumpSocHelper::~AdxDumpSocHelper()
{
    UnInit();
}

/**
 * @brief      parse connect info
 * @param [in] connectInfo: string of connect info
 *
 * @return
 *      IDE_DAEMON_NONE_ERROR: parse connect info success
 *      IDE_DAEMON_INVALID_PARAM_ERROR: parse connect info failed
 */
IdeErrorT AdxDumpSocHelper::ParseConnectInfo(const std::string &connectInfo) const
{
    std::string hostId;
    std::string hostPid;
    bool ret = StringUtils::ParseConnectInfo(connectInfo, hostId, hostPid);
    IDE_CTRL_VALUE_FAILED(ret == true, return IDE_DAEMON_INVALID_PARAM_ERROR, "ParseConnectInfo failed");
    return IDE_DAEMON_NONE_ERROR;
}

bool  AdxDumpSocHelper::Init(const std::string &hostPid)
{
    if (!init_.test_and_set()) {
        if (AdxSocDataDumpInit(hostPid) == IDE_DAEMON_ERROR) {
            init_.clear();
            return false;
        }
    }
    return true;
}

void AdxDumpSocHelper::UnInit()
{
    if (init_.test_and_set()) {
        AdxSocDataDumpUnInit();
        init_.clear();
    }
}

IdeErrorT AdxDumpSocHelper::HandShake(const std::string &info, IDE_SESSION &session) const
{
    IdeErrorT err = ParseConnectInfo(info);
    if (err == IDE_DAEMON_NONE_ERROR) {
        session = DEFAULT_SOC_SESSION;
    }
    IDE_LOGD("soc handshake success");
    return err;
}

IdeErrorT AdxDumpSocHelper::DataProcess(const IDE_SESSION &session, const IdeDumpChunk &dumpChunk) const
{
    UNUSED(session);
    int err;
    uint32_t dataLen = 0;
    // malloc memory for save user data
    IDE_RETURN_IF_CHECK_ASSIGN_32U_ADD(sizeof(DumpChunk),
        dumpChunk.bufLen, dataLen, return IDE_DAEMON_INTERGER_REVERSED_ERROR);
    MsgProto *msg = AdxMsgProto::CreateMsgPacket(IDE_DUMP_REQ, 0, nullptr, dataLen);
    IDE_CTRL_VALUE_FAILED(msg != nullptr, return IDE_DAEMON_MALLOC_ERROR, "create message failed");
    SharedPtr<MsgProto> sendDataMsgPtr(msg, IdeXfree);
    msg = nullptr;
    DumpChunk* data = reinterpret_cast<DumpChunk*>(sendDataMsgPtr->data);
    err = strcpy_s(data->fileName, IDE_MAX_FILE_PATH, dumpChunk.fileName);
    IDE_CTRL_VALUE_FAILED(err == EOK, return IDE_DAEMON_INVALID_PATH_ERROR, "copy file name failed");
    data->bufLen = dumpChunk.bufLen;
    data->flag = dumpChunk.flag;
    data->isLastChunk = dumpChunk.isLastChunk;
    data->offset = dumpChunk.offset;
    IDE_LOGI("dataLen: %u, bufLen: %u, flag: %d, isLastChunk: %u, offset: %ld, fileName: %s",
        dataLen, data->bufLen, data->flag, data->isLastChunk, data->offset, data->fileName);
    err = memcpy_s(data->dataBuf, data->bufLen, dumpChunk.dataBuf, dumpChunk.bufLen);
    IDE_CTRL_VALUE_FAILED(err == EOK, return IDE_DAEMON_UNKNOW_ERROR, "memcpy_s data buffer failed");
    HostDumpDataInfo dataInfo = {sendDataMsgPtr, dataLen};
    MsgStatus status = MsgStatus::MSG_STATUS_NONE_ERROR;
    if (!AdxDumpRecord::Instance().RecordDumpDataToQueue(dataInfo)) {
        status = MsgStatus::MSG_STATUS_CACHE_FULL_ERROR;
    }

    if (status == MsgStatus::MSG_STATUS_CACHE_FULL_ERROR) {
        return IDE_DAEMON_DUMP_QUEUE_FULL;
    }
    IDE_LOGD("dump data process normal");
    return IDE_DAEMON_NONE_ERROR;
}

IdeErrorT AdxDumpSocHelper::Finish(IDE_SESSION &session) const
{
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
IDE_SESSION SocDumpStart(const char *connectInfo)
{
    IDE_LOGI("Soc dump start, connectInfo: %s", connectInfo);
    std::string connectInfoStr = connectInfo;
    std::string::size_type idx = connectInfoStr.find_last_of(";");
    if (idx == std::string::npos) {
        IDE_LOGE("invalid info str: %s", connectInfoStr.c_str());
        return nullptr;
    }
    std::string hostPid = connectInfoStr.substr(idx + 1);
    if (!Adx::AdxDumpSocHelper::Instance().Init(hostPid)) {
        return nullptr;
    }
    IDE_SESSION session = nullptr;
    Adx::AdxDumpSocHelper::Instance().HandShake(std::string(connectInfo), session);
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
IdeErrorT SocDumpData(const IDE_SESSION session, const IdeDumpChunk *dumpChunk)
{
    IdeErrorT ret;
    IDE_CTRL_VALUE_FAILED(session != nullptr, return IDE_DAEMON_INVALID_PARAM_ERROR, "session is nullptr");
    IDE_CTRL_VALUE_FAILED(dumpChunk != nullptr, return IDE_DAEMON_INVALID_PARAM_ERROR, "IdeDumpChunk is nullptr");
    const uint32_t waitInsertDumpQueueTime = 100;
    int32_t retryInsertDumpQueueTimes = 3000; // 5min(3000 * 100ms)
    IDE_LOGD("dump data process entry");
    do {
        ret = Adx::AdxDumpSocHelper::Instance().DataProcess(session, *dumpChunk);
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
IdeErrorT SocDumpEnd(IDE_SESSION session)
{
    IDE_CTRL_VALUE_FAILED(session != nullptr, return IDE_DAEMON_INVALID_PARAM_ERROR, "session is nullptr");
    IDE_LOGI("dump data finish");
    return Adx::AdxDumpSocHelper::Instance().Finish(session);
}
}
