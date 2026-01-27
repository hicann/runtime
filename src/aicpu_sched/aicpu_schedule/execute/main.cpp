/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <string>
#include <vector>
#include <sstream>
#include <unistd.h>
#include <dlfcn.h>
#include <sys/file.h>
#include <sys/ioctl.h>
#include <exception>
#include "core/aicpusd_interface_process.h"
#include "core/aicpusd_event_process.h"
#include "core/aicpusd_event_manager.h"
#include "core/aicpusd_resource_limit.h"
#include "core/aicpusd_worker.h"
#include "aicpusd_profiler.h"
#include "aicpusd_lastword.h"
#include "common/aicpusd_args_parser.h"
#include "aicpusd_util.h"
#include "aicpusd_status.h"
#include "aicpusd_common.h"
#include "securec.h"
#include "tsd.h"
#include "aicpusd_weak_log.h"
#include "driver/ascend_hal.h"
#include "common/aicpusd_context.h"
#include "aicpusd_mc2_maintenance_thread_api.h"
#include "aicpusd_feature_ctrl.h"
#include "aicpusd_cust_dump_process.h"
#include "aicpusd_send_platform_Info_to_custom.h"

namespace AicpuSchedule {
namespace {
constexpr int32_t SUCCESS_VALUE = 0;
const std::string ERROR_MSG_INVALID_PARAM = "E39001";
const std::string ERROR_MSG_DRV_ERROR = "E39002";
const std::string ERROR_MSG_CGROUP_FAILED = "E30007";
const std::string ERROR_MSG_AICPU_INIT_FAILED = "E39004";
const std::string QUEUE_SCHEDULE_SO_NAME = "libqueue_schedule.so";
void *g_qslibHandle = nullptr;

void SetLogLevel(AicpuSchedule::ArgsParser &startParams)
{
    if (&dlog_setlevel != nullptr) {
        if (dlog_setlevel(-1, startParams.GetLogLevel(), startParams.GetEventLevel()) != SUCCESS_VALUE) {
            aicpusd_warn("Set log level failed");
        }
        if ((startParams.GetCcecpuLogLevel() >= DEBUG_LOG) && (startParams.GetCcecpuLogLevel() <= ERROR_LOG)) {
            if (dlog_setlevel(CCECPU, startParams.GetCcecpuLogLevel(), startParams.GetEventLevel()) != SUCCESS_VALUE) {
                aicpusd_warn("Set ccecpu log level failed");
            }
        }
        if ((startParams.GetAicpuLogLevel() >= DEBUG_LOG) && (startParams.GetAicpuLogLevel() <= ERROR_LOG)) {
            if (dlog_setlevel(AICPU, startParams.GetAicpuLogLevel(), startParams.GetEventLevel()) != SUCCESS_VALUE) {
                aicpusd_warn("Set aicpu log level failed");
            }
        }
    }
    LogAttr logAttr = {};
    logAttr.type = APPLICATION;
    logAttr.pid = startParams.GetHostPid();
    logAttr.deviceId = startParams.GetDeviceId();
    logAttr.mode = 0;
    if (DlogSetAttrAicpu(logAttr) != SUCCESS_VALUE) {
        aicpusd_warn("Set log attr failed");
    }
}
/**
 * attach host group based on parameters send by tsd.
 * @param  grpNameListStr group name list
 * @param  grpNameNum group name number
 * @return true:success, false:failed
 */
bool AttachHostGroup(const std::vector<std::string> &groupNameVec, const uint32_t grpNameNum)
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
        aicpusd_err("Aicpu start failed. parse group name num[%d] is consistence with num[%u] in parameter",
                    groupNameVec.size(), grpNameNum);
        return false;
    }

    for (size_t i = 0UL; i < groupNameVec.size(); ++i) {
        const auto drvRet = halGrpAttach(groupNameVec[i].c_str(), -1);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("halGrpAttach group[%s] failed. ret[%d]", groupNameVec[i].c_str(), drvRet);
            return false;
        }
        aicpusd_run_info("halGrpAttach group[%s] successfully.", groupNameVec[i].c_str());
    }
    return true;
}

