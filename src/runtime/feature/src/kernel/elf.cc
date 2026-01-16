/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "elf.hpp"
#include <cstdlib>
#include "securec.h"
#include "logger.hpp"
#include "error_message_manage.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "driver.hpp"

namespace {
constexpr int32_t ELF_SUCCESS = 0;
constexpr int32_t ELF_FAIL = 1;
const std::string ELF_SECTION_DATA = ".data";
const std::string ELF_SECTION_CCE_KERNEL_META_DATA = "__CCE_KernelMetaData";
const std::string ELF_SECTION_PREFIX_ASCEND_META = ".ascend.meta.";
const std::string ELF_SECTION_ASCEND_META = ".ascend.meta";
const std::string ELF_SECTION_ASCEND_STACK_SIZE_RECORD  = ".ascend.stack.size.record";
const std::string ELF_SECTION_MIX_KERNEL_AIV = "_mix_aiv";
const std::string ELF_SECTION_MIX_KERNEL_AIC = "_mix_aic";
}

namespace cce {
namespace runtime {
static int32_t GetFileHeader(rtElfData * const elfData);
static __THREAD_LOCAL__ uint64_t (*GetByte)(const uint8_t [], const int32_t) = nullptr;

uint64_t ByteGetBigEndian(const uint8_t field[], const int32_t size)
{
    uint64_t ret = 0UL;

    switch (size) {
        case 1:
            ret = static_cast<uint64_t>(*field);
            break;
        case 2:
            ret = (static_cast<uint64_t>(field[1U])) | ((static_cast<uint64_t>(field[0U])) << 8U); // shift 8 bit
            break;
        case 3:
            ret = (static_cast<uint64_t>(field[2U])) | ((static_cast<uint64_t>(field[1U])) << 8U) |
                ((static_cast<uint64_t>(field[0U])) << 16U);
            break;
        case 4:
            ret = (static_cast<uint64_t>(field[3U])) | ((static_cast<uint64_t>(field[2U])) << 8U) |
                ((static_cast<uint64_t>(field[1U])) << 16U) | ((static_cast<uint64_t>(field[0U])) << 24U);
            break;
        case 5:
            ret = (static_cast<uint64_t>(field[4U])) | ((static_cast<uint64_t>(field[3U])) << 8U) |
                ((static_cast<uint64_t>(field[2U])) << 16U) | ((static_cast<uint64_t>(field[1U])) << 24U) |
                ((static_cast<uint64_t>(field[0U])) << 32U);
            break;
        case 6:
            ret = (static_cast<uint64_t>(field[5U])) | ((static_cast<uint64_t>(field[4U])) << 8U) |
                ((static_cast<uint64_t>(field[3U])) << 16U) | ((static_cast<uint64_t>(field[2U])) << 24U) |
                ((static_cast<uint64_t>(field[1U])) << 32U) | ((static_cast<uint64_t>(field[0U])) << 40U);
            break;
        case 7:
            ret = (static_cast<uint64_t>(field[6U])) | ((static_cast<uint64_t>(field[5U])) << 8U) |
                ((static_cast<uint64_t>(field[4U])) << 16U) | ((static_cast<uint64_t>(field[3U])) << 24U) |
                ((static_cast<uint64_t>(field[2U])) << 32U) | ((static_cast<uint64_t>(field[1U])) << 40U) |
                ((static_cast<uint64_t>(field[0U])) << 48U);
            break;
        case 8:
            ret = (static_cast<uint64_t>(field[7U])) | ((static_cast<uint64_t>(field[6U])) << 8U) |
                ((static_cast<uint64_t>(field[5U])) << 16U) | ((static_cast<uint64_t>(field[4U])) << 24U) |
                ((static_cast<uint64_t>(field[3U])) << 32U) | ((static_cast<uint64_t>(field[2U])) << 40U) |
                ((static_cast<uint64_t>(field[1U])) << 48U) | ((static_cast<uint64_t>(field[0U])) << 56U);
            break;
        default:
            RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,
                "Unhandled data length: size = %d", size);
            break;
    }

    return ret;
}

uint64_t ByteGetLittleEndian(const uint8_t field[], const int32_t size)
{
    uint64_t ret = 0UL;

    switch (size) {
        case 1:
            ret = static_cast<uint64_t>(*field);
            break;
        case 2:
            ret = (static_cast<uint64_t>(field[0U])) | ((static_cast<uint64_t>(field[1U])) << 8U); // shift 8 bit
            break;
        case 3:
            ret = (static_cast<uint64_t>(field[0U])) |
                ((static_cast<uint64_t>(field[1U])) << 8U) | ((static_cast<uint64_t>(field[2U])) << 16U);
            break;
        case 4:
            ret = (static_cast<uint64_t>(field[0U])) | ((static_cast<uint64_t>(field[1U])) << 8U) |
                ((static_cast<uint64_t>(field[2U])) << 16U) | ((static_cast<uint64_t>(field[3U])) << 24U);
            break;
        case 5:
            ret = (static_cast<uint64_t>(field[0U])) | ((static_cast<uint64_t>(field[1U])) << 8U) |
                ((static_cast<uint64_t>(field[2U])) << 16U) | ((static_cast<uint64_t>(field[3U])) << 24U) |
                ((static_cast<uint64_t>(field[4U])) << 32U);
            break;
        case 6: /* Fall through.  */
            ret = (static_cast<uint64_t>(field[0U])) | ((static_cast<uint64_t>(field[1U])) << 8U) |
                ((static_cast<uint64_t>(field[2U])) << 16U) | ((static_cast<uint64_t>(field[3U])) << 24U) |
                ((static_cast<uint64_t>(field[4U])) << 32U) | ((static_cast<uint64_t>(field[5U])) << 40U);
            break;
        case 7:
            ret = (static_cast<uint64_t>(field[0U])) | ((static_cast<uint64_t>(field[1U])) << 8U) |
                ((static_cast<uint64_t>(field[2U])) << 16U) | ((static_cast<uint64_t>(field[3U])) << 24U) |
                ((static_cast<uint64_t>(field[4U])) << 32U) | ((static_cast<uint64_t>(field[5U])) << 40U) |
                ((static_cast<uint64_t>(field[6U])) << 48U);
            break;
        case 8:
            ret = (static_cast<uint64_t>(field[0U])) | ((static_cast<uint64_t>(field[1U])) << 8U) |
                ((static_cast<uint64_t>(field[2U])) << 16U) | ((static_cast<uint64_t>(field[3U])) << 24U) |
                ((static_cast<uint64_t>(field[4U])) << 32U) | ((static_cast<uint64_t>(field[5U])) << 40U) |
                ((static_cast<uint64_t>(field[6U])) << 48U) | ((static_cast<uint64_t>(field[7U])) << 56U);
            break;
        default:
            RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,
                "Unhandled data length:, size = %d", size);
            break;
    }

    return ret;
}

std::unique_ptr<char_t[]> GetStringTableCopy(const char_t * const src, const uint64_t size)
{
    /* Check for overflow. */
    if (size > ((~(static_cast<uint64_t>(0)) - 1ULL))) {
        return nullptr;
    }

    /* + 1 so that we can '\0' terminate invalid string table sections.  */
    std::unique_ptr<char_t[]> strTbl(new (std::nothrow) char_t[size + 1UL]);
    if (strTbl == nullptr) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Get string table copy failed, new failed, size = %" PRIu64, size);
        return nullptr;
    }

    char_t * const stringTbl = strTbl.get();
    stringTbl[size] = '\0';
    const errno_t ret = memcpy_s(stringTbl, size, src, size);
    if (ret != EOK) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Get string table copy failed, memcpy_s failed, size=%" PRIu64 ", retCode=%d",
            size, ret);
        return nullptr;
    }
    return strTbl;
}

int32_t Get64bitSectionHeaders(rtElfData * const elfData)
{
    if (elfData == nullptr) {
        return ELF_FAIL;
    }
    Elf64_External_Shdr *shdrs = nullptr;
    Elf_Internal_Shdr *internalShdrs = nullptr;
    uint32_t i;
    const uint32_t size = elfData->elf_header.e_shentsize;
    const uint32_t num = elfData->elf_header.e_shnum;

    /* Cope with unexpected section header sizes.  */
    if ((size == 0U) || (num == 0U) || (num > ((~(static_cast<uint64_t>(0))) / size))) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,
            "The value of e_shentsize field or e_shnum is incorrect, e_shentsize = %u, e_shnum = %u",
            size, num);
        return ELF_FAIL;
    }

    if (size != sizeof(*shdrs)) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,
            "The value of e_shentsize field is inconsistent with the size of an ELF section header.");
        return ELF_FAIL;
    }

    shdrs = RtPtrToPtr<Elf64_External_Shdr *>(elfData->obj_ptr_origin + elfData->elf_header.e_shoff);
    if (shdrs == nullptr) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "shdrs is null");
        return ELF_FAIL;
    }

    elfData->section_headers = new (std::nothrow) Elf_Internal_Shdr[num];
    if (elfData->section_headers == nullptr) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "New section headers failed, num = %u", num);
        return ELF_FAIL;
    }

    internalShdrs = elfData->section_headers;
    for (i = 0U; (i < num) && (GetByte != nullptr); i++) {
        const uint64_t objOffset = RtPtrToValue(shdrs + (i + 1)) - RtPtrToValue(elfData->obj_ptr_origin);
        if (objOffset > elfData->obj_size) {
            RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "Section %u is out of obj, num:%u, e_shoff:%" PRIu64 ", "
                "Elf64_External_Shdr size:%zu, obj size:%" PRIu64 ".", i, num, elfData->elf_header.e_shoff,
                sizeof(Elf64_External_Shdr), elfData->obj_size);
            return ELF_FAIL;
        }

        internalShdrs->sh_name = static_cast<uint32_t>(GetByte(static_cast<const uint8_t *>(shdrs[i].sh_name), 4));
        internalShdrs->sh_type = static_cast<uint32_t>(GetByte(static_cast<const uint8_t *>(shdrs[i].sh_type), 4));
        internalShdrs->sh_flags = GetByte(static_cast<const uint8_t *>(shdrs[i].sh_flags), 8);
        internalShdrs->sh_addr = GetByte(static_cast<const uint8_t *>(shdrs[i].sh_addr), 8);
        internalShdrs->sh_size = GetByte(static_cast<const uint8_t *>(shdrs[i].sh_size), 8);
        internalShdrs->sh_entsize = GetByte(static_cast<const uint8_t *>(shdrs[i].sh_entsize), 8);
        internalShdrs->sh_link = static_cast<uint32_t>(GetByte(static_cast<const uint8_t *>(shdrs[i].sh_link), 8));
        internalShdrs->sh_info = static_cast<uint32_t>(GetByte(static_cast<const uint8_t *>(shdrs[i].sh_info), 8));
        internalShdrs->sh_offset = GetByte(static_cast<const uint8_t *>(shdrs[i].sh_offset), 8);
        internalShdrs->sh_addralign = GetByte(static_cast<const uint8_t *>(shdrs[i].sh_addralign), 8);
        if (internalShdrs->sh_link > num) {
            RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,
                " Section %u sh_link value is invalid, current sh_link value is %u,"
                "valid sh_link value range is [%u, %u]!",
                i, internalShdrs->sh_link, 0U, num);
            return ELF_FAIL;
        }
        internalShdrs++;
    }

    return ELF_SUCCESS;
}

