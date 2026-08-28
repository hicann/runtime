/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_ARCH920X_HPP
#define CCE_RUNTIME_ARCH920X_HPP

#include <array>

#include "soc_define.hpp"

namespace cce {
namespace runtime {

inline const std::array<rtChipType_t, 2U>& GetArch920xChips()
{
    static const std::array<rtChipType_t, 2U> chips = {CHIP_CLOUD_V5, CHIP_CLOUD_V6};
    return chips;
}

inline bool IsArch920xChip(const rtChipType_t chipType)
{
    for (const auto chip : GetArch920xChips()) {
        if (chip == chipType) {
            return true;
        }
    }
    return false;
}

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_ARCH920X_HPP
