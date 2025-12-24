/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dump_ELF.h"
#include "log/adx_log.h"
#include "mmpa_api.h"

namespace Adx{
namespace ELF{

namespace {
constexpr Elf64_Half EM_HIIPU = 0x1029;
constexpr Elf64_Word EV_VERSION = 0x01;
constexpr Elf64_Word ADD_ALIGN = 16;
const std::string STRTAB_SECTION_NAME = ".shstrtab";
}

Section::Section(Elf64_Word type)
{
    header_.sh_type = type;
}

void Section::SetData(std::string &data)
{
    data_ = std::move(data);
    header_.sh_size = data_.size();
}

void Section::SetAddr(Elf64_Addr addr)
{
    header_.sh_addr = addr;
}

void Section::SetOffSet(Elf64_Off offset)
{
    header_.sh_offset = offset;
}

void Section::SetEntSize(Elf64_Word entSize)
{
    header_.sh_entsize = entSize;
}

void Section::SetNameIndex(Elf64_Word nameIndex)
{
    header_.sh_name = nameIndex;
}

void Section::SetLink(Elf64_Word link)
{
    header_.sh_link = link;
}

void Section::SetInfo(Elf64_Word info)
{
    header_.sh_info = info;
}

void Section::SetIndex(uint32_t index)
{
    index_ = index;
}

uint32_t Section::GetIndex() const
{
    return index_;
}

void Section::Save(std::ofstream &ofs, std::streampos headerPosition)
{
    SaveHeader(ofs, headerPosition);
    SaveData(ofs);
}

void Section::SaveHeader(std::ofstream &ofs, std::streampos offset)
{
    ofs.seekp(offset);
    ofs.write(reinterpret_cast<const char *>(&header_), sizeof(header_));
}

void Section::SaveData(std::ofstream &ofs)
{
    ofs.seekp(header_.sh_offset);
    ofs.write(data_.c_str(), data_.size());
}

Elf64_Word Section::GetSize() const
{
    return header_.sh_size;
}

void Section::SetAddrAlign(Elf64_Word addrAlign)
{
    header_.sh_addralign = addrAlign;
}

Elf64_Word Section::GetAddrAlign() const
{
    return header_.sh_addralign;
}

DumpELF::DumpELF()
{
    header_.e_ident[EI_MAG0] = ELFMAG0;
    header_.e_ident[EI_MAG1] = ELFMAG1;
    header_.e_ident[EI_MAG2] = ELFMAG2;
    header_.e_ident[EI_MAG3] = ELFMAG3;
    header_.e_ident[EI_CLASS] = ELFCLASS64;
    header_.e_ident[EI_DATA] = ELFDATA2LSB;
    header_.e_ident[EI_VERSION] = EV_CURRENT;
    header_.e_ehsize = sizeof(Elf64_Ehdr);
    header_.e_type = ET_CORE;
    header_.e_machine = EM_HIIPU;
    header_.e_version = EV_VERSION;
    CreateMandatorySection();
}

SectionPtr DumpELF::CreateSection(Elf64_Word type)
{
    try {
        sections_.emplace_back(std::make_shared<Section>(type));
        sections_.back()->SetIndex(static_cast<uint32_t>(sections_.size() - 1));
        return sections_.back();
    } catch (std::exception &ex) {
        IDE_LOGE("Section make shared failed, strerr=%s", ex.what());
        return nullptr;
    }
}

void DumpELF::CreateMandatorySection()
{
    // first section is null section
    SectionPtr sec0 = CreateSection(SHT_NULL);
    IDE_CTRL_VALUE_FAILED(sec0 != nullptr, return, "Create first NULL section failed");
    sectionNameStream_ << '\0';
    sec0->SetNameIndex(0);
}

SectionPtr DumpELF::AddSection(Elf64_Word type, const std::string &name)
{
    SectionPtr newSection = CreateSection(type);
    if (newSection == nullptr) {
        return nullptr;
    }

    Elf64_Word nameIndex = 0;
    if (sectionNameTable_.find(name) != sectionNameTable_.end()) {
        nameIndex = sectionNameTable_[name];
    } else {
        nameIndex = sectionNameStream_.tellp();
        sectionNameStream_ << name << '\0';
        sectionNameTable_[name] = nameIndex;
    }
    newSection->SetNameIndex(nameIndex);

    return newSection;
}

SectionPtr DumpELF::GetSectionByIndex(uint32_t index) const
{
    IDE_CTRL_VALUE_FAILED(index < sections_.size(), return nullptr, "Get section failed, index %u out of range %u",
        index, sections_.size());

    return sections_[index];
}

void DumpELF::Save(const std::string &filename)
{
    IDE_CTRL_VALUE_FAILED(mmAccess2(filename.c_str(), F_OK) != EN_OK, return,
        "file %s already exist", filename.c_str());

    int32_t fd = mmOpen2(filename.c_str() ,M_RDWR | M_CREAT, M_IRUSR | M_IWUSR);
    IDE_CTRL_VALUE_FAILED(fd >= 0, return, "open file %s failed, strerr=%s", filename.c_str(), strerror(errno));
    close(fd);

    std::ofstream ofs(filename, std::ios::binary);
    IDE_CTRL_VALUE_FAILED(ofs.is_open(), return, "open file %s failed, strerr=%s", filename.c_str(), strerror(errno));

    SetSectionHeaderStringTable();

    header_.e_shentsize = sizeof(Elf64_Shdr);
    header_.e_shnum = sections_.size();

    currentFilePos_ = sizeof(Elf64_Ehdr);
    LayoutSections();
    LayoutSectionTable();

    if (!SaveHeader(ofs)) {
        IDE_LOGE("Failed to save ELF header");
        ofs.close();
        return;
    }
    SaveSections(ofs);

    ofs.close();
    IDE_LOGE("Save dump file %s", filename.c_str());

    int32_t err = mmChmod(filename.c_str(), M_IRUSR);  // 落盘文件置为最小权限:用户只读, 400
    IDE_CTRL_VALUE_WARN(err == 0, return, "mmChmod %s failed, strerr=%s", filename.c_str(), strerror(errno));
}

void DumpELF::SetSectionHeaderStringTable()
{
    SectionPtr section = AddSection(SHT_STRTAB, STRTAB_SECTION_NAME);
    IDE_CTRL_VALUE_WARN(section != nullptr, return, "Create %s section failed.", STRTAB_SECTION_NAME.c_str());
    std::string data = sectionNameStream_.str();
    section->SetData(data);
    header_.e_shstrndx = sections_.size() - 1;
}

void DumpELF::LayoutSections()
{
    for (const auto &section : sections_) {
        Elf64_Word sectionAlign = section->GetAddrAlign();
        if ((sectionAlign > 1) && (currentFilePos_ % sectionAlign != 0)) {
            currentFilePos_ += sectionAlign - (currentFilePos_ % sectionAlign);
        }
        section->SetOffSet(currentFilePos_);
        currentFilePos_ += section->GetSize();
    }
}

void DumpELF::LayoutSectionTable()
{
    currentFilePos_ += ADD_ALIGN - (currentFilePos_ % ADD_ALIGN);
    header_.e_shoff = currentFilePos_;
}

bool DumpELF::SaveHeader(std::ofstream &ofs) const
{
    ofs.seekp(0);
    ofs.write(reinterpret_cast<const char *>(&header_), sizeof(header_));
    return ofs.good();
}

void DumpELF::SaveSections(std::ofstream &ofs)
{
    for (uint32_t i = 0; i < sections_.size(); ++i) {
        std::streampos headerPosition = header_.e_shoff + i * sizeof(Elf64_Shdr);
        sections_[i]->Save(ofs, headerPosition);
        IDE_CTRL_VALUE_FAILED_NODO(ofs.good(), continue, "save section %u failed", i);
    }
}

}
}
