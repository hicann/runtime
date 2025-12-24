/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "json.h"

namespace NanoJson {
namespace helper {
    // Functions for decoding from Json string to JsonValue
    bool Parse(std::string& json, JsonValue& value);
    bool GetJsonObj(std::string& json, JsonValue& value);
    bool GetJsonArray(std::string& json, JsonValue& value);
    bool GetJsonStr(std::string& json, JsonValue& value);
    bool GetJsonBool(std::string& json, JsonValue& value);
    bool GetJsonNum(std::string& json, JsonValue& value);
    bool GetJsonNull(std::string& json, JsonValue& value);

    std::string ToString(const JsonValue& value);
    std::string ObjToJson(const JsonValue& value);
    std::string ArrayToJson(const JsonValue& value);
    std::string StrToJson(const JsonValue& value);
    std::string BoolToJson(const JsonValue& value);
    std::string IntToJson(const JsonValue& value);
    std::string UintToJson(const JsonValue& value);
    std::string DoubleToJson(const JsonValue& value);

    void MemoryFree(JsonValue& value);
    void FreeStr(JsonValue& value);
    void FreeArray(JsonValue& value);
    void FreeObj(JsonValue& value);

    using FromJsonFunc = bool (*)(std::string&, JsonValue&);
    using ToJsonFunc = std::string (*)(const JsonValue&);
    using MemFreeFunc = void (*)(JsonValue& value);

    std::unordered_map<char, FromJsonFunc> g_fromJsonFuncMap = {
        {'{', GetJsonObj}, {'[', GetJsonArray}, {'\"', GetJsonStr}, {'t', GetJsonBool}, {'f', GetJsonBool},
        {'0', GetJsonNum}, {'1', GetJsonNum}, {'2', GetJsonNum}, {'3', GetJsonNum}, {'4', GetJsonNum},
        {'5', GetJsonNum}, {'6', GetJsonNum}, {'7', GetJsonNum}, {'8', GetJsonNum}, {'9', GetJsonNum},
        {'-', GetJsonNum}, {'n', GetJsonNull}
    };
    std::unordered_map<uint8_t, ToJsonFunc> g_toJsonFuncMap = {
        {static_cast<uint8_t>(JsonValueType::OBJECT), ObjToJson},
        {static_cast<uint8_t>(JsonValueType::ARRAY), ArrayToJson},
        {static_cast<uint8_t>(JsonValueType::STRING), StrToJson},
        {static_cast<uint8_t>(JsonValueType::BOOLEAN), BoolToJson},
        {static_cast<uint8_t>(JsonValueType::INT), IntToJson},
        {static_cast<uint8_t>(JsonValueType::UINT), UintToJson},
        {static_cast<uint8_t>(JsonValueType::DOUBLE), DoubleToJson}
    };
    std::unordered_map<uint8_t, MemFreeFunc> g_memFreeFuncMap = {
        {static_cast<uint8_t>(JsonValueType::STRING), FreeStr},
        {static_cast<uint8_t>(JsonValueType::ARRAY), FreeArray},
        {static_cast<uint8_t>(JsonValueType::OBJECT), FreeObj}
    };

    inline void RemoveWhitespaces(std::string& str)
    {
        str.erase(0, str.find_first_not_of(" \r\n\t\v\f"));
    }

    inline void RemoveRedundantSym(std::string& str)
    {
        str.erase(0, str.find_first_not_of(" \r\n\t\v\f,"));
    }

    bool GetJsonStr(std::string& json, JsonValue& value)
    {
        json = json.substr(1);
        RemoveWhitespaces(json);
        size_t pos = json.find('\"', 0);
        if (pos == std::string::npos) {
            return false;
        }
        JSONVALUE_STRING_DEFINE(value, return false, json.substr(0, pos));
        json = json.substr(pos + 1);
        RemoveRedundantSym(json);
        return true;
    }

    bool GetJsonBool(std::string& json, JsonValue& value)
    {
        value.type = JsonValueType::BOOLEAN;
        if (json.substr(0, TRUE_STRING_LEN) == "true") {
            value.value.boolValue = true;
            json = json.substr(TRUE_STRING_LEN);
            RemoveRedundantSym(json);
            return true;
        }
        if (json.substr(0, FALSE_STRING_LEN) == "false") {
            value.value.boolValue = false;
            json = json.substr(FALSE_STRING_LEN);
            RemoveRedundantSym(json);
            return true;
        }
        return false;
    }

