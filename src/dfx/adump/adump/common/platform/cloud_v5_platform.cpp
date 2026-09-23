/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "cloud_v5_platform.h"

#include "adump_platform_registry.h"
#include "dump_common.h"
#include "acc_error_info.h"
#include "kernel_pc_fixer.h"

namespace Adx {

ADUMP_PLATFORM_REGISTER(FeaturesSupportInterface, PlatformType::CHIP_CLOUD_V5, CloudV5Features);
ADUMP_PLATFORM_REGISTER(CoredumpInterface, PlatformType::CHIP_CLOUD_V5, CloudV5Coredump);
ADUMP_PLATFORM_REGISTER(ExceptionDumpInterface, PlatformType::CHIP_CLOUD_V5, CloudV5Exception);
ADUMP_PLATFORM_REGISTER(DataDumpInterface, PlatformType::CHIP_CLOUD_V5, CloudV5DataDump);

namespace {
constexpr uint32_t MAX_AIC_CORE_COUNT = 70U;
constexpr uint32_t MAX_AIV_CORE_COUNT = 70U;
constexpr uint32_t MAX_ALL_CORE_COUNT = MAX_AIC_CORE_COUNT + MAX_AIV_CORE_COUNT;
} // namespace

CloudV5Features::CloudV5Features()
{
    supported_ = {
        AdumpPlatformFeature::FEATURE_DATA_DUMP,         AdumpPlatformFeature::FEATURE_OVERFLOW_DUMP,
        AdumpPlatformFeature::FEATURE_EXCEPTION_DUMP_L0, AdumpPlatformFeature::FEATURE_EXCEPTION_DUMP_L1,
        AdumpPlatformFeature::FEATURE_CORE_DUMP,
    };
}

std::unique_ptr<PcFixerInterface> CloudV5Coredump::CreatePcFixer() const
{
    return std::unique_ptr<PcFixerInterface>(new (std::nothrow) CloudV5PcFixer());
}

std::shared_ptr<RegisterInterface> CloudV5Coredump::CreateRegister() const
{
    return std::make_shared<CloudV5Register>();
}

uint16_t CloudV5Coredump::ConvertCoreId(uint8_t coreType, uint16_t coreId) const
{
    return (coreType == CORE_TYPE_AIC) ? coreId : static_cast<uint16_t>(MAX_AIC_CORE_COUNT + coreId);
}

uint64_t CloudV5DataDump::GetKfcStackSize() const
{
    constexpr uint32_t op_stack_count = MAX_ALL_CORE_COUNT;
    return CalcKfcStackSize(op_stack_count);
}

std::vector<std::string> CloudV5DataDump::GetKfcBinNames() const
{
    return {"dump_stat_op_ascend960.o", "kfc_dump_stat_ascend960.o"};
}

size_t CloudV5DataDump::GetCoreTypeIDOffset() const { return MAX_AIV_CORE_COUNT; }

size_t CloudV5DataDump::GetBlockNum() const { return MAX_ALL_CORE_COUNT; }

// ========== 寄存器配置实现 ==========

CloudV5Register::CloudV5Register() : CloudV4Register(true) // 跳过基类 V4 表构建，仅构建 V5 布局
{
    InitAicAivRegisters();
    registerTypeMap_[CORE_TYPE_AIC].push_back(RegisterType::AIC);
    registerTypeMap_[CORE_TYPE_AIC].push_back(RegisterType::AIC_DBG);
    registerTypeMap_[CORE_TYPE_AIV].push_back(RegisterType::AIV);
    registerTypeMap_[CORE_TYPE_AIV].push_back(RegisterType::AIV_DBG);
}

void CloudV5Register::InitErrorRegisters()
{
    ErrorRegisterMap_ = GenCommonErrorRegisters();
    // 追加 V5 特有的 SU/VEC 扩展条目（公共 32 条见 CloudV4Register::GenCommonErrorRegister）。
    static const std::vector<ErrorRegisterTable> v5Only = {
        {RT_V200_SU_ERROR_T0_1, 0x5704, 4, "SU_ERROR_T0_1"},
        {RT_V200_SU_ERR_INFO_T0_4, 0x5740, 4, "SU_ERR_INFO_T0_4"},
        {RT_V200_SU_ERR_INFO_T0_5, 0x5744, 4, "SU_ERR_INFO_T0_5"},
        {RT_V200_SU_ERR_INFO_T0_6, 0x5748, 4, "SU_ERR_INFO_T0_6"},
        {RT_V200_SU_ERR_INFO_T0_7, 0x574C, 4, "SU_ERR_INFO_T0_7"},
        {RT_V200_VEC_ERR_INFO_T0_6, 0x7748, 4, "VEC_ERR_INFO_T0_6"},
    };
    ErrorRegisterMap_.insert(ErrorRegisterMap_.end(), v5Only.begin(), v5Only.end());
}

// AIC SU Debug 寄存器（模块类型 0x1）。
std::vector<RegisterTable> CloudV5Register::GenAicDbgRegSuAddr()
{
    return {
        {0X10000000000000, 32, 8}, {0X10000000000040, 10, 8}, {0X1000000000004b, 4, 8},  {0X10000000000084, 5, 8},
        {0X15000000000000, 32, 8}, {0X15800000000000, 32, 8}, {0X16000000000000, 16, 8}, {0X16800000000000, 32, 8},
        {0X18000000000000, 32, 8}, {0X19000000000010, 12, 8}, {0X19000000000020, 12, 8}, {0X19000000000030, 12, 8},
        {0X19000000000040, 12, 8}, {0X19000000000050, 12, 8}, {0X19000000000060, 12, 8},
    };
}

// AIC MTE Debug 寄存器（模块类型 0x2）。
std::vector<RegisterTable> CloudV5Register::GenAicDbgRegMteAddr()
{
    return {
        {0X21000000000000, 1, 8}, {0X22000000000000, 1, 8}, {0X22000000000003, 4, 8},
        {0X22000000000012, 1, 8}, {0X22000000000014, 1, 8},
    };
}

// AIC CUBE Debug 寄存器（模块类型 0x4）。
std::vector<RegisterTable> CloudV5Register::GenAicDbgRegCubeAddr()
{
    return {
        {0X48000000000000, 512, 8}, {0X48000000000200, 512, 8}, {0X48000000000400, 512, 8}, {0X48000000000600, 512, 8},
        {0X48000000000800, 512, 8}, {0X48000000000a00, 512, 8}, {0X48000000000c00, 512, 8}, {0X48000000000e00, 512, 8},
        {0X48000000001000, 512, 8}, {0X48000000001200, 512, 8}, {0X48000000001400, 512, 8}, {0X48000000001600, 512, 8},
        {0X48000000001800, 512, 8}, {0X48000000001a00, 512, 8}, {0X48000000001c00, 512, 8}, {0X48000000001e00, 512, 8},
        {0X48000000002000, 512, 8}, {0X48000000002200, 512, 8}, {0X48000000002400, 512, 8}, {0X48000000002600, 512, 8},
        {0X48000000002800, 512, 8}, {0X48000000002a00, 512, 8}, {0X48000000002c00, 512, 8}, {0X48000000002e00, 512, 8},
    };
}

// AIC L1 Debug 寄存器（模块类型 0x6）。
std::vector<RegisterTable> CloudV5Register::GenAicDbgRegL1Addr()
{
    return {
        {0X60000000000000, 10, 8},
        {0X61000000000000, 10, 8},
        {0X67000000000000, 1, 8},
    };
}

// AIC DFX 寄存器：SC+SU(0x8/0x9) + MTE(0xa) + CUBE(0xc) + BIF(0xd) + L1(0xe)。
std::vector<RegisterTable> CloudV5Register::GenAicDfxRegAddr()
{
    std::vector<RegisterTable> tab = ScSuDfxAddr();
    // MTE(0xa) + CUBE(0xc) + BIF 低段(0xd)
    static const std::vector<RegisterTable> mid = {
        {0Xa0000000000000, 4, 8}, {0Xa0000000001000, 4, 8}, {0Xa0000000008000, 83, 8}, {0Xa000000000c000, 2, 8},
        {0Xa000000000d000, 2, 8}, {0Xc0000000000000, 4, 8}, {0Xc0000000000006, 2, 8},  {0Xc000000000000c, 4, 8},
        {0Xd0000000000000, 1, 8}, {0Xd0000000000008, 1, 8}, {0Xd0000000000010, 1, 8},  {0Xd0000000000018, 1, 8},
        {0Xd0000000000020, 1, 8}, {0Xd0000000000028, 1, 8}, {0Xd0000000000030, 1, 8},  {0Xd0000000000038, 1, 8},
        {0Xd0000000000040, 1, 8}, {0Xd0000000000048, 1, 8}, {0Xd0000000000050, 1, 8},  {0Xd0000000000058, 1, 8},
        {0Xd0000000000060, 1, 8}, {0Xd0000000000068, 1, 8},
    };
    // L1(0xe)
    static const std::vector<RegisterTable> l1 = {
        {0Xe0000000000000, 5, 8}, {0Xe0000000000100, 3, 8},  {0Xe0000000000200, 1, 8},
        {0Xe0000000000500, 9, 8}, {0Xe0000000000600, 16, 8},
    };
    tab.insert(tab.end(), mid.begin(), mid.end());
    // BIF 高段: 0xd0000000100000 起，步进 0x10000 共 80 个，每个独立条目(单次 RTS 读不超 4096 字节)
    GenAddrByStep(tab, 0Xd0000000100000, 80, 8, 0X10000);
    tab.insert(tab.end(), l1.begin(), l1.end());
    return tab;
}

// AIV SU Debug 寄存器（模块类型 0x1）。
std::vector<RegisterTable> CloudV5Register::GenAivDbgRegSuAddr()
{
    return {
        {0X10000000000000, 32, 8}, {0X10000000000040, 10, 8}, {0X1000000000004b, 4, 8},  {0X10000000000080, 4, 8},
        {0X10000000000086, 1, 8},  {0X10000000000088, 2, 8},  {0X15000000000000, 32, 8}, {0X15800000000000, 32, 8},
        {0X16000000000000, 16, 8}, {0X16800000000000, 16, 8}, {0X18000000000000, 32, 8}, {0X19000000000000, 12, 8},
    };
}

// AIV VEC Debug 寄存器（模块类型 0x3，高段 0x32 主体 + 0x39 尾段）。
std::vector<RegisterTable> CloudV5Register::GenAivDbgRegVecAddr()
{
    std::vector<RegisterTable> tab = VecDbgRegHeadAddr();
    static const std::vector<RegisterTable> mid = {
        {0X32000000000600, 4, 32}, {0X32000000000800, 8, 32}, {0X32000000000a00, 64, 8}, {0X32000000000c00, 8, 16},
        {0X32000000000e00, 8, 8},  {0X32000000001200, 1, 16}, {0X32000000001600, 1, 8},  {0X32000000001800, 1, 8},
        {0X32000000001a00, 1, 32}, {0X32000000001c00, 1, 8},  {0X32000000001e00, 1, 8},  {0X32000000002000, 64, 8},
        {0X32000000002200, 4, 8},
    };
    // V5 尾段为 V4 公共尾段（0x39 段无 0x8000/0xc000/0x10000 三组，那三组为 V4 特有）。
    auto tail = VecDbgRegTailAddr();
    tab.insert(tab.end(), mid.begin(), mid.end());
    tab.insert(tab.end(), tail.begin(), tail.end());
    return tab;
}

// AIV DFX 寄存器：SC(0x8) + SU(0x9) + MTE(0xa) + VEC(0xb) + BIF(0xd)。
std::vector<RegisterTable> CloudV5Register::GenAivDfxRegAddr()
{
    std::vector<RegisterTable> tab = ScSuDfxAddr();
    // MTE(0xa)
    static const std::vector<RegisterTable> mte = {
        {0Xa0000000000003, 1, 8}, {0Xa0000000000100, 4, 8}, {0Xa0000000001100, 4, 8}, {0Xa0000000002100, 3, 8},
        {0Xa0000000009100, 2, 8}, {0Xa000000000a100, 2, 8}, {0Xa000000000c100, 2, 8}, {0Xa000000000d100, 2, 8},
    };
    auto vecSeg = VecDfxAddr();
    // BIF 低段(0xd)
    static const std::vector<RegisterTable> bifLow = {
        {0Xd0000000000000, 1, 8}, {0Xd0000000000008, 1, 8}, {0Xd0000000000010, 1, 8}, {0Xd0000000000018, 1, 8},
        {0Xd0000000000020, 1, 8}, {0Xd0000000000028, 1, 8}, {0Xd0000000000030, 1, 8}, {0Xd0000000000038, 1, 8},
        {0Xd0000000000040, 1, 8}, {0Xd0000000000048, 1, 8}, {0Xd0000000000050, 1, 8}, {0Xd0000000000058, 1, 8},
        {0Xd0000000000060, 1, 8}, {0Xd0000000000068, 1, 8},
    };
    tab.insert(tab.end(), mte.begin(), mte.end());
    tab.insert(tab.end(), vecSeg.begin(), vecSeg.end());
    tab.insert(tab.end(), bifLow.begin(), bifLow.end());
    // BIF 高段: 0xd0000000100000 起，步进 0x10000 共 80 个
    GenAddrByStep(tab, 0Xd0000000100000, 80, 8, 0X10000);
    return tab;
}

void CloudV5Register::GenAICOffsetAddr()
{
    std::vector<RegisterTable> tab = {
        {0X80, 31, 4},
    };
    auto head = OffCommonHeadAddr();
    static const std::vector<RegisterTable> aicOnly = {
        {0X8000, 11, 4}, {0X8030, 6, 4}, {0X8050, 9, 4}, {0X8080, 1, 4}, {0X8088, 6, 4}, {0X8100, 5, 4}, {0X8200, 3, 4},
        {0X8218, 2, 4},  {0X8230, 5, 4}, {0X8268, 1, 4}, {0X827c, 7, 4}, {0X8300, 3, 4}, {0X8400, 5, 4}, {0X8700, 2, 4},
        {0X8710, 1, 4},  {0X8720, 2, 4}, {0X8730, 2, 4}, {0X8740, 2, 4}, {0X8900, 1, 4}, {0X8910, 1, 4}, {0X8920, 1, 4},
        {0X8930, 2, 4},  {0X8940, 1, 4}, {0X8950, 1, 4}, {0X8fe0, 2, 4}, {0X8ff0, 3, 4},
    };
    static const std::vector<RegisterTable> aSeg = {
        {0Xa000, 3, 4}, {0Xa020, 2, 4}, {0Xa600, 2, 4}, {0Xa700, 10, 4}, {0Xa900, 3, 4}, {0Xa910, 1, 4}, {0Xaa00, 5, 4},
    };
    auto seg9 = OffCommon9xAddr();
    auto segB = OffCommonBxAddr();
    tab.insert(tab.end(), head.begin(), head.end());
    tab.insert(tab.end(), aicOnly.begin(), aicOnly.end());
    tab.insert(tab.end(), seg9.begin(), seg9.end());
    tab.insert(tab.end(), aSeg.begin(), aSeg.end());
    tab.insert(tab.end(), segB.begin(), segB.end());
    registerTableMap_[RegisterType::AIC] = std::move(tab);
}

void CloudV5Register::GenAIVOffsetAddr()
{
    std::vector<RegisterTable> tab = {
        {0X80, 31, 4},
    };
    auto head = OffCommonHeadAddr();
    static const std::vector<RegisterTable> aivOnly = {
        {0X7000, 7, 4}, {0X7020, 1, 4}, {0X7030, 1, 4},  {0X7040, 3, 4}, {0X7080, 4, 4}, {0X70c0, 2, 4},
        {0X7100, 6, 4}, {0X7200, 7, 4}, {0X7220, 13, 4}, {0X7700, 1, 4}, {0X7708, 1, 4}, {0X7710, 1, 4},
        {0X7718, 1, 4}, {0X7720, 1, 4}, {0X7728, 1, 4},  {0X7730, 7, 4}, {0X7750, 7, 4}, {0X7900, 1, 4},
        {0X7910, 1, 4}, {0X7920, 1, 4}, {0X7930, 4, 4},  {0X7fe0, 2, 4}, {0X7ff0, 2, 4},
    };
    auto seg9 = OffCommon9xAddr();
    auto segB = OffCommonBxAddr();
    tab.insert(tab.end(), head.begin(), head.end());
    tab.insert(tab.end(), aivOnly.begin(), aivOnly.end());
    tab.insert(tab.end(), seg9.begin(), seg9.end());
    tab.insert(tab.end(), segB.begin(), segB.end());
    registerTableMap_[RegisterType::AIV] = std::move(tab);
}

// V5 平台内部共享段：SC(0x8) + SU(0x9) DFX 寄存器（AIC/AIV 共用）。
std::vector<RegisterTable> CloudV5Register::ScSuDfxAddr()
{
    return {
        {0X80000000000000, 5, 8},  {0X90000000000000, 9, 8}, {0X90000000000040, 9, 8},
        {0X90000000000080, 13, 8}, {0X900000000000c0, 9, 8},
    };
}

// V5 平台内部共享段：错误寄存器偏移表公共头段（AIC/AIV 共用）。
std::vector<RegisterTable> CloudV5Register::OffCommonHeadAddr()
{
    return {
        {0X1000, 4, 4}, {0X11f0, 1, 4}, {0X1200, 2, 4},  {0X1210, 1, 4}, {0X1400, 5, 4},  {0X1500, 5, 4},
        {0X1900, 1, 4}, {0X2000, 1, 4}, {0X2010, 1, 4},  {0X2020, 1, 4}, {0X2030, 2, 4},  {0X2400, 1, 4},
        {0X2410, 2, 4}, {0X2808, 1, 4}, {0X4000, 5, 4},  {0X4020, 9, 4}, {0X4050, 4, 4},  {0X4070, 3, 4},
        {0X40f0, 2, 4}, {0X4140, 1, 4}, {0X4200, 4, 4},  {0X4260, 8, 4}, {0X42a0, 6, 4},  {0X4700, 1, 4},
        {0X4720, 1, 4}, {0X4730, 2, 4}, {0X4750, 3, 4},  {0X4760, 1, 4}, {0X4800, 2, 4},  {0X4810, 2, 4},
        {0X48a0, 3, 4}, {0X48b0, 1, 4}, {0X4980, 1, 4},  {0X4990, 1, 4}, {0X4998, 1, 4},  {0X4a00, 6, 4},
        {0X5000, 1, 4}, {0X5008, 3, 4}, {0X5020, 2, 4},  {0X5030, 1, 4}, {0X5040, 2, 4},  {0X5050, 3, 4},
        {0X5060, 1, 4}, {0X5070, 1, 4}, {0X5080, 1, 4},  {0X50f0, 1, 4}, {0X5100, 19, 4}, {0X5200, 2, 4},
        {0X5300, 3, 4}, {0X5310, 1, 4}, {0X5320, 8, 4},  {0X53a0, 4, 4}, {0X5500, 16, 4}, {0X5580, 16, 4},
        {0X5600, 3, 4}, {0X5610, 1, 4}, {0X5700, 2, 4},  {0X5710, 1, 4}, {0X5720, 2, 4},  {0X5730, 12, 4},
        {0X5900, 1, 4}, {0X5908, 1, 4}, {0X5910, 1, 4},  {0X5920, 6, 4}, {0X5a00, 3, 4},  {0X5a80, 2, 4},
        {0X5b00, 4, 4}, {0X5f00, 1, 4}, {0X5f80, 14, 4}, {0X5fc8, 6, 4}, {0X5fec, 1, 4},  {0X6000, 2, 4},
        {0X6020, 6, 4}, {0X6600, 2, 4}, {0X6700, 11, 4}, {0X673c, 2, 4}, {0X6900, 3, 4},  {0X6910, 4, 4},
        {0X6a00, 5, 4}, {0X6a18, 5, 4}, {0X6b04, 10, 4},
    };
}

// V5 平台内部共享段：错误寄存器偏移表公共 0x9 段（AIC/AIV 共用）。
std::vector<RegisterTable> CloudV5Register::OffCommon9xAddr()
{
    return {
        {0X9000, 4, 4}, {0X9014, 8, 4}, {0X9038, 1, 4}, {0X9040, 5, 4}, {0X9090, 3, 4}, {0X9200, 7, 4}, {0X9220, 1, 4},
        {0X9228, 1, 4}, {0X9230, 5, 4}, {0X9300, 7, 4}, {0X9320, 6, 4}, {0X9350, 4, 4}, {0X9500, 1, 4}, {0X9600, 1, 4},
    };
}

// V5 平台内部共享段：错误寄存器偏移表公共 0xb 段（AIC/AIV 共用）。
std::vector<RegisterTable> CloudV5Register::OffCommonBxAddr()
{
    return {
        {0Xb000, 14, 4}, {0Xb040, 4, 4}, {0Xb080, 14, 4}, {0Xb100, 3, 4}, {0Xb110, 2, 4},
        {0Xb120, 2, 4},  {0Xb130, 2, 4}, {0Xb140, 3, 4},  {0Xb150, 3, 4}, {0Xb280, 2, 4},
        {0Xb380, 2, 4},  {0Xb700, 1, 4}, {0Xb720, 1, 4},
    };
}
} // namespace Adx
