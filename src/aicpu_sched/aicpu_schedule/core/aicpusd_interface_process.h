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
#include <functional>
#include <map>
#include <mutex>
#include <thread>
#include <vector>
#include "aicpusd_status.h"
#include "aicpusd_common.h"
#include "aicpusd_interface.h"
#include "ascend_hal.h"
#include "event_custom_api_struct.h"
#include "ts_api.h"
#include "aicpu_context.h"

namespace AicpuSchedule {
    class AicpuScheduleInterface {
    public:
        __attribute__((visibility("default"))) static AicpuScheduleInterface &GetInstance();

        /**
        * @ingroup AicpuScheduleInterface
        * @brief it use to load the task and stream info for helper.
        * @param [in] ptr : the address of the task and stream info
        * @return AICPU_SCHEDULE_OK: success
        */
        int32_t LoadModelWithQueue(const void * const ptr) const;

        /**
        * @ingroup AicpuScheduleInterface
        * @brief it use to load the task and stream info for helper.
        * @param [in] ptr : the address of the task and stream info
        * @return AICPU_SCHEDULE_OK: success
        */
        int32_t LoadModelWithEvent(const void * const ptr) const;

        /**
        * @ingroup AicpuScheduleInterface
        * @brief it use to load the task and stream info.
        * @param [in] ptr : the address of the task and stream info
        * @return AICPU_SCHEDULE_OK: success
        */
        int32_t LoadProcess(const void * const ptr, const ModelCfgInfo * const cfg = nullptr) const;

        /**
        * @ingroup AicpuScheduleInterface
        * @param [in] modelId
        * @brief it use to destroy one model.
        */
        int32_t Destroy(const uint32_t modelId) const;

        /**
        * @ingroup AicpuScheduleInterface
        * @brief it use to destroy all model.
        * @return AICPU_SCHEDULE_OK:success, other failed.
        */
        int32_t Destroy() const;

        /**
        * @ingroup AicpuScheduleInterface
        * @brief it use to initialize aicpu schedule.
        * @param [in] deviceId
        * @param [in] hostPid: the process id of host
        * @param [in] pidSign: the signature of pid ,it is used in drv.
        * @param [in] profilingMode: the mode of profiling
        * @param [in] vfId: vf id
        * @param [in] isOnline: true-process mode; false-thread mode
        * @param [in] hostProcName: host process name
        * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        __attribute__((visibility("default"))) int32_t InitAICPUScheduler(const std::vector<uint32_t> &deviceVec,
                                                                          const pid_t hostPid,
                                                                          const std::string &pidSign,
                                                                          const uint32_t profilingMode,
                                                                          const uint32_t vfId,
                                                                          const bool isOnline,
                                                                          const AicpuSchedMode schedMode,
                                                                          const std::string &hostProcName = "");

        /**
        * @ingroup AicpuScheduleInterface
        * @brief it use to stop AICPU scheduler.
        * @param [in] deviceId
        * @param [in] hostPid :the process id of host
        * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        __attribute__((visibility("default"))) int32_t StopAICPUScheduler(const std::vector<uint32_t> &deviceVec,
                                                                          const pid_t hostPid);

        int32_t StopAICPUSchedulerWithFlag(const std::vector<uint32_t> &deviceVec, const pid_t hostPid,
            bool waitThreadStop);

        /**
         * @ingroup AicpuScheduleInterface
         * @brief it use to get the errorcode for external module by the model status.
         * @return AICPU_SCHEDULE_SUCCESS: success, other: error code
         */
        ErrorCode GetErrorCode(const uint32_t modelId) const;

        /**
         * @ingroup AicpuScheduleInterface
         * @brief execute model async.
         * @param [in] modelId: model id.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ExecuteModelAsync(const uint32_t modelId) const;

        /**
         * @ingroup IsInitialized
         * @brief Get initFlag
         * @return true or false
         */
        bool IsInitialized(const uint32_t deviceId);

        int32_t Stop(const uint32_t modelId) const;

        int32_t Restart(const uint32_t modelId) const;

        int32_t ClearInput(const uint32_t modelId) const;

        int32_t CheckKernelSupported(const std::string &kernelName) const;

        void UpdateOrInsertStartFlag(const uint32_t deviceId, const bool flag);

        void SetAicpuCustSdProcId(const int32_t aicpuCustSdPid);

        int32_t GetAicpuCustSdProcId() const;

        void SetAicpuSdProcId(const pid_t aicpuSdPid);

        int32_t ProcessException(const DataFlowExceptionNotify *const exceptionInfo) const;
    private:
        AicpuScheduleInterface();

        ~AicpuScheduleInterface();

        AicpuScheduleInterface(AicpuScheduleInterface &) = delete;

        AicpuScheduleInterface &operator=(AicpuScheduleInterface &) = delete;

        int32_t BuildAndSetContext(const uint32_t deviceId, const pid_t hostPid, const uint32_t vfId);

        /**
         * @ingroup AicpuScheduleInterface
         * @brief Get current call mode
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t GetCurrentRunMode(const bool isOnline);

        /**
        * @ingroup AicpuScheduleInterface
        * @brief it use to bind host pid.
        * @param [in] pidSign: the signature of pid ,it is used in drv.
        * @param [in] vfId: vf id
        * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        int32_t BindHostPid(const std::string &pidSign, const uint32_t vfId) const;

        /**
         * @ingroup AicpuScheduleInterface
         * @brief it use to send message to tscpu.
         * @param [in] deviceId
         */
        void SendMsgToTsCpu(const uint32_t deviceId) const;

        int32_t DettachDeviceInDestroy(const std::vector<uint32_t> &deviceVec) const;

    private:
        // the Mode decide if profiling open
        ProfilingMode profilingMode_;

        // it is used to mark which is in call mode or multi-thread mode.
        std::atomic<bool> noThreadFlag_;

        // it is used in updating model status.
        std::mutex mutexForInit_;

        // it is used to record whether is init.
        bool initFlag_;

        uint32_t eventBitMap_;

        // aicpu run mode
        aicpu::AicpuRunMode runMode_;

        std::map<uint32_t, bool> aicpusdInitFlagMap_;

        std::atomic<int32_t> aicpuCustSdPid_;
    };
}
#endif
