/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef PROCMGR_MSR_SYS_OWNER_CLIENT_H
#define PROCMGR_MSR_SYS_OWNER_CLIENT_H

#include <stdint.h>
#include <string>
#include <vector>
#ifdef __cplusplus
extern "C"
{
#endif
struct SetSchedulerInfo {
    pid_t threadId{0};
    int32_t policy{0};
    int32_t priority{0};
};
uint32_t ProcMgrSetScheduler(const std::vector<SetSchedulerInfo>& schedulerInfo);
int32_t ProcMgrUpdateSePolicy();
#ifdef __cplusplus
}
#endif
#endif
