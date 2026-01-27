/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "cpu_detect_test.h"
#include "cpu_detect_print.h"

#define GROUP_GAP_TIME 1000  // 1000us

typedef CpudStatus (*GroupDetectFunc)(uint32_t *regValues, uint32_t *loadStoreBuf, int32_t cpu);
typedef void (*TestcaseDetectFuncA)(uint32_t *regValues);
typedef void (*TestcaseDetectFuncB)(uint32_t *regValues, uint32_t *loadStoreBuf);

typedef struct {
    const char *name;
    GroupDetectFunc func;
} CpuGroupDetectSets;

typedef struct {
    const char *name;
    TestcaseDetectFuncA funcA;
    TestcaseDetectFuncB funcB;
} CpuTestcaseDetectSets;

STATIC CpuGroupDetectSets g_cpuDetectSets[] = {
    {"GroupTaiShan", CpuDetectGroupTaiShan},
    {"GroupA", CpuDetectGroupA},
    {"GroupB", CpuDetectGroupB},
    {"GroupC", CpuDetectGroupC},
    {"GroupD", CpuDetectGroupD},
    {"GroupE", CpuDetectGroupE},
    {"GroupF", CpuDetectGroupF},
    {"GroupG", CpuDetectGroupG},
    {"GroupH", CpuDetectGroupH},
};

#ifdef CPU_DETECT_LINX_CORE
// Taishan
STATIC CpuTestcaseDetectSets g_cpuGroupTaiShanDetectSets[] = {};

// GroupA
STATIC CpuTestcaseDetectSets g_cpuGroupADetectSets[] = {
    {"TSRTIntAlu", TSRTIntAlu, NULL},
    {"TSRTIntCompare", TSRTIntCompare, NULL},
    {"TSRTIntCRCAndShiftAndMov", TSRTIntCRCAndShiftAndMov, NULL},
};

// GroupB
STATIC CpuTestcaseDetectSets g_cpuGroupBDetectSets[] = {};

// GroupC
STATIC CpuTestcaseDetectSets g_cpuGroupCDetectSets[] = {};

// GroupD
STATIC CpuTestcaseDetectSets g_cpuGroupDDetectSets[] = {};

// GroupE
STATIC CpuTestcaseDetectSets g_cpuGroupEDetectSets[] = {
    {"GeneralLoadStoreP01", NULL, GeneralLoadStoreP01},
    {"GeneralLoadStoreP02", NULL, GeneralLoadStoreP02},
    {"LCRTGeneralLoadStoreP02", NULL, LCRTGeneralLoadStoreP02},
    {"LCRTGeneralLoadStoreP03", NULL, LCRTGeneralLoadStoreP03},
    {"LCRTGeneralLoadStoreP04", NULL, LCRTGeneralLoadStoreP04},
    {"GeneralPrefetchP01", NULL, GeneralPrefetchP01},
    {"LCRTGeneralLoadStoreP05", NULL, LCRTGeneralLoadStoreP05},
};

// GroupF
STATIC CpuTestcaseDetectSets g_cpuGroupFDetectSets[] = {
    {"BranchInGeneralP01", BranchInGeneralP01, NULL},
    {"BranchInGeneralP02", BranchInGeneralP02, NULL},
};

// GroupG
STATIC CpuTestcaseDetectSets g_cpuGroupGDetectSets[] = {
    {"EnhanceBranchP01", EnhanceBranchP01, NULL},
    {"EnhanceLoadStoreP02", NULL, EnhanceLoadStoreP02},
    {"BrAdrLiteral", BrAdrLiteral, NULL},
    {"DataCacheInvalidP01", NULL, DataCacheInvalidP01},
    {"EnhanceLoadStoreP01", NULL, EnhanceLoadStoreP01},
    {"InstrCacheInvalid", InstrCacheInvalid, NULL},
    {"LoadALUDependencyP01", NULL, LoadALUDependencyP01},
};

// GroupH
STATIC CpuTestcaseDetectSets g_cpuGroupHDetectSets[] = {};

