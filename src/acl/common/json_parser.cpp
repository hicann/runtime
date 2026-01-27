/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "json_parser.h"

#include <fstream>
#include <sstream>
#include <regex>
#include <sys/stat.h>
#include "mmpa/mmpa_api.h"

namespace {
const std::string ACL_JSON_DEFAULT_DEVICE = "defaultDevice";
const std::string ACL_JSON_DEFAULT_DEVICE_ID = "default_device";
constexpr int32_t DECIMAL = 10;

void CountDepth(const char_t ch, size_t &objDepth, size_t &maxObjDepth, size_t &arrayDepth, size_t &maxArrayDepth)
{
    switch (ch) {
        case '{': {
            ++objDepth;
            if (objDepth > maxObjDepth) {
                maxObjDepth = objDepth;
            }
            break;
        }
        case '}': {
            if (objDepth > 0) {
                --objDepth;
            }
            break;
        }
        case '[': {
            ++arrayDepth;
            if (arrayDepth > maxArrayDepth) {
                maxArrayDepth = arrayDepth;
            }
            break;
        }
        case ']': {
            if (arrayDepth > 0) {
                --arrayDepth;
            }
            break;
        }
        default: {
            return;
        }
    }
}
} // namespace
namespace acl {
    // 配置文件最大字节数目10MBytes
    constexpr int64_t MAX_CONFIG_FILE_BYTE = 10 * 1024 * 1024;
    // 配置文件最大递归深度
    constexpr size_t MAX_CONFIG_OBJ_DEPTH = 10U;
    // 配置文件最大数组个数
    constexpr size_t MAX_CONFIG_ARRAY_DEPTH = 10U;

    void JsonParser::GetMaxNestedLayers(const char_t *const fileName, const size_t length,
        size_t &maxObjDepth, size_t &maxArrayDepth)
    {
        if (length <= 0) {
            ACL_LOG_INNER_ERROR("[Check][Length]the length of file %s must be larger than 0.", fileName);
            return;
        }

        char_t *pBuffer = new(std::nothrow) char_t[length];
        ACL_REQUIRES_NOT_NULL_RET_VOID(pBuffer);
        const std::shared_ptr<char_t> buffer(pBuffer, [](char_t *const deletePtr) { delete[] deletePtr; });

        std::ifstream fin(fileName);
        if (!fin.is_open()) {
            ACL_LOG_INNER_ERROR("[Open][File]read file %s failed.", fileName);
            return;
        }
        (void)fin.seekg(0, fin.beg);
        (void)fin.read(buffer.get(), static_cast<int64_t>(length));

        size_t arrayDepth = 0U;
        size_t objDepth = 0U;
        for (size_t i = 0U; i < length; ++i) {
            const char_t v = buffer.get()[i];
            if (v == '\0') {
                fin.close();
                return;
            }
            CountDepth(v, objDepth, maxObjDepth, arrayDepth, maxArrayDepth);
        }
        fin.close();
    }

    bool JsonParser::IsValidFileName(const char_t *const fileName)
    {
        char_t trustedPath[MMPA_MAX_PATH] = {};
        int32_t ret = mmRealPath(fileName, trustedPath, MMPA_MAX_PATH);
        if (ret != EN_OK) {
            const auto formatErrMsg = acl::AclGetErrorFormatMessage(mmGetErrorCode());
            ACL_LOG_INNER_ERROR("[Trans][RealPath]the file path %s is not like a real path, mmRealPath return %d, "
                "errMessage is %s", fileName, ret, formatErrMsg.c_str());
            return false;
        }

        mmStat_t pathStat;
        ret = mmStatGet(trustedPath, &pathStat);
        if (ret != EN_OK) {
            ACL_LOG_INNER_ERROR("[Get][FileStatus]cannot get config file status, which path is %s, "
                "maybe does not exist, return %d, errcode %d", trustedPath, ret, mmGetErrorCode());
            return false;
        }
        if ((pathStat.st_mode & S_IFMT) != S_IFREG) {
            ACL_LOG_INNER_ERROR("[Config][ConfigFile]config file is not a common file, which path is %s, "
                "mode is %u", trustedPath, pathStat.st_mode);
            return false;
        }
        if (pathStat.st_size > MAX_CONFIG_FILE_BYTE) {
            ACL_LOG_INNER_ERROR("[Check][FileSize]config file %s size[%ld] is larger than "
                "max config file Bytes[%ld]", trustedPath, pathStat.st_size, MAX_CONFIG_FILE_BYTE);
            return false;
        }
        return true;
    }

