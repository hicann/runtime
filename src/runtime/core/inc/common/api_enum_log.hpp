/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_API_ENUM_LOG_HPP
#define CCE_RUNTIME_API_ENUM_LOG_HPP

#include "enum_log.hpp"
#include "runtime/base.h"
#include "runtime/config.h"
#include "runtime/dev.h"
#include "runtime/event.h"
#include "runtime/kernel.h"
#include "runtime/mem.h"
#include "runtime/mem_base.h"
#include "runtime/rt_external_device.h"
#include "runtime/rt_external_dqs.h"
#include "runtime/rt_external_kernel.h"
#include "runtime/rt_external_mem.h"
#include "runtime/rt_external_model.h"
#include "runtime/rt_external_preload.h"

RT_ENUM_LOG_DECLARE(ExecutableKernelTypeToString, rtKernelType_t)
RT_ENUM_LOG_DECLARE(ExecutableKernelTypeToString, uint32_t)

namespace cce {
namespace runtime {

RT_ENUM_LOG_DECLARE(MemcpyOrReduceKindToString, uint32_t)

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_API_ENUM_LOG_HPP