#else
// Taishan
STATIC CpuTestcaseDetectSets g_cpuGroupTaiShanDetectSets[] = {
    {"TaishanFpComparisonP01", TaishanFpComparisonP01, NULL},
    {"TaishanFpMiniMaxiP01", TaishanFpMiniMaxiP01, NULL},
    {"TaishanFpMovMaddP01", TaishanFpMovMaddP01, NULL},
    {"TaishanSimdAddP01", TaishanSimdAddP01, NULL},
    {"TaishanSimdAritheticP01", TaishanSimdAritheticP01, NULL},
    {"TaishanSimdCompareP01", TaishanSimdCompareP01, NULL},
    {"TaishanSimdComplexP01", TaishanSimdComplexP01, NULL},
    {"TaishanSimdCryptoP01", TaishanSimdCryptoP01, NULL},
    {"TaishanSimdElementArithemticP01", TaishanSimdElementArithemticP01, NULL},
    {"TaishanSimdFpIntConversionP01", TaishanSimdFpIntConversionP01, NULL},
    {"TaishanSimdImmP01", TaishanSimdImmP01, NULL},
    {"TaishanSimdMovP01", TaishanSimdMovP01, NULL},
    {"TaishanSimdPairArithmeticP01", TaishanSimdPairArithmeticP01, NULL},
    {"TaishanSimdPermuteP01", TaishanSimdPermuteP01, NULL},
    {"TaishanSimdReduceP01", TaishanSimdReduceP01, NULL},
    {"TaishanSimdUnaryArithmeticP01", TaishanSimdUnaryArithmeticP01, NULL},
    {"TaishanSimdWideNarryArthemticP01", TaishanSimdWideNarryArthemticP01, NULL},
    {"TaishanIntAluP01", TaishanIntAluP01, NULL},
    {"TaishanIntCcP01", TaishanIntCcP01, NULL},
    {"TaishanIntMduP01", TaishanIntMduP01, NULL},
    {"TaishanIntAluP02", TaishanIntAluP02, NULL},
    {"TaishanIntMduP02", TaishanIntMduP02, NULL},
    {"TaishanIntCacheWriteReadP01", NULL, TaishanIntCacheWriteReadP01},
    {"TaishanIntCacheWriteReadP02", NULL, TaishanIntCacheWriteReadP02},
    {"TaishanIntCacheWriteReadP03", NULL, TaishanIntCacheWriteReadP03},
    {"TaishanIntCacheWriteReadP04", NULL, TaishanIntCacheWriteReadP04},
    {"TaishanIntCacheWriteReadP05", NULL, TaishanIntCacheWriteReadP05},
    {"TaishanIntCacheWriteReadP06", NULL, TaishanIntCacheWriteReadP06},
};

// GroupA
STATIC CpuTestcaseDetectSets g_cpuGroupADetectSets[] = {
    {"SinglePressAdvsimdScalar01", SinglePressAdvsimdScalar01, NULL},
    {"SinglePressAdvsimdScalar02", SinglePressAdvsimdScalar02, NULL},
    {"SinglePressAdvsimdScalar03", SinglePressAdvsimdScalar03, NULL},
    {"SinglePressAdvsimdVector01", SinglePressAdvsimdVector01, NULL},
    {"SinglePressAdvsimdVector02", SinglePressAdvsimdVector02, NULL},
    {"SinglePressAdvsimdVector03", SinglePressAdvsimdVector03, NULL},
    {"SinglePressAdvsimdVector04", SinglePressAdvsimdVector04, NULL},
    {"SinglePressAdvsimdVector05", SinglePressAdvsimdVector05, NULL},
    {"SinglePressAdvsimdVector06", SinglePressAdvsimdVector06, NULL},
    {"SinglePressAdvsimdVector07", SinglePressAdvsimdVector07, NULL},
    {"SinglePressAdvsimdVector08", SinglePressAdvsimdVector08, NULL},
    {"SinglePressFloat01", SinglePressFloat01, NULL},
    {"SinglePressFloat02", SinglePressFloat02, NULL},
    {"SinglePressFloat03", SinglePressFloat03, NULL},
    {"SinglePressInt01", SinglePressInt01, NULL},
    {"SinglePressInt02", SinglePressInt02, NULL},
    {"SinglePressInt03", SinglePressInt03, NULL},
};

// GroupB
STATIC CpuTestcaseDetectSets g_cpuGroupBDetectSets[] = {
    {"TSRTIntAllOperation", TSRTIntAllOperation, NULL},
    {"TSRTIntCompare", TSRTIntCompare, NULL},
    {"TSRTIntAlu", TSRTIntAlu, NULL},
    {"TSRTIntCRCAndShiftAndMov", TSRTIntCRCAndShiftAndMov, NULL},
};

