/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "platform_manager_v2.h"
#include <dirent.h>
#include <string.h>
#include <algorithm>
#include <fstream>
#include <vector>
#include "platform_infos_utils.h"
#include "platform_error_define.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

const std::string FIXPIPE_CONFIG_KEY = "Intrinsic_fix_pipe_";
const std::string INI_FILE_SUFFIX = ".ini";

const std::string STR_AI_CORE_INTRINSIC_DTYPE_MAP = "AICoreintrinsicDtypeMap";
const std::string STR_VECTOR_CORE_INTRINSIC_DTYPE_MAP = "VectorCoreintrinsicDtypeMap";

const std::string SOC_VERSION_ASCEND910 = "Ascend910";
const std::string SOC_VERSION_ASCEND910A = "Ascend910A";

PlatformManagerV2& PlatformManagerV2::Instance()
{
    static PlatformManagerV2 platform_info;
    return platform_info;
}

uint32_t PlatformManagerV2::LoadIniFile(const std::string& ini_file_real_path)
{
    std::map<std::string, std::map<std::string, std::string>> content_info_map;
    if (fe::PlatformInfosUtils::LoadIniFileToSections(ini_file_real_path, content_info_map) != PLATFORM_SUCCESS) {
        return PLATFORM_FAILED;
    }

    if (AssemblePlatformInfoVector(content_info_map) != PLATFORM_SUCCESS) {
        PF_LOGE("Assemble platform info failed.");
        return PLATFORM_FAILED;
    }

    return PLATFORM_SUCCESS;
}

uint32_t PlatformManagerV2::AssemblePlatformInfoVector(
    std::map<std::string, std::map<std::string, std::string>>& content_info_map)
{
    fe::PlatFormInfos platform_infos;
    if (!platform_infos.Init()) {
        return PLATFORM_FAILED;
    }

    if (ParsePlatformInfo(content_info_map, platform_infos) != PLATFORM_SUCCESS) {
        PF_LOGE("Parse platform info from content failed.");
        return PLATFORM_FAILED;
    }
    FillupFixPipeInfo(platform_infos);

    std::string soc_version = "";
    (void)platform_infos.GetPlatformResWithLock("version", "SoC_version", soc_version);
    if (!soc_version.empty()) {
        auto iter = platform_infos_map_.find(soc_version);
        if (iter == platform_infos_map_.end()) {
            platform_infos_map_.emplace(soc_version, platform_infos);
            PF_LOGD("The platform info's os soc version[%s] has been initialized.", soc_version.c_str());
        }
    } else {
        PF_LOGE("Failed to initialize platform: %s.", platform_infos.SaveToBuffer().c_str());
        return PLATFORM_FAILED;
    }

    return PLATFORM_SUCCESS;
}

void PlatformManagerV2::FillupFixPipeInfo(fe::PlatFormInfos& platform_infos)
{
    std::string is_support_fixpipe_str;
    if (!platform_infos.GetPlatformResWithLock("AICoreSpec", "support_fixpipe", is_support_fixpipe_str) ||
        !static_cast<bool>(std::atoi(is_support_fixpipe_str.c_str()))) {
        return;
    }
    std::map<std::string, std::vector<std::string>> aicore_map = platform_infos.GetAICoreIntrinsicDtype();
    std::map<std::string, std::vector<std::string>> fixpipe_map;
    for (auto iter = aicore_map.begin(); iter != aicore_map.end(); iter++) {
        if (iter->first.find(FIXPIPE_CONFIG_KEY) != iter->first.npos) {
            fixpipe_map.emplace(make_pair(iter->first, iter->second));
        }
    }
    if (fixpipe_map.empty()) {
        return;
    }
    platform_infos.SetFixPipeDtypeMap(fixpipe_map);
}