    bool GetJsonNum(std::string& json, JsonValue& value)
    {
        size_t pos;
        double num = std::stod(json, &pos);
        if ((pos > 1) &&
            ((json[pos - 1] == '.') || ((json[0] == '0') && (json[1] == '0')) || (json[0] == '-' && json[1] == '.'))) {
            return false;
        }
        for (size_t i = 0; i < pos; i++) {
            if (json[i] == '.') {
                value.type = JsonValueType::DOUBLE;
                value.value.doubleValue = num;
                json = json.substr(pos);
                RemoveRedundantSym(json);
                return true;
            }
        }
        if (json[0] == '-') {
            value.type = JsonValueType::INT;
            try {
                value.value.intValue = std::stoi(json);
            } catch (...) {
                MSPROF_LOGE("Failed to transfer json %s to int.", json.c_str());
                return false;
            }
        } else {
            value.type = JsonValueType::UINT;
            try {
                value.value.uintValue = std::stoi(json);
            } catch (...) {
                MSPROF_LOGE("Failed to transfer json %s to uint.", json.c_str());
                return false;
            }
        }

        json = json.substr(pos);
        RemoveRedundantSym(json);
        return true;
    }

    bool GetJsonNull(std::string& json, JsonValue& value)
    {
        value.type = JsonValueType::NULL_TYPE;
        json = json.substr(TRUE_STRING_LEN);
        RemoveRedundantSym(json);
        return true;
    }

    bool GetJsonArray(std::string& json, JsonValue& value)
    {
        json = json.substr(1);
        RemoveWhitespaces(json);
        JSONVALUE_ARRAY_DEFINE(value, return false);
        while (json[0] != ']') {
            JsonValue tmp;
            if (!Parse(json, tmp) || json.empty()) {
                MemoryFree(tmp);
                return false;
            }
            (*value.value.arrayValue).push_back(tmp);
        }
        RemoveWhitespaces(json);
        json = json.substr(1);
        RemoveRedundantSym(json);
        return true;
    }

    bool GetJsonObj(std::string& json, JsonValue& value)
    {
        json = json.substr(1);
        RemoveWhitespaces(json);
        JsonValue tmp;
        JSONVALUE_OBJECT_DEFINE(value, return false);
        while (json[0] != '}') {
            if ((json[0] != '\"') || json.empty()) {
                return false;
            }
            std::string key;
            json = json.substr(1);
            RemoveWhitespaces(json);
            size_t len = json.find('\"', 0);
            if (len == std::string::npos) {
                return false;
            }
            key = json.substr(0, len);
            json = json.substr(len + 1);
            json.erase(0, json.find_first_not_of(" \r\n\t\v\f:"));
            if (json[0] == ',') {
                RemoveRedundantSym(json);
                continue;
            }
            if (!Parse(json, tmp)) {
                MemoryFree(tmp);
                return false;
            }
            (*value.value.objectValue)[key] = tmp;
        }
        RemoveWhitespaces(json);
        json = json.substr(1);
        RemoveRedundantSym(json);
        return true;
    }

    std::string ObjToJson(const JsonValue& value)
    {
        if ((value.value.objectValue == nullptr) || ((*value.value.objectValue).size() == 0)) {
            return "{}";
        }
        size_t size = (*value.value.objectValue).size();
        std::string str("");
        str += "{";
        auto iter = (*value.value.objectValue).cbegin();
        for (size_t cnt = 0; cnt < size - 1; iter++, cnt++) {
            str += ("\"" + iter->first + "\":" + ToString(iter->second) + ",");
        }
        str += ("\"" + iter->first + "\":" + ToString(iter->second) + "}");
        return str;
    }

    std::string ArrayToJson(const JsonValue& value)
    {
        if ((value.value.arrayValue == nullptr) || ((*value.value.arrayValue).size() == 0)) {
            return "[]";
        }
        size_t size = (*value.value.arrayValue).size();
        std::string str("");
        str += "[";
        for (size_t i = 0; i < size - 1; i++) {
            str += (ToString((*(value.value.arrayValue))[i]) + ",");
        }
        str += (ToString((*(value.value.arrayValue))[size - 1]) + "]");
        return str;
    }

