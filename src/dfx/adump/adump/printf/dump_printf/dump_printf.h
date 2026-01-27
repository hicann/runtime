/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DUMP_PRINTF_H
#define DUMP_PRINTF_H
#include <string>
#include <vector>
#include <unordered_map>
#include "acl/acl_base.h"
#include "runtime/base.h"
#include "profiling/prof_common.h"
#include "adump_api.h"

namespace Adx {
extern uint64_t g_chunk[RING_CHUNK_SIZE + MAX_TENSOR_NUM];
}

#ifdef __cplusplus
extern "C" {
#endif
struct AdxBlockInfo {
    uint32_t len = 0;        // 总长度
    uint32_t core = 0;       // 当前核号
    uint32_t blockNum = 0;   // 本次总共的核数
    uint32_t remainLen = 0;  // 剩下的长度
    uint32_t magic = 0;      // 信息校验数
    uint32_t rsv = 0;
    uint64_t dumpAddr = 0;   // 开始dump的地址
};

#pragma pack(push, 1)
struct AdxDumpInfoHead {
    uint32_t type = 0U;      // dump type, DUMP_SCALAR:1, DUMP_TENSOR:2
    uint32_t infoLen = 0U;   // length for dump info
    uint8_t  infoMsg[0U];    // extend value
};
#pragma pack(pop)

enum AdxDumpType {
    DUMP_DEFAULT = 0,
    DUMP_SCALAR,
    DUMP_TENSOR,
    DUMP_SHAPE,
    DUMP_ASSERT,
    DUMP_META,
    DUMP_TIMESTAMP,
    DUMP_SIMT,
};

struct AdxDumpShapeMessageHead {
    uint32_t dim = 0;
    uint32_t shape[8U];
    uint32_t rsv = 0;      // reserved information
};

struct AdxDumpMessageHead {
    uint32_t addr = 0;     // address
    uint32_t dataType = 0; // data type: int32_t/half/...
    uint32_t desc = 0;     // for usr to add info or tag
    uint32_t bufferId = 0; // UB addr
    uint32_t position = 0; // position
    uint32_t rsv = 0;      // actual dumped data size
};

struct AdxDumpMeta {
    uint32_t typeId = 4U; // DumpType枚举值
    uint32_t len = 8U;
    uint16_t blockDim = 0U;
    uint8_t coreType = 0U;
    uint8_t mixFlag = 0U;
    uint32_t rsv = 0U;
};

struct AdxSimtDumpMeta {
    uint32_t typeId = 4U;
    uint32_t len = 8U;
    uint32_t threadId = 0U;
    uint32_t rsv = 0U;
};

enum AdxPosition {
    ADX_GM = 0,
    ADX_UB,
    ADX_L1,
    ADX_L0A,
    ADX_L0B,
    ADX_L0C,
    ADX_BIAS,
    ADX_FIXBUF,
    ADX_MAX
};

const std::unordered_map<uint32_t, std::string> POSITION_MAP {
    {ADX_GM, "GM"},
    {ADX_UB, "UB"},
    {ADX_L1, "L1"},
    {ADX_L0A, "L0A"},
    {ADX_L0B, "L0B"},
    {ADX_L0C, "L0C"},
    {ADX_BIAS, "BIAS"},
    {ADX_FIXBUF, "FIXBUF"},
};

void AdxAssertCallBack(rtExceptionInfo_t *exceptionInfo);

void AdxPrintWorkSpace(const void *workSpaceAddr, const size_t dumpWorkSpaceSize,
                       aclrtStream stream, const char *opType, bool enableSync);

void AdxPrintTimeStamp(const void *workSpaceAddr, const size_t dumpWorkSpaceSize, aclrtStream stream,
    const char *opType, std::vector<MsprofAicTimeStampInfo> &timeStampInfo);

void AdxPrintSetConfig(const Adx::AdumpPrintConfig &config);
bool AdxCheckAtomicIndex(const rtExceptionArgsInfo_t &exceptionArgsInfo);

#ifdef __cplusplus
}
#endif
#endif // DUMP_PRINTF_H
