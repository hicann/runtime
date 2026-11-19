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

// CC 初始化时加载一次，运行期复用核句柄。
rtError_t CcInitAivKsKernel();

rtError_t CcLaunchAivKsXor(Stream* stm, const AiccKeystreamXorParam& param);

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_CC_AIV_LAUNCH_H