    std::string StrToJson(const JsonValue& value)
    {
        if (value.value.stringValue == nullptr) {
            return "\"\"";
        }
        std::string str("");
        str += ("\"" + (*value.value.stringValue) + "\"");
        return str;
    }

    std::string BoolToJson(const JsonValue& value)
    {
        return (value.value.boolValue) ? "true" : "false";
    }

    std::string IntToJson(const JsonValue& value)
    {
        return std::to_string(value.value.intValue);
    }

    std::string UintToJson(const JsonValue& value)
    {
        return std::to_string(value.value.uintValue);
    }

    std::string DoubleToJson(const JsonValue& value)
    {
        return std::to_string(value.value.doubleValue);
    }

    void FreeStr(JsonValue& value)
    {
        if (value.value.stringValue != nullptr) {
            delete value.value.stringValue;
            value.value.stringValue = nullptr;
        }
    }

    void FreeArray(JsonValue& value)
    {
        if (value.value.arrayValue != nullptr) {
            for (auto& element : *(value.value.arrayValue)) {
                MemoryFree(element);
            }
            value.value.arrayValue->clear();
            delete value.value.arrayValue;
            value.value.arrayValue = nullptr;
        }
    }

    void FreeObj(JsonValue& value)
    {
        if (value.value.objectValue != nullptr) {
            for (auto iter = (*value.value.objectValue).begin();
                iter != (*value.value.objectValue).end();) {
                MemoryFree(iter->second);
                (*value.value.objectValue).erase(iter++);
            }
            value.value.objectValue->clear();
            delete value.value.objectValue;
            value.value.objectValue = nullptr;
        }
    }

    bool Parse(std::string& json, JsonValue& value)
    {
        if (json.size() > MAX_STR_SIZE) {
            throw std::runtime_error("The length of input string is out of range(1M)");
            return false;
        }
        RemoveWhitespaces(json);
        if (json.empty()) {
            throw std::runtime_error("Input string is empty");
            return false;
        }
        char firstChar = json[0];
        if (g_fromJsonFuncMap.find(firstChar) != g_fromJsonFuncMap.end()) {
            return g_fromJsonFuncMap[firstChar](json, value);
        }
        return false;
    }

    std::string ToString(const JsonValue& value)
    {
        uint8_t type = static_cast<uint8_t>(value.type);
        if (value.type == JsonValueType::NULL_TYPE) {
            return "null";
        }
        std::string str("");
        if (g_toJsonFuncMap.find(type) != g_toJsonFuncMap.end()) {
            str += g_toJsonFuncMap[type](value);
        }
        return str;
    }

    void MemoryFree(JsonValue& value)
    {
        uint8_t type = static_cast<uint8_t>(value.type);
        if (g_memFreeFuncMap.find(type) != g_memFreeFuncMap.end()) {
            g_memFreeFuncMap[type](value);
        }
    }
}  // namespace of helper

    JsonValue::JsonValue(JsonValueType jsonType) : type(jsonType), value({nullptr}) {}

    JsonValue& JsonValue::operator=(const int64_t& val)
    {
        type = JsonValueType::INT;
        value.intValue = val;
        return *this;
    }

    JsonValue& JsonValue::operator=(const int32_t& val)
    {
        type = JsonValueType::INT;
        value.intValue = val;
        return *this;
    }

    JsonValue& JsonValue::operator=(const uint64_t& val)
    {
        type = JsonValueType::UINT;
        value.uintValue = val;
        return *this;
    }

    JsonValue& JsonValue::operator=(const uint32_t& val)
    {
        type = JsonValueType::UINT;
        value.uintValue = val;
        return *this;
    }

    JsonValue& JsonValue::operator=(const double& val)
    {
        type = JsonValueType::DOUBLE;
        value.doubleValue = val;
        return *this;
    }

    JsonValue& JsonValue::operator=(const bool& val)
    {
        type = JsonValueType::BOOLEAN;
        value.boolValue = val;
        return *this;
    }

    JsonValue& JsonValue::operator=(const std::string& val)
    {
        type = JsonValueType::STRING;
        if (value.stringValue == nullptr) {
            JSONVALUE_STRING_DEFINE(*this, return *this, val);
        } else {
            (*value.stringValue) = val;
        }
        return *this;
    }

