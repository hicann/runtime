/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "david_lite_platform.h"
#include "config/config.h"

namespace Dvvp {
namespace Collect {
namespace Platform {
using namespace analysis::dvvp::common::config;

PLATFORM_REGISTER(CHIP_CLOUD_V3_LITE, DavidLitePlatform);

uint16_t DavidLitePlatform::GetBiuPerfGroupNum() const { return BIU_PERF_LOWER_GROUP_NUM; }

uint16_t DavidLitePlatform::GetCcuDieNum() const { return DAVID_LITE_CCU_DIE_NUM; }
} // namespace Platform
} // namespace Collect
} // namespace Dvvp
