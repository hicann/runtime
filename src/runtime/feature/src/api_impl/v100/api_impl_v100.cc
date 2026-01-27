/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_impl.hpp"
#include "base.hpp"
#include "inner_thread_local.hpp"
#include "runtime.hpp"
#include "runtime/dev.h"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {

rtError_t ApiImpl::SetXpuDevice(const rtXpuDevType devType, const uint32_t devId)
{
    UNUSED(devType);
    UNUSED(devId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::GetXpuDevCount(const rtXpuDevType devType, uint32_t *devCount)
{
    UNUSED(devType);
    UNUSED(devCount);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::ResetXpuDevice(const rtXpuDevType devType, const uint32_t devId)
{
    UNUSED(devType);
    UNUSED(devId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}
}
}