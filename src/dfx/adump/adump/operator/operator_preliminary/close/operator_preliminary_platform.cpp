/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "operator_preliminary.h"

#include <map>

namespace Adx {
constexpr uint32_t OP_STACK_310P = 2;       // 310P上rts约定算子执行栈
constexpr uint32_t BLOCK_MIN_SIZE = 32;     // 最小搬运单元
constexpr uint32_t OP_STACK_910B = 75;      // 910B上核数 25 + 50
constexpr uint32_t OP_STACK_910_95 = 108;   // DavidV100上核数 36 + 72
constexpr uint32_t INTEGER_KILOBYTE = 1024; // 表示1KB

static const std::map<PlatformType, uint64_t> STACK_SIZE_MAP = {
    {PlatformType::CHIP_DC_TYPE,  OP_STACK_310P * BLOCK_MIN_SIZE * INTEGER_KILOBYTE},
    {PlatformType::CHIP_CLOUD_V2, OP_STACK_910B * BLOCK_MIN_SIZE * INTEGER_KILOBYTE},
    {PlatformType::CHIP_CLOUD_V4, OP_STACK_910_95 * BLOCK_MIN_SIZE * INTEGER_KILOBYTE}
};

const std::map<PlatformType, std::string> BIN_NAME_MAP = {
    {PlatformType::CHIP_DC_TYPE,  "kfc_dump_stat_ascend310p3.o"},
    {PlatformType::CHIP_CLOUD_V2, "kfc_dump_stat_ascend910B.o"},
    {PlatformType::CHIP_CLOUD_V4, "kfc_dump_stat_ascend910_95.o"}
};

uint64_t OperatorPreliminary::CalcStackSize() const
{
    auto it = STACK_SIZE_MAP.find(setting_.GetPlatformType());
    if (it != STACK_SIZE_MAP.cend()) {
        return it->second;
    }
    return 0;
}
} // namespace Adx
