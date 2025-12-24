/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef BFLOAT16_H
#define BFLOAT16_H

#include "hifloat.h"

namespace cce {
namespace runtime {
constexpr int32_t BF16_EXPONENT_BIAS = 127U;

class BFloat16 final {
public:
    explicit BFloat16(uint16_t v = 0) : val(v) {}

    float GetValue() const {
        if (val == 0xFF80) {
            return -std::numeric_limits<float>::infinity();
        } else if (val == 0x7F80) {
            return std::numeric_limits<float>::infinity();
        } else {
            int32_t symbol = val >= 0x8000 ? -1 : 1;
            int32_t exponentVal = (val % 0x8000 / 0x0080);
            float mantissaVal = (val % 0x8000 % 0x0080) / static_cast<float>(0x0080);
            if ((exponentVal == 0xFF) && (mantissaVal > 0)) {
                return std::numeric_limits<float>::quiet_NaN();
            }
            float value = 0.0;
            if (exponentVal == 0) {
                value = static_cast<float>(symbol * pow(BASE_NUM, 1 - BF16_EXPONENT_BIAS) * mantissaVal);
            } else {
                value = static_cast<float>(symbol * pow(BASE_NUM, exponentVal - BF16_EXPONENT_BIAS) * (mantissaVal + 1));
            }
            return value;
        }
    }

private:
    uint16_t val;
};
} // runtime
} // cce

#endif // BFLOAT16_H
