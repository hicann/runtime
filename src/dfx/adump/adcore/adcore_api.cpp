/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "adcore_api.h"
#include "hdc_api.h"
#include "memory_utils.h"
#include "log/adx_log.h"
#include "adx_msg_proto.h"
#include "file_utils.h"
#include "create_func.h"
#include "adx_component.h"
#include "adx_comm_opt_manager.h"
using namespace Adx;
constexpr int32_t TIME_ONE_THOUSAND = 1000;
/**
 * @brief       : watch hdc session to get result
 * @param [in]  : session        hdc session
 * @param [in]  : resultBuf      request info
 * @param [in]  : timeout        0 : wait_always, > 0 wait_timeout, < 0 wait_default; unit: ms
 * @return      : IDE_DAEMON_OK succeed; others failed
 */
static int32_t ReadSettingResult(const HDC_SESSION session, const AdxStringBuffer resultBuf, uint32_t resultLen,
    int32_t timeout)
{
    int32_t err = IDE_DAEMON_ERROR;
    if ((session == nullptr) || (resultBuf == nullptr)) {
        return err;
    }

    do {
        CommHandle handle{COMM_HDC, reinterpret_cast<OptHandle>(session), NR_COMPONENTS, timeout, nullptr};
        std::string value;
        err = AdxMsgProto::GetStringMsgData(handle, value);
        if (err == IDE_DAEMON_OK) {
            if (value.empty()) {
                (void)usleep(TIME_ONE_THOUSAND); // sleep 1ms, avoid frequent read hdc
                continue;
            }

            if (value.compare(0, strlen(HDC_END_MSG), HDC_END_MSG, strlen(HDC_END_MSG)) == 0) {
                break;
            }

            err = memcpy_s(resultBuf, resultLen, value.c_str(), value.length());
            if (err != EOK) {
                IDE_LOGE("memcpy_s failed, result = %d.", err);
                err = IDE_DAEMON_ERROR;
                break;
            }
        }
    } while (err == IDE_DAEMON_OK);

    return err;
}

static int32_t AdxSendMsgToServerByType(AdxHdcServiceType type, IdeTlvConReq req, const AdxStringBuffer result,
    uint32_t resultLen, int32_t timeout = -1)
{
    int32_t err = IDE_DAEMON_ERROR;
    std::unique_ptr<AdxCommOpt> opt (CreateAdxCommOpt(OptType::COMM_HDC));
    IDE_CTRL_VALUE_FAILED(opt != nullptr, return err, "create hdc commopt exception");
    bool ret = AdxCommOptManager::Instance().CommOptsRegister(opt);
    IDE_CTRL_VALUE_FAILED(ret, return err, "register hdc failed");

    HDC_CLIENT client = Adx::HdcClientCreate(type);
    if (client == nullptr) {
        IDE_LOGW("Hdc client create exception");
        return err;
    }

    HDC_SESSION session = nullptr;
    err = Adx::HdcSessionConnect(0, req->dev_id, client, &session);
    if (err != IDE_DAEMON_OK) {
        IDE_LOGW("Connect to device exception, please make sure device id is valid, device id = %d.", req->dev_id);
        (void)Adx::HdcClientDestroy(client);
        return err;
    }

    CommHandle handle{COMM_HDC, reinterpret_cast<OptHandle>(session), NR_COMPONENTS, -1, nullptr};
    err = Adx::AdxMsgProto::SendMsgData(handle, req->type, MsgStatus::MSG_STATUS_NONE_ERROR,
        static_cast<IdeSendBuffT>(req->value), req->len);
    if (err != EN_OK) {
        IDE_LOGE("Write level info to device failed by hdc, result=%d.", err);
    } else if (result != nullptr) {
        err = ReadSettingResult(session, result, resultLen, timeout);
    }

    (void)Adx::HdcSessionDestroy(session);
    (void)Adx::HdcClientDestroy(client);
    return err;
}

int32_t AdxSendMsgAndGetResultByType(AdxHdcServiceType type, IdeTlvConReq req, const AdxStringBuffer result,
    uint32_t resultLen)
{
    if ((req == nullptr) || (result == nullptr)) {
        return IDE_DAEMON_ERROR;
    }
    return AdxSendMsgToServerByType(type, req, result, resultLen);
}

int32_t AdxSendMsgAndNoResultByType(AdxHdcServiceType type, IdeTlvConReq req)
{
    if (req == nullptr) {
        return IDE_DAEMON_ERROR;
    }
    return AdxSendMsgToServerByType(type, req, nullptr, 0);
}

