/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "scd_elf.h"
#include <elf.h>
#include <link.h>
#include <sys/types.h>
#include "adiag_utils.h"
#include "scd_log.h"
#include "scd_dwarf.h"

#define SCD_ELF_FDE_ENTRY_SIZE      8U
#define SCD_ELF_SH_NAME_LENGTH      128U
#define SCD_UINTPTR_MAX             ((uintptr_t)(-1))
#define SCD_PF_X                    ((uint32_t)(PF_X))

uintptr_t ScdElfGetLoadBias(const ScdElf *elf)
{
    return elf->loadBias;
}

size_t ScdElfGetFdeNum(const ScdElf *elf)
{
    return elf->ehFrameHdrSize / SCD_ELF_FDE_ENTRY_SIZE;
}

/**
 * @brief       get function info based on pc
 * @param [in]  elf:        elf info
 * @param [in]  pc:         program counter
 * @param [out] funcName:   function name
 * @param [in]  len:        function name buffer length
 * @param [out] funcOffset: function offset in file
 * @return      NA
 */
void ScdElfGetFunctionInfo(ScdElf *elf, uintptr_t pc, char *funcName, size_t len, size_t *funcOffset)
{
    SCD_CHK_PTR_ACTION(elf, return);
    SCD_CHK_PTR_ACTION(funcName, return);
    SCD_CHK_PTR_ACTION(funcOffset, return);
    struct ListHead *pos = NULL;
    struct AdiagListNode *node = NULL;
    ScdDlSymbol *symbols = NULL;
    char buf[SCD_FUNC_NAME_LENGTH] = {0};
    // traverse all symbol section to find function symbol
    LIST_FOR_EACH(pos, &elf->symbolList.list) {
        node = LIST_ENTRY(pos, struct AdiagListNode, list);
        if (node == NULL) {
            return;
        }
        symbols = (ScdDlSymbol *)node->data;
        for (size_t offset = symbols->symOffset; offset < symbols->symEnd; offset += symbols->symEntrySize) {
            ElfW(Sym) *sym = (ElfW(Sym) *)ScdMemoryGetAddr(elf->memory, offset, sizeof(ElfW(Sym)));
            if (sym == NULL) {
                break;
            }
            // filter function symbol
            if ((sym->st_shndx == SHN_UNDEF) || (ELF64_ST_TYPE(sym->st_info) != STT_FUNC)) {
                continue;
            }

            size_t startOffset = sym->st_value + elf->memory->data + elf->loadBias;
            size_t endOffset = startOffset + sym->st_size;
            if ((pc < startOffset) || (pc >= endOffset)) {
                continue;
            }
            // st_name is the offset of symbol name in string table
            size_t strOffset = symbols->strOffset + sym->st_name;
            if (strOffset >= symbols->strEnd) {
                continue;
            }

            if (ScdMemoryReadString(elf->memory, strOffset, buf,
                SCD_MIN(SCD_FUNC_NAME_LENGTH, symbols->strEnd - strOffset)) == 0) {
                continue;
            }

            errno_t err = memcpy_s(funcName, len, buf, SCD_MIN(strlen(buf) + 1U, len));
            if (err != EOK) {
                SCD_DLOG_ERR("memcpy_s failed, err=%d.", (int32_t)err);
                return;
            }
            *funcOffset = pc - startOffset;
            return;
        }
    }
}

TraStatus ScdElfStep(ScdElf *elf, uintptr_t pc, ScdRegs *regs, bool isFirstStack)
{
    if (elf->ehFrameHdrOffset == 0) {
        STACKTRACE_LOG_RUN("elf of pc(0x%llx) does not have eh_frame_hdr section.", pc);
        return TRACE_FAILURE;
    }
    ScdDwarf dwarf = {0};
    const ScdDwarfStepArgs args = {ScdRegsGetSp(regs), SCD_UINTPTR_MAX, isFirstStack};
    dwarf.memory = elf->memory;
    dwarf.ehFrameHdrOffset = elf->ehFrameHdrOffset;
    dwarf.loadBias = elf->loadBias;
    SCD_DLOG_DBG("dwarf.ehFrameHdrOffset = 0x%llx, dwarf.loadBias = 0x%llx.", dwarf.ehFrameHdrOffset, dwarf.loadBias);
    dwarf.fdeCount = ScdElfGetFdeNum(elf);
    uintptr_t nextPc;
    // when the address read from the elf file is compared with the address in the memory, bias offset is required
    // pc is the address in the memory, so it needs to be subtracted by the bias offset
    TraStatus ret = ScdDwarfStep(&dwarf, regs, &args, pc - dwarf.loadBias, &nextPc);
    ScdRegsSetPc(regs, nextPc);
    return ret;
}

