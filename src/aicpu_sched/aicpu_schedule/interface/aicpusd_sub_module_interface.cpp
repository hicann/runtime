/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <fstream>
#include <algorithm>
#include "profiling_adp.h"
#include "aicpusd_util.h"
#include "aicpusd_status.h"
#include "aicpusd_profiler.h"
#include "aicpusd_event_manager.h"
#include "aicpusd_interface_process.h"
#include "aicpusd_sub_module_interface.h"

namespace AicpuSchedule {
namespace {
constexpr uint32_t MAX_PARAM_NUM = 12U;
const std::string ERROR_MSG_INVALID_PARAM = "E39001";
const std::string ERROR_MSG_DRV_ERROR = "E39002";
const std::string ERROR_MSG_CGROUP_FAILED = "E30007";
const std::string ERROR_MSG_AICPU_INIT_FAILED = "E39004";
} // namespace

int32_t SubModuleInterface::StartAicpuSchedulerModule(const struct TsdSubEventInfo * const eventInfo)
{
    aicpusd_run_info("Enter aicpu schedule sub module start process.");
    // set event key
    SetTsdEventKey(eventInfo);

    // args parse
    ArgsParser startParas;
    if (!ParseArgsFromFile(startParas)) {
        aicpusd_err("Read aicpu submodule start paras from file failed");
        return -1;
    }

    // init aicpu
    AicpuProfiler::ProfilerAgentInit();
    AicpuEventManager::GetInstance().InitEventMgr(false, true, 0U, AicpuSchedMode::SCHED_MODE_INTERRUPT);
    const std::vector<uint32_t> deviceVec(1, tsdEventKey_.deviceId);
    const int32_t ret = AicpuScheduleInterface::GetInstance().InitAICPUScheduler(deviceVec, tsdEventKey_.hostPid,
        startParas.GetPidSign(), startParas.GetProfilingMode(), tsdEventKey_.vfId, true,
        SCHED_MODE_INTERRUPT);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Aicpu schedule start failed, ret[%d].", ret);
        ReportErrMsgToTsd(ret);
        (void)AicpuScheduleInterface::GetInstance().StopAICPUScheduler(deviceVec,
                                                                       static_cast<pid_t>(tsdEventKey_.hostPid));
        return -1;
    }

    std::string libPath = "";
    (void)AicpuUtil::GetEnvVal(ENV_NAME_LD_LIBRARY_PATH, libPath);
    aicpusd_run_info("Aicpu schedule start success, LD_LIBRARY_PATH=%s.", libPath.c_str());

    if (!AttachHostGroup(startParas)) {
        aicpusd_err("AttachHostGroup execute failed.");
        ReportErrMsgToTsd(AICPU_SCHEDULE_ERROR_DRV_ERR);
        return -1;
    }

    SendPidQosMsgToTsd(static_cast<uint32_t>(PRIORITY_LEVEL1));

    const int32_t rspRet = SendSubModuleRsponse(TSD_EVENT_START_AICPU_SD_MODULE_RSP);
    if (rspRet != 0) {
        aicpusd_err("Aicpu startup response return not ok, error code[%d].", rspRet);
        return -1;
    }

    startFlag_ = true;
    aicpusd_run_info("Aicpu schedule sub module start success.");
    return 0;
}

int32_t SubModuleInterface::StopAicpuSchedulerModule(const struct TsdSubEventInfo *const eventInfo)
{
    aicpusd_run_info("Enter aicpu schedule sub module stop process.");
    if (!startFlag_.load()) {
        aicpusd_run_info("No need to stop aicpu sub module.");
        return AICPU_SCHEDULE_SUCCESS;
    }

    SetTsdEventKey(eventInfo);
    const std::vector<uint32_t> deviceVec(1, tsdEventKey_.deviceId);
    (void)AicpuScheduleInterface::GetInstance().StopAICPUScheduler(deviceVec,
                                                                   static_cast<pid_t>(tsdEventKey_.hostPid));
    aicpusd_run_info("Aicpu schedule stopped.");
    const int32_t rspRet = SendSubModuleRsponse(TSD_EVENT_STOP_AICPU_SD_MODULE_RSP);
    if (rspRet != 0) {
        aicpusd_err("Aicpu stop response return not ok, error code[%d].", rspRet);
        return -1;
    }

    startFlag_ = false;
    aicpusd_run_info("Aicpu schedule sub module stop success.");
    return AICPU_SCHEDULE_SUCCESS;
}

void SubModuleInterface::SetTsdEventKey(const struct TsdSubEventInfo * const eventInfo)
{
    tsdEventKey_.deviceId = eventInfo->deviceId;
    tsdEventKey_.hostPid = eventInfo->hostPid;
    tsdEventKey_.vfId = eventInfo->vfId;
}

bool SubModuleInterface::ParseArgsFromFile(ArgsParser &startParas) const
{
    const std::string argsFilePath = BuildArgsFilePath();
    ScopeGuard fileDelGuard([&argsFilePath] () { DeleteArgsFile(argsFilePath); });

    std::ifstream argsFile;
    argsFile.open(argsFilePath, std::ifstream::in);
    if (!argsFile.is_open()) {
        aicpusd_err("Start file[%s] open failed, reason=%s", argsFilePath.c_str(), strerror(errno));
        return false;
    }
    ScopeGuard fileCloseGuard([&argsFile] () { argsFile.close(); });

    uint32_t item = 0U;
    std::vector<std::string> fileLines;
    std::string tempParam;
    while ((item < MAX_PARAM_NUM) && (getline(argsFile, tempParam))) {
        fileLines.emplace_back(tempParam);
        ++item;
    }

    return startParas.ParseArgs(fileLines);
}

