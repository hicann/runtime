/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADX_COMMON_COMMOPT_MANAGER_H
#define ADX_COMMON_COMMOPT_MANAGER_H
#include <memory>
#include <mutex>
#include <map>
#include "adx_comm_opt.h"
#include "common/singleton.h"
#include "common/common_utils.h"
#include "adx_service_config.h"
#include "device/adx_device.h"
#include "extra_config.h"
namespace Adx {
#define ADX_COMMOPT_INVALID_HANDLE(type) {(type), ADX_OPT_INVALID_HANDLE, NR_COMPONENTS, -1, nullptr}

class AdxCommOptManager : public Adx::Common::Singleton::Singleton<AdxCommOptManager> {
public:
    ~AdxCommOptManager();
    bool CommOptsRegister(std::unique_ptr<AdxCommOpt> &opt);
    CommHandle OpenServer(OptType type, const std::map<std::string, std::string> &info);
    int32_t CloseServer(const CommHandle &handle) const;
    CommHandle OpenClient(OptType type, const std::map<std::string, std::string> &info);
    int32_t CloseClient(CommHandle &handle) const;
    CommHandle Accept(const CommHandle &handle) const;
    CommHandle Connect(const CommHandle &handle, const std::map<std::string, std::string> &info);
    int32_t Close(CommHandle &handle) const;
    int32_t Write(const CommHandle &handle, IdeSendBuffT buffer, int32_t length, int32_t flag);
    int32_t Read(const CommHandle &handle, IdeRecvBuffT buffer, int32_t &length, int32_t flag);
    SharedPtr<AdxDevice> GetDevice(OptType type);
    void Timer(OptType type) const;
private:
    std::map<OptType, std::shared_ptr<AdxCommOpt>> commOptMap_;
    mutable std::mutex commOptMapMtx_;
};
}
#endif