    JsonValue& JsonValue::operator[](const std::string& key)
    {
        if (value.objectValue == nullptr) {
            JSONVALUE_OBJECT_DEFINE(*this, return *this);
            return (*(this->value.objectValue))[key];
        }
        if (type == JsonValueType::OBJECT) {
            return (*(this->value.objectValue))[key];
        } else {
            MSPROF_LOGE("Invalid visit for object variable");
            return *this;
        }
    }

    JsonValue& JsonValue::operator[](const size_t& idx)
    {
        if ((type == JsonValueType::ARRAY) && (this->value.arrayValue != nullptr) &&
            (idx < (*(this->value.arrayValue)).size())) {
            return (*(this->value.arrayValue))[idx];
        } else {
            MSPROF_LOGE("Invalid visit for array variable");
            return *this;
        }
    }

    std::string JsonValue::operator()() const
    {
        return NanoJson::helper::ToString(*this);
    }

    template<> bool JsonValue::GetValue<bool>() const
    {
        if ((this->type == JsonValueType::BOOLEAN) || (this->type == JsonValueType::UINT) ||
            (this->type == JsonValueType::INT)) {
            return this->value.boolValue;
        } else {
            if (this->type != JsonValueType::INVALID) {
                MSPROF_LOGE("Invalid data type for boolean variable");
            }
        }
        return false;
    }

    template<> double JsonValue::GetValue<double>() const
    {
        if (this->type == JsonValueType::DOUBLE) {
            return this->value.doubleValue;
        } else {
            if (this->type != JsonValueType::INVALID) {
                MSPROF_LOGE("Invalid data type for double variable");
            }
        }
        return 0.0;
    }

    template<> int64_t JsonValue::GetValue<int64_t>() const
    {
        if ((this->type == JsonValueType::BOOLEAN) || (this->type == JsonValueType::UINT) ||
            (this->type == JsonValueType::INT)) {
            return this->value.intValue;
        } else {
            if (this->type != JsonValueType::INVALID) {
                MSPROF_LOGE("Invalid data type for int variable");
            }
        }
        return 0;
    }

    template<> uint64_t JsonValue::GetValue<uint64_t>() const
    {
        if ((this->type == JsonValueType::BOOLEAN) || (this->type == JsonValueType::UINT) ||
            (this->type == JsonValueType::INT)) {
            return this->value.uintValue;
        } else {
            if (this->type != JsonValueType::INVALID) {
                MSPROF_LOGE("Invalid data type for uint variable");
            }
        }
        return 0;
    }

    template<> int32_t JsonValue::GetValue<int32_t>() const
    {
        if ((this->type == JsonValueType::BOOLEAN) || (this->type == JsonValueType::UINT) ||
            (this->type == JsonValueType::INT)) {
            return static_cast<int32_t>(this->value.intValue);
        } else {
            if (this->type != JsonValueType::INVALID) {
                MSPROF_LOGE("Invalid data type for int variable");
            }
        }
        return 0;
    }

    template<> uint32_t JsonValue::GetValue<uint32_t>() const
    {
        if ((this->type == JsonValueType::BOOLEAN) || (this->type == JsonValueType::UINT) ||
            (this->type == JsonValueType::INT)) {
            return static_cast<uint32_t>(this->value.uintValue);
        } else {
            if (this->type != JsonValueType::INVALID) {
                MSPROF_LOGE("Invalid data type for uint variable");
            }
        }
        return 0;
    }

    template<> void* JsonValue::GetValue<void *>() const
    {
        if (this->type != JsonValueType::NULL_TYPE) {
            MSPROF_LOGE("Invalid data type for null variable");
        }
        return nullptr;
    }

    template<> std::string JsonValue::GetValue<std::string>() const
    {
        if ((this->type == JsonValueType::STRING) && (this->value.stringValue != nullptr)) {
            return *(this->value.stringValue);
        } else {
            if (this->type != JsonValueType::INVALID) {
                MSPROF_LOGE("Invalid data type for string variable");
            }
        }
        return "";
    }

    template<> JsonArray JsonValue::GetValue<JsonArray>() const
    {
        if ((this->type == JsonValueType::ARRAY) && (this->value.arrayValue != nullptr)) {
            return *(this->value.arrayValue);
        } else {
            if (this->type != JsonValueType::INVALID) {
                MSPROF_LOGE("Invalid data type for string variable");
            }
        }
        return JsonArray();
    }

