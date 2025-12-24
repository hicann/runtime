/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef INC_CDLS_JSON_API_H
#define INC_CDLS_JSON_API_H

#include <fstream>
#include <typeinfo>
#include "json/json.h"
#include "msprof_dlog.h"
#include "utils/utils.h"

#define JSON_PARSE_FILE_FAILED -1

using Json = NanoJson::Json;
using JsonValue = NanoJson::JsonValue;

namespace Msprofiler {
namespace Parser {
using namespace analysis::dvvp::common::utils;
template <typename T>
inline void CatchException(T item, const std::exception &e)
{
    if (typeid(item) == typeid(int8_t) || typeid(item) == typeid(uint8_t) || typeid(item) == typeid(int16_t) ||
        typeid(item) == typeid(uint16_t) || typeid(item) == typeid(int32_t) || typeid(item) == typeid(uint32_t) ||
        typeid(item) == typeid(int64_t) || typeid(item) == typeid(uint64_t)) {
        MSPROF_LOGE("\"%ld\" in config file has exception, which is \"%s\"", item, e.what());
    } else if (typeid(item) == typeid(const char *)) {
        MSPROF_LOGE("\"%s\" in config file has exception, which is \"%s\"", item, e.what());
    } else {
        MSPROF_LOGE("unknown type in config file has exception, which is \"%s\"", e.what());
    }
}

template <>
inline void CatchException(const std::string &item, const std::exception &e)
{
    MSPROF_LOGE("\"%s\" in config file has exception, which is \"%s\"", item.c_str(), e.what());
}

inline void LoadConfigFlie(const std::string &configPath, Json &jsonConfigRoot, bool &flag)
{
    std::string configPathString(configPath);
    configPathString = Utils::CanonicalizePath(configPathString);
    if (configPathString.empty()) {
        MSPROF_LOGW("The configPathString path: [%s] does not exist or permission denied.", configPathString.c_str());
        flag = false;
        return;
    }
    configPathString = Utils::CanonicalizePath(configPathString);
    FUNRET_CHECK_EXPR_ACTION_LOGW(configPathString.empty(), return,
        "The configPathString: %s does not exist or permission denied.", configPathString.c_str());
    std::ifstream jsonConfigFileStream(configPathString, std::ifstream::in);
    if (jsonConfigFileStream.is_open()) {
        try {
            std::istreambuf_iterator<char> beg(jsonConfigFileStream), end;
            std::string str(beg, end);
            jsonConfigRoot.Parse(str);
        } catch (std::runtime_error &e) {
            MSPROF_LOGW("Json file config load fail, path:%s", configPathString.c_str());
            flag = false;
        }
        jsonConfigFileStream.close();
        flag = true;
    } else {
        MSPROF_LOGW("Json file path cannot open, path: %s", configPathString.c_str());
        flag = false;
    }
}

}
}
#endif // INC_CDLS_JSON_API_H
