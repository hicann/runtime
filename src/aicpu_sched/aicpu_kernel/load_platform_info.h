/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPU_KERNEL_LOAD_PLATFORM_INFO_H
#define AICPU_KERNEL_LOAD_PLATFORM_INFO_H
#include <mutex>
#include <memory>
#include "platform_infos_def.h"
namespace aicpu {
struct PlatformInfoArgs {
  uint64_t input_data_info;
  uint64_t input_data_len;
  uint64_t platform_instance;
};

class PlatformRebuild {
 public:
  static PlatformRebuild &GetInstance();
  int32_t ProcessPlatformInfoMsg(const uint64_t info_args, const uint32_t info_len);
 private:
  PlatformRebuild() = default;
  ~PlatformRebuild() = default;
  PlatformRebuild(const PlatformRebuild &) = delete;
  PlatformRebuild(PlatformRebuild &&) = delete;
  PlatformRebuild &operator=(const PlatformRebuild &) = delete;
  PlatformRebuild &operator=(PlatformRebuild &&) = delete;
};
}  // namespace aicpu
#endif // AICPU_KERNEL_LOAD_PLATFORM_INFO_H