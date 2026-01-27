/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_FAST_RECOVER_HPP
#define CCE_RUNTIME_FAST_RECOVER_HPP

#include "context.hpp"

namespace cce {
namespace runtime {
    rtError_t DavidDeviceTaskAbort(const int32_t devId, const uint32_t time);
    rtError_t DeviceTaskSendResume(const int32_t devId, const uint64_t timeRemain);
    rtError_t DavidDeviceQuery(const int32_t devId, const uint32_t op, const uint64_t timeRemain);
    rtError_t DavidDeviceKill(const int32_t devId, const uint32_t op, const uint64_t timeRemain);
    rtError_t DeviceTaskSendStop(const int32_t devId, const uint64_t timeRemain);
    rtError_t CtxStreamTaskClean(Context *const ctx);
    rtError_t GetMemUceInfoProc(const uint32_t deviceId, rtErrorInfo * const errorInfo);
    rtError_t MemUceErrorResume(Device * const dev, const uint32_t deviceId, const rtErrorInfo * const errorInfo);

}  // namespace runtime
}  // namespace cce

#endif