STATIC TraStatus ScdElfParseProgramHeaders(ScdElf *elf, ElfW(Ehdr) *ehdr)
{
    size_t phSize = (size_t)ehdr->e_phnum * (size_t)ehdr->e_phentsize;
    for (size_t i = 0; i < phSize; i += ehdr->e_phentsize) {
        ElfW(Phdr) *phdr = (ElfW(Phdr) *)ScdMemoryGetAddr(elf->memory, ehdr->e_phoff + i, sizeof(ElfW(Phdr)));
        SCD_CHK_PTR_ACTION(phdr, return TRACE_FAILURE);

        switch(phdr->p_type) {
            case PT_LOAD:
                if ((phdr->p_flags & SCD_PF_X) == 0) {
                    continue;
                }
                if (elf->loadBiasSave == false) {
                    elf->loadBias  = phdr->p_vaddr - phdr->p_offset;
                    elf->loadBiasSave = true;
                }
                break;
            case PT_GNU_EH_FRAME:
                elf->ehFrameHdrOffset = phdr->p_offset;
                elf->ehFrameHdrSize = phdr->p_memsz;
                elf->ehFrameHdrLoadBias = phdr->p_vaddr - phdr->p_offset;
                break;
            case PT_DYNAMIC:
                elf->dynamicOffset = phdr->p_offset;
                elf->dynamicSize = phdr->p_memsz;
                break;
            default:
                break;
        }
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus ScdElfGetStringSectionHeader(ScdElf *elf, ElfW(Ehdr) *ehdr, size_t *secOffset, size_t *secSize)
{
    ElfW(Shdr) *shdr = ScdMemoryGetAddr(elf->memory,
        ehdr->e_shoff + (uintptr_t)ehdr->e_shstrndx * (uintptr_t)ehdr->e_shentsize, sizeof(ElfW(Shdr)));
    if (shdr == NULL) {
        SCD_DLOG_ERR("read memory failed, get string table section header failed.");
        return TRACE_FAILURE;
    }
    *secOffset = shdr->sh_offset;
    *secSize = shdr->sh_size;
    return TRACE_SUCCESS;
}

STATIC void ScdElfHandleNote(ScdElf *elf, ElfW(Shdr) *shdr, size_t secOffset, size_t secSize)
{
    if (shdr->sh_name >= secSize) {
        return;
    }
    char name[SCD_ELF_SH_NAME_LENGTH] = { 0 };
    if (ScdMemoryReadString(elf->memory, secOffset + shdr->sh_name, name, sizeof(name)) == 0) {
        return;
    }
    if (strcmp(name, ".note.gnu.build-id") == 0) {
        elf->buildIdOffset = shdr->sh_offset;
        elf->buildIdSize = shdr->sh_size;
    }
    return;
}

STATIC TraStatus ScdElfHandleDynsym(ScdElf *elf, ElfW(Ehdr) *ehdr, ElfW(Shdr) *shdr)
{
    if (shdr->sh_link >= ehdr->e_shnum) {
        return TRACE_SUCCESS;
    }
    ElfW(Shdr) *strShdr = (ElfW(Shdr) *)ScdMemoryGetAddr(elf->memory,
        ehdr->e_shoff + (uintptr_t)shdr->sh_link * (uintptr_t)ehdr->e_shentsize, sizeof(ElfW(Shdr)));
    SCD_CHK_PTR_ACTION(strShdr, return TRACE_FAILURE);

    if (strShdr->sh_type != SHT_STRTAB) {
        return TRACE_SUCCESS;
    }
    ScdDlSymbol *symbol = (ScdDlSymbol *)AdiagMalloc(sizeof(ScdDlSymbol));
    SCD_CHK_PTR_ACTION(symbol, return TRACE_FAILURE);

    symbol->symOffset = shdr->sh_offset;
    symbol->symEnd = shdr->sh_offset + shdr->sh_size;
    symbol->symEntrySize = shdr->sh_entsize;
    symbol->strOffset = strShdr->sh_offset;
    symbol->strEnd = strShdr->sh_offset + strShdr->sh_size;

    AdiagStatus adiagRet = AdiagListInsert(&elf->symbolList, symbol);
    if (adiagRet != ADIAG_SUCCESS) {
        SCD_DLOG_ERR("add symbol to list failed.");
        ADIAG_SAFE_FREE(symbol);
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus ScdElfHandleProgbits(ScdElf *elf, ElfW(Shdr) *shdr, size_t secOffset, size_t secSize)
{
    if (shdr->sh_name >= secSize) {
        return TRACE_SUCCESS;
    }
    char name[SCD_ELF_SH_NAME_LENGTH] = { 0 };
    if (ScdMemoryReadString(elf->memory, secOffset + shdr->sh_name, name, sizeof(name)) == 0) {
        SCD_DLOG_ERR("read memory failed, get SHT_PROGBITS section failed.");
        return TRACE_FAILURE;
    }
    if (strcmp(name, ".eh_frame") == 0) {
        elf->ehFrameOffset = shdr->sh_offset;
        elf->ehFrameSize = shdr->sh_size;
        elf->ehFrameLoadBias = shdr->sh_addr - shdr->sh_offset;
    } else if(strcmp(name, ".eh_frame_hdr") == 0 && elf->ehFrameHdrOffset == 0) {
        elf->ehFrameHdrOffset = shdr->sh_offset;
        elf->ehFrameHdrSize = shdr->sh_size;
        elf->ehFrameHdrLoadBias = shdr->sh_addr - shdr->sh_offset;
    } else {
        ;
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus ScdElfParseSectionHeaders(ScdElf *elf, ElfW(Ehdr) *ehdr)
{
    size_t secOffset = 0;
    size_t secSize = 0;
    // get section header entry that contains the section names
    if (ehdr->e_shstrndx < ehdr->e_shnum) {
        if (ScdElfGetStringSectionHeader(elf, ehdr, &secOffset, &secSize) != TRACE_SUCCESS) {
            return TRACE_FAILURE;
        }
    }
    size_t ehSize = (size_t)ehdr->e_shnum * (size_t)ehdr->e_shentsize;
    for (size_t i = ehdr->e_shentsize; i < ehSize; i += ehdr->e_shentsize) {
        ElfW(Shdr) *shdr = (ElfW(Shdr) *)ScdMemoryGetAddr(elf->memory, ehdr->e_shoff + i, sizeof(ElfW(Shdr)));
        if (shdr == NULL) {
            SCD_DLOG_ERR("read memory failed, get section[%zu] failed.", i);
            return TRACE_FAILURE;
        }
        switch(shdr->sh_type) {
            case SHT_NOTE: {
                ScdElfHandleNote(elf, shdr, secOffset, secSize);
                break;
            }
            case SHT_SYMTAB:
            case SHT_DYNSYM: {
                if (ScdElfHandleDynsym(elf, ehdr, shdr) != TRACE_SUCCESS) {
                    return TRACE_FAILURE;
                }
                break;
            }
            case SHT_PROGBITS: {
                if (ScdElfHandleProgbits(elf, shdr, secOffset, secSize) != TRACE_SUCCESS) {
                    return TRACE_FAILURE;
                }
                break;
            }
            default:
                break;
        }
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus ScdElfCheckValid(ElfW(Ehdr) *ehdr)
{
    // check magic
    if (strncmp((const char *)ehdr->e_ident, (const char *)ELFMAG, SELFMAG) != 0) {
        SCD_DLOG_ERR("elf valid check failed, ehdr->e_ident = %s.", ehdr->e_ident);
        return TRACE_FAILURE;
    }

    return TRACE_SUCCESS;
}

STATIC TraStatus ScdElfParse(ScdElf *elf)
{
    // get ELF header
    ElfW(Ehdr) *ehdr = (ElfW(Ehdr) *)ScdMemoryGetAddr(elf->memory, 0, sizeof(ElfW(Ehdr)));
    SCD_CHK_PTR_ACTION(ehdr, return TRACE_FAILURE);

    TraStatus ret = ScdElfCheckValid(ehdr);
    if (ret != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }
    
    ret = ScdElfParseProgramHeaders(elf, ehdr);
    if (ret != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }

    ret = ScdElfParseSectionHeaders(elf, ehdr);
    if (ret != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }

    return TRACE_SUCCESS;
}

/**
 * @brief       load elf info from memory
 * @param [in]  elf:       elf info
 * @param [in]  pid:       process id
 * @param [in]  memory:    dynamic library memory
 * @return      TraStatus
 */
TraStatus ScdElfLoad(ScdElf *elf, int32_t pid, ScdMemory *memory)
{
    SCD_CHK_PTR_ACTION(elf, return TRACE_FAILURE);
    elf->pid = pid;
    elf->memory = memory;

    TraStatus ret = ScdElfParse(elf);
    if (ret != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }

    return TRACE_SUCCESS;
}

/**
 * @brief       init elf info
 * @param [in]  elf:       elf info
 * @return      TraStatus
 */
TraStatus ScdElfInit(ScdElf *elf)
{
    (void)memset_s(elf, sizeof(ScdElf), 0, sizeof(ScdElf));
    elf->loadBiasSave = false;
    return AdiagListInit(&elf->symbolList);
}

/**
 * @brief       uinit elf info
 * @param [in]  elf:       elf info
 * @return      NA
 */
void ScdElfUninit(ScdElf *elf)
{
    ScdDlSymbol *node = (ScdDlSymbol *)AdiagListTakeOut(&elf->symbolList);
    while (node != NULL) {
        ADIAG_SAFE_FREE(node);
        node = (ScdDlSymbol *)AdiagListTakeOut(&elf->symbolList);
    }
}