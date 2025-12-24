/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ADUMP_EXCEPTION_DUMP_ELF_H
#define ADUMP_EXCEPTION_DUMP_ELF_H

#include <elf.h>
#include <vector>
#include <memory>
#include <string>
#include <sstream>
#include <fstream>
#include <map>

namespace Adx {
namespace ELF {

#define ASCEND_SHTYPE_GLOBAL                (SHT_LOUSER + 1)
#define ASCEND_SHTYPE_LOCAL                 (SHT_LOUSER + 2)
#define ASCEND_SHTYPE_REGS                  (SHT_LOUSER + 3)
#define ASCEND_SHTYPE_DEVTBL                (SHT_LOUSER + 4)
#define ASCEND_SHTYPE_AUXINFO_GLOABL        (SHT_LOUSER + 5)
#define ASCEND_SHTYPE_AUXINFO_LOCAL         (SHT_LOUSER + 6)
#define ASCEND_SHTYPE_HOST_KERNEL_OBJECT    (SHT_LOUSER + 7)
#define ASCEND_SHTYPE_FILE_KERNEL_OBJECT    (SHT_LOUSER + 8)
#define ASCEND_SHTYPE_FILE_KERNEL_JSON      (SHT_LOUSER + 9)

class Section {
public:
    explicit Section(Elf64_Word type);
    ~Section() = default;

    void SetData(std::string &data);
    void SetAddr(Elf64_Addr addr);
    void SetOffSet(Elf64_Off offset);
    void SetEntSize(Elf64_Word entSize);
    void SetNameIndex(Elf64_Word nameIndex);
    void SetLink(Elf64_Word link);
    void SetInfo(Elf64_Word info);
    void SetIndex(uint32_t index);
    uint32_t GetIndex() const;
    Elf64_Word GetSize() const;
    void SetAddrAlign(Elf64_Word addrAlign);
    Elf64_Word GetAddrAlign() const;
    void Save(std::ofstream &ofs, std::streampos headerPosition);

private:
    void SaveHeader(std::ofstream &ofs, std::streampos offset);
    void SaveData(std::ofstream &ofs);

    Elf64_Shdr header_{};
    std::string data_;
    uint32_t index_{0};
};

using SectionPtr = std::shared_ptr<Section>;

class DumpELF {
public:
    DumpELF();
    ~DumpELF() = default;

    SectionPtr AddSection(Elf64_Word type, const std::string &name);
    SectionPtr GetSectionByIndex(uint32_t index) const;
    void Save(const std::string &filename);

private:
    void CreateMandatorySection();
    SectionPtr CreateSection(Elf64_Word type);
    void LayoutSections();
    void LayoutSectionTable();
    void SetSectionHeaderStringTable();
    bool SaveHeader(std::ofstream &ofs) const;
    void SaveSections(std::ofstream &ofs);

    Elf64_Ehdr header_{};
    std::vector<SectionPtr> sections_;
    std::stringstream sectionNameStream_;
    std::map<std::string, Elf64_Word> sectionNameTable_;
    Elf64_Word currentFilePos_{0};
};

} // namespace ELF
} // namespace Adx

#endif // ADUMP_EXCEPTION_DUMP_ELF_H