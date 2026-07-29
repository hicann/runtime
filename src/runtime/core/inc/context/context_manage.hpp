/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_CONTEXT_MANAGE_HPP
#define CCE_RUNTIME_CONTEXT_MANAGE_HPP

#include <vector>
#include "error_message_manage.hpp"
#include "base.hpp"
#include "context_data_manage.h"
namespace cce {
namespace runtime {
class Context;
class Device;
enum class ContextAccessMode : uint8_t {
    USER = 0,
    INTERNAL = 1,
};

class ContextManage {
public:
    static bool CheckContextIsValid(
        Context* const curCtx, ContextAccessMode accessMode = ContextAccessMode::USER, rtError_t* errorCode = nullptr);
    static void ReportContextValidationError();
    static void InsertContext(Context* const insertCtx);
    static rtError_t MarkContextForDelete(Context* const eraseCtx);
    static rtError_t DeviceAbort(const int32_t devId);
    static rtError_t Devicekill(const int32_t devId);
    static rtError_t DeviceQuery(const int32_t devId, const uint32_t step, const uint32_t timeout);
    static rtError_t DeviceClean(const int32_t devId);
    static rtError_t DeviceTaskAbort(const int32_t devId, const uint32_t timeout);
    static bool IsSupportDeviceAbort(const int32_t devId);
    static void TryToRecycleCtxMdlPool();
    static void SetGlobalFailureErr(const uint32_t devId, const rtError_t errCode);
    static void SetGlobalErrToCtx(const rtError_t errCode);
    static void DeviceSetFaultType(const uint32_t devId, DeviceFaultType deviceFaultType);
    static bool DeviceSetFaultTypeIfNoError(const uint32_t devId, DeviceFaultType deviceFaultType);
    static bool CheckStreamPtrIsValid(Stream* const stm);
    static rtError_t DeviceResourceClean(int32_t devId);
    static void QueryContextInUse(const int32_t devId, bool& isInUse);
    static bool IsContextTracked(Context* const ctx);
    static bool HasAttachedDevice(Context* const ctx);
    static bool IsActiveContext(Context* const ctx);
    static bool HasActiveDevice(Context* const ctx);
    static Device* GetActiveContextDevice(Context* const ctx);
    static bool IsContextOnDevice(Context* const ctx, const int32_t devId);
    static bool IsActiveContextOnDevice(Context* const ctx, const int32_t devId);
    // Validate inactive explicit context before destroy. This does not acquire an API-level in-use reference.
    static bool AcquireInactiveContextForDestroy(Context* const ctx, rtError_t* errorCode = nullptr);
    static rtError_t RemoveContextFromSet(Context* const eraseCtx);

private:
};
} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_CONTEXT_MANAGE_HPP
