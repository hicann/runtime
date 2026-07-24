/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/tsd_process_controller.h"
#include <sstream>
#include <string>
#include <vector>
#include <chrono>
#include <memory>
#include "error_manager.h"
#include "tsd_log.h"
#include "tsd/status.h"
#include "tsd_util_func.h"
#include "env_internal_api.h"
#include "hdc_message_builder.h"
#include "weak_ascend_hal.h"
#include "driver/ascend_hal.h"
#include "common/type_def.h"

namespace {
constexpr uint32_t DEFAULT_QS_RANKSIZE = 0U;
constexpr uint32_t ASAN_OPEN_TIMEOUT = 3600000U;
constexpr uint32_t MAX_QUEUE_ID_NUM = 8192U;
} // namespace

namespace tsd {

TsdProcessController::TsdProcessController(
    DeviceCommAgent& commAgent, CapabilityManager& capabilityMgr, PackageManager& packageMgr,
    ProcessSharedContext& sharedCtx, uint32_t aicpuDeviceMode)
    : commAgent_(commAgent),
      capabilityMgr_(capabilityMgr),
      packageMgr_(packageMgr),
      sharedCtx_(sharedCtx),
      aicpuDeviceMode_(aicpuDeviceMode)
{}

TSD_StatusT TsdProcessController::Open(const uint32_t rankSize)
{
    if (sharedCtx_.isAdcEnv) {
        TSD_INFO("skip to start aicpu-sd process.");
        return TSD_OPEN_NOT_SUPPORT_FOR_ADC;
    }
    return OpenProcess(rankSize);
}

TSD_StatusT TsdProcessController::OpenAicpuSd() { return OpenProcess(0U); }

TSD_StatusT TsdProcessController::OpenProcess(const uint32_t rankSize)
{
    TSD_RUN_INFO(
        "[ProcessModeManager] enter into open process deviceId[%u] rankSize[%u]", sharedCtx_.logicDeviceId, rankSize);
    TsdStartStatusInfo startInfo = {};
    const TimePoint beginOpen = std::chrono::high_resolution_clock::now();
    if (!CheckNeedToOpen(rankSize, startInfo)) {
        TSD_INFO("Open has already been done before.");
        return TSD_OK;
    }

    TSD_StatusT ret = LoadPackagesToDevice();
    TSD_CHECK(ret == TSD_OK, ret, "Load packages to device failed.");

    ret = InitTsdClient();
    TSD_CHECK(ret == TSD_OK, ret, "Init hdc client failed.");
    startInfo.startQs_ = false;
    ret = SendOpenMsg(rankSize, startInfo);
    TSD_CHECK(ret == TSD_OK, ret, "Send open message to device failed.");
    const TimePoint finSendOpenMsg = std::chrono::high_resolution_clock::now();

    ret = WaitOpenRsp(rankSize);
    if (ret != TSD_OK) {
        return ret;
    }
    const TimePoint finRecvRsp = std::chrono::high_resolution_clock::now();
    SetTsdStartInfo(startInfo.startCp_, startInfo.startHccp_, false);

    ret = ProcessQueueForAdc();
    if (ret != TSD_OK) {
        TSD_ERROR("ProcessQueueForAdc error");
        return ret;
    }
    const TimePoint finOpen = std::chrono::high_resolution_clock::now();
    LogOpenProcessDuration(beginOpen, finSendOpenMsg, finRecvRsp, finOpen);
    return TSD_OK;
}

TSD_StatusT TsdProcessController::LoadPackagesToDevice()
{
    TSD_StatusT ret = packageMgr_.LoadPackageConfigInfoToDevice(true);
    TSD_CHECK(ret == TSD_OK, ret, "Load package config info to device failed.");

    ret = packageMgr_.LoadSysOpKernel();
    TSD_CHECK(ret == TSD_OK, ret, "Send aicpu package to device failed.");

    ret = packageMgr_.LoadPackageToDeviceByConfig();
    TSD_CHECK(ret == TSD_OK, ret, "Load package to device by config failed");
    return TSD_OK;
}

TSD_StatusT TsdProcessController::WaitOpenRsp(const uint32_t rankSize)
{
    TSD_RUN_INFO(
        "[ProcessModeManager] deviceId[%u] sessionId[%u] rankSize[%u], wait subprocess start response",
        sharedCtx_.logicDeviceId, commAgent_.GetSessionId(), rankSize);
    const TSD_StatusT ret = IsAsanMmSysEnv() ? WaitRsp(ASAN_OPEN_TIMEOUT) : WaitRsp(0U);
    if (ret != TSD_OK) {
        REPORT_INPUT_ERROR("E39007", std::vector<std::string>(), std::vector<std::string>());
        TSD_ERROR("Wait open response from device failed.");
    }
    return ret;
}

void TsdProcessController::LogOpenProcessDuration(
    const TimePoint& beginOpen, const TimePoint& finSendOpenMsg, const TimePoint& finRecvRsp,
    const TimePoint& finOpen) const
{
    TSD_RUN_INFO(
        "[TsdClient][deviceId=%u] [sessionId=%u] start hccp and computer process success,"
        "phase4:[%zu]ms send open message to device,"
        "phase5:[%zu]ms receive open message to device,"
        "phase6:[%zu]ms process for adc on host,"
        "whole duration:[%zu]ms",
        sharedCtx_.logicDeviceId, commAgent_.GetSessionId(),
        std::chrono::duration_cast<std::chrono::milliseconds>(finSendOpenMsg - beginOpen).count(),
        std::chrono::duration_cast<std::chrono::milliseconds>(finRecvRsp - finSendOpenMsg).count(),
        std::chrono::duration_cast<std::chrono::milliseconds>(finOpen - finRecvRsp).count(),
        std::chrono::duration_cast<std::chrono::milliseconds>(finOpen - beginOpen).count());
}

TSD_StatusT TsdProcessController::ConstructCloseMsg(HDCMessage& msg)
{
    return HdcMessageBuilder::BuildClose(msg, BuildBaseMessageContext());
}

TSD_StatusT TsdProcessController::Close(const uint32_t flag)
{
    if (!commAgent_.IsInit()) {
        TSD_RUN_INFO("[TsdClient] tsd client no need to close");
        return TSD_OK;
    }
    TSD_CHECK_NULLPTR(
        commAgent_.GetDeviceComm(), TSD_INSTANCE_NOT_INITIALED, "[TsdClient] devCommClient_ is null in Close function");
    TsdCloseFlag tsdCloseFlag = {};
    ParseTsdCloseFlag(flag, tsdCloseFlag);
    if (tsdCloseFlag.quickCloseFlag != QUICK_CLOSE_MODE) {
        TSD_RUN_INFO(
            "[TsdClient] Close [deviceId=%u][sessionId=%u] hccp and computer enter", sharedCtx_.logicDeviceId,
            commAgent_.GetSessionId());
        TSD_StatusT ret = SendCloseMsg();
        TSD_CHECK(ret == TSD_OK, ret, "Send close message to device failed.");
        TSD_RUN_INFO(
            "[TsdClient][deviceId=%u] [sessionId=%u] wait hccp and computer process close response",
            sharedCtx_.logicDeviceId, commAgent_.GetSessionId());
        ret = WaitRsp(0U, false, true);
        TSD_CHECK(ret == TSD_OK, ret, "Wait open response from device failed.");
        TSD_RUN_INFO(
            "[TsdClient][logicDeviceId_=%u]has recv close hccp and computer process response",
            sharedCtx_.logicDeviceId);
    } else {
        TSD_RUN_INFO("Enable quick tsd close, close will only in host.");
    }

    commAgent_.ReleaseDeviceConnection();
    sharedCtx_.rspCode = ResponseCode::FAIL;
    isStartedHccp_ = false;
    hccpPid_ = 0;
    SetTsdStartInfo(false, false, false);
    packageMgr_.ResetOnClose();
    TSD_RUN_INFO(
        "[TsdClient][deviceId=%u] [sessionId=%u] close hccp and "
        "computer process success",
        sharedCtx_.logicDeviceId, commAgent_.GetSessionId());
    return TSD_OK;
}

TSD_StatusT TsdProcessController::WaitRsp(const uint32_t timeout, const bool ignoreRecvErr, const bool isClose)
{
    const TSD_StatusT ret = commAgent_.RecvData(ignoreRecvErr, timeout);
    if (!sharedCtx_.isAdcEnv) {
        if (isClose && (ret == TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED)) {
            TSD_RUN_INFO("close rsp not receive, server close the session");
            return TSD_OK;
        }
    }
    if ((ret != TSD_OK) || (static_cast<uint32_t>(sharedCtx_.rspCode) != 0U)) {
        const std::string reportMsg = BuildWaitRspErrReport(ret);
        if (!ignoreRecvErr) {
            TSD_ERROR("%s", reportMsg.c_str());
            TSD_REPORT_INNER_ERROR("%s", reportMsg.c_str());
        }
        if ((ret == TSD_OK) && (!sharedCtx_.startOrStopFailCode.empty())) {
            REPORT_INPUT_ERROR(
                sharedCtx_.startOrStopFailCode.c_str(), std::vector<std::string>(), std::vector<std::string>());
        }
        return MapFailCodeToStatus();
    }
    return TSD_OK;
}

TSD_StatusT TsdProcessController::MapFailCodeToStatus() const
{
    if (sharedCtx_.startOrStopFailCode == "E30003") {
        return TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT;
    } else if (sharedCtx_.startOrStopFailCode == "E30004") {
        return TSD_SUBPROCESS_BINARY_FILE_DAMAGED;
    } else if (sharedCtx_.startOrStopFailCode == "E30006") {
        return TSD_VERIFY_OPP_FAIL;
    } else if (sharedCtx_.startOrStopFailCode == "E30007") {
        return TSD_ADD_AICPUSD_TO_CGROUP_FAILED;
    } else {
        return TSD_CLT_OPEN_FAILED;
    }
}

std::string TsdProcessController::BuildWaitRspErrReport(const TSD_StatusT recvRet) const
{
    std::ostringstream reportMsg;
    reportMsg << "tsd client wait response fail, hostpid:" << static_cast<uint32_t>(commAgent_.GetProcSign().tgid);
    if (recvRet != TSD_OK) {
        reportMsg << ", receive device response data failed, check hdc service.";
    } else {
        reportMsg << ", device response code[" << static_cast<uint32_t>(sharedCtx_.rspCode) << "]";
        if (!sharedCtx_.errMsg.empty()) {
            reportMsg << ". " << sharedCtx_.errMsg;
            reportMsg << ", error stack:\n" << sharedCtx_.errorLog;
        } else {
            reportMsg << ". unknown device error.";
        }
    }
    return reportMsg.str();
}

TSD_StatusT TsdProcessController::InitTsdClient()
{
    if (commAgent_.IsInit()) {
        TSD_INFO("[TsdClient] tsd client has already been initialized");
        return TSD_OK;
    }
    return commAgent_.InitTsdClient(sharedCtx_.isAdcEnv);
}

MessageContext TsdProcessController::BuildBaseMessageContext() const
{
    MessageContext ctx{};
    ctx.logicDeviceId = sharedCtx_.logicDeviceId;
    ctx.rankSize = rankSize_;
    ctx.procSign = commAgent_.GetProcSign();
    ctx.profilingMode = static_cast<uint32_t>(sharedCtx_.profilingMode);
    ctx.logLevel = sharedCtx_.logLevel;
    ctx.ccecpuLogLevel = sharedCtx_.ccecpuLogLevel;
    ctx.aicpuLogLevel = sharedCtx_.aicpuLogLevel;
    ctx.aicpuKernelCheckCode = packageMgr_.GetHostCheckCode(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL);
    ctx.aicpuExtendKernelCheckCode = packageMgr_.GetHostCheckCode(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL);
    ctx.ascendcppCheckCode = packageMgr_.GetHostCheckCode(TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP);
    ctx.aicpuDeviceMode = aicpuDeviceMode_;
    ctx.aicpuSchedMode = static_cast<SchedMode>(sharedCtx_.aicpuSchedMode);
    ctx.qsInitGroupName = qsInitGrpName_;
    ctx.schedPolicy = schedPolicy_;
    return ctx;
}

TSD_StatusT TsdProcessController::ConstructOpenMsg(HDCMessage& hdcMsg, const TsdStartStatusInfo& startInfo)
{
    MessageContext ctx = BuildBaseMessageContext();
    ctx.startHccp = startInfo.startHccp_;
    ctx.startCp = startInfo.startCp_;
    return HdcMessageBuilder::BuildOpen(hdcMsg, ctx);
}

TSD_StatusT TsdProcessController::SendOpenMsg(const uint32_t rankSize, const TsdStartStatusInfo startInfo)
{
    rankSize_ = rankSize;
    HDCMessage hdcMsg;
    if (ConstructOpenMsg(hdcMsg, startInfo) != TSD_OK) {
        TSD_ERROR("ConstructOpenMsg open msg error");
        return TSD_CLT_OPEN_FAILED;
    }
    if (startInfo.startQs_) {
        hdcMsg.set_type(HDCMessage::TSD_START_QS_MSG);
        qsInitGroupName* const groupName = hdcMsg.mutable_qs_init_group_name();
        if (groupName == nullptr) {
            return TSD_INTERNAL_ERROR;
        }
        groupName->set_qs_init_group_name(qsInitGrpName_);
        hdcMsg.set_sched_policy(schedPolicy_);
        std::string installPath;
        packageMgr_.GetAscendLatestIntallPath(installPath);
        if (!installPath.empty()) {
            hdcMsg.set_ascend_install_path(installPath);
        }
    } else {
        hdcMsg.set_type(HDCMessage::TSD_START_PROC_MSG);
        if (isStartedHccp_) {
            hdcMsg.set_start_hccp(true);
        }
    }
    const TSD_StatusT ret = commAgent_.SendMsg(hdcMsg);
    if (ret != TSD_OK) {
        TSD_ERROR(
            "[TsdClient][deviceId=%u][rankSize_=%u][procpid =%u] "
            "tsdclient start hccp and computer process failed",
            sharedCtx_.logicDeviceId, rankSize_, static_cast<uint32_t>(commAgent_.GetProcSign().tgid));
        return TSD_CLT_OPEN_FAILED;
    }
    return TSD_OK;
}

TSD_StatusT TsdProcessController::SendCloseMsg()
{
    HDCMessage msg;
    if (ConstructCloseMsg(msg) != TSD_OK) {
        TSD_ERROR("ConstructCloseMsg failed");
        return TSD_INTERNAL_ERROR;
    }
    const TSD_StatusT ret = commAgent_.SendMsg(msg);
    if (ret != TSD_OK) {
        TSD_ERROR(
            "[TsdClient][deviceId=%u] tsdclient close hccp and "
            "computer process failed",
            sharedCtx_.logicDeviceId);
        return TSD_CLT_CLOSE_FAILED;
    }

    return TSD_OK;
}

TSD_StatusT TsdProcessController::UpdateProfilingConf(const uint32_t& flag)
{
    TSD_RUN_INFO(
        "[TsdClient] Update profiling mode [deviceId=%u][sessionId=%u][flag=%u]", sharedCtx_.logicDeviceId,
        commAgent_.GetSessionId(), flag);

    if (!commAgent_.IsInit()) {
        TSD_WARN("[TsdClient] tsd client need open first");
        return TSD_OK;
    }
    TSD_CHECK_NULLPTR(
        commAgent_.GetDeviceComm(), TSD_INSTANCE_NOT_INITIALED,
        "[TsdClient] devCommClient_ is null in update profiling function");
    TSD_StatusT ret = SendUpdateProfilingMsg(flag);
    TSD_CHECK(ret == TSD_OK, ret, "Send profiling message to tsdaemon failed.");

    TSD_RUN_INFO(
        "[TsdClient][deviceId=%u] [sessionId=%u] wait update profiling msg response", sharedCtx_.logicDeviceId,
        commAgent_.GetSessionId());

    ret = WaitRsp(0U);
    TSD_CHECK(ret == TSD_OK, ret, "Wait UpdateProfiling response from device failed.");
    return TSD_OK;
}

TSD_StatusT TsdProcessController::SendUpdateProfilingMsg(const uint32_t flag)
{
    HDCMessage msg;
    MessageContext ctx = BuildBaseMessageContext();
    ctx.profilingMode = flag;
    if (HdcMessageBuilder::BuildUpdateProfiling(msg, ctx) != TSD_OK) {
        return TSD_INTERNAL_ERROR;
    }
    const TSD_StatusT ret = commAgent_.SendMsg(msg);
    if (ret != TSD_OK) {
        TSD_ERROR("[TsdClient][deviceId=%u] tsdclient update profiling mode failed", sharedCtx_.logicDeviceId);
        return TSD_CLT_UPDATE_PROFILING_FAILED;
    }

    return TSD_OK;
}

TSD_StatusT TsdProcessController::GetHdcConctStatus(int32_t& hdcSessStat)
{
    return commAgent_.GetHdcConctStatus(hdcSessStat, sharedCtx_.isAdcEnv);
}

TSD_StatusT TsdProcessController::InitQs(const InitFlowGwInfo* const initInfo)
{
    TSD_RUN_INFO(
        "[ProcessModeManager][logicDeviceId_=%u] begin to prepare send open message", sharedCtx_.logicDeviceId);
    if (initInfo == nullptr) {
        TSD_ERROR("TsdInitQs failed, initInfo is nullptr.");
        return tsd::TSD_INTERNAL_ERROR;
    }

    const char_t* const groupName = initInfo->groupName;
    if (tsdStartStatus_.startQs_) {
        TSD_INFO("[ProcessModeManager] QS has opened already, no need open again");
        return TSD_OK;
    }
    TSD_StatusT ret = InitTsdClient();
    TSD_CHECK(ret == TSD_OK, ret, "Init hdc client failed.");

    if (groupName != nullptr) {
        TSD_INFO("[TsdClient]QS open with group[%s]", groupName);
        qsInitGrpName_ = groupName;
    } else {
        TSD_INFO("[TsdClient]QS open with empty groupName");
        qsInitGrpName_.clear();
    }
    schedPolicy_ = initInfo->schedPolicy;

    constexpr TsdStartStatusInfo startInfo = {false, false, true};
    ret = SendOpenMsg(DEFAULT_QS_RANKSIZE, startInfo);
    TSD_CHECK(ret == TSD_OK, ret, "Send InitQs message to device failed.");

    ret = WaitRsp(0U);
    TSD_CHECK(ret == TSD_OK, ret, "Wait InitQs response from device failed.");

    tsdStartStatus_.startQs_ = true;
    TSD_RUN_INFO(
        "[TsdClient][logicDeviceId_=%u] [sessionId=%u] start QS process success", sharedCtx_.logicDeviceId,
        commAgent_.GetSessionId());
    return TSD_OK;
}

void TsdProcessController::SetTsdStartInfo(const bool cpStatus, const bool hccpStatus, const bool qsStatus)
{
    tsdStartStatus_.startCp_ = cpStatus;
    tsdStartStatus_.startHccp_ = hccpStatus;
    tsdStartStatus_.startQs_ = qsStatus;
    capabilityMgr_.SetStartCpStatus(cpStatus);
}

bool TsdProcessController::CheckNeedToOpen(const uint32_t rankSize, TsdStartStatusInfo& startInfo)
{
    constexpr uint32_t HCCP_START_RANK_SIZE = 1U;
    if (rankSize <= HCCP_START_RANK_SIZE) {
        if (tsdStartStatus_.startCp_) {
            TSD_INFO("[TsdClient] cp has already opened, no need open again");
            return false;
        } else {
            startInfo.startHccp_ = false;
            startInfo.startCp_ = true;
        }
    } else {
        if ((tsdStartStatus_.startCp_) && (tsdStartStatus_.startHccp_)) {
            TSD_INFO("[TsdClient] hccp and cp has already opened, no need open again");
            return false;
        }
        startInfo.startCp_ = true;
        startInfo.startHccp_ = true;
    }
    TSD_INFO(
        "[TsdClient] get open para startCp[%u] startHccp[%u] (0:false 1:true)",
        static_cast<uint32_t>(startInfo.startCp_), static_cast<uint32_t>(startInfo.startHccp_));
    return true;
}

void TsdProcessController::ParseTsdCloseFlag(const uint32_t flag, TsdCloseFlag& tsdCloseFlag) const
{
    TSD_RUN_INFO("Parse tsd close flag [%u]", flag);
    tsdCloseFlag.quickCloseFlag = TSD_BITMAP_GET(flag, 0U);
    return;
}

TSD_StatusT TsdProcessController::ProcessQueueForAdc()
{
    if ((sharedCtx_.platInfoMode != static_cast<uint32_t>(ModeType::OFFLINE)) || !sharedCtx_.isAdcEnv) {
        TSD_RUN_INFO(
            "[TsdClient] it is unnecessary for current mode[%u] to grant queue auth to aicpusd",
            static_cast<uint32_t>(ModeType::OFFLINE));
        return TSD_OK;
    }
    const auto ret = SyncQueueAuthority();
    if (ret != TSD_OK) {
        constexpr uint32_t flag = 0;
        const auto closeRet = Close(flag);
        if (closeRet != TSD_OK) {
            TSD_RUN_WARN("[TsdClient]Sync queue authority failed, call close failed!");
            return closeRet;
        }
        TSD_RUN_WARN("[TsdClient]Sync queue authority failed, call close success!");
        return ret;
    }
    return TSD_OK;
}

TSD_StatusT TsdProcessController::ProcessQueueGrant(
    const QueueQueryOutputPara& queueInfoOutBuff, const QueueQueryOutput* const queueInfoList,
    const pid_t aicpuPid) const
{
    const uint32_t outLen = queueInfoOutBuff.outLen;
    if (outLen == 0U) {
        TSD_RUN_INFO("[TsdClient] Current process does not create queue yet. need not to sync");
        return TSD_OK;
    }
    if ((outLen % sizeof(queueInfoList->queQueryQuesOfProcInfo[0U])) != 0U) {
        TSD_ERROR("[TsdClient] QueueInfo outbuff size[%d] is invalid", outLen);
        return TSD_INTERNAL_ERROR;
    }
    const uint32_t queueNum = static_cast<uint32_t>(outLen / sizeof(queueInfoList->queQueryQuesOfProcInfo[0U]));
    TSD_RUN_INFO("[TsdClient] ProcessQueueGrant queueNum[%u]", queueNum);
    for (uint32_t i = 0U; i < queueNum; ++i) {
        const uint32_t queueId = static_cast<uint32_t>(queueInfoList->queQueryQuesOfProcInfo[i].qid);
        if (queueId >= MAX_QUEUE_ID_NUM) {
            TSD_ERROR("Get invalid queueid[%d]", queueId);
            return TSD_INTERNAL_ERROR;
        }
        if (!static_cast<bool>(queueInfoList->queQueryQuesOfProcInfo[i].attr.manage)) {
            continue;
        }
        const auto drvRet = halQueueGrant(
            sharedCtx_.logicDeviceId, static_cast<int32_t>(queueId), aicpuPid,
            queueInfoList->queQueryQuesOfProcInfo[i].attr);
        if ((drvRet != DRV_ERROR_NONE) && (drvRet != DRV_ERROR_NOT_SUPPORT)) {
            TSD_ERROR("[TsdClient]Grant qid[%u] failed, ret[%d]", queueId, drvRet);
            return TSD_INTERNAL_ERROR;
        }
    }
    TSD_RUN_INFO("[TsdClient] ProcessQueueGrant process success");
    return TSD_OK;
}

TSD_StatusT TsdProcessController::SyncQueueAuthority() const
{
    TSD_RUN_INFO("[TsdClient] Current type is ADC. Sync queue auth start.");
    auto drvRet = halQueueInit(sharedCtx_.logicDeviceId);
    if ((drvRet != DRV_ERROR_NONE) && (drvRet != DRV_ERROR_REPEATED_INIT) && (drvRet != DRV_ERROR_NOT_SUPPORT)) {
        TSD_ERROR("[TsdClient] halQueueInit error, drvRet[%d]", drvRet);
        return TSD_INTERNAL_ERROR;
    }
    TSD_RUN_INFO("[TsdClient]Interface halQueueInit success.");
    pid_t aicpuPid = -1;
    const auto ret = GetAicpusdPid(aicpuPid);
    if ((aicpuPid == -1) || (ret != TSD_OK)) {
        return ret;
    }
    pid_t srcPid = drvDeviceGetBareTgid();
    std::unique_ptr<QueueQueryOutput> queueInfoListPtr(new (std::nothrow) QueueQueryOutput());
    if (queueInfoListPtr == nullptr) {
        TSD_ERROR("[TsdClient] fail to alloc queueInfoListPtr");
        return TSD_INTERNAL_ERROR;
    }
    QueueQueryOutput* queueInfoList = queueInfoListPtr.get();
    if (queueInfoList == nullptr) {
        TSD_ERROR("[TsdClient] queueInfoList is null");
        return TSD_INTERNAL_ERROR;
    }
    QueueQueryOutputPara queueInfoOutBuff = {
        PtrToPtr<QueueQueryOutput, void>(queueInfoList), static_cast<uint32_t>(sizeof(QueueQueryOutput))};
    QueueQueryInputPara queueInput = {PtrToPtr<pid_t, void>(&srcPid), static_cast<uint32_t>(sizeof(srcPid))};
    drvRet = halQueueQuery(sharedCtx_.logicDeviceId, QUEUE_QUERY_QUES_OF_CUR_PROC, &queueInput, &queueInfoOutBuff);
    if (drvRet == DRV_ERROR_NOT_SUPPORT) {
        TSD_RUN_INFO("[TsdClient] halQueueQuery is not supported in current chip type.");
        return TSD_OK;
    }
    if (drvRet != DRV_ERROR_NONE) {
        TSD_ERROR("[TsdClient] halQueueQuery execute failed, ret[%d]", drvRet);
        return TSD_INTERNAL_ERROR;
    }

    return ProcessQueueGrant(queueInfoOutBuff, queueInfoList, aicpuPid);
}

TSD_StatusT TsdProcessController::GetAicpusdPid(pid_t& aicpusdPid) const
{
    aicpusdPid = -1;
    const pid_t srcPid = drvDeviceGetBareTgid();
    if (&halQueryDevpid == nullptr) {
        TSD_RUN_INFO("[TsdClient] halQueryDevpid is nullptr, interface is not supported in current version.");
        return TSD_OK;
    }
    halQueryDevpidInfo para = {};
    para.hostpid = srcPid;
    para.proc_type = DEVDRV_PROCESS_CP1;
    para.vfid = 0U;
    para.devid = sharedCtx_.logicDeviceId;
    const auto drvRet = halQueryDevpid(para, &aicpusdPid);
    if (drvRet == DRV_ERROR_NOT_SUPPORT) {
        TSD_RUN_INFO("[TsdClient] halQueryDevpid is not supported in current chip type.");
        return TSD_OK;
    }
    if ((drvRet != DRV_ERROR_NONE) || (aicpusdPid == -1)) {
        TSD_ERROR("[TsdClient]Get aicpusd pid failed, result[%d]", drvRet);
        return TSD_INTERNAL_ERROR;
    }
    TSD_RUN_INFO(
        "Get aicpusd[%d] from host[%d] success.", static_cast<int32_t>(srcPid), static_cast<int32_t>(aicpusdPid));
    return TSD_OK;
}

} // namespace tsd
