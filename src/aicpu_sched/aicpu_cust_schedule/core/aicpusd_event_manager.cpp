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

#include <string>
#include <securec.h>
#include <sstream>
#include "aicpusd_status.h"
#include "aicpusd_util.h"
#include "aicpu_context.h"
#include "aicpusd_monitor.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_event_process.h"
#include "aicpusd_threads_process.h"
#include "dump_task.h"
#include "aicpu_engine.h"
#include "aicpu_cust_sd_dump_process.h"
#include "aicpusd_interface.h"

namespace {
    // stream id
    const std::string CONTEXT_KEY_STREAM_ID = "streamId";
    static constexpr uint64_t CONVER_DRIVER_2_AICPU = 0x0000FFFFFFFFFFFFU;
}

namespace AicpuSchedule {
    constexpr uint32_t TIMEOUT_INTERVAL = 2000U;
    /**
     * @ingroup AicpuEventManager
     * @brief it is used to construct a object of AicpuEventManager.
     */
    AicpuEventManager::AicpuEventManager()
        : noThreadFlag_(true),
          runningFlag_(true) {}

    /**
     * @ingroup AicpuEventManager
     * @brief it is used to destructor a object of AicpuEventManager.
     */
    AicpuEventManager::~AicpuEventManager() {}

    AicpuEventManager &AicpuEventManager::GetInstance()
    {
        static AicpuEventManager instance;
        return instance;
    }

    /**
     * @ingroup AicpuEventManager
     * @brief it use to init.
     * @param [in] noThreadFlag : have thread flag.
     * @param [in] runningFlag : running flag.
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    void AicpuEventManager::InitEventManager(const bool noThreadFlag, const bool runningFlag)
    {
        noThreadFlag_ = noThreadFlag;
        runningFlag_ = runningFlag;
    }

    /**
    * @ingroup AicpuEventManager
    * @brief it is used to parse the struct and get some parameter.
    * @param [in] eventInfo : the event information from mailbox.
    * @param [in] mailboxId : mail box id
    * @param [in] info : the info is used to execute task.
    * @param [in] serialNo : the serial no. in mailbox, which is need to use in response package.
    * @param [out] streamId : streamId is used to cache task.
    * @return AICPU_SCHEDULE_OK: success, other: error code
    */
    int32_t AicpuEventManager::HWTSKernelEventMessageParse(const event_info &eventInfo,
                                                           uint32_t &mailboxId,
                                                           aicpu::HwtsTsKernel &info,
                                                           uint64_t &serialNo,
                                                           uint32_t &streamId,
                                                           uint64_t &taskId,
                                                           uint16_t &dataDumpEnableMode) const
    {
        // for the msg is address of array, it is not a nullptr.
        const hwts_ts_task * const eventMsg = PtrToPtr<const char_t, const hwts_ts_task>(eventInfo.priv.msg);
        mailboxId = eventMsg->mailbox_id;
        serialNo = eventMsg->serial_no;
        return HWTSConverMsgFromDriver2Aicpu(eventInfo, info, streamId, taskId, dataDumpEnableMode);
    }

