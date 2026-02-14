/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
 
#ifndef AICPU_MC2_MAINTENANCE_THREAD_H
#define AICPU_MC2_MAINTENANCE_THREAD_H

#include <cstdint>
// error code for mc2
constexpr int32_t AICPU_SCHEDULE_PARAMETER_IS_NULL = 21600;
constexpr int32_t AICPU_SCHEDULE_THREAD_ALREADY_EXISTS = 21601;
constexpr int32_t AICPU_SCHEDULE_NOT_SUPPORT = 21602;

using AicpuMC2MaintenanceFuncPtr = void(*)(void *);
using AicpuCtrlThreadFuncPtr = void(*)(void *);

enum AicpuCtrlThreadType : uint32_t {
    THREAD_TYPE_HCOM = 0,
    THREAD_TYPE_ASCPP_PROF = 1,
};
#ifdef __cplusplus
extern "C" {
#endif // __cplusplus
__attribute__((weak)) __attribute__((visibility("default"))) int32_t StartMC2MaintenanceThread(AicpuMC2MaintenanceFuncPtr loopFun,
    void *paramLoopFun, AicpuMC2MaintenanceFuncPtr stopNotifyFun, void *paramStopFun);
__attribute__((weak)) __attribute__((visibility("default"))) int32_t AicpuCreateCtrlThread(uint32_t type, AicpuCtrlThreadFuncPtr loopFun,
    void *paramLoopFun, AicpuCtrlThreadFuncPtr stopNotifyFun, void *paramStopFun);

#ifdef __cplusplus
}
#endif
#endif // AICPU_MC2_MAINTENANCE_THREAD_H