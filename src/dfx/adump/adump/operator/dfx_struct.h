/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_DFX_STRUCT_H
#define CCE_RUNTIME_DFX_STRUCT_H

#include <cstdint>
#include "runtime/base.h"

namespace cce {
namespace runtime {

struct BlockInfo {
    uint32_t length = 0;
    uint32_t coreId = 0;
    uint32_t blockNum = 0;
    uint32_t remainLen = 0;
    uint16_t magic = 0xAE86U;
    uint16_t flag = 0;
    uint32_t rsv = 0;
    uint64_t dumpAddr = 0;
    uint64_t dbgAddr = 0;
    uint32_t resv[4] = {0U};
};

enum class DumpType : uint32_t {
    DUMP_DEFAULT = 0,
    DUMP_SCALAR,
    DUMP_TENSOR,
    DUMP_SHAPE,
    DUMP_ASSERT,
    DUMP_META,
    DUMP_TIMESTAMP,
    DUMP_SIMT,
    DUMP_BUFI,
    DUMP_BUFO,
    DUMP_SKIP,
    DUMP_SIMT_ASSERT = 0xF0E00F0EU,
    DUMP_SIMT_PRINTF = 0xF0F00F0FU,
    DUMP_WAIT = 0xF0A55A0FU
};

#pragma pack(push, 1)
struct DumpInfoHead {
    DumpType type = DumpType::DUMP_DEFAULT;
    uint32_t infoLen = 0U;
    uint8_t infoMsg[0U];
};
#pragma pack(pop)

struct BlockWriteInfo {
    DumpType dumpType = DumpType::DUMP_BUFI;
    uint32_t length = 16;
    uint64_t writeIdx = 0;
    uint64_t packIdx = 0;
};

struct BlockReadInfo {
    DumpType dumpType = DumpType::DUMP_BUFO;
    uint32_t length = 16;
    uint64_t readIdx = 0;
    uint64_t resv = 0;
};

struct DumpTimeStampInfoMsg {
    uint32_t descId;
    uint16_t blockIdx;
    uint16_t rsv;
    uint64_t syscyc;
    uint64_t curPc;
    uint64_t entry;
    uint32_t resv[2];
};

constexpr uint32_t RT_DUMP_SHAPE_MAX_SIZE = 8U;
struct DumpTensorInfo {
    uint32_t addr = 0U;
    uint32_t dataType = 0U;
    uint32_t desc;
    uint32_t bufferId;
    uint16_t position;
    uint16_t blockIdx = 0U;
    uint32_t dim = 0U;
    uint32_t shape[RT_DUMP_SHAPE_MAX_SIZE] = {0U};
    uint32_t resv = 0U;
    uint32_t dumpSize;
};

struct DumpShapeInfo {
    uint32_t dim = 0U;
    uint32_t shape[RT_DUMP_SHAPE_MAX_SIZE] = {0U};
    uint32_t resv;
};

constexpr uint32_t RT_KERNEL_DFX_INFO_CORE_TYPE_AIC = 0U;
constexpr uint32_t RT_KERNEL_DFX_INFO_CORE_TYPE_AIV = 1U;
constexpr uint32_t RT_KERNEL_DFX_INFO_CORE_TYPE_SIMT = 2U;

enum class DumpTensorPosition : uint16_t { GM = 0, UB, L1, L0A, L0B, L0C, BIAS, FIXBUF, REG, MAX };

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_DFX_STRUCT_H
