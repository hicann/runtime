/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "load_platform_info.h"
#include "utils/log.h"
#include "utils/status.h"
#include "type_def.h"

namespace {
struct LoadPlatformInfosArgs {
  uint64_t args{0UL};
  uint64_t args_size{0UL};
};
}

extern "C" {
__attribute__((visibility("default"))) uint32_t LoadCustPlatform(void *args) {
  KERNEL_LOG_INFO("Begin loading the custom platform");
  auto load_args = PtrToPtr<void, LoadPlatformInfosArgs>(args);
  const uint64_t input_info = load_args->args;
  const uint32_t info_len = static_cast<uint32_t>(load_args->args_size);
  return aicpu::PlatformRebuild::GetInstance().ProcessPlatformInfoMsg(input_info, info_len);
}

__attribute__((visibility("default"))) int32_t AicpuExtendKernelsLoadPlatformInfo(const uint64_t input_info,
  const uint32_t info_len) {
  KERNEL_LOG_INFO("Begin loading the custom platform with the extension package kernel.");
  return aicpu::PlatformRebuild::GetInstance().ProcessPlatformInfoMsg(input_info, info_len);
}
}

namespace aicpu {
PlatformRebuild &PlatformRebuild::GetInstance() {
  static PlatformRebuild instance;
  return instance;
}

int32_t PlatformRebuild::ProcessPlatformInfoMsg(const uint64_t info_args,
                                                const uint32_t info_len) {
  if (info_len != static_cast<uint32_t>(sizeof(PlatformInfoArgs))) {
    KERNEL_LOG_ERROR("The length of args is invalid, input:%u, base:%zu", info_len,
                     sizeof(PlatformInfoArgs));
    return KERNEL_STATUS_PARAM_INVALID;
  }
  const PlatformInfoArgs *const platform_args = PtrToPtr<void, PlatformInfoArgs>(ValueToPtr(info_args));
  KERNEL_CHECK_NULLPTR(platform_args, KERNEL_STATUS_PARAM_INVALID, "info args nullptr");
  if ((platform_args->input_data_info == 0UL) || (platform_args->input_data_len == 0UL) ||
      (platform_args->platform_instance == 0UL)) {
    KERNEL_LOG_ERROR(
        "input args is invalid: input_data_info:0x%x, input_data_len:%llu, platform_instance:0x%x",
        platform_args->input_data_info, platform_args->input_data_len, platform_args->platform_instance);
    return KERNEL_STATUS_PARAM_INVALID;
  }

  KERNEL_LOG_INFO("input param: input_data_info:0x%x, input_data_len:%llu, platform_instance:0x%x",
                  platform_args->input_data_info, platform_args->input_data_len,
                  platform_args->platform_instance);
  fe::PlatFormInfos *platform_infos = PtrToPtr<void, fe::PlatFormInfos>(ValueToPtr(platform_args->platform_instance));
  KERNEL_CHECK_NULLPTR(platform_infos, KERNEL_STATUS_PARAM_INVALID, "platform instance nullptr");
  char *input_data_info = PtrToPtr<void, char>(ValueToPtr(platform_args->input_data_info));
  KERNEL_CHECK_FALSE(platform_infos->Init(), KERNEL_STATUS_INNER_ERROR, "Fe platformInfo init failed");
  if (!(platform_infos->LoadFromBuffer(input_data_info, platform_args->input_data_len))) {
    KERNEL_LOG_ERROR("Deserialization failed");
    return KERNEL_STATUS_INNER_ERROR;
  }
  KERNEL_LOG_INFO("The platform info has been loaded successfully.");
  return KERNEL_STATUS_OK;
}
}  // namespace aicpu
