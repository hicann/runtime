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
#include <algorithm>
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
#include "aicpusd_message_queue.h"

namespace AicpuSchedule {
    namespace {
        // dvpp kernels so
        const char_t * const DVPP_KERNELS_SO_NAME = "libdvpp_kernels.so";
        // dvpp event handle kernel name
        const char_t * const DVPP_EVENT_HANDLE_KERNEL_NAME = "DvppHandleEvent";
        // dvpp mpi kernels so
        const char_t * const DVPP_MPI_KERNELS_SO_NAME = "libmpi_dvpp_kernels.so";
        // dvpp mpi handle kernel name
        const char_t * const DVPP_MPI_EVENT_HANDLE_KERNEL_NAME = "ProcessDvppMpiEvent";
        // retr kernels so
        const char_t * const RETR_KERNELS_SO_NAME = "libretr_kernels.so";
        // retr event handle kernel name
        const char_t * const RETR_EVENT_KERNEL_NAME = "RetrEventKernel";
        // context key: streamId
        const std::string CONTEXT_KEY_STREAM_ID = "streamId";
        // task flag: convert driver task
        constexpr uint64_t CONVER_DRIVER_2_AICPU = 0x0000FFFFFFFFFFFFU;
        // running thread flag
        thread_local bool g_runningThreadFlag(true);
        // first array index
        constexpr size_t FIRST_INDEX = 0LU;
        // litehisi wait event timeout 120s
        constexpr uint32_t BIT_8 = 8;
        constexpr uint32_t TIMEOUT_LOOP_MAX_INTERVAL = 40U;
        constexpr uint32_t EVENT_PROXY_MSG = static_cast<uint32_t>(EVENT_ID::EVENT_USR_START) + 8U;
        constexpr uint8_t VERSION_0 = 0;
        constexpr uint8_t VERSION_1 = 1;

        constexpr uint32_t AICPU_TOPIC_USER_DATA_PAYLOAD_LEN = 40U;
        constexpr uint32_t AICPU_TOPIC_DEFAULT_KERNEL_TYPE = 127U;
        struct AicpuHwtsTaskInfo {
            uint64_t taskSoNamePtr; /* kernelSo */
            uint64_t paraPtr;       /* paramBase */
            uint64_t taskNamePtr;   /* kernelName */
            uint64_t l2StructPtr;   /* l2Ctrl */
            uint64_t extraFieldPtr;
        };
    }
    /**
     * @ingroup AicpuEventManager
     * @brief it is used to construct a object of AicpuEventManager.
     */
    AicpuEventManager::AicpuEventManager()
        : noThreadFlag_(true),
          runningFlag_(true),
          groupId_(0U),
          eventGetFunc_(nullptr),
          eventRspFunc_(nullptr)
    {
        /* init all event to make all event handle is not null */
        for (uint32_t i = 0U; i < EVENT_MAX_NUM; ++i) {
            aicpuEventProcFunc_[i] = &AicpuEventManager::ProcDefaultEvent;
        }

        aicpuEventProcFunc_[EVENT_TS_HWTS_KERNEL] = &AicpuEventManager::ProcTsHWTSEvent;
        aicpuEventProcFunc_[EVENT_DVPP_MSG] = &AicpuEventManager::ProcDvppMsgEvent;
        aicpuEventProcFunc_[EVENT_DVPP_MPI_MSG] = &AicpuEventManager::ProcDvppMpiMsgEvent;
        aicpuEventProcFunc_[EVENT_FR_MSG] = &AicpuEventManager::ProcFrMsgEvent;
        aicpuEventProcFunc_[EVENT_SPLIT_KERNEL] = &AicpuEventManager::ProcSplitKernelEvent;
        aicpuEventProcFunc_[EVENT_RANDOM_KERNEL] = &AicpuEventManager::ProcRandomKernelEvent;
        aicpuEventProcFunc_[EVENT_TS_CTRL_MSG] = &AicpuEventManager::ProcTsCtrlEvent;
        aicpuEventProcFunc_[EVENT_QUEUE_EMPTY_TO_NOT_EMPTY] = &AicpuEventManager::ProcQueueEmptyToNotEmptyEvent;
        aicpuEventProcFunc_[EVENT_QUEUE_FULL_TO_NOT_FULL] = &AicpuEventManager::ProcQueueFullToNotFullEvent;
        aicpuEventProcFunc_[EVENT_AICPU_MSG] = &AicpuEventManager::ProcAicpuMsgEvent;
        aicpuEventProcFunc_[EVENT_QUEUE_ENQUEUE] = &AicpuEventManager::ProcQueueEvent;
        aicpuEventProcFunc_[EVENT_TDT_ENQUEUE] = &AicpuEventManager::ProcOnPreprocessEvent;
        aicpuEventProcFunc_[EVENT_ACPU_MSG_TYPE1] = &AicpuEventManager::ProcOnPreprocessEvent;
        aicpuEventProcFunc_[EVENT_CDQ_MSG] = &AicpuEventManager::ProcCDQEvent;
        aicpuEventProcFunc_[EVENT_QS_MSG] = &AicpuEventManager::ProcQsEvent;
        aicpuEventProcFunc_[EVENT_DRV_MSG] = &AicpuEventManager::ProcDrvEvent;
        aicpuEventProcFunc_[EVENT_PROXY_MSG] = &AicpuEventManager::ProcProxyEvent;
    }

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
     * @param [in] grpId : group id.
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    void AicpuEventManager::InitEventMgr(const bool noThreadFlag,
                                         const bool runningFlag,
                                         const uint32_t grpId,
                                         const AicpuSchedMode aicpuSchedMode)
    {
        noThreadFlag_ = noThreadFlag;
        runningFlag_ = runningFlag;
        groupId_ = grpId;

        for (uint32_t i = 0; i < MAX_AICPU_THREAD_NUM; i++) {
            for (int j = 0; j < EVENT_MAX_NUM; j++) {
                recvEventStat_[i][j] = 0;
                procEventStat_[i][j] = 0;
            }
        }
        InitLastwordCallback();

        eventGetFunc_ = (aicpuSchedMode == AicpuSchedMode::SCHED_MODE_MSGQ) ?
                        &AicpuEventManager::DoOnceMsq :
                        &AicpuEventManager::DoOnceEsched;
        eventRspFunc_ = (aicpuSchedMode == AicpuSchedMode::SCHED_MODE_MSGQ) ?
                        &AicpuEventManager::ResponseMsq :
                        &AicpuEventManager::ResponseEsched;
        eventGetFunc_ = &AicpuEventManager::DoOnceEsched;
        eventRspFunc_ = &AicpuEventManager::ResponseEsched;
    }

