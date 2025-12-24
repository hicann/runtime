/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "platform_infos_lite_impl.h"
#include "platform_log.h"

using namespace std;

namespace fe {
namespace {
const uint64_t INVALID_VALUE = UINT64_MAX;
const set<string> STRING_VALUE_KEY = {
    "SoC_version", "Short_SoC_version", "AIC_version", "CCEC_AIC_version", "CCEC_AIV_version", "CCEC_CUBE_version",
    "CCEC_VECTOR_version",
    "Compiler_aicpu_support_os", "core_type_list", "cube_vector_mix", "cube_vector_combine", "vir_type_list",
    "ffts_mode", "hardware_sync_betweencore"
};

const std::map<std::string, IntrinsicAbility> INTRINSIC_ABILITY_STR_MAP = {
    {"add", IntrinsicAbility::add},
    {"anti_quant_add", IntrinsicAbility::anti_quant_add},
    {"anti_quant_sub", IntrinsicAbility::anti_quant_sub},
    {"b8u2", IntrinsicAbility::b8u2},
    {"bb", IntrinsicAbility::bb},
    {"bf16", IntrinsicAbility::bf16},
    {"bf162f32", IntrinsicAbility::bf162f32},
    {"bf162s32a", IntrinsicAbility::bf162s32a},
    {"bf162s32c", IntrinsicAbility::bf162s32c},
    {"bf162s32f", IntrinsicAbility::bf162s32f},
    {"bf162s32r", IntrinsicAbility::bf162s32r},
    {"bf162s32z", IntrinsicAbility::bf162s32z},
    {"bs16", IntrinsicAbility::bs16},
    {"bs32", IntrinsicAbility::bs32},
    {"bs8", IntrinsicAbility::bs8},
    {"bu16", IntrinsicAbility::bu16},
    {"bu32", IntrinsicAbility::bu32},
    {"bu8", IntrinsicAbility::bu8},
    {"cast", IntrinsicAbility::cast},
    {"clip_relu", IntrinsicAbility::clip_relu},
    {"deq", IntrinsicAbility::deq},
    {"deqs322f16", IntrinsicAbility::deqs322f16},
    {"dequant", IntrinsicAbility::dequant},
    {"f16", IntrinsicAbility::f16},
    {"f162f16", IntrinsicAbility::f162f16},
    {"f162f32", IntrinsicAbility::f162f32},
    {"f162s16", IntrinsicAbility::f162s16},
    {"f162s16a", IntrinsicAbility::f162s16a},
    {"f162s16c", IntrinsicAbility::f162s16c},
    {"f162s16f", IntrinsicAbility::f162s16f},
    {"f162s16r", IntrinsicAbility::f162s16r},
    {"f162s16z", IntrinsicAbility::f162s16z},
    {"f162s32a", IntrinsicAbility::f162s32a},
    {"f162s32c", IntrinsicAbility::f162s32c},
    {"f162s32f", IntrinsicAbility::f162s32f},
    {"f162s32r", IntrinsicAbility::f162s32r},
    {"f162s32z", IntrinsicAbility::f162s32z},
    {"f162s4", IntrinsicAbility::f162s4},
    {"f162s8", IntrinsicAbility::f162s8},
    {"f162s8a", IntrinsicAbility::f162s8a},
    {"f162s8c", IntrinsicAbility::f162s8c},
    {"f162s8f", IntrinsicAbility::f162s8f},
    {"f162s8r", IntrinsicAbility::f162s8r},
    {"f162s8z", IntrinsicAbility::f162s8z},
    {"f162u8", IntrinsicAbility::f162u8},
    {"f162u8a", IntrinsicAbility::f162u8a},
    {"f162u8c", IntrinsicAbility::f162u8c},
    {"f162u8f", IntrinsicAbility::f162u8f},
    {"f162u8r", IntrinsicAbility::f162u8r},
    {"f162u8z", IntrinsicAbility::f162u8z},
    {"f16f16", IntrinsicAbility::f16f16},
    {"f16f16f16", IntrinsicAbility::f16f16f16},
    {"f16f16s4", IntrinsicAbility::f16f16s4},
    {"f16f16s8", IntrinsicAbility::f16f16s8},
    {"f16f16u16", IntrinsicAbility::f16f16u16},
    {"f16f16u2", IntrinsicAbility::f16f16u2},
    {"f16f32", IntrinsicAbility::f16f32},
    {"f16s16", IntrinsicAbility::f16s16},
    {"f16s32", IntrinsicAbility::f16s32},
    {"f16s32s32", IntrinsicAbility::f16s32s32},
    {"f16s8", IntrinsicAbility::f16s8},
    {"f16u16", IntrinsicAbility::f16u16},
    {"f16u16f16", IntrinsicAbility::f16u16f16},
    {"f16u2", IntrinsicAbility::f16u2},
    {"f16u8", IntrinsicAbility::f16u8},
    {"f32", IntrinsicAbility::f32},
    {"f322bf16", IntrinsicAbility::f322bf16},
    {"f322bf16a", IntrinsicAbility::f322bf16a},
    {"f322bf16c", IntrinsicAbility::f322bf16c},
    {"f322bf16f", IntrinsicAbility::f322bf16f},
    {"f322bf16r", IntrinsicAbility::f322bf16r},
    {"f322bf16z", IntrinsicAbility::f322bf16z},
    {"f322f16", IntrinsicAbility::f322f16},
    {"f322f16a", IntrinsicAbility::f322f16a},
    {"f322f16c", IntrinsicAbility::f322f16c},
    {"f322f16f", IntrinsicAbility::f322f16f},
    {"f322f16o", IntrinsicAbility::f322f16o},
    {"f322f16r", IntrinsicAbility::f322f16r},
    {"f322f16z", IntrinsicAbility::f322f16z},
    {"f322f32", IntrinsicAbility::f322f32},
    {"f322f32a", IntrinsicAbility::f322f32a},
    {"f322f32c", IntrinsicAbility::f322f32c},
    {"f322f32f", IntrinsicAbility::f322f32f},
    {"f322f32r", IntrinsicAbility::f322f32r},
    {"f322f32z", IntrinsicAbility::f322f32z},
    {"f322s16a", IntrinsicAbility::f322s16a},
    {"f322s16c", IntrinsicAbility::f322s16c},
    {"f322s16f", IntrinsicAbility::f322s16f},
    {"f322s16r", IntrinsicAbility::f322s16r},
    {"f322s16z", IntrinsicAbility::f322s16z},
    {"f322s32a", IntrinsicAbility::f322s32a},
    {"f322s32c", IntrinsicAbility::f322s32c},
    {"f322s32f", IntrinsicAbility::f322s32f},
    {"f322s32r", IntrinsicAbility::f322s32r},
    {"f322s32z", IntrinsicAbility::f322s32z},
    {"f322s4", IntrinsicAbility::f322s4},
    {"f322s64a", IntrinsicAbility::f322s64a},
    {"f322s64c", IntrinsicAbility::f322s64c},
    {"f322s64f", IntrinsicAbility::f322s64f},
    {"f322s64r", IntrinsicAbility::f322s64r},
    {"f322s64z", IntrinsicAbility::f322s64z},
    {"f322s8", IntrinsicAbility::f322s8},
    {"f322u8", IntrinsicAbility::f322u8},
    {"f32f16", IntrinsicAbility::f32f16},
    {"f32f16f16", IntrinsicAbility::f32f16f16},
    {"f32f32", IntrinsicAbility::f32f32},
    {"f32f32f32", IntrinsicAbility::f32f32f32},
    {"f32s16", IntrinsicAbility::f32s16},
    {"f32s32", IntrinsicAbility::f32s32},
    {"f32u32", IntrinsicAbility::f32u32},
    {"f32u32f32", IntrinsicAbility::f32u32f32},
    {"float16", IntrinsicAbility::float16},
    {"float32", IntrinsicAbility::float32},
    {"h322f32", IntrinsicAbility::h322f32},
    {"int16", IntrinsicAbility::int16},
    {"int32", IntrinsicAbility::int32},
    {"int64", IntrinsicAbility::int64},
    {"int8", IntrinsicAbility::int8},
    {"normal_relu", IntrinsicAbility::normal_relu},
    {"nz2nd", IntrinsicAbility::nz2nd},
    {"post_act", IntrinsicAbility::post_act},
    {"post_eltwise", IntrinsicAbility::post_eltwise},
    {"post_quant", IntrinsicAbility::post_quant},
    {"post_transform", IntrinsicAbility::post_transform},
    {"pre_act", IntrinsicAbility::pre_act},
    {"pre_conv", IntrinsicAbility::pre_conv},
    {"quant", IntrinsicAbility::quant},
    {"requant", IntrinsicAbility::requant},
    {"s16", IntrinsicAbility::s16},
    {"s162f16", IntrinsicAbility::s162f16},
    {"s162f16a", IntrinsicAbility::s162f16a},
    {"s162f16c", IntrinsicAbility::s162f16c},
    {"s162f16f", IntrinsicAbility::s162f16f},
    {"s162f16r", IntrinsicAbility::s162f16r},
    {"s162f16z", IntrinsicAbility::s162f16z},
    {"s162f32", IntrinsicAbility::s162f32},
    {"s162s16", IntrinsicAbility::s162s16},
    {"s162s32", IntrinsicAbility::s162s32},
    {"s162s8", IntrinsicAbility::s162s8},
    {"s162u32", IntrinsicAbility::s162u32},
    {"s162u8", IntrinsicAbility::s162u8},
    {"s16f16", IntrinsicAbility::s16f16},
    {"s16f32", IntrinsicAbility::s16f32},
    {"s16s16", IntrinsicAbility::s16s16},
    {"s16s16u16", IntrinsicAbility::s16s16u16},
    {"s16s32", IntrinsicAbility::s16s32},
    {"s16s48", IntrinsicAbility::s16s48},
    {"s16s64", IntrinsicAbility::s16s64},
    {"s16s8", IntrinsicAbility::s16s8},
    {"s16u16", IntrinsicAbility::s16u16},
    {"s16u16s16", IntrinsicAbility::s16u16s16},
    {"s16u16s8", IntrinsicAbility::s16u16s8},
    {"s16u32", IntrinsicAbility::s16u32},
    {"s16u8", IntrinsicAbility::s16u8},
    {"s24s16", IntrinsicAbility::s24s16},
    {"s24s8", IntrinsicAbility::s24s8},
    {"s24u16", IntrinsicAbility::s24u16},
    {"s24u8", IntrinsicAbility::s24u8},
    {"s32", IntrinsicAbility::s32},
    {"s322f16", IntrinsicAbility::s322f16},
    {"s322f32", IntrinsicAbility::s322f32},
    {"s322f32a", IntrinsicAbility::s322f32a},
    {"s322f32c", IntrinsicAbility::s322f32c},
    {"s322f32f", IntrinsicAbility::s322f32f},
    {"s322f32r", IntrinsicAbility::s322f32r},
    {"s322f32z", IntrinsicAbility::s322f32z},
    {"s322s16", IntrinsicAbility::s322s16},
    {"s322s4", IntrinsicAbility::s322s4},
    {"s322s64", IntrinsicAbility::s322s64},
    {"s322s8", IntrinsicAbility::s322s8},
    {"s322u16", IntrinsicAbility::s322u16},
    {"s322u8", IntrinsicAbility::s322u8},
    {"s32f32", IntrinsicAbility::s32f32},
    {"s32s16", IntrinsicAbility::s32s16},
    {"s32s32", IntrinsicAbility::s32s32},
    {"s32s4s4", IntrinsicAbility::s32s4s4},
    {"s32s8s8", IntrinsicAbility::s32s8s8},
    {"s32u16", IntrinsicAbility::s32u16},
    {"s32u32", IntrinsicAbility::s32u32},
    {"s32u32s32", IntrinsicAbility::s32u32s32},
    {"s32u8", IntrinsicAbility::s32u8},
    {"s32u8s8", IntrinsicAbility::s32u8s8},
    {"s32u8u2", IntrinsicAbility::s32u8u2},
    {"s32u8u8", IntrinsicAbility::s32u8u8},
    {"s4", IntrinsicAbility::s4},
    {"s48s16", IntrinsicAbility::s48s16},
    {"s48s32", IntrinsicAbility::s48s32},
    {"s48u16", IntrinsicAbility::s48u16},
    {"s642f32a", IntrinsicAbility::s642f32a},
    {"s642f32c", IntrinsicAbility::s642f32c},
    {"s642f32f", IntrinsicAbility::s642f32f},
    {"s642f32r", IntrinsicAbility::s642f32r},
    {"s642f32z", IntrinsicAbility::s642f32z},
    {"s642s32", IntrinsicAbility::s642s32},
    {"s64s32", IntrinsicAbility::s64s32},
    {"s8", IntrinsicAbility::s8},
    {"s82f16", IntrinsicAbility::s82f16},
    {"s82s16", IntrinsicAbility::s82s16},
    {"s82s32", IntrinsicAbility::s82s32},
    {"s82s8", IntrinsicAbility::s82s8},
    {"s8f16", IntrinsicAbility::s8f16},
    {"s8f16f16", IntrinsicAbility::s8f16f16},
    {"s8s16", IntrinsicAbility::s8s16},
    {"s8s24", IntrinsicAbility::s8s24},
    {"s8s32", IntrinsicAbility::s8s32},
    {"s8s48", IntrinsicAbility::s8s48},
    {"s8s8", IntrinsicAbility::s8s8},
    {"s8s8u8", IntrinsicAbility::s8s8u8},
    {"s8u16", IntrinsicAbility::s8u16},
    {"scalar_relu", IntrinsicAbility::scalar_relu},
    {"sub", IntrinsicAbility::sub},
    {"u16", IntrinsicAbility::u16},
    {"u162s32", IntrinsicAbility::u162s32},
    {"u162u32", IntrinsicAbility::u162u32},
    {"u162u8", IntrinsicAbility::u162u8},
    {"u16s16", IntrinsicAbility::u16s16},
    {"u16s48", IntrinsicAbility::u16s48},
    {"u16s64", IntrinsicAbility::u16s64},
    {"u16u16", IntrinsicAbility::u16u16},
    {"u16u16u16", IntrinsicAbility::u16u16u16},
    {"u16u16u8", IntrinsicAbility::u16u16u8},
    {"u16u32", IntrinsicAbility::u16u32},
    {"u16u8", IntrinsicAbility::u16u8},
    {"u32", IntrinsicAbility::u32},
    {"u322s16", IntrinsicAbility::u322s16},
    {"u322u16", IntrinsicAbility::u322u16},
    {"u322u8", IntrinsicAbility::u322u8},
    {"u32s16", IntrinsicAbility::u32s16},
    {"u32s32", IntrinsicAbility::u32s32},
    {"u32u16", IntrinsicAbility::u32u16},
    {"u32u32", IntrinsicAbility::u32u32},
    {"u32u32u32", IntrinsicAbility::u32u32u32},
    {"u32u8", IntrinsicAbility::u32u8},
    {"u32u8u8", IntrinsicAbility::u32u8u8},
    {"u8", IntrinsicAbility::u8},
    {"u82f16", IntrinsicAbility::u82f16},
    {"u82s16", IntrinsicAbility::u82s16},
    {"u82s32", IntrinsicAbility::u82s32},
    {"u82u16", IntrinsicAbility::u82u16},
    {"u82u32", IntrinsicAbility::u82u32},
    {"u8f16", IntrinsicAbility::u8f16},
    {"u8f16f16", IntrinsicAbility::u8f16f16},
    {"u8s16", IntrinsicAbility::u8s16},
    {"u8s24", IntrinsicAbility::u8s24},
    {"u8s48", IntrinsicAbility::u8s48},
    {"u8s8", IntrinsicAbility::u8s8},
    {"u8u16", IntrinsicAbility::u8u16},
    {"u8u32", IntrinsicAbility::u8u32},
    {"u8u8", IntrinsicAbility::u8u8},
    {"u8u8u8", IntrinsicAbility::u8u8u8},
    {"uint16", IntrinsicAbility::uint16},
    {"uint32", IntrinsicAbility::uint32},
    {"uint64", IntrinsicAbility::uint64},
    {"uint8", IntrinsicAbility::uint8},
    {"vdeqs162b8", IntrinsicAbility::vdeqs162b8},
    {"vector_relu", IntrinsicAbility::vector_relu},
    {"e4m3e4m3", IntrinsicAbility::e4m3e4m3},
    {"e4m3e5m2", IntrinsicAbility::e4m3e5m2},
    {"e5m2e4m3", IntrinsicAbility::e5m2e4m3},
    {"e5m2e5m2", IntrinsicAbility::e5m2e5m2},
    {"s32s8s4", IntrinsicAbility::s32s8s4},
    {"s32s16s8", IntrinsicAbility::s32s16s8},
};
}


void PlatFormInfosLiteImpl::InitializeSingleNormal(PlatFormInfos& oldPlatformInfos,
                                                   const string &labelName,
                                                   const std::vector<std::string> &keyNameVec) {

  normal_infos_.emplace_back();
  auto &back = normal_infos_.back();
  std::map<string, string> original_key_value_map;
  oldPlatformInfos.GetPlatformRes(labelName, original_key_value_map);
  for (const auto &keyName : keyNameVec) {
    auto iter = original_key_value_map.find(keyName);
    if (iter == original_key_value_map.end()) {
      PF_LOGD("Cannot find key %s in old platform infos, label %s.",
              keyName.c_str(), labelName.c_str());
      back.emplace_back(INVALID_VALUE);
    } else {
      if (STRING_VALUE_KEY.count(keyName) != 0) {
        PF_LOGD("Do not support parse string value of label %s, key %s.",
                labelName.c_str(), keyName.c_str());
        back.emplace_back(INVALID_VALUE);
      } else {
        back.emplace_back(static_cast<uint64_t>(std::atoi(iter->second.c_str())));
      }
    }
  }
}

bool PlatFormInfosLiteImpl::InitializeSingleIntrinsic(PlatFormInfos& oldPlatformInfos,
                                                      size_t i, const string &labelName,
                                                      const std::vector<std::string> &keyNameVec) {
  intrinsic_infos_.emplace_back();
  auto &back = intrinsic_infos_.back();
  std::map<std::string, std::vector<std::string>> intrinsic_map;
  if (i == static_cast<size_t>(PlatformLabel::ENUM_AI_CORE_INTRINSIC_DTYPE_MAP)) {
    intrinsic_map = oldPlatformInfos.GetAICoreIntrinsicDtype();
  } else {
    intrinsic_map = oldPlatformInfos.GetVectorCoreIntrinsicDtype();
  }
  for (const auto &keyName : keyNameVec) {
    auto iter = intrinsic_map.find(keyName);
    if (iter == intrinsic_map.end()) {
      continue;
    } else {
      for (auto &dtype_str: iter->second) {
        auto iter_ability = INTRINSIC_ABILITY_STR_MAP.find(dtype_str);
        if (iter_ability == INTRINSIC_ABILITY_STR_MAP.end()) {
          PF_LOGE("Cannot find string value %s of label %s, key %s.",
                  dtype_str.c_str(), keyName.c_str(), labelName.c_str());
          return false;
        } else {
          back.emplace(iter_ability->second);
        }
      }
    }
  }
  return true;
}

bool PlatFormInfosLiteImpl::InitPlatFormInfosLite(SocVersion soc_version, PlatFormInfos& old_platform_infos) {
  if (init_) {
    return true;
  }
  soc_version_ = soc_version;
  if (NORMAL_LABEL_SIZE >= LABEL_AND_KEYS.size()) {
    PF_LOGE("NORMAL_LABEL_SIZE %zu is larger than NORMAL_LABEL_KEY_NAME size %zu.",
            NORMAL_LABEL_SIZE, LABEL_AND_KEYS.size());
    return false;
  }

  for (size_t i = 0; i < NORMAL_LABEL_SIZE; ++i) {
    auto &label_and_key = LABEL_AND_KEYS[i];
    InitializeSingleNormal(old_platform_infos, label_and_key.pair.first,
                                      label_and_key.pair.second);
  }

  bool ret;
  for (size_t i = NORMAL_LABEL_SIZE; i < ALL_LABEL_SIZE; ++i) {
    auto &label_and_key = LABEL_AND_KEYS[i];
    ret = InitializeSingleIntrinsic(old_platform_infos, i, label_and_key.pair.first,
                                    label_and_key.pair.second);
    if (!ret) {
      return ret;
    }
  }
  init_ = true;
  return true;
}

bool PlatFormInfosLiteImpl::GetPlatformRes(PlatformLabel label, uint64_t key, uint64_t &val) {
  if (label < PlatformLabel::ENUM_AI_CORE_INTRINSIC_DTYPE_MAP &&
      static_cast<size_t>(label) < normal_infos_.size()) {
    const auto &label_infos = normal_infos_[static_cast<size_t>(label)];
    if (key >= label_infos.size()) {
      return false;
    } else {
      val = label_infos.at(key);
      return true;
    }
  } else {
    return false;
  }
}

const std::vector<uint64_t> &PlatFormInfosLiteImpl::GetPlatformRes(PlatformLabel label) {
  if (label < PlatformLabel::ENUM_AI_CORE_INTRINSIC_DTYPE_MAP &&
      static_cast<size_t>(label) < normal_infos_.size()) {
    return normal_infos_[static_cast<size_t>(label)];
  } else {
    PF_LOGE("PlatformLabel %d is invalid. The size of the normal info is %zu.", label,
            normal_infos_.size());
    return normal_infos_[0];
  }
}

bool PlatFormInfosLiteImpl::CheckIntrinsicSupport(IntrinsicTypeKey intrinsic_type,
                                                  IntrinsicAbility intrinsic_ability) const {
  if (static_cast<size_t>(intrinsic_type) >= intrinsic_infos_.size()) {
    return false;
  }
  if (intrinsic_infos_[static_cast<size_t>(intrinsic_type)].count(intrinsic_ability) != 0) {
    return true;
  } else {
    return false;
  }
}
}