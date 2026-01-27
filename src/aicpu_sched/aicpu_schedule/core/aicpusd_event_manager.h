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
#include <mutex>
#include <thread>
#include <bitset>
#include "aicpu_event_struct.h"
#include "aicpusd_status.h"
#include "aicpusd_common.h"
#include "aicpusd_info.h"
#include "ascend_hal.h"
#include "event_custom_api_struct.h"
#include "aicpusd_sqe_adapter.h"
#include "ts_api.h"

namespace AicpuSchedule {
    constexpr uint32_t ENABLE_MODE_OFFSET = 48U;
    constexpr uint32_t DATADUMP_ENABLE_MODE_OFFSET = 49U;
    constexpr uint32_t DEBUGDUMP_ENABLE_MODE_OFFSET = 50U;
    constexpr uint32_t MAX_AICPU_THREAD_NUM = 32U;
    // timeout interval
    constexpr int32_t AICPU_TIMEOUT_INTERVAL = 3000;

    class AicpuEventManager {
    public:
        __attribute__((visibility("default"))) static AicpuEventManager &GetInstance();

        /**
         * @ingroup AicpuEventManager
         * @brief it use to init.
         * @param [in] noThreadFlag : have thread flag.
         * @param [in] runningFlag : running flag.
         * @param [in] grpId : group id.
         * @param [in] aicpuSchedMode : aicpu sched mode.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        __attribute__((visibility("default"))) void InitEventMgr(const bool noThreadFlag,
                                                                 const bool runningFlag,
                                                                 const uint32_t grpId,
                                                                 const AicpuSchedMode aicpuSchedMode);

        /**
         * @ingroup AicpuEventManager
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @brief it is used in multi-thread.
         */
        void LoopProcess(const uint32_t threadIndex);

        /**
        * @ingroup AicpuEventManager
        * @brief it use to set the exit flag of loop which wait event.
        */
        void CheckAndSetExitFlag(void) const;
        bool ModelLoopTimeOut(const int32_t retVal, uint32_t &waitCounter, const uint32_t maxCounter);
        /**
         * @ingroup AicpuEventManager
         * @brief it is used in call model, which is used in different thread need different while loop variable.
         */
        void CallModeLoopProcess();

        /**
         * @ingroup AicpuEventManager
         * @brief it is used to parse the struct and get some parameter.
         * @param [in] drvEventInfo : the event information from mailbox.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessHWTSKernelEvent(const event_info &drvEventInfo,
                                       const uint32_t threadIndex) const;

        /**
         * @ingroup AicpuEventManager
         * @brief it use to process control task from ts
         * @param [in] drvEventInfo : the event information from ts.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessHWTSControlEvent(const event_info &drvEventInfo);

        /**
         * @ingroup AicpuEventManager
         * @brief it use to execute the model from call interface.
         * @param [in] modelId : the id of model.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ExecuteProcess(const uint32_t modelId);

        /**
         * @ingroup AicpuEventManager
         * @brief it use to execute the model from call interface.
         * @param [in] drvEventInfo : event info.
         * @param [out] drvEventAck : event ack.
         * @return 0: success, other: error code
         */
        int32_t ExecuteProcessSyc(const event_info * const drvEventInfo, event_ack * const drvEventAck);

        /**
         * @ingroup AicpuEventManager
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @param [in] deviceId : device id
         * @brief it is used to wait event for once.
         */
        int32_t DoOnce(const uint32_t threadIndex, const uint32_t deviceId,
                       const int32_t timeout = AICPU_TIMEOUT_INTERVAL);

        /**
         * @ingroup AicpuEventManager
         * @brief it use to set running flag
         * @param [in] runningFlag : running flag.
         */
        void SetRunningFlag(const bool runningFlag);

        /**
        * @ingroup AicpuEventManager
        * @brief print aic error report info
        * @param [in] reportInfo : info from aicpu sd adapter.
        */
        void PrintAicErrReportInfo(const AicpuSqeAdapter::AicErrReportInfo &reportInfo);
        /**
         * @ingroup AicpuEventManager
         * @brief it use to get running flag
         * @return true: running, false: stopped
         */
        bool GetRunningFlag()
        {
            return runningFlag_;
        }

    private:
        AicpuEventManager();

        virtual ~AicpuEventManager()
        {
            if (cancelLastword_ != nullptr) {
                cancelLastword_();
            }
        };

        AicpuEventManager(const AicpuEventManager &) = delete;

        AicpuEventManager &operator=(const AicpuEventManager &) = delete;

        int32_t DoOnceEsched(const uint32_t threadIndex, const uint32_t deviceId, const int32_t timeout);
        int32_t DoOnceMsq(const uint32_t threadIndex, const uint32_t deviceId, const int32_t timeout);

