/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "driver.hpp"

namespace cce {
namespace runtime {
rtError_t GetConnectUbFlagFromDrv(const uint32_t deviceId, bool &connectUbFlag)
{
    UNUSED(deviceId);
    connectUbFlag = false;
    return RT_ERROR_NONE;
}

rtError_t InitDrvEventThread(const uint32_t deviceId)
{
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}

rtError_t GetDrvSentinelMode(void)
{
    return RT_ERROR_NONE;
}

bool IsOfflineNotSupportMemType(const rtMemType_t &type)
{
    constexpr uint32_t RT_MEMORY_POLICY_P2P_MASK = RT_MEMORY_POLICY_HUGE_PAGE_FIRST_P2P |
        RT_MEMORY_POLICY_HUGE_PAGE_ONLY_P2P | RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY_P2P;

    if ((type == RT_MEMORY_P2P_HBM) || (type == RT_MEMORY_P2P_DDR)) {
        return true;
    } else {
        return (static_cast<uint32_t>(type) & RT_MEMORY_POLICY_P2P_MASK) != 0U;
    }
}

rtError_t GetIpcNotifyVa(const uint32_t notifyId, Driver * const curDrv, const uint32_t deviceId, const uint32_t phyId,
    uint64_t &Va)
{
    UNUSED(notifyId);
    UNUSED(curDrv);
    UNUSED(Va);
    UNUSED(phyId);
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}
}  // namespace runtime
}  // namespace cce
