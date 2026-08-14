/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "base.hpp"
#include "group_device.hpp"

namespace cce {
namespace runtime {

rtError_t GroupDevice::GroupInfoSetup() { return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t GroupDevice::GetGroupInfo(const int32_t grpId, rtGroupInfo_t* const info, const uint32_t cnt)
{
    UNUSED(grpId);
    UNUSED(info);
    UNUSED(cnt);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t GroupDevice::GetGroupCount(uint32_t* const cnt)
{
    NULL_PTR_RETURN(cnt, RT_ERROR_INVALID_VALUE);
    *cnt = 0U;
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t GroupDevice::SetGroup(const int32_t grpId)
{
    UNUSED(grpId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t GroupDevice::ResetGroup() { return RT_ERROR_FEATURE_NOT_SUPPORT; }

} // namespace runtime
} // namespace cce
