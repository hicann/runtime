/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CORE_AICPUSD_INTERFACE_PROCESS_PROC_H
#define CORE_AICPUSD_INTERFACE_PROCESS_PROC_H

#include <atomic>
#include <mutex>
#include <thread>
#include <sys/types.h>
#include "aicpusd_interface.h"
#include "aicpusd_status.h"
#include "aicpu_context.h"
#include "core/aicpusd_args_parser.h"

namespace AicpuSchedule {
    void RegCreateCustMc2MaintenanceThreadCallBack();
    class AicpuScheduleInterface {
    public:
        __attribute__((visibility("default"))) static AicpuScheduleInterface &GetInstance();

        /**
        * @ingroup AicpuScheduleInterface
        * @brief it use to initialize aicpu schedule.
        * @param [in] deviceId
        * @param [in] hostPid : the process id of host process
        * @param [in] pidSign : the signature of pid ,it is used in drv.
        * @param [in] profilingMode : the mode of profiling
        * @param [in] aicpuPid: the process id of aicpu-sd process
        * @param [in] vfId: vf id
        * @param [in] isOnline : true: online  false offline
        * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        __attribute__((visibility("default"))) int32_t InitAICPUScheduler(const uint32_t deviceId,
                                                                          const pid_t hostPid,
                                                                          const std::string &pidSign,
                                                                          const uint32_t profilingMode,
                                                                          const pid_t aicpuPid,
                                                                          const uint32_t vfId,
                                                                          const bool isOnline);

        /**
        * @ingroup AicpuScheduleInterface
        * @brief it use to stop AICPU scheduler.
        * @param [in] deviceId
        * @param [in] hostPid :the process id of host
        * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        __attribute__((visibility("default"))) int32_t StopAICPUScheduler(const uint32_t deviceId);

        /**
         * @ingroup AicpuScheduleInterface
         * @brief Get current call mode
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t GetCurrentRunMode(const bool isOnline, aicpu::AicpuRunMode &runMode) const;

        /**
         * @ingroup IsInitialized
         * @brief Get initFlag
         * @return true or false
         */
        bool IsInitialized() const
        {
            return initFlag_;
        }

        __attribute__((visibility("default"))) pid_t GetAicpuSdProcId() const;

        __attribute__((visibility("default"))) void SetAicpuSdProcId(const pid_t aicpuSdPid);

        __attribute__((visibility("default"))) pid_t GetTsdProcId() const;

        __attribute__((visibility("default"))) void SetTsdProcId(const pid_t tsdPid);

        __attribute__((visibility("default"))) int32_t CustAicpuMainProcess(int32_t argc, char_t *argv[]) const;
    private:
        AicpuScheduleInterface();

        ~AicpuScheduleInterface();

        AicpuScheduleInterface(const AicpuScheduleInterface &) = delete;

        AicpuScheduleInterface &operator=(const AicpuScheduleInterface &) = delete;

        void SetLogLevel(const AicpuSchedule::ArgsParser &startParams) const;

        void SetTsdEventDstPidByArgs(const AicpuSchedule::ArgsParser &startParams) const;

        void SetCustAicpuMainThreadAffinity(const AicpuSchedule::ArgsParser &startParams) const;

        bool AttachHostGroup(const std::vector<std::string> &groupNameVec, const uint32_t grpNameNum) const;

        bool SendVfMsgToDrv(const uint32_t cmd, const uint32_t deviceId, const uint32_t vfId) const;

        // it is used to mark which is in call mode or multi-thread mode.
        std::atomic<bool> noThreadFlag_;

        // it is used in updating model status.
        std::mutex mutexForInit_;

        // it is used to record whether is init.
        bool initFlag_;

        pid_t aicpuSdPid_;

        pid_t tsdPid_;
    };
}
#endif