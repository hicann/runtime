/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "sock_comm_opt.h"
#include "sock_api.h"
#include "log/adx_log.h"
#include "adx_sock_device.h"
namespace Adx {
/**
 * @brief      get comm opt name
 *
 * @return
 *      "LOCAL_SOCK"
 */
std::string SockCommOpt::CommOptName()
{
    return "LOCAL_SOCK";
}

/**
 * @brief      get opt type
 *
 * @return
 *      COMM_LOCAL
 */
OptType SockCommOpt::GetOptType()
{
    return OptType::COMM_LOCAL;
}

/**
 * @brief      open server
 * @param [in] info: map of server info
 *
 * @return
 *      handle: opt handle
 *      ADX_OPT_INVALID_HANDLE
 */
OptHandle SockCommOpt::OpenServer(const std::map<std::string, std::string> &info)
{
    OptHandle handle = ADX_OPT_INVALID_HANDLE;
    if (info.empty()) {
        return handle;
    }

    auto it = info.find(OPT_SERVICE_KEY);
    if (it == info.end()) {
        return ADX_OPT_INVALID_HANDLE;
    }
    int32_t fd =  SockServerCreate(it->second);
    if (fd < 0) {
        return handle;
    }

    handle = static_cast<OptHandle>(fd);
    return handle;
}

/**
 * @brief      close server
 * @param [in] handle: opt handle
 *
 * @return
 *      IDE_DAEMON_OK: close and destroy server success
 *      IDE_DAEMON_ERROR: close and destroy server failed
 */
int32_t SockCommOpt::CloseServer(const OptHandle &handle) const
{
    if (handle == ADX_OPT_INVALID_HANDLE) {
        return IDE_DAEMON_ERROR;
    }

    auto fd = static_cast<int32_t>(handle);
    return SockServerDestroy(fd);
}

/**
 * @brief      open client
 * @param [in] info: map of server info
 *
 * @return
 *      fd: opt handle
 */
OptHandle SockCommOpt::OpenClient(const std::map<std::string, std::string> &info)
{
    UNUSED(info);
    int32_t fd = SockClientCreate();
    return static_cast<OptHandle>(fd);
}

/**
 * @brief      close client
 * @param [in] handle: opt handle
 *
 * @return
 *      IDE_DAEMON_OK: close and destroy client success
 *      IDE_DAEMON_ERROR: close and destroy client failed
 */
int32_t SockCommOpt::CloseClient(OptHandle &handle) const
{
    if (handle == ADX_OPT_INVALID_HANDLE) {
        return IDE_DAEMON_ERROR;
    }

    auto fd = static_cast<int32_t>(handle);
    int32_t ret = SockClientDestory(fd);
    handle = ADX_OPT_INVALID_HANDLE;
    return ret;
}

/**
 * @brief      call sock accept
 * @param [in] handle: opt handle
 *
 * @return
 *      clientFd
 */
OptHandle SockCommOpt::Accept(const OptHandle handle) const
{
    if (handle == ADX_OPT_INVALID_HANDLE) {
        return ADX_OPT_INVALID_HANDLE;
    }

    IDE_LOGI("server %d in accept", static_cast<int32_t>(handle));
    int32_t fd = SockAccept(handle);
    if (fd < 0) {
        return ADX_OPT_INVALID_HANDLE;
    }
    IDE_LOGI("client %d", fd);
    return static_cast<OptHandle>(fd);
}

/**
 * @brief      sock connect
 * @param [in] handle: opt handle
 * @param [in] info: map of server info
 *
 * @return
 *      fd: opt handle
 *      ADX_OPT_INVALID_HANDLE
 */
OptHandle SockCommOpt::Connect(const OptHandle handle, const std::map<std::string, std::string> &info)
{
    if (handle == ADX_OPT_INVALID_HANDLE) {
        return ADX_OPT_INVALID_HANDLE;
    }

    auto it = info.find(OPT_SERVICE_KEY);
    if (it == info.end()) {
        return ADX_OPT_INVALID_HANDLE;
    }
    int32_t fd = SockConnect(handle, it->second);
    if (fd < 0) {
        return ADX_OPT_INVALID_HANDLE;
    }

    return static_cast<OptHandle>(fd);
}

/**
 * @brief      sock close
 * @param [in] handle: opt handle
 *
 * @return
 *      IDE_DAEMON_OK: close success
 *      IDE_DAEMON_ERROR: close failed
 */
int32_t SockCommOpt::Close(OptHandle &handle) const
{
    if (handle == ADX_OPT_INVALID_HANDLE) {
        return IDE_DAEMON_ERROR;
    }

    auto fd = static_cast<int32_t>(handle);
    handle = ADX_OPT_INVALID_HANDLE;
    return SockClose(fd);
}

/**
 * @brief      sock write
 * @param [in] handle: opt handle
 * @param [in] buffer: write buffer
 * @param [in] length: write length
 * @param [in] flag: write flag
 *
 * @return
 *      IDE_DAEMON_OK: sock write success
 *      IDE_DAEMON_ERROR: sock write failed
 */
int32_t SockCommOpt::Write(const OptHandle handle, IdeSendBuffT buffer, int32_t length, int32_t flag)
{
    IDE_CTRL_VALUE_FAILED(handle != ADX_OPT_INVALID_HANDLE, return IDE_DAEMON_ERROR,
        "sock write input invalid");
    IDE_CTRL_VALUE_FAILED(buffer != nullptr, return IDE_DAEMON_ERROR, "sock write input invalid");
    IDE_CTRL_VALUE_FAILED(length > 0, return IDE_DAEMON_ERROR, "sock write input invalid");

    return SockWrite(handle, buffer, length, flag);
}

/**
 * @brief      sock read
 * @param [in] handle: opt handle
 * @param [in] buffer: read buffer
 * @param [in] length: receive length
 * @param [in] flag: read flag
 *
 * @return
 *      IDE_DAEMON_OK: sock read success
 *      IDE_DAEMON_ERROR: sock read failed
 */
int32_t SockCommOpt::Read(const OptHandle handle, IdeRecvBuffT buffer, int32_t &length, int32_t /* flag */)
{
    IDE_CTRL_VALUE_FAILED(handle != ADX_OPT_INVALID_HANDLE, return IDE_DAEMON_ERROR,
        "sock write input invalid");
    IDE_CTRL_VALUE_FAILED(buffer != nullptr, return IDE_DAEMON_ERROR, "sock write input invalid");

    int32_t nonBlockFlag = 0;
    return SockRead(handle, buffer, &length, nonBlockFlag);
}

SharedPtr<AdxDevice> SockCommOpt::GetDevice()
{
    if (device_ == nullptr) {
        try {
            device_ = std::make_shared<AdxSockDevice>();
        } catch (...) {
            return nullptr;
        }
    }

    return device_;
}

void SockCommOpt::Timer(void) const
{
}
}