    void AicpuEventManager::InitLastwordCallback()
    {
        auto lastwordCallback = [this]() {
            aicpusd_run_info("Event sd stat:");
            auto accumulate = [](const uint64_t stat[MAX_AICPU_THREAD_NUM][EVENT_MAX_NUM], int eventId) {
                uint64_t sum = 0;
                for (uint32_t i = 0; i < MAX_AICPU_THREAD_NUM; i++) {
                    sum += stat[i][eventId];
                }
                return sum;
            };

            uint64_t eventTotal;
            for (uint32_t i = 0; i < EVENT_MAX_NUM; i++) {
                eventTotal = accumulate(this->recvEventStat_, i);
                aicpusd_run_info("---Recv event id[%d]: %llu", i, eventTotal);
            }

            for (uint32_t i = 0; i < EVENT_MAX_NUM; i++) {
                eventTotal = accumulate(this->procEventStat_, i);
                aicpusd_run_info("---Proc event id[%d]: %llu", i, eventTotal);
            }
        };
        AicpusdLastword::GetInstance().RegLastwordCallback("aicpu sd event mng", lastwordCallback, cancelLastword_);
    }

    int32_t AicpuEventManager::DoOnce(const uint32_t threadIndex, const uint32_t deviceId, const int32_t timeout)
    {
        return (this->*eventGetFunc_)(threadIndex, deviceId, timeout);
    }

    int32_t AicpuEventManager::SendResponse(const uint32_t deviceId, const uint32_t subEventId, hwts_response_t &resp) const
    {
        return (this->*eventRspFunc_)(deviceId, subEventId, resp);
    }

    /**
     * @ingroup AicpuEventManager
     * @brief it use to process for call interface.
     * @param [in] modelId : the model id.
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    int32_t AicpuEventManager::ExecuteProcess(const uint32_t modelId)
    {
        const auto model = AicpuModelManager::GetInstance().GetModel(modelId);
        if (model == nullptr) {
            aicpusd_err("Model[%u] not found.", modelId);
            return AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND;
        }

        const int32_t ret = model->ModelExecute();
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Failed to execute model[%u], ret[%d].", modelId, ret);
            return ret;
        }

        aicpusd_info("Finished to execute the head stream, modelId[%u], ret[%d].", modelId, ret);
        AicpuMsgSend::SendEvent();
        CallModeLoopProcess();

        return AICPU_SCHEDULE_OK;
    }

    /**
     * @ingroup AicpuEventManager
     * @brief it use to execute the model from call interface.
     * @param [in] drvEventInfo : event info.
     * @param [out] drvEventAck : event ack.
     * @return 0: success, other: error code
     */
    int32_t AicpuEventManager::ExecuteProcessSyc(const event_info * const drvEventInfo,
                                                 event_ack * const drvEventAck)
    {
        int32_t ret = AICPU_SCHEDULE_OK;
        switch (drvEventInfo->comm.event_id) {
            case EVENT_TS_HWTS_KERNEL:
                ret = ProcessHWTSKernelEvent(*drvEventInfo, 0U);
                aicpusd_info("Finish to process HWTS event, ret[%d].", ret);
                break;
            case EVENT_TS_CTRL_MSG:
                ret = ProcessHWTSControlEvent(*drvEventInfo);
                aicpusd_info("Finish to process TS CTRL event, ret[%d].", ret);
                break;
            default:
                aicpusd_warn("Don't support this event, event_id[%u]", drvEventInfo->comm.event_id);
                break;
        }
        drvEventAck->event_id = drvEventInfo->comm.event_id;
        return ret;
    }

