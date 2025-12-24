/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ACL_JSON_PARSER_H
#define ACL_JSON_PARSER_H

#include "nlohmann/json.hpp"
#include "acl/acl_base.h"
#include "log_inner.h"
#include "utils/cann_info_utils.h"

namespace acl {
    class JsonParser {
    public:
        static aclError ParseJsonFromFile(const char_t *const fileName, nlohmann::json &js);
        static aclError GetJsonCtxByKey(
            const char_t *const fileName, std::string &strJsonCtx, const std::string &subStrKey, bool &found);
        static aclError GetAttrConfigFromFile(
            const char_t *const fileName, std::map<aclCannAttr, CannInfo> &cannInfoMap);
        static aclError GetDefaultDeviceIdFromFile(const char_t *const fileName, int32_t& devId);
        static aclError GetEventModeFromFile(const char_t *const fileName, uint8_t &event_mode, bool &found);
        static aclError GetStackSize(const char_t *const fileName, size_t &aicoreStackSize, bool &exist);
        static aclError ParseJson(const char_t *const configStr, nlohmann::json &js);
        static aclError GetConfigStrFromFile(const char_t *const fileName, std::string &configStr);

    private:
        static void GetMaxNestedLayers(const char_t *const fileName, const size_t length,
                                       size_t &maxObjDepth, size_t &maxArrayDepth);
        static bool IsValidFileName(const char_t *const fileName);

        static const nlohmann::json& GetCfgJsonByKey(const nlohmann::json &js, const std::string &key) {
            return js.at(key);
        }

        static std::string GetCfgStrByKey(const nlohmann::json &js , const std::string &key) {
            return js.at(key).get<std::string>();
        }
        
        static bool ContainKey(const nlohmann::json &js, const std::string &key) {
            return (js.find(key) != js.end());
        }
    };
}
#endif // ACL_JSON_PARSER_H
