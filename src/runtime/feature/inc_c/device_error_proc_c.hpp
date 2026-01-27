/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_DEVICE_ERROR_PROC_C_HPP__
#define __CCE_RUNTIME_DEVICE_ERROR_PROC_C_HPP__

#include "device/device_error_proc.hpp"

namespace cce {
namespace runtime {
constexpr uint32_t FUSION_CQE_STATUS_ONLY_AIX_ERROR = 0x400U;
constexpr uint32_t FUSION_CQE_STATUS_ERROR_MASK = 0x44444U;

enum class AixErrClass : int32_t {
    AIX_ERROR_NA = 0,
    AIX_MTE_POISON_ERROR = 1,
    AIX_HW_L_ERROR = 2,
    AIX_S_ERROR = 4,
    AIX_LINK_ERROR = 8,
    AIX_ERROR_END
};  // 与TS侧ts_aix_err_class_t对应

rtError_t ProcRingBufferTaskDavid(
    const Device *const dev, const void *const devMem, const bool delFlag, const uint32_t len);
rtError_t ProcessDavidStarsFusionKernelErrorInfo(const StarsDeviceErrorInfo *const info, const uint64_t errorNumber,
    const Device *const dev, const DeviceErrorProc *const insPtr);
rtError_t ProcessDavidStarsWaitTimeoutErrorInfo(const StarsDeviceErrorInfo * const info,
    const uint64_t errorNumber, const Device * const dev, const DeviceErrorProc * const insPtr);
rtError_t ProcessDavidStarsCoreErrorInfo(const StarsDeviceErrorInfo * const info,
    const uint64_t errorNumber, const Device * const dev, const DeviceErrorProc * const insPtr);
rtError_t ProcessDavidStarsCcuErrorInfo(const StarsDeviceErrorInfo * const info,
    const uint64_t errorNumber, const Device * const dev, const DeviceErrorProc * const insPtr);
rtError_t ProcessStarsSdmaErrorInfo(const StarsDeviceErrorInfo * const info,
    const uint64_t errorNumber, const Device * const dev, const DeviceErrorProc * const insPtr);
}  // namespace runtime
}  // namespace cce

#endif