    /**
     * @ingroup AicpuEventManager
     * @brief it use to get stream id and task id form event info
    */
    void AicpuEventManager::GetStreamIdAndTaskIdFromEvent(const hwts_ts_kernel &tsKernel, uint32_t &streamId, 
                                                         uint64_t &taskId, uint32_t subevent_id) const 
    {
        uint32_t tmpStreamId = 0U;
        aicpusd_info("Get stream id[%u] and task id[%u] from hwts.", tsKernel.streamID, tsKernel.taskID);
        tmpStreamId = static_cast<uint32_t>(tsKernel.streamID);
        if (subevent_id != EVENT_FFTS_PLUS_MSG) {
            taskId = static_cast<uint32_t>(tsKernel.taskID);
        }
        uint16_t version = FeatureCtrl::GetTsMsgVersion();
        if (version == VERSION_0) {
            streamId = tmpStreamId;
        } else {
            streamId = INVALID_VAL;
        }
        aicpusd_info("Get stream id[%u] and task id[%u] in version[%hu].", 
                     streamId, taskId, version);
        return;
    }
    /**
     * @ingroup AicpuEventManager
     * @brief it is used to convert hwts_ts_kernel to cceKernel or fwkKernel.
     * @param [in] eventInfo : the event information from mailbox.
     * @param [in] info : the info is used to execute task.
     * @param [out] streamId : streamId is used to cache task.
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    int32_t AicpuEventManager::HWTSConverMsgFromDriver2Aicpu(const event_info &eventInfo,
                                                             aicpu::HwtsTsKernel &info,
                                                             uint32_t &streamId,
                                                             uint64_t &taskId,
                                                             uint16_t &dataDumpEnableMode) const
    {
        int32_t ret = AICPU_SCHEDULE_OK;
        // for the msg is address of array, it is not a nullptr.
        const hwts_ts_task * const eventMsg = PtrToPtr<const char_t, const hwts_ts_task>(eventInfo.priv.msg);
        const hwts_ts_kernel tsKernel = eventMsg->kernel_info;
        GetStreamIdAndTaskIdFromEvent(tsKernel, streamId, taskId, eventInfo.comm.subevent_id);
        dataDumpEnableMode = static_cast<uint16_t>((tsKernel.l2Ctrl >> DATADUMP_ENABLE_MODE_OFFSET) & 1U);
        const uint32_t eventKernelType = static_cast<uint32_t>(tsKernel.kernel_type);
        aicpusd_info("Kernel type of current task is [%u], dataDumpEnableMode[%u].",
                     eventKernelType, dataDumpEnableMode);
        if (eventKernelType == aicpu::KERNEL_TYPE_AICPU_CUSTOM_KFC) {
            info.kernelType = eventKernelType;
            info.kernelBase.cceKernel.kernelName = static_cast<uint64_t>(tsKernel.kernelName & CONVER_DRIVER_2_AICPU);
            info.kernelBase.cceKernel.kernelSo = static_cast<uint64_t>(tsKernel.kernelSo & CONVER_DRIVER_2_AICPU);
            info.kernelBase.cceKernel.paramBase = static_cast<uint64_t>(tsKernel.paramBase & CONVER_DRIVER_2_AICPU);
            info.kernelBase.cceKernel.blockId = tsKernel.blockId;
            info.kernelBase.cceKernel.blockNum = tsKernel.blockNum;
        } else if (eventKernelType == aicpu::KERNEL_TYPE_AICPU_CUSTOM) {
            info.kernelType = eventKernelType;
            info.kernelBase.cceKernel.kernelName = static_cast<uint64_t>(tsKernel.kernelName & CONVER_DRIVER_2_AICPU);
            info.kernelBase.cceKernel.kernelSo = static_cast<uint64_t>(tsKernel.kernelSo & CONVER_DRIVER_2_AICPU);
            info.kernelBase.cceKernel.paramBase = static_cast<uint64_t>(tsKernel.paramBase & CONVER_DRIVER_2_AICPU);
            info.kernelBase.cceKernel.l2VaddrBase = static_cast<uint64_t>(tsKernel.l2VaddrBase & CONVER_DRIVER_2_AICPU);
            info.kernelBase.cceKernel.blockId = tsKernel.blockId;
            info.kernelBase.cceKernel.blockNum = tsKernel.blockNum;
            info.kernelBase.cceKernel.l2Size = 0U;
            info.kernelBase.cceKernel.l2InMain = tsKernel.l2InMain;
        } else {
            aicpusd_err("Don't support kernel_type[%u].", eventKernelType);
            ret = AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        return ret;
    }

    /**
    * @ingroup AicpuEventManager
    * @brief it use to init control event version function map
    */
    void  AicpuEventManager::InitControlVersionFunc() 
    {
        controlEventVersionFuncMap_[VERSION_0] = &AicpuEventManager::ProcessHWTSControlEventV0;
        controlEventVersionFuncMap_[VERSION_1] = &AicpuEventManager::ProcessHWTSControlEventV1;
        return;
    }