    aclError JsonParser::ParseJson(const char_t *const configStr, nlohmann::json &js)
    {
        if (strlen(configStr) == 0UL) {
            ACL_LOG_DEBUG("buffer is empty, no need parse json.");
            return ACL_SUCCESS;
        }
        try {
            js = nlohmann::json::parse(std::string(configStr));
        } catch (const nlohmann::json::exception &e) {
            ACL_LOG_INNER_ERROR("[Check][JsonFile]invalid json buffer, exception:%s.", e.what());
            return ACL_ERROR_PARSE_FILE;
        }
        ACL_LOG_DEBUG("parse json from buffer successfully.");
        return ACL_SUCCESS;
    }

    aclError JsonParser::GetConfigStrFromFile(const char_t *const fileName, std::string &configStr)
    {
        if (fileName == nullptr) {
            ACL_LOG_DEBUG("filename is nullptr, no need to parse json");
            return ACL_SUCCESS;
        }
        ACL_LOG_DEBUG("before GetConfigStrFromFile in ParseJsonFromFile");
        if (!IsValidFileName(fileName)) {
            ACL_LOG_INNER_ERROR("[Check][File]invalid config file[%s]", fileName);
            return ACL_ERROR_INVALID_FILE;
        }
        std::ifstream fin(fileName, std::ios::binary);
        if (!fin.is_open()) {
            ACL_LOG_INNER_ERROR("[Read][File]read file %s failed cause it cannnot be read.", fileName);
            return ACL_ERROR_INVALID_FILE;
        }
        (void)fin.seekg(0, std::ios::end);
        const std::streampos fp = fin.tellg();
        if (static_cast<int32_t>(fp) == 0) {
            ACL_LOG_DEBUG("parse file is null");
            fin.close();
            return ACL_SUCCESS;
        }
        // checking the depth of file
        size_t maxObjDepth = 0U;
        size_t maxArrayDepth = 0U;
        GetMaxNestedLayers(fileName, static_cast<size_t>(fp), maxObjDepth, maxArrayDepth);
        if ((maxObjDepth > MAX_CONFIG_OBJ_DEPTH) || (maxArrayDepth > MAX_CONFIG_ARRAY_DEPTH)) {
            ACL_LOG_INNER_ERROR("[Check][MaxArrayDepth]invalid json file, the object's depth[%zu] is larger than %zu, "
                                "or the array's depth[%zu] is larger than %zu.",
                                maxObjDepth, MAX_CONFIG_OBJ_DEPTH, maxArrayDepth, MAX_CONFIG_ARRAY_DEPTH);
            fin.close();
            return ACL_ERROR_PARSE_FILE;
        }
        ACL_LOG_DEBUG("json file's obj's depth is %zu, array's depth is %zu", maxObjDepth, maxArrayDepth);
        std::stringstream buffer;
        fin.seekg(0, std::ios::beg);
        buffer << fin.rdbuf();
        configStr = buffer.str();
        fin.close();
        return ACL_SUCCESS;
    }

    aclError JsonParser::ParseJsonFromFile(const char_t *const fileName, nlohmann::json &js)
    {
        std::string configStr;
        auto ret = GetConfigStrFromFile(fileName, configStr);
        if (ret != ACL_SUCCESS) {
            ACL_LOG_INNER_ERROR("[Parse][File]Get Buffer from file[%s] failed.", fileName);
            return ret;
        }

        ret= ParseJson(configStr.c_str(), js);
        if (ret != ACL_SUCCESS) {
            ACL_LOG_INNER_ERROR("[Parse][File]parse config file[%s] to json failed.", fileName);
            return ACL_ERROR_PARSE_FILE;
        }

        ACL_LOG_DEBUG("parse json from file[%s] successfully.", fileName);
        return ACL_SUCCESS;
    }

    aclError JsonParser::GetJsonCtxByKey(const char_t *const fileName,
        std::string &strJsonCtx, const std::string &subStrKey, bool &found) {
        found = false;
        nlohmann::json js;
        aclError ret = acl::JsonParser::ParseJsonFromFile(fileName, js);
        if (ret != ACL_SUCCESS) {
            ACL_LOG_INNER_ERROR("parse json from file falied, errorCode = %d", ret);
            return ret;
        }
        const auto configIter = js.find(subStrKey);
        if (configIter != js.end()) {
            strJsonCtx = configIter->dump();
            found = true;
        }
        return ACL_SUCCESS;
    }

