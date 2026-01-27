/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpusd_event_manager.h"
#include <cstdint>
#include <securec.h>
#include <unistd.h>
#include <sstream>
#include "ascend_hal.h"
#include "aicpusd_interface_process.h"
#include "aicpusd_event_process.h"
#include "aicpusd_threads_process.h"
#include "dump_task.h"
#include "ts_api.h"
#include "aicpu_context.h"
#include "aicpu_async_event.h"
#include "aicpu_sched/common/aicpu_task_struct.h"
#include "aicpusd_resource_manager.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_model_execute.h"
#include "aicpu_engine.h"
#include "aicpusd_monitor.h"
#include "aicpusd_lastword.h"
#include "task_queue.h"
#include "aicpusd_profiler.h"
#include "aicpusd_msg_send.h"
#include "common/aicpusd_util.h"
#include "aicpusd_mpi_mgr.h"
#include "aicpu_pulse.h"
#include "aicpusd_queue_event_process.h"
#include "type_def.h"

namespace AicpuSchedule {
    namespace {
        constexpr uint32_t AICPU_TIMEOUT_INTERVAL = 3000U;
    }

    /**
     * @ingroup AicpuEventManager
     * @brief it is used to construct a object of AicpuEventManager.
     */
    AicpuEventManager::AicpuEventManager()
        : noThreadFlag_(true),
          runningFlag_(true),
          groupId_(0U)
    {
        aicpuEventProcFunc_[EVENT_TS_CTRL_MSG] = &AicpuEventManager::ProcTsCtrlEvent;
    }

    AicpuEventManager &AicpuEventManager::GetInstance()
    {
        static AicpuEventManager instance;
        return instance;
    }

    /**
     * @ingroup AicpuEventManager
     * @brief it use to process control task from ts
     * @param [in] drvEventInfo : the event information from ts.
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    int32_t AicpuEventManager::ProcessHWTSControlEvent(const event_info &drvEventInfo)
    {
        // for the msg is address of array, it is not a nullptr.
        // so the info is not used to judge whether is nullptr;
        const TsAicpuSqe * const ctrlMsg = PtrToPtr<const char_t, const TsAicpuSqe>(drvEventInfo.priv.msg);
        const uint16_t version = FeatureCtrl::GetTsMsgVersion();
        AicpuSqeAdapter aicpuSqeAdapter(*ctrlMsg, version);
        uint8_t cmdType = aicpuSqeAdapter.GetCmdType();
        aicpusd_info("Begin to process ctrl msg, cmd type[%u].", cmdType);
        int32_t ret = AICPU_SCHEDULE_OK;
        switch (cmdType) {
            case AICPU_DATADUMP_REPORT: // dump data
                ret = AicpuEventProcess::GetInstance().ProcessDumpDataEvent(aicpuSqeAdapter);
                break;
            case AICPU_DATADUMP_LOADINFO: // load op mapping info for dump
                ret = AicpuEventProcess::GetInstance().ProcessLoadOpMappingEvent(aicpuSqeAdapter);
                break;

            case AICPU_FFTS_PLUS_DATADUMP_REPORT: // dump FFTSPlus data
                ret = AicpuEventProcess::GetInstance().ProcessDumpFFTSPlusDataEvent(aicpuSqeAdapter);
                break;
            default:
                aicpusd_err("The event is not found, cmd type[%u]", cmdType);
                ret = AICPU_SCHEDULE_ERROR_NOT_FOUND_EVENT;
                break;
        }
        return ret;
    }


    int32_t AicpuEventManager::ProcTsCtrlEvent(const event_info &drvEventInfo, const uint32_t threadIndex)
    {
        (void)threadIndex;
        const int32_t ret = ProcessHWTSControlEvent(drvEventInfo);
        aicpusd_info("Finish to process CTRL event, eventid[%u], threadIndex[%u], ret[%d].",
                     drvEventInfo.comm.event_id, threadIndex, ret);
        return ret;
    }
    /**
     * @ingroup AicpuEventManager
     * @brief it use to process all event.
     * @param [in] drvEventInfo : the event information from ts.
     * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    int32_t AicpuEventManager::ProcessEvent(const event_info &drvEventInfo, const uint32_t threadIndex)
    {
        int32_t ret = AICPU_SCHEDULE_OK;
        if (drvEventInfo.comm.event_id >= EVENT_MAX_NUM) {
            aicpusd_err("Unknown event type, event_id[%u].", drvEventInfo.comm.event_id);
            ret = AICPU_SCHEDULE_ERROR_NOT_FOUND_EVENT;
            return ret;
        }
        const AicpuEventProc aicpuEventFunc = aicpuEventProcFunc_[drvEventInfo.comm.event_id];
        if (aicpuEventFunc != nullptr) {
            ret = (this->*aicpuEventFunc)(drvEventInfo, threadIndex);
        } else {
            aicpusd_err("Unknown event type, event_id[%u].", drvEventInfo.comm.event_id);
            ret = AICPU_SCHEDULE_ERROR_NOT_FOUND_EVENT;
        }
        return ret;
    }
    /**
     * @ingroup AicpuEventManager
     * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
     * @brief it is used to wait event for once.
     */
    int32_t AicpuEventManager::DoOnce(const uint32_t threadIndex, const uint32_t deviceId, const int32_t timeout)
    {
        event_info drvEventInfo;
        const int32_t retVal = halEschedWaitEvent(deviceId, groupId_, threadIndex, timeout, &drvEventInfo);
        if (retVal == DRV_ERROR_NONE) {
            (void) ProcessEvent(drvEventInfo, threadIndex);
        } else if (retVal == DRV_ERROR_SCHED_WAIT_TIMEOUT) { // if timeout, will continue wait event.
        } else if ((retVal == DRV_ERROR_SCHED_PROCESS_EXIT) || (retVal == DRV_ERROR_SCHED_PARA_ERR)) {
            if (runningFlag_) {
                runningFlag_ = false;
            }
            aicpusd_warn("Failed to get event, error code=%d, deviceId[%u], groupId[%u], threadIndex[%u]",
                         retVal, deviceId, groupId_, threadIndex);
        } else if (retVal == DRV_ERROR_SCHED_RUN_IN_ILLEGAL_CPU) {
            runningFlag_ = false;
            aicpusd_err("Cpu Illegal get event, error code[%d], deviceId[%u], groupId[%u], threadIndex[%u]",
                        retVal, deviceId, groupId_, threadIndex);
        } else {
            // record a error code
            aicpusd_err("Failed to get event, error code[%d], deviceId[%u], groupId[%u], threadIndex[%u]",
                        retVal, deviceId, groupId_, threadIndex);
        }
        return retVal;
    }

    /**
     * @ingroup AicpuEventManager
     * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
     * @brief it is used in multi-thread.
     */
    void AicpuEventManager::LoopProcess(const uint32_t threadIndex)
    {
        const uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
        while (runningFlag_) {
            (void)DoOnce(threadIndex, deviceId);
        }
        aicpusd_info("The loop of getting event is exit in thread[%u].", threadIndex);
    }

    void AicpuEventManager::SetRunningFlag(const bool runningFlag)
    {
        runningFlag_ = runningFlag;
    }
}