    /**
     * @ingroup AicpuEventManager
     * @brief it use to process control task from ts
     * @param [in] drvEventInfo : the event information from ts.
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    int32_t AicpuEventManager::ProcessHWTSControlEvent(const event_info &drvEventInfo)
    {
        uint16_t version = FeatureCtrl::GetTsMsgVersion();
        aicpusd_info("Begin to process version[%hu] ctrl msg.", version);
        InitControlVersionFunc();
        int32_t ret = AICPU_SCHEDULE_OK;
        if (controlEventVersionFuncMap_.find(version) == controlEventVersionFuncMap_.end()) {
            aicpusd_err("The version[%hu] does not have a corresponding processing function.", version);
            return AICPU_SCHEDULE_ERROR_NOT_FOUND_VERSION;
        }
        ret = (this->*controlEventVersionFuncMap_[version])(drvEventInfo);
        return ret;
    }

    /**
    * @ingroup AicpuEventManager
    * @brief it use to process control task from ts version 0
    * @param [in] drvEventInfo : the event information from ts.
    * @return AICPU_SCHEDULE_OK: success, other: error code
    */
    int32_t AicpuEventManager::ProcessHWTSControlEventV0(const event_info &drvEventInfo)
    {
        // for the msg is address of array, it is not a nullptr.
        // so the info is not used to judge whether is nullptr;
        const TsAicpuSqe * const ctrlMsg = PtrToPtr<const char_t, const TsAicpuSqe>(drvEventInfo.priv.msg);
        const uint16_t version = FeatureCtrl::GetTsMsgVersion();
        AicpuSqeAdapter aicpuSqeAdapter(*ctrlMsg, version);
        uint8_t cmdType = aicpuSqeAdapter.GetCmdType();
        aicpusd_info("Begin to process version[%hu] ctrl msg, cmd type[%u].", version, cmdType);
        int32_t ret = AICPU_SCHEDULE_OK;
        switch (cmdType) {
            case AICPU_MSG_VERSION : {
                    ret = AicpuEventProcess::GetInstance().ProcessMsgVersionEvent(aicpuSqeAdapter);
                    break;
            }
            case AICPU_DATADUMP_LOADINFO: // load op mapping info for dump
                ret = AicpuEventProcess::GetInstance().ProcessLoadOpMappingEvent(aicpuSqeAdapter);
                break;

            default:
                aicpusd_err("The event is not found, cmd type[%u]", cmdType);
                return AICPU_SCHEDULE_ERROR_NOT_FOUND_EVENT;
        }
        return ret;
    }

    /**
    * @ingroup AicpuEventManager
    * @brief it use to process control task from ts version 1
    * @param [in] drvEventInfo : the event information from ts.
    * @return AICPU_SCHEDULE_OK: success, other: error code
    */
    int32_t AicpuEventManager::ProcessHWTSControlEventV1(const event_info &drvEventInfo)
    {
        // for the msg is address of array, it is not a nullptr.
        // so the info is not used to judge whether is nullptr;
        const TsAicpuMsgInfo * const msgInfo = PtrToPtr<const char_t, const TsAicpuMsgInfo>(drvEventInfo.priv.msg);
        const uint16_t version = FeatureCtrl::GetTsMsgVersion();
        AicpuSqeAdapter aicpuSqeAdapter(*msgInfo, version);
        uint8_t cmdType = aicpuSqeAdapter.GetCmdType();
        aicpusd_info("Begin to process version[%hu] ctrl msg, cmd type[%u].", version, cmdType);
        int32_t ret = AICPU_SCHEDULE_OK;
        switch (cmdType) {
            case TS_AICPU_MSG_VERSION : {
                    ret = AicpuEventProcess::GetInstance().ProcessMsgVersionEvent(aicpuSqeAdapter);
                    break;
            }
            case TS_AICPU_DATADUMP_INFO_LOAD: // load op mapping info for dump
                ret = AicpuEventProcess::GetInstance().ProcessLoadOpMappingEvent(aicpuSqeAdapter);
                break;
            default:
                aicpusd_err("The event is not found, cmd type[%u]", cmdType);
                return AICPU_SCHEDULE_ERROR_NOT_FOUND_EVENT;
        }
        return ret;
    }


