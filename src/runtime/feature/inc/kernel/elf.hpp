/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __ELF_HPP__
#define __ELF_HPP__

#include <cstdint>
#include "base.hpp"
#include "rt_preload_task.h"

constexpr int32_t EI_NIDENT = 16;
constexpr int32_t EI_CLASS = 4;
constexpr int32_t EI_DATA = 5;
constexpr int32_t ELFCLASS64 = 2;
constexpr int32_t ELFDATANONE = 0;
constexpr int32_t ELFDATA2LSB = 1;
constexpr int32_t ELFDATA2MSB = 2;
constexpr int32_t SHN_UNDEF = 0; /* Undefined section reference */
constexpr int32_t SHT_PROGBITS = 1; /* Program data */
constexpr int32_t SHT_SYMTAB = 2; /* Link editing symbol table */

constexpr int32_t SHT_STRTAB = 3;  /* A string table */
constexpr int32_t SHT_DYNAMIC = 6; /* Information for dynamic linking */
constexpr int32_t SHT_LOPROC = 0x70000000;
constexpr int32_t SHT_NOTE = 7;

#define SHT_SYMTAB_SHNDX 18 /* Indicies for SHN_XINDEX entries */
constexpr uint32_t STT_NOTYPE = 0;
constexpr uint32_t STT_OBJECT = 1;
constexpr uint32_t STT_FUNC = 2;          /* Symbol is a code object */
constexpr uint32_t STT_SECTION = 3;
constexpr uint32_t STT_FILE = 4;
constexpr uint32_t STT_LOPROC = 13;
constexpr uint32_t STT_HIPROC = 15;
#define STB_GLOBAL 1       /* Global symbols */
constexpr int32_t STV_HIDDEN = 2;        /* Symbol visibility is hidden */
constexpr uint32_t NAME_MAX_LENGTH = 4096U;

constexpr int32_t DT_NULL = 0;
constexpr int32_t DT_SONAME = 14;

constexpr uint32_t KERNEL_CUSTOM_STACK_SIZE_MAX_CLOUD_V2 = 196608U; // 192KB
constexpr uint32_t KERNEL_CUSTOM_STACK_SIZE_MAX_MINI_V3 = 7864320U; // 7680KB
constexpr uint32_t KERNEL_CUSTOM_STACK_SIZE_MAX_DAVID = 131072U; // 128KB

constexpr uint32_t PRINT_SIMD = 0U;
constexpr uint32_t PRINT_SIMT = 1U;

#define MAX_BUF_NUM 2048
#define DEFAULT_TASK_RATION 2U
#define SOLOMON_TASK_RATION 1U
#define NONE_TASK_RATION 0xFFFFFFFFU
#define ELF_ST_BIND(val) ((val) >> 0x4U)

#define ELF_ST_TYPE(val) ((val) & 0xFU)

#define ELF_STV_TYPE(val) ((val) & 0x3U)

#define KERNEL_STACK_SIZE_32K     32768U
#define KERNEL_STACK_SIZE_16K     16384U
#define KERNEL_STACK_TYPE_16K     1U
#define KERNEL_STACK_TYPE_32K     2U
#define ELF_VERSION_MAGIC         0x5A5AU

#define SIMD_FIFO_PER_CORE_SIZE_32K 32768U
#define SIMT_FIFO_SIZE_1024K      1048576U

#define GET_VERSION_MAGIC(val) (((val) >> 16U) & 0xFFFFU)
#define GET_STACK_TYPE(val)    (((val) >> 8U) & 0xFFU)

#define STREQ(a, b) (strcmp((a), (b)) == 0)

#define FUNC_NO_USE_SYNC     0
#define FUNC_USE_SYNC        1

