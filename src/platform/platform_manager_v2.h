/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef PLATFORM_MANAGER_V2_H
#define PLATFORM_MANAGER_V2_H

#include <map>
#include <string>
#include <array>
#include <mutex>
#include "platform_infos_def.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus
class PlatformManagerV2 {
 public:
  PlatformManagerV2(const PlatformManagerV2 &) = delete;
  PlatformManagerV2 &operator=(const PlatformManagerV2 &) = delete;

  static PlatformManagerV2 &Instance();

  int32_t GetSocSpec(const std::string &soc_version, const std::string &label, const std::string &key, std::string &value);

 private:
  PlatformManagerV2() = default;
  ~PlatformManagerV2() = default;

  uint32_t LoadIniFile(const std::string &ini_file_real_path);
  uint32_t AssemblePlatformInfoVector(std::map<std::string, std::map<std::string, std::string>> &content_info_map);
  void FillupFixPipeInfo(fe::PlatFormInfos &platform_infos);
  void ParseAICoreintrinsicDtypeMap(std::map<std::string, std::string> &ai_coreintrinsic_dtype_map,
                                    fe::PlatFormInfos &platform_info_temp);
  void ParseVectorCoreintrinsicDtypeMap(std::map<std::string, std::string> &vector_coreintrinsic_dtype_map,
                                        fe::PlatFormInfos &platform_info_temp);
  void ParsePlatformRes(const std::string &label, std::map<std::string, std::string> &platform_res_map,
                        fe::PlatFormInfos &platform_info_temp);
  uint32_t ParsePlatformInfo(std::map<std::string, std::map<std::string, std::string>> &content_info_map,
                            fe::PlatFormInfos &platform_info_temp);
  std::string RealPath(const std::string &path);
  std::string GetSoFilePath();
  std::string GetConfigFilePath();
  uint32_t InitPlatformInfos(const std::string &soc_version);
  int32_t GetPlatformInfos(const std::string &soc_version, fe::PlatFormInfos &platform_info);

 private:
  std::mutex soc_lock_;
  std::map<std::string, bool> soc_file_status_;

  std::map<std::string, fe::PlatFormInfos> platform_infos_map_;
};

#ifdef __cplusplus
}
#endif // __cplusplus
#endif
