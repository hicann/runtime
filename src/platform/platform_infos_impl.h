/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __PLATFORM_INFOS_IMPL_H__
#define __PLATFORM_INFOS_IMPL_H__

#include <map>
#include <string>
#include <vector>
#include <memory>
#include "platform/platform_infos_def.h"

namespace fe {
class PlatFormInfosImpl {
 public:
  PlatFormInfosImpl() = default;
  PlatFormInfosImpl(const PlatFormInfosImpl &platform_infos_impl);
  PlatFormInfosImpl& operator=(const PlatFormInfosImpl &platform_infos_impl);

  std::map<std::string, std::vector<std::string>> GetAICoreIntrinsicDtype();
  std::map<std::string, std::vector<std::string>> GetVectorCoreIntrinsicDtype();
  bool GetPlatformRes(const std::string &label, const std::string &key, std::string &val);
  bool GetPlatformRes(const std::string &label, std::map<std::string, std::string> &res);
  bool GetPlatformRes(std::map<std::string, std::map<std::string, std::string>> &res);

  void SetAICoreIntrinsicDtype(std::map<std::string, std::vector<std::string>> &intrinsic_dtypes);
  void SetVectorCoreIntrinsicDtype(std::map<std::string, std::vector<std::string>> &intrinsic_dtypes);
  void SetPlatformRes(const std::string &label, std::map<std::string, std::string> &res);
  std::map<std::string, std::vector<std::string>> GetFixPipeDtypeMap();
  void SetFixPipeDtypeMap(const std::map<std::string, std::vector<std::string>> &fixpipe_dtype_map);
 private:
  std::map<std::string, std::vector<std::string>> ai_core_intrinsic_dtype_map_;
  std::map<std::string, std::vector<std::string>> vector_core_intrinsic_dtype_map_;
  std::map<std::string, std::map<std::string, std::string>> platform_res_map_;
  std::map<std::string, std::vector<std::string>> fixpipe_dtype_map_;
};

class OptionalInfosImpl {
 public:
  std::string GetSocVersion();
  std::string GetCoreType();
  uint32_t GetAICoreNum();
  std::string GetL1FusionFlag();
  std::map<std::string, std::vector<std::string>> GetFixPipeDtypeMap();
  void SetFixPipeDtypeMap(const std::map<std::string, std::vector<std::string>> &fixpipe_dtype_map);
  void SetSocVersion(std::string soc_version);
  void SetCoreType(std::string core_type);
  void SetAICoreNum(uint32_t ai_core_num);
  void SetL1FusionFlag(std::string l1_fusion_flag);
 private:
  std::string soc_version_;
  std::string core_type_;
  uint32_t ai_core_num_{0};
  std::string l1_fusion_flag_;
  std::map<std::string, std::vector<std::string>> fixpipe_dtype_map_;
};
}  // namespace fe
#endif
