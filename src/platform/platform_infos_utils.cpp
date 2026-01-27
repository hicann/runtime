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
#include "platform_log.h"
#include "platform_infos_impl.h"

namespace fe {
std::mutex plt_mutex;

PlatformInfosUtils::PlatformInfosUtils()
{}

PlatformInfosUtils::~PlatformInfosUtils()
{}

PlatformInfosUtils &PlatformInfosUtils::GetInstance() {
  static PlatformInfosUtils platform_info_utils;
  return platform_info_utils;
}

void PlatformInfosUtils::Clone(PlatFormInfos &dest_platform_infos, const PlatFormInfos &platform_infos) const {
  std::lock_guard<std::mutex> lock_guard(plt_mutex);
  PF_LOGD("Using platFormInfos Clone function.");
  if(&dest_platform_infos != &platform_infos) {
    dest_platform_infos.core_num_ = platform_infos.core_num_;
    if (platform_infos.platform_infos_impl_) {
      dest_platform_infos.platform_infos_impl_ = std::make_shared<PlatFormInfosImpl>(*platform_infos.platform_infos_impl_);
    }
  }
}

void PlatformInfosUtils::Trim(std::string &str) {
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

void PlatformInfosUtils::Split(const std::string &str, char pattern, std::vector<std::string> &res_vec) {
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
}  // namespace fe
