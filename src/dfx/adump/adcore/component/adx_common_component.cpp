/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "adx_common_component.h"
#include "adx_log.h"
#include "extra_config.h"
namespace Adx {
int32_t AdxCommonComponent::Init()
{
    IDE_CTRL_VALUE_WARN(init_ != nullptr, return IDE_DAEMON_ERROR, "common component %d null init",
        static_cast<int32_t>(componentType_));
    return init_();
}

const std::string AdxCommonComponent::GetInfo()
{
    return "Common hdc server process";
}

ComponentType AdxCommonComponent::GetType()
{
    return componentType_;
}

int32_t AdxCommonComponent::Process(const CommHandle &handle, const SharedPtr<MsgProto> &proto)
{
    IDE_CTRL_VALUE_FAILED(process_ != nullptr, return IDE_DAEMON_ERROR, "common component %d process error",
        static_cast<int32_t>(componentType_));
    return process_(&handle, proto.get(), sizeof(MsgProto) + proto->sliceLen);
}

int32_t AdxCommonComponent::UnInit()
{
    IDE_CTRL_VALUE_WARN(uninit_ != nullptr, return IDE_DAEMON_ERROR, "common component %d null uninit",
        static_cast<int32_t>(componentType_));
    return uninit_();
}

void AdxCommonComponent::SetType(ComponentType componentType)
{
    componentType_ = componentType;
}

AdxCommonComponent::~AdxCommonComponent()
{
    init_ = nullptr;
    process_ = nullptr;
    uninit_ = nullptr;
}
}