    aclError JsonParser::GetAttrConfigFromFile(
        const char_t *const fileName, std::map<aclCannAttr, CannInfo> &cannInfoMap)
    {
        nlohmann::json js;
        aclError ret = JsonParser::ParseJsonFromFile(fileName, js);
        if (ret != ACL_SUCCESS) {
            ACL_LOG_INNER_ERROR("parse swFeatureList.json from file[%s] failed, ret = %d", fileName, ret);
            return ret;
        }
        try {
            for (auto &item : cannInfoMap) {
                auto &cannInfo = item.second;
                const auto config = js.find(cannInfo.readableAttrName);
                if (config != js.end()) {
                    const auto runtimeIter = config->find(SW_CONFIG_RUNTIME);
                    if (runtimeIter != config->end()) {
                        ACL_REQUIRES_OK(CannInfoUtils::ParseVersionValue(
                            runtimeIter->get<std::string>(), &cannInfo.minimumRuntimeVersion));
                    }
                }
            }
        } catch (const nlohmann::json::exception &e) {
            ACL_LOG_INNER_ERROR("invalid config file [%s], exception: %s", fileName, e.what());
            return ACL_ERROR_INTERNAL_ERROR;
        }
        ACL_LOG_INFO("Finish parsing swFeatureList.json");
        return ACL_SUCCESS;
    }

    aclError JsonParser::GetDefaultDeviceIdFromFile(const char_t *const fileName, int32_t& devId)
    {
        ACL_LOG_DEBUG("start to execute GetDefaultDeviceIdFromFile.");
        nlohmann::json js;
        std::string enableFlagStr, defaultDeviceIdStr;
        aclError ret = acl::JsonParser::ParseJsonFromFile(fileName, js);
        if (ret != ACL_SUCCESS) {
            ACL_LOG_INNER_ERROR("[Parse][JsonFromFile]parse default config from file[%s] failed, errorCode = %d", fileName, ret);
            return ret;
        }

        try {
            if (!JsonParser::ContainKey(js, ACL_JSON_DEFAULT_DEVICE)) {
                ACL_LOG_WARN("no defaultDevice item!");
                return ACL_SUCCESS;
            }
            const nlohmann::json &jsDefaultDeviceConfig = JsonParser::GetCfgJsonByKey(js, ACL_JSON_DEFAULT_DEVICE);
            if (!JsonParser::ContainKey(jsDefaultDeviceConfig, ACL_JSON_DEFAULT_DEVICE_ID)) {
                ACL_LOG_WARN("no default_device in acl.json!");
                return ACL_SUCCESS;
            }

            defaultDeviceIdStr = JsonParser::GetCfgStrByKey(jsDefaultDeviceConfig, ACL_JSON_DEFAULT_DEVICE_ID);
        } catch (const nlohmann::json::exception &e) {
            ACL_LOG_INNER_ERROR("parse config file [%s], exception: %s", fileName, e.what());
            return ACL_ERROR_INTERNAL_ERROR;
        }

        std::regex reg("0|[1-9]\\d*");
        if (!std::regex_match(defaultDeviceIdStr, reg)) {
            ACL_LOG_ERROR("default_device %s in acl.json is neither zero nor positive integer.",
                           defaultDeviceIdStr.c_str());
            return ACL_ERROR_INVALID_PARAM;
        }
        devId = static_cast<int32_t>(std::strtol(defaultDeviceIdStr.c_str(), nullptr, DECIMAL));
        ACL_LOG_DEBUG("successfully parse defaultDevice, devId:%d", devId);
        return ACL_SUCCESS;
    }

    aclError JsonParser::GetEventModeFromFile(const char_t *const fileName, uint8_t &event_mode, bool &found)
    {
        nlohmann::json js;
        std::string eventModeStr;
        aclError ret = acl::JsonParser::ParseJsonFromFile(fileName, js);
        if (ret != ACL_SUCCESS) {
            ACL_LOG_INNER_ERROR("[Parse][JsonFromFile]parse json from file[%s] failed, errorCode = %d", fileName, ret);
            return ret;
        }
        const std::string ACL_GRAPH_CONFIG_NAME = "acl_graph";
        const std::string ACL_EVENT_MODE_CONFIG_NAME = "event_mode";

        if (!JsonParser::ContainKey(js, ACL_GRAPH_CONFIG_NAME)) {
            ACL_LOG_INFO("No acl_graph in json file!");
            return ACL_SUCCESS;
        }
        const nlohmann::json &jsAclGraphConfig = JsonParser::GetCfgJsonByKey(js, ACL_GRAPH_CONFIG_NAME);
        if (!JsonParser::ContainKey(jsAclGraphConfig, ACL_EVENT_MODE_CONFIG_NAME)) {
            ACL_LOG_INFO("No event_mode under acl_graph in json file!");
            return ACL_SUCCESS;
        }
        eventModeStr = JsonParser::GetCfgStrByKey(jsAclGraphConfig, ACL_EVENT_MODE_CONFIG_NAME);

        // 校验 event_mode 是否为合法整数，只允许 0 或 1
        std::regex reg("0|1");
        if (!std::regex_match(eventModeStr, reg)) {
            ACL_LOG_ERROR("event_mode value [%s] in json is not a valid integer.", eventModeStr.c_str());
            const char_t *argList[] = {"param", "value", "reason"};
            const char_t *argVal[] = {"event_mode", eventModeStr.c_str(), "only support [0,1]"};
            acl::AclErrorLogManager::ReportInputErrorWithChar(acl::INVALID_PARAM_MSG,
                argList, argVal, 3U);
            return ACL_ERROR_INVALID_PARAM;
        }

        event_mode = static_cast<uint8_t>(std::strtol(eventModeStr.c_str(), nullptr, DECIMAL));
        found = true;
        ACL_LOG_INFO("Successfully parse event_mode: %d, event_mode_str: %s", event_mode, eventModeStr.c_str());
        return ACL_SUCCESS;
    }

