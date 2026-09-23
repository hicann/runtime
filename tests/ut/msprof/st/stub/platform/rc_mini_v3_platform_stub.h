/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DVVP_TEST_STUB_PLATFORM_RC_MINI_V3_PLATFORM_STUB_H
#define DVVP_TEST_STUB_PLATFORM_RC_MINI_V3_PLATFORM_STUB_H
#include "mini_v3_platform.h"

namespace Dvvp {
namespace Collect {
namespace Platform {
// RC mini v3形态桩平台类：基于MiniV3平台裁剪，数值注册chip id 11
class RcMiniV3PlatformStub : public MiniV3Platform {
public:
    RcMiniV3PlatformStub();
    ~RcMiniV3PlatformStub() override {}
    std::string GetDeviceOscDefaultFreq() override;
    std::string GetAicDefaultFreq() override;
    std::vector<std::string> GetHiddenCliArgs() const override;
};
} // namespace Platform
} // namespace Collect
} // namespace Dvvp
#endif
