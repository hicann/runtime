/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <sys/file.h>
#include <sys/ioctl.h>
#include "aicpusd_interface_process.h"
#include <unistd.h>
#include "ascend_hal.h"
#include "status.h"
#include "aicpusd_event_manager.h"
#include "aicpusd_status.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_threads_process.h"
#include "aicpusd_common.h"
#include "aicpusd_monitor.h"
#include "aicpusd_hal_interface_ref.h"
#include "aicpu_cust_sd_dump_process.h"
#include "core/aicpusd_op_executor.h"
#include "core/aicpusd_resource_limit.h"
#include "stackcore_interface_weak.h"
#include "aicpu_cust_sd_mc2_maintenance_thread_api.h"

namespace AicpuSchedule {
    namespace {
        void RegOpenCustSoCallBack()
        {
            SubProcEventCallBackInfo openCustSoInfo = {};
            openCustSoInfo.callBackFunc = CustomOpExecutor::OpenKernelSoByAicpuEvent;
            openCustSoInfo.eventType = AICPU_SUB_EVENT_OPEN_CUSTOM_SO;
            int32_t ret = RegEventMsgCallBackFunc(&openCustSoInfo);
            if (ret != 0) {
                aicpusd_run_warn("Aicpu-sd-cust main thread reg open custom so callback function failed. eventid[%d]",
                                 static_cast<int32_t>(openCustSoInfo.eventType));
                return;
            }
        }
    } //namespace
    constexpr int32_t SUCCESS_VALUE = 0;
    constexpr int32_t ATTACH_TIME_OUT = 20000; // attach fail after 20s blocking attach
    /**
     * @ingroup AicpuScheduleCore
     * @brief it is used to construct a object of AicpuScheduleCore.
     */
    AicpuScheduleInterface::AicpuScheduleInterface()
        : noThreadFlag_(true),
          initFlag_(false),
          aicpuSdPid_(-1),
          tsdPid_(-1) {}

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

    void SetCustAicpuMainThreadContext(const uint32_t deviceId, const pid_t hostPid, const uint32_t vfId)
    {
        aicpu::aicpuContext_t context = {};
        context.tsId = 0U;
        context.deviceId = deviceId;
        context.hostPid = hostPid;
        context.vfId = vfId;
        aicpu::SetUniqueVfId(AicpuDrvManager::GetInstance().GetUniqueVfId());
        (void)aicpu::aicpuSetContext(&context);
    }

