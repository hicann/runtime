/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ADX_SOCK_COMMOPT_H
#define ADX_SOCK_COMMOPT_H
#include "adx_comm_opt.h"
namespace Adx {
class SockCommOpt : public AdxCommOpt {
public:
    SockCommOpt() {}
    ~SockCommOpt() override {}
    std::string CommOptName() override;
    OptType GetOptType() override;
    OptHandle OpenServer(const std::map<std::string, std::string> &info) override;
    int32_t CloseServer(const OptHandle &handle) const override;
    OptHandle OpenClient(const std::map<std::string, std::string> &info) override;
    int32_t CloseClient(OptHandle &handle) const override;
    OptHandle Accept(const OptHandle handle) const override;
    OptHandle Connect(const OptHandle handle, const std::map<std::string, std::string> &info) override;
    int32_t Close(OptHandle &handle) const override;
    int32_t Write(const  OptHandle handle, IdeSendBuffT buffer, int32_t length, int32_t flag) override;
    int32_t Read(const OptHandle handle, IdeRecvBuffT buffer, int32_t &length, int32_t flag) override;
    SharedPtr<AdxDevice> GetDevice() override;
    void Timer(void) const override;
};
}
#endif
