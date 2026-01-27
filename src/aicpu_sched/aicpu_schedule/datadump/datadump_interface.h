/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DATADUMP_INTERFACE_H
#define DATADUMP_INTERFACE_H

#include <sched.h>
#include "aicpusd_info.h"
extern "C" {
/**
 * @brief it is used to init aicpu datadump thread for acl.
 * @param [in] deviceId : The id of self cpu.
 * @param [in] hostPid :  pid of host appication
 * @param [in] profilingMode : it used to open or close profiling.
 * @return AICPU_SCHEDULE_SUCCESS: success  other: error code in ErrorCode
 */
__attribute__((visibility("default"))) int32_t InitAICPUDatadump(const uint32_t deviceId, const pid_t hostPid);
/**
 * @brief it is used to stop the aicpu datadump thread for acl.
 * @param [in] deviceId : The id of self cpu.
 * @param [in] hostPid : pid of host appication
 * @return AICPU_SCHEDULE_SUCCESS: success  other: error code in ErrorCode
 */
__attribute__((visibility("default"))) int32_t StopAICPUDatadump(uint32_t deviceId, pid_t hostPid);
}
#endif  // INC_DATADUMP_INTERFACE_H