    int32_t AicpuEventManager::ProcTsCtrlEvent(const event_info &drvEventInfo, const uint32_t threadIndex)
    {
        (void)threadIndex;
        const int32_t ret = ProcessHWTSControlEvent(drvEventInfo);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Process CTRL event failed, eventId=%u, ret=%d.", drvEventInfo.comm.event_id, ret);
            return ret;
        }

        aicpusd_info("Finish to process CTRL event, eventid[%u], threadIndex[%u], ret[%d].",
                     drvEventInfo.comm.event_id, threadIndex, ret);
        return ret;
    }
    int32_t AicpuEventManager::ExecuteHWTSKFCEventTask(const event_info &drvEventInfo,
                                                       const aicpu::HwtsTsKernel &aicpufwKernelInfo,
                                                       const uint32_t threadIndex,
                                                       const uint32_t streamId,
                                                       const uint64_t taskId) const
    {
        aicpusd_info("custom kfc task, streamId[%u], taskId[%lu].", streamId, taskId);
        std::shared_ptr<aicpu::ProfMessage> profMsg = nullptr;
        const bool profFlag = aicpu::IsProfOpen();
        uint64_t tickBeforeRun = 0LLU;
        (void)aicpu::SetTaskAndStreamId(taskId, streamId);
        if (profFlag) {
            aicpusd_info("Profiling is open, start malloc.");
            try {
                profMsg = std::make_shared<aicpu::ProfMessage>("AICPU");
            } catch (std::exception &threadException) {
                aicpusd_err("make shared for ProfMessage failed. Exception[%s]", threadException.what());
                return TASK_FAIL;
            }
            (void)aicpu::SetProfHandle(profMsg);
            tickBeforeRun = aicpu::GetSystemTick();
        }
        const int32_t ret = aeCallInterface(&aicpufwKernelInfo);
        if (profFlag) {
            aicpu::aicpuProfContext_t aicpuProfCtx = {
                .tickBeforeRun = tickBeforeRun,
                .drvSubmitTick = static_cast<uint64_t>(drvEventInfo.comm.submit_timestamp),
                .drvSchedTick = static_cast<uint64_t>(drvEventInfo.comm.sched_timestamp),
                .kernelType = aicpu::KERNEL_TYPE_AICPU_CUSTOM_KFC
            };
            AicpuUtil::SetProfData(profMsg, aicpuProfCtx, threadIndex, streamId, taskId);
        }
        return ret;
    }
    /**
     * @ingroup AicpuEventManager
     * @brief it is used to parse the struct and get some parameter.
     * @param [in] eventInfo : the event information from mailbox.
     * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    int32_t AicpuEventManager::ProcessHWTSKernelEvent(const event_info &eventInfo, const uint32_t threadIndex) const
    {
        aicpu::HwtsTsKernel aicpufwKernelInfo = { };
        uint32_t mailboxId = 0U;
        uint32_t streamId = 0U;
        uint64_t taskId = 0U;
        uint64_t serialNo = 0U;
        uint16_t dataDumpEnableMode = 0U;
        int32_t ret = HWTSKernelEventMessageParse(eventInfo, mailboxId, aicpufwKernelInfo,
                                                  serialNo, streamId, taskId, dataDumpEnableMode);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        hwts_response_t hwtsResponse;
        hwtsResponse.mailbox_id = mailboxId;
        hwtsResponse.serial_no = serialNo;
        const auto kernelType = aicpufwKernelInfo.kernelType;
        if (kernelType == aicpu::KERNEL_TYPE_AICPU_CUSTOM_KFC) {
            ret = ExecuteHWTSKFCEventTask(eventInfo, aicpufwKernelInfo, threadIndex, streamId, taskId);
            hwtsResponse.status = (ret == AICPU_SCHEDULE_OK) ? static_cast<uint32_t>(TASK_SUCC) :
                static_cast<uint32_t>(TASK_FAIL);
        } else {
            const TaskInfoForMonitor taskInfoForMonitor = {
                .serialNo = serialNo,
                .taskId = taskId,
                .streamId = streamId,
                .isHwts = true
            };
            // GetInstance is not null, checked in InitAICPUScheduler
            AicpuMonitor::GetInstance().SetTaskInfo(static_cast<uint64_t>(threadIndex), taskInfoForMonitor);

            const EventInfoForExecute eventInfoForExecute = {
                .threadIndex = threadIndex,
                .streamId = streamId,
                .taskId = taskId,
                .dataDumpEnableMode = dataDumpEnableMode,
                .serialNo = serialNo,
                .mailboxId = mailboxId
            };
            ret = ExecuteHWTSEventTask(eventInfoForExecute, aicpufwKernelInfo, eventInfo, hwtsResponse);
        }
        hwtsResponse.result = static_cast<uint32_t>(AicpuSchedule::AicpuUtil::TransformInnerErrCode(ret));
        const uint32_t subeventId = eventInfo.comm.subevent_id;
        aicpusd_info("Begin send ack to ts, subevent_id[%u], mailboxId[%u], serialNo[%lu], " \
                     "streamId[%u], taskId[%lu], result[%d], originResult[%d], status[%d].",
                     subeventId, mailboxId, serialNo, streamId, taskId, hwtsResponse.result,
                     ret, hwtsResponse.status);
        const auto drvRet = halEschedAckEvent(AicpuDrvManager::GetInstance().GetDeviceId(), EVENT_TS_HWTS_KERNEL,
            subeventId, PtrToPtr<hwts_response_t, char_t>(&hwtsResponse),
            static_cast<uint32_t>(sizeof(hwts_response_t)));
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Failed to send ack to Ts,"
                        "subevent_id[%u], mailboxId[%u], serialNo[%lu], result[%d], originResult[%d], " \
                        "status[%d], error[%d].", subeventId, mailboxId, serialNo, hwtsResponse.result,
                        ret, hwtsResponse.status, drvRet);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        if (hwtsResponse.result != 0) {
            aicpusd_err("Failed to execute the task, subevent id[%u], mailbox id[%u], serial number[%lu], " \
                "stream id[%u], task id[%lu], result[%d], originResult[%d], status[%d], error[%d].",
                subeventId, mailboxId, serialNo, streamId, taskId, hwtsResponse.result,
                ret, hwtsResponse.status, drvRet);
            AicpuMonitor::GetInstance().SendAbnormalMsgToMain();
        }
        aicpusd_info("End send ack to Ts, subevent_id[%u], mailboxId[%u], serialNo[%lu], result[%d], " \
                     "originResult[%d], status[%d].",
                     subeventId, mailboxId, serialNo, hwtsResponse.result, ret, hwtsResponse.status);

        return AICPU_SCHEDULE_OK;
    }
    int32_t AicpuEventManager::ExecuteHWTSEventTask(const EventInfoForExecute &executeEventInfo,
                                                    aicpu::HwtsTsKernel &aicpufwKernelInfo,
                                                    const event_info &drvEventInfo,
                                                    hwts_response_t &hwtsResponse) const
    {
        (void)aicpu::SetThreadLocalCtx(CONTEXT_KEY_STREAM_ID, std::to_string(executeEventInfo.streamId));
        const hwts_ts_kernel tsKernel = (PtrToPtr<const char_t, const hwts_ts_task>(drvEventInfo.priv.msg))->kernel_info;
        const uint32_t debugDumpEnableMode =
            static_cast<uint32_t>((tsKernel.l2Ctrl >> DEBUGDUMP_ENABLE_MODE_OFFSET) & 1U);
        aicpusd_info("Begin to ExecuteTsKernelTask, mailboxId[%u], serialNo[%lu], streamId[%u], taskId[%lu], " \
                     "dataDumpEnableMode[%u], debugDumpEnableMode[%u].",
                     executeEventInfo.mailboxId, executeEventInfo.serialNo, executeEventInfo.streamId,
                     executeEventInfo.taskId, static_cast<uint32_t>(executeEventInfo.dataDumpEnableMode),
                     debugDumpEnableMode);
        int32_t ret = AicpuEventProcess::GetInstance().ExecuteTsKernelTask(aicpufwKernelInfo,
                                                                           executeEventInfo.threadIndex,
                                                                           drvEventInfo.comm.submit_timestamp,
                                                                           drvEventInfo.comm.sched_timestamp,
                                                                           executeEventInfo.streamId,
                                                                           executeEventInfo.taskId);
        hwtsResponse.status = (ret == AICPU_SCHEDULE_OK) ? static_cast<uint32_t>(TASK_SUCC) :
                                                           static_cast<uint32_t>(TASK_FAIL);
        uint32_t dataDumpEnableMode = static_cast<uint32_t>(executeEventInfo.dataDumpEnableMode);

        if ((ret == AICPU_SCHEDULE_OK) && (dataDumpEnableMode == 1U)) {
            aicpusd_info("Datadump. Begin Dump Self.");
            const int32_t dumpRet = AicpuSchedule::AicpuCustDumpProcess::GetInstance().
                BeginDatadumpTask(aicpu::GetAicpuThreadIndex(), executeEventInfo.streamId,
                                  static_cast<uint32_t>(executeEventInfo.taskId));
            ret = (dumpRet != AICPU_SCHEDULE_OK) ? dumpRet : ret;
        }
        return ret;
    }

    int32_t AicpuEventManager::ProcSplitKernelEvent(const event_info &drvEventInfo, const uint32_t threadIndex) const
    {
        (void)threadIndex;
        const AICPUSubEventInfo * const eventInfo = PtrToPtr<const char_t, const AICPUSubEventInfo>(drvEventInfo.priv.msg);
        aicpusd_info("Begin to process split kernel event. parallelId=%u, type=wait",
                     eventInfo->para.sharderTaskInfo.parallelId);

        const bool ret = ComputeProcess::GetInstance().DoSplitKernelTask(eventInfo->para.sharderTaskInfo);
        if (!ret) {
            aicpusd_err("Process split kernel event failed. parallelId=%u, type=wait",
                        eventInfo->para.sharderTaskInfo.parallelId);
            return static_cast<int32_t>(AICPU_SCHEDULE_FAIL);
        }

        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuEventManager::ProcRandomKernelEvent(const event_info &drvEventInfo, const uint32_t threadIndex) const
    {
        (void)drvEventInfo;
        (void)threadIndex;
        aicpusd_info("Begin to process random kernel event. threadIndex=%u", threadIndex);
        const bool ret = ComputeProcess::GetInstance().DoRandomKernelTask();
        if (!ret) {
            aicpusd_err("Process random kernel event failed. threadIndex=%u", threadIndex);
            return static_cast<int32_t>(AICPU_SCHEDULE_FAIL);
        }

        return AICPU_SCHEDULE_OK;
    }

    /**
     * @ingroup AicpuEventManager
     * @brief it use to process all event.
     * @param [in] eventInfo : the event information from ts.
     * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    int32_t AicpuEventManager::ProcessEvent(const event_info &eventInfo, const uint32_t threadIndex)
    {
        int32_t ret = AICPU_SCHEDULE_OK;
        switch (eventInfo.comm.event_id) {
            case EVENT_TS_HWTS_KERNEL: {
                aicpusd_info("Begin to process HWTS event.");
                ret = ProcessHWTSKernelEvent(eventInfo, threadIndex);
                aicpusd_info("Finish to process HWTS event, ret[%d].", ret);
                break;
            }
            case EVENT_AICPU_MSG: {
                aicpusd_info("Begin to process AICPU event.");
                ret = AicpuEventProcess::GetInstance().ProcessAICPUEvent(eventInfo);
                aicpusd_info("Finish to process AICPU event, ret[%d].", ret);
                break;
            }
            case EVENT_SPLIT_KERNEL:
                ret = ProcSplitKernelEvent(eventInfo, threadIndex);
                break;
            case EVENT_RANDOM_KERNEL: {
                ret = ProcRandomKernelEvent(eventInfo, threadIndex);
                break;
            }
            case EVENT_TS_CTRL_MSG: {
                aicpusd_info("Begin to process ProcTsCtrlEvent event.");
                ret = ProcTsCtrlEvent(eventInfo, threadIndex);
                aicpusd_info("Finish to process ProcTsCtrlEvent event.");
                break;
            }
            default: {
                aicpusd_err("Unknown event type, event_id[%d].", eventInfo.comm.event_id);
                ret = AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
                break;
            }
        }

        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Process event failed. eventId=%d, threadIdx=%u, ret=%d",
                        static_cast<int32_t>(eventInfo.comm.event_id), threadIndex, ret);
            AicpuMonitor::GetInstance().SendAbnormalMsgToMain();
        }

        return ret;
    }

    /**
     * @ingroup AicpuEventManager
     * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
     * @brief it is used to wait event for once.
     */
    void AicpuEventManager::DoOnce(const uint32_t threadIndex)
    {
        const uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
        const uint32_t groupId = AicpuDrvManager::GetInstance().GetGroupId();
        event_info eventInfo;
        const auto retVal = halEschedWaitEvent(deviceId, groupId, threadIndex,
                                               static_cast<int32_t>(TIMEOUT_INTERVAL), &eventInfo);
        if (retVal == DRV_ERROR_NONE) {
            (void) ProcessEvent(eventInfo, threadIndex);
        } else if (retVal == DRV_ERROR_SCHED_WAIT_TIMEOUT) { // if timeout, will continue wait event.
        } else if ((retVal == DRV_ERROR_SCHED_PROCESS_EXIT) || (retVal == DRV_ERROR_SCHED_PARA_ERR)) {
            if (runningFlag_) {
                runningFlag_ = false;
                aicpusd_warn("Failed to get event, error code=%d, deviceId[%u], groupId[%u], threadIndex[%u]",
                             retVal, deviceId, groupId, threadIndex);
            }
        } else {
            // record a error code
            aicpusd_err("Failed to get event, error code[%d], deviceId[%u], groupId[%u], threadIndex[%u]",
                        retVal, deviceId, groupId, threadIndex);
            AicpuMonitor::GetInstance().SendAbnormalMsgToMain();
        }
    }

    /**
     * @ingroup AicpuEventManager
     * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
     * @brief it is used in multi-thread.
     */
    void AicpuEventManager::LoopProcess(const uint32_t threadIndex)
    {
        while (runningFlag_) {
            DoOnce(threadIndex);
        }
        aicpusd_info("The loop of getting event is exit in thread[%u].", threadIndex);
    }

    void AicpuEventManager::SetRunningFlag(const bool runningFlag)
    {
        runningFlag_ = runningFlag;
    }

    int32_t AicpuEventManager::SendCtrlCpuMsg(int32_t aicpuPid, const uint32_t eventType, char_t *msg,
                                              const uint32_t msgLen) const
    {
        (void)eventType;
        (void)msg;
        (void)msgLen;
        return AicpuEventProcess::GetInstance().SendCtrlCpuMsg(
            aicpuPid, static_cast<uint32_t>(TsdSubEventType::TSD_EVENT_STOP_AICPU_PROCESS_WAIT), nullptr, 0U);
    }
}