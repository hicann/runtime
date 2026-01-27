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
#include <sstream>
#include <unistd.h>
#include "bqs_util.h"
#include "queue_schedule_sub_module_interface.h"
#include "bqs_log.h"
#include "driver/ascend_hal.h"
#include "queue_schedule/qs_client.h"
#include "qs_interface_process.h"

namespace bqs {
namespace {
constexpr uint32_t MAX_PARAM_NUM = 12U;
const std::string ENV_NAME_REG_ASCEND_MONITOR = "REGISTER_TO_ASCENDMONITOR";
} // namespace

void SubModuleInterface::SetTsdEventKey(const struct TsdSubEventInfo * const eventInfo)
{
    tsdEventKey_.deviceId = eventInfo->deviceId;
    tsdEventKey_.hostPid = eventInfo->hostPid;
    tsdEventKey_.vfId = eventInfo->vfId;
}

std::string SubModuleInterface::BuildArgsFilePath() const
{
    const uint32_t curPid = static_cast<uint32_t>(getpid());
    const std::string fileName = "queue_schedule_start_param_" + std::to_string(tsdEventKey_.deviceId) +
                                 "_" + std::to_string(tsdEventKey_.vfId) + "_" + std::to_string(curPid);
    std::string pathFreFix = "/home/HwHiAiUser/";
    std::string inputStr;
    GetEnvVal(ENV_NAME_REG_ASCEND_MONITOR, inputStr);
    if (inputStr == "0") {
        pathFreFix = "/home/mdc/";
    }

    return pathFreFix.append(fileName);
}

void SubModuleInterface::DeleteArgsFile(const std::string &argsFilePath)
{
    const int32_t ret = remove(argsFilePath.c_str());
    if (ret != 0) {
        BQS_LOG_ERROR("Remove file[%s] failed, ret=%d, reason=%s", argsFilePath.c_str(), ret, strerror(errno));
        return;
    }

    BQS_LOG_RUN_INFO("Remove file[%s] success", argsFilePath.c_str());
}

bool SubModuleInterface::ParseArgsFromFile(ArgsParser &startParams) const
{
    const std::string argsFilePath = BuildArgsFilePath();
    ScopeGuard fileDelGuard([&argsFilePath] () { DeleteArgsFile(argsFilePath); });

    std::ifstream argsFile;
    argsFile.open(argsFilePath, std::ifstream::in);
    if (!argsFile.is_open()) {
        BQS_LOG_ERROR("Start file[%s] open failed, reason=%s", argsFilePath.c_str(), strerror(errno));
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

    return startParams.ParseArgs(fileLines);
}

bool SubModuleInterface::QsSubModuleAttachGroup(const ArgsParser &startParams)
{
    BQS_LOG_INFO("Begin to attach group.");
    if (!startParams.GetWithGroupName()) {
        BQS_LOG_INFO("withGroupName is false, no need attach now.");
        return true;
    }

    std::string groupNameList = startParams.GetGroupName();
    if (groupNameList.empty()) {
        BQS_LOG_INFO("grpName is empty.");
        return true;
    }
    std::stringstream grpNameStream(groupNameList);
    std::string grpNameElement;
    std::vector<std::string> groupNameVec;
    while (getline(grpNameStream, grpNameElement, ',')) {
        groupNameVec.emplace_back(grpNameElement);
    }
    // if run context is host, halGrpAttach time out cannot be 0
    const int32_t halTimeOut = (bqs::GetRunContext() == bqs::RunContext::HOST) ? 3000 : -1;
    for (const auto &grpName : groupNameVec) {
        const auto drvRet = halGrpAttach(grpName.c_str(), halTimeOut);
        if (drvRet != DRV_ERROR_NONE) {
            BQS_LOG_ERROR("halGrpAttach group[%s] failed. ret[%d]", grpName.c_str(), drvRet);
            return false;
        }
        BQS_LOG_RUN_INFO("halGrpAttach group[%s] success.", grpName.c_str());
    }
    return true;
}

void SubModuleInterface::QsSubModuleInitQsInitParams(InitQsParams &initQsParams, const ArgsParser &startParams)
{
    initQsParams.deviceId = startParams.GetDeviceId();
    initQsParams.enqueGroupId = EventGroupId::ENQUEUE_GROUP_ID;
    initQsParams.f2nfGroupId = EventGroupId::F2NF_GROUP_ID;
    initQsParams.reschedInterval = static_cast<uint32_t>(startParams.GetReschedInterval());
    initQsParams.runMode = startParams.GetDeployMode();
    initQsParams.pid = startParams.GetHostPid();
    initQsParams.vfId = startParams.GetVfId();
    initQsParams.pidSign = startParams.GetPidSign();
    initQsParams.qsInitGrpName = startParams.GetGroupName();
    initQsParams.schedPolicy = startParams.GetSchedPolicy();
    initQsParams.starter = startParams.GetStarter();
    initQsParams.profCfgData = startParams.GetProfCfgData();
    initQsParams.profFlag = startParams.GetProfFlag();
    initQsParams.abnormalInterVal = static_cast<uint32_t>(startParams.GetAbnormalInterval());
}

int32_t SubModuleInterface::SendSubModuleRsponse(const uint32_t eventType) const
{
    return SubModuleProcessResponse(tsdEventKey_.deviceId, TSD_QS, tsdEventKey_.hostPid,
                                    tsdEventKey_.vfId, eventType);
}

void SubModuleInterface::ReportErrMsgToTsd(const int32_t errCode) const
{
    BQS_LOG_RUN_WARN("ReportErrorMsg errcode is %d.", errCode);
    std::string errStr;
    switch (errCode) {
        case BqsStatus::BQS_STATUS_ATTACH_GROUP_FALED: {
            errStr = ERROR_MSG_ATTACH_GROUP_FAILED;
            break;
        }
        default: {
            errStr = ERROR_MSG_QS_INIT_FAILED;
            break;
        }
    }
    BQS_LOG_RUN_WARN("ReportErrorMsg msg is %s.", errStr.c_str());
    (void) TsdReportStartOrStopErrCode(tsdEventKey_.deviceId, TSD_QS, tsdEventKey_.hostPid,
                                       tsdEventKey_.vfId, errStr.c_str(),
                                       static_cast<uint32_t>(errStr.size()));
}

int32_t SubModuleInterface::StartQueueScheduleModule(const struct TsdSubEventInfo * const eventInfo)
{
    BQS_LOG_RUN_INFO("enter queue schedule sub module start process.");
    // set event key
    SetTsdEventKey(eventInfo);

    // args parse
    ArgsParser startParams;
    if (!ParseArgsFromFile(startParams)) {
        BQS_LOG_ERROR("Read aicpu submodule start paras from file failed");
        return -1;
    }

    if (!QsSubModuleAttachGroup(startParams)) {
        BQS_LOG_ERROR("AttachHostGroup error");
        ReportErrMsgToTsd(BqsStatus::BQS_STATUS_ATTACH_GROUP_FALED);
        return -1;
    }

    auto& qsInterface = QueueScheduleInterface::GetInstance();

    bqs::InitQsParams initQsParams = {};
    QsSubModuleInitQsInitParams(initQsParams, startParams);
    const auto bsqStatus = qsInterface.InitQueueScheduler(initQsParams);
    if (bsqStatus != bqs::BQS_STATUS_OK) {
        BQS_LOG_ERROR("QueueSchedule start failed, ret=%d.", bsqStatus);
        ReportErrMsgToTsd(bsqStatus);
        return -1;
    }

    BQS_LOG_RUN_INFO("QueueSchedule init finished.");

    const int32_t rspRet = SendSubModuleRsponse(TSD_EVENT_START_QS_MODULE_RSP);
    if (rspRet != 0) {
        BQS_LOG_ERROR("Tsd wait for shut down return not ok, error code[%d].", rspRet);
        return -1;
    }

    startFlag_ = true;
    BQS_LOG_RUN_INFO("queue schedule sub module start success");
    return rspRet;
}

int32_t SubModuleInterface::StopQueueScheduleModule(const struct TsdSubEventInfo * const eventInfo)
{
    (void)eventInfo;
    BQS_LOG_RUN_INFO("enter queue schedule sub module stop process.");
    if (!startFlag_.load()) {
        BQS_LOG_RUN_INFO("no need to stop qs submodule.");
        return 0;
    }

    auto& qsInterface = QueueScheduleInterface::GetInstance();
    qsInterface.WaitForStop();
    (void)qsInterface.Destroy();
    BQS_LOG_RUN_INFO("queue schedule stopped.");
    const int32_t rspRet = SendSubModuleRsponse(TSD_EVENT_STOP_QS_MODULE_RSP);
    if (rspRet != 0) {
        BQS_LOG_ERROR("queue schedule stop response return not ok, error code[%d].", rspRet);
        return -1;
    }

    startFlag_ = false;
    BQS_LOG_RUN_INFO("queue schedule sub module stop success");
    return rspRet;
}
} // namespace bqs

extern "C" {
int32_t StartQueueScheduleModule(const struct TsdSubEventInfo *const eventInfo)
{
    return bqs::SubModuleInterface::GetInstance().StartQueueScheduleModule(eventInfo);
}

int32_t StopQueueScheduleModule(const struct TsdSubEventInfo *const eventInfo)
{
    return bqs::SubModuleInterface::GetInstance().StopQueueScheduleModule(eventInfo);
}
}