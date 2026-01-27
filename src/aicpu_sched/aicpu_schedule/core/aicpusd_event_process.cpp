/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpusd_event_process.h"
#include <iomanip>
#include <vector>
#include <securec.h>
#include <memory>
#include <new>
#include <dlfcn.h>
#include <set>
#include "aicpu_event_struct.h"
#include "aicpusd_threads_process.h"
#include "dump_task.h"
#include "aicpu_sched/common/aicpu_task_struct.h"
#include "aicpusd_resource_manager.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_profiler.h"
#include "aicpusd_monitor.h"
#include "aicpusd_msg_send.h"
#include "aicpu_context.h"
#include "aicpusd_cust_so_manager.h"
#include "aicpusd_model_err_process.h"
#include "aicpu_async_event.h"
#include "aicpusd_context.h"
#include "aicpu_prof.h"
#include "aicpusd_interface_process.h"
#include "aicpusd_cust_dump_process.h"
#include "common/aicpusd_util.h"
#include "hwts_kernel_register.h"
#include "hwts_kernel_common.h"
#include "profiling_adp.h"
#include "type_def.h"
#include "tsd.h"

namespace {
constexpr size_t MAX_KERNEL_NAME_LEN = 30UL;
constexpr uint16_t VALID_MAGIC_NUM = 0x5A5A;
const std::string EXTEND_SO_PLATFORM_FUNC_NAME = "AicpuExtendKernelsLoadPlatformInfo";
static constexpr uint8_t VERSION_0 = 0;
static constexpr uint8_t VERSION_1 = 1;
std::set<uint8_t> allVersion = {VERSION_0, VERSION_1};
}

namespace AicpuSchedule {
    /**
     * @ingroup AicpuEventProcess
     * @brief it is used to construct a object of AicpuEventProcess.
     */
    AicpuEventProcess::AicpuEventProcess()
        : exitQueueFlag_(false),
          platformFuncPtr_(nullptr)
    {
        aicpusd_info("AicpuEventProcess construct.");
        eventTaskProcess_[AICPU_SUB_EVENT_ACTIVE_STREAM] = &AicpuEventProcess::AICPUEventActiveAicpuStream;
        eventTaskProcess_[AICPU_SUB_EVENT_EXECUTE_MODEL] = &AicpuEventProcess::AICPUEventExecuteModel;
        eventTaskProcess_[AICPU_SUB_EVENT_REPEAT_MODEL] = &AicpuEventProcess::AICPUEventRepeatModel;
        eventTaskProcess_[AICPU_SUB_EVENT_RECOVERY_STREAM] = &AicpuEventProcess::AICPUEventRecoveryStream;
        eventTaskProcess_[AICPU_SUB_EVENT_UPDATE_PROFILING_MODE] = &AicpuEventProcess::AICPUEventUpdateProfilingMode;
        eventTaskProcess_[AICPU_SUB_EVENT_END_GRAPH] = &AicpuEventProcess::AICPUEventEndGraph;
        eventTaskProcess_[AICPU_SUB_EVENT_PREPARE_MEM] = &AicpuEventProcess::AICPUEventPrepareMem;
        eventTaskProcess_[AICPU_SUB_EVENT_TABLE_UNLOCK] = &AicpuEventProcess::AICPUEventTableUnlock;
        eventTaskProcess_[AICPU_SUB_EVENT_SUPPLY_ENQUEUE] = &AicpuEventProcess::AICPUEventSupplyEnque;
    }

    /**
     * @ingroup AicpuEventProcess
     * @brief it is used to destructor a object of AicpuEventProcess.
     */
    AicpuEventProcess::~AicpuEventProcess() {}

    AicpuEventProcess &AicpuEventProcess::GetInstance()
    {
        static AicpuEventProcess instance;
        return instance;
    }

    void AicpuEventProcess::InitQueueFlag()
    {
        exitQueueFlag_ = true;
    }