std::unique_ptr<Elf_Internal_Sym[]> Get64bitElfSymbols(const rtElfData * const elfData,
                                                       const Elf_Internal_Shdr * const section,
                                                       uint64_t * const numSymsReturn)
{
    if ((elfData == nullptr) || (section == nullptr) || (numSymsReturn == nullptr)) {
        return nullptr;
    }

    uint64_t number;
    Elf64_External_Sym *esyms = nullptr;
    Elf_Internal_Sym *psym = nullptr;
    uint32_t j;
    *numSymsReturn = 0UL;

    if (section->sh_size == 0ULL) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "Section->shsize: %" PRIu64 " is NULL.",
            section->sh_size);
        return nullptr;
    }

    /* Run some sanity checks first.  */
    if ((section->sh_entsize == 0ULL) || (section->sh_entsize > section->sh_size)) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "Section has an out of range, current sh_entsize: %" PRIu64
            "range is (%u, %" PRIu64 "]!", section->sh_entsize, 0U, section->sh_size);
        return nullptr;
    }
    number = section->sh_size / section->sh_entsize;

    if ((number * sizeof(Elf64_External_Sym)) > (section->sh_size + 1ULL)) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,
            "Section has an out of range Elf64_External_Sym: %zu!",
            sizeof(Elf64_External_Sym));
        return nullptr;
    }

    esyms = RtPtrToPtr<Elf64_External_Sym *>(elfData->obj_ptr_origin + section->sh_offset);
    if (esyms == nullptr) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "esyms is null");
        return nullptr;
    }

    std::unique_ptr<Elf_Internal_Sym[]> isyms(new (std::nothrow) Elf_Internal_Sym[number]);
    if (isyms == nullptr) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "New symbols failed, num = %" PRIu64, number);
        return nullptr;
    }

    psym = isyms.get();
    for (j = 0U; (j < number) && (GetByte != nullptr); j++) {
        const uint64_t objOffset = RtPtrToValue(esyms + (j + 1)) - RtPtrToValue(elfData->obj_ptr_origin);
        if (objOffset > elfData->obj_size) {
            RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,
                "j:%u, number:%" PRIu64 ", Elf64_External_Sym size:%zu, sh_offset:%" PRIu64 ", obj_size:%" PRIu64 ".",
                j, number, sizeof(Elf64_External_Sym), section->sh_offset, elfData->obj_size);
            return nullptr;
        }

        psym->st_name = GetByte(static_cast<const uint8_t *>(esyms[j].st_name), 4);
        psym->st_info = static_cast<uint8_t>(GetByte(static_cast<const uint8_t *>(esyms[j].st_info), 1));
        psym->st_other = static_cast<uint8_t>(GetByte(static_cast<const uint8_t *>(esyms[j].st_other), 1));
        psym->st_shndx = static_cast<uint32_t>(GetByte(static_cast<const uint8_t *>(esyms[j].st_shndx), 2));
        psym->st_value = GetByte(static_cast<const uint8_t *>(esyms[j].st_value), 8);
        psym->st_size = GetByte(static_cast<const uint8_t *>(esyms[j].st_size), 8);
        psym->st_target_internal = 0U;
        psym++;
    }

   *numSymsReturn = number;

    return isyms;
}

static bool CheckKernelAttr(const Elf_Internal_Sym * const pSym)
{
    return ((ELF_ST_TYPE(pSym->st_info) == static_cast<uint32_t>(STT_FUNC)) &&
        (ELF_ST_BIND(pSym->st_info) == static_cast<uint32_t>(STB_GLOBAL)) &&
        (ELF_STV_TYPE(pSym->st_other) != static_cast<uint32_t>(STV_HIDDEN)) && (pSym->st_name != 0ULL));
}

static uint32_t GetSymbolName(const char_t *stringTab, const Elf_Internal_Sym * const psym,
    const uint64_t numSyms, rtElfData * const elfData)
{
    uint64_t si;
    const Elf_Internal_Sym *internalSym = psym;
    Runtime *rtInstance = Runtime::Instance();
    COND_RETURN_ERROR_MSG_INNER(rtInstance == nullptr, RT_ERROR_INSTANCE_NULL, "Runtime instance is null");
    if (stringTab == nullptr) {
        return RT_ERROR_NONE;
    }
    for (si = 0; si < numSyms; si++) {
        if (ELF_ST_TYPE(internalSym->st_info) == STT_OBJECT) {
            if (internalSym->st_shndx >= elfData->elf_header.e_shnum) {
                return RT_ERROR_NONE;
            }
            std::string symbol;
            (void)symbol.assign(stringTab + internalSym->st_name);
            char_t *src = elfData->obj_ptr_origin;
            Elf_Internal_Shdr *internalShdr = elfData->section_headers + internalSym->st_shndx;
            RT_LOG(RT_LOG_DEBUG, "st_name=%s, st_value=%llu, size=%llu, idx=%u",
                stringTab + internalSym->st_name, internalSym->st_value, internalSym->st_size, internalSym->st_shndx);
            rtInstance->ExeCallbackFillFunc(symbol,
                static_cast<void *>(src + internalSym->st_value + internalShdr->sh_offset - internalShdr->sh_addr),
                static_cast<uint32_t>(internalSym->st_size));
        }
        internalSym++;
    }
    return RT_ERROR_NONE;
}

rtError_t RefreshSymbolAddress(rtElfData *elfData)
{
    Runtime *rtInstance = Runtime::Instance();
    Context * const curCtx = rtInstance->CurrentContext();
    if (curCtx == nullptr) {
        return RT_ERROR_NONE;
    }
    const uint32_t drvDeviceId = static_cast<uint32_t>(curCtx->Device_()->Id_());
    Driver * const curDrv = curCtx->Device_()->Driver_();
    uint64_t sourceAddr = 0;
    if (((elfData->ascendMetaFlag & KERNEL_PRINT_FIFO_ADDR_BIT) != 0) && (elfData->symbolAddr.g_sysPrintFifoSpace != nullptr)) {
        uint64_t *addr = elfData->symbolAddr.g_sysPrintFifoSpace;
        const rtError_t error = curCtx->Device_()->GetPrintFifoAddress(&sourceAddr);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Get printf fifo space address failed!");
        *addr = sourceAddr;
        RT_LOG(RT_LOG_DEBUG, "Set global variable address in binary, g_sysPrintFifoSpace = %p, addr = %p", *addr, addr);
    }
    if (((elfData->ascendMetaFlag & KERNEL_FFTS_ADDR_BIT) != 0) && (elfData->symbolAddr.g_sysFftsAddr != nullptr)) {
        uint64_t *addr = elfData->symbolAddr.g_sysFftsAddr;
        uint32_t sourceAddrLen = 0;
        const rtError_t error = curDrv->GetC2cCtrlAddr(drvDeviceId, &sourceAddr, &sourceAddrLen);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Get ffts address failed!");
        *addr = sourceAddr;
        RT_LOG(RT_LOG_DEBUG, "Set global variable address in binary, g_sysFftsAddr = %p, addr = %p", *addr, addr);
    }
    if (((elfData->ascendMetaFlag & KERNEL_SYSTEM_RUN_CFG_ADDR_BIT) != 0) && (elfData->symbolAddr.g_opL2CacheHintCfg != nullptr)) {
        uint64_t *addr = elfData->symbolAddr.g_opL2CacheHintCfg;
        const rtError_t error = curDrv->GetL2CacheOffset(drvDeviceId, &sourceAddr);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Get L2Cache address failed!");
        *addr = sourceAddr;
        RT_LOG(RT_LOG_DEBUG, "Set global variable address in binary, g_opL2CacheHintCfg = %p, addr = %p", *addr, addr);
    }

    return RT_ERROR_NONE;
}

void SetSymbolAddress(const char_t *stringTab, const Elf_Internal_Sym * const psym,
    const uint64_t numSyms, rtElfData * const elfData)
{
    uint64_t si = 0;
    const Elf_Internal_Sym *internalSym = psym;

    for (si = 0; si < numSyms; si++) {
        if (ELF_ST_TYPE(internalSym->st_info) == STT_OBJECT) {
            if (internalSym->st_shndx >= elfData->elf_header.e_shnum) {
                return;
            }
            std::string symbol;
            (void)symbol.assign(stringTab + internalSym->st_name);
            char_t *src = elfData->obj_ptr_origin;
            Elf_Internal_Shdr *internalShdr = elfData->section_headers + internalSym->st_shndx;
            RT_LOG(RT_LOG_DEBUG, "st_name=%s, st_value=%llu, size=%llu, idx=%u",
                stringTab + internalSym->st_name, internalSym->st_value, internalSym->st_size, internalSym->st_shndx);
            uint64_t *addr = RtPtrToPtr<uint64_t *>(src + internalSym->st_value + internalShdr->sh_offset - internalShdr->sh_addr);
            if (((elfData->ascendMetaFlag & KERNEL_PRINT_FIFO_ADDR_BIT) != 0) && (symbol ==  "g_sysPrintFifoSpace")) {
                // 维侧空间地址
                elfData->symbolAddr.g_sysPrintFifoSpace = addr;
                RT_LOG(RT_LOG_DEBUG, "Parse Elf, &g_sysPrintFifoSpace = %p", addr);
            }
            if (((elfData->ascendMetaFlag & KERNEL_FFTS_ADDR_BIT) != 0) && (symbol ==  "g_sysFftsAddr")) {
                // FFTS 硬同步地址
                elfData->symbolAddr.g_sysFftsAddr = addr;
                RT_LOG(RT_LOG_DEBUG, "Parse Elf, &g_sysFftsAddr = %p", addr);
            }
            if (((elfData->ascendMetaFlag & KERNEL_SYSTEM_RUN_CFG_ADDR_BIT) != 0) && (symbol == "g_opL2CacheHintCfg")) {
                // 双页表地址
                elfData->symbolAddr.g_opL2CacheHintCfg = addr;
                RT_LOG(RT_LOG_DEBUG, "Parse Elf, &g_opL2CacheHintCfg = %p", addr);
            }
        }
        internalSym++;
    }
}

