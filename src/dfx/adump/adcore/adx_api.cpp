/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "adx_api.h"
#include "mmpa_api.h"
#include "ascend_hal.h"
#include "protocol/adx_msg_proto.h"
#include "log/adx_log.h"
#include "common/file_utils.h"
#include "device/adx_dsmi.h"
#include "config.h"
#include "create_func.h"
#include "adcore_api.h"
#include "memory_utils.h"
#include "adx_msg.h"
#include "adx_comm_opt_manager.h"
using namespace Adx;
static constexpr int32_t BLOCK_RETURN_CODE = 4;
static constexpr int32_t RESULT_LEN_MAX = 100;
static constexpr uint32_t DEFAULT_TIMEOUT = 10000; // 10000ms

/**
 * @brief        hdc connect core dump server
 * @param  [out] client     : send file communication client handle
 * @param  [in]  devId      : send file device id
 * @return       CommHandle : client handle
 */
static CommHandle AdxHdcConnect(CommHandle &client, uint16_t devId,
    AdxHdcServiceType hdcType = HDC_SERVICE_TYPE_IDE_FILE_TRANS)
{
    std::map<std::string, std::string> info;
    info[OPT_DEVICE_KEY] = std::to_string(devId);
    info[OPT_SERVICE_KEY] = std::to_string(hdcType);
    CommHandle session = {OptType::COMM_HDC, ADX_OPT_INVALID_HANDLE, NR_COMPONENTS, -1, nullptr};
    std::unique_ptr<AdxCommOpt> opt (CreateAdxCommOpt(OptType::COMM_HDC));
    IDE_CTRL_VALUE_FAILED(opt != nullptr, return session,
        "create hdc commopt exception");
    bool ret = AdxCommOptManager::Instance().CommOptsRegister(opt);
    IDE_CTRL_VALUE_FAILED(ret, return client, "register hdc failed");
    client = AdxCommOptManager::Instance().OpenClient(OptType::COMM_HDC, info);
    IDE_CTRL_VALUE_FAILED(client.session != ADX_OPT_INVALID_HANDLE, return client,
        "open client failed");
    session = AdxCommOptManager::Instance().Connect(client, info);
    if (session.session == ADX_OPT_INVALID_HANDLE) {
        (void)AdxCommOptManager::Instance().CloseClient(client);
    }
    return session;
}

/**
 * @brief  send file common opreate
 * @param  [in]  handle     : send file communication handle
 * @param  [in]  srcFile    : send file source file with path
 * @return IDE_DAEMON_OK(0) : send file success, IDE_DAEMON_ERROR(-1) : send file failed
 */
static int32_t AdxCommonGetFile(const CommHandle &handle, const std::string &srcFile)
{
    IDE_CTRL_VALUE_FAILED(!srcFile.empty(), return IDE_DAEMON_ERROR, "source file input invalid");
    // create dir if not exist
    std::string saveDirName = FileUtils::GetFileDir(srcFile);
    if (!FileUtils::IsFileExist(saveDirName)) {
        if (FileUtils::CreateDir(saveDirName) != IDE_DAEMON_NONE_ERROR) {
            IDE_LOGE("create dir failed path: %s", saveDirName.c_str());
            return IDE_DAEMON_ERROR;
        }
    }
    // get file
    int32_t fd = mmOpen2(srcFile.c_str(), M_RDWR | M_CREAT | M_BINARY | M_TRUNC, M_IRUSR | M_IWRITE);
    char errBuf[MAX_ERRSTR_LEN + 1] = {0};
    IDE_CTRL_VALUE_FAILED(fd >= 0, return IDE_DAEMON_ERROR, "open file exception, info : %s",
                          mmGetErrorFormatMessage(mmGetErrorCode(), errBuf, MAX_ERRSTR_LEN));

    int32_t err = AdxMsgProto::RecvFile(handle, fd);
    if (err != IDE_DAEMON_NONE_ERROR && err != IDE_DAEMON_CHANNEL_ERROR) {
        mmClose(fd);
        fd = -1;
        IDE_LOGE("receive file failed, info : %s", srcFile.c_str());
        (void)remove(srcFile.c_str());
        return IDE_DAEMON_ERROR;
    }

    mmClose(fd);
    fd = -1;

    if (err == IDE_DAEMON_CHANNEL_ERROR) {
        IDE_LOGE("send file receive response failed,\n" \
            "maybe multiple msnpureports executed at the same time, which is not supported,\n" \
            "please execute msnpureport only once per time later if needed");
    }
    return IDE_DAEMON_OK;
}

