/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpusd_interface_process.h"
#include <securec.h>
#include <unistd.h>
#include "aicpusd_info.h"
#include "ascend_hal.h"
#include "aicpusd_event_manager.h"
#include "aicpusd_event_process.h"
#include "aicpusd_threads_process.h"
#include "dump_task.h"
#include "aicpu_context.h"
#include "aicpusd_common.h"
#include "aicpusd_context.h"
#include "aicpusd_util.h"
#include "aicpu_sched/common/aicpu_task_struct.h"
#include "aicpusd_resource_manager.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_model_execute.h"
#include "aicpu_engine.h"
#include "aicpusd_profiler.h"
#include "aicpusd_monitor.h"
#include "aicpusd_worker.h"
#include "aicpusd_cust_so_manager.h"
#include "aicpusd_sub_module_interface.h"

namespace {
    const std::map<EVENT_ID, SCHEDULE_PRIORITY> eventPriority = {
        {EVENT_ID::EVENT_TS_CTRL_MSG, SCHEDULE_PRIORITY::PRIORITY_LEVEL0}
    };

    // first array index
    constexpr size_t FIRST_INDEX = 0LU;
}
namespace AicpuSchedule {
    /**
     * @ingroup AicpuScheduleCore
     * @brief it is used to construct a object of AicpuScheduleCore.
     */
    AicpuScheduleInterface::AicpuScheduleInterface()
        : profilingMode_(PROFILING_CLOSE),
          noThreadFlag_(true),
          initFlag_(false),
          eventBitMap_(0U),
          runMode_(aicpu::AicpuRunMode::THREAD_MODE) {}

    /**
     * @ingroup AicpuScheduleCore
     * @brief it is used to destructor a object of AicpuScheduleCore.
     */
    AicpuScheduleInterface::~AicpuScheduleInterface() {}

    AicpuScheduleInterface &AicpuScheduleInterface::GetInstance()
    {
        static AicpuScheduleInterface instance;
        return instance;
    }

    int32_t AicpuScheduleInterface::BindHostPid(const std::string &pidSign, const uint32_t vfId) const
    {
        const AicpuPlat mode = (runMode_ == aicpu::AicpuRunMode::PROCESS_PCIE_MODE)
                               ? AicpuPlat::AICPU_ONLINE_PLAT : AicpuPlat::AICPU_OFFLINE_PLAT;
        int32_t ret = 0;
        ret = AicpuDrvManager::GetInstance().BindHostPid(pidSign, static_cast<int32_t>(mode),
                                                         vfId, DEVDRV_PROCESS_CP1);
        if (runMode_ == aicpu::AicpuRunMode::THREAD_MODE) {
            int32_t getRet = 0;
            getRet = AicpuDrvManager::GetInstance().BindHostPid(pidSign, static_cast<int32_t>(mode),
                                                                vfId, DEVDRV_PROCESS_CP2);
            aicpusd_warn("BindHostPid DEVDRV_PROCESS_CP2 ret[%d]", getRet);
        }
        return ret;
    }

    /**
     * @ingroup AicpuScheduleInterface
     * @brief it use to initialize aicpu schedule.
     * @param [in] deviceId
     * @param [in] hostPid : the process id of host
     * @param [in] pidSign : the signature of pid ,it is used in drv.
     * @param [in] profilingMode
     * @param [in] vfId : vf id
     * @param [in] isOnline: true-process mode; false-thread mode
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    int32_t AicpuScheduleInterface::InitAICPUScheduler(const std::vector<uint32_t> &deviceVec,
                                                       const pid_t hostPid,
                                                       const std::string &pidSign,
                                                       const uint32_t profilingMode,
                                                       const uint32_t vfId,
                                                       const bool isOnline,
                                                       const AicpuSchedMode schedMode,
                                                       const std::string &hostProcName)
    {
        const std::unique_lock<std::mutex> lockForInit(mutexForInit_);
        if (initFlag_) {
            aicpusd_warn("Aicpu schedule is already init.");
            return AICPU_SCHEDULE_OK;
        }
        noThreadFlag_ = false;
        if (deviceVec.empty()) {
            aicpusd_err("device vector is empty");
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        // get aicpu run mode
        const int32_t getRet = GetCurrentRunMode(isOnline);
        if (getRet != AICPU_SCHEDULE_OK) {
            aicpusd_err("getRet is not ok:%u", getRet);
            return getRet;
        }
        if (AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, hostPid, vfId,
                                                      true, runMode_, hostProcName) != AICPU_SCHEDULE_OK) {
            aicpusd_err("Failed to init aicpu drv manager");
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }

        DeployContext deployCtx = DeployContext::DEVICE;
        const StatusCode status = GetAicpuDeployContext(deployCtx);
        if (status != AICPU_SCHEDULE_OK) {
            aicpusd_err("Get current deploy ctx failed.");
            return status;
        }
        const bool cpuMode = GetCpuMode();
        if ((deployCtx == DeployContext::DEVICE) && (!cpuMode)) {
            const int32_t bindPidRet = BindHostPid(pidSign, vfId);
            if (bindPidRet != AICPU_SCHEDULE_OK) {
                aicpusd_err("check bind pid sign failed, ret[%d].", bindPidRet);
                return bindPidRet;
            }
            aicpusd_info("Bind pid sign success");
        }
        const uint32_t groupId = CP_DEFAULT_GROUP_ID;

        int32_t ret = AicpuDrvManager::GetInstance().InitDrvSchedModule(groupId, eventPriority);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("Failed to init the drv schedule module, ret[%d].", ret);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        const auto retCp =
            ComputeProcess::GetInstance().Start(deviceVec, hostPid, pidSign, profilingMode, vfId, runMode_, schedMode);
        if (retCp != AICPU_SCHEDULE_OK) {
            aicpusd_err("Compute process start failed, ret[%d].", retCp);
            ComputeProcess::GetInstance().Stop();
            return AICPU_SCHEDULE_ERROR_INIT_CP_FAILED;
        }

        aicpusd_info("Success to start compute process, deviceId[%u], hostPid[%d], runMode[%u]",
                     deviceVec[FIRST_INDEX], hostPid, runMode_);
        initFlag_ = true;
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuScheduleInterface::GetCurrentRunMode(const bool isOnline)
    {
        if (!isOnline) {
            runMode_ = aicpu::AicpuRunMode::THREAD_MODE;
            aicpusd_run_info("Current aicpu mode is offline (call by api).");
            return AICPU_SCHEDULE_OK;
        }
        aicpusd_err("Datadump only support thread mode.");
        return AICPU_SCHEDULE_ERROR_INIT_CP_FAILED;
    }

    int32_t AicpuScheduleInterface::DettachDeviceInDestroy(const std::vector<uint32_t> &deviceVec) const
    {
        for (size_t i = 0LU; i < deviceVec.size(); i++) {
            const drvError_t ret = halEschedDettachDevice(deviceVec[i]);
            if (ret != DRV_ERROR_NONE) {
                aicpusd_err("Failed to detach device[%u], result[%d].", deviceVec[i], ret);
                return ret;
            }
            aicpusd_info("Success to detach aicpu scheduler, device[%d].", deviceVec[i]);
        }
        return AICPU_SCHEDULE_OK;
    }
}
