/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "adump_pub.h"
#include "log/adx_log.h"
#include "json_parser.h"
#include "adump_error_manager.h"
#include "common/str_utils.h"

#include <fstream>
#include <sstream>
#include <regex>
#include <sys/stat.h>
#include "mmpa/mmpa_api.h"

namespace Adx {

int32_t JsonParser::ParseJsonFromMemory(const char *dumpConfigData, size_t dumpConfigSize, 
    nlohmann::json &js, std::string &errMsg)
{
    errMsg.clear();
    if ((dumpConfigData == nullptr) || (dumpConfigSize == 0U)) {
        errMsg = "Invalid input parameters";
        IDE_LOGD("Parse json from memory failed: invalid input parameters.");
        return ADUMP_INPUT_FAILED;
    }
    try
    {
        std::string_view jsonString(dumpConfigData, dumpConfigSize);
        IDE_LOGI("Parse json string: %.*s", static_cast<int>(jsonString.size()), jsonString.data());
        js = nlohmann::json::parse(jsonString);
        IDE_LOGD("Parse json successfully.");
        return ADUMP_SUCCESS;
    }
    catch(const nlohmann::json::parse_error& e)
    {
        errMsg = e.what();
        IDE_LOGE("JSON parse error: %s", e.what());
    }
    catch(const std::exception& e)
    {
        errMsg = e.what();
        IDE_LOGE("Unexpected error while parsing JSON from memory: %s", e.what());
    }
    return ADUMP_INPUT_FAILED;
}
} // namespace Adx
