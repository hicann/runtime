/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ACL_TYPES_FP16_IMPL_H_
#define ACL_TYPES_FP16_IMPL_H_

#include <cstdint>
#include "common/log_inner.h"

namespace acl {
/**
 * @ingroup fp16 basic parameter
 * @brief   fp16 exponent bias
 */
static constexpr uint32_t FP16_EXP_BIAS = 15U;
/**
 * @ingroup fp16 basic parameter
 * @brief   bit index of sign in fp16
 */
static constexpr uint32_t FP16_SIGN_INDEX = 15U;
/**
 * @ingroup fp16 basic parameter
 * @brief   mantissa mask of fp16     (        11111 11111)
 */
static constexpr uint32_t FP16_MAN_MASK = 0x03FFU;
/**
 * @ingroup fp16 basic parameter
 * @brief   hide bit of mantissa of fp16(   1 00000 00000)
 */
static constexpr uint32_t FP16_MAN_HIDE_BIT = 0x0400U;
/**
 * @ingroup fp32 basic parameter
 * @brief   fp32 exponent bias
 */
static constexpr uint32_t FP32_EXP_BIAS = 127U;
/**
 * @ingroup fp32 basic parameter
 * @brief   sign mask of fp32         (1 0000 0000  0000 0000 0000 0000 000)
 */
static constexpr uint32_t FP32_SIGN_MASK = 0x80000000U;
/**
 * @ingroup fp32 basic parameter
 * @brief   exponent mask of fp32     (  1111 1111  0000 0000 0000 0000 000)
 */
static constexpr uint32_t FP32_EXP_MASK = 0x7F800000U;
/**
 * @ingroup fp32 basic parameter
 * @brief   mantissa mask of fp32     (             1111 1111 1111 1111 111)
 */
static constexpr uint32_t FP32_MAN_MASK = 0x007FFFFFU;
/**
 * @ingroup fp32 basic parameter
 * @brief   hide bit of mantissa of fp32      (  1  0000 0000 0000 0000 000)
 */
static constexpr uint32_t FP32_MAN_HIDE_BIT = 0x00800000U;
/**
 * @ingroup integer special value judgment
 * @brief   maximum positive value of int16_t           (0111 1111 1111 1111)
 */
static constexpr uint32_t INT16_T_MAX = 0x7FFFU;
/**
 * @ingroup fp16 basic parameter
 * @brief   maximum exponent value of fp16 is 15(11111)
 */
static constexpr uint32_t FP16_MAX_EXP = 0x001FU;
/**
 * @ingroup fp16 basic parameter
 * @brief   the mantissa bit length of fp16 is 10
 */
static constexpr uint32_t FP16_MAN_LEN = 10U;
/**
 * @ingroup fp16 basic parameter
 * @brief   maximum mantissa value of fp16(11111 11111)
 */
static constexpr uint32_t FP16_MAX_MAN = 0x03FFU;
/**
 * @ingroup fp32 basic parameter
 * @brief   bit index of sign in float/fp32
 */
static constexpr uint32_t FP32_SIGN_INDEX = 31U;
/**
 * @ingroup fp32 basic parameter
 * @brief   the mantissa bit length of float/fp32 is 23
 */
static constexpr uint32_t FP32_MAN_LEN = 23U;
/**
 * @ingroup fp32 basic parameter
 * @brief   maximum mantissa value of fp32    (1111 1111 1111 1111 1111 111)
 */
static constexpr uint32_t FP32_MAX_MAN = 0x7FFFFFU;

uint16_t FloatToFp16(const float32_t val);

float32_t Fp16ToFloat(const uint16_t val);
} // namespace acl
/**
 * @ingroup fp16 basic operator
 * @brief   get sign of fp16
 */
#define FP16_EXTRAC_SIGN(x)            (((x) >> 15U) & 1U)
/**
 * @ingroup fp16 basic operator
 * @brief   get exponent of fp16
 */
#define FP16_EXTRAC_EXP(x)             (((x) >> 10U) & acl::FP16_MAX_EXP)
/**
 * @ingroup fp16 basic operator
 * @brief   get mantissa of fp16
 */
#define FP16_EXTRAC_MAN(x)             ((((x) >> 0U) & 0x3FFU) |          \
                                       ((((((x) >> 10U) & 0x1FU) > 0U) ? 1U : 0U) * 0x400U))
/**
 * @ingroup fp16 basic operator
 * @brief   constructor of fp16 from sign exponent and mantissa
 */
#define FP16_CONSTRUCTOR(s, e, m)        (((s) << acl::FP16_SIGN_INDEX) |      \
                                          ((e) << acl::FP16_MAN_LEN) |         \
                                          ((m) & acl::FP16_MAX_MAN))
/**
 * @ingroup fp32 basic operator
 * @brief   constructor of fp32 from sign exponent and mantissa
 */
#define FP32_CONSTRUCTOR(s, e, m)        (((s) << acl::FP32_SIGN_INDEX) |      \
                                          ((e) << acl::FP32_MAN_LEN) |         \
                                          ((m) & acl::FP32_MAX_MAN))
#endif // ACL_TYPES_FP16_IMPL_H_
