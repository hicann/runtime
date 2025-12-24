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
#include <dlfcn.h>
#include <string.h>
#include <algorithm>
#include <climits>
#include <fstream>
#include "platform_log.h"
#include "platform_infos_utils.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

const std::string FIXPIPE_CONFIG_KEY = "Intrinsic_fix_pipe_";
const std::string PLATFORM_RELATIVE_PATH = "../data/platform_config";
const std::string INI_FILE_SUFFIX = ".ini";

const std::string STR_AI_CORE_INTRINSIC_DTYPE_MAP = "AICoreintrinsicDtypeMap";
const std::string STR_VECTOR_CORE_INTRINSIC_DTYPE_MAP = "VectorCoreintrinsicDtypeMap";

const std::string SOC_VERSION_ASCEND910 = "Ascend910";
const std::string SOC_VERSION_ASCEND910A = "Ascend910A";

const uint32_t PLATFORM_FAILED = 0xFFFFFFFF;
const uint32_t PLATFORM_SUCCESS = 0;

PlatformManagerV2 &PlatformManagerV2::Instance() {
  static PlatformManagerV2 platform_info;
  return platform_info;
}

uint32_t PlatformManagerV2::LoadIniFile(const std::string &ini_file_real_path) {
  std::ifstream ifs(ini_file_real_path);
  if (!ifs.is_open()) {
    PF_LOGE("Failed to open conf file, it does not exist or is already opened.");
    return PLATFORM_FAILED;
  }

  std::map<std::string, std::string> content_map;
  std::map<std::string, std::map<std::string, std::string>> content_info_map;
  content_map.clear();
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
      fe::PlatformInfosUtils::Trim(map_key);
      continue;
    }

    size_t pos_of_equal = line.find('=');
    if (pos_of_equal == std::string::npos) {
      continue;
    }

    std::string key = line.substr(0, pos_of_equal);
    fe::PlatformInfosUtils::Trim(key);
    std::string value = line.substr(pos_of_equal + 1, line.length() - pos_of_equal - 1);
    fe::PlatformInfosUtils::Trim(value);
    if (!key.empty() && !value.empty()) {
      content_map.emplace(make_pair(key, value));
    }
  }

  if (!content_map.empty() && !map_key.empty()) {
    content_info_map.emplace(make_pair(map_key, content_map));
    content_map.clear();
  }

  ifs.close();

  if (AssemblePlatformInfoVector(content_info_map) != PLATFORM_SUCCESS) {
    PF_LOGE("Assemble platform info failed.");
    return PLATFORM_FAILED;
  }

  return PLATFORM_SUCCESS;
}

