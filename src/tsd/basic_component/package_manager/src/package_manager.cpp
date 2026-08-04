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
    : envInfo_(logicDeviceId, platInfoMode, isAdcEnv, chipType),
      hashStore_(),
      ctx_(),
      pluginVersion_(envInfo_, hashStore_, ctx_),
      commAgent_(commAgent),
      capabilityMgr_(capabilityMgr),
      checkCodeSvc_(commAgent_, capabilityMgr_, envInfo_, hashStore_, ctx_),
      sender_(commAgent_, capabilityMgr_, envInfo_, hashStore_, ctx_, checkCodeSvc_),
      loader_(commAgent_, capabilityMgr_, envInfo_, hashStore_, ctx_, sender_, checkCodeSvc_, pluginVersion_)
{}

void PackageManager::ResetOnClose() { loader_.Reset(); }

} // namespace tsd
