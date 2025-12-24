/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "platform/platform_info.h"
#include <dirent.h>
#include <dlfcn.h>
#include <string.h>
#include <unordered_set>
#include <algorithm>
#include <climits>
#include <fstream>
#include <mutex>
#include "platform_log.h"
#include "platform/platform_info_def.h"
#include "platform_infos_utils.h"

namespace fe {
namespace {
const std::string FIXPIPE_CONFIG_KEY = "Intrinsic_fix_pipe_";
const std::string PLATFORM_RELATIVE_PATH = "../data/platform_config";
const std::string INI_FILE_SUFFIX = "ini";
const std::string STR_SOC_VERSION = "SoC_version";
const std::string STR_AIC_VERSION = "AIC_version";
const std::string SHORT_SOC_VERSION = "Short_SoC_version";
const std::string STR_CCEC_AIC_VERSION = "CCEC_AIC_version";
const std::string STR_CCEC_AIV_VERSION = "CCEC_AIV_version";
const std::string STR_IS_SUPPORT_AICPU = "Compiler_aicpu_support_os";
const std::string STR_VERSION = "version";
const std::string STR_SOC_INFO = "SoCInfo";
const std::string STR_AI_CORE_SPEC = "AICoreSpec";
const std::string STR_AI_CORE_MEMORY_RATES = "AICoreMemoryRates";
const std::string STR_CPU_CACHE = "CPUCache";
const std::string STR_SOFTWARE_SPEC = "SoftwareSpec";

const std::string STR_AI_CORE_INTRINSIC_DTYPE_MAP = "AICoreintrinsicDtypeMap";
const std::string STR_VECTOR_CORE_SPEC = "VectorCoreSpec";
const std::string STR_VECTOR_CORE_MEMORY_RATES = "VectorCoreMemoryRates";
const std::string STR_VECTOR_CORE_INTRINSIC_DTYPE_MAP = "VectorCoreintrinsicDtypeMap";

const std::string SOC_VERSION_ASCEND910 = "Ascend910";
const std::string SOC_VERSION_ASCEND910A = "Ascend910A";

const uint32_t PLATFORM_FAILED = 0xFFFFFFFF;
const uint32_t PLATFORM_SUCCESS = 0;

enum class PlatformInfoType {
    EN_VERSION = 0,
    EN_SOC_INFO,
    EN_AI_CORE_SPEC,
    EN_AI_CORE_MEMORY_RATES,
    EN_CPU_CACHE,
    EN_AI_CORE_INTRINSIC_DTYPE_MAP,
    EN_VECTOR_CORE_SPEC,
    EN_VECTOR_CORE_MEMORY_RATES,
    EN_VECTOR_CORE_INTRINSIC_DTYPE_MAP,
    EN_SOFTWARE_SPEC,
};

std::map<std::string, PlatformInfoType> g_platform_info_type_map{{STR_VERSION, PlatformInfoType::EN_VERSION},
    {STR_SOC_INFO, PlatformInfoType::EN_SOC_INFO},
    {STR_AI_CORE_SPEC, PlatformInfoType::EN_AI_CORE_SPEC},
    {STR_AI_CORE_MEMORY_RATES, PlatformInfoType::EN_AI_CORE_MEMORY_RATES},
    {STR_CPU_CACHE, PlatformInfoType::EN_CPU_CACHE},
    {STR_AI_CORE_INTRINSIC_DTYPE_MAP, PlatformInfoType::EN_AI_CORE_INTRINSIC_DTYPE_MAP},
    {STR_VECTOR_CORE_SPEC, PlatformInfoType::EN_VECTOR_CORE_SPEC},
    {STR_VECTOR_CORE_MEMORY_RATES, PlatformInfoType::EN_VECTOR_CORE_MEMORY_RATES},
    {STR_VECTOR_CORE_INTRINSIC_DTYPE_MAP, PlatformInfoType::EN_VECTOR_CORE_INTRINSIC_DTYPE_MAP},
    {STR_SOFTWARE_SPEC, PlatformInfoType::EN_SOFTWARE_SPEC}};
}  // namespace

#define CONVERT(name) #name

std::mutex pc_lock_;

PlatformInfoManager::PlatformInfoManager() : init_flag_(false), runtime_init_flag_(false), opti_compilation_info_()
{}

PlatformInfoManager::~PlatformInfoManager()
{}

PlatformInfoManager &PlatformInfoManager::Instance() {
  static PlatformInfoManager platform_info;
  return platform_info;
}

PlatformInfoManager &PlatformInfoManager::GeInstance() {
  static PlatformInfoManager ge_platform_info;
  return ge_platform_info;
}

void PlatformInfoManager::Trim(std::string &str) {
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

uint32_t PlatformInfoManager::LoadIniFile(std::string ini_file_real_path) {
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

  if (AssemblePlatformInfoVector(content_info_map) != PLATFORM_SUCCESS) {
    PF_LOGE("Assemble platform info failed.");
    return PLATFORM_FAILED;
  }

  return PLATFORM_SUCCESS;
}

uint32_t PlatformInfoManager::LoadConfigFile(std::string real_path) {
  std::vector<std::string> ini_cfg_files;
  DIR *dir;
  struct dirent *dirp = nullptr;
  char *file_suffix = const_cast<char *>(".ini");
  dir = opendir(real_path.c_str());
  if (dir == nullptr) {
    PF_LOGE("Failed to open directory %s.", real_path.c_str());
    return PLATFORM_FAILED;
  }

  while ((dirp = readdir(dir)) != nullptr) {
    if (dirp->d_name[0] == '.') {
      continue;
    }
    std::string file_name = dirp->d_name;
    if (strlen(dirp->d_name) <= strlen(file_suffix)) {
      continue;
    }
    size_t pos = file_name.rfind('.');
    if (pos == std::string::npos) {
      continue;
    }
    if (file_name.substr(pos + 1) != INI_FILE_SUFFIX) {
      continue;
    }
    if (strcmp(&(dirp->d_name)[strlen(dirp->d_name) - strlen(file_suffix)], file_suffix) == 0) {
      ini_cfg_files.push_back(real_path + "/" + dirp->d_name);
    }
  }
  closedir(dir);

  if (ini_cfg_files.empty()) {
    PF_LOGE("There is no ini file in path %s.", real_path.c_str());
    return PLATFORM_FAILED;
  }

  for (std::string ini_file_path : ini_cfg_files) {
    if (LoadIniFile(ini_file_path) != PLATFORM_SUCCESS) {
      PF_LOGE("Failed to load ini file[%s].", ini_file_path.c_str());
      return PLATFORM_FAILED;
    }
  }
  return PLATFORM_SUCCESS;
}

void PlatformInfoManager::ParseVersion(std::map<std::string, std::string> &version_map, std::string &soc_version,
                                       PlatformInfo &platform_info_temp) {
  std::map<std::string, std::string>::const_iterator soc = version_map.find(STR_SOC_VERSION);
  if (soc != version_map.end()) {
    soc_version = soc->second;
  }

  std::map<std::string, std::string>::const_iterator aic_version = version_map.find(STR_AIC_VERSION);
  if (aic_version != version_map.end()) {
    platform_info_temp.str_info.aic_version = aic_version->second;
  }

  std::map<std::string, std::string>::const_iterator ccec_aic_version = version_map.find(STR_CCEC_AIC_VERSION);
  if (ccec_aic_version != version_map.end()) {
    platform_info_temp.str_info.ccec_aic_version = ccec_aic_version->second;
  }

  std::map<std::string, std::string>::const_iterator ccec_aiv_version = version_map.find(STR_CCEC_AIV_VERSION);
  if (ccec_aiv_version != version_map.end()) {
    platform_info_temp.str_info.ccec_aiv_version = ccec_aiv_version->second;
  }

  std::map<std::string, std::string>::const_iterator is_support_a_icpu = version_map.find(STR_IS_SUPPORT_AICPU);
  if (is_support_a_icpu != version_map.end()) {
    platform_info_temp.str_info.is_support_ai_cpu_compiler = is_support_a_icpu->second;
  }

  std::map<std::string, std::string>::const_iterator short_soc_version = version_map.find(SHORT_SOC_VERSION);
  if (short_soc_version != version_map.end()) {
    platform_info_temp.str_info.short_soc_version = short_soc_version->second;
  }

  try {
    std::map<std::string, std::string>::const_iterator arch_type = version_map.find(CONVERT(Arch_type));
    if (arch_type != version_map.end()) {
      platform_info_temp.soc_info.arch_type = stoi(arch_type->second);
    }
    
    std::map<std::string, std::string>::const_iterator chip_type = version_map.find(CONVERT(Chip_type));
    if (chip_type != version_map.end()) {
      platform_info_temp.soc_info.chip_type = stoi(chip_type->second);
    }
  } catch (...) {
    PF_LOGE("Failed to parse version");
  }
  return;
}

void PlatformInfoManager::ParseSocInfo(std::map<std::string, std::string> &soc_info_map, PlatformInfo &platform_info_temp) {
  try {
    std::map<std::string, std::string>::const_iterator ai_core_cnt = soc_info_map.find(CONVERT(ai_core_cnt));
    if (ai_core_cnt != soc_info_map.end()) {
      platform_info_temp.soc_info.ai_core_cnt = static_cast<uint32_t>(stoi(ai_core_cnt->second));
    }

    std::map<std::string, std::string>::const_iterator vector_core_cnt = soc_info_map.find(CONVERT(vector_core_cnt));
    if (vector_core_cnt != soc_info_map.end()) {
      platform_info_temp.soc_info.vector_core_cnt = static_cast<uint32_t>(stoi(vector_core_cnt->second));
    }

    std::map<std::string, std::string>::const_iterator ai_cpu_cnt = soc_info_map.find(CONVERT(ai_cpu_cnt));
    if (ai_cpu_cnt != soc_info_map.end()) {
      platform_info_temp.soc_info.ai_cpu_cnt = static_cast<uint32_t>(stoi(ai_cpu_cnt->second));
    }

    std::map<std::string, std::string>::const_iterator memory_type = soc_info_map.find(CONVERT(memory_type));
    if (memory_type != soc_info_map.end()) {
      platform_info_temp.soc_info.memory_type = static_cast<MemoryType>(stoi(memory_type->second));
    }

    std::map<std::string, std::string>::const_iterator memory_size = soc_info_map.find(CONVERT(memory_size));
    if (memory_size != soc_info_map.end()) {
      platform_info_temp.soc_info.memory_size = static_cast<uint64_t>(stoll(memory_size->second));
    }

    std::map<std::string, std::string>::const_iterator l2_type = soc_info_map.find(CONVERT(l2_type));
    if (l2_type != soc_info_map.end()) {
      platform_info_temp.soc_info.l2_type = static_cast<L2Type>(stoi(l2_type->second));
    }

    std::map<std::string, std::string>::const_iterator l2_size = soc_info_map.find(CONVERT(l2_size));
    if (l2_size != soc_info_map.end()) {
      platform_info_temp.soc_info.l2_size = static_cast<uint64_t>(stoll(l2_size->second));
    }

    std::map<std::string, std::string>::const_iterator l2PageNum = soc_info_map.find(CONVERT(l2PageNum));
    if (l2PageNum != soc_info_map.end()) {
      platform_info_temp.soc_info.l2PageNum = static_cast<uint32_t>(stoi(l2PageNum->second));
    }
    std::map<std::string, std::string>::const_iterator task_num = soc_info_map.find(CONVERT(task_num));
    if (task_num != soc_info_map.end()) {
      platform_info_temp.soc_info.task_num = static_cast<uint32_t>(stoi(task_num->second));
    }
  } catch (...) {
    PF_LOGE("Failed to load SocInfo");
  }
}

void PlatformInfoManager::ParseCubeOfAICoreSpec(std::map<std::string, std::string> &ai_core_spec_map, PlatformInfo &platform_info_temp) {
  try {
    std::map<std::string, std::string>::const_iterator cube_freq = ai_core_spec_map.find(CONVERT(cube_freq));
    if (cube_freq != ai_core_spec_map.end()) {
      platform_info_temp.ai_core_spec.cube_freq = static_cast<double>(stod(cube_freq->second));
    }

    std::map<std::string, std::string>::const_iterator cube_m_size = ai_core_spec_map.find(CONVERT(cube_m_size));
    if (cube_m_size != ai_core_spec_map.end()) {
      platform_info_temp.ai_core_spec.cube_m_size = static_cast<uint64_t>(stoll(cube_m_size->second));
    }

    std::map<std::string, std::string>::const_iterator cube_n_size = ai_core_spec_map.find(CONVERT(cube_n_size));
    if (cube_n_size != ai_core_spec_map.end()) {
      platform_info_temp.ai_core_spec.cube_n_size = static_cast<uint64_t>(stoll(cube_n_size->second));
    }

    std::map<std::string, std::string>::const_iterator cube_k_size = ai_core_spec_map.find(CONVERT(cube_k_size));
    if (cube_k_size != ai_core_spec_map.end()) {
      platform_info_temp.ai_core_spec.cube_k_size = static_cast<uint64_t>(stoll(cube_k_size->second));
    }

    std::map<std::string, std::string>::const_iterator vec_calc_size = ai_core_spec_map.find(CONVERT(vec_calc_size));
    if (vec_calc_size != ai_core_spec_map.end()) {
      platform_info_temp.ai_core_spec.vec_calc_size = static_cast<uint64_t>(stoll(vec_calc_size->second));
    }

    platform_info_temp.ai_core_spec.sparsity = 0;
    std::map<std::string, std::string>::const_iterator sparse_matrix = ai_core_spec_map.find(CONVERT(sparsity));
    if (sparse_matrix != ai_core_spec_map.end()) {
      platform_info_temp.ai_core_spec.sparsity = static_cast<uint8_t>(stoll(sparse_matrix->second));
    }
  } catch (...) {
    PF_LOGE("Failed to load AICoreSpecs.");
  }
}

void PlatformInfoManager::ParseBufferOfAICoreSpec(std::map<std::string, std::string> &ai_core_spec_map,
                                                  PlatformInfo &platform_info_temp) {
  try {
    std::map<std::string, std::string>::const_iterator l0_a_size = ai_core_spec_map.find(CONVERT(l0_a_size));
    if (l0_a_size != ai_core_spec_map.end()) {
      platform_info_temp.ai_core_spec.l0_a_size = static_cast<uint64_t>(stoll(l0_a_size->second));
    }

    std::map<std::string, std::string>::const_iterator l0_b_size = ai_core_spec_map.find(CONVERT(l0_b_size));
    if (l0_b_size != ai_core_spec_map.end()) {
      platform_info_temp.ai_core_spec.l0_b_size = static_cast<uint64_t>(stoll(l0_b_size->second));
    }

    std::map<std::string, std::string>::const_iterator l0_c_size = ai_core_spec_map.find(CONVERT(l0_c_size));
    if (l0_c_size != ai_core_spec_map.end()) {
      platform_info_temp.ai_core_spec.l0_c_size = static_cast<uint64_t>(stoll(l0_c_size->second));
    }

    std::map<std::string, std::string>::const_iterator l1_size = ai_core_spec_map.find(CONVERT(l1_size));
    if (l1_size != ai_core_spec_map.end()) {
      platform_info_temp.ai_core_spec.l1_size = static_cast<uint64_t>(stoll(l1_size->second));
    }

    std::map<std::string, std::string>::const_iterator smask_buffer = ai_core_spec_map.find(CONVERT(smask_buffer));
    if (smask_buffer != ai_core_spec_map.end()) {
      platform_info_temp.ai_core_spec.smask_buffer = static_cast<uint64_t>(stoll(smask_buffer->second));
    }
  } catch (...) {
    PF_LOGE("Failed to load AICoreSpecs.");
  }
}

void PlatformInfoManager::ParseUBOfAICoreSpec(std::map<std::string, std::string> &ai_core_spec_map,
                                              PlatformInfo &platform_info_temp) {
  try {
    std::map<std::string, std::string>::const_iterator ub_size = ai_core_spec_map.find(CONVERT(ub_size));
    if (ub_size != ai_core_spec_map.end()) {
      platform_info_temp.ai_core_spec.ub_size = static_cast<uint64_t>(stoll(ub_size->second));
    }

    std::map<std::string, std::string>::const_iterator ubblock_size = ai_core_spec_map.find(CONVERT(ubblock_size));
    if (ubblock_size != ai_core_spec_map.end()) {
      platform_info_temp.ai_core_spec.ubblock_size = static_cast<uint64_t>(stoll(ubblock_size->second));
    }

    std::map<std::string, std::string>::const_iterator ubbank_size = ai_core_spec_map.find(CONVERT(ubbank_size));
    if (ubbank_size != ai_core_spec_map.end()) {
      platform_info_temp.ai_core_spec.ubbank_size = static_cast<uint64_t>(stoll(ubbank_size->second));
    }

    std::map<std::string, std::string>::const_iterator ubbank_num = ai_core_spec_map.find(CONVERT(ubbank_num));
    if (ubbank_num != ai_core_spec_map.end()) {
      platform_info_temp.ai_core_spec.ubbank_num = static_cast<uint64_t>(stoll(ubbank_num->second));
    }

    std::map<std::string, std::string>::const_iterator ubburst_in_one_block = ai_core_spec_map.find(CONVERT(ubburst_in_one_block));
    if (ubburst_in_one_block != ai_core_spec_map.end()) {
      platform_info_temp.ai_core_spec.ubburst_in_one_block = static_cast<uint64_t>(stoll(ubburst_in_one_block->second));
    }

    std::map<std::string, std::string>::const_iterator ubbank_group_num = ai_core_spec_map.find(CONVERT(ubbank_group_num));
    if (ubbank_group_num != ai_core_spec_map.end()) {
      platform_info_temp.ai_core_spec.ubbank_group_num = static_cast<uint64_t>(stoll(ubbank_group_num->second));
    }
  } catch (...) {
    PF_LOGE("Failed to load AICoreSpecs.");
  }
}

void PlatformInfoManager::ParseUnzipOfAICoreSpec(std::map<std::string, std::string> &ai_core_spec_map, PlatformInfo &platform_info_temp) {
  try {
    std::map<std::string, std::string>::const_iterator unzip_engines = ai_core_spec_map.find(CONVERT(unzip_engines));
    if (unzip_engines != ai_core_spec_map.end()) {
      platform_info_temp.ai_core_spec.unzip_engines = static_cast<uint32_t>(stoll(unzip_engines->second));
    }

    std::map<std::string, std::string>::const_iterator unzip_max_ratios = ai_core_spec_map.find(CONVERT(unzip_max_ratios));
    if (unzip_max_ratios != ai_core_spec_map.end()) {
      platform_info_temp.ai_core_spec.unzip_max_ratios = static_cast<uint32_t>(stoll(unzip_max_ratios->second));
    }

    std::map<std::string, std::string>::const_iterator unzip_channels = ai_core_spec_map.find(CONVERT(unzip_channels));
    if (unzip_channels != ai_core_spec_map.end()) {
      platform_info_temp.ai_core_spec.unzip_channels = static_cast<uint32_t>(stoll(unzip_channels->second));
    }

    std::map<std::string, std::string>::const_iterator unzip_is_tight = ai_core_spec_map.find(CONVERT(unzip_is_tight));
    if (unzip_is_tight != ai_core_spec_map.end()) {
      platform_info_temp.ai_core_spec.unzip_is_tight = static_cast<uint8_t>(stoll(unzip_is_tight->second));
    }
  } catch (...) {
    PF_LOGE("Failed to load AICoreSpecs.");
  }
}

void PlatformInfoManager::ParseAICoreSpec(std::map<std::string, std::string> &ai_core_spec_map, PlatformInfo &platform_info_temp) {
  (void)ParseCubeOfAICoreSpec(ai_core_spec_map, platform_info_temp);
  (void)ParseBufferOfAICoreSpec(ai_core_spec_map, platform_info_temp);
  (void)ParseUBOfAICoreSpec(ai_core_spec_map, platform_info_temp);
  (void)ParseUnzipOfAICoreSpec(ai_core_spec_map, platform_info_temp);

  return;
}

static double CalculateFraction(std::string fraction) {
  size_t pos = fraction.find('/');
  try {
    if (pos == std::string::npos) {
      return static_cast<double>(stod(fraction));
    }

    double numerator = static_cast<double>(stod(fraction.substr(0, pos - 1)));
    double denominator = static_cast<double>(stod(fraction.substr(pos + 1)));
    return (numerator / denominator);
  } catch (...) {
    return 0;
  }
}

void PlatformInfoManager::ParseBufferOfAICoreMemoryRates(std::map<std::string, std::string> &ai_core_memory_rates_map,
                                                         PlatformInfo &platform_info_temp) {
  try {
    std::map<std::string, std::string>::const_iterator ddr_rate = ai_core_memory_rates_map.find(CONVERT(ddr_rate));
    if (ddr_rate != ai_core_memory_rates_map.end()) {
      platform_info_temp.ai_core_memory_rates.ddr_rate = static_cast<double>(stod(ddr_rate->second));
    }

    std::map<std::string, std::string>::const_iterator ddr_read_rate = ai_core_memory_rates_map.find(CONVERT(ddr_read_rate));
    if (ddr_read_rate != ai_core_memory_rates_map.end()) {
      platform_info_temp.ai_core_memory_rates.ddr_read_rate = static_cast<double>(stod(ddr_read_rate->second));
    }

    std::map<std::string, std::string>::const_iterator ddr_write_rate = ai_core_memory_rates_map.find(CONVERT(ddr_write_rate));
    if (ddr_write_rate != ai_core_memory_rates_map.end()) {
      platform_info_temp.ai_core_memory_rates.ddr_write_rate = static_cast<double>(stod(ddr_write_rate->second));
    }

    std::map<std::string, std::string>::const_iterator l2_rate = ai_core_memory_rates_map.find(CONVERT(l2_rate));
    if (l2_rate != ai_core_memory_rates_map.end()) {
      platform_info_temp.ai_core_memory_rates.l2_rate = static_cast<double>(stod(l2_rate->second));
    }

    std::map<std::string, std::string>::const_iterator l2_read_rate = ai_core_memory_rates_map.find(CONVERT(l2_read_rate));
    if (l2_read_rate != ai_core_memory_rates_map.end()) {
      platform_info_temp.ai_core_memory_rates.l2_read_rate = static_cast<double>(stod(l2_read_rate->second));
    }

    std::map<std::string, std::string>::const_iterator l2_write_rate = ai_core_memory_rates_map.find(CONVERT(l2_write_rate));
    if (l2_write_rate != ai_core_memory_rates_map.end()) {
      platform_info_temp.ai_core_memory_rates.l2_write_rate = static_cast<double>(stod(l2_write_rate->second));
    }

    std::map<std::string, std::string>::const_iterator l1_to_l0_a_rate = ai_core_memory_rates_map.find(CONVERT(l1_to_l0_a_rate));
    if (l1_to_l0_a_rate != ai_core_memory_rates_map.end()) {
      platform_info_temp.ai_core_memory_rates.l1_to_l0_a_rate = static_cast<double>(stod(l1_to_l0_a_rate->second));
    }

    std::map<std::string, std::string>::const_iterator l1_to_l0_b_rate = ai_core_memory_rates_map.find(CONVERT(l1_to_l0_b_rate));
    if (l1_to_l0_b_rate != ai_core_memory_rates_map.end()) {
      platform_info_temp.ai_core_memory_rates.l1_to_l0_b_rate = static_cast<double>(stod(l1_to_l0_b_rate->second));
    }

    std::map<std::string, std::string>::const_iterator l1_to_ub_rate = ai_core_memory_rates_map.find(CONVERT(l1_to_ub_rate));
    if (l1_to_ub_rate != ai_core_memory_rates_map.end()) {
      platform_info_temp.ai_core_memory_rates.l1_to_ub_rate = static_cast<double>(stod(l1_to_ub_rate->second));
    }

    std::map<std::string, std::string>::const_iterator l0_c_to_ub_rate = ai_core_memory_rates_map.find(CONVERT(l0_c_to_ub_rate));
    if (l0_c_to_ub_rate != ai_core_memory_rates_map.end()) {
      platform_info_temp.ai_core_memory_rates.l0_c_to_ub_rate = static_cast<double>(stod(l0_c_to_ub_rate->second));
    }
  } catch (...) {
    PF_LOGE("Failed to load AICoreMemoryRates.");
  }
}

void PlatformInfoManager::ParseUBOfAICoreMemoryRates(std::map<std::string, std::string> &ai_core_memory_rates_map,
                                                     PlatformInfo &platform_info_temp) {
  std::map<std::string, std::string>::const_iterator ub_to_l2_rate = ai_core_memory_rates_map.find(CONVERT(ub_to_l2_rate));
  if (ub_to_l2_rate != ai_core_memory_rates_map.end()) {
    platform_info_temp.ai_core_memory_rates.ub_to_l2_rate = CalculateFraction(ub_to_l2_rate->second);
  }

  std::map<std::string, std::string>::const_iterator ub_to_ddr_rate = ai_core_memory_rates_map.find(CONVERT(ub_to_ddr_rate));
  if (ub_to_ddr_rate != ai_core_memory_rates_map.end()) {
    platform_info_temp.ai_core_memory_rates.ub_to_ddr_rate = CalculateFraction(ub_to_ddr_rate->second);
  }

  std::map<std::string, std::string>::const_iterator ub_to_l1_rate = ai_core_memory_rates_map.find(CONVERT(ub_to_l1_rate));
  if (ub_to_l1_rate != ai_core_memory_rates_map.end()) {
    try {
      platform_info_temp.ai_core_memory_rates.ub_to_l1_rate = static_cast<double>(stod(ub_to_l1_rate->second));
    } catch (...) {
      PF_LOGE("Failed to load ub_to_l1_rate [%s].", ub_to_l1_rate->second.c_str());
    }
  }
}

void PlatformInfoManager::ParseAICoreMemoryRates(std::map<std::string, std::string> &ai_core_memory_rates_map,
                                                 PlatformInfo &platform_info_temp) {
  (void)ParseBufferOfAICoreMemoryRates(ai_core_memory_rates_map, platform_info_temp);
  (void)ParseUBOfAICoreMemoryRates(ai_core_memory_rates_map, platform_info_temp);
}

static std::vector<std::string> Split(const std::string &str, char pattern) {
  std::vector<std::string> res_vec;
  if (str.empty()) {
    return res_vec;
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
  return res_vec;
}

void PlatformInfoManager::ParseAICoreintrinsicDtypeMap(std::map<std::string, std::string> &ai_coreintrinsic_dtype_map,
                                                       PlatformInfo &platform_info_temp) {
  std::map<std::string, std::string>::const_iterator iter;
  for (iter = ai_coreintrinsic_dtype_map.begin(); iter != ai_coreintrinsic_dtype_map.end(); iter++) {
    size_t pos = iter->second.find('|');
    if (pos == std::string::npos) {
      return;
    }
    std::string key = iter->second.substr(0, pos);
    std::string value = iter->second.substr(pos + 1);
    std::vector<std::string> dtype_vector = Split(value, ',');
    platform_info_temp.ai_core_intrinsic_dtype_map.emplace(make_pair(key, dtype_vector));
  }

  return;
}

void PlatformInfoManager::ParseVectorCoreSpec(std::map<std::string, std::string> &vector_core_spec_map,
                                              PlatformInfo &platform_info_temp) {
  try {
    std::map<std::string, std::string>::const_iterator vec_freq = vector_core_spec_map.find(CONVERT(vec_freq));
    if (vec_freq != vector_core_spec_map.end()) {
      platform_info_temp.vector_core_spec.vec_freq = static_cast<double>(stod(vec_freq->second));
    }

    std::map<std::string, std::string>::const_iterator vec_calc_size = vector_core_spec_map.find(CONVERT(vec_calc_size));
    if (vec_calc_size != vector_core_spec_map.end()) {
      platform_info_temp.vector_core_spec.vec_calc_size = static_cast<uint64_t>(stoll(vec_calc_size->second));
    }

    std::map<std::string, std::string>::const_iterator smask_buffer = vector_core_spec_map.find(CONVERT(smask_buffer));
    if (smask_buffer != vector_core_spec_map.end()) {
      platform_info_temp.vector_core_spec.smask_buffer = static_cast<uint64_t>(stoll(smask_buffer->second));
    }

    std::map<std::string, std::string>::const_iterator ub_size = vector_core_spec_map.find(CONVERT(ub_size));
    if (ub_size != vector_core_spec_map.end()) {
      platform_info_temp.vector_core_spec.ub_size = static_cast<uint64_t>(stoll(ub_size->second));
    }

    std::map<std::string, std::string>::const_iterator ubblock_size = vector_core_spec_map.find(CONVERT(ubblock_size));
    if (ubblock_size != vector_core_spec_map.end()) {
      platform_info_temp.vector_core_spec.ubblock_size = static_cast<uint64_t>(stoll(ubblock_size->second));
    }

    std::map<std::string, std::string>::const_iterator ubbank_size = vector_core_spec_map.find(CONVERT(ubbank_size));
    if (ubbank_size != vector_core_spec_map.end()) {
      platform_info_temp.vector_core_spec.ubbank_size = static_cast<uint64_t>(stoll(ubbank_size->second));
    }

    std::map<std::string, std::string>::const_iterator ubbank_num = vector_core_spec_map.find(CONVERT(ubbank_num));
    if (ubbank_num != vector_core_spec_map.end()) {
      platform_info_temp.vector_core_spec.ubbank_num = static_cast<uint64_t>(stoll(ubbank_num->second));
    }

    std::map<std::string, std::string>::const_iterator ubburst_in_one_block = vector_core_spec_map.find(CONVERT(ubburst_in_one_block));
    if (ubburst_in_one_block != vector_core_spec_map.end()) {
      platform_info_temp.vector_core_spec.ubburst_in_one_block =
          static_cast<uint64_t>(stoll(ubburst_in_one_block->second));
    }

    std::map<std::string, std::string>::const_iterator ubbank_group_num = vector_core_spec_map.find(CONVERT(ubbank_group_num));
    if (ubbank_group_num != vector_core_spec_map.end()) {
      platform_info_temp.vector_core_spec.ubbank_group_num = static_cast<uint64_t>(stoll(ubbank_group_num->second));
    }

    std::map<std::string, std::string>::const_iterator vector_reg_width =
        vector_core_spec_map.find(CONVERT(vector_reg_width));
    if (vector_reg_width != vector_core_spec_map.end()) {
      platform_info_temp.vector_core_spec.vector_reg_size =
          static_cast<uint64_t>(stoll(vector_reg_width->second));
    }

    std::map<std::string, std::string>::const_iterator predicate_reg_width =
        vector_core_spec_map.find(CONVERT(predicate_reg_width));
    if (predicate_reg_width != vector_core_spec_map.end()) {
      platform_info_temp.vector_core_spec.predicate_reg_size =
          static_cast<uint64_t>(stoll(predicate_reg_width->second));
    }
  } catch (...) {
    PF_LOGE("Failed to load VectorCoreSpecs.");
  }
}

void PlatformInfoManager::ParseVectorCoreMemoryRates(std::map<std::string, std::string> &vector_core_memory_rates_map,
                                                     PlatformInfo &platform_info_temp) {
  try {
    std::map<std::string, std::string>::const_iterator ddr_rate = vector_core_memory_rates_map.find(CONVERT(ddr_rate));
    if (ddr_rate != vector_core_memory_rates_map.end()) {
      platform_info_temp.vector_core_memory_rates.ddr_rate = static_cast<double>(stod(ddr_rate->second));
    }

    std::map<std::string, std::string>::const_iterator ddr_read_rate = vector_core_memory_rates_map.find(CONVERT(ddr_read_rate));
    if (ddr_read_rate != vector_core_memory_rates_map.end()) {
      platform_info_temp.vector_core_memory_rates.ddr_read_rate = static_cast<double>(stod(ddr_read_rate->second));
    }

    std::map<std::string, std::string>::const_iterator ddr_write_rate = vector_core_memory_rates_map.find(CONVERT(ddr_write_rate));
    if (ddr_write_rate != vector_core_memory_rates_map.end()) {
      platform_info_temp.vector_core_memory_rates.ddr_write_rate = static_cast<double>(stod(ddr_write_rate->second));
    }

    std::map<std::string, std::string>::const_iterator l2_rate = vector_core_memory_rates_map.find(CONVERT(l2_rate));
    if (l2_rate != vector_core_memory_rates_map.end()) {
      platform_info_temp.vector_core_memory_rates.l2_rate = static_cast<double>(stod(l2_rate->second));
    }

    std::map<std::string, std::string>::const_iterator l2_read_rate = vector_core_memory_rates_map.find(CONVERT(l2_read_rate));
    if (l2_read_rate != vector_core_memory_rates_map.end()) {
      platform_info_temp.vector_core_memory_rates.l2_read_rate = static_cast<double>(stod(l2_read_rate->second));
    }

    std::map<std::string, std::string>::const_iterator l2_write_rate = vector_core_memory_rates_map.find(CONVERT(l2_write_rate));
    if (l2_write_rate != vector_core_memory_rates_map.end()) {
      platform_info_temp.vector_core_memory_rates.l2_write_rate = static_cast<double>(stod(l2_write_rate->second));
    }

    std::map<std::string, std::string>::const_iterator ub_to_l2_rate = vector_core_memory_rates_map.find(CONVERT(ub_to_l2_rate));
    if (ub_to_l2_rate != vector_core_memory_rates_map.end()) {
      platform_info_temp.vector_core_memory_rates.ub_to_l2_rate = static_cast<double>(stod(ub_to_l2_rate->second));
    }

    std::map<std::string, std::string>::const_iterator ub_to_ddr_rate = vector_core_memory_rates_map.find(CONVERT(ub_to_ddr_rate));
    if (ub_to_ddr_rate != vector_core_memory_rates_map.end()) {
      platform_info_temp.vector_core_memory_rates.ub_to_ddr_rate = static_cast<double>(stod(ub_to_ddr_rate->second));
    }
  } catch (...) {
    PF_LOGE("Failed to load VectorCoreMemoryRates.");
  }
}

void PlatformInfoManager::ParseCPUCache(std::map<std::string, std::string> &CPUCacheMap, PlatformInfo &platform_info_temp) {
  try {
    std::map<std::string, std::string>::const_iterator AICPUSyncBySW = CPUCacheMap.find(CONVERT(AICPUSyncBySW));
    if (AICPUSyncBySW != CPUCacheMap.end()) {
      platform_info_temp.cpucache.AICPUSyncBySW = static_cast<uint32_t>(stod(AICPUSyncBySW->second));
    }

    std::map<std::string, std::string>::const_iterator TSCPUSyncBySW = CPUCacheMap.find(CONVERT(TSCPUSyncBySW));
    if (TSCPUSyncBySW != CPUCacheMap.end()) {
      platform_info_temp.cpucache.TSCPUSyncBySW = static_cast<uint32_t>(stod(TSCPUSyncBySW->second));
    }
  } catch (...) {
    PF_LOGE("Failed to load CPU cache.");
  }
}

void PlatformInfoManager::ParseVectorCoreintrinsicDtypeMap(std::map<std::string, std::string> &vector_coreintrinsic_dtype_map,
                                                           PlatformInfo &platform_info_temp) {
  std::map<std::string, std::string>::const_iterator iter;
  for (iter = vector_coreintrinsic_dtype_map.begin(); iter != vector_coreintrinsic_dtype_map.end(); iter++) {
    size_t pos = iter->second.find('|');
    if (pos == std::string::npos) {
      PF_LOGE("The intrinsic_dtype_map string does not contain '|'.");
      return;
    }
    std::string key = iter->second.substr(0, pos);
    std::string value = iter->second.substr(pos + 1);
    std::vector<std::string> dtype_vector = Split(value, ',');
    platform_info_temp.vector_core_intrinsic_dtype_map.emplace(make_pair(key, dtype_vector));
  }
}

void PlatformInfoManager::ParseSoftwareSpec(std::map<std::string, std::string> &software_spec_map,
                                            PlatformInfo &platform_info_temp) {
  try {
    std::map<std::string, std::string>::const_iterator jit_compile_default_value =
        software_spec_map.find(CONVERT(jit_compile_default_value));
    if (jit_compile_default_value != software_spec_map.end() &&
        jit_compile_default_value->second == "1") {
      platform_info_temp.software_spec.jit_compile_default_value = true;
      platform_info_temp.software_spec.jit_compile_mode = JitCompileMode::COMPILE_ONLINE;
    } else {
      platform_info_temp.software_spec.jit_compile_default_value = false;
    }
  } catch (...) {
    PF_LOGE("Failed to load software specification.");
  }
}

uint32_t PlatformInfoManager::ParsePlatformInfoFromStrToStruct(std::map<std::string, std::map<std::string, std::string>> &content_info_map,
                                                               std::string &soc_version, PlatformInfo &platform_info_temp) {
  std::map<std::string, std::map<std::string, std::string>>::iterator it;
  for (it = content_info_map.begin(); it != content_info_map.end(); it++) {
    auto iter = g_platform_info_type_map.find(it->first);
    if (iter == g_platform_info_type_map.end()) {
      continue;
    }

    switch (iter->second) {
      case PlatformInfoType::EN_VERSION: {
        ParseVersion(it->second, soc_version, platform_info_temp);
        break;
      }
      case PlatformInfoType::EN_SOC_INFO: {
        ParseSocInfo(it->second, platform_info_temp);
        break;
      }
      case PlatformInfoType::EN_AI_CORE_SPEC: {
        ParseAICoreSpec(it->second, platform_info_temp);
        break;
      }
      case PlatformInfoType::EN_AI_CORE_MEMORY_RATES: {
        ParseAICoreMemoryRates(it->second, platform_info_temp);
        break;
      }
      case PlatformInfoType::EN_CPU_CACHE: {
        ParseCPUCache(it->second, platform_info_temp);
        break;
      }
      case PlatformInfoType::EN_AI_CORE_INTRINSIC_DTYPE_MAP: {
        ParseAICoreintrinsicDtypeMap(it->second, platform_info_temp);
        break;
      }
      case PlatformInfoType::EN_VECTOR_CORE_SPEC: {
        ParseVectorCoreSpec(it->second, platform_info_temp);
        break;
      }
      case PlatformInfoType::EN_VECTOR_CORE_MEMORY_RATES: {
        ParseVectorCoreMemoryRates(it->second, platform_info_temp);
        break;
      }
      case PlatformInfoType::EN_VECTOR_CORE_INTRINSIC_DTYPE_MAP: {
        ParseVectorCoreintrinsicDtypeMap(it->second, platform_info_temp);
        break;
      }
      case PlatformInfoType::EN_SOFTWARE_SPEC: {
        ParseSoftwareSpec(it->second, platform_info_temp);
        break;
      }
      default: { return PLATFORM_FAILED; }
    }
  }

  return PLATFORM_SUCCESS;
}

uint32_t PlatformInfoManager::AssemblePlatformInfoVector(std::map<std::string, std::map<std::string, std::string>> &content_info_map) {
  std::string soc_version;
  PlatformInfo platform_info_temp;
  uint32_t ret = ParsePlatformInfoFromStrToStruct(content_info_map, soc_version, platform_info_temp);
  if (ret != PLATFORM_SUCCESS) {
    PF_LOGE("Parse platform info from content failed.");
    return PLATFORM_FAILED;
  }

  if (!soc_version.empty()) {
    auto iter = platform_info_map_.find(soc_version);
    if (iter == platform_info_map_.end()) {
      platform_info_map_.emplace(make_pair(soc_version, platform_info_temp));
    }
  }

  PlatFormInfos platform_infos;
  if (!platform_infos.Init()) {
    return PLATFORM_FAILED;
  }

  if (ParsePlatformInfo(content_info_map, soc_version, platform_infos) != PLATFORM_SUCCESS) {
    PF_LOGE("Parse platform info from content failed.");
    return PLATFORM_FAILED;
  }
  FillupFixPipeInfo(platform_infos);
  bool init_result = true;
  if (!soc_version.empty()) {
    auto iter = platform_infos_map_.find(soc_version);
    if (iter == platform_infos_map_.end()) {
      platform_infos_map_.emplace(soc_version, platform_infos);
      auto iter_soc = SOC_VERSION_STR.find(soc_version);
      if (iter_soc != SOC_VERSION_STR.end()) {
        auto &lite = platform_infos_lite_vec_.at(static_cast<size_t>(iter_soc->second));
        init_result = lite.InitPlatFormInfosLite(iter_soc->second, platform_infos);
      } else {
        PF_LOGW("Cannot find Soc info enum by %s.", soc_version.c_str());
      }
      PF_LOGD("The platform info's os soc version[%s] has been initialized.", soc_version.c_str());
    }
  }

  if (!init_result) {
    PF_LOGE("Failed to initialize platform by %s.", soc_version.c_str());
    return PLATFORM_FAILED;
  }

  return PLATFORM_SUCCESS;
}

void PlatformInfoManager::FillupFixPipeInfo(PlatFormInfos &platform_infos) {
  std::string is_support_fixpipe_str;
  if (!platform_infos.GetPlatformRes("AICoreSpec", "support_fixpipe", is_support_fixpipe_str) ||
      !static_cast<bool>(std::atoi(is_support_fixpipe_str.c_str()))) {
    return;
  }
  std::map<std::string, std::vector<std::string>> aicore_map = platform_infos.GetAICoreIntrinsicDtype();
  std::map<std::string, std::vector<std::string>> fixpipe_map_;
  for (auto iter = aicore_map.begin(); iter != aicore_map.end(); iter++) {
    if (iter->first.find(FIXPIPE_CONFIG_KEY) != iter->first.npos) {
      fixpipe_map_.emplace(make_pair(iter->first, iter->second));
    }
  }
  if (fixpipe_map_.empty()) {
    return;
  }
  platform_infos.SetFixPipeDtypeMap(fixpipe_map_);
}

void PlatformInfoManager::ParseAICoreintrinsicDtypeMap(std::map<std::string, std::string> &ai_coreintrinsic_dtype_map,
                                                       PlatFormInfos &platform_info_temp) {
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
    std::vector<std::string> dtype_vector = Split(value, ',');
    platform_res_map.emplace(make_pair(key, value));
    aicore_intrinsic_dtypes.emplace(make_pair(key, dtype_vector));
  }

  platform_info_temp.SetPlatformRes(STR_AI_CORE_INTRINSIC_DTYPE_MAP, platform_res_map);
  platform_info_temp.SetAICoreIntrinsicDtype(aicore_intrinsic_dtypes);
}

void PlatformInfoManager::ParseVectorCoreintrinsicDtypeMap(std::map<std::string, std::string> &vector_coreintrinsic_dtype_map,
                                                           PlatFormInfos &platform_info_temp) {
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
    std::vector<std::string> dtype_vector = Split(value, ',');
    platform_res_map.emplace(make_pair(key, value));
    vector_core_intrinsic_dtype_map.emplace(make_pair(key, dtype_vector));
  }

  platform_info_temp.SetPlatformRes(STR_VECTOR_CORE_INTRINSIC_DTYPE_MAP, platform_res_map);
  platform_info_temp.SetVectorCoreIntrinsicDtype(vector_core_intrinsic_dtype_map);
}

void PlatformInfoManager::ParsePlatformRes(const std::string &label,
                                           std::map<std::string, std::string> &platform_res_map,
                                           PlatFormInfos &platform_info_temp) {
  platform_info_temp.SetPlatformRes(label, platform_res_map);
}

uint32_t PlatformInfoManager::ParsePlatformInfo(std::map<std::string, std::map<std::string, std::string>> &content_info_map,
                                                std::string &soc_version, PlatFormInfos &platform_info_temp) {
  (void)soc_version;
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

std::string PlatformInfoManager::RealPath(const std::string &path) {
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

std::string PlatformInfoManager::GetSoFilePath() {
  Dl_info dl_info;
  std::string real_file_path = "";
  PlatformInfoManager &(*instance_ptr)() = &PlatformInfoManager::Instance;
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

__attribute__((visibility("default"))) uint32_t PlatformInfoManager::InitializePlatformInfo() {
  // add lock
  std::lock_guard<std::mutex> lock_guard(pc_lock_);
  if (init_flag_) {
    return PLATFORM_SUCCESS;
  }
  std::string cfg_file_real_path = RealPath(GetSoFilePath() + PLATFORM_RELATIVE_PATH);
  if (cfg_file_real_path.empty()) {
    PF_LOGE("File path[%s] is not valid.", cfg_file_real_path.c_str());
    return PLATFORM_FAILED;
  }

  uint32_t ret = LoadConfigFile(cfg_file_real_path);
  if (ret != PLATFORM_SUCCESS) {
    PF_LOGE("Failed to load configuration file, path: %s.", cfg_file_real_path.c_str());
    return PLATFORM_FAILED;
  }
  if (!opti_compilation_infos_.Init()) {
    PF_LOGE("Failed to initialize optional information.");
    return PLATFORM_FAILED;
  }

  init_flag_ = true;

  return PLATFORM_SUCCESS;
}

__attribute__((visibility("default"))) uint32_t PlatformInfoManager::GetPlatformInfo(
    const std::string SoCVersion, PlatformInfo &platform_info, OptionalInfo &opti_compilation_info) {
  std::string realSocVersion = SoCVersion;
  if (realSocVersion == SOC_VERSION_ASCEND910) {
    realSocVersion = SOC_VERSION_ASCEND910A;
  }
  auto iter = platform_info_map_.find(realSocVersion);
  if (iter == platform_info_map_.end()) {
    PF_LOGE("Cannot find platform_info by SoCVersion %s.", realSocVersion.c_str());
    return PLATFORM_FAILED;
  }
  platform_info = iter->second;
  opti_compilation_info = opti_compilation_info_;
  return PLATFORM_SUCCESS;
}

__attribute__((visibility("default"))) uint32_t PlatformInfoManager::GetPlatformInfoWithOutSocVersion(
    PlatformInfo &platform_info, OptionalInfo &opti_compilation_info) {
  std::lock_guard<std::mutex> lock_guard(pc_lock_);
  if (opti_compilation_info_.soc_version.empty()) {
    PF_LOGW("Can not found platform_info.");
    return PLATFORM_FAILED;
  }
  auto iter = platform_info_map_.find(opti_compilation_info_.soc_version);
  if (iter == platform_info_map_.end()) {
    PF_LOGE("Cannot find platform_info by SoCVersion %s.", opti_compilation_info_.soc_version.c_str());
    return PLATFORM_FAILED;
  }
  platform_info = iter->second;
  opti_compilation_info = opti_compilation_info_;
  return PLATFORM_SUCCESS;
}

void PlatformInfoManager::SetOptionalCompilationInfo(OptionalInfo &opti_compilation_info) {
  // add lock
  std::lock_guard<std::mutex> lock_guard(pc_lock_);
  opti_compilation_info_ = opti_compilation_info;
  if (opti_compilation_info_.soc_version == SOC_VERSION_ASCEND910) {
    opti_compilation_info_.soc_version = SOC_VERSION_ASCEND910A;
  }
}

__attribute__((visibility("default"))) uint32_t PlatformInfoManager::GetPlatFormInfosLite(
    SocVersion soc_version, PlatFormInfosLite &platform_infos_lite) {
  if (static_cast<size_t>(soc_version) >= platform_infos_lite_vec_.size()) {
    return PLATFORM_FAILED;
  } else {
    platform_infos_lite = platform_infos_lite_vec_.at(static_cast<size_t>(soc_version));
    return PLATFORM_SUCCESS;
  }
}

__attribute__((visibility("default"))) uint32_t PlatformInfoManager::GetPlatformInfos(
    const std::string SoCVersion, PlatFormInfos &platform_info, OptionalInfos &opti_compilation_info) {
  std::string realSocVersion = SoCVersion;
  if (realSocVersion == SOC_VERSION_ASCEND910) {
    realSocVersion = SOC_VERSION_ASCEND910A;
  }
  auto iter = platform_infos_map_.find(realSocVersion);
  if (iter == platform_infos_map_.end()) {
    PF_LOGE("Cannot find platform_info by SoCVersion %s.", realSocVersion.c_str());
    return PLATFORM_FAILED;
  }
  platform_info = iter->second;
  opti_compilation_info = opti_compilation_infos_;
  std::lock_guard<std::mutex> lock_guard(pc_lock_);
  opti_compilation_info.SetFixPipeDtypeMap(platform_info.GetFixPipeDtypeMap());
  return PLATFORM_SUCCESS;
}

__attribute__((visibility("default"))) uint32_t PlatformInfoManager::GetPlatformInfoWithOutSocVersion(
    PlatFormInfos &platform_info, OptionalInfos &opti_compilation_info) {
  std::lock_guard<std::mutex> lock_guard(pc_lock_);
  if (opti_compilation_infos_.GetSocVersion().empty()) {
    PF_LOGW("Cannot find platform_info.");
    return PLATFORM_FAILED;
  }
  auto iter = platform_infos_map_.find(opti_compilation_infos_.GetSocVersion());
  if (iter == platform_infos_map_.end()) {
    PF_LOGE("Cannot find platform_info by SoCVersion %s.", opti_compilation_infos_.GetSocVersion().c_str());
    return PLATFORM_FAILED;
  }
  platform_info = iter->second;
  if (!platform_info.GetFixPipeDtypeMap().empty()) {
    opti_compilation_infos_.SetFixPipeDtypeMap(platform_info.GetFixPipeDtypeMap());
  }
  opti_compilation_info = opti_compilation_infos_;
  return PLATFORM_SUCCESS;
}

__attribute__((visibility("default"))) uint32_t PlatformInfoManager::GetPlatformInstanceByDevice(
    const uint32_t &device_id, PlatFormInfos &platform_info) {
  std::lock_guard<std::mutex> lock_guard(pc_lock_);
  auto iter = device_platform_infos_map_.find(device_id);
  if (iter == device_platform_infos_map_.end()) {
    if (opti_compilation_infos_.GetSocVersion().empty()) {
      PF_LOGW("Not initialize soc_version of optional_infos.");
      return PLATFORM_FAILED;
    }
    if (platform_infos_map_.find(opti_compilation_infos_.GetSocVersion()) == platform_infos_map_.end()) {
      PF_LOGW("Failed to initialize platform info map.");
      return PLATFORM_FAILED;
    }
    device_platform_infos_map_[device_id] = platform_infos_map_[opti_compilation_infos_.GetSocVersion()];
  }
  platform_info = device_platform_infos_map_[device_id];
  return PLATFORM_SUCCESS;
}

void PlatformInfoManager::SetOptionalCompilationInfo(OptionalInfos &opti_compilation_info) {
  // add lock
  std::lock_guard<std::mutex> lock_guard(pc_lock_);
  opti_compilation_infos_ = opti_compilation_info;
  if (opti_compilation_infos_.GetSocVersion() == SOC_VERSION_ASCEND910) {
    opti_compilation_infos_.SetSocVersion(SOC_VERSION_ASCEND910A);
  }
}

uint32_t PlatformInfoManager::UpdatePlatformInfos(fe::PlatFormInfos &platform_info) {
  // add lock
  std::lock_guard<std::mutex> lock_guard(pc_lock_);
  if (opti_compilation_infos_.GetSocVersion().empty()) {
    PF_LOGE("Soc_version in the optional information is empty.");
    return PLATFORM_FAILED;
  }
  if (platform_infos_map_.find(opti_compilation_infos_.GetSocVersion()) == platform_infos_map_.end()) {
    PF_LOGE("Platform info for soc_version [%s] is not initialized.", opti_compilation_infos_.GetSocVersion().c_str());
    return PLATFORM_FAILED;
  }
  platform_infos_map_[opti_compilation_infos_.GetSocVersion()] = platform_info;
  return PLATFORM_SUCCESS;
}

uint32_t PlatformInfoManager::UpdatePlatformInfos(const std::string &soc_version, fe::PlatFormInfos &platform_info) {
  // add lock
  std::lock_guard<std::mutex> lock_guard(pc_lock_);
  if (soc_version.empty()) {
    PF_LOGE("Soc_version is empty.");
    return PLATFORM_FAILED;
  }
  std::string real_soc = soc_version;
  if (real_soc == SOC_VERSION_ASCEND910) {
    real_soc = SOC_VERSION_ASCEND910A;
  }
  if (platform_infos_map_.find(real_soc) == platform_infos_map_.end()) {
    PF_LOGE("Platform info for soc_version [%s] is not initialized.", real_soc.c_str());
    return PLATFORM_FAILED;
  }
  opti_compilation_infos_.SetSocVersionWithLock(real_soc);
  platform_infos_map_[real_soc] = platform_info;
  return PLATFORM_SUCCESS;
}

uint32_t PlatformInfoManager::Finalize() {
  // add lock
  std::lock_guard<std::mutex> lock_guard(pc_lock_);
  if (!init_flag_) {
    return PLATFORM_SUCCESS;
  }

  platform_info_map_.clear();

  platform_infos_map_.clear();

  device_platform_infos_map_.clear();

  runtime_device_platform_infos_map_.clear();

  init_flag_ = false;

  return PLATFORM_SUCCESS;
}

uint32_t PlatformInfoManager::GetRuntimePlatformInfosByDevice(const uint32_t &device_id,
    PlatFormInfos &platform_infos, bool need_deep_copy) {
  std::lock_guard<std::mutex> lock_guard(pc_lock_);
  const auto it = runtime_device_platform_infos_map_.find(device_id);
  PlatFormInfos device_platform_infos;
  if (it == runtime_device_platform_infos_map_.end()) {
    PF_LOGD("Add new platform info with device_id %u.", device_id);
    PlatformInfosUtils::GetInstance().Clone(device_platform_infos, runtime_platform_infos_);
    runtime_device_platform_infos_map_[device_id] = device_platform_infos;
  } else {
    PF_LOGD("Return the platform infos with device_id %u.", device_id);
    device_platform_infos = it->second;
  }
  if (need_deep_copy) {
    PlatformInfosUtils::GetInstance().Clone(platform_infos, device_platform_infos);
  } else {
    platform_infos = device_platform_infos;
  }
  return PLATFORM_SUCCESS;
}

uint32_t PlatformInfoManager::UpdateRuntimePlatformInfosByDevice(const uint32_t &device_id,
    PlatFormInfos &platform_infos) {
  std::lock_guard<std::mutex> lock_guard(pc_lock_);
  PF_LOGD("Update the platform info with device_id %u.", device_id);
  PlatFormInfos device_platform_infos;
  PlatformInfosUtils::GetInstance().Clone(device_platform_infos, platform_infos);
  runtime_device_platform_infos_map_[device_id] = device_platform_infos;
  return PLATFORM_SUCCESS;
}

uint32_t PlatformInfoManager::InitRuntimePlatformInfos(const std::string &SoCVersion) {
  std::lock_guard<std::mutex> lock_guard(pc_lock_);
  if (runtime_init_flag_) {
    return PLATFORM_SUCCESS;
  }

  std::string cfg_file_real_path = RealPath(GetSoFilePath() + PLATFORM_RELATIVE_PATH);
  if (cfg_file_real_path.empty()) {
    PF_LOGE("File path[%s] is not valid.", cfg_file_real_path.c_str());
    return PLATFORM_FAILED;
  }

  std::string real_soc = SoCVersion;
  if (real_soc == SOC_VERSION_ASCEND910) {
    real_soc = SOC_VERSION_ASCEND910A;
  }

  std::string ini_file_path = cfg_file_real_path + "/" + real_soc + ".ini";
  if (LoadIniFile(ini_file_path) != PLATFORM_SUCCESS) {
      PF_LOGE("Failed to load ini file[%s].", ini_file_path.c_str());
      return PLATFORM_FAILED;
  }

  const auto it = platform_infos_map_.find(SoCVersion);
  if (it == platform_infos_map_.end()) {
    std::string errLevel = "E20101";
    std::vector<const char*> args_keys;
    const char* SocVersion = SoCVersion.c_str();
    std::vector<const char*> args_values;
    args_keys.push_back("value");
    args_keys.push_back("parameter");
    args_keys.push_back("reason");
    args_values.push_back(SocVersion);
    args_values.push_back("SoCVersion");
    args_values.push_back("SocVersion may be incorrect");
    REPORT_PREDEFINED_ERRMSG_3PARAMS(errLevel.c_str(), args_keys, args_values);
    PF_LOGE("Not find platformInfos, SocVersion: [%s]", SoCVersion.c_str());
    return PLATFORM_FAILED;
  }
  PlatformInfosUtils::GetInstance().Clone(runtime_platform_infos_, it->second);
  runtime_init_flag_ = true;
  return PLATFORM_SUCCESS;
}

}  // namespace fe