void PlatformManagerV2::ParseAICoreintrinsicDtypeMap(
    std::map<std::string, std::string>& ai_coreintrinsic_dtype_map, fe::PlatFormInfos& platform_info_temp)
{
    std::map<std::string, std::string>::const_iterator iter;
    std::map<std::string, std::string> platform_res_map;
    std::map<std::string, std::vector<std::string>> aicore_intrinsic_dtypes =
        platform_info_temp.GetAICoreIntrinsicDtype();
    for (iter = ai_coreintrinsic_dtype_map.begin(); iter != ai_coreintrinsic_dtype_map.end(); iter++) {
        size_t pos = iter->second.find('|');
        if (pos == std::string::npos) {
            return;
        }
        std::string key = iter->second.substr(0, pos);
        std::string value = iter->second.substr(pos + 1);
        std::vector<std::string> dtype_vector;
        fe::PlatformInfosUtils::Split(value, ',', dtype_vector);
        platform_res_map.emplace(make_pair(key, value));
        aicore_intrinsic_dtypes.emplace(make_pair(key, dtype_vector));
    }

    platform_info_temp.SetPlatformRes(STR_AI_CORE_INTRINSIC_DTYPE_MAP, platform_res_map);
    platform_info_temp.SetAICoreIntrinsicDtype(aicore_intrinsic_dtypes);
}

void PlatformManagerV2::ParseVectorCoreintrinsicDtypeMap(
    std::map<std::string, std::string>& vector_coreintrinsic_dtype_map, fe::PlatFormInfos& platform_info_temp)
{
    std::map<std::string, std::string>::const_iterator iter;
    std::map<std::string, std::string> platform_res_map;
    std::map<std::string, std::vector<std::string>> vector_core_intrinsic_dtype_map =
        platform_info_temp.GetVectorCoreIntrinsicDtype();
    for (iter = vector_coreintrinsic_dtype_map.begin(); iter != vector_coreintrinsic_dtype_map.end(); iter++) {
        size_t pos = iter->second.find('|');
        if (pos == std::string::npos) {
            PF_LOGE("The intrinsic_dtype_map string does not contain '|'.");
            return;
        }
        std::string key = iter->second.substr(0, pos);
        std::string value = iter->second.substr(pos + 1);
        std::vector<std::string> dtype_vector;
        fe::PlatformInfosUtils::Split(value, ',', dtype_vector);
        platform_res_map.emplace(make_pair(key, value));
        vector_core_intrinsic_dtype_map.emplace(make_pair(key, dtype_vector));
    }

    platform_info_temp.SetPlatformRes(STR_VECTOR_CORE_INTRINSIC_DTYPE_MAP, platform_res_map);
    platform_info_temp.SetVectorCoreIntrinsicDtype(vector_core_intrinsic_dtype_map);
}

void PlatformManagerV2::ParsePlatformRes(
    const std::string& label, std::map<std::string, std::string>& platform_res_map,
    fe::PlatFormInfos& platform_info_temp)
{
    platform_info_temp.SetPlatformRes(label, platform_res_map);
}

uint32_t PlatformManagerV2::ParsePlatformInfo(
    std::map<std::string, std::map<std::string, std::string>>& content_info_map, fe::PlatFormInfos& platform_info_temp)
{
    std::map<std::string, std::map<std::string, std::string>>::iterator it;
    for (it = content_info_map.begin(); it != content_info_map.end(); it++) {
        if (it->first == STR_AI_CORE_INTRINSIC_DTYPE_MAP) {
            ParseAICoreintrinsicDtypeMap(it->second, platform_info_temp);
        } else if (it->first == STR_VECTOR_CORE_INTRINSIC_DTYPE_MAP) {
            ParseVectorCoreintrinsicDtypeMap(it->second, platform_info_temp);
        } else {
            ParsePlatformRes(it->first, it->second, platform_info_temp);
        }
    }

    return PLATFORM_SUCCESS;
}

uint32_t PlatformManagerV2::LoadCommonIniFileWithHAL(
    const std::string& soc_version, std::map<std::string, std::map<std::string, std::string>>& content_info_map)
{
    std::string common_path;
    if (!fe::PlatformInfosUtils::FindCommonFile(soc_version, cfg_file_real_path_, common_path)) {
        PF_LOGE("No common file found for soc[%s].", soc_version.c_str());
        return PLATFORM_FAILED;
    }
    PF_LOGI("Fallback to common file[%s] for soc[%s].", common_path.c_str(), soc_version.c_str());

    if (fe::PlatformInfosUtils::LoadIniFileToSections(common_path, content_info_map) != PLATFORM_SUCCESS) {
        PF_LOGE("Failed to load common ini[%s].", common_path.c_str());
        return PLATFORM_FAILED;
    }

    if (fe::PlatformInfosUtils::EnrichSectionsByHAL(soc_version, content_info_map) != PLATFORM_SUCCESS) {
        PF_LOGE("HAL enrichment failed for soc[%s].", soc_version.c_str());
        return PLATFORM_FAILED;
    }

    return PLATFORM_SUCCESS;
}

