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

namespace {
void CountDepth(const char *str, const size_t length, size_t &maxObjDepth, size_t &maxArrayDepth)
{
    size_t arrayDepth = 0;
    size_t objDepth = 0;
    for (size_t i = 0; i < length; i++) {
        if (str[i] == '\0') {
            return;
        }
        if (str[i] == '{') {
            objDepth++;
            if (objDepth > maxObjDepth) {
                maxObjDepth = objDepth;
            }
        } else if (str[i] == '}') {
            if (objDepth > 0) {
                objDepth--;
            }
        } else if (str[i] == '[') {
            arrayDepth++;
            if (arrayDepth > maxArrayDepth) {
                maxArrayDepth = arrayDepth;
            }
        } else if (str[i] == ']') {
            if (arrayDepth > 0) {
                arrayDepth--;
            }
        }
    }
}
} // namespace
namespace Adx {
// 配置文件最大字节数目10MBytes
constexpr int64_t MAX_CONFIG_FILE_BYTE = 10 * 1024 * 1024;
// 配置文件最大递归深度
constexpr size_t MAX_CONFIG_OBJ_DEPTH = 10U;
// 配置文件最大数组个数
constexpr size_t MAX_CONFIG_ARRAY_DEPTH = 10U;

void JsonParser::GetMaxNestedLayers(const char *const fileName, const size_t length,
    size_t &maxObjDepth, size_t &maxArrayDepth)
{
    if (length <= 0) {
        ReportFileOperationError(fileName, FILE_LENGTH_LT_0);
        return;
    }

    char *pBuffer = new(std::nothrow) char[length];
    if (pBuffer == nullptr) {
        IDE_LOGE("New buffer failed");
        return;
    }
    const std::shared_ptr<char> buffer(pBuffer, [](char *const deletePtr) { delete[] deletePtr; });

    std::ifstream fin(fileName);
    if (!fin.is_open()) {
        ReportFileOperationError(fileName, FILE_READ_FAILED);
        return;
    }
    (void)fin.seekg(0, fin.beg);
    (void)fin.read(buffer.get(), static_cast<int64_t>(length));
    CountDepth(buffer.get(), length, maxObjDepth, maxArrayDepth);
    fin.close();
}

bool JsonParser::IsValidFileName(const char *const fileName)
{
    char trustedPath[MMPA_MAX_PATH] = {};
    int32_t ret = mmRealPath(fileName, trustedPath, MMPA_MAX_PATH);
    if (ret != EN_OK) {
        ReportFileOperationError(fileName, StrUtils::Format(FILE_PATH_INVALID,
            StrUtils::Format("mmRealPath return %d, errCode is %d", ret, mmGetErrorCode()).c_str()));
        return false;
    }

    mmStat_t pathStat;
    ret = mmStatGet(trustedPath, &pathStat);
    if (ret != EN_OK) {
        ReportFileOperationError(fileName, StrUtils::Format(FILE_PATH_INVALID,
            StrUtils::Format("mmStatGet return %d, errCode is %d", ret, mmGetErrorCode()).c_str()));
        return false;
    }
    if ((pathStat.st_mode & S_IFMT) != S_IFREG) {
        ReportFileOperationError(fileName, FILE_TYPE_INCORRECT);
        return false;
    }
    if (pathStat.st_size > MAX_CONFIG_FILE_BYTE) {
        ReportFileOperationError(fileName, StrUtils::Format(FILE_LENGTH_GT_MAX, MAX_CONFIG_FILE_BYTE));
        return false;
    }
    return true;
}

bool JsonParser::ParseJson(const char *const fileName, nlohmann::json &js, const size_t fileLength)
{
    std::ifstream fin(fileName);
    if (!fin.is_open()) {
        ReportFileOperationError(fileName, FILE_READ_FAILED);
        return false;
    }

    // checking the depth of file
    size_t maxObjDepth = 0U;
    size_t maxArrayDepth = 0U;
    GetMaxNestedLayers(fileName, fileLength, maxObjDepth, maxArrayDepth);
    if ((maxObjDepth > MAX_CONFIG_OBJ_DEPTH) || (maxArrayDepth > MAX_CONFIG_ARRAY_DEPTH)) {
        ReportFileOperationError(fileName, FILE_JSON_TOO_DEEP);
        fin.close();
        return false;
    }
    IDE_LOGD("Json file's obj's depth is %zu, array's depth is %zu", maxObjDepth, maxArrayDepth);

    try {
        fin >> js;
    } catch (const nlohmann::json::exception &e) {
        ReportFileOperationError(fileName, StrUtils::Format(FILE_JSON_PARSE_FAILED, e.what()));
        fin.close();
        return false;
    }

    fin.close();
    return true;
}

int32_t JsonParser::ParseJsonFromFile(const char *const fileName, nlohmann::json &js)
{
    if (fileName == nullptr) {
        IDE_LOGD("Filename is nullptr, no need to parse json");
        return ADUMP_SUCCESS;
    }
    if (!IsValidFileName(fileName)) {
        return ADUMP_FAILED;
    }
    std::ifstream fin(fileName);
    if (!fin.is_open()) {
        ReportFileOperationError(fileName, FILE_READ_FAILED);
        return ADUMP_FAILED;
    }
    (void)fin.seekg(0, std::ios::end);
    const std::streampos fp = fin.tellg();
    if (static_cast<int32_t>(fp) == 0) {
        IDE_LOGD("Parse file is null");
        fin.close();
        return ADUMP_SUCCESS;
    }
    fin.close();
    if (!ParseJson(fileName, js, static_cast<size_t>(fp))) {
        return ADUMP_FAILED;
    }

    IDE_LOGD("Parse json from file[%s] successfully.", fileName);
    return ADUMP_SUCCESS;
}

int32_t JsonParser::ParseJsonFromMemory(const char *dumpConfigData, size_t dumpConfigSize, nlohmann::json &js)
{
    if ((dumpConfigData == nullptr) || (dumpConfigSize == 0U)) {
        IDE_LOGD("Parse json from memory failed: invaild input parameters.");
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
        IDE_LOGE("JSON parse error: %s", e.what());
    }
    catch(const std::exception& e)
    {
        IDE_LOGE("Unexpected error while parsing JSON from memory: %s", e.what());
    }
    return ADUMP_INPUT_FAILED;
}
} // namespace Adx
