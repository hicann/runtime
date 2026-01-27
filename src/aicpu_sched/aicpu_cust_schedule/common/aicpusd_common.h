/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPUSD_COMMON_H
#define AICPUSD_COMMON_H
#include <string>
#include <unistd.h>
#include "aicpusd_status.h"
#include "aicpu_msg.h"
#include "task_scheduler_error.h"
#include "rt_model.h"
#include "ascend_hal.h"
namespace AicpuSchedule {
using TsAicpuSqe = ts_aicpu_sqe_t;
using TsToAicpuDataDump = ts_to_aicpu_datadump_t;
using TsToAicpuDataDumpInfoLoad = ts_to_aicpu_datadumploadinfo_t;
using TsAicpuMsgVersion =  ts_aicpu_msg_version_t;
using TsAicpuMsgInfo = ts_aicpu_msg_info_t; // v1
using TsToAicpuDataDumpInfoLoad = ts_to_aicpu_datadumploadinfo_t;
using TsToAicpuDataDumpInfoloadMsg = ts_to_aicpu_datadump_info_load_msg_t;
constexpr uint32_t DEFAULT_GROUP_ID = 0U;

#define VM_QOS_PROCESS_STARTUP    _IOW('Q', 0x0, int32_t) // 'Q' is a magic number
#define VM_QOS_PROCESS_SUSPEND    _IOW('Q', 0x1, int32_t)

struct VfMsgInfo {
    uint32_t deviceId;
    uint32_t vfId;
};

enum class ThreadStatus {
    THREAD_INIT = 0,
    THREAD_RUNNING = 1,
    THREAD_EXIT = 2
};

enum class AicpuPlat {
    AICPU_ONLINE_PLAT = 0,
    AICPU_OFFLINE_PLAT,
    AICPU_MAX_PLAT,
};
}
#endif