    /**
     * @ingroup AicpuScheduleInterface
     * @brief it use to initialize aicpu schedule.
     * @param [in] deviceId
     * @param [in] hostPid : the process id of host process
     * @param [in] pidSign : the signature of pid ,it is used in drv.
     * @param [in] profilingMode
     * @param [in] aicpuPid : the process id of aicpu-sd process
     * @param [in] vfId : vf id
     * @param [in] isOnline : true: online  false offline
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    int32_t AicpuScheduleInterface::InitAICPUScheduler(const uint32_t deviceId,
                                                       const pid_t hostPid,
                                                       const std::string &pidSign,
                                                       const uint32_t profilingMode,
                                                       const pid_t aicpuPid,
                                                       const uint32_t vfId,
                                                       const bool isOnline)
    {
        (void)pidSign;
        const std::unique_lock<std::mutex> initLock(mutexForInit_);
        if (initFlag_) {
            aicpusd_warn("Aicpu schedule is already init.");
            return AICPU_SCHEDULE_OK;
        }

        aicpu::InitAicpuErrorLog();
        noThreadFlag_ = false;
        if (AicpuDrvManager::GetInstance().InitDrvMgr(deviceId, hostPid, vfId, true) != AICPU_SCHEDULE_OK) {
            aicpusd_err("Failed to init aicpu drv manager");
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        aicpu::AicpuRunMode runModeCur = aicpu::AicpuRunMode::THREAD_MODE;
        if (GetCurrentRunMode(isOnline, runModeCur) != AICPU_SCHEDULE_OK) {
            aicpusd_err("Aicpu custom get run mode failed");
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }

        const int32_t bindPidRet = AicpuSchedule::AicpuDrvManager::GetInstance().CheckBindHostPid();
        if (bindPidRet != AICPU_SCHEDULE_OK) {
            aicpusd_err("Check bind pid sign failed, ret[%d].", bindPidRet);
            return static_cast<int32_t>(ComputProcessRetCode::CP_RET_COMMON_ERROR);
        }
        aicpusd_info("Bind pid sign success.");
        const uint32_t groupIdCur = DEFAULT_GROUP_ID;
        int32_t retRes = AicpuDrvManager::GetInstance().InitDrvSchedModule(groupIdCur);
        if (retRes != static_cast<int32_t>(DRV_ERROR_NONE)) {
            aicpusd_err("Failed to init the drv schedule module, ret[%d].", retRes);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        SetCustAicpuMainThreadContext(deviceId, hostPid, vfId);
        retRes = AicpuSchedule::AicpuMonitor::GetInstance().InitAicpuMonitor(deviceId, isOnline);
        if (retRes != AICPU_SCHEDULE_OK) {
            aicpusd_err("aicpu monitor init failed, ret[%d]", retRes);
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        retRes = ComputeProcess::GetInstance().Start(deviceId, hostPid, profilingMode, aicpuPid, vfId, runModeCur);
        if (retRes != static_cast<int32_t>(ComputProcessRetCode::CP_RET_SUCCESS)) {
            aicpusd_err("Compute process start failed, ret[%d].", retRes);
            AicpuSchedule::AicpuMonitor::GetInstance().Stop();
            ComputeProcess::GetInstance().Stop();
            return AICPU_SCHEDULE_ERROR_INIT_CP_FAILED;
        }
        aicpusd_info("Success to start compute process, deviceId[%u], hostPid[%d], mode[%d].",
                     deviceId, hostPid, static_cast<int32_t>(isOnline));
        initFlag_ = true;
        return AICPU_SCHEDULE_OK;
    }

    /**
     * @ingroup AicpuScheduleInterface
     * @brief it use to stop AICPU scheduler.
     * @param [in] deviceId
     * @param [in] hostPid :the process id of host
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    int32_t AicpuScheduleInterface::StopAICPUScheduler(const uint32_t deviceId)
    {
        aicpusd_info("Begin to stop aicpu custom scheduler.");
        const std::unique_lock<std::mutex> stopLock(mutexForInit_);
        if (!noThreadFlag_) {
            ComputeProcess::GetInstance().Stop();
        }

        noThreadFlag_ = true;
        initFlag_ = false;
        // GetInstance is not null, checked in InitAICPUScheduler
        AicpuSchedule::AicpuMonitor::GetInstance().Stop();
        AicpuSchedule::AicpuEventManager::GetInstance().SetRunningFlag(false);
        AicpuSchedule::AicpuCustDumpProcess::GetInstance().UnitDataDumpProcess();
        FeatureCtrl::ClearTsMsgVersionInfo();
        constexpr uint32_t sleepUsecs = 1000U; // sleep 1ms to avoid SchedWaitEvent error
        (void)usleep(sleepUsecs);
        if ((FeatureCtrl::ShouldInitDrvThread()) && (&halDrvEventThreadUninit != nullptr)) {
            const auto unInitRet = halDrvEventThreadUninit(deviceId);
            aicpusd_run_info("Uninit process drv queue msg on ccpu, ret is %d.", static_cast<int32_t>(unInitRet));
        }
        const auto ret = halEschedDettachDevice(deviceId);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("Failed to detach device[%u], result[%d].", deviceId, static_cast<int32_t>(ret));
            return static_cast<int32_t>(ret);
        }
        aicpusd_info("Success to stop aicpu custom scheduler.");
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuScheduleInterface::GetCurrentRunMode(const bool isOnline, aicpu::AicpuRunMode &runMode) const
    {
        if (!isOnline) {
            runMode = aicpu::AicpuRunMode::THREAD_MODE;
            aicpusd_info("Current aicpu mode is offline (call by api).");
            return AICPU_SCHEDULE_OK;
        }

        drvHdcCapacity capacity;
        capacity.chanType = HDC_CHAN_TYPE_SOCKET;
        capacity.maxSegment = 0U;
        const hdcError_t hdcRet = drvHdcGetCapacity(&capacity);
        if (hdcRet != DRV_ERROR_NONE) {
            aicpusd_err("Aicpu cust scheduler get capacity failed, ret[%d].", static_cast<int32_t>(hdcRet));
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }

        // online: with host, offline: without host only device
        if (capacity.chanType == HDC_CHAN_TYPE_SOCKET) {
            runMode = aicpu::AicpuRunMode::PROCESS_SOCKET_MODE;
            aicpusd_info("Set aicpu online mode false. current mode is socket_mode.");
            return AICPU_SCHEDULE_OK;
        }

        runMode = aicpu::AicpuRunMode::PROCESS_PCIE_MODE;
        aicpusd_info("Current aicpu mode is online, called from host.");
        return AICPU_SCHEDULE_OK;
    }

    void AicpuScheduleInterface::SetAicpuSdProcId(const pid_t aicpuSdPid)
    {
        aicpuSdPid_ = aicpuSdPid;
        aicpusd_info("Set aicpusd pid:%u", static_cast<uint32_t>(aicpuSdPid_));
    }

    pid_t AicpuScheduleInterface::GetAicpuSdProcId() const
    {
        return aicpuSdPid_;
    }

    void AicpuScheduleInterface::SetTsdProcId(const pid_t tsdPid)
    {
        tsdPid_ = tsdPid;
        aicpusd_info("Set tsd pid:%u", static_cast<uint32_t>(tsdPid_));
    }

    pid_t AicpuScheduleInterface::GetTsdProcId() const
    {
        return tsdPid_;
    }

    void AicpuScheduleInterface::SetLogLevel(const AicpuSchedule::ArgsParser &startParams) const
    {
        if (&dlog_setlevel != nullptr) {
            if (dlog_setlevel(-1, startParams.GetLogLevel(), startParams.GetEventLevel()) != AicpuSchedule::SUCCESS_VALUE) {
                aicpusd_warn("Set log level failed");
            }
            if ((startParams.GetCcecpuLogLevel() >= DEBUG_LOG) && (startParams.GetCcecpuLogLevel() <= ERROR_LOG)) {
                if (dlog_setlevel(CCECPU, startParams.GetCcecpuLogLevel(), startParams.GetEventLevel()) != SUCCESS_VALUE) {
                    aicpusd_warn("Set ccecpu log level failed");
                }
            }
            if ((startParams.GetAicpuLogLevel() >= DEBUG_LOG) && (startParams.GetAicpuLogLevel() <= ERROR_LOG)) {
                if (dlog_setlevel(AICPU, startParams.GetAicpuLogLevel(), startParams.GetEventLevel()) != SUCCESS_VALUE) {
                    aicpusd_warn("Set aicpu log failed");
                }
            }
        }
        if (&DlogSetAttr != nullptr) {
            LogAttr logAttr = {};
            logAttr.type = APPLICATION;
            logAttr.pid = static_cast<uint32_t>(startParams.GetHostPid());
            logAttr.deviceId = startParams.GetDeviceId();
            if (DlogSetAttr(logAttr) != AicpuSchedule::SUCCESS_VALUE) {
                aicpusd_warn("Set log attr failed");
            }
        }
    }
    void AicpuScheduleInterface::SetTsdEventDstPidByArgs(const AicpuSchedule::ArgsParser &startParams) const
    {
        if ((!startParams.HasTsdPid()) || (startParams.GetTsdPid() == 0U)) {
            aicpusd_run_info("hastsdpid:%d, tsdpid:%u", startParams.HasTsdPid(), startParams.GetTsdPid());
            return;
        }
        SetDstTsdEventPid(startParams.GetTsdPid());
        aicpusd_run_info("cust finish set tsdpid:%u", startParams.GetTsdPid());
    }
    void AicpuScheduleInterface::SetCustAicpuMainThreadAffinity(const AicpuSchedule::ArgsParser &startParams) const
    {
        if (!startParams.HasControlCpuList()) {
            return;
        }
        pthread_t threadId = pthread_self();
        std::vector<uint32_t> cpuIds = startParams.GetControlCpuList();
        cpu_set_t cpuset;
        CPU_ZERO(&cpuset);
        for (const auto cpuId: cpuIds) {
            CPU_SET(cpuId, &cpuset);
            aicpusd_info("prepare bind threadId=%lu to cpuId=%u", threadId, static_cast<uint32_t>(cpuId));
        }
        aicpusd_run_info("begin call pthread_setaffinity_np threadId=%lu", threadId);
        // 设置线程亲和性
        int32_t ret = pthread_setaffinity_np(threadId, sizeof(cpu_set_t), &cpuset);
        if (ret != 0) {
            aicpusd_err("BindCpu threadId=%lu set affinity failed, ret=%d", threadId, ret);
            return;
        }
        // 检查线程实际亲和性
        ret = pthread_getaffinity_np(threadId, sizeof(cpu_set_t), &cpuset);
        if (ret != 0) {
            aicpusd_err("BindCpu threadId=%lu get affinity failed, ret=%d", threadId, ret);
            return;
        }
        for (int32_t cpuId = 0; cpuId < CPU_SETSIZE; cpuId++) {
            if (CPU_ISSET(cpuId, &cpuset) != 0) {
                aicpusd_info("BindCpu threadId=%lu to cpuId=%d success", threadId, static_cast<int32_t>(cpuId));
            }
        }
    }

    bool AicpuScheduleInterface::AttachHostGroup(const std::vector<std::string> &groupNameVec,
        const uint32_t grpNameNum) const
    {
        if (grpNameNum == 0U) {
            aicpusd_info("There is not group need to be attached");
            return true;
        }
        if (groupNameVec.empty()) {
            aicpusd_err("Aicpu start failed. Wrong parameters of groupNum[%d] with empty group name", grpNameNum);
            return false;
        }

        if (static_cast<uint32_t>(groupNameVec.size()) != grpNameNum) {
            aicpusd_err("Aicpu start failed. parse group name num[%u] is consistence with num[%u] in parameter",
                        groupNameVec.size(), grpNameNum);
            return false;
        }
        for (size_t i = 0UL; i < groupNameVec.size(); ++i) {
            aicpusd_info("halGrpAttach group[%s].", groupNameVec[i].c_str());
            const auto drvRet = halGrpAttach(groupNameVec[i].c_str(), ATTACH_TIME_OUT);
            if (drvRet != DRV_ERROR_NONE) {
                aicpusd_err("halGrpAttach group[%s] failed. ret[%d]", groupNameVec[i].c_str(), drvRet);
                return false;
            }
            aicpusd_run_info("halGrpAttach group[%s] success", groupNameVec[i].c_str());
        }
        BuffCfg buffCfg = {};
        const auto initDrvRet = halBuffInit(&buffCfg);
        if ((initDrvRet != DRV_ERROR_NONE) && (initDrvRet != DRV_ERROR_REPEATED_INIT)) {
            aicpusd_err("halBuffInit execute failed. ret[%d]", initDrvRet);
            return false;
        }
        return true;
    }

    bool AicpuScheduleInterface::SendVfMsgToDrv(const uint32_t cmd, const uint32_t deviceId, const uint32_t vfId) const
    {
        if (FeatureCtrl::IsVfMode(deviceId, vfId)) {
            const int32_t fd = open("/dev/qos", O_RDWR);
            if (fd < 0) {
                aicpusd_warn("no such file. error[%s],errorno[%d]", strerror(errno), errno);
                return false;
            }
            VfMsgInfo vfMsg;
            vfMsg.deviceId = deviceId;
            vfMsg.vfId = vfId;
            const auto ret = ioctl(fd, cmd, PtrToPtr<VfMsgInfo, void>(&vfMsg));
            if (ret != 0) {
                aicpusd_warn("ioctl failed, error[%s],errorno[%d]", strerror(errno), errno);
                (void)close(fd);
                return false;
            }
            (void)close(fd);
        }
        return true;
    }

    void RegCreateCustMc2MaintenanceThreadCallBack()
    {
        SubProcEventCallBackInfo createCustMc2MaintenanceThreadInfo = {};
        createCustMc2MaintenanceThreadInfo.callBackFunc = CreateCustMc2MaintenanceThread;
        createCustMc2MaintenanceThreadInfo.eventType = TSD_EVENT_START_MC2_THREAD;
        int32_t ret = RegEventMsgCallBackFunc(&createCustMc2MaintenanceThreadInfo);
        if (ret != 0) {
            aicpusd_err("Reg create cust mc2 maintenance thread failed");
            return;
        }
    }

    int32_t AicpuScheduleInterface::CustAicpuMainProcess(int32_t argc, char_t *argv[]) const
    {
        try {
            AicpuSchedule::ArgsParser startParams;
            if (!startParams.ParseArgs(argc, argv)) {
                return -1;
            }
            SetLogLevel(startParams);
            SetTsdEventDstPidByArgs(startParams);
            SetCustAicpuMainThreadAffinity(startParams);
            aicpusd_run_info("Start parameter. %s", startParams.GetParaParsedStr().c_str());
            if (&StackcoreSetSubdirectory != nullptr) {
                (void)StackcoreSetSubdirectory("udf");
            }
            const pid_t aicpuPid = static_cast<pid_t>(startParams.GetAicpuPid());
            const uint32_t vfId = startParams.GetVfId();
            const uint32_t deviceId = startParams.GetDeviceId();
            const pid_t hostPid = static_cast<pid_t>(startParams.GetHostPid());
            const uint32_t mode = startParams.GetProfilingMode();
            if (!startParams.HasTsdPid()) {
                if (!aicpu::AddToCgroup(deviceId, vfId)) {
                    return -1;
                }
            }
            
            // Init custom op executor
            AicpuSchedule::CustomOpExecutor::GetInstance().InitOpExecutor(hostPid, startParams.GetCustSoPath());
            AicpuSchedule::AicpuEventManager::GetInstance().InitEventManager(false, true);
            int32_t ret = AicpuSchedule::AicpuScheduleInterface::GetInstance().InitAICPUScheduler(deviceId, hostPid,
                startParams.GetPidSign(), mode, aicpuPid, vfId, true);
            if (ret != AicpuSchedule::AICPU_SCHEDULE_OK) {
                aicpusd_err("Aicpu custom schedule start failed, ret[%d].", ret);
                (void)AicpuSchedule::AicpuScheduleInterface::GetInstance().StopAICPUScheduler(deviceId);
                return -1;
            }
            const pid_t tsdPid = startParams.HasTsdPid() ? startParams.GetTsdPid() : getppid();
            AicpuSchedule::AicpuScheduleInterface::GetInstance().SetAicpuSdProcId(aicpuPid);
            AicpuSchedule::AicpuScheduleInterface::GetInstance().SetTsdProcId(tsdPid);
            const char_t * const libPath = getenv("LD_LIBRARY_PATH");
            if (libPath == nullptr) {
                aicpusd_run_info("Aicpu schedule start success, but LD_LIBRARY_PATH is empty.");
            } else {
                aicpusd_run_info("Aicpu schedule start success, LD_LIBRARY_PATH=%s.", libPath);
            }
            AicpuSchedule::RegCreateCustMc2MaintenanceThreadCallBack();
            AicpuSchedule::RegOpenCustSoCallBack();
            // response start message to tsd
            int32_t rspRet = static_cast<int32_t>(tsd::TSD_OK);
            if (startParams.GetGrpNameNum() > 0U) {
                rspRet = StartUpRspAndWaitProcess(deviceId, TSD_CUSTOM_COMPUTE, static_cast<uint32_t>(hostPid), vfId);
            } else {
                rspRet = StartupResponse(deviceId, TSD_CUSTOM_COMPUTE, static_cast<uint32_t>(hostPid), vfId);
            }
    
            if (rspRet != static_cast<int32_t>(tsd::TSD_OK)) {
                aicpusd_err("Cust aicpu startup response return not ok, error_code=%d", rspRet);
                return -1;
            }
            aicpusd_info("cust aicpu startup response return success");
    
            (void)SendVfMsgToDrv(VM_QOS_PROCESS_STARTUP, deviceId, vfId);
            // do group attach
            if (!AttachHostGroup(startParams.GetGrpNameList(), startParams.GetGrpNameNum())) {
                aicpusd_err("AttachHostGroup execute failed.");
                return -1;
            }
    
            if (startParams.GetGrpNameNum() > 0U) {
                aicpusd_run_info("Cust Aicpu schedule attach and init success.");
                AicpuSchedule::AicpuEventManager::GetInstance().SendCtrlCpuMsg(
                    aicpuPid, static_cast<uint32_t>(TsdSubEventType::TSD_EVENT_STOP_AICPU_PROCESS_WAIT), nullptr, 0U);
            }

            // wait for shutdown
            const int32_t waitRet = WaitForShutDown(deviceId);
            if (waitRet != static_cast<int32_t>(tsd::TSD_OK)) {
                aicpusd_err("wait for shut down return not ok, error code[%d].", waitRet);
                ret = -1;
            } else {
                aicpusd_info("wait for shut down success");
                ret = 0;
            }
            (void)AicpuSchedule::AicpuScheduleInterface::GetInstance().StopAICPUScheduler(deviceId);
            aicpusd_run_info("Aicpu custom schedule stopped.");
            (void)SendVfMsgToDrv(VM_QOS_PROCESS_SUSPEND, deviceId, vfId);
            if (&DlogFlush != nullptr) {
                DlogFlush();
            }
            return ret;
        } catch (const std::exception &e) {
            aicpusd_err("Execute main failed, reason=%s", e.what());
            return -1;
        }
    }
}