void ReportErrorMsg(const int32_t errCode, const uint32_t deviceId, const uint32_t hostPid, const uint32_t vfId)
{
    std::string errStr;
    switch (errCode) {
        case AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID: {
            errStr = ERROR_MSG_INVALID_PARAM;
            break;
        }
        case AICPU_SCHEDULE_ERROR_DRV_ERR: {
            errStr = ERROR_MSG_DRV_ERROR;
            break;
        }
        case AICPU_SCHEDULE_ERROR_CGROUP_FAILED: {
            errStr = ERROR_MSG_CGROUP_FAILED;
            break;
        }
        case AICPU_SCHEDULE_ERROR_INIT_FAILED: {
            errStr = ERROR_MSG_AICPU_INIT_FAILED;
            break;
        }
        default: {
            errStr = ERROR_MSG_AICPU_INIT_FAILED;
            break;
        }
    }
    DlogFlushAicpu();
    sleep(1); // sleep 1s to avoid log loss
    const int32_t ret = TsdReportStartOrStopErrCode(deviceId, TSD_COMPUTE, hostPid, vfId,
        errStr.c_str(), static_cast<uint32_t>(errStr.size()));
    if (ret != 0) {
        aicpusd_err("TsdReportStartOrStopErrCode failed. ret[%d]", ret);
        sleep(1); // sleep 1s to avoid log loss
    }

    DlogFlushAicpu();
}

void SendPidQosMsgToTsd(const uint32_t pidQos, const uint32_t deviceId, const uint32_t hostPid, const uint32_t vfId)
{
    TsdCapabilityMsgInfo qosPidMsg;
    qosPidMsg.subCapabityType = TSD_EVENT_GET_CAPABILITY;
    qosPidMsg.resultInfo = pidQos;
    ReportMsgToTsd(deviceId, TSD_COMPUTE, hostPid, vfId, reinterpret_cast<const char_t * const>(&qosPidMsg));
}

void RegQueueScheduleModuleCallBack()
{
    g_qslibHandle = dlopen(QUEUE_SCHEDULE_SO_NAME.c_str(), RTLD_LAZY);
    if (g_qslibHandle == nullptr) {
        aicpusd_warn("cannot open %s", QUEUE_SCHEDULE_SO_NAME.c_str());
        return;
    }

    const SubProcEventCallBackFuncInfo startQsFunc =
        reinterpret_cast<SubProcEventCallBackFuncInfo>(dlsym(g_qslibHandle, "StartQueueScheduleModule"));
    if (startQsFunc == nullptr) {
        aicpusd_err("cannot find StartQueueScheduleModule");
        (void)dlclose(g_qslibHandle);
        g_qslibHandle = nullptr;
        return;
    }

    SubProcEventCallBackInfo startCallBackInfo;
    startCallBackInfo.callBackFunc = startQsFunc;
    startCallBackInfo.eventType = TSD_EVENT_START_QS_MODULE;
    int32_t ret = RegEventMsgCallBackFunc(&startCallBackInfo);
    if (ret != 0) {
        aicpusd_err("reg StartQueueScheduleModule failed");
        (void)dlclose(g_qslibHandle);
        g_qslibHandle = nullptr;
        return;
    }

    const SubProcEventCallBackFuncInfo stopQsFunc =
        reinterpret_cast<SubProcEventCallBackFuncInfo>(dlsym(g_qslibHandle, "StopQueueScheduleModule"));
    if (stopQsFunc == nullptr) {
        UnRegEventMsgCallBackFunc(TSD_EVENT_START_QS_MODULE);
        aicpusd_err("cannot find StopQueueScheduleModule");
        (void)dlclose(g_qslibHandle);
        g_qslibHandle = nullptr;
        return;
    }

    SubProcEventCallBackInfo stopCallBackInfo;
    stopCallBackInfo.callBackFunc = stopQsFunc;
    stopCallBackInfo.eventType = TSD_EVENT_STOP_QS_MODULE;

    ret = RegEventMsgCallBackFunc(&stopCallBackInfo);
    if (ret != 0) {
        UnRegEventMsgCallBackFunc(TSD_EVENT_START_QS_MODULE);
        aicpusd_err("reg StopQueueScheduleModule failed");
        (void)dlclose(g_qslibHandle);
        g_qslibHandle = nullptr;
        return;
    }

    aicpusd_run_info("Register queue schedule module callback successfully.");
    return;
}

void RegCreateMc2MantenanceThreadCallBack()
{
    SubProcEventCallBackInfo createMc2MantenanceThreadInfo = {};
    createMc2MantenanceThreadInfo.callBackFunc = CreateMc2MantenanceThread;
    createMc2MantenanceThreadInfo.eventType = TSD_EVENT_START_MC2_THREAD;
    int32_t ret = RegEventMsgCallBackFunc(&createMc2MantenanceThreadInfo);
    if (ret != 0) {
        aicpusd_err("reg Create Mc2 Maintenance Thread failed");
        return;
    }
}

