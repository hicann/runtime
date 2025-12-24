/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "raw_device.hpp"

#include <chrono>
#include "device.hpp"
#include "uma_arg_loader.hpp"
#include "runtime.hpp"
#include "ctrl_stream.hpp"
#include "tsch_stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "program.hpp"
#include "module.hpp"
#include "api.hpp"
#include "driver/ascend_hal.h"
#include "task.hpp"
#include "device/device_error_proc.hpp"
#include "error_message_manage.hpp"
#include "thread_local_container.hpp"
#include "aicpu_err_msg.hpp"
#include "dvpp_grp.hpp"
#include "task_info.hpp"
#include "task_submit.hpp"
#include "event.hpp"
#include "ctrl_res_pool.hpp"
#include "npu_driver_dcache_lock.hpp"
#include "stream_factory.hpp"
#include "arg_loader_ub.hpp"
#include "stub_task.hpp"
#include "dev_info_manage.h"
#include "soc_info.h"
#include "notify.hpp"
#include "capture_model.hpp"
#include "device_sq_cq_pool.hpp"
#include "sq_addr_memory_pool.hpp"
#include "printf.hpp"

namespace cce {
namespace runtime {
void RawDevice::InitResource()
{
    int64_t totalCoreNum = 0;
    (void)driver_->GetDevInfo(deviceId_, MODULE_TYPE_AICORE, INFO_TYPE_CORE_NUM, &totalCoreNum);
    if (GetDevProperties().reduceAicNum &&
        (totalCoreNum == RT_AICORE_NUM_25)) {
        totalCoreNum = RT_AICORE_NUM_25 - 1U;
    }
    InsertResInit(RT_DEV_RES_CUBE_CORE, static_cast<uint32_t>(totalCoreNum));
    InsertResLimit(RT_DEV_RES_CUBE_CORE, static_cast<uint32_t>(totalCoreNum));
    (void)driver_->GetDevInfo(deviceId_, MODULE_TYPE_VECTOR_CORE, INFO_TYPE_CORE_NUM, &totalCoreNum);
    if (GetDevProperties().reduceAicNum &&
        (totalCoreNum == RT_AICORE_NUM_25 * 2)) {    // 2: vector core is double of cube core
        totalCoreNum = (RT_AICORE_NUM_25 - 1U) * 2;  // 2: vector core is double of cube core
    }
    InsertResInit(RT_DEV_RES_VECTOR_CORE, static_cast<uint32_t>(totalCoreNum));
    InsertResLimit(RT_DEV_RES_VECTOR_CORE, static_cast<uint32_t>(totalCoreNum));
}

void RawDevice::InsertResInit(rtDevResLimitType_t type, uint32_t value)
{
    if (type < RT_DEV_RES_TYPE_MAX && type >= 0) {
        resInitArray_[type] = value;
    } else {
        RT_LOG(RT_LOG_WARNING, "illegal device resource type");
    }
}

uint32_t RawDevice::GetResInitValue(const rtDevResLimitType_t type) const
{
    if (type < RT_DEV_RES_TYPE_MAX && type >= 0) {
        return resInitArray_[type];
    }
    RT_LOG(RT_LOG_WARNING, "illegal device resource type");
    return 0;
}

void RawDevice::InsertResLimit(rtDevResLimitType_t type, uint32_t value)
{
    if (type < RT_DEV_RES_TYPE_MAX && type >= 0) {
        resLimitArray_[type] = value;
    } else {
        RT_LOG(RT_LOG_WARNING, "illegal device resource type");
    }
}

uint32_t RawDevice::GetResValue(const rtDevResLimitType_t type) const
{
    if (type < RT_DEV_RES_TYPE_MAX && type >= 0) {
        return resLimitArray_[type];
    }
    RT_LOG(RT_LOG_WARNING, "illegal device resource type");
    return 0U;
}

void RawDevice::ResetResLimit(void)
{
    for (size_t i = 0; i < RT_DEV_RES_TYPE_MAX; i++) {
        resLimitArray_[i] = resInitArray_[i];
    }
}
}  // namespace runtime
}
