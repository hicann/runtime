/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CPU_DETECT_TEST_H
#define CPU_DETECT_TEST_H

#include <stdint.h>
#include "cpu_detect_types.h"

#ifdef __cplusplus
extern "C" {
#endif

#define TEMP_BUF_SIZE (64 * 512)
#define PRINT_TEMP_BUF_LEN (64)

#ifdef CPU_DETECT_LINX_CORE
// GroupA
void LCRTIntASMFlagM(uint32_t *regValues);
void TSRTIntAlu(uint32_t *regValues);
void TSRTIntCompare(uint32_t *regValues);
void TSRTIntCRCAndShiftAndMov(uint32_t *regValues);

// GroupB
void LCRTFloatBF16JscvtFrintts(uint32_t *regValues);
void TSRTFloatCompare(uint32_t *regValues);
void TSRTFloatFixedPointConvertToFloatPoint(uint32_t *regValues);
void TSRTFloatFloatPointConvertPrecision(uint32_t *regValues);
void TSRTFloatFloatPointRoundToInteger(uint32_t *regValues);
void TSRTFloatMinMax(uint32_t *regValues);
void TSRTFloatMovMadd(uint32_t *regValues);

// GroupC
void LCRTAdvsimdScalarRDM(uint32_t *regValues);
void TSRTAdvsimdScalarCompare(uint32_t *regValues);
void TSRTAdvsimdScalarFixedPointConvertToFloatPoint(uint32_t *regValues);
void TSRTAdvsimdScalarFloatPointConvertToInteger(uint32_t *regValues);
void TSRTAdvsimdScalarGeneralOperation(uint32_t *regValues);

// GroupD
void LCRTAdvsimdVectorFcmaFrintts(uint32_t *regValues);
void LCRTAdvsimdVectorFhmI8mm(uint32_t *regValues);
void LCRTAdvsimdVectorRdmBF16Dotprod(uint32_t *regValues);
void LCRTAdvsimdVectorV8p2CryptographicExtension(uint32_t *regValues);
void TSRTAdvsimdVectorCompare(uint32_t *regValues);
void TSRTAdvsimdVectorFixedPointConvertToFloatingPoint(uint32_t *regValues);
void TSRTAdvsimdVectorFloatingPointConvertToInteger(uint32_t *regValues);
void TSRTAdvsimdVectorFloatingPointOperation(uint32_t *regValues);
void TSRTAdvsimdVectorGeneralOperation(uint32_t *regValues);
void TSRTAdvsimdVectorMaxMin(uint32_t *regValues);
void TSRTAdvsimdVectorSecureHashStandard(uint32_t *regValues);
void TSRTAdvsimdVectorSignedOperation(uint32_t *regValues);
void TSRTAdvsimdVectorUnsignedOperation(uint32_t *regValues);

// GroupE
void AdvsimdLoadDeprecatedP01(uint32_t *regValues, uint32_t *loadStoreBuf);
void AdvsimdLoadDeprecatedP02(uint32_t *regValues, uint32_t *loadStoreBuf);
void AdvsimdLoadDeprecatedP03(uint32_t *regValues, uint32_t *loadStoreBuf);
void AdvsimdLoadDeprecatedP04(uint32_t *regValues, uint32_t *loadStoreBuf);
void AdvsimdLoadStoreP01(uint32_t *regValues, uint32_t *loadStoreBuf);
void AdvsimdLoadStoreP02(uint32_t *regValues, uint32_t *loadStoreBuf);
void AdvsimdLoadStoreP03(uint32_t *regValues, uint32_t *loadStoreBuf);
void AdvsimdLoadStoreP04(uint32_t *regValues, uint32_t *loadStoreBuf);
void AdvsimdLoadStoreP05(uint32_t *regValues, uint32_t *loadStoreBuf);
void AdvsimdLoadStoreP06(uint32_t *regValues, uint32_t *loadStoreBuf);
void AdvsimdLoadStoreP07(uint32_t *regValues, uint32_t *loadStoreBuf);
void FpsimdLoadStoreP01(uint32_t *regValues, uint32_t *loadStoreBuf);
void GeneralLoadStoreP01(uint32_t *regValues, uint32_t *loadStoreBuf);
void GeneralLoadStoreP02(uint32_t *regValues, uint32_t *loadStoreBuf);
void LCRTGeneralLoadStoreP01(uint32_t *regValues, uint32_t *loadStoreBuf);
void LCRTGeneralLoadStoreP02(uint32_t *regValues, uint32_t *loadStoreBuf);
void LCRTGeneralLoadStoreP03(uint32_t *regValues, uint32_t *loadStoreBuf);
void LCRTGeneralLoadStoreP04(uint32_t *regValues, uint32_t *loadStoreBuf);
void SveLoadStoreP01(uint32_t *regValues, uint32_t *loadStoreBuf);
void SveLoadStoreP02(uint32_t *regValues, uint32_t *loadStoreBuf);
void SveLoadStoreP03(uint32_t *regValues, uint32_t *loadStoreBuf);
void SveLoadStoreP04(uint32_t *regValues, uint32_t *loadStoreBuf);
void GeneralPrefetchP01(uint32_t *regValues, uint32_t *loadStoreBuf);
void LCRTGeneralLoadStoreP05(uint32_t *regValues, uint32_t *loadStoreBuf);
void SvePrefetchP01(uint32_t *regValues, uint32_t *loadStoreBuf);

// GroupF
void BranchInGeneralP01(uint32_t *regValues);
void BranchInGeneralP02(uint32_t *regValues);

// GroupG
void EnhanceBranchP01(uint32_t *regValues);
void EnhanceDependencyP01(uint32_t *regValues);
void EnhanceLoadStoreP02(uint32_t *regValues, uint32_t *loadStoreBuf);
void BrAdrLiteral(uint32_t *regValues);
void DataCacheInvalidP01(uint32_t *regValues, uint32_t *loadStoreBuf);
void EnhanceFloatP01(uint32_t *regValues);
void EnhanceFloatP02(uint32_t *regValues);
void EnhanceLoadStoreP01(uint32_t *regValues, uint32_t *loadStoreBuf);
void EnhanceSveP01(uint32_t *regValues);
void EnhanceSveP02(uint32_t *regValues);
void EnhanceSveP03(uint32_t *regValues);
void InstrCacheInvalid(uint32_t *regValues);
void LiteralSevlWfe(uint32_t *regValues);
void LoadALUDependencyP01(uint32_t *regValues, uint32_t *loadStoreBuf);
void LoadFaddDependencyP01(uint32_t *regValues, uint32_t *loadStoreBuf);
void LoadFaddDependencyP02(uint32_t *regValues, uint32_t *loadStoreBuf);
void LoadFaddDependencyP03(uint32_t *regValues, uint32_t *loadStoreBuf);

// GroupH
void LCRTSveMoveOperations(uint32_t *regValues);
void LCRTSveReductionOperations(uint32_t *regValues);
void LCRTSveVectorMoveP01(uint32_t *regValues);
void LCRTSveVectorMoveP02(uint32_t *regValues);
void LCRTSveVectorMoveP03(uint32_t *regValues);
void LCRTSveVectorMoveP04(uint32_t *regValues);
void LCRTSveVectorMoveP05(uint32_t *regValues);
void LCRTSveVectorMoveP06(uint32_t *regValues);
void LCRTSveVectorMovprfx(uint32_t *regValues);
void LCRTSveVectorBF16(uint32_t *regValues);
void LCRTSveVectorI8MM(uint32_t *regValues);

#else
// Taishan
void TaishanFpComparisonP01(uint32_t *regValues);
void TaishanFpMiniMaxiP01(uint32_t *regValues);
void TaishanFpMovMaddP01(uint32_t *regValues);
void TaishanSimdAddP01(uint32_t *regValues);
void TaishanSimdAritheticP01(uint32_t *regValues);
void TaishanSimdCompareP01(uint32_t *regValues);
void TaishanSimdComplexP01(uint32_t *regValues);
void TaishanSimdCryptoP01(uint32_t *regValues);
void TaishanSimdElementArithemticP01(uint32_t *regValues);
void TaishanSimdFpIntConversionP01(uint32_t *regValues);
void TaishanSimdImmP01(uint32_t *regValues);
void TaishanSimdMovP01(uint32_t *regValues);
void TaishanSimdPairArithmeticP01(uint32_t *regValues);
void TaishanSimdPermuteP01(uint32_t *regValues);
void TaishanSimdReduceP01(uint32_t *regValues);
void TaishanSimdUnaryArithmeticP01(uint32_t *regValues);
void TaishanSimdWideNarryArthemticP01(uint32_t *regValues);
void TaishanIntAluP01(uint32_t *regValues);
void TaishanIntCcP01(uint32_t *regValues);
void TaishanIntMduP01(uint32_t *regValues);
void TaishanIntAluP02(uint32_t *regValues);
void TaishanIntMduP02(uint32_t *regValues);
void TaishanIntCacheWriteReadP01(uint32_t *regValues, uint32_t *loadStoreBuf);
void TaishanIntCacheWriteReadP02(uint32_t *regValues, uint32_t *loadStoreBuf);
void TaishanIntCacheWriteReadP03(uint32_t *regValues, uint32_t *loadStoreBuf);
void TaishanIntCacheWriteReadP04(uint32_t *regValues, uint32_t *loadStoreBuf);
void TaishanIntCacheWriteReadP05(uint32_t *regValues, uint32_t *loadStoreBuf);
void TaishanIntCacheWriteReadP06(uint32_t *regValues, uint32_t *loadStoreBuf);
// GroupA
void SinglePressAdvsimdScalar01(uint32_t *regValues);
void SinglePressAdvsimdScalar02(uint32_t *regValues);
void SinglePressAdvsimdScalar03(uint32_t *regValues);
void SinglePressAdvsimdVector01(uint32_t *regValues);
void SinglePressAdvsimdVector02(uint32_t *regValues);
void SinglePressAdvsimdVector03(uint32_t *regValues);
void SinglePressAdvsimdVector04(uint32_t *regValues);
void SinglePressAdvsimdVector05(uint32_t *regValues);
void SinglePressAdvsimdVector06(uint32_t *regValues);
void SinglePressAdvsimdVector07(uint32_t *regValues);
void SinglePressAdvsimdVector08(uint32_t *regValues);
void SinglePressFloat01(uint32_t *regValues);
void SinglePressFloat02(uint32_t *regValues);
void SinglePressFloat03(uint32_t *regValues);
void SinglePressInt01(uint32_t *regValues);
void SinglePressInt02(uint32_t *regValues);
void SinglePressInt03(uint32_t *regValues);
// GroupB
void TSRTIntAllOperation(uint32_t *regValues);
void TSRTIntCompare(uint32_t *regValues);
void TSRTIntAlu(uint32_t *regValues);
void TSRTIntCRCAndShiftAndMov(uint32_t *regValues);
// GroupC
void TSRTFloatAllOperation(uint32_t *regValues);
void TSRTFloatCompare(uint32_t *regValues);
void TSRTFloatFixedPointConvertToFloatPoint(uint32_t *regValues);
void TSRTFloatFloatPointConvertPrecision(uint32_t *regValues);
void TSRTFloatFloatPointRoundToInteger(uint32_t *regValues);
void TSRTFloatMinMax(uint32_t *regValues);
void TSRTFloatMovMadd(uint32_t *regValues);
// GroupD
void TSRTAdvsimdScalarAllOperation(uint32_t *regValues);
void TSRTAdvsimdScalarCompare(uint32_t *regValues);
void TSRTAdvsimdScalarFixedPointConvertToFloatPoint(uint32_t *regValues);
void TSRTAdvsimdScalarFloatPointConvertToInteger(uint32_t *regValues);
void TSRTAdvsimdScalarGeneralOperation(uint32_t *regValues);
// GroupE
void TSRTAdvsimdVectorAllOperation(uint32_t *regValues);
void TSRTAdvsimdVectorCompare(uint32_t *regValues);
void TSRTAdvsimdVectorFixedPointConvertToFloatingPoint(uint32_t *regValues);
void TSRTAdvsimdVectorFloatingPointConvertToInteger(uint32_t *regValues);
void TSRTAdvsimdVectorFloatingPointOperation(uint32_t *regValues);
void TSRTAdvsimdVectorGeneralOperation(uint32_t *regValues);
void TSRTAdvsimdVectorMaxMin(uint32_t *regValues);
void TSRTAdvsimdVectorSecureHashStandard(uint32_t *regValues);
void TSRTAdvsimdVectorSignedOperation(uint32_t *regValues);
void TSRTAdvsimdVectorUnsignedOperation(uint32_t *regValues);
// GroupF
void AdvsimdLoadDeprecatedP01(uint32_t *regValues, uint32_t *loadStoreBuf);
void AdvsimdLoadDeprecatedP02(uint32_t *regValues, uint32_t *loadStoreBuf);
void AdvsimdLoadDeprecatedP03(uint32_t *regValues, uint32_t *loadStoreBuf);
void AdvsimdLoadDeprecatedP04(uint32_t *regValues, uint32_t *loadStoreBuf);
void AdvsimdLoadStoreP01(uint32_t *regValues, uint32_t *loadStoreBuf);
void AdvsimdLoadStoreP02(uint32_t *regValues, uint32_t *loadStoreBuf);
void AdvsimdLoadStoreP03(uint32_t *regValues, uint32_t *loadStoreBuf);
void AdvsimdLoadStoreP04(uint32_t *regValues, uint32_t *loadStoreBuf);
void AdvsimdLoadStoreP05(uint32_t *regValues, uint32_t *loadStoreBuf);
void AdvsimdLoadStoreP06(uint32_t *regValues, uint32_t *loadStoreBuf);
void AdvsimdLoadStoreP07(uint32_t *regValues, uint32_t *loadStoreBuf);
void FpsimdLoadStoreP01(uint32_t *regValues, uint32_t *loadStoreBuf);
void FpsimdLoadStoreP02(uint32_t *regValues, uint32_t *loadStoreBuf);
void GeneralLoadStoreP01(uint32_t *regValues, uint32_t *loadStoreBuf);
void GeneralLoadStoreP02(uint32_t *regValues, uint32_t *loadStoreBuf);
void GeneralLoadStoreP03(uint32_t *regValues, uint32_t *loadStoreBuf);
void GeneralLoadStoreP04(uint32_t *regValues, uint32_t *loadStoreBuf);
// GroupG
void BranchInGeneralP01(uint32_t *regValues);
void BranchInGeneralP02(uint32_t *regValues);
// GroupH
void DataReverseAdvsimdScalarP01(uint32_t *regValues);
void DataReverseAdvsimdVectorP01(uint32_t *regValues);
void DataReverseAdvsimdVectorP02(uint32_t *regValues);
void DataReverseAdvsimdVectorP03(uint32_t *regValues);
void DataReverseAdvsimdVectorP04(uint32_t *regValues);
void DataReverseFloatP01(uint32_t *regValues);
void DataReverseIntP01(uint32_t *regValues);
void EnhanceBranchP01(uint32_t *regValues);
void EnhanceDependencyP01(uint32_t *regValues);
void EnhanceLoadStoreP01(uint32_t *regValues, uint32_t *loadStoreBuf);
void EnhanceLoadStoreP02(uint32_t *regValues, uint32_t *loadStoreBuf);
#endif

CpudStatus CpuDetectGroupTaiShan(uint32_t *regValues, uint32_t *loadStoreBuf, int32_t cpu);
CpudStatus CpuDetectGroupA(uint32_t *regValues, uint32_t *loadStoreBuf, int32_t cpu);
CpudStatus CpuDetectGroupB(uint32_t *regValues, uint32_t *loadStoreBuf, int32_t cpu);
CpudStatus CpuDetectGroupC(uint32_t *regValues, uint32_t *loadStoreBuf, int32_t cpu);
CpudStatus CpuDetectGroupD(uint32_t *regValues, uint32_t *loadStoreBuf, int32_t cpu);
CpudStatus CpuDetectGroupE(uint32_t *regValues, uint32_t *loadStoreBuf, int32_t cpu);
CpudStatus CpuDetectGroupF(uint32_t *regValues, uint32_t *loadStoreBuf, int32_t cpu);
CpudStatus CpuDetectGroupG(uint32_t *regValues, uint32_t *loadStoreBuf, int32_t cpu);
CpudStatus CpuDetectGroupH(uint32_t *regValues, uint32_t *loadStoreBuf, int32_t cpu);
CpudStatus CpuDetectGroup(uint32_t *regValues, uint32_t *loadStoreBuf, int32_t cpu);

#ifdef __cplusplus
}
#endif
#endif