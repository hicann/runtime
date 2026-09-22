/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "cloud_v2_platform.h"

#include <string>
#include "runtime/base.h"
#include "log/adx_log.h"
#include "adump_platform_registry.h"
#include "kernel_pc_fixer.h"
#include "dump_common.h"
#include "acc_error_info.h"
#include "dump_core.h"
#include "hccl_mc2_define.h"

namespace Adx {

ADUMP_PLATFORM_REGISTER(ExceptionDumpInterface, PlatformType::CHIP_CLOUD_TYPE, CloudLegacyException);
ADUMP_PLATFORM_REGISTER(FeaturesSupportInterface, PlatformType::CHIP_CLOUD_V2, CloudV2Features);
ADUMP_PLATFORM_REGISTER(CoredumpInterface, PlatformType::CHIP_CLOUD_V2, CloudV2Coredump);
ADUMP_PLATFORM_REGISTER(ExceptionDumpInterface, PlatformType::CHIP_CLOUD_V2, CloudV2Exception);
ADUMP_PLATFORM_REGISTER(DataDumpInterface, PlatformType::CHIP_CLOUD_V2, CloudV2DataDump);

namespace {
uint64_t GetAscend910Mc2StructSize()
{
    constexpr uint32_t socVersionLength = 128U;
    char version[socVersionLength] = {0};
    rtError_t ret = rtGetSocVersion(version, socVersionLength);
    if (ret != RT_ERROR_NONE) {
        IDE_LOGE("[AdumpPlatform] Get soc version failed for mc2 struct size.");
        return 0;
    }
    if (std::string(version).find("Ascend910_93") != std::string::npos) {
        return sizeof(HcclOpResParam);
    }
    return sizeof(HcclCombinOpParam);
}
} // namespace

bool CloudLegacyException::SupportMc2SpacesDump() const { return true; }

uint64_t CloudLegacyException::GetMc2StructSize() const { return GetAscend910Mc2StructSize(); }

CloudV2Features::CloudV2Features()
{
    supported_ = {
        AdumpPlatformFeature::FEATURE_DATA_DUMP,         AdumpPlatformFeature::FEATURE_OVERFLOW_DUMP,
        AdumpPlatformFeature::FEATURE_EXCEPTION_DUMP_L0, AdumpPlatformFeature::FEATURE_EXCEPTION_DUMP_L1,
        AdumpPlatformFeature::FEATURE_CORE_DUMP,
    };
}

std::unique_ptr<PcFixerInterface> CloudV2Coredump::CreatePcFixer() const
{
    return std::unique_ptr<PcFixerInterface>(new (std::nothrow) CloudV2PcFixer());
}

std::shared_ptr<RegisterInterface> CloudV2Coredump::CreateRegister() const
{
    return std::make_shared<CloudV2Register>();
}

void CloudV2Coredump::DumpRegister(DumpCore& core, uint8_t coreType, uint16_t coreId) const
{
    core.DumpStdRegRegister(coreType, coreId);
}

uint16_t CloudV2Coredump::ConvertCoreId(uint8_t coreType, uint16_t coreId) const
{
    return (coreType == CORE_TYPE_AIC) ? coreId : static_cast<uint16_t>(CORE_SIZE_AIC + coreId);
}

bool CloudV2Exception::SupportMc2SpacesDump() const { return true; }

uint64_t CloudV2Exception::GetMc2StructSize() const { return GetAscend910Mc2StructSize(); }

bool CloudV2Exception::IsArgsDataTypeSizeByByte() const { return true; }

uint64_t CloudV2DataDump::GetKfcStackSize() const
{
    constexpr uint32_t OP_STACK_910B = 75;
    return CalcKfcStackSize(OP_STACK_910B);
}

std::vector<std::string> CloudV2DataDump::GetKfcBinNames() const
{
    return {"dump_stat_op_ascend910B.o", "kfc_dump_stat_ascend910B.o"};
}

bool CloudV2DataDump::IsUbFromAiCore() const { return true; }

// ========== 寄存器配置实现 ==========

CloudV2Register::CloudV2Register()
{
    InitAicAivRegisters();
    registerTypeMap_ = {{CORE_TYPE_AIC, {RegisterType::AIC_DBG}}, {CORE_TYPE_AIV, {RegisterType::AIV_DBG}}};
}

std::vector<RegisterTable> CloudV2Register::GenAicDbgRegSuAddr() { return SuDbgRegAddr(); }

// AIC MTE Debug 寄存器（模块编码 0x2）。
std::vector<RegisterTable> CloudV2Register::GenAicDbgRegMteAddr()
{
    return {
        {0X203000000000000, 17, 8},
        {0X203000000000017, 25, 8},
    };
}

// AIC CUBE Debug 寄存器（模块编码 0x3）。
std::vector<RegisterTable> CloudV2Register::GenAicDbgRegCubeAddr()
{
    return {
        {0X300000000000000, 1, 8},
        {0X300000000002000, 1, 8},
        {0X300000000004000, 1, 8},
    };
}

std::vector<RegisterTable> CloudV2Register::GenAivDbgRegSuAddr() { return SuDbgRegAddr(); }

// AIV VEC Debug 寄存器（模块编码 0x1）。
std::vector<RegisterTable> CloudV2Register::GenAivDbgRegVecAddr()
{
    return {
        {0X100000000000000, 2, 16},
        {0X100000000000002, 14, 8},
        {0X101000000000000, 8, 16},
    };
}

void CloudV2Register::InitErrorRegisters()
{
    ErrorRegisterMap_ = {
        {RT_V100_AIC_ERR_0, 0x00000700, 4, "AIC_ERROR_0"},      {RT_V100_AIC_ERR_1, 0x00000704, 4, "AIC_ERROR_1"},
        {RT_V100_AIC_ERR_2, 0x00000760, 4, "AIC_ERROR_2"},      {RT_V100_AIC_ERR_3, 0x00000764, 4, "AIC_ERROR_3"},
        {RT_V100_AIC_ERR_4, 0x00000780, 4, "AIC_ERROR_4"},      {RT_V100_AIC_ERR_5, 0x00000790, 4, "AIC_ERROR_5"},
        {RT_V100_BIU_ERR_0, 0x00000710, 4, "BIU_ERR_INFO_0"},   {RT_V100_BIU_ERR_1, 0x00000714, 4, "BIU_ERR_INFO_1"},
        {RT_V100_CCU_ERR_0, 0x00000718, 4, "CCU_ERR_INFO_0"},   {RT_V100_CCU_ERR_1, 0x0000071C, 4, "CCU_ERR_INFO_1"},
        {RT_V100_IFU_ERR_0, 0x00000728, 4, "IFU_ERR_INFO_0"},   {RT_V100_IFU_ERR_1, 0x0000072C, 4, "IFU_ERR_INFO_1"},
        {RT_V100_MTE_ERR_0, 0x00000730, 4, "MTE_ERR_INFO_0"},   {RT_V100_MTE_ERR_1, 0x00000734, 4, "MTE_ERR_INFO_1"},
        {RT_V100_VEC_ERR_0, 0x00000738, 4, "VEC_ERR_INFO_0"},   {RT_V100_VEC_ERR_1, 0x0000073C, 4, "VEC_ERR_INFO_1"},
        {RT_V100_FIXP_ERR_0, 0x0000078C, 4, "FIXP_ERR_INFO_0"}, {RT_V100_FIXP_ERR_1, 0x000007C8, 4, "FIXP_ERR_INFO_1"},
        {RT_V100_CUBE_ERR_0, 0x00000720, 4, "CUBE_ERR_INFO"},
    };
}

// V2 平台内部共享段：SU Debug 寄存器（GPR0-31 / PC / SPR，AIC/AIV 共用）。
std::vector<RegisterTable> CloudV2Register::SuDbgRegAddr()
{
    return {
        {0X0, 32, 8}, {0X40, 1, 8}, {0X42, 8, 8}, {0X4b, 4, 8}, {0X80, 12, 8},
    };
}
} // namespace Adx