        /**
        * @ingroup AicpuEventManager
        * @brief it use to execute the model from ts.
        * @param [in] modelId : the id of model.
        * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        int32_t TsControlExecuteProcess(const uint32_t modelId) const;

        /**
         * @ingroup AicpuEventManager
         * @brief it use to process task abort.
         * @param [in] info : the information of task.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t TsControlTaskAbort(const AicpuSqeAdapter::AicpuModelOperateInfo &info) const;

        /**
         * @ingroup AicpuEventManager
         * @brief it use to process distributing event.
         * @param [in] info : the information of task.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t EventDistribution(const AicpuSqeAdapter::AicpuModelOperateInfo &info) const;

        /**
         * @ingroup AicpuEventManager
         * @brief it use to process TS_AICPU_MODEL_DESTROY task.
         * @param [in] info : the information of task.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessTsAicpuModelDestroy(const AicpuSqeAdapter::AicpuModelOperateInfo &info) const;

        /**
         * @ingroup AicpuEventManager
         * @brief it use to process control task from ts
         * @param [in] ctrlMsg : the struct of control task.
         * @param [in] subEvent : it is used to store subeventid which is in receive struct.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessModelEvent(AicpuSqeAdapter &aicpuSqeAdapter, const uint32_t subEvent);

        /**
        * @ingroup AicpuEventManager
        * @brief it is used to parse the struct and get some parameter.
        * @param [in] drvEventInfo : the event information from mailbox.
        * @param [in] mailboxId : mailbox id
        * @param [in] info : the info is used to execute task.
        * @param [in] serialNo : the serial no. in mailbox, which is need to use in response package.
        * @param [out] streamId : streamId is used to cache task.
        * @param [out] taskId : task id.
        * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        int32_t HWTSKernelEventMessageParse(const event_info &drvEventInfo, uint32_t &mailboxId,
                                            aicpu::HwtsTsKernel &info, uint64_t &serialNo,
                                            uint32_t &streamId, uint64_t &taskId,
                                            uint16_t &dataDumpEnableMode) const;

        /**
         * @ingroup AicpuEventManager
         * @brief it is used to process dvpp event.
         * @param [in] drvEventInfo : the event information from mailbox.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessDvppEvent(const event_info &drvEventInfo, const uint32_t threadIndex) const;

        /**
         * @ingroup AicpuEventManager
         * @brief it is used to process host mpi dvpp event.
         * @param [in] drvEventInfo : the event information from mailbox.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessMpiDvppEvent(const event_info &drvEventInfo, const uint32_t threadIndex) const;

        /**
         * @ingroup AicpuEventManager
         * @brief it is used to process retr event.
         * @param [in] drvEventInfo : the event information from mailbox.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessRetrEvent(const event_info &drvEventInfo, const uint32_t threadIndex) const;

        /**
         * @ingroup AicpuEventManager
         * @brief it is used to process cdq event.
         * @param [in] drvEventInfo : the event information from mailbox.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessCdqEvent(const event_info &drvEventInfo) const;

        /**
         * @ingroup AicpuEventManager
         * @brief it use to process all event.
         * @param [in] drvEventInfo : the event information from ts.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessEvent(const event_info &drvEventInfo, const uint32_t threadIndex);

        /**
         * @ingroup AicpuEventManager
         * @brief it use to process default event.
         * @param [in] drvEventInfo : the event information
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcDefaultEvent(const event_info &drvEventInfo, const uint32_t threadIndex);

        /**
         * @ingroup AicpuEventManager
         * @brief it is used to process EVENT_TS_HWTS_KERNEL event
         * @param [in] drvEventInfo : the event information.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcTsHWTSEvent(const event_info &drvEventInfo, const uint32_t threadIndex);

        /**
         * @ingroup AicpuEventManager
         * @brief it is used to execute HWTS_KERNEL event Task
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ExecuteHWTSEventTask(const uint32_t &threadIndex,
                                     const uint32_t &streamId,
                                     const uint64_t taskId,
                                     const uint64_t &serialNo,
                                     aicpu::HwtsTsKernel &aicpufwKernelInfo,
                                     const event_info &drvEventInfo,
                                     const uint32_t &mailboxId,
                                     hwts_response_t &hwtsResp,
                                     uint16_t &dataDumpEnableMode) const;
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
         * @brief it is used to process EVENT_DVPP_MSG event
         * @param [in] drvEventInfo : the event information.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcDvppMsgEvent(const event_info &drvEventInfo, const uint32_t threadIndex);

        /**
         * @ingroup AicpuEventManager
         * @brief it is used to process EVENT_DVPP_MPI_MSG event
         * @param [in] drvEventInfo : the event information.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcDvppMpiMsgEvent(const event_info &drvEventInfo, const uint32_t threadIndex);

        /**
         * @ingroup AicpuEventManager
         * @brief it is used to process EVENT_FR_MSG event
         * @param [in] drvEventInfo : the event information.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcFrMsgEvent(const event_info &drvEventInfo, const uint32_t threadIndex);

        /**
         * @ingroup AicpuEventManager
         * @brief it is used to process EVENT_SPLIT_KERNEL event
         * @param [in] drvEventInfo : the event information.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcSplitKernelEvent(const event_info &drvEventInfo, const uint32_t threadIndex);

        /**
         * @ingroup AicpuEventManager
         * @brief it is used to process EVENT_RANDOM_KERNEL event
         * @param [in] drvEventInfo : the event information.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcRandomKernelEvent(const event_info &drvEventInfo, const uint32_t threadIndex);

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
         * @brief it is used to process EVENT_QUEUE_EMPTY_TO_NOT_EMPTY event
         * @param [in] drvEventInfo : the event information.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcQueueEmptyToNotEmptyEvent(const event_info &drvEventInfo, const uint32_t threadIndex);

        /**
         * @ingroup AicpuEventManager
         * @brief it is used to process EVENT_QUEUE_EMPTY_TO_NOT_EMPTY event
         * @param [in] drvEventInfo : the event information.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcQueueFullToNotFullEvent(const event_info &drvEventInfo, const uint32_t threadIndex);

        /**
         * @ingroup AicpuEventManager
         * @brief it is used to process EVENT_AICPU_MSG event
         * @param [in] drvEventInfo : the event information.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcAicpuMsgEvent(const event_info &drvEventInfo, const uint32_t threadIndex);

        /**
         * @ingroup AicpuEventManager
         * @brief it is used to process EVENT_QUEUE_ENQUEUE event
         * @param [in] drvEventInfo : the event information.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcQueueEvent(const event_info &drvEventInfo, const uint32_t threadIndex);

        /**
         * @ingroup AicpuEventManager
         * @brief it is used to process EVENT_TDT_ENQUEUE, EVENT_ACPU_MSG_TYPE1 event
         * @param [in] drvEventInfo : the event information.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcOnPreprocessEvent(const event_info &drvEventInfo, const uint32_t threadIndex);

        /**
         * @ingroup AicpuEventManager
         * @brief it is used to process EVENT_CDQ_MSG event
         * @param [in] drvEventInfo : the event information.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcCDQEvent(const event_info &drvEventInfo, const uint32_t threadIndex);

        /**
         * @ingroup AicpuEventManager
         * @brief it is used to process EVENT_QS_MSG event
         * @param [in] drvEventInfo : the event information.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcQsEvent(const event_info &drvEventInfo, const uint32_t threadIndex);

        /**
         * @ingroup AicpuEventManager
         * @brief it is used to process EVENT_DRV_MSG event
         * @param [in] drvEventInfo : the event information.
         * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcDrvEvent(const event_info &drvEventInfo, const uint32_t threadIndex);

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
         * @brief it use to init control event version function map
        */
        void InitControlVersionFunc();