void RegCreateDatadumpThreadCallBack()
{
    SubProcEventCallBackInfo createDatadumpThreadInfo = {};
    createDatadumpThreadInfo.callBackFunc = CreateDatadumpThread;
    createDatadumpThreadInfo.eventType = TSD_EVENT_START_UDF_DATADUMP_THREAD;
    int32_t ret = RegEventMsgCallBackFunc(&createDatadumpThreadInfo);
    if (ret != 0) {
        aicpusd_err("reg Create datadump Thread failed");
        return;
    }
}

void RegCustProcessLoadPlatformCallBack()
{
    SubProcEventCallBackInfo sendLoadPlatformInfoToCustInfo = {};
    sendLoadPlatformInfoToCustInfo.callBackFunc = SendLoadPlatformInfoToCust;
    sendLoadPlatformInfoToCustInfo.eventType = TSD_EVENT_LOAD_PLATFORM_TO_CUST;
    int32_t ret = RegEventMsgCallBackFunc(&sendLoadPlatformInfoToCustInfo);
    if (ret != 0) {
        aicpusd_err("reg send load platform to cust failed");
        return;
    }
}

void StopQsSubModuleInAicpu(const uint32_t deviceId, const uint32_t hostPid, const uint32_t vfId)
{
    if (g_qslibHandle == nullptr) {
        aicpusd_warn("cannot open so %s", QUEUE_SCHEDULE_SO_NAME.c_str());
        return;
    }
    TsdSubEventInfo eventInfo = {};
    eventInfo.deviceId = deviceId;
    eventInfo.hostPid = hostPid;
    eventInfo.vfId = vfId;
    const SubProcEventCallBackFuncInfo stopQsFunc =
        reinterpret_cast<SubProcEventCallBackFuncInfo>(dlsym(g_qslibHandle, "StopQueueScheduleModule"));
    if (stopQsFunc == nullptr) {
        aicpusd_err("cannot find StopQueueScheduleModule");
        (void)dlclose(g_qslibHandle);
        g_qslibHandle = nullptr;
        return;
    }
    const int32_t ret = stopQsFunc(&eventInfo);
    if (ret != 0) {
        aicpusd_err("StopQueueScheduleModule fail");
    }
    (void)dlclose(g_qslibHandle);
    g_qslibHandle = nullptr;
}

bool SendVfMsgToDrv(const uint32_t cmd, const uint32_t deviceId, const uint32_t vfId)
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

void CloseQslibHandle()
{
    if (g_qslibHandle != nullptr) {
        (void)dlclose(g_qslibHandle);
        g_qslibHandle = nullptr;
        return;
    }
}

AicpuSchedMode GetAicpuSchedMode(const uint32_t deviceId, const uint32_t vfId, const AicpuSchedMode schedMode)
{
    if (vfId > 0 || deviceId >= VDEVICE_MIN_CPU_NUM) {
        aicpusd_run_info("Aicpu start with interrupt mode in virtual machine");
        return SCHED_MODE_INTERRUPT;
    }

    return schedMode;
}
}
}

/**
 * main of compute process.
 * @param  argc argv length
 * @param  argv arg values
 * @return 0:success, other:failed
 */
