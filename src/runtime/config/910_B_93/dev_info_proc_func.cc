/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dev_info.h"
#include "dev_info_manage.h"
#include "npu_driver.hpp"
#include "device_error_proc.hpp"

namespace cce {
namespace runtime {
static bool HitBlackListErrors(uint32_t devId)
{
    if (IsHitBlacklist(devId, g_mulBitEccEventId) || IsSmmuFault(devId)) {
        RT_LOG(RT_LOG_ERROR, "hit black list or hit smmu fault!");
        return true;
    }
    return false;
}

static void UpdateDevProps(DevProperties& props)
{
    if (NpuDriver::CheckIsSupportFeature(0U, FEATURE_TRSDRV_SQ_SUPPORT_DYNAMIC_BIND)) {
        props.baseAicpuStreamId = 32768U; // 32*1024
    }
}

static DevDynInfoProcFunc CHIP_910B_PROC_FUNC = {
    .devPropsUpdateFunc = &UpdateDevProps,
    .devHitBlackListErrors = &HitBlackListErrors,
};

REGISTER_DEV_INFO_PROC_FUNC(CHIP_910_B_93, CHIP_910B_PROC_FUNC);
}  // namespace runtime
} // namespace cce