    aclError JsonParser::GetStackSizeByType(
        const char_t* const fileName, const std::string& typeName, size_t& outSize, bool& outExist)
    {
        ACL_LOG_DEBUG("start to execute GetStackSizeByType, typeName = %s.", typeName.c_str());
        outExist = false;
        outSize = 0U;
        nlohmann::json js;
        aclError ret = acl::JsonParser::ParseJsonFromFile(fileName, js);
        if (ret != ACL_SUCCESS) {
            ACL_LOG_ERROR(
                "[Parse][JsonFromFile]parse default config from file[%s] failed, errorCode = %d", fileName, ret);
            acl::AclErrorLogManager::ReportInputError(
                acl::INVALID_FILE_MSG, std::vector<const char*>({"path", "reason"}),
                std::vector<const char*>({fileName, "Parse config file failed"}));
            return ret;
        }

        try {
            // 检查 "StackSize" 键是否存在
            if (js.find("StackSize") == js.end()) {
                ACL_LOG_DEBUG("StackSize key not found in config file [%s]", fileName);
                outExist = false; // 明确设置 outExist 为 false
                return ACL_SUCCESS;
            }

            const nlohmann::json& stackSizeJs = js["StackSize"];
            if (stackSizeJs.find(typeName.c_str()) != stackSizeJs.end()) {
                size_t rawSize = stackSizeJs.at(typeName.c_str()).get<size_t>();
                outSize = rawSize;
                outExist = true;
                ACL_LOG_INFO("successfully parse %s, size is %zu", typeName.c_str(), outSize);
            }
        } catch (const nlohmann::json::exception& e) {
            ACL_LOG_ERROR("parse config file [%s], exception: %s", fileName, e.what());
            acl::AclErrorLogManager::ReportInputError(
                acl::INVALID_FILE_MSG, std::vector<const char*>({"path", "reason"}),
                std::vector<const char*>({fileName, ("Parse exception: " + std::string(e.what())).c_str()}));
            return ACL_ERROR_INTERNAL_ERROR;
        }

        ACL_LOG_DEBUG("successfully parse StackSize by type");
        return ACL_SUCCESS;
    }

    aclError JsonParser::GetPrintFifoSizeByType(
        const char_t* const fileName, const std::string& typeName, size_t& fifoSize, bool& found)
    {
        ACL_LOG_DEBUG("start to execute GetPrintFifoSizeByType, typeName = %s.", typeName.c_str());
        std::string fifoSizeStr;
        found = false;

        auto ret = acl::JsonParser::GetJsonCtxByKey(fileName, fifoSizeStr, typeName,  found);
        if (ret != ACL_SUCCESS) {
            ACL_LOG_INNER_ERROR("can not parse config from file[%s], config[%s], errorCode = %d", fileName, typeName.c_str(), ret);
            return ret;
        }
        if (!found) {
            return ACL_SUCCESS;
        }

        std::regex reg("[1-9]\\d*");
        if (!std::regex_match(fifoSizeStr, reg)) {
            ACL_LOG_ERROR("fifoSize %s in acl.json is not a positive integer.", fifoSizeStr.c_str());
            return ACL_ERROR_INVALID_PARAM;
        }

        fifoSize = static_cast<size_t>(std::strtol(fifoSizeStr.c_str(), nullptr, DECIMAL));
        ACL_LOG_DEBUG("successfully parse print fifo size by type");
        return ACL_SUCCESS;
    }
} // namespace acl