#ifndef aicpusd_UT
int32_t main(int32_t argc, char *argv[])
#else
int32_t ComputeProcessMain(int32_t argc, char* argv[])
#endif
{
    try {
        AicpuSchedule::ArgsParser startParams;
        if (!startParams.ParseArgs(argc, argv)) {
            return -1;
        }
        AicpuSchedule::SetLogLevel(startParams);
        aicpusd_run_info("Start parameter. %s", startParams.GetParaParsedStr().c_str());

        const uint32_t vfId = startParams.GetVfId();
        const pid_t pid = startParams.GetHostPid();
        const uint32_t deviceId = startParams.GetDeviceId();
        if (!AicpuSchedule::AddToCgroup(deviceId, vfId)) {
            AicpuSchedule::ReportErrorMsg(AicpuSchedule::AICPU_SCHEDULE_ERROR_CGROUP_FAILED,
                                          deviceId, static_cast<uint32_t>(pid), vfId);
            return -1;
        }
        // Make sure AicpusdLastword are created first，to ensure the last exit
        AicpuSchedule::AicpusdLastword::GetInstance();
        AicpuSchedule::AicpuProfiler::ProfilerAgentInit();
        const AicpuSchedMode aicpuSchedMode =  AicpuSchedule::GetAicpuSchedMode(deviceId, vfId,
                                                                                startParams.GetAicpuSchedMode());
        AicpuSchedule::AicpuEventManager::GetInstance().InitEventMgr(false, true, 0U, aicpuSchedMode);
        std::vector<uint32_t> deviceVec(1, deviceId);
        
        int32_t ret = AicpuSchedule::AicpuScheduleInterface::GetInstance().InitAICPUScheduler(
            deviceVec, pid, startParams.GetPidSign(), startParams.GetProfilingMode(),
            vfId, true, aicpuSchedMode, startParams.GetHostProcName());
        if (ret != AicpuSchedule::AICPU_SCHEDULE_OK) {
            aicpusd_err("Aicpu schedule start failed, ret=%d", ret);
            AicpuSchedule::ReportErrorMsg(ret, deviceId, static_cast<uint32_t>(pid), vfId);
            (void)AicpuSchedule::AicpuScheduleInterface::GetInstance().StopAICPUScheduler(deviceVec, pid);
            return -1;
        }

        std::string libPath = "";
        (void)AicpuSchedule::AicpuUtil::GetEnvVal(AicpuSchedule::ENV_NAME_LD_LIBRARY_PATH, libPath);
        aicpusd_run_info("Aicpu schedule start successfully, LD_LIBRARY_PATH=%s", libPath.c_str());

        // start attach and init process.
        // Attach group before send success to make sure aicpusd own the authority to access mbuff send by RTS
        if (!AicpuSchedule::AttachHostGroup(startParams.GetGrpNameList(), startParams.GetGrpNameNum())) {
            aicpusd_err("AttachHostGroup execute failed.");
            AicpuSchedule::ReportErrorMsg(AicpuSchedule::AICPU_SCHEDULE_ERROR_DRV_ERR,
                                          deviceId, static_cast<uint32_t>(pid), vfId);
            return -1;
        }

        aicpusd_run_info("Aicpu schedule attach and init successfully.");
        // send pid qos to tsd current send default value 0 to tsd
        AicpuSchedule::SendPidQosMsgToTsd(static_cast<uint32_t>(PRIORITY_LEVEL1), deviceId,
                                          static_cast<uint32_t>(pid), vfId);
        
        // reg queue schedule start and stop callback func
        AicpuSchedule::RegQueueScheduleModuleCallBack();
        AicpuSchedule::RegCreateMc2MantenanceThreadCallBack();
        AicpuSchedule::RegCreateDatadumpThreadCallBack();
        AicpuSchedule::RegCustProcessLoadPlatformCallBack();

        const int32_t rspRet = StartupResponse(deviceVec[0U], TSD_COMPUTE, static_cast<uint32_t>(pid), vfId);
        if (rspRet != AicpuSchedule::SUCCESS_VALUE) {
            aicpusd_err("Aicpu startup response return not ok, error code[%d].", rspRet);
            AicpuSchedule::CloseQslibHandle();
            return -1;
        }
        aicpusd_run_info("Aicpu startup response return successfully.");

        (void)AicpuSchedule::SendVfMsgToDrv(VM_QOS_PROCESS_STARTUP, deviceId, vfId);

        // wait for shutdown
        const int32_t waitRet = WaitForShutDown(deviceVec[0U]);
        if (waitRet != AicpuSchedule::SUCCESS_VALUE) {
            aicpusd_err("wait for shut down return not ok return not ok, error code[%d].", waitRet);
            ret = -1;
        } else {
            aicpusd_info("wait for shut down return successfully.");
            ret = 0;
        }

        AicpuSchedule::StopQsSubModuleInAicpu(deviceId, static_cast<uint32_t>(pid), vfId);
        (void)AicpuSchedule::AicpuScheduleInterface::GetInstance().StopAICPUScheduler(deviceVec, pid);
        aicpusd_run_info("Aicpu schedule stopped");

        (void)AicpuSchedule::SendVfMsgToDrv(VM_QOS_PROCESS_SUSPEND, deviceId, vfId);
        // flush cache log to slogd
        DlogFlushAicpu();
        return ret;
    } catch (const std::exception &e) {
        aicpusd_err("Execute main failed, reason=%s", e.what());
        return -1;
    }
}
