/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADX_COMMON_COMMON_COMPONENT_H
#define ADX_COMMON_COMMON_COMPONENT_H
#include "adx_component.h"
namespace Adx {
class AdxCommonComponent : public AdxComponent {
public:
    AdxCommonComponent(AdxComponentInit init, AdxComponentProcess process, AdxComponentUnInit uninit,
        ComponentType componentType) : init_(init), process_(process), uninit_(uninit),
        componentType_(componentType) {}
    ~AdxCommonComponent() override;
    int32_t Init() override;
    const std::string GetInfo() override;
    ComponentType GetType() override;
    int32_t Process(const CommHandle &handle, const SharedPtr<MsgProto> &proto) override;
    int32_t UnInit() override;
    void SetType(ComponentType componentType);
private:
    AdxComponentInit init_;
    AdxComponentProcess process_;
    AdxComponentUnInit uninit_;
    ComponentType componentType_;
};
}
#endif // ADX_COMMON_COMMON_COMPONENT_H