static uint32_t GetFuncNum(const Elf_Internal_Sym * const psym, const uint64_t numSyms)
{
    uint32_t si;
    uint32_t funcNum = 0U;

    const Elf_Internal_Sym *internalSym = psym;
    for (si = 0U; si < numSyms; si++) {
        if (ELF_ST_TYPE(internalSym->st_info) == static_cast<uint32_t>(STT_FUNC)) {
            funcNum++;
        }
        internalSym++;
    }

    return funcNum;
}

static void ElfParseKernelArgNum(const uint8_t * const buf, ElfKernelInfo *tlvInfo)
{
    ElfTlvHead *tlvHead = (ElfTlvHead *)buf;
    uint16_t tlvLength = static_cast<uint16_t>(GetByte(RtPtrToPtr<const uint8_t *>(&(tlvHead->length)),
        static_cast<int32_t>(sizeof(uint16_t))));
    if (tlvLength == 0U) {
        return;
    }

    const uint8_t *curBuf = buf + sizeof(ElfTlvHead);
    uint16_t remainLen = tlvLength - static_cast<uint16_t>(sizeof(ElfTlvHead));

    uint16_t tlvType;
    uint16_t argNum = 1U; // reserve for overflow
    while (remainLen > sizeof(ElfTlvHead)) {
        tlvHead = (ElfTlvHead *)curBuf;
        // Attention: this is special, should use ByteGetBigEndian, do not use GetByte
        tlvType = static_cast<uint16_t>(ByteGetBigEndian(RtPtrToPtr<const uint8_t *>(&(tlvHead->type)),
            static_cast<int32_t>(sizeof(uint16_t))));
        tlvLength = static_cast<uint16_t>(ByteGetBigEndian(RtPtrToPtr<const uint8_t *>(&(tlvHead->length)),
            static_cast<int32_t>(sizeof(uint16_t))));
        tlvLength *= 8U; // this is special

        if ((sizeof(ElfTlvHead) + tlvLength) > remainLen) {
            break;
        }

        if (tlvType == static_cast<uint16_t>(FUNC_META_TYPE_DFX_ARG_INFO)) {
            argNum++;
        }
        curBuf = curBuf + sizeof(ElfTlvHead) + tlvLength;
        remainLen = remainLen - static_cast<uint16_t>(sizeof(ElfTlvHead) + tlvLength);
    }

    tlvInfo->userArgsNum = argNum;
}

static void setMetaFlag(rtElfData * const elfData, uint32_t type)
{
    uint32_t bit = 0U;
    switch (type) {
        case KERNEL_PRINT_FIFO_ADDR:
            bit = KERNEL_PRINT_FIFO_ADDR_BIT;
            RT_LOG(RT_LOG_INFO, "Enable print fifo addr flag");
            break;
        case KERNEL_FFTS_ADDR:
            bit = KERNEL_FFTS_ADDR_BIT;
            RT_LOG(RT_LOG_INFO, "Enable ffts addr flag");
            break;
        case KERNEL_SYSTEM_RUN_CFG_ADDR:
            bit = KERNEL_SYSTEM_RUN_CFG_ADDR_BIT;
            RT_LOG(RT_LOG_INFO, "Enable system run cfg addr flag");
            break;
        default:
            break;
    }
    elfData->ascendMetaFlag |= bit;
}

static void ElfParseBinaryTlvInfo(rtElfData * const elfData, uint16_t tlvType, const uint8_t *buf)
{
    const ElfBinaryAddrInfo *addrInfo = nullptr;
    uint32_t type = 0;

    switch (static_cast<uint32_t>(tlvType)) {
        case RT_BINARY_TYPE_BIN_VERSION:
            break;
        case RT_BINARY_TYPE_RUNTIME_IMPLICIT_INFO:
            addrInfo = RtPtrToPtr<const ElfBinaryAddrInfo *>(buf);
            type = addrInfo->type;
            setMetaFlag(elfData, type);
            break;
        default:
            break;
    }
}

static rtError_t ElfParseTlvInfo(uint16_t tlvType, const uint8_t *buf, ElfKernelInfo *tlvInfo)
{
    const ElfFuncTypeInfo *typeInfo = nullptr;
    const ElfKernelSyncInfo *syncInfo = nullptr;
    const ElfTaskRationInfo *taskRationInfo = nullptr;
    const ElfKernelAivTypeInfo *aivTypeInfo = nullptr;
    const ElfKernelReportSzInfo *reportSzInfo = nullptr;
    const ElfKernelMinStackSizeInfo *minStackSizeInfo = nullptr;
    const ElfKernelFunctionEntryInfo *functionEntryInfo = nullptr;
    uint32_t aivType = 0U;
    uint16_t tlvLength = 0U;

    switch (static_cast<int32_t>(tlvType)) {
        case FUNC_META_TYPE_KERNEL_TYPE:
            typeInfo = RtPtrToPtr<const ElfFuncTypeInfo *>(buf);
            tlvInfo->funcType =
                static_cast<uint32_t>(GetByte(RtPtrToPtr<const uint8_t *>(&(typeInfo->funcType)),
                sizeof(uint32_t)));
            break;
        case FUNC_META_TYPE_CROSS_CORE_TYPE:
            syncInfo = RtPtrToPtr<const ElfKernelSyncInfo *>(buf);
            tlvInfo->crossCoreSync =
                static_cast<uint32_t>(GetByte(RtPtrToPtr<const uint8_t *>(&(syncInfo->crossCoreSync)),
                sizeof(uint32_t)));
            break;
        case FUNC_META_TYPE_MIX_TASK_RATION:
            taskRationInfo = RtPtrToPtr<const ElfTaskRationInfo *>(buf);
            tlvInfo->taskRation[0] =
                static_cast<uint16_t>(GetByte(RtPtrToPtr<const uint8_t *>(&(taskRationInfo->taskRation[0])),
                sizeof(uint16_t)));
            tlvInfo->taskRation[1] =
                static_cast<uint16_t>(GetByte(RtPtrToPtr<const uint8_t *>(&(taskRationInfo->taskRation[1])),
                sizeof(uint16_t)));
            break;
        case FUNC_META_TYPE_DFX_TYPE:
            ElfParseKernelArgNum(buf, tlvInfo);
            break;
        case FUNC_META_TYPE_AIV_TYPE_FLAG:
            aivTypeInfo = RtPtrToUnConstPtr<ElfKernelAivTypeInfo*>(RtPtrToPtr<const ElfKernelAivTypeInfo*>(buf));
            aivType = static_cast<uint32_t>(GetByte(RtPtrToPtr<const uint8_t *>(&(aivTypeInfo->aivType)),
                sizeof(uint32_t)));
            tlvInfo->simtFlag = (aivType == static_cast<uint32_t>(AivTypeFlag::AIV_TYPE_SIMT_VF_ONLY)) ||
                                (aivType == static_cast<uint32_t>(AivTypeFlag::AIV_TYPE_SIMD_SIMT_MIX_VF));
            RT_LOG(RT_LOG_INFO, "aivType=%u", aivType);
            break;
        case FUNC_META_TYPE_COMPILER_ALLOC_UB_SIZE:
            reportSzInfo = RtPtrToPtr<const ElfKernelReportSzInfo *>(buf);
            tlvInfo->shareMemSize = static_cast<uint32_t>(
                GetByte(RtPtrToPtr<const uint8_t *>(&(reportSzInfo->shareMemSize)), sizeof(uint32_t)));
            tlvInfo->shareMemSizeFlag = true;
            RT_LOG(RT_LOG_INFO, "shareMemSize=%u.", tlvInfo->shareMemSize);
            break;
        case FUNC_META_TYPE_SU_STACK_SIZE:
            minStackSizeInfo = RtPtrToPtr<const ElfKernelMinStackSizeInfo *>(buf);
            tlvLength = static_cast<uint16_t>(
                GetByte(RtPtrToPtr<const uint8_t *, const uint16_t *>(&(minStackSizeInfo->head.length)),
                    static_cast<int32_t>(sizeof(uint16_t))));
            tlvInfo->minStackSize = static_cast<uint32_t>(
                GetByte(RtPtrToPtr<const uint8_t *, const uint32_t *>(&(minStackSizeInfo->minStackSize)), tlvLength));
            RT_LOG(RT_LOG_INFO, "tlvLength=%u, minStackSize=%u.", tlvLength, tlvInfo->minStackSize);
            break;
        case FUNCTION_META_TYPE_FUNCTION_ENTRY_INFO:
            functionEntryInfo = RtPtrToPtr<const ElfKernelFunctionEntryInfo *>(buf);
            tlvLength = static_cast<uint16_t>(
                GetByte(RtPtrToPtr<const uint8_t *, const uint16_t *>(&(functionEntryInfo->head.length)),
                    static_cast<int32_t>(sizeof(uint16_t))));
            tlvInfo->functionEntryFlag = functionEntryInfo->flag;
            tlvInfo->isSupportFuncEntry = true;
            tlvInfo->functionEntry = functionEntryInfo->functionEntry;
            RT_LOG(RT_LOG_INFO, "tlvLength=%u, isSupportFuncEntry=%d, functionEntryFlag=%u, functionEntry=%" PRIu64 ".", 
                tlvLength, tlvInfo->isSupportFuncEntry, tlvInfo->functionEntryFlag, tlvInfo->functionEntry);
            break;
        default:
            break;
    }

    return RT_ERROR_NONE;
}

