/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "platform/platform_infos_def.h"
#include "platform_infos_impl.h"
#include "platform_log.h"
#ifndef _OPEN_SOURCE_LLT_
#include "proto/platform_infos.pb.h"
#endif
#include "platform_infos_utils.h"
#include <unordered_set>

using std::map;
using std::vector;
using std::string;
using namespace std;

namespace fe {
using ProtoBufString = std::string;
#ifndef _OPEN_SOURCE_LLT_
using ProtoListDType = platform::tiling::ListDType;
using ProtoPlatformMap = platform::tiling::PlatformMap;
using ProtoBufStringVecMap = ascend_private::protobuf::Map<ProtoBufString, ProtoListDType>;
using ProtoBufStringMapMap = ascend_private::protobuf::Map<ProtoBufString, ProtoPlatformMap>;
#endif
PlatFormInfosImplPtr g_platformInfosImplInstance;

bool PlatFormInfos::Init() {
  platform_infos_impl_ = make_shared<PlatFormInfosImpl>();
  if (platform_infos_impl_ == nullptr) {
    return false;
  }

  return true;
}

#ifndef _OPEN_SOURCE_LLT_
static void GetVecMapInfoFromProtoBuf(ProtoBufStringVecMap *protoMap,
                               std::map<std::string, std::vector<std::string>> &dstMap) {
  for (auto mapIter = protoMap->begin(); mapIter != protoMap->end(); ++mapIter) {
    const std::string curMapKey = mapIter->first;
    PF_LOGD("curMapKey:%s", curMapKey.c_str());
    std::vector<std::string> tempVec;
    for (auto index = 0; index < mapIter->second.dtype_size(); index++) {
      tempVec.push_back(mapIter->second.dtype(index));
      PF_LOGD("insert value:%s", mapIter->second.dtype(index).c_str());
    }
    dstMap[curMapKey] = tempVec;
  }
}

static void GetMapMapInfoFromProtoBuf(ProtoBufStringMapMap *protoMap,
                               std::map<std::string, std::map<std::string, std::string>> &dstMap) {
  for (auto mapIter = protoMap->begin(); mapIter != protoMap->end(); ++mapIter) {
    const std::string curMapKey = mapIter->first;
    PF_LOGD("curMapKey:%s", curMapKey.c_str());
    std::map<std::string, std::string> tempMap;
    ProtoPlatformMap &protoTmpMap = mapIter->second;
    for (auto secondIter = protoTmpMap.platform_map().begin();
      secondIter != protoTmpMap.platform_map().end(); ++secondIter) {
      tempMap[secondIter->first] = secondIter->second;
      PF_LOGD("insert key:%s, value:%s", secondIter->first.c_str(), secondIter->second.c_str());
    }
    dstMap[curMapKey] = tempMap;
  }
}
#endif

map<string, vector<string>> PlatFormInfos::GetAICoreIntrinsicDtype() {
  if (platform_infos_impl_ == nullptr) {
    return map<string, vector<string>>();
  }
  return platform_infos_impl_->GetAICoreIntrinsicDtype();
}

map<string, vector<string>> PlatFormInfos::GetVectorCoreIntrinsicDtype() {
  if (platform_infos_impl_ == nullptr) {
    return map<string, vector<string>>();
  }
  return platform_infos_impl_->GetVectorCoreIntrinsicDtype();
}

bool PlatFormInfos::GetPlatformRes(const string &label, const string &key, string &val) {
  if (platform_infos_impl_ == nullptr) {
    return true;
  }
  return platform_infos_impl_->GetPlatformRes(label, key, val);
}

bool PlatFormInfos::GetPlatformResWithLock(const string &label, const string &key, string &val) {
  std::lock_guard<std::mutex> lock_guard(plt_mutex);
  if (platform_infos_impl_ == nullptr) {
    return true;
  }
  return platform_infos_impl_->GetPlatformRes(label, key, val);
}

bool PlatFormInfos::GetPlatformRes(const std::string &label, std::map<std::string, std::string> &res) {
  if (platform_infos_impl_ == nullptr) {
    return true;
  }
  return platform_infos_impl_->GetPlatformRes(label, res);
}

bool PlatFormInfos::GetPlatformResWithLock(const std::string &label, std::map<std::string, std::string> &res) {
  std::lock_guard<std::mutex> lock_guard(plt_mutex);
  if (platform_infos_impl_ == nullptr) {
    return true;
  }
  return platform_infos_impl_->GetPlatformRes(label, res);
}

bool PlatFormInfos::GetPlatformResWithLock(std::map<std::string, std::map<std::string, std::string>> &res) {
  std::lock_guard<std::mutex> lock_guard(plt_mutex);
  if (platform_infos_impl_ == nullptr) {
    return true;
  }
  return platform_infos_impl_->GetPlatformRes(res);
}

void PlatFormInfos::SetAICoreIntrinsicDtype(map<string, vector<string>> &intrinsic_dtypes) {
  if (platform_infos_impl_ == nullptr) {
    return;
  }
  platform_infos_impl_->SetAICoreIntrinsicDtype(intrinsic_dtypes);
}

void PlatFormInfos::SetVectorCoreIntrinsicDtype(map<string, vector<string>> &intrinsic_dtypes) {
  if (platform_infos_impl_ == nullptr) {
    return;
  }
  platform_infos_impl_->SetVectorCoreIntrinsicDtype(intrinsic_dtypes);
}

void PlatFormInfos::SetFixPipeDtypeMap(const std::map<std::string, std::vector<std::string>> &fixpipe_dtype_map) {
  if (platform_infos_impl_ == nullptr) {
    return;
  }
  platform_infos_impl_->SetFixPipeDtypeMap(fixpipe_dtype_map);
}

void PlatFormInfos::SetCoreNumByCoreType(const std::string &core_type) {
    string core_num_str;
    string core_type_str;
    /*
    all core_types: NO_MIX(AIV,AIC)
                    MIX_AIV,MIX_AIC
                    MIX_AIC_AIV
                    MIX(customized for multi-kernelType)
    */
    std::unordered_set<string> vector_core_types = {"VectorCore", "AIV", "MIX_AIV", "MIX_VECTOR_CORE"};
    std::unordered_set<string> customized_types = {"MIX_AIC_AIV", "MIX_AIV", "MIX", "MIX_AICORE", "MIX_VECTOR_CORE"};
    if (vector_core_types.count(core_type) > 0) {
      core_type_str = "vector_core_cnt";
    } else {
      core_type_str = "ai_core_cnt";
    }

    std::lock_guard<std::mutex> lock_guard(plt_mutex);
    try {
      (void)GetPlatformRes("SoCInfo", core_type_str, core_num_str);
      core_num_ = core_num_str.empty() ? 0 : std::stoi(core_num_str.c_str());
      if (customized_types.count(core_type) > 0) {
        core_num_str.clear();
        core_type_str = "mix_vector_core_cnt";
        (void)GetPlatformRes("SoCInfo", core_type_str, core_num_str);
        core_num_ = core_num_str.empty() ? core_num_ : std::stoi(core_num_str.c_str());
      }
    } catch (...) {
      PF_LOGW("Unable to load core_num[%s].", core_num_str.c_str());
    }
    PF_LOGD("Set PlatFormInfos::core_num_ to %s: [%u], core_type: %s.",
            core_type_str.c_str(), core_num_, core_type.c_str());
}

void PlatFormInfos::SetCoreNum(const uint32_t &core_num) {
  std::lock_guard<std::mutex> lock_guard(plt_mutex);
  PF_LOGD("Set PlatFormInfos::core_num_ to %u.", core_num);
  core_num_ = core_num;
}

uint32_t PlatFormInfos::GetCoreNum() const {
  std::lock_guard<std::mutex> lock_guard(plt_mutex);
  PF_LOGD("Get PlatformInfos::core_num_=[%u].", core_num_);
  return core_num_;
}

uint32_t PlatFormInfos::GetCoreNumWithLock() const {
  std::lock_guard<std::mutex> lock_guard(plt_mutex);
  PF_LOGD("Get PlatformInfos::core_num_=[%u].", core_num_);
  return core_num_;
}

uint32_t PlatFormInfos::GetCoreNumByType(const std::string &core_type)
{
    std::unordered_set<string> vector_core_types = {"VectorCore", "AIV"};
    std::string core_type_str;
    if (vector_core_types.count(core_type) != 0) {
        core_type_str = "vector_core_cnt";
    } else {
        core_type_str = "ai_core_cnt";
    }

    std::lock_guard<std::mutex> lock_guard(plt_mutex);
    std::string core_num_str;
    uint32_t core_num = 0;
    try {
        (void)GetPlatformRes("SoCInfo", core_type_str, core_num_str);
        core_num = core_num_str.empty() ? 0 : std::stoi(core_num_str.c_str());
    } catch (...) {
        PF_LOGW("Unable to load core_num[%s].", core_num_str.c_str());
        return -1;
    }
    PF_LOGD("Get PlatFormInfos::core_num %u|%s, core_type %s", core_num, core_num_str.c_str(), core_type.c_str());
    return core_num;
}

void PlatFormInfos::GetLocalMemSize(const LocalMemType &mem_type, uint64_t &size) {
  string size_str;
  switch (mem_type) {
    case LocalMemType::L0_A:
      (void)GetPlatformResWithLock("AICoreSpec", "l0_a_size", size_str);
      break;
    case LocalMemType::L0_B:
      (void)GetPlatformResWithLock("AICoreSpec", "l0_b_size", size_str);
      break;
    case LocalMemType::L0_C:
      (void)GetPlatformResWithLock("AICoreSpec", "l0_c_size", size_str);
      break;
    case LocalMemType::L1:
      (void)GetPlatformResWithLock("AICoreSpec", "l1_size", size_str);
      break;
    case LocalMemType::L2:
      (void)GetPlatformResWithLock("SoCInfo", "l2_size", size_str);
      break;
    case LocalMemType::UB:
      (void)GetPlatformResWithLock("AICoreSpec", "ub_size", size_str);
      break;
    case LocalMemType::HBM:
      (void)GetPlatformResWithLock("SoCInfo", "memory_size", size_str);
      break;
    default:
      break;
  }
  size = size_str.empty() ? 0 : std::atoll(size_str.c_str());
}

void PlatFormInfos:: GetLocalMemBw(const LocalMemType &mem_type, uint64_t &bw_size) {
  string bw_size_str;
  switch (mem_type) {
    case LocalMemType::L2:
      (void) GetPlatformResWithLock("AICoreMemoryRates", "l2_rate", bw_size_str);
      break;
    case LocalMemType::HBM:
      (void) GetPlatformResWithLock("AICoreMemoryRates", "ddr_rate", bw_size_str);
      break;
    default:
      break;
  }
  bw_size = bw_size_str.empty() ? 0 : std::atoll(bw_size_str.c_str());
}

std::map<std::string, std::vector<std::string>>  PlatFormInfos::GetFixPipeDtypeMap() {
  if (platform_infos_impl_ == nullptr) {
    return map<string, vector<string>>();
  }
  return platform_infos_impl_->GetFixPipeDtypeMap();
}

void PlatFormInfos::SetPlatformRes(const std::string &label, std::map<std::string, std::string> &res) {
  if (platform_infos_impl_ == nullptr) {
    return;
  }
  platform_infos_impl_->SetPlatformRes(label, res);
}

void PlatFormInfos::SetPlatformResWithLock(const std::string &label, std::map<std::string, std::string> &res) {
  std::lock_guard<std::mutex> lock_guard(plt_mutex);
  if (platform_infos_impl_ == nullptr) {
    return;
  }
  platform_infos_impl_->SetPlatformRes(label, res);
}

bool PlatFormInfos::InitByInstance() {
    std::lock_guard<std::mutex> lock_guard(plt_mutex);
    if (platform_infos_impl_ != nullptr) {
        return true;
    }
    if (g_platformInfosImplInstance == nullptr) {
        g_platformInfosImplInstance = make_shared<PlatFormInfosImpl>();
        if (g_platformInfosImplInstance == nullptr) {
            return false;
        }
    }
    platform_infos_impl_ = g_platformInfosImplInstance;
    return true;
}

std::string PlatFormInfos::SaveToBuffer() {
#ifdef _OPEN_SOURCE_LLT_
  PF_LOGW("_OPEN_SOURCE_LLT_ has define");
  return "";
#else
  platform::tiling::PlatformInfosDef platformInfosDef;
  for (const auto &iter : GetAICoreIntrinsicDtype()) {
    const auto &dtypes = iter.second;
    platform::tiling::ListDType listDtype;
    for (const auto &dytpe: dtypes) {
      listDtype.add_dtype(dytpe);
    }
    platformInfosDef.mutable_ai_core_intrinsic_dtype_map()->insert({iter.first, listDtype});
  }
  for (const auto &iter: GetVectorCoreIntrinsicDtype()) {
    const auto &dtypes = iter.second;
    platform::tiling::ListDType listDtype;
    for (const auto &dytpe: dtypes) {
      listDtype.add_dtype(dytpe);
    }
    platformInfosDef.mutable_vector_core_intrinsic_dtype_map()->insert({iter.first, listDtype});
  }
  for (const auto &iter: GetFixPipeDtypeMap()) {
    const auto &dtypes = iter.second;
    platform::tiling::ListDType listDtype;
    for (const auto &dytpe: dtypes) {
      listDtype.add_dtype(dytpe);
    }
    platformInfosDef.mutable_fixpipe_dtype_map()->insert({iter.first, listDtype});
  }
 
  std::map<std::string, std::map<std::string, std::string>> res;
  (void) GetPlatformResWithLock(res);
  for (const auto &iter: res) {
    platform::tiling::PlatformMap platformMap;
    for (const auto &info: iter.second) {
      platformMap.mutable_platform_map()->insert({info.first, info.second});
    }
    platformInfosDef.mutable_platform_res_map()->insert({iter.first, platformMap});
  }
  return platformInfosDef.SerializeAsString();
#endif
}

bool PlatFormInfos::LoadFromBuffer(const char *bufPtr, const size_t bufLen) {
#ifdef _OPEN_SOURCE_LLT_
  return true;
#else
  if (platform_infos_impl_ == nullptr) {
    bool ret = InitByInstance();
    if (!ret) {
      PF_LOGE("PlatFormInfos init failed.");
      return false;
    }
  }
  platform::tiling::PlatformInfosDef platformDefInfos;
  bool parseRet = platformDefInfos.ParseFromArray(bufPtr, bufLen);
  if (!parseRet) {
      PF_LOGE("Parse proto failed.");
      return false;
  }
  std::map<std::string, std::vector<std::string>> aiCoreInstrinsicDtypesMap;
  std::map<std::string, std::vector<std::string>> aiVectorInstrinsicDtypesMap;
  std::map<std::string, std::map<std::string, std::string>> platformResMap;
  std::map<std::string, std::vector<std::string>> fixPipeDtypeMap;

  GetVecMapInfoFromProtoBuf(platformDefInfos.mutable_ai_core_intrinsic_dtype_map(), aiCoreInstrinsicDtypesMap);
  GetVecMapInfoFromProtoBuf(platformDefInfos.mutable_vector_core_intrinsic_dtype_map(), aiVectorInstrinsicDtypesMap);
  GetMapMapInfoFromProtoBuf(platformDefInfos.mutable_platform_res_map(), platformResMap);
  GetVecMapInfoFromProtoBuf(platformDefInfos.mutable_fixpipe_dtype_map(), fixPipeDtypeMap);

  platform_infos_impl_->SetAICoreIntrinsicDtype(aiCoreInstrinsicDtypesMap);
  platform_infos_impl_->SetVectorCoreIntrinsicDtype(aiVectorInstrinsicDtypesMap);
  for (auto iter = platformResMap.begin(); iter != platformResMap.end(); ++iter) {
      platform_infos_impl_->SetPlatformRes(iter->first, iter->second);
  }
  platform_infos_impl_->SetFixPipeDtypeMap(fixPipeDtypeMap);

  return true;
#endif
}

bool OptionalInfos::Init() {
  optional_infos_impl_ = make_shared<OptionalInfosImpl>();
  if (optional_infos_impl_ == nullptr) {
    return false;
  }
  return true;
}

string OptionalInfos::GetSocVersion() {
  if (optional_infos_impl_ == nullptr) {
    return "";
  }
  return optional_infos_impl_->GetSocVersion();
}

string OptionalInfos::GetCoreType() {
  if (optional_infos_impl_ == nullptr) {
    return "";
  }
  return optional_infos_impl_->GetCoreType();
}

uint32_t OptionalInfos::GetAICoreNum() {
  if (optional_infos_impl_ == nullptr) {
    return 0;
  }
  return optional_infos_impl_->GetAICoreNum();
}

string OptionalInfos::GetL1FusionFlag() {
  if (optional_infos_impl_ == nullptr) {
    return "";
  }
  return optional_infos_impl_->GetL1FusionFlag();
}

void OptionalInfos::SetFixPipeDtypeMap(const std::map<std::string, std::vector<std::string>> &fixpipe_dtype_map) {
  if (optional_infos_impl_ == nullptr) {
    return;
  }
  optional_infos_impl_->SetFixPipeDtypeMap(fixpipe_dtype_map);
}

std::map<std::string, std::vector<std::string>> OptionalInfos::GetFixPipeDtypeMap() {
  if (optional_infos_impl_ == nullptr) {
    return std::map<std::string, std::vector<std::string>>();
  }
  return optional_infos_impl_->GetFixPipeDtypeMap();
}
void OptionalInfos::SetSocVersion(string soc_version) {
  if (optional_infos_impl_ == nullptr) {
    return;
  }
  optional_infos_impl_->SetSocVersion(soc_version);
}

void OptionalInfos::SetSocVersionWithLock(string soc_version) {
  std::lock_guard<std::mutex> lock_guard(plt_mutex);
  if (optional_infos_impl_ == nullptr) {
    return;
  }
  optional_infos_impl_->SetSocVersion(soc_version);
}

void OptionalInfos::SetCoreType(string core_type) {
  if (optional_infos_impl_ == nullptr) {
    return;
  }
  optional_infos_impl_->SetCoreType(core_type);
}

void OptionalInfos::SetAICoreNum(uint32_t ai_core_num) {
  if (optional_infos_impl_ == nullptr) {
    return;
  }
  optional_infos_impl_->SetAICoreNum(ai_core_num);
}

void OptionalInfos::SetL1FusionFlag(string l1_fusion_flag) {
  if (optional_infos_impl_ == nullptr) {
    return;
  }
  optional_infos_impl_->SetL1FusionFlag(l1_fusion_flag);
}

}  // namespace fe

