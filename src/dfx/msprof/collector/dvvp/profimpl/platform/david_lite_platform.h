/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DVVP_COLLECT_PLATFORM_DAVID_LITE_PLATFORM_H
#define DVVP_COLLECT_PLATFORM_DAVID_LITE_PLATFORM_H

#include "david_platform.h"

namespace Dvvp {
namespace Collect {
namespace Platform {
class DavidLitePlatform : public DavidPlatform {
public:
    uint16_t GetBiuPerfGroupNum() const override;
    uint16_t GetCcuDieNum() const override;
};
} // namespace Platform
} // namespace Collect
} // namespace Dvvp

#endif