/**
 * @brief  get device file
 * @param  [in]  devId      : physical device id
 * @param  [in]  desPath    : send file to destination path
 * @param  [in]  logType    : file type, stackcore, slog, bbox, message
 * @param  [in]  timeout    : 0 wait_always, > 0 wait_timeout; unit: ms
 * @return IDE_DAEMON_OK(0) : get file success, IDE_DAEMON_ERROR(-1) : get file failed
 */
int32_t AdxGetDeviceFileTimeout(uint16_t devId, IdeString desPath, IdeString logType, uint32_t timeout)
{
    int32_t err = IDE_DAEMON_ERROR;
    IDE_CTRL_VALUE_FAILED(desPath != nullptr && logType != nullptr, return err,
        "send file input parameter invalid");
    IDE_RUN_LOGI("get device file to %s", desPath);
    CommHandle client = {OptType::COMM_HDC, ADX_OPT_INVALID_HANDLE, NR_COMPONENTS, -1, nullptr};
    uint32_t logId = 0;
    err = AdxGetLogIdByPhyId(devId, &logId);
    IDE_CTRL_VALUE_FAILED(err == IDE_DAEMON_OK, return err, "get device logic id failed");
    CommHandle handle = AdxHdcConnect(client, logId);
    IDE_CTRL_VALUE_FAILED(handle.session != ADX_OPT_INVALID_HANDLE, return IDE_DAEMON_ERROR,
        "send file hdc client connect failed");
    handle.timeout = timeout;
    std::string basePath = desPath;
    std::string value;
    int32_t result = IDE_DAEMON_OK;
    MsgCode code = AdxMsgProto::SendMsgData(handle, IDE_FILE_GETD_REQ, MsgStatus::MSG_STATUS_NONE_ERROR,
                                            logType, strlen(logType) + 1);
    IDE_CTRL_VALUE_FAILED(code == IDE_DAEMON_NONE_ERROR, goto GET_ERROR, "send file hand shake failed");
    do {
        code = AdxMsgProto::GetStringMsgData(handle, value);
        IDE_CTRL_VALUE_FAILED(code == IDE_DAEMON_NONE_ERROR, goto GET_ERROR, "get file shake response failed, ret=%d",
            static_cast<int32_t>(code));
        size_t msgSize = IdeDaemon::Common::Config::CONTAINER_NO_SUPPORT_MESSAGE.length();
        if (value.compare(0, msgSize, IdeDaemon::Common::Config::CONTAINER_NO_SUPPORT_MESSAGE) == 0) {
            result = BLOCK_RETURN_CODE;
            break;
        }
        msgSize = IdeDaemon::Common::Config::SEND_END_MSG.length();
        if (value.compare(0, msgSize, IdeDaemon::Common::Config::SEND_END_MSG) == 0) {
            break;
        }
        IDE_LOGD("receive file relative path and name is %s", value.c_str());
        value = basePath + OS_SPLIT_STR + value;
#if (OS_TYPE != LINUX)
        value = FileUtils::ReplaceAll(value, "/", "\\");
#endif
        err = AdxCommonGetFile(handle, value);
        if (err != IDE_DAEMON_OK) {
            IDE_LOGE("get file process failed");
            continue;
        }
        (void)mmChmod(value.c_str(), M_IRUSR); // readonly, 400
    } while (true);

GET_ERROR:
    (void)AdxCommOptManager::Instance().Close(handle);
    (void)AdxCommOptManager::Instance().CloseClient(client);
    return result;
}

/**
 * @brief  get file value from the peer end and write to file
 * @param  [in]  handle  :    handle for communicating with the peer end
 * @param  [in]  fd      :    file descriptor
 * @return IDE_DAEMON_OK(0) : recv file success, IDE_DAEMON_ERROR(-1) : recv file failed
 */
