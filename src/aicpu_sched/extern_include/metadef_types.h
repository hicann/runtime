/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPU_SD_EXTERNAL_GRAPH_METADEF_TYPES_H_
#define AICPU_SD_EXTERNAL_GRAPH_METADEF_TYPES_H_

#include <cstdint>

namespace ge {
using char_t = char;
using float32_t = float;
using float64_t = double;

// When data type unit is bit, this offset need to be added.
static constexpr int32_t kDataTypeSizeBitOffset = 1000;
static constexpr uint32_t kBitNumOfOneByte = 8U;

enum DataType {
    DT_FLOAT = 0,
    DT_FLOAT16 = 1,
    DT_INT8 = 2,
    DT_INT32 = 3,
    DT_UINT8 = 4,
    // 5 reserved
    DT_INT16 = 6,
    DT_UINT16 = 7,
    DT_UINT32 = 8,
    DT_INT64 = 9,
    DT_UINT64 = 10,
    DT_DOUBLE = 11,
    DT_BOOL = 12,
    DT_STRING = 13,
    DT_DUAL_SUB_INT8 = 14,
    DT_DUAL_SUB_UINT8 = 15,
    DT_COMPLEX64 = 16,
    DT_COMPLEX128 = 17,
    DT_QINT8 = 18,
    DT_QINT16 = 19,
    DT_QINT32 = 20,
    DT_QUINT8 = 21,
    DT_QUINT16 = 22,
    DT_RESOURCE = 23,
    DT_STRING_REF = 24,
    DT_DUAL = 25,
    DT_VARIANT = 26,
    DT_BF16 = 27,
    DT_UNDEFINED = 28,
    DT_INT4 = 29,
    DT_UINT1 = 30,
    DT_INT2 = 31,
    DT_UINT2 = 32,
    DT_COMPLEX32 = 33,
    DT_HIFLOAT8 = 34,
    DT_FLOAT8_E5M2 = 35,
    DT_FLOAT8_E4M3FN = 36,
    DT_FLOAT8_E8M0 = 37,
    DT_FLOAT6_E3M2 = 38,
    DT_FLOAT6_E2M3 = 39,
    DT_FLOAT4_E2M1 = 40,
    DT_FLOAT4_E1M2 = 41,
    DT_HIFLOAT4 = 42,
    DT_MAX = 43,
};

inline int GetSizeByDataType(DataType data_type)
{
    static int data_type_size[DT_MAX] = {
        4,                          // DT_FLOAT = 0,             float type
        2,                          // DT_FLOAT16 = 1,           fp16 type
        1,                          // DT_INT8 = 2,              int8 type
        4,                          // DT_INT32 = 3,             int32 type
        1,                          // DT_UINT8 = 4,             uint8 type
        -1,                         // reserved
        2,                          // DT_INT16 = 6,             int16 type
        2,                          // DT_UINT16 = 7,            uint16 type
        4,                          // DT_UINT32 = 8,            unsigned int32
        8,                          // DT_INT64 = 9,             int64 type
        8,                          // DT_UINT64 = 10,           unsigned int64
        8,                          // DT_DOUBLE = 11,           double type
        1,                          // DT_BOOL = 12,             bool type
        -1,                         // DT_STRING = 13,           string type
        1,                          // DT_DUAL_SUB_INT8 = 14,    dual output int8 type
        1,                          // DT_DUAL_SUB_UINT8 = 15,   dual output uint8 type
        8,                          // DT_COMPLEX64 = 16,        complex64 type
        16,                         // DT_COMPLEX128 = 17,       complex128 type
        1,                          // DT_QINT8 = 18,            qint8 type
        2,                          // DT_QINT16 = 19,           qint16 type
        4,                          // DT_QINT32 = 20,           qint32 type
        1,                          // DT_QUINT8 = 21,           quint8 type
        2,                          // DT_QUINT16 = 22,          quint16 type
        8,                          // DT_RESOURCE = 23,         resource type
        -1,                         // DT_STRING_REF = 24,       string ref type
        5,                          // DT_DUAL = 25,             dual output type (float + int8)
        8,                          // DT_VARIANT                variant type
        2,                          // DT_BF16 = 27,             bf16 type
        -1,                         // DT_UNDEFINED = 28         Used to indicate a DataType field has not been set.
        kDataTypeSizeBitOffset + 4, // DT_INT4 = 29,             int4 type
        kDataTypeSizeBitOffset + 1, // DT_UINT1 = 30,            uint1 type
        kDataTypeSizeBitOffset + 2, // DT_INT2 = 31,             int2 type
        kDataTypeSizeBitOffset + 2, // DT_UINT2 = 32,            uint2 type
        4,                          // DT_COMPLEX32 = 33,        complex32 type
        1,                          // DT_HIFLOAT8,              hifloat8 type
        1,                          // DT_FLOAT8_E5M2,           float8_e5m2 type
        1,                          // DT_FLOAT8_E4M3FN,         float8_e4m3fn type
        1,                          // DT_FLOAT8_E8M0,           float8_e8m0 type
        kDataTypeSizeBitOffset + 6, // DT_FLOAT6_E3M2,           float6_e3m2 type, 6bit
        kDataTypeSizeBitOffset + 6, // DT_FLOAT6_E2M3,           float6_e2m3 type, 6bit
        kDataTypeSizeBitOffset + 4, // DT_FLOAT4_E2M1,           float4_e2m1 type, 4bit
        kDataTypeSizeBitOffset + 4, // DT_FLOAT4_E1M2,           float4_e1m2 type, 4bit
        kDataTypeSizeBitOffset + 4, // DT_HIFLOAT4,              hifloat4 type, 4bit
                                    // DT_MAX
    };
    if ((data_type < 0) || (data_type >= DT_MAX)) {
        return -1;
    }
    return data_type_size[data_type];
}

inline int32_t GetPrimaryFormat(int32_t format) { return static_cast<int32_t>(static_cast<uint32_t>(format) & 0xffU); }

inline int32_t GetSubFormat(int32_t format)
{
    return static_cast<int32_t>((static_cast<uint32_t>(format) & 0xffff00U) >> kBitNumOfOneByte);
}

} // namespace ge

#endif // AICPU_SD_EXTERNAL_GRAPH_METADEF_TYPES_H_
