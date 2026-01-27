/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "graph/op_desc.h"
#include "graph/types.h"
#include "graph/utils/type_utils.h"
#include "external/exe_graph/runtime/tiling_context.h"
#include "graph/operator_factory.h"
#include "graph/utils/op_desc_utils.h"
#include "register/op_impl_registry.h"
#include "graph/utils/type_utils.h"
#include "common/util/mem_utils.h"

namespace ge {
int64_t GetSizeInBytes(int64_t count, ge::DataType dataType)
{
    const auto typeSize = GetSizeByDataType(dataType);
    if (typeSize < 0) {
        return -1;
    } else if (typeSize > kDataTypeSizeBitOffset) {
        const auto bitSize = typeSize - kDataTypeSizeBitOffset;
        return ((count * bitSize - 1) / kBitNumOfOneByte) + 1;
    } else {
        return count * typeSize;
    }
}

std::string TypeUtils::FormatToSerialString(const ge::Format format)
{
    return "ND";
}

std::string TypeUtils::DataTypeToSerialString(const ge::DataType dataType)
{
    return "DT_UNDEFINED";
}

const char_t *GetDataTypeStr(DataType dt)
{
    return "float";
}

Format GetFormatFromName(const char_t *format)
{
    return FORMAT_ND;
}

const char_t *GetFormatName(Format format)
{
    return "ND";
}

OpDesc::OpDesc() {}

OpDesc::~OpDesc() {}

ProtoAttrMap &OpDesc::MutableAttrMap()
{
    static ProtoAttrMap mp;
    return mp;
}

ConstProtoAttrMap &OpDesc::GetAttrMap() const
{
    static ConstProtoAttrMap mp;
    return mp;
}

Operator OperatorFactory::CreateOperator(char const* a, char const* b)
{
    return Operator();
}

void Operator::BreakConnect() const {}

graphStatus Operator::GetAllIrAttrNamesAndTypes(std::map<AscendString, AscendString> &attr_name_types) const
{
    return 0;
}

OpDescPtr OpDescUtils::GetOpDescFromOperator(const Operator& oprt)
{
    OpDescPtr ptr = std::make_shared<OpDesc>();
    return ptr;
}

const std::vector<std::pair<std::string, IrInputType>> &OpDesc::GetIrInputs() const
{
    static std::vector<std::pair<std::string, IrInputType>> mp;
    return mp;
}

size_t OpDesc::GetAllInputsSize() const
{
    return 0;
}

const std::vector<std::pair<std::string, IrOutputType>> &OpDesc::GetIrOutputs() const
{
    static std::vector<std::pair<std::string, IrOutputType>> mp;
    return mp;
}

size_t OpDesc::GetOutputsSize() const
{
    return 0;
}

const std::vector<std::string> &OpDesc::GetIrAttrNames() const
{
    static std::vector<std::string> vec;
    return vec;
}

const char_t *AscendString::GetString() const
{
  if (name_ == nullptr) {
    const static char *empty_value = "";
    return empty_value;
  }
  return (*name_).c_str();
}

AscendString::AscendString(const char_t *const name) {
  if (name != nullptr) {
    name_ = MakeShared<std::string>(name);
  }
}

AscendString::AscendString(const char_t *const name, size_t length) {
  if (name != nullptr) {
    name_ = MakeShared<std::string>(name, length);
  }
}

bool AscendString::operator<(const AscendString &d) const
{
  if ((name_ == nullptr) && (d.name_ == nullptr)) {
    return false;
  } else if (name_ == nullptr) {
    return true;
  } else if (d.name_ == nullptr) {
    return false;
  } else {
    return (*name_) < (*(d.name_));
  }
}
size_t AscendString::GetLength() const {
  if (name_ == nullptr) {
    return 0UL;
  }

  return (*name_).length();
}

size_t AscendString::Find(const AscendString &ascend_string) const {
  if ((name_ == nullptr) || (ascend_string.name_ == nullptr)) {
    return std::string::npos;
  }
  return name_->find(*(ascend_string.name_));
}

size_t AscendString::Hash() const {
  if (name_ == nullptr) {
    const static size_t kEmptyStringHash = std::hash<std::string>()("");
    return kEmptyStringHash;
  }

  return std::hash<std::string>()(*name_);
}

bool AscendString::operator>(const AscendString &d) const {
  if ((name_ == nullptr) && (d.name_ == nullptr)) {
    return false;
  } else if (name_ == nullptr) {
    return false;
  } else if (d.name_ == nullptr) {
    return true;
  } else {
    return (*name_) > (*(d.name_));
  }
}

bool AscendString::operator<=(const AscendString &d) const {
  if (name_ == nullptr) {
    return true;
  } else if (d.name_ == nullptr) {
    return false;
  } else {
    return (*name_) <= (*(d.name_));
  }
}

bool AscendString::operator>=(const AscendString &d) const {
  if (d.name_ == nullptr) {
    return true;
  } else if (name_ == nullptr) {
    return false;
  } else {
    return (*name_) >= (*(d.name_));
  }
}

bool AscendString::operator==(const AscendString &d) const {
  if ((name_ == nullptr) && (d.name_ == nullptr)) {
    return true;
  } else if (name_ == nullptr) {
    return false;
  } else if (d.name_ == nullptr) {
    return false;
  } else {
    return (*name_) == (*(d.name_));
  }
}

bool AscendString::operator!=(const AscendString &d) const {
  if ((name_ == nullptr) && (d.name_ == nullptr)) {
    return false;
  } else if (name_ == nullptr) {
    return true;
  } else if (d.name_ == nullptr) {
    return true;
  } else {
    return (*name_) != (*(d.name_));
  }
}

const std::map<std::string, AnyValue::ValueType> kAttrStrTypesMap = {
    {"VT_NONE", AnyValue::VT_NONE},
    {"VT_STRING", AnyValue::VT_STRING},
    {"VT_FLOAT", AnyValue::VT_FLOAT},
    {"VT_BOOL", AnyValue::VT_BOOL},
    {"VT_INT", AnyValue::VT_INT},
    {"VT_TENSOR_DESC", AnyValue::VT_TENSOR_DESC},
    {"VT_TENSOR", AnyValue::VT_TENSOR},
    {"VT_BYTES", AnyValue::VT_BYTES},
    {"VT_GRAPH", AnyValue::VT_GRAPH},
    {"VT_NAMED_ATTRS", AnyValue::VT_NAMED_ATTRS},
    {"VT_LIST_LIST_INT", AnyValue::VT_LIST_LIST_INT},
    {"VT_DATA_TYPE", AnyValue::VT_DATA_TYPE},
    {"VT_LIST_STRING", AnyValue::VT_LIST_STRING},
    {"VT_LIST_FLOAT", AnyValue::VT_LIST_FLOAT},
    {"VT_LIST_BOOL", AnyValue::VT_LIST_BOOL},
    {"VT_LIST_INT", AnyValue::VT_LIST_INT},
    {"VT_LIST_TENSOR_DESC", AnyValue::VT_LIST_TENSOR_DESC},
    {"VT_LIST_TENSOR", AnyValue::VT_LIST_TENSOR},
    {"VT_LIST_BYTES", AnyValue::VT_LIST_BYTES},
    {"VT_GRAPH", AnyValue::VT_GRAPH},
    {"VT_LIST_NAMED_ATTRS", AnyValue::VT_LIST_NAMED_ATTRS},
    {"VT_LIST_DATA_TYPE", AnyValue::VT_LIST_DATA_TYPE},
};

AnyValue::ValueType AttrUtils::SerialStringToValueType(const std::string &value_type_string)
{
  const auto it = kAttrStrTypesMap.find(value_type_string);
  if (it != kAttrStrTypesMap.end()) {
    return it->second;
  } else {
    return AnyValue::VT_NONE;
  }
}
} // namespace ge