void GetKernelTlvInfo(const uint8_t *buf, uint32_t bufLen, ElfKernelInfo *tlvInfo)
{
    uint32_t remainLen = bufLen;
    ElfTlvHead *tlvHead;
    uint16_t tlvType;
    uint16_t tlvLength;
    const uint8_t *curBuf = buf;

    while (remainLen > sizeof(ElfTlvHead)) {
        tlvHead = (ElfTlvHead *)curBuf;
        tlvType = static_cast<uint16_t>(GetByte(RtPtrToPtr<const uint8_t *>(&(tlvHead->type)),
            sizeof(uint16_t)));
        tlvLength = static_cast<uint16_t>(GetByte(RtPtrToPtr<const uint8_t *>(&(tlvHead->length)),
            sizeof(uint16_t)));
        if ((sizeof(ElfTlvHead) + tlvLength) > remainLen) {
            break;
        }

        if (ElfParseTlvInfo(tlvType, curBuf, tlvInfo) != RT_ERROR_NONE) {
            break;
        }

        curBuf = curBuf + sizeof(ElfTlvHead) + tlvLength;
        remainLen = remainLen - (sizeof(ElfTlvHead) + tlvLength);
    }

    return;
}

bool GetMixStatus(uint32_t funcType, uint32_t crossCoreSync)
{
    bool isSupportMix = false;
    switch (funcType) {
        case KERNEL_FUNCTION_TYPE_AICORE:
            isSupportMix = false;
            break;
        case KERNEL_FUNCTION_TYPE_AIC:
        case KERNEL_FUNCTION_TYPE_AIC_ROLLBACK:
            if (crossCoreSync == FUNC_USE_SYNC) {
                isSupportMix = true;
            }
            break;
        case KERNEL_FUNCTION_TYPE_AIV:
        case KERNEL_FUNCTION_TYPE_AIV_ROLLBACK:
            if (crossCoreSync == FUNC_USE_SYNC) {
                isSupportMix = true;
            }
            break;
        case KERNEL_FUNCTION_TYPE_MIX_AIC_MAIN:
        case KERNEL_FUNCTION_TYPE_MIX_AIV_MAIN:
            isSupportMix = true;
            break;
        default:
            isSupportMix = false;
            break;
    }
    return isSupportMix;
}

void ParseElfStackInfoHeader(rtElfData * const elfData)
{
    const uint64_t elfVersion = elfData->elf_header.e_version;
    const uint32_t stackType = static_cast<uint32_t>(GET_STACK_TYPE(elfVersion));
    if (GET_VERSION_MAGIC(elfVersion) != ELF_VERSION_MAGIC) {
        RT_LOG(RT_LOG_EVENT, "Check elf version is not match, elfVersion=%llu.", elfVersion);
        return;
    }

    if ((stackType != KERNEL_STACK_TYPE_16K) && (stackType != KERNEL_STACK_TYPE_32K)) {
        RT_LOG(RT_LOG_EVENT, "Check elf stack type is not match, stackType=%u.", stackType);
        return;
    }

    uint64_t stackSize = KERNEL_STACK_SIZE_32K;
    if (stackType == KERNEL_STACK_TYPE_16K) {
        stackSize = KERNEL_STACK_SIZE_16K;
    }

    elfData->stackSize = stackSize;

    return;
}

void ParseElfBinaryMetaInfo(rtElfData * const elfData, const uint8_t *buf, uint64_t bufLen, const std::string &stringTab)
{
    if (stringTab.compare(ELF_SECTION_ASCEND_META) != 0) {
        return;
    }

    uint64_t remainLen = bufLen;
    const uint8_t *curBuf = buf;

    while (remainLen > sizeof(ElfTlvHead)) {
        const ElfTlvHead *tlvHead = RtPtrToPtr<const ElfTlvHead *>(curBuf);
        const uint16_t tlvType = static_cast<uint16_t>(GetByte(RtPtrToPtr<const uint8_t *>(&(tlvHead->type)),
            sizeof(uint16_t)));
        const uint16_t tlvLength = static_cast<uint16_t>(GetByte(RtPtrToPtr<const uint8_t *>(&(tlvHead->length)),
            sizeof(uint16_t)));
        if ((sizeof(ElfTlvHead) + tlvLength) > remainLen) {
            break;
        }

        ElfParseBinaryTlvInfo(elfData, tlvType, curBuf);
        curBuf = curBuf + sizeof(ElfTlvHead) + tlvLength;
        remainLen = remainLen - (sizeof(ElfTlvHead) + tlvLength);
    }

    RT_LOG(RT_LOG_INFO, "section name = %s, flag=%u.", stringTab.c_str(), elfData->ascendMetaFlag);
    return;
}

void ParseElfStackInfoFromSection(rtElfData * const elfData, const uint8_t *buf, uint32_t bufLen)
{
    if ((bufLen < sizeof(uint64_t)) || ((bufLen % sizeof(uint64_t)) != 0U)) {
        RT_LOG(RT_LOG_ERROR, "stack info is invalid, bufLen=%u", bufLen);
        return;
    }

    const uint64_t stackSize = static_cast<uint64_t>(GetByte(buf, sizeof(uint64_t)));
    if ((stackSize != KERNEL_STACK_SIZE_16K) && (stackSize != KERNEL_STACK_SIZE_32K)) {
        RT_LOG(RT_LOG_EVENT, "stack size is invalid, stackSize=%llu", stackSize);
        return;
    }

    const uint32_t size = bufLen / static_cast<uint32_t>(sizeof(uint64_t));

    for (uint32_t index = 1U; index < size; index++) {
        const uint8_t *curBuf = buf + index * sizeof(uint64_t);
        const uint64_t stackSizeTemp = static_cast<uint64_t>(GetByte(curBuf, sizeof(uint64_t)));
        if (stackSizeTemp != stackSize) {
            RT_LOG(RT_LOG_ERROR, "stack size is invalid, stackSize=%llu, expect size=%llu",
                stackSizeTemp, stackSize);
            return;
        }
    }

    elfData->stackSize = stackSize;

    return;
}

bool CheckShareMemSizeValid(const ElfKernelInfo *const kernelInfo)
{
    if (kernelInfo->simtFlag) {
        if (!kernelInfo->shareMemSizeFlag) {
            RT_LOG(RT_LOG_ERROR, "kernel has simtFlag no reportShareMemSize");
            return false;
        }

        if (kernelInfo->shareMemSize > RT_SIMT_REMAIN_UB_SIZE) {
            RT_LOG(RT_LOG_ERROR, "reportShareMemSize is invalid, shareMemSize=%u, maxShareMemSize=%u.",
                kernelInfo->shareMemSize, RT_SIMT_REMAIN_UB_SIZE);
            return false;
        }
    }
    return true;
}

void UpdateFuncTypeByProgType(ElfKernelInfo * const kernelInfo, const uint32_t progType, bool *isUpdate)
{
    if (*isUpdate == false) {
        return;
    }

    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_ELF_INCLUDE_STACK_SIZE)) {
        *isUpdate = false;
        return;
    }

    switch (progType) {
        case Program::MACH_AI_CORE:
            kernelInfo->funcType = KERNEL_FUNCTION_TYPE_AIC;
            break;
        case Program::MACH_AI_VECTOR:
            kernelInfo->funcType = KERNEL_FUNCTION_TYPE_AIV;
            break;
        default:
            break;
    }
    if (kernelInfo->funcType == KERNEL_FUNCTION_TYPE_INVALID) {
        *isUpdate = false;
    }
}

static void kernelInfoInit(rtElfData * const elfData, Elf_Internal_Shdr *section, ElfKernelInfo * const kernelInfo) {
    kernelInfo->funcType = static_cast<uint32_t>(KERNEL_FUNCTION_TYPE_INVALID);
    kernelInfo->crossCoreSync = static_cast<uint32_t>(FUNC_NO_USE_SYNC);
    kernelInfo->taskRation[0] = 0U; // init value 0
    kernelInfo->taskRation[1] = 0U; // init value 0
    kernelInfo->simtFlag = false;
    kernelInfo->shareMemSizeFlag = false;
    kernelInfo->shareMemSize = 0U;
    kernelInfo->dfxAddr = (RtPtrToPtr<uint8_t *>(elfData->obj_ptr_origin) + section->sh_offset);
    kernelInfo->dfxSize = static_cast<uint16_t>(section->sh_size);
    kernelInfo->elfDataFlag = static_cast<int32_t>(elfData->elf_header.e_ident[EI_DATA]);
    kernelInfo->functionEntry = 0U;
    kernelInfo->functionEntryFlag = KERNEL_FUNCTION_ENTRY_DISABLE;
    kernelInfo->isSupportFuncEntry = false;
}

