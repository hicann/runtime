/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "acl/acl_platform.h"

#include <cstring>
#include <map>
#include <string>
#include <utility>
#include <vector>
#include <securec.h>

#include "platform/platform_info.h"
#include "platform/platform_infos_def.h"
#include "platform_log.h"

namespace {
aclError CopyToBuffer(const std::string &src, char *dst, uint32_t max_len)
{
  if (src.size() + 1U > static_cast<size_t>(max_len)) {
    PF_LOGE("Buffer too small: need %zu bytes, got %u.", src.size() + 1U, max_len);
    return ACL_ERROR_INVALID_PARAM;
  }
  if (memcpy_s(dst, static_cast<size_t>(max_len), src.c_str(), src.size() + 1U) != 0) {
    PF_LOGE("memcpy_s failed.");
    return ACL_ERROR_INVALID_PARAM;
  }
  return ACL_SUCCESS;
}

// Try to obtain a valid PlatFormInfos from the given manager.
// Strategy 1: runtime device binding (device 0).
// Strategy 2: fallback via OptionalInfos soc_version.
// Returns true and fills |platform_infos| on success.
bool TryGetPlatFormInfos(fe::PlatformInfoManager &mgr, fe::PlatFormInfos &platform_infos, std::string &source)
{
  auto IsValid = [&]() -> bool {
    std::string probe;
    return platform_infos.GetPlatformResWithLock("SoCInfo", "ai_core_cnt", probe) && !probe.empty();
  };

  fe::OptionalInfos optional_infos;
  if (mgr.GetPlatformInfoWithOutSocVersion(platform_infos, optional_infos) == 0U && IsValid()) {
    source = "optional_infos";
    return true;
  }

  if (mgr.GetRuntimePlatformInfosByDevice(0U, platform_infos) == 0U && IsValid()) {
    source = "device_binding";
    return true;
  }

  return false;
}

// Query order:
//   1. Instance  – GetPlatformInfoWithOutSocVersion
//   2. Instance  – GetRuntimePlatformInfosByDevice
//   3. GeInstance – GetPlatformInfoWithOutSocVersion
//   4. GeInstance – GetRuntimePlatformInfosByDevice
bool GetPlatFormInfos(fe::PlatFormInfos &platform_infos)
{
  std::string source;
  const char *instance_name = nullptr;

  if (TryGetPlatFormInfos(fe::PlatformInfoManager::Instance(), platform_infos, source)) {
    instance_name = "Instance";
  } else if (TryGetPlatFormInfos(fe::PlatformInfoManager::GeInstance(), platform_infos, source)) {
    instance_name = "GeInstance";
  }

  if (instance_name != nullptr) {
    PF_LOGD("GetPlatFormInfos succeeded: source=%s, path=%s.", instance_name, source.c_str());
    return true;
  }

  PF_LOGE("Failed to obtain PlatFormInfos via Instance/GeInstance device[0] or OptionalInfos.");
  return false;
}

const std::vector<std::pair<std::string, std::string>> kDevInfoTable = {
  /* 0: ACL_PLATFORM_AICORE_CNT        */ {"SoCInfo",        "ai_core_cnt"},
  /* 1: ACL_PLATFORM_AICORE_UB_SIZE    */ {"AICoreSpec",     "ub_size"},
  /* 2: ACL_PLATFORM_CUBE_CORE_CNT     */ {"SoCInfo",        "cube_core_cnt"},
  /* 3: ACL_PLATFORM_VECTOR_CORE_CNT   */ {"SoCInfo",        "vector_core_cnt"},
  /* 4: ACL_PLATFORM_L2_SIZE           */ {"SoCInfo",        "l2_size"},
  /* 5: ACL_PLATFORM_MEMORY_SIZE       */ {"SoCInfo",        "memory_size"},
  /* 6: ACL_PLATFORM_CUBE_FREQ         */ {"AICoreSpec",     "cube_freq"},
  /* 7: ACL_PLATFORM_VEC_FREQ          */ {"VectorCoreSpec", "vec_freq"},
  /* 8: ACL_PLATFORM_BT_SIZE           */ {"AICoreSpec",     "bt_size"},
  /* 9: ACL_PLATFORM_L0_A_SIZE         */ {"AICoreSpec",     "l0_a_size"},
  /* 10: ACL_PLATFORM_L0_B_SIZE        */ {"AICoreSpec",     "l0_b_size"},
  /* 11: ACL_PLATFORM_L0_C_SIZE        */ {"AICoreSpec",     "l0_c_size"},
  /* 12: ACL_PLATFORM_L1_SIZE          */ {"AICoreSpec",     "l1_size"},
  /* 13: ACL_PLATFORM_SOC_VERSION      */ {"version",       "SoC_version"},
  /* 14: ACL_PLATFORM_AIC_VERSION      */ {"version",       "AIC_version"},
  /* 15: ACL_PLATFORM_NPU_ARCH         */ {"version",        "NpuArch"},
  /* 16: ACL_PLATFORM_MEMORY_TYPE      */ {"SoCInfo",        "memory_type"},
};
}  // namespace

