/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DVVP_TEST_STUB_PLATFORM_RC_PLATFORM_STUB_H
#define DVVP_TEST_STUB_PLATFORM_RC_PLATFORM_STUB_H
#include "platform_interface.h"

namespace Dvvp {
namespace Collect {
namespace Platform {
// RC形态桩平台类：能力与扩展仓对应平台实现对齐，数值注册chip id 2
class RcPlatformStub : public PlatformInterface {
public:
    RcPlatformStub();
    ~RcPlatformStub() override {}
    std::string GetDeviceOscDefaultFreq() override;
    std::string GetAicDefaultFreq() override;
    std::vector<std::string> GetHiddenCliArgs() const override;

protected:
    std::string GetL2CacheEvents() override;
};
} // namespace Platform
} // namespace Collect
} // namespace Dvvp
#endif