// GroupC
STATIC CpuTestcaseDetectSets g_cpuGroupCDetectSets[] = {
    {"TSRTFloatAllOperation", TSRTFloatAllOperation, NULL},
    {"TSRTFloatCompare", TSRTFloatCompare, NULL},
    {"TSRTFloatFixedPointConvertToFloatPoint", TSRTFloatFixedPointConvertToFloatPoint, NULL},
    {"TSRTFloatFloatPointConvertPrecision", TSRTFloatFloatPointConvertPrecision, NULL},
    {"TSRTFloatFloatPointRoundToInteger", TSRTFloatFloatPointRoundToInteger, NULL},
    {"TSRTFloatMinMax", TSRTFloatMinMax, NULL},
    {"TSRTFloatMovMadd", TSRTFloatMovMadd, NULL},
};

// GroupD
STATIC CpuTestcaseDetectSets g_cpuGroupDDetectSets[] = {
    {"TSRTAdvsimdScalarAllOperation", TSRTAdvsimdScalarAllOperation, NULL},
    {"TSRTAdvsimdScalarCompare", TSRTAdvsimdScalarCompare, NULL},
    {"TSRTAdvsimdScalarFixedPointConvertToFloatPoint", TSRTAdvsimdScalarFixedPointConvertToFloatPoint, NULL},
    {"TSRTAdvsimdScalarFloatPointConvertToInteger", TSRTAdvsimdScalarFloatPointConvertToInteger, NULL},
    {"TSRTAdvsimdScalarGeneralOperation", TSRTAdvsimdScalarGeneralOperation, NULL},
};

// GroupE
STATIC CpuTestcaseDetectSets g_cpuGroupEDetectSets[] = {
    {"TSRTAdvsimdVectorAllOperation", TSRTAdvsimdVectorAllOperation, NULL},
    {"TSRTAdvsimdVectorCompare", TSRTAdvsimdVectorCompare, NULL},
    {"TSRTAdvsimdVectorFixedPointConvertToFloatingPoint", TSRTAdvsimdVectorFixedPointConvertToFloatingPoint, NULL},
    {"TSRTAdvsimdVectorFloatingPointConvertToInteger", TSRTAdvsimdVectorFloatingPointConvertToInteger, NULL},
    {"TSRTAdvsimdVectorFloatingPointOperation", TSRTAdvsimdVectorFloatingPointOperation, NULL},
    {"TSRTAdvsimdVectorGeneralOperation", TSRTAdvsimdVectorGeneralOperation, NULL},
    {"TSRTAdvsimdVectorMaxMin", TSRTAdvsimdVectorMaxMin, NULL},
    {"TSRTAdvsimdVectorSecureHashStandard", TSRTAdvsimdVectorSecureHashStandard, NULL},
    {"TSRTAdvsimdVectorSignedOperation", TSRTAdvsimdVectorSignedOperation, NULL},
    {"TSRTAdvsimdVectorUnsignedOperation", TSRTAdvsimdVectorUnsignedOperation, NULL},
};

// GroupF
STATIC CpuTestcaseDetectSets g_cpuGroupFDetectSets[] = {
    {"AdvsimdLoadDeprecatedP01", NULL, AdvsimdLoadDeprecatedP01},
    {"AdvsimdLoadDeprecatedP02", NULL, AdvsimdLoadDeprecatedP02},
    {"AdvsimdLoadDeprecatedP03", NULL, AdvsimdLoadDeprecatedP03},
    {"AdvsimdLoadDeprecatedP04", NULL, AdvsimdLoadDeprecatedP04},
    {"AdvsimdLoadStoreP01", NULL, AdvsimdLoadStoreP01},
    {"AdvsimdLoadStoreP02", NULL, AdvsimdLoadStoreP02},
    {"AdvsimdLoadStoreP03", NULL, AdvsimdLoadStoreP03},
    {"AdvsimdLoadStoreP04", NULL, AdvsimdLoadStoreP04},
    {"AdvsimdLoadStoreP05", NULL, AdvsimdLoadStoreP05},
    {"AdvsimdLoadStoreP06", NULL, AdvsimdLoadStoreP06},
    {"AdvsimdLoadStoreP07", NULL, AdvsimdLoadStoreP07},
    {"FpsimdLoadStoreP01", NULL, FpsimdLoadStoreP01},
    {"FpsimdLoadStoreP02", NULL, FpsimdLoadStoreP02},
    {"GeneralLoadStoreP01", NULL, GeneralLoadStoreP01},
    {"GeneralLoadStoreP02", NULL, GeneralLoadStoreP02},
    {"GeneralLoadStoreP03", NULL, GeneralLoadStoreP03},
    {"GeneralLoadStoreP04", NULL, GeneralLoadStoreP04},
};

