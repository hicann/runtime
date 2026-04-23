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
#include "acc_error_info.h"
#include "adump_dsmi.h"

namespace Adx {

const std::vector<RegisterTable>& RegisterInterface::GetRegisterTable(RegisterType type) const
{
    static std::vector<RegisterTable> defaultTables = {};
    return registerTableMap_.find(type) != registerTableMap_.end() ? registerTableMap_.at(type) : defaultTables;
}

const std::vector<RegisterType>& RegisterInterface::GetRegisterTypes(uint8_t coreType) const
{
    static std::vector<RegisterType> defaultTypes = {};
    return registerTypeMap_.find(coreType) != registerTypeMap_.end() ? registerTypeMap_.at(coreType) : defaultTypes;
}

const std::vector<ErrorRegisterTable>& RegisterInterface::GetErrorRegisterTable() const
{
    return ErrorRegisterMap_;
}

CloudV2Register::CloudV2Register()
{
    registerTableMap_ = {
        {RegisterType::SU,
         {{GetAddr(0, 0), 32, 8},     // GPR0 - GPR31
          {GetAddr(0, 64), 1, 8},     // PC
          {GetAddr(0, 66), 8, 8},     // 66-73
          {GetAddr(0, 75), 4, 8},     // 75-78
          {GetAddr(0, 128), 12, 8}}}, // 128-139
        {RegisterType::VEC,
         {{GetAddr(256, 0), 2, 16},   // MASK CMPMASK
          {GetAddr(256, 2), 14, 8},   // 2-15
          {GetAddr(257, 0), 8, 16}}}, // VARF0 - VARF7
        {RegisterType::MTE,
         {{GetAddr(515, 0), 17, 8},    // 0-16
          {GetAddr(515, 23), 25, 8}}}, // AIPP_SPR_0 - AIPP_SPR_24
        {RegisterType::CUBE,
         {{GetAddr(768, 0), 1, 8},        // LOW_PRE_TBL
          {GetAddr(768, 0x2000), 1, 8},   // SMASK_INDEX
          {GetAddr(768, 0x4000), 1, 8}}}, // FIXP_PRE_BUF
    };
    registerTypeMap_ = {
        {CORE_TYPE_AIC, {RegisterType::SU, RegisterType::MTE, RegisterType::CUBE, RegisterType::BIU}},
        {CORE_TYPE_AIV, {RegisterType::SU, RegisterType::VEC, RegisterType::BIU}}};
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

uint64_t CloudV2Register::GetAddr(uint64_t regAddrHigh, uint64_t regAddrLow) const
{
 	return (regAddrHigh << HIGH_ADDR_SHIFT) | regAddrLow;
}

CloudV4Register::CloudV4Register()
{
    GenAICDbgAddr();  
    GenAIVDbgAddr();  
    GenAICOffsetAddr();  
    GenAIVOffsetAddr(); 
    registerTypeMap_  = {
        {CORE_TYPE_AIC, {RegisterType::AIC, RegisterType::AIC_DBG}},
        {CORE_TYPE_AIV, {RegisterType::AIV, RegisterType::AIV_DBG}}
    };
    InitErrorRegisterMap();
}

void CloudV4Register::InitErrorRegisterMap()
{
    ErrorRegisterMap_ = {
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
        {RT_V200_CUBE_ERROR_T0_1, 0x8710, 4, "CUBE_ERROR_T0_1"},
        {RT_V200_CUBE_ERR_INFO_T0_0, 0x8730, 4, "CUBE_ERR_INFO_T0_0"},
        {RT_V200_CUBE_ERR_INFO_T0_1, 0x8734, 4, "CUBE_ERR_INFO_T0_1"},
        {RT_V200_L1_ERROR_T0_0, 0xA700, 4, "L1_ERROR_T0_0"},
        {RT_V200_L1_ERROR_T0_1, 0xA704, 4, "L1_ERROR_T0_1"},
        {RT_V200_L1_ERR_INFO_T0_0, 0xA718, 4, "L1_ERR_INFO_T0_0"},
        {RT_V200_L1_ERR_INFO_T0_1, 0xA71C, 4, "L1_ERR_INFO_T0_1"},
        };
}

void CloudV4Register::GenAICDbgAddr(){
    std::vector<RegisterTable> regAICDbgTab =  {
        {0X10000000000000,32, 4}, {0X10000000000040, 15, 4}, 
        {0X10000000000080, 12, 4}, {0X15000000000000, 1, 4},
        {0X15800000000000, 1, 4}, {0X16000000000000, 1, 4},
        {0X16800000000000, 1, 4}, {0X21000000000000, 1, 4},
        {0X22000000000000,32, 4}, {0X23000000000000, 1, 4},
        {0X24000000000000, 23, 4}, {0X40000000000000, 1, 4},
        {0X40000000000008, 1, 4}, {0X40000000000010, 1, 4},
        {0X40000000000018, 1, 4}, {0X40000000000020, 1, 4},
        {0X40000000000028, 1, 4}, {0X40000000000030, 1, 4},
        {0X40000000000038, 1, 4}, {0X40000000000040, 1, 4},
        {0X40000000000048, 1, 4}, {0X40000000000050, 1, 4},
        {0X40000000000058, 1, 4}, {0X40000000000060, 1, 4},
        {0X60000000000000, 10, 4}, {0X61000000000000, 11, 4},
        {0X67000000000000, 1, 4}, {0X80000000000000, 5, 4},
        {0X90000000000000, 9, 4},
        {0X90000000000040, 8, 4}, {0X90000000000080, 13, 4},
        {0X900000000000c0, 8, 4}, {0Xa0000000000000, 3, 4},
        {0Xa0000000000100, 3, 4}, {0Xa0000000000200, 3, 4},
        {0Xa0000000001000, 1, 4}, {0Xa0000000001100, 1, 4},
        {0Xa0000000001200, 1, 4}, {0Xa0000000002100, 2, 4},
        {0Xa0000000002200, 2, 4}, {0Xa0000000003000, 1, 4},
        {0Xa0000000008100, 3, 4}, {0Xc0000000000000, 16, 4},
        {0Xd0000000000000, 1, 4}, {0Xd0000000000008, 1, 4},
        {0Xd0000000000010, 1, 4}, {0Xd0000000000018, 1, 4},
        {0Xd0000000000020, 1, 4}, {0Xd0000000000028, 1, 4},
        {0Xd0000000000030, 1, 4}, {0Xd0000000000038, 1, 4},
        {0Xe0000000000000, 5, 4}, {0Xe0000000000100, 3, 4},
        {0Xe0000000000200, 6, 4}, {0Xe0000000000300, 2, 4},
        {0Xe0000000000400, 1, 4}, {0Xe0000000000500, 9, 4},
        {0Xe0000000000600, 16, 4},
    };
    registerTableMap_[RegisterType::AIC_DBG] = regAICDbgTab;            
}

void CloudV4Register::GenAIVDbgAddr(){
    std::vector<RegisterTable> regAIVDbgTab =  {
        {0X10000000000000,32, 4}, {0X10000000000040, 15, 4}, {0X10000000000080, 12, 4},
        {0X15000000000000, 1, 4}, {0X15800000000000, 1, 4}, {0X16000000000000, 1, 4},
        {0X16800000000000, 1, 4}, {0X21000000000000, 1, 4}, {0X22000000000000,32, 4},       
        {0X23000000000000, 1, 4}, {0X24000000000000, 23, 4}, {0X32000000000000, 8, 4},   
        {0X32000000000010, 8, 4}, {0X32000000000020, 8, 4}, {0X32000000000030, 8, 4},    
        {0X32000000000040, 8, 4}, {0X32000000000050, 8, 4}, {0X32000000000060, 8, 4},   
        {0X32000000000070, 8, 4}, {0X32000000000080, 8, 4}, {0X32000000000090, 8, 4},    
        {0X320000000000a0, 8, 4}, {0X320000000000b0, 8, 4}, {0X320000000000c0, 8, 4},   
        {0X320000000000d0, 8, 4}, {0X320000000000e0, 8, 4}, {0X320000000000f0, 8, 4},   
        {0X32000000000100, 8, 4}, {0X32000000000110, 8, 4}, {0X32000000000120, 8, 4},   
        {0X32000000000130, 8, 4}, {0X32000000000140, 8, 4}, {0X32000000000150, 8, 4},    
        {0X32000000000160, 8, 4}, {0X32000000000170, 8, 4}, {0X32000000000180, 8, 4},   
        {0X32000000000190, 8, 4}, {0X320000000001a0, 8, 4}, {0X320000000001b0, 8, 4},    
        {0X320000000001c0, 8, 4}, {0X320000000001d0, 8, 4}, {0X320000000001e0, 8, 4},   
        {0X320000000001f0, 8, 4}, {0X32000000000200, 1, 4}, {0X32000000000202, 1, 4},  
        {0X32000000000204, 1, 4}, {0X32000000000206, 1, 4}, {0X32000000000208, 1, 4},   
        {0X3200000000020a, 1, 4}, {0X3200000000020c, 1, 4}, {0X3200000000020e, 1, 4},  
        {0X32000000000400, 1, 4}, {0X32000000000440, 1, 4}, {0X32000000000480, 1, 4},   
        {0X320000000004c0, 1, 4}, {0X32000000000600, 4, 4}, {0X32000000000800, 8, 4},    
        {0X32000000000a00, 64, 4}, {0X32000000000c00, 8, 4}, {0X32000000000e00, 8, 4},  
        {0X32000000001000, 4, 4}, {0X32000000001200, 1, 4}, {0X32000000001400, 1, 4},    
        {0X32000000001600, 1, 4}, {0X32000000001800, 1, 4}, {0X32000000001a00, 1, 4},   
        {0X32000000001c00, 1, 4}, {0X32000000001e00, 1, 4}, {0X32000000002000, 64, 4},   
        {0X32000000002200, 4, 4}, {0X32000000002400, 9, 4}, {0X32000000002600, 5, 4},   
        {0X32000000002608, 5, 4}, {0X32000000002800, 1, 4}, {0X32000000002804, 3, 4},    
        {0X32000000002808, 1, 4}, {0X3200000000280c, 1, 4}, {0X32000000002a00, 2, 4},   
        {0X32000000002c00, 1, 4}, {0X39000000000000, 5, 4}, {0X39000000004000, 64, 4},    
        {0X39000000008000, 1, 4}, {0X3900000000c000, 1, 4}, {0X39000000010000, 1, 4},   
        {0X39000000014000, 1, 4}, {0X39000000018000, 1, 4}, {0X3900000001c000, 64, 4},   
        {0X80000000000000, 5, 4}, {0X90000000000000, 9, 4}, {0X90000000000040, 8, 4},
        {0X90000000000080, 13, 4}, {0X900000000000c0, 8, 4}, {0Xa0000000000000, 3, 4},
        {0Xa0000000000100, 3, 4}, {0Xa0000000000200, 3, 4}, {0Xa0000000001000, 1, 4},
        {0Xa0000000001100, 1, 4}, {0Xa0000000001200, 1, 4}, {0Xa0000000002100, 2, 4},
        {0Xa0000000002200, 2, 4}, {0Xa0000000003000, 1, 4}, {0Xa0000000008100, 3, 4},
        {0Xb0000000000000, 1, 4}, {0Xb0000000000008, 1, 4}, {0Xb0000000000010, 1, 4},
        {0Xb0000000000018, 1, 4}, {0Xb0000000000020, 1, 4}, {0Xb0000000000040, 1, 4},
        {0Xb0000000000080, 1, 4}, {0Xb00000000000c0, 1, 4}, {0Xb0000000000100, 1, 4},
        {0Xb0000000000140, 1, 4}, {0Xb0000000000180, 1, 4}, {0Xb00000000001c0, 1, 4},
        {0Xb00000000001c8, 1, 4}, {0Xb0000000000200, 1, 4}, {0Xb0000000000240, 1, 4},
        {0Xb0000000000280, 1, 4}, {0Xb0000000000288, 1, 4}, {0Xb0000000000290, 1, 4},
        {0Xb00000000002c0, 1, 4}, {0Xb00000000002c8, 1, 4}, {0Xb0000000000300, 1, 4},
        {0Xb0000000000340, 1, 4}, {0Xd0000000000000, 1, 4}, {0Xd0000000000008, 1, 4},
        {0Xd0000000000010, 1, 4}, {0Xd0000000000018, 1, 4}, {0Xd0000000000020, 1, 4},
        {0Xd0000000000028, 1, 4}, {0Xd0000000000030, 1, 4}, {0Xd0000000000038, 1, 4},       
    };
    registerTableMap_[RegisterType::AIV_DBG] = regAIVDbgTab;            
}

void CloudV4Register::GenAICOffsetAddr(){
    std::vector<RegisterTable> regAICOffsetTab =  {
        {0X80,30, 4}, {0X1000, 3, 4}, {0X11f0, 1, 4}, 
        {0X1200, 2, 4}, {0X1210, 1, 4}, {0X1400, 5, 4}, 
        {0X1500, 4, 4}, {0X2000, 1, 4}, {0X2010, 1, 4}, 
        {0X2020, 1, 4}, {0X2030, 2, 4}, {0X2400, 1, 4}, 
        {0X2410, 2, 4}, {0X2808, 1, 4}, {0X4000, 5, 4}, 
        {0X4020, 9, 4}, {0X4050, 4, 4}, {0X4070, 2, 4}, 
        {0X40f0, 2, 4}, {0X4140, 1, 4}, {0X4200, 4, 4}, 
        {0X4260, 4, 4}, {0X42a0, 6, 4}, {0X4700, 1, 4}, 
        {0X4720, 1, 4}, {0X4730, 2, 4}, {0X4750, 3, 4}, 
        {0X4760, 1, 4}, {0X48a0, 3, 4}, {0X48b0, 1, 4}, 
        {0X4980, 1, 4}, {0X4990, 1, 4}, {0X4998, 1, 4}, 
        {0X5000, 1, 4}, {0X5008, 2, 4}, {0X5020, 2, 4}, 
        {0X5030, 1, 4}, {0X5040, 2, 4}, {0X5050, 3, 4}, 
        {0X5060, 1, 4}, {0X50f0, 1, 4}, {0X5100, 19, 4}, 
        {0X5200, 2, 4}, {0X5300, 3, 4}, {0X5310, 1, 4}, 
        {0X5320, 8, 4}, {0X53a0, 4, 4}, {0X5600, 3, 4}, 
        {0X5700, 1, 4}, {0X5720, 1, 4}, {0X5730, 4, 4}, 
        {0X5900, 1, 4}, {0X5910, 1, 4}, {0X5920, 2, 4}, 
        {0X5930, 2, 4}, {0X5a00, 3, 4}, {0X5a80, 2, 4}, 
        {0X6000, 2, 4}, {0X6020, 6, 4}, {0X6600, 2, 4}, 
        {0X6700, 1, 4}, {0X6708, 1, 4}, {0X6710, 1, 4}, 
        {0X6718, 5, 4}, {0X673c, 1, 4}, {0X6900, 3, 4}, 
        {0X6910, 3, 4}, {0X6a00, 4, 4}, {0X6a18, 1, 4}, 
        {0X6b04, 1, 4}, {0X6b0c, 3, 4}, 
        {0X8000, 11, 4}, {0X8030, 6, 4}, 
        {0X8050, 9, 4}, {0X8080, 1, 4}, 
        {0X8088, 6, 4}, {0X8100, 2, 4}, 
        {0X8200, 3, 4}, {0X8218, 1, 4}, 
        {0X8230, 4, 4}, {0X8700, 2, 4}, 
        {0X8720, 2, 4}, {0X8730, 2, 4}, 
        {0X8900, 1, 4}, {0X8920, 1, 4}, 
        {0X8930, 2, 4}, {0X8940, 1, 4}, 
        {0X9000, 4, 4}, {0X9014, 14, 4}, 
        {0X9050, 4, 4}, {0X9090, 3, 4}, 
        {0X9200, 7, 4}, {0X9220, 11, 4}, 
        {0X9300, 7, 4}, {0X9320, 4, 4}, 
        {0X9500, 1, 4}, {0X9600, 1, 4}, 
        {0Xa000, 3, 4}, {0Xa020, 2, 4}, 
        {0Xa600, 2, 4}, {0Xa700, 2, 4}, 
        {0Xa710, 4, 4}, {0Xa900, 1, 4}, 
        {0Xa908, 1, 4}, {0Xa910, 1, 4}, 
        {0Xaa00, 1, 4}, {0Xb000, 14, 4}, 
        {0Xb070, 2, 4}, {0Xb080, 14, 4}, 
    };
    registerTableMap_[RegisterType::AIC] = regAICOffsetTab;            
}

void CloudV4Register::GenAIVOffsetAddr(){
    std::vector<RegisterTable> regAIVOffsetTab =  {
        {0X80,30, 4}, {0X1000, 3, 4}, {0X11f0, 1, 4}, 
        {0X1500, 4, 4}, {0X2000, 1, 4}, {0X2010, 1, 4},         
        {0X1200, 2, 4}, {0X1210, 1, 4}, {0X1400, 5, 4}, 
        {0X2020, 1, 4}, {0X2030, 2, 4}, {0X2400, 1, 4},         
        {0X4020, 9, 4}, {0X4050, 4, 4}, {0X4070, 2, 4}, 
        {0X2410, 2, 4}, {0X2808, 1, 4}, {0X4000, 5, 4}, 
        {0X40f0, 2, 4}, {0X4140, 1, 4}, {0X4200, 4, 4}, 
        {0X4260, 4, 4}, {0X42a0, 6, 4}, {0X4700, 1, 4},         
        {0X4760, 1, 4}, {0X48a0, 3, 4}, {0X48b0, 1, 4}, 
        {0X4720, 1, 4}, {0X4730, 2, 4}, {0X4750, 3, 4}, 
        {0X4980, 1, 4}, {0X4990, 1, 4}, {0X4998, 1, 4}, 
        {0X5000, 1, 4}, {0X5008, 2, 4}, {0X5020, 2, 4}, 
        {0X5030, 1, 4}, {0X5040, 2, 4}, {0X5050, 3, 4}, 
        {0X5060, 1, 4}, {0X50f0, 1, 4}, 
        {0X5100, 19, 4}, {0X5200, 2, 4}, 
        {0X5300, 3, 4}, {0X5310, 1, 4}, 
        {0X5320, 8, 4}, {0X53a0, 4, 4}, 
        {0X5600, 3, 4}, {0X5700, 1, 4}, 
        {0X5720, 1, 4}, {0X5730, 4, 4}, 
        {0X5900, 1, 4}, {0X5910, 1, 4}, 
        {0X5920, 2, 4}, {0X5930, 2, 4}, 
        {0X5a00, 3, 4}, {0X5a80, 2, 4}, 
        {0X6000, 2, 4}, {0X6020, 6, 4}, 
        {0X6600, 2, 4}, {0X6700, 1, 4}, 
        {0X6708, 1, 4}, {0X6710, 1, 4}, 
        {0X6718, 5, 4}, {0X673c, 1, 4}, 
        {0X6900, 3, 4}, {0X6910, 3, 4}, 
        {0X6a00, 4, 4}, {0X6a18, 1, 4}, 
        {0X6b04, 1, 4}, {0X6b0c, 3, 4}, 
        {0X7004, 6, 4}, {0X7030, 1, 4}, 
        {0X7040, 3, 4}, {0X7080, 3, 4}, 
        {0X70c0, 2, 4}, {0X7100, 6, 4}, 
        {0X7200, 7, 4}, {0X7700, 1, 4}, 
        {0X7708, 1, 4}, {0X7720, 1, 4}, 
        {0X7728, 1, 4}, {0X7730, 6, 4}, 
        {0X7900, 1, 4}, {0X7920, 1, 4}, 
        {0X9000, 4, 4}, {0X9014, 14, 4}, 
        {0X9050, 4, 4}, {0X9090, 3, 4}, 
        {0X9200, 7, 4}, {0X9220, 11, 4}, 
        {0X9300, 7, 4}, {0X9320, 4, 4}, 
        {0X9500, 1, 4}, {0X9600, 1, 4}, 
        {0Xb000, 14, 4}, {0Xb070, 2, 4}, 
        {0Xb080, 14, 4}, 
    };
    registerTableMap_[RegisterType::AIV] = regAIVOffsetTab;            
}

uint64_t CloudV4Register::GetAddr(uint64_t type, uint64_t regAddrHigh, uint64_t regAddrLow) const 
{
    return (type << MOUDLE_TYPE_SHIFT) | (regAddrHigh << HIGH_ADDR_SHIFT) | regAddrLow;
}

void CloudV4Register::GenAddrByStep(RegisterType regType, const std::vector<RegisterStepTable>& regStepTab)
{
    for (const auto& stepTable : regStepTab) {
        uint64_t curStartAddr = stepTable.startAddr;
        for (uint32_t i = 0; i < stepTable.num; i++) {
            registerTableMap_[regType].emplace_back(curStartAddr, 1, stepTable.byteWidth);
            curStartAddr += stepTable.step;
        }
    }
}

void RegisterManager::CreateRegister()
{
    uint32_t type = 0;
    if (!AdumpDsmi::DrvGetPlatformType(type)) {
        return;
    }
    switch (static_cast<PlatformType>(type)) {
        case PlatformType::CHIP_CLOUD_V2:
            register_ = std::make_shared<CloudV2Register>();
            break;
        case PlatformType::CHIP_CLOUD_V4:
            register_ = std::make_shared<CloudV4Register>();
            break;
        default:
            break;
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