aclError aclplatformGetDeviceInfo(aclplatformDevInfo infoType, char *value, uint32_t maxLen)
{
  // --- parameter validation ---
  const uint32_t info_idx = static_cast<uint32_t>(infoType);
  if (info_idx >= static_cast<uint32_t>(kDevInfoTable.size())) {
    PF_LOGE("Invalid info type %u.", info_idx);
    return ACL_ERROR_INVALID_PARAM;
  }
  if (value == nullptr) {
    PF_LOGE("Device info: output buffer pointer is NULL.");
    return ACL_ERROR_INVALID_PARAM;
  }
  if (maxLen == 0U) {
    PF_LOGE("Device info: output buffer length is 0.");
    return ACL_ERROR_INVALID_PARAM;
  }

  // --- obtain platform info ---
  fe::PlatFormInfos platform_infos;
  if (!GetPlatFormInfos(platform_infos)) {
    return ACL_ERROR_INTERNAL_ERROR;
  }

  // --- query the value ---
  const std::string &section = kDevInfoTable[info_idx].first;
  const std::string &key     = kDevInfoTable[info_idx].second;
  std::string result;

  if (!platform_infos.GetPlatformResWithLock(section, key, result)) {
    PF_LOGE("Key [%s/%s] not found in platform info.", section.c_str(), key.c_str());
    return ACL_ERROR_INVALID_PARAM;
  }
  if (result.empty()) {
    PF_LOGE("Empty result for key [%s/%s].", section.c_str(), key.c_str());
    return ACL_ERROR_INVALID_PARAM;
  }

  PF_LOGI("Device info queried: [%s, %s] = %s.", section.c_str(), key.c_str(), result.c_str());
  return CopyToBuffer(result, value, maxLen);
}

aclError aclplatformGetInstructionInfo(aclplatformCoreType type,
                                       const char *instruction,
                                       char *value,
                                       uint32_t maxLen)
{
  // --- parameter validation ---
  if (type != ACL_PLATFORM_CORE_TYPE_AI_CORE && type != ACL_PLATFORM_CORE_TYPE_VECTOR_CORE) {
    PF_LOGE("Invalid core type %d.", static_cast<int>(type));
    return ACL_ERROR_INVALID_PARAM;
  }
  if (instruction == nullptr) {
    PF_LOGE("Instruction info: instruction pointer is NULL.");
    return ACL_ERROR_INVALID_PARAM;
  }
  if (value == nullptr) {
    PF_LOGE("Instruction info: output buffer pointer is NULL.");
    return ACL_ERROR_INVALID_PARAM;
  }
  if (maxLen == 0U) {
    PF_LOGE("Instruction info: output buffer length is 0.");
    return ACL_ERROR_INVALID_PARAM;
  }

  // --- obtain platform info ---
  fe::PlatFormInfos platform_infos;
  if (!GetPlatFormInfos(platform_infos)) {
    return ACL_ERROR_INTERNAL_ERROR;
  }

  // --- query intrinsic dtype map ---
  const std::string instr_name(instruction);
  std::map<std::string, std::vector<std::string>> intrinsic_map;

  if (type == ACL_PLATFORM_CORE_TYPE_AI_CORE) {
    intrinsic_map = platform_infos.GetAICoreIntrinsicDtype();
  } else {
    intrinsic_map = platform_infos.GetVectorCoreIntrinsicDtype();
  }

  const auto it = intrinsic_map.find(instr_name);
  if (it == intrinsic_map.end() || it->second.empty()) {
    PF_LOGE("Instruction [%s] not found for core type %d.",
            instruction, static_cast<int>(type));
    return ACL_ERROR_INVALID_PARAM;
  }

  // --- join dtypes with "," ---
  std::string result;
  const std::vector<std::string> &dtypes = it->second;
  for (size_t i = 0U; i < dtypes.size(); ++i) {
    if (i > 0U) {
      result += ',';
    }
    result += dtypes[i];
  }

  PF_LOGI("Instruction info queried: [%s], core[%d], result = %s.",
         instruction, static_cast<int>(type), result.c_str());
  return CopyToBuffer(result, value, maxLen);
}
