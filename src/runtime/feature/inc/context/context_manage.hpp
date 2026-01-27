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

class ContextManage {
public:
    static bool CheckContextIsValid(Context * const curCtx, const bool inUseFlag);
    static void InsertContext(Context * const insertCtx);
    static rtError_t EraseContextFromSet(Context * const eraseCtx);
    static rtError_t DeviceAbort(const int32_t devId);
    static rtError_t Devicekill(const int32_t devId);
    static rtError_t DeviceQuery(const int32_t devId, const uint32_t step, const uint32_t timeout);
    static rtError_t DeviceClean(const int32_t devId);
    static rtError_t DeviceTaskAbort(const int32_t devId, const uint32_t timeout);
    static rtError_t SnapShotProcessBackup();
    static rtError_t SnapShotProcessRestore();
    static rtError_t ModelBackup(const int32_t devId);
    static rtError_t ModelRestore(const int32_t devId);
    static rtError_t SinkTaskMemoryBackup(const int32_t devId);
    static bool IsSupportDeviceAbort(const int32_t devId);
    static void TryToRecycleCtxMdlPool();
    static void SetGlobalFailureErr(const uint32_t devId, const rtError_t errCode);
    static void SetGlobalErrToCtx(const rtError_t errCode);
    static void DeviceSetFaultType(const uint32_t devId, DeviceFaultType deviceFaultType);
    static void DeviceGetStreamlist(int32_t devId, rtStreamlistType_t type, rtStreamlist_t *stmList);
    static void DeviceGetModelList(int32_t devId, rtModelList_t *mdlList);
    static bool CheckStreamPtrIsValid(Stream * const stm);
    static rtError_t DeviceResourceClean(int32_t devId);
    static void QueryContextInUse(const int32_t devId, bool &isInUse);
private:
};
}
}

#endif  // CCE_RUNTIME_CONTEXT_MANAGE_HPP
