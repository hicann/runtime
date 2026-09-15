/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef RUNTIME_CORE_INC_C_TASK_LAUNCH_C_HPP
#define RUNTIME_CORE_INC_C_TASK_LAUNCH_C_HPP

#include <mutex>

#include "runtime/base.h"
#include "rts/rts_stars.h"

namespace cce {
namespace runtime {

class Stream;

rtError_t LaunchRandomNumTask(
    const rtRandomNumTaskInfo_t* const taskInfo, Stream* const stm, const void* const reserve);
rtError_t LaunchSqeUpdateTask(
    const void* const src, const uint64_t cpySize, const uint32_t sqId, const uint32_t pos, Stream* const stm);
rtError_t SetStreamSqLockUnlock(Stream* const stm, const bool isLock);
rtError_t SetUpdateAddrTask(const uint64_t devAddr, const uint64_t len, Stream* const stm);
rtError_t RDMASend(const uint32_t sqIndex, const uint32_t wqeIndex, Stream* const stm);
rtError_t RdmaDbSend(const uint32_t dbIndex, const uint64_t dbInfo, Stream* const stm, std::mutex& contextCaptureLock);

} // namespace runtime
} // namespace cce

#endif // RUNTIME_CORE_INC_C_TASK_LAUNCH_C_HPP
