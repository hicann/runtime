/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpusd_util.h"
namespace AicpuSchedule {
const std::map<ge::DataType, std::string> DTYPE_NAMES {
    {ge::DataType::DT_FLOAT, "DT_FLOAT"},
    {ge::DataType::DT_FLOAT16, "DT_FLOAT16"},
    {ge::DataType::DT_INT8, "DT_INT8"},
    {ge::DataType::DT_INT16, "DT_INT16"},
    {ge::DataType::DT_UINT16, "DT_UINT16"},
    {ge::DataType::DT_UINT8, "DT_UINT8"},
    {ge::DataType::DT_INT32, "DT_INT32"},
    {ge::DataType::DT_INT64, "DT_INT64"},
    {ge::DataType::DT_UINT32, "DT_UINT32"},
    {ge::DataType::DT_UINT64, "DT_UINT64"},
    {ge::DataType::DT_BOOL, "DT_BOOL"},
    {ge::DataType::DT_DOUBLE, "DT_DOUBLE"},
    {ge::DataType::DT_STRING, "DT_STRING"},
    {ge::DataType::DT_DUAL_SUB_INT8, "DT_DUAL_SUB_INT8"},
    {ge::DataType::DT_DUAL_SUB_UINT8, "DT_DUAL_SUB_UINT8"},
    {ge::DataType::DT_COMPLEX64, "DT_COMPLEX64"},
    {ge::DataType::DT_COMPLEX128, "DT_COMPLEX128"},
    {ge::DataType::DT_QINT8, "DT_QINT8"},
    {ge::DataType::DT_QINT16, "DT_QINT16"},
    {ge::DataType::DT_QINT32, "DT_QINT32"},
    {ge::DataType::DT_QUINT8, "DT_QUINT8"},
    {ge::DataType::DT_QUINT16, "DT_QUINT16"},
    {ge::DataType::DT_RESOURCE, "DT_RESOURCE"},
    {ge::DataType::DT_STRING_REF, "DT_STRING_REF"},
    {ge::DataType::DT_DUAL, "DT_DUAL"},
    {ge::DataType::DT_VARIANT, "DT_VARIANT"},
    {ge::DataType::DT_BF16, "DT_BF16"},
    {ge::DataType::DT_UNDEFINED, "DT_UNDEFINED"},
    {ge::DataType::DT_INT4, "DT_INT4"},
    {ge::DataType::DT_UINT1, "DT_UINT1"},
    {ge::DataType::DT_INT2, "DT_INT2"},
    {ge::DataType::DT_UINT2, "DT_UINT2"},
    {ge::DataType::DT_COMPLEX32, "DT_COMPLEX32"}};

    std::string AicpuUtil::GetDTypeString(const ge::DataType curDtype)
    {
        auto iter = DTYPE_NAMES.find(curDtype);
        if (iter != DTYPE_NAMES.end()) {
            return iter->second;
        }
        return "DT_UNDEFINED";
    }
}