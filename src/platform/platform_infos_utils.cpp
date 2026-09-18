/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "platform_infos_utils.h"
#include <cstring>
#include <fstream>
#include "platform_log.h"
#include "platform_infos_impl.h"
#include "platform_error_define.h"
#include "driver/ascend_hal_base.h"
#include "platform_plugin_manager.h"

namespace fe {
std::mutex plt_info_mutex;
std::mutex opt_info_mutex;

namespace {
bool BuildSocDeviceMap(std::map<std::string, uint32_t>& soc_device_map)
{
    constexpr uint32_t MAX_DEV_NUM = 64;
    uint32_t devices[MAX_DEV_NUM] = {0};
    drvError_t ret = PlatformPluginManager::GetInstance().DrvGetDevIDs(devices, MAX_DEV_NUM);
    if (ret != DRV_ERROR_NONE) {
        PF_LOGE("drvGetDevIDs failed, ret=%d.", ret);
        return false;
    }

    for (uint32_t i = 0; i < MAX_DEV_NUM; i++) {
        if (devices[i] == 0 && i != 0) {
            break;
        }
        char soc_version[64] = {0};
        ret = PlatformPluginManager::GetInstance().HalGetSocVersion(devices[i], soc_version, sizeof(soc_version));
        if (ret != DRV_ERROR_NONE) {
            PF_LOGW("halGetSocVersion failed for dev %u, ret=%d.", devices[i], ret);
            continue;
        }
        std::string soc_str(soc_version);
        if (!soc_str.empty()) {
            soc_device_map.emplace(make_pair(soc_str, devices[i]));
            PF_LOGD("Mapped soc[%s] to device[%u].", soc_version, devices[i]);
        }
    }
    return true;
}

using ContentInfoMap = std::map<std::string, std::map<std::string, std::string>>;
using EnrichFunc = void (*)(uint32_t dev_id, ContentInfoMap& content_info_map);

void EnrichAiCoreCnt(uint32_t dev_id, ContentInfoMap& content_info_map)
{
    int64_t val = 0;
    if (PlatformPluginManager::GetInstance().HalGetDeviceInfo(dev_id, MODULE_TYPE_AICORE, INFO_TYPE_CORE_NUM, &val) ==
        DRV_ERROR_NONE) {
        content_info_map["SoCInfo"]["ai_core_cnt"] = std::to_string(val);
        content_info_map["SoCInfo"]["cube_core_cnt"] = std::to_string(val);
    }
}

void EnrichVectorCoreCnt(uint32_t dev_id, ContentInfoMap& content_info_map)
{
    (void)dev_id;
    const auto soc_info_it = content_info_map.find("SoCInfo");
    if (soc_info_it == content_info_map.end()) {
        return;
    }
    const auto ratio_it = soc_info_it->second.find("vector_core_ratio");
    if (ratio_it == soc_info_it->second.end()) {
        return;
    }
    const auto ai_core_it = soc_info_it->second.find("ai_core_cnt");
    if (ai_core_it == soc_info_it->second.end()) {
        PF_LOGW(
            "ai_core_cnt is missing, skip computing vector_core_cnt from vector_core_ratio[%s].",
            ratio_it->second.c_str());
        return;
    }

    const std::string& ratio_str = ratio_it->second;
    try {
        const int64_t ai_core_cnt = std::stoll(ai_core_it->second);
        const size_t sep_pos = ratio_str.find(':');
        int64_t vec_part = 0;
        if (sep_pos == std::string::npos) {
            vec_part = std::stoll(ratio_str);
        } else {
            vec_part = std::stoll(ratio_str.substr(sep_pos + 1));
        }
        if (vec_part >= 0) {
            const int64_t vector_core_cnt = ai_core_cnt * vec_part;
            content_info_map["SoCInfo"]["vector_core_cnt"] = std::to_string(vector_core_cnt);
            PF_LOGI(
                "Parsed vector_core_ratio[%s], ai_core_cnt[%ld], vector_core_cnt[%ld].", ratio_str.c_str(),
                static_cast<long>(ai_core_cnt), static_cast<long>(vector_core_cnt));
        } else {
            PF_LOGW(
                "Invalid vector_core_ratio[%s], expect positive ratio, skip computing vector_core_cnt.",
                ratio_str.c_str());
        }
    } catch (const std::exception&) {
        PF_LOGW("Failed to parse vector_core_ratio[%s], skip computing vector_core_cnt.", ratio_str.c_str());
    }
}

void EnrichAiCpuCnt(uint32_t dev_id, ContentInfoMap& content_info_map)
{
    int64_t val = 0;
    if (PlatformPluginManager::GetInstance().HalGetDeviceInfo(dev_id, MODULE_TYPE_AICPU, INFO_TYPE_CORE_NUM, &val) ==
        DRV_ERROR_NONE) {
        content_info_map["SoCInfo"]["ai_cpu_cnt"] = std::to_string(val);
    }
}

const std::vector<EnrichFunc> kEnrichFuncList = {
    EnrichAiCoreCnt,
    EnrichVectorCoreCnt,
    EnrichAiCpuCnt,
};
} // namespace

PlatformInfosUtils::PlatformInfosUtils() {}

PlatformInfosUtils::~PlatformInfosUtils() {}

PlatformInfosUtils& PlatformInfosUtils::GetInstance()
{
    static PlatformInfosUtils platform_info_utils;
    return platform_info_utils;
}

void PlatformInfosUtils::Clone(PlatFormInfos& dest_platform_infos, const PlatFormInfos& platform_infos) const
{
    std::lock_guard<std::mutex> lock_guard(plt_info_mutex);
    PF_LOGD("Using platFormInfos Clone function.");
    if (&dest_platform_infos != &platform_infos) {
        dest_platform_infos.core_num_ = platform_infos.core_num_;
        if (platform_infos.platform_infos_impl_) {
            PF_MAKE_SHARED(
                dest_platform_infos.platform_infos_impl_ =
                    std::make_shared<PlatFormInfosImpl>(*platform_infos.platform_infos_impl_),
                return);
        }
    }
}

void PlatformInfosUtils::Trim(std::string& str)
{
    if (str.empty()) {
        return;
    }
    size_t start_pos = str.find_first_not_of(" \t");
    size_t end_pos = str.find_last_not_of(" \t");
    if (start_pos == std::string::npos || start_pos > end_pos) {
        str.clear();
        return;
    }
    str = str.substr(start_pos, end_pos - start_pos + 1);
}

void PlatformInfosUtils::Split(const std::string& str, char pattern, std::vector<std::string>& res_vec)
{
    if (str.empty()) {
        return;
    }

    std::string str_and_pattern = str + pattern;
    size_t pos = str_and_pattern.find(pattern);
    size_t size = str_and_pattern.size();
    while (pos != std::string::npos) {
        std::string sub_str = str_and_pattern.substr(0, pos);
        res_vec.push_back(sub_str);
        str_and_pattern = str_and_pattern.substr(pos + 1, size);
        pos = str_and_pattern.find(pattern);
    }
    return;
}

bool PlatformInfosUtils::FindCommonFile(
    const std::string& soc_version, const std::string& cfg_dir, std::string& common_path)
{
    for (const auto& prefix : kCommonFilePrefixes) {
        if (strncmp(soc_version.c_str(), prefix.c_str(), prefix.size()) == 0) {
            common_path = cfg_dir + "/" + prefix + "_common.ini";
            return true;
        }
    }
    return false;
}

bool PlatformInfosUtils::IsFileExist(const std::string& file_path)
{
    if (file_path.empty()) {
        return false;
    }
    std::ifstream ifs(file_path);
    return ifs.good();
}

bool PlatformInfosUtils::GetDeviceIdBySocVersion(const std::string& soc_version, uint32_t& dev_id)
{
    static std::mutex map_mutex;
    static std::map<std::string, uint32_t> soc_device_map;
    static bool map_ready = false;

    std::lock_guard<std::mutex> lock(map_mutex);
    if (!map_ready) {
        if (!BuildSocDeviceMap(soc_device_map)) {
            PF_LOGE("BuildSocDeviceMap failed for soc[%s].", soc_version.c_str());
            return false;
        }
        map_ready = true;
    }

    auto it = soc_device_map.find(soc_version);
    if (it == soc_device_map.end()) {
        PF_LOGE("No device_id mapping found for soc[%s].", soc_version.c_str());
        return false;
    }
    dev_id = it->second;
    return true;
}

uint32_t PlatformInfosUtils::LoadIniFileToSections(
    const std::string& ini_file_path, std::map<std::string, std::map<std::string, std::string>>& content_info_map)
{
    std::ifstream ifs(ini_file_path);
    if (!ifs.is_open()) {
        PF_LOGE("Failed to open conf file[%s], it does not exist or is already opened.", ini_file_path.c_str());
        return PLATFORM_FAILED;
    }

    std::map<std::string, std::string> content_map;
    content_info_map.clear();
    std::string line;
    std::string map_key;
    while (std::getline(ifs, line)) {
        if (line.empty() || line.find('#') == 0) {
            continue;
        }

        if (line.find('[') == 0) {
            if (!map_key.empty() && !content_map.empty()) {
                content_info_map.emplace(make_pair(map_key, content_map));
                content_map.clear();
            }
            size_t pos = line.rfind(']');
            if (pos == std::string::npos) {
                continue;
            }
            map_key = line.substr(1, pos - 1);
            Trim(map_key);
            continue;
        }

        size_t pos_of_equal = line.find('=');
        if (pos_of_equal == std::string::npos) {
            continue;
        }

        std::string key = line.substr(0, pos_of_equal);
        Trim(key);
        std::string value = line.substr(pos_of_equal + 1, line.length() - pos_of_equal - 1);
        Trim(value);
        if (!key.empty() && !value.empty()) {
            content_map.emplace(make_pair(key, value));
        }
    }

    if (!content_map.empty() && !map_key.empty()) {
        content_info_map.emplace(make_pair(map_key, content_map));
        content_map.clear();
    }

    ifs.close();
    return PLATFORM_SUCCESS;
}

uint32_t PlatformInfosUtils::EnrichSectionsByHAL(
    const std::string& soc_version, std::map<std::string, std::map<std::string, std::string>>& content_info_map)
{
    uint32_t dev_id = 0;
    if (!GetDeviceIdBySocVersion(soc_version, dev_id)) {
        PF_LOGE("Cannot get device_id for soc[%s], HAL enrichment aborted.", soc_version.c_str());
        return PLATFORM_FAILED;
    }

    for (const auto& enrich_func : kEnrichFuncList) {
        enrich_func(dev_id, content_info_map);
    }

    content_info_map["version"]["SoC_version"] = soc_version;
    return PLATFORM_SUCCESS;
}

std::string RealSoFilePath(const std::string& path)
{
    if (path.empty()) {
        PF_LOGE("Path string is NULL.");
        return "";
    }

    if (path.size() >= PATH_MAX) {
        PF_LOGE("File path '%s' is too long!", path.c_str());
        return "";
    }

    char resolved_path[PATH_MAX] = {0};
    std::string res = "";

    if (realpath(path.c_str(), resolved_path) != nullptr) {
        res = resolved_path;
    } else {
        PF_LOGE("Path '%s' does not exist.", path.c_str());
    }
    return res;
}
} // namespace fe
