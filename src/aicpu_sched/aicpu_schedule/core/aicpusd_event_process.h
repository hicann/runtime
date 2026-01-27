/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CORE_AICPUSD_EVENT_PROCESS_PROC_H
#define CORE_AICPUSD_EVENT_PROCESS_PROC_H

#include <atomic>
#include <string>
#include <mutex>
#include <thread>
#include "aicpu_event_struct.h"
#include "aicpusd_info.h"
#include "aicpusd_status.h"
#include "aicpusd_common.h"
#include "aicpu_context.h"
#include "profiling_adp.h"
#include "ascend_hal.h"
#include "event_custom_api_struct.h"
#include "ts_api.h"
#include "aicpu_engine.h"
#include "aicpusd_sqe_adapter.h"

namespace AicpuSchedule {
    using AicpuExtendSoPlatformFuncPtr = int32_t(*)(uint64_t, uint32_t);
    class AicpuEventProcess {
    public:
        static AicpuEventProcess &GetInstance();

        /**
         * @ingroup AicpuEventProcess
         * @brief init queue flag.
         */
        void InitQueueFlag();

        /**
         * @ingroup AicpuEventProcess
         * @brief it use to process the AICPU event.
         * @param [in] drvEventInfo : the event information from ts.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessAICPUEvent(const event_info &drvEventInfo);

        /**
         * @ingroup AicpuEventProcess
         * @brief it use to execute ts kernel task.
         * @param [in] aicpufwKernelInfo : the event information from ts.
         * @param [in] threadIndex : the id of thread.
         * @param [in] drvSubmitTick : the tick of drv event submit.
         * @param [in] drvSchedTick : the tick of drv event schedule.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ExecuteTsKernelTask(aicpu::HwtsTsKernel &tsKernelInfo,
                                    const uint32_t threadIndex,
                                    const uint64_t drvSubmitTick,
                                    const uint64_t drvSchedTick,
                                    const uint64_t streamId = 65535U,
                                    const uint64_t taskId = 65535U);

        /**
         * @ingroup AicpuEventProcess
         * @brief it use to process response information.
         * @param [in] ctrlMsg : the struct of control task.
         * @param [in] resultCode : the result of execute task.
         * @param [in] subEvent : it is used to store subeventid which is in receive struct.
         * @param [in] noThreadFlag : no thread flag.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessResponseInfo(AicpuSqeAdapter &adapter,
                                    const uint16_t resultCode,
                                    const uint32_t subEvent,
                                    const bool noThreadFlag) const;

        /**
         * @ingroup AicpuEventProcess
         * @brief it is used to process the report of task.
         * @param [in] info : the information of task.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessTaskReportEvent(AicpuSqeAdapter &aicpuSqeAdapter) const;

        /**
         * @ingroup AicpuEventProcess
         * @brief it is used to process the msg version.
         * @param [in] info : the information of task.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessMsgVersionEvent(AicpuSqeAdapter &aicpuSqeAdapter) const;

        /**
         * @ingroup AicpuEventProcess
         * @brief it use to process data dump event.
         * @param [in] ctrlMsg : the struct of control task.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessDumpDataEvent(AicpuSqeAdapter &aicpuSqeAdapter) const;

        /**
         * @ingroup AicpuEventProcess
         * @brief it use to process op mapping load event.
         * @param [in] ctrlMsg : the struct of control task.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessLoadOpMappingEvent(AicpuSqeAdapter &aicpuSqeAdapter) const;

        /**
         * @ingroup AicpuEventProcess
         * @brief it use to transfer device dump event to host.
         * @return AICPU_SCHEDULE_OK: success, other: error code
        */
        bool NeedTransforDumpInfo() const;

