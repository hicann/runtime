/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef OP_API_OP_API_COMMON_INC_OPDEV_INTERNAL_TYPE_UTILS_H
#define OP_API_OP_API_COMMON_INC_OPDEV_INTERNAL_TYPE_UTILS_H

#include "opdev/fp16_t.h"

namespace op::internal {

template<typename T>
struct ScalarValueType {
    using type = T;
};

template<typename T>
struct ScalarValueType<std::complex<T>> {
    using type = T;
};

template<typename T>
struct IsComplex : public std::false_type {};

template<typename T>
struct IsComplex<std::complex<T>> : public std::true_type {};

template<typename Limit, typename T>
inline constexpr bool GreaterThanMax(const T &x)
{
    constexpr bool canOverflow = std::numeric_limits<T>::digits > std::numeric_limits<Limit>::digits;
    if constexpr (canOverflow) {
        return x > std::numeric_limits<Limit>::max();
    }
    return false;
}

template<typename T>
inline constexpr bool IsNegative(
    [[maybe_unused]] const T &x,
    [[maybe_unused]] std::true_type isUnsigned)
{
    return false;
}

template<typename T>
inline constexpr bool IsNegative(
    [[maybe_unused]] const T &x,
    [[maybe_unused]] std::false_type isUnsigned)
{
    return x < T(0);
}

template<typename T>
inline constexpr bool IsNegative(const T &x)
{
    return IsNegative(x, std::is_unsigned<T>());
}

template<typename Limit, typename T>
inline constexpr bool LessThanLowest(
    const T &x,
    [[maybe_unused]] std::false_type limitIsUnsigned,
    [[maybe_unused]] std::false_type xIsUnsigned)
{
    return x < std::numeric_limits<Limit>::lowest();
}

template<typename Limit, typename T>
inline constexpr bool LessThanLowest(
    [[maybe_unused]] const T &x,
    [[maybe_unused]] std::false_type limitIsUnsigned,
    [[maybe_unused]] std::true_type xIsUnsigned)
{
    return false;
}

template<typename Limit, typename T>
inline constexpr bool LessThanLowest(
    const T &x,
    [[maybe_unused]] std::true_type limitIsUnsigned,
    [[maybe_unused]] std::false_type xIsUnsigned)
{
    return x < T(0);
}

template<typename Limit, typename T>
inline constexpr bool LessThanLowest(
    [[maybe_unused]] const T &x,
    [[maybe_unused]] std::true_type limitIsUnsigned,
    [[maybe_unused]] std::true_type xIsUnsigned)
{
    return false;
}

template<typename Limit, typename T>
inline constexpr bool LessThanLowest(const T &x)
{
    return LessThanLowest<Limit>(x, std::is_unsigned<Limit>(), std::is_unsigned<T>());
}

template<typename To, typename From>
typename std::enable_if<std::is_same<From, bool>::value, bool>::type Overflows([[maybe_unused]] From f)
{
    return false;
}

template<typename To, typename From>
typename std::enable_if<std::is_integral<From>::value && !std::is_same<From, bool>::value, bool>::type Overflows(From f)
{
    using limit = std::numeric_limits<typename ScalarValueType<To>::type>;
    if (!limit::is_signed && std::numeric_limits<From>::is_signed) {
        return GreaterThanMax<To, From>(f) || (IsNegative(f) && -static_cast<uint64_t>(f) > limit::max());
    } else {
        return LessThanLowest<To>(f) || GreaterThanMax<To>(f);
    }
}

template<typename To, typename From>
typename std::enable_if<std::is_floating_point<From>::value, bool>::type Overflows(From f)
{
    using limit = std::numeric_limits<typename ScalarValueType<To>::type>;
    if (limit::has_infinity && std::isinf(static_cast<double>(f))) {
        return false;
    }
    if (!limit::has_quiet_NaN && std::isnan(f)) {
        return true;
    }
    return f < static_cast<From>(limit::lowest()) || f > static_cast<From>(limit::max());
}

template<typename To, typename From>
typename std::enable_if<std::is_same<op::fp16_t, typename std::decay<From>::type>::value, bool>::type
Overflows(From f)
{
    if (std::isinf(static_cast<double>(f))) {
        return false;
    }

    return f < FP16_MIN || f > FP16_MAX;
}

template<typename To, typename From>
typename std::enable_if<IsComplex<From>::value, bool>::type Overflows(From f)
{
    if (!IsComplex<To>::value && std::abs(f.imag()) >= std::numeric_limits<decltype(f.imag())>::epsilon()) {
        return true;
    }

    return Overflows<
        typename ScalarValueType<To>::type,
        typename From::value_type>(f.real())
        || Overflows<typename ScalarValueType<To>::type, typename From::value_type>(f.imag());
}
} //  namespace op::internal

namespace std {

template<>
class numeric_limits<op::fp16_t> {
public:
    static constexpr bool is_specialized = true;
    static constexpr bool is_signed = true;
    static constexpr bool is_integer = false;
    static constexpr bool is_exact = false;
    static constexpr bool has_infinity = true;
    static constexpr bool has_quiet_NaN = true;
    static constexpr bool has_signaling_NaN = true;
    static constexpr auto has_denorm = numeric_limits<float>::has_denorm;
    static constexpr auto has_denorm_loss = numeric_limits<float>::has_denorm_loss;
    static constexpr auto round_style = numeric_limits<float>::round_style;
    static constexpr bool is_iec559 = true;
    static constexpr bool is_bounded = true;
    static constexpr bool is_modulo = false;
    static constexpr int digits = 11;
    static constexpr int digits10 = 3;
    static constexpr int max_digits10 = 5;
    static constexpr int radix = 2;
    static constexpr int min_exponent = -13;
    static constexpr int min_exponent10 = -4;
    static constexpr int max_exponent = 16;
    static constexpr int max_exponent10 = 4;
    static constexpr auto traps = numeric_limits<float>::traps;
    static constexpr auto tinyness_before = numeric_limits<float>::tinyness_before;
    static constexpr op::fp16_t min()
    {
        return op::fp16_t(uint16_t(0x0400));
    }
    static constexpr op::fp16_t lowest()
    {
        return op::fp16_t(uint16_t(0xFBFF));
    }
    static constexpr op::fp16_t max()
    {
        return op::fp16_t(uint16_t(0x7BFF));
    }
    static constexpr op::fp16_t epsilon()
    {
        return op::fp16_t(uint16_t(0x1400));
    }
    static constexpr op::fp16_t round_error()
    {
        return op::fp16_t(uint16_t(0x3800));
    }
    static constexpr op::fp16_t infinity()
    {
        return op::fp16_t(uint16_t(0x7C00));
    }
    static constexpr op::fp16_t quiet_NaN()
    {
        return op::fp16_t(uint16_t(0x7E00));
    }
    static constexpr op::fp16_t signaling_NaN()
    {
        return op::fp16_t(uint16_t(0x7D00));
    }
    static constexpr op::fp16_t denorm_min()
    {
        return op::fp16_t(uint16_t(0x0001));
    }
};

} // namespace std

#endif //OP_API_OP_API_COMMON_INC_OPDEV_INTERNAL_TYPE_UTILS_H
