/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __PLATFORM_INFOS_UTILS_H__
#define __PLATFORM_INFOS_UTILS_H__

#include <mutex>
#include <dlfcn.h>
#include <climits>
#include "platform/platform_infos_def.h"
#include "platform_log.h"

namespace fe {
extern std::mutex plt_mutex;
const std::string PLATFORM_RELATIVE_PATH = "data/platform_config";

class PlatformInfosUtils {
  public:
    PlatformInfosUtils(const PlatformInfosUtils &) = delete;
    PlatformInfosUtils &operator=(const PlatformInfosUtils &) = delete;

    static PlatformInfosUtils &GetInstance();
    void Clone(PlatFormInfos &dest_platform_infos, const PlatFormInfos &platform_infos) const;

    static void Trim(std::string &str);
    static void Split(const std::string &str, char pattern, std::vector<std::string> &res_vec);

  private:
    PlatformInfosUtils();
    ~PlatformInfosUtils();
};

std::string RealSoFilePath(const std::string &path);

template <typename ManagerType>
std::string GetSoFilePath() {
  Dl_info dl_info;
  std::string real_file_path = "";
  ManagerType &(*instance_ptr)() = &ManagerType::Instance;
  if (dladdr(reinterpret_cast<void *>(instance_ptr), &dl_info) == 0) {
    PF_LOGE("Failed to read the so file path.");
    return real_file_path;
  } else {
    std::string so_path = dl_info.dli_fname;
    if (so_path.empty()) {
      PF_LOGE("The so file path is empty.");
      return real_file_path;
    }
    real_file_path = RealSoFilePath(so_path);
    size_t pos = real_file_path.rfind('/');
    real_file_path = real_file_path.substr(0, pos + 1);
  }
  return real_file_path;
}

template <typename ManagerType>
std::string GetConfigFilePath() {
  std::string so_file_path = GetSoFilePath<ManagerType>();
  while (!so_file_path.empty() && so_file_path.back() == '/') {
    so_file_path.pop_back();
  }
  size_t pos = so_file_path.find_last_of("/\\");
  if (pos == std::string::npos) {
    return "";
  }
  so_file_path = so_file_path.substr(0, pos + 1);
  PF_LOGI("Current so file path is [%s].", so_file_path.c_str());

  return RealSoFilePath(so_file_path + PLATFORM_RELATIVE_PATH);
}
}  // namespace fe

#endif // __PLATFORM_INFOS_UTILS_H__
