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
#include "adx_dump_record.h"
#include "adx_datadump_callback.h"
#include "memory_utils.h"
#include "common_utils.h"
#include "log/adx_log.h"
#include "string_utils.h"
#include "adx_datadump_server_soc.h"
namespace Adx {
AdxDumpSocHelper::AdxDumpSocHelper() {}

AdxDumpSocHelper::~AdxDumpSocHelper() { UnInit(); }

/**
 * @brief      parse connect info
 * @param [in] connectInfo: string of connect info
 *
 * @return
 *      IDE_DAEMON_NONE_ERROR: parse connect info success
 *      IDE_DAEMON_INVALID_PARAM_ERROR: parse connect info failed
 */
IdeErrorT AdxDumpSocHelper::ParseConnectInfo(const std::string& connectInfo) const
{
    std::string hostId;
    std::string hostPid;
    bool ret = StringUtils::ParseConnectInfo(connectInfo, hostId, hostPid);
    IDE_CTRL_VALUE_FAILED(ret == true, return IDE_DAEMON_INVALID_PARAM_ERROR, "ParseConnectInfo failed");
    return IDE_DAEMON_NONE_ERROR;
}

bool AdxDumpSocHelper::Init(const std::string& hostPid)
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

IdeErrorT AdxDumpSocHelper::HandShake(const std::string& info, IDE_SESSION& session) const
{
    IdeErrorT err = ParseConnectInfo(info);
    if (err == IDE_DAEMON_NONE_ERROR) {
        session = DEFAULT_SOC_SESSION;
    }
    IDE_LOGD("soc handshake success");
    return err;
}

IdeErrorT AdxDumpSocHelper::DataProcess(const IDE_SESSION& session, const IdeDumpChunk& dumpChunk) const
{
    UNUSED(session);
    uint32_t dataLen = 0;
    IDE_CTRL_VALUE_FAILED(dumpChunk.fileName != nullptr, return IDE_DAEMON_INVALID_PARAM_ERROR, "fileName is null");
    IDE_CTRL_VALUE_FAILED(dumpChunk.dataBuf != nullptr, return IDE_DAEMON_INVALID_PARAM_ERROR, "dataBuf is null");
    IDE_CTRL_VALUE_FAILED(dumpChunk.bufLen > 0, return IDE_DAEMON_INVALID_PARAM_ERROR, "bufLen is 0");
    IDE_RETURN_IF_CHECK_ASSIGN_32U_ADD(
        sizeof(DumpChunk), dumpChunk.bufLen, dataLen, return IDE_DAEMON_INTERGER_REVERSED_ERROR);
    DumpChunk* data = reinterpret_cast<DumpChunk*>(IdeXmalloc(dataLen));
    IDE_CTRL_VALUE_FAILED(data != nullptr, return IDE_DAEMON_MALLOC_ERROR, "malloc failed");
    std::unique_ptr<DumpChunk, decltype(&IdeXfree)> dataPtr(data, IdeXfree);
    IDE_CTRL_VALUE_FAILED(
        strnlen(dumpChunk.fileName, MAX_FILE_PATH_LENGTH) < MAX_FILE_PATH_LENGTH, return IDE_DAEMON_INVALID_PATH_ERROR,
        "fileName is too long or not null-terminated, max=%u", MAX_FILE_PATH_LENGTH);
    int32_t err = strcpy_s(data->fileName, MAX_FILE_PATH_LENGTH, dumpChunk.fileName);
    IDE_CTRL_VALUE_FAILED(err == EOK, return IDE_DAEMON_INVALID_PATH_ERROR, "copy file name failed, err=%d", err);
    data->bufLen = dumpChunk.bufLen;
    data->flag = dumpChunk.flag;
    data->isLastChunk = dumpChunk.isLastChunk;
    data->offset = dumpChunk.offset;
    IDE_LOGI(
        "dataLen: %u, bufLen: %u, flag: %d, isLastChunk: %u, offset: %ld, fileName: %s", dataLen, data->bufLen,
        data->flag, data->isLastChunk, data->offset, data->fileName);
    err = memcpy_s(data->dataBuf, data->bufLen, dumpChunk.dataBuf, dumpChunk.bufLen);
    IDE_CTRL_VALUE_FAILED(err == EOK, return IDE_DAEMON_UNKNOW_ERROR, "memcpy_s data buffer failed");
    bool ret = AdxDumpRecord::Instance().RecordDumpDataToDisk(*data);
    IDE_CTRL_VALUE_FAILED(ret, return IDE_DAEMON_WRITE_ERROR, "record dump data to disk failed");
    IDE_LOGD("dump data process normal");
    return IDE_DAEMON_NONE_ERROR;
}

IdeErrorT AdxDumpSocHelper::Finish(IDE_SESSION& session) const
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
IDE_SESSION SocDumpStart(const char* connectInfo)
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
 *      IDE_DAEMON_WRITE_ERROR: write file failed
 *      IDE_DAEMON_MALLOC_ERROR: malloc memory failed
 *      IDE_DAEMON_INVALID_PATH_ERROR:  invalid dump path
 *      IDE_DAEMON_INTERGER_REVERSED_ERROR: integer overflow
 */
IdeErrorT SocDumpData(const IDE_SESSION session, const IdeDumpChunk* dumpChunk)
{
    IDE_CTRL_VALUE_FAILED(session != nullptr, return IDE_DAEMON_INVALID_PARAM_ERROR, "session is nullptr");
    IDE_CTRL_VALUE_FAILED(dumpChunk != nullptr, return IDE_DAEMON_INVALID_PARAM_ERROR, "IdeDumpChunk is nullptr");
    IDE_LOGD("dump data process entry");
    IdeErrorT ret = Adx::AdxDumpSocHelper::Instance().DataProcess(session, *dumpChunk);
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
} // namespace Adx