namespace cce {
namespace runtime {

enum {
    KERNEL_FUNCTION_TYPE_INVALID          = 0U,
    KERNEL_FUNCTION_TYPE_AICORE           = 1U, // c100/m200/m300
    KERNEL_FUNCTION_TYPE_AIC              = 2U, // v220-cube，组合硬同步类型，函数名<function_name>
    KERNEL_FUNCTION_TYPE_AIV              = 3U, // v220-vec，组合硬同步类型，函数名<function_name>
    KERNEL_FUNCTION_TYPE_MIX_AIC_MAIN     = 4U, /* v220 mix cube/vector 1:2, blockdim=cube blockdim=10，
                                                   代表cube block_idx(0..9)，vector block_idx(0..9)，sub_block_idx(0..1)，
                                                   函数名<function_name>_mix_aic+<function_name>_mix_aiv */
    KERNEL_FUNCTION_TYPE_MIX_AIV_MAIN     = 5U, /* v220 mix vector/cube 1:2, blockdim=vector blockdim=10，
                                                   代表vector block_idx(0..9)，cube block_idx(0..9)，sub_block_idx(0..1)，
                                                   函数名<function_name>_mix_aic+<function_name>_mix_aiv */
    KERNEL_FUNCTION_TYPE_AIC_ROLLBACK     = 6U, // v220-cube，aic回退，符号查找<function_name>_mix_aic，支持组合硬同步类型
    KERNEL_FUNCTION_TYPE_AIV_ROLLBACK     = 7U, // v220-vec，aiv回退，符号查找<function_name>_mix_aiv，支持组合硬同步类型

