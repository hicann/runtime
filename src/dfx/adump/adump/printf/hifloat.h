/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef HIFLOAT_H
#define HIFLOAT_H

#include <cmath>
#include <string>
#include <cstdint>

namespace Adx {
constexpr int32_t BASE_NUM = 2;

class HiFloat8 {
public:
    explicit HiFloat8(uint8_t v = 0) : val(v) {}
    int32_t GetExponent(const std::string &binary) const;
    float GetMantissaField(const std::string &binary) const;
    float GetValue() const;

private:
    uint8_t val;
};

class FpaEbMc {
public:
    explicit FpaEbMc(uint8_t v = 0) : val(v) {}
    float Decode(const std::string &bitString, const std::string &exponentBit, const std::string &mantissaBit,
        const uint32_t exponentBitNum) const;

protected:
    uint8_t val;
};

class Fp8E5M2 : public FpaEbMc {
public:
    explicit Fp8E5M2(uint8_t v = 0) : FpaEbMc(v) {}
    float GetValue() const;
};

class Fp8E4M3 : public FpaEbMc {
public:
    explicit Fp8E4M3(uint8_t v = 0) : FpaEbMc(v) {}
    float GetValue() const;
};

class Fp8E8M0 {
public:
    explicit Fp8E8M0(uint8_t v = 0) : val(v) {}
    float GetValue() const;

private:
    uint8_t val;
};

}; // namespace
 
#endif