/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "datadump/datadump_interface.h"
#include "aicpusd_util.h"
#include "profiling_adp.h"
#include "core/aicpusd_interface_process.h"
#include "core/aicpusd_event_manager.h"
#include "core/aicpusd_threads_process.h"
#include "core/aicpusd_cust_so_manager.h"
#include "core/aicpusd_msg_send.h"
#include "aicpusd_monitor.h"
#include "aicpusd_lastword.h"
#include "dump_task.h"
#include "common/aicpusd_util.h"
#include "common/aicpusd_context.h"
#include "dump_task.h"
#include "aicpu_engine.h"
#include "type_def.h"
#include "tsd.h"

extern "C" {
int32_t InitAICPUDatadump(const uint32_t deviceId, const pid_t hostPid)
{
    if (AicpuSchedule::AicpuUtil::IsEnvValEqual("AICPU_APP_LOG_SWITCH", "0")) {
        aicpusd_info("AICPU_APP_LOG_SWITCH is setted to 0 to switch off applog");
    } else {
        LogAttr logAttr = {};
        logAttr.type = APPLICATION;
        logAttr.pid = static_cast<uint32_t>(hostPid);
        logAttr.deviceId = deviceId;
        logAttr.mode = 0;
        if (DlogSetAttrAicpu(logAttr) != 0) {
            aicpusd_warn("Set log attr failed");
        }
    }

    // Make sure AicpusdLastword are created first，to ensure the last exit
    AicpuSchedule::AicpusdLastword::GetInstance();
    const std::vector<uint32_t> deviceVec{deviceId};
    auto deployContext = AicpuSchedule::DeployContext::DEVICE;
    const int32_t status = AicpuSchedule::GetAicpuDeployContext(deployContext);
    if (status != AicpuSchedule::AICPU_SCHEDULE_OK) {
        aicpusd_err("Get current deploy ctx failed.");
        return status;
    }
    process_sign pidSign;
    if (deployContext == AicpuSchedule::DeployContext::DEVICE) {
        const drvError_t ret = drvGetProcessSign(&pidSign);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("Get process sign failed, ret[%d].", ret);
            return AICPU_SCHEDULE_FAIL;
        }
    } else {
        pidSign.sign[0U] = '\0';
    }
    aicpusd_info("Get process sign success");
    return AicpuSchedule::AicpuScheduleInterface::GetInstance().InitAICPUScheduler(deviceVec,
                                                                                   hostPid,
                                                                                   pidSign.sign,
                                                                                   PROFILING_CLOSE,
                                                                                   0U,
                                                                                   false,
                                                                                   SCHED_MODE_INTERRUPT);
}

int32_t StopAICPUDatadump(uint32_t deviceId, pid_t hostPid)
{
    UNUSED(deviceId);
    UNUSED(hostPid);
    AicpuSchedule::OpDumpTaskManager::GetInstance().ClearResource();
    aicpusd_run_info("Success to stop aicpu scheduler, deviceId[%u], hostPid[%d].", deviceId, hostPid);
    return AicpuSchedule::AICPU_SCHEDULE_OK;
}
}