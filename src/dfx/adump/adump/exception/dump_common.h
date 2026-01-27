/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DUMP_COMMON_H
#define DUMP_COMMON_H
#include <cstdint>
#include <string>
#include "runtime/rt.h"
#include "adx_exception_callback.h"

namespace Adx {
// section 名字命名规则统一，ascend 敏感词
const std::string ASCEND_SHNAME_GLOBAL(".ascend.global");
const std::string ASCEND_SHNAME_LOCAL(".ascend.local");
const std::string ASCEND_SHNAME_REGS(".ascend.regs");
const std::string ASCEND_SHNAME_DEVTBL(".ascend.devtbl");
const std::string ASCEND_SHNAME_AUXINFO_GLOABL(".ascend.auxinfo.global");
const std::string ASCEND_SHNAME_AUXINFO_LOCAL(".ascend.auxinfo.local");
const std::string ASCEND_SHNAME_HOST_KERNEL_OBJECT(".ascend.host_kernel_object");
const std::string ASCEND_SHNAME_FILE_KERNEL_OBJECT(".ascend.file_kernel_object");
const std::string ASCEND_SHNAME_FILE_KERNEL_JSON(".ascend.file_kernel_json");

constexpr uint8_t CORE_TYPE_AIC = RT_CORE_TYPE_AIC ;
constexpr uint8_t CORE_TYPE_AIV = RT_CORE_TYPE_AIV;
constexpr uint16_t CORE_SIZE_AIC = 25U;     // milan
constexpr uint16_t CORE_SIZE_AIC_DAVID = 36U;     // david
constexpr uint64_t INVALID_DATA_FLAG = 1LLU << 63U;
constexpr uint8_t REG_DATA_VALID = 0U;
constexpr uint8_t REG_DATA_INVALID = 1U;

struct DevInfo {
    rtDbgCoreInfo_t coreInfo;
    uint32_t devId;
    uint32_t devType;
};

struct GlobalMemInfo {
    uint64_t devAddr;       // 虚拟地址
    uint64_t size;          // 内存大小
    uint32_t sectionIndex;  // 对应哪个.ascend.global section
    DfxTensorType type;     // 内存是input/output/workspace/stack等类型
    uint16_t reserve;
    union {
        struct {
            uint16_t coreId;
        } coreInfo;         // stack 类型的内存区分不同core
        struct {
            uint32_t dim;   // tensor shape
            uint64_t dimSize[25];
        } shape;            // input、output
    } extraInfo;
};

struct LocalMemInfo {
    uint64_t size;                  // memory size
    uint32_t sectionIndex;          // which .ascend.local section
    uint32_t globalSectionIndex;    // which .ascend.gloabl section, cache only
    rtDebugMemoryType_t type;
    uint32_t reserve;
};

struct RegInfo {
    uint64_t addr;
    uint8_t validFlag;              //标识寄存器value是否有效, 0：有效，1：无效
    uint8_t reserve[6];
    uint8_t regSize;                // byte
    uint8_t value[16];
};

struct RegInfoWide {
    uint64_t addr;
    uint8_t validFlag;
    uint8_t reserve[6];
    uint8_t regSize;
    uint8_t value[32];
};

}
#endif