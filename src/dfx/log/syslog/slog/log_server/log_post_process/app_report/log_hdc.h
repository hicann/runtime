/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef LOG_HDC_H
#define LOG_HDC_H
#include "adx_component.h"
#include "adx_comm_opt_manager.h"
#include "common_utils.h"
namespace Adx {
using LogNotifyMsg = struct {
    int timeout;
    char data[0];
};

class LogHdc : public AdxComponent {
public:
    ~LogHdc() override {}
    int32_t Init() override;
    const std::string GetInfo() override
    {
        return "Log hdc server process";
    }
    ComponentType GetType() override
    {
        return ComponentType::COMPONENT_LOG_BACKHAUL;
    }
    int32_t Process(const CommHandle &handle,
        const SharedPtr<MsgProto> &proto) override;
    int32_t UnInit() override;
};
}
#endif