static int32_t AdxRecvFile(const CommHandle &handle, int32_t fd)
{
    IDE_CTRL_VALUE_FAILED(fd >= 0, return IDE_DAEMON_ERROR, "file fd input failed");
    MsgProto *msg = nullptr;
    int32_t length = 0;
    while (true) {
        int32_t ret = AdxCommOptManager::Instance().Read(handle, reinterpret_cast<IdeRecvBuffT>(&msg),
            length, DEFAULT_TIMEOUT);
        IDE_CTRL_VALUE_FAILED((ret == IDE_DAEMON_OK) && (msg != nullptr), return IDE_DAEMON_ERROR,
            "receive file failed, ret: %d", ret);
        if (msg->msgType == MsgType::MSG_CTRL) { // check the message is ctrl or not
            IDE_LOGW("receive control message from device, stop receiving");
            IDE_XFREE_AND_SET_NULL(msg);
            return IDE_DAEMON_ERROR;
        }
        if (msg->sliceLen != 0) {
            mmSsize_t len = mmWrite(fd, msg->data, msg->sliceLen);
            if (len < 0) {
                char errBuf[MAX_ERRSTR_LEN + 1] = {0};
                IDE_LOGE("write file failed, error info: [%s]",
                         mmGetErrorFormatMessage(mmGetErrorCode(), errBuf, MAX_ERRSTR_LEN));
                IDE_XFREE_AND_SET_NULL(msg);
                return IDE_DAEMON_ERROR;
            }
        }

        if (msg->totalLen == msg->sliceLen + msg->offset) {
            break;
        }

        IDE_XFREE_AND_SET_NULL(msg);
    }
    if (AdxSendMsg(&handle, HDC_END_MSG, strlen(HDC_END_MSG)) != IDE_DAEMON_OK) {
        IDE_LOGW("send file response message exception");
    }

    IDE_XFREE_AND_SET_NULL(msg);
    return IDE_DAEMON_OK;
}

/**
 * @brief  get device file
 * @param  [in]  devId      : physical device id
 * @param  [in]  desPath    : send file to destination path
 * @param  [in]  logType    : file type, stackcore, slog, bbox, message
 * @return IDE_DAEMON_OK(0) : get file success, IDE_DAEMON_ERROR(-1) : get file failed
 */
int32_t AdxGetDeviceFile(uint16_t devId, IdeString desPath, IdeString logType)
{
    return AdxGetDeviceFileTimeout(devId, desPath, logType, DEFAULT_TIMEOUT);
}

/**
 * @brief  create file and receive value
 * @param  [in]  handle  :    handle for communicating with the peer end
 * @param  [in]  file    :    the file name
 * @return IDE_DAEMON_OK(0) : recv file success, IDE_DAEMON_ERROR(-1) : recv file failed
 */
static int32_t AdxCreateFileAndRecvValue(const CommHandle &handle, std::string &file)
{
    // create dir if not exist
    std::string saveDirName = FileUtils::GetFileDir(file);
    if (!FileUtils::IsFileExist(saveDirName)) {
        if (FileUtils::CreateDir(saveDirName) != IDE_DAEMON_NONE_ERROR) {
            IDE_LOGE("create dir failed path: %s", saveDirName.c_str());
            return IDE_DAEMON_ERROR;
        }
    }
    // get file
    int32_t fd = mmOpen2(file.c_str(), M_RDWR | M_CREAT | M_BINARY | M_TRUNC, M_IRUSR | M_IWRITE);
    char errBuf[MAX_ERRSTR_LEN + 1] = {0};
    IDE_CTRL_VALUE_FAILED(fd >= 0, return IDE_DAEMON_ERROR, "open file exception, info : %s",
                        mmGetErrorFormatMessage(mmGetErrorCode(), errBuf, MAX_ERRSTR_LEN));

    int32_t err = AdxRecvFile(handle, fd);
    if (err == IDE_DAEMON_ERROR) {
        mmClose(fd);
        fd = -1;
        IDE_LOGE("receive file failed, info : %s", file.c_str());
        (void)remove(file.c_str());
        return IDE_DAEMON_ERROR;
    }
    mmClose(fd);
    fd = -1;
    (void)mmChmod(file.c_str(), M_IRUSR); // readonly, 400
    return IDE_DAEMON_OK;
}

/**
 * @brief  get device file from specified hdc server and component
 * @param  [in]  devId      : physical device id
 * @param  [in]  desPath    : send file to destination path
 * @param  [in]  logType    : file type
 * @param  [in]  hdcType    : hdc server type
 * @param  [in]  compType   : component type
 * @return IDE_DAEMON_OK(0) : get file success, IDE_DAEMON_ERROR(-1) : get file failed
 */
