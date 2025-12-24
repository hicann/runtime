/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime/base.h"
#include "dump_common.h"
#include "register_config.h"

namespace Adx {

const std::vector<RegisterTable>& RegisterInterface::GetRegisterTable(RegisterType type) const
{
    static std::vector<RegisterTable> defaultTables = {};
    return registerTableMap_.find(type) != registerTableMap_.end() ? registerTableMap_.at(type): defaultTables;
}

const std::vector<RegisterType>& RegisterInterface::GetRegisterTypes(uint8_t coreType) const
{
    static std::vector<RegisterType> defaultTypes = {};
    return registerTypeMap_.find(coreType) != registerTypeMap_.end() ? registerTypeMap_.at(coreType): defaultTypes;
}

const std::vector<ErrorRegisterTable>& RegisterInterface::GetErrorRegisterTable() const
{
    return ErrorRegisterMap_;
}

CloudV2Register::CloudV2Register()
{
    registerTableMap_ = {
        {RegisterType::SU, {{GetAddr(0, 0), 32, 8},           // GPR0 - GPR31
                            {GetAddr(0, 64), 1, 8},           // PC
                            {GetAddr(0, 66), 8, 8},           // 66-73
                            {GetAddr(0, 75), 4, 8},           // 75-78
                            {GetAddr(0, 128), 12, 8}}},       // 128-139
        {RegisterType::VEC, {{GetAddr(256, 0), 2, 16},        // MASK CMPMASK
                             {GetAddr(256, 2), 14, 8},        // 2-15
                             {GetAddr(257, 0), 8, 16}}},      // VARF0 - VARF7
        {RegisterType::MTE, {{GetAddr(515, 0), 17, 8},        // 0-16
                             {GetAddr(515, 23), 25, 8}}},     // AIPP_SPR_0 - AIPP_SPR_24
        {RegisterType::CUBE, {{GetAddr(768, 0), 1, 8},        // LOW_PRE_TBL
                              {GetAddr(768, 0x2000), 1, 8},   // SMASK_INDEX
                              {GetAddr(768, 0x4000), 1, 8}}}, // FIXP_PRE_BUF
    };
    registerTypeMap_  = {
        {CORE_TYPE_AIC, {RegisterType::SU, RegisterType::MTE, RegisterType::CUBE, RegisterType::BIU}},
        {CORE_TYPE_AIV, {RegisterType::SU, RegisterType::VEC, RegisterType::BIU}}
    };
    ErrorRegisterMap_ = {
        {RT_V100_AIC_ERR_0, 0x00000700, 4, "AIC_ERROR_0"},
        {RT_V100_AIC_ERR_1, 0x00000704, 4, "AIC_ERROR_1"},
        {RT_V100_AIC_ERR_2, 0x00000760, 4, "AIC_ERROR_2"},
        {RT_V100_AIC_ERR_3, 0x00000764, 4, "AIC_ERROR_3"},
        {RT_V100_AIC_ERR_4, 0x00000780, 4, "AIC_ERROR_4"},
        {RT_V100_AIC_ERR_5, 0x00000790, 4, "AIC_ERROR_5"},
        {RT_V100_BIU_ERR_0, 0x00000710, 4, "BIU_ERR_INFO_0"},
        {RT_V100_BIU_ERR_1, 0x00000714, 4, "BIU_ERR_INFO_1"},
        {RT_V100_CCU_ERR_0, 0x00000718, 4, "CCU_ERR_INFO_0"},
        {RT_V100_CCU_ERR_1, 0x0000071C, 4, "CCU_ERR_INFO_1"},
        {RT_V100_IFU_ERR_0, 0x00000728, 4, "IFU_ERR_INFO_0"},
        {RT_V100_IFU_ERR_1, 0x0000072C, 4, "IFU_ERR_INFO_1"},
        {RT_V100_MTE_ERR_0, 0x00000730, 4, "MTE_ERR_INFO_0"},
        {RT_V100_MTE_ERR_1, 0x00000734, 4, "MTE_ERR_INFO_1"},
        {RT_V100_VEC_ERR_0, 0x00000738, 4, "VEC_ERR_INFO_0"},
        {RT_V100_VEC_ERR_1, 0x0000073C, 4, "VEC_ERR_INFO_1"},
        {RT_V100_FIXP_ERR_0, 0x0000078C, 4, "FIXP_ERR_INFO_0"},
        {RT_V100_FIXP_ERR_1, 0x000007C8, 4, "FIXP_ERR_INFO_1"},
        {RT_V100_CUBE_ERR_0, 0x00000720, 4, "CUBE_ERR_INFO"},
    };
}

uint64_t CloudV2Register::GetAddr(uint64_t regAddrHigh, uint64_t regAddrLow) const {
    return (regAddrHigh << HIGH_ADDR_SHIFT) | regAddrLow;
}

CloudV4Register::CloudV4Register()
{
    registerTableMap_ = {
        {RegisterType::SU, {
            {GetAddr(1, 0, 0), 32, 8}, {GetAddr(1, 0, 64), 15, 8}, {GetAddr(1, 0, 128), 10, 8},
            {GetAddr(1, 5, 0), 1, 8}, {GetAddr(1, 5, 0x800000000000), 1, 8}, {GetAddr(1, 6, 0), 1, 8},
            {GetAddr(1, 6, 0x800000000000), 1, 8}}},
        {RegisterType::MTE, {
            {GetAddr(2, 1, 0), 1, 8}, {GetAddr(2, 2, 0), 2, 8}, {GetAddr(2, 2, 3), 4, 8},
            {GetAddr(2, 2, 0x12), 1, 8}, {GetAddr(2, 2, 0x14), 1, 8}}},
        {RegisterType::MTE_AIV, {
            {GetAddr(2, 1, 0), 1, 8}, {GetAddr(2, 2, 2), 1, 8}, {GetAddr(2, 2, 7), 3, 8},
            {GetAddr(2, 2, 13), 3, 8}, {GetAddr(2, 2, 0x16), 9, 8}}},
        {RegisterType::VEC_RB, {
            {GetAddr(3, 2, 0x600), 4, 32}, {GetAddr(3, 2, 0x800), 4, 32}, {GetAddr(3, 2, 0x804), 4, 8},
            {GetAddr(3, 2, 0xA00), 64, 8}, {GetAddr(3, 2, 0xC00), 8, 16}, {GetAddr(3, 2, 0xE00), 8, 8},
            {GetAddr(3, 2, 0x1200), 1, 16}, {GetAddr(3, 2, 0x1600), 1, 8}, {GetAddr(3, 2, 0x1800), 1, 8},
            {GetAddr(3, 2, 0x1A00), 1, 32}, {GetAddr(3, 2, 0x1C00), 1, 8}, {GetAddr(3, 2, 0x1E00), 1, 8},
            {GetAddr(3, 2, 0x2000), 64, 8}, {GetAddr(3, 2, 0x2200), 4, 8}, {GetAddr(3, 9, 0), 5, 8},
            {GetAddr(3, 9, 0x4000), 1, 8}, {GetAddr(3, 9, 0x8000), 1, 32}, {GetAddr(3, 9, 0xC000), 1, 32},
            {GetAddr(3, 9, 0x10000), 1, 32}, {GetAddr(3, 9, 0x14000), 1, 32}, {GetAddr(3, 9, 0x18000), 1, 8},
            {GetAddr(3, 9, 0x1C000), 1, 8}}},
        {RegisterType::CUBE, {}},
        {RegisterType::L1, {{GetAddr(6, 0, 0), 10, 8},{GetAddr(6, 1, 0), 10, 8}, {GetAddr(6, 7, 0), 1, 8}}},
    };
    GenAddrByStep(RegisterType::VEC_RB,
        {{GetAddr(3, 2, 0), 32, 32, 16}, {GetAddr(3, 2, 0x200), 8, 32, 2}});
    registerTypeMap_  = {
        {CORE_TYPE_AIC, {RegisterType::SU, RegisterType::MTE, RegisterType::CUBE, RegisterType::BIF, RegisterType::L1}},
        {CORE_TYPE_AIV, {RegisterType::SU, RegisterType::MTE_AIV, RegisterType::VEC_RB, RegisterType::BIF}}
    };
}

uint64_t CloudV4Register::GetAddr(uint64_t type, uint64_t regAddrHigh, uint64_t regAddrLow) const {
    return (type << MOUDLE_TYPE_SHIFT) | (regAddrHigh << HIGH_ADDR_SHIFT) | regAddrLow;
}

void CloudV4Register::GenAddrByStep(RegisterType regType, const std::vector<RegisterStepTable> &regStepTab){
    for (const auto &stepTable: regStepTab){
        uint64_t curStartAddr = stepTable.startAddr;
        for (uint32_t i = 0; i < stepTable.num; i++){
            registerTableMap_[regType].emplace_back(curStartAddr, 1, stepTable.byteWith);
            curStartAddr += stepTable.step;
        }
    }
}

RegisterManager::RegisterManager()
{
    CreateRegister();
}

RegisterManager &RegisterManager::GetInstance()
{
    static RegisterManager instance;
    return instance;
}

const std::shared_ptr<RegisterInterface> RegisterManager::GetRegister()
{
    return register_;
}
}
