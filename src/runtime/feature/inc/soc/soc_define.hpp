/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_SOC_DEFINE_HPP
#define CCE_RUNTIME_SOC_DEFINE_HPP

#include <cstdint>

namespace cce {
namespace runtime {

enum rtSocType_t : std::uint8_t {
    SOC_BEGIN = 0,
    SOC_ASCEND910B1,
    SOC_ASCEND910B2,
    SOC_ASCEND910B3,
    SOC_ASCEND910B4,
    SOC_ASCEND910B2C,
    SOC_ASCEND910B4_1,
    SOC_KIRINX90,
    SOC_KIRIN9030,
    SOC_END,
};

}
}
#endif // CCE_RUNTIME_SOC_DEFINE_HPP