std::string SubModuleInterface::BuildArgsFilePath() const
{
    const uint32_t curPid = static_cast<uint32_t>(getpid());
    const std::string fileName = "aicpu_sd_start_param_" + std::to_string(tsdEventKey_.deviceId) +
                                 "_" + std::to_string(tsdEventKey_.vfId) + "_" + std::to_string(curPid);
    std::string pathFreFix = "/home/HwHiAiUser/";
    if (AicpuUtil::IsEnvValEqual(ENV_NAME_REG_ASCEND_MONITOR, "0")) {
        pathFreFix = "/home/mdc/";
    }

    return pathFreFix.append(fileName);
}

void SubModuleInterface::DeleteArgsFile(const std::string &argsFilePath)
{
    const int32_t ret = remove(argsFilePath.c_str());
    if (ret != 0) {
        aicpusd_err("Remove file[%s] failed, ret=%d, reason=%s", argsFilePath.c_str(), ret, strerror(errno));
        return;
    }

    aicpusd_run_info("Remove file[%s] success", argsFilePath.c_str());
}

void SubModuleInterface::ReportErrMsgToTsd(const int32_t errCode) const
{
    const std::map<int32_t, std::string> errStrMaps = {
        {AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID, ERROR_MSG_INVALID_PARAM},
        {AICPU_SCHEDULE_ERROR_DRV_ERR, ERROR_MSG_DRV_ERROR},
        {AICPU_SCHEDULE_ERROR_CGROUP_FAILED, ERROR_MSG_CGROUP_FAILED},
        {AICPU_SCHEDULE_ERROR_INIT_FAILED, ERROR_MSG_AICPU_INIT_FAILED}
    };
    std::string errStr = ERROR_MSG_AICPU_INIT_FAILED;
    const auto &iter = errStrMaps.find(errCode);
    if (iter != errStrMaps.end()) {
        errStr = iter->second;
    }

    const int32_t ret = TsdReportStartOrStopErrCode(tsdEventKey_.deviceId, TSD_COMPUTE, tsdEventKey_.hostPid,
                                                    tsdEventKey_.vfId, errStr.c_str(),
                                                    static_cast<uint32_t>(errStr.size()));
    if (ret != 0) {
        aicpusd_err("ReportErrorMsgToTsd failed. ret=%d", ret);
    }
}

bool SubModuleInterface::AttachHostGroup(const ArgsParser &startParas)
{
    // Only attach group which is in aicpu group but not in qs group
    std::vector<std::string> grpNameList = startParas.GetGrpNameList();
    const std::vector<std::string> qsGrpNameList = startParas.GetQsGrpNameList();
    for (const auto &key : qsGrpNameList) {
        const auto iter = std::remove(grpNameList.begin(), grpNameList.end(), key);
        grpNameList.erase(iter, grpNameList.end());
    }

    const uint32_t grpNameNum = startParas.GetGrpNameNum();
    if ((grpNameNum == 0U) || (grpNameList.size() == 0UL)) {
        aicpusd_info("There is no group need to be attached");
        return true;
    }

    if (static_cast<uint32_t>(grpNameList.size()) > grpNameNum) {
        aicpusd_err("Aicpu start failed. Wrong parameters of groupNum[%d] with empty group name", grpNameNum);
        return false;
    }

    for (const std::string &iter : grpNameList) {
        const auto drvRet = halGrpAttach(iter.c_str(), -1);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("halGrpAttach group[%s] failed. ret[%d]", iter.c_str(), drvRet);
            return false;
        }
        aicpusd_run_info("halGrpAttach group[%s] success.", iter.c_str());
    }

    return true;
}

void SubModuleInterface::SendPidQosMsgToTsd(const uint32_t pidQos) const
{
    TsdCapabilityMsgInfo qosPidMsg;
    qosPidMsg.subCapabityType = TSD_EVENT_GET_CAPABILITY;
    qosPidMsg.resultInfo = pidQos;
    ReportMsgToTsd(tsdEventKey_.deviceId, TSD_COMPUTE, tsdEventKey_.hostPid, tsdEventKey_.vfId,
                   PtrToPtr<TsdCapabilityMsgInfo, const char_t>(&qosPidMsg));
}

int32_t SubModuleInterface::SendSubModuleRsponse(const uint32_t eventType) const
{
    return SubModuleProcessResponse(tsdEventKey_.deviceId, TSD_COMPUTE, tsdEventKey_.hostPid,
                                    tsdEventKey_.vfId, eventType);
}
} // namespace AicpuSchedule

extern "C" {
int32_t StartAicpuSchedulerModule(const struct TsdSubEventInfo *const eventInfo)
{
    return AicpuSchedule::SubModuleInterface::GetInstance().StartAicpuSchedulerModule(eventInfo);
}

int32_t StopAicpuSchedulerModule(const struct TsdSubEventInfo *const eventInfo)
{
    return AicpuSchedule::SubModuleInterface::GetInstance().StopAicpuSchedulerModule(eventInfo);
}
}
