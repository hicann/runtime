/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpusd_threads_process.h"
#include <cstring>
#include <unistd.h>
#include <sys/types.h>
#include <sys/syscall.h>
#include "ascend_hal.h"
#include "tdt_server.h"
#include "task_queue.h"
#include "profiling_adp.h"
#include "aicpusd_util.h"
#include "aicpusd_status.h"
#include "aicpusd_common.h"
#include "aicpusd_event_manager.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_interface_process.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_worker.h"
#include "aicpu_context.h"
#include "aicpusd_monitor.h"
#include "aicpusd_msg_send.h"
#include "aicpu_async_event.h"
#include "aicpusd_hal_interface_ref.h"
#include "aicpu_prof.h"
#include "aicpu_engine.h"
namespace {
const size_t FIRST_INDEX = 0UL;
}

namespace AicpuSchedule {
ComputeProcess::ComputeProcess()
    : deviceVec_({}),
      hostDeviceId_(0U),
      hostPid_(-1),
      pidSign_(""),
      aicpuNum_(0U),
      profilingMode_(PROFILING_CLOSE),
      vfId_(0U),
      isStartTdtFlag_(false),
      runMode_(aicpu::AicpuRunMode::THREAD_MODE) {}

ComputeProcess& ComputeProcess::GetInstance()
{
    static ComputeProcess instance;
    return instance;
}

int32_t ComputeProcess::Start(const std::vector<uint32_t> &deviceVec,
                              const pid_t hostPid,
                              const std::string &pidSign,
                              const uint32_t profilingMode,
                              const uint32_t vfId,
                              const aicpu::AicpuRunMode runMode,
                              const AicpuSchedMode schedMode)
{
    aicpusd_info("Aicpu scheduler start, hostpid[%d], profilingMode[%u], runMode[%u], vfId[%u].",
                 hostPid, profilingMode, runMode, vfId);
    if (deviceVec.empty()) {
        aicpusd_err("device vector is empty.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    const AicpuSchedule::AicpuDrvManager &drvMgr = AicpuSchedule::AicpuDrvManager::GetInstance();
    deviceVec_ = deviceVec;
    aicpuNum_ = drvMgr.GetAicpuNum();
    hostPid_ = hostPid;
    pidSign_ = pidSign;
    runMode_ = runMode;
    vfId_ = vfId;

    aicpusd_info("ComputeProcess::Start: profilingMode[%u]", profilingMode);

    auto ret = AicpuSchedule::ThreadPool::Instance().CreateWorker(schedMode);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Drv create aicpu work tasks failed, ret[%d].", ret);
        return ret;
    }
    aicpusd_info("Aicpu scheduler start successfully, deviceId[%u], hostpid[%d], profilingMode[%u], runMode[%u].",
                 deviceVec_[FIRST_INDEX], hostPid, profilingMode, runMode_);
    return AICPU_SCHEDULE_OK;
}

void ComputeProcess::Stop()
{
}
}
