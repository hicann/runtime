/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_get_file.h"
#include <mutex>
#include <algorithm>
#include "mmpa_api.h"
#include "log_file_utils.h"
#include "log_dsmi_drv.h"
#include "log_print.h"
#include "adcore_api.h"
#include "log_process_util.h"
#include "msnpureport_filedump.h"

namespace Adx {
static std::mutex g_pidMtx;
using stringMap = std::map<std::string, std::string>;
static const stringMap TYPE_TO_PATH({{"slog",        "/var/log/npu/slog/"},
                                     {"stackcore",   "/var/log/npu/coredump/"},
                                     {"bbox",        "/var/log/npu/hisi_logs/"},
                                     {"message",     "/var/log/"},
                                     {"event_sched", "/sys/devices/virtual/devdrv_manager/davinci_manager/node/"}
                                    });

static const std::string MESSAGE_LOG                        = "message";
static const std::string EVENT_LOG                          = "event_sched";
static const std::string MODULE_INFO_LOG                    = "module_info";
static const std::string MODULE_INFO_USER_PATH              = "/home/HwHiAiUser/ide_daemon/";
static const std::string DEVICE_MESSAGE_USER_PATH           = "/var/log/ide_daemon/";
static const std::string DEVICE_COLLECT_SCRIPT              = "/var/log_daemon_collect.sh";
static const std::string CONTAINER_NO_SUPPORT_MESSAGE       = "MESSAGE_CONTAINER_NO_SUPPORT";
static const std::string SEND_END_MSG                       = "game_over";
static const std::string ONE_SPACE                          = " ";
static const std::string COMMAND_SUDO                       = "sudo ";
static constexpr int32_t MESSAGES_MAX_NUM                   = 99;
static constexpr int32_t NON_DOCKER                         = 1;
static constexpr int32_t VM_NON_DOCKER                      = 3;
static constexpr int32_t MAX_FOLDER_DEPTH                   = 6;
static constexpr int32_t MAX_PARALLEL_NUM                   = 16;
static constexpr int32_t SCRIPT_COLLECT_MODE                = 1;
static constexpr int32_t SCRIPT_CLEAR_MODE                  = 2;
LogGetFile::intMap LogGetFile::g_numToPid;
int32_t LogGetFile::Init()
{
    mappingNum_ = 0;
    return SYS_OK;
}

int32_t LogGetFile::GetMappingPid(int32_t pid) const
{
    std::lock_guard<std::mutex> lck(g_pidMtx);
    auto it = std::find_if(g_numToPid.begin(), g_numToPid.end(), [pid](std::pair<int32_t, int32_t> p) {
        return p.second == pid;
    });
    if (it != g_numToPid.end()) {
        return it->first;
    }
    return MAX_PARALLEL_NUM + MAX_PARALLEL_NUM;
}

int32_t LogGetFile::TransferProcess(const CommHandle &handle, const std::string &logType,
                                    const std::string &src, const std::string &des) const
{
    int32_t ret = SYS_ERROR;
    // send file to host id(0)
    if (logType == EVENT_LOG) {
        ret = AdxSendFileByHandle(&handle, IDE_FILE_GETD_REQ, src.c_str(), des.c_str(), SEND_FILE_TYPE_REAL_FILE);
    } else {
        ret = AdxSendFileByHandle(&handle, IDE_FILE_GETD_REQ, src.c_str(), des.c_str(), SEND_FILE_TYPE_TMP_FILE);
    }
    return ret;
}

int32_t LogGetFile::TransferFile(const CommHandle &handle, const std::string &logType,
                                 const std::string &filePath, int32_t pid) const
{
    std::string tmpSuffix;
    std::string tmpFilePath;

    if ((logType != EVENT_LOG) && (logType != MESSAGE_LOG)) {
        tmpSuffix = "." + std::to_string(pid) + ".tmp";
        tmpFilePath = filePath + tmpSuffix;
        if (LogFileUtils::CopyFileAndRename(filePath, tmpFilePath) != SYS_OK) {
            SELF_LOG_ERROR("copy target file to tmp file failed, %s", filePath.c_str());
            return SYS_ERROR;
        }
    } else {
        tmpFilePath = filePath;
    }

    int32_t result = SYS_ERROR;
    do {
        // match prefixPath, such as: /var/log/npu/slog or /var/log/npu/coredump or /var/log/npu/hisi_logs
        std::string matchStr;
        if (GetPathPrefix(tmpFilePath, matchStr, pid) != SYS_OK) {
            break;
        }
        // remove .tmp and prefixPath
        std::string truncatedPath = tmpFilePath.substr(matchStr.length(),
            tmpFilePath.length() - tmpSuffix.length() - matchStr.length());
        int32_t err = TransferProcess(handle, logType, tmpFilePath, truncatedPath);
        if (err != SYS_OK) {
            SELF_LOG_ERROR(" Send file name or file content failed, path is %s", truncatedPath.c_str());
            break;
        }
        result = SYS_OK;
    } while (0);

    if ((logType != EVENT_LOG) && (logType != MESSAGE_LOG)) {
        (void)remove(tmpFilePath.c_str());
    }
    return result;
}

int32_t LogGetFile::ExportModuleInfo(const std::string &logType, int32_t pid) const
{
    for (const auto& info : MSNPUREPORT_FILE_DUMP_INFO) {
        if (logType.compare(info.label) != 0) {
            continue;
        }
        if (!LogFileUtils::IsFileExist(info.deviceScriptPath)) {
            SELF_LOG_INFO("Executable %s script %s is not exist", info.label, info.deviceScriptPath);
            return SYS_INVALID_PARAM;
        }
        SELF_LOG_INFO("Popen %s script: %s", info.label, info.deviceScriptPath);
        std::string shellCommand = COMMAND_SUDO + info.deviceScriptPath + ONE_SPACE + std::to_string(pid);
        int32_t ret = AdxCreateProcess(shellCommand.c_str());
        ONE_ACT_ERR_LOG(ret != SYS_OK, return SYS_ERROR, "AdxCreateProcess script failed");
        return SYS_OK;
    }
    SELF_LOG_ERROR("Find type %s in info list failed", logType.c_str());
    return SYS_ERROR;
}

int32_t LogGetFile::Process(const CommHandle &handle, const std::shared_ptr<MsgProto> &proto)
{
    ONE_ACT_ERR_LOG(proto->msgType != MsgType::MSG_DATA, return SYS_OK, "receive non data message");

    int32_t runEnv = 0;
    int32_t err = LogIdeGetRunEnvBySession(reinterpret_cast<HDC_SESSION>(handle.session), &runEnv);
    if (err != SYS_OK) {
        SELF_LOG_ERROR("Get run env failed, %d.", err);
        return SYS_ERROR;
    }
    if (runEnv != NON_DOCKER && runEnv != VM_NON_DOCKER) {
        SELF_LOG_WARN("Prohibit container get device file, runEnv=%d.", runEnv);
        (void)AdxSendMsgByHandle(&handle, IDE_FILE_GETD_REQ, CONTAINER_NO_SUPPORT_MESSAGE.c_str(),
            CONTAINER_NO_SUPPORT_MESSAGE.length() + 1);
        return SYS_OK;
    }
    std::string logType((IdeString)proto->data);
    std::vector<std::string> list;
    int32_t pid = 0;
    err = LogIdeGetPidBySession(reinterpret_cast<HDC_SESSION>(handle.session), &pid);
    if (err != SYS_OK) {
        SELF_LOG_ERROR("get pid failed, %d", err);
        return SYS_ERROR;
    }

    if (logType == MESSAGE_LOG) {
        std::lock_guard<std::mutex> lck(g_pidMtx);
        mappingNum_ = (mappingNum_ + 1) % MAX_PARALLEL_NUM;
        g_numToPid[mappingNum_ + MAX_PARALLEL_NUM] = pid;
    }

    err = GetFileList(logType, list, pid);
    if (err != SYS_OK) {
        if (err == SYS_INVALID_PARAM) {
            return SYS_OK;
        }
        return SYS_ERROR;
    }

    for (auto it : list) {
        if (((logType == MESSAGE_LOG) && (!IsValidMessageFile(it))) ||
            ((logType == EVENT_LOG) && !LogFileUtils::IsAccessible(it))) {
            continue;
        }

        if (logType == MESSAGE_LOG) {
            err = CopyFileToUserDir(it, pid);
            if (err != SYS_OK) {
                SELF_LOG_ERROR("preprocess message file failed, %s", it.c_str());
                continue;
            }
        }

        err = TransferFile(handle, logType, it, pid);
        if (err != SYS_OK) {
            SELF_LOG_WARN("Transfer file %s result is %d", it.c_str(), err);
        }
    }
    ClearTmpDir(logType, pid);

    err = AdxSendMsgByHandle(&handle, IDE_FILE_GETD_REQ, SEND_END_MSG.c_str(), SEND_END_MSG.length() + 1);
    ONE_ACT_ERR_LOG(err != SYS_OK, return SYS_ERROR,
            "send end msg failed");

    SELF_LOG_INFO("transfer %s file finished", logType.c_str());
    return SYS_OK;
}

void LogGetFile::ClearTmpDir(std::string &logType, int32_t pid)
{
    int32_t ret = 0;
    std::string path;
    if (logType == MESSAGE_LOG) {
        std::string shellCommand = COMMAND_SUDO + DEVICE_COLLECT_SCRIPT + ONE_SPACE + std::to_string(SCRIPT_CLEAR_MODE)
            + ONE_SPACE + std::to_string(GetMappingPid(pid));
        ret = AdxCreateProcess(shellCommand.c_str());
        NO_ACT_ERR_LOG(ret != SYS_OK, "AdxCreateProcess clear script failed, %s", shellCommand.c_str());
    }
    if (IsValidLogType(logType)) {
        path = MODULE_INFO_USER_PATH + MODULE_INFO_LOG + "/" + std::to_string(pid);
        ret = LogFileUtils::RemoveDir(path, 0);
        NO_ACT_ERR_LOG(ret != 0, "remove dir %s failed", path.c_str());
    }
}

int32_t LogGetFile::UnInit()
{
    return SYS_OK;
}

bool LogGetFile::IsValidLogType(const std::string &logType) const
{
    for (const auto& info : MSNPUREPORT_FILE_DUMP_INFO) {
        if (logType.compare(info.label) == 0) {
            return true;
        }
    }
    return false;
}

int32_t LogGetFile::GetFileList(const std::string &logType, std::vector<std::string> &list, int32_t pid)
{
    if (logType.empty()) {
        SELF_LOG_ERROR("logType is empty");
        return SYS_ERROR;
    }
    std::string basePath;
    std::string fileNamePrefix;
    int32_t recursiveDepth = MAX_FOLDER_DEPTH;

    bool isScriptLogType = IsValidLogType(logType);
    if (!isScriptLogType) {
        auto pathMap = TYPE_TO_PATH.find(logType);
        if (pathMap == TYPE_TO_PATH.end()) {
            SELF_LOG_ERROR("Invalid log type, %s", logType.c_str());
            return SYS_ERROR;
        }
        basePath = pathMap->second;
    } else {
        basePath = MODULE_INFO_USER_PATH + MODULE_INFO_LOG;
    }

    if (logType == MESSAGE_LOG) {
        fileNamePrefix = "messages";
        recursiveDepth = 0;
    } else if (isScriptLogType) {
        basePath = basePath + "/" + std::to_string(pid);
        int32_t ret = ExportModuleInfo(logType, pid);
        if (ret != SYS_OK) {
            return ret;
        }
        if (!LogFileUtils::IsDirExist(basePath)) {
            return SYS_OK;
        }
    }

    if (LogFileUtils::GetDirFileList(basePath, list, nullptr, fileNamePrefix, recursiveDepth) == false) {
        SELF_LOG_ERROR("get file list failed.");
        return SYS_ERROR;
    }
    return SYS_OK;
}

int32_t LogGetFile::GetPathPrefix(const std::string &tmpFilePath, std::string &matchStr, int32_t pid) const
{
    if (IsValidTmpFilePath(tmpFilePath, matchStr, pid)) {
        return SYS_OK;
    }

    std::string::size_type idx;
    for (auto it: TYPE_TO_PATH) {
        if (it.first == "message") {
            continue;
        }
        idx = tmpFilePath.find(it.second);
        if (idx != std::string::npos) {
            matchStr = it.second;
            return SYS_OK;
        }
    }

    // The "message" file has been copied to a special user directory.
    idx = tmpFilePath.find(DEVICE_MESSAGE_USER_PATH + "message/" + std::to_string(GetMappingPid(pid)));
    if (idx != std::string::npos) {
        matchStr = DEVICE_MESSAGE_USER_PATH + "message/" + std::to_string(GetMappingPid(pid));
        return SYS_OK;
    }

    SELF_LOG_ERROR("Invalid device file path prefix, %s", tmpFilePath.c_str());
    return SYS_ERROR;
}

bool LogGetFile::IsValidTmpFilePath(const std::string &tmpFilePath, std::string &matchStr, int32_t pid) const
{
    std::string::size_type idx;
    for (const auto& info : MSNPUREPORT_FILE_DUMP_INFO) {
        idx = tmpFilePath.find(MODULE_INFO_USER_PATH + info.hostFilePath + "/" + std::to_string(pid));
        if (idx != std::string::npos) {
            matchStr = MODULE_INFO_USER_PATH + info.hostFilePath + "/" + std::to_string(pid);
            return true;
        }
    }
    return false;
}

bool LogGetFile::IsIntDigital(const std::string &digital) const
{
    if (digital.empty()) {
        return false;
    }

    size_t len = digital.length();
    for (size_t i = 0; i < len; i++) {
        if (!isdigit(digital[i])) {
            return false;
        }
    }
    return true;
}

bool LogGetFile::IsValidMessageFile(std::string &messagesFilePath) const
{
    std::string::size_type idx = messagesFilePath.rfind(".");
    if (idx != std::string::npos) {
        std::string agingNumStr = messagesFilePath.substr(idx + 1);
        if (!IsIntDigital(agingNumStr)) {
            SELF_LOG_ERROR("agingNumStr is not a number, %s, skip", agingNumStr.c_str());
            return false;
        }

        try {
            int32_t agingNum = std::stoi(agingNumStr);
            if (agingNum > MESSAGES_MAX_NUM) {
                SELF_LOG_WARN("exceed messages max num, %d, skip", agingNum);
                return false;
            }
        } catch (std::exception &e) {
            SELF_LOG_ERROR("message file name %s is invalid, %s, skip", messagesFilePath.c_str(), e.what());
            return false;
        }
    }
    return true;
}

int32_t LogGetFile::CopyFileToUserDir(std::string &messagesFilePath, int32_t pid) const
{
    std::string messagesFileName;
    ONE_ACT_ERR_LOG(LogFileUtils::GetFileName(messagesFilePath, messagesFileName) != SYS_OK,
        return SYS_ERROR, "get file name failed");
    std::string messagesNewPath = DEVICE_MESSAGE_USER_PATH + "message/" + std::to_string(GetMappingPid(pid)) + "/";
    std::string messagesNewFile = messagesNewPath + messagesFileName;

    std::string shellCommand = COMMAND_SUDO + DEVICE_COLLECT_SCRIPT + ONE_SPACE + std::to_string(SCRIPT_COLLECT_MODE)
        + ONE_SPACE + std::to_string(GetMappingPid(pid));
    int32_t ret = AdxCreateProcess(shellCommand.c_str());
    ONE_ACT_ERR_LOG(ret != SYS_OK, return SYS_ERROR, "AdxCreateProcess collect script failed, %s",
        shellCommand.c_str());

    if (!LogFileUtils::IsFileExist(messagesNewFile)) {
        SELF_LOG_ERROR("copy message file failed, %s", messagesNewFile.c_str());
        return SYS_ERROR;
    }

    // switch /var/log/messages to /var/log/ide_daemon/messages
    messagesFilePath = messagesNewFile;
    return SYS_OK;
}
}