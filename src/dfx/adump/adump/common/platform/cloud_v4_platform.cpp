/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "cloud_v4_platform.h"

#include <string>
#include "adump_platform_registry.h"
#include "kernel_pc_fixer.h"
#include "dump_common.h"
#include "acc_error_info.h"
#include "dump_core.h"

namespace Adx {

ADUMP_PLATFORM_REGISTER(FeaturesSupportInterface, PlatformType::CHIP_CLOUD_V4, CloudV4Features);
ADUMP_PLATFORM_REGISTER(CoredumpInterface, PlatformType::CHIP_CLOUD_V4, CloudV4Coredump);
ADUMP_PLATFORM_REGISTER(ExceptionDumpInterface, PlatformType::CHIP_CLOUD_V4, CloudV4Exception);
ADUMP_PLATFORM_REGISTER(DataDumpInterface, PlatformType::CHIP_CLOUD_V4, CloudV4DataDump);

namespace {
constexpr uint32_t MAX_AIC_CORE_COUNT = 36U;
constexpr uint32_t MAX_AIV_CORE_COUNT = 72U;
constexpr uint32_t MAX_ALL_CORE_COUNT = MAX_AIC_CORE_COUNT + MAX_AIV_CORE_COUNT;
constexpr size_t ADX_MAX_STR_LEN = 1024U * 1024U;
} // namespace

CloudV4Features::CloudV4Features()
{
    supported_ = {
        AdumpPlatformFeature::FEATURE_DATA_DUMP,         AdumpPlatformFeature::FEATURE_OVERFLOW_DUMP,
        AdumpPlatformFeature::FEATURE_EXCEPTION_DUMP_L0, AdumpPlatformFeature::FEATURE_EXCEPTION_DUMP_L1,
        AdumpPlatformFeature::FEATURE_CORE_DUMP,
    };
}

std::unique_ptr<PcFixerInterface> CloudV4Coredump::CreatePcFixer() const
{
    return std::unique_ptr<PcFixerInterface>(new (std::nothrow) CloudV4PcFixer());
}

std::shared_ptr<RegisterInterface> CloudV4Coredump::CreateRegister() const
{
    return std::make_shared<CloudV4Register>();
}

void CloudV4Coredump::DumpRegister(DumpCore& core, uint8_t coreType, uint16_t coreId) const
{
    core.DumpWideRegRegister(coreType, coreId);
}

uint16_t CloudV4Coredump::ConvertCoreId(uint8_t coreType, uint16_t coreId) const
{
    return (coreType == CORE_TYPE_AIC) ? coreId : static_cast<uint16_t>(MAX_AIC_CORE_COUNT + coreId);
}

bool CloudV4Exception::IsArgsDataTypeSizeByByte() const { return false; }

uint64_t CloudV4DataDump::GetKfcStackSize() const
{
    constexpr uint32_t op_stack_count = MAX_ALL_CORE_COUNT;
    return CalcKfcStackSize(op_stack_count);
}

std::vector<std::string> CloudV4DataDump::GetKfcBinNames() const
{
    return {"dump_stat_op_ascend950.o", "kfc_dump_stat_ascend950.o"};
}

bool CloudV4DataDump::IsUbFromAiCore() const { return true; }

size_t CloudV4DataDump::GetCoreTypeIDOffset() const { return MAX_AIV_CORE_COUNT; }

size_t CloudV4DataDump::GetBlockNum() const { return MAX_ALL_CORE_COUNT; }

int32_t CloudV4DataDump::GetStreamSyncTimeout() const
{
    constexpr int32_t ADX_DAVID_TIMEOUT = 60000 * 30;
    return ADX_DAVID_TIMEOUT;
}

bool CloudV4DataDump::IsSimtDumpEnabled(size_t dumpWorkSpaceSize) const
{
    return dumpWorkSpaceSize > GetBlockNum() * ADX_MAX_STR_LEN;
}

// ========== 寄存器配置实现 ==========

CloudV4Register::CloudV4Register()
{
    InitAicAivRegisters();
    registerTypeMap_ = {
        {CORE_TYPE_AIC, {RegisterType::AIC, RegisterType::AIC_DBG}},
        {CORE_TYPE_AIV, {RegisterType::AIV, RegisterType::AIV_DBG}}};
}

CloudV4Register::CloudV4Register(bool) {}

// V4/V5 公共错误寄存器表（32 条）：V4 全量即此表；V5 在此基础上追加特有条目。
std::vector<ErrorRegisterTable> CloudV4Register::GenCommonErrorRegisters()
{
    return {
        {RT_V200_SC_ERROR_T0_0, 0x4700, 4, "SC_ERROR_T0_0"},
        {RT_V200_SC_ERR_INFO_T0_0, 0x4730, 4, "SC_ERR_INFO_T0_0"},
        {RT_V200_SC_ERR_INFO_T0_1, 0x4734, 4, "SC_ERR_INFO_T0_1"},
        {RT_V200_SU_ERROR_T0_0, 0x5700, 4, "SU_ERROR_T0_0"},
        {RT_V200_SU_ERR_INFO_T0_0, 0x5730, 4, "SU_ERR_INFO_T0_0"},
        {RT_V200_SU_ERR_INFO_T0_1, 0x5734, 4, "SU_ERR_INFO_T0_1"},
        {RT_V200_SU_ERR_INFO_T0_2, 0x5738, 4, "SU_ERR_INFO_T0_2"},
        {RT_V200_SU_ERR_INFO_T0_3, 0x573C, 4, "SU_ERR_INFO_T0_3"},
        {RT_V200_MTE_ERROR_T0_0, 0x6700, 4, "MTE_ERROR_T0_0"},
        {RT_V200_MTE_ERROR_T1_0, 0x6708, 4, "MTE_ERROR_T1_0"},
        {RT_V200_MTE_ERR_INFO_T0_0, 0x6718, 4, "MTE_ERR_INFO_T0_0"},
        {RT_V200_MTE_ERR_INFO_T0_1, 0x671C, 4, "MTE_ERR_INFO_T0_1"},
        {RT_V200_MTE_ERR_INFO_T0_2, 0x6720, 4, "MTE_ERR_INFO_T0_2"},
        {RT_V200_MTE_ERR_INFO_T1_0, 0x6724, 4, "MTE_ERR_INFO_T1_0"},
        {RT_V200_MTE_ERR_INFO_T1_1, 0x6728, 4, "MTE_ERR_INFO_T1_1"},
        {RT_V200_MTE_ERR_INFO_T1_2, 0x673C, 4, "MTE_ERR_INFO_T1_2"},
        {RT_V200_VEC_ERROR_T0_0, 0x7700, 4, "VEC_ERROR_T0_0"},
        {RT_V200_VEC_ERROR_T0_2, 0x7708, 4, "VEC_ERROR_T0_2"},
        {RT_V200_VEC_ERR_INFO_T0_0, 0x7730, 4, "VEC_ERR_INFO_T0_0"},
        {RT_V200_VEC_ERR_INFO_T0_1, 0x7734, 4, "VEC_ERR_INFO_T0_1"},
        {RT_V200_VEC_ERR_INFO_T0_2, 0x7738, 4, "VEC_ERR_INFO_T0_2"},
        {RT_V200_VEC_ERR_INFO_T0_3, 0x773C, 4, "VEC_ERR_INFO_T0_3"},
        {RT_V200_VEC_ERR_INFO_T0_4, 0x7740, 4, "VEC_ERR_INFO_T0_4"},
        {RT_V200_VEC_ERR_INFO_T0_5, 0x7744, 4, "VEC_ERR_INFO_T0_5"},
        {RT_V200_CUBE_ERROR_T0_0, 0x8700, 4, "CUBE_ERROR_T0_0"},
        {RT_V200_CUBE_ERROR_T0_1, 0x8704, 4, "CUBE_ERROR_T0_1"},
        {RT_V200_CUBE_ERR_INFO_T0_0, 0x8730, 4, "CUBE_ERR_INFO_T0_0"},
        {RT_V200_CUBE_ERR_INFO_T0_1, 0x8734, 4, "CUBE_ERR_INFO_T0_1"},
        {RT_V200_L1_ERROR_T0_0, 0xA700, 4, "L1_ERROR_T0_0"},
        {RT_V200_L1_ERROR_T0_1, 0xA704, 4, "L1_ERROR_T0_1"},
        {RT_V200_L1_ERR_INFO_T0_0, 0xA718, 4, "L1_ERR_INFO_T0_0"},
        {RT_V200_L1_ERR_INFO_T0_1, 0xA71C, 4, "L1_ERR_INFO_T0_1"},
    };
}

void CloudV4Register::InitErrorRegisters() { ErrorRegisterMap_ = GenCommonErrorRegisters(); }

// AIC SU Debug 寄存器（模块类型 0x1）。
std::vector<RegisterTable> CloudV4Register::GenAicDbgRegSuAddr()
{
    auto tab = SuDbgRegHeadAddr();
    tab.emplace_back(0X16800000000000, 32, 8);
    return tab;
}

// AIC MTE Debug 寄存器（模块类型 0x2）。
std::vector<RegisterTable> CloudV4Register::GenAicDbgRegMteAddr()
{
    return {
        {0X21000000000000, 1, 8}, {0X22000000000000, 2, 8}, {0X22000000000003, 4, 8},
        {0X22000000000012, 1, 8}, {0X22000000000014, 1, 8},
    };
}

// AIC CUBE Debug 寄存器（模块类型 0x4）。
std::vector<RegisterTable> CloudV4Register::GenAicDbgRegCubeAddr()
{
    return {
        {0X40000000000000, 8, 8}, {0X40000000000008, 8, 8}, {0X40000000000010, 8, 8}, {0X40000000000018, 8, 8},
        {0X40000000000020, 8, 8}, {0X40000000000028, 8, 8}, {0X40000000000030, 8, 8}, {0X40000000000038, 8, 8},
        {0X40000000000040, 8, 8}, {0X40000000000048, 8, 8}, {0X40000000000050, 8, 8}, {0X40000000000058, 8, 8},
        {0X40000000000060, 8, 8},
    };
}

// AIC L1 Debug 寄存器（模块类型 0x6）。
std::vector<RegisterTable> CloudV4Register::GenAicDbgRegL1Addr()
{
    return {
        {0X60000000000000, 10, 8},
        {0X61000000000000, 11, 8},
        {0X67000000000000, 1, 8},
    };
}

// AIC DFX 寄存器：SC(0x8) + SU(0x9) + MTE(0xa) + CUBE(0xc) + BIF(0xd) + L1(0xe)。
std::vector<RegisterTable> CloudV4Register::GenAicDfxRegAddr()
{
    std::vector<RegisterTable> tab = ScSuDfxAddr();
    // MTE(0xa) + CUBE(0xc) + BIF(0xd) + L1(0xe)
    static const std::vector<RegisterTable> tail = {
        {0Xa0000000000000, 3, 8}, {0Xa0000000000100, 3, 8},  {0Xa0000000000200, 3, 8},  {0Xa0000000001000, 1, 8},
        {0Xa0000000001100, 1, 8}, {0Xa0000000001200, 1, 8},  {0Xa0000000002100, 2, 8},  {0Xa0000000002200, 2, 8},
        {0Xa0000000003000, 1, 8}, {0Xa0000000008100, 3, 8},  {0Xc0000000000000, 16, 8}, {0Xd0000000000000, 1, 8},
        {0Xd0000000000008, 1, 8}, {0Xd0000000000010, 1, 8},  {0Xd0000000000018, 1, 8},  {0Xd0000000000020, 1, 8},
        {0Xd0000000000028, 1, 8}, {0Xd0000000000030, 1, 8},  {0Xd0000000000038, 1, 8},  {0Xe0000000000000, 5, 8},
        {0Xe0000000000100, 3, 8}, {0Xe0000000000200, 6, 8},  {0Xe0000000000300, 2, 8},  {0Xe0000000000400, 1, 8},
        {0Xe0000000000500, 9, 8}, {0Xe0000000000600, 16, 8},
    };
    tab.insert(tab.end(), tail.begin(), tail.end());
    return tab;
}

// AIV SU Debug 寄存器（模块类型 0x1）。
std::vector<RegisterTable> CloudV4Register::GenAivDbgRegSuAddr()
{
    auto tab = SuDbgRegHeadAddr();
    tab.emplace_back(0X16800000000000, 16, 8);
    return tab;
}

// AIV MTE Debug 寄存器（模块类型 0x2）。
std::vector<RegisterTable> CloudV4Register::GenAivDbgRegMteAddr()
{
    return {
        {0X21000000000000, 1, 8}, {0X22000000000002, 1, 8}, {0X22000000000007, 3, 8},
        {0X2200000000000d, 3, 8}, {0X22000000000016, 9, 8},
    };
}

// AIV VEC Debug 寄存器（模块类型 0x3）。
std::vector<RegisterTable> CloudV4Register::GenAivDbgRegVecAddr()
{
    std::vector<RegisterTable> tab = VecDbgRegHeadAddr();
    static const std::vector<RegisterTable> mid = {
        {0X32000000000400, 24, 32}, {0X32000000000440, 24, 32}, {0X32000000000480, 24, 32}, {0X320000000004c0, 24, 32},
        {0X32000000000600, 4, 32},  {0X32000000000800, 4, 32},  {0X32000000000804, 4, 8},   {0X32000000000a00, 64, 8},
        {0X32000000000c00, 8, 16},  {0X32000000000e00, 8, 8},   {0X32000000001000, 4, 8},   {0X32000000001200, 1, 16},
        {0X32000000001400, 1, 8},   {0X32000000001600, 1, 8},   {0X32000000001800, 1, 8},   {0X32000000001a00, 1, 32},
        {0X32000000001c00, 1, 8},   {0X32000000001e00, 1, 8},   {0X32000000002000, 64, 8},  {0X32000000002200, 4, 8},
        {0X32000000002400, 9, 32},  {0X32000000002600, 5, 32},  {0X32000000002608, 5, 32},  {0X32000000002800, 1, 32},
        {0X32000000002804, 3, 32},  {0X32000000002808, 1, 32},  {0X3200000000280c, 1, 32},  {0X32000000002a00, 2, 16},
        {0X32000000002c00, 1, 8},
    };
    // 公共尾段 + V4 特有扩展（0x8000/0xc000/0x10000）。
    auto tail = VecDbgRegTailAddr();
    auto tailExtra = VecDbgRegTailExtraAddr();
    tab.insert(tab.end(), mid.begin(), mid.end());
    tab.insert(tab.end(), tail.begin(), tail.end());
    tab.insert(tab.end(), tailExtra.begin(), tailExtra.end());
    return tab;
}

// AIV DFX 寄存器：SC(0x8) + SU(0x9) + MTE(0xa) + VEC(0xb) + BIF(0xd)。
std::vector<RegisterTable> CloudV4Register::GenAivDfxRegAddr()
{
    std::vector<RegisterTable> tab = ScSuDfxAddr();
    // MTE(0xa)
    static const std::vector<RegisterTable> mte = {
        {0Xa0000000000000, 3, 8}, {0Xa0000000000100, 3, 8}, {0Xa0000000000200, 3, 8}, {0Xa0000000001000, 1, 8},
        {0Xa0000000001100, 1, 8}, {0Xa0000000001200, 1, 8}, {0Xa0000000002100, 2, 8}, {0Xa0000000002200, 2, 8},
        {0Xa0000000003000, 1, 8}, {0Xa0000000008100, 3, 8},
    };
    auto vecSeg = VecDfxAddr();
    // BIF(0xd)
    static const std::vector<RegisterTable> bif = {
        {0Xd0000000000000, 1, 8}, {0Xd0000000000008, 1, 8}, {0Xd0000000000010, 1, 8}, {0Xd0000000000018, 1, 8},
        {0Xd0000000000020, 1, 8}, {0Xd0000000000028, 1, 8}, {0Xd0000000000030, 1, 8}, {0Xd0000000000038, 1, 8},
    };
    tab.insert(tab.end(), mte.begin(), mte.end());
    tab.insert(tab.end(), vecSeg.begin(), vecSeg.end());
    tab.insert(tab.end(), bif.begin(), bif.end());
    return tab;
}

void CloudV4Register::GenAICOffsetAddr()
{
    std::vector<RegisterTable> tab = {
        {0X80, 30, 4},   {0X1000, 3, 4}, {0X11f0, 1, 4},  {0X1200, 2, 4}, {0X1210, 1, 4},  {0X1400, 5, 4},
        {0X1500, 4, 4},  {0X2000, 1, 4}, {0X2010, 1, 4},  {0X2020, 1, 4}, {0X2030, 2, 4},  {0X2400, 1, 4},
        {0X2410, 2, 4},  {0X2808, 1, 4}, {0X4000, 5, 4},  {0X4020, 9, 4}, {0X4050, 4, 4},  {0X4070, 2, 4},
        {0X40f0, 2, 4},  {0X4140, 1, 4}, {0X4200, 4, 4},  {0X4260, 4, 4}, {0X42a0, 6, 4},  {0X4700, 1, 4},
        {0X4720, 1, 4},  {0X4730, 2, 4}, {0X4750, 3, 4},  {0X4760, 1, 4}, {0X48a0, 3, 4},  {0X48b0, 1, 4},
        {0X4980, 1, 4},  {0X4990, 1, 4}, {0X4998, 1, 4},  {0X5000, 1, 4}, {0X5008, 2, 4},  {0X5020, 2, 4},
        {0X5030, 1, 4},  {0X5040, 2, 4}, {0X5050, 3, 4},  {0X5060, 1, 4}, {0X50f0, 1, 4},  {0X5100, 19, 4},
        {0X5200, 2, 4},  {0X5300, 3, 4}, {0X5310, 1, 4},  {0X5320, 8, 4}, {0X53a0, 4, 4},  {0X5600, 3, 4},
        {0X5700, 1, 4},  {0X5720, 1, 4}, {0X5730, 4, 4},  {0X5900, 1, 4}, {0X5910, 1, 4},  {0X5920, 2, 4},
        {0X5930, 2, 4},  {0X5a00, 3, 4}, {0X5a80, 2, 4},  {0X6000, 2, 4}, {0X6020, 6, 4},  {0X6600, 2, 4},
        {0X6700, 1, 4},  {0X6708, 1, 4}, {0X6710, 1, 4},  {0X6718, 5, 4}, {0X673c, 1, 4},  {0X6900, 3, 4},
        {0X6910, 3, 4},  {0X6a00, 4, 4}, {0X6a18, 1, 4},  {0X6b04, 1, 4}, {0X6b0c, 3, 4},  {0X8000, 11, 4},
        {0X8030, 6, 4},  {0X8050, 9, 4}, {0X8080, 1, 4},  {0X8088, 6, 4}, {0X8100, 2, 4},  {0X8200, 3, 4},
        {0X8218, 1, 4},  {0X8230, 4, 4}, {0X8700, 2, 4},  {0X8720, 2, 4}, {0X8730, 2, 4},  {0X8900, 1, 4},
        {0X8920, 1, 4},  {0X8930, 2, 4}, {0X8940, 1, 4},  {0X9000, 4, 4}, {0X9014, 14, 4}, {0X9050, 4, 4},
        {0X9090, 3, 4},  {0X9200, 7, 4}, {0X9220, 11, 4}, {0X9300, 7, 4}, {0X9320, 4, 4},  {0X9500, 1, 4},
        {0X9600, 1, 4},  {0Xa000, 3, 4}, {0Xa020, 2, 4},  {0Xa600, 2, 4}, {0Xa700, 2, 4},  {0Xa710, 4, 4},
        {0Xa900, 1, 4},  {0Xa908, 1, 4}, {0Xa910, 1, 4},  {0Xaa00, 1, 4}, {0Xb000, 14, 4}, {0Xb070, 2, 4},
        {0Xb080, 14, 4},
    };
    registerTableMap_[RegisterType::AIC] = std::move(tab);
}

void CloudV4Register::GenAIVOffsetAddr()
{
    std::vector<RegisterTable> tab = {
        {0X80, 30, 4},   {0X1000, 3, 4},  {0X11f0, 1, 4},  {0X1200, 2, 4}, {0X1210, 1, 4}, {0X1400, 5, 4},
        {0X1500, 4, 4},  {0X2000, 1, 4},  {0X2010, 1, 4},  {0X2020, 1, 4}, {0X2030, 2, 4}, {0X2400, 1, 4},
        {0X4020, 9, 4},  {0X4050, 4, 4},  {0X4070, 2, 4},  {0X2410, 2, 4}, {0X2808, 1, 4}, {0X4000, 5, 4},
        {0X40f0, 2, 4},  {0X4140, 1, 4},  {0X4200, 4, 4},  {0X4260, 4, 4}, {0X42a0, 6, 4}, {0X4700, 1, 4},
        {0X4760, 1, 4},  {0X48a0, 3, 4},  {0X48b0, 1, 4},  {0X4720, 1, 4}, {0X4730, 2, 4}, {0X4750, 3, 4},
        {0X4980, 1, 4},  {0X4990, 1, 4},  {0X4998, 1, 4},  {0X5000, 1, 4}, {0X5008, 2, 4}, {0X5020, 2, 4},
        {0X5030, 1, 4},  {0X5040, 2, 4},  {0X5050, 3, 4},  {0X5060, 1, 4}, {0X50f0, 1, 4}, {0X5100, 19, 4},
        {0X5200, 2, 4},  {0X5300, 3, 4},  {0X5310, 1, 4},  {0X5320, 8, 4}, {0X53a0, 4, 4}, {0X5600, 3, 4},
        {0X5700, 1, 4},  {0X5720, 1, 4},  {0X5730, 4, 4},  {0X5900, 1, 4}, {0X5910, 1, 4}, {0X5920, 2, 4},
        {0X5930, 2, 4},  {0X5a00, 3, 4},  {0X5a80, 2, 4},  {0X6000, 2, 4}, {0X6020, 6, 4}, {0X6600, 2, 4},
        {0X6700, 1, 4},  {0X6708, 1, 4},  {0X6710, 1, 4},  {0X6718, 5, 4}, {0X673c, 1, 4}, {0X6900, 3, 4},
        {0X6910, 3, 4},  {0X6a00, 4, 4},  {0X6a18, 1, 4},  {0X6b04, 1, 4}, {0X6b0c, 3, 4}, {0X7004, 6, 4},
        {0X7030, 1, 4},  {0X7040, 3, 4},  {0X7080, 3, 4},  {0X70c0, 2, 4}, {0X7100, 6, 4}, {0X7200, 7, 4},
        {0X7700, 1, 4},  {0X7708, 1, 4},  {0X7720, 1, 4},  {0X7728, 1, 4}, {0X7730, 6, 4}, {0X7900, 1, 4},
        {0X7920, 1, 4},  {0X9000, 4, 4},  {0X9014, 14, 4}, {0X9050, 4, 4}, {0X9090, 3, 4}, {0X9200, 7, 4},
        {0X9220, 11, 4}, {0X9300, 7, 4},  {0X9320, 4, 4},  {0X9500, 1, 4}, {0X9600, 1, 4}, {0Xb000, 14, 4},
        {0Xb070, 2, 4},  {0Xb080, 14, 4},
    };
    registerTableMap_[RegisterType::AIV] = std::move(tab);
}

// V4 平台内部共享段：SU Debug 寄存器前 6 条（模块类型 0x1；末段 0x16800... 的 num 因核而异）。
std::vector<RegisterTable> CloudV4Register::SuDbgRegHeadAddr()
{
    return {
        {0X10000000000000, 32, 8}, {0X10000000000040, 15, 8}, {0X10000000000080, 12, 8},
        {0X15000000000000, 32, 8}, {0X15800000000000, 32, 8}, {0X16000000000000, 16, 8},
    };
}

// V4 平台内部共享段：SC(0x8) + SU(0x9) DFX 寄存器（AIC/AIV 共用）。
std::vector<RegisterTable> CloudV4Register::ScSuDfxAddr()
{
    return {
        {0X80000000000000, 5, 8},  {0X90000000000000, 9, 8}, {0X90000000000040, 8, 8},
        {0X90000000000080, 13, 8}, {0X900000000000c0, 8, 8},
    };
}

// V4 平台内部共享段：VEC DFX 寄存器（模块类型 0xb，AIC/AIV 共用）。
std::vector<RegisterTable> CloudV4Register::VecDfxAddr()
{
    return {
        {0Xb0000000000000, 1, 8}, {0Xb0000000000008, 1, 8}, {0Xb0000000000010, 1, 8}, {0Xb0000000000018, 1, 8},
        {0Xb0000000000020, 1, 8}, {0Xb0000000000040, 1, 8}, {0Xb0000000000080, 1, 8}, {0Xb00000000000c0, 1, 8},
        {0Xb0000000000100, 1, 8}, {0Xb0000000000140, 1, 8}, {0Xb0000000000180, 1, 8}, {0Xb00000000001c0, 1, 8},
        {0Xb00000000001c8, 1, 8}, {0Xb0000000000200, 1, 8}, {0Xb0000000000240, 1, 8}, {0Xb0000000000280, 1, 8},
        {0Xb0000000000288, 1, 8}, {0Xb0000000000290, 1, 8}, {0Xb00000000002c0, 1, 8}, {0Xb00000000002c8, 1, 8},
        {0Xb0000000000300, 1, 8}, {0Xb0000000000340, 1, 8},
    };
}

// V4 平台内部共享段：VEC Debug 寄存器头段（模块类型 0x3，高段 0x32）。
std::vector<RegisterTable> CloudV4Register::VecDbgRegHeadAddr()
{
    return {
        {0X32000000000000, 8, 32}, {0X32000000000010, 8, 32}, {0X32000000000020, 8, 32}, {0X32000000000030, 8, 32},
        {0X32000000000040, 8, 32}, {0X32000000000050, 8, 32}, {0X32000000000060, 8, 32}, {0X32000000000070, 8, 32},
        {0X32000000000080, 8, 32}, {0X32000000000090, 8, 32}, {0X320000000000a0, 8, 32}, {0X320000000000b0, 8, 32},
        {0X320000000000c0, 8, 32}, {0X320000000000d0, 8, 32}, {0X320000000000e0, 8, 32}, {0X320000000000f0, 8, 32},
        {0X32000000000100, 8, 32}, {0X32000000000110, 8, 32}, {0X32000000000120, 8, 32}, {0X32000000000130, 8, 32},
        {0X32000000000140, 8, 32}, {0X32000000000150, 8, 32}, {0X32000000000160, 8, 32}, {0X32000000000170, 8, 32},
        {0X32000000000180, 8, 32}, {0X32000000000190, 8, 32}, {0X320000000001a0, 8, 32}, {0X320000000001b0, 8, 32},
        {0X320000000001c0, 8, 32}, {0X320000000001d0, 8, 32}, {0X320000000001e0, 8, 32}, {0X320000000001f0, 8, 32},
        {0X32000000000200, 1, 32}, {0X32000000000202, 1, 32}, {0X32000000000204, 1, 32}, {0X32000000000206, 1, 32},
        {0X32000000000208, 1, 32}, {0X3200000000020a, 1, 32}, {0X3200000000020c, 1, 32}, {0X3200000000020e, 1, 32},
    };
}

// V4 平台内部共享段：VEC Debug 寄存器尾段（模块类型 0x3，高段 0x39）。
// V4/V5 公共 VEC Debug 尾段（0x39 段，不含 0x8000/0xc000/0x10000 三组 V4 特有条目）。
std::vector<RegisterTable> CloudV4Register::VecDbgRegTailAddr()
{
    return {
        {0X39000000000000, 5, 8},    {0X39000000004000, 64, 8},   {0X39000000014000, 128, 32},
        {0X39000000014080, 128, 32}, {0X39000000014100, 128, 32}, {0X39000000014180, 128, 32},
        {0X39000000014200, 128, 32}, {0X39000000014280, 128, 32}, {0X39000000014300, 128, 32},
        {0X39000000014380, 128, 32}, {0X39000000014400, 128, 32}, {0X39000000014480, 128, 32},
        {0X39000000014500, 128, 32}, {0X39000000014580, 128, 32}, {0X39000000014600, 128, 32},
        {0X39000000014680, 128, 32}, {0X39000000014700, 128, 32}, {0X39000000014780, 128, 32},
        {0X39000000014800, 128, 32}, {0X39000000014880, 128, 32}, {0X39000000014900, 128, 32},
        {0X39000000014980, 128, 32}, {0X39000000014a00, 128, 32}, {0X39000000014a80, 128, 32},
        {0X39000000014b00, 128, 32}, {0X39000000014b80, 128, 32}, {0X39000000014c00, 128, 32},
        {0X39000000014c80, 128, 32}, {0X39000000014d00, 128, 32}, {0X39000000014d80, 128, 32},
        {0X39000000014e00, 128, 32}, {0X39000000014e80, 128, 32}, {0X39000000014f00, 128, 32},
        {0X39000000014f80, 128, 32}, {0X39000000018000, 512, 8},  {0X3900000001c000, 64, 8},
    };
}

// V4 特有的 VEC Debug 尾段扩展（0x8000/0xc000/0x10000 三组，V5 无）。
std::vector<RegisterTable> CloudV4Register::VecDbgRegTailExtraAddr()
{
    return {
        {0X39000000008000, 128, 32},
        {0X3900000000c000, 128, 32},
        {0X39000000010000, 128, 32},
    };
}
} // namespace Adx
