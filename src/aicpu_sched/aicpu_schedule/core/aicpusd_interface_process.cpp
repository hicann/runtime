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
#include "ts_api.h"
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
#include "aicpusd_msg_send.h"
#include "aicpusd_worker.h"
#include "aicpusd_cust_so_manager.h"
#include "aicpusd_sub_module_interface.h"
#include "aicpusd_hal_interface_ref.h"
#include "aicpusd_cust_dump_process.h"
#include "aicpusd_mc2_maintenance_thread.h"
#include "aicpusd_period_statistic.h"
#include "aicpusd_model_statistic.h"
#include "aicpusd_feature_ctrl.h"
#include "hwts_kernel_register.h"
#include "operator_kernel_register.h"

namespace {
    const std::map<EVENT_ID, SCHEDULE_PRIORITY> EVENT_PRIORITY = {
        {EVENT_ID::EVENT_RANDOM_KERNEL, SCHEDULE_PRIORITY::PRIORITY_LEVEL0},
        {EVENT_ID::EVENT_SPLIT_KERNEL, SCHEDULE_PRIORITY::PRIORITY_LEVEL0},
        {EVENT_ID::EVENT_DVPP_MSG, SCHEDULE_PRIORITY::PRIORITY_LEVEL0},
        {EVENT_ID::EVENT_DVPP_MPI_MSG, SCHEDULE_PRIORITY::PRIORITY_LEVEL0},
        {EVENT_ID::EVENT_FR_MSG, SCHEDULE_PRIORITY::PRIORITY_LEVEL0},
        {EVENT_ID::EVENT_TS_HWTS_KERNEL, SCHEDULE_PRIORITY::PRIORITY_LEVEL0},
        {EVENT_ID::EVENT_AICPU_MSG, SCHEDULE_PRIORITY::PRIORITY_LEVEL0},
        {EVENT_ID::EVENT_TS_CTRL_MSG, SCHEDULE_PRIORITY::PRIORITY_LEVEL0},
        {EVENT_ID::EVENT_FFTS_PLUS_MSG, SCHEDULE_PRIORITY::PRIORITY_LEVEL0},
        {EVENT_ID::EVENT_QUEUE_EMPTY_TO_NOT_EMPTY, SCHEDULE_PRIORITY::PRIORITY_LEVEL0},
        {EVENT_ID::EVENT_QUEUE_FULL_TO_NOT_FULL, SCHEDULE_PRIORITY::PRIORITY_LEVEL0},
        {EVENT_ID::EVENT_TDT_ENQUEUE, SCHEDULE_PRIORITY::PRIORITY_LEVEL2},
        {EVENT_ID::EVENT_ACPU_MSG_TYPE1, SCHEDULE_PRIORITY::PRIORITY_LEVEL1}
    };

    // first array index
    constexpr size_t FIRST_INDEX = 0LU;

    // max number of eatch device can split
    constexpr const uint32_t DEVICE_MAX_SPLIT_NUM = 16U;

    const std::string TSKERNEL_PREFIX = "tsKernel:";
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
          runMode_(aicpu::AicpuRunMode::THREAD_MODE),
          aicpuCustSdPid_(-1) {}

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

