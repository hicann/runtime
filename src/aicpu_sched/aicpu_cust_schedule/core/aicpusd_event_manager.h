/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CORE_AICPUSD_EVENT_MANAGER_PROC_H
#define CORE_AICPUSD_EVENT_MANAGER_PROC_H

#include <atomic>
#include <functional>
#include <map>
#include <mutex>
#include <thread>

#include "aicpu_event_struct.h"
#include "ascend_hal.h"
#include "type_def.h"
#include "aicpusd_sqe_adapter.h" 

namespace AicpuSchedule {
    constexpr uint32_t ENABLE_MODE_OFFSET = 48U;
    constexpr uint32_t DATADUMP_ENABLE_MODE_OFFSET = 49U;
    constexpr uint32_t DEBUGDUMP_ENABLE_MODE_OFFSET = 50U;
    constexpr uint8_t VERSION_0 = 0;
    constexpr uint8_t VERSION_1 = 1;

    struct EventInfoForExecute {
        uint32_t threadIndex;
        uint32_t streamId;
        uint64_t taskId;
        uint16_t dataDumpEnableMode;
        uint64_t serialNo;
        uint32_t mailboxId;
    };

    class AicpuEventManager {
    public:
        __attribute__((visibility("default"))) static AicpuEventManager &GetInstance();

        __attribute__((visibility("default"))) void InitEventManager(const bool noThreadFlag, const bool runningFlag);

        /**
         * @ingroup AicpuEventManager
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @brief it is used in multi-thread.
         */
        void LoopProcess(const uint32_t threadIndex);

        /**
         * @ingroup AicpuEventManager
         * @brief it is used to parse the struct and get some parameter.
         * @param [in] eventInfo : the event information from mailbox.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessHWTSKernelEvent(const event_info &eventInfo, const uint32_t threadIndex) const;
        /**
         * @ingroup AicpuEventManager
         * @brief it is used to process EVENT_TS_CTRL_MSG event
         * @param [in] drvEventInfo : the event information.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcTsCtrlEvent(const event_info &drvEventInfo, const uint32_t threadIndex);

        /**
         * @ingroup AicpuEventManager
         * @brief it use to process control task from ts
         * @param [in] drvEventInfo : the event information from ts.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessHWTSControlEvent(const event_info &drvEventInfo);

        /**
         * @ingroup AicpuEventManager
         * @brief it use to set running flag
         * @param [in] runningFlag : running flag.
         */
        void SetRunningFlag(const bool runningFlag);

        /**
         * @ingroup AicpuEventManager
         * @brief it use to get running flag
         * @return true: running, false: stopped
         */
        bool GetRunningFlag()
        {
            return runningFlag_;
        }

        /**
         * @ingroup SendCtrlCpuMsg
         * @brief send ctrl msg.
         * @param [in] custAicpuPid: msg dest pid
         * @param [in] eventType: msg type
         * @param [in] msg: msg body
         * @param [in] msgLen: msg len
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        __attribute__((visibility("default"))) int32_t SendCtrlCpuMsg(
            int32_t aicpuPid, const uint32_t eventType, char_t *msg, const uint32_t msgLen) const;

    private:
        AicpuEventManager();

        ~AicpuEventManager();

        AicpuEventManager(const AicpuEventManager &) = delete;

        AicpuEventManager &operator=(const AicpuEventManager &) = delete;

        /**
        * @ingroup AicpuEventManager
        * @brief it is used to parse the struct and get some parameter.
        * @param [in] eventInfo : the event information from mailbox.
        * @param [in] mailboxId : id of mail box
        * @param [in] info : the info is used to execute task.
        * @param [in] serialNo : the serial no. in mailbox, which is need to use in response package.
        * @param [out] streamId : streamId is used to cache task.
        * @param [out] taskId : task id.
        * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        int32_t HWTSKernelEventMessageParse(const event_info &eventInfo, uint32_t &mailboxId,
                                            aicpu::HwtsTsKernel &info, uint64_t &serialNo,
                                            uint32_t &streamId, uint64_t &taskId,
                                            uint16_t &dataDumpEnableMode) const;

        /**
         * @ingroup AicpuEventManager
         * @brief it is used to convert hwts_ts_kernel to cceKernel or fwkKernel.
         * @param [in] eventInfo : the event information from mailbox.
         * @param [in] info : the info is used to execute task.
         * @param [out] streamId : streamId is used to cache task.
         * @param [out] taskId : task id.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t HWTSConverMsgFromDriver2Aicpu(const event_info &eventInfo, aicpu::HwtsTsKernel &info,
                                              uint32_t &streamId, uint64_t &taskId,
                                              uint16_t &dataDumpEnableMode) const;

        /**
         * @ingroup AicpuEventManager
         * @brief it is used to execute HWTS_KERNEL event Task
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ExecuteHWTSEventTask(const EventInfoForExecute &executeEventInfo,
                                     aicpu::HwtsTsKernel &aicpufwKernelInfo,
                                     const event_info &drvEventInfo,
                                     hwts_response_t &hwtsResponse) const;
        /**
         * @ingroup AicpuEventManager
         * @brief it is used to execute HWTS_KERNEL event Task, kernelType is KERNEL_TYPE_AICPU_KFC
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ExecuteHWTSKFCEventTask(const event_info &drvEventInfo,
                                        const aicpu::HwtsTsKernel &aicpufwKernelInfo,
                                        const uint32_t threadIndex,
                                        const uint32_t streamId,
                                        const uint64_t taskId) const;
        /**
         * @ingroup AicpuEventManager
         * @brief it is used to process EVENT_SPLIT_KERNEL event
         * @param [in] drvEventInfo : the event information.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcSplitKernelEvent(const event_info &drvEventInfo, const uint32_t threadIndex) const;

        /**
         * @ingroup AicpuEventManager
         * @brief it is used to process EVENT_RANDOM_KERNEL event
         * @param [in] drvEventInfo : the event information.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcRandomKernelEvent(const event_info &drvEventInfo, const uint32_t threadIndex) const;

        /**
         * @ingroup AicpuEventManager
         * @brief it use to process all event.
         * @param [in] eventInfo : the event information from ts.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessEvent(const event_info &eventInfo, const uint32_t threadIndex);

        /**
         * @ingroup AicpuEventManager
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @brief it is used to wait event for once.
         */
        void DoOnce(const uint32_t threadIndex);

        /**
         * @ingroup AicpuEventManager
         * @brief it use to init control event version function map
         */
        void InitControlVersionFunc();

        /**
         * @ingroup AicpuEventManager
         * @brief it use to process control task from ts version 0
         * @param [in] drvEventInfo : the event information from ts.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessHWTSControlEventV0(const event_info &drvEventInfo);

        /**
         * @ingroup AicpuEventManager
         * @brief it use to process control task from ts version 1
         * @param [in] drvEventInfo : the event information from ts.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessHWTSControlEventV1(const event_info &drvEventInfo);
        
        /**
         * @ingroup AicpuEventManager
         * @brief it use to get stream id and task id form event info
        */
        void GetStreamIdAndTaskIdFromEvent(const hwts_ts_kernel &tsKernel,
                                           uint32_t &streamId, uint64_t &taskId, uint32_t subevent_id) const;
        using AicpuControlEventVersionFunc = int32_t (AicpuEventManager::*) (const event_info &);
        std::map<uint16_t, AicpuControlEventVersionFunc> controlEventVersionFuncMap_;

        // it is used to mark which is in call mode or multi-thread mode.
        std::atomic<bool> noThreadFlag_;

        // it is used to mark the loop.
        std::atomic<bool> runningFlag_;
    };
}
#endif