int32_t AdxSendMsgByHandle(AdxCommConHandle handle, CmdClassT type, AdxString data, uint32_t len)
{
    if ((handle == nullptr) || (data == nullptr)) {
        return IDE_DAEMON_ERROR;
    }

    std::unique_ptr<AdxCommOpt> opt (CreateAdxCommOpt(handle->type));
    IDE_CTRL_VALUE_FAILED(opt != nullptr, return IDE_DAEMON_ERROR, "create hdc commopt exception");
    bool ret = AdxCommOptManager::Instance().CommOptsRegister(opt);
    IDE_CTRL_VALUE_FAILED(ret, return IDE_DAEMON_ERROR, "register hdc failed");

    return (Adx::AdxMsgProto::SendMsgData(*handle, type, MsgStatus::MSG_STATUS_NONE_ERROR,
        static_cast<IdeSendBuffT>(data), len) == IDE_DAEMON_NONE_ERROR) ? IDE_DAEMON_OK : IDE_DAEMON_ERROR;
}

int32_t AdxSendFileByHandle(AdxCommConHandle handle, CmdClassT type, AdxString srcPath, AdxString desPath,
    SendFileType flag)
{
    if ((handle == nullptr) || (srcPath == nullptr) || (desPath == nullptr)) {
        return IDE_DAEMON_ERROR;
    }
    if (!Adx::FileUtils::IsFileExist(std::string(srcPath))) {
        IDE_LOGE("File %s does not exist.", srcPath);
        return IDE_DAEMON_ERROR;
    }

    std::unique_ptr<AdxCommOpt> opt (CreateAdxCommOpt(handle->type));
    IDE_CTRL_VALUE_FAILED(opt != nullptr, return IDE_DAEMON_ERROR, "create hdc commopt exception");
    bool err = AdxCommOptManager::Instance().CommOptsRegister(opt);
    IDE_CTRL_VALUE_FAILED(err, return IDE_DAEMON_ERROR, "register hdc failed");

    int32_t fd = mmOpen2(srcPath, M_RDONLY | M_BINARY, S_IREAD);
    if (fd < 0) {
        char errBuf[MAX_ERRSTR_LEN + 1] = {0};
        IDE_LOGE("open send file failed, info : %s, open file is %s",
            mmGetErrorFormatMessage(mmGetErrorCode(), errBuf, MAX_ERRSTR_LEN), srcPath);
        return IDE_DAEMON_ERROR;
    }

    int32_t ret = Adx::AdxMsgProto::SendMsgData(*handle, type, MsgStatus::MSG_STATUS_NONE_ERROR,
        static_cast<IdeSendBuffT>(desPath), strlen(desPath) + 1U);
    if (ret != IDE_DAEMON_NONE_ERROR) {
        if (fd >= 0) {
            mmClose(fd);
            fd = -1;
        }
        IDE_LOGE("send file path failed, file path name is %s", srcPath);
        return IDE_DAEMON_ERROR;
    }

    if (flag == SEND_FILE_TYPE_REAL_FILE) {
        ret = Adx::AdxMsgProto::SendEventFile(*handle, type, 0, fd);
    } else {
        ret = Adx::AdxMsgProto::SendFile(*handle, type, 0, fd);
    }
    if (fd >= 0) {
        mmClose(fd);
        fd = -1;
    }

    if (ret != IDE_DAEMON_NONE_ERROR) {
        IDE_LOGE("read or send file failed, start to send ctrl msg to notice host, ret=%d", ret);
        ret = IDE_DAEMON_ERROR;
    }
    return ret;
}

/**
 * @brief       : convert component type to CmdClassT
 * @param  [in] : cmptType     component type
 * @return      : NR_IDE_CMD_CLASS failed; others succeed
 */
static CmdClassT GetReqTypeByComponentType(ComponentType cmptType)
{
    CmdClassT cmdType = NR_IDE_CMD_CLASS;
    for (uint32_t i = 0; i < ARRAY_LEN(g_componentsInfo, AdxComponentMap); i++) {
        if (cmptType == g_componentsInfo[i].cmptType) {
            cmdType = g_componentsInfo[i].cmdType;
            break;
        }
    }
    return cmdType;
}

/**
 * @brief       : get attribute value by communication handle
 * @param [in]  : handle    hdc session
 * @param [in]  : attr      attribute type
 * @param [out] : value     attribute value
 * @return      : IDE_DAEMON_OK succeed; IDE_DAEMON_ERROR failed
 */
int32_t AdxGetAttrByCommHandle(AdxCommConHandle handle, int32_t attr, int32_t *value)
{
    if (handle == nullptr || value == nullptr) {
        IDE_LOGE("get attribute failed, invalid input");
        return IDE_DAEMON_ERROR;
    }
    return IdeGetAttrBySession(reinterpret_cast<HDC_SESSION>(handle->session), attr, value);
}

/**
 * @brief       : create long link communication handle
 * @param [in]  : type         server type
 * @param [in]  : devId        device id
 * @param [in]  : compType     component type
 * @return      : nullptr failed; others succeed
 */