uint32_t PlatformManagerV2::InitPlatformInfos(const std::string& soc_version)
{
    if (cfg_file_real_path_.empty()) {
        cfg_file_real_path_ = fe::GetConfigFilePath<PlatformManagerV2>();
    }
    if (cfg_file_real_path_.empty()) {
        PF_LOGE("File path is not valid.");
        return PLATFORM_FAILED;
    }

    std::string ini_file_path = cfg_file_real_path_ + "/" + soc_version + INI_FILE_SUFFIX;
    if (fe::PlatformInfosUtils::IsFileExist(ini_file_path)) {
        PF_LOGD("Begin to load ini file[%s].", ini_file_path.c_str());
        if (LoadIniFile(ini_file_path) != PLATFORM_SUCCESS) {
            PF_LOGE("Failed to load exact ini[%s].", ini_file_path.c_str());
            return PLATFORM_FAILED;
        }
        return PLATFORM_SUCCESS;
    }

    PF_LOGI("Exact ini[%s] not found, trying common file fallback.", ini_file_path.c_str());
    std::map<std::string, std::map<std::string, std::string>> content_info_map;
    if (LoadCommonIniFileWithHAL(soc_version, content_info_map) != PLATFORM_SUCCESS) {
        PF_LOGE("Failed to load ini file for soc[%s].", soc_version.c_str());
        return PLATFORM_FAILED;
    }

    if (AssemblePlatformInfoVector(content_info_map) != PLATFORM_SUCCESS) {
        PF_LOGE("Assemble platform info failed for soc[%s].", soc_version.c_str());
        return PLATFORM_FAILED;
    }
    return PLATFORM_SUCCESS;
}

int32_t PlatformManagerV2::GetPlatformInfos(const std::string& soc_version, fe::PlatFormInfos& platform_info)
{
    std::string realSocVersion = soc_version;
    if (realSocVersion == SOC_VERSION_ASCEND910) {
        realSocVersion = SOC_VERSION_ASCEND910A;
    }

    std::lock_guard<std::mutex> lock_guard(soc_lock_);
    if (soc_file_status_.count(realSocVersion) == 0) {
        if (InitPlatformInfos(realSocVersion) != PLATFORM_SUCCESS) {
            return PLATFORM_ERROR_PARSE_FILE_FAILED;
        }
    }
    soc_file_status_[realSocVersion] = true;
    auto iter = platform_infos_map_.find(realSocVersion);
    if (iter == platform_infos_map_.end()) {
        PF_LOGE("Cannot find platform_info by SoCVersion %s.", realSocVersion.c_str());
        return PLATFORM_ERROR_NOT_FOUND;
    }
    platform_info = iter->second;
    return PLATFORM_SUCCESS;
}

int32_t PlatformManagerV2::GetSocSpec(
    const std::string& soc_version, const std::string& label, const std::string& key, std::string& value)
{
    PF_LOGD("Begin to get soc[%s] info: label[%s], key[%s].", soc_version.c_str(), label.c_str(), key.c_str());
    fe::PlatFormInfos platform_info;
    auto ret = GetPlatformInfos(soc_version, platform_info);
    if (ret != PLATFORM_SUCCESS) {
        return ret;
    }
    if (!platform_info.GetPlatformResWithLock(label, key, value)) {
        PF_LOGW("Failed to get platform info, label[%s], key[%s].", label.c_str(), key.c_str());
        return PLATFORM_ERROR_NOT_FOUND;
    }
    PF_LOGD("GetSocSpec label[%s], key[%s], value[%s].", label.c_str(), key.c_str(), value.c_str());
    return PLATFORM_SUCCESS;
}

#ifdef __cplusplus
}
#endif // __cplusplus