static void ParseKernelMetaData(rtElfData * const elfData, Elf_Internal_Shdr *section,
                          std::map<std::string, ElfKernelInfo *> &kernelInfoMap,
                          bool *isSupportMix, bool *isUpdate, const uint32_t progType)
{
    std::unique_ptr<char_t[]> strTab = nullptr;

    const Elf_Internal_Shdr * const stringSec = elfData->section_headers + elfData->elf_header.e_shstrndx;
    if (stringSec->sh_size == 0ULL) {
        return;
    }

    if (((stringSec->sh_offset + stringSec->sh_size) > elfData->obj_size) ||
        (stringSec->sh_offset > elfData->obj_size) ||
        (stringSec->sh_size > elfData->obj_size)) {
        RT_LOG(RT_LOG_ERROR, "sh_offset:%" PRIu64 ", sh_size:%" PRIu64 ", obj_size:%" PRIu64 ".",
            stringSec->sh_offset, stringSec->sh_size, elfData->obj_size);
        return;
    }

    strTab = GetStringTableCopy(elfData->obj_ptr_origin + stringSec->sh_offset, stringSec->sh_size);
    if (strTab == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Get String Table failed");
        return;
    }
    // sh_name has beed checked in get_dynamic_section
    const std::string stringTab = std::string(strTab.get() + section->sh_name);
    if (stringTab.compare(ELF_SECTION_DATA) == 0) {
        elfData->dataFlag = true;
        RT_LOG(RT_LOG_INFO, "dataFlag=%u", elfData->dataFlag);
    }
    RT_LOG(RT_LOG_INFO, "section name = %s.", stringTab.c_str());
    if (stringTab.compare(ELF_SECTION_CCE_KERNEL_META_DATA) == 0) {
        uint32_t *degenerateFlag = RtPtrToPtr<uint32_t *>(RtPtrToPtr<uint8_t *>(elfData->obj_ptr_origin) +
            section->sh_offset);
        elfData->degenerateFlag = static_cast<bool>(*degenerateFlag);
        RT_LOG(RT_LOG_DEBUG, "Get degenerate symbol value is %u", *degenerateFlag);
    } else if (stringTab.find(ELF_SECTION_PREFIX_ASCEND_META) != std::string::npos) {
        std::string kernelName;
        const size_t kernelNameLen = stringTab.size() - ELF_SECTION_PREFIX_ASCEND_META.size();
        if (unlikely((kernelNameLen >= static_cast<size_t>(NAME_MAX_LENGTH))) || (kernelNameLen == 0U)) {
            RT_LOG(RT_LOG_WARNING, "kernel_name=%s is too long or is empty, skip it",
                stringTab.substr(ELF_SECTION_PREFIX_ASCEND_META.size()).c_str());
            return;
        }

        ElfKernelInfo * const kernelInfo = new (std::nothrow) ElfKernelInfo();
        if (kernelInfo == nullptr) {
            return;
        }

        kernelInfoInit(elfData, section, kernelInfo);
        GetKernelTlvInfo((RtPtrToPtr<uint8_t *>(elfData->obj_ptr_origin) + section->sh_offset),
            static_cast<uint32_t>(section->sh_size), kernelInfo);

        const bool mixStatus = GetMixStatus(kernelInfo->funcType, kernelInfo->crossCoreSync);
        const rtChipType_t chipType = Runtime::Instance()->GetChipType();
        if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_MIX) || mixStatus) {
            *isSupportMix = true;
        } else {
            *isSupportMix = false;
        }
        if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_TYPE_AICORE_MIX)
            && (kernelInfo->funcType == KERNEL_FUNCTION_TYPE_AICORE)) {
            *isSupportMix = false;
        }
        *isUpdate = *isSupportMix;
        *isUpdate = (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_TYPE_UPDATE_NO_MIX)) ?
            true : *isUpdate;
        if (kernelInfo->funcType == static_cast<uint32_t>(KERNEL_FUNCTION_TYPE_INVALID)) {
            *isSupportMix = false;
            UpdateFuncTypeByProgType(kernelInfo, progType, isUpdate);
        }
        (void)kernelName.assign(stringTab.substr(ELF_SECTION_PREFIX_ASCEND_META.size()));
        if (!CheckShareMemSizeValid(kernelInfo)) {
            RT_LOG(RT_LOG_ERROR, "kernel_name=%s, checkShareMemSizeValid"
                "funcType=%u, simtFlag=%d, shareMemSizeFlag=%d, shareMemSize=%u.",
                kernelName.c_str(), kernelInfo->funcType, kernelInfo->simtFlag,
                kernelInfo->shareMemSizeFlag, kernelInfo->shareMemSize);
            delete kernelInfo;
            return;
        }
        kernelInfoMap[kernelName] = kernelInfo;
        RT_LOG(RT_LOG_INFO, "kernel_name=%s, ration[0]=%u, ration[1]=%u, isSupportMix=%d, isUpdate=%d, "
            "dfxAddr=0x%llx, dfxSize=%u, "
            "funcType=%u, crossCoreSync=%u, simtFlag=%d, shareMemSizeFlag=%d, shareMemSize=%u, minStackSize=%u, "
            "isSupportFuncEntry=%d, functionEntryFlag=%u, functionEntry=%" PRIu64 ".",
            kernelName.c_str(), kernelInfo->taskRation[0], kernelInfo->taskRation[1], *isSupportMix, *isUpdate, 
            RtPtrToValue(kernelInfo->dfxAddr), kernelInfo->dfxSize,
            kernelInfo->funcType, kernelInfo->crossCoreSync,
            kernelInfo->simtFlag, kernelInfo->shareMemSizeFlag, kernelInfo->shareMemSize, kernelInfo->minStackSize,
            kernelInfo->isSupportFuncEntry, kernelInfo->functionEntryFlag, kernelInfo->functionEntry);
    } else if (stringTab.find(ELF_SECTION_ASCEND_STACK_SIZE_RECORD) != std::string::npos) {
        ParseElfStackInfoFromSection(elfData, (RtPtrToPtr<uint8_t *>(elfData->obj_ptr_origin) + section->sh_offset),
            static_cast<uint32_t>(section->sh_size));
    } else {
        ParseElfBinaryMetaInfo(elfData, (RtPtrToPtr<uint8_t *>(elfData->obj_ptr_origin) + section->sh_offset),
            section->sh_size, stringTab);
    }

    return;
}

static void KernelInfoMapRelease(std::map<std::string, ElfKernelInfo *>& kernelInfoMap)
{
    for (auto iter = kernelInfoMap.begin(); iter != kernelInfoMap.end(); ++iter) {
        const ElfKernelInfo * const kernelInfo = iter->second;
        delete kernelInfo;
    }
}

static rtError_t SetTaskRationAndResult(uint32_t funcType, std::vector<uint32_t>& funcTypeList,
    uint32_t resRation, uint32_t* taskRation)
{
    bool found = false;
    rtError_t result = RT_ERROR_NONE;
    for (auto it = funcTypeList.begin(); it != funcTypeList.end(); ++it) {
        if (*it  == funcType) {
            found = true;
            *taskRation = resRation;
            break;
        }
    }
    if (!found) {
        RT_LOG(RT_LOG_ERROR, "error funcType=%u", funcType);
        result = RT_ERROR_INVALID_VALUE;
    }
    funcTypeList.clear();
    return result;
}

uint32_t GetRatioEnum(ElfKernelInfo * elfKernelInfo)
{
    std::map<std::string, Ratio> ratioMap {{"1:2", RATION_TYPE_ONE_RATIO_TWO},
        {"2:1", RATION_TYPE_TWO_RATIO_ONE}, {"1:1", RATION_TYPE_ONE_RATIO_ONE},
        {"1:0", RATION_TYPE_ONE_RATIO_ZERO}, {"0:1", RATION_TYPE_ZERO_RATIO_ONE}
    };

    std::string rationKey = std::to_string(elfKernelInfo->taskRation[0]) + ":"
        + std::to_string(elfKernelInfo->taskRation[1]);

    auto it = ratioMap.find(rationKey);
    if (it == ratioMap.end()) {
        RT_LOG(RT_LOG_ERROR, "error cubeRatio=%u, vectorRatio=%u",
            elfKernelInfo->taskRation[0], elfKernelInfo->taskRation[1]);
        return RATION_TYPE_MAX;
    }

    return it->second;
}

rtError_t ConvertTaskRation(ElfKernelInfo * elfKernelInfo, uint32_t& taskRation)
{
    if (elfKernelInfo == nullptr) {
        RT_LOG(RT_LOG_ERROR, "elfKernelInfo is null");
        return RT_ERROR_INVALID_VALUE;
    }
    if (elfKernelInfo->funcType == KERNEL_FUNCTION_TYPE_AIC ||
        elfKernelInfo->funcType == KERNEL_FUNCTION_TYPE_AIV ||
        elfKernelInfo->funcType == KERNEL_FUNCTION_TYPE_AIC_ROLLBACK ||
        elfKernelInfo->funcType == KERNEL_FUNCTION_TYPE_AIV_ROLLBACK) {
        taskRation = 0U;
        return RT_ERROR_NONE;
    }

    std::vector<uint32_t> targetFuncTypeList;
    rtError_t result = RT_ERROR_NONE;
    uint32_t ratioEnum = GetRatioEnum(elfKernelInfo);
    RT_LOG(RT_LOG_DEBUG, "functionType=%u, ratioValue=%u", elfKernelInfo->funcType, ratioEnum);
    switch (ratioEnum) {
        case RATION_TYPE_ONE_RATIO_TWO:
            targetFuncTypeList.push_back(KERNEL_FUNCTION_TYPE_MIX_AIC_MAIN);
            result = SetTaskRationAndResult(elfKernelInfo->funcType, targetFuncTypeList, 2U, &taskRation);
            break;
        case RATION_TYPE_TWO_RATIO_ONE:
            targetFuncTypeList.push_back(KERNEL_FUNCTION_TYPE_MIX_AIV_MAIN);
            result = SetTaskRationAndResult(elfKernelInfo->funcType, targetFuncTypeList, 2U, &taskRation);
            break;
        case RATION_TYPE_ONE_RATIO_ONE:
            targetFuncTypeList.push_back(KERNEL_FUNCTION_TYPE_MIX_AIC_MAIN);
            targetFuncTypeList.push_back(KERNEL_FUNCTION_TYPE_MIX_AIV_MAIN);
            result = SetTaskRationAndResult(elfKernelInfo->funcType, targetFuncTypeList, 1U, &taskRation);
            break;
        case RATION_TYPE_ONE_RATIO_ZERO:
            targetFuncTypeList.push_back(KERNEL_FUNCTION_TYPE_MIX_AIC_MAIN);
            result = SetTaskRationAndResult(elfKernelInfo->funcType, targetFuncTypeList, 0U, &taskRation);
            break;
        case RATION_TYPE_ZERO_RATIO_ONE:
            targetFuncTypeList.push_back(KERNEL_FUNCTION_TYPE_MIX_AIV_MAIN);
            result = SetTaskRationAndResult(elfKernelInfo->funcType, targetFuncTypeList, 0U, &taskRation);
            break;
        default:
            result = RT_ERROR_INVALID_VALUE;
            break;
    }
    return result;
}