AdxCommHandle AdxCreateCommHandle(AdxHdcServiceType type, int32_t devId, ComponentType compType)
{
    std::unique_ptr<AdxCommOpt> opt (CreateAdxCommOpt(OptType::COMM_HDC));
    IDE_CTRL_VALUE_FAILED(opt != nullptr, return nullptr, "create hdc commopt exception");
    bool ret = AdxCommOptManager::Instance().CommOptsRegister(opt);
    IDE_CTRL_VALUE_FAILED(ret, return nullptr, "register hdc failed");

    HDC_CLIENT client = Adx::HdcClientCreate(type);
    IDE_CTRL_VALUE_FAILED(client != nullptr, return nullptr, "Hdc client create exception");

    HDC_SESSION session = nullptr;
    int32_t err = Adx::HdcSessionConnect(0, devId, client, &session);
    if (err != IDE_DAEMON_OK) {
        IDE_LOGW("Connect to device exception, please make sure device id is valid, device id = %d.", devId);
        (void)Adx::HdcClientDestroy(client);
        return nullptr;
    }

    AdxCommHandle handle = static_cast<AdxCommHandle>(IdeXmalloc(sizeof(CommHandle)));
    IDE_CTRL_VALUE_FAILED(handle != nullptr, return handle, "Malloc handle failed.");
    handle->type = OptType::COMM_HDC;
    handle->session = reinterpret_cast<OptHandle>(session);
    handle->client = client;
    handle->comp = compType;
    handle->timeout = 0;

    const std::string defaultMessage = "LONG_LINK_DEFAULT";
    err = Adx::AdxMsgProto::SendMsgData(*handle, GetReqTypeByComponentType(compType), MsgStatus::MSG_STATUS_LONG_LINK,
        static_cast<IdeSendBuffT>(defaultMessage.c_str()), defaultMessage.size());
    if (err != IDE_DAEMON_OK) {
        IDE_LOGE("Write default info to device failed by hdc, result=%d.", err);
        (void)Adx::HdcSessionDestroy(session);
        (void)Adx::HdcClientDestroy(client);
        handle->session = 0;
        handle->client = nullptr;
        IDE_XFREE_AND_SET_NULL(handle);
    }
    return handle;
}

/**
 * @brief       : check if handle is valid
 * @param [in]  : handle         checked handle
 * @return      : IDE_DAEMON_OK valid; IDE_DAEMON_ERROR invalid
 */
int32_t AdxIsCommHandleValid(AdxCommConHandle handle)
{
    if ((handle == nullptr) || (handle->session == 0)) {
        IDE_LOGE("the handle is invalid");
        return IDE_DAEMON_ERROR;
    }
    return IDE_DAEMON_OK;
}

/**
 * @brief       : destroy and free communication handle
 * @param [in]  : handle         communication handle
 */
void AdxDestroyCommHandle(AdxCommHandle handle)
{
    if (handle != nullptr && handle->session != 0) {
        (void)Adx::HdcSessionDestroy(reinterpret_cast<HDC_SESSION>(handle->session));
        if (handle->client != nullptr) {
            (void)Adx::HdcClientDestroy(handle->client);
        }
        IdeXfree(handle);
    } else {
        IDE_LOGE("Can not destroy invalid handle.");
    }
}

/**
 * @brief       : send message by communication handle
 * @param [in]  : handle         communication handle
 * @param [in]  : data           message data
 * @param [in]  : len            data length
 * @return      : IDE_DAEMON_OK succeed; others failed
 */
int32_t AdxSendMsg(AdxCommConHandle handle, AdxString data, uint32_t len)
{
    if ((handle == nullptr) || (data == nullptr)) {
        return IDE_DAEMON_ERROR;
    }

    std::unique_ptr<AdxCommOpt> opt (CreateAdxCommOpt(handle->type));
    IDE_CTRL_VALUE_FAILED(opt != nullptr, return IDE_DAEMON_ERROR, "create hdc commopt exception");
    bool ret = AdxCommOptManager::Instance().CommOptsRegister(opt);
    IDE_CTRL_VALUE_FAILED(ret, return IDE_DAEMON_ERROR, "register hdc failed");

    return (Adx::AdxMsgProto::SendMsgData(*handle, GetReqTypeByComponentType(handle->comp),
        MsgStatus::MSG_STATUS_NONE_ERROR, static_cast<IdeSendBuffT>(data), len) ==
        IDE_DAEMON_NONE_ERROR) ? IDE_DAEMON_OK : IDE_DAEMON_ERROR;
}

/**
 * @brief          : receive message by communication handle
 * @param [in]     : handle         communication handle
 * @param [out]    : data           message data
 * @param [in|out] : len            data length
 * @param [in]     : timeout        max wait time; unit: ms
 * @return         : IDE_DAEMON_OK succeed; others failed
 */
