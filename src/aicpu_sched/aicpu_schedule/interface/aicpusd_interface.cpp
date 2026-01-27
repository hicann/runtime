/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpusd_interface.h"
#include "aicpusd_util.h"
#include "profiling_adp.h"
#include "core/aicpusd_interface_process.h"
#include "core/aicpusd_event_manager.h"
#include "core/aicpusd_threads_process.h"
#include "core/aicpusd_cust_so_manager.h"
#include "core/aicpusd_msg_send.h"
#include "common/aicpusd_util.h"
#include "common/aicpusd_context.h"
#include "aicpusd_monitor.h"
#include "aicpusd_lastword.h"
#include "dump_task.h"
#include "aicpu_engine.h"
#include "type_def.h"
#include "tsd.h"
#include "aicpu_prof.h"

extern "C" {
/**
 * @brief it is used to load the task and stream info.
 * @param [in] ptr : the address of the task and stream info
 * @return AICPU_SCHEDULE_OK: success  other: error code
 */
int32_t AICPUModelLoad(void *ptr)
{
    aicpusd_info("Begin store task information of model.");
    const int32_t ret = AicpuSchedule::AicpuScheduleInterface::GetInstance().LoadProcess(ptr);
    aicpusd_info("Finished store task information of model, ret[%d].", ret);
    if (ret != AicpuSchedule::AICPU_SCHEDULE_OK) {
        return AICPU_SCHEDULE_FAIL;
    }
    return AICPU_SCHEDULE_SUCCESS;
}

/**
 * @brief it is used to destroy the model.
 * @param [in] modelId : The id of model will be destroy.
 * @return AICPU_SCHEDULE_OK: success  other: error code
 */
int32_t AICPUModelDestroy(uint32_t modelId)
{
    aicpusd_info("Begin destroy task information of modelId[%u].", modelId);
    const int32_t ret = AicpuSchedule::AicpuScheduleInterface::GetInstance().Destroy(modelId);
    aicpusd_info("Finished destroy task information of modelId[%u], ret[%d].", modelId, ret);
    if (ret != AicpuSchedule::AICPU_SCHEDULE_OK) {
        return AICPU_SCHEDULE_FAIL;
    }
    return AICPU_SCHEDULE_SUCCESS;
}

/**
 * @brief it is used to execute the model.
 * @param [in] modelId : The id of model will be run.
 * @return AICPU_SCHEDULE_OK: success  other: error code
 */
int32_t AICPUModelExecute(uint32_t modelId)
{
    aicpusd_info("Begin execute task information of modelId[%u].", modelId);
    const int32_t ret = AicpuSchedule::AicpuEventManager::GetInstance().ExecuteProcess(modelId);
    aicpusd_info("Finished execute task information of modelId[%u], ret[%d].", modelId, ret);
    if (ret != AicpuSchedule::AICPU_SCHEDULE_OK) {
        return AICPU_SCHEDULE_FAIL;
    }

    return AicpuSchedule::AicpuScheduleInterface::GetInstance().GetErrorCode(modelId);
}

/**
 * @ingroup AicpuScheduleInterface
 * @brief it use to execute the model from call interface.
 * @param [in] drvEventInfo : event info.
 * @param [out] drvEventAck : event ack.
 * @return 0: success, other: error code
 */
int32_t AICPUExecuteTask(struct event_info *drvEventInfo, struct event_ack *drvEventAck)
{
    if ((drvEventInfo == nullptr) || (drvEventAck == nullptr)) {
        return AICPU_SCHEDULE_FAIL;
    }
    const int32_t ret = AicpuSchedule::AicpuEventManager::GetInstance().ExecuteProcessSyc(drvEventInfo, drvEventAck);
    if (ret != AicpuSchedule::AICPU_SCHEDULE_OK) {
        return AICPU_SCHEDULE_FAIL;
    }
    return AICPU_SCHEDULE_SUCCESS;
}

/**
 * @ingroup AicpuScheduleInterface
 * @brief it use to preload so.
 * @param [in] soName : so name.
 * @return 0: success, other: error code
 */
int32_t AICPUPreOpenKernels(const char *soName)
{
    if (soName == nullptr) {
        aicpusd_err("So name is null. Please check!");
        return AicpuSchedule::AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    // load so
    const uint32_t loadSoNum = 1U;
    const char *soNames[loadSoNum] = {soName};
    const aeStatus_t ret = aeBatchLoadKernelSo(aicpu::KERNEL_TYPE_AICPU, loadSoNum, &soNames[0U]);
    if (ret != AE_STATUS_SUCCESS) {
        aicpusd_err("Failed to preload aicpu so %s. Please check.", soName);
        return ret;
    }
    aicpusd_run_info("Preload so %s success.", soName);
    return AicpuSchedule::AICPU_SCHEDULE_OK;
}

/**
 * @brief it is used to init aicpu scheduler for acl.
 * @param [in] deviceId : The id of self cpu.
 * @param [in] hostPid : The id of host
 * @param [in] profilingMode : it used to open or close profiling.
 * @return AICPU_SCHEDULE_OK: success  other: error code in StatusCode
 */
int32_t InitAICPUScheduler(const uint32_t deviceId, const pid_t hostPid, const ProfilingMode profilingMode)
{
    if (AicpuSchedule::AicpuScheduleInterface::GetInstance().IsInitialized(deviceId)) {
        aicpusd_run_info("Aicpu Schedule is already init");
        return AicpuSchedule::AICPU_SCHEDULE_OK;
    }

    const std::string envNameAicpuAppLogSwitch = "AICPU_APP_LOG_SWITCH";
    if (AicpuSchedule::AicpuUtil::IsEnvValEqual(envNameAicpuAppLogSwitch, "0")) {
        aicpusd_info("%s is setted to 0 to switch off applog", envNameAicpuAppLogSwitch.c_str());
    } else {
        LogAttr logInfo = {};
        logInfo.type = APPLICATION;
        logInfo.pid = 0U;
        logInfo.deviceId = deviceId;
        logInfo.mode = 0U;
        if (DlogSetAttrAicpu(logInfo) != 0) {
            aicpusd_warn("Set log attr failed");
        }
    }

    // Make sure AicpusdLastword are created first，to ensure the last exit
    AicpuSchedule::AicpusdLastword::GetInstance();
    AicpuSchedule::AicpuEventManager::GetInstance().InitEventMgr(false, true, 0U, SCHED_MODE_INTERRUPT);
    const std::vector<uint32_t> deviceVec{deviceId};
    auto deployContext = AicpuSchedule::DeployContext::DEVICE;
    const int32_t status = AicpuSchedule::GetAicpuDeployContext(deployContext);
    if (status != AicpuSchedule::AICPU_SCHEDULE_OK) {
        aicpusd_err("Get current deploy ctx failed.");
        return status;
    }
    process_sign pidSign;
    if (deployContext == AicpuSchedule::DeployContext::DEVICE) {
        const drvError_t ret = drvGetProcessSign(&pidSign);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("Get process sign failed, ret[%d].", ret);
            return AICPU_SCHEDULE_FAIL;
        }
    } else {
        pidSign.sign[0U] = '\0';
    }
    aicpusd_info("Get process sign success");
    return AicpuSchedule::AicpuScheduleInterface::GetInstance().InitAICPUScheduler(deviceVec,
                                                                                   hostPid,
                                                                                   pidSign.sign,
                                                                                   profilingMode,
                                                                                   0U,
                                                                                   false,
                                                                                   SCHED_MODE_INTERRUPT);
}

/**
 * @brief it is used to update profiling mode for acl.
 * @param [in] deviceId : The id of self cpu.
 * @param [in] hostPid : The id of host
 * @param [in] flag : flag[0] == 1 means PROFILING_OPEN, otherwise PROFILING_CLOSE.
 * @return AICPU_SCHEDULE_OK: success  other: error code in StatusCode
 */
int32_t UpdateProfilingMode(uint32_t deviceId, pid_t hostPid, uint32_t flag)
{
    // set or unset mode
    const bool isStart = (flag & (static_cast<uint32_t>(1U) <<
                          static_cast<uint32_t>(aicpu::PROFILING_FEATURE_SWITCH))) > 0U;
    // if set or unset kernel profiling mode
    const bool kernelMode = (flag & (static_cast<uint32_t>(1U) <<
                             static_cast<uint32_t>(aicpu::PROFILING_FEATURE_KERNEL_MODE))) > 0U;
    // if set or unset model profiling mode
    const bool modelMode = (flag & (static_cast<uint32_t>(1U) <<
                            static_cast<uint32_t>(aicpu::PROFILING_FEATURE_MODEL_MODE))) > 0U;
    ProfilingMode mode = PROFILING_CLOSE;
    bool isModelModeOn = false;
    aicpu::LoadProfilingLib();
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
    aicpusd_info("Begin to update aicpu profiling mode, flag[%lu], deviceId[%u], hostPid[%d], isStart[%d], mode[%d],"
                 " isModelModeOn[%d].", flag, deviceId, hostPid, isStart, mode, isModelModeOn);
    return AicpuSchedule::AICPU_SCHEDULE_OK;
}

/**
 * @brief it is used to stop the aicpu scheduler for acl.
 * @param [in] deviceId : The id of self cpu.
 * @param [in] hostPid : host pid
 * @return AICPU_SCHEDULE_OK: success  other: error code in StatusCode
 */
int32_t StopAICPUScheduler(uint32_t deviceId, pid_t hostPid)
{
    (void)AicpuSchedule::AicpuCustSoManager::GetInstance().DeleteCustSoDir();
    AicpuSchedule::OpDumpTaskManager::GetInstance().ClearResource();
    const std::vector<uint32_t> deviceVec = {deviceId};
    (void)AicpuSchedule::AicpuScheduleInterface::GetInstance().StopAICPUSchedulerWithFlag(deviceVec, hostPid, false);
    aicpusd_run_info("Success to stop aicpu scheduler, deviceId[%u], hostPid[%d].", deviceId, hostPid);
    return AicpuSchedule::AICPU_SCHEDULE_OK;
}

/**
 * @brief Check if the scheduling module stops running
 * @return true or false
 */
bool AicpuIsStoped()
{
    return !AicpuSchedule::AicpuEventManager::GetInstance().GetRunningFlag();
}

/**
 * @brief it is used to load op mapping info for data dump.
 * @param [in] infoAddr : The pointer of info.
 * @param [in] len : The length of info
 * @return AICPU_SCHEDULE_OK: success  other: error code in StatusCode
 */
int32_t LoadOpMappingInfo(const void *infoAddr, uint32_t len)
{
    AicpuSchedule::OpDumpTaskManager &opDumpTaskMgr = AicpuSchedule::OpDumpTaskManager::GetInstance();
    AicpuSchedule::AicpuSqeAdapter aicpuSqeAdapter(0UL);
    return opDumpTaskMgr.LoadOpMappingInfo(PtrToPtr<const void, const char_t>(infoAddr), len, aicpuSqeAdapter);
}

/**
 * @brief it is used to set report callback function.
 * @param [in] reportCallback : report callback function.
 * @return AICPU_SCHEDULE_OK: success  other: error code in StatusCode
 */
int32_t AicpuSetMsprofReporterCallback(MsprofReporterCallback reportCallback)
{
    return aicpu::SetMsprofReporterCallback(reportCallback);
}

/**
 * @brief it is used to init aicpu scheduler for helper.
 * @param [in] initParam : init param ptr.
 * @return AICPU_SCHEDULE_SUCCESS: success  other: error code in ErrorCode
 */
int32_t InitCpuScheduler(const CpuSchedInitParam * const initParam)
{
    aicpusd_run_info("InitAICPUScheduler in heterogeneo1us mode.");
    AicpuSchedule::SetCpuMode(true);
    if (initParam == nullptr) {
        aicpusd_err("Init Param is null. Please check!");
        return AICPU_SCHEDULE_FAIL;
    }
    return InitAICPUScheduler(initParam->deviceId,
                              initParam->hostPid,
                              initParam->profilingMode);
}

/**
 * @brief it is used to stop the aicpu scheduler for helper.
 * @param [in] deviceId : The id of self cpu.
 * @param [in] hostPid : host pid
 * @return AICPU_SCHEDULE_OK: success  other: error code in StatusCode
 */
int32_t StopCPUScheduler(const uint32_t deviceId, const pid_t hostPid)
{
    aicpusd_run_info("StopAICPUScheduler in heterogeneous mode.");
    std::vector<uint32_t> deviceVec = {deviceId};
    return AicpuSchedule::AicpuScheduleInterface::GetInstance().StopAICPUSchedulerWithFlag(deviceVec, hostPid, true);
}

/**
 * @brief it is used to load model with queue.
 * @param [in] ptr : the address of the model info
 * @return AICPU_SCHEDULE_OK: success  other: error code
 */
int32_t AicpuLoadModelWithQ(void *ptr)
{
    aicpusd_info("Begin to load model with queue.");
    const int32_t ret = AicpuSchedule::AicpuScheduleInterface::GetInstance().LoadModelWithQueue(ptr);
    aicpusd_info("Finished load model with queue, ret[%d].", ret);
    if (ret != AicpuSchedule::AICPU_SCHEDULE_OK) {
        return AICPU_SCHEDULE_FAIL;
    }
    return AICPU_SCHEDULE_SUCCESS;
}

int32_t AicpuLoadModel(void *ptr)
{
    aicpusd_info("Begin to load model with event.");
    const int32_t ret = AicpuSchedule::AicpuScheduleInterface::GetInstance().LoadModelWithEvent(ptr);
    aicpusd_info("Finished load model with event, ret[%d].", ret);
    if (ret != AicpuSchedule::AICPU_SCHEDULE_OK) {
        return AICPU_SCHEDULE_FAIL;
    }
    return static_cast<int32_t>(AICPU_SCHEDULE_SUCCESS);
}

void AicpuReportNotifyInfo(const aicpu::AsyncNotifyInfo &notifyInfo)
{
    AicpuSchedule::AicpuMsgSend::AicpuReportNotifyInfo(notifyInfo);
}

uint32_t AicpuGetTaskDefaultTimeout()
{
    return AicpuSchedule::AicpuMonitor::GetInstance().GetTaskDefaultTimeout();
}

void RegLastwordCallback(const std::string mark,
    std::function<void ()> callback, std::function<void ()> &cancelReg)
{
    AicpuSchedule::AicpusdLastword::GetInstance().RegLastwordCallback(mark, callback, cancelReg);
}

/**
 * @brief it is used to stop the model.
 * @param [in] ptr : ptr which point to ReDeployConfig.
 * @return AICPU_SCHEDULE_OK: success  other: error code
 */
int32_t AICPUModelStop(const ReDeployConfig * const ptr)
{
    aicpusd_run_info("Begin stop model.");
    if (ptr == nullptr) {
        aicpusd_err("AICPUModelStop ptr is null");
        return AICPU_SCHEDULE_FAIL;
    }
    const uint32_t modelIdNum = ptr->modelIdNum;
    const uint32_t *const modelIds = PtrToPtr<void, uint32_t>(ValueToPtr(ptr->modelIdsAddr));
    if ((modelIdNum != 0U) && (modelIds == nullptr)) {
        aicpusd_err("AICPUModelStop modelIds is null");
        return AICPU_SCHEDULE_FAIL;
    }
    for (uint32_t i = 0U; i < modelIdNum; ++i) {
        const int32_t ret = AicpuSchedule::AicpuScheduleInterface::GetInstance().Stop(modelIds[i]);
        if (ret != AicpuSchedule::AICPU_SCHEDULE_OK) {
            aicpusd_err("Stop model[%u] failed, ret[%d].", modelIds[i], ret);
            return AICPU_SCHEDULE_FAIL;
        }
        aicpusd_info("Stop model[%u] success", modelIds[i]);
    }
    aicpusd_run_info("Finished stop model, %u models had been processed.", modelIdNum);
    return AICPU_SCHEDULE_SUCCESS;
}

/**
 * @brief it is used to restart the model.
 * @param [in] ptr : ptr which point to ReDeployConfig.
 * @return AICPU_SCHEDULE_OK: success  other: error code
 */
int32_t AICPUModelClearInputAndRestart(const ReDeployConfig * const ptr)
{
    aicpusd_run_info("Begin ClearInputAndRestart model.");
    if (ptr == nullptr) {
        aicpusd_err("AICPUModelClearInputAndRestart ptr is null");
        return AICPU_SCHEDULE_FAIL;
    }
    const uint32_t modelIdNum = ptr->modelIdNum;
    const uint32_t *const modelIds = PtrToPtr<void, uint32_t>(ValueToPtr(ptr->modelIdsAddr));
    if ((modelIdNum != 0U) && (modelIds == nullptr)) {
        aicpusd_err("AICPUModelClearInputAndRestart modelIds is null");
        return AICPU_SCHEDULE_FAIL;
    }
    for (uint32_t i = 0U; i < modelIdNum; ++i) {
        int32_t ret = AicpuSchedule::AicpuScheduleInterface::GetInstance().ClearInput(modelIds[i]);
        if (ret != AicpuSchedule::AICPU_SCHEDULE_OK) {
            aicpusd_err("Clear model[%u] failed, ret[%d].", modelIds[i], ret);
            return AICPU_SCHEDULE_FAIL;
        }
        aicpusd_info("Clear model[%u] success", modelIds[i]);

        ret = AicpuSchedule::AicpuScheduleInterface::GetInstance().Restart(modelIds[i]);
        if (ret != AicpuSchedule::AICPU_SCHEDULE_OK) {
            aicpusd_err("Restart model[%u] failed, ret[%d].", modelIds[i], ret);
            return AICPU_SCHEDULE_FAIL;
        }
        aicpusd_info("Restart model[%u] success", modelIds[i]);
    }
    aicpusd_run_info("Finished ClearInputAndRestart, %u models had been processed.", modelIdNum);
    return AICPU_SCHEDULE_SUCCESS;
}

/**
 * @brief it is used to check kernel support.
 * @param [in] cfgPtr : cfgPtr which point to CheckKernelSupportedConfig.
 * @return AICPU_SCHEDULE_OK: supported  other: not supported
 */
int32_t CheckKernelSupported(const CheckKernelSupportedConfig * const cfgPtr)
{
    aicpusd_run_info("begin run CheckKernelSupported model.");
    if (cfgPtr == nullptr) {
        aicpusd_err("CheckKernelSupported cfgPtr is null");
        return AICPU_SCHEDULE_FAIL;
    }
    const char *const kernelName = PtrToPtr<void, char_t>(ValueToPtr(cfgPtr->kernelNameAddr));
    const uint32_t kernelNameLen = cfgPtr->kernelNameLen;
    uint32_t *resultAddr = PtrToPtr<void, uint32_t>(ValueToPtr(cfgPtr->checkResultAddr));
    if ((kernelName == nullptr) || (kernelNameLen == 0) || (resultAddr == nullptr)) {
        aicpusd_err("CheckKernelSupportedConfig params error");
        return AICPU_SCHEDULE_FAIL;
    }
    std::string operatorKernelName(kernelName, kernelNameLen);
    aicpusd_run_info("Task kernel name[%s].", operatorKernelName.c_str());
    const int32_t retCode = AicpuSchedule::AicpuScheduleInterface::GetInstance().CheckKernelSupported(operatorKernelName);
    *resultAddr = static_cast<uint32_t>(retCode);
    aicpusd_run_info("finished run CheckKernelSupported model retCode[%d].", retCode);
    return AICPU_SCHEDULE_SUCCESS;
}

int32_t AICPUModelProcessDataException(const DataFlowExceptionNotify *const exceptionInfo)
{
    return  AicpuSchedule::AicpuScheduleInterface::GetInstance().ProcessException(exceptionInfo);
}
}