rtError_t UpdateKernelsInfo(std::map<std::string, ElfKernelInfo *>& kernelInfoMap,
                            RtKernel * const kernels, rtElfData * const elfData, bool* isSupportMix)
{
    const uint32_t kernelNum = elfData->kernel_num;
    const uint32_t mapSize = kernelInfoMap.size();
    if (mapSize == 0U) {
        return RT_ERROR_NONE;
    }

    if (mapSize > kernelNum) {
        RT_LOG(RT_LOG_ERROR, "kernel num is not match, kernelNum=%u, mapSize is %u.",
               kernelNum, mapSize);
        return RT_ERROR_INVALID_VALUE;
    }
    if (mapSize < kernelNum) {
        RT_LOG(RT_LOG_INFO, "kernel num is not match, kernelNum=%u, mapSize is %u. change isSupportMix to false",
               kernelNum, mapSize);
        *isSupportMix = false;
        return RT_ERROR_NONE;
    }

    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    bool isSupportKernelTaskRation =
        IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_TASK_RATION);
    for (uint32_t index = 0U; index < kernelNum; index++) {
        const auto iter = kernelInfoMap.find(std::string(kernels[index].name));
        if (iter == kernelInfoMap.end()) {
            RT_LOG(RT_LOG_ERROR, "kernel_name=%s get kernel type failed.", kernels[index].name);
            return RT_ERROR_INVALID_VALUE;
        }

        if ((iter->second->funcType == KERNEL_FUNCTION_TYPE_INVALID) ||
            (iter->second->funcType >= KERNEL_FUNCTION_TYPE_MAX)) {
            RT_LOG(RT_LOG_ERROR, "kernel type and cross core sync info check failed, funcType=%u, crossCoreSync=%u.",
                iter->second->funcType, iter->second->crossCoreSync);
            return RT_ERROR_INVALID_VALUE;
        }

        kernels[index].dfxAddr = iter->second->dfxAddr;
        kernels[index].dfxSize = iter->second->dfxSize;
        kernels[index].elfDataFlag = iter->second->elfDataFlag;
        kernels[index].funcType = iter->second->funcType;
        kernels[index].userArgsNum = iter->second->userArgsNum;
        kernels[index].crossCoreSync = iter->second->crossCoreSync;
        // default task ratio for task ration MIX_AIC_AIV_MAIN_AIC/MIX_AIC_AIV_MAIN_AIV
        kernels[index].taskRation = DEFAULT_TASK_RATION;
        kernels[index].simtFlag = iter->second->simtFlag;
        kernels[index].shareMemSize = iter->second->shareMemSize;
        kernels[index].minStackSize = iter->second->minStackSize;
        RT_LOG(RT_LOG_INFO, "update dfx and funcType info, kernel_name=%s, dfxAddr=0x%llx, dfxSize=%u, funcType=%u",
                kernels[index].name, kernels[index].dfxAddr, kernels[index].dfxSize, kernels[index].funcType);
        // section no taskRation
        if ((iter->second->taskRation[0] == 0U) && (iter->second->taskRation[1] == 0U) &&
            (!isSupportKernelTaskRation)) {
            continue;
        }
        rtError_t error = ConvertTaskRation(iter->second, kernels[index].taskRation);
        if (error != RT_ERROR_NONE) {
            return error;
        }
    }

    elfData->containsAscendMeta = true;
    return RT_ERROR_NONE;
}

rtError_t UpdateKernelsMinStackSizeInfo(
    const std::map<std::string, ElfKernelInfo *> &kernelInfoMap, RtKernel *kernels, uint32_t kernelNum)
{
    const Runtime *const rtInstance = Runtime::Instance();
    const uint32_t customerStackSize = rtInstance->GetDeviceCustomerStackSize();
    RT_LOG(RT_LOG_DEBUG, "kernelNum=%u, mapSize=%u.", kernelNum, kernelInfoMap.size());
    for (uint32_t index = 0U; index < kernelNum; index++) {
        const auto iter = kernelInfoMap.find(std::string(kernels[index].name));
        if (iter == kernelInfoMap.end()) {
            continue;
        }

        kernels[index].minStackSize = iter->second->minStackSize;
        if (kernels[index].minStackSize > customerStackSize) {
            RT_LOG(RT_LOG_ERROR,
                "kernel_name:%s min stack size is %u, larger than current process default size %u. "
                "Please modify aclInit json, and reboot process.",
                kernels[index].name,
                kernels[index].minStackSize,
                customerStackSize);
            return RT_ERROR_INVALID_VALUE;
        }
        RT_LOG(RT_LOG_INFO, "kernel_name=%s, minStackSize=%u.", kernels[index].name, kernels[index].minStackSize);
    }
    return RT_ERROR_NONE;
}

static void KernelNameFree(RtKernel * const kernels, uint32_t kernelNum)
{
    for (uint32_t i = 0; i < kernelNum; ++i) {
        DELETE_A(kernels[i].name);
    }
}

static void ParseSymbols(const char_t *stringTab, const Elf_Internal_Sym * const psym,
    const uint64_t numSyms, rtElfData * const elfData)
{
    // ExeCallback
    (void)GetSymbolName(stringTab, psym, numSyms, elfData);
    // Set Symbol
    (void)SetSymbolAddress(stringTab, psym, numSyms, elfData);
}

RtKernel *GetKernels(rtElfData * const elfData)
{
    NULL_PTR_RETURN_MSG(elfData, nullptr);
    Elf_Internal_Shdr *section = nullptr;
    uint32_t index;
    uint32_t funcNum = 0U;
    uint32_t kernelNum = 0U;

    section = elfData->section_headers;
    for (index = 0U; index < elfData->elf_header.e_shnum; index++) {
        uint32_t si;
        std::unique_ptr<char_t[]> strTab = nullptr;
        uint64_t strTabSize = 0UL;
        char_t *stringTab = nullptr;

        if ((section->sh_type != static_cast<uint32_t>(SHT_SYMTAB)) || (section->sh_entsize == 0ULL)) {
            section++;
            continue;
        }

        uint64_t numSyms = 0UL;
        const std::unique_ptr<Elf_Internal_Sym[]> symTab = Get64bitElfSymbols(elfData, section, &numSyms);
        if (symTab == nullptr) {
            RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "Get 64bit elf symbols failed");
            section++;
            continue;
        }

        const Elf_Internal_Shdr * const stringSec = elfData->section_headers + section->sh_link;
        if (stringSec->sh_size != 0ULL) {
            if (((stringSec->sh_offset + stringSec->sh_size) > elfData->obj_size) ||
                (stringSec->sh_offset > elfData->obj_size) ||
                (stringSec->sh_size > elfData->obj_size)) {
                RT_LOG(RT_LOG_ERROR, "sh_offset:%" PRIu64 ", sh_size:%" PRIu64 ", obj_size:%" PRIu64 ".",
                    stringSec->sh_offset, stringSec->sh_size, elfData->obj_size);
                return nullptr;
            }

            strTab = GetStringTableCopy(elfData->obj_ptr_origin + stringSec->sh_offset, stringSec->sh_size);
            if (strTab != nullptr) {
                strTabSize = stringSec->sh_size;
                stringTab = strTab.get();
            }
        }
        ParseSymbols(stringTab, symTab.get(), numSyms, elfData);
        funcNum = GetFuncNum(symTab.get(), numSyms);
        if (funcNum < 1U) {
            RT_LOG(RT_LOG_ERROR, "funcNum is error.");
            return nullptr;
        }

        RtKernel * const kernels = new (std::nothrow) RtKernel[funcNum];
        if (kernels == nullptr) {
            return kernels;
        }

        const size_t size = static_cast<size_t>((sizeof(RtKernel)) * (funcNum));
        errno_t rc = memset_s(kernels, size, 0, size);
        COND_LOG(rc != EOK, "memset_s failed, size=%zu, retCode=%d.", size, rc);
        elfData->func_num = funcNum;

        Elf_Internal_Sym *psym = symTab.get();
        for (si = 0U; si < numSyms; si++) {
            if (!(CheckKernelAttr(psym) && (stringTab != nullptr) && ((stringTab + psym->st_name) != nullptr))) {
                psym++;
                continue;
            }
            if (psym->st_name > stringSec->sh_size) {
                KernelNameFree(kernels, kernelNum);
                delete[] kernels;
                return nullptr;
            }
            const size_t len = strnlen(stringTab + psym->st_name, static_cast<size_t>(NAME_MAX_LENGTH));
            if (len == static_cast<size_t>(NAME_MAX_LENGTH)) {
                RT_LOG(RT_LOG_WARNING, "kernel_name exceeds 4k, skip it, kernel_name=%s", stringTab + psym->st_name);
                psym++;
                continue;
            }
            kernels[kernelNum].name = new (std::nothrow) char[len + 1U];
            if (kernels[kernelNum].name == nullptr) {
                KernelNameFree(kernels, kernelNum);
                delete[] kernels;
                return nullptr;
            }
            (void)memset_s(kernels[kernelNum].name, len + 1U, 0, len + 1U);
            rc = strncpy_s(kernels[kernelNum].name, len + 1U, stringTab + psym->st_name, strTabSize);
            COND_LOG(rc != EOK, "strncpy_s failed, size=%zu, strTabSize=%u, retCode=%d.", len + 1U, strTabSize, rc);
            kernels[kernelNum].offset = static_cast<int32_t>(psym->st_value);
            kernels[kernelNum].length = static_cast<int32_t>(psym->st_size);
            kernels[kernelNum].userArgsNum = USER_ARGS_MAX_NUM;
            RT_LOG(RT_LOG_DEBUG, "kernel_name=%s, offset=%d, length=%u, stackSize=%llu,",
                stringTab + psym->st_name, kernels[kernelNum].offset, psym->st_size, elfData->stackSize);
            kernelNum++;
            psym++;
        }
        elfData->kernel_num = kernelNum;
        return kernels;
    }
    return nullptr;
}

static void ProcessDynamicSection(rtElfData * const elfData, const Elf_Internal_Shdr * const dynamicSection,
                                  const char_t * const dynamicStrings, const uint64_t dynamicStringsLength)
{
    if (elfData == nullptr) {
        return;
    }
    if ((dynamicStrings == nullptr) || (dynamicStringsLength == 0ULL)) {
        return;
    }
    if ((dynamicSection == nullptr) || (dynamicSection->sh_size == 0ULL)) {
        return;
    }

    Elf64_External_Dyn * const eDyn =
        RtPtrToPtr<Elf64_External_Dyn *>(elfData->obj_ptr_origin + dynamicSection->sh_offset);

    if ((GetByte == nullptr) ||
        (dynamicSection->sh_offset > elfData->obj_size) ||
        (dynamicSection->sh_size > elfData->obj_size) ||
        ((dynamicSection->sh_offset + dynamicSection->sh_size) > elfData->obj_size)) {
        RT_LOG(RT_LOG_ERROR, "sh_offset:%" PRIu64 ", sh_size:%" PRIu64 ", obj_size:%" PRIu64 ".",
            dynamicSection->sh_offset, dynamicSection->sh_size, elfData->obj_size);

        return;
    }

    Elf64_External_Dyn *ext = nullptr;
    uint64_t tag = static_cast<uint64_t>(DT_NULL);
    for (ext = eDyn; RtPtrToPtr<char_t *>(ext + 1) <= (RtPtrToPtr<char_t *>(eDyn) + dynamicSection->sh_size); ext++) {
        tag = GetByte(static_cast<const uint8_t *>(ext->d_tag), 8);
        if ((tag == static_cast<uint64_t>(DT_NULL)) || (tag == static_cast<uint64_t>(DT_SONAME))) {
            break;
        }
    }

    if (tag == static_cast<uint64_t>(DT_SONAME)) {
        const uint64_t val = GetByte(static_cast<const uint8_t *>(ext->dUn.d_val), 8);
        elfData->so_name = dynamicStrings + val;
    }
}