        /**
         * @ingroup AicpuEventManager
         * @brief it use to get stream id and task id form event info
        */
        void GetStreamIdAndTaskIdFromEvent(const hwts_ts_kernel &tsKernel,
                                           uint32_t &streamId, uint64_t &taskId, uint32_t subevent_id) const;

        void InitLastwordCallback();

        int32_t ProcProxyEvent(const event_info &drvEventInfo, const uint32_t threadIndex);
        int32_t FillEvent(const AicpuTopicMailbox &mb, event_info &eventInfo) const;
        int32_t FillEventCommInfo(const AicpuTopicMailbox &mb, event_info &eventInfo) const;
        int32_t FillEventPrivHwtsInfo(const AicpuTopicMailbox &mb, event_info &eventInfo) const;
        int32_t FillEventPrivCommInfo(const AicpuTopicMailbox &mb, event_info &eventInfo) const;

        int32_t SendResponse(const uint32_t deviceId, const uint32_t subEventId, hwts_response_t &resp) const;
        int32_t ResponseMsq(const uint32_t deviceId, const uint32_t subEventId, hwts_response_t &resp) const;
        int32_t ResponseEsched(const uint32_t deviceId, const uint32_t subEventId, hwts_response_t &resp) const;

        // it is used to mark which is in call mode or multi-thread mode.
        std::atomic<bool> noThreadFlag_;

        // it is used to mark the loop.
        std::atomic<bool> runningFlag_;

        // the id is used to group in process.
        uint32_t groupId_;

        using AicpuEventGetFunc = int32_t (AicpuEventManager::*)(const uint32_t, const uint32_t, const int32_t);
        AicpuEventGetFunc eventGetFunc_;

        using AicpuEventRspFunc = int32_t (AicpuEventManager::*)(const uint32_t, const uint32_t, hwts_response_t &) const;
        AicpuEventRspFunc eventRspFunc_;

        using AicpuControlEventVersionFunc = int32_t (AicpuEventManager::*) (const event_info &);
        std::map<uint16_t, AicpuControlEventVersionFunc> controlEventVersionFuncMap_;

        // event process funtion type
        using AicpuEventProc = int32_t (AicpuEventManager::*)(const event_info &, const uint32_t);

        AicpuEventProc aicpuEventProcFunc_[EVENT_MAX_NUM] = {nullptr};

        uint64_t recvEventStat_[MAX_AICPU_THREAD_NUM][EVENT_MAX_NUM];
        uint64_t procEventStat_[MAX_AICPU_THREAD_NUM][EVENT_MAX_NUM];
        std::function<void()> cancelLastword_ = nullptr;
    };
}
#endif