    int32_t AicpuScheduleInterface::LoadModelWithQueue(const void * const ptr) const
    {
        std::vector<QueInfo> queInfos;
        std::vector<AicpuTaskInfo> aicpuTaskInfos;
        std::vector<StreamInfo> streamInfos;
        AicpuModelInfo curAicpuModelInfo;

        if (ptr == nullptr) {
            aicpusd_err("the parameter is not valid in load model.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        const auto ret = AicpuModelManager::GetInstance().TransModelInfo(ptr, curAicpuModelInfo,
            aicpuTaskInfos, streamInfos, queInfos, nullptr);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }

        if (queInfos.empty()) {
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        return LoadProcess(&curAicpuModelInfo);
    }

    int32_t AicpuScheduleInterface::LoadModelWithEvent(const void * const ptr) const
    {
        std::vector<QueInfo> queInfos;
        std::vector<AicpuTaskInfo> aicpuTaskInfos;
        std::vector<StreamInfo> streamInfos;
        std::vector<ModelCfgInfo> modelCfgs;
        AicpuModelInfo curAicpuModelInfo;

        if (ptr == nullptr) {
            aicpusd_err("the parameter is not valid in load model.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        const auto ret = AicpuModelManager::GetInstance().TransModelInfo(ptr, curAicpuModelInfo,
            aicpuTaskInfos, streamInfos, queInfos, &modelCfgs);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }

        if (modelCfgs.empty()) {
            aicpusd_err("Invalid modelCfg");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        return LoadProcess(&curAicpuModelInfo, &modelCfgs[0U]);
    }

    /**
     * @ingroup AicpuScheduleInterface
     * @brief it use to load the task and stream info.
     * @param [in] ptr : the address of the task and stream info
     * @return AICPU_SCHEDULE_OK: success
     */
    int32_t AicpuScheduleInterface::LoadProcess(const void * const ptr, const ModelCfgInfo * const cfg) const
    {
        if (ptr == nullptr) {
            aicpusd_err("the parameter is not valid in load model.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        const AicpuModelInfo * const infoTask = PtrToPtr<const void, const AicpuModelInfo>(ptr);
        const uint32_t modelId = infoTask->moduleID;
        aicpusd_info("Begin to load model[%u]", modelId);
        const int32_t ret = AicpuModelManager::GetInstance().ModelLoad(infoTask, cfg);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Failed to load model[%u].", modelId);
            return ret;
        }

        aicpusd_info("Model[%u] queue size[%u]", modelId, infoTask->queueSize);
        if (static_cast<int32_t>(infoTask->queueSize) > 0) {
            AicpuEventProcess::GetInstance().InitQueueFlag();
            return ExecuteModelAsync(modelId);
        }

        if (cfg != nullptr) {
            return ExecuteModelAsync(modelId);
        }
        return AICPU_SCHEDULE_OK;
    }

    /**
     * @ingroup AicpuScheduleInterface
     * @brief it use to execute model.
     * @param [in] modelId : modelId
     * @return AICPU_SCHEDULE_OK: success
     */
    int32_t AicpuScheduleInterface::ExecuteModelAsync(const uint32_t modelId) const
    {
        aicpusd_info("Begin to execute model[%u] async", modelId);
        AICPUSubEventInfo subEventInfo = {};
        subEventInfo.modelId = modelId;
        const bool syncSendFlag = GetCpuMode();
        return AicpuMsgSend::SendAICPUSubEvent(PtrToPtr<AICPUSubEventInfo, const char_t>(&subEventInfo),
            static_cast<uint32_t>(sizeof(AICPUSubEventInfo)),
            AICPU_SUB_EVENT_EXECUTE_MODEL,
            CP_DEFAULT_GROUP_ID,
            syncSendFlag);
    }

    /**
     * @ingroup AicpuScheduleInterface
     * @brief it use to get the errorcode for external module by the model status.
     * @param [in] modelId : modelId
     * @return AICPU_SCHEDULE_SUCCESS: success, other: error code
     */
    ErrorCode AicpuScheduleInterface::GetErrorCode(const uint32_t modelId) const
    {
        const AicpuModelStatus status = AicpuModelManager::GetInstance().GetModelStatus(modelId);
        if (status == AicpuModelStatus::MODEL_STATUS_ERROR) {
            return AICPU_SCHEDULE_FAIL;
        } else if (status == AicpuModelStatus::MODEL_STATUS_ABORT) {
            return AICPU_SCHEDULE_ABORT;
        } else {
            return AICPU_SCHEDULE_SUCCESS;
        }
    }

    /**
     * @ingroup AicpuScheduleInterface
     * @brief it use to send message to tscpu.
     * @param [in] deviceId
     */
    void AicpuScheduleInterface::SendMsgToTsCpu(const uint32_t deviceId) const
    {
        // send msg to tscpu
        AicpuSqeAdapter aicpuadapter(FeatureCtrl::GetTsMsgVersion());
        const int32_t ret = aicpuadapter.AicpuNoticeTsPidResponse(deviceId);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_run_warn("AicpuNoticeTsPidResponse ret:%d.", ret);
        }
    }

    int32_t AicpuScheduleInterface::BindHostPid(const std::string &pidSign, const uint32_t vfId) const
    {
        int32_t ret = 0;
        if (runMode_ == aicpu::AicpuRunMode::THREAD_MODE) {
            constexpr int32_t mode = static_cast<int32_t>(AicpuPlat::AICPU_OFFLINE_PLAT);
            ret = AicpuDrvManager::GetInstance().BindHostPid(pidSign, mode,
                                                             vfId, DEVDRV_PROCESS_CP1);
            int32_t getRet = 0;
            getRet = AicpuDrvManager::GetInstance().BindHostPid(pidSign, mode,
                                                                vfId, DEVDRV_PROCESS_CP2);
            aicpusd_warn("BindHostPid DEVDRV_PROCESS_CP2 ret[%d]", getRet);
        } else {
            ret = AicpuDrvManager::GetInstance().CheckBindHostPid();
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
        if (deviceVec.empty()) {
            aicpusd_err("device vector is empty");
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }

        if (IsInitialized(deviceVec[0])) {
            aicpusd_warn("Aicpu schedule is already init.");
            return AICPU_SCHEDULE_OK;
        }
        const std::unique_lock<std::mutex> lockForInit(mutexForInit_);
        UpdateOrInsertStartFlag(deviceVec[0], false);
        noThreadFlag_ = false;

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
        (void)aicpu::SetAicpuRunMode(runMode_); // InitDrvSchedModule will use the runMode.
        DeployContext deployCtx = DeployContext::DEVICE;
        const StatusCode status = GetAicpuDeployContext(deployCtx);
        if (status != AICPU_SCHEDULE_OK) {
            aicpusd_err("Get current deploy ctx failed.");
            return status;
        }
        const bool cpuMode = GetCpuMode();
        if ((deployCtx == DeployContext::DEVICE || deployCtx == DeployContext::HOSTCPU) && (!cpuMode)) {
            const int32_t bindPidRet = BindHostPid(pidSign, vfId);
            if (bindPidRet != AICPU_SCHEDULE_OK) {
                aicpusd_err("check bind pid sign failed, ret[%d].", bindPidRet);
                return bindPidRet;
            }
            aicpusd_info("Bind pid sign success");
        }

        constexpr uint32_t groupId = CP_DEFAULT_GROUP_ID;
        int32_t ret = AicpuDrvManager::GetInstance().InitDrvSchedModule(groupId, EVENT_PRIORITY);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("Failed to init the drv schedule module, ret[%d].", ret);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        ret = AicpuSchedule::AicpuMonitor::GetInstance().InitMonitor(deviceVec[FIRST_INDEX], isOnline);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("aicpu monitor init failed, ret[%d]", ret);
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        (void)AicpuSchedule::AicpuEventProcess::GetInstance(); // Pre init instance
        const auto retCp = ComputeProcess::GetInstance().Start(deviceVec, hostPid, pidSign, profilingMode,
                                                               vfId, runMode_, schedMode);
        if (retCp != AICPU_SCHEDULE_OK) {
            aicpusd_err("Compute process start failed, ret[%d].", retCp);
            ComputeProcess::GetInstance().Stop();
            AicpuSchedule::AicpuMonitor::GetInstance().StopMonitor();
            return AICPU_SCHEDULE_ERROR_INIT_CP_FAILED;
        }
        AicpuSchedule::AicpuSdPeriodStatistic::GetInstance().InitStatistic(deviceVec[FIRST_INDEX], hostPid, runMode_);
        AicpuSchedule::AicpuSdModelStatistic::GetInstance().InitModelStatInfo();
        // send message to tscpu, failure is not handled and does not affect the main process
        SendMsgToTsCpu(deviceVec[FIRST_INDEX]);
        const auto conRet = BuildAndSetContext(deviceVec[FIRST_INDEX], hostPid, vfId);
        if (conRet != AICPU_SCHEDULE_OK) {
            return conRet;
        }

        if (deployCtx != DeployContext::HOSTCPU) {
            // init AicpuCustSoManager
            (void)AicpuSchedule::AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(runMode_, schedMode);
        }
        aicpusd_info("Success to start compute process, deviceId[%u], hostPid[%d], runMode[%u]",
                     deviceVec[FIRST_INDEX], hostPid, runMode_);
        UpdateOrInsertStartFlag(deviceVec[0], true);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuScheduleInterface::BuildAndSetContext(
        const uint32_t deviceId, const pid_t hostPid, const uint32_t vfId)
    {
        aicpu::aicpuContext_t context = {
            .deviceId = deviceId,
            .tsId = 0U,
            .hostPid = hostPid,
            .vfId = vfId
        };
        uint32_t uniqueVfId = context.vfId;
        (void)aicpu::aicpuSetContext(&context);
        aicpu::SetUniqueVfId(uniqueVfId);
        if (FeatureCtrl::IsAosCore()) {
            return AICPU_SCHEDULE_OK;
        }
        if (FeatureCtrl::IsVfModeCheckedByDeviceId(deviceId)) {
            uniqueVfId = deviceId;
        } else {
            if ((context.deviceId != 0U) && (context.vfId != 0U)) {
                uint32_t maxNumSpDev = 0U;
                const auto vfMaxRet = halGetDeviceVfMax(context.deviceId, &maxNumSpDev);
                if ((vfMaxRet != DRV_ERROR_NONE) || (maxNumSpDev > DEVICE_MAX_SPLIT_NUM)) {
                    aicpusd_err("Failed to get device cat vf number, result[%d], max num[%u].", vfMaxRet, maxNumSpDev);
                    ComputeProcess::GetInstance().Stop();
                    AicpuSchedule::AicpuMonitor::GetInstance().StopMonitor();
                    return AICPU_SCHEDULE_ERROR_INIT_CP_FAILED;
                } else {
                    uniqueVfId = (maxNumSpDev * context.deviceId) + context.vfId;
                }
            }
        }
        aicpu::SetUniqueVfId(uniqueVfId);
        return AICPU_SCHEDULE_OK;
    }

    /**
     * @ingroup AicpuScheduleInterface
     * @param [in] modelId
     * @brief it use to destroy one model.
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    int32_t AicpuScheduleInterface::Destroy(const uint32_t modelId) const
    {
        const auto model = AicpuModelManager::GetInstance().GetModel(modelId);
        if (model == nullptr) {
            aicpusd_err("Model[%u] is not found.", modelId);
            return AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND;
        }

        const uint32_t tsId = model->GetModelTsId();
        if (tsId < static_cast<uint32_t>(TSIDFlag::AICPU_SCHEDULE_TS_ID)) {
            TsAicpuSqe tsAicpuSqe = {};
            tsAicpuSqe.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
            tsAicpuSqe.cmd_type = AICPU_MODEL_OPERATE;
            tsAicpuSqe.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
            tsAicpuSqe.tid = static_cast<uint8_t>(0U); // no need tid
            tsAicpuSqe.ts_id = static_cast<uint8_t>(tsId);
            tsAicpuSqe.u.aicpu_model_operate.cmd_type = TS_AICPU_MODEL_DESTROY;
            tsAicpuSqe.u.aicpu_model_operate.model_id = static_cast<uint16_t>(modelId);
            tsAicpuSqe.u.aicpu_model_operate.arg_ptr = 0UL;
            tsAicpuSqe.u.aicpu_model_operate.task_id = static_cast<uint16_t>(0U);

            const int32_t drvRet = tsDevSendMsgAsync(AicpuDrvManager::GetInstance().GetDeviceId(), tsId,
                                                     PtrToPtr<TsAicpuSqe, char_t>(&tsAicpuSqe),
                                                     static_cast<uint32_t>(sizeof(TsAicpuSqe)), modelId);
            if (drvRet != DRV_ERROR_NONE) {
                aicpusd_err("Failed to send destroy model[%u] to ts[%u] , result[%d].", modelId, tsId, drvRet);
            }
            aicpusd_info("Success to destroy tsDevSendMsgAsync.");
        }

        const auto ret =  model->ModelDestroy();
        const auto initType = model->GetHcclInitType();
        if (initType != HcclInitType::INIT_TYPE_NUM) {
            AicpuModelManager::GetInstance().GuardHccl(initType);
        }
        AicpuModelManager::GetInstance().ModelConfigClear(modelId);
        return ret;
    }

    /**
     * @ingroup AicpuScheduleInterface
     * @param [in] modelId
     * @brief it use to stop one model.
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    int32_t AicpuScheduleInterface::Stop(const uint32_t modelId) const
    {
        const auto model = AicpuModelManager::GetInstance().GetModel(modelId);
        if (model == nullptr) {
            aicpusd_err("Model[%u] is not found.", modelId);
            return AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND;
        }

        const uint32_t tsId = model->GetModelTsId();
        if (tsId < static_cast<uint32_t>(TSIDFlag::AICPU_SCHEDULE_TS_ID)) {
            TsAicpuSqe tsAicpuSqe = {};
            tsAicpuSqe.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
            tsAicpuSqe.cmd_type = AICPU_MODEL_OPERATE;
            tsAicpuSqe.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
            tsAicpuSqe.tid = static_cast<uint8_t>(0U); // no need tid
            tsAicpuSqe.ts_id = static_cast<uint8_t>(tsId);
            tsAicpuSqe.u.aicpu_model_operate.cmd_type = TS_AICPU_MODEL_DESTROY;
            tsAicpuSqe.u.aicpu_model_operate.model_id = static_cast<uint16_t>(modelId);
            tsAicpuSqe.u.aicpu_model_operate.arg_ptr = 0UL;
            tsAicpuSqe.u.aicpu_model_operate.task_id = static_cast<uint16_t>(0U);

            const int32_t drvRet = tsDevSendMsgAsync(AicpuDrvManager::GetInstance().GetDeviceId(), tsId,
                                                     PtrToPtr<TsAicpuSqe, char_t>(&tsAicpuSqe),
                                                     static_cast<uint32_t>(sizeof(TsAicpuSqe)), modelId);
            if (drvRet != DRV_ERROR_NONE) {
                aicpusd_err("Failed to send destroy model[%u] to ts[%u] , result[%d].", modelId, tsId, drvRet);
            }
            aicpusd_info("Success to destroy tsDevSendMsgAsync.");
        }

        uint32_t retryCost = 0U;
        const uint32_t retryIntervalUs = 10000U;
        const uint32_t retryCostLimitUs = 1000000U;
        auto stopRet = model->ModelStop();
        while ((stopRet == AICPU_SCHEDULE_ERROR_IN_WORKING) && (retryCost < retryCostLimitUs)) {
            usleep(retryIntervalUs);
            retryCost += retryIntervalUs;
            stopRet = model->ModelStop();
        }
        aicpusd_run_info("Stop model[%u], ret is %d, retryCost is %u.", modelId, stopRet, retryCost);
        return stopRet;
    }

    int32_t AicpuScheduleInterface::Restart(const uint32_t modelId) const
    {
        const auto model = AicpuModelManager::GetInstance().GetModel(modelId);
        if (model == nullptr) {
            aicpusd_err("Model[%u] is not found.", modelId);
            return AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND;
        }

        uint32_t retryCost = 0U;
        const uint32_t retryIntervalUs = 10000U;
        const uint32_t retryCostLimitUs = 1000000U;
        auto restartRet = model->ModelRestart();
        while ((restartRet == AICPU_SCHEDULE_ERROR_IN_WORKING) && (retryCost < retryCostLimitUs)) {
            usleep(retryIntervalUs);
            retryCost += retryIntervalUs;
            restartRet = model->ModelRestart();
        }
        aicpusd_run_info("Restart model[%u], ret is %d, retryCost is %u.", modelId, restartRet, retryCost);
        return restartRet;
    }

    int32_t AicpuScheduleInterface::CheckKernelSupported(const std::string &kernelName) const
    {
        const auto pos = kernelName.find(TSKERNEL_PREFIX);
        if (pos != kernelName.npos) {
            const std::string tsKernelName = kernelName.substr(TSKERNEL_PREFIX.length());
            return HwTsKernelRegister::Instance().CheckTsKernelSupported(tsKernelName);
        }
        return OperatorKernelRegister::Instance().CheckOperatorKernelSupported(kernelName);
    }

    int32_t AicpuScheduleInterface::ClearInput(const uint32_t modelId) const
    {
        const auto model = AicpuModelManager::GetInstance().GetModel(modelId);
        if (model == nullptr) {
            aicpusd_err("Model[%u] is not found.", modelId);
            return AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND;
        }

        return model->ModelClearInput();
    }

    /**
     * @ingroup AicpuScheduleInterface
     * @brief it use to destroy all model.
     */
    int32_t AicpuScheduleInterface::Destroy() const
    {
        return AicpuModelManager::GetInstance().Exit();
    }

    /**
     * @ingroup AicpuScheduleInterface
     * @brief it use to stop AICPU scheduler.
     * @param [in] deviceId
     * @param [in] hostPid :the process id of host
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    int32_t AicpuScheduleInterface::StopAICPUScheduler(const std::vector<uint32_t> &deviceVec, const pid_t hostPid)
    {
        return StopAICPUSchedulerWithFlag(deviceVec, hostPid, false);
    }

    int32_t AicpuScheduleInterface::StopAICPUSchedulerWithFlag(const std::vector<uint32_t> &deviceVec,
        const pid_t hostPid, const bool waitThreadStop)
    {
        if (deviceVec.empty()) {
            aicpusd_err("deviceVec is empty.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        aicpusd_run_info("Begin to stop aicpu scheduler, hostPid[%d]", hostPid);
        const std::unique_lock<std::mutex> lockForInit(mutexForInit_);
        if (!noThreadFlag_) {
            ComputeProcess::GetInstance().Stop();
        }

        (void)Destroy();
        noThreadFlag_ = true;
        UpdateOrInsertStartFlag(deviceVec[0], false);
        AicpuSchedule::AicpuMonitor::GetInstance().StopMonitor();
        AicpuSchedule::AicpuEventManager::GetInstance().SetRunningFlag(false);
        AicpuSchedule::AicpuSdPeriodStatistic::GetInstance().StopStatistic();
        AicpuSchedule::AicpuSdPeriodStatistic::GetInstance().PrintOutStatisticInfo(runMode_);
        AicpuSchedule::AicpuSdModelStatistic::GetInstance().PrintOutModelStatInfo();
        AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).UnitMc2MantenanceProcess();
        AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(1).UnitMc2MantenanceProcess();
        AicpuSchedule::AicpuSdCustDumpProcess::GetInstance().UnitCustDataDumpProcess();
        FeatureCtrl::ClearTsMsgVersionInfo();
        constexpr uint32_t sleepUsecs = 1000U;  // sleep 1ms to avoid SchedWaitEvent error
        (void)usleep(sleepUsecs);
        const int32_t ret = DettachDeviceInDestroy(deviceVec);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("DettachDeviceInDestroy error %d", ret);
            return ret;
        }
        if ((runMode_ == aicpu::AicpuRunMode::PROCESS_PCIE_MODE) ||
            (runMode_ == aicpu::AicpuRunMode::PROCESS_SOCKET_MODE) ||
            waitThreadStop) {
            AicpuSchedule::ThreadPool::Instance().WaitForStop();
        }
        g_aicpuProfiler.Uninit();
        aicpusd_run_info("Success to stop aicpu scheduler, hostPid[%d]", hostPid);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuScheduleInterface::GetCurrentRunMode(const bool isOnline)
    {
        if (!isOnline) {
            runMode_ = aicpu::AicpuRunMode::THREAD_MODE;
            aicpusd_run_info("Current aicpu mode is offline (call by api).");
            return AICPU_SCHEDULE_OK;
        }

        drvHdcCapacity capacity;
        capacity.chanType = HDC_CHAN_TYPE_SOCKET;
        capacity.maxSegment = 0U;
        const hdcError_t hdcRet = drvHdcGetCapacity(&capacity);
        if (hdcRet != DRV_ERROR_NONE) {
            aicpusd_err("Aicpu scheduler get capacity failed, ret[%d].", hdcRet);
            return AICPU_SCHEDULE_ERROR_FROM_DRV;
        }

        // online: with host, offline: without host only device
        if (capacity.chanType == HDC_CHAN_TYPE_SOCKET) {
            runMode_ = aicpu::AicpuRunMode::PROCESS_SOCKET_MODE;
            aicpusd_run_info("Set aicpu online mode false. current mode is socket_mode.");
            return AICPU_SCHEDULE_OK;
        }

        runMode_ = aicpu::AicpuRunMode::PROCESS_PCIE_MODE;
        aicpusd_run_info("Current aicpu mode is online (call from host).");
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuScheduleInterface::DettachDeviceInDestroy(const std::vector<uint32_t> &deviceVec) const
    {
        if (SubModuleInterface::GetInstance().GetStartFlag()) {
            aicpusd_run_info("sub module no need to detach device, main module do it");
            return AICPU_SCHEDULE_OK;
        }

        DeployContext deployCtx = DeployContext::DEVICE;
        (void)GetAicpuDeployContext(deployCtx);
        for (size_t i = 0LU; i < deviceVec.size(); i++) {
            if ((FeatureCtrl::ShouldInitDrvThread()) && (deployCtx == DeployContext::DEVICE) &&
                (&halDrvEventThreadUninit != nullptr)) {
                const auto unInitRet = halDrvEventThreadUninit(deviceVec[i]);
                aicpusd_run_info("Uninit process drv queue msg on ccpu, ret is %d.", static_cast<int32_t>(unInitRet));
                (void) unInitRet;
            }
            const drvError_t ret = halEschedDettachDevice(deviceVec[i]);
            if ((ret != DRV_ERROR_NONE) && (ret != DRV_ERROR_NOT_EXIST)) { // maybe is repeated detach
                aicpusd_err("Failed to detach device[%u], result[%d].", deviceVec[i], ret);
                return ret;
            }
            aicpusd_info("Success to detach aicpu scheduler, device[%d].", deviceVec[i]);
        }
        return AICPU_SCHEDULE_OK;
    }

    bool AicpuScheduleInterface::IsInitialized(const uint32_t deviceId)
    {
        const std::unique_lock<std::mutex> lockForInit(mutexForInit_);
        auto initIter = aicpusdInitFlagMap_.find(deviceId);
        if (initIter != aicpusdInitFlagMap_.end()) {
            return (initIter->second);
        } else {
            return false;
        }
    }

    void AicpuScheduleInterface::UpdateOrInsertStartFlag(const uint32_t deviceId, const bool flag)
    {
        auto initIter = aicpusdInitFlagMap_.find(deviceId);
        if (initIter != aicpusdInitFlagMap_.end()) {
            initIter->second = flag;
        } else {
            aicpusdInitFlagMap_.insert(std::pair<uint32_t, bool>(deviceId, false));
        }
    }

    void AicpuScheduleInterface::SetAicpuCustSdProcId(const int32_t aicpuCustSdPid)
    {
        if (aicpuCustSdPid != -1) {
            aicpuCustSdPid_ = aicpuCustSdPid;
            aicpusd_info("set aicpucustsd pid:%d", aicpuCustSdPid_.load());
        }
    }

    int32_t AicpuScheduleInterface::GetAicpuCustSdProcId() const
    {
        return aicpuCustSdPid_.load();
    }

    int32_t AicpuScheduleInterface::ProcessException(const DataFlowExceptionNotify *const exceptionInfo) const
    {
        aicpusd_info("Begin to process data exception event.");
        if (exceptionInfo == nullptr) {
            aicpusd_err("Invalid exception info.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        const auto modelNum = exceptionInfo->modelIdNum;
        const auto modelIdsAddr = PtrToPtr<void, uint32_t>(ValueToPtr(exceptionInfo->modelIdsAddr));
        if ((modelNum > 0U) && (modelIdsAddr == nullptr)) {
            aicpusd_err("Invalid modelIds.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        for (uint32_t i = 0; i < modelNum; ++i) {
            const auto modelId = modelIdsAddr[static_cast<size_t>(i)];
            const auto model = AicpuModelManager::GetInstance().GetModel(modelId);
            if (model == nullptr) {
                aicpusd_err("Model[%u] is not found.", modelId);
                return AICPU_SCHEDULE_ERROR_MODEL_NOT_FOUND;
            }
            const auto processRet = model->ProcessDataException(exceptionInfo->transId, exceptionInfo->type);
            if (processRet != AICPU_SCHEDULE_OK) {
                return processRet;
            }
            aicpusd_run_info("Success to process kernel data exception for transid[%lu] of model[%u].",
                exceptionInfo->transId, modelId);
        }
        aicpusd_info("Success to process kernel data exception event.");
        return AICPU_SCHEDULE_OK;
    }
}