static void get_dynamic_section(const char_t * const base, const Elf_Internal_Shdr * const section,
                                const char_t * const stringTable, const uint64_t stringTableLength,
                                const char_t ** const dynamicStrings, uint64_t * const dynamicStringsLength,
                                const Elf_Internal_Shdr ** const dynamicSection)
{
    if ((stringTable != nullptr) && (section->sh_name < stringTableLength)) {
        const char_t * const sectionName = stringTable + section->sh_name;
        static const std::string DYNSTR(".dynstr");
        static const std::string DYNNAMIC(".dynamic");
        if ((section->sh_type == static_cast<uint32_t>(SHT_STRTAB)) && (DYNSTR.compare(sectionName) == 0)) {
            *dynamicStrings = base + section->sh_offset;
            *dynamicStringsLength = section->sh_size;
        } else if ((section->sh_type == static_cast<uint32_t>(SHT_DYNAMIC)) && (DYNNAMIC.compare(sectionName) == 0)) {
            *dynamicSection = section;
        } else {
            // no operation
        }
    }
}

static int32_t GetStringTable(const rtElfData * const elfData, std::unique_ptr<char_t[]> &stringTable,
                              uint64_t * const stringTableLength)
{
    if ((elfData->elf_header.e_shstrndx != static_cast<uint32_t>(SHN_UNDEF)) &&
        (elfData->elf_header.e_shstrndx < elfData->elf_header.e_shnum)) {
        const Elf_Internal_Shdr * const section = elfData->section_headers + elfData->elf_header.e_shstrndx;

        if (section->sh_size != 0ULL) {
            if (((section->sh_offset + section->sh_size) > elfData->obj_size) ||
                (section->sh_offset > elfData->obj_size) ||
                (section->sh_size > elfData->obj_size)) {
                RT_LOG(RT_LOG_ERROR, "sh_offset:%" PRIu64 ", sh_size:%" PRIu64 ", obj_size:%" PRIu64 ".",
                    section->sh_offset, section->sh_size, elfData->obj_size);
                return ELF_FAIL;
            }

            stringTable = GetStringTableCopy(elfData->obj_ptr_origin + section->sh_offset, section->sh_size);
            *stringTableLength = section->sh_size;
        }
    }

    return ELF_SUCCESS;
}

 rtError_t SetKernelFunctionEntry(RtKernel * const kernels, uint32_t kernelsNum, const std::map<std::string, ElfKernelInfo *> &kernelInfoMap)
{
    for (uint32_t i = 0; i < kernelsNum; ++i) {
        const auto it = kernelInfoMap.find(std::string(kernels[i].name));
        if ((it == kernelInfoMap.end()) || (!it->second->isSupportFuncEntry)) {
            kernels[i].funcEntryType = KERNEL_TYPE_TILING_KEY;
            continue;
        } 
        const uint8_t functionEntryFlag = it->second->functionEntryFlag;
        if (functionEntryFlag == 0U) {
            kernels[i].functionEntry = it->second->functionEntry;
            kernels[i].funcEntryType = KERNEL_TYPE_FUNCTION_ENTRY;
        } else if (functionEntryFlag == KERNEL_FUNCTION_ENTRY_DISABLE) {
            kernels[i].funcEntryType = KERNEL_TYPE_NOT_SUPPORT_FUNCTION_ENTRY;
        } else {
            RT_LOG(RT_LOG_ERROR, "kernel function meta info error! kernel name=%s, functionEntryFlag=%u",
                kernels[i].name, functionEntryFlag);
            return RT_ERROR_INVALID_VALUE;
        }
    }
    return RT_ERROR_NONE;
}

/* Dump the symbol table.  */
static RtKernel *ProcessSymbolTable(rtElfData * const elfData, const uint32_t progType, bool *isSupportMix)
{
    Elf_Internal_Shdr *section = nullptr;

    uint32_t i;
    std::unique_ptr<char_t[]> strTbl = nullptr;
    uint64_t strTblSize = 0UL;
    char_t *stringTbl = nullptr;
    bool isUpdate = false;

    const char_t *dynamicStrings = nullptr;
    uint64_t dynamicStringsLength = 0UL;
    const Elf_Internal_Shdr *dynamicSection = nullptr;
    std::map<std::string, ElfKernelInfo *> kernelInfoMap;

    elfData->section_headers = nullptr;
    if (Get64bitSectionHeaders(elfData) == ELF_FAIL) {
        RT_LOG(RT_LOG_ERROR, "Get 64bit section headers failed");
        return nullptr;
    }

    // accuire string_table and string_table_length
    if (GetStringTable(elfData, strTbl, &strTblSize) == ELF_FAIL) {
        RT_LOG(RT_LOG_ERROR, "Get String Table failed");
        return nullptr;
    }

    if (strTbl != nullptr) {
        stringTbl = strTbl.get();
    }

    section = elfData->section_headers;
    for (i = 0U; i < elfData->elf_header.e_shnum; i++) {
        if (section == nullptr) {
            continue;
        }
        if (((section->sh_flags & 0x2ULL) != 0ULL) && (section->sh_size > 0ULL)) {
            if (elfData->text_offset == 0ULL) {
                elfData->text_offset = section->sh_offset;
            }
            if ((MAX_UINT64_NUM - section->sh_size) < (section->sh_offset - elfData->text_offset)) {
                RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "elfData->text_size invalid value, current size is %" PRIu64
                    "valid range is [0, %" PRIu64 "]",
                    (section->sh_offset + section->sh_size - elfData->text_offset),
                    static_cast<uint64_t>(MAX_UINT64_NUM));
                KernelInfoMapRelease(kernelInfoMap);
                return nullptr;
            }
            elfData->text_size = section->sh_offset + section->sh_size - elfData->text_offset;
        }
        get_dynamic_section(elfData->obj_ptr_origin, section, stringTbl, strTblSize, &dynamicStrings,
                            &dynamicStringsLength, &dynamicSection);

        if ((section->sh_type == static_cast<uint32_t>(SHT_PROGBITS)) ||
            (section->sh_type == static_cast<uint32_t>(SHT_NOTE))) {
            ParseKernelMetaData(elfData, section, kernelInfoMap, isSupportMix, &isUpdate, progType);
        }
        section++;
    }

    const Runtime * const rtInstance = Runtime::Instance();
    const rtChipType_t chipType = rtInstance->GetChipType();
    if ((elfData->stackSize == 0ULL) && 
        IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_ELF_INCLUDE_STACK_SIZE)) {
        ParseElfStackInfoHeader(elfData);
    }

    ProcessDynamicSection(elfData, dynamicSection, dynamicStrings, dynamicStringsLength);

    RtKernel * const kernels = GetKernels(elfData);
    if (kernels != nullptr) {
        const bool isMixKernel = (progType == Program::MACH_AI_MIX_KERNEL) ? true : false;
        std::function<void()> const errReleaseKernels = [&kernels, &elfData, &kernelInfoMap]() {
            KernelNameFree(kernels, elfData->kernel_num);
            delete[] kernels;
            KernelInfoMapRelease(kernelInfoMap);
        };
        ScopeGuard kernelsGuard(errReleaseKernels);
        if (isMixKernel || isUpdate) {
            if (UpdateKernelsInfo(kernelInfoMap, kernels, elfData, isSupportMix) != RT_ERROR_NONE) {
                return nullptr;
            }
        }

        if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_META_TYPE_SU_STACK_SIZE)) {
            const auto error = UpdateKernelsMinStackSizeInfo(kernelInfoMap, kernels, elfData->kernel_num);
            if (error != RT_ERROR_NONE) {
                return nullptr;
            }
        }

        rtError_t error = SetKernelFunctionEntry(kernels, elfData->kernel_num, kernelInfoMap);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "set kernel function entry failed! errCode = %d.", error);
            return nullptr;
        }
        kernelsGuard.ReleaseGuard();
    }
    KernelInfoMapRelease(kernelInfoMap);
    return kernels;
}

static int32_t GetFileHeader(rtElfData * const elfData)
{
    errno_t ret = memcpy_s(elfData->elf_header.e_ident, static_cast<size_t>(EI_NIDENT), elfData->obj_ptr,
        static_cast<size_t>(EI_NIDENT));
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret != EOK, ELF_FAIL,
        "Get file header failed, memcpy_s failed, size=%zu, retCode=%d!", static_cast<size_t>(EI_NIDENT), ret);
    elfData->obj_ptr += EI_NIDENT;

    /* Determine how to read the rest of the header.  */
    switch (static_cast<int32_t>(elfData->elf_header.e_ident[EI_DATA])) {
        case ELFDATANONE:
        case ELFDATA2LSB:
            GetByte = &ByteGetLittleEndian;
            break;
        case ELFDATA2MSB:
            GetByte = &ByteGetBigEndian;
            break;
        default:
            GetByte = &ByteGetLittleEndian;
            break;
    }

    /* For now we only support 64 bit ELF objects.  */
    const bool is32bitElf = (static_cast<int32_t>(elfData->elf_header.e_ident[EI_CLASS]) != ELFCLASS64);

    /* Read in the rest of the header.  */
    if (is32bitElf) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,
            "Elf can no be 32bit.");
        return ELF_FAIL;
    } else {
        const size_t tmpSize = sizeof(Elf64_External_Ehdr) - static_cast<size_t>(EI_NIDENT);
        uint8_t hdr[tmpSize];
        ret = memcpy_s(&hdr[0], tmpSize, elfData->obj_ptr, tmpSize);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret != EOK, ELF_FAIL,
            "Get file header failed, second memcpy_s failed, size=%zu, retCode=%d!", tmpSize, ret);
        elfData->obj_ptr += tmpSize;
        elfData->elf_header.e_type = static_cast<uint16_t>(GetByte(static_cast<const uint8_t *>(&hdr[0]), 2));
        elfData->elf_header.e_machine = static_cast<uint16_t>(GetByte(static_cast<const uint8_t *>(hdr + 2), 2));
        elfData->elf_header.e_version = GetByte(static_cast<const uint8_t *>(hdr + 4), 4);
        elfData->elf_header.e_entry = GetByte(static_cast<const uint8_t *>(hdr + 8), 8);
        elfData->elf_header.e_phoff = GetByte(static_cast<const uint8_t *>(hdr + 16), 8);
        elfData->elf_header.e_shoff = GetByte(static_cast<const uint8_t *>(hdr + 24), 8);
        elfData->elf_header.e_flags = GetByte(static_cast<const uint8_t *>(hdr + 32), 4);
        elfData->elf_header.e_ehsize = static_cast<uint32_t>(GetByte(static_cast<const uint8_t *>(hdr + 36), 2));
        elfData->elf_header.e_phentsize = static_cast<uint32_t>(GetByte(static_cast<const uint8_t *>(hdr + 38), 2));
        elfData->elf_header.e_phnum = static_cast<uint32_t>(GetByte(static_cast<const uint8_t *>(hdr + 40), 2));
        elfData->elf_header.e_shentsize = static_cast<uint32_t>(GetByte(static_cast<const uint8_t *>(hdr + 42), 2));
        elfData->elf_header.e_shnum = static_cast<uint32_t>(GetByte(static_cast<const uint8_t *>(hdr + 44), 2));
        elfData->elf_header.e_shstrndx = static_cast<uint32_t>(GetByte(static_cast<const uint8_t *>(hdr + 46), 2));
    }
    return ELF_SUCCESS;
}

