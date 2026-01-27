/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "hdc_comm_opt.h"
#include "hdc_api.h"
#include "device/adx_dsmi.h"
#include "log/adx_log.h"
#include "device/adx_hdc_device.h"
#include "mmpa_api.h"
namespace Adx {
std::string HdcCommOpt::CommOptName()
{
    return "HDC";
}

OptType HdcCommOpt::GetOptType()
{
    return OptType::COMM_HDC;
}

OptHandle HdcCommOpt::OpenServer(const std::map<std::string, std::string> &info)
{
    if (info.empty() || info.size() < 1) {
        IDE_LOGE("open server input invalid");
        return ADX_OPT_INVALID_HANDLE;
    }

    int32_t devId;
    drvHdcServiceType type;
    try {
        auto device = info.find(OPT_DEVICE_KEY);
        if (device == info.end()) {
            IDE_LOGE("open server input parameter invalid, DeviceId not found.");
            return ADX_OPT_INVALID_HANDLE;
        }

        auto service = info.find(OPT_SERVICE_KEY);
        if (service == info.end()) {
            IDE_LOGE("open server input parameter invalid, ServiceType not found");
            return ADX_OPT_INVALID_HANDLE;
        }
        devId = std::stoi(device->second);                     // device id
        type = (drvHdcServiceType)std::stoi(service->second);  // service type
    } catch (...) {
        IDE_LOGE("Value of device id or service type is not a number");
        return ADX_OPT_INVALID_HANDLE;
    }

    if (type >= HDC_SERVICE_TYPE_MAX || devId < 0) {
        return ADX_OPT_INVALID_HANDLE;
    }

    IDE_RUN_LOGI("open device[%d] server[%d]", devId, type);
    HDC_SERVER server = HdcServerCreate(devId, type);
    if (server == nullptr) {
        return ADX_OPT_INVALID_HANDLE;
    }

    return (OptHandle)server;
}

int32_t HdcCommOpt::CloseServer(const OptHandle &handle) const
{
    if (handle == ADX_OPT_INVALID_HANDLE) {
        IDE_LOGE("close server input invalid");
        return IDE_DAEMON_ERROR;
    }

    IDE_RUN_LOGI("close device server[%u]",  static_cast<uint32_t>(handle));
    return HdcServerDestroy(reinterpret_cast<HDC_SERVER>(handle));
}

OptHandle HdcCommOpt::OpenClient(const std::map<std::string, std::string> &info)
{
    if (info.empty() || info.size() == 0) {
        IDE_LOGE("open client input invalid");
        return ADX_OPT_INVALID_HANDLE;
    }

    drvHdcServiceType type;
    try {
        auto service = info.find(OPT_SERVICE_KEY);
        if (service == info.end()) {
            IDE_LOGE("open client input parameter invalid, ServiceType not found");
            return ADX_OPT_INVALID_HANDLE;
        }
        type = (drvHdcServiceType)std::stoi(service->second);  // service type
    } catch (...) {
        IDE_LOGE("Value of service type is not a number");
        return ADX_OPT_INVALID_HANDLE;
    }

    if (type >= HDC_SERVICE_TYPE_MAX) {
        IDE_LOGE("open client input type out of range");
        return ADX_OPT_INVALID_HANDLE;
    }

    HDC_CLIENT session = HdcClientCreate(type);
    if (session == nullptr) {
        IDE_LOGE("hdc client create exception");
        return ADX_OPT_INVALID_HANDLE;
    }

    return (OptHandle)session;
}

int32_t HdcCommOpt::CloseClient(OptHandle &handle) const
{
    IDE_CTRL_VALUE_FAILED(handle != ADX_OPT_INVALID_HANDLE, return IDE_DAEMON_ERROR,
        "hdc close client input invalid");
    return HdcClientDestroy((HDC_CLIENT)handle);
}

OptHandle HdcCommOpt::Accept(const OptHandle handle) const
{
    IDE_CTRL_VALUE_FAILED(handle != ADX_OPT_INVALID_HANDLE, return ADX_OPT_INVALID_HANDLE,
        "hdc accept input invalid");
    HDC_SESSION session = HdcServerAccept((HDC_SERVER)handle);
    if (session == nullptr) {
        return ADX_OPT_INVALID_HANDLE;
    }

    return (OptHandle)session;
}

OptHandle HdcCommOpt::Connect(const OptHandle handle, const std::map<std::string, std::string> &info)
{
    IDE_CTRL_VALUE_FAILED(handle != ADX_OPT_INVALID_HANDLE, return ADX_OPT_INVALID_HANDLE,
        "hdc connect input invalid");
    IDE_CTRL_VALUE_FAILED(!info.empty(), return ADX_OPT_INVALID_HANDLE,
        "hdc connect input invalid");

    int32_t devId;
    auto device = info.find(OPT_DEVICE_KEY);
    if (device == info.end()) {
        IDE_LOGE("connect input parameter invalid, DeviceId not found");
        return ADX_OPT_INVALID_HANDLE;
    }
    try {
        devId = std::stoi(device->second);
    } catch (...) {
        IDE_LOGE("Value of device id is not a number");
        return ADX_OPT_INVALID_HANDLE;
    }
    IDE_CTRL_VALUE_FAILED(devId >= 0 && devId < DEVICE_NUM_MAX,
        return ADX_OPT_INVALID_HANDLE, "devId invalid");
    HDC_SESSION session = nullptr;
    int32_t err;
    try {
        auto host = info.find(OPT_PID_KEY);
        if (host == info.end()) {
            err = HdcSessionConnect(0, devId, (HDC_CLIENT)handle, &session);
        } else {
            int32_t hostPid = std::stoi(host->second);
            if (hostPid < 0) {
                return ADX_OPT_INVALID_HANDLE;
            }
            err = HalHdcSessionConnect(0, devId, hostPid, (HDC_CLIENT)handle, &session);
        }
    } catch (...) {
        IDE_LOGE("Value of host pid is not a number");
        return ADX_OPT_INVALID_HANDLE;
    }

    if (err != IDE_DAEMON_OK) {
        IDE_LOGE("hdc connect error: %d", err);
        return ADX_OPT_INVALID_HANDLE;
    }

    return (OptHandle)session;
}

int32_t HdcCommOpt::Close(OptHandle &handle) const
{
    IDE_CTRL_VALUE_WARN(handle != ADX_OPT_INVALID_HANDLE, return IDE_DAEMON_OK,
        "hdc handle is invalid. maybe has been closed or not connected");

    HDC_SESSION session = (HDC_SESSION)handle;
    int32_t ret = HdcSessionClose(session);
    session = nullptr;
    handle = ADX_OPT_INVALID_HANDLE;
    return ret;
}

int32_t HdcCommOpt::Write(const OptHandle handle, IdeSendBuffT buffer, int32_t length, int32_t flag)
{
    IDE_CTRL_VALUE_FAILED(handle != ADX_OPT_INVALID_HANDLE, return IDE_DAEMON_ERROR,
        "hdc write input invalid");
    IDE_CTRL_VALUE_FAILED(buffer != nullptr, return IDE_DAEMON_ERROR, "hdc write input invalid");
    IDE_CTRL_VALUE_FAILED(length > 0, return IDE_DAEMON_ERROR, "hdc write input invalid");

    if (flag == COMM_OPT_BLOCK) {
        return HdcWrite((HDC_SESSION)handle, buffer, length);
    }

    return HdcWriteNb((HDC_SESSION)handle, buffer, length);
}

int32_t HdcCommOpt::Read(const OptHandle handle, IdeRecvBuffT buffer, int32_t &length, int32_t flag)
{
    IDE_CTRL_VALUE_FAILED(handle != ADX_OPT_INVALID_HANDLE, return IDE_DAEMON_ERROR,
        "hdc read input invalid");
    IDE_CTRL_VALUE_FAILED(buffer != nullptr, return IDE_DAEMON_ERROR, "hdc read input invalid");

    if (flag == COMM_OPT_BLOCK) {
        return HdcRead(reinterpret_cast<HDC_SESSION>(handle), buffer, &length);
    }

    if (flag != COMM_OPT_NOBLOCK) {
        return HdcReadTimeout(reinterpret_cast<HDC_SESSION>(handle), static_cast<uint32_t>(flag), buffer, &length);
    }

    // 在投片验证阶段FPGA场景下，因hdc传输性能较差，需将maxRetryTimes设置为800，保证通过hdc接收数据成功
    // 在常规场景下，当hdc对端未能成功发送数据时，若maxRetryTimes设置为800，等待时间过长会影响用户体验，需修改为142
    const int32_t maxRetryTimes = 142; // 10s (1 + 2 + ... + 142)ms;
    int32_t err;
    int32_t retryTime = 1;
    while (retryTime < maxRetryTimes) {
        err = HdcReadNb(reinterpret_cast<HDC_SESSION>(handle), buffer, &length);
        if (err == IDE_DAEMON_RECV_NODATA) {
            mmSleep(retryTime);
            retryTime++;
        } else {
            break;
        }
    }

    if (retryTime >= maxRetryTimes) {
        IDE_LOGW("no received request in %d times", retryTime);
        err = IDE_DAEMON_ERROR;
    }
    return err;
}

SharedPtr<AdxDevice> HdcCommOpt::GetDevice()
{
    if (device_ == nullptr) {
        try {
            device_ = std::make_shared<AdxHdcDevice>();
        } catch (...) {
            IDE_LOGE("Failed to get hdc device.");
            return nullptr;
        }
    }

    return device_;
}

void HdcCommOpt::Timer(void) const
{
}
}