    /**
    * @ingroup AicpuEventManager
    * @brief it use to execute the model from ts.
    * @param [in] modelId : the id of model.
    * @return AICPU_SCHEDULE_OK: success, other: error code
    */
    int32_t AicpuEventManager::TsControlExecuteProcess(const uint32_t modelId) const
    {
        const auto model = AicpuModelManager::GetInstance().GetModel(modelId);
        if (model == nullptr) {
            aicpusd_err("Model[%u] not found.", modelId);
            return AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND;
        }

        const int32_t ret = model->ModelExecute();
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Failed to execute model[%u], ret[%d].", modelId, ret);
            return ret;
        }
        return AICPU_SCHEDULE_OK;
    }

    /**
     * @ingroup AicpuEventManager
     * @brief it use to set the exit flag of loop which wait event.
     */
    void AicpuEventManager::CheckAndSetExitFlag() const
    {
        if (noThreadFlag_) {
            aicpusd_info("Set the exit flag.");
            g_runningThreadFlag = false;
        }
    }

    int32_t AicpuEventManager::ProcessTsAicpuModelDestroy(const AicpuSqeAdapter::AicpuModelOperateInfo &info) const
    {
        const uint32_t modelId = static_cast<uint32_t>(info.model_id);
        const AicpuModelStatus modelStatus = AicpuModelManager::GetInstance().GetModelStatus(modelId);
        if (modelStatus == AicpuModelStatus::MODEL_STATUS_RUNNING) {
            const auto ret = TsControlTaskAbort(info);
            if (ret != AICPU_SCHEDULE_OK) {
                aicpusd_err("Failed to abort modelId[%u] ret[%d]", modelId, ret);
                return ret;
            }
        }
        const auto ret = AicpuScheduleInterface::GetInstance().Destroy(modelId);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Failed to destroy modelId[%u].", modelId);
            return ret;
        }
        CheckAndSetExitFlag();
        aicpusd_info("The destroy task is complete, ret[%d]", ret);
        return ret;
    }

    /**
     * @ingroup AicpuEventManager
     * @brief it use to process distributing event.
     * @param [in] info : the information of task.
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    int32_t AicpuEventManager::EventDistribution(const AicpuSqeAdapter::AicpuModelOperateInfo &info) const
    {
        int32_t ret = AICPU_SCHEDULE_OK;
        const uint32_t cmdType = static_cast<uint32_t>(info.cmd_type);
        switch (cmdType) {
            case TS_AICPU_MODEL_LOAD: {
                aicpusd_info("Begin to load task.");
                const void * const argPtr = ValueToPtr(info.arg_ptr);
                ret = AicpuScheduleInterface::GetInstance().LoadProcess(const_cast<const void *>(argPtr));
                aicpusd_info("The load task is complete, ret[%d].", ret);
                break;
            }
            case TS_AICPU_MODEL_EXECUTE: {
                const uint32_t modelId = static_cast<uint32_t>(info.model_id);
                ret = TsControlExecuteProcess(modelId);
                aicpusd_info("The execute task is complete, modelId[%u], ret[%d].", modelId, ret);
                break;
            }
            case TS_AICPU_MODEL_ABORT: {
                const uint32_t modelId = static_cast<uint32_t>(info.model_id);
                ret = TsControlTaskAbort(info);
                if (ret != AICPU_SCHEDULE_OK) {
                    aicpusd_err("Failed to abort modelId[%u] ret[%d]", modelId, ret);
                    return ret;
                }
                CheckAndSetExitFlag();
                aicpusd_info("The abort task is complete, ret[%d]", ret);
                break;
            }
            case TS_AICPU_MODEL_DESTROY: {
                ret = ProcessTsAicpuModelDestroy(info);
                if (ret != AICPU_SCHEDULE_OK) {
                    return ret;
                }
                break;
            }
            default: {
                aicpusd_err("The type is not found, type[%u]", cmdType);
                CheckAndSetExitFlag();
                ret = AICPU_SCHEDULE_ERROR_NOT_FOUND_CMD_TYPE;
                break;
            }
        }
        return ret;
    }

    /**
     * @ingroup AicpuEventManager
     * @brief it use to abort task.
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    int32_t AicpuEventManager::TsControlTaskAbort(const AicpuSqeAdapter::AicpuModelOperateInfo &info) const
    {
        const uint32_t modelId = static_cast<uint32_t>(info.model_id);
        AicpuModel * const model = AicpuModelManager::GetInstance().GetModel(modelId);
        if (model == nullptr) {
            aicpusd_err("Model[%u] abort failed, no model found.", modelId);
            return AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND;
        }
        const auto ret = model->ModelAbort();
        aicpusd_info("End to process abort task for modelId[%u] from ts, ret[%d].", modelId, ret);
        return ret;
    }

    /**
     * @ingroup AicpuEventManager
     * @brief it use to process control task from ts
     * @param [in] ctrlMsg : the struct of control task.
     * @param [in] subEvent : it is used to store subeventid which is in receive struct.
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    int32_t AicpuEventManager::ProcessModelEvent(AicpuSqeAdapter &aicpuSqeAdapter, const uint32_t subEvent)
    {
        AicpuSqeAdapter::AicpuModelOperateInfo info{};
        aicpuSqeAdapter.GetAicpuModelOperateInfo(info);
        int32_t ret = EventDistribution(info);

        ret = AicpuEventProcess::GetInstance().ProcessResponseInfo(aicpuSqeAdapter, static_cast<uint16_t>(ret),
                                                                   subEvent, noThreadFlag_);
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
                case AICPU_MODEL_OPERATE: {
                    ret = ProcessModelEvent(aicpuSqeAdapter, drvEventInfo.comm.subevent_id);
                    if (ret != AICPU_SCHEDULE_OK) {
                        return ret;
                    }
                    break;
                }
                case AIC_TASK_REPORT: {
                    ret = AicpuEventProcess::GetInstance().ProcessTaskReportEvent(aicpuSqeAdapter);
                    if (ret != AICPU_SCHEDULE_OK) {
                        aicpusd_err("Failed to execute task report from ts.");
                        return ret;
                    }
                    aicpusd_info("Finish to execute the task report from ts.");
                    CheckAndSetExitFlag();
                    break;
                }
                case AICPU_NOTIFY_RECORD:
                    break;
                case AICPU_DATADUMP_REPORT: // dump data
                    ret = AicpuEventProcess::GetInstance().ProcessDumpDataEvent(aicpuSqeAdapter);
                    break;
                case AICPU_DATADUMP_LOADINFO: // load op mapping info for dump
                    ret = AicpuEventProcess::GetInstance().ProcessLoadOpMappingEvent(aicpuSqeAdapter);
                    break;
                case AICPU_TIMEOUT_CONFIG: // set op execute timeout config send by ts: include execute and wait timeout
                    ret = AicpuEventProcess::GetInstance().ProcessSetTimeoutEvent(aicpuSqeAdapter);
                    break;
                case AICPU_FFTS_PLUS_DATADUMP_REPORT: // dump FFTSPlus data
                    ret = AicpuEventProcess::GetInstance().ProcessDumpFFTSPlusDataEvent(aicpuSqeAdapter);
                    break;
                case AICPU_INFO_LOAD: // load platform info from buf
                    ret = AicpuEventProcess::GetInstance().ProcessLoadPlatformFromBuf(aicpuSqeAdapter);
                    break;
                case AIC_ERROR_REPORT: {
                    AicpuSqeAdapter::AicErrReportInfo reportInfo;
                    aicpuSqeAdapter.GetAicErrReportInfo(reportInfo);
                    aicpu::OpEventParam param = {};
                    param.resultCode = static_cast<uint32_t>(reportInfo.u.aicError.result_code);
                    param.aivErrorBitMap = reportInfo.u.aicError.aiv_err_bitmap;
                    param.aicErrorBitMap = reportInfo.u.aicError.aic_err_bitmap;
                    aicpu::AsyncEventManager::GetInstance().ProcessOpEvent(
                        drvEventInfo.comm.event_id, cmdType, &param);
                    break;
                }
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
            case TS_AICPU_MSG_VERSION: {
                ret = AicpuEventProcess::GetInstance().ProcessMsgVersionEvent(aicpuSqeAdapter);
                break;
            }
            case TS_AICPU_MODEL_OPERATE: {
                ret = ProcessModelEvent(aicpuSqeAdapter, drvEventInfo.comm.subevent_id);
                break;
            }
            case TS_AICPU_TASK_REPORT: {
                ret = AicpuEventProcess::GetInstance().ProcessTaskReportEvent(aicpuSqeAdapter);
                if (ret != AICPU_SCHEDULE_OK) {
                    aicpusd_err("Failed to execute task report from ts.");
                    return ret;
                }
                aicpusd_info("Finish to execute the task report from ts.");
                CheckAndSetExitFlag();
                break;
            }
            case TS_AICPU_NORMAL_DATADUMP_REPORT:
            case TS_AICPU_DEBUG_DATADUMP_REPORT: {
                ret = AicpuEventProcess::GetInstance().ProcessDumpDataEvent(aicpuSqeAdapter);
                break;
            }
            case TS_AICPU_DATADUMP_INFO_LOAD: {
                ret = AicpuEventProcess::GetInstance().ProcessLoadOpMappingEvent(aicpuSqeAdapter);
                break;
            }
            case TS_AICPU_TIMEOUT_CONFIG: {
                ret = AicpuEventProcess::GetInstance().ProcessSetTimeoutEvent(aicpuSqeAdapter);
                break;
            }
            case TS_AICPU_INFO_LOAD: {
                ret = AicpuEventProcess::GetInstance().ProcessLoadPlatformFromBuf(aicpuSqeAdapter);
                break;
            }
            case TS_AIC_ERROR_REPORT: {
                AicpuSqeAdapter::AicErrReportInfo reportInfo;
                aicpuSqeAdapter.GetAicErrReportInfo(reportInfo);
                aicpu::OpEventParam param = {};
                PrintAicErrReportInfo(reportInfo);
                break;
            }
            default:
                aicpusd_err("The event is not found, cmd type[%u]", cmdType);
                return AICPU_SCHEDULE_ERROR_NOT_FOUND_EVENT;
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
     * @brief print aic error report info
     * @param [in] reportInfo : info from aicpu sd adapter.
     */
    void  AicpuEventManager::PrintAicErrReportInfo(const AicpuSqeAdapter::AicErrReportInfo &reportInfo)
    {
        TsToAicpuAicErrMsgReport aicErrMsg = reportInfo.u.aicErrorMsg;
        uint16_t aicBitmapNum = aicErrMsg.aic_bitmap_num;
        uint16_t aivBitmapNum = aicErrMsg.aic_bitmap_num;
        std::ostringstream oss;
        for (size_t i = 0; i < aicBitmapNum; i++) {
            oss << "aicmap" << "[" << i << "] : " << std::bitset<BIT_8>(aicErrMsg.bitmap[i]).to_string() << ",";
        }
        for (size_t i = aicBitmapNum; i < (aicBitmapNum + aivBitmapNum); i++) {
            oss << "aivmap" << "[" << i << "] : " << std::bitset<BIT_8>(aicErrMsg.bitmap[i]).to_string() << ",";
        }
        aicpusd_info("Bit map is : %s", oss.str().c_str());
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
    * @brief it use to init control event version function map
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
    * @brief it is used to parse the struct and get some parameter.
    * @param [in] drvEventInfo : the event information from mailbox.
    * @param [in] mailboxId : mailbox id
    * @param [in] info : the info is used to execute task.
    * @param [in] serialNo : the serial no. in mailbox, which is need to use in response package.
    * @param [out] streamId : streamId is used to cache task, version 1 stream id is invalid
    * @return AICPU_SCHEDULE_OK: success, other: error code
    */
    int32_t AicpuEventManager::HWTSKernelEventMessageParse(const event_info &drvEventInfo,
                                                           uint32_t &mailboxId,
                                                           aicpu::HwtsTsKernel &info,
                                                           uint64_t &serialNo,
                                                           uint32_t &streamId,
                                                           uint64_t &taskId,
                                                           uint16_t &dataDumpEnableMode) const
    {
        // for the msg is address of array, it is not a nullptr.
        const hwts_ts_task * const eventMsg = PtrToPtr<const char_t, const hwts_ts_task>(drvEventInfo.priv.msg);
        mailboxId = eventMsg->mailbox_id;
        serialNo = static_cast<uint64_t>(eventMsg->serial_no);
        // for the msg is address of array, it is not a nullptr.
        const hwts_ts_kernel tsKernel = eventMsg->kernel_info;
        GetStreamIdAndTaskIdFromEvent(tsKernel, streamId, taskId, drvEventInfo.comm.subevent_id);
        const uint32_t kernelType = tsKernel.kernel_type;
        switch (kernelType) {
            case aicpu::KERNEL_TYPE_AICPU_KFC: {
                info.kernelType = kernelType;
                info.kernelBase.cceKernel.kernelName = static_cast<uint64_t>(tsKernel.kernelName & CONVER_DRIVER_2_AICPU);
                info.kernelBase.cceKernel.kernelSo = static_cast<uint64_t>(tsKernel.kernelSo & CONVER_DRIVER_2_AICPU);
                info.kernelBase.cceKernel.paramBase = static_cast<uint64_t>(tsKernel.paramBase & CONVER_DRIVER_2_AICPU);
                info.kernelBase.cceKernel.blockId = static_cast<uint32_t>(tsKernel.blockId);
                info.kernelBase.cceKernel.blockNum = static_cast<uint32_t>(tsKernel.blockNum);
                break;
            }
            case aicpu::KERNEL_TYPE_CCE:
            case aicpu::KERNEL_TYPE_AICPU:
            case aicpu::KERNEL_TYPE_AICPU_CUSTOM: {
                info.kernelType = kernelType;
                info.kernelBase.cceKernel.kernelName =
                    static_cast<uint64_t>(tsKernel.kernelName & CONVER_DRIVER_2_AICPU);
                info.kernelBase.cceKernel.kernelSo = static_cast<uint64_t>(tsKernel.kernelSo & CONVER_DRIVER_2_AICPU);
                info.kernelBase.cceKernel.paramBase =
                    static_cast<uint64_t>(tsKernel.paramBase & CONVER_DRIVER_2_AICPU);
                info.kernelBase.cceKernel.l2VaddrBase =
                    static_cast<uint64_t>(tsKernel.l2VaddrBase & CONVER_DRIVER_2_AICPU);
                info.kernelBase.cceKernel.blockId = static_cast<uint32_t>(tsKernel.blockId);
                info.kernelBase.cceKernel.blockNum = static_cast<uint32_t>(tsKernel.blockNum);
                info.kernelBase.cceKernel.l2Size = 0U;
                info.kernelBase.cceKernel.l2InMain = static_cast<uint32_t>(tsKernel.l2InMain);
                break;
            }
            case aicpu::KERNEL_TYPE_FWK: {
                info.kernelType = aicpu::KERNEL_TYPE_FWK;
                info.kernelBase.fwkKernel.size = 0U;
                info.kernelBase.fwkKernel.kernel = static_cast<uint64_t>(tsKernel.paramBase & CONVER_DRIVER_2_AICPU);
                break;
            }
            default: {
                aicpusd_err("Don't support kernel_type[%u].", kernelType);
                return AICPU_SCHEDULE_ERROR_DRV_ERR;
            }
        }

        dataDumpEnableMode = static_cast<uint16_t>((tsKernel.l2Ctrl >> DATADUMP_ENABLE_MODE_OFFSET) & 1U);
        aicpusd_info("Kernel type of current task is [%u], dataDumpEnableMode[%u].", kernelType, dataDumpEnableMode);
        return AICPU_SCHEDULE_OK;
    }
    int32_t AicpuEventManager::ExecuteHWTSKFCEventTask(const event_info &drvEventInfo,
                                                       const aicpu::HwtsTsKernel &aicpufwKernelInfo,
                                                       const uint32_t threadIndex,
                                                       const uint32_t streamId,
                                                       const uint64_t taskId) const
    {
        aicpusd_info("kfc task, streamId[%u], taskId[%lu].", streamId, taskId);
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
                .kernelType = aicpu::KERNEL_TYPE_AICPU_KFC
            };

            const ProfIdentity profIdentity = {
                .taskId = taskId,
                .streamId = streamId,
                .threadIndex = threadIndex,
                .deviceId = AicpuDrvManager::GetInstance().GetDeviceId()
            };
            (void)AicpuUtil::SetProfData(profMsg, aicpuProfCtx, profIdentity);
        }
        return ret;
    }
    /**
     * @ingroup AicpuEventManager
     * @brief it is used to parse the struct and get some parameter.
     * @param [in] drvEventInfo : the event information from mailbox.
     * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    int32_t AicpuEventManager::ProcessHWTSKernelEvent(const event_info &drvEventInfo,
                                                      const uint32_t threadIndex) const
    {
        aicpu::HwtsTsKernel aicpufwKernelInfo = {};
        uint32_t mailboxId = 0U;
        uint32_t streamId = 0U;
        uint64_t taskId = 0LU;
        uint64_t serialNo = 0LU;
        uint16_t dataDumpEnableMode = 0U;
        int32_t ret = HWTSKernelEventMessageParse(drvEventInfo, mailboxId, aicpufwKernelInfo,
                                                  serialNo, streamId, taskId, dataDumpEnableMode);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }
        hwts_response_t hwtsResp;
        hwtsResp.mailbox_id = mailboxId;
        hwtsResp.serial_no = serialNo;
        const auto kernelType = aicpufwKernelInfo.kernelType;
        if (kernelType == aicpu::KERNEL_TYPE_AICPU_KFC) {
            ret = ExecuteHWTSKFCEventTask(drvEventInfo, aicpufwKernelInfo, threadIndex, streamId, taskId);
            hwtsResp.status = (ret == AICPU_SCHEDULE_OK) ? static_cast<uint32_t>(TASK_SUCC) :
                static_cast<uint32_t>(TASK_FAIL);
        } else {
            const TaskInfoForMonitor monitorTaskInfo = {
                .serialNo = serialNo,
                .taskId = taskId,
                .streamId = streamId,
                .isHwts = true
            };
            AicpuMonitor::GetInstance().SetTaskInfo(threadIndex, monitorTaskInfo);
            ret = ExecuteHWTSEventTask(threadIndex, streamId, taskId,  serialNo, aicpufwKernelInfo,
                                       drvEventInfo, mailboxId, hwtsResp, dataDumpEnableMode);
        }
        hwtsResp.result = static_cast<uint32_t>(AicpuUtil::TransformInnerErrCode(ret));
        const auto kernelName = PtrToPtr<const void, const char_t>(ValueToPtr(
            aicpufwKernelInfo.kernelBase.cceKernel.kernelName));
        if ((noThreadFlag_) && (kernelName != nullptr) && (strcmp(kernelName, "endGraph") == 0)) {
            g_runningThreadFlag = false;
            return AICPU_SCHEDULE_OK;
        }
        const uint32_t drvSubeventId = drvEventInfo.comm.subevent_id;
        const uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
        const int32_t drvRet = SendResponse(deviceId, drvSubeventId, hwtsResp);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Failed to send ack to Ts, kernelType[%u] deviceId[%u], subevent_id[%u], mailboxId[%u], "
                "serialNo[%lu], streamId[%u], taskId[%lu], result[%d], originResult[%d], status[%d], error[%d].",
                kernelType, deviceId, drvSubeventId, mailboxId, serialNo, streamId, taskId,
                hwtsResp.result, ret, hwtsResp.status, drvRet);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        aicpusd_info("End send ack to Ts, kernelType[%u], deviceId[%u], subevent_id[%u], mailboxId[%u], "
            "serialNo[%lu], streamId[%u], taskId[%lu], result[%d], originResult[%d], status[%d].",
            kernelType, deviceId, drvSubeventId, mailboxId, serialNo, streamId, taskId, hwtsResp.result,
            ret, hwtsResp.status);
        return AICPU_SCHEDULE_OK;
    }
    int32_t AicpuEventManager::ExecuteHWTSEventTask(const uint32_t &threadIndex,
                                                    const uint32_t &streamId,
                                                    const uint64_t taskId,
                                                    const uint64_t &serialNo,
                                                    aicpu::HwtsTsKernel &aicpufwKernelInfo,
                                                    const event_info &drvEventInfo,
                                                    const uint32_t &mailboxId,
                                                    hwts_response_t &hwtsResp,
                                                    uint16_t &dataDumpEnableMode) const
    {
        (void)aicpu::SetThreadLocalCtx(CONTEXT_KEY_STREAM_ID, std::to_string(streamId));
        (void)aicpu::SetTaskAndStreamId(taskId, streamId);

        aicpusd_info("Begin to ExecuteTsKernelTask, mailboxId[%u], serialNo[%lu], streamId[%u], taskId[%lu], " \
                     "dataDumpEnableMode[%u], kernelType[%u], subeventId[%u].",
                     mailboxId, serialNo, streamId, taskId, dataDumpEnableMode,
                     aicpufwKernelInfo.kernelType, drvEventInfo.comm.subevent_id);
        int32_t ret = AicpuEventProcess::GetInstance().ExecuteTsKernelTask(aicpufwKernelInfo, threadIndex,
            static_cast<uint64_t>(drvEventInfo.comm.submit_timestamp),
            static_cast<uint64_t>(drvEventInfo.comm.sched_timestamp),
            static_cast<uint64_t>(streamId), taskId);
        hwtsResp.status = (ret == AICPU_SCHEDULE_OK) ? static_cast<uint32_t>(TASK_SUCC) :
                                                       static_cast<uint32_t>(TASK_FAIL);
        if ((dataDumpEnableMode == 1U) && (ret == AICPU_SCHEDULE_OK)) {
            aicpusd_info("Datadump. Begin Dump Self.");
            TaskInfoExt dumpTaskInfo(streamId, static_cast<uint32_t>(taskId));
            const DumpFileName fileName(streamId, static_cast<uint32_t>(taskId));
            const int32_t dumpRet = AicpuSchedule::OpDumpTaskManager::GetInstance().
                DumpOpInfo(dumpTaskInfo, fileName);
            ret = (dumpRet != AICPU_SCHEDULE_OK) ? dumpRet : ret;
        }
        return ret;
    }

    /**
     * @ingroup AicpuEventManager
     * @brief it is used to process dvpp event.
     * @param [in] drvEventInfo : the event information from mailbox.
     * @param [in] threadIndex : thread index assign by aicpu index, but when running time they are different.
     * @return AICPU_SCHEDULE_OK: success, other: error code
    */
    int32_t AicpuEventManager::ProcessDvppEvent(const event_info &drvEventInfo, const uint32_t threadIndex) const
    {
        // create parambase for aicpu task,
        const size_t argsSize = sizeof(aicpu::AicpuParamHead) + sizeof(uint64_t);
        char_t args[argsSize] = {};
        const auto paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(&args[FIRST_INDEX]);
        paramHead->length = argsSize;
        paramHead->ioAddrNum = 0U;  // no io addr
        uint64_t * const attr =
            PtrToPtr<char_t, uint64_t>(PtrAdd<char_t>(&args[0UL], argsSize, sizeof(aicpu::AicpuParamHead)));
        *attr = PtrToValue(PtrToPtr<const event_info, const void>(&drvEventInfo));

        // create dvpp event task
        aicpu::HwtsTsKernel dvppKernel = {};
        // KERNEL_TYPE_AICPU
        dvppKernel.kernelType = 2U;
        dvppKernel.kernelBase.cceKernel.kernelName = reinterpret_cast<uintptr_t>(DVPP_EVENT_HANDLE_KERNEL_NAME);
        dvppKernel.kernelBase.cceKernel.kernelSo = reinterpret_cast<uintptr_t>(DVPP_KERNELS_SO_NAME);
        dvppKernel.kernelBase.cceKernel.paramBase = reinterpret_cast<uintptr_t>(&args[0UL]);

        const auto taskRet = AicpuEventProcess::GetInstance().ExecuteTsKernelTask(dvppKernel, threadIndex,
            static_cast<uint64_t>(drvEventInfo.comm.submit_timestamp),
            static_cast<uint64_t>(drvEventInfo.comm.sched_timestamp));
        aicpusd_info("Find and execute dvpp task end, threadIndex[%u], taskRet[%d], argsSize[%zu].",
                     threadIndex, taskRet, argsSize);
        return taskRet;
    }

    int32_t AicpuEventManager::ProcessMpiDvppEvent(const event_info &drvEventInfo, const uint32_t threadIndex) const
    {
        // record Mpi Dvpp event
        mpi::MpiDvppStatisticManager::Instance().InitMpiDvpp();
        mpi::MpiDvppStatisticManager::Instance().Record();
        aicpu::HwtsTsKernel mpiKernel = {};
        // KERNEL_TYPE_AICPU
        mpiKernel.kernelType = 2U;
        mpiKernel.kernelBase.cceKernel.kernelName = reinterpret_cast<uintptr_t>(DVPP_MPI_EVENT_HANDLE_KERNEL_NAME);
        mpiKernel.kernelBase.cceKernel.kernelSo = reinterpret_cast<uintptr_t>(DVPP_MPI_KERNELS_SO_NAME);
        mpiKernel.kernelBase.cceKernel.paramBase = reinterpret_cast<uintptr_t>(&drvEventInfo);

        const auto taskRet = AicpuEventProcess::GetInstance().ExecuteTsKernelTask(mpiKernel, threadIndex,
            static_cast<uint64_t>(drvEventInfo.comm.submit_timestamp),
            static_cast<uint64_t>(drvEventInfo.comm.sched_timestamp));
        aicpusd_info("Find and execute mpi dvpp task end, threadIndex[%u], taskRet[%d].", threadIndex, taskRet);
        return taskRet;
    }

    int32_t AicpuEventManager::ProcessRetrEvent(const event_info &drvEventInfo, const uint32_t threadIndex) const
    {
        // create parambase for aicpu task,
        const size_t argsSize = sizeof(aicpu::AicpuParamHead) + sizeof(uint64_t);
        char_t args[argsSize] = {};
        const auto paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(&args[FIRST_INDEX]);
        paramHead->length = argsSize;
        paramHead->ioAddrNum = 0U;  // no io addr
        uint64_t * const attr =
            PtrToPtr<char_t, uint64_t>(PtrAdd<char_t>(&args[0UL], argsSize, sizeof(aicpu::AicpuParamHead)));
        *attr = PtrToValue(PtrToPtr<const event_info, const void>(&drvEventInfo));

        // create retr event task
        aicpu::HwtsTsKernel retrKernel = {};
        // KERNEL_TYPE_AICPU
        retrKernel.kernelType = 2U;
        retrKernel.kernelBase.cceKernel.kernelName = reinterpret_cast<uintptr_t>(RETR_EVENT_KERNEL_NAME);
        retrKernel.kernelBase.cceKernel.kernelSo = reinterpret_cast<uintptr_t>(RETR_KERNELS_SO_NAME);
        retrKernel.kernelBase.cceKernel.paramBase = reinterpret_cast<uintptr_t>(&args[0UL]);

        const auto taskRet = AicpuEventProcess::GetInstance().ExecuteTsKernelTask(retrKernel, threadIndex,
            static_cast<uint64_t>(drvEventInfo.comm.submit_timestamp),
            static_cast<uint64_t>(drvEventInfo.comm.sched_timestamp));
        aicpusd_info("Find and execute retr task end, threadIndex[%u], taskRet[%d], argsSize[%zu].",
                     threadIndex, taskRet, argsSize);
        return taskRet;
    }

    /**
     * @ingroup AicpuScheduleInterface
     * @brief it is used to process CDQ event.
     * @param [in] drvEventInfo : the event information from mailbox.
     * @return AICPU_SCHEDULE_OK: success, other: error code
    */
    int32_t AicpuEventManager::ProcessCdqEvent(const event_info &drvEventInfo) const
    {
        const uint32_t drvEventId = drvEventInfo.comm.event_id;
        const uint32_t drvSubeventId = drvEventInfo.comm.subevent_id;
        void * const param = PtrToPtr<event_info, void>(const_cast<event_info *>(&drvEventInfo));
        aicpu::AsyncEventManager::GetInstance().ProcessEvent(drvEventId, drvSubeventId, param);
        aicpusd_info("ProcessCdqEvent by eventId[%u] subeventId[%u] end", drvEventId, drvSubeventId);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuEventManager::ProcTsHWTSEvent(const event_info &drvEventInfo, const uint32_t threadIndex)
    {
        return ProcessHWTSKernelEvent(drvEventInfo, threadIndex);
    }

    int32_t AicpuEventManager::ProcDefaultEvent(const event_info &drvEventInfo, const uint32_t threadIndex)
    {
        (void)threadIndex;
        aicpusd_err("Receive event but no process handle, eventID=%d",
                    static_cast<int32_t>(drvEventInfo.comm.event_id));
        return AICPU_SCHEDULE_ERROR_NOT_FOUND_EVENT;
    }

    int32_t AicpuEventManager::ProcDvppMsgEvent(const event_info &drvEventInfo, const uint32_t threadIndex)
    {
        const int32_t ret = ProcessDvppEvent(drvEventInfo, threadIndex);
        return ret;
    }

    int32_t AicpuEventManager::ProcDvppMpiMsgEvent(const event_info &drvEventInfo, const uint32_t threadIndex)
    {
        const int32_t ret = ProcessMpiDvppEvent(drvEventInfo, threadIndex);
        return ret;
    }

    int32_t AicpuEventManager::ProcFrMsgEvent(const event_info &drvEventInfo, const uint32_t threadIndex)
    {
        const int32_t ret = ProcessRetrEvent(drvEventInfo, threadIndex);
        return ret;
    }

    int32_t AicpuEventManager::ProcSplitKernelEvent(const event_info &drvEventInfo, const uint32_t threadIndex)
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

    int32_t AicpuEventManager::ProcRandomKernelEvent(const event_info &drvEventInfo, const uint32_t threadIndex)
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

    int32_t AicpuEventManager::ProcTsCtrlEvent(const event_info &drvEventInfo, const uint32_t threadIndex)
    {
        (void)threadIndex;
        const int32_t ret = ProcessHWTSControlEvent(drvEventInfo);
        aicpusd_info("Finish to process CTRL event, eventid[%u], threadIndex[%u], ret[%d].",
                     drvEventInfo.comm.event_id, threadIndex, ret);
        return ret;
    }

    int32_t AicpuEventManager::ProcQueueEmptyToNotEmptyEvent(
        const event_info &drvEventInfo, const uint32_t threadIndex)
    {
        (void)threadIndex;
        const uint32_t queueId = drvEventInfo.comm.subevent_id;
        const int32_t ret = AicpuEventProcess::GetInstance().ProcessQueueNotEmptyEvent(queueId);
        aicpusd_info("Finish to process non-empty event, queueId[%u], threadIndex[%u], ret[%d].",
                     queueId, threadIndex, ret);
        return ret;
    }

    int32_t AicpuEventManager::ProcQueueFullToNotFullEvent(
        const event_info &drvEventInfo, const uint32_t threadIndex)
    {
        (void)threadIndex;
        const uint32_t queueId = drvEventInfo.comm.subevent_id;
        const int32_t ret = AicpuEventProcess::GetInstance().ProcessQueueNotFullEvent(queueId);
        aicpusd_info("Finish to process not full event, queueId[%u], threadIndex[%u], ret[%d].",
                     queueId, threadIndex, ret);
        return ret;
    }

    int32_t AicpuEventManager::ProcAicpuMsgEvent(const event_info &drvEventInfo, const uint32_t threadIndex)
    {
        (void)threadIndex;
        const int32_t ret = AicpuEventProcess::GetInstance().ProcessAICPUEvent(drvEventInfo);
        return ret;
    }

    int32_t AicpuEventManager::ProcQueueEvent(const event_info &drvEventInfo, const uint32_t threadIndex)
    {
        (void)threadIndex;
        const int32_t ret = AicpuEventProcess::GetInstance().ProcessEnqueueEvent(drvEventInfo);
        return ret;
    }

    int32_t AicpuEventManager::ProcOnPreprocessEvent(const event_info &drvEventInfo, const uint32_t threadIndex)
    {
        (void)threadIndex;
        if (FeatureCtrl::IsAosCore()) {
            return AICPU_SCHEDULE_OK;
        }
        DataPreprocess::TaskQueueMgr::GetInstance().OnPreprocessEvent(
            static_cast<uint32_t>(drvEventInfo.comm.event_id));
        aicpusd_info("Finish to process queue enqueue event, event id[%d], threadIndex[%u]",
                     drvEventInfo.comm.event_id, threadIndex);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuEventManager::ProcCDQEvent(const event_info &drvEventInfo, const uint32_t threadIndex)
    {
        (void)threadIndex;
        const int32_t ret = ProcessCdqEvent(drvEventInfo);
        return ret;
    }

    int32_t AicpuEventManager::ProcQsEvent(const event_info &drvEventInfo, const uint32_t threadIndex)
    {
        (void)threadIndex;
        const int32_t ret = AicpuQueueEventProcess::GetInstance().ProcessQsMsg(drvEventInfo);
        aicpusd_info("Finish to process queue event qs, event id[%d], threadIndex[%u], ret[%d]",
                     drvEventInfo.comm.event_id, threadIndex, ret);
        return ret;
    }

    int32_t AicpuEventManager::ProcDrvEvent(const event_info &drvEventInfo, const uint32_t threadIndex)
    {
        (void)threadIndex;
        const int32_t ret = AicpuQueueEventProcess::GetInstance().ProcessDrvMsg(drvEventInfo);
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
        const uint32_t curEventId = drvEventInfo.comm.event_id;
        if (curEventId >= EVENT_MAX_NUM) {
            aicpusd_err("Unknown event type, event_id[%u].", drvEventInfo.comm.event_id);
            return AICPU_SCHEDULE_ERROR_NOT_FOUND_EVENT;
        }
        const uint32_t threadid = (threadIndex >= MAX_AICPU_THREAD_NUM) ? 0U : threadIndex;
        ++recvEventStat_[threadid][curEventId];
        const int32_t ret = (this->*aicpuEventProcFunc_[curEventId])(drvEventInfo, threadIndex);
        ++procEventStat_[threadid][curEventId];
        return ret;
    }

    int32_t AicpuEventManager::DoOnceEsched(const uint32_t threadIndex, const uint32_t deviceId, const int32_t timeout)
    {
        event_info drvEventInfo;
        const int32_t retVal = halEschedWaitEvent(deviceId, groupId_, threadIndex, timeout, &drvEventInfo);
        if (retVal == DRV_ERROR_NONE) {
            if (g_aicpuProfiler.GetHiperfSoStatus()) {
                g_aicpuProfiler.InitProfiler(getpid(), static_cast<pid_t>(GetTid()));
                g_aicpuProfiler.SetProcEventStart();
                g_aicpuProfiler.SetEventId(drvEventInfo.comm.event_id);
                (void) ProcessEvent(drvEventInfo, threadIndex);
                g_aicpuProfiler.SetProcEventEnd();
                g_aicpuProfiler.Profiler();
                AicpuMsgSend::SendEvent();
            } else {
                (void) ProcessEvent(drvEventInfo, threadIndex);
                AicpuMsgSend::SendEvent();
            }
        } else if ((retVal == DRV_ERROR_SCHED_WAIT_TIMEOUT) || (retVal == DRV_ERROR_NO_EVENT)) {
            // if timeout, will continue wait event.
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
            AicpuMonitor::GetInstance().SendKillMsgToTsd();
        } else {
            // record a error code
            aicpusd_err("Failed to get event, error code[%d], deviceId[%u], groupId[%u], threadIndex[%u]",
                        retVal, deviceId, groupId_, threadIndex);
        }
        return retVal;
    }

    int32_t AicpuEventManager::DoOnceMsq(const uint32_t threadIndex, const uint32_t deviceId, const int32_t timeout)
    {
        (void)deviceId;
        (void)timeout;
        MsqDatas datas = {};
        if (MessageQueue::WaitMsqInfoOnce(datas)) {
            event_info drvEventInfo = {};
            if (FillEvent(*(PtrToPtr<MsqDatas, AicpuTopicMailbox>(&datas)), drvEventInfo) != AICPU_SCHEDULE_OK) {
                // if the PID is 0, it indicates an AICPU rescue op, directly return success.
                hwts_response_t resp = {};
                resp.result = 0U;
                resp.status = 0U;
                (void)ResponseMsq(0U, 0U, resp);
                return AICPU_SCHEDULE_OK;
            }
            (void)ProcessEvent(drvEventInfo, threadIndex);
        }

        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuEventManager::ResponseMsq(const uint32_t deviceId, const uint32_t subEventId,
                                           hwts_response_t &resp) const
    {
        (void)deviceId;
        (void)subEventId;
        MessageQueue::SendResponse(resp.result, resp.status);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuEventManager::ResponseEsched(const uint32_t deviceId, const uint32_t subEventId,
                                              hwts_response_t &resp) const
    {
        return halEschedAckEvent(deviceId, EVENT_TS_HWTS_KERNEL, subEventId, PtrToPtr<hwts_response_t, char_t>(&resp),
                                 static_cast<uint32_t>(sizeof(hwts_response_t)));
    }

    int32_t AicpuEventManager::FillEvent(const AicpuTopicMailbox &mb, event_info &eventInfo) const
    {
        (void)FillEventCommInfo(mb, eventInfo);

        if ((mb.topicId == EVENT_TS_HWTS_KERNEL) && (mb.kernelType != AICPU_TOPIC_DEFAULT_KERNEL_TYPE)) {
            return FillEventPrivHwtsInfo(mb, eventInfo);
        } else {
            (void)FillEventPrivCommInfo(mb, eventInfo);
        }

        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuEventManager::FillEventCommInfo(const AicpuTopicMailbox &mb, event_info &eventInfo) const
    {
        const uint64_t timeStamp = GetCurrentTime();
        eventInfo.comm.event_id = static_cast<EVENT_ID>(mb.topicId);
        eventInfo.comm.subevent_id = mb.subtopicId;
        eventInfo.comm.pid = mb.pid;
        eventInfo.comm.host_pid = -1;
        eventInfo.comm.grp_id = mb.gid;
        eventInfo.comm.submit_timestamp = timeStamp;
        eventInfo.comm.sched_timestamp = timeStamp;

        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuEventManager::FillEventPrivHwtsInfo(const AicpuTopicMailbox &mb, event_info &eventInfo) const
    {
        if (mb.pid == 0U) {
            aicpusd_run_info("Receive rescue aicpu op, start send response.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        static std::atomic<uint64_t> serialNo(0UL);
        const AicpuHwtsTaskInfo * const rtsTask = PtrToPtr<const uint32_t, const AicpuHwtsTaskInfo>(mb.userData);
        hwts_ts_task *task = PtrToPtr<char, hwts_ts_task>(eventInfo.priv.msg);
        task->mailbox_id = mb.mailboxId;
        task->kernel_info.pid = mb.pid;
        task->serial_no = serialNo;
        task->kernel_info.kernel_type = mb.kernelType;
        task->kernel_info.batchMode = mb.batchMode;
        task->kernel_info.satMode = mb.satMode;
        task->kernel_info.rspMode = mb.rspMode;
        task->kernel_info.streamID = mb.streamId;
        task->kernel_info.kernelName = rtsTask->taskNamePtr;
        task->kernel_info.kernelSo = rtsTask->taskSoNamePtr;
        task->kernel_info.paramBase = rtsTask->paraPtr;
        task->kernel_info.l2Ctrl = rtsTask->l2StructPtr;
        task->kernel_info.l2VaddrBase = 0ULL;
        task->kernel_info.blockId = mb.blkId;
        task->kernel_info.blockNum = mb.blkDim;
        task->kernel_info.l2InMain = 0U;
        task->kernel_info.taskID = rtsTask->extraFieldPtr;

        eventInfo.priv.msg_len = static_cast<uint32_t>(sizeof(hwts_ts_task));

        serialNo++;

        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuEventManager::FillEventPrivCommInfo(const AicpuTopicMailbox &mb, event_info &eventInfo) const
    {
        const uint32_t userDataLen = std::min(static_cast<uint32_t>(mb.userDataLen), AICPU_TOPIC_USER_DATA_PAYLOAD_LEN);
        const int32_t ret = memcpy_s(eventInfo.priv.msg, EVENT_MAX_MSG_LEN, &mb.userData[0], static_cast<uint64_t>(userDataLen));
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Failed to copy event msg, eventId=%u, subEventId=%u, max=%d, userDataLen=%u",
                        mb.topicId, mb.subtopicId, EVENT_MAX_MSG_LEN, userDataLen);
            return AICPU_SCHEDULE_ERROR_SAFE_FUNCTION_ERR;
        }

        eventInfo.priv.msg_len = userDataLen;

        return AICPU_SCHEDULE_OK;
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

    bool AicpuEventManager::ModelLoopTimeOut(const int32_t retVal, uint32_t &waitCounter, const uint32_t maxCounter)
    {
        if (retVal == DRV_ERROR_NONE) {
            waitCounter = 0U;
        } else if (++waitCounter >= maxCounter) {
            return true;
        }
        return false;
    }
    /**
     * @ingroup AicpuEventManager
     * @brief it is used in call model, which is used in different thread need different while loop variable.
     */
    void AicpuEventManager::CallModeLoopProcess()
    {
        g_runningThreadFlag = true;
        const uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
        uint32_t waitCounter = 0U;
        while (g_runningThreadFlag) {
            const int32_t retVal = DoOnce(0U, deviceId);
            const bool timeoutFlag = ModelLoopTimeOut(retVal, waitCounter, TIMEOUT_LOOP_MAX_INTERVAL);
            if (timeoutFlag) {
                g_runningThreadFlag = false;
                break;
            }
        }
        aicpusd_info("The loop of getting event is exit in call mode.");
    }

    void AicpuEventManager::SetRunningFlag(const bool runningFlag)
    {
        runningFlag_ = runningFlag;
    }

    int32_t AicpuEventManager::ProcProxyEvent(const event_info &drvEventInfo, const uint32_t threadIndex)
    {
        (void)threadIndex;
        const int32_t ret = AicpuQueueEventProcess::GetInstance().ProcessProxyMsg(drvEventInfo);
        return ret;
    }
}
