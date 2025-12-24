/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef REGISTER_CONFIG_H
#define REGISTER_CONFIG_H

#include <cstdint>
#include <vector>
#include <memory>
#include <map>
#include <string>

namespace Adx {

namespace {
constexpr uint32_t HIGH_ADDR_SHIFT = 48U;
constexpr uint32_t MOUDLE_TYPE_SHIFT = 52U;
}

struct RegisterTable {
    RegisterTable(uint64_t regStartAddr, uint32_t regNum, uint8_t regByteWidth):
        startAddr(regStartAddr), num(regNum), byteWith(regByteWidth) {}
    uint64_t startAddr;
    uint32_t num;
    uint8_t byteWith;
};

struct RegisterStepTable {
    uint64_t startAddr;
    uint32_t num;
    uint8_t byteWith;
    uint8_t step;
};

struct ErrorRegisterTable {
    ErrorRegisterTable(uint8_t regErrIndex, uint64_t regOffsetAddr, uint8_t regByteWidth, std::string regName):
        errIndex(regErrIndex), offsetAddr(regOffsetAddr), byteWidth(regByteWidth), name(regName) {}
    uint8_t errIndex;
    uint64_t offsetAddr;
    uint8_t byteWidth;
    std::string name;
};

enum class RegisterType {
    SU,
    VEC,
    MTE,
    CUBE,
    BIU,
    VEC_RB,
    BIF,
    L1,
    MTE_AIV,
};

class RegisterInterface {
public:
    RegisterInterface() = default;
    virtual ~RegisterInterface() = default;
    const std::vector<RegisterTable>& GetRegisterTable(RegisterType type) const;
    const std::vector<RegisterType>& GetRegisterTypes(uint8_t coreType) const;
    const std::vector<ErrorRegisterTable>& GetErrorRegisterTable() const;
protected:
    std::map<RegisterType, std::vector<RegisterTable>> registerTableMap_;
    std::map<uint8_t, std::vector<RegisterType>> registerTypeMap_;
    std::vector<ErrorRegisterTable> ErrorRegisterMap_;
};

class CloudV2Register : public RegisterInterface {
public:
    CloudV2Register();
    ~CloudV2Register() override {};
private:
    uint64_t GetAddr(uint64_t regAddrHigh, uint64_t regAddrLow) const;
};

class CloudV4Register : public RegisterInterface {
public:
    CloudV4Register();
    ~CloudV4Register() override {};
private:
    uint64_t GetAddr(uint64_t type, uint64_t regAddrHigh, uint64_t regAddrLow) const;
    void GenAddrByStep(RegisterType regType, const std::vector<RegisterStepTable> &regStepTab);
};

class RegisterManager {
public:
    RegisterManager();
    ~RegisterManager() {}
    static RegisterManager &GetInstance();
    const std::shared_ptr<RegisterInterface> GetRegister();

private:
    void CreateRegister();

    std::shared_ptr<RegisterInterface> register_;
};
}
#endif