    KERNEL_FUNCTION_TYPE_MAX              = 8U,
};

enum {
    FUNC_META_TYPE_INVALID          = 0U,
    FUNC_META_TYPE_KERNEL_TYPE      = 1U,
    FUNC_META_TYPE_CROSS_CORE_TYPE  = 2U,
    FUNC_META_TYPE_MIX_TASK_RATION  = 3U,
    FUNC_META_TYPE_DFX_TYPE         = 4U,
    FUNC_META_TYPE_DFX_ARG_INFO     = 5U,
    FUNC_META_TYPE_COMPILER_ALLOC_UB_SIZE  = 7U, // for simt, elf report share memory size
    FUNC_META_TYPE_SU_STACK_SIZE    = 8U,        // for min stack size
    FUNC_META_TYPE_AIV_TYPE_FLAG    = 12U,       // for simt, corresponding enum AivTypeFlag
    FUNCTION_META_TYPE_FUNCTION_ENTRY_INFO = 14U,
    FUNC_META_TYPE_BLOCK_DIM_INFO   = 15U,
};

enum class AivTypeFlag : uint32_t {
    AIV_TYPE_NO_VF = 1,            // SU
    AIV_TYPE_SIMD_VF_ONLY = 2,     // SU + SIMD
    AIV_TYPE_SIMT_VF_ONLY = 3,     // SU + SIMT
    AIV_TYPE_SIMD_SIMT_MIX_VF = 4, // SU + SIMD + SIMT
};

enum Ratio {
    RATION_TYPE_ONE_RATIO_TWO         = 0,
    RATION_TYPE_TWO_RATIO_ONE         = 1,
    RATION_TYPE_ONE_RATIO_ONE         = 2,
    RATION_TYPE_ONE_RATIO_ZERO        = 3,
    RATION_TYPE_ZERO_RATIO_ONE        = 4,
    RATION_TYPE_MAX                   = 5,
};

enum KernelFunctionEntryType {
    KERNEL_TYPE_TILING_KEY = 0,                 // legacy tiling key flow
    KERNEL_TYPE_FUNCTION_ENTRY = 1,             // replace tiling key with function entry
    KERNEL_TYPE_NOT_SUPPORT_FUNCTION_ENTRY = 2, // neither function-entry nor tiling-key supported
};

constexpr uint16_t USER_ARGS_MAX_NUM = 128U;
typedef struct {
    uint16_t type;
    uint16_t length;
} ElfTlvHead;

typedef struct {
    ElfTlvHead head;
    uint32_t funcType;
} ElfFuncTypeInfo;

typedef struct {
    ElfTlvHead head;
    uint32_t crossCoreSync;
} ElfKernelSyncInfo;

typedef struct {
    ElfTlvHead head;
    uint16_t taskRation[2];
} ElfTaskRationInfo;

struct ElfDfxInfo{
    ElfTlvHead head;
    uint8_t value[0];
};

struct ElfKernelAivTypeInfo {
    ElfTlvHead head;
    uint32_t aivType;
};

struct ElfKernelReportSzInfo {
    ElfTlvHead head;
    uint32_t shareMemSize;
};

struct ElfKernelMinStackSizeInfo {
    ElfTlvHead head;
    uint32_t minStackSize;
};

constexpr uint8_t KERNEL_FUNCTION_ENTRY_DISABLE = 0x80;

struct ElfKernelFunctionEntryInfo {
    ElfTlvHead head;
    uint8_t flag;               // 0x80, disable function entry(the same as tiling key); 0x00 enable.
    uint8_t resv0;              // 0x00
    uint16_t resv1;             // 0x00
    uint64_t functionEntry;     // tiling key, if functionEntry is not supported, the default value is 0.
};

struct ElfBinaryAddrInfo {
    ElfTlvHead head;
    uint32_t type;
};

struct ElfKernelInfo {
    uint32_t funcType;
    uint32_t crossCoreSync;
    uint16_t taskRation[2];
    const void *dfxAddr;
    uint16_t dfxSize;
    uint32_t kernelVfType;
    uint32_t shareMemSize;
    int32_t elfDataFlag;
    uint16_t userArgsNum;
    uint32_t minStackSize;
    uint64_t functionEntry;
    bool isSupportFuncEntry;
    uint8_t functionEntryFlag;
};

struct Elf_Internal_Ehdr {
    uint8_t e_ident[EI_NIDENT]; /* ELF "magic number" */
    uint64_t e_entry;                 /* Entry point virtual address */
    uint64_t e_phoff;                 /* Program header table file offset */
    uint64_t e_shoff;                 /* Section header table file offset */
    uint64_t e_version;               /* Identifies object file version */
    uint64_t e_flags;                 /* Processor-specific flags */
    uint16_t e_type;              /* Identifies object file type */
    uint16_t e_machine;           /* Specifies required architecture */
    uint32_t e_ehsize;            /* ELF header size in bytes */
    uint32_t e_phentsize;         /* Program header table entry size */
    uint32_t e_phnum;             /* Program header table entry count */
    uint32_t e_shentsize;         /* Section header table entry size */
    uint32_t e_shnum;             /* Section header table entry count */
    uint32_t e_shstrndx;          /* Section header string table index */
};

/* 64-bit ELF file header.  */
struct Elf64_External_Ehdr {
    uint8_t e_ident[16];    /* ELF "magic number" */
    uint8_t e_type[2];      /* Identifies object file type */
    uint8_t e_machine[2];   /* Specifies required architecture */
    uint8_t e_version[4];   /* Identifies object file version */
    uint8_t e_entry[8];     /* Entry point virtual address */
    uint8_t e_phoff[8];     /* Program header table file offset */
    uint8_t e_shoff[8];     /* Section header table file offset */
    uint8_t e_flags[4];     /* Processor-specific flags */
    uint8_t e_ehsize[2];    /* ELF header size in bytes */
    uint8_t e_phentsize[2]; /* Program header table entry size */
    uint8_t e_phnum[2];     /* Program header table entry count */
    uint8_t e_shentsize[2]; /* Section header table entry size */
    uint8_t e_shnum[2];     /* Section header table entry count */
    uint8_t e_shstrndx[2];  /* Section header string table index */
};

/* 64-bit ELF section header.  */
struct Elf64_External_Shdr {
    uint8_t sh_name[4];      /* Section name, index in string tbl */
    uint8_t sh_type[4];      /* Type of section */
    uint8_t sh_flags[8];     /* Miscellaneous section attributes */
    uint8_t sh_addr[8];      /* Section virtual addr at execution */
    uint8_t sh_offset[8];    /* Section file offset */
    uint8_t sh_size[8];      /* Size of section in bytes */
    uint8_t sh_link[4];      /* Index of another section */
    uint8_t sh_info[4];      /* Additional section information */
    uint8_t sh_addralign[8]; /* Section alignment */
    uint8_t sh_entsize[8];   /* Entry size if section holds table */
};

/* Section header */
struct Elf_Internal_Shdr {
    uint32_t sh_name;  /* Section name, index in string tbl */
    uint32_t sh_type;  /* Type of section */
    uint64_t sh_flags;     /* Miscellaneous section attributes */
    uint64_t sh_addr;      /* Section virtual addr at execution */
    uint64_t sh_offset;    /* Section file offset */
    uint64_t sh_size;      /* Size of section in bytes */
    uint32_t sh_link;  /* Index of another section */
    uint32_t sh_info;  /* Additional section information */
    uint64_t sh_addralign; /* Section alignment */
    uint64_t sh_entsize;   /* Entry size if section holds table */
};

struct Elf_Internal_Sym {
    uint64_t st_value;                /* Value of the symbol */
    uint64_t st_size;                 /* Associated symbol size */
    uint64_t st_name;                 /* Symbol name, index in string tbl */
    uint8_t st_info;            /* Type and binding attributes */
    uint8_t st_other;           /* Visibilty, and target specific */
    uint8_t st_target_internal; /* Internal-only information */
    uint32_t st_shndx;            /* Associated section index */
};

typedef struct elf_section_list_def {
    Elf_Internal_Shdr *hdr;
    struct elf_section_list_def *next;
} elf_section_list;

struct Elf64_External_Sym {
    uint8_t st_name[4];  /* Symbol name, index in string tbl */
    uint8_t st_info[1];  /* Type and binding attributes */
    uint8_t st_other[1]; /* No defined meaning, 0 */
    uint8_t st_shndx[2]; /* Associated section index */
    uint8_t st_value[8]; /* Value of the symbol */
    uint8_t st_size[8];  /* Associated symbol size */
};

struct Elf_External_Sym_Shndx {
    uint8_t est_shndx[4]; /* Section index */
};

struct Elf64_External_Dyn {
    uint8_t d_tag[8]; /* entry tag value */
    union {
        uint8_t d_val[8];
        uint8_t d_ptr[8];
    } dUn;
};

struct RtKernel final {
    char_t *name;         // kernem name
    int32_t offset;      //  The offset of current kernel in object
    int32_t length;      //  The length of current kernel
    void *stubAddr;  //  The address of stub function of current kernel
    uint32_t funcType;  // The function type of kernel
    uint32_t crossCoreSync;  // cross core sync
    uint32_t  taskRation; // The taskRation of aic : aiv
    const void *dfxAddr;
    uint16_t dfxSize;
    uint8_t reserved; // 填补空间以保持四字节对齐
    uint32_t kernelVfType;
    uint32_t shareMemSize;
    int32_t elfDataFlag;
    uint16_t userArgsNum;
    uint32_t minStackSize;
    uint64_t functionEntry;         // the same as tiling key
    KernelFunctionEntryType funcEntryType;
};

struct rtKernelContent {
    uint32_t length;
    uint32_t offset;
    uint32_t kernelVfType;
    uint32_t shareMemSize;
};

struct RtKernelCombine
{
    const struct RtKernel* kernel;
    const void *stubFunc;
    uint8_t mixType;
    uint32_t kernelType;
    uint64_t tilingKey;
    uint32_t kernelIdx;
};

constexpr uint32_t KERNEL_PRINT_FIFO_ADDR_BIT = 1U;
constexpr uint32_t KERNEL_FFTS_ADDR_BIT = 2U;
constexpr uint32_t KERNEL_SYSTEM_RUN_CFG_ADDR_BIT = 4U;
constexpr uint32_t KERNEL_SIMT_PRINT_FIFO_ADDR_BIT = 8U;

constexpr uint32_t KERNEL_PRINT_FIFO_ADDR = 1U;
constexpr uint32_t KERNEL_FFTS_ADDR = 2U;
constexpr uint32_t KERNEL_SYSTEM_RUN_CFG_ADDR = 3U;
constexpr uint32_t KERNEL_SIMT_PRINT_FIFO_ADDR = 4U;

struct rtElfSymbolAddr {
    uint64_t *g_sysFftsAddr = nullptr;
    uint64_t *g_opL2CacheHintCfg = nullptr;
    uint64_t *g_sysPrintFifoSpace = nullptr;
    uint64_t *g_sysSimtPrintFifoSpace = nullptr;
};

struct rtElfData {
    char_t *obj_ptr;
    char_t *obj_ptr_origin;
    uint64_t obj_size;
    struct Elf_Internal_Ehdr elf_header;
    Elf_Internal_Shdr *section_headers;
    uint64_t text_offset;
    uint64_t text_size;
    uint32_t kernel_num;
    uint32_t func_num;
    const char_t *so_name;
    bool degenerateFlag;
    uint64_t stackSize;
    bool dataFlag = false;
    bool containsAscendMeta; // if contains valid ascend.meta data
    uint32_t ascendMetaFlag = 0;
    rtElfSymbolAddr symbolAddr;
};

RtKernel *ProcessObject(char_t * const objBuf, rtElfData * const elfData, const uint32_t progType, bool* isSupportMix);
RtKernel *GetKernels(rtElfData * const elfData);
uint64_t ByteGetLittleEndian(const uint8_t field[], const int32_t size);
uint64_t ByteGetBigEndian(const uint8_t field[], const int32_t size);
int32_t Get64bitSectionHeaders(rtElfData * const elfData);
int32_t GetEhSizeOffset(void * const elfData, const uint32_t elfLen, uint32_t* offset);
std::unique_ptr<Elf_Internal_Sym[]> Get64bitElfSymbols(const rtElfData * const elfData,
                                                       const Elf_Internal_Shdr * const section,
                                                       uint64_t * const numSymsReturn);
std::unique_ptr<char_t[]> GetStringTableCopy(const char_t * const src, const uint64_t size);

void GetKernelTlvInfo(const uint8_t *buf, uint32_t bufLen, ElfKernelInfo *tlvInfo);
void UpdateFuncTypeByProgType(ElfKernelInfo * const kernelInfo, const uint32_t progType, bool *isUpdate);
rtError_t SetKernelFunctionEntry(RtKernel * const kernels, uint32_t kernelsNum, const std::map<std::string, ElfKernelInfo *> &kernelInfoMap);

rtError_t ConvertTaskRation(ElfKernelInfo *elfKernelInfo, uint32_t& taskRation);
bool GetMixStatus(uint32_t funcType, uint32_t crossCoreSync);
void ParseElfStackInfoHeader(rtElfData * const elfData);
void ParseElfStackInfoFromSection(rtElfData * const elfData, const uint8_t *buf, uint32_t bufLen);
void ParseElfBinaryMetaInfo(rtElfData * const elfData, const uint8_t *buf, uint64_t bufLen, const std::string &stringTab);
rtError_t UpdateKernelsInfo(std::map<std::string, ElfKernelInfo *>& kernelInfoMap,
                            RtKernel * const kernels, rtElfData * const elfData, bool* isSupportMix);
rtError_t UpdateKernelsMinStackSizeInfo(
    const std::map<std::string, ElfKernelInfo *> &kernelInfoMap, RtKernel *kernels, uint32_t kernelNum);
rtError_t RefreshSymbolAddress(rtElfData *elfData);
void SetSymbolAddress(const char_t *stringTab, const Elf_Internal_Sym * const psym,
    const uint64_t numSyms, rtElfData * const elfData);
rtError_t GetBinaryMetaInfo(const rtElfData * const elfData, const uint16_t type, void *data, const uint32_t length);
rtError_t GetFunctionMetaInfo(const rtElfData * const elfData, const std::string &kernelName, const uint16_t type,
                              void *data, const uint32_t length);
}
}

#endif
