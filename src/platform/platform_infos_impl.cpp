/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "platform_infos_impl.h"

using namespace std;

namespace fe {

std::map<std::string, std::vector<std::string>> PlatFormInfosImpl::GetAICoreIntrinsicDtype() {
  return ai_core_intrinsic_dtype_map_;
}

std::map<std::string, std::vector<std::string>> PlatFormInfosImpl::GetVectorCoreIntrinsicDtype() {
  return vector_core_intrinsic_dtype_map_;
}

PlatFormInfosImpl::PlatFormInfosImpl(const PlatFormInfosImpl &platform_infos_impl) {
  ai_core_intrinsic_dtype_map_ = platform_infos_impl.ai_core_intrinsic_dtype_map_;
  vector_core_intrinsic_dtype_map_ = platform_infos_impl.vector_core_intrinsic_dtype_map_;
  platform_res_map_ = platform_infos_impl.platform_res_map_;
  fixpipe_dtype_map_ = platform_infos_impl.fixpipe_dtype_map_;
}

PlatFormInfosImpl& PlatFormInfosImpl::operator=(const PlatFormInfosImpl& platform_infos_impl) {
    if (this != &platform_infos_impl) {
        ai_core_intrinsic_dtype_map_ = platform_infos_impl.ai_core_intrinsic_dtype_map_;
        vector_core_intrinsic_dtype_map_ = platform_infos_impl.vector_core_intrinsic_dtype_map_;
        platform_res_map_ = platform_infos_impl.platform_res_map_;
        fixpipe_dtype_map_ = platform_infos_impl.fixpipe_dtype_map_;
    }
    return *this;
}

bool PlatFormInfosImpl::GetPlatformRes(const std::string& label, const std::string& key,
                                       std::string& val) {
  auto it_label = platform_res_map_.find(label);
  if (it_label == platform_res_map_.end()) {
    return false;
  }
  auto it_key = it_label->second.find(key);
  if (it_key == it_label->second.end()) {
    return false;
  }

  val = it_key->second;
  return true;
}

bool PlatFormInfosImpl::GetPlatformRes(const std::string& label, std::map<std::string, std::string>& res) {
  auto it_label = platform_res_map_.find(label);
  if (it_label == platform_res_map_.end()) {
    return false;
  }

  res = it_label->second;
  return true;
}

bool PlatFormInfosImpl::GetPlatformRes(std::map<std::string, std::map<std::string, std::string>> &res) {
  res = platform_res_map_;
  return true;
}

void PlatFormInfosImpl::SetAICoreIntrinsicDtype(std::map<std::string, std::vector<std::string>>& intrinsic_dtypes) {
  ai_core_intrinsic_dtype_map_ = intrinsic_dtypes;
}

void PlatFormInfosImpl::SetVectorCoreIntrinsicDtype(std::map<std::string, std::vector<std::string>>& intrinsic_dtypes) {
  vector_core_intrinsic_dtype_map_ = intrinsic_dtypes;
}

void PlatFormInfosImpl::SetPlatformRes(const std::string& label, std::map<std::string, std::string>& res) {
  platform_res_map_[label] = res;
}

void PlatFormInfosImpl::SetFixPipeDtypeMap(
    const std::map<std::string, std::vector<std::string>>& fixpipe_dtype_map) {
  fixpipe_dtype_map_ = fixpipe_dtype_map;
}

std::map<std::string, std::vector<std::string>> PlatFormInfosImpl::GetFixPipeDtypeMap() {
  return fixpipe_dtype_map_;
}

std::string OptionalInfosImpl::GetSocVersion() { return soc_version_; }

std::string OptionalInfosImpl::GetCoreType() { return core_type_; }

uint32_t OptionalInfosImpl::GetAICoreNum() { return ai_core_num_; }

std::string OptionalInfosImpl::GetL1FusionFlag() { return l1_fusion_flag_; }

void OptionalInfosImpl::SetSocVersion(std::string soc_version) { soc_version_ = soc_version; }

void OptionalInfosImpl::SetFixPipeDtypeMap(
    const std::map<std::string, std::vector<std::string>>& fixpipe_dtype_map) {
  std::lock_guard<std::mutex> lock(mtx_);
  fixpipe_dtype_map_ = fixpipe_dtype_map;
}

std::map<std::string, std::vector<std::string>> OptionalInfosImpl::GetFixPipeDtypeMap() {
  std::lock_guard<std::mutex> lock(mtx_);
  return fixpipe_dtype_map_;
}

void OptionalInfosImpl::SetCoreType(string core_type) { core_type_ = core_type; }

void OptionalInfosImpl::SetAICoreNum(uint32_t ai_core_num) { ai_core_num_ = ai_core_num; }

void OptionalInfosImpl::SetL1FusionFlag(string l1_fusion_flag) { l1_fusion_flag_ = l1_fusion_flag; }

}  // namespace fe
