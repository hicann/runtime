/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __KFC_DUMP_PARAM_H__
#define __KFC_DUMP_PARAM_H__

#include <cstdint>
#include "kernel_operator.h"

// David 系列芯片架构（3510/9201）：支持硬件同步指令、uint8 类型需要 cache buf
#if defined(__NPU_ARCH__) && ((__NPU_ARCH__ == 3510) || (__NPU_ARCH__ == 9201)) && defined(__DAV_VEC__)
#define KFC_DUMP_ARCH_DAVID 1
#else
#define KFC_DUMP_ARCH_DAVID 0
#endif

namespace KfcDumpStat {
using namespace AscendC;

constexpr uint32_t DUMP_MSG_CNT = 16U; // 消息队列深度
constexpr uint32_t DUMP_MSG_VALID_MASK = 0x5CDF123A;
constexpr uint32_t MSG_TYPE_INDEX = 0;
constexpr uint32_t MSG_VALID_INDEX = 12;
constexpr uint32_t MSG_RESULT_INDEX = 13;
constexpr uint32_t MSG_RESULT_SUCCESS = 0;
constexpr uint32_t MSG_RESULT_FAILED = 1;

enum class OutputDataType : uint32_t {
    DUMP_DT_UNDEFINED = 0,
    DUMP_DT_FLOAT = 1,
    DUMP_DT_FLOAT16 = 2,
    DUMP_DT_INT8 = 3,
    DUMP_DT_UINT8 = 4,
    DUMP_DT_INT16 = 5,
    DUMP_DT_UINT16 = 6,
    DUMP_DT_INT32 = 7,
    DUMP_DT_INT64 = 8,
    DUMP_DT_UINT32 = 9,
    DUMP_DT_UINT64 = 10,
    DUMP_DT_BOOL = 11,
    DUMP_DT_DOUBLE = 12,
    DUMP_DT_STRING = 13,
    DUMP_DT_DUAL_SUB_INT8 = 14,
    DUMP_DT_DUAL_SUB_UINT8 = 15,
    DUMP_DT_COMPLEX64 = 16,
    DUMP_DT_COMPLEX128 = 17,
    DUMP_DT_QINT8 = 18,
    DUMP_DT_QINT16 = 19,
    DUMP_DT_QINT32 = 20,
    DUMP_DT_QUINT8 = 21,
    DUMP_DT_QUINT16 = 22,
    DUMP_DT_RESOURCE = 23,
    DUMP_DT_STRING_REF = 24,
    DUMP_DT_DUAL = 25,
    DUMP_DT_VARIANT = 26,
    DUMP_DT_BF16 = 27,
    DUMP_DT_HIFLOAT8 = 33,
    DUMP_DT_FLOAT8_E5M2 = 34,
    DUMP_DT_FLOAT8_E4M3FN = 35,
    DUMP_DT_FLOAT8_E8M0 = 36,
    DUMP_DT_FLOAT6_E3M2 = 37,
    DUMP_DT_FLOAT6_E2M3 = 38,
    DUMP_DT_FLOAT4_E2M1 = 39,
    DUMP_DT_FLOAT4_E1M2 = 40,
};

struct KfcDumpContext {
    uint64_t msgQ;
    uint64_t workspace;
    uint64_t workspaceSize;
    uint64_t aiCoreNum;
    uint64_t ubSize;
    uint64_t syncspace;
};

enum class StatClass : int64_t {
    STAT_MAX = 0,
    STAT_MIN = 1,
    STAT_MEAN = 2,
    STAT_NAN = 3,
    STAT_NEG_INF = 4,
    STAT_POS_INF = 5,
    STAT_L2NORM = 6,
};

enum class DumpStatMsgType : uint32_t {
    KFC_DUMP_MSG_DEFAULT = 0,
    KFC_DUMP_MSG_REQUEST = 1,  // dump request
    KFC_DUMP_MSG_RESPONSE = 2, // dump response
    KFC_DUMP_MSG_FINISHED = 3, // dump finished
    KFC_DUMP_MSG_RESERVED      // reserved
};

struct KfcDumpStatMsg {
    volatile DumpStatMsgType msgType; // 消息类型
    volatile uint32_t dataType;       // 待统计数据类型
    volatile uint64_t dataCount;      // 待统计数据个数
    volatile uint64_t dataAddr;       // 待统计数据地址
    volatile uint64_t dumpStatClass;  // 需要做那些统计项
    volatile uint64_t outputAddr;     // 统计结果输出地址
    volatile uint64_t outputAddrSize; // 统计结果输出地址大小

    volatile uint32_t valid;          // 消息有效位为 DUMP_MSG_VALID_MASK，发送发设置，读取方重置
    volatile uint32_t result;         // 统计结果返回码，0 代表成功，1 代表数据类型不支持
    uint32_t reserved[2];             // 凑够 64 字节
};

struct KfcDumpMsgBody {
    KfcDumpStatMsg msgSndArea[DUMP_MSG_CNT];
    KfcDumpStatMsg msgRcvArea[DUMP_MSG_CNT];
};

} // namespace KfcDumpStat

#endif // __KFC_DUMP_PARAM_H__