    int32_t AicpuEventProcess::AICPUEventActiveAicpuStream(const AICPUSubEventInfo &subEventInfo) const
    {
        const uint32_t modelId = subEventInfo.modelId;
        const uint32_t streamId = subEventInfo.para.streamInfo.streamId;
        aicpusd_info("Begin to active aicpu stream, model[%u] streamId[%u]", modelId, streamId);

        const auto model = AicpuModelManager::GetInstance().GetModel(modelId);
        if (model == nullptr) {
            aicpusd_err("Model[%u] recover event failed, no model found.", modelId);
            return AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND;
        }

        const int32_t ret = model->ActiveStream(streamId);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Model[%u] active aicpu stream[%u] failed, ret[%d]", modelId, streamId, ret);
            return ret;
        }
        aicpusd_info("Model[%u] finish to active aicpu stream[%u]", modelId, streamId);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuEventProcess::AICPUEventExecuteModel(const AICPUSubEventInfo &subEventInfo) const
    {
        const uint32_t modelId = subEventInfo.modelId;
        aicpusd_info("Begin to execute model[%u]", modelId);
        AicpuModel * const model = AicpuModelManager::GetInstance().GetModel(modelId);
        if (model == nullptr) {
            aicpusd_err("Model[%u] execute model event failed, no model found.", modelId);
            return AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND;
        }

        // execute the model
        const int32_t ret = model->ModelExecute();
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Model[%u] execute failed, ret[%d]", modelId, ret);
            return ret;
        }
        aicpusd_info("Finish to execute model[%u]", modelId);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuEventProcess::AICPUEventRepeatModel(const AICPUSubEventInfo &subEventInfo) const
    {
        const uint32_t modelId = subEventInfo.modelId;
        aicpusd_info("Begin to execute repeat model[%u]", modelId);
        AicpuModel * const model = AicpuModelManager::GetInstance().GetModel(modelId);
        if (model == nullptr) {
            aicpusd_err("Model[%u] repeat event failed, as no model found.", modelId);
            return AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND;
        }

        // execute the model
        const int32_t ret = model->ModelRepeat();
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Model[%u] repeat failed, ret[%d].", modelId, ret);
            return ret;
        }
        aicpusd_info("Finshed to execute repeat model[%u]", modelId);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuEventProcess::AICPUEventRecoveryStream(const AICPUSubEventInfo &subEventInfo) const
    {
        const uint32_t recoverStreamId = subEventInfo.para.streamInfo.streamId;
        const uint32_t modelId = subEventInfo.modelId;
        aicpusd_info("Begin to recovery aicpu stream, model[%u] streamId[%u]", modelId, recoverStreamId);
        AicpuModel * const model = AicpuModelManager::GetInstance().GetModel(modelId);
        if (model == nullptr) {
            aicpusd_err("Model[%u] recover event failed, as no model found.", modelId);
            return AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND;
        }

        const int32_t ret = model->RecoverStream(recoverStreamId);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Model[%u] recovery aicpu stream[%u] failed, ret[%d].", modelId, recoverStreamId, ret);
            return ret;
        }
        aicpusd_info("Model[%u] finshed to recovery aicpu stream[%u]", modelId, recoverStreamId);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuEventProcess::AICPUEventUpdateProfilingMode(const AICPUSubEventInfo &subEventInfo) const
    {
        const uint32_t flag = subEventInfo.para.modeInfo.flag;
        // set or unset mode
        const bool isStart = (flag & (1U << aicpu::PROFILING_FEATURE_SWITCH)) > 0U;
        // if set or unset kernel profiling mode
        const bool kernelMode = (flag & (1U << aicpu::PROFILING_FEATURE_KERNEL_MODE)) > 0U;
        // if set or unset model profiling mode
        const bool modelMode = (flag & (1U << aicpu::PROFILING_FEATURE_MODEL_MODE)) > 0U;
        ProfilingMode mode = PROFILING_CLOSE;
        bool isModelModeOn = false;
        aicpu::SetProfilingFlagForKFC(flag);
        if (isStart) {
            mode = PROFILING_OPEN;
            isModelModeOn = true;
        }
        if (kernelMode) {
            AicpuSchedule::ComputeProcess::GetInstance().UpdateProfilingMode(mode);
        }
        if (modelMode) {
            AicpuSchedule::ComputeProcess::GetInstance().UpdateProfilingModelMode(isModelModeOn);
        }
        aicpusd_info("Begin to update aicpu event profiling mode, flag[%lu], isStart[%d], mode[%d],"
                     " isModelModeOn[%d]", flag, isStart, mode, isModelModeOn);
        const std::vector<uint32_t> deviceVec = AicpuDrvManager::GetInstance().GetDeviceList();
        if (deviceVec.empty()) {
            aicpusd_err("the device vector is empty");
            return AICPU_SCHEDULE_ERROR_TASK_EXECUTE_FAILED;
        }
        if (SendUpdateProfilingRspToTsd(deviceVec[0],
                                        static_cast<uint32_t>(TsdWaitType::TSD_COMPUTE),
                                        static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid()),
                                        AicpuDrvManager::GetInstance().GetVfId())  != AICPU_SCHEDULE_OK) {
            aicpusd_err("send profiline response to tsd failed");
            return AICPU_SCHEDULE_ERROR_TASK_EXECUTE_FAILED;
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuEventProcess::AICPUEventEndGraph(const AICPUSubEventInfo &subEventInfo) const
    {
        const uint32_t modelId = subEventInfo.modelId;
        const uint32_t result = subEventInfo.para.endGraphInfo.result;
        aicpusd_info("AicpuEventProcess::AICPUEventEndGraph: modelId[%u], result[%u]", modelId, result);
        AicpuModel * const model = AicpuModelManager::GetInstance().GetModel(modelId);
        if (model == nullptr) {
            aicpusd_err("Receive model[%u] EndGraph msg, but no model found.", modelId);
            return AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND;
        }
        int32_t ret = AICPU_SCHEDULE_OK;
        if ((result == 0U) || (model->AbnormalEnabled())) {
            if (result != 0) {
                aicpusd_err("modelId[%u] execute fail, result[%u]", modelId, result);
                model->SetModelRetCode(static_cast<int32_t>(result));
            }
            ret = HwTsKernelCommon::ProcessEndGraph(modelId);
        } else {
            ret = model->ModelAbort();
        }
        return ret;
    }

    int32_t AicpuEventProcess::AICPUEventPrepareMem(const AICPUSubEventInfo &subEventInfo) const
    {
        const uint32_t modelId = subEventInfo.modelId;

        bool hasWait = false;
        uint32_t waitStreamId = 0U;
        EventWaitManager::PrepareMemWaitManager().Event(static_cast<size_t>(modelId), hasWait, waitStreamId);
        if (!hasWait) {
            return AICPU_SCHEDULE_OK;
        }

        AicpuModel * const model = AicpuModelManager::GetInstance().GetModel(modelId);
        if (model == nullptr) {
            aicpusd_err("Receive model[%u] PrepareMem msg, but no model found.", modelId);
            return AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND;
        }

        aicpusd_info("Begin to recover execute model[%u] stream[%u].", modelId, waitStreamId);
        // Recovery stream Execute.
        const auto ret = model->RecoverStream(waitStreamId);
        if (ret == AICPU_SCHEDULE_OK) {
            aicpusd_info("PrepareMem event of model[%u] recover execute stream[%u] success.", modelId, waitStreamId);
        } else {
            aicpusd_err("PrepareMem event of model[%u] recover execute stream[%u] failed, ret[%d].",
                        modelId, waitStreamId, ret);
        }
        return ret;
    }

    int32_t AicpuEventProcess::AICPUEventTableUnlock(const AICPUSubEventInfo &subEventInfo) const
    {
        const uint32_t tableId = subEventInfo.para.unlockTableInfo.tableId;
        for (const auto model : AicpuModelManager::GetInstance().GetModelsByTableId(tableId)) {
            bool hasWait = false;
            uint32_t waitStreamId = 0U;
            EventWaitManager::TableUnlockWaitManager().Event(
                static_cast<size_t>(model->GetId()), hasWait, waitStreamId);
            if (!hasWait) {
                continue;
            }
            const auto ret = model->RecoverStream(waitStreamId);
            if (ret != AICPU_SCHEDULE_OK) {
                aicpusd_err("TableUnlock event to recover model[%u], stream[%u] failed, ret is [%d]",
                    model->GetId(), waitStreamId, ret);
                return ret;
            }
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuEventProcess::AICPUEventSupplyEnque(const AICPUSubEventInfo &subEventInfo) const
    {
        const uint32_t modelId = subEventInfo.modelId;
        const auto model = AicpuModelManager::GetInstance().GetModel(modelId);
        if (model == nullptr) {
            aicpusd_err("Fail to find model[%u]", modelId);
            return AICPU_SCHEDULE_ERROR_STREAM_NOT_FOUND;
        }

        bool hasWait = false;
        uint32_t waitStreamId = INVALID_NUMBER;
        EventWaitManager::AnyQueNotEmptyWaitManager().Event(static_cast<size_t>(modelId), hasWait, waitStreamId);
        if (!hasWait) {
            aicpusd_info("AnyQueNotEmpty[%u] event don't need to recover execute stream.", modelId);
            return AICPU_SCHEDULE_OK;
        }

        aicpusd_info("Begin to recover execute stream[%u].", waitStreamId);
        // Recovery stream Execute.
        const auto ret = model->RecoverStream(waitStreamId);
        if (ret == AICPU_SCHEDULE_OK) {
            aicpusd_info("AnyQueNotEmpty[%u] event recover execute stream[%u] success.", modelId, waitStreamId);
        } else {
            aicpusd_err("AnyQueNotEmpty[%u] event recover execute stream[%u] failed, ret[%d].",
                modelId, waitStreamId, ret);
        }
        return ret;
    }

    /**
     * @ingroup AicpuEventProcess
     * @brief it is used to process the report of task.
     * @param [in] info : the information of task.
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    int32_t AicpuEventProcess::ProcessTaskReportEvent(AicpuSqeAdapter &aicpuSqeAdapter) const
    {
        AicpuSqeAdapter::AicpuTaskReportInfo info{};
        aicpuSqeAdapter.GetAicpuTaskReportInfo(info);
        const uint32_t modelId = static_cast<uint32_t>(info.model_id);
        aicpusd_run_info("Begin to process task report. modelId=%u, retCode=%d.", modelId, info.result_code);
        AicpuModel * const model = AicpuModelManager::GetInstance().GetModel(modelId);
        if (model == nullptr) {
            aicpusd_err("Model[%u] task report event failed, no model found.", modelId);
            AicpuModelErrProc::GetInstance().RecordAicoreOpErrLog(info, aicpuSqeAdapter);
            return AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND;
        }
        if (!model->IsEndOfSequence()) {
            AicpuModelErrProc::GetInstance().RecordAicoreOpErrLog(info, aicpuSqeAdapter);
            if (static_cast<int32_t>(info.result_code) == static_cast<int32_t>(TS_MODEL_STREAM_EXE_FAILED)) {
                model->SetModelRetCode(INNER_ERROR_BASE + AICPU_SCHEDULE_ERROR_MODEL_EXECUTE_FAILED);
            } else {
                model->SetModelRetCode(INNER_ERROR_BASE + AICPU_SCHEDULE_ERROR_TSCH_OTHER_ERROR);
            }
        }

        AicpuMonitor::GetInstance().SetModelEndTime(modelId);
        int32_t ret = AICPU_SCHEDULE_OK;
        if (exitQueueFlag_) {
            if (model->IsEndOfSequence() || model->AbnormalEnabled()) {
                aicpusd_run_info("Begin to execute endgraph.");
                return HwTsKernelCommon::ProcessEndGraph(modelId);
            }
            // this branch is for model has queue
            ret = model->ModelAbort();
            if (ret != AICPU_SCHEDULE_OK) {
                return ret;
            }

            aicpusd_run_info("begin to execute ModelRepeat. modelId[%u].", modelId);
            AICPUSubEventInfo subEventInfo = {};
            subEventInfo.modelId = modelId;
            ret = AicpuMsgSend::SendAICPUSubEvent(PtrToPtr<AICPUSubEventInfo, const char_t>(&subEventInfo),
                static_cast<uint32_t>(sizeof(AICPUSubEventInfo)),
                AICPU_SUB_EVENT_REPEAT_MODEL,
                CP_DEFAULT_GROUP_ID,
                false);
        } else {
            ret = model->TaskReport();
        }
        return ret;
    }

    /**
    * @ingroup AicpuEventProcess
    * @brief it use to process data dump event.
    * @param [in] ctrlMsg : the struct of control task.
    * @return AICPU_SCHEDULE_OK: success, other: error code
    */
    int32_t AicpuEventProcess::ProcessSetTimeoutEvent(AicpuSqeAdapter &aicpuSqeAdapter) const
    {
        AicpuSqeAdapter::AicpuTimeOutConfigInfo opTimeoutCfg{};
        aicpuSqeAdapter.GetAicpuTimeOutConfigInfo(opTimeoutCfg);
        const uint32_t excTimeoutEnable = opTimeoutCfg.i.op_execute_timeout_en;
        const uint32_t excTimeoutVal = opTimeoutCfg.i.op_execute_timeout;
        const uint32_t waitTimeoutEnable = opTimeoutCfg.i.op_wait_timeout_en;
        const uint32_t waitTimeoutVal = opTimeoutCfg.i.op_wait_timeout;
        aicpusd_run_info("Get opTimeoutEnable[%u] value[%u] waitTimeoutEnable[%u] value[%u] from ts success.",
                      excTimeoutEnable, excTimeoutVal, waitTimeoutEnable, waitTimeoutVal);
        uint32_t ret = AICPU_SCHEDULE_OK;
        bool validTimeoutParam = true;

        if (excTimeoutEnable == 1U) {
            if (AicpuUtil::IsValidTimeoutVal(excTimeoutVal)) {
                AicpuMonitor::GetInstance().SetOpExecuteTimeOut(excTimeoutEnable, excTimeoutVal);
                aicpusd_info("Config OP execute timeout success, enable[%u] timeout[%us].",
                             excTimeoutEnable, excTimeoutVal);
            } else {
                validTimeoutParam = false;
            }
        }

        const uint32_t curTimeoutVal = AicpuMonitor::GetInstance().GetTaskDefaultTimeout();
        if (waitTimeoutEnable == 1U) {
            if ((waitTimeoutVal != 0U) && (waitTimeoutVal < curTimeoutVal)) {
                // if ts has start wait op timeout, then need disable aicpu op timer
                // The waitTimeoutVal is 0 indicates that the timeout never expires.
                aicpusd_run_info(
                    "Close aicpu op timer, waitTimeVal[%us], curTimeVal[%us].", waitTimeoutVal, curTimeoutVal);
                AicpuMonitor::GetInstance().SetOpTimeoutFlag(false);
            } else {
                aicpusd_run_info(
                    "Reopen aicpu op timer, waitTimeVal[%us], curTimeVal[%us].", waitTimeoutVal, curTimeoutVal);
                AicpuMonitor::GetInstance().SetOpTimeoutFlag(true);
            }
        }

        if (!validTimeoutParam) {
            aicpusd_err("valid Timeout Param opTimeoutEnable[%u] value[%u] waitTimeoutEnable[%u] value[%u]",
                        excTimeoutEnable, excTimeoutVal, waitTimeoutEnable, waitTimeoutVal);
            ret = static_cast<uint32_t>(
                AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
        }

        aicpusd_info("Begin AicpuTimeOutConfigResponseToTs using tsDevSendMsgAsync function.");
        const int32_t tmpRet  =  aicpuSqeAdapter.AicpuTimeOutConfigResponseToTs(
                                                   static_cast<uint32_t>(ret));
        aicpusd_info("Finished AicpuTimeOutConfigResponseToTs, ret[%d].", tmpRet);
        return tmpRet;
    }

    /**
    * @ingroup AicpuEventProcess
    * @brief it is used to process the msg version.
    * @param [in] info : the information of task.
    * @return AICPU_SCHEDULE_OK: success, other: error code
    */
    int32_t AicpuEventProcess::ProcessMsgVersionEvent(AicpuSqeAdapter &aicpuSqeAdapter) const 
    {
        aicpusd_info("Begin to process msg version event.");
        AicpuSqeAdapter::AicpuMsgVersionInfo info {};
        aicpuSqeAdapter.GetAicpuMsgVersionInfo(info);
        int32_t ret = AICPU_SCHEDULE_OK;
        if (info.magic_num != VALID_MAGIC_NUM) {
            aicpusd_err("Magic num[%hu] is not valid.", info.magic_num);
            return AICPU_SCHEDULE_ERROR_INVALID_MAGIC_NUM;
        } else {
            uint16_t version = info.version;
            if (allVersion.find(version) == allVersion.end()) {
                aicpusd_err("Version is incorrect, version[%hu]", version);
                return AICPU_SCHEDULE_ERROR_INNER_ERROR;
            }
            FeatureCtrl::SetTsMsgVersion(version);
            aicpusd_info("Set msg version [%hu].", version); 
        }
        aicpusd_info("Begin to send response msg version.");
        int32_t rspRet = aicpuSqeAdapter.AicpuMsgVersionResponseToTs(ret);
        aicpusd_info("Finished to send response msg version information, ret[%d].", rspRet);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Failed to response info, ret[%d]", ret);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        return AICPU_SCHEDULE_OK;
    }
    /**
    * @ingroup AicpuEventProcess
    * @brief it use to process data dump event.
    * @param [in] ctrlMsg : the struct of control task.
    * @return AICPU_SCHEDULE_OK: success, other: error code
    */
    int32_t AicpuEventProcess::ProcessDumpDataEvent(AicpuSqeAdapter &aicpuSqeAdapter) const
    {
        AicpuSchedule::OpDumpTaskManager &opDumpTaskMgr = AicpuSchedule::OpDumpTaskManager::GetInstance();
        AicpuSqeAdapter::AicpuDataDumpInfo info {};
        aicpuSqeAdapter.GetAicpuDataDumpInfo(info);
        aicpusd_info("Begin to dump data, stream id[%u], task id[%u], debug stream id[%u], debug task id[%u],"
                     "is model[%u], file name stream id [%u], file name task id [%u]",
                    info.dump_stream_id,
                    info.dump_task_id,
                    info.debug_dump_stream_id,
                    info.debug_dump_task_id,
                    info.is_model,
                    info.file_name_stream_id,
                    info.file_name_task_id);
                int32_t ret = AICPU_SCHEDULE_OK;
        TaskInfoExt dumpTaskInfo(static_cast<volatile uint32_t>(info.dump_stream_id),
                                        static_cast<volatile uint32_t>(info.dump_task_id));
        DumpFileName dumpFileName(info.file_name_stream_id, info.file_name_task_id);
        if (info.is_debug && FeatureCtrl::IsNoNeedDumpOpDebugProduct()) {
            aicpusd_warn("Not support to dump Op debug, stream id[%u],"
                            " task id[%u], stream id1[%u], task id1[%u], is model[%u],",
                            info.dump_stream_id, info.dump_task_id, info.debug_dump_stream_id, info.debug_dump_task_id,
                            info.is_model);
        } else {
            ret = opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, dumpFileName);
        }
        if (info.is_model && info.is_debug) {
            TaskInfoExt debugdumpTaskInfo(static_cast<volatile uint32_t>(info.debug_dump_stream_id),
                                  static_cast<volatile uint32_t>(info.debug_dump_task_id));
            const int32_t tmpRet = opDumpTaskMgr.DumpOpInfo(debugdumpTaskInfo, dumpFileName);
            ret = (ret == AICPU_SCHEDULE_OK)? tmpRet : ret;
        }
        return SendDumpResponceInfo(aicpuSqeAdapter, ret);
    }

    /**
    * @ingroup AicpuEventProcess
    * @brief it use to process FFTSPlus data dump event.
    * @param [in] ctrlMsg : the struct of control task.
    * @return AICPU_SCHEDULE_OK: success, other: error code
    */
    int32_t AicpuEventProcess::ProcessDumpFFTSPlusDataEvent(AicpuSqeAdapter &aicpuSqeAdapter) const
    {
        AicpuSchedule::OpDumpTaskManager &opDumpTaskMgr = AicpuSchedule::OpDumpTaskManager::GetInstance();
        AicpuSqeAdapter::AicpuDumpFFTSPlusDataInfo info {};
        aicpuSqeAdapter.GetAicpuDumpFFTSPlusDataInfo(info);
        aicpusd_info("Begin to dump FFTSPlus data, stream id[%u], task id[%u], stream id1[%u], task id1[%u], "
                     "model id[%u], context id[%u], thread id[%u], reserved[%u].",
                     info.i.stream_id, info.i.task_id, info.i.stream_id1, info.i.task_id1,
                     static_cast<uint32_t>(info.i.model_id), info.i.context_id, info.i.thread_id, info.i.reserved[0]);

        int32_t ret = AICPU_SCHEDULE_OK;
        bool validDumpParam = false;
        uint32_t ackStreamId = info.i.stream_id;
        uint32_t ackTaskId = info.i.task_id;
        if ((info.i.task_id != INVALID_VAL) && (info.i.stream_id != INVALID_VAL)) {
            validDumpParam = true;
            const bool isFftsPlusOverflow = (info.i.task_id1 != INVALID_VAL) && (info.i.stream_id1 != INVALID_VAL);
            uint32_t contextId = static_cast<volatile uint32_t>(info.i.context_id);
            uint32_t threadId = static_cast<volatile uint32_t>(info.i.thread_id);
            if (isFftsPlusOverflow) {
                contextId = INVALID_VAL;
                threadId = INVALID_VAL;
            }
            TaskInfoExt dumpTaskInfo(static_cast<volatile uint32_t>(info.i.stream_id),
                                           static_cast<volatile uint32_t>(info.i.task_id),
                                           contextId,
                                           threadId);
            DumpFileName dumpFileName(info.i.stream_id1, info.i.task_id1, info.i.context_id, info.i.thread_id);
            ret = opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, dumpFileName);
        }
        if ((info.i.task_id1 != INVALID_VAL) && (info.i.stream_id1 != INVALID_VAL)) {
            validDumpParam = true;
            ackStreamId = info.i.stream_id1;
            ackTaskId = info.i.task_id1;
            TaskInfoExt dumpTaskInfo(static_cast<volatile uint32_t>(info.i.stream_id1),
                                           static_cast<volatile uint32_t>(info.i.task_id1),
                                           static_cast<volatile uint32_t>(info.i.context_id),
                                           static_cast<volatile uint32_t>(info.i.thread_id));
            DumpFileName dumpFileName(info.i.stream_id1, info.i.task_id1, info.i.context_id, info.i.thread_id);
            const int32_t tmpRet = opDumpTaskMgr.DumpOpInfo(dumpTaskInfo, dumpFileName);
            ret = (ret == AICPU_SCHEDULE_OK)? tmpRet : ret;
        }

        if (!validDumpParam) {
            aicpusd_err("Invalid dump FFTSPlus param, stream id[%hu], task id[%hu], stream id1[%hu], task id1[%hu], " \
                        "context id[%hu], thread id[%u].",
                        info.i.stream_id, info.i.task_id, info.i.stream_id1,
                        info.i.task_id1, info.i.context_id, info.i.thread_id);
            ret = AICPU_SCHEDULE_ERROR_DUMP_FAILED;
        }

        return SendDumpResponceInfo(aicpuSqeAdapter, ret);
    }

    int32_t AicpuEventProcess::SendDumpResponceInfo(AicpuSqeAdapter &adapter,  const int32_t &dumpRet) const
    {
        // send response information to ts.
        aicpusd_info("Begin to send response information using tsDevSendMsgAsync function.");
        const int32_t ret = adapter.AicpuDumpResponseToTs(dumpRet);
        aicpusd_info("Finished to send dump report information, ret[%d].", ret);
        return ret;
    }

    /**
    * @ingroup AicpuEventProcess
    * @brief it use to process op mapping load event.
    * @param [in] ctrlMsg : the struct of control task.
    * @return AICPU_SCHEDULE_OK: success, other: error code
    */
    int32_t AicpuEventProcess::ProcessLoadOpMappingEvent(AicpuSqeAdapter &aicpuSqeAdapter) const
    {
        aicpusd_info("Begin to load op mapping event.");
        AicpuSqeAdapter::AicpuDataDumpInfoLoad info {};
        aicpuSqeAdapter.GetAicpuDataDumpInfoLoad(info);
        const char_t * const opMappingInfo =
            PtrToPtr<void, char_t>(ValueToPtr(static_cast<uintptr_t>(info.dumpinfoPtr)));
        const uint32_t len = info.length;
        AicpuSchedule::OpDumpTaskManager &opDumpTaskMgr = AicpuSchedule::OpDumpTaskManager::GetInstance();
        int32_t ret = opDumpTaskMgr.LoadOpMappingInfo(opMappingInfo, len, aicpuSqeAdapter);
        uint32_t runMode;
        const aicpu::status_t status = aicpu::GetAicpuRunMode(runMode);
        if (status != aicpu::AICPU_ERROR_NONE) {
            aicpusd_err("Get current aicpu ctx failed.");
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        const uint32_t deviceId = AicpuSchedule::AicpuDrvManager::GetInstance().GetDeviceId();
        AicpuSchedule::AicpuSdCustDumpProcess::GetInstance().InitCustDumpProcess(deviceId,
            static_cast<aicpu::AicpuRunMode>(runMode));
        // send response information to ts.
        aicpusd_info("Begin to send response information using tsDevSendMsgAsync function; load ret[%d].", ret);
        ret = aicpuSqeAdapter.AicpuDataDumpLoadResponseToTs(ret);
        aicpusd_info("Finished to send dump load info report info, ret[%d].", ret);
        return ret;
    }

    /**
     * @ingroup AicpuEventProcess
     * @brief it use to process the AICPU event.
     * @param [in] drvEventInfo : the event information from ts.
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    int32_t AicpuEventProcess::ProcessAICPUEvent(const event_info &drvEventInfo)
    {
        if (static_cast<size_t>(drvEventInfo.priv.msg_len) != sizeof(AICPUSubEventInfo)) {
            aicpusd_err("The len[%u] is not correct[%zu].", drvEventInfo.priv.msg_len, sizeof(AICPUSubEventInfo));
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        // for the msg is address of array, it is not a nullptr.
        // so the info is not used to judge whether is nullptr;
        const AICPUSubEventInfo * const info = PtrToPtr<const char_t, const AICPUSubEventInfo>(drvEventInfo.priv.msg);

        int32_t ret = AICPU_SCHEDULE_OK;
        // find process function of the subevent id.
        const AICPUSubEvent drvEventId = static_cast<AICPUSubEvent>(drvEventInfo.comm.subevent_id);
        aicpusd_info("Begin to receive the aicpu event, eventId[%d], drvEventId[%d]",
                     drvEventInfo.comm.subevent_id, drvEventId);
        if (drvEventId >= AICPU_SUB_EVENT_MAX_NUM) {
            aicpusd_err("The subevent id is invalid, id[%u].", drvEventInfo.comm.subevent_id);
            return AICPU_SCHEDULE_ERROR_UNKNOW_AICPU_EVENT;
        }
        const EventProcess taskProcess = eventTaskProcess_[drvEventId];
        if (taskProcess != nullptr) {
            ret = (this->*taskProcess)(*info);
        } else {
            aicpusd_err("The subevent id is invalid, id[%u].", drvEventInfo.comm.subevent_id);
            return AICPU_SCHEDULE_ERROR_UNKNOW_AICPU_EVENT;
        }
        // Failed to execute the task , it need to handle error.
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("failed to process aicpu event, eventId[%d].", drvEventId);
            return ret;
        }
        aicpusd_info("Success to process aicpu event, eventId[%d]", drvEventId);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuEventProcess::ProcessQueueNotEmptyEvent(const uint32_t queueId) const
    {
        bool hasWait = false;
        uint32_t waitStreamId = INVALID_NUMBER;
        EventWaitManager::QueueNotEmptyWaitManager().Event(static_cast<const size_t>(queueId), hasWait, waitStreamId);
        if (!hasWait) {
            // find model by qid
            const auto model = AicpuModelManager::GetInstance().GetModelByQueueId(queueId);
            if (model != nullptr) {
                aicpusd_info("GetModelByQueueId for %u is model %u", queueId, model->GetId());
                EventWaitManager::AnyQueNotEmptyWaitManager().Event(
                    static_cast<size_t>(model->GetId()), hasWait, waitStreamId);
            }
        }
        if (!hasWait) {
            aicpusd_info("Queue[%u] non-empty event don't need to recover execute stream.", queueId);
            // Execute the asynchronous operator that registers the event.
            (void)aicpu::AsyncEventManager::GetInstance().ProcessEvent(EVENT_QUEUE_EMPTY_TO_NOT_EMPTY, queueId);
            return AICPU_SCHEDULE_OK;
        }
        const auto model = AicpuModelManager::GetInstance().GetModelByStreamId(waitStreamId);
        if (model == nullptr) {
            aicpusd_err("Queue[%u] non-empty event recover execute stream[%u] failed, as find modelId failed.",
                        queueId, waitStreamId);
            return AICPU_SCHEDULE_ERROR_STREAM_NOT_FOUND;
        }
        aicpusd_info("Begin to recover execute stream[%u].", waitStreamId);
        // Recovery stream Execute.
        const auto ret = model->RecoverStream(waitStreamId);
        if (ret == AICPU_SCHEDULE_OK) {
            aicpusd_info("Queue[%u] non-empty event recover execute stream[%u] success.",
                         queueId, waitStreamId);
        } else {
            aicpusd_err("Queue[%u] non-empty event recover execute stream[%u] failed, ret[%d].",
                        queueId, waitStreamId, ret);
        }
        return ret;
    }

    int32_t AicpuEventProcess::ProcessEnqueueEvent(const event_info &drvEventInfo) const
    {
        const uint32_t drvEventId = drvEventInfo.comm.event_id;
        const uint32_t drvSubeventId = drvEventInfo.comm.subevent_id;
        aicpusd_info("ProcessEnqueue by eventId[%u] subeventId[%u] begin", drvEventId, drvSubeventId);
        if (&aicpu::DoEventCallback == nullptr) {
            aicpusd_info("Can not find DoEventCallback symbol, skip event process");
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        void * const param = PtrToPtr<event_info, void>(const_cast<event_info *>(&drvEventInfo));
        const auto ret = aicpu::DoEventCallback(drvEventId, drvSubeventId, param);
        aicpusd_info("Finish to call ProcessEnqueue by eventId:[%u] subeventId:[%u] end, ret:[%d]",
                     drvEventId, drvSubeventId, ret);
        return ret;
    }

    int32_t AicpuEventProcess::ProcessQueueNotFullEvent(const uint32_t queueId) const
    {
        bool hasWait = false;
        uint32_t waitStreamId = INVALID_NUMBER;
        EventWaitManager::QueueNotFullWaitManager().Event(static_cast<const size_t>(queueId), hasWait, waitStreamId);
        if (!hasWait) {
            aicpusd_info("Queue[%u] not full event don't need to recover execute stream.", queueId);
            // Execute the asynchronous operator that registers the event.
            (void)aicpu::AsyncEventManager::GetInstance().ProcessEvent(EVENT_QUEUE_FULL_TO_NOT_FULL, queueId);
            return AICPU_SCHEDULE_OK;
        }
        const auto model = AicpuModelManager::GetInstance().GetModelByStreamId(waitStreamId);
        if (model == nullptr) {
            aicpusd_err("Queue[%u] not full event recover execute stream[%u] failed, as find modelId failed.",
                        queueId, waitStreamId);
            return AICPU_SCHEDULE_ERROR_STREAM_NOT_FOUND;
        }

        aicpusd_info("Begin to recover execute stream[%u].", waitStreamId);
        const auto ret = model->RecoverStream(waitStreamId);
        if (ret == AICPU_SCHEDULE_OK) {
            aicpusd_info("Queue[%u] not full event recover execute stream[%u] success.",
                         queueId, waitStreamId);
        } else {
            aicpusd_err("Queue[%u] not full event recover execute stream[%u] failed, ret[%d].",
                        queueId, waitStreamId, ret);
        }
        return ret;
    }

    /**
     * @ingroup AicpuEventProcess
     * @brief it use to process response information.
     * @param [in] ctrlMsg : the struct of control task.
     * @param [in] resultcode : the result of execute task.
     * @param [in] subEvent : it is used to store subeventid which is in receive struct.
     * @param [in] noThreadFlag : no thread flag.
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    int32_t AicpuEventProcess::ProcessResponseInfo(AicpuSqeAdapter &adapter,
                                                   const uint16_t resultCode,
                                                   const uint32_t subEvent,
                                                   const bool noThreadFlag) const
    {
        aicpusd_info("Begin to process response info.");
        AicpuSqeAdapter::AicpuModelOperateInfo info {};
        adapter.GetAicpuModelOperateInfo(info);
        if ((static_cast<int32_t>(info.cmd_type) == TS_AICPU_MODEL_ABORT) && (noThreadFlag)) {
            // directly to exist, it don't need to send response to ts.
            return DRV_ERROR_NONE;
        }
        const int32_t transedResult = AicpuSchedule::AicpuUtil::TransformInnerErrCode(static_cast<int32_t>(resultCode));
        const int32_t ret = adapter.AicpuModelOperateResponseToTs(transedResult, subEvent);
        // send response information to ts.
        aicpusd_info("Finished to send response information, ret[%d].", ret);
        return ret;
    }

    int32_t AicpuEventProcess::ExecuteTsKernelTask(aicpu::HwtsTsKernel &tsKernelInfo, const uint32_t threadIndex,
                                                   const uint64_t drvSubmitTick, const uint64_t drvSchedTick,
                                                   const uint64_t streamId, const uint64_t taskId)
    {
        const aicpu::KernelType kernelType = static_cast<const aicpu::KernelType>(tsKernelInfo.kernelType);
        if (((kernelType == aicpu::KernelType::KERNEL_TYPE_CCE) ||
                (kernelType == aicpu::KernelType::KERNEL_TYPE_AICPU)) &&
            (tsKernelInfo.kernelBase.cceKernel.kernelSo == 0UL)) {
            return ExecuteLogicKernel(tsKernelInfo);
        }

        // check cust aicpu kernel RunMode
        if ((kernelType == aicpu::KernelType::KERNEL_TYPE_AICPU_CUSTOM) &&
            (AicpuUtil::CheckCustAicpuThreadMode() != AICPU_SCHEDULE_OK)) {
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }

        // execute kernel
        aicpusd_info("Begin to process aicpu engine process, kernelType[%u].", tsKernelInfo.kernelType);
        std::shared_ptr<aicpu::ProfMessage> profMsg = nullptr;
        const bool profFlag = aicpu::IsProfOpen();
        aicpu::aicpuProfContext_t aicpuProfCtx;
        if (profFlag) {
            try {
                profMsg = std::make_shared<aicpu::ProfMessage>("AICPU");
            } catch (...) {
                aicpusd_err("make shared for ProfMessage failed.");
                return AICPU_SCHEDULE_ERROR_INNER_ERROR;
            }
            (void)aicpu::SetProfHandle(profMsg);

            const uint64_t tickBeforeRun = aicpu::GetSystemTick();
            aicpuProfCtx = {
                .tickBeforeRun = tickBeforeRun,
                .drvSubmitTick = drvSubmitTick,
                .drvSchedTick = drvSchedTick,
                .kernelType = tsKernelInfo.kernelType
            };
            (void)aicpu::aicpuSetProfContext(aicpuProfCtx);
        }

        AicpuMonitor::GetInstance().SetTaskStartTime(threadIndex);
        const int32_t retAicpu = aeCallInterface(&tsKernelInfo);
        AicpuMonitor::GetInstance().SetTaskEndTime(threadIndex);
        if (profFlag) {
            const ProfIdentity profIdentity = {
                .taskId = taskId,
                .streamId = streamId,
                .threadIndex = threadIndex,
                .deviceId = AicpuDrvManager::GetInstance().GetDeviceId()
            };
            (void)AicpuUtil::SetProfData(profMsg, aicpuProfCtx, profIdentity);
        }

        PostProcessTsKernelTask(retAicpu, streamId, taskId);
        return retAicpu;
    }

    void AicpuEventProcess::PostProcessTsKernelTask(const int32_t errorCode, const uint64_t streamId,
                                                    const uint64_t taskId) const
    {
        if (errorCode == AE_STATUS_SUCCESS) {
            (void)aicpu::SetOpname("null");
            aicpusd_info("Aicpu engine process success, result[%d].", errorCode);
            return;
        }

        // This status is not error, so never print error log
        if ((errorCode == AE_STATUS_END_OF_SEQUENCE) || (errorCode == AE_STATUS_TASK_WAIT) ||
            (errorCode == AE_STATUS_TASK_ABORT)) {
            (void)aicpu::SetOpname("null");
            aicpusd_info("Aicpu engine process success in special status, result[%d].", errorCode);
            return;
        }

        std::string opname = "null";
        (void)aicpu::GetOpname(aicpu::GetAicpuThreadIndex(), opname);
        aicpusd_err("Aicpu engine process failed, result[%d], opName[%s], streamId[%llu], taskId[%llu].",
                    errorCode, opname.c_str(), streamId, taskId);
        (void)aicpu::SetOpname("null");

        return;
    }

    int32_t AicpuEventProcess::ExecuteLogicKernel(aicpu::HwtsTsKernel &tsKernelInfo) const
    {
        if (static_cast<uintptr_t>(tsKernelInfo.kernelBase.cceKernel.kernelName) == 0UL) {
            aicpusd_err("ExecuteLogicKernel failed as the name of kernel is null.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        const size_t cpySize = strnlen(
            static_cast<const char_t *>(ValueToPtr(tsKernelInfo.kernelBase.cceKernel.kernelName)),
            MAX_KERNEL_NAME_LEN);
        char_t kernelName[MAX_KERNEL_NAME_LEN + 1UL] = {};
        const errno_t memRet = memcpy_s(&kernelName[0], MAX_KERNEL_NAME_LEN + 1UL,
            static_cast<const char_t *>(ValueToPtr(tsKernelInfo.kernelBase.cceKernel.kernelName)), cpySize);
        if (memRet != EOK) {
            aicpusd_err("memcpy_s kernel name failed ret[%d].", memRet);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        aicpusd_info("Task kernel name[%s].", &kernelName[0]);

        // check logic kernel and run it;
        return HwTsKernelRegister::Instance().RunTsKernelTaskProcess(tsKernelInfo, kernelName);
    }

    AicpuExtendSoPlatformFuncPtr AicpuEventProcess::GetAicpuExtendSoPlatformFuncPtr()
    {
        const std::lock_guard<std::mutex> lk(mutexForPlatformPtr_);
        if (platformFuncPtr_ != nullptr) {
            return platformFuncPtr_;
        }

        platformFuncPtr_ = reinterpret_cast<AicpuExtendSoPlatformFuncPtr>(dlsym(RTLD_DEFAULT,
            EXTEND_SO_PLATFORM_FUNC_NAME.c_str()));
        if (platformFuncPtr_ == nullptr) {
            aicpusd_err("failed to find func:%s, err:%s", EXTEND_SO_PLATFORM_FUNC_NAME.c_str(), dlerror());
        }
        return platformFuncPtr_;
    }

    int32_t AicpuEventProcess::SendLoadPlatformFromBufMsgRsp(const int32_t resultCode,
                                                             AicpuSqeAdapter &aicpuSqeAdapter) const
    {
        // send response information to ts.
        aicpusd_info("Begin send response information using tsDevSendMsgAsync function load ret[%d]", resultCode);
        const int32_t ret  = aicpuSqeAdapter.AicpuInfoLoadResponseToTs(resultCode);
        aicpusd_info("Finished to send platform load info report info, ret[%d].", ret);
        return ret;
    }

    int32_t AicpuEventProcess::ProcessLoadPlatformFromBuf(AicpuSqeAdapter &aicpuSqeAdapter)
    {
        aicpusd_info("Begin to process LoadPlatformFromBuf event.");
        AicpuSqeAdapter::AicpuInfoLoad info{};
        aicpuSqeAdapter.GetAicpuInfoLoad(info);
        AicpuExtendSoPlatformFuncPtr funcPtr = GetAicpuExtendSoPlatformFuncPtr();
        if (funcPtr == nullptr) {
            aicpusd_err("failed to find func:%s", EXTEND_SO_PLATFORM_FUNC_NAME.c_str());
            SendLoadPlatformFromBufMsgRsp(AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID, aicpuSqeAdapter);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        aicpusd_info("platform buf:0x%x, len:%u", info.aicpuInfoPtr, info.length);
        const int32_t ret = funcPtr(info.aicpuInfoPtr, info.length);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("func:%s procss failed,ret:%u", EXTEND_SO_PLATFORM_FUNC_NAME.c_str(), ret);
        }
        return SendLoadPlatformFromBufMsgRsp(ret, aicpuSqeAdapter);
    }
}
