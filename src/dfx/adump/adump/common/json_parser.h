/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ADUMP_JSON_PARSER_H
#define ADUMP_JSON_PARSER_H

#include "nlohmann/json.hpp"

namespace Adx {
    class JsonParser {
    public:
        static int32_t ParseJsonFromFile(const char *const fileName, nlohmann::json &js);
        static int32_t ParseJsonFromMemory(const char *dumpConfigData, size_t dumpConfigSize, nlohmann::json &js);
        static const nlohmann::json& GetCfgJsonByKey(const nlohmann::json &js, const std::string &key) {
            return js.at(key);
        }
        static bool ContainKey(const nlohmann::json &js, const std::string &key) {
            return (js.find(key) != js.end());
        }
        static std::string GetCfgStrByKey(const nlohmann::json &js , const std::string &key) {
            return js.at(key).get<std::string>();
        }

    private:
        static void GetMaxNestedLayers(const char *const fileName, const size_t length,
                                       size_t &maxObjDepth, size_t &maxArrayDepth);
        static bool IsValidFileName(const char *const fileName);

        static bool ParseJson(const char *const fileName, nlohmann::json &js, const size_t fileLength);
    };
}
#endif
