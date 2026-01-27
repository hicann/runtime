/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "base.hpp"
#include "dev_info_manage.h"

namespace cce {
namespace runtime {

REGISTER_PLATFORM_LIB_INFO(CHIP_XPU, "libruntime_v200.so");

const std::unordered_set<RtOptionalFeatureType> CHIP_XPU_FEATURE{
    RtOptionalFeatureType::RT_FEATURE_XPU};
REGISTER_CHIP_FEATURE_SET(CHIP_XPU, CHIP_XPU_FEATURE);
}
}
