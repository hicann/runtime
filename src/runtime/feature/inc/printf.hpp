/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_PRINTF_HPP
#define CCE_RUNTIME_PRINTF_HPP

#include "base.hpp"
#include "driver.hpp"

namespace cce {
namespace runtime {
constexpr size_t BLOCK_NUM = 75U;

// 单核数据排布 blockData: | blockInfo | readInfo | tlv1 | tlv2 | tlv3 ... | writeInfo |
// 整体排布：| blockData1 | blockData2 | ... | bloackData75 |

struct BlockInfo {
    uint32_t length = 0;      // 单核维测总长度
    uint32_t coreId = 0;      // 当前core id
    uint32_t blockNum = 0;    // 本次总共的核数
    uint32_t remainLen = 0;   // 可打印的总长度
    uint16_t magic = 0xAE86;  // 信息校验数 // 0xAE86
    uint16_t flag = 0;        // falg 0: simd, 1: simt
    uint32_t rsv = 0;         // DUMP EXC FLAG
    uint64_t dumpAddr = 0;    // 起始printf的地址
    uint32_t resv[6] = {0U};
};

enum class DumpType : uint32_t  {
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
    DUMP_SKIP
};

#pragma pack(push, 1)
struct DumpInfoHead {
    DumpType type = DumpType::DUMP_DEFAULT;      // dump type, DUMP_SCALAR:1, DUMP_TENSOR:2
    uint32_t infoLen = 0U;   // length for dump info
    uint8_t  infoMsg[0U];    // extend value
};
#pragma pack(pop)
 
struct BlockWriteInfo {
    DumpType dumpType = DumpType::DUMP_BUFI;
    uint32_t length = 16; // writeIdx 和 packIdx 的大小相加
    uint64_t writeIdx = 0;
    uint64_t packIdx = 0;
};
 
struct BlockReadInfo {
    DumpType dumpType = DumpType::DUMP_BUFO;
    uint32_t length = 16;  // readIdx 和 resv 的大小相加
    uint64_t readIdx = 0;
    uint64_t resv = 0;
};

struct DumpTimeStampInfoMsg {
    uint32_t descId;   // dot Id for description
    uint32_t rsv;
    uint64_t syscyc;   // dotting timestamp with system cycle
    uint64_t curPc;   // currrent pc for source line
    uint64_t entry; // Entry system cycle
    uint32_t resv[2];   // reserved
};

struct DumpTensorInfo {
    uint32_t addr = 0U;
    uint32_t dataType = 0U; // 数据类型
    uint32_t desc;          // 用户标识
    uint32_t bufferId;
    uint16_t position;        // position GM, UB, L1, L0C
    uint16_t resv1 = 0U;      // 保留字段
    uint32_t dim = 0U;        // dim值
    uint32_t shape[8] = {0U}; // shape 各维度值 < 8
    uint32_t resv = 0U;       // 保留字
    uint32_t dumpSize;        // dump实际的大小，不包含对齐长度
};

struct DumpShapeInfo {
    uint32_t dim = 0U;            // shapeInfo.dim, 即：fmt的offset
    uint32_t shape[8U] = {0U};     
    uint32_t resv;                
};

rtError_t InitPrintf(void *addr, const size_t blockSize, Driver *curDrv);
rtError_t ParsePrintf(void *addr, const size_t blockSize, Driver *curDrv);
} // runtime
} // cce
 
#endif // CCE_RUNTIME_PRINTF_HPP