    template<> JsonObj JsonValue::GetValue<JsonObj>() const
    {
        if ((this->type == JsonValueType::OBJECT) && (this->value.objectValue != nullptr)) {
            return *(this->value.objectValue);
        } else {
            if (this->type != JsonValueType::INVALID) {
                MSPROF_LOGE("Invalid data type for string variable");
            }
        }
        return JsonObj();
    }

    void JsonValue::SetArraySize(const size_t& size)
    {
        if (this->value.arrayValue != nullptr) {
            MSPROF_LOGE("SetArraySize is only valid for JsonValue without allocating memory");
            return;
        }
        JSONVALUE_ARRAY_DEFINE(*this, return, size);
    }

    void JsonValue::PushBack(JsonValue &val)
    {
        if ((this->type != JsonValueType::ARRAY)) {
            MSPROF_LOGE("PushBack() is only valid for ARRAY type");
            return;
        }
        if (this->value.arrayValue == nullptr) {
            JSONVALUE_ARRAY_DEFINE(*this, return);
        }
        (*value.arrayValue).push_back(val);
    }

    bool JsonValue::Contains(const std::string& key) const
    {
        if ((this->type == JsonValueType::INVALID) || (this->value.objectValue == nullptr)) {
            return false;
        }
        if (this->type != JsonValueType::OBJECT) {
            MSPROF_LOGE("Invalid data type");
            return false;
        } else {
            return (this->value.objectValue->find(key) != this->value.objectValue->end());
        }
    }

    Json::Json()
    {
        value_.type = JsonValueType::OBJECT;
        value_.value.objectValue = nullptr;
    }

    Json::Json(const JsonValue& val)
    {
        if (val.type == JsonValueType::OBJECT) {
            value_ = val;
        } else {
            throw std::runtime_error("Cannot assign a JsonValue without Object type to Json");
        }
    }

    Json::Json(const std::string &json)
    {
        NanoJson::Json::Parse(json);
    }

    Json::~Json()
    {
        if (value_.value.objectValue != nullptr) {
            helper::MemoryFree(value_);
        }
    }

    void Json::Parse(const std::string& json)
    {
        std::string str = json;
        try {
            if ((!helper::Parse(str, value_)) ||
                (value_.type != JsonValueType::OBJECT)) {
                helper::MemoryFree(value_);
                throw std::runtime_error("Input json string error");
            }
        } catch(std::runtime_error& e) {
            throw std::runtime_error(e.what());
        }
    }

    void Json::Insert(const JsonValue& val)
    {
        if (val.type == JsonValueType::OBJECT && val.value.objectValue != nullptr) {
            std::unordered_map<std::string, NanoJson::JsonValue> obj = (*val.value.objectValue);
            for (auto iter = obj.begin(); iter != obj.end(); iter++) {
                value_[iter->first] = iter->second;
            }
        }
    }

    Json &Json::RemoveByKey(const std::string &key)
    {
        if (value_.type != JsonValueType::OBJECT || value_.value.objectValue == nullptr) {
            return *this;
        }
        auto it = value_.value.objectValue->find(key);
        if (it != value_.value.objectValue->cend()) {
            helper::MemoryFree(value_.value.objectValue->at(key));
            value_.value.objectValue->erase(it);
        }
        return *this;
    }

    JsonValue& Json::operator[](const std::string& key)
    {
        return value_[key];
    }

    void Json::operator=(const JsonValue& val)
    {
        if (val.type == JsonValueType::OBJECT) {
            value_ = val;
        } else {
            MSPROF_LOGE("Cannot assign a JsonValue without Object type to Json");
            return;
        }
    }

    std::string Json::ToString() const
    {
        return value_();
    }

    JsonValue Json::GetJsonValue() const
    {
        return value_;
    }

    bool Json::Contains(const std::string& key) const
    {
        return value_.Contains(key);
    }

    std::unordered_map<std::string, JsonValue>::iterator Json::Begin() const
    {
        if (value_.value.objectValue != nullptr) {
            return value_.value.objectValue->begin();
        } else {
            return this->End();
        }
    }

    std::unordered_map<std::string, JsonValue>::iterator Json::End() const
    {
        if (value_.value.objectValue != nullptr) {
            return value_.value.objectValue->end();
        } else {
            return std::unordered_map<std::string, JsonValue>::iterator();
        }
    }
}  // end of namespace NanoJson
