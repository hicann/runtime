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

#include "fp16_t.h"
 
namespace cce {
namespace runtime {
/**
 * @ingroup fp16_t global filed
 * @brief   round mode of last valid digital
 */
const fp16RoundMode_t g_RoundMode = ROUND_TO_NEAREST;
 
void ExtractFP16(const uint16_t &val, uint16_t *s, int16_t *e, uint16_t *m)
{
    // 1.Extract
    *s = Fp16ExtracSign(val);
    *e = Fp16ExtracExp(val);
    *m = Fp16ExtracMan(val);
 
    // Denormal
    if (0 == (*e)) {
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
static bool IsRoundOne(uint64_t man, uint16_t truncLen)
{
    uint16_t shiftOut = truncLen - DIM_2;
    uint64_t mask0 = 0x4;
    mask0 = mask0 << shiftOut;
    uint64_t mask1 = 0x2;
    mask1 = mask1 << shiftOut;
    uint64_t mask2;
    mask2 = mask1 - 1;
 
    bool lastBit = ((man & mask0) > 0);
    bool truncHigh = false;
    bool truncLeft = false;
    if (ROUND_TO_NEAREST == g_RoundMode) {
        truncHigh = ((man & mask1) > 0);
        truncLeft = ((man & mask2) > 0);
    }
    return (truncHigh && (truncLeft || lastBit));
}
/**
 * @ingroup fp16_t public method
 * @param [in] exp       exponent of fp16_t value
 * @param [in] man       exponent of fp16_t value
 * @brief   normalize fp16_t value
 * @return
 */
static void Fp16Normalize(int16_t &exp, uint16_t &man)
{
    if (exp >= FP16_MAX_EXP) {
        exp = FP16_MAX_EXP - 1;
        man = FP16_MAX_MAN;
    } else if (exp == 0 && man == FP16_MAN_HIDE_BIT) {
        exp++;
        man = 0;
    }
}
 
/**
 * @ingroup fp16_t math conversion static method
 * @param [in] fpVal uint16_t value of fp16_t object
 * @brief   Convert fp16_t to float/fp32
 * @return  Return float/fp32 value of fpVal which is the value of fp16_t object
 */
static float fp16ToFloat(const uint16_t &fpVal)
{
    float ret;
 
    uint16_t hfSign;
    uint16_t hfMan;
    int16_t hfExp;
    ExtractFP16(fpVal, &hfSign, &hfExp, &hfMan);
 
    while (hfMan && !(hfMan & FP16_MAN_HIDE_BIT)) {
        hfMan <<= 1;
        hfExp--;
    }
 
    uint32_t sRet;
    uint32_t eRet;
    uint32_t mRet;
    uint32_t fVal;
 
    sRet = hfSign;
    if (!hfMan) {
        eRet = 0;
        mRet = 0;
    } else {
        eRet = static_cast<uint32_t>(hfExp - FP16_EXP_BIAS + FP32_EXP_BIAS);
        mRet = hfMan & FP16_MAN_MASK;
        mRet = mRet << (FP32_MAN_LEN - FP16_MAN_LEN);
    }
    fVal = FP32_CONSTRUCTOR(sRet, eRet, mRet);
    uint32_t *ptrFVal = &fVal;
    float *ptrRet = reinterpret_cast<float *>(ptrFVal);
    ret = *ptrRet;
 
    return ret;
}
 
// evaluation
fp16_t &fp16_t::operator=(const fp16_t &fp)
{
    if (this == &fp) {
        return *this;
    }
    val = fp.val;
    return *this;
}
fp16_t &fp16_t::operator=(const float &fVal)
{
    uint16_t sRet;
    uint16_t mRet;
    int16_t eRet;
    uint32_t eF;
    uint32_t mF;
    uint32_t ui32V = *(reinterpret_cast<const uint32_t *>(&fVal)); // 1:8:23bit sign:exp:man
    uint32_t mLenDelta;
 
    sRet = static_cast<uint16_t>((ui32V & FP32_SIGN_MASK) >> FP32_SIGN_INDEX); // 4Byte->2Byte
    eF = (ui32V & FP32_EXP_MASK) >> FP32_MAN_LEN;                              // 8 bit exponent
    mF = (ui32V & FP32_MAN_MASK);                                              // 23 bit mantissa dont't need to care about denormal
    mLenDelta = FP32_MAN_LEN - FP16_MAN_LEN;
 
    bool needRound = false;
    // Exponent overflow/NaN converts to signed inf/NaN
    if (eF > 0x8Fu) { // 0x8Fu:142=127+15
        eRet = FP16_MAX_EXP - 1;
        mRet = FP16_MAX_MAN;
    } else if (eF <= 0x70u) { // 0x70u:112=127-15 Exponent underflow converts to denormalized half or signed zero
        eRet = 0;
        if (eF >= 0x67) { // 0x67:103=127-24 Denormal
            mF = (mF | FP32_MAN_HIDE_BIT);
            uint16_t shiftOut = FP32_MAN_LEN;
            uint64_t mTmp = ((uint64_t) mF) << (eF - 0x67);
 
            needRound = IsRoundOne(mTmp, shiftOut);
            mRet = static_cast<uint16_t>(mTmp >> shiftOut);
            if (needRound) {
                mRet++;
            }
        } else if (eF == 0x66 && mF > 0) { // 0x66:102 Denormal 0<f_v<min(Denormal)
            mRet = 1;
        } else {
            mRet = 0;
        }
    } else { // Regular case with no overflow or underflow
        eRet = (int16_t) (eF - 0x70u);
 
        needRound = IsRoundOne(mF, mLenDelta);
        mRet = static_cast<uint16_t>(mF >> mLenDelta);
        if (needRound) {
            mRet++;
        }
        if (mRet & FP16_MAN_HIDE_BIT) {
            eRet++;
        }
    }
 
    Fp16Normalize(eRet, mRet);
    val = FP16_CONSTRUCTOR(sRet, (uint16_t) eRet, mRet);
    return *this;
}
fp16_t &fp16_t::operator=(const int8_t &iVal)
{
    uint16_t sRet;
    uint16_t eRet;
    uint16_t mRet;
 
    sRet = (uint16_t) ((((uint8_t) iVal) & 0x80) >> DIM_7);
    mRet = (uint16_t) ((((uint8_t) iVal) & INT8_T_MAX));
 
    if (mRet == 0) {
        eRet = 0;
    } else {
        if (sRet) {                           // negative number(<0)
            mRet = (uint16_t) std::abs(iVal); // complement
        }
 
        eRet = FP16_MAN_LEN;
        while ((mRet & FP16_MAN_HIDE_BIT) == 0) {
            mRet = mRet << DIM_1;
            eRet = eRet - DIM_1;
        }
        eRet = eRet + FP16_EXP_BIAS;
    }
 
    val = FP16_CONSTRUCTOR(sRet, eRet, mRet);
    return *this;
}
fp16_t &fp16_t::operator=(const uint8_t &uiVal)
{
    uint16_t sRet;
    uint16_t eRet;
    uint16_t mRet;
    sRet = 0;
    eRet = 0;
    mRet = uiVal;
    if (mRet) {
        eRet = FP16_MAN_LEN;
        while ((mRet & FP16_MAN_HIDE_BIT) == 0) {
            mRet = mRet << DIM_1;
            eRet = eRet - DIM_1;
        }
        eRet = eRet + FP16_EXP_BIAS;
    }
 
    val = FP16_CONSTRUCTOR(sRet, eRet, mRet);
    return *this;
}
fp16_t &fp16_t::operator=(const int16_t &iVal)
{
    if (iVal == 0) {
        val = 0;
    } else {
        uint16_t sRet;
        uint16_t uiVal = *(reinterpret_cast<const uint16_t *>(&iVal));
        sRet = (uint16_t) (uiVal >> BitShift_15);
        if (sRet) {
            int16_t iValM = -iVal;
            uiVal = *(reinterpret_cast<uint16_t *>(&iValM));
        }
        uint32_t mTmp = (uiVal & FP32_ABS_MAX);
        uint16_t mMin = FP16_MAN_HIDE_BIT;
        uint16_t mMax = mMin << 1;
        uint16_t len = (uint16_t) GetManBitLength(mTmp);
        if (mTmp) {
            int16_t eRet;
            if (len > DIM_11) {
                eRet = FP16_EXP_BIAS + FP16_MAN_LEN;
                uint16_t eTmp = len - DIM_11;
                uint32_t truncMask = 1;
                for (int i = 1; i < eTmp; i++) {
                    truncMask = (truncMask << 1) + 1;
                }
                uint32_t mTrunc = (mTmp & truncMask) << (BitShift_32 - eTmp);
                for (int i = 0; i < eTmp; i++) {
                    mTmp = (mTmp >> 1);
                    eRet = eRet + 1;
                }
                bool bLastBit = ((mTmp & 1) > 0);
                bool bTruncHigh = false;
                bool bTruncLeft = false;
                if (ROUND_TO_NEAREST == g_RoundMode) { // trunc
                    bTruncHigh = ((mTrunc & FP32_SIGN_MASK) > 0);
                    bTruncLeft = ((mTrunc & FP32_ABS_MAX) > 0);
                }
                mTmp = ManRoundToNearest(bLastBit, bTruncHigh, bTruncLeft, mTmp);
                while (mTmp >= mMax || eRet < 0) {
                    mTmp = mTmp >> 1;
                    eRet = eRet + 1;
                }
            } else {
                eRet = FP16_EXP_BIAS;
                mTmp = mTmp << (11 - len);
                eRet = eRet + (len - 1);
            }
            uint16_t mRet = (uint16_t) mTmp;
            val = FP16_CONSTRUCTOR(sRet, (uint16_t) eRet, mRet);
        }
    }
    return *this;
}
fp16_t &fp16_t::operator=(const int32_t &iVal)
{
    if (iVal == 0) {
        val = 0;
    } else {
        uint32_t uiVal = *(reinterpret_cast<const uint32_t *>(&iVal));
        uint16_t sRet = (uint16_t) (uiVal >> BitShift_31);
        if (sRet) {
            int32_t iValM = -iVal;
            uiVal = *(reinterpret_cast<uint32_t *>(&iValM));
        }
        int16_t eRet;
        uint32_t mTmp = (uiVal & FP32_ABS_MAX);
        uint32_t mMin = FP16_MAN_HIDE_BIT;
        uint32_t mMax = mMin << 1;
        uint16_t len = (uint16_t) GetManBitLength(mTmp);
        if (len > DIM_11) {
            eRet = FP16_EXP_BIAS + FP16_MAN_LEN;
            uint32_t mTrunc = 0;
            uint32_t truncMask = 1;
            uint16_t eTmp = len - DIM_11;
            for (int i = 1; i < eTmp; i++) {
                truncMask = (truncMask << 1) + 1;
            }
            mTrunc = (mTmp & truncMask) << (BitShift_32 - eTmp);
            for (int i = 0; i < eTmp; i++) {
                mTmp = (mTmp >> 1);
                eRet = eRet + 1;
            }
            bool bLastBit = ((mTmp & 1) > 0);
            bool bTruncHigh = false;
            bool bTruncLeft = false;
            if (ROUND_TO_NEAREST == g_RoundMode) { // trunc
                bTruncHigh = ((mTrunc & FP32_SIGN_MASK) > 0);
                bTruncLeft = ((mTrunc & FP32_ABS_MAX) > 0);
            }
            mTmp = ManRoundToNearest(bLastBit, bTruncHigh, bTruncLeft, mTmp);
            while (mTmp >= mMax || eRet < 0) {
                mTmp = mTmp >> 1;
                eRet = eRet + 1;
            }
            if (eRet >= FP16_MAX_EXP) {
                eRet = FP16_MAX_EXP - 1;
                mTmp = FP16_MAX_MAN;
            }
        } else {
            eRet = FP16_EXP_BIAS;
            mTmp = mTmp << (DIM_11 - len);
            eRet = eRet + (len - 1);
        }
        uint16_t mRet = (uint16_t) mTmp;
        val = FP16_CONSTRUCTOR(sRet, (uint16_t) eRet, mRet);
    }
    return *this;
}
fp16_t &fp16_t::operator=(const uint32_t &uiVal)
{
    if (uiVal == 0) {
        val = 0;
    } else {
        int16_t eRet;
        uint32_t mTmp = uiVal;
 
        uint32_t mMin = FP16_MAN_HIDE_BIT;
        uint32_t mMax = mMin << 1;
        uint16_t len = (uint16_t) GetManBitLength(mTmp);
 
        if (len > DIM_11) {
            eRet = FP16_EXP_BIAS + FP16_MAN_LEN;
            uint32_t mTrunc = 0;
            uint32_t truncMask = 1;
            uint16_t eTmp = len - DIM_11;
            for (int i = 1; i < eTmp; i++) {
                truncMask = (truncMask << 1) + 1;
            }
            mTrunc = (mTmp & truncMask) << (BitShift_32 - eTmp);
            for (int i = 0; i < eTmp; i++) {
                mTmp = (mTmp >> 1);
                eRet = eRet + 1;
            }
            bool bLastBit = ((mTmp & 1) > 0);
            bool bTruncHigh = false;
            bool bTruncLeft = false;
            if (ROUND_TO_NEAREST == g_RoundMode) { // trunc
                bTruncHigh = ((mTrunc & FP32_SIGN_MASK) > 0);
                bTruncLeft = ((mTrunc & FP32_ABS_MAX) > 0);
            }
            mTmp = ManRoundToNearest(bLastBit, bTruncHigh, bTruncLeft, mTmp);
            while (mTmp >= mMax || eRet < 0) {
                mTmp = mTmp >> 1;
                eRet = eRet + 1;
            }
            if (eRet >= FP16_MAX_EXP) {
                eRet = FP16_MAX_EXP - 1;
                mTmp = FP16_MAX_MAN;
            }
        } else {
            eRet = FP16_EXP_BIAS;
            mTmp = mTmp << (DIM_11 - len);
            eRet = eRet + (len - 1);
        }
        uint16_t mRet = (uint16_t) mTmp;
        val = FP16_CONSTRUCTOR(0u, (uint16_t) eRet, mRet);
    }
    return *this;
}
fp16_t &fp16_t::operator=(const double &dVal)
{
    uint16_t sRet;
    uint16_t mRet;
    int16_t eRet;
    uint64_t eD;
    uint64_t mD;
    uint64_t ui64V = *((uint64_t *) &dVal); // 1:11:52bit sign:exp:man
    uint32_t mLenDelta;
 
    sRet = static_cast<uint16_t>((ui64V & FP64_SIGN_MASK) >> FP64_SIGN_INDEX); // 4Byte
    eD = (ui64V & FP64_EXP_MASK) >> FP64_MAN_LEN;                              // 10 bit exponent
    mD = (ui64V & FP64_MAN_MASK);                                              // 52 bit mantissa
    mLenDelta = FP64_MAN_LEN - FP16_MAN_LEN;
 
    bool needRound = false;
    // Exponent overflow/NaN converts to signed inf/NaN
    if (eD >= 0x410u) { // 0x410:1040=1023+16
        eRet = FP16_MAX_EXP - 1;
        mRet = FP16_MAX_MAN;
        val = FP16_CONSTRUCTOR(sRet, (uint16_t) eRet, mRet);
    } else if (eD <= 0x3F0u) { // Exponent underflow converts to denormalized half or signed zero
        // 0x3F0:1008=1023-15
        /**
     * Signed zeros, denormalized floats, and floats with small
     * exponents all convert to signed zero half precision.
     */
        eRet = 0;
        if (eD >= 0x3E7u) { // 0x3E7u:999=1023-24 Denormal
            // Underflows to a denormalized value
            mD = (FP64_MAN_HIDE_BIT | mD);
            uint16_t shiftOut = FP64_MAN_LEN;
            uint64_t mTmp = ((uint64_t) mD) << (eD - 0x3E7u);
 
            needRound = IsRoundOne(mTmp, shiftOut);
            mRet = static_cast<uint16_t>(mTmp >> shiftOut);
            if (needRound) {
                mRet++;
            }
        } else if (eD == 0x3E6u && mD > 0) {
            mRet = 1;
        } else {
            mRet = 0;
        }
    } else { // Regular case with no overflow or underflow
        eRet = (int16_t) (eD - 0x3F0u);
 
        needRound = IsRoundOne(mD, mLenDelta);
        mRet = static_cast<uint16_t>(mD >> mLenDelta);
        if (needRound) {
            mRet++;
        }
        if (mRet & FP16_MAN_HIDE_BIT) {
            eRet++;
        }
    }
 
    Fp16Normalize(eRet, mRet);
    val = FP16_CONSTRUCTOR(sRet, (uint16_t) eRet, mRet);
    return *this;
}
 
tagFp16 &fp16_t::operator=(const int64_t &iVal)
{
    return *this = (static_cast<int32_t>(iVal));
}
tagFp16 &fp16_t::operator=(const uint64_t &uiVal)
{
    return *this = (static_cast<uint32_t>(uiVal));
}
 
float fp16_t::toFloat() const
{
    return fp16ToFloat(val);
}
} // runtime
} // cce
#endif