        /**
         * @ingroup AicpuEventProcess
         * @brief it use to process FFTSPlus data dump event.
         * @param [in] ctrlMsg : the struct of control task.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessDumpFFTSPlusDataEvent(AicpuSqeAdapter &aicpuSqeAdapter) const;

        /**
         * @ingroup AicpuEventProcess
         * @brief it use to process queue enqueue event.
         * @param [in] drvEventInfo : the queue event obj.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessEnqueueEvent(const event_info &drvEventInfo) const;

        /**
         * @ingroup AicpuEventProcess
         * @brief it use to process timeout config send by ts.
         * @param [in] ctrlMsg : the struct of control task..
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessSetTimeoutEvent(AicpuSqeAdapter &aicpuSqeAdapter) const;

        /**
         * @ingroup AicpuEventProcess
         * @brief it use to process queue not-empty event.
         * @param [in] queueId : the id of queue.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessQueueNotEmptyEvent(const uint32_t queueId) const;

        /**
         * @ingroup AicpuEventProcess
         * @brief it use to process queue not-full event.
         * @param [in] queueId : the id of queue.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessQueueNotFullEvent(const uint32_t queueId) const;

        /**
         * @ingroup ProcessLoadPlatformFromBuf
         * @brief process platfrom info.
         * @param [in] TsAicpuSqe &ctrlMsg
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ProcessLoadPlatformFromBuf(AicpuSqeAdapter &aicpuSqeAdapter);

        int32_t SendLoadPlatformFromBufMsgRsp(const int32_t resultCode, AicpuSqeAdapter &aicpuSqeAdapter) const;

    private:

        AicpuEventProcess();

        ~AicpuEventProcess();

        AicpuEventProcess(AicpuEventProcess &) = delete;

        AicpuEventProcess &operator=(AicpuEventProcess &) = delete;

        /**
         * @ingroup AicpuEventProcess
         * @brief it use to active aicpu stream.
         * @param [in] subEventInfo : the event info of aicpu.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t AICPUEventActiveAicpuStream(const AICPUSubEventInfo &subEventInfo) const;

        /**
         * @ingroup AicpuEventProcess
         * @brief it use to execute model.
         * @param [in] subEventInfo : the event info of aicpu.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t AICPUEventExecuteModel(const AICPUSubEventInfo &subEventInfo) const;

        /**
         * @ingroup AicpuEventProcess
         * @brief it use to repeat model.
         * @param [in] subEventInfo : the event info of aicpu.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t AICPUEventRepeatModel(const AICPUSubEventInfo &subEventInfo) const;

        /**
         * @ingroup AicpuEventProcess
         * @brief it use to recovery stream.
         * @param [in] subEventInfo : the event info of aicpu.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t AICPUEventRecoveryStream(const AICPUSubEventInfo &subEventInfo) const;

        /**
         * @ingroup AicpuEventProcess
         * @brief it use to update profiling mode.
         * @param [in] subEventInfo : the event info of aicpu.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t AICPUEventUpdateProfilingMode(const AICPUSubEventInfo &subEventInfo) const;

        /**
         * @ingroup AicpuEventProcess
         * @brief it use to end graph (from ge).
         * @param [in] subEventInfo : the event info of aicpu.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t AICPUEventEndGraph(const AICPUSubEventInfo &subEventInfo) const;

        /**
         * @ingroup AicpuEventProcess
         * @brief it use to recover stream which is pending on prepareMem.
         * @param [in] subEventInfo : the event info of aicpu.
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t AICPUEventPrepareMem(const AICPUSubEventInfo &subEventInfo) const;

        int32_t AICPUEventTableUnlock(const AICPUSubEventInfo &subEventInfo) const;

        int32_t AICPUEventSupplyEnque(const AICPUSubEventInfo &subEventInfo) const;

        /**
         * @ingroup AicpuEventProcess
         * @brief it use to execute logic kernel.
         * @param tsKernelInfo ts kernel info
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t ExecuteLogicKernel(aicpu::HwtsTsKernel &tsKernelInfo) const;

        /**
         * @ingroup AicpuEventProcess
         * @brief is use to check cust aicpu kernel
         * @param ctrlMsg Dump Origin Info
         * @param ackStreamId Ack Stream Id
         * @param ackTaskId Ack Task Id
         * @param ackModelId Ack Model Id
         * @param dumpRet Dump Result
         * @return AICPU_SCHEDULE_OK: success, other: error code
         */
        int32_t SendDumpResponceInfo(AicpuSqeAdapter &adapter,  const int32_t &dumpRet) const;

        AicpuExtendSoPlatformFuncPtr GetAicpuExtendSoPlatformFuncPtr();

        void PostProcessTsKernelTask(const int32_t errorCode, const uint64_t streamId, const uint64_t taskId) const;

    private:
        // exit queue
        std::atomic<bool> exitQueueFlag_;

        using EventProcess = int32_t (AicpuEventProcess::*)(const AICPUSubEventInfo &info) const;
        EventProcess eventTaskProcess_[AICPU_SUB_EVENT_MAX_NUM] = {nullptr};
        std::mutex mutexForPlatformPtr_;
        AicpuExtendSoPlatformFuncPtr platformFuncPtr_;
    };
}
#endif