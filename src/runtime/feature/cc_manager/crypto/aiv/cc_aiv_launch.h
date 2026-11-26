/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_CC_AIV_LAUNCH_H
#define CCE_RUNTIME_CC_AIV_LAUNCH_H

#include "base.hpp"
#include "task_queue/task_queue_abi.h"

namespace cce {
namespace runtime {

class Stream;

// Load the AIV keystream kernel on first CC use and reuse the handle afterwards.
// The current context and its device are resolved inside, and must belong to devId.
rtError_t CcInitAivKsKernel(uint32_t devId);

// Clear the load state of this device; the next CC operation loads it again.
void CcResetAivKsKernel(uint32_t devId);

rtError_t CcLaunchAivKsXor(Stream* stm, const AiccKeystreamXorParam& param);

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_CC_AIV_LAUNCH_H
