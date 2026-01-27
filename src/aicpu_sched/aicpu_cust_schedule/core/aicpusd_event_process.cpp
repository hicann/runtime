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
#ifndef _AOSCORE_
#endif
#include "ascend_hal.h"
#include "aicpusd_monitor.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_op_executor.h"
#include "aicpu_context.h"
#include "aicpusd_common.h"
#include "profiling_adp.h"
#include "aicpusd_hal_interface_ref.h"
#include "common/aicpusd_util.h"
#include "dump_task.h"
#include "ts_api.h"
#include "aicpusd_interface_process.h"
#include "tsd.h"
#include "aicpu_prof.h"

namespace AicpuSchedule {
    constexpr uint32_t CCPU_DEFAULT_GROUP_ID = 30U;
    constexpr uint16_t VALID_MAGIC_NUM = 0x5A5A;
    static constexpr uint8_t VERSION_0 = 0;
    static constexpr uint8_t VERSION_1 = 1;
    std::set<uint8_t> allVersion = {VERSION_0, VERSION_1};
    /**
     * @ingroup AicpuEventProcess
     * @brief it is used to construct a object of AicpuEventProcess.
     */
    AicpuEventProcess::AicpuEventProcess()
    {
        eventTaskProcess_[AICPU_SUB_EVENT_BIND_SD_PID] = &AicpuEventProcess::AICPUEventBindSdPid;
        eventTaskProcess_[AICPU_SUB_EVENT_OPEN_CUSTOM_SO] = &AicpuEventProcess::AICPUEventOpenCustomSo;
        eventTaskProcess_[AICPU_SUB_EVENT_CUST_UPDATE_PROFILING_MODE] =
            &AicpuEventProcess::AICPUEventCustUpdateProfilingMode;
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

    /**
     * @ingroup AicpuEventProcess
     * @brief it use to process the AICPU event.
     * @param [in] eventInfo : the event information from ts.
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    int32_t AicpuEventProcess::ProcessAICPUEvent(const event_info &eventInfo)
    {
        aicpusd_info("Begin to process the aicpu event, eventId[%d].", eventInfo.comm.subevent_id);

        int32_t ret = AICPU_SCHEDULE_OK;
        // find process function of the subevent id.
        const AICPUCustSubEvent custEventId = static_cast<AICPUCustSubEvent>(eventInfo.comm.subevent_id);
        const auto it = eventTaskProcess_.find(custEventId);
        if (it != eventTaskProcess_.end()) {
            const EventProcess pFunction = it->second;
            ret = (this->*pFunction)(eventInfo.priv);
        } else {
            aicpusd_err("The subevent id is invalid, id[%u].", eventInfo.comm.subevent_id);
            return AICPU_SCHEDULE_ERROR_UNKNOW_AICPU_EVENT;
        }
        // Failed to execute the task , it need to handle error.
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Failed to process aicpu event, eventId[%d].", custEventId);
            return ret;
        }
        aicpusd_info("Success to process aicpu event, eventId[%d].", custEventId);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuEventProcess::ExecuteTsKernelTask(aicpu::HwtsTsKernel &tsKernelInfo, const uint32_t threadIndex,
                                                   const uint64_t drvSubmitTick, const uint64_t drvSchedTick,
                                                   const uint64_t streamId, const uint64_t taskId)
    {
        std::shared_ptr<aicpu::ProfMessage> profMsg = nullptr;
        if (aicpu::IsProfOpen()) {
            aicpusd_info("Profiling is open, start malloc.");
            try {
                profMsg = std::make_shared<aicpu::ProfMessage>("AICPU");
            } catch (std::exception &threadException) {
                aicpusd_err("make shared for ProfMessage failed. Exception[%s]", threadException.what());
                return AICPU_SCHEDULE_ERROR_INNER_ERROR;
            }
            (void)aicpu::SetProfHandle(profMsg);
        }
        const uint64_t tickBeforeRun = aicpu::GetSystemTick();
        const aicpu::aicpuProfContext_t aicpuProfCtx = {
            .tickBeforeRun = tickBeforeRun,
            .drvSubmitTick = drvSubmitTick,
            .drvSchedTick = drvSchedTick,
            .kernelType = tsKernelInfo.kernelType
        };
        (void)aicpu::aicpuSetProfContext(aicpuProfCtx);
        AicpuMonitor::GetInstance().SetTaskStartTime(static_cast<uint64_t>(threadIndex));
        const auto retAicpu = CustomOpExecutor::GetInstance().ExecuteKernel(tsKernelInfo);
        AicpuMonitor::GetInstance().SetTaskEndTime(static_cast<uint64_t>(threadIndex));
        AicpuUtil::SetProfData(profMsg, aicpuProfCtx, threadIndex, streamId, taskId);
        if (retAicpu != AICPU_SCHEDULE_OK) {
            std::string opName;
            (void)aicpu::GetOpname(threadIndex, opName);
            aicpusd_err("Execute aicpu custom kernel failed, result[%d], opName[%s], streamId[%llu], taskId[%llu].",
                retAicpu, opName.c_str(), streamId, taskId);
            AicpuMonitor::GetInstance().SendAbnormalMsgToMain();
        }

        (void)aicpu::SetOpname("null");
        return retAicpu;
    }

    int32_t AicpuEventProcess::AICPUEventBindSdPid(const event_info_priv &privEventInfo) const
    {
        if (privEventInfo.msg_len != sizeof(AICPUBindSdPidEventMsg)) {
            aicpusd_err("The event msg len[%u] is not correct[%zu].",
                        privEventInfo.msg_len, sizeof(AICPUBindSdPidEventMsg));
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        const AICPUBindSdPidEventMsg * const info =
            PtrToPtr<const char_t, const AICPUBindSdPidEventMsg>(privEventInfo.msg);
        const pid_t hostPid = AicpuDrvManager::GetInstance().GetHostPid();
        const uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
        const uint32_t vfId = AicpuDrvManager::GetInstance().GetVfId();
        if (&halMemBindSibling == nullptr) {
            aicpusd_err("Interface halMemBindSibling is not supported in current device");
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        drvError_t drvRet = DRV_ERROR_NONE;
        if (AicpuSchedule::AicpuDrvManager::GetInstance().GetSafeVerifyFlag()) {
            drvRet = halMemBindSibling(hostPid, info->pid, vfId, deviceId, SVM_MEM_BIND_SVM_GRP);
        } else {
            //new
            drvRet = halMemBindSibling(hostPid, info->pid, vfId, deviceId, SVM_MEM_BIND_SVM_GRP | SVM_MEM_BIND_SP_GRP_NO_ALLOC);
        }
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Failed to halMemBindSibling, hostpid=%d, aicpuSdPid=%d, deviceId=%u, ret=%d.\n",
                        hostPid, info->pid, deviceId, drvRet);
            return drvRet;
        }
        aicpusd_info("Bind Sibling pid success, hostpid=%d, aicpuSdPid=%d, deviceId=%u.",
                     hostPid, info->pid, deviceId);
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuEventProcess::AICPUEventOpenCustomSo(const event_info_priv &privEventInfo) const
    {
        const int32_t ret = CustomOpExecutor::GetInstance().OpenKernelSo(privEventInfo);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Open custom kernel so failed.");
            return ret;
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuEventProcess::AICPUEventCustUpdateProfilingMode(const event_info_priv &privEventInfo) const
    {
        const AICPUSubEventInfo * const info = PtrToPtr<const char_t, const AICPUSubEventInfo>(privEventInfo.msg);
        const uint32_t modelInfoFlag = (*info).para.modeInfo.flag;
        aicpusd_info("Get profiling flag success, flag[%u]", modelInfoFlag);

        ProfilingMode profilingMode = PROFILING_CLOSE;
        bool kernelFlag = false;
        AicpuUtil::GetProfilingInfo(modelInfoFlag, profilingMode, kernelFlag);
        aicpusd_info("Update aicpu profiling mode success, profilingMode[%u], kernelFlag[%d], ",
                     profilingMode, kernelFlag);
        aicpu::LoadProfilingLib();
        aicpu::SetProfilingFlagForKFC(modelInfoFlag);
        if (kernelFlag) {
            aicpu::UpdateMode(profilingMode == PROFILING_OPEN);
        }
        if (SendUpdateProfilingRspToTsd(AicpuDrvManager::GetInstance().GetDeviceId(),
                                        static_cast<uint32_t>(TsdWaitType::TSD_CUSTOM_COMPUTE),
                                        static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid()),
                                        AicpuDrvManager::GetInstance().GetVfId()) != AICPU_SCHEDULE_OK) {
            aicpusd_err("send profilling response to tsd failed");
            return AICPU_SCHEDULE_ERROR_TASK_EXECUTE_FAILED;
        }
        return AICPU_SCHEDULE_OK;
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
            aicpusd_err("Magic num[%u] is not valid.", info.magic_num);
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
        if (rspRet != AICPU_SCHEDULE_OK) {
            aicpusd_err("Failed to response info, ret[%d]", ret);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        return AICPU_SCHEDULE_OK;
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
        const void * const opMappingInfo = ValueToPtr(info.dumpinfoPtr);
        const uint32_t len = info.length;
        AicpuSchedule::OpDumpTaskManager &opDumpTaskMgr = AicpuSchedule::OpDumpTaskManager::GetInstance();
        int32_t ret = opDumpTaskMgr.LoadOpMappingInfo(PtrToPtr<const void, const char_t>(opMappingInfo), len);
        aicpusd_info("Begin to send response information using tsDevSendMsgAsync function; load ret[%d].", ret);
        int32_t res = aicpuSqeAdapter.AicpuDataDumpLoadResponseToTs(ret);
        aicpusd_info("Finished to send dump load info report info, ret=%d", ret);

        if (res != AICPU_SCHEDULE_OK) {
            aicpusd_err("Failed to response info, ret[%d]", ret);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }

        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuEventProcess::SendCtrlCpuMsg(int32_t aicpuPid, const uint32_t eventType, char_t *msg,
                                              const uint32_t msgLen) const
    {
        event_summary eventInfoSummary = {};
        eventInfoSummary.pid = aicpuPid;
        eventInfoSummary.event_id = EVENT_CCPU_CTRL_MSG;
        eventInfoSummary.subevent_id = eventType;
        eventInfoSummary.msg = msg;
        eventInfoSummary.msg_len = msgLen;
        eventInfoSummary.grp_id = CCPU_DEFAULT_GROUP_ID;
        eventInfoSummary.dst_engine = CCPU_DEVICE;
        const drvError_t ret = halEschedSubmitEvent(AicpuDrvManager::GetInstance().GetDeviceId(),
                                                    &eventInfoSummary);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("Failed to submit aicpu event. ret is %d.", ret);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        aicpusd_info("Send ctrl cpu msg success, eventType=%u", eventType);
        return AICPU_SCHEDULE_OK;
    }
}