int32_t AdxGetSpecifiedFile(uint16_t devId, IdeString desPath, IdeString logType, int32_t hdcType, int32_t compType)
{
    int32_t err = IDE_DAEMON_ERROR;
    IDE_CTRL_VALUE_FAILED((desPath != nullptr) && (logType != nullptr), return err,
        "send file input parameter invalid");
    IDE_RUN_LOGI("get device file to %s", desPath);
    CommHandle client = {OptType::COMM_HDC, ADX_OPT_INVALID_HANDLE, NR_COMPONENTS, -1, nullptr};
    uint32_t logId = 0;
    err = AdxGetLogIdByPhyId(devId, &logId);
    IDE_CTRL_VALUE_FAILED(err == IDE_DAEMON_OK, return err, "get device logic id failed");
    CommHandle handle = AdxHdcConnect(client, logId, static_cast<AdxHdcServiceType>(hdcType));
    IDE_CTRL_VALUE_FAILED(handle.session != ADX_OPT_INVALID_HANDLE, return IDE_DAEMON_ERROR,
        "send file hdc client connect failed");
    handle.comp = static_cast<ComponentType>(compType);
    err = AdxSendMsg(static_cast<AdxCommConHandle>(&handle), logType, strlen(logType));
    IDE_CTRL_VALUE_FAILED(err == IDE_DAEMON_OK, return err, "send data message failed");
    std::string basePath = desPath;
    do {
        uint32_t len = RESULT_LEN_MAX;
        IdeStringBuffer ptr = static_cast<IdeStringBuffer>(IdeXmalloc(len));
        err = AdxRecvMsg(&handle, &ptr, &len, DEFAULT_TIMEOUT);
        if (err != IDE_DAEMON_OK) {
            IDE_XFREE_AND_SET_NULL(ptr);
            IDE_LOGE("receive message failed, ret: %d", err);
            break;
        }
        std::string value(ptr);
        IDE_XFREE_AND_SET_NULL(ptr);
        size_t msgSize = IdeDaemon::Common::Config::CONTAINER_NO_SUPPORT_MESSAGE.length();
        if (value.compare(0, msgSize, IdeDaemon::Common::Config::CONTAINER_NO_SUPPORT_MESSAGE) == 0) {
            err = BLOCK_RETURN_CODE;
            break;
        }
        msgSize = sizeof(HDC_END_MSG);
        if (value.compare(0, msgSize, HDC_END_MSG) == 0) {
            break;
        }
        err = AdxSendMsg(&handle, HDC_END_MSG, strlen(HDC_END_MSG));
        if (err != IDE_DAEMON_OK) {
            IDE_LOGW("send name response message exception");
        }
        IDE_LOGD("receive file relative path and name is %s", value.c_str());
        value = basePath + OS_SPLIT_STR + value;

        if (AdxCreateFileAndRecvValue(handle, value) != IDE_DAEMON_OK) {
            err = IDE_DAEMON_ERROR;
            break;
        }
    } while (true);

    (void)AdxCommOptManager::Instance().Close(handle);
    (void)AdxCommOptManager::Instance().CloseClient(client);
    return err;
}

int32_t AdxRecvDevFileTimeout(AdxCommHandle handle, AdxString desPath, uint32_t timeout, AdxStringBuffer fileName,
    uint32_t fileNameLen)
{
    IDE_CTRL_VALUE_FAILED(handle != nullptr, return IDE_DAEMON_ERROR, "handle is NULL.");
    IDE_CTRL_VALUE_FAILED(desPath != nullptr, return IDE_DAEMON_ERROR, "desPath is NULL.");
    IDE_CTRL_VALUE_FAILED(fileName != nullptr, return IDE_DAEMON_ERROR, "fileName is NULL.");

    uint32_t len = fileNameLen;
    int32_t ret = AdxRecvMsg(handle, &fileName, &len, timeout);
    if (ret != IDE_DAEMON_OK) {
        return ret;
    }
    std::string value(fileName);
    if (value.compare(HDC_END_MSG) == 0) {
        return IDE_DAEMON_ERROR;
    }
    value = std::string(desPath) + OS_SPLIT_STR + value;
    if (AdxCreateFileAndRecvValue(*handle, value) != IDE_DAEMON_OK) {
        return IDE_DAEMON_ERROR;
    }
    return IDE_DAEMON_OK;
}