int32_t AdxRecvMsg(AdxCommHandle handle, IdeStrBufAddrT data, uint32_t *len, uint32_t timeout)
{
    int32_t err = IDE_DAEMON_ERROR;
    if (len == nullptr) {
        IDE_LOGE("receive message failed, invalid length");
        return err;
    }
    if ((handle == nullptr) || (data == nullptr)) {
        *len = 0;
        IDE_LOGE("receive message failed, invalid input.");
        return err;
    }

    handle->timeout = static_cast<int32_t>(timeout);
    std::string value;
    err = AdxMsgProto::GetStringMsgData(*handle, value);
    if (err != IDE_DAEMON_OK) {
        *len = 0;
        return err;
    }
    if (value.empty()) {
        *len = 0;
        return IDE_DAEMON_RECV_NODATA;
    }
    if (*len < value.length()) {
        IDE_LOGE("input length(%u bytes) less than read message length(%zu bytes)", *len, value.length());
        *len = 0;
        return IDE_DAEMON_ERROR;
    }
    err = memcpy_s(*data, *len, value.c_str(), value.length());
    if (err != EOK) {
        IDE_LOGE("memcpy_s failed, result=%d.", err);
        *len = 0;
        return IDE_DAEMON_ERROR;
    }
    *len = value.length();
    return err;
}

static int32_t AdxServerCommProcess(AdxHdcServiceType type, AdxTlvConReq req, AdxStringBuffer result, uint32_t length,
    uint32_t timeout)
{
    if (req == nullptr) {
        IDE_LOGE("invalid input, tlv struct is null");
        return IDE_DAEMON_ERROR;
    }
    if (req->len < 0) {
        IDE_LOGE("invalid input, length of tlv struct is %d bytes", req->len);
        return IDE_DAEMON_ERROR;
    }
    IdeTlvReq ide = static_cast<IdeTlvReq>(IdeXmalloc(sizeof(TlvReqT) + req->len));
    if (ide == nullptr) {
        IDE_LOGE("malloc ide tlv failed, size=%zu bytes", sizeof(TlvReqT) + req->len);
        return IDE_DAEMON_ERROR;
    }
    ide->type = GetReqTypeByComponentType(req->type);
    if (ide->type == NR_IDE_CMD_CLASS) {
        IDE_LOGE("invalid input, component type of tlv struct is %d", static_cast<int32_t>(req->type));
        IDE_XFREE_AND_SET_NULL(ide);
        return IDE_DAEMON_ERROR;
    }
    ide->dev_id = req->devId;
    ide->len = req->len;
    int32_t ret = memcpy_s(ide->value, ide->len, req->value, req->len);
    if (ret != EOK) {
        IDE_LOGE("memcpy_s from cmptype to req failed, result=%d", ret);
        IDE_XFREE_AND_SET_NULL(ide);
        return IDE_DAEMON_ERROR;
    }
    if (result == nullptr) {
        IDE_LOGI("AdxDevCommShortLink, no results needed, cmpt=%d, cmd=%d, devId=%d",
            static_cast<int32_t>(req->type), static_cast<int32_t>(ide->type), ide->dev_id);
        ret = AdxSendMsgAndNoResultByType(type, ide);
    } else {
        IDE_LOGI("AdxDevCommShortLink, result wait timeout:%u, cmpt=%d, cmd=%d, devId=%d", timeout,
            static_cast<int32_t>(req->type), static_cast<int32_t>(ide->type), ide->dev_id);
        (void)memset_s(result, length, 0, length);
        ret = AdxSendMsgToServerByType(type, ide, result, length, static_cast<int32_t>(timeout));
    }
    IDE_XFREE_AND_SET_NULL(ide);
    return ret;
}

/**
 * @brief          : communication with the specific hdc server and get result if needed
 * @param [in]     : type         server type
 * @param [in]     : req          including device id, component type, message data
 * @param [in|out] : result       get result data from device, pass nullptr if result is not needed
 * @param [in]     : length       result data length
 * @param [in]     : timeout      0 : wait_always, > 0 wait_timeout; unit: ms
 * @return         : IDE_DAEMON_OK succeed; others failed
 */
int32_t AdxDevCommShortLink(AdxHdcServiceType type, AdxTlvConReq req, AdxStringBuffer result, uint32_t length,
    uint32_t timeout) {
    int32_t ret = AdxServerCommProcess(type, req, result, length, timeout);
    if ((ret != IDE_DAEMON_OK) && (result != nullptr) && (strlen(result) == 0)) {
        const std::string value = "get result data from server failed";
        int32_t err = strncpy_s(result, length, value.c_str(), value.length());
        if (err != EOK) {
            IDE_LOGE("strncpy_s null result data failed, result: %d.", err);
        }
    }
    return ret;
}