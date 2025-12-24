/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dump_datatype.h"
#include <map>
#include "log/adx_log.h"
namespace Adx {
namespace {
static constexpr uint32_t K_BIT_NUM_OF_ONE_BYTE = 8U;
const std::map<GeDataType, ProtoDataType> GE_DT_TO_PROTO_DT = {
    { GeDataType::DT_FLOAT, ProtoDataType::DT_FLOAT },
    { GeDataType::DT_FLOAT16, ProtoDataType::DT_FLOAT16 },
    { GeDataType::DT_INT8, ProtoDataType::DT_INT8 },
    { GeDataType::DT_INT16, ProtoDataType::DT_INT16 },
    { GeDataType::DT_UINT16, ProtoDataType::DT_UINT16 },
    { GeDataType::DT_UINT8, ProtoDataType::DT_UINT8 },
    { GeDataType::DT_INT32, ProtoDataType::DT_INT32 },
    { GeDataType::DT_INT64, ProtoDataType::DT_INT64 },
    { GeDataType::DT_UINT32, ProtoDataType::DT_UINT32 },
    { GeDataType::DT_UINT64, ProtoDataType::DT_UINT64 },
    { GeDataType::DT_BOOL, ProtoDataType::DT_BOOL },
    { GeDataType::DT_DOUBLE, ProtoDataType::DT_DOUBLE },
    { GeDataType::DT_STRING, ProtoDataType::DT_STRING },
    { GeDataType::DT_DUAL_SUB_INT8, ProtoDataType::DT_DUAL_SUB_INT8 },
    { GeDataType::DT_DUAL_SUB_UINT8, ProtoDataType::DT_DUAL_SUB_UINT8 },
    { GeDataType::DT_COMPLEX64, ProtoDataType::DT_COMPLEX64 },
    { GeDataType::DT_COMPLEX128, ProtoDataType::DT_COMPLEX128 },
    { GeDataType::DT_QINT8, ProtoDataType::DT_QINT8 },
    { GeDataType::DT_QINT16, ProtoDataType::DT_QINT16 },
    { GeDataType::C_DT_QINT32, ProtoDataType::DT_QINT32 },
    { GeDataType::DT_QUINT8, ProtoDataType::DT_QUINT8 },
    { GeDataType::DT_QUINT16, ProtoDataType::DT_QUINT16 },
    { GeDataType::DT_RESOURCE, ProtoDataType::DT_RESOURCE },
    { GeDataType::DT_STRING_REF, ProtoDataType::DT_STRING_REF },
    { GeDataType::DT_DUAL, ProtoDataType::DT_DUAL },
    { GeDataType::DT_VARIANT, ProtoDataType::DT_VARIANT },
    { GeDataType::DT_BF16, ProtoDataType::DT_BF16 },
    { GeDataType::DT_UNDEFINED, ProtoDataType::DT_UNDEFINED },
    { GeDataType::DT_INT4, ProtoDataType::DT_INT4 },
    { GeDataType::DT_UINT1, ProtoDataType::DT_UINT1 },
    { GeDataType::DT_INT2, ProtoDataType::DT_INT2 },
    { GeDataType::DT_UINT2, ProtoDataType::DT_UINT2 },
    { GeDataType::DT_COMPLEX32, ProtoDataType::DT_COMPLEX32 },
    { GeDataType::DT_HIFLOAT8, ProtoDataType::DT_HIFLOAT8 },
    { GeDataType::DT_FLOAT8_E5M2, ProtoDataType::DT_FLOAT8_E5M2 },
    { GeDataType::DT_FLOAT8_E4M3FN, ProtoDataType::DT_FLOAT8_E4M3FN },
    { GeDataType::DT_FLOAT8_E8M0, ProtoDataType::DT_FLOAT8_E8M0 },
    { GeDataType::DT_FLOAT6_E3M2, ProtoDataType::DT_FLOAT6_E3M2 },
    { GeDataType::DT_FLOAT6_E2M3, ProtoDataType::DT_FLOAT6_E2M3 },
    { GeDataType::DT_FLOAT4_E2M1, ProtoDataType::DT_FLOAT4_E2M1 },
    { GeDataType::DT_FLOAT4_E1M2, ProtoDataType::DT_FLOAT4_E1M2 }
};

static const std::map<toolkit::dump::OutputDataType, std::string> DT_STRING_MAPS = {
    {toolkit::dump::DT_UNDEFINED,      "DT_UNDEFINED"},
    {toolkit::dump::DT_FLOAT,          "DT_FLOAT"},
    {toolkit::dump::DT_FLOAT16,        "DT_FLOAT16"},
    {toolkit::dump::DT_INT8,           "DT_INT8"},
    {toolkit::dump::DT_UINT8,          "DT_UINT8"},
    {toolkit::dump::DT_INT16,          "DT_INT16"},
    {toolkit::dump::DT_UINT16,         "DT_UINT16"},
    {toolkit::dump::DT_INT32,          "DT_INT32"},
    {toolkit::dump::DT_INT64,          "DT_INT64"},
    {toolkit::dump::DT_UINT32,         "DT_UINT32"},
    {toolkit::dump::DT_UINT64,         "DT_UINT64"},
    {toolkit::dump::DT_BOOL,           "DT_BOOL"},
    {toolkit::dump::DT_DOUBLE,         "DT_DOUBLE"},
    {toolkit::dump::DT_STRING,         "DT_STRING"},
    {toolkit::dump::DT_DUAL_SUB_INT8,  "DT_DUAL_SUB_INT8"},
    {toolkit::dump::DT_DUAL_SUB_UINT8, "DT_DUAL_SUB_UINT8"},
    {toolkit::dump::DT_COMPLEX64,      "DT_COMPLEX64"},
    {toolkit::dump::DT_COMPLEX128,     "DT_COMPLEX128"},
    {toolkit::dump::DT_QINT8,          "DT_QINT8"},
    {toolkit::dump::DT_QINT16,         "DT_QINT16"},
    {toolkit::dump::DT_QINT32,         "DT_QINT32"},
    {toolkit::dump::DT_QUINT8,         "DT_QUINT8"},
    {toolkit::dump::DT_QUINT16,        "DT_QUINT16"},
    {toolkit::dump::DT_RESOURCE,       "DT_RESOURCE"},
    {toolkit::dump::DT_STRING_REF,     "DT_STRING_REF"},
    {toolkit::dump::DT_DUAL,           "DT_DUAL"},
    {toolkit::dump::DT_VARIANT,        "DT_VARIANT"},
    {toolkit::dump::DT_BF16,           "DT_BF16"},
    {toolkit::dump::DT_INT4,           "DT_INT4"},
    {toolkit::dump::DT_UINT1,          "DT_UINT1"},
    {toolkit::dump::DT_INT2,           "DT_INT2"},
    {toolkit::dump::DT_UINT2,          "DT_UINT2"},
    {toolkit::dump::DT_HIFLOAT8,       "DT_HIFLOAT8"},
    {toolkit::dump::DT_FLOAT8_E5M2,    "DT_FLOAT8_E5M2"},
    {toolkit::dump::DT_FLOAT8_E4M3FN,  "DT_FLOAT8_E4M3FN"},
    {toolkit::dump::DT_FLOAT8_E8M0,    "DT_FLOAT8_E8M0"},
    {toolkit::dump::DT_FLOAT6_E3M2,    "DT_FLOAT6_E3M2"},
    {toolkit::dump::DT_FLOAT6_E2M3,    "DT_FLOAT6_E2M3"},
    {toolkit::dump::DT_FLOAT4_E2M1,    "DT_FLOAT4_E2M1"},
    {toolkit::dump::DT_FLOAT4_E1M2,    "DT_FLOAT4_E1M2"},
};

static const std::map<toolkit::dump::OutputFormat, std::string> FORMAT_STRING_MAPS = {
    {toolkit::dump::FORMAT_NCHW, "NCHW"},
    {toolkit::dump::FORMAT_NHWC, "NHWC"},
    {toolkit::dump::FORMAT_ND, "ND"},
    {toolkit::dump::FORMAT_NC1HWC0, "NC1HWC0"},
    {toolkit::dump::FORMAT_FRACTAL_Z, "FRACTAL_Z"},
    {toolkit::dump::FORMAT_NC1C0HWPAD, "NC1C0HWPAD"},
    {toolkit::dump::FORMAT_NHWC1C0, "NHWC1C0"},
    {toolkit::dump::FORMAT_FSR_NCHW, "FSR_NCHW"},
    {toolkit::dump::FORMAT_FRACTAL_DECONV, "FRACTAL_DECONV"},
    {toolkit::dump::FORMAT_C1HWNC0, "C1HWNC0"},
    {toolkit::dump::FORMAT_FRACTAL_DECONV_TRANSPOSE, "FRACTAL_DECONV_TRANSPOSE"},
    {toolkit::dump::FORMAT_FRACTAL_DECONV_SP_STRIDE_TRANS, "FRACTAL_DECONV_SP_STRIDE_TRANS"},
    {toolkit::dump::FORMAT_NC1HWC0_C04, "NC1HWC0_C04"},
    {toolkit::dump::FORMAT_FRACTAL_Z_C04, "FRACTAL_Z_C04"},
    {toolkit::dump::FORMAT_CHWN, "CHWN"},
    {toolkit::dump::FORMAT_FRACTAL_DECONV_SP_STRIDE8_TRANS, "FRACTAL_DECONV_SP_STRIDE8_TRANS"},
    {toolkit::dump::FORMAT_HWCN, "HWCN"},
    {toolkit::dump::FORMAT_NC1KHKWHWC0, "NC1KHKWHWC0"},
    {toolkit::dump::FORMAT_BN_WEIGHT, "BN_WEIGHT"},
    {toolkit::dump::FORMAT_FILTER_HWCK, "FILTER_HWCK"},
    {toolkit::dump::FORMAT_HASHTABLE_LOOKUP_LOOKUPS, "HASHTABLE_LOOKUP_LOOKUPS"},
    {toolkit::dump::FORMAT_HASHTABLE_LOOKUP_KEYS, "HASHTABLE_LOOKUP_KEYS"},
    {toolkit::dump::FORMAT_HASHTABLE_LOOKUP_VALUE, "HASHTABLE_LOOKUP_VALUE"},
    {toolkit::dump::FORMAT_HASHTABLE_LOOKUP_OUTPUT, "HASHTABLE_LOOKUP_OUTPUT"},
    {toolkit::dump::FORMAT_HASHTABLE_LOOKUP_HITS, "HASHTABLE_LOOKUP_HITS"},
    {toolkit::dump::FORMAT_C1HWNCoC0, "C1HWNCoC0"},
    {toolkit::dump::FORMAT_MD, "MD"},
    {toolkit::dump::FORMAT_NDHWC, "NDHWC"},
    {toolkit::dump::FORMAT_FRACTAL_ZZ, "FRACTAL_ZZ"},
    {toolkit::dump::FORMAT_FRACTAL_NZ, "FRACTAL_NZ"},
    {toolkit::dump::FORMAT_NCDHW, "NCDHW"},
    {toolkit::dump::FORMAT_DHWCH, "DHWCH"},
    {toolkit::dump::FORMAT_NDC1HWC0, "NDC1HWC0"},
    {toolkit::dump::FORMAT_FRACTAL_Z_3D, "FRACTAL_Z_3D"},
    {toolkit::dump::FORMAT_CN, "CN"},
    {toolkit::dump::FORMAT_NC, "NC"},
    {toolkit::dump::FORMAT_DHWNC, "DHWNC"},
    {toolkit::dump::FORMAT_FRACTAL_Z_3D_TRANSPOSE, "FRACTAL_Z_3D_TRANSPOSE"},
    {toolkit::dump::FORMAT_FRACTAL_ZN_LSTM, "FRACTAL_ZN_LSTM"},
    {toolkit::dump::FORMAT_FRACTAL_Z_G, "FRACTAL_Z_G"},
    {toolkit::dump::FORMAT_RESERVED, "RESERVED"},
    {toolkit::dump::FORMAT_ALL, "ALL"},
    {toolkit::dump::FORMAT_NULL, "NULL"},
    {toolkit::dump::FORMAT_ND_RNN_BIAS, "ND_RNN_BIAS"},
    {toolkit::dump::FORMAT_FRACTAL_ZN_RNN, "FRACTAL_ZN_RNN"},
    {toolkit::dump::FORMAT_NYUV, "NYUV"},
    {toolkit::dump::FORMAT_NYUV_A, "NYUV_A"},
    {toolkit::dump::FORMAT_NCL, "NCL"},
    {toolkit::dump::FORMAT_FRACTAL_Z_WINO, "FRACTAL_Z_WINO"},
    {toolkit::dump::FORMAT_C1HWC0, "C1HWC0"}
};
} // namespace

inline int32_t GetPrimaryFormat(int32_t format)
{
    return static_cast<int32_t>(static_cast<uint32_t>(format) & 0xffU);
}

inline int32_t GetSubFormat(int32_t format)
{
    return static_cast<int32_t>((static_cast<uint32_t>(format) & 0xffff00U) >> K_BIT_NUM_OF_ONE_BYTE);
}

inline bool HasSubFormat(int32_t format)
{
    return GetSubFormat(format) > 0;
}

int32_t DumpDataType::GetIrDataType(GeDataType dataType)
{
    auto it = GE_DT_TO_PROTO_DT.find(dataType);
    int32_t protoDataType = it != GE_DT_TO_PROTO_DT.cend() ?
                            static_cast<int32_t>(it->second) :
                            static_cast<int32_t>(ProtoDataType::DT_UNDEFINED);
    IDE_LOGI("Dump dataType conversion: input=%d, output=%d",
                static_cast<int32_t>(dataType), protoDataType);
    return protoDataType;
}

std::string DumpDataType::FormatToSerialString(const int32_t format)
{
    const auto it = FORMAT_STRING_MAPS.find(static_cast<toolkit::dump::OutputFormat>(GetPrimaryFormat(format)));
    if (it != FORMAT_STRING_MAPS.end()) {
        if (HasSubFormat(format)) {
            return std::string(it->second + ":" + std::to_string(GetSubFormat(format))).c_str();
        }
        return it->second.c_str();
    } else {
        IDE_LOGE("[Check][Param] Format not support %d", format);
        return "RESERVED";
    }
}

std::string DumpDataType::DataTypeToSerialString(const int32_t dataType)
{
    const auto it = DT_STRING_MAPS.find(static_cast<toolkit::dump::OutputDataType>(dataType));
    if (it != DT_STRING_MAPS.end()) {
        return it->second.c_str();
    } else {
        IDE_LOGE("DataTypeToSerialString: datatype not support %d", dataType);
        return "UNDEFINED";
    }
}
} // namespace Adx
