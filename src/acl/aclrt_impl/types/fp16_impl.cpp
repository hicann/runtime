/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "fp16_impl.h"

namespace acl {
/**
 * @ingroup fp16_t global filed
 * @brief   round mode of last valid digital
 */

union TypeUnion {
    float32_t fVal;
    uint32_t uVal;
};

static void ExtractFP16(const uint16_t val, uint16_t *const s, int16_t *const e, uint16_t *const m)
{
    // 1.Extract
    *s = FP16_EXTRAC_SIGN(val);
    *e = static_cast<int16_t>(FP16_EXTRAC_EXP(val));
    *m = FP16_EXTRAC_MAN(val);

    // Denormal
    if ((*e) == 0) {
        *e = 1;
    }
}

/**
 * @ingroup fp16_t static method
 * @param [in] man       truncated mantissa
 * @param [in] shiftOut left shift bits based on ten bits
 * @brief   judge whether to add one to the result while converting fp16_t to other datatype
 * @return  Return true if add one, otherwise false
 */
static bool IsRoundOne(const uint64_t man, const uint16_t truncLen)
{
    uint64_t mask0 = 0x4UL;
    uint64_t mask1 = 0x2UL;
    uint64_t mask2;
    const uint64_t shiftOut = static_cast<uint64_t>(truncLen - 2U); // shift 2 byte
    mask0 = mask0 << shiftOut;
    mask1 = mask1 << shiftOut;
    mask2 = mask1 - 1U;

    const bool lastBit = ((man & mask0) > 0UL);
    const bool truncHigh = ((man & mask1) > 0UL);
    const bool truncLeft = ((man & mask2) > 0UL);
    return (truncHigh && (truncLeft || lastBit));
}

/**
 * @ingroup fp16_t public method
 * @param [in] exp       exponent of fp16_t value
 * @param [in] man       exponent of fp16_t value
 * @brief   normalize fp16_t value
 * @return
 */
static void Fp16Normalize(uint16_t &expVal, uint16_t &man)
{
    if (expVal >= FP16_MAX_EXP) {
        expVal = FP16_MAX_EXP - 1U;
        man = FP16_MAX_MAN;
        return;
    }
    if ((expVal == 0U) && (man == FP16_MAN_HIDE_BIT)) {
        expVal++;
        man = 0U;
        return;
    }
}

float32_t Fp16ToFloat(const uint16_t val)
{
    uint16_t hfSign;
    uint16_t hfMan;
    int16_t hfExp;
    ExtractFP16(val, &hfSign, &hfExp, &hfMan);

    while ((hfMan != 0U) && ((hfMan & FP16_MAN_HIDE_BIT) == 0U)) {
        hfMan <<= 1U;
        hfExp--;
    }

    uint32_t eRet;
    uint32_t mRet;
    if (hfMan == 0U) {
        eRet = 0U;
        mRet = 0U;
    } else {
        eRet = static_cast<uint32_t>(hfExp + static_cast<int16_t>(FP32_EXP_BIAS - FP16_EXP_BIAS));
        mRet = static_cast<uint32_t>(hfMan & FP16_MAN_MASK);
        mRet = mRet << (FP32_MAN_LEN - FP16_MAN_LEN);
    }

    const uint32_t sRet = hfSign;
    TypeUnion u;
    u.uVal = FP32_CONSTRUCTOR(sRet, eRet, mRet);
    const auto ret = u.fVal;
    return ret;
}

uint16_t FloatToFp16(const float32_t val)
{
    TypeUnion u;
    u.fVal = val;
    const uint32_t ui32V = u.uVal;  // 1:8:23bit sign:exp:man
    const auto sRet = static_cast<uint16_t>((ui32V & FP32_SIGN_MASK) >> FP32_SIGN_INDEX);  // 4Byte->2Byte
    const uint32_t eF = (ui32V & FP32_EXP_MASK) >> FP32_MAN_LEN; // 8 bit exponent
    uint32_t mF = (ui32V & FP32_MAN_MASK); // 23 bit mantissa dont't need to care about denormal

    uint16_t mRet;
    uint16_t eRet;
    // Exponent overflow/NaN converts to signed inf/NaN
    if (eF > 0x8FU) {  // 0x8Fu:142=127+15
        eRet = FP16_MAX_EXP - 1U;
        mRet = FP16_MAX_MAN;
    } else if (eF <= 0x70U) {  // 0x70u:112=127-15 Exponent underflow converts to denormalized half or signed zero
        eRet = 0U;
        if (eF >= 0x67U) {  // 0x67:103=127-24 Denormal
            mF = (mF | FP32_MAN_HIDE_BIT);
            const uint16_t shiftOut = FP32_MAN_LEN;
            const uint64_t mTmp = (static_cast<uint64_t>(mF)) << (eF - 0x67U);

            const bool needRound = IsRoundOne(mTmp, shiftOut);
            mRet = static_cast<uint16_t>(mTmp >> shiftOut);
            if (needRound) {
                mRet++;
            }
        } else if ((eF == 0x66U) && (mF > 0U)) {  // 0x66:102 Denormal 0<f_v<min(Denormal)
            mRet = 1U;
        } else {
            mRet = 0U;
        }
    } else {  // Regular case with no overflow or underflow
        const uint32_t mLenDelta = FP32_MAN_LEN - FP16_MAN_LEN;
        eRet = static_cast<uint16_t>(eF - 0x70U);
        const bool needRound = IsRoundOne(static_cast<uint64_t>(mF), static_cast<uint16_t>(mLenDelta));
        mRet = static_cast<uint16_t>(mF >> mLenDelta);
        if (needRound) {
            mRet++;
        }
        if ((mRet & FP16_MAN_HIDE_BIT) != 0U) {
            eRet++;
        }
    }

    Fp16Normalize(eRet, mRet);
    const uint16_t ret = static_cast<uint16_t>(FP16_CONSTRUCTOR(sRet, eRet, mRet));
    return ret;
}
} // namespace acl
