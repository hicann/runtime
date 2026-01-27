/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DUMP_DATATYPE_H
#define DUMP_DATATYPE_H
#include <cstdint>
#include <string>

namespace Adx {
enum class GeDataType: int32_t {
    DT_FLOAT = 0,            // float type
    DT_FLOAT16 = 1,          // fp16 type
    DT_INT8 = 2,             // int8 type
    DT_INT32 = 3,            // int32 type
    DT_UINT8 = 4,            // uint8 type
    // reserved
    DT_INT16 = 6,            // int16 type
    DT_UINT16 = 7,           // uint16 type
    DT_UINT32 = 8,           // unsigned int32
    DT_INT64 = 9,            // int64 type
    DT_UINT64 = 10,          // unsigned int64
    DT_DOUBLE = 11,          // double type
    DT_BOOL = 12,            // bool type
    DT_STRING = 13,          // string type
    DT_DUAL_SUB_INT8 = 14,   // dual output int8 type
    DT_DUAL_SUB_UINT8 = 15,  // dual output uint8 type
    DT_COMPLEX64 = 16,       // complex64 type
    DT_COMPLEX128 = 17,      // complex128 type
    DT_QINT8 = 18,           // qint8 type
    DT_QINT16 = 19,          // qint16 type
    DT_QINT32 = 20,          // qint32 type
    DT_QUINT8 = 21,          // quint8 type
    DT_QUINT16 = 22,         // quint16 type
    DT_RESOURCE = 23,        // resource type
    DT_STRING_REF = 24,      // string ref type
    DT_DUAL = 25,            // dual output type
    DT_VARIANT = 26,         // dt_variant type
    DT_BF16 = 27,            // bf16 type
    DT_UNDEFINED = 28,       // Used to indicate a DataType field has not been set.
    DT_INT4 = 29,            // int4 type
    DT_UINT1 = 30,           // uint1 type
    DT_INT2 = 31,            // int2 type
    DT_UINT2 = 32,           // uint2 type
    DT_COMPLEX32 = 33,       // complex32 type
    DT_HIFLOAT8 = 34,        // hifloat8 type
    DT_FLOAT8_E5M2 = 35,     // float8_e5m2 type
    DT_FLOAT8_E4M3FN = 36,   // float8_e4m3fn type
    DT_FLOAT8_E8M0 = 37,     // float8_e8m0 type
    DT_FLOAT6_E3M2 = 38,     // float6_e3m2 type
    DT_FLOAT6_E2M3 = 39,     // float6_e2m3 type
    DT_FLOAT4_E2M1 = 40,     // float4_e2m1 type
    DT_FLOAT4_E1M2 = 41     // float4_e1m2 type
};

enum class ProtoDataType: int32_t {
    DT_UNDEFINED = 0,  // Used to indicate a DataType field has not been set.
    DT_FLOAT     = 1,  // float type
    DT_FLOAT16   = 2,  // fp16 type
    DT_INT8      = 3,  // int8 type
    DT_UINT8     = 4,  // uint8 type
    DT_INT16     = 5,  // int16 type
    DT_UINT16    = 6,  // uint16 type
    DT_INT32     = 7,  //
    DT_INT64     = 8,  // int64 type
    DT_UINT32    = 9,  // unsigned int32
    DT_UINT64    = 10,  // unsigned int64
    DT_BOOL      = 11,  // bool type
    DT_DOUBLE    = 12, // double type
    DT_STRING = 13,            // string type
    DT_DUAL_SUB_INT8 = 14,    /**< dual output int8 type */
    DT_DUAL_SUB_UINT8 = 15,    /**< dual output uint8 type */
    DT_COMPLEX64 = 16,         // complex64 type
    DT_COMPLEX128 = 17,        // complex128 type
    DT_QINT8 = 18,             // qint8 type
    DT_QINT16 = 19,            // qint16 type
    DT_QINT32 = 20,            // qint32 type
    DT_QUINT8 = 21,            // quint8 type
    DT_QUINT16 = 22,           // quint16 type
    DT_RESOURCE  = 23,         // resource type
    DT_STRING_REF = 24,        // string_ref type
    DT_DUAL      = 25,              /**< dual output type */
    DT_VARIANT = 26,           // variant type
    DT_BF16 = 27,              // bf16 type
    DT_INT4 = 28,              // int4 type
    DT_UINT1 = 29,             // uint1 type
    DT_INT2 = 30,              // int2 type
    DT_UINT2 = 31,             // uint2 type
    DT_COMPLEX32 = 32,         // complex32 type
    DT_HIFLOAT8 = 33,          // hifloat8 type
    DT_FLOAT8_E5M2 = 34,       // float8_e5m2 type
    DT_FLOAT8_E4M3FN = 35,     // float8_e4m3fn type
    DT_FLOAT8_E8M0 = 36,       // float8_e8m0 type
    DT_FLOAT6_E3M2 = 37,       // float6_e3m2 type
    DT_FLOAT6_E2M3 = 38,       // float6_e2m3 type
    DT_FLOAT4_E2M1 = 39,       // float4_e2m1 type
    DT_FLOAT4_E1M2 = 40       // float4_e1m2 type
};

enum class ImplyType : unsigned int {
  BUILDIN = 0,  // Built in operator, normally executed by OME
  TVM,          // Compile to TVM bin file for execution
  CUSTOM,       // User defined calculation logic, executed by CPU
  AI_CPU,       // AICPU
  CCE,          // Cce
  GELOCAL,      // GE local, do node need execute by device
  HCCL,         // Hccl
  INVALID = 0xFFFFFFFF,
};

class DumpDataType {
public:
    static int32_t GetIrDataType(GeDataType dataType);
    static std::string FormatToSerialString(const int32_t format);
    static std::string DataTypeToSerialString(const int32_t dataType);
};
} // namespace Adx
#endif // DUMP_DATATYPE_H
