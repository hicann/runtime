/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ADUMP_TINY_CHIP

#include <bitset>
#include <limits>
#include <unordered_map>
#include "base.hpp"
#include "hifloat.h"

namespace cce {
namespace runtime {
constexpr int32_t FP8E8M0_EXPONENT_BIAS = 127U;
constexpr size_t ONE_BYTE_BIT_NUM = 8U;
constexpr uint32_t FP8E5M2_EXPONENT_BIT_NUM = 5U;
constexpr uint32_t FP8E4M3_EXPONENT_BIT_NUM = 4U;
constexpr int32_t HIFLOAT8_SUBNORMAL_NUM = 23;

static std::unordered_map<std::string, float> g_adxMantissaMapB2f = {
    {"000", 0}, {"001", 0.125}, {"010", 0.25}, {"011", 0.375}, {"100", 0.5},
    {"101", 0.625}, {"110", 0.75}, {"111", 0.875}, {"00", 0}, {"01", 0.25},
    {"10", 0.5}, {"11", 0.75}, {"0", 0}, {"1", 0.5}
};

static std::unordered_map<std::string, float> g_adxPresetEncoedsMap = {
    {"00000000", 0}, {"10000000", std::numeric_limits<float>::quiet_NaN()},
    {"01101111", std::numeric_limits<float>::infinity()}, {"11101111", -std::numeric_limits<float>::infinity()}
};

static std::unordered_map<std::string, uint32_t> g_adxConventionalMap = {
    {"11", 4}, {"10", 3}, {"01", 2}, {"001", 1}, {"0001", 0}, {"0000", 0}
};

static inline std::string ByteToBinary(const uint8_t byte) {
    return std::bitset<ONE_BYTE_BIT_NUM>(byte).to_string();
}

int32_t HiFloat8::GetExponent(const std::string &binary) const
{
    if (binary.length() == 0) {
        return 0;
    }
    int32_t symbol = binary.substr(0, 1) == "0" ? 1 : -1;
    std::string revisedBinary = "1" + binary.substr(1);
    return symbol * std::stoi(revisedBinary, nullptr, BASE_NUM);
}

float HiFloat8::GetMantissaField(const std::string &binary) const
{
    return std::stoi(binary, nullptr, BASE_NUM) / static_cast<float>(pow(BASE_NUM, binary.length()));
}

float HiFloat8::GetValue() const
{
    std::string bitString = ByteToBinary(val);
    float value = 0.0;
    if (g_adxPresetEncoedsMap.find(bitString) != g_adxPresetEncoedsMap.end()) {
        value = g_adxPresetEncoedsMap[bitString];
        return value;
    }
    if (bitString.length() == ONE_BYTE_BIT_NUM) {
        std::string symbolBit = bitString.substr(0, 1);
        int32_t signVal = symbolBit == "0" ? 1 : -1;
        std::string dotField;
        uint32_t dotVal = 0;
        for (const auto& pair : g_adxConventionalMap) {
            const std::string &dot = pair.first;
            if (bitString.substr(1).find(dot) == 0) {
                dotField = dot;
                dotVal = pair.second;
                break;
            }
        }
        if (dotField.empty()) {
            RT_LOG(RT_LOG_INFO, "No dot field was found.");
            return std::numeric_limits<float>::max();
        }
        if (dotField == "0000") {
            std::string mantissaBit = bitString.substr(1 + dotField.length());
            int32_t mantissaVal = std::stoi(mantissaBit, nullptr, BASE_NUM);
            value = signVal * static_cast<float>(pow(BASE_NUM, mantissaVal - HIFLOAT8_SUBNORMAL_NUM));
            return value;
        }
        int32_t exponentField = GetExponent(bitString.substr(1 + dotField.length(), dotVal));
        float mantissaField = GetMantissaField(bitString.substr(1 +  dotField.length() + dotVal));
        value = signVal * static_cast<float>(pow(BASE_NUM, exponentField) * (1 + mantissaField));
    }
    return value;
}

float FpaEbMc::Decode(const std::string &bitString, const std::string &exponentBit, const std::string &mantissaBit,
        const uint32_t exponentBitNum) const
{
    int32_t exponentBias = (1 << (exponentBitNum - 1)) - 1;
    int32_t signVal = std::stoi(bitString.substr(0, 1), nullptr, BASE_NUM);
    int32_t exponentVal = std::stoi(exponentBit, nullptr, BASE_NUM);
    bool isNormal = exponentVal == 0U ? false : true;
    float value = 0.0;
    if (isNormal) {
        value = static_cast<float>(
            pow(-1, signVal) * pow(BASE_NUM, exponentVal - exponentBias) * (1 + g_adxMantissaMapB2f[mantissaBit]));
    } else {
        value = static_cast<float>(
            pow(-1, signVal) * pow(BASE_NUM, exponentVal - exponentBias + 1) * g_adxMantissaMapB2f[mantissaBit]);
    }
    return value;
}

float Fp8E5M2::GetValue() const
{
    std::string bitString = ByteToBinary(val);
    std::string exponentBit = bitString.substr(1, FP8E5M2_EXPONENT_BIT_NUM);
    std::string mantissaBit = bitString.substr(1 + FP8E5M2_EXPONENT_BIT_NUM);
    if (exponentBit == "11111" && mantissaBit == "00") {
        return static_cast<float>(pow(-1, std::stoi(bitString.substr(0, 1), nullptr, BASE_NUM))) *
               std::numeric_limits<float>::infinity();
    } else if (exponentBit == "11111") {
        return std::numeric_limits<float>::quiet_NaN();
    }
    return Decode(bitString, exponentBit, mantissaBit, FP8E5M2_EXPONENT_BIT_NUM);
}

float Fp8E4M3::GetValue() const
{
    std::string bitString = ByteToBinary(val);
    std::string exponentBit = bitString.substr(1, FP8E4M3_EXPONENT_BIT_NUM);
    std::string mantissaBit = bitString.substr(1 + FP8E4M3_EXPONENT_BIT_NUM);
    if (exponentBit == "1111" && mantissaBit == "111") {
        return std::numeric_limits<float>::quiet_NaN();
    }
    return Decode(bitString, exponentBit, mantissaBit, FP8E4M3_EXPONENT_BIT_NUM);
}

float Fp8E8M0::GetValue() const
{
    std::string bitString = ByteToBinary(val);
    float value = 0.0;
    std::string exponentBit = bitString.substr(0, ONE_BYTE_BIT_NUM);
    if (exponentBit == "11111111") {
        value = std::numeric_limits<float>::quiet_NaN();
        return value;
    }
    // exponentBit为空时stoi会抛异常，可以保证exponentBit不会为空
    int32_t exponentVal = std::stoi(exponentBit, nullptr, BASE_NUM);
    value = static_cast<float>(pow(BASE_NUM, exponentVal - FP8E8M0_EXPONENT_BIAS));
    return value;
}
} // namespace runtime
} // cce
#endif