static void ProcessSymbolTableGetOffset(rtElfData *elfData, uint32_t* offset)
{
    Elf_Internal_Shdr *section = nullptr;
    uint32_t i;

    elfData->section_headers = nullptr;
    if (Get64bitSectionHeaders(elfData) == ELF_FAIL) {
        RT_LOG(RT_LOG_ERROR, "Get 64bit section headers failed");
    }

    if (elfData->section_headers == nullptr) {
        return;
    }
    section = elfData->section_headers;
    for (i = 0U; i < elfData->elf_header.e_shnum; i++) {
        if (section == nullptr) {
            continue;
        }
        if (((section->sh_flags & 0x2ULL) != 0ULL) &&
            (section->sh_size > 0ULL) &&
            (elfData->text_offset == 0ULL)) {
                elfData->text_offset = section->sh_offset;
        }
        section++;
    }

    *offset = static_cast<uint32_t>(elfData->text_offset);
    return;
}

RtKernel *ProcessObject(char_t * const objBuf, rtElfData * const elfData, const uint32_t progType, bool* isSupportMix)
{
    if (objBuf == nullptr) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,
            "read ELF buffer failed");
        return nullptr;
    }
    elfData->obj_ptr = objBuf;
    elfData->obj_ptr_origin = objBuf;
    elfData->section_headers = nullptr;
    elfData->kernel_num = 0U;
    elfData->stackSize = 0ULL;

    if (GetFileHeader(elfData) == ELF_FAIL) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,
            "read object header failed");
        return nullptr;
    }

    RtKernel * const kernels = ProcessSymbolTable(elfData, progType, isSupportMix);
    return kernels;
}

int32_t GetEhSizeOffset(void * const elfData, const uint32_t elfLen, uint32_t* offset)
{
    rtElfData *elfDataF = new (std::nothrow) rtElfData;

    if (elfDataF == nullptr) {
        RT_LOG(RT_LOG_ERROR, "new elfDataF failed.");
        return ELF_FAIL;
    }
    (void)memset_s(elfDataF, sizeof(rtElfData), 0, sizeof(rtElfData));

    elfDataF->obj_ptr = static_cast<char_t *>(elfData);
    elfDataF->obj_ptr_origin = static_cast<char_t *>(elfData);
    elfDataF->section_headers = nullptr;
    elfDataF->obj_size = elfLen;

    if (GetFileHeader(elfDataF) == ELF_FAIL) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "read object header failed");
        if (elfDataF->section_headers != nullptr) {
            DELETE_A(elfDataF->section_headers);
            elfDataF->section_headers = nullptr;
        }
        DELETE_O(elfDataF);
        elfDataF = nullptr;
        return ELF_FAIL;
    }

    ProcessSymbolTableGetOffset(elfDataF, offset);
    RT_LOG(RT_LOG_INFO, "Get Elf offset = %u", *offset);

    if (elfDataF->section_headers != nullptr) {
        delete[] elfDataF->section_headers;
        elfDataF->section_headers = nullptr;
    }
    delete elfDataF;
    elfDataF = nullptr;

    return ELF_SUCCESS;
}

static rtError_t GetMetaSection(const rtElfData * const elfData, Elf_Internal_Shdr * &section, const std::string &targetSection)
{
    const Elf_Internal_Shdr * const stringSec = elfData->section_headers + elfData->elf_header.e_shstrndx;
    
    if (stringSec->sh_size == 0ULL) {
        return RT_ERROR_INVALID_VALUE;
    }
    if ((stringSec->sh_offset > elfData->obj_size) ||
        (stringSec->sh_size > elfData->obj_size) ||
        ((stringSec->sh_offset + stringSec->sh_size) > elfData->obj_size)) {
        RT_LOG(RT_LOG_ERROR, "sh_offset:%" PRIu64 ", sh_size:%" PRIu64 ", obj_size:%" PRIu64 ".",
            stringSec->sh_offset, stringSec->sh_size, elfData->obj_size);
        return RT_ERROR_INVALID_VALUE;
    }

    std::unique_ptr<char_t[]> strTab = nullptr;
    strTab = GetStringTableCopy(elfData->obj_ptr_origin + stringSec->sh_offset, stringSec->sh_size);
    if (strTab == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Get String Table failed!");
        return RT_ERROR_INVALID_VALUE;
    }

    Elf_Internal_Shdr *curSection = elfData->section_headers;
    for (size_t i = 0U; i < elfData->elf_header.e_shnum; i++) {
        if (curSection == nullptr) {
            continue;
        }
        // sh_name has beed checked in get_dynamic_section
        const std::string stringTab = std::string(strTab.get() + curSection->sh_name);
        if (stringTab.compare(targetSection) == 0) {
            section = curSection;
            break;
        }
        curSection++;
    }

    if (section == nullptr) {
        RT_LOG(RT_LOG_WARNING, "Get meta section %s failed!", targetSection.c_str());
        return RT_ERROR_INVALID_VALUE;
    }
    return RT_ERROR_NONE;
}

static rtError_t GetMetaInfo(const rtElfData * const elfData, const Elf_Internal_Shdr * const metaSection,
                             const uint16_t type, uint64_t *data, const uint32_t length)
{
    uint64_t remainLen = metaSection->sh_size;
    uint8_t *curBuf = RtPtrToPtr<uint8_t *>(elfData->obj_ptr_origin) + metaSection->sh_offset;

    while (remainLen > sizeof(ElfTlvHead)) {
        const ElfTlvHead *tlvHead = RtPtrToPtr<const ElfTlvHead *>(curBuf);
        const uint16_t tlvType = static_cast<uint16_t>(GetByte(RtPtrToPtr<const uint8_t *>(&(tlvHead->type)),
            sizeof(uint16_t)));
        const uint16_t tlvLength = static_cast<uint16_t>(GetByte(RtPtrToPtr<const uint8_t *>(&(tlvHead->length)),
            sizeof(uint16_t)));
        if ((sizeof(ElfTlvHead) + tlvLength) > remainLen) {
            break;
        }
        if (tlvType == type) {
            COND_RETURN_ERROR_MSG_INNER(length != tlvLength, RT_ERROR_INVALID_VALUE, 
                                        "length is not equal tlvLength, length = %u, tlvLength = %u, type = %u.", length, tlvLength, type);
            *data = RtPtrToPtr<uint64_t>(curBuf + sizeof(ElfTlvHead));
            RT_LOG(RT_LOG_INFO, "Get meta info segment, type = %u", type);
            return RT_ERROR_NONE;
        }
        curBuf = curBuf + sizeof(ElfTlvHead) + tlvLength;
        remainLen = remainLen - (sizeof(ElfTlvHead) + tlvLength);
    }

    RT_LOG(RT_LOG_WARNING, "No data segment with the type value of %u was found.", type);
    return RT_ERROR_INVALID_VALUE;
}

rtError_t GetBinaryMetaInfo(const rtElfData * const elfData, const uint16_t type, void *data, const uint32_t length)
{
    if (elfData == nullptr) {
        RT_LOG(RT_LOG_ERROR, "elfData is nullptr.");
        return RT_ERROR_INVALID_VALUE;
    }

    if (type > RT_BINARY_TYPE_RUNTIME_IMPLICIT_INFO) {
        RT_LOG(RT_LOG_WARNING, "No data segment with the type value of %u was found.", type);
        return RT_ERROR_INVALID_VALUE;
    }

    Elf_Internal_Shdr *section = nullptr;
    const rtError_t error = GetMetaSection(elfData, section, ELF_SECTION_ASCEND_META);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Get meta section failed!");
        return error;
    }

    return GetMetaInfo(elfData, section, type, RtPtrToPtr<uint64_t *>(data), length);
}

rtError_t GetFunctionMetaInfo(const rtElfData * const elfData, const std::string &kernelName, const uint16_t type,
                              void *data, const uint32_t length)
{
    if (elfData == nullptr) {
        RT_LOG(RT_LOG_ERROR, "elfData is nullptr.");
        return RT_ERROR_INVALID_VALUE;
    }

    if ((type >= RT_FUNCTION_TYPE_PARAM_INFO) || (type == 0)) {
        RT_LOG(RT_LOG_WARNING, "No data segment with the type value of %u was found.", type);
        return RT_ERROR_INVALID_VALUE;
    }

    const std::string targetSection = ELF_SECTION_PREFIX_ASCEND_META + kernelName;
    Elf_Internal_Shdr *section = nullptr;
    const rtError_t error = GetMetaSection(elfData, section, targetSection);
    const rtError_t errorAic = GetMetaSection(elfData, section, targetSection + ELF_SECTION_MIX_KERNEL_AIC);
    const rtError_t errorAiv = GetMetaSection(elfData, section, targetSection + ELF_SECTION_MIX_KERNEL_AIV);
    if ((error != RT_ERROR_NONE) && (errorAic != RT_ERROR_NONE) && (errorAiv != RT_ERROR_NONE)) {
        RT_LOG(RT_LOG_ERROR, "Get meta section failed!");
        return error;
    }

    return GetMetaInfo(elfData, section, type, RtPtrToPtr<uint64_t *>(data), length);
}
}
}
