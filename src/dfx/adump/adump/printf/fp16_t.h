/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef FP16_T_H
#define FP16_T_H
 
#include <algorithm>
#include <cmath>
#include <math.h>
#include <stdint.h>
 
namespace Adx {
 
const uint16_t DIM_1 = 1;
const uint16_t DIM_2 = 2;
const uint16_t DIM_7 = 7;
const uint16_t DIM_11 = 11;
 
const uint16_t BitShift_15 = 15;
const uint16_t BitShift_31 = 31;
const uint16_t BitShift_32 = 32;
 
/**
 * @ingroup fp16 basic parameter
 * @brief   fp16 exponent bias
 */
#define FP16_EXP_BIAS (15)
/**
 * @ingroup fp16 basic parameter
 * @brief   the mantissa bit length of fp16 is 10
 */
#define FP16_MAN_LEN (10)
/**
 * @ingroup fp16 basic parameter
 * @brief   bit index of sign in fp16
 */
#define FP16_SIGN_INDEX (15)
/**
 * @ingroup fp16 basic parameter
 * @brief   sign mask of fp16         (1 00000 00000 00000)
 */
#define FP16_SIGN_MASK (0x8000)
/**
 * @ingroup fp16 basic parameter
 * @brief   exponent mask of fp16     (  11111 00000 00000)
 */
#define FP16_EXP_MASK (0x7C00)
/**
 * @ingroup fp16 basic parameter
 * @brief   mantissa mask of fp16     (        11111 11111)
 */
#define FP16_MAN_MASK (0x03FF)
/**
 * @ingroup fp16 basic parameter
 * @brief   conceal bit of mantissa of fp16(   1 00000 00000)
 */
#define FP16_MAN_HIDE_BIT (0x0400)
/**
 * @ingroup fp16 basic parameter
 * @brief   maximum value            (0111 1011 1111 1111)
 */
#define FP16_MAX (0x7BFF)
/**
 * @ingroup fp16 basic parameter
 * @brief   minimum value            (1111 1011 1111 1111)
 */
#define FP16_MIN (0xFBFF)
/**
 * @ingroup fp16 basic parameter
 * @brief   absolute maximum value   (0111 1111 1111 1111)
 */
#define FP16_ABS_MAX (0x7FFF)
/**
 * @ingroup fp16 basic parameter
 * @brief   maximum exponent value of fp16 is 15(11111)
 */
#define FP16_MAX_EXP (0x001F)
/**
 * @ingroup fp16 basic parameter
 * @brief   maximum valid exponent value of fp16 is 14(11110)
 */
#define FP16_MAX_VALID_EXP (0x001E)
/**
 * @ingroup fp16 basic parameter
 * @brief   maximum mantissa value of fp16(11111 11111)
 */
#define FP16_MAX_MAN (0x03FF)
/**
 * @ingroup fp16 basic parameter
 * @brief   absolute minimum normal value of fp16
 *         (E=1,M=0 D=2^(-14)=0.00006103515625)
 */
#define FP16_MIN_NORMAL ((1.0f / (2 << 14)))
 
/**
 * @ingroup fp16 basic operator
 * @brief   get sign of fp16
 */
#define FP16_EXTRAC_SIGN(x) (((x) >> 15) & 1)
/**
 * @ingroup fp16 basic operator
 * @brief   get exponent of fp16
 */
#define FP16_EXTRAC_EXP(x) (((x) >> 10) & FP16_MAX_EXP)
/**
 * @ingroup fp16 basic operator
 * @brief   get mantissa of fp16
 */
#define FP16_EXTRAC_MAN(x) ((((x) >> 0) & 0x3FF) | (((((x) >> 10) & 0x1F) > 0 ? 1 : 0) * 0x400))
/**
 * @ingroup fp16 basic operator
 * @brief   constructor of fp16 from sign exponent and mantissa
 */
#define FP16_CONSTRUCTOR(s, e, m) \
    (static_cast<uint16_t>(((s) << FP16_SIGN_INDEX) | ((e) << FP16_MAN_LEN) | ((m) &FP16_MAX_MAN)))
 
/**
 * @ingroup fp16 special value judgment
 * @brief   whether a fp16 is zero
 */
#define FP16_IS_ZERO(x) (((x) &FP16_ABS_MAX) == 0)
/**
 * @ingroup fp16 special value judgment
 * @brief   whether a fp16 is a denormalized value
 */
#define FP16_IS_DENORM(x) ((((x) &FP16_EXP_MASK) == 0))
/**
 * @ingroup fp16 special value judgment
 * @brief   whether a fp16 is infinite
 */
#define FP16_IS_INF(x) (((x) &FP16_ABS_MAX) == FP16_ABS_MAX)
/**
 * @ingroup fp16 special value judgment
 * @brief   whether a fp16 is NaN
 */
#define FP16_IS_NAN(x) (((x & FP16_EXP_MASK) == FP16_EXP_MASK) && (x & FP16_MAN_MASK))
/**
 * @ingroup fp16 special value judgment
 * @brief   whether a fp16 is invalid
 */
#define FP16_IS_INVALID(x) ((x & FP16_EXP_MASK) == FP16_EXP_MASK)
/**
 * @ingroup fp32 basic parameter
 * @brief   fp32 exponent bias
 */
#define FP32_EXP_BIAS (127)
/**
 * @ingroup fp32 basic parameter
 * @brief   the exponent bit length of float/fp32 is 8
 */
#define FP32_EXP_LEN (8)
/**
 * @ingroup fp32 basic parameter
 * @brief   the mantissa bit length of float/fp32 is 23
 */
#define FP32_MAN_LEN (23)
/**
 * @ingroup fp32 basic parameter
 * @brief   bit index of sign in float/fp32
 */
#define FP32_SIGN_INDEX (31)
/**
 * @ingroup fp32 basic parameter
 * @brief   sign mask of fp32         (1 0000 0000  0000 0000 0000 0000 000)
 */
#define FP32_SIGN_MASK (0x80000000u)
/**
 * @ingroup fp32 basic parameter
 * @brief   exponent mask of fp32     (  1111 1111  0000 0000 0000 0000 000)
 */
#define FP32_EXP_MASK (0x7F800000u)
/**
 * @ingroup fp32 basic parameter
 * @brief   mantissa mask of fp32     (             1111 1111 1111 1111 111)
 */
#define FP32_MAN_MASK (0x007FFFFFu)
/**
 * @ingroup fp32 basic parameter
 * @brief   conceal bit of mantissa of fp32      (  1  0000 0000 0000 0000 000)
 */
#define FP32_MAN_HIDE_BIT (0x00800000u)
/**
 * @ingroup fp32 basic parameter
 * @brief   absolute maximum value    (0 1111 1111  1111 1111 1111 1111 111)
 */
#define FP32_ABS_MAX (0x7FFFFFFFu)
/**
 * @ingroup fp32 basic parameter
 * @brief   maximum exponent value of fp32 is 255(1111 1111)
 */
#define FP32_MAX_EXP (0xFF)
/**
 * @ingroup fp32 basic parameter
 * @brief   maximum mantissa value of fp32    (1111 1111 1111 1111 1111 111)
 */
#define FP32_MAX_MAN (0x7FFFFF)
/**
 * @ingroup fp32 special value judgment
 * @brief   whether a fp32 is NaN
 */
#define FP32_IS_NAN(x) (((x & FP32_EXP_MASK) == FP32_EXP_MASK) && (x & FP32_MAN_MASK))
/**
 * @ingroup fp32 special value judgment
 * @brief   whether a fp32 is infinite
 */
#define FP32_IS_INF(x) (((x & FP32_EXP_MASK) == FP32_EXP_MASK) && (!(x & FP32_MAN_MASK)))
/**
 * @ingroup fp32 special value judgment
 * @brief   whether a fp32 is a denormalized value
 */
#define FP32_IS_DENORM(x) ((((x) &FP32_EXP_MASK) == 0))
/**
 * @ingroup fp32 basic operator
 * @brief   get sign of fp32
 */
#define FP32_EXTRAC_SIGN(x) (((x) >> FP32_SIGN_INDEX) & 1)
/**
 * @ingroup fp32 basic operator
 * @brief   get exponent of fp16
 */
#define FP32_EXTRAC_EXP(x) (((x) &FP32_EXP_MASK) >> FP32_MAN_LEN)
/**
 * @ingroup fp32 basic operator
 * @brief   get mantissa of fp16
 */
#define FP32_EXTRAC_MAN(x) \
    (((x) &FP32_MAN_MASK) | (((((x) >> FP32_MAN_LEN) & FP32_MAX_EXP) > 0 ? 1 : 0) * FP32_MAN_HIDE_BIT))
/**
 * @ingroup fp32 basic operator
 * @brief   constructor of fp32 from sign exponent and mantissa
 */
#define FP32_CONSTRUCTOR(s, e, m) (((s) << FP32_SIGN_INDEX) | ((e) << FP32_MAN_LEN) | ((m) &FP32_MAX_MAN))
 
/**
 * @ingroup fp64 basic parameter
 * @brief   fp64 exponent bias
 */
#define FP64_EXP_BIAS (1023)
/**
 * @ingroup fp64 basic parameter
 * @brief   the exponent bit length of double/fp64 is 11
 */
#define FP64_EXP_LEN (11)
/**
 * @ingroup fp64 basic parameter
 * @brief   the mantissa bit length of double/fp64 is 52
 */
#define FP64_MAN_LEN (52)
/**
 * @ingroup fp64 basic parameter
 * @brief   bit index of sign in double/fp64 is 63
 */
#define FP64_SIGN_INDEX (63)
/**
 * @ingroup fp64 basic parameter
 * @brief   sign mask of fp64                 (1 000                   (total 63bits 0))
 */
#define FP64_SIGN_MASK (0x8000000000000000LLu)
/**
 * @ingroup fp64 basic parameter
 * @brief   exponent mask of fp64            (0 1 11111 11111  0000?-?-(total 52bits 0))
 */
#define FP64_EXP_MASK (0x7FF0000000000000LLu)
/**
 * @ingroup fp64 basic parameter
 * @brief   mantissa mask of fp64            (                 1111?-?-(total 52bits 1))
 */
#define FP64_MAN_MASK (0x000FFFFFFFFFFFFFLLu)
/**
 * @ingroup fp64 basic parameter
 * @brief   conceal bit of mantissa of fp64     (               1 0000?-?-(total 52bits 0))
 */
#define FP64_MAN_HIDE_BIT (0x0010000000000000LLu)
/**
 * @ingroup fp64 basic parameter
 * @brief   absolute maximum value           (0 111?-?-(total 63bits 1))
 */
#define FP64_ABS_MAX (0x7FFFFFFFFFFFFFFFLLu)
/**
 * @ingroup fp64 basic parameter
 * @brief   maximum exponent value of fp64 is 2047(1 11111 11111)
 */
#define FP64_MAX_EXP (0x07FF)
/**
 * @ingroup fp64 basic parameter
 * @brief   maximum mantissa value of fp64  (111?-?-(total 52bits 1))
 */
#define FP64_MAX_MAN (0xFFFFFFFFFFFLLu)
/**
 * @ingroup fp64 special value judgment
 * @brief   whether a fp64 is NaN
 */
#define FP64_IS_NAN(x) (((x & FP64_EXP_MASK) == FP64_EXP_MASK) && (x & FP64_MAN_MASK))
/**
 * @ingroup fp64 special value judgment
 * @brief   whether a fp64 is infinite
 */
#define FP64_IS_INF(x) (((x & FP64_EXP_MASK) == FP64_EXP_MASK) && (!(x & FP64_MAN_MASK)))
 
/**
 * @ingroup integer special value judgment
 * @brief   maximum positive value of int8_t            (0111 1111)
 */
#define INT8_T_MAX (0x7F)
/**
 * @ingroup integer special value judgment
 * @brief   maximum value of a data with 8 bits length  (1111 111)
 */
#define BIT_LEN8_MAX (0xFF)
/**
 * @ingroup integer special value judgment
 * @brief   maximum positive value of int16_t           (0111 1111 1111 1111)
 */
#define INT16_T_MAX (0x7FFF)
/**
 * @ingroup integer special value judgment
 * @brief   maximum value of a data with 16 bits length (1111 1111 1111 1111)
 */
#define BIT_LEN16_MAX (0xFFFF)
/**
 * @ingroup integer special value judgment
 * @brief   maximum positive value of int32_t           (0111 1111 1111 1111 1111 1111 1111 1111)
 */
#define INT32_T_MAX (0x7FFFFFFFu)
/**
 * @ingroup integer special value judgment
 * @brief   maximum value of a data with 32 bits length (1111 1111 1111 1111 1111 1111 1111 1111)
 */
#define BIT_LEN32_MAX (0xFFFFFFFFu)
/**
 * @ingroup print switch
 * @brief   print an error if input fp16 is overflow
 */
 
/**
 * @ingroup fp16_t enum
 * @brief   round mode of last valid digital
 */
typedef enum tagFp16RoundMode {
    ROUND_TO_NEAREST = 0, /**< round to nearest even */
    ROUND_BY_TRUNCATED,   /**< round by truncated    */
    ROUND_MODE_RESERVED,
} fp16RoundMode_t;
 
/**
 * @ingroup fp16_t
 * @brief   Half precision float
 *         bit15:       1 bit SIGN      +---+-----+------------+
 *         bit14-10:    5 bit EXP       | S |EEEEE|MM MMMM MMMM|
 *         bit0-9:      10bit MAN       +---+-----+------------+
 *
 */
typedef struct tagFp16 {
    uint16_t val;
 
public:
    /**
   * @ingroup fp16_t constructor
   * @brief   Constructor without any param(default constructor)
   */
    tagFp16(void)
    {
        val = 0x0u;
    }
    /**
   * @ingroup all type constructor
   * @brief   Constructor with all type
   */
    template<typename T>
    tagFp16(const T &value)
    {
        *this = value;
    }
    /**
   * @ingroup fp16_t constructor
   * @brief   Constructor with an uint16_t value
   */
    constexpr tagFp16(const uint16_t &uiVal) : val(uiVal)
    {
    }
    /**
   * @ingroup fp16_t constructor
   * @brief   Constructor with a fp16_t object(copy constructor)
   */
    tagFp16(const tagFp16 &fp) : val(fp.val)
    {
    }
    /**
   * @ingroup fp16_t math evaluation operator
   * @param [in] fp fp16_t object to be copy to fp16_t
   * @brief   Override basic evaluation operator to copy fp16_t to a new fp16_t
   * @return  Return fp16_t result from fp
   */
    tagFp16 &operator=(const tagFp16 &fp);
    /**
   * @ingroup fp16_t math evaluation operator
   * @param [in] fVal float object to be converted to fp16_t
   * @brief   Override basic evaluation operator to convert float to fp16_t
   * @return  Return fp16_t result from fVal
   */
    tagFp16 &operator=(const float &fVal);
    /**
   * @ingroup fp16_t math evaluation operator
   * @param [in] dVal double object to be converted to fp16_t
   * @brief   Override basic evaluation operator to convert double to fp16_t
   * @return  Return fp16_t result from dVal
   */
    tagFp16 &operator=(const double &dVal);
    /**
   * @ingroup fp16_t math evaluation operator
   * @param [in] iVal float object to be converted to fp16_t
   * @brief   Override basic evaluation operator to convert float to fp16_t
   * @return  Return fp16_t result from iVal
   */
    tagFp16 &operator=(const int8_t &iVal);
    /**
   * @ingroup fp16_t math evaluation operator
   * @param [in] uiVal uint8_t object to be converted to fp16_t
   * @brief   Override basic evaluation operator to convert uint8_t to fp16_t
   * @return  Return fp16_t result from uiVal
   */
    tagFp16 &operator=(const uint8_t &uiVal);
    /**
   * @ingroup fp16_t math evaluation operator
   * @param [in] iVal int16_t object to be converted to fp16_t
   * @brief   Override basic evaluation operator to convert int16_t to fp16_t
   * @return  Return fp16_t result from iVal
   */
    tagFp16 &operator=(const int16_t &iVal);
    /**
   * @ingroup fp16_t math evaluation operator
   * @param [in] uiVal uint16_t object to be converted to fp16_t
   * @brief   Override basic evaluation operator to convert uint16_t to fp16_t
   * @return  Return fp16_t result from uiVal
   */
    tagFp16 &operator=(const uint16_t &uiVal);
    /**
   * @ingroup fp16_t math evaluation operator
   * @param [in] iVal int32_t object to be converted to fp16_t
   * @brief   Override basic evaluation operator to convert int32_t to fp16_t
   * @return  Return fp16_t result from iVal
   */
    tagFp16 &operator=(const int32_t &iVal);
    /**
   * @ingroup fp16_t math evaluation operator
   * @param [in] uiVal uint32_t object to be converted to fp16_t
   * @brief   Override basic evaluation operator to convert uint32_t to fp16_t
   * @return  Return fp16_t result from uiVal
   */
    tagFp16 &operator=(const uint32_t &uiVal);
    tagFp16 &operator=(const int64_t &iVal);
    tagFp16 &operator=(const uint64_t &uiVal);
    /**
   * @ingroup fp16_t math conversion
   * @brief   Convert fp16_t to float/fp32
   * @return  Return float/fp32 value of fp16_t
   */
    float toFloat();
} fp16_t;
 
/**
 * @ingroup fp16_t public method
 * @param [in]     val signature is negative
 * @param [in|out] s   sign of fp16_t object
 * @param [in|out] e   exponent of fp16_t object
 * @param [in|out] m   mantissa of fp16_t object
 * @brief   Extract the sign, exponent and mantissa of a fp16_t object
 */
void ExtractFP16(const uint16_t &val, uint16_t *s, int16_t *e, uint16_t *m);
/*lint +e1573*/
/**
 * @ingroup fp16_t public method
 * @param [in] bit0    whether the last preserved bit is 1 before round
 * @param [in] bit1    whether the abbreviation's highest bit is 1
 * @param [in] bitLeft whether the abbreviation's bits which not contain highest bit grater than 0
 * @param [in] man     mantissa of a fp16_t or float number, support types: uint16_t/uint32_t/uint64_t
 * @param [in] shift   abbreviation bits
 * @brief    Round fp16_t or float mantissa to nearest value
 * @return   Returns true if round 1,otherwise false;
*/
/*lint -e1573*/
template<typename T>
T ManRoundToNearest(bool bit0, bool bit1, bool bitLeft, T man, uint16_t shift = 0)
{
    man = (man >> shift) + ((bit1 && (bitLeft || bit0)) ? 1 : 0);
    return man;
}
/*lint +e1573*/
/**
 * @ingroup fp16_t public method
 * @param [in] man    mantissa of a float number, support types: uint16_t/uint32_t/uint64_t
 * @brief   Get bit length of a uint32_t number
 * @return  Return bit length of man
 */
/*lint -e1573*/
template<typename T>
int16_t GetManBitLength(T man)
{
    int16_t len = 0;
    while (man) {
        man >>= 1;
        len++;
    }
    return len;
}
 
/*lint +e1573*/
}; // namespace op
 
#endif /*_FP16_T_HPP_*/