// GroupG
STATIC CpuTestcaseDetectSets g_cpuGroupGDetectSets[] = {
    {"BranchInGeneralP01", BranchInGeneralP01, NULL},
    {"BranchInGeneralP02", BranchInGeneralP02, NULL},

};

// GroupH
STATIC CpuTestcaseDetectSets g_cpuGroupHDetectSets[] = {
    {"DataReverseAdvsimdScalarP01", DataReverseAdvsimdScalarP01, NULL},
    {"DataReverseAdvsimdVectorP01", DataReverseAdvsimdVectorP01, NULL},
    {"DataReverseAdvsimdVectorP02", DataReverseAdvsimdVectorP02, NULL},
    {"DataReverseAdvsimdVectorP03", DataReverseAdvsimdVectorP03, NULL},
    {"DataReverseAdvsimdVectorP04", DataReverseAdvsimdVectorP04, NULL},
    {"DataReverseFloatP01", DataReverseFloatP01, NULL},
    {"DataReverseIntP01", DataReverseIntP01, NULL},
    {"EnhanceBranchP01", EnhanceBranchP01, NULL},
    {"EnhanceDependencyP01", EnhanceDependencyP01, NULL},
    {"EnhanceLoadStoreP01", NULL, EnhanceLoadStoreP01},
    {"EnhanceLoadStoreP02", NULL, EnhanceLoadStoreP02},
};

#endif

//print the debug info of CPU
STATIC void CpuDetectDumpBuf(uint32_t *regValues, int32_t len, int32_t cpu)
{
    const int32_t regSize = 4;
    const int32_t regNum = len / regSize;
    uint32_t *p = regValues;
    for (int32_t idx = 0; idx < regNum; idx++) {
        int32_t v = idx * regSize;
        ADETECT_ERR("cpu(%d) detect failed, X%02d:0x%08x_%08x X%02d:0x%08x_%08x",
                    cpu, (v / 2 + 1), p[v + 1], p[v], (v / 2 + 2), p[v + 3], p[v + 2]);  // 一个寄存器有4个字节，分别打印0\1\2\3字节
    }
}

STATIC bool CpuDetectCheckBuf(uint32_t *regValues, int32_t len)
{
    // if test fail, buf[1][0] will not be zero
    const int32_t retReg = 2;
    if ((len < retReg) || (regValues[0] != 0) || (regValues[1] != 0)) {
        return false;
    }
    return true;
}

STATIC CpudStatus CpuDetectGroupComm(const CpuTestcaseDetectSets *detectSet, uint32_t num, uint32_t *regValues,
                                     uint32_t *loadStoreBuf, int cpu)
{
    for (uint32_t i = 0; i < num; i++) {
        if ((detectSet[i].funcA == NULL) && (detectSet[i].funcB == NULL)) {
            continue;
        }
        // run testcase
        if (detectSet[i].funcA != NULL) {
            (void)memset_s(regValues, TEMP_BUF_SIZE, 0, TEMP_BUF_SIZE);
            detectSet[i].funcA(regValues);
        } else if (detectSet[i].funcB != NULL) {
            (void)memset_s(regValues, TEMP_BUF_SIZE, 0, TEMP_BUF_SIZE);
            (void)memset_s(loadStoreBuf, TEMP_BUF_SIZE, 0, TEMP_BUF_SIZE);
            detectSet[i].funcB(regValues, loadStoreBuf);
        }

        // check
        bool result = CpuDetectCheckBuf(regValues, TEMP_BUF_SIZE);
        if (!result) {
            ADETECT_ERR("cpu(%d) detection run testcase(%s) failed, reg[0] = %d, reg[1] = %d.", cpu, detectSet[i].name,
                        regValues[0], regValues[1]);
            CpuDetectDumpBuf(regValues, PRINT_TEMP_BUF_LEN, cpu);
            return CPUD_ERROR_TESTCASE;
        }
    }
    usleep(GROUP_GAP_TIME);
    return CPUD_SUCCESS;
}

