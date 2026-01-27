/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dump_core_checker.h"
#include <iostream>
#include <cstring>
#include "dump_ELF.h"

namespace Adx {

bool DumpCoreChecker::Load(const std::string& path)
{
    fileStream_.open(path, std::ios::binary);
    if (!fileStream_.is_open()) {
        std::cout << "Open dump core file" << path << " failed." << std::endl;
        return false;
    }

    if (!fileStream_.read((char*)(&header_), sizeof(header_))) {
        std::cout << "Read elf header failed." << std::endl;
        return false;
    }

    std::string secHeaderTable(header_.e_shentsize * header_.e_shnum, 0);
    if (!fileStream_.seekg(header_.e_shoff)) {
        std::cout << "Seek to section header table failed." << std::endl;
        return false;
    }
    if (!fileStream_.read((char*)secHeaderTable.data(), secHeaderTable.size())) {
        std::cout << "Read section header table failed." << std::endl;
        return false;
    }
    const Elf64_Shdr *secHeaderPtr = reinterpret_cast<const Elf64_Shdr*>(secHeaderTable.data());
    for (uint32_t i = 0; i < header_.e_shnum; ++i) {
        sections_.emplace_back(secHeaderPtr[i]);
    }

    shstrtab_.reserve(sections_[header_.e_shstrndx].sh_size);
    if (!fileStream_.seekg(sections_[header_.e_shstrndx].sh_offset)) {
        std::cout << "Seek to section header string table failed." << std::endl;
        return false;
    }

    if (!fileStream_.read((char*)shstrtab_.data(), sections_[header_.e_shstrndx].sh_size)) {
        std::cout << "Read section header string table failed." << std::endl;
        return false;
    }
    return true;
}

bool DumpCoreChecker::CheckElfHeader()
{
    return true;
}

bool DumpCoreChecker::CheckDevTbl(DevInfo &devInfo)
{
    bool isFind = false;
    for (const auto& section : sections_) {
        if (section.sh_type == ASCEND_SHTYPE_DEVTBL) {
            if (isFind) {
                std::cout << "find multi dev tbl section." << std::endl;
                return false;
            }
            if (section.sh_size != sizeof(DevInfo)) {
                std::cout << "check dev tbl section sh_size failed." << std::endl;
            }
            std::string sectionData(section.sh_size, 0);
            if (!fileStream_.seekg(section.sh_offset)) {
                std::cout << "Seek to dev tbl section content failed." << std::endl;
                return false;
            }
            if (!fileStream_.read((char*)sectionData.data(), section.sh_size)) {
                std::cout << "Read dev tbl section content failed." << std::endl;
                return false;
            }
            if (memcmp(sectionData.data(), &devInfo, section.sh_size) != 0) {
                std::cout << "check dev tbl section content failed." << std::endl;
                return false;
            }
            isFind = true;
        }
    }
    return isFind;
}

bool DumpCoreChecker::CheckGlobalMem(const std::vector<std::string>& globalMem, const std::vector<GlobalMemInfo> &globalMemInfo)
{
    std::string globalAuxInfo;
    uint32_t globalAuxInfoindex = 0;
    for (const auto& section : sections_) {
        if (section.sh_type == ASCEND_SHTYPE_AUXINFO_GLOABL) {
            if (section.sh_entsize != sizeof(GlobalMemInfo)) {
                std::cout << "check global auxinfo section sh_entsize failed." << std::endl;
                return false;
            }
            if (section.sh_size % section.sh_entsize != 0) {
                std::cout << "check global section size failed." << std::endl;
                return false;
            }
            if (section.sh_size / section.sh_entsize != globalMemInfo.size()) {
                std::cout << "check global section num failed." << std::endl;
                return false;
            }
            if (ASCEND_SHNAME_AUXINFO_GLOABL.compare(shstrtab_.data() + section.sh_name) != 0) {
                std::cout << "check global auxinfo section name failed." << std::endl;
                return false;
            }

            globalAuxInfo.reserve(section.sh_size);
            if (!fileStream_.seekg(section.sh_offset)) {
                std::cout << "Seek to global aux info failed." << std::endl;
                return false;
            }
            if (!fileStream_.read((char*)globalAuxInfo.data(), section.sh_size)) {
                std::cout << "Read global aux info failed." << std::endl;
                return false;
            }
            break;
        }
        globalAuxInfoindex++;
    }

    return CheckGlobalMem(globalAuxInfo, globalAuxInfoindex, globalMem, globalMemInfo);
}

bool DumpCoreChecker::CheckGlobalMem(std::string &globalAuxInfo, uint32_t globalAuxInfoindex,
    const std::vector<std::string>& globalMem, const std::vector<GlobalMemInfo> &globalMemInfo)
{
    const GlobalMemInfo *globalMemInfoPtr = reinterpret_cast<const GlobalMemInfo*>(globalAuxInfo.data());
    std::string sectionData;
    for (uint32_t i = 0; i < globalMem.size(); ++i) {
        // check GlobalMemInfo
        if (globalMemInfoPtr[i].devAddr != globalMemInfo[i].devAddr ||
            globalMemInfoPtr[i].size != globalMemInfo[i].size ||
            globalMemInfoPtr[i].type != globalMemInfo[i].type ||
            globalMemInfoPtr[i].extraInfo.shape.dim != globalMemInfo[i].extraInfo.shape.dim) {
            std::cout << "check global mem size failed." << std::endl;
            std::cout << "expect devAddr: " << std::hex << globalMemInfo[i].devAddr <<
                         ", size: " << std::dec << globalMemInfo[i].size <<
                         ", type: " << (uint32_t)globalMemInfo[i].type <<
                         ", shape dim: " << globalMemInfo[i].extraInfo.shape.dim << std::endl;
            std::cout << "but got devAddr: " << std::hex << globalMemInfoPtr[i].devAddr <<
                         ", size: " << std::dec << globalMemInfoPtr[i].size <<
                         ", type: " << (uint32_t)globalMemInfoPtr[i].type <<
                         ", shape dim: " << globalMemInfoPtr[i].extraInfo.shape.dim << std::endl;
            return false;
        }

        // check section header
        auto &section = sections_[globalMemInfoPtr[i].sectionIndex];
        if (ASCEND_SHNAME_GLOBAL.compare(shstrtab_.data() + section.sh_name) != 0 ||
            section.sh_type != ASCEND_SHTYPE_GLOBAL ||
            section.sh_size != globalMemInfoPtr[i].size ||
            section.sh_addr != globalMemInfoPtr[i].devAddr ||
            section.sh_link != globalAuxInfoindex ||
            section.sh_info != i) {
            std::cout << "expect section header sh_name: " << ASCEND_SHNAME_GLOBAL <<
                        ", sh_type: " << ASCEND_SHTYPE_GLOBAL <<
                        ", sh_flags: " << 0 <<
                        ", sh_addr: " << globalMemInfoPtr[i].devAddr <<
                        ", sh_size: " << globalMemInfoPtr[i].size <<
                        ", sh_link: " << globalAuxInfoindex <<
                        ", sh_info: " << i <<
                        ", sh_entsize: " << 0 << std::endl;
            std::cout << "but get section header sh_name: " << shstrtab_.data() + section.sh_name <<
                        ", sh_type: " << section.sh_type << ", sh_flags: " << section.sh_flags <<
                        ", sh_addr: " << section.sh_addr << ", sh_size: " << section.sh_size <<
                        ", sh_link: " << section.sh_link << ", sh_info: " << section.sh_info <<
                        ", sh_entsize: " << section.sh_entsize << std::endl;
            return false;
        }

        // check section content
        sectionData.reserve(globalMemInfo[i].size);
        if (!fileStream_.seekg(section.sh_offset)) {
            std::cout << "Seek to global section content failed, offset: " << section.sh_offset << std::endl;
            return false;
        }
        if (!fileStream_.read((char*)sectionData.data(), section.sh_size)) {
            std::cout << "Read global section content failed." << std::endl;
            return false;
        }
        if (memcmp(sectionData.data(), globalMem[i].data(), section.sh_size) != 0) {
            std::cout << "check global section content failed, index: " << i << std::endl;
            return false;
        }
    }
    return true;
}

bool DumpCoreChecker::CheckLocalMem(uint16_t coreId, const std::vector<std::string> &localMemList, const std::vector<LocalMemInfo>& localMemInfoList)
{
    std::string localAuxInfo;
    uint32_t localAuxInfoIndex = 0;
    bool result = false;
    uint32_t sectionNum = coreId < CORE_SIZE_AIC ? 7 : 4;       // aic(l0A l0B l0C L1 icache dcache2) aiv(UB icache dcache2)
    for (const auto& section : sections_) {
        if (section.sh_type == ASCEND_SHTYPE_AUXINFO_LOCAL) {
            if (ASCEND_SHNAME_AUXINFO_LOCAL.compare(0, ASCEND_SHNAME_AUXINFO_LOCAL.size(), shstrtab_.data() + section.sh_name, ASCEND_SHNAME_AUXINFO_LOCAL.size()) != 0) {
                std::cout << "check local auxinfo section name failed." << std::endl;
                return false;
            }
            std::string sectionName = ASCEND_SHNAME_AUXINFO_LOCAL + "." + std::to_string(coreId);
            if (sectionName.compare(shstrtab_.data() + section.sh_name) != 0) {
                localAuxInfoIndex++;
                continue;
            }
            result = true;

            if (section.sh_entsize != sizeof(LocalMemInfo)) {
                std::cout << "check local auxinfo section sh_entsize failed." << std::endl;
                return false;
            }
            if (section.sh_size % section.sh_entsize != 0) {
                std::cout << "check local section size failed." << std::endl;
                return false;
            }
            if (section.sh_size / section.sh_entsize != sectionNum) {
                std::cout << "check local section num failed." << std::endl;
                return false;
            }

            localAuxInfo.reserve(section.sh_size);
            if (!fileStream_.seekg(section.sh_offset)) {
                std::cout << "Seek to local aux info failed." << std::endl;
                return false;
            }
            if (!fileStream_.read((char*)localAuxInfo.data(), section.sh_size)) {
                std::cout << "Read local aux info failed." << std::endl;
                return false;
            }
            break;
        }
        localAuxInfoIndex++;
    }
    if (!result) {
        return false;
    }

    return CheckLocalMem(coreId, localAuxInfo, localAuxInfoIndex, localMemList, localMemInfoList);
}

bool DumpCoreChecker::CheckLocalMem(uint16_t coreId, std::string &localAuxInfo, uint32_t localAuxInfoIndex,
    const std::vector<std::string> &localMemList, const std::vector<LocalMemInfo>& localMemInfoList)
{
    const LocalMemInfo *localMemInfoPtr = reinterpret_cast<const LocalMemInfo*>(localAuxInfo.data());
    std::string sectionName = ASCEND_SHNAME_LOCAL + "." + std::to_string(coreId);
    for (uint32_t i = 0; i < localMemInfoList.size(); ++i) {
        if (localMemInfoPtr[i].size != localMemInfoList[i].size ||
            localMemInfoPtr[i].type != localMemInfoList[i].type) {
            std::cout << "check local mem size failed." << std::endl;
            std::cout << "expect size: " << std::dec << localMemInfoList[i].size <<
                         ", type: " << localMemInfoList[i].type << std::endl;
            std::cout << "but got size: " << std::dec << localMemInfoPtr[i].size <<
                         ", type: " << localMemInfoPtr[i].type << std::endl;
            return false;
        }

        auto &section = sections_[localMemInfoPtr[i].sectionIndex];
        if (sectionName.compare(shstrtab_.data() + section.sh_name) != 0 ||
            section.sh_type != ASCEND_SHTYPE_LOCAL ||
            section.sh_addr != 0 ||
            section.sh_size != localMemInfoPtr[i].size ||
            section.sh_link != localAuxInfoIndex ||
            section.sh_info != i) {
            std::cout << "expect section header sh_name: " << sectionName <<
                         ", sh_type: " << ASCEND_SHTYPE_LOCAL << ", sh_addr: " << 0 <<
                         ", sh_size: " << localMemInfoPtr[i].size << ", sh_link: " << localAuxInfoIndex <<
                         ", sh_info: " << i << ", sh_entsize: " << 0 << std::endl;
            std::cout << "but get section header sh_name: " << shstrtab_.data() + section.sh_name <<
                         ", sh_type: " << section.sh_type << ", sh_addr: " << section.sh_addr <<
                         ", sh_size: " << section.sh_size << ", sh_link: " << section.sh_link <<
                         ", sh_info: " << section.sh_info << ", sh_entsize: " << section.sh_entsize << std::endl;
            return false;
        }

        std::string localSectionData(section.sh_size, 0);
        if (!fileStream_.seekg(section.sh_offset)) {
            std::cout << "Seek to local section content failed." << std::endl;
            return false;
        }
        if (!fileStream_.read((char*)localSectionData.data(), section.sh_size)) {
            std::cout << "Read local section content failed." << std::endl;
            return false;
        }
        if (memcmp(localSectionData.data(), localMemList[i].data(), section.sh_size) != 0) {
            std::cout << "check local section content failed." << std::endl;
            return false;
        }
    }
    return true;
}

template<typename T>
bool DumpCoreChecker::CheckRegisters(uint16_t coreId, uint8_t validFlag)
{
    bool result = false;
    for (const auto& section : sections_) {
        if (section.sh_type == ASCEND_SHTYPE_REGS) {
            if (ASCEND_SHNAME_REGS.compare(0, ASCEND_SHNAME_REGS.size(), shstrtab_.data() + section.sh_name, ASCEND_SHNAME_REGS.size()) != 0) {
                std::cout << "check regs section name failed." << std::endl;
                return false;
            }
            std::string sectionName = ASCEND_SHNAME_REGS + "." + std::to_string(coreId);
            if (sectionName.compare(shstrtab_.data() + section.sh_name) != 0) {
                continue;
            }
            if (section.sh_entsize != sizeof(T)) {
                std::cout << "check regs section sh_entsize failed." << std::endl;
                return false;
            }
            if (section.sh_size % section.sh_entsize != 0) {
                std::cout << "check regs section size failed." << std::endl;
                return false;
            }
            std::string regData(section.sh_size, 0);
            if (!fileStream_.seekg(section.sh_offset)) {
                std::cout << "Seek to regs section content failed." << std::endl;
                return false;
            }
            if (!fileStream_.read((char*)regData.data(), section.sh_size)) {
                std::cout << "Read regs section content failed." << std::endl;
                return false;
            }
            if (!CheckRegisters<T>(regData, section.sh_size, validFlag)) {
                std::cout << "check regs section content failed." << std::endl;
                return false;
            }
        }
        result = true;
    }
    return result;
}

template<typename T>
bool DumpCoreChecker::CheckRegisters(std::string &regData, uint32_t size, uint8_t validFlag)
{
    const T *regInfoPtr = reinterpret_cast<const T*>(regData.data());
    uint32_t regNum = size / sizeof(T);
    for (uint32_t i = 0; i < regNum; ++i) {
        if (validFlag == REG_DATA_INVALID) {
            if (regInfoPtr[i].validFlag == REG_DATA_INVALID) {
                continue;
            } else {
                std::cout << "check regs invalid flag failed, index: " << i << ", addr: " << regInfoPtr[i].addr << std::endl;
                return false;
            }
        }
        if (memcmp(&regInfoPtr[i].addr, &regInfoPtr[i].value, sizeof(regInfoPtr[i].addr)) != 0) {
            std::cout << "check regs section content failed, index: " << i << std::endl;
            return false;
        }
        if (regInfoPtr[i].validFlag != REG_DATA_VALID) {
            std::cout << "check regs valid flag failed, index: " << i << ", addr: " << regInfoPtr[i].addr << std::endl;
            return false;
        }
    }
    return true;
}
template bool DumpCoreChecker::CheckRegisters<RegInfo>(std::string&, uint32_t, uint8_t);
template bool DumpCoreChecker::CheckRegisters<RegInfoWide>(std::string&, uint32_t, uint8_t);
template bool DumpCoreChecker::CheckRegisters<RegInfo>(uint16_t, uint8_t);
template bool DumpCoreChecker::CheckRegisters<RegInfoWide>(uint16_t, uint8_t);
}