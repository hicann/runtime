/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __PLATFORM_INFOS_LITE_IMPL_H__
#define __PLATFORM_INFOS_LITE_IMPL_H__

#include <set>
#include "platform/platform_infos_lite_def.h"

namespace fe {
class PlatFormInfosLiteImpl {
 public:
  bool InitPlatFormInfosLite(SocVersion soc_version, PlatFormInfos& old_platform_infos);
  bool GetPlatformRes(PlatformLabel label, uint64_t key, uint64_t &val);
  bool CheckIntrinsicSupport(IntrinsicTypeKey intrinsic_type, IntrinsicAbility intrinsic_ability) const;

  const std::vector<uint64_t> &GetPlatformRes(PlatformLabel label);

 private:
     void InitializeSingleNormal(
         PlatFormInfos &oldPlatformInfos, const std::string &labelName, const std::vector<std::string> &keyNameVec);
     bool InitializeSingleIntrinsic(PlatFormInfos &oldPlatformInfos, size_t i, const std::string &labelName,
         const std::vector<std::string> &keyNameVec);
     bool init_ = false;
     SocVersion soc_version_;
     std::vector<std::vector<uint64_t>> normal_infos_;
     std::vector<std::set<IntrinsicAbility>> intrinsic_infos_;
};
}  // namespace fe

#endif // __PLATFORM_INFOS_LITE_IMPL_H__