CpudStatus CpuDetectGroupTaiShan(uint32_t *regValues, uint32_t *loadStoreBuf, int32_t cpu)
{
    const uint32_t num = sizeof(g_cpuGroupTaiShanDetectSets) / sizeof(CpuTestcaseDetectSets);
    return CpuDetectGroupComm(g_cpuGroupTaiShanDetectSets, num, regValues, loadStoreBuf, cpu);
}

CpudStatus CpuDetectGroupA(uint32_t *regValues, uint32_t *loadStoreBuf, int32_t cpu)
{
    const uint32_t num = sizeof(g_cpuGroupADetectSets) / sizeof(CpuTestcaseDetectSets);
    return CpuDetectGroupComm(g_cpuGroupADetectSets, num, regValues, loadStoreBuf, cpu);
}

CpudStatus CpuDetectGroupB(uint32_t *regValues, uint32_t *loadStoreBuf, int32_t cpu)
{
    const uint32_t num = sizeof(g_cpuGroupBDetectSets) / sizeof(CpuTestcaseDetectSets);
    return CpuDetectGroupComm(g_cpuGroupBDetectSets, num, regValues, loadStoreBuf, cpu);
}

CpudStatus CpuDetectGroupC(uint32_t *regValues, uint32_t *loadStoreBuf, int32_t cpu)
{
    const uint32_t num = sizeof(g_cpuGroupCDetectSets) / sizeof(CpuTestcaseDetectSets);
    return CpuDetectGroupComm(g_cpuGroupCDetectSets, num, regValues, loadStoreBuf, cpu);
}

CpudStatus CpuDetectGroupD(uint32_t *regValues, uint32_t *loadStoreBuf, int32_t cpu)
{
    const uint32_t num = sizeof(g_cpuGroupDDetectSets) / sizeof(CpuTestcaseDetectSets);
    return CpuDetectGroupComm(g_cpuGroupDDetectSets, num, regValues, loadStoreBuf, cpu);
}

CpudStatus CpuDetectGroupE(uint32_t *regValues, uint32_t *loadStoreBuf, int32_t cpu)
{
    const uint32_t num = sizeof(g_cpuGroupEDetectSets) / sizeof(CpuTestcaseDetectSets);
    return CpuDetectGroupComm(g_cpuGroupEDetectSets, num, regValues, loadStoreBuf, cpu);
}

CpudStatus CpuDetectGroupF(uint32_t *regValues, uint32_t *loadStoreBuf, int32_t cpu)
{
    const uint32_t num = sizeof(g_cpuGroupFDetectSets) / sizeof(CpuTestcaseDetectSets);
    return CpuDetectGroupComm(g_cpuGroupFDetectSets, num, regValues, loadStoreBuf, cpu);
}

CpudStatus CpuDetectGroupG(uint32_t *regValues, uint32_t *loadStoreBuf, int32_t cpu)
{
    const uint32_t num = sizeof(g_cpuGroupGDetectSets) / sizeof(CpuTestcaseDetectSets);
    return CpuDetectGroupComm(g_cpuGroupGDetectSets, num, regValues, loadStoreBuf, cpu);
}

CpudStatus CpuDetectGroupH(uint32_t *regValues, uint32_t *loadStoreBuf, int32_t cpu)
{
    const uint32_t num = sizeof(g_cpuGroupHDetectSets) / sizeof(CpuTestcaseDetectSets);
    return CpuDetectGroupComm(g_cpuGroupHDetectSets, num, regValues, loadStoreBuf, cpu);
}

CpudStatus CpuDetectGroup(uint32_t *regValues, uint32_t *loadStoreBuf, int32_t cpu)
{
    ADETECT_CHK_EXPR_ACTION((regValues == NULL) || (loadStoreBuf == NULL), return CPUD_ERROR_PARAM,
                            "invalid input param.");
    int32_t num = sizeof(g_cpuDetectSets) / sizeof(CpuGroupDetectSets);
    for (int32_t i = 0; i < num; i++) {
        if (g_cpuDetectSets[i].func == NULL) {
            continue;
        }
        CpudStatus ret = g_cpuDetectSets[i].func(regValues, loadStoreBuf, cpu);
        if (ret != CPUD_SUCCESS) {
            ADETECT_ERR("cpu(%d) run testcase group(%s) failed.", cpu, g_cpuDetectSets[i].name);
            return ret;
        }
    }
    return CPUD_SUCCESS;
}