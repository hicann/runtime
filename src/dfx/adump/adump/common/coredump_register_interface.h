/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef COREDUMP_REGISTER_INTERFACE_H
#define COREDUMP_REGISTER_INTERFACE_H

#include <cstdint>
#include <vector>
#include <map>
#include <string>

namespace Adx {

struct RegisterTable {
    RegisterTable(uint64_t regStartAddr, uint32_t regNum, uint8_t regByteWidth)
        : startAddr(regStartAddr), num(regNum), byteWidth(regByteWidth)
    {}
    uint64_t startAddr;
    uint32_t num;
    uint8_t byteWidth;
};

struct ErrorRegisterTable {
    ErrorRegisterTable(uint8_t regErrIndex, uint64_t regOffsetAddr, uint8_t regByteWidth, std::string regName)
        : errIndex(regErrIndex), offsetAddr(regOffsetAddr), byteWidth(regByteWidth), name(regName)
    {}
    uint8_t errIndex;
    uint64_t offsetAddr;
    uint8_t byteWidth;
    std::string name;
};

// Debug/DFX 寄存器地址布局（V4/V5）：bit63-52 为模块类型，bit51-48 为模块内高段，低 48 位为偏移。
// 模块类型分 Debug(0x0~0x7) 与 DFX(0x8~0xf) 两域，同一模块在两域各占一个编号：
//   Debug 域             DFX 域
//   0x0  SC              0x8  SC
//   0x1  SU              0x9  SU
//   0x2  MTE             0xa  MTE
//   0x3  VEC             0xb  VEC
//   0x4  CUBE            0xc  CUBE
//   0x5  BIU             0xd  BIF
//   0x6  L1              0xe  L1
// V2 不区分两域，地址为模块编码 + 模块内偏移，整表经 AIC_DBG/AIV_DBG 通道读取。

enum class RegisterType : uint8_t { AIC, AIV, AIC_DBG, AIV_DBG };

class RegisterInterface {
public:
    RegisterInterface() = default;
    virtual ~RegisterInterface() = default;

    const std::vector<RegisterTable>& GetRegisterTable(RegisterType type) const
    {
        static std::vector<RegisterTable> defaultTables = {};
        return registerTableMap_.find(type) != registerTableMap_.end() ? registerTableMap_.at(type) : defaultTables;
    }

    const std::vector<RegisterType>& GetRegisterTypes(uint8_t coreType) const
    {
        static std::vector<RegisterType> defaultTypes = {};
        return registerTypeMap_.find(coreType) != registerTypeMap_.end() ? registerTypeMap_.at(coreType) : defaultTypes;
    }

    const std::vector<ErrorRegisterTable>& GetErrorRegisterTable() const { return ErrorRegisterMap_; }

protected:
    // SU/MTE/CUBE/L1/DFX 段聚合为 AIC_DBG 表，SU/MTE/VEC/DFX 段聚合为 AIV_DBG 表。
    void GenAicDbgRegAddr()
    {
        std::vector<RegisterTable> regAICDbgTab;
        auto suTab = GenAicDbgRegSuAddr();
        auto mteTab = GenAicDbgRegMteAddr();
        auto cubeTab = GenAicDbgRegCubeAddr();
        auto l1Tab = GenAicDbgRegL1Addr();
        auto dfxTab = GenAicDfxRegAddr();
        regAICDbgTab.insert(regAICDbgTab.end(), suTab.begin(), suTab.end());
        regAICDbgTab.insert(regAICDbgTab.end(), mteTab.begin(), mteTab.end());
        regAICDbgTab.insert(regAICDbgTab.end(), cubeTab.begin(), cubeTab.end());
        regAICDbgTab.insert(regAICDbgTab.end(), l1Tab.begin(), l1Tab.end());
        regAICDbgTab.insert(regAICDbgTab.end(), dfxTab.begin(), dfxTab.end());
        registerTableMap_[RegisterType::AIC_DBG] = std::move(regAICDbgTab);
    }

    void GenAivDbgRegAddr()
    {
        std::vector<RegisterTable> regAIVDbgTab;
        auto suTab = GenAivDbgRegSuAddr();
        auto mteTab = GenAivDbgRegMteAddr();
        auto vecTab = GenAivDbgRegVecAddr();
        auto dfxTab = GenAivDfxRegAddr();
        regAIVDbgTab.insert(regAIVDbgTab.end(), suTab.begin(), suTab.end());
        regAIVDbgTab.insert(regAIVDbgTab.end(), mteTab.begin(), mteTab.end());
        regAIVDbgTab.insert(regAIVDbgTab.end(), vecTab.begin(), vecTab.end());
        regAIVDbgTab.insert(regAIVDbgTab.end(), dfxTab.begin(), dfxTab.end());
        registerTableMap_[RegisterType::AIV_DBG] = std::move(regAIVDbgTab);
    }

    // 步进展开：以 startAddr 为起点按 step 递增生成 count 个单寄存器条目（每个条目一次独立 RTS 读，不合并）。
    static void GenAddrByStep(
        std::vector<RegisterTable>& tab, uint64_t startAddr, uint32_t count, uint8_t byteWidth, uint64_t step)
    {
        for (uint32_t i = 0; i < count; i++) {
            tab.emplace_back(startAddr + i * step, 1, byteWidth);
        }
    }

    virtual std::vector<RegisterTable> GenAicDbgRegSuAddr() { return {}; }

    virtual std::vector<RegisterTable> GenAicDbgRegMteAddr() { return {}; }

    virtual std::vector<RegisterTable> GenAicDbgRegCubeAddr() { return {}; }

    virtual std::vector<RegisterTable> GenAicDbgRegL1Addr() { return {}; }

    virtual std::vector<RegisterTable> GenAicDfxRegAddr() { return {}; }

    virtual std::vector<RegisterTable> GenAivDbgRegSuAddr() { return {}; }

    virtual std::vector<RegisterTable> GenAivDbgRegMteAddr() { return {}; }

    virtual std::vector<RegisterTable> GenAivDbgRegVecAddr() { return {}; }

    virtual std::vector<RegisterTable> GenAivDfxRegAddr() { return {}; }

    // 直读偏移表（V2 无此通道，默认空；V4/V5 各自实现）。
    virtual void GenAICOffsetAddr() {}
    virtual void GenAIVOffsetAddr() {}
    virtual void InitErrorRegisters() {}

    // AIC/AIV 寄存器初始化公共序列：聚合 Debug 表 + 直读偏移表 + 错误寄存器表。
    // registerTypeMap_ 因平台而异（V2 仅 DBG 表），由派生类构造函数自行赋值。
    void InitAicAivRegisters()
    {
        GenAicDbgRegAddr();
        GenAivDbgRegAddr();
        GenAICOffsetAddr();
        GenAIVOffsetAddr();
        InitErrorRegisters();
    }

    std::map<RegisterType, std::vector<RegisterTable>> registerTableMap_;
    std::map<uint8_t, std::vector<RegisterType>> registerTypeMap_;
    std::vector<ErrorRegisterTable> ErrorRegisterMap_;
};

} // namespace Adx
#endif // COREDUMP_REGISTER_INTERFACE_H
