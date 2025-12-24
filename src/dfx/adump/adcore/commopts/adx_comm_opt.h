/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADX_COMMOPT_H
#define ADX_COMMOPT_H
#include <cstdint>
#include <string>
#include <map>
#include "extra_config.h"
#include "device/adx_device.h"
#include "common_utils.h"
#include "adx_service_config.h"
namespace Adx {
constexpr int32_t COMM_OPT_BLOCK = 0;
constexpr int32_t COMM_OPT_NOBLOCK = 1;
constexpr int32_t COMM_OPT_TIMEOUT = 2;
constexpr OptHandle ADX_OPT_INVALID_HANDLE = -1;
const std::string OPT_DEVICE_KEY       = "DeviceId";
const std::string OPT_SERVICE_KEY      = "ServiceType";
const std::string OPT_PID_KEY          = "Pid";

class AdxCommOpt {
public:
    AdxCommOpt() : device_(nullptr) {}
    virtual ~AdxCommOpt() {}
    virtual std::string CommOptName() = 0;
    virtual OptType GetOptType() = 0;
    virtual OptHandle OpenServer(const std::map<std::string, std::string> &info) = 0;
    virtual int32_t CloseServer(const OptHandle &handle) const = 0;
    virtual OptHandle OpenClient(const std::map<std::string, std::string> &info) = 0;
    virtual int32_t CloseClient(OptHandle &handle) const = 0;
    virtual OptHandle Accept(const OptHandle handle) const = 0;
    virtual OptHandle Connect(const OptHandle handle, const std::map<std::string, std::string> &info) = 0;
    virtual int32_t Close(OptHandle &handle) const = 0;
    virtual int32_t Write(const OptHandle handle, IdeSendBuffT buffer, int32_t length, int32_t flag) = 0;
    virtual int32_t Read(const OptHandle handle, IdeRecvBuffT buffer, int32_t &length, int32_t flag) = 0;
    virtual SharedPtr<AdxDevice> GetDevice() = 0;
    virtual void Timer(void) const = 0;
protected:
    SharedPtr<AdxDevice> device_ = nullptr;
};
}
#endif