uint32_t PlatformManagerV2::AssemblePlatformInfoVector(std::map<std::string, std::map<std::string, std::string>> &content_info_map) {
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

void PlatformManagerV2::FillupFixPipeInfo(fe::PlatFormInfos &platform_infos) {
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

void PlatformManagerV2::ParseAICoreintrinsicDtypeMap(std::map<std::string, std::string> &ai_coreintrinsic_dtype_map,
                                                    fe::PlatFormInfos &platform_info_temp) {
  std::map<std::string, std::string>::const_iterator iter;
  std::map<std::string, std::string> platform_res_map;
  std::map<std::string, std::vector<std::string>> aicore_intrinsic_dtypes = platform_info_temp.GetAICoreIntrinsicDtype();
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

void PlatformManagerV2::ParseVectorCoreintrinsicDtypeMap(std::map<std::string, std::string> &vector_coreintrinsic_dtype_map,
                                                        fe::PlatFormInfos &platform_info_temp) {
  std::map<std::string, std::string>::const_iterator iter;
  std::map<std::string, std::string> platform_res_map;
  std::map<std::string, std::vector<std::string>> vector_core_intrinsic_dtype_map = platform_info_temp.GetVectorCoreIntrinsicDtype();
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

void PlatformManagerV2::ParsePlatformRes(const std::string &label,
                                        std::map<std::string, std::string> &platform_res_map,
                                        fe::PlatFormInfos &platform_info_temp) {
  platform_info_temp.SetPlatformRes(label, platform_res_map);
}

uint32_t PlatformManagerV2::ParsePlatformInfo(std::map<std::string, std::map<std::string, std::string>> &content_info_map,
                                              fe::PlatFormInfos &platform_info_temp) {
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

std::string PlatformManagerV2::RealPath(const std::string &path) {
  if (path.empty()) {
    PF_LOGE("Path string is NULL.");
    return "";
  }

  if (path.size() >= PATH_MAX) {
    PF_LOGE("File path '%s' is too long!", path.c_str());
    return "";
  }

  char resoved_path[PATH_MAX] = {0};
  std::string res = "";

  if (realpath(path.c_str(), resoved_path) != nullptr) {
    res = resoved_path;
  } else {
    PF_LOGE("Path '%s' does not exist.", path.c_str());
  }
  return res;
}

std::string PlatformManagerV2::GetSoFilePath() {
  Dl_info dl_info;
  std::string real_file_path = "";
  PlatformManagerV2 &(*instance_ptr)() = &PlatformManagerV2::Instance;
  if (dladdr(reinterpret_cast<void *>(instance_ptr), &dl_info) == 0) {
    PF_LOGE("Failed to read the so file path.");
    return real_file_path;
  } else {
    std::string so_path = dl_info.dli_fname;
    if (so_path.empty()) {
      PF_LOGE("The so file path is empty.");
      return real_file_path;
    }
    real_file_path = RealPath(so_path);
    size_t pos = real_file_path.rfind('/');
    real_file_path = real_file_path.substr(0, pos + 1);
  }
  return real_file_path;
}

uint32_t PlatformManagerV2::InitPlatformInfos(const std::string &soc_version) {
  std::string cfg_file_real_path = RealPath(GetSoFilePath() + PLATFORM_RELATIVE_PATH);
  if (cfg_file_real_path.empty()) {
    PF_LOGE("File path[%s] is not valid.", cfg_file_real_path.c_str());
    return PLATFORM_FAILED;
  }

  std::string ini_file_path = cfg_file_real_path + "/" + soc_version + INI_FILE_SUFFIX;
  PF_LOGD("Begin to load ini file[%s].", ini_file_path.c_str());
  if (LoadIniFile(ini_file_path) != PLATFORM_SUCCESS) {
    PF_LOGE("Failed to load ini file[%s].", ini_file_path.c_str());
    return PLATFORM_FAILED;
  }
  return PLATFORM_SUCCESS;
}

uint32_t PlatformManagerV2::GetPlatformInfos(const std::string &soc_version, fe::PlatFormInfos &platform_info) {
  std::string realSocVersion = soc_version;
  if (realSocVersion == SOC_VERSION_ASCEND910) {
    realSocVersion = SOC_VERSION_ASCEND910A;
  }
  {
    std::lock_guard<std::mutex> lock_guard(soc_lock_);
    if (soc_file_status_.count(realSocVersion) == 0) {
      if (InitPlatformInfos(realSocVersion) != PLATFORM_SUCCESS) {
        return PLATFORM_FAILED;
      }
    }
    soc_file_status_[realSocVersion] = true;
  }
  auto iter = platform_infos_map_.find(realSocVersion);
  if (iter == platform_infos_map_.end()) {
    PF_LOGE("Cannot find platform_info by SoCVersion %s.", realSocVersion.c_str());
    return PLATFORM_FAILED;
  }
  platform_info = iter->second;
  return PLATFORM_SUCCESS;
}

uint32_t PlatformManagerV2::GetSocSpec(const std::string &soc_version,
                                       const std::string &label, const std::string &key, std::string &value) {
  PF_LOGD("Begin to get soc[%s] info: label[%s], key[%s]", soc_version.c_str(), label.c_str(), key.c_str());
  fe::PlatFormInfos platform_info;
  if (GetPlatformInfos(soc_version, platform_info) != PLATFORM_SUCCESS) {
    return PLATFORM_FAILED;
  }
  if (!platform_info.GetPlatformResWithLock(label, key, value)) {
    PF_LOGW("Failed to get platform info, lable[%s], key[%s]", label.c_str(), key.c_str());
    return PLATFORM_FAILED;
  }
  PF_LOGD("GetSocSpec lable[%s], key[%s], value[%s]", label.c_str(), key.c_str(), value.c_str());
  return PLATFORM_SUCCESS;
}

#ifdef __cplusplus
}
#endif // __cplusplus
