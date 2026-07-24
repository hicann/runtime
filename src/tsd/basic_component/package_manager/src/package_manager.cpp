/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "package_manager.h"

namespace tsd {

PackageManager::PackageManager(
    uint32_t logicDeviceId, DeviceCommAgent& commAgent, CapabilityManager& capabilityMgr, uint32_t platInfoMode,
    bool isAdcEnv, uint32_t chipType)
    : getCheckCodeRetrySupport_(false),
      deviceIdle_(false),
      loadPackageErrorMsg_(""),
      envInfo_(logicDeviceId, platInfoMode, isAdcEnv, chipType),
      hashStore_(),
      pluginVersion_(envInfo_, hashStore_, pkgRspCode_),
      packageName_(envInfo_.packageName_),
      pkgHostHashValue_(hashStore_.pkgHostHashValue_),
      pkgDeviceHashValue_(hashStore_.pkgDeviceHashValue_),
      commAgent_(commAgent),
      capabilityMgr_(capabilityMgr),
      devicePluginVersions_(pluginVersion_.devicePluginVersions_),
      pluginUpdateStrategy_(pluginVersion_.pluginUpdateStrategy_),
      hasComputedPluginStrategy_(pluginVersion_.hasComputedPluginStrategy_),
      sender_(*this, commAgent_, capabilityMgr_, envInfo_, hashStore_, deviceIdle_, getCheckCodeRetrySupport_),
      checkCodeSvc_(
          *this, commAgent_, capabilityMgr_, envInfo_, hashStore_, pkgRspCode_, getCheckCodeRetrySupport_,
          loadPackageErrorMsg_),
      loader_(*this, commAgent_, capabilityMgr_, envInfo_, hashStore_, pkgRspCode_, loadPackageErrorMsg_),
      aicpuPackageExistInDevice_(loader_.aicpuPackageExistInDevice_),
      packagePeerCheckCode_(checkCodeSvc_.peerCheckCode_),
      packageHostCheckCode_(checkCodeSvc_.hostCheckCode_)
{}

PackageManager::~PackageManager() {}

void PackageManager::ResetOnClose() { loader_.Reset(); }

} // namespace tsd
