/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "platform/platform_infos_lite_def.h"
#include "platform_infos_lite_impl.h"
#include "platform_log.h"

namespace fe {
bool PlatFormInfosLite::InitPlatFormInfosLite(SocVersion soc_version, PlatFormInfos& old_platform_infos) {
  PF_MAKE_SHARED(platform_infos_lite_impl_ = std::make_shared<PlatFormInfosLiteImpl>(), return false);
  if (platform_infos_lite_impl_ == nullptr) {
    return false;
  }

  return platform_infos_lite_impl_->InitPlatFormInfosLite(soc_version, old_platform_infos);
}

bool PlatFormInfosLite::GetPlatformRes(PlatformLabel label, uint64_t key, uint64_t &val) const {
  if (platform_infos_lite_impl_ == nullptr) {
    return false;
  }
  return platform_infos_lite_impl_->GetPlatformRes(label, key, val);
}

const std::vector<uint64_t> &PlatFormInfosLite::GetPlatformRes(PlatformLabel label) const {
  return platform_infos_lite_impl_->GetPlatformRes(label);
}

bool PlatFormInfosLite::CheckIntrinsicSupport(IntrinsicTypeKey intrinsic_type,
                                              IntrinsicAbility intrinsic_ability) const {
  if (platform_infos_lite_impl_ == nullptr) {
    return false;
  }
  return platform_infos_lite_impl_->CheckIntrinsicSupport(intrinsic_type, intrinsic_ability);
}
}
